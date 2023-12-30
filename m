Return-Path: <linux-kselftest+bounces-2534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16239820403
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 09:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F03B212D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 08:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A76D6DE;
	Sat, 30 Dec 2023 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eTwsyt0A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125C23A0;
	Sat, 30 Dec 2023 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703924394;
	bh=D/rmWS9VU4cYt40QweSANvOejlIuAoUvy2Du5sUf6eg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eTwsyt0AV6pv+3zawmmedJxOW/I2uboiAgqm2UDj8H6xlD+ysBWsNNsnonqO0I8LT
	 XL7T3N7bJif7bd1qezdZmz68CBcTyNnantyuyujzRYgKqhguagfdarlncg0uGcu+qu
	 QMPz8ThVtDDC1CK1inh6AP10G/EpC8kpCGRvm+0puapKf8vLpuLSNaHvaLZR/HpEFU
	 wdOe6FBzo3O400HFWHJI8O/ATTW/q/rX18HwwDNVdFpAejP6UusElTdd6RxPhnh5Rs
	 hywXpQYJ09RRDoEE61eSKr10ZzqW8ChtfhAJMkI7pOUufaSqp6nasoq3iuL9Tc0YvE
	 qGFJpLdF6sFbA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 243F837813CF;
	Sat, 30 Dec 2023 08:19:48 +0000 (UTC)
Message-ID: <ce75321b-da1f-457a-abc5-982c0e95fff6@collabora.com>
Date: Sat, 30 Dec 2023 13:19:47 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH] kselftest: Add basic test for probing the rust sample
 modules
Content-Language: en-US
To: Laura Nao <laura.nao@collabora.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Shuah Khan <shuah@kernel.org>
References: <20231215132132.169628-1-laura.nao@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231215132132.169628-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/23 6:21 PM, Laura Nao wrote:
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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
> @@ -18847,6 +18847,7 @@ F:	Documentation/rust/
>  F:	rust/
>  F:	samples/rust/
>  F:	scripts/*rust*
> +F:	tools/testing/selftests/rust/
>  K:	\b(?i:rust)\b
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
> +	cp $(top_srcdir)/tools/testing/selftests/dt/ktap_helpers.sh $@
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

-- 
BR,
Muhammad Usama Anjum

