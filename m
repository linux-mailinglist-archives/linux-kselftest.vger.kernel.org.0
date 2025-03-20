Return-Path: <linux-kselftest+bounces-29498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1404A6A623
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301A816FC27
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2189221D9A;
	Thu, 20 Mar 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BxGBJrtk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E217A31A;
	Thu, 20 Mar 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473259; cv=none; b=swaz7+VwEqPPldh0bxg3ARCfi/en4mBSDw1bPkfnkvBCoBKfm+zp5zM+7Y38VBCFVQHd+3Uu9CroKWFs1kwKoiVtnx64oXSc4VKELpa7UD+Y5nReJeINvKzPA+VEwYvy5RnF0mgO9T10JikfAVVWlNjQsC9FmvEbH5mwDujSB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473259; c=relaxed/simple;
	bh=ObbmHjbc8zZC963JR2zDwtsuXqPwG1o6MCnmRa4zEeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r5+nLW0dfMnjeVoZq9ViysQU5/2bfKM/3h0l2Blk1VZIbqxe2AwUUzqHrd53xtwWI+VZn77Nafre7HWMLY6Kenf3FssRK1QrKPEhw/2j12lEu/gmPWDZYhhAcjiHkCanJsl5N/aFVn3DmI7rOzBqd9HeBsk2ez4AEuBXWSFkh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BxGBJrtk; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K59d8q031203;
	Thu, 20 Mar 2025 07:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=3tLRhB83LvBqQnQvwrt/Ef3YOjAwm3tOEBLod32rvM4=; b=
	BxGBJrtkgP8YYuiB4+Wg7NP5ioeHhSU8EZU7WuQ5x/1OyoIxsrkC+0RI+C6iCZq9
	IQido1gKVEryspyyY63qJ3bSqFo+8J9dr0O5Vr5U+blE3GCFDSl4TeaK2BaNmV64
	jA3vI7+KlbZGFFmw6K7A9XtUdRECz1liZ6DNjMW5lwlNXfjUxH4/1T6AgO2BkQOv
	1wySWpw4nvngZNIhq8jSiI8oDbY8tuzlVdD7GiKhCSEVBZxa1BkZFNoYRoNPx/17
	+ya/OEAbygOxVmtJE47bfzxgxdE33xaj+EdeQZmzKTIvL0ySU4KWzOi0wkElh2pp
	hxc/pqJu340Awj1dpBHcKg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45g9p6s0by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 07:20:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 12:20:36 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 12:20:36 +0000
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0FB9282255A;
	Thu, 20 Mar 2025 12:20:35 +0000 (UTC)
Message-ID: <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
Date: Thu, 20 Mar 2025 12:20:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
To: Nico Pache <npache@redhat.com>, <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC: <simont@opensource.cirrus.com>, <ckeepax@opensource.cirrus.com>,
        <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>,
        <johannes.berg@intel.com>, <sj@kernel.org>
References: <20250319230539.140869-1-npache@redhat.com>
 <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vcz3PEp9 c=1 sm=1 tr=0 ts=67dc0816 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=20KFwNOVAAAA:8 a=2PFKkWWLCDjf3SO0miIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cagRjpx59etYv9AJ4wAhWJHlCdStqxuh
X-Proofpoint-ORIG-GUID: cagRjpx59etYv9AJ4wAhWJHlCdStqxuh
X-Proofpoint-Spam-Reason: safe

On 19/3/25 23:11, Nico Pache wrote:
> On Wed, Mar 19, 2025 at 5:05 PM Nico Pache <npache@redhat.com> wrote:
>>
>> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
>> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
>> depends on clause, and set CONFIG_FW_CS_DSP=y in the kunit tooling.
> 
> A further note here:
> 
> This test is failing and panicing across multiple arches, and
> triggering kasan slats on debug kernels. I think this test needs more
> testing ;P
>

Please supply details of failures or links to bug reports.
"is failing" and "panicing" doesn't tell me enough to fix anything.
Failing how? Panicking how? On what architectures?
I tested it on the architectures I have available, and the kunit um
architecture. Unfortunately not everyone has hardware for every
architecture supported by Linux so we have to trust somewhat that
other architectures don't do anything unexpectedly different from
what we _can_ test it on.

Also, are any of these failures the unterminated string bug that someone
fixed recently?

>>
>> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file download")
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   drivers/firmware/cirrus/Kconfig              | 3 +--
>>   tools/testing/kunit/configs/all_tests.config | 2 ++
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
>> index 0a883091259a..989568ab5712 100644
>> --- a/drivers/firmware/cirrus/Kconfig
>> +++ b/drivers/firmware/cirrus/Kconfig
>> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
>>
>>   config FW_CS_DSP_KUNIT_TEST
>>          tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
>> -       depends on KUNIT && REGMAP
>> +       depends on KUNIT && REGMAP && FW_CS_DSP
>>          default KUNIT_ALL_TESTS
>> -       select FW_CS_DSP
>>          select FW_CS_DSP_KUNIT_TEST_UTILS
>>          help
>>            This builds KUnit tests for cs_dsp.
>> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
>> index b0049be00c70..96c6b4aca87d 100644
>> --- a/tools/testing/kunit/configs/all_tests.config
>> +++ b/tools/testing/kunit/configs/all_tests.config
>> @@ -49,3 +49,5 @@ CONFIG_SOUND=y
>>   CONFIG_SND=y
>>   CONFIG_SND_SOC=y
>>   CONFIG_SND_SOC_TOPOLOGY_BUILD=y
>> +
>> +CONFIG_FW_CS_DSP=y
>> \ No newline at end of file
>> --
>> 2.48.1
>>
> 


