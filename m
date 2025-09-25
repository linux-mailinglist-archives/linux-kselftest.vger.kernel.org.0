Return-Path: <linux-kselftest+bounces-42269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E4B9D70D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 07:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2981890024
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 05:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E52E7F07;
	Thu, 25 Sep 2025 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PF1SpOQr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Uw3Pzdd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09652E7BCF;
	Thu, 25 Sep 2025 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777476; cv=fail; b=epkzUuN3adC4A452kq1QSlzR5dSk36hEYLRyLJXxrKn+UhtDIVNIESM0t2+Qs/XcNKGqzrM5Eraj3j3V1FKp745XOa/3pW4CQYqjXaMLWqRWAmYMp23RdGIZnKja0Qff3j8ESSUWQmaHKfA5yQ0nPmkk6BJtZ2yrgij85YqN90Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777476; c=relaxed/simple;
	bh=eXLCfpSuyUfu7FLAXiAF63LYaDGag/5RE7OEuhuBCLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUz5Iw8TklH4Yn/ojhOAoIjwvPdwGEZUWy2LsSGE0hFqKJrUZsPXBGDFt+/vRpjdn7e4pKwrq8LGyuZwIg0KpxGvjm+GUPd5JIPwnWyUBdsx29h0VBb3ASsHvYKKIzogLZqfFWifDmh/ECFC6/hhxa3SV1U7l1xW8gO5e3imkmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PF1SpOQr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Uw3Pzdd/; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758777474; x=1790313474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eXLCfpSuyUfu7FLAXiAF63LYaDGag/5RE7OEuhuBCLI=;
  b=PF1SpOQrewo1nblfn9le2OUOd9QqZR/PWRzasK9Jd9u1ideB///pHZEe
   3Dt6kN4UBtcvPFhDAVBDMXS5a/tDCphFCx5mIumD77Ackfhg9i+VsHvCj
   6IdeZVRa5PsaEGGKMVFmtApIAlMSZrMErVUVz0pM0QQvBM/SFlQyy6za0
   LyZGVXiFdePhelLEOLjlvYb+LxvSk+EMxJqg/pqiKExeKLo14EE+llqFE
   3HKg/c3dQNIS7GlrajGpgoYYw6bbMABQf3kZ25D9/5a5p9u5kcdZcbSr4
   kf1rIfYz6RKADEp5Taugt8bHMzT/fy74o7+8IttKD2FL+YGoh5DQKqdSu
   Q==;
X-CSE-ConnectionGUID: YXkfhNGEQcC560njpF2OHw==
X-CSE-MsgGUID: X71m9weqRjCZoQHkAytCjA==
X-IronPort-AV: E=Sophos;i="6.18,291,1751212800"; 
   d="scan'208";a="129871352"
Received: from mail-southcentralusazon11013005.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.5])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 13:16:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4i7JRnfDbK7zzpZEa3uhC08o1adgHo7aa9yJotUo76ZPUgdlnbTwl4oEgdYWg7qhbpz4y0NhmaDYcZmucJ0bO41ebNBrupSMxZKxajHvuHKZg68B4+4HAwAtSZ961Xd84pOPJHRT9V2FBoMzAIQFsBaCLfmnM0m9OdyZsfvvdg6V6qCbnis5OLBmQBwLXEwUZdwl6OGB9YIGuT+SkMOcTudjCLaccSil+stQ77kq6eszXQsKRjLFNgiVVu09f4VUpIVIBCQ1/30AIW3p2VU8s5K0RYHBGdqQSrx0pd5t5ATaYGeRptZe9cK1BWtpnvMdy40kUE1ITTUw+6HOYYqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXLCfpSuyUfu7FLAXiAF63LYaDGag/5RE7OEuhuBCLI=;
 b=HFj2zxNkEMVN1VvpdXDZ35rzs4ajw/HNO0Vypq7NRnjm5FJMomgJ3jP3NlZjOH2dS2faKT6+w98A20IhripVuWtQ2rXm2/CBm55ooiMsoVAA0FKfdkoavNvLWLSxsbcnSYzy6KRgS1XMB4Zs6W9bqAxWOB5dek6n+tAgBrng524M2ZTmMQX74t/5mtTCLIm/5zrjLAZ1eU7XG3rMP8VxPuez1nphz7L6IW2pQbhZhKJPqRj5aGC4PDcVCfD0pKd2/+HNf4/IShpE16iYzpN26vZwBrUAskePs4uXzVXsNsCDo9cBLLEOmp0d3n3HigMGBS11OcHUm9h2u7EXTyybxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXLCfpSuyUfu7FLAXiAF63LYaDGag/5RE7OEuhuBCLI=;
 b=Uw3Pzdd/iK9/xGKouu8MOO2/8MVBnrnUSCHJvZ7ZERJIlq4oD9s7RlTwaQLS+iSIj4LFKQsoUtMweor6BHMFhk4FLw0cHCL2FTDEDPsxshRFJq17KkPtEwYwTdPJOVKkMaajqbty7BropQn6aQj6kortJAS7Ixrrqh9hA1lAMJg=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY1PR04MB8653.namprd04.prod.outlook.com (2603:10b6:a03:525::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 05:16:44 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Thu, 25 Sep 2025
 05:16:44 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] selftests: tls: add tls record_size_limit test
Thread-Topic: [PATCH v4 2/2] selftests: tls: add tls record_size_limit test
Thread-Index: AQHcLEt4VXp6F+Ian0Ck6xKCzQf54rSintgAgAC/uoA=
Date: Thu, 25 Sep 2025 05:16:44 +0000
Message-ID: <0bae4a20d499c23a80065f5cb7ba1e6a1d95417b.camel@wdc.com>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
	 <20250923053207.113938-2-wilfred.opensource@gmail.com>
	 <aNQvZnCWhymiXYPO@krikkit>
In-Reply-To: <aNQvZnCWhymiXYPO@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY1PR04MB8653:EE_
x-ms-office365-filtering-correlation-id: 777a0e8d-1119-4710-7bca-08ddfbf2b7ec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R20wZGFWN3lXNjJLTzdnUDN3eEFEc2VtRXN5dmpNTnRqTUh6K2gyK3FpSVND?=
 =?utf-8?B?SlYwOUhFelBuamkyK0NrNzkxN3VLeDFIdjVJZU8rclUvK2NpR2FKSGFDYkt6?=
 =?utf-8?B?eHd4R0Zha3QwcFNHem56d05KbmVLVFFmNHl5K25pNGdiSTFmc0phb0M3a3E0?=
 =?utf-8?B?WFk5Mm1mdFE0b0FVWjF0ZWtIZEh3RXNGRzV5Z3o0M1l5bU1GR1k4elFPRTNh?=
 =?utf-8?B?R1d1RmkwMHUvWktRUUl0dkFoMU1ZVzQ4dENTRklUakwrc0Y5L1EwZ2s0RHVx?=
 =?utf-8?B?V2xieVJMS0oydndXQ09BWFlCSG0wZXZrM1JTa2FNbFU3UWVkbi9Ra1h4T1lV?=
 =?utf-8?B?aDFveExUM00rcThtSHp5Mm5Id3ZiOUVHcllFVGlvOGMvM1hjOTVpWHRlUHYr?=
 =?utf-8?B?S05ac2Z3YldGZDZNWHNuNEhFNFpPbUs5MitpODhKeUl2L0NEVksvVysxS0J6?=
 =?utf-8?B?bCs3Y1lhWDltSllhWkNiRmNHZU4wVW5SNWkxVkFIbWtmRTlxRkJPZmVlL01B?=
 =?utf-8?B?a1AwTk4ycWFMeC9ySnRBampVckM3Rmc4bHFDZTNFT3U2Qlk4M3d1SFhmNTUr?=
 =?utf-8?B?VFZ0Z2NqY0ZrM2IxK0IyVitHU2FMVkpla05DQjNQNWVoWEhtMFlmQk52ZlBS?=
 =?utf-8?B?ZUtxV2JpR3dnbWtHNWhzRUlMVCtlRHU3eHF2cnMwRUFYT3VZZjNoWWFpNk5m?=
 =?utf-8?B?d21XNjcxWXYrUEhyZkNQOHZXSk9UTy9yWGNvY2JST1JUd0VGbXlhdUpzVFJF?=
 =?utf-8?B?OWFTQ1kwNDBtNVFGblBlSm1ub0VaYU9SbzNlZUwveWs3T1dnMlV3K3dnK1Fp?=
 =?utf-8?B?MlNuVVFySHp1dTFSU2RrYzgyd056UkN5Uk5zRXlwalhRK2p1UjYrRmhCNGV6?=
 =?utf-8?B?V2Z6Rllna25UQnZtWUZ1ZXliUHJyZ0VhMnM1a2NHYndBK2NFb1I2eFowQzIz?=
 =?utf-8?B?VERKamRtYXFMcnAvRXpkSnN2TzF3eDFXMXp4Y3pQbzNxR2tndGhxMUgzOHpv?=
 =?utf-8?B?amppc2x3WldBVkpJTE4zNlJUanBGdFJCbzBrQXFaTVNjc3g1WHQ1czV3VmtE?=
 =?utf-8?B?UDRBUlBHbG1JNC9MYklmU1ZwUmZsRDhXU3lhejBXZytOYXJxVkRYeXhDZ1Zu?=
 =?utf-8?B?TXlHQXVRM2ZjbExwQVRiYWt1Y1lMTTFsMVA4RTl3WHBBRnU2N1E5R00vMmpa?=
 =?utf-8?B?VEhFTHQyaWVYejFLVDVkb01qN3dncTRZdUNrUWxNUVRmbUFhYmxjN0c3T21J?=
 =?utf-8?B?ODlwRGx0N0taY296Y1BpcS9nV0RkZXFJZHRaVi9EOTl6T2w3SkxVS200aXNK?=
 =?utf-8?B?ZHNad1A0a2hxYThKV3BUTi9ST0ovaklDNFk4VURseHE1clVMS293aS9vRWpB?=
 =?utf-8?B?dlZObytFQndtMkIzRXgvdjROWW9KUzIvY2h1YUtTdGp3ajRMbXUzY2cvNG5j?=
 =?utf-8?B?TzR3OVZWNDRzUnBtdm16Z0pCakRtenFNTkxUeHBBUnhVOXVPTXdpS05Vb3Q4?=
 =?utf-8?B?dExTZlN4RlNrbHJ4YzZETFJsb04rR2M5aUxQbWxZY2VNVFVqaVdMcE5mSDE3?=
 =?utf-8?B?ZlF3K243YktSdnZvWXhBallUOXE1YWNxS3E1c2hub0JUeEJSQllwLy9JT1Zt?=
 =?utf-8?B?VDh1c0FaNTNicUhJM2RQRFU1N25hMGlvVFhmVFUzRExjUkpIYm1kWEhVNWFn?=
 =?utf-8?B?QUdadXg0WnFOWTBadlNoUTB0S1JNMEdPRFk4bG5VOS90RUJVNUVmUExEVEI0?=
 =?utf-8?B?azNzSUxUaEkrTUhzeDlaRXd6YmJ3WTczdWxZWi8xamsyUWVSODIweXh0NnVh?=
 =?utf-8?B?OVhCN1YrM0c0WmsyOHZGbEpUVFh1WCtxcGJzNTdvcklJV1Z6R2hBb2djN3I1?=
 =?utf-8?B?ZzBtWG0yM3JXVUdKbWxxMWYzZUxTMkJVblZXMlNqMmxWY3dYbzM2YU1IMDgr?=
 =?utf-8?Q?gzp7gfYrvL8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L202NGlpMjUyS3NjUk5POVNsTWVvdWxlTURyQVBJQUVmeWQ1U2hlUlNDejFG?=
 =?utf-8?B?TXQrb254S0FYM1lEMEF5ZTZkRVE0T0dDMDRjS3V1UHRIM1hUNVFjRVBSenFL?=
 =?utf-8?B?TndpWnZCRFZrMDVCMUI3eTRpS21kdkpwMnZkL25BRVBOdTV4QXRRSkllRHd4?=
 =?utf-8?B?cXg1M1BEVnBrSXArNWp0WjRYYWRZSlkwbm1TVFhuN0REb0RQOVZqQzhzbnN2?=
 =?utf-8?B?dGIvZ2V2M2ZkbStqcWgxZ0pSWForY2FjSUtzcnZBZTIyS3ZpMHZ3SFZmYnAr?=
 =?utf-8?B?L1pFK1dwLy9XZm8rLzBUb0pKRG1icVVsNWFmUlZJMG5UZHZ5TldDSTc4WUZH?=
 =?utf-8?B?YmFJVEhDcjh0Vzl4UU5HaGFXNFVld1BDaGpvWnRSckJ5dWxvWmlNakl4Sjg0?=
 =?utf-8?B?NGNHU3V0eXNjVXFmTHBpZFJrZnZBR3NwQTUxRTlsTHB0TEhWWFIydURTamwx?=
 =?utf-8?B?azRUdGlUM055NlowQlVya3FWbGZIOWlUVGcxeThqeEs5ejJONmIwRkthZm1U?=
 =?utf-8?B?ZVJ3MzFKZW1PWnJlaDRDSHRzYm1KOXNIaklyWkdGcEE0Vy96K01Eczk4SjBL?=
 =?utf-8?B?bURpQ2tYbk1HUjY2elNQSVB1N3Y3aytmTjYzRDdSOC9pZ05qWWxCNzdMcG11?=
 =?utf-8?B?aW5XOVVlNG5GSVVnWTBsVmpaMFJCVlRhdDVsei9WTFdPZDhJNWIveFFPcFBZ?=
 =?utf-8?B?TXltQ2RETmQ1YWN6d1lnSDRqNEYwZS9vU1NBeFRRUVdDaThMZTZQKzN1QWx3?=
 =?utf-8?B?Wi9CL3UrM0hPcTdNQXBvUUdLbTg1ZHFNZE00WjRIVGRrY05ZV245ODQ0Z0NY?=
 =?utf-8?B?Y3ZqWDU4a1BRQWJiQlNOTU5jYldwdG1hOU1Ld1NhcVFrdFQxZ2Fnd3VieXE3?=
 =?utf-8?B?bjVYTStLNUc5dTdUejhPTEFDb1k2bE1KbE9WSDJZWjBJbGFzYStsZGhEcDRx?=
 =?utf-8?B?akVjRFpMQW5mRS9RLzVMcS9NZitPVkxsMWJmVnVPVVgwSzBhTlNLMlpRWlYz?=
 =?utf-8?B?c1o2aHdlM2Fxbnl5VDFPYVk4Nnc5M1BPWi9MaUNIbFpXM2xzcUFRcGdmdksv?=
 =?utf-8?B?Z1Z4bWMvVWdyWEtycCtJR2FSeEpaS0doSks4NitaS1NJZ2NoNDVsNmUvVlYx?=
 =?utf-8?B?Ti9CWUtRZ200TXl5eElYRnM2a1BaeVhTN1I4eUlBUjRUcjhwQlFWUkZ0UEtV?=
 =?utf-8?B?RTdGV3NOUmsxSGM2RHRETmQzRzZ0K2h5NGFGMGJweUZtTWdwV0YydTg1MEpQ?=
 =?utf-8?B?b0R4WXJ6dmhqWDNGcXNZZkRldVpteU81S1pyTDBhZTNRSVN6V3hXWXBpVUhP?=
 =?utf-8?B?eHU5NnpNdVZoQ2Jpb0RiRHl6dnI5V2MvM0VDbWZLTkpxTHlPNkc5dDZPazB4?=
 =?utf-8?B?SUszMnBsOThCTU1aTmJBUUdYRWtNYjhWOHVhRVdHenlIN09SME5saVlaN0pz?=
 =?utf-8?B?T01Fck0xNDRyb2VxQVJoaWwrdnlzYUcrTlAySm1Nbk05MHMxUkxxOXlwTTNv?=
 =?utf-8?B?QVo3RjdWWTI0SXJLQlV5NVUzN3dZa2tQWXhSdVlORmI0Q1Y0OFhNbGxNVTBk?=
 =?utf-8?B?MTJzQVJRM2VkZ2xhbEdxaHdNUHo4SE8wb2hXV2tJTXZ3dVVhOWdnWG9EVXNN?=
 =?utf-8?B?cVNVWklKL0tPOHM2MlF6K0VtZm0vRVJ4a1hPTkcwR1VvY1ViMGo1Q0tPbjV6?=
 =?utf-8?B?WE5VeEwrNjdkZkVuOWhncnJCaEVBVTNOd29oY3BNZzBITnNoYVE2TTFjVUpV?=
 =?utf-8?B?b091TytqejNkeFBmaXBGQTBkOTRUQ3BjUE9RWUVmWEJoeWkxWGxxOGF0Nml6?=
 =?utf-8?B?anpDeVlncUx0dW9SNnNyUGpscFpvNXlKUk1CODlYR3E3amFVanRIamFMVGsz?=
 =?utf-8?B?cU9veFptSTVTRGNQWXRDQUpOVXBhV1o1WDNNV1VBUE54YVIxeFJNNzlkWTFu?=
 =?utf-8?B?RmEzMElRSFFhcEhtVTh4VmcrcS9qa2RacU1pckIyZmsycDlDVGxOaklmU1VZ?=
 =?utf-8?B?ZVViUllNTGE3enpSUEpmeE5hMmJBSDZyTk5ZclY3ZVEwN0E0ZDBENGdjMHhy?=
 =?utf-8?B?Wm5RaG5JcHVOMHNnZzYrZ0xoWWttL2pBbXJBZDBCQzA4THp5V0FWSkx6cXVP?=
 =?utf-8?B?bGdyYnFmOG45NWNOY3huSXBGS2IzUHkzN1h5cVJiTkprTGJvMXBoU3VZM20w?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6743EFC22D03468A43B4C3EB52272D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uWj7LVIkiaLwecF7uJj26djn1mtMPR3r7YOAJNhKEY/htkO7bVFTvftphb2ArzPmizDVYhU31o1E1R/8QY8bBrbnhm+ktDB8KvfcvNaTICQHeSVDtLj+b+b0AiLhY8SbFIab1fMr+NuPi7ixy10rVYeDtW+Wv3k2VQYPaH+UtRINNY18S4MMI95WjInT9/cuRxXf12lis//zfd/KeG1w5B3HFnV4qVqyptgAsuqslZPYtQxXZypJfCP5jdINRylXVTcxy+SJ4Rl0sfCrOmmgW7y0mwlgePscjwVULXDkAAMiqsQHsWdM98zFp+FSQhSEHmubEltBeHDi/BJcT6LoNCnbLT7DVy7tmofjrMfJBFp2z9g0BB+Yd1NMmePcyGolgEic0i3p353+8j2f424wKS93UY7axTgsteH8SW/x1Jl3OqPKBJS/bo7elU58RMn5NOmvgiqlcBwdfEnuiKlAAmSysW4nbthdsrsnHSDMLunt1UAS3qVPfBGFBQpGzxN040gSZ1IpPVCXaEgkH4BHSIm7HKjpTIbxdUdX21EFhH+d8tcZWXwS+Kcta9Jpr4WM6mreZ0ltqbisy0y8BH+BvQnmnSVdbb/HSfKybRdWii81LXqjuQ19op8sKIbfJPQw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777a0e8d-1119-4710-7bca-08ddfbf2b7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 05:16:44.2793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7pBclVebrYXb3iOhttxGAbTltXdrErx6DialnDEIVqI5VWozlXM43LHjerreaJg8ROgvpENpausbnbSqMxABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8653

T24gV2VkLCAyMDI1LTA5LTI0IGF0IDE5OjUwICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IFtnb3QgYSBiaXQgZGlzdHJhY3RlZCB3aGlsZSB3cml0aW5nIHRoaXMgc28gU2ltb24gZ290
IHRvIHRoZSBwcm9jZXNzDQo+IHN0dWZmIGJlZm9yZSBtZSwgYnV0IEknbGwgbGVhdmUgaXQgaW46
XQ0KPiANCj4gQlRXLCBhIGZldyBkZXRhaWxzIGFib3V0IHByb2Nlc3M6IHNpbmNlIHRoaXMgaXMg
YSBuZXcgZmVhdHVyZSwgdGhlDQo+IHN1YmplY3QgcHJlZml4IHNob3VsZCBiZSBbUEFUQ0ggbmV0
LW5leHQgdjQgbi9tXSAobmV3IHN0dWZmIHRhcmdldHMNCj4gdGhlIG5ldC1uZXh0IHRyZWUpLCBh
bmQgdGhlIHBhdGNoZXMgc2hvdWxkIGJlIGJhc2VkIG9uIHRoZSBuZXQtbmV4dA0KPiB0cmVlIFsx
XSAoSSdtIG5vdCBzdXJlIHdoYXQgeW91IGJhc2VkIHRoaXMgb24sIGdpdCBhbSBjb21wbGFpbmVk
IG9uDQo+IGJvdGggbmV0IGFuZCBuZXQtbmV4dCBmb3IgdGhpcyBwYXRjaCkuIE1vcmUgaW5mbyBh
Ym91dCB0aGlzIGluIHRoZQ0KPiBkb2NzIFsyXS4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LW5leHQuZ2l0Lw0K
PiBbMl0gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5o
dG1sDQo+IMKgwqDCoCAoaW4gY2FzZSB5b3UncmUgbm90IGF3YXJlOiBhbHNvIG5vdGUgdGhlIGJp
dHMgYWJvdXQgIm1lcmdlDQo+IHdpbmRvdyINCj4gwqDCoMKgIHdoaWNoIHdpbGwgcXVpdGUgbGlr
ZWx5IGJlY29tZSByZWxldmFudCBpbiBhIGZldyBkYXlzKQ0KPiANClRoYW5rcyEgSSB3aWxsIHJl
YmFzZSB0aGlzIG9uIFsxXSBmb3IgVjUgd2l0aCB0aGUgY2hhbmdlcyB5b3UNCnNwZWNpZmllZC4N
Cj4gDQo+IDIwMjUtMDktMjMsIDE1OjMyOjA3ICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6
DQo+ID4gRnJvbTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4g
PiANCj4gPiBUZXN0IHRoYXQgb3V0Z29pbmcgcGxhaW50ZXh0IHJlY29yZHMgcmVzcGVjdCB0aGUg
dGxzDQo+ID4gcmVjb3JkX3NpemVfbGltaXQNCj4gPiBzZXQgdXNpbmcgc2V0c29ja29wdCgpLiBU
aGUgcmVjb3JkIHNpemUgbGltaXQgaXMgc2V0IHRvIGJlIDEyOCwNCj4gPiB0aHVzLA0KPiA+IGlu
IGFsbCByZWNlaXZlZCByZWNvcmRzLCB0aGUgcGxhaW50ZXh0IG11c3Qgbm90IGV4Y2VlZCB0aGlz
IGFtb3VudC4NCj4gPiANCj4gPiBBbHNvIHRlc3QgdGhhdCBzZXR0aW5nIGEgbmV3IHJlY29yZCBz
aXplIGxpbWl0IHdoaWxzdCBhIHBlbmRpbmcNCj4gPiBvcGVuDQo+ID4gcmVjb3JkIGV4aXN0cyBp
cyBoYW5kbGVkIGNvcnJlY3RseSBieSBkaXNjYXJkaW5nIHRoZSByZXF1ZXN0Lg0KPiA+IA0KPiA+
IFN1Z2dlc3RlZC1ieTogU2FicmluYSBEdWJyb2NhIDxzZEBxdWVhc3lzbmFpbC5uZXQ+DQo+ID4g
U2lnbmVkLW9mZi1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4N
Cj4gDQo+IFRoYW5rcyBmb3IgYWRkaW5nIHRoaXMgcGF0Y2guDQo+IChhbmQgZm9yIHRoZSB0YWcg
OikpDQo+IA0KPiA+IC0tLQ0KPiA+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Rscy5j
IHwgMTQ5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMTQ5IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbmV0L3Rscy5jDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9uZXQvdGxzLmMNCj4gPiBpbmRleCAwZjU2NDBkOGRjN2YuLmM1YmQ0MzFkNWFmMyAxMDA2NDQN
Cj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvdGxzLmMNCj4gPiArKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvdGxzLmMNCj4gPiBAQCAtMjQsNiArMjQsNyBAQA0K
PiA+IMKgI2luY2x1ZGUgIi4uL2tzZWxmdGVzdF9oYXJuZXNzLmgiDQo+ID4gwqANCj4gPiDCoCNk
ZWZpbmUgVExTX1BBWUxPQURfTUFYX0xFTiAxNjM4NA0KPiA+ICsjZGVmaW5lIFRMU19UWF9SRUNP
UkRfU0laRV9MSU0gNQ0KPiANCj4gbml0OiBUaGF0IHNob3VsZCBub3QgYmUgbmVlZGVkIGlmIHlv
dSBydW4gYG1ha2UgaGVhZGVyc19pbnN0YWxsYA0KPiBiZWZvcmUgY29tcGlsaW5nIHRoZSBzZWxm
dGVzdDoNCj4gDQo+IG1ha2UgLXMgaGVhZGVyc19pbnN0YWxsIDsgbWFrZSAtQyB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9uZXQgdGxzDQo+IG1ha2U6IEVudGVyaW5nIGRpcmVjdG9yeQ0KPiAnL2hv
bWUvc2FiL2xpbnV4L25ldC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQnDQo+IGdjYyAtV2Fs
bCAtV2wsLS1uby1hcy1uZWVkZWQgLU8yIC1nIC1JLi4vLi4vLi4vLi4vdXNyL2luY2x1ZGUvIC0N
Cj4gaXN5c3RlbQ0KPiAvaG9tZS9zYWIvbGludXgvbmV0L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
Ly4uLy4uLy4uL3Vzci9pbmNsdWRlIC0NCj4gSS4uLyAtRF9HTlVfU09VUkNFPcKgwqDCoMKgIHRs
cy5jwqDCoCAtbyB0bHMNCj4gDQo+IGFuZCB0aGF0IHdpbGwgZmluZCB0aGUgbmV3IGNvbnN0YW50
IGRlZmluZWQgaW4gdGhlIHByZXZpb3VzIHBhdGNoDQo+IHVzaW5nIHRoZSBoZWFkZXJzIGZyb20g
dGhlIGN1cnJlbnQga2VybmVsIHRyZWUsIGluc3RlYWQgb2YgdGhvc2UgaW4NCj4gdGhlIHN5c3Rl
bS4NCj4gDQpUaGFua3MhDQo+IA0KPiBbLi4uXQ0KPiA+ICtURVNUKHR4X3JlY29yZF9zaXplKQ0K
PiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdGxzX2NyeXB0b19pbmZvX2tleXMgdGxzMTI7DQo+ID4gKwlp
bnQgY2ZkLCByZXQsIGZkLCByeF9sZW4sIG92ZXJoZWFkOw0KPiA+ICsJc2l6ZV90IHRvdGFsX3Bs
YWludGV4dF9yeCA9IDA7DQo+ID4gKwlfX3U4IHR4WzEwMjRdLCByeFsyMDAwXTsNCj4gPiArCV9f
dTggKnJlYzsNCj4gPiArCV9fdTE2IGxpbWl0ID0gMTI4Ow0KPiA+ICsJX191MTYgb3B0ID0gMDsN
Cj4gPiArCV9fdTggcmVjX2hlYWRlcl9sZW4gPSA1Ow0KPiANCj4gZ2NjIGNvbXBsYWlucyBhYm91
dCB1bnVzZWQgdmFyaWFibGVzLCBJIGd1ZXNzIGxlZnRvdmVycyBmcm9tDQo+IGV4dHJhY3Rpbmcg
cGFyc2VfdGxzX3JlY29yZHM6DQo+IA0KPiB0bHMuYzogSW4gZnVuY3Rpb24g4oCYdHhfcmVjb3Jk
X3NpemXigJk6DQo+IHRscy5jOjI4NDA6MTQ6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhy
ZWNfaGVhZGVyX2xlbuKAmSBbLVd1bnVzZWQtDQo+IHZhcmlhYmxlXQ0KPiDCoDI4NDAgfMKgwqDC
oMKgwqDCoMKgwqAgX191OCByZWNfaGVhZGVyX2xlbiA9IDU7DQo+IMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+DQo+IHRscy5jOjI4Mzc6MTU6IHdh
cm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhyZWPigJkgWy1XdW51c2VkLXZhcmlhYmxlXQ0KPiDC
oDI4MzcgfMKgwqDCoMKgwqDCoMKgwqAgX191OCAqcmVjOw0KPiDCoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fg0KPiB0bHMuYzogSW4gZnVuY3Rpb24g4oCYdHhfcmVj
b3JkX3NpemVfb3Blbl9yZWPigJk6DQo+IHRscy5jOjI4OTM6MTQ6IHdhcm5pbmc6IHVudXNlZCB2
YXJpYWJsZSDigJhyZWNfaGVhZGVyX2xlbuKAmSBbLVd1bnVzZWQtDQo+IHZhcmlhYmxlXQ0KPiDC
oDI4OTMgfMKgwqDCoMKgwqDCoMKgwqAgX191OCByZWNfaGVhZGVyX2xlbiA9IDU7DQo+IMKgwqDC
oMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+DQo+IHRscy5j
OjI4OTE6MTU6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhyZWPigJkgWy1XdW51c2VkLXZh
cmlhYmxlXQ0KPiDCoDI4OTEgfMKgwqDCoMKgwqDCoMKgwqAgX191OCAqcmVjOw0KPiDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fg0KPiANCj4gDQo+ID4gKwl1bnNp
Z25lZCBpbnQgb3B0bGVuID0gc2l6ZW9mKG9wdCk7DQo+ID4gKwlib29sIG5vdGxzOw0KPiA+ICsN
Cj4gPiArCXRsc19jcnlwdG9faW5mb19pbml0KFRMU18xXzJfVkVSU0lPTiwNCj4gPiBUTFNfQ0lQ
SEVSX0FFU19DQ01fMTI4LA0KPiA+ICsJCQnCoMKgwqDCoCAmdGxzMTIsIDApOw0KPiA+ICsNCj4g
PiArCXVscF9zb2NrX3BhaXIoX21ldGFkYXRhLCAmZmQsICZjZmQsICZub3Rscyk7DQo+ID4gKw0K
PiA+ICsJaWYgKG5vdGxzKQ0KPiA+ICsJCWV4aXQoS1NGVF9TS0lQKTsNCj4gPiArDQo+ID4gKwkv
KiBEb24ndCBpbnN0YWxsIGtleXMgb24gZmQsIHdlJ2xsIHBhcnNlIHJhdyByZWNvcmRzICovDQo+
ID4gKwlyZXQgPSBzZXRzb2Nrb3B0KGNmZCwgU09MX1RMUywgVExTX1RYLCAmdGxzMTIsIHRsczEy
Lmxlbik7DQo+ID4gKwlBU1NFUlRfRVEocmV0LCAwKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBzZXRz
b2Nrb3B0KGNmZCwgU09MX1RMUywgVExTX1RYX1JFQ09SRF9TSVpFX0xJTSwNCj4gPiAmbGltaXQs
IHNpemVvZihsaW1pdCkpOw0KPiA+ICsJQVNTRVJUX0VRKHJldCwgMCk7DQo+ID4gKw0KPiA+ICsJ
cmV0ID0gZ2V0c29ja29wdChjZmQsIFNPTF9UTFMsIFRMU19UWF9SRUNPUkRfU0laRV9MSU0sDQo+
ID4gJm9wdCwgJm9wdGxlbik7DQo+ID4gKwlBU1NFUlRfRVEocmV0LCAwKTsNCj4gPiArCUFTU0VS
VF9FUShsaW1pdCwgb3B0KTsNCj4gPiArCUFTU0VSVF9FUShvcHRsZW4sIHNpemVvZihsaW1pdCkp
Ow0KPiANCj4gbml0OiBNYXliZSBhIGZldyBvZiB0aG9zZSBzaG91bGQgYmUgRVhQRUNUX0VRPyAo
QVNTRVJUXyogc3RvcHMgdGhlDQo+IHRlc3QsIEVYUEVDVF8qIHdpbGwgcnVuIHRoZSByZXN0IG9m
IHRoZSB0ZXN0KQ0KPiANCj4gR2V0dGluZyB0aGUgd3JvbmcgdmFsdWUgYmFjayBmcm9tIHRoaXMg
Z2V0c29ja29wdCBpcyB3b3J0aCBub3RpbmcgYnV0DQo+IHRoZXJlJ3MgdmFsdWUgaW4gcnVubmlu
ZyB0aGUgdHJhZmZpYyB0aHJvdWdoIGFueXdheT8NCj4gDQo+ID4gKw0KPiA+ICsJbWVtc2V0KHR4
LCAwLCBzaXplb2YodHgpKTsNCj4gPiArCUVYUEVDVF9FUShzZW5kKGNmZCwgdHgsIHNpemVvZih0
eCksIDApLCBzaXplb2YodHgpKTsNCj4gDQo+IEJ1dCB0aGlzIG9uZSBzaG91bGQgbWF5YmUgYmUg
YW4gQVNTRVJUIGJlY2F1c2UgdHJ5aW5nIHRvIHBhcnNlDQo+IHJlY29yZHMNCj4gZnJvbSB3aGF0
ZXZlciBkYXRhIHdlIG1hbmFnZWQgdG8gc2VuZCAoaWYgYW55KSBtYXkgbm90IG1ha2UgbXVjaA0K
PiBzZW5zZT8NCj4gDQo+IChqdXN0IHNvbWUgdGhvdWdodHMsIHRoaXMgaXMgbm90IGEgInN0cmlj
dCByZXF1aXJlbWVudCIgdG8gY2hhbmdlDQo+IGFueXRoaW5nIGluIHRoZSBwYXRjaCkNCkdvb2Qg
cG9pbnRzLCBJIHRoaW5rIHRoYXQgbWFrZXMgbW9yZSBzZW5zZS4NCg0KUmVnYXJkcywNCldpbGZy
ZWQNCg==

