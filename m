Return-Path: <linux-kselftest+bounces-33612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E4AC1DE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A650596B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1147F2820A8;
	Fri, 23 May 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzmHKItG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A22DCBED;
	Fri, 23 May 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986393; cv=fail; b=N34jeWVtCoypaljKzivwmdu+jhQ+CpgsPhfptBXEHvzAZbhKK7zQ9zVB/od4ZNkjgvspkhlUTjT7AI/wBTroiefB5EV+vsZFIduuknqoyKlGOveRvqQHtiafX2LYt/k/9gToLm4AcWMxAW3oIQVZwhiwyQ4mjoMuEyaZ9hbe5zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986393; c=relaxed/simple;
	bh=llOypQFovGjK0MJYJEdAyD0cezI+LnlxDRl5AEDHr3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/pEV24wmZ68LN9gYFOfaPgLZolwE4eV3e3LajLfRqripSiKad5JqwQeZkGErhWWzsuiGnQOeREi5Oj+UDqp4vHRlEtBU0BWdUpqKQb1fOCXetIoVSwg51wS7Lu0h4KTNhDt88YzTzS3j9CJAZUe2TAVZbg0VAigI2ZgWes15YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzmHKItG; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747986392; x=1779522392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llOypQFovGjK0MJYJEdAyD0cezI+LnlxDRl5AEDHr3Q=;
  b=fzmHKItG0Bz24C4/6427875aogBvhDHd+65R5uZHdf2LPw3e48hh9NtJ
   RVI4iN1FdZycInTq2GxFCeyzUpzkcCbJwGPeOfArpRatJwm3YwKDXC05Z
   TJ8mu+esK5NNiDcetkZIe8okuOrfSevCAXnWunFf30jhODcG6+mZ6laZR
   oE4dwq3qIh+TR1SML9Y0va8zPzM5vphS5VEDmnLtbjfXmpLl2hd7+pam3
   Q6V+3kTSqVU55Bl4ewdY968EtRjH1W2QJDxEJQ6rgfIbj1O8I+v/2CkC0
   lNujnKeB8MZSlydOYaf7dNNic1fBBj1ftZt+vt8VZ3lTiFYAPJLWG8Afx
   Q==;
X-CSE-ConnectionGUID: QC2uljhRQK2rt8rknfgLVw==
X-CSE-MsgGUID: d35Mg4SdR1SviKHLjmlARw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49914720"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49914720"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:46:22 -0700
X-CSE-ConnectionGUID: Be6LBcCoR7SGvKmI5fkqWQ==
X-CSE-MsgGUID: gMXGMK8wThq4O2zTQMM6mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="140856759"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:46:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 00:46:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 00:46:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 00:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ecl3yVwGNzO49o+i566VerGG1vVqifbi4tBRpAFSejA2rAeXILCaGBP0S24NT1hrJEpBETWM4rGrp7sjNHZU1H4m7ake4n2zK5uyy180SD0TgBjf5o7LFxrCIVlo23qlY9XGEzAlBs9ZGt6HyK0iuluLVfFX9UPrkBQBOtnzYO0jXGUNOIXOn8/X5Vqh52gJo6PF8qrPMz1lLaJL5Ud41L+Mwpw76kRYJv0hsxUCY4fn4qoWqnRTZbOVghj6VI1DapB8IFmv5dR1K2tJZCrzttNZag+gvgSRtFqcAw8hXlcxa0HdnsLJKJegREEBBQ+IG6rV6YKNyX97EcT52/Ykpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV8UL3CS49J0d3HMUU7NSHuBBeckS7jgYJvSNlD/Vo8=;
 b=wdc/uowzqCJLQ+PRdIm/nvKQeX1IpwRbBuAAj/FJa2ur+Suf9yjeCAi2iRH63M+fGWOnnlt6nVwvWWRVbo+Zpi6YBwzs3Mdb81fLb1qBhCgAkDVmE4ePI9uh5rLhe4nCZI8gdmfTbkjN/kzs8ZQPQCL3lcUhyQm05ynQoTTX2gr/9uC5VaY/zw3p4Z1kslWUMw6e0xM+m/dX32W7xMhnAemQscBdAt+W8+lSuNMKqqxY3uooeg4xK0Wc8K6C/TyurHR874pM5UyhdgAfx8h2sOqJTSd5EQnA2CMPuZWCP3QCt4xDCjqLxhDMvBHY92iTiyq7EXh7atIlu+3wIuG6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 23 May
 2025 07:46:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 07:46:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 02/29] iommufd: Introduce iommufd_object_alloc_ucmd
 helper
Thread-Topic: [PATCH v5 02/29] iommufd: Introduce iommufd_object_alloc_ucmd
 helper
Thread-Index: AQHbx6QRuGKSUXq7OUSJC0+nT1LEFLPf3ZzQ
Date: Fri, 23 May 2025 07:46:13 +0000
Message-ID: <BN9PR11MB5276E1932E77354694D45C678C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <4cc3e95520bbade9004615d04fdf5624e0b2d51d.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <4cc3e95520bbade9004615d04fdf5624e0b2d51d.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7252:EE_
x-ms-office365-filtering-correlation-id: 124e6d33-aea5-4232-bed9-08dd99cde467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rjYAI/ajJeMK5Nmg06nlkQnnT4mUu3HV5FPDaFj9o1P5HAiqnHnmjMkMjnXr?=
 =?us-ascii?Q?I7/CAbjViobxq8jvfGVpCyTs5glB4orgM85kbMUPkdxqWkDLJs9AdEu4fF5+?=
 =?us-ascii?Q?2XAr4nJdW2FcF0YA/LTddxwKIDEcbODUvsxjU1Oml8JNvl6pht2zXwhCUHJT?=
 =?us-ascii?Q?p2nFrhwYMc84vpppbaTxCxdWLIIvSB0MxteTdLFu/ucdwXLaQGK1rTYQ4IUC?=
 =?us-ascii?Q?Why5OOP3GfY9UOk7rdvdD2YQ9KLGbDpAMLXOysSKeMBl4jHRf/74NRAKbAAv?=
 =?us-ascii?Q?AUD9hftBKt5O29KpMo1HdHasgfmpF5o+zFL0FcCbGzFUON7mW3Og4maqZWiw?=
 =?us-ascii?Q?H7LvKel0s30DdZeijlurU7cKGx6ryxcy9XmJQ6GxnhKEhRNIlhJ4pybexlBt?=
 =?us-ascii?Q?TfMLAE5U2Hyba7bq3yLNFs8M9kemXZrx/oVhJt6FukufH48TxVBEL49WkeoK?=
 =?us-ascii?Q?nmpJq/5Dq4MwZIK3sXlmd/+20ddXZ6CA6AVOgCeedEnenEYsGbUwsIIZi3gQ?=
 =?us-ascii?Q?SF1bfSCidsHRiwox+lKM/9RbnTYz1m3IbcRopSJnFGzmvKywcMkMkmMaxaLo?=
 =?us-ascii?Q?Q+rLfhkQv2sTIhTFnz5XJOhN55raDtOvQTuo5NL186sfwXAnzTvbMwhX9g3Q?=
 =?us-ascii?Q?O8GLGobMkXC3xhCK4/zBclDn7/sMdI5/kX8kIvUEQ+p1b8ARGze0AFWQvAap?=
 =?us-ascii?Q?XM0cygEIITWaayIUjjHOS5MzUFkJ8/CX1xhQ4ZWt9QMMFIjHCHuAnHHivaN0?=
 =?us-ascii?Q?K9NX+Z0o38ROFUZarSTH2lDJZdO8gjg5J0vMd59D69Nfi5Zefsr8rrpC3P5E?=
 =?us-ascii?Q?5TeUlE+d4i9Z5vwxmJejxgQXl6cEWrrQUDgikGv8ZRUeXLZMaR/lYcZ9QoRc?=
 =?us-ascii?Q?GlCFhtLEwZbz6512wmF1z4kgc+6iOw/4QFXJIbUNJys1t7n81noCXTWncLVk?=
 =?us-ascii?Q?2vOGOzPe8fFhszyZGnYBLYdK5rCkhkXZoYnpTjWFuVZEc/CF43ufT9bORxHj?=
 =?us-ascii?Q?KTWYqWh3UtoMlF5sT+C50QjVlOt2MgizoNWR29BrbplUNy1Vdat25ZUPEJc8?=
 =?us-ascii?Q?A14qLNT++0S4dFzkeE6dPDcQ1Lnx9PqR3duFY2IiB24lxXDYDuPEIpl4E55e?=
 =?us-ascii?Q?4fk8qJGnKZwkIgHgUXxiE6R0TQNuDaxqImS+T1t+M+Wrv81wcfNBnBnx1mX2?=
 =?us-ascii?Q?413Kygeo0r9A2O/aabAsRKEGMSN3KRvxYWV34xyjdF1Uxo74MnaHiL537EWj?=
 =?us-ascii?Q?04XBabCZA3v+Qqu8A19uJveE6rw/wknl2rpuOnIwBh0mzHGg8sJuGq8edBl+?=
 =?us-ascii?Q?dbqQmcD/GHOA5L7SWdyh6CDBwxmUeMaxWQbXNoIkKKzRIKNKPLzuovX+kkZ/?=
 =?us-ascii?Q?u2NRfLbPOz62+JarzONamYEbkMI8HfgnVAwoXprmVSySZO+5QmBtfS8thGrb?=
 =?us-ascii?Q?vPggN1WTOjA3e72gJWTMnKLVb6qwmIWehnWJcDnKLxShUfqTXHoXHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sCYe56gktsG6u+GENf4oGdCfFDIg974QByCh98YtZGx+NrM5AcdGKWNOsIiM?=
 =?us-ascii?Q?Fd02ubu6w4M5Ff4Yf/0ZgCaPT8Xl8ghnkEr/x/xW4eijMnYBFf8WFeBMEQIs?=
 =?us-ascii?Q?S08kT39JlxSdDySQBkeRMyphJCQPU8m6SVtzJWoeTNV+Ks5k1k8RQ8y4/w+K?=
 =?us-ascii?Q?ZNMmU771aoT5V8BBRLovr2UN3sbSOvRwR+ZBLfDEIa9Sh/Q+YMo5EuiBOzKb?=
 =?us-ascii?Q?F1hz+o8xArJKGQBmixaQolYPQR/CTdQ8h9s+iTmfLM4kBg6G3zH4TnelYYi/?=
 =?us-ascii?Q?Ox2KlT9lNDRpcyx6nO6egYkNOl2T4FFcllODsXFhfebnqhI9xOb5lnfZAYYy?=
 =?us-ascii?Q?4BV7v7OYEob3ECgyoHu2kCI1Om9AbFV7cS6FtLFiGz4rM9Ij0gsKcUsbglBU?=
 =?us-ascii?Q?TaO78OsqIlL2rxARvGvqEAIRaZofUS2WdogIXHZIcuJ1cyvMSEQ5HWFPfZtu?=
 =?us-ascii?Q?bQS5bJAbALm6FxBSuT3vIdgxl6nyztRWQO+Vyv8PVt4EuGuVPfgMA7sUvCtC?=
 =?us-ascii?Q?/gJxOiAJo8lZPkEATYHFSX4YvTkZkipeH3DnMHEnhTBZSKSd1ig3Lt6s6K5o?=
 =?us-ascii?Q?F3N/IxHgXMdXNOE/lHOw6bn2FDa785j8bA13qOo+lUZJVsCqzZrWS/n02sOt?=
 =?us-ascii?Q?/EXAFHGD50MXWvpd/xExIQZMzasFSGX9GQ7wiU9KnYHDu3rJIh9FWcJF6I27?=
 =?us-ascii?Q?UKx05V4mBjpVXRM/fm1+YigwO9oCFNVzf+DjinHgLCKcmCpEQXXvNIVEKeA2?=
 =?us-ascii?Q?KktDvN2dLh8WvlrMfSyHCGFsmuGcvJYiRJIL2A13g6aYurjGnXu7UtueNYY6?=
 =?us-ascii?Q?8VP9DBxPCTDEB71GSxHCW+/WGNj/pNp4nampXmN1WrOvr24eOUMJwlUNtNuY?=
 =?us-ascii?Q?chaTbrot+zg79mPp7+5pesMAesX7fEW4YI4BcHdbh13RixgjDs5yZTCyj9Hy?=
 =?us-ascii?Q?PN8BBw+mxmIBQj7+v3slRXWI0bg7xiQEODt9DtmA7R9HgXr4MIIp19FwtOit?=
 =?us-ascii?Q?m2pqRUGKqjWFddVP61vipQJoZH9fGp9PQUTTBXsdaZrXwHuE5xk4Um1y1Me7?=
 =?us-ascii?Q?Dhef8uFJ1sl4cqjhE2pxQgEywZBNoGUJciEO7kTeMx7EhdFiba+mjixgHFWj?=
 =?us-ascii?Q?iZYkibQFFfU8LffHqomLK4jmpmzNQ8O/YAyuJgSbfJvKSymNqSKd7o/zd6GN?=
 =?us-ascii?Q?yT6Ne627Vd9jeTKetU7m+lDO7XTOYX/lqrtlkmfCrsy/eYLPDwRMh8Fi4wk5?=
 =?us-ascii?Q?oY+eunmjVStH103l6ZWiAdXaRMvChihUBdYOxuWBOMf3JW4Mqm7MT0mdnVRk?=
 =?us-ascii?Q?CHGlkSmlabvMHBWo5jnBvTeUdiZRT2rjZrXqxX6Rdt5YExT8o4FEtNN5aegx?=
 =?us-ascii?Q?2tg0lkjvBP1aUepQnz0s/gHbyn96uLZeTbvtyOO3m8JlQN/a/3vIgbBlgJN6?=
 =?us-ascii?Q?zTryyv5GiBJg2XQBGfol0ds6lQegiTQR3TziImzaiWs1DqoTYcY4/xuw0tNK?=
 =?us-ascii?Q?Lnh10ZCyU34HnztfbgOjOJUIIrsI9ZWIQdqOPV2/IyTAZJKDeshYmU2nfL6y?=
 =?us-ascii?Q?2s0hjiaciHVy34pR2AKUNfFspZnpuP1Qm1KwSr7f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 124e6d33-aea5-4232-bed9-08dd99cde467
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:46:13.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuiV8ViAqJMLtNyO7seEBXwuEkY9Jprk5wJhQjy+DJkkWh1HaKsH9rGJOqVXzc4TN+9QIdAmSw8ZUVlWNxIBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:21 AM
>=20
> @@ -135,6 +135,7 @@ struct iommufd_ucmd {
>  	void __user *ubuffer;
>  	u32 user_size;
>  	void *cmd;
> +	struct iommufd_object *new_obj;

Could just be called as 'obj'. but not a strong preference.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

