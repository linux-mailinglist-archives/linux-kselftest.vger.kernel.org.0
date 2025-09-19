Return-Path: <linux-kselftest+bounces-41917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E15B885FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D893A9A10
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D313C2E54A7;
	Fri, 19 Sep 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzNnXqB0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C562D3A86
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269800; cv=fail; b=th8u2msrQZFsF8nTUovdMkrNyRhtdJzNBMS4uSYSRxANRFIUgrooCxE6Oid79PEKR/QYgeAqpLcNb4WP0thSj+tCfu7LxT63qSUdthkyl++nzSpynnk9ev1WAQ+mLMeQ+9mOuZt9x6LfJX9tsnjb03BSm0NTI2XQmC/IAbZXsuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269800; c=relaxed/simple;
	bh=rT00wrG360UHff6BYYJBBPCRBsmEC+2qP7iy0OODD4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WvIzdXV8J+/mJc9kPgxIHerCV5vgLm36IxD2qpk5zMvWyZ66SYorNBc9Yi0WBSzW27vAfj2+Sqgx/zj7PtfruUREuAT53C3v1ztoEwFFIyVuQ03L946Re3+CfTKL9JzTbyXSQWRoDY/UmK02X4QBepMMH2jBch9eCMk4+LDVhkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzNnXqB0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758269799; x=1789805799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rT00wrG360UHff6BYYJBBPCRBsmEC+2qP7iy0OODD4I=;
  b=BzNnXqB0ZYa31xZksb0yRDO6A/PsN5KEiBumx/8KgdFJhcozSFv/0Hsj
   CXxLp/iz/wbk59mjMBRfXfY9IjaPhN9odWQMakjQYntKr3/olF5zJAMMM
   IFb0Vp6EdBX4BqIv1ZYTojtA/IVmGoBrtGRx+J63E5YRB+OoJYSWRi6RF
   iesGOCp6RUHb/V8ewI+z0XIJ3846bTRcoYvpRooXBzYSRDqEVXsd5LFq4
   SDxOs0057uXRJk5ffnbSzR+pQEXHbPUpON7PfkCEkVF8/bYc6TPR/QLhq
   8jRDNhG1XZRglhhoIWG3ZrjHnKPg4HFpd1xie4eqgLZ6MQ8ph3d/k4lvd
   g==;
X-CSE-ConnectionGUID: V+fygZxHQG+SxptrNosT5g==
X-CSE-MsgGUID: +kIRdY+eS7SpzhV1TWVPDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59833700"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="59833700"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:16:38 -0700
X-CSE-ConnectionGUID: O/BcSp+rToiEPKqSyhq7Wg==
X-CSE-MsgGUID: Dpgxk85bRoiu5XJ+lybaYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="206721259"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:16:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:16:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:16:26 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKlnnvVkuA7cZJjPNcWPO2AtJSKgsEzqtMnu3WSHp1x9alAQqfxKBhSkanslRNjJodeIe/xAj0wHp2ordw54hKzD6TQ2KL5hf+8vVufkCyvJTYW2u52/B6yq1CM9iMqjeuGL5D5pz7gdLebz/AHTosOX5BEOP8VaikI1V4EsQDy2rupMUBixfBtA3nvIDWNq5m0f6+SPEAXX4xClg/W6EDufTD5/GwBNyo+T175vnSZIIK6K3A308YyKyYEH5MrXrI0d2o+RKEV3ROupOL+PCIf1uCzdByefKJz9EdM2d2rJHAk5j8H+2JWyUu4HsUqd+k1G0ZL+4bnt4BBQv4+U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsC1aNnTvjPF2z9n+Z2KaHGkgqPSpzVNk22DPgnIWeg=;
 b=qQAYh0XJNT3tkkcGadiQBFOENw0Kseo+ShSdQR1v2v0mato/RitRZoOfWg9XCQGxeynutcUyhXJ6Cg63CmPsMVK90W/H7BsZJlDxM1xEoybLvh2AxPcG8ym83YhktAEDMzct1d535Z2JltefpbPZOdA80WUutKiofuxy0VuIXKqp7HqNSXQVp68qbIUChmfOakGbmwcQrQRESZP+NCJrRZC2G4bPK3SvwXRRyr8PbokEuJtRWTtfBQhYDkbVP8QHzW1KVIqxP0+GtKcKnUY/9rg7ep1oRv5SXOSEW+3S2TIezDVDXstjJctnthM7+uZOfOQ/b/no3Pf440YLlXWNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:16:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:16:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>,
	"syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com"
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: RE: [PATCH 1/3] iommufd: Fix race during abort for file descriptors
Thread-Topic: [PATCH 1/3] iommufd: Fix race during abort for file descriptors
Thread-Index: AQHcKA4TqDOlm8lOH0SfJBLOxMHGfLSaKxmQ
Date: Fri, 19 Sep 2025 08:16:17 +0000
Message-ID: <BN9PR11MB5276152E660B489C4C5313C98C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
In-Reply-To: <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5796:EE_
x-ms-office365-filtering-correlation-id: e7011e50-21ca-436b-8f32-08ddf754cefe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ucrRze3qzqQldvaoYYuF5XJEAOpNYiabIUFdFy/xUJuComywUWdZgCVnIPOu?=
 =?us-ascii?Q?LNzH1ichmLnrMj3N8Qy8MGP7r944Vb6B0K9BVFrA9Qj3Kz1s+cQ1x9P6Y+D9?=
 =?us-ascii?Q?zFWiQdMcGY4QppDB+t69Fs+aDsnfCzvl1mpJphTnfsQHRlCYVY7smGO/RG/V?=
 =?us-ascii?Q?pEk5/Dz1LP3PbKvOfDhIvzmjQtbqapLQr4ghWyzMkV4aLJt5oA0D3rlgbNVK?=
 =?us-ascii?Q?4o3En/9y52dms5K649tOCsRkPjPNQfo01fX/PvG6LAxWlPh7D8eb6NEgHXCU?=
 =?us-ascii?Q?eYTgwMYBMsH8GyFXdFZhRthzBuba5YlKXr2pgf6Xrl4DeWiPWoBjjfKM6KUc?=
 =?us-ascii?Q?/8VRKOAfC2BvuBrm2RUCOoRPd12dag7QqLp/FqJRnoXdZBF9uyEo/rSkuuBM?=
 =?us-ascii?Q?91er6vkfDY5YjoV2Ri8ND29HvCyL/qQX4DOnmPTUjdjBgWs0WJdhaN7WNo/k?=
 =?us-ascii?Q?UVoADbWWOde3Y7ImweWTS8RSMniLqmwxMGpCMVP/Mc3WQkopB4TBiCsBKdzt?=
 =?us-ascii?Q?dDuFJuOG42TAf0V3U1rmIOlvfhAJ+2UhxA/BxVZMYj0IWYa1k5w9tOokaazF?=
 =?us-ascii?Q?bIFRlnHE3MvpJlIutyWgTfzhSECUeq8fnIIdsyysChPaiQPY+EcuiYeuBbbd?=
 =?us-ascii?Q?f8F6ZZ2NOgdjMaNjYOW2lWMbqI798bsanMOSdoVhLY24AeDk+dYD7o6EoQi7?=
 =?us-ascii?Q?3Q4lLbQ/NF5zD6HBXVJNXUB08NraKGL/8DHd2kH4i2zQ3uEgCiiUh/5p2q0N?=
 =?us-ascii?Q?RYxf+U57zb1hl+4oMc8tAscjWanmpoqtV4q6KWSiJLucMxRhimSRvNGBwQdq?=
 =?us-ascii?Q?xOZnmpOe8Bt+0fcYgCEg94AweiFI7qxcoll/qgvqyuiGEDzZceQi6eRfGvXY?=
 =?us-ascii?Q?ohHYi+92OVsGDJuvyvwO1LexiXcU72RsjL1850cM3oIVFEImosOF/fSvBt07?=
 =?us-ascii?Q?OzJ74nbmugMQ+mRTRhTEgByWZpPfN/Ilxsg52qUPhRaM+bM94JVMUQa7erwM?=
 =?us-ascii?Q?rjNp6LMDYQ3wid/M5KuswUDLd5msiG1hMsQbkj4ezRLHjTyYEgqGMJhHmpms?=
 =?us-ascii?Q?vp99gx1plKABqIC0bAzN+BdMR7d7V8b/iRhhVkV1h7gInyOohNetxC5DH/gT?=
 =?us-ascii?Q?f5DKIi+qvl8W6p66MLdYy+HJPqi7JNaZ5tccefLB0uTLQH4XUEDaqxmesrLz?=
 =?us-ascii?Q?H3xIwTfRULqJJoJVi96cT9Hfim/TCYgYu5Ca6tf+EQI1wjFfcGV6XYW5Ubbd?=
 =?us-ascii?Q?GDbM3URWANaNPQRTu47oJXdTPepknJzJvwMYBm8Rwx3+hw+eBbJViDRp03UY?=
 =?us-ascii?Q?mFT2imS2U0bxw6PKamrAWpWjONv8akn0FedKraZZUIeHCb+aiin9CCXq0mKU?=
 =?us-ascii?Q?LAKxP/J/4+LGO32b7oUHnOpY3c7rOvM+CZvsub4wM+LQbmCDSz/t/70VORZj?=
 =?us-ascii?Q?C3htPKWdvtY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?STZd2iSFBbZcM14tKY5hPK3pg6ISEfbLkv7/wccEJF7yVBPZg51+13asFBAq?=
 =?us-ascii?Q?HQsGuvzh5APXbYDPSH5nLy6BmndRtEI9CcCdgTEO6fOmwzCjHTtKJ2TY7Msr?=
 =?us-ascii?Q?j2wugcaBWHl32BQYXUtrJsEqTaTKccOc06QVRUFjdCWgM2k3iGgN3xLFgtRA?=
 =?us-ascii?Q?L4pl+PrZilKRo/+i54z3Sl+oQfNp2jEz/o3QLbPgpLy1b/SjLboSRW1iIiqZ?=
 =?us-ascii?Q?k0ozI9KtIFJ+kAEQAiwEWm6bVjm2Z5R4CxOkFipd2W10E6MbRXQ1w11yvetp?=
 =?us-ascii?Q?/BjCcnC+cJrmraZ4axMmqJCzbt1CV9UDQmUWgpGwLz5Ca65eQ8/B0yywbQPK?=
 =?us-ascii?Q?n4c/x0UNMx8hJeorK8ALh/SHK0qgpVMKMv6AK/qH+E4HzjlL5Dg4eSV9oQ9K?=
 =?us-ascii?Q?slnhKfBOe47QxpLfN84jPi3a43ZFstqHDEQffKjfYRG0djGOg7+HRaMfi7m6?=
 =?us-ascii?Q?L4jAOQ31erL54qXg+1pYzGlUwWHzst46peXt9mO9OKitUpEBpv6sLbsWUglB?=
 =?us-ascii?Q?YfElbMY4U6WKSUf8R39UqXaNuIMyiL6O3i4rc0g6e73jLuzN0fgtigXeQThn?=
 =?us-ascii?Q?dafN1he2X3L96AW+TdoaIQ20VqisWdhGhMtqjWXl8I2wStopBupd56RSI6eM?=
 =?us-ascii?Q?U6PWfJOckTfh8MSaXBLiyomZc7i7az9qPy7AKYGf1jjz0BJaAf86fJ7cvdV2?=
 =?us-ascii?Q?DNH77/znq6ci1JhFvSIdLwNrfR0AwsliPqLTNAiX80b3z2bAPICJb2lzicV0?=
 =?us-ascii?Q?GOidIrhiEpxgAMiA3O8YzlxBVwWsUkBCvp+X/Fcuh5EZMZQgqi1xf/UAkSfs?=
 =?us-ascii?Q?nvKtpDy+BihtUsQq1C8w3ht8zdd+aVaKkBlVrYfabd4UEUiFdnJqdtBG2GQw?=
 =?us-ascii?Q?lP6L6Zpsflt/qdxeCTDVbdc0g8Y/x4jJUyo9WQSNaHanQR0UYCqH58ngy6ZB?=
 =?us-ascii?Q?0d1dTb3l/D2QLu9uDrN2kp2cTZrpDapK7xZuz06tZLzMPxuGKgUvaF+LwvHG?=
 =?us-ascii?Q?N04FP/JJ/Ay77h/HQFKEQ8pAd/7cA1D9Dr/aJfXOZZ8IGCfnxQ+IFGcS9qPX?=
 =?us-ascii?Q?iyEpcHwTvESwqL3zeKXE4COIfPCTosJSmrbIrayjKSyl2/hzO+RPYh3ShdzT?=
 =?us-ascii?Q?ZG7uLX45hJyQQ5XLUb5yg7e8XcvUcUBTxa4303Pky3Eiom5W5a6iYjpHBIIO?=
 =?us-ascii?Q?bI3nB49gMNKqELak29aIDK887U/et8fhRs+0JGVSn4TKVT5XbAV9W0+auUlT?=
 =?us-ascii?Q?NFpuI+FMQvDg0z4P4XHljyAUr9KO6//t0kvPgQuq340tnKLys8ALxbsZE3Rt?=
 =?us-ascii?Q?Qx5Ckj1E6u5HzCJoG3W2cXKLA0niUxZ78LUKmsU85wK5VD7WtAyehLx3NuQx?=
 =?us-ascii?Q?DMgRCQjU/91t3vw4FIVS42EM1BmlJCoxRkfI/ACgoKNfxBYhLQuEsO7bA7I0?=
 =?us-ascii?Q?L1lJ7rtDLljp39ewoDQLct/lvHcOnZqwakZ1cBAdnJnhPNMlpO6bFsuxSeIH?=
 =?us-ascii?Q?oLD7MNKHeXI9W749iFystmLuJVdrdzxd2U9nkeMMShRmC8kA4dvxIjW4i5YL?=
 =?us-ascii?Q?NQ+5s2ZBdmecP7snBGkPKjOBHl7w0xMeRvfOP7W6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7011e50-21ca-436b-8f32-08ddf754cefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:16:17.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/mdCA40Sy0PgmVoxN6OQiFfCGYcQGhFdmoLt+LdyT7R/OqP9joz/HiMa/tolZFnKSQfYuoqgooz0/K0hxi3iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 18, 2025 4:02 AM
>=20
> fput() doesn't actually call file_operations release() synchronously, it
> puts the file on a work queue and it will be released eventually.
>=20
> This is normally fine, except for iommufd the file and the iommufd_object
> are tied to gether. The file has the object as it's private_data and hold=
s
> a users refcount, while the object is expected to remain alive as long as
> the file is.
>=20
> When the allocation of a new object aborts before installing the file it
> will fput() the file and then go on to immediately kfree() the obj. This
> causes a UAF once the workqueue completes the fput() and tries to
> decrement the users refcount.
>=20
> Fix this by putting the core code in charge of the file lifetime, and cal=
l
> __fput_sync() during abort to ensure that release() is called before
> kfree. __fput_sync() is a bit too tricky to open code in all the object
> implementations. Instead the objects tell the core code where the file
> pointer is and the core will take care of the life cycle.
>=20
> If the object is successfully allocated then the file will hold a users
> refcount and the iommufd_object cannot be destroyed.
>=20
> It is worth noting that close(); ioctl(IOMMU_DESTROY); doesn't have an
> issue because close() is already using a synchronous version of fput().
>=20
> The UAF looks like this:
>=20
>     BUG: KASAN: slab-use-after-free in
> iommufd_eventq_fops_release+0x45/0xc0
> drivers/iommu/iommufd/eventq.c:376
>     Write of size 4 at addr ffff888059c97804 by task syz.0.46/6164
>=20
>     CPU: 0 UID: 0 PID: 6164 Comm: syz.0.46 Not tainted syzkaller #0
> PREEMPT(full)
>     Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 08/18/2025
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:94 [inline]
>      dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>      print_address_description mm/kasan/report.c:378 [inline]
>      print_report+0xcd/0x630 mm/kasan/report.c:482
>      kasan_report+0xe0/0x110 mm/kasan/report.c:595
>      check_region_inline mm/kasan/generic.c:183 [inline]
>      kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
>      instrument_atomic_read_write include/linux/instrumented.h:96 [inline=
]
>      atomic_fetch_sub_release include/linux/atomic/atomic-
> instrumented.h:400 [inline]
>      __refcount_dec include/linux/refcount.h:455 [inline]
>      refcount_dec include/linux/refcount.h:476 [inline]
>      iommufd_eventq_fops_release+0x45/0xc0
> drivers/iommu/iommufd/eventq.c:376
>      __fput+0x402/0xb70 fs/file_table.c:468
>      task_work_run+0x14d/0x240 kernel/task_work.c:227
>      resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>      exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
>      exit_to_user_mode_prepare include/linux/irq-entry-common.h:225
> [inline]
>      syscall_exit_to_user_mode_work include/linux/entry-common.h:175
> [inline]
>      syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>      do_syscall_64+0x41c/0x4c0 arch/x86/entry/syscall_64.c:100
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Reported-by: syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
> Closes:
> https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a2.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

