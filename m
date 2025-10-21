Return-Path: <linux-kselftest+bounces-43692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B1BF937A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6414E2A2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04D26B75B;
	Tue, 21 Oct 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XDvShKWa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x9SyeVR5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AD1607A4;
	Tue, 21 Oct 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089002; cv=fail; b=F63jl2NDpVylXu3U0xXX53oBeBRNIU3D79n6oPy/sG3piYw9H+eA/WDd+XO83y+HwVUAC48ykJfEKCXHg5UCQaMP/DfvaUWj1lQewCgYlfws8pRgU0bp3O0Od4mbxmA6sHs7tPxXq3/A6siByZHQGuBzJol+yZFmRNvbBNoTCGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089002; c=relaxed/simple;
	bh=mUtXdHc60rY2iAat4Gw8GMglumyeU7YdbdIfOZayBAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iskOsAu7MhOqS09ohcer84Ivl/hGuqCnyC/6bX/sY9Gc+jCyAcPC76rvXmqTGbFT96aY6ZgxQKoS3rNs1XAdMMyNbUus/Fu+djaQlP5jwlqs9EGj5/yrKg/nPwJtvRlx0DYobgUwJxGY8biI9iOgSQLdNbOmvfKC5n7LDtSMr/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XDvShKWa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=x9SyeVR5; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761088998; x=1792624998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mUtXdHc60rY2iAat4Gw8GMglumyeU7YdbdIfOZayBAU=;
  b=XDvShKWaXC1Yuofv7jbBUKsOA2tPebe6Wk/5Sm54KA3mMpfS9A9Cup4M
   r1rm3iZwblPC/HlTCySc1ZP6B42ENvTDUF0JGx0Jdr+6ofNCUbjEbWSXI
   k3r6CFPWnTD2DsUfQoEZnOJrdYYKHzk5BwKojGaWIp0JsjfY+BqBMRaWl
   BQbjgrmx3fNlOqNpFInP2JyjRi0PWtSMlj+n5/pc1ivni3ISqicTqt3Ms
   h6FRs65S7tBauUkVJ79/EgcLsILzxr62u3vVoBdyPeOByZkCXZ8IWvem1
   Tunm/zkHACNG0pOEDBdFO3YC/VH2UY56P4kcT+eMgN1ivWNWahSzwaY2F
   Q==;
X-CSE-ConnectionGUID: nCdntehYTR6SgOLZIzryFA==
X-CSE-MsgGUID: XSRTSxaXQkmNTAOFshSjQg==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="134612825"
Received: from mail-westus2azon11010047.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.47])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 07:23:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GywUm7aNQpmWf/aoxc27sp9FFIfSTt0ajlfDU6xdVBLLZ4HHYs8sNu5TLykquzHFZoWrBpo20UoY5zM5Bx5MZWHfycf3WWFBmLsvHK+ACXqML5uCQY/peoM0d03z7ajr511J+JTR4/psHE0NyvcDf+R+H1WsMxVjn0JWtnHThIY632PM3tzhRERVQqXtOdeZopCQau1H0j5l+Xwuj4yQkZHtogYbZiOy/twHOohkRBb144kcRu9WUk+v26dJGlpi/bMAb/Ml6k0aS3LccySD7a+H+bMGXwLWaQbjZMf32WbBBHL5Cvi7lyXShsiIsktJlUTVy2+4bv6jk2Ti7y9X4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUtXdHc60rY2iAat4Gw8GMglumyeU7YdbdIfOZayBAU=;
 b=IlorurCsuQh253C5y3qXIr/VRt0SRr/5cbNmQXHuCkTQq9ESzvtXSrBkMqUpqSd0IHlWGcegk1WLCCukbZ/FO0Y3RLMLIFOk//iqr+5S/1IRYy7Jo4yPWt2S+YRP6OeIW6kzUNHq/QP05khywnhuxQ7btYJTuM90Q+BvRerFVTZH6LHBHPamZoJ3+Vkt40hNH+JfsnQNzL5QF8QJ/DgcUxwejScGJp3vMLN2ilzZV5amZQiyVUCQo623UFbjlTdBxG5PC2U4geOOhl5CdPIZxJxNdP92rjKIn5n2XzkvXQVP3/gygHN7diQ4EP4tkE9pxjGK9zWuyovjPnk3S36Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUtXdHc60rY2iAat4Gw8GMglumyeU7YdbdIfOZayBAU=;
 b=x9SyeVR5nal8GUCZcwF+oVpgWUcdG/OyQCao9CQLWPaHLAGRE1LCeqezO/SawgYRMFhtM+mEroWkBL6D0IxUiohzyQhw/GBCTp7gUOaJZKZ584PHWW8j6Y+YDoe8XHEwDTeMdfETFnE58Bhxl1A01AE3S4epXI7Qw8WmwZtaRlQ=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by DM6PR04MB6809.namprd04.prod.outlook.com (2603:10b6:5:22a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 23:23:12 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 23:23:12 +0000
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
Subject: Re: [PATCH net-next v7 1/2] net/tls: support setting the maximum
 payload size
Thread-Topic: [PATCH net-next v7 1/2] net/tls: support setting the maximum
 payload size
Thread-Index: AQHcQm09hSB2PUoACUCx+NrQR0/i37TMeNsAgADFngA=
Date: Tue, 21 Oct 2025 23:23:11 +0000
Message-ID: <018f3da122b80b7f1ba28bfd4b813eb8879fce19.camel@wdc.com>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
	 <aPdwGJGUxhqiocBX@horms.kernel.org>
In-Reply-To: <aPdwGJGUxhqiocBX@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|DM6PR04MB6809:EE_
x-ms-office365-filtering-correlation-id: 2c42194e-bff5-4f02-5c31-08de10f8cda0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2lHNDFSei8weXpHWDRIeGpCTVVHQ2RkS3A0VFZwQnN3dTFYUGgrUUhXb0g0?=
 =?utf-8?B?TDJCb3ppalI2UjVuZDg3d1Z3b2wwT1N0dFA2enVxNHhDQnlvUzZNRlNZV0R5?=
 =?utf-8?B?YitTaDFOc3VHOUdoUkplV2tVVDNib2kvcldIVzFiUzgrSk9xSFV3Z2h2QXBy?=
 =?utf-8?B?SlVybEE0YUkzdGQ0bUh2WDljZkR5eVFaWGV0KzJzQ250ckFwN1RjZVMzeXp0?=
 =?utf-8?B?TnphVGhjdnZQUkhMTEppUU9IaFE3N3pZa1J1aVFLNENUT3dqUFYrcDRyNWl0?=
 =?utf-8?B?ckZDRDN6TFBFcHZMVSsvMlp2MnlGRlpjajI2ZFdMY2NXTmFxM2YxTlNRRGZR?=
 =?utf-8?B?dnVVQWtwT2VocFBoQmVNVnFOdXQvN013SWd4QXRwdGNjUHVkdjJDWDNXSCto?=
 =?utf-8?B?T2F1YitBVS94OCtLQkpVSEx5NHllamJIMllrMUtQNnY2MGpld2xVaW5wMXFC?=
 =?utf-8?B?SnF3bVdyaW4xNUtTQ1pCZ1ZHQUdXMUVtN0hJUDVBN0ZUeXdMTDZpWUJzVzcy?=
 =?utf-8?B?eitSUlFYZHBaSytnQ3dpTHcwOWFRbkJYMzRPak9YWGRBMWVXaHQ0WUtyb0Z6?=
 =?utf-8?B?QWRIY0ZoVnBTRXFnZHlEQ3JVNG9ETjdMOUZhcm15YWpXdzFzdFoyNVEwZzZa?=
 =?utf-8?B?bEx6WEFCWnkraTVTeGppRkl6R2grdjBBRVFDTnV1eGNiakt2MmVnSmRXVWtT?=
 =?utf-8?B?ckVmdlphSHBGN2VVRSttTldhZnUwNWNuZ01YSGZZbkNkMkRBMXVVZUsvNjBQ?=
 =?utf-8?B?RFo0d1hLVkNDaHJlNW1hNllNMUFrYzcvVFl5blRPaEV1eUd6d010aGovR0Uw?=
 =?utf-8?B?dlhPbUkzeEhQTlhuNFR4M29mN3dwVWlVRXRUOFlQSWpkVU9QTHljeHdpd2NY?=
 =?utf-8?B?RVVYT1NZbzB3T0g1S1NsMWJNbFFsVGdIOGZtOWFMaUxqd3A0SkxlTzRSWjQ3?=
 =?utf-8?B?dlR2Y1JXN1NQK1BRdzFqT2FrV2hJbzJKN2JVbW1YZW9qTFFLR1VHRGdrUWtt?=
 =?utf-8?B?OGR4TkNkQnd5cGVOQjRzQ002aGh6blFKbGlnOFRsaXp5SVk2VUIrMHhzM1Ez?=
 =?utf-8?B?ZnNQVXozQXRhcEYrT2p1dXduWjZKRHkyQUZLNWFtU3ZlQ0tMc0Z2Vi9UT2ta?=
 =?utf-8?B?RGFTSGp4dHBJbE5RQkg4YmhmaW9oaWVYd0QxMDJlMlFZZmFjS1RJZkM2ZjYr?=
 =?utf-8?B?bDkrZW1EbStLUGcxcWU4Qno5VmhLS1FZaFp6aHZxWi9JSVM5UURYUHkyd3Nm?=
 =?utf-8?B?VlhZZkplaytPYXV0czU1ZzNjNUNKZzBJM0VvWXFuME01MGgrZFhPL3J2enhi?=
 =?utf-8?B?SUtJU2Y2bUR1UDdFajF2WkJ4emJRNzlQS2hTOFVxSEk3Q2JWYU1SS2RKdmVX?=
 =?utf-8?B?RVE0blNIUTJxN1ljSnhvNUtWaisxVU5OL3hXaW80MFdEaDJKU0ZBY2xFRGQ5?=
 =?utf-8?B?VFJsV2ZQdzFaTjJqM3llVi9lL1pnUkdGZWl6eE5IM2xrK01HQzBKMU1naUp0?=
 =?utf-8?B?RWxyZ3RyZm1vUldjSVcreEVpQ1M0RlRXd3JRSDFIcVNIZkNnOXZ2SjN5WFk0?=
 =?utf-8?B?ZTRic2poRnZOL1RZdUpzRlN3NWhtbzd4a2c2TE1mcWpUa2YvL2tYNGxQbVQy?=
 =?utf-8?B?SVRja2w1eWVKYjJ3QlYxb0tNVHFJY3lMR0NYSW1YUG4zZHBxRVF2NldvWG5q?=
 =?utf-8?B?SXZaZmpOODRCdEVXMTZDV0FzZk5BY0owSlJkRkFXNjlZTTRWazNIeFVqazFE?=
 =?utf-8?B?cHJTMEFkbzlwRDJ3TzdqUzFUKy8xNjY0b0pOY3A1aTk0b2pwR2tGT0duTzhG?=
 =?utf-8?B?WEhNSks1emh3Y3l3c0tFc1QvMGZBdW5OM2RHcnlITExjMTVvVGphS2Y5L1Fq?=
 =?utf-8?B?Z2c1SENtK1RvZnMzYVJOZnoyZ2NPVW1EajdtRy9ZN0RVemxHbUFSdzdEZ0hM?=
 =?utf-8?B?eEJkVlhkRGFnYTd5ZktXekV0dWpCdXd6ZnRZdFMwQUFCOWpUM1E5SDJqUzlB?=
 =?utf-8?B?R2FsNEkydUhhdWlFNld2VThjRFZzMWdSZUFDVlVxQU14NUMvaEE0RFl4Qm8v?=
 =?utf-8?Q?9+2dly?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3pyTVdjaXd4cm9pMityQXRaM25DVUVqRnNwQ0RTeWZzZlRrRUFsWHYxVmxO?=
 =?utf-8?B?Ymgrakh5ZnBKSU1rMHVFQm5IRzJ3SmZ2VTRha3ZKS3hwZTRjMEpvOHUxYkhv?=
 =?utf-8?B?VC9DYzBmSG5aWklzUFpLS1NDU0xITzVvNnJIcnJuTDlqTDFzUi9uNk5XeUd6?=
 =?utf-8?B?ZVZrbGNJNk5sZ0MwdlBjSjkwemtvRm81andMRVhzUzhoaWtaLzJMZzhYcHp1?=
 =?utf-8?B?cWE1V1NRZVIwbnRnRDQzc3ZSSDc1YnZJMkhDUzNiVWJwK0F4UDBpSCtOR0tR?=
 =?utf-8?B?QnlMMUNkNi9BSkpXeVdHUkxacWdnMnpsOE10WWNqdzN3eGlHZzUyVitBckxB?=
 =?utf-8?B?QldBSHptbjM1YWgwZTF0OExDMTJiMEVvanc5Y3JmMVpnN1Y1U0xFTlc4dFdj?=
 =?utf-8?B?YVV6TG02UGdIQ3M3Vi9OR0tnOCtUR1c5bkZCNHRMQ2R3aDZvbVR0bkM2cWw5?=
 =?utf-8?B?bUNPZDU0eVhtOWFHTGlLelhZeFBzTkVOWHNkWm1PZGRBcjdsdGg1c01GZlN6?=
 =?utf-8?B?U2dqOWFnelZlL29QL0NZckoreEpZQUpsc3JyTlNtUGEwdmsrTkliY2E3eVZ4?=
 =?utf-8?B?aUd0dGJ3RUJsdVFYMmZNaHhEdzZ3Y0dTbWhRRVZaanJiNEs1VFhJZ2c3VWhO?=
 =?utf-8?B?NVVHeXZPa2o5NUlhSXE0THR4d0JtSXdaYzJXdUx4eWdPSC9WWGlnVlZ3U2tS?=
 =?utf-8?B?d1ZhTFdxOFR2NEVkOFZTdWNpYUZldGdwVWc1QTNEN09WMTBXYnRka0JMaUM1?=
 =?utf-8?B?eXZyam41L1VNMmZXcnV3VFBlMFlPdXRtNGMzS0t2em1lSTdvWkU4bFgxUURL?=
 =?utf-8?B?QlBwTkxoQS8yb1NESC9xNzdDbE1mSkNXNlVBSTk5dmFXWVd0L21OZDk5UWJz?=
 =?utf-8?B?a3FiNTRIbkRQUEphc3dOUTYrQmdBUGtpNGhZNUc3MkxqNTdWMWllNDRiSXls?=
 =?utf-8?B?b1BPaW1PSzFsNlVZYUQwdHNzeEEvd1ZjRitJMnd5ZUlsbGZ0WmtwOWU1ZStH?=
 =?utf-8?B?RUE4NU1zK0RiemJabGZlV09KaDJwVG5DL1Z6b0M0MEJIMFFXZVdJOWVCbHhJ?=
 =?utf-8?B?VW40ak9OL3dORFMrOU9xNzkwK2xaUjlmb2NsZDFEY0ZWYWFTU1pBdlhmNE5r?=
 =?utf-8?B?NkxjZnlTdWh1cjJwOUVRLzc1TDVhNTltMUVyaW91WUdJQjd4ZXg3SFN1azhu?=
 =?utf-8?B?MnRUT0V5QWhjSGNtenBzT0FIM3dCakNDZ2xncnZsN2NnZ2pHVVZwbm9YaEZ2?=
 =?utf-8?B?UkFhZDFQVVhhbDhPMmt6VFo4aVg1SCtzWHZXWGR2NW5EUFJLeEtMTmRzV013?=
 =?utf-8?B?RkdlSFhjTGVRcTFGU21IMkRKWDUwa2l1M2VEZ3FhenppaGZsVTMyZG83bXlV?=
 =?utf-8?B?YXBPRWpMY1NRYWZUUzc3VVppTStJcHhQdG1nemEzQ2F6ZzFlTUw4cnBZeUZ5?=
 =?utf-8?B?amh5aFdCM0N6L0lCbnB2dk5lbWtzQzNZemJ4dVRxcEl2bFZDWmhheVlPaXNv?=
 =?utf-8?B?T3dwQUxYUGd1YVp2WHdGVFFSdnM0aWhhb25qNlo1cG5qVzE2R3JWSVJuV3Bv?=
 =?utf-8?B?S3BOR2Q5dFlVanBjRlJvQURvTmJoMGNDcW1DeUlQb203N1FzWXE5MTFyQXBL?=
 =?utf-8?B?MURYVnVFeEEzL3ZLL0YxQlFkcGIrUzNQd2t5SnZPV2tRTnhVbWc5NTRPd2VX?=
 =?utf-8?B?eDEwVk5uQ3pEZjM2WjZMNDAzWkdVV2NpYlk1dThUNHdSOXFyWERLdHhVajZi?=
 =?utf-8?B?U21kZ3gzejBid2dzMndhVVpvNzZaYUhLUmFPSEVrQlpTdm00eUl6L1dxc3VP?=
 =?utf-8?B?L21Nd1NBOU9TdjhSb1FUbFJRZVk4OFpWMGcvSnNvY2N2NXlVdWR6SmN3cVRK?=
 =?utf-8?B?bUdBeWU3SlJ3cWRZSDNITm0rMjhOR3Zvekp4SWp2WHh5M1FBaEJOMVBtUEx4?=
 =?utf-8?B?Ym9XSnhjUnNidjEwTCtYMGUyT0NaWUIzMU9uUng0L2hKZkRZNWFLaDZsc292?=
 =?utf-8?B?SVNvODNQOURxTzRPbTFUSFdDYzJYc1J0eW1IaVpvWkgwM09vU3F3Qkl2aHhh?=
 =?utf-8?B?YmxESVEyMkwwMFNac2Z6cVREb1dFbVVDRW5DeFJwMzNUekM4SVNteW5SWVRN?=
 =?utf-8?B?a1ZUcHIzZzRSS01tdnlIbytMcmQrbXhJZ1p3QVM2cytIa1p3VENONjBsN1JK?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47897443E2177B498F95D12CF4D8C799@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qFVU+la45L7apj9cBJBee6RDu7J2p4X/JO4u2H9zTDcMsbDm4uAAVyppvy3u4fBEYbqjCCAWt7yPv1eiGvxc7cM9VjzEHSBKii+Rk+1u//25U0u4WFhybZ/DhyCe2dHX8bGWXrMY76bhPT1pC/C3YDggLac5LMJjOZwdXBMQDFpcAO1zZYgqsYSVZmHiaS4W+cr9MJOwMeuODS5b1BlBvWdb79P0GqD/7CIVK3pZ5VzBjm8hkP1J+ZRqCyJKCu8eYCQtClCPO2UN4Pc1wZLzvkBXXYi670Ru70KEEjW0ooZP3JpmtFBykFpXtt9hNUg2BQ4rkCejWG0rL0KApwaMdcxZtbZvHT7CNwCarHWVdSBdqHDPzwPw9anyyVRlzJIPm+BV03s9knSjP7hgX8DPH9oo4K2VYu+hrqkCIhXY2s+662oHkDaMBiJBKvFVGl4L0H8MuKX66UaF7WbbLqqKgGposTJ53ycazgZ8k43KMO3xSbbeWmKwWiD63hjdzqx5q8fu3aqabHD/SVg2EaE0iVg7M8Syw0aiFWOcu2A8A/pTHn1OPl3cuNh658XF2C0fXO1RzGX8sO3AomkN6/a2OK9C79OS1JZFFf61vsu9wpKdHhMzyfMVq07NPuzQdyUg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c42194e-bff5-4f02-5c31-08de10f8cda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 23:23:12.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nj0aqhT9UuERB8gNllQhfhr5DiXeVmbtxcR1D98hA0HPKav+nQWt1fXpYsoW0ueLn2SutsUN6PO1LXWv2cs69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6809

T24gVHVlLCAyMDI1LTEwLTIxIGF0IDEyOjM1ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFR1ZSwgT2N0IDIxLCAyMDI1IGF0IDA3OjI5OjE3UE0gKzEwMDAsIFdpbGZyZWQgTWFsbGF3
YSB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9u
ZXR3b3JraW5nL3Rscy5yc3QNCj4gPiBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy90bHMucnN0
DQo+ID4gaW5kZXggMzZjYzdhZmMyNTI3Li5lY2FhNzYzMWVjNDYgMTAwNjQ0DQo+ID4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3Rscy5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L25ldHdvcmtpbmcvdGxzLnJzdA0KPiA+IEBAIC0yODAsNiArMjgwLDI4IEBAIElmIHRoZSByZWNv
cmQgZGVjcnlwdGVkIHR1cm5zIG91dCB0byBoYWQgYmVlbg0KPiA+IHBhZGRlZCBvciBpcyBub3Qg
YSBkYXRhDQo+ID4gwqByZWNvcmQgaXQgd2lsbCBiZSBkZWNyeXB0ZWQgYWdhaW4gaW50byBhIGtl
cm5lbCBidWZmZXIgd2l0aG91dA0KPiA+IHplcm8gY29weS4NCj4gPiDCoFN1Y2ggZXZlbnRzIGFy
ZSBjb3VudGVkIGluIHRoZSBgYFRsc0RlY3J5cHRSZXRyeWBgIHN0YXRpc3RpYy4NCj4gPiDCoA0K
PiA+ICtUTFNfVFhfTUFYX1BBWUxPQURfTEVODQo+ID4gK35+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gPiArDQo+ID4gK1NwZWNpZmllcyB0aGUgbWF4aW11bSBzaXplIG9mIHRoZSBwbGFpbnRleHQg
cGF5bG9hZCBmb3INCj4gPiB0cmFuc21pdHRlZCBUTFMgcmVjb3Jkcy4NCj4gPiArDQo+ID4gK1do
ZW4gdGhpcyBvcHRpb24gaXMgc2V0LCB0aGUga2VybmVsIGVuZm9yY2VzIHRoZSBzcGVjaWZpZWQg
bGltaXQNCj4gPiBvbiBhbGwgb3V0Z29pbmcNCj4gPiArVExTIHJlY29yZHMuIE5vIHBsYWludGV4
dCBmcmFnbWVudCB3aWxsIGV4Y2VlZCB0aGlzIHNpemUuIFRoaXMNCj4gPiBvcHRpb24gY2FuIGJl
IHVzZWQNCj4gPiArdG8gaW1wbGVtZW50IHRoZSBUTFMgUmVjb3JkIFNpemUgTGltaXQgZXh0ZW5z
aW9uIFsxXS4NCj4gPiArCS0gRm9yIFRMUyAxLjIsIHRoZSB2YWx1ZSBjb3JyZXNwb25kcyBkaXJl
Y3RseSB0byB0aGUNCj4gPiByZWNvcmQgc2l6ZSBsaW1pdC4NCj4gDQo+IEhpIFdpbGZyZWQsDQo+
IA0KPiBVbmZvcnR1bmF0ZWx5IG1ha2UgaHRtbGRvY3Mgc2VlbXMgdW5oYXBweSB3aXRoIHRoZSBs
aW5lIGFib3ZlLg0KPiANCj4gLi4uL3Rscy5yc3Q6MjkxOiBFUlJPUjogVW5leHBlY3RlZCBpbmRl
bnRhdGlvbi4gW2RvY3V0aWxzXQ0KPiANCj4gVGhpcyB3YXMgd2l0aCBTcGhpbnggOC4xLjMuDQpI
ZXkgU2ltb24sDQoNCkFoIEkgZGlkbid0IHJlYWxpc2UgdGhpcyB3YXNuJ3QgYWxsb3dlZCwgd2ls
bCBmaXh1cCBhbmQgdGVzdCB3aXRoIG1ha2UNCmh0bWxkb2NzLiANCg0KVGhhbmtzIQ0KV2lsZnJl
ZA0KPiANCj4gPiArCS0gRm9yIFRMUyAxLjMsIHRoZSB2YWx1ZSBzaG91bGQgYmUgc2V0IHRvDQo+
ID4gcmVjb3JkX3NpemVfbGltaXQgLSAxLCBzaW5jZQ0KPiA+ICsJwqAgdGhlIHJlY29yZCBzaXpl
IGxpbWl0IGluY2x1ZGVzIG9uZSBhZGRpdGlvbmFsIGJ5dGUgZm9yDQo+ID4gdGhlIENvbnRlbnRU
eXBlDQo+ID4gKwnCoCBmaWVsZC4NCj4gPiArDQo+ID4gK1RoZSB2YWxpZCByYW5nZSBmb3IgdGhp
cyBvcHRpb24gaXMgNjQgdG8gMTYzODQgYnl0ZXMgZm9yIFRMUyAxLjIsDQo+ID4gYW5kIDYzIHRv
DQo+ID4gKzE2Mzg0IGJ5dGVzIGZvciBUTFMgMS4zLiBUaGUgbG93ZXIgbWluaW11bSBmb3IgVExT
IDEuMyBhY2NvdW50cw0KPiA+IGZvciB0aGUNCj4gPiArZXh0cmEgYnl0ZSB1c2VkIGJ5IHRoZSBD
b250ZW50VHlwZSBmaWVsZC4NCj4gPiArDQo+ID4gK0ZvciBUTFMgMS4zLCBnZXRzb2Nrb3B0KCkg
d2lsbCByZXR1cm4gdGhlIHRvdGFsIHBsYWludGV4dCBmcmFnbWVudA0KPiA+IGxlbmd0aCwNCj4g
PiAraW5jbHVzaXZlIG9mIHRoZSBDb250ZW50VHlwZSBmaWVsZC4NCj4gPiArDQo+ID4gK1sxXSBo
dHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzg0NDkNCj4gPiArDQo+ID4g
wqBTdGF0aXN0aWNzDQo+ID4gwqA9PT09PT09PT09DQo+IA0KPiAuLi4NCg==

