Return-Path: <linux-kselftest+bounces-28260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0AA4F2EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32703AAAA6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B47083F;
	Wed,  5 Mar 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OSGYjKgC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRGjYXwW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OSGYjKgC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRGjYXwW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEC11187
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135635; cv=none; b=cyOAwYHsCUrNott9k+34/a8FS6c+xc4/KpDfi1MxU4UWC0ApxtoDf0GkVPlunkTLfkxhv+17dE9DoFTbtDUDGb0+JOajNVJ3sgtghLJ48ou/lz9qCM5rgf30ktSU354+qYmk7zdZZaczTxk2YK2r2HfFYUT4Z5PctfFK3l/01dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135635; c=relaxed/simple;
	bh=3e3yxcmYtE8ePzutVdEIQRyyeU2zZtXk2gjqjirqaUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCwuUXfKGteKVNjM4MzYt00PAzusvdtxUopMyw2L3SiwkDlIc/qK4uBprPnFD6BfRMqO+V+kUU50lXgN+yalXFKF0kdZLogXtVUnqov5JqH+UtI47BzHrYrnzl47d70N1ubmRcCnQDLLw3FMELpo2QXdT7KaXGn5dos42gbII/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OSGYjKgC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRGjYXwW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OSGYjKgC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRGjYXwW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C7081F393;
	Wed,  5 Mar 2025 00:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741135631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpE1lxZxABOKXIwMHjULgkVKB+Q3oObvwMR0H2N/HFs=;
	b=OSGYjKgCOGRdx5+E+Y4NujEe6IxfyosERMMN0r6dxqu/JBRPcnZiS4eez9iRJVJlgNfQEi
	BLSqq34mmx7HOitASGN5gRWhZeGA8zpqi4f3Zax3rRTpc7Zolz0mxWbv+MUxX+WQlDANaE
	eBO77R9t429WuD5bw3d5o2/5LgRL2Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741135631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpE1lxZxABOKXIwMHjULgkVKB+Q3oObvwMR0H2N/HFs=;
	b=hRGjYXwWTaRS6YjaQCp/fUmuckbrg5MiPv22upMdk04ocTOCamulCI7YwWCLNUTUs3ccw1
	FjSHhp8raLW96MDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OSGYjKgC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hRGjYXwW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741135631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpE1lxZxABOKXIwMHjULgkVKB+Q3oObvwMR0H2N/HFs=;
	b=OSGYjKgCOGRdx5+E+Y4NujEe6IxfyosERMMN0r6dxqu/JBRPcnZiS4eez9iRJVJlgNfQEi
	BLSqq34mmx7HOitASGN5gRWhZeGA8zpqi4f3Zax3rRTpc7Zolz0mxWbv+MUxX+WQlDANaE
	eBO77R9t429WuD5bw3d5o2/5LgRL2Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741135631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpE1lxZxABOKXIwMHjULgkVKB+Q3oObvwMR0H2N/HFs=;
	b=hRGjYXwWTaRS6YjaQCp/fUmuckbrg5MiPv22upMdk04ocTOCamulCI7YwWCLNUTUs3ccw1
	FjSHhp8raLW96MDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D611B1393C;
	Wed,  5 Mar 2025 00:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2cBmIgyfx2esYAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 05 Mar 2025 00:47:08 +0000
Date: Wed, 5 Mar 2025 11:47:01 +1100
From: David Disseldorp <ddiss@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Christian Brauner
 <christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [brauner-github:vfs.all 205/231] WARNING: modpost: vmlinux:
 section mismatch in reference: initramfs_test_cases+0x0 (section: .data) ->
 initramfs_test_extract (section: .init.text)
Message-ID: <20250305114701.28c0ee0b.ddiss@suse.de>
In-Reply-To: <202503050109.t5Ab93hX-lkp@intel.com>
References: <202503050109.t5Ab93hX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C7081F393
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,vger.kernel.org,googlegroups.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,intel.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

[cc'ing linux-kselftest and kunit-dev]

Hi,

On Wed, 5 Mar 2025 01:47:55 +0800, kernel test robot wrote:

> tree:   https://github.com/brauner/linux.git vfs.all
> head:   ea47e99a3a234837d5fea0d1a20bb2ad1eaa6dd4
> commit: b6736cfccb582b7c016cba6cd484fbcf30d499af [205/231] initramfs_test: kunit tests for initramfs unpacking
> config: x86_64-buildonly-randconfig-002-20250304 (https://download.01.org/0day-ci/archive/20250305/202503050109.t5Ab93hX-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050109.t5Ab93hX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503050109.t5Ab93hX-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x30 (section: .data) -> initramfs_test_fname_overrun (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x60 (section: .data) -> initramfs_test_data (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x90 (section: .data) -> initramfs_test_csum (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xc0 (section: .data) -> initramfs_test_hardlink (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xf0 (section: .data) -> initramfs_test_many (section: .init.text)  

These new warnings are covered in the commit message. The
kunit_test_init_section_suites() registered tests aren't in the .init
section as debugfs entries are retained for results reporting (without
an ability to rerun them).
IIUC, the __kunit_init_test_suites->CONCATENATE(..., _probe) suffix is
intended to suppress the modpost warning - @kunit-dev: any ideas why
this isn't working as intended?

Thanks, David

