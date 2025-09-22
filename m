Return-Path: <linux-kselftest+bounces-42045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E850DB8F39B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 09:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75627A61AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D02F1FD3;
	Mon, 22 Sep 2025 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGQQXgrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2E2F0C7B;
	Mon, 22 Sep 2025 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525067; cv=fail; b=mZjGmO1mIMYwAjVtcOqkTF5mkJ4KH+PtzUzPmi1nBZOyJHBSY5E0c3FQkS0cYR8EJWwpHDH5k2a4ZNJikpi+4n/51ckZMdbOXLJwf8wPbx0Ueh6jbpORzAnaNHN9Ak2dpbKLZDQoqJhABTGsg/ua/zPcO2YbM5kvGXZPJZ9h3yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525067; c=relaxed/simple;
	bh=vDr1vaIQcnY31b3shZSmwdAxyijo3vjKPUseaNVbkQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F5Bv8s03CjrH8hUQcOIkN/POB4hNll5OPRTZ60QpB6stMzFwbjSm9lAvo5y39hwAEc0ZImm+TNWee7AwK6RrjcOqd1Rc6VAm3CJAgPj/mr1zb8YqjqssSMS0iwDrud+8pLbX3VbLWT7zB+wxsXQg05WeabsVmDP/scM1/m4Zq8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGQQXgrI; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758525065; x=1790061065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=vDr1vaIQcnY31b3shZSmwdAxyijo3vjKPUseaNVbkQs=;
  b=DGQQXgrI9Vc7IeaYzCuDy4aHiiRVW3E7mzlqiaFY8wKKHmv5nT1wUfb0
   XhhErRYzp5dAB1iyJNlwwdjR4F4TxVFdqclcrpV0+vUkmA6uyRCXReDRq
   ELCfN12iJ/coHzrCh0eIxO2fnOiVtJwlg1purSS5r6GU54E9HRJNK8Lrd
   43w3GV1Zs7379AiItjxlEU1nTK2tsmezqZqWIeJ0R9ex/AXH31ISqaW+y
   KZ9ByOMOpdmXDiVpDqIIA02MLvZmdzj+sIvmZapcn6kfV1kvc6sHJg0yd
   YH0bPDTnzzmCorQn+1w3NJ9cX1BbKUHUIefR3l05Afp5Z8V0M3OO7YII9
   Q==;
X-CSE-ConnectionGUID: Yzzy8bPhSm6oHyuauFt+pg==
X-CSE-MsgGUID: Xyis2MpgT5aQe24OhUVmLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="59997663"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="59997663"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 00:11:04 -0700
X-CSE-ConnectionGUID: zvPxTKbDQrOx0iKzAt2vsQ==
X-CSE-MsgGUID: eDCanUFRQDS0pMKG3GdcPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="200119484"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 00:11:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 00:11:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 00:11:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 00:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIGK91XcUJzVqHT6acQ0a+aQBxYFUhP44KMHT3ycjrkC0bD8Xny4AQDOIUkBH2J5B+XFPI4aMNGAhlraJ3rGdy2xgU4BDxJoZSzZd3DHfeYwNw4lke2UmBKGEZoTH4Ctw1Yp8+YFa+EVlWz1FqhIcKHBbqk1JmoQrk6vyr7WaoaMSwPqATaGk1C96tuZIbOiwYlHL7Zv6GhS6bKFqFtb3KsxJYmqQmVD83MoqWvFrX0KFUxcDnaq3SwqqtsspHeTL6CgtLiJvk04xpSDUX/+aF6JIlckBm0OGF7s9PhlA2y0XR8rwSA225fSc7OqaPMlXao5Agu4rfjhDs+5sTVPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOOCWS4qsLFPCXPMt99VQNm2pMxf3gMMuNOmwZguj7k=;
 b=qvJhCMG7nzILSTn8zxYNHdD0pcVsHrypxNEeGEmQq6ExmUTI3phwqIrOT9dJ04aHez/mmT59AYLCRJUyAzPSKsiI/bgYqn33jE1lZ2OpkSahtobOHF3Mur/NITpPB61GT/uOTfvASrpGMxPRFHAC9AfNI2qsHmcfg5wMQTp1Yp5YaLFi5LSVi4WfcWc5LWXx/qprmVmKQ57RNRTwVvqkqUuRU0Iz0goEU2PPu86DaLZzC/JgR8BrWO1UeutccRNvK4BRFWmtPUgHm+CCpXPYGOSppioLAs9dNfe6RBCNDhy4oijRqKp9EApYO3ARwbRCSZvhgHZyCewe2Fn9See0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 07:11:01 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%7]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:11:01 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "w@1wt.eu" <w@1wt.eu>
CC: "acme@redhat.com" <acme@redhat.com>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "linux@weissschuh.net"
	<linux@weissschuh.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] um: add infrastructure to build files using
 nolibc
Thread-Topic: [PATCH v2 07/11] um: add infrastructure to build files using
 nolibc
Thread-Index: AQHcKXsomVpzJc9HgUCyR/Mli4h1drSdTDUAgAGA7QA=
Date: Mon, 22 Sep 2025 07:11:01 +0000
Message-ID: <9d0434033c9475d88184e1e12d5a13853492dfde.camel@intel.com>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <20250919153420.727385-8-benjamin@sipsolutions.net>
	 <20250921081318.GB16684@1wt.eu>
In-Reply-To: <20250921081318.GB16684@1wt.eu>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|IA0PR11MB7187:EE_
x-ms-office365-filtering-correlation-id: ae1f9f5e-8ea4-4995-3e89-08ddf9a7300a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVdQWnJUVTJTY0tBV1RZQWthTnA1UkhtZzI3TFR3THh2K3laK2hqZlhhM1Fx?=
 =?utf-8?B?TllOSjhqS0lOSlNFUm1qeFIxdndlSHpJKzNTUjlDVFRreWtQcDExQnpDWCtK?=
 =?utf-8?B?UUI4ZnhLWEtDQUJmNnZUZm95dmptWGRUclNtQXdLWXNkZXRleFpkbEZ5QmN5?=
 =?utf-8?B?UXFaNEdjeUczSGlndFBZYW8rYS9DdFZlaGlhaVFhVzVZeXhieEpyVWhxd1lt?=
 =?utf-8?B?cWZxazVBL1E0MVlIWmZrMmJrVWhSRnlDcHNtVjloR1g2eDV2dVRIbGQrZkR2?=
 =?utf-8?B?MTBNZ0FmcmdPWk1MV0VrU3B6OElITWJsbkFMTEFtWWVpNksySzNUZGpyZGlP?=
 =?utf-8?B?TGlLOFZjK2UvOUxMN3hneTIxMXl2R0ExRk9FYkxINExEY2xkeHBzVzJQMjJI?=
 =?utf-8?B?STBnT2Z4Nk1vRVl0RU9TdktTZHNTRmJ3YllaOU1zcVRCK0ptOGdKN21Tb3E5?=
 =?utf-8?B?ZFJQSjljMkttV1EvSUJ3MmVjWE5FcWhxOHhiTmVhMkdJbFVYWUpsN1hhc1Uy?=
 =?utf-8?B?N1cvVWVNNHMxVlI4aUEwZUlXSlkzclRwN1VMbDFnL1UzZDBoSjBSNGVLVFNE?=
 =?utf-8?B?TDN3K2J0c3U1L1pnUGtJQU1iaVloeUo2Qi9QdloyYmlXL2o4QUx0RHVHUUR3?=
 =?utf-8?B?RHRjaUVMcG5vVklxQzE1WmRRcjkzcVIvMW5jRWtZM0phVG1LV0lBMU93dzg0?=
 =?utf-8?B?b0M1cTg0QlpieDlXU3ladDRPVDdBQnJsVHVPenExaWw4cjg2UHFnM3VYQjdQ?=
 =?utf-8?B?cmNzWHZSREl0MjUvdzJYaXJHV1IwTVY1RDRnNzRYN2VVWHJ2a0libTdFZnpP?=
 =?utf-8?B?NUhOR2ticDBaNERXb0doT1RkMWgwaDBIdWJVREtIMGNGWmh3TktlazlBanA3?=
 =?utf-8?B?Z0hCbUNhRHJLeXdrblgvbGZIbStac1V0UGRyL0pJYTBUaG8vcUhrNnJqZHBB?=
 =?utf-8?B?WmxtQXVEVVJMdEtOcDU2bEIzRlhsSEVDVlRCdlNNSW5DcnF3Z0V4aDlXeDFF?=
 =?utf-8?B?OEI5WWlDNXBmSEFRak9JYUpURzBYazdZc253SVZSd09obStQeG5iQ0lndmlq?=
 =?utf-8?B?ZWZjVGMzWitLU2pHekF1R0xZQ0VFUWkxSFpubzYrSmU3MWgzV3l6M1dHU2Rk?=
 =?utf-8?B?aEU4Z3dFekFwOG5KUnJncGdYUUVVY2hDYkdCVm5MYVJaR3FFeW4rNnZEdXYv?=
 =?utf-8?B?UVFKVnZBQjIyUjZSZWw2cHFjajZMcXR3MElPazhuMWloWGlnVDRYNjRMMUpN?=
 =?utf-8?B?UTRzNjBPalNyQU44dFBidmM2TU9DVmZNZ1BKOXZBRDFlUXI0K21ESEw0R0pI?=
 =?utf-8?B?MFQ4cmM2RFhKeldWRW5VQk9pam1FRjMxZllMVnNUTXozd3B3R3Z0eTdROHRQ?=
 =?utf-8?B?SzVheWV2eXBnR05iZUEvOVlHVm9YL05CTEkzamJiU3EzNm01Z0Q0dGJwVXZR?=
 =?utf-8?B?Y09uM1NEdDkyV21qVDZqZ2ZnT2FBN2dlaGwzTDU4MmtFVEZpdGtIaXFJcU5B?=
 =?utf-8?B?UEMvZHJkMk1HTXZWRm9oaFNDZldrNzhBek51aXlDUm5HR1NhTk9uM2FBY2hU?=
 =?utf-8?B?TTNLVmZNdHMyRkUrUW8vWFNEK2VUUjIyVVJ0T1RVWjFhQzY0NTkzelBZWDd6?=
 =?utf-8?B?SkhjRDltTUZmdXNhWWdLWnRaRW5MaXBTZ1hxU093aWtFdFV3Uk1DbzhreFlU?=
 =?utf-8?B?Zmo4UnNBVllwYjRYSVhnTXNqZmduYkt4WnU1eCtwV0loNkllNllTVjhaci9a?=
 =?utf-8?B?RVZEaVRBRWM0UmpESUNKNjZuMGpvWkdORHVPeGRyTkpTdmlHVGlscHlkYjB1?=
 =?utf-8?B?bk52ODBUMlpCZytsbEczaUp6N3BOZmdBR2NDOFRVWElxclVEYVBrOGVtcGM2?=
 =?utf-8?B?V3NDcVF6V0N5aExMckQwcU5IZjRRTS9wSnlaWnpzYzQ1UHRXbmlZZFZDWUpk?=
 =?utf-8?B?dStkWFBTMEJlSms4c3c5a0MwMWNLTU9LVmUwRVNSeUJKclVXWWhCempob0Fq?=
 =?utf-8?Q?+kl7VSq+WjWJssFsAHeZtb9csOYhnA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVczbTNhVm5USHVraXJMcTF1VFdaN0RvTUtqaWZjbERVRGdmT0lzVXRQRmFh?=
 =?utf-8?B?WTdLWEdYOCtldmsyYm9EcE5iQTJDOUhlMVMzN0JvbDh3QjJNcldOVTNUQkRw?=
 =?utf-8?B?TklsNEh1b0w3ay9ROHVjS2dzaGVINjUveEltbEJJTjRMTUpqS1E0OU1DTFdj?=
 =?utf-8?B?bnRQOE1oM1VoQVhFbGNSdGt2RjhLcjdwSEtGa1JURk1peFdDQVIvT3djVHhE?=
 =?utf-8?B?Um15ZzF5aTk1ZklaOTgrTTlQdHQ5L2U2a1kzVU5Nc3hEdDVMRWM0MGFnZllp?=
 =?utf-8?B?TWhUY0pzaDJxbXQ5eFd3bkZmQkUvdkFWNFl2TWZjK3BLejdUMlJYcWt5SEt0?=
 =?utf-8?B?K3N5QlVHZHhUWE5TUWloVktQMXlZSDJXU0phV3J0NDJrRXhQaU5mb1NRdW1w?=
 =?utf-8?B?TXFaUlNVcVAzUW9lVlVjSXR4QVFBMVVqOWdodEZ1eE5JOVVVN3dTYnNYdEsv?=
 =?utf-8?B?UGljZHlZZmRGWnZ3OE52Y29XYjNZaWNaOW5VMTdEZHpNS0g1ckFSb1IwRFkv?=
 =?utf-8?B?R0RTNjlUbWtJWGc0aU5FVjRqN0phaUxEcWNHQlBIVXExZSs3NUd2MGkyMkp4?=
 =?utf-8?B?Rnhpeml6MEdjM09PQnZoZ3BIaWVRWHRSa09UUGI2ODdCS05pQnZDL1FQYjhR?=
 =?utf-8?B?emtXTHJ0MzhjS1RRbE10MkEyQWptUGlEZnlNSE91QldUQjhtcU1nQmJLOEUv?=
 =?utf-8?B?QWdxMkcwaXl6TllMRGpuUFU0bW91aVgza1kwbmxueDdmeEJOcTBRcC8vMXQz?=
 =?utf-8?B?UGNTSVBLblZOQXpEYmJpL1BHUlBSdW9JeHNqNE9jS3hnb1hEdGs4Nk1SY0lI?=
 =?utf-8?B?TklRdzIzTFRqUEhGSlJYTGxyeHFtUm4rRi9sczJLYzNvUGMzVkwyVDhDck8w?=
 =?utf-8?B?Q0NSMDdLVlI1bzFkQVZtTFF4MnFad25sRW04UnBuMnVkRTI5UTRpdFlwNkVS?=
 =?utf-8?B?a2NXOTNoQVdtbEUxSkRSSmdIZEtwa1ZuOFVFb0JyQmQyZTU2TUZMZmw1OGNG?=
 =?utf-8?B?Y3I5TXVWNVVxV1NDc01KZlhhbGVzTkN1ZWVIN1JieUlIU2JJbnVUT0ZxbktJ?=
 =?utf-8?B?L1JSVVZSSTV6STlYN2NVajd2RmtzckU1M3MrTHpYMmFERU9NVE5GeWM2b0l1?=
 =?utf-8?B?dCt6VDVlVE9pbVMrK2NvVko1a3ZKTXR5ZUc3aUgyVk1HL0cvYTMrMmpaZWNk?=
 =?utf-8?B?RFZiZVI0UkxUOWIrM05xQ2ZZRUx5bEQwMFc3ZlNSOXEwb1NnRloyd2liVjhq?=
 =?utf-8?B?TllQY3o2ZDVrVStYRU5reGZuUUNtRWNnYjdaV1BvSk9QZnFqaGUxaER4L3RQ?=
 =?utf-8?B?OVhGdVF0WmwyUnlINit4ejRoQkk1aUZTWllGRm5HQlBCQ2kvMGV4MUFKekRo?=
 =?utf-8?B?T1FGN2VuamFKRFVzbDBwT1A3RGFlYzE0dE8rUDg5SXRLU1ZvUnFvMGVjeXlN?=
 =?utf-8?B?Y1BPNTNoQjJZYUo1RVhrRUR2OHlDVThKbUpwUnN1UTk1azBQTFN2MmhOQmRv?=
 =?utf-8?B?dld0UkZVMitGVUczbHE4S21CdTM5dDE1UlBkaXZLK2tGWXhIMzlRcHhNMnlF?=
 =?utf-8?B?Ym1QVlRQRW1XWnJTM1lVQzZYbGhmcllVRGs4YzAzNTNyNEZrckd1LzBuc2VK?=
 =?utf-8?B?a21ReGh2NmNNUWJNUDhQWjZGZzY4aEljQURwRDc1ZmFlaC9QdmVGSmMvWUhG?=
 =?utf-8?B?SnhNSThvcW1EajNYanZFL3ZQMHQyRUViK2pBUUVDQytuWTBGYmc0dDhnditQ?=
 =?utf-8?B?SnJXQjUrUDMwUUVFSXVYWm15ZzgzVi82eG9kRGh0YUZRcFJXeTJUSXh4TmlH?=
 =?utf-8?B?YjhsOGJuYjV2cmJ5R2hjdkNjQ1JZSjViYWFQUkxDOWFSSzErM0I2UHNpcGU1?=
 =?utf-8?B?YnlMdHZCWHppOVJiWWhiN3RzdHpqVVVWWTRHMndyVVZsYWZKbXp5QTlKOFl2?=
 =?utf-8?B?UTIvbDhVNEJVcXo1eTNRRUxFNUFtV3haajhXM1pjZHppekNRcHNDU2xQWGk0?=
 =?utf-8?B?NzJxWDNKb09zelpBbmRiTlFVWmRiSHBKRy9jTWo2QXM0cHFudm1Sa0QvN1I0?=
 =?utf-8?B?djNlNEpxT0ZhcDJmOTZLQ0puaGMxcFc1bWU3VFBXamJoYzdoQ21qdFFIUVNm?=
 =?utf-8?B?YkMveHNGaHVnUTF2azdNdW9UYkFmaG13clIzWFk3UHc3VUVMakN3emFhQThT?=
 =?utf-8?B?OHNaTHFVZkFGNk5KbzdJMUZNTWozU3VKa0ppakJGSFR2aGRlY2VxRmlQc2h5?=
 =?utf-8?B?WXlJWmdSNVBnNXUyc09RSFV0UU5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89FBE295397EA342A5EDF9EBC37AF9F8@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f9f5e-8ea4-4995-3e89-08ddf9a7300a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 07:11:01.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HGIJITAFBh5UIHMO87DGxw4oc5uyriQVqDGEYL6R365o7m0RyUAy6aoOqo0JHZ1MjCD3POrlliin+BTkfP49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFN1biwgMjAyNS0wOS0yMSBhdCAxMDoxMyArMDIwMCwgV2lsbHkgVGFycmVhdSB3
cm90ZToNCj4gSGkgQmVuamFtaW4sDQo+IA0KPiBPbiBGcmksIFNlcCAxOSwgMjAyNSBhdCAwNToz
NDoxNlBNICswMjAwLCBCZW5qYW1pbiBCZXJnIHdyb3RlOg0KPiA+IEZyb206IEJlbmphbWluIEJl
cmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPg0KPiA+IA0KPiA+IEFkZCBOT0xJQkNfQ0ZMQUdT
IGFuZCBOT0xJQkNfT0JKUyB0byBidWlsZCBmaWxlcyBhZ2FpbnN0IG5vbGliYyByYXRoZXINCj4g
PiB0aGFuIGxpYmMuIFdpdGggdGhpcyBpdCBpcyBwb3NzaWJsZSB0byBtb3ZlIHRvIG5vbGliYyBp
biBzbWFsbGVyIHN0ZXBzLg0KPiA+IA0KPiA+IFNldCBOT0xJQkNfSUdOT1JFX0VSUk5PLCBhcyB0
aGUgbm9saWJjIGVycm5vIGltcGxlbWVudGF0aW9uIGlzIG92ZXJseQ0KPiA+IHNpbXBsZSBhbmQg
Y2Fubm90IGhhbmRsZSB0aHJlYWRpbmcuIG5vbGliYyBwcm92aWRlcyBzeXNfKiBmdW5jdGlvbnMg
dGhhdA0KPiA+IGRvIG5vdCBlbXVsYXRlIHRoZSBsaWJjIGVycm5vIGJlaGF2aW91ciBhbmQgY2Fu
IGJlIHVzZWQgaW5zdGVhZC4NCj4gDQo+IEp1c3QgZm9yIG15IHVuZGVyc3RhbmRpbmcsIGluIGNh
c2Ugd2UgY2FuIGltcHJvdmUgcG9ydGFiaWxpdHksIHdoeSBpcyBpdA0KPiBuZWVkZWQgdG8gZGlz
YWJsZSBlcnJubyBwcm9jZXNzaW5nIGhlcmUgPyBFdmVuIGlmIGl0J3MgbGltaXRlZCwgaXQNCj4g
c2hvdWxkbid0IGNhdXNlIHRyb3VibGUuIEkgbWVhbiB0aGF0IGlmIGEgcHJvZ3JhbSB3b3JrcyB3
aXRoIGl0IGRlZmluZWQsDQo+IGxvZ2ljYWxseSBpdCBzaG91bGQgYWxzbyB3b3JrIHdpdGhvdXQg
c2luY2UgdGhlIG9ubHkgZGlmZmVyZW5jZSBpcyB0aGF0DQo+IHRoZSBlcnJubyBnbG9iYWwgdmFy
aWFibGUgd2lsbCBub3QgYmUgZGVmaW5lZCBub3IgYXNzaWduZWQgb24gc3lzY2FsbA0KPiByZXR1
cm5zLg0KPiANCj4gPiBHdWFyZCB0aGUgc3lzY2FsbCBkZWZpbml0aW9uIGFzIGl0IGlzIGEgbWFj
cm8gaW4gbm9saWJjLg0KPiANCj4gVGhpcyBvbmUgaXMgaW50ZXJlc3Rpbmc6DQo+IA0KPiDCoCAt
LS0gYS9hcmNoL3VtL2luY2x1ZGUvc2hhcmVkL29zLmgNCj4gwqAgKysrIGIvYXJjaC91bS9pbmNs
dWRlL3NoYXJlZC9vcy5oDQo+IMKgIEBAIC0zMjcsNyArMzI3LDkgQEAgZXh0ZXJuIGludCBfX2ln
bm9yZV9zaWdpb19mZChpbnQgZmQpOw0KPiDCoMKgIC8qIHR0eS5jICovDQo+IMKgwqAgZXh0ZXJu
IGludCBnZXRfcHR5KHZvaWQpOw0KPiANCj4gwqAgKyNpZm5kZWYgTk9MSUJDDQo+IMKgwqAgbG9u
ZyBzeXNjYWxsKGxvbmcgbnVtYmVyLCAuLi4pOw0KPiDCoCArI2VuZGlmDQo+IA0KPiBJbiBub2xp
YmMsIHRoZSBzeXNjYWxsKCkgZGVmaW5pdGlvbiBpbmRlZWQgbG9va3MgbGlrZSB0aGlzIG5vdzoN
Cj4gDQo+IMKgICNkZWZpbmUgX19zeXNjYWxsX25hcmcoXzAsIF8xLCBfMiwgXzMsIF80LCBfNSwg
XzYsIE4sIC4uLikgTg0KPiDCoCAjZGVmaW5lIF9zeXNjYWxsX25hcmcoLi4uKSBfX3N5c2NhbGxf
bmFyZyhfX1ZBX0FSR1NfXywgNiwgNSwgNCwgMywgMiwgMSwgMCkNCj4gwqAgI2RlZmluZSBfc3lz
Y2FsbChOLCAuLi4pIF9fc3lzcmV0KG15X3N5c2NhbGwjI04oX19WQV9BUkdTX18pKQ0KPiDCoCAj
ZGVmaW5lIF9zeXNjYWxsX24oTiwgLi4uKSBfc3lzY2FsbChOLCBfX1ZBX0FSR1NfXykNCj4gwqAg
I2RlZmluZSBzeXNjYWxsKC4uLikgX3N5c2NhbGxfbihfc3lzY2FsbF9uYXJnKF9fVkFfQVJHU19f
KSwgIyNfX1ZBX0FSR1NfXykNCj4gDQo+IEV4Y2VwdCBieSBtYXBwaW5nIGFsbCBzeXNjYWxscyB0
byBfc3lzY2FsbCg2LCAuLi4pIGFuZCBhbHdheXMgcGFzc2luZw0KPiA2IGFyZ3MsIEknbSBub3Qg
c2VlaW5nIGFueSBlYXN5IHdheSB0byBkeW5hbWljYWxseSBhZGFwdCB0byB0aGUgbnVtYmVyDQo+
IG9mIGFyZ3VtZW50cyBpZiB3ZSB3YW50ZWQgdG8gbW92ZSBpdCB0byBhIGZ1bmN0aW9uLiBBbHNv
LCBhIHN0YXRpYw0KPiBmdW5jdGlvbiB3b3VsZCBzdGlsbCBjb25mbGljdCB3aXRoIHRoZSBkZWZp
bml0aW9uIGFib3ZlLiBJJ20gd29uZGVyaW5nDQo+IGFib3V0IHdoYXQgZXh0ZW50IHRoZSBkb2N1
bWVudGVkICJsb25nIHN5c2NhbGwobnVtYmVyLCAuLi4pIiBpcyB2YWxpZCBpbg0KPiBmYWN0LCBh
cyBJIGRvdWJ0IGl0J3MgcmVhbGx5IGltcGxlbWVudGVkIGFueXdoZXJlIGFzIGEgZ2VuZXJpYyBm
dW5jdGlvbg0KPiB0YWtpbmcgdGhlIG1heGltdW0gYW1vdW50IG9mIGFyZ3MuDQo+IA0KPiBUaHVz
IEkgdGhpbmsgdGhhdCB0aGUgZ3VhcmQgaXMgaW5kZWVkIHRoZSBvbmx5IG9wdGlvbiB0byByZWNv
bmNpbGlhdGUgdGhlc2UNCj4gdHdvIGluY29tcGF0aWJsZSBhcHByb2FjaGVzLiBCeSB0aGUgd2F5
IEkgdGhpbmsgaXQgY291bGQgYmUgbW9yZSBmdXR1cmUtDQo+IHByb29mIHRvIGRvIHRoZSBndWFy
ZCBvbiB0aGUgc3lzY2FsbCBtYWNybyBkZWZpbml0aW9uIGl0c2VsZiAod2hpY2ggd291bGQNCj4g
dGh1cyBhbHNvIHJlc2lzdCBpdCBiZWluZyBwYXNzZWQgYnkgIi1Ec3lzY2FsbCh4KT0oLi4uKSIg
b3IgYW55IG90aGVyIGZvcm06DQo+IA0KPiDCoCArI2lmbmRlZiBzeXNjYWxsDQo+IMKgwqAgbG9u
ZyBzeXNjYWxsKGxvbmcgbnVtYmVyLCAuLi4pOw0KPiDCoCArI2VuZGlmDQoNCkkgaGFkIHRoYXQs
IGJ1dCB0aGVuIFRob21hcyBzdWdnZXN0ZWQgdGhlIE5PTElCQyBjaGVjayA6LSkNCg0KT3ZlcmFs
bCwgaXQgcHJvYmFibHkgZG9lcyBub3QgcmVhbGx5IG1hdHRlci4gVGhlIGRlY2xhcmF0aW9uIGlz
IHVzZWQNCndoZW4gdGhpcyBmaWxlIGlzIGluY2x1ZGVkIGZyb20ga2VybmVsIGNvZGUgdG8gYmUg
YWJsZSB0byBkbyBob3N0DQpzeXNjYWxscy4gVGhhdCBjYW4gYmUgdXNlZnVsLCBidXQgaW4gdGhh
dCBjYXNlIHdlIHdpbGwgbm90IGJlIGFibGUgdG8NCnVzZSBub2xpYmMgaW5jbHVkZXMgYW5kIG1h
Y3JvcyBhbnl3YXkuIElmIFVNTCBzdG9wcyBsaW5raW5nIGFnYWluc3QNCmxpYmMgd2UnbGwgbmVl
ZCBhbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiwgbGlrZWx5IGJ5IGFkZGluZyBhIHNpbXBsZQ0Kb3Nf
c3lzY2FsbCB3cmFwcGVyIGFuZCB1c2luZyB0aGF0IGluc3RlYWQuDQoNCkNvbnNpZGVyaW5nIHRo
YXQsIEkgdGhpbmsgSSdsbCBjaGFuZ2UgaXQgdG8gIiNpZmRlZiBfX0tFUk5FTF9fIi4NCg0KQmVu
amFtaW4NCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2Ft
cGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55DQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAs
IHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBTZWFuIEZlbm5lbGx5LCBKZWZmcmV5
IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNpbHZhDQpDaGFpcnBlcnNvbiBvZiB0aGUgU3Vw
ZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gNCkNv
bW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


