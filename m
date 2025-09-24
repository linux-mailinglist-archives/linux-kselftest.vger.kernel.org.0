Return-Path: <linux-kselftest+bounces-42173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE08FB9913E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 11:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E167AB408
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D92D6E52;
	Wed, 24 Sep 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4NUb3kp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706812D6E42;
	Wed, 24 Sep 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705740; cv=fail; b=gncY9fPR5gRUdztfFUzbe8DXzS7DtwpdbjVGHA/ukp6MNkB/ahp0DeiDLRyAcw6UGBZelZgvEwK8k7MwBvf7qCLzAczXrK0t/LL3NuEnbI+kldsAz4x2jOafR9CPEzpeNymJVIIpsui4ODSDFFhWSGymMtlkFn/Zi8la6ZsF/vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705740; c=relaxed/simple;
	bh=pVttnqkxHMRJsnp/LBVJZJr+NcuWLymYrk+uXvwcdA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S13IWH5Bb2SH/+oXoSIdUV40/ab+v5pBs5XllP0ETuHM0mzs9m7DORLog1DwLGbCXccpExB1C+wXMUzJSsbB2h5kruelE6heK8z5PXfHWDghb1hvxpu6Z0o5B6YCcJ/i8isBDGmK7dA5EZL/ekaRdYqXAzUgiO/9WI/lSZEyEbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4NUb3kp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758705736; x=1790241736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pVttnqkxHMRJsnp/LBVJZJr+NcuWLymYrk+uXvwcdA4=;
  b=e4NUb3kpVDUnl+mrYb9kXO9SLhD8lyBqmtvCrPj+6ZXlh/NXKdQrrx19
   aFC26c5sX5YLZ/kpBRYVzwiiSDoDEPBBPILo9nHnTXFtcgJFF60PQNLAm
   K/MBEJsYNL+oXIhZp0JV7So6pPJ3rYFB1hp0/XKMSmvkiji4Uw/46r9PA
   To33T090sGs9SRyE45zZ0eeuwPdP1lo3HoQv4T1xVtMvnaJ9cKrX555zX
   37yEjaPqilQNrM0oFH9HEkuUJwLBsSVn0hPLxK3GC/V8hpH92PFud73JB
   TzKD9S+xWAM5pMePwU06z5kczyxiH6dp8MDZ98SUOt/kWRf8Q5oMhuO6h
   g==;
X-CSE-ConnectionGUID: Y2GOIwV5TJqlmJi09Z4+Pw==
X-CSE-MsgGUID: ihyNya+HQKOgdQydXgbdew==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60921466"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="60921466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:22:15 -0700
X-CSE-ConnectionGUID: 6swMlR7ATT2MhimrRLbCew==
X-CSE-MsgGUID: W3kdJ/izRLGK1gQQ6fLBKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="214111965"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:22:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 02:22:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 02:22:13 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 02:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOTpOUwiJOo268Jjn1SlcI9u1ETs4ruiGnuwDZy+93Gj+uXtn7aMfQZ6/RkN/sZf3JdbsH5VjzSDn2VJkoOnlm+1LwxGR2gbpqZbZWDG4CSFI92Gza4wljXItM9Pblp+hlgqtpIhVa80hK9dNR+mOMNQ/uWnkIc5s5VNTZ0OA0IDZ+R3kiEsAcV839as8oyqXA62Q3qE8j+nQ3bvjCELGBdKcgJ/5By9oxvjTMV7tFyYmED7VsYgp2QCnAEfOnytFlnkQhOQ/btjTtUeUHfi9N0ewCXxHxBpkW+k86OQFOcu2RcDeBAMPsQTUMr1Q1yOehdANykqwuZq4xbnqHzu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOLF6PENsB+y+ZgnoqhhdHnOsOjS2yeUmKxC6rSiddo=;
 b=Br3mPfn2q/gfZnjhyKRwNjHRIyEw2OAnx0JI/r6Bl1K43xRYUPL/YNS/IxAfEDXhO5z42crn9eUZJqLQKZ5rrWtFQUx8cV/onmCla2YGeP07G5TFC8RqVz+BhosAqHwQOwb/iFIr0KcVHF5BSrH7Gast9zosLJfyF0UynyRE9tmm+4jI2nKQpYMDyl79qSLm1/w8rM2Gxq6NbGnWCdHmOVLK+XQ7PIEvRtJVRPuCi674FWUkbPf8BZmWCovbRbSWU6KF1zMllc2p/QoHPH74s9t39tDlYuf00U7S7t2EF+5I6a72RVkJgyUl3fyzwJiM4ijLPAAxOp3s8p/OF0nl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 09:22:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:22:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Thread-Topic: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Thread-Index: AQHcHPrR8MFcZTbSXECVEcBg2V80YbSYmJ3QgAIg9YCAB3XKYA==
Date: Wed, 24 Sep 2025 09:22:10 +0000
Message-ID: <BN9PR11MB52769D72111E5A55205DAB7C8C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB5276DB96BCDDFC2DB68FAE178C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250919152627.GE2132010@nvidia.com>
In-Reply-To: <20250919152627.GE2132010@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7899:EE_
x-ms-office365-filtering-correlation-id: a99338cf-d5d2-41bd-ca82-08ddfb4bd74a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?aplVONjpDPkHOkKif6xzuJXLwXgT3lzAAJs3BE1S9NWl35o8gvDN70ByLHHb?=
 =?us-ascii?Q?s8aOEYSMgNhVma92CguJhf3Re2GaewDacSCjhFIUp/sm1lObDN3qGjkFEO+4?=
 =?us-ascii?Q?eTxRvyuuCJBpxkGHivbr67Zn8I8KYBVZiugtkrXSX2dJBkauqH+reTH1ZM3M?=
 =?us-ascii?Q?zRchDeGXyUu5laexLaOsCLRV/9Xd/IE+Ts75FK/AFI1rp7zY9oUyEXjN7zxE?=
 =?us-ascii?Q?CY+Xob5rIHxaYqhFx/z2bZwo7tmvCsmhIaQqp+4uZ5kCqeJQzeV6YUMHJKlg?=
 =?us-ascii?Q?2PVaQNZCHqKLZYK26+PktRl3959s1Wn+fTU/z+WSam4tic1n/j1krwYvJapk?=
 =?us-ascii?Q?jOkDQpgvK3e2AYkzoR4BDazoLc3hBFHn5eVf9CVJHPn5DQD9+f2TKajGSwvE?=
 =?us-ascii?Q?fppLIXi4choo6K2/niXInTlvVqz0ePJQaZBspTTVx2Z6yuQl5wconGqEUVbX?=
 =?us-ascii?Q?zkybTcjmty22pio4TqTfWT9C94/H8MkImjDG2nwvnFVbGUpwc4JYmUQDmwhc?=
 =?us-ascii?Q?AP+Pow0ncztbcTnOPs6M82ESPnsu4queiQT601/+5rpWOL2/aUjdYdTNoUC2?=
 =?us-ascii?Q?PZ074nJtC5p+EL3UsTKMFfbt6Bo6UlKj4WdXgvSH9B9QquxhKNs+68XWdd65?=
 =?us-ascii?Q?5izmOSpldMzVF70egW8IccqZW/cyLDkeOTI8cWmxmuzzvS2BsQ3wuoBwNQ3u?=
 =?us-ascii?Q?2d7Jd98B7EJaw+N3uiMvRYew95XFPBV5M2h2HZ2TdLwBYymnE0knhey/tBtr?=
 =?us-ascii?Q?Kp2e1qynM21xlWfUgFdxqIGm+0+ZHb/rRQB1CJIf+EIGR5KROruEhZ5vJeAT?=
 =?us-ascii?Q?KKJakXkf0V91COzxruDgjbnxOzMbNrhJjnwWQwK1cHcSCPU1xewT5X6nDdri?=
 =?us-ascii?Q?R8L2tUi2bXagLELUY8iQ9gOpBZlMiOzBley54tFviN6v0X37WjhgbJCb7GHe?=
 =?us-ascii?Q?Ps+e2DKDQuhTNJXdRs6eByJu7WSLDZxCet09opSt59cJlKEAHup2wuFDL0dI?=
 =?us-ascii?Q?KGzRdX/bPr/7NyGbA2+m3uLX2q34jLBsLZV4YcpTBazvZxgOB1zvlet4YEF+?=
 =?us-ascii?Q?euiGabqzFPlgx7Zyv2Md5kzm7YwM9C2Ymk+vtSDqhjlGF80FR3dAizwVkPbj?=
 =?us-ascii?Q?xmZhVla3PZe3igp4xo50+DoGNrOFpSqVaIoLW4WPPcEoQ6zm9AjOuXjkuiRO?=
 =?us-ascii?Q?jxjueceu/aNPF2b99CV9bFoqO5R0cjgjffj+ForRLpL3XMw6xioFOcHP7Qko?=
 =?us-ascii?Q?lW4u03MWyQjmP+AjzWJzsLZsEoVdJMdsjfzFlf+p4w59K7jOBNkCZ/qq6mCA?=
 =?us-ascii?Q?VTUFvqju1dFIMrqyxi7bt+PoGJN9kO6b8p+mDJbbQZlujtmqSYaPAGQDUDG6?=
 =?us-ascii?Q?kO561AedOPPdPsjWIC9SKVmg5jqM7nYPkwHVGGK7b1H8dYSb7HEmAFj+zw/U?=
 =?us-ascii?Q?GevfSuLhpbF2GG1k+hQX+XBqIILCtTIsb341n3i25gMiK/C/Y982kXa5SSZC?=
 =?us-ascii?Q?3O9uVtY1th7G95s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uaxtv5KRG8ukrK5XmsF6zBaWLnIDed7AmbU4MZSuCljss3/gBmQ2I+g4/3n8?=
 =?us-ascii?Q?4x+j0nTxZjIArf8Mhq78KA3BFGxePxq7kurdUNgM65gHQchG2fGCPC3X9q4H?=
 =?us-ascii?Q?b+TJT+zjnM24U3qK4AlLPFZSIIygXdWy+iRja+TLyTqiheQ3VfjVu8Ua1ieb?=
 =?us-ascii?Q?8XiAjQ8go5zILBoerg1uPWZ2zsfgqWPja6FOFDiiskG2GF4QM4sXUVVxDC/D?=
 =?us-ascii?Q?f/iITrRHt8g1iVlHdKeZez8Bv4l5/TOio2FsSDQjiZXiv8mTlR8wIvj9lA0l?=
 =?us-ascii?Q?yRFXGc8mqmgh7s6GLNunotbEj/TbH0pFsU+4sxMiVcVs9nB76yesgpsa6+2s?=
 =?us-ascii?Q?2KDvBzQ3XfoTpeRH9zgWDXShNe8+ljr9RiZzBUx3FFPMX9UPiprrrIZbRZGf?=
 =?us-ascii?Q?ifxiWA/EnV856f0+i3l//pmgc641eNTse697WlK/747+mqEIu9pvbt8EYxeH?=
 =?us-ascii?Q?ZsgbxvEDtJ4CsWPRf/7VAP2ajzRkCGTcOB7cTl3uDsel8DOh8HovybnNbDYM?=
 =?us-ascii?Q?u1aF4RuFTYMJbKm+r54UvKXs4DHN8IwJTdBVpnl4tMKP4M/D9g4BAJuuxiXo?=
 =?us-ascii?Q?pcIAGctejb3FbWTNWXsHTAvAnR572tAmmDUKmKI5vM2yjTiFqtXKfacxRhUS?=
 =?us-ascii?Q?dOu9MLFTtKGVDn5ipUbmUU8IvurW5IOgJ09Pa0AzxdPR3ogOWT8735A5/Jjc?=
 =?us-ascii?Q?EEYwDF98fnKH8SSMRGox1FfhtxaLodZn17r9CrhhcMiU1jiedfc6tS+bDtCz?=
 =?us-ascii?Q?VbGifLyJhkUUoXgFX5kU7LAHI9zJ8kkgk85f+RRBqLcSHJXicONjQTeL0tfe?=
 =?us-ascii?Q?zqNXziGZuJOQaZg5yko1ynnzxCnBqQZzVakYdMyp50+J23MoDvUSMkYfXsHO?=
 =?us-ascii?Q?FUXA8EikzZvW9OxpbCoYccX7H6uY+AjuDWRCzK0qUJpo+9Msrz28JsuBoO/A?=
 =?us-ascii?Q?pLnkbiclusEmyrFS8MFGObvUnn79XkeggYRmyvQWBZNv3bv7BS44YYY/Bm2g?=
 =?us-ascii?Q?jz7TD8AxBjYxLIA/l0nOUN2M9jOAzI90CkDBYSYqKfhh0bR2Te5oeXYhyPLa?=
 =?us-ascii?Q?JeE283IagZSq5ZD7MAPaOslFx07sdrOEn2QWbs9q53V6Mpj2Mk9MBBhPh5qF?=
 =?us-ascii?Q?q6fww0bA2I3KEens6YDsQiTCbZwYZLGENq5DUltHMSWhqvGO6wolVvZwgD9D?=
 =?us-ascii?Q?gQ6WcTe48NYDZGqkaAnHBpjevT8EcLPkMhXsx3JR6rU6paBZgxzX5LCMsf9u?=
 =?us-ascii?Q?3NAvYMb+rNrteN4VhzFdaKazQuRUhZb+MB/yDup3bDPokg2COefgTsurQ8gN?=
 =?us-ascii?Q?/j5MfObSjt/9IU/Stw9QeAQ5xRqPbRTwSoa2q60wfb5pm6xEsf8YV3IoJu3x?=
 =?us-ascii?Q?gULBu/M3zHvdR3cjncFTR9bDbTy4kl5JIwC/cBsVD+wcemrLTfO4AMB06KCx?=
 =?us-ascii?Q?5TQFMRK+HnGiWOXhGuC7mL58rZmtXjqDo3QF1HMMmuLetgItOhlxvwAVNnSO?=
 =?us-ascii?Q?gFRaTNAoGXJUqb1ABNDsf4SSPzi0QWEUtO7xvpbVINQlsdEjXliy76r9I5h3?=
 =?us-ascii?Q?EC+gofKybBh1LqCSY7knh8rC9Mtwk13HEBXSINiq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a99338cf-d5d2-41bd-ca82-08ddfb4bd74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:22:10.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlOtvi82aAzr6LQ4WwEBZq+WWaRpap2ySA2qWor3WCECKJBYChQN5bNek+8HsPuTEN9zOgb9X4LAnVNJ1rNAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 19, 2025 11:26 PM
>=20
> On Thu, Sep 18, 2025 at 06:58:04AM +0000, Tian, Kevin wrote:
>=20
> > I don't quite understand the purpose of ignore_mapped here. Could you
> > mind elaborating it? the only caller always sets it now...
>=20
> And I'll move it to the map patch that uses it:
>=20
> +       struct pt_iommu_collect_args collect =3D {};
>=20
> And invert the sense:
>=20
> 	/* Fail if any OAs are within the range */
> 	u8 check_mapped : 1;
>=20
> Its purpose is to micro optimize deinit, we don't need to check every
> leaf table to see what is in it during deinit.
>=20
> When processing map() it is not allowed to overmap something that is
> already mapped, so the extra checking is needed.
>=20

Okay, it's clear then.

