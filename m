Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0F6EFC9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 23:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbjDZVrz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZVry (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 17:47:54 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76253AC;
        Wed, 26 Apr 2023 14:47:53 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLZDrV003707;
        Wed, 26 Apr 2023 14:47:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=loIKsCy2FUJ5gA4qoestcaLVxImydjEisTwtqj/sM+g=;
 b=dMoN4sGijtE+pvsMH10uoht1GN4KfzpwF84ecYuE3I/YSdOdqSPwnvXQnqPLDB9eXB3q
 ErIi//f7/MEiSS0hc1bkQlEUB6tZ+2q+y2mjZOTBO6ucEDBaoleoe3X5TS641gngbmwQ
 zxvFIXKYXoCMIpnl2wRKexKa4k3JUI/TwIxhON1f9axP1WtXL9tywVgq5CcXYYQCZZeB
 6PVqf/FWu7zpwsdNOUbkJb2TX87fvQhNl8DleEhJBFW7g6Yn4cEwoA196BL9oMurBN+e
 EpA5qb8HybUaeSEa+vV31ADGWDChLavEalP2wxyiKoZfGYBsNr7Ule4WtUbqmBwviHwm nw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7av50gs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 14:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Qb+rkgmEYoXbZvkkE+owsQDDphqDCfO1ChR6iPx8Chr1XtqmBaAJdNefgb+Ev5uXH3CT6CORVjnegOT0G+fe92RUA8qd9GrfalT+ChE0l9+lvDbuSrMRp4y5lX5tXKLaoA6on+MR15iQ03tfoDNEDaCj7L6EbpB+hCnXfeRHv4b9UUeFoK7PKEXxSf5KDfshgJHngfKiNHfuIPPiw7sDe7NWeW+18C8Fe1s8wmdOQKWGl+70HebV9obZhZnN1Rus+o5fQlH7EiOqKm9YSNce2bsNfR65+8kW4Tqu3TfUR3xpWqRVO0Tq+vn2faBbv9H2qRKD6cLkleeIu7W/cFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loIKsCy2FUJ5gA4qoestcaLVxImydjEisTwtqj/sM+g=;
 b=gESHIaTvswmtkCNzZea4T5JPoO0uy4A/lNFBi5fjs+kUkGdwm0tkvPKZPKrssPwH0NBfUBtj8V4FOj+oyoT8jUm2cETxZeC+XkONRMnNUyrXtoN2Or/aIRlQAS/4/X1DWSKfuxqlkYKRL+K/UfzinyOlteVeNfvpwODKeCs0zD7yhnIComQCghKrpkdonyJA8s3ttCJ3/qaVVUQTu2LvInfMW2rnR3EqLKGq1tABBrtCJXwE8qytFLg+izzxQxZ43fFvR2oP1FDdPBLK286oe7A5aFGYvkMNFUbrgsr6QzCsZQu0Jr87DaCtZ4oz3ToTMYzG32276jFmXPkhfO9sFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5268.namprd15.prod.outlook.com (2603:10b6:303:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 21:47:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 21:47:32 +0000
Message-ID: <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com>
Date:   Wed, 26 Apr 2023 14:47:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
To:     Espen Grindhaug <espen.grindhaug@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
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
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ZEV/EzOM+TJomP66@eg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6c0ada-419e-4b99-738a-08db469fd6b0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c027AUdu2vNQyhIRV1HT/ywsCfk+1PeM+Sjl+uSVz3dv/+/njfzX/i8lyOnXKm4NIB0gTMZzxbgEPO4K9U1x9Z5yHbVGugWvlWWSbY6yHXHTKX1+eJphxR+Fd2v5KE/kLt60+awvy6A2hsp536YsPGNO0qeZG8ThimYjSlMrGru7/TsAH01C+8nLQgO+lMBQCIDMblEYPEQpIP2kcmvqngcLL7u0dfp3mkMxyB4AMKHQIZI0jlhcIqCgDB6jsx1G3wWituW/8uqWxdLsxPRb42cgy7uP1oDK4H+HDiw54uwVIbIZ2LUBHEiJkeu6wCBG+muGZzYEZLgkSbILenQi9cTHlHvHD3c302rdx4TQYJDqRTUUD/Oq2CJyduqbMp7xJXzzjgMURC/6RXItaOhwotNbjsT1sHo6F/65kk/fUmg+ZvDFWZhFa3BWgHRLBwF7wyJKrwH25MaPaPNuy26A3V787xt1t6CvhjSm6xk1Y8U1j07Itw7SrifGo84341EpcpqbjLWoeHwXfc1IJDoSe6fa4rZmHGHALhzDQivj08n1pQr7t51sC2+QAFpfIXpcsJ3sYljsmwGEW2ZXCXolHM8AFY6qJL1CCL/EtMLB/nOGX97Cj/qDnuik5YkoAJCzhcOqxukU1WQ+V2ejIvdqXPqqyMHhHuPmOPxpESqmVhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(86362001)(186003)(6506007)(6512007)(38100700002)(5660300002)(53546011)(31686004)(2616005)(6486002)(31696002)(6666004)(83380400001)(478600001)(36756003)(110136005)(7416002)(921005)(41300700001)(2906002)(8936002)(8676002)(4744005)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy9XY1VRNEtHbGcvOXJYOXltV2lPM2JPVkJFKytxVVBPRmxFQVkzdlJWamJM?=
 =?utf-8?B?ODZMdGtsQ0h0cFhMNk5naVhoY1EvWFZtWGV5RldabUhZamtzL1lpSGpMRlR2?=
 =?utf-8?B?VGF6YU5iRDFCZ3RMdEMzSlpQaXBSWHRQM0RyakJpbkZGZFVjeEhkdG4veFRD?=
 =?utf-8?B?WGxrV1RIbCthVHVkVENCMHhJN3dXLys0d0FyVTQyNHBWTEMvSTZQN25vTXgv?=
 =?utf-8?B?RU15N3dwWXpnRHBXWkhheUtQSE5UNWhHUzJkSndlbVoyZTN0c1FpTldzK3VB?=
 =?utf-8?B?cGFoMFNOem55VGhLWFlZTURTdFo4MUdkUE1JRUZwdlNxdGFCSlBXdHhGOUFD?=
 =?utf-8?B?QjhRZ2hDUTV2b3dmMlUvM25kZHNBVEJpWE16SEpsZG5raXlrY3RHL3RmWFV6?=
 =?utf-8?B?Q0pBM3hXYmV3YXZuSi9lR0FBSmZjVTN1KzdSbW1XRWF4ZWF3TnQxZEV3aU40?=
 =?utf-8?B?SVI5Y1UySGFtVXlncVArU3VQRHJIUFU5OG1kYTN3VWk5YVNYZ09vZmVtNUNH?=
 =?utf-8?B?R3NKRUZHWnBWM0lzL2c3bjBaWm5ZenU1bjVBa2tGVnNOM1RNejFlSC9EcWV3?=
 =?utf-8?B?OXdmOVJJUU9Fd3cxTGhjNmpCMG5STTdmZk1GNkh3bnBXeHdFNnUyUjZuT3A4?=
 =?utf-8?B?NXI1Zk04ZXk4UldmbGRUQUF5eWltWm8vWGZhS1RBTnZCVjBLZlJjaWo4czhC?=
 =?utf-8?B?dUJYMVVlY3FPQStwdmdkdkpZOHp0dVJRbEVQYXRTWlIwVzJIdDBtNHJ4OEF6?=
 =?utf-8?B?M25yUE5EdDBkQ0kvdUc5R1N0dFVDZ3RiODQ1SHlSQ1VCWGRvRWM3QklHa0tU?=
 =?utf-8?B?eDVvTEU5US8yeXFhcElURGR0MXNPU3ZYUTBCblFsbzFFUGtVK2Roam94Q2NC?=
 =?utf-8?B?U3Q5aTdMTUZEMlFqc3BmSExSMTZmVTF6L0dYdk1iRGRFRnFFdUhwTEM3c1F4?=
 =?utf-8?B?SThxdStqeWZlL2VuT3J2dG1PMGkxdnluQzFhVkJVNEp4eUpVVDlYZ0FRb2g2?=
 =?utf-8?B?YUhLOUhvd2h6M2NZQVY5MWtwb2JQSkh4ZzRkZHY4SWdqUUxBMEdpVTVScnpP?=
 =?utf-8?B?NEJkNmpqUGNBcnZ4Rm02eFh6OEVvb09NWkc3clZTdjZuY2NDb1c1cFlnUUZH?=
 =?utf-8?B?Vk5jM1R1WlJzWStYRVV2eURJZmF0ejBlZU00aG9vd1ZWa1JLNFFYZGhOV1dJ?=
 =?utf-8?B?RVFaTlh1OURxYUd5aVdFWGs2em1WTFQvRDBmeS91eWNUcUY3cGlvd0gzR2J3?=
 =?utf-8?B?b3Fwa2g5V0VXcDNYSS9XS1VYbWlTV0Y0dkUyZDlOQTZJT0JhR1dqYmhKRE9x?=
 =?utf-8?B?dXJ3TGY0czRramNQSEg3QldZR2pMNFFucWFPN29GWW5TMXR5elJDK2FvdzE0?=
 =?utf-8?B?VUIreFljSWxBQzlGNXFWMEl2MlVodDk2V3JXbXVFUVVGZVRVZWtFbWt3aktz?=
 =?utf-8?B?ZWJsZzkrcFpLK2d4Y1pDZGhpMitxM1J5UGN1ckdhSnFpQXgrVDIzeEFQVmla?=
 =?utf-8?B?WGNnYU5WckM3TTlRQ09mM0ZkTjVnaXpsL2JVb2JJb0VmZXZKVmZ2dEIydWJB?=
 =?utf-8?B?cGpHMHRHQ2xZeDdsa2k4a3ZSSXVId2hFVmJxWmlmRFRzRERUQ0dna1BYUlB6?=
 =?utf-8?B?QXdETVk1bjVQRE9nbDdvN1RWWml4K1ZBYW9Ld3RWeUVFQUpKMGxrNWQ0M2RG?=
 =?utf-8?B?bjk5NUZNaGRQMFcreENsZ3dMVkthNC9PMnhsVTFRaXJHVDgyZzZDSW9GRDA0?=
 =?utf-8?B?U1k1ZkVpQVRNbTJYNmN1b01nb2dkUTByMTI5T2xDZzZDVjkvZ043MzZPOFBG?=
 =?utf-8?B?RVcwdU14UkxLa1Z0K3lrNWZ5U2k3c3lMQlUxcmo1Yyt0bXB2MHVhRElXaEdL?=
 =?utf-8?B?Vjk5RmtlU2RXR1M2d0N2S3BoeHpEeGlPam5JbmlNK2l1SkV0QzhOS3hTN2pY?=
 =?utf-8?B?WVYyMEQ5amhLWDljaTcvQVpzQkQvZVlsTkpkeTNaeVFqVTdFNXJCNTdZQlVq?=
 =?utf-8?B?d3NzYzlmQm9NdzFhUjd0Q0lQdndUVi9oeVc3NitUKy85RmowZ0IxZmwyb1dx?=
 =?utf-8?B?c3g5MHhtTXc1U3UwVVlMNlNJNnBkY004U0o2Y29nTWlVQjc4UDRBT2RobWha?=
 =?utf-8?B?UFlObEpOZmZoR1lVemlUa05FWUhsT2o2azYwUUdzeHA4UFc1VzNPRmZFUFpN?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c0ada-419e-4b99-738a-08db469fd6b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:47:32.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkR4q45NeNpthnkxHGS0lNjAG1SD76qSA8nsCtb7ABrLB97vp7xlhfn4BWsmh9GN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5268
X-Proofpoint-ORIG-GUID: sOz-I6c_0tspLBeR7QXQFotuqwCtc1_6
X-Proofpoint-GUID: sOz-I6c_0tspLBeR7QXQFotuqwCtc1_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
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



On 4/23/23 11:55 AM, Espen Grindhaug wrote:
> This change fixes the handling of versions in elf_find_func_offset.
> In the previous implementation, we incorrectly assumed that the

Could you give more explanation/example in the commit message
what does 'incorrectly' mean here? In which situations the
current libbpf implementation will not be correct?

> version information would be present in the string found in the
> string table.
> 
> We now look up the correct version string in the version symbol
> table before constructing the full name and then comparing.
> 
> This patch adds support for both name@version and name@@version to
> match output of the various elf parsers.
> 
> Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>

[...]
