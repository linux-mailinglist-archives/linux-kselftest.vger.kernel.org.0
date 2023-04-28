Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840616F0FF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjD1BUU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344665AbjD1BUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 21:20:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836B212C;
        Thu, 27 Apr 2023 18:20:17 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S01Gt1031786;
        Thu, 27 Apr 2023 18:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=b+IL6lki3t07t+VRGNFFC2DRyZWTeBGI3jrGva87ies=;
 b=TS9ob6gulyBMO1DITs27lUKwlqQjEBrI6Sfb0/11eW26uzDCXbEdO5ZTRCaGe++G/muo
 jNjdSbPbY5T6KKrHW21iLEQ7STN/a9TCpYoKh8ksSlmMbWSkgmHPW4g1hjVvEEQhUwEc
 SFs2peuEelQAd33LZs0/EvFjJq+0JbO9jlekM8OPIm+2ePFVY3OO2OuCbZe3GZePaI6M
 E5o6PQSGXqOMOKFwFm05qdrcT7jCM6ol84Bd/e0K+PD8k0O5EBZUEu4ihRMV9KTFGG7L
 F8JaGtl+o6Alh8GfZtY7vzjqUZ7UX+QRa43ugKjqggJ4x0mvSwn0x/bkhZ+1hUCt4ZV8 yQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q837ugbje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AilQBcHjZbtVqHiRlqH+Yv/nqRe9J2sW82pIDZat7MUu+Cxj0MTuroMYEk/Ws7ekpdlAqsmvmPH4s1SJsnqtzUI5crdqYtc8trnK1aSwd06IC97yyEJIA+8zIAZoIGOxPkHfjghJxWL29B/wri1btrc4m5T6Fz+2YpuX8jsZCK4ey/GzKX6KusdrgoQT7Dln7dMfQdd2v6hRt1ofQveOGBVaWgL1zyDS0Bi/P28dLurV/tLFs4+dyVDuCieOBpDv16kRJavnmRn1mMiBRyRZwAVADZNzjrvClK2EDg4hyk6nG8wQslg5BZdM8L1ioe6Hcx4LQWIl2Uy2RTzgLr5hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+IL6lki3t07t+VRGNFFC2DRyZWTeBGI3jrGva87ies=;
 b=UIeCJFOokxGBzplFSHT9/tGO+39Gvslh9LL5SHrTjQIchdzlJlJExi7NFUPbyMeDDyADwNJmcziGsqxOKyhnnC9rnRXbIRXROdEGObw9lupTisvIbY3q6MmasNx+ad1lsivILwm2+kv3v432GVLYvMb0jMkKnFLnm6rFHL2TDZR1hmG6O8SNNtYqGkas2tOlsH2jd4GmHacDqzwpGZ7lTnAUQWRmWJvL7RYjEISnlCmVlW+qUmPRGytw8mceQyzll1w9KPu/vj8suuBkHmnDH5xQyamLaJ4Ggh7z86DwCDci8RV8xjfQw94bjOTvhm1EQEUaDoqtFQ67yDCN04OeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3828.namprd15.prod.outlook.com (2603:10b6:208:27d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 01:19:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 01:19:34 +0000
Message-ID: <0e7b884a-05c3-83c7-0de1-9bfe14ff77b3@meta.com>
Date:   Thu, 27 Apr 2023 18:19:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
Content-Language: en-US
To:     Espen Grindhaug <espen.grindhaug@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <ZEV/EzOM+TJomP66@eg>
 <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com> <ZErK0M/qAi/VS8U8@eg>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ZErK0M/qAi/VS8U8@eg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3828:EE_
X-MS-Office365-Filtering-Correlation-Id: ed135a75-14f3-4fb8-bd19-08db4786a012
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtyCQTs8neUKjFmuoGHOrcVG17tMCrFDPKFxo6VpgY3sY+SYgvn2qQ55uBCbOvD4CgUO3Hkk1A1VErkQVwiAyQR0rRfZZw5g1+MF77BzrSCFeWMpPnrxVX27lgd/PXw6W9gien8TYOxufTd3R3WkvVhbuABxE+/G8PaUivJOsVMx6dpXkwWCafIZB898Aw0u7Ra/PnA34QZKP2Vi0QshMD1RilM+CRgB3QgQOc033m4ODokTa6CGaUms4rSZ0FDXCxyIfaclyIUi3szlUGSW3q2F0wDp23geYyrNr4h+PVbwXkiGrYcLjvxQrnciWkSgt8sNNuVhuUj0KPGIV5GNvh8P27lLFVW2ufF5cwpx9Ygqp3rVTKP83CLHh6CyNPMFezpk/+VuPCAuMfhBChbGKMW6Zm4AZfiFv/Q32seYjLTdurGu8xBBHfqg19gb0O19rEChD70/0EB1H6CKNZLmYjsy6oAioVmQy7glsrHoCgRmFVXy8V3YCPKhHLa+0f/Sc7IPrbMJIbtKsLVk/QHboC3HR88Bwd+L/PQqGJpb+ovM5xAqZAQ6tWrmG0/N2xu42w0ohQQJpLOfOKJetixaVIc/CBNPuhZLDW9e2Ao8H8IulkBeHXytonhIUrKe8LBTqoLoPTHYXLA1c1MEmLbCVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(31686004)(2616005)(36756003)(41300700001)(38100700002)(7416002)(2906002)(316002)(8676002)(86362001)(8936002)(31696002)(5660300002)(66476007)(66556008)(4326008)(66946007)(6916009)(83380400001)(186003)(54906003)(6512007)(6506007)(53546011)(6666004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdWQ3NvZFEzbjZ4Y2l1WGo4cG1DQXA0eXRLUnRnVDdRVWdWTWwraE9CSm1m?=
 =?utf-8?B?TUVrbjdDUFRFeWcvV1Rjekd3eklNVkpSZzBlSlJYTUhDQVdNT2gzbWhxNUxS?=
 =?utf-8?B?aFY3dnZUNUFxWXhGUTAwRkdjL0tOYnk5dUxmWGtabWdhbjZQbS9ROHo2RVlX?=
 =?utf-8?B?RGkvRGM0TWZpZnZ6K09jdDkyTHFGRVhjQnhUUnhzMVNRdGhHQVhrUklaeTZr?=
 =?utf-8?B?K2pQMkVRQ2x3SFM4aXpYNFFEczhKM0pZSnpFNzZBS2JhVk5jeURlOWNnS0sz?=
 =?utf-8?B?SitRZHZiMjRHY2ZFT1lKOUFwZmZEdTZYa0MvcHdkUUpHcFJXSzI2S3hPTW9h?=
 =?utf-8?B?RHg2VWJqZWoya1JiLzV3aVUzT2QxRlN1M2x1UnJDa1VFdzZIcklXQW1mRjB5?=
 =?utf-8?B?VjFJaG4vSmhLMWF0OFlsWld5T0twRXp3Z2lhb1l3WjlBK1hWamFBV2RYeHNW?=
 =?utf-8?B?cGNjTjVPZzV1WlpsejZzU21zV0ViSnRZV2pUY2tWRG9VenFhei9ZRDE3NG1E?=
 =?utf-8?B?OVNWV0crNmZzajl3Z1Z3THVydDc2akxKZHZ0aEpLbUpST3dqazJvZk5IM3hG?=
 =?utf-8?B?VjdqdnUyLzZyNUZhWmRueDBhUW1FWGtkZVdLRWpCZGtOVW1zeUJ6c3pMUUhj?=
 =?utf-8?B?REF5eWl3RmVuQ1FNcWVWdmhNaENHMXNsTk5Gb0NaZVdnVFZhdzdWVWMyQ055?=
 =?utf-8?B?bFZxVGVicFRtOGRCVzIzRHFFU1ZDL1dTNEVITDBDcHBkekdhb2R6UUpmbHpJ?=
 =?utf-8?B?Q3NaaUtYakJZVjhPeUVrWGlLclBzczZ2dlZCNG05aFZ6a21GNEtGMENXelhw?=
 =?utf-8?B?SnB1ZHdabDRwSG1KeTNEN09rQWh0Y2pncWJxY2lqb3dqTzlDYXh2OWZmRVBk?=
 =?utf-8?B?cnk0YVdPSWtGTzZRUytHeGF1R3Ixb2l4YVIxdWNsZXMwWnJIdDVRSlNhaGZm?=
 =?utf-8?B?bnQwZkJuVHVKSFYvWU1MVEZnMnFXOGRwMVNRWGFJdE16bmFuM2M3eVVtYkRE?=
 =?utf-8?B?OE9rUWFpQVpOMjFBQndFSmFPNVpzcUpFY1M1UTQ3bDloQWIzVDBNdUJwZjlJ?=
 =?utf-8?B?bUxtR3BQa2QxRjFlcm0vaVdxa0VGcUR6Rm5aMkhIQ3VHS3VyZG5lVXdlcTRT?=
 =?utf-8?B?U0E3SUttUXl0WUwvNXFId242Z29BWjJYRTZUTktHcDE5YlgzWXllQzdaUWFk?=
 =?utf-8?B?UFU4UjQ1TjA1YWxGWTFxOGk4OHJFS2pnSHQxM3k0TjRqZTdNU2NoMUl4MkVw?=
 =?utf-8?B?Yllrc25ybHZSdXl2RUtqbVQ3WlB4NUFwRCtpQUwrUmlBSjM1bUtoMlBDbmZm?=
 =?utf-8?B?WmxzaS9MRWxydlhUMlJQUndxVVYyOGJHSzBVRDJhUGF1RlF0TVZZRjNoczJC?=
 =?utf-8?B?aVlWWXk5dUhibEVkWkc2RG9sVzgxOGhsa0NtR042RkFLVG5WWnZiTnc5WUV5?=
 =?utf-8?B?c1FjSy93dmQ5OWtrL0pMNmZ6OGg0c3dKcE5ucjhWbkFyc3k1dEhRM2tiakps?=
 =?utf-8?B?Z0NNcDlzNTVWMUpuelJOdGxwYm1VVmFtbHQ5R0NjTm1KY0hwR05BZWhhUXhl?=
 =?utf-8?B?VCtQMXBMQTJsUDdJb2p0SFlrRzc0Z1ZvT3hRV2ZNNWZINDlUdFdQVzNTa2tW?=
 =?utf-8?B?VncxcEZVbk1NZ2ZIV1VhaWgyZVlyZlFpZE5xdzd6bm1WWGRpQkNoU2JCUnlO?=
 =?utf-8?B?eXJHcGpuQnBYaWJDcGZXb0lHN3dDLzFsSzBFb0M1OWd3WnRLWlhOb3owVGhk?=
 =?utf-8?B?TWY3WVBoOHhkL1gyQ1ZSWTU2dEh5ci9SeUt3T0FGUGIrTE84SFY4dW9PRXdC?=
 =?utf-8?B?dDNJOTZQbkJqZXVhcmFDN0lXdjhZREhlbE5DV3JTampBL0NqejV3a0VEVmhl?=
 =?utf-8?B?ekJvTlZIaFk5THFLb3lIMHlGWXdiWkEzYStKSG9FTlZ4Qzg2SXA5RG5IKzBz?=
 =?utf-8?B?eVN4NVBEM2drWEhwcTBsOXpHNkNCZHQxdFFCYVpEWlZHWGZBeFJpQWhiQ2hB?=
 =?utf-8?B?eFJNMTltR1Radk0zNXNJdzdaamdQUXd5elN1NzlNVStyWmR6VDFjbzRjbHZs?=
 =?utf-8?B?Q0V4OUVsaXc5UWJpVmVCNGdFZGpheVlEOC9WeE1ZTWxyeW00U3dSNWxkaTIy?=
 =?utf-8?B?YUdlL2xYWHpJMkxlVFRwazJyM2FPNHBFQm4wVGcxVkh3blBVcmFlR0NROTVM?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed135a75-14f3-4fb8-bd19-08db4786a012
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 01:19:34.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGzqQOcDH7rQb4f98ExdhAUCQM/mhMVbb4c2CAlfa3RKXseWW9r7tbiLTkRUaTkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3828
X-Proofpoint-GUID: Y0AyB57-Hrj1c0Ei0AQ0Li_tajhdzrLH
X-Proofpoint-ORIG-GUID: Y0AyB57-Hrj1c0Ei0AQ0Li_tajhdzrLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/27/23 12:19 PM, Espen Grindhaug wrote:
> On Wed, Apr 26, 2023 at 02:47:27PM -0700, Yonghong Song wrote:
>>
>>
>> On 4/23/23 11:55 AM, Espen Grindhaug wrote:
>>> This change fixes the handling of versions in elf_find_func_offset.
>>> In the previous implementation, we incorrectly assumed that the
>>
>> Could you give more explanation/example in the commit message
>> what does 'incorrectly' mean here? In which situations the
>> current libbpf implementation will not be correct?
>>
> 
> How about something like this?
> 
> 
> libbpf: Improve version handling when attaching uprobe
> 
> This change fixes the handling of versions in elf_find_func_offset.
> 
> For example, let's assume we are trying to attach an uprobe to pthread_create in
> glibc. Prior to this commit, it would fail with an error message saying 'elf:
> ambiguous match [...]', this is because there are two entries in the symbol
> table with that name.
> 
> $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
> 0000000000094cc0 T pthread_create@GLIBC_2.2.5
> 0000000000094cc0 T pthread_create@@GLIBC_2.34
> 
> So we go ahead and modify our code to attach to 'pthread_create@@GLIBC_2.34',
> and this also fails, but this time with the error 'elf: failed to find symbol
> [...]'. This fails because we incorrectly assumed that the version information
> would be present in the string found in the string table, but there is only the
> string 'pthread_create'.

I tried one example with my centos8 libpthread library.

$ llvm-readelf -s /lib64/libc-2.28.so | grep pthread_cond_signal
     39: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14 
pthread_cond_signal@@GLIBC_2.3.2
     40: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14 
pthread_cond_signal@GLIBC_2.2.5
   3160: 0000000000096250    43 FUNC    LOCAL  DEFAULT    14 
__pthread_cond_signal_2_0
   3589: 0000000000095f70    43 FUNC    LOCAL  DEFAULT    14 
__pthread_cond_signal
   5522: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14 
pthread_cond_signal@@GLIBC_2.3.2
   5545: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14 
pthread_cond_signal@GLIBC_2.2.5
$ nm -D /lib64/libc-2.28.so | grep pthread_cond_signal
0000000000095f70 T pthread_cond_signal@@GLIBC_2.3.2
0000000000096250 T pthread_cond_signal@GLIBC_2.2.5
$

Note that two pthread_cond_signal functions have different addresses,
which is expected as they implemented for different versions.

But in your case,
 > $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
 > 0000000000094cc0 T pthread_create@GLIBC_2.2.5
 > 0000000000094cc0 T pthread_create@@GLIBC_2.34

Two functions have the same address which is very weird and I suspect
some issues here at least needs some investigation.

Second, for the symbol table, the following is ELF encoding,

typedef struct {
         Elf64_Word      st_name;
         unsigned char   st_info;
         unsigned char   st_other;
         Elf64_Half      st_shndx;
         Elf64_Addr      st_value;
         Elf64_Xword     st_size;
} Elf64_Sym;

where
st_name

     An index into the object file's symbol string table, which holds 
the character representations of the symbol names. If the value is 
nonzero, the value represents a string table index that gives the symbol 
name. Otherwise, the symbol table entry has no name.

So, the function name (including @..., @@...) should be in string table
which is the same for the above two pthread_cond_signal symbols.

I think it is worthwhile to debug why in your situation 
pthread_create@GLIBC_2.2.5 and pthread_create@@GLIBC_2.34 do not
have them in the string table.

> 
> This patch reworks how we compare the symbol name provided by the user if it is
> qualified with a version (using @ or @@). We now look up the correct version
> string in the version symbol table before constructing the full name, as also
> done above by nm, before comparing.
> 
>>> version information would be present in the string found in the
>>> string table.
>>>
>>> We now look up the correct version string in the version symbol
>>> table before constructing the full name and then comparing.
>>>
>>> This patch adds support for both name@version and name@@version to
>>> match output of the various elf parsers.
>>>
>>> Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
>>
>> [...]
