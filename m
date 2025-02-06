Return-Path: <linux-kselftest+bounces-25942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF37DA2B1F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F6018893A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E91A23AF;
	Thu,  6 Feb 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPbtAWJs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953F1A0BFE;
	Thu,  6 Feb 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868943; cv=fail; b=ioYNsmAyJmXE+mw3cpH6cV335sjaK3kKeE+YTgnAVCddOI2Y0jRy4wRBGFAGM5T7ero8nKMYmMwatcbQo+WljsPABccrNcXIqAxuhiBrZdlkBzxZ+/N9VIvY9NOu+I1f/TnweSgO71a6UAfRpkbJBvKW7YrMbNcOIMmyuKOEgZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868943; c=relaxed/simple;
	bh=IOPob5NC2+6vqemUOlw+NklkRLlsGAuRNFyIGIVTpA8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4w/wDGZAo9Vki0A6obzqnK3Z7N9c8mZXIeE3kTc8WqD+YfrwP2vPi6mPPKcpDep3ApOO+avWLfJgFTwKJUmdZg2Blt1fUzpJcyKDuKlQat9R5VrEMALNCOIXhKMiskX9URUaJh8kFflsORpfms03u1xLE3133VZ0emnMqtU8Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPbtAWJs; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738868941; x=1770404941;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IOPob5NC2+6vqemUOlw+NklkRLlsGAuRNFyIGIVTpA8=;
  b=GPbtAWJs5h/nKmIcv8gJUt6juJAokXY035ZvFxhFN8Jxpxod6RkyQJB6
   3NTivxYhgDH8AcGmPs0Yh9B/5LZShD/Rs2EN4fl8XQaMX2gaur/q9O/y6
   9mPLljTHy6tl1Ep1nWwZvQEhWMLXYQ3WRWm2PWcw+ZW7XrhDSByJGpHE6
   yExx17eWGNSmBQNufwrsvb7aSa0ChKt/TPX3r4Cd9rCKVHVb+JrXJvhHr
   FzoNVRE/fmB2bpHr6hsMcth3JoF8rq0Quvt3xYqKxlOvnHDAk+bF7yd+e
   EIuy+ePWKZBEixDlhQ6/PZoJ1VTWr494ah8ATd3qRMn4FS6DyJDKfPHSn
   g==;
X-CSE-ConnectionGUID: jNOkr8wqRiGX4ft4IW8tyw==
X-CSE-MsgGUID: rGWrQ5jmS5CMcgpyg3yZ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="57034488"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="57034488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:08:57 -0800
X-CSE-ConnectionGUID: StFZ78iUQf2s9kxt1p7hcQ==
X-CSE-MsgGUID: 8ExAbR06S9ufCQZEAUDTTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="111223885"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 11:08:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 11:08:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 11:08:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 11:08:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+xdml1s3FA/fkuuBT6slzBcak1LKKMZcw7iRPJ5H8sFqGhBJ6qABN/POSeeKweABagoMZUnXxjngd5jQNKLTxU/xgCRUjI0xjmWzsqvmLSmGIefLpLiHDzBXpHynLEDRuoc9gOkjOeFhRklq+3H2qhyzEEhqtDq9jgQeBERq4WCEoV8IjOBA1dax5epRsqKmyK3nbmYJ7msGob/aSgrQFvtJM5iF8AHLnXfNcsIkP2UAZxdMohRdXD10t6XhSe0LgcA4kQL5m4UMz3vBQCvOk9dNmGia3o+zkpXK7HbmA634dFULFfhmkaKM8huFF1uwpfNRLxRsOyaJtVC7sxrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY+oBevItabcdfnhSRgANYSWH3DJXEo6/3BIy9qdG+g=;
 b=f8hN+HNVZRmZq7VbQxiOdP9FxDNdL3y3jGH/Vlga9FW8vZvrz0HDZjUnNEOz8NRTOzkedtJ59xtt2Pu4s+3KjWd9c+4aEKtPchtxQIp+S7ca16tM6Uo2UAWuo2IK9USb9hcJdKCIDWQnBxRa8Df+ePR60aHZDkxQhk2neOeCMU9H1IqWr49+0+sTQKPmLQDHYCelERuFdQbcJL+/y5NLA11l/1+uWbVrshUa877KwVS9FzpC3cs+pkizPP/EboYRsKYTfSbkofRZ8dpu3/KREOk50HcMxSw8E5iFK66sNTNA37ZnNij2rnJ57NSZT4NUtt3l/KyRy2/a5qbAlguPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 19:08:34 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 19:08:34 +0000
Date: Thu, 6 Feb 2025 20:08:24 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, Florian Bezdeka <florian.bezdeka@siemens.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Bjorn
 Topel" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>, Daniel Jurgens <danielj@nvidia.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, Bouska Zdenek
	<zdenek.bouska@siemens.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <intel-wired-lan@lists.osuosl.org>,
	<xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next v9 3/5] net: stmmac: Add launch time support to
 XDP ZC
Message-ID: <Z6UIqPt+Rkpo5E+M@boxer>
References: <20250206060408.808325-1-yoong.siang.song@intel.com>
 <20250206060408.808325-4-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206060408.808325-4-yoong.siang.song@intel.com>
X-ClientProxiedBy: VE1PR08CA0008.eurprd08.prod.outlook.com
 (2603:10a6:803:104::21) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM6PR11MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: ff45fa80-df34-44b4-06fe-08dd46e1a743
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tha7+iQpCNysFNgZQH67qiXhET0Kho3mIckv9uyU3mruK8+aeG2S6hXBtgLb?=
 =?us-ascii?Q?8GzpkcmyVcBMh8B+msOuASN05GD1aogEIhY5RHI1XtZLm5wNJPsCZ3gnhTW3?=
 =?us-ascii?Q?g9KY3qAeG9KF+kgk7Iw/UQnpSttR3z7t8iwPZCI/gEKs2c+aFh5VrK+lXzg8?=
 =?us-ascii?Q?+zat8njSheKtNy8aMPaV+kh4LEelFuif1Obda2b4DHvMwTAp9sjuJBZgS16c?=
 =?us-ascii?Q?iM0ovBLd9JhiRYAQlZpMFRTrI9y4sHKSRgXxzozmViCp67RoDL4D5LKOj4Go?=
 =?us-ascii?Q?J7WqFuzUlqKoyG+Ujp99PNzLmyaBa+z0rLrM/8OLs5FSTvydy425CCEdjAJT?=
 =?us-ascii?Q?fqgbfoMA0CwFaH/k1yxx4UHCUA2OHhvRApXETChgqSKL1JFQrqBByvBE27nM?=
 =?us-ascii?Q?Ne3Evtl1nnJbmzmneodHsZwx/2ANRBzdosihrjDw3opZkPLImT/ICh6bx7FU?=
 =?us-ascii?Q?26IIcJ0jfisavwnxErrKShNbYwHOx1e7Z7BkEMB0soNmhP86FylLfw509V9P?=
 =?us-ascii?Q?FsjW+zVYrI/VpH0nPlMVldmFnHjlDOQ6B41t8nKbZU/nnlnuLz8IgiykCW/c?=
 =?us-ascii?Q?m+GeoXxDVsv//OoRxtYQomkRBxlO6l8xtoiGJ5SyXS/pUKF9cGdHJ+y2V1n/?=
 =?us-ascii?Q?2FLJz8Jm9IoSOzqdwAYuFijB55s+FEo3de7+fq4bsbmLETUZWnsPFEyx4r4m?=
 =?us-ascii?Q?J0IOaH8EBBG9iaiwI91KD4EaNpU5pdgY/zvd1EfBbAE8osdsP/Obe5eJq+gh?=
 =?us-ascii?Q?J6Ib3nCaDIz12vfdOGmyEtKQTaefGghMblX3ECtJgsD/mgOPhSDCO1NLOrY1?=
 =?us-ascii?Q?/4TN8109fQlp4+tpHpuHZpy+8OJsjT8Hq3p2LT7/oYrP320mdfdDlaRRpkDE?=
 =?us-ascii?Q?1EJS1eVw+qqCdkxKgzFKy2GI1gFGhH6xRmp+St8VPVcv5sSVpRJOA91NIXDF?=
 =?us-ascii?Q?NUL3BtlF3Slm8U9xK6KgTcWNT6bM17t27tMkHkl9xQo08fOiRDRnxDW/Dz3b?=
 =?us-ascii?Q?x0pijtJOyq73BnAC8ixKoMre0CdMuHdjJZV3szQdVLZ4yUjfBgXKYORQ9Lws?=
 =?us-ascii?Q?aA6vrcohyCTg+mQ9vcyUFV0j9o2gUey0ah/C5q609GOloaCTvba54/EEN3rj?=
 =?us-ascii?Q?48O3chWqQUbxFFbNAKnFC/TRJg2LKoL/iZOuD0hFJDUMfk4SV45E9tvnluaN?=
 =?us-ascii?Q?3nY9u97lbcMvTqPa6y8kUoZPeYrRqnEoemVhGXy8qvFQlXQ8cdqjumTx3Ljn?=
 =?us-ascii?Q?FCZPmOyhU72/PslQ+hP2kRaTo+CXstGTLn5NxEwoEP91EYR8vDVItgWHGL1O?=
 =?us-ascii?Q?UFE6D6rvNOAz0WmZzrIA0Ky6umeY6bPZs67g6TlY8GW+aCG0wvBHjVBgJmxq?=
 =?us-ascii?Q?3xHgQFe4FL2MCBngpp4BHwynGi29?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7obZ8BAVdK5tU3p8TsYVUm5fF+T9tBYW9ztw3ykJQ9zQ+S3Pn4M6ooztvOrd?=
 =?us-ascii?Q?iX3PN/ZE8opoMmIpd5I1lWtAgj4FFADHtQldY0YvVMIDmx4rVOC5ZLwsLBE4?=
 =?us-ascii?Q?q7805NjY4cqPZBKzAhNEBuNdmJUq38flsuKTmy9usJ6SVnwbMDU6dfepSw0S?=
 =?us-ascii?Q?eRHXizGkTkqxyMrGyppR7j5fPQsVNhIqvKEyMAbxggqMunA08acR4wSxZWqv?=
 =?us-ascii?Q?v77W0CTsqtnXrLy6H/BxJCDdRRX2GG03/5e7PrRowwztnb6zV6DGYv0zzm0p?=
 =?us-ascii?Q?PeGVEvJu8JXSMPFogTY3PNO/Dc07wkYHoLV5Rd7EOFcZmsFCenc1b9EsZMFE?=
 =?us-ascii?Q?mMc/OVRbPTtHnMh0GTKbOZxZS/IpK6hUQ+YrIqKGaZNpAfonJH7+7FGaPBw+?=
 =?us-ascii?Q?69HSe9dDxx6OiAQMxUmsM0djA9+rEOXijTqb+CfFlU7Ot0kQ9L5DwU0Rg5ZA?=
 =?us-ascii?Q?em5/bT9Jeg+cBMnWqOLGjfgkZIxp2y1UkLO+geM3V2bW9jLPLCWvEnme/wnu?=
 =?us-ascii?Q?pnDMUH9GDbEV5sXYttI07tscKv84BrFQ+TmiSbFiKyxdIlqCjVH0sa91uuHv?=
 =?us-ascii?Q?LtutikWnnjJYSQMhgZT5nH8Y84Iaso17D9SLNTu+2+CTJGCyAGlQQ0Enhbjv?=
 =?us-ascii?Q?Y1+2JkcVlhsRGTQyu280Vp0sxdCgUNKNJWCToiZPA7ZlnJCTGNWZprF7z0Qp?=
 =?us-ascii?Q?xcqMz/pmBd+GAILmAC5laDO3FD7TNj+8fLByd2dSf7JLJNtxtyeO1xMQo8ol?=
 =?us-ascii?Q?lKmXUSy4iDlsAcSXxgd/yAvn+coliw7+QqaGKXYzl0j3OIB5joFVeS84e8J7?=
 =?us-ascii?Q?iFppifRxiACUA6uL0Th64tQ0uaBzdCBSJ3CdcSSvChESPx0ANe3XyD2lYOfA?=
 =?us-ascii?Q?VrIQCiNfyoXOwhrTDMzXgGUCGKZ36Su4wnYOYYFXo9kfK8UKPhj9KMq/aGMT?=
 =?us-ascii?Q?1GtfZ38OwUnxBNC4Z9iioth3JMVcIUaQf7/gtpKAsvm5vkp1UUPnzk/9MFAK?=
 =?us-ascii?Q?QHet9teIW7o/eIGG4HD+mvHK9psff89BnZQFwiq3RA6GPwFD3jxerlxsU58Q?=
 =?us-ascii?Q?Ct87AaRfXERhWrMqh3bq7UyIISQBEa/CT/Bd685qCTjLxfA9F8lfMybJyBUW?=
 =?us-ascii?Q?4+93GqBktF5suQtspol0Ho3Xwb3BOVpWWVRN4gU4aG9+JwJJ2EsYheCORan+?=
 =?us-ascii?Q?bptMahYgMEKN917MvZYbBOOzhXVF9XCKvvO92dJjg92JnuDW7HlImwTU5AdU?=
 =?us-ascii?Q?u+1GBrsFupVs9YT0vkaCT81ojH31tU/aGEErz6GJAeW2AVcCv+ihixSf40AY?=
 =?us-ascii?Q?zXMatuBwbudMdXOUF7dyeFeobJJyl5wENJitO5kyspTE3hvvuFOrXqsvqR0D?=
 =?us-ascii?Q?x/UKIPS+sfew9UP8KgY8dfWkdvMNwb/VNdKyrJDQHsV0EDg0Y+w5uYFaXDmJ?=
 =?us-ascii?Q?GvZTb/Vi5virw0Q3jhDAekKmQlU0sv2EVVL6LE9LCYUOW8MFOH/F6TQKfeNw?=
 =?us-ascii?Q?RIGjMbYwIJYSK3UFd6E6XjY/Xzum4e04T3/ycWyrb+OEWpOE4dXz51YeYuHx?=
 =?us-ascii?Q?6EFmkB4TTCplC1JAhihr5V6WRKrsh6KcvO0gzfNq4E3b31LV4iT20PgAHbND?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff45fa80-df34-44b4-06fe-08dd46e1a743
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:08:34.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6ZIBXiV7ylMf1Ia01JTkQDIoFuuGVYSKQNbepLNuLcvl+truhs2QTMmqEmuR54h6TesZp3SVPEkcMHy6AmQOGk6WHyrw2K/+UDP04SU4/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com

On Thu, Feb 06, 2025 at 02:04:06PM +0800, Song Yoong Siang wrote:
> Enable launch time (Time-Based Scheduling) support for XDP zero copy via
> the XDP Tx metadata framework.
> 
> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
> on Intel Tiger Lake platform. Below are the test steps and result.
> 
> Test 1: Send a single packet with the launch time set to 1 s in the future.
> 
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>    $ sudo ./xdp_hw_metadata enp0s30f4 -l 1000000000 -L 1
> 
> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
>    of the DUT.
> 
> Result:
> When the launch time is set to 1 s in the future, the delta between the
> launch time and the transmit hardware timestamp is 16.963 us, as shown in
> printout of the xdp_hw_metadata application below.
>   0x55b5864717a8: rx_desc[4]->addr=88100 addr=88100 comp_addr=88100 EoP
>   No rx_hash, err=-95
>   HW RX-time:   1734579065767717328 (sec:1734579065.7677)
>                 delta to User RX-time sec:0.0004 (375.624 usec)
>   XDP RX-time:   1734579065768004454 (sec:1734579065.7680)
>                  delta to User RX-time sec:0.0001 (88.498 usec)
>   No rx_vlan_tci or rx_vlan_proto, err=-95
>   0x55b5864717a8: ping-pong with csum=5619 (want 0000)
>                   csum_start=34 csum_offset=6
>   HW RX-time:   1734579065767717328 (sec:1734579065.7677)
>                 delta to HW Launch-time sec:1.0000 (1000000.000 usec)
>   0x55b5864717a8: complete tx idx=4 addr=4018
>   HW Launch-time:   1734579066767717328 (sec:1734579066.7677)
>                     delta to HW TX-complete-time sec:0.0000 (16.963 usec)
>   HW TX-complete-time:   1734579066767734291 (sec:1734579066.7677)
>                          delta to User TX-complete-time sec:0.0001
>                          (130.408 usec)
>   XDP RX-time:   1734579065768004454 (sec:1734579065.7680)
>                  delta to User TX-complete-time sec:0.9999
>                 (999860.245 usec)
>   HW RX-time:   1734579065767717328 (sec:1734579065.7677)
>                 delta to HW TX-complete-time sec:1.0000 (1000016.963 usec)
>   0x55b5864717a8: complete rx idx=132 addr=88100
> 
> Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
>         500 us in the future.
> 
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>    $ sudo chrt -f 99 ./xdp_hw_metadata enp0s30f4 -l 500000 -L 1 > \
>      /dev/shm/result.log
> 
> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
>    VLAN priority 1 to port 9091 of the DUT.
> 
> Result:
> When the launch time is set to 500 us in the future, the average delta
> between the launch time and the transmit hardware timestamp is 13.854 us,
> as shown in the analysis of /dev/shm/result.log below. The XDP launch time
> works correctly in sending 1000 packets continuously.
>   Min delta: 08.410 us
>   Avr delta: 13.854 us
>   Max delta: 17.076 us
>   Total packets forwarded: 1000
> 
> Reviewed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Sorry haven't looked here in previous review approaches :/

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index f05cae103d83..925d8b97a42b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -106,6 +106,8 @@ struct stmmac_metadata_request {
>  	struct stmmac_priv *priv;
>  	struct dma_desc *tx_desc;
>  	bool *set_ic;
> +	struct dma_edesc *edesc;
> +	int tbs;

wanted to comment you're introducing holes here but set_ic is a ptr:)

>  };
>  
>  struct stmmac_xsk_tx_complete {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d04543e5697b..5e5d24924ce7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2514,9 +2514,20 @@ static u64 stmmac_xsk_fill_timestamp(void *_priv)
>  	return 0;
>  }
>  
> +static void stmmac_xsk_request_launch_time(u64 launch_time, void *_priv)
> +{
> +	struct stmmac_metadata_request *meta_req = _priv;
> +	struct timespec64 ts = ns_to_timespec64(launch_time);

nit: Apply reverse christmas tree rule here (order the variable
definitions from longest to shortest), but it's not a showstopper I
guess...

> +
> +	if (meta_req->tbs & STMMAC_TBS_EN)
> +		stmmac_set_desc_tbs(meta_req->priv, meta_req->edesc, ts.tv_sec,
> +				    ts.tv_nsec);
> +}
> +
>  static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
>  	.tmo_request_timestamp		= stmmac_xsk_request_timestamp,
>  	.tmo_fill_timestamp		= stmmac_xsk_fill_timestamp,
> +	.tmo_request_launch_time	= stmmac_xsk_request_launch_time,
>  };
>  
>  static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> @@ -2600,6 +2611,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  		meta_req.priv = priv;
>  		meta_req.tx_desc = tx_desc;
>  		meta_req.set_ic = &set_ic;
> +		meta_req.tbs = tx_q->tbs;
> +		meta_req.edesc = &tx_q->dma_entx[entry];
>  		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
>  					&meta_req);
>  		if (set_ic) {
> -- 
> 2.34.1
> 

