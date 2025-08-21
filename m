Return-Path: <linux-kselftest+bounces-39513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A188B2FD7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8E26417E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A72857D7;
	Thu, 21 Aug 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+tuCDRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37407285063;
	Thu, 21 Aug 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787454; cv=fail; b=clFkm35FDS8uKV3VOtbrCVRcu3kZ5VlS1A4eOUhxJKIlskuEUMrhcw1idmakV0t5rsjGi/OIAfCDi+1LCvMNe4qH4vQvSb+K4uv/8Tg7ddHdkAmeAjlw2Mgh1XeO1RXHqPkDCPv96ArpZC6cVoft4Grp2SxTgh2Y7lsr+w1tuDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787454; c=relaxed/simple;
	bh=RSro4ysnc0KO4HWuP6bG4boRLL5i5o3+rVtSU2wvXTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O2QWOmBvYOR1MBPRxcjv4g1XzcN3AuxDAC32ROmVNZPQt3ftIG80aUgv3giQhOzu30t0um4rYfb/p1NO5FxAWet9kf+Fk0AFq++EP96hlPTw8rG62LGYgKkM5lHhiTFyaxaIN5yI4ue+wuRRYx6GalBO3fSOv34xVZYk1kRoPGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+tuCDRS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755787453; x=1787323453;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RSro4ysnc0KO4HWuP6bG4boRLL5i5o3+rVtSU2wvXTo=;
  b=l+tuCDRS7lxTyBRrGMcKWHmiauEzuS6MfnQU5us1RHIvqhPLHHDKmyNV
   CpN70J25eQi7cHy9mcGI9dvQc7QF56XVJLh53KcXtcMzMID1qLaYdqYyW
   QDPwGBU3rYkJe7zhXwCYhgoL2ORogXjbYHeC7IFYVstl7QKPA91jp9Ody
   XC6DgtZ4THO9eWpDWoKme5CHF62nqyVwFAd2JgqIzYMIRmZgN7hSfhkPw
   LV0qyC0aSEhdce+XAOdksRR9aPdPu/AJwdd+a2J1v6zNMKaUHgOLqt7Z2
   jCydJOwK5d1bdwfw1Dla3VyTaSrrmeJblQC1Vh/yBFbuwKN/Ilz7AaGct
   A==;
X-CSE-ConnectionGUID: PCXI6rYnRlu8T1hHVq4MDg==
X-CSE-MsgGUID: 7q0rNttKSLCPxf/mX3sAng==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58225553"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58225553"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:44:12 -0700
X-CSE-ConnectionGUID: bJAalBsqRAenV9zIF18d6g==
X-CSE-MsgGUID: A7/ZKew0Q8Wa++k3XTr8XA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:44:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 07:44:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 07:44:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.77) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 07:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnriOR3PGWvTJg3Svpc4+1llakG6Y5YsJCdiCQomu73NBQQ2NPvyq5TTFGS1NjBX48e6vplqBon9mP+awW5MogLpXjQX2Rw91tRsoM/SrqdiNOuS6nHtYTGrVdKdbl94qzZPi7l0sTtyIQ+ApL5qPrXzPGarPrH4nJrTIltavfWo4E636yVeh/Ko8cL2wOwE56M6DbXpqtWw38dOB109i/WhiV/DhIftYbSV+C4qPp9vvazlls0eCZhI/NTIYKhkIVvEWNK5qK+qHxgLn5PfGkA/yZc20/Bs1BsJUsYujuTevdASRo0f9Y0hnHnogWXgCkdQBcp1cEjLv2N0cndaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdkx/9krGh4gWpxYv8qouR14lqQ/ubL3OoD3ZRIxjFo=;
 b=HKkn7c5p5rdzCmSifNJHBIUEV/BLt9Ls1pVKGgbbpcSDJGSF3u/Upzdv8iLhbnTui/V0stEkp9VyHtFz1pgFplMhAtbqT7OHwY+XGrlu6v9ZvVgbr5MHfDSa6/FGUPBl8IswmFoEbTJ/+3bNQLjvLay9KsmGaBeHuKaieK6eEjfn1bYD2ixmp7SFBR3iBu7EJhbiZOGNmXPhtW5NqRA2D3WrF1ZaN4qPaSzI5N5A015FnlOi8PJIxr8RcY6SjF21Zbp+soA4Db77w3z41Vx5JNuM2ErSZtOYo7KNBVAb0zIvfjSukiwTRMb7lZ6+j7M3WnDjWCYSh1uvlDeyqHMOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM3PR11MB8672.namprd11.prod.outlook.com
 (2603:10b6:0:44::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:44:07 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:44:07 +0000
Date: Thu, 21 Aug 2025 09:45:51 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 02/19] KVM: selftests: Allocate pgd in virt_map() as
 necessary
Message-ID: <68a7311f91bd9_2a6d0229463@iweiny-mobl.notmuch>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-3-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-3-sagis@google.com>
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM3PR11MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c06bfb-d7fa-421e-bab4-08dde0c12e60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJsoCpS45TaFRrxVbH4jpFsYRBl92S/w7c5Ta74AAb6emWt6WxbyLkStS2ws?=
 =?us-ascii?Q?baY+WVRu4W/GK9CPCCRSUJm7xeza3XXm/YyvZ9olOmJrfMC64QvV1OBh2uJs?=
 =?us-ascii?Q?pVayS67PddseL2wucRIdXW5MqoXuWKK5PQhtawEpekkPH9YTdxRxJ7Wu6nak?=
 =?us-ascii?Q?nPKD0RB9m0EXHIshjKiyCBalospyWc2TYeaR//IlohA26WYvQDaAId/LXpSA?=
 =?us-ascii?Q?9K6rFTGxN/FGK3A4GyKJEn83i6BNfsCtzqsCrBBtVKbCU7gGh5+sPsyQgNEQ?=
 =?us-ascii?Q?/20paxNyAGzzoT0wSWhXaM51lF4q/nVAIVG6DQJzYvYihU/LtsZwWb0OsN5H?=
 =?us-ascii?Q?6MLvo73xTQCqqTtDIicyUd1beHg2iESZ/CLHuRfckwjhMDiqonglZXTJmc71?=
 =?us-ascii?Q?xnvoFXIBdGxpKZSLksBeSJhedKZg6IGeHsVVjQrKL8efjkVnV5FTMHAWOS9d?=
 =?us-ascii?Q?ei4Fq+/e0jeP3AE87vRNlhMIBmw90UQDvMelftoApan+mgz5aRUk6oEyjQ6X?=
 =?us-ascii?Q?kfCdY+UfYvwT1jWDoJBlwNAaxQICE/b5+ui/GTfKSmCw5GastU/j1kvVS1qY?=
 =?us-ascii?Q?bWS9gUqBytxl5Mud2R/l3XYKFdgd7CO/GRDEka0XWLY41gHvHWEw4ZQUWKFA?=
 =?us-ascii?Q?f9U78hlfKzGsgmZ3T3UnlbYqG3FXeqgXYW9G5jlT7eAiBwBXk0fDgVVK74Yc?=
 =?us-ascii?Q?eJ/i7sKBH54PHCJ6fF7G/OiZTthi1mv5tP00GH/2D/1EoC64pqKkT0JxjPuT?=
 =?us-ascii?Q?uOLu2X1kEE78S2aXgz6UKYVE89EegLnc652z1BvEnQ8J7tLqlWb2DP2h0VQB?=
 =?us-ascii?Q?Ez8v3uCnH0t3z+fHYJf23hJOYa7lLmOy428bv4tY8S9wCa9H6kFfoOPRqtd5?=
 =?us-ascii?Q?u2kXzcgFzQIFuXvHznoc29FXBZoh+HpuFHLQKSYbWW7KVROxs3VPZBLQZagI?=
 =?us-ascii?Q?WYZ2XXX7m6ggLiV0nXbpbbyAoYm+Ffx1CICTOFmbRDNvxJHmvlWaIRLL4P6l?=
 =?us-ascii?Q?2WQTHanU/ihWxYP2O1R5HPdU4eo8coEHrJQJMuNF3b/2HInk39v1LPc92aVG?=
 =?us-ascii?Q?ygAW7kxWPKBtbCpgSqiuOQigeZOXBJhMbvqQzublFvM4Vqh9+m/2fCUjs8jI?=
 =?us-ascii?Q?+cPudZlB5L9+Et2q2bNaa3njmbI5LlDselOnN9qJVKNRe1twR/PBM2SUgEVQ?=
 =?us-ascii?Q?nuCd4n/zMmQtaUSDUcM9+QWUE4vEq+JuPtGyo4QSiYt0rJsEgjgIs/SeimTr?=
 =?us-ascii?Q?cSUzbMmicFIPDBflOO2Yg+iGWGh5eq4muoD+7aQCMyJAOPPiddu0Ui0w2HlM?=
 =?us-ascii?Q?AN5IJ7YIG/0l3DmCnUcQG+CZZWCv3mFQ/FY2U4Rk/YT7fB5mfAQxN4ydQ7it?=
 =?us-ascii?Q?GaTL/Ikp5rMIru8vMFy8Q700r4zOZwC8hbaO1uBPNdJF6pkK3qC757xJEJkx?=
 =?us-ascii?Q?jotsXFeGIC2FBDLDLMYsdPdYmi1l/9gi7yXV545w1RMZkkEHpyHb5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OmpUn9u2euuRYa6XvJgoTIJOC9MYj7yaGF7Yi1wjX2zET4FCdbpdQ1P1SaOJ?=
 =?us-ascii?Q?VuVd4BJcAPw+A2plEDRLSlLcMhJJ+GaKS9LwArY5NMLGmOq5Qc0xryRTGNrJ?=
 =?us-ascii?Q?2DXFSt2gSZEODDtowmvd1FWn/a0i5AElEn6a+5HbxO64nADY4QtK/dxmqSd9?=
 =?us-ascii?Q?0ewe9xuNKolLpM9SUFpdekmvTfx6j3eF6nFBezDIJfVBlavgSvmheFBjZoZw?=
 =?us-ascii?Q?wJvSMxgYXe8AUDfMquoMgdPVnooj53KpgyK7uDczFXRKoyla42aoRD0O6JYI?=
 =?us-ascii?Q?gB+au1Qrmm4/6lf9cx9HMw4cIDzHU2xnV5FU06bNPGBJLgmW3Newu5eeoti4?=
 =?us-ascii?Q?NItSUezYGmWn/Kj8pzHoskxdE39NklH/6gHsfasE5/hixQPIuNpdgxPlyY/A?=
 =?us-ascii?Q?DcUBqic+qcDP/umhggp1I5JnsdH2cQXTVZQfoG8Ljr5R6migcs68NJbfAjm3?=
 =?us-ascii?Q?js7Uc5A7gx+42kaKyIRXuCIb+ewNAK82k0PQrPBrKv6JWEGiDJ+L/J1WoLyX?=
 =?us-ascii?Q?bwO7C52KFzajD/0vqklBoz3Av6c6zo9xEXr9LbYAzKOp4oIARsbtHbprr95K?=
 =?us-ascii?Q?LOWoJJfNhRhVmSGCpLnoa4XGU7ERYQna41bcRoiUtyZ1gadKWvlRSMeJ7Ebt?=
 =?us-ascii?Q?ur8S8udQRDEYufXMUC9yHu3fpflGUt6hwwZd7CUsHnWd3WlyuP+UVdxyHPGX?=
 =?us-ascii?Q?bzmjCZ9PFByvHHzcWE0zPMyMEkjzn/YUeVxhRW1lyFuYJnqmuMnfK1b2eoax?=
 =?us-ascii?Q?EWj/vpPAyYMiW1P9d35Ux3jpu+xSnYxCvBFjh+s6jM9b1X7tIYesJlvgZX1d?=
 =?us-ascii?Q?iDTdYQ6vQUUZhajI+coOuceUV3nnArJ1jmQAM9cc7odSyvuW0peCdRUS0jF5?=
 =?us-ascii?Q?hbahqPRAVbLGpo5swcXWEM7r8uUgeHlNQukHrN7EljoWr9YDOCqGIb/h1mH7?=
 =?us-ascii?Q?HVDye9HB/xBNH14szUVvBDlKQtA72wjm4k3mXrJKDhnZrIvZdWMNxIxWJbC/?=
 =?us-ascii?Q?IuNBc4Ud0XI8Cu0Ejz73o9c5lsBYzNHyEOTHNs2eIvbdutad5arig4+xBPO7?=
 =?us-ascii?Q?5crGe4cHwEKFcSMrP+N115IPfCHiZvtbIo3MJJ7K4VVa/cgOJ4Fc3rFNAA5v?=
 =?us-ascii?Q?Hb7R2rH4DraGwmkLJ2UJKJ03/ZSc+aY8Ql+SXfJumXvMb4fr9RbpHwmY9wgx?=
 =?us-ascii?Q?KmRT1lG6i9sxrWm4CDusLtPscry2AP+zrAwseCbc6mICwE3srlvUUzAUeteW?=
 =?us-ascii?Q?Hl/4TQL539iR2jAP+DFxrKBBhJ9ygIFEoCN/7fEMwJEH4P/V5Wjw4XWKazEn?=
 =?us-ascii?Q?RQop6JfBMHogIFCjOmnvxG+Ip90gzYoNzUArLmqry4HIwvqYZw6/EUL+leHk?=
 =?us-ascii?Q?0F/WkTYBUGMtolqOwkYvJRWkNwURoYPRjAB34Ct1sVh/CI1/8Fl8vWnyW4Yu?=
 =?us-ascii?Q?DL1n5GTXlzG/XDyWXOio0VlfvcYRivoiWTV7ceghCIK5omen8TnYadc9mWBm?=
 =?us-ascii?Q?fnSl66xnEDGehZGOColYN1kRa57i75zX6lZo9baTC7ap+kwyM2wgRCpxptN0?=
 =?us-ascii?Q?VuCs+q+2bP93MyalSelnCm7asuxoFJAIQq8Q95dE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c06bfb-d7fa-421e-bab4-08dde0c12e60
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:44:07.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86LRPQ63bT7jJuf7zxcpPNPBkAMwVf2BVhFr9xWuQJOkpVJ7Fzi5te7Kmi8yVYZtPqDV1smIn2DaAToEFkuXsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> If virt_map() is called before any call to ____vm_vaddr_alloc() it
> will create the mapping using an invalid pgd.
> 
> Add call to virt_pgd_alloc() as part of virt_map() before creating the
> mapping, similarly to ____vm_vaddr_alloc()
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c3f5142b0a54..b4c8702ba4bd 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1609,6 +1609,7 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
>  	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
>  
> +	virt_pgd_alloc(vm);
>  	while (npages--) {
>  		virt_pg_map(vm, vaddr, paddr);
>  		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
> -- 
> 2.51.0.rc1.193.gad69d77794-goog
> 



