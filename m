Return-Path: <linux-kselftest+bounces-6405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E341487F2E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 23:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976C2280A67
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237DE59B60;
	Mon, 18 Mar 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfB8dYGj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570595A4C2;
	Mon, 18 Mar 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799509; cv=fail; b=FfbIFnAgVp82QLmqpDO+qZWBnnL3L0xgQvUNmK4ZASqxIg9xF0SAvwnAfdfOwVkAh3QBwkKE797xNS+RSqjQiab4sdsZW2H3uWirajj9V5yvWVIgqSGB/7M7DZWw34uc5x6rSvku7qnqJzqM9HYtAjZQoLi+NTwzMlAAMh2moJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799509; c=relaxed/simple;
	bh=plgQ5bOLdOI0u+RTNVovHUxoz/YyJlGCSU3xjmu3cO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F/83yWxeOfyNHPtZxBKhH/18YyKYBGCFNCKj3xXs4/PYO5aiVaHsknMmwtgCzE0wjwCN4Sz+ZT/RMjIBUDSWdPU6LonniD+APz2y2uuOyo5mXXTmaNRCIHi0AHsA4rzBykEJo7YyaWQLOGqOK7qBCMukYOeLCJTMuHyJVCwTv14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfB8dYGj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799508; x=1742335508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=plgQ5bOLdOI0u+RTNVovHUxoz/YyJlGCSU3xjmu3cO4=;
  b=bfB8dYGj28BV+ihoi8MWqxBLuMjAt5Pbzs5lVK78qPAx4UPtl7XZI4d2
   4p0AR/AXkT1W9+eRwphDcAXlFFf2lVnrquVGl7jK/8uv7MckgtqrTHOS/
   1GY72drq5qy3VizrD32mhZ2SCoMOsVGg1iIFDaTu0Q3Lm5BUPsbUlji8+
   V+wnSGXFpMwvMV4L8jCVtfgD/lCasyeVwZD+AW85hxSECXCQbOO9+fPIi
   +m+etupwTjl9UruA6tY2Xw9dkAe0ZpXvV+u+TahR3fjAZS9jcXkCH4K66
   K+rkF6fak3HFHw2b3CPsNsm8//He7q1UYIu2oebAzAOoqAbMMAdj5wWBl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="8584080"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="8584080"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13983408"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 15:04:52 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 15:04:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 15:04:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 15:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/jWxEtePh8DLKAWs6Z4PiwGjANO/6f8YCBB1yEYDmSPFhrsZTAfYJFjCczdu4bMtA+zVuSLUubv0nNMxNDY8ULWd0bwJpqLNzHT83biwhNfV4btooySdulNzvRsY3vyoRdkQ035q/6g2MPddmLfEsN3p+bv9ehLg4Vc8GiuIJ0k4Jvfx4rGthYrbRIGY4GjlC+8mgdCVjyhjkF1gDlw/7Ylf/fr+Mgl1AAoIRDBPFrylZZ+5VoPi3Gg3ARaXolGr1z0EnMIehflyihZ3bnpPf11ZWpPquGsdUybwK5a+OGFwSr+MRUt0ZPh8GWreTQLb/AYU+u1HgtYV8dUnLbCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plgQ5bOLdOI0u+RTNVovHUxoz/YyJlGCSU3xjmu3cO4=;
 b=jQTixLm4I4KY64zBOOCVr8RgjJ34trdAtC3VJh6gJlE9auls/rLJqDCk6JAvbKSfW5qB5Oy3y9HjQ/64F37redTSYuVAKhi+7FTNFW8JNcFtZHyjjsPOfkUnVkdIn0DmBgzSjncv/HJ+S6c7S66z2A66eYZy/+PJSGnU8UaRhzhaJXWdrDDCl6GYymodcLuHkQw9a453zfTBdQPmuAHVSKN/R6D2R9lsNYvULHLhrKxut47nP+OnzZA1ISef/fLiMWtTFvOl1ZTSTM6ryM1zM/D/QdOWNTRtLmniP3t+YWHmExKcMa4Ou/mkzIydsPXJKqOchHUfVZaQRj0LmJ7amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 22:04:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 22:04:47 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>, "'peternewman@google.com'" <peternewman@google.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhCAACNlgIAAEarAgAAc2ACAAUZZboAK/v/LgATLiICAAAEvkIAAFESAgAADgICAAAqcgIAAClZg
Date: Mon, 18 Mar 2024 22:04:47 +0000
Message-ID: <SJ1PR11MB6083CF09A97C13C0859D5A67FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
 <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fe4a54cf-7103-49c7-add4-ee4bcf76c7b3@intel.com>
In-Reply-To: <fe4a54cf-7103-49c7-add4-ee4bcf76c7b3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB8197:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5sOAbkl3BEq41mflTYbWYyHVguAWcrOVUFvssM7nK8HRimMfLzR/ft8WocuNXpOfuPaMREQg0KM6jn9hBTuwYYvi/y2Q8k0Mr43KjTDRA2dlGT3zylUmxIXC38P+L+x4Uc1aVItOJc/tmDNae0ex+/0PbYdb7hp9UKWLdrZ+jBU2uBVyLe3qG+wgQdslbJ/bTRhFk4oCPCxw70DOofmkbafcTmDg+T9LInbobpNN3tdVatKeg2fXwnzLUCXsa8ftzuh9lUAqz+Jl2WLzzRhOfXAx67uk7jNC3L0aKTviNi2vcpvOgbIQgpnhFUusUct2SSyVLwyg6W2+NKWShsdhtlzr1Fb5HIUGGRhyQbJA4JeStEToWsl63RGJ2KfX9KuEczuoTrHmBE0nUBQhOqZjniG1hOut1woUv4zpstyDbGiBa5YgbUSFDv+tgh1UwQdV+Aai3C1UMupfAaS2MrEC0XwA3dTeIa0524ERVGo8xnWAi+NBoDXBKlPfqGQFDK1wxAeBrYyCF21FmdvMMEHRbr/PhQvizrXH/qXKcXIaakAfJBFLEmfl0B53CxKx27ST8TLf+qX42dSLfH2F9/hwhqNH7lsdFIKJmV8qUTwc5y4Ui2y7AADOCzQUzMjv3nG/uDDJqkYpLjXerKoVHsnIc0I8TM/GxHKEJbesHFyA1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUNBWmJZalk0VGVHbUpjQmdsSHhvbE5FOXVCRzNPVWVqODdpTStMeWxNclBx?=
 =?utf-8?B?K2wwNnEzcy9XQVpnQVAxRDdSeE5XVjFmQXMxa01FdzVKSWFzS2hFcnIxUDNv?=
 =?utf-8?B?Wjl4YTZkeHNzN0tUYUJOMmplWXVndmNidWgwMTQxOTZuMjhJcU14QlFjYUpN?=
 =?utf-8?B?ODNoaC9Nb0k0a00yRnNJRzVnMzZsVkpOUmtkVUJpWlJqRk41UnRoNmZ6M25W?=
 =?utf-8?B?QVErRFl5ZjdMK081NERhZ3pPd0t5QTh1ODJ2UjJKTjJmQVhtZFZuTExSaVdh?=
 =?utf-8?B?TmRFSVZoVHpQU04rUGZTYzF0U2hLR25iYmtnaEx0SEJSSkorZEJCMTBVVVVQ?=
 =?utf-8?B?MDBVblVOZEoxWWdDL0pQenVJNjlxUkdYb1Y5Y3dyU282QzltaFlubE1tKzRC?=
 =?utf-8?B?b2ZxU3Fqc2ErK0hvT0Q3MkRxY2lTVjFRc2dzc05LbXkreG5iZ3YvZlVFMk80?=
 =?utf-8?B?UVYweG42YjhyNmZSTXZOdit2NlFQUlJLcnN2Q1dTN3JrSVNOTU5PUjBHV1Ux?=
 =?utf-8?B?YVNMQmhmcmExNE02MWx6UTdFZGNJaytvUkluby9FVldXUWtVV2R4UnlQZTdE?=
 =?utf-8?B?amZIWUg3dTZrQ1FGMEVzamZ0S2dBUWZ4UlJQY1pTeGgxZ1J2MnY3ajJ6WElw?=
 =?utf-8?B?b3ZjdzgrOVlCL1VyRHdJWGxqZFBuK3BSbnlFaGhvZUorOG9nZ3NPeXVLR2Vn?=
 =?utf-8?B?WitIaEpIUWhUbGlQZG82Vy9BZktKUEdJRjNNeEc5eEtITEhQSENGcDZFb0ti?=
 =?utf-8?B?bStiSGlwUGdGT3UxY0hoSUVMclFISXZMa041eTVUcmRFbkJNZmkwYjlLK3g3?=
 =?utf-8?B?cnl3d28vMEIrYTUwNy82V2FBTU9ENkh1dFZFU1NsYUxwVmFyZU15TWRCU0I1?=
 =?utf-8?B?aUpWQlBNZjNNQ0pKc0g4d2R0QTllTGFKZnZjZFUrK3VUSW1QOXN4N05HbXRw?=
 =?utf-8?B?UGswT2Fock1Cb1ZHYkFWZlY2ck9WdGMzc2UyTEd0RXFpVEZvRnlqN1dnMjh2?=
 =?utf-8?B?eW5kOHZEMG1JOGlKRjkxOHlOQkIxVmNxajVXdTlJdUtMa3lPUkIrN3Rmd3Zu?=
 =?utf-8?B?WkNaQkJObk5FOEp3UUdmblplOHN5eWp4WmFYb2tYRDQyVHlSTWtZQVdid25m?=
 =?utf-8?B?OWlVK215ZStkeDdMQjFiK2hBNUxUQnorTDZDMEswTVM5aEZONTNPbW1OcVN3?=
 =?utf-8?B?RU1tTm1DZ0duNzYrOGVjQ0tZdXloblpHSVBNYzhHTDFIVHljMFU2SFVLWTYw?=
 =?utf-8?B?SlB0Q1JLczA5WW9GMkxmRWx2c2llN041U2JrV25kUTVEMHN5bjYrbWExeXJJ?=
 =?utf-8?B?VkZqakhxc2dhTEhTaEc3NW1SQWRPNGJtZExrZUtZbzl6WGg3VGZRVTAzMU9o?=
 =?utf-8?B?ZXoxZWJwMDE1Z1I1enFURm9WSzg1NXljYzdBVXJiQjBha1RvZXdLYzhKMVlM?=
 =?utf-8?B?a2pLVXBLTDRtOFZUOFE0TW9jSnY3UlRETXlSWjVoK3FJZ1RSK0Y2NU1DbkV5?=
 =?utf-8?B?NGtoaW9YMjQxWC9iVjlmbHVkdEllZ0JYaEQzVDY4MFZjdDhDdmJQWEJxakpo?=
 =?utf-8?B?UmJaQ2xUNmlKL0F5WmtCR2N3cUJTMTVLOXJuZk1BazdDbWtXZXhpdnFRNmxC?=
 =?utf-8?B?KzJmZTBReVpMZTAvaEV0STduYkZRWFFhekpObHZlMjZPMmlCd2ZlUzEvOSsw?=
 =?utf-8?B?eTNiQTZhcDd0Rkk1ZUhZN2pkVkRuT05TUDZ2UHNHQnNQU2MrcmE2ZVBTaURy?=
 =?utf-8?B?QlQ0NnhHb2x6aXM3ejNUSFV2cUhObCtGN0hTSlIrdTlzVFdKSGduNFpRaGVu?=
 =?utf-8?B?TXF3anJRNzN1dEMycGxLcU5mSFg0bHd0L05rY0NqSEl2MjFEYzk3OUNZUDFB?=
 =?utf-8?B?UTNTNnZpd3lQa0JlcTBZSXRwWGh5MGFWSjNnNkFNbDBFVDRGZDVVTUZCOUVq?=
 =?utf-8?B?ZE1sV0ZPTzVuOGVVd2Q5alY1WTZGd053MDdEdXdrbktsOUdCLysrbFpuOTBQ?=
 =?utf-8?B?ZHFuMUhTRFFZSlgxOWhUU3EvSnhPY09tb3ZQcjJBMFJDblZDenFxdHIxWVN3?=
 =?utf-8?B?cXp4QWQxRFV3SGNwRUplQ0V3dGZ1dWcveTR5QzV5NHEyTlJRTGhLaUt1ZDIv?=
 =?utf-8?Q?4jfjHMQ6BNItOsImrOjZrQ3W4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d664e6c-ea4b-449a-0da3-08dc47976d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 22:04:47.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asJL7vOA9O8Jo/4Rzjl7vCuoYLZmXhI6oMp36Q0pw+D6C/rsjAOFS0BPuxNVrDhOdVsRSQ59WGJkx0Rd6tl8qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com

PiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFuZCB0aGUgZGV0YWlscyBieSBhbnN3
ZXJpbmcgbXkgZmlyc3QNCj4gcXVlc3Rpb246IFdoYXQgaXMgdGhlIHVzZSBjYXNlIGZvciBuZWVk
aW5nIHRvIGV4cG9zZSB0aGUgaW5kaXZpZHVhbCBjbHVzdGVyDQo+IGNvdW50cz8gDQo+DQo+IFRo
aXMgaXMgYSBtb2RlbCBzcGVjaWZpYyBmZWF0dXJlIHNvIGlmIHRoaXMgaXMgc29tZXRoaW5nIG5l
ZWRlZCBmb3IganVzdCBhDQo+IGNvdXBsZSBvZiBzeXN0ZW1zIEkgdGhpbmsgd2Ugc2hvdWxkIGJl
IGxlc3MgaW5jbGluZWQgdG8gbWFrZSBjaGFuZ2VzIHRvDQo+IHJlc2N0cmwgaW50ZXJmYWNlLiBJ
IGFtIHN0YXJ0aW5nIHRvIGJlIGNvbmNlcm5lZCBhYm91dCBzb21ldGhpbmcgc2ltaWxhcg0KPiBi
ZWNvbWluZyBhcmNoaXRlY3R1cmFsIGxhdGVyIGFuZCB0aGVuIHdlIG5lZWQgdG8gd3JhbmdsZSB0
aGlzIG1vZGVsIHNwZWNpZmljDQo+IHJlc2N0cmwgc3VwcG9ydCAod2hpY2ggaGFzIHRoZW4gYmVj
b21lIEFCSSkgYWdhaW4gdG8gc3VwcG9ydCB3aGF0ZXZlciB0aGF0DQo+IG1heSBsb29rIGxpa2Uu
DQoNClJlaW5ldHRlLA0KDQpNb2RlbCBzcGVjaWZpYy4gQnV0IHByZXNlbnQgaW4gbXVsdGlwbGUg
Y29uc2VjdXRpdmUgZ2VuZXJhdGlvbnMgKFNhcHBoaXJlIFJhcGlkcywNCkVtZXJhbGQgUmFwaWRz
LCBHcmFuaXRlIFJhcGlkcywgU2llcnJhIEZvcmVzdCkuDQoNCkFkZGluZyBQZXRlciBOZXdtYW4g
Zm9yIGEgcmVzY3RybCB1c2VyIHBlcnNwZWN0aXZlIG9uIFNOQywgcmF0aGVyIHRoYW4gbWUNCmNv
bnRpbnVlIHRvIHNwZWN1bGF0ZSBvbiBwb3NzaWJsZSB3YXlzIHRoaXMgbWlnaHQgYmUgdXNlZC4N
Cg0KUGV0ZXI6IFlvdSB3aWxsIG5lZWQgdG8gZGlnIGJhY2sgYSBmZXcgbWVzc2FnZXMgb24gbG9y
ZS5rZXJuZWwub3JnIHRvDQpnZXQgY29udGV4dC4NCg0KLVRvbnkNCg==

