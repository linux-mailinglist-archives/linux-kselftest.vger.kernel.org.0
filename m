Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8E767D05
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjG2IAA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjG2IAA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:00:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F7F3;
        Sat, 29 Jul 2023 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690617596; bh=brSfKfj4DiAAIZHsgpMn9L6z+JmdibU3dW+6RUT9wEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4OuXtQijmEPTGOyghioJkQ4dNB2j0T1qCh0gN0A04z1yu8nCVAEJiohbV9I2y9ce
         zKoUfZE6fcAF/mUbq/by7PNIUF53rkBGxrksa9LWoUkDmxgQoWZkQZDosXihNuY6Yi
         nwxC+2IXIVD2QzY1OyKBy8K8chJxJkecmnlQisVk=
Date:   Sat, 29 Jul 2023 09:59:55 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when
 poweroff fails
Message-ID: <ac2994fd-3131-45d1-aef3-ae8a7e0c3740@t-8ch.de>
References: <cover.1690489039.git.falcon@tinylab.org>
 <4b4d792299ca5356f8f5af5fc9a27c687b0e4e38.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4d792299ca5356f8f5af5fc9a27c687b0e4e38.1690489039.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-28 04:30:31+0800, Zhangjin Wu wrote:
> The kernel of some architectures can not poweroff qemu-system normally,
> especially for tinyconfig.
> 
> Some architectures may have no kernel poweroff support, the others may
> require more kernel config options and therefore slow down the
> tinyconfig build and test. and also, it's very hard (and some even not
> possible) to find out the exact poweroff related kernel config options
> for every architecture.
> 
> Since the low-level poweroff support is heavily kernel & qemu dependent,
> it is not that critical to both nolibc and nolibc-test, let's simply
> ignore the poweroff required kernel config options for tinyconfig (and
> even for defconfig) and quit qemu-system after a specified timeout or
> with an expected system halt or poweroff string (these strings mean our
> reboot() library routine is perfectly ok).
> 
> QEMU_TIMEOUT can be configured for every architecture based on their
> time cost requirement of bios boot + kernel boot + test + poweroff.
> 
> By default, 10 seconds timeout is configured, this is enough for most of
> the architectures, otherwise, customize one by architecture.
> 
> To tell users the test running progress in time, some critical running
> status are also printed and detected.
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/lkml/20230722130248.GK17311@1wt.eu/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 30 +++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index a214745e0f3e..9a57de3b283c 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -105,6 +105,9 @@ QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1
>  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
>  
> +# QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
> +QEMU_TIMEOUT           = $(or $(QEMU_TIMEOUT_$(XARCH)),10)
> +
>  # OUTPUT is only set when run from the main makefile, otherwise
>  # it defaults to this nolibc directory.
>  OUTPUT ?= $(CURDIR)/
> @@ -229,16 +232,39 @@ kernel: $(KERNEL_CONFIG)
>  # common macros for qemu run/rerun targets
>  QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
>  
> +TIMEOUT_CMD = t=$(QEMU_TIMEOUT); past=0; \
> +	bios_timeout=$$(expr $$t - 7); kernel_timeout=$$(expr $$t - 5); init_timeout=$$(expr $$t - 3); test_timeout=$$(expr $$t - 1);              \
> +	err=""; bios=0; kernel=0; init=0; test=0; poweredoff=0; panic=0;                                                                           \
> +	echo "Running $(KERNEL_IMAGE) on qemu-system-$(QEMU_ARCH)";                                                                                \
> +	while [ $$t -gt 0 ]; do                                                                                                                    \
> +	    sleep 2; t=$$(expr $$t - 2); past=$$(expr $$past + 2);                                                                                 \
> +	    if [ $$bios -eq 0 ] && grep -E "Linux version|Kernel command line|printk: console" "$(RUN_OUT)"; then bios=1; fi;                      \
> +	    if [ $$bios -eq 1 -a $$kernel -eq 0 ] && grep -E "Run .* as init process" "$(RUN_OUT)"; then kernel=1; fi;                             \
> +	    if [ $$kernel -eq 1 -a $$init -eq 0 ] && grep -E "Running test" "$(RUN_OUT)"; then init=1; fi;                                         \
> +	    if [ $$init -eq 1 -a $$test -eq 0 ] && grep -E "Leaving init with final status|Exiting with status" "$(RUN_OUT)"; then test=1; fi;     \
> +	    if [ $$init -eq 1 ] && grep -E "Kernel panic - not syncing: Attempted to kill init" "$(RUN_OUT)"; then err="test"; sleep 1; break; fi; \
> +	    if [ $$test -eq 1 ] && grep -E "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then poweredoff=1; sleep 1; break; fi;         \
> +	    if [ $$past -gt $$bios_timeout -a $$bios -eq 0 ]; then err="bios"; break; fi;                                                          \
> +	    if [ $$past -gt $$kernel_timeout -a $$kernel -eq 0 ]; then err="kernel"; break; fi;                                                    \
> +	    if [ $$past -gt $$init_timeout -a $$init -eq 0 ]; then err="init"; break; fi;                                                          \
> +	    if [ $$past -gt $$test_timeout -a $$test -eq 0 ]; then err="test"; break; fi;                                                          \
> +	done;                                                                                                                                      \
> +	if [ -z "$$err" -a $$poweredoff -eq 0 -a $$panic -eq 0 ]; then err="qemu-system-$(QEMU_ARCH)"; fi;                                         \
> +	if [ -n "$$err" ]; then echo "$$err may timeout, test failed"; tail -10 $(RUN_OUT); else echo "powered off, test finish"; fi;              \
> +	pkill -15 qemu-system-$(QEMU_ARCH) || true
> +
> +TIMEOUT_QEMU_RUN = ($(QEMU_SYSTEM_RUN) > "$(RUN_OUT)" &); $(TIMEOUT_CMD)
> +

This feels fairly hacky.

Before we complicated nolibc-test to handle the no-procfs case to save a
few seconds building the kernel and now we have fairly big timeouts.
And a statemachine that relies on the specific strings emitted by the
testsuite.

I would like to get back to something more deterministic and obvious,
even at the cost of some time spent compiling the test kernels.
(saying this as somebody developing on a 2016 ultrabook)

"Since the low-level poweroff support is heavily kernel & qemu dependent"

The kernel we can control.

How common are qemus with that are missing poweroff support? 
As this worked before I guess the only architecture where this could
pose a problem would be ppc.


An alternative I would like to put up for discussion:

qemu could provide a watchdog device that is pinged by nolibc-test for
each testcase.
After nolibc-test is done and didn't poweroff properly the watchdog will
reset the machine. ( -watchog-action poweroff ).

The disadvantages are that we would need to add watchdog drivers to the
kernels and figure out the correct watchdog devices and drivers for each arch.

It seems virtio-watchdog is not yet usable.

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
> 
