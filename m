Return-Path: <linux-kselftest+bounces-18572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBF989B4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB961C206A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7671547C3;
	Mon, 30 Sep 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiKBN1hq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780A15099C
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680856; cv=fail; b=qcJeegS6XLBkyGiOcFbleDm36YIx98H9MOtwbI2rYiBjQf/b+DJKNDZMuv+fN5U209E1EsQ3oklyfKPjU9qCxOQLuO4tm3kUgmlauG7pRTr7wZS9RoBfJRztq2zPdP2d2CFSiGckKcVFIyynFvapsnajG8P891gqVFzGBjHCD1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680856; c=relaxed/simple;
	bh=AluBlXgrN2tAC0Kdb/B5LP8gVMWSIAn0rSDYGTb4RSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOcRs2FHC1hnzsibROBarQHP74DqiEJN4FNxjp+twPhJ230yjG6cWgfO+ByL1tELgYmriB88a/m9ELHM0G77Rq/PukrjF/PnfnZMqGbKcz0q/qjAbDETUfQedTxS98CXgoJUU4jc2+rcgUhR7EcxEYy5wYKmK10FLAJls51bnSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiKBN1hq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727680855; x=1759216855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AluBlXgrN2tAC0Kdb/B5LP8gVMWSIAn0rSDYGTb4RSE=;
  b=DiKBN1hqqFVrkBQ1nJXP9gy+WaXdie8NfdmoNw9VS1lA+rsZA80vDtiO
   oTkk8K3KIgLoSXHXLBs6sSxfJSGQV3pjRYDHvLyM0I/rZdcS9OAI47ddB
   ceNGwFPkeamNCPYbYiMzQBX6KxH2B+WIZsYkVtLfZ9wYJBSfG1oureLFf
   KaduEDE26pyrz2a+bHU+FVNZyDZ0Q/CCE588lZlYBORl2sa01PObfV8Uh
   po7dU9jJNyE9eDZNsBDKwtqp9wkBGJX6Y+uRbLfg03V0DprlVjC2hXI9c
   C0C1DO3iiH+3Zl8bDdo/+uveRhX1l/h2stcHssZdXy+4McYwCG9Q426Bj
   g==;
X-CSE-ConnectionGUID: pmHy2PbPSkic7zlJQF/dMQ==
X-CSE-MsgGUID: rkIrPdZWSpSg06HlUiOZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="49275277"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="49275277"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:20:55 -0700
X-CSE-ConnectionGUID: MryvIjjsTuKdDF3TUQXOFQ==
X-CSE-MsgGUID: NNJ7iSzwQM+DDkK3cHV67w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73076576"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:20:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:20:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:20:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjzg1lrkGMQ7YlTmLqCgnLR+tKLOspPGdIQtjMsEKSpOCQSwl2LPsFEzhJQhPS01Xre1yvBuQHz9naMbsIFbFu2g8QZCD345MiJQPac45Bvf/HkAy5Y0iNuq+t2InyiAN6/wicW4oGUH04jMUYsYmna2OMrGmIznRhenB313iLN5Ra4SdG1fWiExcKRuCuDMDJeB7UGxgnuXOy80ORtqhGNWCNyDqUCctC7685yxpuxGNl3bdXy31PyjkR8eB+GlqFqDUJZVRdHIwp0kZVFeFtljdUQ8c9z7VZbUYsBqJuZFAbjCqrcAPU/8fTDq2xlRIlFyxk9Y9gvMKpEwz5OZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AluBlXgrN2tAC0Kdb/B5LP8gVMWSIAn0rSDYGTb4RSE=;
 b=Jf/l3XvMUPHaXSfMmJlA5bxpmPMiTt7CI8/41fbwIV8xuokLhgqDNE7ns3QwugY0RhczLw9u/BQ7I0yaeDw8rUZoWWrDtM2Pms2WU97eo+PQLQy4/sCEYZwbG0gi7HWV47CQ47/JvuEMQ8Wdw4665T06YP4ruSDUawdJzG3U13w6sI775pSun3QYG0GVuHuiOJkTG2fYPlylyrNr9eTOULPoT6b4bGoJeUpUpLJpB1T44m2O0OoFsngPjXqfdzJ7fLvzc8zIxW3JU7towAwpvWMObhRi57MUfDXcLwXidPuAzrm24wBU1sBOHNSMn5BmSvuZxS4YssPh0p6gyXGdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:20:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:20:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v2 6/6] iommu: Make set_dev_pasid op support domain
 replacement
Thread-Topic: [PATCH v2 6/6] iommu: Make set_dev_pasid op support domain
 replacement
Thread-Index: AQHbBRRd+zUgqv3EHkKf7qboTT3IPbJwCEfg
Date: Mon, 30 Sep 2024 07:20:51 +0000
Message-ID: <BN9PR11MB5276DA9328839D9FEBDA71608C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-7-yi.l.liu@intel.com>
In-Reply-To: <20240912130427.10119-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 612c5da9-5490-4571-b0d7-08dce12069dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UM0BKQI2MxaLAQlAbviuK9KJ0VUWPL2iTB5c1z8eHf66C+p3bf+B3WYSJW7C?=
 =?us-ascii?Q?iRrHp8DRtyYBuJ7zECwe9/t2AOAgdOm4UMMjEvQ+zPim+Kxbn+12vgdObVpX?=
 =?us-ascii?Q?IOTOWFWWAhYPk9Pdh53p6cTwOLrH5Kmmla7JPBYuC6MyHLDN6wODiQxtZmfa?=
 =?us-ascii?Q?w1FWU4FNPONa9WPStkhvLyt3rF9lkeIPL161yy6VNt2xZMAEuvg2i61LlG88?=
 =?us-ascii?Q?K74GkTfH9bgvchLSkp+LHIWKJfZ3J7kxnF6NFhmOwqqwQP7uobzQoVGMgPgw?=
 =?us-ascii?Q?lpksa35plRwzkUfYywZ1b+XCKn70vx4qtrJV8nidpge3Ok+uu700nL/D+eE4?=
 =?us-ascii?Q?FAUCxrsPC+ht+j6Zd7Vlii1/P6BjE6jtxBRxpnRGLWcQDQmqMNoYfTIVLvui?=
 =?us-ascii?Q?ynCHmfR6xFDrEP+JBL1bvviBGPc+vx5fRFRPN9257H/lWkWThDmKqkz/XUwc?=
 =?us-ascii?Q?2FMj2ZukrFOOunTVKynQ9u+piQ975/NnR4eqqSgcjVJW08AChUORObJucDfZ?=
 =?us-ascii?Q?bM2jL/qIyJFrzgpH+IEGd3nWC626HUt+KNQCBTzPpO0NdVA/eOO4NIH5/Jdn?=
 =?us-ascii?Q?wvYFbj4ScJVOvY6E73e9si18wCQnZnRwJ51SZFslWMJ7iDMeaHcew3rccdmX?=
 =?us-ascii?Q?mSkBJIM7QX+vlVgUYuLlP2g9+vz7I9MtczzuDfx3xVNoeGTr0C1nhFw3gAst?=
 =?us-ascii?Q?bOH2HmRoVcfbyT5RCzIMvLmu5XcM+ezcWxBCw2Gs7RX8TpqKXWJX8HkX7hDH?=
 =?us-ascii?Q?mS8JWUYqXzHPG6cd9P2UgdbXBbusPV8CORlAWLDX/YSXvr12mxvDhkVPgZXW?=
 =?us-ascii?Q?c+rTk6m4Zmnic0cri6qjMCQM4RNtwKbXZl/ZvbuRxZvlZW+LimGZbFO7klFv?=
 =?us-ascii?Q?fqV2yOyswx3bgguNQUvVquu30dORIXUWg37nK4y9gieYEOvhC+KiMrZdpv1O?=
 =?us-ascii?Q?u6ENVTdqyhguSAzwFon2ts8mNNvHMyeh0grxlp33GLsfJMuMhp+V9t0TIu7W?=
 =?us-ascii?Q?qq1k6Zp6VsNJQOGyK22H60flUQacr3msyE5aNPL0Nob6djli/07TUAev+xix?=
 =?us-ascii?Q?LQhcilZKTypLE5zEjnp/fF9LMskcl0uC7bgdHKV/fj1D3nRNSIbMXiGtffew?=
 =?us-ascii?Q?MFcibAquH+2S+U31tE8Jwn6NDoiTvOnwxVDv9Nk70uGfvYpV7xFXq8SPBBjx?=
 =?us-ascii?Q?jTv8+wQ9AU5/alMb67TDcjbio7ogRmPyNjL6UZvKaoihGPqoGKdJ13d9zhGw?=
 =?us-ascii?Q?hvRYQj853OCgG64XZbwAmh5A3wKGFYMlUxX0C994954N3j3kKlfndylDoW8l?=
 =?us-ascii?Q?BwtsCW2ZAUnDbsQGyL2zKWpKsnFG3NQUhdG1MkptQFFTyhNM2f69zSqddHsy?=
 =?us-ascii?Q?WB+F2+aK5FapuCYJJo7ol+DKBCyUmHCPWioUcOEdDeJ+F7+Q/Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7JtZbsNPrcNZNoAKV5lcIAWlSKOaH/uygUXV9PI117oGVhMkpV7iqiBxm4l?=
 =?us-ascii?Q?n5KPPHyHdeg+Dm7mPIGdlZDPKSBtL5lTiclerYFJ2wA085D2Uv0BVbp6TRm0?=
 =?us-ascii?Q?oepVXslQLemuZ9QmR0kk88tElz6LwXHS5TlrhnX19VnjGM6gqs5OxDTRT+95?=
 =?us-ascii?Q?XRT4gEF5QvKeLcgnAZ8uL+LAYkiYhd4jAzegvFRJld07zcK3di/qDxOBZ1/V?=
 =?us-ascii?Q?VDdLplaSAHjd5DGc/7OYrch6T6eS5bHbSSXZ1eLBWnfNKaf/WzPcGJNG6GoJ?=
 =?us-ascii?Q?fASrEdIn7YumMi+M5te8s+b2SFmtkh9dqGyaOCHqVyjb4xBUpuVxF1AhlqqW?=
 =?us-ascii?Q?dP+er7fZy27aVUawD1nVTTc0DTmDoHtUkl1W1CW1tNzQB3MCdv0hlgcN2rZu?=
 =?us-ascii?Q?EUjUTweIPgwmqwuMR1oiXyODXRCQjmt69LD9ehGsKZA2+WUdbUYaKghouKNB?=
 =?us-ascii?Q?bdFA1PsvaWdfFCQbINp9ae+Xl2/xFgErgbkCFJdoOu/tUaYqe4wPno2ERZ69?=
 =?us-ascii?Q?Syuct+XvqQwpLwEy9g/tal4U4o574gb5ypqUKwQWRcsX/Gce7IsIhgl3ca8S?=
 =?us-ascii?Q?F8dx++6gCucXLSRcM4IgLBrdspRkGeGF0FXrojpgwwsLDMuQjwwlOQYY0NrP?=
 =?us-ascii?Q?swL4X1TvGIqtTqeP37q+evdxhCM2dFATOpEUTdvfbWDmcuswAZXwLguYZZDK?=
 =?us-ascii?Q?pXlif90WbLB+HwuYdM4787co5zMZmX7V/TeREGvWGbb93aZUFZztq8l+krtF?=
 =?us-ascii?Q?K1VOR78pwWMkB1exh0/noOEBG/emRi/IylnGUGpllxartGlxtLX1LHpCQeo5?=
 =?us-ascii?Q?rz5uyAL1Dk5+yQuq//89m/RSZ46363chnsvqbyRns2zLAlOlvpibcDNQi2Gu?=
 =?us-ascii?Q?FghsEF24PLEqUsRH90JU1RN/03KpDNg4BhVJGHuCSZKdL9JQ1+f09rz47j3N?=
 =?us-ascii?Q?7paatB1/+j3838+z1sqUdtTlo/S4JJvyLFHt3KdB1cruGiEUfNQTgzKhhsC6?=
 =?us-ascii?Q?LoniIIzPmD/c/krwWb2ub2gXU7OrDraWEQ0Gtqr1QI+FalddVTlqldnZ/zIJ?=
 =?us-ascii?Q?e1HVK5rONa/QfFBQS0LfGu5RxJJd80OrdXC2u7nSgGcc7qFQatxSgsnZVKgH?=
 =?us-ascii?Q?sW8j5Ri0lYWo3T+7+pIjUA6od81dVD9RrLfQ0qChXU6gQEnzqlIWEQ881uUK?=
 =?us-ascii?Q?ZLetTdYGBNLUW4tDDV5UKxnjpNlqW75T8itRQrd8RHR69qk1V82qSS+NypEd?=
 =?us-ascii?Q?jege9eIhlmRy7H45s2RwMwokLLIFgR2U2vuIwdF6o0PbRzKlyyOLv4b9MaId?=
 =?us-ascii?Q?bZaGz7sv2iOhy5jg9Lg3b7y1CpxMnPHujVUzp7dxCKBHr3UxI9cnQhg/BWQ8?=
 =?us-ascii?Q?6PQUBQ+JdizWc/klJNMOEYG0TJmYKF6ZZJoyeZljnP0Zu7rEzNnvqk430pP8?=
 =?us-ascii?Q?khVVNO9izkE3XToF7gTudbyCeVUEJdk832x1xYLKEsEZJcrVDKRRE0OD9Jkx?=
 =?us-ascii?Q?sQuiH65qPHJPpxnYc4+8Y/HM+LYBS3p8lEtD5cxx30HuGxX8y/NcW7IMcUW9?=
 =?us-ascii?Q?2591tp8PUZtntHhy7MGyw5gyfRpaui9dzpk3SmeW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 612c5da9-5490-4571-b0d7-08dce12069dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:20:51.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLnHr9NpvgNXR2cJrB/8HZvVX7cyHQXl0+mh2m+yWmeblytcB2BCvat4TF6b7h05kq3/NKVBpWEnZg1f6bjC6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:04 PM
>=20
> The iommu core is going to support domain replacement for pasid, it needs
> to make the set_dev_pasid op support replacing domain and keep the old
> domain config in the failure case.
>=20
> AMD iommu driver does not support domain replacement for pasid yet, so it
> would fail the set_dev_pasid op to keep the old config if the input @old
> is non-NULL.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

