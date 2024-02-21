Return-Path: <linux-kselftest+bounces-5160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA085D7E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0641F2174C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC753816;
	Wed, 21 Feb 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iRWuvZVc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iRWuvZVc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF88524CC;
	Wed, 21 Feb 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518392; cv=none; b=Cxh/ohZjjpBBG/dk7XboCBtHMBOJ21PJsEGN7aPle4cQKp6+ZQz1OOAQFoYvffxQU2Inr1kO6xPyjprSw0qR+l0ScksubXWRxW8jI+yqzmHq0ReZj1E2sHsFnPKgjYz6CtM+F11664nss3K5dtb/M1rBShWnebph5ogIQP9bsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518392; c=relaxed/simple;
	bh=zfSCybRmbb/lrtG9gfA1Ai/ZsUMy3YqqpsG1e7POSyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbUy1NKmcFxjl0l0slB3zk4Geh7YPMKghoSpV/vnSlXsoRk07JYuO3JbMiXxKIxzuUaqZPo4WLEhd85uRk0qtW18uRoUwY59D3bH5CCSOuVnfEzV9QeXr2y4OfI2IcRVbuY9cy7fXYq7xpvCrAIQUdzu9PB4AbVr2Qdfk+0no8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iRWuvZVc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iRWuvZVc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E8A01FB5D;
	Wed, 21 Feb 2024 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708518388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nm0QM3k1zWdm3vn93j0VrJgcVj1uHSl3xw8GClBQ9Q=;
	b=iRWuvZVcgB3QZv4oa/f7wkeTod9VaDkgrmYiuj2bk33Rr7tt+vjatq1ZNoB3dr7UWwNKrW
	EIv+FAd1fWq+Y6GqgVrsEkSP7L0bTrbZkjFMatP2tVo/uuo3nTjmonM1tr8pyjzZ7ZXXmx
	1uiRI33cLVCTPD2UeCdJg+Y7egTCeNg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708518388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nm0QM3k1zWdm3vn93j0VrJgcVj1uHSl3xw8GClBQ9Q=;
	b=iRWuvZVcgB3QZv4oa/f7wkeTod9VaDkgrmYiuj2bk33Rr7tt+vjatq1ZNoB3dr7UWwNKrW
	EIv+FAd1fWq+Y6GqgVrsEkSP7L0bTrbZkjFMatP2tVo/uuo3nTjmonM1tr8pyjzZ7ZXXmx
	1uiRI33cLVCTPD2UeCdJg+Y7egTCeNg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA109139D1;
	Wed, 21 Feb 2024 12:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zYQyKPPr1WUMMAAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 12:26:27 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	kernel test robot <lkp@intel.com>,
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
Date: Wed, 21 Feb 2024 09:26:23 -0300
Message-ID: <20240221122624.30549-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <c3ee4083-fca7-43cc-b955-3b7e4faed2b0@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
> > On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > 
> >> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
> >>
> >>> Hi Marcos,
> >>>
> >>> kernel test robot noticed the following build errors:
> >>>
> >>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> >>>
> >>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> >>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> >>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
> >>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
> >>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> >>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
> >>
> >> We should ask the kernel test robot machine owners to install kernel-devel
> >> package in order to have this fixed.
> > 
> > Or maybe ask them to change the reproducer to specify KDIR to the git tree,
> > instead of /lib/modules/?
> > 
> 
> This would be a regression to automated test rings. Do you have any other
> solutions?

I would say that we could skip the these tests if kernel-devel package is not
installed. Would it be acceptable? At least we would avoid such issues like this
in the future as well.

> 
> We could remove livepatch from default test until these changes are made
> to test ring environments?
> 
> thanks,
> -- Shuah

