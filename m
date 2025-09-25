Return-Path: <linux-kselftest+bounces-42436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD916BA1FBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96F61C02DAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23E2ECE9A;
	Thu, 25 Sep 2025 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MpUHtSj3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="im0wbZm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515F1F8AC8;
	Thu, 25 Sep 2025 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843434; cv=fail; b=aY6Q7VYF1pfr9W+8vOs+JcVThDMQTO3KM3GJ7fVCXo7wIdINZW6I+yLwHKw2SfnTz7RsEP+5kOMRpXJDO0Vl+wM+4t4lH8HV3+lr658SGEqL5QkqPVU9kBsWAA8SCmAffObK9itu5nKH2dF1Lfp2t8M6G/exoAxWDAdIuRW+5mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843434; c=relaxed/simple;
	bh=7ZkXWxxmbjtmNfNBqCjGw210EQX8XGTy8tXZJed5jXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soKXTxrnAdVEOkhbuzASXMIi94b/7OqXcsgXNJ9TV9kAU1tqvXH7gOCzU4YddSRaznEK0JJgrFavV3WYOcATq4n2VprIp0IMVI7PyMt+WyG1Dwvg9zRVU5iiOAOjvU/85fu1A8GZCTKiH3ZBD1R7mc7xhvxgy8lmaI5fk3bAWt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MpUHtSj3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=im0wbZm7; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758843432; x=1790379432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7ZkXWxxmbjtmNfNBqCjGw210EQX8XGTy8tXZJed5jXs=;
  b=MpUHtSj3cq8E+W+BN2+obV6yv+uAfladaL+dzugQBUWixP4Vx7W92TEe
   iiOiUYDRg+rZkFi1AEsxYcG6cocEOQSvRdh2xpJOSHMLj2/umH8vE/bNp
   QXHRLgNf2gCbeM4yzo8/rqvi/YK+0SHw2yCxo97iP/TF4iVOHJ/b088i+
   6jWSPagsoTbUJE/9w6gkbK+1RbxpZ8rLfVogAkaxVeZlnD8RgrNnu9Za4
   42ms7UmacJL9QBwz/Hr3SOuUC3R7nQvG/n2LAwhplvaFOMHUZcLEEk4dV
   6gzo7VlnhwmccM3hob0VfCfg7HBCXSOinlEhHjOX2N1y46xWxI10wjntH
   A==;
X-CSE-ConnectionGUID: ppeOaN7GRoiZMDheUktL5A==
X-CSE-MsgGUID: 6plZ/tnXSSOrUXUK0MLmOQ==
X-IronPort-AV: E=Sophos;i="6.18,293,1751212800"; 
   d="scan'208";a="130614077"
Received: from mail-westus2azon11010061.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.61])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2025 07:37:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoKuz9+T+Nf5m0Ah9gu4VOUbb0mi5hyetgmeBAbBeQ8LHoXfJwQlGoUGmNMxxN/ASTi/NwKZ43Ia6mnndkixUYScOzWSgR0qVSTxKuSdTEGwgSIvODLWLhzctr2V9goeK7pWuKiCfTk6WNg4P+o/BcwqpatTDuBuP75cEwb4jtj3T1Gd4wYupEcaBLSvxPERpu9zfKWQug/6c3tOlbt0clGycSCNff5zknZqn1PTjo98BiC13PWJnPqJR5qbQ7i7tcN6zUrrLg5u5M1qOiZmcwUCes/qBCZUuvV8fur0ffpWGNgs2T5hme95ZsqkaQRa7QchzFF1sOsRwBIJrrqeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZkXWxxmbjtmNfNBqCjGw210EQX8XGTy8tXZJed5jXs=;
 b=H+Mf7Qml6F2P56AePrROMfCuRIPqQScsP9i/QQnBEjsQplLy0xgPpi4meNgTRFZPb2UlwDWk6d6+cjaqFZVHnDsi2lbRUuqzsGK1KH4UXW/A/5WOp8QV1sXwksGFTTfPcu45ThY8uyVh8eXWrOFeUPlFK6oJqCCoBQXC7jacv+j5YWNISGZPG32KkUXWw/hS6Av+xSnKLHqrn00Rlr3HpvAWofttA26/0rTKmnvrUDXuhCeSveA6CAJpgeuX5gmEiHy0ci5mreByxjg/JlCoqGtiVRUvSVFvkDfS7OYFVr9504u3YNnu1NZVj4ktuT4hhiHkKvlN44QKAZIbNTDV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZkXWxxmbjtmNfNBqCjGw210EQX8XGTy8tXZJed5jXs=;
 b=im0wbZm7YSXuftPOSDemvEcVMKFXaKowOmO0Ow94zzCjUiIrLzGv/vdmNpsEri09bRiaFBdZXeedIMNUyR/FuB4lR5eNX9ZY1L8qJBEOJs1hk0CVfTuox49jnG93t73V4d0ka6/U1NZbluv7brinwju7AcBDPRgMOdpQ7HG3tF8=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CY3PR04MB9717.namprd04.prod.outlook.com (2603:10b6:930:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 23:37:09 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Thu, 25 Sep 2025
 23:37:09 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Thread-Topic: [PATCH v4 1/2] net/tls: support maximum record size limit
Thread-Index: AQHcLEtzQYYhasLEz0mdPGnzGKCvLLSinvcAgADF5ICAAQmDgIAAI6gA
Date: Thu, 25 Sep 2025 23:37:09 +0000
Message-ID: <bfc1bab9a8f2f51e19ba4fd57a6b8bdf69683d42.camel@wdc.com>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
	 <aNQvgD7AvFe7-sAv@krikkit>
	 <4a83e2f526013516e2827a4ff8899b0437d08a25.camel@wdc.com>
	 <aNW0OxiN8M2hv7Qu@krikkit>
In-Reply-To: <aNW0OxiN8M2hv7Qu@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CY3PR04MB9717:EE_
x-ms-office365-filtering-correlation-id: 0f69e442-f563-4c37-741d-08ddfc8c721d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHVlVlNTSlRKdC8rYUxyYkVDRkI1bVdCWHRFVCtMOGcveFlzbDNSWGE2R1VN?=
 =?utf-8?B?ZTdLZWUxdnJLZVVDQjdHcldYN2xiZW53azZnOTU5dmUwd240MVE4K2FuTlFL?=
 =?utf-8?B?QS8yRjBXMzF3YVZWUExwNGNNblB4TXQzUERuZFAwQmZiWk1rdmNhcngrMnJw?=
 =?utf-8?B?cXNuUVhKblk0M0t6MUdqMnNNL3RjK1huUUpmdzhWSFFJNk4wRTMvZ0lLVmE1?=
 =?utf-8?B?YnlGamMrenFXMUI4ZzMrUzdxNkRLV2RjclNCdzNrelgxUjhBdmhvRW51UThX?=
 =?utf-8?B?MVJlQTBkVG1Ub2pCS3kvT3lieFNUNkdBZzM0ZjlINndaU3FYWFFqSDZQRGk2?=
 =?utf-8?B?UFkwWEpYN0Y1WWw0bHJ6V1o0TzRZOHpGa20xdEVEMWwxYVRxU3JoYTVBY0t2?=
 =?utf-8?B?bFpXTkJ3R1pZSGU4Z0hMbFlramNRQWV1ajVMSjlwL04yS1dIbzRvSE16NDd6?=
 =?utf-8?B?QjVUbjhrc1ZBSm9XdXRwV0xSYjFHTVd6QTR3L2lNS09FU3VwdmFVZkhnNmMx?=
 =?utf-8?B?Q2xvZDhoTWdhb0xLZU82dlhZV0x2eXZMbExsRFZwcjd3R1VaSnFYc2YxUkZ5?=
 =?utf-8?B?UDd4SVd4aW5yUTQxRFhqMENBNXlCQlo5Yldad21vWDkwUnFFT2JjcGhRY1Jm?=
 =?utf-8?B?aENZbmZYTUJlTElXN0hvemZkbldINWFYRy9VQ1RNUjgyc1orRm9EYW9hZmVu?=
 =?utf-8?B?YXRtRGZCcmsxSkNIVHNydFNKMjJub216aVNBd1JYdWJHelJiQjMzcVlJZXls?=
 =?utf-8?B?NFprUzRKdHFQcC96MWtpM3RtQU0zb25iMFVXZURScWMwWWZwMkFneU5tbERs?=
 =?utf-8?B?Qlk2NWFKYW5tOVpsOEltd0IxTitBZkVJdDNuOTZRM0tXWDVrNWdoa3RZMTha?=
 =?utf-8?B?SXNEdDlnZ05saDQyQmVaWnJXNDhqNjJOdnBnY0dlSXZRYTFJRzIyRW5wa0hL?=
 =?utf-8?B?WFNHQ3RxOXJ6Ty9mUmFpYjFId25ndWd0bkxQbFdGbDBPZFJ0SS9pbDJ4UmI3?=
 =?utf-8?B?ZHBrbVFNMGVKZGkwaHl5bWp0eWtkSXg1QVhUT0VHU3Fsb2IxYUJUMjlHbWNp?=
 =?utf-8?B?ZzlFV25NeXQ1aFFxMzRYMzd4Wi96ZWx6dmlXV2czSWErMDRPdmxqN3cwNEx4?=
 =?utf-8?B?L1k3RThxb3BRMHRFSThJcUppVkNaYmozYWEvUktxTkl2c0JDdUFmWUxXanRI?=
 =?utf-8?B?OVhrSFVhdmtYNTdLMVhHQUt3eTJuVmt5VTFjbm5RcEh0dlJ1cFVxNm9RbjJV?=
 =?utf-8?B?Vjd2a0RQTHljWUJFYVcxRzJjdlY1U0JneWFMeG8zOXh4bWtzR3lpdFBwU2tx?=
 =?utf-8?B?WVRVTWY2WUNLcm9KbzZaVjFPNFFXSDNUT25sMHRSYURpaGhhdEFiRXVwMjc1?=
 =?utf-8?B?ckVXcjZDMUVPVTJneDArTXJyR0NodkJ1MlpjMnVteTU2bUhjdWxtVnhSVG9j?=
 =?utf-8?B?ZWowTWlTeXlWSzFyQlJuU0ZOVUptanFONFVDaHpHdVo5OFBrbFhLYnRWSGNu?=
 =?utf-8?B?V0FSTUlaZ1hSOUZHNEVJZUFET2R2SzgzZnErOWh4UDdBUFhISTFkb3ZJQXRx?=
 =?utf-8?B?SG0waVVrYnhmUFd1OGYxenpOVExsSkgzNmxxa2k0Y2NuSnRLWGYydVowV1JU?=
 =?utf-8?B?SU9qNDNsck4wbXcxYmJ5L0ZMUFdNVkZpdE1NUkJRWkhmNm96ckl6WUx3MSs1?=
 =?utf-8?B?a3JEcWNMbmNKU21Xdk9aaGVOQkxsdlhkYzFXZHVUblkycHZ1cTdCNFM5c0V5?=
 =?utf-8?B?RldNZFc3TExodkNNSmNUTjlFZFBqYXFxQXA0cyt3VEl2U3kyTHpGMUw1YURv?=
 =?utf-8?B?eCtCQXpnUzBrRmlNUXRZY3RtWEpJb3ppbEdEdldtSEZJb1FpQXhrWE5DZmlV?=
 =?utf-8?B?SXN4S3RuM2F4R1Q0ckI0cW9LRmJqRHpHZWZVYzhnYWFZRzg4SGc3OEpGRDdt?=
 =?utf-8?B?bHgwUWxjaFVlMjhUb2Z6Zkhka25QVVpSb1F1OGR2YkJMUlk1SS8rS1p3dEV5?=
 =?utf-8?B?QXlVd0dKY2RlamY5a3UxM1RxR3lIUFd5OEJGSUFkTFVrMnpYZEVJU09rU1hj?=
 =?utf-8?Q?EgLsS3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MU1VZ1R3VXhDWXJ1L1NZYms1aUlNVzVGOTJ2ZXZEWk41MnBMTGJnZGowQVBj?=
 =?utf-8?B?SlErZ24zOXJzcDlqTWtpRWJLdXdzeXVxSXRiT0V1ZTNBcEZMZHNvQkJsS1lw?=
 =?utf-8?B?b2toRVFPSGVDTjNtdnI4cHMzcFYvUjM2THJUQUo3QXJnMUMwenlhNXJEbXp6?=
 =?utf-8?B?KzMvL08xdzlydktnLzFacTlhWFJKQTlCUTlsOWxWUmJzRStnUXF3bWRKbTBv?=
 =?utf-8?B?SlpIWlZXcDA4Q2xMdFBucEZQRTBRVUt0b2RaK2VxT1NSTEViWDg1aER5bFRF?=
 =?utf-8?B?NWJoTnRLTlltN1pOdXNHMVMyb2RBSERQWFh1NUEvTm1YbmJNSUV0ZkxSM25V?=
 =?utf-8?B?SEZNd28wSDI1TnNkZlVrSHNVQVYvaFVyTlJibFpaSmQ2clRHRSt4bXpjVHNU?=
 =?utf-8?B?WkRQcUFCWklJb2NGTWdzcVdxTDlQenFONHhPS2RSSVRXMmVCR3ZJbEhXSXl2?=
 =?utf-8?B?d2trVFgxakhCU3Jza3Q1d2tyR1RTUTNKbW00Yk03UjZFK0tONzlheUkzL3RQ?=
 =?utf-8?B?ZzZtbTZzV0Y5T20wRGtqVENmUVNzZmNZUWp2b0txcGcyZWdzTmFDa2RXMDRk?=
 =?utf-8?B?bmJxL3VSQ1NYeVk4aUF0dlJDTFlFQWxHMFI0aFdsaVdNWHl2ek9WNUlrMUNW?=
 =?utf-8?B?bnFsQi9mNlBvZlVQWi9sSHRPVWNzZ21XaUNNTVhLRXlNVllMODVjWVk4NGh5?=
 =?utf-8?B?L2R6OW1ZdHEwdDFBRmxabm4rbmdjRTdVLzFORTBrODYwUVFUNitCVnBZY2FN?=
 =?utf-8?B?WmpHOEdkS094Z1Q2eTdnVUw2amF4THMrSUxXVzJ5eWdwVk1ZYWVhMklNeE9y?=
 =?utf-8?B?b0FPaFNDNm1NbkFhQ2hTb2l1VG5XeDRqRTFXT3ExeGp3MVpQQm1HemZMc2ht?=
 =?utf-8?B?MXBrTDZZaGNHQ0o0MStXdEtSUFZEbVVSNUZQYWllNXFYWlI1c1R2M2hEVURl?=
 =?utf-8?B?ZFQ3UWdTR0VmTzNEd21ma2plSXJ2Z1ZrbjZTejd4WkFvb0xTNFk3blZwMzNm?=
 =?utf-8?B?K0ViNHdZdjJuLzNRMDd1TmJ2V0luc0hEOVZITDVlZHIwU2RjeXVGVEdOVWNQ?=
 =?utf-8?B?b2VsNzRxdnFtUE1WVGdIR0drZmFNUlpWbHMyRDQ1UlFvelRMbDVLTFVZYmFV?=
 =?utf-8?B?enk2Z2xtbVNqa0xIRmRXYVVXSTEzeVhTUnAzb2FuRk1kbkZhbzFGa0VPc0th?=
 =?utf-8?B?MmdFTFVSYm15dGszZ1dpY1BCRVJuWGE5RlBkSldPOHorLzJxKzgwNDF4cENG?=
 =?utf-8?B?QVhkcGtqTEkwL055VXRVOUVKNlo2NEJMR2ExV0VWS2tLUXpMOHNPZktpRXZK?=
 =?utf-8?B?Vlo2N3ZBWHIzaER5WHlFN05BbTdCb0JlRmlHV21tWHlUQUM5aGxrcURuYzRY?=
 =?utf-8?B?K2toOGZSTWhFM0hCNHJpdE0zVEswc3VCNGsvbTc2UlUxRUp0eUN5QWdIamdL?=
 =?utf-8?B?WmE4SmprenVMSHdYL0hzWldoZHRubU8vNWEvVlM1QSt2WkxSc0pWRlREVkFF?=
 =?utf-8?B?ZDZtdEp1b2xOQjZRNFRyRHduUGhoeHNFcmk5dXlWb1ZFd294QnpPK3loa0pC?=
 =?utf-8?B?ekhFVWhFTXJJNWIzczdsbmZraG02akRKbTdHcEhsc1lLMkROOG9IYkxUcXRP?=
 =?utf-8?B?TU0yNDN6V211R1U3Qm9FcHpPYm9pVlVwc2tGQlM5UXZjckgraCtpQ2J5YXE0?=
 =?utf-8?B?bEE3YWJrRnBiMGhIQ0t0SlJ1VE84ajkvdTBnMWQ5WERxYjBYd21FeDJab0t5?=
 =?utf-8?B?R1FNUS9HMUFnRmF3WHBkd0hscEZqREJ1aHNSaGRqYmhIY1NhYlZMWjBtd0xL?=
 =?utf-8?B?dWpXZGgzdnVCblNGbUlnc1VjRlZFdmNLL0lVaGVLOE5pNStjRWovOXZUdTgx?=
 =?utf-8?B?ZFZxWGNTaENFYkJTcE5UL29PUTFiN1FLUGdiWmVJOFYvQzZUQm5uN1Y5ZDYx?=
 =?utf-8?B?V280MUYyOVNpWklrMTRIQ3JpQlZnUlI0TnV3V1ErRDBXMTB1dlNuZjVLc3Nj?=
 =?utf-8?B?QmtlbWZtZlltc3h1Z2FHTTVMc2JBRVo4Q281Q0NVZ1B1UjI0dnN6VWJUb0tV?=
 =?utf-8?B?OXF6OEdiNXY1MW1xQ3RNbzRONEJQOW1TMjlaYTFGMmZ1T3RFY0ZZTWxTSWpI?=
 =?utf-8?B?aDRUOXRYbXI5RXJ3c245UWtBRmhNYTExbWhIbkRCQStGZy92bDhuV1FxdVY1?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B582F9B560A9754A9A5B042C51F9DBC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iKYuWo/OKpQYdkwE5QfRsV41/3ajZea73gH3by4QhVrEPx8Il/F+nmF5+v1TgEmUs4r0O8JJRDUBJw9H+VIw2YEB6GlSeAFKGUvDhl2vst2DluC0Kw+nAGC7de9r2FM7q/263W1AyJ9j4HT0QsQI31kjkx+d/hkQq9QdFqgc5Kk5TbuBX80JGX/cSwBSRsil3h2yFThYhAHo/os8sfG7pykZCX0GY0U+mcKN94IO/uA+QPHOdfHE/wL3VpfpnuBzqCzUp4045kEhT1sn3RIJN3zOf91G/2JxGtW4wDOrTKEaF/c/GdPeGY5qXdXdinzJdXLUcSI3bkEKmPpxSA2DQlIB0ads29d1ctutyWyV8K4s2wm172jVWI5Oa6RbQeRa27a6BlcAb7jkyV/qddHZA8InaVjmh7m5+sOf3VnkQniDHLB3alLkKIWZkBQAY0aqwfKMc43JgRWHGTJRuenVx0shfqpBbGrD4DOf+FGqoUSnXi3Ff7CqBn7exfj6KZt5pAEPUiFDqGuEhDJtMDsd6Bvn+43tPju8AzxyEtJ8kVTxjUn9UVriQGmJzm9dZvSD8/zkBzKDWZCuvnUy0fpohcFfEmGVQJ1EQZRSbLvSRcm17U6QE6wwvkEwy86hSW08
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f69e442-f563-4c37-741d-08ddfc8c721d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 23:37:09.6246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECWKb4oQ33GrUeKzLWQTmqC1YsHZeFaRzwiEJlftbhkSmDTDesIA/68Cki3CK631pLX//RGxUvM4PbCna1kkMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR04MB9717

T24gVGh1LCAyMDI1LTA5LTI1IGF0IDIzOjI5ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjUtMDktMjUsIDA1OjM5OjE0ICswMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6DQo+
ID4gT24gV2VkLCAyMDI1LTA5LTI0IGF0IDE5OjUwICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3Jv
dGU6DQo+ID4gPiA+IEBAIC0xMTExLDYgKzExODAsMTEgQEAgc3RhdGljIGludCB0bHNfZ2V0X2lu
Zm8oc3RydWN0IHNvY2sgKnNrLA0KPiA+ID4gPiBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBib29sIG5l
dF9hZG1pbikNCj4gPiA+ID4gwqAJCQlnb3RvIG5sYV9mYWlsdXJlOw0KPiA+ID4gPiDCoAl9DQo+
ID4gPiA+IMKgDQo+ID4gPiA+ICsJZXJyID0gbmxhX3B1dF91MTYoc2tiLCBUTFNfSU5GT19UWF9S
RUNPUkRfU0laRV9MSU0sDQo+ID4gPiA+ICsJCQnCoCBjdHgtPnR4X3JlY29yZF9zaXplX2xpbWl0
KTsNCj4gPiA+IA0KPiA+ID4gSSdtIG5vdCBzdXJlIGhlcmU6IGlmIHdlIGRvIHRoZSArMSBhZGp1
c3RtZW50IHdlJ2QgYmUgY29uc2lzdGVudA0KPiA+ID4gd2l0aA0KPiA+ID4gdGhlIHZhbHVlIHJl
cG9ydGVkIGJ5IGdldHNvY2tvcHQsIGJ1dCBPVE9IIHVzZXJzIG1heSBnZXQgY29uZnVzZWQNCj4g
PiA+IGFib3V0IHNlZWluZyBhIHZhbHVlIGxhcmdlciB0aGFuIFRMU19NQVhfUEFZTE9BRF9TSVpF
Lg0KPiA+IE1ha2VzIHNlbnNlIHRvIGtlZXAgdGhlIGJlaGF2aW91ciB0aGUgc2FtZSBhcyBnZXRz
b2Nrb3B0KCkgcmlnaHQ/DQo+ID4gU28NCj4gPiBhZGQgdGhlICsxIGNoYW5nZXMgaGVyZSBiYXNl
ZCBvbiB2ZXJzaW9uIChzYW1lIGFzIGdldHNvY2tvcHQoKSkuIEluDQo+ID4gd2hpY2ggY2FzZSwg
aXQgc2hvdWxkIG5ldmVyIGV4Y2VlZCBUTFNfTUFYX1BBWUxPQURfU0laRS4NCj4gDQo+IFRoZSBt
YXggdmFsdWUgZm9yIDEuMyBpcyBUTFNfTUFYX1BBWUxPQURfU0laRSsxIChhZnRlciBhZGp1c3Rt
ZW50KSwNCj4gc2luY2UgaXQncyB0aGUgbWF4IHZhbHVlIHRoYXQgd2lsbCBiZSBhY2NlcHRlZCBi
eSBzZXRzb2Nrb3B0IChhZnRlcg0KPiBwYXNzaW5nIHRoZSAidmFsdWUgLSAxID4gVExTX01BWF9Q
QVlMT0FEX1NJWkUiIGNoZWNrKS4gQW5kIGl0J3MgdGhlDQo+IHZhbHVlIG1vc3QgdXNlcnMgd2ls
bCBzZWUgc2luY2UgaXQncyB0aGUgZGVmYXVsdC4NCkFoIEkgc2VlIHdoYXQgeW91IG1lYW4uICBJ
biByZWdhcmRzIHRvICJidXQgT1RPSCB1c2VycyBtYXkgZ2V0IGNvbmZ1c2VkDQphYm91dCBzZWVp
bmcgYSB2YWx1ZSBsYXJnZXIgdGhhbiBUTFNfTUFYX1BBWUxPQURfU0laRS4iLCBkbyB5b3UgdGhp
bmsNCml0J3Mgc3VmZmljaWVudCB0byBkb2N1bWVudCBUTFNfTUFYX1BBWUxPQURfU0laRSBhbmQg
c3BlY2lmeSB0aGF0IGZvcg0KVExTIDEuMyB0aGlzIGRvZXNuJ3QgaW5jbHVkZSB0aGUgQ29udGVu
dFR5cGUgYnl0ZT8NCg0KV2lsZnJlZA0K

