Return-Path: <linux-kselftest+bounces-22800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D309E3058
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 01:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30B4164387
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126767F9;
	Wed,  4 Dec 2024 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYvaEiHX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FD1372
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271842; cv=none; b=D9BSHWMQ4k2u4TQKDTa7YRZKdKJcuMDbtnnglVgEAR3Q3vxp2/yAeDa5WG1/NacLXjJ84CSpppNl0KSZgBC3iIIjqTjHWX2exHeIAKzn4wi+j9LFMnUbQDIQBEMtVPTNCcxSCejY6bnRR//hYTyms3GM6+Uf539Y9+MmVjwdhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271842; c=relaxed/simple;
	bh=1a67SnFU13qE4J5y3Rgj7WQorDdDgbyoqJnmWeb0Gj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI+LmUvZgdQ/Jmwy8U4vgjIuNKOdf0Bl4LfMPPrhDMiLXLvDWb0NElIvyTj4s6RzHfYL90eBLORey3Jfrzar5Jn401mxuh3mkP6QrLCAlnW4uH/UQXT5cL+CaDKqkPHl08TTblXaLIy+mmc7S/mifEmxXdRB1j7o591tCxP/Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYvaEiHX; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a74d9aeb38so21677055ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 16:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733271839; x=1733876639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9FbCJ3x5IuqiKm/j7Dkcx5/WgXv4GorOvwEXGeUN44=;
        b=KYvaEiHXHaUqmeS/YeFapQIzT3dI5Bq7Es/YLXHVoIw0e/XQlXucw8K8mAZPW4BrRf
         /IHxzTZitQ1MgWKnU6U31GIQGB2I5TQDgRLcNhfQZBgoP0LsNoXJllxCAZZFlgWpmSs+
         kNNIJ94CPiCcZfkQF38Jf4Pj0ifOcLhXdEtbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733271839; x=1733876639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9FbCJ3x5IuqiKm/j7Dkcx5/WgXv4GorOvwEXGeUN44=;
        b=BjYmk70y3xuOz9xZgYBmM+eFgdBmdNS458pGaIcpS1lrB/s2mWcB9C4wMkg1yiXKZa
         uSd3UBI+SHidRXp2pOQaaur7EwmD+q+hNRKT4UC8QP1YjJ0cWStunjV9I+/aO/H5lHOY
         wJm+qqB6i1gmBiJgHKHGTkQAGnMDPJbZzN+dMhCHetSpaIPsm3OfNaWJ7KGBW8nlnQbD
         MAvN5RV9fAHjvKRbDY/7zxdXfATLc4dtnln9sJEsW6okgAZR5cQEfFm/d7XlOIIRXX9g
         g6lH94f/D2ugF23qCiLWvtu6f/1paOkG6TYkOliNtT7G5ZzJqxb3fP4/rbyRTH5A+Wic
         ps8g==
X-Forwarded-Encrypted: i=1; AJvYcCUKUU5o6JG6OS6obLXbJ0rVBFy7hmMNZ/hb/0Q1c91Px6tz/p7tsjFtc6xs1p+FlAmpF75m4JTEOtwUX87kwU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgMXGqHMffS5oyoejOlHmHLtpXjUTDtF/M0JFRDt5ZSJClNK9
	zpKLo4XnA1vXiJSis6f7S2tFyEF3Xehax3/69pSzf4jfl7gITUsajKUaIRYxpZY=
X-Gm-Gg: ASbGncsAjQpNZUdFuJD1kxVFrFrnGIqXySKYN59idWMEFnp2ZmUORDZq/vMG8Ecl8pg
	nAR2Osl4BmvvIpql3Qw3sNKapVvkChktxMDwZcUcIILph43hS4FHekGZKl7xo+uA3vcJRX5VF0Q
	bxyMMLgWueJQ0jYlqgoHwAoUFzMt0squHT4brwXLKtIOgFzdNErnAPMe/iLDIhCe67eEVzeB1mr
	CAs6E6zH05/8huRA5pohWwnEHQc39MEIkFiSPg5xvnPpTLIAI6Ut6RwGxkD3A==
X-Google-Smtp-Source: AGHT+IFFmMu7amT4tAHwLTX5LZYeNDtyDgTZPdJhuoc5E5+fNYPSbpXnhLVmJnXlu2dY0WS4xaa5Ow==
X-Received: by 2002:a05:6e02:19c8:b0:3a7:c5b1:a55c with SMTP id e9e14a558f8ab-3a7f99baa4fmr55303285ab.0.1733271839042;
        Tue, 03 Dec 2024 16:23:59 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e9064esm2736966173.156.2024.12.03.16.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:23:58 -0800 (PST)
Message-ID: <115bb206-8401-4475-977d-7dd98a2b872c@linuxfoundation.org>
Date: Tue, 3 Dec 2024 17:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: arm coresight: sysfsmode testing
To: Linu Cherian <lcherian@marvell.com>, suzuki.poulose@arm.com,
 mike.leach@linaro.org, james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129083813.3056909-1-lcherian@marvell.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241129083813.3056909-1-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/29/24 01:38, Linu Cherian wrote:
> Add sysfs mode selftest for ARM Coresight hardware tracer.

Please add details on what this test does in here. Include
the output from the test?

Does this test have dependencies on config? If it does, does
this test detect and skip if config isn't enabled?

> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>   .../drivers/hwtracing/coresight/Makefile      |   5 +
>   .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
>   2 files changed, 149 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile
>   create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> 
> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/Makefile b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> new file mode 100644
> index 000000000000..7dc68ae1c0a9
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS = sysfs_test_trace.sh
> +
> +include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> new file mode 100755
> index 000000000000..0d6307fff1d2
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> @@ -0,0 +1,144 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Marvell.
> +
> +# Test Arm CoreSight trace capture in sysfs mode
> +# Based on tools/perf/tests/shell/test_arm_coresight.sh
> +
> +glb_err=0
> +
> +arm_cs_report() {
> +	if [ $2 != 0 ]; then
> +		echo "$1: FAIL"
> +		glb_err=$2
> +	else
> +		echo "$1: PASS"
> +	fi
> +}
> +
> +is_device_sink() {
> +	# If the node of "enable_sink" is existed under the device path, this
> +	# means the device is a sink device.
> +
> +	if [ -e "$1/enable_sink" ]; then
> +
> +		return 0
> +	else
> +		return 1
> +	fi
> +}
> +
> +# Configure sink for buffer mode
> +cfg_sink_buf_mode() {
> +	sink_dev=$1
> +	mode=$2
> +	# Set buffer mode if supported
> +	if [ -e "$sink_dev/buf_modes_available" ]; then
> +		cat $sink_dev/buf_modes_available | grep -E -q $mode
> +		if [ $? -eq 0 ]; then
> +			echo $mode > $sink_dev/buf_mode_preferred
> +			return 0
> +		fi
> +	fi
> +
> +	return 1
> +}
> +
> +run_app() {
> +
> +	taskset -c $1 dd if=/dev/urandom  of=/dev/null bs=1M count=64
> +}
> +
> +sysfs_trace() {
> +	src_dev=$1
> +	sink_dev=$2
> +	cpu=$3
> +
> +	# Enable sink device
> +	echo 1 > $sink_dev/enable_sink
> +	# Enable source device
> +	echo 1 > $src_dev/enable_source
> +
> +	# Run app to be traced
> +	run_app $cpu
> +
> +	# Read back trace data
> +	dd if=/dev/$sink_dev_name of=/tmp/tracedata
> +
> +	# Verify if read is successful
> +	err=$?
> +
> +	# Disable source device
> +	echo 0 > $src_dev/enable_source
> +
> +	# Diskable sink device
> +	echo 0 > $sink_dev/enable_sink
> +
> +	arm_cs_report "CoreSight path testing (CPU$cpu -> $sink_dev_name)" $err
> +}
> +
> +try_sysfs_trace_resrv_buf() {
> +	src_dev=$1
> +	sink_dev=$2
> +	cpu=$3
> +
> +	# Configure the resrved buffer mode if available
> +	cfg_sink_buf_mode $sink_dev "resrv"
> +	if [ $? -eq 0 ]; then
> +		echo "Running sysfs trace with resrv buf mode"
> +		sysfs_trace $src_dev $sink_dev $cpu
> +		# Restore buffer mode
> +		cfg_sink_buf_mode $sink_dev "auto"
> +		if [ $? -eq 1 ]; then
> +			echo "Failed to restore default buf mode"
> +		fi
> +	fi
> +}
> +
> +arm_cs_iterate_devices() {
> +	src_dev=$1
> +	cpu=$3
> +	for cdev in $2/connections/out\:*; do
> +
> +		# Skip testing if it's not a directory
> +		! [ -d $cdev ] && continue;
> +
> +		# Read out its symbol link file name
> +		sink_dev=`readlink -f $cdev`
> +
> +		# Extract device name from path, e.g.
> +		#   sink_dev = '/sys/devices/platform/20010000.etf/tmc_etf0'
> +		#     `> sink_dev_name = 'tmc_etf0'
> +		sink_dev_name=$(basename $sink_dev)
> +
> +		if is_device_sink $sink_dev; then
> +			# Run trace with resrv buf mode (if available)
> +			try_sysfs_trace_resrv_buf $src_dev $sink_dev $cpu
> +
> +			# Run the default mode
> +			echo "Running sysfs trace with default settings"
> +			sysfs_trace $src_dev $sink_dev $cpu
> +		fi
> +
> +		arm_cs_iterate_devices $src_dev $cdev $cpu
> +
> +	done
> +}
> +
> +arm_cs_etm_traverse_path_test() {
> +	# Iterate for every ETM device
> +	for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
> +		# Canonicalize the path
> +		dev=`readlink -f $dev`
> +
> +		# Find the ETM device belonging to which CPU
> +		cpu=`cat $dev/cpu`
> +
> +		# Use depth-first search (DFS) to iterate outputs
> +		arm_cs_iterate_devices $dev $dev $cpu
> +	done
> +}
> +
> +arm_cs_etm_traverse_path_test
> +
> +exit $glb_err

thanks,
-- Shuah

