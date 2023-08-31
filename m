Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3397578F48A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbjHaVZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHaVZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:25:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF4107;
        Thu, 31 Aug 2023 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693517156; x=1725053156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qol5wK7wVW9D9DiTIKQrFDSku1UfMGCpW8fZ+iDXPHI=;
  b=TE3CRPuwUIGR1eNJJiiIeBLpWroccM+xlP5Mcb3h+oJlOR1j0ZMOjEzu
   fGUUXGFYAah6+NyMOdz6L4G4/FUnUpWdOeg3+BTinB1lnWEmVfIPmCbFU
   Z1rdityExpKXcmazsUHEhPGBgdPoppqDUjZ662S+rsLBa38nzJeuCbrKa
   rwsBmDLj+xCN1rvh0KSU7Q0VxP3XQvHirRC8GWdUct9kltDfVxIqY0HYu
   GbyWwS04cCDDAt3g29E5o9f4c6VfwWmrszwyudFS/VpOpHDXZRyvEWOJG
   WZEhEI4cwmN/QtOhpYU7MDqIIopf97k4PFEH+aPkB2DJDKywQJPy+t4q1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407065159"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="407065159"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854446015"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="854446015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 14:25:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 14:25:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntsXFRAIABdkSWjGnllnAIfegnnr9kTaKSphBsOhE5feWTQg3d79zpayupo01lM/4pu+P5UIy8R6oCX5fsQjAq0MhI/xLIbdAMpOYPs02kefojdgE7aimYmtMoPZWmxo3eNo04xLaK7GKfV7KN8ykjWasbKP5bJYelr2VtysV1+aGN7LfwpwJJ7/Fne82T1yE/1m49tHe97IKTShJYaL0royRVCOvPizSsfOAFb4NEVz2ZvsyJJm2ZO8RLAotZq4sNJmQU2HcmCzsXAtWchv6XBGS3WOhfEEyodIFB8X93NWfOLyLHUYzn6hnCi9h69temd7QBsjmYjthlL3tCLuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgH9hepw15nkL/Ar9ocDsin+/r7FyN1yaI4AjAzr7Jg=;
 b=QMv58CT0Me1IR6d+/vRfjZF5/arBWmEeXygh+DR5DbQPPjRFbW3QJ3BHXQnblbi4Py2bxeaLKAdkxbyegAn+VHWhFxEjS2hpSWpV+Pw1OCXevPc9rfyxvOBW3Pb7zGxSIvUlRSAPA/vhoSpG1tJlT2K5jO6+nStDtk3yOa9A+i3Wg40jUUpINprMXnmyDygmj8tc5qaGx0bc8Mb01xYH9FwwRZIleQf7j10kBmQ4kKDzKY8XBVjdfHNtVV2bCGIg9K/DhkQRoPnXxtIPILuqjHL+ZusMDQwKjGnupJADGDrOixG5R/cY8TklvzotfDgW3QKfkc25G6CNdwbARsUUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 21:25:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 21:25:49 +0000
Message-ID: <3558a06f-a6c0-9a60-a0f2-c8cedfb7f763@intel.com>
Date:   Thu, 31 Aug 2023 14:25:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 6/8] selftests/resctrl: Make benchmark command const
 and build it with pointers
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
 <20230831110843.26719-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230831110843.26719-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc41811-15f9-44fc-7870-08dbaa68d8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfW6JiLHstehVfW4GNekPTicEnlq/SBm7mttBTEr4R8Qhhvd3A28boY9wirLqDe9CM6xBLlYKBhr6lkyJchyiBoXOH44kHwZUFAiotwvhZM/A4bhKysMGMx0njTq5xZuiNtKqh9pApFk0/FGW3VmDvxhGQlcvNlprS+hpPG9ho3NeGvr+NM0hq5jseUcfe5TKKA49mujN0EnACYg/Lp0ZGsm6eE4hEmSxMP//Ug8iBdHdttFM6Hk4jQQrjGAg1FqKwOREOdQNiXzSXD1vNQLwlmyDFYas/9QEJ/YLbyVwJM+HLofuSBge/IYIIpCthGnbVN4X6LMrScaKfYS/NW6+EmcszcYMhK0o71MFQhrdfRNojdEsLzSKDj8T47OHuvhiRYGfCEtQM5ELoGFoIkPsD3AaakWLW6bCN8NnWswK9yM84x0iParkz4SZ72CxMrNKYxriiDPlHhW+OcJlP2fSUDizFb3qoaSOI8zW//dakSavK8MpKJHb9RHta2FE7Uwk68oLyk5VM9kLeMcn+IuRoskOZgHsMBU1I01d8v8hTehbGpFAAoFwJRmBzWaDfoyXixvN4pB5OBo6sI8PWohoT5NbxUf5uC44R+BdzSekSLfjPEnKF1sGIeXj+WFD7gz8uV462PBTPp7VPWigN0XLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199024)(1800799009)(186009)(4744005)(2906002)(5660300002)(86362001)(53546011)(316002)(82960400001)(478600001)(31696002)(2616005)(4326008)(8676002)(31686004)(6506007)(6486002)(44832011)(6512007)(8936002)(26005)(38100700002)(66574015)(41300700001)(36756003)(66946007)(66556008)(66476007)(110136005)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZiS1BWMm52K3BocjV4TnNhc3ZGZjFGUjVXTVhRSFhYVGlYK0h0QTFjZ0V2?=
 =?utf-8?B?Z2MvTWRqVUJZbVNXZk1hR25RWDBac2JkTHZKZlBKZlpTMElqYWorTW1xQWwz?=
 =?utf-8?B?WXJQZmJqYkE4ZUQyVTNac2VDUUl6UjR2WG5jK2VxeGwwa0dpUFRNQjAra21P?=
 =?utf-8?B?UTRwVytRVnM0cVdMSndtakRmNDBSRCt3WlByQlVCTlBjeStYMTdwUGJ3SEd1?=
 =?utf-8?B?UFNUZERVbkZnYTczK1BYalNicDFvdk5aTnBwRlBMYzZUSklWemEyT2RYTlVG?=
 =?utf-8?B?Vjl1SDJBbnVjWkNnMG16UUg0R0txdk5maFRMcTBvZHpMc2RrV1lwNSs0eTkv?=
 =?utf-8?B?aHFLZERBaHRMaDhvd09wVUg0ckV6UGpBMzNwRmxiQytVekVuV24xZmlveXVD?=
 =?utf-8?B?SXJMbEZrdnVDVGx5UGYrcWVRTDdHbXhaVThCRGRYeURqRHgxMUJHS1BoUysx?=
 =?utf-8?B?SzgvakIzU3ZsR3RjcmoyaFhLVnNsaTNtV1ROQ1Q4SzEySXBnc25FaW9sRTNq?=
 =?utf-8?B?WkdMRGlKY0Z6U3F6djhqV1gwUjQ3Wjh4UlVsRXJGbjZZc0xWbHpzYzJFWWU5?=
 =?utf-8?B?cXU5cW5Td2xGS2NZSFJ3QnEvK204Wlk1RndQWVoyV3RubWY1U3ljazZNYUJW?=
 =?utf-8?B?dWJZeVlyT3J5THEybmN2TnM3VERnQUJhTEd3eFNZbTJ3aU54c2w1WWFxMmxz?=
 =?utf-8?B?MjJKVncyQTJRdWVUaGkwZjJCOENJMDJldUFHcyt4OFFZaW9EZlBiQnJ5Q1d6?=
 =?utf-8?B?SCtmVTFlWW95V0pEY2tYOVNBZzhBU2VaRGdiaDUvYUNBQ1Q0NHdBMVVabnZF?=
 =?utf-8?B?M21DOURzUDF4TTdpdlVNTk1rUWREWitRUnQ2KzlCc1V4c1NscGlIeG41MERP?=
 =?utf-8?B?L1pkc2Q3bXVubHlVaFBvbWVoSnkyc0VGZkkvM3V5b21kUjB2UmlIZ0dRQUxE?=
 =?utf-8?B?dXF1SFp6eXJLRzZ5citlSGg1L3VGQUhJSWNjK3lvenByN0pQd1pIODV6aW1E?=
 =?utf-8?B?SERvenhQdFRRTjZJUC9CVjRnTnpBU3kzWmFMV3J5aHkvbkN0OFBWTldrTzBv?=
 =?utf-8?B?R3pETE9vUG1IaW9odnRFOU9XN3FjVFQ1bzE5clRKTzhBY2dRa1RVdFBYaEhO?=
 =?utf-8?B?WTdZWmhTZW9pNWR6MUhiU0RRSWMrWWFLY0NPa2kzVkJpSzYvWXo1b3lJZXhm?=
 =?utf-8?B?VVc3M096VFVwMXJIQUpCRFl5VmV5ekVaQjcvSlRvcnJWUTY2cGxwT1UyNzVh?=
 =?utf-8?B?UnVpTnhjVTRMWFJwRER3a28zSmZ6VVU5VG5vb2lXVGlubmwzR21EdS9hbEh5?=
 =?utf-8?B?S3JPZnNVZ3E1TTlsRWFReVNONWhXdDhiNkRMMXJQS2tmTlJOTFBOV3JpdVly?=
 =?utf-8?B?M3podkFwRVQwMXozTisyK25oZ1FqVDdlZU5iYVJaMGFwYXc5aGtNcko4eUdr?=
 =?utf-8?B?b1o2amIvaVc4SDlZYk9TRjV4VlJwMzZpQjkvdEhWdVBGZGxpOVdQK3JiL3BJ?=
 =?utf-8?B?SmRxUkpuL1V4RDJBa0VhTU9JaDZvckU1eVFSWXJJNGU4eFBZWHlwN3FUWTZt?=
 =?utf-8?B?Yk5wdVJmS1ZoWk9UaFFJYU5qb053dktsRzJUblhoMTI4ay9UN1I4VEVCMWIx?=
 =?utf-8?B?di9QM2dFN1o0ZDZYNnFkL1VzeFdxUFM3UWNib2hSZ2NZajVFM3RTNGNwMWZY?=
 =?utf-8?B?Z2hwWlRKT1BmMEF1ek8ramVNRkhvZXAvTG8vT3Q4ejhBb1pmSENsdlJWVHVQ?=
 =?utf-8?B?Q1dITVd6K1lZT1ZsaEdnZVM2VnlLZWV1RkFoOFh5UVcrdzBlZHY3cnVkR0RX?=
 =?utf-8?B?NHQ4TU1Ec0trZWhZRUUzUG1tYlgyY2FyNHBwYzFBMEF4T0QyREduakVtcnAr?=
 =?utf-8?B?aTVhcHM4VDVoY1BidWxqNGhpUlJuQ1o5T3lwNDBtQnpkbjhEdnpDZW9Bd25K?=
 =?utf-8?B?MmJPK2F4azloTkNOa2lzWkRBdjhYU1NBM1NYcUZZd2MwMFV6TU1VdGRWWjFK?=
 =?utf-8?B?SFNDWEJFUllialVucFNjY3FLT200OGF3c3NqVUJnemFYOGFtQVlJQmtHaDN4?=
 =?utf-8?B?TFlVVncrQXJpeXVtVjE3OFhNZzdvZXRrSVVQRVpHc0VUdlBFQUFFQ2F4WkUy?=
 =?utf-8?B?VU53RThsNU5nN2pxNFlvK0ZpQ3VIMXptdEx6a1JuckkwMWhzblVqQk9vbTlq?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc41811-15f9-44fc-7870-08dbaa68d8de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:25:49.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWq3ytIGoQ74ESos/JGyjpfDU6nTxXDRyOLsPgYlD2uzRfjDve+8N4D7b8OuzfSuYUdjTy/l72YtT7m+wK3ZTF0ZddlyLNJRFVfp9alEri4=
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
> Benchmark command is used in multiple tests so it should not be
> mutated by the tests but CMT test alters span argument. Due to the
> order of tests (CMT test runs last), mutating the span argument in CMT
> test does not trigger any real problems currently.
> 
> Mark benchmark_cmd strings as const and setup the benchmark command
> using pointers. Because the benchmark command becomes const, the input
> arguments can be used directly. Besides being simpler, using the input
> arguments directly also removes the internal size restriction.
> 
> CMT test has to create a copy of the benchmark command before altering
> the benchmark command.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
