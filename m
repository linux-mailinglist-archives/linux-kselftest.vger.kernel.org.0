Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08985229B89
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgGVPeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 11:34:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28760 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728256AbgGVPeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 11:34:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MF1qNr104578;
        Wed, 22 Jul 2020 11:33:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vs074c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 11:33:29 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06MF1twN104659;
        Wed, 22 Jul 2020 11:33:29 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vs072y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 11:33:28 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MFCuiV022177;
        Wed, 22 Jul 2020 15:33:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 32brq82qvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 15:33:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06MFXOtX23593370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 15:33:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02D32A4054;
        Wed, 22 Jul 2020 15:33:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC2ACA4060;
        Wed, 22 Jul 2020 15:33:21 +0000 (GMT)
Received: from [9.77.192.138] (unknown [9.77.192.138])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 15:33:21 +0000 (GMT)
Subject: Re: [PATCH v3 0/2] Selftest for cpuidle latency measurement
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, npiggin@gmail.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        pratik.r.sampat@gmail.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200721124300.65615-1-psampat@linux.ibm.com>
 <17e884b8-09d8-98a8-3890-bf506d2cdfca@linaro.org>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <ea27fd11-43c3-ac3e-5913-692fdcd483e9@linux.ibm.com>
Date:   Wed, 22 Jul 2020 21:03:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <17e884b8-09d8-98a8-3890-bf506d2cdfca@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_08:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=838 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220104
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Daniel,

On 21/07/20 8:27 pm, Daniel Lezcano wrote:
> On 21/07/2020 14:42, Pratik Rajesh Sampat wrote:
>> v2: https://lkml.org/lkml/2020/7/17/369
>> Changelog v2-->v3
>> Based on comments from Gautham R. Shenoy adding the following in the
>> selftest,
>> 1. Grepping modules to determine if already loaded
>> 2. Wrapper to enable/disable states
>> 3. Preventing any operation/test on offlined CPUs
>> ---
>>
>> The patch series introduces a mechanism to measure wakeup latency for
>> IPI and timer based interrupts
>> The motivation behind this series is to find significant deviations
>> behind advertised latency and resisdency values
> Why do you want to measure for the timer and the IPI ? Whatever the
> source of the wakeup, the exit latency remains the same, no ?
>
> Is all this kernel-ish code really needed ?
>
> What about using a highres periodic timer and make it expires every eg.
> 50ms x 2400, so it is 120 secondes and measure the deviation. Repeat the
> operation for each idle states.
>
> And in order to make it as much accurate as possible, set the program
> affinity on a CPU and isolate this one by preventing other processes to
> be scheduled on and migrate the interrupts on the other CPUs.
>
> That will be all userspace code, no?
>
>
The kernel module may not needed now that you mention it.
IPI latencies could be measured using pipes and threads using
pthread_attr_setaffinity_np to control the experiment, as you
suggested. This should internally fire a smp_call_function_single.

The original idea was to essentially measure it as closely as possible
in the kernel without involving the kernel-->userspace overhead.
However, the user-space approach may not be too much of a problem as
we are collecting a baseline and the delta of the latency is what we
would be concerned about anyways!

With respect to measuring both timers and IPI latencies: In principle
yes, the exit latency should remain the same but if there is a
deviation in reality we may want to measure it.

I'll implement this experiment in the userspace and get back with the
numbers to confirm.

Thanks for your comments!
Best,
Pratik

>
>

