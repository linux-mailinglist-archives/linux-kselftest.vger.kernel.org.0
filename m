Return-Path: <linux-kselftest+bounces-36285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C2AF1055
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD984A1D9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F10253358;
	Wed,  2 Jul 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvRVzQ/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0223497B;
	Wed,  2 Jul 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449373; cv=fail; b=ccHdP7zLZKX6qxKzlv6OZ7GjT9kjNmLpQnr7dI4Yd8deHgV62qzDG3cG95P3J9Cp/dPSQ3bs//b2B2KLqDjCYMQl/qKvHJhVyVBxtrEWYn8eHBmgIf8tEgUZW0PsUg0u/Zp+v9V1t+XGyN052pFQC9w7rnUtckQh60z0cFNyGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449373; c=relaxed/simple;
	bh=uIa/xNdAn/CHIZkxb4svmmvt39TZYHC+GOwd255Tpxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWwkCyhQLxq18ZTI2vlV/1Mj8bVdfiwHk/CrbsEUsFJc0s5vsZuDpU42I4kRJTyZHvoFQKTqeNnXr2B7Lp+jf76akgP5lXzc6QBEvMbqIOGzBBFCXvO1HvyM8fuJ9VeKo3sREFqbF1P2b1J3DAGgAA0o7jA/AghPwqhYu2epB+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvRVzQ/Y; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449371; x=1782985371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uIa/xNdAn/CHIZkxb4svmmvt39TZYHC+GOwd255Tpxg=;
  b=hvRVzQ/Y5yMwJYfaUgIWJKzl9YaqJOy7RvLYWBUP09Kjuuc8R8bg4Q/I
   ttSbzfliIB7Shlg1AD3LekOHmOnIXNsKEMue9WQDMQF1TnLN1B+14FecJ
   u4E9qdQQ07WH9u9iipsYrI9D7F2DAatMaaik5ih48tfM5bkg0XHUKRa/5
   jai6gJS/pAEznUIJYXBe7wp/oN1MNkAXfBnU4ZyQoOMB5t2WuIZuYZfaw
   cHPsYJtaqOSTM3aPyfJjGlVJ0jdPhlrBZjmVGtu3gkXSOELIOyi+huunU
   YLzfFHtbF7FGESzQLSR64bG8eDWs+FPTfWTp3PRjv6dX0a8avHRjOZCjN
   Q==;
X-CSE-ConnectionGUID: 8rjGyVcnRFyuuWBtUDg3wA==
X-CSE-MsgGUID: uKfnTcQjRSiFRIW/YTcAzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53878638"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53878638"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:42:51 -0700
X-CSE-ConnectionGUID: esTSsJ1xQs22dRGp3j4QDA==
X-CSE-MsgGUID: mtOPgPh/SG6dXzqBfe3bBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159542337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:42:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:42:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:42:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSKhIzEThOogkXb+TXpAgvBasZPUe65fOSfRBiC+HGP3+x0ur50ekSxhrrC647Vh5JfW7c0s7IimT7WT83OR27uspGVI8yJXQsjVHW7vnXRWioeqkCjyJ1Ji+/UQ0dMW21ilsypoAqedI02XxEKdcrSksrK5WHrNBkKbvljxGIELV6kuC9o+d9C72cL2yCOv9tkP6ah8mjj4XnfkofhkWJ5pI17BciSpHy/irfzJPBbqUIvfZiw6T8rewFUw9qweFsFjE0b0EGpPWa4KMKF1rfgQGsTtZFn8vXOFtNOHKnLLnA3Z1EDq5T80t2KutXRqUUdYrnPofJemjbwUGAGC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXni8dTKXuyOhLq0Ih39ZKnpmB4pyGpIgk+QLou9MfU=;
 b=ZGokRRIPF1Cdmr4sBG0jvF3kfYbXr8Avg+YASQ/5ITIsa4QoWPDZ9g/4YIyq70z2P/bN9Sldd5UODdjrdrW9PXqItBNgIroiXvia8QoSAZiNOeaXyDBvpI6QrhVCs/eg3A1pfQwodktcJKjLceFzdzf6H8eFA8+7Ux+P3WZ/CwOFHNc8uzQY3i4+7kNAAuHxwNkaIRShtVYDpP2Mzud5gZZPdp9vYDc6lgxRsLqkEkbV7hlDUBMjjd4uMim2pFtwy+nhzNVInBsQ+1MT5yneC+JdN3i+0a2fawygX09hKUam23GzrjJ2dkxP9SkzApbOwEZjsItxpwYOby6ztSwGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 09:42:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:42:44 +0000
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
Subject: RE: [PATCH v7 09/28] iommufd/access: Add internal APIs for HW queue
 to use
Thread-Topic: [PATCH v7 09/28] iommufd/access: Add internal APIs for HW queue
 to use
Thread-Index: AQHb5tGH5FP4hOzu902d7cqslxb+drQenZSA
Date: Wed, 2 Jul 2025 09:42:44 +0000
Message-ID: <BN9PR11MB5276A03B8E3EFADF4F80E8278C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <77c6f6ddbcb32c83487d0ee58993726bb92671ed.1750966133.git.nicolinc@nvidia.com>
In-Reply-To: <77c6f6ddbcb32c83487d0ee58993726bb92671ed.1750966133.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: 10061145-5027-4444-146b-08ddb94ccbd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1j0h7iL/wC7CVP4erg1m92UWS6qoTGwaIFKzX/KxZaSiN1KYKmS6fI15c1ax?=
 =?us-ascii?Q?4cb3bhC+/FcNL3CVseEqQi0hrc0/EVD6map3XIIeG54O81WyYhhhpWovDhQC?=
 =?us-ascii?Q?x5EUvdgEA6gurPD50X/PPeGJMtBh+A1VljBPzWl7uLyC5eKVbzcl/i0yqJib?=
 =?us-ascii?Q?5d3U/zPJFFKzYYGLANPhHS9o4LYIW001P0WEVq/Qrd0mxvBNOyiW4nHPowAg?=
 =?us-ascii?Q?F2XYsT+yzHaBzALKs4Lm85MWcCoeIDf0tZT9qbWOeJeVI44PLOQ1BU+t44O9?=
 =?us-ascii?Q?4g9b0qyFsAhiXx/d35HTpOpfKgelZZoLZcTlz+p3yBl7eEr2eWk4YXmH4xuY?=
 =?us-ascii?Q?5YPJjqeu46ixqfPrKCRB3rzo9LU7UoBenFj61X/ZvyuGwZ6zuU/ld1Vxck4s?=
 =?us-ascii?Q?otspUDmba901tlgDbYosP6SLCzdE7icUTY1oNy3pCXPvVRwkC8r2GIpQ0pLu?=
 =?us-ascii?Q?a693QkFxLimxXccL8gw8T2GwXUTGyeyN/iTzUnA3UKaSe8LwgqNmsaOEc6UU?=
 =?us-ascii?Q?l5WSKDwquC8sixBLsy8P4XMyKOf3LjLescCldhz2jMuRo4glVJaSs5WzmsZ0?=
 =?us-ascii?Q?dD9HpNpf8nRo+OEyyqiDHuKINikobgp3AMq+P/qO+0EwgcMFIzlAFTdOv/e6?=
 =?us-ascii?Q?qDCJCKhaXV1J1XdrOJSGUyTdjqtAanqHNW41hc6iXi8mtOVJtakBYR9H/vFa?=
 =?us-ascii?Q?VYbaNbWS+zc4pCnjgnaRPeJJL/cv3U0gff3ZApa1CCH4Hx3P8gJtu4O0240f?=
 =?us-ascii?Q?CvhIrtPCFTIC0LNoXhe8sWL5E6gRcVEBpgXFbl0yNZGRgv6lf9Kebz9FEcZM?=
 =?us-ascii?Q?VXilO5fW10hdD9N38/wdCdxp1BMQGnfmsFrjtKgW+KcKGLKZIow/APnrdQ9I?=
 =?us-ascii?Q?MyVrgDxOHJIogZfgq3TEBcZTHNTGnIT/h49rfVCld57JMkgLqAtUDPKA+5D8?=
 =?us-ascii?Q?kAyUSem+3hJWTeNruK+D8km1fNb9e/ZvlGXY9Q1GT2pXZhlVohFX67lAVkvI?=
 =?us-ascii?Q?kPXJiL0n8KQtb/MQBjxZjz6vo3X2WxzxmpTIeOs/aMcejdXEhC2GHMQKygrY?=
 =?us-ascii?Q?pBDYuYoPcEbIXEab52MfkKHoAvfZM0A5UywuYnbP//KZqCrn18Ys3Y3R1ziV?=
 =?us-ascii?Q?gMAENNVC07atAGQu13cWWdvCDUPy1TaLfjTWbzKMdVTGCUEgCpP12SH18cw5?=
 =?us-ascii?Q?8LqP7P56N5Xvzu3vS2MMzVhm6Hvjy9Lb8Je4mcu0LY8gED3e/pFMLVa23HkZ?=
 =?us-ascii?Q?/BqP97nLmLPUr/OQ9UIh2nZyczYjnb496K7YgEtjgYSORi4CyjGrwYOSTr0I?=
 =?us-ascii?Q?IxD0lth7T3bPy18Jp/j23RgvHE4P/WTi/zfBwdR9LUD4BX9pSxePovRAeMAe?=
 =?us-ascii?Q?dM9i6Rjm/1v9/xDancBEeSO+Q9kvWW+h062MKtIY9eR8o/K8awv3YVw2skD+?=
 =?us-ascii?Q?vVlI8rYgoTUYupjeMXLfx55clyodgHceMr/6rl/u4HsQrKEE7x3Qa8aPZchV?=
 =?us-ascii?Q?HkGN6oLhllxUIs4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zox6XppD5Z7mASrDUNV5CEg3O1QHzFZhPx7cKuSpfDefzUUKgkobBQW6clD0?=
 =?us-ascii?Q?O9uuEoqO44QQec3S8FT84zNJLCShyJCaVtyR1EI9iebR+I2UNikkJ/jJ10f2?=
 =?us-ascii?Q?s72F8EYfDNLY1w4JX3E6MzB8/W8IYiaCXCZIGQ17tmMAOzjSX03b7+TkjcGa?=
 =?us-ascii?Q?7Pz4/yfXqHg9e2ZDjFe8pV3geoClfvuB+ii/PgYgoSd8Zs3cC6CCrim6YDmy?=
 =?us-ascii?Q?FbXJIfqwSiwuXS4Jvdo1ZFbbLIgAJzKMLQGmsEn95PTLy7x8Ppz9gJQ5E+Z5?=
 =?us-ascii?Q?YOjQcJFea81Lv1J5XY96kbbF8tlkDwBw43wfSD0V3ZFmYC9SCf5jjAZSGhDh?=
 =?us-ascii?Q?2lPP8Fb4RmtrzTd94g3EUtzhfwcZDQwiqNZXJ/KPijPfzRERpME++Kyqq2Ba?=
 =?us-ascii?Q?YiwnwyMLKEhzeqZYH6CVzYp0HEsqkOLTb96v9DyshccxwEKqzaLSiO/jWLSd?=
 =?us-ascii?Q?iAwFLcNH1VmEjPwKizZwkyWqNmUAkFgeREsTgRaotKKLmwdFQ7RM2QQ7yvx/?=
 =?us-ascii?Q?E5UxDB4vspjT130Y8b6le34Rdy/lkkLa8kpO2TQ2EDqpgH8AZFgHV6YiT3Yy?=
 =?us-ascii?Q?er0fquho0ANHs1jhVzwF08LInyFLE9ySfZXAziWdY0/xebEIaWh0VfSvfBTr?=
 =?us-ascii?Q?+R3iZT16mC6b9PY2eiI7GrAumZXan211SLqC5kGym7+gAYjfVEquSCAS4zxI?=
 =?us-ascii?Q?Dgr7WhSLbuPf5BiNpiWN4nfa/X5qh6DWKbAeupTWWZCrIBXtLXSRHAUFB0WT?=
 =?us-ascii?Q?ZMLJCJjMLmSPPBGoXHPvdjQ4jTTxg2qccsRb6LCXNqVZhNjbHjXJi2myL3pH?=
 =?us-ascii?Q?tGNQ7fWy8IoH4hSkoVCJyOG2hlakNCHRXRpncCI4GNdKAUPi9LDgDOc/K0j7?=
 =?us-ascii?Q?gU3EbZquBXnEnaNHu6LViv4REmxdyK3oFW8oG1ed7YsCAezSB8apLjiSSFkI?=
 =?us-ascii?Q?9wQuHgpPIQlvUVxXuWno3NDP8oQ9lJtZilI9Lj/2lnA4tTD7U+5AVeKmObjc?=
 =?us-ascii?Q?ti0h8FrkiQnZdpT/90HjVgWnEZAqgUYJhRY5GNGl3a928aljBg/WEukOsQZo?=
 =?us-ascii?Q?SZLuUTr+Ok+7TXLaMO2VfdUiyMul7ipTUCL1G1Q+0wrys35IOG87SXSknGEE?=
 =?us-ascii?Q?eP0hiucpu5N13QAfrwtp0rESRMfVek5cEwLGdAZxnwLdHG0vTrl/viwgWnE7?=
 =?us-ascii?Q?UGhUfQdJbQTFXvTPnmX0zfqj4v0dXJHvc/bM48okKrbvP68b7PtbQRnxXw+v?=
 =?us-ascii?Q?1NFzDahptn/ZJ9vl3E76eUysXGqw507tA9KepgUTKCAJri9C+C0LVgjmlVC5?=
 =?us-ascii?Q?G4TWQVJ91q+bTxwVD56NDwTPtRXyR90mzCDCIjqOUqUCbx6GaBpOie0YCzqo?=
 =?us-ascii?Q?DR2GcqK7eKLdF0mB9KaM/RTCIBSg/QjW1pAFpuDrElg35o77uoPb20wnuT2A?=
 =?us-ascii?Q?NtMi65wtvWteiu3Mj4IlT44ZwomU9zyn+r+itV4oqMQWYOaLfhd1H7oHjSWY?=
 =?us-ascii?Q?ZIOVd5JhT6QsuevtxEwvUBMdGKNe8P8ffei8HZZXO7AQB3tTw/AJp2QIAmxW?=
 =?us-ascii?Q?tBzRh1if73Kxy2IjqRIv3lcSHmLd79NZV6OMu49q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10061145-5027-4444-146b-08ddb94ccbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:42:44.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t40Z7oWGW2adaGknmRVPYFBh9Xj6WToh4/LMzuonJROvJo1RAuPG6i8/R5cRKA06aRdzv0h/qSFdzevXIhCpvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, June 27, 2025 3:35 AM
>=20
> The new HW queue object, as an internal iommufd object, wants to reuse
> the
> struct iommufd_access to pin some iova range in the iopt.
>=20
> However, an access generally takes the refcount of an ictx. So, in such a=
n
> internal case, a deadlock could happen when the release of the ictx has t=
o
> wait for the release of the access first when releasing a hw_queue object=
,
> which could wait for the release of the ictx that is refcounted:
>     ictx --releases--> hw_queue --releases--> access
>       ^                                         |
>       |_________________releases________________v
>=20
> To address this, add a set of lightweight internal APIs to unlink the ict=
x
> and the access, i.e. no ictx refcounting by the access:
>     ictx --releases--> hw_queue --releases--> access
>=20
> Then, there's no point in setting the access->ictx. So simply define !ict=
x
> as an flag for an internal use and add an inline helper.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

