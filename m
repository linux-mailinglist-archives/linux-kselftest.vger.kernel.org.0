Return-Path: <linux-kselftest+bounces-18892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7B98D126
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 12:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702061F22EFB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF311E6309;
	Wed,  2 Oct 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tzDfN0CR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1WomHnh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tzDfN0CR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1WomHnh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D462564;
	Wed,  2 Oct 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864797; cv=none; b=boflfhP4Pm8aDCC1xYHNjsEpAGIMxj/0VyFlz/Os7m3NlMh3uIBVeuGoKK3V6LBI6Z/MbRzQTidpOnhfdZaJX6gFkuPrU4P6xchlFa3OnC7OXYYCsTx/s5FRVomyQmQlowLTxASZFFzF4q7LtqHou8vawoV0FmyUmXohZYQHTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864797; c=relaxed/simple;
	bh=yOaoxJMVmNsnw32EFtdnzzpiTusgvtyyoSVfzuJO1bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEastlFb9+4Cc+zW8PYAYsZobWWL8JmZPmGRj/I9fDvKbW+EcT+CtwwiWXoy90ZzW0XCunyzWmZtoAVQrv3iuIW/NXEhi6WUi45jQeq+46ZhamG6OLXUWsMBZUqaJV4xri5xzAPeB9YiwpFCC/ZHHo9iaSPLonn0MvrZeMilYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tzDfN0CR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1WomHnh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tzDfN0CR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1WomHnh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FAB71FD49;
	Wed,  2 Oct 2024 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727864793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8wpNEENVwFj1K0orUvPrsefE82eun3cy9AkEFnKhTvY=;
	b=tzDfN0CRvh0RSoQv9B722FeqajrwpxdSKJR03d3Sbg4D++35wXOftr+X3WwFCGx/znZ7fI
	9haF0PifmPbhIyqgYPySEq5kd5hOC484lZ0vM4bINkzUKv1maItoiFzBd/ZKHE8LZpZf+e
	8Aeftw0JPTA8KCeZFTn40df+DtyYJ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727864793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8wpNEENVwFj1K0orUvPrsefE82eun3cy9AkEFnKhTvY=;
	b=a1WomHnhUjGCqP8uLwaln827gSiabs5jKhCPOzRQW/FyHgvvtQ6JDIGT6+8jVvO0sojLYH
	LSdlX6W+YS3bT+Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tzDfN0CR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a1WomHnh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727864793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8wpNEENVwFj1K0orUvPrsefE82eun3cy9AkEFnKhTvY=;
	b=tzDfN0CRvh0RSoQv9B722FeqajrwpxdSKJR03d3Sbg4D++35wXOftr+X3WwFCGx/znZ7fI
	9haF0PifmPbhIyqgYPySEq5kd5hOC484lZ0vM4bINkzUKv1maItoiFzBd/ZKHE8LZpZf+e
	8Aeftw0JPTA8KCeZFTn40df+DtyYJ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727864793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8wpNEENVwFj1K0orUvPrsefE82eun3cy9AkEFnKhTvY=;
	b=a1WomHnhUjGCqP8uLwaln827gSiabs5jKhCPOzRQW/FyHgvvtQ6JDIGT6+8jVvO0sojLYH
	LSdlX6W+YS3bT+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE66B13974;
	Wed,  2 Oct 2024 10:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YD4ANtgf/WZ4YQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 10:26:32 +0000
Message-ID: <80d0cd70-c00a-475c-a028-e842fb86403b@suse.cz>
Date: Wed, 2 Oct 2024 12:26:32 +0200
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241001-b4-slub-kunit-fix-v2-2-2d995d3ecb49@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FAB71FD49
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/1/24 18:20, Vlastimil Babka wrote:
> Guenter Roeck reports that the new slub kunit tests added by commit
> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
> test_leak_destroy()") cause a lockup on boot on several architectures
> when the kunit tests are configured to be built-in and not modules.
> 
> The test_kfree_rcu test invokes kfree_rcu() and boot sequence inspection
> showed the runner for built-in kunit tests kunit_run_all_tests() is
> called before setting system_state to SYSTEM_RUNNING and calling
> rcu_end_inkernel_boot(), so this seems like a likely cause. So while I
> was unable to reproduce the problem myself, skipping the test when the
> slub_kunit module is built-in should avoid the issue.
> 
> An alternative fix that was moving the call to kunit_run_all_tests() a
> bit later in the boot was tried, but has broken tests with functions
> marked as __init due to free_initmem() already being done.
> 
> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/

I hope you can confirm it helps, because the commit added two tests and I've
only skipped one of them, as it's the one using kfree_rcu(), which is
suspected. But the other is responsible for the (now suppressed)
kmem_cache_destroy() warning, and maybe I'm missing something and it was
actually that one causing the lockups.

Since you mentioned the boot lockups happened on some x86_64 too, do you
have a .config of the lockup case? I've tried tweaking some rcu options but
still nothing.

Thanks!

> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: rcu@vger.kernel.org
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/slub_kunit.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 85d51ec09846d4fa219db6bda336c6f0b89e98e4..80e39f003344858722a544ad62ed84e885574054 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -164,10 +164,16 @@ struct test_kfree_rcu_struct {
>  
>  static void test_kfree_rcu(struct kunit *test)
>  {
> -	struct kmem_cache *s = test_kmem_cache_create("TestSlub_kfree_rcu",
> -				sizeof(struct test_kfree_rcu_struct),
> -				SLAB_NO_MERGE);
> -	struct test_kfree_rcu_struct *p = kmem_cache_alloc(s, GFP_KERNEL);
> +	struct kmem_cache *s;
> +	struct test_kfree_rcu_struct *p;
> +
> +	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
> +		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
> +
> +	s = test_kmem_cache_create("TestSlub_kfree_rcu",
> +				   sizeof(struct test_kfree_rcu_struct),
> +				   SLAB_NO_MERGE);
> +	p = kmem_cache_alloc(s, GFP_KERNEL);
>  
>  	kfree_rcu(p, rcu);
>  	kmem_cache_destroy(s);
> 


