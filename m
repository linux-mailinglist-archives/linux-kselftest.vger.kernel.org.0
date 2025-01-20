Return-Path: <linux-kselftest+bounces-24792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC094A16C93
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 13:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04253165F7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA31E1A31;
	Mon, 20 Jan 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UJA3fAtR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QvFBqHqQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoGroTVf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tGzZg2l+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC21E1041;
	Mon, 20 Jan 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377666; cv=none; b=U2LO93IW0Y48my5uDb94Ny9G3bc1ZvK9DJcSL/pkCReMQeyIZBiK4t+ps505BCvWIDiDY88YHA9oMnHAeB46k5MXb1IpT/Xkx+chI+mmyZ+5q3kY8SFdbRBWWH8AEV5VrgMElFbOZTSiW6NHBI3/BgZdlLV96b8svz/1+bNh180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377666; c=relaxed/simple;
	bh=VGHPiSwrdHj3zzWlkUOqJ5bcRyoq8nwz8AYfqOlegAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h6l9yCwed2fZQLCRmVA9t2HTTtFyUNzlzt7Lbi7bK1o499ApFusKmtBKcE149omG6qH57241sER0ZJRZ+XOMn6Nm2PBC6Z84UdCIACTPAAR6WHt601YByB96yzYmbY9VQT7LwArTPyN5kfU4Gn8PWzC8FR/65kJ5bu0rCjfR4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UJA3fAtR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QvFBqHqQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoGroTVf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tGzZg2l+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7CBF21120;
	Mon, 20 Jan 2025 12:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737377663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dENmDQuJs1xXFdoO9XY/CuTPv0FcoxD3ePEE0cuT3Sc=;
	b=UJA3fAtRHyBiyNsNFtuZ6b1LvgrrGS8JvoZY6kg61DdCknQrzF81nWncWt684NuK/sQ74q
	BkfoJzWYooX9nadWj39H+v4OMLNLTyhgKqI17X2d6jO1VlF6Dhyze3v4KnLax/PhW+lMcU
	KAQtHZiE5YIFHzyxYmn3isj9Fl+zIzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737377663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dENmDQuJs1xXFdoO9XY/CuTPv0FcoxD3ePEE0cuT3Sc=;
	b=QvFBqHqQKUV6FaWuReKnInGYqqerx3MNqbkdsiLvcaxs57aAog5rQxcgCErlYbmLI6gMrP
	GxIZj+tXnW6JRzBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737377662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dENmDQuJs1xXFdoO9XY/CuTPv0FcoxD3ePEE0cuT3Sc=;
	b=yoGroTVfoeof3PR/+HOq4a5PuQzt+cEglOhzznMQdb22FtUbh/cdlc/82uMB7upPzMTCq9
	6LJtYXAKxVZF678sKO+uhMuqzU7vpCnGn8E3nwHq8MOUCMY8N1AJUH7kt5zx0oCSeRNuam
	/BzuZeQMU7srxy/WR9mhMzJhHRtsoMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737377662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dENmDQuJs1xXFdoO9XY/CuTPv0FcoxD3ePEE0cuT3Sc=;
	b=tGzZg2l+gsqIeqmEuN+JWQcQYrtVKrfMEVqi0wP58YcV9+vP/IUfFB9+oJZH2XI0IPGvRS
	PYgVANJqfqf1FTBw==
Date: Mon, 20 Jan 2025 13:54:22 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
cc: jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
    shuah@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
    christophe.leroy@csgroup.eu, naveen@kernel.org, 
    live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
In-Reply-To: <20250119163238.749847-1-maddy@linux.ibm.com>
Message-ID: <alpine.LSU.2.21.2501201354120.12227@pobox.suse.cz>
References: <20250119163238.749847-1-maddy@linux.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,ellerman.id.au,gmail.com,csgroup.eu,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 19 Jan 2025, Madhavan Srinivasan wrote:

> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER,
> which adds the caller id as part of the dmesg. With recent
> util-linux's update 467a5b3192f16 ('dmesg: add caller_id support')
> the standard "dmesg" has been enhanced to print PRINTK_CALLER fields.
> 
> Due to this, even though the expected vs observed are same,
> end testcase results are failed.
> 
>  -% insmod test_modules/test_klp_livepatch.ko
>  -livepatch: enabling patch 'test_klp_livepatch'
>  -livepatch: 'test_klp_livepatch': initializing patching transition
>  -livepatch: 'test_klp_livepatch': starting patching transition
>  -livepatch: 'test_klp_livepatch': completing patching transition
>  -livepatch: 'test_klp_livepatch': patching complete
>  -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  -livepatch: 'test_klp_livepatch': initializing unpatching transition
>  -livepatch: 'test_klp_livepatch': starting unpatching transition
>  -livepatch: 'test_klp_livepatch': completing unpatching transition
>  -livepatch: 'test_klp_livepatch': unpatching complete
>  -% rmmod test_klp_livepatch
>  +[   T3659] % insmod test_modules/test_klp_livepatch.ko
>  +[   T3682] livepatch: enabling patch 'test_klp_livepatch'
>  +[   T3682] livepatch: 'test_klp_livepatch': initializing patching transition
>  +[   T3682] livepatch: 'test_klp_livepatch': starting patching transition
>  +[    T826] livepatch: 'test_klp_livepatch': completing patching transition
>  +[    T826] livepatch: 'test_klp_livepatch': patching complete
>  +[   T3659] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  +[   T3659] livepatch: 'test_klp_livepatch': initializing unpatching transition
>  +[   T3659] livepatch: 'test_klp_livepatch': starting unpatching transition
>  +[    T789] livepatch: 'test_klp_livepatch': completing unpatching transition
>  +[    T789] livepatch: 'test_klp_livepatch': unpatching complete
>  +[   T3659] % rmmod test_klp_livepatch
> 
>   ERROR: livepatch kselftest(s) failed
>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
> 
> Currently the check_result() handles the "[time]" removal from
> the dmesg. Enhance the check to also handle removal of "[Thread Id]"
> or "[CPU Id]".
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M

