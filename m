Return-Path: <linux-kselftest+bounces-26832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD395A39283
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF393AA842
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C51B042C;
	Tue, 18 Feb 2025 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7VVzAlW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC11922D4;
	Tue, 18 Feb 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856004; cv=fail; b=IlfpYfD9h1jZQ60w5c17vSTURy1a7geQMi5P9hOvChPzXlwujg/rKjUm/xFbbukp60SP6CHUYWoQk3RNfrMKq3PudYcgLm6zlY+rBeu+/VqUIHsldf3fCJyxECIdrdCSO4H8w4CW8XA1Aq8zYYq8oE5gSu8WYXLFKjBJ1BnqU8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856004; c=relaxed/simple;
	bh=HKNCDKP1vhtr+CWEZeMx0wruXbWxPKCIEaAgl4aTpu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGns7mWud/FaS7Awrf2zOGg8poPw15NSG5tJ7FNtc7LUx6DmpV0UkDTqs0c/YtPAIiRnXkbKpiaTOJv5/au8vFIAIfuGsCtgZKddigWf6OONmxaxSfgKSt5MYqoEVXmcEGBhCM1JsS3Ed2zSJmcG4hXK4rKIVl+SfwBSBw7/+GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7VVzAlW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739856003; x=1771392003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HKNCDKP1vhtr+CWEZeMx0wruXbWxPKCIEaAgl4aTpu8=;
  b=j7VVzAlWwLS5RRKoeCCl/UjqmdmmbjZN2lwNWK/AX52QSufMKiW7nYHZ
   3GoTIxlJbb7e1qEDX3QfSXsQsvjPkxNoXxxnEJi2jPwH2iIQnbt1razKd
   70elui+uXFw2d0clLoyyK48qp1H9Yk2EFvhm4K4uPfGqCHxLL8xcKGfwc
   LapNa2gCZtB1spqA9AWpnm/39mLuWob6X8vGIN1FLrqxVpM9C58/JwGr6
   0ME/jfKC81LlQjAeUlsDz+UJVdHPDkK+KQ3gyLzNhBZmIkZ0p/exztM4F
   pmFy8eBJM/XUZh7+nItCYvpbTkqwuXBe7L4opgAd64TUd2fUK8Flu9jJZ
   w==;
X-CSE-ConnectionGUID: M1toRCH5R3Ss/iQWmAOtSw==
X-CSE-MsgGUID: /vsoxFvKTb+KL7Jj/UBoPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40660949"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="40660949"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:20:02 -0800
X-CSE-ConnectionGUID: j++ODzPHSI+YicApfCzWHw==
X-CSE-MsgGUID: L4UGNWs6RsCCB1D9cNl9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118420242"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 21:20:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 21:20:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 21:20:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:20:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHR8Zzvx19WfAuEz2xds0vjtOm9649ALHmsAvJc754YlBbwE2jWZRi00KIiWTSOodDF24ifeTZUVR4PrLzh1/qgmnCqyyoCsia3T25z29tZB24Fg5yiCGznRyNzN5Ty0E1UJ0WF9L5dJAd9f4Nf+J8UkVjgE/EaEpvbKldgZjNR4zE9P3Ks1xfBdQTIah/w6erzzCD/cNsJIFGo3a/MhLsabyDyKflJUURTywUiPosmjTYLwwx/baDtZjgUqbUorv1Eenm9rZ9LSVYLeo6TSGGB09ZaVGkvM/QRBzpbZ7bn4Y5i18ZfOhA0B3B4Ad/fCNB0TwN8njleByhgFm6yYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKNCDKP1vhtr+CWEZeMx0wruXbWxPKCIEaAgl4aTpu8=;
 b=t4d7gSvnuVo5k8QFkcMbrqoxEnxk0sWaBcEKSERaAW7Ahh7e98zRpMPhaEOUKnu6pGRJ3JEfq6gT7ho1/BId6DVLXPH8YfJSPtAVuPxfawD3Z7u4Rr9Lc1S0CdgyFguo6tntKYAhGbZUrkdPJdaGI79RZZZmsEZyci+mM2G3YT2xiM+UdkT0yMir5wnsMYiY0xIGNn15+wXyHXtSWmk4hGPOpvotoTQkBWYSYBGnMstuocLDLVWWIpHQODK1aJcGs5bq1rRVEmXwGMCjdqm97P2mMlJrVhYMV8f2lziJwjNjCHQbKlF2Lalw25sYgrHd0PPxpjYSYH8Ywon7zQ+XYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 05:19:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:19:58 +0000
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
Subject: RE: [PATCH v6 10/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test
 coverage
Thread-Topic: [PATCH v6 10/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test
 coverage
Thread-Index: AQHbbsB/1huO456TcUSth/gk2I5BSbNMq+Zw
Date: Tue, 18 Feb 2025 05:19:58 +0000
Message-ID: <BN9PR11MB52764BD13290851406179EA38CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <272642fc50cef2799ed3a11244bff382696e690c.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <272642fc50cef2799ed3a11244bff382696e690c.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6142:EE_
x-ms-office365-filtering-correlation-id: b1a8f1c4-2fa6-44ce-e637-08dd4fdbe32f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3WPBFznqQLTbqIgKFjIaP5GbnaKnTtxSH4gEL0TvkbzYhw1/WRQodr/YUKT1?=
 =?us-ascii?Q?iLXHczYaCW7x9L2XaQ7eE5559Vv285Q5hnJUMIJzm4ia7rry7VNHaMXn5I8v?=
 =?us-ascii?Q?pH3npLjtLJnOjGhzl0mATUcqnB/FoHnunLvryBQ8CUOx2JL2+NJZiSKgVT6y?=
 =?us-ascii?Q?ykcR/xxVC43AAJLrwT89Xv1UyV5BJf+U6fxmo8/U6+DrKaxHXBrnforBd3Tf?=
 =?us-ascii?Q?/LKsobHDDsBF/lcEl2Vzu7NLmiE20Bz/Og23l+IrWxKyVovNFyGWF/uMT7qs?=
 =?us-ascii?Q?dYNzgXyEfi2D4XiGwaSVYgRyDR4jC76xVUnYUcl4KC5eiPZx2PYr5rhIXWPf?=
 =?us-ascii?Q?mzf8wyZeP0hxNdGOvoh43tNeL3Pu90rgGbEWE1C69LDKUCs4P8PPjT13TgZB?=
 =?us-ascii?Q?LKUOEA4h+nmpws+zSpeF2m4VFlAWxNWeyOP7Es9cZkHpykBIjY7jKJIAtvBB?=
 =?us-ascii?Q?7uRlCtnfpJeWiZ4OHziASXjwL0o6N0ir6GwNfOkXpDLLpDv8CAUy+B1FQomL?=
 =?us-ascii?Q?Zk8AIpnQr+JclITDOUun8iI2BNr/oUvbIzSv+oL0AdDW3xtgbQs0kdObyshl?=
 =?us-ascii?Q?URuFhAPlWrMN54zOGT4OceuBIKv4ytaYrgnX3YwyJ1MWg8gqj0brr31PDqd4?=
 =?us-ascii?Q?ln3lkVId9wHXGp9uUFcX1J7cN8HgpBwTub0WOQGyq9+nLJY4J8z5K7u/IK+L?=
 =?us-ascii?Q?rmCTNkgZQPVi+2QO6UH9A4Q+QegZuxgDn7+TyO0WNlX0m3DstaEx2nftRWFm?=
 =?us-ascii?Q?K/03IK0iYzhJMhu7hg5NQSPI+tuYls0H4+wgTH5Y5j+JlMi9mn1qoX+71c/C?=
 =?us-ascii?Q?ZlWQYk45B0/Z0GKbfb8CvYfA6QnLHHaKntaRP+BgBvl7chAcTYrWeNzBjrTZ?=
 =?us-ascii?Q?6CbRr3qZW0+vyxh6/UH6AO3S4Gp/5fCcwglSwjQ6j/Cf/HvipT89vz9TsQ6e?=
 =?us-ascii?Q?LAy6VbRBx/QP0WV/hnbL8orrUawc3HvtTfIuODoJQIXBklaAFXufiL2grRrO?=
 =?us-ascii?Q?+tuJjyd9wTf3q+kfb+b5/hpKP1xdzbVHLXwzz9LrYObGr13SvAUj6wZ4wwol?=
 =?us-ascii?Q?cX5A3EBGPmtH3E6q+D/AzYlHhobJUBYYgGpSWd6qW4JPd3K6wsa1Cg23SNNo?=
 =?us-ascii?Q?LfYUiPaD8JLfaTxlr6PIpeVYeEvAknVlaYnrb1MAUII9lu9sJRbIkj8Z9kLw?=
 =?us-ascii?Q?512+0vAOeqN9QPDjaM/XbvlfYcygw9+fbHubzHV51YvzWzrVSzydv4scK/vE?=
 =?us-ascii?Q?d8b6oGKiPfxHQyDpN8PYEuZkwWbMWuYpTtCg4zd1mGj0Pe645KauZ81IVIvZ?=
 =?us-ascii?Q?0UcVlAiTBAzORwmoQ2hOMZDin4lNtBCEobDVEifmVgKpdkEYt3dAOnAf2f3O?=
 =?us-ascii?Q?MtB/qy5PVXm8OW2WZcx2CuLd+BMBeYLXVNL1/Ioq2nNgubtrRkhh1bz5H5XH?=
 =?us-ascii?Q?JgeIx2rvBo9lEEmO7swwIpaj7uC2HndI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5f77jzlvnqiESYEGj7aClgRTxEzRrW8Jlwy8FllJuyKysDbMlGSxkCE34bVb?=
 =?us-ascii?Q?37f5VsbHUFOm7/tauCDlPpfmr+LhWMqWqw5uqjcOhPN5Md0nNwTWLs7rawc3?=
 =?us-ascii?Q?dziB4fnI0rxUpnAZBW588pJFvVMXFYu8de2j4eBcb1PPxUGgLNnzNg9tf03e?=
 =?us-ascii?Q?pBUEgs9tkBrAK+uidmyJvEKeexaqmEt504M1qtwtnrK6Y8Q/dwAeJ/kI9BgI?=
 =?us-ascii?Q?2GEHYf3rk1HkaZa+Cc1lGg+4IUvd6zxsH1LbUuyDmuNycJ7yXzKw9o0K5tiv?=
 =?us-ascii?Q?WWl/Xm2lXl8Mmx6JNplLBlAlaLCASsDzuPtjpXNmOO/7lbxdRimRS49SmdVd?=
 =?us-ascii?Q?ZQ00zJrzB5YxC/Bm2lAyx3wI/eK6LcDnTSw57SQNCCKoM6kwt3R2eYPn6Tez?=
 =?us-ascii?Q?ekzS9FgV6YxsbPtWZAQQAtvKoczzreDj/j83talPwTtiC97TdSPTlw1cjvsl?=
 =?us-ascii?Q?DMIN4mwKoNbQ6xlhxSOcRqiySghYxIhIHlS+1Aiv5reCt+ja8W/RQM4TrCZQ?=
 =?us-ascii?Q?3qbnYX9OyrWir0w1B0GJZEN8zsM5+Fmvv+arVAXC2qbtjUsGwiQAqe5LmqI6?=
 =?us-ascii?Q?xqrqyHryOs6zECZC5nabPs2h2gyK+D4WxwIKwfISXMSRQvujgyZhtEWM2HmQ?=
 =?us-ascii?Q?o5F9TTNYa2IRPBpQAE0ZXtqiQ810nbBfGJ42p3elQm277Go0M1yufkeO/H7N?=
 =?us-ascii?Q?xfGc95eswIRcoi7mDe3Y2RaOJ2R1pbE+Xghe65vVur2BsGpZrB/OWXjF6tM5?=
 =?us-ascii?Q?xgQ4cTJVdX3gDshfW58U7lngLO6GWw74i7tl4hUY4CCTH5Q1ZJZi9S0sF3dL?=
 =?us-ascii?Q?keurZSrLCv4ecVcKPyhzX/jM25I3qCD/3Z0CUJ6TGDJB/Tq/jGq08/3DzVX+?=
 =?us-ascii?Q?PsdqIMGLu7HQebPosxJ6ShyuQUqurdeQ4RNhmsW2aDO3RtC4kI42GRNx9Uyg?=
 =?us-ascii?Q?6KGCtIboxYXG9tGHOs+sk8IXq8tWrzrBxcS3Sn2DSaZ3yc7pet0/4MgMSD3S?=
 =?us-ascii?Q?T1scLnf+ACUhC58vBlO2QNAU0PH06Fwe4Dru2GKhMEWVo+JjmAQ/PAdp+2l+?=
 =?us-ascii?Q?h+v8LDpfMQSGloMQzF3bnPDWUudTWTa0/WQcDi0aoeilQFAo0kkeGIit1kcB?=
 =?us-ascii?Q?uFPzA4QsQ6wGI/jBQcfphkFykSEU7+skotPxfaqcwyHGxgXWoLsvufSPEeGZ?=
 =?us-ascii?Q?2JAQIOQQNfhIS/0/tV0hwR+jCnZ0Es45EeOpnJ13etw77i5zv/e3QE/v29wD?=
 =?us-ascii?Q?L1ucF5Tf8/onliNBVCvNowMfkJ+yr2pPqtqLI5k3i8Z0HPgP6vPssvg3sbsN?=
 =?us-ascii?Q?/zg9dAA9FIpZuoMptLk4i2S3T/NkghyyF6oGiv857wCRq5rnfChhaliOtIG3?=
 =?us-ascii?Q?HxUMIGvmapcM7s2Jel1Q6c0Y8lMUg15Zat6bjuJDS215SFUhCjE9VufpTTTx?=
 =?us-ascii?Q?oDD0E6/EUX/tN12BfLUF40dKB5cxjX2l4FiTufrq93grZ1ywAtHoLQQ7lpap?=
 =?us-ascii?Q?IOMAGNpy4Yi9DDdbjoG25tk/IIk8rtwSZbGyDq7rBNdtc7uSX9kpJmZ/z4GY?=
 =?us-ascii?Q?c8teECk4936O+mkfujZODQOI79Au7BrWJ8J5Zx1i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a8f1c4-2fa6-44ce-e637-08dd4fdbe32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:19:58.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6TBibzltJPzKEBfcwbug5dg18QNw6NArknmvnr/4Tafg16uDaIjTUGHeTHDMkSPxab45Irk2LaiQyB37RcXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
>=20
> Trigger vEVENTs by feeding an idev ID and validating the returned output
> virt_ids whether they equal to the value that was set to the vDEVICE.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

