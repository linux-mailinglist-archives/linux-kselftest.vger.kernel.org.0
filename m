Return-Path: <linux-kselftest+bounces-35196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB8ADC6FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 11:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04911888D3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C552C08A6;
	Tue, 17 Jun 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hw1/o4lr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC62C08AC
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153737; cv=none; b=G8qtF07zVb2u6jNBn4pVYrSeItLBKN5VLYtq0095QmB30Q2HAyJGdNDiYbzrKIWP5YmlBvahvdj1WqpN93K3rbRo1adjbrcZ4IrYPHhySNgcPh/uptniRHJMH0OclOfWjDyqoCQ8hFkP6H3tdDCmex/Bd/RrtegPkI6s3LiBZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153737; c=relaxed/simple;
	bh=yU8B2S0rvUJRYS4eDEpg/4azZ5qYIqxzpKab9dnBZz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff6F3S89dDKPbLAS4zwCneN6Exf+RJTWYKUCTOZUWUJWHl5+jbqZSbes6zO1gNaivRI7bgPH16PBQIu5rUk0on2nekORkyIYTk3uUguewzJogjaoKv1NcvPp0neOW2Nic2nkhGnalId+Ke6nTJelDwSGHm96RlLcWtgQii5/qq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hw1/o4lr; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87f1b3a3e7bso728907241.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750153734; x=1750758534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJabXLtW1m0bIrhc/aru55FQgKQQl5SUoAdpl7Ryqe0=;
        b=Hw1/o4lr6VhQg9YPirI80Udk4EkljoaYnWcf4pUFVIk7I7oEMips1IWVXbtAb4BnpK
         1WhZn+tBrlvQkkJpmQqGoyW41lu7QLpw/Xx5sh5iOsnBJi1girisLmTAIcJU/VQ9VwAi
         n2MfPj0fAt0Vtd5FsCqzv3B6iA7E2NWp6baBpSv5FFNyzmuQnrMIxNHdNw79JsMtK04t
         Y14c+4DD76xs9Z3lnG8RxwrJstNPPvy0tHrMoWQLkm1bH3IVzSGg+QX8rPNKfnIkJnrr
         Cc+zm5aoH+S4HqPwj4bRDgWeQZt/EWJK3AtOmE/ZCuX+GdotI7o+abeCK53gKQtCZEtK
         3cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153734; x=1750758534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJabXLtW1m0bIrhc/aru55FQgKQQl5SUoAdpl7Ryqe0=;
        b=shTGHB5X8bE/2cWr4pTFfsaQctTVIyjgLuk3muPfE4KlhbLPj3g4jYci6VceXz2umf
         7K6bQcIoOX36abK5OoG3MNTqLLm6xbIrc6gmeSGrdly2NeFjJ1vjXV0xp8SDe9mVBV3R
         wOMa0UI9FKgR9/rWUPqO0CFtA6Hb9ow68PonUzA1NwoF2e5qR9LC3huwY1326hWAC/Xx
         KDivINsD8CQcYBdVCRNRIBWyYy0kCZsnCHUhVSYKcBC03ZPKDVupEeMh/utGUKCeoz4p
         Zct0Y0WMjK/MpYjAv24hxh5VOqEsSeGjYYRl/DZXOVW96Ai3DOvUkIl/dCzcIsYRtvRn
         aHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGWfljEW3Xq6s/3nJIYh3M5arqv4YgjuJBl3NpFbhbSijMEAldwEQ9bsVTf5jeGCplpf7BGuSufNGVQ4LzksM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2WTsI966JrpzVX6DYt525d5Ka0WZAk1vNpfEaNxgkQXU9sIi
	+8y98aDviJz6vNlecmUmTxxxaWc0uTEg9ALWkPdHr6ugVXFwTmSfMpyr4qr0knIHMa/B8ckXemM
	2obSUKEUTTnFO5psZzOE7V9zDxHWW1rrG5yUTzrc9Gg==
X-Gm-Gg: ASbGnct41tutm1MtfGSfE9TcQp3pnQoGsu9RuXDrFCwGHgjGOr7ZnW++wqNm6SbrtBE
	zpQPZJF1+ufPx7ssTIypNEcAP06+j3g87Sf+YvA2+wkaVN5TpMkGLLwnfW7f8N9Rv+BbIr4DmfN
	I9c4Vp7J59RWvH/oFRVJFRaMSkFcJudSgHwsx2TYB0H4o1c3cJoFYqQZfl3rJfmd8iDtgjldYr/
	mbwkgnMWA0VQ1Q=
X-Google-Smtp-Source: AGHT+IFqlwLfs3w5t0Kke4vusAJ0LDpMDoRdBhRndcFHTCxIPX6kVlBZ7kOElI3G6E8LB5BuhyWmQMy9mQlLjgSj4NQ=
X-Received: by 2002:a05:6102:4b88:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-4e7f632331bmr9323586137.3.1750153734104; Tue, 17 Jun 2025
 02:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYssELHcYKwgGNBMLrfeKZa9swGdLrH7gxqzd4P0kaOiZg@mail.gmail.com>
 <7c101fe5-7c73-4916-a832-d656511eeab8@heusel.eu> <ec18001d-7123-4d13-aea7-a28594cd137b@redhat.com>
In-Reply-To: <ec18001d-7123-4d13-aea7-a28594cd137b@redhat.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Jun 2025 15:18:42 +0530
X-Gm-Features: AX0GCFuBeLu3_hPbiCBoM4g8VWlAFlv6r7WSlxB2DJ9al6JMin7gQdwU7P-bZ5E
Message-ID: <CA+G9fYvoYSpyxpBAcAje6X7707+y9cc84mUrWMvdLtZc3Np1eQ@mail.gmail.com>
Subject: Re: clang: selftests/mm gup_longterm error while loading shared
 libraries liburing.so.2 cannot open shared object file No such file or directory
To: David Hildenbrand <david@redhat.com>
Cc: Christian Heusel <christian@heusel.eu>, clang-built-linux <llvm@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, lorenzo.stoakes@oracle.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 at 01:58, David Hildenbrand <david@redhat.com> wrote:
>
> On 16.06.25 21:14, Christian Heusel wrote:
> > On 25/06/16 11:02PM, Naresh Kamboju wrote:
> >> The following test regressions noticed while running selftests/mm gup_=
longterm
> >> test cases on Dragonboard-845c, Dragonboard-410c, rock-pi-4, qemu-arm6=
4 and
> >> qemu-x86_64 this build have required selftest/mm/configs included and =
toolchain
> >> is clang nightly.
> >>
> >> Regressions found on Dragonboard-845c, Dragonboard-410c, rock-pi-4,
> >> qemu-arm64 and qemu-x86_64
> >>    -  selftests mm gup_longterm fails
> >>
> >> Regression Analysis:
> >>   - New regression? Yes
> >>   - Reproducibility? Yes
> >>
> >> Test regression: selftests mm gup_longterm error while loading shared
> >> libraries liburing.so.2 cannot open shared object file No such file or
> >> directory
>  >> Test regression: selftests mm cow error while loading shared
> libraries>> liburing.so.2 cannot open shared object file No such file or
> directory
> >
> > These do not really look like kernel regressions, rather like a bug in
> > the userspace testing tool =F0=9F=A4=94 Could it be that the tests were=
 not
> > rebuilt for the new liburing or that the dependency is not installed in
> > the test environment?
>
> It looks like the tests were build with liburing around, and then ran
> without liburing around.
>
> Note that the file for example has:
>
> #ifdef LOCAL_CONFIG_HAVE_LIBURING
> #include <liburing.h>
> #endif /* LOCAL_CONFIG_HAVE_LIBURING */
>
> You should be running into similar issues with cow.c, which uses the
> exact same approach for detecting+linking liburing.
>
> So seems like something is off in your testing environment?

The kselftest built with cross toolchain((gcc-13 and clang) vs (arm64 / x86=
_64))
and tar / zipped and exported to NFS and mounted by DUT the
device under test by using overlayfs.

The tar / zipped file has all installed binaries and script files to run te=
sts.

However, The missing debian package onto the userspace has been installed
 + liburing-dev today. This will fix the reported problem.

- Naresh

>
> --
> Cheers,
>
> David / dhildenb
>

