Return-Path: <linux-kselftest+bounces-42942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDFBCBCAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 08:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A58F3A8B2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 06:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA622579E;
	Fri, 10 Oct 2025 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1AhY70n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bA55roXF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6B3F9D2;
	Fri, 10 Oct 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078084; cv=none; b=P0PVNYMUfjwPE6dgeES8/Sic/L1rUciOEj2IA+jWRhlnyCkJTjI/ksFPxCXE1sdff7GdjRpKQm00WROsulDSg8P77RHk/fj5t4JV17P0AWr17hFJro96BSdJU0NPWVJ0z/Q69+AomDZbQl4dGFPAhC7n9mNgey3WD5Gub4dcCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078084; c=relaxed/simple;
	bh=/mRuhHRC392X5pmkdrDLMtdkkjcqyAuBiMgYYggFlTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAv0vtkPT5QuJtqKGWLm2vUR8WcqSp3vDbcj9G4R8qh0nk09jvgpAMVXs513Vbn2vhvNY4bFUVBlT/5Iu1Ek7j73xFa4Cnx/YwNlFNIfCcfiMH5O4KnG8ECbHmNzJpol3nu4BQm1DCmpSS7/QG3+WwLpk0cJe2FIUblzkWceSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1AhY70n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bA55roXF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 Oct 2025 08:34:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760078074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyHaf+gpqdV0paie6RQCx/SzHlqjG0cpyjEGnlnxH3g=;
	b=R1AhY70noMw1rq5tVIxcwaKnSBzuMYiRyC3t5+A+M8DhOS3KPLigGXd9yEwW64CvZggc/t
	RSlzf/adWKNmwgE3gCjgTpcAcBl6zoxKdT23tJUbECXol3fws1O1fjrvDgnl3YUoo5U+Vv
	4mX+ffPhdA2FX86fLV0qO8Uorg+clwAXYsbek0oTbb89medIExYRaDjRdghIeh9B4HWbuQ
	/zl2fttQuvTA5wmd1MiMbSLc28XmGWMzqNeEklEb8VEhEJLFEto9r/q10TzNVZja9l76e6
	SkLss1/7Tz6Ts0p47Hi6B0wfR3fMetAf2Nuz20HsUXH7ll3XOTzt+BU67/Hu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760078074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyHaf+gpqdV0paie6RQCx/SzHlqjG0cpyjEGnlnxH3g=;
	b=bA55roXF3H9aQTdJPa8VB1TN3l3w7swi8vZHx6aQCMkon2MmhDcnH+KHEfEghSjmgJi+8p
	4uKR5qF7yivf9LDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/run_kselftest.sh: Add --error-on-fail flag
Message-ID: <20251010082310-b25e69f3-4568-4886-a0c9-3bd611bce073@linutronix.de>
References: <20251007-b4-ksft-error-on-fail-v1-1-71bf058f5662@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-b4-ksft-error-on-fail-v1-1-71bf058f5662@google.com>

On Tue, Oct 07, 2025 at 11:06:46AM +0000, Brendan Jackman wrote:
> Parsing KTAP is quite an inconvenience, but most of the time the thing
> you really want to know is "did anything fail"?
> 
> Let's give the user the ability to get this information without needing
> to parse anything.
> 
> Because of the use of subshells and namespaces, this needs to be
> communicated via a file. Just write arbitrary data into the file and
> treat non-emppty content as a signal that something failed.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 14 ++++++++++----
>  tools/testing/selftests/run_kselftest.sh    | 14 ++++++++++++++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 2c3c58e65a419f5ee8d7dc51a37671237a07fa0b..fd1e0f9b1cef48c5df1afaaedc0c97bee1c12dc5 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -44,6 +44,12 @@ tap_timeout()
>  	fi
>  }
>  
> +report_failure()
> +{
> +	echo "not ok $*" >> "$kselftest_failures_file"
> +	echo "$*" >> "$kselftest_failures_file"

Both of these go into the failures file. The first should go to stdout, no?

> +}
> +
>  run_one()
>  {
>  	DIR="$1"
> @@ -105,7 +111,7 @@ run_one()
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -e "$TEST" ]; then
>  		echo "# Warning: file $TEST is missing!"
> -		echo "not ok $test_num $TEST_HDR_MSG"
> +		report_failure "$test_num $TEST_HDR_MSG"
>  	else
>  		if [ -x /usr/bin/stdbuf ]; then
>  			stdbuf="/usr/bin/stdbuf --output=L "
> @@ -123,7 +129,7 @@ run_one()
>  				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
>  				cmd="$stdbuf $interpreter ./$BASENAME_TEST"
>  			else
> -				echo "not ok $test_num $TEST_HDR_MSG"
> +				report_failure "$test_num $TEST_HDR_MSG"
>  				return
>  			fi
>  		fi
> @@ -137,9 +143,9 @@ run_one()
>  			echo "ok $test_num $TEST_HDR_MSG # SKIP"
>  		elif [ $rc -eq $timeout_rc ]; then \
>  			echo "#"
> -			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
> +			report_failure "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
>  		else
> -			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
> +			report_failure "$test_num $TEST_HDR_MSG # exit=$rc"
>  		fi)
>  		cd - >/dev/null
>  	fi
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index 0443beacf3621ae36cb12ffd57f696ddef3526b5..c345f38ad424029bfe50d19b26bdd1d4bda29316 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -36,6 +36,7 @@ Usage: $0 [OPTIONS]
>    -n | --netns			Run each test in namespace
>    -h | --help			Show this usage info
>    -o | --override-timeout	Number of seconds after which we timeout
> +  -e | --error-on-fail	After finishing all tests, exit with code 1 if any failed.

To me it looks like the new behavior could be the default,
removing the need for an additional option.

>  EOF
>  	exit $1
>  }
> @@ -44,6 +45,7 @@ COLLECTIONS=""
>  TESTS=""
>  dryrun=""
>  kselftest_override_timeout=""
> +ERROR_ON_FAIL=false
>  while true; do
>  	case "$1" in
>  		-s | --summary)
> @@ -71,6 +73,9 @@ while true; do
>  		-o | --override-timeout)
>  			kselftest_override_timeout="$2"
>  			shift 2 ;;
> +		-e | --error-on-fail)
> +			ERROR_ON_FAIL="true"
> +			shift ;;
>  		-h | --help)
>  			usage 0 ;;
>  		"")
> @@ -105,9 +110,18 @@ if [ -n "$TESTS" ]; then
>  	available="$(echo "$valid" | sed -e 's/ /\n/g')"
>  fi
>  
> +kselftest_failures_file=$(mktemp --tmpdir kselftest-failures-XXXXXX)

Quoting?

I'm not a fan of the implementation details, but also can't come up with
something better.

> +export kselftest_failures_file
> +
>  collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
>  for collection in $collections ; do
>  	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
>  	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
>  	($dryrun cd "$collection" && $dryrun run_many $tests)
>  done
> +
> +failures="$(cat "$kselftest_failures_file")"
> +rm "$kselftest_failures_file"
> +if "$ERROR_ON_FAIL" && [ "$failures" ]; then
> +	exit 1
> +fi
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20251007-b4-ksft-error-on-fail-0c2cb3246041
> 
> Best regards,
> -- 
> Brendan Jackman <jackmanb@google.com>
> 

