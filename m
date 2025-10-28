Return-Path: <linux-kselftest+bounces-44167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9EC12834
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 02:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8541A274D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604B21D3E8;
	Tue, 28 Oct 2025 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1aEWdKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4121CA0D;
	Tue, 28 Oct 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614184; cv=fail; b=g8RFQXa+ShtuJscI6h3aKAmNlaUf641xTjJ02W2db0b6fqrPckMKSKWLMNSfwXruSyUWWx5/oAYM549xvTnODvrr1OA94kNWeVMvnI2TZNV+65lkZstF5M0L3MfZGPz55RRLo2ltxOh+cpKlETiba6xmrMVhumq99bKdtM8qNb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614184; c=relaxed/simple;
	bh=kb6/kORm7Bwf8XXOmQXYlVYV4/bgcv3/xSFehETDk6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VBetmxGugklo/JloiTCQG5+e7o9sx3GOU7FT74l61pgVbKFT0VXQBZxmZaw7+6+KUP0qKXA+sxysCcoHryTzO1HHER9nxUrkInw6CWBTUpFzWUz6H+9ahmp+SfQHvMq3Gkq0L5WBdoZkany+E4/601Bg1z3X75bxJuEJQ87yaCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1aEWdKr; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761614181; x=1793150181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kb6/kORm7Bwf8XXOmQXYlVYV4/bgcv3/xSFehETDk6I=;
  b=C1aEWdKr/hHUcoU3PGKGeIlI5uTW3vPKRS0E0ql0wgLLF6E47VGpqtM9
   Y2YfX3SeKZ611h9uNSgtLqYI/BvbLQUnyIcnHSrQkFg/F/VLi1xIpWlkY
   JHgFZYEqRhubCqDBwI5ghMGK8VZGb4HP96+xiYnrwu+i6PBBjiq5tMVRR
   iatFmiNht3sefIl0G6U2hH4ivQA5egsx8oXz96aXs5ev0EdkHbCYUC0Do
   cgU+vNj0YQDVN9eO5S1z37PLPcmflgkoSB8XQUS8ehbLdUfWnWayGeJDb
   UowQQqXkmVEPv5ZnJD+QCKlJyEPd0zO/jMzI09KhzbS64xpcf7P0ZpoBT
   g==;
X-CSE-ConnectionGUID: ugKxtuLvTTW62Bu0wr4sJg==
X-CSE-MsgGUID: NKnAFxLTTbyV27tNfc+IJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63742552"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63742552"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 18:16:21 -0700
X-CSE-ConnectionGUID: PKhJ73hXQeCNQ/m3IxdCUQ==
X-CSE-MsgGUID: WZlyWw78QuOiLHnRfJRADQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185663022"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 18:16:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 18:16:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 18:16:19 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 18:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgeRxSQelDjyfogj7lHhsATdQhWQJnK14vR6ujh9LgxWfRalyo0bzTOjCwD1NY+97yT+XmrU1jzrVBQ6CQTsUpZvhM7uTPH9h4xo2xkl7MQPrTiBl4xquKm3yMtYkJh3stgmzgRBwPNnHEb1Oy40jcc3wQrv4PPKQ56l2ZNls3phVjgc4LF0nqaf5sbZJvbmzbfsusPfPtmbwObIsBXQX5sjwXkebTgRLYgYA9Ja80XCqXwHDTWp9sRpU+me+0DD8v/d1dx6QhMhDOWZqtDc+a+2Fgv61n3sFvtonHt+ks37MpcwjhRfXiQD+gP768EL0vzaMnYYue58WWkDuaLbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrbhTJ0r4PO83vR/0raUGTVlVlaAwRq2EDzHSPqsPe8=;
 b=XS4eCy7aLBbc4pMhMpdOpYPNU9gqxloFCDqnZaJPoHjkFgscLFCFlmisfgkurziy05e4EKF+F8y4hO3Q1UUGt7J7qLuHHjOeUfWGDglGtEWz2YpYvWbONTH5BnQtycX/gb5sMk7YIZqrZ5uLBilmcildxARPHLuC3PhWcmCQvdjjsmihNBmgJvESpqU3s1v0Joh7Rgd/LsQ4vSAZW7sDez82+P5kEv25RorOfiLmEdC813oQV2/MdjgEaBD2nupo1s0lDzBlo3ZNMjxw/NnGdrVxeBGlZDKLRI+rzgrpW/xeB941RCSkWe4APrSLMsRjRveGYXGDj8f9TBXkXEEIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 01:16:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 01:16:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>, "Anup
 Patel" <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, "Jonathan
 Corbet" <corbet@lwn.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v7 07/15] iommupt: Add map_pages op
Thread-Topic: [PATCH v7 07/15] iommupt: Add map_pages op
Thread-Index: AQHcREnZveRzU+0FVE2mIi5+sC2lDLTWyCug
Date: Tue, 28 Oct 2025 01:16:15 +0000
Message-ID: <BN9PR11MB52764CD5E4E461D36FFD2B668CFDA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
 <7-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <7-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6456:EE_
x-ms-office365-filtering-correlation-id: c2f9317e-b979-429a-2c3f-08de15bf9788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?NfTBZBHf6S4vVrbT1xYykNcsY1p8ksYZCrWKGebXOUl5eq6IGmPHyA2JOkm1?=
 =?us-ascii?Q?t4azf0W0bc7ekZlnCEKsMZTWcFklmdNuXE2drhQZ+F/OhKxaqN5wtcTuXx/v?=
 =?us-ascii?Q?Oyk4zE04wbHS9+rjJuHn71vGzLTacEKQddcRkC8STv0AQ4dw0ZYiB5mx0v8e?=
 =?us-ascii?Q?4p93jrCReL38582C2Cj1/dDeTixycOn+DeIilkR/vmDKRuOrgtTVFwSpJdtF?=
 =?us-ascii?Q?QKhlwfbAgxgVO4y4CnEKvv0/tk4TsjVOcGSV0TEHmq7r/zkvjTg/6PaYi2tV?=
 =?us-ascii?Q?D3pYpK6b0z+FNs7dLHuHzly5gUnspuI5mSw9KQPRB4N058pRRaTzEL34pLkk?=
 =?us-ascii?Q?kBlwAv78o/ZmRMUjGwqsj+2KIxEkCaPD0JEAwK54K/Q1tEz9LwH0GAPK6zJW?=
 =?us-ascii?Q?mkToXbW1GgTGT6EjlESR+INoFRBk/oLh9617aMxeVygPZTNl2hfrXVHdC/M2?=
 =?us-ascii?Q?56/bhX2p1zsJHoiPimexc7M+a68zy2kAxueFLeI44Er92iVgsBCYvtaJzOYG?=
 =?us-ascii?Q?YFJr8gEvcXHA8IS6BF+ds6XfjaVX8wGsC/8igPsZkUjnedZ2FAhvtinZIqeL?=
 =?us-ascii?Q?LNMo6YlA1ElSFe09YmWiIXwhc6Fx59IZ6U+ySsD7z4/2S8v+gU+00cTnfE9M?=
 =?us-ascii?Q?gEsXijyohifd3NrWYS/qSetlTvXlZXQmcn/zIsLwchNLjWfY47eY/Mdpy6j3?=
 =?us-ascii?Q?Nnv1Fvn22ImDmI3zQM4JATzO6iLLLtKrOhcSpbhVwfa9USaDLx/BHA+8USRB?=
 =?us-ascii?Q?HxxjMFhxcfb58+UNIXzfj54FbjnOG50O1YHjb+hMUo4r7eA+DLAUc3sybrvV?=
 =?us-ascii?Q?t/hgpcebWRdI06A1+b6wpQg19uMkkiYUPlrqfaO5jFQkich5vLhB86/ISHEY?=
 =?us-ascii?Q?4MLGg4oprSQjGRj48XTbUxhN4H401Zfi2sf/YYaI7AFwb+3vpGWBuXCRSWP4?=
 =?us-ascii?Q?1iltYK4wwOC3F+f1uBGDp8HGN8259AgsOtYZIhmyxJF3RVEGGRDyeDoUM0qL?=
 =?us-ascii?Q?hpIdU5oHTTsanvRUjHEY+StuFl+xTtZkDW1m1AcjMCOIQ1tAkVMprhJtFti8?=
 =?us-ascii?Q?AampHtsm7IJiYirL6XX7PZTT5No/aL1arvezs0GqwgHOJjTfoDcNoYOQjYo3?=
 =?us-ascii?Q?cAtK1qWExX6iymhIaZtv68d5WV2brc8syTr/D09nh2CG0xyxj5gDWrLrV1fr?=
 =?us-ascii?Q?DOD+IN078FgBFygjlaFjarML00reDHoKj7sRJRrgqTf8Vj71h8TSIAsr5Mmj?=
 =?us-ascii?Q?Ni4mnTULaL1vHSmj5HCjyWENhpMQLneMDmxfeoMvJvxAl4nVHHUM4T3Cpmey?=
 =?us-ascii?Q?l/lcZWGk+yiqgppzF/vSWVHnt2VPtk8MMN2NR3PWqgntBMwk/tyi9vuyi6pN?=
 =?us-ascii?Q?y+eCEja8EHKJZNKeodg3tiaCGxJeC0iR3ZYxFrN35gAaGkX5EbPLEWjeAtkl?=
 =?us-ascii?Q?WesKgullCKwyvuyUc1LDtSMY10FjlqdJJ2A+wymVkuUvcnErg8cUKCp15fG6?=
 =?us-ascii?Q?a8oTRRpo7LhyD0lNV3Dl2QG4mpInguIY4OivZSu/MXz3G23VBKuhPlJQgQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?stYO6gC+aOlPLz8CbzJb2+OPIqMLgRdVt7/tQWHZh6YmdU/EWQ8zpaIMNV5H?=
 =?us-ascii?Q?cv0kfisVkSI3VPTshGZXv+uUpbisIbJ/LDEr6jDeZdY+5+yCy5ZkeoToJdWS?=
 =?us-ascii?Q?3tR1dFVWNnfjx1L87Q2kuhJe6Vrxmpuxr++M58emoSPAQdIgPI0Ia7r8VDp4?=
 =?us-ascii?Q?hYs2Pc5wVA7EohK+wZZivwc5KcsI3PaNhGucKuNi/oBQI2kZuErvHr8/pILx?=
 =?us-ascii?Q?XXRCu3PT7CQ1PSZYU1fTmOPtdhxQYe315VpUvpPrTTI1LLLotMQSAEYzhVIE?=
 =?us-ascii?Q?uY6XB7SJFaZIeynGfjIrQerjueP/ZnEpi0WD4qZ3YwT52rn9Dzf0eYZrh/al?=
 =?us-ascii?Q?sEemoYQL/JFJXLiSiWqrYQIsITmrUBgoCnvtOEMdkZlIIuU3xiXlyfzhBhVQ?=
 =?us-ascii?Q?q99atXo2fyPxp/LrtlqQlSI7BFUf3dOPH7LyW2xp+6s7NQC0y1E7F1ZQsDKJ?=
 =?us-ascii?Q?0Qfm5jwH/zKv5KjX8Q0niNtOrnRklC5G4UBxqpnPYvLq0z/IXWDlb+jMjRsG?=
 =?us-ascii?Q?RH99s7glr+bb++/3hmLnhkqIlzgTDnaYmbLKYyX7N7gqxSwycghlc/Ljb6XX?=
 =?us-ascii?Q?sGlw6jQ4P6dmj2STtESXIcckCuLbR3XH6tCuMoWvNXYV54PKVcBDjxUTlGVw?=
 =?us-ascii?Q?YKrENBMKsijiENCsvi7OPJTzczhcSi0bgBZjDbsDtonvkXPg7ss/R5wbvAGy?=
 =?us-ascii?Q?PyEXREplRgsR9YkvU1NRJAgk1+cGPx/09elqn19ODkJdSIswkNVkALFYkqD9?=
 =?us-ascii?Q?nneQiUKduihqYXItyShfb+gxKvZJDMjnrTQO2sTR8hRyZGRZadPP+TJJu6wZ?=
 =?us-ascii?Q?G87NEQQREhX1o5k6LekL0+xD4bFJOeHk5UPAYrvUvbcM4/7jouzj6scOfCJW?=
 =?us-ascii?Q?mFfFx8Wwiz6OOiteOVWzfszhKk3vk26l1OzP4vN/iwKNZlfMknN7x28Plxt4?=
 =?us-ascii?Q?fD/+E5R+/mZfITKjlI68wQFZVPJiI8RNEObhBH+Ffi+hxx9ko8e7dbJESTin?=
 =?us-ascii?Q?g8X92JIr2KRuquO6FBUMtg1AIRXwTbcfK6fPzjzvG86se59NVE+VqQrBKSNA?=
 =?us-ascii?Q?1aB4rbABipNHTwOXozLK1Sh2Ud3qBfYfmr6BN/F7ldB3Xs49eygzgcDSJXVp?=
 =?us-ascii?Q?+FC6UVfwb3cAT1BJyea8olxd1vavs4KD46xEBLvyeqaJTNjAhHZgHMJna1eP?=
 =?us-ascii?Q?EKhidvgXF6QhrKHsJ8VO9YR94gkprYOOINeOH03q+TlAVNa3qa9dOjKzedTl?=
 =?us-ascii?Q?fbMqD+S1Ri3v3y3xkJmlZ+A4EsN78PHQMXUgBGXoQ3nio94H6b83xhsw6OUX?=
 =?us-ascii?Q?UkiHJtJmVlhNr09BtnAqP/5qAOP9/SaB/hlMQ76uxC3GlXpRBp/cTk7bjknR?=
 =?us-ascii?Q?Z7Qocga8m0ZBRP+BWWmvznw8mwl8NbNHQjbZ3mXoi0eWX2gn/JkOQARpKrI4?=
 =?us-ascii?Q?sVD9XGLVf5vEKqyPysEasOnAv1u16TzlSavWVJWdIODYXU6FEqdFocuLbK+P?=
 =?us-ascii?Q?fJEbKEMzdU14fp9CWZpCQJEpgPY9MSJt5zOem0PSGt2jKbtbYoTTgAGySvVJ?=
 =?us-ascii?Q?4od5AsK4BrpxIkYsDibc2vTs8PsoGJbNAUunw6Wn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f9317e-b979-429a-2c3f-08de15bf9788
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 01:16:15.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Dc7vwM5K2Gu/7iy0W08Nr+OTwPAvDI11oGg7wCfh4ngob7SagRbF/3gyzhQde9iLOO8fykd8NS0OCzYxaKxww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, October 24, 2025 2:21 AM
>=20
> map is slightly complicated because it has to handle a number of special
> edge cases:
>  - Overmapping a previously shared, but now empty, table level with an OA=
.
>    Requries validating and freeing the possibly empty tables
>  - Doing the above across an entire to-be-created contiguous entry
>  - Installing a new shared table level concurrently with another thread
>  - Expanding the table by adding more top levels
>=20
> Table expansion is a unique feature of AMDv1, this version is quite
> similar except we handle racing concurrent lockless map. The table top
> pointer and starting level are encoded in a single uintptr_t which ensure=
s
> we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and
> use
> that fixed point as its starting point. Concurrent expansion is handled
> with a table global spinlock.
>=20
> When inserting a new table entry map checks that the entire portion of th=
e
> table is empty. This includes freeing any empty lower tables that will be
> overwritten by an OA. A separate free list is used while checking and
> collecting all the empty lower tables so that writing the new entry is
> uninterrupted, either the new entry fully writes or nothing changes.
>=20
> A special fast path for PAGE_SIZE is implemented that does a direct walk
> to the leaf level and installs a single entry. This gives ~15% improvemen=
t
> for iommu_map() when mapping lists of single pages.
>=20
> This version sits under the iommu_domain_ops as map_pages() but does not
> require the external page size calculation. The implementation is actuall=
y
> map_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize iommu_map() to take advantage of this.
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

