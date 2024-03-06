Return-Path: <linux-kselftest+bounces-6011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8899874234
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBA1F21FFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF61B809;
	Wed,  6 Mar 2024 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U62x6RJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6214265;
	Wed,  6 Mar 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762049; cv=fail; b=STlJPQ/ruDEeieXYwQKPJoq9/XAinRrFbR6JZHjrlxV0p4/XtqLkYrtjg4zaZSiFN0iidGv90OgdQqMP+QqT1+J4R4mEAJsiH1iNQXrfJzDitkAH77xhISyqd6VTwFOTTMSkz27L7TDOgm2os6v6EgddCkZiYIsR6k/qMpANEBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762049; c=relaxed/simple;
	bh=Q+8D9Qj6M9g6DMUnEvP2AdZU0gckYjSkpM77raRv8SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UDBVnzrMeo+SES4cX5R8MbzMbbRejkWEWzFiMspv4gQqstr3YnZUetVK+d8si7u80VPePP/KcqdOykqra+AAYsrKFgBPsfbFfKsVMKZ9TTNGPPNJyWjLj2X0JrSZ6Jcj6K3cbVV0l79gBz7V0jYJDD3S3svfDp+tKBdHfaidzoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U62x6RJT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709762048; x=1741298048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q+8D9Qj6M9g6DMUnEvP2AdZU0gckYjSkpM77raRv8SU=;
  b=U62x6RJTY1z1nibH9RRYnby/XAEnCEzfTqC6xKv0i9BByM6fokElIHtV
   ACEnBJLbAc5HzM9zBywnBHMyOvVSFwfsDaIYSkzVWSs+Cf1nWXMEoZQ5w
   dWxYFecitC/31XQcbF254e5EIj280BgZijO6BOH83lsKTt6sxAsMoPp6J
   Za3HpydQ9PK8yp2HnHOa3DdjJwPzcxG1FzP9sEaEoqaPNhJYRyYn0hFBW
   BQk26K1239lvlwG4/NLLhJaG6vhMsx30lcruQMyNKFo83O43X+uA5Is+Q
   zrAFzSUSMFzSCjJhdwaJOue84I9Gpd8nXRjco3ssqRSSCWfC+MhW/eFpq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8167012"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="8167012"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="10314046"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 13:54:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 13:54:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 13:54:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 13:54:06 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 13:54:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5JVEk+C1fauiQoJuPLEGmOrI8hRnmeSIEUjr/nOqX2NRuPzHmze+jGzzO8eMkrVdEMiClII4X43RAT/6vNu/Lq4i7Gjl1qzjtN8Fc48oeT6ZawuDcwDR08leoPkcNQXMpaKB0i/OoyeF5eFpnvbJ7F2EekfOcx8neY9aGW82EIlJIUtUaYLsN2B+P0jktcZnmWjGNuhW4PJabicoFaSFQvTG3HNu9aB0U6PxST4rG1ujGkTunzgLWbtKKrhLbF7tGf+r1Tr2KcwtCYP+33u9di91hQVszWBm5oiKqNqORNQMN+3dKMd8ZxBS7/aHWoJ+BilPquxMdyamhQdlcsOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+8D9Qj6M9g6DMUnEvP2AdZU0gckYjSkpM77raRv8SU=;
 b=S54ejBPMN0MW4SDt77Qhl+XVVr4JHejFjQl3t4SOeN+4V6fFO2rT2+Z9CMinxMTWwCMa4QbFYTPWOWoe1nJgs3X33fAdBT4OfGjP0I2fItBF9XQwCUGFby8TDdvHHxFQ9zvE1gq6N1O/PAe0YYhUxR3FyYGLI0Pq2FckyRyjNdcmZVmHu98fQAI0PO7eSuzr4vegMcANnRnz8NDMDSeeQj7mhncIkt1S1ZAVtdIKff1yV8MaP+R6mvSOx83znPk9N4fP855MtoqswOrggZDYcA0PmhGXjm8GEyCY+LlGf+zqNeBr/ORKB7ucWZa8jwXDoq3VsBElX3LUwZicndP6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 21:54:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 21:54:02 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Shuah Khan" <shuah@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>
CC: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQ
Date: Wed, 6 Mar 2024 21:54:02 +0000
Message-ID: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5949:EE_
x-ms-office365-filtering-correlation-id: 66f3e011-a4c0-44a7-8773-08dc3e27ef86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNH6zlZvFspfVXvIeQpWk03skSV4BIO2wsPS5SpLl9xTXKiKs9tnAOAiTlRJhh8fcxzOlPt4x6VuoYTgCFFZ8nVGTCCCVYLczHU9LjaiaQHBNrIu02NLxy/N+4Pr0QzY1oKzESeXHrX0yAJZjnTcd/c7Eh6ODV3vWVatcXLgBK96ohQ/ZOddst74VjxiGiu65tC0ahXLrBCBEzIjiFMH1HeruqvHKigCI6RGsqJ4SMcrNo8pUFGg12N4bPue0I5q8iwerHnoZOoSsDuortDWxcttRWkCFBhZb6Xlg1ORkvdez+A028a65L04hguOeMAn3dYu3fd+JACiU/u4KPY0s3e5IAh2AkXXB44x6GORjci8hZTHnooVFKSp95CrukQGDAjfFFR+sHKPGWK2Nz6eRIbL54r1VLlJXyPHv8kG1AZn+ee/F5ZdpylwbfS0Cj7jVWvy3C6Y4P9Ge9YZ2if8w5u1vLNwEyEWW9Bgo88V28IcMp+yTo73G3GC+1dF4P9x5UK7vV9cC6euyoUznhSZg6SqmMuMuV+GKovWLWWpqVYRxtBEPpkW4j7/vsR1rCdcgcUFqqefNV8smal2aIwhgKEUBLFqLm3g1JJJoQIrvfh+DiYzwtnmsT96KCbyowIDimvVZUnfZum0pnwOXufUuGtHxjw3ir1gzrY4gxsawMU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/FIFQioQUvbYKgki4lVV02I1G8s/rg67uwPxvWpdv7Cj3iT7+HqtLZa11N9o?=
 =?us-ascii?Q?tYUGAZUTNsqrOGhnPZb5nMoaDatX7Z4zANyymJxQuT+OicgZArxIs8UHekUQ?=
 =?us-ascii?Q?pKLrbRvkNJkh4Y7bNyeOJJ12NOG3pTch05opHQyPNOgLZlUVtev2YngkRh5j?=
 =?us-ascii?Q?sJ+KciEbHq44Ob/lltfa8RPHy9VJ9UvaCuSCEG9pc3CJ9vocwOFxpzZGSzWs?=
 =?us-ascii?Q?8ittwEcHJEQvpHCfIdkUMsrsaIKFu+ziQFzP0qCpu5mooD4kYluggx13titZ?=
 =?us-ascii?Q?s9ox9uMThjV1jCQDy8BqbtGe+z21sWUyfbC/MYVEzqDTN4Hfgv8OBLliowM7?=
 =?us-ascii?Q?ndhH6kGoFh1UP3TPB9gD7TG2cdqm+l4WS5OGMOvKOzMs7QgV+O/XyN10Sjme?=
 =?us-ascii?Q?WQNUYXdTlLfsm9kw2fEgV53o7uLOL+RIYFCee1Tqym/rmYOC5iS11NuJUJKD?=
 =?us-ascii?Q?u2kMbWzgneNX0ROEjEtOaN6qFsO2WTSerV+hOB/jjw2WamDSsfsA/jucFY73?=
 =?us-ascii?Q?5P9+i+uswm5khyUWrVX+abNw8VFpWjj2GS4ShOX8N9ddSERXXCjn8OQeu2kZ?=
 =?us-ascii?Q?5CynPpx7aC/InCj2GwAU0PltbX4QyMYhTFfxOaeqK7CFGccaXe3Yy9eYIxGE?=
 =?us-ascii?Q?SjYNLtJjK2NDM3L+m8vzIgocJQ3YYCHzCusvs8OY5Zbosb6/O917VMpdNi5k?=
 =?us-ascii?Q?Ez3b9Vm182F+bbqkC6v1lv/XMgX0nH5Aka8h2wkgkqeh3ePPFQFnoRr2dv0H?=
 =?us-ascii?Q?hmniIFkGdTfSgytzc1gjeO9xZvibrp8T47qrZpIKRbCLsWb8vJzECSfgPH7P?=
 =?us-ascii?Q?YPnf0i6s4HjmGtwFPan0nTnfnGNqjpokeOdrHVz7T+0XLvfGgfP0Kz0Z1S/+?=
 =?us-ascii?Q?mh6u+PHL5l7zlPT6yc8m6xQbw5CF/bvh1MEegDWQs1yrA92e2QHuRK2ByIdS?=
 =?us-ascii?Q?U7Hp+XEJDGtS5XTU448TeRcL4d/TUpD8DH7vAJHPmo1MmWZTsM+u1egSiNgf?=
 =?us-ascii?Q?nZpPY5ovbcdi8mWhBBcgUc1ssisMM6d/OMWSC8hNptp5V2z/VosKnLiSAL7T?=
 =?us-ascii?Q?R67/HljT8mrkzDtVnBGARHW36R2SlOa+RRWdeob4GPJTZrTPUjk7FsmOzfKq?=
 =?us-ascii?Q?EndEWAQkehb1K9arrMMX/py64AACGBFGoxeRP1ly4Jqs3Wcq2ugEn9HsC+5J?=
 =?us-ascii?Q?Ulj9Lx2SVInaZ5HAyStwL1mlnkfDcISdnbAVNafAFLQu3zfWNY9dgwxnMyia?=
 =?us-ascii?Q?GIGBfVw3tJ9FJLg3ayUQiVNydKciZhgg9Z1aHrpl9zBesjtNdNUiPEtcEJfk?=
 =?us-ascii?Q?UTR5IW/UISop8u6E3kyl9xCshebpdRUoGnx87hyyquGgmT2S/+HyC28qjC2W?=
 =?us-ascii?Q?dhkPFeoma3R+gFj53oZ7ekICpTf+49e+wwQ3/8049J97kbGUeTHqO+NLSTsy?=
 =?us-ascii?Q?HeGN9v6h0Akk+TVmpyWDnJfix3n635SisxTJdgojMcfoab+cJ1RpRpQTF6T1?=
 =?us-ascii?Q?LHKFfk3Iw53JBMteUJxSZI3C4D6U/h26DC32FBjGoDfM5rD+vCKL5wFAO2XJ?=
 =?us-ascii?Q?vt8bLRInCOhX3Pl8d8jPqhTrrXEpT4KFRrLbSdyp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f3e011-a4c0-44a7-8773-08dc3e27ef86
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 21:54:02.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zguIfIsVgQL4psRXltZbI4Ip5rNNw4YI9iqnVTEewGN9Qm8ulKEnKiaLcBNuubV22fW39QFFKPClHaWJhgAtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5949
X-OriginatorOrg: intel.com

> Figuring out if SNC is enabled is only one part of the problem, the
> other being whether the kernel supports it. As there is no easy
> interface that simply states SNC support in the kernel one can find that
> information by comparing L3 cache sizes from different sources. Cache
> size reported by /sys/devices/system/node/node0/cpu0/cache/index3/size
> will always show the full cache size even if it's split by enabled SNC.
> On the other hand /sys/fs/resctrl/size has information about L3 size,
> that with kernel support is adjusted for enabled SNC.

Early versions of the kernel SNC patch series added an info/l3_MON/snc_ways
file to provide this information. I was talked out of it then:

https://lore.kernel.org/all/f0841866-315b-4727-0a6c-ec60d22ca29c@arm.com/

But that discussion didn't consider the question you discuss here: "Does th=
is
instance of the kernel support SNC?"

So you have a clever solution. But it seems like a roundabout way for
an application to discover whether the kernel has configured resctrl for
SNC mode.

Should the kernel provide an info/ file listing the SNC configuration?

If so, what should it be named? "snc_ways" as a kernel variable was
later replaced by "snc_nodes_per_l3_cache". Is that a good filename?

-Tony

