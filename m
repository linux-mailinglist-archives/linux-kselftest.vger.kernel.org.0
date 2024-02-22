Return-Path: <linux-kselftest+bounces-5259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA53485EEDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 03:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C62830FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 02:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9371400A;
	Thu, 22 Feb 2024 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EFMyLwKr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EFMyLwKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D27125D7;
	Thu, 22 Feb 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567511; cv=none; b=NU5RWU0xzKp4jubk0e1uf3mrhD4vSM2W1KpCRlYl7BMxMCMzRWu8HeH8d/viuYeneh/avggBc39HJ6MafzIxPIOxYYouuY7yc7+WW6hkZ6B2VjhWUkNtl5GO2opxCqvYK00EDFMHZdjTw/hnPJAE8g2yI8sBs7R95UH+rcqRw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567511; c=relaxed/simple;
	bh=3m2O0gxqVD4leeDPk3EpgqVSoMqn/AGGWB8HA13FHP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbF0vFT741xxhXxbP+BnFF0xZE0v2QU2wROhLJ4x6iqcLVEGhj7N2G/QaxKlregqsrERv7o2wVafjhMKEnkEW8HBY9X+ao5xfxuaB54sa6Rt011Gz/iGyhj/1JF2Utalks602F+axjQSL5dv79fCJsuUrehgPw7L/Sb17cv9Gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EFMyLwKr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EFMyLwKr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A99EC21FEF;
	Thu, 22 Feb 2024 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708567499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt2nTJyCo2DcsFR2s8JybA6/3TKUrIMwu//hSiSPmVk=;
	b=EFMyLwKrIv2T/TF+cLB4CGTgD/P/SAUnitjVyiw/hHJqjncyIlIe/EPUxTnreAIAyUk1vx
	7h6ebhwTHigc5XL7GqVaOvd2q8Zwr4L6emwPkiSJjvaRrE24kKkRUySbhjsc7yUqRwUP3M
	hNmxbIUlr1pJ8aCQG1nCwyiQP+EUhvw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708567499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt2nTJyCo2DcsFR2s8JybA6/3TKUrIMwu//hSiSPmVk=;
	b=EFMyLwKrIv2T/TF+cLB4CGTgD/P/SAUnitjVyiw/hHJqjncyIlIe/EPUxTnreAIAyUk1vx
	7h6ebhwTHigc5XL7GqVaOvd2q8Zwr4L6emwPkiSJjvaRrE24kKkRUySbhjsc7yUqRwUP3M
	hNmxbIUlr1pJ8aCQG1nCwyiQP+EUhvw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 35F12134AF;
	Thu, 22 Feb 2024 02:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id W7QtOsqr1mXTUAAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Thu, 22 Feb 2024 02:04:58 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
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
Date: Wed, 21 Feb 2024 23:04:55 -0300
Message-ID: <20240222020456.28532-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <ZdajMy061zaqq8fP@yujie-X299>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EFMyLwKr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: A99EC21FEF
X-Spam-Flag: NO

On Thu, 22 Feb 2024 09:28:19 +0800 Yujie Liu <yujie.liu@intel.com> wrote:

> On Wed, Feb 21, 2024 at 07:04:03PM -0300, Marcos Paulo de Souza wrote:
> > On Wed, 21 Feb 2024 14:12:00 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> > 
> > > On 2/21/24 05:26, Marcos Paulo de Souza wrote:
> > > > On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> > > > 
> > > >> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
> > > >>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > > >>>
> > > >>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
> > > >>>>
> > > >>>>> Hi Marcos,
> > > >>>>>
> > > >>>>> kernel test robot noticed the following build errors:
> > > >>>>>
> > > >>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> > > >>>>>
> > > >>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> > > >>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> > > >>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
> > > >>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
> > > >>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > >>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
> > > >>>>>
> > > >>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > >>>>> the same patch/commit), kindly add following tags
> > > >>>>> | Reported-by: kernel test robot <lkp@intel.com>
> > > >>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
> > > >>>>>
> > > >>>>> All errors (new ones prefixed by >>):
> > > >>>>>
> > > >>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
> > > >>>>
> > > >>>> We should ask the kernel test robot machine owners to install kernel-devel
> > > >>>> package in order to have this fixed.
> > > >>>
> > > >>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
> > > >>> instead of /lib/modules/?
> > > >>>
> > > >>
> > > >> This would be a regression to automated test rings. Do you have any other
> > > >> solutions?
> > > > 
> > > > I would say that we could skip the these tests if kernel-devel package is not
> > > > installed. Would it be acceptable? At least we would avoid such issues like this
> > > > in the future as well.
> > > > 
> > > 
> > > We have to check and skip build. Something we could do in the livepatch
> > > Makefile. Can you send patch for this - I will oull this in for next
> > > so we don't break test rings.
> > 
> > I added a new patch in the same patchset that would cover this, skipping the
> > build and test if kernel-devel is not installed. The patchset was sent earlier
> > today. Please check if the new patch fixes things on the build robot.
> 
> Hi Shuah, Hi Marcos,
> 
> Sorry for this wrong report. The files are organized in a different way
> in the bot and cause this issue. We have fixed the bot to explicitly
> set KDIR to the correct path before building the selftests. The patch
> [1] can also work well in bot's environment.
> 
> [1] https://lore.kernel.org/all/20240221-lp-selftests-fixes-v2-2-a19be1e029a7@suse.com/

Hi Yujie, thanks for letting us know that the bot had different settings. Either
way the patch you mentioned should help to reduce noise in the future on
bot's that doesn't have kernel-devel installed.

Again, thanks a lot for fixing the issue!
  Marcos

> 
> Best Regards,
> Yujie

