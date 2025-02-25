Return-Path: <linux-kselftest+bounces-27472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33DBA44503
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F77AC3F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D432D1624DD;
	Tue, 25 Feb 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTcX3Vfh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3j6myiMX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTcX3Vfh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3j6myiMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDC155757
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498866; cv=none; b=Frxs/HMcBT+EZhpSOAES1Mzs9TeRF+3xFjF7McDXj5wxcu3oFMyInI6U/9pf0r8XIeor61YrBHRR9NnrxF/Jj0wK9HVRUFA2Zm/I48P3bbxjh0Qu1yTjL6uYgrlcjXJqDSqJBAkVIEivX+2D7ZU02QAMgzWPSZC6EBwqt65i3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498866; c=relaxed/simple;
	bh=siMjE7KE9lqHRtIJmfA4/PmU8WGku/thbzmfXPBq+iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmhxW1wHUHB//dZnaVPrYPSCp6VrrrtgJYe0fzgd2uoIalPWXXeF20v1KqEPLX9Vc51GdxR9DamBC9mER1ce72W13+gTjGVK9iQ+/OZjT3FbjFlPrbJMXV/DDwGjnVDfqrioYSXm5gtzK0O+FpLeZLRx/bLjGs/r6/nGkoyBNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTcX3Vfh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3j6myiMX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTcX3Vfh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3j6myiMX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A84C1F455;
	Tue, 25 Feb 2025 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740498863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lBYuAw66CA3JfHfUK9Bjsw6IqRY+91rrORHN8kXl2pA=;
	b=oTcX3VfhbE0TjL1fIL40szodu8FLIzpUXngT5EubANsyGFeX0mSWBI1L8is3B4zLnDr/j8
	w81/Q0f8g32T8T7YSl70HxM8Eqmz6wwAy4yepQNymejEKNlMn5LcOaUCXTV36iafzLqhCy
	xpBiRx4vRganm1CbTDlL3pOBpGbWsgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740498863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lBYuAw66CA3JfHfUK9Bjsw6IqRY+91rrORHN8kXl2pA=;
	b=3j6myiMXbz1GED977Dyje9fnBRxL6kjioXdSfitS8ndiNTRPS/p+1KqDQZlqhMOgY2Nyvc
	iiqZlI6Oub+WtkAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oTcX3Vfh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3j6myiMX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740498863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lBYuAw66CA3JfHfUK9Bjsw6IqRY+91rrORHN8kXl2pA=;
	b=oTcX3VfhbE0TjL1fIL40szodu8FLIzpUXngT5EubANsyGFeX0mSWBI1L8is3B4zLnDr/j8
	w81/Q0f8g32T8T7YSl70HxM8Eqmz6wwAy4yepQNymejEKNlMn5LcOaUCXTV36iafzLqhCy
	xpBiRx4vRganm1CbTDlL3pOBpGbWsgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740498863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lBYuAw66CA3JfHfUK9Bjsw6IqRY+91rrORHN8kXl2pA=;
	b=3j6myiMXbz1GED977Dyje9fnBRxL6kjioXdSfitS8ndiNTRPS/p+1KqDQZlqhMOgY2Nyvc
	iiqZlI6Oub+WtkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35AAB13332;
	Tue, 25 Feb 2025 15:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vp/CDK/nvWcfMwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Feb 2025 15:54:23 +0000
Message-ID: <e0954e13-2c7d-447c-ba86-19875c74bc3b@suse.cz>
Date: Tue, 25 Feb 2025 16:54:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
 <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5A84C1F455
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/18/25 18:28, Lorenzo Stoakes wrote:
> On Tue, Feb 18, 2025 at 06:25:35PM +0100, David Hildenbrand wrote:
>>
>> > > >
>> > > > It fails because it tries to 'touch' the memory, but 'touching' guard
>> > > > region memory causes a segfault. This kind of breaks the idea of
>> > > > mlock()'ing guard regions.
>> > > >
>> > > > I think adding workarounds to make this possible in any way is not really
>> > > > worth it (and would probably be pretty gross).
>> > > >
>> > > > We already document that 'mlock()ing lightweight guard regions will fail'
>> > > > as per man page so this is all in line with that.
>> > >
>> > > Right, and I claim that supporting VM_LOCKONFAULT might likely be as easy as
>> > > allowing install/remove of guard regions when that flag is set.
>> >
>> > We already allow this flag! VM_LOCKED and VM_HUGETLB are the only flags we
>> > disallow.
>>
>>
>> See mlock2();
>>
>> SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>> {
>> 	vm_flags_t vm_flags = VM_LOCKED;
>>
>> 	if (flags & ~MLOCK_ONFAULT)
>> 		return -EINVAL;
>>
>> 	if (flags & MLOCK_ONFAULT)
>> 		vm_flags |= VM_LOCKONFAULT;
>>
>> 	return do_mlock(start, len, vm_flags);
>> }
>>
>>
>> VM_LOCKONFAULT always as VM_LOCKED set as well.
> 
> OK cool, that makes sense.
> 
> As with much kernel stuff, I knew this in the past. Then I forgot. Then I knew
> again, then... :P if only somebody would write it down in a book...
> 
> Yeah then that makes sense to check explicitly for (VM_LOCKED | VM_LOCKONFAULT)
> in any MADV_GUARD_INSTALL_LOCKED variant as obviously this would be passively
> excluded right now.

Sorry for the late reply. So AFAIU from your conversations, guards can't be
compatible with VM_LOCKED, which means e.g. any attempts of glibc to use
guards for stacks will soon discover that mlockall() users exist and are
broken by this, and the attempts will fail? That's a bummer.

As for compatibility with VM_LOCKONFAULT, do we need a new
MADV_GUARD_INSTALL_LOCKED or can we say MADV_GUARD_INSTALL is new enough
that it can be just retrofitted (like you retrofit file backed mappings)?
AFAIU the only risk would be breaking somebody that already relies on a
failure for VM_LOCKONFAULT, and it's unlikely there's such a somebody now.



