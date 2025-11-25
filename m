Return-Path: <linux-kselftest+bounces-46436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63CC8534F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA73A9543
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F4221DAE;
	Tue, 25 Nov 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FY+355QL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWtGKK0Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="up2UOeij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFVqEwZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C041FDE01
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077928; cv=none; b=WYeAwxaEKL8lq0giXEieKpfikOQhD+Su+dVZlfm2Jo6j/ZsyJZZbkAn37TvhN+X3CZCuRthAeWIUXgs7NPd8YPaqPYRwGc7MFQXVj76q8jCSsfsyDsfxhpoYQw9abc23/v/qWzfKICelIYCPrxy3MUBErBd+xwhdUhFgtu85tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077928; c=relaxed/simple;
	bh=jutAJAAqG9b1pvGErmLBFzYKTc0qTKmeBDQIKhOhP+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjdAV8qQOZ4cxPNJK6WHz8b1jq1FXuPl/iVgKyoOXFBBRiUq+nC+L6g12jahaUELrqL6XNIocvsYlNrtFOxR2GPzqOXrCX6OApKu9FVgXyZHKcsXzAnDmYIa5X0NSHCm4dmFbxzOqT5tmkO3p1JAcdlnTHa7aWca5BOW1RvCKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FY+355QL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWtGKK0Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=up2UOeij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFVqEwZI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2C7522844;
	Tue, 25 Nov 2025 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764077925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjtFN8WWBRYbYkmEaem1ql+t3SQYXM2w2lHsBbsZSpc=;
	b=FY+355QL19H9gzGMWljgDxQ+uiBc87dy+BNwoMJAg1lc6iNlCkfOszPA0FhKXiVj8c1lUT
	8IRxTFcU+SROix4VjUjm8Z6dljp5IGnP6G52Jk9Zl8+pWn2EwfpLKFhSOzFZ9dSwQgLJyg
	GHktexMzZHTSIui4wMd0R6QNTURs0fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764077925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjtFN8WWBRYbYkmEaem1ql+t3SQYXM2w2lHsBbsZSpc=;
	b=PWtGKK0Q5RX4D40885nJS65RXcUZerfkTSajEK9SE6aLsIqcKMGNtYPQwigi3Xe/VG/72+
	imkrLxkbci9l/yCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764077924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjtFN8WWBRYbYkmEaem1ql+t3SQYXM2w2lHsBbsZSpc=;
	b=up2UOeijkbGoQ0gJEEm6sdLfMfNEQrQpCAbYC4MiIBoGCTncqLYkyHAk2pMHfOPKQinS+t
	R0UeIfpPiDMgLvFqrkOKzt/DVHlR3wMS/kB3tRmN3AEIxa2xAZWn28A2xck1HEZimI7YoP
	5YlSe6QZ5iB/llAhaztIwAl1NqZthkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764077924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjtFN8WWBRYbYkmEaem1ql+t3SQYXM2w2lHsBbsZSpc=;
	b=yFVqEwZIy8fOrotXJC0ZhG9UBn1SYcscBxlfqdXY5+nO4OWVgZyVD45coRymecPc4DNu/p
	OrEDupclvOoIxeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B74443EA63;
	Tue, 25 Nov 2025 13:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7li1K2SxJWlgMwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 25 Nov 2025 13:38:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: rbm@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] selftests/run_kselftest.sh: Add `--skip` argument option
Date: Tue, 25 Nov 2025 14:38:39 +0100
Message-ID: <20251125133840.172697-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125-selftests-add_skip_opt-v1-1-85ef2ae2e035@suse.com>
References: <20251125-selftests-add_skip_opt-v1-1-85ef2ae2e035@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Hi Ricardo, all,

> Currently the only way of excluding certain tests from a collection is by
> passing all the other tests explicitly via `--test`. Therefore, if the user
> wants to skip a single test the resulting command line might be too big,
> depending on the collection. Add an option `--skip` that takes care of
> that.
> 
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/run_kselftest.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index d4be97498b32..84d45254675c 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -30,6 +30,7 @@ Usage: $0 [OPTIONS]
>    -s | --summary		Print summary with detailed log in output.log (conflict with -p)
>    -p | --per-test-log		Print test log in /tmp with each test name (conflict with -s)
>    -t | --test COLLECTION:TEST	Run TEST from COLLECTION
> +  -S | --skip COLLECTION:TEST	Skip TEST from COLLECTION
>    -c | --collection COLLECTION	Run all tests from COLLECTION
>    -l | --list			List the available collection:test entries
>    -d | --dry-run		Don't actually run any tests
> @@ -43,6 +44,7 @@ EOF
>  
>  COLLECTIONS=""
>  TESTS=""
> +SKIP=""
>  dryrun=""
>  kselftest_override_timeout=""
>  ERROR_ON_FAIL=true
> @@ -58,6 +60,9 @@ while true; do
>  		-t | --test)
>  			TESTS="$TESTS $2"
>  			shift 2 ;;
> +		-S | --skip)
> +			SKIP="$SKIP $2"
> +			shift 2 ;;
>  		-c | --collection)
>  			COLLECTIONS="$COLLECTIONS $2"
>  			shift 2 ;;
> @@ -109,6 +114,12 @@ if [ -n "$TESTS" ]; then
>  	done
>  	available="$(echo "$valid" | sed -e 's/ /\n/g')"
>  fi
> +# Remove tests to be skipped from available list
> +if [ -n "$SKIP" ]; then
> +	for skipped in $SKIP ; do
> +		available="$(echo "$available" | grep -v "^${skipped}$")"
> +	done
> +fi

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

