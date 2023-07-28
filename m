Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA22767677
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 21:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjG1Tlb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 15:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjG1Tla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 15:41:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5268448C;
        Fri, 28 Jul 2023 12:41:02 -0700 (PDT)
X-QQ-mid: bizesmtp87t1690573251tapgz91s
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 03:40:50 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: +ynUkgUhZJkRDS+4P/cO6v+LDp1G8Bn7nTKxUBq3FBEVv78/MGTrl7l43ki+w
        rJx6GQkHC18N/d1moGqxsXFO/p9rDRtH0FRkA9ilKkD1SGjFrYZfxLw40SilyWxLdw9KmZh
        j5H/0CvAKu9fE3WgFKvaBYPyrgoBGAeLXdgz7OVcGqgHsHqdKBYNQlOyDeInHJWakmp7P5g
        b7phuljLlBGyz1koIEANr23RS/5F4blRnMBDAyTNDmBSFpqAYYqlEyfj9bWr1dYbsQA8rUU
        c4loSTtTk9a4PBHeGOuhSUXBdteN1hYGVJLdvU+pSWFs30Hg/wPClKOwFYbSK7kTinQWwjM
        v1m3AP26a3JWcoGoiDGlhNGcQlNhA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2622001603414672531
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when poweroff fails
Date:   Sat, 29 Jul 2023 03:40:50 +0800
Message-Id: <20230728194050.151614-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4b4d792299ca5356f8f5af5fc9a27c687b0e4e38.1690489039.git.falcon@tinylab.org>
References: <4b4d792299ca5356f8f5af5fc9a27c687b0e4e38.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

two trivial updates required in this patch.

[...]
> 
> To tell users the test running progress in time, some critical running
> status are also printed and detected.
> 
[...]
> @@ -229,16 +232,39 @@ kernel: $(KERNEL_CONFIG)
>  # common macros for qemu run/rerun targets
>  QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
>  
> +TIMEOUT_CMD = t=$(QEMU_TIMEOUT); past=0; \
> +	bios_timeout=$$(expr $$t - 7); kernel_timeout=$$(expr $$t - 5); init_timeout=$$(expr $$t - 3); test_timeout=$$(expr $$t - 1);              \
> +	err=""; bios=0; kernel=0; init=0; test=0; poweredoff=0; panic=0;                                                                           \

This 'panic=0;' variable init should be removed, it is not required in
the latest version:

	err=""; bios=0; kernel=0; init=0; test=0; poweredoff=0;                                                                                    \

> +	echo "Running $(KERNEL_IMAGE) on qemu-system-$(QEMU_ARCH)";                                                                                \
> +	while [ $$t -gt 0 ]; do                                                                                                                    \
> +	    sleep 2; t=$$(expr $$t - 2); past=$$(expr $$past + 2);                                                                                 \
> +	    if [ $$bios -eq 0 ] && grep -E "Linux version|Kernel command line|printk: console" "$(RUN_OUT)"; then bios=1; fi;                      \
> +	    if [ $$bios -eq 1 -a $$kernel -eq 0 ] && grep -E "Run .* as init process" "$(RUN_OUT)"; then kernel=1; fi;                             \
> +	    if [ $$kernel -eq 1 -a $$init -eq 0 ] && grep -E "Running test" "$(RUN_OUT)"; then init=1; fi;                                         \
> +	    if [ $$init -eq 1 -a $$test -eq 0 ] && grep -E "Leaving init with final status|Exiting with status" "$(RUN_OUT)"; then test=1; fi;     \

It is better to get the line of 'Total number of errors' instead of
'Exiting with status', the later never trigger in qemu-system run.

	    if [ $$init -eq 1 -a $$test -eq 0 ] && grep -E "Leaving init with final status|Total number of errors" "$(RUN_OUT)"; then test=1; fi;  \

> +	    if [ $$init -eq 1 ] && grep -E "Kernel panic - not syncing: Attempted to kill init" "$(RUN_OUT)"; then err="test"; sleep 1; break; fi; \
> +	    if [ $$test -eq 1 ] && grep -E "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then poweredoff=1; sleep 1; break; fi;         \
> +	    if [ $$past -gt $$bios_timeout -a $$bios -eq 0 ]; then err="bios"; break; fi;                                                          \
> +	    if [ $$past -gt $$kernel_timeout -a $$kernel -eq 0 ]; then err="kernel"; break; fi;                                                    \
> +	    if [ $$past -gt $$init_timeout -a $$init -eq 0 ]; then err="init"; break; fi;                                                          \
> +	    if [ $$past -gt $$test_timeout -a $$test -eq 0 ]; then err="test"; break; fi;                                                          \
> +	done;                                                                                                                                      \
> +	if [ -z "$$err" -a $$poweredoff -eq 0 -a $$panic -eq 0 ]; then err="qemu-system-$(QEMU_ARCH)"; fi;                                         \

And here, we should remove the panic check here too, it is replaced with
'err="test"':

	if [ -z "$$err" -a $$poweredoff -eq 0 ]; then err="qemu-system-$(QEMU_ARCH)"; fi;                                                          \


Thanks,
Zhangjin

> +	if [ -n "$$err" ]; then echo "$$err may timeout, test failed"; tail -10 $(RUN_OUT); else echo "powered off, test finish"; fi;              \
> +	pkill -15 qemu-system-$(QEMU_ARCH) || true
> +
> +TIMEOUT_QEMU_RUN = ($(QEMU_SYSTEM_RUN) > "$(RUN_OUT)" &); $(TIMEOUT_CMD)
> +
>  # run the tests after building the kernel
>  PHONY += $(KERNEL_IMAGE)
>  $(KERNEL_IMAGE): kernel
>  run: $(KERNEL_IMAGE)
> -	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
> +	$(Q)$(TIMEOUT_QEMU_RUN)
>  	$(Q)$(REPORT) "$(RUN_OUT)"
>  
>  # re-run the tests from an existing kernel
>  rerun:
> -	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
> +	$(Q)$(TIMEOUT_QEMU_RUN)
>  	$(Q)$(REPORT) "$(RUN_OUT)"
>  
>  # report with existing test log
> -- 
> 2.25.1
