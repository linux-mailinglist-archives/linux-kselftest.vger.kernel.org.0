Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE48733FFD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 07:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCRGoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 02:44:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26026 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229805AbhCRGoV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 02:44:21 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I6Yd6T030113;
        Thu, 18 Mar 2021 02:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wuG7LxMh0D9Gw5rYPviUBu3EYRll3uuW72aqZbePPAk=;
 b=ZX87egYQyPWg6yzRsCi5njq9cOBzICoC9ll5qp5GagXevLM1K786fTmCccRjij5Pt788
 00+bM7NE8dnUnbKQbEu5tooeKo+wVoYIvuufl6MRtlMN2rgdi04+1tq/GX2cZiM/5Fj1
 +AmMHqRccwROf7inmTlcM9S9gx3bpPJGZOJz0LwUTVQX/QtsSLRkeI+NsGXj42LK6ulI
 ALxuyHh3iXYk+yv/CWmnGeQCBxce76ewASS64FVI646HZeLogsp+bx5Kw0iFneoH+Yf+
 PGmtkqU19/ru9B2UctLBwP5JI1VF2bOM43djcamu1Ulvk1MKNtHP4M6CTSK4ZqALZL8x FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c0b4a70m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 02:44:16 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12I6Yqpd031271;
        Thu, 18 Mar 2021 02:44:16 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c0b4a6w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 02:44:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12I6gPkH008902;
        Thu, 18 Mar 2021 06:44:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 378n18ac60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 06:44:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12I6i4Yh65601838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 06:44:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B75DDA4053;
        Thu, 18 Mar 2021 06:44:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1464DA404D;
        Thu, 18 Mar 2021 06:44:03 +0000 (GMT)
Received: from [9.85.86.95] (unknown [9.85.86.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Mar 2021 06:44:02 +0000 (GMT)
Subject: Re: [RFC 2/2] selftest/cpuidle: Add support for cpuidle latency
 measurement
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210315114827.46036-1-psampat@linux.ibm.com>
 <20210315114827.46036-3-psampat@linux.ibm.com>
 <CAAYoRsW-E_Rek-c=e3xr8dTNUWud1AkndNaNySCZpt=h1qSf7g@mail.gmail.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <5d001a54-68ca-4cb8-4beb-4e5210f03677@linux.ibm.com>
Date:   Thu, 18 Mar 2021 12:14:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAYoRsW-E_Rek-c=e3xr8dTNUWud1AkndNaNySCZpt=h1qSf7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180050
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Doug,
Thanks for trying these patches out.

On 18/03/21 2:30 am, Doug Smythies wrote:
> Hi Pratik,
>
> It just so happens that I have been trying Artem's version this last
> week, so I tried yours.
>
> On Mon, Mar 15, 2021 at 4:49 AM Pratik Rajesh Sampat
> <psampat@linux.ibm.com> wrote:
> ...
>> To run this test specifically:
>> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests
> While I suppose it should have been obvious, I interpreted
> the "$" sign to mean I could run as a regular user, which I can not.

Ah yes, this does need root privileges, I should have prefixed the command with
sudo in the instructions for better understanding.

>> There are a few optinal arguments too that the script can take
>>          [-h <help>]
>>          [-m <location of the module>]
>>          [-o <location of the output>]
>>          [-v <verbose> (run on all cpus)]
>> Default Output location in: tools/testing/cpuidle/cpuidle.log
> Isn't it:
>
> tools/testing/selftests/cpuidle/cpuidle.log

My bad, It was a typing error. I missed the "selftest" directory while
typing it out.

> ? At least, that is where my file was.
>
> Other notes:
>
> No idle state for CPU 0 ever gets disabled.
> I assume this is because CPU 0 can never be offline,
> so that bit of code (Disable all stop states) doesn't find its state.
> By the way, processor = Intel i5-9600K

I had tried these patches on an IBM POWER 9 processor and disabling CPU0's idle
state works there. However, it does make sense for some processors to treat CPU
0 differently.
Maybe I could write in a case if idle state disabling fails for a CPU then we
just skip it?

> The system is left with all idle states disabled, well not for CPU 0
> as per the above comment. The suggestion is to restore them,
> otherwise my processor hogs 42 watts instead of 2.
>
> My results are highly variable per test.

Question: Do you notice high variability with IPI test, Timer test or both?

I can think of two reasons for high run to run variance:

1. If you observe variance in timer tests, then I believe there could a
mechanism of "C-state pre-wake" on some Intel machines at play here, which can
pre-wake a CPU from an idle state when timers are armed. I'm not sure if the
Intel platform that you're running on does that or not.

Artem had described this behavior to me a while ago and I think his wult page
describes this behavior in more detail:
https://intel.github.io/wult/#c-state-pre-wake

2. I have noticed variability in results when there are kernel book-keeping or
jitter tasks scheduled from time to time on an otherwise idle core.
In the full per-CPU logs at tools/testing/selftests/cpuidle/cpuidle.log can you
spot any obvious outliers per-CPU state?

Also you may want to run the test in verbose mode which runs for all the
threads of each CPU with the following: "sudo ./cpuidle.sh -v". While latency
mostly matters for per-core basis but it still maybe a good idea to see if
that changes anything with the observations.

--
Thanks and regards,
Pratik

> My system is very idle:
> Example (from turbostat at 6 seconds sample rate):
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt RAMWatt
> 0.03    4600    153     28      2.03    1.89
> 0.01    4600    103     29      2.03    1.89
> 0.05    4600    115     29      2.08    1.89
> 0.01    4600    95      28      2.09    1.89
> 0.03    4600    114     28      2.11    1.89
> 0.01    4600    107     29      2.07    1.89
> 0.02    4600    102     29      2.11    1.89
>
> ...
>
> ... Doug

