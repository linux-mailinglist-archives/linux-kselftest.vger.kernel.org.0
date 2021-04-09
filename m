Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16235969F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 09:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhDIHnd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 03:43:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhDIHnc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 03:43:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1397YsjU146039;
        Fri, 9 Apr 2021 03:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xiUtlMdV1qmOtUTS0mAOTmFtl+PR5P0QOUvxxRJMJII=;
 b=QXzXVPNMqIHYqXDt6OVXZDYL0v8nTc+Ost0GE1qAvJocIGLOuN0oEanY8Cvp4bFMiDER
 t60SvWTtX5Bztkvn0AiDL8cMmJCzh8RzZa7/04op4JZ7BEtv1O2u/VoQLHYhfVnoiTLS
 HP1zX6SVthF5Ccp8HIiSAGRbA6Y4LpamcqIfXz+rXcXQjdhwYmDYnEI14QBUrfhrwBOE
 70MDNAw7pYtGFaL7EJInkZLlSjbxA9jtM2IvkumcNRw54y7R9dg4kMoKy0WyDZ689/6u
 1X5Xju1w24GRI5ZmVTpkvbeTCG+DpCbhy5xatuBjpiZsB+HBgjy5x/QMC3DpQCBW+qHC cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpmgvn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 03:43:15 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1397Z3Af000582;
        Fri, 9 Apr 2021 03:43:14 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpmgvmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 03:43:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1397bJ12005476;
        Fri, 9 Apr 2021 07:43:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbwa8nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 07:43:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1397h97h43974916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 07:43:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C368D4204F;
        Fri,  9 Apr 2021 07:43:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9466642049;
        Fri,  9 Apr 2021 07:43:07 +0000 (GMT)
Received: from [9.85.88.88] (unknown [9.85.88.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 07:43:07 +0000 (GMT)
Subject: Re: [RFC v3 0/2] CPU-Idle latency selftest framework
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210404083354.23060-1-psampat@linux.ibm.com>
 <CAAYoRsWaAmyuJU4FCb7gtK0y-ZprdDVvp0vMpy=ZohzoC7YX1Q@mail.gmail.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <0a4b32e0-426e-4886-ae37-6d0bdafdea7f@linux.ibm.com>
Date:   Fri, 9 Apr 2021 13:13:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAYoRsWaAmyuJU4FCb7gtK0y-ZprdDVvp0vMpy=ZohzoC7YX1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m_I7_nfha0zFllGSCP4Jkwuf7I4ug_C6
X-Proofpoint-GUID: mK7HdC2km8f6KCAES3XRk4HSNS13m498
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090055
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Doug,

On 09/04/21 10:53 am, Doug Smythies wrote:
> Hi Pratik,
>
> I tried V3 on a Intel i5-10600K processor with 6 cores and 12 CPUs.
> The core to cpu mappings are:
> core 0 has cpus 0 and 6
> core 1 has cpus 1 and 7
> core 2 has cpus 2 and 8
> core 3 has cpus 3 and 9
> core 4 has cpus 4 and 10
> core 5 has cpus 5 and 11
>
> By default, it will test CPUs 0,2,4,6,10 on cores 0,2,4,0,2,4.
> wouldn't it make more sense to test each core once?

Ideally it would be better to run on all the CPUs, however on larger systems
that I'm testing on with hundreds of cores and a high a thread count, the
execution time increases while not particularly bringing any additional
information to the table.

That is why it made sense only run on one of the threads of each core to make
the experiment faster while preserving accuracy.

To handle various thread topologies it maybe worthwhile if we parse
/sys/devices/system/cpu/cpuX/topology/thread_siblings_list for each core and
use this information to run only once per physical core, rather than
assuming the topology.

What are your thoughts on a mechanism like this?

> With the source CPU always 0, I think the results from the results
> from the destination CPUs 0 and 6, on core 0 bias the results, at
> least in the deeper idle states. They don't make much difference in
> the shallow states. Myself, I wouldn't include them in the results.

I agree, CPU0->CPU0 same core interaction is causing a bias. I could omit that
observation while computing the average.

In the verbose mode I'll omit all the threads of CPU0 and in the default
(quick) mode just CPU0's latency can be omitted while computing average.

Thank you,
Pratik

> Example, where I used the -v option for all CPUs:
>
> --IPI Latency Test---
> --Baseline IPI Latency measurement: CPU Busy--
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0          101
> 0            1          790
> 0            2          609
> 0            3          595
> 0            4          737
> 0            5          759
> 0            6          780
> 0            7          741
> 0            8          574
> 0            9          681
> 0           10          527
> 0           11          552
> Baseline Avg IPI latency(ns): 620  <<<< suggest 656 here
> ---Enabling state: 0---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0           76
> 0            1          471
> 0            2          420
> 0            3          462
> 0            4          454
> 0            5          468
> 0            6          453
> 0            7          473
> 0            8          380
> 0            9          483
> 0           10          492
> 0           11          454
> Expected IPI latency(ns): 0
> Observed Avg IPI latency(ns) - State 0: 423 <<<<< suggest 456 here
> ---Enabling state: 1---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0          112
> 0            1          866
> 0            2          663
> 0            3          851
> 0            4         1090
> 0            5         1314
> 0            6         1941
> 0            7         1458
> 0            8          687
> 0            9          802
> 0           10         1041
> 0           11         1284
> Expected IPI latency(ns): 1000
> Observed Avg IPI latency(ns) - State 1: 1009 <<<< suggest 1006 here
> ---Enabling state: 2---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0           75
> 0            1        16362
> 0            2        16785
> 0            3        19650
> 0            4        17356
> 0            5        17606
> 0            6         2217
> 0            7        17958
> 0            8        17332
> 0            9        16615
> 0           10        17382
> 0           11        17423
> Expected IPI latency(ns): 120000
> Observed Avg IPI latency(ns) - State 2: 14730 <<<< suggest 17447 here
> ---Enabling state: 3---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0          103
> 0            1        17416
> 0            2        17961
> 0            3        16651
> 0            4        17867
> 0            5        17726
> 0            6         2178
> 0            7        16620
> 0            8        20951
> 0            9        16567
> 0           10        17131
> 0           11        17563
> Expected IPI latency(ns): 1034000
> Observed Avg IPI latency(ns) - State 3: 14894 <<<< suggest 17645 here
>
> Hope this helps.
>
> ... Doug

