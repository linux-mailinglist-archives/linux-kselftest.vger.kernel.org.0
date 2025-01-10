Return-Path: <linux-kselftest+bounces-24183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F0A08854
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91768162C1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC02063F1;
	Fri, 10 Jan 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjr19lzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CFE746E;
	Fri, 10 Jan 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736490417; cv=fail; b=JKjUc50Puov1L2a6ubQC6koUnMdJfbHXikmw5OwcmkYzXJpp0Irp8ZYY/EsVJqptV+XxHhw5apxdQsVsGCTg4K9O182Gr8tbO/nHFNpoKmWjMN9D6Oh0ryrHCP9ob9kE3TmcFgZiBtLCxy0sRwX0XRyFrtsCRbarbx99t47nYto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736490417; c=relaxed/simple;
	bh=Mn6tMZhw5YSpy0oKWijbUs2oYhIRG5nNgkPBvWrjndw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUnUF8l0AdYbTpgQVjH20pwVCmHstPo5+7fX9BA46M7VcKJXpgSQijGIiYE84ljRlwZmYOySzc7VFxoh4n3DDoQYDzY1qhilfAW6KQvNLXgKS4Zx4ZtsZULJM/hzUr2QYwBbNkYAsEHi9Pdvtod7M0M9I3AgyUmlBHWnOIcVt2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjr19lzw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736490416; x=1768026416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mn6tMZhw5YSpy0oKWijbUs2oYhIRG5nNgkPBvWrjndw=;
  b=gjr19lzw5a03T9VF2Uf9SFFfnfLRQENhbyImC6WXrlDOgydv8gdyZZar
   IM7TFWLUPzdGzDOrfY2xHNomku0lTrKd/TooVse3RRRJGBL9VCstaONFo
   9HpWJtBZLavVOnorQ7Nsb+KDTWOBIrzgkEuDn4aAWQLzhwT8GgFCCp9zJ
   dEomqfwaxmRnvdky8bnEk3aFjLxLq6wir0ix9HD8UuEZNbU6R9+3d2UZU
   ffJw/0WyaWQv1/WxKZ77JmecbbnyxgV5GrMjmUKYDhJUhO8EiP+bBP+JQ
   D+rcdMVsKXVmG42pGgnId1HDbmtLa9H1TLwW+Oytw0O+i11gv4LUicJhm
   Q==;
X-CSE-ConnectionGUID: 6mY+t1lHSnWdyHcVzGRLWg==
X-CSE-MsgGUID: EzWspitFQfWqVP5fm8x8Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="48188574"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="48188574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 22:26:55 -0800
X-CSE-ConnectionGUID: D6nuWdo4TGq6PncNkJZl6w==
X-CSE-MsgGUID: bx3JX+h9TQW2KEs2XUo6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107692629"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 22:26:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 22:26:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 22:26:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 22:26:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICXjl210hu8kjizMCw/PWJmHlrhlLGADDHOS2bkNchQhVgyjN0TF6fONpkqBwqTQHqSo/IH8Xfq8PyEd2rELkjtQnMyhRH8USozNUvfKyiOaN35e3vjljkmqWOEi768HBepXTPtzTAP93gMFi4aLAmJdWR+S95N0pfFSKfGwa5k5VLhyYPMKqJ5jy1rwBLQDo8XnkUPCXxNBL51Wni+7oSM829+2Tz8g08n76VZ62zS++hUR5YSn7UfBOsXUEWJPUZcd3XrIzyISuCy095WMP27fC6fN2RUdQS/YIy8d3XRPmLAQ3LshT0fY9Ii6tV0mwIDoqEzRfs8wEbVhByAE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn6tMZhw5YSpy0oKWijbUs2oYhIRG5nNgkPBvWrjndw=;
 b=cQOYzsIgE2KeNRdKel5XbkaIUk6NMJOXOHRhgirf4DbFi/aNQBdk7yX8E3hnIEUTUaJqx0AV1W1vFAhFN20H4AOtMRBfwzKYhmkyGua2zOMzybeuJZYYSZcFlpRXmJRwd7qloKdRzgqM3mdM2o9v6tZ0qsDyoOBsg9Wg1jU4IQMD0XSHgk5vRtdKAU84Tq+aOrSQJNthVpiIQ0ncOSm0KxmKubgHQDhbOBW6gWF7DIL3h9ScjWCU9WE/1Ews8aLaPIGz0SW7klXPeltoaoqTdoqXoG+B2wrWH/AISHM2RSwsnzk57VBUqoGxTS6T1CYCBBXXDmbCAOPM+s9tjKnX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7266.namprd11.prod.outlook.com (2603:10b6:930:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 06:26:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:26:24 +0000
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
Subject: RE: [PATCH v5 04/14] iommufd: Abstract an iommufd_eventq from
 iommufd_fault
Thread-Topic: [PATCH v5 04/14] iommufd: Abstract an iommufd_eventq from
 iommufd_fault
Thread-Index: AQHbYSc4ImwTbFiHj0GNVkJ17O64kLMPiJUw
Date: Fri, 10 Jan 2025 06:26:24 +0000
Message-ID: <BN9PR11MB5276E53C001610ED08C5A0CA8C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <a6490048ab3df78f648e3ef0d217a90b7213d47c.1736237481.git.nicolinc@nvidia.com>
In-Reply-To: <a6490048ab3df78f648e3ef0d217a90b7213d47c.1736237481.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7266:EE_
x-ms-office365-filtering-correlation-id: 5536e980-078d-47df-0f8e-08dd313fb4ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IlAZoznxdS99lX3WcRNb3WIvennCWNNXmx5awQ+MPj/nroplJXA/oM2NmpoF?=
 =?us-ascii?Q?JwEEq332k7AjGtXi/EK3/c4axp7DA/LEPNfHHZ4t90PBIH8R6dYJvjRAj4fe?=
 =?us-ascii?Q?OUJSocId7EBWjRnEReDRBvSBeMjBQBdJjw4cPOwcWeMvL0eDNhu/7v8VnRiD?=
 =?us-ascii?Q?EvTPNGVXrWxrATJhQnz4q48NDq7iLIoAGPfwucpT8ZUoEsYCQfqjRSt94gpX?=
 =?us-ascii?Q?t3MeT3eiOwhWARGNeUiyB38ZaL9OMwgHbspOGG/gys4x+CMxMADr1gG8IH1x?=
 =?us-ascii?Q?T0hecmX8NON6Ar5+UKZ7L6MBw3fwSq5jh8p2Y5V/pg0+ofURwWH8437lgMQs?=
 =?us-ascii?Q?wmgLVw9g7oQbGZfXA34opS8YJoyQ8T+o64cdRrHx+KvklTl5tde9NplwBnqc?=
 =?us-ascii?Q?nhiZOzZNKo9rj6XNQw/JHgCGfcRJldH5wI5xW/lRmcUT8vj7pfT1MYVkGSzW?=
 =?us-ascii?Q?mSAAXCB4XNtrhtPto2wHEBERcXuEes/73kHqgQ98gEfbxE2yl8UgoVmWNbcC?=
 =?us-ascii?Q?JnzyrT2hnxWfc1F3OUfCQU9F4P5esJGvUmj3L01w5LmDyDBMdskPkqoFSh6g?=
 =?us-ascii?Q?8yo7dNaFPfkN+oTatfylxiYhMOzcJWxDxYa6TmfC1DOFA6+ojN5IJkCE0jV7?=
 =?us-ascii?Q?nhCgkjw7VmvOjmLpsMwllLbAXBdU+PstIxJ2Gf6gF26F/BOGLXhe6981+bpJ?=
 =?us-ascii?Q?0dGPK/Xu4kT39fIwbAENIACS9q//iZwhCHkxsE1LxngMtyYEEKE7f+ngNoox?=
 =?us-ascii?Q?fmFdNK+14u41t7DC3GejKfJAL80DTm/hmuU6Ai9sxt4kX8up+IqvTzv/YOU7?=
 =?us-ascii?Q?Jj+hbzk83ZWXttH3ILwwjj3Ink0kvuLet5sVbB49h71Wu6Mp9YPtodiMworD?=
 =?us-ascii?Q?WwRCe6LeJ5wpQjh3vCHdBb5UxfpxgKPgTjWEk3tJt2jDIEeWXtYEjXJU8lp7?=
 =?us-ascii?Q?BtLbg8sqP9fXVRSkOXq+vvmVUmiUzobL1zICR15/yTS59iHvkEo7lwCtRwq6?=
 =?us-ascii?Q?IVpAwE+RGKygRR7hOP/ypmAC9NLp3U0xUSrQ8uTAK4NcRJHndlmbdC2nT4oX?=
 =?us-ascii?Q?62jSEdNM9DSRSGIQ18YMk118euD7Y/GP128qe9WNBS5oZNmeLwS72YbcUurM?=
 =?us-ascii?Q?xltT/CUpDjqJrIdFIzipRBGy0qU+WZ/MsGwOLgdoq1Ltvu/M2rwjnV0mBVmm?=
 =?us-ascii?Q?wcD0hth4uc5QLjrxUyvPeUCpTKDw/yYyNpeIDPnVUHflnQ1wuuG4eVwhc6Ny?=
 =?us-ascii?Q?ZEODmZNZYJ3Gsce7M7Zi+AbSfs9UdSYSqsM1Un4cXCvNg+DsfmsqoQQTQdVD?=
 =?us-ascii?Q?g8sFT9oAbuboq7NSmeVZfR3bcebjFzz5a4ILYyE4U5FVIcI+Z8xyq7XYuFZg?=
 =?us-ascii?Q?ErVFRfJ75tXIojmouXLpG307HwcNrmbmd9b8NOL/kKeL2g+v1NpcTsqlBLcE?=
 =?us-ascii?Q?sX7MZUFY0Ai/iUqrjG36Ul9iDQrU3tlo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zwetV7N0Gntu+zcQjZwntmupmD8u9jMtdqQGulh3ZPcbEXgqPxthtdwD+86B?=
 =?us-ascii?Q?+9wrz9IpgNfgSeuKHz8dezLJ//c9/TcwatFLw0dfi0r4sCCDXNZVNwLPGSkM?=
 =?us-ascii?Q?Dft+4IloTbNNB66KHWoabfAqRwrq8w3XPu/Va5gm28WLbNMUuudqD3qwYPdT?=
 =?us-ascii?Q?L3l7+1VGn9VAI+MjjjGm31wRb5T5BbiIh80bds3o2seLlZaWFQtpbLiYhQVr?=
 =?us-ascii?Q?flXMYospXJO5TiKRTW3e79Cmw2UnTSzTADXus56LP7xky1M39OyvsC9nEYRY?=
 =?us-ascii?Q?HA3LVEywUdOU8H7bYaTg9u2Dg0Ch3s6SB1+ICLBLeoLBapy4C/jixyH7AaU6?=
 =?us-ascii?Q?CeUsv4tewvubHbG8bi/eEF55whFgPQpi4sJvLU0vlW1KamT/Jp/hTf6mDjmR?=
 =?us-ascii?Q?A2ySNVL2+uDOPqOG69WJKfcsxa8/zGQPWs4ZaPVCkK6dUwlEtPNDGvmGV4G9?=
 =?us-ascii?Q?pMP2Gl+yv9og0Hi+bN+4fpwnrqJTQ3c2QXFPBw156Ds2yKFHHZ2DKyj1XDOd?=
 =?us-ascii?Q?AVG5/Flms8ty46lYIMiR5H32keJqyy7X29/GuzuCAZG+Iq0ZzZqqjYUDjOoA?=
 =?us-ascii?Q?RATQ24DuMKep7PIU2Avah30Ha/eHMxf961zxqzTM/uunb2pXJQN5xDvWo6OR?=
 =?us-ascii?Q?I4Y+KnT7XGacHk9fNZb+QqpTSn5SZgnTzH9JaFBMvDNWWBG6Au+r6ak873W0?=
 =?us-ascii?Q?RsbTr/iiMSKwS2pQbN4Zv0Mqb2PtGH1mfP65yzwh11MMsLqfKOLjhNd6nWSB?=
 =?us-ascii?Q?ZYbPRQ8zWKQ6X5KHSUrzjXTOeLnsfgHaGH3wZjaXOStnsizmCcYfOQWA5+vW?=
 =?us-ascii?Q?ZnPnxyOb3KvIhzXaK9OUm3wygBls67D+KV/bXUlUhap6c81tS2kI3oHvqnq3?=
 =?us-ascii?Q?NnDLecpIoFgsROJetXj6N2keQrv8G74l4Dh/qsouBFGVJjrm8SFAnvD2+bSi?=
 =?us-ascii?Q?jJZ1jX3OVheZvxKWFtP14OoLolUSGFfqfyWr4jrocHu5h333Ss4CSl9xxtUy?=
 =?us-ascii?Q?+Id54qdh6ivzzUnyYLCkThqO8SF/c5T2SGN4pq20cFYsMiDWUetoVxEIqncQ?=
 =?us-ascii?Q?GYw7ybif61z3N/pkPD/yaWi8Smiv7zBI2WvcxISf+y8bDUdhiXN2I6WKC3tF?=
 =?us-ascii?Q?T4+nDIhl55vGWbZTSHW2wCgwuN95kJ4kgmict+UV2OfqpntpWwvK7/ICrSEe?=
 =?us-ascii?Q?JLWZBbaYyo2/v4KKvQTXGyaVJaCwV2pHjSjVmPzIUVChfQfKrsvQ0tquBMl8?=
 =?us-ascii?Q?O+Q7KRAkwZv0GXQID0/9YDuAaJrSFF/bHBkPdlnCCyhMWzxMBiIIpU8NSt3y?=
 =?us-ascii?Q?BF0ooel9Iu3ZdPhpd+hBxSs51Pf7mvI9cGJPjmKquje/iWcL1QKeD2FOxKXR?=
 =?us-ascii?Q?bOxI2P+cV3cVrStuUM+19iCNutqpCXzFvg371s1m+pUDzSaFztu/dLH2eRLX?=
 =?us-ascii?Q?cArG89+UTGLMWne3hAwlnnHOw3gfXRYAlg/3LhcbdQeraKzAfG1Aoj9PGr22?=
 =?us-ascii?Q?TfZ7nHlg9UpMxRGmA/FhYoQyI0GbZViuKvv5TM921M6PGOmSNuHY1nRIm+jM?=
 =?us-ascii?Q?QQP0wOZ6TmNTqC+LKUibPG0P8XqVTBlB9H86I5Yn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5536e980-078d-47df-0f8e-08dd313fb4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 06:26:24.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtCdk4c2bIFP4vRFcjJUAk1K3aGE2prfDT0KEFc1rjYp6SODvgae3JQIiVHsxrQS1SgI29uSdi/rhhOsuhFqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7266
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 8, 2025 1:10 AM
>=20
> The fault object was designed exclusively for hwpt's IO page faults (PRI)=
.
> But its queue implementation can be reused for other purposes too, such a=
s
> hardware IRQ and event injections to user space.
>=20
> Meanwhile, a fault object holds a list of faults. So it's more accurate t=
o
> call it a "fault queue". Combining the reusing idea above, abstract a new
> iommufd_eventq as a common structure embedded into struct
> iommufd_fault,
> similar to hwpt_paging holding a common hwpt.
>=20
> Add a common iommufd_eventq_ops and iommufd_eventq_init to prepare
> for an
> IOMMUFD_OBJ_VEVENTQ (vIOMMU Event Queue).
>=20
> Also, add missing xa_destroy and mutex_destroy in iommufd_fault_destroy()=
.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

