Return-Path: <linux-kselftest+bounces-46075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8556C72ADC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BED334AFA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AAB2FE567;
	Thu, 20 Nov 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evAdTNxY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184D1607A4;
	Thu, 20 Nov 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625408; cv=fail; b=UvD/AVO7tY7QimlrTDQaiTJOlMXAHzKrs03OOzZWkeJwwIoPCI98Xc4dg8cQC59iRAq93j0itBSF9ZmT/IQYy61S9qKU1Hjbm7HbfX/j6gH2+ODkh2KuGPFb492XAJy2UZDg1tAx1CfrnTNQ0DCrCQ6y2eDmy8kyXZm93nQrvCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625408; c=relaxed/simple;
	bh=k1SFJ0Bw8bgbV8giffSuXhNY00+vUGQHuimmCl4TUJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8j3MH1HlAAZNMm78w0MDHcvdSWqboFa5hB+Azzn9+CQtU+h7ESID89VMuMCqSRsqgt2xZ3+KOHr7wYlb52RJz+Tz1BAka/Gf0fABtPJkXguegWQJoQMkBHyh3Him+ULCA/WRJvJKNp4yIEaS+qWqsHa8fVe9Fbpo8p3ybcAzsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evAdTNxY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763625407; x=1795161407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k1SFJ0Bw8bgbV8giffSuXhNY00+vUGQHuimmCl4TUJE=;
  b=evAdTNxY8sve4xDTlQdNOsps2kJR+gLSqbwM8sUGQ7zmrRNf8mKCUwdY
   Q3/WOszKX56wDhqcnbJnowItbvajw7gbheE8hpTGb0Bb2AKpYpjiebfCs
   BS9UwThMBhTxLZurBxaVe9lRaIAGvuMK9jBiwX2fNuS8Px/l3JKKJABTg
   ZIFVMVHZ0hdSRltKLuH69jF6zbg6/g6tFimb5KrqSgGH0UM4Qi4BLx1hd
   gRhukK/LQQY5Bxc+cUvnlB8DPyby6XMrHDvqSjsgY9ktDbzTy4ur0Kml8
   8jNX/x03D7pOKzh3p9CpWXMIRuLBqYEoFhF3usYwgpURu7I5VCDq1xfM8
   A==;
X-CSE-ConnectionGUID: REUQyT71QPSFrJyaHvCRWg==
X-CSE-MsgGUID: zaDd58QcTJaxWaToJrlZJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69540479"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69540479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:55:08 -0800
X-CSE-ConnectionGUID: yA5wFuMyRSyVMRqIR3SzXA==
X-CSE-MsgGUID: 3Mc3j4o3TLeU/JzvnnK4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="195587856"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:55:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:55:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 23:55:06 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.61)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:55:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO/hBYpgCBYh4CMe04eT1kGYo2j1vgcQKXSrvZp+f5hHoT92GSBrNiwHkUI4anITvq8n+e+4w/y5cPn9tsrcjLoHLIZcPmKKSYyXbl2evx4HVW9cjzRRr/lF957naOwN3Fdj9U0fbAFsiuYQ5Kp5PvKYm2tblbJ4L2Fw0R4z3pDPctvU5RmCcfwrCRrqL0Ygcsph6TLyQ+2aA4DYznLn6XRfsxeSBB8xu8tWV09vpBs4+5MfrgEjcRcmEHGCp+MVFYtJdoZz8JvU0NNeAwc2kWjLcsIOwRdYXNmMYBpBE9vGu+ZIURbdW52IRGLAYhbiPOrxgdwOsc6iKglECOuGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4yszX692BB93JTbzSb+vfZ+ZrfBSsBIHaNRageqPzM=;
 b=pK/pPSzQ3okIiJDgl0sK7MrqzoDzDgFB/lKgJjymVcHVcQhkXvxe74FmERtlRZsXEl44RuYIzf13opWQhPmY89NBmc9O299LiP7HBW82P/sEmj66y7Riai6NpNWSVlXO4N1dhkYT5MkSZCxrLjolKSeCuVRCKqWf+nf5b5/f62W8y5cXtSubeDdSjPLVlhMw57fyx0Fy3SgJ4PBONS2vtZ/PGSz4OVB0GDjbtsHBd3BFyX1uu7J5cBDC9UbfYEfatVrq17WKti/fs0aI/uexVNF4+GY6r5bDwpPtYYHGxUn+qSyCHOLHAvEpN/FHyrfk33zZtwJUQQXxe/5M2UzUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV4PR11MB9489.namprd11.prod.outlook.com (2603:10b6:408:2e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:55:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 07:55:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 2/9] iommufd: Add DMABUF to iopt_pages
Thread-Topic: [PATCH 2/9] iommufd: Add DMABUF to iopt_pages
Thread-Index: AQHcUAaQ5o8wDg+kSEqzERQwdOHX+7T7RHlA
Date: Thu, 20 Nov 2025 07:55:04 +0000
Message-ID: <BN9PR11MB5276AC3E40996E4DCD9159CE8CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <2-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <2-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV4PR11MB9489:EE_
x-ms-office365-filtering-correlation-id: 4b6fdf55-aa0e-404f-5f78-08de280a1de9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jhEhh7pjy9XCQpY2msNTfx17JO1TYHEhF5w085N3XxwsJivk3Zji7qrFXc?=
 =?iso-8859-1?Q?r7p3JDR+DvxTYyAup0qcbepf5u/W4+/MVQF8C2EwUsNbyAGlEc6k0Ome1X?=
 =?iso-8859-1?Q?F2/9zUM9QQ9NZtog70XaxKFrVnufqd9kByxODWDNcNs0r3QC+NPWRzi/Da?=
 =?iso-8859-1?Q?Vb2MD1TVbEc1r5k2r2H0n7nnruKmE5ffcBeujXx+Mt5Jxgxzgay09dFvIZ?=
 =?iso-8859-1?Q?ZLrzVUun3tY6V0z+6sHLLezhUwKWbw2Rtl6ukcsCssyyrrZcZqfj6whc6H?=
 =?iso-8859-1?Q?ISGHrGKzHgjp5nSkJg9HSlr2SNDlz9MY7Aj03rXPNlxXZQZEH2V3S96BeO?=
 =?iso-8859-1?Q?JbEsyYbJVRjISTZtNBp9ECMpkTR7Rg9caVITYOrcanF681ucwc6cDxh4se?=
 =?iso-8859-1?Q?KUMkMVIcpVpdGd/KD9U4kSvAvCXNNwc9HUW8pw01gwHp8AmCtUmh2dae0L?=
 =?iso-8859-1?Q?6xHfZC2p/laGij6JBIfK4KpMx8lwIwofYYcQHNzRbsBTTITaRbIrE/aNN3?=
 =?iso-8859-1?Q?siuUuaDH4/VAh8ERb+lSjvcekNRUPffrw2j/Ck5zQFu0Vy/tN4CodxPN0W?=
 =?iso-8859-1?Q?aS5LCtL8h+mP4p2N/ZN2adHa2Zsw+cNOSExKID9lfvstiJPbd1hICg/GCQ?=
 =?iso-8859-1?Q?TRAMCWfb6w7yUModgqUr1pmSbncmn/hWDlL1MzKPaY4G45wMA01Uln2tnn?=
 =?iso-8859-1?Q?s1qRvynFScFuLlL1mOMB7h9mvPXFmz1rzYeYPl3QER2EApi/rIlNwhcehL?=
 =?iso-8859-1?Q?Cv7yhaSCwJt2tk+U4EPTRk5WtZqVDEcGIJRBZHw5elf6FZKszIkEHbYcal?=
 =?iso-8859-1?Q?JCCH4B4F1nW0Y8sn3a271AYKsfgs7ksyA0zBXg5kacx8NXARCFFThz4HZD?=
 =?iso-8859-1?Q?DJzDDRSvQOruU1jWii81pz3VxKV8aqRDZ64RJVdTNlqZ3EIqOFhEpOIVZJ?=
 =?iso-8859-1?Q?KwcErELN/Hzy5d2iARWslVWsnVCuwhQuuvIm+m2rwk28vVhLNifCVgvWId?=
 =?iso-8859-1?Q?QocThs9G3g/xh/pFInvQ4XUORlyIz+cs8LoT/YLqNcvXZz9aguSkhZwp6U?=
 =?iso-8859-1?Q?y4KyQh9UFU/YlHe1ckh8a8zV3J3ugBbF76Av5Bhhzy9vdsflNMOSOURG66?=
 =?iso-8859-1?Q?ZNWDgYi9LZTk2cw0X/g8jUwdWMHHYkWJ3xk249rlAC7OgsFbsTosOTN3LS?=
 =?iso-8859-1?Q?m4DNM2q+9zW8b1vlUljmskTSpSy2Sd79F3GsHu6iSy0OqzTzXBpScRNMEG?=
 =?iso-8859-1?Q?6fc/eTrqo63/USB3JEJq6cTtmCFc/Uvt5BPG3piT2Jy8WIK1snmMAthkJR?=
 =?iso-8859-1?Q?dIhh6j+yjPMFFOdT97UxnpAANf7Db+mb2Sw3okiP+8W5Ulnddvzsx63jVx?=
 =?iso-8859-1?Q?Z1f+IMeeBK4bd1jSMwSNZzWV/6j4hBElZv1qYwWZa0ACCXRiGKNFjWPo8n?=
 =?iso-8859-1?Q?NYxVyhuh/lNcRE8i4J5zZa5G4t/KgugioqAG7QbjHWy2w2HqnCOmS2dbaP?=
 =?iso-8859-1?Q?/SkVdS5H/9NDzyuqINQseqJgxdbToQnHcfAWWQ+uqSdSDZNcxNWFKwUSsx?=
 =?iso-8859-1?Q?dZ2eF0yDRQPXFkc3haIYK1dr6jDYs38vLmaZFaA+Dl4uAQ9XQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Q3uf0VSQtgIjr7S/GOk6gUFSi5bmsF481Sgi9zwRZHvMNHPOf+OgjMGel?=
 =?iso-8859-1?Q?qeHQgfLGZmnfwRYO3go2wM+L2HVdDkiYFb1oryp8fVDEVifTulHgnGhVle?=
 =?iso-8859-1?Q?mZLtB3+914jLEVq1RknI1rSUHrxF3tSe6Px8GKr3NCd+o0+9qGdgyBeYEs?=
 =?iso-8859-1?Q?gXIU4GmUGVzkxgrTgEIT8RfwMqn8zCESVn3VptWvJTqK7Lgl31DUHvyYMm?=
 =?iso-8859-1?Q?aiF1yWEOWbAZrTATEkLhz4ELP/gEz0jrItb1DvB4xPbmQ2q9tWyNWZQRyF?=
 =?iso-8859-1?Q?infQnb1N4EG9te/HJg5FQPK0rJq1fwFeei8S3PdvvzQa/oiZ0cpa1a/BZB?=
 =?iso-8859-1?Q?1NxxDRAyRBYqTg6slmgEnLIzNtQ6L7SXe54bpnFmInjU3P3Hp6vbkiAbJa?=
 =?iso-8859-1?Q?OHO21aELF1MJD0O0vPETPmj8MhPAJcpRFh+YieAOUIwSZ0h1iwxTDnsG1X?=
 =?iso-8859-1?Q?NST9N2ahDQk8r3NWbzI6DS1aI08yhrtod45GgUQeTjH/J2w6reF0GX7n7u?=
 =?iso-8859-1?Q?uQLAIHaPiA8ooqBRaDMUyodO9tp0x4jW/VBIG9dUHCFfmFuJacwvL2o0Xw?=
 =?iso-8859-1?Q?qYhZvH4o2qJD6sue5nWmXYTg5IyjU393JYOPr0qpiIeIjOg8A5LL22Oa3O?=
 =?iso-8859-1?Q?Faien8JK9hdL19/wvtW1PdQOPEUkKWEiKSqUDXYhBSh6/+rYFawfR8yafM?=
 =?iso-8859-1?Q?GkT5fzEjmLaRuRGmgKBn961aWqwfBW85mZWAiyH/TlAsOeif1aES73gekk?=
 =?iso-8859-1?Q?7mfGN/h+1KuhIO3Lq9bhYxswg26pgEJXzxemalQAGhrlZFWYZgJoqFRrao?=
 =?iso-8859-1?Q?FpWhbth/lMX+8x0Ufj+RjrP72mOqmCD1M+U6ogi8XAaC6NLZR0vz4DUupX?=
 =?iso-8859-1?Q?gg2eCaJKnk3GkWD1MQxU5Z7PrZiSzNnLfs852DmNXls0ivnPEHOU0HYusY?=
 =?iso-8859-1?Q?NKOqmE/mN+NnmO/Esp66A/5mSTGZzNPNrijA0ndi5UgEmlFFpIJxHG3z7t?=
 =?iso-8859-1?Q?Ud5PDhfj3Ms5fvRaKPXhN2d7FB31XLLXRdPP/Br/VVGiJp9eijjyP+aHED?=
 =?iso-8859-1?Q?/wK9YwI8GlH5jTsupERvqEXgWs6Be1grAZApOTyR1/o4QeOmmrjxJJRyyE?=
 =?iso-8859-1?Q?udBQctHBU3WvG8ZM9hSWrqZFJXN5Pp4Nmygpu2mR8rZZCrEzxTwYUwQmve?=
 =?iso-8859-1?Q?xBD6EBheyccTJf4MP0tyH3wiFoobXm+3BxV01f88mW4Yn93qkY2aaO2j0p?=
 =?iso-8859-1?Q?16COglb1CMJhAG382Z+6Tjt1K5qB4L7CltoIVH+pQh5ozuYooJYjOJJnaP?=
 =?iso-8859-1?Q?Rbj+JdjES5e3D1yzq6myP7bNfgosH6uewFKrIoEbE9XDZxw/pLEAJ7JOiR?=
 =?iso-8859-1?Q?Qki7Dhxq/h1KVSyJ7HxNPiw6NNXVHeyp1vY6NYL8peoFmOTErPUqU4sLlk?=
 =?iso-8859-1?Q?lwG2sSUXynZR8Nr36EF2SUZjh1Xtt1FLxL36S4YOfWDRGcMJ9FZKZaff+T?=
 =?iso-8859-1?Q?Ei3k0ZC3380bVfcRA8LTKU/TouIM4BF9DkvtspkNnS26NUN4i1EVJW49xB?=
 =?iso-8859-1?Q?OUH06lJbg6C5vt1t8JChjj/ntS8C1lRwXsFUmb5AVuJ+/Fk/7/pwiGh66O?=
 =?iso-8859-1?Q?FMd8LClV1KQ+IxKPb9D56k+fkMsygwUCbg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6fdf55-aa0e-404f-5f78-08de280a1de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:55:04.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN/iL6UKhLDx4U4GXDsRRyoRXxe2UagHPiI11hsNrcAyHwPvuvxBL8y1+2Mw8HcAFw24BiJrTvHE3+m85uE4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9489
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 8, 2025 12:50 AM
>=20
>=20
> @@ -2031,7 +2155,10 @@ int iopt_pages_rw_access(struct iopt_pages
> *pages, unsigned long start_byte,
>  	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
>  		return -EPERM;
>=20
> -	if (pages->type =3D=3D IOPT_ADDRESS_FILE)
> +	if (iopt_is_dmabuf(pages))
> +		return -EINVAL;
> +

probably also add helpers for other types, e.g.:

  iopt_is_user()
  iopt_is_memfd()

> +	if (pages->type !=3D IOPT_ADDRESS_USER)
>  		return iopt_pages_rw_slow(pages, start_index, last_index,
>  					  start_byte % PAGE_SIZE, data,
> length,
>  					  flags);
> --

then the following WARN_ON() becomes useless:

	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
	    WARN_ON(pages->type !=3D IOPT_ADDRESS_USER))
		return -EINVAL;

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

