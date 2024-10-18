Return-Path: <linux-kselftest+bounces-20141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467899A4149
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE34B23DC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750A1F4269;
	Fri, 18 Oct 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZ/8VTLh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XZqiu3DN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7LBj9iz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7aUq1Maz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF81EE03D;
	Fri, 18 Oct 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262185; cv=none; b=jyk4TK1d7oskGBWtY3CtbjQyLbS0MM0R3vp8E0zYzWDuyMJT39RCFUeeiRKFYBvbcb+MjpOEM1rLY1MJzTHKle87JlLcFNfXB6PXlzElMZyAvVJ1MkwXkPANeV8UNfHWv7hYMtXN5ZL2Umg5f/WBxbKRqTmCVLoiYRxYgNfWsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262185; c=relaxed/simple;
	bh=5epDjfiMaa9pin4fteE1kp57LURHkEYKH2wIKIdpUfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVLg6b3ynfQXjNXcFXxRaLo+ZZ1nrL1ST2fsmgIyJTDt7mkgifjLm2x6gv7kv9EHbBL5bf/r/AJqCJBMD3fK5Cg0urHi55ThOlmfllngPdKLnIeQCpu2la6HyDqz55nhCMpxium31dUvogNA8JFtz+MWl/HOdT7jygURiXWzYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZ/8VTLh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XZqiu3DN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7LBj9iz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7aUq1Maz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E75A421C99;
	Fri, 18 Oct 2024 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729262182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHIFS1nc3HCPUMjfKrnrHIzz1FD8QGBIt1PbxMnXDK8=;
	b=FZ/8VTLh9hhjSGX/ggH4bkuGSThJ15elA2jjpi/2PLOcpbcDCJtFPUP049A/4fsvQ8cWRw
	vFs+EQ+JdT3mKeHd+BB7Dt/TN9KiTuYRT4a/KdzMaMj9Co+VSH3Zlw/wjqiIROa8G9sc9g
	YoCgt6ESMaTPNc0M2HJvohKODs96xws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729262182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHIFS1nc3HCPUMjfKrnrHIzz1FD8QGBIt1PbxMnXDK8=;
	b=XZqiu3DNxmNf3ZuLYZsv2hr+dgoGNeyX1zJfe53USgGGiSmHs5uayprjq9GwU1VgbMMjqS
	GaCCUPJEAbLvzfAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729262181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHIFS1nc3HCPUMjfKrnrHIzz1FD8QGBIt1PbxMnXDK8=;
	b=c7LBj9izEUAe5MMBGWhAwHDnZSeCxA9I9wkvjM7EEY2GIchIjTN6rEUle4lYKcixo5vITE
	TgA1jVKEOb5CKUFkf4RN9OrwvcTFAtEJu0cm9cwTKLydyxMBlo+Z+rfft6mZ96Jc/uDVXM
	t2MqceH17yRT+frK0GcvgQeqUzs+TUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729262181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHIFS1nc3HCPUMjfKrnrHIzz1FD8QGBIt1PbxMnXDK8=;
	b=7aUq1Maz5v/FiBDI0Hxuc5jcRsGtniJpGplmX/MOt33BqWtENWPglkwcV8qloanHb+ZqxC
	mICagdqMeAGsJMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E6613A85;
	Fri, 18 Oct 2024 14:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ckf/MmVyEmf4OQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 18 Oct 2024 14:36:21 +0000
Date: Fri, 18 Oct 2024 16:35:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: David Gow <davidgow@google.com>, Donald Zickus <dzickus@redhat.com>,
	workflows <workflows@vger.kernel.org>,
	automated-testing <automated-testing@lists.yoctoproject.org>,
	linux-kselftest <linux-kselftest@vger.kernel.org>,
	kernelci <kernelci@lists.linux.dev>,
	Nikolai Kondrashov <nkondras@redhat.com>,
	kernelci-members <kernelci-members@groups.io>,
	"laura.nao" <laura.nao@collabora.com>
Subject: Re: [Automated-testing] [RFC] Test catalog template
Message-ID: <ZxJyKZD9vcKnwG0n@yuki.lan>
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
 <192a002ee68.e1e6c6282027214.1199547115557464780@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192a002ee68.e1e6c6282027214.1199547115557464780@collabora.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi!
> Then there are other perspectives that crosses this. For example, many of the LTP and
> kselftests will just fail, but there is no accumulated knowledge on what the result of
> each test means. So understanding what is expected to pass/fail for each platform is
> a sort of dependance in this extensive documentation effort we are set ourselves for.

We are spending quite a lot of time to make sure LTP tests do not fail
unless there is a reason to. If you see LTP tests failing and you think
that they shouldn't just report it on the LTP mailing list and we will
fix that.

-- 
Cyril Hrubis
chrubis@suse.cz

