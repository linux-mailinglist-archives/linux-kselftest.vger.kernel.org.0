Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C17671A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjG1QPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjG1QP3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:15:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402A4490;
        Fri, 28 Jul 2023 09:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaMc5wEurCL6mtlfS+kbq7lETmQcHEgJye64Vye1tdI9jn8z+qqE5krZxhw72Z1auvfsln9faBs0PbfGuItKymyHmlYd+UWvtBVYoaoPcrMM7VkSvDOeEW8yRJQUTZzzulDJew14DznZIG70nET8OkxVFGJNqjF++vcXDqyg3Vy7hCzvZa6co6YhyXgrA8hFH66oLvsRouePRAY/im5hE3tsTz+KxYunr6/BsBhmxoogzjRAMi0kBkkVeis2PYCiM9VdwoFpftQnD/GKIQQ70yayUqZ/8JrB3X3nfpQdE7RpIgctPxx61CibB9nE5NuY3L32a31J2FSXr7fF7GRBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr+ROKqF/HVLQZ9xNQGqYrZcjS3Mvhu8ahdFrqlR35Q=;
 b=SJv0M5UAtnUUruphwK6gTUziFUqehIU1+8pLncPZH7F5xvJUfuHvJfbnAnmR6MLTsHFdY39HTfRiExVvkz53iUG+zPac1wyH9GQshIXULmFQE6K12NIBcupmYLhA2SX2C1MMS9SPkrTZaQchxaq2zfRGIC8Q8+qN+rJtDq1MsydOKARFaJ8o2ykT+DpXsqHzC3OqHbOPjGk3zXcwl5UHmHfKnzl4WzXy+D/R6lQq5CrVnMEsKUduy4GtXeUJyGJJxwENpsAjMF4WN2jlWHMpvxzlkfWvu1LgbHDWgbgO5Z9oAcztSrH0YGWwvri5EEYHhFx2oRpQ2Id6FV8sRVaxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr+ROKqF/HVLQZ9xNQGqYrZcjS3Mvhu8ahdFrqlR35Q=;
 b=O/Xps3/iYOvVtlON3x7cGtHgNg+5LB4Ic/iBU7ZSUSlP6YKcb3B4kn4VDPulXz73oKuHRZDUMV8KGfg4YLnn2NORx5V+g5qZjWeb5iuHJrQPR6TCYPyZtAIcAX3aUCY/OWc1aH0/DcKm8JLCTHwdessWnuPmpXHvw5m1SVi3Osc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:15:18 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::bc63:b5a8:902:ee0e]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::bc63:b5a8:902:ee0e%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:15:18 +0000
Message-ID: <d1e720a1-d52c-a14b-3389-a2fb830c208e@amd.com>
Date:   Fri, 28 Jul 2023 21:45:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] selftests: mm: ksm: Fix incorrect evaluation of
 parameter
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        shuah@kernel.org, pasha.tatashin@soleen.com,
        zhansayabagdaulet@gmail.com, tyhicks@linux.microsoft.com,
        raghavendra.kodsarathimmappa@amd.com
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Narasimhan.V@amd.com,
        Santosh.Shukla@amd.com
References: <20230728060109.4403-1-ayush.jain3@amd.com>
 <8e4d9fa7-7550-87a9-ead1-2d2a8691cdab@redhat.com>
From:   Ayush Jain <ayush.jain3@amd.com>
In-Reply-To: <8e4d9fa7-7550-87a9-ead1-2d2a8691cdab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ccd3ab-02a2-4e56-6e48-08db8f85d5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHTZoGxLjpjUEMtzsOGlsmj9qvm2Be9SngPYgf1uwk8pqU3MDnu+OxemL3+oV+lchSMvnVYG2lPqioJKoeLUt0hLIC6ELYS9jMfl8VYlPmWQo11wInv2BkOgJ1qravCx/WswVu4+lNJldMWAXT7a9O4WZIMb4Mcvbj/ODqwIKnY1gXv+hRZuKL1tLfSOBpYit0Oj7QKjIa7T6aexjWnMJ6b4PMD5Pxk2nZvHF9bfTPGv62hZgbCOTrDCb/TJPlV3fSrgJvE38FKafiAeabh5Maty4kw6vWqOf8cH0MQjQqDyvlun27+VQRo0060JGb/5KzZ0VGVe/0UDIhN2F0N9ONhVu5btYS98DJVVKfgwEDspNq0cxAZHUPJtfYK01vwKgcMZ3fDFUstLI23xIre03BxAnPMTqbAboNNLQA9P10yyCKkr3lxV4o+kKLei5EXExZxPWzFEzrPfqIe1sBg/snHjJfArDRMJROTM1h0zuKeyAraiuOhNwmZByfKHynG1WwxTEfZRlapUyxkeMrIsNWLhCdKjVWbuJ26XjP3Mndv8Bbr0xdQsYORM/sRsOhBnCZNLWmz3Lk4IPHP+StNrSSc2BZTb1tgVoEbfASJ8Hj2MBIUpENYKRf6iUY4gSXGiaafEe8OHmPRjJPYYHlnbUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(83380400001)(2906002)(2616005)(6666004)(6486002)(53546011)(26005)(86362001)(6512007)(478600001)(38100700002)(5660300002)(41300700001)(31686004)(316002)(186003)(66946007)(66556008)(66476007)(31696002)(6506007)(8936002)(8676002)(36756003)(4326008)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxwSGlHOGwveEZNVE44c2ZlUTJsc0lRRk9yZzZrLzdGd3JqNCtsUU9wQXJv?=
 =?utf-8?B?Qk1kbE5wSlpPN04xdEZGNW1jQ01SRHNEVnBGL0FaVW1oMDJjR3NuQ2JQYXBx?=
 =?utf-8?B?SVRLanVmaG5zRjd4a3YvVGNqZHJKYmRDVWxRUDJ4dG1sclVTckRYWm4xejQ4?=
 =?utf-8?B?WGZ6Ump3aVQ3c3JHMmV3d1hOQUF1SjdDeHBvSHQvaXg1QjhCRklMRWF2UUds?=
 =?utf-8?B?OW1qbS9jdGx4ZnhZSGdBM2F2YlFTelkvU1QyVVk3dGV6cm9sWXcrKzI4OHN1?=
 =?utf-8?B?ZzBmNDF2ZEo2YXpLRVVwOWl4TktNeHordjBxdVFyVXBudThoYzVCV29wVFhJ?=
 =?utf-8?B?TlRROU1QbEsvRVdlWlB6YjZHaE1NTEE0MVZSTkVzNUN5c0l4SDhwM3NaU3E2?=
 =?utf-8?B?S3B2MVpYK3FxY3piSkQ5eVZPSGpUOW9xQXhOVlY1TnZTUXNaOHdEcUV3NVVQ?=
 =?utf-8?B?eUtaRnZST2VGOGRRbHE0eVVaZG1BVk5YQVdrTFFkdVRRcUM3RUswZC9mSW9x?=
 =?utf-8?B?RnFsbFdkb0JnV2hBUTNQc3ovZjIxQ2ZwOENsWWM2VUowVFQ0Y3llTDcvdVFL?=
 =?utf-8?B?NzJRUzFxTldhNFoyekdBYTJac1EybTl4M0xHRWFaVzd1Q280cUM1V3A3QlF0?=
 =?utf-8?B?V2l0RkovN0ZEbnVBRnplOEs2bkJUTU43WTlhY2hqOGowM2JNRjA4Q2FrZGM0?=
 =?utf-8?B?NUo1YXphbm9zTVAwcHc3VW5PaEJDMEtuQnkyZ2VQN2ZmT0Nhd1VRZGRCZi85?=
 =?utf-8?B?YnhxQ3g1TTlHV0d0TmhhNEJROFZFUGttOTJuYUlHMVU2Vk9vZEZpOVMzODNI?=
 =?utf-8?B?eVFJK2lLUmhuZWF5RzZ0R0pmT21zMjlHWjlvcWd6d1lacVRrZTBMcDQvYUJM?=
 =?utf-8?B?aUlFeHd0NkFXZ1ptUHNDaUhjbUFteldZQ0hvK05PVkxYZ25lUzROY1NzR092?=
 =?utf-8?B?Q053ZUp2QjlldmpoV243MXAxOVZnajVVa0tkcEVza1RyblA5Q2dmeitiZmo4?=
 =?utf-8?B?YXVwaUZScHFCTGhqNXBjbXVkUExmUENqWXVHTnNnQjV3Z1M2TEZNYzhwRHhD?=
 =?utf-8?B?TVBsT1RzN2hRR0pJRjQ4d21icnNpYUg3ZTR2N0M4aXNCWTYwMzlKTjlvcnBG?=
 =?utf-8?B?aENkOVhtNVRpWHR1WUM5Kyt6OE90RjFSN1dxcGdaTm1tTnFhUnhxbENnUFB0?=
 =?utf-8?B?cml4QmtwbVlqNlRVTFg5MXNYL0d6aGZTbjhuUnoxWGl0eHRzWjB2UVJYSnRQ?=
 =?utf-8?B?OVVJYzFabVhvYzhQZTRHbjlIeU9RY0VKajlrbzVhYk1oZkphWWxHdWl0ek45?=
 =?utf-8?B?eEFvRjMyRDdndGI5elVrREdNWlowNkpXUCtKTjdUc3VXbUZjZlhIUHhJRW9D?=
 =?utf-8?B?UkMwamlXWERzanBjTWN2ZmNsbmxsZWxJOUE4VisxenV5K0JOVXdsOEFadGxt?=
 =?utf-8?B?eFV1Ry9QSVJwNCt3dmE1YnlXZ1VmdEY4TmxXYjE3dUFGdk9Pb2NUQUJGYVpS?=
 =?utf-8?B?ZnZtRWtBZ3l1cVZ1YzBacnJObmozM1JOaU1GT0VlZGwvT05RRTBuV1lXM1Nr?=
 =?utf-8?B?NGpFSWVJcVIza2lCQlZGWFBJdU5SeGdVYlo2MkNmV2grZmV4aGYxb01kS0Ji?=
 =?utf-8?B?MnBBZ2kvaWdnOTBmR0ZBQWNMVHJUNkpaWmcrVWJSdFhGaFFSWm9GVlVSTUts?=
 =?utf-8?B?OXMxdjBoN1IreGpNNkwzcXRvSEJtcnQyZk5MNER4MzA5RFRqQ1VtVnlzTkpU?=
 =?utf-8?B?c1ovcDQ2bU1pTlBFVEZCNU9tRWR2dmw0a3NPRGE0cFhNbEszU0lydnh6WUh6?=
 =?utf-8?B?a01DY3NJelV3WUNidFA5dFcrZEYxdXhRWkFUM0liSksyMklMQ3JzdHd1Zi9m?=
 =?utf-8?B?dVZaRmlHajcxbkh5VlFuSnAra3FHVm1RWW5ONDBpS2hLWGJ0SFRVN25CSHZ5?=
 =?utf-8?B?MTNjeThIOUEyK1BBU3BFWVhHa09yWHFmOG5Ydi9VUEc5Wjlnc3JvNEFvZWVJ?=
 =?utf-8?B?T2dieVRZKy9OOCtMQ0ZQS2VndStYdjh6WThjYm1kczVkMVh5a011OFRWazFL?=
 =?utf-8?B?cDRaNit3V3hOczRJTWZmVkRXM0NBQnNMSm1GbjlFKzVodGhSV3hCNVZXZWow?=
 =?utf-8?Q?/Kyt+fs/JcYA2RieUMG6jHwtC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ccd3ab-02a2-4e56-6e48-08db8f85d5ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:15:18.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdNQkdl3o2jC47u2PU5w7QwauOLWMkoGZ2QGGGRAdW2xo5XZt5z82r4lMUd9Q9kSGHb3DEKy2Dso6n8ZlXUpsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello David,

On 7/28/2023 8:05 PM, David Hildenbrand wrote:
> On 28.07.23 08:01, Ayush Jain wrote:
>> A missing break in kms_tests leads to kselftest hang when the
>> parameter -s is used.
>> In current code flow because of missing break in -s, -t parses
>> args spilled from -s and as -t accepts only valid values as 0,1
>> so any arg in -s >1 or <0, gets in ksm_test failure
>>
>> This went undetected since, before the addition of option -t,
>> the next case -M would immediately break out of the switch
>> statement but that is no longer the case
>>
>> Add the missing break statement.
>>
>> ----Before----
>> ./ksm_tests -H -s 100
>> Invalid merge type
>>
>> ----After----
>> ./ksm_tests -H -s 100
>> Number of normal pages:    0
>> Number of huge pages:    50
>> Total size:    100 MiB
>> Total time:    0.401732682 s
>> Average speed:  248.922 MiB/s
>>
>> Fixes: 9e7cb94ca218 ("selftests: vm: add KSM merging time test")
> 
> I think this actually fixes 07115fcc15b4 ("selftests/mm: add new selftests for KSM") that added the "t" parsing.
> 

Sure will update in v2.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks,
Ayush Jain
