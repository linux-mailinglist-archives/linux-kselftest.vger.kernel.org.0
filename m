Return-Path: <linux-kselftest+bounces-5388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462BF861FCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE6B1C23A7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A6249F1;
	Fri, 23 Feb 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h/CHrS0t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h/CHrS0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D735C2E3;
	Fri, 23 Feb 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727520; cv=none; b=Ihi3W5/FPzRV6PPmDCoqNqhwRPCJ6/f9lwpGlvPmbfxcRoMv1fnJBVqlZzZhBnbL2qlP8VDHMD4dFy2Id5JMCEyhzXGi386MLSH/kARNlRNuGbZru6VTM1xwm12WVqjrsVEKHuJvMKUgJ7Z13GBdlxZ0WMRLAH40Mc0+Xft9Efo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727520; c=relaxed/simple;
	bh=CSSfnrBOZr8oER5j70U04tSSJE+PjtiMP6S1SgYinKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjqbahV0Fckd8ANzmUKsF2eC/Xr7Gzvk6tDy7zzhG9848TvQLoME5d6b1R2gedRcagjOvFy59uiviqlI+8otQ8WI9+HVQ5uze0Bsqp2+eg0/H/Yp+/LU+PWtgHlgfCXqsXRer5BWkrRIJjAOLEzFkuUyCHuqUsjhTVsOhAFe5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h/CHrS0t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h/CHrS0t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AFC921E9F;
	Fri, 23 Feb 2024 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708727516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVnaK53xBINKA/CDWOs8fMo7oTELoE+zxqM9rpML8hw=;
	b=h/CHrS0tRTMG8iJA4XXKW0FILU4bB+N/5UUZJoqw1D12lI7/NI2sJL7osABOkgvs1GMViu
	cHNg+Z50MTCOOCVtCHogGCt0neZUMuG0FYRVhbwCvX6dJJ9VxGjfTbe8+Obkfv7jdpzfDm
	R9L5tawSfqXnHAKeo02ePrCreKbhNUo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708727516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVnaK53xBINKA/CDWOs8fMo7oTELoE+zxqM9rpML8hw=;
	b=h/CHrS0tRTMG8iJA4XXKW0FILU4bB+N/5UUZJoqw1D12lI7/NI2sJL7osABOkgvs1GMViu
	cHNg+Z50MTCOOCVtCHogGCt0neZUMuG0FYRVhbwCvX6dJJ9VxGjfTbe8+Obkfv7jdpzfDm
	R9L5tawSfqXnHAKeo02ePrCreKbhNUo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A5DE613419;
	Fri, 23 Feb 2024 22:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xJMeG9sc2WUQWwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Fri, 23 Feb 2024 22:31:55 +0000
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
Date: Fri, 23 Feb 2024 19:31:52 -0300
Message-ID: <20240223223152.13528-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cf6b3ca2-3996-4ebd-858d-eb71a5bd3841@linuxfoundation.org>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

On Fri, 23 Feb 2024 15:07:20 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 2/21/24 15:04, Marcos Paulo de Souza wrote:
> > On Wed, 21 Feb 2024 14:12:00 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> > 
> >> On 2/21/24 05:26, Marcos Paulo de Souza wrote:
> >>> On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>>
> >>>> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
> >>>>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> >>>>>
> >>>>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
> >>>>>>
> >>>>>>> Hi Marcos,
> >>>>>>>
> >>>>>>> kernel test robot noticed the following build errors:
> >>>>>>>
> >>>>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> >>>>>>>
> >>>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> >>>>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> >>>>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
> >>>>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
> >>>>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> >>>>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
> >>>>>>>
> >>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >>>>>>> the same patch/commit), kindly add following tags
> >>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
> >>>>>>>
> >>>>>>> All errors (new ones prefixed by >>):
> >>>>>>>
> >>>>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
> >>>>>>
> >>>>>> We should ask the kernel test robot machine owners to install kernel-devel
> >>>>>> package in order to have this fixed.
> >>>>>
> >>>>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
> >>>>> instead of /lib/modules/?
> >>>>>
> >>>>
> >>>> This would be a regression to automated test rings. Do you have any other
> >>>> solutions?
> >>>
> >>> I would say that we could skip the these tests if kernel-devel package is not
> >>> installed. Would it be acceptable? At least we would avoid such issues like this
> >>> in the future as well.
> >>>
> >>
> >> We have to check and skip build. Something we could do in the livepatch
> >> Makefile. Can you send patch for this - I will oull this in for next
> >> so we don't break test rings.
> > 
> > I added a new patch in the same patchset that would cover this, skipping the
> > build and test if kernel-devel is not installed. The patchset was sent earlier
> > today. Please check if the new patch fixes things on the build robot.
> > 
> 
> Did you send the patch to me so I can apply it on top of what I have in next?

Yes, I have sent the patchset. The message id is

https://lore.kernel.org/linux-kselftest/20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com/T/#t

BTW, you can skip the last patch, since it introduced a warning when running
furex selftests. The rest is ok per Yujie.

> 
> thanks,
> -- Shuah

