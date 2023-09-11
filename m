Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987EA79BA8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjIKVTL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbjIKRBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 13:01:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995F121;
        Mon, 11 Sep 2023 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694451700; x=1725987700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tp2ViXKJvV8vhlqOmzJKvxBBvgZ4TjHLQewc6Z/otDE=;
  b=V9z6L8ooTpNbO29ylqyDq23imqUrXS0J8xBu/ZRroYegGYGiSx1pb/zg
   wmFT8dUfwIJbKHZv92PbRPFlKAlpDj/ctj/qenjLyTrH7EA4mfdolt/za
   JBdtS4Sq+s9Nuof74cDl+NQiQYYw/S59erCmmeuEbJ4jYWPYEbdGjIjSn
   3q4p5AnwN+gd/xysB8KxLsWYHQ9uCGQJhBt28gsISDvyMnPU9X8itEsdL
   6iZLuZPGszkCqwhipTFOgV1CrVSlmMF/uEHXkKpjYAMNu1qU7Aty4hymR
   fCoAdt0VZ4Eb7yFrCU8ZbcauoLUCDMBLW56p1RJOZ6PZGoCiYAlwdjVfg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377055545"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377055545"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778464945"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="778464945"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 09:59:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 09:59:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 09:59:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 09:59:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 09:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR63vKPgFLfdMDkXfmz89TKn84fbLkf1SaWYYMpL3MnGMg1eb9V6w1VK0AwE9y3Caf8132HYQciaFrQVOywhA2jEqs4vQqbKyU2LscUCBC0Kyk0tyzzdQV5LOKjuae5nzYY/fBpYl5tQRTbwJbfLtUFzYjCbfQe9i2ML6/n8x4uWHGEWDIxWePnGyucpSSjG86JpKXpdMDlheUelZF6MCH8XVmFHU6EjlO2U5k0SLBJcyfGdLzCdqgYriIhMKOzZl4nefvC/NGBbH50/R06rekj2cxSOvXGMn5zIdLT9SVGxXok1dbPV3z7u5hwobuVhvpHuIybo18stdKX5yygo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEs/dPNbRw+8xhBjT0SeeXzh+qhcQf+9+YMhf7dsCdc=;
 b=MVTokf5FU/CyTUNwknjg+4L3ajqGfT3rOCUatNebELip4rFZEUupziiicHfWUPY0eVCV74UK+kBnH24jblSJWWr3bAp7TCMQSDffBYISl8Wqi54mvsiKQM35vGrBb6gzmVkACsMK+4Tn+1dK3etWQ2APsyJMWaEARM2JrbWHitz8dmG3uqTREVJpuO0Z1Sqs8dvpehW7Bo700RkfYeRAJezj/9x6260OfCnOpbPHv+xrI/PBFL4GTBNi7+xCt22H109CA3fV8ef15GDSn7giqzmZ9EIMkPCHUVKg7FSHC0A9mjtZiFbjrCX5hYwZju1xmhDOdJYAew1P6PlQbuy6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 16:59:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 16:59:33 +0000
Message-ID: <e0fa9375-0b50-af89-81d3-eaaecf19a788@intel.com>
Date:   Mon, 11 Sep 2023 09:59:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v3 2/2] selftests/resctrl: Move run_benchmark() to
 a more fitting file
Content-Language: en-US
To:     Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <7026d06ce116c4c5b5454c814cda69387c54e2a0.1693575451.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7026d06ce116c4c5b5454c814cda69387c54e2a0.1693575451.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 41699f65-cf67-461c-6760-08dbb2e87925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5jW0EvXrI7N+FvJnIMNdGkkh49JKYKK6w/YyIt6PDeM5KPYFgcOcDF564BB9qCcDvNzqHISbnOk8tCvzBc+5g7GojVTZb7Hg4WPs0UsmmfwHvJEce8vKFy8ohov2EKH3OSWgSFIStOAluGqTQ4n0ON9hH5LeB6E6avZLh7BI2P74iyog7wbrCuzRL8FXYloLkw1PpKU9vf1tPvzBOraV1sDyqHwZa6LNM71+jBZUsJA0Kd3MXnoTFjw8ooTGe+3N883aS/vdDiu+XF7XkE9dnvAHFWBbI4mHxmjeb16No8HWxFU83CugVvmhuyWTSPvdMtwzTnIxdhg81OJmZ8InlqSPcqcAjmw6ujsysfo6Ko6RwQsW+GNhpxXC7EwqA47FvGNz3L9JpIl9ESrSRDY383WJnP+9N9Gyo0skIIE5CVFiYAtFfnjMws2QgOwAtW6csi407rxxWs5i4ObD9UR5TSAFvg/bwJADFx1e/+SKgD5E542wIaWSSUN+iXOJijNId9XjjrtRbqCpkbF5NVRpwO9hGjX3zVGhWqRkC5ixuJFmm7DowJYbacITfXevcENw4rpE8W1G3PMArfAr5m2A9PLzSKWaSp3KoNkQIZNGjyXwcGfRjO8LZgBqosNS12LZxKkgLhWgrxmFQ3VZJ48xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199024)(1800799009)(186009)(4326008)(44832011)(478600001)(316002)(66476007)(8676002)(66556008)(110136005)(66946007)(41300700001)(5660300002)(31686004)(8936002)(66899024)(2906002)(38100700002)(82960400001)(26005)(2616005)(86362001)(31696002)(4744005)(36756003)(53546011)(6512007)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NnTHZBUDMwZkxZZzg0L2xOb0J2Y3o0SmdJUk9NUittcGJQSTFjRU9GR2h4?=
 =?utf-8?B?T29yZzdPQVRUUitPRXNndWZlV2JkNkRlL200Rm04NkhwWE5wMVE0LzUreTZE?=
 =?utf-8?B?S0lWSmc4VHdNMVlyT2xMbGJnalFvMVpBZnlkTG5qTysrYzN0QjNPUUR4ZUpO?=
 =?utf-8?B?YWNXQzNIRDFZRXkzeXM1dmY1b1MwOWNIQ0NsTzlmNHJMWEdVc1FBUGJ0QzV4?=
 =?utf-8?B?UEtZeVBjT0lMbzJ2K0IrR2YyakZydVIzNlk0VmlxWTZyL2xOdFVMYWtjMHZ0?=
 =?utf-8?B?eWovcEpPRjJNd3V1aWs1YXVIZktLdUlYa003ZHFQbmZuOEhocjBqYktQNkl5?=
 =?utf-8?B?dEx0SnQ5L3EvR3RXUFB0cjNuTXRPazhsZ2FsMjF6azg0RUpBUi9INGJKZUxk?=
 =?utf-8?B?dkdOMzViVDA1Vk5oakkya1RZWXovTGRBdGZFTzVPUGdvN2w4Zk1kSXk0RVNN?=
 =?utf-8?B?NmZPMlZ6cnFEd3RkbUJkMVVDV2J0elhKVlYvdVIvNEIvK3YyeVlSd1BRQmJj?=
 =?utf-8?B?blZOMlFFU2pRVjJjdkZhSFY4MGVxRnk0RWlsQmZ4S2x2V2V3VlR3YytaN2V6?=
 =?utf-8?B?ejc4K3h5N1R2UHdoTmREVllUVVE2bk0wM09uQTFPN0RlYndlNmtNNFFCc09k?=
 =?utf-8?B?OXNSb1N2OGh0a3hrNWtEVGhSVFdnSE5IMi92S3cxTjRxMnp0TTE2TklpRWhK?=
 =?utf-8?B?bXRpTzF6UVdwQXRmQ1RQU3hnN3FRUWgxdE94bVlNNVEwMGN1WEZCNktUSFNG?=
 =?utf-8?B?a0NIK3pFRm5kQlhtTHVBajhzZnFlbW5HczA2VjY0YlZMeFEvNUFmK0h2Ymxt?=
 =?utf-8?B?T3J6cUhJdW1rNkN0VVhOcWNBL1R6aEdBVjBkU1BHYkZNYnIyWE43OEJ4T0Jh?=
 =?utf-8?B?RGZBVVlXUHEzK1dXOGRZUzB1RG51L0ZaNFhpRUJiN3l1MVBwUDl4aW9rempJ?=
 =?utf-8?B?bVNrOER6K0ZqZVQ5WG1pZnY5eURSS3ptNWpVVWNwcEJZSDFhVGMrbS9sZnZ0?=
 =?utf-8?B?L2pLdEJBM2VFYmlrWTBtdHJkZG1MYjdKUmgzdDA5MTRoR0M1THhjMnBNMXJG?=
 =?utf-8?B?cHJ6eHZ0U0cvM1JMZCsvYlJ0MldydU1JWUFlSkhzVVhvVmJtRFJqbUNmclJ4?=
 =?utf-8?B?dklIT05iZnV1QXpHVnptM0s0ZzY5Zk9rM0NnL0J3c3dranB6M2dZcHhiNlV2?=
 =?utf-8?B?ZC9Td2swT1pUcU13VWEwckFPS0dZek9GbzlZcFNaT2R5b1NjZkFJdVU5azlR?=
 =?utf-8?B?YkNGMkxRd2RqL0Y4SnBWMEc2UU0wZ2pKOVNGbGtNTEsrdzFsWmdWQlNXczRB?=
 =?utf-8?B?SmZ5OWpzU1YyWVpEdWxObDBYUldKU1JiSkIwcmgvdW9YYWhHaCtvcWt4OFRU?=
 =?utf-8?B?TnVXTnFYWHJHbGE2SU92eklPdXBBbmpJZ0QyakNYTVo1RmlNUEFlaXM1cnRS?=
 =?utf-8?B?MDRZQUhaRXhMcjJoTU4xWStObmZ6dDdNVmE3emV6ajM5aXVNand4OEcyanM5?=
 =?utf-8?B?ODhMZE5LZUo3Q25LQ05kWTh3Y3ZJYjhpUEVDRGQrOStiVkl4eEhNbUpBOTNQ?=
 =?utf-8?B?MFJ2aHJDZUtmdWNhbXJ2SWpRc3QyREdCTXFzbWNYVjlSWFZNaldmekI5NnZJ?=
 =?utf-8?B?aHM4V1o0RHJybkFRcUpmcGx3SGhyK0JSaVJYaERJMGE1S3N1Sy9CVzJjdFdz?=
 =?utf-8?B?U1hkOCtpN2Z1LzZKMXlZb2MxMDAwVjI2VTJhS3M5SnltMWJaR051OTkvK2Rs?=
 =?utf-8?B?U0xLY1NXRTZMNFMvQm9ia2xqYUU0TnV5Q0R6dEhVNW5KWTNEdmh6amMyYi9l?=
 =?utf-8?B?Mjlvdit2aHRhYzN1RENZRThiMWI4dkVJckJiWmVSYjRveldWL3NWc3BtQk4x?=
 =?utf-8?B?RWlxVzdqSEd2cXpieHZvZ2ZsOWI5dnVIVGRsQkJFQks2di9LZlZOa09UTm1Z?=
 =?utf-8?B?RTMzSzdCSFV4UUNxTFdTQWltbzFMRU9yVnRqRG1RVFl4ajRQNE5vdktVMEgx?=
 =?utf-8?B?T2M5d0FNdkpCUGdWSWdTNHR6bENBd1U1VGh3ZXRIeFZ6U0dSWkd4MEtJa01n?=
 =?utf-8?B?bWJ5L2Q4eDkvUUtBV0RzcmRzdjRoTkZCMXJSN2tHeS9yMXBDZnlqVzVlOWI4?=
 =?utf-8?B?Q3pmTVpaRzd2TTVHdUd4VHJkYTZiejVCcmQzZGo3Rmd5UkF5VDFJRUhmVlhp?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41699f65-cf67-461c-6760-08dbb2e87925
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 16:59:33.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98M4O35GkugNoYFtOtyR1Qg1UOW6PDg4Y652xTWk1V06iUqJqxBv/V/l0SYMmmJ+PbgewR8mw6EOMV53NyT7K/rdXI6y9ZQ+g4RmCIFu5pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/1/2023 6:42 AM, Wieczor-Retman Maciej wrote:
> resctrlfs.c file contains mostly functions that interact in some way

This can just be "resctrlfs.c contains ..." (no need for "file")

> with resctrl FS entries while functions inside resctrl_val.c deal with
> measurements and benchmarking.
> 
> run_benchmark() is located in resctrlfs.c file even though it's

same here

> purpose is not interacting with the resctrl FS but to execute cache
> checking logic.
> 
> Move run_benchmark() to resctrl_val.c just before resctrl_val() that
> makes use of run_benchmark(). Make run_benchmark() static since it's
> not used between multiple files anymore.
> 
> Remove return comment from kernel-doc since the function is type void.
> 
> Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
