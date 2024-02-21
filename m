Return-Path: <linux-kselftest+bounces-5161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B485D7EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C631F21A33
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBCB54F84;
	Wed, 21 Feb 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Oz7LHx41";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Oz7LHx41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9B53E32;
	Wed, 21 Feb 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518626; cv=none; b=RdNaUnHA0wJHd2jExu7bBXMhoGFzwY1JxkceTtOiz9NcNrgPYBVdJJ+U2jomexX6nOhwa4UePK2NLv+E3dPZp71xPg1dYtxRU4END4+7/mWRM8jPYyKTfoG4eLi57gWdWW0FYFx1TWkyK+uTmyn0UZr01FhGyYtY5BFUvt1g04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518626; c=relaxed/simple;
	bh=1kwO+Ov/rkMoSq6eQXkirPGbfGGxQZZPux5NE5WO6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/qix4Xedv2avhHn3jVpbBOzjsqHM+ZEmIvkDBaCwUiURnED5KX01lw5YC18uDsXGrrcjENJULdhtwPs4FUAWwELu1kzg4kOKUFUdtcGNaqJklmrEf9C/dyE75wcUEto1OPqC3jFwdYRQsKjXZI3J/Eoo3Je9bQbKCqt+r4k+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Oz7LHx41; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Oz7LHx41; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1091FB5A;
	Wed, 21 Feb 2024 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708518622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/3UF1llyRPkvnSOmTVftLToViwl2uA6Cb3KNTWzsjY=;
	b=Oz7LHx41KMUKHOMjOrjKp45nuc5DNefmQznIzfZuYvHQVJ/A1IM2hQ64S0mmWFu+yDHo/9
	knxJWzpR2pC/FOwwtO+Myyrm+Apguz+3SHhIR1sah0D6M8P2Xb/WeXwUjRXIcLHEaIfTFF
	E3pwRHg3eGEHhMrZntrb2ogvca3v+oY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708518622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/3UF1llyRPkvnSOmTVftLToViwl2uA6Cb3KNTWzsjY=;
	b=Oz7LHx41KMUKHOMjOrjKp45nuc5DNefmQznIzfZuYvHQVJ/A1IM2hQ64S0mmWFu+yDHo/9
	knxJWzpR2pC/FOwwtO+Myyrm+Apguz+3SHhIR1sah0D6M8P2Xb/WeXwUjRXIcLHEaIfTFF
	E3pwRHg3eGEHhMrZntrb2ogvca3v+oY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE85A139D1;
	Wed, 21 Feb 2024 12:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WmX0LN3s1WUuMQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 12:30:21 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: kernel test robot <lkp@intel.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
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
Date: Wed, 21 Feb 2024 09:29:47 -0300
Message-ID: <20240221122949.26263-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <202402191502.dALlSRz0-lkp@intel.com>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon, 19 Feb 2024 15:16:51 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Marcos,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc%40suse.com
> patch subject: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191502.dALlSRz0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191502.dALlSRz0-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Makefile:11: warning: overriding recipe for target 'all'
> >> ../lib.mk:62: warning: ignoring old recipe for target 'all'
>    make[1]: *** [../lib.mk:62: all] Error 2
>    Makefile:65: warning: overriding recipe for target 'emit_tests'
>    ../lib.mk:120: warning: ignoring old recipe for target 'emit_tests'
>    make[1]: *** No targets.  Stop.
>    make[1]: *** No targets.  Stop.
>    make[1]: *** No targets.  Stop.

I couldn't reproduce this one locally. Shuah, have you seen this issue in your
setup? I followed the steps to reproduce this issue (it's the same sequence
already reported in earlier patches...)

> 
> 
> vim +/all +11 Makefile
> 
> ^1da177e4c3f41 Linus Torvalds 2005-04-16   7  
> ^1da177e4c3f41 Linus Torvalds 2005-04-16   8  # *DOCUMENTATION*
> ^1da177e4c3f41 Linus Torvalds 2005-04-16   9  # To see a list of typical targets execute "make help"
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  10  # More info can be located in ./README
> ^1da177e4c3f41 Linus Torvalds 2005-04-16 @11  # Comments in this file are targeted only to the developer, do not
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  12  # expect to learn how to build the kernel reading this file.
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  13  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

