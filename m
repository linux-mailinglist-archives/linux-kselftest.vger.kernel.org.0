Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1C45D183
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 01:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbhKYAS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 19:18:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243273AbhKYAS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 19:18:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOLpPs4029755;
        Thu, 25 Nov 2021 00:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zSF/FnVBcZ1mEkmYRrl6F/JWM9mPlzqSUSk5cELuKBY=;
 b=hvDYXpvtrsTNY/M5R679GqDdp5S1Q1xsFLYEx7vyz3qipz2SSXVFyPDABlfaO2ohjRpD
 yR1Jr0plhsVjB7ardym6/DudAK9mWMx4/OvQ+FLqcnwtCTSdISe58eMfJ4uBgz+Q2PXu
 HckjMJEgn8gdbjBfunENwWPfzM6Zk50VEtUUIwhDcCGCZr2sGdEEr4J8U1MpvWdkTpzg
 OEi5SSwnTzyz4JtROUGenngfJgf+AkXxF7/kxhJz/3NF1VnAH5LGu7CXcbbKp0Q+/cxK
 4lCVv66smYqoFm6uynkAh+ntr7cgY4xXUqd6yJht2Hou/XhwmndrV5NcSwKIAzurN+MY hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chwp69vmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:15:13 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AP0CN3x004383;
        Thu, 25 Nov 2021 00:15:13 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chwp69vmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:15:13 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AONwlik025518;
        Thu, 25 Nov 2021 00:15:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3cerncrvwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:15:12 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP0FBLh63308132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 00:15:11 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85E8F2805E;
        Thu, 25 Nov 2021 00:15:11 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B16F428074;
        Thu, 25 Nov 2021 00:15:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 00:15:10 +0000 (GMT)
Message-ID: <1189a2ef-ae31-92f2-a7a7-d60064bdde44@linux.ibm.com>
Date:   Wed, 24 Nov 2021 19:15:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] selftests: tpm2: Probe for available PCR bank
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20211124141314.1356338-1-stefanb@linux.ibm.com>
 <20211124141314.1356338-2-stefanb@linux.ibm.com> <YZ7QwlZ77b4A/ZbR@iki.fi>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YZ7QwlZ77b4A/ZbR@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uTb9Rg0mJ3OLqYWv5bBXPc7FqucqC09A
X-Proofpoint-GUID: GbhetZrs8bjhSJBYQuX0R9g8ZyBIGX62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240116
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/24/21 18:54, Jarkko Sakkinen wrote:
> On Wed, Nov 24, 2021 at 09:13:12AM -0500, Stefan Berger wrote:
>> Probe for an available PCR bank to accommodate devices that do not have a
>> SHA-1 PCR bank or whose SHA-1 bank is deactivated. Use the bank that can
>> be used in the TPM2 commands. Assert on the probing function to not
>> return None.
> What is *the bank* that can be used?

The bank can be either SHA-1 or SHA-256 at this point.

>
> In addition, I don't understand the last sentence.


If the probing function returns None the test fails due to an 
assertIsNotNone().

    stefan

>
> /Jarkko
>
>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   tools/testing/selftests/tpm2/tpm2_tests.py | 35 +++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
>> index 9d764306887b..6b88ff0e47b9 100644
>> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
>> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
>> @@ -27,7 +27,23 @@ class SmokeTest(unittest.TestCase):
>>           result = self.client.unseal(self.root_key, blob, auth, None)
>>           self.assertEqual(data, result)
>>   
>> +    def determine_bank_alg(self):
>> +        # Probe for available PCR bank
>> +        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
>> +            try:
>> +                handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>> +                self.client.policy_pcr(handle, [17], bank_alg=bank_alg)
>> +                return bank_alg
>> +            except tpm2.UnknownPCRBankError:
>> +                pass
>> +            finally:
>> +                self.client.flush_context(handle)
>> +        return None
>> +
>>       def test_seal_with_policy(self):
>> +        bank_alg = self.determine_bank_alg()
>> +        self.assertIsNotNone(bank_alg)
>> +
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>>   
>>           data = ('X' * 64).encode()
>> @@ -35,7 +51,7 @@ class SmokeTest(unittest.TestCase):
>>           pcrs = [16]
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               policy_dig = self.client.get_policy_digest(handle)
>> @@ -47,7 +63,7 @@ class SmokeTest(unittest.TestCase):
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               result = self.client.unseal(self.root_key, blob, auth, handle)
>> @@ -72,6 +88,9 @@ class SmokeTest(unittest.TestCase):
>>           self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
>>   
>>       def test_unseal_with_wrong_policy(self):
>> +        bank_alg = self.determine_bank_alg()
>> +        self.assertIsNotNone(bank_alg)
>> +
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>>   
>>           data = ('X' * 64).encode()
>> @@ -79,7 +98,7 @@ class SmokeTest(unittest.TestCase):
>>           pcrs = [16]
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               policy_dig = self.client.get_policy_digest(handle)
>> @@ -91,13 +110,13 @@ class SmokeTest(unittest.TestCase):
>>           # Extend first a PCR that is not part of the policy and try to unseal.
>>           # This should succeed.
>>   
>> -        ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
>> -        self.client.extend_pcr(1, ('X' * ds).encode())
>> +        ds = tpm2.get_digest_size(bank_alg)
>> +        self.client.extend_pcr(1, ('X' * ds).encode(), bank_alg=bank_alg)
>>   
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               result = self.client.unseal(self.root_key, blob, auth, handle)
>> @@ -109,14 +128,14 @@ class SmokeTest(unittest.TestCase):
>>   
>>           # Then, extend a PCR that is part of the policy and try to unseal.
>>           # This should fail.
>> -        self.client.extend_pcr(16, ('X' * ds).encode())
>> +        self.client.extend_pcr(16, ('X' * ds).encode(), bank_alg=bank_alg)
>>   
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>>   
>>           rc = 0
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               result = self.client.unseal(self.root_key, blob, auth, handle)
>> -- 
>> 2.31.1
>>
