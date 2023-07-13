Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3A752D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjGMW7d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGMW7c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:59:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D72127;
        Thu, 13 Jul 2023 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289171; x=1720825171;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vBHD+VEwHrT1Ln0E0+3Pas0gSYPDRS11b8HMx8w6l9A=;
  b=ms68fzPTVzkpz33ShvPWc2pT05Oo1DL6vHtcMp5funLLCu9tY07b4CZV
   qni6/HZvNwyXoca+OOyr7yb6/k97RRPmCeXUEZhSg9MXOYxKytzjgh+MW
   FeZCjsOdEocwQ6FSt5dGguYsxy1REoLBesR1dRQIOmkY3npaxEATPkxrs
   uRPcNypUC7Ld/JQh62rcLw02fmbRQekxNHwNGVeKydZfNT/VbkouKJGJL
   jO517DtZ0MZ9oTNWszrNyL+UOOutHv8e02ePcQ2h2CUfVVfqT4YWP9Sel
   hQVWEuK7YhLm6vTqxkvt3X9vEomcMkc8ipexxF+vn+bdh8MtvLuqAiDhh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362796619"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362796619"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812199938"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812199938"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2023 15:59:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:59:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:59:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez+POSWCrweRaUpSD67wOvaVFs0FJjBW8EaWH6lFM/PjEDjQRYd83TDjVSncRCbrWYfNvuB/1JmJZ80PPSHxTu8QiOKvCRubAIGrMAJfZCjO7fYFKDsSOGWiqJmGE7Ffpgh45HGCsDAku+0r6hCLXSlnf3cDHkerXkhsmYTGlkX7ZWZM8uSTyXSvoQc2pf88KdxR25OYiCUWgiHqKkycRqfFuh/nKvpkjMH9ww6In9g///KQFOE5UcBfc+Ya1Tmfd4f4z/I9BlOoV5JFg+0P2igpJH+pNCfCtG5paeP9R92XZhqfF3Qb8NHC0epnsSEgWUgSq6Dcf2CaUxYlfqEQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtfdiqjpU8ia707YElLhiR6lQT3LKoLOdYNDZaZxe3s=;
 b=VabpwgnbYRi1+hnm6NuotCV/2bCYtqXLrpqoaR5PoTPrxzCwS7KH3o2DrLCPnzq9N8FTaAmDAZOiAo62t3dseGrwE4bMnxQ3/EFXeJ6FgCMN8Li+s5HLrTR0/phIxceOb5PE71thbZEym1RFAGueYAlLI1TXhXakGJKV4G0Sv5MtlUSPJVx0gu9aqQ1BQZf1sYHjhdzBY1vGGW+s661Y1EJ4Dr9NxjGcpDSSOgwlH4tb24a+GlnHYRRbsmW4pYD7Jnrz0gnwUN2W2Yn1rTOOOl6BjKhY7t8wKbVNE4dtKK3acy/diGTkmBL3C/1ID7n2NJukYnEkGPRbKi3gUkQzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Thu, 13 Jul
 2023 22:59:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:59:28 +0000
Message-ID: <b9c0402a-5471-c8ce-9cf4-aa1a1a629b07@intel.com>
Date:   Thu, 13 Jul 2023 15:59:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 08/19] selftests/resctrl: Remove mum_resctrlfs from
 struct resctrl_val_param
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-9-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO6PR11MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bd242f-ce49-4907-efff-08db83f4cf61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeeR/decnlf6fwfjYllZYouis1J+uV76yId2cMgUJm6hfIgG/hB9EOCW2smkWkzVS712ODjvYd2Kf4kx/cL8VjJgJeVFAxzGNcTJYQyNVticijdDpaQGLuY0y7MVwc2GpvAEv2kDuzZgrImn4bMvt7Sms5KLsd1Ho8gh3tFkaeaVfkOy0oxnC9DwPTpTw0Z9M1eN7Ri06NrpwOrp+2qs2aq7z2L6Zx4jRIB0BNQMTnkXUfY5RUalszVBfw4xfaMqcRoZk/NpR0ZWXMFyRRU+KDInBfnsUZuuVZJ20Z7H+cjMWqwwKAiECvijwhJCtYwJP+01VLRO3KglYO5AC2GOl067y29dA/zFJ1ulC7Ix/JzduNzIV7LlVib7ROTyBjbceLEpWz5K4ALWcN8O63kN0Y/Q9QJiVkawAAsREynncSB3fEJfVW/ZxZtLFplC381SxNp0+kfAljyX1awqPhZO/EDrGtmE+U95Zxwges5amZinQIJBOVDnxrtEiwkJ7J0YLBqWEv7haypeREgctl4spwNPUDXYYu5TW7XeBHQ8rhxeKsOanGgLSa7hZVIcFmFP5CUFtwHcuWD+oV7HeqLDIhzf/mpL5ipwpdxSVurS+GLeWUauVVuHshBcGgAErJtN3dm2xSyf6y7IuFdaY2cDBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(110136005)(41300700001)(44832011)(66476007)(66946007)(66556008)(478600001)(4744005)(31686004)(5660300002)(2906002)(8676002)(8936002)(316002)(6666004)(6486002)(6512007)(82960400001)(31696002)(86362001)(26005)(6506007)(53546011)(186003)(83380400001)(2616005)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGZLQkRLS05SaFFSZW02cy9VZlI3eVdoRXVCTHlpcUswaUdFVkJXWVM0eldr?=
 =?utf-8?B?cGRTSWRZQU91SXI2dlk2Z0dvMGFCRVhEV3NXanplR2RxalJzQ2tqYWhYeDUv?=
 =?utf-8?B?WnJQL0NuQXB3bGhZalZHZEdjL0twTC9RN05BdFJ0cVd3YnhuMHVYQTNaNHV1?=
 =?utf-8?B?empCSjlBSzFCNThuK3pHYURDRVFCRktkZWJJVThKSDBDR1ByMHM1VjBJaWZh?=
 =?utf-8?B?eDRKL1EzMXJmTGxGdHRCUE5odlhBcDlqdGorYzR5ZUVKcmNsdmVaMnp1TDY2?=
 =?utf-8?B?TDZtVDE3SmM1MWZUcG9YZkRxMHFMdUlHeWhWai9hNVJSaG5rVmRPelNzSXlE?=
 =?utf-8?B?T3FBZ1JCVUdkSEg3QndYU0YyVC9uLzVPYkNOZ2luQ3phdEFwcTdVS3pYQjBP?=
 =?utf-8?B?blByeExGTkRiSk01QzJubTdSRGtzQWwwaDFNbGdmaWtzdWlGN2UxOUlyY0pR?=
 =?utf-8?B?OWc3dTVwMHlFMlIyVHZXNGN1Y3hBNzQzd2xmZTRGTGNmODJLL0ZtTVBDa2Q4?=
 =?utf-8?B?djA2bjhBa3FzNGtVNEM5MUFjUHFEcm9HaUUzenhWS01hTm01UFdMcjJJQ0ZU?=
 =?utf-8?B?VWFrUzFDSmlvSG44cjdvOTJsZFF2YTVhR0V2OEIrWit0a3B2Z0lGNmdHR0Rs?=
 =?utf-8?B?eVpOZW02bHdiWm1VeVcrSDNwQ09SazZhTnNvMC9YU3I0YlBHVUtmZW4yR3pH?=
 =?utf-8?B?Z3psSzNuejdXM2Rxc1cxeFZ4NW1vRVB0VFlEWFBjclp6a05VQ3VjQXNXTjNS?=
 =?utf-8?B?YnZLRFI2N2RWeU1mOU5wbENHaDZKeWZqTmJ2bmtzeTl4bmJHdW1wdU1ZaEZa?=
 =?utf-8?B?UDI5ZDFibFJ0eG5mL1NlYWlJUHpzTHRFeWRKSHc3cVhBNVZKSllKb2xLbjFh?=
 =?utf-8?B?N05na2V1em5GOFRhOVJ3RlpqTitpeTVyR004UXdWK3phUnZpWDZMZ3gyUUZT?=
 =?utf-8?B?VkFzQy8wUUZLZUhnRWRRNjRrekxWNGpWQndxUVU5bUZRdTA1d3ZmeWlzU296?=
 =?utf-8?B?M1puc2tYNytyMnNma05wSUxtTnVKYVQrM0VIUGlVUklaMURLa2xNWmE5cVBV?=
 =?utf-8?B?V0I3U0wwN09RL2ErNjNtRjFRdUZzNGVZV3JnOTRNaG0vQzlmdGRmVHBWY1hI?=
 =?utf-8?B?aVo1U3BzL3hsd2JvdlJ2TGcxMW1rOVN0aGQxdmxXNmFmK0Y2NDhIZjA5N1FM?=
 =?utf-8?B?bFZFNmp2NHR0czl5YlJJUWlwUWpXOVgzNlV5Q2tzdmIyVWlHRm1Jd05mMjRR?=
 =?utf-8?B?Z2xpbitzbm41M1BDU011RGViY0E4THMzRzc4aTNscGFaN2RxOGdvQmRTMFhx?=
 =?utf-8?B?d29ZNFRaeGM0aHFxN3VGTStVaXpBVUxIbzhOcUJaRmllVHlYSndZMldOL1NT?=
 =?utf-8?B?NjgrRE1jdHRRY1VGSm9tdmpNcktyeXRGUjBtSkpGbUhHZ2s1bGhETUloLytH?=
 =?utf-8?B?SFNkU2lqbVg4Y3Y5V1o3YmNyWkNyZGxzcnZJT3NaeVhmWU41ZS9sT1ZlRERz?=
 =?utf-8?B?cUhtNzR3M2tkY0V2eDM0aEFPSGJjclNFNnR2bXVRbmdHeEJjb2dsOXJVTWdy?=
 =?utf-8?B?K1hMbWNvVEtOS2xoeFBNaTlPL1dyaHRyN2JRcjhBWVJ1c2ZjdmtVRHNQbmEv?=
 =?utf-8?B?cUxVbElJWWhvVUY1YmsyT2NJTFk2dVVnYmZDaEs3WUVrVlJmTndsSis0R3hB?=
 =?utf-8?B?eVN2N3l6ckxBZEM1UlJUTDFRUlJkYlRmd081OU1zQVMyMVAvbGlST3lDMW5J?=
 =?utf-8?B?R3VMTjUvUU0vMy9Qc0NLN1pnUVVXcTQ0a2dNb2ZVWlduL1YrYStGTEs3MFVv?=
 =?utf-8?B?cEdaZFlaQi9EZW5RbHFuK2Z3UUlUa3pGZDNiNHU1WUx0QStRMWd2YmRDeWN4?=
 =?utf-8?B?bEVxZlVObW5XanNtdUhDSGUzQmJ0TG5aWERtc3BwTmpoQk9yUHRMTmg5TFUr?=
 =?utf-8?B?andtZTU2R0NJUjRaMENISU0wb3BjOWNBQ0lvNDBOSi9jT2lGbjdqSDI2WnE0?=
 =?utf-8?B?UElkSXVIbDJ2TkNYbGwyMmlkbkJzVFdxNmtvZ1lvV0JqdGh1Qk9FMjZ2WXRn?=
 =?utf-8?B?aDJPc0NtdzZmOCtBcC9JZDFNYjBRQ3FEMW9pUnRYWFgyd0RCS3JxZ1ZKSnRY?=
 =?utf-8?B?eVNVRi9NVkluRHNhUTEwdk4yczNYU0oxUG9HeHJETG1zWWthTnlHNDFTQUEx?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bd242f-ce49-4907-efff-08db83f4cf61
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:59:27.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVBX54HTje5fEF/TK0TEpZWF3vhYlxs2msMzUxOWvN3RpqYD8wfVG4IzIirJ55GdsqA3RsAefULHRtQLx9k+sJ5yfnFtItIrMcCf7pEWFY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> Resctrl FS mount/umount are now cleanly paired leaving .mum_resctrlfs
> in the struct resctrl_val_param unused.
> 
> Remove .mum_resctrlfs from the struct resctrl_val_param that is
> leftover from the remount trickery and no longer needed.

s/needed/used. Actually, considering the first paragraph the
second paragraph can just be:
"Remove .mum_resctrlfs from struct resctrl_val_param."

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

With the changelog updated:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
