Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42953621ED8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 23:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKHWIE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 17:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKHWIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 17:08:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE541E726;
        Tue,  8 Nov 2022 14:07:59 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JRKGO024346;
        Tue, 8 Nov 2022 14:06:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=/aeC5P4a6geIBycwczBlQ0s+Lqao1x8HrCtNp5ECyTQ=;
 b=Wxal9tea1bDoTxFwdr8YE+LhGEr+brXxn3ajrocOpoQd2agjzB6eIdXqprfAW7dgR7de
 v1SxKTNsxJdco8jenU5Z52LshNbZrDHHpT6DUQPA+N/gel/snrEM8erVCbr80RZy8B57
 8iEh+x8pIHGUA1OVn+2cMPKwkJ19qqRojVg+wnHrFikCXDomDnUQYroettk9KVZNjzYS
 9G5wj/7RqMMUR+BcxwHr0S8ZlWLvtJKniHz+kWQ7yahMztyBYlIRBIrS4pN2hgIqWgVJ
 UkurK74n27se5qEz6zCCmXT72KRGi50LV94gVSjHEQdngqZUEQKBMyj6xY4NGtcaAM+r Vg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqh9wf2d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:06:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEVUYpcVgVzrh/w/NP1y5u/2oQhUnyyq6H/hXGvzf0Bl4u7JXksUCqy9+0IsOXObnF+dLmKlOR03co7K4We6DdLpUqqJfeB0DWCwYcY79nFFUnP6irhSO5QDz2NsBH8rsrjV6E1hq8KZ2/UPZSWayLdtMdSv/NROJL0LuvOzKlLzkrKDMqohyNXxZvsN90MQK0Nb7K2tI5ZIWLb48fIDutk3eBFRmBsGElqr67aoh/lmrEfWgCiXnzzKkmWFVkK/jFiRzPnXSrTYyMzTXs6X11A0DP1imuXCZY1y3IZG6Dv3/9HzKnudv8t4fQrsnhLMnPE3IjEOEJI6cHl9XlsHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aeC5P4a6geIBycwczBlQ0s+Lqao1x8HrCtNp5ECyTQ=;
 b=QoKnrqIG2Tc2ZG/ho6dT89NuFbv6JAveP2tvM4EeL54QuqJz8xLQH/C6Bmn+LIdCzgsV2TiVQUghvO+WFmhH9sndvcQ6yRdDkpC4ni3EIRZOo/1V7wP7kpp4tMkIRquM3aYUA4zq3tyun+Qvo+ZKaMfqkZi5AvoY94SsrLYIYLOyonQ/YpTAYwXg+t1UIjnriuSx0BOjcDLlT81v+WzOHcAdxvjCXHxlFz63mwQ10c8kxPRf2hBvHXqwil6vUEiafgdYGh/8WR9slThH74mDmnimex2rb7/MX2mbsHpQaT4m5+HrmUX/bXu19boycJ4m5/Szwv0z8ar14XWI7Qphbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3396.namprd15.prod.outlook.com (2603:10b6:408:a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 22:06:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 22:06:17 +0000
Message-ID: <e38ccca6-52b6-27e0-5d10-3a5b8c80432a@meta.com>
Date:   Tue, 8 Nov 2022 14:06:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v1 2/2] selftests: bpf: add a test when
 bpf_probe_read_kernel_str() returns EFAULT
Content-Language: en-US
To:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20221108195211.214025-1-flaniel@linux.microsoft.com>
 <20221108195211.214025-3-flaniel@linux.microsoft.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108195211.214025-3-flaniel@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB3396:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a55f573-7f81-447b-a00c-08dac1d575c5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5Ez905mlT+39EhayGlUlizYnd8kjgZj07kK3VAtidiaL1TNLuvAEX4me8e76MiUokqAskFuLhfzFrAZeu+nwMgfwurNroPbig4sxwCn1GgLVP4JkiNaOjERoLrkUE+LCWyL54e7/XkPNA9/3jn1t2IjV8zTq1+w/9NWASBz429pgiMGVe+ktI+uu0yMxcLClsoK5z+U3NYMk2sGH/OPd0UEG1iVRgiDsS3UYNPlUxoCh7Wdoi4oheggSuOQLgNIsdVysQsD5jaW39LUocIzZLG9RyInE2dX6iflT5thZpULBTGHINeNBmOFtv1ohm+CxytK2olNMK2N3zO7oK6rFFehJABaQ2IiTOFGV8UrM8AzxbJBVKDsUleJam+i4MKHkI/dzXdi1MHN+mCWAxsGWBuYV3PJsfPwqnpjReHJyTQvRNGIz8+g8n5wiDmSQZZfcbCYxEJjlesyItpGHP+IQEV3qMGJAsO/ZD3+JpY4Ml85U0GOyWRQdtQ1eezDuy2p1E7eJgTrB9BXKd6p1Hb9vy75gnsuRdKpKqqsMEFgZKGxaFU4e52bz/5Wo8mSOwxfiB33BnrJxvBsV+DdbGtvaeQEz3xc1SMGf2ddoeFU5sCZZybKw4ADzp4RiveUp7N1YaPcNNHx58dfL5aWit+Y5Ijn5oyqTrHiLrVXQ3v5M6KHcjmTg+fLIO+bepEmBxK9QWTe86Mqkr9gdMBBPadUHFknbw7HEcgMFWNjnx2wvefy4M88ZYJoDyjPXD02pZ3WyHLWIX4of0XNKGyyCX0mEmHSDN6t+ET5ks8hCOYTclA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(4326008)(66946007)(66476007)(66556008)(2906002)(53546011)(6506007)(6666004)(45080400002)(478600001)(6486002)(86362001)(31696002)(186003)(8676002)(36756003)(2616005)(6512007)(54906003)(316002)(5660300002)(7416002)(31686004)(8936002)(41300700001)(38100700002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHN6SmNKR1dFenROdEh2ZEpnZjlYM2tLN1VuYWZ1bUNuVVk5MkN6Mm5sTVNF?=
 =?utf-8?B?anRPbWNYSUVMelNoT3BCR2U2K0VTZGdsTkhDbFdDM1FRT2tIcjBkZXVZcTl3?=
 =?utf-8?B?RHhYV1JoRlFrUURLMHlleFljRThNaU14SmxVNm5IbHNPaXNaL3JMNnhmbCtw?=
 =?utf-8?B?Mlk1VUdGaFJ6a0psbWhBcGxzSHkzOFY4eDhWcnM1Zkt2OWkyc0RiNGdTZXNh?=
 =?utf-8?B?SzhkYUZDWFFJV3pQNXZSUWdYTFVsS2szZm9uSHovVXhsZGpJb2V2NWlGQlZP?=
 =?utf-8?B?ZW1DeE9WMkFHbk0yN3QzV05OYVRiMjVPT3FzYWlFU1VUNkFlUThYWm5zblVa?=
 =?utf-8?B?aU84YjkxbkpvK1FENHNrVkYydHd1eUJlYnFuMDEvSXJxZnh6cWwxbVhiVUIr?=
 =?utf-8?B?dWFDSERlbTdEM2szR1VlNCtIY1lLWlNnV2pzNDBmQmIrd0xNZ1JpclltYUY2?=
 =?utf-8?B?bFI2Y0U1Z2Z0dTByellIWkMyVGlYZHBUYlRWQU5pVVkveEc5Y3BmdmxjWUVI?=
 =?utf-8?B?WTJMYWpLWWNZRlV5K1dHYmtpTUhrNnd2UjBRSFRYRXdhUHlnNm1hdHpKUTBH?=
 =?utf-8?B?cjd1TGlGSWp4WDc0MU9jL2tEd1BHWEpXNUJSalRlOUV3L1M5YWtkNFRRQ2lj?=
 =?utf-8?B?aTk3LzhnUXFvMDhhYWRyZ0pEVExMWWZzT2MxaE9yWWVwcDRUNkdCSWVCZzRR?=
 =?utf-8?B?SXU4a3djalFjblkwVkFnSVh6WjhxUU5wUmY1eEc2a2ZpUEtPa3RBNFE3VXlZ?=
 =?utf-8?B?Vm9UK0xhellnaWpKeThYU2kvL0pENGYzK25pTlMza0NoM0k4c0ExZlpLenl6?=
 =?utf-8?B?KzdjNnBpcXUyd1RPMUZtL0tTYVdWbWp1U0k3VkJqWVVVNVJ5V2N5UlVzUkVC?=
 =?utf-8?B?VTBnUnN5ODljek9ZUHI5WDNuUDZ5U2VvWmlyUDZ4RHl1QzZIVU84YTdyZjBZ?=
 =?utf-8?B?djdSazA4c1VwOThOU3Q5WVMyYkZJdWd2VE8vRWZhL2liOFdjbmZlRzdjTE1B?=
 =?utf-8?B?SkhwRzZKZWJRSzRwK0tvaGhLU2dzRFVnWmVWSDRIaVZtd05zLzZVS1JLMHBk?=
 =?utf-8?B?S09NWlgydUZ5Ym85WVdrNWdSUE5sYmU1Ry83RFBmRG5QZkwzaXMxN2l4Wjlm?=
 =?utf-8?B?eFg4QUZaUHVka3NZMVpWSldRL0pDMXVMTkFKVUwvWXhBOXdOZzRPdENvdHUw?=
 =?utf-8?B?VmF1VDZNQlBkeWtad01BWkVWR1JsTVRFeTFGU1dubWR3TDJEZUpoS0g4aGg5?=
 =?utf-8?B?NTQyWVFXNENqaXk5cjNIbU0zZnFJb2d0QVZHcG9yWnRDOWhOTXF6YTh0SXFH?=
 =?utf-8?B?eFFvU1dYVzltbzVaMmN5TStweXl3YmZhdGhiNkkxM3RQSXNxeFJRWktEWEE3?=
 =?utf-8?B?NG1ldGpnRkhXK2JaM1J5L0MxWG80ZDVoVzVSVmsrUG5QSjc1YVVlV09lWkMy?=
 =?utf-8?B?dUlFWm1BNkc3WGZhYlNOYVFWdmNIbFdUTlJ2Nk1wd01lR2NVWHlacWZ2UWQ3?=
 =?utf-8?B?emZqMmt5dEluTlRVcW9wakFDeG5JcHFKTlBOdmc5Ry9uWFhxaEJqTm5ZRXhZ?=
 =?utf-8?B?Q0JOTmZzWHRxT2FWVWFReEswbFVIVDdQaEtJLzZvMWxTQnoyemlQc2duQmp2?=
 =?utf-8?B?cUZTUlN4NWhBa2g2bUtDdm1uZGoyZWhZdGpzMnJkTUVPN1dtNWtNYlZ2U0hk?=
 =?utf-8?B?MWZjR3h0TjQzRmtIYVJqZHJtNG9rbDE4MWRZV21LNHNDaFhDMmE4cnRkREI2?=
 =?utf-8?B?NFpHVzBFWFk1Z3BpSVVKM0JTKzIxUXBzRmxHRG5yankrSUVWL2JJci9RdVVO?=
 =?utf-8?B?eS9iNTBGRytTTko2cWQrQTcrZVNyNlhKZ2FCRThpVXp2eVBxSEU5TzF2R0Zm?=
 =?utf-8?B?QzNZMk0yU1VQeEFNc2NNcWF5Z3NHckgxOVpENnZxbmREMWdVOWRUN1YzdjZB?=
 =?utf-8?B?SzBqZzFtd3FwaGUyeTdpVVM0ekNrb0E3WVhGd1p2Z2hsdUp4WG5sbE1FUzlV?=
 =?utf-8?B?RXNubXhvSFBxdStPVE1EVSttTWl6ci9rMXQwVWE1aWNwdTd0VzJ0Rk85WE1Z?=
 =?utf-8?B?OCs1RWcwOEFPSXhBa2dUeE1BRHVsVXZ2c2pDSWo4bnRkNVhMUGxoMXg1OWd5?=
 =?utf-8?B?U1I5SnVSYytYTld1OWFlQ1BBUS84by9VSzdCSGR2bzBmbjUwUHJxcFo0S2Zz?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a55f573-7f81-447b-a00c-08dac1d575c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 22:06:17.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHThuFdnty+ZIaarWlkYg9oGDqA6tz64qS06zVoCjCJJt035YbzigT6S+yFgcKhr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3396
X-Proofpoint-ORIG-GUID: 8MuyCova3LIRHPm0SFoZYNVmQ20OjlLB
X-Proofpoint-GUID: 8MuyCova3LIRHPm0SFoZYNVmQ20OjlLB
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



On 11/8/22 11:52 AM, Francis Laniel wrote:
> From: Alban Crequy <albancrequy@microsoft.com>
> 
> This commit tests previous fix of bpf_probe_read_kernel_str().
> 
> Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>

Acked-by: Yonghong Song <yhs@fb.com>
