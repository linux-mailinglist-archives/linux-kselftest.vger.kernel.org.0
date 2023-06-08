Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBB728677
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFHRkq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFHRkp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 13:40:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E21A2115;
        Thu,  8 Jun 2023 10:40:41 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358GmRq5005444;
        Thu, 8 Jun 2023 10:40:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=GndH3H0MyeAxJHn/6S/UDKMcS3nOXgDvInsIBE1HdbI=;
 b=lf/kMdr1S1wNa2/tNTBw5mariIy02tMVAP4N2e/T2mdDH9k9qpBna1IQ3cf9gDyEcsi8
 Db7y7rcAVNRZxPmH9qShRvtxYREtzpFhpIJbxoW+Kfs9CIzkJlFlm/QX/3lNu9DYMvoQ
 bfnHTJD82Gobh+KWa4Vr3ig+p9YkNQ42+J3ZoQu4bEEGvs8xPQ9pAD2gxjxjbT7UTv5u
 /YgbLKISO9ZgLf9eG3jINFlE4exxXx1tcGOGd6Y1aSWdgrGHNLOe9ZasBOArDXxEfvkQ
 OiFdwkLfKua2GPGoI7jqcCDeZ5BFLjAIEGXpVm4pg2O+J7XkFuAqSl4guWeJhRoUx1J4 UA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r36g5w9ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd855NskVxxX+xAJ4Cb7aNPrfZi+zDxa5jZLtth8p1WPiJPM4pzHqMs3qS4DEgdSIDd/uKs5cShizmhEGsldi3jjezAu93wc0XVP0WtHUuj54HPjrco6917ZM3tx2Px6SY8Akx+M/yRbLiwu0/jGoec0y24ly5t4ACrCdMMai0jl5DRQiFJAZwSLxzu2CYDNo8S+eHi8CGwxklDmZB2dI1CBdxaJiPBvglq9euWSAWjK8Kpty3VuFEpSiZnFUsbWfgZMpmRCOIy/HO1l877hi3Z9AjdKp3ZI5hxkbN4tzNQ9p1GygOmKzf7880FfPzG1fL6AHp6iLohMOU2P42tNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GndH3H0MyeAxJHn/6S/UDKMcS3nOXgDvInsIBE1HdbI=;
 b=GGwGVLzQDGS0CpDgsrx3y4TorwPCYbzM0LzAAwhpSc6fInJVNM2WMYt1EmHSnSp/BF+RxjPBcHa2Ko3VhEGG7iLIHBIWqxR1J+pnHJP6ORx//HlkgLRxi7t0UkSbcUg/xP0Knhehz0GQZhEXBUPHQRKGrHQ1WhfpG9Qo0RE/erNLq7VB9m6iKb3u7cuNdp5m0cqdrouoozCrTlS86v4XLjxdGEaIksU0DDG4+TWXeLCZSag8EQtR/VWv/IphRKlHO4mK9NkuLw0qdIfZGscXbStyAixadvEbYDRwMuYbQvqY/3HsLvZOAm7oYEKH6Os/w0okV20N8gAnjrrtuJ1YpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL1PR15MB5340.namprd15.prod.outlook.com (2603:10b6:208:387::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 17:40:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 17:40:18 +0000
Message-ID: <04c149d2-4b7d-f1ee-28b7-3a7ff0c7aa51@meta.com>
Date:   Thu, 8 Jun 2023 10:40:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH bpf v2 1/2] selftests/bpf: add a test for subprogram
 extables
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
References: <cover.1686166633.git.kjlx@templeofstupid.com>
 <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BL1PR15MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 39031086-b2b1-457f-4841-08db68476ccd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQcIdsPxovWa5xtAW2O18FjW3BcytRfFGBP0suolqLH4o74tmlEClStj5vPnFZAh2c41BtaW7f/1a10m5w9p9icPUpAqHvmg7UIyjag4yx21rz9UFDWBRNVt7OIxnwezCtjdDef+zcJqdk6ZqjM4mIFx/++VuIeQaZ5mLwox+LG/kmbWBE832UzjAvZwKFgQUesV46OG3/3YRnM2ahR3dTrC2pcjhlWOKVrbeupKLO013HhlmfQQwayrRPDW92kJij1WqPl3khNd8RSb/FwjyPQC8lX5Ki62aB77seOBDIA3QcqTHiw+DsqWd4+04eTnU3BQTA0RskaC7UlWqDBf2zGAsDpOBRFWRib+Y+sPDozl8t5h2By5yIxr8cuwSm3beB2Rx7FuX5xcKVZaM7PZoV+4uPIoPB3+1Y1JuxecnlRuxlurRa+BUnlEgjX0bMrPpOp4TGpTFyYlPwQq9Z9zG+pTOv1KMwJOFB1iTMjboqwPdgDPlhV1gH+9NiOSDCUVkGXaGyS+EKiWerUf1gjs/7Wx0tiwHxt29IhrwGJtjtx34Aph73emOaNIJ3cgI22s3wEufnA8chnjCHVHWPymyIBf9zn6P6renV6Sy6OUDV7QL7lTwAVbzHI1jqq3/66PEi0TQ/pLo8iN6z6FECZYqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(4744005)(6666004)(66946007)(2906002)(66556008)(6486002)(66476007)(54906003)(8676002)(86362001)(5660300002)(36756003)(7416002)(38100700002)(8936002)(31696002)(316002)(4326008)(478600001)(41300700001)(2616005)(6506007)(6512007)(53546011)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RPcm1OMHVmd29aZHA4SUIyMWRuRjk4aUptRDA0Syt3Z1A1OTdUK2x3OGUr?=
 =?utf-8?B?VDdEVkNDRWhzVll0aW93dFg4ejVBT2tGREpCcC93TGk0dTM3SHB5TnBLN2JC?=
 =?utf-8?B?djlZS0hFOXZHSEh0NkhybnFjWHBibXNybjUzSjQrQm43OE1ZLy9IOGV0M3F1?=
 =?utf-8?B?Qk1rV2hIaDRzYUttU2FFSTc3Tit2bFBPa3g5dkdMRDRzMmZPdUdLZlFVZ25u?=
 =?utf-8?B?K2wrSEJNcDBlanVsZE56Y0pvK1RvbGFQVlM2MEZ0dnJBRmhDVktQbytPOGVT?=
 =?utf-8?B?TkdzWWVjNGFtdDNtS2ZTNnFhQmlJOFpyYS9QMCtsRWQwQXVEdEZoTVFreUM0?=
 =?utf-8?B?T1o5Q0J2N3R5aVhCK2xoVTMrSkpURDhpazloSWlwRkRDejVwVEdTT3VGeVlu?=
 =?utf-8?B?cE5RSkZaMEMwdkJCUXp5SnowS2NXcVQvcnRrWHp5Si9GRDdCbVVPeTNlNGVq?=
 =?utf-8?B?WlozMys1dUJPSDcwVmhyd3dTcHdiWXVFelFHZklWZTkrd1R0WE1zUkJwWEhs?=
 =?utf-8?B?VkhjYlRZd0JXVXhITWZOMVF4cU1JMy9tNFVnVnRqUk9oU0pTaXJKeDhDYmlQ?=
 =?utf-8?B?Q1JnU0ZuN2xRdHlHdERZTnVCTmlmakg0V01LV3NVeDVyNEFvT2xRMFRqTXBG?=
 =?utf-8?B?dkdpcXdzbFVaVFZHdHorU2ZoTXUxNXVSSXhNNHJtaXFEWDNNeURlRlpyYzUx?=
 =?utf-8?B?WFdTc3pzZG5BL204UkFoWXRaQXZ6bHdYSmdmcXU4TnlZTXhOdWxnaDR2YXF6?=
 =?utf-8?B?UHJuVURUazZLN0VRQndoYzlURXBEekl0MGNKZnV6cU5TNHJONktpSTZMTzNu?=
 =?utf-8?B?L1hNK0xwSlNneS9Pa2lHOXArekE1eTdlemlOcmd2VW1wek9ZWDVsVDIzOUNl?=
 =?utf-8?B?by9rWnZOOG9WeWRHRDlJOXFkU1MvTzZkbzhEd2tublFIdC8vNmQ4S0pZOXgw?=
 =?utf-8?B?MzM5WC91WHZ6UnZVbGZ6Z2oxTGxoWitYS0R1NHZLYW9VdDVPQi9WTjR4TTRk?=
 =?utf-8?B?dEovK2s0VTFNKzQ5Lzk4c0RtMEpSQi9adUFrK050MWlyS2NlZkN3REN0NE14?=
 =?utf-8?B?cTVGT0dkYTJYa2Y0V2c0bENrcmEzV0dJbGx6dE1kbGY0c0xlWE5RcVQvMm4v?=
 =?utf-8?B?YlR3dStVWlNYSnlkaUw3MjB2bUg2dXh5djByK25Lb2gzOTB5RzhOWkNBYmx0?=
 =?utf-8?B?Uk1kY2lYTlMzSXN0Wk9ncHZPdlRNWmxPbTdVMzRDbmx3N05YNytrSXdnbllq?=
 =?utf-8?B?ayt3WmtYM3hkaWswRjNuMjJkTFpRYlN5dUk3bzhtRm40WUdnQWxVcXVFUFVW?=
 =?utf-8?B?ZFVyWTRIUkpOMDAvL2pZeGJFOVE4bmw5cndleWRjLzNyYmZQQmZuZEVPYmpG?=
 =?utf-8?B?RmVjYzdDNzhoL0dCdXVFUXpkT3NCdGwwSUl4bXVYYVl1VUs1NGNWQi9nejJw?=
 =?utf-8?B?dUpKVUNxREhOY2MzUnNJQU5yZDFPeWRsZmY4dFVqU2tGQmpEaHVMWlNwenBa?=
 =?utf-8?B?WHRFTHJaT2h4SUFYMURpWWYyYWplMHQ3VDBhVE10UFZRZGlIMldRZGxVTllm?=
 =?utf-8?B?VlRoL0NRWXdqbEY0QmFaNlV2WUdHUllvNk02YXhMejZLUDRWUS9XK3JWYm5B?=
 =?utf-8?B?Wi84QkRJZG9iS1lTalRRb3ViVHFuRm42aGpORjdTa1BsdFBkSHBXUmdVWVcv?=
 =?utf-8?B?ZDhJTldFWlpTcGdySVlVT3duY0NzR203R0RnRjUxRHVCdGplY1lFeTBsUjhy?=
 =?utf-8?B?UlNyYTZORTUxUWdZRXV0VSsxUFVuRVc2Wk9HaGFIV3R0L3F5b0J0US81cE5M?=
 =?utf-8?B?NXdXSnNJKzVtMkl2NVJObTFLaGVJTHJoVnFTTWl3a0hmY3JoZUsyaVNVWFdW?=
 =?utf-8?B?T3lTY3JyWno5TjR4RUxTYVdKbGVGMzQvU21pUWlGcGFhM0p0dTRSZkpVM2ps?=
 =?utf-8?B?WUxTM1ZXZ3d2a0gzYUdaM1BRaUhsb3lGZDNvNUtFbzBRTi9BVjN1SFBlZ29H?=
 =?utf-8?B?UjVaSEZmM1dmZEgrcUJIVm9xN3V1UGpZRFV2cmFFTkh3dnl3VWo2bVo5WnU1?=
 =?utf-8?B?blBiUEM2eE9qcHkxV3JNZ2VSbWVGY21wcVhlSkphTGllRktuTHQyYnJoUU1p?=
 =?utf-8?B?NURTYksrczU4Ukh3SE4xR1ZzQTZVb2N2Q1VkcVg3MEFrMEtuRS91c1Y0Sk1J?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39031086-b2b1-457f-4841-08db68476ccd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:40:18.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8B3yQJoXXHW3xYypT0xf5PwPH0hI+ybabn7+6sHNCuoWEhEVQ3cfKK9jeCHEJID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5340
X-Proofpoint-ORIG-GUID: BUpkpNGewzZ3tc3CyeGRzXxzv6StqHUS
X-Proofpoint-GUID: BUpkpNGewzZ3tc3CyeGRzXxzv6StqHUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_13,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/7/23 2:04 PM, Krister Johansen wrote:
> In certain situations a program with subprograms may have a NULL
> extable entry.  This should not happen, and when it does, it turns a
> single trap into multiple.  Add a test case for further debugging and to
> prevent regressions.  N.b: without any other patches this can panic or
> oops a kernel.

Also, it would be great if you can show the kernel oops stack trace.

> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>   .../bpf/prog_tests/subprogs_extable.c         | 35 +++++++++
>   .../bpf/progs/test_subprogs_extable.c         | 71 +++++++++++++++++++
>   2 files changed, 106 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> 
[...]
