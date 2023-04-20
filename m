Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDF6E9DD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDTV1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjDTV1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 17:27:01 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7E30C5;
        Thu, 20 Apr 2023 14:26:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 88F83320024A;
        Thu, 20 Apr 2023 17:26:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Apr 2023 17:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682026016; x=1682112416; bh=ky
        pGF2ii73vq7/MLpGRQfGi3Vad0RUnvoKgRKQqP8c4=; b=S48pqTi3g1iCvy/lPY
        pwdM0OKwkxXwYg17Ey9YitSRRwLJaMco0E1lrPsaKNyVe6of1qlgN7I4WH42eTlz
        TxbmjMuZcdOBy3qDP9HkgJBk/Kk83EDd+iChTsbxrPGZthrkVWUOkEJkU0OA8YW6
        OMBQqPFb1yChqi44/wV8kG1cYWSTX7f/pvv7KIfTDUUZYfv0uz0JAZ3DYCqxQWyA
        7/m2hfq9uALNzk7/k5J51z/fbR0e/tFHwjv4zlUHdVKrIAhvTmx7QKcpL4PcE8vz
        b8Qeszm4CVrJDsQxBXCaJXJ9443SzGXyJaipIOYSv05S3pxLgOLL2k8zrZlGDVGg
        uBSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682026016; x=1682112416; bh=kypGF2ii73vq7
        /MLpGRQfGi3Vad0RUnvoKgRKQqP8c4=; b=ZSVGEgiumPxVBspocrub1eSMopJ8S
        i8lf1W0REVumFGfbjAzaGINMZ9CL+P8MN1MW4/x8eWtIPnqdexAedPqNlUqTERpJ
        1TUNjSc+t52G0FBnez71PBFtu5ui03gcgFQXkALg3hm4yNJe23BggW4Xzx3LcV7p
        a0QFJuLfIXNbAzjuDkKmLV8WSebJZ9ZNGfGJDc4lEBPB96C05jwjKAe6sPvIx+kl
        7dqxnrwIJb2veHWTH0DpJW0riSixxKiDI11p3QyYsBl1brQWBNcSGAxN1WyquFBw
        nfY8uboPHyVQFOXmZrXw3OqL0P7rWWtjjITUXiRCHo3cfchMT02Tb4eEw==
X-ME-Sender: <xms:H65BZOgq4fLcqHVBkpFqD7t3Kfkcx-uHRim7C_CAx6I7u9oNgHklZw>
    <xme:H65BZPDQQbx4dMjEUT5ZyswBvEw_Tixzqwhwfxa12kcv-6Z-IAOSb-IZIFpXyh4qx
    WpqjG_BuFQFpRPYAIo>
X-ME-Received: <xmr:H65BZGHuXf44E4aQPpOjvzc6H7Rj4Qmn0gVDn5LwGf8WwbUgbpfDqzrMyatAQmYCYDXh6vzKiEOYraMBnFq8B7gqoqxiuL9eejoT-mUHuw96Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:H65BZHQRedaeVcuG1dT-BvsrzNUcD6fv5a-FCRQBZnJC467XrcyqWw>
    <xmx:H65BZLxqbgKPxvDO6Cf4XioiDxG9pF-6OU4fDtsRZ-ryCtVAOl9Ksw>
    <xmx:H65BZF72Hiv-b4hsn43RkGMk-V9mnjbziMA-MJ8bXo7Lhb6820m6iw>
    <xmx:IK5BZAK-EZrNlzwSoHaaw51tNn9QCllYURl1nTUymBYB-IaYZqu1XA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Apr 2023 17:26:53 -0400 (EDT)
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-2-david@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when
 setting PR_SET_MEMORY_MERGE=0
Date:   Thu, 20 Apr 2023 14:21:42 -0700
In-reply-to: <20230418152849.505124-2-david@redhat.com>
Message-ID: <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> Let's unmerge any KSM pages when setting PR_SET_MEMORY_MERGE=0, and clear
> the VM_MERGEABLE flag from all VMAs -- just like KSM would. Of course,
> only do that if we previously set PR_SET_MEMORY_MERGE=1.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/ksm.h |  1 +
>  kernel/sys.c        |  7 +------
>  mm/ksm.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 590934bdddcf..7108bc65dc2a 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -21,6 +21,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>
>  void ksm_add_vma(struct vm_area_struct *vma);
>  int ksm_enable_merge_any(struct mm_struct *mm);
> +int ksm_disable_merge_any(struct mm_struct *mm);
>
>  int __ksm_enter(struct mm_struct *mm);
>  void __ksm_exit(struct mm_struct *mm);
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 72cdb16e2636..3436376667d7 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2698,12 +2698,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		if (arg2) {
>  			error = ksm_enable_merge_any(me->mm);
>  		} else {
> -			/*
> -			 * TODO: we might want disable KSM on all VMAs and
> -			 * trigger unsharing to completely disable KSM.
> -			 */
> -			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> -			error = 0;
> +			error = ksm_disable_merge_any(me->mm);
>  		}
>
nit:
can we do:

    if (arg2)
   	error = ksm_enable_merge_any(me->mm);
	else
   	error = ksm_disable_merge_any(me->mm);
	mmap_write_unlock(me->mm);
	break;

> diff --git a/mm/ksm.c b/mm/ksm.c
> index a959e8925413..813f7fbc1832 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2520,6 +2520,22 @@ static void __ksm_add_vma(struct vm_area_struct *vma)
>  		vm_flags_set(vma, VM_MERGEABLE);
>  }
>
> +static int __ksm_del_vma(struct vm_area_struct *vma)
> +{
> +	int err;
> +
> +	if (!(vma->vm_flags & VM_MERGEABLE))
> +		return 0;
> +
> +	if (vma->anon_vma) {
> +		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
> +		if (err)
> +			return err;
> +	}
> +
> +	vm_flags_clear(vma, VM_MERGEABLE);
> +	return 0;
> +}
>  /**
>   * ksm_add_vma - Mark vma as mergeable if compatible
>   *
> @@ -2542,6 +2558,20 @@ static void ksm_add_vmas(struct mm_struct *mm)
>  		__ksm_add_vma(vma);
>  }
>
> +static int ksm_del_vmas(struct mm_struct *mm)
> +{
> +	struct vm_area_struct *vma;
> +	int err;
> +
> +	VMA_ITERATOR(vmi, mm, 0);
> +	for_each_vma(vmi, vma) {
> +		err = __ksm_del_vma(vma);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  /**
>   * ksm_enable_merge_any - Add mm to mm ksm list and enable merging on all
>   *                        compatible VMA's
> @@ -2569,6 +2599,23 @@ int ksm_enable_merge_any(struct mm_struct *mm)
>  	return 0;
>  }
>
> +int ksm_disable_merge_any(struct mm_struct *mm)
>

I understand we want to keep the name "symmetric" with
ksm_enable_merge_any, but it also unmerges the ksm pages. Do we want to
reflect that in the function name?

Can we add a comment for the function?

> +{
> +	int err;
> +
> +	if (!test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +		return 0;
> +
> +	err = ksm_del_vmas(mm);
> +	if (err) {
> +		ksm_add_vmas(mm);
> +		return err;
> +	}
> +
> +	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>

We only clear the MMF_VM_MERGE_ANY flag if there are no errors. Is this
what we want? This means that if the process creates new memory regions
they would still be marked as mergeable.

> +	return 0;
> +}
> +
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		unsigned long end, int advice, unsigned long *vm_flags)
>  {
