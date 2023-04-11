Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B796DD657
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDKJMI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDKJLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 05:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187DF2728
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681204224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4m+6kmRETatL5vM33br0ArKsEnyNrwupCB642F9Beus=;
        b=FwN8p830x9Y+oHDHjEttJ9zMtP025Cw4uMvcRuKFKHfF+uSafZqCSE8ppQqVSmrvJAVYYT
        TSd+yfc4ERj++S+2vGJQFUrzBDD8Ekm/nduJnUqHBQ1fKg9hecpMv1SuLz7GEGTqb9Zs+v
        RYegW/iizj/yJ8Ba5VIjIq0szrb2LRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-TCf0n08pOCmLdXqBglFm-g-1; Tue, 11 Apr 2023 05:10:21 -0400
X-MC-Unique: TCf0n08pOCmLdXqBglFm-g-1
Received: by mail-wm1-f71.google.com with SMTP id g6-20020a05600c310600b003ee69edec16so5088258wmo.5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 02:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681204220; x=1683796220;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m+6kmRETatL5vM33br0ArKsEnyNrwupCB642F9Beus=;
        b=ebbNeeg+wFavPBUGhwOpIMJEQ7UwEwDTTYzV6lwCDGtGeQXK3ZNwmZlo/d39h8LydT
         0/w77821xoud45YdokICkXz+K8piQAJw/oTctMKxMqwuSQWvipQpf50KslIaznTcbEwE
         fFC+BuC+V4kMpdCMHsqi8dCXt1Tm3vydPUUaKPcxW7bb0m4mhBANPTkQpRHUl0J5WdCi
         WyD5XAp+GS/PUSI/cpuFpRn1w4+D/bVeDoic0t+9vN2KOOCpFcQpcDcYBcjX67kbsWUw
         OcCcI1djcdH8ejHYY1tIU9su8S2MGl68+BbfDxMTKJ5s5V4nPCZEfsJv2Ns9IAy+SrqW
         BEtw==
X-Gm-Message-State: AAQBX9coDkZL7UTM24b3mKBNIeRHmT9mrxEGEuNJenhXhfmTHliLBU1n
        +aWCLBRXUox894SuaVZ34WCr9PJ7O9OJtT2j9j+wEDfuth7NlEI9k3u4NhZfjqUoXAYFuOwaITc
        1ni9hN7OsQm2+6R2GDhk8eT5fcUJj
X-Received: by 2002:a5d:63d2:0:b0:2f1:e954:6876 with SMTP id c18-20020a5d63d2000000b002f1e9546876mr3880512wrw.42.1681204219854;
        Tue, 11 Apr 2023 02:10:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350YS9JdXV7tbiL94xQAZP+E8bK9EOJlCxuA9lOrAjMCRprlqq2ZRFLv2nARv1+7mExPVIDLatQ==
X-Received: by 2002:a5d:63d2:0:b0:2f1:e954:6876 with SMTP id c18-20020a5d63d2000000b002f1e9546876mr3880481wrw.42.1681204219412;
        Tue, 11 Apr 2023 02:10:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1300:6f08:1748:eba7:b2a9? (p200300cbc70613006f081748eba7b2a9.dip0.t-ipconnect.de. [2003:cb:c706:1300:6f08:1748:eba7:b2a9])
        by smtp.gmail.com with ESMTPSA id d4-20020a056000114400b002efb3566b0asm10554093wrx.52.2023.04.11.02.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 02:10:18 -0700 (PDT)
Message-ID: <ad414e0e-c7be-cc55-6a91-e983b0262503@redhat.com>
Date:   Tue, 11 Apr 2023 11:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230406165339.1017597-1-shr@devkernel.io>
 <20230406165339.1017597-3-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 2/3] mm: add new KSM process and sysfs knobs
In-Reply-To: <20230406165339.1017597-3-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.04.23 18:53, Stefan Roesch wrote:
> This adds the general_profit KSM sysfs knob and the process profit metric
> and process merge type knobs to ksm_stat.
> 
> 1) expose general_profit metric
> 
>     The documentation mentions a general profit metric, however this
>     metric is not calculated.  In addition the formula depends on the size
>     of internal structures, which makes it more difficult for an
>     administrator to make the calculation.  Adding the metric for a better
>     user experience.
> 
> 2) document general_profit sysfs knob
> 
> 3) calculate ksm process profit metric
> 
>     The ksm documentation mentions the process profit metric and how to
>     calculate it.  This adds the calculation of the metric.
> 
> 4) add ksm_merge_type() function
> 
>     This adds the ksm_merge_type function.  The function returns the
>     merge type for the process.  For madvise it returns "madvise", for
>     prctl it returns "process" and otherwise it returns "none".

I'm curious, why exactly is this change required in this context? It 
might be sufficient to observe if the prctl is set for a process. If 
not, the ksm stats can reveal whether KSM is still active for that 
process -> madvise.

For your use case, I'd assume it's pretty unnecessary to expose that.

If there is no compelling reason, I'd suggest to drop this and limit 
this patch to exposing the general/per-mm profit, which I can understand 
why it's desirable when fine-tuning a workload.


[...]

> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>   Documentation/ABI/testing/sysfs-kernel-mm-ksm |  8 +++++
>   Documentation/admin-guide/mm/ksm.rst          |  8 ++++-
>   fs/proc/base.c                                |  5 +++
>   include/linux/ksm.h                           |  5 +++
>   mm/ksm.c                                      | 32 +++++++++++++++++++
>   5 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> index d244674a9480..7768e90f7a8f 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NUMA nodes.
>   
>   		When it is set to 0 only pages from the same node are merged,
>   		otherwise pages from all nodes can be merged together (default).
> +
> +What:		/sys/kernel/mm/ksm/general_profit
> +Date:		January 2023

^ No

> +KernelVersion:  6.1

^ Outdated

(kind of weird having to come up with the right numbers before getting 
it merged)

[...]

>   
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 07463ad4a70a..c74450318e05 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -96,6 +96,7 @@
>   #include <linux/time_namespace.h>
>   #include <linux/resctrl.h>
>   #include <linux/cn_proc.h>
> +#include <linux/ksm.h>
>   #include <trace/events/oom.h>
>   #include "internal.h"
>   #include "fd.h"
> @@ -3199,6 +3200,7 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
>   
>   	return 0;
>   }
> +

^ unrelated change

>   static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   				struct pid *pid, struct task_struct *task)
>   {
> @@ -3208,6 +3210,9 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   	if (mm) {
>   		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
>   		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
> +		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
> +		seq_printf(m, "ksm_merge_type %s\n", ksm_merge_type(mm));
> +		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>   		mmput(mm);
>   	}
>   
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index c65455bf124c..4c32f9bca723 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -60,6 +60,11 @@ struct page *ksm_might_need_to_copy(struct page *page,
>   void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
>   void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
>   
> +#ifdef CONFIG_PROC_FS
> +long ksm_process_profit(struct mm_struct *);
> +const char *ksm_merge_type(struct mm_struct *mm);
> +#endif /* CONFIG_PROC_FS */
> +
>   #else  /* !CONFIG_KSM */
>   
>   static inline int ksm_add_mm(struct mm_struct *mm)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index ab95ae0f9def..76b10ff840ac 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3042,6 +3042,25 @@ static void wait_while_offlining(void)
>   }
>   #endif /* CONFIG_MEMORY_HOTREMOVE */
>   
> +#ifdef CONFIG_PROC_FS
> +long ksm_process_profit(struct mm_struct *mm)
> +{
> +	return (long)mm->ksm_merging_pages * PAGE_SIZE -

Do we really need the cast to long? mm->ksm_merging_pages is defined as 
"unsigned long". Just like "ksm_pages_sharing" below.

> +		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
> +}
> +
> +/* Return merge type name as string. */
> +const char *ksm_merge_type(struct mm_struct *mm)
> +{
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +		return "process";
> +	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +		return "madvise";
> +	else
> +		return "none";
> +}
> +#endif /* CONFIG_PROC_FS */
> +

Apart from these nits, LGTM (again, I don't see why the merge type 
should belong into this patch, and why there is a real need to expose it 
like that).

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

