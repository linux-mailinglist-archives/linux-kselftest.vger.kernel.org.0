Return-Path: <linux-kselftest+bounces-21064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A29B58BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3773DB20F8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D91AAD7;
	Wed, 30 Oct 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfQd6br8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE53125DF;
	Wed, 30 Oct 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248914; cv=fail; b=EYNx8b5Wld2T4xebmnBXWFqzTg3iwaNni0JKK4bS443T/bLVI31zM36kAEnG4V0iFV/7cry2fF0cNkjjvHoLxOfTI7Qx7FDoL4w3xryNuM7bQRtGyt6lNkRFlMFhb4gWBvoPabkqTmPoiSmitFVXuvdepp/m7yyn7PNl+vMsMJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248914; c=relaxed/simple;
	bh=tqbZcYUkGjwCBOBHh7c2DQuE/iyuDDIf/ixVMOGZ/HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwPZUtCWvOgpATSmxYslVN5+DGpodgrTbkGWUb0b0QlTg6SmJh2lUPhsD8r6uasIKLMSp9cChV7DA2mmJ8dj/iNumhl69nSbNNcIEl/8j67GFOQQgmfuz3jxDSGpjaYtdPdEyA/BKKIOJlfetWL4JmgaEInslEOlMxXqaWJJtOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfQd6br8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730248912; x=1761784912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqbZcYUkGjwCBOBHh7c2DQuE/iyuDDIf/ixVMOGZ/HQ=;
  b=DfQd6br8i8nFqqsPncF4VNPAOwwgqZhKm/JS6sQEIWxnOt+929yF+3tq
   HPWky1GHrUxVo00msHkn/cdl6zpeYdKhK+X3N0ZZXbHuWzUB4nLYh4cdT
   huoyKmkD5Vm+XVAx8lGFDZer+dpFffx9c2WCfb3HsVeTNGv/iu7TwfDf7
   PWaxxSNIZm9mRTa1G6flil4h/Ack+ZfHnpdlRLi1caP7h3gIJ765bbZwo
   ZSr7SJqzEix1I/ILYRRXgXEqw6HZe167P6Cy7mxNQ42rOa0HSB79qjquI
   VURHqk/0QiB6G3+VnCqm85sqthJnmRo1BuSqWmDeR1yqrYHX1f2wcjtf7
   g==;
X-CSE-ConnectionGUID: yxiCRmruR5mebBDBs2LbmQ==
X-CSE-MsgGUID: mbGiF0tLS+m60hjp236eYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30124065"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30124065"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 17:41:46 -0700
X-CSE-ConnectionGUID: E0QsfzlJQHe+RTELNrVyZg==
X-CSE-MsgGUID: J2pB+tvmTNiQQbx9H+E1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82558175"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 17:41:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 17:41:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 17:41:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 17:41:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9YucwLUPHiWwI3mWAJdGqnlvfUS7FKE5eebl5uhrkkollS144JHWUD5f3SzF/d85A5HMpuHaOyqh8Ohu/7l/rYwx7Ttzg+LaDOnviMVMt4lNr3h4jqdAgqZe6SUX01Y7shwGaHy3HZIDD8ThPcaGzrHdO6zxSNZ4+dP3t1q4N+iiXWLzJSR6r88lUy1XvGb5pwPh4iV/bvlXMgXA8HccaRAYSbzOUEIa97A1LIGk52+vzxuIwqNNVkwXTx975iIK/DR5UolpPcnhsTORpUFwO/qTt++l94M5pX+rWpZXdF6fEvr1SeDEHhLRaouVUSK+elcQiBmkq+lOJ2+/DM5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aldvFJ1BfUtu821Fn+oBb9WsejPxHpMmlRIq53l2lqo=;
 b=YHQz/etBR0EL8a/heRP/HPJlR+MhwK7ny8+hi1I0XPgQuROYXuVcxMLh7w3P5vEKfI73/CpoU4E8cwjOWrw8UAaqh7/xzIhECj7C7uasettXj9OeTfylbr7tnOG0iNEZWlZIeFwUlikN15ATTlXrPl+Q0isiVVAHvf9nFxnooJ4BcKTpuLe2kG1FcYEeriIqDcXaZeGJluvqmGEhYp/5OZHpxQmpH5SASAvIxKJJ58rI02SedDY02059c8RgbPhxviN7G7LywbfQ5NKximHHHnNSXK5rx2ILxexOXT/mbN4w7GIgHnQhKemjSik+ViC4DDuvKV58bWzSTmvsG+XV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 00:41:33 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:41:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op on
 vIOMMU-based hwpt_nested
Thread-Topic: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op
 on vIOMMU-based hwpt_nested
Thread-Index: AQHbJzjNUAV67+f8cECZZB3t9YlZFrKdaC0ggACB+wCAAJAZEA==
Date: Wed, 30 Oct 2024 00:41:33 +0000
Message-ID: <BL1PR11MB52712B1C48F93BE78F4203828C542@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
 <BN9PR11MB5276EC0C0CBA3AAF700B57238C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241029160458.GM209124@nvidia.com>
In-Reply-To: <20241029160458.GM209124@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL1PR11MB5319:EE_
x-ms-office365-filtering-correlation-id: cf519ce1-feb9-473e-ffc9-08dcf87b9a54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jc5LujEU4fKahINlLSw43LNKG60+7tl/9nLAF930+rpBwp58HJsL2A+np05i?=
 =?us-ascii?Q?U82X/VnjFc8uaePAtkHGkjT71khzofPO7wB6TXmEADbVktGLQKfFUH7UTWL9?=
 =?us-ascii?Q?KAPMGz9SAGZzD6SXMIjJWf4axAP962d2fLDZ/PhHJPnMjf4sVJdn2CiqsdF5?=
 =?us-ascii?Q?XBAX9I8W9bBWs+cq4dS2GAJOt6TwsiN21UQKB78kWgC412OmuvnbCDFkc9U6?=
 =?us-ascii?Q?xrX7fIHknG1tEdKl+NwJofzoFayxWZm2ISHTK8afEnMtpQIZmmyYkxVzQleC?=
 =?us-ascii?Q?OJlzraapYo9tH9FT98dSLlw1kC/ckbNL7Qnz2o3rGk77GB4M6XmOnAZr7A3+?=
 =?us-ascii?Q?vCit48f1H1rkMAaaVSwPXUGkUc8N8EV/hCbBA7zf67z4Jk+qF+EfLeYZ375F?=
 =?us-ascii?Q?8qeWt29wiVWmpTItFSD0ko9orVxpOb/WPKGWZltt2khksMR7Maswe0UU1Lmo?=
 =?us-ascii?Q?pDrAvLFkn580tJQIGyPNhPW/uwUjqPCDEiYy63ob+X2wNDojgFgBGWFHjVWt?=
 =?us-ascii?Q?q3jCapuGeWOdYlLbKKAuAdu8jZBZYtI8kyKspCl3ibPLflZrebBsDCwn9syw?=
 =?us-ascii?Q?fTVjQGfFjppLEK56nJDigyFN8eLyRjNAg5heBapAK6Ed7kP5UzcCDNF65uZH?=
 =?us-ascii?Q?dE9f/r2fledo3HrgmVc+mvrbBTDVYo5+p+kiiaUsMLn72ZpcyblJJgCOh0Tj?=
 =?us-ascii?Q?DVZoHv7G1r/3l8bHiGaHOR/YB4lvF+N4KDBVwHW9o2be0JDiC8j6mQMQi920?=
 =?us-ascii?Q?OC9Y2aO3aFokCFARZMqAyxLSHvXgA6Wpd0mYDjO7EF6mfgx3iilMPHFLNUBU?=
 =?us-ascii?Q?KoKOfz2uotE7DqsDHJYAon0ca7Cpobb6Fg9enWq8UlyE9bp56WIQhsuyF8qV?=
 =?us-ascii?Q?cr0zkxkYXlhw6avsR2gM77r+kToYfKgMGmwVKwCHzH7EdjmL8WxOZ4p2uCuf?=
 =?us-ascii?Q?3BYLHC7jDEpfJPNAOGCi6kKVdk+/v6Q0Uk62DO7IW2ksiUa+y5HoBfjlX409?=
 =?us-ascii?Q?khhoZH91Ng2vjYJCYEqfiW+5JX++RUo3NuZ3vCNC810pNQWA6Lk/xnETz5hD?=
 =?us-ascii?Q?QK68cMcKnK5Sgy3QNx/qagVDrDzsM8aLWIP3yr5tqAgwRWBS6y3Yj6jUcej7?=
 =?us-ascii?Q?IloO6kt+Pnu4/QHxk5ltboLKjdas9VfxKjS0T1/8L01tuUw1ebnp39qEfz9U?=
 =?us-ascii?Q?xcFZ8cw9stij3+3yCpmaExbb9F+LPxhJxQPQ8paggK039T8Gm63dFNBbTCLO?=
 =?us-ascii?Q?SxMjxC0Zkkw/jNtQINQ2/ZNe/kcyi1peav/18hjdhUP+tFkN+IpjZaDufZQ0?=
 =?us-ascii?Q?QiGecA4dL8cIk2qT8bwp7nijoi2Ng1SYvSjcIZ54UXK1H3TopbAzHJMdrCNR?=
 =?us-ascii?Q?/q7J7Bs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hE1U4rSwTz94maFZYYX5fclEL+KKYN8IS2QWEgHyux/aYLLHRn0ooLcjthGY?=
 =?us-ascii?Q?Hc2SPVlVsnRaikc4sy1YcSUwnJuACXiz+3KPRk4lSri1KPORAY3bk7/z95rz?=
 =?us-ascii?Q?7xNkIXW7APLn0WcMp/6Kk3PH8PSp7o6IRNPeOHhC/7FAgZ4rZbLmfl2oB2Mu?=
 =?us-ascii?Q?DrBO2a2ytZqP296s1qFzIhrKvizOBOSkH/Fb7lZOSNCoDSvWS9rrbMOLratn?=
 =?us-ascii?Q?gmj/n5vbSF0I2M2V5LamxA4+aZhRXjoWBtZVZ/HUkipLd+ogdXkcG1fRQFyZ?=
 =?us-ascii?Q?I5spHlESdVDdPJA3IvRxl3TChHMwqpWVR7mzgGaIH01ng3yXPBMB39DnpHVQ?=
 =?us-ascii?Q?K/L3qqFp2SyUYqnwVcV40uRPORcopmBY6iYQK9PxTwute7lfRj/XHcla7Z/L?=
 =?us-ascii?Q?j8zX/nrHZWZP8YU1tD2tYTkLXKMGlThuyp1MFjsBpK7+Px+YFw/2dLPs02wD?=
 =?us-ascii?Q?8lrX22cFPYqdXIM1to5YX3F2/pNSmPE52CAr8Gcgw008GIYFseLL/u5p6zWF?=
 =?us-ascii?Q?PryofNtf6kYR744fn0TdpH10Y7NrCHrAX0GQ2EzgX2KxNaYDbnWCMgMiIvCN?=
 =?us-ascii?Q?v/+PZz/tShXWH2HO5RPiGI39oNgTWLnSks2JjHXpV4pBdXJOer31TfjG6e+m?=
 =?us-ascii?Q?PLje0rjqTI1qCEBPtCRsQjOINzqCKWq/MvEDS+RjVrEkbPJnnmBUEJ4mQ9J/?=
 =?us-ascii?Q?dh1E/J7/GjM1219ePANCr+so3NhMCU2WUYv1Q1Sv0jJMxrDGvRhvzb247u6J?=
 =?us-ascii?Q?fi5DrD/7CqHLoydX9DekV2CsXJNl2lOstlPOXPEevUFdUy9xXlZk0VimKVV4?=
 =?us-ascii?Q?ekvqg9sG1EPcb+XJhZY/Ugs8GD1EABGhfBSOBixLrZ0wWOU0a51c2W8svRuY?=
 =?us-ascii?Q?toLfV6RB/shTUumEdcJs9byULUeWkod+ejU8BdSBnJcMCtfhJUXeuYrWu3vY?=
 =?us-ascii?Q?j7LZIFMQFCRvx8+vTUy/kvKF0Rzn7u61L2s6hsEDbrlyTHOI1mM2ipqPmSHp?=
 =?us-ascii?Q?SdJ//yacYhquYNEuLTMRmj/r/GBRRFGK47Y4xEluj66JjZSLMBLPjjQVvmii?=
 =?us-ascii?Q?xhE8MoLggPD41jDXXFaV4CAmRG5f/PFV4n/DStaCGd7ixiRtz7lZWh2japkl?=
 =?us-ascii?Q?7aM02LqrfvjxXP6APb9TU/SszgRb4MQmnoinmBsDTju2Z3TnNDQZf4UR0+9B?=
 =?us-ascii?Q?TmyoApcq5YoOgWrdhTC99TAbOngasWdXuLczhwhZwJm2/ebR3Yhglg90st3M?=
 =?us-ascii?Q?azOqTfYs5HuRKX+HmiH/cDv9VRpENY7CxvUBEm/ZFIozjFG/gHX04OmBLTVQ?=
 =?us-ascii?Q?Ddz0Z2FwnMsAU2UN9w7L0T/FaKyKCyVn4ZT8g4jheCd4zSrG8EvMqus8X/1F?=
 =?us-ascii?Q?Ma+Haf2lRQ7n38dqygCIMXwbSjCd+R35DXsL9XZrrWWH3kdSreoZcu6+3x73?=
 =?us-ascii?Q?MqeJ9+oL8lPRf6bFX5IAR5zz8uWKxzgOJvb9mP7ftS1lJooR4LjlQDZyfjgZ?=
 =?us-ascii?Q?53yEv8CYd0uJPW4p6rYwhz97InijEwJtndruHgiwBwYtVWJVLr3+z3uvUH+F?=
 =?us-ascii?Q?GVXyuNCMJodZAr8HpgT6CuYik+LIQfoTo2CS0rx1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf519ce1-feb9-473e-ffc9-08dcf87b9a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 00:41:33.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOZLKk1LPV3jZlgQGEqUugOZGMD0M0hB7SevES2IV9Ez48Co+joMftf/nNORj4K0Co0cN9hCS/j1bHt3DJM58w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 30, 2024 12:05 AM
>=20
> On Tue, Oct 29, 2024 at 08:22:43AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, October 26, 2024 7:51 AM
> > >
> > > @@ -302,7 +302,9 @@ iommufd_viommu_alloc_hwpt_nested(struct
> > > iommufd_viommu *viommu, u32 flags,
> > >  	}
> > >  	hwpt->domain->owner =3D viommu->iommu_dev->ops;
> > >
> > > -	if (WARN_ON_ONCE(hwpt->domain->type !=3D
> > > IOMMU_DOMAIN_NESTED)) {
> > > +	if (WARN_ON_ONCE(hwpt->domain->type !=3D
> > > IOMMU_DOMAIN_NESTED ||
> > > +			 (!viommu->ops->cache_invalidate &&
> > > +			  !hwpt->domain->ops->cache_invalidate_user))) {
> > >  		rc =3D -EINVAL;
> > >  		goto out_abort;
> > >  	}
> >
> > According to patch5, cache invalidate in viommu only uses
> > viommu->ops->cache_invalidate. Is here intended to allow
> > nested hwpt created via viommu to still support the old
> > method?
>=20
> I think that is reasonable?
>=20

Yes, just want to confirm.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

