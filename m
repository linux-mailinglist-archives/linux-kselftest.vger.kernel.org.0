Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BB7C6D94
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjJLMFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjJLMFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 08:05:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F66B7;
        Thu, 12 Oct 2023 05:05:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C92KQk023342;
        Thu, 12 Oct 2023 12:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=P0SruXYuZ4fEJEsgDPpc2f+UJe8To1pY+wkzUkXt4LI=;
 b=PoZlMThnBPFX+PSYeb6Pt8iFq4xeMtMIfSDI8I0C0+z2wsaSF4hDPq1LEhlAqr/BoMKY
 BswJxbAA54zX03L8HdgxHsc28+KjplepRikh6WFdE5SfCuHN3XOLZzrVg48nQ2EiQSxG
 Neg5aOD7Kyz7KwK5irw+6rSZfVIosJE5EZKBPiAu+cxESlgGlPSjcoU0d2UxT1DkbSOe
 cZbIc7MfpmBjaAGTRWv6q0fA1PbDmolPCnKz790GwUS3MLaTtCLiV+Tca25mMP5y2avn
 /wezupiXDcLZQXcEJo90Gdv6E2ZeoGpojnJL/qsXeetUrRS13HvNjcn1lG+2VjAZUkyf BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxuakax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 12:05:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBigEg013637;
        Thu, 12 Oct 2023 12:05:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhtb69j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 12:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLcdJtDqyxhV4w0KHAJVHOOgTaChiL2xknadKjzcVJs8mKwJkE/7yQ/ylsPvAKxn5nlU01UiKK8tmZGagEnTumESe86rqz3jNlCGfAzccYV8ZkFlnPkCXRJB3KfZPGKlENb2yafUZwzaUbKL+SaYZMomGWQA0Qi3I68eD0vaA0prHmxkGFLMYLRHm75cTJTJLJAinkWNLAoMz1qo7LJkzP6bwnue4dzObk8GXnpWC02O/0sR64T5ArqRSxTunZbfMEgPIb+mVwhvFPlZhyuqsRFw97ty7xlihibIiukmWgPzHT+oCt5rEZ9moVL50GugQe+d2EjKeyFMIY8sPeU0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0SruXYuZ4fEJEsgDPpc2f+UJe8To1pY+wkzUkXt4LI=;
 b=BYhLDkjmG+dAylIHePQr6nYcroXpJ3oaJjaMzZJFUuGo0ifOPYJ4YYN4eC4FF/ilKMX7SgV/AiA3tzkT6oQaYZu4Z729HKAKajPUm84Q7tEYxbfMhXpJz+1xQM/e8mnVsE7lNMSElN6jD5STa40y44wU8bzvRoihH1X+CarCcpB8/oJ+nebb6hUcPAJvxGQqb9+VrQB7Tz3enzd6qYriXgjjTWy8vE8COVdvNTC3LVmIfRueXK+CPMqXYYndZh0GFxKwXid9LQRYW3NcKUYkImFHVr4H0K6KjjFkusTVozDy8X/DmUqsE11h3pdxcKSJlGJ+eLBZFVoYtFDuPaovWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0SruXYuZ4fEJEsgDPpc2f+UJe8To1pY+wkzUkXt4LI=;
 b=Yg9IbypUi0ynDPaMuJVTIIBU8pIbG/cTdv9YIbiqGWIjaO4ayqqn/HLhCRKxUph1szPhnZ3p5ZYixM6o8eKAPcEaeILv6z+nNLlAFjFDX75lO6Swy0itjnHir7v+bwI0WWOwx+/troPPsVnGysHAgKOw3AtFKZcDHiqcw+rdYuc=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Thu, 12 Oct
 2023 12:05:34 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::b2ff:9828:4632:f1ff]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::b2ff:9828:4632:f1ff%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 12:05:34 +0000
Message-ID: <d5913fe5-c94b-2b30-0d30-1866326e61f9@oracle.com>
Date:   Thu, 12 Oct 2023 05:05:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [External] : Re: [PATCH 1/1] selftests/mm: include mman header to
 access MREMAP_DONTUNMAP identifier
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231012064048.433346-1-samasth.norway.ananda@oracle.com>
 <3be75492-36e7-4ffe-ab0e-ef583b801af1@collabora.com>
From:   samasth.norway.ananda@oracle.com
In-Reply-To: <3be75492-36e7-4ffe-ab0e-ef583b801af1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: dd737b87-7540-4933-13b9-08dbcb1b8a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J794Wq7IvhPCdF2Wj3faDEJJ4nFf1s38ZIEnfo0B0iPpR28CBkvuYR2Q9SpFAouboE9oqK5HIplEq2UNHkVGYmwJRiiWgZfN78AqklZRwhC0tciGl4+ZqHguAjJLkEaQlxpr8P7vD5f7K6SxFYgwzdpl2lwfBXp4ec8HV26+QmkkbK7apLLKmm6q2s/mL/277GeNa6g113ziS20KISu1SmHkJisrV5OawZwXGwKtCdyEKwOnG2dOXrgFKO87Q7BSE7joV5aFmYebZZJOC9Xs5dXl7SiQqxWUmOR9pdMs28B6EBmt5IZ5wq34I1KmBCLWy3Pku/92DWeK3HQOrTe8WaHwBdLzSzsO9y2kWqcDzcMX+u/Uq0ZXifDCakH3xYl3ugr/mmKMSNUCnWzoFjmpwxHbCzNk3glj4jCcjWISf4Jux4bPFqyAnc3p+xG7+v/J9qdNbnNlxlzy87fokvwqpsBhvW6ljUlT4GfGremmOjxVWi0R5q3XMKSrlKN5KhwPkKeKtXlWNYySJ77+ZQq1E0ZASnzskBniau8MaSQQkuGzM1FIOdw3y3pn/URgVZZSoMb2Uqpu/oyD4aY3agqGyl04TMPmYdoVL5aq05RmqtsmS/YML/D1Ou7j1ksk3YM/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(9686003)(478600001)(31696002)(6486002)(86362001)(36756003)(6506007)(53546011)(8676002)(6666004)(8936002)(316002)(4744005)(5660300002)(4326008)(66556008)(66476007)(2906002)(41300700001)(66946007)(38100700002)(26005)(31686004)(2616005)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlXdjFMUzBkbEZsRnBEK0VRTWtKQXNhMXV3dm9pbFRCK1FxeHRwWGtlbmxy?=
 =?utf-8?B?WXVwTGhwRWdEaDdobHpsSDFzVjFpem5uN0VOdEF5MlFPY0JBMS9zUzI2NFVm?=
 =?utf-8?B?UkFWM05icVlaOGxlbitUV3dFd2t5OTdja3JGaGU2dTRneklhWU9sVEQraWNV?=
 =?utf-8?B?bVVPZlU5VEJ5U2tyL0pscGpySkdPWUE3MEZhNzhqQmNFZ3dHcEY1TmlPRTkr?=
 =?utf-8?B?SU14dUdqTWx6YXY3N3k4amJtcFpiSm1XQU1tcmlScHIySEZpN01UNzFJRWpy?=
 =?utf-8?B?QkxxMTJCQk1STGtOWXFYQ1Z5QU42OUR4Vk9oMEdIaUR6N0NyU0VSZ2FydUo4?=
 =?utf-8?B?VWM5NUxPUWVvK3JSN21ZWllZSUlsR1JPY3lYbFRJYjFMNmhJMTFUTTlQRVEw?=
 =?utf-8?B?NHhydnZuRXRQUVJkNzhUNnZoVFpLTG1mb1JzaDNRL0JMdHVOZDAxWm10SG9C?=
 =?utf-8?B?MFFPc0gyOGg0YjlGNlkxa29XNjBla2hjM0kxUC9QalRZcm85Y3lRVXR5cDV0?=
 =?utf-8?B?NWRSWndvc3BNWHVPVzIvbDdMWlFzeG5qM3FpZDQwL1RSdGhRdnQrMGpoTGlI?=
 =?utf-8?B?NEhicGFSdjA4ZVgxeS9oMmcrQ2tNV0toektZM3dPOWd1a005ZnN0VmRiVWJt?=
 =?utf-8?B?b3dQQURTSXZmRVJhZmFBKzNjaUZrMk5CVGZOTUcrVGdrM0lzVGpSYmVRMnNR?=
 =?utf-8?B?RTZHU0ZhWmNEL3krUGc4MFovbTRPN0tsM0E3dzMzY3BzWDhYS0VRNEtSNmtp?=
 =?utf-8?B?dHBlQitDWVI1cGdJRlpRcmh0cldidElmTlk4S0tSbHUrMDRnL21rRGVyZERn?=
 =?utf-8?B?djB3a2J3Q3pnZUVlVzZ2cTdVd0hONnZpL0JGVE1xM2h2S2tLK0tCUm5abStJ?=
 =?utf-8?B?QVpDRGwwbkNoeWZkNVdkNUc2S0xTL09qM1ZtQW55TzFBTnJxUitSVDlXRVox?=
 =?utf-8?B?MkFTMURXWmNndFpkLzFPRnkyTWIyTHg2OFRXbVNmdVZOcUk5dlI3cmRCbDZM?=
 =?utf-8?B?OTMvUmlpL09HaERvN1JUSUVKR0VYS1AvR1Z1d3NuUmJvQmhZbDJ2MitlQ0c0?=
 =?utf-8?B?UWRobGNCOUxvMGsyWTZ4RkxMaUJZbVpOY085bVNMcy9zYVNkb05IQmtvS3NP?=
 =?utf-8?B?N1kxZEtZcW5YeWRxTHdlT3E1R2k4WUxrOFQ5SllZc2FpQ05zMUtwRXNna092?=
 =?utf-8?B?QWxwcHBtWVdGWHdFZGZUNkRPWWxVdFMvcGFKS3Q3MDZqS2VTMk0yWkRuYktT?=
 =?utf-8?B?RU8waUNPQkZkemJJeFU3Wm82VEhjeElVM1lFc0pkb0dEVkJCY2JiLzlTMlo1?=
 =?utf-8?B?THp5Z1dFZ3ZRTG5vODZWdDVEdW9QTWVuV0hubzZXYVZDVGJNaTdZL3Rpemsz?=
 =?utf-8?B?VGVuckxPa2JlMWpUbElyYjdSOVNhaFJZVk1nV3lUNFQ5dkk3eUo4S3hRdTkv?=
 =?utf-8?B?dkg5ZHJoSGY3ZzZVK3ptekFFbVRLOXFNQ093dnViSXZzcnp0SlJJeFhwK256?=
 =?utf-8?B?RlgyaXE2V2hwcUR1Q2ZPaFpOU1R6RDVyRjJXMEhXYVZzUXErRGFvU2tqYk1j?=
 =?utf-8?B?QTRXSDlsREdDMk9oY016NHpGMitrTnp5MHFPRzN1N3hOOStHejg5dVJTajg1?=
 =?utf-8?B?RGhUUlBveHJtQU14aHM2NitMc3lZbXRCTFcwSUIvTFJqVVA5UExHMGlMazhB?=
 =?utf-8?B?VEpmM1VHTkZ0V1lmdzdSRk5zY25Sd2hVeDU4d3pmSit3U3hUMUVhejY2Y1Mx?=
 =?utf-8?B?RFlrMUo4SXJRRDNCZEpyWjB4UHFVUHRiNXMxR3ByLzJwNlhvSEV6ZVIyYWtv?=
 =?utf-8?B?anhyV1FhQ01oOUNvQ1FXYXphbjFMYXdOMGg0RzhGckh5dExISHZNWXZhVGtL?=
 =?utf-8?B?TTZZZGpvQUV5TTNuaVlKUlZUQnBoNVQrQU1VSHlneURUc0tOeW9XZVdya0VZ?=
 =?utf-8?B?ckJwYVBnV1J5UncvNzhXR0xnZGJ3TVlqNlBzUE1lZVRKdmV0dGcrVGhyM1ND?=
 =?utf-8?B?THoxQ09Db0xBbCtVYlJVSnh4UWxGZVQ2WUNuVko0NEVzZUw5OU5kdjJTRXpk?=
 =?utf-8?B?c01zUWp5clBpeHZCdGZiaVdPNUtXUlVMV05rMWFWUityTW1BM1hIVVhHN1A1?=
 =?utf-8?B?UjFsbVlOYlNWN2V0VC9kdldUWTBNaXllUTVIeWxMbDd0OVVSZ21ndmJiTnY1?=
 =?utf-8?Q?YIIicgh8j14NI4h0Lzb41mo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ta0d/nUN8nUxUisABmNyaYd/h3MwkzEQV0NzrRx4i+ZQK+QmhgC9gUi9Oenyuyyj/SQLfk3mOlgzNM3D+qZKvh0uXSM5vjMZbJQG137xWCn+O+nnUvgr2UkW+DTGnZbEovJlOE4YLcdIf81IcEYe9WIVOfeaGlluqQ1Y1dhVWAjXP7Ax3iPLboh7aPR4y9JV4DtXslct60xBpnmizpGHhqsaQMEqPh5xfDnhtc6WsHhLAcdeB9FeUGyR1c8v02bUsG3fMvRvMURXUqTyenCGAZChFFOAWj3mn+w3pnwkEk3HKyIcg28lvsjgZTdSVrBZIWySXN0T0LJqEmb8eHwuBgY7RZQ40wE/MXmXCmYoouE5EamOd/ay+SQ+7CP55YaFFLSluYGa5wx33PmZQxRMZq04b6ymyDQXeOKXcboQ7QgSVTaQnO9UOGbFFvYwnHyoZl9WfDaEr2HXH+5LObrhqdmkZm+TErocBpyV/3Upyv7r5aFcZsGHQe4XfYQ3vvA8rKwP6fC4jUXpblPx1T0jG8gio63zg4MrEUuN8pzYyacy1IQaCACl3cKJdAvK+0hwKXSK85oiSvSRPfGeGJCOkJ8Pjou2P0o81XVKuEpfqUuAaa/+zDClsGScLkTWTSik9HLy1NTtu0yty2QbpdXqdoxYvL/hL9ZwNDaJIHFQMEVEfrp54yGcEsqTQUx7Irt5w8pEQqvyWF6RrTLwegEuK6Wx0dssuuZh/S3f+PFaEWYDsdqT8ubsDpm4qgrHX+2yPekKdXuQI61LzqPC9omrdcItiKA706DZmpHsQKczNFjdsESwWOlYteJjP+QCnxLysJnSake4PvU8W2pyLpAmQ3i0yioMiR+EWxj4MiRaoKi0HxeBtu9hlGszT7mNWjKVJBEFBaUgWYWvPZm/ZWJu6pAoXcl9qfCyhgkanRDBRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd737b87-7540-4933-13b9-08dbcb1b8a14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:05:34.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trCfxYoB0x+vrWGlv4lXysixEXBL8ZKzzqz6r1Qa99Sk1pOGo4ZrgjDoPdf1lx1rSC5csrPU3QeVK+opL6/YtiZOhZtp2xgYwsvliXqWmZW/Ltmx/xODJcc4wq6JKfFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=988 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120099
X-Proofpoint-GUID: LjomTstHoaGmmyteAsK0KKQlU0QCDudN
X-Proofpoint-ORIG-GUID: LjomTstHoaGmmyteAsK0KKQlU0QCDudN
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/12/23 1:06 AM, Muhammad Usama Anjum wrote:

> You have mentioned in other email that MREMAP_DONTUNMAP isn't present in
> glibc older than 2.32. So including linux/mman.h solves the build error for
> people having older glibc. Please add this to the description of the patch
> to give the exact reason this patch should be accepted.
> 

Thanks Usama. I will send out a v2 patch with updated description as you 
suggested.
