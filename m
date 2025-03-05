Return-Path: <linux-kselftest+bounces-28308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77DA4FF1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F62D3ADE8C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BAF24886A;
	Wed,  5 Mar 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYkk13TG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqSWQihC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYkk13TG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqSWQihC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC132475D0
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179393; cv=none; b=TJgXzycAqTlCZuWo/JELAAbM9vx2xDeapLd/ggh7024WMOsUWJEEP6YIdvywRbp4/XJQOpfNl8ED/zatGPml6+0skbzGnEcyNYqIDMEpiapPsEzgZTc/wwa7gri3F7d23eyU9l5ivIO/M4521UylM/Mdg3haJLRj0kWrMgiKSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179393; c=relaxed/simple;
	bh=7rP1q4sjtPGTwvZCo6TvJK937m2vMlozF4ddOFBImF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nx7F2x0B+6j6C9/PqiVeYBwg/jfMBTgKs8ypuOPOd/D8W+GoMDg9nYfqmfBq6ZNoLn8xJQycXz5z3PGg6ZhOlkjdBaZtS29hoVzqRfmvI5IN5CPDTJ9rboZYflsQDAye9zqlscwFrsPHB4v/CbcleZtz4Vm1nOq1bCYcD5g0xPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYkk13TG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqSWQihC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYkk13TG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqSWQihC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2571F455;
	Wed,  5 Mar 2025 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741179389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMTJEHhe2iHM3A9CeRbjgCSsa/If8US42GvM//vLAL0=;
	b=UYkk13TGu+2jm/3NyxzZibOSqRhWQf8t+4AD8jm8ZVimZ8QkIitwtjI/3b+jzGuA2+Q6e7
	FIo2XcXmMfCq3d5EQtew0gn6bGWXJ3yNMrnJ5dqM8RTOBm35NydCevbcO/lb7JjfsfmeCF
	qgjr10iXna+luJmO+zFxwJKaeJvnm1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741179389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMTJEHhe2iHM3A9CeRbjgCSsa/If8US42GvM//vLAL0=;
	b=PqSWQihCXupiDI21nzFsmWx/KgqHMRyEaV/cbx5o/2wASBnfVi/BV+wB+ZmRhJObu1l3jo
	7+XpL7sMQ4yMM4BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741179389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMTJEHhe2iHM3A9CeRbjgCSsa/If8US42GvM//vLAL0=;
	b=UYkk13TGu+2jm/3NyxzZibOSqRhWQf8t+4AD8jm8ZVimZ8QkIitwtjI/3b+jzGuA2+Q6e7
	FIo2XcXmMfCq3d5EQtew0gn6bGWXJ3yNMrnJ5dqM8RTOBm35NydCevbcO/lb7JjfsfmeCF
	qgjr10iXna+luJmO+zFxwJKaeJvnm1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741179389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMTJEHhe2iHM3A9CeRbjgCSsa/If8US42GvM//vLAL0=;
	b=PqSWQihCXupiDI21nzFsmWx/KgqHMRyEaV/cbx5o/2wASBnfVi/BV+wB+ZmRhJObu1l3jo
	7+XpL7sMQ4yMM4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC91E13939;
	Wed,  5 Mar 2025 12:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OE2iKPpJyGevMQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 05 Mar 2025 12:56:26 +0000
Date: Wed, 5 Mar 2025 23:56:01 +1100
From: David Disseldorp <ddiss@suse.de>
To: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Christian Brauner <christianvanbrauner@gmail.com>, Christian Brauner
 <brauner@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [brauner-github:vfs.all 205/231] WARNING: modpost: vmlinux:
 section mismatch in reference: initramfs_test_cases+0x0 (section: .data) ->
 initramfs_test_extract (section: .init.text)
Message-ID: <20250305235601.464f6432.ddiss@suse.de>
In-Reply-To: <20250305114701.28c0ee0b.ddiss@suse.de>
References: <202503050109.t5Ab93hX-lkp@intel.com>
	<20250305114701.28c0ee0b.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,gmail.com,kernel.org,canb.auug.org.au];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 5 Mar 2025 11:47:01 +1100, David Disseldorp wrote:

> [cc'ing linux-kselftest and kunit-dev]
> 
> Hi,
> 
> On Wed, 5 Mar 2025 01:47:55 +0800, kernel test robot wrote:
> 
> > tree:   https://github.com/brauner/linux.git vfs.all
> > head:   ea47e99a3a234837d5fea0d1a20bb2ad1eaa6dd4
> > commit: b6736cfccb582b7c016cba6cd484fbcf30d499af [205/231] initramfs_test: kunit tests for initramfs unpacking
> > config: x86_64-buildonly-randconfig-002-20250304 (https://download.01.org/0day-ci/archive/20250305/202503050109.t5Ab93hX-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050109.t5Ab93hX-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503050109.t5Ab93hX-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >   
> > >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x30 (section: .data) -> initramfs_test_fname_overrun (section: .init.text)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x60 (section: .data) -> initramfs_test_data (section: .init.text)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x90 (section: .data) -> initramfs_test_csum (section: .init.text)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xc0 (section: .data) -> initramfs_test_hardlink (section: .init.text)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xf0 (section: .data) -> initramfs_test_many (section: .init.text)    
> 
> These new warnings are covered in the commit message. The
> kunit_test_init_section_suites() registered tests aren't in the .init
> section as debugfs entries are retained for results reporting (without
> an ability to rerun them).
> IIUC, the __kunit_init_test_suites->CONCATENATE(..., _probe) suffix is
> intended to suppress the modpost warning - @kunit-dev: any ideas why
> this isn't working as intended?

Stephen Rothwell (cc'ed) mentioned that we might be able to use
__refdata for initramfs_test_cases. The __ref* description in init.h
does indicate that it's suitable, and I now see that it's present in
kunit-example-test.c . I'll propose a patch which can be squashed in
with the existing commit.

Thanks, David

