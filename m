Return-Path: <linux-kselftest+bounces-20710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365769B11D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A078EB21476
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684920C32C;
	Fri, 25 Oct 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSUHN1JR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePvB/2C+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0SSZIC8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoh0sLnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4425217F4C;
	Fri, 25 Oct 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892702; cv=none; b=nCJw/goOlm8SoEecFcKknZKtONwz/u2kZywoWg/ENxWdj07ptG2kSkBMb42txIprKIhDkmznRWr2B5c9ae7tTD+YpK4PIUAqpUbQTrd9+iH2tMkZJ6xjWYYvhFKb4u2fj/Asm4EYWjhIbEYj8/e9tTAtF6Kx52X7ijCho8Eij5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892702; c=relaxed/simple;
	bh=7cpHCGz70pl2I6jwn6GKzELJ0Sz+df5Ozl1FrWTZgyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq8jcgEPisd06Y+352eBuG/yodIswPrv1K3Cp9oLNhPtp9cQZvBmbmv3y4l8ZEalvKsWaKvatdG0jQfTdskLoGH1C8QH2bz7zRlPv/r7d0hwoBXQiEIqy8bAVyz/jc/gj6p2FXU1+hCLvCwoZ1JW2VAhtYeK5ScIY5NxdiM78Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSUHN1JR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePvB/2C+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0SSZIC8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoh0sLnm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D10D321CFE;
	Fri, 25 Oct 2024 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729892698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cxCBDLDsjsRmWTodkxgqSQhPE4jsteJg/X0cnhzrBpw=;
	b=hSUHN1JRlHqGH4u/LWCRh77mA9FJkAWSjw8ylSJPJHq1xJXVnBf3PGu7m3ZYpMPzgdh9kU
	cbpkaYgqf/PR9sS9zaU8WHzP/HcEzz1M4ysBCfFXoh+hfLqXyjrkMyBNkyI9+wkLgxMuQ6
	PgFZFfwmIWA5b44xpF4Ej0y9FjgOmMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729892698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cxCBDLDsjsRmWTodkxgqSQhPE4jsteJg/X0cnhzrBpw=;
	b=ePvB/2C+7W6L1xEpXJ1TWO3l4lWBGJ4pwFK1HktRXSaJODVo9dzJGtoYGo6D0Zzo11irRn
	icogB9D24vUXxGCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729892697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cxCBDLDsjsRmWTodkxgqSQhPE4jsteJg/X0cnhzrBpw=;
	b=Z0SSZIC8tWulFfGuhjFOYMIBW+G0NWRQzmEgtsrGWCQ7CMhIQ8nQVPiR+8mRCZbBb4voz2
	4XLw5qIWCKrDoBVEDF5I+3B9Zgox8ZMSsvQD7lgHf3ED2ERzlHPP7CgqOX66P9k1YCgH0J
	9my6bIheSewQCgi9awIAJrP0aPVCJkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729892697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cxCBDLDsjsRmWTodkxgqSQhPE4jsteJg/X0cnhzrBpw=;
	b=eoh0sLnmHDK+kLpsBDvGP1/Js6vJfCN+h5TF/wZftuCSalw9ZbfMDUGoYVNfKHts9EhhAX
	kYSPDcY3x0Fd2qCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B6B136E4;
	Fri, 25 Oct 2024 21:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BSAiL1gRHGfAWAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 21:44:56 +0000
Message-ID: <0ed7b766-1e7d-4f77-bf5a-bfa52d36ca8e@suse.cz>
Date: Fri, 25 Oct 2024 23:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
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
 Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,gmail.com,alpha.franken.de,HansenPartnership.com,gmx.de,zankel.net,chromium.org,nvidia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3py1j7x8bxoj6nr7eaeb97sq)]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/23/24 18:24, Lorenzo Stoakes wrote:
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
> entries - establishing PTE markers such that accesses to them cause a fault
> followed by a SIGSGEV signal being raised.
> 
> This is achieved through the PTE marker mechanism, which we have already
> extended to provide PTE_MARKER_GUARD, which we installed via the generic
> page walking logic which we have extended for this purpose.
> 
> These guard ranges are established with MADV_GUARD_INSTALL. If the range in
> which they are installed contain any existing mappings, they will be
> zapped, i.e. free the range and unmap memory (thus mimicking the behaviour
> of MADV_DONTNEED in this respect).
> 
> Any existing guard entries will be left untouched. There is therefore no
> nesting of guarded pages.
> 
> Guarded ranges are NOT cleared by MADV_DONTNEED nor MADV_FREE (in both
> instances the memory range may be reused at which point a user would expect
> guards to still be in place), but they are cleared via MADV_GUARD_REMOVE,
> process teardown or unmapping of memory ranges.
> 
> The guard property can be removed from ranges via MADV_GUARD_REMOVE. The
> ranges over which this is applied, should they contain non-guard entries,
> will be untouched, with only guard entries being cleared.
> 
> We permit this operation on anonymous memory only, and only VMAs which are
> non-special, non-huge and not mlock()'d (if we permitted this we'd have to
> drop locked pages which would be rather counterintuitive).
> 
> Racing page faults can cause repeated attempts to install guard pages that
> are interrupted, result in a zap, and this process can end up being
> repeated. If this happens more than would be expected in normal operation,
> we rescind locks and retry the whole thing, which avoids lock contention in
> this scenario.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -423,6 +423,12 @@ extern unsigned long highest_memmap_pfn;
>   */
>  #define MAX_RECLAIM_RETRIES 16
>  
> +/*
> + * Maximum number of attempts we make to install guard pages before we give up
> + * and return -ERESTARTNOINTR to have userspace try again.
> + */
> +#define MAX_MADVISE_GUARD_RETRIES 3

Can't we simply put this in mm/madvise.c ? Didn't find usage elsewhere.



