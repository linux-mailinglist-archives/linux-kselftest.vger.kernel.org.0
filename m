Return-Path: <linux-kselftest+bounces-45277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFAC49D46
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 01:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65AE4E3511
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F134D3BF;
	Tue, 11 Nov 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLz2AIKL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C934D39F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819800; cv=none; b=A6AIIhcVHwrZ+MNMfxusWkuRsDQXK+kKAT1OspXbHU9UJUNLYOkgNKHhDKqnH3jwBKs8C5M29RQyb1WhqML3ImpYqj1KMWu4+FT68iPuoa1r+k2jfA5/93cEVzZYOPumz/0xyIt1TlBYPYl+GV/lPnhOHFgPPRZehVP9zx/2yKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819800; c=relaxed/simple;
	bh=gZ5/m077XwBZLhAmwLVAiJZP3Ep+Vx20A7NkuQEHPPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs/Ctq1wyLz8c7LeS4wUiJ8gvTcHuax8GtC9vD3i7qUz7k7kN82EdkdCdWBtmgiv37uRTCKwt6AhYq+lcWLIBVVLRp9HVGj2jYYLDVZxkZIhKuzgqd2gZEy6MsSUMZjvRIcgsR5tywKVLnnJgbdnUlqZe5224kAT4ULRglq8jNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLz2AIKL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594285c6509so4005575e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762819797; x=1763424597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFEHCNfHv1D8JoCl4Nsmjn6JwQRfPNbQJk+sIWcQCWU=;
        b=gLz2AIKL6xMj9C1Sa7+YRItNJbgrocb9By4S/yhj3r8aSr39URnhLjz/08r0cdz41D
         LQ62useSgBJ2OYLXR42XyTKLVcjKWQf1XMfMQGwUDAQl/PsFEF34+Se3aFt10vWE+bBl
         tjoNxZp9EwzAVeTEmnr8sa950CnhThpknF5i0BB8oTyNOg95POPpqG4jRnCw9qGkjnLj
         MlUMRqHJQGxqUpPJ97iL3E7MQChRtbe1cIRyncJog+MKxle0oBDiWVfT6Nfq0AHjOsmZ
         VsQz0J38lV1uYVQawzJtyd6V0SMKovkJcM+IDt/BJJrlrtN81ogFiKBNiucB/lcvtQW0
         FSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819797; x=1763424597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFEHCNfHv1D8JoCl4Nsmjn6JwQRfPNbQJk+sIWcQCWU=;
        b=BwzPVqgrGYMkWefggtAFcGN7Z/rawWeEj14UumyleiZax+koCk6eUD6zXm3BrNZpJw
         q8up71EhSfQKuotSBgpw+xI7X/Q6xBHwWU4NsEZuVUMlr+h/jyW/Fi16HklYWosri5x3
         CFcTEdmTxSrCHS3WEO8azA+qaLB7e14tUcC//CkYfsFtGGhVuFkQH3Fz8r4a3dLAkTaD
         BVYktYbl+NY0juy5W/dzUtVzYxUqbLjoLKPiR/xRGqInGQ2/orSqVGLA6zjxK/3GWl2T
         qiwIKe29f0GtwmuYTzSG3jvCrGOz/Rh+rjte6txhSHZeVNQhmP88D1SKHswyr9sY6kqH
         S7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNAog/wCcNVyD3dsCkwNj1UhfxDKSlcRHx6H1MBnJajsozBOJzmIlST9Q9JfpBMEbdvrcS2F0UUF51mGNEgW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXms0WJ8C5QelBvZK4HZ8gUQDlXPXB9ojwyfZ264R5eqjtl9oe
	CnQn5I6qw6UMIf/cRemzdHuins3gfEqgc6y69tePodj/Sde1o8qoch4nZfq1Jw24dK16DVUv+D7
	WExNEGsT1NHuIf/Qy5eBbeI1Xkf7CTr97BkcsRADq9sQmBBl8pHq4WWokGp8=
X-Gm-Gg: ASbGncvJ8svMRxqL+SHp6tEZMIoWkZeCyNugKlE0AtZHGUQew6j1PsscuESGOzCUYzh
	Sw26+Q2sWBwuV8Zk95u0EHY1nsSTKFWaun1tRGbytJ5tsgooV3DV+VwqSZAOY7PJnUb1bwH+EKw
	V5VWQI+s+V/PDNLb8jNWwivKDhcFJgcZ0lxDnGHQIGVxiNu53zgM7QWaG3Pk+7rf+/diILhONTX
	EflzQCt+c56ntltdbFoOJQZsxStx7UWYKjZiZoumGy6lnie3r/gm/xkzd6UO4Nl/UV5Z8E=
X-Google-Smtp-Source: AGHT+IHo2L5BMywZB4ygtkbG7ou934mmvSM1iJnq4YXV+tyl1PbwOxo9qYD3jNo2QlU6HODLtb4dq1vYUatSp3CdWDk=
X-Received: by 2002:a05:6512:3d87:b0:594:3020:f88a with SMTP id
 2adb3069b0e04-5945f146154mr2982019e87.3.1762819796505; Mon, 10 Nov 2025
 16:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com> <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 10 Nov 2025 16:09:28 -0800
X-Gm-Features: AWmQ_bl8_Cdy60TogV-QJ49WsEn_RX2LsLOaqoNdfUT7B2UZ4an-cWntLVlYT40
Message-ID: <CALzav=f5PSLJifD6_0iqLW+Uh+zQ9f_N4zVtq4ikon1gg_h3TA@mail.gmail.com>
Subject: Re: [PATCH 2/4] vfio: selftests: fix map limit tests to use last
 available iova
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
> +       if (region->iova !=3D (~(iova_t)0 & ~(region->size - 1)))
> +               SKIP(return, "IOMMU address space insufficient for overfl=
ow test");
> +

If, instead, this was:

  region->iova =3D ~(iova_t)0 & ~(region->size - 1);

then I think this test could be run on all platforms. The kernel
checks for overflow before it checks for valid iova ranges.

