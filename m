Return-Path: <linux-kselftest+bounces-5346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02361861735
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF628CCCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253C84A33;
	Fri, 23 Feb 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qgf7q8FY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qgf7q8FY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F1823CD;
	Fri, 23 Feb 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704773; cv=none; b=QIaZgeDwkh+DbRP9lBQ37DF1onePI1U/KbMx4yludhno7nD714o2KETgCGaeqkZwbfTBsmr26L1rrPiSLu5p2RaBWToyKswXyy3Goa2GnKzCBC+1DawRc1LGX/3PQ2gZb1bLxXGgDu2gPr0UC7Lw2Rj9cKYuHiuGThbbhmg8prE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704773; c=relaxed/simple;
	bh=4qSytJe4tnMwAepg4Nvdm4SEC8+SCPH7B63BsPHxymM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5GZzOmHTZ7jji/tj0WyWDFBZcfrTc8/17BblOWKc374YnfHR3xqhSZcxoM5zr80Da5mGlwi5RcSVP4LwOSi9ptL2uGAlkC3Yv1ntnY/THnsRQf1s+WK4aAiokUEjK+IrxK6YCxBXYezxeBG/ruUKpoj2XLVWT8td9Py/L4YRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qgf7q8FY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qgf7q8FY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C417321FDC;
	Fri, 23 Feb 2024 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708704767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOYP9cXOBNVQsH28eDZ3pDkkW+B28cpy8dhMl1BYBD8=;
	b=qgf7q8FYvNegQU6eeqrndjhOQVKfYnJDYyw8pO70seAGXTXAeOuNwZAY7nOHSAPF9ZhtXs
	EQndG+274hMzE4v3hkKWjfvFcLXHyWppG+jTl+dCAWUzaIKEmCA9JAUM6ltfOkJl7qUvbf
	EoKYL7+Vjc6qRFpEyGu15idIuRQx3rw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708704767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOYP9cXOBNVQsH28eDZ3pDkkW+B28cpy8dhMl1BYBD8=;
	b=qgf7q8FYvNegQU6eeqrndjhOQVKfYnJDYyw8pO70seAGXTXAeOuNwZAY7nOHSAPF9ZhtXs
	EQndG+274hMzE4v3hkKWjfvFcLXHyWppG+jTl+dCAWUzaIKEmCA9JAUM6ltfOkJl7qUvbf
	EoKYL7+Vjc6qRFpEyGu15idIuRQx3rw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 46BE813419;
	Fri, 23 Feb 2024 16:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2TVgBP/D2GWvGwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Fri, 23 Feb 2024 16:12:47 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	kernel test robot <lkp@intel.com>,
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
Subject: Re: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
Date: Fri, 23 Feb 2024 13:12:43 -0300
Message-ID: <20240223161244.17709-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <ZdgTkKSSme5Evgwq@yujie-X299>
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
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, 23 Feb 2024 11:40:00 +0800 Yujie Liu <yujie.liu@intel.com> wrote:

> On Wed, Feb 21, 2024 at 09:29:47AM -0300, Marcos Paulo de Souza wrote:
> > On Mon, 19 Feb 2024 15:16:51 +0800 kernel test robot <lkp@intel.com> wrote:
> > 
> > > Hi Marcos,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> > > base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> > > patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc%40suse.com
> > > patch subject: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191502.dALlSRz0-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202402191502.dALlSRz0-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> Makefile:11: warning: overriding recipe for target 'all'
> > > >> ../lib.mk:62: warning: ignoring old recipe for target 'all'
> > 
> > I couldn't reproduce this one locally. Shuah, have you seen this issue in your
> > setup? I followed the steps to reproduce this issue (it's the same sequence
> > already reported in earlier patches...)
> 
> Hi Marcos,
> 
> This seems to be a warning when compiling futex selftest.
> 
> linux/tools/testing/selftests/futex$ make
> Makefile:11: warning: overriding recipe for target 'all'
> ../lib.mk:62: warning: ignoring old recipe for target 'all'
> 
> There is no such warning if this patch is not applied. Looks like it is
> due to the "all" target is defined in lib.mk but overridden in futex
> Makefile? Could you please help take a look?

I believe that I understood what's going on:

Before this patch, the 'all' from lib.mk target didn't have a "recipe" only
dependencies. The TARGET_GEN_MODS_DIR variable was used while resolving the
dependencies from it.

The proposed patch simplified the process by removing the gen_mods_dir target,
and checked TARGET_GEN_MODS_DIR variable as a recipe.

Per my local tests, we can have two targets with the same name on two different
Makefiles (one that includes in the other in case), as long as only one of them
have a recipe (commands to execute). The dependencies of the target
on the included file would will be checked and executed either way.

But, if both targets have commands to execute, make will say the target was
overridden. In both cases, only the target from the file that includes the other
will execute. I believe this matches the current expectation of the futex
selftests, as they jump on into "functional" directory and execute the tests
there. That makefile also includes lib.mk...

It seems that planned to include more directories since they introduced the
selftests, but never did:


  commit 2aa8470f02a9b9e6a410d1264fe6c8fa6c402eff
  Author: Darren Hart <dvhart@linux.intel.com>
  Date:   Tue May 12 21:07:52 2015 -0700

      selftests: Add futex functional tests

      The futextest testsuite [1] provides functional, stress, and
      performance tests for the various futex op codes. Those tests will be of
      more use to futex developers if they are included with the kernel
      source.

      Copy the core infrastructure and the functional tests into selftests,
      but adapt them for inclusion in the kernel:

      - Update the Makefile to include the run_tests target, remove reference
        to the performance and stress tests from the contributed sources.
      - Replace my dead IBM email address with my current Intel email address.
      - Remove the warrantee and write-to paragraphs from the license blurbs.
      - Remove the NAME section as the filename is easily determined. ;-)
      - Make the whitespace usage consistent in a couple of places.
      - Cleanup various CodingStyle violations.

      A future effort will explore moving the performance and stress tests
      into the kernel.

      1. http://git.kernel.org/cgit/linux/kernel/git/dvhart/futextest.git

Either way, if my change adds a new warning, I think that we can drop that patch
and move on. OTOH, I believe that futex selftests could be simplified in order
to remove this awkward setup to run their tests.

> 
> Thanks,
> Yujie

