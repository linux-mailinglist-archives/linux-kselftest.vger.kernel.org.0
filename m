Return-Path: <linux-kselftest+bounces-49303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69CAD3972F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C68130056D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB33328E1;
	Sun, 18 Jan 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jOJxQHEv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9633AD9B;
	Sun, 18 Jan 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768747180; cv=none; b=CCSSJoj7ukHZ4TTU4JKOureZrd1jG7zCYeuxZPRZAGJv5fF+tyqg1VmwOWDsc1hIx3wnQSP9WRkCAgks8fBsN9fXdz8E9eTKZZAaWwGydnBDxyUIXQCuPp0YQkTySGDUPavCC7YjqWdYY1LFSlAIZrC0/xM6pi+KJJ4s7aj7POM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768747180; c=relaxed/simple;
	bh=ZUVQgD8JZV17RTL6RV0QvIigZLPZLGEDwYCEhh29kT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NeOZfait6/FGfO0pO9h/c4tigLOU1k+T4HLcbySiL3P3wuelvoQ4pK5S5nlCF689KmBlpYqiF+fSZjn7ezSFF4cT2ul3onZ1smEpPthSMssubgUqkpBeMBn3124ixFqdUi8DnEgvV8aA7VSLFvj+I8YGabDD/DkeDHly1ccAyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jOJxQHEv; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=GDwAhQba4DcLFDUD7BKPAMnLjKl2pDznGFWtdg/A+v8=; t=1768747176;
	x=1769351976; b=jOJxQHEvtbA4JPHO27v/sqgePAl/G0xp+/kCn4F0kyws4mR/EShS0OCaTyQso
	yqH0nsXhQrOlE2KOHLxMrW1L2hZEHbTL7uS6zS/Jp4ya2f+DSGlklynhHu0sT6CpsAoEmj+VS/ECu
	e+GFY4iqRpR9n0c9VlrgIEdkiyZbKO/OQQBud0GqZj+4BDUon7U3o2NTHQoOgk6PHgS0mxVHxQ7/w
	pe4kInxoJE+r6qtKT8xFva63QFD7R39+TdT3R0H83SLA3mHbyLzRp/NqfN08+A6tzYNIlprG+9GgQ
	0p/LPJb5vhqwjCa7oWAyBK7TJCnEL4e+2wvYM+onEhwrwiPVrQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vhTw8-000000038Ee-33m4; Sun, 18 Jan 2026 15:39:28 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vhTw8-000000016n8-23Xf; Sun, 18 Jan 2026 15:39:28 +0100
Message-ID: <e039b9f44b6856d1fd7173dcbdc1a24738ed6cfc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/3] sparc: Add architecture support for clone3
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jessica Clarke <jrtc27@jrtc27.com>, Ludwig Rydberg
	 <ludwig.rydberg@gaisler.com>
Cc: davem@davemloft.net, andreas@gaisler.com, brauner@kernel.org, 
	shuah@kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 arnd@arndb.de, geert@linux-m68k.org, 	schuster.simon@siemens-energy.com
Date: Sun, 18 Jan 2026 15:39:27 +0100
In-Reply-To: <a06fe615e4790134e29954ab016b6ec11f24d62c.camel@physik.fu-berlin.de>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
		 <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
		 <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
	 <a06fe615e4790134e29954ab016b6ec11f24d62c.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Sat, 2026-01-17 at 22:23 +0100, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> On Fri, 2026-01-16 at 16:47 +0000, Jessica Clarke wrote:
> > On Fri, Jan 16, 2026 at 04:30:50PM +0100, Ludwig Rydberg wrote:
> > > Add support for the clone3 system call to the SPARC architectures.
> > >=20
> > > The implementation follows the pattern of the original clone syscall.
> > > However, instead of explicitly calling kernel_clone, the clone3
> > > handler calls the generic sys_clone3 handler in kernel/fork.
> > > In case no stack is provided, the parents stack is reused.
> > >=20
> > > The return call conventions for clone on SPARC are kept for clone3:
> > >   Parent -->  %o0 =3D=3D child's  pid, %o1 =3D=3D 0
> > >   Child  -->  %o0 =3D=3D parent's pid, %o1 =3D=3D 1
> >=20
> > One of the benefits of having a new clone3 is that the interface can be
> > made the same across all architectures*, unlike clone, which both passe=
s
> > the arguments in different orders for different architectures and, in
> > the case of SPARC, has this weird return convention inherited from the
> > SunOS syscall interface. Is there a good reason to deviate for clone3
> > too and keep this annoying oddity going, that requires special-casing
> > SPARC when other architectures can just syscall(__NR_clone3, ...)?
>=20
> Very good point. Since clone3() is a new syscall, I think it would make m=
ore
> sense to use the same interface as all the other architectures.
>=20
> The weird syscall interface was already the reason why we had to write cu=
stom
> code for systemd on SPARC in order to use the raw clone() syscall.
>=20
> I think the proposed implementation of clone3() for SPARC would actually =
break
> the libcamera build which calls clone3() using the syscall handler [1]:
>=20
> FAILED: [code=3D1] src/libcamera/libcamera.so.0.6.0.p/process.cpp.o=20
> c++ -Isrc/libcamera/libcamera.so.0.6.0.p -Isrc/libcamera -I../src/libcame=
ra -Iinclude -I../include -Iinclude/libcamera -Iinclude/libcamera/ipa -Iinc=
lude/libcamera/internal -Isrc/libcamera/proxy -
> I/usr/include/p11-kit-1 -I/usr/include/sparc64-linux-gnu -fdiagnostics-co=
lor=3Dalways -D_GLIBCXX_ASSERTIONS=3D1 -D_FILE_OFFSET_BITS=3D64 -Wall -Winv=
alid-pch -Wextra -Werror -std=3Dc++17 -Wnon-virtual-dtor -
> Wno-redundant-move -Wmissing-declarations -Wshadow -include /build/reprod=
ucible-path/libcamera-0.6.0/obj-sparc64-linux-gnu/config.h -g -O2 -ffile-pr=
efix-map=3D/build/reproducible-path/libcamera-0.6.0=3D.
> -fstack-protector-strong -Wformat -Werror=3Dformat-security -Wno-error -W=
date-time -D_FORTIFY_SOURCE=3D2 -fPIC -DLIBCAMERA_BASE_PRIVATE -MD -MQ src/=
libcamera/libcamera.so.0.6.0.p/process.cpp.o -MF
> src/libcamera/libcamera.so.0.6.0.p/process.cpp.o.d -o src/libcamera/libca=
mera.so.0.6.0.p/process.cpp.o -c ../src/libcamera/process.cpp
> ../src/libcamera/process.cpp: In member function =E2=80=98int libcamera::=
Process::start(const std::string&, libcamera::Span<const std::__cxx11::basi=
c_string<char> >, libcamera::Span<const int>)=E2=80=99:
> ../src/libcamera/process.cpp:160:33: error: =E2=80=98SYS_clone3=E2=80=99 =
was not declared in this scope; did you mean =E2=80=98SYS_clone=E2=80=99?
>   160 |         long childPid =3D syscall(SYS_clone3, &cargs, sizeof(carg=
s));
>       |                                 ^~~~~~~~~~
>       |                                 SYS_clone
>=20
> I'll verify that and report back.

I can confirm that libcamera builds fine and passes its testsuite with a pa=
tched kernel:

Ok:                38
Expected Fail:     1
Fail:              0
Skipped:           31

Full log written to /home/glaubitz/libcamera/libcamera-0.6.0/obj-sparc64-li=
nux-gnu/meson-logs/testlog.txt
make[1]: Leaving directory '/home/glaubitz/libcamera/libcamera-0.6.0'

Whether the currently chosen interface is the right one, is another questio=
n though.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

