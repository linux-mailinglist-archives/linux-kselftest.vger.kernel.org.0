Return-Path: <linux-kselftest+bounces-20302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767229A90A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0737A1F2307F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5CE1E5707;
	Mon, 21 Oct 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MkbVPTGO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DjdRUKyz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MkbVPTGO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DjdRUKyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6E1DC753;
	Mon, 21 Oct 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541495; cv=none; b=r0/5Tey42svni/aSbZqkvUW20U5UJ90NeqIjkmcOrHbjB4TbEa9U/e2RVpx3spRmGYaYsVhdVVb85lqjSCI7IdI3oFz5N31H4B81DWdDmTspvWixagMXi5mI60GiT7eWemWiFeVnE88wmMTZH7a5Oo1qa0l6MOgAg+ctkOiTusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541495; c=relaxed/simple;
	bh=0AjqEPgo5YJ5UHVxYtur3XKL2rfKxw9vIRyuh25E+1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p38rJKVkSde7P2uqC5LJqhmtqtK8+VSyXHSRazFs41VOWxHgIybe3UwJtN3AI9VOF/lMUWEAs+3K+Z8s2pgkp0OQjPrGIcWrwFckPQ4C+4LecCyT/lmnb68QqsQdMEK+K8c8boabAgEWhm6c25rY5AwBUBceIuH5XQZIpAJr/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MkbVPTGO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DjdRUKyz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MkbVPTGO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DjdRUKyz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5925A21C9E;
	Mon, 21 Oct 2024 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729541490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TUHq37aNBPulYbrvIlyzG7xqO2QpErgZ+H1UXjgVmM=;
	b=MkbVPTGOHfA6KuYo4gFd9P6rIYKDt02PGyipPw+V42WPDUoFywzjKvFivgdlQNaPLQgsIH
	vi5BWbedImnNY859jKM6cvLMLGbMWxeEsxsWaIY5xJQLprvrnuncQWRtiv4aVJ8g1EXce4
	MifpAMv75Z8NGktlGXRBTiCjLtEaWmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729541490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TUHq37aNBPulYbrvIlyzG7xqO2QpErgZ+H1UXjgVmM=;
	b=DjdRUKyz/abzGentx+0Pg15Yw3WyPgqlvuUSR/X7JW7Brwq2WX2k+f/v3jkDrEGjgowR6c
	9EWptTrfGsRmTAAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MkbVPTGO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DjdRUKyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729541490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TUHq37aNBPulYbrvIlyzG7xqO2QpErgZ+H1UXjgVmM=;
	b=MkbVPTGOHfA6KuYo4gFd9P6rIYKDt02PGyipPw+V42WPDUoFywzjKvFivgdlQNaPLQgsIH
	vi5BWbedImnNY859jKM6cvLMLGbMWxeEsxsWaIY5xJQLprvrnuncQWRtiv4aVJ8g1EXce4
	MifpAMv75Z8NGktlGXRBTiCjLtEaWmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729541490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TUHq37aNBPulYbrvIlyzG7xqO2QpErgZ+H1UXjgVmM=;
	b=DjdRUKyz/abzGentx+0Pg15Yw3WyPgqlvuUSR/X7JW7Brwq2WX2k+f/v3jkDrEGjgowR6c
	9EWptTrfGsRmTAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18912139E0;
	Mon, 21 Oct 2024 20:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mt6CBXK1FmenPQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 20:11:30 +0000
Message-ID: <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
Date: Mon, 21 Oct 2024 22:11:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5925A21C9E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,HansenPartnership.com,gmx.de,zankel.net,arndb.de,chromium.org,nvidia.com];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLz1534diqmneu69wx1fp4cing)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/20/24 18:20, Lorenzo Stoakes wrote:
> Implement a new lightweight guard page feature, that is regions of userland
> virtual memory that, when accessed, cause a fatal signal to arise.
> 
> Currently users must establish PROT_NONE ranges to achieve this.
> 
> However this is very costly memory-wise - we need a VMA for each and every
> one of these regions AND they become unmergeable with surrounding VMAs.
> 
> In addition repeated mmap() calls require repeated kernel context switches
> and contention of the mmap lock to install these ranges, potentially also
> having to unmap memory if installed over existing ranges.
> 
> The lightweight guard approach eliminates the VMA cost altogether - rather
> than establishing a PROT_NONE VMA, it operates at the level of page table
> entries - poisoning PTEs such that accesses to them cause a fault followed
> by a SIGSGEV signal being raised.
> 
> This is achieved through the PTE marker mechanism, which a previous commit
> in this series extended to permit this to be done, installed via the
> generic page walking logic, also extended by a prior commit for this
> purpose.
> 
> These poison ranges are established with MADV_GUARD_POISON, and if the
> range in which they are installed contain any existing mappings, they will
> be zapped, i.e. free the range and unmap memory (thus mimicking the
> behaviour of MADV_DONTNEED in this respect).
> 
> Any existing poison entries will be left untouched. There is no nesting of
> poisoned pages.
> 
> Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
> unexpected behaviour, but are cleared on process teardown or unmapping of
> memory ranges.
> 
> Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
> 'remedying' the poisoning. The ranges over which this is applied, should
> they contain non-poison entries, will be untouched, only poison entries
> will be cleared.
> 
> We permit this operation on anonymous memory only, and only VMAs which are
> non-special, non-huge and not mlock()'d (if we permitted this we'd have to
> drop locked pages which would be rather counterintuitive).
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

<snip>

> +static long madvise_guard_poison(struct vm_area_struct *vma,
> +				 struct vm_area_struct **prev,
> +				 unsigned long start, unsigned long end)
> +{
> +	long err;
> +
> +	*prev = vma;
> +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> +		return -EINVAL;
> +
> +	/*
> +	 * If we install poison markers, then the range is no longer
> +	 * empty from a page table perspective and therefore it's
> +	 * appropriate to have an anon_vma.
> +	 *
> +	 * This ensures that on fork, we copy page tables correctly.
> +	 */
> +	err = anon_vma_prepare(vma);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Optimistically try to install the guard poison pages first. If any
> +	 * non-guard pages are encountered, give up and zap the range before
> +	 * trying again.
> +	 */

Should the page walker become powerful enough to handle this in one go? :)
But sure, if it's too big a task to teach it to zap ptes with all the tlb
flushing etc (I assume it's something page walkers don't do today), it makes
sense to do it this way.
Or we could require userspace to zap first (MADV_DONTNEED), but that would
unnecessarily mean extra syscalls for the use case of an allocator debug
mode that wants to turn freed memory to guards to catch use after free.
So this seems like a good compromise...

> +	while (true) {
> +		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> +		err = walk_page_range_mm(vma->vm_mm, start, end,
> +					 &guard_poison_walk_ops, NULL);
> +		if (err <= 0)
> +			return err;
> +
> +		/*
> +		 * OK some of the range have non-guard pages mapped, zap
> +		 * them. This leaves existing guard pages in place.
> +		 */
> +		zap_page_range_single(vma, start, end - start, NULL);

... however the potentially endless loop doesn't seem great. Could a
malicious program keep refaulting the range (ignoring any segfaults if it
loses a race) with one thread while failing to make progress here with
another thread? Is that ok because it would only punish itself?

I mean if we have to retry the guards page installation more than once, it
means the program *is* racing faults with installing guard ptes in the same
range, right? So it would be right to segfault it. But I guess when we
detect it here, we have no way to send the signal to the right thread and it
would be too late? So unless we can do the PTE zap+install marker
atomically, maybe there's no better way and this is acceptable as a
malicious program can harm only itself?

Maybe it would be just simpler to install the marker via zap_details rather
than the pagewalk?

> +
> +		if (fatal_signal_pending(current))
> +			return -EINTR;
> +		cond_resched();
> +	}
> +}
> +
> +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> +				    unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t ptent = ptep_get(pte);
> +
> +	if (is_guard_pte_marker(ptent)) {
> +		/* Simply clear the PTE marker. */
> +		pte_clear_not_present_full(walk->mm, addr, pte, false);
> +		update_mmu_cache(walk->vma, addr, pte);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops guard_unpoison_walk_ops = {
> +	.pte_entry		= guard_unpoison_pte_entry,
> +	.walk_lock		= PGWALK_RDLOCK,
> +};
> +
> +static long madvise_guard_unpoison(struct vm_area_struct *vma,
> +				   struct vm_area_struct **prev,
> +				   unsigned long start, unsigned long end)
> +{
> +	*prev = vma;
> +	/*
> +	 * We're ok with unpoisoning mlock()'d ranges, as this is a
> +	 * non-destructive action.
> +	 */
> +	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
> +		return -EINVAL;
> +
> +	return walk_page_range(vma->vm_mm, start, end,
> +			       &guard_unpoison_walk_ops, NULL);
> +}
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with its own
> @@ -1098,6 +1260,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  		break;
>  	case MADV_COLLAPSE:
>  		return madvise_collapse(vma, prev, start, end);
> +	case MADV_GUARD_POISON:
> +		return madvise_guard_poison(vma, prev, start, end);
> +	case MADV_GUARD_UNPOISON:
> +		return madvise_guard_unpoison(vma, prev, start, end);
>  	}
>  
>  	anon_name = anon_vma_name(vma);
> @@ -1197,6 +1363,8 @@ madvise_behavior_valid(int behavior)
>  	case MADV_DODUMP:
>  	case MADV_WIPEONFORK:
>  	case MADV_KEEPONFORK:
> +	case MADV_GUARD_POISON:
> +	case MADV_GUARD_UNPOISON:
>  #ifdef CONFIG_MEMORY_FAILURE
>  	case MADV_SOFT_OFFLINE:
>  	case MADV_HWPOISON:
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0c5d6d06107d..d0e3ebfadef8 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			} else if (is_pte_marker_entry(entry)) {
>  				/*
>  				 * Ignore error swap entries unconditionally,
> -				 * because any access should sigbus anyway.
> +				 * because any access should sigbus/sigsegv
> +				 * anyway.
>  				 */
>  				if (is_poisoned_swp_entry(entry))
>  					continue;
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..21bf5534bcf5 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
>  	case MADV_REMOVE:
>  	case MADV_DONTFORK:
>  	case MADV_WIPEONFORK:
> +	case MADV_GUARD_POISON:
>  		return true;
>  	}
>  


