Return-Path: <linux-kselftest+bounces-46318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED5C7D2F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4343A99DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA223D7D8;
	Sat, 22 Nov 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQh4f0sM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350A19258E;
	Sat, 22 Nov 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763823402; cv=fail; b=fYlBRM2L63hS0/P18yR51bo7BCxtnvVgwb254rxDludTL3O2FXuyCza+1xZLanmxtbcmXgP+T6JZtxcpLarM6C/yJPlAL5y1UZFUDvUMOaAUTXaSBLvbprdjIsFNK6BuJCaQ9WgzB65V76TcAJIKZRTLja5cY7KKsMPKERvE4Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763823402; c=relaxed/simple;
	bh=AJPrMzkDnLvyKtGGSUjMP+WD09MDcJojvkxgmB/24oU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dEr3anBjT5GELuH2IommQO7AralCr0x9JUtg09sIfohs6pAQvjvOKSLPgsWA+CNWStYmMtbGDkhTn3Mvgz7fu77kFiIj2KEsUP815T4P1yHZLddV8AEiT5T/CiEqAH25nqsk1B/sBQJVVJ3GbB2I/FCe8z2Zo2LN1ixZzrCnzCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQh4f0sM; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763823400; x=1795359400;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AJPrMzkDnLvyKtGGSUjMP+WD09MDcJojvkxgmB/24oU=;
  b=SQh4f0sMJgZFxXdZWpqH0vBbP3q6O94dr5HWH2gOJ8z8qlrxO2d7ZMHT
   ILyve6PHqGOjbq2SavomqUir7k9VQiuUTDTLeRboe5eBOjvo9RsqfRdTk
   FghpJsLpGXIapSkDencAL8gHBvxW2Xq2epVO77pK0bqma57OX2n6xF4BB
   /6HEJjjj60ddTWk91rjCe8sStayq6dxFYIM0IpxfOLvGi/6Nlnp/flOZ5
   vIhJm65Sp+zpo9PmK7wCdfNygAkBlyAXw9Kd/8W7pRXQ1aoFD7Nm9wiFD
   zVBy6QiIe0yKeRbr5qa+6EEdl/xjtEOkC0aZWOcvt9urzwG1wiJODRx0P
   g==;
X-CSE-ConnectionGUID: j14qFdfaTvaHSWa0pwCIqw==
X-CSE-MsgGUID: bNBd9aseRfS+nWmRuw6+Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="83514413"
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="83514413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 06:56:40 -0800
X-CSE-ConnectionGUID: C55tmzJISMmOQHlGzFavag==
X-CSE-MsgGUID: axxQ8XgqSfe7GkW/9ZlO6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="191718713"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 06:56:40 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 06:56:38 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 22 Nov 2025 06:56:38 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 06:56:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIffCOT0OZOqvNImapmhZL5GSfBq3q0peqmJYA/QsgME110Sa76aKx0Xtan7MbJY01LitioHHi8Qu1erPYI0ewl30kplGhwEYV6uqT1/NQ5mYzJHzKNDNiQcm9RCqo9qK5MwJCWcOPOKmKhHsIOXhWcdS5ClB3ROrMGBLjNrbA3PPadci46+PmScEQhpcuchSiyeusi7ujaAQxQD4jWd2JcybXPVcPpkZsnlpdH42kr9TNnDDZ+Mrf1wlePVyt1EqjAZjpIAsjwsVWXDHRVTALE34eLmfIdENgH4DYmu9Zby8RuCBYLr0Z1mceK9LUyijwgYqeCuH02+xgfdLsbw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5vRE7dgpri2oOMOcB8glS5PQ4+FcU8KxD3Vg1HQ2uc=;
 b=DIyR7/ueLkd4cwrUvhZolwU6qle6mP51MkPEYj46xoqLfqzcbjvZBMOs7DUdXWrF8V4I49IEUupMGR0DKDknseoIfW2ssT+JQqNL30nEwD//cFQFEiXS1DwrpBCSFHLEpY8C8EIOKVbHy0+QvMfWqOv0G1ILp2ZMEOeT9GVsKClXVosUyIoLAeBh0bw68DjNs+ALawStuwAlSdjDwcp60eDoIARrk5UQ4Dr9wQ2l+SYtGii4ewM0/uOZusXOs3NXd3RHkAqRwZRMWcMuu/xgBdfWFI81R/r58VFwBA6lil9yVaeUeFRhP63AlOcZDEFqDtNbKZiqcp1JNf4aczPeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Sat, 22 Nov
 2025 14:56:37 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::3876:1eb1:8e84:84e7]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::3876:1eb1:8e84:84e7%6]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 14:56:36 +0000
Date: Sat, 22 Nov 2025 22:56:26 +0800
From: kernel test robot <lkp@intel.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
CC: <oe-kbuild-all@lists.linux.dev>, Alex Mastro <amastro@fb.com>, "David
 Matlack" <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Raghavendra Rao Ananta
	<rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 07/18] vfio: selftests: Eliminate overly chatty logging
Message-ID: <aSHPGr9evRIaAvhD@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251121181429.1421717-8-dmatlack@google.com>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|CH3PR11MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: c318da88-9427-4729-7d37-08de29d755ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0jZJZ2dGBby3PaAi7gKKRK4YbPdpXoJW+NTJcX+whyeuR1B7cqXo4uLmt9?=
 =?iso-8859-1?Q?FDVMj/v+Jg4FSKyhgwpNrO1Kgd+Tf+Lycs/QDI5lmQqUsmHZWueuQTz78u?=
 =?iso-8859-1?Q?e1pfs7MVTYZvclP2MkExijGgrcLrmXLJoiFKJEUZS3AZBMHztgD1waqCyS?=
 =?iso-8859-1?Q?scos/ZrpgTh677xylOx2EfiR5Xp+pXXiQmrTQTUM1SmSJaSFuFvQMf5iJ5?=
 =?iso-8859-1?Q?qnD5+FrtfJYjE/MzkVbglDUo0KmPDiW78mKUcJ2joJgkdiRg/BbOjbS4Hs?=
 =?iso-8859-1?Q?SuxWps5ugytRyCDFtEHq7I0mJxoKrm9DRmbdXFeg0FjIYswsmoCIWQdCpT?=
 =?iso-8859-1?Q?/vN6PH6w+e/gdjWIGHNsBoh2CEYa5+BoYdboJI66jIioTR36H4Nn6hocMA?=
 =?iso-8859-1?Q?DcI8XK1j9mFb9EeNWIfX/WlaY5sz5XDLBxrZyngFvamKN6bMgr9l+AGFcN?=
 =?iso-8859-1?Q?UyzXUsGUFGvRJCqNXAiqnVwrNhmIDoSrC6JW9ztT9aCfLEPaKoH7R630WQ?=
 =?iso-8859-1?Q?3IveQ97ZiH+6gOjcQjC9gM5eDZTh6kfW/BQ1GkIo0MLZoKeinYL8VWjhzt?=
 =?iso-8859-1?Q?42BX6QPiNqzLTKYxX1D3nhazyvLdcQoBJosAQf7yTOdOLtsKnuPjBSVS83?=
 =?iso-8859-1?Q?YHUZ2DKHSmMLh+R24Xkx9XB9HQlxlBKyjSu4iE/p7jp2DQ9CVjLxAteKLf?=
 =?iso-8859-1?Q?dWOtAp677WLft67sZZr9pqmpdqJma7X5E0dVG8wrr7FsroVa0rtmbx/JrO?=
 =?iso-8859-1?Q?IEv5aEOdVNCLUEImSiKYLg7fq8YOnisrxtm4xGmio1obdbumzf7HKOYQyq?=
 =?iso-8859-1?Q?C1yPK48QS5Ap5mNIujhcl/WFo0/Tp75nI1IPWDR1LxwXDpt2nEtC9ChOLw?=
 =?iso-8859-1?Q?MJ3dWkd5BeoIneopsYe8Pe5fvTQyWM6i4yLboSJhc65p2Wm83XUUTjfMbd?=
 =?iso-8859-1?Q?nKd/CXNwTjt+IX0MZbyid1lOWrQFEJiun76yocOiHWFsegNPCbWtjrtVrP?=
 =?iso-8859-1?Q?I9nUAuX/wRYEJS1McieAbWuF9QwduiNxY/JJ6beD0nfgybk/vx95UPBPjv?=
 =?iso-8859-1?Q?XhWyjXvydXGCbEwGv0bYmGj2tmwBenDJkIszWp8k1Q2LAx9A9oeiBtPgYq?=
 =?iso-8859-1?Q?kL2TFj+cN3hnI6GVxhcETpKcSikGvjuRF1J5v2Elrt5M4LuocRAqkUTYE2?=
 =?iso-8859-1?Q?h2pRXndS8YUt5Znp9HCZAoUTFShNixiyMZ7U2KpLTkRED5TBpEudGqr5D2?=
 =?iso-8859-1?Q?l/nn/CmddkCbOchyndnIxFca1VznmWS5zcQC7M72hS38oaCALIqYhtpPl+?=
 =?iso-8859-1?Q?Dn2ug8EQfFW7KE1xCCg7eUvygF5KA6b0P5fxlmyn3NwKiTA+7MLphMMrGU?=
 =?iso-8859-1?Q?XoSrDLwjPxNVDFc2dUwwtMp71SrBtV7B/Pi6nY0bNUHflP89SqytiG3NxP?=
 =?iso-8859-1?Q?p7IIqkzJrVVgLDjAmCVKAtcx9hr8+ZJvm/XIFA54JY9ss5DQcOA9OnEuLk?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vfnO4jqPedbCfWOrfATQ8GMR1MG/ry/ZMYKjqTtH2TOoFM+3OHvxM9S//x?=
 =?iso-8859-1?Q?ua1c3I3iczfPwDUOper+iAFdzWYTvV7peNMIcnLvI/YClm9FbKFJj6ZArg?=
 =?iso-8859-1?Q?n8XRsxzX45Je3vIFScYaK3BY0zZZr5wNa7AczO+khqbOCCm+5qPImxWZ8s?=
 =?iso-8859-1?Q?Y0z7LXiyQB+xgcr+oiytqyv7ikBEHPg91RC0EtVzXEH5X8kb0ABgrYDM2i?=
 =?iso-8859-1?Q?W+FS8r/DLZyvGMyF6BTmU/v/xBfaCVUdmy5/iyHWVdG2b2GhHC7fHDp+Bk?=
 =?iso-8859-1?Q?FOuwrJaqab+O74nPiHLiNL9uTbBXnLGAS1DSrgnb3l/ZS5fGwXYa8B1RyM?=
 =?iso-8859-1?Q?Io20QYrPa1Q1L/onDq7ScRPMPlvi7YgfwvQHeHtynokbIAnvejIkbo1JTY?=
 =?iso-8859-1?Q?XWfmH6+Kt+61wOmTrO+4DfCZYDdhNAU+FPz2yTBWvk8CaA5eFxLgJ0k//K?=
 =?iso-8859-1?Q?1m+96Hyhxa1EwncqlfrvY76nPT+mYGIx8aDlJ13rPfHmNIX5wA6WgLEFhY?=
 =?iso-8859-1?Q?c0QPoPM4MoeWH7LfwsmBfC5uJbbvw+9waGx7J4AGojOp5uI5zwJiMATtEP?=
 =?iso-8859-1?Q?a7Saggmwin9GTpd3g7Z4iU4ECOMVgNDVSwqg9BcqiGA98gVRL5CpO63Fiy?=
 =?iso-8859-1?Q?xvD3jG/dZr41973yv/9gZ3TeQhRBDEP2PcgrxJBmZbW3VtkjV/2hS959Wt?=
 =?iso-8859-1?Q?XnBYCMQH1xK7Ns/mBFSP4JDi0xxFjCq8gyiZLXgTVK4Q/ygh/OYEkoUhda?=
 =?iso-8859-1?Q?fXF8nri5c76LM7fI3dXEhmENZDXPPzNY7vgX2QSQgnBoKUaV++gvnaefnc?=
 =?iso-8859-1?Q?Nwyh5rRPqlG7wcepMbjLG/OWjpgYxHng02qSajuxLffTYShzn21pXy713v?=
 =?iso-8859-1?Q?nW2NHIXkdWvUFUhW5o8CIhmS2eDFOXdFG6d+JUQks/ebnV83ISSHfYJaMq?=
 =?iso-8859-1?Q?GZwXVuJCNH6xi2LDpu+i8CP8nEx0/iSO1D1VCp458tuUtKmKWJqpSWESXY?=
 =?iso-8859-1?Q?qr9Tc9rTHUYgINFuo4ZhhN8IRx48hdu1z47dcsITxOcGoen+iKfIYTUlLe?=
 =?iso-8859-1?Q?JRvKeyj1NvoBgXb4Q/ZgOwLCG82AIr4oD4ITbP049Dv3yYY+A8Lh3L52jw?=
 =?iso-8859-1?Q?FtNWcITbdhIRp7EakqzmeAgQDlp80aDQ1wKP00yDoqDmOMrmsSg6nCEySy?=
 =?iso-8859-1?Q?jEWjA/Qq3tZ6IlZJnXPrPcT4vi1aOXrHLGaQVZelkBpl/uTgeflG7uN1wt?=
 =?iso-8859-1?Q?1Gb99L4mIcgUTnQfKSY7D5EITLkjaWWq6RZCGT3EqVv1viPK/RZTEEv/Qo?=
 =?iso-8859-1?Q?nifc2EUfx2akpqcrQWOh5hL/7fEmk01T92t9jNztv/mlxG1m8P9ATwd5HZ?=
 =?iso-8859-1?Q?3UD7vHfNoqBHV/7gaGnLlVJPC1CgqguIK6svuHL9Bc7MCgbB/xe3iGm5Tf?=
 =?iso-8859-1?Q?E3Wmu/NIvz4LojTwV7iqjOu1uTwhv+txiUFMqkX8vtDu+FJz5rRCmEvYTA?=
 =?iso-8859-1?Q?qynWWPHC0HS7Lzr9NmvyRW5IQvDPaRzhfDvrfE/2VM0d+IDB6sgJcRSg0A?=
 =?iso-8859-1?Q?1JIUpXci9i4JG/SWnE1SwgxcLvybKOLgfNtzJKtef8NAZBNh1//CBt94u+?=
 =?iso-8859-1?Q?sIfhqH+IToCaAGyjkKBT1X6EV0BHzF2w3o4WYYgvA5dlLDXq7wS42CQg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c318da88-9427-4729-7d37-08de29d755ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 14:56:36.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd14w9AYbIHGtdLuNNH5PNr4ahI4Em3AVE9zIVYyzHVtFWWuG9IzjaWk62/e7vWU324v56w/lGHdw5ehgYK5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
X-OriginatorOrg: intel.com

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Matlack/vfio-selftests-Move-run-sh-into-scripts-directory/20251122-022109
base:   fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7
patch link:    https://lore.kernel.org/r/20251121181429.1421717-8-dmatlack%40google.com
patch subject: [PATCH v3 07/18] vfio: selftests: Eliminate overly chatty logging
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251122/202511222214.BiU6tURK-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511222214.BiU6tURK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202511222214.BiU6tURK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from tools/testing/selftests/vfio/lib/vfio_pci_driver.c:2:
>> tools/testing/selftests/vfio/lib/include/../../../kselftest.h:53:10: fatal error: errno.h: No such file or directory
      53 | #include <errno.h>
         |          ^~~~~~~~~
   compilation terminated.


vim +53 tools/testing/selftests/vfio/lib/include/../../../kselftest.h

7fb2c3ea28bf7b7 Shuah Khan     2014-10-03  51  
9e38be732da8fe3 Mark Brown     2023-04-06  52  #ifndef NOLIBC
fc2e634e997d84f Aleksa Sarai   2019-07-20 @53  #include <errno.h>
7fb2c3ea28bf7b7 Shuah Khan     2014-10-03  54  #include <stdlib.h>
7fb2c3ea28bf7b7 Shuah Khan     2014-10-03  55  #include <unistd.h>
151b2732111f074 Paul Elder     2017-06-28  56  #include <stdarg.h>
f2662ec26b26adb André Almeida  2025-09-17  57  #include <stdbool.h>
907f33028871fa7 Mark Brown     2023-09-28  58  #include <string.h>
a18261d71bbc625 Tycho Andersen 2019-01-18  59  #include <stdio.h>
6d029c25b71f2de Oleg Nesterov  2024-04-09  60  #include <sys/utsname.h>
9e38be732da8fe3 Mark Brown     2023-04-06  61  #endif
7fb2c3ea28bf7b7 Shuah Khan     2014-10-03  62  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


