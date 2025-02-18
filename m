Return-Path: <linux-kselftest+bounces-26827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A787A39260
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176F43A9E2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81A1B041C;
	Tue, 18 Feb 2025 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkLooSNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CE1ACEB0;
	Tue, 18 Feb 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739855161; cv=fail; b=cuSQzm55S49ob5gSuRiXyF6rDFIcFFx1RN72bPA44hMtClgFWCBPon1++Vt/mQFUlueugGi8ziB+VAwrL/dlp7QzRj06GlPRk2GvncjZTpnktQwQcP2jSzlHe1X0zPMCskZAoXiRl9Sk4RckzxdBZU/psLvEMUOwgVsZf+7jJMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739855161; c=relaxed/simple;
	bh=dJVr2yT4DipbSLIwFSFcDKtcHwWX19Ib8fGbCNlwipE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFFPe3b284bBXW4jWnj9XuFKf4sf9eR3nGYG9R+nrLdJDWR7gqHH/6+8imaGjDTrYIHFo/2A8ztUEWAQGRRyINjqo5k+Z2v7gkE5joPvagE+PMzD4Q4X6/Omd54OiEnurXfd1iiilDxgCF7WUsogpLZoeKo8bcx43mRyTVX80nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkLooSNF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739855159; x=1771391159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJVr2yT4DipbSLIwFSFcDKtcHwWX19Ib8fGbCNlwipE=;
  b=PkLooSNFZI+jr3JHMBXRq80KjyCmCQtqlESb/MzauFnfKMZFmG5MeRvf
   hKiyE/WdN9QhIzPbtK/HG+8Bl477wOxGcwvos/oLYSfmpW+UlmSQk1xte
   h1CI/36BIIbsAUEPw/mJIL9tFE6hTU51dIGQV79oxZMfis4ZV07+2PmaK
   CD9I9FlwLIEiX/PO+CzO5t87t/Sjgcx/nCZlmZu1Iis23c/kFxRuSzbX2
   6AbiT+tsf2paUarDNEJnuRfS3/thMfhH5abf36r8yg5oH02EA4Afzhwm7
   Z5omkIHN60jOLqjuMpGYohpHKZ9iZooy8jUT8A5tTvRYKKFJMMZB4Roc/
   w==;
X-CSE-ConnectionGUID: kAVFXPuATwqiHPX6wKcSQA==
X-CSE-MsgGUID: 2V2SYASFQlGBRoQ5Yz5fxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44463520"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44463520"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:05:59 -0800
X-CSE-ConnectionGUID: 75HfAZ9TSA2xpXyFjCY1UA==
X-CSE-MsgGUID: mABipiEvQVq0eIWijUqutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114754150"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 21:05:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 21:05:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 21:05:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:05:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJLAIDjF4MSEmBuX1paJ8/L/U2ME/VHtsB5olpThnARtXa8shNyifh302NeEZKZbjesyyvzQL7dPj48nS+RiMG+Zl1+hH5C1kaM/OGb6XF4VaOXke5pVlkCm8Uc0QNWxvTppYWOgPrFXBMNUCuww+Y5BrpD4mtdfuN+bG7U+kYDqksohSRxYicbky5pAoSbxiBCL0Sz4kpM0qLBCHlWCqDf4hZa2t8pkVV2vb1ojHFIgH+uTq3ZrY1wEv53th/kT2uuZhReWccSACdZz40ngMDJ5ftb//dUviSQfv8BnuIDvEQ6cnjrkn3+BaDXf/kaq3qrPm6xP11FWEiWSLMcILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJVr2yT4DipbSLIwFSFcDKtcHwWX19Ib8fGbCNlwipE=;
 b=IxiBUn0nwxnnBhVUT2Oqy4uPqQD2sloEe6KP0agFagfpUCuz+etvwneplStY7Y0xHyy9Y5W6vZpwj9s4a5SwOSzBU59+KQVhPCIIi8211muLmtwoRCmrEKtqpryHripF56/ykBnGIkcYdi8s1kgGmmQ1cTxkSYISaNZid/GJ6SRxXGq5zv05OmnM90LBs4RPGRRamWAh5nK+4d56c/NyTVoVxmmUWwafLOu/I/0/z2Sr5G77hH+3P5Oz0jeIPKtSS3bE2fYPXqgtGDwOi7KY3+IaEhJc1uqqi1c87A3VNCnCEOKaAT8eimNH+vqVCdmZ7bAn5Kaq0Yum3YGpNI6Sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB8778.namprd11.prod.outlook.com (2603:10b6:610:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 05:05:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:05:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 01/14] iommufd/fault: Move two fault functions out of
 the header
Thread-Topic: [PATCH v6 01/14] iommufd/fault: Move two fault functions out of
 the header
Thread-Index: AQHbbsByR+T3yhH5dkaDWdPy5109aLNMp+kA
Date: Tue, 18 Feb 2025 05:05:54 +0000
Message-ID: <BN9PR11MB52768167F61D64327CB819CA8CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <d47fb648e36a6a5f04e0d98d02fa71e47c4a77e8.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <d47fb648e36a6a5f04e0d98d02fa71e47c4a77e8.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH2PR11MB8778:EE_
x-ms-office365-filtering-correlation-id: f1008adf-7e68-4a56-cfa2-08dd4fd9ec13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VP01cC/3R0hIyjVw9sGgTzeahQqD9LzZnusErTNvg9XQp9mTjmCMKppjgK4i?=
 =?us-ascii?Q?mWhKaPzdSglDQ/UByHgLlvuYIlGQCGB2wdHv9HigbBgITNdJFQ6ii5XIiCwc?=
 =?us-ascii?Q?51OdkpgsXNV4lFhKe1th2UW4XSR5a10S8ineBzNa78nu53zPqbzd8uevjJuN?=
 =?us-ascii?Q?RHUY2FWeXnEJmlrAt7oYqdOJrEjagFMQ8s4zfSU3l9C+FYtqzjVyVf4RLo1S?=
 =?us-ascii?Q?qocvGWNW2dqJvL12obpgjn5+kb8eiiImv2dhuIFqxZEwB8c2T2UgxdxSoGA1?=
 =?us-ascii?Q?TW+CqirRtBcOl0+IO2pNX38J+dFpil3/5AX+8Igz/Gu8tgtljBKp3oxFQy3f?=
 =?us-ascii?Q?NcxoJrhYiaT3IKJmlHVv6pzeYIF/r/j5ETyWWe4/FAnWIg9Lh3fm1T1AAjBs?=
 =?us-ascii?Q?Fr5J/YhUO3qplPWrJjwcuJelml6jZLsCT7P/uewrWyzeydeWafCj4N0CwmIm?=
 =?us-ascii?Q?GVggZcvwm8sWBXiltyB0EggCRvrUNNc/9+ZTWVTp/Dqhgxjev5azXATPSquS?=
 =?us-ascii?Q?NkBm7skpN2JaJ7gFgDedwHSvSJNqKQ8m4ZRYp0H6KYyHNH0xNDaD4k/li/xC?=
 =?us-ascii?Q?5U6NMNXN+xepDAeOd7yGjUhiviLmVpczTmDG31Sq3KLfHwW2JjzyPUHHpL8F?=
 =?us-ascii?Q?dHZ959QEgEj1sseS9xiWqz9WyFFe/m+8tZaX1IPIyBrY7Qu8zIHuuPm4dTCf?=
 =?us-ascii?Q?fUGbSb9Pi9bn0gSLYjm4kedbHVy+j7OLr1MOhFLStWZEF+btZSkOxVsvErD/?=
 =?us-ascii?Q?IdfBG7gtvpgWL1BHuumKhj04ptwoi+6cmc8LI6ckzrl4UDCPH9kBC4u6/pRm?=
 =?us-ascii?Q?Wn+judkiKnXC4zULmHtB5jO2HEDBulvl+bwno4yV3NvahtpzPd0efJisa0zY?=
 =?us-ascii?Q?iyKwiYLk+cJJVFzsQIzg6H4Eh5JwMOb5jsbSr+jwgBdEhFFg/evrf2mOr3Lo?=
 =?us-ascii?Q?rbo8tkB4PxzHuEzfxdAcwq+0ys+5Q9tZIHmaahIJWx1Lnzk6+P4R/mPSgYA4?=
 =?us-ascii?Q?qhw4RSIr1WeRiaH/doIVGqhEHtCHGhU2zYxaFQUx7Xuczb0kh+0CadDq6Npp?=
 =?us-ascii?Q?sgOBSyoJLoLxLBboE8kfY6gX8zJkxVKAJ0J3GR5n8PpulezeRPL4O2jRLQiB?=
 =?us-ascii?Q?m2IY0lVZzgw4OvKUcg6d5L58Z4dHkgy1Sv6Xl1hC3SCxYkrOxqJzGRoO8MCt?=
 =?us-ascii?Q?PmqTIA2ZhyqzRsKap5rV3qXqdcuONIosUJ4t5Xb6T9POwrOe/pM+M4/1qNWe?=
 =?us-ascii?Q?hd1GG5GOGeO1swpuHQfGq2kP4SjKXwrSI8FD/gDKaxMOwrITWWlGHhuISVE5?=
 =?us-ascii?Q?/ovD7vBwkLbC6dGK4KNtrOgvDv2MQvush5n0RJyjd8sbLw3YqL7qgd9Izp+E?=
 =?us-ascii?Q?dELuuGTrKwzoBVA9vbyNGMCoAtbTfVEgUUBDnsZ8I3ruYialaeu7e3HuC3NW?=
 =?us-ascii?Q?JvJG7465TU9viVwUBih4MixsV6alD7MN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y8J3Ye51+u6DJvQfLDEMrx+Oq0lBQDymefd35f+CBYQ/g+jLcx+/gyQKO1zz?=
 =?us-ascii?Q?pcqZAaBZETBU4yJ9KEo3HZDMNj2IIPG+SJPX+Ww/Idb3kRy43amGvxAPpx+Q?=
 =?us-ascii?Q?OWKTSKcPx44MdFk39ka2kJ04g9RwneAy2RoNsbIrzEQG5USzDQdK+eMQJbIZ?=
 =?us-ascii?Q?QarPQ8KYb2gzqXPe4/PArlSg7Vb0wa8PRCiGv3KQlPT8xO6zl4y0SfznS/44?=
 =?us-ascii?Q?ZehFDmkC/8XCM7YY+qjykBkrntObUQnf3I8NdT/Rv84TjaZKWo4PtbQ2CvhA?=
 =?us-ascii?Q?t8snbGfTqOwBcV4JohDmwxPo7PWexrdUxdl9PMYV0utx730b2zX2tD+oMKz3?=
 =?us-ascii?Q?wPZtvEx/RWvWpO+8HWCH27DC+CcNG/G6l591aVLP/441tVKt1lBKBPM+Rn0I?=
 =?us-ascii?Q?XciTO1m8IBCR1j8rHiAd8NtKKauX77L5d8rLc/yNHVcQBg5pdSDrywB6KSC/?=
 =?us-ascii?Q?WJKDMV9xBIck2pSSeC/YPaifeP6IZsBXi3pcFFwHuCGer6g49u/nJqKGIRQT?=
 =?us-ascii?Q?ub5RCXNlcWLKgvQz9R/V8RJ3z4SEYSkWelajxn9e0/kJj6vqwI8WC8JQJrio?=
 =?us-ascii?Q?7IDsees/51oMRHiJManl6ld4+WezlAd9MH56ML85VvoKex5FQzu7bR/zmpfT?=
 =?us-ascii?Q?14fgn8PJn9Yo2Rba8vRHN/baomjo369eaOPaUUPxzgxDkw1bLuXF614QfrFe?=
 =?us-ascii?Q?9hJ9MZ9925M1GXObwixOM8CeJI1JYBFCdXE3WtfiNsOsLeY5MXM1QcLveHzv?=
 =?us-ascii?Q?ScjfkhYne3MNS15hINONAIR13LXqxJe+bmvrd9WJixqWjGkp1Fqm6ITh2F3W?=
 =?us-ascii?Q?2/GXOYDllJ1eRrATjjc6+M5OiB5l14YVSOVfMRMh75KvMxKc9onVO1d5lvdt?=
 =?us-ascii?Q?jAbY9wlPumPiubAKDofMgy5h/9mkQx1WCYmHtuGfl8cMqkUJwRmkzlIPtM39?=
 =?us-ascii?Q?n+xPHDhLFs9cRQmnba40zBxsift80R0BhkZSAEWWc2JHqoPuWFORwgvxYA1K?=
 =?us-ascii?Q?cAIPD7wEQNkHpAgdXwJXqT4E9BPPF0zHfzVjhZ1H6r4eJEAQfgW8PF/UB0H+?=
 =?us-ascii?Q?fqsJTkkUUKSt/7DCT8TlIDbxEHav4aKpBW12esLVC5Y9FIb7137acI9IMZhl?=
 =?us-ascii?Q?wFpIMSpycZ60KpcvvPG2svFjRgFNc/O/cfKxIo/Rto3n02tyi2fh1bjikZ9M?=
 =?us-ascii?Q?qKQNXM1z8Q1lTi7jHF1B2YMOoeD2o4oFEKx3lHlvaUIN0qviQxkQ2fHt0k2+?=
 =?us-ascii?Q?fZ4h7PeDBPywEtStOTOgZrq0w6oZo4m9Tv487V1zrn4HwsmCNzi5M0SAEDnl?=
 =?us-ascii?Q?ZxaXK9RaJgAg7Py/5S2UdDkMweb4nYUNaiaddBUmO5svVuMgyjooHP99MXj2?=
 =?us-ascii?Q?KRBykSOnMtgxUi4+9UZTqkU45+MJRI4WhqgbBQCDdyaNTLD/6Ex6wU1DEYWh?=
 =?us-ascii?Q?xVOkOUmwYhAEF1JbZoy5i1t2+SHvENxwYECAQDE1g67vOi+W1sGozhy5gdx0?=
 =?us-ascii?Q?ZuMIP8rACeRYruaKqHwgfEgcuo0b0PLRUXbE+AfW68a4ZZGCCuqKvF6NJjpy?=
 =?us-ascii?Q?WeEqxNtBO74wFc5O3xRf+k/EzgmWfHLEHcbukbIQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1008adf-7e68-4a56-cfa2-08dd4fd9ec13
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:05:54.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJp+ueJQ/da9UkCVqSfpACJOD+R53OQIUliejjvU4tO61GFOT+nWzWV9U617xhCR3haVk76RZxvbQVqlFjtAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8778
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
>=20
> There is no need to keep them in the header. The vEVENTQ version of these
> two functions will turn out to be a different implementation and will not
> share with this fault version. Thus, move them out of the header.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

