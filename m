Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD51E7B22AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjI1Qnr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjI1Qnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 12:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD661B6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695919381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1o7xXnVfbwvPCElX1CmpaaAz+Yq3UYakUDqHLuD5rI=;
        b=GYYuCaatV9flH9JyTU+GKeWL9G8AlaaDgYoEU3bee2E5fXB6jMdUknQMrOhkazQ69Mcqa7
        6fx9N+xn4/wQSCr1TrZzQqlCBizIU62C9sh5h8Kux6VhB1VsW5/G+pc8FIhQTmMRL6T/xA
        GRvMRK3C6OwIN0wt20+ZH9r/Pm+0Mn0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-WqyC_IslOpiVAMC_hMitlg-1; Thu, 28 Sep 2023 12:42:58 -0400
X-MC-Unique: WqyC_IslOpiVAMC_hMitlg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6557c921deeso212235156d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 09:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695919377; x=1696524177;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1o7xXnVfbwvPCElX1CmpaaAz+Yq3UYakUDqHLuD5rI=;
        b=YB+h5vXEpJ6lRc3pd9pXzdJqi2xRa1rEYcoWD71TGS+enJNNsi1eqcqCngy95pVIsL
         9ztglZXLAR5Pd0eZAIOF3RLztpGfiKE56zSZsAvdUUw/QcP4911fEz8DxcgGg16wUIbr
         0OrSb2wSr2py0cUT23KJoztlLfsMx+nppzQJz+kgedquhGn/SuZUwUcEvy4MonrpV8ce
         jQiUmKhLQN5sJ+cGWLowd4TPvEGuLBv+82QU3R8NNnh5Y/rYus25k1MEEl81VQrgrilw
         BtENZHL14Lupo7gxDIjZjv95xFtDmzYoPKkmiHHn6vECaC4i5yxeZORr/OKcMivVhC/z
         nSkw==
X-Gm-Message-State: AOJu0YxPloPTMP1ZXvo+uEF1xj4ODX3ldPc6ujD6IXXvc3KskYIqvPxE
        sE8dngHPnUsSnVTceq6DJ+fDG7AfQKI9m+YxLtiLEpw/A0X8vdOF1eGeOzybitl4cGNg+kMv+v4
        fxjtCOuNUZYzLEgE/BFMtQmx8L2k=
X-Received: by 2002:a0c:b25e:0:b0:65b:26d4:7fc2 with SMTP id k30-20020a0cb25e000000b0065b26d47fc2mr1409701qve.2.1695919376991;
        Thu, 28 Sep 2023 09:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLtUZQQC5uiq2UCX9cP17evsFKTs3OYesHYvDXxlcpphBELvnYYf9OjBLBS8OGLZq+KkMSWw==
X-Received: by 2002:a0c:b25e:0:b0:65b:26d4:7fc2 with SMTP id k30-20020a0cb25e000000b0065b26d47fc2mr1409684qve.2.1695919376649;
        Thu, 28 Sep 2023 09:42:56 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id em17-20020ad44f91000000b0065af366bdc1sm4980017qvb.103.2023.09.28.09.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 09:42:55 -0700 (PDT)
Message-ID: <49dec96d-b02c-fa6e-1d2e-78d9c320f39c@redhat.com>
Date:   Thu, 28 Sep 2023 18:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND 3/3] kunit: Init and run test suites in the right
 state
To:     Jinjie Ruan <ruanjinjie@huawei.com>
References: <20230928091446.1209703-1-ruanjinjie@huawei.com>
 <20230928091446.1209703-4-ruanjinjie@huawei.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
Cc:     davidgow@google.com, brendan.higgins@linux.dev, rmoar@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
In-Reply-To: <20230928091446.1209703-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023-09-28 11:14, Jinjie Ruan wrote:
> As Marco pointed out, commit 2810c1e99867 ("kunit: Fix wild-memory-access
> bug in kunit_free_suite_set()") causes test suites to run while the test
> module is still in MODULE_STATE_COMING. In that state, the module
> is not fully initialized, lacking sysfs, module_memory, args, init
> function which causes null-ptr-deref of using fake devices below.
> 
> Since load_module() notify MODULE_STATE_COMING in prepare_coming_module(),
> and then init sysfs and args etc. in parse_args() and mod_sysfs_setup(),
> after that it notify MODULE_STATE_LIVE in do_init_module(), and fake driver
> in the test suits depend on them. So the test suits should be executed when
> notify MODULE_STATE_LIVE.
> 
> But the kunit_free_suite_set() in kunit_module_exit() depends on the
> success of kunit_filter_suites() in kunit_module_init(). The best practice
> is to alloc and init resource when notify MODULE_STATE_COMING and free them
> when notify MODULE_STATE_GOING. So split the kunit_module_exec() from
> kunit_module_init() to run test suits when MODULE_STATE_LIVE, call
> kunit_filter_suites() and allocate memory in kunit_module_init() and call
> kunit_free_suite_set() in kunit_module_exit() to free the memory.
> 
> So if load_module() succeeds and notify module state as below, it calls
> kunit_module_init(), kunit_module_exec() and kunit_module_exit(), which
> will work ok. The mod->state state machine when load_module() succeeds:
> 
> 			      kunit_filter_suites()	kunit_module_exec()
>     MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_LIVE
>              ^                                              |
>              |                                              |
>              +---------------- MODULE_STATE_GOING <---------+
> 			      kunit_free_suite_set()
> 
> If load_module() fails and notify module state as below, it call
> kunit_module_init() and kunit_module_exit(), which will also work ok.
> The mod->state state machine when load_module() fails at mod_sysfs_setup():
> 
> 			      kunit_filter_suites()	kunit_free_suite_set()
>     MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_GOING
>             ^                                               |
>             |                                               |
>             +-----------------------------------------------+
> 
>  general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
>  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>  CPU: 1 PID: 1868 Comm: modprobe Tainted: G        W        N 6.6.0-rc3+ #61
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  RIP: 0010:kobject_namespace+0x71/0x150
>  Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
>  RSP: 0018:ffff88810f797288 EFLAGS: 00010206
>  RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>  RDX: 0000000000000003 RSI: ffffffff847b4900 RDI: 0000000000000018
>  RBP: ffff88810ba08940 R08: 0000000000000001 R09: ffffed1021ef2e0f
>  R10: ffff88810f79707f R11: 746e756f63666572 R12: ffffffffa0241990
>  R13: ffff88810ba08958 R14: ffff88810ba08968 R15: ffffffff84ac6c20
>  FS:  00007ff9f2186540(0000) GS:ffff888119c80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fff73a2cff8 CR3: 000000010b77b002 CR4: 0000000000770ee0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? die_addr+0x3d/0xa0
>   ? exc_general_protection+0x144/0x220
>   ? asm_exc_general_protection+0x22/0x30
>   ? kobject_namespace+0x71/0x150
>   kobject_add_internal+0x267/0x870
>   kobject_add+0x120/0x1f0
>   ? kset_create_and_add+0x160/0x160
>   ? __kmem_cache_alloc_node+0x1d2/0x350
>   ? _raw_spin_lock+0x87/0xe0
>   ? kobject_create_and_add+0x3c/0xb0
>   kobject_create_and_add+0x68/0xb0
>   module_add_driver+0x260/0x350
>   bus_add_driver+0x2c9/0x580
>   driver_register+0x133/0x460
>   kunit_run_tests+0xdb/0xef0
>   ? _prb_read_valid+0x3e3/0x550
>   ? _raw_spin_lock+0x87/0xe0
>   ? _raw_spin_lock_bh+0xe0/0xe0
>   ? __send_ipi_mask+0x1ba/0x450
>   ? __pte_offset_map+0x19/0x1f0
>   ? __pte_offset_map_lock+0xd6/0x1b0
>   ? __kunit_test_suites_exit+0x30/0x30
>   ? kvm_smp_send_call_func_ipi+0x68/0xc0
>   ? do_sync_core+0x22/0x30
>   ? smp_call_function_many_cond+0x1be/0xcf0
>   ? __text_poke+0x890/0x890
>   ? __text_poke+0x890/0x890
>   ? on_each_cpu_cond_mask+0x46/0x70
>   ? text_poke_bp_batch+0x413/0x570
>   ? do_sync_core+0x30/0x30
>   ? __jump_label_patch+0x34c/0x350
>   ? mutex_unlock+0x80/0xd0
>   ? __mutex_unlock_slowpath.constprop.0+0x2a0/0x2a0
>   __kunit_test_suites_init+0xc4/0x120
>   kunit_module_notify+0x36c/0x3b0
>   ? __kunit_test_suites_init+0x120/0x120
>   ? preempt_count_add+0x79/0x150
>   notifier_call_chain+0xbf/0x280
>   ? kasan_quarantine_put+0x21/0x1a0
>   blocking_notifier_call_chain_robust+0xbb/0x140
>   ? notifier_call_chain+0x280/0x280
>   ? 0xffffffffa0238000
>   load_module+0x4af0/0x67d0
>   ? module_frob_arch_sections+0x20/0x20
>   ? rwsem_down_write_slowpath+0x11a0/0x11a0
>   ? kernel_read_file+0x3ca/0x510
>   ? __x64_sys_fspick+0x2a0/0x2a0
>   ? init_module_from_file+0xd2/0x130
>   init_module_from_file+0xd2/0x130
>   ? __ia32_sys_init_module+0xa0/0xa0
>   ? userfaultfd_unmap_prep+0x3d0/0x3d0
>   ? _raw_spin_lock_bh+0xe0/0xe0
>   idempotent_init_module+0x339/0x610
>   ? init_module_from_file+0x130/0x130
>   ? __fget_light+0x57/0x500
>   __x64_sys_finit_module+0xba/0x130
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
> Reported-by: Marco Pagani <marpagan@redhat.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  lib/kunit/test.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 145f70219f46..8fac4783c676 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -739,7 +739,6 @@ static int kunit_module_init(struct module *mod)
>  	struct kunit_suite_set suite_set = {
>  		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
>  	};
> -	const char *action = kunit_action();
>  	int err = 0;
>  
>  	suite_set = kunit_filter_suites(&suite_set,
> @@ -752,16 +751,28 @@ static int kunit_module_init(struct module *mod)
>  	mod->kunit_suites = (struct kunit_suite **)suite_set.start;
>  	mod->num_kunit_suites = suite_set.end - suite_set.start;
>  
> -	if (!action)
> +	return err;
> +}
> +
> +static void kunit_module_exec(struct module *mod)
> +{
> +	struct kunit_suite_set suite_set = {
> +		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
> +	};
> +	const char *action = kunit_action();
> +
> +	if (!action) {
>  		kunit_exec_run_tests(&suite_set, false);
> +
> +		__kunit_test_suites_exit(mod->kunit_suites,
> +					 mod->num_kunit_suites);
> +	}


I don't think destroying debugfs right after running the tests is advisable.

The reason why I sent an RFC is to leave room for a discussion on which is
the best way to solve the issue. I think it would be better to have a
discussion before rushing patches.

Thanks,
Marco


>  	else if (!strcmp(action, "list"))
>  		kunit_exec_list_tests(&suite_set, false);
>  	else if (!strcmp(action, "list_attr"))
>  		kunit_exec_list_tests(&suite_set, true);
>  	else
>  		pr_err("kunit: unknown action '%s'\n", action);
> -
> -	return err;
>  }
>  
>  static void kunit_module_exit(struct module *mod)
> @@ -769,11 +780,6 @@ static void kunit_module_exit(struct module *mod)
>  	struct kunit_suite_set suite_set = {
>  		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
>  	};
> -	const char *action = kunit_action();
> -
> -	if (!action)
> -		__kunit_test_suites_exit(mod->kunit_suites,
> -					 mod->num_kunit_suites);
>  
>  	kunit_free_suite_set(suite_set);
>  }
> @@ -789,6 +795,7 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>  		ret = kunit_module_init(mod);
>  		break;
>  	case MODULE_STATE_LIVE:
> +		kunit_module_exec(mod);
>  		break;
>  	case MODULE_STATE_GOING:
>  		kunit_module_exit(mod);

