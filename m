Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE3783C85
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjHVJKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHVJKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 05:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384A1BE;
        Tue, 22 Aug 2023 02:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6B2E64FE4;
        Tue, 22 Aug 2023 09:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B12BC433C7;
        Tue, 22 Aug 2023 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692695412;
        bh=pQisISmZ66AdEx39jJ4009uh0Yx/8HETEG0JPihLCHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dt1q16xZ4wVawYqxKyc7pTbYu+xIoHKLpdt4WziTYiykP4mBCSsx9VyKV3nGdWZuB
         CGlsfHp0LveeO9NIsm2e6txPBhrMJk1AjqMm2owxcsfgIRV8U6Tt291oP3dqGDBQwG
         gDHLPYuO5I1KGNzPSmFaAQ13Ck4sdojjeTz3R2DLhRG6otJRWx1AbClFee5WLwQArS
         PEQ+W/rcU+hY/C9pH9HW980wqKbHfsBj2syDGyGfJ4KcbpYfg7B6yf6QcxIUaEjVGF
         QYWB8QtIcGfFThWJC6mqnrDF7sLKwARR06oIWqrbVYOF+L5uhBGCzY8GFgI7AqFe2D
         prG6ZSWsJIrdA==
Date:   Tue, 22 Aug 2023 11:10:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
Message-ID: <20230822-seenotrettung-bungalow-a4ea576f6f85@brauner>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 06:40:59PM +1000, Aleksa Sarai wrote:
> In order to incentivise userspace to switch to passing MFD_EXEC and
> MFD_NOEXEC_SEAL, we need to provide a warning on each attempt to call
> memfd_create() without the new flags. pr_warn_once() is not useful
> because on most systems the one warning is burned up during the boot
> process (on my system, systemd does this within the first second of
> boot) and thus userspace will in practice never see the warnings to push
> them to switch to the new flags.
> 
> The original patchset[1] used pr_warn_ratelimited(), however there were
> concerns about the degree of spam in the kernel log[2,3]. The resulting
> inability to detect every case was flagged as an issue at the time[4].
> 
> While we could come up with an alternative rate-limiting scheme such as
> only outputting the message if vm.memfd_noexec has been modified, or
> only outputting the message once for a given task, these alternatives
> have downsides that don't make sense given how low-stakes a single
> kernel warning message is. Switching to pr_info_ratelimited() instead
> should be fine -- it's possible some monitoring tool will be unhappy
> with a stream of warning-level messages but there's already plenty of
> info-level message spam in dmesg.
> 
> [1]: https://lore.kernel.org/20221215001205.51969-4-jeffxu@google.com/
> [2]: https://lore.kernel.org/202212161233.85C9783FB@keescook/
> [3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
> [4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org/
> 
> Cc: stable@vger.kernel.org # v6.3+
> Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
