Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3675E7A0D7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbjINSvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbjINSuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 14:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EF56E5828
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694717022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0akcrrxPTvMntGm3gQRHZF2Md0/HBRzawwdcPZ7RPas=;
        b=NnETkKMxgRzXYJHyd0e1mbnsKiTeYFpJLRACAag7SlUOVv90GGYffMiAp5gXAuV48uxQl+
        c9d8xFj8zqPypLE0rSvqre3K/TyxluJqM8l2NcKw6nChBGpR0Jm1qzT80Yf8bzgC2evr+o
        PIsKVfCq0pAyvTNMWUJdBwRROX1pdxs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-etRAT9XQPVayZFK6fbWBfQ-1; Thu, 14 Sep 2023 14:43:40 -0400
X-MC-Unique: etRAT9XQPVayZFK6fbWBfQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f2981b8364so813084f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 11:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717019; x=1695321819;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0akcrrxPTvMntGm3gQRHZF2Md0/HBRzawwdcPZ7RPas=;
        b=Eub/iDRRLqXmiw6OQzva31HeFcBXoqiJGDuHKh4n7xc3SGY603BQ7AvXWW9fcGOA5X
         8X+iZHKsSvxF7TRAp/SInl1DT1EsmU5ccgbcnRv6ikbZOJ9QojCI8KCze/WB5ROwzm5o
         ApQS8q1NwMo0nMPjvqVdhgIvpd2SnhVbm6Vip8jJvSJb25b9gDgW4qbKF/QRwMYw5alV
         lX7reIBwinBORgHqr1rExpNWMx9Y3TZ7tc6ipV6dK7viRsV2keonq8tclJkoqyFaqy0b
         8306CEhE+IoO3fBoBsBheS533biyKANpoqDw5ljQGOVfv1x8Yu+KLA1/349ETrpYi+DJ
         F4rA==
X-Gm-Message-State: AOJu0Yy6SLhyUc5rLfj+R+hJket3r/OZwh7vg9IYsNNQs5i3cuXX8uPm
        324LhWh5iLgyQwVf+8sMCKpRYCWcRT36wfSuJN+541xzQekKUb1i6AcM0CbIFfE/VvBdl1iLfm9
        ncQ9hNmhKFiDMex3zcE+VvKI7A3Jk
X-Received: by 2002:adf:f782:0:b0:31a:d551:c2c9 with SMTP id q2-20020adff782000000b0031ad551c2c9mr5368583wrp.6.1694717019429;
        Thu, 14 Sep 2023 11:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh7NWNMxRoWhcImoY2+JKuaYIz/StTxRyV5OHnf5w7KYP/JyxfK3mH80nh87mgTPUaRf1QtA==
X-Received: by 2002:adf:f782:0:b0:31a:d551:c2c9 with SMTP id q2-20020adff782000000b0031ad551c2c9mr5368560wrp.6.1694717018868;
        Thu, 14 Sep 2023 11:43:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:600:4630:4a91:d07:7095? (p200300cbc71c060046304a910d077095.dip0.t-ipconnect.de. [2003:cb:c71c:600:4630:4a91:d07:7095])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0031accc7228asm2463536wru.34.2023.09.14.11.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:43:38 -0700 (PDT)
Message-ID: <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
Date:   Thu, 14 Sep 2023 20:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
 <ZQNMze6SXdIm13CW@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQNMze6SXdIm13CW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14.09.23 20:11, Matthew Wilcox wrote:
> On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>>   extern long uffd_wp_range(struct vm_area_struct *vma,
>>   			  unsigned long start, unsigned long len, bool enable_wp);
>>   
>> +/* remap_pages */
>> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
>> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
>> +			   struct mm_struct *src_mm,
>> +			   unsigned long dst_start,
>> +			   unsigned long src_start,
>> +			   unsigned long len, __u64 flags);
>> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>> +				struct mm_struct *src_mm,
>> +				pmd_t *dst_pmd, pmd_t *src_pmd,
>> +				pmd_t dst_pmdval,
>> +				struct vm_area_struct *dst_vma,
>> +				struct vm_area_struct *src_vma,
>> +				unsigned long dst_addr,
>> +				unsigned long src_addr);
> 
> Drop the 'extern' markers from function declarations.
> 
>> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>> +			 struct mm_struct *src_mm,
>> +			 pmd_t *dst_pmd, pmd_t *src_pmd,
>> +			 pmd_t dst_pmdval,
>> +			 struct vm_area_struct *dst_vma,
>> +			 struct vm_area_struct *src_vma,
>> +			 unsigned long dst_addr,
>> +			 unsigned long src_addr)
>> +{
>> +	pmd_t _dst_pmd, src_pmdval;
>> +	struct page *src_page;
>> +	struct anon_vma *src_anon_vma, *dst_anon_vma;
>> +	spinlock_t *src_ptl, *dst_ptl;
>> +	pgtable_t pgtable;
>> +	struct mmu_notifier_range range;
>> +
>> +	src_pmdval = *src_pmd;
>> +	src_ptl = pmd_lockptr(src_mm, src_pmd);
>> +
>> +	BUG_ON(!pmd_trans_huge(src_pmdval));
>> +	BUG_ON(!pmd_none(dst_pmdval));
>> +	BUG_ON(!spin_is_locked(src_ptl));
>> +	mmap_assert_locked(src_mm);
>> +	mmap_assert_locked(dst_mm);
>> +	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
>> +	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
>> +
>> +	src_page = pmd_page(src_pmdval);
>> +	BUG_ON(!PageHead(src_page));
>> +	BUG_ON(!PageAnon(src_page));
> 
> Better to add a src_folio = page_folio(src_page);
> and then folio_test_anon() here.
> 
>> +	if (unlikely(page_mapcount(src_page) != 1)) {
> 
> Brr, this is going to miss PTE mappings of this folio.  I think you
> actually want folio_mapcount() instead, although it'd be more efficient
> to look at folio->_entire_mapcount == 1 and _nr_pages_mapped == 0.
> Not wure what a good name for that predicate would be.

We have

  * It only works on non shared anonymous pages because those can
  * be relocated without generating non linear anon_vmas in the rmap
  * code.
  *
  * It provides a zero copy mechanism to handle userspace page faults.
  * The source vma pages should have mapcount == 1, which can be
  * enforced by using madvise(MADV_DONTFORK) on src vma.

Use PageAnonExclusive(). As long as KSM is not involved and you don't 
use fork(), that flag should be good enough for that use case here.

[...]

>> +			/*
>> +			 * Pin the page while holding the lock to be sure the
>> +			 * page isn't freed under us
>> +			 */
>> +			spin_lock(src_ptl);
>> +			if (!pte_same(orig_src_pte, *src_pte)) {
>> +				spin_unlock(src_ptl);
>> +				err = -EAGAIN;
>> +				goto out;
>> +			}
>> +
>> +			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
>> +			if (!folio || !folio_test_anon(folio) ||
>> +			    folio_estimated_sharers(folio) != 1) {
> 
> I wonder if we also want to fail if folio_test_large()?  While we don't
> have large anon folios today, it seems to me that trying to migrate one
> of them like this is just not going to work.

Yes, refuse any PTE-mapped large folios.


-- 
Cheers,

David / dhildenb

