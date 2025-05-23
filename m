Return-Path: <linux-kselftest+bounces-33615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A423AC1DF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97640A25FB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FD8283FF1;
	Fri, 23 May 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB8lgjmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF428369A;
	Fri, 23 May 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986937; cv=fail; b=kOtCo6+hfiD1+DDfOUecWlIJNoJocvXuHpBAYPR/+J0+RfEV49C2rO1iDg1V6jG73n6Hj/kygXJfuDEo4eTD1MZuncrPzc/MYjN0LXT3zRAntl+YG1bZFhDfOSIMSwCedBE1O6mqCBfKOmmGohkzxdw80H5luyM6KUchuhfIrAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986937; c=relaxed/simple;
	bh=FzWPYP44fJc3qgNKdC/oZqjf4DJfJU4SDW8nHCpmGZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ORDsXpnvsmWXjDKPb2sPuNzuZrWnDDd9ubLouJmoQkgzxQ5amPzVPE9My49u9GXtkN+OJqUUSvDc5QVYgHB6EdaObdTqsnmqOrGYnk6Q32tyGjCpWDv0WzLK8rCGy6dJo6MzvxKEIqVop4Kk0zLwQZBeKiIjAof2Phzj2wogB/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB8lgjmF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747986937; x=1779522937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FzWPYP44fJc3qgNKdC/oZqjf4DJfJU4SDW8nHCpmGZs=;
  b=WB8lgjmFvQVGgSF4zEq1+/NB2Kqt5z/9+CvsFuX7izJFOSHCflrxUjtJ
   muwMMvOkPMyt8XyBFrghqEzFrTT4mu61F7ZLX6Wr2CZW2mYmj6p3Hcuyo
   NNRHRQz1AwALwozfjFEMy7DpEQnOyNfgetC7tnNwY+uccsXJrOyOOCaML
   LGigL6g2MrV/qcqtlIcF9HhhvLikovvssCRW/KrTaD6nF2A7Mi4qCc9iL
   sudTLgyAvMSH0d+kb5LwAG42lFC8h2+kLOrSpao7clcW4PXnj2CWLImQx
   Zha3BRYRqAxD4+A1i55QyMYLOVB6zof7k8b9DkLD6IOhH3bKGX1F0HhVl
   g==;
X-CSE-ConnectionGUID: 0xeTENcxR/Ktkkb5uMbdRg==
X-CSE-MsgGUID: ENzgrkYhRZOFZZYe38ZR8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="67450140"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="67450140"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:55:36 -0700
X-CSE-ConnectionGUID: Fj2ys8vnTjWSid5rB4Vgkw==
X-CSE-MsgGUID: nuNH6vpRS/iTo5EbgK1NbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141101812"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:55:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 00:55:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 00:55:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.68) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 00:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGIO7RJqQsoWy7E1homwBj4PV+f5t1UYiVMpzCJMf3pyRQ10QSOHOgxGu8g1CWsgRt8jrySf90/te4PPGcKD9mGOVubR7zbIwSJqRwqF4D22FGgYtXPcfMwgroOAt1v7Mh/b9iRSpo+v3uxHyu0ZCKraE7RSK2eh8JlTTeX9Hh5XrwSZBy9gh8kvkfXkXacksJMLUsEET4IITji7n3SMV8yjaPtUQnM+R9tALnJspqAYymx6+q4azJli/1Ftrp348SK1kM/z5L05qvRhtsfdLQ97NZdgvXFoLlNBGoMbjsuPrOYMP6GpO98jgPnsKkDqkS5G1VodwFq48HgaxDnQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fI8XMob7f2AAsoHpLB9iKnIQIBm6rzCnVUpEcYQTTU=;
 b=K9YTwQBqIOikCAJGwN6rF6mRZ/C6cJ3/fRhfUyw5U0zETEUFBlltINeY8XBada5OFDwj+eXPIAJsT1d2wHTLyDxVtgdT9If5RdX4vdL/MGH8/6Lr3ZHnwApukLf7hJcvrLOOHDXmsnSl84TVSEDf7z8lqhOPDfhn5/itjn2kAc6Eaq9xFoSmzYdYgyHn3aV3nkEfAh4sFFTQ9EYnxdG5lutXodS4dENWsR1T555S6d9snZNfc/fUDBuR5R0XKkFVkSfUuotDQ7n+Z4sNxH9JgThwXG5YDYuJwhdryaXUuRsVHOFNq9COibsz3wlaVcAj7B3iKWmNMmBqn73nUT0x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 07:55:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 07:55:18 +0000
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
Subject: RE: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Thread-Topic: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Thread-Index: AQHbx6QeTkbifu9CFkeHNnpRlXIZnbPf4FyQ
Date: Fri, 23 May 2025 07:55:18 +0000
Message-ID: <BN9PR11MB5276C599F23964E423CCA2738C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4896:EE_
x-ms-office365-filtering-correlation-id: 98247cce-1382-4f18-8ad7-08dd99cf2958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zf+1vl6exp4VBR1lt1UcvVbbDq1kcUnBGFKahuO/s7lHv0g7IfScCnVvc9Yj?=
 =?us-ascii?Q?ogf3z79sII5n9C1dhRLWw/noxmKcz8JuzvO6TIrNS4sq+HYEGySOG27ywSuF?=
 =?us-ascii?Q?WksjOiifgoc3Ae5SN4HePUMQ+rUxppbhvBQ7kbn0VUrVyH64Ml6FD1WMUQPm?=
 =?us-ascii?Q?j9uTapMbZ5a735EaPcWVr+Nz/qFpht5IK/Q7VgFsymdm9KZV7/oGMxW1Sh8S?=
 =?us-ascii?Q?QF+5lKhxYomHiIVgaJtoa9zIinydblY+gPDkQ3dIG7VdGRojf+W+MnQZnwMq?=
 =?us-ascii?Q?twXecm8/sQTPLZuRDCue/8HdsPnFg80UzSFjz/fErH/M2AWrnMfVG+LgWr3w?=
 =?us-ascii?Q?FHL/FDLRwJkB45+eBASJFRfDDvc7qe2p4JaUtyQvmKVFvs6dZl8Li+ZiGiAW?=
 =?us-ascii?Q?0fI5I1g54FUTM91m5LyJIH8eDKq3xjSoTfy9HBTnt5pLQQJZ+dC0OXmYIhZ/?=
 =?us-ascii?Q?P0Ss28Zim8P1GIUHrbUuhl2OROMfeLi1UPaDVX283A4fKZu4Ps/pXDS8T/4U?=
 =?us-ascii?Q?eseCt/dazXHy4Mysz01UZZKHn5cBX0U8JH8GATHjLP65bFMPNsInP1RSmcWh?=
 =?us-ascii?Q?pLqAAPtL1XlVPA+FV5w59MqON5Wsea67VXjL3UWwxxWdemjOQEXcDAM0UF0j?=
 =?us-ascii?Q?G3UvEG2FuDSXwvuWzW8RJMaQriOJZmXZ/NZ/P0PrxBP5q18MfycKRDkT6dHI?=
 =?us-ascii?Q?gph9JcXxIw0it2wbYcfA8BwIKvCFudLFee8VUqm7O5Y1wAw9ZNNffMCHXs2Q?=
 =?us-ascii?Q?pBhjC6gA4KwwuLW7aloKA1DuOdby0ey1rkPxnW14GZc5TjGjiaJnEFh/MvQI?=
 =?us-ascii?Q?XlaWBkZnLxj3ZSAx9l0OqyOHv+t2400+U3taVa9lu20PpGTkpKYhz7Luu9nw?=
 =?us-ascii?Q?j1sREjLAtk2F27ighiLEFEDevXE8GFMqhTlEU6ksPkUVPs83rOiKzg3lHr64?=
 =?us-ascii?Q?0gwY8ce8wlVjFYClVpomovUZUPI3jOqq3nWGFjiG2D+CY1AKSe8cv7/4oOTd?=
 =?us-ascii?Q?v+NnrCxBoHh2EtHA2kNaJLyOJFHVr976PlQz82Ti0Kk97m9uEJunsJcfsra8?=
 =?us-ascii?Q?jEFmX0sypCNMEHV7p+nRR7JPJ7RYmPRNj1qtUmUudWKVO+cXnPuCBOHdpJKp?=
 =?us-ascii?Q?iXlcaP6myXLjTWNN8HuL6GHVZ1PeZMZlneN2VEkW3qbahlT8W/3g3Kya0cOn?=
 =?us-ascii?Q?uwpBlIIfNgOzukk4rTJuDX3DmlklMCBEZAt3b2ZsIMLRjfTQRedV88vO2f6f?=
 =?us-ascii?Q?Q+3sJsfIa1hHdPAXsEJUk+Bdqp3Xw+rZmVberDrDlg54tLBdJ50HUervhuMv?=
 =?us-ascii?Q?dmXo08CtX+G9azOE13KWoc6MaG11xONhGHRUVYIJ2BbgAleza1OUIzSr+jxq?=
 =?us-ascii?Q?a6xR7h8kawoIgbGjjeUA0dWqTLZ5LOwrejR9hAYvi0coHI6TLL50j6tBnBmy?=
 =?us-ascii?Q?FwZZ/5Fd6Dc8OXdRRCn9anQDj3FJdAfRkCnIBWgH56wqWKzkBS9s8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jW7Gdw0v0ZOffYWafauuv4bZQhMzjYOtDBy5+2sBiNwzBOHFZsqdAFIpEqA+?=
 =?us-ascii?Q?DGh5YGSbRs6AyNMBRLkgmoe/rH6RUyAEUAsNPkUljIVpmkvJGxqL1tfv/ySm?=
 =?us-ascii?Q?ipjUQR9nc8UY0L/Ji9m9T01I81ig9wlIBs55yWv7h9Qn34ghMn4qvvC9eihg?=
 =?us-ascii?Q?WnY21H/lNt/dIB3vKd/R3+tUdgNSqt7OUIdX415OJPAILwe8a8TcMJIhK02W?=
 =?us-ascii?Q?evoPQKqxsiTA8QXo0+B/CEiCBhZSbatD1UfHpAsikHDKr0suZSH1Q4Pfrpnc?=
 =?us-ascii?Q?GJOkXnNknm5XNJXFgeFO8tZB63xj6t8EltFs5WxTeIupYYaJ7SNJt5lEFlUd?=
 =?us-ascii?Q?79BKeFYV+wOUy0zg7yA7iCiZq0/g3ZpKswvmpoEMpDyJPxn4G1s4huOzsDgb?=
 =?us-ascii?Q?DmsM1ASA141ZihdwQpI43dRJLkbiyjCa0Plwbjrzg0NM/PWiJFDjxohC91bf?=
 =?us-ascii?Q?/95O0sZGREeSsdMNAQl1Tu6pNMikkkNgBH24b2QCeReo1d3C5CFOw8UDTxhv?=
 =?us-ascii?Q?EQIMCPVQBeep0id6k/Ui2MV+SD2XDwbglqCaDYTc6KX0nuNFS//fRaGw2kcJ?=
 =?us-ascii?Q?s9Tg6V394xliVH0PoigVwQ2pue0CfrT3NIclIxCMKapIFT8DRwVdTLlaWqNG?=
 =?us-ascii?Q?IBkZjzYV0GeqhohT0FexCzC3XgF0G2cqWbPF8YcI7E0yxFahpqYl62FoxXiC?=
 =?us-ascii?Q?6yCur0gpcJtFhq7rBJaxmni/v69E9AcLUIL20gPV0IzxLeSY94E3lYrJWlHW?=
 =?us-ascii?Q?lIGFgtxBToMEOas4GaL0E3H8XG3JN64LMtaOmTpnlv7BcyouEjg6tXACbeGW?=
 =?us-ascii?Q?vE9mGR0Ncv6A76A8OBKREGf2PdvdZkEyRn0RYkJI1o9rJzqTd3JDgaWBxmII?=
 =?us-ascii?Q?svBApzI+ehIKu4hAMAHElwLWVgsJEpIYc6kPixWzehp1p02gJyva6E6EP8dS?=
 =?us-ascii?Q?MPd+O05Mf7buKF7QGL0rA1tsmkwhUCwLwlcnRNIPJMeNrveEwMv/6L+yri/D?=
 =?us-ascii?Q?feeEiDJjGsQDZ26vtt44hqA+ABy4zYlZnBJKlkd6l6O9dfStL0BKh2DikLy/?=
 =?us-ascii?Q?4QJcszIzdct1PAreDwQYi/KyvrMNXRgEAIAitqbJuAoifFWq6FVeagUCkRpu?=
 =?us-ascii?Q?0pAhcFygBtg0CXilnDp4kXvtCSp3C76ARcjRiyKAk99dbsOTKj83yEM4m1eH?=
 =?us-ascii?Q?kl/zl7E76YBhEKBn6TRgWNCDERHykyILo2lFKrkvDkB/P54nDhU/ga4o9suS?=
 =?us-ascii?Q?ariG3I9b2Cp69H1z5s5Sisrhe3/yDY04kLVQuAfzAhLZglCkzjxinBwta0fb?=
 =?us-ascii?Q?xPHK962TherjOMDLfr48IFhMn5H5ectmT8f4LJ1j+5ysAxRovZz5+BiyyBRE?=
 =?us-ascii?Q?DTf5VxGmSAVswEQ5H6PJUDi0YE3iAha/3T8s+ER5/S5NyMQAsx+aujNGRsRn?=
 =?us-ascii?Q?EnhC38S5X4nRuEAX+hCd/S9QcdybzNfGXO86aWAK8bYmnf5v/obQWxu893rG?=
 =?us-ascii?Q?RKAQin6FyOvkZZ4P6TTkTrSIBsS+OMU2TUwhEXBRRBG2IGLucY6IB0CpCtke?=
 =?us-ascii?Q?XhBVdwKhybvtPZCDxdTZttXAZL+gf/KNQ50/hkVv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98247cce-1382-4f18-8ad7-08dd99cf2958
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:55:18.7356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbZPdapkowuwct9B1w/djIgAjPGBujeDBFSqGx4baYW903WjuOGr2A9BUTEdIHVdIpgGYSrsL/Lf5PMBF5CO2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:22 AM
>=20
> +
> +enum iommufd_viommu_flags {
> +	/*
> +	 * The HW does not go through an address translation table but
> reads the
> +	 * physical address space directly: iommufd core should pin the
> physical
> +	 * pages backing the queue memory that's allocated for the HW
> QUEUE, and
> +	 * ensure those physical pages are contiguous in the physical space.
> +	 */
> +	IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA =3D 1 << 0,
> +};

The queue itself doesn't read an address.

What about 'QUEUE_BASE_PA'?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

