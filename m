Return-Path: <linux-kselftest+bounces-45204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B0C445A4
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F5E3A82AE
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8023496F;
	Sun,  9 Nov 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sjj8Tmj8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIf/Vc1e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sjj8Tmj8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIf/Vc1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30802367DF
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Nov 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715473; cv=none; b=ArvrpH5RSuoLxyoO+AuDZdXR6PZu/hfCOZyMXusa9p764tGk0WE16ngmI/uSeR5fnMOZOd3fqZ16eMCQabqcGanbLw2SMc0L8PBa1+8eExZxjazl4o7YOknzWRA1HKP5MBubCidJKXqHMlwCpXP7fOFWAMi85wocMpQIfojo1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715473; c=relaxed/simple;
	bh=zNGgOq6uu5sBukeaWlKEEco/Nz+foneBJ3sqjqWHrL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs25ew51s80z2bt6sQEhSLGSLTie4MLzcq2t/pKJb1WZ4DE9WvcKUiqBZ618Eko5Am3XqDBsf7HX4EuHyXbO2cvVrPJJO6xeL2gp4h/W0dads6+hpWsFRTpYf+A64di0deafrrEcbpB8Jatkrxmk7++rRhenpu9RyxcVZXMpyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sjj8Tmj8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIf/Vc1e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sjj8Tmj8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIf/Vc1e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C304622B75;
	Sun,  9 Nov 2025 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762715469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qX9lJAeqWuZ+tZhf9D+6OWeGPK1zBp473L1ubEGFTno=;
	b=Sjj8Tmj8te78EcciPx4vbEFIaaUYrlCsTNtCM7lpeMmq/UkH9LUMD2IRGUDK5ViIZx/qrw
	OhU6yjzIi49h2Mzz8VvDLXRxNDdz6PGRzytxL5Oek0QzdHqPtVJqcfNuRG1V4+ALGrJ4NU
	tBjY+5hv1ruMaxKOiNSTkoSvfbIjZdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762715469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qX9lJAeqWuZ+tZhf9D+6OWeGPK1zBp473L1ubEGFTno=;
	b=AIf/Vc1eF+LE48PBOj4Ivn9c86r5GC6pqubLqgzOfWXwF20vYgoBaETOO08B/RcdT9CkXl
	wI1aG0oFTDdHS0CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762715469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qX9lJAeqWuZ+tZhf9D+6OWeGPK1zBp473L1ubEGFTno=;
	b=Sjj8Tmj8te78EcciPx4vbEFIaaUYrlCsTNtCM7lpeMmq/UkH9LUMD2IRGUDK5ViIZx/qrw
	OhU6yjzIi49h2Mzz8VvDLXRxNDdz6PGRzytxL5Oek0QzdHqPtVJqcfNuRG1V4+ALGrJ4NU
	tBjY+5hv1ruMaxKOiNSTkoSvfbIjZdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762715469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qX9lJAeqWuZ+tZhf9D+6OWeGPK1zBp473L1ubEGFTno=;
	b=AIf/Vc1eF+LE48PBOj4Ivn9c86r5GC6pqubLqgzOfWXwF20vYgoBaETOO08B/RcdT9CkXl
	wI1aG0oFTDdHS0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F9D7140AC;
	Sun,  9 Nov 2025 19:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RoarJU3nEGlMWAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 09 Nov 2025 19:11:09 +0000
Message-ID: <a7034e0c-a2ab-425a-8472-ef0a87a17681@suse.cz>
Date: Sun, 9 Nov 2025 20:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org> <aQyOZ6eYng-IjxS_@fedora>
 <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
 <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>
 <aRA6lEQmmrvmj2DX@kernel.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aRA6lEQmmrvmj2DX@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,oracle.com,google.com,suse.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 11/9/25 07:54, Mike Rapoport wrote:
> (added Nathan for clang advice)
> 
> On Fri, Nov 07, 2025 at 04:08:55PM -0800, Andrew Morton wrote:
>> On Fri, 7 Nov 2025 10:27:27 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
>> 
>> > On 06.11.25 13:02, Ankit Khushwaha wrote:
>> > > On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
>> > >> On 06.11.25 11:49, Ankit Khushwaha wrote:
>> > >>> Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
>> > >>> triggers following warning:
>> > >>>
>> > >>> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
>> > >>> false [-Wtautological-compare]
>> > >>>    1035 |                 if (addr + c.dest_alignment < addr) {
>> > >>>         |                                             ^
>> > >>>
>> > >>> typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
>> > >>
>> > >> With which compiler are you seeing this?
>> > > 
>> > > Hi David,
>> > > 
>> > > clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.
>> > > 
>> > > To reproduce:
>> > > 	make -C tools/testing/selftests/mm CC=clang
>> > 
>> > Thanks, and thanks to Lorenzo for the details.
>> > 
>> > Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> 
>> I must say, applying this would be an unhappy life event.
>> 
>> 	if (void* + ulong < void*)
>> 
>> makes perfect sense in a world which permits void* arithmetic (ie,
>> ours).  So what the heck is clang doing??

My (not very informed) guess would be something about undefined behavior
because pointer arithmetic is strictly speaking only valid within an array,
so void* + ulong is also still in the same array, and thus can't become
smaller by an overflow, because overflow can't happen if we're still within
the same valid array...

But I don't know if this strictness is only applied to the warning itself or
to the actual compilation too (does it eliminate everything as dead code then?)

>> If we do
>> 
>> 	void *addr2 = addr + c.dest_alignment;
>> 	if (addr2 < addr)
>> 		...
>> 
>> then which statement warns, and why?

As the answer was that nothing warns, I'd think it just isn't able to warn
if it's no longer part of the same statement. Whether it also means it's not
eliminated as dead code anymore, dunno.


