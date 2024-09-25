Return-Path: <linux-kselftest+bounces-18333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D1984F95
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 02:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E6B20EFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8495132103;
	Wed, 25 Sep 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR+V/BUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE6130499;
	Wed, 25 Sep 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225406; cv=none; b=Re8ddgqePCLI1Xs0xNVBTEtxhGJmCHIGkFJFPr7xyqsEluoeT0aPRQaNL9Imv8zTFHsk5UDrMZLWG5t+7CmtXCBEr1kkDOUTy6oWPzD5mJBfRfYnukW6Mg4lT3SpN5IeXXaOedg8pohjlryiqKDnz5t3XTf6XRm2DuHUgEl+UQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225406; c=relaxed/simple;
	bh=n9b2CcW3JcflL4xUUDh/blICAcUDGjmnRZHdA6aXMZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChmkqGk4s8+e4ENM/BtNQtJuXfUhh6mZrmOdsdnxzewSnH1TKpU1Cbz4iggib0PpFKcN+A8gKjr8qm7Vy1iFNkrGREkrsbkDdFtIpuqLkC5bzTM8aXX8Bgk+kb+XjvSyCKgETCJ/hguIhR1vI9xYuTuiltci1AvqaebNrk+gGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR+V/BUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA45AC4CEC4;
	Wed, 25 Sep 2024 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727225406;
	bh=n9b2CcW3JcflL4xUUDh/blICAcUDGjmnRZHdA6aXMZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LR+V/BUwffxK2X8mV7Pu6x1gSzmO5d1+YwaUopuUgjZQQjGV4xF3ff5eGISvr6OA+
	 ZA5RUiT6oHOwtxpqfKT94uOKh6VVgEqH7/EfWPg8GDU/k726DvcbpjwRJ666LWEAm+
	 P93PeVXMUFiKRWq2FUsR5YArVAahxeER1e12WeoLWHKGlfCa7GKwWrUaookXDPGeRL
	 6+WTmUNBG9Vz/lB6PcxWvOMgt/4TmpDithskA7MdHzXtYQQZzqsndMalWoK3uYS2FK
	 6KkONLkFvnoAJwg0RD6HbuAM1Mg20mz9Bffh5GKenPtpLL6ebVfgcqSpciijPbOatz
	 FwARod0/wKabw==
Date: Tue, 24 Sep 2024 17:53:26 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] selftest: remoteproc: Add basic test for start/stop
 sequence
Message-ID: <ad6zsxcmqxavf7uo76ipriqjg7ipijafkaehgs5wthyyf364lv@kg4kzrxgucgl>
References: <20240920175842.388781-1-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920175842.388781-1-quic_wasimn@quicinc.com>

On Fri, Sep 20, 2024 at 11:28:42PM GMT, Wasim Nazir wrote:
> Add new basic remoteproc test that check start/stop
> sequence of all subsystems available.
> 

Please describe your test scenario more than just "check start/stop
sequence".

Signed-off-by...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e062b5328341..aff76edc4242 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18225,6 +18225,7 @@ F:	Documentation/staging/remoteproc.rst
>  F:	drivers/remoteproc/
>  F:	include/linux/remoteproc.h
>  F:	include/linux/remoteproc/
> +F:	tools/testing/selftests/remoteproc/
> 
>  REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
>  M:	Bjorn Andersson <andersson@kernel.org>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 697f13bbbc32..31db0311efdc 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -68,6 +68,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += remoteproc
>  TARGETS += resctrl
>  TARGETS += riscv
>  TARGETS += rlimits
> diff --git a/tools/testing/selftests/remoteproc/Makefile b/tools/testing/selftests/remoteproc/Makefile
> new file mode 100644
> index 000000000000..a84b3934fd36
> --- /dev/null
> +++ b/tools/testing/selftests/remoteproc/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_PROGS := remoteproc_test.sh
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/remoteproc/config b/tools/testing/selftests/remoteproc/config
> new file mode 100644
> index 000000000000..a5c237d2f3b4
> --- /dev/null
> +++ b/tools/testing/selftests/remoteproc/config
> @@ -0,0 +1 @@
> +CONFIG_REMOTEPROC=y
> diff --git a/tools/testing/selftests/remoteproc/remoteproc_test.sh b/tools/testing/selftests/remoteproc/remoteproc_test.sh
> new file mode 100644
> index 000000000000..88c8f15d8406
> --- /dev/null
> +++ b/tools/testing/selftests/remoteproc/remoteproc_test.sh
> @@ -0,0 +1,165 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> +#
> +
> +DIR="$(dirname $(readlink -f "$0"))"
> +
> +KTAP_HELPERS="${DIR}/../kselftest/ktap_helpers.sh"
> +if [ -e "$KTAP_HELPERS" ]; then
> +    source "$KTAP_HELPERS"
> +else
> +    echo -n "1..0 # SKIP $KTAP_HELPERS file not found"
> +	exit 4
> +fi
> +
> +RPROC_SYS=/sys/class/remoteproc
> +RPROC_SEQ_SLEEP=5
> +rproc_ss_files=
> +num_tests=0
> +test_err=0
> +
> +check_error() {
> +	if [ $? -ne 0 ]; then
> +		test_err=$((test_err+1))
> +		ktap_print_msg "$@"
> +	fi
> +}
> +
> +rproc_seq_test_ss_one() {
> +	ss=$1

"ss" or "subsystem" are Qualcomm terms, please use "remoteproc instance"
instead.

> +	rproc=${RPROC_SYS}/$ss
> +	rproc_name=$(cat $rproc/name)
> +	rproc_state=$(cat $rproc/state)
> +	rproc_ssr=$(cat $rproc/recovery)
> +	ktap_print_msg "Testing rproc sequence for $rproc_name"
> +
> +	# Reset test_err value
> +	test_err=0
> +	if [ "$rproc_ssr" != "enabled" ]; then
> +		echo enabled > $rproc/recovery
> +		check_error "$rproc_name SSR-enabled failed"

Same with "SSR", you can express this with standard terms.

Why do we need "recovery" enabled in order to perform start/stop or
stop/start testing? Doesn't recovery only affect the crash code path?

> +	fi
> +
> +	if [ "$rproc_state" != "running" ]; then

I'd like to see your arguments in the commit message, or a comment here,
of why you do either start/stop or stop/start - instead of e.g. make
sure they are all stopped and then start/stop them in the test.


PS. Please use check go/upstream and adopt b4.

Regards,
Bjorn

> +		echo start > "$rproc/state"
> +		check_error "$rproc_name state-start failed"
> +
> +		sleep ${RPROC_SEQ_SLEEP}
> +
> +		echo stop > "$rproc/state"
> +		check_error "$rproc_name state-stop failed"
> +	else
> +		echo stop > "$rproc/state"
> +		check_error "$rproc_name state-stop failed"
> +
> +		sleep ${RPROC_SEQ_SLEEP}
> +
> +		echo start > "$rproc/state"
> +		check_error "$rproc_name state-start failed"
> +	fi
> +
> +	if [ $test_err -ne 0 ]; then
> +		ktap_test_fail "$rproc_name"
> +	else
> +		ktap_test_pass "$rproc_name"
> +	fi
> +}

