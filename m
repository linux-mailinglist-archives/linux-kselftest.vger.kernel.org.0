Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C6825C49B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgICPNI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 11:13:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18844 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbgICMDK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 08:03:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083BYxRM180240;
        Thu, 3 Sep 2020 08:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RwwxTYzL444FMU+fHZcE8N87UoE2Q8WJIZikb7QZa3I=;
 b=dTa3ylzR3BGFnO0m4dOSwyzg+q4xQgTsYm2q0vzicbi1+UOKUaYnEimQleTvLKt28hTR
 hJS96hjQvanU6/BndcA11lm9KkfB0ok8ZKaap0/CFqASfi7AlAA9ldltSUeF5NBFWXsY
 uZTxXyjQoCOkY2ssQGKFMx++koaytSIBC7ojfJZaVjordMCrbqA/YwH3O13ROQwFsp3U
 Nasj6dQB8kp2kaS3j6MmyGHqbiEQHUrZ9VGrSuRgnpUSRPj7rI/7s2IdRUKCCHJjzfz+
 ng0LHlca+pr7wHIFPH5pWuYbXHgI9q9tk/XAwv9C6+1HbopNdfyPn5oGz5gsPkGZXCOo tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ay8ehgev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 08:00:16 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 083BaRVf184429;
        Thu, 3 Sep 2020 08:00:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ay8ehgdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 08:00:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083Bwq4M009411;
        Thu, 3 Sep 2020 12:00:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gwtr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 12:00:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 083Bwddp41746860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Sep 2020 11:58:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0500E11C0AF;
        Thu,  3 Sep 2020 12:00:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BB7111C0A1;
        Thu,  3 Sep 2020 12:00:08 +0000 (GMT)
Received: from [9.79.210.158] (unknown [9.79.210.158])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Sep 2020 12:00:07 +0000 (GMT)
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
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <fa616fed-66be-bcad-83b8-b1173a3a444f@linux.ibm.com>
Date:   Thu, 3 Sep 2020 17:30:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b59481655c29d081eea4f34c00166517738000e5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_05:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=907 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030102
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Artem,

On 02/09/20 8:55 pm, Artem Bityutskiy wrote:
> On Wed, 2020-09-02 at 17:15 +0530, Pratik Rajesh Sampat wrote:
>> Measure cpuidle latencies on wakeup to determine and compare with the
>> advertsied wakeup latencies for each idle state.

Thank you for pointing me to your talk. It was very interesting!
I certainly did not know about that the Intel architecture being aware
of timers and pre-wakes the CPUs which makes the timer experiment
observations void.

> It looks like the measurements include more than just C-state wake,
> they also include the overhead of waking up the proces, context switch,
> and potentially any interrupts that happen on that CPU. I am not saying
> this is not interesting data, it surely is, but it is going to be
> larger than you see in cpuidle latency tables. Potentially
> significantly larger.

The measurements will definitely include overhead than just the C-State
wakeup.

However, we are also collecting a baseline measurement wherein we run
the same test on a 100% busy CPU and the measurement of latency from
that could be considered to the kernel-userspace overhead.
The rest of the measurements would be considered keeping this baseline
in mind.

> Therefore, I am not sure this program should be advertised as "cpuidle
> measurement". It really measures the "IPI latency" in case of the IPI
> method.

Now with the new found knowledge of timers in Intel, I understand that
this really only seems to measure IPI latency and not timer latency,
although both the observations shouldn't be too far off anyways.

>> A baseline measurement for each case of IPI and timers is taken at
>> 100 percent CPU usage to quantify for the kernel-userpsace overhead
>> during execution.
> At least on Intel platforms, this will mean that the IPI method won't
> cover deep C-states like, say, PC6, because one CPU is busy. Again, not
> saying this is not interesting, just pointing out the limitation.

That's a valid point. We have similar deep idle states in POWER too.
The idea here is that this test should be run on an already idle
system, of course there will be kernel jitters along the way
which can cause little skewness in observations across some CPUs but I
believe the observations overall should be stable.

Another solution to this could be using isolcpus, but that just
increases the complexity all the more.
If you have any suggestions of any other way that could guarantee
idleness that would be great.

>
> I was working on a somewhat similar stuff for x86 platforms, and I am
> almost ready to publish that on github. I can notify you when I do so
> if you are interested. But here is a small presentation of the approach
> that I did on Plumbers last year:
>
> https://youtu.be/Opk92aQyvt0?t=8266
>
> (the link points to the start of my talk)
>
Sure thing. Do notify me when it comes up.
I would be happy to have a look at it.

--
Thanks!
Pratik

