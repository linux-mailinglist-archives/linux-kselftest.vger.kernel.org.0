Return-Path: <linux-kselftest+bounces-5676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56CB86D71A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 23:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCF71F23EAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 22:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86DC41C8B;
	Thu, 29 Feb 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FeUQA2v9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6276D528
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247442; cv=none; b=Sn6voqkj89h2eiiphwznTfY+DQTyxL34hkoFZm6B2Y72drUAc2toTWbyWYsIW+dMjokOGcUXpaD27IS3SCQqgMP6RQaN/zZUzzreMgLnMJFoSPeGLkkKwMZh1TkG7MaGGt6jp8PzgMx8hLBOaHt6e0ORSYFIcGiSAJWE7frWesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247442; c=relaxed/simple;
	bh=YI7Y0eL/IE4f+xZR1GuF6vEyLlTj75G+J0s2eyMGAxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u34b2dB48G9cR8Ta8lAbztwrztfbTgMS1OGxMM/2KRD1/IHmfFVwzgNOh010UVUV/WsbdwQXDJgM3tr00M0MLucl8W9GomXWYBSeznq5JDd034W8DUEx1l1fMMyA9hsYdlvQjRd497DvU5gzlsxMbDa7EKiEdTjZg/o0hgXywi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FeUQA2v9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709247437;
	bh=itYBaBippbMWC/C0xJlt/4GyP66AD1FY1F2a8aBFV68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FeUQA2v9Llhv5GuB0CFNiiB3Uk3FQwaNrcHS5NEQ4iiAo18X5w4BcWhuQEkxmVxim
	 M6UBKG/amHEo1ZZzSkcITLj5SjSioqwuOk1pLLgsu7E4lGjfM6ipz8J98e0ncRS8TD
	 S+SybN3BdejymxTdmjDurXam1CoOUugd68OeXmXmDTwEA20GGz2yCU5S8GnPSWLATE
	 X/n8leB89BUuMs6IaVOh11KkJhryfOv4gJE6W4DTgzYdMUZCBqtMZpL3P49TOFVC65
	 Jr9+q6EzX1ehXaOT32NxzNHxjqAEo9rNNc0QZu8V7NC0lsoLPDAPD18ntDI4efms0p
	 SgSg+UBRSj2DQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tm67130jdz4wcb;
	Fri,  1 Mar 2024 09:57:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sachin Sant
 <sachinp@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kselftest@vger.kernel.org, tanzhasanwork@gmail.com
Subject: Re: [kselftests/powerpc] Primitives test build failure with linux-next
In-Reply-To: <CAHp75VekfCq8c9h1k57LRjs2GZQ+ep9SdFbEWbDd98z_ySQ+Lw@mail.gmail.com>
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
 <CAHp75VekfCq8c9h1k57LRjs2GZQ+ep9SdFbEWbDd98z_ySQ+Lw@mail.gmail.com>
Date: Fri, 01 Mar 2024 09:57:17 +1100
Message-ID: <87le72g9pu.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Sachin Sant <sachinp@linux.ibm.co=
m> wrote:
>>
>> Powerpc specific selftests (specifically powerpc/primitives) included in=
 linux-next
>> tree fails to build with following error
>>
>> gcc -std=3Dgnu99 -O2 -Wall -Werror -DGIT_VERSION=3D'"next-20240229-0-gf3=
03a3e2bcfb-dirty"' -I/home/sachin/linux-next/tools/testing/selftests/powerp=
c/include  -I/home/sachin/linux-next/tools/testing/selftests/powerpc/primit=
ives    load_unaligned_zeropad.c ../harness.c  -o /home/sachin/linux-next/t=
ools/testing/selftests/powerpc/primitives/load_unaligned_zeropad
>> In file included from load_unaligned_zeropad.c:26:
>> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or dire=
ctory
>>     7 | #include <linux/bitops.h>
>>       |          ^~~~~~~~~~~~~~~~
>> compilation terminated.
>>
>> The header file in question was last changed by following commit
>>
>> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>>     kernel.h: removed REPEAT_BYTE from kernel.h
>
> Thanks for the report.
> What is missing here are the steps to reproduce it here. E.g., I have
> an x86_64 machine, I can use QEMU if required.

The patch I just posted should fix it.

Cross building the selftests is not too hard, you need a cross toolchain
with libc. There's some instructions on our wiki[1], the tldr is:

  cd ~/tmp
  wget https://toolchains.bootlin.com/downloads/releases/toolchains/powerpc=
64le-power8/tarballs/powerpc64le-power8--glibc--stable-2023.11-1.tar.bz2
  tar -xf powerpc64le-power8--glibc--stable-2023.11-1.tar.bz2
  export CROSS_COMPILE=3D$PWD/powerpc64le-power8--glibc--stable-2023.11-1/b=
in/powerpc64le-linux-
  cd ~/src/linux
  export ARCH=3Dpowerpc
  make defconfig
  make headers
  make -C tools/testing/selftests/powerpc

cheers

1: https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels

