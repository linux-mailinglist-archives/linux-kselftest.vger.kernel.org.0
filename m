Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1E62795E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiKNJr2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 04:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiKNJrZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 04:47:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8A19C3C;
        Mon, 14 Nov 2022 01:47:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE8g7Jp025676;
        Mon, 14 Nov 2022 09:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F1zDETyuNtfyPDklupL/t+SahmqvPeLwlWGnau78gwc=;
 b=Sx7vaj9OsaULxBJQQo2LxWtkYXVit04IAUdQUjXqtsJDSHyfx5qXDK7UU4MzcxwRr23w
 ipSLu5Qob1F1CrnZaA1XlG67uIsdPSjHteegRwkQLpBch6umJz5xaNyO6f1x6uKIzMpk
 jfN6i/+wXGVoOJcho4fvbXSj/kmLOTVemzkela6yNdvVj0Q+foblTxDfYnVZgUq547Wz
 2nFctcWAduTQnysO0qqvElyZAgYAaoVd0quZ6dPYQcmlIWTfx+E1+4WUkMhI6AT/PYfX
 FuRi+EfQHrMzTQakyxEAajM+WKNRMjLQLH9PaekIVb3wK/cxoAWQqOlLPKlnwdkwsvy5 Hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1gjhch9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 09:47:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AE9E8MX037961;
        Mon, 14 Nov 2022 09:47:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x3vycc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 09:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQpFvifuwRpmPTSsSDM1pEuzCa+B86xuhkRBUTROSjLnWvBG0EzpJS5vA3+YOeZ9bZfrRzlSPPr97+8i3xsjmATKn9a+FA4lkBNq96opyxpO2ip4uhwikPcb+eZcZTbgiP5JNlqW0tIkABtYTp+sWf/0eQDrvzhjc1QMJTGl/cdYImNEfGbURbEnb5GhmsqrI/fD9AT+UyqevkE/Y8zcG0ohiu0xU1nYiuKANCSfF38MLL5gM9IgWZNqbc80lGnyVGeCiviVMwCtJ7KwS0dAE+m4Nhl5Lft2fLFmxdXpXZl0aJwzUjMzMTM0uACzp2r0IrrslPbpnA4WPpnXXj1gkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1zDETyuNtfyPDklupL/t+SahmqvPeLwlWGnau78gwc=;
 b=H6b/HBLspHArT/DERBt9OtrXSrrZIirGq3/0ZiRNx3gSuswAEkqpSS9nMaBV3ewS/F3uH1lVQwgrX833wbRcxKuW58RS8IrF3FuALQxsrF48TlsWQYYvyCSZHHEEIFHVPqIABwh5UGu7CEdk84n5CODkhKd604YqOjkVz2w00TO1jdff57/+8qURhq6wPEmpXyViqrhPxgfwtpsTcKzRrQOvip2I/5//gyebz3lM3olQF0k7ULbUKC0DkwF2H8tGL4guhHkYArvlrnk5xZZYEGGHhB1iE5Ubu7ozFa/tMxeepOWeYuYZX/6vt6RU0pAFheUlzPE2DYsH2FCyz8lPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1zDETyuNtfyPDklupL/t+SahmqvPeLwlWGnau78gwc=;
 b=o/Qxcf6yBBXx7fxaj1ZzEvUSni8mVQLDIA1jobs45tHKN7wC/sWYnLL79Cbt5RoP7itWaBKjNMVzEYfm9MDtA4jSR7OVLdMFuZuQIuSdIfYBV6dgayo8l4nN2Q0zlvfmiYrsIfRJRCnPPMhCL5b0fKZS+oo78vNZOahLug+BWKc=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 BY5PR10MB4193.namprd10.prod.outlook.com (2603:10b6:a03:202::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 09:47:00 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b9f5:77e4:456c:9e08]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b9f5:77e4:456c:9e08%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 09:47:00 +0000
Message-ID: <96eeeb5e-9fe9-ebf6-cc91-d49c86ec615d@oracle.com>
Date:   Mon, 14 Nov 2022 15:16:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] kselftest/cgroup: Fix gathering number of CPUs
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        cgroups@vger.kernel.org
Cc:     leit@meta.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221113114449.18693-1-leitao@debian.org>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20221113114449.18693-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::17) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|BY5PR10MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ae4d49-9e5c-4ae3-7ccc-08dac6252d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ppC537cSrBANXCZc+8nSq3B4UO/XBT4ADcsTJLy1+6DljDZ57AIKGrcggnn8jeAt2ZmAzJS13qZoH4lv0KgF5959xsIOSQw7r9wUxJOHywitE+4rRaef3FJnJgVCCUPwVZGXiQL5xQY6eBgssRKQITw9lUlfZAU98pBz0m77t4MWnIu3uJWIfx9Pa87U0rVsFmpoo84nEdv7F79Io1QRD5HvQ8KGE3YM0297hX1G2VqwdGDMa6eORr2NpYzFn+LQllB8+3dx40qBKCN2lytjb4Zdj+HfjGEzk7ZlM/f5KyWUaY59z263Q5bwrb/zYGiabW4tU5EYUzjCqFA1I2wPBwLwet3FMKWWl6J6g05O72wdRbZsgDbtPTcIMe7p9pet1yzS/vsLSlJ0cVQlZeCP2RZe9h6verZy/qqwyC/X18q5QAK/tWrOX8TCtwNtQciRTTMTLKIgUzUaOe5Wnryl7C9vC8Ijms6FEpTU4WFr+Oh+68E/30IOV44PqBZP2JtIfdSlDb9m1YLKBl5QNpmJFVjZReuEBbOQi/wpMJAVzS61/raVcmkCDebm5LUat92aPe7kVQkVgEIu1Y+ZyePBVf2BtGDYf4q19Q8/Rig34n9dYXnSZ7OybyAmLRjYolLJuKaMPLSQTFBxl5B3likS+hMFdfU1lPfKclUET74sABlo5OArmFX0sRW8AYV1YY4wUHcwFAAL3/ByJrHN8MCO7Vcl40yJbhm5pIFsKW9YcFP5t3VQxnVfA0Bmn4UXYn3bmZJaU4OcYo7L08CNVRtbYFpV6Ptn8cmbTCNUsZ2sQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(36756003)(53546011)(6506007)(6666004)(38100700002)(2906002)(44832011)(83380400001)(316002)(66476007)(31696002)(66556008)(8676002)(66946007)(4326008)(6512007)(86362001)(41300700001)(186003)(5660300002)(26005)(2616005)(8936002)(31686004)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJMTXlOTkZ5Mi9iVEwvMllqSUJmbi9UWlg5ZW05cnh2Q3Nra3hBS3ZKbS8v?=
 =?utf-8?B?MmVEMmVLSW82eURDeDVHbGswRUs0N2ptc0d4MjViV3JhNVViSGRBYTVEbFla?=
 =?utf-8?B?elhtU3RJY1dXcmNTSncxbUFsL1F4bjlyOFVha1lQR210Wm8rZ1pGYlc1c0l2?=
 =?utf-8?B?WFhJNExTUk5RSzlTOTF5a0gvbm9qTlFNTllhZXRsUVF0V01qeW5CNEpnMjcv?=
 =?utf-8?B?OUJEZW1ES0NvU2Z5SUczVVRlOGVPUlI0VGRYdkhFajFOYlpKVkpvZnlwNHdR?=
 =?utf-8?B?ZkNCM3pPWDBTRm1CMFRwdTFqUmlpM3oyYjF6OFQ4Rm5wZzgzZjVsSXpZNFFL?=
 =?utf-8?B?K0JsOE9MaTMyVHYwOEpvNUh0UU9WcndrRHYvRUJZVG1uWkJzVHFwMkRYNXVX?=
 =?utf-8?B?OTNPNlJHRGp0U2tvWHlDSVE4c2hOL0tNWDlYbFptQVU1M3I1eWJ4NXZjYSt2?=
 =?utf-8?B?Mi9lWmVUR1kzNnRaZWFrSWZxNks4MlVEMzZlaEJrajg3ckJWYktWcldlbndq?=
 =?utf-8?B?Vk02MWo1a05Qamk5NHUzMHN2VFkzMmhGUUUxUldwcTREZG1rMEUvUkFNMlJI?=
 =?utf-8?B?dEJNRzFqSjVYaUdxRkkxZDJiMWZRY1g4a0pXUlhndE1VbDdvSzh2UWRPU1BT?=
 =?utf-8?B?NWZOUUp5WXYzOVV4V1BvczdEaDgycmo5a2ZJRDNLVHA1Z3BaanNoWGI2aXVu?=
 =?utf-8?B?NnE4RTdhRW5KcTJGTEl3NjBTK0xUb2J5RC9Tc2wvbDFxRUxjYkNTbUN2enJl?=
 =?utf-8?B?cHVIRkY3MC84NFNZR3BFNUtVaEgwMnRRWVFsNW90Z1Z0Q0VXcjBGRDRyazdG?=
 =?utf-8?B?ZllKS3V2ay94WVd3KzJWWUczdE11NEY3bi9DZW5ZQ3VTcG9zS0JQSUl6ZHlS?=
 =?utf-8?B?Y3FtU3BqSkl3WkE5N3owV241ZWtwSENNdURpQ0lUeGFxWjFaS2ZzTVRVL2Nh?=
 =?utf-8?B?aC80Zmt6T0JsbzZXUGxYUDY3bG5oRHdZSEdrY0RlSzk4MER4cjJnQ3UyQWpz?=
 =?utf-8?B?b3B6LzhlR242N08rcHFZV2UxMktoUVF6SG0zRTNhVSsrTjllRW44UEdJK2hq?=
 =?utf-8?B?R1B6VlBTSEE2OVlkWk1QSDlOMlg3cVdsbjhqeTJYbTBrdFFDTDJmQWJJUGth?=
 =?utf-8?B?YWJpendrN3BVY0d1Qi9GYUhrTkxVZGxpSU96QmNzcUxIN2Z6SzJZeEpaWDh4?=
 =?utf-8?B?aytrK3NJSEFlTmFIUVRsUTJSbXUrdEMrQWFNemI2UXJ1MHpZU1JNZTM2K0k5?=
 =?utf-8?B?R1JNZEtKTlZ6em1HOTBnZU9tS0lTdHNzZXhGeGM5cytBTTJBb01HOWdUem91?=
 =?utf-8?B?U21uZ2FpeUNIa0JZWlEwRUc5VXI2NnpPdUlMK0dCaTl6bUZGcHFWMkZVbmly?=
 =?utf-8?B?dzlUQXpTMTYzdk1XU25LdGRtU0dSVHNORFR4VXJaRmgzZ01RdkhZZ0xialkw?=
 =?utf-8?B?TnRjaHY4bjFZMEI2UDdDWlJnbVV5R2dtV3AyT2MzaTE4dEFrMlZQbnV0d2do?=
 =?utf-8?B?VTdZbXZhbFNKenNiV25LaEFqSDR2UkJTMUNMM2hKQy9jYjBwNWJEREVYUjF1?=
 =?utf-8?B?ODl0U3VldEI5OVVXbnBQMU9kMWtBaG5zbThQSlkvYmFOZnBQOGFGSGxsbDVr?=
 =?utf-8?B?b2pOUUFGM3I2SU03Wk1TVDA3cTAzSFpiVnNQbExmNDFJOFp0NlFocWFkRkpP?=
 =?utf-8?B?NXJZdVJrTnNCVnJSaVhWNFZVTUtyV2RLUGVzUHhyUnl3dGs0NCtnZzErSm96?=
 =?utf-8?B?N2NyU2pXUWhUbUVrUFhuVUpEVkI0WnJWNW1Bd2ZFS3puWWRQYWYyUkRUUVVN?=
 =?utf-8?B?TUo5cE1QSndDYzZXdWJtcnhYSFkwcE5TS0RBWENzbVlZeDQ3aFBLNUJzY2Ni?=
 =?utf-8?B?V1FvczFPa08zUVFzazljenh3cWpna0NGdnJ4U0t1cE5CUkhsOWNONXNDci9B?=
 =?utf-8?B?Vm5GdSt6d0JxMTNmTndJNlk2TDdCQXV3aXV1b3Fka29zMFMzclFFRktncnZE?=
 =?utf-8?B?ZnlhYW1BeDBrZXdGYWdtTkZOYll6TmZyUmxLUU5QQ3kxYXVQL1ZSVUdBUHla?=
 =?utf-8?B?MUY4WVNRZy8xVnN3NldaeE9UWTJrRkRFOGZGNHRyemNTQTBJU1d5WHBmc0VU?=
 =?utf-8?B?dVU3OUNTaXlPY1haUFdwSHpPNEV0cmw0SGtpVUZlUFF4Q3NpdjhEb0d6Ym5X?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RmIzZ2ErNVJta2FtdURmdGtrM2srdGdwTzRtaTBtaHdjTDA3T2tsVnJWK2ti?=
 =?utf-8?B?WUlBQzNMVXJBMGdKMERlM2F3UGdybDVvQjcvS1UxY2IyQTl5OUdTV1lPQThE?=
 =?utf-8?B?UGtLSitKUVgzL1ZPd29ETWplbkhQZlVkQlBMT1ROckx4Y3dHZGUvS2JhaXFm?=
 =?utf-8?B?VjhqY1BqNkN5cnBvTThWbWZ2V3NNSndweEkrVS9sTW5VWE44TFFVUi9OQVB5?=
 =?utf-8?B?UE5Vd2V5TDhxTHROSk5JZ2NoaHhwQ2JJb0JiUGFSWTZhSTNaeFdDaysvSXM4?=
 =?utf-8?B?ZVJsNXdJbVErd0JvYUl1aWRia1lxdC9GWVlHdVlxUmludUpTbDg5SlEyTk5E?=
 =?utf-8?B?R1VkM2p3a1pWeWN6WXNldFc4ZDJoYUxVclhtMVR5Wk1LSTNBb203emIyblNT?=
 =?utf-8?B?V2hMd0JZT0hhS0VXNlcvaU5rbGFxaEVwQlFUajBZL01Ka29jbm1mYWRscldn?=
 =?utf-8?B?SUx5V2k2MWpJcTFReUFmOEZKanZsbGpHRExubk1hL3dmT1RkSkVidk05dkhP?=
 =?utf-8?B?cVEyRWltRUcxRkZidVRjSFMzVEZpb2paWDV5VmF2MytvSjF2c2ZHUTlkRVlG?=
 =?utf-8?B?M2loRGNrRVpseWZENTNDRDFQeXJ0NE9kM0ZxNU00YTIxRDVOYzUrNDc2dVM2?=
 =?utf-8?B?QU8rR05XZzU3WURERGRvNkR2cVZyQUlhdHR0VlpkUlMvMnNqUENDR0RneUZG?=
 =?utf-8?B?SmRnTW5FT1E0UlQ2RXVpQ3dOeXlhdVVPR2ZQdnZOUWFNVkFsQm80VHBNMEN2?=
 =?utf-8?B?a2dScjBYT3BDbkxaVkZYWVoxQ3VRRXZWZnJRTnFwRWgyejdIRy9PTjl6Um9W?=
 =?utf-8?B?TENwenhrZXVZaHZnWTRRYndDV2NXclVmMEJKQzJVVzlKMEdjVnowQUlSYkE4?=
 =?utf-8?B?MWZHKzVuWjFsRk1wa3huckhqU1c1emJlNTU0TWxNamZvNDU5U1ByYjcvL2xR?=
 =?utf-8?B?ZlA4cnhtOVRMM0RoY3N1K1RwM0tVcmZKZWxGb3Ura2hwM0F1c1Q2QUlzQmxo?=
 =?utf-8?B?aEVybVE4Wk0xaStmMkhKOXRqcTR2ckJDeTA3T0lxTitCVlRZY0dWMytlMnhP?=
 =?utf-8?B?VHZoN1pKYklxL2dlSTZxcyt4aWgvcHdDL3U3dFhPZklnZzV0d2dwZWNjckd5?=
 =?utf-8?B?ckRMREpMZXRjK2pHUDBsajl6ZzNzUXFVMERNcUU1ZnFLUEw2MWxEMnF6M2sv?=
 =?utf-8?B?OHBteTkxZm5rMkpOK292aW9FYkdtNElWZUdvVTlCZnRITzRzRTRvVU1RZUZ5?=
 =?utf-8?B?VFgxY2RLRVRxVDBZY3hHa1J3VzBvQ29SS3ZYMDh2WDRSeWhLWXhWZmxtQ3l6?=
 =?utf-8?B?U3Z0cW9HN0JqSnNpZkkvMUl1V1NTTkQ1OHQ0MVdvTG9JSmZVQXBscFFsazQ3?=
 =?utf-8?B?MGUxdEQ4aWdLK1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ae4d49-9e5c-4ae3-7ccc-08dac6252d01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 09:47:00.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN5+LvsDtPC7wPO833Ncb9Q2XrMVzRIP+uEhS734Lkmirmcy+kMFg6DP5dPqQOmbh0DWnozmN0hwTO9oPI9CgzmHrc3sqMkGKUXe+69PrpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_07,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140072
X-Proofpoint-ORIG-GUID: -0VxrU6kdAPQywM238bOOgWi_qn3KX3B
X-Proofpoint-GUID: -0VxrU6kdAPQywM238bOOgWi_qn3KX3B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/13/22 17:14, Breno Leitao wrote:
> test_cpuset_prs.sh is failing with the following error:
> 
> 	test_cpuset_prs.sh: line 29: [[: 8
> 	57%: syntax error in expression (error token is "57%")
> 
> This is happening because `lscpu | grep "^CPU(s)"` returns two lines in
> some systems (such as Debian unstable):
> 
> 	# lscpu | grep "^CPU(s)"
> 	CPU(s):                          8
> 	CPU(s) scaling MHz:              55%
> 
> This is a simple fix that discard the second line.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Tested with util-linux v2.38

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

> ---
>  tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 526d2c42d870..564ca8c33035 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -25,7 +25,7 @@ WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
>  CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
>  [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
>  
> -CPUS=$(lscpu | grep "^CPU(s)" | sed -e "s/.*:[[:space:]]*//")
> +CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
>  [[ $CPUS -lt 8 ]] && skip_test "Test needs at least 8 cpus available!"
>  
>  # Set verbose flag and delay factor

-- 
Thanks,
Kamalesh
