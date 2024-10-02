Return-Path: <linux-kselftest+bounces-18906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21D98DD48
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147A4284D9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38941D0E27;
	Wed,  2 Oct 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="12Zr4U0Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P4KgZGbb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zc1cPzkM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="12RJnV0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01991D014A;
	Wed,  2 Oct 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880289; cv=none; b=DAXt2kGl67fgJazsjhedvaYm56/V8hBXO3m6QQskru3wtHJzAHh81n9UWVlMJeHfhC95k3PXqKpeqAmSSZZmq1rxJ/A3GThfbRhS8qvoZYzn6chzI6KD/e0cF2Hi0lWXWNab+P+aqCUbmxHkS4hmPku0eJG6muiNz9qG9SBhXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880289; c=relaxed/simple;
	bh=xbMRWafQtWcsHPkcRwW4rObd+QgE2P8G83Na5STTNxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJb+tl+UExFi6vwtnhmVVmPUS02OcPpEip8bmNHIbCcRB8zX2cnT/ccBeaM0rBy+jMNC7s6xAZL5EqU98wONziBxgDI2AAUD4y+S52g5XYMx+dnW4unwuDxTXd7Qt3gt9aNb4IXJAGFYo3M+nUWabn8INJQc3m/XXEBQhjtJ0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=12Zr4U0Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P4KgZGbb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zc1cPzkM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=12RJnV0w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6475219EE;
	Wed,  2 Oct 2024 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727880286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Belre76DL6h+0gD4JiFxLhRUZh4NO1hWWD43NEdumV4=;
	b=12Zr4U0Q7vibjRo0oZ9RaWG1aO5DJoaUW+ryILL8JL5958QC7tIDvRfyHu2axT/jN6pzUe
	oegWOM2YWeyUOJ8mPBj46Ujxrfl23VjiGOBdEwdtvX6HikIhSHtJ/th7gSwW0frKzAtccL
	tlFgXLPKkTn/jrOOgU3YUu/oxwGM8kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727880286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Belre76DL6h+0gD4JiFxLhRUZh4NO1hWWD43NEdumV4=;
	b=P4KgZGbbiC8yYmw5t6DljUj6bq2eV4H/K+x/wQtn5DY0jaB18QLR1vFsJ9fdJQO+n2bGx6
	wyBXZINzLL46JKDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zc1cPzkM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=12RJnV0w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727880285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Belre76DL6h+0gD4JiFxLhRUZh4NO1hWWD43NEdumV4=;
	b=Zc1cPzkMWSQBnSQN0xZUR/ZMkuow81+byG5pv/cATuO4h1NmOTRhgZc9OBTQzNa74Uh7Rb
	mgYDaDQLUL6uFNrgsc6No49rp3q+HZohKp56hnr+/Xb552Us7OsSFegHE2Kg/FV7b8DpPy
	HU+evWluNzba/WJ1HqjCqhM3H5bWNpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727880285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Belre76DL6h+0gD4JiFxLhRUZh4NO1hWWD43NEdumV4=;
	b=12RJnV0wVUR5bFbvcRnM6w3GrBLoKKIljoSl1DzuC780vlBrUaYFS4mduMJDA0oiA9C2v9
	StK2Uu+tBCkcmMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC31A13A6E;
	Wed,  2 Oct 2024 14:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d7tiLV1c/WYyNwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 14:44:45 +0000
Message-ID: <7f18cd71-4a4a-4d29-beb4-33f6d9fe3c12@suse.cz>
Date: Wed, 2 Oct 2024 16:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab hotfixes v2 2/2] slub/kunit: skip test_kfree_rcu when
 the slub kunit test is built-in
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 rcu@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
References: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
 <20241001-b4-slub-kunit-fix-v2-2-2d995d3ecb49@suse.cz>
 <80d0cd70-c00a-475c-a028-e842fb86403b@suse.cz>
 <87f2fe09-ba6a-4405-b716-5325bb6a223b@roeck-us.net>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <87f2fe09-ba6a-4405-b716-5325bb6a223b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E6475219EE
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,kernel.org,google.com,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/2/24 15:52, Guenter Roeck wrote:
> On 10/2/24 03:26, Vlastimil Babka wrote:
>> On 10/1/24 18:20, Vlastimil Babka wrote:
>>> Guenter Roeck reports that the new slub kunit tests added by commit
>>> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
>>> test_leak_destroy()") cause a lockup on boot on several architectures
>>> when the kunit tests are configured to be built-in and not modules.
>>>
>>> The test_kfree_rcu test invokes kfree_rcu() and boot sequence inspection
>>> showed the runner for built-in kunit tests kunit_run_all_tests() is
>>> called before setting system_state to SYSTEM_RUNNING and calling
>>> rcu_end_inkernel_boot(), so this seems like a likely cause. So while I
>>> was unable to reproduce the problem myself, skipping the test when the
>>> slub_kunit module is built-in should avoid the issue.
>>>
>>> An alternative fix that was moving the call to kunit_run_all_tests() a
>>> bit later in the boot was tried, but has broken tests with functions
>>> marked as __init due to free_initmem() already being done.
>>>
>>> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
>> 
>> I hope you can confirm it helps, because the commit added two tests and I've
>> only skipped one of them, as it's the one using kfree_rcu(), which is
>> suspected. But the other is responsible for the (now suppressed)
>> kmem_cache_destroy() warning, and maybe I'm missing something and it was
>> actually that one causing the lockups.
>> 
> 
> Everything works with your patches applied, so we are good.

Thanks for testing! Queued for -next now and will send to Linus later if
all's good.

>> Since you mentioned the boot lockups happened on some x86_64 too, do you
>> have a .config of the lockup case? I've tried tweaking some rcu options but
>> still nothing.
>> 
> 
> I have a bunch of debug options enabled. Configuration (generated using
> "make savedefconfig") for x86_64 is attached.

Hmm, didn't see the hang with that (using virtme-ng) on v6.12-rc1. Guess
there's something more to it. Oh well.

> Thanks,
> Guenter


