Return-Path: <linux-kselftest+bounces-3142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F88302C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 10:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD8D1F23F4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707114276;
	Wed, 17 Jan 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+Gwmzvm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35E14AA8;
	Wed, 17 Jan 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484974; cv=fail; b=Cs72bHMF5d6dUbdvArHWubPyaGQD3CLgOMsuoEqpdDWrzAxfboJLFCATeYlvBKnMl0P13vqwEL9KOWblFnJsHZskD9TPU1OJgoMFqvb9eXYi/A0XGw9tsrOMoLI0ZKKu+YIL2cNUG23H87z9qK/8Z3nDv05SheZ8HzVkUTsKo1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484974; c=relaxed/simple;
	bh=TNUu9z2eZpc8YaqS8Zjaw4beKxPF6uaz4WniOoB1BD4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=I3tb25N2BqHgXH9qPUPqcu6DrCCfGv+bZrfy6tp/v3sKrj2fKFCdY/W1mtwmEnUKjoVY+Ubkflsm/h2e0P+xYCmXDfpCszKTLjJpDsq66aHXfWi0hqKSy1tnOcu/TNeHtmsNlZFPzIaxmYftIiEX0U96HI5ymYHc9d7XCR8VWLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+Gwmzvm; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705484972; x=1737020972;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TNUu9z2eZpc8YaqS8Zjaw4beKxPF6uaz4WniOoB1BD4=;
  b=j+GwmzvmJiTCzmLoXxbLWhmhApMrrLPAO0O8coDiLg80p2bXqU0SMQHe
   0QOHEXrCtHvNB2C+oY9zHlePiOun7eC/Vdo6QheHKVK3kkZb4T55COZ1W
   1jU+3l/dPryBfz1ys4LiJCWpekqyVh/fORE04/+f4IlPAGAHxpglnawiU
   AnBnVj9m3GgDQPGEKJqAY3KJ7N/1vrx44yJdGrx2LJW1nm8rpBlDej39M
   5pErKvVt7yWmiUuZ8eBKz7VBNszqie6S5cBi22CyXisWE9OAROntx3CxY
   l5Mda/6hafNvBhpzENA6CWb5sBteXR8yzkFKl5syAiZDo4zPpAlYqZh1C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="431283813"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="431283813"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18788474"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 01:49:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:49:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:49:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 01:49:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 01:49:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj74L0OIT9UJR2v/aILg+1uwgNc6Q8ySgnRG+tgI/bUcm5Kkwt4qAtJKQgfZux0FSAfMeU+ZwkKJhgUUW24ymef+Q5axWsu1JAJ5QKwvLzvMNz9JFW+k7rA57ecXvafK/EJ20hdOxy3uU/7e/EtTCc+YMfr2rgjNfRsXaH3poIcvbsf8EZIXRkLyX6otAQqBFZTXC4TeHcQE+9DDPYkaUKBiAzN9rR79BIei5JNaCkdEicFdF0AkArHcMbE/FRWmh9N2X/coK8b+PdkeHOyo2PSGSwXjdSMTwqGkKG4Arrl+VcrQiMONS4LsMt/DoM2GHWFVz6jpOoPeOWZ4j+usKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQzbfvdcQxlH0zFq1U/9SJ+i/m/X9aadxais1dCeI0c=;
 b=JARvrF1jaRQ5qvMb2NbOmqtgNyOBs/u/Dy987Lv6bGsw7VEl9Cf/+Km7w4jlDC8smxW5FwPdjdD+Z8YZ5oc2ILbMgt7g2y6ugGrixPATJ1Xbx9OnNE/eOZ6Jd+KqmEJ9O53HS1G2mFgBFY7CJ5Hj1EKODFaV2DDN8TOvWEO4vwI2VbRR5knwkJE1NViHIVL9Ld9D9b1AlNCclJ8feAuwNlgELkoL8SeVb/adAWa4Y1X/99S1vGewxpUag6h38mJ1wQFbmf4HtNydLue89rZ7O3v5Xf3FGplOEhCRYKRpmR648v+dkFwx1AtLY5zMu6QdzllyiTVPnwtQBfE3YIS0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 09:49:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Wed, 17 Jan 2024
 09:49:27 +0000
Date: Wed, 17 Jan 2024 10:49:20 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] selftests/resctrl: Split
 validate_resctrl_feature_request()
Message-ID: <2o7adr2cos6qcikcu7oop4ss7vib2n6ue33djgfeds3v6gj53f@uu45lomrp5qv>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <d6442103165be849d32585e861fc2850f7c4e8ea.1702392177.git.maciej.wieczor-retman@intel.com>
 <64b6767a-201b-4c61-98e9-f01aa271dd33@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b6767a-201b-4c61-98e9-f01aa271dd33@intel.com>
X-ClientProxiedBy: VI1PR0102CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1ee0b-639c-46b1-cdce-08dc1741983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlwTbMSKPkxA2XMb8zN1lk/m1fUEbjwEWtACJ/YmoqTNSV1b5VUHnO4HF85CuM/ESyrCkKRkRODHYYAp2P1RlGLfLLkNz4cLyK8Ee6AIh6OIQO7Vn/WsDPzJogNp5drPXJCEQLCyvyz6NoIapuf6lk9Y9ZoV57iMg88mlO1uvKbbR9OdyTRPhgucThEWVlRkdY6HA7KIDUfYuSXO0Bj9TQwicyDYyHtQB43+Wv4qj01ZzYwp+uvvX5HBUiB/Xhf2ZzlZZNelJBUZx14eaaPg4jpS3nLMjyl2kqjVYewCdEmMqicoD/VDL3qBt9SYa/EnQAJXHAP02rD8SwdZ4Kli56cGn9QjrGRnsLfWhVJ2DmSZDzwZwOUje1iM6KRuH3mgupEUxuK9Q2awXKXOLSlYy0HgM0BlLn9KEieTSx8EIjJqB8pgpKb+T/nX179+tBt7WVWujIBLqUBd7Ym3Hmr7xpct41g+eHubClx2hTQD0LvaygIQG2Iu+yVHkCHSXF4U5NJCkj51uI1pZBoA/6ED/wSCYPFAhUnwiMPoIiWe0UJcFztJnYlJf7b1OJ8L4tqhkPvuhyyzImSN9QxrKn5635GZ3WCNb5dkoz7w6Ljmz2P+uOtt6VioGPK2UXcZHU5V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66574015)(83380400001)(53546011)(86362001)(82960400001)(66946007)(6666004)(33716001)(6862004)(8936002)(8676002)(4326008)(5660300002)(9686003)(26005)(38100700002)(316002)(15650500001)(54906003)(6636002)(66556008)(66476007)(2906002)(6512007)(6486002)(6506007)(41300700001)(478600001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vHFtl8/H/8PwjK2aj5oxO9eYNoo/tQ5aZckR0lmCox93iJOvg0Kbps0e6j?=
 =?iso-8859-1?Q?ZtbdXTbGhshj1PXE+ncZ7IL1zB8QbNwk712gooxHUaNRu6SoWROQGNLJLB?=
 =?iso-8859-1?Q?cIeng/u5bBYUcCQ7FvAbiHVBZ2kgqmu7R5egAF4lZXPfQoq0r9+NmXHUqB?=
 =?iso-8859-1?Q?plhKRghESy95oPivgT56PwE2IkuPEet/00q7ZhCDAr6ddh9SPe7b5vIDOW?=
 =?iso-8859-1?Q?pgKp1XV0kd1kwCv3+wH9rdAd+VRxb/ZufpN2XUTlKolu1X7RZ9I27RYRtc?=
 =?iso-8859-1?Q?MeADYQuzou0+kg88pN0k59shK5ux4qRl8jc31cVUbCCaSHREHOrWp2h8zX?=
 =?iso-8859-1?Q?V2jZ4LyLiAZwc/cyzZDwkqLsprvtgfB4g9ysvShlp1QrUsiutacL9wJHO3?=
 =?iso-8859-1?Q?zbR8QHfEPhMj87DL/zAJ6md3HvcVlVGe5jVojHre6ynd1V8QiOKuo94HTM?=
 =?iso-8859-1?Q?H2dkZ+U++0KN5JxgefFi0JxCYkkqoPnoXlJ2DnUkArq3s7o45PecDJ/B8E?=
 =?iso-8859-1?Q?TdAsSX4sy5iRryWutTLL0cxPh037N4e4HmL8KwY6NL23u2279XYtORS1A4?=
 =?iso-8859-1?Q?Q1OK1gbaLSCOwjDj8ZF9vgAs7dSXCSTPlp/IwwczB6LdCX89aEuLR7HxvZ?=
 =?iso-8859-1?Q?6Z9N1Mavj9jo8nBPh0g8XNomOGb8VJqLiMrGejVK+Iz5mp1bccBYgATZfv?=
 =?iso-8859-1?Q?M1q767EGe/Lfhfi6oxf3c1IQEA8GideISnYJDM4pWKS4HdKmxK7ke0GCOP?=
 =?iso-8859-1?Q?o+v38fp5D+o/89u80MGP79kq4B0EY56EQxnJYUhgt1EvBM3K9ibyPKQQzN?=
 =?iso-8859-1?Q?kKs1imUlzlhZiVzIx5/Fqe/yPhS1WGYHA6iYg0ahSr+PInbzLURVE8Rr6L?=
 =?iso-8859-1?Q?AtqmyEVguSUNHaUYhSH2A7F23prMNvjhZO4XgVn23tU1JvB8P5dNuLbtql?=
 =?iso-8859-1?Q?QpPPDxuPNVpsz9Cdif3c22iuu+YddVaH1oZJXUaRYkANvreBM0OpCcokvv?=
 =?iso-8859-1?Q?Xg55inG4Gu6o62Gq/4q78PsvL1DksilMlfL9rItn6feiUgAYVO1ixdx5zJ?=
 =?iso-8859-1?Q?VQm+ifV8hmEMJNHqeVrAinOfIe7Wf6u8b/n8N1ayPlHzmKcl2nd72p5QoH?=
 =?iso-8859-1?Q?Z323qHiC2Iwt3LlvyjRVrV3lH/0EvUgfJmF7O25uJozVXVlER7O2hmi2z7?=
 =?iso-8859-1?Q?0X8bKL2AEWjXrIg+jd0ZoM6t0QBUn7UV9PIzJ+lpfDlHI7RnFFZYJhwUKb?=
 =?iso-8859-1?Q?4IcBJXj9D5Npa8LnxVX3OTomE0MgtgcFAiaAgj6h2Whs0V7hoylUlGcEII?=
 =?iso-8859-1?Q?pv+2NCdWzON9sg2dN16YxBYkSkLJKAwn9UAl+noEVTu5D1dSu+H6OqcS7Z?=
 =?iso-8859-1?Q?Ioq8XxIpkttborTl6yK3ok5len3ItuZ7BbIvq/mL8eTo4sZwMex1rJB4eC?=
 =?iso-8859-1?Q?Juc0cgOg3SQBECIBFEZxyZnlSP70MvBbUuGigJ8bU3ZmFHBT+8y9IsPcNz?=
 =?iso-8859-1?Q?ymterEIt4fsfA+l9ZQLyhpcQv8cwbYtNaqjFmKQx7EtOCL4ol5FKUo/qog?=
 =?iso-8859-1?Q?GJvXIy1mZV7fFtWYuXKaROfh6MgoGzLivJD0aeLoN26GQBVVnlRG6Oc4v9?=
 =?iso-8859-1?Q?BXXEIjF/KvEvBwQKdSJQRI1jDyfDeo/oBcAuv7Bzv67eu7o29+5RAJmcGL?=
 =?iso-8859-1?Q?tJa5iUwm5UEsuk4vUuM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1ee0b-639c-46b1-cdce-08dc1741983e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:49:27.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHJkz+ELuWxxJ010axSkUxMuOX7bvEQL6gtoOi7qrEDZvFpx4cObWVMKV5wrPpVeWHlp82Ge+fovZfGLHzBWCg8jO8gwrIRYzVKRYVby9HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

Hi!

On 2024-01-08 at 14:38:45 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>> validate_resctrl_feature_request() is used to test both if a resource is
>> present in the info directory, and if a passed monitoring feature is
>> present in the mon_features file. There exists a different way to
>> represent feature support and that is by the presence of 0 or 1 in
>> single file in the info/resource directory. In this case the filename
>> represents what feature support is being indicated.
>> 
>> Split validate_resctrl_feature_request() into three smaller functions
>> that each accomplish one check:
>> - Resource directory presence in the /sys/fs/resctrl/info directory.
>> - Feature name presence in the /sys/fs/resctrl/info/RESOURCE/mon_features file.
>> - Feature file presence in a given /sys/fs/resctrl/info/RESOURCE directory.
>
>Please present refactoring of existing code and introduction of new
>feature as separate patches. 

Sure, will do.

>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Added this patch.
>> 
>>  tools/testing/selftests/resctrl/cat_test.c  |  2 -
>>  tools/testing/selftests/resctrl/cmt_test.c  |  4 +-
>>  tools/testing/selftests/resctrl/mba_test.c  |  5 +-
>>  tools/testing/selftests/resctrl/mbm_test.c  |  6 +--
>>  tools/testing/selftests/resctrl/resctrl.h   |  6 ++-
>>  tools/testing/selftests/resctrl/resctrlfs.c | 59 +++++++++++++++++----
>>  6 files changed, 63 insertions(+), 19 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 39fc9303b8e8..7dc7206b3b99 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -1,9 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Cache Allocation Technology (CAT) test
>> - *
>>   * Copyright (C) 2018 Intel Corporation
>> - *
>>   * Authors:
>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>   *    Fenghua Yu <fenghua.yu@intel.com>
>
>Some unrelated changes here. 

Oops, sorry, I'll remove these.

>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 70333440ff2f..8546421f0940 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -725,6 +721,25 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>>  	if (stat(res_path, &statbuf))
>>  		return false;
>>  
>> +	return true;
>> +}
>> +
>> +/*
>> + * resctrl_mon_feature_exists - Check if requested feature is valid.
>> + * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
>
>If this is intended for the monitoring resource and L3_MON (per below) is the
>only valid resource then @resource cannot be all of the examples shown. Why is
>the @resource argument needed?

I see now that these functions turned out rather silly. I'll redo them according
to all your other comments. Thanks for pointing these out!

>> + * @feature:	Required monitor feature (in mon_features file). Can only be
>> + *		set for L3_MON. Must be NULL for all other resources.
>
>Which other resources?

I'll remove it and just put L3_MON in the path.

>> + *
>> + * Return: True if the resource/feature is supported, else false. False is
>> + *         also returned if resctrl FS is not mounted.
>> + */
>> +bool resctrl_mon_feature_exists(const char *resource,
>> +				const char *feature)
>> +{
>> +	char res_path[PATH_MAX];
>> +	char *res;
>> +	FILE *inf;
>> +
>>  	if (!feature)
>>  		return true;
>
>Doesn't this mean that resctrl_mon_feature_exists(NULL, NULL) will return true? 

I'll get rid of this check.

>>  
>> @@ -740,9 +755,35 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>>  	return !!res;
>>  }
>>  
>> +/*
>> + * resctrl_cache_feature_exists - Check if a file that indicates a
>> + * cache related feature support is present.
>
>Seems like this is not really specific to a cache ... it can
>check for any info file related to any resource.

Right, I'll rewrite this.

>
>> + * @resource:	Required cache resource (L3 or L2)
>> + * @feature:	Required cache feature.
>
>This seems to assume some usage of this utility. What if it
>is, for example, resource_info_file_exists() or resource_info_file_readable()?

Yes, I think resource_info_file_exists() fits better.

>> + *
>> + * Return: True if the feature is supported, else false.
>> + */
>> +bool resctrl_cache_feature_exists(const char *resource,
>> +				  const char *feature)
>> +{
>> +	char res_path[PATH_MAX];
>> +	struct stat statbuf;
>> +
>> +	if (!feature)
>> +		return true;
>
>resctrl_cache_feature_exists(NULL, NULL) will return true, no?

I'll remove this check.

>> +
>> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
>> +		 feature);
>> +
>> +	if (stat(res_path, &statbuf))
>> +		return false;
>
>I think it will be more robust to look at statbuf to learn if the file type
>is correct and the file is actually readable.

Could that file be unreadable or of wrong type?

Also I thought that since read_info_res_file() opens and reads that file any
errors should be handled there. Shouldn't this part of the test only return
whether the file is there or not since that indicates if something is supported
in the kernel?

>> +
>> +	return true;
>> +}
>> +
>>  bool test_resource_feature_check(const struct resctrl_test *test)
>>  {
>> -	return validate_resctrl_feature_request(test->resource, NULL);
>> +	return resctrl_resource_exists(test->resource);
>>  }
>>  
>>  int filter_dmesg(void)
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

