Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453C7A9EE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjIUUOv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 16:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIUUOe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 16:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4ACB999
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695320271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzTcdyGI2+mbR4kqUecFI/lIF7d7z4fF019Uf7kMsFc=;
        b=JYDrhLw3BKbCNplIUR762TBwcHsRP2QlY8YLgWkjc2EGOvS1maU9utY0bYmOR22Z7nz8i2
        Rk1FQhWeJI9twCV/Hyb7GkFEx1I3TMn4bzDCkJatPDQabISc1w4GyX+nd4A9ErnOvJI+b2
        nNhnsTGHBlXlXmvp+lHwBaqUEtjtkzM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-sXgkFp04NbuD0joDS7rpXg-1; Thu, 21 Sep 2023 14:17:49 -0400
X-MC-Unique: sXgkFp04NbuD0joDS7rpXg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40309efe8b1so9529395e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 11:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320267; x=1695925067;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzTcdyGI2+mbR4kqUecFI/lIF7d7z4fF019Uf7kMsFc=;
        b=D/WuaZ+qC21Z0KoAoQ+NC6vXITQH1/Kib3rcWt2cbmgOe+sB7zItlxQvycdb+XWzQf
         EDbI+M9nu4W1fUqXgkc8Hi3SbuEinvXHxNaEFyOQ6etUpP4ZzGbvMXRSgj0YuoTOju7Y
         1NB39V18tqAS5Mr3QXg9sNvIgySz+GT8R0z+HONbX5uHkXOCfrX7lZgdWgtwr9jdcN3q
         WJ0eGipYasyZiOCVR1xNB0fLN8888FJfaaOcQ0pT7dqIJJI+aGyHgtjPjkQV7YED1Us5
         tfK8uKGyzg95TyBZq7bkM642rx+V8K3970GLho0qfDTO0Clf/zACqekF88aKgxyLueh4
         wKhg==
X-Gm-Message-State: AOJu0YxVVBCYb4bRPX+H4QG3G1Evys4p6bIKkoB4tlJHhJQiuMQmPVfN
        fAQz8YJKNtRlh9KcDNIsdOlRv9pnVrMnoA1sw0wy7pKzpH/09piBJMGLid6X2P7RT2lODaUvLae
        YbrBOYUXHyKXfrPl5ra5ay/B4FfNP
X-Received: by 2002:a1c:740f:0:b0:401:daf2:2735 with SMTP id p15-20020a1c740f000000b00401daf22735mr5528374wmc.31.1695320267487;
        Thu, 21 Sep 2023 11:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnVaSJCzaFK2qmY3g4W/8mz+pVzeGQKzxpMU+YTexuT26Aj3jV+KbrvHxK+ANFw1c9j6a+MA==
X-Received: by 2002:a1c:740f:0:b0:401:daf2:2735 with SMTP id p15-20020a1c740f000000b00401daf22735mr5528356wmc.31.1695320267022;
        Thu, 21 Sep 2023 11:17:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626? (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de. [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c379100b003fe1a96845bsm5414170wmr.2.2023.09.21.11.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:17:46 -0700 (PDT)
Message-ID: <354f2508-74d5-2723-502c-32d009f77a3e@redhat.com>
Date:   Thu, 21 Sep 2023 20:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
 <ZQNMze6SXdIm13CW@casper.infradead.org>
 <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
 <f6e350f4-1bf3-ca10-93f8-c11db44ce62b@redhat.com>
 <CAJuCfpGqt1V5puRMhLkjG6F2T4xtsDY8qy--ZfBPNL9kxPyWtg@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpGqt1V5puRMhLkjG6F2T4xtsDY8qy--ZfBPNL9kxPyWtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.09.23 20:04, Suren Baghdasaryan wrote:
> On Thu, Sep 14, 2023 at 6:45 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.09.23 20:43, David Hildenbrand wrote:
>>> On 14.09.23 20:11, Matthew Wilcox wrote:
>>>> On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
>>>>> +++ b/include/linux/userfaultfd_k.h
>>>>> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>>>>>     extern long uffd_wp_range(struct vm_area_struct *vma,
>>>>>                        unsigned long start, unsigned long len, bool enable_wp);
>>>>>
>>>>> +/* remap_pages */
>>>>> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>>>>> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
>>>>> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
>>>>> +                      struct mm_struct *src_mm,
>>>>> +                      unsigned long dst_start,
>>>>> +                      unsigned long src_start,
>>>>> +                      unsigned long len, __u64 flags);
>>>>> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>>>>> +                           struct mm_struct *src_mm,
>>>>> +                           pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>> +                           pmd_t dst_pmdval,
>>>>> +                           struct vm_area_struct *dst_vma,
>>>>> +                           struct vm_area_struct *src_vma,
>>>>> +                           unsigned long dst_addr,
>>>>> +                           unsigned long src_addr);
>>>>
>>>> Drop the 'extern' markers from function declarations.
>>>>
>>>>> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>>>>> +                    struct mm_struct *src_mm,
>>>>> +                    pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>> +                    pmd_t dst_pmdval,
>>>>> +                    struct vm_area_struct *dst_vma,
>>>>> +                    struct vm_area_struct *src_vma,
>>>>> +                    unsigned long dst_addr,
>>>>> +                    unsigned long src_addr)
>>>>> +{
>>>>> +   pmd_t _dst_pmd, src_pmdval;
>>>>> +   struct page *src_page;
>>>>> +   struct anon_vma *src_anon_vma, *dst_anon_vma;
>>>>> +   spinlock_t *src_ptl, *dst_ptl;
>>>>> +   pgtable_t pgtable;
>>>>> +   struct mmu_notifier_range range;
>>>>> +
>>>>> +   src_pmdval = *src_pmd;
>>>>> +   src_ptl = pmd_lockptr(src_mm, src_pmd);
>>>>> +
>>>>> +   BUG_ON(!pmd_trans_huge(src_pmdval));
>>>>> +   BUG_ON(!pmd_none(dst_pmdval));
>>>>> +   BUG_ON(!spin_is_locked(src_ptl));
>>>>> +   mmap_assert_locked(src_mm);
>>>>> +   mmap_assert_locked(dst_mm);
>>>>> +   BUG_ON(src_addr & ~HPAGE_PMD_MASK);
>>>>> +   BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
>>>>> +
>>>>> +   src_page = pmd_page(src_pmdval);
>>>>> +   BUG_ON(!PageHead(src_page));
>>>>> +   BUG_ON(!PageAnon(src_page));
>>>>
>>>> Better to add a src_folio = page_folio(src_page);
>>>> and then folio_test_anon() here.
>>>>
>>>>> +   if (unlikely(page_mapcount(src_page) != 1)) {
>>>>
>>>> Brr, this is going to miss PTE mappings of this folio.  I think you
>>>> actually want folio_mapcount() instead, although it'd be more efficient
>>>> to look at folio->_entire_mapcount == 1 and _nr_pages_mapped == 0.
>>>> Not wure what a good name for that predicate would be.
>>>
>>> We have
>>>
>>>     * It only works on non shared anonymous pages because those can
>>>     * be relocated without generating non linear anon_vmas in the rmap
>>>     * code.
>>>     *
>>>     * It provides a zero copy mechanism to handle userspace page faults.
>>>     * The source vma pages should have mapcount == 1, which can be
>>>     * enforced by using madvise(MADV_DONTFORK) on src vma.
>>>
>>> Use PageAnonExclusive(). As long as KSM is not involved and you don't
>>> use fork(), that flag should be good enough for that use case here.
>>>
>> ... and similarly don't do any of that swapcount stuff and only check if
>> the swap pte is anon exclusive.
> 
> I'm preparing v2 and this is the only part left for me to address but
> I'm not clear how. David, could you please clarify how I should be
> checking swap pte to be exclusive without swapcount?

If you have a real swp pte (not a non-swap pte like migration entries) 
you should be able to just use pte_swp_exclusive().

-- 
Cheers,

David / dhildenb

