Return-Path: <linux-kselftest+bounces-29536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B3A6B17E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 00:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AB417D86F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447A2253BA;
	Thu, 20 Mar 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcZO1KqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FE22259F;
	Thu, 20 Mar 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512565; cv=none; b=h9OzhzDNeyaJdSnIu53NVvRf46Lob2igqxoJeVPysuCLfijXrhizeskXI+wzL1PWTOUWB8GG3G+1S4uYoXIoPK+E+GnP1CFMUTGNKz8ki1qn/OApE1DkjyPnJrjtUCJrUNe6ysfEnR/bWYu6NW+9LEUV26jvjVskoD0BLJ36zIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512565; c=relaxed/simple;
	bh=Ydxfige0Qt9rhjF9s2BhO4yX2CTtIsRjAujiYNVvwfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sW7YVp4zYIf7j6CGa9n9YF+rx2bUv7CY9wKVfjeejHwuBWgDQWVzciKJDREWyzJ7JZ16LjQNixg14UbqURQT30TB9yieGMuXnIQTTHdZaR1QH7i9QAgfsGUsTi2JFCsgLNu0h6yfY6MRX2TDQGQvDFJrZb2b08kOpMoZ1fa2OLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcZO1KqH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30144a72db9so330658a91.1;
        Thu, 20 Mar 2025 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512563; x=1743117363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydxfige0Qt9rhjF9s2BhO4yX2CTtIsRjAujiYNVvwfo=;
        b=fcZO1KqHh8ecuSfZldeBL3h2khhbDnVan66VbGszPTdrK6AyG7cVE2SKb4YruaOWKu
         jIdiSlrpX/HXO/sGuZpSzB8NJHAmJyV4RneG5/0zGo4LR3xLbvX9aC3Ocw3ikgWybQvu
         /P8fgwJYjVt7z6Gw/fh16fG8RZuvj++GEd0AhgCLtgL2xcG4FWwXlqgj/9GExIAJ7tS7
         +IYupKhCkiyIcR00+dmLNJyJMGQwd1XeruKZa+4DU3J38fffWIWV1dWmBilMBYR7TLjh
         aRAQLMF3VFUIKLDWHLOHgxVjTeD/gHRH9qUBgCD66JI9rYfnVSTAiUhajtm+4jWOOgm1
         mGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512563; x=1743117363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ydxfige0Qt9rhjF9s2BhO4yX2CTtIsRjAujiYNVvwfo=;
        b=bkfeMPiH8v/MV1cW0ioMXl4y7ccIHJgtEXM3JyN7/ZGGeJT/Lur/HY1+e4RXk4IIGZ
         BLFaRWupa5z7YJUu/5SbagHMulnbssDMrB9nRwHBqclAAgj6JLQrHTSSBuzvjVjXHh71
         3AURwqDVwATZRNA1E8togKhJBUjveAyg4VwhoAUA7FEpyZeMzUhXySKhwIBgF7EVF0ll
         ynPYCwgpbcYSG4N2WThgKsloIRemRsET0mByXQpdOmW6oylUR8KPfywEpX4s9wb2NiaL
         0l9Jw85l1GeFwlCC/9PnXJJEcw6q3i/IpvS0vY+qhPoILZWDfAuNoZ7Hw2xKN7QYcYLY
         JumA==
X-Forwarded-Encrypted: i=1; AJvYcCV6KAyMMSmi8eTxPtGwfz8CtGndvxjqUeWF5pPq750MV3kse7AsjLLSDulDMl0yd8Fsw+jeGpVgew7DbEqu6BTk@vger.kernel.org, AJvYcCWAzgGtti8Ab7bssrgJaHDyx/R40XNj9EeKaYJzdr2O9AUHzjqdH9XdIDgOq66fZtCXSfQE24TMJjEQ6bQ=@vger.kernel.org, AJvYcCXCrp5Uy96qv84oOhljUvdmwCj85P0puEJAb4FeM0ec4wafBKkuaQPUweum5/IViPcEsvlyTS0FSJ+OKEol5b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvIK4Q6rfbjFS15FGbkEplL95Gw0AsS6hycO/oMUDp2TxIUsW
	ucMiC2OioJIyMBcv8Fj+403GfKM285HqKcoy1t3QL7b1HOFm9W39BQaVDYdno688QCZ/3NqgpkV
	PYbHTn4P//ULzU/zffsEWRCb6YRs=
X-Gm-Gg: ASbGncud6iaLFq4Qfl3o4hqO5o2kkUZikJ751L9yC4n7fJGQE26OPuqLCO7HIB76HLl
	LwPSD0xkzXRX+EP3U26EHuoe+/k/3RGjtLBIMrjMvTCVxo+pP+b6XQxw9b1IkFdII5LsGQrnU1B
	vKEscw4NhXfRgIJ5gIQTiz+/soww==
X-Google-Smtp-Source: AGHT+IEPthy1/e/i4AFWlh6vRu8JgcwxaoROuqkfEcIemV6NB/GcdEIEE0+HBaASQjzuFJSpiJ7txn/KiNZA6nAcf68=
X-Received: by 2002:a17:90b:3a90:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3031321b196mr234814a91.5.1742512562872; Thu, 20 Mar 2025
 16:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-9-contact@antoniohickey.com> <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
In-Reply-To: <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 00:15:49 +0100
X-Gm-Features: AQ5f1JpuFaFwMimQ5FPKyDiYDaVf3vM9hX1WsOImxjBowRVA4KFUcl3e3XdKgGA
Message-ID: <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
To: David Gow <davidgow@google.com>
Cc: Antonio Hickey <contact@byte-forge.io>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Antonio Hickey <contact@antoniohickey.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:02=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> In general, I think changes such as those in this series are going to
> get progressively more prone to conflicts as Rust is adopted by other
> subsystems, as the 'rust' tree won't be the only one carrying changes
> which could be affected. Maybe in the future it'd make sense to split
> these up into a series which enables the new feature, and only then
> put the warnings in place in the next version?

+1, I had to do a two-cycle split for other things in the past
already, e.g. for Gary's FFI series.

I agree that churn for this kind of change has a cost. For tree-wide
series, it will become harder and harder over time, just like in C,
and some changes and cleanups may take several cycles.

For Clippy lints, I think we have some extra flexibility. We still aim
to keep everything Clippy-clean (and patches sent should be sent clean
under the latest stable Rust version at least, and maintainers should
enable Clippy in their test runs), but if something slips in a
particular corner/config/arch that is not routinely tested, it is not
the end of the world as long as it gets cleaned up.

Anyway, KUnit `#[test]`s are in -- I was not planning to merge this
now anyway, it should be reviewed a bit more.

Thanks!

Cheers,
Miguel

