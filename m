Return-Path: <linux-kselftest+bounces-18908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4B98DED7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 17:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA681F22DF3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5C1D0DE6;
	Wed,  2 Oct 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2TVKURS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAMF9w3K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0fw3LQ20";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkRJ1Q9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803B1D0DC4;
	Wed,  2 Oct 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882611; cv=none; b=GmJAJc5mRZm1Q4OwsYCgBtp/3E+ESDUJuxH31KRFM5WD0jT5d/cEgHlxe++mRDoyy7QeFBnsPHA+h//mPNHIEKxQ5F3cHtnyfCp8egLxthPnovggN0KaRkgoLe9BWa8rkqxkibXCr/vAdmW9oR+71Cq+Eol1y/akDDm4xehKZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882611; c=relaxed/simple;
	bh=/yXPrV1FR5GIsKRi85kOHNP3nlia8DKhJfPuC0DEKWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OXThWwXffCf3rvxfKkADdxGPd9Cx+9RUmvMKAhkX1bfdtp6CPabzrwMytT7cmybHxClZ3nBigcJkVpeyLM3EVlz9fadUG6Mvnkh8mgkNelg4zUpKu/zNtLyCo0KK5pk0I9YwmPkqEQfLT4HlIPpI945m/nEyif7JSA41x+Sy0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2TVKURS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAMF9w3K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0fw3LQ20; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkRJ1Q9X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7B7B21C6B;
	Wed,  2 Oct 2024 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727882608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnIbF0VvYkqNimH9KKv4Ic76UBu3+W6XPzME/Ok1a3w=;
	b=C2TVKURSpI1Wb6tUKl3MVuLSf6M4g6XRhROLU+HVpzasXRgSjleBDSofdXEnoZBhCAgDtm
	lrsqhllvtQGHqWL7vTJ1Yosk6zWsP7voqG0nZIMbt8ul/fj/ExK0qZLCBbeL+nv/vT6Nk7
	fUPZ6eQzbxPxhk8KcK+NgANwe6imSqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727882608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnIbF0VvYkqNimH9KKv4Ic76UBu3+W6XPzME/Ok1a3w=;
	b=uAMF9w3KiypCZjuVMzbBcthXk74jaZtYed2CfaXNSh6uaxctECnEaWKNDpDaOE8CeCHyUD
	xxcZQn7GjYBJu2Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727882607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnIbF0VvYkqNimH9KKv4Ic76UBu3+W6XPzME/Ok1a3w=;
	b=0fw3LQ20qmDoS9pjOxyOcR8PhBTGzTkhtYKzx+V2Yv77LPXp5oxDFajnQRM9t+H9mtocM0
	3PyFfNV5E5ChZcC8KD3eYhpT3V10+t9IPfk2ovINn4jWZ+gy3sKkM1RSWoQL5sjsK7GcWK
	FaSwzEWz/fByJF9H0pVgji/7kT4fz6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727882607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnIbF0VvYkqNimH9KKv4Ic76UBu3+W6XPzME/Ok1a3w=;
	b=IkRJ1Q9Xne/Aib6UHX53XiwKclbVYgTifpqiyLWeo3qRtZVdOUhSMr9XuXaQHA0YMMLlSi
	Cx5o80f+y02UDNBg==
Date: Wed, 2 Oct 2024 17:23:27 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Vetter <mvetter@suse.com>
cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to
 SYSFS_KLP_DIR
In-Reply-To: <20240930093308.65103-2-mvetter@suse.com>
Message-ID: <alpine.LSU.2.21.2410021720190.23724@pobox.suse.cz>
References: <20240930093308.65103-1-mvetter@suse.com> <20240930093308.65103-2-mvetter@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

On Mon, 30 Sep 2024, Michael Vetter wrote:

> This naming makes more sense according to the directory structure.
> Especially when we later add more paths.
> 
> Signed-off-by: Michael Vetter <mvetter@suse.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index fc4c6a016d38..50361fceff06 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -6,7 +6,7 @@
>  
>  MAX_RETRIES=600
>  RETRY_INTERVAL=".1"	# seconds
> -KLP_SYSFS_DIR="/sys/kernel/livepatch"
> +SYSFS_KLP_DIR="/sys/kernel/livepatch"
>  
>  # Kselftest framework requirement - SKIP code is 4
>  ksft_skip=4
> @@ -322,7 +322,7 @@ function check_sysfs_rights() {
>  	local rel_path="$1"; shift
>  	local expected_rights="$1"; shift
>  
> -	local path="$KLP_SYSFS_DIR/$mod/$rel_path"
> +	local path="$SYSFS_KLP_DIR/$mod/$rel_path"
>  	local rights=$(/bin/stat --format '%A' "$path")
>  	if test "$rights" != "$expected_rights" ; then
>  		die "Unexpected access rights of $path: $expected_rights vs. $rights"
> @@ -338,7 +338,7 @@ function check_sysfs_value() {
>  	local rel_path="$1"; shift
>  	local expected_value="$1"; shift
>  
> -	local path="$KLP_SYSFS_DIR/$mod/$rel_path"
> +	local path="$SYSFS_KLP_DIR/$mod/$rel_path"
>  	local value=`cat $path`
>  	if test "$value" != "$expected_value" ; then
>  		die "Unexpected value in $path: $expected_value vs. $value"

I am sorry I was not explicit enough previously. There are still 
/sys/kernel/livepatch occurrences in tools/testing/selftest/livepatch/ 
which can be replaced with this new variable. They are there for quite 
some time but it would be really nice if you could replace them all to 
make it consistent since you are touching it.

Thank you,
Miroslav

