Return-Path: <linux-kselftest+bounces-29584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793FA6C2F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 20:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37CD46180E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147E11EB1A1;
	Fri, 21 Mar 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEiQ4Sf6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9D154426;
	Fri, 21 Mar 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583905; cv=none; b=EWkt5zPQff2dufCs1m2LUrtHCVvyjAwVONQIV4E8vCAbMg/bpJbHa/3evu4uTZ0EKm5RSpH8P+XKTrtIyEvsAhQFY+FRTPaBsAJdZQfO2WPL4d508BLytBIpri7v5PuBvbwISzYRdruQIQ+JhBc1FhYUAxE0/vhQJbHd1bevVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583905; c=relaxed/simple;
	bh=jKbpIna3dbFZRR/fucLtB7Q4uGgsuLmcIOJYUwilYQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzJ7twrdLOmt5kOQ4TUKfwOHPxxLLQ0iuXWUanTAM65PzdoiDWocNQfG6IuDGYrszm6GZMoT+PveAjuTFmgQrYSMxsC1YlJQ9lC56kVsAgQQX5X13MacY3v0kpJxeWGg6tQt5gd8DifhQaXVm9zbHJBvW+YABKYrcL0xZ+95kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEiQ4Sf6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22792ef6215so1653085ad.2;
        Fri, 21 Mar 2025 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742583903; x=1743188703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKbpIna3dbFZRR/fucLtB7Q4uGgsuLmcIOJYUwilYQw=;
        b=WEiQ4Sf6QgmSD5YK+kRSNcJ04w2Eb9ZK3YhVJIypMw73i9zu3Rk8cgZcc1B47Wvfxq
         CZxObsAvmBl29wUtgDW3QNC31uxuD1HhqAoGD96Vnxmkd0uhfuKSyx+qT/gvlg+iaxUp
         MJyPeDd7OsQGLKtb7GhrlXZ7PAMsPVb5SdJCr2765/2BYq1v4ddT4+PS81F32a8qgFEn
         di6zOcwPQ614Gi3UJPUZiOKotLMYl2M1z3QV5RBrpa8zgNYFzVbrI8vVcY+hkFEu5O5V
         QE7grmpHoCRu72he+QPQW/nnvgNgfzMWjWq/mc2XfmcwFMcReIXScjxaPV10KfJhU82P
         39SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583903; x=1743188703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKbpIna3dbFZRR/fucLtB7Q4uGgsuLmcIOJYUwilYQw=;
        b=GUPyrdTC/CMy7aTsy7LCGss9nAXkP/cxsX11Z1IHJjEUjzy2dEzN8ycZmaV2BsE6Ha
         yWMhjEdZ/6xxFcAgIqen25RinShASQUPSFvKMda/vcfMLxET3DA7SRUm4RXq1EVv1uQp
         6e4clbLaVEzjUI01HMJS/10Ep7wOBtFd9+j+pm5yPgvmvAReshcDFXYJ59Kw5npoqK/c
         L0QD/wm36blW4ZLQgPtd56fE95L5ofAmmB0B70/o372UB/6NgcqoXNNsfYp5h6qIU+W1
         3rks8lJ5HIFWbEYv05cnfL7KxEFa9bCt7hli/ZMH+hUd1qF0g79TjT63uL83BNrPKbKE
         7hiA==
X-Forwarded-Encrypted: i=1; AJvYcCVRDg2iGo3q/Mapa/GPa3Jw5AsDr9tGZ0MlohxK1730+r9//IDwHlzFeUIpYgQS0OpFHm+fbnnaWPKlUOAUq+TU@vger.kernel.org, AJvYcCW8CbSyM84BsjnMT77CITUGoo3DwI2pg6v7M3Y9U+UJJ8uR8+mZOvcEzvKNJ7Q+uUrDNEmky8ESrmLf1UU=@vger.kernel.org, AJvYcCWnhy5HHrYyM2CSL6WUij1BF6u0Txy9TH1PrQXr7dFG8fGmF0TPqN8vqTcIJx7w37MhGhzI0WXT9R7r3GS+98k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEYVVylxQPOiaD3/kSi1AysI45I4C0eXI8v3ZErwe5rq/Ekgo
	5JTVIzAi4LyWfTRqrYma9oPyJHCtjYwxmVZokaIR3BMaSw8ShuCS5hbtIxp5L7rnQQyraO4GfmQ
	LQ7SdLDIANnCsJ4wv2+TzbEaI5M8=
X-Gm-Gg: ASbGncuGWKKbFo0DaU4dVqrZ3l+vaKrXQ5omWf3D7AP0h1ga2CbqnHbOiP/eeEcigiP
	Z9DQHaZ/KWapiwJDViw1fIbnIo5zYVg3tu6s41csyPjLpUVBjBDAc7m61M3Fkm7Lh3BQFZCVJdS
	gQFJQAdCdon1/WgcjkuhWxJPEdfw==
X-Google-Smtp-Source: AGHT+IFfF0WPiynY7L/JMlKt3aOD+drhtkQpAHg8KRXBtOzwTJ2kdZ/CImypmGLptIC1aJB6bgaJlhn7NWrtUmFYLik=
X-Received: by 2002:a17:902:ea07:b0:224:1579:b347 with SMTP id
 d9443c01a7336-22780d82835mr25006905ad.7.1742583902713; Fri, 21 Mar 2025
 12:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-9-contact@antoniohickey.com> <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
 <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
 <CABVgOSmhMP4F74GuwRG3bWyumgF19WxmC=ymbehuWVD==OxdnQ@mail.gmail.com> <67dd9c7d.c80a0220.2d0437.7969@mx.google.com>
In-Reply-To: <67dd9c7d.c80a0220.2d0437.7969@mx.google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 20:04:50 +0100
X-Gm-Features: AQ5f1Jpvyxmt1d9L20jGnAvbXaB55k7MlP28iVo1DJSdd1UYYF2ozSi8aGPpqI4
Message-ID: <CANiq72ngWXcPnn60JFzqfY7pd+1UFmt+CAmg1q67VxfUnuiJfg@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: David Gow <davidgow@google.com>, Antonio Hickey <contact@byte-forge.io>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Antonio Hickey <contact@antoniohickey.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:06=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> I agree this whole series should wait a bit, but do we want to merge
> patch #1 as early as possible (maybe right after v6.15-rc1), so that new
> code can switch to &raw since that's the direction anyway?

Sounds like a good idea to me.

Cheers,
Miguel

