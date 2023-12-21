Return-Path: <linux-kselftest+bounces-2316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E481BF3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B345D1F24271
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC66E2A1;
	Thu, 21 Dec 2023 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWJUVxH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9B697B1;
	Thu, 21 Dec 2023 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbd990ad852so1252506276.1;
        Thu, 21 Dec 2023 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703187994; x=1703792794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6/yAn6lNSX2MGYTUbcrF0LVeIXWmfijpcUqz22yFI0=;
        b=nWJUVxH+ONTZwvq3AgHS+xVh2JN2ZyV4CF1plmJ4op9Ire19x1MG4DfXdDHalgE3zL
         8H+Vu6ef3DuBYXiwMLhc+dtTr33cAu1ceaj22JuK7+BPfbUXBRQPI/ZOl7wZU9ayM+Zh
         czb8x6zHYeE33BQPgvIl2CEmcn749iGoSM+a+QTPbgKa7sh9oxrZoAlix/EhriCQYPH7
         k/t3H3qtxN8YAegCIqrlV/lAdLez+VcWSzkrpD2A+0As0lR/4r/53RK8rgTLzi6P+ls1
         ZedEcCcghQl4iWxe2VzRP1V5JMkMZkRRCpPpq2UZppIzcf6JIEk+A10fRCKm+2wiGHP5
         qWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187994; x=1703792794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6/yAn6lNSX2MGYTUbcrF0LVeIXWmfijpcUqz22yFI0=;
        b=T3nw5K5NEbBCpWT5DOMQ/22VNtHGVwLIsJlsYCFoNl6VQOiMWRK9XkrACJwWcPwLb2
         hGu5CHc5k6AF23xCUJUNw6NKuQj5oQ3tEvjejJ7SFNXmz8OOFZQ6lb3hAzSPfpPvuJSg
         YGbxuMR0HmRTNGBNBlS9kw/sx0oan2xb0eRsSulKLRw0AT3b48sFL63cTEXKhnQbNPDK
         joZ+A1LoOMzagqpwSYWfLVIogJ3nTdoNwHvB3t9PHLNgk3uxlqnUmncdDLtdM0qH/2Gi
         WJjkKdwaTsycnX92mQEjr8ULjdyuunEVZP0xciwoLQGSI3t1z1nf8JoWB+T8DkIJ08WQ
         6QhA==
X-Gm-Message-State: AOJu0Yza252RSQy8XA4sxjFs/mG7BMzKtKa82arsroEPXm08u1t/3e4H
	9odbi4CSYmZQcuoP5MqUpQOCw9xIs4aqOpMHp+8=
X-Google-Smtp-Source: AGHT+IGNtWN/NlhB9JTutxP0DQ7YOWRxNm+b5oJRXoY4j1WqomTGtZXvPrR2dVDq8UgdFw/9rw+7JItC3zAfAslucro=
X-Received: by 2002:a25:6606:0:b0:dbd:1334:a8d with SMTP id
 a6-20020a256606000000b00dbd13340a8dmr285785ybc.118.1703187994263; Thu, 21 Dec
 2023 11:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215132132.169628-1-laura.nao@collabora.com>
In-Reply-To: <20231215132132.169628-1-laura.nao@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 20:46:22 +0100
Message-ID: <CANiq72nAZ53fjsaMk8iYTwtqbvGo3LrTCpBCrh4zx6xLOFBP9w@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Add basic test for probing the rust sample modules
To: Laura Nao <laura.nao@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Shuah Khan <shuah@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel@collabora.com, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 2:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Thanks Laura!

Shuah: do you want that we pick this one? If so, your `Acked-by` would
be nice -- thanks! Otherwise, please feel free to pick it up.

Cc'ing David too since it involves KTAP in case he has comments.

> diff --git a/tools/testing/selftests/rust/Makefile b/tools/testing/selfte=
sts/rust/Makefile

Missing SPDX line? (it can be added when picking it up, though).

> +$(OUTPUT)/ktap_helpers.sh:
> +       cp $(top_srcdir)/tools/testing/selftests/dt/ktap_helpers.sh $@

This may be something for another series, but should these helpers be
factored out perhaps / provided by the framework? Does it work
sourcing them from `dt` directly instead of copying meanwhile (to
simplify)?

> +KSFT_PASS=3D0
> +KSFT_FAIL=3D1
> +KSFT_SKIP=3D4

Similarly, would it make sense for this kind of "common constants" be
factored somehow? Or does that not make sense (I see other tests also
define them "manually")?

Cheers,
Miguel

