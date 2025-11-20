Return-Path: <linux-kselftest+bounces-46080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFAC72B5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14EAE4E1767
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4EC2DFF13;
	Thu, 20 Nov 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2rKQvsC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4B2BE02B;
	Thu, 20 Nov 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625988; cv=fail; b=ZoYuh+Ya1qYuLIjOY8yD4PWLZkRtDpT8C2Xgyi9QaN40f9Ti1cUNzRG7d8PiWoIt7h/xCoFkQ3hNoFJEweaewXWP/35WRfDXOsjUI/0S71XWnWGPE1jYWfCeTcfhNLPGWsjuP00kmCWcZ6nzkmg7IjpNO2Ac9+wSdp6VMCM/HvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625988; c=relaxed/simple;
	bh=RnmgHaxO74WBfl7UBxW4avUbatJJytwN7PQ9+WQQEfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mf5nInYilSxtb8XNLa7fObAcPyjT/YxasKABILv3I8lu5hBpAI7dM3teofESVCx6D03jSpKOhBk9sxUpfTcFZw9pCY/8P07nJrU2o8v17HuodBxsAF25gH0dt8Ecn8w/h419tHpgRw9QJvXm3HNHgZ7u4UvkM8byniQ4ZY2Sbic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2rKQvsC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763625987; x=1795161987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RnmgHaxO74WBfl7UBxW4avUbatJJytwN7PQ9+WQQEfQ=;
  b=Y2rKQvsCNjFkl5Fh9y6aqhLfJLVZ5v3esePxyaFc91mbRAYFjppl81sb
   7lv69/ifeA53sHExhKXgnQqZPK55L76mKQ6R7nvZmFw5tFRTtB0rarZGt
   476OQ4VGCE8mThgpug25e4/OhVfPqzMlkSgHSFRgzcvA+6iR/yRcmpnD/
   IptziNb4HTb+n3t35emz39JXgbT1i2AiHhdYMM/+WaNGiR6VuZu2bvz7+
   Lm32eE6HfZFVeifjJ1TviKDSFP5u/yHvUzNw/Dxu4d5RyLXPhs4O2CnR5
   Bf3q1pNl6zQ2Hx6tIL+uwUvTbabpfDyjcXqfiLdYymAp1/BeC48wTVzWx
   Q==;
X-CSE-ConnectionGUID: LSZJQPijTd2HGUJpWqnqdw==
X-CSE-MsgGUID: qScHSNmGQAuOT1dvXOuqTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69541871"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69541871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:06:27 -0800
X-CSE-ConnectionGUID: W6XVn291SYKQhsjzLA9g2g==
X-CSE-MsgGUID: 69iDwC/SR+2EnQFzlfdYZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="195592165"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:06:26 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:06:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 00:06:25 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 00:06:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp79c/HvBt/i1HOAIFiecBUzy5BuOta3m5aQcq0ovdYmvlW9aUaSmulQ064GgTr940bHcgOydAbOKGhFlRhP40rvlRqS534jFynBBd9Fv0b7FZ7Zo3r3bZBLcazJZpfCpiFq/OMO3wG6MEPWNMtfSknOIx4vgzs7rLHtQZuNeuAPF+hdjNtZhXwB6w6u7rCqP5sHaaswfE7dh4+IiRC5yiJBu+tYYX38Zq4mn9A2oT/zh8Z+VAQIvEjmGt4khNU88ZpG24z7CHLuO7JJPU6iKhfvY6eoA0L4jOgheoYAvuiGh04aW10bLKVfQeH5JZzq3as0KVbJnU6Cpls1UItJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnmgHaxO74WBfl7UBxW4avUbatJJytwN7PQ9+WQQEfQ=;
 b=Qr2NsYBXG9DdqIy/Dm63SZ5S407pSBckJ2vbuWQRddTp+zuXmsj9E0H1qj2xPD9L19f4KDnKLQ6Th34UbOStDo8GvXMuEc5rWSB41zCnhc+0fxtlcTVvbFIPdUFh43kgWPHTpqj+P5002eSy/Eu3LTcT0R0ZpVC3zWmuzps1ljT0axajg2ImArUePrE6mF1F4ZhuTJ0/BHQlipwA2za/YjUUB4pxv/DG1B85847Jl4iGWlZw7AALmES1JzplGvC0yVYd8g2lVtsMx25rhWh42+iDEu0fEq96E/ksE19WrR7yDVjzFFHJy7bGAJ7fAqGvbsyJZan/Frs6G6jo7IgqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:06:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 08:06:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 8/9] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Thread-Topic: [PATCH 8/9] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Thread-Index: AQHcUAaTEfIdPqEJQk2CMiIlAndo/bT7SOOA
Date: Thu, 20 Nov 2025 08:06:18 +0000
Message-ID: <BN9PR11MB5276EF675C70F9DE99C2F49F8CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <8-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <8-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: 1a87681e-579f-4a07-11eb-08de280baf2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ThDtcfdqzfkoDQzg3L4Nc582QryKNr9Ro0Q5665EqmeDKEsEDupMfAIlXf?=
 =?iso-8859-1?Q?pWvtxSyyLphRMOF/3JtNQGxoIj+CYHvFUejUeFXGMlTz9t+TcX40pazFCF?=
 =?iso-8859-1?Q?zVImwv1b/SlfO1vnFcuaks1/aHgLhMbk/coZ4bPIk+FcRcMxJfdwc/ejeQ?=
 =?iso-8859-1?Q?DvdVrdGLPyDbM5Rxop5VIfFD/SJWCs6SS5G3ksXvj1zK604ni7jDjBV47+?=
 =?iso-8859-1?Q?NvJ/iI/DubWFlrfjVQnVTM+bAU121TwBMEIDuQOWRw/bX0hGM+5W5jfwUY?=
 =?iso-8859-1?Q?X19lCqisj8TCucaJ9TrWa3DgfIpac1n/bxjbGzXBP09Wmf9LXxRDHjS3WO?=
 =?iso-8859-1?Q?KHDTRi2FsA8akJ/yHdhfDpgSQpHGeIPvpd13rrzZtBLQS4OVmmaSVdeQdK?=
 =?iso-8859-1?Q?z2DV9PI2JqB7Y0IIkL2/S1ppRTf9s+/UUzD8VDrhrGxdLW7PWjy6iKdP5T?=
 =?iso-8859-1?Q?/5zgZDc65O7D0XHptZtCt/aZTBwOxO7CFR5C5mj1la0UhRauY0UyR7uy0i?=
 =?iso-8859-1?Q?HQS5V+L5BD1fLMaj5cIz12FikqTkltIOhWhsvD8W2i7yWfZ/Kwp2eK/JzF?=
 =?iso-8859-1?Q?YHtfcVftbbA05fxY98mWZN50+4Is+LAN3eYSVL6LmZD60Ihs/nuuXsiGpR?=
 =?iso-8859-1?Q?v9BxHeq1BW0oEVp2IuTbSG8N3abP7/tQzyyFR+Do6UlPFdGKHs+OW5pE2q?=
 =?iso-8859-1?Q?DIi0tBoFbj6f/0y4QDSJ9zKxYJ1+pRTNTRmNwt+ylcAhogqUEUsE9ai+24?=
 =?iso-8859-1?Q?pZgOtVRLTtOtcnc+36iv3qbhA6VzhY94S3HnxLD1U3wTKDte+EN6IcBrsa?=
 =?iso-8859-1?Q?AzlCkqwMby8M6FcuzCcswl4c/A1krPRxCUU9FmJ/doVDjWhjd1syOq7mM7?=
 =?iso-8859-1?Q?h8Knlo4cb0kxaE/+3nmdjIU7n1tM/33b3fIwWbyAfzl18tVduUPL6hSEDG?=
 =?iso-8859-1?Q?R2A3b5XZiRgUP9+Nsr70Z2wsBqeW6z+k139mNyQuokLbMcti8zODK7l8d3?=
 =?iso-8859-1?Q?sXEacCbOucpahXDbbw0RLNezTQQzMLZle7pKIDPrvBfNIbT7GWFlQf/epG?=
 =?iso-8859-1?Q?6TX/pCxgXdYrSKN/8GF1Soo+a2AEheKNCfmh91Wj0q6Ny+ST/Lb+o6/AcT?=
 =?iso-8859-1?Q?/U4pCSULFgTStduY9WrfW2sfSENEGmnco5lawh0/Cd7ZILpPOfuhfm8Nsb?=
 =?iso-8859-1?Q?sG92SR1xPyIfvkkc8W0cqEmNKJx5UbDW4afrfzORoW0UOrJAtVxG+ajfEJ?=
 =?iso-8859-1?Q?aoYey+K8glvwFqqibHjxDefzvGj/h2L+1nVzS5nUAXLe9BiuQs9Z+5ZJmJ?=
 =?iso-8859-1?Q?8uKWAWG50mCldnYJISWsh2L9T3/9Y4AgXChqi6XL8RrP0mT+vFUfME2Uqq?=
 =?iso-8859-1?Q?V1TTSHKbD0L8hNCFEqOxpeTB1R9PkWiHzud6KeH4jHVqP8G/PgvC7FWGyO?=
 =?iso-8859-1?Q?w2uxRHtwHPThe/RPs3cz1BjqO3B5o1axntflcV6gSpGWoW18D8eUo2XKfO?=
 =?iso-8859-1?Q?UTX3P+TZaTDmjLLwOhuxUt37g2ccVwJlzL/K9nE92Ec33bHsdCAgRRS5+B?=
 =?iso-8859-1?Q?wlSEE2+eZX3Tgav8Iof1hnepDZqspQhelSHzvurMo7SDyVjT0A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1I18M9VhbPmE0KicHwFwS8/9eiGsKagGV/KQ5a2WBGciGoSNUHM1iog9tG?=
 =?iso-8859-1?Q?j9xj398GcnjyggMCV8b5/Wk4IX7oRfO8PWTkrM3HT+qEtxGO4nHRQLymeU?=
 =?iso-8859-1?Q?a8Qutdy13wrGQuFfliqEJkVhdMyxt2d9kRE4C++3emtMkErBBUofKNWSq/?=
 =?iso-8859-1?Q?29uZBl8LipqmFYH3lxaN5ISJbXlqHKjwM4Tg02YnR04tkbiHrweGrINh7x?=
 =?iso-8859-1?Q?Ojv0xxO+Xl6WJPfNo4eQoaq+rFbbmv5opr2MFqwyhFuzqG6J6bW6s3co8l?=
 =?iso-8859-1?Q?ldd3d+IuiPo/xndCYFhNhYKXBBt7xQLFhZo1WxZjCNMpix7qQaKXEcJT4G?=
 =?iso-8859-1?Q?0qZPQYAPciwz8vAZdf0yD4jZsnuusPinbTcw0B7DSwcugYBRE9kciek5hw?=
 =?iso-8859-1?Q?GOyefJVhOhhrax0v+aUlhQaZHJaUhG4qseUocEdxDigDpcZq8ItKDjxUU+?=
 =?iso-8859-1?Q?QNePJLHB++603KCTftQfI9GfIHMRsmQBHRcvC9leb0QZ7BpG3dq+qX2UHw?=
 =?iso-8859-1?Q?tP567F0Di1zcAzKHN1Oa9OXOJ+iiA5iAkIdLuQI++kx+68mOpAavXzw+A6?=
 =?iso-8859-1?Q?bfymoqscfhmnaChTvAmizKQ+z/j62p9sk8BqfVvrcCuIQYRg8mSCN4AZUw?=
 =?iso-8859-1?Q?mK4kDmuhZ9PF3+pkh62k+uUQQEwHM2l19lNFi0Ox9iOU1liSlVaoQ1qa8/?=
 =?iso-8859-1?Q?YEonJ08mX5aU3LRmjTx5Pb4+PUmKoox0L2RefRkelYA0v7G+tbww8VB6FY?=
 =?iso-8859-1?Q?A9AfMYeFqC5ec0Og7KqjBX1gWTPoILFWOAgTcPT/K0BoYhHWkkvRagHZad?=
 =?iso-8859-1?Q?fGQ9T9q5uaNR+qyba+zoKmV/oqLKnW2WUGcMygu6NEF4hXpq1NW02vIzL6?=
 =?iso-8859-1?Q?KpNTLlNdY/zFw8dXkDbVlfzxWckHYPVLpvLnhk/VVdqx/TrapgtX0Robta?=
 =?iso-8859-1?Q?BNwv/kRZp6+HRjQe+IU2UP3Wnz1fP1ORW2e/Qfra93FR+p8MUQ4juYIJbt?=
 =?iso-8859-1?Q?lVrXeaT8iwav/hsV+bWkvv9AMC/8dcyfd2qouK80GpmAn2N3twHn6s5l+p?=
 =?iso-8859-1?Q?qefrqEZJKJNprRA96quMQGW6ESIb0pQ7lU+K85HJspdMofRxoVa+Gl12VZ?=
 =?iso-8859-1?Q?YEynL0FofQxJxVzsWqoz7gNAEhOxJRBViOLaTmcRNdRAjSJHulGXQKUQub?=
 =?iso-8859-1?Q?z8U8JP5q/6umBk14LnONCFQpLf7yaFVi+uBAa0dpVjA18FD16g8OMM7ZPQ?=
 =?iso-8859-1?Q?Bjt6QhJinz1hr59AyNXxPYs1YXO70u3ZsO2uUc2VtghhPBN9ETDWKFIbkC?=
 =?iso-8859-1?Q?CBaBRd5mtzwI3Ng2KoOgDA2EnMtwTOpmjlqS/Z1dPm3R00TEA32x1ew4zW?=
 =?iso-8859-1?Q?UzhjmAHAd9hRTrUthomxrz+hzb/CKzkAqsUWUuMN0OIzmhmQ8Q+rd6f3T9?=
 =?iso-8859-1?Q?Bh6j0MYs/hOxMd6ALzEBqG7DhzlZdkcJKvPDRqKAQYbDegohE3Xb4NLkzB?=
 =?iso-8859-1?Q?K164HQPzciJbK3DSgRQ2y3Yr7HsnjnNpjhpzxyvLMACVRHpmLMtUpDmApr?=
 =?iso-8859-1?Q?GtlGocrDzIRe6DlnUHcPsuAZFjDMbRYlSsKrT2qQVrDop6j9Ah8hm9VecF?=
 =?iso-8859-1?Q?KMuCx7JemINiIMM8oJsy3pY9l7sGKX4zTl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87681e-579f-4a07-11eb-08de280baf2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:06:18.1860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zHO98pIpF5zpgDzYFsEQHMSQcPNz02M9etajnf1SzgFsj60iOEsB5VDR0QMBOiHPatcGlZIZ+LElETIMB4JnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 8, 2025 12:50 AM
>=20
> Finally call iopt_alloc_dmabuf_pages() if the user passed in a DMABUF
> through IOMMU_IOAS_MAP_FILE. This makes the feature visible to
> userspace.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

