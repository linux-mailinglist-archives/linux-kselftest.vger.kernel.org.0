Return-Path: <linux-kselftest+bounces-30522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5300CA855CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C428B3B5D5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9B28F931;
	Fri, 11 Apr 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMpz9zOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8C1F0982;
	Fri, 11 Apr 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357583; cv=fail; b=TsVSwRNXOTJVarhDzcuiG++opIOepLRCrh3F0F5ZKEqJOsb7bU3Ue2Hj93qumfdzBaBmFsoeKkDd7I3p+RYgdOGhKLfx4rSxt8hhpdETo++JT2/3Lpeiunvjav4q0v9yWXAWayPt6O8WeKjhrAgkffOBXsFaWSPWqr7IwWmJBe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357583; c=relaxed/simple;
	bh=De3Ym0UHRvVD7ZFwHqfSqBJptKVez5LkAShdewMeCjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awdcv19hJnoBI7ZHu75zPSzrkzyr9/DOJoVkfTmLO7HgwldmLdXOINA1bOBCssfaeoHM+oJ6TGNrjaAHlk2slHcRqSNEQ6gE/4jbFVtUCm3KZahAdUi+a5rKZTK3Vjjw6miTIQ3AoUGPPDGe2W4GoY5bo/Wj5GVHwupue515pvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMpz9zOE; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcTmj1O7ZrhmglMlZKxj81VTeSAmfjswnc3pqIuG3ybdUoV+tSjcxk1RrdSKCpKADVUc54n/by8stAIyHCML8EyedOxlIG16eohwrmto6uY7pfsm/Flep/hFvhB0J+wvUjVWzC8k63LgkuXdUHXZKCER/H+6fwK+mPxZ72MY8d7EmN/JNQ0yXCc+PgHk4bd6UigeoHwOC4IPwBQJ1TxZBw++ur/gCfAT7MBc+izC19WQohnn1I3AP5rwl2S1GOGt8FZgqWS0qfAznxeb5TWLNNht32nzbeAyNDrHUtApbKu/jupiqqTUTG6DmctJYX8Fy/sXfSX9zjh8+62xn3JeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De3Ym0UHRvVD7ZFwHqfSqBJptKVez5LkAShdewMeCjY=;
 b=SIxQVAXzpSiS6yaTkurc+6PCpyiWF+steSY7Btu2pfRDiAoTiODn2UXfol8M7zqtp0uoPNBCQTSC3cPtULNo4KPZbYOMECYsb7/BzaGuVzB/Owj8gtUuHcczcPPpWwin20Xq33Fp0cCDkD4lygvHBg9aVwBy0Or4mOSD+75mFF8BoHRtHfN8U5EQxAlWnaWg8NsDlPXydo4VVYvwyDUZhKHQ2Nli4GZ+CrHxuu1XecSh4g6iUEOc04ox6Nv4sjuWJ8SlPCtMBUfSP42CrJiPfRw0uRQJjc03uSAVRhAGEYeIqQt1B8B22+eDb0Ybr4flZGZeK3u8Yw7q4dIVOqkXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De3Ym0UHRvVD7ZFwHqfSqBJptKVez5LkAShdewMeCjY=;
 b=aMpz9zOE9dkmMC8p0KjStwBsMn3nfV/Wq1IoUYVKxQyzynXTgHnxpdbIvSYrzCt31lDcvYRE+j1/WLx4wijhkeG7EVbHA2VmvagZtWbOqYSEJlrjFuhNdTHB07KNvIehSpwFpHLiw9mrLxzcYE9e1PqEWuETa660i2dOoJzudW9TckOa5bOuLZvhBhav6Q1XDBq6UCPDSXeXDozvjD/3BDbbkY42e/hrTgAg1buvF/LvzK5YbVtqHDR1fHfn5ZFSTgrFDRInzxPSk5eORtuqUTnvgDJyAVAwcJRMPj3fSzUyEPunoQUJxVW4SV7jp6L6lNQvCQ1EC90ykfaBvNBysA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 07:46:16 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 07:46:15 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "razor@blackwall.org" <razor@blackwall.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"bbhushan2@marvell.com" <bbhushan2@marvell.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hkelam@marvell.com" <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "jv@jvosburgh.net"
	<jv@jvosburgh.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
	"ayush.sawal@chelsio.com" <ayush.sawal@chelsio.com>, Jianbo Liu
	<jianbol@nvidia.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"gakula@marvell.com" <gakula@marvell.com>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>, "louis.peens@corigine.com"
	<louis.peens@corigine.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/6] xfrm & bonding: Correct use of
 xso.real_dev
Thread-Topic: [PATCH net-next v2 0/6] xfrm & bonding: Correct use of
 xso.real_dev
Thread-Index: AQHbqV2YEvrYLsKl3UaINN5c1voHQrOcv7KAgAFSmQA=
Date: Fri, 11 Apr 2025 07:46:15 +0000
Message-ID: <a4b514e8a5bcbbe5dc1e6b6c9076b7a7afa57b45.camel@nvidia.com>
References: <20250409144133.2833606-1-cratiu@nvidia.com>
	 <a7989f85-7699-4b90-9328-9480297a1765@blackwall.org>
In-Reply-To: <a7989f85-7699-4b90-9328-9480297a1765@blackwall.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|BY5PR12MB4258:EE_
x-ms-office365-filtering-correlation-id: d3c9f103-4746-405f-82bf-08dd78ccf053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b05aempmWTJpb2oxem93VE1pSExSQU1FQUpCb1ZuRmsxVnQ3YnI4REVER21G?=
 =?utf-8?B?aFdaRDZuRFZIMlFpYXUybUwyb2Z1bDFEcmJvaWxHa2t4WGZUWE1WV0c1dC9L?=
 =?utf-8?B?ZUVmRi9ScDJZUXlOQUJtRjNXdFliNHlDcFZ3Q3BBYThKNDUrWFJpcm1Xakt5?=
 =?utf-8?B?T1RyRGMzanVOM2ttNFJ2ZFJuRmU4L3dXYVhTSk10Y3IwUTg2bWdPdTZGT1Ru?=
 =?utf-8?B?eE5WMVgzaW1ObTB5VUtjN3o5YW40MmVaT2l3OTJ6czZpTHI1VzdOQWxIRldu?=
 =?utf-8?B?Sm8waEF5N2tCeGkxdzVsQ0Ryd1JCS0l5ZXBEU3AvUGJPWVZDQ1R1ZlB3bmNQ?=
 =?utf-8?B?TmQ3anFISG1ZYVZScFBBWnA5Ty90eXp6YmVOank1aU5vRGFnSVBrYUVuZWZV?=
 =?utf-8?B?T1hxb3dWKytnbDBoSEpsc2tWdlFVMGZMNXpzemd1RzRCbFNuSlplQmlVd0R5?=
 =?utf-8?B?dVU2aGYvWC9BVDUxZ2VIYUhGSWx0QlJpS2VjS1h1QnFZa2hGKzU1U2tuNmx6?=
 =?utf-8?B?MW13L0cvYldQRysvTEN1RUtGVTI3dDdMdm1zWnpmSEpPWDBFZmRVNEROek1h?=
 =?utf-8?B?Rm91WWxJbERPOXFyYzJ3eUZaNlordHg3TlVEWHNLTzlzeEJjMnZYVDc4V3I5?=
 =?utf-8?B?TTZMbk5PcW53aGl1SkdCR3BLUXpmTnhXWWxoTVN5S29vZmhiS05UZnRodzZt?=
 =?utf-8?B?aUQ5OFc1Sm1RVHU2akVYR2piU1Z0dnVPRHFKMjB1UDRUU0lwTXFsN3hLbWxx?=
 =?utf-8?B?NGc2YVN5YWVFR3FpUTJmU3VKZCtiVmpvUnhvSHpPU0JHNE5ZNUNUVG1wTkdj?=
 =?utf-8?B?UVdEK3VKdm9HYU9nMWZEVG5ZMml0VVVNUFlaV1ZVY2d6QjZ2eW1hZHg0UGp5?=
 =?utf-8?B?bkhKaFZXMURjWGNzeFRuL3VZUzJRTFhINjQvWVlKTjNSZDdKUkFHazJGcW93?=
 =?utf-8?B?eVh1RkJRc2hRejdwZkxEWWY5N3ZLeENCM29ieXBNbHVOR2RobHQ1Ny83TW9O?=
 =?utf-8?B?aU5UQ3cwRm9BbXNDaEFORmhLQ29sdGwreHdsdGZzVDBHQUowd1JXZkYwcnpV?=
 =?utf-8?B?V2NpdUQwcnhqRHhza1Rxbi9pcWg2bm5ORlZhNTEySmFiYTk2a1VtaDFSUTVw?=
 =?utf-8?B?NTR6TGMxQnJpQXpWYjhNZVY0ZnBpb2dlZmtWMTFaekxKRGZGbEtHbzhXZ1Zs?=
 =?utf-8?B?Y2RGaEp6b3JqNXVvWUp3Zk1KaVNBeUp1cDNkVjlRSFhkTjQwWTk4c0c3YUFw?=
 =?utf-8?B?N25ZSTBJQTFVcU8wYTVRNmFLSURFVzRMQ0htRlZXc0s5dDNrMHROYTgvTHFx?=
 =?utf-8?B?YWlxMndldVlseTVtemtDUVhwNFd2MnFxVXM1OVRNSnZlZWEvN3BHd3FFektW?=
 =?utf-8?B?VjBTYTc5UTNhenpxK1o3SDFyMFE2SkhXaUNpaG9nQnJxaUdaa3JvaUp3d1p6?=
 =?utf-8?B?NkJuUkhGbkFMQlpaL1NpbUZpa3pRbkxFblBVWGh0QUE5OG4xSFNaZEQ3L1F6?=
 =?utf-8?B?Q0FuT0U1UUs5RzZJUXlPZmdwakRId3g2RGs4bmpuUTh5ZWNyMXMya2xTdmty?=
 =?utf-8?B?T1lJQ3N1Tlk1VEtkdU5LRjZUcVkvRzA1ZU1vdkR0dUdIdFQwWkxxS3VwL1Nk?=
 =?utf-8?B?a1FQdytqSFlpQ0R1Zzc1KzAweFN4MU1qUEVQSnozQnJnMHVNTWg0ajJ0MTk0?=
 =?utf-8?B?OCs4N09nY3RvZFQ1TVU5OEVwTWxCWFluTWFyb3dONDJoZ280MENoMWZVaEtq?=
 =?utf-8?B?SXlNZW1INWxOK3JuSDdUaENrampRN1Yxcm1TNEZWZWYxL001SVpPL2JzeHd3?=
 =?utf-8?B?WnpYbitYb1hFWi91eXZxMEdkZUtrVWtTR0tSQ0YrT2VzS3h6SUFuclNGcE1J?=
 =?utf-8?B?R1FaZmFldTZPdWhGTUpWMi95eFZ5M0E1bWoxQzFjcWtOZG55RFZnKyt2TDIy?=
 =?utf-8?B?MW1VN3JBeDMyVUl6aElHMjRnWld5cGdrTTBzMlBFRXRNNW52ZTYxUTJqOE9a?=
 =?utf-8?B?WHZzRHFuMjZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1EwUXRIVHF1STZqUHNaRXEvS2ErUiszam80alMrbS9kUkJ2OU9KSDRobFZF?=
 =?utf-8?B?MDJKeTZpejZDQkdXWU9mYXJmT3d6SzdzT3JOSEZnaENVYXRYVGtPMDdoMVVl?=
 =?utf-8?B?eC9VZEMrWjUyR3dTQUlvUHNBQ0dEbFovZWlJUWU4WTRCRjFseUwxZmwrNk56?=
 =?utf-8?B?UVQ0RGdKazc2SWNBYnVNVzVGNXF6dzB2cW9ydXpsN2JLeUgrZHc5dTM5TmZT?=
 =?utf-8?B?cllLMWFleWxlMVhXMTlsZ1paVEUxdXRMa1BNZlJ5ajRmTXBBKzM2MG5QYjY4?=
 =?utf-8?B?OXpicEQveUlLWFRuS1Rsd2tmZHJRVFFjTHBJd285Wjc1VDhoMWdSb1UvanMw?=
 =?utf-8?B?L294Y3lHRVVncG9FZlBiUDNCcXIvdDN1MUFEWHFqSnBEYlJuenBWOEhmc1hx?=
 =?utf-8?B?K0d6Z0diWENwSEVRMVV2TkpBNmd1VU9Ha1FvTEpZWXgyZjlCMDJKbm9qZCtw?=
 =?utf-8?B?V0txNll4WHhlRy9LOHNEOGQ3c2M2THN0bi9RTlZ6L0RPSVFhU1RYdTQ2NUpW?=
 =?utf-8?B?MHRxYmo2SUMyYzN3R2ppWUZ6K2xhZkluUitjSFl4KzVqZWpxU1VEeUIzdWl3?=
 =?utf-8?B?b1B1dHJUcVdVVStZNjlFRHFCbXVnN2FXelArWFgvL3lzL0VxeFJ4R0JxTDRE?=
 =?utf-8?B?WDNoVmdxV3loTFFzTGROOFpnNVdGN2xEQUNRbWxkdjdWeSswWFMxeVpJeVJM?=
 =?utf-8?B?UysxcXZpclMwY1RVWDRRcWp4bnlpZTJqSkUzSERaeDA4dHBNMVd3WHRZYXN3?=
 =?utf-8?B?QlpzQjdHODB4TFhSMUhBeFVLQ0NqSHg2Vk9IaVRkeGJvZ3BVd3RsclRhSisy?=
 =?utf-8?B?b3dxQzBEUHFXSFJ3SnRIMHpwSVRNYlZTOVhCTUFnUisvckxuUU1raGl0MHo5?=
 =?utf-8?B?elVaeERiUTJ5UnZraVFMMjFkYlpHcjZkckZ5SFJVZ1RYa1NYdmZwc3NzOSt2?=
 =?utf-8?B?TlJ0N1g4Mi9VNk1KOFhkL2pVS2VkWW9tSWRqUEcrNEcwSE1nOVNmOGZ5QXdZ?=
 =?utf-8?B?RWlQbTBHQVJYdnhNZWxZZzN3L25USjZYNHNZekM5YWlZSUxlMmRkczFvampx?=
 =?utf-8?B?TzNOaGpwajZsSkVrc3NGTHl2eEpscjZvcUV2c2pvRDJLTFVsNGJQYmNuR2Jz?=
 =?utf-8?B?dlZ0NjhYdHVLeGZSSFpKS2JISm9TOThlbDVDSzdWb1pTcCthOW9QYkV0QTJ6?=
 =?utf-8?B?TDc5QnlYOFBBaDlnYS93NnFDSXUreGRSeDdwUVV6WFl1T2RtNlpuUVNpNVIz?=
 =?utf-8?B?amtvWVVkVGhxcGV1VFduS1JKVXl4dWkzMGxJaGowcDErWEkvRkVQMm1WQ2hz?=
 =?utf-8?B?eFREZG42SE9QQ0pydm00Y2JYaW1NSFpGakRKZXNmWkYzY3lOckI1Umd2OUJ2?=
 =?utf-8?B?QUhRbWxSQVhNeHIxeTdGWStEWGUyRU05SFpJa0d2WHNISllzRlY1NEgrRjZn?=
 =?utf-8?B?eEtaTUE1NS95NnIweG54a3QzR283bVRDQkdCR3RTK1Vhbm1rMys5Z0t2SVEy?=
 =?utf-8?B?a1VWVTdqNld0eDVta0RReXU3cTk1UnpnK2d6akhYUXkxNmlzV1ZCN3V5KzV0?=
 =?utf-8?B?SUVJKzFrdXNjRTYyWHpDVk1mZFdKbk5uZ09aOVFOa0pzRTBvdnhTVi9vckFB?=
 =?utf-8?B?dEg5QUhJZU9MamZxOWlVeCt6NXUwVVlUZHVPanRObUlvMlpBcG9Vc1lmQkhR?=
 =?utf-8?B?UFBjTHdYMHZoOEZsd3JDRDdLdEhsYlZNck5VSzhrVGc0akJEQ2ZZSGZ6U1l0?=
 =?utf-8?B?OUs2UEpsZmxoTjZjQzB2VXFweEluY1dkK01qNlN3U1MzMWs1bXFrQnpDTm5u?=
 =?utf-8?B?czQzaTFvVVV3ZDkza3FoMmxjL3lnb1A3TWtKVFluVWMxMWNuM1J2T2VKSzM0?=
 =?utf-8?B?TlVBUG1Ja2tlZGpkWHIxM09VaEdhL0xkMWQ5aXR2bjZiUDNmcFNPS2JBT2w1?=
 =?utf-8?B?SVNoYjVhQlU5d0FraDQ2ejA5aW1FaUI0SUpBdk5oWEVKd1JhRjcvaUhJY1hP?=
 =?utf-8?B?QUJkODNvOEVaMDRJbUFEajgrQm1yc1NRczlNcm9LU2FRSTRtK1Q4bFpzdFBt?=
 =?utf-8?B?bkRneitNS0dKdXcycEJheFU0MDE4b2lMN1hDT1RoUkQydVBreFJOaTYwcEtv?=
 =?utf-8?Q?ENjxqei5DIWLliZ2bPRwG8FS1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3EC280C09FA0E4E8A410B17ADA7DE03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c9f103-4746-405f-82bf-08dd78ccf053
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:46:15.7016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCHfh4ExKk1XkslYJNPSgCobf769AVzqpxdb4L4X9RezaA+zwbV0UpBZ2vasp7mgv109BqE4L62Bmdh8Z6/mJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

T24gVGh1LCAyMDI1LTA0LTEwIGF0IDE0OjEwICswMzAwLCBOaWtvbGF5IEFsZWtzYW5kcm92IHdy
b3RlOg0KPiANCj4gVGhhbmsgeW91IGZvciBmb2xsb3dpbmcgdXAgb24gdGhpcy4gSXQncyBkZWZp
bml0ZWx5IG5vdCBnZXR0aW5nDQo+IGNsZWFuZXIgd2l0aCBhIGJvbmQNCj4gcHRyIGluIHhmcm0g
cHJvdGVjdGVkIGJ5IHR3byBsb2NrcyBpbiBkaWZmZXJlbnQgZHJpdmVycywgYnV0IGl0DQo+IHNo
b3VsZCBkbyBBRkFJQ1QuDQo+IEluIGNhc2UgdGhlcmUgaXMgYW5vdGhlciB2ZXJzaW9uIEknZCBh
ZGQgYSBiaWcgY29tbWVudCBvZiB0aGUgbG9ja2luZw0KPiBleHBlY3RhdGlvbnMNCj4gZm9yIHJl
YWxfZGV2LCBhbmQgbWF5YmUgaW4gdGhlIGZ1dHVyZSBpdCBjYW4gZnVsbHkgbW92ZSB0byB0aGUN
Cj4gYm9uZGluZyBhcyB3ZWxsLg0KPiANCj4gRm9yIHRoZSBzZXQ6DQo+IFJldmlld2VkLWJ5OiBO
aWtvbGF5IEFsZWtzYW5kcm92IDxyYXpvckBibGFja3dhbGwub3JnPg0KDQpUaGFua3MgZm9yIHRo
ZSByZXZpZXcsIEknbGwgc2VuZCB2MyB3aXRoIHRoZSBjb21tZW50IGFkZGVkLg0KSSB3b3VsZCBo
YXZlIGxpa2VkIHRvIHB1c2ggdGhpcyBhIGJpdCBmdXJ0aGVyIHdpdGggbWFraW5nIHJlYWxfZGV2
DQpwcml2YXRlLCBidXQgSSBkaWRuJ3QgZmluZCBhIHdheSBhbmQgdGhhdCBjYW4gYmUgZG9uZSBz
ZXBhcmF0ZWx5Lg0KDQpDb3NtaW4uDQo=

