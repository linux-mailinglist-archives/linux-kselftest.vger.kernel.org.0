Return-Path: <linux-kselftest+bounces-44026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A5C083E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 00:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7475F1883176
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698E303CB7;
	Fri, 24 Oct 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WTTwjRCx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPY0qqdk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WTTwjRCx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPY0qqdk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CEA22FE0A
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345071; cv=none; b=fXPnn4WhTaGqd76IsQviWTDBdm8/o9isgYhjWq5qN+i+Yt3J8NgPsXoqYhBVmU6XFA5kEvMHVmBuj+Ih2Fy+Xu5iui2yseRkxN0Kf/0HmKx99B6/IpTbPsZiArtM/r0nftkITPj7cJZ8IBDNmitL5hVrWLliIkyMl+8xJdkmpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345071; c=relaxed/simple;
	bh=TdtvSFhVumAdCHdZdAGKLPPL1lptHcjWodC1ykDPzY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbUZJ463jhZfoT7RdmaBsaa5StEFphKgCKhn9B4W45ullX0nonFcFg1tzbJ3PqWr7O+ubCS1ISzhgiR3TlchynUxw2wKaffpRShY/O6SzBnh4er8nYIyX1QwqbinWecqLfj0VuNBtV+/ZYceBnSH/WHkn/uw6R3OBv/m7Dr5LSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WTTwjRCx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPY0qqdk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WTTwjRCx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPY0qqdk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47D59211E8;
	Fri, 24 Oct 2025 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761345066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaDkQXEDq3kiZtr1ll+BBk3Dg0qixXh2ek2kyEyFBLo=;
	b=WTTwjRCxGB26PULa/ak6Okz4dsHb+N43kdKOP+ED1wRE0ANRFxocl1iqwChFEy2qFVB/t6
	HnEQ3y1qKQv843HJdWRHWuu4eFa4nPQefDPcdaBUEglKWx/SC6JaFoKeiEMw+zjey+sGE2
	6Dj8XTGGp0WYBlgpxYMuJIB1ygGaM+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761345066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaDkQXEDq3kiZtr1ll+BBk3Dg0qixXh2ek2kyEyFBLo=;
	b=zPY0qqdke3Lu6ES/8PPTBWAO0LRSuqxdR+K2yGNe1/3Z3gdUGnz7iONCHFZFcx+3YtYOC6
	dAYr1MrZU4+GekDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761345066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaDkQXEDq3kiZtr1ll+BBk3Dg0qixXh2ek2kyEyFBLo=;
	b=WTTwjRCxGB26PULa/ak6Okz4dsHb+N43kdKOP+ED1wRE0ANRFxocl1iqwChFEy2qFVB/t6
	HnEQ3y1qKQv843HJdWRHWuu4eFa4nPQefDPcdaBUEglKWx/SC6JaFoKeiEMw+zjey+sGE2
	6Dj8XTGGp0WYBlgpxYMuJIB1ygGaM+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761345066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaDkQXEDq3kiZtr1ll+BBk3Dg0qixXh2ek2kyEyFBLo=;
	b=zPY0qqdke3Lu6ES/8PPTBWAO0LRSuqxdR+K2yGNe1/3Z3gdUGnz7iONCHFZFcx+3YtYOC6
	dAYr1MrZU4+GekDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25DF813693;
	Fri, 24 Oct 2025 22:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JqLLCCr++2gdDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 Oct 2025 22:31:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80A6CA280E; Sat, 25 Oct 2025 00:31:05 +0200 (CEST)
Date: Sat, 25 Oct 2025 00:31:05 +0200
From: Jan Kara <jack@suse.cz>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 01/32] pidfs: validate extensible ioctls
Message-ID: <s57bjg2caxa5zhsamkll7b637omcszkammckb56pexs5m3uu4s@fyqo2js5flrk>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
 <5b287ec6-72ff-4707-9040-3c84efc58b94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b287ec6-72ff-4707-9040-3c84efc58b94@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Thu 23-10-25 12:46:45, Jiri Slaby wrote:
> On 10. 09. 25, 16:36, Christian Brauner wrote:
> > Validate extensible ioctls stricter than we do now.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >   fs/pidfs.c         |  2 +-
> >   include/linux/fs.h | 14 ++++++++++++++
> >   2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index edc35522d75c..0a5083b9cce5 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> >   		 * erronously mistook the file descriptor for a pidfd.
> >   		 * This is not perfect but will catch most cases.
> >   		 */
> > -		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > +		return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> 
> Hi,
> 
> this turned EINVAL (from pidfd_info()) into ENOTTY (from pidfd_ioctl()) for
> at least LTP's:
> struct pidfd_info_invalid {
> 	uint32_t dummy;
> };
> 
> #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct
> pidfd_info_invalid)
> 
> ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) == EINVAL
> 
> at:
> https://github.com/linux-test-project/ltp/blob/9bb94efa39bb1b08f37e56c7437db5fa13ddcae2/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c#L46
> 
> Is this expected?

We already discussed this internally but for others the problem was
discussed here [1] and we decided the new errno value is OK and LTP test is
being fixed up.

								Honza

[1] https://lore.kernel.org/all/aPIPGeWo8gtxVxQX@yuki.lan/

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

