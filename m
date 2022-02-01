Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31574A5473
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiBABHB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 20:07:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23752 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231523AbiBABHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 20:07:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VLftBs006233;
        Tue, 1 Feb 2022 01:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0XUQJ4ZCR7d5FI4q+sft7UiL8lAm6LFhR2WdGZpk/ms=;
 b=FNVqibcZmjSoVU+T/Rw2Au2nvrY7KMgUrgJ8+LblZLgFZe/Gbu/GvJboFqX9ktLHyTAd
 ywRQIH68IZ2eJQqLfap/trlXcNrHv0D4wQ1fdcRa/TEPNLXAXO65PdDs0vV++W6U95O4
 GFzFGxsPbJQFTZzvCCnlqkmK7lR/zhOPK2Zozb8OUEsCJpRL3BYP2lSEeNKn5ZlOqCWd
 EUSB0Jvoh/e+xb1rfsS2d/aGHXHhqBBtx5oW2arwsds7/CjNGBWpkXzBSDPI5BRBjhPt
 BFWPZJUe0fQOBpGG5KEGtO4W6MsYU+lUzme2sWsN3qFmnp3rBbd2FBUBcSBMr7ev3b+p UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9w9d0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 01:06:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211119n3154394;
        Tue, 1 Feb 2022 01:06:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3dvwd58fx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 01:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwXvrqSUbSbJsdo/Ebp0tnZA4KodoKS27HbSHWxIGScNoQXYTS3JzP2N1oiDq3DPFaSkhQlg+vclw+Q6Pkdr7stpyVj1ihwZBfPmf6BXs3nf4m1S/+cjg4PZp39LW167dbys2ayryx4LcJpDJYGyIARL83kF/Y2OHMksKsa/1RcyLU2ux0A0zziFhA02YZP5S7souNBLB76812UYOjmkah0CXEbb3+oeKJuJ+pXO9Pf+GvqOcKgjuqWS1K4z+InQzuNXADLYTr8l0Unh99LPshf3WF8nMgvQLoxxxReElk8WsGcgtQOWODl45TAqDDCmxIr6CqL7h26d9v0cAeLtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XUQJ4ZCR7d5FI4q+sft7UiL8lAm6LFhR2WdGZpk/ms=;
 b=Vn9p/Jc/HfCOodMosrBphaJDYcIrINW4m2Mg+K09Ib7Ft+NrMNu4rhzuHoN0lhwfALUOyHuz4O8GnGvRWkLqpGRZPMw9cJiQaz8QQkLTxWlpxf3XpMGZPL81vmBAO3relEr0nj/F5GkP1TbAgXQahWhghscTfn/L//sj3A87GITRKsXphEmQLoXYViUqWX+m8pczEGoGy5h5fke2q2gijbGMHm7PlHt8rOo+cCqyuBt20/HvBYU7i9zWkzWH3h9RHUn5jqcx6azPnbb6BQKMYpkAQrpT5Fg/DZnDg+7aB3EGpubFZv+Qsijik4QPyZ2MP81XITF32GjfHwBa1l4wpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XUQJ4ZCR7d5FI4q+sft7UiL8lAm6LFhR2WdGZpk/ms=;
 b=p8T/sf9UZQweSGMduIcTUrUi9YPaBdyh3xxG5Vt3YhQQ56H2zZk5bf7s1M2aVlwocmBDC5JE2w0USD8Xd9BwwkH/i8NzSIHbPCAjWyjmhjsckVVrtyEa32Znr6wEsYNfy0CJPCuB550x5fQt6ldjk+2+GrzVOa8bLoPIiS5Yq/E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5728.namprd10.prod.outlook.com (2603:10b6:303:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 01:06:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 01:06:52 +0000
Message-ID: <a525220e-86cf-e9d7-116b-fe988a59239e@oracle.com>
Date:   Mon, 31 Jan 2022 17:06:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] userfaultfd/selftests: use swap() to make code cleaner
Content-Language: en-US
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211028112331.16152-1-deng.changcheng@zte.com.cn>
 <beff2e58-cc75-7c91-543c-ed35b8939470@oracle.com>
In-Reply-To: <beff2e58-cc75-7c91-543c-ed35b8939470@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR18CA0048.namprd18.prod.outlook.com
 (2603:10b6:104:2::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67005009-24ac-456f-33d3-08d9e51f2174
X-MS-TrafficTypeDiagnostic: MW4PR10MB5728:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5728EDB27123F738947519E6E2269@MW4PR10MB5728.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: me+wBFt+yLvd9O6QdPwe5XdancQbitY21peQN95uH0Z/Q7BTXzq2KVQhIK5xXT21Ef7fz/p0re+g9As7oZLRdeOet3mBlCp634+qb6YZ51jrtE4PVcRQ0yOMxx9fONCSTFTb16HnX04VyWCZY3jk1Bs+Ed8cDuhMl3kZ/Alvmx0d96z3YVufq3fWNyctqgI11cN9wsBBNDSSAodsgAQKqLNjty2B0pULF4F/ygx65ExopmDyXRy9Nr4wBuM+HJEWPsmbqwcvTkDo0OHnwX5X1G0/EkkidoJ8PDZkExasnp+2zWBWzRVkmjHc24l37NAYyp33NlmZbB2bcWyWsn8Ibuo6pz0jjkdivwSxUpQdPTCBZwW4W54jfrjXJdYfoP9OIPMiWcUfWCWaVLZxVBn1SRUqAcG8hF+XFQlzbXS5sHQ9Sn351OVMscKfYukFkI0DJcfGsyaphMfxMlRCTIAoiwjScc4IM70eFYSDwSDJckdxFuUNROyC7+GKOhiIMLJhj/5VMPSse3bHsWBuzzYeQBxDMLo+9pECg9GJZ993gpzbW6IGTCD0QG3+lFixP4G4Xhdd2VsdL6fSG1cT+wum0ww1tc71MIxDFrozvLj/PzRx4DvUrd0WDH+JzaAUhdR+nnkQnP72ZtmXPWZOqtxJxYM8WnG3sMPjqLcWIFINoFmIGDlMU6bw4XhnbLwH8EPGB14Fi2poQmwZcK5TfUbpcAC5DPFkXuGgPYo1Nvvt5GOoHRq+5CrM2o8aB1IUJievzSyz2tj6Pzbcy3BxsmgCqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(6512007)(26005)(186003)(86362001)(2616005)(52116002)(508600001)(31696002)(53546011)(6486002)(2906002)(38350700002)(5660300002)(36756003)(44832011)(31686004)(6506007)(54906003)(66946007)(38100700002)(66556008)(66476007)(8936002)(8676002)(4326008)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBSTm5NYzkvcndKZVpPNTRSNDNVek1udlpsanpSdld6Vk9FV3NyQnNrYXZD?=
 =?utf-8?B?d2tvWUJMVzZ2YTVsN05hemhhTk5BYkEvWmJPbEU5aGFkclVLSDNrSk9EMW1l?=
 =?utf-8?B?YmV0UW1wemNUdG9mNG1WM0xJcjBNZmJCVm9hM2VNUU11d0o3QUNPYWdselRm?=
 =?utf-8?B?elRvYUl0bWZNTUVkTmtqVUp5TVE1c3NqbW1OTlBIeGFweGhmS0NyUS9mVWdv?=
 =?utf-8?B?eGRmSjI1SW1oblVNb3ZNaENBQlhGQ05TZVB6VUd3Skw2bjFrRkZjTjFnVVpm?=
 =?utf-8?B?dU03MHhnK2dSbmd3SFk5WFhyVytFczFOa2o4ZnhHSUlMS3p0S2dtdUgraTlu?=
 =?utf-8?B?NG5zS0I2S0FEVjN6Nzc2ZWExdVk1YnJFZXhDdnlYLzdWNWlMMU82SnczR25N?=
 =?utf-8?B?M1JOelUvcmVkWml1Tzl2RW4vWk12UUZSKzZHRHB5QWtyRGN0aVB6QzJLZGo5?=
 =?utf-8?B?WG1KV1lnSVBDbmFpb0oxK2gwMnl5Z2o3NUIzemFmS3Fyem1OSXRtanh4ck91?=
 =?utf-8?B?ekVWbzFqelFqaHUraGlTYWY4VVhnSXB6eHFpVFpJNlRXekpaWEpldzhWYzdE?=
 =?utf-8?B?dXZCU1ZNRm0vUWhZaHcybVJadzhXMlFFUlE1RTFEaGYwdW9taHJldWZweVZ3?=
 =?utf-8?B?aEJ1djhOYU9DZW9YaWh2VHVPd2N2MWU3M1NJOHpxNUhnd0dFQk1wVmdvNUdU?=
 =?utf-8?B?a2dOY0tPZzNOUDF5ZFp3bjNSWk9PS2wxNWhnamtvTjV1SlRhcnRNeGRsN0xN?=
 =?utf-8?B?M2RvcXF0cHFQUFNoZkE4NTdxVWJLUmlEVmJBVnQvdTloUWwxWk9SSFI0dXdF?=
 =?utf-8?B?UUFucWhwcUFOdzNhVHVsWWRPMkFOc1cvZy9nY2F3RkVpSlVhWWUzdldOZWR1?=
 =?utf-8?B?TXd5MnlLWlFWNzR0OWhnS1NxNlZYcXMwYWExWld4TjMrbE51OVRTazBNRzJo?=
 =?utf-8?B?ZEYxN3dFejlqVFRPZm9nMHEycFZJMWg5elFTUWJhdG4rZDE2SXBGOGlHcUtB?=
 =?utf-8?B?Wm5GY1I0dlJ1dUsvdWpnZWdHSXhlTEFJalpROS9NU09JUXJiMkxmTEhiK0xI?=
 =?utf-8?B?Vk9YcTRsMHdrMDRzZ05GaUJ3NldOejlCTmdRMTZVazg2WmxGNytadGlra1Ra?=
 =?utf-8?B?QzBmQ0wvaU9haWpuUHdTTVBvbG9aaFlKT1hKQ2lxK0VPdU9QRnNCUUdkR1U0?=
 =?utf-8?B?NmFvRElBbFk5d25zWjlkeVJ2c0kzUGlJMldmTisxOGFpSVlTZ0p4ZUtwcjlu?=
 =?utf-8?B?Nlh2ZmhTT3lhQzB0Y0lDaW5acUR6NUIrR0JFUjBSWnJpalJMQ203ZS8yNUp0?=
 =?utf-8?B?TnlGc2NPTkNzMytMRmhJWjAweDJiemtaTVdsek9oL1kzRjY4N1VlcXVjUEJU?=
 =?utf-8?B?UjVnSGZ5eU1FbHMvV1M1VXErQXI1a3NFWDVGbjQ1UVFhWVRSK2NvUzI3Q1Zk?=
 =?utf-8?B?SzRjU2g3aDV5cEJVMFBUZzFZN0NHQ2ZrYVpUUVR2dGRwMUl4WFpaU0VEWEVX?=
 =?utf-8?B?SmNBVjB5OWJsbGloRCtMMEw4eUNWWC92ZE1VVG1lMm0vWDFXWFMyaVlXREg3?=
 =?utf-8?B?QXdJNmpnWEZxWS9HenpVd3dTZ2U0NDF0QWZ4R1Zkb3MzeVZXemRtRkZzZlBj?=
 =?utf-8?B?dGI5Z3dtQ0twdXFvbkR6VlVCNDhTcDNmVFQ1WkxRanl6TEo4YWZPNUNyeGlZ?=
 =?utf-8?B?MFlrbzRNNW4vYVNYUzlOMVk2ajZmcHpvbE1vV1hEbFRvbGZtRHNrRXB6ZGpy?=
 =?utf-8?B?TmdWNVlQZnlrV1JvM3lOZW1kdnBaZDRoaWQxcS9QMjVPRFpJK1kvQkhFdzEz?=
 =?utf-8?B?c3RmTE80aXJGT1IvMmN2YlNYNllacTQrR1M4MURCUDBZRkdnRlZLQmtNQ201?=
 =?utf-8?B?b2VqcHVZMkpzbzFXTnJDU3Azem9JbTVjM0FuWnpwa01kY0hmemEwTGZHbkhi?=
 =?utf-8?B?bnowTStTZzlSaWZHdTZLYW5uWXNObDJFbXhYUGZBWGtacjBha2txblloVzNM?=
 =?utf-8?B?aDd2MWdzM01Va3BTL3hQSlYxeDlaY1k3M1piRUFXL2txSW1MNUdUTnFwWEN3?=
 =?utf-8?B?Mm11cmJkSzRySm43Vjl3TnhmcS9KeVA2WUcra2ltbHh0Uloyd2hhdUM1ZFhm?=
 =?utf-8?B?SklHZTh2WVFrT0dDRENTaFA0elpSdjVYSkNYWXJoTVJpUk5sdHlFTGs4bFMr?=
 =?utf-8?Q?e5hAbCuxSHE6m6fEx3SX7DY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67005009-24ac-456f-33d3-08d9e51f2174
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 01:06:51.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LomIY653kDBnadnw/icAesbU7rkwmG0sVBWTay8ismtlfodXHN2o1yFqaOiuiB+cXnwywWH6u/hSMIzedTZEOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5728
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010004
X-Proofpoint-ORIG-GUID: 2RxVMeSGPLfSDJqjfMHNyxIBiBpl5tTv
X-Proofpoint-GUID: 2RxVMeSGPLfSDJqjfMHNyxIBiBpl5tTv
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/31/22 15:00, Mike Kravetz wrote:
> On 10/28/21 04:23, cgel.zte@gmail.com wrote:
>> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>>
>> Use swap() in order to make code cleaner. Issue found by coccinelle.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
>> ---
>>  tools/testing/selftests/vm/userfaultfd.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
>> index 8a09057d2f22..41dfe6f4ebfb 100644
>> --- a/tools/testing/selftests/vm/userfaultfd.c
>> +++ b/tools/testing/selftests/vm/userfaultfd.c
>> @@ -1413,7 +1413,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>>  static int userfaultfd_stress(void)
>>  {
>>  	void *area;
>> -	char *tmp_area;
>>  	unsigned long nr;
>>  	struct uffdio_register uffdio_register;
>>  	struct uffd_stats uffd_stats[nr_cpus];
>> @@ -1524,13 +1523,8 @@ static int userfaultfd_stress(void)
>>  					    count_verify[nr], nr);
>>  
>>  		/* prepare next bounce */
>> -		tmp_area = area_src;
>> -		area_src = area_dst;
>> -		area_dst = tmp_area;
>> -
>> -		tmp_area = area_src_alias;
>> -		area_src_alias = area_dst_alias;
>> -		area_dst_alias = tmp_area;
>> +		swap(area_src, area_dst);
>> +		swap(area_src_alias, area_dst_alias);
>>  
>>  		uffd_stats_report(uffd_stats, nr_cpus);
>>  	}
> 
> Sorry for the late comment/question.
> 
> Where is the test supposed to get the definition of swap()?  When trying to
> build, I get:
> 
> gcc -Wall -I ../../../../usr/include  -no-pie    userfaultfd.c -lrt -lpthread -o /home/mkravetz/tmp/linux-stable/tools/testing/selftests/vm/userfaultfd
> userfaultfd.c: In function ‘userfaultfd_stress’:
> userfaultfd.c:1530:3: warning: implicit declaration of function ‘swap’; did you mean ‘swab’? [-Wimplicit-function-declaration]
>  1530 |   swap(area_src, area_dst);
>       |   ^~~~
>       |   swab
> /usr/bin/ld: /tmp/ccPiwPM0.o: in function `userfaultfd_stress':
> userfaultfd.c:(.text+0x4b6d): undefined reference to `swap'
> /usr/bin/ld: userfaultfd.c:(.text+0x4b8b): undefined reference to `swap'
> collect2: error: ld returned 1 exit status
> make[1]: *** [../lib.mk:146: /home/mkravetz/tmp/linux-stable/tools/testing/selftests/vm/userfaultfd] Error 1
> 
> As far as I can see, swap is only defined in 'include/linux/minmax.h'.
> However, that is not part of the user API and not available to the tests.
> What am I missing?

Please disregard.

It was failing for me on v5.17-rc2, but I see it was fixed in linux-next
with commit "selftests: vm: remove dependecy from internal kernel macros".

Sorry for the noise,
-- 
Mike Kravetz
