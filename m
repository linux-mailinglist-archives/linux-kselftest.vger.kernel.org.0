Return-Path: <linux-kselftest+bounces-13086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD9924B59
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED8BB24383
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C117DA21;
	Tue,  2 Jul 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZE+KvIAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D617DA09;
	Tue,  2 Jul 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957845; cv=fail; b=T2lb0irKJslFPUYmAywPVbYFkFEalxu9PrvCGTQ+5exJKgjQczbV5Tm9zkY3S0p8b/WQM9yZNF52es5OvPvTpmsjAKlcwq7yyNcvqEkxE0Em12rWCT8HMTnZxiQ18IvjWuZGYrugcZfsnnIwG8b+zZMcwg8LYSJKBbvpxELmGTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957845; c=relaxed/simple;
	bh=hZmKokolC9ILrysz5jXYmNMymoL/WTWeoK7AlNf11N4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=etgnoOXiRluRApYw725TVHQtBTQVVub4E19f2H7fPEOHqUpB61OGDnsfJQWbti9gCNd5Je0pEstbkONB2QdYbTHzA91TNSIWOsQNmj69SG4XssfCbauOrtd4Y8iPn3+qebGGPeYP1Wgi746lsGAdfShbmQfhPYCHNXIKBVGZiJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZE+KvIAo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719957844; x=1751493844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hZmKokolC9ILrysz5jXYmNMymoL/WTWeoK7AlNf11N4=;
  b=ZE+KvIAoYB77dmRHNEtXkkFOybPnavYxUHvIyilKiYKzbAFOmCp1FvzO
   1O2GDMRXeaITcTlo/e4rlT06lk+yEse7zTql38AuqKp8k091/nazxnQ/1
   n3b6FpcZ8+HfdJJiGIl2TBvoPHBqyx+moxo9ThJUnJis/a1ek65RMO1U9
   /yBmeLk9CeBH46jpt3kDPDmMMQMWhu+OCnTzVnm8RuhF8Z6/n1+tN8vKB
   NmjSgOFGR9UkC7Zb9YWRgT5RTB7EgZfr+eTA4aIOVFOamVkvxDAEW9KF3
   ho3i06NoBT64lqvdU9WI2ZOz9k+97KRhw5imfggVkmNzAO79eRKdlb9Ko
   g==;
X-CSE-ConnectionGUID: yh6U3MzcRN2PL5mL10eDKw==
X-CSE-MsgGUID: enfIkNWlS/WEEzodftz9fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837523"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="27837523"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:04:03 -0700
X-CSE-ConnectionGUID: 2qU1tVOsSp2RtoYZbgR/nA==
X-CSE-MsgGUID: 1OFdFBW2TRinY04AimsWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45958367"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 15:04:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 15:04:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 15:04:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 15:04:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug79Kh7ZzySu7p7vGREvhNIILC7SJjlF+b1grn9vPLrhO/QW+vykdo5ZaeTx5BUireqlHo4PyxU/TJCw6phn6HOsZJJoWTAVW58jUl+43VaruyFxSeFt2xT2/AVOx36DGcdR46EADy4MqrBONQXo96ru5W/IpzjQcehvgAH5OeZgaXaY1vcyYw4bPtcGAZwMCzq03aXEyDVoxnwYW4za6TuWI8XxUKuURmlGP6d2Cd/iI+k5i57RPQhHg9sZujqmQfE576+d0u0LaJYUPMqiW9JwL7Qp6hcKROQRSix53Z9uL5nKA0/OPS5WoejS7pVeRC8DOJk6cD+XENXxmsNUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZmKokolC9ILrysz5jXYmNMymoL/WTWeoK7AlNf11N4=;
 b=hEqyWTjNpdMLwesaMJZCuTCt7cI2D8DTmnIEWbGmDHWs2HzK1pfHLh+9WvJP2wQ4KClt+ZCUNL5X28i+jO7b02QJzXDg5un55wm2Rv8sJmR/UCvZveFUeYs268v8on9+9W9Wt+LKBKrAXdQMsGGKg2ZJ07MRkOcw+6SeS5ahVhoXFWW9JuHfy+EBIgbpGltxH4s+IrRz6qpUnaFo4wHxBBlaWLYMpqg5xOA72ykdcMcmPC925jQWGOwtdBnpEWDXculOZ1CXDr+/sHNN2JQOnaV7J62OqAVvOBHC+BemILc35pd05uM0qPYuH890vMgutnueM+WSBQkUU8aXFU4ZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 22:03:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:03:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHay8Gqstk8aT+5WkSi2DkWMDfArrHiB7zQgAHtvICAAAn17YAAAFPQ
Date: Tue, 2 Jul 2024 22:03:58 +0000
Message-ID: <SJ1PR11MB6083B0251209AC52D91DA3FDFCDC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4fdc8cc0-0b04-4879-9337-9eda3b83f603@intel.com>
 <ZoR1GSV4_IWrNMK3@agluck-desk3.sc.intel.com>
 <a206cbfe-83a1-4c9d-8cc9-5cff1598a6d2@intel.com>
In-Reply-To: <a206cbfe-83a1-4c9d-8cc9-5cff1598a6d2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5301:EE_
x-ms-office365-filtering-correlation-id: 36d16c5d-d42c-4df6-e44d-08dc9ae2dfef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ekxTUGw2UTJ6Y1BQMFQ0dnl5YkdzRjBpSWJCdEwwdU9HNVM2UWpiSURFczV0?=
 =?utf-8?B?WWVWU1lvbHR6RkZ0cTZuM0ErOEQrSE10a052ZkJvU0VWUld6VWs3VzBlR3Uy?=
 =?utf-8?B?MjlGYlpudHlhaUpmT3hNUjRKZWFqVHQvYmJEWjdKT2RXZDF6ZVV0OFBBazk2?=
 =?utf-8?B?eE1aNlEvdHRKNENpRlFES09rMUtla1pNSzZIOC9sb3RoQ2FQeUk5RWNBeEl0?=
 =?utf-8?B?L21yZGljeUdEWnJzZDFCcTFpVUw2MlVmV0FIb0gvYjVaMjVTYXRnUW8xUTZE?=
 =?utf-8?B?NjNtT0JROTRpMlRxdnFacTNuYzZCdFdvS2tBY05qSTczS3p1eDVmNVJ5ZVIz?=
 =?utf-8?B?bXpPbytIL1Q5aWw4Q2l4d20xOHFMMnFVZHpRWTVNNnBEL1FQWmZwajJYYkF5?=
 =?utf-8?B?ZVZhTVdHRmVxVk05WEZRTndTL012QytteWMweVpoS1ltUjhvNkRtWjdpOTNk?=
 =?utf-8?B?L3Izck1wU1NjRCsrdHp6RTNsdEFXSHJWWDgvSU5WcVJ6OWw5bEMzM3dTRUYy?=
 =?utf-8?B?ZkdZMWREYzdObnVxeWFzWWdZOG81WE8yaEpqN2JtMGg1NmhTUmFuUG45cklz?=
 =?utf-8?B?cVN5dzY2dmJSOUVJRS9MMTNmWEVCd0UyYTZOSHBSWWpJQ3AzSU9nSE5LMlRT?=
 =?utf-8?B?anVLMWsrUFpNK1Y4RmNJSUZrNDRYcGpmNE9kM1VCV3NjY0FzaDErcGEzcEpK?=
 =?utf-8?B?emVhWjN3YUFCenpmNmhaWDlhRlpwMVBwOFR3QXAyY3RGYXROMTFWL0ZJdXFl?=
 =?utf-8?B?VTJNb1NHT3REK2szTWN5QzlqZWQ5RmhWbXF3SERURk5haXhRMVZOWUtVTXFV?=
 =?utf-8?B?VXZqQzF0blpFSVAzSzY0cTc2Z2s5WjdpMjVWUzB0WFNOc3NTc0ozNUhTdGc4?=
 =?utf-8?B?MFhUR2RrSGdYRTN1SlE3N3hiWTV2VHZGT3pYTjJzT3huZWFYS3BBM2FnM25x?=
 =?utf-8?B?L05xRE5ISEpna3dMdEVPdlVmOHY2OW56MTZ3NlNOR1pKd1lpd2Z0bU1HVUcz?=
 =?utf-8?B?TFUyYU41WCsxUlR5aGZVb0tHNjhhTWxRRWJPT3lCbklxWFA3OFppZTlFTDhi?=
 =?utf-8?B?dXZHM1M0RVkzZmgrb3lsd3NMUUZZZ0xNTjcrWEtmMGw1bVh0d1FZNEVoNE1Y?=
 =?utf-8?B?dHZLQ1A2WTg0TVVNc0tOTnRYc3VneDZFUGNzMnhXWmtlTlBUTHpOM2VyNGd6?=
 =?utf-8?B?RFp2WkFuYkc2YS92WUZHL2p2NzVKN1dQaWRwdWtVamdUNExuemxiWG9TZzNt?=
 =?utf-8?B?TlcrdEE4SHVRZko1WkVWbFpocGdWNklSbm53Y1dCdzdPZTdPUjZxaWh4aVNx?=
 =?utf-8?B?SFVaL2tPWWlHTDhLbnlsMW0yMWRjY1ZrMzMxR0NTN1d5Vnc2OUhMOEgwVWZt?=
 =?utf-8?B?amRWTHZWWlRNdkVHMGFqMS9hSTg1RHJEV1ZuS2MvWW0zRzNLU3JLQ1BqRjl3?=
 =?utf-8?B?K2IxVzVkczZmdTFxaXF0bE1acUpHTzNaZnJEd0d1S0xNTjQ2NEpITTg1OWFR?=
 =?utf-8?B?dGJ4djR0RWpwMTJROXVMV0U1NFoxRVZ4VndyNEdkVk5xUkZrM1BzOHBQM1hC?=
 =?utf-8?B?dzN4Q3AvT2hmdXMzclB4UHFNek5iVVZ4NUs2YVRDeDNnVU9DbHhNemFJb1Zn?=
 =?utf-8?B?eE5SaytScnRvakRBOUYrSk80QlF2V0luZ0E0VlkwL1VJY2pKemJvcHpZVDR1?=
 =?utf-8?B?dFZNM1E2Q1NtdDBUeERldkxSS2VnaFZyMWtzK25KeW12bFNlQkh6V243WlhF?=
 =?utf-8?B?cU4wdzI1K2tveHcvRkpWT2E5NlRxWUIxaEdVemxEa1pNTDJoeG9oM05tMUtr?=
 =?utf-8?B?T1ozUmxGWkhJZllxK2FpeEFqN2kydFl2ZDRhYVhqbkd6eTg1TzNhZEV3K2lq?=
 =?utf-8?B?NWQ0bzl2S0Nna2JMZGJTd0pnS1Fnc1NlTERLUzZidWZnZ2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXlMMVFSWjQyL3pXMzZScjRIV2hUS3BnTnc0ME5WRFZmVW9qdHlrV1FKSk5W?=
 =?utf-8?B?NGd4RkhpRW5qZk51R1dzbEU2Q1pRWlJnMFFHSkxWeE01RFhsS0tSTk9OcVMy?=
 =?utf-8?B?RFd6MzZpVFdFUzRXZldVZ1RwbS84UndKZENmS3BnSGFyRE1oc0Urc2lSV3Zy?=
 =?utf-8?B?MW5HVlVKc1lBOHJoclpPdFJkalJvZG8xYmltekJwZ3ZEUjZTYjNFT0VlNjlq?=
 =?utf-8?B?UEtSQjJVbmMvbC9veGVWZ0JyUXdUaC9oK3UwbkRjU2FDbWZ4ZlAvYU10YkVq?=
 =?utf-8?B?L2E2c3VxNDMvQUpET1hpOUFlQW9iSHZuOXJtM3RvSURrZHpMaEtXaFY2T1cv?=
 =?utf-8?B?U1dpSzJ0Q1Voc3VQUnZlWTh3SkZLblloaWhVYzVYZkQrS3B5Q2YzaUI5L1pl?=
 =?utf-8?B?cVFqa3ZSRjFzYUl3dndONGFWdkx3UTBzN1ZKMFliclBnU1gzMTI4QmliYXpP?=
 =?utf-8?B?eEw0VEVvN2xVVXQ5dElnRmcyU011QmVMMStjSnJoc1pUVkdMTGZOVmU0Ny9J?=
 =?utf-8?B?TzNOWUNhYzI5VXJFSnI2UStTYUFlOXB2V2Zzb01yQVVDRDNJTW1RYTBLQVhX?=
 =?utf-8?B?cGFVN3ZiRTZVSWNPQkFiTkc1Q1AyNGRnNWVURWxQZnZGNEtWamdTc2VkNWc2?=
 =?utf-8?B?QjlYWEVVU3VOVzFWSVNMRktNUU5BUDJhUy9MNDVGNFM5MDdHMVJUNzI4cVNU?=
 =?utf-8?B?b05INkQwdVNhQjRMWmxLeFU4Y3MrMmd6Z2dZMFh0RzBkajh4dk41UVlVTDZi?=
 =?utf-8?B?ZnBVWWRZV1VVOXRMT093VCtZNXRwdW1kL2JWRkhBTkJWazdrMWNhd3NwNVgw?=
 =?utf-8?B?VVdhK1JZdnFEMkJoTW9CbTl5WEVlWFZQSlM0VjR6c3dSaS95VUlrT3lGMlVt?=
 =?utf-8?B?WWk2RUpFaFFnZHdVT2NzcDNCUE50TzZLTjl2aGdPTlpUQ3FHQWZpWFIvWlUz?=
 =?utf-8?B?QktRZWhocEg4SWhISkJ4bFUyR3pBM2QvZ0dHL2thZE9PK0pQWnJmSE5PR2tM?=
 =?utf-8?B?VXNpM29WRjBLeUlRMkVCWkhkZ3Q0dDBkajZpNmc3NzlCL3FJVmhUV1hseWFX?=
 =?utf-8?B?VVhRZC8vd1NvYnh2YzZzSTBxNk96NjVhUEhZTmFXejRpU0NQenBZeGJJR3N0?=
 =?utf-8?B?U1lSaHk1cllUZnljSFpnKzVPQjhMOG9xT3Ftems0NWlBNGxJeGZoZmxTV1ZP?=
 =?utf-8?B?czJrQXRzbm1KK25hSklFMnEzM253QjJUMTYzaE90TlNXU1JXaWlEamhSUGxT?=
 =?utf-8?B?b0hUSC9IWUNmWGx6SU9YVXFZUkpmY3JXalUwSTQ5VWNiem5oVTRvTFl6dWVh?=
 =?utf-8?B?c2xPLysyNlNKNnNEZDFwbDduUzFYalA4eExiR1hPMVlkUDBaYVJRa2FFNWVW?=
 =?utf-8?B?RDNUVHZ1NVVELzNDMEp4N05LdnJ4aGpSbzc4OGdVbDZVR3VSR1JkZ3lIYXZI?=
 =?utf-8?B?MnJ4bUZyVGJBQUxvVFk3OGx3VGhtdUNOQ1RBOW9BR2RsY1hSdlIyWGVRWEdy?=
 =?utf-8?B?dmlrTG1ScWFGQlJ3ank0L2wzRHZHbTk1WnF3T3M4RENseFZyd0ZKTS9ESUFq?=
 =?utf-8?B?aHd2VnVIazBtU3Nady85L1ZwR2RyWE1OVjRmZXlMdkp6VlZlb2tsKzg5UlU1?=
 =?utf-8?B?Wk80TkZ6aDRydk1rdU9oV29zQmlHSitmYTZPVTZMZmlGVVZKTnUxT2lXMUtj?=
 =?utf-8?B?a2lUS3ljOUdkRjFFclZYU3NtRGVQZGpnL041d2xkM2QzOS95VW8wWE43Skla?=
 =?utf-8?B?MytpOTlWZlFXcGpFTHhIQlhIUzNuUTFwbHVCWndZTzVqeStTUEZ6QXJ2dXhL?=
 =?utf-8?B?L082Vm0vZW1TcnI2bW8wS1BxNTNULzNDaFFYWUE1OXRLMTY1N2ZVdFEwMzV1?=
 =?utf-8?B?a3NXeEJSZFZaOWJ4NWRYaUtCRTdwN2RHV2I5cmNuOVVZZDN6dGdpTmdBVStz?=
 =?utf-8?B?SkFRTEhTTUJPdWE5WWZWNDJmUXJKaTUwZ0N5ZVgvVnlva0N1MmVKNE1LUlNp?=
 =?utf-8?B?Z3hiWWljeld1dk54R2N4QWpxSkNaTjljMlVlT3JpNEhoZUpBeSs2WDQrQW5J?=
 =?utf-8?B?YmlmUXZIVTVlb0l6VDhFTmtzZjVnUWhiWStESFdoemxTMHg0L2x0S1g5T1Ji?=
 =?utf-8?Q?25DndC8xdeE4uTWTrixVp/uQ5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d16c5d-d42c-4df6-e44d-08dc9ae2dfef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 22:03:58.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFttSUpCE1y/LX6CGuQKxKu2zAGLzXx9r+ZcRkXlV8O5SDiYoManDF+0MW/wWzZhJXC8fN5SGbchZIBSqCeyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com

Pj4gU28gZmdldHMoIC4uLikgZm9sbG93ZWQgd2l0aCAiaWYgKG9mZmxpbmVfY3B1c19zdHJbMF0g
PT0gJ1xuJykgIj8NCj4NCj4gSG93IGFib3V0IHNpbXBsaWZ5aW5nIGl0IG1vcmUgdG8gImlmIChm
Z2V0YyhmcCkgPT0gJ1xuJykiID8NCg0KUmVpbmV0dGUsDQoNCkV2ZW4gYmV0dGVyLg0KDQotVG9u
eQ0K

