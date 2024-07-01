Return-Path: <linux-kselftest+bounces-13016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB991E4BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332A5283A7D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3315E5DF;
	Mon,  1 Jul 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg9bJCUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4171EB2A;
	Mon,  1 Jul 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849866; cv=fail; b=Yv/BBOvuUTfT26S93oPc9lobb4v4wJLbxMHq5i5uTqG2KZSccYBc5dzJnVGs3Nk8mrhI32mPd+izQl5ACjY1DMmoJfesHnTr8zcb2oBMdhEwn/PdL8HMU8yZ4oPg8T5R1ZzEnJC0YpIiotBWYwGdaD1scMlDj77L9qJ4pyuSp2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849866; c=relaxed/simple;
	bh=dEmZYM17WHQ01N6xxpEJOPKMqnRFqiBs2QlnfcDREgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSP9CDMnq20wP4eN7/mzeehxTg/8isFqPYdJCq13IEyhL0KLA3197EG/tbooyBDYCBAmsODfPqIA3WsT1baFJu5L2V+GTfd/wARIY1NyviLWUlgG1p+EH49/ugfIdENsGhqlHHcJc0ObQaowX+e2MWlSzp4sCap2rX2RzHcGmtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg9bJCUC; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719849864; x=1751385864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dEmZYM17WHQ01N6xxpEJOPKMqnRFqiBs2QlnfcDREgY=;
  b=Eg9bJCUC/hz2l7fxCMXM7wyhkO/0rpO/fjpeBVz0l0OaIqKbZGssS8+G
   YEfQNTeTkvShSOnKTOp8fhAvMPvTDqOLnj9IIIaBeeHoWYB5EtQwjp2t5
   CMHXx2YMhZ4jGZNtlJoNxuCjFI7LustUzEji1mxaQmwP6y40WMCUGI4mH
   qS5cQs2RRLS32+FRqhDy06WCsdOtENRYO8tINzMOHja/faxi/Pnwh1p0B
   hkg60Mzi/B3p0JJeE0s+Dd/LfH1pRgwvSNbwOUNhviuQybjaQEOSICprb
   r74jldhYuu2EI/AfyocYvSOwtcBAzt/XACCP6Je0w0K8vOkLpR2ZOxoj/
   w==;
X-CSE-ConnectionGUID: d812AsSXTDugQpXevPvnGg==
X-CSE-MsgGUID: PxykerDNTXy3dUB+7wsrLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20743233"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="20743233"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:04:08 -0700
X-CSE-ConnectionGUID: JFXZCDGRQVWdHWC2/r14qQ==
X-CSE-MsgGUID: UPcWxd1UQ3OOeHud7ONwnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="83111574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 09:04:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:04:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:04:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 09:04:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 09:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRy2+BnrGi1or2BOOEhDwqHzEsqq9PxSg7GnxPPyC3Ddu+VOwTPGRU+GSgXNv+jSr3y8HS/0ikZ5XdQWeapCPTAPs+GYJVmYLi80e76N53WcRVCKD2N5XhISsVc40KTL5lm6LDzo8cfYjQw66e3JgPHor59xrWJCm/grhUqwCxfjwbFaSrktWX+pxRun0NVf+zpZVmUdkKjRMZZmx6z2FXIrsjkMgFw4kDhfnnQLuCQhpAoR4qhE665A+lnp9eG0xnMZ0IcZnkt0Pn/gb/RtFKVdfZloxes1D4SFfL56ZSSSIURVf3tOQGPSbRmBosE/cECJytCYozOjimioNPMSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJHTPenOkh4AD8k7/W5p/VyoAR55EOofNsvMBphi7HM=;
 b=S2b+BuCUsTIoRk7FVtSsv7HtQNNf94z4hxLCphNiSEL5Fkw5OVkbwSrNBTYqVJjR539hO+ltRdHgyCwG5lPchwH+gOrg7A/kckc9Q5EXR0h3dkpAAzrdDenM//w9xO0VoUw15rmVBrsgywrYjkkV7UaEqFYO15KvKY6nbbN+jp0eAZ+UnhnKnaOHCOFH9Qp85XrsqUyftVPFR1UrvT3Ibur9EEhX7ClPsO3pu3cpftLU7519ngRki+NJ8hlIpMqhZKU3aO5u9v20uoafQqEn6NC1Q8PB+Fje7DyRqR8o1qnFmyrQZSZnvrRIbq89HetFGACv0jmpHw3wqZt65jltbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:04:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 16:04:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHay8Gqstk8aT+5WkSi2DkWMDfArrHiB7zQ
Date: Mon, 1 Jul 2024 16:04:00 +0000
Message-ID: <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5092:EE_
x-ms-office365-filtering-correlation-id: cd4ac519-93eb-4663-4e6a-08dc99e76c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u8EFt3n1mFDbH3OVGmBtgabRwr2LFIKDZU7Lte31jsnFPGabM/LYGoKVW+lf?=
 =?us-ascii?Q?zFk7ld/GdMqubX2vUUazekpPwTJLTlRXDQVvlPnyrdr+9Ea88SMCyFaMMc03?=
 =?us-ascii?Q?jQiGHkIXekk4ssyRbv8KTvO2T0vZ27ZFcnWRA8XNYC6v4HIci2nxq1Ion8k8?=
 =?us-ascii?Q?xn61SuCEBQ/zpj00oGkFBZa/Sa6OiN8SM0PUhd0PwwMpiN7E1BttIRyrOhAA?=
 =?us-ascii?Q?+xJDD7dRei+vhYAMu3SJJY5K6U6A320w0wFZ0DupgNlgtndQy8yhfLpKoQFh?=
 =?us-ascii?Q?CPC3T4XAPOyG6++iXByPyL0FJ6pDQXtYcKDoSVBqj2cW8AqkZiZBzrS/mUcl?=
 =?us-ascii?Q?aYHqutN1M0YXaDCQou7jQ9ky8KwrXR6h3MivgborLS1Ssb/cJUgnBR55yx/j?=
 =?us-ascii?Q?z2nk+2TMDv0NUkOgW9MwJtjrsnTt4yMcoWoOCRSCtfSLmOdlwjLA9qea9hhc?=
 =?us-ascii?Q?Lczj4HWAyDdtYzLLL9Cgg02t+Hg3Azbkg75ftIDKygEdY5yiRkbv2nTquAsj?=
 =?us-ascii?Q?a6Nlel34/LJsAq2+MpTrAE4N3xXqq3wVkQ+GWslBQI0EADvhbm6HB/Hbeqrq?=
 =?us-ascii?Q?odzRldB1M7M8kMTnA8spyrslXPYl953zlRZdYlPai5A7lJEghQRja16e0HiM?=
 =?us-ascii?Q?pBTbI3x5X/YjqrYEcJYYeqasbQwEco6x9V3e5SVUJsYtc8WipsIXKn/jaFic?=
 =?us-ascii?Q?e5PLn2EaRqqjMTgjUH6o/ALOFKsN9/3TOXBJ2hPAPAExO78lYRqAqYJF0tuB?=
 =?us-ascii?Q?RkWUbLwn15cDy4A63Nn30f5HH36g4/pksFiAmabfVNZWySn8Iu98gNYnWe3J?=
 =?us-ascii?Q?lVgxfxmUN8Xcbo8BYwx9aLadc1Hj9Jmnj01no1tuXc404iPstUTSIHS7Jf/C?=
 =?us-ascii?Q?0myQaJg+vr1Kd8buMzIpaLbcSrfQ+7tCR83F+YUvI7F+WCsg/yqhaVFFDlTi?=
 =?us-ascii?Q?l58nUVgvMGVD6mWM2ebDbX6CP7IvqRhepwcf+xSOzt0ItnRf1+MGMzKlUcpd?=
 =?us-ascii?Q?WYLJj23/MMVByglD8oBx8KGN4YeTkLFvFp5Z9vQRCNWqz2MG0QrlJKVPX8YR?=
 =?us-ascii?Q?Czb0wktDh0NHI8bBaCrid0HjJSie15H/N3YOm//BlxhswzznmDSzcSs+7TH8?=
 =?us-ascii?Q?X+R5y9J8OdtZdjOrcbvwtJrzZJQIw8O4FcKt2wZNC0MBjugw+d+uqAMp4ujk?=
 =?us-ascii?Q?HeMNtUv2Ol6CoLiwkB185BYfXVSRoIzcpaONNZC0RDHvEP3G3RM2TRyhL3fX?=
 =?us-ascii?Q?7j12tRG69gGWgi+Y1Fkap9/zkNp2S7qQIO3nk8367rz481RaJX+Si2vXlHBq?=
 =?us-ascii?Q?jw5HdiQk2W0vOc79nfIoQS6UTVH7DuHdy/4PFAfA/3X2+e7Us2AcneDazEsC?=
 =?us-ascii?Q?lBRAl0S7qm7zItDhRWDwYxl+7Bgm4UxiTkb4gXMjeFwmX8Uvzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZYk3AXF9OU/6kCKwFMyRdGo299PiagXFkTUM32KgLxYXMBeNX+0LsurMjeM?=
 =?us-ascii?Q?xL2uIi9bJ9ssuN01MV1qG7Z+TBZ+yH+P11W259X569HUjVOOWXdKsLbznAqV?=
 =?us-ascii?Q?KC9WzJNDH8RLsQxaU+9RFpLIe1vTfdsuiuIpZjEQvCxsRT5WUGumTqt509b1?=
 =?us-ascii?Q?CAkLN1ZrhmypUGkEfTT3kkMDvpkm4+8/eRrHhrMkdQBUPUzQVSKW0A3KcZyC?=
 =?us-ascii?Q?+VPfNQwYlmm7jrlH7/rnPZndlDTpe6+6awv/cjl/27oG8hBOwlkI3JVwnUxD?=
 =?us-ascii?Q?aTyRQgr1WoqVqaCdKKaW922WpyV5VWio7zOg+VAz/uPCtodWqUSegrKv7fb4?=
 =?us-ascii?Q?aKKg0QM71MnwSNGeHc5b3npIl/lu4xigoTCG8PI8nDNjs3Ny1MkDVSpp9tQ2?=
 =?us-ascii?Q?2Z5ag6swjct5coZIzAQP5e8LKWjRGAsoVkNrJproWfAdK97J6e+68ZNGsbJC?=
 =?us-ascii?Q?Xp41zulUDOIMfqChp2uzHKahydVeifZZOkS6wv+YuwmSXbcKhFTyc07GUY7/?=
 =?us-ascii?Q?KIs8f6lw067n0U8hdx/diBmXXzd76vE0S/QRW+sRRPspWtKUNwx4XMGWfAW/?=
 =?us-ascii?Q?AtMt/3FQDSpyShmcmXN4RHa3MtMel+zUy1VLHORu+vza+TBYvxQpf9C78g5g?=
 =?us-ascii?Q?Esf7GoT/B1LUsEeQ9CjB+bqJRqWferuW0N4Me5VaUSzKZPovMnbg2VTLHzex?=
 =?us-ascii?Q?iyqMR4x1ptc7Rn9P8KzN9oF8OCAdyt943lISmIJcJPGTYqHzj5215YeKLcTY?=
 =?us-ascii?Q?YhVT5mL+uB2pJ9NZhFd+gH3B23R5ex0hiHpXzn4P66aKwthp7drH8IgP6qcQ?=
 =?us-ascii?Q?GR+DYePqF0RuXTKzT+a0RKiF78rHzVfwARSV77rkFSjiMWvc1zXn9lSyjzGB?=
 =?us-ascii?Q?09xNQpypMy1x6LNA1trhkUNT8vj2Rs46fuXvbBxgpJg+MrdPeGb431KmcPEc?=
 =?us-ascii?Q?Uju8N9YRKD5jT1aL8avo1rETZIGHbGz7CaKJfzvSQjdwT6kpvJjvurQStDJ+?=
 =?us-ascii?Q?6VMXrDvNDHFpCWuZuTjz9m7YISAEzWknEXYkFi5sZ3pEahZKQ/DA6pqmeEX4?=
 =?us-ascii?Q?3Dhc3fsqI8cQlnpzfxCTl+zxHFv9v6XmZQENRaJEn2VycT2i1MCj4Y8IWeUR?=
 =?us-ascii?Q?pYynkfv12eGjZvbhwXMYCTHz6DPqMbrtrnIOn5saY96yFaHuWnR2pD1Q0wXm?=
 =?us-ascii?Q?tQxqlFYTV9SCF5dFMjf+oSJjMb6ysnDdVsB51hwpjbGEQH8SUUtD/R4vlk01?=
 =?us-ascii?Q?TjOxkscaMnqCx79Qc75ZPvFI13ym+yqcZZyqHq4B8dfYg9nSpY/zSGbTMgFr?=
 =?us-ascii?Q?f5/jSKgl+LIP5zF8Jh6HjTiEni7dliC/j21nge0DKHAMHWu6eP+t4bSwN+UA?=
 =?us-ascii?Q?FJXvnQ35N7dhXKmP/pHWrkVG+ZbR/DpohaB9kbCCisTvyy0VH33Pdwv2NxwX?=
 =?us-ascii?Q?yaj6yEuFSPHHbiJ+r9zRBTPpdbVnKcA/9QbqToxCMYR/+4D8L2vGpHuIYuob?=
 =?us-ascii?Q?6JfR6VASeo5suyWWoHgTAXCRnDW7sEMIRpYV4YwfQsnFnlF6KcD/PAz+AoSS?=
 =?us-ascii?Q?GWFA/ZnIJ6fKFXYWFnOYArecqHVC58FSvXnknxkQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4ac519-93eb-4663-4e6a-08dc99e76c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 16:04:00.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1JgfvMpy4OUxh8B93wgiIU1+XaPwkIcpyJIYYTgXP4fmubpFBHvSn5lagXkTCEKRkLL0kYSzuVSCsmxRWvLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com

+static bool cpus_offline_empty(void)
+{
+	char offline_cpus_str[64];
+	FILE *fp;
+
+	fp =3D fopen("/sys/devices/system/cpu/offline", "r");

Check for fp =3D=3D NULL before using it.

+	if (fscanf(fp, "%s", offline_cpus_str) < 0) {

fscanf() seems like a heavy hammer.

	if (fgets(offline_cpus_str, sizeof(offline_cpus_str), fp) =3D=3D NULL) {
+		if (!errno) {

Don't need an errno check (seems dubious mixing errno with stdio).

+			fclose(fp);
+			return 1;

			return true;

+		}
+		ksft_perror("Could not read offline CPUs file!");
+	}
+
+	fclose(fp);
+
+	return 0;

	return false;
+}


