Return-Path: <linux-kselftest+bounces-38220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B898B18E83
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 14:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA201663E7
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49B1EEA5F;
	Sat,  2 Aug 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKu6qHpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37C273F9
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138611; cv=fail; b=OubA8sbQ7p6oLzi9r22o3QYlh0AzFwjz8cgEpCI+RUErODdUmW2DotA7XT8CBEfy3LQ5B7ENg59t7KJljzedpXJaA20PxQsLJP8eS4Bu1T5er4B8EwZDYPAHaLIjLOjkqY1+/MGjRDvSj1vvz1hfkljM9pxt4VQh6qQqaErA6SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138611; c=relaxed/simple;
	bh=hmwW0zEmTgfZBLnH5XsfXBexv0onXKAXPj/CfjoaDyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E985hNDWwK6/B3h06eIy2EHuLhHf6rl70A4XjFR9koIpbmzU7X/+Lmku7jqP94qv0yWXZ02thlhxsLu6HvWPd9DcX6ks7l0YNZpgzpjDvCNNBBIylvcXfl+obOksjA+rLIiforefgrM7IZFC+WuDuNBYm9vJXp1TzOTu0YhggcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKu6qHpq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754138609; x=1785674609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=hmwW0zEmTgfZBLnH5XsfXBexv0onXKAXPj/CfjoaDyQ=;
  b=IKu6qHpqmwTKVIRup33oC9NIPW1JhrOICNCaRmnpF6r7vfmlV2cSFB+q
   IgHlUk4N7t25b/44P5NbYJ43+J63w+7zNp2vP8nxmlMJdjaDKTGCnM/R4
   l52udwk7SGR/abQ/Q78lU+72CfrfFCEjF5ZTOxL6lvU61bT5Mybs2Mmjl
   9Hgo2lFAzzrHFm3tSRmU49NIsxXNrhmwYcCZ9DDP6i+Licu9GKi8m50CT
   qQTcEjjCPnNr1NCoKn8TxAvh4oEqET1Z3VyYZzq+Pqsr9Z5BqnRIaZaCB
   Slo0DeEa+chjmAsg6WjhDlg58pGU3JyuBZ/nG8yfaeuCjjuH9EuEg0WU0
   Q==;
X-CSE-ConnectionGUID: hlRi2gHCQUG+4PTw7UWI3Q==
X-CSE-MsgGUID: 8YIHQv4kST+IP39KNDhk6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="67535789"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67535789"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 05:43:26 -0700
X-CSE-ConnectionGUID: 1g+5bFsrT1SSokazd8472A==
X-CSE-MsgGUID: rDfLpuhRR4GGOfaxNREJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163707984"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 05:43:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 2 Aug 2025 05:43:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 2 Aug 2025 05:43:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 2 Aug 2025 05:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRk4omKI/+QoreuCpBLA3CjlMy5cFRujrswwyFsnEF1QZbIEHKrjlSzvsENgzJ4PENnVRkT3s40qPw0A0vkFHchTDmgR3BfutPTqUZ8X1rlYUnzq8IM3Kl1lDVTrx+m+RO5QGW8EgaAwg+1rpLSzntncgQahDmk5wfgMgjI8pI4xlYVz8GmDg/6A8wXPySglJcHp9fV1JLNzBmIpsuPgYVS/I/pekclCjlaHyAdWYzVEvKCB+tqgl4/caBb57QhtBiKgcmui+SOQC+avjuiDercs10rKl7ZkQZBrkFiVHIcvEBjrs6g17zEX2JOX5lllNxA3qxi37T8bggO6e2s7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQz4IkJqQLQCSjzfZ36G54yUb5uC4dbVPDF4jRbBqVY=;
 b=m5mLU3LZXaVfIbs/b1rUndyrN3e6F5COZ05kS5ru8tDfMx7bCNvodEtWqrTB0+C2l7poIiYskpCjmzcDzyqll3bgj9QwYog2gjmrYLFQq9RJWggcJFMxupZwlUxth03aietJGyVI8QN6DLQp/wUwZgJALUoQIoIPNdGFzFK3TYv2HZsw4Cxs+vS40/KeC9urbZYzeD0FHbq8qij3eTl0X5lel7ErYGFNED3xKM9p0b1ako7AlrNgOTPaJPyuSwg/SJ2WvQPBLSdAUJATmbhcSAZ9umF7qoAa9CMmCY/SQyjjjwBgrMtnL3oWeaMMlBPcgjq0IXHhgj6HacBHrfdglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Sat, 2 Aug
 2025 12:43:16 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%7]) with mapi id 15.20.8989.015; Sat, 2 Aug 2025
 12:43:16 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "linux@weissschuh.net" <linux@weissschuh.net>
CC: "w@1wt.eu" <w@1wt.eu>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] tools/nolibc: add signal support
Thread-Topic: [PATCH v3 4/4] tools/nolibc: add signal support
Thread-Index: AQHcAlebACylJcYnlEK6eTyMPMAidrRN59CAgAFDVoCAABCpgIAAFYmA
Date: Sat, 2 Aug 2025 12:43:16 +0000
Message-ID: <9fafeaf6abdd5295d2746fb84e3f5c5ba2c5b7ed.camel@intel.com>
References: <20250731201225.323254-1-benjamin@sipsolutions.net>
	 <20250731201225.323254-5-benjamin@sipsolutions.net>
	 <fbd9add3-dd99-4deb-979d-79ecfdae2f6c@t-8ch.de>
	 <bae0c68a9cb24aa5d16f0df74959207ea4385c66.camel@intel.com>
	 <ef70e7c7-15e0-4de6-9100-f6b70bb4010e@t-8ch.de>
In-Reply-To: <ef70e7c7-15e0-4de6-9100-f6b70bb4010e@t-8ch.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|CH3PR11MB7371:EE_
x-ms-office365-filtering-correlation-id: 1c474924-4f2d-4105-eb8e-08ddd1c226e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3BLU09qQlhlZWdrRnV4SGN2UDl2ZFo2N1FOeWttVEY2SGxxN0ExSEN3YUt4?=
 =?utf-8?B?UEFtRnY4U1hHVTJ0azhjdmNuQVVuQXVHOXNpdHVjZTVTcG9UTndhRFFRTlZp?=
 =?utf-8?B?ZHN6LzhXUllaUUs2WGFQRUJJaUEwWlpid3dudm5hc0lEczNDZlRLQ2dDWFhw?=
 =?utf-8?B?N3I1MzZqMnVoVUNSK1F1Q0I1NXJHcHM5cXFKbm5uS3B1UUxPZjZoaVplNU1Q?=
 =?utf-8?B?b3dPRHFHbkorTzZ1WFhHdFVvaUlzMTA1K3dDcjY0QlQwcnAzekVtS2RnZktu?=
 =?utf-8?B?cnpJWDNweVA1RlZKT0RkZ1B6RWhKbEMzTnRsSVFuQlNHR2tCeGFJYzdMZjlk?=
 =?utf-8?B?T3JqOGM3MjBCUWxXMnZjTWtySDQ5Zlh1aFFCcUFIam5aenppdmlRWDNxZlpO?=
 =?utf-8?B?MXdCQWhkalNQaEJjaDJzQ25PWldjZWdaZVBWcFNwelNFTTB6dVlVc1JKZTZz?=
 =?utf-8?B?ZkdDY0xoNGVCMHJ4SmxINmtJY3JuV0RLTkRMbzVncWY2YVJ0NTMzS2ZzS1J3?=
 =?utf-8?B?bU5OWlp2VTBRM3hnNDFOeEFhTlQvemZST2xkeEViUy94WDE0aGxvTWViL3Fj?=
 =?utf-8?B?TXJQNFRObFdueXp0Nm45R0ZJa3FLeG05OXMzM3JaYUxCWGR0UTQvczlwNk9l?=
 =?utf-8?B?bHpxZzQ2b0xUelBiRFVEejNMZ2RBSEptRUJsZjBqOFNrUmdES3Y2TTJLOGk1?=
 =?utf-8?B?SXIrM0M0NXorcloxc0QrZFhWNHVKbFZmRmNyaE5wbE5JdDVremE3VXN1V2lV?=
 =?utf-8?B?RDBaTEd0RTJQcnpGZDBxWlh6K0Q2N25DcUtVS293cTk5U2VKbHd3aXFnZXZK?=
 =?utf-8?B?N0pTVXNEQjVCbGNuMCtwWHJzOXRTQytXbjV4d0F1dGJmSXVMbWJQYzU4OEdL?=
 =?utf-8?B?eUR2VHJTNnpwZmhPbWhFYU4xdUUyS1l1OEIyMFN5Tk5CV3VNS2RSZE9xazd5?=
 =?utf-8?B?alEvUnJlN1NzWnRXeDdHY0pKNjhxNEtkVmNGb3g4c0NvTmJBQ2lVb3E2dkpG?=
 =?utf-8?B?SDlHVk8wWjB6TjNqenB2TGZ4L09FNVdyQThTdW16LzBNTjc2RGpEd2dRaTNH?=
 =?utf-8?B?WXVzOVAwTFRTV0p3L0MyZXhDRzJ2WVQvbVpYdmZ1cTlpTkZETjRtc0JjTVJX?=
 =?utf-8?B?TmFrWTh3M2ZkQkhHYVM2bUlmdTcyL3BtdFdKejkyQndwVVlkVnZpWjZVU2Nw?=
 =?utf-8?B?K1hjQUJlYURucDZObURaejExVGs3SDBqRUZGbnNQMHJrMWlJNkU1NE9nZ1V6?=
 =?utf-8?B?VGl3OUhlSjN3WFZlRG5CQVRXNDZPaUhsYW42aTJ1QTBmekVndGVSeWZGSHA0?=
 =?utf-8?B?M2NFbSsvMTh1MGxTc0pqYjNscmlBempOR240c29MK3JIRmNHYUovd1FjWWxN?=
 =?utf-8?B?QzM5cExsaDlhWEVWRTJycElqQ09BaHdzbmtyMFU3WFNGd1pkeWdsOXczWkt3?=
 =?utf-8?B?R1ZSUGd2VlA1TG8wZkhudHR0MUhsbjJuM1lRS3dNdlFtbXhzMU5yOVNMNytT?=
 =?utf-8?B?TlBkbzlicDZLVHVBd1lxdHFOdXhuSG84ZXVRcGdqQklpZm5wcEJqbUgxRHBi?=
 =?utf-8?B?ZllGM25YUU1HM044N282ZXh1ZDFUSXZ5R3gwMnMrWHM3USs5bnREMUtxTFhI?=
 =?utf-8?B?aTZsbWU5UllNOXNkaVI1M0thY3J0c2EyU25DTVRneGlJRUUzWDc0dHBHSUVH?=
 =?utf-8?B?ZTVxaFdyRGhFeFlqTncvWlhOeGdESlRIcVZuZ3lHNk8xOFJZZTUyd0hENVha?=
 =?utf-8?B?WVZnNnh1OXJhM2J5bVg1aEE4NnY2S2xOTG5SVUFIdzYzbTN4RnhJdTMram5n?=
 =?utf-8?B?ZWhVcWljVkNHUGNOS1JMUVo5V21xU3ZUWUp4d1RTN0VjbjdZNEU1T29PVFA3?=
 =?utf-8?B?dkJKQ1huS01iYi9YT0xxSC9ZOXIvWklqS045eDdSdHhQVnAyM3piZGsyYlVk?=
 =?utf-8?B?ZElQWHovZWZKckNRbXFSYWFlQUZGUDBTcTR2dWMvVjRENzVUUUlDbmF0VWtO?=
 =?utf-8?B?bGxSYkdzK3dnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVdiZTBRRDE3TjNoL1NpTVNXYmhRSFdNWnRSeUhWRUNCd1VFckluNkphaEp6?=
 =?utf-8?B?b0M4NHpiclRTUXk4VkhtYTUrSm90TmpEaVM5Ym9MNS9CSy9qWjV0WU9PS1dx?=
 =?utf-8?B?aEZiMEJLSWI1bStLRTdtdGc1aGxORXBlZm1QM2YvTGg3UE9kOW03YWc5TDRM?=
 =?utf-8?B?T1o3b3hYUU50UWpXSEdvTGxPL01Yd2Fjek1MODdVKy9XQUpVdlVlVW5wb0V1?=
 =?utf-8?B?aE0yTUVkNU5sSU5SZHNMdjFSVEdkVllzLzFnVUtTdmVOM01kd0RQMVhzSmRN?=
 =?utf-8?B?ZldqN0pyRWcwU05ULytEY0dtSzFMQVB0Y2RTcUl1cEExUjZQWUsxNGdxZGtB?=
 =?utf-8?B?Y1JHZloxUWxyU0JUeElPT2R2OGpXeG8wOHY1b3QwTjhYUXdFRm9SZFE4UjRi?=
 =?utf-8?B?Z00xU00rT3ZuWWFNNFdVaE5VTytFZUVQMDhQakR4SjN0dHF1ZzFlemVLVnZw?=
 =?utf-8?B?R01ycUJUR1FCRHRKTktBVGJtVzYvK3Q0U1VLNm1qVkk4czlGVW1sdVJnQ0lq?=
 =?utf-8?B?UUROMXRLc21BSlRReUJ4MVVhK29oSlZlSk5wN3ptdlVLeTVIRUdmS1BBQnRp?=
 =?utf-8?B?S2hwa2lIYnp3eFdUTHpJenlNNnI5Sjk5bDFCUXVJYUF6SVBWbkIyM0VwVjlM?=
 =?utf-8?B?cU5XMVpnVDY5OG40ZzZCZU5JYlBrcEF2b1pWM21wclFQWFBucWQwNk13aHpo?=
 =?utf-8?B?WVl2SWFJVzh0VFVvMnM2Q0Y0OEk5NnJaTHFyMWdqQU1IZzE2dzZTcUJ3NXlR?=
 =?utf-8?B?STd0WTJPUDdBOGlMdys5R01Xb0szZ2UzUkN1akQ4WXduZzZ3bnMrVXBVZDVr?=
 =?utf-8?B?d0t3WlhzUG1tYmtHVmt3V2R5R05ocW9GNG1EWmFrUkl4QkM4SXl6eTRUcDBP?=
 =?utf-8?B?cFlUaUJ4RGVkQ0h0MVNtajVjL2hUczF5dXRNZXY1cnljREQzTmpxamRyM004?=
 =?utf-8?B?bHpZRkh3M2RsYnl3QjR3TWVpOGN2TmlFc3gzSW9teTRnb05EbGVvODRYV1Ay?=
 =?utf-8?B?Q29EY3RRcnBsMWJqRFRpYXo2OFkwMUk1d1BZNnNFc0luOWZXQ3NENEZMeS9Z?=
 =?utf-8?B?ajB1cUhJYzVyVFYzUmJwTGJTWmlHWGhqNkNLVjBkTmVBbUE3SHl5ZEZqTGl3?=
 =?utf-8?B?Unl2a0o0QnlUS0doN3FQbVhCRldhMW5FS2ZCL1F1ejVJdVVWUTJWU2V6YWJh?=
 =?utf-8?B?MW96Vm56QjhhR3hJYlNBMzA2N1V2dzl2R0MxODJZTWNOTFRvTDlFdXJrbmto?=
 =?utf-8?B?U0JoelcrbzdGbXV2OHNHc1FaQURHOG16OE1LWnlaeExVT2R2dUN2WmFtTmhu?=
 =?utf-8?B?c2YyWDhPRm8rY3NWRm0yU2lKZVVDLytiS0Y2a0tPR09lSGdNSUJWNXZmZVFa?=
 =?utf-8?B?dDJ3WWVncW5BU2pubWFXRHdVNGxlMWFzZklWc0Fpa1VZV0QyNnYxNXd2ZzFa?=
 =?utf-8?B?MHdLakRLT0FDRVFCNlRpcmluVWhEMWVoUldOMENqVnJ5TWlXVUpWNTBlMW1s?=
 =?utf-8?B?TjBWVUxVOE0yYUM1UnNJYzBISWZlSlVwaWpwQWdIYi83NTQydVhqUFFubTJ2?=
 =?utf-8?B?emlGN25zVndKVGNmM1pKK2FIUzBZdUZXL3ZlRmVWeFl5bStZQUVjWmo0OFhy?=
 =?utf-8?B?UlIxcHZQKzExUGpoTFF1bjNaK2ticTczQ3VuM1FuT011clpYWWUyZ0x4dnVG?=
 =?utf-8?B?Q1FublZYOVExdDBHS3VTTGU5R01OUisrd2xrWmJDTmlCNm00SVVwZDJIaXhM?=
 =?utf-8?B?K3R2YmpFYUlNcWE5SkFFZVNNZjBJMDd6bzcrZFBVMUZwMFZobDNuK2hXUm9h?=
 =?utf-8?B?Z0QvdU9zK08yNlZRTmNmVmdOblBtUnQxRkRHSGpDYnRaWVBFNGpvS0dHVEkz?=
 =?utf-8?B?Tmh1N0ZXSmNOSy9xTEJobjM1Q3J1MjFON0wwYkw2Z04yRXFJbHgvN1BIM0NN?=
 =?utf-8?B?WHVZbWV5Q0dQZDI2SjIyY1pYelVZVUhpbGpiSkgzeFNJVUFYVWZwa21nVVgv?=
 =?utf-8?B?K2ZTRXphNTVTMEJpelJ5QnNSZDZJeDYwWjVZeDhrV01TcjVLREg4VVl5Tmpq?=
 =?utf-8?B?b1JIZFFscFQ0dDRoRFdmclZaRzJFQ3hkSHFIdGhscDRuays2K05VcXZvZE1Q?=
 =?utf-8?B?bE1laTFjT2t3S0xBbFA5VldYWHU1RklPSXZrYjZoN084aThydFVRR3NBa3N1?=
 =?utf-8?B?MmF3aXlhUk5XSUQ0SWozZHAyWVgvbjBWWE0zS2lhVDJZRVNKR2x1blpGTDQ5?=
 =?utf-8?B?RXhUd2JPNnNtRUJFQ3UzMTZ5NUlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9BB627804B2BF4D889C85EDB5247F91@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c474924-4f2d-4105-eb8e-08ddd1c226e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2025 12:43:16.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rg+Re9Bc7GoIE1ScPE0wpARIycz+qyZGhytvgh2kTw0x7E8cubLYbU3uGXehtH2iD7+1OfScSgyXtU1UzStGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFNhdCwgMjAyNS0wOC0wMiBhdCAxMzoyNiArMDIwMCwgVGhvbWFzIFdlacOfc2No
dWggd3JvdGU6DQo+IE5vdGU6IFBsZWFzZSBhbHNvIENjIHRoZSBwYXRjaGVzIHRvIExLTUwgaW4g
dGhlIGZ1dHVyZS4NCj4gDQo+IE9uIDIwMjUtMDgtMDIgMTA6MjY6MzQrMDAwMCwgQmVyZywgQmVu
amFtaW4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDI1LTA4LTAxIGF0IDE3OjA5ICswMjAwLCBUaG9t
YXMgV2Vpw59zY2h1aCB3cm90ZToNCj4gPiA+IE9uIDIwMjUtMDctMzEgMjI6MTI6MjUrMDIwMCwg
QmVuamFtaW4gQmVyZyB3cm90ZToNCj4gPiA+ID4gRnJvbTogQmVuamFtaW4gQmVyZyA8YmVuamFt
aW4uYmVyZ0BpbnRlbC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3Igc2ln
YWN0aW9uKCkgdXNpbmcgdGhlIHJ0X3NpZ2FjdGlvbiBzeXNjYWxsIGFuZCBpbXBsZW1lbnQNCj4g
PiA+ID4gdGhlIG5vcm1hbCBzYV9tYXNrIGhlbHBlcnMuDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3Ig
dGhlIHVhcGkgZGVmaW5pdGlvbnMsIGV2ZXJ5dGhpbmcgaXMgY29waWVkIGludG8gbm9saWJjLiBU
aGlzIGF2b2lkcw0KPiA+ID4gPiBpc3N1ZXMgd2l0aCBrZXJuZWwgYXJjaGl0ZWN0dXJlIGhlYWRl
cnMgdGhhdCBhcmUgbm90IHVzYWJsZSB3aXRoIHRoZQ0KPiA+ID4gPiBydF9zaWdhY3Rpb24gc3lz
Y2FsbC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEJlcmcgPGJl
bmphbWluLmJlcmdAaW50ZWwuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gLS0tDQo+ID4gPiA+IA0K
PiA+ID4gPiB2MzoNCj4gPiA+ID4gLSBwdXQgZXZlcnl0aGluZyBpbnRvIHNpZ25hbC5oIGFuZCB0
aGUgbmV3IGFzbS1zaWduYWwuaA0KPiA+ID4gDQo+ID4gPiBIbSwgZGlkIHdlIGRlY2lkZSBvbiB0
aGF0PyBXZSBkb24ndCB3YW50IHRoZSBwZXItYXJjaGl0ZWN0dXJlIGluY2x1ZGUNCj4gPiA+IGRh
bmNlLCBidXQgc3RhdGljIG92ZXJyaWRlcyBzaG91bGQgc3RpbGwgYmUgZmluZSBJIHRoaW5rLg0K
PiA+ID4gS2VlcGluZyB0aGUgYXJjaGl0ZWN0dXJlIGlmZGVmZmVyeSBpbnNpZGUgdGhlIHJlc3Bl
Y3RpdmUgYXJjaCBoZWFkZXIuDQo+ID4gPiBBbmQgYWxsIHRoZSBnZW5lcmljIHN0dWZmIGluIGEg
c2hhcmVkIGhlYWRlci4NCj4gPiANCj4gPiBJIHByb2JhYmx5IGp1c3QgZGlkbid0IHJlYWxseSB1
bmRlcnN0YW5kIHdoYXQgeW91IG1lYW50IDotKQ0KPiA+IA0KPiA+IFlvdSBhcmUgcmlnaHQsIHdl
IGNhbiBoYXZlIHRoZSBjb21tb24gZGVmaW5pdGlvbnMgaW4gc2lnbmFsLmggYW5kIGp1c3QNCj4g
PiBza2lwIHRoZW0gaWYgdGhlIGFyY2hpdGVjdHVyZSBoZWFkZXIgZGlkIGFscmVhZHkgZGVmaW5l
IHRoZW0uDQo+IA0KPiBTb3VuZHMgZ29vZCB0byBtZS4NCj4gDQo+ID4gSSB0aGluayBJJ2xsIGFs
c28gZHJvcCBhc20tc2lnbmFsLmggYWdhaW4sIHNlZSBiZWxvdy4NCj4gPiANCj4gPiA+ID4gLSBz
cGxpdCBvdXQgc2lnc2V0X3QgdGVzdHMNCj4gPiA+ID4gLSBhY3R1YWxseSBtYXJrIHNpZ25hbF9j
aGVjayBzdGF0aWMNCj4gPiA+ID4gLSByZW1vdmUgdW51c2VkIHN0cmluZy5oIGluY2x1ZGUNCj4g
PiA+ID4gLSBmaXggU0lHVVNSMiByZXNldA0KPiA+ID4gPiAtIFVzZSBpbnRlZ2VyIGZvciBzaWdu
YWxfY2hlY2sgYXMgdGhlIHNpZ25hbHMgYXJlIGVtaXR0ZWQgZnJvbSB0aGUNCj4gPiA+ID4gwqAg
c3lzY2FsbCBjb250ZXh0Lg0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBw
b2ludCwgaXNuJ3QgaXQgYSBzaWduYWwgaGFuZGxlcj8NCj4gPiANCj4gPiBNeSByZWFzb25pbmcg
aXMsIHRoYXQgdGhlIHNpZ25hbCBlbWlzc2lvbiBieSB0aGUga2VybmVsIGhhcHBlbnMgZnJvbQ0K
PiA+IHRoZSBraWxsIHN5c2NhbGwgb3IgZnVuY3Rpb24gcmV0dXJuLiBCb3RoIGNhc2VzIGltcGxp
Y2l0bHkgYWN0IGFzIGENCj4gPiBtZW1vcnkgYmFycmllci4gU28gaW4gdGhpcyBzcGVjaWZpYyBj
YXNlIHdlIGRvIG5vdCBhY3R1YWxseSBuZWVkIGFuDQo+ID4gYXRvbWljIHZhcmlhYmxlLg0KPiAN
Cj4gT2suIEdpdmVuIHRoYXQgdGhlIGNvZGUgaXMgZG9pbmcgYSByZWFkLW1vZGlmeS13cml0ZSwg
dGhlIGd1YXJhbnRlZXMgb2YNCj4gc2lnX2F0b21pY190IGFyZSBwcm9iYWJseSBub3QgZW5vdWdo
IGFueXdheXMuDQo+IFdoYXQgYWJvdXQgdm9sYXRpbGU/DQoNCkFzIEkgc2FpZCwgSSBkb24ndCB0
aGluayB3ZSBuZWVkIGFueSBhZGRpdGlvbmFsIGd1YXJhbnRlZXMuIFRoZQ0KY29tcGlsZXIgaXMg
bm90IHBlcm1pdHRlZC9hYmxlIHRvIGtlZXAgdGhlIHZhcmlhYmxlIGluIGEgcmVnaXN0ZXIgYXQN
CnRoZSByZWxldmFudCB0aW1lcy4NCg0KVGhpcyBpcyBiZWNhdXNlIHN5c2NhbGxzIGFjdCBhcyBt
ZW1vcnkgYmFycmllciAodGhlIGtpbGwgaGVyZSkuIEkNCmJlbGlldmUgdGhlIHNhbWUgaXMgdHJ1
ZSBmb3IgdGhlIGZ1bmN0aW9uIHJldHVybiBvZiB0aGUgc2lnbmFsIGhhbmRsZXIuDQpTbyB0aGUg
ZmFjdCB0aGF0IHRoZSBzaWduYWwgZW1pc3Npb24gY2FuIG9ubHkgaGFwcGVuIGluIHRoZXNlIHR3
bw0Kc3BlY2lmaWMgbG9jYXRpb25zIHJlc3VsdHMgaW4gc3VmZmljaWVudCBndWFyYW50ZWVzLg0K
DQpOb3csIGFsbCB0aGlzIHdvdWxkIG5vdCBiZSB0cnVlIGlmIHRoZSBraWxsIHdhcyBkb25lIGJ5
IGEgc2VwYXJhdGUNCnRocmVhZCBvciBwcm9jZXNzLiBCdXQsIGl0IHNob3VsZCBiZSBlbnRpcmVs
eSBzYWZlIGhlcmUuDQoNCkknbGwgYWRkIGEgY29tbWVudCBhYm91dCB3aHkgbm8gc2lnbmFsIHNh
ZmV0eSBtZWFzdXJlcyBhcmUgbmVlZGVkLg0KDQpCZW5qYW1pbg0KDQo+ID4gPiA+IHYyOg0KPiA+
ID4gPiAtIFVzZSBuZXdseSBhZGRlZCBtYWNyb3MgdG8gY2hlY2sgc2lnbmFsIGVtaXNzaW9uIG9y
ZGVyDQo+ID4gPiA+IC0gQWRkIHRlc3RzIGZvciBzaWdzZXQgaGFuZGxpbmcNCj4gPiA+ID4gLSBS
ZXN0b3JlIHRoZSBkZWZhdWx0IGhhbmRsZXIgYWZ0ZXIgc2lnbmFsIHRlc3QNCj4gPiA+ID4gLSBt
YWtlIHNpZ25hbF9jaGVjayB2YXJpYWJsZSBzdGF0aWMNCj4gPiA+ID4gDQo+ID4gPiA+IHYxOg0K
PiA+ID4gPiAtIFVwZGF0ZSBhcmNoaXRlY3R1cmUgc3VwcG9ydCAoYWRkaW5nIHNoKQ0KPiA+ID4g
PiAtIE1vdmUgc3BhcmMgc3lzX3J0X3NpZ2FjdGlvbiBsb2dpYyBpbnRvIGl0cyBoZWFkZXINCj4g
PiA+ID4gLSBBZGQgc2lnX2F0b21pY190DQo+ID4gPiA+IC0gVXNlIG5ldyBCSVRTRVRfKiBtYWNy
b3MNCj4gPiA+ID4gLSBNb3ZlIHRlc3QgaW50byBzeXNjYWxsIHN1aXRlDQo+ID4gPiA+IC0gVmFy
aW91cyBvdGhlciBzbWFsbCBjaGFuZ2VzDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoHRvb2xzL2lu
Y2x1ZGUvbm9saWJjL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDEgKw0KPiA+ID4gPiDCoHRvb2xzL2luY2x1ZGUvbm9saWJjL2FyY2gtczM5MC5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0NCj4gPiA+ID4gwqB0b29scy9pbmNsdWRlL25vbGli
Yy9hc20tc2lnbmFsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjM3ICsrKysrKysrKysrKysr
KysrKysNCj4gPiA+ID4gwqB0b29scy9pbmNsdWRlL25vbGliYy9zaWduYWwuaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3OSArKysrKysrKysrKysrKw0KPiA+ID4gPiDCoHRvb2xz
L2luY2x1ZGUvbm9saWJjL3N5cy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDIgKy0NCj4gPiA+ID4gwqB0b29scy9pbmNsdWRlL25vbGliYy9zeXMvd2FpdC5owqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gPiA+IMKgdG9vbHMvaW5jbHVk
ZS9ub2xpYmMvdGltZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAy
ICstDQo+ID4gPiA+IMKgdG9vbHMvaW5jbHVkZS9ub2xpYmMvdHlwZXMuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDkgKw0KPiA+ID4gPiDCoHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25vbGliYy9ub2xpYmMtdGVzdC5jIHwgMTM0ICsrKysrKysrKysrDQo+ID4gPiA+IMKg
OSBmaWxlcyBjaGFuZ2VkLCA1NjYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvaW5jbHVkZS9ub2xpYmMvYXNtLXNpZ25hbC5o
DQo+ID4gPiANCj4gPiA+ICguLi4pDQo+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xz
L2luY2x1ZGUvbm9saWJjL3N5cy5oIGIvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc3lzLmgNCj4gPiA+
ID4gaW5kZXggMjk1ZTcxZDM0YWJhLi5hNzkwZTgxNjU2NWIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N5cy5oDQo+ID4gPiA+ICsrKyBiL3Rvb2xzL2luY2x1ZGUv
bm9saWJjL3N5cy5oDQo+ID4gPiA+IEBAIC0xNCw3ICsxNCw2IEBADQo+ID4gPiA+IMKgDQo+ID4g
PiA+IMKgLyogc3lzdGVtIGluY2x1ZGVzICovDQo+ID4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Vu
aXN0ZC5oPg0KPiA+ID4gPiAtI2luY2x1ZGUgPGxpbnV4L3NpZ25hbC5oPsKgIC8qIGZvciBTSUdD
SExEICovDQo+ID4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Rlcm1pb3MuaD4NCj4gPiA+ID4gwqAj
aW5jbHVkZSA8bGludXgvbW1hbi5oPg0KPiA+ID4gPiDCoCNpbmNsdWRlIDxsaW51eC9mcy5oPg0K
PiA+ID4gPiBAQCAtMjgsNiArMjcsNyBAQA0KPiA+ID4gPiDCoCNpbmNsdWRlICJlcnJuby5oIg0K
PiA+ID4gPiDCoCNpbmNsdWRlICJzdGRhcmcuaCINCj4gPiA+ID4gwqAjaW5jbHVkZSAidHlwZXMu
aCINCj4gPiA+ID4gKyNpbmNsdWRlICJhc20tc2lnbmFsLmgiIC8qIGZvciBTSUdDSExEICovDQo+
ID4gPiANCj4gPiA+ICNpbmNsdWRlICJzaWduYWwuaCINCj4gPiANCj4gPiBSaWdodCwgdGhpcyBh
bmQgYXNtLXNpZ25hbC5oIGhhcHBlbmVkIGJlY2F1c2Ugc2lnbmFsLmggdXNlcyBzeXNfa2lsbCgp
DQo+ID4gZm9yIHJhaXNlKCksIHJlc3VsdGluZyBpbiBhIGNpcmN1bGFyIGRlcGVuZGVuY3kuDQo+
ID4gDQo+ID4gVGhlIHNpbXBsZXN0IHNvbHV0aW9uIGlzIHByb2JhYmx5IHRvIGF2b2lkIHRoZSBj
aXJjdWxhciBpbmNsdWRlIGJ5DQo+ID4gaW1wbGVtZW50aW5nIHJhaXNlKCkgYXM6DQo+ID4gDQo+
ID4gaW50IHJhaXNlKGludCBzaWduYWwpOw0KPiA+IF9fYXR0cmlidXRlX18oKHdlYWssdW51c2Vk
LHNlY3Rpb24oIi50ZXh0Lm5vbGliY19yYWlzZSIpKSkNCj4gPiBpbnQgcmFpc2UoaW50IHNpZ25h
bCkNCj4gPiB7DQo+ID4gCXJldHVybiBteV9zeXNjYWxsMihfX05SX2tpbGwsIG15X3N5c2NhbGww
KF9fTlJfZ2V0cGlkKSwgc2lnbmFsKTsNCj4gPiB9DQo+IA0KPiBBbHNvIHNvdW5kcyBnb29kLiBP
ciBhZGQgbG9jYWwgZGVjbGFyYXRpb25zIHN5c19raWxsKCkgYW5kIHN5c19nZXRwaWQoKS4NCj4g
DQo+ICguLi4pDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIDQpSZWdpc3RlcmVkIEFkZHJlc3M6IEFt
IENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQ0KVGVsOiArNDkgODkgOTkgODg1
My0wLCB3d3cuaW50ZWwuZGUNCk1hbmFnaW5nIERpcmVjdG9yczogU2VhbiBGZW5uZWxseSwgSmVm
ZnJleSBTY2huZWlkZXJtYW4sIFRpZmZhbnkgRG9vbiBTaWx2YQ0KQ2hhaXJwZXJzb24gb2YgdGhl
IFN1cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1DQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNo
DQpDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==


