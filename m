Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EFC6DE74C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDKWbp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKWbo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 18:31:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63146B3;
        Tue, 11 Apr 2023 15:31:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 66D295C011D;
        Tue, 11 Apr 2023 18:31:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Apr 2023 18:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681252298; x=1681338698; bh=/C
        0dh5AAS6LZy77yzp081bIaCHH24Kxd//814piP+ok=; b=TR7c6bvdxVpQpF2pkY
        TWbowemVqK9Yo7wlXyYaRtBte8wy1LG8TvnkKFqR/jwMWs62mlOCO8bKPrYfMx9G
        rX2uLjVUUARIOSjVbkrBk/nrY20ckB/2b+sCGoQ4eddibj5rj7k3AhA8fj5o5Hth
        W7VHyhNJVrfv2atjaqygNij5+luw4b5HiZ9mwj8oT33Li/8SjbGS72InN0PBcxtu
        QZ2VI09D/FJI7mazgwn4fTaWaUhwtNKdSSw619h4KsT4mKwOI0JypTwU+/wm4EDp
        Eqs0K5asWCoojqyltrf2rIHDV5M2R3g6KpG8uRtXIYSsOnhi+Hos84DdWrXofV96
        FgQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681252298; x=1681338698; bh=/C0dh5AAS6LZy
        77yzp081bIaCHH24Kxd//814piP+ok=; b=igb/tx05Wrpw63U/EA2a+j+wNfeCV
        RTTD+5VMfMzZjlLGQ8o3UxhCx4F+XBhAo7tcjyU4v1Wkdy+AkntABcJEbfV1hEz8
        Q1b2XGAp84xJEbgQV17dkbe4MYbuj+oMAsU3rHLOZ6kDculAMX99ECjCyrxCKZgS
        A+B07FLTXl/W2udamdmWR/X/RY/x+t9VQHDCQuZRdEQtuCnjGeN7k726HT+FM45c
        QizG52Ads9QPSDekNFZQyke6ERhNJgLALv8VlTfG7pNMn2lEKdnwAUjjkXwR432O
        LxoSOS/rDiI82Lnqj4ey+3CWxlmEis8xVbBptVvWkAYgFv1zRzhHXl6yg==
X-ME-Sender: <xms:yd81ZEAk8Fw9J87nYQTqG32HxcKyrfP5wBQxN9PArqoqzV3HR46ung>
    <xme:yd81ZGgLx4Wu0iFonX3iTcDJp9z3vNjFxMmtVMhlKXgmrsMZoNpGEBehDQ1FMe11K
    CI2dGpDRAc6ISZLD2Y>
X-ME-Received: <xmr:yd81ZHmjP3Xs4Omsa22QwQts2XWGaYrtR5sh082qsbxNxjOBmJgmPuKM5KFvjGe_XkDjEX-5aaAxKSdzBAyrQ28k6dDPC8Kt-uXcpPb8EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:yd81ZKy8Zv86lEeMqBvuP8aDUaJ_FvR7YL69tpkEhSFzPUF8-_QZlA>
    <xmx:yd81ZJShFF-ya1Ji6m22uGJhjycB2qkc0iNvf43A_YG3NLLE3GA3gQ>
    <xmx:yd81ZFZgStIKMnm6r32t2hibtvexaXqq0i2psBqSMHbOE9o5LeMbZw>
    <xmx:yt81ZEFc8u62lGQmmecvcfOr9N8iWFcrSXvs5UNu6C-FTjNoDw_POQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 18:31:36 -0400 (EDT)
References: <20230406165339.1017597-1-shr@devkernel.io>
 <20230406165339.1017597-3-shr@devkernel.io>
 <ad414e0e-c7be-cc55-6a91-e983b0262503@redhat.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 2/3] mm: add new KSM process and sysfs knobs
Date:   Tue, 11 Apr 2023 15:29:59 -0700
In-reply-to: <ad414e0e-c7be-cc55-6a91-e983b0262503@redhat.com>
Message-ID: <qvqwfs962gqj.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 06.04.23 18:53, Stefan Roesch wrote:
>> This adds the general_profit KSM sysfs knob and the process profit metric
>> and process merge type knobs to ksm_stat.
>> 1) expose general_profit metric
>>     The documentation mentions a general profit metric, however this
>>     metric is not calculated.  In addition the formula depends on the size
>>     of internal structures, which makes it more difficult for an
>>     administrator to make the calculation.  Adding the metric for a better
>>     user experience.
>> 2) document general_profit sysfs knob
>> 3) calculate ksm process profit metric
>>     The ksm documentation mentions the process profit metric and how to
>>     calculate it.  This adds the calculation of the metric.
>> 4) add ksm_merge_type() function
>>     This adds the ksm_merge_type function.  The function returns the
>>     merge type for the process.  For madvise it returns "madvise", for
>>     prctl it returns "process" and otherwise it returns "none".
>
> I'm curious, why exactly is this change required in this context? It might be
> sufficient to observe if the prctl is set for a process. If not, the ksm stats
> can reveal whether KSM is still active for that process -> madvise.
>
> For your use case, I'd assume it's pretty unnecessary to expose that.
>
> If there is no compelling reason, I'd suggest to drop this and limit this patch
> to exposing the general/per-mm profit, which I can understand why it's desirable
> when fine-tuning a workload.
>
>
> [...]
>

In the next version, the ksm_merge_type function() is removed.

>
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>   Documentation/ABI/testing/sysfs-kernel-mm-ksm |  8 +++++
>>   Documentation/admin-guide/mm/ksm.rst          |  8 ++++-
>>   fs/proc/base.c                                |  5 +++
>>   include/linux/ksm.h                           |  5 +++
>>   mm/ksm.c                                      | 32 +++++++++++++++++++
>>   5 files changed, 57 insertions(+), 1 deletion(-)
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> index d244674a9480..7768e90f7a8f 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NUMA nodes.
>>     		When it is set to 0 only pages from the same node are merged,
>>   		otherwise pages from all nodes can be merged together (default).
>> +
>> +What:		/sys/kernel/mm/ksm/general_profit
>> +Date:		January 2023
>
> ^ N
>
Updated in the next version.

>> +KernelVersion:  6.1
>
> ^ Outdated
>
Updated in the next version.

> (kind of weird having to come up with the right numbers before getting it
> merged)
>
> [...]
>
>>   diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 07463ad4a70a..c74450318e05 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -96,6 +96,7 @@
>>   #include <linux/time_namespace.h>
>>   #include <linux/resctrl.h>
>>   #include <linux/cn_proc.h>
>> +#include <linux/ksm.h>
>>   #include <trace/events/oom.h>
>>   #include "internal.h"
>>   #include "fd.h"
>> @@ -3199,6 +3200,7 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
>>     	return 0;
>>   }
>> +
>
> ^ unrelated change
>

Fixed in the next version.

>>   static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>   				struct pid *pid, struct task_struct *task)
>>   {
>> @@ -3208,6 +3210,9 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>   	if (mm) {
>>   		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
>>   		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
>> +		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>> +		seq_printf(m, "ksm_merge_type %s\n", ksm_merge_type(mm));
>> +		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>>   		mmput(mm);
>>   	}
>>   diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index c65455bf124c..4c32f9bca723 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -60,6 +60,11 @@ struct page *ksm_might_need_to_copy(struct page *page,
>>   void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
>>   void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
>>   +#ifdef CONFIG_PROC_FS
>> +long ksm_process_profit(struct mm_struct *);
>> +const char *ksm_merge_type(struct mm_struct *mm);
>> +#endif /* CONFIG_PROC_FS */
>> +
>>   #else  /* !CONFIG_KSM */
>>     static inline int ksm_add_mm(struct mm_struct *mm)
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index ab95ae0f9def..76b10ff840ac 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -3042,6 +3042,25 @@ static void wait_while_offlining(void)
>>   }
>>   #endif /* CONFIG_MEMORY_HOTREMOVE */
>>   +#ifdef CONFIG_PROC_FS
>> +long ksm_process_profit(struct mm_struct *mm)
>> +{
>> +	return (long)mm->ksm_merging_pages * PAGE_SIZE -
>
> Do we really need the cast to long? mm->ksm_merging_pages is defined as
> "unsigned long". Just like "ksm_pages_sharing" below.
>

Removed the cast in the next version.

>> +		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
>> +}
>> +
>> +/* Return merge type name as string. */
>> +const char *ksm_merge_type(struct mm_struct *mm)
>> +{
>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		return "process";
>> +	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
>> +		return "madvise";
>> +	else
>> +		return "none";
>> +}
>> +#endif /* CONFIG_PROC_FS */
>> +
>
> Apart from these nits, LGTM (again, I don't see why the merge type should belong
> into this patch, and why there is a real need to expose it like that).
>
> Acked-by: David Hildenbrand <david@redhat.com>
