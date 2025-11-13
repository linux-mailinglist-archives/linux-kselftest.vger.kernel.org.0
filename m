Return-Path: <linux-kselftest+bounces-45585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC35C59ECC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21CE8344D42
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17F2FD1D9;
	Thu, 13 Nov 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hO7A4Jj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51027B348
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064841; cv=none; b=cJk2Vked5Gh/49e6lG55RSaIyfmXZ3d/v07g/h0Y1c7i0jUETq0cI3PKuqyvqnQgjhu9SVIICTV3W3ttjg4y25YE68Laxqg6Q7s0XkMDmnQk3i6bvl1s4WEh/jBe/RXbF/57bV1J1e81IXt1Uv7h+Uu2uSe+aMUMoxAkgug0A9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064841; c=relaxed/simple;
	bh=cgrHeA2dwRNJRuS3NPXszdAtqyyXx5jZH2HnI9g1mWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwnQ78jBcgQkJyfy8lFfcYvJcVLKHNaEEM5Bb899mVLQRaAz08cNPpdyezYalvxPIzAv/GUgUYMlJdnHb4TmlGzdJfViow5jddW2DxIdg4wv1NuCfrKFemimvATqEvWjnmsFjiYFBfNDs5NPJ1cY5KaWEOOKXLPMRjqe4e8YIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hO7A4Jj6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so2053402a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763064838; x=1763669638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5WVCcQA0Nc9ynxNx/rxTvZahrW/VbsfxFWCQnWaLJk=;
        b=hO7A4Jj6TVyLQmQwSUK+FxUPvZEHOte+NMzPCtFwT0rLegX35jCA2hNOEXh9dZOOnv
         f10wxThDbaCDQ2ZiW2L5vqy7+MGEN7A8J/SWdJisnnlNTNIrzTXTMQc44TD7ueWXJBKR
         cUHlNMP0H5uSnuyDRElitakLGJB+LBUZ5Obf6p//kXo2IdEu7nTqPcWptQTVgCVKTNV5
         vZQkTVojHUOVvSutJ0otc3qZooCGVzGmhlNyGAFdCJkz6TwxedEQhLDnoog2A4PYP3kg
         Qu7WzfQSwnidePAtiyxuC5GJ0i4wCNA8qGzt4TjE6xoA6iCvuigldTQ+D6PMTRFntjpi
         EWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064838; x=1763669638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5WVCcQA0Nc9ynxNx/rxTvZahrW/VbsfxFWCQnWaLJk=;
        b=Qoh+0pk72tIzbh4d+jacs4rcm5TUwxigs+foIaBkMTyYhNvriLzhAwxQFFv6OWTSAT
         VDMWPfqmJC37tN2Jn7xlYFzUAVt8IGmhjLUZ5SOhcWpdQkajaTovDXlElxBS0qT4FAwx
         en8zxchh5M9jZS4vqsb4MIPnpo5cqIallfOFypnVRqgZWlu0JCq5KCdtuQN3vWex+UuM
         6ZqBz56Tjb5Yp97DWQRMzj5DbWUFu5ioHbY0EQn8V4SVgXla7YKcJ8Pcsvbnf7+Pbg4r
         NNnPTKUy8obDn12o4PkxC9/Mp5QBGXx/fpN+jDr0njVeI84Ih0J2kNWtY0pJ2Wno9TOu
         PX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU80gLlwWgMe0HQ9xEN5cIKtXkL9farl593eValmKuNR9IId3498xYNMa4XyA+HJvBezkb2XwE98xQuycA+Oe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjm/5hi1euE0qi7JDyC09QxJ10/VrLrvMFbxtga0GhGcIZ2l+I
	MNiSYgDKo6Od4z54GcDDbeR3h9JXAzlA2hTPxOExsmOieyo3+e9HKLBQYuWYll8U7WV5IIAZB79
	5X60BbngWsWm+3VOuEqLzK3qfCTBvS2nm1fy3xRc9Hg==
X-Gm-Gg: ASbGncu5Zfc9HnHnX/zhZ49UssN2Oq+RkqEVeP6ouEKRXvCme5A8EQeeNHerdA9XAHf
	p67nt7pR+39BMvKDd4UWWFjDGHNp3cX7yL0NDyzg0GkP1wYDUoX4rsR2mKTasZ4n04G9kRapFNX
	bAirW75hVlNg2j4O59rrHxMS19xjEF8uovsVrlKjVYgBLtPHnxjra2QciuldjW1cmzjzZRXUR+p
	QLPTyBmRUVSn9SAhTDsJkjdN/8bAuyfbVIrSIEDrtuHqHTwzKkNictwmA==
X-Google-Smtp-Source: AGHT+IHk2DiUUy/xNwDtwZautO7acJDvr0M6jMmicQX7WgglAjHdW5I4cD1JskoIx/tv/1OALKLJImDpFRebYAI4FVg=
X-Received: by 2002:a05:6402:3506:b0:640:9b62:a8bb with SMTP id
 4fb4d7f45d1cf-64350e89ad2mr411863a12.22.1763064838507; Thu, 13 Nov 2025
 12:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev> <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev> <mafs0qzu69gei.fsf@kernel.org>
 <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
 <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev> <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
 <9e144e21-a5e7-4c12-b8b0-07172787ab37@linux.dev> <CA+CK2bBQxB7ihmhBa76vJbdD988B+8PBrV4arDSNqjv_VB4DVw@mail.gmail.com>
In-Reply-To: <CA+CK2bBQxB7ihmhBa76vJbdD988B+8PBrV4arDSNqjv_VB4DVw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 15:13:20 -0500
X-Gm-Features: AWmQ_bk1wk0wGCneUvxEMQLoqh3QSRk09hjuZwzxox1hVPC9Dl6J8B2vKcwHXN0
Message-ID: <CA+CK2bCUN6SH7x=DnTFvCgEYGKoyOrCMzwQjHCY0LK35Hd-_zA@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 3:10=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> >   set -e
> >
> > -kexec -l -s --reuse-cmdline /boot/bzImage
> > +kexec -l -s --reuse-cmdline /boot/bzImage --initrd
> > /boot/initramfs-`uname -r`.img
>
> Thank you for your suggestion, in the next version, I am going to add
> initramfs optionally, I am thinking to update script to something like

Optionally, because in some environments (like in mine), it is built
into bzImage.

> this:
>
> #!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
> set -e
>
> # Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initramfs
>
> KERNEL=3D"${KERNEL:-/boot/bzImage}"
> set -- -l -s --reuse-cmdline "$KERNEL"
>
> INITRAMFS=3D"${INITRAMFS:-/boot/initramfs}"
> if [ -f "$INITRAMFS" ]; then
>     set -- "$@" --initrd=3D"$INITRAMFS"
> fi
>
> kexec "$@"
> kexec -e

