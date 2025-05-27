Return-Path: <linux-kselftest+bounces-33831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA94AC45AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 02:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5483E3BCDBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2348D1FDA;
	Tue, 27 May 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1du49yD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698210E3;
	Tue, 27 May 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304780; cv=none; b=SZD1d0R+BA3QrDZ90bPXHru7dnYEFseVEQu7ZANT89usW9HgHjL6iRO3b8idmKg/XFphuG6Ei55Xs0nv+ksOXxGmuAyYZ+BuiaBCfLlUyBYKK1w6m313WG1QabyXKs+8veBU1wb6NxannohnVX1xUTTVvO2LBjYabaFEspkcpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304780; c=relaxed/simple;
	bh=ShvoaIDylmqmCO/4tqPQuAPuovRvMewoIpt2vjGQa/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CF6nQddDhoc9fmDE3obqtRrruLS/Pj8qWYy3BImRosR0U5BomUtpz9QZIHy/3bIGoNSMuz4iXfNvePxMt4bMKuRyhWa6PCiN2G3nfK+KocENOlN+lFdavhXo2WOd2lgeAm/Zb6+h3DmcminTc9jwt71qTZFYKJ93PnBRLVKOkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1du49yD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311676255c3so98573a91.3;
        Mon, 26 May 2025 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748304778; x=1748909578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDUVHJC72R11plYvEJN4plaYAB5GiKYQgfvLL/uyWH4=;
        b=j1du49yDdrNV0cnn2nAox51kHS42m1rIzwYJB7g7d3ZXJ2RrPMNcEriviPvC6kPbpV
         GDPs77SjrXM6NudVbG3uYyacgXa8kdv48lbgK8J3ZLx9JzOT/DJwZubm+6u6y6mW8xZ1
         YbaPLvPPLcEYyKObnIcyHP5jacUOqDMXt1bDisEmZ3W9k3vAeVud0PzEVp7+Qidc7XL+
         T/kC7+sAmZxaAGrrHvsnQdi/C+RpHop1R7c5pyQKh8oIV1nILzPsWbe4qraeXjvMLGR9
         ytSEGewpAGkWU9vUYN78kIqSsjfBw28ylbsAbNtw+EAlxqREtGal+cMScEZp4i9W+Ged
         5C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748304778; x=1748909578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDUVHJC72R11plYvEJN4plaYAB5GiKYQgfvLL/uyWH4=;
        b=hT8TO8RsKGVJMSIAB745k9OzFQnTCR6re3tJVgUU7GT+EBxxp+CaK7F5MAkwcldJw1
         WNyWY4x5yIa+biyhKKXLnnlYi8QmIsuZ6Hohn/uA9NdQPj3TUFyy8z2+t0AeLDsmo+H/
         Va6LmQFTpzv8GPi0uzAceb2uCi4O5M6Kltqclm/GzTghf0qmji2WoF1vnfYYAjUvaIgV
         9aFb8A6hOim32o9eEx2am7eEUBeEiSIYGSnwPtrrO1N8ySjlq123MWRE+W+kotbBud65
         ZGEIMYSrJw9fZVmDiZD6SZVNbXEkXzErZ1ZJJ58XZ9mUlOahVrTpeScrj4C9oGDV71et
         2qGg==
X-Forwarded-Encrypted: i=1; AJvYcCUg/gF5Xrm+SdE57FfLdWdW7z8vG81EEkGQV8OzG1qsj3p10pfaKoWnStwa4+NnPvyS1HIWrkzKmOowrXY=@vger.kernel.org, AJvYcCUzMvOYF4uSkG46DBJvBVog9gQ75ZZ9J87eDTyNgbcCSm96R7QARK3iUOg26R7IKpNZvQJmYP0L6WargjfmkIOE@vger.kernel.org, AJvYcCWhny3LpBEyRUcFaW11phh1G+BFA4vVPTP9btDOaBE8wnlTo6LTELGSJ5ehVWx5O61zZC8HR/i4YlQBnCBhlzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkf1t1TwJ5qaZ4oT5dxT2Mi62KKQxwfSRQe0aqu68ZcEQlWYAY
	cXNXNmYYeqYaZJwawGUCQ2SAtS412hdtMSpmmcdsyqm7uNPK0blw6tDQ1G+9JaoMyrHOC0ZccFR
	RndcavnLmt6ft0dswlCz4cL8jTUG1utM=
X-Gm-Gg: ASbGnctXzAe9KSGh6aDQABM7Y+ybCGfsTZrzyaAAJhUW02BjoqTFUr38Lm2Zva2MU64
	maQ3U8Rfn8fned+yLUh9+Iz93nKcinO3Zx0TL2k9FIRFUSGCYHeBvbnZN3fd01bqni3qf+ln8Mt
	cPIDO1s/E3RPaZED1MTElQBTpxwDpxuVLe
X-Google-Smtp-Source: AGHT+IGP6WSH1KR6xEx1oB8OliPNzy9iZnUE2S1clmoqmPisa2Cs0N5JoYvUV6KeHWSF04V6hwfbzOMIFPpxAN9AOFs=
X-Received: by 2002:a17:90b:3ec1:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-3110f0ee9b7mr6504882a91.1.1748304777913; Mon, 26 May 2025
 17:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <CANiq72mj2yv4E7Dd+19fmP9xGWELdv6JwXULpu91oq0BMzob+g@mail.gmail.com>
In-Reply-To: <CANiq72mj2yv4E7Dd+19fmP9xGWELdv6JwXULpu91oq0BMzob+g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 02:12:46 +0200
X-Gm-Features: AX0GCFuWVeWoWd2QF4i5h3bZPOTXxZwG0hZtocU1fZDNtHBMsACg5wKAztA9UY8
Message-ID: <CANiq72=q66Xvihm9t3hbtJVAcB+f-aRRY9+amSEWBZrCjTcyUQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rust KUnit `#[test]` support improvements
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 2:10=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>     [ Split from the next commit as suggested by Tamir. - Miguel ]
>
>     [ Split the `CString` simplification into a new commit. - Miguel ]

By the way, I kept the tags from David and Danilo in that new commit,
since it was really a pure split, but of course let me know if someone
doesn't want that.

Cheers,
Miguel

