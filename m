Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8B2684DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 08:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgINGba (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 02:31:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgINGb1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 02:31:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08E62HqJ063631;
        Mon, 14 Sep 2020 02:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+f3ZSgcjocPx6bP9sBMNDfuiyXz+zw9QTYzFYdxpOdY=;
 b=V+OVesyPrqeQPahOc9UwGccNoTot3LK1Uz1hQXajDjnU2Di7vpNQ5dv1MRyAlexiib0c
 2w2pC0hpu6z1WYVsTZHRYasd9vMP1UeN/jQM5UBmSe+gzGHUY8eYYIp5oHaSQVWIOniL
 d6+Q8GW/BnKtZ5S+PPXqGL+rg3dQ7gyu1BwtOOcgMTvjD4qUGvX+e9c11kvbVi1hOaNn
 c2NbaKauhndjChrK2/urwnMasrYaW96XRApJYjGLW65O2u3eVTlpEw0dMmLF1xnpPH4L
 y/FOGg/UhhwqAzsq+9ahyUZQl8sSG24gNXL7JTAUbE8CxUPfcTJ66FG0SO4kYRC4V48W aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33hwys6tha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 02:31:17 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08E62W4b064885;
        Mon, 14 Sep 2020 02:31:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33hwys6tge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 02:31:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E6NHxH012794;
        Mon, 14 Sep 2020 06:31:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 33h2r99d6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 06:31:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08E6VCns14811454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 06:31:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 773C3AE045;
        Mon, 14 Sep 2020 06:31:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93E1EAE057;
        Mon, 14 Sep 2020 06:31:10 +0000 (GMT)
Received: from [9.79.217.60] (unknown [9.79.217.60])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Sep 2020 06:31:10 +0000 (GMT)
Subject: Re: [RFC v4 1/1] selftests/cpuidle: Add support for cpuidle latency
 measurement
To:     dedekind1@gmail.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, npiggin@gmail.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20200902114506.45809-1-psampat@linux.ibm.com>
 <20200902114506.45809-2-psampat@linux.ibm.com>
 <b59481655c29d081eea4f34c00166517738000e5.camel@gmail.com>
 <fa616fed-66be-bcad-83b8-b1173a3a444f@linux.ibm.com>
 <9c5156274a86573ad592e6e431f3cbee8135b736.camel@gmail.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <607abe47-6155-d956-d373-b498cc1d26e8@linux.ibm.com>
Date:   Mon, 14 Sep 2020 12:01:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9c5156274a86573ad592e6e431f3cbee8135b736.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_09:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140051
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 03/09/20 8:20 pm, Artem Bityutskiy wrote:
> On Thu, 2020-09-03 at 17:30 +0530, Pratik Sampat wrote:
>> I certainly did not know about that the Intel architecture being aware
>> of timers and pre-wakes the CPUs which makes the timer experiment
>> observations void.
> Well, things depend on platform, it is really "void", it is just
> different and it measures an optimized case. The result may be smaller
> observed latency. And things depend on the platform.

Of course, this will be for just software observability and hardware
can be more complex with each architecture behaving differently.

>> However, we are also collecting a baseline measurement wherein we run
>> the same test on a 100% busy CPU and the measurement of latency from
>> that could be considered to the kernel-userspace overhead.
>> The rest of the measurements would be considered keeping this baseline
>> in mind.
> Yes, this should give the idea of the overhead, but still, at least for
> many Intel platforms I would not be comfortable using the resulting
> number (measured latency - baseline) for a cpuidle driver, because
> there are just too many variables there. I am not sure I could assume
> the baseline measured this way is an invariant - it could be noticeably
> different depending on whether you use C-states or not.
>
>>> At least on Intel platforms, this will mean that the IPI method won't
>>> cover deep C-states like, say, PC6, because one CPU is busy. Again, not
>>> saying this is not interesting, just pointing out the limitation.
>> That's a valid point. We have similar deep idle states in POWER too.
>> The idea here is that this test should be run on an already idle
>> system, of course there will be kernel jitters along the way
>> which can cause little skewness in observations across some CPUs but I
>> believe the observations overall should be stable.
> If baseline and cpuidle latency are numbers of same order of magnitude,
> and you are measuring in a controlled lab system, may be yes. But if
> baseline is, say, in milliseconds, and you are measuring a 10
> microseconds C-state, then probably no.

This makes complete sense. The magnitude of deviations being greater
than the scope of the experiment may not be very useful in quantifying
the latency metric.

One way is to minimize the baseline overhead is to make this a kernel
module https://lkml.org/lkml/2020/7/21/567. However, the overhead is
unavoidable but definetly can be further minimized by using an external
approach suggested by you in your LPC talk

>> Another solution to this could be using isolcpus, but that just
>> increases the complexity all the more.
>> If you have any suggestions of any other way that could guarantee
>> idleness that would be great.
> Well, I did not try to guarantee idleness. I just use timers and
> external device (the network card), so no CPUs needs to be busy and the
> system can enter deep C-states. Then I just look at median, 99%-th
> percentile, etc.
>
> But by all means IPI is also a very interesting experiment. Just covers
> a different usage scenario.
>
> When I started experimenting in this area, one of my main early
> takeaways was realization that C-state latency really depends on the
> event source.

That is an interesting observation, on POWER systems where we don't
have timer related wakeup optimizations, the readings from this test do
signify a difference between latencies of IPI versus the latency
gathered after a timer interrupt.

However, these timer based variations weren't as prominent on my Intel
based ThinkPad t480, therefore in confirmation with your observations.

This discussions does help!
Although this approach may not help quantify latency deviations at a
hardware-accurate level but could still be helpful in quantifying this
metric from a software observability point of view.


Thanks!
Pratik

