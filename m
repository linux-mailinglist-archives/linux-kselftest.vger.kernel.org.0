Return-Path: <linux-kselftest+bounces-20771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004A9B230C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343671C20C54
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B817A584;
	Mon, 28 Oct 2024 02:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awX2Mptx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DF224CF;
	Mon, 28 Oct 2024 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083315; cv=fail; b=fN+BfeCMPySKQznnSUMv0yjs0JZF0dy3mMbF2pTPbe1ntzAEQL4OjzNZJ0EF53faSse1IG+mqNAOML25TpeWVVbcSDwMmWTsN3SkqU6nkygpNo4PoEB6MroQ0AXaL1qY6lNDtYbEDA2OYXuUwHl5jderzjfX3xWLH8E/FGzH5MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083315; c=relaxed/simple;
	bh=ITzUXMB6BvxJnuaU0XL40LLf5kk9eS+HxjYoauQxw8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIQSs2j4s0473n8nbPEiN34nE/P66atSFF+ZCJ/YMAW5U4Y3qhTA6oYhbdTlJwfpwO9YoHlNNSF9iFEqAYXe+6wNMs1Jgqh2gYpkrJSQPJyiqyxnF8avmlL3+JEgCGumbZ4eHCkVuktR634YP51XZdZXtMow/j+ZI+KYoaHMyxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awX2Mptx; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083313; x=1761619313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ITzUXMB6BvxJnuaU0XL40LLf5kk9eS+HxjYoauQxw8g=;
  b=awX2Mptx7OTeQObGB6KXPRQ55MJmEYJuJI4e6xI3G85mxUeBoBtP49UN
   Pl8sGLKNwyNkL+Y8/2lefe4NVqa5deZhkMAP9itFEBom2mWpqhqLoXrPV
   u5X4ldWu7o5OEhnkUamjKzMTOkxeyHRowGgaD4pn9iMlB5DVBDw0LRs+7
   z+/rqjv+0GkUsLxMOI9reLtmbfsn0fZ7xFT2NUTzGB0nprJzh0AoBlpPu
   uGvZSs6nhkqW0nUqc6SWwt6vOUy2BlfVdTrwpCvspVaMmrd1yBJavD6H5
   Eqi4WqYUKdk4HpTWlc1C0qh7VS+gcLlNNIgVNoCnllOW5tGea2hQNa4Qu
   w==;
X-CSE-ConnectionGUID: oFdKiyizRSGiERs8dYOKpg==
X-CSE-MsgGUID: Q/Nu3U+HQU+eRM7hIW/D6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29104958"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29104958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:41:43 -0700
X-CSE-ConnectionGUID: HmsjYXqGSYS2Mw3symmCmg==
X-CSE-MsgGUID: Xz00aaMJS2qC+eE85Gu82A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81577951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:41:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:41:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:41:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9VIJgA6mXyRctqOqFsDj3VgLIJz/AEdqKUi3RfmahQR9dmilOA8yz5Wk4LHRDD7JePq23CwHDCHWsfSUylW5BlPVVyPc0zYiUkxYDSgwe5VkrhWmFOTxhFxMxmmee40z9p/jX6gtq0iZSy0d+zg5THn98cjS0SVxVKOe6/FLvXGK0D9eWz/0Cw0uG9t5y8g+YLMLPn6hVAQ1SFJUDAMs8o6Mp4CelUe/70O7JH6cBP6yV1Z73Nvr/KlSQXg8yHDzmTw0UdBQieUKERgz6IEqlGMKG9i3XxyNnmF8/BA2jTiiBYk+qHnnwvAyCfziXchofYSTQskB8DxaN78zTj1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekr621rlKsvJYAI6IeJjRx2Y6zFky0qy/94k42gTNX8=;
 b=CN+NVP5uRuM6vWBuz75m8Cp6jZfiYfaC5JUmpfyBJ7Bj5wt+MuI66WuZxqxsnf5KrAhFInsT03VoobtklVk9FCUhWfUSd4NANH9W4zj7jSfViyHmiaDJBlx9M2hysI74iFsgJ9CK/luU/+El45xR6lOEPLwlf372VYioddpwpquJ/TQC1IDudniXsPcPCPxiGYQr6c1+xh6ZxbOzkn782LYSyKs5Unk9UWB7ehdULW/gafs66K7wTSRRTKvGpAFO52bEff+8NVIlTOJ5nA+L4D3nmlQobPcZQLRydo7GvQDfO+k9dDZiUlwmdKUZe/+pvW6elsd/SyiuCV1RMIr7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:41:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:41:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 02/13] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Thread-Topic: [PATCH v5 02/13] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Thread-Index: AQHbJzisVec8d2q5gkS0VejmWJEqkbKbdxog
Date: Mon, 28 Oct 2024 02:41:32 +0000
Message-ID: <BN9PR11MB5276BD4D1A5E02CC52579DBF8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e172d2370223a5a012a70aea76175b71a95964f0.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <e172d2370223a5a012a70aea76175b71a95964f0.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 13801c20-cb51-4001-3314-08dcf6fa084b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oR+uQzkvJkBFx2VLllIyphHXcxn/tBqXic1WVRUMhqqd6wa5v1UKuZ2t540K?=
 =?us-ascii?Q?pZCbWyGhFiuI3VmWSDvjbt7Hteb9E9voyE6dP7k4s3OvzD+eElZiJQIZdrPV?=
 =?us-ascii?Q?2pRxeT3lvq0jf52G85GHfKbBlr1GcMHDfFqO3ULzJ4gbRNpVAcMEXksZTVxR?=
 =?us-ascii?Q?sIGw3ydVuVbtjR6bHtX8+193vqeKdaiwXx1Shj4gFj17WVvBsA9pS0e03vRe?=
 =?us-ascii?Q?PFZ3LByWItdU8Qh2/HF/Q35LsoK4R7vSPcrpl00g43qHdiEKGtb3y+qo1b85?=
 =?us-ascii?Q?jcwpBno65BRjm95cFCIfeOUmGCvtWnypdOGd1nRfgahA8JPqyFRXc6x2Vmzj?=
 =?us-ascii?Q?zMX9rSl/riMSDYOAgX2J9BqkNPd4QhAEQgAhL3zn3W1bNRtCD5Dm/tf0b7uB?=
 =?us-ascii?Q?jAoeYO+fwa7znRq8+ycxuvrQv2sVse2ZY/6wUDwm/msWQ9xNJ9Eij5up7/8S?=
 =?us-ascii?Q?62r7rBMjxUO+qsYJYYZZf14YIb5cjhqvfH5BdQJTUHpaoaRBat7TfmFHWC/s?=
 =?us-ascii?Q?1u3G+K66pD2r4Ybxufh25mj3hUY87s20mZisqcdL/lpa5uWa5THTmYUVJvFw?=
 =?us-ascii?Q?ojUrORInEKUI8v7/DKTFsHBvvWW9zmh122UAm20WMUYMKzxlpAqvHYMgbKuD?=
 =?us-ascii?Q?UUsGld1GqBPU2hTcRmyfDlVH1UZhNyH1HoqI9TCTWFDFd4kaqYhDiXg2Zaoe?=
 =?us-ascii?Q?MSYFWTuQFQeV08OuUUb6hJfNtdhf/UR19APShWW831F6VsDD+SrFnjkXZhmZ?=
 =?us-ascii?Q?VtubQ5ZVNptx9KNnD1A1hr44m5A+GdwTeDIXBEaRIyutp/UJh3Y9s7mFHcPz?=
 =?us-ascii?Q?UullCjyn256K8n98Fdgjkdhm3jk1KvPHVDCYosUprA01941aWXrCDZ64Z1BF?=
 =?us-ascii?Q?TcZ1e7z+fE3VECTkbW6l8rbzQqsDKhFS5n5uL/DONO6Axx0pJurKpmPtx8Y6?=
 =?us-ascii?Q?jQa33x7XwfT0M+jesKRaT8UblLm/juYivs/WGZ3aC1v1LztIQ5qzhs9s8vtA?=
 =?us-ascii?Q?IM8SAWesW4MIE4OEmYCtjYN22pAvI10b/A7l6X0IoBDtpyxsh/DNJl8/cnpQ?=
 =?us-ascii?Q?0ho03+Ncpq21sTfXJL+fYccIxZQVwFuYoRVkg1RfCHW72JeahTHgVF4CQPui?=
 =?us-ascii?Q?KKqt+pn8WWPD3JdkeTUo/HEdX1NtpbaLABatY2P8IyxE1rl7DQ9TxN3Qyx/B?=
 =?us-ascii?Q?LPLkKSx6dko+zHSTPu3cHYFrRNbcF1SUG+FZKpyJns0rzdUVZDwykKCZqHrC?=
 =?us-ascii?Q?eiM/LJc6Zvd7mABv6BW6y9pkBgBSPKPwx+AtcbWBz9STGEgrlmmbX18sN5WJ?=
 =?us-ascii?Q?CnUDQ4uBKojZUdqoz98ogDmtnS15hNyWUuVm80ABSeOX97ElwTmWVIOzxySS?=
 =?us-ascii?Q?iS7naow=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LpTnaXRSyX8By3Z1Mj9X9TK09SFW8F1KYJkqdju/iMzaVLSQY8kV2oMl0pi9?=
 =?us-ascii?Q?LdpTZJd+3wKOBlRut1z00l9dotS0uUvgtExDpWJcHgvrV5lodBlaEFNGdUDe?=
 =?us-ascii?Q?ItB2V7rB5sMlP2vXwdvCPpnAHrxSrBz+CUbzQ6VSIvGsRCT/x/rfkum6Drxd?=
 =?us-ascii?Q?u8sX1SMXkLwKP6SDj2DlVesOhQml2xGc9xUytYtiCzjiZHGgQtqnXH4YwM2e?=
 =?us-ascii?Q?+9V9+A8L6rtufIihgQoQtRHrmN7g+clbBQroFUJNvrbEI2KMPDXzK9ClAHUs?=
 =?us-ascii?Q?16CoTCV73dF5LkQCgxCSr6UT/IFvzdP4nqEWXNWryeTXWAfqfMrCBDIkzE8X?=
 =?us-ascii?Q?u+/9/ZxVgigx2s4WfsxcITeCCCpFKh+HMomR7YhgWHwe4B6UKKVK5RNAGuYD?=
 =?us-ascii?Q?9MI95gs6+UPD93UBwgcJz8NE71YQqK8mEkGfk3GQVWatsosEz/rz+lH4IzSC?=
 =?us-ascii?Q?oYjSoh0iRjHRVVf9vzx7pd4h+e5vR7aboUrDJgjGOIHwOYJsR4bHxF7txMEy?=
 =?us-ascii?Q?0cS/24938xPDJIInUHjUQUg9855SVYeB0DjeGTYZvyTXiNSsZ1s7ds2ZOajh?=
 =?us-ascii?Q?Z8cf327tE33oHazLO88uIDfatcT/dtyKI9wt2xOTparm9TgL5DQ398hbQR3z?=
 =?us-ascii?Q?DU7RbG6GlRNX1Ehe0ESMLB94Ty4VUcXgjIABWr+eKTm72OKPnPUKfLVKY+bW?=
 =?us-ascii?Q?gkB8g/iNEC4KLbfND2lD7SVdfOxcm9oDNvpIELSqKjpSCuM+J1m+tpa2X0v9?=
 =?us-ascii?Q?KVWT0UNswfp4iVVeV0WAaTx5ZlI/RQe9rm2QBdiHIMxAqK5lxBAg9OZ85TrQ?=
 =?us-ascii?Q?Xj6W5H8FYR7WvyGU4vv9BCPQZNh83i09xAT35EAWfaEEHvQsYo/dZYXSM+UM?=
 =?us-ascii?Q?G6t6kFhobiV+4IJghdcKA6s1CMQmyzCl0WpTIPW2WoCbV+C05qtBSCwyfJJP?=
 =?us-ascii?Q?XzY28x86f11SkM/YdWpKidwNT7Nwj2peX0w46WtsJh2G6PEDz44CWQFSiMpi?=
 =?us-ascii?Q?Fe0nlXZ5R2QBpI75hqeu4sZU5J2Y1Jm1JnML45zxfkiy4mBx1e4AcPKiBeX2?=
 =?us-ascii?Q?RIghfzunrX42YZ9ob3v2kdSJ9voNogNARBra1LXZ/nyOmtitpo9xmboD2Wc/?=
 =?us-ascii?Q?DZvpDYtzQADB2RZMoEwiDbe8vnSDOCqoisgFZtZNnK5tGltbant23lzpP0ma?=
 =?us-ascii?Q?48N3d+Gf6B1MyLV7GO4LAlkKXbproJp+UU7eX0VUjhLi5qvgqHvKW9JJcf52?=
 =?us-ascii?Q?GkTVwntklbQo1FjqoHtIQPP5TndAsK8558/XSmJzgdr+FTroELEBaYxZr4nf?=
 =?us-ascii?Q?quXs7yhAsUEqaZSK9nw0H2osi2dRkKoxwHO2H6SKzwvS69C2Ctw2R3uPC6Oz?=
 =?us-ascii?Q?UDFOjfct1sxQ31V945faPcXW30HeVVbnt05a3A+QiT/im88PpuOLUCBky0nZ?=
 =?us-ascii?Q?JEdPCRhzScWrsQKOLy2JcQB/3AJR1ghriMvaV8TPyDcDpZGyQWf9PhgwE9No?=
 =?us-ascii?Q?+WZSabfHcjUBXRZRrJr4NqXcjA2Wfi0g4XmH3nDPv73VGFd5QE0bNJdhK3bt?=
 =?us-ascii?Q?Ac7fDNNa4sDp68kQ1zFeaceUN/numoAE1V74PN6u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13801c20-cb51-4001-3314-08dcf6fa084b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:41:32.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cC9cj/YCXk9oneUHM0D6K0bhhJsy+0tEgiVmoRfnD2s8+KkEAUqJ5NRLzGf3Zx388UJW1BniJ0bDL3QknBZdJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>
> + * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU
> instance behind
> + *                the @dev, as the set of virtualization resources share=
d/passed
> + *                to user space IOMMU instance. And associate it with a =
nesting
> + *                @parent_domain. The @viommu_type must be defined in th=
e
> header
> + *                include/uapi/linux/iommufd.h
> + *                It is suggested to call iommufd_viommu_alloc() helper =
for
> + *                a bundled allocation of the core and the driver struct=
ures,
> + *                using the given @ictx pointer.

s/suggested/required/?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

