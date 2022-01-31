Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6974A52C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 00:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiAaXAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 18:00:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57146 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235529AbiAaXAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 18:00:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VMWruC008746;
        Mon, 31 Jan 2022 23:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sa5IGJymqwVrH9CtgPq2s59WbgfzjQPs7TAwnbNQV2o=;
 b=sPPPLbtFajEiOWVwoYyeLbwUjjxl/5GmxbguDtZZHjFj6nT9bi3QUIAGIbUwtJPFzMZb
 uQCyIFs4sDp6KyeQkrsyW2AEpSK8cr7hGgr3WY4bxS1ELfYtz/2AI0QTpIo4eDKvoSFW
 lu9FGqcwzSRT0okG2qKDv7NOnS0L5WdcZ/C4eRwB+rImdQ6soIdN8LBc1rZfua6fG4g7
 ia33r33Mt/9Km8xDyx4TPANUJaIJ8P4BYuph+NKEdpY1ml9AEPzNlmUOTK/jemlPRAzc
 DIDx8tpzIMg6HfY8Z/XrtTr326OJ23w97giU+zXcQvrCu3X4yXdBlGyX8vSJXM6/pw7A TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2ggjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 23:00:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VMuG9Q144220;
        Mon, 31 Jan 2022 23:00:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3dvy1nnjsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 23:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFe1zYIu3Ri+8nI3nPGn8BYKHHApjv9ObjfiTyb/DMemqIDfEmmzgMezslR9zgcupFaKUO04y+eNIPIoNYpOE4L/UNsjQ5GO2NecX8o5swDbSwV+G9tIk5LMO5N6M+gUk+guac/SMk0SydIpum0UpzgfiDErpYMgdXEbSL86Rg6l7aUGttSltR5wxuqBO17No1E+4rVhrhZnnRry49L/ZgPbAB5MGwUvspNE2XAuinCvkWs3AQZUp5dHD3E3fV5M+AF7DVvA6XcKjlXm0qSfP8NFGVim4P6a/W2PlSQTUZ1hc7J5VD1IVfBPQ3fhNz51zLtEcg5zQ9ncXF8vjtrBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa5IGJymqwVrH9CtgPq2s59WbgfzjQPs7TAwnbNQV2o=;
 b=UzjmWEvwNet+PTcYZLqlxvIYdcIHJcXc2TbsbN2PRoH+AslpPo2QHdumTrOJGnRXrktOD5Dk+z6c2nqPazWOEwEUbpZ4Xqu7ESoPYVKri9ucQfWt6fJkxaw+6U5cAKVMcy4xiY6jUylkwugQWTy+Vw/7CFcXFON267dhqxT0FubVhV4wDY7l9l1DLb612IMjg8e2usk7CTOJxKL8pfpsP2xl4k9VBuGamghfVq5KvKPgsuH4GW8SAPBI5ycsPMj8JVJcJ/8pns0U/MK/ZIaDW8IX5Mn7/VmPDgwjOxXbT6YY4IOVvkYchC7diBtG69CYtYFnctrxNt8wqg8ghAETgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa5IGJymqwVrH9CtgPq2s59WbgfzjQPs7TAwnbNQV2o=;
 b=s/ivv6flFHiRuEqU9LSTmWlL4QjAuiB2W8pSY0epwJTDE3vJV0i46raIotqvlP42mUqKrkq5zcmfEVKUaMaO/xY3gkPbtsbP8VRF+euNAsBM3skQf49APp88jWK8j6rT6geD75BckHG02LkSqzvUodlT+nCMgQrBnNVtBFDnExU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1746.namprd10.prod.outlook.com (2603:10b6:405:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 23:00:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 23:00:25 +0000
Message-ID: <beff2e58-cc75-7c91-543c-ed35b8939470@oracle.com>
Date:   Mon, 31 Jan 2022 15:00:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] userfaultfd/selftests: use swap() to make code cleaner
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211028112331.16152-1-deng.changcheng@zte.com.cn>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211028112331.16152-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b90cf5e7-d09c-44d1-e046-08d9e50d77b6
X-MS-TrafficTypeDiagnostic: BN6PR10MB1746:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1746F30FF90A2BC258272BACE2259@BN6PR10MB1746.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaEB1BeZYZqB0dNTlPUECSnVi5foC7mwOLt9LHAvW+tCIGhWRMyU5SM+tyTEK0WrUGRVayPtKj/05kKZD7FFYBK/3c9GzUnx3RSHmPEYICVWE+sDwk2g1b4qIzN2sLBQ8PUEQi4SbHYdYSVyTpiUKb7NosmjUFr9mKgpsu13XUniA1MNK5jiLYOXW+f+lHuIfp+boU9wKPKhesknn0HAlriJ1U9pnrgkyYxIIWsz+/Ut4xNZnDCchsxnWDj/59hfI39KQBLkt6cmH68qawyaeCP8gwY3RpJySHlKVIfJ0eydohnxhGY3L+Vd24Gi7BR77dCWWN1QB6jZgZ3kRHIwuobpWRusKXUedkDh+R/TTKDuPe6XQsQusdEagTJ8fH9m6ct5cMBZIuVR/wlr2rxjSVd6OrYckh7473ycs1jvXSidzETzwegsN+xEFaose3cuumMCjOt+d8v/UuQjIpjeQZQzJd8XK19ye5MC0V1NepS2+YYeG5As3tnd68zM1NaPby65OuR+HB9S6LquNlORoea/nMiRkkiUcK1L5gt5gJxcwp9PIvw8PVCBEw8J3e8KEi57K3pxPo2A6pqj4C3cPwAfQhytH+FpavfyEDwd99uSI+J0mxMaR7NXKnKqe6CQ/MueAEJheBqIjqDsQa5WDMgHUd1ZKJsQ+RDCrCOKLMtQ51yTSiZdGt21gd+9uazpS0FtxIs+3wvmiwODONvLiwvwRYrsh1Ng4R4SPGQKoI5xEeqLAZBTWTqaBvUIU4YZrDTLilDBmBJ7fl9Q+Cw/BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(86362001)(508600001)(54906003)(38100700002)(66946007)(31696002)(66556008)(6486002)(316002)(31686004)(4326008)(8676002)(8936002)(36756003)(2616005)(44832011)(2906002)(52116002)(6506007)(186003)(53546011)(38350700002)(83380400001)(6512007)(5660300002)(26005)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5UeVdqQlp3YnFRLy9oSUl4UG92d0FaQlVyVGlwUWZyVUZBSDJlLzYzQ244?=
 =?utf-8?B?NWpWVUpWT1VuQzFyUmJpeStDSkl0K1JTbUkxTVZ6dWU2YUtnQnRNU0h0azFV?=
 =?utf-8?B?S2g2Y3U3eURqNUZyMGFUNzM0SmxHbFRRRmFLN2RocUVjRnJVZGJIamFCdjJE?=
 =?utf-8?B?SXQ3UURjS1FpYWtZc281V2FPQlVPaWk1Nlh4b1Iwa1hSYkpRclEzWjR3SFUy?=
 =?utf-8?B?aUZNZnRCdUo3Z0s1djRyYXE4ZnEzcm5nMmRwRUN0UVBxdTRzVXRldmhJbnNk?=
 =?utf-8?B?TEV4SlF1dCt2T1MzZmE4WUJLdmpBNkE4M2F3NkZ6S2laNjR3Z3FqVFJTUUUw?=
 =?utf-8?B?WUZZWlo1OS9QRTVnbEh6eHVDSUd1ejdNbVNFajJvSERuZVRreW1mWnYydFU0?=
 =?utf-8?B?dTBNNWlWRzhTWXlhRFRTN3lUOWZnbDAxb2RXWDRxR25DbDdNL1VadjI0dlVw?=
 =?utf-8?B?QmY3RlNnelFtZHFlYVZaUnNVaTh1MHFGcW5MaVVmaEs4MkhiSk9yNzg1STl1?=
 =?utf-8?B?S0UydmtJNGJGVWFtYnk0RHpEczNKeHpjWjlmSnZnQ3grcnVoTnN2NmVTQjZq?=
 =?utf-8?B?alhBSC9GQmswU0dkOUgrZjVlTXRwS3pNV3luVlhpcUVFZXFBK0h3c1doSi9n?=
 =?utf-8?B?NFZZdC9md0lJR2ZmdkZuUDVjNVowcVc2TUVXWnhjZU9zcjkvY0h4bzUwYzlM?=
 =?utf-8?B?VFp4bHJyK3lvVXFkWFZrMTBnZVl3Z0FmVTQxQ0pKeUU4Mk56eGpwaUJlbW83?=
 =?utf-8?B?OFg1eFppZWhtdE9KUWVNSHJoVitFaDg5QXBuUXI0WmpaSmpEQmFTbzg3TUdW?=
 =?utf-8?B?bElpT3I3K1Q1Mm1Da2h2L3FCdW9oQTR5cXhGbHB4MGo3ZzFIbHNSNExHNU54?=
 =?utf-8?B?WVBwSzlhQytHWHRMRHhWeTA3Q1lzdDFXYjljUTFHT09RZUtXSkY4MFA1RU5a?=
 =?utf-8?B?MGhmZjZ6NC9nUHhhOVNVbjRKSHEwZlhKQndzc3JGNUE2Rjl5VXRITEhzMU4z?=
 =?utf-8?B?aURZNlM3VWkyNGdXbnhRTFNpTmJtMElGY0VBekY0SWordzFXREJ1TGQwc2JU?=
 =?utf-8?B?ald5OUN2cDVTMUw0RE5VUE9ndFUzN0ZUNWRhd1YvditKVTc4UFFVSWZHbEhZ?=
 =?utf-8?B?K3NEb05jYVVJUU1GdDhoYVJJazRZY1ZJb0xVcGNLWjh5cHNra2kvbGVuYUxu?=
 =?utf-8?B?VXJEMG9STSt3VDVxK2dEWlhjQStNaDRhdFArRXF0Mk1zUk5KV0lrN1l6c1l2?=
 =?utf-8?B?am5qRVE2TWc4VU90S1dKVUdoaFZIR2NwUTRJOUkyQVdBR0VCWHpWNW9KMjRH?=
 =?utf-8?B?OHJwNGU5bUNrWjU4QUdiSmU3WGt0YVRXK1d1bkJLa3p4cE9SSXgyNnAzamNr?=
 =?utf-8?B?NWY0NmIvS3U2ME4vcFN2dnl5Ymh3OVJJUnVnaE11b0VaNi9KLzhhbDQ3ZFJE?=
 =?utf-8?B?akovZ0U0QjNFSGp6Smp0blRLRlZSMHp0V0lRZG52ZWFxL2R4dmtnbVpJQTJH?=
 =?utf-8?B?R0VlcGZNbDliWHg2ZzQvUlRHSnpKVDdLZ1c1LzdSWXFGN3J1OEptTm04NE1p?=
 =?utf-8?B?cldqM3AxVXJTa1BqRXgySXNXeFVzTm1Qb0hpS2FYa2lqSVVVazhUQjRJdzJh?=
 =?utf-8?B?RTdjZG0wS3IrSUZDc093TlZJS29Wb3UyQkNpYzdXMG9TVWpEY2R4VC9HNW84?=
 =?utf-8?B?M0puNnE1VWg1N1VKa0tlVWZFTnRKWWNlZkNsQmZIdFFXeEh6NHZiajB3cXRN?=
 =?utf-8?B?bHBFMkxpU1gzN1BHZmRzc3BrQjZWM3BUN1RuOFUvOVVFQXBlWk9PRHg0Q3o0?=
 =?utf-8?B?dUdtMWhCbFB2UUova1FrTmhHWmtCbWQyTkxjL0g4VmQ4NnhpU2hCUmRweHZG?=
 =?utf-8?B?NlIwMGphK2VNMk9nZGNXNjgyRWxEWVpCQVB5N2R4emF6UHJwY3lFa0lYQXpV?=
 =?utf-8?B?aW1WVmRpYmtlWnhjQWp1aEdmWUdicUV3SExkME5UUEFRWWdjYTd3QytSWGto?=
 =?utf-8?B?NGcwQzZ0bGgyN0JKNzc2bDhReHA4blNTK2NoU3NWb2pLbFFQWWhXRlFuK3k4?=
 =?utf-8?B?YzY4aG1mMHl2ejROUkFoS09YT2ptN2c2RmlBUVNLSzVZRUk4b1ppZG1qbXhH?=
 =?utf-8?B?R0dBK2duc3dUd293bENsUEhaSWM5UVdBY2REd2EvZVEvUXpra3RZRm9HbEZE?=
 =?utf-8?Q?Jn0B6ty2TDNP9R4GsJrkCrU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90cf5e7-d09c-44d1-e046-08d9e50d77b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 23:00:25.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr39W7cLRxaBkMSWDZWydrRPJIrqwU+nzddauAtiAfVKKFWHOAEgRRGQi+vtj5rQk7m0RtKcZGn7VTGsWRC28A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1746
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310143
X-Proofpoint-GUID: nUuEx9jAj7TJUyNljWc3_tNas02to9FU
X-Proofpoint-ORIG-GUID: nUuEx9jAj7TJUyNljWc3_tNas02to9FU
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/28/21 04:23, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use swap() in order to make code cleaner. Issue found by coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 8a09057d2f22..41dfe6f4ebfb 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -1413,7 +1413,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>  static int userfaultfd_stress(void)
>  {
>  	void *area;
> -	char *tmp_area;
>  	unsigned long nr;
>  	struct uffdio_register uffdio_register;
>  	struct uffd_stats uffd_stats[nr_cpus];
> @@ -1524,13 +1523,8 @@ static int userfaultfd_stress(void)
>  					    count_verify[nr], nr);
>  
>  		/* prepare next bounce */
> -		tmp_area = area_src;
> -		area_src = area_dst;
> -		area_dst = tmp_area;
> -
> -		tmp_area = area_src_alias;
> -		area_src_alias = area_dst_alias;
> -		area_dst_alias = tmp_area;
> +		swap(area_src, area_dst);
> +		swap(area_src_alias, area_dst_alias);
>  
>  		uffd_stats_report(uffd_stats, nr_cpus);
>  	}

Sorry for the late comment/question.

Where is the test supposed to get the definition of swap()?  When trying to
build, I get:

gcc -Wall -I ../../../../usr/include  -no-pie    userfaultfd.c -lrt -lpthread -o /home/mkravetz/tmp/linux-stable/tools/testing/selftests/vm/userfaultfd
userfaultfd.c: In function ‘userfaultfd_stress’:
userfaultfd.c:1530:3: warning: implicit declaration of function ‘swap’; did you mean ‘swab’? [-Wimplicit-function-declaration]
 1530 |   swap(area_src, area_dst);
      |   ^~~~
      |   swab
/usr/bin/ld: /tmp/ccPiwPM0.o: in function `userfaultfd_stress':
userfaultfd.c:(.text+0x4b6d): undefined reference to `swap'
/usr/bin/ld: userfaultfd.c:(.text+0x4b8b): undefined reference to `swap'
collect2: error: ld returned 1 exit status
make[1]: *** [../lib.mk:146: /home/mkravetz/tmp/linux-stable/tools/testing/selftests/vm/userfaultfd] Error 1

As far as I can see, swap is only defined in 'include/linux/minmax.h'.
However, that is not part of the user API and not available to the tests.
What am I missing?
--
Mike Kravetz
