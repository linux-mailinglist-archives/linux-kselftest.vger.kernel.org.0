Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0045FC70
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Nov 2021 04:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352386AbhK0DtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 22:49:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236666AbhK0DrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 22:47:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AR3MVKe023858;
        Sat, 27 Nov 2021 03:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4eB56somxyCGqXyzYvzkcEQfJwq4cs00pYLIPKTRSd0=;
 b=BXz4p1Xj33GTpa4ZS2qpnj3JYTWNT/cd1qHmkE5TfflDN2aIbjjXKTQg9Is4MEUfoBPH
 LUz58cWxIw7bHstALm7r3epXf30chBc+i3Dy7U3Orzq0Xd+D/kxjMKh32CyvaadNvJcP
 Lf6IDV1yZWI78q5zlHb+tdFTVaz9f42ORL/koD/vfF15vTqO9zcXlSz/jxySRL689/fJ
 CLuT0SWryUSyaxsPJq9rTJdz8xAs4eB2v/2k1g2CNoFTlbZCQJty+XbKwXz2IbZQ1rFQ
 FwGqpi1JUqxw4LTGWZONIntRIYWOVDtesJgJa1UdZHwDxIU3hqfRPVPbsGtO1uLAnSnd VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ckcq386yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Nov 2021 03:43:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AR3YKDW020454;
        Sat, 27 Nov 2021 03:43:45 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ckcq386ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Nov 2021 03:43:45 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AR3h0Xo025865;
        Sat, 27 Nov 2021 03:43:44 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3ckca98f7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Nov 2021 03:43:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AR3hhVI21627784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Nov 2021 03:43:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AE6AAC05F;
        Sat, 27 Nov 2021 03:43:43 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30072AC05E;
        Sat, 27 Nov 2021 03:43:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 27 Nov 2021 03:43:43 +0000 (GMT)
Message-ID: <2557c1e2-b0fa-8729-0eb0-6ae68ee6f653@linux.ibm.com>
Date:   Fri, 26 Nov 2021 22:43:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/3] selftests: tpm2: Probe for available PCR bank
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
References: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
 <20211125003827.1360432-2-stefanb@linux.vnet.ibm.com>
 <97ddf0f23592b74e7647e3c9b36b37553c594c82.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <97ddf0f23592b74e7647e3c9b36b37553c594c82.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aUbulO1Y26RYD-7d-PQyEFe0TZSG6FjT
X-Proofpoint-ORIG-GUID: WXDukT7EUqffygXAbUtycn2irpRL29Gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-27_01,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111270017
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/26/21 19:29, Jarkko Sakkinen wrote:
> On Wed, 2021-11-24 at 19:38 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Probe for an available PCR bank to accommodate devices that do not have a
> What does "probing for an vailable PCR bank" even mean?

Checking ? Testing ? What's the difference to those words?


>
>> SHA-1 PCR bank or whose SHA-1 bank is deactivated. Use the bank that can
>> be used for the TPM2 commands, such as the SHA-256 bank.
> This is incorrect, as the patch does not have code to query
> available hash algorithms.

I am not sure I understand. The new function determines which PCR banks 
(SHA-1 or SHA-256) the subsequent tests can use. It tries to execute the 
policy_pcr command with the given hash bank algorithm (SHA-256 or SHA-1) 
and if it returns an UnknowPcrBankError it tries the next one in the 
list. It doesn't need to query available hash algorithms. A TPM 2 may 
support SHA 256 and yet its SHA 256 bank may be deactivate.

> What the code does, and only does that, is to use SHA-256 as
> a fallback when SHA-1 is not enabled.
>
> /Jarkko
>
>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   tools/testing/selftests/tpm2/tpm2_tests.py | 35 +++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
>> index 9d764306887b..6b88ff0e47b9 100644
>> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
>> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
>> @@ -27,7 +27,23 @@ class SmokeTest(unittest.TestCase):
>>           result = self.client.unseal(self.root_key, blob, auth, None)
>>           self.assertEqual(data, result)
>>   
>> +    def determine_bank_alg(self):
>> +        # Probe for available PCR bank
>> +        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
>> +            try:
>> +                handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>> +                self.client.policy_pcr(handle, [17], bank_alg=bank_alg)
>> +                return bank_alg
>> +            except tpm2.UnknownPCRBankError:
>> +                pass
>> +            finally:
>> +                self.client.flush_context(handle)
>> +        return None
>> +
>>       def test_seal_with_policy(self):
>> +        bank_alg = self.determine_bank_alg()
>> +        self.assertIsNotNone(bank_alg)
>> +
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>>   
>>           data = ('X' * 64).encode()
>> @@ -35,7 +51,7 @@ class SmokeTest(unittest.TestCase):
>>           pcrs = [16]
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               policy_dig = self.client.get_policy_digest(handle)
>> @@ -47,7 +63,7 @@ class SmokeTest(unittest.TestCase):
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>>   
>>           try:
>> -            self.client.policy_pcr(handle, p"Use SHA-256 as a fallback crs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               result = self.client.unseal(self.root_key, blob, auth, handle)
>> @@ -72,6 +88,9 @@ class SmokeTest(unittest.TestCase):
>>           self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
>>   
>>       def test_unseal_with_wrong_policy(self):
>> +        bank_alg = self.determine_bank_alg()
>> +        self.assertIsNotNone(bank_alg)
>> +
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>>   
>>           data = ('X' * 64).encode()
>> @@ -79,7 +98,7 @@ class SmokeTest(unittest.TestCase):
>>           pcrs = [16]
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               policy_dig = self.client.get_policy_digest(handle)
>> @@ -91,13 +110,13 @@ class SmokeTest(unittest.TestCase):
>>           # Extend first a PCR that is not part of the policy and try to unseal.
>>           # This should succeed.
>>   
>> -        ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
>> -        self.client.extend_pcr(1, ('X' * ds).encode())
>> +        ds = tpm2.get_digest_size(bank_alg)
>> +        self.client.extend_pcr(1, ('X' * ds).encode(), bank_alg=bank_alg)
>>   
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               result = self.client.unseal(self.root_key, blob, auth, handle)
>> @@ -109,14 +128,14 @@ class SmokeTest(unittest.TestCase):
>>   
>>           # Then, extend a PCR that is part of the policy and try to unseal.
>>           # This should fail.
>> -        self.client.extend_pcr(16, ('X' * ds).encode())
>> +        self.client.extend_pcr(16, ('X' * ds).encode(), bank_alg=bank_alg)
>>   
>>           handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>>   
>>           rc = 0
>>   
>>           try:
>> -            self.client.policy_pcr(handle, pcrs)
>> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>>               self.client.policy_password(handle)
>>   
>>               result = self.client.unseal(self.root_key, blob, auth, handle)
