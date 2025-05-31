Return-Path: <linux-kselftest+bounces-34108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F5AC9B43
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A888E3B9981
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0B423BF83;
	Sat, 31 May 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH5ih7RK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBD23BCF7;
	Sat, 31 May 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748699514; cv=none; b=rKm+GzyFDTbAef8XxJkNZOjuxZOY+zM67jqPaXpvWEvLPjJ5ORypsmkK85Rx8DszVkw0x5orpbtcOedM4vKr8cOKyBcs4LkQ+r5ZUaeI8iOomLUklph4riN4IYA6NJbANtLmK+BOXKsGOitomMnlcJRiSr6QbXj2XSUHbi+MHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748699514; c=relaxed/simple;
	bh=TjkQgG4bvyolCjKm8gpgiWDCkKosYaVkELekZFpxnvY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ztk8AzWxSGNwWcA1DHmpXA2MFao6QVGNEjCEX6cCpHe8ncK3cmGxjckg5Fz2LiRsnTkCpgOHmxl41cPUY37FgHFBPpoXjkx8EcWgxRUgILHRX2Yw7b5KNQPHIVFblsoNIsHcTKdFMvxf1gpUJGfsDnRZUAThYEb43LWTIsPTmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH5ih7RK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74DFC4CEEF;
	Sat, 31 May 2025 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748699513;
	bh=TjkQgG4bvyolCjKm8gpgiWDCkKosYaVkELekZFpxnvY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SH5ih7RKSdqexXT5A8Sic37lsM0a8noboX5JnN+uGHXoUwZGIHVW4K843gW0HQge1
	 Zjbyg2QGUa4wU7ow6xYB3H8jG/m+j0mxPJAKyf9b0Cr0aaC2IBLayCioPH4suhqbyF
	 b1RB/0v6SaOPntHrLJ7Ct804Rfw6rmUvGkxDJWW01c4sY3Atw0s3d/cruXQEYIODIH
	 GPytMwaL8xaoHz3is0J/TtVbjJX5RHzwbq3U7UH3L+pV77zI5CuYipGpbHHXhcvwlx
	 gN0ia2vxUfI5nlhmIpybV/v+K6r8IR8IPBymXStVpKAZSqp2jpsCm5ZB+qIsGdrnSv
	 62Ywf2OFX5sIA==
Date: Sat, 31 May 2025 06:51:50 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
CC: Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>,
 Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maxime Ripard <mripard@kernel.org>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
 Alessandro Carminati <alessandro.carminati@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/5=5D_bug/kunit=3A_Core_sup?=
 =?US-ASCII?Q?port_for_suppressing_warning_backtraces?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250531102304.GF21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com> <20250526132755.166150-2-acarmina@redhat.com> <20250529090129.GZ24938@noisy.programming.kicks-ass.net> <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com> <20250530140140.GE21197@noisy.programming.kicks-ass.net> <202505301037.D816A49@keescook> <20250531102304.GF21197@noisy.programming.kicks-ass.net>
Message-ID: <8C5E309E-03E5-4353-8515-67A53EC6C9E3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 31, 2025 3:23:04 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Fri, May 30, 2025 at 10:48:47AM -0700, Kees Cook wrote:
>> On Fri, May 30, 2025 at 04:01:40PM +0200, Peter Zijlstra wrote:
>> > I'm not really concerned with performance here, but more with the siz=
e
>> > of the code emitted by WARN_ONCE()=2E There are a *ton* of WARN sites=
,
>> > while only one report_bug() and printk()=2E
>> >=20
>> > The really offensive thing is that this is for a feature most nobody
>> > will ever need :/
>>=20
>> Well, it won't be enabled often -- this reminds me of ftrace: it needs
>> to work, but it'll be off most of the time=2E
>
>Well, ftrace is useful, but when would I *ever* care about this stuff? I
>can't operate kunit, don't give a crap about kunit, and if I were to
>magically run it, I would be more than capable of ignoring WARNs=2E

It's not for you, then=2E :) I can't operate ftrace, but I use kunit almos=
t daily=2E Ignoring WARNs makes this much nicer, and especially for CIs=2E

>Cleaned it up a little bit=2E=2E=2E I'll add some comments on later :-)
>
>I also need to go fix WARN_ONCE(), at least for the n<=3D2 cases that can
>use BUGFLAG_ONCE now=2E

Cool! I'll expand the WARN tests in LKDTM so we can get wider behavioral a=
nd architectural coverage=2E

-Kees


--=20
Kees Cook

