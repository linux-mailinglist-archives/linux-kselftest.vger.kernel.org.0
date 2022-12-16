Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC864F127
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 19:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiLPSkj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 13:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiLPSkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 13:40:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C094F64C;
        Fri, 16 Dec 2022 10:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC81CCE1DD0;
        Fri, 16 Dec 2022 18:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB02C433EF;
        Fri, 16 Dec 2022 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671215991;
        bh=Owmoceg0LHhYZbdMp5jHogqJClJnU6VIhvIygZhSx5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKfvSh/JQvHoP2ydk6uJTkzsRsQ/NJ8Alqc0iKgaOH5ltjmm6/WOyFpfpgo6xWZn0
         KggObs5mrXy3osHX568HDDzzwbuO7iyEW+yrvTQyZ8pHzrjWGm+t75oI2riyou0JqF
         IHufAKjOU3+8/7tAzX+vSUiKCE4oppqbkllajCn24cp5LTUT4diU9+qgBSah3s4pAb
         VJ3u/I2LaZ4DJf8A8O8W+oCUJV6VmNAL7pW75UbyXojUAkBfxdipC40L+IyDNdtZAT
         2lRwPxx43Qo4MOMpSE1uSt99WhP1bUuSg18o0ux+b1OzMtMJ8ByJYUMXmFTJfQ7yY8
         BrVOoEDTmzpbw==
From:   SeongJae Park <sj@kernel.org>
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Fri, 16 Dec 2022 18:39:49 +0000
Message-Id: <20221216183949.169779-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209160453.3246150-4-jeffxu@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jeff,

> From: Jeff Xu <jeffxu@google.com>
> 
> The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
> set executable bit at creation time (memfd_create).
> 
> When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> (mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> be executable (mode: 0777) after creation.
> 
> when MFD_EXEC flag is set, memfd is created with executable bit
> (mode:0777), this is the same as the old behavior of memfd_create.
> 
> The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
>         MFD_EXEC was set.
> 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
>         MFD_NOEXEC_SEAL was set.
> 2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> 
> The sysctl allows finer control of memfd_create for old-software
> that doesn't set the executable bit, for example, a container with
> vm.memfd_noexec=1 means the old-software will create non-executable
> memfd by default. Also, the value of memfd_noexec is passed to child
> namespace at creation time. For example, if the init namespace has
> vm.memfd_noexec=2, all its children namespaces will be created with 2.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
[...]
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index f4f8cb0435b4..8a98b1af9376 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -23,6 +23,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/signal.h>
>  #include <linux/idr.h>
> +#include "pid_sysctl.h"
>  
>  static DEFINE_MUTEX(pid_caches_mutex);
>  static struct kmem_cache *pid_ns_cachep;
> @@ -110,6 +111,8 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
>  
> +	initialize_memfd_noexec_scope(ns);
> +
>  	return ns;
>  
>  out_free_idr:
> @@ -455,6 +458,8 @@ static __init int pid_namespaces_init(void)
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	register_sysctl_paths(kern_path, pid_ns_ctl_table);
>  #endif
> +
> +	register_pid_ns_sysctl_table_vm();
>  	return 0;
>  }
[...]
>  
> diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
> new file mode 100644
> index 000000000000..90a93161a122
> --- /dev/null
> +++ b/kernel/pid_sysctl.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LINUX_PID_SYSCTL_H
> +#define LINUX_PID_SYSCTL_H
> +
> +#include <linux/pid_namespace.h>
> +
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> +static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns)
[...]
> +static inline void register_pid_ns_sysctl_table_vm(void)
> +{
> +	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
> +}
> +#else
> +static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
> +static inline void register_pid_ns_ctl_table_vm(void) {}
> +#endif
[...]

I found this patch makes build fails whne CONFIG_SYSCTL or CONFIG_MEMFD_CREATE
are not defined, as initialize_memfd_noexec_scope() and
register_pid_ns_sysctl_table_vm() are used from pid_namespace.c without the
configs protection.

I just posted a patch for that:
https://lore.kernel.org/linux-mm/20221216183314.169707-1-sj@kernel.org/

Could you please check?


Thanks,
SJ
