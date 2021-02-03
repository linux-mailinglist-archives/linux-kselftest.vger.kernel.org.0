Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A130DF71
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhBCQPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 11:15:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53168 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhBCQPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 11:15:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FngAu118575;
        Wed, 3 Feb 2021 16:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UuX2CnY2PFWmbKfbpX2HPM9V3Bv741hwEZF+gN7z3xA=;
 b=Pertp9rxVJdjx/ozVsHZPoBNv+FHcUlmzeEIvRTCzyltBR8TunKDtjRk2gpeANcY0kEv
 ZMgiUxV++3FeyxqaL6tGzGVxHOyTDXS3DigcEmIhHmbT1QmZD/MQI15DSUu/DKaoZyQD
 Et1070Hs39zxMzWL6JlwC8MIYDNLvSq07GIzWDaDdx36PJkN9ZzcDythpbUSXZqh69lA
 5Lnba7ElOXTWsUqXFrQ4Iv6DETI/9W7MDWtericIrcNOExUEhkWnZVlC6u7zM2X97R3+
 MRAz3XwM10e4XbuXk6Ht1AWBqRzCGtEYkAPOnYmQclhM5XbRNSWgesMUQwXGuez4vbJ5 gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm0sjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:13:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FoKvQ192830;
        Wed, 3 Feb 2021 16:13:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 36dh7tqhyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRV1bNtE0xFCRr0DMrVjPXaVEf+nwyKXHWjSYIf7yEWb7FRMb9vo0APNXBtIgRrLOu2iGZgya3LR0hFNymKGDCwCrgh3maIXSMVH6muz1Ngycdlu9YrHd9WT2S2Y81PGgatGWm32gJ3SDw77Een2y3KdB6/gTWygo2b8IM00/1waPaHCJYFNXIa3cVsHhO/xrDQcmovVm7ixrgdLvhUSvBUza4+1ob239+9AQbadrn18zy/ygeaGtJpYzRtZc8NVdyUHRAA0Z6OQQL7aZRqlvR51Ln/HOs4DKrcjldB5gBTsYd+fOCmb4PqDjz7lsjX/6xe1tgLClmZfl+2uU0x3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuX2CnY2PFWmbKfbpX2HPM9V3Bv741hwEZF+gN7z3xA=;
 b=Fq1VeS13epH7LH+Sr+T4ha8V1IxlvXclLdMSZuS6Ohxzm6PviHdcMKk5tP1rwJfIlbeHI3NpF3L60oyNBffWAbmPgO/mLj+5wOQ+1TsMEICaChRiJyGa8Pw7vkspAT98s+ug7QxlFBPUVx09YfTfBIN2UWJP44+lI1wjoZw1p2pCLL0A4H5yjGKO0NEcu3PjTzjTFK23WlVKHZ+FLIMVjyZB1mNCSsjyAIRhkdkhMC62kQO1xESfskVX2DJBiNGhSzxojySVEdAdBcq2Cb68FpMPR92oDCTRGsw329bkxG1nZTZEb0X81fCUxNp8Q5m/I7rchsVP2WNJFu5XzokxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuX2CnY2PFWmbKfbpX2HPM9V3Bv741hwEZF+gN7z3xA=;
 b=iTBkyqC+ZFMgq5P78ksS9XaSgI7S77e1IzYqtCScA8DzmEXqPAQRsp6SZH2sISQGdw/F1yqd2NsIgX/VH801FCib9s85rjbCnPxRPmYVvD4T3XW0MmWHw7Pk9uOvCCpIm0535zCCF6XDH3gmde7o3OOu4BbhB93+Z0hq7B6NrXY=
Authentication-Results: namei.org; dkim=none (message not signed)
 header.d=none;namei.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3208.namprd10.prod.outlook.com (2603:10b6:a03:159::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 16:13:32 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 16:13:32 +0000
Subject: Re: [PATCH v8 02/14] mm/gup: check every subpage of a compound page
 during isolation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org,
        jmorris@namei.org
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
 <20210125194751.1275316-3-pasha.tatashin@soleen.com>
 <05a66361-214c-2afe-22e4-12862ea1e4e2@oracle.com>
 <20210203145313.GQ4718@ziepe.ca>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <f82dca38-52bd-aa27-2d27-b5a67f5284f5@oracle.com>
Date:   Wed, 3 Feb 2021 16:13:21 +0000
In-Reply-To: <20210203145313.GQ4718@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::9) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:152::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 16:13:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 153a5354-e1cb-40b7-62d1-08d8c85ea6de
X-MS-TrafficTypeDiagnostic: BYAPR10MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB320881F7C23BC4837DB1C574BBB49@BYAPR10MB3208.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0LsxrQ0jvthO+jQxx8/aN9V+O5XLaxlraH3jxk/p/iD9G/w2Zas9RMWhqCJAk4JxkVYor72wdpMfDUIssEhqdrVt+a8LekgUBBE0KM/GeejKoi7QPHy4brrPqxGe9PG4BFkEp/uzwBTaOXK5w9j5RcDyw34CNNRdxJnMC/7DodRnhuKDyOTysGkiJpa0MVDApXt4rGDr2SvkssmEn7czC2866z9Tw4rsd+gHaHbfOor6A/dVeC4Y0Toi9D6I3/HxMq/wEpqaJeyuJh0+GczZOKXLyPYjmzuC8HfAVqbtIJpyBTySu1ESwO6sNzbz0YFfSn4iIiLm+KgkVW0lBC3Q7LGooQEC/n3rVlhh8VI6lXqflqzDEJuGD9ea7Yy+1rWwy9p/EivPMpNauivU6umNkmMI27JnWIM4Z75Qo3GJbAIqXsx2KrWQQ7tULpYHDnSuEyfKm7e+JEB9FYqZP+UWrnZhjc/vhbtXyfiLMDQQrj6l8csXdTeELLJ5kF9jlvK/i5AhxCgnrjjWDCKhDLZlOsFeydm9si8lkXRw8lNkXpxWRjBeNzW8jwrF9uQR0WcWd31V771kPK0YM1aD9FNZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(26005)(186003)(31686004)(6916009)(6486002)(31696002)(2906002)(2616005)(8676002)(956004)(66946007)(16526019)(7416002)(6666004)(8936002)(478600001)(66476007)(36756003)(5660300002)(316002)(16576012)(66556008)(53546011)(4326008)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ckNCSlVEOEdYd2tiMWtlQWcvNHAxaUFMOXBtR3BCM004U0pYVEplcWZLK3Jk?=
 =?utf-8?B?MUtOeWtSUnVYZWFra01lbituUVpYZVllWUhzTzA5RVJwNm81MkVDdUh5QXJv?=
 =?utf-8?B?TlJtV2o4N1ZEQ0FzbUlpVUJ2L3JMWVl4aVJEcVo5WVMyZDdsZEhlZXNNaFpF?=
 =?utf-8?B?Yit0ZVMzR2lpWXovOEhmTEtPQ1pWTnFEMFcvRFZxQ1lqZENSUXBHNXI4RWJU?=
 =?utf-8?B?UU1Jd3NXc3EvVi85OExnYmFqSzRLdStEUTJjM0dHRVBMdjBxQXVvNC9IdkMx?=
 =?utf-8?B?STJ6RzhhcXdiN3YxRnpyN1ZpdWVGRTloc2FzSE1CUVdnTHRISDNBY1lITzdJ?=
 =?utf-8?B?dlI2RzI3aVBLU1RBYWhsUFJzcDQrK0s0Z21DV20yTkFVR3AyaFVlRWpHUXls?=
 =?utf-8?B?elR5SXRxKzA2Y3FTK2JFS3J5TFpLRkFhMWptd0VaVlRnSk5pbEwvVnNZOU9N?=
 =?utf-8?B?N2JsenRkOXVFRXZxSUhERzNZbld6dWRUTm1aY2k5SlE1bHBNQ3l3d0gzZ2Vv?=
 =?utf-8?B?YnBqamVndWo5ZmVSSUdiYm5LUktNT1k1dUxla2xIVFMzS3R5VWswVkd5TFk0?=
 =?utf-8?B?N3NUUW5GcFhJWXE1S2tiam9WSFRNZE9KcnJvbFdGR0tBVlRTLzRTNStlczJx?=
 =?utf-8?B?MG1tZGZzQ0dKeTQvYkdISmcyWkV4QmJQQXhKaDVtL011YTBlZ1JOK290NHNX?=
 =?utf-8?B?NEZKZmNmYXFyS1IzODU1bHFOS0M0QjBGalFpRU1tZkd1VGdleGNCSDJRZ1hH?=
 =?utf-8?B?ZG40bkV5NlRlYzhiV21oSlZFVmxIOFhmSTVtR2tSMHVKVEhzdkRRS1g1TXVi?=
 =?utf-8?B?YWJySEIrQWFkQWMzaUV1bDUwODdLY3c0K3paeDF6d2lOd05jOU1admlHZGxT?=
 =?utf-8?B?SUNsUm1qbGdoU3FUZjlrQ3JSOEtBb3U2b256Q3NrUWZnSU93V05TNThHaG53?=
 =?utf-8?B?YTNTalRsQ3djZUtIL0dxMXA2c1ViRURRQmgvV2laaXI1c1V3UFliUDYyNk9k?=
 =?utf-8?B?U0M4bXlNUXRWd3dmdHVlYllmcC9Wczd4RjJ4QWpIczAxb29zNmViYWVIR1Qz?=
 =?utf-8?B?VWFxbHRGbTdSN3pwdkZkTmJVeHE2eXhJMkZHbGQwTmpoU1R4N2Zobkl2bVB6?=
 =?utf-8?B?KzE3RnhWT085WjZYa1ZPSG9tbjNBMnkxQWMvdTZCU3c4aXQvZ28wK3lDNjd5?=
 =?utf-8?B?S1BFbXBjUkFjdm9CSmhGRTBZOTFNTm5LVkpvc3NUb0lxMlk4Q2J5QXlNZnds?=
 =?utf-8?B?T0QrdmQzendsdzZad1huc01CRjdyckljcTN1eEZVbnlDMENrV3dmakF2cEdq?=
 =?utf-8?B?dHowZXFDRjkzcDUxVndRa25VNytPV2xsU0xCZkxJTUpHZWVkcTdSdkR5ZW85?=
 =?utf-8?B?OGxqalhscG1pbG9hSm5VNzE3TVpCVWduQk1YbjB1b0xoZnNLdGNZa3EzQjMy?=
 =?utf-8?Q?Ulx9b70a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153a5354-e1cb-40b7-62d1-08d8c85ea6de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 16:13:32.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeDX0ckS/1FV6dlu/TqIYBaww4+qVH63A/hR7KniF10h9SCdESH+E1DvKHHneCPrL6alnrFZjROZcKO9osmxEWhGz82VUyUFeBWCLqAgXxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3208
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030098
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/21 2:53 PM, Jason Gunthorpe wrote:
> On Wed, Feb 03, 2021 at 01:22:18PM +0000, Joao Martins wrote:
> 
>> With this, longterm gup will 'regress' for hugetlbfs e.g. from ~6k -> ~32k usecs when
>> pinning a 16G hugetlb file.
> 
> Yes, but correctness demands it.
> 
Hence the quotes around the word regress.

But still, we are adding unnecessary overhead (previously nonexistent) to compound pages
even those where the issue doesn't exist (hugetlb).

> The solution is to track these pages as we discover them so we know if
> a PMD/PUD points and can directly skip the duplicated work
> 
That looks better. It would require moving check_and_migrate_movable_pages() elsewhere,
and/or possibly reworking the entire series?

>> Splitting can only occur on THP right? If so, perhaps we could
>> retain the @step increment for compound pages but when
>> !is_transparent_hugepage(head) or just PageHuge(head) like:
> 
> Honestly I'd rather see it fixed properly which will give even bigger
> performance gains - avoiding the entire rescan of the page list will
> be a win
> 

If check_and_migrate_movable_pages() is meant to migrate unpinned pages, then rather than
pinning+unpinning+moving, perhaps it would be called in __get_user_pages() place where we
are walking page tables and know if it's a PUD/PMD and can skip all the subpages and just
record and migrate those instead. Was that your thinking?

	Joao
