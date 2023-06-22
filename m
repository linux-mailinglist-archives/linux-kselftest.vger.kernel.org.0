Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5790673962F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 06:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFVEQA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 00:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFVEP7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 00:15:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027F185;
        Wed, 21 Jun 2023 21:15:57 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35LIemOl027199;
        Wed, 21 Jun 2023 21:15:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VfTevuRXPOdSA0qKbynhxpMw1juuH0esvvVVxOetvP4=;
 b=bPwsVtQP81NY7H75icHMB11kYMU9AhWzNUNuUvBy6YvZa9s8GylmtbPUgCBbLrwaE7It
 M5qPEb+deuMSYntouZhympvqCWO1wwCCzlsRinYwdMY2FLqvkyjpp/kzvuLgyUtKuwVu
 nWHj6VBgxRhAzFlq8/bb4vE5jDlyhy4YRLsz8IE8cqOVwdyhVy50ag2NOrX/70nOQNjw
 Cag3gc5ahiKcyCjY4J3KsqZ/uIsweJPb4hegBws069Ix/xDPwhKvNgNADEOXAn70O97s
 kO3V0Rdke3nKbXvEcv8Rzz4e2ABn65Q7D0tGplHC2j7A+O5XJE+VpcTjMRZ5PHXTeTM5 gg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by m0001303.ppops.net (PPS) with ESMTPS id 3rbw26gb1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 21:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2ennmuaB9ER0+3uMY3Lts7pAYNxsvdYXP6K12K9o5IInYMDriTMEHxK5+rkDtnm9pQ1e05ycZK7L49/Wy/Lw1E600dhWsE+7BhdBSfqZVFMoAKHdlL1c9GNddA42wDAGsuKjHeGNko0TBj5FZSde23z8UKGhuoJkKDLYpW4pJjX77If+IcOcStlleaMOBq/M0bA7YfTSRID0Pt2rwgfQxVL81gExVgJjZYuJCXSby7xxmMYUPg37iqBVANfsmoAz9mOykJ8hebpuPXJoLK1/bAZkoFjHxqvaE52yCmsdKt5GwDdltqy2cqPRW30W10/U5libqh+iHSqINB8OL1xRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfTevuRXPOdSA0qKbynhxpMw1juuH0esvvVVxOetvP4=;
 b=F9fk2HUptCDS8Y5zYfFOQCVTzi/elV8xojBt/WnuaLgam0UWuQ0zQOuJpm53fL8qOIKKIDwcGqoKDfUR/LTHoMhlWjdrpDgubGHIKEY4hwLxmmTb7fH+nyH1UU5zFsGRFdcBMHw4dq4XLPku4daRFOiN2013tJcYtz6Orco7UDLzwdc6j57D2JIOc/vbmZb0a9bhaWUKvfv+EEdJG7qFcSNB+hbrQTuVdrgnXru9gQogZTc9RvlfYd2ZIH116MqwgjqMaL5LLaBLdHwbkm8sygmqU3zIq90qsUUP67E2LpXpTgoLGCG0DY+1TLEJqpXlV9G7lr3KeaVk6YRt0Nd57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5489.namprd15.prod.outlook.com (2603:10b6:208:3aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 04:15:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 04:15:36 +0000
Message-ID: <bf4d7953-8c85-2de1-7fdc-0968da1767ab@meta.com>
Date:   Wed, 21 Jun 2023 21:15:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Verify that the cgroup_skb
 filters receive expected packets.
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
 <20230620171409.166001-3-kuifeng@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230620171409.166001-3-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac0eeba-df8b-41c7-a709-08db72d7542e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2piWvzKUG6Isgc7YAd+wBXH5rNJep/V8bn2wW3g/tqK6MTsywjjomHpeQmKig4Q3Xz2wGV/3I043pazOtul2ZwnDZKI/lTsUIfeBoOuw7zNY6oJT47eZ0A8T+Ks6T7WicDlNb5tjB/xh2/v2f1yPt+/0GQf66+8miAKu7ouuvcqLsAr1br0l9cxKVdC065/t8F7sXMEQ1uJ4M+59CGaby0i+u7kqtXglvTeO68nx0vTXGTgooukmoo65M5pRXTWCA2zauiN02jibziJhsdNKoF7mAf3YTq4DHh1x6hO6Ws3OJ40i/YN4IhgA4WxxDzHOSkF5ONwBVvMhZKenHmPDue6kxmjxIeKy4Sv0pA4RJh+ez2BcE8s6L17PMiWHlDmWjK7kkxw86pOqKJjjpmZoSRabRUs5JR6oguwtQeZcztxX/nBv+fDht8Dls6v1cJhw3FhtD6OTYiRcSCXlwntWCVXyQCuIJph0IvZxztcO4lnzjP1Gian+dCXRNf+w58gyoCgaD48LejyfT5GCmvNBYurYmEyoDCwzz+tMypGIcXsMHx775qF+zH1TRdIk9IBFeKAiMAMhCi3RPO2ob0j7SgxFkEu422F+/A69dpSRq4BgTJ4CEs0e7L1VAEWmo0kTMy8PXzUVvuSwrIQDCJWqk27zWoUO1gHaLvwE2o3j84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(6486002)(478600001)(6666004)(36756003)(53546011)(186003)(6506007)(83380400001)(86362001)(31696002)(921005)(6512007)(2616005)(38100700002)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(8936002)(31686004)(8676002)(7416002)(5660300002)(41300700001)(2906002)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDEvU3FPUWg4UHJ5VWJwSDJaQ0VPaHhESDZpZE9CTENTZVlMeWVyc3JUUklq?=
 =?utf-8?B?bWZKY2o4OEhYVEcxNTg3YWlpb2lJMTRDekcxMmorUzcxLzFqZHppZTIzeEo4?=
 =?utf-8?B?eUc0MFRUYlQybDV5WGZiblpOSEhWTTlIOHIzYnE0WEFrVTFhZnQxQnNyZE9X?=
 =?utf-8?B?d0lVRzRwbWJnd0crczF4UkdiMnh6YnQ1Lzlmd21mZEtmaXNaSlJOOEtkMmE3?=
 =?utf-8?B?dUFuMFNpclEybVRmRE56R25tVXZPUWJLU3dqWGVvVFk1eHJpRzVMZ0pyYXg3?=
 =?utf-8?B?YmEraTlJWXgwc0xoN1orNFRDOHc2dmN6dlZQcnZiZzRVT2hncnI5aFpzTUVD?=
 =?utf-8?B?R3g3VHVFZkdmMTNMdUZtNTBTckxDb1E3bzFRUGV3VkY3TmhZSkV2QW9Ia0p1?=
 =?utf-8?B?V3ZrVlhKcDZLZmpuOFhvMmdhNXpTSmpKVmlxZFQyNk5IRlNUaFBNL3E1Wko3?=
 =?utf-8?B?Z1FuSWpBNy9xY05VbVhucjIzRjRITzUyQ2U4cCtLSzdhMDJHOTlhOGNpa1FI?=
 =?utf-8?B?VFVPUkMvd2EwS3N4d2JzS1p1SUh3N3k5Umdsc2FXVmR2RDBMUmJHZFJlRi9a?=
 =?utf-8?B?cmdSM2h3MjJ0d29UM1J6YXY4MndrVG5HVllHajdSdWU1bmFXbk14N1NCOHpF?=
 =?utf-8?B?TTN3b3EwOEFpVmhwOTA3UTd6QUFHbmliOExNRnhVdkhrQjZDcHRJM0V6aWcv?=
 =?utf-8?B?Z0NuRFRNQkF1TitEdUoxWXdBMSsvdzNBaFkrQUgzOUVBY0V4TzRmbUIyRFZh?=
 =?utf-8?B?NVQrdGp5ZVQya3FSN1NuOEVheFM1OWZlc1NWNmRMMzc1cEJqWGlSNFRRY0NZ?=
 =?utf-8?B?NnRXUGV6amtuWXlxc29vYUZmS3FPcnVKd1I2OEZKKzBlZXdXMXFtallKWXk4?=
 =?utf-8?B?Q05mNGtxVHFTRHJ5MWViOWlqYnlEUU81eTNHdGtoUldtM3JTVkNoaW4zRHI3?=
 =?utf-8?B?RkNFRDUwOHVqVHQzM3ZDeG9takZvczVJQVpEcnlLMHdWUkV2YUl1SUsyKzh6?=
 =?utf-8?B?d3VTZXJoelExdWdOL2d6WGFDd3gzVXRqaDdrSnljbWhweDE1K0IxS2xxS3hW?=
 =?utf-8?B?Qk9sT2JGdWdtRXRmZzNrc1pwSDlVRE1FUW1CUFpWTGt1bG1iUi9OL0NvSlZE?=
 =?utf-8?B?VDFKQVdtOU10Y0tUN1pOQnJQOGg5VWJMVkhhQ0dENFYxc05VQytBTUV2VHhL?=
 =?utf-8?B?NVI3dktrOENWdjdhWXRZeldoRHVLczU0OFNpZmFtVnkvdG13Sm54Zi9pdVZn?=
 =?utf-8?B?ZlozSVRFaFFMRlJSVmxFQlFOWFAyM2NEUks3WTdlenl4MmgrZlJBUTBNZ0Z0?=
 =?utf-8?B?bU5vUXVPVURtVVUyWjVJQ3JOcjZoTGJ2bU8xYWxEWWxMVEpSd1Z6ek8wQXZo?=
 =?utf-8?B?UFNwaW5idlMzbkc0amRCYXNwNGtabHdxWDl3SktOODFlelZ6Y0oyKzUyaTV6?=
 =?utf-8?B?THJRdkhwQVIvYmw0ZkFVcittOG9vbDN5U0VaKzJZUXdBZVgrNHdHSWFhWnE1?=
 =?utf-8?B?dVNxYmtCUitHUmxEenBnWi81eWZxUnpvOFpvTEJPZTVudEd4OW8vT0w2NTV6?=
 =?utf-8?B?OHF4RW8wOUZPcVJtSE5sZVB6Z1B1MW9RUUJoa2Zwek1JL0loRzBseFhOS3gr?=
 =?utf-8?B?VFlRbHgvWlFoWDAraU5meVdkb2trM2ZUUC9hcTBIdENPYlhTclVwcE5FeFVO?=
 =?utf-8?B?Y09pYVZuaE1VTXhzT3JHM1ZacUNmZGpZQ3ZNb2JrVVlCVGFYUHR5c2xpNXFR?=
 =?utf-8?B?Y0lmWGdybG5JU05WeFhQcExHQ0htUWJUUVJkNU55Y010aGVUVHNGZHNQaTJL?=
 =?utf-8?B?dUZManorNE43NlhsZk1TdlpQaE5pMlloT0h4Yk1jVEdNcU45VjZJTmM3OFdh?=
 =?utf-8?B?NEFldGJGNkI3TmZxM2RZcDhZK1NzQ1JFQVcvb0NJZDg2QjJEaFpZY3o2VmdS?=
 =?utf-8?B?ZCthc0g4SUVjOGx3Qkp4dDl2ZzV1MHQwWXpDNEp1RzVNREY0dUNSeHFjRGpu?=
 =?utf-8?B?aHhYeVRXOUxNcXgyRTZCOWlsejFONDVCOHVPanluN3VNamZuVnQ0U09nNjN0?=
 =?utf-8?B?T0wzdlgvREovMG1peW9BbU92cXlBc3Bob1pjUUlaQjBZVHlieVdXWmtjNXNs?=
 =?utf-8?B?NEoxdFRIVE5iRkdoQ3M1TzZmY2FKbERGWUYxTi9qQWxzbk5NNWpMMFh1NVMz?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac0eeba-df8b-41c7-a709-08db72d7542e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 04:15:36.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqdcD0WvrFsfKu7pMJ4g91lcQXQp9y7FL97/LGRJLf+9sLPDV9MyFz6rJ6hdwceE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5489
X-Proofpoint-ORIG-GUID: GgY7EHZUVeU2wM9FMvrpBGrdElfHmtPH
X-Proofpoint-GUID: GgY7EHZUVeU2wM9FMvrpBGrdElfHmtPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_01,2023-06-16_01,2023-05-22_02
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
> This test case includes four scenarios:
> 1. Connect to the server from outside the cgroup and close the connection
>     from outside the cgroup.
> 2. Connect to the server from outside the cgroup and close the connection
>     from inside the cgroup.
> 3. Connect to the server from inside the cgroup and close the connection
>     from outside the cgroup.
> 4. Connect to the server from inside the cgroup and close the connection
>     from inside the cgroup.
> 
> The test case is to verify that cgroup_skb/{egress, ingress} filters
> receive expected packets including SYN, SYN/ACK, ACK, FIN, and FIN/ACK.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
>   tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
>   tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
>   .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 399 ++++++++++++++++++
>   .../selftests/bpf/progs/cgroup_tcp_skb.c      | 382 +++++++++++++++++
>   5 files changed, 829 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>   create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
> 
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 9e95b37a7dff..2caee8423ee0 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -277,6 +277,18 @@ int join_cgroup(const char *relative_path)
>   	return join_cgroup_from_top(cgroup_path);
>   }
>   
> +/**
> + * join_root_cgroup() - Join the root cgroup
> + *
> + * This function joins the root cgroup.
> + *
> + * On success, it returns 0, otherwise on failure it returns 1.
> + */
> +int join_root_cgroup(void)
> +{
> +	return join_cgroup_from_top(CGROUP_MOUNT_PATH);
> +}
> +
>   /**
>    * join_parent_cgroup() - Join a cgroup in the parent process workdir
>    * @relative_path: The cgroup path, relative to parent process workdir, to join
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
> index f099a166c94d..5c2cb9c8b546 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.h
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.h
> @@ -22,6 +22,7 @@ void remove_cgroup(const char *relative_path);
>   unsigned long long get_cgroup_id(const char *relative_path);
>   
>   int join_cgroup(const char *relative_path);
> +int join_root_cgroup(void);
>   int join_parent_cgroup(const char *relative_path);
>   
>   int setup_cgroup_environment(void);
> diff --git a/tools/testing/selftests/bpf/cgroup_tcp_skb.h b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
> new file mode 100644
> index 000000000000..1054b3633983
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2023 Facebook */

/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */

> +
> +/* Define states of a socket to tracking messages sending to and from the
> + * socket.
> + *
> + * These states are based on rfc9293 with some modifications to support
> + * tracking of messages sent out from a socket. For example, when a SYN is
> + * received, a new socket is transiting to the SYN_RECV state defined in
> + * rfc9293. But, we put it in SYN_RECV_SENDING_SYN_ACK state and when
> + * SYN-ACK is sent out, it moves to SYN_RECV state. With this modification,
> + * we can track the message sent out from a socket.
> + */
> +
> +#ifndef __CGROUP_TCP_SKB_H__
> +#define __CGROUP_TCP_SKB_H__
> +
> +enum {
> +	INIT,
> +	CLOSED,
> +	SYN_SENT,
> +	SYN_RECV_SENDING_SYN_ACK,
> +	SYN_RECV,
> +	ESTABLISHED,
> +	FIN_WAIT1,
> +	FIN_WAIT2,
> +	CLOSE_WAIT_SENDING_ACK,
> +	CLOSE_WAIT,
> +	CLOSING,
> +	LAST_ACK,
> +	TIME_WAIT_SENDING_ACK,
> +	TIME_WAIT,
> +};
> +
> +#endif /* __CGROUP_TCP_SKB_H__ */
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> new file mode 100644
> index 000000000000..1b78e8ab3f02
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Facebook */
> +#include <test_progs.h>
> +#include <linux/in6.h>
> +#include <sys/socket.h>
> +#include <sched.h>
> +#include <unistd.h>
> +#include "cgroup_helpers.h"
> +#include "testing_helpers.h"
> +#include "cgroup_tcp_skb.skel.h"
> +#include "cgroup_tcp_skb.h"
> +
> +#define CGROUP_TCP_SKB_PATH "/test_cgroup_tcp_skb"
> +
> +static int install_filters(int cgroup_fd,
> +			   struct bpf_link **egress_link,
> +			   struct bpf_link **ingress_link,
> +			   struct bpf_program *egress_prog,
> +			   struct bpf_program *ingress_prog,
> +			   struct cgroup_tcp_skb *skel)
> +{
> +	/* Prepare filters */
> +	skel->bss->g_sock_state = 0;
> +	skel->bss->g_unexpected = 0;
> +	*egress_link =
> +		bpf_program__attach_cgroup(egress_prog,
> +					   cgroup_fd);
> +	if (!ASSERT_NEQ(*egress_link, NULL, "egress_link"))
> +		return -1;

!ASSERT_OK_PTR(...)

> +	*ingress_link =
> +		bpf_program__attach_cgroup(ingress_prog,
> +					   cgroup_fd);
> +	if (!ASSERT_NEQ(*ingress_link, NULL, "ingress_link"))
> +		return -1;

!ASSERT_OK_PTR(...)

> +
> +	return 0;
> +}
> +
> +static void uninstall_filters(struct bpf_link **egress_link,
> +			      struct bpf_link **ingress_link)
> +{
> +	bpf_link__destroy(*egress_link);
> +	*egress_link = NULL;
> +	bpf_link__destroy(*ingress_link);
> +	*ingress_link = NULL;
> +}
> +
[...]
> +
> +static int close_connection(int *closing_fd, int *peer_fd, int *listen_fd,
> +			    struct cgroup_tcp_skb *skel)
> +{
> +	__u32 saved_packet_count = 0;
> +	int err;
> +	int i;
> +
> +	/* Wait for ACKs to be sent */
> +	saved_packet_count = skel->bss->g_packet_count;
> +	usleep(100000);		/* 0.1s */
> +	while (skel->bss->g_packet_count != saved_packet_count) {
> +		saved_packet_count = skel->bss->g_packet_count;
> +		usleep(100000);	/* 0.1s */
> +	}

Should we put a limitation in the number of loop iterations
just in case that something went wrong or too slow?

> +
> +	skel->bss->g_packet_count = 0;
> +	saved_packet_count = 0;
> +
> +	/* Half shutdown to make sure the closing socket having a chance to
> +	 * receive a FIN from the peer.
> +	 */
> +	err = shutdown(*closing_fd, SHUT_WR);
> +	if (!ASSERT_OK(err, "shutdown closing_fd"))
> +		return -1;
> +
> +	/* Wait for FIN and the ACK of the FIN to be observed */
> +	for (i = 0;
> +	     skel->bss->g_packet_count < saved_packet_count + 2 && i < 10;
> +	     i++) {
> +		usleep(100000);	/* 0.1s */
> +	}

'{...}' is not necessary.

> +	if (!ASSERT_GE(skel->bss->g_packet_count, saved_packet_count + 2,
> +		       "packet_count"))
> +		return -1;
> +
> +	saved_packet_count = skel->bss->g_packet_count;
> +
> +	/* Fully shutdown the connection */
> +	err = close(*peer_fd);
> +	if (!ASSERT_OK(err, "close peer_fd"))
> +		return -1;
> +	*peer_fd = -1;
> +
> +	/* Wait for FIN and the ACK of the FIN to be observed */
> +	for (i = 0;
> +	     skel->bss->g_packet_count < saved_packet_count + 2 && i < 10;
> +	     i++) {
> +		usleep(100000);	/* 0.1s */
> +	}

'{...}' is not necessary.

> +	if (!ASSERT_GE(skel->bss->g_packet_count, saved_packet_count + 2,
> +		       "packet_count"))
> +		return -1;
> +
> +	err = close(*closing_fd);
> +	if (!ASSERT_OK(err, "close closing_fd"))
> +		return -1;
> +	*closing_fd = -1;
> +
> +	close(*listen_fd);
> +	*listen_fd = -1;
> +
> +	return 0;
> +}
> +
[...]
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
> new file mode 100644
> index 000000000000..372a1548798c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Facebook */

/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */

> +#include <linux/bpf.h>
> +#include <bpf/bpf_endian.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include <linux/if_ether.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/ipv6.h>
> +#include <linux/tcp.h>
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +
> +#include "cgroup_tcp_skb.h"
[...]
