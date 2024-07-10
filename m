Return-Path: <linux-kselftest+bounces-13445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C455792CC7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E871C2283C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC337EF09;
	Wed, 10 Jul 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H2eKVdlA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183B8615A;
	Wed, 10 Jul 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598766; cv=none; b=Gvzf6ZqKsLfHJQJnCFRy0tifeSMRKZBqtV9absS5TBYc+Y0gRa+tP4bcTfCqukWgPU1c3uC3/TWkgsspDSUscBUNCvf8tjEae8YbWvO8LdZp18l1CbakIjM8Q45sWK/ZIw0L26N6hzdjaShvyEXlBWPgqy1xRwouzSjo38BGFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598766; c=relaxed/simple;
	bh=IrY+szMv6r3qp86jQb0TltgeA0YlhoI7y8wRxi4ku58=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gVAoecjryYoplrZsapxzeBQPj+gmvOVE55PyhlSdWhzR1x+gujjlxwMaM9JDtf4FCA2MHdYNG1Pn06rp7To9+NMPltwPdDEwRUNzZ3VAenUGlQTnwTQSjz0NcXr7SCu6+ijWo9YFbkvlJQ7JgogXfSfbdtgDHsTBzFfhBdQ3jSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H2eKVdlA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720598328;
	bh=IrY+szMv6r3qp86jQb0TltgeA0YlhoI7y8wRxi4ku58=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=H2eKVdlA17V/UI0H6Gv+u/6BH/pp28omb9H6NZneq0KvPWYq5OxqllXeOy+UoeF1M
	 mW7VTYozKi2ifEw3V7O+msiwvReawVWwGFCepD9EOaGIR/ToR2o2AiA5qv282t4KVB
	 DXkztkcozzWuxN/QawIe+c0l0qkkEbe2h0MklelafMHQLtpNH+H47qxQy6NFFy5GVq
	 qxmi8KJciddOlEOD6tStR0UwhJNNKErVfThHWewkj+fAVxow/nXutRBfxMC5fuH2ZE
	 ERrzzulxJq3pPB0/h9fyf/oBmC10bnwIqfCwlifj9wKBo3ivTN8IGW7IqEkoSFIS6N
	 qCx6n+UYODnOQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 28D603782109;
	Wed, 10 Jul 2024 07:58:45 +0000 (UTC)
Message-ID: <b0402960-6719-4c36-9f39-d799e2a285b5@collabora.com>
Date: Wed, 10 Jul 2024 12:58:43 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tpm2: conform test to TAP output
To: Shuah Khan <skhan@linuxfoundation.org>,
 Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20240702065559.772855-1-usama.anjum@collabora.com>
 <6940383d-68cb-4966-a587-9fa0cc56545e@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6940383d-68cb-4966-a587-9fa0cc56545e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 7/10/24 4:36 AM, Shuah Khan wrote:
> On 7/2/24 00:55, Muhammad Usama Anjum wrote:
>> The python unittest is being used for executing tests. TAP output
>> cannot be added in the unittest framework. The python unittest is being
>> run from a script. Add the output TAP logs to the script. Add "#"
>> prefix to the python unittest output which will mark all output as
>> informational TAP messages. Check exit status of the python unittest to
>> decide if test passed or failed. Not sure why but python unittest
>> outputs logs in stderr. So redirect the logs to stdout and then add
>> prefix.
>>
>> Specify the bash explicitly instead of sh to run these tests as all of
>> the kselftests are shifting towards using bash explicitly. Some
>> interpreters have different syntax and cause issues.
>>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - CC more people which were missing earlier
>> ---
>>   tools/testing/selftests/tpm2/test_async.sh | 24 ++++++++++++++++------
>>   tools/testing/selftests/tpm2/test_smoke.sh | 19 ++++++++++++++---
>>   tools/testing/selftests/tpm2/test_space.sh | 19 ++++++++++++++---
>>   3 files changed, 50 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/tpm2/test_async.sh
>> b/tools/testing/selftests/tpm2/test_async.sh
>> index 43bf5bd772fd4..0e6e5d9d649fb 100755
>> --- a/tools/testing/selftests/tpm2/test_async.sh
>> +++ b/tools/testing/selftests/tpm2/test_async.sh
>> @@ -1,10 +1,22 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>   -# Kselftest framework requirement - SKIP code is 4.
>> -ksft_skip=4
>> +DIR="$(dirname $(readlink -f "$0"))"
>> +source "${DIR}"/../kselftest/ktap_helpers.sh
>>   -[ -e /dev/tpm0 ] || exit $ksft_skip
>> -[ -e /dev/tpmrm0 ] || exit $ksft_skip
>> +ktap_print_header
>>   -python3 -m unittest -v tpm2_tests.AsyncTest
>> +[ -e /dev/tpm0 ] || ktap_finished
>> +[ -e /dev/tpmrm0 ] || ktap_finished
>> +
>> +ktap_set_plan 1
>> +
>> +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1 | sed "s/^/# /"
>> +
>> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
>> +    ktap_test_pass "tpm2_tests.AsyncTest"
>> +else
>> +    ktap_test_fail "tpm2_tests.AsyncTest"
>> +fi
>> +
>> +ktap_finished
>> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh
>> b/tools/testing/selftests/tpm2/test_smoke.sh
>> index 58af963e5b55a..2219a180de91d 100755
>> --- a/tools/testing/selftests/tpm2/test_smoke.sh
>> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
>> @@ -1,9 +1,22 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>     # Kselftest framework requirement - SKIP code is 4.
>> -ksft_skip=4
>> +DIR="$(dirname $(readlink -f "$0"))"
>> +source "${DIR}"/../kselftest/ktap_helpers.sh
>> +
>> +ktap_print_header
>>     [ -e /dev/tpm0 ] || exit $ksft_skip
>>   -python3 -m unittest -v tpm2_tests.SmokeTest
>> +ktap_set_plan 1
>> +
>> +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1 | sed "s/^/# /"
>> +
>> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
>> +    ktap_test_pass "tpm2_tests.AsyncTest"
>> +else
>> +    ktap_test_fail "tpm2_tests.AsyncTest"
>> +fi
>> +
>> +ktap_finished
>> diff --git a/tools/testing/selftests/tpm2/test_space.sh
>> b/tools/testing/selftests/tpm2/test_space.sh
>> index 04c47b13fe8ac..6a55d13d74983 100755
>> --- a/tools/testing/selftests/tpm2/test_space.sh
>> +++ b/tools/testing/selftests/tpm2/test_space.sh
>> @@ -1,9 +1,22 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>     # Kselftest framework requirement - SKIP code is 4.
>> -ksft_skip=4
>> +DIR="$(dirname $(readlink -f "$0"))"
>> +source "${DIR}"/../kselftest/ktap_helpers.sh
>> +
>> +ktap_print_header
>>     [ -e /dev/tpmrm0 ] || exit $ksft_skip
>>   -python3 -m unittest -v tpm2_tests.SpaceTest
>> +ktap_set_plan 1
>> +
>> +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1 | sed "s/^/# /"
>> +
>> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
>> +    ktap_test_pass "tpm2_tests.AsyncTest"
>> +else
>> +    ktap_test_fail "tpm2_tests.AsyncTest"
>> +fi
>> +
>> +ktap_finished
> 
> Usama,
> 
> As I mentioned another TAP conversion patch from you  patch if the
> following command gives you TAP, there is  no need to convert.
> 
> make -C tools/testing/tmp2 run_tests
> make kselftest TARGETS=tmp2
> 
> kselftest framework lib.mk and runtests wrappers take care for
> TAP. The reason to take care of this at framework level is to
> avoid changes to individual tests. The wrapper keys off of
> KSFT_* codes returned from tests.
> 
> Please don't send TAP conversion patches like this one. The output
> from the commands will have duplicate messages. The reason tests
> return
> 
> make -C tools/testing/tmp2 run_tests
> make kselftest TARGETS=tmp2
It is understandable. Thank you for clearing this about TAP conformance.
I've been looking at individual test conformance.

This patch has some fixes. I'll send them as new patch series after
removing TAP conformance changes.

> 
> thanks,
> -- Shuah
> 
> 
> 
> 

-- 
BR,
Muhammad Usama Anjum

