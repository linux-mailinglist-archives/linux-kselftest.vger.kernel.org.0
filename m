Return-Path: <linux-kselftest+bounces-49242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E65D39118
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 22:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F563011A72
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D712DF701;
	Sat, 17 Jan 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="C6wwJ3b0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746719D07E;
	Sat, 17 Jan 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768685052; cv=none; b=aj0QkSE3zaKaCf7Aoql7kb7WkVb44Ai4v25wBE0e6VWvY029Q3YytL5AFXWFukaiF7U92PyOP12+wZ0JTOCHZq6dLGxL5oseEB8xCGzP7JZ4DQjnIMO3sb7rH+o7rNc5F/YuffFBuHDF5ZGWgb42ZIOR/HVC0ZQm0glKTj8Fo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768685052; c=relaxed/simple;
	bh=damT640QIAWrw1UUgwC9nWxAU9FsTXSNlOmgazewMp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAqI9tnoAdYZfP7EWqbXhe004R32XOfFiJQc7mpovkTYOoxZa1NiZac1yt1e3x82La8elrSFRMVkWWXpw0qTQeCKiWxlllpczhkLWiVr1GmrvNEGD2QyBSH6C35EqkExfcD9VLHx/uYB3SEEB3Hr+51RxqqkNyA+8MqEeLhZqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=C6wwJ3b0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZS9eqf8cBY1x3wIhISPjotjhoDBTuzHKisMxjnWJ7Ws=; t=1768685049;
	x=1769289849; b=C6wwJ3b0JsFWZuF4govybDQuLanb5g8bLnHitueyrNjNZ+t0AX5M3l43TsFxz
	9NzsvIwAhj8LuJL+/ODpcDRErxAWt4xTPwCjjaY6bjXo3CoQsDj7XUnJC+hYDidmjq0KmlAd5CM6x
	w1UShDhwrzbQnD8/EtiIPMtobSj0DfYikkZjimEwmp6idbSOcgfLlO8luirooDyq4M2Jo/3bCrpMV
	62rlcNbKkiW7kHjytpa0XelbGmR45mcgU/G1E0RPqY7trdcSC3vSpkNfM4QQweesawXrmgsdUMBRe
	SxsP8XaQSodwmvSVYsaS667064Fd6eGKxy8NeQbnXfm2fgwM8w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vhDm2-00000000VUy-2911; Sat, 17 Jan 2026 22:23:58 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vhDm2-00000003XZ7-18rV; Sat, 17 Jan 2026 22:23:58 +0100
Message-ID: <a06fe615e4790134e29954ab016b6ec11f24d62c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/3] sparc: Add architecture support for clone3
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jessica Clarke <jrtc27@jrtc27.com>, Ludwig Rydberg
	 <ludwig.rydberg@gaisler.com>
Cc: davem@davemloft.net, andreas@gaisler.com, brauner@kernel.org, 
	shuah@kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 arnd@arndb.de, geert@linux-m68k.org, 	schuster.simon@siemens-energy.com
Date: Sat, 17 Jan 2026 22:23:57 +0100
In-Reply-To: <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
	 <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
	 <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
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

On Fri, 2026-01-16 at 16:47 +0000, Jessica Clarke wrote:
> On Fri, Jan 16, 2026 at 04:30:50PM +0100, Ludwig Rydberg wrote:
> > Add support for the clone3 system call to the SPARC architectures.
> >=20
> > The implementation follows the pattern of the original clone syscall.
> > However, instead of explicitly calling kernel_clone, the clone3
> > handler calls the generic sys_clone3 handler in kernel/fork.
> > In case no stack is provided, the parents stack is reused.
> >=20
> > The return call conventions for clone on SPARC are kept for clone3:
> >   Parent -->  %o0 =3D=3D child's  pid, %o1 =3D=3D 0
> >   Child  -->  %o0 =3D=3D parent's pid, %o1 =3D=3D 1
>=20
> One of the benefits of having a new clone3 is that the interface can be
> made the same across all architectures*, unlike clone, which both passes
> the arguments in different orders for different architectures and, in
> the case of SPARC, has this weird return convention inherited from the
> SunOS syscall interface. Is there a good reason to deviate for clone3
> too and keep this annoying oddity going, that requires special-casing
> SPARC when other architectures can just syscall(__NR_clone3, ...)?

Very good point. Since clone3() is a new syscall, I think it would make mor=
e
sense to use the same interface as all the other architectures.

The weird syscall interface was already the reason why we had to write cust=
om
code for systemd on SPARC in order to use the raw clone() syscall.

I think the proposed implementation of clone3() for SPARC would actually br=
eak
the libcamera build which calls clone3() using the syscall handler [1]:

FAILED: [code=3D1] src/libcamera/libcamera.so.0.6.0.p/process.cpp.o=20
c++ -Isrc/libcamera/libcamera.so.0.6.0.p -Isrc/libcamera -I../src/libcamera=
 -Iinclude -I../include -Iinclude/libcamera -Iinclude/libcamera/ipa -Iinclu=
de/libcamera/internal -Isrc/libcamera/proxy -
I/usr/include/p11-kit-1 -I/usr/include/sparc64-linux-gnu -fdiagnostics-colo=
r=3Dalways -D_GLIBCXX_ASSERTIONS=3D1 -D_FILE_OFFSET_BITS=3D64 -Wall -Winval=
id-pch -Wextra -Werror -std=3Dc++17 -Wnon-virtual-dtor -
Wno-redundant-move -Wmissing-declarations -Wshadow -include /build/reproduc=
ible-path/libcamera-0.6.0/obj-sparc64-linux-gnu/config.h -g -O2 -ffile-pref=
ix-map=3D/build/reproducible-path/libcamera-0.6.0=3D.
-fstack-protector-strong -Wformat -Werror=3Dformat-security -Wno-error -Wda=
te-time -D_FORTIFY_SOURCE=3D2 -fPIC -DLIBCAMERA_BASE_PRIVATE -MD -MQ src/li=
bcamera/libcamera.so.0.6.0.p/process.cpp.o -MF
src/libcamera/libcamera.so.0.6.0.p/process.cpp.o.d -o src/libcamera/libcame=
ra.so.0.6.0.p/process.cpp.o -c ../src/libcamera/process.cpp
../src/libcamera/process.cpp: In member function =E2=80=98int libcamera::Pr=
ocess::start(const std::string&, libcamera::Span<const std::__cxx11::basic_=
string<char> >, libcamera::Span<const int>)=E2=80=99:
../src/libcamera/process.cpp:160:33: error: =E2=80=98SYS_clone3=E2=80=99 wa=
s not declared in this scope; did you mean =E2=80=98SYS_clone=E2=80=99?
  160 |         long childPid =3D syscall(SYS_clone3, &cargs, sizeof(cargs)=
);
      |                                 ^~~~~~~~~~
      |                                 SYS_clone

I'll verify that and report back.

Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=3Dlibcamera&arch=3Dspa=
rc64&ver=3D0.6.0-2&stamp=3D1766489678&raw=3D0

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

