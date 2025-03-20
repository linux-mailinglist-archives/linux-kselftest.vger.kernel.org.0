Return-Path: <linux-kselftest+bounces-29535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304BA6B17C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 00:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF817B93B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C822257C;
	Thu, 20 Mar 2025 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWWvvFlC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351351EDA18;
	Thu, 20 Mar 2025 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512450; cv=none; b=M9RM5agq7PuikEK7VJtjeort5kdfbMJ9QiDPvo4gaNRGdQV3dhfr/Nlom+Mf9zelJMUMcfHL6b6VFVXndlCAvSZkSN4wYireN0wrCsD49W67yrGCMS5gVZa2tElVnZj/rv8HyuYpE8RcChRtgNHnhWcpBu3AyBC+zeIOtWUwFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512450; c=relaxed/simple;
	bh=oh7eMKFUPbLqNqZ9+et6MQgLtwMmKR5ZYoZjPnyeVzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSstTiCATRliWcpE46TsVcj/5dkSqmuZcbFdPrLSu79/igNOzNCo60XLbk1fC+GY8BOZo/zgU2weqbj5KNP0QJecttJdDr6CUaObMh6gjLGl1VaymmNcUGyop9733NzyZHvnNJOhKmBe678EHppg/BsVSBe+VtzV6OkSK3r7YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWWvvFlC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240b4de10eso3894055ad.1;
        Thu, 20 Mar 2025 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512448; x=1743117248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh7eMKFUPbLqNqZ9+et6MQgLtwMmKR5ZYoZjPnyeVzU=;
        b=mWWvvFlCecoBHnRd8ScngpHPksCv83nXpPvFxUDzIIjYYs1kYamnwHxuxNtJI8NRYc
         G/fKuQDMBiBkm/zGjjNXiE/l/zvo+meCVD09XGjnUyzv+MAT34CxiObXzMhI2ORRCBvJ
         BI0VyvWGH7UuNLfO2XL38qolgUlnLdV/JC3r3R+8K2/AuX0u3TEnGm7NbOJnnOoAGpP1
         902bQ0/cL6HybupOClswiwuZvqT5p9Anm6i9mFwv7mYZ/vrUswglR/t9MRDy8k/goPxQ
         0L6Nf+8qf76vS80y365peChrRdMOKWW/S0FZFxFGA/HNmfn5+tO1Plc5PEn4ly8OdTKE
         MnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512448; x=1743117248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh7eMKFUPbLqNqZ9+et6MQgLtwMmKR5ZYoZjPnyeVzU=;
        b=nk0eSWgRjcQP77x9koWa40fRtTgOO3k/5n/Nge/lHxEYiXDBaQQmelm7zT2PBN0hfX
         XBKDBG2o1rM2sovuJD4XBRJFyLowcV/JabWHoO+C8fqzqVr96qspL0bKhD2SI0TtzA2X
         CsYPWnVnR036guENtvLBP5yRBHilS4Wbcx1jB/5PST4OQLXkJzdrHaCtKr40GHRTovYx
         CXDUjiba2G1ynAaH4L/DpXcEnLuoj1SjDqlSpQUyQbLJmvJC5oxYAqM3BKt4RG8qJPzh
         jRzvKloAoQmi9iw94L5lHs0pD2Wf8cAvdBFHgjd9QL5X9QeaQBI8Iz5SeAQdKi/Rgnbd
         dL7A==
X-Forwarded-Encrypted: i=1; AJvYcCVCmypj1T3MXLrjpWw6fRcKsfc47Y5DyiBwKyKqhQJi5RjQOXDf83SEGcnJWLSJXZcDeZ5o1As8/M+Eibre+5k=@vger.kernel.org, AJvYcCVKT5Vp63KpX500P8th2zYWhPIo2zRMm0lhlNSNJpxKDuzCXENQTu3K53UcafNUY8EWYUhG3zSKMDf70nA=@vger.kernel.org, AJvYcCXqYpgHGnQcb1JPPFkt0CuzVHgHUKv3bx1wfNlUxqfq295eQRpo+qEf56wm5FPsCFSoKdovPIQF+hJCZIFBVvF8@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIMvYw2zq83WEi77X4dh3ZEWDgTTWFhqzXTVK58f/eJfX9S8Z
	RN83tmTNMPICg+fEdkKB4e8dBG1n+DSW/yk/Me4qR0OmkEr7lVeQA46oOV2vvRh9zE24QMwhc07
	S9iNmPVoD4g6TbK8PPOw+oSTbJFE=
X-Gm-Gg: ASbGnctWvi5ipaesTQ9nvJhf4YPcRVars1lYkAWEAX6LPSvC3D10B1AGcR5HAgtwXWM
	RZMOc4WznGN9uRgDs4i7uPVIL0gM1AJIHTnwFgEuGp+zSPSf9QZPZhYtIakS4suzFs2+gEhlwC9
	Tju+QurF1+hAfFMVBorEUcb/sZKkimG+w3gkxx
X-Google-Smtp-Source: AGHT+IFyh2pZZk0axc3v59LIOPEvMKGdpbMB28ixr/zdn/Smks0UoWpBkCvgwp5apR+PtGOosIcNrkELyCtQPIPeYFg=
X-Received: by 2002:a17:902:f68b:b0:215:a96d:ec36 with SMTP id
 d9443c01a7336-22780c7fd3bmr5511395ad.5.1742512448449; Thu, 20 Mar 2025
 16:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307090103.918788-1-davidgow@google.com> <CABVgOSmtBU=zvxC2--4=F0Vh=sh0GX5XNGB0coJuj-4fP=puDw@mail.gmail.com>
In-Reply-To: <CABVgOSmtBU=zvxC2--4=F0Vh=sh0GX5XNGB0coJuj-4fP=puDw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 00:13:55 +0100
X-Gm-Features: AQ5f1JoExnNXS3ZQXERuD4-XaPB2Zp9nHfEaZdChhCaVbixhpetBpDwqPrKBx9Y
Message-ID: <CANiq72m0g4a2x=oyVHMP1wkpi8k3t1CpRZDAVoYD+yAFPfMwtg@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Tamir Duberstein <tamird@gmail.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:14=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> The only reason for delay I can think of is all of the patches which
> adjust clippy warnings, etc., for things like addr_of_mut!() (and
> possibly some of the casting). I'm unlikely to have time to re-send
> everything out before the merge window with those fixed (I'm going to
> be away for the latter half of this week), so if folks are okay with
> either accepting this as-is, doing a follow-up fix, or delaying those
> warnings, that's ideal on my end.

Yeah, those series (Antonio's or Tamir's) are independent, and in my
view they shouldn't delay something (a feature) like this series.

Cheers,
Miguel

