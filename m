Return-Path: <linux-kselftest+bounces-14696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9299459DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 10:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F49D1C22E0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901461C0DF7;
	Fri,  2 Aug 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAIL+Upn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD113FF6;
	Fri,  2 Aug 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587218; cv=fail; b=Q1FcbiW4wtyTJftcuC//tIrg5VM/2Rr4V3ybnI6f0KmX9+GYjPxwJBduz/YURqVbRcK+EYi6W5YK1RghU0gU1g4AYoRaZcP1nTNo9yMIPOcZOFiozJVhik0uj1Av6b9fAGxGq4NY45gvo0bGT8Hqmvx95UwnP4c0Q4MgqwMBVkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587218; c=relaxed/simple;
	bh=xYvxiXaRe6VmcOP5T/OraP2LF1QF5aXHoXyQJkxkALA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NnH0TVryU9sW9mvY+grSL286NhACt3tGo2bEOcs/mk8Nyfqn7hwgP4MGYtJAy+WFxNxnVQiqocC2skL7uRCK+v2FuVb8Q8XZlMdX93+h4Nd/0RJvCEApuz4ailxjHfkKmIe6mwye58JilQ6QMDPipuN8mSUhjUjgeGpTPsPYPQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAIL+Upn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722587217; x=1754123217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYvxiXaRe6VmcOP5T/OraP2LF1QF5aXHoXyQJkxkALA=;
  b=fAIL+UpnvuZclxUzJ3+JGB62TGQBwxngqRdJvk72feb/moppMbP59aDw
   R+LxBEkFhlDTqfvyjochqMFT7F8mq/RLvlnoy+1zENvZwiyStWQ43V2To
   wZuHKY7Zfyxrr/SPtGIw6jJGZgtsN3xBE2LfimJp2nqCiKo5UiYyDUMxg
   VFvs60M4ji0OLragWGdjr+YbX+XSJ6Vixy1SMxARMPPl12hP+4n7fERJD
   KbffLoZx3U50xAKpZqO3Sp66vcCw0cu/NTjJUU0I+sXCY/eG/ZfEypJQR
   A7zu/lVIYXg9pHIYt/riJhIO9TRp26Xyj5pJteCt0G8ca3rGIAx58ET7K
   Q==;
X-CSE-ConnectionGUID: vva9ZQNDTXe3Rkcez+vbmg==
X-CSE-MsgGUID: kYCbKempROW6oJgD9jNzUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="38053719"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38053719"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:26:55 -0700
X-CSE-ConnectionGUID: YzFSaJjQREWZnSkpX2udZw==
X-CSE-MsgGUID: HyaLYcvpQ+q2nGOhhQdYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="92876259"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 01:26:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 01:26:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 01:26:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 01:26:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 01:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMvDyxKXz8aWgEBw7QScDAShK5dW/8SnPnBwXj5jvD+l9qPWMsoNVCTrf//mhzF7QH5mRf481efk3moyxKW7w+J+1NoiGn6GZGH7URvH0xHthZl3KXLHW8LOS8bjiD2rK8tKXkd1EyNrIWzEhYNSyqviA58W0V6FTCSVhx1oxXISCwAM9kfY+Cxe/L/ray+seIqxW6scfhKjQK1YOU9AB20OI53kcX3V360wnkoBHAJQggoAH+ibIgE5bSufn9xP9AVfix5lr3T2xxs0+qmQ9JbeV3S1cdMnEaUZh+RHyeKqFgIk4wkj36f83NauaJwv8S50HCyo2VfEz+nQiG9/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqbT47+81ID/+mEUV7gO4Or1gm1l+hhSNBbW9JFIpWM=;
 b=PYwBAOTAThzPULua9/0uuDwdizfKSMNChp/qyFM1kM2HwosDVifXsDQ3zw1lraBa/wehTUbsmGDIWiP2e+Ty1M69zImK38K0P1vnHEOU+4UpY7QDXg5Fb/YHAhtH0boxmiunoIu95QZH5zl85f07v2N7kJNnegzkTfQ2oHn0Lqvffz/kKrC99cewBospq+1cS9ce6CLizuVJoDsSv0X4mSGCFtQKfBJyYPQprferhsXTu1RtAdtpq0QAStMNYeCqcWo0KnRx5gYfo1SNvvbCsK9v6WK/eWL52u4LpdSSFBdwwzXxQwlRhY6bz4EraVO3Ec72WhlwjebMOcmwc81JXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 08:26:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 08:26:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>
CC: Mostafa Saleh <smostafa@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton
	<akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Matthew Wilcox
	<willy@infradead.org>, "maz@kernel.org" <maz@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Fuad Tabba <tabba@google.com>,
	"Xu, Yilun" <yilun.xu@intel.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
Subject: RE: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Thread-Topic: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Thread-Index: AQHawdyTbbj3CTyCxU2oU4wQ5oQq6rHOYY8AgABR7QCAAe6NAIAAEoqAgAAFggCAQyU6EA==
Date: Fri, 2 Aug 2024 08:26:48 +0000
Message-ID: <BN9PR11MB5276D7FAC258CFC02F75D0648CB32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
 <20240620143406.GJ2494510@nvidia.com>
In-Reply-To: <20240620143406.GJ2494510@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB8380:EE_
x-ms-office365-filtering-correlation-id: 1f8e64d2-2791-4bc4-8937-08dcb2ccda66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iiEYoFDYAZrZza4g+RuqRyI414K36ZM21dE/zau4tAu8O63swX2nXY7r5ACX?=
 =?us-ascii?Q?q1zsdaG+L3oL8Pvq6bYKry2IrYVC8pgLqeJUNm1b4hBo+bveii2I5sJl4Zfb?=
 =?us-ascii?Q?9Ng0Mt2kcp6yPaqlnx8KewzBvlr1kTU9K/daPLMf53BZSNcN9BbSw4XHdl6M?=
 =?us-ascii?Q?kp3TgWAzDMSBpVRQwX/ecjgdlGogMsOoZcfm3YXGJbLDP4151AWFe4pXbR80?=
 =?us-ascii?Q?iV4saJvZ0Wc0SCdh38eGbuFEa64T3a5KM4aQS1h8QJnl6rDlNHO+JzsWgHcH?=
 =?us-ascii?Q?DPa1QIjuvQnIeXPNDqboxBUlkmt33eg/zTN0/8xqe8HqMS9LitLzCmON+40B?=
 =?us-ascii?Q?rbVUXTa0UDNb4/1EeDOfwOgEIRT/QJGt6y7meSp2lKWT3L5dBFneZxQqBRUU?=
 =?us-ascii?Q?//xnNT8W1P1a5fq5/878hoxpGJfFN2QgMnklmsKj+yC750TB9IXQV1YCSLch?=
 =?us-ascii?Q?M25PNMTKoscsdYPar+vlxLdUR5QJ9Aoi2p0jxrJ3S8tHMmV5vNLmNCtlbQuG?=
 =?us-ascii?Q?JrvfwCoSUDGW+KZ1CJfZuhPazE3wgJEceAZkkWHNoNVXl5/yVVkyRyjKUcr0?=
 =?us-ascii?Q?A+B5VThEmzhxH1BfWe7/90gBPlnv265tw/VBfq9M0lzusLOGwAuNudWwlfih?=
 =?us-ascii?Q?URWxPW48vTCbSJGxbpaQWX9eSBoYV6qJw1SCntCUSO3R55DC/0PBj0v6+xTV?=
 =?us-ascii?Q?gGqSZenFB9ai6nqn6GRXnQDfAyyrlP562cOc0EZdvVdGW8I+xWQqJU2BGgkh?=
 =?us-ascii?Q?X7vRzvoX0hyrPX/eT7teQnZ3xUCJArwhlErXkbw2/mAGXvM4UCcRkapyw+ee?=
 =?us-ascii?Q?YG+BAK+0iFW8B7xPRUiGyEHoSuRc5/9FjD1+g4cgOVSYAWc/S5wf6BQE5gdL?=
 =?us-ascii?Q?PuNlKuZF693tU2Jwp4Pf0lQ3pm2rnBnalDX5VVgA3f0wR5NwG4UUXBQOCF4T?=
 =?us-ascii?Q?GTwGDPq2WspGU+C6RW4e+Y+Zk8XnxAF5VD2Gks6E3ijnQe7fgRdA2xpfjPJF?=
 =?us-ascii?Q?xtCdnufKc+1i18gKTp9wqCRs8PSAIpVcMq6LOUtu12YW2Zlu0P7vDvXxvrIR?=
 =?us-ascii?Q?Ufq2Je/Ax8yvGFTylyY4+O7Ts6TJQ9xvn8gI3kbfBgjX0Wavg2Z2vt+vQrcg?=
 =?us-ascii?Q?/NkiC8wpJYi2hg02OFYmlgXD3QJ3H+RkBhhqppkGu/NxPZ5hzIBJ32YqM0Do?=
 =?us-ascii?Q?T1eXcM5GW6vnqXCTrivcR25RpHfFZNnj5X8rQaQMOMIjTUsPKClCsX3mssD1?=
 =?us-ascii?Q?EVVpYmkQ4+cLfZ0/IVnm1OTBA1fATABKGKZmAGhSlp9z7wZ68gNYdgTrwovM?=
 =?us-ascii?Q?lHI+VDbIUpBeEAsk3TJmjcZE+7M5Coh8c+mjssLMQY6AQRXwdg5Mb5Y10Dlw?=
 =?us-ascii?Q?OOQzHu8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tDAWzJZlksgSBAbb8Jw5h+82jSG4zuSgEoszgfZXFYiYcELZ9SdZVMoS0YCW?=
 =?us-ascii?Q?muWzoC3HghSYyvhnmWnmzRHPY5qNnXZEZd32IlCmsr9BbDea5X8Z1ZtYGyOq?=
 =?us-ascii?Q?4hkpC6JznieSCJluKzX9bOEy736D1ziMJf/SjMkiKm/FMzqS65p+wt0BRuoT?=
 =?us-ascii?Q?+8Y5tCjQtgjBwEHTrorEFmhZVyUrCDAAunGIXLDlXSwDpJ3nwmFmFmthwynH?=
 =?us-ascii?Q?cMBlN3mhFIpt/SVlXYzWuf/qMosrZ63tX1+0xkaFglzaMc6zEHJJeRfBTp93?=
 =?us-ascii?Q?eWMlAzsL7HxJBp61VnEUxKJ34EFcymftapxx4Fcb00I4YjayJc1b0HbSsDS8?=
 =?us-ascii?Q?9laIxPIVVdutnT5JZ1tao/NirAS695jYxLIHiX4Lk5pbG8jYoMrQjHdvOylK?=
 =?us-ascii?Q?Kja42XKLGE9GfZvv1IMSIotgsNScu5TbJyAF9AKeEDXcKJ8325WAI511gUr/?=
 =?us-ascii?Q?U4rEC+bwM8RhTTte7qT6ocfaaEu87wvcsGw74lZmpsVJO3ksvGv53ssdH73/?=
 =?us-ascii?Q?ZikpMR6wnEAhJdOrutB9zywzbb3nN/rK8ad5SF08p8OSdOWiVQn2OwsQDdEn?=
 =?us-ascii?Q?Lo38rrBuRIpFKs4S5I+NHcPzD0XMNstIyAee76LSWKGV6t3CVKI7zzpG9GWl?=
 =?us-ascii?Q?7mrycNsYwysIMyqPIkzd39laspuO2gKrA+w/GpKQUBjIVQjOAdOgfhiG8URM?=
 =?us-ascii?Q?VlH6caHC6OxMjGVXpxUBa8XGIxaNTlHomB0Hq7yffE30C00w0dSJ00z7bwWz?=
 =?us-ascii?Q?NFO/G7ko1OouwwT1NwlzJjqdJQKV+9U4StvxN3NX0QcivLWsnj4XUzjYebZy?=
 =?us-ascii?Q?wpmGbOjF+xG+KD6JDsjIAk5SKmahyWP6CkDWcSjtu3XUaZh0+SW56XQZhWAC?=
 =?us-ascii?Q?OqZwBab9QX44OkmVxCGkWony7Deidtxldsy/x/21/BD3WRD9BuuecmePLBt4?=
 =?us-ascii?Q?n/Vm3yee940JfAOln5YWjWbuEAR9fI8DfFL44vm3Cg5h+kyjhKY1SKOzf5hR?=
 =?us-ascii?Q?//fE1/ZWyDmygP7pMKLe/dWU64V8tKuxdBwO8xCklaSpaP0JAtbIW3EDl5LN?=
 =?us-ascii?Q?B6ioverVV3Wue+6wMW0erxDuZKYIxAe9o9GYxcVOXBaCP4L6LaZV1uA3g3/Z?=
 =?us-ascii?Q?GWmZtM57Y/CxGigyhrntrtDr6uCEHd1DP0gQg6UGfhLnGbecqD5rICBLtOoG?=
 =?us-ascii?Q?TXiHUSLuggYInZ8HQgpPxByAHCPZe5SVIfQEYglp7aodA78QB7fwiSv6rxz5?=
 =?us-ascii?Q?4NEysXpB77gksIlWs0ElSUz6wMBEGY6tR0eWw8c2XzEdTRt98TLztyd4wYJ5?=
 =?us-ascii?Q?bHrkQ7N/fbVv+F4w7oz+rrCkRxa9F+cRL95ySUNHtFS1fhWktE9Yr//rugus?=
 =?us-ascii?Q?jERETvfSXiTHdVVw/76tgAvJOnIWIYCtgaSl5jQTrhMz3UdrCYOG9A9JjzBi?=
 =?us-ascii?Q?r3EjANObFXLiOBkzM/amT0u/RM/pO24Xv7lWFuVY14194q6tUoF48tLT0WZF?=
 =?us-ascii?Q?xhhkmS61bvr5cfVh2EK88t4ESu8Dhq/l74bE0nV1I1Up6E+bx+ef9ZQDq5BE?=
 =?us-ascii?Q?tibsRtWbBD4P+u6TlurYsNbCWdBhqFq8nl6jm1fY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8e64d2-2791-4bc4-8937-08dcb2ccda66
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 08:26:48.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUgTXdmJiwm0xxsYGPPAn8THIoqzkUXzfUn8JqfVK57b6g0EUaOlDthfawGLNsJ7aOUYjDnebpmQHvk+wDbrUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8380
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, June 20, 2024 10:34 PM
>=20
> On Thu, Jun 20, 2024 at 04:14:23PM +0200, David Hildenbrand wrote:
>=20
> > 1) How would the device be able to grab/access "private memory", if not
> >    via the user page tables?
>=20
> The approaches I'm aware of require the secure world to own the IOMMU
> and generate the IOMMU page tables. So we will not use a GUP approach
> with VFIO today as the kernel will not have any reason to generate a
> page table in the first place. Instead we will say "this PCI device
> translates through the secure world" and walk away.
>=20
> The page table population would have to be done through the KVM path.
>=20

Sorry for noting this discussion late. Dave pointed it to me in a related
thread [1].

I had an impression that above approach fits some trusted IO arch (e.g.
TDX Connect which has a special secure I/O page table format and
requires sharing it between IOMMU/KVM) but not all.

e.g. SEV-TIO spec [2] (page 8) describes to have the IOMMU walk the
existing I/O page tables to get HPA and then verify it through a new
permission table (RMP) for access control.

That arch may better fit a scheme in which the I/O page tables are
still managed by VFIO/IOMMUFD and RMP is managed by KVM, with an
an extension to the MAP_DMA call to accept a [guest_memfd, offset]
pair to find out the pfn instead of using host virtual address.

looks the Linux MM alignment session [3] did mention "guest_memfd
will take ownership of the hugepages, and provide interested parties
(userspace, KVM, iommu) with pages to be used" to support that extension?

[1] https://lore.kernel.org/kvm/272e3dbf-ed4a-43f5-8b5f-56bf6d74930c@redhat=
.com/
[2] https://www.amd.com/system/files/documents/sev-tio-whitepaper.pdf
[3] https://lore.kernel.org/kvm/20240712232937.2861788-1-ackerleytng@google=
.com/

Thanks
Kevin

