Return-Path: <linux-kselftest+bounces-39511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133CFB2FD63
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCBF6431E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521661FF7C5;
	Thu, 21 Aug 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTc/hE61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C61D8DFB;
	Thu, 21 Aug 2025 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786968; cv=fail; b=hq8Y7ywP7n+2sb1pYSvMTVvEUjgPWwYf+zcev4gSnBlkU7x1O20hdthSSFrJhayjoroOuuJBiTMqHw7mqhKqAWJnWAJCqGb9IyXFsv6zM6GexnSMxd5QabuAHt2Qr355sI5ez686v0bYhdBgo8o3B9s5upFI7Nzwb5c4piSrmBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786968; c=relaxed/simple;
	bh=RLXYm73hjPbfuOejYwvDk6VpXn9lEhnIQRJzGcPKxHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nmuCMZSw+Od86AS7669wNKr+LaGgccpADENwCBHT1bdRQyVfWz5zFYPBcYrmFWq/u/Rtm8CPiPSDvS+oOEoHS8HjjgcreaIYI0SC567vRkp+RjPK70xTps2N602dumaIgfJLGfvz23hUGbUVVNAV2OKTCgT7xU/eHGoDMfwRN7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTc/hE61; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755786966; x=1787322966;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RLXYm73hjPbfuOejYwvDk6VpXn9lEhnIQRJzGcPKxHM=;
  b=jTc/hE61cQRpZrjRVlkd9RyQzLw8g3eIPeG3FUpHJTp5+McFw1dQwjye
   XL5u9piGkkEFCJtWk6KhnBrcUxEU/PFSGl7n045medTR1oTjYiU9KW/Ux
   2nRFVGJUgxFhOKX0E+j+rSUGLh5K8Rldi9t/DtfDZdhFTSGnLTsUX1h2t
   MIEkFHxUAyv/RIER+N1ZJutUIzfrrMz+LzXBaq3tu4qKlLqrvtw+rgLoH
   DJ7orM7W3z84ZVfGBlad9CklHpi8uLyjJIya/pF2KLsCIWVe6duEgv+eN
   A8qen2XitUYzsswdq9Yyi8f/a6z2hzUJvrqWbHZGlvwEprxGsX5FSAuew
   A==;
X-CSE-ConnectionGUID: RVr9OBoxT8KJHPu5ScVLcA==
X-CSE-MsgGUID: y+R+IvTfQ0KnbBrBn03J2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68675991"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68675991"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:36:05 -0700
X-CSE-ConnectionGUID: 88W0EfelQgOmNYGTLWw+6w==
X-CSE-MsgGUID: fJRvp1lDRsyuzKWFZbXTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199303611"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:36:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 07:36:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 07:36:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.80)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 07:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGRl6MBMeVcBwN0cXAm46x0aDXKoCFSLdXVrvjMnNsDdRCXxnSS3jRHKo79G/LiCrysjLJvae7QIrR+qE7GnbN5NrEnP45EjwBiuJrMJ9O7ekzitky8ecfAxttdwEzqZB11/1GvfcC/tGRtfWEB0kJYcus68PPLQhEBKuypJXLJ5kpDkX9DwheBzQNt3sH0IKM/bll02PPEmnuAbOhI5e4h+IYRJXAPeXKAyBMhnr5v9q6pzGoaxzMeQydSuJa0Dl7AOIs7mIsUcbM0KgvBtdfvNYU9qRdbzvNZzroyAhFWLbdMaXvoB7w7d4X6HK3oLE0QvxEvkoGTe6z2hE9L4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WndbsLiGW+gAP8GdC/iprV0F3JP7fsahgKZ1dXT0ipQ=;
 b=yjXWAhfyNZ9eVwSO6xbECcqltBjebIKKazdCUiC88zutJUq7L/5byk5LVPbk7GmtrJspNOPDe9hJ7BDIYxvwO6Xo8Vl9b1RnbD2n34VQzVtJ5ADzgMTaUgZGhsBvSao7vXGI8IMkhmE59sUy/Vohml1AnyA70OvRhUX6ujupp/OhPQGz+Y2ga85fROJGFjl5Anvx3E692yLKQtnOpCUidthdsynKoSNLc1IRYmeMl2/wRLwM8LYpChLHETKBnMOUcziG3EvZuMjqIADpY1oAJmCmUwWy2tu2gK91Yg8WRFerkDGNMOUOrPndSKsPMyXu4Ks5Fdhx7j6/Oi4V0v7lvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM4PR11MB6213.namprd11.prod.outlook.com
 (2603:10b6:8:ae::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 14:35:59 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:35:58 +0000
Date: Thu, 21 Aug 2025 09:37:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, Kees Cook <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v9 01/19] KVM: selftests: Include overflow.h instead of
 redefining is_signed_type()
Message-ID: <68a72f36be3db_2a6d02294bc@iweiny-mobl.notmuch>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-2-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-2-sagis@google.com>
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM4PR11MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af31856-da78-438e-4d4b-08dde0c00b6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6LrE77cSFoxb43jqaszt2nvx/4nTHNw2cLwuK6gOkb6KkyAowpHErMS2fiZV?=
 =?us-ascii?Q?HsTvmu+t6SNNA7JtMwuWINzLxSRFaFuDO67t9fk2j5ou2YV7uBby2/LIDo6w?=
 =?us-ascii?Q?0u9H+StzD5KaUO6IEJF/mJqO8wYu7hxIH79y9lZCzMbseD0vzBe4geuIfQlL?=
 =?us-ascii?Q?zk0qbo7qgF4mSbsEz2GoPFHPnzjnxMlGZFxXbTCcTJ8IkdN66Gqsy7GLZP/Y?=
 =?us-ascii?Q?v5XVk/Q//ZVD9vU45AVBty48LFWgxgdKtKzYRYWpeflFz4hWodBx6u4I08pI?=
 =?us-ascii?Q?ylZJODJduQST66hJTbLzSWr8UlEoBI2CVL2Che2nDx7DmYk/oV97d//BRh0G?=
 =?us-ascii?Q?MCgrFqB+1u32jl7D/FFYBwJkBin6Nw1bd58Irfcj0x5mBonXmT9JFJW4U005?=
 =?us-ascii?Q?DgHGqpFav5CDfvfaU9wOIz6/4eaKqg8gfzN8TFccScIOHPaX2KG262s9cBPa?=
 =?us-ascii?Q?FpHQgLYMblDuGUmXO0uz0MwiMcxsT3A7uXRtUUrkUie65h8xbLZXHu8E+Z4g?=
 =?us-ascii?Q?tIHMohp5/Nr29gGyMgrNAw/vYpw6vKpFgUpkNBu7bna4pWcPVa+e+uihMWK6?=
 =?us-ascii?Q?WpTdB9vPEjtgngQpaDRVLV885jCXXblZVvx4ujXhPUKAgnOFAw1CWZYjNh43?=
 =?us-ascii?Q?GxK9NnHLkfvvwyr/BEKc+OoJcw4kIpzfFS8IRZ85oL5d+ffODXJvfQ0e72XX?=
 =?us-ascii?Q?yrrHMR6YlZPuxyQTSRkuwPhNsuNIJ/7EORxFcRVJyrfxoKfz5re+NDKI8nh6?=
 =?us-ascii?Q?1PWR4H6ietsKOZzsGb4DfEtAkDoqO7dCcSk9Vx0186dF8BzDw6zFcXD34Sr9?=
 =?us-ascii?Q?bS07/1nVL+0pXcm4heG0rdVfv6gw8iwkLmtW79AHuVZ07xlqe9JtStXBpkbp?=
 =?us-ascii?Q?/+JWfABkU3o92b5xYBoW6yK7xmr7dwMjOkZwBQtb94tIZiCF7FMW+h04P/Zy?=
 =?us-ascii?Q?+lz//sStX6OkVazEm6mVxpGjfigWTaNNx59+QYpH41nf1RCQ3q9swp5k5M87?=
 =?us-ascii?Q?NOXMVtYCLHiFG4rfJEOXkrvvR36oykaHqyy5mtxq6cNGnrj4h/p39GQ57E/d?=
 =?us-ascii?Q?1jdzGdMaxVmFAEwUhaSQ2aL88tZw1ID17Er7SsvsEK0af5ADfoefQAiaU0Oh?=
 =?us-ascii?Q?ooxtqG4xm/eoSsQTTMXguXtRDPcSwhfXT2b6ibG74U2Hmla9JpyKM6dhmIhO?=
 =?us-ascii?Q?9R1k+WW/b18FvjRY6ou1QfNlLYb3Y9mwebPGqYtFNXIgdhbprLaTup9RXI0n?=
 =?us-ascii?Q?ZPa3WDz7aiN9O+WPaJJNUdqU0MtdJ4rHahRpeoAeRZ3rqf69dgTR9x0U2lr8?=
 =?us-ascii?Q?f+p305JbkgB7d/B3G3P3+L38mKd6gTgcUWzEof/p70ZB6KoHDm2SzlAOOZhu?=
 =?us-ascii?Q?VrxKgPL0LDz/OWcyJ9c+NVCiXWHgONFQ9x1ocoscq9GU0pKFGDdaFRuBiziR?=
 =?us-ascii?Q?KriSJZzSYFdA6N6oO9OGdv9nTXlQKfg3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7RFwaYWgfGL7DyV4pzonBaVS08woLlvsvlvNuT458u5bAQBiT5b4O/AiVb1?=
 =?us-ascii?Q?DMlbZKxmzpodhwqPndblOX06A0Jm19k751qyVVo0uhBHFfMN2kUkBhlgkHtr?=
 =?us-ascii?Q?UQK8iWlkZYzZNYIQRjw6b8Rmk4k5FaHVVcVJjKEq5kjubMjBJnliseUT2oLN?=
 =?us-ascii?Q?v6f7Si9YF9D/rVJq9Sq8TWW+SAGffDZawa+OLWwuZ7wHfm1drPEuoD/o2bIn?=
 =?us-ascii?Q?VWkfEd1G6+cT9PBHkRuPoKQgoIW0+zm/V2ja7azrs3RGSTR3BzmwgO38Guno?=
 =?us-ascii?Q?KaP6TIz/iP0VYJKN2/yE25NkVFowjcBiemczs54HDmfPO5Dd1k+zPNTrdfDk?=
 =?us-ascii?Q?9eb6bL9rviRHFhePKHmlN7NvkkwOre5E0qbp61kIw73qvIc8feaJColWR61c?=
 =?us-ascii?Q?fTZipMJEM1vmyRgKseVMG7Yx7fIammLfbKl5SnIdxK0YT7ypEJ/M9z879hVz?=
 =?us-ascii?Q?+RfRWZftWH0p3OPeOJJllFtfcxnXzIhGP8t2l3usbCi1IWAo3W00c4EmckWB?=
 =?us-ascii?Q?yH4gkfbLVTnnwV+MTIUIVh++BEdsyiALeuRiYCvZMAylFHg3b6AsO04tqP6o?=
 =?us-ascii?Q?TpBgHVPAVQJxCtvhwNkU3JdixMm1BUmhiy2iUmhOELrbr1dspXifURI6FCl3?=
 =?us-ascii?Q?fz7iPi0OrW8INo9Is+H4eS42+pQugDFJIYqtMWzT2mV83T0ffFYmR/DhJdyb?=
 =?us-ascii?Q?5suICHC6NrRxCOwtyKeTsWX0KqvBfLjwZbmF7rXU260aK1oyXfEySIabic7l?=
 =?us-ascii?Q?SlYW7WUesWD7yhH0Ss2a4qcdZvH/klojg3mAXV6vjQC4vseLgCggVMzZ5GgZ?=
 =?us-ascii?Q?kJlh/WOPZdE5SXmc37HZRignWsQgvQTdslCIN0jzBMHwQZTvkUSwsDTIM5K3?=
 =?us-ascii?Q?1dtHzR0MIJeo8lvU0ZHNiE3K6Vgw/l4zM6cowtMWuB4DpaRf9S2ThJ9ojUKK?=
 =?us-ascii?Q?DYPRaVTQHWwA5bJ/H3vhW2uD8b3gm1WVAfs4C2H78p172LFwZdJClqUJakjg?=
 =?us-ascii?Q?e/TIwLVKooKsF1Y3VPsIF9bKHCkerqy3A6wZnHXrOXH0tumh1lU5Fr3l0Zz/?=
 =?us-ascii?Q?bAf2Wo9rBgB1E1mQS0IWsrmiX2xunVX6qta6quMmGNxclvAGNDAgjBUgRYiL?=
 =?us-ascii?Q?urSOp/hz+d1jfOlzfvG5SGjLXsmVZSkEPpA7O59VcrqKYHf+ycvL41w/gbNM?=
 =?us-ascii?Q?pba3qUu9re8JnLMiviyQj/v9+tf7n9p1oEuGWMkGJHw0RqXSB6vevcE4j697?=
 =?us-ascii?Q?xR1dfbh2e0qWzjl89hWbzmcwsSyfQFfbkgt8U750gipMTDcB9uyvsm8S/M20?=
 =?us-ascii?Q?wDjCDpQtCvH4FoDRxrI21zX/RWyV1DznVbG1ksOX5UoDtCruz1WsyO7egXTz?=
 =?us-ascii?Q?pLs58mjyBeZObJEkEag71cWl2znELeNQefbkFEOy2QF+e29dASADuysICvLJ?=
 =?us-ascii?Q?IyTq3e/IAZH46TbBaj1uBmHpMAVXDM8JK1l5hKYB58OpMAq6hpb02ukIrsGB?=
 =?us-ascii?Q?Hu93lj9ulZKm5RMDo+V57sqJwZ5Iv2DLCAp00DSZx8ABsk4ovpW/3d920DYd?=
 =?us-ascii?Q?746h2ND9wm7nVY/+3kdtsUmt+cYNK0d+OpGpIdmj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af31856-da78-438e-4d4b-08dde0c00b6b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:35:58.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9gZElEuIufXueEvRv3aXpWcmKM8XS8PRceapxW5bmWRoRt5+yeg0AjLni+qeNA/PxEOoZQx8OHD6R85co9tfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com

Need to add the selftest folks.

+ linux-kselftest@vger.kernel.org
+ Kees Cook <kees@kernel.org>
+ Shuah Khan <shuah@kernel.org>

Sagi Shahar wrote:
> Redefinition of is_signed_type() causes compilation warning for tests
> which use kselftest_harness. Replace the definition with linux/overflow.h
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>

Thanks!  I've seen this as well and it fixes the warning for me as well.
It might be worth picking up separate from this series depending on what
the selftest folks say.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tools/testing/selftests/kselftest_harness.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2925e47db995..a580a0d33c65 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -56,6 +56,7 @@
>  #include <asm/types.h>
>  #include <ctype.h>
>  #include <errno.h>
> +#include <linux/overflow.h>
>  #include <linux/unistd.h>
>  #include <poll.h>
>  #include <stdbool.h>
> @@ -751,8 +752,6 @@
>  	for (; _metadata->trigger; _metadata->trigger = \
>  			__bail(_assert, _metadata))
>  
> -#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> -
>  #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
>  	/* Avoid multiple evaluation of the cases */ \
>  	__typeof__(_expected) __exp = (_expected); \
> -- 
> 2.51.0.rc1.193.gad69d77794-goog
> 



