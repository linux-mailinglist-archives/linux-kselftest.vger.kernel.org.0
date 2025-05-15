Return-Path: <linux-kselftest+bounces-33028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE76AB7D3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2664E095F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423F29550B;
	Thu, 15 May 2025 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kf71kUJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC179293B6F;
	Thu, 15 May 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288106; cv=fail; b=hPfmL7a/DP0FqEAoaxYzkB8XAPF2h8K6JHalKlfzuMVYfSRm2wh5l5e6Zgv19cyaprzCZ3kx9XML1fU7yFcYsBh4OO9m6x7FCcBRgQdivo1snrvXsLQdJpFyfgUwhSNgfwexzfWlN2ZvLY1Vk+CP8CCZmJHTljY+YqeYosv2RD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288106; c=relaxed/simple;
	bh=k3JX5uo+Pw8rh6rwullWKVPVhx9tNpN22qaiI40JXpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+USq7u3S5hExlpxn+TiWpvdc0pVXiN/E8TsOvjDp3AuZN25XNhFeUSU4YuVCVmsg4Rphf+5PvWqK/n/opJANJkMr6eLjF5qNPUQAexa9HCg09Xym0JYpEhxE2JwtAX98usQECQWgZIOYzOwf/pp82V5pF2IFbLZquY77RYmD+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kf71kUJ7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747288105; x=1778824105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k3JX5uo+Pw8rh6rwullWKVPVhx9tNpN22qaiI40JXpY=;
  b=kf71kUJ7leFDNWvAAbVaZLwcenVJqT2dkgrI3/O4aBGsfqP2lEYKPoj0
   XvI8+3Z4wIfGEc+thyVOfOLBUgjREjln7RPqyhkgVXOmHmhJZs+Kq9p0d
   4cbLghyBHY4koqTlqtXkknJpyiP9mYNIKm07/WVd6StEjlBODJRrICDpT
   mdLDwm5fBkhJSIw8NbeUFKHiQ8ISnf2+EY6UHQ+nfjNsUiyXUOA1V8BZ1
   jj7Ne9R9XwOd8nTHfgWtZFDgRGzMSMP+2kVFrSXkVR4RRq+Ntkg21MDhl
   V4v5qblM5fVO20DTV6B2g2/mH2XxcQzqWSfvwGHohMId5jNPUJjWsRuD+
   w==;
X-CSE-ConnectionGUID: Y+aLRJGMRbWe808j3KCFAQ==
X-CSE-MsgGUID: +0GJStNAS8aAeTpfapwiTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59438501"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="59438501"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:48:24 -0700
X-CSE-ConnectionGUID: 9x2jGLJuQyOXchEAG3SeBw==
X-CSE-MsgGUID: MXxbi9G7T8WIpf333yV/3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143146446"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:48:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:48:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:48:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXtRI4DtorxsCvaNUnbfcCvu2rOkDBiQdw+PrDZDTdkEaGHkPgFfHizp/jVuQzK8N1tbJXXi/2S3jiv72UsvtnHJT4yJ30VG1yl0aeHBDgwQNNz6JzFRidgV/DA3vzugXE1xypa72T5YWutThSNxH8vc4sBW7hy54oNAeEkHJU+CApq+K/q+ffFk+PSV85gCVBkbxF75L7LeHj+byqvYaRL+i/KmBlbVszqwiyzRFI3nPfbCk9xWWtgWrtyyNeUmwx/ByoysgTfOVPcUe+qudlnb9/nBRO0HNimenipMNJxDJwr/1N0mNXOjhK09bwIDOjisdX16AjQFIM/pXCQQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3JX5uo+Pw8rh6rwullWKVPVhx9tNpN22qaiI40JXpY=;
 b=RWF9HVkVvwbJ8PogScH5egfoHABKxAA8kkk59RacgMT05A5fzd8VM2RIA8rNU2ZuqFCGDNP2nDi7dhNpGgAvTYxVazIMH0+42CNOaNg4eA4K92fnRlEgwaCiQN7KYIk8agWYPhxvzreVpl3/aqeAQ3n5w1rw9rV44dqVeLt/lelBwR7C1SluU9csTNCNoYNLd9X2Ine2d19IwD6uNb4UFph/p3NbbMa+Gmd/pVf/qlaRXc0FwVDFVyshCxFHgrtzB4/cJ/D00OAkXGhpV4tq5amARdroElZSDwHQr0TFMEWTdJlQiC8pwDLnzedXVVTHanAAp2rebi4q+z8DjRzkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 15 May
 2025 05:48:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:48:19 +0000
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
Subject: RE: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Thread-Topic: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Thread-Index: AQHbwI73mchcCcHD/EiE30+T28ZEWrPTOLNA
Date: Thu, 15 May 2025 05:48:19 +0000
Message-ID: <BN9PR11MB5276CF6D8C18EB2F3BA779918C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: ba6e276a-5c5e-466f-54b2-08dd93741873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5mXrGd+tEpjg1zIAzID575AJO9xaYeQEvIDTUgIGxpkkLFeMhVE0VexzOSfD?=
 =?us-ascii?Q?FCyN6XrPoAILfTCW/xpHGmHIEJ12c2Cz+00AdagVEmFHAzrpZaFapPyfcwUX?=
 =?us-ascii?Q?PUr+TeMhSh9/j0Ao4rjn+PV9fNkIJtoWRwqMLj9T0UftTiEmRebDItNhhKW4?=
 =?us-ascii?Q?fyK7XFEHN8NbzTDRy4AaHJ/CC1hkG2+hHTrcgCd9M6rGX/QuHFsVF3wh8x90?=
 =?us-ascii?Q?GDMm9pelBM/LzQZvsQct0d2ouavASQsLoBFXjKbtsaldcxiSp5p0QzqhiUZB?=
 =?us-ascii?Q?7+JmZ5QBNvTNOCPLvhhYcgj9pRMtUt/rFEKFeHAfYRO2q08qhuncoM+tGGgN?=
 =?us-ascii?Q?CkcciIkG9wBbD+SQNFCNjXJiznbKiXhPDzyX0gjKpM5sUGf8cXKFuZk6u7sC?=
 =?us-ascii?Q?UGlBMm27bR9oPAteqpOaErvRbapbJupmcjifg/3ATuB49kDcxg+DgnfA/AMD?=
 =?us-ascii?Q?htOd3Q4KJqQCNiuXzd5HN2MO5IurETSjL7jyKuFh4of49iqXYXKUD7BE3zsA?=
 =?us-ascii?Q?rTPOAHF8RS7/2YhSIFYBVxgdIS8cAq4btMwlD6XSiD5/8Kux99CExG1rQxVg?=
 =?us-ascii?Q?Khcufk+qFqn42JY93G2qVl8eLDiM1JGWFFcQ0GqDnCWn5YYngP4SVTU7/9rk?=
 =?us-ascii?Q?biNbs6/SGKWKmQfve+kJeGqE5JLcw0MqpOd3682ARTRZFD/RgbVsdCP/Q+y1?=
 =?us-ascii?Q?DhKtfn6c62MpUAxNuUZVUNxALRpzxEB9wKrzb7jsBR0HHAFgcBmw/OcZ8DEp?=
 =?us-ascii?Q?qthi1tyxF3/T//yi9n5UZQTsatAasi9TMYUhKkNZLANMOtrucCQI1hJjAt8H?=
 =?us-ascii?Q?U5UdX8G1h1e+VF3o+jk10G+HBFgMVrD2Jdo0oKLLXtid0Zm+8c6wZdBDaWDx?=
 =?us-ascii?Q?8Md8guE1vYka30lGqgKlDKEjGg8yg5toy/+sYf2EIgdBqvr+GKDuvSezAQvF?=
 =?us-ascii?Q?cylt/vz7+hRus7CCce8PdQfKlxG2VIFa2juEr+lvHZsRZbMR+171+0Y+39Lj?=
 =?us-ascii?Q?BjM3KJhlf3+erdTr2wGtIO4ye1G/18ysWrw5mI3ryDB32nxuAhkovfdJDA6v?=
 =?us-ascii?Q?g+d+UfsJpY0dJGaQ8M1GtFTHMzFOlNB7HhOMdoDl3GC/1QKG2g2XwDGuEgrl?=
 =?us-ascii?Q?TjSO+KpayYZC5u1to64eJXC/tHX+YdrlqiGKNjEAsboKIV1BfxcNMnWpSkpC?=
 =?us-ascii?Q?FkS+x68IguMRXdSSY+0oA09hxDq1xXLW0S0O/u66qMY38H7SLhnEs9GsDirP?=
 =?us-ascii?Q?l2ayo6bd2H9Tnew35lSx5byZ9xAakhrpldYoFW4gGnQ1yJmBp3hI3Wb7rWta?=
 =?us-ascii?Q?78Y0hanWqZfpUj+RS3uimgz3VpflJPRYKscFmzwsjszNk3oKDgQCjSSuhqVm?=
 =?us-ascii?Q?340tvlUrWlja20bcnkUtQ84rramcTEG/O/s7NzVKuGFf+w96ZQP2hO+Lmtlc?=
 =?us-ascii?Q?E4gr36a/UolAheXNMNDzIbzlCHmExqqWWJlaYw7MDKXoP8M1blLkAcrBtxYU?=
 =?us-ascii?Q?zYXcItqq9P1diX0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mgWN2jIh7vh1EyDmTY3EjWnl674rSn6DDoNauBRiQINpggMZRbReLzrpRNeP?=
 =?us-ascii?Q?TFHD7S9DKdNr3Fh6ApUKAvkvYRE2w6qDznm6YHncEfYfrwRVuTSY9g2xpmox?=
 =?us-ascii?Q?/TyCgr3xtCuzjsfQ2s0f69qPxRDVq0VULSXl2TKmjL+aFFLk1ZIPKrbylXTr?=
 =?us-ascii?Q?AWcRXiXXNDC89fX5Q5dqgwgi/eQ5mBXATtDVJC7Dz0RVU9E2j+fXfCOsbBp3?=
 =?us-ascii?Q?epkR6cZ1kj727lvvHGDnU/92Q8iOQO37K84FdP0YId2pKiOCnNSm4vHQZ45b?=
 =?us-ascii?Q?+FYuw9z3gKunhFRejDgwWICaFRlUb8oTJGSkeBCBpnKM4gwuzMJq7q4v1w7o?=
 =?us-ascii?Q?4xXVU3O0z7ihIyX27hCRhaaADRJSpHDEgMEeM5keoEhVb8Mg9zmYkCJRzs+c?=
 =?us-ascii?Q?jP3OMHWTq7BUYkyMXJNQr4AZ3KnP2oSC0NINliX87rie85aNktbq+H8uKclK?=
 =?us-ascii?Q?SXy7Cmp3a4ZUzrU/vzpczm+JOEwHJpPcroFwOQRpHwFeTOM1+17AZDjNlrLx?=
 =?us-ascii?Q?PdyniputaEJYBKtWiDULwQBQ1CsF587IHm9NkbW9o7XnQJDCEsU5Lt7YcXqt?=
 =?us-ascii?Q?vwo84Jc8GRjNxbkhl7JpDyMV4n8Jbjokni1FagQXCrviruZiTptlMOu6xu36?=
 =?us-ascii?Q?Bw+4CwyofLE/uVsmzfbvz1VAGqEiARolK9E4qwhC9VkiA7kh3uvgCnjDVe9f?=
 =?us-ascii?Q?DRe2MgxGCbuKomeuLVIUiEWPWJU7IOjdr4lXki87h7/XkLCbrs76EMoNJGQj?=
 =?us-ascii?Q?IzT/x5vAab9ia4+0vKBgqp7i0GD5vAhzsmWIL7y1hiZkuRFKXuHYxCH9rXKS?=
 =?us-ascii?Q?fJrsqnGTtpBPotvL+yqzemDWcqtoerKGe9fHY30KdWTgGGTLs180Y3DJRwr9?=
 =?us-ascii?Q?CxecqZh2Jbt7wGZSi4sDnuC/4NNH9l9Psj19dldKHLdQi84R35ODWd3JCESL?=
 =?us-ascii?Q?ir9zx7lOp1Hc6j/QhkmIwfpGpFWYUITwZ4/Z7B+zhLmFhhamrdOwnp3Ny1e5?=
 =?us-ascii?Q?lO+Cwwr5uNizpHXk3AAJlomTfkyXbkPb4KnH32DH+00KSOZMRU9O92MHkIxI?=
 =?us-ascii?Q?7lv4X8F1pEIhVs6/QK5qeVGE+VJoSzvBqr9wKmE9sT+av3zcPE7OVS+IJUPZ?=
 =?us-ascii?Q?DhUUMLyNkVLQBf2NAA0N9XdecI1sZkZ8eTyegECD8d9ryZwGDPaNpZt3f3Si?=
 =?us-ascii?Q?rG228hzj3/THEVsBimK9uYYuB9boCRKQ0H9YEXjK0D81B3r9O1OnqVFPjOHB?=
 =?us-ascii?Q?sqfU+Ej4dZlsehY8PkWDLVs1a3/Y8pYybGlfb6B/JGcc71vsb0PJjVmP90Ez?=
 =?us-ascii?Q?6bBmLcMAxMfTeipdBLD42XUKqrxX6edaCcHhEPhNZTSKIe3nCLXe42nuZnw/?=
 =?us-ascii?Q?HRevNpV7LY6UFdWujuCLx22h9P1S0gsbY1g+paPgYIBCZCVPhNyBXLTqGDwP?=
 =?us-ascii?Q?vlkJrguiM/Iki667ux5uk89+juwR4N5WOmsUFCMDykycXjSpGz+OfKNsodD9?=
 =?us-ascii?Q?L0Toq8+NfHAdj0BSMleXXitwla71YxjMqhjWrayWRsmyYRZAGuZxg1w8NZ1t?=
 =?us-ascii?Q?jfLTHl7OJhNXlq913Wgzkmz6Tn/0Ia9VD1L2ej99?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6e276a-5c5e-466f-54b2-08dd93741873
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:48:19.2116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXglrNJeVO0P3I/icTrFutvPLBPCL4DOpcycZrUezH9xpyNKW7/vHrARKIy81Gj2y0xrOMtyzRSM7hsuCL8xlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:02 AM
>=20
> When an IOMMU driver calls iommufd_viommu_alloc(), it must pass in an
> ictx
> pointer as the underlying _iommufd_object_alloc() helper function require=
s
> that to allocate a new object. However, neither the iommufd_viommu_alloc(=
)
> nor its underlying _iommufd_object_alloc() saves the ictx in the allocate=
d
> viommu object, although viommu could hold an ictx pointer.
>=20
> When the IOMMU driver wants to use another iommufd function passing in
> the
> allocated viommu, it could have avoided passing in the ictx pointer again=
,
> if viommu->ictx is valid.
>=20
> Save ictx to viommu->ictx in the iommufd_viommu_alloc(), in order to ease
> a new vIOMMU-based helper that would then get the ictx from viommu->ictx.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

