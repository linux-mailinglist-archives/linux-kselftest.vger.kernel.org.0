Return-Path: <linux-kselftest+bounces-27585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D862CA45C99
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F05B7A9B6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BF1C8634;
	Wed, 26 Feb 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aqtkAbL6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734901A3031;
	Wed, 26 Feb 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567952; cv=fail; b=KdJrS67LhEu+A71jxq3YMqB7Tsc11QxpirS7Jj53Z8qwGjc7DVC/P0AAMOa499tNCMm8JjkAuW+ub9aKolRVEVJ0cTe0/Srd1iZnSLx8oPYAiNjtZG264MBDoqq5WmcxFxc4Li/gOVOhUFEkzB+t4p7gI/ssae6tM0guvHUFasM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567952; c=relaxed/simple;
	bh=1ZXtLAvItFg41Y+c/Gh/CuIUkxoaYkWLMs+Fu0knpFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jz8HkBdl9DqQwkryB0jB6ESNHBWb56RrVkSxCJhzE3uW1kIo0XR4q3RP2JLy62L/GLWnxqThsgZGQDAQ+E1WoM5dboLO6FRq7U7bGBOyiAHMNwyZzxzVsMWnuY+772Use70Cxu5uuLYmmIH5oLcsJeq93KVSIh59OpaihOYxMo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aqtkAbL6; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWF3C5GXef6QNw3IVp/qY/oJZF4D9mvUEx4KMpLnJvwNt61qhQQ14F0POxWkAAbIjcl7pxbbcM62x5FZXnUyQGkXVsOgGW85dwRrdGwD9xBF2+t1sOAq9RKRnZlR+MTDMeCWEV+QhYxso6paXzMR67QQ6QVq4VPNwIjabG9sSa7aylWaeWCe1lTwLBEdsHyDYYVdcBTynPKnLliruPJ7GomdL5dios22YmJR2L2yTM3rb0y968NkWHpRZ2NYIOVWe7bF19wwi0flyjjy8SOwAhYjIl6D2QV/0XMirwUCWB/K6is6t2NZLCjQrpw6nlHL25H5I2qnc0fhaK6DkmVKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZXtLAvItFg41Y+c/Gh/CuIUkxoaYkWLMs+Fu0knpFQ=;
 b=hsg1Lyon9ecUJeuLNMaeWgafD8ze1Vge0y9YRKEDEBrsIE0hr3jx8CJuJMTKWpyJLU6up7R/4xyaVfkMXp7w3lr7uvxvePM26lztU8xfSXZMh754BxNlpjVU6pvIgxlAVVFXJ2AsrpnnLCdNKeleq+ggnBRuxk0YW9dVbJXBk+zamQu1LE58Bl79nyp/CPfbmFidzIigyC1dK1MDRcbrKP1sggO+C77McsgZBb1+wKKhsWLgJRJbYjm3U5vmVXS27rFhteFWzbd4F4GLDwcdfjw4cFS6t3ucK4ifT0lmMN7G6eHzrWKGzwonh6Dq6bh5AoiXXtQjz8RK9qx3xJ62MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZXtLAvItFg41Y+c/Gh/CuIUkxoaYkWLMs+Fu0knpFQ=;
 b=aqtkAbL6JTZpn+h+0hxaZ0EfpsjURjXxy/8zerk5RR4r961bsq77152tRL5lnqkRTJzQNvNdU9iIKBzjDUU/4RZnrA5QOGzK++B2Gb8BzNxAfr4tgt4KAn+MiYR6IWT+EH9Ymcqqt/AbMurbSFLttajrqRMg2Z6+bM43BFQ/NssGrLJ/QpQ79YgdVqBdZcDdE0R1/16UMSCA3Rsgg+DgBJ7FqR3CkL+O/wmPO4NJJz3D9KJGac9Y/DOvLTpWA3RnLHtdfajTiyz/OPCf1yZ3WtEImS3olrJvFpulAjpVOnF7jLc0U0ZIMYNwHHXxTcWqei8wU0NAn4meHxC/90oVNg==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 11:05:47 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 11:05:47 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "jarod@redhat.com" <jarod@redhat.com>,
	"razor@blackwall.org" <razor@blackwall.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Jianbo Liu <jianbol@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Thread-Topic: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Thread-Index: AQHbh2ll1/r6krzjmEu6zwJW6lI7lLNYDFAAgAFMEYCAABWRAA==
Date: Wed, 26 Feb 2025 11:05:47 +0000
Message-ID: <0605dc53cdcee5ea71b89114f2318dd5d0a83276.camel@nvidia.com>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
	 <20250225094049.20142-2-liuhangbin@gmail.com>
	 <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
	 <Z77jc8AB3D2xWczl@fedora>
In-Reply-To: <Z77jc8AB3D2xWczl@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MW4PR12MB7264:EE_
x-ms-office365-filtering-correlation-id: 2133d483-1764-4a67-21f8-08dd565585ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RS9qSjlmQXM1cDRpTXU1SlgrdGU3VVFmSzFwM0FVTElPbVNCb2syZzE2OHdy?=
 =?utf-8?B?bWVNejZHYk1LY01YL1FaOXhoTVJwREthaXp2VUUrNk1lS2hFd1RFUVZTT0xh?=
 =?utf-8?B?QndUQnZYWjJQRTNtN2hxL0FFTmdXSFV1SDVxSzFtMHY1QzlFTzVPcm9qMHI3?=
 =?utf-8?B?alBzQzFKRUZMUnZQMHkxelBWZmUzYS93ejJQNGkrN1N1enIvMlFzTEpQbm96?=
 =?utf-8?B?ZDhpU3lyQTYzbXFpOVpwTEpjblB4N0dtQUVDOEtNbnFvV2FNT0xiSFdGdXpV?=
 =?utf-8?B?a1ZhSThramRyZjAvTUtlM1FzclFXVzFMeWkwaC9NcWthRk1kSFRuOExXeWpW?=
 =?utf-8?B?Q1BtMWZYc0lvVHQ3N3FtOFJrZkdXY3BDYkhTbXpPdURoWk5ZOVVkSVE4R1RX?=
 =?utf-8?B?TzNNZ1p5TTI3VkVBc0d0NmlGSTBzdmVBMGtjVkhRYmlpWllWVlFVaTNiMmtR?=
 =?utf-8?B?VGI2UlJrb1RqaTZBVHBad0FzSGtnMFdaTlNOSnp2WVNnSnVQRjA1QnhVbkti?=
 =?utf-8?B?R3JZUGNLRFZMRGk4Yk9IeHRYbjliaUxkTkM0bGJ2dCtSdnpmek0rTUhMTGxz?=
 =?utf-8?B?R3VJV2dTck5jU1dYd1hxYzh3aklBOWVOcnZTbzBYTkp3RG13ME1rK0lhcm1J?=
 =?utf-8?B?ZUtUYm44QVN1VUh6M2JWNWxNZThqK3ViQ1hJS1liSkp0Q3duNk9Ya2pVV0JS?=
 =?utf-8?B?SUhOMWZtc1gyTnVucDdPeWMxcXBoWHdUZHM2WVZWOEIyWFZxOVRmK1Rqb2p5?=
 =?utf-8?B?TU9DQUVZRDArM3ZpZjNOZWcxS3RNeFR5ZjlpV2Z0TFVzVm9ub2Y4WU1VVmZ2?=
 =?utf-8?B?MDZ0VTA5M1A2dmFFblNsMTNPQWVZTDREVGRvbFhJRVNDRWtxaHRmMFNyZnE3?=
 =?utf-8?B?akhYNjdNck16dnJIYzB0WW5qL1A4NG1ZVFcvTWR4T2dWUnVhbHFXVk5sdFRk?=
 =?utf-8?B?SERIVVJCUStKaWdtL2hxUHpURHc3TE5Gc0VZQXBSN2VnNWRaNmtiak1FbFlG?=
 =?utf-8?B?TWdickVVeE9pU1Z2V1ZML1RPRFBrTDZObmlMU1hCVWVCa0ZPOXpVeVN4bTZX?=
 =?utf-8?B?TTlWWm9WbkZqZWEzdHlFM3ZqalFScTNLcXBRb3pDMlBrRzdGYzBDVzl2ZE9p?=
 =?utf-8?B?Tm1TSEIydTI0WXdGK0hSYWlVem9Vdk5WOS8rSkFJRENzRldGN0I3UDJTaTJk?=
 =?utf-8?B?MGpOZk5Vb3JGdGlScW0xMzFWL0tIcWRkd3lxcmV6emJsNk9KL2lkc0ZMcDhu?=
 =?utf-8?B?aDhXUWZFSW1CMllUY3l0dHRFdEF4dW84VXgzWWFZbkdETjRsd1B6a2lndUVv?=
 =?utf-8?B?aDRRbFZ1aUVzUVRidTV0UmpXQ3NlTWE4RDNpekhUbU1vZkRKVXM2OWx4WWlh?=
 =?utf-8?B?ZXlaWnNlMUREVldpOTVwL3hJY092TWdTRGlEMDh5bzZ6YjY0WnhHU1BGTjdi?=
 =?utf-8?B?a2RIQ0loT2hBa1pTekxZSTBiMWVlNG5TUGNqakR5UG1yM1FwL21qcWhuWEx3?=
 =?utf-8?B?SytQeE9WN0cxRG1ZblVUMmwrSnFUaUk3QzJ0V1ozazdGSWJmNnR6MGVlS0dW?=
 =?utf-8?B?cmJyUkUzNmsxMWozSVM5bVRsckNkcDRxdzhNVndmeEhId2VEckZZTWlNNjhz?=
 =?utf-8?B?emhIUGVmbS9tNWdYMmNjVS9LNmM2aHJYZk5iVmZQUFQvcXJlb09BSi9pUDZ2?=
 =?utf-8?B?S29NNndiVEJTUWtDd2NCUC81NnU1Qmp1c0hrMzJ5Nm9hMzZxNTRZcUIvRDND?=
 =?utf-8?B?eHhCcXU5bnRsYW5PV01JTjJMeEVDaUlxcFhPTVdzMWt4d2NKVEwrYWVJdjdm?=
 =?utf-8?B?K2o4RDN5enpvajVRT0s4NmQ2a0FSQkJ4WWtwR3pwN3pVTW1FZFVEOForNWEv?=
 =?utf-8?B?WXJNUEN5Vjl0RDYvUmovb0JJZ1l0L3NXUGszQm0xdlRzczZxbWpha01OOUFR?=
 =?utf-8?Q?mvWmQR8FuFIn/V8z8LH/nKv2bO+g+DKo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmZBYlhuaEF2Zi9BK1lhallaZm9IMEpMcHBQc2F4UXBqWjRGZUs3RHFkOWFZ?=
 =?utf-8?B?Q05yZk9Oa3pXeXRMRUZkcnlOandGc2JrNVBBNmd6N0JLVVV6VWNvcFkyYllW?=
 =?utf-8?B?M1RJNHZPeDY4TksyV3NPYzJhUFlWb2UxeXYxbG5vYkc3dEVMcExtUWc5NUJ4?=
 =?utf-8?B?bE9qT1dJTHlxQUE0eUl6MXJzcU1GbjRudjdkb0had1NWbmhhSjU4cjFoem50?=
 =?utf-8?B?ZEprQjRVYkFkL2VDYS8zYTZ6VHBTUDZwNzNNc0NVRHQ3T1Y0VGpyM3BJbGIv?=
 =?utf-8?B?L243UlJiRkNXRmZDNlhucHdZN0p6Rk85VHBPdGFCTXZJNnlER05FUGhyUE00?=
 =?utf-8?B?OVBMaDNVL0lXTFNsMHh5V21ybzhCOUcwRVFJVE1BTmZoVXNkY0NuTVBEeXg5?=
 =?utf-8?B?QXIrOHJOTGM4ZjdjaEVJRklCWEJ1aklRbGIrZGRnbjNHSUc5Q3pzZkRCY0FI?=
 =?utf-8?B?YnhDL3hoaHRCdUk5cjN5Vkp4eDBSWWpkYzBFUXhLZkVBQzJ5OWVuZDBJRTB0?=
 =?utf-8?B?Ukc2dUxzdTUxT1FYN3liaDY4MGQ3RlZEaloySnBEODk3SkVHdHc4Mkc1ZURx?=
 =?utf-8?B?TnpBQ2xRaWpHNGsrRmdwck8rZXBnOWwrbWpWZTVBSFl1dVM4Y25vUVl6dWVL?=
 =?utf-8?B?VTRVV0diRVZUSlZaVjR5a1p5K2pkMk45YVBENStTb0gwOHFlQXBLWEx3Rm00?=
 =?utf-8?B?M2dZdTFra1RjUkpNQU5KZCt4NEs0QnBYUGVmZnJLTnhXWjVDVTBWVlYzOGU1?=
 =?utf-8?B?cFRBR2YvV0duWlEwVjJ5S0t0d3I0VW5tTFFKYmppSGJPemxyZ3VKK3pocDg5?=
 =?utf-8?B?blVjVWdzRS9LVlM5cUM3MzhqV2t2UkpHVmdVNVBxeDM1VmNvdlpVbVRicjhS?=
 =?utf-8?B?UFVReXA3c0wzdk5PbnFrOHlyekY4ajRzcCtuME5FTllrMGJ4aktRRHN0K1Mz?=
 =?utf-8?B?bElyYlR3V2dZVXNuZlFubzIzcGNiWUFBMU5sQUthRnRyYnd5TEhMc09naVZ5?=
 =?utf-8?B?cTJvQ2NoWS94ODFkMUxKbEhTRUZTUzlnT3JTc2RkaVFyRy9Eb1k2MDdZWTlz?=
 =?utf-8?B?cFlsRnI4bEdYNzJhNVhkUloxaGZ2N1pieTlLTHRZSWRoMXNkYm1YcktnN3l5?=
 =?utf-8?B?QWZBU3V2YnhlSW1LelI1RzZoVysvNHR2bTh6YzlOVUlPMWZ5eTBTK1lGQmdo?=
 =?utf-8?B?YjJiaEoycDFvaC9OME9jQkxiQnNhRDR4ZUF4aGNzQTlyS0s4Y0JVeXNLUWFp?=
 =?utf-8?B?NW8xMWh1NzdERVF6b2xKQ09pQ0ZuVEovMXkzMXUvOTlvNlFKYzFIbDlCVFdn?=
 =?utf-8?B?ZGVSR1hSdlRGaFUyTEtPalByekJ4aGpISW56YzJQZnNUa1FKRzFOYjdBMmwz?=
 =?utf-8?B?Z0xpVkZBK3RjRVc4QnBlMStCNEEydTRFOUJ5QzhyTFUwZWNiTUJPdUdQYXJk?=
 =?utf-8?B?YnY5bWNhQ1NacjVMYmkvN2J6K3liemhyckhVcGdoZzRLWkFUV0hyRXVwMG44?=
 =?utf-8?B?N1lzK2I0all2aDRURnV4amhuOXllSWtNRVVKbjloVWt0WHBmZG4vZWhneWNF?=
 =?utf-8?B?Mmk4NGQrR0kwVlRNbWVvSEtLd0I5WExUOVd5RmpWNnlUazlGUDhCTER0S0h4?=
 =?utf-8?B?N1IyVGdDL1pEVFNnbllnWFV6YWpEaVJtWTZWVWY0d2t6cWd3djJpVzZtVUR3?=
 =?utf-8?B?SkREWlRkelVHMDYzNndQV25aTHNpRGk3Ym94RkhXUUtldGNrTVpxdW83eStS?=
 =?utf-8?B?V0loMDJFREJOTnFRdkpEd25CeHlGS3NhWGtxd2dmQ0xWaElaTkgrNGVONk1U?=
 =?utf-8?B?eUpidVV4ck1nNXIyallmWTJha2Z1OWNiNjRlcGdDL0tib3VwRmRMRkU4dE1T?=
 =?utf-8?B?RWZTS05pQXQ1d0dmckY4cEhna014b3ZZSnNvbnRCNEloelNhQ2JaODZnemtk?=
 =?utf-8?B?UTYzQjhqVy9Jcml0U3NabkZ4bXFRd1l6S3cvOW5zR2t0NFdZc3NMSi8wWTgz?=
 =?utf-8?B?S3B2YjNaMC9PRjdjR0NobExIYlVURXBobFEzVExQcU14Yk1PNkljY29wanZ3?=
 =?utf-8?B?WENHNG5rdzVTRisyRklVb3JTWklaU3dyN3JHWVZYZlMxRlR4L3htRk5YUWwx?=
 =?utf-8?Q?XSJSrxZsSStTJcC9xeHNsK/sF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2AA24E0F833D34B938552BC0B46D041@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2133d483-1764-4a67-21f8-08dd565585ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:05:47.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcgAVjs2ENRnseTqJBj744+5cGF3tOnre99Byo9usX4fnXliVyg/Z1Xfew617UYA9VSjxYkzTpXRcbinXUDJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDA5OjQ4ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
SGkgQ29zbWluLA0KPiBPbiBUdWUsIEZlYiAyNSwgMjAyNSBhdCAwMjowMDowNVBNICswMDAwLCBD
b3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gVGhpcyBnb3QgbWUgdG8gc3RhcmUgYXQgdGhlIGNvZGUg
YWdhaW4uIFdoYXQgaWYgd2UgbW92ZSB0aGUgcmVtb3ZhbA0KPiA+IG9mDQo+ID4gdGhlIHhzIGZy
b20gYm9uZC0+aXBzZWMgZnJvbSBib25kX2lwc2VjX2RlbF9zYSB0bw0KPiA+IGJvbmRfaXBzZWNf
ZnJlZV9zYT8NCj4gPiBib25kX2lwc2VjX2ZyZWVfc2EsIHVubGlrZSBib25kX2lwc2VjX2RlbF9z
YSwgaXMgbm90IGNhbGxlZCB3aXRoIHgtDQo+ID4gPiBsb2NrIGhlbGQuIEl0IGlzIGNhbGxlZCBm
cm9tIHRoZSB4ZnJtIGdjIHRhc2sgb3IgZGlyZWN0bHkgdmlhDQo+ID4geGZybV9zdGF0ZV9wdXRf
c3luYyBhbmQgdGhlcmVmb3JlIHdvdWxkbid0IHN1ZmZlciBmcm9tIHRoZSBsb2NraW5nDQo+ID4g
aXNzdWUuDQo+ID4gDQo+ID4gVGhlIHRyaWNreSBwYXJ0IGlzIHRvIG1ha2Ugc3VyZSB0aGF0IGlu
YWN0aXZlIGJvbmQtPmlwc2VjIGVudHJpZXMNCj4gPiAoYWZ0ZXIgYm9uZF9pcHNlY19kZWxfc2Eg
Y2FsbHMpIGRvIG5vdCBjYXVzZSBpc3N1ZXMgaWYgdGhlcmUncyBhDQo+ID4gbWlncmF0aW9uIChi
b25kX2lwc2VjX2RlbF9zYV9hbGwgaXMgY2FsbGVkKSBoYXBwZW5pbmcgYmVmb3JlDQo+ID4gYm9u
ZF9pcHNlY19mcmVlX3NhLiBQZXJoYXBzIGZpbHRlcmluZyBieSB4LT5rbS5zdGF0ZSAhPQ0KPiA+
IFhGUk1fU1RBVEVfREVBRA0KPiA+IGluIGJvbmRfaXBzZWNfZGVsX3NhX2FsbC4NCj4gPiANCj4g
PiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzIGlkZWE/DQo+IA0KPiBUaGFua3MgYSBsb3Qg
Zm9yIHRoZSBjb21tZW50cy4gSSBhbHNvIHNraXBwZWQgdGhlIERFQUQgeHMgaW4NCj4gYWRkX3Nh
X2FsbC4NCj4gV2hhdCBhYm91dCB0aGUgcGF0Y2ggbGlrZToNCg0KVGhpcyBpcyB3aGF0IEkgaGFk
IGluIG1pbmQsIHRoYW5rcyBmb3IgcHJvcG9zaW5nIGl0LiBNYXliZSB5b3Ugc2hvdWxkDQpwYWNr
YWdlIGl0IGluIGEgbmV3IHN1Ym1pc3Npb24gd2l0aCBhIHByb3BlciB0aXRsZS9ldGMuPw0KSSds
bCBkbyB0aGUgaW5pdGlhbCByZXZpZXcgaGVyZS4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRf
bWFpbi5jDQo+IGluZGV4IGU0NWJiYTI0MGNiYy4uMGU0ZGI0M2E4MzNhIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF9tYWluLmMNCj4gQEAgLTUzNyw2ICs1MzcsMTIgQEAgc3RhdGljIHZvaWQgYm9u
ZF9pcHNlY19hZGRfc2FfYWxsKHN0cnVjdCBib25kaW5nDQo+ICpib25kKQ0KPiDCoAl9DQo+IMKg
DQo+IMKgCWxpc3RfZm9yX2VhY2hfZW50cnkoaXBzZWMsICZib25kLT5pcHNlY19saXN0LCBsaXN0
KSB7DQo+ICsJCS8qIE5vIG5lZWQgdG8gaGFuZGxlIERFQUQgWEZSTSwgYXMgaXQgaGFzIGFscmVh
ZHkNCj4gYmVlbg0KPiArCQkgKiBkZWxldGVkIGFuZCB3aWxsIGJlIGZyZWVkIGxhdGVyLg0KPiAr
CQkgKi8NCg0KTml0OiBNYXliZSByZXBocmFzZSB0aGF0IGFzICJTa2lwIGRlYWQgeGZybSBzdGF0
ZXMsIHRoZXknbGwgYmUgZnJlZWQNCmxhdGVyLiINCg0KPiArCQlpZiAoaXBzZWMtPnhzLT5rbS5z
dGF0ZSA9PSBYRlJNX1NUQVRFX0RFQUQpDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiDCoAkJLyog
SWYgbmV3IHN0YXRlIGlzIGFkZGVkIGJlZm9yZSBpcHNlY19sb2NrIGFjcXVpcmVkDQo+ICovDQo+
IMKgCQlpZiAoaXBzZWMtPnhzLT54c28ucmVhbF9kZXYgPT0gcmVhbF9kZXYpDQo+IMKgCQkJY29u
dGludWU7DQo+IEBAIC01OTIsMTUgKzU5OCw2IEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfZGVs
X3NhKHN0cnVjdCB4ZnJtX3N0YXRlDQo+ICp4cykNCj4gwqAJcmVhbF9kZXYtPnhmcm1kZXZfb3Bz
LT54ZG9fZGV2X3N0YXRlX2RlbGV0ZSh4cyk7DQo+IMKgb3V0Og0KPiDCoAluZXRkZXZfcHV0KHJl
YWxfZGV2LCAmdHJhY2tlcik7DQo+IC0JbXV0ZXhfbG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+
IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShpcHNlYywgJmJvbmQtPmlwc2VjX2xpc3QsIGxpc3QpIHsN
Cj4gLQkJaWYgKGlwc2VjLT54cyA9PSB4cykgew0KPiAtCQkJbGlzdF9kZWwoJmlwc2VjLT5saXN0
KTsNCj4gLQkJCWtmcmVlKGlwc2VjKTsNCj4gLQkJCWJyZWFrOw0KPiAtCQl9DQo+IC0JfQ0KPiAt
CW11dGV4X3VubG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRp
YyB2b2lkIGJvbmRfaXBzZWNfZGVsX3NhX2FsbChzdHJ1Y3QgYm9uZGluZyAqYm9uZCkNCj4gQEAg
LTYxNyw2ICs2MTQsMTIgQEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19kZWxfc2FfYWxsKHN0cnVj
dCBib25kaW5nDQo+ICpib25kKQ0KPiDCoA0KPiDCoAltdXRleF9sb2NrKCZib25kLT5pcHNlY19s
b2NrKTsNCj4gwqAJbGlzdF9mb3JfZWFjaF9lbnRyeShpcHNlYywgJmJvbmQtPmlwc2VjX2xpc3Qs
IGxpc3QpIHsNCj4gKwkJLyogTm8gbmVlZCB0byBoYW5kbGUgREVBRCBYRlJNLCBhcyBpdCBoYXMg
YWxyZWFkeQ0KPiBiZWVuDQo+ICsJCSAqIGRlbGV0ZWQgYW5kIHdpbGwgYmUgZnJlZWQgbGF0ZXIu
DQo+ICsJCSAqLw0KPiArCQlpZiAoaXBzZWMtPnhzLT5rbS5zdGF0ZSA9PSBYRlJNX1NUQVRFX0RF
QUQpDQo+ICsJCQljb250aW51ZTsNCj4gKw0KDQpJZiB0aGlzIGRvZXNuJ3QgZnJlZSBkZWFkIGVu
dHJpZXMgbm93IGFuZCBib25kX2lwc2VjX2FkZF9zYV9hbGwgaXMNCmNhbGxlZCBzb29uIGFmdGVy
LCB0aGUgcGVuZGluZyBib25kX2lwc2VjX2ZyZWVfc2EoKSBjYWxsIHdpbGwgdGhlbiBoaXQNCnRo
ZSBXQVJOX09OKHhzLT54c28ucmVhbF9kZXYgIT0gcmVhbF9kZXYpIGJlZm9yZSBhdHRlbXB0aW5n
IHRvIGNhbGwNCmZyZWUgb24gdGhlIHdyb25nIGRldmljZS4NClRvIGZpeCB0aGF0LCB0aGVzZSBl
bnRyaWVzIHNob3VsZCBiZSBmcmVlZCBoZXJlIGFuZCB0aGUgV0FSTl9PTiBpbg0KYm9uZF9pcHNl
Y19mcmVlX3NhKCkgc2hvdWxkIGJlIGNvbnZlcnRlZCB0byBhbiBpZi4uLmdvdG8gb3V0LCBzbyB0
aGF0IA0KYm9uZF9pcHNlY19mcmVlX3NhKCkgY2FsbHMgd291bGQgaGl0IG9uZSBvZiB0aGVzZSBj
b25kaXRpb25zOg0KMS4gImlmICghc2xhdmUpIiwgd2hlbiBubyBhY3RpdmUgZGV2aWNlIGV4aXN0
cy4NCjIuICJpZiAoIXhzLT54c28ucmVhbF9kZXYpIiwgd2hlbiB4ZG9fZGV2X3N0YXRlX2FkZCgp
IGZhaWxlZC4NCjMuICJpZiAoeHMtPnhzby5yZWFsX2RldiAhPSByZWFsX2RldikiLCB3aGVuIGEg
REVBRCB4cyB3YXMgYWxyZWFkeQ0KZnJlZWQgYnkgYm9uZF9pcHNlY19kZWxfc2FfYWxsKCkgbWln
cmF0aW9uIHRvIGEgbmV3IGRldmljZS4NCkluIGFsbCAzIGNhc2VzLCB4ZG9fZGV2X3N0YXRlX2Zy
ZWUoKSBzaG91bGRuJ3QgYmUgY2FsbGVkLCBvbmx5IHhzDQpyZW1vdmVkIGZyb20gdGhlIGJvbmQt
Pmlwc2VjIGxpc3QuDQoNCkkgaG9wZSBJIGRpZG4ndCBtaXNzIGFueSBjb3JuZXIgY2FzZS4NCg0K
PiDCoAkJaWYgKCFpcHNlYy0+eHMtPnhzby5yZWFsX2RldikNCj4gwqAJCQljb250aW51ZTsNCj4g
wqANCj4gQEAgLTY2Niw2ICs2NjksMTYgQEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19mcmVlX3Nh
KHN0cnVjdCB4ZnJtX3N0YXRlDQo+ICp4cykNCj4gwqAJCXJlYWxfZGV2LT54ZnJtZGV2X29wcy0+
eGRvX2Rldl9zdGF0ZV9mcmVlKHhzKTsNCj4gwqBvdXQ6DQo+IMKgCW5ldGRldl9wdXQocmVhbF9k
ZXYsICZ0cmFja2VyKTsNCj4gKw0KPiArCW11dGV4X2xvY2soJmJvbmQtPmlwc2VjX2xvY2spOw0K
PiArCWxpc3RfZm9yX2VhY2hfZW50cnkoaXBzZWMsICZib25kLT5pcHNlY19saXN0LCBsaXN0KSB7
DQo+ICsJCWlmIChpcHNlYy0+eHMgPT0geHMpIHsNCj4gKwkJCWxpc3RfZGVsKCZpcHNlYy0+bGlz
dCk7DQo+ICsJCQlrZnJlZShpcHNlYyk7DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiArCX0NCj4g
KwltdXRleF91bmxvY2soJmJvbmQtPmlwc2VjX2xvY2spOw0KPiDCoH0NCj4gwqANCj4gwqAvKioN
Cg0KQ29zbWluLg0K

