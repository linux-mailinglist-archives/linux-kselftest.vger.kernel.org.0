Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D382D288A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLHKKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 05:10:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgLHKKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 05:10:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8A3f1x163729;
        Tue, 8 Dec 2020 05:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5/TrwPbfHl9X0bHCx6Y4zScwpYDU0Ds9sPXGhs/IsSo=;
 b=UHi1xpoaxaEgtcmjylvw5wWvPZnnzdNgDRz+vVhIciVj8wINpuvvf1Ruo3/0JzlLf3KM
 RpLzRheI0sB5/vUUWgzIFUNIW65fug4sZdINtCaU1hphUw+qG1vrRT7A67WXRsXNPk6Q
 bgmx39TDQ4kqYK/FxDErL9CScLMNQNgh2nUinrFpfRMFeSvNaN0sHTyUBQ3brNPvKIHA
 fBtrnAFh5+0t2VypEmHV8JTarvc3D/Has1uugaOGpunERyaEl+gxmrUHYKZ/CYIVM864
 r1tjZlGvDN6gOE7NfjLU2BB12/OU2BJcnZ6ggdzP7yG0tfIXPVRHoi5MkVBkqmVrn9fE HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a61x2m3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 05:09:38 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8A3tc2165731;
        Tue, 8 Dec 2020 05:09:38 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a61x2m36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 05:09:38 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8A8Ekg021900;
        Tue, 8 Dec 2020 10:09:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u83ed4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:09:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8A9XAj21102936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 10:09:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62BAD4C044;
        Tue,  8 Dec 2020 10:09:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F5694C04E;
        Tue,  8 Dec 2020 10:09:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.152.117])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 10:09:32 +0000 (GMT)
Subject: Re: [PATCH v4] self_tests/kvm: sync_regs test for diag318
To:     Collin Walling <walling@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, imbrenda@linux.ibm.com
References: <20201207154125.10322-1-walling@linux.ibm.com>
 <2ea47a0e-40fb-35bc-5819-63a9e7b2ec59@de.ibm.com>
 <d5289faa-0422-5f16-9d84-cd6c1d627033@linux.ibm.com>
 <87bf5fb7-26bf-f757-1efa-d2a49bde5188@de.ibm.com>
 <501fe03a-c245-73f3-4715-1327cc73a712@linux.ibm.com>
 <ed4013bb-ac56-cd16-ca90-008bca8bf52b@de.ibm.com>
 <a3b745cf-d0ed-a200-b01e-907c9ffb4569@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Message-ID: <ac497116-5b07-43f0-95cf-90c1c7b3965a@linux.ibm.com>
Date:   Tue, 8 Dec 2020 11:09:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a3b745cf-d0ed-a200-b01e-907c9ffb4569@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_06:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080062
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/20 9:59 PM, Collin Walling wrote:
> On 12/7/20 3:16 PM, Christian Borntraeger wrote:
>>
>>
>> On 07.12.20 21:13, Collin Walling wrote:
>>> On 12/7/20 3:09 PM, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 07.12.20 21:06, Collin Walling wrote:
>>>>> On 12/7/20 2:32 PM, Christian Borntraeger wrote:
>>>>>> On 07.12.20 16:41, Collin Walling wrote:
>>>>>>> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
>>>>>>> that must be intercepted via SIE, handled in userspace, and the
>>>>>>> information set by the instruction is communicated back to KVM.
>>>>>>>
>>>>>>> To test the instruction interception, an ad-hoc handler is defined which
>>>>>>> simply has a VM execute the instruction and then userspace will extract
>>>>>>> the necessary info. The handler is defined such that the instruction
>>>>>>> invocation occurs only once. It is up to the caller to determine how the
>>>>>>> info returned by this handler should be used.
>>>>>>>
>>>>>>> The diag318 info is communicated from userspace to KVM via a sync_regs
>>>>>>> call. This is tested During a sync_regs test, where the diag318 info is
>>>>>>> requested via the handler, then the info is stored in the appropriate
>>>>>>> register in KVM via a sync registers call.
>>>>>>>
>>>>>>> If KVM does not support diag318, then the tests will print a message
>>>>>>> stating that diag318 was skipped, and the asserts will simply test
>>>>>>> against a value of 0.
>>>>>>>
>>>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>>>
>>>>>> Interestingly enough, this testcase actually trigger a bug:
>>>>>> While we gracefully handle this (no crash)
>>>>>> debugfs: Directory 'kvm-200206' with parent 's390dbf' already present!
>>>>>> is certainly not ideal....
>>>>>>
>>>>>
>>>>> Odd... I wonder what triggered this behavior?
>>>>>
>>>>> I run my tests with a simple command:
>>>>>
>>>>> make summary=0 TARGETS=kvm kselftest
>>>>>
>>>>> This must have something to do with spinning up another VM to get the
>>>>> diag318 data. I think if I have the sync_regs test call the diag handler
>>>>> first, and then have the sync regs create a VM, that might solve that
>>>>> issue...
>>>>
>>>> Yes, the s390dbf code will try to create a file named kvm-%pid. With
>>>> 2 VMs the 2nd one fails. Luckily the kvm will be created anyway and 
>>>> also the shutdown seems to be fine, still....
>>>>
>>>>>
>>>>> May I ask how you encountered this bug so I may replicate in on my end?
>>>>
>>>> I just did
>>>> make TARGETS=kvm selftests
>>>>
>>>> and then the error is on dmesg.
>>>>
>>>
>>> Thanks. v5 with fix incoming.
>>
>> I think the test is actually fine and we should rather fix the kvm module to
>> gracefully handle a userspace that starts up 2 or more guests.
>>
> 
> Looks like the root cause is within the inode.c file used for the debug
> filesystem. Essentially, the 2nd VM starts / ends just fine as you
> mentioned, but doesn't get a dbfs.
> 
> Since this touches the dbfs related area, and I'm unsure how common this
> problem is out in the wild, should we ping the kernel list and see if it
> catches anyone's attention?
> 
> A first thought would be to append a per-userspace incrementing value to
> the end of the kvm-%pid part to account for any collisions, but that's
> up to the folks that know more than I do.
> 

Seems like I have a deja-vu, I remember having to fix that for the
common code :-)
For the KVM debugfs I solved that by appending the file descriptor after
the pid. Maybe we can steal the string from the dentry.

Have a look into vm_create_vm_debugfs(struct kvm *kvm, int fd).
