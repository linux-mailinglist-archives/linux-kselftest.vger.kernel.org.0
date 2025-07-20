Return-Path: <linux-kselftest+bounces-37712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28BB0B87A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6DF3B9789
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274691F181F;
	Sun, 20 Jul 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdE7sah4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62551DE8A4;
	Sun, 20 Jul 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050042; cv=none; b=soC1y6u7++itk3hkTZe1Iya05eZc/s9ZGomGEf/+mLvSqEoHV5xY/UUlZk3nzCwn5iJxB7LXyt4YlDeUbGQvqOvIYoSoTnFL006C2RrQ1rq15/hYXT3veL7JdYGY1NhzVMi8XMjQq3PoKlq1lL7w4Cy7+no8L1Xc5QVc9YJ7qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050042; c=relaxed/simple;
	bh=mpgqK+O0m6zO53aSXcw4x5Rvxxj3q7jMk1YJQoBS47Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVnKWSOlvh+zWF7JMcI1ZzQsbatQRyLWw5lX0iJzr1/qsAeQpAu2KPQwy2EsgYfXy5kg6wUToVUcMvsn+MpGBjxEibNdePBn01K78+5RQNVEKydVjaA+H7BDRwsPusZHiT41bWQhm4yEQmKkPMVXHqCttzvxtcGX0OuYn/ofatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdE7sah4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so1022079a91.2;
        Sun, 20 Jul 2025 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753050040; x=1753654840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2IA3sMXL8MfYHWrx6ejWU6QjqsZ3Jj7kffCWQM2MQg=;
        b=EdE7sah4XaX1iBn4bNP4kBs7EXDLnTBbg3J9uibh1GMjOnpwqlMWAZNYWhNKpjZ6FZ
         rtqa9x1NTS5AO6SwI2EiTvP4bWpxQc/jwYMXAfu+NzxMsc4orGh/LK0CB8YRBcO2KL/b
         kdZScn7ekAONqvkspCRpxfVgDVg9ORJBm9HOM9LyK1YL2qKuNWAHvtqPqhvJqq6KOix7
         lu04rh+iaSqlCLnph0LpINPmx049EQAIUM6KewTX0ggRtoH1rSk1HZsnYe+fCet2v/jI
         68wNdTvxfgui/3f02Kz7OHF+ks1ycX87T9icArmSI8y0JqX0YKpg5SDCSjVmbZBYVTnR
         DcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753050040; x=1753654840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2IA3sMXL8MfYHWrx6ejWU6QjqsZ3Jj7kffCWQM2MQg=;
        b=LyNE1jD+5HE1iRhOg8To69MLvOXSOs7CazQZOaerpd5jn18Gf1l3zAisfK47Jj9tbv
         6y3j5/J/AF/nJfZR6z3PJVbIKOT7ihi2rtnxXR2VxUUlTLXYBfzQymEtBeaIrYfna5go
         xs0uI8ilPEmpxtTqZWLNqCt+ODJnpIxUgxqzrCMuIG/pO6O0PM/mknNZ7hj3lETZDU1W
         R3vbOKKSidR02CKElfjkJyEsrKtRRj4mPHb54o11IunrtwlmtAtJB10KsstZan8URVKh
         ynSAbvsPQ7NYJ2aM1/S80vzSMmtr6d80Peo0MkIxiplCODGWXKzW0vpOKFYNxGhr0SEE
         jJmA==
X-Forwarded-Encrypted: i=1; AJvYcCU+2tUsw9jpxl2A9c58+990ID6eh2w0Bm4ApaJOoHrsEfH7g6ocQg/DpKF622efYuGjumydJWQJgg+TAZQ=@vger.kernel.org, AJvYcCUq7FtUzNBTTEJndUeSr/iMIXQL0VgjeSe482Zc7L0EHTsS91WWVerWJya4nBTxEpf8OrLz7QJBIRwy3xGp016r@vger.kernel.org, AJvYcCXMiKoh7ydekB/i2QovnZujnH/OAUeFtT7eqaL7+PiSy/kXAbKMSqo7gtvTztpofIrCJL41Y/iGZ78XKZjRaKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKOB4Lh6qQLjfMoJVEhgej2BgAmi06ml4Md45mXPu2QAik65a
	U5DKiz9OaN8TSki6Tty1yzbNEIozxHU1wonq9i7cakJ7AvGbUsfyTFhA9EUP6xN6s5gbO4wrQ3Z
	pXwuMLSUgAFWFYW3sdXSSQiDDyahHTeg=
X-Gm-Gg: ASbGnctS6ORvGarfMIS3SjpSSbLfJ+Q8uC5I8txHTycXGtBI3qzbUOuTJzGaxJWCHTd
	ee3ih8FpN2vlaUppPqcYbcxMUCYhEyS8Ev3XR6bLv0mPP1OWvhnlNHBkXtLGdR5nCpjZxfm1BTY
	/GlKhbdohUuuceIYlyRzIdNwGIsKWNXCiAMIsPyb+DLuidNRluIXG1jwvIiE1Us43eW7oE4fdaz
	Jxm8QSS
X-Google-Smtp-Source: AGHT+IHDtz6azWEF/xGmb9dqZOj2H3tX8J7UDfAhEpXoe7djUPf2x1euDZPU4WxseqamxBJUAo9cNkVVoajiO78BgtM=
X-Received: by 2002:a17:90b:55cb:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-31c9e7a4b17mr10406175a91.8.1753050039987; Sun, 20 Jul 2025
 15:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com> <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com>
In-Reply-To: <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 00:20:27 +0200
X-Gm-Features: Ac12FXyLsz1bmwVkFG-DrTCV5JzIvjpyMKUulmGV4UeLKeC-0LFpqJp96ApQGpI
Message-ID: <CANiq72nb4LuwkZVjEseMubSX4VOMNTX-8wUV7LtS5FN80cMjyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: emit path candidates in panic message
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 3:15=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> +                write!(&mut candidates, "    {path:?}").unwrap();

I assume this was supposed to be `writeln!`; otherwise, we lose the
newlines and the indent does not make much sense.

I will fix it when applying.

Cheers,
Miguel

