Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8D61FBD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiKGRtI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 12:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiKGRtH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 12:49:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A31DA57;
        Mon,  7 Nov 2022 09:49:06 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GlsP7009708;
        Mon, 7 Nov 2022 09:48:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LqWD9uzPsa9qRIUDvSK1v4+tRH4QSn20nADfU501xIE=;
 b=hN9mVvrVbzx+UPV+Jl3qmSCAA31pioTvT5nc86G3aaSzjfflVthtj6kblAjc9dll9gkL
 h5J8cMzvp3D3A+9SApH82vkFHsDOyk3JZ+WXX2iIS1rD8DILrAOcBapRzQUboDBLxvl6
 Ccx31WE8NWi2g2Mx3OdZ6kiaNBzk1999jNiVsvagtC1abadNFrRmzvIqQIQFVo4GdQrY
 sUWnrhgrwRgVoT72XhghIEcOhUUS6ovH21nXX9sX6JxNgx/Pte2iAgCDFxytjqmtEfM5
 j6yI4A6RX3SgIIPr13sOWXvywZ7EMp96ERJvJB+PtNLrf/hw9+RFCYx1EDG77RMckeCs hQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knnhnrrqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 09:48:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVqnfqhEQMmv6tIoNgA0U6jGZ/akQ4sQShK152bIvLPNKl/AkxKTQLwIcq8nm6aQeiWjgAAUBMFXq05tdt2k2ZcEpyEv+nueqjUBCA5An1uUEYSzSjQLaBOYCFYKNzXQrqvqa1uJHSvc1MFC6nxXEDC/rIe9wuG+bU6U+MqlGJp7seAcW/RZfTRzYPLPcz48iN9FPmGoc5jJU/GXxmy5VS0CVj6ODfvSmiIDlfwlcEceILCf0fKTn2SOlMvYmh9vcKtUNyns5Yrze4uA0PfnV9jglRexFORcd0SWuDclbJTK9tc/r70BaDDH2/ny3g1/gSSgF/sEEdOX6jiEjECXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWD9uzPsa9qRIUDvSK1v4+tRH4QSn20nADfU501xIE=;
 b=RHbmc9kQtUoUKOFX1lDM0hiRfXwqpFdkyfMegmIwj0Z95rcPZ96OSHSduC68pgq3+2yATw23040alG3rAyH2gxIohvtbks/NP3CGyi92Ej2sAHe+h5S18E+n3BfWgaIVQc55NNOI+3vTFmTEEv0gPaLoZg8ry+wHthNVSbHho0UIW6H81Vqkyilx3FrioAVfGLPGQraj4Us0AukS3YoD9BkK9L3gpbJIGIpU6L68pqLioAK2sR5jjKhhZz4mUZIhudQHQpcYoWGtv9xoTmEN1Bag6IhOzYqUcA8CLVgaBFWoAhtTLfSF6CST5T2asevv2Up+5ZND5+rafZ3miFQRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3381.namprd15.prod.outlook.com (2603:10b6:a03:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 17:48:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:48:29 +0000
Message-ID: <de78485e-6786-2a52-4364-8055cbc7e0d6@meta.com>
Date:   Mon, 7 Nov 2022 09:48:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [net] seg6: selftests/bpf: fix BPF object file name in
 test_lwt_seg6local.sh
Content-Language: en-US
To:     Andrea Mayer <andrea.mayer@uniroma2.it>,
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
        =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>
References: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2111940d-0c91-49b7-42ba-08dac0e847d7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CHzvq9i8pOw2NJsle43rDeBXYs7z2RPOJPoRmnJ/ICfockLYvLFZvCSNDhe9hwmlHIYfIDkEhrLct61qTQBc8jDvO8FDTeuoTvD8v2eFx/NPdT1XIdV7ss9n0qdW4KS6cBP+f2cDIZeBILpNnCg738dzNbVmmsc8Ht6l6tL0DCEe9fxgH5lBOmDZZq3T1WtwG6jsn0NQIt/Xyif6qZNRSqDCYDye5XIjJiiXK2qNXqyg/te9CYLSVSFS10gc2k7s/ti4vJl3DYY4i1+qvHaL360tLtiorlZ8nyQjnRet3qPUp+xKxzYSDs1DBUn9nt521naWi8rX13Pwrfkj/sj7D64al0ayKkDuU4wvJA2dM1shryLdADF+4xlvz53+i1uY+pzI2j8YPmCloafKr5YdqmvMArKYSCWEXmSLGF5zr9/Y29fovx4AGwGBgxxJ/azBhgO4p1Wut6yYxTLBpSc/FZYuIuNLXLwm7q8cw3jnWdQCSB4plOLN8R7pXFTel+HG0zs1//TTxJItaaeNVA1i2BJioZRgmfedT7VHuBXMjNnUruhdd+rJ91MGFWCqb9ScmkBX57Y7E87bzpc8vcajpTpOMzpUFKCZmUpgNrLzogWzT/ojyMwuSz4QO+ZnQUrQabEb72Uo3Jl0z1Qo4RKJBueBOkiewXtMHmH8OtMrcMmZXKjiYF0jvNpXE+p3NRQW7Mtn47XYdy1MmRCTplOx1tRSbiRpscqrh4MS23mYJUmr0L7H8gJp8ETKLLrYw6p3ICXARCD1Zs7QxplaI7sUAB83eGA6e7AtMqqxEYytqSogagYQh1GOSaowQReQgtT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(8936002)(31696002)(86362001)(38100700002)(921005)(8676002)(4326008)(66476007)(5660300002)(66946007)(41300700001)(316002)(186003)(7416002)(110136005)(2616005)(6486002)(478600001)(54906003)(6666004)(66556008)(2906002)(83380400001)(53546011)(6506007)(4744005)(6512007)(36756003)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpmUHB1Vk9RRmFMVjhob0RRUW9YbzZFdGhRNElBZ0xKUHZiLzgyRWNZNkJU?=
 =?utf-8?B?WnFRRjBjdUlLNjNTdXFxdFBGWlRhTVVEb0xLeVlMbGxXZU1Fd0RBUTM3SWJH?=
 =?utf-8?B?V2NMbjI3TWY2T0lSbU5pbEg1d2JzcHJsWUlnNDd0MExLa0M3ODNLVHIyRW9L?=
 =?utf-8?B?eStCN052QWc1eVVEMlk5M01NblEwQlJCQi9kcXI4aUo4V0dvbXM3Y3AzOXdV?=
 =?utf-8?B?NnV2L0RDN3c3dGI3Ym1TS1FtcTBUaG5aNXdnRUN6ajJ4TmRIMng0NHprOUVs?=
 =?utf-8?B?OW9EclJVSEp2UjdUVjJ2WGt1eDdNM2FnTXFDK1lac3Z0cTVXdUtrVjMzVFdQ?=
 =?utf-8?B?cFRhQ0ZDUlJkdjRReHdKYlhaNjZMaHZiYlVCRlp5Uk04U2lUODN0eisvaFNM?=
 =?utf-8?B?bEpLdjlXckdJeW84aDhJRFpjQlhKRGFPN0t2cXhyU1VQLzdvN1c1YjhLZ3N0?=
 =?utf-8?B?alNGVGxBYXB0Rmw0d0EvNVNSZUxKUVBjemVZS20xOHJUcWFieGdUSEdYbG9k?=
 =?utf-8?B?QXUwbmMyWEdkOFM2N0hPYkxoWmpoMWdkUjBHWERPL1paWXlGZERwaHZpY0ZH?=
 =?utf-8?B?Z0E5OFIvUjIyL2h3Qktqa0dBa3lVWC9RaE1CczhTQVZQOXZvV3RXSkRZWURY?=
 =?utf-8?B?Ykh0WnFFbnZzeURVRVRBVHZnNmlvaUlkQ1BaRlEyTmxEM3RoUHJPdDZuQWgw?=
 =?utf-8?B?Rm5jVlVEVDJzazdaNjl2S0RwU3JhckpOdHorT0RqUWV6b0JoU29QeGJOTmZh?=
 =?utf-8?B?Z1FwcDRMU3VCdDRTa3Y3NktSU2xmd25TT3FmTDg2QmNBNElsSktHdjliSGNE?=
 =?utf-8?B?Rm5pNlRjT29IM3p6TWdQTXlFeUZQQmM5RDJ2algwOU9KNUVQMjRuZjlEUzA3?=
 =?utf-8?B?UTdhUjFuWWRUd1dmMUVCVW5CU0F0b3J3RXBnbEVjSW9TN2lHWExKQmt1R3Vv?=
 =?utf-8?B?YzJIcVhDQk9ZNCthYmYrM2hPYXB4dXZmR0UydGxRSEpDR0ZHdUw3dmpTMGJn?=
 =?utf-8?B?K1drd29ZVDBGaHNVeVhnN2Z1dXdXYjBOUVNSMm91dGNKVlRzMU1haXB0UDhX?=
 =?utf-8?B?eWZYYUNiZWpaSFlrcW0vL3ZBWCt0dmxySUZoVHZlcHg4ZmY0Tmc4bDREU3Z4?=
 =?utf-8?B?OC9VSGdGY0F5Q2Fya2d3SGdiMG85QjVmajJMNC9lYjE3bTFsNXZtejdmeE1s?=
 =?utf-8?B?TkZNQ0ZZd1VDcXVER2gwc1pubkZ6V28wU1ZqbG1NSVlZV0UyU0FGZXFJbzUw?=
 =?utf-8?B?aEFCdC9LWERRcmNNY24wU3hreEZDdkV0STdLWEIxNU9kWGdpVTF1SUJOVjBw?=
 =?utf-8?B?Q0R0Z2JNUUFqcXNSNzBmWGNkWTJqei9RcnVDcDBvalNkcXRXTk1TYzRtRUpv?=
 =?utf-8?B?QStXaWRKTlRVeS9TNHFIcTVSYjN1V1g4VUlCdzlnMmxPZ1ZraGVPM3EwYW5r?=
 =?utf-8?B?a1F6UFVidTk2T1h1Qm81MXY3ZWx5MG1zTnVmdThEVU5CVHVnWmk4VTBSQ2Za?=
 =?utf-8?B?bHRKOTBQSkJnaVdWaG1OdlpjcnpqQ2NQRTNvUm1HMlV6b3RiWVRobS94YWZG?=
 =?utf-8?B?N2NCR0trSDdiWWlQbmtPOWxCSE1ERjhLL1c5R1hjdzMvNklobzFHUGNveGp0?=
 =?utf-8?B?Wno2UzY2VkRKQ2dOTnZCTG1aYWFvVzFqZ0ZFY2xFTTJzano3OTZ1VEJkZDNa?=
 =?utf-8?B?cEpwVjRPNFNLTWQvbzQrYi94WEd3dStaWnBiV1pDa216a3NYc2QwY3RMek1G?=
 =?utf-8?B?ZW8vcUVSM1h6Rlh4L0ppR1BZV0Y1YWV1blhvNjREMXV3UDFPSEQrT2N5VTMy?=
 =?utf-8?B?WnpkUGhmUnA3ZXI4ZVluV29UUzlWVGFPak0xZi9OZlZzQVNRbVhGT0Exc3hJ?=
 =?utf-8?B?Q2xMQkVvUzRENmVqOE9qOG91T042RWdtQm9OS3NzWFpteno5V3pPZnRmS1Zp?=
 =?utf-8?B?VkFEY09ELzR6Q1VTakZqd3hDYmhVV1dpaGFwSE1lV1FmZUxUU0ZmUHJQT0t1?=
 =?utf-8?B?b3MrVkxoQW5PV0VCQkc2RW9EaFNzQWR5T2xFallCWktEd0VqNGhMQUpYYkp3?=
 =?utf-8?B?UjBRK20vOGovSno2YjFEb3pzaEl2Z2pRb1k5Qml3SFZNSU5YeTg0RkRxMkg1?=
 =?utf-8?B?L3pzbTVpV2hhYmpYOHVvdXBwNVJGWS9ONXQxc0NIejRFL2tTNFh2Tkk5aUZY?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2111940d-0c91-49b7-42ba-08dac0e847d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:48:29.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeNP0CtfzaOkBraz66/p3f7v9e+6KF7/PLTnV6UmRbE1M1WH3me2tvFdD8FOjUjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3381
X-Proofpoint-GUID: G2EbL5SiGSEm8LMPZSVZ5kTCVqgSc6Xu
X-Proofpoint-ORIG-GUID: G2EbL5SiGSEm8LMPZSVZ5kTCVqgSc6Xu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/7/22 6:30 AM, Andrea Mayer wrote:
> The test_lwt_seg6local.c implements several eBPF programs which are
> used to test the SRv6 End.BPF behavior.
> Since commit afef88e65554 ("selftests/bpf: Store BPF object files with
> .bpf.o extension"), part of the build system and test programs loading
> BPF object files are supposed to work with the .bpf.o extension.
> 
> Consequently, the test_lwt_seg6local.c is compiled into
> test_lwt_seg6local.bpf.o and the corresponding test_lwt_seg6local.sh
> script is not updated to deal with the correct .bpf.o extension.
> 
> This patch fixes the test_lwt_seg6local.sh, using the correct .bpf.o
> extension for the testing BPF object file, i.e. test_lwt_seg6local.bpf.o.
> 
> Fixes: afef88e65554 ("selftests/bpf: Store BPF object files with .bpf.o extension")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Acked-by: Yonghong Song <yhs@fb.com>
