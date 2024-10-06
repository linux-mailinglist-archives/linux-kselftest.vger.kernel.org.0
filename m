Return-Path: <linux-kselftest+bounces-19120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509A991C69
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 05:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D831F21E28
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 03:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201915380A;
	Sun,  6 Oct 2024 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xonfc9ic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830B149E16
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Oct 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728185759; cv=fail; b=IpGlm5rtf4IbzT3sWybIJiscM7UawI0Q3N24iOTkfu06lF8k2mhlnYIrS4dDWDq1clFhWKZTSP3zMnNDvnnqpIPnzWKRgEyV5DKHU4mayLSncUQFJ5KdWdbr+GdAVJYb9JjCcmNd19H0GG3u2XErCSaSlfmld8W5u62GSaKdU2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728185759; c=relaxed/simple;
	bh=nM1SgKfes5bTn9z0jnngVsjOZl1FMmqU0ZbRqIxgOLY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qWaeA/0KyvVeyVvuba4idfjmPUEV9M4PAiV3Y7nLlXv4zK6C0f6ROlXqjK2+8ahPYWOqpl+ZDLQVrqXonvlFHYqSYHnoogLiev09OISYjGeha+NVkqReRKMkJ4jJpSYTGlFRu0nxSMZLkvYs7uYNRYVEvf+G7asoqkM1REROCbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xonfc9ic; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728185758; x=1759721758;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=nM1SgKfes5bTn9z0jnngVsjOZl1FMmqU0ZbRqIxgOLY=;
  b=Xonfc9iccs3iIP15HbqgU+KKxC043BsVXBzLcm9g1kgjU183ox/pQfA8
   aNOAkllI3nMxsMHdugjRS6RQA80bOIrx74A19MOupFgzATAJpTDMgrgAs
   zKIj4XSHK/XNbjLvGbA/fEYRsZDDO3cFq/6TMF1XEiWcKFH7vWmb+Pv2a
   6ncfpvS+9n2EdYgClToY625SGA47ZyuHA/VZZ8vkZ61RB29G+6MfsmjrI
   8zgrGbf2WDKZhQRwAcMP9L/6QpevfScthhrxtYRjjvkgghcMqYtkxwjOa
   OPR0Cik/kCYpUUXfp+QAEeNHnnnp5fiZeqLhg9kya+5d+XT+/hSKVUByU
   g==;
X-CSE-ConnectionGUID: GUOI2CpTQFaRuGAexZdb/Q==
X-CSE-MsgGUID: GgOxsKz9QbqF0wmtsb01dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="37932491"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="37932491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 20:35:58 -0700
X-CSE-ConnectionGUID: AnxP3d03S8iRRl1vzrY47Q==
X-CSE-MsgGUID: ctqnRhP2S5yrDUGDXTQPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="79523406"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2024 20:35:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 20:35:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 20:35:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 5 Oct 2024 20:35:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Oct 2024 20:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxndRX5tSNxwLqTVDHTfOXd0uw1EpYhBAhHJK48hxRYZ2uyUYShHVB+JKGNCwEqTYCQbBwBnDUA1qR4BUJpI5ZNQx9P5exmnOMQbQJh5/n6VeVbI2CK5x9oY/EU+h1AcdE7YA7jSAGLZx3NjIcMhzHVbktLvu5s9E9FFjZzydxG638n4dUdQEairR1Knf8toB7Y3PPvTX6Cb/wvwDVZ9ozcRRHshVBTrgKRGoTLmGSNpM30K28381e5Skfkw3TArj0erLoRF6lxQ1qVL2TfQMBK3uOB/L+BkudUGN6RhfHGeRUNhPPRF0Z2enxUSKUYFCpXZY8+vX0HzYEjibN8ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZVxxcM2SwPwONC9xqi8McgBRcJu+MdNlSTm3v1VcF4=;
 b=oMpsNz3pwf2pdAJvcELtmE30c4z91r4HFXOIJ4rPmsDtmg3QunPDxpXOi//FXdjYZ655jL73zwSB1pfTuXiS52n/50Ipq69IN5502zuk0KN0jLTlHe2K1FRdwaVDCCiU34pfCzaOum9zuKl7xeYlSu1F7OWIeWsLh9Sl6srXMr/T1Rl2HTrFW8znn2sRT5BRBb7WMCXmPkLlXbnNqYQxp15GX4pC9fT1tQjvQp3Ul/mW783y3OJ8kd7hNdOkNqBASLfDsQcPrw3HVfUElxATTy3jxkQ8OLHP7O/Y1PYO9L0lcLtKgcQsd7qkdLdIFO37eVafO0zafNVgJBiXA/bYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 03:35:48 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 03:35:48 +0000
Date: Sun, 6 Oct 2024 11:35:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <skhan@linuxfoundation.org>,
	<greg@kroah.com>, <linux-kselftest@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH kselftest 3/3] selftests: vDSO: improve getrandom and
 chacha error messages
Message-ID: <ZwIFjL7yb+7JpTS2@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241003031307.2236454-4-Jason@zx2c4.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3ea7df-7ccb-4821-e8a8-08dce5b7f815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?602ZuVQT+5xc+frURxH2qmpIr7GJj3Uyebgi7z/1rYwX9OLDluDXgoehEiQY?=
 =?us-ascii?Q?TYlSMLbnFLVtFjUs9qnZ0wdKGmt7NngBOEK5/COgYTtrLAyhXa3OX8CnLf6l?=
 =?us-ascii?Q?RTfZWBhMpPITosMtebSo2IEj2lhn7DvNWfrJfmKvklHmVw6CNm15dGcBh4cN?=
 =?us-ascii?Q?Rg3tZDHMZy1hYjGKoAiXChqHfORNlZnvB4fD9Oa1eXWHK4b/nM0tDYta3Vxr?=
 =?us-ascii?Q?hESYHh5QSUCbcTt2J8cdHdowFqwxWSPp67nHnCn8IhKPpZR9KaMVbKyTuAXM?=
 =?us-ascii?Q?8LdibAcEXWwAiNiK1IzcnL9EmQTlAjtqFoob7UmKMlviyDc+rQzoPf5vZFaE?=
 =?us-ascii?Q?FtEzEytnNlf0erwnQlfbEnCYIi5R+ktkGLdMwE0LVdlqkvb3Tt3Ud1p3XfCZ?=
 =?us-ascii?Q?lgDhf1N2CpFJozw8DOnbq6pBxggqdkOsgjjFbOk/bK++LJ8aJi+FDCV/H7zJ?=
 =?us-ascii?Q?aybCWFwIbpFBLc0hK2vYpsBfmOJSR5uymcOi1hQmYqGivmPdoHuttBDM2jic?=
 =?us-ascii?Q?9DNfrbW+vOsCinx05+9qjZ4871fWYxLyZdk7LUpMdsSon4GBEOyABSDvRv5q?=
 =?us-ascii?Q?b7MPPxFLpBoo/dmdUrvoVeQ0blkKsYnpHBH7MbSwBAd+4h+qauQ+hgZNkPbN?=
 =?us-ascii?Q?IZlv298nzwPahbzCh2Xhkc4ZA71Xa87YNEciHg+YMEECZxY+uFzn1C6ib+Bz?=
 =?us-ascii?Q?435WVINuqVR4qciJ9QX0XZKyT++UTfczltj2vW6mAavPal/rwoxvKMCuFsEJ?=
 =?us-ascii?Q?V5MeIxECtDgN632o7LqKBwUmvxFz2qoC5oGeJaqmRwwKKqpcq7opHUQkragM?=
 =?us-ascii?Q?HeeCCM/QSPlp0cFKrWIZo91Nw7cYon7BgHXJTpDtN1ntssHpSpEy6ozfMpPL?=
 =?us-ascii?Q?P5MfSgLl07k4I05u0RMHuOo7mYuwqHOD4kxPaSBE0exT9BJONIeDLwjK8sUb?=
 =?us-ascii?Q?sQFuTpu2meGjuajs1kreILIT0GwdVDtjbWsatKgTnVzmsTQV8vItNHPLtRna?=
 =?us-ascii?Q?g7YeQ54u6mm/nVBY9gqmw8+b2BVeMZg4xjKcFVnH9esrSJwP1cKAPUXjGssZ?=
 =?us-ascii?Q?6vAQIin/ITSptPXD6O9ihmeg66eNkPSFXGFqh5Qlq8y+3z0R4+pISMuRmVwd?=
 =?us-ascii?Q?qs1JT1DVV6AWbykGI1EUfb8jWsIVzx9AC+kjillLZi9Ri4BOWZLg5ZoJEBfy?=
 =?us-ascii?Q?fcBWpI8jiamDNdw320qmNBzhbH9y7iTjjlsBo/5iACFlnvC5sOQOwXqXCZQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NDEGsLX8qkIqfmpBmsoTiDoq+jlmcwvHTZKTKcHbJ+UpfwKvw4nGg2EE1uq?=
 =?us-ascii?Q?NY1sNoFuC7YsQeSp8JHlimjiHTM3fYH0A/hW4bMYNCKd9TVc6d68wkzKDmAT?=
 =?us-ascii?Q?Qpex0tPJYbx33a8d9pRTHpQmKVD878ar/lVFb0HLAfOnd06yxWMEn/Cl+b5c?=
 =?us-ascii?Q?sEEGGG5P6R5SX8YYBRHaqGfJDrOsx6LvC17ttgqNNUpHH2KOcp8BjOzV4IpA?=
 =?us-ascii?Q?vo96yP1hOCZlsuRk4+xYf+LGWepHdyVvhqJ/JDDEXh/y+/6YJ1X964O/UMf8?=
 =?us-ascii?Q?VDagDPYxf1ggoeem+RcJWSV3SRxhTBBJfdEOEls7CK7rXy07LNKMBrHdzOSz?=
 =?us-ascii?Q?GAEV9Ha52BawcJH2mA9S51LDCPwi6g6rD5HUTq2nbHxhXRRXuJ52ueyEEaRu?=
 =?us-ascii?Q?tQoAN8zMxdyU8Awl5z2iaHCwS6xpXZiJdPq6wlU7DuwpO1kcdDa2D7k8hoKn?=
 =?us-ascii?Q?2BdIeMefR9tr1j/iJ7ijtZF7c3mTgkRL7g7HwHkgMcwOsFgjELDc5VnvcsUD?=
 =?us-ascii?Q?x1h78peeUGHyR4x9yQlUdvhynFcXvuzfaEfcQd1XbcUb+gNuhYVAC+cYWWo/?=
 =?us-ascii?Q?zeSNWw6S800J0xrtBj9I58WD2PWEXMczkQtZNBzPZZmzcgZkjs5B+wG8HCbs?=
 =?us-ascii?Q?1m45akyQKfUozkSifv1q+YTKPEFuyBG3gdfj3ig+eR5tQTB6xi+2PoV1ikmR?=
 =?us-ascii?Q?E2Q9qBwfjFsxkiI99d8QTt5fwZArGNh+CcD3WdXbbMzCfdbY+KDFEkDq64Og?=
 =?us-ascii?Q?OzsJCn16F3Lyb6vi60QKoqPCwxWFfefwOTQhDKl9f6nT2+gKuH2oMqsFLmXZ?=
 =?us-ascii?Q?wWPivbpjl3Ft5TN82Y5zfASBEOr86ccwP3INZ7RnQGnxucu7JQmFYKQzAGVV?=
 =?us-ascii?Q?HSGS19vl3fjsuIIuWSeXnqcpR1gJ3TfnZPmxUNE5uLkKgxMR79yUx2f6v5Hm?=
 =?us-ascii?Q?EWMM4ykenC0mtRlPXQWGsJn36wHJCdsalDqnJTaNVa0o3Gy+7JXOqQl4VcgV?=
 =?us-ascii?Q?Qvj0wtz9coZn0F3k/ep/7iqYwYJxcRU/pmq7NL+qdN0zGuWLfUBIePzxxuog?=
 =?us-ascii?Q?20LiiUwnfLrNGuzHzblvG3Hig7PEO147SI3LvhQCB/ItUX2FakxlifUxhC7H?=
 =?us-ascii?Q?3+QrowF1mStlUkZdhJHisGOf1UWTIpJDobhVvyrInH9S/sgpr1A4BzZiWV/v?=
 =?us-ascii?Q?Vqy97/olcEsO15tKkulzlWleDsiRDrprHpbKXRwTgKhrBXZnHXOnVYae5Vkm?=
 =?us-ascii?Q?s2v/4xxntjGKUWEozAHPfaVhigaLhkffpzCeP1UfHfLf+pUcudng31iwKsl7?=
 =?us-ascii?Q?n+5GxE0/7rtTIt/g/JrH9v1I4TwZUF7gLlTA0BL8WBLXHeO7OUTkSvYK0lvL?=
 =?us-ascii?Q?Gh4mt1+jxAAzuAzxHJmWbcZp3Zgs6u0j3RS3WXJX0QxFAe56rFVHdIkOuglW?=
 =?us-ascii?Q?sh3QIEoeWTAuMlPaTa3S0Spx9dCZdQyFdoR9woHx0vCa9Q/DrQ+4yvbxw/gW?=
 =?us-ascii?Q?6FsKey4HXGSpqY9tkCWZ0qAAci+jXWX4osBSggw2VOVYr7xz9QYHL3EAhduV?=
 =?us-ascii?Q?yzH4LQgR81PTRNepVUtAhSfEh5saF5j0Gg7o/2QU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ea7df-7ccb-4821-e8a8-08dce5b7f815
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 03:35:48.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2P3xbu3f2bKsZd50H8zpO3UHI/GtSpzc7wyoKARrj9+4MC4J8T3y6NjMjwUVcWdIyWwNQ4YxfuQNlitSJttlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-A-Donenfeld/selftests-vDSO-condition-chacha-build-on-chacha-implementation/20241003-111508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20241003031307.2236454-4-Jason%40zx2c4.com
patch subject: [PATCH kselftest 3/3] selftests: vDSO: improve getrandom and chacha error messages
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051432.uAzAV7yV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202410051432.uAzAV7yV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vdso_test_getrandom.c:274:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
     274 |                 else if (WSTOPSIG(status) == (SIGTRAP | 0x80)) {
         |                 ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


