Return-Path: <linux-kselftest+bounces-1871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B1812109
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577681F2173B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41DC7FBBA;
	Wed, 13 Dec 2023 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeRI1wtK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE11106;
	Wed, 13 Dec 2023 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504618; x=1734040618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2rv0iJz9V7L6S/S6IikCfcBErFHYMQIj2660BI49LHw=;
  b=FeRI1wtKuqkBgS2kMUsdKC6c3Quil7KxSowIdpPNiCIEhBzGCIVecF1L
   WGX+Gvj+ZvJg21VkV/yGQD/gKvq/oDTztvcSAaS6vmsmF/gvSvwr/ovPW
   RhC9vToKHLyYaF3UjLuHOSuy691Z0mBrZVL1xvLbfra/bbVb1vMuTDZtk
   O3kSMd8fP7NmyNjaJR9c/ckU4H49i/ILs2TzhgCoWzH2M/nYGAJl84ror
   4W/SpOiMcHhRy1VpaGfb2uUYv9Rd29ku0AE8OZ8Vv6ZrEWJzcP/+jFXEv
   b6MXt9TUd6dTLeAuhN31Bg6EWTnvVlf3h7qWP0GMu5DvYEL6GUfJX9hXG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392208025"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="392208025"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:56:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750280160"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750280160"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:56:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:56:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3Y5JjGPxXsTrk0dPNMJuRdoecvQZD8KOPiZ4ZsrQ+qRQaM709l4pW1J541m3VowEaz5n6yKA55HMPM5sYwAzebQ4F2yV3xWJ6dr5yqQwxAHLXYezF7lEiEdFmDLm+lodOdrjyGPksj8OzQdA+WHmY1JHaawZVVrmK80wmgox6updQ0IJlETUsF3RU68te+PFRXgTwHIgE3ivEvZaaQLzOzBGqoGwfLHKADdtvZIlDekGMnvfmofpp7tOzklCkPowcDYJrpkiRneIWqsbKdgOOBe/NkjlOHrX6I2iZD2yCPA7/e26PTrRcsEiy8YwVAJ5aIlc+ybyLgGXu/3rmtzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbh9kIUNayA7Jfn+L10ARlWHjaK3ofcAmn4jmjunEw4=;
 b=aYVXABTmz7Rbq2PfTSmNAwUNXTVKF+0EHMP2bYxJPYIjbk7Iad0RfrAd7IcGZOL1vYbVwzSWhZ94iJrA6geYF9oZmyAGqxIrxnOnFDvf9akPSfR4OeZrv0mg10yNodv8CkndkSax9gJnV3ezIYP8yXxpADkA5uEUVu7Zgt3tsvr5hyQI0+RxdExUSM+D8JRlqpdhLWucz+a7YiPLRokOoRp+7J7L7Z/V/1airMTY+fYzGVz1KP7FOq42bR+rtP/KSlpnJmVts2ruvNGjTs/t0FNpbyFKFepsRutZvS4VSFbge6dRiNpkc5iiKTL2R4ah0bbaTvX32pPH4JcZF3BHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:56:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:56:46 +0000
Message-ID: <1d96d1c4-d37e-40b0-b343-b143efd6440f@intel.com>
Date: Wed, 13 Dec 2023 13:56:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/29] selftests/resctrl: Replace file write with
 volatile variable
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-21-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-21-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 45983953-f710-4425-767b-08dbfc266676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACPvf9r9qCNQ/eZo6QVjjhU7kZ7YybpUHx0WQMOWXsXaeUgmZcV8jdAG9N99jSWUZbPHArettDE82llkWz5LRMje+dwGqzdfvpTtcXa2DV4e1ntgxdzzvs+/87qm7zf9MybWdR2tp3TjzMgmYK0OO4Id9SfpP8YeHxaVh0QZ1WyuBVF++Hgk+sRsJ7nFXjAd3tZkyu6a63KDPiwYc1wmrCSM4NvFtTox21ro8xIDoYvh73AywMb1m5hUI9xT9UCtSewTecwAzhpvyx2QxpBNfmO2y26Rb9Tog5fSIVNyWBdclvvBTCb3tu25o9/fE8hxohkDoyXUXbMkNKOVNXo8ek8ajLcpagy447Cp7s5o5EluB1e+IgnB3ZvJNEQcKU4CGTxJ3OrZ+IciZVOD6jMRnsv69xsIlSQJi1GISvYx5YETS/4H3XMrhtahPhvwzF8IlGUeeK9+GEOizyUQFfJ7s2I9X5dwzBVaaaOxqNxjp/j8a42UshL2WXFHvqz5lotJV8DriTaiSn53EnsFGe3FmQWkaZvvLVVkxkpkEBcaSULYpNvKMH5CFhC/CBdqB4A2eWWO6qYe60lL2jAfrHRlG1k/39tkd1t2yPflg7HiN9RQBXIflKvNuX7+YA3SHzkTQl5R5WRm+i9R+P3JvHllCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(2616005)(53546011)(31696002)(86362001)(82960400001)(36756003)(38100700002)(4326008)(5660300002)(6512007)(6506007)(316002)(6636002)(478600001)(66946007)(66556008)(66476007)(110136005)(41300700001)(44832011)(8936002)(8676002)(6486002)(2906002)(26005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzY4R1F3VUpmcXA1ZzMvNkhGN280OURDSFJJRVkzOHhNdkJqYXMrWnIzQXhO?=
 =?utf-8?B?bHZYZ3FlejhkTi9qVHFEVVRQSXp1bHRIN29UaEFrS2hwanRVTnVRR3B5RHQz?=
 =?utf-8?B?YUV2NUd4Zlo0Y25WdnlQTVRodGN4WjZTYjZ4LzNtcXFBSmxVakRzTlJXWEFu?=
 =?utf-8?B?NFZaSDV1amxBMGdFYmRCV3NjMy9SN3lsWlJIWFE1K0RmVm8rUlpwamRnb0M5?=
 =?utf-8?B?dmN3WFkyWDMycDZlSS9CaGRSVzBKZE5DdEthaDJpcFFPNUJIdHViS3h0NHJp?=
 =?utf-8?B?OHlqWG5uekhSK0ZJVVF5Y0M2UVEvSVVVQW9QYnVzM2srZ1RVUVVXVWltVlRN?=
 =?utf-8?B?NGJtbjg0OHN3RWJQMTdzYUVINkxEbE9LZllBWEdFYVgzWTdieXRPTTI1Z0tz?=
 =?utf-8?B?aTRwdlJvTGZpUEdhMEVCVm16c2FnZzdOd2w3VFNmK0FrRTVOZDJCdFR1TGJD?=
 =?utf-8?B?dGx3VWc4amZrb3pKSDZJZHBVVzEzZmZaN3hQSmpWNW0rUXRJVE4zRDBHQVlm?=
 =?utf-8?B?ZnNsZ0pXdGxrNDZDQ2hqd2FMeWVkRnRtOFBySHFidENsWHN2R2s4Q2htTXox?=
 =?utf-8?B?WmV6K2t4NUNXY2pFN094TEZVUTgrWGhwWTZOZ3dDblhtNk5XaitBdGJsaklZ?=
 =?utf-8?B?aDd0RzhKSWhBTEtrTm0wNmxTSWt5NEhIV25qRjU5M1BzaGRxKzJacXB4YVFi?=
 =?utf-8?B?UUMyYnNVRm9pWjFwQnZoSEhWNlkzNG1OMXlaa2FyYmRaMXl2cG1vSHpRQnlz?=
 =?utf-8?B?ck1iRnhwd0tsUk90amxuOXd5SUdBRWtzNTRHQUlEWjhXNFhubnYwcmszQVZH?=
 =?utf-8?B?Ny8rL1dNS2dCUU10SHUrTmNUYXJzOHFkYlZpOGl2L3daZW9jWm1uQ0JVMFVK?=
 =?utf-8?B?dGJ0cVBYbGE0cUc3N2ZNV0h1SFdtWHVDWDl5d2d6VEdXL1Z1VTNMOUJ2R2wx?=
 =?utf-8?B?VVhTZlBZcklaQTMrYVc3UTN6Vmo4dkJyN1h4KzlaMFBDdkZ3TnIra21iWG5L?=
 =?utf-8?B?MlBrcHNnK0g0T0UxcVdBUXdhS2FlYm5Sd0oxRG9BZWVPL3RkRWxjOFJtWExW?=
 =?utf-8?B?RlBoQ0dic0FyRU1nMHN1TlY4elZUb1BqTUVPeUQ1NFh6R1h6NEt4QzJoMlZH?=
 =?utf-8?B?Z3Vsb1AxWDlVeW11WmlrNzNkTG9zSUcyZkQ2enRnUHB1Q1phTTVJRXhsdHZh?=
 =?utf-8?B?RkR2ZkRsYVBHL3g3Zmp0NW5DRC9pbEdtZTJybHlWRnpSM29vOFM1ZDBIYmMr?=
 =?utf-8?B?K0VMdFd1MlBaeTNKNW1ndEoxNUdjRURkeXN5NGkzZ0pLQkVWY0dCNS92bFpE?=
 =?utf-8?B?bHlsZklXK1l4emJOazQ2SlI1N2puejQ3dlgycHZRTlpkUnNyUGpjQUtvUDhI?=
 =?utf-8?B?UUdNK05sUjE5RjR3bEttcG93M3U2ZElWdXd5eWsydkdnbHN6RmxxV2lHOC84?=
 =?utf-8?B?OGMwdDV5K0d6MHNWNkQwRGhtUmRjTktzbUJrZE05WlFDSnREWEtRcDd5a09m?=
 =?utf-8?B?TVNWY3NaVWx5SWVUM2lZVVVOb3lEOW9DdzBNQklLbG9VaTQwUVZvMEZST3ds?=
 =?utf-8?B?a0dualkwV2lBMFZLYkc1NmxVeDJ1ajVGck0rbHB0cjROUFVuUGdFY08xa0JC?=
 =?utf-8?B?enh2RjFwWWdiUFpjQ1Nkc0JRMkpSOU92RjIwUVlrN3JMZmlWS240ejgzbE1v?=
 =?utf-8?B?eDZHMDEwZ1BPejBRTlZ5WmxRV3Jxc2lkdjVnc2dyT0dBWG5GdlVsSEI5OWdh?=
 =?utf-8?B?ajRWN1dGczh4amhYbW1DMmFBSVJSQS9pcG9MVHhOWGluVTlyZ0RNcUNIYW5Z?=
 =?utf-8?B?MzV1emhDNHdJU21nNDFWVXJDVHhQODdpM0I4Y3NReXpnQ2hvQzlpcnFLa3Ry?=
 =?utf-8?B?VUxzWWxUb3VEL0N5b2NhNkhVMXVSbmtYeDJPNFNoYVBYMVZqL0RBbVJ3bVB5?=
 =?utf-8?B?dDI4SitMWTRBZ0tHbGdEVmxYdWNHOEliTzN6MkVnM2xCNDY4NVE3bXFiWHdO?=
 =?utf-8?B?VHBSYVJQbXQycnJ0d29sMDdjVHVlSVIvK2JGeFBjT092NVRyV3BOUmFTZHFJ?=
 =?utf-8?B?V0JBME5kalY3bDNCK0pFMFRLRFdTblBGT1Exa2RDZ3dNSW0rZUNzWTN1V2VO?=
 =?utf-8?B?ZmtoNllyWEJkakpmS3dmdFNHZlhJYUx3YkdkWGJ5ckJvaU9rRGxpMXhFR0FG?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45983953-f710-4425-767b-08dbfc266676
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:56:46.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRWly2ybgGUxWfOtVWZ7YOor4ea6cuB4Gtewlx33RVuJvKLNuwDot6yigD5xHC2Y7leR954oJ+xsTppm/0aSXlStmr6g6oyAxwK8bQli76o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> The fill_buf code prevents compiler optimizating the entire read loop
> away by writing the final value of the variable into a file. While it
> achieves the goal, writing into a file requires significant amount of
> work within the innermost test loop and also error handling.
> 
> A simpler approach is to take advantage of volatile. Writing through
> a pointer to a volatile variable is enough to prevent compiler from
> optimizing the write away, and therefore compiler cannot remove the
> read loop either.
> 
> Add a volatile 'value_sink' into resctrl_tests.c and make fill_buf to
> write into it. As a result, the error handling in fill_buf.c can be
> simplified.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

