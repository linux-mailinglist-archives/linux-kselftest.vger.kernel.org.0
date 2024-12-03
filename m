Return-Path: <linux-kselftest+bounces-22731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9E9E1832
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A42832BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDC1E0DA0;
	Tue,  3 Dec 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZnyRyeJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE081E0094;
	Tue,  3 Dec 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219269; cv=fail; b=rJ3txtJ7T+ZH/ZN7Hp13GYfFwHrlxlC0bnNerQ7zM/K1HLrYcXJ7Rn+6tZPCL7Kb/AKmexo7ek7ZAGHG3YzUcynObijkDs/CrgqXqjo3asSSLHmv+izun5bXEjBS+WzrRHLqQy36/J4Dq+zT0MGb3ugzc9/+Wr1hqNrt0yRJGDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219269; c=relaxed/simple;
	bh=7WTM2MA+hmj0Z/ISd8xTZCIaP9GqSy2fAr2wJjW0hUM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnyuO821OmSzw654u1ECUcNM6xSyPyBkxidzuu+seWyuoWKjGhtAuFgaoS9pN8NR4FoMDVNPJ9S3BdM+7FuS8HCLo8GH33iUXakpR95AAp0mlV47sSJdUpNkEPNsdOznIO5At64YO+U5h5gv2GcB8t0vksfwUz+gVurxOjPITsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZnyRyeJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733219268; x=1764755268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7WTM2MA+hmj0Z/ISd8xTZCIaP9GqSy2fAr2wJjW0hUM=;
  b=XZnyRyeJ73e4oXZ7HXwxNaVHymvq9Fv4tGg5vyvqpmnhJulPaFxjlzJE
   6Wixk38sr+5d6gX+RsF/D4hvXlzGzTscJIY5cJkLevotIjvvmLgSTgSDm
   mdgb1g9zpVLK1yUxNzT7sEDiyk5+ny9+LoaIGD51aqcxfWW2jvb+oQkpv
   iviXSymN6eMEPNkcLYh+iAGVeQNwats5keLrt2eRFam9rj8BUy+sR+ude
   QzNz5qmXqV4E2gRQVWbe7VzeOM2gMJLz/jLklIMj/IvkY+7AbaREhOdhJ
   xFzPvQtNLJxg58/eQW2psiC03FWyEDBFBfA6C5HNXszT5USs/Ffes/n9b
   g==;
X-CSE-ConnectionGUID: jnX4GeIwQKKaMMchGMZsKg==
X-CSE-MsgGUID: k4r6yCEmSXeE40W37x/AJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="58828509"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="58828509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:47:47 -0800
X-CSE-ConnectionGUID: M+UQH+ljRO+zuv62JPjrhg==
X-CSE-MsgGUID: /R7EJUDTTv2s3XkBN72N4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93470831"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 01:47:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 01:47:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 01:47:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 01:47:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzOTW+s+rTvVEh+4zsDAenn1Rxgw4IXxPjZLNV4H0WkpGmAuQlAvH2JzhgEtUvXYyg2GgwoHiVL6eDP4x4NTMUOpdXA4v24Yh3dQ3NJvn/pAsI5mocEka5o38A84t7yBbXzWetu21PJQeDJ0bDPBm556n+wSM9KkZjvS8XJ9IyxgB2q0Jdlef0q1oLUkl01e8+KmpgaLqE3GYcwSIfu3no1hk9fRFNnvhg0oHjF5xeqJLT2qfxfndkYYHf5hLzHQRmObCsMMp75Vsd1r0KxhtdVFfZY/TZ97Uye/UpoXJW0DwIMNj+bLJ/zsgCQU1SO46f1n4QXZ7B8VUB7BC5svJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiV3TA/Tr9ws01Eg4V1bcMUvVs09cDi0AVfVeaW80oc=;
 b=qME8sIEecl0kgYaQDBXvuNi9c2VRzLIce2/X7CT+LC/wEiGJE0YbbHMnJeOlT5TnCUPs8xBTZfVrhv81n0YV1/3/oKh5AALmVT4rgvDhZqrqol/QZoWcEEvwXnFdLtG3y4YreSM79DNEdXFM16WRjXwft1h/uNtllZRt/rEbiey0QW5ZX7ImLPg3ESepENzyIs+N20fBkDBLLbKVl5p8kmSim14lBx9VX9NinYQjt42uZNdmNiCy/k3ptq/56v+aNrxcEStK6cro/dbyaC5bMua6gdH2xf3fz73HdbYcqn423I872cCuXe0ZnYKiiuVXtu1RmLwAqeIJ4zlSIrrCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 09:47:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 09:47:44 +0000
Message-ID: <a6487e28-787a-4c9a-9dcb-15d92d0f6b3d@intel.com>
Date: Tue, 3 Dec 2024 17:52:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] iommufd/fault: Fix out_fput in
 iommufd_fault_alloc()
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
References: <cover.1733212723.git.nicolinc@nvidia.com>
 <b5651beb3a6b1adeef26fffac24607353bf67ba1.1733212723.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <b5651beb3a6b1adeef26fffac24607353bf67ba1.1733212723.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b0b36a-fc06-4d91-1616-08dd137f893a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlR4bzNsYXNkUm4wL0lyN2cxdVRsU3JKRUJuaDVTRlloUTdzWWxUeU5FNlZa?=
 =?utf-8?B?L3ZORU41OWZzUjdSSzhuYm9teEhxcGtyZ1dFd3hrOXFqQVppSWxZeVJjOGpr?=
 =?utf-8?B?WFNZUDAxNVpzejNFbzJDMVh0cldCeWx0K2JUSDZhWEs3YkZMRkZoeHU5c0xI?=
 =?utf-8?B?cFRuenFwRzRGb29JVUI4M3lOeUtDS1hqL2QweVdOWTYrTnBsYS9ZU0xPem9S?=
 =?utf-8?B?WVhnNyt6dytrVkdhdUNjNTBub1pFK0l1VDdUclZYRmpRSTlNbUxzZyttTU9D?=
 =?utf-8?B?M2pSOUwwcDVjUFVkV1dtbS9ZNzlYN3pPZFJVckRBV2N2NU1tTHdadysvay9u?=
 =?utf-8?B?OEFQT1hacTNXSHVHMWdSbkhlSHVBS09NRmhkVXhOVkNYQ0NlaXVRUUx4bXpa?=
 =?utf-8?B?b3FQOGpQZ0dVd2FsaEtMeE1aSnlZbmpuR3diMHh5UUlrUUVvNk8xbE5SbGoz?=
 =?utf-8?B?TC9KNTltajh5S09mZHFFTzFSM1BzUzVReTF0R2k3NWFUem8vY0xXQUlOR2h2?=
 =?utf-8?B?S0c2U0R1WDRIS2lScVNKbExoSXZRa2haYis4ZDIrR1BjQWhid1FnM0dQdzll?=
 =?utf-8?B?NFBMYmxoNkt2bzF5NDFjZGpzSEM3SUxVd2dTQU9HWGpaMEc4YWpKalRoOWJa?=
 =?utf-8?B?enRZb2RDMndYRDJWZ2kxb3RwVjN3cDVSQUVqQ2Q4eS9RYXFlZmRPYjFTNTgy?=
 =?utf-8?B?VnZ0M0VLTHp3NnRQQWt5elhDRFNtQ3U4MVJ1a3NlZHd4ZDYzT3A4d2xGd09H?=
 =?utf-8?B?K2wvMHRkclVzRGQ3QXpvaHJPM3hsVkpFeXIrd0ZXK0hucEhEVUxiSFJKdG5R?=
 =?utf-8?B?NGJTVVg2bFdFWWpOQnVZVGhkZWJWV2gvTHE0UTZsaGFsbXBOWWpaQTE4Mkhk?=
 =?utf-8?B?bzVEU2ZhWDc2eGFxVUR6QmhuWWxpd3RoWlAvTUY1dkJHbjdGZk53NTRLeDVH?=
 =?utf-8?B?U0k4UndGVldhbU5OU1dlS1ZkNmVxM1owamgxV2VISHRFZGRsUjJHQlc0K2hU?=
 =?utf-8?B?bjE2Z2g5andhU25NU243WVRpY09PdGs5SXpNNXlhR0VRMEEzbzBVQmVlSjc0?=
 =?utf-8?B?SE9Zb3piNU1hMFd5MmJ4aUVSNVd1VFBuUXpPb0h1K2U4a2ptZjErcjk4eHA1?=
 =?utf-8?B?Y003THgzUGhETzc5Y0dtZG1CTk5rT3VzMFNoNDRiU0JNWlB3WW55M3kraUJn?=
 =?utf-8?B?cGVLQTJrWkthbmtxUFc2S2dieDdDR0xPcUlqcXJPd0Fob21kRkJLWDQ2YU5Y?=
 =?utf-8?B?TGhhdWFVWWxjQkQvbUUvSkpKcTMxOUdTbmRKRk1xbmpmRTI2dGpGNjkvcHpz?=
 =?utf-8?B?eXBGQTZKSk5USE95elRWa3k1T0lVQXpxMHJwQUNLVlZvZjJaZmNqRVFHeGVT?=
 =?utf-8?B?S1IwMXZYSm16TUVPZEFkODJiZEIvL2VneU13UHB6N3dpenBkZXRPS1dCNlFX?=
 =?utf-8?B?WXNqc0pZUHpGM0VVaEJHNzRrWHJHT2g0Qm9QWDZhL1hwalZ1SkFyNi81SkYv?=
 =?utf-8?B?aG5uZWFqY24xZUlHaUtBTlZFMUhlMDh4OVF2VlFRZ01qRTVZcld5TjV0TEhK?=
 =?utf-8?B?VWRuWGFrSjM4NmNXc3J6SWlhcmt2QllVUURlRkx0SkxyWURkNGxTWXJUMkhu?=
 =?utf-8?B?RTZlZXdGanp4aFFIRXdETmNodTFUM1k1K2MrS3BaTzV5UDhaeHZBRUxVV2lK?=
 =?utf-8?B?THV0SjNHSzBGejdad3lxVnpmaUNHNCtDeFlyN2M3WjhJZytXeXF6UGxZWkFR?=
 =?utf-8?B?ME12VGpNRWhTcWV3N2JvOGxyWllFOS85QjI3RWVJZk5Jc1BsSWxsRXV5a29k?=
 =?utf-8?B?VjIzVlJWakRjR2N4VUkwQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEtTREd5UnF1b1Bnd1E1aDhhd1lQNWcrSGZHTWRscWg1YUg4Y0owdkpXNWFm?=
 =?utf-8?B?NEY5Z29XWG56eEFBNGhzaTRWY0hna1pmZTc4a1A5K2hUT05JZ3BoNzRhRHV3?=
 =?utf-8?B?by9JbWpFZjYxckdNVHB4ZUJjcTUvOTRsWTcvQWMzV1gxSnNOdVdYVCtYQStx?=
 =?utf-8?B?K2RCMkRGUWNXcXVVaEVmYzVPeWhnbnB0aU9aUm9hUXg2dkx0bExVNUp6aXRD?=
 =?utf-8?B?NEhaaUJNYUJncS9oNHpRMUdnUVVEWmJ0Z2crSHFEK0o4MXRWODhsYXNXLyti?=
 =?utf-8?B?VE5wRUlnRmo3S0FKMW51NjNZcjQ0RDJpZjlRSHlWQW5QN1hETE9VODZoOUxC?=
 =?utf-8?B?eGJ6WkhnY3NZK0VPaitvdlkwZTBPSjU2Y1ViWXltY0psQU1MVVhOdnEwRXZm?=
 =?utf-8?B?cG5GNDQ1TWVLUU9CdUJYZWdHY1ZZZDJVWURtem5SSkdNYmhnY21hS2NTemt3?=
 =?utf-8?B?dGtuZVJ1Y2p3QllWWXNhNk9zQ0pVZW1IU2lXU3UyUHkwbVdmOHlVQldyV1Jj?=
 =?utf-8?B?VFJGbUZMT1ZpZGlQK1pXcHQvWU1LNkVta2Nna25ENXpPOTlLNDRORkNqbW82?=
 =?utf-8?B?Wkc3QlhKMzl6VVV5cFJRb0JwVE1OTjNCeGFHZlIycDVhNlJSVEVBMXh5Ulcw?=
 =?utf-8?B?d01aUjJpQWNyV2JmQ0prRjNlY2NJOGN3K25CWk56TEJlNEZETjBmcTBjL1k4?=
 =?utf-8?B?UTcxV2pEUUxBMC9IRnVybElZREI3SEJ3blZlb2NNMCtJRFZvSzVvWGthUGdB?=
 =?utf-8?B?TDFJdUNSUG53d2hiNzQvYUV1ZUJYdE1HdEE4NmhmRCtON3VWcVB5NnczZjdW?=
 =?utf-8?B?dzB3SE1aRGxhenFBWWxSVlNwc3g1L2VsSGVVQml5VkhJb1VoQ25UNFV3dm80?=
 =?utf-8?B?Y0t6K1F0dzBsampNZGJOT1RBemZERkxack4wYjhxL1hEcHJqUXZBSFMvWjBD?=
 =?utf-8?B?TlRiQlZGRTlPeTJ5MVhhRE5pRE5MbTZoMEFuTjRLT045YXhUZFdoeW8zRXI4?=
 =?utf-8?B?WWpYbUJlRk9qUTN4YmttTEdWQlJ2NitaNnlsVFdnd3krckV3WlNBdEpxTlM4?=
 =?utf-8?B?ZUkyU0hvQ2VyaTZsNE16bkg1QkZaTU1qeWZQRFVKUXRyYVg4OVVzaC9neVNO?=
 =?utf-8?B?d1VjQnJNSkl2RXZ4NE4zTk1mb01LaUp0QVAzUG4wVE4zZlFzeFFaR0N5aGE3?=
 =?utf-8?B?RWlNUnNDaENHMEZoZHlnNE4vNkhNSkYxK053a082RVJYSTFFTFN5WlFZQSt3?=
 =?utf-8?B?MzZ3RWRMWm04SUkva3pwUlJHSVQrYXVTdS9uQmxzZG1NQWMzQXN1L3FXUXBU?=
 =?utf-8?B?YWt3S0RQUDNMNnd0dE1pK3hFUXduSm1CWTREQ2ZENkRWWHZta2M3U3lQcEhv?=
 =?utf-8?B?WU9vU1ltSGRJNnBEb0NFN1JEc0hsM1J6TGltNkIxUXhXOWtyZFB1QUo5RjRI?=
 =?utf-8?B?Nmdqenp6Z203UE5ZWGZYVkVzc2lPdGhVaUU5ZWRxaVQxdHRyeFZ4Nm5MOThL?=
 =?utf-8?B?RkUzam9ZZ2htUnl2ZHlYSk03c1dlSkxmZ3pGVnhCTVREMzZXMW5rTWwrTmlE?=
 =?utf-8?B?R0F5bjBLc1ZxbmhSbHFYSE15YzVlRGwwMmRTTnIvWTE3N1JUdFRpN2Q0dTJu?=
 =?utf-8?B?WHVtQUErSVhOQzZnamJXRUpxN09FWktyQTY5dEVnTEhYdEVJcERncExtMjQz?=
 =?utf-8?B?b1RZWUkzK2ZQUGJ0K3dybytHb0ZGdDF0ajBRS3QybDhyNGFtUGNqQ2FPaDVt?=
 =?utf-8?B?bjNWb0pUU25ES1RJcFUwZG9oYTRKWkhyMmZlZUVLSUc4NE5TOElRUzlGWEJM?=
 =?utf-8?B?Z1A0bWcrZ291NU0rdkNJVVdkLzY0RmxUdVFUYmE2STUzdk56RFVHMUMzb1dX?=
 =?utf-8?B?c3ZoUVdOYmdXMnBlU1N5dlRlU3E1RVBLRnlPLzZvaG1IYXkzQTNuTnNnY2tz?=
 =?utf-8?B?elRtNnA1K05vTWtINlMySFF3cHNVblJaUzVELy9rUlROUElrT1BKUE1ramRK?=
 =?utf-8?B?R1RwQU1wODNpR1NGK1F6UlBlQWZDUFlJSk1sc3UweVkyLzQ1blExTG9ROS9C?=
 =?utf-8?B?UHdDaW41OFBOM1pOTUl6TlFScGJzMkFUZ1FvNEQ4NDFYNFZXelByTCtRcm05?=
 =?utf-8?Q?L23M2oBwZ/GR9Yn4VyRvxAcDf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b0b36a-fc06-4d91-1616-08dd137f893a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:47:44.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8enuMzRhA4tDHwcot1NUg5ztBFwT90okSAShhUabiThKFX2b5opGCK5UfXARhiqyb6SrcGq24nZqkYF+Ukgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com

On 2024/12/3 16:02, Nicolin Chen wrote:
> As fput() calls the file->f_op->release op, where fault obj and ictx are
> getting released, there is no need to release these two after fput() one
> more time, which would result in imbalanced refcounts:
>    refcount_t: decrement hit 0; leaking memory.
>    WARNING: CPU: 48 PID: 2369 at lib/refcount.c:31 refcount_warn_saturate+0x60/0x230
>    Call trace:
>     refcount_warn_saturate+0x60/0x230 (P)
>     refcount_warn_saturate+0x60/0x230 (L)
>     iommufd_fault_fops_release+0x9c/0xe0 [iommufd]
>    ...
>    VFS: Close: file count is 0 (f_op=iommufd_fops [iommufd])
>    WARNING: CPU: 48 PID: 2369 at fs/open.c:1507 filp_flush+0x3c/0xf0
>    Call trace:
>     filp_flush+0x3c/0xf0 (P)
>     filp_flush+0x3c/0xf0 (L)
>     __arm64_sys_close+0x34/0x98
>    ...
>    imbalanced put on file reference count
>    WARNING: CPU: 48 PID: 2369 at fs/file.c:74 __file_ref_put+0x100/0x138
>    Call trace:
>     __file_ref_put+0x100/0x138 (P)
>     __file_ref_put+0x100/0x138 (L)
>     __fput_sync+0x4c/0xd0
> 
> Drop those two lines to fix the warnings above.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/fault.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 053b0e30f55a..1fe804e28a86 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -420,8 +420,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
>   	put_unused_fd(fdno);
>   out_fput:
>   	fput(filep);
> -	refcount_dec(&fault->obj.users);
> -	iommufd_ctx_put(fault->ictx);
>   out_abort:
>   	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
>   

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

