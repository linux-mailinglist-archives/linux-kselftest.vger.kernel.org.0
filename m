Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1881F6C4963
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCVLnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 07:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCVLnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 07:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CB5C12C
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679485330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBZgK0/JPT5xJjz9EUa06pTovtVSpvWZDvch5ee80L8=;
        b=X/Zjz0dLHMG3inVOfjV8FAqTpj9HopvSM92Iqv15TLbTyLJg36UBg+pU/o+6sgyxD2hEpC
        FzHPm7quADiv6+b0Z9UiDlROMtSIjcAV9K/+TWhmD0nxg1xH1fx8txYBGsZV5BpHQAllVY
        P1YJX24nWihLS208+ryhGJjb5ss8NX8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-QuOUNTV8N5eHZHYE2xuJyg-1; Wed, 22 Mar 2023 07:42:04 -0400
X-MC-Unique: QuOUNTV8N5eHZHYE2xuJyg-1
Received: by mail-wm1-f70.google.com with SMTP id j27-20020a05600c1c1b00b003edd2023418so5570093wms.4
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 04:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485323;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBZgK0/JPT5xJjz9EUa06pTovtVSpvWZDvch5ee80L8=;
        b=m1zhyn4RPIHl/hzTW3EvOxprHJizgWn9tCjMKexB8hpoXQ+cZrPG4Rq3tOBGcSzs9E
         lWgXUJdGK1EM/kcKSMU/FkLHvIjT2ay2gXCT2xvs/W92uvQDEi5HdCKk6GI+YcUhNA5m
         KeXekjsA5F13TwGmj0oxUDACYzeCd24x1WGqxrObvS6idY0rnHJahczhoZJGYVH9aiDO
         nbUx0CzjKYKGQODp6aIKKiukBZlZccJImsdoYv9HvF6Y4Ux8040Qhh4GHxrE2quMWHoj
         fwr6s990PhkKoIRXGAAsRvz4NmszdhxOgGEGHo+Ix7Xulg5Dgjk9FD4/FCaQbp/OC2hX
         jmKA==
X-Gm-Message-State: AO0yUKV/KjwEvZuVygI8nXqYtnb0HzobU0DSrqtj4prnLX8GEwk0m4tj
        0RGa0dhUnmhHKviGhZmCaWVJLXz4ZcvCLee06JfLNBgRlzPynlv3I/bqezWznMDMk+fBflrnUSD
        TqY1pE3H2uOzGCylNkRa8DM6lkDoy
X-Received: by 2002:a05:600c:b8f:b0:3ee:f91:19aa with SMTP id fl15-20020a05600c0b8f00b003ee0f9119aamr1509094wmb.0.1679485323379;
        Wed, 22 Mar 2023 04:42:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set+5kJml4rsGt82fAlBVT9jTxgatu7EG77Rbrxa9bVDd4VR+2tEyYsjJMTVSfgxkwsO3b20ySA==
X-Received: by 2002:a05:600c:b8f:b0:3ee:f91:19aa with SMTP id fl15-20020a05600c0b8f00b003ee0f9119aamr1509078wmb.0.1679485322979;
        Wed, 22 Mar 2023 04:42:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c4e5600b003ee6def283bsm720842wmq.11.2023.03.22.04.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:42:02 -0700 (PDT)
Message-ID: <808b9d4a-1b01-be64-00ce-001930540de9@redhat.com>
Date:   Wed, 22 Mar 2023 12:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20230104144905.460075-1-david@redhat.com>
 <CAAa6QmSZTQ6=oxsTvCLoaFMcpamkNa7wY6VkDoipRTDAo5JhoQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] selftests/vm: cow: Add COW tests for
 collapsing of PTE-mapped anon THP
In-Reply-To: <CAAa6QmSZTQ6=oxsTvCLoaFMcpamkNa7wY6VkDoipRTDAo5JhoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16.03.23 00:28, Zach O'Keefe wrote:
>>
>> Currently, anonymous PTE-mapped THPs cannot be collapsed in-place:
>> collapsing (e.g., via MADV_COLLAPSE) implies allocating a fresh THP and
>> mapping that new THP via a PMD: as it's a fresh anon THP, it will get the
>> exclusive flag set on the head page and everybody is happy.
>>
>> However, if the kernel would ever support in-place collapse of anonymous
>> THPs (replacing a page table mapping each sub-page of a THP via PTEs with a
>> single PMD mapping the complete THP), exclusivity information stored for
>> each sub-page would have to be collapsed accordingly:
>>
>> (1) All PTEs map !exclusive anon sub-pages: the in-place collapsed THP
>>      must not not have the exclusive flag set on the head page mapped by
>>      the PMD. This is the easiest case to handle ("simply don't set any
>>      exclusive flags").
>>
>> (2) All PTEs map exclusive anon sub-pages: when collapsing, we have to
>>      clear the exclusive flag from all tail pages and only leave the
>>      exclusive flag set for the head page. Otherwise, fork() after
>>      collapse would not clear the exclusive flags from the tail pages
>>      and we'd be in trouble once PTE-mapping the shared THP when writing
>>      to shared tail pages that still have the exclusive flag set. This
>>      would effectively revert what the PTE-mapping code does when
>>      propagating the exclusive flag to all sub-pages.
>>
>> (3) PTEs map a mixture of exclusive and !exclusive anon sub-pages (can
>>      happen e.g., due to MADV_DONTFORK before fork()). We must not
>>      collapse the THP in-place, otherwise bad things may happen:
>>      the exclusive flags of sub-pages would get ignored and the
>>      exclusive flag of the head page would get used instead.
>>
>> Now that we have MADV_COLLAPSE in place to trigger collapsing a THP,
>> let's add some test cases that would bail out early, if we'd
>> voluntarily/accidantially unlock in-place collapse for anon THPs and
>> forget about taking proper care of exclusive flags.
> 
> Hey David,
> 
> Sorry for the (very) delayed review. As our helpful syncs offline, I'm in a
> better place to understand the intent of these tests.

Thanks for the review and sorry for the late reply!

> 
> On Wed, Jan 4, 2023 at 6:49 AM David Hildenbrand <david@redhat.com> wrote:
> 
>> Running the test on a kernel with MADV_COLLAPSE support:
>>    # [INFO] Anonymous THP tests
>>    # [RUN] Basic COW after fork() when collapsing before fork()
>>    ok 169 No leak from parent into child
>>    # [RUN] Basic COW after fork() when collapsing after fork() (fully shared)
>>    ok 170 # SKIP MADV_COLLAPSE failed: Invalid argument
>>    # [RUN] Basic COW after fork() when collapsing after fork() (lower shared)
>>    ok 171 No leak from parent into child
>>    # [RUN] Basic COW after fork() when collapsing after fork() (upper shared)
>>    ok 172 No leak from parent into child
>>
>> For now, MADV_COLLAPSE always seems to fail if all PTEs map shared
>> sub-pages.
> 
> Thanks for pointing this out. I have had a TODO / pending patch to verify this
> for awhile. It seems this is due to some old requirement of requiring a single
> writeable pte. I don't know this history well here, but I don't think it's

Interesting. A single writable PTE would indicate that at least some 
part of the range is exclusive (!shared) without looking at mapcounts. 
But of course, it's an unreliable check.

> required anymore, and, as this test shows, prevents collapse of
> pte-mapped-hugepage shared across fork().

[...]

>>
>> +#ifndef MADV_COLLAPSE
>> +#define MADV_COLLAPSE 25
>> +#endif
>> +
>>   static size_t pagesize;
>>   static int pagemap_fd;
>>   static size_t thpsize;
>> @@ -1178,6 +1182,228 @@ static int tests_per_anon_test_case(void)
>>          return tests;
>>   }
>>
>> +enum anon_thp_collapse_test {
>> +       ANON_THP_COLLAPSE_UNSHARED,
> 
> OK, so this test checks case 2: we see all PG_anon_exclusive, and need to make
> sure we clear the bit on tails. Had we not, after fork(), the bit would still be
> set on tails (since copy_huge_pmd() -> page_try_dup_anon_rmap() only clears it
> on head), and so write to said tails would go through after wp fault, and since
> collapse was in-place, this leaks data from parent to child.
> 
>> +       ANON_THP_COLLAPSE_FULLY_SHARED,
> 
> This checks case 1: we see all !PG_anon_exclusive, we aught to set the flag on
> head page in parent, after fork(). Had we not, subsequent write will be allowed
> to go through after wp fault and hit backing page -- which, since collapse was
> in-place, is same as child, leaking data.
> 
>> +       ANON_THP_COLLAPSE_LOWER_SHARED,
>> +       ANON_THP_COLLAPSE_UPPER_SHARED,
> 
> IIUC, this check only partially tests case 3. Had we introduced a bug where we
> set PG_anon_exclusive on the head in this mixed-case, it's very similar to
> ANON_THP_COLLAPSE_FULLY_SHARED.
> 
> However, if we decided to still attempt in-place collapse, and cleared the bit
> in the parent, then the write here will be CoW'd and we won't see data leak
> into the child. In order for problems to occur, we'd need something to trip
> the improper CoW. The example you've shared with me was a io_uring fixed buffer
> mapping the non-shared pages, which, after CoW, would disagree.
> 
> That said, I'm not sure the extra work required to catch this case is worth the
> effort.

Yes, just like most tests, covering all corner cases takes a lot of 
effort and is probably not worth it. Wiring up io_uring (also used in 
the file already for these purposes) would be possible, however the 
initial tests are really more targeted at "bail out early" and to catch 
the obvious things one might miss when collapsing THP.

IOW: when people ignore exclusivity information when collapsing; the 
failing tests would directly tell you what needs to be done: better not 
mess with case #3. So IMHO, the basic tests for #3 are sufficient to 
express "see, you did it wrong: better be careful".

There are scenarios where we could handle #3: for example, if we're the 
only one mapping all sub-pages of a THP and there are no other 
references (i.e., page_count() == 512), we could collapse and mark the 
head page exclusive (clearing the marker from any tail pages). Once we 
really want to optimize these cases, we can add more such tests.

-- 
Thanks,

David / dhildenb

