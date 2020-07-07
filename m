Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05A217312
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGPyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 11:54:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbgGGPyR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 11:54:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067FWtcB066589;
        Tue, 7 Jul 2020 11:53:54 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324s7163h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 11:53:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067FeF8Y016662;
        Tue, 7 Jul 2020 15:53:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 322hd7uk99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 15:53:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067Fro4R65732814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 15:53:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E73364C050;
        Tue,  7 Jul 2020 15:53:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CF24C04A;
        Tue,  7 Jul 2020 15:53:47 +0000 (GMT)
Received: from [9.85.70.197] (unknown [9.85.70.197])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 15:53:47 +0000 (GMT)
Subject: Re: [PATCH 2/2] selftest/cpuidle: Add support for cpuidle latency
 measurement
To:     Shuah Khan <skhan@linuxfoundation.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200707152917.10652-1-psampat@linux.ibm.com>
 <20200707152917.10652-3-psampat@linux.ibm.com>
 <bf016b30-18e6-69fd-afc5-5319ebd6a890@linuxfoundation.org>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <77f3c7a1-bfb0-d6ff-67e1-1854e390016e@linux.ibm.com>
Date:   Tue, 7 Jul 2020 21:23:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bf016b30-18e6-69fd-afc5-5319ebd6a890@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 cotscore=-2147483648 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070113
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[..snip..]
>> +
>> +ins_mod()
>> +{
>> +    if [ ! -f "$MODULE" ]; then
>> +        printf "$MODULE module does not exist. Exitting\n"
>> +        exit 2
>
> Please use ksft_skip code to indicate the test is being skipped.
>
Sure thing I'll use ksft_skip exit code instead.
>> +    fi
>> +    printf "Inserting $MODULE module\n\n"
>> +    insmod $MODULE
>> +    if [ $? != 0 ]; then
>> +        printf "Insmod $MODULE failed\n"
>> +        exit 2
>
> This is fine since you expect to be able to load the module.
>
Thanks for the review.
Pratik

[..snip..]
>>
>
> thanks,
> -- Shuah

