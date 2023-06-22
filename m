Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862C7395DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFVDiT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 23:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVDiS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 23:38:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6D198B;
        Wed, 21 Jun 2023 20:38:17 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M15RA0000623;
        Wed, 21 Jun 2023 20:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CMlinlQZ3IInaimuM+IUc76MaekTYSFV/RJpag6JF5k=;
 b=hg7DIpHKoxN2egIMhtrdUBaEFIY5/Kji9MRZdWXNYh0iGv2MW5O8aU/mnt2pTV0rCzeX
 qlJ/b0FPd9FZw5AYQ+tptltjJJ8kygbmzThSE7PqAcNR03zND9zYFmF6YFHdG/pDBuli
 ZEsN6t9o0a/HnpDcI0JLZcNzTparwTKKS+/V7bnuDL7GLoplwB6iyIIFhHMiGw1KZCXS
 Ips5HowTzrrH1B+Z1Toe3sEuJ5ZHQlmiq0nDm24RRnwpPoSZRP2nBIToWggGEOPYc9vn
 f560Wc450bZLeC+TTKF8kpUPohzHugUepuRYZzrUTQEM6UtT/VnGFqbBvQ1aPxEjJtC5 Ng== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbwvnqnk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 20:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe97aDBQUqJa5l0/qp58a62d+ZkIB/YiHW2gaJ0hm/9Whc/8THCNoi7/YRW7rGLLi1yJ7qTfNq9E4A6Fu3pwJPXR2DT7TKeAnkr9X9pJdh6LO9fQYrSpGENZ/tBTG9Re38b9JQuRSi6F6T4M4WgMXXc0dfYxKsptg1WcAvmEX1BqwMZvy2Z+aXjowZnxnPnftI5EU3s206q2r9N6m3yC/FwLvT2SiewO9tdVHrDx7KSUPnYX6jv+ZvuTajzjEnwBDz6WEEGGfnmBHgvFozLPWaq8ZC+QJDsugV7w0sFrh6hG/DIedu1thE627aibIm6dVxdYpLkQD6UJ9mNXYQWAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMlinlQZ3IInaimuM+IUc76MaekTYSFV/RJpag6JF5k=;
 b=c/DGC25wdCCaKkraZ1JBUljhL61mnmBi3C9He9ibXf2UXDConBEfLPeEuJbVgHXELUdXU+Vdy2o025gKIfDxE5sOQnKg2zYoTV4NdKH4jT9/4r13preIgXe9cUT1wA/5LovdW9z8oKrWXWsGZkUIzRzsTw+zMqxPW6oZR8vT1Jg/EKB8dghgxih5DNPcnLUt2W3lRb8/X/uQxBisK8mojBHweJVi60Nsf8/qJwm38SDdUkRbNZsTXgekieE4SQpzew6e8jly1IRCuEekmuY3+MVq4fEznfTQ+ulc9AyD7ljoUp+O907j3t6MgQzy9ZC1hzmyo0RgR3GCV+cutJiAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6093.namprd15.prod.outlook.com (2603:10b6:8:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 22 Jun
 2023 03:37:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 03:37:55 +0000
Message-ID: <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
Date:   Wed, 21 Jun 2023 20:37:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
Content-Language: en-US
To:     Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, kpsingh@kernel.org, shuah@kernel.org,
        john.fastabend@gmail.com, sdf@google.com, mykolal@fb.com,
        linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-2-kuifeng@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230620171409.166001-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eed5058-3b8a-4025-9512-08db72d210c4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REK/xSMWY19QamZEST2lzZO19GziojzxfNPP2gM7Htj/XG1Hsy4fmJN3xbzX4Y14h/FiLarZ+OUjIV6RzxkYVZ/ztiovGoomdBajUdK9kqPh7VcFKdEj1iApqZTJschKyJKEdfXBQdYzx+RvE/i+8W/MgiRkP7ph+0ciSgs3SQTzY7K+olc1zLanyRlkDabSd3aRomPAM47gfUIlLDZ5DMzGb4edmWG8LRocCz6TXzWgMrvxkdpsvE1YCIHcnl/jOB6XDDGJ5NVVsJHDjVJkeOp5C6Zksj8STo6XrFFrgSnboXJ2oQop0brQaoh18bqxC2LloYC/emu+tNP5PVAJZ9Ur68cZvO/ywRNxUmrsvPf6cmeDN4aEzLSDsLrav8ajR1ZEdh/TM3mlAJ9JrFWpvJ7bASOgj9oil9i0Kg9WEedaWKabuCrvzw8DB1pBs3le20L7FUls1U2iI2wExwBgQUDLu97jlbF0z1F+0SQHuTVL4j4iQXxnJpJzQ83rsP2p0IcLQFT8dAXB1lHZZs2RI8d3mMclPbf+VeokARgBgVtix6MyZ8djifV9PqD9vqu7AIR/sHqCAr26MrtFjlNGTjJq2jnyM07MlNyMCHOUF5pwjhmODb36P+pGHmTdL+2XDUWdR0vUkP+4J8kshfzmAi0l771qvAV1oaxCNpxL6rA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(921005)(83380400001)(2616005)(4326008)(7416002)(186003)(6512007)(31686004)(38100700002)(107886003)(2906002)(36756003)(6506007)(53546011)(31696002)(6666004)(478600001)(6486002)(86362001)(8676002)(41300700001)(8936002)(5660300002)(316002)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlRvS0NzRXVQemUvK1ZlM3VnaU1hR044MU9aN0VvU2V1U3JGUitsSzI5VFJQ?=
 =?utf-8?B?Q3JUM2tlNGh6bm5GWDhIS3pwOThlcUZheGRubzhkRjVlbWhFcDY5ZTNJMzFZ?=
 =?utf-8?B?cC82cDZ3cXoyazBkVEFra2d6WTUrMXZPdkMzMG9DRENqWTFYRUhNR0dyeEIz?=
 =?utf-8?B?ajJBY3BtSGp3emFmL3RkajVzZ3RuRzIzMkZ3UW9yaFlPREZkVC95SFc4cTdV?=
 =?utf-8?B?NGJDM245d3RzV21JL1J4YTlGZEZDa0tnR1h3YzlkL3RPVEV6QzJqTXhIeDA2?=
 =?utf-8?B?TTdINXpzR0gzU21yMTM0a3R2dzkzUXZ4MCtVRFRLYnI1MFFHWWxrMW5sa0ty?=
 =?utf-8?B?VDRDSUlQV09aU21oaTlEQ29kdVZ5Q1pGeG1nK1lvUms2cGFaaTd5Q1NEam4v?=
 =?utf-8?B?RTR4bXpZMjFNK2U1YzRZR0JML0dna1NkUjA5N1RPSXJwK3hqQ3d2Wm1lVnBv?=
 =?utf-8?B?bk5QdmxIQkdKa1JhZktNTU5hamNwck9QVytnclBXOEhEUTFGS1hKbWFOcHpw?=
 =?utf-8?B?RDZJTWN0a1hRSmZRR0NvdWlaMHVZSGZJVVpDTFR0bisxbk92cTU5K0doUGRM?=
 =?utf-8?B?aDBlTys1c09CVW1CaC9reEsxL20vekNGY0JuSW10c2lXR2RSYXQ1M2dCT0hq?=
 =?utf-8?B?b3lKd1RkeDhUV1hJV0hQWWtkUDZ0eU42UHB4TXU5Szk1dmhsOE1kQmZrNkR0?=
 =?utf-8?B?R0s1R2VXV2xZbEhBQzFEY0JxUFM3OWhoby9HYVJhYkkzbE95SlNBTUJsYUVG?=
 =?utf-8?B?KzRJNS9iaGk3aHZRWmlEYW5udTEwNGk2Z29TZElIZ0FObjFEdVhOZGhJbWpL?=
 =?utf-8?B?M01VOUhYZHBjUGhmR1Jnb3R0b1IvSzJCckdGRXFUSkhwWWd1c1BvRHhYTUlB?=
 =?utf-8?B?a2ZnOSt4WUhqRzBxVXJ1Rm5GRVBES2hRS3J5eXhBaUova3psd0lCb2RWQkpG?=
 =?utf-8?B?Q3RBNDYvRnRpalAxSUNTMWVOYUtNcEhlQTFFRWlFd0liQUxLcFVCTjJjaXpP?=
 =?utf-8?B?ODNRcERjMEpoSUlsZjNNcWl3OFBSVldrVE9Ld2lKQ1A1Uncxd3MrRmZCZklB?=
 =?utf-8?B?M1VSOTdObW5UUTNmeFhRdEljQTRZMFJGdmpoc0RiWGRoVmVVeS9XNjVTTUds?=
 =?utf-8?B?VHFRTDViMEVRbTkzb1pzZ01Wdy83cFJVc2IvUGZDRWlCcHR0V1VUMEVsYUlk?=
 =?utf-8?B?d3AwelFNR2M1T1p2QnFsWE9zY0lKMFptUmdRVGhJRFB2b2hQeU1sODRWdysx?=
 =?utf-8?B?ZHUvaXFLY0U1d2FCZWZWbkQzNFFTaVRJUVh3aThwTkNBa21KNEJ3OVNJcGVp?=
 =?utf-8?B?cFI0TWl3bTEwY2srS3lyNkRlSFlPUVV4ajNUMFZWVzZWVU9JTFpyWGUraEtV?=
 =?utf-8?B?UCtRVi80cVJ3MFBLOU5rVW9pZkhkcGhXOFhqZFlTOG0zN2Y2NUxtR2pPYUkr?=
 =?utf-8?B?NnRoTFdMbUFyRlRtL3pxdjNjUnVnQm5TTjFOR3h0YVUyN2VyYkRwejMwTmpC?=
 =?utf-8?B?QWk0R0QwbHpQRFdEYlhETkMxYjk2QTJndERtUmtxRjZ1cldUN0NxZ2RQM3p5?=
 =?utf-8?B?c01FU3AweGVmZEpOcXYyWDllYTNOU05SM2l3K0VodnhsT0x4ZkdZRFFDMGt5?=
 =?utf-8?B?azBLV0svNTUwdm5ydU8vc1FCVzArZTc1RU1DU3k5Rmp1cXA5K2xBVUR2azVH?=
 =?utf-8?B?OGVrV2Vrd2htRU1LeU1hcm9xVWVpMnl0UytVL045a2crc0tGbXJ0djEySXVB?=
 =?utf-8?B?eXZrd3dZbmI4Y0szMWRYeVJGWVJHc3ZPR0NTS25uOWQwSjNSM25YK2ZwVVp2?=
 =?utf-8?B?ejNwRnZ4T3hPUTVoOXNpVWtSUUVuQ2dPWDFyamVKMkw3TlJLdWtvckQ5Qktz?=
 =?utf-8?B?U2JBbHpYUjFCMlBYQjdHa2l6ZFNnd1laWVp3M1FzbFFsUUlMc2RNcUNzUHZN?=
 =?utf-8?B?RGxCdzZIMi9yZGRoMGdoZlBzY3VPYmxOVWpxQnVzTkNrOEVVUWNudlRMVVlL?=
 =?utf-8?B?WElBQzkxbzJwTmNaTjB2UUFVcGNZamtxclNTd2c0MWVrNzdVbTBIeXNXejRT?=
 =?utf-8?B?Vlk3aUtpOWN1VWVvN2E0dHVvalhIMk80U1dMWmhUblczVFFCNW05Wit5TDRP?=
 =?utf-8?B?emYyZjBDYzdWa3hTdFBhbEs1b2FpQW5wUUpWSTQyVUdRTnFXTHVSTFhOQndi?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eed5058-3b8a-4025-9512-08db72d210c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:37:55.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztLswK8bpbcfaeMvltH9jY57Llj62YAtrailinwHuSGMpDLBSi4rbdtOCrwhicna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6093
X-Proofpoint-GUID: f863XHA7-Je9VedgX4q4rP8k3UcTNVJZ
X-Proofpoint-ORIG-GUID: f863XHA7-Je9VedgX4q4rP8k3UcTNVJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
> checking skb->sk against sk.
> 
> The filters were called only if skb is owned by the sock that the
> skb is sent out through.  In another words, skb->sk should point to
> the sock that it is sending through its egress.  However, the filters would
> miss SYNACK skbs that they are owned by a request_sock but sent through
> the listening sock, that is the socket listening incoming connections.
> This is an unnecessary restrict.

The original patch which introduced 'sk == skb->sk' is
   3007098494be  cgroup: add support for eBPF programs
There are no mentioning in commit message why 'sk == skb->sk'
is needed. So it is possible that this is just restricted
for use cases at that moment. Now there are use cases
where 'sk != skb->sk' so removing this check can enable
the new use case. Maybe you can add this into your commit
message so people can understand the history of 'sk == skb->sk'.

> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/linux/bpf-cgroup.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..e656da531f9f 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
>   ({									       \
>   	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
> +	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
>   		typeof(sk) __sk = sk_to_full_sk(sk);			       \
>   		if (sk_fullsock(__sk) &&				       \
>   		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
