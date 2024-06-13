Return-Path: <linux-kselftest+bounces-11825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595EF9062A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 05:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB921B2123C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F41304AA;
	Thu, 13 Jun 2024 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOuy6pq/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC5748E;
	Thu, 13 Jun 2024 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249278; cv=fail; b=pie1NVYCSBHLIRlf1ssWHtCi0kp4ikuJwzbXq4lrp6i7E+bYNy07JDwpBI6CO9dsR2p61gh7TFUx391ys7i7ugzBJttt3OBkHOQaaYa0GFGCK5XvnmfH8k7DAOY7s1wSY40XRuGYTqM4LhRsy9TBgP29fw/S15jCnv+RWFPUVI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249278; c=relaxed/simple;
	bh=UGJVF2EKG1K1EE+VhP9PpSvKLzznfw/1UCbHYXTWucc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XsaSl/NM1gVL7r7JC0rM90LT+8EnjD48I8i/bE0hWWMAjBxqPNnJmNn+kX2+ztVLT6AyMk6pKu5Wo+dWQMyi/aVozzKHqGTKKLTY2NM8p2MAvDSqvq1dY2zi2i0EsH1Gn6fdTaOHsy6G8hRXrBk5So/hnD3DT/YItwUGxzArZn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOuy6pq/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249277; x=1749785277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UGJVF2EKG1K1EE+VhP9PpSvKLzznfw/1UCbHYXTWucc=;
  b=bOuy6pq/o7gXkkIjjTN7UaokF66eDOm1m6Hr8rNMGESSb7XE1E09+/WR
   lI5L2hLiEuAV/yQzB8h9Nn5VkM2nsLjaSD3/cqvAU+RODZcCXTXiKTtS2
   92cDLCUB50Wl2/39wXeb3sWjTD/kYoRA6LNlR7C4p+7clTdJbipAa9tzt
   2uXTI7DeSO/eFSYQXkNCsUgpmJk65DzAGIPRqXp4ec96oD/bCv4pGZ3tf
   Rl92Jm2eBx5J8JtJu4rB1FNT506zuctviYdgWxPoGr8uWcKiF5eX5jn16
   +PjuBoZ4ceWWWVCH+2y9xmvQjg1PSHcg94LsJ0sk/PyQiD2a25KMYY0kv
   Q==;
X-CSE-ConnectionGUID: 0RX2e9BYQYWRfsgqckjwTA==
X-CSE-MsgGUID: POK6gft1TbO1JBN8jY7y7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15273692"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15273692"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:27:54 -0700
X-CSE-ConnectionGUID: OfZ0LSK5T3Wh6Tieu0cA7Q==
X-CSE-MsgGUID: hnRuu1/SQXeheENXXvuDJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44440315"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 20:27:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 20:27:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 20:27:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 20:27:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 20:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNtxwhgAManW0Xk/D3fVfLj5XUWtCUyLVMCVenSNHsrcA2QulKhpexDnnXaJG0X9ygtbWDq9x0bTnX0atCW8Povsu15L4FJU9vfkzhghydt+RMok42OkFoCd7IoOnBPqo2ODmbVTNUTKxFnbbQLAsXJXg0zlJcVb/YIFwy6tD4YZDhjQ/Lm4l2Yn4IEo1P2uO8L+s9fgiTMQEIpgPUUZl+UDQTzTbAk8BupZwAdlMB3LnPK2F5LqifjnR5xymRpLELiV+ttFERhjVJekdrdyMTvrvP8fP9XAjO5wzckUi9vc9V7Ro7Lb6RkfULTCbqNcP4XRyyyK/CL+wg/WSNQfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7o6rvgDTkg0tN/BW+vetJc3e51/7SVChrzoXfAEqag=;
 b=fKbgL+VsdVd8F1dytS4VJTtyl/RPgE3pejs44aJsGCwCyeb8zjObjSWP56t4p9JiTFNHbnjwiZuVrRgrbSdOwIGT2p34POuoB48tzEr3Zmy/tnS/2se2b++WFm2xQ+4WAtjVkVhyvM9P8NHmcu8ykYJw7i6BwJcMI0qtFDMtK8HqjXZaqHyUctvlxZOtP2RqMTc7wexmvurtrkmPb3ksJGesyFCToALX5vyMDIuVpZr9QYcBZoQC1vYHMt5EZa3Xtg/VFdrBvgHnpS/noqJkf+5e3Ist0dBgQu/U795CKqezkw30oADQDDn/eU6aPGHp0jUia1bsKVAMGxuLav3USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 03:27:48 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 03:27:48 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 04/25] KVM: x86: Mark CR4.FRED as not reserved
Thread-Topic: [PATCH v2 04/25] KVM: x86: Mark CR4.FRED as not reserved
Thread-Index: AQHaWe+gBPWte0uMqUOIgIdlQKoa17HFZoMAgABotFA=
Date: Thu, 13 Jun 2024 03:27:48 +0000
Message-ID: <SA1PR11MB673449B25E4807599715E6A9A8C12@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-5-xin3.li@intel.com> <ZmoPLOx8sujVsGIS@google.com>
In-Reply-To: <ZmoPLOx8sujVsGIS@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA0PR11MB4671:EE_
x-ms-office365-filtering-correlation-id: 4ac6a727-0b6b-4199-e222-08dc8b58cc57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?V887f7UC8z1B4k7lLZjNyyLyWKRbTPUCPseg5BLSCzjnwcjnTQZDkciCo1Iw?=
 =?us-ascii?Q?rRMBaXbiLSvx82w39HbdOx38fn+3rdPecrgZYteGsPVlifmTyW5RW5pzk0hB?=
 =?us-ascii?Q?lzo60QyADnt0AMyuQcTqp7ZgHQq95Kk7PlxQ75KAVv87BhGaODX/FmndaH9H?=
 =?us-ascii?Q?jZM2FuBg8ZNY0T1a3qZ9nV5d9RLXIUXCRsgqAl6+freyON11jSfzBYFMz356?=
 =?us-ascii?Q?JPWYfvag08t/+lkC9OUA2Lj7MoDqvGF0RCuguG5GaYh0gUEZz8dSMBVmV9a0?=
 =?us-ascii?Q?xZcgkqyl9vXWWQRW9tqgayeGos0bjLCCjm/uHLIiv+5tJNxadrg7dDigLckF?=
 =?us-ascii?Q?iCV+5ozerJhn2wrBNTo/COdYgYd9Ai8JwEQgHi5rSOBdWRmyNHrJrwF2iKK8?=
 =?us-ascii?Q?ssEr5A8RyXxm9pR3x8NztHidhbM2f0hbW5s/ikqdzOJ6J+fvT6hj6+k4k13Y?=
 =?us-ascii?Q?9uW+DWVxvH3t/Ve0om7WoY0FrzUf3Oc7kx/3VWWl4Jnan/M5ncnYAXMy6Oc7?=
 =?us-ascii?Q?Res+qYurd6TsjJtnEPK7NuEcOe2Eci2Vyo+oIHgh9OUCjuV0n/+IV/B6mlUA?=
 =?us-ascii?Q?EIFlthvxcBrqyXU6d4cT6fHryAfgjlr0yPYA5rJSLPutBviDEs12Rhay+EMp?=
 =?us-ascii?Q?4hT2PbOgFaYAx9Cqd0c+zzffN94P00fsNrpmuPzBSxlwpkpNwJM7ITRnWWn3?=
 =?us-ascii?Q?qchpJNGUJvQ20O/VmJOhtGr9Oh2BvrSHztX8aQtBxUjEOKBNDhHSDaZqii/M?=
 =?us-ascii?Q?sOUzn11oTZHZQPw/YppbhcqRKIhhrb3J7rtXEOEUOUBM1Vyr3FXDKjKN4uDY?=
 =?us-ascii?Q?rQk1iNaCEXhdJCyhwBpzTviM8V99dHAuUt2tMHAA0WquvET48ao+vIwhwev4?=
 =?us-ascii?Q?x5Txs4w+OG7m9W1trXbxCByKwphoZEX1FzoWGAVHX7NMSpDfgNWipDuZPxcL?=
 =?us-ascii?Q?9i0qgChitCZGVacAnIq94NPEdP4jCiFtsykfkkveAZ2+/Z6xTHL/FCERUJGe?=
 =?us-ascii?Q?rQ5+l4eUiJ+iI5EmT1XRDigLOp8KsKMRnu55xi8j85VbWu2ppCJ1qn1MnG5G?=
 =?us-ascii?Q?uJJm6IWLqcccKyXvJmDGbN5gQXvzc8Gy3XQ8zWeeKBgtXTsZhmcuP1oUixjw?=
 =?us-ascii?Q?4iExmG1rIi5EltbyQMPJPL25OEFrSJC32pU7RHZzg1OmXWjFWJAAni97Bu6i?=
 =?us-ascii?Q?M1SBhZ3s9JBEqfWZMQDtgdaSoWUQtWZ1VDMdEatuFqkIjtgrAwyPFPf3Jf1l?=
 =?us-ascii?Q?txF+9W0IGIW+UQxqWbqWwiWAWpoFmATmxgB4jFLKrVz0a1+fpjcSoMu6h2DA?=
 =?us-ascii?Q?TwDOFn5L3m4zPfIqXbyKHZ9FmJFgg3ouh/NqBclIH0mFgRJqBfNduqDnfmvO?=
 =?us-ascii?Q?dIHCYLw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fA8gimwUOg58jfSuTlRLFscAeGDQ/eJM9jEIwmm1G2qeclwM+Pm0vtoh6aCM?=
 =?us-ascii?Q?4/BVymwHUwfsbkyFQa/I3JIwOZH57Uu2M2vBeKqb0a1PNP5+CQk3TbEG6qRT?=
 =?us-ascii?Q?TahlJKy7/iZnXvffLyJZFCVBh565FSgJ98kX0qRjQxmnRhszFh+UYbKe6UO8?=
 =?us-ascii?Q?/2fenubd+01/C4i8HYSj84YP8fJEwRzql/Tyq5nqmihwp9yB9N6CvIOBXqaM?=
 =?us-ascii?Q?JjaqhkJGp5bJM08XR3ibL2GV62iz2raOlDYUsGeBvRf/nJKzfoDX8n/qcvzg?=
 =?us-ascii?Q?ZbvEXnrNwzKWLm4/HT5+d4BCmMkgEe2f2rRAT3YJAqYXpVdUIrwUM/2MJj0x?=
 =?us-ascii?Q?5PZrXEaXyQ8uKBSea0IYCVJifEUQHvGvvgFbRKeZTNM6vjTmXn0OfxwDDZwP?=
 =?us-ascii?Q?jsVkVa1POLha3fG1330k1A2bhGqEnwpCzuk6x37rn690XP43AuzynLolwZ8Y?=
 =?us-ascii?Q?aQfKp4IFYIk8v7XrUVaMoUqK6zcoHujU79h7fP4SCx1IgYh1aIVa5xzi8Cvs?=
 =?us-ascii?Q?CfZRdf4YTAKm3a1vNiD9VjMxHyiJxz3TbCq9GIVzbfsNTyWbGqICs3S6nVK2?=
 =?us-ascii?Q?7qXxtdMzMiAgrrda6T2Wbxm338LY56Mtw9mzXP+vcGJRk/8WrXtnrRpPsBPg?=
 =?us-ascii?Q?akOisgvSfp4oHO6R0VbOJUbfEEHqBtU5uA9tjRv+MKgEL0CWagl2858AF4Hg?=
 =?us-ascii?Q?7uhla2bAbyA6SbjlfMxjjOvrwZxcNpEAlGEuylbrlpjahavjrOm3PPlJs1+a?=
 =?us-ascii?Q?hDTQAUwC4aaFB9V6RYf3WVZkXhoFlF3OHxgqJqSGiBuF2T8rHoc1AFNr5nev?=
 =?us-ascii?Q?1QfdRVYqmIX7lsSxsK20DCRbsdgxps6c52+tQT6F/o9NeBkLLXaqnWD6ZlEb?=
 =?us-ascii?Q?cZEWS1ph6LAxcP2d6UVrbGqTDc0bV6OFfOzbi5BqLTG17tMK2d5qLhVJXC5a?=
 =?us-ascii?Q?W7hDgWGvuBxmEBHyWWRyXJoLjPmiqkFnb45L8vt1II3tg2JcOUzQezooeWI3?=
 =?us-ascii?Q?xFDRSZk92d70zzKDC0lD69f97P16bpGsP/ZCHx1ESdbf18VGA6nSzlI9AuNc?=
 =?us-ascii?Q?AoulFaoWmm7oBa9C/6GRH1yf237dAoFhE5c2bYJwzE0HNqur6McwaQRhDdoQ?=
 =?us-ascii?Q?JYrwpDh+vGRR7amItFw/oCqAnWCuPmpTMeq7ofhWTXd1X7wgOsSBMJhr/QN8?=
 =?us-ascii?Q?3D/x/WMXkMtwIfpxXexbTE7IzuouSZvgHzCreEJb5ztmI8KDKLtkJXlDLVT6?=
 =?us-ascii?Q?jpwQo9U+QQZhpvmBLsnin1uoj3VgZGFlxG9nHSkgrXpg3sP59VmGT6nIzzcx?=
 =?us-ascii?Q?qbh/8Pypomfb3hmEtF0zGmero6PgPf5b22X8yOjg6xZt/YZJLLHBZ97cSMQh?=
 =?us-ascii?Q?ASf2X/TdQfoHK3G6KKezV88caOmi5na+DzI+W7T1o6z1HQ71fsrkZogCWxyy?=
 =?us-ascii?Q?HXD3EoumC+1D3+kR5qNtnRs5oAI22Nfgc/vwzy3Ye3H6QUprQOre1B/nPzOB?=
 =?us-ascii?Q?8OdIXRix36sRhgYiGwVmTEgl13I2D8rY7nkRDFPf1OFyD2CNBq4fvwu1rLhA?=
 =?us-ascii?Q?P+DmPDjbI91B0jkdpyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac6a727-0b6b-4199-e222-08dc8b58cc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 03:27:48.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh9URZJVF8nfyH81gJwXUQlinDAqUwgjTAiAs/BDGedIZtm58FeALh96cIUS7tboSnq+FRWi/fNbLdD+t63AYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com


> On Wed, Feb 07, 2024, Xin Li wrote:
> > The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when a gue=
st
> > enumerates FRED, otherwise it is still a reserved bit.
>=20
> This isn't quite correct, as __cr4_reserved_bits() is used with kvm_cpu_c=
aps too,
> i.e. to compute CR4 bits that are reserved from the host's perspective.  =
And that
> matters, because if this check was done _only_ on guest CPUID, then KVM w=
ould
> allow CR4.FRED=3D1 before all of KVM support is in place.

Ah, that means I didn't dig deep enough.

Thanks!
    Xin

