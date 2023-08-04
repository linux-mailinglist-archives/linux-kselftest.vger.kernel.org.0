Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35D7704BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjHDPbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 11:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjHDPbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 11:31:25 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA39B9;
        Fri,  4 Aug 2023 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691163053; bh=n62HmNE3akQNdm2oi6fPb5D4Hbn1tXNoatiXKn3ylUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+nzmV/pqyiindTWjfRsKcIM9wGXzo7t2RdAx/B5oHjk65uHK7hSgzjj4UIvmUI/x
         EQdjpYmfRTM07jZ1HObnLTUhFcC2eVuJ5RYG6j9L4Lkx4laet7jVhjCmMVfq8Yhf1v
         xLUSbf8Nwu8+hxfc+Qx4s/AMfFBGLc8BQCiSuqhI=
Date:   Fri, 4 Aug 2023 17:30:52 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v1 1/3] selftests/nolibc: allow report with existing test
 log
Message-ID: <fc316639-10c7-46d3-a897-9553606aba2d@t-8ch.de>
References: <cover.1691073180.git.falcon@tinylab.org>
 <a2879d1ef44fd482a63a8d1a41527289ebcd501b.1691073180.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2879d1ef44fd482a63a8d1a41527289ebcd501b.1691073180.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-03 22:44:47+0800, Zhangjin Wu wrote:
> After the tests finish, it is valuable to report and summarize with
> existing test log.
> 
> This avoid rerun or run the tests again when not necessary.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/testing/selftests/nolibc/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 16cc33db54e3..51fef5e6a152 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -225,6 +225,10 @@ rerun:
>  	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
> +# report with existing test log
> +report:
> +	$(Q)$(REPORT) $(CURDIR)/run.out
> +
>  clean:
>  	$(call QUIET_CLEAN, sysroot)
>  	$(Q)rm -rf sysroot
> -- 
> 2.25.1
> 
