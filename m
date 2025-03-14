Return-Path: <linux-kselftest+bounces-29044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03ACA61253
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847BF1B62BC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC27202C2A;
	Fri, 14 Mar 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/IyhA90";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="046hKvlz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/IyhA90";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="046hKvlz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135620299D
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958090; cv=none; b=kgGlBCHl2eXdN0CfeFy2cvxtzTjmf+W/JUXuktJoT4nfj1qmyJf9iyADJD2riJB7BNKImlxG9ZuORZVJ1V+WyOSRG/dfD63UqGoy2kRameEty6/LcFGB1zNitLWYsDT5E9lo7NkyCk0ZN0Kl1ISeDC4CL8Zl3XoMM1hd2uO7aVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958090; c=relaxed/simple;
	bh=i5pgVOZlVnq0y47YV+bp584paVxAqR35NM0VmcVJbdg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kLxHp2MdT95IPeeJuEdNiIrQfunj1PcOch+LtIIOWruyaHo473w87Vdd/BfqMXbYUYbnCDBGkgUWxRYygIV5XfFxk2ncjNBDQkcudssx428WTM5wCLgMVO+93VVdtgsLheClRlRxxAQ75knNDh5c+Za9sRRzQD/H497SPY207mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/IyhA90; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=046hKvlz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/IyhA90; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=046hKvlz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 452362116E;
	Fri, 14 Mar 2025 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741958087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1avXQwhwgX4XEF1ZEtVMSZaAo6rnSr1qiGZubxC19HI=;
	b=n/IyhA90i67l1TV9Wmw/AAAoC09i6VEIyW3oqYoz/ufMi8M80UMHynYNPrdr9T1l3aJkuU
	mSKm4UlMNAKUUATOhTWzp6fIBkMwGiuBLWZdRKQiVgwkOztvbVBAkd1qrPIMZeCdTWEkkH
	ObDqUvKR/S2trp9DThBQrQ+yGdUEAdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741958087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1avXQwhwgX4XEF1ZEtVMSZaAo6rnSr1qiGZubxC19HI=;
	b=046hKvlzpKzF6HYX5VwZ4n+XsiebxqUX0uiwyuiUvUAS7p/JSfP+xbtLXKuurjfxiedIKo
	msUURfaBIYr1AaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741958087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1avXQwhwgX4XEF1ZEtVMSZaAo6rnSr1qiGZubxC19HI=;
	b=n/IyhA90i67l1TV9Wmw/AAAoC09i6VEIyW3oqYoz/ufMi8M80UMHynYNPrdr9T1l3aJkuU
	mSKm4UlMNAKUUATOhTWzp6fIBkMwGiuBLWZdRKQiVgwkOztvbVBAkd1qrPIMZeCdTWEkkH
	ObDqUvKR/S2trp9DThBQrQ+yGdUEAdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741958087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1avXQwhwgX4XEF1ZEtVMSZaAo6rnSr1qiGZubxC19HI=;
	b=046hKvlzpKzF6HYX5VwZ4n+XsiebxqUX0uiwyuiUvUAS7p/JSfP+xbtLXKuurjfxiedIKo
	msUURfaBIYr1AaCA==
Date: Fri, 14 Mar 2025 14:14:47 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Filipe Xavier <felipeaggger@gmail.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
    live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH PATCH 2/2] selftests: livepatch: test if ftrace can trace
 a livepatched function
In-Reply-To: <20250306-ftrace-sftest-livepatch-v1-2-a6f1dfc30e17@gmail.com>
Message-ID: <alpine.LSU.2.21.2503141411010.4442@pobox.suse.cz>
References: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com> <20250306-ftrace-sftest-livepatch-v1-2-a6f1dfc30e17@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,vger.kernel.org,live.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.29
X-Spam-Flag: NO

Hi,

> +start_test "trace livepatched function and check that the live patch remains in effect"
> +
> +FUNCTION_NAME="livepatch_cmdline_proc_show"
> +
> +load_lp $MOD_LIVEPATCH
> +trace_function "$FUNCTION_NAME"

trace_funtion() calls cleanup_ftrace() to prepare the test. Ok.

> +if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	log "livepatch: ok"
> +fi
> +
> +check_traced_function "$FUNCTION_NAME"
> +
> +cleanup_tracing

Here, I suppose, cleanup_tracing() is called to clean up after the check 
above so that nothing stays and more tests can be added later. Right? 
Would it make sense then to call cleanup_tracing() in 
check_traced_function()? I think it would less error prone. 
If needed, check_traced_function() can always be upgraded so that it 
checks for more traced functions.

Miroslav

