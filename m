Return-Path: <linux-kselftest+bounces-18575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CA989B5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381FB281F87
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB154C00;
	Mon, 30 Sep 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/4qdxNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1821547DB
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681091; cv=fail; b=FURTg0rbm7pedRwjVpxM/hsyVX658GiLMSlBWpCePDy3FeHoQdkbaYVoKYC8tJlbYcgqP7CH5PVE+0NlNqyFurZ7yuGD+siHxH/1AjHNnaDVxsVy2TZZxfDrOzqJjh9+tzRNWd5wPqTbgIQtZueNd0kKikuU/IC5Yc/S/M7Xguo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681091; c=relaxed/simple;
	bh=/yvL1aFQ6q0WNrutGQ5yBr+t6eI6nBLQeMLM6xQ9hQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJQi19h9ClmLnaHwfw2amDUsn/assfgbOAS1QMzn1OnSPgmrdJLyUWx6kbLSEUMbxipoMtzpuVIXMLS4eNQUgtel6Q0pXigPHu0a/i6MmnGwlTVSOx2/Z/toZmBxfwpmvqgR0aNkoKSyY5HohINYyYp11Fy8KuKovRBt8kE78dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/4qdxNR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727681090; x=1759217090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yvL1aFQ6q0WNrutGQ5yBr+t6eI6nBLQeMLM6xQ9hQU=;
  b=B/4qdxNRop8FOds6I8Uk6QMRe4m80WiRo8NHo56tFWjgWDlBVDS4wlvj
   Xu/cXv0W08Wf93oGV5cXnj3D8aZ9oM40Td2t32RR0FQlIyCH476P9i7F/
   QibJoeWFSUY8PdLmm8txgLIWclfXd6NU5cDbre5L4P7rpe4XNM9FABBZU
   FHRzxQCx9TtepviNe8ObOUvTA1B+NF0RcVJudOjb/VvSZJZjztT0q6DN/
   0MZifqyMuHEC1H1DR+eDedMpiQ21bitOwPfCW8S8vkZ/vZpSU0nyZSVhf
   +xwyUxLPUPJd9gAUOTJ5KuCIbBobNY/Qsxvqw3JTsLhhaR2UC7LoNAccK
   w==;
X-CSE-ConnectionGUID: owz1QmtSTkaRxMX3tSunPA==
X-CSE-MsgGUID: O7WbGrrbSLqBuff+pcYWSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30549863"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="30549863"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:24:48 -0700
X-CSE-ConnectionGUID: /Ecj8ptTTuyDVzMLn1NfJw==
X-CSE-MsgGUID: oq4dbT9CTky9xMDhHYW+8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="110691195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:24:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:24:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:24:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:24:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siY0wvsls75N5XvIK9kjVlF6yU3uLNjqvT1mNXajYsMPvFDQQTk74PS+9uB5cf7FjU27GID0Aq9KuKuuic8q59YPVXGF74oIQG1nbsQ+HxfCvvNvKHo9+3oJcAQpmiVh7wSKaJweNzT4oQd8p3Fmq7hDsLxvTdQzYU1dV+2xgx/77voNh0QAgdi5oy09tuZo+2eHp2qAhEULktaQXKs3CgSTBfm/qYFzglY1kp/C9PcJcSJ/f8L5y6HBvnxoXIzJWYBfZ7VimPbExtMPHniCrBxKlxITppEkcAgdF23mwogK7fX9OybdvLJhpuvsfWIBtIz1w5Ian3P+m5U3dbzlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yvL1aFQ6q0WNrutGQ5yBr+t6eI6nBLQeMLM6xQ9hQU=;
 b=NjvJh/JTKpN/utEa7NSBzBo0u/1q9DNW+LXWBMm50CKORolN8PzFXXehZ/Wa9I02FEfBeddLcdq9uEfYvTzuuUS0mFy7qsgH3dCTiycLXEP3IiQm03wAUVMzmUk8esEu4NziB2FRR8CFBMGbZN506Whx0BlWQ7VLP+EyXBIwA16/u8JRZP+eVpC5TBGM6pv7KNxsixoL5NLRDKVGeAxR+q6KhtOsPCw0js4EHeP+dctPq7HJHfxjJ66CjO4YBLCbseuQR+wIE3HuWEGJ5cFwCpeTmZK1KWyj/IDazoI6B7QTdEcmq6KGqbs4bIw+9v6I5SezUEYsotLwssIs6QLNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:24:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:24:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH 2/3] iommu/vt-d: Make blocked domain support PASID
Thread-Topic: [PATCH 2/3] iommu/vt-d: Make blocked domain support PASID
Thread-Index: AQHbBRS16iBZ8+lbeEmk4dVSG1PtVLJwCWQw
Date: Mon, 30 Sep 2024 07:24:42 +0000
Message-ID: <BN9PR11MB52766DE792D88E33C7BA45878C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130653.11028-1-yi.l.liu@intel.com>
 <20240912130653.11028-3-yi.l.liu@intel.com>
In-Reply-To: <20240912130653.11028-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: d1026483-764e-4540-9760-08dce120f3a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tf6yZMW9ig/n3qCVpuCewbF3IJyqmUYhy/CFGrkFeA3OOJ6kGU5FKKxjVqhC?=
 =?us-ascii?Q?oqHCFNYNhJWbxnwsOnWIPwugDOLE1zHW5FYjpD97YsY5qiYF9+cAaGpginfY?=
 =?us-ascii?Q?EpQFNTp6/vcrKy2jw75lFz+EYfLTjVVT7loDD9P+B0nxdkMqxtRaBrixW9+M?=
 =?us-ascii?Q?Q6n4Z4Svm+4sCGtp3yLjaTUIc2jwk1e+JxaPJqKHPi494ElZSrJFkiZ3mtmr?=
 =?us-ascii?Q?Qk6jj8js0zhcNMMT8GPSLBNuoQIPjUgXzcRnkwH5+xy5p1TOvFvMlXdRHfxJ?=
 =?us-ascii?Q?Qn6NrehAyDr3xQzHecjWWUOI8fx72v1hWN3f/qSciWXrnU6YyzcJOTnuyGa9?=
 =?us-ascii?Q?WtaEReTOgoqoUFDI/rr1thJ93Z5Pi2tH94Cl6nY8tHLpy6xU45PgEYDjVDP5?=
 =?us-ascii?Q?Jn1WAZ4zyNIezmVSnHqjFfgjomWXJqa4K1D7HrDC55Y7AOERPQk9Ir6kBuvD?=
 =?us-ascii?Q?TR5WG6WwntinaHMJd62yd3D9aKPonVNdIo5zh/Gb+05jdkq4AXksoHSPNzs2?=
 =?us-ascii?Q?ZuWq1Q0S+H0BN6HRPjSAI40xKas7C6ZuyZKV0tTtvmy/8NVWuoYJQkd9H1ty?=
 =?us-ascii?Q?2L6/STil2JxAMaz3jY+54uGsaRGwOQj5/UH8Sdg32FhRPQJbGxku0BFSZoU4?=
 =?us-ascii?Q?RTkVTg/c4s9rnAV9FdvWXMP20cYUkxBUz72t0n4CuZUjqIewnbbUgOtjOZib?=
 =?us-ascii?Q?7W6HUMlIxDaZNmAwlAdxyg/7AZkV/MuzVMXbU2r9XWh7MKzglVPKJQnkKHpE?=
 =?us-ascii?Q?mRa1pDnGbS5kJOXq0xmBKygCTYHRBrlBVDyjZPkflEj6MKEP7XQXi0sF5ktr?=
 =?us-ascii?Q?seiUTEO+zWs1LYPMjDlG1VBiy9B2MB1gxfMMn6OyDrTYQ4E2T6W30G1iTkne?=
 =?us-ascii?Q?5Y3fHXOvRGV6/xoqai+TXuRLtF/JEqB4Xhk3w9w9jvM1j72eKUl184UvoFs6?=
 =?us-ascii?Q?OFCk0K4z05ifW1/ShrcJBlUEGj0Kqe2OrZJELe6nI6qpaihMuYybvNQqkIna?=
 =?us-ascii?Q?deKA2AWGTgErP+tkmr8cYlEzaW8Gm26dQoIEyF7EHpo+Tr90pqAsNr81Ctjk?=
 =?us-ascii?Q?+9jbgc0mGl9FKOBdWZSUaY7Y73weRx+glfMNOtyQln/MA3G9W4ZPq5xmZk3E?=
 =?us-ascii?Q?inRZ6P9twzrP/0nV1ZpyiGlc3D6dfdmVxbl2BFZQf3kgF0pqCuqWzGJmCenw?=
 =?us-ascii?Q?ARU7LRVHuA2GZwfkrk4Td08qgC5PlfFxAUbuYMgJX28XXngGBYzshxnbmlK5?=
 =?us-ascii?Q?8NfYSumEa3pLY6mRXLAF6xAz0p9oY8q0HAv4rwd7oyqJcusE+Cd5dK86xV5I?=
 =?us-ascii?Q?YqHbXNFM/hiouoShCggDjk7Fmbr8/9XMSxf1xqarPjEc8UbNbmzA76HVVJBc?=
 =?us-ascii?Q?Y/e3cvuas6YoWEbMU1dU3y8UhBHy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KNiFcnga9HguJKn460TPR9z7bj6+Fr4xX7CXRItM5fO86W5RvyWngtIshO7s?=
 =?us-ascii?Q?3JVk5q0QoAR6N6zaQ8SN6BiiCL+ikK7qYdMFny9FO3d/dv4Xgq9WVdk3Zv6z?=
 =?us-ascii?Q?6xcjwr+Khj5EQtg0SF41He2T9+LVnli+Ej3M684tXUpd3BM/xEPR4/aHpQ82?=
 =?us-ascii?Q?C1+j3gvqlYGLv+4QWRzqjIdSVoTiHvaJ5Vziuu8cF29P9ikY5K6DzVTpl5su?=
 =?us-ascii?Q?cvNFigFRfrQanAXMC2CcKvLLx63jrshC0WnyFnrbMdWVcYANV5BvAJCSwABG?=
 =?us-ascii?Q?EsU0jutlJBX8cG0vloU0FH+sKby6sP0RPzab9Aou0rQPZyNs5QCbqu5DOb23?=
 =?us-ascii?Q?mDUyf3wCOPnOZOR5xUoayJIyKq5qpZL4hctkR+BvdVmQdXZHj3A/ZQpok76+?=
 =?us-ascii?Q?nhgv0uLlN4BFSyR+URVL0Nu9YS7sTAzl+PDMLPTj0X0OacfhasH4iZ+kJP+z?=
 =?us-ascii?Q?4Sp/MxsOI+1x7jdXC1TF0HHBXAAOt66ul3FNXgoXHZlec1CrP7w0Vb+bkOE4?=
 =?us-ascii?Q?RH6ZXOZXk1NfpZN5JAtz6uccpkWuROHvt8o+6wD7OqPWKIaIRH9ipt4T5ny3?=
 =?us-ascii?Q?MF6AcaRt6UZLE9OZiXDgei2R1lQC5dvX4D3KzW3mTdYKudSQsfg2MD7eynEo?=
 =?us-ascii?Q?VwLQqMxjmW8NAdPynmsij0V/zh3MP5ixd/S6x/JfaP+Nai/1m2ZpUwGtDorP?=
 =?us-ascii?Q?PLTEgnS7Q7oFgmDBtwS1ZveHh/+lxFkMD9BzUpUtBLfaHBz+11kpL0WOz7+j?=
 =?us-ascii?Q?alLZqiGIGepxtY3PJudLGVxgFvA81kAQ5jbUAizc2raNZf00/W1GdAKgkxIU?=
 =?us-ascii?Q?MhwuwDM4IQPAigCiv7xBz29jn4DOytjOifn7tR17ctxMYFIkSgmGK0Ka3wSd?=
 =?us-ascii?Q?uDt+Z61rHi2aBms6QCX8wKRDeVQSn5a1Ilxtl4OTuSh0PtAYbl3suVQj3dhx?=
 =?us-ascii?Q?h8qL7QAZNSFw+xmcYjrbyZSXzvD90yMIgQnoroZcxYcotrpR/pmVRsWMLIHR?=
 =?us-ascii?Q?RCKn61U2lHb3nCVKM6aaPv3kLaJffVnHn3xFLbSWD0Kabqre5viCRJkkzy63?=
 =?us-ascii?Q?pQqMCH132DjypqqcLwNMSdfb/73BGj/IM9iwxPGIaNFJEDGpjdwokDWlp2dg?=
 =?us-ascii?Q?qykB0eZMPtjsHW7K8igUtfRlcgVqD5mn6lu5h2Wxnv7u8b/nYLP10R9tPEOb?=
 =?us-ascii?Q?SqOqPqhtFit+iQiUeK5whBzEb/Xn0jWa8/sc/I56OPE89CPjaa2eb7NrozNa?=
 =?us-ascii?Q?E3lVbq23W5m9mmzwOWoz+uRStOt05cuqtfx04784PDW90g5Wzh6kjnhLpkFm?=
 =?us-ascii?Q?smZ2FURnOdlueQNl7I/m651Q4IoSZIHJ61AIzcM4B/+71RDZ6+0LzKQTM4Dl?=
 =?us-ascii?Q?NiiVBPzL02zNx157PHX2I5s+iiXafcXInHWpb+lJtVPp60FrAUXxAceFZeBk?=
 =?us-ascii?Q?qpsqB8b5eqcF5JF0vBbpnHXeOVG/599pqiVpAv1fBk9AqWSfFik1Zb1swvdb?=
 =?us-ascii?Q?Tc/EnVvHWZMhAssd8TFcACuPg5o+4NRfysUfiRN545UUwAIXwEyaSPedJSwt?=
 =?us-ascii?Q?0RTpWS+Y/JWSF8I9h6l4C1bkWvUNKrephbLQwmk5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1026483-764e-4540-9760-08dce120f3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:24:42.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRWMYJDEkibkcjc6MWjzfUt9oXjBWIaMjMS9dXEH6JT5F3c2QFFZskqkT/o9HMq4QQ5/WXETgNc8xpxIwh/4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:07 PM
>=20
> The blocked domain can be extended to park PASID of a device to be the
> DMA blocking state. By this the remove_dev_pasid() op is dropped.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

