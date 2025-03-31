Return-Path: <linux-kselftest+bounces-29958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B5A76CF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 20:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E62188CE09
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39E2147F3;
	Mon, 31 Mar 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i0GOUGAA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1d6dPsT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i0GOUGAA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1d6dPsT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6D1DE3A5
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445953; cv=none; b=V+MkUsa/7j4Nf9L1L989AEsNgCfmJic09gVDxKnmefzMxRyuaNA6/Tz3icWhafjGhKehlu9BsVi7JVXpiI2Niz8f/mHMxMU/Xh1FICt/c28cBBKS91gzC7CdNqlh38Vb7SnUvA8u2QtwF2hvU6ZaVBUOH+wSVsJDuJqVnfEZVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445953; c=relaxed/simple;
	bh=BJkQvthlNtH6auAfO4lCrhO/pF8mIIMYSy9yIE1FvhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvjTIeAle3kNez79hWa88lt9aIYYiPHME6kmB+1QpBwxpk4eeZxM+oMEdI5MXSP6fxVgYdKuWW+UFb1TWPUxlLpkcLGuZoUChRoNO4SOQrLkvyDliODTwVwYe7PICLQ9UvY/10O0Kce99FLIAx8CbMEYVQmBbxNYzyM7+PmW+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i0GOUGAA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1d6dPsT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i0GOUGAA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1d6dPsT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 247FC211E5;
	Mon, 31 Mar 2025 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743445949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv4Lmp/QdqT0c2+FR1HowIaSrO31qTK8wTqkhmeumIM=;
	b=i0GOUGAANFCukQk7qUtG8rRgjDslM1onbc4kxUYe/+TzRx7kDpG+mekMyDWQIr0wSeald4
	nmgVakNm2GqL2ZZ7KsmJkqwT+815zoAx9S9Kc9RvBnq/4eeK7BoeaCFL6sS14vN4bHjbv4
	ky2kQ3P1MGetLjxxeV1WgfgF7q2jL3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743445949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv4Lmp/QdqT0c2+FR1HowIaSrO31qTK8wTqkhmeumIM=;
	b=X1d6dPsT3JjGcL6NA2t05gmqWKWpTJR9ZrJIAlIR8fmw1ockgY8pne3WpIAnrFUVUdlCqG
	kXAOWb/l1njC+KBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i0GOUGAA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X1d6dPsT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743445949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv4Lmp/QdqT0c2+FR1HowIaSrO31qTK8wTqkhmeumIM=;
	b=i0GOUGAANFCukQk7qUtG8rRgjDslM1onbc4kxUYe/+TzRx7kDpG+mekMyDWQIr0wSeald4
	nmgVakNm2GqL2ZZ7KsmJkqwT+815zoAx9S9Kc9RvBnq/4eeK7BoeaCFL6sS14vN4bHjbv4
	ky2kQ3P1MGetLjxxeV1WgfgF7q2jL3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743445949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv4Lmp/QdqT0c2+FR1HowIaSrO31qTK8wTqkhmeumIM=;
	b=X1d6dPsT3JjGcL6NA2t05gmqWKWpTJR9ZrJIAlIR8fmw1ockgY8pne3WpIAnrFUVUdlCqG
	kXAOWb/l1njC+KBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0E64139A1;
	Mon, 31 Mar 2025 18:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OCvpOLzf6meXBAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 18:32:28 +0000
Date: Mon, 31 Mar 2025 20:32:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Cc: linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] unshare_test: set nr_open using soft limit
Message-ID: <20250331183227.GA279891@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250328144717.108054-1-lufei@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328144717.108054-1-lufei@uniontech.com>
X-Rspamd-Queue-Id: 247FC211E5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi all,

> Set maximum file descriptor number limit by rlimit.rlim_max than
> nr_open(hard limit). Hard limit may cause dup2 fail.

It actually changes from failure:

# ./unshare_test 
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           global.unshare_EMFILE ...
# unshare_test.c:60:unshare_EMFILE:Expected dup2(2, nr_open + 64) (-1) >= 0 (0)
# unshare_EMFILE: Test failed
#          FAIL  global.unshare_EMFILE
not ok 1 global.unshare_EMFILE
# FAILED: 0 / 1 tests passed.
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

to pass:

TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           global.unshare_EMFILE ...
#            OK  global.unshare_EMFILE
ok 1 global.unshare_EMFILE
# PASSED: 1 / 1 tests passed.
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>  tools/testing/selftests/core/unshare_test.c | 28 +++++++++++++--------
>  1 file changed, 18 insertions(+), 10 deletions(-)

> diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
> index 7fec9dfb1b0e..2c4e7104b0d9 100644
> --- a/tools/testing/selftests/core/unshare_test.c
> +++ b/tools/testing/selftests/core/unshare_test.c
> @@ -26,10 +26,11 @@ TEST(unshare_EMFILE)
>  		.exit_signal = SIGCHLD,
>  	};
>  	int fd;
> -	ssize_t n, n2;
> -	static char buf[512], buf2[512];
> +	ssize_t n, n2, n3;
> +	static char buf[512], buf2[512], buf3[512];
>  	struct rlimit rlimit;
>  	int nr_open;
> +	int rlimit_max;

>  	fd = open("/proc/sys/fs/nr_open", O_RDWR);
>  	ASSERT_GE(fd, 0);
> @@ -42,22 +43,24 @@ TEST(unshare_EMFILE)

>  	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));

> -	/* bump fs.nr_open */
> -	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
> +	rlimit_max = rlimit.rlim_max;
> +
> +	/* bump rlimit.rlim_max */
> +	n2 = sprintf(buf2, "%d\n", rlimit_max + 1024);
>  	lseek(fd, 0, SEEK_SET);
>  	write(fd, buf2, n2);

>  	/* bump ulimit -n */
> -	rlimit.rlim_cur = nr_open + 1024;
> -	rlimit.rlim_max = nr_open + 1024;
> +	rlimit.rlim_cur = rlimit_max + 1024;
> +	rlimit.rlim_max = rlimit_max + 1024;
>  	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
>  		lseek(fd, 0, SEEK_SET);
>  		write(fd, buf, n);
>  		exit(EXIT_FAILURE);
>  	}

> -	/* get a descriptor past the old fs.nr_open */
> -	EXPECT_GE(dup2(2, nr_open + 64), 0) {
> +	/* get a descriptor past the old rlimit.rlim_max */
> +	EXPECT_GE(dup2(2, rlimit_max + 64), 0) {
>  		lseek(fd, 0, SEEK_SET);
>  		write(fd, buf, n);
>  		exit(EXIT_FAILURE);
> @@ -74,15 +77,20 @@ TEST(unshare_EMFILE)
>  	if (pid == 0) {
>  		int err;

> -		/* restore fs.nr_open */
> +		n3 = sprintf(buf3, "%d\n", rlimit_max);
>  		lseek(fd, 0, SEEK_SET);
> -		write(fd, buf, n);
> +		write(fd, buf3, n3);
nit: do we really need buf3? Can't we reuse buf2?
Or do I miss something obvious?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
>  		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
>  		err = unshare(CLONE_FILES);
>  		EXPECT_EQ(err, -1)
>  			exit(EXIT_FAILURE);
>  		EXPECT_EQ(errno, EMFILE)
>  			exit(EXIT_FAILURE);
> +
> +		/* restore fs.nr_open */
> +		lseek(fd, 0, SEEK_SET);
> +		write(fd, buf, n);
>  		exit(EXIT_SUCCESS);
>  	}

