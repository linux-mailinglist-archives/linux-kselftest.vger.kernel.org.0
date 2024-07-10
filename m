Return-Path: <linux-kselftest+bounces-13474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353D92D558
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC871F216EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0F194135;
	Wed, 10 Jul 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQOjHRSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA1192B7F;
	Wed, 10 Jul 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626671; cv=fail; b=selTIlGx8UZTspNNZiRavKV5sIWVr9EKmJU/yKcvhjdx4YXV2FbLIwgUxz/MfzsGlc7+5wbg2879HXyrJ371VTOH2G2AAKuQtciVWQyU7XHstE/2pI/orGgJ2UProz1yGXmXd7c+MFH7Gv/1zLtuQHtAlZQcjf/yu/Kk0w/BweA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626671; c=relaxed/simple;
	bh=Z+AsOcLacqiNGZ565Rohnn88wmIZoOFL9WJoWeg6gjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtbiXitjFuVHhXorrBz8vn8WTBm045/Mo9qultwoVhn96Zl8sOa6ejA0w+mGChoMdRye70ErtDAE7P3FQJlA7qjdbxq0RAv9I2MY4k0r/4mpDp8eAwv19vnKboxbcBIu66qFtChac6GK3RSrMM1kSyR/LeNcRPLPSqSyTITrGlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQOjHRSk; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720626669; x=1752162669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z+AsOcLacqiNGZ565Rohnn88wmIZoOFL9WJoWeg6gjw=;
  b=DQOjHRSkTV75hsQMU8dJUm+AbcWPs4j53+MbMbsTLuew+dYzUwDyw3nY
   QXdOKXaV978tWynR7wdIrcgZ/Tk0pByT2v66gr0o/Sd2D3MTNQ/vvnLIj
   NrIyevBg8YbQRD/ypiCutghMBZ2R9bNKxBKKOx/gjlG+SVqeLYY8qOx1e
   efHqg6BE7mkh4FEVnZbuc2u1NLO96SFjyQqkMNp0vdE9DfdPGi6jLb71n
   jgl9vgbwe/kXSntpsl/bHPWdxDvRv643Ioqqzn/asPAlgZQVK/SCspHap
   B/1tyQ+DbHskdXEdNXtzIBSIUskCpASp2TWniT/dDYuQlusB60q5KW1/s
   g==;
X-CSE-ConnectionGUID: uZibyKAjQWSEynUyyfoAnA==
X-CSE-MsgGUID: kVkRcPlyRaOiMINLfff7Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="20870934"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="20870934"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 08:51:08 -0700
X-CSE-ConnectionGUID: Pqm2khDPSlqTLxKJq0aeAg==
X-CSE-MsgGUID: qg4jVvk1Sd++CtAeK8pgew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48273165"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 08:51:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 08:51:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 08:51:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 08:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTonVtYEkyfgQVzIc1jKeo66+zB4/UHpOvcyfnYwPwRadI3WG/jflInZ577Wf29JYn457A+/+uv5SBL+4KPmDcQLdguQesEY8prNI+rlbLE13OqykuIHqrtx3vUj4rFN3ZzsTO0txAf3+I5l84/0kffOybcq2wkeePa8/UNeoMydCQyi+1s9xzSUJUmH7IJY1IfBy8z83HxA0EQgyuo3qux1FImXBI/M83DLp+aTMq16eTorvr+lhY47vDe+6UOnIH5qxZ+kxW/cNEi+0ZfCYmZnPZPeuPvFb7unDRIZxghYo3HHLpGRftIcAUBY34V9E/OYbT5/ribkfr9tx9qYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOr0CK0KeuzuirR8r+tDxtVm1O1tihRENDMF0XotSIw=;
 b=kIo7rhJf+SLL8AsNWd00C/z/wrToXq1MSrB9c5EkLv3T0sDKriss4qXqcNcuH5AcAQ1I9c7o3fQg313yIGRSvg4z8kaERZNPuHJEq19ZseZ9yRnbK6tCQGgXVqlQSFUZIHd86xG8/TjvhNdprqFAHKwmIHFVtxm0oURPhsQkRbt+Ei/C3FqEz38KiNeZiXMw7Wo6vwceMLRvnAKWyRkpzeVgB8rFy05TIIVXKfgxUPzS7nsjotlHgfyPUOal+xqczWiy5OQoT+AAXPsnE2MfBqJ4jLT4xg6Ckd7q9cjF4ECfZqnHUsnwW9jSb6aKpHIClhl2tPnHA5XzaeYIpyDuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 15:51:04 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 15:51:04 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07HFceqAgCsrPIA=
Date: Wed, 10 Jul 2024 15:51:03 +0000
Message-ID: <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com>
In-Reply-To: <ZmoYvcbFBPJ5ARma@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|BL3PR11MB6315:EE_
x-ms-office365-filtering-correlation-id: 0c0e9329-a7ce-449a-67e2-08dca0f81ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ogooI9pShV4RFijZqRkxOcFmD7cNjLT6T9stvyE4E261n8UgFJiDx5zj8Ba0?=
 =?us-ascii?Q?izsYCWuNewFJZ1exKOSpIpmodm26N9C/Jj1StO4sVYT69p+MX5qIKjJ9qPCS?=
 =?us-ascii?Q?oYtWPtSVksqRbJL+ClvJOBY0cWoKixIA39N+Oam+TAP5KRxVT7MU48nuYFCr?=
 =?us-ascii?Q?XjmMdi+/ijTifBfCmhhSVwgOaKKBZjpGyfp+kgZhOejM7UKh1xYiUOjRBv77?=
 =?us-ascii?Q?h8qXS3t71WsAAn8Js0XqAxWn8Q+Ywe3ihOFn5hp8y8ZJWh+xM8lU63jnHgGd?=
 =?us-ascii?Q?xKTZKzeVCFByfbGtFe+OORjVwupzaEGQsEM+wL2yuuSHgyd67vshFokY72Nx?=
 =?us-ascii?Q?dGzyI0eeuch9nIQyOEEA7IhHNy61ANH5AKkpPUrB6tsokNysGeiOY9FIhzgY?=
 =?us-ascii?Q?a4oHfXLtx3/4QNgXHCEXDAJ7rv2uTPYiC9zTdu/0ZapaeSoS7vxHRxvxqZgd?=
 =?us-ascii?Q?ZHLzw1S6eEPYzay166ilWgrbhRTDwNZa951/22on8d2P0GGxCfir36iyPEDa?=
 =?us-ascii?Q?n0+SGAZ+y2NfhUO0Z5QpoBROa0Kr8Z+34+3EGUBeKRomGS7bPiJeb9P4O5DR?=
 =?us-ascii?Q?ksQXSKhKcAPP90lHQ000rjuNjJQIbXb1fNf0o6MMuDLiP8+YGtNWKyLBettX?=
 =?us-ascii?Q?ei/G1nr9N3u5B4Vmdw/TLB+AqH4Pdz2Cn5bsFHEUb3gi5GG9azy92HTowiAM?=
 =?us-ascii?Q?mP/HyfSUelH/7ncHphq6dFvcx+wvkQopWzaiRoCmzv9Nx7iD4CmnfFbwFcvF?=
 =?us-ascii?Q?I/eLO32K+vvvQ6Og7+/dBoytl+HlXz34bdKvhEKYeBdtKqwT09WxQenWOr5F?=
 =?us-ascii?Q?fBgXRdKvV28Sgab2+7hfmgf9BPIh5knjF7S6Nv5ccTgWCyWUUu+ZKjDrOvuB?=
 =?us-ascii?Q?8a7Wv1edUDlAaZTbvaMc+Hwz8cFO4wco5msfLYlKyC4/yd5dtz7Jc5s31JTd?=
 =?us-ascii?Q?U5+vh36bAwPguRnSR/6k7tkT8rnuTzYC7b6rIWyMamgFJgnL3RAqWN28TR3w?=
 =?us-ascii?Q?dTTxguZ+mAtcf44358LqRvkxGvqky1aH4ZfX5PWuXM1r2b3W5seDS/l02OMr?=
 =?us-ascii?Q?9QIbSOZmfA3HVlSmohreDDZRWQXTPbdmjiPL+RcVwW+1C2t0inLYEYYTkFP5?=
 =?us-ascii?Q?CrDNaCG/TXFbM+evpJOHzely7mPwAsQ37YFED50vNFPmThSpDPqTQCNhw/UF?=
 =?us-ascii?Q?sL0i53HwpttGaC/slW9pQXW6u6L9fA0dYHH2kZj3p68GagtEk7QCeluJWRYG?=
 =?us-ascii?Q?pQGkA/08cEKX4q9uLhD0/7dFEj0YdPor5QAkPr8/Mooj3U7Sp/H5DPJElG76?=
 =?us-ascii?Q?fu6WgUj6lA8iondGRqGj3Y2gUWEDNMtdCptSsa80X2vsTPRqErFzBKZwjrHt?=
 =?us-ascii?Q?ZoM8P3Z89x7wE2SeoToFnZXbsitxdQDZFEXiGv4B9xDvY3oT3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sP4aisltPlmqUwR3qH3k8u37RcWpu9rYL99By11ac2t+tURJtKEbFvIR9Km6?=
 =?us-ascii?Q?c6tRgI5qXJnv/exEont3TYgA4vRtbpNDI96/j8FgYalpRsvwsDxL2t5T7CPc?=
 =?us-ascii?Q?ZoNuG84obDVakMGAfDq0TV/2C6SSMEs9zaYQhpNMkDWazEAe95ZYpW8wMsoh?=
 =?us-ascii?Q?0ElKdzouQ+x0GZXjgN0+RddLq9qN3A1zz1Ny9+7yKDBJ4asSVOF+FOgQg46+?=
 =?us-ascii?Q?71Dw4iXLaUYeApryVSRTuACFgp6CetvTrgkNtKH2Ieqb+YS8vjetVGtJKQw4?=
 =?us-ascii?Q?eMeewV+L+VlfyyftBx9cLCFY/+q6hX1HcI+E1dYih2qaMltoN2P0RU4KKVx5?=
 =?us-ascii?Q?ARDiRew7DZGgmlyIzQB2QJGueQu5S89eNqPrxNmNE5wIEzy8aOQQzuYS+W36?=
 =?us-ascii?Q?/dxM096u8r1WYbNHnyZafqrCNk9PcXp5ArcygfZfaGkyKat60oCwyXUhPSi7?=
 =?us-ascii?Q?uT9wewQ4WqsgFe4xpIAVv/B50ZPLsdSrH43I0+GLc+/KJSPIW52fHvnTS5am?=
 =?us-ascii?Q?e7zcvB4zMM2Jkc9+mXajtgkQrEArYISQ7w5pM5gzb3+iB84yFlOTdsJCXSrq?=
 =?us-ascii?Q?QUcnBEHrJxTuphf+pPmN5Jb7yzOKDt/bTpoUNTmdH65HQ5IwPHYGGIIXe8be?=
 =?us-ascii?Q?nwFMmyL3cMx8qZmYY2odbXbXDZ0fbEAOzknyHj08mIa2uuQFT9IVVhurof7d?=
 =?us-ascii?Q?96GOiYOy+8lkLUPi3S9gWl1YkF6my92osjbkqy/y3gv0Rh76GHpPsuqLseNM?=
 =?us-ascii?Q?r1jsju+Fs9ndCWWmuraR8ZAq1z1l27YoQ3gzbGOyGpEXIIe4i2Ln7HBRjSfN?=
 =?us-ascii?Q?8P+KNTvzHInUXBpYG52Sd/3T0HBvyWfX2Vn3VTT4Dr0jkubH97n8nRMo61V2?=
 =?us-ascii?Q?RfoZxJtrDW+YsO5yDmn2NKb/JHg8VciFIIoez/kQZQEPVdHhBt43btQZ0gki?=
 =?us-ascii?Q?fU1WgEXJkQ6rXDBhsmmrTqAMjA0SIrVHSrghMoR4jdyMXRkLw+50qEZKska1?=
 =?us-ascii?Q?AlL4nVZaIBp4fNrD9ongLiFhbn9hsXF/FOvhR4R4NIIHVz9Nt70LZSQuXIWg?=
 =?us-ascii?Q?7KKoD7GEKpUZe7I+/MFvEmM3Nk2MY00D3ZjT1345zSrsluujMYiVOHLVEYXT?=
 =?us-ascii?Q?iiwzUnAOHtqHK84mCec0xvXAzHUpwFbZagPBud0kFQTZfQq7Q+KHNSYvz/rL?=
 =?us-ascii?Q?fT+7fFYySBsN7GVUKwe4WK8cIlAG72a75B3bwckjiH6IK4RcCYaYoa+CJZ+0?=
 =?us-ascii?Q?Wj68XFCvzjabCTjxcfCqncM7RE0vtjY5+h3L2J0DybO/JPmGWPWmr2gIHHo3?=
 =?us-ascii?Q?slOb2Ie6YCfjQ6ZKHqt7/2zZUBAlLLuflrycQS89Bdzr8cD/ebA/qjIyvieM?=
 =?us-ascii?Q?YTY9PVRW9kkOrhXPIZ2mADjqhYyiDZtRBGp+B46A825xU95BywaJO6hb8sWA?=
 =?us-ascii?Q?6sEB0V976m7mUB4r0y2nJUs/eFSzASagnny0pVuAY3OgPzBRDAyWRIxrG/LY?=
 =?us-ascii?Q?Bj9QHrWHrbO0Rq/8rEv/gbfIiNfXHZQTaCx8melK3Hy6SYwzGyLW1Loa2iNX?=
 =?us-ascii?Q?RI7DFyIJI8Ybwl+e5w0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0e9329-a7ce-449a-67e2-08dca0f81ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 15:51:04.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3P9yMioCq0A4WO/yJ9aT5sWSjJsLHmHjtGjlbSZ7Xpyx/hd+0askm6Lo4R11J77NyGLmyWG15wi79xP8ertXnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com

> On Wed, Feb 07, 2024, Xin Li wrote:
> > Switch MSR_IA32_FRED_RSP0 between host and guest in
> > vmx_prepare_switch_to_{host,guest}().
> >
> > MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
> > KVM, running on ring 0, can run safely with guest FRED RSP0, i.e., no
> > need to switch between host/guest FRED RSP0 during VM entry and exit.
> >
> > KVM should switch to host FRED RSP0 before returning to user level,
> > and switch to guest FRED RSP0 before entering guest mode.
>=20
> Heh, if only KVM had a framework that was specifically designed for conte=
xt
> switching MSRs on return to userspace.  Translation: please use the
> user_return_msr() APIs.

IIUC the user return MSR framework works for MSRs that are per CPU
constants, but like MSR_KERNEL_GS_BASE, MSR_IA32_FRED_RSP0 is a per
*task* constant, thus we can't use it.

