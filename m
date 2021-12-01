Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D1946508A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbhLAO4T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:56:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231266AbhLAO4T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:56:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Eq43n021925;
        Wed, 1 Dec 2021 14:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ib4L4QWPQ+tGPMk+wtD8oXVjJUb80I/kHxdeE5v1kVQ=;
 b=eqbTN4+hWCrEn1oaqdeuLz88+t4oNnf7gRDykKfzOcO0hERF2nmPwMUbCeXtR5zeYBYp
 GYnKHqP6Kwzn3DoQjfbkoG6BasWyjFwRJOdh8BUQb3GXpeZKwJnpYOEy+AxflOk7nmlA
 mAxIPv4ILxtnPRNLeRzYsR1UAEAZjFLK9wQkDAoc7Bd1jTjBj0pbYDfqdU6NA+C/uEam
 OZJTpa/HIjQ8Dxy28DpI1ZFgN9DEDfXO29e0J7XIt2cMuHKGQNukLkuGgroTFu/5mhiQ
 h0GAl9ehMADIWfH8gF0LCKlwwfVGiZzsY8uisu6kmydCSl7uQ2aTItr5+l1Wh00pDJCV Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpb6m00rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 14:52:55 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1EqFpI022886;
        Wed, 1 Dec 2021 14:52:54 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpb6m00r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 14:52:54 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Emhs1001475;
        Wed, 1 Dec 2021 14:52:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3ckcacm02y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 14:52:22 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1EqKwV17367910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 14:52:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2564EAC06B;
        Wed,  1 Dec 2021 14:52:20 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BFD1AC078;
        Wed,  1 Dec 2021 14:52:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 14:52:19 +0000 (GMT)
Message-ID: <72d566d3-d677-8d0a-612d-fe9c5f3c94cb@linux.ibm.com>
Date:   Wed, 1 Dec 2021 09:52:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/2] selftests: tpm2: Reset the dictionary attack lock
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-3-stefanb@linux.vnet.ibm.com>
 <YaVljk1vLRZ/TDJ/@iki.fi>
 <e569444c-e0cd-52bc-308f-7fa457dbf086@linux.ibm.com>
 <YadLaHB0oJZYTMbh@iki.fi>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YadLaHB0oJZYTMbh@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EnOcVd06013j5aR8fUhYPgJYjmqUU52n
X-Proofpoint-GUID: 7wa_daydB5EQ9XANB_ef181c6ifHl_jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112010082
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/21 05:16, Jarkko Sakkinen wrote:

> On Mon, Nov 29, 2021 at 07:26:12PM -0500, Stefan Berger wrote:
>> On 11/29/21 18:43, Jarkko Sakkinen wrote:
>>> On Sat, Nov 27, 2021 at 11:10:52PM -0500, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Reset the dictionary attack lock to avoid the following types of test
>>>> failures after running the test 2 times:
>>>>
>>>> ======================================================================
>>>> ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
>>>> ----------------------------------------------------------------------
>>>> Traceback (most recent call last):
>>>>     File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_tests.py", line 105, in test_unseal_with_wrong_policy
>>>>       blob = self.client.seal(self.root_key, data, auth, policy_dig)
>>>>     File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 620, in seal
>>>>       rsp = self.send_cmd(cmd)
>>>>     File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 397, in send_cmd
>>>>       raise ProtocolError(cc, rc)
>>>> tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>    tools/testing/selftests/tpm2/tpm2_tests.py | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
>>>> index e63a37819978..ad6f54c01adf 100644
>>>> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
>>>> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
>>>> @@ -139,6 +139,8 @@ class SmokeTest(unittest.TestCase):
>>>>            except:
>>>>                self.client.flush_context(handle)
>>>>                raise
>>>> +        finally:
>>>> +            self.client.reset_da_lock()
>>>>            self.assertEqual(rc, tpm2.TPM2_RC_POLICY_FAIL)
>>>> -- 
>>>> 2.31.1
>>>>
>>> I don't agree with this as a DA lock has legit use. This would be adequate
>>> for systems dedicated for kernel testing only.
>> The problem is this particular test case I am patching here causes the above
>> test failures upon rerun. We are testing the driver here presumably and not
>> the TPM2, so I think we should leave the TPM2 as cleaned up as possible,
>> thus my suggestion is to reset the DA lock and we won't hear any complaints
>> after that.
>
>> The tss packages also have command line tools to reset the DA lock, but it
>> shouldn't be necessary to use them after running a **driver** test case.
> If you speak about TSS, please alway say which one :-)

packages : both

tpm2_dictionarylockout -c [ -p password ]

tssdictionaryattacklockreset [-pwd password]


>
> Adding non-volatile state changes explicitly is to a test case is both
> intrusive and wrong. These type of choices are not to be done in the
> test case implementation for sure.

I drop this patch because if someone changed the password the lock reset 
will not work as expected.

One can also argue with having a test case that triggers a failure 
condition in the TPM2 is both intrusive and wrong. That said, the 
offending test cases should probably not even exist, especially since 
they test a user's knowledge about the device afterwards...


>
> An improvement that does not add extra side-effect, would be to read the
> TPM_PT_LOCKOUT_COUNTER and roll back with a proper error message for the
> lockout condition.
>
> You can also configure the maximum number of tries up to (2 << 31) - 1
> = 4294967295 with TPM2_DictionaryAttackParameters...

... which I think the user of a device driver test should not have to do.


   Stefan

>
> /Jarkko
