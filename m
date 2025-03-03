Return-Path: <linux-kselftest+bounces-28019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F5A4BACB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774BA170AFF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1BB1F1501;
	Mon,  3 Mar 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="suFG/FlY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8FprFIt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="suFG/FlY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8FprFIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0681F0E52
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994180; cv=none; b=T/GxEE1TwRcCQJqV3OkXvkAefW4TTupIyg7VTTneErWM9Nk+GcL7aHH6AQRBSuM5BLnCxBEcyNNK/HbW0LV8bOlKvFH2n6hK0uud0aPE6FeZDHqzMtKjs2p5g0o/SBMv38oKiR8atYATfQybJphGZcRCBlzLSiun6Ei0hABj7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994180; c=relaxed/simple;
	bh=9Cbkt6zSkkx3XsqzbnzOWO/5wx0/MMZJ8cnKPDT1DwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz8f2bIxiOyBd9KqH3n9q/OQKHuUoDjBsVaBiSnAGM5nvEfbHLZE7kV6U04Uq1WlLitS8MIoFUwquqqCMSG7SbGGWRcgTdL9HerZ2uwfsJeTObUy/sUFiQPW1rOleVkvYpILJK6WwwF+DuBuYcBUQfHhDtRrI0CgkaOOCxoQzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=suFG/FlY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8FprFIt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=suFG/FlY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8FprFIt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9737A2116B;
	Mon,  3 Mar 2025 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740994175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k20e0qHL6dXusoDcwpaKQhA8JbIFxFlDyPMo74Hll8Y=;
	b=suFG/FlYmMKcbVomcogtNbITCCy7ix5NnqSD8V5LAedrCCBP3DdQx3zv7/xkvsVYY6jb15
	FdmtwEdXsAfuIHBitriasDfW6qpNs1WV9ryqfIlojgg3tqme5wsyvAZUlvx6JP/xG4F8dm
	Ip7SNiKvp3zfo+eOgpcrOV2hvOsGpTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740994175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k20e0qHL6dXusoDcwpaKQhA8JbIFxFlDyPMo74Hll8Y=;
	b=B8FprFItVpmkhESKHSrsJp0b4ojWcAjtS0PIkiIuktfOgQyT3sWPlR9cur7f30G2Tfl9UO
	M9L7EPWLwk0fyoDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="suFG/FlY";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B8FprFIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740994175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k20e0qHL6dXusoDcwpaKQhA8JbIFxFlDyPMo74Hll8Y=;
	b=suFG/FlYmMKcbVomcogtNbITCCy7ix5NnqSD8V5LAedrCCBP3DdQx3zv7/xkvsVYY6jb15
	FdmtwEdXsAfuIHBitriasDfW6qpNs1WV9ryqfIlojgg3tqme5wsyvAZUlvx6JP/xG4F8dm
	Ip7SNiKvp3zfo+eOgpcrOV2hvOsGpTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740994175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k20e0qHL6dXusoDcwpaKQhA8JbIFxFlDyPMo74Hll8Y=;
	b=B8FprFItVpmkhESKHSrsJp0b4ojWcAjtS0PIkiIuktfOgQyT3sWPlR9cur7f30G2Tfl9UO
	M9L7EPWLwk0fyoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43C9613A61;
	Mon,  3 Mar 2025 09:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ML9YD392xWc1BQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Mar 2025 09:29:35 +0000
Message-ID: <12b82997-0129-4fef-afc0-e925e542be88@suse.cz>
Date: Mon, 3 Mar 2025 10:29:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] mm: introduce AS_NO_DIRECT_MAP
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Patrick Roy <roypat@amazon.co.uk>,
 rppt@kernel.org, seanjc@google.com
Cc: pbonzini@redhat.com, corbet@lwn.net, willy@infradead.org,
 akpm@linux-foundation.org, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 jannh@google.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tabba@google.com, jgowans@amazon.com,
 graf@amazon.com, kalyazin@amazon.com, xmarcalx@amazon.com,
 derekmn@amazon.com, jthoughton@google.com
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-2-roypat@amazon.co.uk>
 <3dc4bb80-0beb-4bbb-bfd8-47fc096f70e9@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <3dc4bb80-0beb-4bbb-bfd8-47fc096f70e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9737A2116B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,infradead.org,linux-foundation.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,oracle.com,vger.kernel.org,kvack.org,amazon.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLo3k5aap4ysuunujcz1d3qjj5)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 17:52, David Hildenbrand wrote:
> On 21.02.25 17:07, Patrick Roy wrote:
>> Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
>> set to not present . Currently, mappings that match this description are
>> secretmem mappings (memfd_secret()). Later, some guest_memfd
>> configurations will also fall into this category.
>> 
>> Reject this new type of mappings in all locations that currently reject
>> secretmem mappings, on the assumption that if secretmem mappings are
>> rejected somewhere, it is precisely because of an inability to deal with
>> folios without direct map entries.
>> 
>> Use a new flag instead of overloading AS_INACCESSIBLE (which is already
>> set by guest_memfd) because not all guest_memfd mappings will end up
>> being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
>> can be mapped to userspace should also be GUP-able, and generally not
>> have restrictions on who can access it).
>> 
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>> ---
> 
> ...
> 
>>   static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>>   {
>>   	return mapping->gfp_mask;
>> diff --git a/lib/buildid.c b/lib/buildid.c
>> index c4b0f376fb34..80b5d805067f 100644
>> --- a/lib/buildid.c
>> +++ b/lib/buildid.c
>> @@ -65,8 +65,8 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
>>   
>>   	freader_put_folio(r);
>>   
>> -	/* reject secretmem folios created with memfd_secret() */
>> -	if (secretmem_mapping(r->file->f_mapping))
>> +	/* reject secretmem folios created with memfd_secret() or guest_memfd() */
>> +	if (secretmem_mapping(r->file->f_mapping) || mapping_no_direct_map(r->file->f_mapping))
>>   		return -EFAULT;
> 
> Maybe I'm missing it, but why do we have to special-case secretmem with 
> that at all anymore?
> 
> Couldn't we just let secretmem set AS_NO_DIRECT_MAP as well, and convert 
> all/most secretmem specific stuff to check AS_NO_DIRECT_MAP as well?

That's done in patch 02. But yeah, squashing them together would reduce some
churn. I guess because it removes some !IS_ENABLED(CONFIG_SECRETMEM)
optimizations, a separate change for review was preferred.



