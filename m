Return-Path: <linux-kselftest+bounces-44198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6FC1619F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E53E4EA28B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E334AAF3;
	Tue, 28 Oct 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGuRx9Na"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FF32E6A7
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671930; cv=none; b=rSKYu9d0j09vQ95RpRPI28VPITtWjzg7zgkbHFJvT0UZ9SUqg4y5mnt08lC5HQfuIwkUfG3QLy3GqqHWc56jTr+b/ds5/LN1gfs0T1J4ar/qHb7w26Rff3VQwlARkLD5ufTFXySvXhxJzwvwxsCMDeDqYo6s/67ECgxvbKmilCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671930; c=relaxed/simple;
	bh=UYwxvkY2zdm/DyH3ka2ma9lDVPuQqvHwI04Qpd7l7vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCkgEDT54zQBUvpyDLQgtU+RkCXHNI9So0+2M15fVHRiuiFHzmv2RqpSUjKHc4owHVerCf4JmRP4JcZ+aubTX6wVmGvtLUuvhqnZQvVqqC/XCThQYm25E0/o+gK1ygiPp2kpXkk/MPZ7CbRwFIzj39Nja1pP/LRWTrDTgJMlrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGuRx9Na; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so4565587a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671929; x=1762276729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4n1AXwmY/rwCKDx/cQZwkmGhjBWLLIwBisORqaR6Wo=;
        b=bGuRx9NaTGJ62kAPYH+q5pqRoO0ej+L5PiwZYUnuW43y6S9i5KN7+nHFW6oZc2wOu4
         FZlibd73IiEPZfuvWpSTm/JaNqBHfFLzzIdATnRmA06gSLlNRFGzaqyOInGITFI5B6yB
         CE4f8ONvwmarcuUW7HGLq5pVFaTwAHkMOWN82IvZfegT0XYAuJI0wFXa5DGDQoKfQrtS
         bSCAvXWtgE55awhMVG+hrlQ14Grt8+X8510FipZNE9RuZhKXlJ0BU3R3RZHGNCa4N7Ka
         7CGvYSRl8/q/76q1JbyGooGlGkAdP0vuKPwG+yIsoMS5eNE6ib2ckN0PQ3nLBIgDUmc+
         TBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671929; x=1762276729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4n1AXwmY/rwCKDx/cQZwkmGhjBWLLIwBisORqaR6Wo=;
        b=xKeQ22sWvBRDSp2EpQrAKRv1GyBg8hW31d5n633PN7MGC+5YLLUyZffpPfUfXffpfN
         C+ZIpsQWm9jXf9P2En1okt5UG3WinQ+plFlMeS7Iy/y854h1Dv7lBRbmiTyRFmn272Pl
         CULuBmyQYFBrF1THK1yFtl/5ldrgebMq8v+KicWJKrLj2wof5hxZ7u9zMIEL7hJL1pXG
         IeAevF/iiA5fMYIXDgRZe0oeK0TrfwBUocDhDnROtXunQ3kWOhbIdt/8SOW0HxzVh4xD
         w3LcNDp51IF3u52IaByEjsHqqCNVq5We2jfFY3C2+1E4h+RmIN48zxYrzpx7wynUkZXe
         ya7w==
X-Forwarded-Encrypted: i=1; AJvYcCXk9iupXDHh+CxLCrV45JYb8U1oSM80YOSnLOWst/hANBsJyZ5UIO0Pqwp4LdmL8w0bQJPD6x8Mb+SRoDmdWEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBp+WOPgAimMwUesUjZepQslaCj7JCve6uBY0B1tFjjKdPppZn
	zbTyC5ZrORER2UAnzKLraTP+1UFkg/vDKAbXWczwCGCI+1El++utISAN
X-Gm-Gg: ASbGncty1vP3A+xruZhG2/JhkTrNYbAMKWefZTXm8CATjYNlyzl2v+WMorw94JKg8Yo
	N3dFM7HMu/vYAZspzm3KN2MN4IkMySHWLoCzKxl9LEDMfMRMU4dl5BOK5otnzpuwKtf/TJ5KTxT
	pGTXnAOeiK7GlDgYTYC7A1hX3q0hNG4S26fR7hq7W2bTZBY2ISe6S1RA+OPUYVZBYeY9kyTaACY
	/Ejg5BCNVh8mJ0fZJAOCnMoXpRDQO1vl5jbNmD5c5vmrNeNR2Ob1ibGxFAUOu0HcFr/97t+BDGU
	oAB+59aNnc9Ll5ni4nsYPp9b0U61QQN5dfcio2+g9wRyPMRCQ8qqCgaSBBP+z0rzBu1eK2pls1j
	QcNGVh/bIlmcAbwQ1judfHErY9vBF3SjVedJY4HvjlFGMy6idGh5k12rQS1xLa8PPYrrm40rnY3
	iVEXIBYU0iy1OFIrxh8QfMXlTsB4ILtUVK7URO
X-Google-Smtp-Source: AGHT+IGzWUp6pB0RrxfOplxKt3YLhG+4AtzqD0EnJQYft/iHYC0j5K1snUzrTanQqB8W/931TN3xVA==
X-Received: by 2002:a17:903:1c2:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-294cac96c6fmr55866035ad.0.1761671928527;
        Tue, 28 Oct 2025 10:18:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3f28:abaa:8fee:bfa5? ([2620:10d:c090:500::7:f7b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0827fsm121791055ad.31.2025.10.28.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:18:48 -0700 (PDT)
Message-ID: <bf1de6a8291d2607b8c77674af899551607bdb79.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix tnum_overlap to check for zero
 mask intersection
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, kafai.wan@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	shung-hsi.yu@suse.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 10:18:45 -0700
In-Reply-To: <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
References: <20251028151938.3872003-2-kafai.wan@linux.dev>
	 <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 15:45 +0000, bot+bpf-ci@kernel.org wrote:
> ```
> commit 16cbc4520eb13d2065d145c76b97fb93035d81e8
> Author: KaFai Wan <kafai.wan@linux.dev>
>=20
> bpf: Fix tnum_overlap to check for zero mask intersection
>=20
> This patch adds an early return check in tnum_overlap() to detect
> non-overlapping tnums when their masks have no overlapping bits. The
> fix addresses a syzbot report where the verifier failed to recognize
> that two tnums couldn't represent the same value.
>=20
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
>=20
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index f8e70e9c3..1a75b7c9a 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
> >  {
> >  	u64 mu;
> >=20
> > +	if (a.mask && b.mask && !(a.mask & b.mask))
> > +		return false;
>                               ^^^^^
>=20
> Does this logic correctly detect non-overlapping tnums? Consider this
> counter-example:
>=20
>   a =3D (value=3D0x5, mask=3D0xA)  // binary: value=3D0101, mask=3D1010
>   b =3D (value=3D0xA, mask=3D0x5)  // binary: value=3D1010, mask=3D0101
>=20
> The masks are disjoint: (0xA & 0x5) =3D=3D 0, so the new check returns
> false (no overlap).
>=20
> However, these tnums actually represent overlapping sets:
>   a represents: {5, 7, 13, 15}  // 0b0101, 0b0111, 0b1101, 0b1111
>   b represents: {10, 11, 14, 15} // 0b1010, 0b1011, 0b1110, 0b1111
>=20
> Both sets contain 15, so they do overlap. Can this cause incorrect
> verifier behavior when is_branch_taken() calls tnum_overlap() to
> determine if JEQ/JNE branches are reachable?

This is a legit bug, please address.

> >  	mu =3D ~a.mask & ~b.mask;
> >  	return (a.value & mu) =3D=3D (b.value & mu);
> >  }
>=20
>=20
> ```
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> In-Reply-To-Subject: `bpf: Fix tnum_overlap to check for zero mask inters=
ection`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/188801=
08453

