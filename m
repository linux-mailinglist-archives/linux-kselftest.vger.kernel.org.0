Return-Path: <linux-kselftest+bounces-36284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042EBAF105B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5513F5221EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5E24E019;
	Wed,  2 Jul 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJJAzBnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193924DD17;
	Wed,  2 Jul 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449291; cv=fail; b=tEm+jNo4oL+tRxMR1IhmmP4Ovf2827xRzCIOL5Lv+mc+hTiaAhvzpFqWJnPbv2u35EYdrnjpjb8kyP7WHoh2qvn7epRyzvTfctudWkN+ekP9c8dozzUpzC4oLvgyatyzsZqJ4XYiDb42Ilqvsb6RgaESYbDYYanwofwAde9cByU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449291; c=relaxed/simple;
	bh=nuye8mQOymLoyywShpn2OBErXg9xa0KbnVcOmRD86k4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MsbNEQBtcIc7lZW97YfB5/1Snq5KCkly5v8iQwyMTLvDU4aS/fTMUxwnMd4CYBOaR8YdYkDpQrao3mafVa+bJMUCmjaq2qQGOZWXZfw18e0POUhYJpUCJ5kPdSP/CrFW7LP4HwagMfvBSzbpxfH9kJN3GdB/Jh9Z8iFrRuAG6iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJJAzBnX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449290; x=1782985290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nuye8mQOymLoyywShpn2OBErXg9xa0KbnVcOmRD86k4=;
  b=KJJAzBnXqx4oqZwSrduJZ8w0uoBUzn7v/6HEckeeoePAg+gyhRIT1dGg
   yQylegAcIAfrDZlWeMsJvrGkIH36mLgImszQqw9yPPC1gG+1lKCBgyMgT
   lM6OE5nawlhAXBwXcNhCK0cI6+aJJZUF4lIcYiU9mxxIa8lT0Ufj2VRB8
   EVOmoNF7vvkzlw24a97DUXV2SnJldmfBf9ljPYNtZRpLZz8rbm0RwsBhs
   c8cJuRIIfSjybGYWjN9iWGlXK9itIoRvlSOWKdYImDVcClz9uxdB6Ovrc
   /QG6+6K/mNLWTr75wuOug+OWaT1LjWO2pomApC02+k8A8CRyZfpsNCi6E
   w==;
X-CSE-ConnectionGUID: yfKeOJchRjW3qZ+MSQneGA==
X-CSE-MsgGUID: Aj7QxM0USLO/Fq2WG5keaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53853535"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53853535"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:41:30 -0700
X-CSE-ConnectionGUID: Qt7ZVvh8T/C0ktT+Dj2acQ==
X-CSE-MsgGUID: nAK1f8Q4R6mfrMWcOPLsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158405969"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:41:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:41:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:41:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg0ZxXkQc4hhsZ4JPHccZr0afQWdD8MIu9Hc+AZHHOGIKpArbyFQLQnBVTcmY48Bv/HoqucgJBg8fM/jkSEsQivqBnKPRcAk1PaMZfvlpM4v2VQ8QM/jfWxpNXaTFaiviXBKbHAqh6TTnp0qo/F3m+W+ZCl5ErVMyLXuokDgZdtKQ+C9UiLNvtpcSVpDNV3svNaJKIDzlnEi9U/x7ovl86yZfgyYWfBV7yT9xZR6fWeV57YzspIdCuRKDNkOuHqN9V9vAyEE/rhVDNKmTJ7mm7agPmoYF/bXjiWntHytwURkwc0VDiiRP4y/empCeWSStXBhqq9/FNzQmce1akEF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuye8mQOymLoyywShpn2OBErXg9xa0KbnVcOmRD86k4=;
 b=MQwTBKmqeDfrFVyQymFnUOfHDXi/pkLIvhWmZYC2/FNpgyW+9S9NJb20p3Ax7Z1my1+O7+03VuCwkNBlSKdkE8mCo1zbS3ULBAYlHrP7HO1zGBDtp+m9KFEWKhN8tXElpyi348bH64OCErSh5sHjHL4WlhkGWMM7fxHlKuuZX23FXRy4atnBmmgNaVprns200uVScdb1kuql+LWGQgtgn6TlsqLyZFLf+KGiycjasehOWs4qD63btDk+BzNtrreg2T2s5EUXP4wBZnw7HqtdJGuQKUXG6AEG5nX+CBxWIgEySLIKSoaxVAILLUxGiq/NArg8+JYhBClk3jt+FXZKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 09:41:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:41:24 +0000
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
Subject: RE: [PATCH v7 03/28] iommu: Use enum iommu_hw_info_type for type in
 hw_info op
Thread-Topic: [PATCH v7 03/28] iommu: Use enum iommu_hw_info_type for type in
 hw_info op
Thread-Index: AQHb5tGAm+R0ztnTlEuZ7ktC/QgY2bQenTPw
Date: Wed, 2 Jul 2025 09:41:24 +0000
Message-ID: <BN9PR11MB5276BBB07B8944B875D376468C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>
In-Reply-To: <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: 2de0c962-60ba-4863-b79f-08ddb94c9c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?N1RDDEqXrArgWaaHebSourb1XKHm17Fw6qxKThq06eZbQro0XJo5/QGR5qQ7?=
 =?us-ascii?Q?7B8puIF67fMTxnihYmYxTHaxJfK5OwaA3jf3BnmjFlvtQImag7YCCFagHLZt?=
 =?us-ascii?Q?c7fJvSL1Ge4CArUGTd5sL9LsGN0b0bSIcjxdY/aYlMBMiCo0vjs09byiTAps?=
 =?us-ascii?Q?Vtejhj6lc7LxeHQGJXs35Enahp7pfgQXR8nzOtwF4bn6UkyImX2l0hVNa/+2?=
 =?us-ascii?Q?j7mBmDcaAf5QO2Eq4bPV+U1MGbBc8RtEJRo4rFLgBZKiJ/6o46KMIde+nE4P?=
 =?us-ascii?Q?JBomG1y8U0LekA6i2PrCjubD5aEgil8+pXXE/QimHjVjmjk1YSBEUyXmdDuo?=
 =?us-ascii?Q?0ZHx/pWnrRY4obohLExQUSNijbHDlZv7XjKdSF0ZwXNIqdD08fSI2LccJ2k6?=
 =?us-ascii?Q?GgSLJZEH/XkYKVeSt9K6e2wt6zGfDN4PfvD89m6sJZAev3xSpweYrwWO+JhC?=
 =?us-ascii?Q?c//YRewrDZ7PVKcaFVRBkRGJ4ri0yyeLGLzejPf/AB9DQQADfNHuXljQlom5?=
 =?us-ascii?Q?X0FjJaMP3RCUffBY+SAGQXjPCt9Rx3RtadokP3abbke24jaTPC3zpeFrrDGv?=
 =?us-ascii?Q?kVkua8xIGeHsUflfkPDb90MSywvufliyrREpK4sciZRi652Mv3wEMV/hJNE4?=
 =?us-ascii?Q?oOImiHp5RsNwoCLNvxDdD8gWQVh33z9qXy1Oz0OpydR4leEFzp/po4nPEnRu?=
 =?us-ascii?Q?wVxVokMDK/nS1fjuTkp+uoQCOl0JxtqYX1Hq+2VlHJUAN+7f6d32Bh3Yco0s?=
 =?us-ascii?Q?EE2eU3W3DI0Al+8vo/StM9HYX4/N26KvDqba5/wXjBg4qFLZtIxy9MkbC9II?=
 =?us-ascii?Q?E4lid1g0a/JIsCE2l9rgkVBMSJXDCWaoJME0VjAPy7yD360g8Y1jlhXFffBO?=
 =?us-ascii?Q?n2BPnUazf/V8qeZONrMowpF/X4YfbEcQWxq/+jNOKidFe0sg+w9A3w6UlofJ?=
 =?us-ascii?Q?bIcjXb2WY4QpvGuVp44M6+nVLNCloVC6oKGn24200mNfwFFCETrnGk0NTnbf?=
 =?us-ascii?Q?byf9gGVuf6AgRr0frdKcsW1D4YGCKTuVg4og50vYHYokh2mqoKt+s0lYMfIw?=
 =?us-ascii?Q?c+T6snXRR4134BqPgGIEHPcxtRL4/TLd9Bjv+WmTPvLMEdcf50ogF45VW8Gy?=
 =?us-ascii?Q?PgQy81FegHtzxUhT+djkK+fd+g0Vr04OgZycMgjVBat/5muwSKh9nBC+ohve?=
 =?us-ascii?Q?BMFKzONGuIm0ZnQBO6/XlpUyRO/LD5NVS8J1AZLS68el0wIJE0MPT1EltQfU?=
 =?us-ascii?Q?6XHTai6McFPypavK2Kn+LIrY2fq0qa9ux5yOmHPAz/EgW4QQRRfZbCVj+qaG?=
 =?us-ascii?Q?qS3N/SwOBXgeD5Kl3KrmFhUfhxGr7ehJoPjM2Z5Jh9C1UwxZaiogdVWQlfp5?=
 =?us-ascii?Q?0ZD7TP0VGD/pn3FbvvN9NIK5odT+2mMka2mbzLy6N4aD+/uJFWO9oo3pNkjO?=
 =?us-ascii?Q?sB8VX9NKDjzHAYXyhbw5P9Gn1GJyl7MN4tpn4JH7mthI5Ce/ABNwbA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iHZWSydLIH0ZLnpivQsSG+zm0M6SbUeTbdfe7CACL7B2/Astq8i9qIb/VWnv?=
 =?us-ascii?Q?ugYSAbmxO50lCsX/ROuBehzQCLlIsZKeUqsNEiPGJmKgfjl9G3q0cKLHRjK5?=
 =?us-ascii?Q?7gYwjB7OfvrtY6gWSkwfCwihKfnLjKF5qdSv80kQNc/sfszccOHnL8JcOaDA?=
 =?us-ascii?Q?Q5srvus/qkiaisoLTwojDaU8WDSt34QmoJezkI/pZB+oEZ4j3sJcJnqst82g?=
 =?us-ascii?Q?7xgHtanxPh4OpCJMeTZwFtFsdbUxAk8ZSDQqBEuPLn3OKq0iygp1T+U1fzlR?=
 =?us-ascii?Q?xztFTy2ozRd7AcTk9K+uhevMNLryoZtFJTGE1vGOZyiU8hc3pyUj6YA51CtM?=
 =?us-ascii?Q?ph7eYlXCPJM5RPAYHowTPzI/7phJsSvwDKfTjvIltTYY877nJDPSfJQ3LrZ/?=
 =?us-ascii?Q?GnnFkKV4f32PdfiW28RYlsxR3H6FEcnz37T3Uodj3990GDlJyKDw2AbXOuAt?=
 =?us-ascii?Q?V+lKHFQWsStxy+peerKef6co+1pO0oWmhFCp61rAB73J/Z7HVDvSxsYFWIV/?=
 =?us-ascii?Q?5pL0yxq16Gph+nPPpGjUoE5MfP2uPuFfyfWYx64mq0tWZ4qxQtn1YvmtAaq+?=
 =?us-ascii?Q?9mHvaqtNEn6vGGX97IFiHYnqrHhNDNyR+xMAT11lfKHSveptmeRalBY0c6/y?=
 =?us-ascii?Q?QPTH01bNBpo8wJzv6wmb+xAyjOYlL+07Ih2uT48yWlznncz1pTtspK1bPCWC?=
 =?us-ascii?Q?HOgRJ9y8zMMCKJCpb/QOcSCxBPi0S1WJLpEHbW8++kt2F8IsuOG1vWPhWE9Z?=
 =?us-ascii?Q?0IfjfdZBfK5GzUA9LWrfEAxbbBYzAbA4UvJ9iXhQhz+jlbrp2/kfaKBAzLgz?=
 =?us-ascii?Q?R0KQr3PXfe0nWPox6TDKBedD71S3pYy3f/T0fO+oyq5aXW3Lz5NCeUk0HdEp?=
 =?us-ascii?Q?Qo1C/VafFersDAK1yH+RaWkv0Tiw/qyBzZAZ1IW+lpGVaCXZinxC6gM1fNNP?=
 =?us-ascii?Q?rb6RMM0mp3QmEm82mmzccs6CsDyXCXeP7cZVN3eQCdEl95zlrvH02H4NBdQp?=
 =?us-ascii?Q?J7VPYmvG2yGol1SqvB0/XUYB2EZs2pVbYvKGdvH0OXruC/dhR97Stv49EThg?=
 =?us-ascii?Q?OSdM+oafohln0++G+je90mGcGvbBX+nfbw4c3wUTtWHOpAeaDWCgGykH4dsf?=
 =?us-ascii?Q?4fBxTPEZ2nudKkzBAwDbKBz25DRSSumEcYGHhnpbVPLqc2j2YqibUcCcg1Pl?=
 =?us-ascii?Q?QLAq8ijLf1DKONAOLf5NXpGuzAGC0vTvHNs2o4actgG7kcx4caRRZnBv8e12?=
 =?us-ascii?Q?dJ2lZ4ox4AL+K8Z/6/1RTzhS5RCrUWWlQ/77depO/BuAbY2Tl2emCFy3vXQj?=
 =?us-ascii?Q?G1XaFISTjYaDz+A5duycYSe64MKUF9Guov6+lWEVxLaIYi06LoKcV91tI9MG?=
 =?us-ascii?Q?zfzL1rq0q5lbhVd1MvsCw14C9o0mnG+UFghciPIDv/ZHKvHZe0kTuQT3pGUy?=
 =?us-ascii?Q?x4TTvMEHLZInZjq0moh0tkpmUjfwmF9m3+x7C47Vql5qus+sC/il4OCRY9ub?=
 =?us-ascii?Q?8snJsKC3dKt9UHTlmf6OPWQzHx9CzzckEWymZyhzZq+OgMLYREuTLn0uMXuy?=
 =?us-ascii?Q?Qzuw3fMHXtS65QdjCIqcMKoZumIXgFDkjg09MmjY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de0c962-60ba-4863-b79f-08ddb94c9c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:41:24.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DNzpZq8Zy//MX8gJQjJJC7lEhsknbcF5Lnah9Kp8KnvBW5ZGJPmzfIIZL6aq4IYyL6fNP92lZgXwAnXr06faQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, June 27, 2025 3:35 AM
>=20
> Replace u32 to make it clear. No functional changes.
>=20
> Also simplify the kdoc since the type itself is clear enough.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

