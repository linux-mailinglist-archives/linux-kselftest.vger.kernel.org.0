Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62325621DC8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 21:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKHUk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 15:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKHUk0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 15:40:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E565856;
        Tue,  8 Nov 2022 12:40:25 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JRGDE019565;
        Tue, 8 Nov 2022 12:38:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=u1iu7koph6UCJ/1wUU9MH0x6mDp3jhQ1hAboQi2QIY0=;
 b=EhT/Ol4J6Tx1qHja3d6z2GKAiChooK6eObVo1HPlk5bW9hMD7AspxLo9ZTPSTRVw5BKG
 UeP8sBYFnSJF4gIL2xKHYygFJWJfB1ClyoYlrGbskZxwrR/F2w87j7o49t5YVv1rYs2y
 gfNUn9nBiy0NaHvJgV0Wh/6rYLhALNUZUZI0ld+pKre3Omk+D7UAP+MZlNfycuulStpn
 M3wj1mgMi87qTn7EW6RcyDjG852uvi81Z8o6H/qAn+EgoycqP946g+wWpiGmFmuobIlh
 LfsmmUHb5WyPHCCpHBRH7gKDYCshg5CIpsek4h7DBZult7PHKMk/TQTTDbb0+daI0dP/ BA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqd0efxp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:38:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0TpEq1AFjHnfk+Wb3GDPraSGnBVeBjYqJ5tbpyBvNdjKayjhWsAjVEyvFWyfIXa/dNzvjcCMAt91dqOoTgNssxwwjcEXnJxhyEB7Lt2xr6i0ab/NvE/3NmdTEHVTBhPqIjLtQ6gfuLBtvMXovxAbFCC230gfKndByg68eRVEkkPhH1I0FFi9C60rwftg8ktjTVkd6YlqXKzGrchp0kypuMbsgatPplE8Ag1lKO7IlAUw2eHngooNAH4ce4omt+B4jPip1h4ysYs7nQLDR+gcy6XH9h2ero07bDwknTp4sP67B5q0nhaU5x9BijR1u2IL/dgKtcyIRitjMvlEHd9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1iu7koph6UCJ/1wUU9MH0x6mDp3jhQ1hAboQi2QIY0=;
 b=gKmJ/sq2XJZTyhc7ixdtQdI/rSztkvRnjgS+wOESQLMVp6DDfncwdX5GQaUD8cKLFkRK2CrQyGrBM+bdIa4mgjcNaDdEr6thWh4KAbyUiujBjCYh3cqg+fAmScIrBPpZa3S9eIG7vVyvTr5aPLGVdqOmYmPDr1Lh2DxRKqfsKfE0bJkGWMY8/CXd25foqU6kr5iU7hlMcWUtyD72jhzn29IIDgsT8xeB71fpjWNViIcJwxgSnCx7HUuCmpDdyLydglbAyOl9hYWFJ/4PHjY0uFJe5Ft8I8G0aQf+Eu7CxSJCjg6+HsSECLbF9Jn65ugthAh7Kg7pi45+peuiAkH59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5178.namprd15.prod.outlook.com (2603:10b6:a03:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 20:38:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 20:38:57 +0000
Message-ID: <ab5a36cd-e9cc-074a-2fb6-858f5cc897e4@meta.com>
Date:   Tue, 8 Nov 2022 12:38:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v1 1/2] maccess: fix writing offset in case of fault
 in strncpy_from_kernel_nofault()
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
To:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221108195211.214025-1-flaniel@linux.microsoft.com>
 <20221108195211.214025-2-flaniel@linux.microsoft.com>
 <a725e235-f4e9-84a3-a88b-dce274423a75@meta.com>
In-Reply-To: <a725e235-f4e9-84a3-a88b-dce274423a75@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:40::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1295a15b-1aca-4555-001a-08dac1c9420d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbrQ4wqvpF7/H5+66jdva4dR6iAgPQscN+Io4CZjLrBQ4oZCcVBYGRHbC12YTHguPpnvIjmpctRv0FpRmMdwRClhWBvXhdMJIcQBGTE7/DRjlEBpYEyQ4mjboPo7P2lps3+nqdMAPicKLGiDo4KWrbww/hPAjaTZFYoGJJXd3DNwFInN4X0gJNoQhhVeAHFjI1TTcvVX9ZDMZip6kdaWCf1lkU1qfPzV/E1DbOQVZ6EQnivp8iFH4k73pADS0+3RrMBVC5TS28kbalFLhF2nqAqs9rScD119gfb0ToKRMeVWTIMgQjZpOP2KnOsQveh53qVDcyaKJqqABtkKHjft6Wb2TyysS9YIHn+CD1r0rzInmy4WzpbXgWdXjRWBC3qv67kc2WVD+hhi4+PCEk089LMInYucy+8TCLFHSN/lipa9pQA+9ZIDAaEwYP8cOfAYai4N4719jZukA4wzHYbYBgWSuUj/ewPc6TAjIxi2//kqJBbuNZYpzMJzgVxaPJ82iLy3aW5uQsoocb/aJYPMHWt2p8fNmfndFt6/kgQxf3TY5DhqQ0DcmcHcjL4NASuHUAPCSjDQmv5Jz/KTlb2D1yeHin2fp70K/Cj8AyWeiMP+J29JD59GhqDmtb8ZzSc/JSFQtlLQWnOLls3E2Bu/s3Tmi3cM59kNahlEJ9rokUFBBmz5PGmDthVQlWoJ36pmgAHCYFhYx5gT28krHqbx5LUy4bwbRZdABk8MWteqD29PEYn3DF9qNp53/0zffG5PX5N8+rX9U8uV+VjpnjFL0P51l9HkbWO1jCTFVwOSjXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(66556008)(66476007)(45080400002)(66946007)(8676002)(83380400001)(36756003)(4326008)(6506007)(53546011)(54906003)(38100700002)(316002)(6666004)(31696002)(86362001)(6512007)(31686004)(8936002)(41300700001)(478600001)(2906002)(7416002)(6486002)(186003)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpBbFhTbHFSY0FUSHEzdGM0MXYxVFRsVzNYM2NWa2d3OFA4d1orbnVwYVQ3?=
 =?utf-8?B?YUxiOG5QOENZbHVFb1hTYjZyUWdiYTRCV2QzSUY3T3YwdzlnR1piWHZOSVQ4?=
 =?utf-8?B?T0lXeGZ2S0pWRUp3TVFQRllNSjZ0Z3JuRnpTT0tHK0dxS05wYnlDNUx6WXZ6?=
 =?utf-8?B?VWErTDVCNDdhN0tSWVVHUTNTc0o5TDEwOUt5bFNLZUZsL2RoMUhFY3Z3T0pQ?=
 =?utf-8?B?UWRiWTdHUHFHZFYzdVRLck03SWtZT1VsWGRhY1doQS9hVFRlNk94Vm96cWp2?=
 =?utf-8?B?dnJaR3BwcDhYQTQ0bVFad2Nybm5WcWU1dEtEbUwwdHk3aEhCeksvOGFXV3Q1?=
 =?utf-8?B?SGtldVNHaW01OXBYSm9RWUxxNW9VaGtJM09ta25HcC9HV1FHdzU2c3JkQ0Jx?=
 =?utf-8?B?SHRjUFdzSDJ3RkF3OFlTMWNJSzRsWlBocnVJcFhQU1MxbjlKNVl2R0hCNHBu?=
 =?utf-8?B?b1BFVlBMWTNQekNxUFF0ZG1mRVRjcGhOL2VvRDVBMUNFUFlCc0haZ2Z0OEVt?=
 =?utf-8?B?VWNWZTljTlpCeVRQZnlNdHhVSEZTQjVqRHFvK0p3cDFYWGNkOUwrblBpRXFm?=
 =?utf-8?B?bWkzWEdWbkh5K25sa0FLNFAvQk1INnphcStucGlDMWJPMzI0SjR6RExPUHlE?=
 =?utf-8?B?WnN2OUYrMWxZZFQzUHNieUc5bEsrcE5HV3dNcTUwa1B4ejZ0UDREWUpCVGw3?=
 =?utf-8?B?dmRQNVFaZjJxOEhYaEVZUitWWmN3YTAvL2dZWnBSdkxtZDNsdklzdUxUUDVv?=
 =?utf-8?B?NkdkU25NRzBzNUk4TVhMck5tTTY4UXB6SmJaYlo2RVVvdDhBbmwxaFBKam1M?=
 =?utf-8?B?T01vRzF4cm9tcjZ2QXhYSTB2SndZeGprV0pUVmhkMDBtc0tFWURwT3hldWxy?=
 =?utf-8?B?NXZJQU9pQjdieVVWeFRTZ0ErNEJ4Z1FoRkZlbTJFZVFHQVl1bWJkNGtEalpZ?=
 =?utf-8?B?K1dzcHp5YWltOGtwclJOdk1tNG5EendTcmlVUUxvdzNTMHVxM3llYmtKZlQr?=
 =?utf-8?B?eFZENjZPcjVaM2pSTytVa1dCN3VjVEUrczU5YjI0L0UxREhTaWZsQkEyYmJ3?=
 =?utf-8?B?Q3F6cmxDcFFnN3pzcWc0NzJIbi93OFlPa2FybWJNMHl0UzVWaTBxWkdWNjUr?=
 =?utf-8?B?TlZXMXVNSjZuN2lKMGdUQmRxRXR6cXlVTlNVQklJcldGMk9WY1k1ekIxSlZP?=
 =?utf-8?B?Z0l6cFA4WXZCbEIzZHRCOS9yYkF3Z2N1Qyt4VFp2OGJBMnFTWGQ0RzNNN3Fv?=
 =?utf-8?B?RjNtU0RsdEs1TzNiYlpZNTc0cUpFbFFIaUJQckVlMFVFSzhsZ25YNS80R0ww?=
 =?utf-8?B?TllWblQ1bG9wcGZhZ0FKcStPYW1sTHpQbWszWjhIdG9DWXZHZkhPeGVSSGQx?=
 =?utf-8?B?blE5TUZORDlLSG9Md2JZVnRWbWtBcUp3WDBlcTNERzhyVXE3VlZ0NUNjNmU3?=
 =?utf-8?B?R3kvUy9XeUhKZk9RdkpuOXd6cnA4dnJVdzhsaEx6UTR1OXZmcU5rTlZRZUVk?=
 =?utf-8?B?SVlIZkIwQUEycmFyVXcrRDBOcjJGTGZXRWhSak5wSTBLRVBLa0NWTE9YWTMx?=
 =?utf-8?B?b1ZiT0pSNDNEaGh3WkkyKzBNZFZzRjI1VDNCdURoWlRlbkh4T1RPZWJCTFM4?=
 =?utf-8?B?T2hzcy93eExHQ0VoSHRDZUdVeFdoVG5ocndOZ2VBbUx3ZWhhQ3RWOHNaWTVh?=
 =?utf-8?B?TUs1cUlPQTFXekxQWTRuNSttK1Jpc0gvb3cwa1VkeHE0b2NGODh1Z1Z6alQ0?=
 =?utf-8?B?akwySWZEUTVKVXVNdyt3Zm01MjdlUUQ2R1kvS3NMU3lxWFdxcEl0WDJhRW9i?=
 =?utf-8?B?Rlpsb09iKyswc1RaWWttNnJiaUNEcUZLVStQZTE5N2piKzVjYUh4eFVCaUR5?=
 =?utf-8?B?OHpodkFtUjBXYmJhdHhNQ3VYQlhtcW0xdGxCM3VXTzRqUkRTYlMxak54UC9n?=
 =?utf-8?B?Nml0aVhSNit3Q21pemhuY1FYN2lld0M2c1VQVzdObEtHUU9pRmxtZHhWY2dn?=
 =?utf-8?B?OTc2ZHlld0pqNUxXQjlLMEJJdXQvRnFUaE5vQk9PeXdkOHFaUnAvZnhhdTd5?=
 =?utf-8?B?Y0hZM3h5SHQvV3N1UGFTVi9YeTZPb09rS1ZQQXhNMjh2Q3U2azJESHRVekVI?=
 =?utf-8?B?d2VFREdmSEErWENHaDVqWWpxR1V4MjZsRFk5UnRDa29IQURHTWlwR3JIU0Zk?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1295a15b-1aca-4555-001a-08dac1c9420d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 20:38:56.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZVXsUS1Ug/qd8rdfgEssd0wRuV52xswneOJfjXysxikgwG5GKkQhA3d3Zips4+k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5178
X-Proofpoint-ORIG-GUID: dDxcw9OIMsSBCKx_Qh8XX8ChsLAs9QYI
X-Proofpoint-GUID: dDxcw9OIMsSBCKx_Qh8XX8ChsLAs9QYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/8/22 12:35 PM, Yonghong Song wrote:
> 
> 
> On 11/8/22 11:52 AM, Francis Laniel wrote:
>> From: Alban Crequy <albancrequy@microsoft.com>
>>
>> If a page fault occurs while copying the first byte, this function 
>> resets one
>> byte before dst.
>> As a consequence, an address could be modified and leaded to kernel 
>> crashes if
>> case the modified address was accessed later.
>>
>> Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
>> Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
>> ---
>>   mm/maccess.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/maccess.c b/mm/maccess.c
>> index 5f4d240f67ec..074f6b086671 100644
>> --- a/mm/maccess.c
>> +++ b/mm/maccess.c
>> @@ -97,7 +97,7 @@ long strncpy_from_kernel_nofault(char *dst, const 
>> void *unsafe_addr, long count)
>>       return src - unsafe_addr;
>>   Efault:
>>       pagefault_enable();
>> -    dst[-1] = '\0';
>> +    dst[0] = '\0';
> 
> What if the fault is due to dst, so the above won't work, right?
> 
> The original code should work fine if the first byte copy is successful.
> For the first byte copy fault, maybe just to leave it as is?

Okay, the dst is always safe (from func signature), so change looks okay
to me. Probably mm people can double check.

> 
>>       return -EFAULT;
>>   }
>>
>> -- 
>> 2.25.1
>>
