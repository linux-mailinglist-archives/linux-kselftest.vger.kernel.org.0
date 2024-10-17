Return-Path: <linux-kselftest+bounces-19950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670059A2074
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4D81F276A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B11DA0EB;
	Thu, 17 Oct 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlIkPS/R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmtiCc1w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPZpQ/v8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXWS2Ayl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A081CFEA8;
	Thu, 17 Oct 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162950; cv=none; b=sxzyaf7pdxxPnR8XdQnxiBcXLUfGNFdcNC8OynsCJYjC6BupU2M6df4ys82eGrlqodxt1GiElKxltULOjoGqqZPnSqPrjgMUebiv0M8FVoJqxvF1okfnzrX3YZfARSFO2U32whjzQ6x2LDFepAO6NAmZ4arBWggF1Oa/qnugcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162950; c=relaxed/simple;
	bh=Zti17zEdTPMWDKHNIdgZCRrvFCHtrP8wvz5ruYvdQyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGVnI/jQ+r3S5j4H2rHMKjM7FIh6PWYvLbFLLZ3pkrOauynlpGfPYLleJX/+rQq83QJ5WOrwE3ft7a8qXR+rPEfIQ7P1f2uiKTOhUlBThfR6bNpC3XYZRN1Mj7yw8yinA62leNKECOTAAXIXTJCc9vGLUuz+u2WG7xCxAdsp4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlIkPS/R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmtiCc1w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPZpQ/v8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXWS2Ayl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6CA01FF00;
	Thu, 17 Oct 2024 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729162945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsimjDXOtmZTun9KLOezGQKKRdNWogA3OVHTwBEzwu4=;
	b=zlIkPS/R6usbDO65DmcVwA66S8cPLQeNbQ1kcUHph5TMso/Qn/6BokgYvPvH+FvpHFOtJl
	VJ9x5WDugKf6IwfN5/ZHFujE5nqTfLqx5ytXTfwgTysK3i8ZUAdI1XVTCWCEVpZVjNBfTp
	ypEU4DIBGV+B802Nj1wmEAIyrMF1/1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729162945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsimjDXOtmZTun9KLOezGQKKRdNWogA3OVHTwBEzwu4=;
	b=RmtiCc1wVjpXgQg7brD3wXwC+b4zfdnYyH/YKG2hbUVRYEbfeaiJWHWmCauLVhWFX1xnJZ
	WyaJIC31zrXNMzCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="YPZpQ/v8";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DXWS2Ayl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729162944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsimjDXOtmZTun9KLOezGQKKRdNWogA3OVHTwBEzwu4=;
	b=YPZpQ/v8FssDMx3Z1V0hiHZ3hA2Pcg01dpK28MHM8e6Iln7pkeW19GJe1aqxf61nQZTzhk
	iYLmk9oj7lEDTWMYM6i9LkaIKihIORVEJaILWif5Cw667a97Dd/WPSyW2r05StrMuZ40hW
	mcAKJpqE6xj6K6JvGLpTxQmzECaeN9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729162944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsimjDXOtmZTun9KLOezGQKKRdNWogA3OVHTwBEzwu4=;
	b=DXWS2AylRJvBGs15UXEyi1B9f7q2JLWsq/v4RSde+zNqsxDj+DwdUpQ3IcCsyAS3kzYJhj
	BeR8f7baSBnntLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 939F213A42;
	Thu, 17 Oct 2024 11:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1DS5I8DuEGdMZgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 17 Oct 2024 11:02:24 +0000
Date: Thu, 17 Oct 2024 13:01:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Donald Zickus <dzickus@redhat.com>
Cc: Tim Bird <tim.bird@sony.com>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"automated-testing@lists.yoctoproject.org" <automated-testing@lists.yoctoproject.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	kernelci <kernelci@lists.linux.dev>,
	Nikolai Kondrashov <nkondras@redhat.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	kernelci-members <kernelci-members@groups.io>,
	"laura.nao@collabora.com" <laura.nao@collabora.com>
Subject: Re: [Automated-testing] [RFC] Test catalog template
Message-ID: <ZxDufyLOPSjDxB6A@yuki.lan>
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
 <Zw-7Tydnaaj3XAQo@yuki.lan>
 <CAK18DXYDxfd3cqUdUjLvzMMxvkCma-H6qWbgmAgqyRTNb00TWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK18DXYDxfd3cqUdUjLvzMMxvkCma-H6qWbgmAgqyRTNb00TWA@mail.gmail.com>
X-Rspamd-Queue-Id: A6CA01FF00
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi!
> > A few thousand tests to be more precise, and also the content tend to
> > change between releases, be it test additions or removal and I do not
> > think this level of changes is somehing that makes sense to be tracked
> > in such database.
> >
> > It may be better to have more generic description of LTP subsets, there
> > are a few obvious e.g. "SysV IPC" or "Timers", and have the LTP
> > testrunner map that to actual testcases. The hard task here is to figure
> > out which groups would be useful and keep the set reasonably small.
> >
> > I can move this forward in LTP reasonably quickly we get small list of
> > useful groups from kernel develpers.
> 
> Thanks!  The thought was if we wanted to encourage contributors to run
> these tests before submitting, does running the whole LTP testsuite
> make sense or like you said a targeted set would be much better?

The best answer is "it depends". The whole LTP run can take hours on
slower hardware and may not even test the code you wanted to test, e.g.
if you did changes to compat code you have to build LTP with -m32 to
actually excercise the 32bit emulation layer. If you changed kernel core
it may make sense to run whole LTP, on the other hand changes isolated
to a certain subsystems e.g. SysV IPC, Timers, Cgroups, etc. could be
tested fairly quickly with a subset of LTP. So I think that we need some
kind of mapping or heuristics so that we can map certain usecases to a
subsets of tests.

-- 
Cyril Hrubis
chrubis@suse.cz

