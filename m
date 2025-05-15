Return-Path: <linux-kselftest+bounces-33027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D158AB7D2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD63AD820
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AB289E00;
	Thu, 15 May 2025 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVdaoxa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A761EE00B;
	Thu, 15 May 2025 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288009; cv=fail; b=ekk+5oct3pKmNpuJsev8gjokztr9uWYYRo83aE/x05QijoEE6V4Axsrz9v5XY87C2K54m8+vlik593IwaHSYE2dVsRExYLpwl7R7DyzFH4ngI1OI7MgEtMr06p23QHM3noaP5SIkVDD47cBzb/Kfm5Vtm6NYkKas+Ql5eZHx8VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288009; c=relaxed/simple;
	bh=pzRaaasEmqhAZrLEunzN4C3b+lr7qaKO9uwRcoZWHE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLUwEaKOrjjatXvOPdGtcd/aEh+Y52gynrFkLvHBlaVA8ywYW7Qco3FvGPOxXGihPgPvx3ZJgmwxgMDn/z9h0vFFzJCe3f9iwv6iHZhQ2CFNClwFkpFSP2PRDneKo1kdpN3/Ct/vS4C64EagOX47hBJBPQp4zgyHziyyttNtfGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVdaoxa7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747288008; x=1778824008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pzRaaasEmqhAZrLEunzN4C3b+lr7qaKO9uwRcoZWHE0=;
  b=LVdaoxa7BwfZfecFeAYj1YrdRM2+GSBJ3ltcHAOjAlk17Y8k2iga/nzW
   bs9+24J3tE9wDJehUC8RW5XZHpFDp5EjcigYB58bKmho11NI/I0SWduuy
   RhpbADLUOlDMx2l0kkvwuz6E0g+N2X73HtMkRcr7Bu+Au9ZLhWMZr+gi0
   YbNVrouvbIl8FPaURQ5IetSrh/cbqNaupcempEGPwOYiTx2eBFzC2rLZ2
   dAynI5mIWCS7l/bE6W5/+X3L4Tq95BRZxXn5y5yDKAGfKRy0jo0tU2DQS
   heriGaT2ltrt8KqzhOD/luIk8Sg5oRZivmPIOX8+ISyoYqroWpVEqeefV
   g==;
X-CSE-ConnectionGUID: 0wTmAZGfRqKlexwyViu5og==
X-CSE-MsgGUID: dqJSSD7FRymjU2Zg3QAdAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48458888"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="48458888"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:46:45 -0700
X-CSE-ConnectionGUID: mB5a4RUsSp2Uf8qiXGuWrQ==
X-CSE-MsgGUID: BVrHbKnxTpihT44lCo/NCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="142273542"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:46:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:46:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:46:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQQVPGLHX7TAauwJXCdzT06lvTW/t04NqpV+YqHPrLZDyaiEKcZU8I+v6uqM7Gz1s9/FTKjLVCCprBr9xvY6iHTygeMofzlBqZ0AbUJDU4aHVnZxvRprVVwfNsOClGkfn7Lk4p6/slkPbC4UaDSQa77yXXA1KHVFV2azgM1h+V4dSX16+6FBIGcDErFbq2EYU2BlE5I3I7Xp/7xrQXtx3GxkPxBpTAMTKYA0NE+jfW1jnBob7ZVLuUyzg3X6uk3+Kea/8FDtsRTMaR2fOVpntZW8w/NlOpOoP09PzKq6QH9CTpFZBHXZ6TfMVCFtboAIUPhLhbibo+fkJQlcYNEgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzRaaasEmqhAZrLEunzN4C3b+lr7qaKO9uwRcoZWHE0=;
 b=hGs1qysZkuIfa9GRlFmU0yChQyXPGwW9aWSG5tHgi08juF15VF1Vl+VdNdeaYYGGfBVZj4HHhBd4mQ8AEWE84qMiAOQPTZNn5i4qExoKOJPELl0DHUraCchVFYFC8KCwOBWTRDceaOSMhZuZrCqyJ3G+yNUtuNGvPCRSRvTt9a6af6RTnAULVuuHFzAGPZAw4GgpTG4yf7TPgXDQk+gEFAkeZkbAP9o9TBmP9uMvdXwNoA4Mja7vPQFngf1BI9t3rAwdn1fU4RTsH/EJUd7UfvNH+d68hXtU1qGXTM3/XrV66BOooGyaXoarMVhkvRRdYF2PT0KOV/fJRFMIW2g8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 15 May
 2025 05:46:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:46:29 +0000
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 04/23] iommu: Add iommu_copy_struct_to_user helper
Thread-Topic: [PATCH v4 04/23] iommu: Add iommu_copy_struct_to_user helper
Thread-Index: AQHbwI7xvc3ac6zjL0miPcXjjBchgLPTOCZA
Date: Thu, 15 May 2025 05:46:29 +0000
Message-ID: <BN9PR11MB527628023D0B3B3ADFABA4CA8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <0ad7b2ae8f0d692923dcc9d8fe3feb85017df520.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <0ad7b2ae8f0d692923dcc9d8fe3feb85017df520.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: 85525a6b-4508-4960-952e-08dd9373d737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?op+LHc+FGFF1UlRKpwhSxOa2naT52f/lJEwXU4wxp51/DtPHJ4L5IUnfmb93?=
 =?us-ascii?Q?Dr9F1V2tpo2ZblLmWYXSKi1ibhsaQoeR/0jK9a/N+vRMTuXI/rIYxeQGibAB?=
 =?us-ascii?Q?Oek0G43eLzNfJqpfxYj2bwGP9KSGUIRHucmrvbFQEdgxo2eoJ1E/AEskm7EB?=
 =?us-ascii?Q?j1iLcjgrrQYmpcSZbs+H5du5UL8Dihfs7vNA9GJXIbUVGHI6EqNnLV5sIyYX?=
 =?us-ascii?Q?af9FuYS+1TEK0Cx0aghKW+fwvC6JaFR09Hl46L44Ev6c7UCDwHGTYzWkx4ck?=
 =?us-ascii?Q?Ai+X5jf1O1kcuofd9sKkIQGXXl7pZ+s/nC5oEjOTOqH8+/qJdkTOijtjx4ZD?=
 =?us-ascii?Q?uKBk++KI3o1rRazOnAXe0eaD7ZcRYxH2wNbWbJ4cg5nrp3728ZQo4FOIK5Os?=
 =?us-ascii?Q?rZE/4sa6xUjBzxgfLikYGkJ2pPX/IrXZGs0HuivY4ZXX7/fLvsVktn2UKcZU?=
 =?us-ascii?Q?6xMhLB+j+SJGsi24B+frSxJKnGF6TZ5D24rujK6XMfvBXFRGQUfY0zAJuOZl?=
 =?us-ascii?Q?eErqv6UnPcC7kiXvNaK7VhNgFwMMdB2+B7/U0/6ePUbFcQF2ZfWPFOtGHRZM?=
 =?us-ascii?Q?c9hJ4nf/6CgfRB0v0IWzgl9eT0jTEBHujO1GeLXMvgJVA+8RkTLMf+l+HAVr?=
 =?us-ascii?Q?S1yUM3/dBDY4MgQj/GIfzZYChhY0yzRYMsqoU6E0KhLG5W9GtmdpZ7PgAOoo?=
 =?us-ascii?Q?4F1UxlQpy7AI02bvpkw2Dy3ZeL5tdpjFwxcZRWx6zX8CdjpxtSD8cLfYEIUu?=
 =?us-ascii?Q?ymaSLEMl8xnmqOnmgZMfAfJh5Ca7T33eH330SV2rutDgon9/+XxLAL7QS4Nj?=
 =?us-ascii?Q?7vawVCcSAEN16jJ6Zp0V77w9L101sjuJnq1WqNUwYlUAAoz022lJpz1xDgCt?=
 =?us-ascii?Q?4H6PaPOFY3cRpjZM6xz0OVbZWUp/ihrJHXLAtrWaDYJd2lRgymhAWrgtsyjL?=
 =?us-ascii?Q?qbWtFONDCzXPMZqCqi0b7lMcsd+oB+sswVREFWYB1lHh5Bc5wdpACIJjoKdg?=
 =?us-ascii?Q?x8YlWphIC5TS1/zG483o7vtzTatgC2zii8O3I8UGeyYy1OC6bktUdw1Tko4z?=
 =?us-ascii?Q?99IjPDPg7zkks2Qt62JY1LLXiSVBxCeUvYLIX1U7zDoTAQVJ476RPCfQ4MdP?=
 =?us-ascii?Q?YyczZezF44/kxDvClnJjkaEVGh32TVDcQtXlsXNJb+2EM7X0QAsJoFOmSXBB?=
 =?us-ascii?Q?h3m4EELnA8ynBSMF79ibCfwkQvtFOESwYES3k1R4KLUAHWnJI2G6jnzu37jz?=
 =?us-ascii?Q?Ed1Z4IWmoRSkVg2bv+JDBRbQ59OR35yoKqbxMzKi4kq8QgNu9SgV2QNEv7Ay?=
 =?us-ascii?Q?GjKbokdLE7VSk+/q1UxuakcfPB0BgsPg0/Bv4vl5K4Pe9AxQlEhKDIdxbdQL?=
 =?us-ascii?Q?z6X8+cUSY2n+7EPhpRcNXYzWDFomRl9PqBeHx/5TKtxFiJP3iJbF7ij2hD93?=
 =?us-ascii?Q?wSFHAY8CEx74e0kOiV6P5swIHCjkdi5jwYE/FVl2ZRjgWeLXe2R9mw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rD9qVSKV/A+qXdvM3d4o/xFN6M4fJdJ0Za0PdZyY2UN0fIf5VP+wchfvUQHp?=
 =?us-ascii?Q?KsTYBzmKGyAMH2aw2PaCckayROL1tJkcRDtg4F1ZsqaVUGuFZ5h6pPxqF9n6?=
 =?us-ascii?Q?nUpVLO6AJwnDAuqIQn/KVMaxAnDF7wOFELf7DxIqBz172ablfystcaaK43rR?=
 =?us-ascii?Q?64bxeQb68dOygg55n17xRFqNsWzLwUji0LNxxiIlnGUtcmQf49wPlNDeysNo?=
 =?us-ascii?Q?aLGyCN2g2d+JjY5+5WA7hEBG/fsTV+yq+jZ3ur+HwWvV7cwQ3Mvxh8y4VykN?=
 =?us-ascii?Q?APwVxhPzLif742RZz8oK/JltdTH8Bc7Kseepc6ZYbO5JvfxsU5RpL/i4DQ9A?=
 =?us-ascii?Q?J6iuqazOWfJPQbgrT70tycoEPtUIqfC9IKM7wWEnqVfwDgaA088vw+z1hbD6?=
 =?us-ascii?Q?EcfRqCNWB5sWkinFt+UmAQQWYIAGm/OKl8R+4PtB2proxCGGFISMkOUUdoOG?=
 =?us-ascii?Q?3vNPXvJ9rzxONGQ5JuIQuYD4lXE1xJYamYJFRCDe2CEfb5KrFSxcu+oMzXew?=
 =?us-ascii?Q?zviPoKkS6QVn7PAni22eDIyqJ5DBU29gtg4ETW9Fq0pqrLg8Cu6pvrK2HdPD?=
 =?us-ascii?Q?6n5lmbnBMPd06qGj5Fc1T1x7MjjnoUWnPLRXfEoYO05cInMEPs0pO0zA4LDf?=
 =?us-ascii?Q?rzX/yvVs+GNJs/u9HwSnEqM0jf2WKbUtnYhM2T2Qfha1+X5zdVDHVve3nb0g?=
 =?us-ascii?Q?vdfLJDNgRwJn5nAwIS4VXOR20est5fsd+iPgANdzAdExJfgkc4ickueY5S/6?=
 =?us-ascii?Q?fa5LhTbvx1ORe992ZzUyVQoCnSoGcPgwt5oaaCWFVau1JQFJyJWiQBYrSsnd?=
 =?us-ascii?Q?vabaGq05+pTVsW0iQ6phu1AMZoo/0WT9BUwjdPMTsviqaF0Sd1g2MdLE66Mn?=
 =?us-ascii?Q?5MckpZfmRQq3UCYBLN+VG6LqY9SQfRsglkaQDel0srw+jCHNjTi8v+WVg2X8?=
 =?us-ascii?Q?gKIS9Qu5HNoecGyBCjW6NDVQ+1/ez6pL01rq60K351pYNI7m6/nTm7n/N19D?=
 =?us-ascii?Q?ekEkZ7kgM0Wcz/brUmCBnxGkfArg//OgE2hBwPeMBLvq9FC6PqSvhwJGHbRf?=
 =?us-ascii?Q?wXuDiA9t57ry3mpgJQtezrRu/bsONR1AISTdBAyL6H7Fy7w+XGeoYWNwsWR/?=
 =?us-ascii?Q?wHeEQ/tyJ37iTfVNQirW0om37y/iaAbUPw47PoJpQtOV8ZejbZ8TGXBKxwbz?=
 =?us-ascii?Q?6cgDRCVYErgPbHykNILFP0v6bNjh0RNCnw3eY4qIJoLh70J6HoIyjSwez7IW?=
 =?us-ascii?Q?901f5fIprcoVoLGZuWKzhmljZ2Yo9O+wYq4ltJv6DjR9Cw69X2MdcpClVvWw?=
 =?us-ascii?Q?wH9wzPbixHLJUvtXlqf3l/dTaqg6uttxIXkvlrrm6G/JWLk3gcIKEpRi5NtJ?=
 =?us-ascii?Q?cW2pCncnUWdznTNA9LIp+3mjOq2Wramk80SdQtQOfYDSA3tJCXkX5NZ44M3V?=
 =?us-ascii?Q?nPQVsd81jjcFTTfLhzoRHkMuV5lOljRRnyPj/ZkybvqDehr4xNavdXDn4ZjZ?=
 =?us-ascii?Q?sSiqGsOBDYRNOBQZd13IRd35rdiAVjHQ+0JuC1P3Gu5GDXJ1ouPa/1lLzKPw?=
 =?us-ascii?Q?SxBJq8F/hMqoc5LH0i33Qqhvh0fBgXO5VUDIdpQb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85525a6b-4508-4960-952e-08dd9373d737
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:46:29.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iI2rhAXfR7l5ONFsYFdXBzaZ1zUbCMK5C1NGocn6ymZy1XamxxIdINsW/5aZ3Xo72Ep31X92hdwRu7goE1To4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:02 AM
>=20
> Similar to the iommu_copy_struct_from_user helper receiving data from the
> user space, add an iommu_copy_struct_to_user helper to report output data
> back to the user space data pointer.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

