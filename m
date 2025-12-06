Return-Path: <linux-kselftest+bounces-47220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0DCA9D2A
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 02:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4CEC3026986
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B7224B1E;
	Sat,  6 Dec 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok94njrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4121D585
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983706; cv=none; b=US5NCaNe/yjRcFgpGGXmtHvvUdjS2tUkjud504deu8RAcXniM7pIZiBXV5lLiZbTb7Rmja1t0lx9228COUxwI6Fci4uQKYLkbXvVZ6l5FEPtja1a6/Kcf2qDqvWhcGZk/nO4MtYyRRRk8fFRpmwtVd7tN84vdbjm17Ue4XQ77xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983706; c=relaxed/simple;
	bh=k7vn03xYpt9hwCU4zPJ8OyGGc9vGZ3yKMuF6XjNxoHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYcL3C1sgt24538HMF168BQcryDxUk0yAWKw6NFzbcIW94maDQe/tY7fNuucgRrNUg+BeIYIDbdhkMBruC8bQIdMGcykrR9X6W4FMzOqq7yD3yQfnRb2JEiRVNQS/LALdM/U9PgSS8ads9mgwSYlcza+iZARMT7jYVbBdPuaGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok94njrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2094C2BC9E
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 01:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764983705;
	bh=k7vn03xYpt9hwCU4zPJ8OyGGc9vGZ3yKMuF6XjNxoHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ok94njrIeJWKKbBL4t2QH95D7wqdWVdQ5t3yQEPcrht5BokaJhoTF4LeP5B9intg9
	 cwd1SmBJX0z4a3u0+g7f52NrPV74gG7ezYzZoSsqfJgshoehcj38bdqERaSe+Z2JQ3
	 sxCsS9JiFJE95eLzBFN6DzjagMCZ0AHJBBgTVVA7vwZXbCn+fkliGZJ3RkNk0WzLUt
	 wP59tHr4zxlxlMJLvZzSBBjJSav3uEUKSlI+wmHAGPuFYbI+yNn1xah5c2gunB17Az
	 S7KBMAIds/H26RfqwjjNPqgmSCDngTkKlhHio2VlYiEGYM/HzCgllU0AKetZ9kDZgm
	 3kPKR3GzpLAAA==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7895017c722so26730647b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 17:15:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6URzvzVhVIEl7T03G3vdyyMkhRgZeeXqf5V0oWZeSpoC8Tuc6Zf42jFDdYFekJtbka5mjfDe3gIlyB60IOlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6swE8V0lQEKKIhoSD5J75wf4oY2ImFj74YjYnuyYKKDoCfR3/
	VelgBXF+xxWxV/lqgaPv7HJbOBJcvpqlaT8N5vnfEcKq9gmCMMWpl9ouYaHiaN6//zIllHYnwsO
	GN8loCgzGDIR1i0M+uYk6Q0dTG9HjLAY=
X-Google-Smtp-Source: AGHT+IExpiGzlLEDTL6++vidfifAf1Ir9DdQssL/98HJtyKIKmr8HQ/9SDSGmaA811TD+/v0RKmMlKchNmOuTWhusG4=
X-Received: by 2002:a05:690c:6c87:b0:788:f66:7822 with SMTP id
 00721157ae682-78c33b277b9mr9041907b3.4.1764983704890; Fri, 05 Dec 2025
 17:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205173923.31740-1-git@danielhodges.dev> <20251205173923.31740-4-git@danielhodges.dev>
In-Reply-To: <20251205173923.31740-4-git@danielhodges.dev>
From: Song Liu <song@kernel.org>
Date: Fri, 5 Dec 2025 17:14:54 -0800
X-Gmail-Original-Message-ID: <CAHzjS_sDeUTV3FMGD_iraCo7dxAbSf0BVx_-jSGyEQv_67ckkw@mail.gmail.com>
X-Gm-Features: AWmQ_blUXDsA2xCgGsEnqBQ-7QbPPw7fXAjpl5i8klOONOXxk7e99z-TUkUswck
Message-ID: <CAHzjS_sDeUTV3FMGD_iraCo7dxAbSf0BVx_-jSGyEQv_67ckkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] selftests/bpf: Add tests for
 bpf_crypto_hash kfunc
To: Daniel Hodges <git@danielhodges.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	vadim.fedorenko@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 9:39=E2=80=AFAM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> Add selftests to validate the bpf_crypto_hash works properly. The tests
> verify both correct functionality and proper error handling.
>
> Test Data:
> All tests use the well-known NIST test vector input "abc" and validate
> against the standardized expected outputs for each algorithm. This ensure=
s
> the BPF kfunc wrappers correctly delegate to the kernel crypto library.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  tools/testing/selftests/bpf/config            |   2 +
>  .../selftests/bpf/prog_tests/crypto_hash.c    | 158 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/crypto_hash.c | 141 ++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
>  create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 558839e3c185..d168b3073cba 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -12,7 +12,9 @@ CONFIG_BPF_SYSCALL=3Dy
>  # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
>  CONFIG_CGROUP_BPF=3Dy
>  CONFIG_CRYPTO_HMAC=3Dy
> +CONFIG_CRYPTO_HASH2=3Dy
>  CONFIG_CRYPTO_SHA256=3Dy
> +CONFIG_CRYPTO_SHA512=3Dy
>  CONFIG_CRYPTO_USER_API=3Dy
>  CONFIG_CRYPTO_USER_API_HASH=3Dy
>  CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_hash.c b/tools=
/testing/selftests/bpf/prog_tests/crypto_hash.c
> new file mode 100644
> index 000000000000..f1495ea85aae
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_hash.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0

Maybe add Copyright here?

> +
> +#include <test_progs.h>
> +#include <errno.h>
> +#include "crypto_hash.skel.h"
> +
> +/* NIST test vectors for SHA-256("abc") */
> +static const unsigned char expected_sha256[32] =3D {
> +       0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea,
> +       0x41, 0x41, 0x40, 0xde, 0x5d, 0xae, 0x22, 0x23,
> +       0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
> +       0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad
> +};
> +
> +/* NIST test vectors for SHA-384("abc") */
> +static const unsigned char expected_sha384[48] =3D {
> +       0xcb, 0x00, 0x75, 0x3f, 0x45, 0xa3, 0x5e, 0x8b,
> +       0xb5, 0xa0, 0x3d, 0x69, 0x9a, 0xc6, 0x50, 0x07,
> +       0x27, 0x2c, 0x32, 0xab, 0x0e, 0xde, 0xd1, 0x63,
> +       0x1a, 0x8b, 0x60, 0x5a, 0x43, 0xff, 0x5b, 0xed,
> +       0x80, 0x86, 0x07, 0x2b, 0xa1, 0xe7, 0xcc, 0x23,
> +       0x58, 0xba, 0xec, 0xa1, 0x34, 0xc8, 0x25, 0xa7
> +};
> +
> +/* NIST test vectors for SHA-512("abc") */
> +static const unsigned char expected_sha512[64] =3D {
> +       0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba,
> +       0xcc, 0x41, 0x73, 0x49, 0xae, 0x20, 0x41, 0x31,
> +       0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
> +       0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a,
> +       0x21, 0x92, 0x99, 0x2a, 0x27, 0x4f, 0xc1, 0xa8,
> +       0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
> +       0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e,
> +       0x2a, 0x9a, 0xc9, 0x4f, 0xa5, 0x4c, 0xa4, 0x9f
> +};
> +
> +static void test_sha256_basic(void)
> +{
> +       struct crypto_hash *skel;
> +       int err, prog_fd;
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +
> +       skel =3D crypto_hash__open_and_load();
> +       if (!skel) {
> +               /* Skip if kfuncs not available (CONFIG_CRYPTO_HASH2 not =
set) */
> +               if (errno =3D=3D ENOENT || errno =3D=3D EINVAL) {
> +                       test__skip();
> +                       return;
> +               }
> +               ASSERT_OK_PTR(skel, "crypto_hash__open_and_load");
> +               return;
> +       }
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.test_sha256);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_sha256");
> +       ASSERT_EQ(skel->data->sha256_status, 0, "sha256_status");
> +       ASSERT_EQ(memcmp(skel->bss->sha256_output, expected_sha256, 32), =
0,
> +                 "sha256_output_match");
> +
> +       crypto_hash__destroy(skel);
> +}

nit: We have quite some duplicated code here. Maybe try to reuse some of
the code?

Thanks,
Song

