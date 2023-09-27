Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199E7B0ED1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjI0WRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 18:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WRF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 18:17:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA69FB;
        Wed, 27 Sep 2023 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695853022; x=1727389022;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5JHyvNukpK58Tky6N7ypipHTSErIIS6pdqpXp5m+hU=;
  b=lKr87OcwawJtkUojCOaG7TNb7tiHXg8N0ulG/IjzU6GR45/towucn1eH
   a91E4UWTtjLDXB5jMwMhvpiUD//iQg8Srs7so8NnCKPWCHiVJo2a9xGEr
   cltpcTdsw7zysjeDXV61JS7A2k0px+AYXra1JmjS6hAWzIn6s8OU+1tFR
   J6iZ1vKUmcLG//2VEmdAuNUBHfewv0ieoIHhCfUL+DzjSJ/5TbawnEy3C
   /CASJDjTtFzAJbZ0+NvLRvOAcPNfQGK1iIPw+fJXcMKWCr+POte8QmQrW
   ssDwh0KvcnYMeNowa8K+nq3EIBuli2L7VHRzG+C9lejqpYyBqlgqOa1x2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412849575"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="412849575"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 15:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="865018673"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="865018673"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 15:16:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:16:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 15:16:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 15:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqB0XLyCKXYBxKM5C67eT3IqSsHjmmLCoal9m5ZRAlQwkDC4QMoIElmJW5kZphaQv6aNroy3asaIpsnL+dvYZmn2OqUIxDBKr8iYAib1KWsAf3uveamnHPJI/iZ0kv/e7ZsHKwlgKxYIWz6Bw/AGhO+s7z6/8yQCZMMAoc2mNr+h1gcV5P5rRtWdU+OLosMF6cdQgvZ/8mM+++NMPc2WYJPXQU/vp6xDq659r9e2wa9o+czrrh3lTgiWMXDs25MfQRulykQ+eAmB2SnvztZNL3ArpJ23vxegAXFKlFTbVojPlPAAzxYRTXyLSEeOrpuOVzudVYvh37uPA3LM0fEmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+1aNzHaOkh39neLOILTzClBU6Osv+56KpqrN2/o/68=;
 b=G5KK2Qk5FMdxJAs1aH4/S8Ya1QhX/RQySeThYEyk0tuzKBmUGN0GiI1QSC8/22rWNiczdcmq1XwJT2q8V9DNm1dhS82FWunu0a0vglZLBy+VKJW9JYMPuRhOuTAWTP4/DTgRux/q2a/6CdpJftyHNQi67Ibfd9BlJBazfPs7iGzxxSDd/yB6X+Ow5cFJAl0BqXRtJjKKM8Uh6q+7/bSaMg4VfWWbLin/bgaVeiT9QVtrkq4sXIS8A2raceHlz+Bl47IkmAuNpaFEtYEiuMYYKF1LmVyZvYsvSrjFHLm+om5Rsp03n/AUN0hGcNn8Ob7ZW+JY385h6Obz1tZI4bL+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 22:16:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 22:16:20 +0000
Message-ID: <ec0a63fc-081a-a4bf-8ebf-d501b1d44cc0@intel.com>
Date:   Wed, 27 Sep 2023 15:16:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/2] selftests/resctrl: Bug fix and optimization
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <shuah@kernel.org>, <fenghua.yu@intel.com>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 69570406-763f-4c5c-d95e-08dbbfa7607e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PakiAaMB4zzos+58A+PBO5k7HNaJVZoZPsR3E7LGIMXxkVii8LVt8byPa9zjr30Fqso5tGezNbaDsC1hwJ7cIf56dSV793ThpsBlPDAPqYr5Gu/17usPmwDvwU0gbP4ea0ERE0YqU7dUTVNB9T7/hNiYF8BQTzcHD8STyaotQnBzYYQswYA0kEtuJ0f+yDyV9dM+0O7S7iEfOBh8CI8bJFmYSiiGisxJPw7OQkxDkAETy31bAKDd0u+2GSA6fEPftQ4QMEGbIhSbkomkfRIjpqEXfkYwLXQfgszd1EFSV6+WnOiB2dplSwKrLJyGLMhr9TrlaCuJtKoS+BR5LbGtansK3tnNJRMDiv3azkR79GjGfPAb280oIq8NhypUuwiXyEDspONArygY9Zu14HsKBSDfnWPnrDK2gNvyvSiWFf/WE/LYfNUKMjVFbXip3RFRvKr06fLs3IWL0w+smasxMlhHEGuNHGBHV5Un/zKdzkFxKXOOl9PLyuWrO+8V7hADWHngiQM8v0mFiPj17RXdr1/oHBpTlohsaucPxaUU4RrXS8tFT/22p7xqPKYsvGTvubW6G7HpZ1fOYyIcuiQQAklzYw51tUF0Br3uc24BJw8KSoLobPu948QvYgstITdd4OjbLuRmiHUo+CnZ79LvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(6486002)(2616005)(2906002)(86362001)(82960400001)(4744005)(31696002)(6512007)(5660300002)(26005)(38100700002)(66556008)(44832011)(66476007)(6506007)(53546011)(66946007)(6636002)(41300700001)(36756003)(31686004)(316002)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpva0ZjV1VYbTdMdEN2anJSRERQWmg0Z09FNExBdEJvVlowdDNJZnROcDdG?=
 =?utf-8?B?OFJEY3BKM3AyS1dCNUIwakhoR092QmJzemFyYkU0L2EydU5rYjJtb3pIaEsz?=
 =?utf-8?B?dFQzektHbmx3elR2elZWTWZBeVBOK3YvQ0gwejIrQXdJWHFUN3hNSHE2VjJS?=
 =?utf-8?B?TS9hc3RNUmFaVEdkMVJId3hxYk05MG0zR0xRTmpEZk56alo0NVJ5MjFtUFlJ?=
 =?utf-8?B?WUJXWSszQ0N5eWVGMkhJVi9Bem8vakJaZTJSczlQZkRBSjltK2pDc3BuTWds?=
 =?utf-8?B?U2hwWERrcktsSm1kM0l6TG95cFNDRXdDYkJzZVRJTHl3VDN1TlZWU2xxU20v?=
 =?utf-8?B?SDRMd1JESElUc3dUelBhUlVmejE3dTRVRWhpNkpvTFVBZlgxZURWTlF4UVZX?=
 =?utf-8?B?TE5SRllmdGtLVXRiRTgvOVJtbUpVTUMwdkpHSjMvSGoxZDFoMlRCc0ZVdkJP?=
 =?utf-8?B?MXRSeFhEWXFUUG5lTENGQ0N0UC9oNUEwL214MjFjN0pwN0JtNDYwR3YwTlhn?=
 =?utf-8?B?eGVMQVU4d2hmOWU3YkNBM2xnSjFUT2p6d1ZLNnBjLzYxYmUrUkNKMGRHSjNW?=
 =?utf-8?B?cGlyRllkV1RWRWk5T1paSHRVQ25hSlRjcU9ycS81R24xUTMrN1RRSUwvd09W?=
 =?utf-8?B?WG1BczZQdXAyMXM5VW9kZk1IczVUUlFpaHArRDBNamtFMDlJRmFuWHZFRzEx?=
 =?utf-8?B?L0lUZXRCcE5hTTc0UVhNUU5CUU1WdHhSL21uZnRiOHVDM1NpOHpTK0tFM2pr?=
 =?utf-8?B?NDNPZjJrWlllNW5sQlVUZkRNVEJEa3pQRklFZk9icFFYOGZpQUI2a0ZsT1Rn?=
 =?utf-8?B?Zk1qSGxVL1lXUVQwUURsVVZSaVZpVkxUVmx1UWcrbG1rcDAvSmtkVTZoRnhB?=
 =?utf-8?B?MnJSa2xPOVovbUxxQ3pXUXRYcFdoQWVXT1hFc0RGQ2VIalJYL1NRUndTcGd4?=
 =?utf-8?B?Z3pUS1hXcDUrWUg4a1RqQ2hTNGlwUVlqTFMxWFJxbk5xWjFuaFREam1wNWJt?=
 =?utf-8?B?OWtQNC9tQXl5SDIyc28xVVhtMmRHMlpUQjdDWm9JSmszQnlycnZVdk96ZzdG?=
 =?utf-8?B?cUNBbys2eXJEeEF6SVZyTERVSDkySlhkUFJKelhicENZQXdNOEd1Sk5aS3VG?=
 =?utf-8?B?OTFmUk0xazlMSGJ1K2dHaHp4bjRyL0dlQzExb1YzZWtlUHJ6dCtmN0pYVy94?=
 =?utf-8?B?aFNNdm83cndhYXowRnZDMkpQZ0UrcWN2TjBpY3B0c3VDNVU2Q1cvLzZORk9x?=
 =?utf-8?B?RW9zK2xwY09NcTExWmYvMzFwTXU3RjFtWmg3RHI5YTA3UCtzUHJrK0VMb2Ux?=
 =?utf-8?B?bUhCcVRJN1lhazY5N25wU2hPRTNoSEVNMzFueU9jb0hZdEpCOHVnTVVOQ0Uy?=
 =?utf-8?B?QmdNRTNiK2tVb0k1UlhRbzN1Mk5KQmRFdnpVVUZncDBURWJ5YVJzMzRicXAv?=
 =?utf-8?B?cnd1RnNGVm1iRERsNXRhK0QvVTN0d1RnS0Uvby9xNDBON2lqQTMybFNSdlMy?=
 =?utf-8?B?dEJLNzc5aGlIYm9Lc2paYTYzbzZnN2psN1R5WDRXbDFYeFRqZ090eGhwMzF5?=
 =?utf-8?B?V1M4NE1LSys5eS9UaDVVc2xScDhKYVpLYVpNNU5aWlp6djRGNVhycjVLTXdR?=
 =?utf-8?B?eXlDVkNCYUMxc0hCY3lGcjlKYXhKSFJmNEU0dnZKeit3QmxTYnpGZmE1Qi9r?=
 =?utf-8?B?dytIc0hhQk9kMGNvcEM3d0lrU0hGWGdkei9TZW5teE96b1lnUW0ydW56SU83?=
 =?utf-8?B?OTZ3QWZjb0dlMVd1TTJ2c3hnQUJuREhHRzJmOStrRmtmcUpmWjdiUUtBK1NT?=
 =?utf-8?B?eXQ5Y1FVbmVCQzRZaXo5ZlR3aDNWY2NTYk5ZYmJ3L3FPR09DY2tERDhHRFRW?=
 =?utf-8?B?NExkUEhJVnRqMkZwdFVIOU5PbEgyeEVmZ0dzZnViNmhQSVRCZFZ1UEJuQnp6?=
 =?utf-8?B?bHdiU0Y3RUtRY0JHN29lRHJtWEp1WGRxNndYbXdIVG5yM2x5MU96b2xtdXJ3?=
 =?utf-8?B?RlRHRWRXVTRCUWhmamRRcGpLN0N1aCt0SVRmcldEc1pDWmYrZ09kdG1VdWdE?=
 =?utf-8?B?Um9XRjFycjAvZkxEbXFKWnpVcnptOFpVNW9USkFSd2hwaU9zbEJXM0puZ0ho?=
 =?utf-8?B?UGl3dkd0bWlyWSs2ZjF3S1RNKzVLMno2ZDF0YzJlSEptN2d6RFN1RVBaVWJX?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69570406-763f-4c5c-d95e-08dbbfa7607e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:16:20.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l6k0bJBaGHh1boiGq129fLeIbb1LAQdzXR3MAYccLXPFK1MLXn0Oos9F5Rd6bywiPoyaOwX91g1YU3xl0VqsCsBHt3JZhVfAaFhiAhWyF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/22/2023 1:09 AM, Maciej Wieczor-Retman wrote:
> The resctrlfs.c file defines functions that interact with the resctrl FS
> while resctrl_val.c file defines functions that perform measurements on
> the cache. Run_benchmark() fits logically into the second file before
> resctrl_val() function that uses it.

nitpick ... if there are comments in one patch of the series please consider
if it applies to other places in the series.

> 
> Move run_benchmark() from resctrlfs.c to resctrl_val.c and remove
> redundant part of the kernel-doc comment. Make run_benchmark() static
> and remove it from the header file.
> 
> Patch series is based on [1] which is based on [2] which are based on
> ksefltest next branch.

ksefltest -> kselftest

Reinette
