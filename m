Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763CA462913
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 01:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhK3A3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 19:29:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhK3A3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 19:29:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU07xZZ015197;
        Tue, 30 Nov 2021 00:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iuFClz7+kbeyFS/JDn8ErvHs+egURHv8fQNTm0xzMzc=;
 b=P5T4XtMUSwZFN/EinCb/Jh2TbTRjobad9IoSWFHFBxj4eDtWhLcjkZlVsAw1zTL3764N
 lBZ29rsJXhojsrrshdIJVwSvqQbWyfY07uoi5iEmmkXVQtpdLjiyxRec3bsKiShyq5gS
 49oq8AGXZ1sCcr9bBdqQHCU1uR/+c5zp17w5FUHR6+ZjfncD4fT2/04ho7sLnDT6uPPg
 dr5S9LVS9j9uCBSxdU+Rfht0hdv7/QsrTyQJ3n5Lw6XTP+K5m7mgB3IYYa0bcFUHXzaT
 Fl5deOhKwzNJdLq0E9G7nI+PQ+YyN9n8zihCZzUlQH3TPilt4SzLJMN3vaqStsP6lw9P vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn8u6gjr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 00:26:15 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AU0BI1h026669;
        Tue, 30 Nov 2021 00:26:15 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn8u6gjqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 00:26:15 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AU0Nu3M021215;
        Tue, 30 Nov 2021 00:26:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3ckcabbgjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 00:26:14 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AU0QDjD28770886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 00:26:13 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567F86E052;
        Tue, 30 Nov 2021 00:26:13 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFCAD6E04E;
        Tue, 30 Nov 2021 00:26:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 00:26:12 +0000 (GMT)
Message-ID: <e569444c-e0cd-52bc-308f-7fa457dbf086@linux.ibm.com>
Date:   Mon, 29 Nov 2021 19:26:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/2] selftests: tpm2: Reset the dictionary attack lock
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-3-stefanb@linux.vnet.ibm.com>
 <YaVljk1vLRZ/TDJ/@iki.fi>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YaVljk1vLRZ/TDJ/@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3xHyV2QAq9-2auLXAoor550Y5zY9QN9O
X-Proofpoint-GUID: f6k4syvCm65vhtT--XbDAvwD45Xiadgd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290116
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/29/21 18:43, Jarkko Sakkinen wrote:
> On Sat, Nov 27, 2021 at 11:10:52PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Reset the dictionary attack lock to avoid the following types of test
>> failures after running the test 2 times:
>>
>> ======================================================================
>> ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>    File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_tests.py", line 105, in test_unseal_with_wrong_policy
>>      blob = self.client.seal(self.root_key, data, auth, policy_dig)
>>    File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 620, in seal
>>      rsp = self.send_cmd(cmd)
>>    File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 397, in send_cmd
>>      raise ProtocolError(cc, rc)
>> tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   tools/testing/selftests/tpm2/tpm2_tests.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
>> index e63a37819978..ad6f54c01adf 100644
>> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
>> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
>> @@ -139,6 +139,8 @@ class SmokeTest(unittest.TestCase):
>>           except:
>>               self.client.flush_context(handle)
>>               raise
>> +        finally:
>> +            self.client.reset_da_lock()
>>   
>>           self.assertEqual(rc, tpm2.TPM2_RC_POLICY_FAIL)
>>   
>> -- 
>> 2.31.1
>>
> I don't agree with this as a DA lock has legit use. This would be adequate
> for systems dedicated for kernel testing only.

The problem is this particular test case I am patching here causes the 
above test failures upon rerun. We are testing the driver here 
presumably and not the TPM2, so I think we should leave the TPM2 as 
cleaned up as possible, thus my suggestion is to reset the DA lock and 
we won't hear any complaints after that.


> We could make this available in the folder where TPM2 tests are:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-scripts.git/tree/tpm2-reset-da-lock


The tss packages also have command line tools to reset the DA lock, but 
it shouldn't be necessary to use them after running a **driver** test case.


    stefan


>
> /Jarkko
