Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D3501E36
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Apr 2022 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiDNW1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiDNW1O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 18:27:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49125AECE;
        Thu, 14 Apr 2022 15:24:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EKvuFn014133;
        Thu, 14 Apr 2022 22:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E7kQgRSLVqahKmxKZzLWMGfXKfPKTjxNOfxmojvXUZg=;
 b=kfqFMWhnolvEoXfRn7Mrb/DBN4Ra29zbVGjkYmDnz3EaR3ZPv070l18eHINLJ/AwVMgy
 CPV5U1SjVY+sDfzE4JsmtuprPRKjVCkh1a0hVxeA8TqlnFu/XAPsWCxREPEaXQn8yfQ2
 friX+T511wj+90VVm8rPMOhbG752lcGOdiZLoMDZGfGcXJFFOcjIksHkZNShjpv/lNOc
 /QmisqOD23tIzqldgS0MuZrH11PFZ9GFxIDd+E1rej9ze2xsyCkhJfC+663eNsCpzvNi
 S31OwxnvNkRhhTL5xug4QmBE270fT6nBAaHKh1S3IZEuTiSN34JVSBASSz4PMz3eIQcv og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu6be9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:24:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EMHQPL020978;
        Thu, 14 Apr 2022 22:24:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k57ddj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzRsxf8v5EiU91Z88pjDL0NWlRzFvg0S9s/wdycCq1e3FQPR/3S0Egkjsu81iTQqdcQ8rptglT9AnYhIqJ9BizaJZmea6m9y/PBuicBQ5AXDD8/Bh9t7kCaBHEIdzyy6nAinAFtRMPKdnvlMapKml2iO/VewqXgFAFKxzFCu/T481OpGv4Oj/YuCX6+dxagqUVBdSixRjgdMX54G76jv5Xpd0SKD4YR5BQ4m2rSGMvYXwXX0saObE0xqZr1S3p/Of1CCnKkryqyr63MZaxf3P3P5FbpWlPc1Kr1k+EBEm02GisUgENqo82J4Ygm+QEtPYtp0PtASOdWu8cJFvd/BqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7kQgRSLVqahKmxKZzLWMGfXKfPKTjxNOfxmojvXUZg=;
 b=Hh+MhdCy1HjciqnBQgm6emcf5AtPEvlTNeMwgtHM2khIViNF95nPjPl6owPIp1JyzrTBeKJIbax/X75pUU5pXoDRyepKluqITBo6nrHLqBBbnEOve46ldwKg/Wor2Ar/7pW3G6FYobGAjQyWqudOVg0JZIG73rCbxTPu6iWxhRTx19+lNgxxEJESChmG/kxFoy7iFnCFn5iGktv+kLk87113kPwG7MmP1+IcU8llX+aifWy3uPzaCKvEJlQot2uO5xDwj/GNSnuCHjHDkDBw/yO8nuKaNjGE1ABGZVCpyUu5BC+busp7qr/uibHf+indyyLLmz5U0yGbNiK/q+zgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7kQgRSLVqahKmxKZzLWMGfXKfPKTjxNOfxmojvXUZg=;
 b=lVsTBgpR5q+YfSHJnqgYq8MCxw8tjER4GKEAwdExx/0bLvrsefh3hY3EyP/Nj2OTGF+WCgGWRymXnR0UHSMRyqR2xYhEUoNzFvRQOxT50/4n9khZ55HhfVFQFUNyZaaiBdhtkZH8dnjmky1bN3CYvE9xtmXIDgaGP3IP+peZ6ko=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB3962.namprd10.prod.outlook.com (2603:10b6:5:1fb::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 22:24:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 22:24:36 +0000
Message-ID: <7b1c0a82-f7c3-4f60-ccb3-893caf4221f9@oracle.com>
Date:   Thu, 14 Apr 2022 15:24:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/4] selftest/vm: verify remap destination address in
 mremap_test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-3-sidhartha.kumar@oracle.com>
 <e6cc5cf6-b6bc-2eca-255d-5dd247253255@linuxfoundation.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <e6cc5cf6-b6bc-2eca-255d-5dd247253255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:a03:100::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d94769d-e8c5-434f-c1d7-08da1e658eaf
X-MS-TrafficTypeDiagnostic: DM6PR10MB3962:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB39620664DA03464CD816DA2E95EF9@DM6PR10MB3962.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuIzb9b2ZsxSX84JRzRDn8irtihm51gyXBaouwVDqzGwoR1bIK4anw57xZkbEhKRgUV1Cb9uiZRJLwGwFIpcXLyMcOc+CPk/BKmJKF0256ElDjTGP00jPxkBEHueAizoAdYvpxsFgA3nw/KUQ82e3Oiu8DTMRI9/wHlkHL+BJ4cwLnn9gmNUxnVLC7M1R0zzMPYff7pHd8nMSK1lvxU5niQke2Yq5Sf9ZY/LQaRhl+tR1vnv2uH3HMKV7QWa3JXFWKe8VIl0W5R9aUw7J2947D+kkm6viAbLW6zXxvxhj1tEnOouqv30PSkZGiNzP2Veg5h91CclJNOlam1OaNMAxdQssrmS5M4Fix09YRViPs6JRew7wn4F3B7Rp+uvGcrL9UQyMWLvS1zZI98NHmld4DFDozdULlTeWgCofr9BRi3ZwgW8h9+yvEUkWGnKrMMoscF/XO5zljpxbAX/1NKjIpRJ6JOKXJdxuLIYmkGQBSVq7i+u21etKgP+0w9sZckWQ/VJWTLurUo+ag9hMDyCtsCzfsQfhevCn6h/HHRP2cKTd1GCRdV2QcvoSGnFiqcjqEs8EB8yAucu6Choq3KortUbSrxmi0ykVnjLN2tU9M87eGyZm2EC10phUf/XdxNtjGqw1R0aKU703BCqIDYblrH4xStrY1nm4eW+klz5Eh4pros4JWVaJXnQ8cd4EkXFPEJn8hialkBttG9RO2gh4JrKt327Dth6BT9CFQ5B+ywkBr1TnM/i/5W9z6DN8Gr6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(66946007)(44832011)(186003)(86362001)(4326008)(31696002)(36756003)(508600001)(5660300002)(15650500001)(6486002)(38100700002)(2616005)(8936002)(83380400001)(8676002)(316002)(6506007)(6512007)(53546011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlGVmxtN01McXF2SXhlZXlwMnorcFROREVma1RGQmkwN0RERnFQUklrblhF?=
 =?utf-8?B?WnlXZXFOSGFQSDJLaUE2MTlRY1Ayd3ljRzdoT2ZmOFFUb3BoUFN5emxXYTBa?=
 =?utf-8?B?M0s5cjdzdG1PTjNiMkFxa29SdFFIbU95cGtlNllza1llL0R0ckZtQ1E1L2R3?=
 =?utf-8?B?dnZSKzBMTVAveVFSc3YxdGs0MkphUU5lL2FKd21QQzFBRGs0cmw5WXI2Wkdv?=
 =?utf-8?B?dmJHU1dPSHRzVnU2SVZSYlU4U2Zwc0U0dG1nSHAybzV5TlpXUDdrYk14dXRU?=
 =?utf-8?B?UUM0MVFxc1J5eVJ6bnNvZHZxUVZzVFg0Q2FadVlhdXNLVlllbldLMUVSTytO?=
 =?utf-8?B?QkplQlpCSmJhWHpRek9nMDJsbC9IWG9jTEtwTk5EUFBxdXRIaGRFMTVpaWNj?=
 =?utf-8?B?TFlJZ0laQkhwYXJVOVl3SWVKYmRoNHFHUkpVVDFWdTFJcHdhcmQ0aGhJT3o4?=
 =?utf-8?B?TG9ZK09CUzhsVGtLbmdPMStjSFhKQTYvUktBc05rMXZUakJlZllYaTI2bXp6?=
 =?utf-8?B?aG53NU5EWEkwMWI4bzhEZHVSYWtuL0Y3ZmZNTXFZa0c3YWZrYTdCeXRJU2t4?=
 =?utf-8?B?Z3dTTGIya3I1QW5qQ1YrR0x0bVdhRkN0RzBlalViR0RCZ0VLaVBVZlNaM3V6?=
 =?utf-8?B?Q3cyam1BWEJyaVQxRmtIbmZ0cko0Q2hIRzFKU2loZFJFL285ZWgvL2Zpakdl?=
 =?utf-8?B?NWtjUWcvRVZBSzY4MUpZcHBhTTJrYzJ2QVFvbHhsK0xsTHBRcVVTSmY5M05k?=
 =?utf-8?B?SUhwL05lbjAyTDVSNUc1MTJuaGF1Z0VLWkpQSklnRlBSWS9lTE1TRU53ZzBD?=
 =?utf-8?B?Y052UFJ5REZ1TU9rWDBJdDBpTUxJelU3NkhDMzJRUHBZenN5VGVTbmpMVUpa?=
 =?utf-8?B?M0pQSlI0RGsxbHFwRmt3TjgxS2k1YnVXVkUxQkZBL3ZGZ0JCK01wVVZKUk1s?=
 =?utf-8?B?YUNDMWN3TE5uOXlaeEhEZTQzUjZ5aldyQTBnSUxrMnRiR0J3UlY1OG8zRExn?=
 =?utf-8?B?dmdxZzI4Mk4rY3B2NVhjcGx4WTJVV09iamlKWStQa3lPYkEwK3FiZ20rRTli?=
 =?utf-8?B?bkNPVlJyM0xKWFhrNVAwMWRGTzh6c3FyUmFacjd4Wi95VUlSWlAwdFU5U3E0?=
 =?utf-8?B?eDFtMUQzTWdZM3haTm8vTDVKVDhJK2NCam5XZkxBZW5ndG5xWmJIMGZqSHhP?=
 =?utf-8?B?Ull3cnJVbFpaQlQzeDAwQWRsZmE2djVOK0lCZnJIWkxNL0hLRUdPeTRWd04r?=
 =?utf-8?B?MjVadktGQ3k1M3p6MVI4VVl6ekRKSjJzSmp1UC8vZWV4OGVzK0ljUnhHMm0y?=
 =?utf-8?B?OVhKU2VtTDVhWVRzL2QvRGpJL3JwRkFqZUFsZG5Sa3AxSEdiZ2tSem5QK25J?=
 =?utf-8?B?clNrK0dVOURTSnV4OGQra0kzdGFMaWRJVzVJazhqOVJNSFB5eitZeUVtaENK?=
 =?utf-8?B?RUl1SVNEMnF6bkUzRlE5T0hMMHBRSVNQWVBTVVNydU53SHJrbFpHZ1J2Rzht?=
 =?utf-8?B?aWwwVDU1OGpLYXVjR1hYaWt1SWZNUFdqU1RwQjdjb0o0amVLdWtrcFhwSUQ3?=
 =?utf-8?B?WnhudnNPY3pzY3JPU3VVNjZxemlmMWFMYytoME9ETmZwemtQQlBqMHlScnlU?=
 =?utf-8?B?cVBhNEt4a0R5N1JYVWxNVzNjNDd1R3J0Q0tmaG53WVZwbW83VWRPM2s5bXoz?=
 =?utf-8?B?RTVFYi91Q1ZUUjNDUU9ibHlseFgzUDQ2UmJrVllTUG5BQXZFc242WWd6aXly?=
 =?utf-8?B?YkE2Q0hiMFpMeElwdWFPRExFVjRIdUVTN3JYdHltUlBSajNZV3dEaEpJSGsw?=
 =?utf-8?B?NXBWOGZJc3hROWJVa3FPMTFNbnlQdmdrNm53amZRdGk4Q2pMdDQ5TVBqU2Zp?=
 =?utf-8?B?dU5VWGlaL0lncjJUc016azZXblFVeWFIQTlvU29YNHIxV2FDZ050QkxsbTA4?=
 =?utf-8?B?MWZXVktKS1lDYXhqN3dGMTZvdjVJaDZuOG9EOU9yRVJJZmdwWHpQRzlpa3VJ?=
 =?utf-8?B?aXlkYXpReGVjWjN4U1Y5a3QxS1ZwOWVsL3dUYUJyYmtrNTQzcFZwRkFhb0ow?=
 =?utf-8?B?azl2R3I4bWxGNDh6bUNSdTd4ZDFQTFpmSXJoZzcwSnJRV0hJZG03R2xDWkxI?=
 =?utf-8?B?NER1UDliaEMxYzZNaGF5b1VOcG9LN2gyeklZdzYza21FZmJrN2c4S2lTaTFh?=
 =?utf-8?B?TmZmcGhqcEFiMFpOUnhZcHZQYThCendHbkNIdjAxUUVyVTVId2pua0YxK2Yr?=
 =?utf-8?B?SDlBR2hDSlJzdmpya1d5SDBHaWJWMDZ3WGt1dUlja2wzNjFnbys4YlVzdkNX?=
 =?utf-8?B?RVdnYlR5bEgxZmtqeDZPQmZ5c2l6WUxYVGNtMGQ1ajVOaGFUTVd3ZWw0WFVF?=
 =?utf-8?Q?OSRJYmypHnEsCWDJKOOiNVuqNbQFXdYFRZmxffc+dwq1f?=
X-MS-Exchange-AntiSpam-MessageData-1: za1A6eNIi1c2Mw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d94769d-e8c5-434f-c1d7-08da1e658eaf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 22:24:36.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8SBliPv+q74M66zDCgvpndLKXcMFgcIuJCgNhhXAAIAfMHvBs41S6LaGMT500htC1sMGee2uQyr7DQwchoVHBh0DySApNBc0v6DuziJJR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3962
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140116
X-Proofpoint-ORIG-GUID: qx4X9w1kie0SV8_fi8JsLn8LYfW4NSjL
X-Proofpoint-GUID: qx4X9w1kie0SV8_fi8JsLn8LYfW4NSjL
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/14/22 2:47 PM, Shuah Khan wrote:
> On 4/14/22 11:15 AM, Sidhartha Kumar wrote:
>> Because mremap does not have a NOREPLACE flag,
>> it can destroy existing mappings. This can
>> cause a segfault if regions such as text are
>> destroyed.
>
> Please explain the reason for segfault.
>
With the MREMAP_FIXED flag used by the test,
the text region, which fell in the range of the remap
region, got unmapped. This caused a segfault when
trying to fetch the next instruction after the mremap()
call.
> Add a blank line here. Makes it easier to read.
>
> Verify the requested mremap destination
>> address does not overlap any existing mappings
>> by using mmap's FIXED_NOREPLACE flag and checking
>
> Spell this out fully - MAP_FIXED_NOREPLACE
>> for the EEXIST error code. Keep incrementing the
>> destination address until a valid mapping is found
>> or max address is reached.
>>
>
> Essentially mremap() doesn't check for overlaps and removes
> or overwrites existing mappings? The way you are fixing it
> is by verifying by calling mremap() with MAP_FIXED_NOREPLACE
> flag and check for EEXIST.
>
Yes, with the MREMAP_FIXED flag that the test uses, any previous
mapping in the address range of the remap region gets unmapped.
Yes, fixing this issue by calling mmap() with MAP_FIXED_NOREPLACE
flag and checking for EEXIST.

> What happens when max address is reached?
>
That is covered by the check if (addr > ULLONG_MAX - region size)
in the remap_region_valid() function.
> Same comment on # of chars per line in commit log. Also
>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   tools/testing/selftests/vm/mremap_test.c | 36 ++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vm/mremap_test.c 
>> b/tools/testing/selftests/vm/mremap_test.c
>> index 58600fee4b81..98e9cff34aa7 100644
>> --- a/tools/testing/selftests/vm/mremap_test.c
>> +++ b/tools/testing/selftests/vm/mremap_test.c
>> @@ -10,6 +10,7 @@
>>   #include <string.h>
>>   #include <sys/mman.h>
>>   #include <time.h>
>> +#include <limits.h>
>>     #include "../kselftest.h"
>>   @@ -65,6 +66,34 @@ enum {
>>       .expect_failure = should_fail                \
>>   }
>>   +/*
>> + * Returns 0 if the requested remap region overlaps with an
>> + * existing mapping (e.g text, stack) else returns 1.
>> + */
>> +static int remap_region_valid(void *addr, unsigned long long size)
>
> This returns bool 0 (false) 1 (true)
>
> Please name the routine - is_remap_region_valid() and change it to
> return bool.
>
>> +{
>> +    void *remap_addr = NULL;
>> +    int ret = 1;
>> +
>> +    if ((unsigned long long) addr > ULLONG_MAX - size) {
>> +        ksft_print_msg("Can't find a valid region to remap to\n");
>
> Change it to "Couldn't" - also this message doesn't look right. We hav't
> looked for valid region yet and it just exceeds the limits?
>
Because this function is called in a loop in remap_region() and addr is 
being
incremented continuously, we could enter this function with addr high 
enough that
another increment would cause overflow.
>
>> +        exit(KSFT_SKIP);> +    }
>> +
>> +    /* Use MAP_FIXED_NOREPLACE flag to ensure region is not mapped */
>> +    remap_addr = mmap(addr, size, PROT_READ | PROT_WRITE,
>> +            MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
>> +            -1, 0);
>
> Alignment should match open parenthesis here and in other places. 
> Makes it
> easier to read the code.
>
>> +    if (remap_addr == MAP_FAILED) {
>> +        if (errno == EEXIST)
>> +            ret = 0;
>> +    } else {
>> +        munmap(remap_addr, size);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   /* Returns mmap_min_addr sysctl */
>>   static unsigned long long get_mmap_min_addr(void)
>>   {
>> @@ -180,6 +209,13 @@ static long long remap_region(struct config c, 
>> unsigned int threshold_mb,
>>       if (!((unsigned long long) addr & c.dest_alignment))
>>           addr = (void *) ((unsigned long long) addr | 
>> c.dest_alignment);
>>   +    /* Don't destroy existing mappings unless expected to overlap */
>> +    while (!remap_region_valid(addr, c.region_size)) {
>> +        if (c.overlapping)
>> +            break;
>> +        addr += c.src_alignment;
>> +    }
>> +
>>       clock_gettime(CLOCK_MONOTONIC, &t_start);
>>       dest_addr = mremap(src_addr, c.region_size, c.region_size,
>>               MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
>>
>
> thanks,
> -- Shuah
>

