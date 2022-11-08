Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8546621DBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKHUhD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKHUhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 15:37:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECCA60EB2;
        Tue,  8 Nov 2022 12:37:01 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8JRIrG015007;
        Tue, 8 Nov 2022 12:35:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KIkKmz1t4LjwjIgiAWKVZFgMsQ5YudQin5RbasJKo+w=;
 b=j7QxtUQ37NufJEPrWElqbzkJDRB8vOPQRX0AT64Dg7wAMb6l4EEWJtmC10F49dFdti7/
 iuur/tTbYXOiZeBOVm8aZ+73LnfE2f5z41PkgGybBHCWbSaJBwZzHp0mtCiuJXX9Nzf8
 i9IG10Hd4FFJqJux1UOxjnSsneAaq+/gquiK5e0qE7WC+eUgjFbnbve1g9s1yyOb5unP
 TIH4XTLXUKJyAt2lK8QzGbnyXwZ7oVcE4B55Xm7fiSq3RzKG8e2wlvd+tRzl7WVHfGCg
 2DoX9/dYA2qnTTahA2AXge5H6zhU+sMtuZxVkB0KBRyMAY6z4hA9/ZFXkYTabGzTs4LY Kw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kqp1mmtrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:35:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Y0ejIJ3w5XcfU1H8rmxOV6y6MblfDgntHpt4X6PmrNMPgRvWk6GYNMRMXK9WN/DjwYtZPh3PWDURi4JNRgG2I+4YnoJNdkRAtnM/epyUhmeEvahfGcbJk3lCtx5BdiV9QcNIhVBQoW7CUQvMV05NL+NMpSPNJaMKTp5Kb6fvhvfGC3hoKuKPlkE5OeY6vyAYzR1ddglUb8iYZao3QJBie66lr+ELvfpe+Yi/lBO/B74nOsVvTtpHJnsUSXdHniqjXDENUkDTjv7SGH3/mWThZOhV0w3NC3cw8Y5rL01X2lTqBId0qVvS4LogXTE1QGLZOzJdwf202ea/SVXkV+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIkKmz1t4LjwjIgiAWKVZFgMsQ5YudQin5RbasJKo+w=;
 b=k2MhgLeNFuPuTDSo2hamneixmnZIUo9AWxfdsv2jqUXcVtt1rGHEk3g0beccAk8GDL5egd9hPcQwxuP2e2ggbUe+D0XFcg5HoEI8PtF9SS6ei9BU/b54K38JwX4cTzaeo8ZM5RxJN1qRC6FS5Qtk1LaNbu95yAvNqPEuQ6wzCIBd59oI0Sj/iK5iAZmxquE0b8o47NXNMBlAA4+K5MyxGuZkEsVJ/DZfOITLzFfOvJ7b/JZmmj7fPDr+eVcPBJ9FDBkjd3vbAq2Kcj8yT2Ah0OaHrPXIsu81XSiGG2SzQ9Q9LNWKAfPfznw6wDNB7l17CVYgk3WLsGyO63BCLp1E7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2724.namprd15.prod.outlook.com (2603:10b6:408:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 8 Nov
 2022 20:35:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 20:35:25 +0000
Message-ID: <a725e235-f4e9-84a3-a88b-dce274423a75@meta.com>
Date:   Tue, 8 Nov 2022 12:35:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v1 1/2] maccess: fix writing offset in case of fault
 in strncpy_from_kernel_nofault()
Content-Language: en-US
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
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108195211.214025-2-flaniel@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB2724:EE_
X-MS-Office365-Filtering-Correlation-Id: b669062f-1255-4888-c49e-08dac1c8c41d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+wofzy3rMA3s4BcarEzh5X4xz+WDDxrMJSGTOyQdvdPFqA/ZkSYg/SwP70w7vyFb3QjN6zMkNwTZbwOV58hDMIff2ERHH/PzvxZUA5+WZE0pLKU3NEv5myBH+EBjI+AY4xkO6fVFdHivoC2i2BXhnAHuhr+9r5M48cTNNRbVBEOh0OvbewBqjrqsuY56JCKvxe1HGZDAuF887oXa8rp2Bocx1wjscx1wdiDF71hTteuCiz25Dq1ZJ/Xgyp6OILaG+QMPszrP4Z0lBkbG/h6lUUVKMdSByqae5Z4++ZiSY6G3vzFa3R9jvxNDFQgvqsdT8nOb/f9Anqr9Ge5N+qSjfT+DGRVue1hK2NpFiGLIX/EjgxBMe0HAXQWaRz0f8croHlDe6SbrTlmWK/YpJoHkk+VMGVqyAt3z+gyPkiTFnCtCqhtWftydzwng86RSaMN/HQhbo2/fBXryPQ/eKGYbVk928KFZF44jWieoWsaaB0uExrPJXg4JPQGa0xP2ohrGQzxzQVSMO2G92As7D3a49c6D3uhUzF/tr4TqsZ4Etls9+GvlssjpAAFdBydISuaTlEqwLAdgyrwK1etLW+uJifxcMI8S3KW+ogNxpqrQ7yI+5KiyCJrsFKBXcN0e6azMFmtaVdc9uH2OZWGoDjb4ssCuQ63c/tP5P2hIefbXg4gj9RfdkYms1bKNt63cxtbx3BGySSnx+d1w0wBNvsQescmbUQnuFwjDJ3hwYfjkairlVzYcT/M2LYs7WLL7buq6D/Mgp8N0NYcz5mIQpAvvGn/0bruZQ3cWm9Wuo9a9UI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199015)(83380400001)(86362001)(31696002)(38100700002)(478600001)(6486002)(8936002)(7416002)(6666004)(5660300002)(66556008)(4326008)(66946007)(8676002)(45080400002)(66476007)(41300700001)(316002)(54906003)(2616005)(186003)(6512007)(2906002)(6506007)(53546011)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5MdnlWeWd6ZzVyVDZLdzFuVXg1MUIvL2J6eS83R2ZvdEJXYVhwU3FlZFFU?=
 =?utf-8?B?MElBMHlDVlprRkJvWlVHZUJyQjJLVXhyYjVBcHdCQnhiQlBFM0FrUFZrZ1Bw?=
 =?utf-8?B?VTRhVE02cEF0VDJIUUpxM2VDZ1lmMEh1cTJmZ2EwdzA5SjlUVEg0L2lnU1JZ?=
 =?utf-8?B?Q3dDNi9iQzNISlcya3NDM2EyRitBcTZ6WEoyU3pLUUg4MW1UcGxxQWZLZnZX?=
 =?utf-8?B?S1dWMzd4VDhScWVvc05seFdRU1QvK3cyYWlpV09kb2ZBYXRFMnluT2FCR0dm?=
 =?utf-8?B?NW9YUSt0NjJCMEs5Y1h0bGp2Yzhwd3ZGcWpQVmRlWFJVU25RUXlKdjNaaUN4?=
 =?utf-8?B?S2RWS3BscVFQMU9NVUpETGFTUUhxLzhUSWtuWGNkMVQ1SzFrQkRDMFZLSzBl?=
 =?utf-8?B?MDJDNmcyU3VFc1FlTUV4YlhxTUUzTnp1UDB4STRDYkQwUXp4VWYvZkdkSTdW?=
 =?utf-8?B?KzF2YU00TWl4WURScUxaL3ltcEVkRmpTb3RrWnZPbmtObUR1cEFzSUZXaTY2?=
 =?utf-8?B?eldBUXhiVnRiOUtIU2p2QTAwRnB0cXhzcENjZkJRT20xV1BIVzFhSnVHQUNa?=
 =?utf-8?B?a3M3ekNxQVk4S21paDVrSmUwR2VHRGxYTWk1TmZ6MTJFRTNiT3RkYXk2OHND?=
 =?utf-8?B?bE01R0U1dUZicTFsa2pKdE4yQkQxWE1zZkZGR3BYSWtGZ2Ztbi9acEpNNkUr?=
 =?utf-8?B?TXF2SjNnK29LeGU1NVF5VDNKcFcvMGlmSjVCb2NzOUNTWlAxeWVxZGtWbDNw?=
 =?utf-8?B?SS9obWpWU3NrRjNYL0ZpUURCRGdkN2dLZjlTaDZuK1NhZ1FxckFjM2VRSGtI?=
 =?utf-8?B?Z2IwWmFRbHBxbkpkTEdqTlI1MGQ2aUN4ZGg4MlJmcTVEUXVLSzRvcHpwcGwy?=
 =?utf-8?B?V1dIVGpPYW95STZteWkvWTlMNElMd2YwdWgxbENjMGYzNkVtMUxLcGhuRTVN?=
 =?utf-8?B?NTUxcldIblVPL2lpV0ZkOXZvT0hnSE8xWmROTjdRUWpITG1xOGd0dGcxcGhK?=
 =?utf-8?B?TkN1MHJJT2lULzlDWnpjTXdLdFBnM0NvdlEwcmZKd1diUm1OQldJaWNwZU11?=
 =?utf-8?B?ai9aajl2cEowNWZzQ0ZZUEhaakF6emx3THlUai9qaGNtS3RxMHRseDZrWW1O?=
 =?utf-8?B?MmovU3AzMXFNZW5mN2JhSWQ5N0ZLSHB5WFJ4VHJiMHVNUjRQQmpBdHVqREli?=
 =?utf-8?B?WVZ0RWViSmlZTHFlNjNwOGpnSGJUUGFScVpaOHlMcUViMzhHVmkwcWdlZ0NJ?=
 =?utf-8?B?c3ZVdlVvb0hsa3RHVmZYUFBLZXRzQnAwU0hFcDhMaXUvd3NFM1pxZDUvYTk1?=
 =?utf-8?B?K3lJamcwcUdVcjl6MnJGZUtubUVNckU3TG1YSWJVb3VrSVdYNk9PN2IwS1hX?=
 =?utf-8?B?bktncjVLZmhjVUZ1cUIvNHQyMHpZTThQUzZBMlVXbUkyTVpFRFpWVi91NW9L?=
 =?utf-8?B?WlhTd1dJaE1RMTJQemdTMDY3RVYrUks2KzYyMHkzOHdISkg4WWFyQ2M4RTdH?=
 =?utf-8?B?YXZycHJQdWRHZmtPU0pjaC80M3RPZ0txZEltUTd6aDl0NGk3Wm5oYkt0cXdD?=
 =?utf-8?B?d09uekNIcjNranJESmFFbThUMlhJT1NWVFZqd09BQmN4WkZoQjB6Q0l4cUFO?=
 =?utf-8?B?THdIV2R1MnlhQTdDK2tCQU1YOVhreWxuRlB1YUtWeTczUXAvMjE1cnpwKzR0?=
 =?utf-8?B?VmtiT1AvYkpSUHVKUXBTblN2bVlSUXVxZmlRRWp5Nm1NR3pjVC9VQlRiQzJT?=
 =?utf-8?B?MG9MT1E2N2FCeldMbDRWUWxaUFNnWGd2RW5Gc3VpalFUanYwczR5UEswNnB0?=
 =?utf-8?B?eEIwNmlwdG5ndkVkc0puOFk2MGVlb2wwQlpPcmlxLzJFRk53VVM2OEJHcWhI?=
 =?utf-8?B?cUZmeVpYRDZZVnR5aC9BMHlvTjR0bVQxbkxYN2FTVXc2Q3VGb1Zvemt5UG01?=
 =?utf-8?B?K2dGUmF3ZlYrUnRXMHZFTTF5K0pYRDNKTUllc1V0ZXd4anVPbUtPQnE5T3Yy?=
 =?utf-8?B?Y3E5cHRSd1NSZGZSQW83Y1NQZVFsSGMrZHI3Qk80NUExZDhnRVErOWQ4VEFR?=
 =?utf-8?B?L1UxdEwyS3dQMWhMWFdsMmVNd05lWXB6S29DOXVXT0JSd0x4TFgvTnVoN2hu?=
 =?utf-8?B?UGZpWEtlUm9qN3Q5RmJGTTZ5QnFyU3FYMTBnaGFYTWNXeU9PS083SGR3aXJC?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b669062f-1255-4888-c49e-08dac1c8c41d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 20:35:25.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwTT5P0Smf8w4mHtgBRTLtErThkyYqaNwOIMyo9g0BO5/muIhp6ptacr2qGkRVm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2724
X-Proofpoint-GUID: SWBRWiyL5QYeVBuJa7w6O-6OVDvHRgfU
X-Proofpoint-ORIG-GUID: SWBRWiyL5QYeVBuJa7w6O-6OVDvHRgfU
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
> If a page fault occurs while copying the first byte, this function resets one
> byte before dst.
> As a consequence, an address could be modified and leaded to kernel crashes if
> case the modified address was accessed later.
> 
> Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
> Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>   mm/maccess.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 5f4d240f67ec..074f6b086671 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -97,7 +97,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
>   	return src - unsafe_addr;
>   Efault:
>   	pagefault_enable();
> -	dst[-1] = '\0';
> +	dst[0] = '\0';

What if the fault is due to dst, so the above won't work, right?

The original code should work fine if the first byte copy is successful.
For the first byte copy fault, maybe just to leave it as is?

>   	return -EFAULT;
>   }
> 
> --
> 2.25.1
> 
