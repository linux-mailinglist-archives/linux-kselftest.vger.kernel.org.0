Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647234412B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 05:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhKAEQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 00:16:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229457AbhKAEQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 00:16:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19VLYpAb013124;
        Sun, 31 Oct 2021 21:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8KxcbJlD/nR9R9nL//+LOAhaFdydTM+DoLhsQE08bB4=;
 b=HMN0FfA1n3V4guLrYDW/Gxi8Gipf66wFtdcP9PeDxMHSUBa6Wco6VcaH0TLzNHrldvCP
 Xa3Mt6ec6dmYz2+jpjlsBBQq0tD49g8T+AXbkGMZxg9+OQLrTNyZJYXp4F6JBy3AAK5A
 8Gq+Ewzo8SudeRPe3tJ8n1z8HMYxlM7jqds= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c1ns749e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 31 Oct 2021 21:13:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 31 Oct 2021 21:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI0yLXxj/6ipJd+xVLh0ZTouI1UdcHQZF5Kz8Bp5BO3RLH6fp6p9Mg3LLw70n2djfFaghsYUBjcnKP/T9BklBpdYHWlNJYxq5pi/bFxVZ/J5vthvsb/Xi7iAXshb+iRsWmGYE0dw1a3zM4AEiNnxBNmQWBm7owQWS/7wMVZd4qEZlskVbA0EsVW6p1rVTM4CpdcV89wHJA+YYIbxiEsTwwbJ+wKM6isBi8jkRHY/WZjtkb8FK0ae2IK3kzx0G1hGce+PvCOcsDLX4ivGysTPrOSpRgn7sFzavn/u+wziD+P2VOsZQQypAMSNzNNT8CdhTdG6muc0wKuqGKmhP35mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KxcbJlD/nR9R9nL//+LOAhaFdydTM+DoLhsQE08bB4=;
 b=HLsNboU+VJn8R9BDHDzCpdOj9rGrbUKiMN/eJfxBYP5Ll6HuKbogufqfhRqn/UqhZK6ZuDVnDt/u6V00Z7nGbmfxAF06s5OPUH0j5GbdE7yFNihYsQJP1xdVQ7n9wnzPWJ9p0ij2GDXYARUXtDb8SGYIOPbaSsAWazsCTptLFBRkPivd46bPHqPchvkCoJdrwLQ/NJX/lHXmMh1XL71O89+mUtVGgJ2/3mXWiVG948baGg78Objx+itGm4Hy7F8aQjA54oL/yw5tM8/KS0Zfpg3phe8U52SFkNdae+cU/IxE2oPJg8kRo+svGFX8nJZ3qitGFn6MGZC4Z4AtB/4oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4095.namprd15.prod.outlook.com (2603:10b6:805:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Mon, 1 Nov
 2021 04:13:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 04:13:50 +0000
Message-ID: <3d7c321e-6099-a7f4-bffe-06d4bf48536d@fb.com>
Date:   Sun, 31 Oct 2021 21:13:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH -next] bpf/benchs: Fix return value check of
 bpf_program__attach()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
        <ast@kernel.org>
References: <20211030093051.2609665-1-yangyingliang@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211030093051.2609665-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::17cb] (2620:10d:c090:400::5:ee01) by MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 04:13:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282fee3f-27b4-4227-f24a-08d99cee0223
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4095:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB409582BE8190421630EFD40AD38A9@SN6PR1501MB4095.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTFw0driQtNC6jhZxVc1Y2QSzEjXY25a1dYXkePr429cVXGxOPqDik6cBguciyeDqz9q8LKue3scbuFAHgKCf1yyS4dsbLS/Xrf+sN3vRHaQikXcNMss3ndjTt7KUvawM+xnqXsW2TnWNBK43Nw+R+TXchUc3MeTS5eunOIc2I8dBcgYkbIWxW8xYzBPMPH/XuC6jr+11yHpq6/OsRYuxj3QVHJdfVP5+Zlz9wpWh12HLN0Q39ChYL0G3jnsrXLz81cX50pd+NsKcWH2mKUN05F+Jwo6IQPBAz8BqdSPi2yXJP0un4RGJLTm2TuoFu4oIpmPXZw5wp8QfxPn6adK8cCZdcaZ0p1HgWozk2eu30ehy1u4SY0bY9zCLGhVLbPykQzBcGInLFbVI2ZynNcU2dtpeFwcM3BMll5y+u3uJSGgrWyd5cOR8/w9rulPGKtFAvSYNMb5pWMYS5laFVF5v0Lo/X+clzEpFvolxblezJKEf7mtkKLzQjajizhH0z4k8DDATp86rGb/XGkQ+8Szfj+oo+0CEWPvN1QnsTh0PcOUkeLWV+Zf/C9L/B9pWCs1kO0wJFyTwr+GXU+Fw7MefkLCBabdnImNv9kc1Gpt4k4B1x1J9E6PMLMLXFkYk5q00oYitQFp2D40ObWhmEfR+B0oJCyefZXjXegVIG9RfkuIaiQoHPExv59wBUHI6lBjCuj1Az4vDdiwOygKXxo/FP2eSj3p5jb4tJ9vsjoZiFb34JkNqXz9ZxkLdKiAY2uLkbeCcOJ3V4jtyHzg5naUyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(53546011)(2906002)(66946007)(4326008)(186003)(8676002)(83380400001)(316002)(5660300002)(52116002)(66476007)(66556008)(31696002)(86362001)(38100700002)(8936002)(31686004)(36756003)(2616005)(6486002)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzlWWHJPb3FLeEgwY2xnSU45ZTB0VkNCV3dSOE43WnRoN3dmWmE3QUZFNmxW?=
 =?utf-8?B?ekZiSjJHV2IrekhCZktKRWxUTWs4SC9nS2FnTUV2MHJrVXc5V04xYXM3TEx6?=
 =?utf-8?B?Vzd3c3h3Z1czb3dYaFhsMlUxbnFWdlc3TUtxLzdnWTJ0SlNlVFZlQy9SRWpM?=
 =?utf-8?B?bmEzWVRaemlWZlZrTzZUQ2JHd1MrQnBwV3hTNWttaXc5Z2Q5TytiTzkxb3U2?=
 =?utf-8?B?YXF4MzJFWlVNVmtCMG5jb3h4TnJ5UXN5M2Q1aGZMZ0J3S2ZGY1BsQVlCNGUy?=
 =?utf-8?B?bEhvbGtQYW1IWkJtSnV5ODV6VmlzNEl4Y2R2Z280a2dwUk1MYWUxQVpNcE9y?=
 =?utf-8?B?RUMxMVZISmdTVWFBTWRIWTJma2h1MlhzVmd3YVE1ZWR5REQyTEhEQ3c5NTZY?=
 =?utf-8?B?Z0NTeURQWDQ2cHh6NGVieDBCeDdzbzEvaEZDcnFITnpGVHBEZWpXM0M0RGJR?=
 =?utf-8?B?bUozZVBpc0o0WFcyYks5cGRLQlBrc083WWx3VzNiNHJSMlJMZ2xmTzRiU2Z3?=
 =?utf-8?B?YXBONlJNdTY1OUhpOGJCVm9hbVI4WnZpSmYvOUtDUzIzcnJNRlhJaVB4U1pv?=
 =?utf-8?B?ZVVOdGNtSU5Lc3hFeW9IU0xxSVpsU2RtbnFnZkVwSEtKdVpzVGxxcUowODR5?=
 =?utf-8?B?OGpDUjdmSWFuNkhnZkZxV1htNjIrZzdVQ25BZ0E4eEM1d3lPQ3g4WjRxeC9M?=
 =?utf-8?B?ZVE2c1BGLzdwM0c1L1JHUGxqb3VlRzdhM2QxbFZkcE8xNVVibGFLK29ERExj?=
 =?utf-8?B?a2cwc2ZIVjVVd05oOTRmQXFDdC9WVnUxVlc3b1lUeG9iNXljMzk2Vk5yRkps?=
 =?utf-8?B?aUx5MHZQSzVOK2l2US9BKzlTaW9neGRXYXV3Y0lIdVNOcHRSblRraUZiaGVn?=
 =?utf-8?B?UlVUQ0ZsaWRORUFKK292ckh1VHB1dE5yMXJPSGMydG5WcXp2a1BNOW9MTGlC?=
 =?utf-8?B?eTF2eVRPdlNnQzNrYnVCaTF3L1l0WWNVU2RCR0VkaWdSU0dYay8rTXZhMndW?=
 =?utf-8?B?cVRKQlBoTWptRHlsdERxbVE0Vm04T2wxLzVQR3E2UWJaVFp1WnpqYjZXVnRI?=
 =?utf-8?B?THlJL0xEdkRPM3E5THBHWEtVTUVnOUJJcS9ZWWNGZGk0WElHWlkvdE5IeTA4?=
 =?utf-8?B?TC9kdkN5QUlDVUFDSGErcVZsNWlhZWFtM2Jnc1I4dlF6QVZLcUc5VUc5UURG?=
 =?utf-8?B?N3l3U0NxNVNrZlFpRXlXekVxaEgvdGtqeTVqOStCMHRRaVlIZ0FSMGJValE0?=
 =?utf-8?B?Y1dXaU9ldFFXVnJabzBVK2crWUtSMURUbkR0WlozVmZnSG9PaHA1VzVHK0o5?=
 =?utf-8?B?eXhLb044eHh3bytOcXVOUDE3a3NkRUJiRFl0V3VSeGNrdmNCdHBqTTM4ZVVt?=
 =?utf-8?B?M0RKOHplS0FrcXFzOVl2Y2l2RU8xNjBNeHRnWDRWcDBVUEdYZks2bFZHZWw0?=
 =?utf-8?B?aEd5WStjR0NtMk9uYk9aZFI1M1RxS1NWNkliVGNxSzMyOFRDbTRpYkF4ZGtl?=
 =?utf-8?B?elhSVm5UZjNpcytzT1RNNGo5d0FDRC8xQXBpTEc3dFQrbGJqY1oxTjNER1dj?=
 =?utf-8?B?NG5OUGl1SzQyOG1IZkY0MzhJUzMwUmROMHJkZXIwS0FWVWYvWDIyT01PZWJr?=
 =?utf-8?B?a01RdnZ4S2ZaMFd6YlVtY3NVOHJFaHJ6YTUvOGlydSs5NEhCbWtEOFJHZ0x0?=
 =?utf-8?B?SkNrVFgrUk1nd0FzdnUyZytyYmtsNlNNSE9FdnNQVHZKVi9ORUo2OHNMVGxC?=
 =?utf-8?B?dmQ5MEV0d3dIeGpDRUQ3TURhMDl4aUZXZndxTWo0NVk0NjRaV1dYS0NoOWZV?=
 =?utf-8?B?bWRkOVlZZkljSVM4eld0L0QrTXRmYnhVelY5OHI4ZWJtWGtZaEkxMGVUdnZQ?=
 =?utf-8?B?R2FWUmpFQndGSmhtOFlwQkNTeVQ2ODF3R0xpMktEeWRpL04vUmVWekx0QWhj?=
 =?utf-8?B?NWM3eUZnd1pVZkVrWm11eXRaWm8vL0ZDVlY4V3E1SFpvUWxTTzhOUXBTNkVN?=
 =?utf-8?B?ci9ySEwwdDhuRjlabnlnTVBRY2d1THErTUpHTVlnTTBWNFFraU5tUHNkNmRh?=
 =?utf-8?B?U1FOajBqTE4vZmNiOFhSanI5NmgxYTFpeVMxSUpGMGsrN3loZDZFR1V0eGxR?=
 =?utf-8?B?R2hJekcxd20wMnpjTHZBUHNOR003Sm9mZmZvbU1ObUpDaVY0SU9JOW0xSGdC?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 282fee3f-27b4-4227-f24a-08d99cee0223
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 04:13:50.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hN3zLrC7RO8mYtxIrfYe/he3dwe58TJGZefT5rPuYFQWuQyq+xO/YQ7odMcXx+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4095
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -esCVVy0CDM_5bM7QN6OiCNe_rN6d1kE
X-Proofpoint-GUID: -esCVVy0CDM_5bM7QN6OiCNe_rN6d1kE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_01,2021-10-29_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 mlxlogscore=979 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111010024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/30/21 2:30 AM, Yang Yingliang wrote:
> If bpf_program__attach() fails, it never returns NULL,
> we should use libbpf_get_error() to check the return value.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for the fix. LGTM with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../bpf/benchs/bench_bloom_filter_map.c       | 20 ++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> index 6eeeed2913e6..6879340b20c4 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> @@ -296,6 +296,7 @@ static struct bloom_filter_bench *setup_skeleton(void)
>   static void bloom_lookup_setup(void)
>   {
>   	struct bpf_link *link;
> +	int err;
>   
>   	ctx.use_array_map = true;
>   
> @@ -304,7 +305,8 @@ static void bloom_lookup_setup(void)
>   	populate_maps();
>   
>   	link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
> -	if (!link) {
> +	err = libbpf_get_error(link);
> +	if (err) {

There is no need to define 'int err', you can just do
	if (libbpf_get_error(link))

The same for a few 'int err' below.

>   		fprintf(stderr, "failed to attach program!\n");
>   		exit(1);
>   	}
> @@ -313,6 +315,7 @@ static void bloom_lookup_setup(void)
>   static void bloom_update_setup(void)
>   {
>   	struct bpf_link *link;
> +	int err;
>   
>   	ctx.use_array_map = true;
>   
> @@ -321,7 +324,8 @@ static void bloom_update_setup(void)
>   	populate_maps();
>   
>   	link = bpf_program__attach(ctx.skel->progs.bloom_update);
> -	if (!link) {
> +	err = libbpf_get_error(link);
> +	if (err) {
>   		fprintf(stderr, "failed to attach program!\n");
>   		exit(1);
>   	}
> @@ -330,6 +334,7 @@ static void bloom_update_setup(void)
>   static void false_positive_setup(void)
>   {
>   	struct bpf_link *link;
> +	int err;
>   
>   	ctx.use_hashmap = true;
>   	ctx.hashmap_use_bloom = true;
> @@ -340,7 +345,8 @@ static void false_positive_setup(void)
>   	populate_maps();
>   
>   	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
> -	if (!link) {
> +	err = libbpf_get_error(link);
> +	if (err) {
>   		fprintf(stderr, "failed to attach program!\n");
>   		exit(1);
>   	}
> @@ -349,6 +355,7 @@ static void false_positive_setup(void)
>   static void hashmap_with_bloom_setup(void)
>   {
>   	struct bpf_link *link;
> +	int err;
>   
>   	ctx.use_hashmap = true;
>   	ctx.hashmap_use_bloom = true;
> @@ -358,7 +365,8 @@ static void hashmap_with_bloom_setup(void)
>   	populate_maps();
>   
>   	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
> -	if (!link) {
> +	err = libbpf_get_error(link);
> +	if (err) {
>   		fprintf(stderr, "failed to attach program!\n");
>   		exit(1);
>   	}
> @@ -367,6 +375,7 @@ static void hashmap_with_bloom_setup(void)
>   static void hashmap_no_bloom_setup(void)
>   {
>   	struct bpf_link *link;
> +	int err;
>   
>   	ctx.use_hashmap = true;
>   
> @@ -375,7 +384,8 @@ static void hashmap_no_bloom_setup(void)
>   	populate_maps();
>   
>   	link = bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
> -	if (!link) {
> +	err = libbpf_get_error(link);
> +	if (err) {
>   		fprintf(stderr, "failed to attach program!\n");
>   		exit(1);
>   	}
> 
