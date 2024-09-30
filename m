Return-Path: <linux-kselftest+bounces-18586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78C989C44
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18531C206A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E01714A5;
	Mon, 30 Sep 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CR3FAutm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C317839C;
	Mon, 30 Sep 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683878; cv=fail; b=KlSFs1GcUrJbHd++67gzX2m3ZMEcj3Zx8kpy6mSBBnU/v6EeL4o5B3lUZZ8Fd2akbndhXEAXrLYK6pAsyV1nwB62Ax2hUu113VOQZpcAfMDuQz0vueiEjPanPKza6Dgheb+Jf/YozX5Ehd8o0QiEX9lfRTkr8sAVLA+De9yjyas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683878; c=relaxed/simple;
	bh=l7Ea8DXkp+gP8g5eC3fYd5dHt3QwkfH+k9ao1mGk2tY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ruwe4sBSVUYUz/nEyTYy+WVBsojodyxDfg2u4j/8T4JdUehlPOl2bZsF/o5RFFCZ0JWeLVwvSjmFT8Pt7DW84WAkz4EDbceycgOcB8F+LQtHGr8I1lhdamYnfCJx27QgDjXvibe0JVa7b23Kl3D+cgL/TJuTXlg22fUMunSpAdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CR3FAutm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727683876; x=1759219876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l7Ea8DXkp+gP8g5eC3fYd5dHt3QwkfH+k9ao1mGk2tY=;
  b=CR3FAutmhdVLLSsprPUUQgHt/TVTQprppJ3limFNIRraGQ5aDtRHNJXe
   Ewv4MNUzYqXTD3drTLXvQ3AqVs9U2N8XxJO/I1gocyaGBpX7bw8gi+y+l
   CY8HATv/MvtHxaDhwo/KTQ+/2kQ5e8DwO5TXWPWd4RJqH86VZdz/JIcax
   50QibMnNpFuwnp1iwV+lnleeSp/hWyicm9T6IW4sVPJIJnMekulelHeZF
   G34o+y3mvF2O/kMmPxvuHVHQ/mYJ2Cab/6ounMTx4tzZi/CV7wySHpmXW
   exv5k71/+PgsJ7CZLBcQRhWFBk1KDmynjbeevcA8mVkqQR9XRtkFlxYbX
   Q==;
X-CSE-ConnectionGUID: SyUB4vX4Srewz6Qa8mXI1Q==
X-CSE-MsgGUID: aYjmHX+KQMylghBCckRH8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37432403"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="37432403"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:11:15 -0700
X-CSE-ConnectionGUID: HQVIREjDThqgvnk9Z5UFPw==
X-CSE-MsgGUID: WbhA9vXkTmGwCyGtIVzu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104010497"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 01:11:14 -0700
Received: from ORSMSX603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with ShadowRedundancy id
 15.1.2507.6; Mon, 30 Sep 2024 08:11:14 +0000
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:55:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:55:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UImQU/MixixHvY6qLsE21bt6+ZYdOzngpiuFKuxollj/Whb8R9qkITQ6QfENCW56K2R9VXUtQ+P/itRkoiwibSkydw63gwJcxlIStmLXT5OEcbR8AOk9S8ZR9tquACOh973pJ+A0f9x95+Vi2clvP4x/07WXsCPNzN78TouDcDTHTLxycMRiRcY1JgTF3f+4oN29TcusXVB+ikMKK/nAJWTyPSrkNyNk8YFA/l6u6rHH195vrfwDadD1Zs4Fns0keJZbgg5Cg2Qcuzt5HxkCCrpOi5cKLuCxRxGQjfDvgBwCaFoA8HfK6Uy2KfawoeKGigkdWRi5/wKFqFlsSliQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzYEPvSaYVSYXpUtdPVAbrcIU1i/Ey1zagmaT39xzNY=;
 b=SHjJvwq16DCupKmCFRXWV6GAw5TePVQfifZnspqnaQvmRneiP0fFaXJnJtnDYAIFoylxTHT1rMh8DqXd6107ZClQdP4sAwncLXQhlQoAfTbxW2YtPdTQ13M1KYyrr9U3wjIaHlUC7bpzYn39DKHycplPcuLKQTs2YB7+rfAnlKIlj86P/0Dc8w8PNSYauHSfPlapMErxVM5RE1mQJ6W3b5kV26SdwoywMoOp8QhShWuJD/qGlT0aYhXZIhIDDcqiRdoelnHX1mYr1pILFndcADaIbql8GuOqiH6dGeGxtpnNtYZSCsia08yZrFtLHO6ScBkR6DoDVkOIrZ3S6E1Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 30 Sep
 2024 07:55:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:55:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Thread-Topic: [PATCH v3 3/4] vfio: Add
 VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Thread-Index: AQHbBRYvXMsgiuWObkCSDeonmky/CbJwEWYg
Date: Mon, 30 Sep 2024 07:55:08 +0000
Message-ID: <BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-4-yi.l.liu@intel.com>
In-Reply-To: <20240912131729.14951-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4587:EE_
x-ms-office365-filtering-correlation-id: e8840f62-7a35-4df5-47f1-08dce125342a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lzbl7xHmdSryV8Qf+pKTrYoj8nSrg2LSl/wfkk0gpvv8wzi4rDUVNWAbvXEy?=
 =?us-ascii?Q?QugB0OPx2ZLw3zTLLVBdrcMypu/M/g1Z+lVvSZj5mN2o+pKZTIccCCqPoOSc?=
 =?us-ascii?Q?+Hx0j7HilWnDue3Ez/0dT0qy5yBhzYy1KLj2PqDcUbUI5QWo58wYl8OwB26f?=
 =?us-ascii?Q?KOuSSVdXPizfxEs5vRnjVLz+gXt59VS1ybANpyAi2PzuX7D5jM+gMpt5wVE/?=
 =?us-ascii?Q?/jkH30AdxDgX3ZQqDvJ14heLlb2acK79Sx4pHgpF0o4ZIOOxtrksXffa5l0i?=
 =?us-ascii?Q?aFn38Qe8UB1vEk+H7NEBBxxW1tJ6lhD76EU9QCyRX6jmSlAHU3tcjmdTy1pY?=
 =?us-ascii?Q?B8fck9Qr6/CBiDA7zjBwARS43wylKfZ0tZIUvq8gJy4B41ihcjABIfwuGuQI?=
 =?us-ascii?Q?p2i2vh2dfivpfaK+ndJrHLZzKpmZaTXzn5aGpV5rExP8SZnSr6yei0Q8X2KG?=
 =?us-ascii?Q?SdapImOF3YtjYXoQgtNcDS6GGplssLADfy0/6HmcvKTI8IsjOet4jcMKCbVR?=
 =?us-ascii?Q?chU5cgvw5rTCEnrfySu4ihJKvwUyEiDZtoMf74sxyfgS0Og5CqhT6ArFvDaz?=
 =?us-ascii?Q?6ORtnLFNlmnpUYkAlj9k/N4A5kjssixefCB5kRFokG/iuPEP5MX64NDJOdem?=
 =?us-ascii?Q?GRRe/P+TbK1sPTNlZvt5jBoJFe3Fba2p8zccy5G/RVRhN5bC3WRvurWPSX52?=
 =?us-ascii?Q?yLTQcYwRHbvMXutvN3R6eeUwVl5Gnr2sP8ABz8YwcPfaLniNq8H4TiCXVBQK?=
 =?us-ascii?Q?a3gAF/XpR4DSa5mLnndJDcezEKZbNqkDYLaU7u+ucP6DdWcCVL86SrmxwXqo?=
 =?us-ascii?Q?M0RL3B8kOMFalM63KzTNe060ofLw3PDKYIuDIIo+JR2SP/bNGdNdv+zU17BZ?=
 =?us-ascii?Q?zjchhlxqvU9zghfySRx5WIBmNSxGcrLtEXYMXzrdUoojN1WQqfph3xH8I0pv?=
 =?us-ascii?Q?sF8attZ3Em9djt1jov+ZY9usTfAs2+wdCuxw0THuuDU2mkZdSccj6mjGmT7g?=
 =?us-ascii?Q?A/sAqKFoh3tyZ8ehS+0DM6AyHd6CqtxnPdF9o/yibFUfc0tpUsYdUtsPWAJJ?=
 =?us-ascii?Q?61I4ElHPIE/MnvNGsLlEiv/y5mMrZS3VI/DK7D+KvIjaxdnHddSbIvVq0FY2?=
 =?us-ascii?Q?9lKXEAMAqjFlLqgjAgohMqJ3CwfmTwGOIXItV/5io5hKWGIkLvqUPGw8Eh5V?=
 =?us-ascii?Q?kXovNxUIwNvFDftYJxe2TQFfvbRUzysQHHqtkGvo1Fb7WJRLexRoXIX4r15f?=
 =?us-ascii?Q?DXnCjKToBTaSjEDebOAN5Tj8jw26jLQ3n0VR8y1vkcS5ghfE1H4rj/tFizvX?=
 =?us-ascii?Q?bIJnXOjyG8IkrJdoDnUg8R7xac0cRNWG2ogsUJOGSnFZgJsC80vm8/j5WBSy?=
 =?us-ascii?Q?XnbecTbZaP4x/EjPXA01SEr+dyNlz3fmz39a3IbHHpFIZ4b8Fw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AxfFi3paDsQ5NLgwrrTOyIaLkVUBKhVJdYVmHasH4FBjNvCfHAzyurQU0XJZ?=
 =?us-ascii?Q?YbvId5vmt/+oPi2XwySfRcl4k06dte0GnwsNRK6I/ws4m6RQGtiaDKxfnuan?=
 =?us-ascii?Q?uZaLO4WPE3sDaiZ1FgEM19h8Rcry3Chs5gjrJRWKE+0I7N/9cl9Dw34MzKTO?=
 =?us-ascii?Q?eEK2XENsxQ5ymRLTboROxauzg7mQ8oUCQXB93XMR6ross76T20QNNPsAcjWH?=
 =?us-ascii?Q?Dfi7gTsburIQqJD8Ht+zif8dHQ2hJsP5vf/z5EE7JGNVJry5N8ABYtP2WtWF?=
 =?us-ascii?Q?T6LN3P3G/FnKPX/mp8rU/8qF6V9hSL1TS+BbSgI1pXdUrPsAxcjtA6ziKJXh?=
 =?us-ascii?Q?zlBWwmRmB8HEPe9TvDKeDW+VvAcXGa5Thej4d38tNGAyZlfSUbzQbWzYos4m?=
 =?us-ascii?Q?rjBcLs+RRgKK7H+UiRsmW0e5ezb90BA5eBfYZXghoavETkoTQZMQ0BrEjdol?=
 =?us-ascii?Q?41gbkIr1ooZUfsP/ILwDPY5UENTR2DcyzYuzrRmVmMlqwP2VfVs3o4BuzPZ+?=
 =?us-ascii?Q?X3TJz0H0YsUYsZC5/kVMmfmAnnSXvUsz/GA0dkO5nJl5aB1pbUBhFu4Tt1lw?=
 =?us-ascii?Q?zY//VjfIoaBT2zWYD/VMH5RqufHa783twSoEMgDkuqK7pPWpDksCr9XGQHAW?=
 =?us-ascii?Q?5kewuL1lYMSPweDr07+gHVTVTYiZWhtcKxeTMFK2+ZeS1dXQKMUxs5L1Y1n6?=
 =?us-ascii?Q?m5cqVdKlc1NqV0cvlp/ewx2bgNhjnzd2Lc7nBFn36bqLYkRW0uEQ8TZ4fHl/?=
 =?us-ascii?Q?5ETJEcrZ6pGii8CK2NoP0afFg4todOpeb+3BPljAj7hIIXqr06ATjwg4H16d?=
 =?us-ascii?Q?9aSh4wNFQaUa1S455SFoSZsd1RLhjL880xMf55BqirY1lb5lP36ddVQxoPH8?=
 =?us-ascii?Q?T6/T2H9zSl61DKdS737arsbsqU1tuTjXLyqdVXhZq0/J+0qBl2me/I7jXVr/?=
 =?us-ascii?Q?nLAazhw+/pB+/jLBZ1FdEJjCQvGLU6dd5xFTZC52Z5n79cKGrNZ5E67LLaAR?=
 =?us-ascii?Q?pMuwZIbb0SeYepVhDP8WODbaRXilqh1SkuytkQfZ1UapK29ekZlsuhr2r4ec?=
 =?us-ascii?Q?0TmD9SmPYhGHj8Lr9tIVpGM7/ROZeCcVJUP16Acvi1ZV2/2//q9Jzcjed7Vl?=
 =?us-ascii?Q?/iy4BoL9NgAgdyfh1X9tKbXtVrmHnaMl8ZEBwx4C1kTd7v0dCjlb/YfoBwnJ?=
 =?us-ascii?Q?Q9kqueMVTUp4ZxIXzp+PyTQWCSqPM8ALSdZ2smq0Put5ZCCmgj+NusFmDI7p?=
 =?us-ascii?Q?A2BSTqsWZCcqqXMqlb88ZtHPsPo09Vv0NOaV8iTbYVyh9+GMs0a6BPpJfVez?=
 =?us-ascii?Q?oDUjOc6vUsvUa1nlFpHysArMHuYQgPqx5aMTVX6zt9k/5s18oaE8VTznpwos?=
 =?us-ascii?Q?//zKauOuFmAHfb9IHri6sReE+DoSseajaN9DJoxKitO62GaU7roTj0XZjzSi?=
 =?us-ascii?Q?36eNffXd9pT7eWBNER/pNF3M+C6BNV8hLSqXGCl5AH2gXoIxVdEidP24hNZN?=
 =?us-ascii?Q?DOcs/RQfjFwoPw7HOzq7RZWv5GUYCVRmHkvTD+PDkVcBzqemjKbK0Z7eJi0y?=
 =?us-ascii?Q?hH+8rOE7MRdMzP9ezkBDspakUgMGBa70U2lqfuym?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8840f62-7a35-4df5-47f1-08dce125342a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:55:08.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qufGvN8LwFqbfI9yMrMR/ZhAOER1NOGu2ifdf8yo21MwKOFjvyMXqo0xyBozIx7jU6nJXISaAeKpSZ0dt99KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:17 PM
>=20
> +/*
> + * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE,
> VFIO_BASE + 21,
> + *					      struct
> vfio_device_pasid_attach_iommufd_pt)
> + * @argsz:	User filled size of this data.
> + * @flags:	Must be 0.
> + * @pasid:	The pasid to be attached.
> + * @pt_id:	Input the target id which can represent an ioas or a hwpt
> + *		allocated via iommufd subsystem.
> + *		Output the input ioas id or the attached hwpt id which could
> + *		be the specified hwpt itself or a hwpt automatically created
> + *		for the specified ioas by kernel during the attachment.
> + *
> + * Associate a pasid with an address space within the bound iommufd.
> Undo by
> + * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT or device fd close. This is
> only allowed
> + * on cdev fds.
> + *
> + * If a pasid is currently attached to a valid hwpt, without doing a
> + * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT, a second
> + * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT ioctl passing in another
> hwpt id is
> + * allowed. This action, also known as a hwpt replacement, will replace =
the
> + * pasid's currently attached hwpt with a new hwpt corresponding to the
> given
> + * @pt_id.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_device_pasid_attach_iommufd_pt {
> +	__u32	argsz;
> +	__u32	flags;
> +	__u32	pasid;
> +	__u32	pt_id;
> +};
> +
> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
> VFIO_BASE + 21)

Not sure whether this was discussed before. Does it make sense
to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
by introducing a new pasid field and a new flag bit?

