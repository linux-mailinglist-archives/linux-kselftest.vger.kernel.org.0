Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F77C55C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjJKNpt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 09:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjJKNps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 09:45:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34A93;
        Wed, 11 Oct 2023 06:45:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1110CC433C7;
        Wed, 11 Oct 2023 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697031946;
        bh=hhI2du2wdG1ZY2MdeHOhI6DDrpzvKP3LvQCKE392xJg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SaYYuqYFP2AOsilXmF5SGSllEYKKJ4n+/i+eRhcqtHv5dY3vSDG2fbiSqQUKdnRt6
         vp+Hf8EZ6CoUuceUdziJExGqgSMVaE9wXqZHHGiVrYpiacD+fhHyWZXEuP7gS/7tZu
         /cfJTQFm7+wUykCQQDhpDqtESbYSXKkT1W148h5OgxDSd4kKpPE8+O+w8ggFB3HOG3
         QRw/kSFB4n1eBcGBhoXAu08J/D0Z0rlmmDPoaMhP0Cs8ez9jpwGgNlcTKTmtRrzNaU
         SCoM9PF+FlDZAp6oRimfRuOJMFTpNNxAyEF8Ss4V/9umLBx73q9+XYuBQBZOJp7dqv
         6kV3H6GNvOICw==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
Subject: Re: [PATCH v3 0/3] selftests/hid: assorted fixes
Message-Id: <169703194378.3126081.13251971976785038026.b4-ty@kernel.org>
Date:   Wed, 11 Oct 2023 15:45:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 05 Oct 2023 17:55:31 +0200, Benjamin Tissoires wrote:
> And this is the last(?) revision of this series which should now compile
> with or without CONFIG_HID_BPF set.
> 
> I had to do changes because [1] was failing
> 
> Nick, I kept your Tested-by, even if I made small changes in 1/3. Feel
> free to shout if you don't want me to keep it.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.7/selftests), thanks!

[1/3] selftests/hid: ensure we can compile the tests on kernels pre-6.3
      https://git.kernel.org/hid/hid/c/ae7487d112cf
[2/3] selftests/hid: do not manually call headers_install
      https://git.kernel.org/hid/hid/c/89d024a7ba02
[3/3] selftests/hid: force using our compiled libbpf headers
      https://git.kernel.org/hid/hid/c/91939636cac4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

