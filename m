Return-Path: <linux-kselftest+bounces-14098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4528B93A80D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CA91C22552
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724914264A;
	Tue, 23 Jul 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0WKdgPH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8113C9CB;
	Tue, 23 Jul 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766519; cv=none; b=hRwXiT4Kf9Ru2WHipS3hTemIpH97LExN2z937//X6AYQTApk+dLinC/4i0NrYPwznVrypYRzBKnoiz29Zex4Lw8mNF4OiqCFA7AkxJADWzSzIBzgScYzuGKDxFNmfLMSbEoRb9UsI3c2po1r3jh+8Kq/NvAbRN5aV+saS4DfzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766519; c=relaxed/simple;
	bh=o3WEIpUZ2Ir6/UxTB4aSIomYxmK5gpHnooT4W3F63P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6xSEQqKcD31/eiz3S0W8VennV4PKWU4ZjsNnWIYsyRAa7X9DVLUQX15V4yxZRScuKIrBcCIfaax9SQkmqIW7vIFHvMYA6BkYLOGkyreImYKwuuzehvP7pPOG/RIKxX1PArSFq+zDLDANWm7XCjoT3McNcMXaHo93P3PavyxkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0WKdgPH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso1697360b3a.0;
        Tue, 23 Jul 2024 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721766518; x=1722371318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3WEIpUZ2Ir6/UxTB4aSIomYxmK5gpHnooT4W3F63P4=;
        b=A0WKdgPH20RByqbw6bWiO6/6kIhIQVYTG70bgIKCuDn6zpvqhjwZJU84oiOfQsLY/+
         ca500hFnmHkmKS+kR3fnTF0Q0Q3iDVjfSoqpYF5c3hgvCy1nyDkxV3Not2ZGQ5LzOWnr
         8tbUrTzEyY3/B32/oLeYsplDxIosgHvDocZGYP0zgECt8/grjdu3nSwrcpXiIn8DHMP9
         85ozFaFJ/GeTCmM+Z6no+3BSCcRjnBQ27w3xG6RK5T6AJJhm85hVILRgKJWiiuJaj2y1
         nkPfikNHzSOJA8ebgmLAema1YZdZUfLNlnftCVVwGLyzB76tQJL2kZm1tJLf0/xJd9dC
         //Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721766518; x=1722371318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3WEIpUZ2Ir6/UxTB4aSIomYxmK5gpHnooT4W3F63P4=;
        b=CbOCVTo3tcKdtDttaS55nYsGy4im97C6KknLTz4lpOUIkl3EEVcqZ7m1Ht/+QZ0KDW
         eoFdPZNeAtOLdtbPB0OaJrnqvO3G1hMzdGmvjLeu/g7f1XBoCasTm7BtFtauqKwdd6vt
         jI8nKuGEAEUaxr16H3ZgSfO11vx+ygZVOd+//hltnalQYX2eQRn2d3ZHRMJLxnNyJ545
         yz12yF1MHzFL/pUx8QevsBEDzMr0ITuKeygv9aSU1TwNNsIqaNl0lGh95Zh8kmgrrYLS
         P4Eb0ZivFWsxYHXsLlWrqZOf1RyeCK4pflC73e5pYCetcIeO4z3Rhvjd3a0+65YJ24WM
         /Axg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Hzn8Cybw94D1QVIEk/no/PgfZ4pEtK5ClSZE65BmSX9C6MP6jQ5r2dr49pICB1pCGvuxWSUOI3kyU4ylgp6b2ryf2rAWEFONLK3PcFAdvQbN3+c3bSrSVO9GP6otWajdZl3i
X-Gm-Message-State: AOJu0YzUN4q0QAVkkoqmCoWLQMOUqOT1T+zBz61JYDZDSunpHIN3KIqa
	k27X1+oHXey4R6dNzD0S9QFMRLyJi8bhgijoiwrhS8Zre3vUo7TWIJm7Cr9/O9R8ezzruAk1XGp
	e0/KQFdFRQt1tw+XpgojCPsCBAw5AtQ==
X-Google-Smtp-Source: AGHT+IHo4CP6gnK5Jmdf1ya66+0HaFOLgkaaXdIFIcFPe6AOIp/m28IxYjDmUzplJhxdNCWpeFGIaiGCfdNt1XQ8P3M=
X-Received: by 2002:a05:6a20:a128:b0:1c0:e925:f3ea with SMTP id
 adf61e73a8af0-1c45e5d4b0cmr1136696637.16.1721766517763; Tue, 23 Jul 2024
 13:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
 <20240719232159.2147210-1-tony.ambardar@gmail.com> <CAEf4BzZ-caZKO_kEqhh930_x3UGVXQ3NJJaG5BZq9NJhaP2xng@mail.gmail.com>
 <ZptJ1dsnKbjTZ6iH@kodidev-ubuntu> <Zp8I3aN/bZnka4I+@kodidev-ubuntu> <00c938b06c8b3df26a10f93b4bdb113048525c9b.camel@gmail.com>
In-Reply-To: <00c938b06c8b3df26a10f93b4bdb113048525c9b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jul 2024 13:28:25 -0700
Message-ID: <CAEf4BzYSfY57+DnUdWzqGeMG5iEVg9eWnta=kunQ6MkgFxfM6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile
 log output
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-07-22 at 18:35 -0700, Tony Ambardar wrote:
> [...]
>
> > Hi Andrii,
> >
> > I sent out a v2 based on your suggestions but omitted Eduard's Acked-by=
:
> > by mistake. Should I resubmit or is that something you can update?
>
> That's fine, don't bother.
>

Added it while applying.

> [...]
>

