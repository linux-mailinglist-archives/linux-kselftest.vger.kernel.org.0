Return-Path: <linux-kselftest+bounces-22823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D19E38A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116281615B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A03B1AF0A4;
	Wed,  4 Dec 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgX3UcCq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264F1B21A6
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311093; cv=none; b=RIpV6QB+5e604DjrgKPGVMa3B50cx1NerqFztdhfGIoXg1S5rZTVshNORKhRkFgd2aPrwmZGUK52MOSxeXgypErgR914L9PzOTSgTysjbMLyTz3iuWEtPQCVOASMnMU8nEogoGrEdCzIPeHoYlVlwmwIZtDIDI4OUj7nuPkYafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311093; c=relaxed/simple;
	bh=TGtkDKKCNTT/Q1Hhg0MUyKvvt8Pn/X6xaH586tX/pmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNxWbzOEn+cwxbGJ5B2PvejAZBXM+vkgujNkHlfYGJ/pqshn5fjBjVen8v/pduHtmm7IX6L/sIwzAFYO+aw/dTLkmGeGmBPCcktR4Z5dh6R2lv7WLKzdsFAcuCGin76xzfH5JioUItWCiKhS4j4NNYQjKr3knh9mShVXFcWlnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CgX3UcCq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4549063f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 03:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733311090; x=1733915890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grMcytodYJK+yAAtJTqT9EcYuraadbQypdSGHtPZYzg=;
        b=CgX3UcCqJUx+ivF+wJTw7ypxjSYku7++uvSYiH9WaP+GllvqAGmL2XoOHpyOfhLyGr
         gv7SCBwG3V/jVGe+AlY7eG+wexU/Qe54cQ2JQe4iLt7sFYw5J4EyhPQSc8xx6u+hfVhj
         R71ptwIJbP6cG1Pg2puGeUDDkWtti8Q9jcY2w8SM8GPbWXSjG3vkazerHR/bj6dFE9p6
         VqmQ5g2FeME1e5F9kRtzyAnWBp5dTQM9BCl82CfmC+ubFzFWpt69GMceRWb43yzh73re
         /XVxvV1QDIuqrTkP/v7eFzxj/C9/nwIAcaeLYpBaz+LDZWAIoU1j2V1JWXEFAeOUayzW
         nK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733311090; x=1733915890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grMcytodYJK+yAAtJTqT9EcYuraadbQypdSGHtPZYzg=;
        b=J4H/zJ+UGPudx/5DJyxvKGNxCluA5Z0TY6ZCbKsBnr0ZHgJ2TgaLMQA854idUrEHNp
         Fo5NBUKMQSQMot1ygB1Y6AAXmZnZ543DcT2RTKnNRQNygFCCwuoiooTiCu3fUfXdyoO2
         gPYxwaGozd/YiwWJC8tkl7i7fbHk+C066zjC7o6kE0R7AsxGs/zYknu6QxW8IJrMXXxF
         mSR+GnhlBcA7ZibUCXX5D7Q5onldApAgG+ADfJaGG1EQlAGoNJ3UfWjyDKKZCPp+k+X+
         yYlRrN79mljerzjVAnWVrngQEfTum7JLyK45m+BYoh73V6X3rBTFm+tzPoaiLG7RSHo5
         8Kyw==
X-Forwarded-Encrypted: i=1; AJvYcCUkfqw/xMUsn5pOCedv4ufUa9gv+YngsltQ1fr50XCQEbZqivMX3I7R+6U3M6S0eGnRbwduDmF7kTXYY25aMXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCmODq48+Y6eQFNUybXeSSmEM3sVdFlkOQ+ycxiS5PLaKPuXk
	LwpHr6hyTkcbs0WlDB+/tIdCmO08tC5WezcK9/FTW7jPlvrXgq1suMNKQNZD7PY=
X-Gm-Gg: ASbGncukV9xTMwIxJv6uCiycnDRUVMyLutAz1gj8D22u7vrEUYVKHjPyoIkfNkkixBZ
	IQ7ksf6rhJSv/xqVOb05GKIIP3N3NbDpXM1CgPR05Ik7ujEmtlN67VjVgmpwKw3pM0vzr3cmt93
	mE3Npaji20UIZrpoYwzuOxzxpF/cykd2Fbscj9+WDtX8nxrIDxKBlZDFhSeUI54a6/kL8VgB7tz
	9CmBcmjaz0OVMZr5gjTnscz0Zd4aK770JHnpxvXQ/ck4+n5cOMoyGj7Oam6aw==
X-Google-Smtp-Source: AGHT+IEboZtlYwyDwWy2/nz4tPekz9TBu2kwWpNNoUvNEhX86KgTe/gaLtaugdikQPzy6OgU/p9TaA==
X-Received: by 2002:a5d:64e4:0:b0:385:f47b:1508 with SMTP id ffacd0b85a97d-385fd3f35efmr5902451f8f.35.1733311089628;
        Wed, 04 Dec 2024 03:18:09 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e9c075e8sm11523453f8f.7.2024.12.04.03.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:18:09 -0800 (PST)
Message-ID: <91bb1592-4311-4afe-a728-fc9000b04aca@linaro.org>
Date: Wed, 4 Dec 2024 11:18:07 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: arm coresight: sysfsmode testing
To: Shuah Khan <skhan@linuxfoundation.org>,
 Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@arm.com>
References: <20241129083813.3056909-1-lcherian@marvell.com>
 <115bb206-8401-4475-977d-7dd98a2b872c@linuxfoundation.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <115bb206-8401-4475-977d-7dd98a2b872c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/12/2024 12:23 am, Shuah Khan wrote:
> On 11/29/24 01:38, Linu Cherian wrote:
>> Add sysfs mode selftest for ARM Coresight hardware tracer.
> 
> Please add details on what this test does in here. Include
> the output from the test?
> 
> Does this test have dependencies on config? If it does, does
> this test detect and skip if config isn't enabled?
> 

Without the config the test won't find any devices and it will still 
pass. But yes it would still be good to explicitly mark the dependency.

>>
>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>> ---
>>   .../drivers/hwtracing/coresight/Makefile      |   5 +
>>   .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
>>   2 files changed, 149 insertions(+)
>>   create mode 100644 tools/testing/selftests/drivers/hwtracing/ 
>> coresight/Makefile
>>   create mode 100755 tools/testing/selftests/drivers/hwtracing/ 
>> coresight/sysfs_test_trace.sh
>>
>> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/ 
>> Makefile b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
>> new file mode 100644
>> index 000000000000..7dc68ae1c0a9
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +TEST_PROGS = sysfs_test_trace.sh
>> +
>> +include ../../../lib.mk
>> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/ 
>> sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/ 
>> coresight/sysfs_test_trace.sh
>> new file mode 100755
>> index 000000000000..0d6307fff1d2
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/ 
>> sysfs_test_trace.sh
>> @@ -0,0 +1,144 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 Marvell.
>> +
>> +# Test Arm CoreSight trace capture in sysfs mode
>> +# Based on tools/perf/tests/shell/test_arm_coresight.sh
>> +
>> +glb_err=0
>> +
>> +arm_cs_report() {
>> +    if [ $2 != 0 ]; then
>> +        echo "$1: FAIL"
>> +        glb_err=$2
>> +    else
>> +        echo "$1: PASS"
>> +    fi
>> +}
>> +
>> +is_device_sink() {
>> +    # If the node of "enable_sink" is existed under the device path, 
>> this
>> +    # means the device is a sink device.
>> +
>> +    if [ -e "$1/enable_sink" ]; then
>> +
>> +        return 0
>> +    else
>> +        return 1
>> +    fi
>> +}
>> +
>> +# Configure sink for buffer mode
>> +cfg_sink_buf_mode() {
>> +    sink_dev=$1
>> +    mode=$2
>> +    # Set buffer mode if supported
>> +    if [ -e "$sink_dev/buf_modes_available" ]; then
>> +        cat $sink_dev/buf_modes_available | grep -E -q $mode
>> +        if [ $? -eq 0 ]; then
>> +            echo $mode > $sink_dev/buf_mode_preferred
>> +            return 0
>> +        fi
>> +    fi
>> +
>> +    return 1
>> +}
>> +
>> +run_app() {
>> +
>> +    taskset -c $1 dd if=/dev/urandom  of=/dev/null bs=1M count=64
>> +}
>> +
>> +sysfs_trace() {
>> +    src_dev=$1
>> +    sink_dev=$2
>> +    cpu=$3
>> +
>> +    # Enable sink device
>> +    echo 1 > $sink_dev/enable_sink
>> +    # Enable source device
>> +    echo 1 > $src_dev/enable_source
>> +
>> +    # Run app to be traced
>> +    run_app $cpu
>> +
>> +    # Read back trace data
>> +    dd if=/dev/$sink_dev_name of=/tmp/tracedata
>> +
>> +    # Verify if read is successful
>> +    err=$?
>> +
>> +    # Disable source device
>> +    echo 0 > $src_dev/enable_source
>> +
>> +    # Diskable sink device
>> +    echo 0 > $sink_dev/enable_sink
>> +
>> +    arm_cs_report "CoreSight path testing (CPU$cpu -> 
>> $sink_dev_name)" $err
>> +}
>> +
>> +try_sysfs_trace_resrv_buf() {
>> +    src_dev=$1
>> +    sink_dev=$2
>> +    cpu=$3
>> +
>> +    # Configure the resrved buffer mode if available
>> +    cfg_sink_buf_mode $sink_dev "resrv"
>> +    if [ $? -eq 0 ]; then
>> +        echo "Running sysfs trace with resrv buf mode"
>> +        sysfs_trace $src_dev $sink_dev $cpu
>> +        # Restore buffer mode
>> +        cfg_sink_buf_mode $sink_dev "auto"
>> +        if [ $? -eq 1 ]; then
>> +            echo "Failed to restore default buf mode"
>> +        fi
>> +    fi
>> +}
>> +
>> +arm_cs_iterate_devices() {
>> +    src_dev=$1
>> +    cpu=$3
>> +    for cdev in $2/connections/out\:*; do
>> +
>> +        # Skip testing if it's not a directory
>> +        ! [ -d $cdev ] && continue;
>> +
>> +        # Read out its symbol link file name
>> +        sink_dev=`readlink -f $cdev`
>> +
>> +        # Extract device name from path, e.g.
>> +        #   sink_dev = '/sys/devices/platform/20010000.etf/tmc_etf0'
>> +        #     `> sink_dev_name = 'tmc_etf0'
>> +        sink_dev_name=$(basename $sink_dev)
>> +
>> +        if is_device_sink $sink_dev; then
>> +            # Run trace with resrv buf mode (if available)
>> +            try_sysfs_trace_resrv_buf $src_dev $sink_dev $cpu
>> +
>> +            # Run the default mode
>> +            echo "Running sysfs trace with default settings"
>> +            sysfs_trace $src_dev $sink_dev $cpu
>> +        fi
>> +
>> +        arm_cs_iterate_devices $src_dev $cdev $cpu
>> +
>> +    done
>> +}
>> +
>> +arm_cs_etm_traverse_path_test() {
>> +    # Iterate for every ETM device
>> +    for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
>> +        # Canonicalize the path
>> +        dev=`readlink -f $dev`
>> +
>> +        # Find the ETM device belonging to which CPU
>> +        cpu=`cat $dev/cpu`
>> +
>> +        # Use depth-first search (DFS) to iterate outputs
>> +        arm_cs_iterate_devices $dev $dev $cpu
>> +    done
>> +}
>> +
>> +arm_cs_etm_traverse_path_test
>> +
>> +exit $glb_err
> 
> thanks,
> -- Shuah
> 


