Return-Path: <linux-kselftest+bounces-18268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A2983C68
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 07:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D80B20EA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 05:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5342A8F;
	Tue, 24 Sep 2024 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aEibO+SK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314D2E859;
	Tue, 24 Sep 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156291; cv=fail; b=j3iHxEkHeQg84e1wBbc43fKaxP4Xfse/hlnjzvYWFGuEGF/4dj6ix7879jTObkcwHTI0bYdsiWgLcL8ZxuGtYch5b7Vdl/bAOxja8YTN2m0rRL8cE3PtlPZ2PHVx+DfR3nJ64YoOOdnVPoU80HBkv7Eiyt+uoLWo98BrmaJCV2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156291; c=relaxed/simple;
	bh=iWeHYOkEHdfZUZRbZzNP5WgYUqYShhIUPKcADkKyDRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VpRzS8sdsSSSiVLb2qivAmy9kZuVM+U2yTwqFbEJ3ooLxEGAGluiuc3RUxIYhNUU4xrji0eUwpQNdzVUiEmT+/rcN4hApDX4qhnGedOE4qaOJD+weuC9xM4nQ/Jx277xqgp+9ZKHa7/JSIXuQM3vddb8hTrmJcSs/AhqD/MwIyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aEibO+SK; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJTunqjaA4uhxDPIIeFZVWtnk6aNphbGmOaI5HrtXwRVKtLvjN7oGarsOSs740tLJYu+yzpwUf/7XGpQuW+baa1Ez8mBwKjaXOlRRDDnXtBhjBRWt5Nqi65XXKfLp2IEY+4OBk0A+hg58qzg/DgQobKto0x5DTWg/hG7payY1Tb6Yln45RC+0IXL2PWrC1FFUy05FMryiQQPW/vlIOrZA44Bpx9Gec7vqzyODL8qV1On/VTL2ZEjX/bHCuvZovTBN+4oPo6QYBdtDhw1ZNf1SGmnn35Rm9a4YrEaMILf9l5ut9y0Bkhfqy/uC6LlTQyLlisChkf3MLv+LQLpgCswfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIkFgwiNWgrY+5tC9pYdxh4q6c/acw9YDpYngqrJ6qI=;
 b=mONgKkbmcb4r6wlLvV5Csr03epjdcBg7O8/3wvbPW9uc3TI+nC8PgUMlPqu/8mE3299Xf8lYzJ/NOS4GL24Gjv/t9W1St8MKZTigx/J5c/AIg+XEBwycg+FitcHBor8+UVGY+2H79qdfm+ZbhF/qiVsikjpgwz43zNqh2nH3VMUh8F3gac46/J8cmugpe4ozPI0Hv7gEB8p+TFbobGte1p5ZFCqgAnQGQMT/gXSyyDjFdiklLo53cxHWW0aCSMua+o2w7sPmsHw5b/M8a3dJsmGpPRPdiXL4zzZYPqIbh3O3JbPE4wDagZycrP8DIxXvXcMfqghne6cW921BrF8OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIkFgwiNWgrY+5tC9pYdxh4q6c/acw9YDpYngqrJ6qI=;
 b=aEibO+SKUwJM96mt5zaOQaPVnkqI9BbEJJLz0x44GDvHcKeVyxINZCpI3YTTmIjLaS3wrpy8e812saUl4Fg1hMDgniEU5+TxjuoLNfi1dNAj7T+t8i74Hz+FVCP3jXo7oI7zFRtMpOPlkr/fTwULasGZ9BQexlq7A9Jol96Bu14aPD5z6s+93KVn+Cy6trqPBIklXimyTJUOj0VaSFIKjgv3ozAVhtSvtFzartXMkOLGTsn4I36EDOVyNv5EY2vS+9SFwNeIamfbTSDrG7VJUZekkvB/TbS5vlUpLA3ah4RSWflrBhAsuKCgimIsIf6eq2asCWwr2JDZRtrDnXiWCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) by
 DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Tue, 24 Sep 2024 05:38:07 +0000
Received: from DM4PR12MB6399.namprd12.prod.outlook.com
 ([fe80::a909:22d1:b276:7c12]) by DM4PR12MB6399.namprd12.prod.outlook.com
 ([fe80::a909:22d1:b276:7c12%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 05:38:06 +0000
Message-ID: <8c92ef18-6648-4348-9008-4f646d8b6956@nvidia.com>
Date: Tue, 24 Sep 2024 13:37:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftest: rtc: Check if could access /dev/rtc0 before
 testing
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 Koba Ko <kobak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-3-jjang@nvidia.com>
 <202406201937464fc96b1c@mail.local>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <202406201937464fc96b1c@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To DM4PR12MB6399.namprd12.prod.outlook.com
 (2603:10b6:8:b7::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6399:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc41fa0-2429-4d26-6763-08dcdc5b10f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUhnemJ4VEg5clhPbXpPT1Y0WDd6UFdZc05NWlZZTkxjTnNoeEJxUXprZmd2?=
 =?utf-8?B?aTcrTzVVSWJCV3R0cytIY0gwQjJoaHVhOXhIUURKM29qMHFFcHFFbzBaU01E?=
 =?utf-8?B?U3hkYXRIV0kvTnBxdVNJY0lrUEdNcE5sZlRYb0R4QngrNHFhZ0piUWlBaVR6?=
 =?utf-8?B?WU9SQVg4T085MngvaThEdGl2a3JhVHh1dkdqZWtQcm5sbjRvb0o4MGU4bVdY?=
 =?utf-8?B?U0hjcG5CK2Jab01iTmUyTWE1NGtBeHo5ZUdXbXI5QnZwa1dYT21Nem96MUow?=
 =?utf-8?B?c2pqOWpMa1Mzam5TRmRMQXlCOUpFNGsxazkxa3MwYmJNRkhXRWd6UmpIbnRJ?=
 =?utf-8?B?WFFZa0NyTlZjekhKbWF0cWI5ZkV5bno1NFFQQjNiU3BhYWIxaUNWNHBhbjRO?=
 =?utf-8?B?QkJ6SEJuM1RGS0g5SFVNQ3JFMElPRXllbUpnaGRweVR2bFBMSU1RSU5CQnFJ?=
 =?utf-8?B?eDdiZUk3U3Ewdkh4RVNhVjVodUNnYlJMaXlHbFRrMm04SWdGOGhDcUxVckU5?=
 =?utf-8?B?MEFZS3FnZ083eElvRENEcWZzM0dXcHlLWWI0bDZQWDdRR3djSGRQbm1iOHU0?=
 =?utf-8?B?bGJlOEZaekNhV2V4TkRSZjRPUjNCVUhIYjRnVlF0ZVlZRHVhdGJlemJhUkpw?=
 =?utf-8?B?V3BmQlFjUXNGTUsxRVMzNm80QTllMldEYzFhN3A2SkZoUmxEbFZqdGpBUHV5?=
 =?utf-8?B?ZHJlamtrNDc0aS9kZmdZd2U3TmpXZWRnd2JoMmhJSjFSNEdRYnc5bmE4NkVK?=
 =?utf-8?B?V3ZDR2ZVMGViRXdzeHhKQVdMaUgwMlVsZjJBYXg3dmNmeGd1VFBja0FtcFI3?=
 =?utf-8?B?S01jM3FvZjJlK1dHNjhiN1l4dy9RSmFmcjRJSXVsRWw5ZlpGYU9lMnlPTXVN?=
 =?utf-8?B?ZUZ4WkJWdFVzdGZzWlM2cGp3d0ErdW5KcW5MY1dQaEVyR3l4VlIxazlwZ0Fx?=
 =?utf-8?B?SHNiK0lmdnNWb2F4SURXMExiTE9LSUVHR3d5bjhDamhYNEVVMnNwQ0dlWndZ?=
 =?utf-8?B?MVFiWWQvc3lXQjVtUFZXQzM3Tm1FYTczL0crNE03VEUyZ2xLZ1V2U3ZKMkE5?=
 =?utf-8?B?UndTVUlWSlFQSitLRk5lenNzYm5KbVI4K2Y5c3RkTGYyK3NGSTNKMGFZN3dM?=
 =?utf-8?B?UVNQT0VhRlBxSWdmTXg0L1dsNzMrdzBnTmRyYXJhcUl4WkZjb3VXNWkzcUlU?=
 =?utf-8?B?QVJ2QU93SXpCK0Z6ZEY0cVA4RUExdnVhK3ovWDdFVkVQblpnQTQwaloxdzZF?=
 =?utf-8?B?RUVGaGh3NDRxcVdQTitsamJHejl5dEhMYjRLcm9CMUs4TVJIYzdlZlhOUHRr?=
 =?utf-8?B?bzd1K09tOEkvK1lFVUthbmorNjFNTlVEeEFrd1JjL1BNN2dWUFJ2SHNsbUFQ?=
 =?utf-8?B?ekY4RjlEUVpTUkxyZ3hGelluOVJGUGx6eFcwcHpISWZjNUJkMExnQklCYkw1?=
 =?utf-8?B?blFYRDhvK2NpRnFHQk85dXBtNzlnSDhRQmtkcitGQTBlNDJlTHNzdmlLTkxs?=
 =?utf-8?B?cXNjOHkwd211R0M5aHRFbGZFTzArTHhSQnBsUnpYRjkwZlpTb3YyTUxFMXAw?=
 =?utf-8?B?Tkc2M0wyZCszZWlHeENOa0ZIM0lkNVNXSXIrSjNFckNtdEwyU3o4a1dTY1Bu?=
 =?utf-8?B?azJFeHFGeENETmtpVzAyWmxVVWNQTTdWWFlvWEU3UmtKcDJvUmphaXpDdm1D?=
 =?utf-8?B?Z2VBUVYvWWJDL3ZvQXRkTXVGOEVCUHQ4cXhiclFIaFdFSklVRzVpbFh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2FJY3haSk1KR04ySFk0S3RrV2JzU1ZMTkx4SEZmaDhFbDR5a3RDQnNkMEhz?=
 =?utf-8?B?YUp2SUUxanR4WU8rNUMyWmhqOWdGcUYvL0RkeWpLMHpzWW5wekVqYTBxTDFv?=
 =?utf-8?B?a3kxejJxbVlSb0w1alJoWVlOKzI5RDMrRWxHcjRCUGZwWGpobENGbjhvZDRz?=
 =?utf-8?B?dnhGQitzN0RJUjUvOXpLT1NUT2drWHFYUld3eldoNmpySGFZUGRBcUE0Ykdz?=
 =?utf-8?B?RGx0VEh0aUp6NTVPWTFldHcxdkVITVVBejhmOWJ6OEpJNnpJMFMvRnZtMHdY?=
 =?utf-8?B?UXRUQitVeDJhTGNMVnRGZzhhaitRZ3g1S05LV0RDRUFYdDhIcWdLMHlJVTBp?=
 =?utf-8?B?TTRCeHFuUEFCZEZVS2RmV3J2aGYxWDBTYkdmOER0VGNocld2RTJWS25VR1RE?=
 =?utf-8?B?VjhtYk85aGwvaTFZZ292dW9VODJHNGpCQUZuR3Q4ZzNlNERWdE9HMWFqb0Fa?=
 =?utf-8?B?OHpQN3k2NW9zMVdocExvc3VVUm9POHN4eDg2bDFvTVUzOTEwdEpKZ2JsQkhz?=
 =?utf-8?B?QThld25TL3lLYzJqOVVTNEpvVTduRzhWc2d2NHo2Sm5XZVNqRWtYOWdaV2tt?=
 =?utf-8?B?MGVXTitEUGFidVg1WklUYllrZmpnV3E1cTlDNDBIMStqTkptQ1lEU1FZNEFT?=
 =?utf-8?B?S3ExYmpTUnV1MVJyV1lySml1Vks1U1hwcVBZWWpTS3ZiUEdpbmVWUi80a2Zz?=
 =?utf-8?B?YktxaWlpNzhmb3owUGJFZFhON3JJcUxFUmpsOGYxMGxVeGhEM0RBRHBYRGdT?=
 =?utf-8?B?ZldkRkVZa1A3V3FRVENkUDFJSzJwYUpueUZtL210aW9sdThBVjZ0RWdQM0pl?=
 =?utf-8?B?Q2hoL3oxaWhtZHMvUUllRkpDamYyMlNNNnlsbjJrRVRMcFYyQjIwVG0xdGFP?=
 =?utf-8?B?M0d3dmtXaU1OUW44enMxa3VRa3BQZmNuaGZZbzdvUXhFb2pLMEwvNGlwbXQ5?=
 =?utf-8?B?WTN1WHVSTmxOTkVuVjFQajZOYVhOY2g4bSs5cnhleEo0WUczZTJTNHJtMHFC?=
 =?utf-8?B?OHVJM1BjN3ZmUEtsSlQrSUlRbnlpL3dhQ2xTamNnYWFQQktiVHdzcnl4a1Y0?=
 =?utf-8?B?aUFwTmVuUWZJUGw0ZkRHN0hBSTRtTDdJYWJ4TTRHaDNMc21LY0c4RzBONXhu?=
 =?utf-8?B?em5JS1I0S3lYd0RHL0xGeEhBSzVaK2VrSVk3OWxlUHBJY1FhdS8yQjNVSmEz?=
 =?utf-8?B?MnExMEV0MUUzVnd1cWtnOUR6SGpramFlUVNWenNWZnRRMnBKYm4xY2dycXc0?=
 =?utf-8?B?UU9XRGt1SlJuVmJSc2YxZ3BFQWMvbmpkRUVYMVVZY0puV0dwUVRFL2tjZFIv?=
 =?utf-8?B?SzdPc3lRTkNCS0lsM3ppZXFwc3VWV2hMOHlUTGxabHRhcmFZL1dmVGNRRGtR?=
 =?utf-8?B?dThxTVNTTkU3VnJVc21lbFZUR2dKU1RLV01zK1N1ZDJ1OHd6VktWcWJnVklh?=
 =?utf-8?B?L3drTFcrRnhST05lakhpTXREMWJzS1BQaEZvYlFWclRYS3R2M3lNWU9UczRw?=
 =?utf-8?B?bHBnTXcxL2lMT0Q0YWdpNFRmTHN2dUVTeVdjZkNManJRZ3UyK0JZWG82MVZL?=
 =?utf-8?B?MXdOMGJjUXk3N1lYOUtqVzJhenFxVVBOZDdKZWZUdDFtUklXQm5DSGJsSEJW?=
 =?utf-8?B?ZDB0VTJKMnNkZTN6REkxRmJVUGM2LzBkRUtGR3pheCszS0hRMHQxQmF1RGJm?=
 =?utf-8?B?ZjVNRTJPbmM4OTBkcEsraFNuSjE1ejhTU25obEFnVXI3TVBjK1lGQjcxeGtu?=
 =?utf-8?B?TnpSeW9GTVBkZlZvWkdPZ0lpSnlGemFXd1FNSUg0TlpxUUwrQkZJb1c5bGg3?=
 =?utf-8?B?ODhBa1lVRmdsbkY5YjhlZmUxZ2k1M2x1cXE0WUNQZkFFOFFBQXczblQ5Wk1w?=
 =?utf-8?B?VmV0SEsvWTlqbk5na05SM3JncGthRjZMVHlzcGxQYkxrbzFyM2s5aDhNZzNW?=
 =?utf-8?B?ZHNuaWIwdldOYnB3SEhKTk5ZR3MyRTlYZjd3RkFjT0FWa2dRMm1raytvR3hZ?=
 =?utf-8?B?SUpPNFF3NU5lbXBFQUZyMlY1YWd3dlFibU9XRDhVTExRUW9HcUovR2crNjRu?=
 =?utf-8?B?Q3hqV014WXB0VGRtWjJsRVhISm9aeXFtUmhZWHF2WlVPQjQwdHd6K0hRTjhx?=
 =?utf-8?Q?ckglvZbvzhyhUu9JhUXO2Xkka?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc41fa0-2429-4d26-6763-08dcdc5b10f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:38:06.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFlEPQ2JikwBZjf5SEtFg/zvdrFt3SXWhIi7sWZ2iDuFycodbFydvvJsuuWj5gSMRsjIdK0rzvRS/rpWicHB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

Hi Alexandre,

Thank you for looking at the rtc patch.
I saw you Acked the [PATCH 2/2], not sure when could we see the patch
in kernel master or next branch ?

Thank you,
Joseph.

On 2024/6/21 3:37 AM, Alexandre Belloni wrote:
> On 23/05/2024 18:38:07-0700, Joseph Jang wrote:
>> The rtctest requires the read permission on /dev/rtc0. The rtctest will
>> be skipped if the /dev/rtc0 is not readable.
>>
>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
>> ---
>>   tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
>> index 2b12497eb30d..d104f5326cf4 100644
>> --- a/tools/testing/selftests/rtc/rtctest.c
>> +++ b/tools/testing/selftests/rtc/rtctest.c
>> @@ -483,6 +483,8 @@ __constructor_order_last(void)
>>   
>>   int main(int argc, char **argv)
>>   {
>> +	int ret = -1;
>> +
>>   	switch (argc) {
>>   	case 2:
>>   		rtc_file = argv[1];
>> @@ -494,5 +496,12 @@ int main(int argc, char **argv)
>>   		return 1;
>>   	}
>>   
>> -	return test_harness_run(argc, argv);
>> +	/* Run the test if rtc_file is accessible */
>> +	if (access(rtc_file, R_OK) == 0)
>> +		ret = test_harness_run(argc, argv);
>> +	else
>> +		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
>> +						rtc_file);
>> +
>> +	return ret;
>>   }
>> -- 
>> 2.34.1
>>
> 

