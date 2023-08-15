Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70C277CF3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjHOPfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbjHOPep (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:34:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA11BD0;
        Tue, 15 Aug 2023 08:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmmPdlKvku2FcrK7wnYPoTf+SYUOqwMtbYS3LQHoGogFg6ktSJeqKqrTS1rnep+gkR9efvZ+Dre246E32+LkM9sjX7U57Yw+2+JxT8tS/nuSbx8sPFaAB5NhJZ/yrS5UTJNVs0XK8LXEfq1ct4VoY/dCFC1j9eG3xkzAaquL0ryQajOrIjJcQrBXEmyK2imu7zEi+y8WFDb0zyY+pIMjJPaXLS19QS/JxD7Wz5kbmbga1XtECV/fpf23dUYVWvuRCop2zQNYkhrKpRu17iJiiRAKx4Txd+fMdvdFmSqCTUvaBV5Oqh7KnXe+H2Ng+u3dYzVQBBdKVvfM6r5ZObTm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPehk5SPPbTq8vf9WNJ8Ko+9c5SUM5NfiKWR/KbxpJU=;
 b=KC8czhlAaeAmJcHXEY34JYZhGRY16GcLrqHs7Bd3pVYW24okf0KSg4QaN7VBgzkDxnXXQEdWEef8s2v+acFNQgkx/vKsoqWgaGxkoi5ptoCCuJmv38DlpZyceFZL2HmNbBAIer7ZEUTg5nYu0bzE5JzZL8xVdLNPsej0tpEeJp9Xx+QVWOOr6eL361NwAykPDbE7CXab/vSutBUM6lqBOg9sHuYYK6EvVDnIQ++J/noewbWv3Zikpj5JIWfDE8Atpg5N5MW1eJ6GtWpKuOAsF8dNAujaFpCtYglGkXlroEDGnIinoXeYzkxx7I1UKjnk0fLNQ3CLdqWz6KLVnrTp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPehk5SPPbTq8vf9WNJ8Ko+9c5SUM5NfiKWR/KbxpJU=;
 b=VPi12LTTjWVO2YswzjTW/XTsyFBtBw6ZfwQerP/eKdNUer3B8ypVpN7oJttuwqIxe+7Q49ESWwW7tUXE/UDsclZNx649Onv6Dk9yshPueKdHAd3qbUk0NNYbOOrAeAVOwo6Rn+nOwdyVNhxgemTnFYCC7dZjJ77jIfXWsEUcCN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:34:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:34:10 +0000
Message-ID: <ed19e1d4-02c7-484d-9620-eedb1393d779@amd.com>
Date:   Tue, 15 Aug 2023 10:34:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/7] Documentation: amd-pstate: introduce AMD Pstate
 Preferred Core
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230815061546.3556083-1-li.meng@amd.com>
 <20230815061546.3556083-7-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230815061546.3556083-7-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddd0168-620a-4804-05b9-08db9da5122a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2sNOBsGsVHXRbdcrPdoEulOj1eY9hNKupaDwYCkWYAUOk5KbGgE/LKhdMhO1OmzL5z9JxXYlc2zXA4lcdUciL2OCY7nv9d4QG0nsvjBycwKQMogkQW1J7pqri2JTG2cG2mCXr72JljmlSasQXgDTrxblSNrFilOzXEmb1SyJxF4pZspT3BWIHZEmheo5HJj3PAzYGACuYpoAfsV/Ih9sqmRb5TRMxmdrlEHEo9o6AfDUUkKco1I10u3+qczDd4R6AcwSnehP5IkiIS7EWLQjeaa2guqQqAgkjeii6abDVlxmw1lU7TqQ4KeF79iXwMjog0uBLsCdHmHPlDYfhUmKP0jzzv9DD8izj23aMh2STa0KXjnw69pbNmCOUxy7bMNh0wfqfimsoE8x+ttqoTy+Y0hlbAVG539fN8jRYos6Keq+dzHRVI0oL1gR9jBd3hg1LFf2medSHlmzxXerMfnvbdmdERMKgqlIAwniKycAbwilwQ1buRdv3jqfBr8UScDaIgOIkOUp1s2CxUChOYE5jMrqBnBKlwTrwP9VCw1sMFmrB6wRnXRupflCFQSR+0r5x+u4GI22jiZMImbOqvX7p3JXhf6VzS7MmNXHuxnwkBLHzB84CG2dVoUGGimqWzbIWWSigYW6TnmxJiTLMVk4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(6512007)(26005)(110136005)(66556008)(2616005)(31686004)(66476007)(66946007)(4326008)(6636002)(316002)(54906003)(41300700001)(8936002)(86362001)(8676002)(83380400001)(31696002)(2906002)(36756003)(44832011)(5660300002)(6486002)(6666004)(38100700002)(478600001)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWVpb1lIUmtWd1g5VFR5ak9ZbUxUdUxXTmtkaHhnQmtKc0hsSmJzbjNidEMy?=
 =?utf-8?B?WTZhQ0dTWGdlV2p0bEdnYy9kZkRxditJMnZCVVJud1ozUE5KNHZBcGFCUzJS?=
 =?utf-8?B?c05lTytXZUs3K0pSNlByZ3A5SGFuajlDZ0c2TlNTQkJnQVI5WldVTWNuWlpP?=
 =?utf-8?B?NjRPWSsxU2MxKy94VHNVdC80YXJLeFRuK0tuU2s0ZUJrV2dFZ3c0dUwzdUNB?=
 =?utf-8?B?RzZXcTVaSXU0cENwN0tPdDAybWdScGgraGRhbUovWjB6V3crbXdUUXlDcXNS?=
 =?utf-8?B?S00xV2p3NXIrVmE0b25NWnJTay9heXBBdGc3cnB1bWo4c3dQUkNrUFlCckdS?=
 =?utf-8?B?T3AzeTRUZ2JyeUVNdjZDYms4Nm95RFpMeGNuZk5CZThvaFNwV0U2TXNxOUxl?=
 =?utf-8?B?SmdqS0Y3cXJPa1VrNVBFYmRqVlRvNXRTSWJkN3lZZ292b0hYdlkvRGVIVWtI?=
 =?utf-8?B?cnNrSU5LcllNdUlQaDlRb1RtQlU2bHcwSHVmK1VBV2pQZmRtcXp3SzhOK3hF?=
 =?utf-8?B?SkM4eWFxRnRYRjNRa0FLYk1hTkt6R3VWamJjWnFCS2h0SWRxenVQOG92ZDRs?=
 =?utf-8?B?Mk1KVUlBTFlwM1dRSTJ4eE9UZUY2WFhMV0dVU0RoWU1abFRxMDh2RWZhMlBY?=
 =?utf-8?B?S2gyMjRnVldPRHBYNElmZUU2U0pWN25iYms0aXd5S3drVFUzeXRRSXllL0M4?=
 =?utf-8?B?ZzVoU3cvQ1BhT2paQlA5R0V1azU5Tmw3blpqeXJOR3IveC84d0tkMm1OQmxU?=
 =?utf-8?B?SkZyNnZET0FscXJFK1BsQ1A3dlkrSVZsUUhaSXE0NitRN0dwTnRZNk84UHJV?=
 =?utf-8?B?YlRTUkcvWjg1eVpBTWEyUlg2NEFRb01lUnFDOWJacFdVb0JoWklnVlZhUmdK?=
 =?utf-8?B?MXlNU1QvdWQ5NjE0L2lqYUd1ekt5dm03SWUrRW1ZRjZOQkErd1lWazFoZE1D?=
 =?utf-8?B?UEh0VElTWnVITjZSOTRBbmluUG1NSkhWR2hPQjVseWM5S3NtWVM3QVNGUzVn?=
 =?utf-8?B?ZWMrZ0QvbFR3a1VKc0VLZ05BMExDRWJsSUhCdEJFTzM5SmxUTmVrTWk4bjFq?=
 =?utf-8?B?bEJ4dTd6Y3F3ZGJQb2ZNT0NXcGIwYXVxNlVIM2IxTjZwcVVTdk5iRW8rTnBj?=
 =?utf-8?B?NHVsQUJsRTlqNjI1SUhxVC9GS1kzYnM4ZkE1VFBQWVJQdHB4d250YkFTTWJM?=
 =?utf-8?B?c3Zlck52bWRPTlN4S1lmUWhWTXhsSXc5YWswMFhEVUVQV3NocklCNnJuMXU3?=
 =?utf-8?B?Nm53MUFDQVNjYWhhUWhEdFpXakVIVnp1L2xPV1kyWUt4SGlyaWl4T3lMTUtk?=
 =?utf-8?B?RG9DaFlIMDZublFCQTRBRy9GRFFWVTBYcXQ1MG1yNUw2OEphaC8xdFBlM3Za?=
 =?utf-8?B?YlpSRDJTeGVody9rUkZYM1NUSlo4aVh4YlQ4RDZCQWhIMEpZUkw2NjVqcElE?=
 =?utf-8?B?R2kxNW5iK1R5cDZMb3o5YUorcEw0QUs4dHJXTkpGdVVPRVp2ZFU3WFRDdFRM?=
 =?utf-8?B?OWFjSWk4WmxRa0lNVnB5QVRJd3pEbmtyN0tGRUxVRFd1QWJkcFBJN1RQNy81?=
 =?utf-8?B?V0Z1TFllVFJ4d2tLNXJTUjdzV0tpUzliTVZPclFFK01ZTWdCZmZVdDl0MFg2?=
 =?utf-8?B?TmpuUmJLWGNYMVJqZDZTa0t0eVpSYzFRYmd0d3FvRE1sd2NWMkdXMWM3Z0Zy?=
 =?utf-8?B?amJlQjZQL3NKRXp2SWs1TFIxaTd0KzhLOTI3ZEtkZ2F4aWZFMXRiMzdYc1Rp?=
 =?utf-8?B?SGxQZzNNS0pmMDFkQnBmR1BXQlNZUm5TOUJaZkI2ckxnVzJvNkY1Rlg0TjlG?=
 =?utf-8?B?VzFPckdtU0N0cnhIeVNXZE0wYlhhdmFXcldVdXVvYWRLRzJuTE0rSXp4bzNl?=
 =?utf-8?B?WXlmdnh6L1Y2SWVlVUJRNXBYNG1nT1YxS0Iva09acHlCMStrNzltWUxIY3o1?=
 =?utf-8?B?LytsczdwbUxCUlA4SGxtZW5VSGc4RHVWbTdEZ3V3bDRJYm1CNHA3SXJsMXFX?=
 =?utf-8?B?OUk0T1lkRndnVGd6MURkNGRmU0N4RzlRcmtCd0Q4YzlSOTdxUDBjYTlNbmxB?=
 =?utf-8?B?VVA0Lzh3KzRsQ25ZYUZ3MTEyTWNkYkU1T0I3OWs1cnZTbDl4UjZaSUdMVFd6?=
 =?utf-8?Q?O67wxOHrFigHzG1DUb1B1y/lN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddd0168-620a-4804-05b9-08db9da5122a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:34:10.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyeHDcelfBhO+MgN/8s6yYH60Hl728/2o7+FB6oPfNRwp/fTPW8/7XtDgLpkI51ijsm860UPOBNtXqKTXGBJ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/2023 01:15, Meng Li wrote:
> Introduce AMD Pstate Preferred Core.
> 
> check preferred core state:
> $ cat /sys/devices/system/cpu/amd-pstate/prefcore_state
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 54 +++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..ef2b69935311 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
>   level and the platform autonomously selects a performance level in this range
>   and appropriate to the current workload.
>   
> +AMD Pstate Preferred Core
> +=================================
> +
> +The core frequency is subjected to the process variation in semiconductors.
> +Not all cores are able to reach the maximum frequency respecting the
> +infrastructure limits. Consequently, AMD has redefined the concept of
> +maximum frequency of a part. This means that a fraction of cores can reach
> +maximum frequency. To find the best process scheduling policy for a given
> +scenario, OS needs to know the core ordering informed by the platform through
> +highest performance capability register of the CPPC interface.
> +
> +``AMD Pstate Preferred Core`` enable the scheduler to favor scheduling on cores
> +can be get a higher frequency with lower voltage under preferred core.
> +And it has the ability to dynamically change the preferred core based on the
> +workload and platform conditions and accounting for thermals and aging.
> +
> +The priority metric will be initialized by the AMD Pstate driver. The AMD Pstate
> +driver will also determine whether or not ``AMD Pstate Preferred Core`` is
> +supported by the platform.
> +
> +AMD Pstate driver will provide an initial core ordering when the system boots.
> +The platform uses the CPPC interfaces to communicate the core ranking to the
> +operating system and scheduler to make sure that OS is choosing the cores
> +with highest performance firstly for scheduling the process. When AMD Pstate
> +driver receives a message with the highest performance change, it will
> +update the core ranking and set the cpu's priority.
> +
> +AMD Preferred Core Switch
> +=================================
> +Kernel Parameters
> +-----------------
> +
> +``AMD Pstate Preferred Core`` has two states: enable and disable.
> +Enable/disable states can be chosen by different kernel parameters.
> +Default enable ``AMD Pstate Preferred Core``.
> + > +``amd_prefcore=disable``
> +
> +If ``amd_prefcore=disable`` is passed to kernel command line option
> +then disable ``AMD Pstate Preferred Core`` if platform can support
> +the Preferred Core feature.
This all seems needlessly wordy.  Here's my suggestion.

"``AMD Pstate preferred core`` will be enabled if the underlying 
platform supports it.  It can be disabled by kernel parameter:

``amd_prefcore=disable``

> +
>   User Space Interface in ``sysfs`` - General
>   ===========================================
>   
> @@ -385,6 +427,18 @@ control its functionality at the system level.  They are located in the
>           to the operation mode represented by that string - or to be
>           unregistered in the "disable" case.
>   
> +``prefcore``
> +	Preferred Core state of the driver: "enabled" or "disabled".
> +
> +	"enabled"
> +		Enable the AMD Preferred Core.
> +
> +	"disabled"
> +		Disable the AMD Preferred Core
> +
> +
> +        This attribute is read-only to check the state of Preferred Core.
> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   

