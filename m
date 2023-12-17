Return-Path: <linux-kselftest+bounces-2109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D800D81634C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 00:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900882823B2
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 23:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80849F98;
	Sun, 17 Dec 2023 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVE6QyMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BD49F8D;
	Sun, 17 Dec 2023 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so644129a12.2;
        Sun, 17 Dec 2023 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702855386; x=1703460186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFKLHnzI1MkQMFN4aygtqwkY70T4csRqR2mODluuL4g=;
        b=gVE6QyMAhBi0KMKfBWeqoDDY3SclvTQ7IRulluPIVybfMUbjuFR1jphoG5cMzlFGaG
         njUG29+KEATkt9JPNIFJelw1BVtsSIRogk4LvyNm2tlLIRI0t6o1rTt4/PAM4TP1bTKC
         agmAMYovR/Ylkvo9sQICc7tUL3msuIQx/uYBoPDR7FHaxtXCdC7ASIaOw+hmV/2xrtF3
         DHkU9+5KS6nYJBKo3+O2zblhse4uTrqKqy3AM5agPIeOsOff2bj17J1ncTuzMqRCi9p5
         tTF3xvogHCc2AorvAd2EyQZ0Qns0l0l4ZdL4IR/FLNI9War1u6eRcPGQ0zahrV/v+5JG
         Jqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702855386; x=1703460186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFKLHnzI1MkQMFN4aygtqwkY70T4csRqR2mODluuL4g=;
        b=rbm0JU4CLGqM2ipVB6d8PONM1mAiFw9XYjfa161WFNQjohY1xSiKdYekCDYsx+3tY7
         rcnpa3efkO4vXXhOT1IL2JRY6Wes/a9MBmDEud1f7cWZMsl43rdouj1IKW+ubYHJGM6c
         PoJ6N3pcwj5yUDvLZwazkaJWY31OFPsMEYgW9r9VAOi93HEfZf5yPKkXnNMe0sk//Jna
         BO/9lwDbcYI3ze9xbntb7e5S4KLDrHL+PQsTAn3+rdmPzCqOonJvWxCpRfaftsW5ecSW
         xLLKg/1IeSoLxAOjNMm0UV3SQmhpK0kiq1SitbQfLUtoincLwL0o+SgyR1C38c1FIbRy
         ey4w==
X-Gm-Message-State: AOJu0YxZE5+NjEPgBBCh24OFprSBzpvcgzQJTIaVxlJa9C2kwI2OxCYf
	eln1PIUQFkWFpJsRu0azHFCalk9Zg26dd2p7D5s=
X-Google-Smtp-Source: AGHT+IFRPhyRTKuojMsil2yKkL04/71aHlgb7+G4YVmuDXz/+pcBvd2/+IfbASuI78uWL89BWkqU5LDRdph2b3LCdCY=
X-Received: by 2002:a50:d78b:0:b0:54b:687f:446c with SMTP id
 w11-20020a50d78b000000b0054b687f446cmr8075776edi.31.1702855386340; Sun, 17
 Dec 2023 15:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215132132.169628-1-laura.nao@collabora.com>
In-Reply-To: <20231215132132.169628-1-laura.nao@collabora.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 18 Dec 2023 00:22:30 +0100
Message-ID: <CAA76j90YdSaAQYBKNwge5jpsexn_KG-qD89+V0_e4vumjLqEDQ@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Add basic test for probing the rust sample modules
To: Laura Nao <laura.nao@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Shuah Khan <shuah@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 14:25, Laura Nao <laura.nao@collabora.com> wrote:
>
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  MAINTAINERS                                   |  1 +
>  tools/testing/selftests/Makefile              |  1 +
>  tools/testing/selftests/rust/.gitignore       |  1 +
>  tools/testing/selftests/rust/Makefile         |  8 ++++
>  .../selftests/rust/test_probe_samples.sh      | 42 +++++++++++++++++++
>  5 files changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/rust/.gitignore
>  create mode 100644 tools/testing/selftests/rust/Makefile
>  create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2c6187a3ac8..acf283a5d2c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18847,6 +18847,7 @@ F:      Documentation/rust/
>  F:     rust/
>  F:     samples/rust/
>  F:     scripts/*rust*
> +F:     tools/testing/selftests/rust/
>  K:     \b(?i:rust)\b
>
>  RXRPC SOCKETS (AF_RXRPC)
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 3b2061d1c1a5..26140426c849 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -74,6 +74,7 @@ TARGETS += riscv
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> +TARGETS += rust
>  TARGETS += seccomp
>  TARGETS += sgx
>  TARGETS += sigaltstack
> diff --git a/tools/testing/selftests/rust/.gitignore b/tools/testing/selftests/rust/.gitignore
> new file mode 100644
> index 000000000000..e3c5c04d1b19
> --- /dev/null
> +++ b/tools/testing/selftests/rust/.gitignore
> @@ -0,0 +1 @@
> +ktap_helpers.sh
> diff --git a/tools/testing/selftests/rust/Makefile b/tools/testing/selftests/rust/Makefile
> new file mode 100644
> index 000000000000..ccaa50f35b5b
> --- /dev/null
> +++ b/tools/testing/selftests/rust/Makefile
> @@ -0,0 +1,8 @@
> +
> +TEST_PROGS += test_probe_samples.sh
> +TEST_GEN_FILES := ktap_helpers.sh
> +
> +include ../lib.mk
> +
> +$(OUTPUT)/ktap_helpers.sh:
> +       cp $(top_srcdir)/tools/testing/selftests/dt/ktap_helpers.sh $@
> diff --git a/tools/testing/selftests/rust/test_probe_samples.sh b/tools/testing/selftests/rust/test_probe_samples.sh
> new file mode 100755
> index 000000000000..a46550543f73
> --- /dev/null
> +++ b/tools/testing/selftests/rust/test_probe_samples.sh
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2023 Collabora Ltd
> +#
> +# This script tests whether the rust sample modules can
> +# be added and removed correctly.
> +#
> +
> +DIR="$(dirname "$(readlink -f "$0")")"
> +
> +source "${DIR}"/ktap_helpers.sh
> +
> +rust_sample_modules=("rust_minimal" "rust_print")
> +
> +KSFT_PASS=0
> +KSFT_FAIL=1
> +KSFT_SKIP=4
> +
> +ret="${KSFT_PASS}"
> +
> +ktap_print_header
> +
> +ktap_set_plan "${#rust_sample_modules[@]}"
> +
> +for sample in "${rust_sample_modules[@]}"; do
> +    if ! /sbin/modprobe -n -q "$sample"; then
> +        ktap_test_skip "module $sample is not found in /lib/modules/$(uname -r)"
> +        continue
> +    fi
> +
> +    if /sbin/modprobe -q "$sample"; then
> +        /sbin/modprobe -q -r "$sample"
> +        ktap_test_pass "$sample"
> +    else
> +        ret="${KSFT_FAIL}"
> +        ktap_test_fail "$sample"
> +    fi
> +done
> +
> +ktap_print_totals
> +exit "${ret}"
> --
> 2.30.2
>
>

Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>

