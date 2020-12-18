Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7328E2DEB1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 22:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLRVa7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 16:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgLRVa6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 16:30:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B4C0617A7;
        Fri, 18 Dec 2020 13:30:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608327016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQBIaQeB+KmCNpr3NLJs42/5GB9+rqiUqXXBJwHHXTA=;
        b=o6alVmX2TceBoncFKP2LvKeZz4t/g0z7srAOFKTQkIEOdOSME2WTSS34j8Kxod+4S+10sA
        kxyrqs/i9YtKMTXRmPQBC4/BJmn7KuuJGI6/fFX8be196GrM04eAZ83ow6Ho2mkMTDhVq4
        CUqL0wv/6QxuLw7Be6PH3T4+h1Yj/s5U+bkujymhormlh0CKNGbjHBeK2G4oBG5y8dZsY1
        /wAIXHRlxDaA2jzbC7LYE7zEcgVZkpSDHSO33+6EbxM8XGc8L2L6Z+O1KWa5ZiqSJds8YG
        sehAfhYSenbV2wvSGC8U74CZPwNgoooOtFptcbqC1aNozp6OuG/j4RmgDVnKZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608327016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQBIaQeB+KmCNpr3NLJs42/5GB9+rqiUqXXBJwHHXTA=;
        b=zhgamjPf5RkPLGgewtChhQyy5U4UOYxe9+Mb5hpZ7p1EybTAR2/wLGaSe6SN3/uaH5Mj9q
        t6Nb6u+tTJCFSdBQ==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <20201218194249.GE1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de> <878s9vqkrk.fsf@nanos.tec.linutronix.de> <20201218194249.GE1563847@iweiny-DESK2.sc.intel.com>
Date:   Fri, 18 Dec 2020 22:30:16 +0100
Message-ID: <873602redz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18 2020 at 11:42, Ira Weiny wrote:
> On Fri, Dec 18, 2020 at 02:57:51PM +0100, Thomas Gleixner wrote:
>>   2) Modify kmap() so that it marks the to be mapped page as 'globaly
>>      unprotected' instead of doing this global unprotect PKS dance.
>>      kunmap() undoes that. That obviously needs some thought
>>      vs. refcounting if there are concurrent users, but that's a
>>      solvable problem either as part of struct page itself or
>>      stored in some global hash.
>
> How would this globally unprotected flag work?  I suppose if kmap created a new
> PTE we could make that PTE non-PKS protected then we don't have to fiddle with
> the register...  I think I like that idea.

No. Look at the highmem implementation of kmap(). It's a terrible idea,
really. Don't even think about that.

There is _no_ global flag. The point is that the kmap is strictly bound
to a particular struct page. So you can simply do:

  kmap(page)
    if (page_is_access_protected(page))
        atomic_inc(&page->unprotect);

  kunmap(page)
    if (page_is_access_protected(page))
        atomic_dec(&page->unprotect);

and in the #PF handler:

    if (!page->unprotect)
       goto die;

The reason why I said: either in struct page itself or in a global hash
is that struct page is already packed and people are not really happy
about increasing it's size. But the principle is roughly the same.

>> 
>>   4) Have a smart #PF mechanism which does:
>> 
>>      if (error_code & X86_PF_PK) {
>>          page = virt_to_page(address);
>> 
>>          if (!page || !page_is_globaly_unprotected(page))
>>                  goto die;
>> 
>>          if (pks_mode == PKS_MODE_STRICT)
>>          	 goto die;
>> 
>>          WARN_ONCE(pks_mode == PKS_MODE_RELAXED, "Useful info ...");
>> 
>>          temporary_unprotect(page, regs);
>>          return;
>>      }
>
> I feel like this is very similar to what I had in the global patch you found in
> my git tree with the exception of the RELAXED mode.  I simply had globally
> unprotected or die.

Your stuff depends on that global_pks_state which is not maintainable
especially not the teardown side. This depends on per page state which
is clearly way simpler and more focussed.

> Regardless I think unprotecting a global context is the easy part.  The code
> you had a problem with (and I see is fully broken) was the restriction of
> access.  A failure to update in that direction would only result in a wider
> window of access.  I contemplated not doing a global update at all and just
> leave the access open until the next context switch.  But the code as it stands
> tries to force an update for a couple of reasons:
>
> 1) kmap_local_page() removes most of the need for global pks.  So I was
>    thinking that global PKS could be a slow path.
>
> 2) kmap()'s that are handed to other contexts they are likely to be 'long term'
>    and should not need to be updated 'too' often.  I will admit that I don't
>    know how often 'too often' is.

Even once in while is not a justification for stopping the world for N
milliseconds.

>>      temporary_unprotect(page, regs)
>>      {
>>         key = page_to_key(page);
>> 
>> 	/* Return from #PF will establish this for the faulting context */
>>         extended_state(regs)->pks &= ~PKS_MASK(key);
>>      }
>> 
>>      This temporary unprotect is undone when the context is left, so
>>      depending on the context (thread, interrupt, softirq) the
>>      unprotected section might be way wider than actually needed, but
>>      that's still orders of magnitudes better than having this fully
>>      unrestricted global PKS mode which is completely scopeless.
>
> I'm not sure I follow you.  How would we know when the context is
> left?

The context goes away on it's own. Either context switch or return from
interrupt. As I said there is an extended window where the external
context still might have unprotected access even if the initiating
context has called kunmap() already. It's not pretty, but it's not the
end of the world either.

That's why I suggested to have that WARN_ONCE() so we can actually see
why and where that happens and think about solutions to make this go
into local context, e.g. by changing the vaddr pointer to a struct page
pointer for these particular use cases and then the other context can do
kmap/unmap_local().

>>   5) The DAX case which you made "work" with dev_access_enable() and
>>      dev_access_disable(), i.e. with yet another lazy approach of
>>      avoiding to change a handful of usage sites.
>> 
>>      The use cases are strictly context local which means the global
>>      magic is not used at all. Why does it exist in the first place?
>
> I'm not following.  What is 'it'?

That global argument to dev_access_enable()/disable(). 

>>      That leaves the question about the refcount. AFAICT, nothing nests
>>      in that use case for a given execution context. I'm surely missing
>>      something subtle here.
>
> The refcount is needed for non-global pks as well as global.  I've not resolved
> if anything needs to be done with the refcount on the global update since the
> following is legal.
>
> kmap()
> kmap_local_page()
> kunmap()
> kunmap_local()
>
> Which would be a problem.  But I don't think it is ever actually done.

If it does not exist why would we support it in the first place? We can
have some warning there to catch that case.

> Another problem would be if the kmap and kunmap happened in different
> contexts...  :-/  I don't think that is done either but I don't know for
> certain.
>
> Frankly, my main focus before any of this global support has been to
> get rid of as many kmaps as possible.[1] Once that is done I think
> more of these questions can be answered better.

I was expecting that you could answer these questions :)

Thanks,

        tglx
