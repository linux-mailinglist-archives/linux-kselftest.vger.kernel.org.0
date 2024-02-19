Return-Path: <linux-kselftest+bounces-4920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E70859B67
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 05:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D88BB210A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 04:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA6BA2F;
	Mon, 19 Feb 2024 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ny0cysA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BE2114;
	Mon, 19 Feb 2024 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316989; cv=none; b=koL8AxAjmZinaUnbBsC61rlKw+JlZ37dmJoZSNdrG6OeZTXWxs6sniCDr/1YqtUot9wje3Op1SfqkNavFqdAPLhndz+aR3+LHAFGUgqOn/nOKRJNj92+edTjALOZUB0VeL9DaLyqKixulJIgC4IQkFXdoo+S0w3+3d7OlXbnBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316989; c=relaxed/simple;
	bh=SIGWU8j4rGm0JRkqEmRJ5TLOuX98GmQ38UKVMU2NWIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLbexd8snN9hhevJWew9HIzS5xLKSUIbWJXi15c0JqY1b78uCi5u7DdIlF/FQcWfk05MM752XyhdgEeVUc1VAFos1TKiTPTvBAqPr7zEBQFhzm+EnOJ9gpPuYivlvFtihZ/DgSCkbuOlup7iqec5yiLA8ISIjzitVlDrSF0VUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ny0cysA8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708316984;
	bh=NHz/ml8wR7rRyzCrjA+ja5j9Xr/oV+FlgsSVvKeDt4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ny0cysA8UOOXVNACuhPZDYckWEMfXe68/Nus80D26osTI/maRanNzo3ISD3oM62Mn
	 APa4sdFb9dT0VET6oZ+MTMGTK6c10xlBDx1YjnvETdCFA+5nh4zQ2hzZIoJ+lLWks8
	 4wA6L0uoqnR2ajYBkjQ+Ttfn0OUtUYmcYWxfDj4/XcDwaeIli0XlTHcO2O+h56YR0f
	 ey2Sq49ZF4k15QzdzgxJDoUZtr9mtJk+EgLcRl5997KGV+k4QUrDDPLdXl0PCpQhft
	 5AucMPIc5ukmFzyxADSRqzfIE0Wf9PqSp4R1QbY3UGWW1WJT8wN5iMQUMuRbv4pk+3
	 nEL3CCqc2dYBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdV1h4kDzz4wcH;
	Mon, 19 Feb 2024 15:29:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Nathan Lynch
 <nathanl@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: powerpc: Add header symlinks for building
 papr character device tests
In-Reply-To: <20240215215045.GU9696@kitsune.suse.cz>
References: <20240215165527.23684-1-msuchanek@suse.de>
 <87cysxilr5.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
 <20240215192334.GT9696@kitsune.suse.cz>
 <87a5o1ikk0.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
 <20240215215045.GU9696@kitsune.suse.cz>
Date: Mon, 19 Feb 2024 15:29:44 +1100
Message-ID: <877cj113gn.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Thu, Feb 15, 2024 at 01:39:27PM -0600, Nathan Lynch wrote:
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> > On Thu, Feb 15, 2024 at 01:13:34PM -0600, Nathan Lynch wrote:
>> >> Michal Suchanek <msuchanek@suse.de> writes:
>> >> >
>> >> > Without the headers the tests don't build.
>> >> >
>> >> > Fixes: 9118c5d32bdd ("powerpc/selftests: Add test for papr-vpd")
>> >> > Fixes: 76b2ec3faeaa ("powerpc/selftests: Add test for papr-sysparm")
>> >> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> >> > ---
>> >> >  tools/testing/selftests/powerpc/include/asm/papr-miscdev.h | 1 +
>> >> >  tools/testing/selftests/powerpc/include/asm/papr-sysparm.h | 1 +
>> >> >  tools/testing/selftests/powerpc/include/asm/papr-vpd.h     | 1 +
>> >> >  3 files changed, 3 insertions(+)
>> >> >  create mode 120000 tools/testing/selftests/powerpc/include/asm/pap=
r-miscdev.h
>> >> >  create mode 120000 tools/testing/selftests/powerpc/include/asm/pap=
r-sysparm.h
>> >> >  create mode 120000
>> >> > tools/testing/selftests/powerpc/include/asm/papr-vpd.h
>> >>=20
>> >> I really hope making symlinks into the kernel source isn't necessary.=
 I
>> >> haven't experienced build failures with these tests. How are you
>> >> building them?
>> >>=20
>> >> I usually do something like (on a x86 build host):
>> >>=20
>> >> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux- ppc64le_defc=
onfig
>> >> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux- headers
>> >> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux- -C tools/tes=
ting/selftests/powerpc/
>> >>=20
>> >> without issue.
>> >
>> > I am not configuring the kernel, only building the tests, and certainly
>> > not installing headers on the system.
>>=20
>> OK, but again: how do you provoke the build errors, exactly? Don't make
>> us guess please.
>
> cd tools/testing/selftests/powerpc/
>
> make -k
>
>> > Apparently this is what people aim to do, and report bugs when it does
>> > not work: build the kselftests as self-contained testsuite that relies
>> > only on standard libc, and whatever it brought in the sources.
>> >
>> > That said, the target to install headers is headers_install, not
>> > headers. The headers target is not documented, it's probably meant to =
be
>> > internal to the build system. Yet it is not enforced that it is built
>> > before building the selftests.
>>=20
>> <shrug> the headers target is used in Documentation/dev-tools/kselftest.=
rst:
>>=20
>> """
>> To build the tests::
>>=20
>>   $ make headers
>>   $ make -C tools/testing/selftests
>> """
>
> Indeed so it's not supposed to work otherwise. It would be nice if it
> did but might be difficult to achieve with plain makefiles.

It used to work without the headers, but at some point folks decided it
was causing too many problems and building the headers was made mandatory.

Note that by default they aren't installed globally, they just end up in
$KBUILD_OUTPUT/usr/include. So it shouldn't affect the host system.

cheers

