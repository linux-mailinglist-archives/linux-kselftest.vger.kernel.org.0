Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113FC2692BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgINRNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 13:13:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgINRNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 13:13:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EH41Ox015270;
        Mon, 14 Sep 2020 13:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=/1vfwABSnmtOZ4CtBNzW+dx7wqU5W4NhKkEHRm7FVhk=;
 b=jtDYDlloAGl78nnKrvd8o5kHB5jZEq9r/ImbctiqGDLvJUabksCUzlvqDR2M4hnE5zQa
 E84LGVGKIbr1T8OlBT7paAdmdmHM8FMs64vEUJJNxDTafDa/jbK/aY4Y3tXMU8elR4W7
 eMg9KUYUdML34opsEStl/o6Uzb2EtwRBmSkPlu+CmBI28P9eqcDx1UDYTzUomrvx8aWK
 5MSTAAyXGUEbW1s5WNx6/LM6R08dgZ9Qbnord1vjo3A2VJR9+O35iZi48Z8m6+kTbjvd
 ViNsb8nHbVXH9O8NhzUjSGIg8JsnYbT7DrL/34D1rYnYesOjBUvQNdMAEVgWDHXJPxlN lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ja70d3p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 13:13:07 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08EH4YpH017398;
        Mon, 14 Sep 2020 13:13:06 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ja70d3nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 13:13:06 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EHCVuV032226;
        Mon, 14 Sep 2020 17:13:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 33gny95qjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 17:13:05 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08EHD0tg33292616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 17:13:01 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F2596A051;
        Mon, 14 Sep 2020 17:13:04 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDF126A04F;
        Mon, 14 Sep 2020 17:13:03 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.73.235])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Sep 2020 17:13:03 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 163712E3885; Mon, 14 Sep 2020 22:43:00 +0530 (IST)
Date:   Mon, 14 Sep 2020 22:43:00 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, npiggin@gmail.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
Subject: Re: [RFC v4 0/1] Selftest for cpuidle latency measurement
Message-ID: <20200914171259.GA25628@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200902114506.45809-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902114506.45809-1-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_06:2020-09-14,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140133
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 02, 2020 at 05:15:05PM +0530, Pratik Rajesh Sampat wrote:
> Changelog v3-->v4:
> 1. Overhaul in implementation from kernel module to a userspace selftest 
> ---
> 
> The patch series introduces a mechanism to measure wakeup latency for
> IPI and timer based interrupts
> The motivation behind this series is to find significant deviations
> behind advertised latency and residency values
> 
> To achieve this in the userspace, IPI latencies are calculated by
> sending information through pipes and inducing a wakeup, similarly
> alarm events are setup for calculate timer based wakeup latencies.

> 
> To account for delays from kernel-userspace interactions baseline
> observations are taken on a 100% busy CPU and subsequent obervations
> must be considered relative to that.
> 
> In theory, wakeups induced by IPI and Timers should have similar
> wakeup latencies, however in practice there may be deviations which may
> need to be captured.
> 
> One downside of the userspace approach in contrast to the kernel
> implementation is that the run to run variance can turn out to be high
> in the order of ms; which is the scope of the experiments at times.
> 
> Another downside of the userspace approach is that it takes much longer
> to run and hence a command-line option quick and full are added to make
> sure quick 1 CPU tests can be carried out when needed and otherwise it
> can carry out a full system comprehensive test.
> 
> Usage
> ---
> ./cpuidle --mode <full / quick / num_cpus> --output <output location> 
> full: runs on all CPUS
> quick: run on a random CPU
> num_cpus: Limit the number of CPUS to run on
> 
> Sample output snippet
> ---------------------
> --IPI Latency Test---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> ...
>   0          5       256178
>   0          6       478161
>   0          7       285445
>   0          8       273553
> Expected IPI latency(ns): 100000
> Observed Average IPI latency(ns): 248334

I suppose by run-to-run variance you are referring to the outliers in
the above sequence (like 478161) ? Or is it that each time you run
your test program you observe completely different series of values ?

If it is the former, then perhaps we could discard the outliers for
the purpose of average latency computation and print the max, min and
the corrected-average values above.



> 
> --Timeout Latency Test--
> --Baseline Timeout Latency measurement: CPU Busy--
> Wakeup_src Baseline_delay(ns)
> ...
>  32          972405
>  33         1004287
>  34          986663
>  35          994022
> Expected timeout(ns): 10000000
> Observed Average timeout diff(ns): 991844
>

It would be good to see a complete sample output, perhaps for the
--mode=10 so that it is easy to discern if there are cases when the
observed timeouts/IPI latencies for the busy case are larger than the
idle-case.



> Pratik Rajesh Sampat (1):
>   selftests/cpuidle: Add support for cpuidle latency measurement
> 
>  tools/testing/selftests/Makefile          |   1 +
>  tools/testing/selftests/cpuidle/Makefile  |   7 +
>  tools/testing/selftests/cpuidle/cpuidle.c | 616 ++++++++++++++++++++++
>  tools/testing/selftests/cpuidle/settings  |   1 +
>  4 files changed, 625 insertions(+)
>  create mode 100644 tools/testing/selftests/cpuidle/Makefile
>  create mode 100644 tools/testing/selftests/cpuidle/cpuidle.c
>  create mode 100644 tools/testing/selftests/cpuidle/settings
> 
> -- 
> 2.26.2
> 

--
Thanks and Regards
gautham.
