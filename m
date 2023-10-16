Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE47CB1C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 20:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjJPSCR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjJPSCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 14:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137FAC
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697479290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgLDjZVj0XdXYm9kLe73MFbIBa94kVbOoQPaPBwR2t8=;
        b=NivTGFMuZFkaeiveQRHFxVX/GLQ+qeESN4aaziOz25tqtpcdAQZ8yl8RDADcs87AtcctzX
        Dn6lX2RXPKVplyWCoaRiTbumkNMVWusOFhrcZ/W8Y/sTKnAmU+RlBQSEWzlQqODBIWAaot
        TYecoF8MYBMPFa/6EJXb8zpalXOrRKk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-qFvgNq-_M7CLn84c-PCziA-1; Mon, 16 Oct 2023 14:01:14 -0400
X-MC-Unique: qFvgNq-_M7CLn84c-PCziA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-405629826ccso36391605e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 11:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697479273; x=1698084073;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgLDjZVj0XdXYm9kLe73MFbIBa94kVbOoQPaPBwR2t8=;
        b=IbmHJVZ+ditGvCLD91V7dOW+GafizteKyyjEiGnshUfmc92xs/I5YReKFQ9YkX5VsZ
         5X4DVhFw5RPmlNgughJB83r43SCw0Rfw84UdeKMncdywLb0917gwJ5biKAOeOkl9Kbhy
         MSOh4Ki5InJ/HAKmUJRBU8baoZ/FDn5ovbIzsDM3gwRcUqISe1ViXVMNF8gXdvoUT01K
         0ZMpAHOXgItbD7eh3WYoO+lenfJvWk6/7Q8kJzubI3pdJImaVORsqPAzZMBfIgzzFU2F
         OZUSmhwO3/yMla5WZuNfDTtnzZTYCxbGgcNg7e8I1cORmts3sKczjPif8+VyN9TLtnbm
         EWUA==
X-Gm-Message-State: AOJu0Yzl9Ya+ZihSN3t42JsRiWV+3M7R9/tBKa4QN66TsFZNUOZJIQXH
        YhmwcSNhgdDl9vPjTj8wp/3lky5W6UXeB2d9cU4m7N8Qxs22G8RCK90M/H7LhG4npHcM23wNwpq
        Pvgh3c4og8buzVwg7KdGl3DgXz9N9
X-Received: by 2002:a05:600c:2154:b0:401:519:c9 with SMTP id v20-20020a05600c215400b00401051900c9mr30565369wml.13.1697479273183;
        Mon, 16 Oct 2023 11:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8pCLIakSA25F9i66lD2EnjM3dwIvovQhF2Qm8USqE6swBPT/eG0QlP1UN5SBxdqyxfV6Gsg==
X-Received: by 2002:a05:600c:2154:b0:401:519:c9 with SMTP id v20-20020a05600c215400b00401051900c9mr30565339wml.13.1697479272598;
        Mon, 16 Oct 2023 11:01:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:9300:8903:bf2e:db72:6527? (p200300cbc73c93008903bf2edb726527.dip0.t-ipconnect.de. [2003:cb:c73c:9300:8903:bf2e:db72:6527])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b004068e09a70bsm7804392wmq.31.2023.10.16.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:01:12 -0700 (PDT)
Message-ID: <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
Date:   Mon, 16 Oct 2023 20:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
In-Reply-To: <ZSlragGjFEw9QS1Y@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[...]

>>> Actually, even though I have no solid clue, but I had a feeling that there
>>> can be some interesting way to leverage this across-mm movement, while
>>> keeping things all safe (by e.g. elaborately requiring other proc to create
>>> uffd and deliver to this proc).
>>
>> Okay, but no real use cases yet.
> 
> I can provide a "not solid" example.  I didn't mention it because it's
> really something that just popped into my mind when thinking cross-mm, so I
> never discussed with anyone yet nor shared it anywhere.
> 
> Consider VM live upgrade in a generic form (e.g., no VFIO), we can do that
> very efficiently with shmem or hugetlbfs, but not yet anonymous.  We can do
> extremely efficient postcopy live upgrade now with anonymous if with REMAP.
> 
> Basically I see it a potential way of moving memory efficiently especially
> with thp.

It's an interesting use case indeed. The questions would be if this is 
(a) a use case we want to support; (b) why we need to make that decision 
now and add that feature.

One question is if this kind of "moving memory between processes" really 
should be done, because intuitively SHMEM smells like the right thing to 
use here (two processes wanting to access the same memory).

The downsides of shmem are lack of the shared zeropage and KSM. The 
shared zeropage is usually less of a concern for VMs, but KSM is. 
However, KSM will also disallow moving pages here. But all 
non-deduplicated ones could be moved.

[I wondered whether moving KSM pages (rmap items) could be done; 
probably in some limited form with some more added complexity]

> 
>>
>>>
>>> Considering Andrea's original version already contains those bits and all
>>> above, I'd vote that we go ahead with supporting two MMs.
>>
>> You can do nasty things with that, as it stands, on the upstream codebase.
>>
>> If you pin the page in src_mm and move it to dst_mm, you successfully broke
>> an invariant that "exclusive" means "no other references from other
>> processes". That page is marked exclusive but it is, in fact, not exclusive.
> 
> It is still exclusive to the dst mm?  I see your point, but I think you're
> taking exclusiveness altogether with pinning, and IMHO that may not be
> always necessary?

That's the definition of PAE. See do_wp_page() on when we reset PAE: 
when there are no other references, which implies no other references 
from other processes. Maybe you have "currently exclusively mapped" in 
mind, which is what the mapcount can be used for.

> 
>>
>> Once you achieved that, you can easily have src_mm not have MMF_HAS_PINNED,
> 
> (I suppose you meant dst_mm here)

Yes.

> 
>> so you can just COW-share that page. Now you successfully broke the
>> invariant that COW-shared pages must not be pinned. And you can even trigger
>> VM_BUG_ONs, like in sanity_check_pinned_pages().
> 
> Yeah, that's really unfortunate.  But frankly, I don't think it's the fault
> of this new feature, but the rest.
> 
> Let's imagine if the MMF_HAS_PINNED wasn't proposed as a per-mm flag, but
> per-vma, which I don't see why we can't because it's simply a hint so far.
> Then if we apply the same rule here, UFFDIO_REMAP won't even work for
> single-mm as long as cross-vma. Then UFFDIO_REMAP as a whole feature will
> be NACKed simply because of this..

Because of gup-fast we likely won't see that happening. And if we would, 
it could be handled (src_mm has the flag set, set it on the destination 
if the page maybe pinned after hiding it from gup-fast; or simply always 
copy the flag if set on the src).

> 
> And I don't think anyone can guarantee a per-vma MMF_HAS_PINNED can never
> happen, or any further change to pinning solution that may affect this.  So
> far it just looks unsafe to remap a pin page to me.

It may be questionable to allow remapping pinned pages.

> 
> I don't have a good suggestion here if this is a risk.. I'd think it risky
> then to do REMAP over pinned pages no matter cross-mm or single-mm.  It
> means probably we just rule them out: folio_maybe_dma_pinned() may not even
> be enough to be safe with fast-gup.  We may need page_needs_cow_for_dma()
> with proper write_protect_seq no matter cross-mm or single-mm?

If you unmap and sync against GUP-fast, you can check after unmapping 
and remap and fail if it maybe pinned afterwards. Plus an early check 
upfront.

> 
>>
>> Can it all be fixed? Sure, with more complexity. For something without clear
>> motivation, I'll have to pass.
> 
> I think what you raised is a valid concern, but IMHO it's better fixed no
> matter cross-mm or single-mm.  What do you think?

single-mm should at least not cause harm, but the semantics are 
questionable. cross-mm could, especially with malicious user space that 
wants to find ways of harming the kernel.

I'll note that mremap with pinned pages works.

> 
> In general, pinning lose its whole point here to me for an userspace either
> if it DONTNEEDs it or REMAP it.  What would be great to do here is we unpin
> it upon DONTNEED/REMAP/whatever drops the page, because it loses its
> coherency anyway, IMHO.

Further, moving a part of a THP would fail either way, because the 
pinned THP cannot get split.

-- 
Cheers,

David / dhildenb

