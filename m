Return-Path: <linux-kselftest+bounces-23130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09749EC119
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD94166A62
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 00:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1B3D984;
	Wed, 11 Dec 2024 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rilfHm50"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CF8489;
	Wed, 11 Dec 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878299; cv=fail; b=ajC/tJPRsvnBFGASMLlVrb75nb0JJNWEfPEbDRI3wVNWDn27A7bS+8wxmQHm1MtxsC1MuMK0Q0kacanCI7C5gFhVwk8+l42suI63gBcV6AY+dNMCDaKD+2YQhmQACpCuroN5hUDp2Iv1/G3AnnTC4dScsCOzSRFc8cECWUZWVWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878299; c=relaxed/simple;
	bh=bFEfAiKScjLpi2yRDgY80PFOySd6hpTr2443O3YWoHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+3EFR2U1ZVDWh3yZ2IDY1zf8o57dwvQGSuG5AwNcHYWXMAbO82AW4hyjxnlbXqQN+MsXiOwxyMjqr0CFTc/KN+hD9FPrWbmCUzXd2gqIAxCJoDii05hcw7oruxjYNHOkaQmAgiwdI3FDvIavVKUR1DMXEgG6UmYWdy3FNNJr6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rilfHm50; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733878297; x=1765414297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bFEfAiKScjLpi2yRDgY80PFOySd6hpTr2443O3YWoHk=;
  b=rilfHm503THQ87/fb4oeaKPV16ea3w0IlDM6m7lVR9RBLMFuJSxixrl2
   OMcxupordzAHrH1HFkhAGEqeBD7CoOvnyUcLGG5vaStQTM4lCs7WlxS6o
   vLW4RCt3R7rCj0ZSe21lH05Mbbv72bprgTPco14MfpGlx6734iDeXvbN4
   ivqYS8zPMurHV/6zSui2pEAAjRQ6ubxlmcsC4a0tPKl3y88PYCG8+Jlt2
   +DzsrEfEkbyRmwaYEfnBdSmKqfJhkyh6e81rXsc9qUhyIxvavA8aXyaSJ
   JPmHO05JKbV1KoSqOvNgmUZXukES9ylItSr/3V1UrY8ulc6Jat4pcQfDL
   g==;
X-CSE-ConnectionGUID: FXSq+FMaRxujDPiYNWPDOg==
X-CSE-MsgGUID: flj0EKUHRvWE2L7nFmbHsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="145628644"
X-IronPort-AV: E=Sophos;i="6.12,224,1728918000"; 
   d="scan'208";a="145628644"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:50:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COzxSzmI2nNd0xc4NCXcl7PQ3wHU6UaYexhJCNghtkr4bHAsIU2UPjCm9+Qx+rKA4Q80Moq/AD3upY14aI59ALw3YNEIo3XQ/cbs+Z4fqjf98U0B2Z7YtXo/9+6CQGHoGSRP1sQZ2larHUyW5QY7BhsrBkFNxwHTw3lCYRXDMIqMc3vpV5QPX+vohWp9HAhPY2xBakmPvEu7hr9BwXkFurOjfPF/TtO2IuRKVv807fUfxQhLMfJuiL3ILM0jWt7x5AdXaVPbN/lZaUfYN5Mpb7xQ4b4Qege3BOkmg36YLHRxqEw72py86TAUOgUyJ91zvXqwXNarsyxQhxVNJaKzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFEfAiKScjLpi2yRDgY80PFOySd6hpTr2443O3YWoHk=;
 b=KjrlJDPXaJZKzZcDlhbL63sa4XETQ+KxljG+Hire15A+deKUHs/CUfQaoSyJHh/t7vRytnOnj3DwMAEWJVm9GcDDbYnCfMx+zOGx+csoq6bKMLTColQxdaBhp3zRYdBWsYMJ70/c+ZAgOQzeebLVJL8uOACDBSXJqasYkMoXLAN+ZdbogdYNqnfgjKGykODEiUDI31OekVCamkwJHREfiF6+qLWBY2qIrhgz2qsvnUFmYGzUrdOHGxcJ2J8X6du0Vg/Punihrr1e7V5J79tmxNaceBBAOm09/LSalP63MlumFexNIhgnaxc/gnifK5Py1AimfqWjGZghO9qmXYSmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB12881.jpnprd01.prod.outlook.com (2603:1096:604:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 11 Dec
 2024 00:50:21 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:50:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH for-next v3] selftests/filesystems: Add missing gitignore
 file
Thread-Topic: [PATCH for-next v3] selftests/filesystems: Add missing gitignore
 file
Thread-Index: AQHbPLFG/gafrAt7lEeNWNsnX3LhQrLf004AgACAnIA=
Date: Wed, 11 Dec 2024 00:50:21 +0000
Message-ID: <a8b0a496-4151-48b2-ba14-3deaf2fc8597@fujitsu.com>
References: <20241122073725.1531483-1-lizhijian@fujitsu.com>
 <57d11b05-d2ac-4fb3-beb2-cd1f45b38596@linuxfoundation.org>
In-Reply-To: <57d11b05-d2ac-4fb3-beb2-cd1f45b38596@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB12881:EE_
x-ms-office365-filtering-correlation-id: 4807f2c2-0170-4a6f-479b-08dd197dca43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDU4anVQSGl0T0d0QlNCUTRxejBlS05ZeFR2c1lQVHlOT1Arc2I0T2FIS1hn?=
 =?utf-8?B?azZ2eDNqOEpDcmFQSDNKTE10aGhuV2hzS1RQQ0NsU2hUeUlEbktFTFYzL0ZX?=
 =?utf-8?B?RFRyOXlOWW8yUDVmOEsxN2ZNVU5SVWtXc3huWnhzM21NWThQTGw4WGIrZzN4?=
 =?utf-8?B?YXZSbWU3K1BYd1Y5Z3JZY1B3L0ZYS1Z4d2F0aHRIWU9XSXYvem0vd1hOanA3?=
 =?utf-8?B?TzRnNERReVc3bWFEOHUySEVzaVp0eVU2bUlzRllCcisraEZNS0x6VzlwQm5R?=
 =?utf-8?B?ZXBKd3RCSnAvbXBXeXUvTm91SnBqT2o3UGRlKy9aQTVqT1lVc054c2lUWDhG?=
 =?utf-8?B?SWxVd3NFQlZjeXVpY1l0UFZpelIyelQ1MEhpQVNweFJsd1ZSa3RtbFF3N0oz?=
 =?utf-8?B?MXlscjl4T0tBQmxVbWNueU1OaUhkTkUwd3JNTFRVZmRWQkh4RzVkTTUybEVu?=
 =?utf-8?B?RXZ2bnRHaGlHZ1g4TWI1MFVBUnVORWdlSDN1RVNBUkRzd1NFNTNBK3V6QVVG?=
 =?utf-8?B?cUhKcldBTG92dSszVlNYWDcydDhuRFdVTWlFd1h4SWxIN0FLK0pvY2cxai9S?=
 =?utf-8?B?YUplUFNOWmNRWXBZQzdTaldxOWRaajM5MlZXUHBYWS9LeFVWQmZ0bmVJQkJF?=
 =?utf-8?B?OUdIL2hMT3ZOY281WGMvR1pTSTBWdE94ZkszTlpqQzNydEY5QUlsUTRXakJ3?=
 =?utf-8?B?aWdzTkRmVDhaUFJhOTJrZnpvY3ZOZGRSZE5xK2U0WURtK010SWR1L1cyYk1W?=
 =?utf-8?B?cHp5R1ZIYTVZQkZTZ3VpQkNxZlNWaStOUWc3cklrM2szbkJrbk5naFl5RmxW?=
 =?utf-8?B?NmdWaWFmdzZ6YkJ6Vm95R1NkdHJyaEJ4ZDJYQU5uNit1cW5FNnpoNlkwOCtR?=
 =?utf-8?B?d0JGQWMyM0pBVDZxaGo4NVIyZFlzWGtlWHBzby94SVd6cFlQU2lUQ1A2L3pW?=
 =?utf-8?B?QmJhNmFwWlBjTGhUeHUwSVg5UE41UEZmdTJMWXI1M3JJMkxvc3VZNER0WEVx?=
 =?utf-8?B?YkY5QXNmT2hsbEo5cU16R0tKVmJOY2sxOElnOUhJcGgwS3NjbmV5cTZ2a2Zv?=
 =?utf-8?B?by9tbFNKUlFaVDF0NHZaZjhpQ052K1N4MGEyOXp6REFsQTFNRmFkOUVkWVZC?=
 =?utf-8?B?N2IyOWxLREVUVFJ6RlhhZ3gzYVM1NUtORXBTcUVzZmwydk9NdXBSVzZQdHNO?=
 =?utf-8?B?dW5rRTlaUFMyN05zR1o1TnhKRDY0UGVUVWdoenkxSWtwYjFtM2RpVzhTTTI1?=
 =?utf-8?B?Y0NFaldvLzl3Ky9VQkQ5bzh1Z0dRZkRMVy85bm91NzY3N2ZJdTlZYzZTWTAw?=
 =?utf-8?B?cloxdHJRaUx5WHBzbm40Y1BCSDZCNDZ4VmNHNi8wb2dzVWMvZ0JRQkxxQWs2?=
 =?utf-8?B?NDE1MTY5VlpLRGR4TEgxbGlWUU9wUVpsYTNyWlVyNW9ubmpOQlpobExOdEEy?=
 =?utf-8?B?cUJNYWxrVWpwZ2VXZFdwbzlCaXJKR2NjVVVVZ2ZOOCtoMFNIbHVySkd6aDJy?=
 =?utf-8?B?TytWRkNaZXhQVUNLRyt4VTZLakJTNjdsVnFKRmhUdkJBd1FDQlkySTNvTnJP?=
 =?utf-8?B?Wk5QbDVxdENpWmdTMFNBa3pCZXhRUmw3Y2RuVjgvNFZ3SDM5aWl4dm9yRGE3?=
 =?utf-8?B?QURRVmZGeFZWb1VnaFhXV05yWGJnVXJrSmJSS3E2K3k0V0xubDRqbDRBT2Fr?=
 =?utf-8?B?N3h1ZEdMY3BaMHFxR3N1ZkgvWjdGNFYvZThBTW53YWdwN0xVbnFCVEFtL1dk?=
 =?utf-8?B?bUI0cGNGdGZPODdKZWpOMHpzUDVOVmdWNTRkVmpwLy9xWEhzOHY0NWhDSlht?=
 =?utf-8?B?Q2JwcHZqeUl2WFZHQ3U4bDA1R2lxeUZZbkJRSVVLT2dCWnRrSkRRemp4d1Vt?=
 =?utf-8?B?Zlg2WXJzTDZIbjlOSkRjTEJtY2lBdnY3c3k2SEJFeTZucjJUckZhb2ZXN1NJ?=
 =?utf-8?Q?5SJoQw9FT9XP3n0mNFpN1kRyMNnikNWS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzFKb1ZRbkUra2hiNmhidFJCc09OdmxPYmN0SnZsU1VvdFdrMDlNc2FCWlBr?=
 =?utf-8?B?Ri90Q2w5R3lhczh0eXUwdXVteUZENkdwUUsySWVNMm53dmxIQVZRbXhHUjFy?=
 =?utf-8?B?Z1I4bVEzektJSGNuZU5BYkgrV1N6SHBld3lvTUYwM2xqdkxhZk9QOEhBZ1dG?=
 =?utf-8?B?TzFDSUYrOXc3YmRLK3NVcm80NVp3L0NBYXpKZnUwTmxJbUg2MDZmVkI2Z0k0?=
 =?utf-8?B?WkZoVDNlc0VYMGNSc01aUHQ3OURKMGdRRnUvdXh5Wlhnbkd2Rm5zMGMyMFpo?=
 =?utf-8?B?ZGFNUEtOT3FMRVVkcjhGSi9aQ2x6ZjVWVW41MmN1bFRGdXlQdGw4ZGdJODBl?=
 =?utf-8?B?SkVhVDlYM1VESmlKWkVEcjVRNkVvemxXdnhTODJXNDlvd3hKK1ZkQ1Q2UmFE?=
 =?utf-8?B?dUZLQ1I4TTg3UFRHOEZxRmdpd0ZqYU42cTRxTThXVmloV0E4VlFqcTBtM1pr?=
 =?utf-8?B?VUtLQnhXV1pqZldtc2IwUFpLWmcvMC8zL1huY0ZhcmxhVmliQVNqK0RHTTRs?=
 =?utf-8?B?cS9WSyt6Y1hwTytRUjFCSldjT01BM2VtVXlDUDhrWHZuV1JCRWdMYVpENENz?=
 =?utf-8?B?UW9mV29lc3pOQXhZaWM1L29DbmZST1ZjNnlSV0JQTCtzZzhBQis4cXhEeWtV?=
 =?utf-8?B?cDZUM3pHQ0NVZWFuRzVVM3Z6ODgydXNabC8vQlNFQzl6UVNma2w5TmFYbjVB?=
 =?utf-8?B?Y1V4amZDMWZuSlBHM1BmRVMxUjBQVWVZOGp0cFVRT0k3Q2o1TmdWNWpYWFdV?=
 =?utf-8?B?Yi92SEw1bnVpdUc3VFRoWEt0NmpFOEVPNkpBVGNIY1hzbUJmUHpmaFZRY1BV?=
 =?utf-8?B?dk9DUjNpdGIveUtEYkRhUmdkMkpjVmcxZncxVUN4cFEzTTJpTXRwUk43UVAz?=
 =?utf-8?B?RmhlaFVaUC9Qc1huY2ltOGRJZTZRS1hQVGpBWGQ2M2hUcVJCdk4xVVlOWmYv?=
 =?utf-8?B?K3hNWFByeXJlbmNFMUR0REYyU2hENVQ3c2x0MlQ0UHZBQm42bW5TQUttdkcz?=
 =?utf-8?B?b3VPY1FIMk10Y3ZRTjQ3VktTMFNVbkQ5NnU5aTdUcTBGYW5Wc3BMenRrUGQz?=
 =?utf-8?B?Q2drYUJoSEcrT0NzMjJmZzVZTElsdExxZU9qM0RjZFhHWHN5RTZsd2dISkhG?=
 =?utf-8?B?ZVNDSCtPYis0eE8yWEdjVzFaWE53RFRrNERPVjFmMVhrNWFJbUUxYWwxZmhF?=
 =?utf-8?B?R0ZvYk42ZEFkY1l6UGNlempUcHRuNERLWlpxSkcxcE14ZWRNWFllRkovc3Bh?=
 =?utf-8?B?V1RDYkt5WXJMQVhYdXA0bUppOUk0R1NranpZall0dHIyZkl0UlZ2RnRiQ0F4?=
 =?utf-8?B?b3lLNUk4UUJZK09pTHRQRjlrc25IS0owMGhGRGhKQVNkS21VeHJlVDkrNlor?=
 =?utf-8?B?Tk95b2NRbFk3U1FLT3RmTkRzZzQzTjVvNDd1NUI0MnVkOWZmSVRSMzhUUnM2?=
 =?utf-8?B?M1Mwa2ZSTXVwZzNnbkEyR2J4M1VZRGNHWUNqelZ6QzVvTGlGSjBxRDhTV250?=
 =?utf-8?B?ckJYWFcwdWU1b2dZMWxpd3hTWlVFVG51UkhmMTlQd3dpc25QZEk3MmxQR09O?=
 =?utf-8?B?Z0MwaDdQZzVRZ21YVlkrOW94cDExZXZTcGN1dDRxRnViRkhqYmI3TXk2aStP?=
 =?utf-8?B?WFR1dTlrai9jWDVobTE2dTE3a1ZsR2FwV1ZiY3Z4YjdWWmRaYnBzSXNFaDZ1?=
 =?utf-8?B?eTZSa3A1Y1E3SDVvbUY1OFkrSWVxOXdlTmw5SkFPMmpHdXJwaWRLRFlCWWFr?=
 =?utf-8?B?S3VyZWZLYmt2dEFCUUE3QVZPcWNPZ1hUZHh4cFJkOUNrKzRqU2t2K1RBR1lS?=
 =?utf-8?B?aUVVb21vdmFHak1vcStNNHA4aHp4NGdsamF6d0dnWUlwVHBuZzg2b0c2SUYw?=
 =?utf-8?B?bGYySXRuRlEwVkJIWElMY2gxQXBjMW5YL3hYMWNFOGxZK1E3alRIY3g2QmlK?=
 =?utf-8?B?MDh6OEMwMWZSWTAxVXdnR3lQemh0QkxmTXRMRzgwTlFzUTBRVm5tL2x6TlZU?=
 =?utf-8?B?aDZOQjZ1dDlBZkxHbDRzMWl1OHRaSkV0RWFwM0xMNjJsVGdtNkFtajJWVEtq?=
 =?utf-8?B?WG9pTzljV1BsTVVESXR1K1k3aUZwY0xGSFRFbzlnVWU0VmhWK1pIaEQwTXVK?=
 =?utf-8?B?MHRETm90ZDVVcGJEYU02a1pDUzUyMEc4U2VINzgwWkk4L3ZNN1AwVU84aG40?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AECED3225E41304898FBDE09E88FAAA3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wr/QC09w5+KVOoQcxWfyH9J6k45Jm1KxLMTpHqjQKZ44315o2QFFOwrZSxIqoPJXVt0aDHdlntFY7O1jU9g5Z8DycH+odn05nJsnro7cNtj8Z6N4n1kiYq7SqhlA1K2vNEg+0vvFjHxS0a/xoCf2u9Vvilgg21H9tE0YrASOeoaal8qfGgczDnl44nOTGlJHmucPrGPt5yOgiFntb21pnGEUUYNQ5AbsQzVKDREMIqaKaZcFc/wQfAaw46plwPnokBzEPDdCM6lQo8YVd3ZuSjyQqyKbeASBBe9cVrcaQbsbp1lc9z3gjhDpb6TLCPzDSmDsPAsCN8YUjbz5oT983OMqQzX7++RqI9nrQ0blg/meJ/fY8C5U5l9ULICF2chEgs02MK0NK84io1EcDfYFUwp44bi8GW3hvtLD50/Cs0GwU5oKLRDU4TIEM62zRGfvNR1+eO2UcFHiS0dUyC5GJkNQH1I6SzYsxZFb9sRTc/plPA7sA6NX0OdC9HMRVD/KK7YuL60ITe6bGRXr+Vv8rBLX9LISLtXLWjO6806EHfwM/uCmepPe8vJ7hlXN9eJchwlYbAlgq48k9gEMFtQriODBy5aBRU2U7DTsQFfVPQprq0APNaC3l4FKtO/CjLMo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4807f2c2-0170-4a6f-479b-08dd197dca43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:50:21.1044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebW0n8a8+YrV2J+VBskg710MvxFTMsfzYCF/JLNXZaUPP3iMnjWNuoi/u7uJ34RWLr5zYDZ9u1qUGHFzdAkbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12881

DQoNCk9uIDExLzEyLzIwMjQgMDE6MTAsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDExLzIyLzI0
IDAwOjM3LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gQ29tcGlsZWQgYmluYXJ5IGZpbGVzIHNob3Vs
ZCBiZSBhZGRlZCB0byAuZ2l0aWdub3JlDQo+Pg0KPj4gJ2dpdCBzdGF0dXMnIGNvbXBsYWluczoN
Cj4+IFVudHJhY2tlZCBmaWxlczoNCj4+ICh1c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0byBpbmNs
dWRlIGluIHdoYXQgd2lsbCBiZSBjb21taXR0ZWQpDQo+PiDCoMKgwqDCoMKgIGZpbGVzeXN0ZW1z
L3N0YXRtb3VudC9zdGF0bW91bnRfdGVzdF9ucw0KPj4NCj4+IENjOiBTaHVhaCBLaGFuIDxzaHVh
aEBrZXJuZWwub3JnPg0KPj4gQ2M6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5v
cmc+DQo+PiBDYzogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+DQo+PiBDYzog
Sm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiBIZWxsbywNCj4+IENv
dmVyIGxldHRlciBpcyBoZXJlLg0KPj4NCj4+IFRoaXMgcGF0Y2ggc2V0IGFpbXMgdG8gbWFrZSAn
Z2l0IHN0YXR1cycgY2xlYXIgYWZ0ZXIgJ21ha2UnIGFuZCAnbWFrZQ0KPj4gcnVuX3Rlc3RzJyBm
b3Iga3NlbGZ0ZXN0cy4NCj4+IC0tLQ0KPj4gVjM6DQo+PiDCoMKgIHNvcnRlZCB0aGUgaWdub3Jl
ZCBmaWxlcw0KPj4gVjI6DQo+PiDCoMKgwqAgc3BsaXQgYXMgYSBzZXBhcmF0ZSBwYXRjaCBmcm9t
IGEgc21hbGwgb25lIFswXQ0KPj4gwqDCoMKgIFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1rc2VsZnRlc3QvMjAyNDEwMTUwMTA4MTcuNDUzNTM5LTEtbGl6aGlqaWFuQGZ1aml0c3Uu
Y29tLw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1
LmNvbT4NCj4+IC0tLQ0KPj4gwqAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMv
c3RhdG1vdW50Ly5naXRpZ25vcmUgfCAxICsNCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxl
c3lzdGVtcy9zdGF0bW91bnQvLmdpdGlnbm9yZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Zp
bGVzeXN0ZW1zL3N0YXRtb3VudC8uZ2l0aWdub3JlDQo+PiBpbmRleCA4MmE0ODQ2Y2JjNGIuLjk3
MzM2M2FkNjZhMiAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVz
eXN0ZW1zL3N0YXRtb3VudC8uZ2l0aWdub3JlDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9maWxlc3lzdGVtcy9zdGF0bW91bnQvLmdpdGlnbm9yZQ0KPj4gQEAgLTEsMiArMSwzIEBA
DQo+PiDCoCAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4+ICtzdGF0
bW91bnRfdGVzdF9ucw0KPj4gwqAgLypfdGVzdA0KPiAnDQo+IEkgYW0gc2VlaW5nIGR1cGxpY2F0
ZSBzaWduYXR1cmUgd2FybmluZyBvbiB0aGlzIHBhdGNoLiBQbGVhc2UNCj4gZml4IGFuZCBzZW5k
IGEgY29ycmVjdCBwYXRjaC4NCg0KR29vZCBjYXRjaCwgZml4ZWQgYW5kIHBvc3RlZCBhbiB1cGRh
dGVkIHJldmlzaW9uLg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQoNCj4gDQo+IHRoYW5rcywNCj4g
LS0gU2h1YWg=

