Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2016737681
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjFTVRH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjFTVRF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 17:17:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683D0F4
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 14:17:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-763a3699b9aso186736085a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1687295819; x=1689887819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+lU1iOzH0JYHL0tnMsXHMxNMnW9cnjxfw7NbbeeT9k=;
        b=Yj2QVX53Fw+1mon5tH4IY14qcLlldykQRdTs9ybZsnZrNJDZk6dwY4IldEP5yGcWEb
         yi7HHM/ZTWOv76ma7egJ1o7JXrdbxcrt+c7DSGndboQhD0bTQKRGlyVXUA1Q2UAd2L8H
         21l3AexyK7XnNoIxWR7NImrcrkLh1RDYji0b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295819; x=1689887819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+lU1iOzH0JYHL0tnMsXHMxNMnW9cnjxfw7NbbeeT9k=;
        b=MTDxKaV7w+Zkh2pJ/J6p//B+AXQXtI5h08X2V2JCSpzwk6L9rZbEEP16ZvEssV6D5q
         uAjZHPU93KvzoH9vkbOF3z7yCfHXl98VDvI1xizzhxdgUhE69iyShi9/HUw0pgkyXVrC
         gtJclBeF6JXfT+STjCEMXGIu3Zuy67faVNXpnBHwXn7rbJL/GDu9xjMcMdEVAb825lbl
         ko+ovUS1k00A9Ox5zLgE2RT6tSaOGDXu65uPh6lPx2/7ItUIJWZk2EJs3htkg+QuguBp
         zbl1QJ7Zyr1y7V8ok4m1IbL7U5lbcq1gKUZ30H4CM8hk5ayIOM39mbYnDeJ77VjPBScf
         OlVw==
X-Gm-Message-State: AC+VfDySScOoEealX+7CFGBHzlgpziLyDGDRFoDRoyRsF/IJvmdG/Nwm
        fDtClMtW3dzeG0Zz3PdnX3dLZg==
X-Google-Smtp-Source: ACHHUZ4xbfW9KezmmcCLJNdjr99ASmS2ufrHWysJjhsE+cY/TB9a4xu9GZNLCbBFA1/pGAvmRfCELw==
X-Received: by 2002:a05:620a:270e:b0:762:5ad0:59c5 with SMTP id b14-20020a05620a270e00b007625ad059c5mr7894137qkp.60.1687295819363;
        Tue, 20 Jun 2023 14:16:59 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a131500b0075b35e72a21sm1524673qkj.86.2023.06.20.14.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:16:58 -0700 (PDT)
Message-ID: <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
Date:   Tue, 20 Jun 2023 17:16:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
 <f28eadbc-f40e-4286-bf7e-af0ac360617e@lucifer.local>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <f28eadbc-f40e-4286-bf7e-af0ac360617e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Lorenzo,

On 6/20/23 07:02, Lorenzo Stoakes wrote:
> On Mon, Jun 19, 2023 at 11:55:08AM -0400, Joel Fernandes wrote:
>> Hi Lorenzo,
>> Thanks for the review! I replied below:
>>
>> On 6/17/23 18:49, Lorenzo Stoakes wrote:
>>> On Wed, May 31, 2023 at 10:08:01PM +0000, Joel Fernandes (Google) wrote:
>>>> Recently, we see reports [1] of a warning that triggers due to
>>>> move_page_tables() doing a downward and overlapping move on a
>>>> mutually-aligned offset within a PMD. By mutual alignment, I
>>>> mean the source and destination addresses of the mremap are at
>>>> the same offset within a PMD.
>>>>
>>>> This mutual alignment along with the fact that the move is downward is
>>>> sufficient to cause a warning related to having an allocated PMD that
>>>> does not have PTEs in it.
>>>>
>>>> This warning will only trigger when there is mutual alignment in the
>>>> move operation. A solution, as suggested by Linus Torvalds [2], is to
>>>> initiate the copy process at the PMD level whenever such alignment is
>>>> present. Implementing this approach will not only prevent the warning
>>>> from being triggered, but it will also optimize the operation as this
>>>> method should enhance the speed of the copy process whenever there's a
>>
>> [...]
>>
>>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>>>    mm/mremap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 61 insertions(+)
>>>>
>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>> index 411a85682b58..bf355e4d6bd4 100644
>>>> --- a/mm/mremap.c
>>>> +++ b/mm/mremap.c
>>>> @@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct
>>>>    	return moved;
>>>>    }
>>>>
>>>> +/*
>>>> + * A helper to check if a previous mapping exists. Required for
>>>> + * move_page_tables() and realign_addr() to determine if a previous mapping
>>>> + * exists before we can do realignment optimizations.
>>>> + */
>>>> +static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
>>>> +			       unsigned long mask)
>>>> +{
>>>> +	unsigned long addr_masked = addr_to_align & mask;
>>>> +	struct vm_area_struct *prev = NULL, *cur = NULL;
>>>> +
>>>> +	/*
>>>> +	 * If @addr_to_align of either source or destination is not the beginning
>>>> +	 * of the corresponding VMA, we can't align down or we will destroy part
>>>> +	 * of the current mapping.
>>>> +	 */
>>>> +	if (vma->vm_start != addr_to_align)
>>>> +		return false;
>>>
>>> See below, I think we can eliminate this check.
>>>
>>>> +
>>>> +	/*
>>>> +	 * Find the VMA before @vma to see if it subsumes the masked address.
>>>> +	 * The mmap write lock is held here so the lookup is safe.
>>>> +	 */
>>>> +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
>>>> +	if (WARN_ON_ONCE(cur != vma))
>>>> +		return false;
>>>> +
>>>> +	return !prev || prev->vm_end <= addr_masked;
>>>
>>> This is a bit clunky, and I don't think we need the WARN_ON_ONCE() check if
>>> we're under the mmap_lock.
>>>
>>> How about something like:-
>>>
>>> return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;
>>>
>>> Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
>>> empty.
>>>
>>> But actually, we should be able to go further and replace the previous
>>> check with:-
>>>
>>> return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;
>>>
>>> Which will fail if addr_to_align is offset within the VMA.
>>
>> Your suggestion would mean that we do a full VMA search starting from the
>> root. That would not be a nice thing if say we've 1000s of VMAs?
>>
>> Actually Liam told me to use find_vma_prev() because given a VMA, the maple
>> tree would not have to work that hard for the common case to find the
>> previous VMA. Per conversing with him, there is a chance we may have to go
>> one step above in the tree if we hit the edge of a node, but that's not
>> supposed to be the common case. In previous code, the previous VMA could
>> just be obtained using the "previous VMA" pointer, however that pointer has
>> been remove since the maple tree changes and given a VMA, going to the
>> previous one using the maple tree is just as fast (as I'm told).
> 
> As far as I can tell, find_vma_prev() already does a walk? I mean this is
> equivalent to find_vma() only retrieving the previous VMA right? I defer to
> Liam, but I'm not sure this would be that much more involved? Perhaps he
> can comment.
> 
> An alternative is to create an iterator and use vma_prev(). I find it
> extremely clunky that we search for a VMA we already possess (and it's
> previous one) while not needing the the former.
> 
> I'm not hugely familiar with the maple tree (perhaps Liam can comment) but
> I suspect that'd be more performant if that's the concern. Either way I
> would be surprised if this is the correct approach.

I see your point. I am not sure myself, the maple tree functions for both APIs 
are indeed similar. We already have looked up the VMA being aligned down. If 
there is a way to get the previous VMA quickly, given an existing VMA, I can 
incorporate that change.

Ideally, if I had access to the ma_state used for lookup of the VMA being 
aligned down, I could perhaps reuse that somehow. But when I checked, that 
seemed a lot more invasive to pass that state down to these align functions.

But there is a merit to your suggestion itself in the sense it cuts down a few 
more lines of code.

>> Considering this, I would keep the code as-is and perhaps you/we could
>> consider the replacement with another API in a subsequent patch as it does
>> the job for this patch.
> 
> See above. I don't think this kind of comment is helpful in code
> review. Your disagreement above suffices, I've responded to it and of
> course if there is no other way this is fine.
> 
> But I'd be surprised, and re-looking up a VMA we already have is just
> horrid. It's not really a nitpick, it's a code quality issue in my view.
> 
> In any case, let's please try to avoid 'if you are bothered, write a follow
> up patch' style responses. If you disagree with something just say so, it's
> fine! :)

I wasn't disagreeing :) Just saying that the find_vma_prev() suggested in a 
previous conversation with Liam fixes the issue (and has been tested a lot in 
this series, on my side) so I was hoping to stick to that and we could iterate 
more on that in the future.

However, after taking a deeper look at the maple tree, I'd like to give the 
find_vma_intersection() option at least a try (with appropriate attribution to you).

Apologies if the response style in my previous email came across badly. That 
wasn't my intent and I will try to improve myself.

[..]

>>>> +		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
>>>> +	}
>>>> +
>>>>    	if (is_vm_hugetlb_page(vma))
>>>>    		return move_hugetlb_page_tables(vma, new_vma, old_addr,
>>>>    						new_addr, len);
>>>> @@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>>>
>>>>    	mmu_notifier_invalidate_range_end(&range);
>>>>
>>>> +	/*
>>>> +	 * Prevent negative return values when {old,new}_addr was realigned
>>>> +	 * but we broke out of the above loop for the first PMD itself.
>>>> +	 */
>>>> +	if (len + old_addr < old_end)
>>>> +		return 0;
>>>> +
>>>
>>> I find this a little iffy, I mean I see that if you align [old,new]_addr to
>>> PMD, then from then on in you're relying on the fact that the loop is just
>>> going from old_addr (now aligned) -> old_end and thus has the correct
>>> length.
>>>
>>> Can't we just fix this issue by correcting len? If you take my review above
>>> which checks len in [maybe_]realign_addr(), you could take that as a
>>> pointer and equally update that.
>>>
>>> Then you can drop this check.
>>
>> The drawback of adjusting len is it changes what move_page_tables() users
>> were previously expecting.
>>
>> I think we should look at the return value of move_page_tables() as well,
>> not just len independently.
>>
>> len is what the user requested.
>>
>> "len + old_addr - old_end" is how much was actually copied and is the return value.
>>
>> If everything was copied, old_addr == old_end and len is unchanged.
> 
> Ah yeah I see, sorry I missed the fact we're returning a value, that does
> complicate things...
> 
> If we retain the hugetlb logic, then we could work around the issue with
> that instance of len by storing the 'actual length' of the range in
> a new var actual_len and passing that.
> 
> If we choose to instead just not do this for hugetlb (I wonder if the
> hugetlb handling code actually does the equivalent of this since surely
> these pages have to be handled a PMD at a time?) then we can drop the whole
> actual_len idea [see below on response to hugetlb thing].

Thanks. Yes, you are right. We should already b  good with hugetlb handling as 
it does appear that hugetlb_move_page_tables() does copy by huge_page_size(h), 
so the old_addr should already be PMD-aligned for it to be able to do that.

[..]

>>>>    	return len + old_addr - old_end;	/* how much done */
>>>>    }
>>> Also I am concerned in the hugetlb case -> len is passed to
>>> move_hugetlb_page_tables() which is now strictly incorrect, I wonder if
>>> this could cause an issue?
>>>
>>> Correcting len seems the neat way of addressing this.
>>
>> That's a good point. I am wondering if we can just change that from:
>>
>> 	if (is_vm_hugetlb_page(vma))
>> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
>> 				new_addr, len);
>>
>> to:
>> 	if (is_vm_hugetlb_page(vma))
>> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
>> 				new_addr, old_addr - new_addr);
>>
>> Or, another option is to turn it off for hugetlb by just moving:
>>
>> 	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
>> 		realign_addr(...);
>>
>> to after:
>>
>> 	if (is_vm_hugetlb_page(vma))
>> 		return move_hugetlb_page_tables(...);
>>
>> thanks,
> 
> I think the actual_len solution should sort this right? If not maybe better
> to be conservative and disable for the hugetlb case (I'm not sure if this
> would help given you'd need to be PMD aligned anyway right?), so not to
> hold up the series.
> 
> If we do decide not to include hugetlb (the endless 'special case' for so
> much code...) in this then we can drop the actual_len idea altogether.
> 
> (Yes I realise it's ironic I'm suggesting deferring to a later patch here
> but there you go ;)

;-). Considering our discussion above that hugetlb mremap addresses should 
always starts at a PMD boundary, maybe I can just add a warning to the if() like 
so to detect any potential?

	if (is_vm_hugetlb_page(vma)) {
		WARN_ON_ONCE(old_addr - old_end != len);
		return move_hugetlb_page_tables(vma, new_vma, old_addr,
						new_addr, len);
         }


Thank you so much and I learnt a lot from you and others in -mm community.

- Joel

