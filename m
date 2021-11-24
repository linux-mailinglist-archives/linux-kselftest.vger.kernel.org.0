Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1145B101
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 02:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhKXBLY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 20:11:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45736 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232547AbhKXBLX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 20:11:23 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO0WsAp006044;
        Wed, 24 Nov 2021 01:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ftcwUVxGs3lfGKuOWMu7iiIHgnO8yGb0y+S9gY3Ajwc=;
 b=YWSHO755rqPPXnUwKSF4IMYoocM7iyBh6iAsJL93MhNCKIUAgusks8/TyZx482r8TJab
 kUxdFOZ018+6Ory0nNlHYdRM9d+q1zEbs/oNiHiuWUA5+veyoXgQdD+uuWIjQedKH4ku
 XbWgQyv3F9o/4xajbwiEDEzAwlP4f5quRnHPD2vbZlUEolvniShRLhDcmY38w7yxJKO/
 LDae+blO/GZA2I1tLuhvkTRZD0tFKaHuD60sv9RecYjm1d1UgBVjdenj+be+FO8E9Bjy
 NqPq1nPi9xKnsIYlVeXVw5Ey90kW+ClB+MbnbLE++CeCay/mfd5tuT7fL36I2JLtG2NI Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46fe21j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 01:08:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO0xacV091713;
        Wed, 24 Nov 2021 01:08:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3020.oracle.com with ESMTP id 3ch5tgf43f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 01:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lROzJCdGrRYq3L6vEa8UduRtivFX9BFp50O3973cQv4JJbT/S5Ib1duvmm58y3QLMfrjfrR1/x9IKLvrt7CdLnc9BaROZY4bDcwlEEIPoD5gYfHZ3T1vhxp6klQeGXpa7sTp+f9W4Pcihg6pFs7XZiEoS06ZXNKq0EmvkBJ+eXrF62wbG26EEMAFThDJg1LkOjdg+idds6iKykLkPnAeSxgvVsOOzNAqZtDVZiz/4PixGRsNVS4PKBi9Hg0IYTidkIzokEi74qKDnB5mwFMVoWPhZ/KAeSYAyMnKpWRqDq832hRRgBJmr/KITzGc9BSDHZav9E0Zr9tLgxSYBolX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftcwUVxGs3lfGKuOWMu7iiIHgnO8yGb0y+S9gY3Ajwc=;
 b=jkjV0CpDKg9MHDIl+vuZGSCC/XBs6haeW5h0sfX9eoq27sX15qcbzN4PqAXWhmAhi0XDPExozBO6H7N5f7bvLAcJIvBdBWb60UaxaumE8k23A8I0jf9A3+Kh4QRMrmj/YzzZPIO3j2mi7P/v/C43HIThuYeGlSl4wBf/p4YHuq7QIzpTBYmaLEUYht3jbgZ8DQmrCAhbpTH7l7TCMXl50sOWxsp3tPH8WBNPYHbe36vdgi9dJSFfBCJbUYvrZeXbnpw28MaAs3Ut0HtCLlv41SQC4kfxifmPvm1A6wxGw/zGphvoc6/+oFBBk/mpuDibbkaeU8q1YRYjF8Wwd1VdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftcwUVxGs3lfGKuOWMu7iiIHgnO8yGb0y+S9gY3Ajwc=;
 b=O9xTAk1EUqkuFgEKWK6xN3aWLUIGQgJH30ckQjquGFb0Z7IeBahp8Dk42GzekLmTBCUm3awxSowtc+wdBv6GkktFjTb8X5tNh5CHPE1G/1ctfXb9z0blf06UP0K7cJnbob3MjmwY0D0JZLkZASEbbF2bS0bRsZne+RL5qWct6do=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 01:08:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 01:08:04 +0000
Message-ID: <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com>
Date:   Tue, 23 Nov 2021 17:08:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>
References: <20211123204644.3458700-1-yosryahmed@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211123204644.3458700-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:104:7::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Wed, 24 Nov 2021 01:08:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c07e035-fae6-4914-941b-08d9aee6de24
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-Microsoft-Antispam-PRVS: <BY5PR10MB406597C5AA26EB93D29A5278E2619@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE4YgF9nK2R454MaRZ9l+vrQTUOyr4yfZ7nvB8EU03pnUk3wiWB4+t0V0ColfW59UZxcea8MdxVK4tzuJ229rkn8z324T3MjsGCQgyk3sgnLVxzbyBpCNBGAcDs1ak/E8D0qRB/jynFGq4FR1vt1v1+f1idWMepDCFADcEx4DTm2Oy7pMWV8wZyi6lzoc5soLua5ZWl2kyHcQx7yqIeMcncoJjN96iMDHoiAFgsrepIPVVUk9HBdwzL0Vcg6WhO7v0ZdmpB3oqyq5G9uajYVVGwO6Z6Nyx2opDY6YePeSXI8ALfplnO6h2NQiNAHit8IuWEPivDKfNY/so1Shyiqyb6IQMQEbfWpYZkJ+SZjAjS+jjdBrsf/nwaUT99oJDf06/VEul+9PjsAKC0e7+Sd4myxk7BAYzEhrPllOnN+H7EolV+E5g11MaYsg3Dv7ldwJLUFrX9Q58F1WfKy9VdAejzeI5SpbbmSIvWebTkpaSMjBJqzyhRGPDh87ncTfWiqE2cyOZ6DasD20OhgBX6kcyLqaa4s3RnmF4+sk/891ConsEdV0MZPoKAXpYITAWYKofVBKbeSJqKw9TPqs6PArnUtwjECtu+EV8luhmi4I4USfmJQV3Vw6nPtMnskGWmvlIy0r/ZNVYFb5Tq6+WfnXJZFBT2m4O4FCSMke5EXpGRDOQiGdN3JZB+btt7w44TipJoATz0f8OmUmLLWRhnatwjoTM2Gw+8IaLXmF4kLJHEesTfO7VkDn49m5A69ReBzHDOSgB3t7vZ9EYf0YKpw1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(31686004)(8936002)(508600001)(4326008)(44832011)(38350700002)(38100700002)(2906002)(86362001)(8676002)(52116002)(5660300002)(2616005)(110136005)(36756003)(66556008)(31696002)(16576012)(53546011)(66476007)(316002)(956004)(186003)(66946007)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1RXNm1MNWpocitiUVlraGtFcE9BTmV4UkF4UkdIbXJxcDRud1FmdHNDQTFQ?=
 =?utf-8?B?bHhoU1h3WGQvMWl4Q1ZlR3YvZjgyS0FxZDZDZ1VWNUIyTTZvN0hIMzhnTlhQ?=
 =?utf-8?B?clRrUFhveitPRzM2RUVycjc2blYrMXJvU2cwb3c5SGxKZkRQdTdxcmZoZFVP?=
 =?utf-8?B?Z3YrL01ybWdodzhsckhnT0JiYStKRnAvM1RtcjdDeSsyTEpLY0ZSdzNIc0dn?=
 =?utf-8?B?ckxpSWpnRVdaWnFrTGt3WktrQmE2NzdRNWN0U3ZqNGVJQXAvZkdBenJ6djdE?=
 =?utf-8?B?S1NYMGMyZXBLWGcrMHpmcEJUemc5czA3ckR2NHpkSXcxQkRKYzhsSENFbi8w?=
 =?utf-8?B?VG42Ty96c3RoSUh0SjlGMUFxUHdSR1hVMDhzZDdTbGtZRlVhcDZYR0EyQTZR?=
 =?utf-8?B?SEJmd00xdXgzRVBXUE5xeUp3MWxMOVBORnQrQURrY3ZVMkhOSVBmbGJJejd2?=
 =?utf-8?B?ZEp5czBxek9EaVQrT09MODkrYmVWY05uOW9Oa1cwRFZwNjBadU1xUGozc1dt?=
 =?utf-8?B?aHdsVGh3T0M1WDBYMnBGM0RHdDRxdmxybkNRZHpGckNaNThvamNuZEhQYkVV?=
 =?utf-8?B?enBhcTZKKzhVc25GdjAwcEwzaStDNmRrdXQ2NVpxdTFKZGMrQlVvdkpKdVFI?=
 =?utf-8?B?MWdoeHZXSGU2aXhEb0t1dWpDOUt4aXVuQlJ2eWJaaHZhV2xXbVNhcmdFYVBx?=
 =?utf-8?B?dFYyLzdwZllCL1kxbjlzWXltVnVBZFpUb0RJOE5UalNlQTducTFMTjhIdmxy?=
 =?utf-8?B?SHpyaWZqZ3dhTWVzVFlBM256bTJoYUVsejNNWTVGUCtWZTBOQjE1V0x5em1D?=
 =?utf-8?B?RUlwaXliSHdEcjErci9aOVBuK3A2SituNm1tZTRlNTVDcHRYYzMvSnEyWFJE?=
 =?utf-8?B?ZUpKVFgwS0czMENScU15d3A4SHhnQm1PN1RiYVRaZUU3K0Jmck44NUpWY1pw?=
 =?utf-8?B?ZzlTOHFETi9WaG9nWXlldFF6VFFXU25WcmVRdk8zTU1PR0FrSU56Mi9nOFBP?=
 =?utf-8?B?QTlJa0VVaEVmLytWNE1ZKzVWUE84c3JNeVd3b2twQVlJczBBVlVWOXdOYmoz?=
 =?utf-8?B?UW9PaWhCWWVHenlRYndodUxnbHh6TFkxaWVnV3luRi9SVDlNcWhtejlWcHJ3?=
 =?utf-8?B?U3lmTzR0RWdPM1ZkdlV0U3ZlSHZmZHd5eUhCVmkzUUFwRXQ1Qkp6ZStKcG5y?=
 =?utf-8?B?R2kxMm1iVUJQWU0wOUdhZjhHd08weTRpRXRUbkpWc3doeHlEcDJXdmNyS2xF?=
 =?utf-8?B?V1FLQVBTdGtOREhGZ1ltWHFueE1YMWZ2Q0ZSbUFUOStlSXJoSURTQUFTZWZE?=
 =?utf-8?B?cWhtRnh0SWpxMWV4blU4TnBxdlVFcUtwNktXYmZPRGJXbDJpUU8vU0N5eDN5?=
 =?utf-8?B?MjBsdXU1N3E2T0xLQlArRC9yWXZzbUdOQTUzcCtkb2VlRGJRdktiK2NUbnZq?=
 =?utf-8?B?RkU4VlNJR2l5RE83ZDJUNFdTMXVWUk9aSGYzZWdDRXBXc1BNamJHQ1o3SGpS?=
 =?utf-8?B?eFhPbU9BK0lPa1RxLzUxNVVlYnBTWFBPakUrZElhSWpYMFFRNTZIaEZSdU5X?=
 =?utf-8?B?eXV3MU9lSnU1Y3F5aDhpR0ppQXNzVHZoL0ZHajlGTGo1TVhSTHBiUTZRYSsr?=
 =?utf-8?B?OERaVlJ5WkpOQkNGcnZwRlgxeXZJUjRiUEw4SXBiY21Za3dIN2l0enFqUFpK?=
 =?utf-8?B?NzdleDlmWXg1aXIyWWxJdFdNUGVyL0xrdjJWOWlNZUdOSVk0a3pYeEVqSnlp?=
 =?utf-8?B?MXlQalkyTWhUWS9NTWJ4V2ZEait5TmlRc0FkZzY1VFUrT1A1NFRoMXNTRmNz?=
 =?utf-8?B?bjJpMWd3bFk1SldhbEpFV0FTZ3hQSjROeG5QQTkyak1CalZpSW5pWE9iQTNM?=
 =?utf-8?B?WmhqT2ZxSzRVK29qc2tINnhEVlNmclI1a0dMZEpsWVlIZUIvc1l6TzhEZ0dC?=
 =?utf-8?B?ODJzSDVqck9BbGNKL0JqZ3p6ZDB3SjZNa2FuVUpQUXEreit4enFtMWlIYUxP?=
 =?utf-8?B?akMySzRxa1FQNVhCMDlCd0ZNSm9JWmJDZjVyN3U3YXJLaTB1bUc5OTlEd1hr?=
 =?utf-8?B?MGE4RThFYmVzUU9FZGEreW5DSkVuUTdENE5Ea1QyOFh2QnAyUWtheG9vQUlt?=
 =?utf-8?B?bDE0anVPNDh3b1JRUCtrNFczcmpVeW5YT3FjMTE3MU9FSWpIbWhoV1FzbnBT?=
 =?utf-8?Q?TZBsV3V4JiqdnwHBu0bm01U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c07e035-fae6-4914-941b-08d9aee6de24
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 01:08:04.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG6HZG2+TYV235LmSm7bXz0ja55LfhrLm9WHQB0+6Dt4fQiDRSeyitaLe3iTW10iVsaOfD38HXAPv00iZZKWWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240004
X-Proofpoint-GUID: kOy14rbntoRtYc5eh2hduSIeL7dsW9I7
X-Proofpoint-ORIG-GUID: kOy14rbntoRtYc5eh2hduSIeL7dsW9I7
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/21 12:46, Yosry Ahmed wrote:
> The hugetlb vma mremap() test mentions in the header comment that it
> uses 10MB worth of huge pages, when it actually uses 1GB. This causes
> the test to fail on devices with smaller memories.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'll let Mina comment, but I think I know what happened.

The original version of the test did indeed use 10MB.  However, the mremap
code must 'unshare' and shared pmd mappings before remapping.  Since sharing
requires mappings of at least 1GB, the size was changed to make sure unsharing
worked.

In the end, I believe I suggested adding hugepage-mremap to run_vmtests.sh.
The script does not try to configure a GB worth of huge pages.  And, I think
it is somewhat unreasonable to suggest users gave a spare GB to run the test.

I'm OK with restoring the original value.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
