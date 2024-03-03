Return-Path: <linux-kselftest+bounces-5795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25486F3DD
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 08:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0387AB22D2A
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F98BFA;
	Sun,  3 Mar 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBwOatBF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208C6FBD;
	Sun,  3 Mar 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709450147; cv=fail; b=Gb8X9y4qcgSw241gpw6+zCasZ0EymkDhP2GBMk+OI/NHltgykmNXJfOIt6lOwECh1BwEhfVba6hLI4wULeYmcpfsr0RURc9qFjIGh7RQqPgC4p1Vn9u3q50boVWnhvi8gz1XGJPrew/9/d5QfwH7taqTfWk3jcuwOQhT71pRW+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709450147; c=relaxed/simple;
	bh=r/Tjtcy/oUcDojmdJqP1Zp1Aq8O1E0CDvTTcpnOXwcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SfgSRHN2VMWYLsTkdr+Za9tXc3eZz0rz8j7Ga3op15qg/zDpy0BU86Ap0Gh2++1fg8SQKzDP2C50CA14V2U10uNcLJpzztTfdnRu697/cumMlJErbDfp2XrhZyZbz1IqNDNBlB8iS2levW5ps35s1IL2NFBHNthNcyXhgn2XqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBwOatBF; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709450144; x=1740986144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r/Tjtcy/oUcDojmdJqP1Zp1Aq8O1E0CDvTTcpnOXwcw=;
  b=XBwOatBF4JDm1X8OCdx0PfXdkaOgAPMNk4w/0xpmOnJmH3/vZjCWNMij
   gKfujsqSvvUXHcmFAvKPl1si8cEKLVD1gNRLuRWhTA8qWJLZPkU4zu0Zv
   nJX6UKIHmVbmxQ4OxG5WcKsC52NJUAHq7BS8nJtE5NRXDgfP/IEfB7xqa
   aCp9G9ZtH5VGRvBbfbznp063xPiwGjL3BmaTN8k1tJTuFd4fI9a4aNBIu
   ojTtLY9x/wb9oTyFY2MfSVQ0Gtny3XVWHduJQqC0uV/5pi/IKuq7Tg2gS
   dasTVLSlr7z949u4Ogdx+GBcCalRxbx7U0ceP0wAndQ91aucv+/erJnga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="15363084"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="15363084"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 23:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="8587023"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2024 23:15:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 23:15:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 2 Mar 2024 23:15:43 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 23:15:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps0RmCsubI83NgwZHKBHOYJGs7Ig7x8lp2LBh1fSMd5cPQNQohpeb99UPg9qeZR+0uUosFRpVwe44Rglb06J0zIdpSCumJt9m003TL2KyW+DobEWLlK5/4qXl+UkVdByaVYHPfwVCxqybFzB2qkHzMCdDbCVppEpRpscoc/dh5MuBm6nR6pHcPQq2neosf6MbheUn/EUshIX5Q6yHpL9E+Gl/mePoM4vjTlCShaq/jz/uBgbrfTzexGZ5JdrhhZGY2Ofl2c0+Ev0fs5oLfhq66valteQ/YMOQq5yLCV/5vqFlzpjcfq0eX5PZTLsCImm5XmQ+s7kyf8C3hV7PCj6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Tjtcy/oUcDojmdJqP1Zp1Aq8O1E0CDvTTcpnOXwcw=;
 b=Stn5xeFawNmiFPdpBRJI11ooX3djcr8lMZZJzr+iYDMRyVQq2TN4wHbLZhWyjawEqlIj6h2A73nvHHkmpjfCJyMocqSujZwYZxG7KfuJZrrjSqjiUp/+t4Tuvez4u2vtH+xLJzDdSjxP/OaH5MG71CiQ7Q0fvE6eQXmHmfMieNTtlmuFziVIQppbh/iDhBjdiojhefDCf5MGI9I2Sp3PM3DkYuz8LPIWKiZDXe2O1i12qcs7hF6snwyYvkqBZNWtY4j7J7dUtJPO3LtQWf4HR0/NW8uCr7Qm4b4MTUyfleNe31yvnKufaJ999nd5zd24T8GD+tqFymq0JqS9KkSDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Sun, 3 Mar
 2024 07:15:35 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::9445:5793:b0b7:711a%7]) with mapi id 15.20.7362.015; Sun, 3 Mar 2024
 07:15:35 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: John Fastabend <john.fastabend@gmail.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, "Hao Luo"
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: RE: [PATCH iwl-next,v2 2/2] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Topic: [PATCH iwl-next,v2 2/2] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Index: AQHabAGNMRi+WAUgMkShE1BGP39O97EjyRHggAF7ooCAAFePsA==
Date: Sun, 3 Mar 2024 07:15:35 +0000
Message-ID: <PH0PR11MB5830C0636B1C7E5C185BFEF6D85C2@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240301162348.898619-1-yoong.siang.song@intel.com>
 <20240301162348.898619-3-yoong.siang.song@intel.com>
 <65e2165a89ed0_5dcfe20823@john.notmuch>
 <PH0PR11MB58305CA6B9ECA2005DC315CCD85D2@PH0PR11MB5830.namprd11.prod.outlook.com>
 <65e3d963c6dc0_8ee3b20879@john.notmuch>
In-Reply-To: <65e3d963c6dc0_8ee3b20879@john.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SJ0PR11MB6789:EE_
x-ms-office365-filtering-correlation-id: 30282dd5-f57f-45d6-d743-08dc3b51b8b0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gS8hvQcf5EDsIcdu1gtyTEHlgfPrtwsVwQ0+tmYPZSKQ4/X/ocdnpFv19zc4cbJadRpzXZu38jyQ4Mqz47tXPH3vwd1k3Ce+rS6VnExwSb2OowyqGWMZTQyp+pIZBA7RE4h85fkN4vACig64Zl6Q9id8wIcAGhSlv1pFLSF86H/mmE5mw+w1ZVrctSVAxQezkbvUTgNgwMlLzI3XVrz5SRM0Y5Z0Pcar4RPFvp1Kjk03uzoYOl/tm/QWb20Y2+9IXkm6xSOgpp3lmTH6wG+Oy7CGReeCyrKaFnXi3YQHMjslTPGe9xDClbh2EfMOSLs6Yp7jYG2sqsbgNEldkRWXIEvN+bNz6oX79/mvi1udlWqmit1on0sx4WQ/jYqBkMxP00y4iCrrQbnCUV6BrK9JneBnZZXVNKlsyZiuKDr0nMTNUFYtD8mwgr3j6L0NXUYhA5Wwbifz/J6tTi5SlRWCQZikPcqxsrEHB4SSmpA5yF26da7qdsUx6S53taLeY1RUbVhkTXjybUQYK3w/iV4J8/RK1Kr9A7ZlPZUJiY6C7MNwxpiQ/krVqTX+JP63H+toKE5Zo35jS7hkYKZwnxSmoOLlrx1heDhVdEuP5oLS8IZHUB+x1d4/T7wTR7x+zmcZ0YDIZEnEWnAxa9ONcfr2IYN8B4s6JFRC5aBtqhEs0OLZYEy4qim+Pk/zc5jDeEMlDrfUV6j5gs784PUdbwRcufcmps0r6SXONN6mEMdaxrc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDVYV0p4SGJ2VjBmbWFIY2NCdFBRek5VbENoRllXQVpiREkzYURmTVMrNDR1?=
 =?utf-8?B?OWVXRENzbkJRdUNlWnQ0ODRBUzRWc0VzNWpaWERKSTh6SGJKNllVTDhPTHNE?=
 =?utf-8?B?R3VzV215aWtRckFPZTc5YjJ5R2FBeGtQSno0eTh3cFlQM3JuQXZ5UWJObkQx?=
 =?utf-8?B?UUlmMUUyZFhKbjd6enpUc2VXakFFZVdIYWM5V0JlejJmdHhnQWx2NmJON3Qy?=
 =?utf-8?B?aXF2QWdPY0ZOMDBzZmJBaW1xOU40d1ZQVTRLRkthb3NPSEtWb0JubFRmc1FQ?=
 =?utf-8?B?end2VDJ3QnpXVS9seEdFTEVIN0Z0KzNsQzUrSUttOGdOSWlySXBFZVZyOVFE?=
 =?utf-8?B?UmljMVVUV3plK2FmUzZzZTBReG5rcmFOTFhrT2ZsNGJKRTJYa1dSTXg3T2wz?=
 =?utf-8?B?SFJ0VGZhM1B1NWlna1FyWUZ1d2JjZUc4RlhnZThSRkFodmE0Z0NHOFMwajNZ?=
 =?utf-8?B?Z2ZDZTI5RWJUaXhabTluT0o2RWRLS3NNUDBvNUoyTWNleFRwUmRtMThkQ3VJ?=
 =?utf-8?B?cU9OVDZGYi9RZmFQa0trQ0tzNDdudWRRWUdPMlVYTHp4VldEUWZwMlg3Szd0?=
 =?utf-8?B?RXlvRmxDSDkyTURWRnUycjI3UHBtSFVRbFJXTjY5bTZValBPdEFTUmhVNjh5?=
 =?utf-8?B?Y0JOSGtFVzFwVUFtemNQMVFlVkFuSmRtYjRGdTAyS2ZueEUxeFAwOStLRnFw?=
 =?utf-8?B?Rkd1Y0paNG8vZEgxQkVJZGIvMi9NdzRvcUZwYk1LanFSREdrV2JiZ1pxWHB4?=
 =?utf-8?B?blZESFdlNmVZWXIrU0hqV0dWakl6QWNUdGtRUWJEYjVUYmJ4RjhaRUpSb0tz?=
 =?utf-8?B?TjIwbEUrODR5R0h3SzZmWGdTcXg3RlZxbVVGU21xR0dFdzBhajBsaThmRHN4?=
 =?utf-8?B?OUZFajQxdnRaYlVUaXNCZFRXYTlyZTRWT2RWZDNOaGIvekFTZndNTzBXbmU3?=
 =?utf-8?B?S1VWSG16RDNjcnJMVE8yZ3lzbG5NdzZkZk9na3d0M2FVWitTUDRuU05SZXRw?=
 =?utf-8?B?UzcxaG41RmNONDltd0krV2VzVFBxRGFCejh6T1NoaDRvSlVabzh6MkFZcDlP?=
 =?utf-8?B?eE9nVi9TZVVhZlJuRWlNSVpBeWRObnl1OGZkbHYvQ3JpYnpDMndxV0FHbjhu?=
 =?utf-8?B?cW14dkRXTlhOMFk5ajRoNTRGaU1ZWWgvRWtoRUh6TC83OWtDNzBLSnc4NzFI?=
 =?utf-8?B?S0xFQWJPZVd4RHNUR1NLRGdkWHpCWDVEZWZGcVBtZ3VnVEdIek9SRmxLbG0z?=
 =?utf-8?B?VlA4UFg1TU41b3NsVDBOSVl0SEQ3bkI3N3NEVUY1UUN6Zm4xZzlETEN2MEN6?=
 =?utf-8?B?NkEyZXdZK1g1QTFXV003ZlVOcVpiRVRoRU50ZVJWZkVzVXlqa2JWSFI4bUZH?=
 =?utf-8?B?eDBQZXhMaDhqOUNtZFJFb1BJT21pZXNLckh0WFJQT2hHbmZZdXFuMncyNkpr?=
 =?utf-8?B?b1gyTFFoL3MxeGl6UmJlTFZ1aVgvRWVnV2k4NnNYdDAySVQrSG5SNWZ1Q1Q3?=
 =?utf-8?B?aFBWZWFudk5uMWlEV0g5NjFCV2w1eU44aGNRQ0JmSldnY3FZSTNoUGF1SVlC?=
 =?utf-8?B?TTF2RVlJbzRRbkI1Yk1yRHNWeWtSbE5YaEpMSFR5OU5JMmtteGJ0dHc1ek5s?=
 =?utf-8?B?ZDBMNlJjQmYzS0Q4Rk4xb09oQXhPb0cybktjSTcyYlhweHpwMURDOHNzTndP?=
 =?utf-8?B?dGFMZWxrZ3dqbmNvMlc0amdHMitEaURZemFHMW44bWtWNWhzelZPRHcvZVdV?=
 =?utf-8?B?ei9aVTNabVRZOVZ2MWw5eEtNNjM0d3VPK2pUOGM4V3ZPM1l1dDdKRXdrRG9H?=
 =?utf-8?B?OXJCY25kcE5mWGdoTDRGUHB0b3Y5YUFLYU91cklubUhGZTd4Y2hzSjhmN3VV?=
 =?utf-8?B?S1d1elZySG03L0Uxc2hLT0ZSdEdHQUhrc0licHNnNC8wOG9JaHZmclRnNUVp?=
 =?utf-8?B?ZE9YVk8zUTVDanMxNWVJdDBlWEkzQi81aXhMWGFYTUhsUjIrQ1EyVWlJeTk1?=
 =?utf-8?B?dkdSeEFYWkpUaURXT3lXK3J6NHpOOEFlV0tmb0lWV29WS1hRelBKUDBPZ2F6?=
 =?utf-8?B?UGo2bko0dk9adm9nV2FBMFlKeEJWMCt5YVdpUEV2WmVHZks2S3hYNFZ3VVJw?=
 =?utf-8?B?NXk3Ti9oTm4ycnhMWjlWYlN1OXRkcFVPMWtMdlFsaGZTbU13NkVCU0hXVHVw?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30282dd5-f57f-45d6-d743-08dc3b51b8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 07:15:35.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBhmoIeSaWzHeGSFkF/N7KNNXG5SnkDXHuDwb13EqQPbdnnP818Zz/6T8FvzNmDFXQTZyNCTxujRQtnCSm5RC85VBOznDpJgaiC/53dMNd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
X-OriginatorOrg: intel.com

T24gU3VuZGF5LCBNYXJjaCAzLCAyMDI0IDk6NTkgQU0sIEpvaG4gRmFzdGFiZW5kIDxqb2huLmZh
c3RhYmVuZEBnbWFpbC5jb20+IHdyb3RlOg0KPlNvbmcsIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4g
T24gU2F0dXJkYXksIE1hcmNoIDIsIDIwMjQgMTo1NSBBTSwgSm9obiBGYXN0YWJlbmQgPGpvaG4u
ZmFzdGFiZW5kQGdtYWlsLmNvbT4gd3JvdGU6DQo+PiA+U29uZyBZb29uZyBTaWFuZyB3cm90ZToN
Cj4+ID4+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IHRvIHBlci1wYWNrZXQgVHggaGFyZHdhcmUg
dGltZXN0YW1wIHJlcXVlc3QgdG8NCj4+ID4+IEFGX1hEUCB6ZXJvLWNvcHkgcGFja2V0IHZpYSBY
RFAgVHggbWV0YWRhdGEgZnJhbWV3b3JrLiBQbGVhc2Ugbm90ZSB0aGF0DQo+PiA+PiB1c2VyIG5l
ZWRzIHRvIGVuYWJsZSBUeCBIVyB0aW1lc3RhbXAgY2FwYWJpbGl0eSB2aWEgaWdjX2lvY3RsKCkg
d2l0aA0KPj4gPj4gU0lPQ1NIV1RTVEFNUCBjbWQgYmVmb3JlIHNlbmRpbmcgeHNrIFR4IGhhcmR3
YXJlIHRpbWVzdGFtcCByZXF1ZXN0Lg0KPj4gPj4NCj4+ID4+IFNhbWUgYXMgaW1wbGVtZW50YXRp
b24gaW4gUlggdGltZXN0YW1wIFhEUCBoaW50cyBrZnVuYyBtZXRhZGF0YSwgVGltZXIgMA0KPj4g
Pj4gKGFkanVzdGFibGUgY2xvY2spIGlzIHVzZWQgaW4geHNrIFR4IGhhcmR3YXJlIHRpbWVzdGFt
cC4gaTIyNS9pMjI2IGhhdmUNCj4+ID4+IGZvdXIgc2V0cyBvZiB0aW1lc3RhbXBpbmcgcmVnaXN0
ZXJzLiBCb3RoICpza2IgYW5kICp4c2tfdHhfYnVmZmVyIHBvaW50ZXJzDQo+PiA+PiBhcmUgdXNl
ZCB0byBpbmRpY2F0ZSB3aGV0aGVyIHRoZSB0aW1lc3RhbXBpbmcgcmVnaXN0ZXIgaXMgYWxyZWFk
eSBvY2N1cGllZC4NCj4+ID4+DQo+PiA+PiBGdXJ0aGVybW9yZSwgYSBib29sZWFuIHZhcmlhYmxl
IG5hbWVkIHhza19wZW5kaW5nX3RzIGlzIHVzZWQgdG8gaG9sZCB0aGUNCj4+ID4+IHRyYW5zbWl0
IGNvbXBsZXRpb24gdW50aWwgdGhlIHR4IGhhcmR3YXJlIHRpbWVzdGFtcCBpcyByZWFkeS4gVGhp
cyBpcw0KPj4gPj4gYmVjYXVzZSwgZm9yIGkyMjUvaTIyNiwgdGhlIHRpbWVzdGFtcCBub3RpZmlj
YXRpb24gZXZlbnQgY29tZXMgc29tZSB0aW1lDQo+PiA+PiBhZnRlciB0aGUgdHJhbnNtaXQgY29t
cGxldGlvbiBldmVudC4gVGhlIGRyaXZlciB3aWxsIHJldHJpZ2dlciBoYXJkd2FyZSBpcnENCj4+
ID4+IHRvIGNsZWFuIHRoZSBwYWNrZXQgYWZ0ZXIgcmV0cmlldmUgdGhlIHR4IGhhcmR3YXJlIHRp
bWVzdGFtcC4NCj4+ID4+DQo+PiA+PiBCZXNpZGVzLCB4c2tfbWV0YSBpcyBhZGRlZCBpbnRvIHN0
cnVjdCBpZ2NfdHhfdGltZXN0YW1wX3JlcXVlc3QgYXMgYSBob29rDQo+PiA+PiB0byB0aGUgbWV0
YWRhdGEgbG9jYXRpb24gb2YgdGhlIHRyYW5zbWl0IHBhY2tldC4gV2hlbiB0aGUgVHggdGltZXN0
YW1wDQo+PiA+PiBpbnRlcnJ1cHQgaXMgZmlyZWQsIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciB3aWxs
IGNvcHkgdGhlIHZhbHVlIG9mIFR4IGh3dHMNCj4+ID4+IGludG8gbWV0YWRhdGEgbG9jYXRpb24g
dmlhIHhza190eF9tZXRhZGF0YV9jb21wbGV0ZSgpLg0KPj4gPj4NCj4+ID4+IENvLWRldmVsb3Bl
ZC1ieTogTGFpIFBldGVyIEp1biBBbm4gPGp1bi5hbm4ubGFpQGludGVsLmNvbT4NCj4+ID4+IFNp
Z25lZC1vZmYtYnk6IExhaSBQZXRlciBKdW4gQW5uIDxqdW4uYW5uLmxhaUBpbnRlbC5jb20+DQo+
PiA+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIFlvb25nIFNpYW5nIDx5b29uZy5zaWFuZy5zb25nQGlu
dGVsLmNvbT4NCj4+ID4+IC0tLQ0KPj4gPg0KPj4gPlsuLi5dDQo+PiA+DQo+PiA+Pg0KPj4gPj4g
K3N0YXRpYyB2b2lkIGlnY194c2tfcmVxdWVzdF90aW1lc3RhbXAodm9pZCAqX3ByaXYpDQo+PiA+
PiArew0KPj4gPj4gKwlzdHJ1Y3QgaWdjX21ldGFkYXRhX3JlcXVlc3QgKm1ldGFfcmVxID0gX3By
aXY7DQo+PiA+PiArCXN0cnVjdCBpZ2NfcmluZyAqdHhfcmluZyA9IG1ldGFfcmVxLT50eF9yaW5n
Ow0KPj4gPj4gKwlzdHJ1Y3QgaWdjX3R4X3RpbWVzdGFtcF9yZXF1ZXN0ICp0c3RhbXA7DQo+PiA+
PiArCXUzMiB0eF9mbGFncyA9IElHQ19UWF9GTEFHU19UU1RBTVA7DQo+PiA+PiArCXN0cnVjdCBp
Z2NfYWRhcHRlciAqYWRhcHRlcjsNCj4+ID4+ICsJdW5zaWduZWQgbG9uZyBsb2NrX2ZsYWdzOw0K
Pj4gPj4gKwlib29sIGZvdW5kID0gZmFsc2U7DQo+PiA+PiArCWludCBpOw0KPj4gPj4gKw0KPj4g
Pj4gKwlpZiAodGVzdF9iaXQoSUdDX1JJTkdfRkxBR19UWF9IV1RTVEFNUCwgJnR4X3JpbmctPmZs
YWdzKSkgew0KPj4gPj4gKwkJYWRhcHRlciA9IG5ldGRldl9wcml2KHR4X3JpbmctPm5ldGRldik7
DQo+PiA+PiArDQo+PiA+PiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRhcHRlci0+cHRwX3R4X2xv
Y2ssIGxvY2tfZmxhZ3MpOw0KPj4gPj4gKw0KPj4gPj4gKwkJLyogU2VhcmNoIGZvciBhdmFpbGFi
bGUgdHN0YW1wIHJlZ3MgKi8NCj4+ID4+ICsJCWZvciAoaSA9IDA7IGkgPCBJR0NfTUFYX1RYX1RT
VEFNUF9SRUdTOyBpKyspIHsNCj4+ID4+ICsJCQl0c3RhbXAgPSAmYWRhcHRlci0+dHhfdHN0YW1w
W2ldOw0KPj4gPj4gKw0KPj4gPj4gKwkJCWlmICh0c3RhbXAtPnNrYikNCj4+ID4+ICsJCQkJY29u
dGludWU7DQo+PiA+PiArDQo+PiA+PiArCQkJZm91bmQgPSB0cnVlOw0KPj4gPj4gKwkJCWJyZWFr
Ow0KPj4gPg0KPj4gPk5vdCBob3cgSSB3b3VsZCBoYXZlIHdyaXR0ZW4gdGhpcyBsb29wIGNvbnN0
cnVjdCBzZWVtcyBhIGJpdCBvZGQNCj4+ID50byBkZWZhdWx0IGJyZWFrIGJ1dCBpdCB3b3Jrcy4N
Cj4+DQo+PiBIaSBKb2huLA0KPj4gRmlyc3Qgb2YgYWxsLCB0aGFuayB5b3UgZm9yIHJldmlld2lu
ZyB0aGUgcGF0Y2guDQo+PiBJIGFncmVlIHRoYXQgd2UgY2FuIG1ha2UgdGhlIGxvb3AgYmV0dGVy
Lg0KPj4gSG93IGFib3V0IEkgY2hhbmdlIHRoZSBsb29wIHRvIGJlbG93Og0KPg0KPlRoYXQgaXMg
bW9yZSBuYXR1cmFsIHRvIG1lLCBidXQgd2hhdGV2ZXIgcmVhZHMgYmVzdCBmb3IgeW91DQo+aXMg
cHJvYmFibHkgb2suDQo+DQoNCkkgYW0gb2sgd2l0aCBib3RoIHZlcnNpb25zLg0KSSB3aWxsIGNo
YW5nZSBpdCBpbiBuZXh0IHZlcnNpb24gZm9yIGJldHRlciByZWFkYWJpbGl0eSBhbmQgY2xhcml0
eS4NCg0KPj4NCj4+IGZvciAoaSA9IDA7IGkgPCBJR0NfTUFYX1RYX1RTVEFNUF9SRUdTOyBpKysp
IHsNCj4+IAl0c3RhbXAgPSAmYWRhcHRlci0+dHhfdHN0YW1wW2ldOw0KPj4NCj4+IAlpZiAoIXRz
dGFtcC0+c2tiKSB7DQo+PiAJCWZvdW5kID0gdHJ1ZTsNCj4+IAkJYnJlYWs7DQo+PiAJfQ0KPj4g
fQ0KPj4NCj4+ID4NCj4+ID4+ICsJCX0NCj4+ID4+ICsNCj4+ID4+ICsJCS8qIFJldHVybiBpZiBu
byBhdmFpbGFibGUgdHN0YW1wIHJlZ3MgKi8NCj4+ID4+ICsJCWlmICghZm91bmQpIHsNCj4+ID4+
ICsJCQlhZGFwdGVyLT50eF9od3RzdGFtcF9za2lwcGVkKys7DQo+PiA+PiArCQkJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmYWRhcHRlci0+cHRwX3R4X2xvY2ssDQo+PiA+PiArCQkJCQkgICAgICAg
bG9ja19mbGFncyk7DQo+PiA+PiArCQkJcmV0dXJuOw0KPj4gPj4gKwkJfQ0KPj4gPg0KPj4gPlsu
Li5dDQo+PiA+DQo+PiA+Pg0KPj4gPj4gK3N0YXRpYyB2b2lkIGlnY19wdHBfZnJlZV90eF9idWZm
ZXIoc3RydWN0IGlnY19hZGFwdGVyICphZGFwdGVyLA0KPj4gPj4gKwkJCQkgICBzdHJ1Y3QgaWdj
X3R4X3RpbWVzdGFtcF9yZXF1ZXN0ICp0c3RhbXApDQo+PiA+PiArew0KPj4gPj4gKwlpZiAodHN0
YW1wLT5idWZmZXJfdHlwZSA9PSBJR0NfVFhfQlVGRkVSX1RZUEVfWFNLKSB7DQo+PiA+PiArCQkv
KiBSZWxlYXNlIHRoZSB0cmFuc21pdCBjb21wbGV0aW9uICovDQo+PiA+PiArCQl0c3RhbXAtPnhz
a190eF9idWZmZXItPnhza19wZW5kaW5nX3RzID0gZmFsc2U7DQo+PiA+PiArCQl0c3RhbXAtPnhz
a190eF9idWZmZXIgPSBOVUxMOw0KPj4gPj4gKwkJdHN0YW1wLT5idWZmZXJfdHlwZSA9IDA7DQo+
PiA+PiArDQo+PiA+PiArCQkvKiBUcmlnZ2VyIHR4cnggaW50ZXJydXB0IGZvciB0cmFuc21pdCBj
b21wbGV0aW9uICovDQo+PiA+PiArCQlpZ2NfeHNrX3dha2V1cChhZGFwdGVyLT5uZXRkZXYsIHRz
dGFtcC0+eHNrX3F1ZXVlX2luZGV4LCAwKTsNCj4+ID4NCj4+ID5KdXN0IGN1cmlvdXMgYmVjYXVz
ZSBJIGRpZG4ndCBmaW5kIGl0LiBGYWlybHkgc3VyZSBJIGp1c3QgbmVlZCB0byBsb29rIG1vcmUs
DQo+PiA+YnV0IGRvbid0IHlvdSB3YW50IHRvIHN0aWxsICd0c3RhbXAtPnNrYiA9IE5VTEwnIGlu
IHRoaXMgcGF0aCBzb21ld2hlcmU/DQo+PiA+SXQgbG9va3MgbGlrZSB0cmlnZ2VyaW5nIHRoZSB0
eCBpbnRlcnJ1cHQgYWdhaW4gd2l0aCBidWZmZXJfdHlwZSA9PSAwIHdvdWxkbid0DQo+PiA+ZG8g
dGhlIG51bGwuDQo+PiA+DQo+PiA+SSBzdXNwZWN0IEkganVzdCBtaXNzZWQgaXQuDQo+Pg0KPj4g
U2luY2UgdGhlIHRpbWVzdGFtcCByZWdpc3RlciB3aWxsIG9ubHkgYmUgdXNlZCBieSBlaXRoZXIg
c2tiIG9yIHhzaywNCj4+IFNvIHdlIG1ha2UgdHN0YW1wLT54c2tfdHhfYnVmZmVyIGFuZCB0c3Rh
bXAtPnNrYiBhcyB1bmlvbiwNCj4+IFRoZW4gYmFzZWQgb24gdHN0YW1wLT5idWZmZXJfdHlwZSB0
byBkZWNpZGUgd2hldGhlcg0KPj4gdHN0YW1wLT54c2tfdHhfYnVmZmVyIG9yIHRzdGFtcC0+c2ti
IHNob3VsZCBiZSB1c2VkLg0KPj4NCj4+IE15IHRob3VnaHQgaXMsIGJ5IHNldHRpbmcgdHN0YW1w
LT54c2tfdHhfYnVmZmVyPU5VTEwsDQo+PiB0c3RhbXAtPnNrYiB3aWxsIGJlY29tZSBOVUxMIGFz
IHdlbGwsIGFuZCB2aWNlIHZlcnNhLg0KPg0KPlNlZW1zIGdvb2QgdG8gbWUuIE1heWJlIGEgY29t
bWVudCB0aG91Z2g/IE90aGVyd2lzZSBJIHN1c3BlY3QgbmV4dA0KPnBlcnNvbiB0byByZWFkIHRo
ZSBjb2RlIHdpbGwgaGF2ZSB0byBzcGVuZCB0aGUgZXh0cmEgdGltZSB0byB0cmFjaw0KPml0IGRv
d24gYXMgd2VsbC4NCj4NCg0KU3VyZS4gSSB3aWxsIGFkZCBjb21tZW50IGluIG5leHQgdmVyc2lv
bi4NCg0KPj4NCj4+IFRoYW5rcyAmIFJlZ2FyZHMNCj4+IFNpYW5nDQo+DQo+QWxzbyBmZWVsIGZy
ZWUgdG8gY2FycnkgbXkgYWNrIGludG8gdGhlIHYyIGlmIHlvdSBtYWtlIHRoZSBjb3VwbGUNCj5z
bWFsbCBuaXRwaWNrIGNoYW5nZXMuDQo+DQo+QWNrZWQtYnk6IEpvaG4gRmFzdGFiZW5kIDxqb2hu
LmZhc3RhYmVuZEBnbWFpbC5jb20+DQo+DQpUaGFuayB5b3UgZm9yIHlvdXIgYWNrbm93bGVkZ21l
bnQuDQoNCg0K

