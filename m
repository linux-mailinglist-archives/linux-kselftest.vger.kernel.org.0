Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4061E1D3
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Nov 2022 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiKFL1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Nov 2022 06:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiKFL1U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Nov 2022 06:27:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C25F60;
        Sun,  6 Nov 2022 03:27:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D49960C41;
        Sun,  6 Nov 2022 11:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5351BC433D6;
        Sun,  6 Nov 2022 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667734038;
        bh=TkHgIkBcH71TK5yfForSJw+5lXMejJ9dhQTtpK8GAnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aitp4QYdYt454gND3ks/FDrd8SJrNQ2NpV74b0nWoYBOvrVDPNcnoB/L48uI4qNs0
         qXnAjqMRI+O2tFOWgkm/cEqpoVMNFpTOqwN0IDbm0gus99/68FEDTfjOvtDzRQKcig
         lrS3o9ujeuKENM73EEfc6OLm1oC5G0J55/Nvp1CE=
Date:   Sun, 6 Nov 2022 12:27:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y2eaEG5IX+tk4wuA@kroah.com>
References: <Y1kwa0ZLI9xbEaHx@ziqianlu-desk1>
 <Y2eKO48Tv+UD0IpV@ziqianlu-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2eKO48Tv+UD0IpV@ziqianlu-desk1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 06, 2022 at 06:19:39PM +0800, Aaron Lu wrote:
> To capture potential programming errors like mistakenly setting Global
> bit on kernel page table entries, a selftest for meltdown is added.
> 
> This selftest is based on https://github.com/IAIK/meltdown. What this
> test does is to firstly set a predefined string at a random user address
> and then with pagemap, get the physical address of this string. Finally,
> try to fetch the data using kernel's directmap address for this physical
> address to see if user space can use kernel's page table.

As this is based on someone else's code, what happened to the proper
credit for them as the author and copyright owner?

> Per my tests, this test works well on CPUs that have TSX support. For
> this reason, this selftest only works on CPUs that supports TSX.
> 
> This test requires the knowledge of direct map base. IAIK used the
> following two methods to get direct map base:
> 1 through a kernel module to show phys_to_virt(0);
> 2 by exploiting the same HW vulnerability to guess the base.
> Method 1 makes running this selftest complex while method 2 is not
> reliable and I do not want to use a possibly wrong value to run this
> test. Suggestions are welcome.
> 
> Tested on both x86_64 and i386_pae VMs on a host with i7-7700K cpu,
> success rate is about 50% when nopti kernel cmdline is used.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
> v2:
> - Added [SKIP], [INFO] prefix to some prints;
> - Do not run 32bits test on 64bits host since it doesn't make sense to
>   do that;
> - Minor comment update.
> 
>  tools/testing/selftests/x86/Makefile   |   2 +-
>  tools/testing/selftests/x86/meltdown.c | 418 +++++++++++++++++++++++++
>  2 files changed, 419 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/meltdown.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 0388c4d60af0..36f99c360a56 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl ioperm \
>  			test_vsyscall mov_ss_trap \
> -			syscall_arg_fault fsgsbase_restore sigaltstack
> +			syscall_arg_fault fsgsbase_restore sigaltstack meltdown
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
> diff --git a/tools/testing/selftests/x86/meltdown.c b/tools/testing/selftests/x86/meltdown.c
> new file mode 100644
> index 000000000000..8c0c1db49096
> --- /dev/null
> +++ b/tools/testing/selftests/x86/meltdown.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0-only

That's nice but that does NOT reflect the license of the code below, as
you state in the comments.

You might want to get an Intel lawyer to look this over and give you
advice on how to properly tag this license.

> +/*
> + * This selftest is based on code from https://github.com/IAIK/meltdown
> + * and can be used to check if user space can read data through kernel
> + * page table entries.
> + *
> + * Note for i386 test: due to kernel prefer to use high memory for user
> + * programs, it is necessary to restrict the available memory under that
> + * of low memory size(around ~896MiB) so that the memory hosting "string"
> + * in main() is directly mapped.
> + *
> + * Note for both x86_64 and i386 test: the hardware race window can not be
> + * exploited 100% each time so a single run of the test on a vulnerable system
> + * may not FAIL. My tests on a i7-7700K cpu have a success rate about 50%.
> + *
> + * The original copyright and license information are shown below:
> + *
> + * Copyright (c) 2018 meltdown

I don't see that copyright in the original github repo, are you sure
about that?  I see individual developers contributing there instead.
Please keep authorship information when you know it.

thanks,

greg k-h
