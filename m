Return-Path: <linux-kselftest+bounces-20407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9539AB2DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB3FB252A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5FF1A76B7;
	Tue, 22 Oct 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWY593mf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PpslFFz/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChkLK7o+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCGMKk1V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8291A7066;
	Tue, 22 Oct 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612560; cv=none; b=AS+lZUfJDK939z9pLKM+Y+JQ8LdjQ7GLqKkgg6AomQg557xglP0Z1kF1EClaTh7CZftomSQdLV/MDCEMJseqikhftXn1g/C9jgbx7i8r/oJJ8vGydNiRGHMFmaQDIiPQkGp8i2LoETgKgBIkFO5L2DDXD1g2FBv16B+oNuSB+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612560; c=relaxed/simple;
	bh=qdiw+9iWWIUdBQsa8uZIUdsCsqPh/ECLmNwq+10aTbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUR3sqKekg++hTesrqItR1QJN4SSkkhFHKk+q2X+ijpsgdDED+rKWGsovVsbr8PEUBiSUA31lGOZxZy6E12wV7ds7A9CcpgMLdyS2Rioc7AZkXF+8vos2SHJNR9joARcpbQHXOhygt2lamQsqj/ekt1g3tQsIsKvWozW7pGawCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yWY593mf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PpslFFz/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChkLK7o+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCGMKk1V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFC5D1FD2A;
	Tue, 22 Oct 2024 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729612544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdiw+9iWWIUdBQsa8uZIUdsCsqPh/ECLmNwq+10aTbE=;
	b=yWY593mfxM7+fXjWrlzFpoyWifGwzGDz5T5beh+7sIhv8cDAo9AV7jaVlhz/cGkHntcUCg
	xarqy89Lw/X0ItHfgNGYHCbryc4a6DLeOddRw1KIXGVDCbtt3NwFZmeuhSo7PTgWIy4SVw
	AvNJBe/BIWu+s3x0bTK/8qOJRZTqH5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729612544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdiw+9iWWIUdBQsa8uZIUdsCsqPh/ECLmNwq+10aTbE=;
	b=PpslFFz/8aTVtMVrdRn7CxhtHZlBHHDyDyQMLZe4xz69mOiHyxlkTh0ty8MztyysIhwy2P
	BJMxzr614KJaP+Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729612543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdiw+9iWWIUdBQsa8uZIUdsCsqPh/ECLmNwq+10aTbE=;
	b=ChkLK7o+mdekXp6JBUjmsDoZrK94rdcyr/uoh0ReQNdZS/GX39UCStxeLebN2qzq6THNcl
	Q4UgzvE3YSOtW5SGNg+9iZ6fCOZXgrhLjXR4LqMu3/RVT//O8LHmDb9Y49XBrh/q7ShAnm
	oMLOVFA6VSztY6P+41f5tYxicnN93FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729612543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdiw+9iWWIUdBQsa8uZIUdsCsqPh/ECLmNwq+10aTbE=;
	b=XCGMKk1Vd0VE4kQFHxYirSe3QRx0BUxPLBY125RsCscNeQ/3vxQftsbEbCqAjl+LI/t57a
	OHAl0pOQsf2ZdbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D43B13AC9;
	Tue, 22 Oct 2024 15:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xOQkIv/KF2dBDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Oct 2024 15:55:43 +0000
Message-ID: <8f68ad82-2f60-49f8-b150-0cf183c9cc71@suse.cz>
Date: Tue, 22 Oct 2024 17:55:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when
 sealed
Content-Language: en-US
To: Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com,
 jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com,
 sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org,
 gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com,
 merimus@google.com, rdunlap@infradead.org, stable@vger.kernel.org
References: <20241017005105.3047458-1-jeffxu@chromium.org>
 <20241017005105.3047458-2-jeffxu@chromium.org>
 <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
 <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com>
 <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
 <CABi2SkXArA+yfodoOxDbTTOpWCbU5Ce1p1HadSo0=CL23K4-dQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CABi2SkXArA+yfodoOxDbTTOpWCbU5Ce1p1HadSo0=CL23K4-dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[chromium.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/17/24 22:57, Jeff Xu wrote:
> On Thu, Oct 17, 2024 at 1:49 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
>> >
>> > > > For file-backed, private, read-only memory mappings, we previously did
>> > > > not block the madvise(MADV_DONTNEED). This was based on
>> > > > the assumption that the memory's content, being file-backed, could be
>> > > > retrieved from the file if accessed again. However, this assumption
>> > > > failed to consider scenarios where a mapping is initially created as
>> > > > read-write, modified, and subsequently changed to read-only. The newly
>> > > > introduced VM_WASWRITE flag addresses this oversight.
>> > >
>> > > We *do not* need this. It's sufficient to just block discard operations on read-only
>> > > private mappings.
>> > I think you meant blocking madvise(MADV_DONTNEED) on all read-only
>> > private file-backed mappings.
>> >
>> > I considered that option, but there is a use case for madvise on those
>> > mappings that never get modified.
>> >
>> > Apps can use that to free up RAM. e.g. Considering read-only .text
>> > section, which never gets modified, madvise( MADV_DONTNEED) can free
>> > up RAM when memory is in-stress, memory will be reclaimed from a
>> > backed-file on next read access. Therefore we can't just block all
>> > read-only private file-backed mapping, only those that really need to,
>> > such as mapping changed from rw=>r (what you described)
>>
>> Does anyone actually do this? If so, why? WHYYYY?
>>
> This is a legit use case, I can't argue that it isn't.

Could the same effect be simply achieved with MADV_COLD/MADV_PAGEOUT? That
should be able to reclaim the pages as well if they are indeed not used, but
it's non-destructive and you don't want to allow destructive madvise anyway
(i.e. no throwing away data that would be replaced by zeroes or original
file content on the next touch) so it seems overall a better fit for sealed
areas?



