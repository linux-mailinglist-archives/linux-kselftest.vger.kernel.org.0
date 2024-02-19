Return-Path: <linux-kselftest+bounces-4929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382185A52E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376BA285BDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D7E36AF1;
	Mon, 19 Feb 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YXVvc6ki";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KbJioyej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E4364C6;
	Mon, 19 Feb 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350818; cv=none; b=F0VlmY7xVTMliSmc4wRJRedY2GFr3SU8JjvhLjGxe3FTOgNq+nuUOv+3B3o5/v65U3bsC7KJvqMUvp/ddKECSEPanAhKY6gEibGq/XPxEBoiUNpNHUlTNZoJ49mh5E9orpshlz8lF7KhHMpjXY8Hr79XmtheL4hAFMkrG2tJPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350818; c=relaxed/simple;
	bh=mjCeAIQZv6m3D3psvqDPNKm1MymqtEETfxNpQ8BvHoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7AydNt/Tk/TgbBbUy1VfZrQg9q/03yEPRn/YjaaF7VbdIzYNz8E/bu+i5kgVS5YMh4iLrc3LdDXDXHgZtpNIMwarvku6nL9fwBwcQZ22IwAPIyyO/bp2DvUcnGIIhXJuuh8acmEqRN55nfoUrgOmeMolqxF7Gwy5aEntjtRMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YXVvc6ki; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KbJioyej; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E53BE21747;
	Mon, 19 Feb 2024 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708350815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWgx8ZUrqNvRYMebTBHKWkfDEjmiK2tptdVH4AjyYtY=;
	b=YXVvc6ki+BbBR0BE/vR1JOoFmujkPZDgv7Jk9X2GPIpfKcVZ5vrWKBkB0gDpOe+S1UMzEp
	b17aNUQS6vTQJMI1mYRYLXxuRWLRxbVgIqocQj5v6ylGt1tcZZ4jj12X333DaSAd5NIorM
	rzIS7CaoUW+ONHtuHCtA2kSkMRl0Ok4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708350814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWgx8ZUrqNvRYMebTBHKWkfDEjmiK2tptdVH4AjyYtY=;
	b=KbJioyej9rk6fekZDPu2bjoJqFGs3fxeyhyM8L8IGb+vGbsMlvHLEDEiydaRp04KEdwjcq
	HAzCVc/npxIV4qksMQy4OoBdTmQlQq6Fsm7Rf8d/7fXx1TiMjd+91t5mGO5glDBXcu/Yfd
	HPf5zq5SEtZuwjusVCJ+SyBzRTdbE8A=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 66CC513585;
	Mon, 19 Feb 2024 13:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3ETgCl5d02XgCwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Mon, 19 Feb 2024 13:53:34 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: kernel test robot <lkp@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	oe-kbuild-all@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Date: Mon, 19 Feb 2024 10:53:22 -0300
Message-ID: <20240219135325.2280-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240219121522.23480-1-mpdesouza@suse.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:

> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Marcos,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> > base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> > patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
> > patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
> 
> We should ask the kernel test robot machine owners to install kernel-devel
> package in order to have this fixed.

Or maybe ask them to change the reproducer to specify KDIR to the git tree,
instead of /lib/modules/?

> 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki

