Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561CB728E9B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 05:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjFIDeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 23:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFIDeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 23:34:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245230F0;
        Thu,  8 Jun 2023 20:34:21 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3591WENn023449;
        Thu, 8 Jun 2023 20:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6WSk4IqRsEke7poHBd3pWAOel+mOSK4EQm9knUDIsI0=;
 b=OabZoJsqpLTMRJ3RN3soUxe98EeQrPI6ypmxTD5HPXRE4pJ81Bg4DUKWGiA5vy/gLGSf
 5LEANb1LzwI/7bl1WBYjLrwnychnbVGwwrSk0yGVRGSPJAxMk6Ued1xtgA1+30y6WrLk
 FyBcNuiNYuRlaiYee2ARRCMqcZ4lD1pgjrop1biy9Cmu/5S3gci6nuBxMgbgUTpkPzad
 sv78IoXNpVsExpgslQRPPi9x0ctLCe2si0Y9Ayn5zS2kDQjaqOk6fghebLFt3nN2XoHY
 7SETE9l6ht5kZLtLuGWeeI/3Rw6/lZTDSf3+Q4FBKMqluogGJwxW8NJMtNm6I/10+2rc uw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r3fd6nn7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 20:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPn+roYDwA0/tBlQL5ielWdPq0uDnvOkNZu7JDy1/KFgiNNV+JHJFMpv3nDpQXYCDdDsNfvxqOUPpzKdD0UbxSOFQB3ayjvsDTRhXpP7gB5AhWynOzypPBD+Gp76mQZFKMbeMN6UcK3vvGqLRv1dAHSd+Mz7XttczOw+SiDC2uGLs2VNSCZZdS9gzKAK4vAeGbTX0tqjzCdZs/Anr4ruSFhKCqBHOBvRwmJY0PtIRsa2veh+JJInqhZ71TlAFuPiQm4yq0AiYg1kDxJ2KJHjg/C3EHewREAzTfuHptPJrTQnOSwjS1nAd447rWNGXCEug/UiZZJVqziqM3HOp7zprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WSk4IqRsEke7poHBd3pWAOel+mOSK4EQm9knUDIsI0=;
 b=MyU6uwIfJ670ZUawdBPKLu6V/wFWD36RmaL5UEhta66yy8BWpOLrFghF2r/KGS6VuO7EdtI/imAHN9wbLYeQ8ePwgCyeEoWZcpXYteqllOtVTUVa+sOnHsbC0GKf18KSs9YH5PDPhrsCQgaSxPdnR18tuhGheQTbkKz0kdeMCYhPsFM9BUioXNWHImW9GK/mymM+GdMv6J19TLabowOGJF3QErKFa1mVRdjTNt9QzQRimChQlaghwDYY2AtAUl5ReyjmqvbWht/DjrgMrWjDuFnz6JlD0pkFw0qCbJU6t3UDIDU+/AK8AJgGkMQW2KAIgH7Fj5Sax1WglJK19yKbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL1PR15MB5339.namprd15.prod.outlook.com (2603:10b6:208:386::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:33:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:33:59 +0000
Message-ID: <b877e130-2a81-7233-3162-4f414b58549e@meta.com>
Date:   Thu, 8 Jun 2023 20:33:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH bpf v3 1/2] bpf: ensure main program has an extable
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1686268304.git.kjlx@templeofstupid.com>
 <d0c703a2d47d3368032c65fa70297cdcb5a16da7.1686268304.git.kjlx@templeofstupid.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d0c703a2d47d3368032c65fa70297cdcb5a16da7.1686268304.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BL1PR15MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 6736274e-d23d-4b87-34c6-08db689a5c67
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYy45wVQr5k/XcAKVrIZhIgtZJeUCyzP6tmWQ5zdK8pQ7Lgx+YtjdeA/i2JJcRIXuWljbmFvBhUYk/IVvXPvptXylj4wellJYRnQpFV+LKjjCeiH4vgHM3Qj//iKTLonCn5RpQT0URKCOcRY3aDTU4hQSlRRtW2yA+SSiW2JjWEzaRagbUCJ31wYpvQ1PWFqt+DJw0JR3dIydsQeheP1y9OyTo3P5WMveFi1Q2BgejFUbjEUYwpql3HciTd4qh7W2w882ecyfo2qUVA1gUxLGfWPOKJC1oixTZfQJYVbI6aMgDb50iGJFJmPFhc1tPt3lIcc0U+ETbs0U5cj/9dbo/vko+pwqOjmwyq96eUgbq2QQx3JKBKxXl0rSVefHHZKHvKcMgJoaq7zGTPf0FVHVqhtEQHT6lpMkvptjUF8NgVPqrNSv4BWOcvJQ9jKJg/NJ1eLvmfMU6GBux/XHGoKVQT2zFax5FdQEoGCII4eFb5ctIKbHnBTE6qG2L17SoNVRUkrulrAVykofQUOqQVJE4Krb9uh0WBS/a4ns+klbkwTkLSTABm0o0FdWnZfB6WidY9aWfKDS+u4bGiWWM/u5Lg5f+v8dB9F6TdHVEwRaRI3ZQe1tOYKiIdS1FXtArhgAQESB3eni02QdgkfgBREcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(31696002)(54906003)(4326008)(38100700002)(66476007)(478600001)(66946007)(6486002)(66556008)(6666004)(5660300002)(186003)(2906002)(36756003)(2616005)(41300700001)(8676002)(316002)(8936002)(86362001)(7416002)(31686004)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk1RVDV0ekttZ2hUTzFKOWZPLzRJcTkrWDlQdWZYL0NvUm14NXYwN1Z1QjJ2?=
 =?utf-8?B?SVViQy92UU8rbUh1S1Z5bTZGT0FsS2NvTWdoN0Y1a055TENBKzMwVm4yUFp0?=
 =?utf-8?B?V3l5ZTdOY0lBUGFRdmoxVkJzVEU4RWUzT1VZdE5TTEFLaVdURlpPS0JHYUgz?=
 =?utf-8?B?NDIxaVhuNHhwL1N4YXJQb2NIKzdVRWxrRm1NM09QZWRxbEhULzhUMDN1R3Y4?=
 =?utf-8?B?dFkzcm16TUpnMURyeEFtN3Jhd2JKeUJROWg5UmdvSFZFM3kvcW9NQlYwdHY3?=
 =?utf-8?B?dlJ5ZWVmWXRhdkRDWnhHUzczUk1IR1F4WUk1QjcxWk1wSnVsQ2lWSzgxOHRW?=
 =?utf-8?B?cWhHUmR6T2NyeGk1SG14ZmJMd0J5Z3BTazZzeUkxRkwwTVl0NENhbDBEUTJw?=
 =?utf-8?B?N3N4UlorMjg1bVAzd0J1ZERHSnEvejlwaXpQQ0E3UGVxWnZHaW02bVkzYTls?=
 =?utf-8?B?cmR6aDM4SVhoQzRJaEpseWFOMzRBbDN6ampQWUpGQlJVY1J5UnBUTS85OXll?=
 =?utf-8?B?bk9wTGxrRThEazh0TmVsWTVMK1lQY2k2RHRRRm5xbHR3RzZGOU83OVdnSEJW?=
 =?utf-8?B?ditTVXorMDY5Z0N4WFNPU2dXNTdUV1lvQ0o5akV0K2FKQ1JSZklHTEpNRFpu?=
 =?utf-8?B?cWJ5VWROTG1MSHJWUC8xTWZteG1KZzZoTENGaVZLdUdVdDByMDRUbnFxY21M?=
 =?utf-8?B?RUlVRWk0SzBZT1pwallRQWtxRjlibzZmWkhORWVYNDFrcDBXaExFQm1ueXg1?=
 =?utf-8?B?NysvR2RQOVhuWUZNV0twYnR3dkFndjBvSnZqc3RZRUtLYm9qeksxMFpoZU5U?=
 =?utf-8?B?OC9kOGRERjBoTlp2VXQzQVdkN0wxYUtRQnNTTUVpUksvdVV2S2g3VHRvblJN?=
 =?utf-8?B?em5wZ2RKOW5rRDJ4cVA4RVdCcmZTdElRd3p6RHlpMWJCcjc5MGxITnltdURz?=
 =?utf-8?B?dHZRRm8yQXZvOEh0MzRxa1NSWjlBeWVaRFhYQlJJRFJsd2sray81TFFwZDRx?=
 =?utf-8?B?bzErMW5CM09aRFVIaEhxRS96MGtONksxcGpQdEZOTXBjTE05UEM3TVdoMGhl?=
 =?utf-8?B?cEprNmZwTW5PcDFHaWhCSk5OcW8vV0Zmc2p3dXRXaW5ERjNNQzZmRkh0dUE4?=
 =?utf-8?B?am82UDFlejd4SGlEVDk2RzdoMDB2UkoxWXFKTTdEWU5ieldvSEVJb3gzYmts?=
 =?utf-8?B?SDd4QVIwd3BiYko3Skd6OFkrUFpFME9aTGlITTBnM3BXWVpDNnpFN1VtQmNE?=
 =?utf-8?B?KzB6N2tKRE5IeGwvVTJhL3liOG1LUFAzUU15NUNpbm5UeEl5dDI1QkFUQ3Vt?=
 =?utf-8?B?VnNhZys0L3dEWDNNd09oOW9mcW4yR2ZncXpuVDhEWENYN3RGcEhPUHlEVEVV?=
 =?utf-8?B?NjhHZWlIYWhMMWNaVHJyN2FjQUJVNjhCYUY3M0FaRVhOLzEzR0lMd2hGcy9j?=
 =?utf-8?B?ZXdySHdnMEdFV0RRbWR6cWYvT2MxbjNwc3lrRGJRZVArYno1TWFkSXlDbEw3?=
 =?utf-8?B?eXh6Y0k2cmxYanhlM2JKYzcyK0JHM2hxN1dKNEJFS3piZWk3Y2xaOXM1M3Rq?=
 =?utf-8?B?NTZHKzByU2FNMmdCNmVHK1Aydm1NYmhFUGhOTHdVZ3NUQWZ6MUljNFNWbTVQ?=
 =?utf-8?B?clNOSUtXYXJ6SEExNDZRT0JhUU1Yb1JRcGk5aFM0a3V5ZTBWSUZqQ3FQcmxp?=
 =?utf-8?B?dzhyOCtqbzRLTVJ0eHlwYUN3aTErWSt3M20yN3BGeWVCN0RmSys2bjMvUW9Q?=
 =?utf-8?B?N2NBNmNkZ3BNTzcxeTRFckIxRmNMdVFRbzk0andTMTB1cXZOWk4xY0I5Tmk1?=
 =?utf-8?B?ckMraE1MUkQ1aEVMRldjOFVzTm9MK2VLRjZEaHhXU0kwY0liVkZmcGcyWXpN?=
 =?utf-8?B?enVUdzRsemxJMVRIWnZpcTJUdDRjbUZ1YXBkK3I1eE1iUWI2ZzRKNG5PS1BN?=
 =?utf-8?B?Tk8rZEhSYm9WNHYrOFl0YzhaQXZXNUM4dmRCbTNWSFVROFhTdjdEbkEwOVF6?=
 =?utf-8?B?MTZEMjdlODVBZkNJYmJUYWF5UHJLd1NHcE9ZM2xOWkEwTG5scjN3S3lSc294?=
 =?utf-8?B?UytMcGgwM2ZMMG50TU5NY2hqOXNSOXpCZWZnMVRzaDVOOXZaOXkrbnRRbXUz?=
 =?utf-8?B?cDFadGIvRFdjemZpbmhnMnNCQVFaUlM2V2d5Mk9wdjRhRVlHQm1mSkNGVXRF?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6736274e-d23d-4b87-34c6-08db689a5c67
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 03:33:58.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8JuHWrsjX8AY5VbuogrP0JKrZQHHAr4VMSsp9esdBRx7Kex/up2g6V3ixG1zZM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5339
X-Proofpoint-GUID: 10ldEj-AH0pgZ7XdSn9mmXbaTPynS1kr
X-Proofpoint-ORIG-GUID: 10ldEj-AH0pgZ7XdSn9mmXbaTPynS1kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_01,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/8/23 5:10 PM, Krister Johansen wrote:
> When subprograms are in use, the main program is not jit'd after the
> subprograms because jit_subprogs sets a value for prog->bpf_func upon
> success.  Subsequent calls to the JIT are bypassed when this value is
> non-NULL.  This leads to a situation where the main program and its
> func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
> has an extable.  Extables are only created during JIT.  Now there are
> two nearly identical program ksym entries in the tree, but only one has
> an extable.  Depending upon how the entries are placed, there's a chance
> that a fault will call search_extable on the aux with the NULL entry.
> 
> Since jit_subprogs already copies state from func[0] to the main
> program, include the extable pointer in this state duplication.
> Additionally, ensure that the copy of the main program in func[0] is not
> added to the bpf_prog_kallsyms table. Instead, let the main program get
> added later in bpf_prog_load().  This ensures there is only a single
> copy of the main program in the kallsyms table, and that its tag matches
> the tag observed by tooling like bpftool.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>

Acked-by: Yonghong Song <yhs@fb.com>
