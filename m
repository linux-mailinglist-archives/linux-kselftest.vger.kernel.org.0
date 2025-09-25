Return-Path: <linux-kselftest+bounces-42270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A9B9D71E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 07:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2D7A45AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 05:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183872E7F03;
	Thu, 25 Sep 2025 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cx8j1wcx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oMDugsAc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433182BB13;
	Thu, 25 Sep 2025 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777556; cv=fail; b=FrGVf3Wv/gRqNFHVAnoMIMnYoXPrvPj4+YcjDhJYXs5aKyO/e4ZIKgpYOs2zBYXfIS+6AADe1bvVeIgeiuWN3wSnT2PcUktY23oVLTlK7NHPUaarlcYEuRgE3OqGmYMmGfVr8l1LrY4fHEIbcnTU51Z92c/CNamPAJImFZlj1Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777556; c=relaxed/simple;
	bh=bswvTZ5rK25imOax0hH80HE5xl5y2TBdfigd+YbpSXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/iJbefni5PZ12spJ5R4QORtOEd2eYaGG5eKwrYPl7D01m+dqtq48OSVhsdSs8nbUR+BPW+IjYmnT2emtrcYy9rBfnwxRXcDZ6lmJ/11bUE5PTI5/ivXFQ6F0ENnEoxSSO+JPnczhvu29p9KWIx0rZ55ZnauaNbHQJz9Xy3YR84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cx8j1wcx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oMDugsAc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758777554; x=1790313554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bswvTZ5rK25imOax0hH80HE5xl5y2TBdfigd+YbpSXo=;
  b=Cx8j1wcxj9vbmyBxsSIPoMnLKm+6UOJBhbAjGe7M1NGauur+U40DHKJE
   65rdlaDiXtQ+NEfcwKHC7wwVukIIWpg0B3XQV9XQZe2iMVul0bkNbZAjc
   yIUP7DnLgh4DVHzoExrUlhQ/Ggkc70u1sDBztQHpHIDkmbKHfeYqIXkvh
   CGr5OvejWDIOGFXSFCpX7XONvotJSTjiYkHJjORGCS9fMV8saE1UIFVxi
   ly4+TU8PuirFcwipHLO7b550VXgRR5mBZU75P2/7airo544pY/DvdYjkL
   Qk9gHgQCbUXoD8HDTNBNZmvPgVqj0oIYJ/Wn1/M3/6mPQvZsDVjS/KV8B
   A==;
X-CSE-ConnectionGUID: IvpSadyNQMCfnqLcUeRiaQ==
X-CSE-MsgGUID: w/S2X12AQqOlNDRCWlV1HQ==
X-IronPort-AV: E=Sophos;i="6.18,291,1751212800"; 
   d="scan'208";a="129873068"
Received: from mail-westus3azon11011046.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.46])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 13:19:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/oPkTSP/7KDQGljIUrcjTcv14+BUCgXGsZNRXwS2YpzKoQytciS3lVMYIa5OUl5Q6M1Mjav8xY0ZVUuiEJlNCvQJvCj1VWXF0B9YnIRMsqbFLdXg3VQXHs71QzsX/zG632gVvjd5KXnPvuPi1AkB3oa1aRZj688Q3BK6fV4ba8cTd07SZvHeZJ+uIfORRa8qVyAxQ07wDgueG5OWFI0TpkPg2ur2elftBmBJV/3YqXaWoYM/51UWX+B7nW9rBVXfv5jwUToWUPXrN4N08asauc2+oUchPpnccAf2th4/AvAuACTq05mvD/2eIAUeEBIMGe9mS+7dlZNW6KpveVIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bswvTZ5rK25imOax0hH80HE5xl5y2TBdfigd+YbpSXo=;
 b=GAYUzpJYySFmAHBfQtFByFxKewNQtRc0e6Ra6z8ztvOvViXVtXDB2occwy/pYCHFm/rhdvNvspKWYpfDcLNgd0pm7YhNIbmRww8NTtmm42WE+8Bpd9+YqhCd+gKb9Ts5eGlyK9dAmKlI4O/uY/aMURSjvIWLMoXggSBZJQH7kWbRyX8GjRynTggIzZksdBEC+Q71Pd+0dHcpdT7P4huIVStpf+dDxYw2rX3UuC3iXOOOlYbfVUf/0Au1o+CM1pxoFB8Iqs4Fwl/8zPoc5LegMGN1iVCMfLxnobuKaR4R2u+Ovgvbj7ZJG+TzVcZyCf/GZQ3QaOrvqG9F/snPnjoZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bswvTZ5rK25imOax0hH80HE5xl5y2TBdfigd+YbpSXo=;
 b=oMDugsAccDuqZ6X20LGv8+KuEDOdZborDW3oI3z2Utj/rONUzf6EzuwgSIs1G9RpomEuKhL2KuHSzuBEchyXo8FC9O2cl3CaZrV1zT8NWr2gKv4ha+dpWVSK6ViTqZP/bYFHS4RmBSUFQKfgH+5Kh9rzSc6xVaDMrBQhBHvR2Yw=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY1PR04MB8653.namprd04.prod.outlook.com (2603:10b6:a03:525::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 05:19:10 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Thu, 25 Sep 2025
 05:19:10 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Thread-Topic: [PATCH v4 1/2] net/tls: support maximum record size limit
Thread-Index: AQHcLEtzQYYhasLEz0mdPGnzGKCvLLSikbQAgADNjIA=
Date: Thu, 25 Sep 2025 05:19:10 +0000
Message-ID: <98d2016e285b11e0a08d599362e2e2f608ffba66.camel@wdc.com>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
	 <20250924170328.GR836419@horms.kernel.org>
In-Reply-To: <20250924170328.GR836419@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY1PR04MB8653:EE_
x-ms-office365-filtering-correlation-id: e9df1767-02fb-4ccb-c8dc-08ddfbf30f18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkdoRXE4a2hKdStrYTFXejY5OUw0b3c3NXF4dmx1Y3JoR2dFaDF3TGtFVUdp?=
 =?utf-8?B?QkZtZ2kxTnI4YWJlekVYcmRpSFNNMUdHZ0RWZDRxN2d2aXVqUDFqREZBY1VK?=
 =?utf-8?B?NitrNXM3QktrbEw5cXdQaERObS9WZ2NNbmNyd3E5dU1rbDlVdUhPb3lnWFUv?=
 =?utf-8?B?ODRLdTRucmxIeVNLMlVQbXNuZmNHSUVpcTJ1NnVYU0tLcUFSREhMRktxd0o2?=
 =?utf-8?B?c3RVck1YMFVmSk91M3Fmamt2S2VPdEdJbXl4S0thQllXSWw3bVYrQ1hrNDBt?=
 =?utf-8?B?NHJyMjdwWGlXYSthWjhTMGRoUFkxTS8zczBuOXAvZWlqYkVNdnNGQTkwOFh4?=
 =?utf-8?B?ZTJObWVzSTEybGtDZkhrWk5jUUllcW9qKzMrMUdqWFNJVzg3V2docGNSZXJQ?=
 =?utf-8?B?YmV0MFg2eHQyQzQ1WlhUb3gxZ0VBV0F6V2h2UjRjZkwzYzlOeE1obUYrbHIz?=
 =?utf-8?B?SGd6SDc3SDhJMkVZLzJnMGYyYmFva0tmWW5VYUJMdFdZWnJscjgxK1lGWUht?=
 =?utf-8?B?ampLVmtlMXp0Tkw3NlZFWm15Sm1CYzcwanNQNjBTWENsdGZUSlI3aEVVcC9x?=
 =?utf-8?B?V0tSUERUUnV2UzJCWTJaZ0lzSUhISGpEL0pjdDNZVXp1ckJjWEY5SkE5YXR1?=
 =?utf-8?B?RU9mUUxmSDhuOUZyYUIzeVlhK1FGbVBnSGIrdUJjVk1iYWdEbS9OelEvNkNW?=
 =?utf-8?B?aFMvUjAzUm0xRmZ5aXNXUklFbkxjbURoRzlRT3hFMGp5TkJYeGpqV0RxRzRJ?=
 =?utf-8?B?N3BuQVBndjNJTGROb1YrL0M4VHVST0VCMXoxVGNpM1ZzMEU2V2NRWUwydllJ?=
 =?utf-8?B?UjVDRTJrS0dVd1JEbjNFVWxhTjlzMkI4UERLWkJaTm1XVjZxWlB4ZDY1UFVT?=
 =?utf-8?B?Q3FQc1ViSTB5dEpkakhnMFlUeDExdExmVVBoSzdhbUJMMzJBR05FTVN4UERC?=
 =?utf-8?B?M1NrTzFUZm5JMXdNSkdtMFprUmdNMlk0OTFUT0dYeWZNWG5Vclc2cllaY1hp?=
 =?utf-8?B?RXVmZ2FNZDBOZGFuZ0lEYWVpWFZtWFNDaE8vMzU0NThDMmFCNTFUZDJSekFC?=
 =?utf-8?B?ZU1aMEVuMTNtSFNieUVndW16eTVSdUF5QkZWeXZKREVlUzlKMFVOMFdRUms5?=
 =?utf-8?B?dHhCRDFZZFlTRlBnQ3M5blYyMkxhSzVlSWFEcnEyWVl4dzdFb2p2azU0MU91?=
 =?utf-8?B?ZlJWaUhKUGU2a3NNVXFLTEc5S1BOYnUrUjJualovajZCMDQrWlIxaEFuZ3lx?=
 =?utf-8?B?bStDQTRTd3hXNDRCeW1IaWVKOE8rYTN3dzIxMEdSMG4vWklqWU1WK1lqek9X?=
 =?utf-8?B?eExIelZmMlUyVzYzcW05SUFodFRNYWVlaWJzTHZOd1Rjb055NllpTXh2cWc5?=
 =?utf-8?B?c2ZVRXRDak1RVVVVcTRSNTREWnE0cURKN08zbG9MZTZ2SVp4Z3d2bS9XK00w?=
 =?utf-8?B?Ymw3NGM2R1hTM09lOU1wNmxXZTVaZkNyQmNZbEU3VFVuOU16VGR1Ni81WUNH?=
 =?utf-8?B?U3daakd6TlBzbE55ZnlSY0NXTHV3LzZkTXZuVGxxbVg1N0JwdngvcjBuQzRT?=
 =?utf-8?B?ZUlQd2dpaWNVcnlxbG5rZTlZeWFpbk5vb0RNM0MrVlVUcExyT3FXTHkwaDNK?=
 =?utf-8?B?amY2dDZGYUI2dE4wSWMwNmZwdWl1MjZQWHM4WmwrMDRwSnJiSjl1Wlh2Z2Zk?=
 =?utf-8?B?c0QyOE5VWXE2K09YSGdMT0NXWFZSMklTLzl6RkV2Wk9aSnZVdnIvVjJYbXIz?=
 =?utf-8?B?K1BQSGhZRXpYS0NXVDNoVDRXZWpadmMxK1lCUmswK014YjF3ZHVJZ2NoSld5?=
 =?utf-8?B?aVMyaXNXKzJtRXgvT2VpbkI0c2NweTl3OHlJbzU2ZHhZUW5jUys1c1VNeWVl?=
 =?utf-8?B?NDhMY0lmTGhRTHNFVElQeVluUGhnUjZUSEo2YUtSMTh4RHZINEREL3BxbVlN?=
 =?utf-8?Q?XBZ0GX095uE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUk4K1JpcnE5OTVCSzh3TG9qVHNaejFMU0JwM0Q3M3QxcGQ4V3lPUkpudUFh?=
 =?utf-8?B?anVETE41QnFXSDU3bk9VQ0JjT2VsZzQxZkJTU1kvbDZxTk1heWowQzNtNFRp?=
 =?utf-8?B?T2VTemtDa0ZlTFI2NFFmNHlqOHFnMDhmQkRmR3FwZk12ZlFlQkRLZ1hiSjR1?=
 =?utf-8?B?M2VzRTNBOTYzN2t1emRLek45eXlWbFNhWTRacVI2ci9jMUVKelVtdWxOL2RG?=
 =?utf-8?B?Y01ZdVo4VDQ3V1dsVjFZWXdQUkZQb3JNOXFTVDBKL0V2SmkyTE1UT1p2VFFi?=
 =?utf-8?B?NmR3TWt5OGRkeUxJWWRXNzVTSENpZHh5bTUrQWtjNUtmUC9ZVlhreDdkbzJR?=
 =?utf-8?B?RU9JcU1hdzJhWkZRWjRiM3FxQWVXTWNpU3QrRVlWaFRMS0txNlZYcGhoTkFY?=
 =?utf-8?B?YWRjWEFGVGZEUmVVcTVrQjN1Wi9iUnAra1RJTURyZ2I2SWFJMTJiMUxXb2Nk?=
 =?utf-8?B?LytXYWMvV0dSbGw0dkprSmczWjFBZ0NSNVdIenU4ZXhXZTJaWG0rZHhDRDVh?=
 =?utf-8?B?ZWR4cytiaStjaFU2cEZFbGIremtYb1ZaTkJxQWIrK01jMU5WaGQzTk03c242?=
 =?utf-8?B?eGtiZUZGVy9sSGlOL1JEdGRvYTlYbVVpZ0NmWGRmdUxuSmxWOHhPTWhyWXRT?=
 =?utf-8?B?bjJVUndiTkNJZmVYMWV4MDc1VXZZdGtiS1dzSEF3RGhkcE8xR3ZYWFBLVUcx?=
 =?utf-8?B?V2dpaVFRbTJocU9kMkt2UTRKTEpPSlQ3dUtDSjNuZWxHZmgwS09zZ21LZkxF?=
 =?utf-8?B?OHZLMUVkMldDcVNMSDZpMGgxQlgwRlNVL0I0REQzY1J2dzJsaFlYeVN1U2Jv?=
 =?utf-8?B?bGl1QTZDU0NiSjBXM3I1TnFPVEkyS09ZMFlXOFhXMjMwSWc1UFFCR0dlUXhp?=
 =?utf-8?B?eFkzczh4OTNmT0pUQXdJT1oxNisxQndpamVWL3JoV0VRVlU5dS9VSzFCOVRi?=
 =?utf-8?B?MlZ5TFYySzlOU1lTQklqUlZhSnpUK00zeEp5RHQxRjd4MzdNRHdxd1ZxVDJz?=
 =?utf-8?B?U01Xd1VqcnBYQWQzQzk4YXU1dzIzRkVrRzNseTY4ZFBlam1xOVk1OUdITFI0?=
 =?utf-8?B?S2ZhOUxIQ3c0WWhtVW85MXh0d1c0RkJnOEdxYWs0dHV0aEowYUlNQVJ6Q0Mx?=
 =?utf-8?B?NnhSODg5U0NiV1lwbituMVdpUGVhR2hIWWVhb3JLbEU4N0NuMHA4U2QxVEhs?=
 =?utf-8?B?eE43V0dKeXM3ajFIRHBycGdJMFMvdlJzQ202Q1dIeDR0QVdFcnhNOVNSbG5x?=
 =?utf-8?B?WW9teEV2NzBIVmdWMWI5cUNDWWFVZXZmNzhSNXhtQ2RleEUxVVRHUjFFd0RF?=
 =?utf-8?B?SWhSS1ZIaVRrbGk1MXFNMUNTNnEvc1pqWEpWUHphUUpCVkFNaGJ1elMyem5j?=
 =?utf-8?B?d0ZhQW52c2M5MXlmbHBOS0xwRWtIZlhJdVJpVS83aG9QMEg2VHU3ckxzM0hl?=
 =?utf-8?B?OWwvL1FmeU1kMG11VEM1UG9uZkhKcE9FMm5UUTFBZ3pBQndramtwTC9WU0JS?=
 =?utf-8?B?OHBIQVlvd0tEVUxFa3NIeFlpdHZXaUdVL0FlVDdJaDBxc3NKREZ0ZTdFRXl5?=
 =?utf-8?B?Y0VJbWE0WFc5YXFYUEhJYU5LbjFQSG9iUTQrZ2dEdXNCajJVZEpiSFFtMnlU?=
 =?utf-8?B?UlBYbXl2dEx6aWdTWk5KUTJnbDlnbWd5ek9sMlFKRVpTWU5ZcnBDUUIzNGUr?=
 =?utf-8?B?MUNwTFFjZzdrS1NaWlVRSTd5TFB3UFpLTTJPYUZUUjl3aUozYU9INGtlQlpX?=
 =?utf-8?B?YW4yZ0JvdmFBWjZNT3NjWFp3WGdNSVJsVERMcWlCUzJwejlKN2ZoMDBwTGU1?=
 =?utf-8?B?Qm92NS9SNWk2U3BPNGxUNHZVV1hQQ25hUG42YlB1RFhBS1RZRzZYNFlZeWow?=
 =?utf-8?B?aldKZkpFZDQwK2xYZ29mNHZaVGxYOG82dHV5WlJUVkQwamZaQ2xjaEJySEF1?=
 =?utf-8?B?d3RHSFdRQ2UzY1ducng5K28rYkQrMk11MVVEZ1RRQXR3eDBFMENaTlBVQXhm?=
 =?utf-8?B?aUhPMi9MdlNVRHZtQkpxYzBSQjU1Wnc1enZrdDg5dTRvUE9wYVZBNXJZbURI?=
 =?utf-8?B?bC9odE9YcE9nMUFyQXlrVUN6dXdYMjJwQUoxNXo2Nm9YaG42N051ejZxd2Uw?=
 =?utf-8?B?cVRrbWVlOGhkSEV4NWdRdXg4bkl1MUZUc28wcjllRU5RTEo1TVZwUjN0UHVF?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <283416B88939AC429B0B8AE998A560D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ax2seToTYI/UVWBfi09vKW6qcg287n6RrBPvV/SUxb1Smtis9yRmuEw/Oj1yRH4N4wisJN0H/XBhydjXa8WFt5XW9auLv352M0rnJfOxXlJqRFR/zfMpxVl7NBlxy4YOrJHYM1Q/14FbJWm993KyEP5K7JQGCi09Czj/pizpSXF8brlL9Pd+tW4TDOFf4Z8Ng2oJvsu/WJyg59YGLAKK3VBxIoEtss1tXrRKWd1um3aQAI+9Jmj9ZnF3IGDXO5a9yxPUEbPAPbyxmpXTTyVg6sjWwQAcaBrw6f32bu8K96832Dyb+Zkg3y6sQyNHBCsM++L0GNaaYIPpfMoQCQeND5RUN8cfJ019KSpj53k5mqM5faaSDQEuJzv8yjCUDGhfRy/bM0BEaa0G1m4auI0xsj8zy4TIxG/JAHyA8otlBo6sEHiXh6PR49D8T5B7RiHlaKd/HqAVHh/YDFYKIcrAmyWtQaOwaLEDrk5hs3qoib38YlGOGpSZPHKsTGgCd8QiwSqXaqeDyesr5oysXmcFo9Ck7hYSkEVkcQ41qxjJa1prwgHmYMt+QFke+Oqn1tfeJN7BGWliIGZuzxOn73lSt3XhnSsCBI6ABBl//VuuuHmNVp+y5yVf2CXOLFnAZ/FY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9df1767-02fb-4ccb-c8dc-08ddfbf30f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 05:19:10.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfIXv5+gko6DTmYbYAHVEKnE90bFcSK3VRuTZXFDTTF76Bq8SXE4VaYshfjd32tVE4Fchi3ymklMApAORxSZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8653

T24gV2VkLCAyMDI1LTA5LTI0IGF0IDE4OjAzICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IA0KWy4uLl0NCj4gSGkgV2lsZnJlZCwNCj4gDQo+IFVuZm9ydHVuYXRlbHkgdGhpcyBzZXJpZXMg
ZG9lc24ndCBhcHBseSBjbGVhbmx5IGFnYWluc3QgY3VycmVudCBuZXQtDQo+IG5leHQuDQo+IFNv
IHlvdSB3aWxsIG5lZWQgdG8gcmViYXNlIGFuZCByZXBvc3QgYWZ0ZXIgd2FpdGluZyBmb3Igc29t
ZSBtb3JlDQo+IG1lYW5pbmdmdWwgcmV2aWV3IGZyb20gb3RoZXJzLg0KPiANCj4gQWxzbywgcGxl
YXNlIGluY2x1ZGUgbmV0LW5leHQgaW4gdGhlIHN1YmplY3QsIGFzc3VtaW5nIHRoYXQgaXMgdGhl
DQo+IHRhcmdldA0KPiB0cmVlLg0KPiANCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHY1IDEv
Ml0gLi4uDQo+IA0KPiBTZWU6IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvbWFpbnRh
aW5lci1uZXRkZXYuaHRtbA0KPiANCkhleSBTaW1vbiwNCg0KSW5kZWVkLCBJIGluY29ycmVjdGx5
IGRpZCBub3QgYmFzZSB0aGlzIG9uIFsxXSwgd2lsbCBmaXh1cCBmb3IgVjUuDQpUaGFua3MhDQoN
ClsxXQ0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0
ZGV2L25ldC1uZXh0LmdpdC8NCg0KUmVnYXJkcywNCldpbGZyZWQNCj4gVGhhbmtzIQ0KPiANCj4g
Li4uDQo=

