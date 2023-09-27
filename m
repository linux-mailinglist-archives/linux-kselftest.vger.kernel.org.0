Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB98E7B0ECE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 00:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjI0WPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WPO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 18:15:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7AAFC;
        Wed, 27 Sep 2023 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695852912; x=1727388912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TDpG+n25nAqwuViGiWvrzd+pZpG+OMrF2/2MI2f21HE=;
  b=cor5czwnxA5AxgjdCHTiO4O+uZexr8y4gKbyxLZBJv+y2AxLHmi3mfeQ
   irh3Q/UzncoqCtojDCPB4CsIrOAb2k2k9tagHyhIpxz0XDhZCJLhMIxHa
   cVCDM/bNT38Em3j6qTe8biTQfklRdTAPejp4o/BX0fG7/flx6+jUVNYh7
   w/E3qCXQCTKAz53ECYfANSm2q0fE3x6dH8gnn8J1Kz/BwdyXIMhf//3UH
   Msk1J4ICfTCNjajqQkgCowUDsyUpFjA57WNfItj0XcH9IDRyyY1ryBanw
   3MK7Gsfq4/FKkCdNqlrg6B+uULklau+G2SSFH0RJkqbkt3TGflBjHk+VA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="372292382"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="372292382"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 15:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="892773060"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="892773060"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 15:14:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:15:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:15:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 15:15:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 15:15:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/UfbOh+HYXwNQHEBcu2iKafcXsgDk3NoqExJQvsL3Xruk720w2qJiRokbB/lfKhRP0vy6zt8A/cCwVtQ+fB0sydhuJ94hltPkV1ye2MDDWFEluGyG6YCZCttGLq87PptT43/2rYXNZmHvWNhYAq8dhulpFCwmSJ9kKx26J+8rCxS6yk0r1Q2o0N6Ukp0zyadl286/cjQvcjvYAGKtXJOTdk0r89h8vAux3VH0vbYNmgj9EmKXerZdI9CNZ9aGQdX+VAOss/a8bKObDg82UDxNudhIRoNEQsT5kxdtLOcb46AR3mYWENi8dNO4WQ9rrI887VpsHyYL2C9inHMzc/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY/Ida7zQGzMiezccSLmiVUy4JMuXQJBXU2YHFY6/YQ=;
 b=NWkN0tRYw1kT1TM+7M/lGMOYQF0CExFIEQcef1rC4eAgLxhQ3vx7nfveA8keq3iTjh6mwpqj2LYzgR5VFhqQNiyFcAvI+7Dkh+Yj7cpvyF5hnZH5FbLhj/rlj1cJpf7gEkZBj27tk/6K52+4a/+S+ELUd2zP03fyjlpW8ADqnRtQqdqT0dkCu2Y1SARI+WgygBmeilYaxvvTLhdfG5weLgMW/r2/zo53ldNCwXa8PQ1JECfW+qdJvpo81A7gTOmcvNpUzh9zsK74xeNJ/1ZHsSjtDUDwN79OXd64sMtwmi8l3ndWbX7cJQHc5dfpMOd9dZOWPYWxqCsQMNX0OC7mCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 22:15:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 22:15:08 +0000
Message-ID: <322fb9ff-f3f4-45df-9b3f-524125ca6101@intel.com>
Date:   Wed, 27 Sep 2023 15:15:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Fix schemata write error check
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
 <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: facd962b-4373-41d2-1f5c-08dbbfa735bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWM1eXoBRuYsTZpbAW2mD2cpc/odxM5Fa9VROqsDeL+Oq9NkmXwP+ORE9qrMM4HTomiDS0PfRwA0io+uohwz0EZ4UY1DgvUOmZ4mvWMXhu6f2mOjF+7GMU9UGOmQ1/K2bV4UNHbzoqHdTJVqcTu8dgtwW/ejVkupTk2gWm/41RqrS1WJF6Omt4Dpn1txu0CfR3gmytE8kBdTMbcQqcet8XLnEUgpNvAkeRo3E3K93XpRjMNW/dMfx7gJaFUUXScD0OMe4ykcRLbVGQWtksDyfNov612HSVdWrkL9/0DASLVth8qxMBiQUm34Q90GTMZ5sj3vHzUUYnyEw+IFJzUpDtBdqfwdhRLd/NrjmkIf7sfTHxdRBet7/v29px0NN2TNjbQZE9IxAQTg/3vSI8h1zcRxTLM/m0B+qQavzY66T0njnnbZp+nII9aTGZ2SaJcnvmJnWmyrXnBTiLw9jxTAhM2s4jPsjDADGb8HfURKuyxK8kCCo/Zax1ioq/+4ai0T15MjwTbZhQ9nxcjjgVMHyp+T0Oik7kkGXf+J8woDb5tiSdEhQ/efQPhy99CQcDXU0mWALGqjijIQcxMKJifqWTqrELIWCDPHftzr2C1przzFzjNN2n68Mw1p/XdM+m+wM4eZ1+Y3fao9ymJqcWkC1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(83380400001)(478600001)(31686004)(38100700002)(6506007)(6486002)(26005)(2616005)(6512007)(82960400001)(53546011)(316002)(31696002)(86362001)(2906002)(44832011)(4326008)(5660300002)(8936002)(8676002)(36756003)(110136005)(66946007)(66556008)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVXenFVd09IMDZ5Y0JqdU5kdWlvTWZNOE1RTjFRSTdoS0xBRW8wZTRoMHo0?=
 =?utf-8?B?aWxkNXNGK01UNVNhSFVJU05aeHNocHlXQUYzUDFsc1liSm4rOE5PY0hQSjJu?=
 =?utf-8?B?RnNlekdUWk5TWkprRVdiYTBFRzE4eGU5VzJUVTNlakNRWHVFRXQwVEl3bmdv?=
 =?utf-8?B?ZTFQd3dMOGMwY0dEbTlzYkd5bmtVTUJBcU55TUVGN1MwdW1LQ0dQdEJzYVBs?=
 =?utf-8?B?b2U1NkdHeDNVaXB3OUVYZmRwK0E1QVJjelZEakVVN1lXZEZKTzFjUlVYaTJT?=
 =?utf-8?B?dEdrMU9DQlN3d1paOWFmU1QzOWVBOStRdTBTbmx4U0luSW02andSMi9DZ0hV?=
 =?utf-8?B?aDFzZWRscW9IZWN3amQrOEJSMm5sUzA0TWtKVVJlYStyWUZ4WDkwMEcyMkov?=
 =?utf-8?B?ank1SEl1N1ljZ3VqZkdlQTVHRTEyTmU4YXZzQXZoaFlJRzd6SVVlSGw0VmNu?=
 =?utf-8?B?dStHdlZFOGljbDd5M2U3alRidzlWZ3FnRkhJTThVSVFyYzk1cUFjaFNPd1pv?=
 =?utf-8?B?VW1MdmdnZnhRemppVXBWQTJTWDIvcWl4VGxkelJIeDJHdk9CNXdjNVlQZFVN?=
 =?utf-8?B?QUYwcjNnRW5pYVpjc21SbkJ5eTljUXRUYjFpSUVtOEkvNk5SbVkzdExjcVlM?=
 =?utf-8?B?UmhIOGhZT2cxRTV2MWhRUk1VTlN3Y3lIa3Y4cEZZK210TjNueVNvSWdtRjhX?=
 =?utf-8?B?YzBBWUN6TUhOZEJMdVBxK1VqSlBXMGpMZEgydzl1dm5scnNFa2lWUmRDaEVR?=
 =?utf-8?B?aitVSklrN0RsRDkvanZxeVI1bWoxUUVkbUxnVFZRRkc0d2lrY3BqWjJPMmpE?=
 =?utf-8?B?cXdDeDBLb3JNUEV1bE9VSWpYbTVwb09rZU1UWW13Y2NST0xxV0VCSmE4R1hO?=
 =?utf-8?B?NzQ1bDNtVkFMY2ZKT2xwTUZBZy92NFNZVmNibURENUxsUEFMNFhkczBpaUk0?=
 =?utf-8?B?UHNLUFhPZHZMMlNsYlkwNVp4Y2Q1ZjBkZ2RscTBPbndnNmkrRWxYWEJHTEtG?=
 =?utf-8?B?Wk1ydFB1QXNFeHVsZVFMSUhSNSsxSlZDMmV3ZktTYlg0SERNSXZMRU5NcVlo?=
 =?utf-8?B?S3lmTEZXc0hwMDNSemNXRTFFU0ZHMld5WnJkVW5ibGVTRDJyby9KT2Y1L1pK?=
 =?utf-8?B?Y2tuRVkwVDYxQzBaenFZdVk0Y0xxcFBVU1FwSnpJSGE1dnVHd1ZRRW1kNDd3?=
 =?utf-8?B?enBYVStVbldYUkRqVGRMU21xOU9acG12VzRaTktuc1pWR2Z2RW95ZDRtQ2Z6?=
 =?utf-8?B?UFdTbnpJcUoycWZxeDAxYWcxZ1JVRWdyV2xJNkR2SWFpbkFjZ05kUngrS0U2?=
 =?utf-8?B?L09aSG9rYmlRZmtkamhqTTFRQ3d5ZE9ReTVBa3JFcWNjamc5aUEwYi8rYTVP?=
 =?utf-8?B?dG5ZYWR3RzBTS3VtNlI2YkNBcE5pWmNkSUEyKzlRVXdEK2tZVUx5NWtKRGtH?=
 =?utf-8?B?YkRJSzJ1WFZLZDZnME5KNGdiL01scEZIUUpZaTNnbVRmdDZXR3Fkd0NYUTZz?=
 =?utf-8?B?Q2Z3Tm44RE5sZHhyVTlSL1RHRDNDUmdRWFJCWk9GbjltQUErcDlhdVBYWG5S?=
 =?utf-8?B?VnkvUVNYU0J3RmRBeFZpTUN5Y2p2aWxrbXNUWnFSZU9sc09kSklDTHA3THlP?=
 =?utf-8?B?d2trS01DU0hvaFE0TWYvaVRDWFpFTkptWVFrN09hdWEzUnp5VnczSXpYTUhW?=
 =?utf-8?B?RWR1Ry9rZGRqNmRRa3VDZUVtQWNhOFIxWTFJOXhuNVRrSFc0dENhazRHekhD?=
 =?utf-8?B?TmlvdVN0UmJpNUYzdUhpZXorWGVNd0svbUhJazdCRlptRGR4YStlUHBpNlEx?=
 =?utf-8?B?dVRGeWNrc2ZENGxCK0gyTzRoSHVCdjMzQWJGM05vYStmRmlRd08yY2VDYXkr?=
 =?utf-8?B?bHJ0L3hnWE5XdTBIZ1Z6dlBVY1MrLzhYOCtseisrcVdINGU1Umd2ZU5EY213?=
 =?utf-8?B?MWYvb1VSMERrVkVWcStNc0pmSVNQWjhqcjVHWEN4Wm5MMkRQV3VXVXhZdXRq?=
 =?utf-8?B?NmtEV0pjWXAyMG5ZL3dmb081WnlZWGFNa2JFWHFtRjJydjlzZVd5UEY3TGgz?=
 =?utf-8?B?eTNwcGJvcGlhN1FUeExlRHVveEJwMDkyaUJNVVI5eTVLK0RrVkxaNFFBSWEw?=
 =?utf-8?B?dG5SdnN4MW5zdGJqaUpwNElqN2tWVU1YZE9yL1c2K2xGU1VFYWxuVHlEZWhj?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: facd962b-4373-41d2-1f5c-08dbbfa735bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:15:08.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiB6B3sVLDm1fWHtXW6gq1GpOTbLAK8iDmNmgux6dfg7k5y0GwEUQdRmk4QkIwceG5K2m+l5ZdvohwAG0xO3i9NWvyYDZzMEeLTTkOwfdDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/22/2023 1:10 AM, Maciej Wieczor-Retman wrote:
> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to constraints defined by what a particular CPU supports.
> Some example of constraints are max length or having contiguous bits.
> The driver should properly return errors when any rule concerning
> bitmask format is broken.
> 
> Resctrl FS returns error codes from fprintf() only when fclose() is
> called. Current error checking scheme allows invalid bitmasks to be
> written into schemata file and the selftest doesn't notice because the
> fclose() error code isn't checked.
> 
> Substitute fopen(), flose() and fprintf() with open(), close() and
> write() to avoid error code buffering between fprintf() and fclose().
> 
> Remove newline character from the schema string after writing it to
> the schemata file so it prints correctly before function return.
> 
> Pass the string generated with strerror() to the "reason" buffer so
> the error message is more verbose. Extend "reason" buffer so it can hold
> longer messages.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Unify error checking between open() and write(). (Reinette)
> - Add fcntl.h for glibc backward compatiblitiy. (Reinette)
> 
> Changelog v3:
> - Rename fp to fd. (Ilpo)
> - Remove strlen, strcspn and just use the snprintf value instead. (Ilpo)
> 
> Changelog v2:
> - Rewrite patch message.
> - Double "reason" buffer size to fit longer error explanation.
> - Redo file interactions with syscalls instead of stdio functions.
> 
>  tools/testing/selftests/resctrl/resctrlfs.c | 30 ++++++++++++---------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 3a8111362d26..edc8fc6e44b0 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -8,6 +8,7 @@
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>
>   */
> +#include <fcntl.h>
>  #include <limits.h>
>  
>  #include "resctrl.h"
> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   */
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  {
> -	char controlgroup[1024], schema[1024], reason[64];
> -	int resource_id, ret = 0;
> -	FILE *fp;
> +	char controlgroup[1024], schema[1024], reason[128];
> +	int resource_id, fd, schema_len = -1, ret = 0;

I am trying to understand the schema_len initialization. Could
you please elaborate why you chose -1? I'm a bit concerned with
the robustness here with it being used as an unsigned integer
in write() and also the negative array index later.

>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
> @@ -520,27 +520,31 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "L3:", resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "MB:", resource_id, '=', schemata);
>  
> -	fp = fopen(controlgroup, "w");
> -	if (!fp) {
> -		sprintf(reason, "Failed to open control group");
> +	fd = open(controlgroup, O_WRONLY);
> +	if (!fd) {

Be careful ... the error checking appropriate to the original
pointer needs a double check with this new usage.
According to "man 2 open" - open() returns -1 on error so I expect
that this should rather be:
	if (fd < 0) {
or
	if (fd == -1) {

The rest looks good to me.

Reinette
