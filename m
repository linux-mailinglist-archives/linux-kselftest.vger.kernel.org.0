Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5BC7B0563
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjI0NaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjI0NaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 09:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC611D
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695821380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2hv5CuQPn74NEvKQKxD/ubIeG0HKIdGdn5RcarEG6U=;
        b=HuXzarHLLaxmu+0QeI+x89WfBtKFV5HJIfdWwxTFAciKzgp0yBdMFQwgJ1x0wNVMt3rUpt
        C8R9HuZ9gx5l2KDovxmd+CHId8020Biep4kWwa7/SiKefI9QSMjNOynxpiXSubNMjkacbs
        G/jAAxMlcDoGKJANNvF7BrkdAXvRl68=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-mJTADcSHMje6DqO7g6oAEQ-1; Wed, 27 Sep 2023 09:29:38 -0400
X-MC-Unique: mJTADcSHMje6DqO7g6oAEQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40642a1e13bso15955095e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 06:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695821378; x=1696426178;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2hv5CuQPn74NEvKQKxD/ubIeG0HKIdGdn5RcarEG6U=;
        b=TfKx2Ec4KVc0gWsASzATc95f2NYJtGyI5TZN22Hx4PjUYuWuGGMWF34xySBcvVr1mG
         +QkXJjrWo+sCuF49Kwn+zDOCHWFk/cNdN5kNDWzel2ikmzV0QcKJCNDOZAq9P3aA8gas
         FEnwpNe0lB5VoOtI0T0krBjOK1s6TTRY7LjmTirXdpEAKCgMG4XUNEUJH7/tXjvJ7ySS
         sOYcIL+wkgYmHhiR23oigizxhuIJ6gcxyJFjVoKxmP5hC2+cBnYoZahSflTFk1n6JfAu
         yNeNzV9r7nZ8oDRRwbfvBECU8yE+ShmSowz8GvIy4DJg+PBqV9l7gu+JglJoYaJ66ze5
         vSrQ==
X-Gm-Message-State: AOJu0YxRxXQpphspsDBqWjuQKaZWQc3tohZz1QEkhaHbUUYyDqyAp1EC
        CQj0Y37PtW4YORgMQADGA/GV2W2eALFC35VHXURunZCcvz4RwsFaUo8SVSeI4LQ9wW9lc2ZW0j2
        Jb3uA20Z7txOQ2y2IJozAmv1DNLl8
X-Received: by 2002:a7b:c8cd:0:b0:405:3a63:6d12 with SMTP id f13-20020a7bc8cd000000b004053a636d12mr1881899wml.17.1695821377606;
        Wed, 27 Sep 2023 06:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmM/Vcbhyu+gFvAqhqp6gDueEI1OOogKEfv68sNWi+zB+gBfd/bHDtz9MAW7eJXY1rkpiOgg==
X-Received: by 2002:a7b:c8cd:0:b0:405:3a63:6d12 with SMTP id f13-20020a7bc8cd000000b004053a636d12mr1881872wml.17.1695821377080;
        Wed, 27 Sep 2023 06:29:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:6900:3a06:bd5:2f7b:e6eb? (p200300cbc74969003a060bd52f7be6eb.dip0.t-ipconnect.de. [2003:cb:c749:6900:3a06:bd5:2f7b:e6eb])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c210200b004063d8b43e7sm3920879wml.48.2023.09.27.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 06:29:36 -0700 (PDT)
Message-ID: <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
Date:   Wed, 27 Sep 2023 15:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> +static int remap_anon_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>> +                         struct vm_area_struct *dst_vma,
>> +                         struct vm_area_struct *src_vma,
>> +                         unsigned long dst_addr, unsigned long src_addr,
>> +                         pte_t *dst_pte, pte_t *src_pte,
>> +                         pte_t orig_dst_pte, pte_t orig_src_pte,
>> +                         spinlock_t *dst_ptl, spinlock_t *src_ptl,
>> +                         struct folio *src_folio)
>> +{
>> +       struct anon_vma *dst_anon_vma;
>> +
>> +       double_pt_lock(dst_ptl, src_ptl);
>> +
>> +       if (!pte_same(*src_pte, orig_src_pte) ||
>> +           !pte_same(*dst_pte, orig_dst_pte) ||
>> +           folio_test_large(src_folio) ||
>> +           folio_estimated_sharers(src_folio) != 1) {

^ here you should check PageAnonExclusive. Please get rid of any 
implicit explicit/implcit mapcount checks.

>> +               double_pt_unlock(dst_ptl, src_ptl);
>> +               return -EAGAIN;
>> +       }
>> +
>> +       BUG_ON(!folio_test_anon(src_folio));
>> +
>> +       dst_anon_vma = (void *)dst_vma->anon_vma + PAGE_MAPPING_ANON;
>> +       WRITE_ONCE(src_folio->mapping,
>> +                  (struct address_space *) dst_anon_vma);

I have some cleanups pending for page_move_anon_rmap(), that moves the 
SetPageAnonExclusive hunk out. Here we should be using 
page_move_anon_rmap() [or rather, folio_move_anon_rmap() after my cleanups]

I'll send them out soonish.

>> +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
>> +                                                     dst_addr)); >> +
>> +       orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
>> +       orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>> +       orig_dst_pte = maybe_mkwrite(pte_mkdirty(orig_dst_pte),
>> +                                    dst_vma);
> 
> I think there's still a theoretical issue here that you could fix by
> checking for the AnonExclusive flag, similar to the huge page case.
> 
> Consider the following scenario:
> 
> 1. process P1 does a write fault in a private anonymous VMA, creating
> and mapping a new anonymous page A1
> 2. process P1 forks and creates two children P2 and P3. afterwards, A1
> is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
> 3. process P1 removes its mapping of A1, dropping its mapcount to 2.
> 4. process P2 uses vmsplice() to grab a reference to A1 with get_user_pages()
> 5. process P2 removes its mapping of A1, dropping its mapcount to 1.
> 
> If at this point P3 does a write fault on its mapping of A1, it will
> still trigger copy-on-write thanks to the AnonExclusive mechanism; and
> this is necessary to avoid P3 mapping A1 as writable and writing data
> into it that will become visible to P2, if P2 and P3 are in different
> security contexts.
> 
> But if P3 instead moves its mapping of A1 to another address with
> remap_anon_pte() which only does a page mapcount check, the
> maybe_mkwrite() will directly make the mapping writable, circumventing
> the AnonExclusive mechanism.
> 

Yes, can_change_pte_writable() contains the exact logic when we can turn 
something easily writable even if it wasn't writable before. which 
includes that PageAnonExclusive is set. (but with uffd-wp or softdirty 
tracking, there is more to consider)

-- 
Cheers,

David / dhildenb

