Return-Path: <linux-kselftest+bounces-18048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DBC97A7C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 21:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D2BB2531C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654515B552;
	Mon, 16 Sep 2024 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7yZVnJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C731459FD;
	Mon, 16 Sep 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514623; cv=none; b=Sb/XvLCAfQBUpbPYDHsdTKhDDtetPmg6V3MH9hcZLXaYm9mbZi7oPSeUj2+phQx4r+vWjRdgYtvOckx3Pv3v8/M5EUsDW2Emu390e9aBpEOnoO0Ag6BW4cVb6Rt0XreqfJ0iB+Au+dXKC24O8KdeYZioYH1DnJODBbQ4bfaaAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514623; c=relaxed/simple;
	bh=eNDNlenQ55wq3OU9jE97F/r798BG32rPjmyy5X4VSQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3DMTwLYr7QBvvIeV6+F/KqTk4iVRNGiOkMdOZwA/SWcJEENP6gFIAYchlS0krU3qJIwzPVlY5cKBn/1huuK4Rm2QDcX+D9SV/VrtX9y78le7cHKI5FP8yrU845B/ddTdBgAcFUWVGtk1UebN5XCcDZ96Ir4ZFfKsVh/PoSc1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7yZVnJu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71829963767so573225b3a.1;
        Mon, 16 Sep 2024 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726514621; x=1727119421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foWXsdfvXW3kM0+CVvXUZRQOzmZiK+RDiPeNZHlJE8A=;
        b=P7yZVnJuGFizK/d+c83CSngwa2jMh/IlG5IqLcREBV1DV5GuAZz31a2uyqzANHN+R2
         YjnNWU526H+pkkF/+DLF8NtMCtRfuzQPA0qjOAZn0ovQ8EH/QoiufT+7/Z9OncfsxQvT
         5kaSEXG00MJtumH3uVNTeceC/qRs7bO3w0j1EIyVyxrbGaB95YzOwcEAkzK0L3nceWQ9
         oX4W6PVniEG2cVYfD90x81wT+4gpU/mtcsmoZ4k0tfn2cY8LEv/bfbBfoWQLVodhUk1H
         jDvrMC+nGvw5eeyzKOKNdcsIDrw6NPT1GdxIucWACJf87GKW/ytLao4pV6/lprkGoTej
         X1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514621; x=1727119421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foWXsdfvXW3kM0+CVvXUZRQOzmZiK+RDiPeNZHlJE8A=;
        b=ZcYLLU8iu3XxhGJnoa38WPicsQYAftlpHNJGrUTAITKL2QTRnXQkI+cVadhMC23ogM
         q0BJbyreAcuLYzJCFiUHgMgnzOxlnpnPXTGWRz9IhyicbyjMS11H9E3ECSGVndth83Tg
         X94vZFRWhTBgXCwYYltV+4WB6HMmIr8Jbl0oBlpVYSzy+JeYUS3/ffHvptIkqwssM6ro
         fdgX8lu5MjW/eqwdOevROaAW1dAFJd8FwECdHHnr25q3QfyN5UnZTkIwMQItrYDisXbP
         3TxnupWbMbJqmYG/2LTAMA73RQBKPLXQNu1RePP4SF5LrALyrS8X6JvqWNQH5lVxeDc7
         JWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXql+HtU7DOIn7cXB+sM2aCoKfPft1KwT4iB39CIuZAWWM3VKrmeIpNGi9TqnFx0KOqKu9pCy0CS4ngbio=@vger.kernel.org, AJvYcCXsotSz2bXJA7mfanEgesUD9W15dkCroXqORPVI9e9Gnu1KHIdD3fCkkFo22l5K1ceDcnykPQ2Sdx7xQeBxrjat@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPV4C9WzfM2RqttBfDgtLheQcRZHGFAcGS6XqIJ+lvBZ5cJQ9
	Js1D0NUw6EfvhSUQPpTEtU4HvcWUUQhCcoxtJUXJUD1TvSh4v7M1XikW2lQ9FdBVzN31Bgf32Q8
	UuhS2LgwIRWzoYAUo6XGpBM8Q4Zc=
X-Google-Smtp-Source: AGHT+IE7DRhJ+wg7wlbPODJvQQTOCMwvp+3FoQzGpOHy6LDZVVh093NafbDs/OOEt5XjGoPIpmBLlqaM0zneI2fo6eg=
X-Received: by 2002:a05:6a00:2d88:b0:717:87c5:84b with SMTP id
 d2e1a72fcca58-71926088d53mr9934593b3a.1.1726514620830; Mon, 16 Sep 2024
 12:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuaDUCxseqCW8BO0KhLKn6F0VHYaAhu-T9v-MJHzJebcQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuaDUCxseqCW8BO0KhLKn6F0VHYaAhu-T9v-MJHzJebcQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Sep 2024 21:23:28 +0200
Message-ID: <CANiq72kaAd5v+c+A3GHWp9riDtGTrKcCb3kraw2EaZLyp8asSg@mail.gmail.com>
Subject: Re: rustgcc-kselftest: error: unknown unstable option: `patchable-function-entry`
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Miguel Ojeda <ojeda@kernel.org>, aliceryhl@google.com, 
	Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Mon, Sep 16, 2024 at 9:17=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The x86 rust gcc builds failed on the Linux next-20240917 due to followin=
g build
> warnings / errors with rustgcc for selftests rust builds.
>
> First seen on next-20240917
>   Good: next-20240913
>   BAD:  next-20240917
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks for the report -- this should be already fixed in `rust-next`
for tomorrow (requirement changed from `!FINEIBT` to `!CALL_PADDING`),
please see https://lore.kernel.org/rust-for-linux/CANiq72=3DB9NmC=3D1eSaOrg=
7XutjueQsSXGcBQb7dQFPuL0SFjPsA@mail.gmail.com/

If you can confirm it is, that would be great, thanks! i.e. you will
need either to disable `CALL_PADDING` or use a newer Rust compiler
version.

By the way, I think you meant next-202409176, not next-20240917?

Cheers,
Miguel

