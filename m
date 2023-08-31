Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42C78F48C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHaV0C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbjHaV0B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:26:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66681B2;
        Thu, 31 Aug 2023 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693517158; x=1725053158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ic3K2lBezYB8Yf8rMlEo4xViT4hcTpxoXE4h74yNVu0=;
  b=E7uV/bKVcV2KVHBVmXuPKRvfMWM096L1ReAAGkF01+kSF49g/sCj3ZK6
   zxWV31hMzoeg2g8CTwiGKhocE3EsE13ld062Owz2zEfp5KVym+0GUVs21
   rXzecx7SpMFTW5405Sk7rqZ7U/5Jxfrf1kOyDJTBwXeqiovyCD5X54vB3
   QyCK3gnVVr81c+UY2kw2/2R6MFNaNrlPjJ4VvoLta+GCTgklEBvQOlxc5
   NHR9U0A9PYVsgsk2CtNWaMqz0GmHs2YNWLAhGm/mYkNq/vmuvh5NWjEWX
   dw6hDD7ObZ82egvqfDL8ejqwmVAYhs2kPEhboFVcSvfYy3HDVr1/DwoK9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378804207"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="378804207"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="768951131"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="768951131"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 14:25:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 14:25:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRV/XwFHv4ta31NbNNPk0aBMe4BHPG5BsvzY8flq+UOKyyV0SkMG6FA2xxX2OWBWWgmFfOh3uN7b7xDdMJ+YuRv3DNBR3oxBkWKowz5T3uOtsaVVnizU1/0ud3jf+mK5uGxaZwQSjh0oEpMBnrWSB3KNqxGYVRX59NGyMEdoSPpAmh5FzXAi6vUsgFkwvcnsC6xXoIQg4IR8jmF6/WzkScx2XksM2Xkfvn1jhkneFcLCqq1CN++QnK1M6QCYe6rQ7itt70KmyFqD3VqCLfVtVpOVI3/3+qYq/zxKXWuELfxO5ymD3jOluc/DSEhGwq1QvlT7+3ZYb94Pw+E+FVnqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoQ0am7o29I60SO+H9LFmTehb5dtsOn+MvAMYncA12M=;
 b=KOs8317J9fqcOYgPt9TESU4bxf+ZYklsEYRrGpA5WlOLocRUukYH+kEusBlRl1PydLAwcV/tYGr+s0lKY11Hf0t2WSpdVMEFJ3ATQNmogJOAq5yjJBtkjrhgPqxbKUG2OJGfsTeOWZOtnb4kbk+ZGk0h7/lxaE70j08LqjaJ1nkGNLH8ElXGkSYNspvqk5gN90DLP2/IAyo1GnsesSW244rlR0mmjQ6YIIeJhegS3EHW2SvInRbma2TDt6kRYEHHY07LpN+k8wGQ8eKGTKmDwTJhiaHvhRhgC7Frgvjkv43Nrmmw5fQaHcJO6yBmLANUBpbfQ22MxwRaIU6OJtSv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 21:25:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 21:25:33 +0000
Message-ID: <df92babf-8d41-55ad-e0ed-dae0d7d2f990@intel.com>
Date:   Thu, 31 Aug 2023 14:25:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/8] selftests/resctrl: Reorder resctrl FS prep code
 and benchmark_cmd init
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
 <20230831110843.26719-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230831110843.26719-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 42be86e7-552a-4df2-e7fa-08dbaa68cf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBvH5HCM7oEMzhVKIkFUiEMQjZxS0wvPQktq3UDtl5C37WUP+xa1H9pW1nSjxefZWBFiqH5lAElEHD3meBOo56rEzbICB14aSSDCra9py1qRkBdDrgcmCyJ5OUEuvuk5Jhr/H4V6B8rCCWoC9QE2SAxWxbTJr3GvhA1fujO68/EyONs0fSF+VCoi4X/OITqDjkVOUiQ3RKLzWQpLsuKAHuBwk0rzd4yhPtuhtTXNmXdpmwakSEaYww06Do0TphxF8yGhsvpVa0QW6hczNXTtoGeKUcZt2qEwxLHdJc/g5Jvc0uLfLekUp59pGh7f0GXy1KraW4r6wSk8AAbXrceIeBUheiWAnh+cTn81WDmgupjsDpovqXLM3IqONB5lriPXzsRJEZ/sfox9SlvJgDM1axk6g1bjvjNb4KP0cGULZ9OIEqFWIOSdD9borVQ1bx/syO3PEnJyAXmxbN46pkPPAmAIUQ7SNewvH/9j3c+0Uqvom6Kd3Vz7/fViD36irAd+vso1myF5tHL9rKXEL/rFRE+fLzcCLYEzsJgmJcsToaKQUIUvZn/P3Te/Vi7f85CzGoN7PWp8ADMETx/jEUtbyNMXghuG43bkdc8VcKLLIiy1cCX7o7f9TaDcxVO0LMLosSCsGUrfLRI+s6fbwJBryQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199024)(1800799009)(186009)(4744005)(2906002)(5660300002)(86362001)(53546011)(316002)(82960400001)(478600001)(31696002)(2616005)(4326008)(8676002)(31686004)(6506007)(6486002)(44832011)(6512007)(8936002)(26005)(38100700002)(41300700001)(36756003)(66946007)(66556008)(66476007)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJTeHI2MUpTMXNtSWUrUU9QbXUrNDBWSUJET0FzWjdaYlI1amJHcnAzcitS?=
 =?utf-8?B?RkFwNlVkUnFIa24vbEhOWC9iVmk2U1p1ek1sc05oNVVEYk4xU3UvY1IvbFM5?=
 =?utf-8?B?MVFYeitPWE9jMVpibldRZ2lCVGRGODJhWndidmd5NmhLT1A3eUo0WU1PQml5?=
 =?utf-8?B?VFRSWGFwV0ZJcjFxYS9uRjJzeVpKTGxlQ3g1WmMyS3VxaUZhNEVmQmxBZlZL?=
 =?utf-8?B?aHpKb0hJNnR2WEZ0ckR0UGdIVzNnOGJXR3I5ZHBjc0xFOWp4UGZvKzZvLzJR?=
 =?utf-8?B?OEhYWFNOU0NQb3gwR1QyWXA2Rjc5bktSYmhKYUtscy82UTdISGdDd0Z6Y3N2?=
 =?utf-8?B?bXhlN0tadVIxZ3JCdnNZb1FRbEFPQVJEY0s2MExLaTlCeE9TV1hzNFY4OXNr?=
 =?utf-8?B?RVdDcWlWczN4M2RSeExmYWhEL1RKaWJBVkIvNU0yRFlYY0JPSmY1bU9tZlY3?=
 =?utf-8?B?TnFaMEIyVmpmVXNEcWVZOGRXdlA0VXVxb2tIb1FlSG5NQ2RvSWxpUE5LanpS?=
 =?utf-8?B?cUswcU52SnZGTWRieEdZRXJqejRxN0txMFBXb3NzUGk0U0xKZ1pJeVEzdmF2?=
 =?utf-8?B?eUNYdldVd3FFdXRwR3dkOG9ZaWVFaTlGbGl2a2dDRUJBZ2tQa2luOVhFKzhD?=
 =?utf-8?B?VHg3L2h4d25sU3BoMkJOUVIwdVVjKzlmZFNyM3pyYnM2NXU1MzFTblN3azlQ?=
 =?utf-8?B?SllJd2pJOTh4NnJ4SHA2Y253YjNlWEpZU040Q1RFZGM2R092a1dkTUJ2YktN?=
 =?utf-8?B?MkM3V0NEM1p3c3dnZ3ozRXJrME9zSjU3d3VhcHN2SGNFdVFHSDkzZElzVGpF?=
 =?utf-8?B?Tk9iN3J2OGhsdWoyUkdmNUZobllsdW9OL3lVRzFacXFJb3ZVSGJpRVpRMDRX?=
 =?utf-8?B?K2FjdnFCdjhTVk9kancyQlY5NUdIUWlXbkJGbVJHZW1DMGRlUnRxWEJzQjVX?=
 =?utf-8?B?cE1NMUxUaUR4TTNjSDB3SUpYWEQzV0JxUXk2U21JVUxpMllwcENuYjlldU9r?=
 =?utf-8?B?MzlPNVk3K0dxM3RrZ1ozeXNnVmZQVlZia0szR281ZklJb2QxMnNBQzlTSXl5?=
 =?utf-8?B?cW9jYmZvTFRFa1h0a2Q0dVNVV3JlUVk3TmlHQ2ZjZFNzeVR6Q2lldS9rSE9E?=
 =?utf-8?B?eWFKTjlESkFmU1FLNmxZSnlmSzM3VUNEbDM2b0hNRjdYZGZtQituUmJ2cXlX?=
 =?utf-8?B?YW13V3l4a2N2V1VCU2hDSDlGMnAydmVvSndGSEJaSWpoRFRzSDdoRFpWNmNE?=
 =?utf-8?B?NTZrOHh5anJJR0w2dHlFRGVLc1UwV1lZNjhFZlN1aDdVUHhTZFp0YWNjY3l6?=
 =?utf-8?B?VHBFZXJnOGpicXh4T2lFU2NxQzJtTkdua2I2SFZxdVQ5Sy84S0NBeWd0UC9h?=
 =?utf-8?B?RFJLWnZ4czFTMzVkaTN3cDBSY2s3S1BZbWQzWm5USDdXeXdtMSt6T0MvemE1?=
 =?utf-8?B?WFJlOE0yd0ZmbVhkdlNreHdMRGJKTVd1Vk5ZanhxbnVLbUlTZHlsRjkycnE1?=
 =?utf-8?B?dXRDMTgzZzI5UFgvOGpnWGVyNDhqQjY5QUprRnl4ZTI0MjNEQVlqdWRtVkV0?=
 =?utf-8?B?MVhWU05STVNQTjErdVhrMVRjaXJaQlMvWnRPWlRjM1M0MytwMFRoSHQyVWpC?=
 =?utf-8?B?V2Vhdi9qby9vSHptcHRuOHQ0clZERndmNmtUdkRwdXVPRFhRbFlwQTBncFQ3?=
 =?utf-8?B?S3MxWFhYb3lxZ0I5OUh5bGg1aTR0dmtma3Jvbk9BRVZIU0NiQk1jN0pmRkFY?=
 =?utf-8?B?YUZ0cHdyOWs5ZXJVOUVodTNVdzhLZThFNm5TYlA4Z211bVd6NDF1VmNRMzdi?=
 =?utf-8?B?Q1hxZjFNYlU1SlFJMFB6dnNDanFtVXROZVlTS2RMeXUvMXdEeEcrVEVPVDRD?=
 =?utf-8?B?MlhBWGVsdThLNmg4VmdxSFhocEpHMVgxOTFuQVBkK1ZCVkNIZ2VOMm9iN3JU?=
 =?utf-8?B?VitIL0Jwb2xDcndNdjF4WmFvdEFST0pCUmt3dStKQlF2d2prYUtoWWxxOTFQ?=
 =?utf-8?B?VUtTZElYZVNCSi81bGd2OVR0a1VGTWZ5TjF4bTlDV0o5VXpEcnUrVW5UUVY0?=
 =?utf-8?B?QmYzTzFqcVpCZHZtcG8zTmRaUmFrTWQ5NGZHbzE5c3Q1VFNmMk9kN0syak1F?=
 =?utf-8?B?Z0xqQ09Xb3RqZmFwRHhhcW1QYWp5bXBlYUdqck13ckxuMGtybjA3MUFIdGYy?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42be86e7-552a-4df2-e7fa-08dbaa68cf38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:25:33.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hv4d9LxhHgF6CtPZWKOm131eubUzsTEXAXWMHxrE4by7Eg9ByMzrYDaV+DR8I0ZaICsTacHdDphOcq4LJstneI5q1YYXee1nvggwt2jrHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/31/2023 4:08 AM, Ilpo Järvinen wrote:
> Benchmark command is initialized before resctrl FS check and
> preparation code that can call ksft_exit_skip(). There is no strong
> reason why the resctrl FS support check and unmounting it (if already
> mounted), has to be done after the benchmark command initialization.
> 
> Move benchmark command initialization such that it is done not until
> right before the tests commence. This simplifies rollback handling when
> benchmark command initialization starts to use dynamic allocation (in a
> change following this).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
