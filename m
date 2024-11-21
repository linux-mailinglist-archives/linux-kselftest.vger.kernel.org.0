Return-Path: <linux-kselftest+bounces-22405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1449D4D95
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 14:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD3F1F21455
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B91D4324;
	Thu, 21 Nov 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEG5jByR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0dMoycn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEG5jByR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0dMoycn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE214BF87;
	Thu, 21 Nov 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732195007; cv=none; b=ucnzMKMJmUhbGdG8Lxyy1TtjPnmTMD+5bdoq4QcJdy2+RzXm3eGDkzgJPj+6OpG7AP3zRK3Z34P4uW56qEt4vVGbP9md6gzWndMEDpjMneSFkiwLNDgg2M/b/PKSMarNH1wyBiVv7ZXhzdhdJLYTx5VhdMubfpHG1RO/kaolO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732195007; c=relaxed/simple;
	bh=7XHWyvWXbr2LJZIelM99SG1GYm/RcFWHYMS7xIgK4jk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZM+FyYndqZfbTdZ3Cq7YD1soOLvye2Rb4QfZAycvZOL1ZqKDiHRme946W2okw65+IIvkCJJJqU9jrRrisbo2Dhgi3nJFlZWC8Ehxdt9Fiaf+1jfqYBAADqYPDob2A4QEDybBwxBxsCdyVF15EI5Jz2DeanS222hYble8g+sq9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEG5jByR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0dMoycn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEG5jByR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0dMoycn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3391321A08;
	Thu, 21 Nov 2024 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732195003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YTXiVTRlxcSzx9SYX8rgBDqmASsJNsTcw4BKzeFV+E=;
	b=MEG5jByR+NcMAEhMIIhFIrOgZUlazDP3xMPzE8FufTGlX3hMeUtBwRlrzqUdqz6bbVVGLX
	D6WLDdmL3gn6EmhzkwJmScAGixC7Ci9rXEbLEBPbZllRtsRyMU2gq5Eu0e9Puow6ccb68q
	chX/2dve3nolCfF9At5DKdV6Xy1lPnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732195003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YTXiVTRlxcSzx9SYX8rgBDqmASsJNsTcw4BKzeFV+E=;
	b=r0dMoycnkB8G4vPTsVGog+tnhIWAi415a+UX0LLEoLCM1MwCFzUxXFqedE+6M9dDvF/yH3
	brFUDHJl4WmMvxBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732195003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YTXiVTRlxcSzx9SYX8rgBDqmASsJNsTcw4BKzeFV+E=;
	b=MEG5jByR+NcMAEhMIIhFIrOgZUlazDP3xMPzE8FufTGlX3hMeUtBwRlrzqUdqz6bbVVGLX
	D6WLDdmL3gn6EmhzkwJmScAGixC7Ci9rXEbLEBPbZllRtsRyMU2gq5Eu0e9Puow6ccb68q
	chX/2dve3nolCfF9At5DKdV6Xy1lPnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732195003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YTXiVTRlxcSzx9SYX8rgBDqmASsJNsTcw4BKzeFV+E=;
	b=r0dMoycnkB8G4vPTsVGog+tnhIWAi415a+UX0LLEoLCM1MwCFzUxXFqedE+6M9dDvF/yH3
	brFUDHJl4WmMvxBQ==
Date: Thu, 21 Nov 2024 14:16:43 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: George Guo <dongtai.guo@linux.dev>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, shuah@kernel.org, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 1/6] selftests/livepatch: fix
 test-callbacks.sh execution error
In-Reply-To: <20241121111135.2125391-1-dongtai.guo@linux.dev>
Message-ID: <alpine.LSU.2.21.2411211414400.8938@pobox.suse.cz>
References: <20241121111135.2125391-1-dongtai.guo@linux.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On Thu, 21 Nov 2024, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
> 
> The script test-callbacks.sh fails with the following error:
> $ sudo ./test-callbacks.sh
> TEST: target module before livepatch ... not ok
> 
> - expected
> + result
>  test_klp_callbacks_mod: test_klp_callbacks_mod_init
>  % insmod test_modules/test_klp_callbacks_demo.ko
>  livepatch: enabling patch 'test_klp_callbacks_demo'
> -livepatch: 'test_klp_callbacks_demo': initializing patching transition
> +transition: 'test_klp_callbacks_demo': initializing patching transition
>  test_klp_callbacks_demo: pre_patch_callback: vmlinux
>  test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
> -livepatch: 'test_klp_callbacks_demo': starting patching transition
> -livepatch: 'test_klp_callbacks_demo': completing patching transition
> +transition: 'test_klp_callbacks_demo': starting patching transition
> +transition: 'test_klp_callbacks_demo': completing patching transition
>  test_klp_callbacks_demo: post_patch_callback: vmlinux
>  test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
> -livepatch: 'test_klp_callbacks_demo': patching complete
> +transition: 'test_klp_callbacks_demo': patching complete
>  % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
> -livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
> +transition: 'test_klp_callbacks_demo': initializing unpatching transition
>  test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
>  test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
> -livepatch: 'test_klp_callbacks_demo': starting unpatching transition
> -livepatch: 'test_klp_callbacks_demo': completing unpatching transition
> +transition: 'test_klp_callbacks_demo': starting unpatching transition
> +transition: 'test_klp_callbacks_demo': completing unpatching transition
>  test_klp_callbacks_demo: post_unpatch_callback: vmlinux
>  test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
> -livepatch: 'test_klp_callbacks_demo': unpatching complete
> +transition: 'test_klp_callbacks_demo': unpatching complete
>  % rmmod test_klp_callbacks_demo
>  % rmmod test_klp_callbacks_mod
>  test_klp_callbacks_mod: test_klp_callbacks_mod_exit
> 
> ERROR: livepatch kselftest(s) failed
> 
> The issue arises due to a mismatch in expected log output during livepatch
> transition. Specifically, the logs previously contained "livepatch:" but have
> now been updated to "transition:". This results in test failures when comparing
> the output with the expected values.
> 
> This patch updates the expected test output to reflect the new log format.

are you sure? I have just run livepatch selftests on v6.12 and everything 
was fine.

The above suggests that something happened to KBUILD_MODNAME in your case 
(which would also mean that the fix should be different). Could you 
verify or provide more information, please?

Miroslav

