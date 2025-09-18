Return-Path: <linux-kselftest+bounces-41806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88FB83316
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2BA1C81471
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7632D9EFF;
	Thu, 18 Sep 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJiyngc2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77F2D9ECB;
	Thu, 18 Sep 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178161; cv=fail; b=hRCwyIylYo36uHes2L0TexZDfacMuAHC7GmtsxwjgG9m0iyDgZAAU3iZKxgdj+sX1yHvlNxvSv3RjPBoNsQjeDIlD2WCiHaq4St9Ifq+7OcTCslcawf7FIz+74tbVwVk4lbDBww92QW2RY3H5opHUMqtYeu9eGyFqSQbBOIfK70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178161; c=relaxed/simple;
	bh=I7/vHC+QnOnn9BGCs4TgBXQUmbs2jtGzJpNclkaDKLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kj9Xb9fzzK6GezyYPcOcbwrW3zaBwdPsozoksrYDlKFu4obeNnWDJWluemD4YTF/xhTXGToHVJ17oHY+9JcjHjj4HXJncpl8aLxMQe1e0OxyPRt93m7c6NhECH2ZeFdKGibfToJGnnQkhGpSebkEjstfxostJHFO/Bb+fqs9gm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJiyngc2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758178159; x=1789714159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I7/vHC+QnOnn9BGCs4TgBXQUmbs2jtGzJpNclkaDKLk=;
  b=jJiyngc20h4reXQN8jwHGbgCoc+RXKGztuMdhnV4Da/FXfzqT3H++kgp
   qbYfbvy30HckCOlGiKyxIVQUAeHH5xmXZU7+vEuoc6uYnjJFcwQhekAJZ
   s3Ng/zqpNeWvHSO3I1FKfJMlqh1BKGPOQvG354+6nCfnvG1UWC+vU1ThC
   MVMmWMrdUHvt/I2L+eNfOvRJzVurHZed6PB4b7FVaOVNldZXda1z4Clmu
   TI/cgQBUMlJSsQH7UEHrZ7pQtcVuGHz4xWarfGjD+jev/KMpUDewDLCxo
   prLHsDkBrnT/694O84KDlqIMIiXaOWYLdf1WIRfhqc7EyVFYFwV8cKNEP
   w==;
X-CSE-ConnectionGUID: gdYO3rvcSkKd8lrauZsFyg==
X-CSE-MsgGUID: 8UGw6C7oTRW+JQ8a1UXzfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71601672"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="71601672"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:49:18 -0700
X-CSE-ConnectionGUID: yb6VmCzUQNOy/p+InUk7NA==
X-CSE-MsgGUID: T/pFZwBXSg2ng60k+qykTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="179865932"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:49:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:49:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 23:49:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:49:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDbSk6g7SgKj0yaYQ2ptLhPoBgRhMW83naTdLlVmuFvuFSV/5dFiBhJ/IZW0looR9zfeK9Se2e4/e2VBE8TEFvi+3xl2UK9UFSqiRFWt5rQ5J7LM1dWlBzoiv1tgrmVNqVmlEWbTNY8iSAPcpUbZwkSyGQSoWnaCwUlzLf+Pi67mf6jg20EVqwaKgFS4sSJ0IKhF56HzQsKIgEP+OpTIjWMVNfZVLS4aMXCPcpNC1CIq8U3+slZp9DEYW2wWhHKq0fUXKdAbsMN2FS5fFzR+KcHrk3kO5FkggmXfcVBeOV8tr5oAi98yiRC3AGMrV9718wiWztJgFeVrvQv2ibJn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwTmrsuI7UVn4Yx0KXmOXDPS5G6TQVAQBy0ZxnD0QUo=;
 b=kn2LDwPotrIT1suDMhXPqWqtBlSfLPyUUSzTkNbBK1cRFdJHa9vX0q0dhINwa6bc7Pkg0334J9DtLqxtMWFP1QLCgRfUDfPzl1HEVkJviPHDaZc4+sW7lLuXXKuBsN7PghNn3+SEtNvhuxLpNCoXx2cM9BcSezm9g7sSoep/xeDxhIdurtheoHXfx+JFTnmvznwGa+xCWOiDPyc2T7brRy/g/QonCZrtGdG40raSwKK2kEeiQ6Q/+cSWh4bPZChtkQaCuKyTd27REYsjWs/ENxGo9mj2uddqPfF8sH0Lc8KtoXa9s9yzBBHHBkbEqQAGUGAE+meaPRaTuWlHlXUJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:49:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:49:08 +0000
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
Subject: RE: [PATCH v5 01/15] genpt: Generic Page Table base API
Thread-Topic: [PATCH v5 01/15] genpt: Generic Page Table base API
Thread-Index: AQHcHPrLfNePWPa2q0qW7OShpmqDlbSXCZ4g
Date: Thu, 18 Sep 2025 06:49:08 +0000
Message-ID: <BN9PR11MB527669A84AD24A550FDDD85A8C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5268:EE_
x-ms-office365-filtering-correlation-id: 289b0fbd-6bb5-442f-7e58-08ddf67f77ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?7foxUn8uYU675l3u9jPBCwvkromC6sGBhUA5lSrukJ/kZLRMLV7kZf3b04hm?=
 =?us-ascii?Q?eXWP2MQv7lyjUV8jeWzp/nnetjEr6RkVIQCCIDeca+j7HloncOmjtoslKIH5?=
 =?us-ascii?Q?uK4WZrqabh1C4Rbp4PeBH8WZr+TO80/YQ01fjI6gO2x+Sk6uycHgmjn+TuLm?=
 =?us-ascii?Q?8TMrCpa2Mn/bAyl1t6GzOq2/bogiC6OMSHkAvkfqFiAjWKy04NKP6Eg6cOv4?=
 =?us-ascii?Q?pvCpvamKTCEr1SMzmWpe/jO1auqp0n/13LcyzuRNx3N2aB/ZHFek3GZwUV6g?=
 =?us-ascii?Q?m1PX1YzH/AOeC+RAp6TrOHjSk/f1qmRUaoxawHMhM5OYkGjzZr2yxP7UfRe4?=
 =?us-ascii?Q?HZeR0l1wVSeiMCYHEBMKi7g9X3MzG9tLWbP9JN04CoMD5sY7SNL4jGs1lpP2?=
 =?us-ascii?Q?ctk2r34sGMCjmOqLnoTXPuGAt1/Ci2tHT6AwvyHjospHnA9BouEREIydT1sM?=
 =?us-ascii?Q?kXuuZjMim3frfHQVmRaPoeaxYP1F9IJIPt3dywZwiJmXEa3EyuJiX3UoHDlh?=
 =?us-ascii?Q?bpzNiNRoZqjLicHVZ1ZkesJfBpx7WDB3+KGoqjLRVm8C3tUccnbwCG5H8m7N?=
 =?us-ascii?Q?OQtzHNymrsHrcX5DkMrso4ujw8ZXwY8Vdy4QjNeE3qHJTAuR3zQu0yrEqxWH?=
 =?us-ascii?Q?fajXHEAruVXZKy0z354TISa0VezSVLoIuIjpJ2oOz+3IoeBOIeSgdWpM3ViY?=
 =?us-ascii?Q?NGw16YeLpI5n5xLkAanxN2REjVO8cWnkVo92yD/yLKgYpukThu2ZFioMxVvs?=
 =?us-ascii?Q?ooe8WUlDAahrhNviRxoIjqRqoy9n6gsu8L8tJMCnJ/e7snI4JCa5EMWyIq75?=
 =?us-ascii?Q?2EU6F5SPNBjaOU6Z4Tn3aR4byYxLR6WNNdWaa9Fzf7upEEJmj20nnYTIDmmI?=
 =?us-ascii?Q?yTEFmAmk8slXnKOxxN+TmuZVxDJ/7TM5oLv3Qihmmngw7N3oWv00TuOzH3Jh?=
 =?us-ascii?Q?zepVDoksyai+j5ghBVMWZ6gBDC3Hm8+gJFMHXEEekUvR2JEESfVKV1imqIbO?=
 =?us-ascii?Q?sAN3ASQKE2yx79NP21C+q4iNQBxKV02iFZwHZZdseqAdHKmN+bujHbUkvjtG?=
 =?us-ascii?Q?Tci6dpBz4FWgAr7jA9yasaGvGkOHuSHOLCWf1ZvJg6y9R6MyuAojn5ih8Ibk?=
 =?us-ascii?Q?2zmZUnRQejvEbZ7u5vodROPcD616G3a+Nfw/F7zXc3lvsaXijPMCzXWdw+MS?=
 =?us-ascii?Q?uhR95Mng947RAitdXrPnG9jTrRwg5CPVjSEZrJve+CaMCAVaen1pHjJv62Iz?=
 =?us-ascii?Q?HOTtlH6mEimCRQtAmp18dIA8nRpK22NZgtXOeJxY9O51DNCbLVcF3ZMhpL7c?=
 =?us-ascii?Q?Wg8KqZOTKz59c9UNktmyWYoihVvNdOu1mrxe7Vm3wTPTkrnI9+iIQV4tMeZR?=
 =?us-ascii?Q?BQ2r0ZnPr2CMgzpHSeok6fr1sBKc5nMw8/kEL50pqSlux25DISkmFbVVNeEa?=
 =?us-ascii?Q?siRHowm2q1ounHhV5sBVIMaV2+1Kdh2s/gxWxJGpkz1WvFG4jMN21lSDSOjX?=
 =?us-ascii?Q?eJI+hSXxk9G0W90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lDm++4mmhHrYIx7Lar5tfV8IY1auf70N8Qk1pY2QI22Z6zRjgpFn5p6VsNmN?=
 =?us-ascii?Q?FmCywbP0OEzx1J+nVVrX7Ot8yGUbwgnwD3AiVn66JSXwjaG/yMr5sw54cHd9?=
 =?us-ascii?Q?2l32swHs1m/jkX+7EC5M8IN1/xobb0vDZZEyP8fLLpFx82KC9Bh8mLo5Fk4C?=
 =?us-ascii?Q?6MNKFLXE/UPdLH/lRj21Nzrp9H0jvw986lf1YTfjdVvbJyuw3C1FkFt+apkp?=
 =?us-ascii?Q?+6+pKkXGsw+Tlt/snyt9LFRL4FOqMOFv3eKZMA739NDS/J5YD1M7b49qCi2Q?=
 =?us-ascii?Q?Q/A6v8WooMwCnYlY/ysmJLZbtgivXQT+wenntnXDLCLae+LV2InwAWFd/JU6?=
 =?us-ascii?Q?dNM2+32a8a4X9bymxVS6qzbvaLF5ch/qs8FqhG9UWXP4Kpue2vzAUTbNTk3B?=
 =?us-ascii?Q?Gr6asiQO/FtXBcGHguPGofp2zHB5eYPQZ9DT+1CrfC0f2I/UdRfJ181Z8RII?=
 =?us-ascii?Q?pk25/0ft8eEJ5Bc2hcYLkNlWRqec6edvJGon6irDEPNFFo+7DucCWOLq/LHj?=
 =?us-ascii?Q?EvWm6kv4NyJLG9ZfQepTUROVBtFdCejlAN5tRzvBMXoQ81ZfP0zuaGfSYfbH?=
 =?us-ascii?Q?19JhCZKAFZFJmt+PJQwPdPDQk58rKO8mefEJRd//Aud9J9oYfVI6rUZywYco?=
 =?us-ascii?Q?4gE/Az/Nm8zeBKKB0U/IKDDQm73lNc6ZKxA4bIds/w0gH4//CClDciA2shCP?=
 =?us-ascii?Q?c4aPaR/JWawSr0i/yuyo/y/WXceQ3hZAiVAHyC/8WfyxeWhSoWUSm1eYk53q?=
 =?us-ascii?Q?Pod+T2R4vqNPck8j2SjjuLaQq8kFxIcbj2Y8/jNgc573GnXxC+Jx7vkHRMnS?=
 =?us-ascii?Q?qBO3xCEYj4cGaKzB+GoZZ/K40pUR4xRSdWnupR8xuayJL3QRffex5LemrUrH?=
 =?us-ascii?Q?IfuZP5jyIEdf/ZuimA8AzYvR9Yb0PAAM1zTgECldpX50AE7i2Dr/M+PRKZ2R?=
 =?us-ascii?Q?b1FPCJYfvyao4aosCRvWvVGW/S1gipMjWrr3IGHuqpeFGPa0BjxzuFR5BtCk?=
 =?us-ascii?Q?tcsc6dp0w6s+002FD3vOGLmxUMoD8DlIJXtJ0iD3a/NWIi2guBJjvAHHwmXQ?=
 =?us-ascii?Q?JwA9G1vUe41FAP4ZZtBtorQYiqg/khb+Dy95VsASQ3KZ1Uwa4Cd9aXdQrh/c?=
 =?us-ascii?Q?CnFCy7YdmRBZuP+nTJiPleH7wBSQTba/sxZXjGCgqvhsPSL3pB7N8/pyW8ub?=
 =?us-ascii?Q?k62rTboBBdaumwTudpefHUR0gq0tyUi5brqMwMDVhHbFxaMrsv6fW6jlSA8M?=
 =?us-ascii?Q?Y47FQTJQ8vVJW1fAUQPez4saveuKnO5dnDqcR649YKZrbk5Pc9iQKs7TEsLo?=
 =?us-ascii?Q?HAK3aiAQkW4BHtBwc64pmoU4xyHKPwnyfjQ57XghAk9kjUycvfGuW1eVS7my?=
 =?us-ascii?Q?qlWebzZwf19P0TNDaC4LoLmeleU+UykQByFMEOcijkg/JQtlO+KfZWd1uTVu?=
 =?us-ascii?Q?ffVcnTN27JsEOAls3EfvczVOarz1jTybMoplS2Ms3mOtjkpFfKevVm1QHi4a?=
 =?us-ascii?Q?TKTTeDRFssl+XTDlxVgtGe45up27/o1z2pHm9BLquK/CThynPvpqBJuWcReo?=
 =?us-ascii?Q?lZ5yn+mLSSorc4pKmB4YZhx8qTZEwVkNHPtsk2IV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b0fbd-6bb5-442f-7e58-08ddf67f77ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 06:49:08.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGYVUccp8JJJBNlBlixONT6A9ZISAo62fu9VTpWcyQqWYToiMAk+scoyGVe7ldGWDRIfKvAUx9Xke9shEEDbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:46 AM
>=20
[...]
>=20
> This is enough to implement the 8 initial format variations with all of
> their features:
>  * Entries comprised of contiguous blocks of IO PTEs for larger page
>    sizes (AMDv1, ARMv8)
>  * Multi-level tables, up to 6 levels. Runtime selected top level
>  * Runtime variable table level size (ARM's concatenated tables)
>  * Expandable top level (AMDv1)

any more context about this one? how is it different from the earlier
"runtime selected top level"?

> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_common.h
> @@ -0,0 +1,355 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * This header is included after the format. It contains definitions
> + * that build on the format definitions to create the basic format API.
> + *
> + * The format API is listed here, with kdocs, in alphabetical order. The

Is alphabetical order important here? It's not strictly followed, e.g.:

	pt_entry_make_write_dirty()
	pt_dirty_supported()
	pt_entry_num_contig_lg2()

and several other violations at a glance. IMHO grouping related functions
together is more meaningful (e.g. dirty related) and less burden than
following the alphabetical order.

> + * functions without bodies are implemented in the format using the
> pattern:
> + *     static inline FMTpt_XXX(..) {..}
> + *     #define pt_XXX FMTpt_XXX

or provided by pt_fmt_defaults.h

> + *
> + * The routines marked "@pts: Entry to query" operate on the entire
> contiguous
> + * entry and can be called with a pts->index pointing to any sub item th=
at
> makes
> + * up that entry.
> + *
> + * The header order is:
> + *  pt_defs.h
> + *  fmt_XX.h

s/fmt_XX.h/FMT.h/

or rename amdv1.h etc. to fmt_amdv1.h etc. to be consistent

> +/**
> + * pt_entry_make_write_dirty() - Make an entry dirty
> + * @pts: Table index to change

it's about the entire entry instead of a specific index? if yes then
"entry to change" makes more sense.

> +
> +/**
> + * pt_entry_oa_full() - Return the full OA for an entry
> + * @pts: Entry to query

s/full/exact/?

> +
> +/**
> + * pt_entry_set_write_clean() - Make the entry write clean
> + * @pts: Table index to change

ditto "entry to change"

> +/**
> + * pt_has_system_page() - True if level 0 can install a PAGE_SHIFT entry
> + * @common: Page table to query

pt_has_system_page_size()

> +/**
> + * pt_install_leaf_entry() - Write a leaf entry to the table
> + * @pts: Table index to change
> + * @oa: Output Address for this leaf
> + * @oasz_lg2: Size in VA for this leaf
> + * @attrs: Attributes to modify the entry
> + *
> + * A leaf OA entry will return PT_ENTRY_OA from pt_load_entry(). It
> translates
> + * the VA indicated by pts to the given OA.
> + *
> + * For a single item non-contiguous entry oasz_lg2 is pt_table_item_lg2s=
z().
> + * For contiguous it is pt_table_item_lg2sz() + num_contig_lg2.

this sounds a fixed thing then could be judged within the function instead =
of
letting the caller to set?

> +
> +/**
> + * pt_max_output_address_lg2() - Return the maximum OA the table
> format can hold
> + * @common: Page table to query

pt_max_oa_lg2()

> +/**
> + * DOC: Generic Page Table Language
> + *
> + * Language used in Generic Page Table
> + *  VA
> + *     The input address to the page table, often the virtual address.
> + *  OA
> + *     The output address from the page table, often the physical addres=
s.
> + *  leaf
> + *     An entry that results in an output address. I.e. a physical memor=
y addr

"I.e. a physical ..." is redundant to what OA already explains

> + *  start/end
> + *     An half-open range, e.g. [0,0) refers to no VA.
> + *  start/last
> + *     An inclusive closed range, e.g. [0,0] refers to the VA 0
> + *  common
> + *     The generic page table container struct pt_common
> + *  level
> + *     The number of table hops from the lowest leaf. Level 0
> + *     is always a table of only leaves of the least significant VA bits=
. The
> + *     labels used by HW descriptions are never used.
> + *  top_level
> + *     The inclusive highest level of the table. A two-level table
> + *     has a top level of 1.
> + *  table
> + *     A linear array of entries representing the translation items for =
that
> + *     level.

to not mix 'entry' and 'item' in one description:

"A linear array of translation items for that level"

> + *  index
> + *     The position in a table of an element: item =3D table[index]
> + *  item
> + *     A single position in a table

'position' is called 'index'

> + *  entry
> + *     A single logical element in a table. If contiguous pages are not
> + *     supported then item and entry are the same thing, otherwise entry
> refers
> + *     to the all the items that comprise a single contiguous translatio=
n.

'refers to all the items"

> + *  item/entry_size
> + *     The number of bytes of VA the table translates for.
> + *     If the item is a table entry then the next table covers
> + *     this size. If the entry is an output address then the

s/is/translates/

> + *     full OA is: OA | (VA % entry_size)
> + *  contig_count
> + *     The number of consecutive items fused into a single entry.
> + *     item_size * contig_count is the size of that entry's translation.
> + *  lg2
> + *     Indicates the value is encoded as log2, i.e. 1<<x is the actual v=
alue.
> + *     Normally the compiler is fine to optimize divide and mod with log=
2
> values
> + *     automatically when inlining, however if the values are not consta=
nt
> + *     expressions it can't. So we do it by hand; we want to avoid 64-bi=
t
> + *     divmod.
> + */
> +
> +/* Returned by pt_load_entry() and for_each_pt_level_entry() */
> +enum pt_entry_type {
> +	PT_ENTRY_EMPTY,
> +	PT_ENTRY_TABLE,

add a comment to be consistent with following line

> +	/* Entry is valid and returns an output address */
> +	PT_ENTRY_OA,
> +};
> +
> +struct pt_range {
> +	struct pt_common *common;
> +	struct pt_table_p *top_table;
> +	pt_vaddr_t va;
> +	pt_vaddr_t last_va;
> +	u8 top_level;
> +	u8 max_vasz_lg2;
> +};
> +
> +/*
> + * Similar to xa_state, this records information about an in-progress pa=
rse
> at a
> + * single level.
> + */
> +struct pt_state {
> +	struct pt_range *range;
> +	struct pt_table_p *table;
> +	struct pt_table_p *table_lower;
> +	u64 entry;
> +	enum pt_entry_type type;
> +	unsigned short index;
> +	unsigned short end_index;
> +	u8 level;
> +};
> +
> +#define pt_cur_table(pts, type) ((type *)((pts)->table))
> +
> +/*
> + * Try to install a new table pointer. The locking methodology requires =
this
> to
> + * be atomic (multiple threads can race to install a pointer) the losing
> threads

"... install a pointer). The losing threads..."

> +static inline bool pt_feature(const struct pt_common *common,
> +			      unsigned int feature_nr)
> +{
> +	if (PT_FORCE_ENABLED_FEATURES & BIT(feature_nr))
> +		return true;
> +	if (!PT_SUPPORTED_FEATURE(feature_nr))
> +		return false;
> +	return common->features & BIT(feature_nr);
> +}

common->features is already verified in pt_init_common(). So above is
kind of an optimization using compiler to filter out static checks in fast
path?

> +/*
> + * PT_WARN_ON is used for invariants that the kunit should be checking
> can't
> + * happen.
> + */
> +#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
> +#define PT_WARN_ON WARN_ON
> +#else
> +static inline bool PT_WARN_ON(bool condition)
> +{
> +	return false;
> +}
> +#endif

Then call it PT_DBG_WARN_ON() to be more explicit?

btw looks there is no plain WARN_ON() used in generic-pt. Just be curious
about the rationale behind. Is it a new trend to contain all warnings under
a debug option?

> +
> +/* These all work on the VA type */
> +#define log2_to_int(a_lg2) log2_to_int_t(pt_vaddr_t, a_lg2)
> +#define log2_to_max_int(a_lg2) log2_to_max_int_t(pt_vaddr_t, a_lg2)
> +#define log2_div(a, b_lg2) log2_div_t(pt_vaddr_t, a, b_lg2)
> +#define log2_div_eq(a, b, c_lg2) log2_div_eq_t(pt_vaddr_t, a, b, c_lg2)
> +#define log2_mod(a, b_lg2) log2_mod_t(pt_vaddr_t, a, b_lg2)
> +#define log2_mod_eq_max(a, b_lg2) log2_mod_eq_max_t(pt_vaddr_t, a,
> b_lg2)
> +#define log2_set_mod(a, val, b_lg2) log2_set_mod_t(pt_vaddr_t, a, val,
> b_lg2)
> +#define log2_set_mod_max(a, b_lg2) log2_set_mod_max_t(pt_vaddr_t, a,
> b_lg2)
> +#define log2_mul(a, b_lg2) log2_mul_t(pt_vaddr_t, a, b_lg2)
> +#define log2_ffs(a) log2_ffs_t(pt_vaddr_t, a)
> +#define log2_fls(a) log2_fls_t(pt_vaddr_t, a)
> +#define log2_ffz(a) log2_ffz_t(pt_vaddr_t, a)

above three are not related to log2

> +
> +/* If not supplied by the format then contiguous pages are not supported=
 */
> +#ifndef pt_entry_num_contig_lg2
> +static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state
> *pts)
> +{
> +	return ilog2(1);
> +}
> +
> +static inline unsigned short pt_contig_count_lg2(const struct pt_state *=
pts)
> +{
> +	return ilog2(1);
> +}

what is the difference between above two helpers?

It's currently not implemented by any driver so will have the default versi=
on
returning 0. and it is only used by default pt_possible_sizes(), which then
returns only one page size accordingly.

I kind of think it's useless and we could simply move pt_possible_sizes()
here and simplify it to return only one size explicitly, assuming a format
should implement both pt_entry_num_contig_lg2() and pt_possible_sizes().

> +#ifndef pt_pgsz_lg2_to_level
> +static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common=
,
> +						unsigned int pgsize_lg2)
> +{
> +	return (pgsize_lg2 - PT_GRANULE_LG2SZ) /
> +	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE));
> +	return 0;
> +}
> +#endif

remove the 2nd 'return'

> +
> +/* If not supplied by the format then dirty tracking is not supported */
> +#ifndef pt_entry_write_is_dirty
> +static inline bool pt_entry_write_is_dirty(const struct pt_state *pts)
> +{
> +	return false;
> +}
> +
> +static inline void pt_entry_set_write_clean(struct pt_state *pts)
> +{
> +}
> +
> +static inline bool pt_dirty_supported(struct pt_common *common)
> +{
> +	return true;

should return false here.

> +
> +/*
> + * Format supplies either:
> + *   pt_entry_oa - OA is at the start of a contiguous entry
> + * or
> + *   pt_item_oa  - OA is correct for every item in a contiguous entry

what is the meaning of 'correct'?

> + *
> + * Build the missing one
> + */
> +#ifdef pt_entry_oa
> +static inline pt_oaddr_t pt_item_oa(const struct pt_state *pts)
> +{
> +	return pt_entry_oa(pts) |
> +	       log2_mul(pts->index, pt_table_item_lg2sz(pts));
> +}
> +#define _pt_entry_oa_fast pt_entry_oa
> +#endif
> +
> +#ifdef pt_item_oa
> +static inline pt_oaddr_t pt_entry_oa(const struct pt_state *pts)
> +{
> +	return log2_set_mod(pt_item_oa(pts), 0,
> +			    pt_entry_num_contig_lg2(pts) +
> +				    pt_table_item_lg2sz(pts));
> +}
> +#define _pt_entry_oa_fast pt_item_oa
> +#endif

I have a problem understanding _pt_entry_oa_fast() here.

Obviously pt_entry_oa/pt_item_oa generates different oa for
a given pts, based on the aligned size. why is it ok to alias
a common macro to either of them? looks the assumption
is that the caller doesn't care about the offset within the
entry range e.g. will do its own masking. Probably some comment
is welcomed to clarify it.

> +
> +/*
> + * If not supplied by the format then use the constant
> + * PT_MAX_OUTPUT_ADDRESS_LG2.
> + */
> +#ifndef pt_max_output_address_lg2
> +static inline unsigned int
> +pt_max_output_address_lg2(const struct pt_common *common)
> +{
> +	return PT_MAX_OUTPUT_ADDRESS_LG2;
> +}
> +#endif
> +
> +#ifndef pt_has_system_page
> +static inline bool pt_has_system_page(const struct pt_common *common)
> +{
> +	return PT_GRANULE_LG2SZ =3D=3D PAGE_SHIFT;
> +}
> +#endif

will there be a implementation supporting system page size while breaking
above check? if not it could be moved to pt_common.h

> +
> +/**
> + * pt_item_fully_covered() - Check if the item or entry is entirely cont=
ained
> + *                           within pts->range

when using pts it's more accurate to call it pt_entry_fully_covered()

> + *
> + * The system is divided into three logical levels:
> + *
> + *  - The page table format and its manipulation functions
> + *  - Generic helpers to give a consistent API regardless of underlying =
format
> + *  - An algorithm implementation (e.g. IOMMU/DRM/KVM/MM)
> + *
> + * Multiple implementations are supported. The intention is to have the
> generic
> + * format code be re-usable for whatever specalized implementation is

s/ specalized/specialized

> required.
> + * The generic code is solely about the format of the radix tree; it doe=
s not
> + * include memory allocation or higher level decisions that are left for=
 the
> + * implementation.
> + *
> + * The generic framework supports a superset of functions across many HW
> + * implementations:
> + *
> + *  - Entries comprised of contiguous blocks of IO PTEs for larger page =
sizes
> + *  - Multi-level tables, up to 6 levels. Runtime selected top level
> + *  - Runtime variable table level size (ARM's concatenated tables)
> + *  - Expandable top level allowing dynamic sizing of table levels
> + *  - Optional leaf entries at any level
> + *  - 32-bit/64-bit virtual and output addresses, using every address bi=
t
> + *  - Dirty tracking Sign extended addressing

and "Sign extended addressing "

> +	/**
> +	 * @PT_FEAT_FLUSH_RANGE: IOTLB maintenance is done by flushing
> IOVA
> +	 * ranges which will clean out any walk cache or any IOPTE fully
> +	 * contained by the range. The optimization objective is to minimize
> the
> +	 * number of flushes even if ranges include IOVA gaps that do not
> need
> +	 * to be flushed.
> +	 */
> +	PT_FEAT_FLUSH_RANGE,
> +	/**
> +	 * @PT_FEAT_FLUSH_RANGE_NO_GAPS: Like PT_FEAT_FLUSH_RANGE
> except that
> +	 * the optimization objective is to only flush IOVA that has been
> +	 * changed. This mode is suitable for cases like hypervisor shadowing
> +	 * where flushing unchanged ranges may cause the hypervisor to
> reparse
> +	 * significant amount of page table.
> +	 */
> +	PT_FEAT_FLUSH_RANGE_NO_GAPS,

FLUSH_RANGE and FLUSH_RANGE_NO_GAPS are mutually exclusive but
one format must select one? then we could just keep one flag (NO_GAP)
then feature off means FLUSH_RANGE.


