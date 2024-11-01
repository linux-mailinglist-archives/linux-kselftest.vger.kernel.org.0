Return-Path: <linux-kselftest+bounces-21304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4DE9B9454
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A2D1F24DD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DE1C3F32;
	Fri,  1 Nov 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="WcAKc/xg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E871B86F7;
	Fri,  1 Nov 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474616; cv=none; b=mkIKZ2N21AhaxMWNfjkBFqhK0FbR6Cb7HD3qSLTcxZyqTVJuppVt64LflIgG7p0JLLd4jD4dat3daQnQQX/gQYKXsxofUxDhzfo3WZjeGZD0v84Ncm12OmdYw7eCb8iNw/enl/dZepUGgMdMEerNnxgBLRKIk6E36vN0GVFvMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474616; c=relaxed/simple;
	bh=1lSNsaHIimMFo1UCaMuCdQiZilhCgJx4nlx+WOXHOec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5oYgVCUq9J+gwThAc8SNCcbPjhuVAOVp6MAI6G2Oa5tQXal18I/dZU2j81arGFe1L7eD4eczlL7FxGubhUdFGNN+hKSnRb2FsknX4nbdVksj6J+226iNQyr5JvCMEOSL5pprQpJvPkrzfOthWON4XwePtSsRTmMUWaQMG2k3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=WcAKc/xg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1730474609; bh=1lSNsaHIimMFo1UCaMuCdQiZilhCgJx4nlx+WOXHOec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcAKc/xgTp/3Iqi4tC60L/iKtU+kQRSn8NJ7KXKsZ//+dfGAKJAHocyRgoSWk9gcZ
	 uczVWTkq8gWIOMgssy9E1Uh/P4Twz2+l70HQ5JFSEPy62/pKtWMEjq76HSIZEl/kc8
	 HaYwd1fHW802b4UZPtgq9jcmOEIqUD+GyyZraDkM=
Date: Fri, 1 Nov 2024 15:23:16 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alyssa Ross <hi@alyssa.is>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kunit: enable hardware acceleration when available
Message-ID: <5d855199-d054-43f2-b209-23bbfa5f6d92@t-8ch.de>
References: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
 <20241025-kunit-qemu-accel-macos-v1-2-2f30c26192d4@gmail.com>
 <jhmonkl53vrgz3pjhbbopvrx6infgbezlsvba3luccrpwtnmtb@ptobfcxrr4ud>
 <CAJ-ks9m8AD2fon4Nxvc_S-DwY4TkRPHpq0icT0jPwCiCxy6Tqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9m8AD2fon4Nxvc_S-DwY4TkRPHpq0icT0jPwCiCxy6Tqw@mail.gmail.com>

On 2024-11-01 10:49:36-0400, Tamir Duberstein wrote:
> On Fri, Nov 1, 2024, 09:52 Alyssa Ross <hi@alyssa.is> wrote:
> >
> > On Fri, Oct 25, 2024 at 05:03:54PM -0400, Tamir Duberstein wrote:
> > > @@ -124,6 +125,29 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > >                               '-no-reboot',
> > >                               '-nographic',
> > >                               '-serial', self._serial] + self._extra_qemu_params
> > > +             accelerators = {
> > > +                     line.strip()
> > > +                     for line in subprocess.check_output([qemu_binary, "-accel", "help"], text=True).splitlines()
> > > +                     if line and line.islower()
> > > +             }
> > > +             if 'kvm' in accelerators:
> > > +                     try:
> > > +                             with open('/dev/kvm', 'rb+'):
> > > +                                     qemu_command.extend(['-accel', 'kvm'])
> > > +                     except OSError as e:
> > > +                             print(e)
> > > +             elif 'hvf' in accelerators:
> > > +                     try:
> > > +                             for line in subprocess.check_output(['sysctl', 'kern.hv_support'], text=True).splitlines():
> > > +                                     if not line:
> > > +                                             continue
> > > +                                     key, value = line.split(':')
> > > +                                     if key == 'kern.hv_support' and bool(value):
> > > +                                             qemu_command.extend(['-accel', 'hvf'])
> > > +                                             break
> > > +                     except subprocess.CalledProcessError as e:
> > > +                             print(e)
> > > +
> >
> > QEMU supports falling back if one accelerator is not available, if you
> > specify multiple like -accel kvm:tcg.  Couldn't you rely on that rather
> > than re-implementing the availability checks here?
> 
> Have you ever used that? Here's what I get when I try:
> 
> tamird@Tamirs-MacBook-Pro linux % tools/testing/kunit/kunit.py run
> --arch arm64 --make_options LLVM=1 --raw_output=all
> [10:45:03] Configuring KUnit Kernel ...
> [10:45:03] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=arm64 O=.kunit olddefconfig LLVM=1
> Building with:
> $ make all compile_commands.json ARCH=arm64 O=.kunit --jobs=12 LLVM=1
> [10:45:07] Starting KUnit Kernel (1/1)...
> Running tests with:
> $ qemu-system-aarch64 -nodefaults -m 1024 -kernel
> .kunit/arch/arm64/boot/Image.gz -append 'kunit.enable=1
> console=ttyAMA0 kunit_shutdown=reboot' -no-reboot -nographic -serial
> stdio -accel kvm:tcg -machine virt -cpu max
> qemu-system-aarch64: -accel kvm:tcg: invalid accelerator kvm:tcg
> 
> The same thing happens with hvf:kvm:tcg or just hvf:tcg.

That syntax is for -machine accel=hvf:kvm:tcg.
But you can also specify -accel multiple times.

> I also can't find this in the documentation.

-accel name[,prop=value[,...]]
      This  is used to enable an accelerator. [..]
      If there is more than one accelerator specified,
      the next one is used if the previous one fails to initialize.

-machine [type=]name[,prop=value[,...]]
      Supported machine properties are:

      accel=accels1[:accels2[:...]]
	     [..]
	     If there is more than one accelerator specified,
	     the next one is used if the  previous one fails to initialize.


Thomas

