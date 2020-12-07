Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011182D1A63
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 21:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgLGURY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 15:17:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgLGURY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 15:17:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7JdGwS105041;
        Mon, 7 Dec 2020 15:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rK2q7t9Vd7Je/FrnJA98xAL1ZjrmaqZukOk+YA3Y/mE=;
 b=tHq3WKbtRLZZmTUY+Wvg5us1Ja7gEcCh1P1EmLIVGod4nNfdIbqudYs7yd9ZLYkgVXqz
 8Gg6q6+2kL/UDdqird63gKHHSGxzjrniiVYjRHXeixMwO6Qx56STSH0SCNeTOx92MWLG
 m7LAqGAulMC7IIVAXjGdcKuRK8eVxiwRuF3kE0jsL/G3TXJnDJ8/QAfP1O7zCinw0Ahh
 i0lpSsPeFnj3FMpJb9jDK26uayLBBAs/IPOfBXgjvr65buPk529fXLdACiOMAg4/mbbV
 hwOPpvx2+aTd4/iMUo8lsUzm3x+LQMWhjInctKEW1FnVkJqy24LvyLakOn/YlVpvyBtY Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359s0h41jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 15:16:43 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7JmNhu140435;
        Mon, 7 Dec 2020 15:16:42 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359s0h41j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 15:16:42 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7KDt9A005439;
        Mon, 7 Dec 2020 20:16:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8m67m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 20:16:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7KGbM751184080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 20:16:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92CA5A4053;
        Mon,  7 Dec 2020 20:16:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A2FA4040;
        Mon,  7 Dec 2020 20:16:36 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.4.19])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 20:16:36 +0000 (GMT)
Subject: Re: [PATCH v4] self_tests/kvm: sync_regs test for diag318
To:     Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        cohuck@redhat.com, pbonzini@redhat.com, imbrenda@linux.ibm.com
References: <20201207154125.10322-1-walling@linux.ibm.com>
 <2ea47a0e-40fb-35bc-5819-63a9e7b2ec59@de.ibm.com>
 <d5289faa-0422-5f16-9d84-cd6c1d627033@linux.ibm.com>
 <87bf5fb7-26bf-f757-1efa-d2a49bde5188@de.ibm.com>
 <501fe03a-c245-73f3-4715-1327cc73a712@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ed4013bb-ac56-cd16-ca90-008bca8bf52b@de.ibm.com>
Date:   Mon, 7 Dec 2020 21:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <501fe03a-c245-73f3-4715-1327cc73a712@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_16:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070125
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 07.12.20 21:13, Collin Walling wrote:
> On 12/7/20 3:09 PM, Christian Borntraeger wrote:
>>
>>
>> On 07.12.20 21:06, Collin Walling wrote:
>>> On 12/7/20 2:32 PM, Christian Borntraeger wrote:
>>>> On 07.12.20 16:41, Collin Walling wrote:
>>>>> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
>>>>> that must be intercepted via SIE, handled in userspace, and the
>>>>> information set by the instruction is communicated back to KVM.
>>>>>
>>>>> To test the instruction interception, an ad-hoc handler is defined which
>>>>> simply has a VM execute the instruction and then userspace will extract
>>>>> the necessary info. The handler is defined such that the instruction
>>>>> invocation occurs only once. It is up to the caller to determine how the
>>>>> info returned by this handler should be used.
>>>>>
>>>>> The diag318 info is communicated from userspace to KVM via a sync_regs
>>>>> call. This is tested During a sync_regs test, where the diag318 info is
>>>>> requested via the handler, then the info is stored in the appropriate
>>>>> register in KVM via a sync registers call.
>>>>>
>>>>> If KVM does not support diag318, then the tests will print a message
>>>>> stating that diag318 was skipped, and the asserts will simply test
>>>>> against a value of 0.
>>>>>
>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>
>>>> Interestingly enough, this testcase actually trigger a bug:
>>>> While we gracefully handle this (no crash)
>>>> debugfs: Directory 'kvm-200206' with parent 's390dbf' already present!
>>>> is certainly not ideal....
>>>>
>>>
>>> Odd... I wonder what triggered this behavior?
>>>
>>> I run my tests with a simple command:
>>>
>>> make summary=0 TARGETS=kvm kselftest
>>>
>>> This must have something to do with spinning up another VM to get the
>>> diag318 data. I think if I have the sync_regs test call the diag handler
>>> first, and then have the sync regs create a VM, that might solve that
>>> issue...
>>
>> Yes, the s390dbf code will try to create a file named kvm-%pid. With
>> 2 VMs the 2nd one fails. Luckily the kvm will be created anyway and 
>> also the shutdown seems to be fine, still....
>>
>>>
>>> May I ask how you encountered this bug so I may replicate in on my end?
>>
>> I just did
>> make TARGETS=kvm selftests
>>
>> and then the error is on dmesg.
>>
> 
> Thanks. v5 with fix incoming.

I think the test is actually fine and we should rather fix the kvm module to
gracefully handle a userspace that starts up 2 or more guests.
