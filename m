Return-Path: <linux-kselftest+bounces-5162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A985D813
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58E51C226DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E469312;
	Wed, 21 Feb 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xx4SlMy6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zpKtbHyN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xx4SlMy6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zpKtbHyN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834B67E73;
	Wed, 21 Feb 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519445; cv=none; b=qPRMPrFum8JweabpezVnN2Tu+NMilw2vrr5RRULw0PuPH1Tol+7e6cf+JOW9t9rZMEbWjU3DOOMCJB2mwJjbKAReUSPU9OqHDtuYkuBj602kfaMSnFakuAwKbX2+DpDvsXpujxDkLEV7tbWtxGOC4Twq5YJNiqFjdCqDdx3xm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519445; c=relaxed/simple;
	bh=gkgJhFNU0w2euKCzgtnfXaFn6+eWSHDRHzTmuXrUbwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3P5cUq3hqMZVFhKyiV1TMYPDG7bjEmi5AFAD5VugZUSQyTgGtFAgjrXmugl3TUlRMmMrPIDdgXVqrzpv9dXItxRMr1eW02rlHqUIOXwBi04I0n7bMC1fech9E023caDmwyRcEUJCMnz7MOdzKZdJCNv+EEW+jsxX1t3S9tJzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xx4SlMy6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zpKtbHyN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xx4SlMy6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zpKtbHyN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 460011FB66;
	Wed, 21 Feb 2024 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708519442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgJhFNU0w2euKCzgtnfXaFn6+eWSHDRHzTmuXrUbwU=;
	b=Xx4SlMy6QSJAp97sysS2MZ+BkFe3PHHO0CBTr9NIVrPbEWm6Tc4tsVUsYFlEOPg9FsDG1D
	yqXTYzHsREBNsxawxjQP/qv0huii+0iu/tTrTRU+QviUEnDi+Yd11x7bgPblKxTM0rhFvD
	FQctbtwlb7tk19VwKO8na2o5BSB/UyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708519442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgJhFNU0w2euKCzgtnfXaFn6+eWSHDRHzTmuXrUbwU=;
	b=zpKtbHyNzZPV1VOSBF9quyCut1I54YW0S0qMivDVdrWfTKXTHTjiGyjBkmGQ6QRwssC5f4
	wYo7L0AHXnH3gjAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708519442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgJhFNU0w2euKCzgtnfXaFn6+eWSHDRHzTmuXrUbwU=;
	b=Xx4SlMy6QSJAp97sysS2MZ+BkFe3PHHO0CBTr9NIVrPbEWm6Tc4tsVUsYFlEOPg9FsDG1D
	yqXTYzHsREBNsxawxjQP/qv0huii+0iu/tTrTRU+QviUEnDi+Yd11x7bgPblKxTM0rhFvD
	FQctbtwlb7tk19VwKO8na2o5BSB/UyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708519442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgJhFNU0w2euKCzgtnfXaFn6+eWSHDRHzTmuXrUbwU=;
	b=zpKtbHyNzZPV1VOSBF9quyCut1I54YW0S0qMivDVdrWfTKXTHTjiGyjBkmGQ6QRwssC5f4
	wYo7L0AHXnH3gjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C58139D0;
	Wed, 21 Feb 2024 12:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3VHbMhHw1WVdaAAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 21 Feb 2024 12:44:01 +0000
From: Nicolai Stange <nstange@suse.de>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: zhangwarden@gmail.com,  jikos@kernel.org,  joe.lawrence@redhat.com,
  jpoimboe@kernel.org,  linux-kernel-mentees@lists.linuxfoundation.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  live-patching@vger.kernel.org,  mbenes@suse.cz,  mpdesouza@suse.com,
  pmladek@suse.com,  shuah@kernel.org,  skhan@linuxfoundation.org
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
In-Reply-To: <ff1078b2-447d-4ae7-8287-d0affd23588d@gmail.com> (Shresth
	Prasad's message of "Wed, 21 Feb 2024 15:29:39 +0530 (GMT+05:30)")
References: <ff1078b2-447d-4ae7-8287-d0affd23588d@gmail.com>
Date: Wed, 21 Feb 2024 13:44:01 +0100
Message-ID: <878r3eyoku.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xx4SlMy6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zpKtbHyN
X-Spamd-Result: default: False [1.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 INVALID_MSGID(1.70)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,lists.linuxfoundation.org,vger.kernel.org,suse.cz,suse.com,linuxfoundation.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[65.81%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.78
X-Rspamd-Queue-Id: 460011FB66
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Shresth Prasad <shresthprasad7@gmail.com> writes:

> I checked the source code and yes I am on the latest Linux next repo.
>
> Here's the warning:
> /home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatc=
h/test_modules/test_klp_state.c:38:24: warning: assignment to =E2=80=98stru=
ct klp_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
> =C2=A0=C2=A0 38 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logleve=
l_state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^


Is the declaration of klp_get_state() visible at that point, i.e. is
there perhaps any warning about missing declarations above that?

Otherwise C rules would default to assume an 'int' return type.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

