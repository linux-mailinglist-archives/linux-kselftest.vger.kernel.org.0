Return-Path: <linux-kselftest+bounces-10974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919B8D5673
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE87B215D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9A17C7DF;
	Thu, 30 May 2024 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgivVOLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13617B418;
	Thu, 30 May 2024 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112786; cv=fail; b=MkdhYMXbBdDaFhKoMERGtbbRzswcYXh3I9fB9i3IWtZZKGYZNkhLSfuyqMdlWjrwa/LjWckQs9w8UkIYiC4uGSMkJuSdp7lfoV1vqgCziOX6SYZzG6GXLWdVDDN3hrg1BFfOccx/iI5VtfgZdyPvXo5RKK3kT+UBuXhCT2UprUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112786; c=relaxed/simple;
	bh=C1bcsetXCaq4RWTvr+tgh4tYUCbX0jGBvFffvHyaVP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dG3udiM0+pg7SQYWmGRynZG+pTy/fuyvF2/q/PvGN24PS1Lu61A5/GqsetO2ncburZdrn23dZ3hbUsm/t6z7A/vSXTTaP3bMdngzbsP9GQbcXc1A8Cs7xDJFdyf9YplpcYUiKG0bqDPcppkmrec8NT+8eTEShieob2e76/rFXUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgivVOLx; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717112785; x=1748648785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C1bcsetXCaq4RWTvr+tgh4tYUCbX0jGBvFffvHyaVP0=;
  b=FgivVOLx3vEFWAMRwnmZ7mVGGAkxZAdwPFftvmvbc5jpYa4hWJSNWfSf
   FH35+WaEa1TWnwOCQlpYQKlD60LFS/GUaQbXnDm8W88kEgEiCcma2a0Pm
   fin5pHtLMHDIXqV31aFmOrQRza/JkpuSj6kkUt7vX2zhtG9vGT9uPelvi
   0OmUtERpXQYdqboRlVcqLi34yvNIVeiUARQGQ/fXmpKbI+gnXUUi9A53z
   uCwKojhHZ8zUBqkB1vVcKk6/TqU74UPr+dStLB9FjwzF1LvwMAdndqR/+
   QiTCBwj8N8laCywUg9h7wUDrelzYwcUQtzRxkQ/Sjt9ojaQQZBJR7SwiW
   A==;
X-CSE-ConnectionGUID: CIxRNOT5SPSro/EhkV3SBw==
X-CSE-MsgGUID: asWuibuuSM+fcy2vImE15A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24200013"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24200013"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:46:23 -0700
X-CSE-ConnectionGUID: 7EH+Uc1aR3mgnrCr6j4O1w==
X-CSE-MsgGUID: Vmeq9RAgTFOzrqnhQeTk2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="59162717"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 16:46:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:46:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 16:46:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 16:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF25tjwfrPN5n5slRcnDuJnlY4m+CYYUgU7jvUwVwlZpgOPnPDHXdHbGhw7TZvcj6JSMwMil/Djwb0/dlRWpScRaBWRRLddGksdNflvn5a9uapOfKrbTgKT3m+dMLpbhDf6sqmq9a3fWISUmv87eNZ1wj/I6UDHy3K/MTPFLBbYXHJD775kCULk0gdQ472f2BkV7sRueaPCLPQsVju/x2MWKjFelGgJ/K/WGlmJg0YABNJaIzY2J4MfWj/imL3VQUF2QQWhU7ONSiG9dMdfHBKSdnCZW6RopEOCyVhqm3ZDjwdVWVD3Mj6NLmxFt2LJh1ozWCp0cZ5ynR63m7sYVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1bcsetXCaq4RWTvr+tgh4tYUCbX0jGBvFffvHyaVP0=;
 b=Im0KQfJKjBkfXxLil7cpbR6ZBLMhTMqDW2cny/VkAXJwQ0HUDPU3Mb+LOgFieR4Oy3F48oFgd7Moaqalg6B7uu39cJhPfe3/pQnvcovbRxDW6NfMgyuUt/sx6yRdFx2RzKDlIj7zbqZeGpyYG2gShLXbGCQHQPFFMe0pHUteYI667HhOOhBzciHI34fBjB6CxQSy1U1cEipklZwC7qdXBFa9lisFY3Ko3Us1ChF/vxzwm7kNy3n2BczE6LByLlolcgpgc8XhULzWVp1wLM+pAyyiTH/ZdNjVLDrGmgjfW6GlO9pPYPgsttYzvxHhKeDs1LlqLQ8p0hoR9971R4OmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 23:46:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 23:46:18 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Thread-Topic: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Thread-Index: AQHaprmme8fjFWvJ30CJk2uljzCiTbGwftaAgAAI17A=
Date: Thu, 30 May 2024 23:46:18 +0000
Message-ID: <SJ1PR11MB60833CF8BD209555A5370299FCF32@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
In-Reply-To: <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8009:EE_
x-ms-office365-filtering-correlation-id: 7c06448c-ee97-440d-b6bd-08dc8102b39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OW9CWm5jZE5BUUxIc3JIMjY4bklmSHJRY1ZxWWxHanJxTzNyS0dPdUhEUEIw?=
 =?utf-8?B?OTRWVFJKdWV1NGZsVG5QSk0rd1pSdXIxWFBCS0RWdFJyeE93SjB6Sm5WZU8w?=
 =?utf-8?B?V3lTMHBEOTE2YWZkcHEwbXhDdlRPMlFjOE40SnZnc0RydThXQ2xxSktpbURH?=
 =?utf-8?B?c1MyME1UMStmVVl5WGRPdHZlaVpDTlZ0b1U2SkdBL2tkOGdCZGxpNnhmNjRs?=
 =?utf-8?B?NS9YdUgrb2M3WlJTV3pqbEZOMGJPWGlvSzFjdjlxK2pyTE16S2VKWWJoSG4y?=
 =?utf-8?B?MXVHVU9wVm4vZ3BlUjJIeDlQY1AwcllxQ1J3K1hIR0xtRVlkdGxmVzVjTFFj?=
 =?utf-8?B?bjU2NXJOL0s4bHh5M3JaM2hsemI1TkdVeExNZWIya0FpQlV0a3hheWxicjU0?=
 =?utf-8?B?SDBYLy9tZ3B3YjQ1T2djejk5bGhxN1gwRzJaOWxXYURtU0dkWlc4NDJGSDdk?=
 =?utf-8?B?RDJ1MHdXeisvSG9EL2tvZUpsL0tDK2l2aXpvSklvU3BTenFBRjlRR1R5bkoy?=
 =?utf-8?B?UHlNSHcwVUZ6U0ZzU2huU20yNUt3S01MTUR6aUFSdWgyVCtCV3FMYjNvVHNE?=
 =?utf-8?B?MjNvZzdEd2RzSkZwb3FwRjZpcXBjMnVGYmZtU1o4M1kzVlFJM2pCZFVuWU5U?=
 =?utf-8?B?WVBEZmRJUVZZVUtmeDVJWFA0MmlLK3EwMEhFMGQxZFJSeFFhcGRkU01TTC8y?=
 =?utf-8?B?WnlwWjZqRCtzdi9Ha3NCRXNtcElaTWxWcW9Ebnk2Ly9YdkxXOGszSFRJVmd6?=
 =?utf-8?B?UnVtWWM3MERsMnQ4K0ZSVmlHcjExVEc2WXVMb1BCQmdqa2JzV1BMM01ZY1Vh?=
 =?utf-8?B?NGMwYzlyUmdHWlEzclVjY2NnbjdTYzlpVktyMlhJa3VUaTh3bjNvWmtveHZa?=
 =?utf-8?B?enJ4Slc4dzBaRW4zdm45dnY5dytpK25mQmd5WGVpWlZzV3BGR1gzdm1GbWpZ?=
 =?utf-8?B?M3IzNVZWQTFwaFBYbVVaa283WjNpZnpjNTd5VlpNRDNHS0tHK1pXMFAxaGZi?=
 =?utf-8?B?WkNrdVVROURFd2ZDVnJYUUNncHZhMFEwWW93aC9kUGZUU1lLV3J6S2dUdUkz?=
 =?utf-8?B?L3g0NVBCUVJUZ0lCdm80ck5TSnE1dTFKTlBHa1QxZDc5ZHJZOUtsVStmRkdh?=
 =?utf-8?B?TkFmUWpmemtDbzJhakZPZEt4RGVqamdDMWNNaDhzZ0k5eVVHRTFVcTdacEQ1?=
 =?utf-8?B?SzdKR0trNnlSYmZuZjJFbk5aclVFZWJuNG1xV2w0bi96Tk9HQTlPYXpUd1hP?=
 =?utf-8?B?eTZrTnpRbGdIUUx1ZzR6TUtoN2RWNzdmU3BhcWNuZnp4QXNmK1lHMi9jM3dn?=
 =?utf-8?B?ZVoyZ0lKT09PaEMxTkdaL1JOZnM0NmNJaHgyY2NOckdGWlJpdXN6ZVdjd2Va?=
 =?utf-8?B?YkdnWHVqN1hmYUc1U0hreWcxbXljeFhFdlZYVnluVE91U1BCQi92QmxWZzZL?=
 =?utf-8?B?YnBudkd3L2ZBVVJQMDZYbDdNUVNNMVlPaWZ3TjRLMytXZzIvVVhEeFJSdjFv?=
 =?utf-8?B?NzVvVjJWc0YzcWhaK0xWc3RQd1ZzMkxJSTVZdkQ3aEdyYm9yaUg4VzkzMWhO?=
 =?utf-8?B?TW5xNFl0SWxOSndGMzAyWXRvdlVZVTVsSGMvTURTNXgxL1dZUnAvaHVjUXRT?=
 =?utf-8?B?SncvanpCbEVLb1VDYis4eUwwWHpTN0xFTWQzQzVRRmh2dXdtaUVPQXEvQ0t2?=
 =?utf-8?B?cmwrQXJKc29ncUViWmdwdUxnY2c2R0NIZGVHRWx5N2ZEQm5kcXhkT25YdWdX?=
 =?utf-8?B?L3dhTGxCcjZJY2xVa2hpSWNnZEFRKytqZUEwREc5WWxBZjFqSTRqeHVnZzRy?=
 =?utf-8?B?b21qN3hTRmxoSmMyQU5vUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3gyZGQyZ04xSDlJbHVJMzE1aWFhVU1WSlEyekZJQTIyb2lOdHFJSEM4RGd0?=
 =?utf-8?B?Sm4rbVBOdVlTWFA0SjJFTWUvaFdmMVVZLyt2dGo5VG5xQnlCOUpoT1ZoYjA2?=
 =?utf-8?B?MFIwRVVzK2wvRmFLZDZYc2NaOTNHaFFXTnZRR1FRQlN4NnRsQ2NkNjVsbTdD?=
 =?utf-8?B?QjRqL0hzYzRtL2lkMWFYeGtmRXF3TWswUUlnaXU1TjNqQWNnTmlEL2ZGYjZN?=
 =?utf-8?B?UG1GbG9JZkJDS1ZWMGk5R290UFNnSjMvTWtTamNxOXpOSHFGcE50UVBlQWV1?=
 =?utf-8?B?ZEdwT2NOK2tpdlV6cUF4Wjc0T1QyY3drck9jUVZaVG1KVWN3aGlneWY4d3JH?=
 =?utf-8?B?b2lVc0VKU2lTSXhqZ2Uxdm14SFhhakhjVEk2L3JBc3VoQklRNXl3dUh2bkc3?=
 =?utf-8?B?ZmU3NXJVN2kxUDBBQkRpeE5QalF2ZVVhRENuSzEyV3RnZktKWmhHWm51ZUpH?=
 =?utf-8?B?TDZEYkIwVjloZnZJV1IwbTBYNXh5dmhTTDI1WjltQ2ZWMndkanN3ZG85ZVZ2?=
 =?utf-8?B?SmZVVjRreWExczN3WGxZdFpGaTVhbkQrb0E2cmNRajBLcG9nSlB2NmNHVHl6?=
 =?utf-8?B?VXUwOTdKcUdudjg0bFNFd2VIZCtaY1E0MVFudi8xeHFuaStMdUd6dWN6ZFBt?=
 =?utf-8?B?N0draTh3ZWJ0bk1qYXRTQjhveWxUN20ycTAvbU9Db1oycjd6azUvQjFDdElO?=
 =?utf-8?B?dThBQkkvakNjOFRuQjN1VklKSWlDRTl2WVByamZuZDBkVld5Z0poZVB5cWdP?=
 =?utf-8?B?bXJJYkduMDduTGd6aUxzOUdyZ1ltZXpLNUFLUGFsaHp4cmR4UDhVZCtXcDc5?=
 =?utf-8?B?bWJpRjhKYndsMVkxdWRZRUtHd3NkUTZ0Qms3ZVZBQnFIOFgvcE1Ga3luenp4?=
 =?utf-8?B?cGZ3WG9WcU9YNFhRaXpOcVljMW1DVHNoa1RwQitVbldvS2xSak00aCttRHZk?=
 =?utf-8?B?ZjlwNWlKaDVVNzNFTzdVRVZXZGxuay9td1V6UWdEZjBEWDFZcmgzdDg0Ty9E?=
 =?utf-8?B?Q08wek01aVBmOEJNZURjQkV3WFBleW9Bd0pJVG1pbTVEcWNMa2prdlhINWIw?=
 =?utf-8?B?SXNDb2F2ZnVvMzBvb0lFVDBuNC94UXh6RXNZOXlPK0FTN3doR0IwSDZpSmlN?=
 =?utf-8?B?ZUVoYVlOTVE5VEhXTDFVOW5vQ1AxSHErem9sdDVMTk5rem5PTStDbFJVV1hU?=
 =?utf-8?B?Rlk5dEYwWDlxR05zbEE0eWxHTFNyQWRhWFUvSzdjQi9xb1lMUFlQcjB4L0xq?=
 =?utf-8?B?aUxGWitXanl6cnBZZk9IeHQ0SXZRNE50WjBDUmhSb2pndHlMMmtmRkZzRk0r?=
 =?utf-8?B?a1p0ajB1cHNjYUtHb0NpYm9HYnFwMlFsaUZJYjQvc0daS2d1VTNmRDFmQ2N0?=
 =?utf-8?B?ZkVoOG9TU0s5N3VuK2tZam1QTVJia0ZSMGNId3VVQUVVcjdjWE5uQVg0Mm5P?=
 =?utf-8?B?NVJ4N2FwUDF5dGcrd216N0FuWllaVFl4TGE3NXh5QTVKc2RreUQ0ODN4VGc3?=
 =?utf-8?B?M0RId3pqdnB4dGFHMDNvcHJ0MlZMK1pCeCtJNDU4amprSTNzNzE2dG5Zb1BK?=
 =?utf-8?B?QVBlQ2lGWDdEczNMNnBpT3o4QmZxQlNJejFlQ1d2M3ZkcmlHWTJSdUJaK2Qy?=
 =?utf-8?B?Q2gzSW5melM2VWNsVmhjbmlVOTJrMVhETS9kV0ZEYk96RkRkZXVWQytyb1o4?=
 =?utf-8?B?Ry94MTYwTGhqYnJBeDZKYVhWK2Z5MWo0L2Zyd1dienNDMnlpcTVqTmdNbzFm?=
 =?utf-8?B?KytpdnJydWlCb2RuaG1Vd2l2SUJnOHdmNHltQjRYcTkrZzB3STF1TG5JZU9U?=
 =?utf-8?B?eTFHYXI5VFE4WC9wN3NjaXRWL0tEelR4c1FEckhHeERlV2Y4RGJ1ZlZTTzJp?=
 =?utf-8?B?RkROdDJRWHJkMUNNcS83eHNjVkg2dmxoVzBtMHlQb3Y5R1B2aDFNOXZEemkr?=
 =?utf-8?B?dGdrNDIwSlpUYzZMdWdLYTJHSEEyaHdxeVpaSG5PSmdMQmwzL2pLSThseTB6?=
 =?utf-8?B?Y1h2SUUxYklLZ0lGRjZYM2lreS9Gc3NnaEI1MTlScERjdEo5OFZpT3lDdmQ4?=
 =?utf-8?B?UnhiVmcvQ1huck80eElpK0g3YkFHZU0rb3FOTE9IYXpNSzdvdGRUaGU5MHpa?=
 =?utf-8?Q?7Hp7T1PNX/C/0xg0HUxFPP65y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c06448c-ee97-440d-b6bd-08dc8102b39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 23:46:18.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gWQSyDF5uXw8TLqgpRewg947OC596TQsIwLoBadzd776skzAdHOwXSlxl5WzDBFYeA0EuJ+s4lNk7CM6l33mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
X-OriginatorOrg: intel.com

Pj4gV2hlbiBTTkMgbW9kZSBpcyBlbmFibGVkIHRoZSBlZmZlY3RpdmUgYW1vdW50IG9mIEwzIGNh
Y2hlIGF2YWlsYWJsZQ0KPj4gZm9yIGFsbG9jYXRpb24gaXMgZGl2aWRlZCBieSB0aGUgbnVtYmVy
IG9mIG5vZGVzIHBlciBMMy4NCj4NCj4gVGhpcyB3YXMgYSBtaXN0YWtlIGluIG9yaWdpbmFsIGlt
cGxlbWVudGF0aW9uIGFuZCBubyBsb25nZXIgZG9uZS4NCg0KTXkgb3JpZ2luYWwga2VybmVsIGNv
ZGUgYWRqdXN0ZWQgdmFsdWUgcmVwb3J0ZWQgaW4gdGhlICJzaXplIiBmaWxlIGluIHJlc2N0cmwu
DQpUaGF0J3Mgbm8gbG9uZ2VyIGRvbmUgYmVjYXVzZSB0aGUgZWZmZWN0aXZlIHNpemUgZGVwZW5k
cyBvbiBob3cgYXBwbGljYXRpb25zDQphcmUgYWxsb2NhdGluZyBhbmQgdXNpbmcgbWVtb3J5LiBT
aW5jZSB0aGUga2VybmVsIGNhbid0IGtub3cgdGhhdCwgaXQNCnNlZW1lZCBiZXN0IHRvIGp1c3Qg
cmVwb3J0IHRoZSB0b3RhbCBzaXplIG9mIHRoZSBjYWNoZS4NCg0KQnV0IEkgdGhpbmsgdGhlIHJl
c2N0cmwgdGVzdHMgc3RpbGwgbmVlZCB0byB0YWtlIHRoaXMgaW50byBhY2NvdW50IHdoZW4gcnVu
bmluZw0KbGxjX29jY3VwYW5jeSB0ZXN0cy4NCg0KRS5nLiBvbiBhIDItd2F5IFNOQyBzeXN0ZW0g
d2l0aCBhIDEwME1CIEwzIGNhY2hlIGEgdGVzdCB0aGF0IGFsbG9jYXRlcw0KbWVtb3J5IGZyb20g
aXRzIGxvY2FsIFNOQyBub2RlIChkZWZhdWx0IGJlaGF2aW9yIHdpdGhvdXQgdXNpbmcgbGlibnVt
YSkNCndpbGwgb25seSBzZWUgNTAgTUIgbGxjX29jY3VwYW5jeSB3aXRoIGEgZnVsbHkgcG9wdWxh
dGVkIEwzIG1hc2sgaW4gdGhlDQpzY2hlbWF0YSBmaWxlLg0KDQotVG9ueQ0K

