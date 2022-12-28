Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375596585DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiL1SnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 13:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiL1SnP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 13:43:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8812AA0;
        Wed, 28 Dec 2022 10:43:14 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSE7iFr031191;
        Wed, 28 Dec 2022 10:42:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9gNco2OEkZo6pnI45c+3w/MyGd7/Iz7KNbIFyeGJi6Y=;
 b=US+BU8GfPMogD8FOOANDRY600QlfUhf9ZrnShICCv0gP9necVJRx9D6DNgiYayimHPON
 RtCV1W5gRqmyGg8QVSEgp12yEsuoaTdPDATibq1gpqWWizA356ao6Q6v1MPt0mOzA6D0
 V8VmDVxI0h9XolNi4sM4PAD8SsAF5Vq6dXCUAqA2ns7yzMFUE6DvXtAPpmysPPJ6W5XT
 NK1ahayjdstCtFP1TSX5yPAqYnKzg5dnjwOqiXjW7Jo87XIYx+6r7QLnPaOmIq17+yh4
 4xuT7Eep2nnRC744dPiyBd51CtjN7UdjpamGVtBurI5W+Zpq4xnWa5nghmhj88LdMCIK sg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mp00umm0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 10:42:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVojTHuU6omht8T/tJ/EtnaSP0EKhg6iaWoCpdqFjdgMMWGbSMTU+snyj3OuTv4UqJ3GkstyEsd6jxc0zgS4L20fc0/zOXVtZewF13IBnQy8Md5HEf3lvSwd4cC9vKrPNgQYHZkfx5VmyJLOeVAoppRL9wSW8yHZMOLLHWCcTsUPdd8aYDrwOuXHpUW09SDel9VajdG0xKHxHdRgq5ya5sfxDH/4n6i0CAWrMTNwa7Egvd2bBCs9XlF2J5xdPRKCXdFKoKDNsyEq7s3ybspU4Lhb6zWcGCHB8vZsZgfVQvL+pxuSIMksb7cWEbKlQzhxfzjplz467IVqRH7bFk97rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gNco2OEkZo6pnI45c+3w/MyGd7/Iz7KNbIFyeGJi6Y=;
 b=h6NKR+PkW5Z09Zp6eHm4Fvb8+jwOYpvGI6tN+wgyoV72ni3SRGDcMv4Q3qSptkIuh4P6QEWpzqW0l8U83pK2lPbyqTKNxxUAA/Un+jqUMvNqPTNWhAHlGOZAgJYSUBlV1kv6zomSqn6qScmUOsBvTnt584dwg8NoDKU/Kb9PWnzuXBoEduJS8FqckfdGEaTUPbALaeiUdDpDSLtKqi1WQIVCpU9BCeNXM9i3NKDkaYn5i0rdfFoB8evvWbdBg2em4TWT9r5YnxRVesfwfoFlgIJWs9e6vM5ryJ0WHY4BHohM9QsHyswgwGJPidZUcJ7FE3lvdbRP5NwZny0IaD5tTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5125.namprd15.prod.outlook.com (2603:10b6:510:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.15; Wed, 28 Dec
 2022 18:42:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 18:42:42 +0000
Message-ID: <6ba9832d-d7a6-9bfa-324c-c8cbc57fe8aa@meta.com>
Date:   Wed, 28 Dec 2022 10:42:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] selftests/bpf: move struct definitions out of
 function params
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20221221055856.2786043-1-james.hilliard1@gmail.com>
 <CAEf4BzZFgOksVucYDq1ZzPWTBZV0zHtK0H4U0LVEtz19nzbpVg@mail.gmail.com>
 <CADvTj4o4RvmjQrO4tjfUf0=Pw7teWmsR_toNSJjWivhD5ukK6g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CADvTj4o4RvmjQrO4tjfUf0=Pw7teWmsR_toNSJjWivhD5ukK6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ec919b-0518-40f5-46a5-08dae9034dcc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WC1YHLJkktWcBY+D6TjOhDU2tzcLzKgyPKnsP7r59bsr7eBw1DhomjicqHJopN1zBzwHXzznWp+LmCmycWX6xISd7yjXaHSTYhaL/rJz0p83Xt4TzZ6QgrFeUsoog8S8gCaJMyzmbTxEn8ZDsNTbk1ydvbYs438H1G93zNsrpxRVBC5TyC0N+U+gO9b/Tpm1JQMyq+hPXXphvs6l4M0yENIVFvs0IpDeoD1je9r+OA9D0SPSCUy5xDTXvm3urvYLZAt5JRQ5k53QfOroXsxTmoVdWDK51T9VQ2LXt4buwlfnPWiJwmdQEON8NS/WHzgVAj63/hFZ6ysEArQ/rzNW/Yr3K1gaXMAQfZ6BkBDHnuyaxMfI2jBsModjYvFAhmekDb5Ip+FXehGTA5ErApxLyvhZZBnjjWP0O/nkkxFxwev9Aq8Zbp73R48iBDOByir+wLmtmOnJ3unCD7sGdULJZmORHVuthr4Qe2uPg6gfVS5yrTXuzKXeW0AMQnDek+rDmjvpzsVAONYGuI3vSoISlfiO6HvFdLMH3HsRMQGSyYK+04a+UGrGPLD51HrZwNr1JZdxqGWV9Vfi9+lS1tBUqOqCja269a4wT5YV+nO/xAiloL8apPIW4o7hF6DZ+AVL6evqQVbSN334JbV7cRVfGF3AjcApQ4ZnlrZb/1TbrtBRTpDnIlAiItCxf5eR/veF9+CFlxfGM1FcoN8nBdLXfXqOB9P+VDYYObod/M2LkkQFq0848d9pHFHcxR7Pa/NBoV7Elyvdmfn5PTQpdMpgV7aDGYwxRfCzUB1x81Ws+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(6486002)(110136005)(478600001)(966005)(6666004)(2906002)(54906003)(316002)(36756003)(38100700002)(53546011)(83380400001)(86362001)(2616005)(186003)(6512007)(6506007)(31696002)(7416002)(5660300002)(31686004)(8676002)(4326008)(66556008)(8936002)(66946007)(66476007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3V2UmZvd3Z3ZDQvTnNkUHBKTFk4TUVSV2N6OW13UCtub0VDdWdjeXRuNW16?=
 =?utf-8?B?dCsvNmFZS1JlR3lHT2thRUtqTlUvd2FsaFFKVS9uRHA3RDVQMi93WFRZR0Vw?=
 =?utf-8?B?SEdPb0F6Mzd1U3dMNlVPaWVQKzFHWmdCOUtnS2VMbjVUOFB0VUo5bnM4NW4v?=
 =?utf-8?B?M2d1a0xNYWhESUtFVWg0WUh5amRTcXNHcUpGWG5qbXJWRFNnZWFIL1dDbkZ2?=
 =?utf-8?B?VXFYYmh4NFR3cHI2ckVZMWlndkUzbzQ1dWtWbmE0RGNSV0d5YVJSa3o3YjFl?=
 =?utf-8?B?SUFZVjR5QWhXc2U3NTF3dG05UnhtSFczRldXTDl6NXgzV0JFTit3bjZvTkkw?=
 =?utf-8?B?WTdyOW05K3IwNGJqOHovTjk4eitrME9KTDF3aEZva2wxYjBZVnpFb1J5VjJj?=
 =?utf-8?B?bGh4ekcyaHhOK1ZUc1dMN0wzTFo1Q0NjZHFIa0M0ZGVHNGVMWHptcUlLd1l2?=
 =?utf-8?B?R0VnVWVhdzN3cHhlODdJRXRDMm1XdHhHaTZyQlpDeHZGbmQ2K0REaFBNM1Jq?=
 =?utf-8?B?aVFWNHpJbWFNNVQya082cUtPSVFLVzlKMHRZOHJuSS8xWDNna2tBUGlHV05D?=
 =?utf-8?B?UzlUQTVDYmFQVWtHaU9lY1YzWEN4NlJOZ2xYMGRXUDFLVjhVNkpybEViZEJD?=
 =?utf-8?B?cVV0MTVqZE93MUVhVWRzaG9tS0lPSWJQakpBOFRlZG54SGNYMmF2M3hHemJU?=
 =?utf-8?B?YlY2blUwcDhwUmFwSkwyWlVEVXRSdlVvNURGaWViTDFlbHNEYjdGWGpKMWdQ?=
 =?utf-8?B?NUJia0VmZm5icVNXQStKaWw2VW5oM2hNWDVQUlB3TCs5ZnJ2N0RlZkRhcVQr?=
 =?utf-8?B?N09rODV2cnRablNjbUVra0pBU2tzVXR6LzlkVHFtVmdTZ240OGhNcXJBM3lr?=
 =?utf-8?B?Q3pRZG01K2NoN2NLTWNyTjBhSklOZVA0Q2xubkY1eHl3SXlhMzYyWCtsdzZ5?=
 =?utf-8?B?dll0OWgrcDRGWGR0VEwzcDJEeVFzbFFmNUhON1ljdDZ4YmQ4aDNZMkpvSStB?=
 =?utf-8?B?OW5ySm01eElaVDZJeVlhYjJ2Z1MrcmFPaUJpWGpJcExvckRsSFhQZEtpVW5m?=
 =?utf-8?B?S3hYaldka2ZoREVxOVhYNEt3c2VFa1phS0p0T0h1aW5yZlhwZk1ZMXcxRTJo?=
 =?utf-8?B?SWRlU3M0Sk12c2t1akNjM2hLQjJud0RKdisyWXNka2VmTmZ3UWNkdEF1TGhP?=
 =?utf-8?B?eXZYS0dqa3NpV3FPUGxRTTFxMjNCR25jQXhNbTVXK0NpR2IxQ09kaFVEaldN?=
 =?utf-8?B?bmVvU3hqZGVsQXJVN3c1LzhTa3dKKzlsaTl6YVQyMFlicXR5azhDcHBJNHNi?=
 =?utf-8?B?azVzRVN1QlMwUnF6MW9RWG1EcldSV0x0UlFZRCtJcS9Nb1dMS29KeVplTTAz?=
 =?utf-8?B?aGNxQnlrdXlHZlZ5SGtKQUZDYWZQTUw4ZXAxdnRCcEVKakFEUVEweEM3L3Zl?=
 =?utf-8?B?QThHVjE3THhqem96aHR4aWRUVkNLT2ZZSlUvVzNJOGJGQU1YZXdDZVFTM3pO?=
 =?utf-8?B?aDgzL3hvT0dSc2ZXU09sQ25NeEdlNWlWMFJFdCtNZHQ0ck9VY0M3Y2pCOFFv?=
 =?utf-8?B?MGtNRGNoSnRKRVNuQjVUMHhjKzJoOE5ZWXNtb2traFE1Q0R4VGNsSjFLRkQ1?=
 =?utf-8?B?QzRaNGc1b0I2eENaak1naDROYlROUGJHQXpDMTMvVlErZTduVE1xQ2VhVWdU?=
 =?utf-8?B?R0VZdTMzRnQzd2NzQUNsYWNwd0hWRTByOHBEdzdidGQ5MkhBMjdsZFQ1NGFa?=
 =?utf-8?B?d00zTFRsdWlFeXlvVFhZZnQyZDVLV3dqTnI3VjdHWjc3L3ZjQU4xN3dINXZv?=
 =?utf-8?B?QXdiN0tacGNOREx5V0p3V2tSVDV5TXc1VWJjYzdoTEdvbUtJdmgxaEk1bVNa?=
 =?utf-8?B?MElqV0hORENBTEZmMTV2czJCdEdud24vcUVML1N2aTlISlpxclI3THZxbHpR?=
 =?utf-8?B?VWpvK3Yyd1hsVEdhbmVVZUphb0MrZXA5THEvMmpBWCtJam5MdUlpSm42dm9l?=
 =?utf-8?B?dHhWV3hTSExQbFBISTZxSEZaU0pKT3RyajZvbVNJR1FIYVU4TGNxSlFKM3JF?=
 =?utf-8?B?a3Q4RWlyVHRnUUlZd3pxMmNJZXVmVEhnTmV3dHdwNEhReWoxY1pFcDN4c3l5?=
 =?utf-8?B?SlJ1dW9UQkJVWlJSUlhscEh2bUdIT0Y0aWNrOTdWbUVFZTVaS2pDRTNoMzBo?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ec919b-0518-40f5-46a5-08dae9034dcc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 18:42:42.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b3ZCNMICmXHJFZLurgwji8hC33hETEy11YFtQw3DKrVYVyMg3atoMPRobPEgYZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5125
X-Proofpoint-GUID: 9zM-fJvOm7aTNr2f7xsywkwucpZb3nLp
X-Proofpoint-ORIG-GUID: 9zM-fJvOm7aTNr2f7xsywkwucpZb3nLp
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_13,2022-12-28_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 12/22/22 11:26 AM, James Hilliard wrote:
> On Thu, Dec 22, 2022 at 12:04 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Dec 20, 2022 at 9:59 PM James Hilliard
>> <james.hilliard1@gmail.com> wrote:
>>>
>>> Anonymous structs can't be declared inside function parameter
>>> definitions in current c standards, however clang doesn't detect this
>>> condition currently while GCC does.
>>>
>>> Details: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108189
>>>
>>> Fixes errors like:
>>> progs/btf_dump_test_case_bitfields.c:85:7: error: anonymous struct declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>>     85 | int f(struct {
>>>        |       ^~~~~~
>>>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>> ---
>>>   .../bpf/progs/btf_dump_test_case_bitfields.c  |  9 ++++--
>>>   .../progs/btf_dump_test_case_namespacing.c    | 10 ++++---
>>>   .../bpf/progs/btf_dump_test_case_packing.c    | 10 ++++---
>>>   .../bpf/progs/btf_dump_test_case_padding.c    | 10 ++++---
>>>   .../bpf/progs/btf_dump_test_case_syntax.c     | 30 +++++++++++++------
>>>   5 files changed, 46 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
>>> index e01690618e1e..c75f6bd06a49 100644
>>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
>>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
>>> @@ -82,11 +82,16 @@ struct bitfield_flushed {
>>>          long b: 16;
>>>   };
>>>
>>> -int f(struct {
>>> +/* ----- START-EXPECTED-OUTPUT ----- */
>>> +struct root_struct {
>>
>> there is no need to make this struct part of expected output, just
>> keep it next to f?
> 
> Seems to be required as the diff check fails otherwise.
> 
>>
>>
>>>          struct bitfields_only_mixed_types _1;
>>>          struct bitfield_mixed_with_others _2;
>>>          struct bitfield_flushed _3;
>>> -} *_)
>>> +};
>>> +
>>> +/* ------ END-EXPECTED-OUTPUT ------ */
>>> +
>>> +int f(struct root_struct *_)
>>>   {
>>>          return 0;
>>>   }
>>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
>>> index 92a4ad428710..d7cf2a8487c9 100644
>>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
>>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
>>> @@ -49,9 +49,7 @@ typedef int Y;
>>>
>>>   typedef int Z;
>>>
>>> -/*------ END-EXPECTED-OUTPUT ------ */
>>> -
>>> -int f(struct {
>>> +struct root_struct {
>>>          struct S _1;
>>>          S _2;
>>>          union U _3;
>>> @@ -67,7 +65,11 @@ int f(struct {
>>>          X xx;
>>>          Y yy;
>>>          Z zz;
>>> -} *_)
>>> +};
>>
>> same, that struct is only to preserve all the referenced types, so
>> keep it hidden from the output
> 
> I wasn't able to find a way to keep it out of the output.
> 
> The other tests with a root_struct seem to always have it in the output:
> https://github.com/torvalds/linux/blob/v6.1/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c#L21-L28
> https://github.com/torvalds/linux/blob/v6.1/tools/testing/selftests/bpf/progs/btf_dump_test_case_ordering.c#L50-L56
> https://github.com/torvalds/linux/blob/v6.1/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c#L222-L237
> 
>>
>>> +
>>> +/*------ END-EXPECTED-OUTPUT ------ */
>>> +
>>> +int f(struct root_struct *_)
>>>   {
>>>          return 0;
>>>   }
>>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
>>> index 7998f27df7dd..e039ceb50c43 100644
>>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
>>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
>>> @@ -132,9 +132,7 @@ struct outer_packed_struct {
>>>          struct nested_packed_struct b;
>>>   } __attribute__((packed));
>>>
>>> -/* ------ END-EXPECTED-OUTPUT ------ */
>>> -
>>> -int f(struct {
>>> +struct root_struct {
>>>          struct packed_trailing_space _1;
>>>          struct non_packed_trailing_space _2;
>>>          struct packed_fields _3;
>>> @@ -147,7 +145,11 @@ int f(struct {
>>>          struct usb_host_endpoint _10;
>>>          struct outer_nonpacked_struct _11;
>>>          struct outer_packed_struct _12;
>>> -} *_)
>>> +};
>>> +
>>> +/* ------ END-EXPECTED-OUTPUT ------ */
>>> +
>>> +int f(struct root_struct *_)
>>>   {
>>>          return 0;
>>>   }
>>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
>>> index 79276fbe454a..2ca46ad8d66a 100644
>>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
>>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
>>> @@ -220,9 +220,7 @@ struct outer_mixed_but_unpacked {
>>>          struct nested_packed b2;
>>>   };
>>>
>>> -/* ------ END-EXPECTED-OUTPUT ------ */
>>> -
>>> -int f(struct {
>>> +struct root_struct {
>>>          struct padded_implicitly _1;
>>>          struct padded_explicitly _2;
>>>          struct padded_a_lot _3;
>>> @@ -243,7 +241,11 @@ int f(struct {
>>>          struct ib_wc _201;
>>>          struct acpi_object_method _202;
>>>          struct outer_mixed_but_unpacked _203;
>>> -} *_)
>>> +} __attribute__((packed));
>>> +
>>> +/* ------ END-EXPECTED-OUTPUT ------ */
>>> +
>>> +int f(struct root_struct *_)
>>>   {
>>>          return 0;
>>>   }
>>> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
>>> index 26fffb02ed10..3e31df7cecc6 100644
>>> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
>>> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
>>> @@ -104,24 +104,24 @@ typedef void (*printf_fn_t)(const char *, ...);
>>>    *   typedef const fn_output_inner_t fn_ptr_arr2_t[5];
>>>    */
>>>   /* ----- START-EXPECTED-OUTPUT ----- */
>>> -typedef char * const * (*fn_ptr2_t)(struct {
>>> -       int a;
>>> -}, int (*)(int));
>>> +struct struct_a;
>>> +
>>> +typedef char * const * (*fn_ptr2_t)(struct struct_a, int (*)(int));
>>> +
>>> +struct struct_c;
>>> +
>>> +struct struct_h;
>>>
>>>   typedef struct {
>>>          int a;
>>> -       void (*b)(int, struct {
>>> -               int c;
>>> -       }, union {
>>> +       void (*b)(int, struct struct_c, union {
>>>                  char d;
>>>                  int e[5];
>>>          });
>>>   } (*fn_complex_t)(union {
>>>          void *f;
>>>          char g[16];
>>> -}, struct {
>>> -       int h;
>>> -});
>>> +}, struct struct_h);
>>
>> these do test some pieces of libbpf's btf_dump logic, so I'm way more
>> reluctant to remove these. If I understand correctly, this syntax will
>> be eventually supported by GCC, so is there any way to keep these
>> examples as is by requiring C23 mode or something? Or just skipping
>> compiling this one if GCC is used?
> 
> I'm not sure, I'm having trouble finding a description in the C23 specification,
> I presume if it is in there then GCC will eventually support it.
> 
> Maybe just keep the root_struct changes for now and hold off on this until
> it's clarified that this is valid C23 code or not?
> 
> At the moment it appears there's a clang bug here as it shouldn't be valid
> C17 code(which AFAIU is clang's default).

Looks like clang supports anonymous struct parameter all the way back to 
c89. I tried clang12 and latest clang16.

$ cat t.c
typedef char * const * (*fn_ptr2_t)(struct {
         int a;
}, int (*)(int));
fn_ptr2_t h;
$ clang -S -emit-llvm -g -std=c89 t.c
$ clang -S -emit-llvm -g -std=c11 t.c
$ clang -S -emit-llvm -g -std=c17 t.c
]$ clang -S -emit-llvm -g t.c
$ gcc -v -S t.c
...
GNU C17 (GCC) version 8.5.0 20210514 (Red Hat 8.5.0-17) 
(x86_64-redhat-linux)
...
t.c:1:37: warning: anonymous struct declared inside parameter list will 
not be visible outside of this definition or declaration
  typedef char * const * (*fn_ptr2_t)(struct {
                                      ^~~~~~
...

I agree that we should understand better about standard requirement
before making the change.

> 
>>
>>>
>>>   typedef void (* (*signal_t)(int, void (*)(int)))(int);
>>>
>>> @@ -272,6 +272,18 @@ struct root_struct {
>>>          struct float_struct _15;
>>>   };
>>>
>>> +struct struct_a {
>>> +       int a;
>>> +};
>>> +
>>> +struct struct_h {
>>> +       int h;
>>> +};
>>> +
>>> +struct struct_c {
>>> +       int c;
>>> +};
>>> +
>>>   /* ------ END-EXPECTED-OUTPUT ------ */
>>>
>>>   int f(struct root_struct *s)
>>> --
>>> 2.34.1
>>>
