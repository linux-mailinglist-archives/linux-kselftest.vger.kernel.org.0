Return-Path: <linux-kselftest+bounces-2634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BA824107
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAF1F24027
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436921101;
	Thu,  4 Jan 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="X1jTidq8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630421346;
	Thu,  4 Jan 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4046hdjZ030048;
	Thu, 4 Jan 2024 05:52:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=9kG4CWKk779E79cZ9RMjlvgl3FjSChZFyguuXHLEgNI=; b=
	X1jTidq8+GQGpTWbQQNLS8kIRD07jvFPy+UGyq3mQrp1D/bxFr4/qxMEWDPO2Oxe
	W+BLpde3uqM4g1vbE+EK0cvGEnSAQfpa/777pH2pqGne5E1qC/GXMbr3uy5BnsZD
	IJQw5Ol4GVKoMSWW83qIpqW/PfkRF5nNP8ILSEuoELRTO/vmCmrvP4711lSdRaKa
	kdOckkLCcbHdZFaNilyoktcLDPVPzMC6viw3WDRxY8EG8VhmDsNB8+I3vJckfU70
	+54sb4/fTV2XmqArXr0ged++ssY8G3q4o4iRGkipyh2E19x4iTRzGxTC3Ln2wPux
	7WQhh1Ks6tpLU9ouEf/8Hw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vahg2em9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:52:31 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 11:52:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 4 Jan 2024 11:52:28 +0000
Received: from [198.61.65.138] (EDIN4L06LR3.ad.cirrus.com [198.61.65.138])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A7F0E46C;
	Thu,  4 Jan 2024 11:52:28 +0000 (UTC)
Message-ID: <c6a4c016-e889-422c-91aa-91568f6667f4@opensource.cirrus.com>
Date: Thu, 4 Jan 2024 11:52:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Protect string comparisons against NULL
To: David Gow <davidgow@google.com>
CC: <brendan.higgins@linux.dev>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20231220155256.407974-1-rf@opensource.cirrus.com>
 <CABVgOSnoJEZOCdPBVqBKS=sEXeeq_6_+G4PPodY0HWJ3A7yA+A@mail.gmail.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSnoJEZOCdPBVqBKS=sEXeeq_6_+G4PPodY0HWJ3A7yA+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VpCSsqZxXsyHzGHVbLqb4UnDlzyi7u0o
X-Proofpoint-ORIG-GUID: VpCSsqZxXsyHzGHVbLqb4UnDlzyi7u0o
X-Proofpoint-Spam-Reason: safe

On 22/12/23 08:39, David Gow wrote:
> On Wed, 20 Dec 2023 at 23:52, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Add NULL checks to KUNIT_BINARY_STR_ASSERTION() so that it will fail
>> cleanly if either pointer is NULL, instead of causing a NULL pointer
>> dereference in the strcmp().
>>
>> A test failure could be that a string is unexpectedly NULL. This could
>> be trapped by KUNIT_ASSERT_NOT_NULL() but that would terminate the test
>> at that point. It's preferable that the KUNIT_EXPECT_STR*() macros can
>> handle NULL pointers as a failure.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
> 
> I think this is the right thing to do. There's possibly an argument
> that this should succeed if both are NULL, but I prefer it this way.
> 

Maybe an _OR_NULL() variant of the string test macros would be better to
be explicit that NULL is acceptable.

> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David


