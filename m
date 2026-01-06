Return-Path: <linux-kselftest+bounces-48322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392DCFB277
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 22:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3954E3099549
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E534A3AC;
	Tue,  6 Jan 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L0JCrEf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F349B13
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719926; cv=pass; b=LIjtXD4/Ltwj7nK8QG9sOAdSLBR/w2k2O33Zuis70KaB77WZatKHlgv+bzuG7DGAxOpOAbiVTfjJblIauni9UYSjlz4s4Sn6TwSNPYCqiMCTNDGVDssLzSiywxfRc+viC5W7sCo0id1q3mYsSJAK9lgtJMZS6iTbM2JtP2tAHDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719926; c=relaxed/simple;
	bh=4kIuX6Agq3HD0TLnVcZN913LVX+FCf68NrUDWYKrLZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkYjg9PeOH6uj9h9eDmebmy/eDPaSBJsiYzcZavOHQ6+/LgRHp3eMZ5d/1EnnNMi2hAelMT2SasFDYRukCOtrud6xh6RfQyZU/ohPtH6tPRgNZSYs+qRZa55QYnMgkfQMwrdeUg5ixuZsxoTkbIMwxOTlF2olNmRJM2UFoov+R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L0JCrEf0; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11f450147cfso37087c88.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 09:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767719924; cv=none;
        d=google.com; s=arc-20240605;
        b=LMeWbhz0Q7IkDrncF0+X3x6jwav9LCUpedVLpIPK9MtaMFNMG8ksQj0r0Nz82iv2mj
         oqlbzQCWaXmCX2gZyit87S02REPiVb+PL5RIJQLPX3bX8jZcjS+37lGA3RQXAc1+1SwG
         Ha2NhmHbkPot+fTXZouldEibTXAFU3A2xo5Z+j1HfD6Mv25R1BBcmthH22JSOhfjnMnX
         UfJ61WnY8Ec5f6wrkJAQ5dUgpDbjrQkPt8ZBerDETzFOv891kuloTXmSGy3D1NvaxcGE
         C5VbtY+86WtDxfDhySVJ0r4zpDCHC1/0BNSoC0bwY1A1tX5AvexrKeg0vCETGzWcFNnq
         p/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=el9IdsVpvDRJVEdnxklkmPvqwg7S8+dzbfu1CSsjkVc=;
        fh=YuGSa7MrV3uosFes7qc4SlKlxPJFvzCqRaqNujd8y4k=;
        b=UvTmTrLM+R3Ud7brYtsbcVjd4u0G0jxDYTjVFpADfMUMbvog81WstRZn9JZhOr/15R
         RJpu9QEhdfP9I9IfTYwnTYgz3Mz7nUgVJqZqZi10QZw3ng5OtZZAtDFgOKl2RDD0iPl/
         u2nkF6NpmO85VJSMSYWGJeSlUzKyY3VrnLEMHsjoHO1hl8vZPWbM76UD4p9NJimtckdD
         A/J5HHmVOf5pnLyg66MAXWCN0+ipVBLJ2sQlK3iAtKtZxxQFrFcD9fgqx6SR3dWLzJae
         pc3yhGGM4dA3+HItgykRFhUMZOayY4UJ64v7KcDztRjYTjiFBvCdXxMaNyDXAF3r/SdK
         XDjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767719924; x=1768324724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el9IdsVpvDRJVEdnxklkmPvqwg7S8+dzbfu1CSsjkVc=;
        b=L0JCrEf0CxGjZlVPdGLiAhubcYDAobdQSZrOsNjJpiygYspAp/4Ht6kGoF1CvSSp3W
         DSGBWeiFw1jvHjjgq0N329CbU1pzbW24n/uKPKsE4XRtpNBdy1kbfspf64RPQOJgyWdl
         lwl4zzH//6aRLc5CRsD04toFAIpd3u5WRWVQB1Mt4680h6y1TSiwHgz6lh22zgaBrv1c
         lT7Fp4PynyaldSrmnUTkVTkk5h8hKH0EJEPDkFnQxozoA82RuKaKm6MTgRPKCy062Sld
         dv31/jY9T3dPFrH13drZVvny1K+4jq3cNRQP8VuRnU9j0+n1tuOH6w4QYUws/9ha/7kE
         aDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719924; x=1768324724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=el9IdsVpvDRJVEdnxklkmPvqwg7S8+dzbfu1CSsjkVc=;
        b=OFpVOC3FGKWnpNb2ky9fRpTPLT9nX0QXfaLLso0sVtn/T2Cgi+JA9Bg81/O4prf1t7
         Mx3GJydnE6UehCVDj2F8wtBCGnjNGBlcz4Va0FS4pAHmR13hNSxHUq39aR24z1iEZHX/
         gcoAozhgwHPBaetQWjg5pQhXk2+FEN79yoUKN9tvFBT7eQ8wth5Zp+1unzcY7aWW5Y/S
         qzkL+oGiwiUQjvHl5AYRp5wt3OsqsbgjXNXCCDZwncWPtqinu9bxoIo2udiJI8yAJaAs
         Ht+pW4F1eKB6IdJL96JCdq/vF+YcRQdqDzkipE7YdigT0UFnsEbTuvytY6VQ8CCdy7YO
         PhFA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWo3o9gLA06dFMek4cnb10VNVS/zMLyM/lydJ/UPdDEhl+3Mjci7sS/S753zptRbHgkplqFporJ0NGmv2wuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/XQC7IkOBdeXiUM5j6vj//EYe4jjg4TBdz+yVv3pHRauCDj7
	cFvD4xg7mEJ0d2ds6b60s9v1+vsCKsYQZbmXMfXvM9ZAvMOISCjIWPlRKV9Z3ez5DcVAYowBR5C
	BZy7rtOFwSNlSI7syHqUytelM6GrpK+SDcVliQ8Xsxg==
X-Gm-Gg: AY/fxX5Urwh2fB97Wt/Yrfy+2uJsv+9ZzcNI0LFgEkC+MS5zEkr/8nQq1BuCTjVbJJm
	sZj78dGdbVSq90FlqtZh+aM6ZHA2kMpk1B+IoUT/fMkCCVJOe+rZScbNlk7eAxqSlkknl0rUaZb
	H8A2XnrZdoZtL4SfGdZc4Lci+rVUQr/HnwCGLp2M5E/UyMFip1Vfe0Oi6f8qSzsNZTu8HrMnhRb
	FgELs/9HUqURAFU2UcJ9+vTc97kN5IYAMc0YKwLDAhm6sz1+W5IxNnlQUx/DQWIqtP40Bsa
X-Google-Smtp-Source: AGHT+IHJa/wLLHrmuywVzlRGyH5Yo3APVWKq7aE4CE/jD/1YOw2SXtvug2pAPBCT3XgeLuTQ6DbQhrJVVoiNv+zqfew=
X-Received: by 2002:a05:7022:e0b:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121f188dca6mr1576758c88.2.1767719923753; Tue, 06 Jan 2026
 09:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-14-csander@purestorage.com> <aV0THiUJ0S1l8FNC@fedora>
In-Reply-To: <aV0THiUJ0S1l8FNC@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 09:18:32 -0800
X-Gm-Features: AQt7F2p-9Q1Gb8POklMIHL1sT1S_3cYjSMMZ_GUmQXTheHiXANNW7Tkv76aEaqo
Message-ID: <CADUfDZpw7rfshnC649QG+N+vVvck4VNXDLwCQW=6TYFCiB7a_Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/19] selftests: ublk: add utility to get block device
 metadata size
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 05:57:45PM -0700, Caleb Sander Mateos wrote:
> > Some block device integrity parameters are available in sysfs, but
> > others are only accessible using the FS_IOC_GETLBMD_CAP ioctl. Add a
> > metadata_size utility program to print out the logical block metadata
> > size, PI offset, and PI size within the metadata. Example output:
> > $ metadata_size /dev/ublkb0
> > metadata_size: 64
> > pi_offset: 56
> > pi_tuple_size: 8
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile        |  4 +--
> >  tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/ublk/metadata_size.c
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/self=
tests/ublk/Makefile
> > index 06ba6fde098d..41f776bb86a6 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -47,14 +47,14 @@ TEST_PROGS +=3D test_stress_03.sh
> >  TEST_PROGS +=3D test_stress_04.sh
> >  TEST_PROGS +=3D test_stress_05.sh
> >  TEST_PROGS +=3D test_stress_06.sh
> >  TEST_PROGS +=3D test_stress_07.sh
> >
> > -TEST_GEN_PROGS_EXTENDED =3D kublk
> > +TEST_GEN_PROGS_EXTENDED =3D kublk metadata_size
> >
> >  LOCAL_HDRS +=3D $(wildcard *.h)
> >  include ../lib.mk
> >
> > -$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
> > +$(OUTPUT)/kublk: common.c fault_inject.c file_backed.c kublk.c null.c =
stripe.c
>
> I feel wildcard is pretty handy, can we avoid to kill it? Such as:
>
> STANDALONE_UTILS :=3D metadata_size.c
> KUBLK_SRCS :=3D $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))

Sure, I wasn't aware of filter-out. I'm fine with that.

Thanks,
Caleb

