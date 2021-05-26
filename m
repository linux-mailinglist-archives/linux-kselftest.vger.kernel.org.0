Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6765391C72
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhEZPxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 11:53:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52474 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232769AbhEZPxr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 11:53:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QFgpQl028635;
        Wed, 26 May 2021 15:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=su/BLzALfgH3BbHzewjIuzZ49G0u4Wj+z3V2N79tHBA=;
 b=JtkqZOLuHHvLdfYdukmJTGVmjBWSkhm1frpJoD+NJ5IIqxt93eYK6Fd7eQe9XkMTRw80
 FFcRZSIwxqkLwTxn3Lj8cimryEQm+83Mrr542X5w/vXNUhqbdPowyXvWJpb0Blw6LAuz
 upynauxhW9mk3uxWvAUTE1uwag/JueiH3+cLU3mx7vizhKZ/Mj4H3KoQncj5j3f24f/z
 d26IsTNzHluJ00wNpKxtzqqG5QHZItLrkOhnNn85XJh8PPYtjOqslosGnNY+nAxKVaJU
 aFa8oAHZbzMRPNV4PQQoGYQcmkK0mTQIWeCjcJXc6brsjDN5npOijhBBdctf4t8yjqKL QQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38smut036t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 15:50:36 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14QFoZeJ005782;
        Wed, 26 May 2021 15:50:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 38qbqtdhvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 15:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCZagyyuiPrvA0fK2klbyPWaTWp7Eil5tO1nCRvTb/MVZdqFAflM16KfPfP40jjrrXrH2Yqx0W1XGsPBTr7WC20ivz/7ZlMcvl1rkQlRy/flskvVzZBupvjYTHc8TUHColw5MDWhHKPiXNgViYczOmlu0t6V16k9Pt+6dZQOBQjXj2Skl1SWirqZXntw0zLZ7uThcJ88jaW72mZ5Z3zdikhROwDrDs87jp0jR4Jw9R0d6ZeIzkrhACkAUbVUY3FTxSerIgBfCzw5zEKxIs3T4feWAEzU8KxiMJqY0Vuxdvt229c7H74swMPKKleVmZ3PA4keBFLMKaQK8zGWwGT93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su/BLzALfgH3BbHzewjIuzZ49G0u4Wj+z3V2N79tHBA=;
 b=RaMvtict9ijMsRxmjBksnmh1ZAhBCJ4ERJlCiX9NA81ThTP4Eli/5IiM+CM0VXuqadm39GtFc32GawgVV/N3ypeGzvQLS7dKUXS4tLcNQVfKzZMaM8Ezd87zRmFeHlcCBwgzQrkdZIP5CUFcBohAGcvww6Uh03D6s5DhLDjpm9BteG7Ye43lZvhTlcRj8jdhAZ2NMnS0/2tp/ZFE4CXldcp2o9sYRBtWw5XqqkatFpEljf6rwGHiGcLVoAhikw+wS12g2O9nFYlVVov2Cpzr4IejmvZ1NPfiMdEwda/jLqc7/NTAHy0I0BsKfXUOtqzGn714uEZYoWlm7aCon384Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su/BLzALfgH3BbHzewjIuzZ49G0u4Wj+z3V2N79tHBA=;
 b=HHhKTPAF+P86qRBjPeAmDz5uiVzlBHLAvFX2FeJwTlJYwwqXF4KAb9W0EiNCte1rG1/m3zezzeEbVmQF1nPrTb42X3WcnItl4jxRoSC7x+5okBYe6kaUTqIzH56YUYkaJEvBuPZ3NJj1vZCe1lebiUk/Ui4bhCI4iNsyVKgYDk4=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH0PR10MB5370.namprd10.prod.outlook.com (2603:10b6:610:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 15:50:32 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517%5]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 15:50:32 +0000
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Babu Moger <babu.moger@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, shuah@kernel.org, jroedel@suse.de,
        ubizjak@gmail.com, viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, rppt@kernel.org, Fan_Yang@sjtu.edu.cn,
        anshuman.khandual@arm.com, b.thiel@posteo.de, jgross@suse.com,
        keescook@chromium.org, seanjc@google.com, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        0x7f454c46@gmail.com, jhubbard@nvidia.com, sandipan@linux.ibm.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        suxingxing@loongson.cn, harish@linux.ibm.com,
        rong.a.chen@intel.com, linuxram@us.ibm.com, bauerman@linux.ibm.com
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
 <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
 <a4f6b80d-8546-09dc-7435-25b3d890aace@amd.com>
 <e0dbd490-0209-9f74-36b7-c55992060b44@intel.com>
 <ab564da6-1029-1dab-d54e-a266a623974f@amd.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <036bd3d8-d6fb-db0f-c4f1-6b2a4a104191@oracle.com>
Date:   Wed, 26 May 2021 10:50:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <ab564da6-1029-1dab-d54e-a266a623974f@amd.com>
Content-Type: multipart/mixed;
 boundary="------------399C47FFBC2862C83C803AF4"
Content-Language: en-US
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SN1PR12CA0110.namprd12.prod.outlook.com
 (2603:10b6:802:21::45) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SN1PR12CA0110.namprd12.prod.outlook.com (2603:10b6:802:21::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 15:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99969c23-e670-419f-80f5-08d9205dfe11
X-MS-TrafficTypeDiagnostic: CH0PR10MB5370:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5370B0B14DEC3BFC10118E4687249@CH0PR10MB5370.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jpuXriaWhjWe7FEsyhHK0WY6BoaUGkRLGtPj9Hs5g289os53vSVYD/DuYJYuZZ+5WOHacKUQf7Yjc+sBcPWmo9cOPl7FHoRnbILRgr86bQXfR0wiAuPTuV8ogvQs3997tVgK/ZNM3pYrRJJMkXuuj1hg4LwaXshMu12JatZ+Rrwp4ot7vba5dxLfhJlanBSQvSuzc7BgFxOhTGCvDYcObU5YsuP99aaSOXX0XSOlPvbznRZkK3jhKh8RDTKzJeXm+bwlOfHGug0V9uYWrm2spaek9JIhlNMsGL0I8WitZ2uoAQJHmf2vq+9arGcd7ZcENM6O2pleVbjfebzYEgCxtTgho96g+KiK0J5vtWZ3vQWMCxKHYWizl2PDplmFfjMX5tDLXc2nnc3iA+bcMQDnNHIQSlFoNhN89E9ITOPidpCyVC7VLb8DqkVbAwJ006BapTauSFUUmNUDkCOQBZRaCn+dBmcXYaGoKa4fBfj4rIFzWs24xLQuLLBuNhkBgvxBGV6pbIPwOzW+HbrlxiyRBHVEIkAwboGAeByL29jYR+7eXUL/F1nx1fYhAmAJHeQELOpzZCJzeNx3G1wgUj9RyUYnw6kXXhkIMLBh5piT1loOe8/gALYpaewC2W+Huo/TrzbRqaYcMoopukFsY1NC3SBA6GU4xHblP0ba4Itk8cXgwr3E6FPud+SgZccDxpWg1hEkmw/U/tdbpyDtA1Z34vRkldO3yRD/vq6HJWrmw5vEopDkFSAOd5i1MOwmKAJnOqe108ecaNDTzLk2YSaOuSwHuzuGHP4Pdty2eQLAm/CwzTFxKRJVkNURMDuFvFWmpdU8Sru8gcZooUc+kPPAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(16576012)(235185007)(2906002)(7416002)(316002)(44832011)(16526019)(186003)(2616005)(966005)(110136005)(956004)(6486002)(5660300002)(478600001)(31686004)(8676002)(8936002)(86362001)(38100700002)(26005)(66556008)(31696002)(66476007)(66616009)(4326008)(36756003)(53546011)(7406005)(66946007)(10126625002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?VSW7uWw6z7C3YeEESE0VQBTU9gMrTQtyyIfVrahMIJy1OeKvvc3oxVNp?=
 =?Windows-1252?Q?y3yabRVPnljJJMSZJQdpoD0VNGYUa6P8ur/4DRHMbX9YpQ6MkanT/6Yu?=
 =?Windows-1252?Q?KJjm6UHFpIPZ2UT70Qp0YJc1jINCkZEak98ckeY/Ij2aE2SLEqa9kjbF?=
 =?Windows-1252?Q?890X8cGxVLolqcV5/EiKeKQZU6cciBGg5JxLZbmq6N8WYFXCkwe3KbsB?=
 =?Windows-1252?Q?/kDY0jy1kgb+kwNHnLUkhfu3IX7tcGekt9cQkNtdLIJnjhDwzVSq0xwy?=
 =?Windows-1252?Q?L2ZaDxx+8H7ZdNjXG+qZ69eKmsGiRo4lYK51hu+KT+1POTdVJSmrTUKs?=
 =?Windows-1252?Q?vopVn5Y2ASek8bA6tCnVYXlb3qUsu6h9EGIFLppkLQ1RVOqRjNt+q26J?=
 =?Windows-1252?Q?6Cwq8Yxsx6g9eVnFtTM1hAG6JEpsNoh8y+VjP7gLfIUf4w1n5aeydQB6?=
 =?Windows-1252?Q?0VvbLGxmA1QACVZwsZ6jtScAmB2dcx8THaR+4R5Psaqoxg1OMdsOi3+v?=
 =?Windows-1252?Q?Nw+ZooqNj1T9OhIhqsJaN7+Jnxv5C5Es3MvjGAF7EpPEMiKoSI6uvdo8?=
 =?Windows-1252?Q?Bq127r6T3QQqrXiNcBEzUNb1O4QE5u3b9dHAPWhTiMzpLUmbeni5q84c?=
 =?Windows-1252?Q?w0Ap2vkYD8wjqyRenYzQS0O7bktIN1F7BZlWaxO/yzso+mc1rC1ZwqjI?=
 =?Windows-1252?Q?/Z/obiyAlKsCdNxAeNAoKJg3NQ+smRpPgVaQPRGEoft7w7gprWx0G496?=
 =?Windows-1252?Q?OUq9h4HqzTrMg0axzwrJV3hAhPW14IoIB/2rCbE0ZdiQyvWCp+PS0YUL?=
 =?Windows-1252?Q?Ef/oJ8719crplZd88poBIfth2ofpkQsNZ9lwB+vTokBsuwOo6dkHx7in?=
 =?Windows-1252?Q?dZSD1Co0U6g/77wUsRCFd/SY0y0ogepPxGZ4Zn7ichimuXM6F+wcb3Nx?=
 =?Windows-1252?Q?1qewWbm11mtRYUf/6LQH3AmgDc8Kkwoj7pQ7+9uGfGx7nGiLhozoHxxV?=
 =?Windows-1252?Q?gjEnRz/YqcHKH44bqx+XvMPcBQKXaHOVMeu2XwrOUx3tdKnZpmmsfSN9?=
 =?Windows-1252?Q?crspls/hb/pk1X3yNBpJDjNTRcBaq02ObSlq5FuB0xwcUo7TB0vWkxbp?=
 =?Windows-1252?Q?I+1cIb3m9ccviR2yIOmiRPpuSafSIEolPy68iLApABROfSEgIbw+gGFO?=
 =?Windows-1252?Q?vFksPn6XJHtKui4GeDVRbXB7Nh7z9IzForLamvKiozz8m6YRGIQfvItI?=
 =?Windows-1252?Q?zNqv5vWHjF/ms4aHQnhOd7jhDy2W4NB9wn1Ap9O29FTFwzUQpE6gvu4O?=
 =?Windows-1252?Q?ZHDnLapV4zfpn45262FDN+cnnrhhtOwtVsI8wHF57jfSd7aLBPKxwPgq?=
 =?Windows-1252?Q?NVlP+a1hWy9OUKjBf4uYJ12JSVc0eu94m7I8abIX+qwHwCKlyB7Ui+w2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99969c23-e670-419f-80f5-08d9205dfe11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 15:50:31.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXrFFwmHR3aHDCOYdQAgmyrCVMi1Ha4Aw2AVQZPL5gB/toZ5ZWtdTKfJUJ+glQb+18jhgpmdobegIQaAX8K5dzD6vjm378OUF9uzGOs8tWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5370
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260106
X-Proofpoint-ORIG-GUID: 1Yw0Dvc7LzgnyoJ1a1btGsyRaNSiBahv
X-Proofpoint-GUID: 1Yw0Dvc7LzgnyoJ1a1btGsyRaNSiBahv
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--------------399C47FFBC2862C83C803AF4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/21 10:25 AM, Babu Moger wrote:
> 
> 
> On 5/25/21 7:20 PM, Dave Hansen wrote:
>> On 5/25/21 5:03 PM, Babu Moger wrote:
>>>> What values do PKRU and the shadow have when the test fails?  Is PKRU 0?
>>> It goes back to default value 0x55555554. The test is expecting it to be
>>> 0. Printed them below.
>>>
>>> test_ptrace_of_child()::1346, pkey_reg: 0x0000000055555554 shadow:
>>> 0000000000000000
>>> protection_keys_64: pkey-helpers.h:127: _read_pkey_reg: Assertion
>>> `pkey_reg == shadow_pkey_reg' failed.
>>
>> That's backwards (shadow vs pkru) from what I was expecting.
>>
>> Can you turn on all the debuging?
>>
>> Just compile with -DDEBUG_LEVEL=5
>>
> 
> 
> Copied the logs at https://pastebin.com/gtQiHg8Q

I think this failed early due to the debug code. I have a patch that 
gets around this.

--------------399C47FFBC2862C83C803AF4
Content-Type: text/x-patch; charset=UTF-8;
 name="selftests_vm_pkeys_fix_assert.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selftests_vm_pkeys_fix_assert.patch"

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH] selftests/vm/pkeys: fix assert when DEBUG_LEVEL is set to 2
Date: Mon, 12 Apr 2021 17:13:31 -0500

test_implicit_mprotect_exec_only_memory() hits an assert in
_read_pkey_reg() when DEBUG_LEVEL=2.

test 12 starting with pkey: 2
doing malloc_pkey_anon_huge(size=4096, prot=0x3, pkey=2)
new_nr_records: 1
new_size: 24
sys_mprotect_pkey(0x0x7f44144bb000, 400000, prot=3, pkey=2)
mprotect_pkey(0x7f44144bb000, 400000, prot=0x3, pkey=2) ret: 0
mprotect_pkey()::628, ret: 0 pkey_reg: 0x0000000000000000 shadow: 0x0000000000000000
unaligned protection_keys: pkey-helpers.h:127: _read_pkey_reg: Assertion `pkey_reg == shadow_pkey_reg' failed.

This patch provides one way to fix it. Would it be better to make sure
that shadow_pkey_reg is properly set?

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index fdbb602ecf32..070f6f90dcce 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1449,7 +1449,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
 	pkey_assert(!ret);
 
-	dprintf2("pkey_reg: %016llx\n", read_pkey_reg());
+	dprintf2("pkey_reg: %016llx\n", __read_pkey_reg());
 
 	/* Make sure this is an *instruction* fault */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
-- 
2.31.1


--------------399C47FFBC2862C83C803AF4--
