Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57286DFE62
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 21:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDLTJK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDLTJJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 15:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BAF30E0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681326505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2b0MyEWLjA5++ZOA33AjiWd65RqaG2EUAPS/RL7lf9A=;
        b=KhVCKYhtcpOGLtPDBMY2f99blBP78NCp2/lLOBxcnG2H3r+HmC2HtnEPAeZeH+d542sF2E
        B8t52Ay1anOi1qBEXMBb7YFlacLPmmV7PgChZfPA+zlwBhTfnF4AYd9q3vZTA3uzh/giBm
        FybEI6iAgqk9IK3rFPZTIbzdrJHV/OQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-kmzCJKbmO2Sm37RH0NikNw-1; Wed, 12 Apr 2023 15:08:24 -0400
X-MC-Unique: kmzCJKbmO2Sm37RH0NikNw-1
Received: by mail-ej1-f70.google.com with SMTP id c25-20020a17090603d900b0094a5a6c90c5so4177920eja.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 12:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681326503; x=1683918503;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2b0MyEWLjA5++ZOA33AjiWd65RqaG2EUAPS/RL7lf9A=;
        b=Aj1Ogf++rAsIg8jW+7TwHgOntHTIRPOOp/QQ/PxtRYJGpuEWUm50/ugZNBZiuOXhkh
         fNKpnktixxNPbnUGAR1HabeSh6Oyd5c2pBQzAWxg8NJ4jPpjYNWgd8p1WqlLgNEq7+sp
         S9+Tw28deRp1njkwgLPEHA3Q1WvdNigXM22K+++YPzg9a7UKdrO367C2lpqQLlqpgIXG
         l1HPtU6jIjcKDTwbTKq0vStZ9UbCzJiMUGgavbu5stdr+B4Xr2XGnWhiJD9jvAzsx5WY
         FPaZZ6GcdQvdhL9hGoqr7QyRhxoD6pAnrhGSoxqJfpyc3MqH7l5o047z1tNUbNgm51Ox
         K1ag==
X-Gm-Message-State: AAQBX9fj7d0clZ1qvqEUCynJD5wzieh6SWuqlNdFAsyGR3MfjAC96tu0
        TVsJ/49g8TLbvgL0NEcw0ce7hfEYXa2mQKwJuvWjBJsCgsxofvRexdenHOWwcSuLjKsA1ItSi+X
        +n+wU4ZY2+CcM0iBsQ3z2cUeLKjRi
X-Received: by 2002:a17:906:6ada:b0:93e:908d:cfe2 with SMTP id q26-20020a1709066ada00b0093e908dcfe2mr36270ejs.0.1681326502807;
        Wed, 12 Apr 2023 12:08:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350bF9rF/goBdWIOKa5Ss+n9nteDFVob7gmUBb7kFvjlPXQwKn9B7N0Bkkx3ANUU4VzfYdZBu7g==
X-Received: by 2002:a17:906:6ada:b0:93e:908d:cfe2 with SMTP id q26-20020a1709066ada00b0093e908dcfe2mr36249ejs.0.1681326502441;
        Wed, 12 Apr 2023 12:08:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id kq9-20020a170906abc900b0094a5edc82b3sm4326615ejb.162.2023.04.12.12.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:08:22 -0700 (PDT)
Message-ID: <33f18dde-8ff8-5ec6-9bee-3c1900c2bd83@redhat.com>
Date:   Wed, 12 Apr 2023 21:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-2-shr@devkernel.io>
 <b3bac995-0d87-a4d7-b261-9cbe3aa901af@redhat.com>
 <qvqw1qkpavxn.fsf@devbig1114.prn1.facebook.com>
 <30b948fe-7983-39dd-9565-9f92ffd9101b@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 1/3] mm: add new api to enable ksm per process
In-Reply-To: <30b948fe-7983-39dd-9565-9f92ffd9101b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12.04.23 20:41, David Hildenbrand wrote:
> [...]
>> That will work.
>>> work? IOW, not exporting ksm_add_mm() and not passing a flag to __ksm_enter() --
>>> it would simply set MMF_VM_MERGEABLE ?
>>>
>>
>> ksm_add_mm() is also used in prctl (kernel/sys.c). Do you want to make a
>> similar change there?
> 
> Yes.
> 
>>>> + *
>>>> + * @vma:  Pointer to vma
>>>> + */
>>>> +void ksm_add_vma(struct vm_area_struct *vma)
>>>> +{
>>>> +	struct mm_struct *mm = vma->vm_mm;
>>>> +
>>>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>>>> +		__ksm_add_vma(vma);
>>>> +}
>>>> +
>>>> +/**
>>>> + * ksm_add_vmas - Mark all vma's of a process as mergeable
>>>> + *
>>>> + * @mm:  Pointer to mm
>>>> + */
>>>> +void ksm_add_vmas(struct mm_struct *mm)
>>>
>>> I'd suggest calling this
>>>
>> I guess you forgot your name suggestion?
> 
> Yeah, I reconsidered because the first idea I had was not particularly
> good. Maybe
> 
> ksm_enable_for_all_vmas()
> 
> But not so sure. If you think the "add" terminology is a good fit, keep
> it like that.
> 
> 
> Thanks for bearing with me :)
> 

I briefly played with your patch to see how much it can be simplified.
Always enabling ksm (setting MMF_VM_MERGEABLE) before setting
MMF_VM_MERGE_ANY might simplify things. ksm_enable_merge_any() [or however it should
be called] and ksm_fork() contain the interesting bits.


Feel free to incorporate what you consider valuable (uncompiled,
untested).


diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 5a716bdcba05..5b2eef31398e 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2591,6 +2591,12 @@ int gmap_mark_unmergeable(void)
  	int ret;
  	VMA_ITERATOR(vmi, mm, 0);
  
+	/*
+	 * Make sure to disable KSM (if enabled for the whole process or
+	 * individual VMAs). Note that nothing currently hinders user space
+	 * from re-enabling it.
+	 */
+	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
  	for_each_vma(vmi, vma) {
  		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
  		vm_flags = vma->vm_flags;
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7e232ba59b86..c638b034d586 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -18,13 +18,24 @@
  #ifdef CONFIG_KSM
  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
  		unsigned long end, int advice, unsigned long *vm_flags);
+
+void ksm_add_vma(struct vm_area_struct *vma);
+int ksm_enable_merge_any(struct mm_struct *mm);
+
  int __ksm_enter(struct mm_struct *mm);
  void __ksm_exit(struct mm_struct *mm);
  
  static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
  {
-	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
+	int ret;
+
+	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags)) {
+		ret = __ksm_enter(mm);
+		if (ret)
+			return ret;
+	}
+	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
+		set_bit(MMF_VM_MERGE_ANY, &mm->flags);
  	return 0;
  }
  
@@ -53,6 +64,10 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
  
  #else  /* !CONFIG_KSM */
  
+static inline void ksm_add_vma(struct vm_area_struct *vma)
+{
+}
+
  static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
  {
  	return 0;
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0e17ae7fbfd3..0ee96ea7a0e9 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -90,4 +90,5 @@ static inline int get_dumpable(struct mm_struct *mm)
  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
  
+#define MMF_VM_MERGE_ANY	29
  #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1312a137f7fb..759b3f53e53f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -290,4 +290,6 @@ struct prctl_mm_map {
  #define PR_SET_VMA		0x53564d41
  # define PR_SET_VMA_ANON_NAME		0
  
+#define PR_SET_MEMORY_MERGE		67
+#define PR_GET_MEMORY_MERGE		68
  #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 495cd87d9bf4..8c2e50edeb18 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -15,6 +15,7 @@
  #include <linux/highuid.h>
  #include <linux/fs.h>
  #include <linux/kmod.h>
+#include <linux/ksm.h>
  #include <linux/perf_event.h>
  #include <linux/resource.h>
  #include <linux/kernel.h>
@@ -2661,6 +2662,30 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
  	case PR_SET_VMA:
  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
  		break;
+#ifdef CONFIG_KSM
+	case PR_SET_MEMORY_MERGE:
+		if (mmap_write_lock_killable(me->mm))
+			return -EINTR;
+
+		if (arg2) {
+			error = ksm_enable_merge_any(me->mm);
+		} else {
+			/*
+			 * TODO: we might want disable KSM on all VMAs and
+			 * trigger unsharing to completely disable KSM.
+			 */
+			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
+			error = 0;
+		}
+		mmap_write_unlock(me->mm);
+		break;
+	case PR_GET_MEMORY_MERGE:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+
+		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
+		break;
+#endif
  	default:
  		error = -EINVAL;
  		break;
diff --git a/mm/ksm.c b/mm/ksm.c
index 2b8d30068cbb..76ceec35395c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -512,6 +512,28 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
  	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
  }
  
+static bool vma_ksm_compatible(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
+			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
+			     VM_MIXEDMAP))
+		return false;		/* just ignore the advice */
+
+	if (vma_is_dax(vma))
+		return false;
+
+#ifdef VM_SAO
+	if (vma->vm_flags & VM_SAO)
+		return false;
+#endif
+#ifdef VM_SPARC_ADI
+	if (vma->vm_flags & VM_SPARC_ADI)
+		return false;
+#endif
+
+	return true;
+}
+
  static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
  		unsigned long addr)
  {
@@ -1020,6 +1042,7 @@ static int unmerge_and_remove_all_rmap_items(void)
  
  			mm_slot_free(mm_slot_cache, mm_slot);
  			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
  			mmdrop(mm);
  		} else
  			spin_unlock(&ksm_mmlist_lock);
@@ -2395,6 +2418,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
  
  		mm_slot_free(mm_slot_cache, mm_slot);
  		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
  		mmap_read_unlock(mm);
  		mmdrop(mm);
  	} else {
@@ -2471,6 +2495,52 @@ static int ksm_scan_thread(void *nothing)
  	return 0;
  }
  
+static void __ksm_add_vma(struct vm_area_struct *vma)
+{
+	unsigned long vm_flags = vma->vm_flags;
+
+	if (vm_flags & VM_MERGEABLE)
+		return;
+
+	if (vma_ksm_compatible(vma)) {
+		vm_flags |= VM_MERGEABLE;
+		vm_flags_reset(vma, vm_flags);
+	}
+}
+
+/**
+ * ksm_add_vma - Mark vma as mergeable
+ *
+ * @vma:  Pointer to vma
+ */
+void ksm_add_vma(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		__ksm_add_vma(vma);
+}
+
+int ksm_enable_merge_any(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	int ret;
+
+	if (test_bit(MMF_VM_MERGE_ANY, mm->flags))
+		return 0;
+
+	if (!test_bit(MMF_VM_MERGEABLE, mm->flags)) {
+		ret = __ksm_enter(mm);
+		if (ret)
+			return ret;
+	}
+	set_bit(MMF_VM_MERGE_ANY, &mm->flags);
+
+	VMA_ITERATOR(vmi, mm, 0);
+	for_each_vma(vmi, vma)
+		__ksm_add_vma(vma);
+}
+
  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
  		unsigned long end, int advice, unsigned long *vm_flags)
  {
@@ -2479,25 +2549,10 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
  
  	switch (advice) {
  	case MADV_MERGEABLE:
-		/*
-		 * Be somewhat over-protective for now!
-		 */
-		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
-				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_MIXEDMAP))
-			return 0;		/* just ignore the advice */
-
-		if (vma_is_dax(vma))
+		if (vma->vm_flags & VM_MERGEABLE)
  			return 0;
-
-#ifdef VM_SAO
-		if (*vm_flags & VM_SAO)
-			return 0;
-#endif
-#ifdef VM_SPARC_ADI
-		if (*vm_flags & VM_SPARC_ADI)
+		if (!vma_ksm_compatible(vma))
  			return 0;
-#endif
  
  		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
  			err = __ksm_enter(mm);
@@ -2601,6 +2656,7 @@ void __ksm_exit(struct mm_struct *mm)
  	if (easy_to_free) {
  		mm_slot_free(mm_slot_cache, mm_slot);
  		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
  		mmdrop(mm);
  	} else if (mm_slot) {
  		mmap_write_lock(mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index ff68a67a2a7c..1f8619ff58ca 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
  #include <linux/pkeys.h>
  #include <linux/oom.h>
  #include <linux/sched/mm.h>
+#include <linux/ksm.h>
  
  #include <linux/uaccess.h>
  #include <asm/cacheflush.h>
@@ -2659,6 +2660,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  	if (file && vm_flags & VM_SHARED)
  		mapping_unmap_writable(file->f_mapping);
  	file = vma->vm_file;
+	ksm_add_vma(vma);
  expanded:
  	perf_event_mmap(vma);
  
@@ -2931,6 +2933,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
  		goto mas_store_fail;
  
  	mm->map_count++;
+	ksm_add_vma(vma);
  out:
  	perf_event_mmap(vma);
  	mm->total_vm += len >> PAGE_SHIFT;
-- 
2.39.2


-- 
Thanks,

David / dhildenb

