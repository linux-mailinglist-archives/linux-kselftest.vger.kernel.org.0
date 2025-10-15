Return-Path: <linux-kselftest+bounces-43167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10BBDD26E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F445072EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55731771B;
	Wed, 15 Oct 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFVOktnT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DC299AAF;
	Wed, 15 Oct 2025 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513159; cv=fail; b=RPLarIKDizdz4cu/eIOBRYXMi2xauhXzTGru/rbT1grFiv/TOZuXZGwhgQ/jW+oSLpC55cZzijE3zK6a77gFfRLZS6JX6aHjkD4Ob2d4/b22s+lzJoqnf1hrwWmtCBs3JpBpYqjFz6Y+VW1hT08ynIncZDNI/2WTRIRtIYZtIJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513159; c=relaxed/simple;
	bh=znXv3e7vxXzV1PPqIsTnC0fTlOI7aYR2v25Ki3vdG4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VnQ3gnWzM/jTc57tUAkn5KEcmajiDurHNFfLhTrFk6pwbgK9zTeYJVjnOYSyV/Y0qqU7/ksGB51axDbxS5D3UiNJzO6O2FhJQn1DccIUyg3jFtv4AX91vewWdz5s4s44RyZMe5FlGI6McuL+ec75eV6Yr4mfSvYKidqDVKKaW/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFVOktnT; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760513158; x=1792049158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=znXv3e7vxXzV1PPqIsTnC0fTlOI7aYR2v25Ki3vdG4w=;
  b=FFVOktnTywuT3TGa5arYiD8FIZ64V/Oz7tU3NB53VKkLo3XIzga+Ym9F
   np0Ty63HoULAyr8asd0RPJxqtd4e8lKzPNetO4cUhoxAESwf0oZZvNbX/
   qHz+h4wFExs0aAGiVtKNnN1Zjd9DeJuqXl08Z5y+xVcmvrcay5FiXLy8M
   acThpZksdE3GsP+9xlGGNOGZOmeZWp+t0xc8cztPDbngbn7p4w1sY1d0e
   k/VGW2LIfJQYg/GhnnOu1OipyIZ67VAK5Fg1dhAUMxHgY0Qw7sskYA4Fi
   s5AlH8M7gsA+1oTqd/AB/zw4sdRXKuI4cofLFHMo00nZy7R0ZsfZGEVSF
   g==;
X-CSE-ConnectionGUID: C5aU2JN0Ryu5EBXZHdApjA==
X-CSE-MsgGUID: D44c+MzqQ8eNpvPF6Vm0sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62576708"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62576708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:25:57 -0700
X-CSE-ConnectionGUID: 2cvbPyfTTcOGqgcFABBNSg==
X-CSE-MsgGUID: o9d6Ez05QkqLtLqhJsE4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="219238838"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:25:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:25:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 00:25:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLrZ9W2K5ftvb3/M0aSoPmLX+vdNtOjLCFvWis3ScFI4+LdojIMzYXds7OBxjSdJELRn6oxENw40CW8d/MQefRYaEtVmo4vlTYYk4VXAjFRcBd5gOaFuVQlro5qw/0FJVzXCWuiSN7zuDzsdLefxv8UxPToKXMfD9xjl0rpQnqZmFmlaG8Z/CnqVxvQuUkoiHAH+qr7HXDuICNRaaRUN1XjoWN6v9TL2zb5VeSHM8s/S6nZNMO6ocP+qORSA/eN/qLgkUNVPsspFg31oi5yIld5rnNWAavhOqMetlfPJX42LyW6TznNuCTNyOxiL2CEOAh00EosOzWs4Wy6kPnL3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzcGuoMmKhzyPabMXCHHsqwZyRTiUbB8BmdzBSdXM0M=;
 b=EW50l6lvb1g9cdtbyh754uFPHn7GxghcK83M2i+jcJzP0WQKVpTCv060Svj2kdTpir5qfDbXu9PB48EpVgoQpI3f2tvXlL4KBoHYILka5D/waWXUyktubRmOvgIMIcR7irZoim+i4+A0NiqhdkT/5UpZ9mPCoQOpn0XPtXlTp6Xr+95Xrl42t6Ap7FudLTFZrkVYC666zvBxhQXWNUWWLnf/UUpgqOhNqgjAAHuQBskLaNrQpRsAhXxjkLEZ9ohCQwZ64qgnBrLd2KjHh7XXOl8egYhL6mwtbcu6M3F8QlsYjmGsaT9LLeBuhmoA5AxgfbvAGjoSqpTl9dyvH0gDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 07:25:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 07:25:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 03/15] iommupt: Add the basic structure of the iommu
 implementation
Thread-Topic: [PATCH v6 03/15] iommupt: Add the basic structure of the iommu
 implementation
Thread-Index: AQHcN6Ux9WAW8NWQnkGxmIenUpHRxLTC2ghQ
Date: Wed, 15 Oct 2025 07:25:49 +0000
Message-ID: <BN9PR11MB527642E4F4290938CCB4BE8D8CE8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <3-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <3-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4846:EE_
x-ms-office365-filtering-correlation-id: daceeda4-106e-422f-4d1e-08de0bbc1096
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZwTtNJDtK9MpYxvFF3Ns+0XdisABE310J4AYYMP2s0i2lOU0hLiwtnQRQidi?=
 =?us-ascii?Q?NCSaKWI6rqbMNApnlvOxd8LrN29KdvySrOvURnlRcSqbcOkBRjRvdyk2OGzV?=
 =?us-ascii?Q?IkKCYdiVfF37V7k25NYCZh/g5G+INnq5lgGkCuOCT/jDRKuU1E6rHUiqkwJr?=
 =?us-ascii?Q?xYOPFCmFQ8NDMjFef25hWJXgQcozealn+K/ZiHrCyH8sNAAaARAkLNTP8Vp2?=
 =?us-ascii?Q?FIpbthzQLk0kwhdSQbJ7dcEP4LA1k0ieqEy3SSEkUUlERVRoOpNhWL1gd9Ex?=
 =?us-ascii?Q?omqQlyRMmttKSVVzXIHTAPEtb1KdQXokqj2c9M3TSLikDbX65+XBeoI7py9r?=
 =?us-ascii?Q?X88LSg6iY7saqe2krOnmchMVENZxpc6i23bPicflZtTSmxafC6hnIhVlBUMs?=
 =?us-ascii?Q?MhberzlTaUTSpd3fI6rwS0YzgZT7NyQiI0qbRjb1t2YhnNsQIeDboSgeA0HI?=
 =?us-ascii?Q?HlqZRPjwSiRwdLVXlxnnlolzu175jMsQIkVhg+/IHMTouV3clWTLH4x985+5?=
 =?us-ascii?Q?vhtZVIrNvs3MZT9lcuoW0tE8GtPjBFG//mIJ+RXiWKqZTrxUCDDgl6n/8SFz?=
 =?us-ascii?Q?owv0Qa926Jg4njOAaFBkOVlApCTOykYcNw/sYwvHcLnZCSL1EXd8e/ZuMYFi?=
 =?us-ascii?Q?VueOlNQp/2s31iS1gsXU7ZcvXC3c7A8XoqCbE4S36bAhMDwCW8+dnpAwCkQj?=
 =?us-ascii?Q?K2R1xBNPvbdlJiOPWwVNgUIcslWskgTFyIRwABArjWp4EWvCadofBQLoWs1s?=
 =?us-ascii?Q?lqt0K/ftgFumZJZ/1wjNlnW+xp9l6FnrtJu0gKBKm+V7UYNBKBOvLCX1FiRG?=
 =?us-ascii?Q?kx5Xv9wFe6vNZbbgYyeCy0atI6ORO0jwbzBjdMGfEYuF/KeW+ioRPJsIFBlv?=
 =?us-ascii?Q?vpvSqdJDCF0VA7NAO1G010x/YiPfqwmVer2TcZ/nos3Zy8v9nhrvcR+z8nHB?=
 =?us-ascii?Q?dZ8sw6s6gppFtdYUAk06BZHiih5oSAWp/K00TpGb/JyOS/TVHAFHV35c/yKw?=
 =?us-ascii?Q?27FecIr1DA6ZCabYjaUixZrMEk8bHEQXiMIRnGbdfEVgcQN/wvkj874gaf71?=
 =?us-ascii?Q?hq1clMmx44qYDiTEx5PO31hS3qHuhFwpjwxJvZbRWyQwItLUU09tlU9H3BT1?=
 =?us-ascii?Q?rB2x7g8WxxLA4np1VD4SFTpYAA9uhZ8MvPHjQwfqA6pz30ArLZunCfZu6zsV?=
 =?us-ascii?Q?ldzFZJMGUaWhy1O0+G4lPc3BsK23DkZZ2DkROlu6kWZ0hZ651Ib++bfyEYPG?=
 =?us-ascii?Q?1KOVL7YtORsRfwPuwhlVy0dsgHZr48LOnx+D5I8qNS3YdA9AH5FxyxQHWpTZ?=
 =?us-ascii?Q?jDvHo+/G1oiPzmORstHUxgYSDS3GdW7SVKyvb5IpEicYlHofOii9hVC6peaN?=
 =?us-ascii?Q?LdP8ewk6+yB5HW6AgkmVWOLb416acQNJwCPHfIg/s6mJRosq2FLvBpvG8sDd?=
 =?us-ascii?Q?Xdyw5g/9MYo2PUQo2KRBT4ARFG4jfzFUEb+vzNdefb0nAOIMOCpD+VnYkZJg?=
 =?us-ascii?Q?xDZfJ+wtqzlAB6Gsst45lnh0PjXRii/bpCgmB6iUHOKH4X3myYXxLDF+Ng?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vvREqVEG41eMpjCIVuOOXcTh13xmU4nCGtHhvmS5lXwMaBBakhMAE4gCVBSq?=
 =?us-ascii?Q?vPf/bdN0kWJmSVwPehU8+1WVGIqH94Q3V8AZw1Sd/hHVoeu++i0hiqjVSz9z?=
 =?us-ascii?Q?8oEz7sVYE92tMBYBw2Y6O0YFVHj4KJYL6pDto5hymqfBG06YSgL/p8ph7LCM?=
 =?us-ascii?Q?xqBCSwtY80Ot+d5OLNMx4mViIcTuWJKHJ2S4SkQ5Pu1YtLlq+SMiBbMXu9v9?=
 =?us-ascii?Q?jbVaOo7mLy932Mxq97EdmTDsqOtSRNpN/9wc6mSawtZoh8C+wkeTEcn2X322?=
 =?us-ascii?Q?oA9OAygHC6++Mz9CWATFxxKLda4g4p31VwsDKyUlDe13S8utDyDh0aO3bq70?=
 =?us-ascii?Q?AvYrGomm5EzxwlAwHOTbHuO0TeoHjCJ+ClBAnhel9BP3C9lE084JJAp93gSc?=
 =?us-ascii?Q?g26Vn7waXe8Qs5EsS/eEU1fIEGwIXyKhHIqsNh5u9k/5pONgnme6t2uqyQDR?=
 =?us-ascii?Q?27edgJwp8IdagfqQAzMIj4AwcjK6JM3S/X4PTPuX1W1Lb1RPuurXRqjiHOTa?=
 =?us-ascii?Q?ryaS8cH72JN07URYPQnKKlbk/xGpC3DJ/M0zsawtqbvqIs90ttnKwazReFo9?=
 =?us-ascii?Q?3oTRfHDVrxBzOAW5ENQqMp4cdtu4P/Ukza97p6dm3KBjp+2xz6dmtFzUDbbz?=
 =?us-ascii?Q?Y2nFqUuWTYXkLFQeXcGRZERi2jwRqq6Z8zu7x75BIzdriQzOzR+cZ38QmWBn?=
 =?us-ascii?Q?OsfJw3J6g9K5aryY8ZkTkCKZQebJHqRy/fm6i3Tx8RhHZDPXGd7jlyEPeRmR?=
 =?us-ascii?Q?i13H1CYyjttqz+WuYfA9IYRzZtaWZMjDb2X1R+FjKLRbXRd5PARhM1bbdmVI?=
 =?us-ascii?Q?yD5w9FCbMTt0fbPO0mSJGvLpQZl9WzXs5Noy50DJArAX6tU9dGTmzFAUOZ/z?=
 =?us-ascii?Q?WypJxdokj3pHvb23DF2fbTzlx9CkDSlHHjEso4jGOpS4LkYFmKGpP3jIM51C?=
 =?us-ascii?Q?AdKR8BtQdlhJWShj3Lte2vNJddeJOtIVtNiMXz671A4ZcEsXlO8JcQW+s4jF?=
 =?us-ascii?Q?L6uaY807p0681Getkf/Jgxc/HbBtk3OA6HNUYAarmwS0KOv51V9l/DYs/bkq?=
 =?us-ascii?Q?1MX8ubKlGXWrjgjN8gxn0tJPltVObSBdZjAjQtFGsTMTBw0pdcQk0u7JspZu?=
 =?us-ascii?Q?KXhEjAdzYet9bqCCmH01mqdp8y9UsRDHtwmf29o5YwEDOWh3NXG1flRp5FTv?=
 =?us-ascii?Q?ga1pMIEtkg58UKvp/g2vAQn3rWwjFZXsZNloDaRKZ9zEljkHgH/fd5XdG3iL?=
 =?us-ascii?Q?RuFneaGAuSAdEFv1dnazrekDExSNENujsnjXfJgzHjSj8mWo4EuamcploBPY?=
 =?us-ascii?Q?BTUloVirS5r3/18dfVUJB5OFs46bbroIr1ghjeSciWaEpgrICqHPukNIxFBE?=
 =?us-ascii?Q?xDOPpjp67Q+G1TdpCxmy49TJvDwf33sGpvGTsnFitwazxImMYNwQSrqTD0zF?=
 =?us-ascii?Q?A7Eo26lx0yOrGK7oNI+RFeeZZ8RM6negvUVqfambf/LqDRNZ8uHvaTZDHbbn?=
 =?us-ascii?Q?RYHCX5/CyH21aVAUxJ70EsQgGeiQGdItPhbPDvaqkaDE1/2tWkSnKFX2Tx+v?=
 =?us-ascii?Q?K7N1AUQkLrlpTl9M8ra3e4Hi2Oc2tbOBSOQg+z6x?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daceeda4-106e-422f-4d1e-08de0bbc1096
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 07:25:49.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qPwih9zUKYVp/YxuEe9rerVLNITSqeCvY6WAbnpWxOGJYf7hZNzTdbLWCLv3UHnGWlkoVcQRNgt1JfduMaEOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
> +
> +config IOMMU_PT
> +	tristate "IOMMU Page Tables"
> +	select IOMMU_API
> +	depends on IOMMU_SUPPORT
> +	depends on GENERIC_PT
> +	help
> +	  Generic library for building IOMMU page tables
> +
> +	  IOMMU_PT provides an implementation of the page table
> operations
> +	  related struct iommu_domain using GENERIC_PT to abstract the
> page
> +	  table format.

"operations related to struct iommu_domain", and probably split
the long sentence

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

