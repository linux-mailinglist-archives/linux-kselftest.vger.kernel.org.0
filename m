Return-Path: <linux-kselftest+bounces-40947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09328B490AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24D53B9EDC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B430C348;
	Mon,  8 Sep 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F6TOoU7w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7nfi5bDK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b5feAlKW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1lx/ZXI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50672626
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340242; cv=none; b=tSn0acGTTxCdu+WvA78V3heYF3FA2qoN+7CpPQK/gfqLEbPXC3pBJo2nu/giFrdhz4MVYhLnwjNyvwL/Yclm0VZ0rWcsUY++nmwVoa+6+KLvlqc9yRONdhAJNxezsHWx1yI7a1Peu3+GaFY5w44vKWGgCrfpwLFD3EYMGF3kV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340242; c=relaxed/simple;
	bh=lI5hhua7BF/59CxJnX46nMf5H/5lSBPTHxxpL2dbOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFChl1UmMfxG2PJKNw8yaw6q2JmJfotjscTFzSkn666MzIzERctQKLTG7PBMSyp0G0JKxgOQ4K3VXTcWe0TQu6I/Ufgyw0w9uKHX99FjAB4x9w9SMDxd+9HtS4OXK+zQkiuaYKhaJV2Pb4u1WYt8RsU0sKcFN1kdbqAAM6JQnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F6TOoU7w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7nfi5bDK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b5feAlKW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q1lx/ZXI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC4FD8BEA8;
	Mon,  8 Sep 2025 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757340239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVKSLRxf+cROZGzxsMukti7xTt0IN5mvuqmeAvrozk=;
	b=F6TOoU7wdFEksIzUqng6tO9H/1SvyWtF0QTXt07qwBRkAlPMgRAjsnfbtRwF7NUOH6xy5f
	M70K1iK0B8a/gPDeEe2iTDm5UA6bW/0390ZD4/HWhzPKXzFUImB1i322a+eeRxuq/p/V0v
	RHY0WPhUnqn7QMI0yxLHj2M8VDu+fJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757340239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVKSLRxf+cROZGzxsMukti7xTt0IN5mvuqmeAvrozk=;
	b=7nfi5bDKNGACsThZ9/ZLfyZNqsjwdU1GCBHOTeF5VLToT973MX91mbKXbQ3psgmQV6k1Y7
	LLQ1Lc3Y9BflNzAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757340238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVKSLRxf+cROZGzxsMukti7xTt0IN5mvuqmeAvrozk=;
	b=b5feAlKW4BGehyQn0eRqJNb83d7hT9KYpfhFn8IFUvncoCod/HBdkDUPOewYW2QqeSOpN1
	dtn6uPTzSOpghwb1r1hDljLRj/4oJ/iESq50vdTjiZY3kZUbsWrE0ROS721TgEePNwnqOz
	sUOjpSUk6CcD/OfAR4dd/faWatv2lkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757340238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVKSLRxf+cROZGzxsMukti7xTt0IN5mvuqmeAvrozk=;
	b=Q1lx/ZXI3KqyRRzjEy0AG0GDGWHFsuwzRqgV3ehqBy/api8ncBdf2lM2AJHnz5Epx9OLNT
	53yogQsEWpsnBJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0B6C13869;
	Mon,  8 Sep 2025 14:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PmjtMk7ivmgPRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 14:03:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85C70A0A2D; Mon,  8 Sep 2025 16:03:58 +0200 (CEST)
Date: Mon, 8 Sep 2025 16:03:58 +0200
From: Jan Kara <jack@suse.cz>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: shuah@kernel.org, brauner@kernel.org, amir73il@gmail.com, 
	jhubbard@nvidia.com, jack@suse.cz, mszeredi@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/filesystems: Use return value of the function
 'chdir()'
Message-ID: <ih3rx26fktypyqmqnrkumgdgfwlb5jhyxkjg2xgwy5ea6she63@r7y2oapgjpbc>
References: <20250710001927.4726-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710001927.4726-1-alessandro.zanni87@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,suse.cz,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Thu 10-07-25 02:19:25, Alessandro Zanni wrote:
> Fix to use the return value of the function 'chdir("/")' and check if the
> return is either 0 (ok) or 1 (not ok, so the test stops).
> 
> The patch fies the solves the following errors:
> mount-notify_test.c:468:17: warning: ignoring return value of ‘chdir’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   468 |                 chdir("/");
> 
> mount-notify_test_ns.c:489:17: warning: ignoring return value of
> ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-
> result]
>   489 |                 chdir("/");
> 
> To reproduce the issue, use the command:
> make kselftest TARGET=filesystems/statmount
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../selftests/filesystems/mount-notify/mount-notify_test.c      | 2 +-
>  .../selftests/filesystems/mount-notify/mount-notify_test_ns.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index 5a3b0ace1a88..a7f899599d52 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -458,7 +458,7 @@ TEST_F(fanotify, rmdir)
>  	ASSERT_GE(ret, 0);
>  
>  	if (ret == 0) {
> -		chdir("/");
> +		ASSERT_EQ(0, chdir("/"));
>  		unshare(CLONE_NEWNS);
>  		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>  		umount2("/a", MNT_DETACH);
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> index d91946e69591..dc9eb3087a1a 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> @@ -486,7 +486,7 @@ TEST_F(fanotify, rmdir)
>  	ASSERT_GE(ret, 0);
>  
>  	if (ret == 0) {
> -		chdir("/");
> +		ASSERT_EQ(0, chdir("/"));
>  		unshare(CLONE_NEWNS);
>  		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>  		umount2("/a", MNT_DETACH);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

