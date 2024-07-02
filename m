Return-Path: <linux-kselftest+bounces-13093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D1924C66
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 01:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E135B1C20B75
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3115B10B;
	Tue,  2 Jul 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxK70bGB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C31DA32A;
	Tue,  2 Jul 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964262; cv=none; b=ga/9C2QRt/9E89XLqiFYHFlRc/AC4SzT5L5X9fxxhkmuV7MLizo4s9qbMkaSWWy1NRwWOIhwh60qIr9MxwF0k0uKDvpU9wMUTsaoLhcihqiXvyLET3XgSJgvhnrCCg6cpJsgY7jiuxI8Raegp4KoZ9NSC3kpidaoFfV0JHyV6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964262; c=relaxed/simple;
	bh=ctcDbJ9YllTRckLiie3Fv33wxtw7FWJYQwy96EE4ENg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJAuCMDjKjsrTickaVaFPNDSuxcbwJYOxkX7ZzJZ0IxT4c4udunEnrMXy6NuuRXaTwkyY06yKwt73pjSliEzHCqmNB/7FllzzgIVvYEgqHIsXq5Lmg6kqmCFHlscFgVfB/wGygyL5sS0nMghkS1SbXAy5e/ZPDPlfnjyMjqJgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxK70bGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02530C116B1;
	Tue,  2 Jul 2024 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964262;
	bh=ctcDbJ9YllTRckLiie3Fv33wxtw7FWJYQwy96EE4ENg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jxK70bGBMieCUxYq1eVUZu5ETs9nQnTUi+WaREKXaxDiU+S+9I+HPr3PGEAsCOXGR
	 NC5eUyk7nU5/393x7t+vX7jnDz889wiWvMHspiNdbRNJIaYACgTnaYHGQ8uvqfogHL
	 JT+iKg1xOjJH2TR/n9GR2aPOn4OvoV+J4/CuC5XK+hvqG23RdcKOl1q3V2x9urpOOl
	 P2D8gjbYbejVu6A2XJIywioUEqr8z8HrYPW8VRwKTeIH4YCt70l+o192sVPXPNCDlY
	 WL0B2jfqgms5GkW+Wd8x0rRHBmGwgCsCEPsMH2WVwwOOD57zXt3L3Fqn836iWR3R2U
	 LBxHbgbOgL9Vw==
Message-ID: <1e74e47457e2dec53bdb0b18b678a1e99299d53e.camel@kernel.org>
Subject: Re: [PATCH] selftests: tpm2: conform test to TAP output
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	 <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Jul 2024 02:50:58 +0300
In-Reply-To: <20240702065559.772855-1-usama.anjum@collabora.com>
References: <20240702065559.772855-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 11:55 +0500, Muhammad Usama Anjum wrote:
> The python unittest is being used for executing tests. TAP output
> cannot be added in the unittest framework. The python unittest is being
> run from a script. Add the output TAP logs to the script. Add "#"
> prefix to the python unittest output which will mark all output as
> informational TAP messages. Check exit status of the python unittest to
> decide if test passed or failed. Not sure why but python unittest
> outputs logs in stderr. So redirect the logs to stdout and then add
> prefix.
>=20
> Specify the bash explicitly instead of sh to run these tests as all of
> the kselftests are shifting towards using bash explicitly. Some
> interpreters have different syntax and cause issues.
>=20
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - CC more people which were missing earlier
> ---
> =C2=A0tools/testing/selftests/tpm2/test_async.sh | 24 ++++++++++++++++---=
---
> =C2=A0tools/testing/selftests/tpm2/test_smoke.sh | 19 ++++++++++++++---
> =C2=A0tools/testing/selftests/tpm2/test_space.sh | 19 ++++++++++++++---
> =C2=A03 files changed, 50 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/testing/selftests/tpm2/test_async.sh
> b/tools/testing/selftests/tpm2/test_async.sh
> index 43bf5bd772fd4..0e6e5d9d649fb 100755
> --- a/tools/testing/selftests/tpm2/test_async.sh
> +++ b/tools/testing/selftests/tpm2/test_async.sh
> @@ -1,10 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
> =C2=A0# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> =C2=A0
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> +DIR=3D"$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> =C2=A0
> -[ -e /dev/tpm0 ] || exit $ksft_skip
> -[ -e /dev/tpmrm0 ] || exit $ksft_skip
> +ktap_print_header
> =C2=A0
> -python3 -m unittest -v tpm2_tests.AsyncTest
> +[ -e /dev/tpm0 ] || ktap_finished
> +[ -e /dev/tpmrm0 ] || ktap_finished
> +
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh
> b/tools/testing/selftests/tpm2/test_smoke.sh
> index 58af963e5b55a..2219a180de91d 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -1,9 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
> =C2=A0# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> =C2=A0
> =C2=A0# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> +DIR=3D"$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +ktap_print_header
> =C2=A0
> =C2=A0[ -e /dev/tpm0 ] || exit $ksft_skip
> =C2=A0
> -python3 -m unittest -v tpm2_tests.SmokeTest
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished
> diff --git a/tools/testing/selftests/tpm2/test_space.sh
> b/tools/testing/selftests/tpm2/test_space.sh
> index 04c47b13fe8ac..6a55d13d74983 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -1,9 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
> =C2=A0# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> =C2=A0
> =C2=A0# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> +DIR=3D"$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +ktap_print_header
> =C2=A0
> =C2=A0[ -e /dev/tpmrm0 ] || exit $ksft_skip
> =C2=A0
> -python3 -m unittest -v tpm2_tests.SpaceTest
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished

Acknowledging that I noticed this but won't test
before week 31, when I'm back from holiday.

BR, Jarkko


