Return-Path: <linux-kselftest+bounces-36255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1EAF097A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3C93BDA22
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8D1E411C;
	Wed,  2 Jul 2025 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VegY5IO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423F1C6B4;
	Wed,  2 Jul 2025 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428547; cv=fail; b=WK3KXpciGaWtn5HduFixB2Uj3LmvP6IAfQLCBw8AB4YUrCuD7Bc0dk47cejHy2vd0vX3/VdMKlT2JIWkLI1bReYCSQl9ooUuAdNvFZCGvP90VQtofOLQ5E+Wivu05s0MDZbe8Rk4Z6RMuQQvlEOQ6Vo84W4/gt03vnQJxjbuW5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428547; c=relaxed/simple;
	bh=dXwIfoFWSEunmbcSVQmUc+E3qcMc61nRr6JWADTYWJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOcJcva6wuCh+HSR+jZrvHd7HxP3SnaJB0MGM5dFTTZeiuscthpLNc7OFicxDTnnqAAS9iDg6QulKdG9RLgt0b5JjfRIayX6TEyUlvbBGZ0AbmDJjZEL1hZEyzmx+XLh9/Hm0uO6VYnS4quWcoQ8aNmJf41vS597oRxPOlf8yfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VegY5IO8; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751428546; x=1782964546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dXwIfoFWSEunmbcSVQmUc+E3qcMc61nRr6JWADTYWJ0=;
  b=VegY5IO8fwzuivTnKFb6Oeeyr8XahHSw+h09M8FTWxeVJVmJr1WXlaaF
   DNoex6v39FyZa7odv0q2eQyS/4fHuRyX+ZrG5tIdxCOUro2ZHvg5FE7mC
   HVMRDRV/tLOJfHQntid+thexjpsUwlMfu99+9WvMibOGmWSWW4BuJWR4K
   bGhPMGLuoCHfzDzSjUgTXh0joeB2BgQ1Cku/UeusC/rNW8QjIV2Q7cg6g
   ZqGrlZ8TpnKpHZndVX1s5yhWJjDUIwAu0CyEyi5mCSa4ji+1WkT59XND2
   zDt20mNWsZs6qPEPxLCPaFqUaOAtF8cAj1lgQ+PUhNC9k19mSKnr4NU7N
   Q==;
X-CSE-ConnectionGUID: C/LHZcIPQ8uQC/PyVlg+kQ==
X-CSE-MsgGUID: jF1Lhr+pRk2RCrXw/hctig==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65058459"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="65058459"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 20:55:45 -0700
X-CSE-ConnectionGUID: XAaILJi3SyGHoHgySqSp1A==
X-CSE-MsgGUID: 5nPf1NbySpCaMcF7Xw1edQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="157996253"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 20:55:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 20:55:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 20:55:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.57)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 20:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWI0GLbgKyS6x97uWAr506sU24/dfVqXw1bPP16IvjyY7bc3AlnUtF8iyTXBU6cTzbuuxM76C+dOMd6fsYVGJnJ/6xM51xgdCq7QQktegPMkXxquxFVCu63tpXht471uG5N9RidU4T812l33UlHItAv7zqDAoXiNOUwDFVma9strmG8AYx3jEL90oZ82farydm4ggSWTDcYT8/BplH5A2dm4WsVapCsE6v7epUQ/Q+e1HYoddFJ/xRS3YaC5/VI2NI3IYhjSX9Y7HKRbQlG6u4iZF75anWN6XpW2iOZQpwmdt7wMgRTQb1O2nVV7HRQqma4NtQnEgORW5X3/H6Ik8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXwIfoFWSEunmbcSVQmUc+E3qcMc61nRr6JWADTYWJ0=;
 b=f6L9/i+kDetiIfEv+9bYnGauaQB2gyO2BQY+LeYumq+0RK6Y+fjiFa/RdSFBFe8lD7nzpc9oA19sbpypVQt4hoXVLTAz7yYAnmdQYnuxnNdkYb3DUzJwntDQnvTdO76qXwNbHgzdLUDtQq+j5FFIe7zLgkX9FnLy1v6EIhHxWbLkOooJ6w7uEcO8M3n6SCd1+L2wo3J4D4XzDm0YgpqWNPXqP03p+z7qdeVfAj8UYU8XqV6hmFlNzV6jgK36wCi0jKko126zwt58SB0zo3tQvAkqNHjTxX/Iiw9fiSwELdGACpUS7SSrWo2CyfE2SjF+gKUo+fHgm3xaS+TOm9iAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by IA4PR11MB9009.namprd11.prod.outlook.com (2603:10b6:208:56f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 2 Jul
 2025 03:55:39 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Wed, 2 Jul 2025
 03:55:38 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, Stanislav Fomichev
	<stfomichev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Thread-Index: AQHb6kEMHPOPYZSFok6IH5vzoGeGvLQddqWAgACgmGCAABl5kA==
Date: Wed, 2 Jul 2025 03:55:38 +0000
Message-ID: <IA3PR11MB9254C961FD048793FD0013EAD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
 <aGQNWXe6FBks8D3U@mini-arch>
 <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|IA4PR11MB9009:EE_
x-ms-office365-filtering-correlation-id: a773fed1-4837-436d-630d-08ddb91c4e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TVVSWGZUR1NLcGtGcWkrMFM4eUYvamVzc01iY1ZncEVyS0FZdXdIclA1czJW?=
 =?utf-8?B?MExTMUtkd2J0bEhPd1dQd0xDcVVtak10S3AxdXBLaEJtcUEyamN2M2IvSnNT?=
 =?utf-8?B?VDlnR0tuckNTZGtPVGl2NFhlT2RWVHIyOHpMeFNtNFpjdVJ3MzJuUk41WS9m?=
 =?utf-8?B?d3dvVENDTDFKNlhNUS9ITlBnWDVXQUhSL0YvMTFxd3BGSi9ZbHp4Q1M5cUxH?=
 =?utf-8?B?UGxWb1NuVGVOL3A2L2VtVnl4aEpid0NJNC9WT3NGdGJWdjNpZmY1VE1TdkIx?=
 =?utf-8?B?SSs5T0ptR0JLd3JybXNjYmxHZmw0OGRuVm5Pb2U3YWRjYnNXdUJBUkE1QkIy?=
 =?utf-8?B?SGVrZzlsalR0V2t1UlpTN1NRSGphK2p0blU1R0l0NWhKa3dCczMzYlFaNWNP?=
 =?utf-8?B?Y0ozUUFZU1kwWmg2NWpuZUJkSXRMMG9sWlVVUFRQY1IvOHNoZzFXQUhZYWQx?=
 =?utf-8?B?M0phcDMxRkNCMmFRNlh5a1QwN0o5WGtxdlBQRTN1dFVCZXI1UWhjVzVFcnNE?=
 =?utf-8?B?MCtEbUpsSFV1K0hYZC9oWm9tWkxMVXpGOWFLSmdhM2xDaHJybGF4SnYvSUor?=
 =?utf-8?B?Y3BTRWlFbWVjV2NaV0Y4Ymx5K1ByMThCQ2N2cWExODZ2eVVWaVE1Ri9Pb1RR?=
 =?utf-8?B?WWc3aVE5UytOZUVmV3VWTkFSd1YvR1M1alN6bnAySXJWMVVORW9LK0lhdU05?=
 =?utf-8?B?NG13MGtSMktqRTUyNHhUV0ZsMXgva3kwc0g5dnY5Q2xQYmE1UmFvSmlhclJr?=
 =?utf-8?B?N0JMK3d2UUoxaE05YlZKUlFNaG1idVVIZ3FnSjVtVXhrSEtMUWgzKzhiZnB6?=
 =?utf-8?B?cUdPcmQrNzJwWHBBVU5yWkNrSHBQMS94Yzczb3dIdHRYd2o4d2ZGU2hzU2ZT?=
 =?utf-8?B?cFRFNHQ2K0JuWWM0aVcyMVJjZ000a2k1UFhIeERNUmY1czFWU05ZTEVZTEIv?=
 =?utf-8?B?c3ZocXRzbzZzaDFEckk1ZFhlQ0hVZG9EdnhjdDYyTGxsRE8zTXVCZ1hQUU95?=
 =?utf-8?B?SWVmcXZGRncydG5aekR6dHI0SS8zdWlXY2ZxaU1DNG9FbGEwd0pTcXk5czh1?=
 =?utf-8?B?cFBtbWFxRitWUWp5SGlGSDgvQ3NBdnZlMmNuaFhOcWd1eHZSNWRUYlpDdmo3?=
 =?utf-8?B?UzI1VHhrN3o4a2ZhalQ1UXpNaWRXYlp1T0QvUDA5OUhHWThWUmlhNnZWbTVl?=
 =?utf-8?B?dWZEQmw1bk16dG5YWDI2SlNtczNhYlMvaC9qNldYNUJIdFR6UHEyNnI4dDNa?=
 =?utf-8?B?VWt2WUlWVHZOZTN4c0Jrb05KbHlxV2xhdjYzd2RJTDRnOU5GYXV2Q1dzRjJv?=
 =?utf-8?B?ZnhoVDJFVkVJM3dwVDV1aEJoaktZdnBtSENid2xvMG1DMTZzeGJLM1QvMk1q?=
 =?utf-8?B?SlNKaFBndndwZXBybU1EOHhoeGhaKzcvazFKQ2hBM2JsM1NjNVFXYnp0cWsz?=
 =?utf-8?B?TFJSRlE2bDdnTHAwU2Q2dUhPUGZKbG1mdzUyVnlLUzZvWlNLRkV2NHR6UU5C?=
 =?utf-8?B?eDIzRlkyMUszSVpzMjIvYjcyL0hkNlpNN2VRdmZQTVBEMndoQ3l4Y1dqcWo2?=
 =?utf-8?B?bm1ERmVXUFFpTjZHR245aEJjVGRGSTNJMHRXT3hhS2E1THNJc1lnNDh3dDNj?=
 =?utf-8?B?VWNFL2RuVmFldEczc0pWMHZKYmd0WFNGR3BnTGpjdFFITGF3cFliUURhYW9I?=
 =?utf-8?B?NTA0dm15VldCLy9BNHZBSmFQK1pMZkh6cHhON29NUkJuVkJMZkxmMzFUbVhD?=
 =?utf-8?B?V1J0YVNJSkk0VHc4cWxyWGhSYmxGeWxaSXZtMnZ3WGIrL3ErS0U1WDZRU0Yz?=
 =?utf-8?B?ZlIvOFczRTZjMG1hbjlWN0RvdWJkVGl6amZoMGdUdGMwK1FDRjRGcUtva3d1?=
 =?utf-8?B?U1FtdTJ0STI0ajJKMUN4amdsQkVUN2E5eFBlN21oWCtDNkVMTXp4Ymx0cVZI?=
 =?utf-8?B?NjdVK0FneDJ4TkxuTE1LcWNjL1JZZ09FMi9xTzc4aytvNFpRYms1ZVJLaEZR?=
 =?utf-8?Q?cOrnsDKRIDPt0XcM1PQ0/JKFx4qZkE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUMySVI0ZU54NTlLU25WU2dqNjZCc3ZlcmNZVENkbFRlM2NmY0I0VGJEeVBH?=
 =?utf-8?B?d0tjc2FJQWRRQ0xWQ1Z5YytwY0F1Rm41OGtxRGxqd1JWWVdWRE81aHFPbDdR?=
 =?utf-8?B?YUxOTnZvZWh3QnQrdnNMNnpEQjE4cUlDRnJPdGlmSUlQWVVnTTl0M3psN3Bn?=
 =?utf-8?B?K0dqMG1xeW90VUVBOTlzNGNoRFpITjdaZ3VKbVJKNG1aMDMxRlZnQ0lSUHJq?=
 =?utf-8?B?TWZiVHIrdEg4Qm93RzAvdzZESFhiWEZEME02MzUwU09NbW1SNW1xdnRsckJs?=
 =?utf-8?B?T3d6ZTRlMkk1UnVqTEtjNG5rUlN1b0tOdFFMN08zdXJoQjk3RFhacEI0dFNK?=
 =?utf-8?B?Q0VpQVR3SHBwdnV5YzRlSG9HKzFscGFDc1h4RE9UVytzbjVMRHVpZjBqdWVx?=
 =?utf-8?B?OFcreTlBTEg0WDliZFJoU1JYSU5ibmEra2hQUkwrSUoxYUhkM0laY00zMnNp?=
 =?utf-8?B?NUJjTXducEFuWURtOElRNUdvdFhOTWJWbXVyK3ZlWC9IMnQrRlc4M1lkeUNY?=
 =?utf-8?B?c1FTblhnb2FsZjJ3OGJvbVVuZEFEMitqUUt4eTVZaitVZnZKK2JmZWVEbVdG?=
 =?utf-8?B?Q2tSa3VRSnVUTTZzdkwrR0tGdE5yL2dNRWYxQ0tUUXdnb3VnS3hycG9DN2N4?=
 =?utf-8?B?QVBWMGdic0J5Z3N1L05RNjQxQ2FmdEFRdzdPdXJSdnBDazdXbmdEL3dzZTMr?=
 =?utf-8?B?b09XOHM3d0FMVGdRQlNkVEsvdmpVUmRvQnREUWhDUWpKUmM5R0Z3dU9OUEJM?=
 =?utf-8?B?bzVXUFZOVWcxUm40cXAxRStaWlZYMnQ2MUVGUXNTWmV4a2VrZjZiYUl2WUJE?=
 =?utf-8?B?YnJHTGtDbmErMDZzbXB0c1Z0dVd1N1ZTKzNYSlVwNGJZV1RWemdIZDl5L1ZU?=
 =?utf-8?B?bFNpT0dMajJmTFFHbFJKekk0Z29yRDVkakNCdTRqUjE0VXRtdDVnNUNxWjZI?=
 =?utf-8?B?WURHKzhPYU1KREg3U09vbDVYbm1OdXd0VkZyeFRMMXdkS2JBTWZhdFFNMW52?=
 =?utf-8?B?R2lwUWY0RFZIZHBEeFduMWIwYU9DdXpQNHNBVXQ3RkhIcTFadTZHM0pFVWpx?=
 =?utf-8?B?OGtYNEdveXAvSnQxRTluNFBOd0ZMTmJqY1Nid1ZndnVNRDFiYnp0Z2wveG1X?=
 =?utf-8?B?cTBPUUxZb0ZEQVB2VVhUNVA0N0Q0UVJ1Z0ZlZW9FbUl3V3JQVGRzN0Y4RXlZ?=
 =?utf-8?B?MS9HOFROTUV5S1V1SEJGeUdmRWpVY3lsdWY4VldvamVhMmptbnh6ZkdwSllm?=
 =?utf-8?B?R2MwZFY4VWdOZTlVdXd2Q0psWGV2T2pvVExxZzNSYUZUdllONUY5SVpnbFNX?=
 =?utf-8?B?YWhiUUo0ZlBMS0RPa0pBZ1U3TzRDelM5dUljMzA1TlF4RUZ1SUEwR0hMaS9n?=
 =?utf-8?B?WmRuVjFTT1l3VE1CU0tzdFFEMGF1UnN5THh5THZnRUZUbStpY05pRFNqZmQ5?=
 =?utf-8?B?c0R4ZFY4ZjNTeXJyWGhVQnlvMGJZaUROWVlRSDNwb2piUGJ6czlIa1lkMWV2?=
 =?utf-8?B?Z1kvUnJYNXNwV1YrRVF3aTlKd1FoK3ZvWEdaRjlwUDdoZG1oc3gxaDI4cHZt?=
 =?utf-8?B?dzdnODdwSFNJdHpTY0U2dEdOZUE1Wjh0bkl2amhSbkg0d0trVnRLMEF3Z25l?=
 =?utf-8?B?TUN2U3Q1NVJFZWowd0k2K1NkTVNzNDhmMDgzSUpxbFRVemxWUmJ3UmVGV2xi?=
 =?utf-8?B?VVRMdll5U1ZPdjFHVS85K1MrWW9oYXlsVzJPdm0vVE5xUDNEa0NodkZBTmpy?=
 =?utf-8?B?L1pxQm9RVHFBVi9wWHRWVzUyUlJ1akJ1a25iQmFNRjhxRTFWSy8wSWZ4WnA5?=
 =?utf-8?B?NjBqeTNlVTlQaUQ1U1JJb1l2SzhzMkUwZ0F2QlBjc2pNK1RmM2d0b0xDTmdH?=
 =?utf-8?B?T0QzdDR5bUtUZXJVdzlteFRZKytnRzUrdGRSREEzKzYvTkZlaUI4bEJIcngx?=
 =?utf-8?B?Ujg0a0RrS1RTMWYzdmI0OWZ6cDBPUFFGOHVsWFV1dTNGUm5RSDFWU2MvcWo2?=
 =?utf-8?B?TUZYeU5uOTN1eWpWdzE5T3Y4VFdrZ1BLOGVwdmxqRkMrbkxKRElFcE90UjJt?=
 =?utf-8?B?SE1mc0VzSWlsRS8yNi9wdGFGQWxpejdsbkpMVElZZ216UFAzYVhPMHd1dHVF?=
 =?utf-8?B?RTk4bWN5azlWVjhid2hXUkNxdml2K1hIRGRqQUQrRVdzaUxiNnEyaCtaN2g1?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a773fed1-4837-436d-630d-08ddb91c4e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 03:55:38.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/UsGsPkvkZd3s1PsM2OmtcWNgGkrbaDugXwr+r4nacUKtTqNl0Dg0fwG2q2/zGrTe5VyuD/rCQ16qOzC7IrgrT79O3inRmk/5vXDPHhtv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9009
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKdWx5IDIsIDIwMjUgMTA6MjMgQU0sIFNvbmcsIFlvb25nIFNpYW5nIDx5
b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4gd3JvdGU6DQo+T24gV2VkbmVzZGF5LCBKdWx5IDIs
IDIwMjUgMTI6MzEgQU0sIFN0YW5pc2xhdiBGb21pY2hldiA8c3Rmb21pY2hldkBnbWFpbC5jb20+
DQo+d3JvdGU6DQo+Pk9uIDA3LzAxLCBTb25nIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4+IEludHJv
ZHVjZSB0aGUgWERQX01FVEFEQVRBX1NJWkUgbWFjcm8gdG8gZW5zdXJlIHRoYXQgdXNlciBhcHBs
aWNhdGlvbnMgY2FuDQo+Pj4gY29uc2lzdGVudGx5IHJldHJpZXZlIHRoZSBjb3JyZWN0IGxvY2F0
aW9uIG9mIHN0cnVjdCB4ZHBfbWV0YS4NCj4+Pg0KPj4+IFByaW9yIHRvIHRoaXMgY29tbWl0LCB0
aGUgWERQIHByb2dyYW0gYWRqdXN0ZWQgdGhlIGRhdGFfbWV0YSBiYWNrd2FyZCBieQ0KPj4+IHRo
ZSBzaXplIG9mIHN0cnVjdCB4ZHBfbWV0YSwgd2hpbGUgdGhlIHVzZXIgYXBwbGljYXRpb24gcmV0
cmlldmVkIHRoZSBkYXRhDQo+Pj4gYnkgY2FsY3VsYXRpbmcgYmFja3dhcmQgZnJvbSB0aGUgZGF0
YSBwb2ludGVyLiBUaGlzIGFwcHJvYWNoIG9ubHkgd29ya2VkIGlmDQo+Pj4geGRwX2J1ZmYtPmRh
dGFfbWV0YSB3YXMgZXF1YWwgdG8geGRwX2J1ZmYtPmRhdGEgYmVmb3JlIGNhbGxpbmcNCj4+PiBi
cGZfeGRwX2FkanVzdF9tZXRhLg0KPj4+DQo+Pj4gV2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIFhE
UF9NRVRBREFUQV9TSVpFLCBib3RoIHRoZSBYRFAgcHJvZ3JhbSBhbmQgdXNlcg0KPj4+IGFwcGxp
Y2F0aW9uIG5vdyBjYWxjdWxhdGUgYW5kIGlkZW50aWZ5IHRoZSBsb2NhdGlvbiBvZiBzdHJ1Y3Qg
eGRwX21ldGEgZnJvbQ0KPj4+IHRoZSBkYXRhIHBvaW50ZXIuIFRoaXMgZW5zdXJlcyB0aGUgaW1w
bGVtZW50YXRpb24gcmVtYWlucyBmdW5jdGlvbmFsIGV2ZW4NCj4+PiB3aGVuIHRoZXJlIGlzIGRl
dmljZS1yZXNlcnZlZCBtZXRhZGF0YSwgbWFraW5nIHRoZSB0ZXN0cyBtb3JlIHBvcnRhYmxlDQo+
Pj4gYWNyb3NzIGRpZmZlcmVudCBOSUNzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU29uZyBZ
b29uZyBTaWFuZyA8eW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3hkcF9tZXRhZGF0YS5jIHwgIDIg
Ky0NCj4+PiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hkcF9od19tZXRhZGF0
YS5jICAgfCAxMCArKysrKysrKystDQo+Pj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9w
cm9ncy94ZHBfbWV0YWRhdGEuYyAgICAgIHwgIDggKysrKysrKy0NCj4+PiAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3hkcF9od19tZXRhZGF0YS5jICAgICAgICAgfCAgMiArLQ0KPj4+ICB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveGRwX21ldGFkYXRhLmggICAgICAgICAgICB8ICA3
ICsrKysrKysNCj4+PiAgNSBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9nX3Rlc3RzL3hkcF9tZXRhZGF0YS5jDQo+PmIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL3Byb2dfdGVzdHMveGRwX21ldGFkYXRhLmMNCj4+PiBpbmRleCAxOWY5MmFmZmMyZGEuLjhk
NmMyNjMzNjk4YiAxMDA2NDQNCj4+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
cHJvZ190ZXN0cy94ZHBfbWV0YWRhdGEuYw0KPj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL3hkcF9tZXRhZGF0YS5jDQo+Pj4gQEAgLTMwMiw3ICszMDIsNyBA
QCBzdGF0aWMgaW50IHZlcmlmeV94c2tfbWV0YWRhdGEoc3RydWN0IHhzayAqeHNrLCBib29sDQo+
PnNlbnRfZnJvbV9hZl94ZHApDQo+Pj4NCj4+PiAgCS8qIGN1c3RvbSBtZXRhZGF0YSAqLw0KPj4+
DQo+Pj4gLQltZXRhID0gZGF0YSAtIHNpemVvZihzdHJ1Y3QgeGRwX21ldGEpOw0KPj4+ICsJbWV0
YSA9IGRhdGEgLSBYRFBfTUVUQURBVEFfU0laRTsNCj4+Pg0KPj4+ICAJaWYgKCFBU1NFUlRfTkVR
KG1ldGEtPnJ4X3RpbWVzdGFtcCwgMCwgInJ4X3RpbWVzdGFtcCIpKQ0KPj4+ICAJCXJldHVybiAt
MTsNCj4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hk
cF9od19tZXRhZGF0YS5jDQo+PmIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hk
cF9od19tZXRhZGF0YS5jDQo+Pj4gaW5kZXggMzMwZWNlMmVhYmRiLi43MjI0MmFjMWNkY2QgMTAw
NjQ0DQo+Pj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hkcF9od19t
ZXRhZGF0YS5jDQo+Pj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hk
cF9od19tZXRhZGF0YS5jDQo+Pj4gQEAgLTI3LDYgKzI3LDcgQEAgZXh0ZXJuIGludCBicGZfeGRw
X21ldGFkYXRhX3J4X3ZsYW5fdGFnKGNvbnN0IHN0cnVjdA0KPj54ZHBfbWQgKmN0eCwNCj4+PiAg
U0VDKCJ4ZHAuZnJhZ3MiKQ0KPj4+ICBpbnQgcngoc3RydWN0IHhkcF9tZCAqY3R4KQ0KPj4+ICB7
DQo+Pj4gKwlpbnQgbWV0YWxlbl91c2VkLCBtZXRhbGVuX3RvX2FkanVzdDsNCj4+PiAgCXZvaWQg
KmRhdGEsICpkYXRhX21ldGEsICpkYXRhX2VuZDsNCj4+PiAgCXN0cnVjdCBpcHY2aGRyICppcDZo
ID0gTlVMTDsNCj4+PiAgCXN0cnVjdCB1ZHBoZHIgKnVkcCA9IE5VTEw7DQo+Pj4gQEAgLTcyLDcg
KzczLDE0IEBAIGludCByeChzdHJ1Y3QgeGRwX21kICpjdHgpDQo+Pj4gIAkJcmV0dXJuIFhEUF9Q
QVNTOw0KPj4+ICAJfQ0KPj4+DQo+Pj4gLQllcnIgPSBicGZfeGRwX2FkanVzdF9tZXRhKGN0eCwg
LShpbnQpc2l6ZW9mKHN0cnVjdCB4ZHBfbWV0YSkpOw0KPj4NCj4+Wy4uXQ0KPj4NCj4+PiArCW1l
dGFsZW5fdXNlZCA9IGN0eC0+ZGF0YSAtIGN0eC0+ZGF0YV9tZXRhOw0KPj4NCj4+SXMgdGhlIGlu
dGVudCBoZXJlIHRvIHF1ZXJ5IGhvdyBtdWNoIG1ldGFkYXRhIGhhcyBiZWVuIGNvbnN1bWVkL3Jl
c2VydmVkDQo+PmJ5IHRoZSBkcml2ZXI/DQo+WWVzLg0KPg0KPj5Mb29raW5nIGF0IElHQyBpdCBo
YXMgdGhlIGZvbGxvd2luZyBjb2RlL2NvbW1lbnQ6DQo+Pg0KPj4JYmktPnhkcC0+ZGF0YSArPSBJ
R0NfVFNfSERSX0xFTjsNCj4+DQo+PgkvKiBIVyB0aW1lc3RhbXAgaGFzIGJlZW4gY29waWVkIGlu
dG8gbG9jYWwgdmFyaWFibGUuIE1ldGFkYXRhDQo+PgkgKiBsZW5ndGggd2hlbiBYRFAgcHJvZ3Jh
bSBpcyBjYWxsZWQgc2hvdWxkIGJlIDAuDQo+PgkgKi8NCj4+CWJpLT54ZHAtPmRhdGFfbWV0YSAr
PSBJR0NfVFNfSERSX0xFTjsNCj4+DQo+PkFyZSB5b3Ugc3VyZSB0aGF0IG1ldGFkYXRhIHNpemUg
aXMgY29ycmVjdGx5IGV4cG9zZWQgdG8gdGhlIGJwZiBwcm9ncmFtPw0KPllvdSBhcmUgcmlnaHQs
IHRoZSBjdXJyZW50IGlnYyBkcml2ZXIgZGlkbid0IGV4cG9zZSB0aGUgbWV0YWRhdGEgc2l6ZSBj
b3JyZWN0bHkuDQo+SSBzdWJtaXR0ZWQgWzFdIHRvIGZpeCBpdC4NCj4NCj5bMV0gaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2ludGVsLXdpcmVkLQ0KPmxhbi9wYXRjaC8yMDI1
MDcwMTA4MDk1NS4zMjczMTM3LTEteW9vbmcuc2lhbmcuc29uZ0BpbnRlbC5jb20vDQo+DQo+Pg0K
Pj5NeSBhc3N1bXB0aW9ucyB3YXMgdGhhdCB3ZSBzaG91bGQganVzdCB1bmNvbmRpdGlvbmFsbHkg
ZG8gYnBmX3hkcF9hZGp1c3RfbWV0YQ0KPj53aXRoIC1YRFBfTUVUQURBVEFfU0laRSBhbmQgdGhh
dCBzaG91bGQgYmUgZ29vZCBlbm91Z2guDQo+DQo+VGhlIGNoZWNraW5nIGlzIGp1c3QgZm9yIHBy
ZWNhdXRpb25zLiBObyBwcm9ibGVtIGlmIGRpcmVjdGx5IGFkanVzdCB0aGUgbWV0YQ0KPnVuY29u
ZGl0aW9uYWxseS4NCj5UaGF0IHdpbGwgc2F2ZSBwcm9jZXNzaW5nIHRpbWUgZm9yIGVhY2ggcGFj
a2V0IGFzIHdlbGwuDQo+SSB3aWxsIHJlbW92ZSB0aGUgY2hlY2tpbmcgYW5kIHN1Ym1pdCB2Mi4N
Cj4NCj5UaGFua3MgJiBSZWdhcmRzDQo+U2lhbmcNCj4NCg0KSGkgU3RhbmlzbGF2IEZvbWljaGV2
LA0KDQpJIHN1Ym1pdHRlZCB2Mi4gQnV0IGFmdGVyIHRoYXQsIEkgdGhpbmsgdHdpY2UuIElNSE8s
IA0KZXJyID0gYnBmX3hkcF9hZGp1c3RfbWV0YShjdHgsIChpbnQpKGN0eC0+ZGF0YSAtIGN0eC0+
ZGF0YV9tZXRhIC0gWERQX01FVEFEQVRBX1NJWkUpKTsNCmlzIGJldHRlciB0aGFuDQplcnIgPSBi
cGZfeGRwX2FkanVzdF9tZXRhKGN0eCwgLShpbnQpWERQX01FVEFEQVRBX1NJWkUpOw0KYmVjYXVz
ZSBpdCBpcyBtb3JlIHJvYnVzdC4NCg0KQW55IHRob3VnaHRzPw0KDQpUaGFua3MgJiBSZWdhcmRz
DQpTaWFuZw0K

