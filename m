Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE633046AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbhAZRVk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jan 2021 12:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390726AbhAZI7G (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jan 2021 03:59:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A1B229C4;
        Tue, 26 Jan 2021 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611651431;
        bh=3dgUnP8aJ1eg4nORcRJtC2l55XdTih1ZiktWTkuQgN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSPJ+2FNgJy9vX8TwuFtwlJ4BJGqjUsMVwz5vKSBR+DobJHY/hllcDCu+vsFJxOfA
         PtkBWbLVoKefAGzdw4tyPia/jf4/w/CTdqHUVcVPQYf8O6K/yO3n8YH3+6Qdp/WX2S
         3kpUytNDMZHdzYJVTeOCy1th0H1D8f7O80nUrqwGjIsLbS4pp10nhROJcxxrWQAvfI
         8rjhyrPOGkxeS0hfiSW+pq2m1eEQO7Dad0uLwiHZ3KfYXTJUzK2DuHM2u3gAHO+f+q
         ugk4X5eb03lt2fccryhj8VWMjQNpJj9IPEsXSd0j6TsD/IowA22eEkV42dAFy7PBId
         8LtfF1A42mNbA==
Date:   Tue, 26 Jan 2021 10:56:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210126085654.GO6332@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
 <20210126073142.GY827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126073142.GY827@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 26, 2021 at 08:31:42AM +0100, Michal Hocko wrote:
> On Mon 25-01-21 23:38:17, Mike Rapoport wrote:
> > On Mon, Jan 25, 2021 at 05:54:51PM +0100, Michal Hocko wrote:
> > > On Thu 21-01-21 14:27:20, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > > when the memory is actually allocated and freed.
> > > 
> > > What does this mean?
> > 
> > That means that the accounting is updated when secretmem does cma_alloc()
> > and cma_relase().
> > 
> > > What are the lifetime rules?
> > 
> > Hmm, what do you mean by lifetime rules?
> 
> OK, so let's start by reservation time (mmap time right?) then the
> instantiation time (faulting in memory). What if the calling process of
> the former has a different memcg context than the later. E.g. when you
> send your fd or inherited fd over fork will move to a different memcg.
> 
> What about freeing path? E.g. when you punch a hole in the middle of
> a mapping?
> 
> Please make sure to document all this.
 
So, does something like this answer your question:

---
The memory cgroup is charged when secremem allocates pages from CMA to
increase large pages pool during ->fault() processing.
The pages are uncharged from memory cgroup when they are released back to
CMA at the time secretme inode is evicted.
---

> > > [...]
> > > 
> > > > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > > > +{
> > > > +	int err;
> > > > +
> > > > +	err = memcg_kmem_charge_page(page, gfp, order);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	/*
> > > > +	 * seceremem caches are unreclaimable kernel allocations, so treat
> > > > +	 * them as unreclaimable slab memory for VM statistics purposes
> > > > +	 */
> > > > +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> > > > +			      PAGE_SIZE << order);
> > > 
> > > A lot of memcg accounted memory is not reclaimable. Why do you abuse
> > > SLAB counter when this is not a slab owned memory? Why do you use the
> > > kmem accounting API when __GFP_ACCOUNT should give you the same without
> > > this details?
> > 
> > I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> 
> Other people are working on this to change. But OK, I do see that this
> can be done later but it looks rather awkward.
> 
> > Besides, kmem accounting with __GFP_ACCOUNT does not seem
> > to update stats and there was an explicit request for statistics:
> >  
> > https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> 
> charging and stats are two different things. You can still take care of
> your stats without explicitly using the charging API. But this is a mere
> detail. It just hit my eyes.
> 
> > As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> > 
> > https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> 
> Those arguments should be a part of the changelof.
> 
> > I think that a dedicated stats counter would be too much at the moment and
> > NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.
> 
> Why do you think it would be too much? If the secret memory becomes a
> prevalent memory user because it will happen to back the whole virtual
> machine then hiding it into any existing counter would be less than
> useful.
> 
> Please note that this all is a user visible stuff that will become PITA
> (if possible) to change later on. You should really have strong
> arguments in your justification here.

I think that adding a dedicated counter for few 2M areas per container is
not worth the churn. 

When we'll get to the point that secretmem can be used to back the entire
guest memory we can add a new counter and it does not seem to PITA to me.

-- 
Sincerely yours,
Mike.
