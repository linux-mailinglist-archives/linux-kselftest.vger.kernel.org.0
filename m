Return-Path: <linux-kselftest+bounces-20909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579A9B4430
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1691F2371C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67D203711;
	Tue, 29 Oct 2024 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqvvQghp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B1202F67;
	Tue, 29 Oct 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190395; cv=fail; b=OZz1IrLkqtyFQnBI784I0i/9gnkbmLNz8t352kE+Zc41uRdd6LPwIJ1xuwETGU4TDxR406PryLeYkShjdrgVWTpOrfrxSSJG3eJZqjhDHEXjnhHcNzM8zqsx0gO7IrdNQ+4miQMG5VHH45OncBy7cx4wJWj/8X7le+dkdcLHRps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190395; c=relaxed/simple;
	bh=og2RnH7lYxQRT9BVKqvk0MayA/vTBbmmLfUi4Az9IS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ITRBSFQyMsP32QpD0QnQpUoc6NJdMf3laEHgQiVCWfei3XSomesknJAKuaGnmAMBdH15gUlfqsxo9PTzC/VVuKOhq6yX7xdDXs/XbzLjFBFbOy2qdJwM0ZVmGA6Fvx3oH4IxrVtHOQTuld7c5xzRHS8F5+SH9k3RZDXKsnZ+Y68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqvvQghp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190392; x=1761726392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=og2RnH7lYxQRT9BVKqvk0MayA/vTBbmmLfUi4Az9IS0=;
  b=jqvvQghpXWWW8o2aMU5awyBIoq7PJROO3DyaPwo68hGvvyVh5ZH92Q1X
   mPygcTR+auM+igVMp2ih5qWtwBzofo7FiV2h5Y9OiK4p75h5omA9eQzio
   FAYxtx9g9IsvZCMDob7FIZCcKEn3uP2pp9fn8OvengNjLe/speTJ8Z5tC
   X63CPp84gUzrHUgdDxXc0K6DzNVkW0LALdSwhZFrF8rbO193uL0Wg+OC9
   i8I7PBNPwwyxCEFqKgo7nM/LXJOsii5eZLN4X5ouMb3VjdY4Zyac9ze1B
   XTKWJy5vfBkWlHx3iSfSk8MRwGbWFqdCkuZcCXCkds6v3FhojgGsfiOjv
   g==;
X-CSE-ConnectionGUID: y9N4PAbXTZm4cZVfDF4QvQ==
X-CSE-MsgGUID: eFg9816fQJqpql8JHz7ZdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30001964"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30001964"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:26:31 -0700
X-CSE-ConnectionGUID: 9j9JjtrBTgiJUmiVatlEXA==
X-CSE-MsgGUID: ecNFsswqSxC4n88xjQx8hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82029803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:26:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:26:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:26:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE8FGoiFhZPrEcqkRLI5suS7/RfMkRNX4ElkyIVu066W/nJUsahqsQAxTT2ygJAsAG7SdVVOWGailPr3PQmUWXF2owyTnCxqi7v3qyo2Quu0HB74T4VGFq3DWiNljLoTMCxt8Guu+OnBtojabRDJ8VrAqUUMolH3+doEVUMJlBWbEDv5ZwZgYpyQ2b+JRR9Hfpa77pVlNnaknQtP1auCRSCeEfDnk1Pe5IzIZ9FBXirHHPyanRhIbvAOLSrie9zoHFqZoEmov8sBFJDplbkQcR2i8N8yedztgitv+IaYKKag+/gWnP9IaZRWSAfiIqe7hVisLhgfKjtjXpB3yTynNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og2RnH7lYxQRT9BVKqvk0MayA/vTBbmmLfUi4Az9IS0=;
 b=Hg349+neLLKyRuVQcjUTnQAgYF6dXatr8HBUGvNap2twopBR34cHn+onPY0QNNdcXdfMsTsq3SV6AYgMv/k5FdwsTayzh81R/gJkrTZW8mANXMwHQ/H5MwLpbZzURnWxZBBtY7s7ccHrEdYMcjtbDt+klH9KRO3cVijIXG5vo/Qy+y+sjY3nzO4ob60Ts7nZ1D7nIEnbpcM7lgND5AKMADJZeLrDADGN+R2E7+dtASK7vtlz9MVa0yViCSXaCNtRLaB5K4BUAbLmKoEyFcw38Lw6YjZZkfXtaOnWL6fHi9WPPgzwtVIKMuSP08q0gNOlvhRRKDTrY1ro5PN/Zm0Rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:26:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:26:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
Subject: RE: [PATCH v5 10/13] iommufd/selftest: Add vIOMMU coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Thread-Topic: [PATCH v5 10/13] iommufd/selftest: Add vIOMMU coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Thread-Index: AQHbJzjP6nU7RuNIk0W5YGdHeD6rULKdaexw
Date: Tue, 29 Oct 2024 08:26:23 +0000
Message-ID: <BN9PR11MB52762B28C14A652AD63F98488C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <35452ef0c1bcc9e0ed5217c89c9a72c1f7a17360.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <35452ef0c1bcc9e0ed5217c89c9a72c1f7a17360.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: 489322ab-ed26-486f-d0f8-08dcf7f35fba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fZ2H8yFtLz3Z8uDASMAd4dBZwiO6slMB1PQq/PTafqer+pky5dZ4R95qokfo?=
 =?us-ascii?Q?69A9rokR4Ph09WQpLbNP5CgWjirU3ecnsJC9oSAjGwgn199UERhCecnKKGoS?=
 =?us-ascii?Q?vn9QUr7jm4hqJ3KwIGKhQLHXgu0cbvXrXa1dwvaozTNI4XTDWHPOQOVF8eEp?=
 =?us-ascii?Q?LX2QSasOnetVLvMWSiBtppOf0NUTLLZhzW1aLtlFY7X4XS8xlDMPTMWaZ5Zr?=
 =?us-ascii?Q?Ton4kiFm7p81bgenSkCnWsdpZaA9zMQ7Zodldj83SBQVYPJEtAGZY1sW5MCZ?=
 =?us-ascii?Q?28u7xZmHsoBAPPMlFDv2AucxPF4PEGyDNqhd+qCvlvZ0HZrYPlUct34XdMQz?=
 =?us-ascii?Q?Uyi3zXDMI4O4u489ef0pv70pS6nfNFqUNRGI2pDL3VrwStr5TO6z6BP+EEI8?=
 =?us-ascii?Q?NPyxYC1L1eiroos3BT8ymKF6qK8Wq2pJfHEKCB3TxFCzRt5ys4UZsMdbD/ye?=
 =?us-ascii?Q?Gm2lVTLPUmctFuBQLHX93xuN6aIp48JzMGfPiXkjVJ7xxD4IyyBzdT0swB1g?=
 =?us-ascii?Q?pMb/nuIThFrXWNp7etTufTKKA1AgCfrpQxB+np2UJztTC25aWZgFRtIpT6UQ?=
 =?us-ascii?Q?x3l/6IPbrztVxCTTM30OvV8OTaE7EeKf4LVbkO1QqXni7J7dJSUjH4cf02bK?=
 =?us-ascii?Q?6AVNZQXJw5V/x1bC7psPmxVeEpUTcWB9JvDV44vOWuO26Aa3RVw6MNFAhGaF?=
 =?us-ascii?Q?Phfj5giR+0wVBJkI6e7KmXlPkV3Vd9rI8VRxt4D2vRKPbDESNVpSa5NQ09xg?=
 =?us-ascii?Q?E3AXbgJge0wwbKmmdzzjB2BOaxtAribHBik3cRVpvWO92Qwde50Jn10K9MAH?=
 =?us-ascii?Q?lLvxoq3y58IENukfq8nRMKZaX+wFWYVhOJCsxrd2CZppQJmodToAo40E34kB?=
 =?us-ascii?Q?OyFQm30jYluda1hvkbVXWRbbVsOAMK4fJv3V87/asR7UZkXjQ3ine9b6cBOt?=
 =?us-ascii?Q?t+Q+Dm9FevF9sUJwWIbUhGoYomgtOdEOBSHAj4Eo8NnIw36aaYzsDIxG4dJ/?=
 =?us-ascii?Q?czbn3Zi6poYE7Q9KkVDKcpm5yAXhUR3THsmV1maOys/NKKBgXmIL8CGY+ChB?=
 =?us-ascii?Q?lFDKI50XVKF/yaFAN6mjfYQJ+GDcV4YI5M3kqbfmLZRKIt2H5JS0QMW18SZ/?=
 =?us-ascii?Q?tRpdCPn7zsZNi6hy6+YpMVTeU0IIsIhe49ORG4tRw/F4WWPKp/+34e/LLZlD?=
 =?us-ascii?Q?czqOjf4W9AilST3w3ZTwsO/Wz5OdJEUe8YnGf8nPu0HhSu6x3Ois241EJ78B?=
 =?us-ascii?Q?ih2bylh6K9uJJMi1pxBSXfmS38o3hK40RGCUKBZ1Zaqni0DUVONUgCueGbWx?=
 =?us-ascii?Q?OVAI6A0IKcYRfFL+HIG1nVJJymqJxaNQFlbXoxGJ4xCCFfu3VZYaKuZXOjja?=
 =?us-ascii?Q?rrL3AZE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Xp6DZqPa9tRX302A7H9Nmz3zrpKD/QISB9dpgC65Lq+kLkPqYMBZW7I9NMu?=
 =?us-ascii?Q?oy++SK2Ff9I2EpQhjA5/IOibOVo2WYt7wRmwPQqdaY5MO7j6OGFvcESpQlWr?=
 =?us-ascii?Q?hbyIgd1ur84qFTWp/tihe3cWhDjvgHC8rnIrOpnuM4qseH4fwHCxVM0rQ8YU?=
 =?us-ascii?Q?nqcsHxqaoSMvOzp38Atf51tpH2KHNVvqwVkkZSOlS6ovYibE6cA1NZChNR9N?=
 =?us-ascii?Q?UCAuNW53Lqe2c48snILnwHjgtbAlqYOr/lW99o3xDe8dhgToAHhI+l39nDp2?=
 =?us-ascii?Q?9Jw+xI6HR9OQBMbo+HZVQKlZOYF9xw0oM+iIX5tEhKVVjPNOghHXFMT9q7hs?=
 =?us-ascii?Q?/yBrjh9GdwD/cenTe+vViFN/niEWAjIgq5FE8Vr2x6H2hcNgB41jRwLLyc2x?=
 =?us-ascii?Q?rCMrMoY6XnsAqYLFK3qYLby7HAPRFqPnIyHc0FHXRYXNqn248LuMtUa9l1Qc?=
 =?us-ascii?Q?Fx49v3tqkWsHEDcgyMDwZkbF5rm35QGeR0nD265InsyWyxqjKbZKbMtosQgP?=
 =?us-ascii?Q?kqLSMhCT/iIjCVJCjhqVfJiFTfdWa5ZjTpQb6s5/xNpcQkh6Mg3QutPe0ONi?=
 =?us-ascii?Q?/wursuDRkw5wLBVZlrpfEumq+3DxWpRIAEYoHhvKn2yJXBPJhXe3l9OI25r6?=
 =?us-ascii?Q?wWxIDErWiBJcgD084Mjo0TdLGoavLSpwEf8VfnflVySubvc3lKWzYQtZRi8B?=
 =?us-ascii?Q?p7TGvE44GJiCRAlUnRrFWJU2rJTOmFaizYthjvdPOJ8C2X6LPvuxqVLOhmsS?=
 =?us-ascii?Q?uZYkJ9fpDyAipAGSLhB94gtT43nya9Z1c/illCQaNobdgVyZ2lP7l/vOO2PS?=
 =?us-ascii?Q?WFTbGNlAMne+nyOyqElBNQsFXyiZzWbhJHIzFUKnjuCUj7rQGTQMABZJrIvF?=
 =?us-ascii?Q?COW7EZBIowi5CWPHeLmAaaFo6oVEQ33+HZwjlHgA48i7xIda8fkSpMs2xGM9?=
 =?us-ascii?Q?bM9OuJsYuDqCzPuJL/YGHjeC+L4jnviyDXv80KlzS8OTjuQiTuyhvpN72nAn?=
 =?us-ascii?Q?V4MX8X1eKJxcbpHRKEkmJFRNInSlapr05swlI5UQd0Eqk6J8qePEMq0gXZHu?=
 =?us-ascii?Q?Z4+hA0lQOjysNNhP9gtDZ7fAhMkxqbSLHry4BSROu+6XiO2cO48RE6AeDhBl?=
 =?us-ascii?Q?2VRz2ACnWS9RhJ8r38lW4GyxtS1Dnc0EHK72JqrixBqh5hoE3QXJudDBdJA+?=
 =?us-ascii?Q?QCCcKwlAePHzTDwloVqXv3966aC0s2YRjeDUR2JUuNKqZ0iqbCI6tdI07DD0?=
 =?us-ascii?Q?DLBOU5TeW4hXD9LjDTo3ypVD/ifzo9ePctHbqIFJJeelSn2/i+h/faflJxqW?=
 =?us-ascii?Q?5FJAme9FW3Px6D3NJ7cm8juTBrkeE16pHQIupXhTYHBO9/EmGBorijkRMHZ6?=
 =?us-ascii?Q?gLr2fBPTyvK3iK92S+RXkT5YXkDQB+JurqHcC3kyDvjMLUKEkwlUl2je/F2h?=
 =?us-ascii?Q?pbiFa/B56ua3yphre3Ajzj66RcSMx3uSHgWmB+YkIj6PIYG1aRzowzwx8gcP?=
 =?us-ascii?Q?Ue7xR2ltGdNL7X1CDkDiJjG1Z4+uyBUwrufHgJ5oHXVEI9LW4w9ohHsxv9uq?=
 =?us-ascii?Q?OtuWKTVFBTzfF2DxNLuNXvxYaU+GrbdDom1JgSPi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 489322ab-ed26-486f-d0f8-08dcf7f35fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:26:23.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UybL3svHVX83GPFOqdlWX18F1GL/7L7EWQNSeeI7rMuVP7RR2PYzjqszmecMFXLborvTbZdY+AIpwAoqivaz2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> Add a viommu_cache test function to cover vIOMMU invalidations using the
> updated IOMMU_HWPT_INVALIDATE ioctl, which now allows passing in a
> vIOMMU
> via its hwpt_id field.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

