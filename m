Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2A44234E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 23:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKAWYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 18:24:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31552 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232280AbhKAWYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 18:24:13 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GoVqn004904;
        Mon, 1 Nov 2021 15:21:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=43Z89EWGui1MrgvPjTDVFiqylFZRXD8jsLtbOYUsX+g=;
 b=ot+qW8DkCBWJ561bU8tyk/KqEtnPGjUvpNpnCsxHnE4XHz+w4riwWfVP24pdAQwsp05Q
 2T25O9TjzlEGBefGblavFBSvhBDcf7IcT8GaO2WZFZp3x+CqvLQZc3JWKceO8rHv440X
 5iUtE0BkJPmHkWZHEAOQQSVcwJOgJ2eZbYU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2gryusp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Nov 2021 15:21:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 15:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFHzbd55G5mDqUhcZuJsbqtwGkESNktgBdHp5veCCIEjl3R7N0zsEeBieRpDphfClyPVb+ICoj5pFEyFH+fe+BBbLdayusQRSkURFbmePeO3y2vRi6EWOkTfYRe5pk6m8h1HV57v/QmcELkpsQ8TaOq+wMMtoeDazJGQJ68KIndkuOaNRXmf5xYubRwkQSCQgfsV9bbUc63OOOJ+HfqLjcpyoDiMyRbK9DFn3Q+epsHG9HmtaPpJsUM/dHgwmacL7stNvjVR6GSPeiDaxPbUPXc1RtxUyF/HhOlrFaYac35ddimrYXKQYCU4A4nARLEsllwv74WZGyLWfXLIG33l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Z89EWGui1MrgvPjTDVFiqylFZRXD8jsLtbOYUsX+g=;
 b=lXy+5yYg0T7GSgIb+H5/uPp5+LPFfPPOqYAdQ6HGCxuHP3kyMXpam7/8bJ58xf/TfHnHO1t1/7NmViOitPKFczZ0/fFtdBeHlpvkQlXF/cnJbGU+EF3zPtc9TpAEPvLOwTE8qPJuX4M11jG+gbaytA5iVoiYQ1AB6MZe5oIf00VG1VBvoxTsXdI3qyAgjpJTQqAKnVoHLCVGDM/OdzOtZ9ncPhR+QWyPLdbFkWIOb5OpmF4vIIXTxYW91HmR2rbRlyy7ELFJ/vivuUEITqJncGU1+4AIUxJiqUrGlQMOOi/rbi/eMQpUi5Rxh15ungYz/bNzlp9zylxMqw7mZ3DWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2367.namprd15.prod.outlook.com (2603:10b6:805:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 22:21:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 22:21:24 +0000
Message-ID: <90518c5d-36ea-ec97-9f14-0687fdd6074f@fb.com>
Date:   Mon, 1 Nov 2021 15:21:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH -next v2] bpf/benchs: Fix return value check of
 bpf_program__attach()
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Joanne Koong <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20211101124310.3947887-1-yangyingliang@huawei.com>
 <CAADnVQJS_2St=iaqHU+zasy_0A0bidJN=STnkHrNcSNL5vO1Dg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQJS_2St=iaqHU+zasy_0A0bidJN=STnkHrNcSNL5vO1Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:102:1::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:38d3) by CO2PR04CA0001.namprd04.prod.outlook.com (2603:10b6:102:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 22:21:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0baa856-74e0-4b8e-9e93-08d99d85f0e3
X-MS-TrafficTypeDiagnostic: SN6PR15MB2367:
X-Microsoft-Antispam-PRVS: <SN6PR15MB236759B057027BCBF49F5373D38A9@SN6PR15MB2367.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMt91t8bODsRG0br5+mbzQfELkxx3dJdhdJ3tQo0G16a0rPrwGwH58K77eu2HcikYrNBixW2fmoE11Vn/X188/hXjpTjN8cgEv0z/oVTzU5XfFIavhVncExOpKz1nRijKTHBA5uqayDo3tVO/tCZpH4KT835r4ZhwKHoEdaiOzjuFdAnQzMw3iO27txNnXXmlHOW0NrxIHODF+NRRQbieMGhRSpL4YfukUt7dpXJ1TnB4luntB8rqZPWUJ0Qolvet6hDlqmZn9oXM1ys8cg7bCve8eawnvCE23SyUaGZcFNwd8JPARLp/Dn2Ep6QjpM/Tbg5WkZR8SIoh9nQj9pRvku/I3bwra9PX88pA293rD7MHQTdVhNjIS+agCIaMZQG2D2xZUPdP6izj669mHu9YUc34ABNfMuzswXpM8czHE1JEVqL3O92pb5b00gXqvYf09+YUN+tdvmxI3zs33VK98QCJGQaeuWtq1E+mIM94hzlpCfYQ2kYgkWq0h1vxnHyF36fDGmr7LyPl82PFGLYLHgqgtn9vc27qln7c0c11OyR7EN48z++UJFQLudiMIrLt2ERN5BMx17HQ0IzUofB7zMKKqcUPrFrTYpu9Tn7cAqnXE/jVY92I+Tcbwp0Vt7XUIDR7U+MN4BJ7qngPzB7GtACP9dAOlHW0XAvGdQl9PEj2F3VeoWiCzMt9CBRTfHXyzysKQpmEk5ixSVtzNmFr86c6WsC/E7qIvpLirERXO5hAwsBcX2H0qC0J3JYFSa7MJRBE3LpvVtxO/YLAAVpug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(8936002)(52116002)(53546011)(2906002)(38100700002)(6486002)(83380400001)(110136005)(66556008)(66476007)(66946007)(2616005)(86362001)(54906003)(31686004)(8676002)(186003)(316002)(4326008)(5660300002)(508600001)(36756003)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGVJR1ppOU9IbjY1ZUdzR1hnRXlpZVErU1RhRWlnbE9xYlBHTzVaUjNaWXFy?=
 =?utf-8?B?aGlyMVhFYnlWY290QVdYOFNuc3BrdWRTZXg5ZGNWUC9ySXY1SVI0dXVkSkVG?=
 =?utf-8?B?Y1lpV2RXRlJwakFIc2ZzVzRrRzdSMmN5RVkrNFlISHV2Y21QZnRiTE5WYzhl?=
 =?utf-8?B?UHJZdGF6YS9MZGYwdHBJbmxKZTJKOFRPakxNazlJNjg1RjQrWG05dDlmbml6?=
 =?utf-8?B?NXY4WjdrVXlCbGxrek1PR3NwT0VoUnQvbnJyRGpPeVJYbWtNRjIxaGtHSjJT?=
 =?utf-8?B?MzErclV3cUF4ZnZPdUUrWHhuZml2QXM3MjZZTldLMGRDUUZyNW54aUxsbmww?=
 =?utf-8?B?bEJzdURJWC9ueTBxZkZ3a1ZUQzcrQi91K2JwVmx1NEtZV2ptYzBIU2RPS0Nn?=
 =?utf-8?B?U1YvRm5qTEp2aGZzd2tIUUp5b0c2cGtpd1ZlRVRMUXc4MndHd0I1akZsK0I0?=
 =?utf-8?B?eDdhL2ZGa3h3SWhRZmpFUmpBSDIwdnJGeHRFdDdwVVozMEcxY09Da0IzSks5?=
 =?utf-8?B?d2FKNklvRkYza2hXYkN2ay94V2FQTUdYUkpsblRBbjdUMTUwc0N0VG10NURP?=
 =?utf-8?B?NW9XT0xjS3RDdGdCTDhSOUtEMEl5czdkaGV4SG9HLzNESzRKMjlNVlh1MW9s?=
 =?utf-8?B?ZkFYN1VOYWMvRGVqRnhNTWkxMHpyMzVDeEk5UVFRbnpIVG9mTWxDakZFbFMx?=
 =?utf-8?B?TndBZzIyVlFNM3JzUGVDQWpVWE5SSk15M3JHUUl2QVUrM2dwRGQ3UlkvdGtG?=
 =?utf-8?B?V0FVdzB2YjBIQ1M5STNWVGpqaU1ha0hlblZUVUtzSFNHb2tOQU9TN0FVUENF?=
 =?utf-8?B?aU5nSUZ6ckVqZmRNSmU3RVV4b2VySXgrUklndU44SkpYN0FOMmpxT3l4ZzBC?=
 =?utf-8?B?ZjBpdFF1a1J1dDRwN3hFK094bC9Kd3dDam9FYmRoWXpyRWJlanhxRlJYWWhw?=
 =?utf-8?B?QjArUE9jNkFJbGRkVVVtSkRXU3NRcTB4T3BlYThWa0Q5QVMwZ2JydStBRXJj?=
 =?utf-8?B?TjBjNVRnSEdob202Yk56ZU5ScDZGT28yWGJ3WUpVT2xkcjB4Y2VhMmc2V0Vp?=
 =?utf-8?B?NFNTY0lIeDBiQ1RBcHRZc3N3KzlLV1liNzJsa2p0NS8zelBhQUt4WmtOOEpD?=
 =?utf-8?B?cDFhOHdQOEkzcnhTVkZYdzJxM0xnakh6V0JxYU9yaE1kK09LcnVFdkFVc1U5?=
 =?utf-8?B?SmU0OHdKQURBeTJyL0F4dUd1N2VmUm5JbEVyeWVXTkFXTGN4R2pOTGIzdlB6?=
 =?utf-8?B?U2xnbVVQdmE3NTUrSkZXQ1YwYnVwSHJMd09wUEhFcXRnWW5EOUp6ZHBuUnJ5?=
 =?utf-8?B?VVB1VWRGb3JBdWJvSk01U3kvK2Y4b1VUbllYNG0zaFl0RWtsL1dCcnNTYVRv?=
 =?utf-8?B?aHlVZ0J5enY4Rmt6VnVSWmRLWUtHR055UHB0ZkNIQnc0UlB5WkgzYkxjVTc4?=
 =?utf-8?B?U3VPQmJjNlRwc1hzR3c3STh0REQ2L0xsRFdmU0NtTWxqR2k4M2lUU2JjR2Jq?=
 =?utf-8?B?R3ZWcVRwTTZjOWZPdHpUTnVmTmdmcXZaTnlhWFN3eEVVRng4UmJ1V2pGZXVH?=
 =?utf-8?B?dStpRUMyZW9jbk42YVpWQmFCTEdWb0x2TEQyWU9xc3FxQ2hhMllrY1JVUkJs?=
 =?utf-8?B?TXM1T0JDYWpRTSs3OE9yQnRpU1U4Qi9NUktXYU1XR08vMVB4OGc5VU41UWhx?=
 =?utf-8?B?OGNoTzRPaDdlVXgxWDJ3dE5kM2VOV3BWbnVnRDdEdVRDQ0dPaE1zdXlHNXRh?=
 =?utf-8?B?dldhQUJvak5JVzdjYkFOQmNGamVrUnJtOCtqVWE1ZURwbFc0ZktwQStNeGRJ?=
 =?utf-8?B?cm1pU2svMFhJcElWcXhMQ0FuUm1CNkRrL2wydVRXY2F3WEFwZXBndjYvMUUr?=
 =?utf-8?B?alg5WVVCTnJ1VGNOZDQ1dVE4bFBtVVZPcmpGaHZLTU50RjdZQ25wemZMaWpp?=
 =?utf-8?B?Yko0cDVSbWR3NlVSb2FoYXFsb0lRbDJFR0FDRmdYVnhCQkxaeHlTeks5ZUlh?=
 =?utf-8?B?MjF3WlJjZXpsWHZZZmx6TW1wSUN6djFScTcyaDBEWVB5VFI3L2s1M0NyOW5v?=
 =?utf-8?B?VksycGpyS1hyUm54M3A5dXlSWHBpM29XazBtT2dmaE9kRlJPbHpqUFlHWU51?=
 =?utf-8?Q?1QOF0y6jwlmv4P9htX4fA4HRd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0baa856-74e0-4b8e-9e93-08d99d85f0e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 22:21:24.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V749PTBXUI+XnkwQlrct0HHoOfnjXqAhaQw4XwMZyQ62RAQxrpdDvnfx/ljj6Np8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2367
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tWLJggohAJOsvZKQK5quK_G4TLmp57eI
X-Proofpoint-ORIG-GUID: tWLJggohAJOsvZKQK5quK_G4TLmp57eI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=752 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/1/21 3:00 PM, Alexei Starovoitov wrote:
> On Mon, Nov 1, 2021 at 5:35 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>>
>> If bpf_program__attach() fails, it never returns NULL,
>> we should use libbpf_get_error() to check the return value.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>> v2:
>>    don't use 'int err'
>> ---
>>   .../selftests/bpf/benchs/bench_bloom_filter_map.c      | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>> index 6eeeed2913e6..4afaa4adb327 100644
>> --- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>> +++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>> @@ -304,7 +304,7 @@ static void bloom_lookup_setup(void)
>>          populate_maps();
>>
>>          link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
>> -       if (!link) {
>> +       if (libbpf_get_error(link)) {
> 
> Please use ASSERT_OK_PTR() instead.
> See how other tests are doing it.

I actually looked at this. ASSERT_OK_PTR() is defined in test_progs.h
and test_progs.h is ONLY included in files which eventually linked to
test_progs. That is why I didn't recommend to use ASSERT_OK_PTR().

Maybe it is okay to include test_progs.h in benchs/*.c. Or we may
want to refactor to a separate header file to contain these macros
which can be used for test_progs.h and other applications.

> 
