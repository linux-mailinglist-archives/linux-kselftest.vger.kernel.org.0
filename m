Return-Path: <linux-kselftest+bounces-2844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CD82AD53
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 12:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED1628A45B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F814F94;
	Thu, 11 Jan 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRiVqEJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCEA154A1;
	Thu, 11 Jan 2024 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704972367; x=1736508367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cm+Rl/9wsRSWeMgoyVofEAMpf2k5da29hv/gVIN2sKw=;
  b=TRiVqEJFE5+1hz5/3SdAHvCBq9c34u1mp5BQKq7XG3K1UYH2sHcRzCIU
   6wIZSDrrbQ8eeEzjqCWExjJL6k8nUeuJvX/+dyZtaCEn2iWWJSw8T8CGH
   XLAm8f9pF+FspcY0MLOX2VzrzEggi5X7JhkXSNWmzO+c6mzb4GXI4HF0G
   QZpAUwjQHsL8YD8jXSCLnAFaFbKmXaZEp3kWAtnUjyjR7UHoIVjpF0QMi
   jY6yCijG1FJQ9cdm9QJwVUmF9Iw77qHaEhY/G4aVYkiNzJBSXF7axvzwX
   +Cw8dPmuBQT6qG/OXA16OTX5hPCyfkY96ArYOlBCEq1jUJSa8tJddibrK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6179083"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="6179083"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113803847"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1113803847"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 03:26:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 03:26:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 03:26:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 03:26:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpivI7i2rfTzAFDTr7lhXXf5K4vloZ+fj7mxpysgc8LITSzBOFfPz1AUjOOCO3ooPdshL17yTBkDBXJBYsbuEsKkZFjP9YOmOq6oYFpTShW+jDlvG43bDx2jp4QDM7rUsoPionVWLUvw9GvIQDWkkFx0/hUgIwnCAsy+eU6wGsnO+wrRrxJ1ZnRXjt+imZIKvkM5lcqrhFOJRboMm8ZM7CfM+VVbl7KvY/lN9QIwPkTXnh0NahZPGKhh4MxmHFWcAqgC+7s104/X/BrkJlwurrkeExdgOdMf4AF3ltapcQGDb0unnIs6EHrC6aWqI5U2+UwIovrfrHSEJ/62KQLQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KLV4N6WJAKP0RxL2Ocup9IPnFe55jWSYEHAOULIF1s=;
 b=JJfbRzTlRrmzV4lsqZJ69eLTZ2uKa9r+qpNit6hbLTjuTit/ErOA6C/mBZQJn41AZKQ0Jc0fVDUYb4UVKMLicdyDC7WqtAyE2G5MABz6KyQDYf3X/+Ikyfm88tbzMTShBME+T56CefWMXVyqzrsS4hy0JMsc5Y8PUonggb4XGi9J1EIhbeO/vavA3BuydeSt4M0baugIFtt++yIbqS/6pJow5VyUWtRrVDsZtuDZuHWeKnAewC9w+WZzkyT7778H+QgNKfieJAMeoR36K9lq3azCJUt+NwbAY5MsdT4Pw3Al8MBvQBoN+i7WtapN8wAeV4ItfGjoaKcI2STIhQ+RsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 11:25:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 11:25:58 +0000
Message-ID: <7156e5ae-5e45-43d9-b6d1-fe3ce4218338@intel.com>
Date: Thu, 11 Jan 2024 12:25:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] selftests: net: Small fixes
Content-Language: en-US
To: Benjamin Poirier <bpoirier@nvidia.com>, <netdev@vger.kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Jonathan
 Toppins" <jon.toppins+linux@gmail.com>, Joachim Wiberg <troglobit@gmail.com>,
	<linux-kselftest@vger.kernel.org>
References: <20240110141436.157419-1-bpoirier@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240110141436.157419-1-bpoirier@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8494cd34-8027-4856-7260-08dc1298155c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASGZ9sP2dmI5BYb1bg3e6ojlIfrPNuSJUAA/mS2/cRBN3SIa49WG4fItphhr5pDpcRuQ2wkVJ1bos/BXGvv+zF3w7qVyoZVcjVwV70vcxvbRco8NM22XGPWEkktmbr+GQeGMW/lIdtVpRwsFpV8OMMxpopv4CdZxBXrdVu6YOSIOHDdzy/tDDwGo3eKGXxjWEdjODA63BwmyuLRxce0eH0EbzDlEaJdQW+CST7tpY9UbRRrOQWeWoylHMmrLfoGk08lx4lZrLXXmj4Rz8tHjx0r5FpXAUM+wk2wGeVC642S5RnorDE1aywgUJO9oWN5mdnD6Im+suOSMRlg+mw6lpTlpqUordO3Uug69eOZ6+b8/VSM9xMMxOi15cBx7KHftfu6Gosy1HChE69bIrEwqb0G1c2VpZqjnbJ2RnAxLZ1L2cdWQMQRskRFhZs1cYZwBxBXrncu2MeFpPj8arQuPul2mfKmjc2PTVrMLdDpZwPdf2c09hjITjrB0xQ9gxVVEELTjvQ4knOFMbiy/IRKxqIKF72HEAvqdqxDDtTE1ugXxP6F/vUVhgOk1h5A6G655A2R9RP4OCwOSmMUl5M+korGxrcBe254V0WCVeHWSdHU7werAf1sTd5Cdy26B09HT0OdpZ91E2aI4Fv5g2QFTXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(6506007)(6512007)(53546011)(26005)(66476007)(478600001)(66946007)(2616005)(6486002)(6666004)(31696002)(82960400001)(83380400001)(86362001)(66556008)(966005)(54906003)(316002)(5660300002)(8676002)(36756003)(41300700001)(7416002)(2906002)(4744005)(4326008)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZVL1pKcU5LTTZYem9VUzM2Q3hla1N5QjZpdUFEWHlTL21zbng1L2tpUzJw?=
 =?utf-8?B?dlhjYVIzb2RsWUpCc1l3SXBJd3hhNmpldk1XSG5UZzkxUEViSnE3dTVBMTVI?=
 =?utf-8?B?ZmtkcDA5ZVZoQ3NIcCttR2dZakZWWWNSdEdSUzZuYzgyODQrQnZqK2VVdGN2?=
 =?utf-8?B?N2hSaC91VFZzRnZHMEw5WVJyMDQ1VUREWmNJNmVMTmJVT0N2anU5QnpIaVUw?=
 =?utf-8?B?UmRHZ1p0UlJGVXYxcG40QUYya2VoM0pKWmJZblBQQmxMYTJlUDFLaGFwT0FG?=
 =?utf-8?B?TWtWaUVvT1pDZHNGVGQyZHdlRSsvdno1WnE1WGxUVDhaSVFPR1hyYnVuRUIr?=
 =?utf-8?B?b0FuVjYrUkRMTmFCbjhZRXBNamtuQUJ6L2k2TzZIYjdnUkprUkpQTlZiUWFV?=
 =?utf-8?B?VUErUGZqQUhhNzd0blE2eWFTcWFDaWRaeE54RDZOMzdnblJwY3RyeVZNclYy?=
 =?utf-8?B?U0JidUk5QmwxeHlST3prVk1IaDFaMGRHZjY4RzhGU1RoSU5FQStHdERoNFZG?=
 =?utf-8?B?WHFqaDNoYUFRcGN2YkJiQW5pVFpmWkNndGNTeHVKSWFVNmpjSWQrOEhOaWNB?=
 =?utf-8?B?Wk5CMStwL2NJcFJYT2xxeGlvWU9oYWdISU85Y243RUwrcnRiMkhiMmF6dW1I?=
 =?utf-8?B?MzRBVFpCSHYrSWswcUNzSE1PdVBkUVpScnBlQk54TlNiOHZSRnc3RnhTUGV2?=
 =?utf-8?B?VU9ickc3Y0tDZVlxMWhaNmZPcHVJTS81QUdFd0VGcjNFUmV5T1dQVVVIQm95?=
 =?utf-8?B?Q1JvSEp0b2hObVZNblZvNG1sbEl1eHk3ODRtZmVVTzNZQlFkUEtOZTBYc09H?=
 =?utf-8?B?SVBZNEhHY2lFaExuY0Y0OThGRnJDRDI3dHd2eE4ydHN6YW5zWXNjZmhOTm03?=
 =?utf-8?B?RW9ZSGZvaFd5cEs1aXF0Znd6NVNMUDVrWGRHME1vdFFaS0VLaGFQOGtOQWx2?=
 =?utf-8?B?Q2syZGNNOHZ0ZHFKdTFCbkRvWTZXRmpKMExBN0JoL1ppRUJlTjNJdXgxcE1r?=
 =?utf-8?B?UFlqcTJPTnFoM0JPeFhreWtnUGtIZDB4NVBQbVJxMitvRmc5TVdhaytKazNE?=
 =?utf-8?B?MlVmV1NtZkVaL0NsWCtvWmRPeEd4YUgzcklaa0huRHRtSEs2NVR3WWs5YkYx?=
 =?utf-8?B?ekZTbURYT1crWk11NDd6amV0VWVTRFhjQjhrc05BdkplYnd1R1VLbmYwRWdV?=
 =?utf-8?B?R2xzWFJzUWZlUEgvdk9QZFdqb1RxV1FKSXIzUnNudlBZa2UyZ2pocGNXTzB6?=
 =?utf-8?B?bHBCcDFEKzRXYTRqOG0zYXdZSVZjOEIvYU9qZ1k3KzNLWFliNHZoMTVxVXlU?=
 =?utf-8?B?dEFuWnduZWpLb2FiM2tBRVB2aGltZElNSS83UW9ucGw3UFZXc09HQXBGbVMy?=
 =?utf-8?B?aTRSSmF6WVV1UytIalkzYmNxRUwvaHNKYTFuQ3Q2WDVWT082TCtXcy9GcmZ4?=
 =?utf-8?B?d3lKYlg4aEk2QWEvbmtjcjN0MWt2WjE3dVBJUXllWGxxMVU2VUpQZGJ4d1J1?=
 =?utf-8?B?OHVOaFI2eW1IOG8xQWxaYThmeHBHcTY2WjdTb1ZBTlEvd2JZOWxKRjQ4ZnAz?=
 =?utf-8?B?ejdjbGhwQmFyUDd5YTNpejZuOTRuVHdtRk9WL1lDWFVaUmM0ZDROZzQ0RFZD?=
 =?utf-8?B?UzFHeXRsRy9LNGtTODAySDI1K2lERFJGUlJHWWdFVWRJR0JnZng4VlVtMTE5?=
 =?utf-8?B?c1hCbUxVR2ZHcStyWmhQdy9uallEdHJGdDljV3grdkJvZm5nV2lPTTEycHFp?=
 =?utf-8?B?ZTY3Tkc2R1V2d0c3dURac3poMEM0MWJNZnpVOGkzYjZxd1oxMWptdFpoS2Ft?=
 =?utf-8?B?M1JQU2U1eTZsWW5oRjY2Wjc5U2ZIdXU5ZCt3SWdHaENlenNlZjJnbFkzT1JO?=
 =?utf-8?B?TmlZbDZiNEx5U29lazNZeEVKTXdCeHJNNUxoS2tLNUV2NlFHcGpwL3BqWTls?=
 =?utf-8?B?TkRYYXV1eUJuZHV3NUJIalUzelNsNmJpK1N1N25UQjFoU29hOGh4ejVzZ3F6?=
 =?utf-8?B?NmxiUnAwdmxhRDlISXdXeFV0QmlodzBjc1ptRjl2ZklaaWVicExuanRoNnEw?=
 =?utf-8?B?NVc0LzdNMmpsYTRMUmVwSnV2MFdBejNIS2Z2b1M2RkcyR3VOK1VMOG03VTBs?=
 =?utf-8?B?TUdVb3Z5MGd3L211aTlpVlA3VkVLRno5ak04UE9HN3BmVnlJVkE5TzgzWXFZ?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8494cd34-8027-4856-7260-08dc1298155c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 11:25:58.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nONp/zU19c0uMcXF8XVZvoQCpJXaOnrggq3Tl+dFuwYigwIWoesET6rxbYKu9ZYK1tgwElCNah51XsyN23PVeNvY2kguP8D4gM/rRzcXwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com

On 1/10/24 15:14, Benjamin Poirier wrote:
> From: Benjamin Poirier <benjamin.poirier@gmail.com>
> 
> Two small fixes for net selftests.
> 
> These patches were carved out of the following RFC series:
> https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/
> 
> I'm planning to send the rest of the series to net-next after it opens up.
> 
> Benjamin Poirier (2):
>    selftests: bonding: Change script interpreter
>    selftests: forwarding: Remove executable bits from lib.sh
> 
>   .../selftests/drivers/net/bonding/mode-1-recovery-updelay.sh    | 2 +-
>   .../selftests/drivers/net/bonding/mode-2-recovery-updelay.sh    | 2 +-
>   tools/testing/selftests/net/forwarding/lib.sh                   | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   mode change 100755 => 100644 tools/testing/selftests/net/forwarding/lib.sh
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

