Return-Path: <linux-kselftest+bounces-18562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9071989954
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 05:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76B71C20A3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 03:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459B17736;
	Mon, 30 Sep 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnjTPXwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E899383;
	Mon, 30 Sep 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727665406; cv=none; b=VA3CF8pUWzRzTOOYMHyZbw+9oRAIkFLKJZE37k8oYHmdni7Z1xlks7gkmhZbIyUkp38fw005AythcCVNPO0bleom9AXp4KfpeR+iRo94729qfG/yS2wssDnD63ODPD6Ht/D8JF8ozVMyJcm2w+G8drs8COpmE8cJs44dphdRvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727665406; c=relaxed/simple;
	bh=ZPLeceSoms1LJsjZuhWfOriodeA4mCGIP5lnp9n3uWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9tqKBfqR1AGwsiS4c8W/ejrOttgh8U45CnnA7oIXchlGLX+1LTWfOzBEX9Ot2X1R4EsODb7FLpb+qwFC+2Jj8wWCEFCHuijKzviN8/Nf0AQ/pprly/Fz1Ys5KTj2UPQwjGrs0mHNz7A6vkyK5U/7G7wkqX62rPu/cLJu5I+U3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnjTPXwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246F2C4CEC5;
	Mon, 30 Sep 2024 03:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727665405;
	bh=ZPLeceSoms1LJsjZuhWfOriodeA4mCGIP5lnp9n3uWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnjTPXwTWozYj5fYuGn8DNPKlcBl20zqc6nd6xZx8+xGmowTe+k+NgxbxC76gLGzE
	 BRU1PnwlRTdBLlJocCgy2wpPKx/PGD5KSmiUGkKQcpoZJSWDfIy1RSJz7cfu8I/Eng
	 Ac7x7sK4wUW0d6VgsQpitWPB4/wWYHoWac9mI1J2dMyXF0tOo8A6Dy/ud2Zjwwr9iv
	 B82R9wtJqeE9L+WLaULFhxdpahgotVWRM0+xxRFe5x0k/jQec3Le71eQgpDQoCvE3q
	 YIr1j9n9cDXVP0B36mqYsEOXzUCKu+4RfFpoIjGsaxSO2rDgPDoaQIMJhf5l3z2b6O
	 gEuOjYG7v7G7w==
Date: Sun, 29 Sep 2024 22:03:23 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2] selftest: remoteproc: Add basic test for start/stop
 sequence
Message-ID: <xee5pz7qha3nn2ldr6ogtikbrc23d4mrxabdfv6ujtbtj7fcch@whh726b6xlhc>
References: <20240927112132.3927298-1-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927112132.3927298-1-quic_wasimn@quicinc.com>

On Fri, Sep 27, 2024 at 04:51:32PM GMT, Wasim Nazir wrote:
> This test includes:
>     1) Start/stop test for each rproc instance sequencially
>     2) Start/stop test for all rproc instances concurrently
> 

This fails to describe the purpose of the patch. Provide a proper commit
mesasge.

In particular, I expect an argumentation for your test scheme. Will this
work across all remoteproc instances? Does it have any dependencies,
etc...

> Changes in v2:
> - Update commit message
> - Addressed start/stop flow

The changelog goes below the '---' line, adjacent to your diffstat -
which is missing from your patch. I don't know how you're sending these
patches, but your system is either configured weirdly or you're not
following my instructions on go/upstream.

> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a77770cd96b8..02ebad5ae790 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19596,6 +19596,7 @@ F:	Documentation/staging/remoteproc.rst
>  F:	drivers/remoteproc/
>  F:	include/linux/remoteproc.h
>  F:	include/linux/remoteproc/
> +F:	tools/testing/selftests/remoteproc/
> 
>  REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
>  M:	Bjorn Andersson <andersson@kernel.org>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index b38199965f99..0c8a0f427d01 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -82,6 +82,7 @@ TARGETS += proc
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
> index 000000000000..589368285307
> --- /dev/null
> +++ b/tools/testing/selftests/remoteproc/remoteproc_test.sh
> @@ -0,0 +1,134 @@
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
> +    . "$KTAP_HELPERS"
> +else
> +    echo -n "1..0 # SKIP $KTAP_HELPERS file not found"
> +    exit 4
> +fi
> +
> +RPROC_SYS=/sys/class/remoteproc
> +RPROC_SEQ_SLEEP=5
> +rproc_instances=
> +# Declare an array to save initial states of each instance
> +org_instance_to_state=""
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
> +rproc_stop_instances() {
> +	for instance in ${rproc_instances}; do
> +		rproc=${RPROC_SYS}/$instance
> +		rproc_name=$(cat $rproc/name)
> +		rproc_state=$(cat $rproc/state)
> +
> +		echo stop > "$rproc/state"
> +		check_error "$rproc_name state-stop failed at state $rproc_state"
> +	done
> +	sleep ${RPROC_SEQ_SLEEP}
> +}
> +
> +rproc_start_instances() {
> +	for instance in ${rproc_instances}; do
> +		rproc=${RPROC_SYS}/$instance
> +		rproc_name=$(cat $rproc/name)
> +		rproc_state=$(cat $rproc/state)
> +
> +		echo start > "$rproc/state"
> +		check_error "$rproc_name state-start failed at state $rproc_state"
> +	done
> +	sleep ${RPROC_SEQ_SLEEP}
> +}
> +
> +rproc_seq_test_instance_one() {
> +	instance=$1
> +	rproc=${RPROC_SYS}/$instance
> +	rproc_name=$(cat $rproc/name)
> +	rproc_state=$(cat $rproc/state)
> +	ktap_print_msg "Testing rproc sequence for $rproc_name"
> +
> +	# Reset test_err value
> +	test_err=0
> +
> +	# Begin start/stop sequence
> +	echo start > "$rproc/state"
> +	check_error "$rproc_name state-start failed at state $rproc_state"
> +
> +	sleep ${RPROC_SEQ_SLEEP}
> +
> +	echo stop > "$rproc/state"
> +	check_error "$rproc_name state-stop failed at state $rproc_state"
> +
> +	if [ $test_err -ne 0 ]; then
> +		ktap_test_fail "$rproc_name"
> +	else
> +		ktap_test_pass "$rproc_name"
> +	fi
> +}
> +
> +rproc_seq_test_instances_concurrently() {
> +	# Reset test_err value
> +	test_err=0
> +
> +	rproc_start_instances
> +
> +	rproc_stop_instances
> +
> +	if [ $test_err -ne 0 ]; then
> +		ktap_test_fail "for any of $rproc_instances"
> +	else
> +		ktap_test_pass "for all $rproc_instances"
> +	fi
> +}
> +
> +ktap_print_header
> +
> +if [ ! -d "${RPROC_SYS}" ]; then
> +	ktap_skip_all "${RPROC_SYS} doesn't exist."
> +	exit "${KSFT_SKIP}"
> +fi
> +
> +rproc_instances=$(find ${RPROC_SYS}/remoteproc* -maxdepth 1 -exec basename {} \;)
> +num_tests=$(echo ${rproc_instances} | wc -w)
> +if [ "${num_tests}" -eq 0 ]; then
> +	ktap_skip_all "${RPROC_SYS}/remoteproc* doesn't exist."
> +	exit "${KSFT_SKIP}"
> +fi
> +
> +# Total tests will be:
> +# 1) Seq tests for each instance sequencially
> +# 2) Seq tests for all instances concurrently
> +num_tests=$((num_tests+1))
> +
> +ktap_set_plan "${num_tests}"
> +
> +# Stop all instances
> +rproc_stop_instances

Will this not fail for remoteproc instances that aren't started
automatically?

Regards,
Bjorn

> +
> +# Test 1
> +ktap_print_msg "Testing rproc start/stop sequence for each instance sequencially"
> +for instance in ${rproc_instances}; do
> +	rproc_seq_test_instance_one $instance
> +done
> +
> +# Test 2
> +ktap_print_msg "Testing rproc start/stop sequence for all instances concurrently"
> +rproc_seq_test_instances_concurrently
> +
> +# Restore all instances
> +rproc_start_instances
> +
> +ktap_finished
> --
> 2.46.1
> 

