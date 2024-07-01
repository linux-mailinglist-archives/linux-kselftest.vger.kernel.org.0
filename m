Return-Path: <linux-kselftest+bounces-13013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F591E42B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97FCB21EE5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CC15A84A;
	Mon,  1 Jul 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHSorZUM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57353AC;
	Mon,  1 Jul 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847478; cv=none; b=PGPw3hhNkmv31aEMspngip01LO5gtg6kX9SelLL3ZcnpYUbzGipZ3wn3Db9Cwf4DtqJDxs2oZ102mRIxbm58FGPr9oVC3ofgPyGDTVMJ3nhcTeaoPjtOoiAJtfUrOgq1YTznM8wv/PlucOgxdMQcKuS7FGpBpmG63tpbAZnOm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847478; c=relaxed/simple;
	bh=zO9zhZD7NeH4rydIMT73BHxp3UakCkHYLjUnbSxaWL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJ6pcwnKVpCSHvzjUWMf0Eg1A3W4u3/sgxt4U9kxXr1v3EhmcDp5Zu2BVkVgZ2WX0bqxQXjv3oCYUXtIqNK9U4+VTSzcO0v/EHnXsObiEfmmTrcNXxZIgN56IH0tu1CjUNKmMwz+vyL4em6NY08rwIpjro+cU94zpWBbx/IghXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHSorZUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D071C116B1;
	Mon,  1 Jul 2024 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847477;
	bh=zO9zhZD7NeH4rydIMT73BHxp3UakCkHYLjUnbSxaWL4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jHSorZUMcXuesKtFDjbDCSGsCvspP9sWAA7tNS1fw/HExjeozcLWG0z2yMGHqB5O+
	 9I/zg6EdRkmi8yYFSalWQsWa+rgpA4VhQCDx+esHyvmqs8xqtluJbU6dmGlc/WaLhj
	 fP4nC6mF9amPo04nt/8zU+r2BYaa2OYr8qLCsl5geD2k/YEAzJUzRAHAyv1VkZQa++
	 ZukTBZcCMuwz4iTLq4+9mCn72AeWcgTsVnqPKAzjyuqBX/2QZhOlCaHxEvegeeOnXk
	 TJ5OgwEi8TYUXZG1AKvE0ylIbwSXNgy3MQy2VwcmPLValdgH2AWRlN8dFnKpVqpiqh
	 etcPLf5r9kq9Q==
Message-ID: <c082049759b7caa2368e61f34f7f7c4671429533.camel@kernel.org>
Subject: Re: [PATCH] selftests: tpm2: conform test to TAP output
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Mon, 01 Jul 2024 15:24:34 +0000
In-Reply-To: <af21c2d7-46ce-4a18-88a5-c0d4bccaf1dc@collabora.com>
References: <20240426091435.2742024-1-usama.anjum@collabora.com>
	 <4fb5ad2e-cc9f-4ad6-94a5-7de9f503ab94@collabora.com>
	 <af21c2d7-46ce-4a18-88a5-c0d4bccaf1dc@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 13:40 +0500, Muhammad Usama Anjum wrote:
> Adding Jarkko
>=20
> On 5/28/24 10:05 AM, Muhammad Usama Anjum wrote:
> > Kind reminder
> >=20
> > On 4/26/24 2:14 PM, Muhammad Usama Anjum wrote:
> > > The python unittest is being used for executing tests. TAP output
> > > cannot be added in the unittest framework. The python unittest is bei=
ng
> > > run from a script. Add the output TAP logs to the script. Add "#"
> > > prefix to the python unittest output which will mark all output as
> > > informational TAP messages. Check exit status of the python unittest =
to
> > > decide if test passed or failed. Not sure why but python unittest
> > > outputs logs in stderr. So redirect the logs to stdout and then add
> > > prefix.
> > >=20
> > > Specify the bash explicitly instead of sh to run these tests as all o=
f
> > > the kselftests are shifting towards using bash explicitly. Some
> > > interpreters have different syntax and cause issues.
> > >=20
> > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > ---
> > > =C2=A0tools/testing/selftests/tpm2/test_async.sh | 24 +++++++++++++++=
+------
> > > =C2=A0tools/testing/selftests/tpm2/test_smoke.sh | 19 ++++++++++++++-=
--
> > > =C2=A0tools/testing/selftests/tpm2/test_space.sh | 19 ++++++++++++++-=
--
> > > =C2=A03 files changed, 50 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/tpm2/test_async.sh
> > > b/tools/testing/selftests/tpm2/test_async.sh
> > > index 43bf5bd772fd4..0e6e5d9d649fb 100755
> > > --- a/tools/testing/selftests/tpm2/test_async.sh
> > > +++ b/tools/testing/selftests/tpm2/test_async.sh
> > > @@ -1,10 +1,22 @@
> > > -#!/bin/sh
> > > +#!/bin/bash
> > > =C2=A0# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > > =C2=A0
> > > -# Kselftest framework requirement - SKIP code is 4.
> > > -ksft_skip=3D4
> > > +DIR=3D"$(dirname $(readlink -f "$0"))"
> > > +source "${DIR}"/../kselftest/ktap_helpers.sh
> > > =C2=A0
> > > -[ -e /dev/tpm0 ] || exit $ksft_skip
> > > -[ -e /dev/tpmrm0 ] || exit $ksft_skip
> > > +ktap_print_header
> > > =C2=A0
> > > -python3 -m unittest -v tpm2_tests.AsyncTest
> > > +[ -e /dev/tpm0 ] || ktap_finished
> > > +[ -e /dev/tpmrm0 ] || ktap_finished
> > > +
> > > +ktap_set_plan 1
> > > +
> > > +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1 | sed "s/^/# /"
> > > +
> > > +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> > > +	ktap_test_pass "tpm2_tests.AsyncTest"
> > > +else
> > > +	ktap_test_fail "tpm2_tests.AsyncTest"
> > > +fi
> > > +
> > > +ktap_finished
> > > diff --git a/tools/testing/selftests/tpm2/test_smoke.sh
> > > b/tools/testing/selftests/tpm2/test_smoke.sh
> > > index 58af963e5b55a..2219a180de91d 100755
> > > --- a/tools/testing/selftests/tpm2/test_smoke.sh
> > > +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> > > @@ -1,9 +1,22 @@
> > > -#!/bin/sh
> > > +#!/bin/bash
> > > =C2=A0# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > > =C2=A0
> > > =C2=A0# Kselftest framework requirement - SKIP code is 4.
> > > -ksft_skip=3D4
> > > +DIR=3D"$(dirname $(readlink -f "$0"))"
> > > +source "${DIR}"/../kselftest/ktap_helpers.sh
> > > +
> > > +ktap_print_header
> > > =C2=A0
> > > =C2=A0[ -e /dev/tpm0 ] || exit $ksft_skip
> > > =C2=A0
> > > -python3 -m unittest -v tpm2_tests.SmokeTest
> > > +ktap_set_plan 1
> > > +
> > > +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1 | sed "s/^/# /"
> > > +
> > > +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> > > +	ktap_test_pass "tpm2_tests.AsyncTest"
> > > +else
> > > +	ktap_test_fail "tpm2_tests.AsyncTest"
> > > +fi
> > > +
> > > +ktap_finished
> > > diff --git a/tools/testing/selftests/tpm2/test_space.sh
> > > b/tools/testing/selftests/tpm2/test_space.sh
> > > index 04c47b13fe8ac..6a55d13d74983 100755
> > > --- a/tools/testing/selftests/tpm2/test_space.sh
> > > +++ b/tools/testing/selftests/tpm2/test_space.sh
> > > @@ -1,9 +1,22 @@
> > > -#!/bin/sh
> > > +#!/bin/bash
> > > =C2=A0# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > > =C2=A0
> > > =C2=A0# Kselftest framework requirement - SKIP code is 4.
> > > -ksft_skip=3D4
> > > +DIR=3D"$(dirname $(readlink -f "$0"))"
> > > +source "${DIR}"/../kselftest/ktap_helpers.sh
> > > +
> > > +ktap_print_header
> > > =C2=A0
> > > =C2=A0[ -e /dev/tpmrm0 ] || exit $ksft_skip
> > > =C2=A0
> > > -python3 -m unittest -v tpm2_tests.SpaceTest
> > > +ktap_set_plan 1
> > > +
> > > +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1 | sed "s/^/# /"
> > > +
> > > +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> > > +	ktap_test_pass "tpm2_tests.AsyncTest"
> > > +else
> > > +	ktap_test_fail "tpm2_tests.AsyncTest"
> > > +fi
> > > +
> > > +ktap_finished
> >=20
>=20

Cc me to the next patch version.

BR, Jarkko

