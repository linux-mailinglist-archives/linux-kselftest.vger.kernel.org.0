Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3954353735
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Apr 2021 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhDDHe1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Apr 2021 03:34:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229675AbhDDHe0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Apr 2021 03:34:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1347XRKR142409;
        Sun, 4 Apr 2021 03:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2R8reBzTetkARKhf+wUoL3rELP7Dnxr7IKA7hJpDfDs=;
 b=ISI9H4Bf2li3WkVobfOXqVEbilXmV06xH1NDYUoXXhyOlg1o/1KBAKCCq6ZX4CQPWh1T
 TobEJBOSQ9EXk1Two7Ka/SFXdDmfx/GYB65Xm3LiwW+Ej2nhyXVekCTBZAoy7uRPRzsp
 KgBMFPbll9NUZFrL3aukaUV+mCT9I3QEcV/ZJLwQ+u2CmXZR5WHsK/DGhrMnriRihjgc
 +5gm6StV5jdrzgcQ6Vkdsd3uT9bXBUh0jJPRzUFKmPsLQhX7ioj632u8DoO3emMIqEtq
 sf6pQfRcJxGXRT8Ylupz6hOPSu2b033JOZ2DozV8AxkffgSKCMf3Up+RzipkCrsRi9TT +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37q5p93e7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Apr 2021 03:34:17 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1347YHdr143347;
        Sun, 4 Apr 2021 03:34:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37q5p93e74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Apr 2021 03:34:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1347Rtov000606;
        Sun, 4 Apr 2021 07:34:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 37q2n2r714-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Apr 2021 07:34:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1347YClC45351374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Apr 2021 07:34:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A84AE045;
        Sun,  4 Apr 2021 07:34:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CEC6AE051;
        Sun,  4 Apr 2021 07:34:11 +0000 (GMT)
Received: from [9.85.90.174] (unknown [9.85.90.174])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  4 Apr 2021 07:34:10 +0000 (GMT)
Subject: Re: [RFC v2 2/2] selftest/cpuidle: Add support for cpuidle latency
 measurement
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210401114504.13466-1-psampat@linux.ibm.com>
 <20210401114504.13466-3-psampat@linux.ibm.com>
 <CAAYoRsWKw2eXXoXGhdaM2pqhvDGXz8o=hV5K5HmYaZvetxv96w@mail.gmail.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <b6d19fec-d9c9-817f-0ba1-4445d53e9616@linux.ibm.com>
Date:   Sun, 4 Apr 2021 13:04:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAYoRsWKw2eXXoXGhdaM2pqhvDGXz8o=hV5K5HmYaZvetxv96w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: da90MTzAnjH_JKePqHot8qQuC7FFtz8X
X-Proofpoint-GUID: 2Zfd0OdT5tlkWOm_GLjKbCPRcOfwTw71
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-04_01:2021-04-01,2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104040050
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Doug,

Thanks for your review.

On 02/04/21 4:57 am, Doug Smythies wrote:
> Hi Pratik,
>
> On Thu, Apr 1, 2021 at 4:45 AM Pratik Rajesh Sampat
> <psampat@linux.ibm.com> wrote:
> ...
>
>> To run this test specifically:
>> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests
> I have not become any smarter than I was with version 1,
> and still assumed that the "$" meant regular user.
> Please put it as "#" or separate the two steps, compile and run.

Apologies, I missed incorporating the root user discussion we had.
I'll add a sudo past the "$" symbol.

>> There are a few optinal arguments too that the script can take
> optional
>
> Suggest to also specifically mention how to run without re-compile,
>
> # ./cpuidle.sh -v

Sure thing, I'll add a comment specifying this.

> Note also that the test still leaves all idle states disabled when done.

Yes, I missed out enabling all the idle states after the tests are done.
I'll spin a new version where I enable idle states at the end of the experiment
so that the system stays coherent.

>>          [-h <help>]
>>          [-i <run timer tests>]
>>          [-m <location of the module>]
>>          [-o <location of the output>]
>>          [-v <verbose> (run on all cpus)]
>> Default Output location in: tools/testing/selftest/cpuidle/cpuidle.log
> ...
>
>> +cpu_is_online()
>> +{
>> +       cpu=$1
>> +       if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
>> +               echo 0
> incorrect. should be:
>
>> +               echo 1

Right! Thanks for catching this.

> ... Doug

Thank you,
Pratik

