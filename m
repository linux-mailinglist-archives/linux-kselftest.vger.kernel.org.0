Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F186A0C18
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjBWOqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 09:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjBWOqP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 09:46:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B85034C23;
        Thu, 23 Feb 2023 06:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B3C56172A;
        Thu, 23 Feb 2023 14:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C78C433EF;
        Thu, 23 Feb 2023 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677163571;
        bh=A7ZaP9yIleoXryrA51MEQFdI9ZE/IxgMZO1YwAt/rGw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bG+a1mGCVpa8t4i0p7gVdNtX5XFsdZY252PMObHVb3VlDHtxfRB7TjTaUIaKeZ04F
         0EFfBtKk39l4gTNlskkTn89rEgQ7iHMaO528XRkuprjENDB2CXz1vDzc1dIFQsfJ/1
         w3OHRuy5gERgsvuKYGo4GbFvq4/YULUGD9tbLyGcab5jwbChurQyZleG3EJ31/6rjr
         cU7Lf2vugIqOsCH12lhur2K8b6ctc/Oyb5CBbwmM04ppHm2z/sEbtkKYKnATIu8zUR
         DiJeK5favS3LoX2Jv+Lc4bSqjG9pDjkhZaE2RHU0xznxZDblRmsDn7PxHX6O2rqwEF
         JuuNg0SBkBZLA==
Date:   Thu, 23 Feb 2023 15:46:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: hid: fix hid_bpf not set in config
In-Reply-To: <20230223-fix_hid_bpf_kconfig-v1-1-71b213bd8e2b@redhat.com>
Message-ID: <nycvar.YFH.7.76.2302231545410.1142@cbobk.fhfr.pm>
References: <20230223-fix_hid_bpf_kconfig-v1-1-71b213bd8e2b@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 23 Feb 2023, Benjamin Tissoires wrote:

> Now that CONFIG_HID_BPF is not automatically implied by HID, we need
> to set it properly in the selftests config.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to hid.git#for-6.3/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

