Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A27501D93
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 23:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiDNVlq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 17:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiDNVlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 17:41:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52956716C3;
        Thu, 14 Apr 2022 14:39:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EIjx9n018804;
        Thu, 14 Apr 2022 21:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u//ICAbBiOxncqgDSNLkBH7j0qd69R+cMUMIxgTIhKo=;
 b=TA2I9iUywjhOt4AJoPB4fvkMrho/PTbk0JMPe0o10v3r5flNjSV6M6fxCqNBYD2rPGUr
 GhgOTsk0FjnCdD4bhB/iaYrJXC17RhT/Loo5OyVyvuofuNzJna76iqrKEbEgSscfw6tC
 yacWZ12VxhqoMFEiimc7U3NNy9WjLRYP54+Z3uFfJ+SsWIiROHgCi+vmq38E48v7aV28
 3HkkgMnwtFyaGjRjnUNn1p8cN+XtrugqAphd3tMj6GC0/P9IBrkN7QwcFGldbTtdzjfs
 //U9kUjnWmmlGQ3psgmsQjQAqzG7uBs6ohBag8/N6LjR/UshsNMRzD1rD3SQFnz0gE+K /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1p3m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 21:39:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23ELWQJe039874;
        Thu, 14 Apr 2022 21:39:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9m5ksa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 21:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGQN8Y/krId2lGjeapvG+krsPwVzP2vXnpbHCRzNJbF9843YZdNBaX+I23NiCf2JscVCQf5SGHDqKVprfXBuXtm5lCWeSFJDrCPSq7nTK01gBJLdPmwfUY8qLuDpdqwnmLAEsWrRXhHJ0xHsgH6Bg3HpE2AEEiQiECFIUqcnaIvThF7vDkbWXuag7KtDfUipt6ic+U/SsdJTocBnEAnsfsp9Lg+OKrb/Lc9xPDN94NujLIrcon5t1B4tghdfC+dubuvyYDV+52/UYZGCuShkBrnGGmpnAqb2HarqwPQpC8iBsS59SuzmIt4fWaSxMPbumK7gVLi8X1EJLTTUjmUvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u//ICAbBiOxncqgDSNLkBH7j0qd69R+cMUMIxgTIhKo=;
 b=KZhgeQAaXgvqqXdiDvjstANweDTDmnlRKj9e7H4JvgvNVtw77yn4ZQDf5V5MBprWbXgtN3ZRPA+pw1mQX89T/0vCrdfsT66H9aDHQENOIZs0lpMZ8xwRBotkj0NkI0Y7jeRdE11sVeN8N830SogUdXSMKkzPvtL8R3OsZ107kttQaBVYQKvyZYq9vbhv+qHrLTGF1mSg3oniN21gBZbb4YW+b851EXHnrrzqA6pAJ3Rk4Uq1OkKb8Z4OtoeuWpQkjc4oJZHpofpdyjWLqGHTdwtliaiUbcjjMS3Gk53RnWSnSMEcjqBpGx85Sn58u9lfAzeYeEcqam8d/lujnBjpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u//ICAbBiOxncqgDSNLkBH7j0qd69R+cMUMIxgTIhKo=;
 b=L7wJQfQbGIw1ajcAjhfpwbGXNf2CPbJbTXvnzOhBN4I7oUrQe+lGCvBOlrGB3iACLjvE1q6QctK9tQ47l9Oz1V9Y+b6dTmmJlppICl1sVtYq8oPSNb8L2DAkYYwTcN657Qy8pa+FMKXIznKMeFPBmteyqXSlFMICiZaEpmup2dw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MWHPR10MB1712.namprd10.prod.outlook.com (2603:10b6:301:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 21:39:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 21:39:03 +0000
Message-ID: <e857188b-1e20-c236-3cb4-7aa7432b7632@oracle.com>
Date:   Thu, 14 Apr 2022 14:39:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/4] selftest/vm: verify mmap addr in mremap_test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-2-sidhartha.kumar@oracle.com>
 <eb48d665-1a8b-50cb-00d5-95d8b8cf5625@linuxfoundation.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <eb48d665-1a8b-50cb-00d5-95d8b8cf5625@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8753550-a602-44f4-4c84-08da1e5f31df
X-MS-TrafficTypeDiagnostic: MWHPR10MB1712:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB171201798B873FC0F46F7B8095EF9@MWHPR10MB1712.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpsbrTS4orBFL4A681986koqvOjhtS01ne50XP6Vpt57bryC8yImjTroJJbjVrdmmwyJSKXr+ueogdChl5OtKMDyoxTI+iX1bIR4+z7smv1jRpOxoO6tg1slVMQbct8H793O0km+27fzkXy7ZaOklKmKo0AZ9tTYaCIX2gdXYvHqlSlz4Yy2J779YijLHV2i+IG04Zen7D8nOMkipzK6czJGO8waYz6l5ELSdbnr5GvLIzfOTIaFKTMEHtQAqEXQ2lRTPat9GA1G75xIRul3Mw6KCda+wDF9CJSIMffzt5iia73F59yP7vbiXxMlFUjgZc41Fi2ZPoVlgH2zUByhBkNgyISn/z9xjo/WeD9WIK/HC62x5rKHeZIlYHzX5v8VyOYB6pPaj4SboRvoZ5AlvsJTn6UIFkJ3m/CgjD+VoSfIfAXQ+HgSv+393sqQ+qROduDmOfjBdJWeqwxUd4vx69Ml3riQuFakpy3pp0CUpdUsvS6SsDS2g0rxxMh4rdRXNe1OYk2FZRVzcRb2IVtvpQJyDFVfR25UipytQ64HklgNYVMlqp53eAbW+8X/k6Ool4qFiXpwHQzKF5PcqNY20FwrDOJv5Jd37tfWWQ2MCZwrvt7CfZDsBgbimnPQH4ObMS+ADvFhbvTopawT4Q1lH5CsEGGBPjrJEBexbK4QBoYRhNFR0cRk+qWVFr1b2PVsZ1QIBKBONGbiiNPRpQaER3o3ViAeCZkhrIhJ0oTA1PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(53546011)(2906002)(6506007)(508600001)(36756003)(8936002)(6512007)(38100700002)(4326008)(86362001)(66946007)(31686004)(186003)(316002)(5660300002)(44832011)(8676002)(2616005)(6486002)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCt6V1I0ZmJpcTBWZ1NmbTZCYzhWYjlaSE1lQnpUdGxxOHUxRXJWZUUvOEV4?=
 =?utf-8?B?RGltZGNQbklsVlcwVmNVUEhaWm8xVFRRM3dkMG5WR0RQWVR2ejhlRWs4T2Y4?=
 =?utf-8?B?ditXMXNUamNnU1p1T1IwYzYwKzJLd3YwSG5McDAycnc3K1p1RzdjMDIyMkNY?=
 =?utf-8?B?NGpuYVZOT3JCQmV0RGNRVDlDSTJQOE80Zlo4RjJqeHFQRVljenFqTlFJSVRO?=
 =?utf-8?B?VUNkRkdzTEQ4MDVFbzB6Unh0dVZVZkhJYSt4b1k0Q3ptVkR3RFZ6TXFKYkU2?=
 =?utf-8?B?YkE2S3k5UXRDYXZQbkErL05hcmNiQU91Tmk1S001QmpmSlYybENkQzZybFl5?=
 =?utf-8?B?aDduaEdZZVBQZ2ZZQXJoVzl5OUpGTlgzL0dWenE5bXZmV3VGek9VQjY0c0xE?=
 =?utf-8?B?aVFFdDZJeGZuMlZBcEV6NXFDNzltSllmUlFacDBvMS8raVdtVkpSQ3FKTTRW?=
 =?utf-8?B?dVFmV3F5bFdES0JTU3F6ZUtSTkp4emtOVlpscTY0UjFkZHRhWk45dXN2VUk2?=
 =?utf-8?B?RkNMRHhzM0gra05wMzlrRWlWQWJsUzJ3Z2t1SjFRbm5MOUFxYnVDQ3p2bTBT?=
 =?utf-8?B?ZnYrYjgzdFNBYXFsNXJhTVJRNWV2MHFLK254TlhhTUU0eUVKdUJoTVA5Lzdn?=
 =?utf-8?B?WTRidlBnNDN4U0NGY0FYN3E2cm42R2FVcUVpc3E5bU1tRlpyZkJSWmhma1k1?=
 =?utf-8?B?U01CNFNxOS84QXg3ZFRpWFpDWGhNazlLVFZhL2RMVjg1Wkt4dXRYR0FvNDQ1?=
 =?utf-8?B?eGVWaUFqMG1Eem9OdnlnNkJUMmt6dnBpWE8xaUxNVnN4aStnRzNlQzlVdXAv?=
 =?utf-8?B?T1h5ck1zZk9EQ0FQU1I5MmZEUmxjM2RCYkJ0djZ0eUhyTFV1bk5JWTR0TXkx?=
 =?utf-8?B?TzYxcyt2bEw0YTZ2NEhMSXJqSUkxdFFvVGFnWkxiSEFZaWVwdk9VS3JabW16?=
 =?utf-8?B?MFhxZ0tIb3JyUWFkR1hGeld0MlpreC9uTk5xRHd6SjZXQmtKT3dETGNtSERv?=
 =?utf-8?B?ODYyak5ub2ZvRmtOVEdqZ1JwNmpvcUc2MFlMY0xYV2tGZTZqSUU5N0dxQ0ZL?=
 =?utf-8?B?YmphUDgxcmNYV2wwNjBsOXJsSndiNG10OWN3K096aG51M1M0eXdkRG5RcEZk?=
 =?utf-8?B?WWJKWTZGcjZFbHFXZndiZVRrOHZZbHV6d3BXMW9pbFkzSzkvR0svM2MvcWJy?=
 =?utf-8?B?dzFSR3BPM0F4cXZlMzVrVk5DM293WTdPUC9DeGhpQ1Z4c3huWmdRYVBvQUNv?=
 =?utf-8?B?MlRqdHc3ZjM4TS9EODhSaWlGVkhuL2xIUzMra243cllQVHhrMEdYUlg2NnQz?=
 =?utf-8?B?OUN6dmoraXQwUk1RREJaV21zMjdXQkdtWVdLUXV6ZGVrTm9taWtIb0dzNzRO?=
 =?utf-8?B?ZElOc2JRZkRGSXB1b1hLNDA5dnh6aHQ3RTFiYnlZVUkrbTAxYUE4RGkvajBi?=
 =?utf-8?B?V1JsZ09rUy82a1UrQzN6c3hSVGQvY1VaNmpvM0hyMUk0NHNYQTZLb0IrN0lP?=
 =?utf-8?B?d0RJdEZwMTdhV2VyZnlNd1E1RnlWUGZKazRlQ3N3Sm4vZEdDUWRjQlcyckVP?=
 =?utf-8?B?WEJlRHpuWnhLNU1mY0l1bW56TmYxMlhSQkNNSC9FMGFJQS9VTFllTGRtYmVm?=
 =?utf-8?B?U0RDYmNPNEU1dklHSHJLV05zZWRnS3VyNUNSa01nVStTM1V5MHdUWVZrNDhq?=
 =?utf-8?B?elR0V0NhVEZVajdzNG9za0pJSUtqU3h6WW04RVpPcXB1anIzdnl1TW55TjFw?=
 =?utf-8?B?THhpaHNUcElyOVM5eDI2b1dzTENhQm9xcEh0cnhlQjdmSVhXMVhLVmI3ak9s?=
 =?utf-8?B?ZFpDSDhOa05uSWNsRllkMFJLVHNXelZLWm1BQXp1b1I1cmt6RWNxTGh0Qk9D?=
 =?utf-8?B?VmptUzI2QTA5aWRwbHJCM3NPS1ZESlVzU0FvWmVFck9BSHd0Y0NCNXM0Tm5i?=
 =?utf-8?B?UlJTdVI4VjNpZ2xEak5kUHdXUkVoL3FVMncvNjN2MUtxRGFCVE51bmxVY2RU?=
 =?utf-8?B?bnNGZVVWQlpzNHJpSjgrK1hZaDZ3UGZCNS9IdVNYZURHYi9vUzdsTy85K21l?=
 =?utf-8?B?eml3ci83WnJROTJCajQzOUNMK3BNdmQ4NHp0T1BiS0sxdHIyK3NRbXY5MnJo?=
 =?utf-8?B?Ry90OXNtSStnbEpvVnloY090dmc5aDJhMkRjaWhLN254Yk9oRHRoQ2U5MVd0?=
 =?utf-8?B?NDArVDc1d2tOS1RnbWRTVVEzWERxSXVGK0ljbmQranFWZVVtNEVPR2lLcFox?=
 =?utf-8?B?OVBCUThpSXFqdUtGck9oeURCdGpkbzVsV3R1WmQ5dmt4Z3NqTE0rOWhtcURj?=
 =?utf-8?B?eERhU0lUSEpuUDFCUno2YWtqUThDVnFZK293UEFLaUpTY1FuVHRSRHpsTUFu?=
 =?utf-8?Q?RcnbuPX6599LEouoDOsRXFDmgQBXsJh+ktVYd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8753550-a602-44f4-4c84-08da1e5f31df
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 21:39:03.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/k73zP/wT0YdPDacy1VC4PTNPLYrWLtzJ8KtkV59mWsUYua0ImBbq0f+fXwnM1a6gzkgwtWooIWrwtd5OunqoVg63Arolp+vX5aIt5/jlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1712
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140111
X-Proofpoint-GUID: CAOSSTTY6gN6V7aaAY_bzGwLGNi-RYN1
X-Proofpoint-ORIG-GUID: CAOSSTTY6gN6V7aaAY_bzGwLGNi-RYN1
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/14/22 2:19 PM, Shuah Khan wrote:
> On 4/14/22 11:15 AM, Sidhartha Kumar wrote:
>> Avoid calling mmap with requested addresses that
>> are less than the system's mmap_min_addr. Running
>> the test as root returns EACCES when trying to map
>> addresses < mmap_min_addr which is not one of the
>> error codes for the retry condition. Add a munmap
>> call after an alignment check as the mappings are
>> retained after the retry and can reach vm.max_map_count.
>>
>
> Please use 75 or 76 chars per line in change logs to make it
> easier to read the commit log.
Sure
> The description is a bit confusing. What happens when mmap tries
> to map addresses < mmap_min_addr?
>
If run without root, mmap returns the EPERM error code but with root

it returns the EACCES error code. In the code of the test case, it checks

if the map failed with the EPERM error code and will retry with a new 
address.

The test breaks when run as root because EACCES isn't caught for the 
retry condition.

Rather than arbitrarily also catching the EACCES error code, I avoid mapping

with addresses < mmap_min_addr.

>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   tools/testing/selftests/vm/mremap_test.c | 41 +++++++++++++++++++++++-
>>   1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/vm/mremap_test.c 
>> b/tools/testing/selftests/vm/mremap_test.c
>> index 0624d1bd71b5..58600fee4b81 100644
>> --- a/tools/testing/selftests/vm/mremap_test.c
>> +++ b/tools/testing/selftests/vm/mremap_test.c
>> @@ -6,6 +6,7 @@
>>     #include <errno.h>
>>   #include <stdlib.h>
>> +#include <stdio.h>
>>   #include <string.h>
>>   #include <sys/mman.h>
>>   #include <time.h>
>> @@ -64,6 +65,35 @@ enum {
>>       .expect_failure = should_fail                \
>>   }
>>   +/* Returns mmap_min_addr sysctl */
>
> Change this to "sysctl tunable from procfs"
>
>> +static unsigned long long get_mmap_min_addr(void)
>> +{
>> +    FILE *fp;
>> +    int n_matched;
>> +    static unsigned long long addr;
>> +
>> +    if (addr)
>> +        return addr;
>> +
>> +    fp = fopen("/proc/sys/vm/mmap_min_addr", "r");
>> +    if (fp == NULL) {
>> +        ksft_print_msg("Failed to open /proc/sys/vm/mmap_min_addr: 
>> %s\n",
>> +            strerror(errno));
>> +        exit(KSFT_SKIP);
>> +    }
>> +
>> +    n_matched = fscanf(fp, "%llu", &addr);
>> +    if (n_matched != 1) {
>> +        ksft_print_msg("Failed to read /proc/sys/vm/mmap_min_addr: 
>> %s\n",
>> +            strerror(errno));
>> +        fclose(fp);
>> +        exit(KSFT_SKIP);
>> +    }
>> +
>> +    fclose(fp);
>> +    return addr;
>> +}
>> +
>>   /*
>>    * Returns the start address of the mapping on success, else returns
>>    * NULL on failure.
>> @@ -72,8 +102,15 @@ static void *get_source_mapping(struct config c)
>>   {
>>       unsigned long long addr = 0ULL;
>>       void *src_addr = NULL;
>> +    unsigned long long mmap_min_addr;
>> +
>> +    mmap_min_addr = get_mmap_min_addr();
>> +
>>   retry:
>>       addr += c.src_alignment;
>> +    if (addr < mmap_min_addr)
>> +        goto retry;
>
> Should this be an error or retry? Can you add why this is a retry
> when addr < mmap_min_addr?
>
In the original code, addr starts at 0, attempts an mmap, and retries on

failure with addr += c.src_alignment. I just retry earlier before the mmap

call because the mmap call will always fail if the addr < mmap_min_addr.

>> +
>>       src_addr = mmap((void *) addr, c.region_size, PROT_READ | 
>> PROT_WRITE,
>>               MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
>>               -1, 0);
>> @@ -91,8 +128,10 @@ static void *get_source_mapping(struct config c)
>>        * alignment in the tests.
>>        */
>>       if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
>> -            !((unsigned long long) src_addr & c.src_alignment))
>> +            !((unsigned long long) src_addr & c.src_alignment)) {
>> +        munmap(src_addr, c.region_size);
>>           goto retry;
>> +    }
>>         if (!src_addr)
>>           goto error;
>>
>
> thanks,
> -- Shuah
