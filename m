Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F776E9E0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjDTVmg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 17:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjDTVme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 17:42:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66C1B1;
        Thu, 20 Apr 2023 14:42:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B2F73320069B;
        Thu, 20 Apr 2023 17:42:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 Apr 2023 17:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682026935; x=1682113335; bh=69
        77uaVS2Td2DS9RRiez30knC70Ckn3N3nk86wurFuA=; b=kB//UeM/D77+29L6nb
        x0k+u2NKKdSPwlPhpS5evvlUNn+lGKEN2Cff9oWnDi8ikzJSs9gXxqfA88RfIBOg
        Q54XE/iPVB/gABuDZjpEvXPjviXpAfQq0aBvY9I3bpKwh4ZeuztZf/GkpZZjIWQz
        IRzQhlsAVTlmHBjtoOUXuZVuQQSKDGESv2kWoy8wlSxo0D/qTBakGpiA+YWrgh+o
        hHsRwZzjjZc58AY4UL1xKmk6ZMb9gqLA8UQ31wHYUGh5AWD5s1/zUpRfxX8m8Sgl
        wsnVGusHxTorDyouAnWvUsm5tYcH9cz+7BhTprOyO2Eh3pOyHUeLAwMiMOMSkRRq
        vFjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682026935; x=1682113335; bh=6977uaVS2Td2D
        S9RRiez30knC70Ckn3N3nk86wurFuA=; b=ArVKl0LA/UbRRmel+qsbCcYwwWi5r
        bZLGJz7H1iFmZ4hfZulYA5VYs6judWHY1ZhcZjAPU84mvVdi1HEvXxrnoMEvESls
        dktW/A/rzmr0jd0394QPSVswjuYKR6Ypcq4Jy+ypQ8ygwwEgmVruaNP6lLxcX0F3
        k7htVWj+qdrhJvMwYeXlJE6hhCKTj54zOxyTk25Afw0UWyktBrghiiatXYQOU6+7
        PphIhf/IA6Q9rpWvwpAoN7g+oO458zfS/q7ZsZ2DPF/1B8OGcNgxsqAhgLGsLbP3
        4ciN/IRuEb8AhyHxutZAUTZo5AoJyIJzyQ3FJQd0HiwpXYkBy5OoMPjfw==
X-ME-Sender: <xms:t7FBZGmew-Rc4rLPsXzR7Pk7zL6b_Mqd5ND_LdndHGAIuAqWLNhH0Q>
    <xme:t7FBZN3kXoa7qHp7MzraaSAz-HeeP8YzUUCP3sTh8vM6a2swFbA_RqtXZhhjlIpTb
    ynm7bg0yNYKhr4sg3g>
X-ME-Received: <xmr:t7FBZEpYIhHsUcCYTsdw_4xTTbAPkFJgSmy52fRt6T0KB1C4_TLxb52zUVx08VC2loXIdUGHLc3hS8OKGdU8lDvIxrblUtT3jC-ZP-DqcaTO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtfedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:t7FBZKl_DfyWHOuS5qtfTluh9MZpocCJhWgkWnhinVDQxo3J3Gfq8Q>
    <xmx:t7FBZE31gOxXEUlbf2GX_8lMVtRqV7w0K1bfPxEhExZZpAIHN_fEMQ>
    <xmx:t7FBZBs8LvlfR2mr2GQGaxeM4U1Yvgh5NQhjg0Yxb_LpEcIGD7IDOA>
    <xmx:t7FBZOOqXhpDwKCbguOYeCBQxWk99wylGRkt1TvRgvUKfDH6VkLTsQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Apr 2023 17:42:13 -0400 (EDT)
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-4-david@redhat.com>
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
Subject: Re: [PATCH v1 3/3] mm/ksm: move disabling KSM from s390/gmap code
 to KSM code
Date:   Thu, 20 Apr 2023 14:41:00 -0700
In-reply-to: <20230418152849.505124-4-david@redhat.com>
Message-ID: <qvqwildqi62z.fsf@devbig1114.prn1.facebook.com>
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

> Let's factor out actual disabling of KSM. The existing
> "mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can be dropped,
> because def_flags should never include VM_MERGEABLE. Note that we don't
> currently prevent re-enabling KSM.
>
> This should now be faster in case KSM was never enabled, because we only
> conditionally iterate all VMAs. Further, it certainly looks cleaner.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 20 +-------------------
>  include/linux/ksm.h |  6 ++++++
>  mm/ksm.c            | 11 +++++++++++
>  3 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 0949811761e6..dfe905c7bd8e 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
>
>  int gmap_mark_unmergeable(void)
>  {
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
> -	unsigned long vm_flags;
> -	int ret;
> -	VMA_ITERATOR(vmi, mm, 0);
> -
>  	/*
>  	 * Make sure to disable KSM (if enabled for the whole process or
>  	 * individual VMAs). Note that nothing currently hinders user space
>  	 * from re-enabling it.
>  	 */
> -	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> -
> -	for_each_vma(vmi, vma) {
> -		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
> -		vm_flags = vma->vm_flags;
> -		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -				  MADV_UNMERGEABLE, &vm_flags);
> -		if (ret)
> -			return ret;
> -		vm_flags_reset(vma, vm_flags);
> -	}
> -	mm->def_flags &= ~VM_MERGEABLE;
>

This clears the def_flags struct member, however, in ksm_disable() we
clear the __flags struct member. Is this a problem?

> -	return 0;
> +	return ksm_disable(current->mm);
>  }
>  EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
>
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 7108bc65dc2a..b3d8b7849e18 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -22,6 +22,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  void ksm_add_vma(struct vm_area_struct *vma);
>  int ksm_enable_merge_any(struct mm_struct *mm);
>  int ksm_disable_merge_any(struct mm_struct *mm);
> +int ksm_disable(struct mm_struct *mm);
>
>  int __ksm_enter(struct mm_struct *mm);
>  void __ksm_exit(struct mm_struct *mm);
> @@ -75,6 +76,11 @@ static inline void ksm_add_vma(struct vm_area_struct *vma)
>  {
>  }
>
> +static inline int ksm_disable(struct mm_struct *mm)
> +{
> +	return 0;
> +}
> +
>  static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	return 0;
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 813f7fbc1832..208311cbb019 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2616,6 +2616,17 @@ int ksm_disable_merge_any(struct mm_struct *mm)
>  	return 0;
>  }
>
> +int ksm_disable(struct mm_struct *mm)
> +{
> +	mmap_assert_write_locked(mm);
> +
> +	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +		return 0;
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> +		return ksm_disable_merge_any(mm);
> +	return ksm_del_vmas(mm);
> +}
> +
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		unsigned long end, int advice, unsigned long *vm_flags)
>  {
