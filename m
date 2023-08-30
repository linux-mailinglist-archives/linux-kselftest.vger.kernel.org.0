Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5678E10F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbjH3U63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbjH3U63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 16:58:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5DCC5;
        Wed, 30 Aug 2023 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693429076; x=1724965076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZB/EUyf1TwuUqjWwjH/BNjU8yf9LkEEsqYrUZfC7eA=;
  b=jJGMbemxXVwL+1kd0SxuyIY3QmAyu4x0ciftNRytoaLT5x8I3uEZcoHa
   faFp3s0DMO8SmHIlLiVjpUmUfD7qGqLwz60IYNoQ31zZMwniCFDrwFs0G
   n2jUbIN7YByYhJ3mu+eJ5fVK2dxC3UaxKW//+AkEPm4lrLyW7Q15tkCaW
   KZYpfIacD0hJpeXKxMiOdmVnxqe25L7t0UVQ1gU/r/yxzqeTsovy4S5WV
   NwSaX4ULJKBml5c0RD8eDs4K3MvmjTokIGB+6jE8y0DOZmo/jSefHDM9K
   xnkyjcdE4DFZI7xlhGRVvM8Krba9yJ0gcHdKSzhKNRHmbLNidKygxPkMp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374660076"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374660076"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="829359787"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="829359787"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2023 13:49:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:49:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 13:49:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 13:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0s2g5dV5mVmppqfuPAKdLQx8i4bvy8FE6OC1aAPesfoXYeLgNtPcouIsg5l3QCk2r1Ilx34yq+xdHZsWFBOk8oDZ3Pfyk7JJfneinZI09NMAmNwJLR5MmrPxQiQC0jSynUWZEFIEHZC3tDpfbNPX8tpgoZt+TaNiSrDLQPalfY9TYqaeCUMCv1usb7yOkTxC+T2G3+bgnRYzxLtIY9DDK23l3LVjCsyye9KRO5e2f3yWA4UXbh/iZD4Ug10HUBp6e/0HEpYgKW90RAa6Nv7l7bQC3lv3pWewUCwFU4SwRYcq8FFNruA53EViy6cqEfsd043BZi4c29AhoXsXOQ++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIS0/vUNZWSluoIq8cpuVPdNK7xSfGFYG/HLfJUvVqA=;
 b=TvP4jU0D+fCp6xo5A8WGwXBxIcxbSMAqTPslOkWrJJDhCXRPdd7dmiJnLKWsqWJFwdtkW3BM6wCOxjs6CIk6HselGB00Ewgn2y3/U9Z8nEHlyhxdkMeYPfKTTYUP9qsojz5EQ2gtWU9FWQaWqDY2RjJSZbsK5sC+kkadW3GAWCGWP4MBGEI2X4TtF4EYeFVc5r8ONgz7WDJ7103LKWFtpnvKYlDJYKOXjP0UOHZYvgU5C3EhMa97ZUT3xUIRACS+9fmo+mHnESSofJOuxxjHhe5rXVnULeJuwkXdvxycLdKzRvy+lbUShm5lvGWMH/0BYo1o11E0U9CxxqVd6pkgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 20:49:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 20:49:21 +0000
Message-ID: <57f891d8-09f9-fe5d-fa85-0669f5e8d1ce@intel.com>
Date:   Wed, 30 Aug 2023 13:49:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Fix schemata write error check
Content-Language: en-US
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <fenghua.yu@intel.com>
CC:     <ilpo.jarvinen@linux.intel.com>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
 <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0354.namprd04.prod.outlook.com
 (2603:10b6:303:8a::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: c9593ab5-ea28-45f8-8c4b-08dba99a961f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JetIDskdtSWBw/AS1IPY3MOy0iNWU3rmWLymzN6c0b94uz+T+6Zyqu+X9SSh8/QeYoHh1JR3cBt0Ygu/TRwR1CkvXYtkBaSUduUKM5sFBS/tyF226/ZYyfTYfMh0oSGlVjqygrlQcpiHW/Iuv3+Od65YzejbgGeh+iV6P4UctD8vPUESXxoJu4ERVzHFdDDmGGLvxgFDgCzZcerhsw4Yck85x1eRe8LNYC/vNWsJgnl0mPyvRTVvCKWhdG1RUYYRCKHVOxGTsWAicpdZaP7glt7v9EPKBwi2+ue1uTeKWlt7D3GQFkv3Llt7IBqtqLs4frKvzGlRtuiwmXhtBpnTFUFXKicz8jDJoP9cBhkfQX7rvcNVwyddWjgTNEHfropOxe2l5iSRluuInCiprnFFjdAKUl0PTBX5WmbqNXkgeJXzMPHR2XWGsn8lTVjb+NfY0bP4m/6ipyNVoXbs+eKo2X3ks9YLP+UHttSKyimKDKIfaJT+//MBsf+WtZ6BH4pKIl+hH7dZDtXpzRLZos8IDTioRLhpZ9fr1KBLwZu9nPfZH7v9aLftHhMQvMI1hCyO04j9GutqEnV0Ij2u6WpTWaAwWkP5gkDOzRMkCg5FmW+ZLpkj4KClFWu1MiFrQXDsvz+XCMDjjGPzxQv5xSk6tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(1800799009)(451199024)(186009)(36756003)(31686004)(8676002)(83380400001)(31696002)(5660300002)(86362001)(41300700001)(44832011)(4326008)(8936002)(53546011)(26005)(6666004)(2616005)(6486002)(6506007)(6512007)(478600001)(2906002)(38100700002)(6636002)(66946007)(66476007)(66556008)(316002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtGei9NOXczMTMvY2w5VUtTMWZueU9ObGNMdEp6a1pCa2ZDUXZESEpRb0JJ?=
 =?utf-8?B?NzVZTmZqdmpETHV5V0c3MzEvSTdCeG93SW9XNXNMQjZSQVpvb0kwbGl2bm9v?=
 =?utf-8?B?dDZQeGU0STV3aEtiWWVnUHhaVnYrWFllNHZYNmx2b08rVGlFamtKbXR0TklY?=
 =?utf-8?B?SWF5bWxScktUK01iUm92Qm12amxPU1NzMWdrcXUxVUhOZTM4YWF3amFrb0l1?=
 =?utf-8?B?Q1NEYjZIOFV5SGdrNksrNWh6SHpIc1JxQk5Qci92eVI5MXg0UTR1Slltd2Z5?=
 =?utf-8?B?MkVCaDhHQjdKYVRwS0hyd3BrMUhNRzVpMFE3VjdtYmM0K2pVUWFxVlJIaDFW?=
 =?utf-8?B?Vlp6QUhmSUZyUUY1cDZMSnVvYzMyME51MUNTQ1NIVnRtNHFWMjNXTlo2MVJl?=
 =?utf-8?B?NitMdnVIKzZYZDBzWEN3V2xjdkoyN0NJMCt3Y0tXU1pOUTFlWlNjakhYclBS?=
 =?utf-8?B?Z1NQNFZUcDRmOXU1RDlvYnJyV1FxZXVMRjdCbWhmcUFHcGtGTzNRQzlsVUY3?=
 =?utf-8?B?QWppaEhDam5FajcvM0pxWVg5dEFUUFA3a0VqWDNUU1BxZXFZd3hib2RWT3Z3?=
 =?utf-8?B?NEY2aElFWHdSWW1vR3Y2dkpNYTZxU0FJZVNrRktjZXZBeUFkSjkwTkp2bjZm?=
 =?utf-8?B?UHJuSEVxdTZSZGN4SjN2b3BtQmxHM3JtVDVvWnRpSzZvV0c5RURLaUNwYUNa?=
 =?utf-8?B?WEZPRkt2cU9TUXg4NWlSSDkySVN3cUJBTEFORWc0WlNtQ1Vmdm9sWUs1MVp0?=
 =?utf-8?B?Vjc5cGJBbUxrQ0NCRzdwUEdlbGk3YTJrQmMzR3p3d05vQnpCZ2NVczF6OUJK?=
 =?utf-8?B?dVFybzZ6eEhDRTJUcXhCSUZKWVhlV3JWSlhmVnRGam9HaGtQdkUzTjBZZlNo?=
 =?utf-8?B?eFdyNHA1TG9mUEhzY3huV2xVejI5cklFY2FwaG1UNThkMXBUWk1FdU84T0Vo?=
 =?utf-8?B?YmU2THlJVTZGYWtsZ2dZKzlPSmNJZTVsZlJwODROS3ZxU1hzeGFnOU9YaXYr?=
 =?utf-8?B?YjRaWlFHY0MzNGVkZzBhTDlXWkJnZjVWVFpqR2ZLRVZremtGTXlSUjNGYnE0?=
 =?utf-8?B?cnpkK3B5QkdVbU5WajFOQzd3eEFMck5sc3crR050eDB5R2hxZ3lSa1MxVFpu?=
 =?utf-8?B?Z2dsbXVreGVNOXJiL1hKcHQvWHd6aWNFdVE5QkNhaEFXSENjbDFVaUM0cE5w?=
 =?utf-8?B?b3lhRDNNQUJMZnhzU1Y1TUJEQnM4UEVTV0RySGRMdGVGSWNhOFRheG9RdEZn?=
 =?utf-8?B?UVp5d2NCRHNza0Mzb3J6eXlKaEduOWFJUVJFUXZLL3V1MjY4TGRwK1lUYUtO?=
 =?utf-8?B?dXlXdG8vclVMNVl5eDhjYnp5L1QvQUY5aWViakd2RjliclRpS3dLWlNvQ2Qz?=
 =?utf-8?B?dUJjemcxQTQ1bHZPZ2dxckR6eEkyMmR1dkxmTXlnVkkrL2Fld3p2YVVEbS9C?=
 =?utf-8?B?NloyMlBaTG0yalFWYjVuMk5PYmZlMnJnbkU2N2VhZ1RlZW1vVFNadkxBVjQw?=
 =?utf-8?B?bDJOeGc1dkF6NE0rMm15aU1pRXhTL0kvZjYwbncwY2tGeElrNFgxNC9kZ2Ri?=
 =?utf-8?B?VHkwN3BCd2ZXVG05dzdMaXdnUG9BRFpzbFhyYnZXRzdGT0tNWG1BQnVXQ2Rr?=
 =?utf-8?B?MFJ3dFpjaENiL3JySnZLS2xZbHhQK0RieWlXcW5ZODU5N0JZUXpoaUtYUTRm?=
 =?utf-8?B?RGNHdG5GWHRaNjBHQ3FiQ1FFdGpzdUFQUnloNHdMRHdoUG1saDRLeTlRbHVs?=
 =?utf-8?B?aW14Q2tUQ1JXcXpwdElPNUVaeUhBQ0Z6aFJPTE9uZmR6aGZtelZyUlo5NkVa?=
 =?utf-8?B?bGZOWWtZcjkxcHFVVjhERnpJR0dpZXhVcWpjTzlVMUlUUXY2NUFqdy81Z2Jr?=
 =?utf-8?B?eEN5cU4rL1J2cTV6Qk85Tnl4aGtsTzJmMmx3S3BQcGIzUFRpd0puNWtYN0h5?=
 =?utf-8?B?NEFzU2hXVC9IbUJSUGJ2OVdRbnpYblB6eXd2WlpEaFduZmg0T0h6QW9wYkxv?=
 =?utf-8?B?M1JpTFJieThvL3lmSGJndzlHa1RiK0RreVpsNmdPY3JmZW9XUTBqTFBTTVYr?=
 =?utf-8?B?VE45QmY3MFFLWWlFcWJGbHB2dUQ3cEtiVHIxQ2UzNVdIaGlDZE9GQ3lWb09S?=
 =?utf-8?B?NFd3aGp5aGVFN2hzZGQwNCthNDVwR09hak5ZR01DS201SmdpanZFTVQ3WmxV?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9593ab5-ea28-45f8-8c4b-08dba99a961f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:49:21.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FiS5uox8nzKjWyOXz2ntrrwX53Hv/YefHYC8+3mC7Md3cMsM3zv0M2kFi/nS3kGr893y+NjVpWDUrq5xQ/B9r4cN8wP9uNlHaynEEuSx5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 8/28/2023 2:56 AM, Wieczor-Retman, Maciej wrote:
> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to some constraints defined by what a particular CPU supports.
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
> Add newline to the end of the schema string so it satisfies rdt
> schemata writing requirements.

I am not sure how to interpret the above because existing code already
adds a newline to the end of the schema when the buffer is written to
the schemata file. Also please use "resctrl schemata" since RDT is
Intel specific and does not use schemata terminology.

> 
> Remove newline character from the schemat string after writing it to
> the schemata file so it prints correctly before function return.

schemat -> "schema" or "schemata"?

> Pass the string generated with strerror() to the "reason" buffer so
> the error message is more verbose. Extend "reason" buffer so it can hold
> longer messages.
> 
> Changelog v2:
> - Rewrite patch message.
> - Double "reason" buffer size to fit longer error explanation.
> - Redo file interactions with syscalls instead of stdio functions.
> 

Please place the above "Changelog v2" snippet below the "---" lines below.
This is text that should not end up in the kernel log.

> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---

(list of changes should go here)

Reinette



Reinette
