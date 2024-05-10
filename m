Return-Path: <linux-kselftest+bounces-10023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2218C29A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222AA1F2194E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F41CF83;
	Fri, 10 May 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xl+Kj02U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCE22EE3;
	Fri, 10 May 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364099; cv=fail; b=OFpbGswRzJLj583SOkzw1qD9ILwsPftJNLjvs7EtL1I1EW+kWFVqngcoKHMR4DTVhI+st2zXb1jo8ZDMXfAlsG0M6cVclxkfCQbFj7DgsB8Hol8rn79jnJqDQsZyalSFPoGzETfqcOUdTKL9jfINHAwg9T9+3eHj7vZNytTYyPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364099; c=relaxed/simple;
	bh=kXDoKoDH5/bsbyv2N1G6HOqVfnD5upaB7dxSVw5qmes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rIbrFchmM9FkrxNcraGMfcR5hzFIz2dO5ltclPdQQoaBUmPPfgo/DVU9iz8JELBobP3INQ0WADgor/SIeObfmNfougPItEaW8zyQWrU+m1Es7++pM+y+2lrJozC6vumtNOU/t8ZqqI5x0agMPysNY6ax+if1dz39noqgscJ0vic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xl+Kj02U; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCsQOccLoPvKpuCmfYUqB5YebU97FMnhKFcLey1UweyUoLcXxOuGNP2M1m2aLIMMhScNyQQBMFjyJdsOZGy+ZsgPJRsTU3651u2eTtCEq5hZG7+pvrkxi3zhIFaKhfuLoO+v7Xg3EhGndGMU1oZnmH6aRfpgBF5stLmvUzzMCAbF8BSsNEsp2p/7WekkucKl1vsssbn83xbJdjQHqIcNB0gdkQ3uAeQ/0Rs/XSi/TT1Ornk31cLWXehRIBgLcwQwk9TR/ZkyRXiI8AKs0fUuutyfpobkdtC6xhVMfJ4oSPSzRaQehvho+22m6Ys0qBgN3tE4nllNw8Fd2/pyy2q7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+xuWsGSIo796oaYElZs7tHWSQ0nxI0xBpFF2ZfxAVI=;
 b=Qb+biDI7LaqtxpmmmwPcPZ3r/lU33yasJ5mFFwhYn9YVymEhN4Z2nezxWRXndGEibSAlaVmlOf1RKQoV/FEjoiU/XqmkaaSeGbRz5AxY4dnH8xDV78i2UYc9bhbcZ/uM9+pEUJKoZobRMDA2XJN04m9wbGGS3rcl/WO4yN6HmcRYJKxq3Sk4Q6MEQtieCHKx+S7T0mhgypec7x0U0aUlNr1amxSZd+ChN7DKHmezN4uJ48EaWZdVejJzXR5XbhwXt6/Js6xnvlHFdccuh4kKl8qI2+OVYmvvvSglor6f4kuYU5nMzsXDg8b7+qwsBFOligM/a3yPeZBnP2/api6ZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+xuWsGSIo796oaYElZs7tHWSQ0nxI0xBpFF2ZfxAVI=;
 b=Xl+Kj02UDEtSuX9wjZroMfAnd42cVxTfkXAFfM1ibdCeqFetV2hTVfC3aEDm6xhqEIzekza3Vfi5gap+AeHpauBZrA4/nt1YL3ppDfkPLXRqIxhFLtdhEhN3/kemkwAABPRNGJL1Pc05qW/qQ3eXhs03G3Z2yhtDIT0rhzhyklOQ95eADEzPYQaRFVesZhL2AMnyhZa7gj3sUFNK/Bnwsr8KSMLTm8gBFBdqqil/4blLzbKL5OR97bSgGNQKeqsJYX/C1npITNtvN0l9fYu6jOq4EuTY7POnFH+ilyw/AU8KRp/GAfzi06bOgeJR8N19kcbBvLv3nLrWdTxF4QTRuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Fri, 10 May
 2024 18:01:21 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 18:01:21 +0000
Message-ID: <e366b4d3-1cf3-48cf-8445-cdbc1156d32b@nvidia.com>
Date: Fri, 10 May 2024 11:01:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240508190254.266892-1-jhubbard@nvidia.com>
 <c1e834d6-266d-d8bb-4e85-cdc440ddcb31@linux.intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c1e834d6-266d-d8bb-4e85-cdc440ddcb31@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 18299fef-0bb6-48f3-5be8-08dc711b3327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnR2cHh5bVM5cTJGeDUvempTYlRROE1WL09sV25mSjgxK05yUk9GWnl1UDd2?=
 =?utf-8?B?bFdDckxmSTJMN1RSZEh6MUo4amJIZzV5MVV4SDNpd3VnVC8rNUwvdmIraE16?=
 =?utf-8?B?WVVCQmF5WndxWGFqcE1PNlZVWFRoNCtOQkEwTVNpK0F6ajlsa3Y5VXFpRCtF?=
 =?utf-8?B?V3JDK2pJSTVEYTg5Z0xZT1JFaGhrSlE3QjlrZ1FHeUlJZ2lJbzhlcXJGRjN2?=
 =?utf-8?B?SCtsNjdiK01NQjliMStLOXhQdGRVMWoxNXdDZTRoblBSWUFGZXZXaGVUbkRC?=
 =?utf-8?B?MlZKc3lxalc5RWRtSHUra3FyalJobVlvcEhBS1lydnFUekhISndpYUw4MTB4?=
 =?utf-8?B?TDRnMXUrdjZRejZkVlYyNTBIL1pQVEY2Ukl5YVFndXRCdkVWQW9KUnpiODZH?=
 =?utf-8?B?d3FEQTRMakNHNDlack5WcDRZbHJjVjJXZlBURjlidkxqTmJjOFgvQWpTRFQ4?=
 =?utf-8?B?VXpTWDJvYWJ5R1BzV1Q0WXpWTE16eDBhbG5jNDVVZXBncUQ3eUFMNDhjY1JM?=
 =?utf-8?B?YkFCWkl4dzlTVjgyWUdWaVRNcEFzRW5hcjhPQjZnMkFINmw1TGVuQmVJVTU4?=
 =?utf-8?B?aXBpeTQ0QUpmeEFPN2tmcENpbnZZVmN6a2Y1RUp1dFpBQWx0VStQYUFDb3Zp?=
 =?utf-8?B?THFXVStiQWRMbzlDenc4dVNuL1RsTldJZnBXOWNwemRvMWlHOFZPdG15MWhL?=
 =?utf-8?B?RC8yTVFzV005WWRlSHFjS2U3dExBWmFzM3FNSy9oTEJYQkxaelF6TldEd0Ux?=
 =?utf-8?B?L0VTZUh2KzRLYUFqbW82TzFxWGhTK1Y0L0hFZ2l5N1k5Z1NSdTQ4UFAvWGpZ?=
 =?utf-8?B?Mkc1dm1ldU9HSHcwaUlTVmF6cTNvQXR3VHJYaktKYTd2c0ttMnlRSkplR25w?=
 =?utf-8?B?UXVHRklIQ0RXWU5hczZiTFdTNE1mZjRZdjlsY1RXbzdhUUhDeGM4a2dzUjFv?=
 =?utf-8?B?TlFBTHVaVzdEU09BOWwyR1JPWWxZaUVhQWx6anVoN2ZLenVoREhMUzkxWnZp?=
 =?utf-8?B?WmxQdmpaWWJBWmdrVWV1YVByK20yanhyOUF2S2JhaUpRVEQ5U0g2WlllQUdH?=
 =?utf-8?B?U0RKQnZ1YVUrRG5FbWhQY0R3anJNeVNOTkZQRzVleGE0NitYelhaUkw1WDBY?=
 =?utf-8?B?Qy8yaUk3Rnp1Q2l4eTNFaXg3YXMzY2dKTFZzNSs2WkNiY1FKajhldEVQQkpG?=
 =?utf-8?B?RUoyN1FIRGRrc3FCWmhaVGYyc0lhek5WdzV1VGNmU1kydWlmWDRjckVXbzM1?=
 =?utf-8?B?eVFUNms5TFJRRk1Nd1RPK0xBWTRGMVdvay9WQkR6QUhwODRVaFoyQWQ5MUl0?=
 =?utf-8?B?aVBrdWlCcjgwVEtsWmFZSkxSSms1dWYvNlVGa1VpRU9WS0tOZjlOVXc2RFVw?=
 =?utf-8?B?UzVGcWNqVHRmemIwWi9aRnVuSDc2TUZGRHJFeHRIcTAyWnJNTzhFVGRNSmNa?=
 =?utf-8?B?d3ZPWFpXT1ZFRjdsSXFmbWZhSk9HZXM2WUJRUGZ3VlQ0UlZzdzJGYkdMd2k1?=
 =?utf-8?B?TlRaSVV1VC9yTHh1UnA2Z1N1b1M5WmNDeDNpMXlFZFBNandKMXlrcW85dDQv?=
 =?utf-8?B?d05xWkdNdlE3OFo5RnY2VUh3aGVlM01Ha1BRYUpUUTRrOTZhT0svR2Jjbkpi?=
 =?utf-8?B?eTFkaWtVcHlDUnM1NEVnZlBCcWZER08wMC8zVjZOOERkM3RPMlJKM2xaYzN6?=
 =?utf-8?B?bkRRbEFBcXZycTRLenp1VkNNNEtZQWc3cTVnUWxGY2lxMUtYVmxxQThBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJJbVM0cGNWa3FKRTVvOXFRZkJWTjF2Z2l0UHlCRjB6R29iZ3k3SDg0eEpr?=
 =?utf-8?B?MkVkRWllSUFqVFdqdjJKQ1MwNUdLckptRGJxTnVTQU51dU9kelFtRGpYNHdM?=
 =?utf-8?B?VnZsWDJkbnZISS85ZjYvZkNqL0tWc3BHTTM2REc4OVB6M1pxZXpkaTBKaFZa?=
 =?utf-8?B?SFpQMHgrbnhBZGlXRXpxOEdxYmEvOGxPczRDN3NQLzduekVtNjhsOG5PYnpj?=
 =?utf-8?B?WS9iSS9lYmx4QTY4TVc1aDBidzZhaG9PNmRJdVc1N3ZqY0ZkZWRSVjhiNGlY?=
 =?utf-8?B?WkJONWhnakVUS21PK3R4OGp5eHV3M2hpQ2ZKV2xvVEFEZWJSMjhoeFRzV1RR?=
 =?utf-8?B?ZFJVY2RONjJWdFUrU0ZlOHhpckdhaGxjSUtCNWM0ZHpuRndINlFaQlJvT1dZ?=
 =?utf-8?B?MEFVUWQ5ZDF6YmVhYlJWUkZKMDgyd2ZlQ28rb1M1cHdtem01Qldkc28vN2pC?=
 =?utf-8?B?MHFOU1hzUTNlWlpSUkRPWkpsNklKQ1NQOHhTblVjSUJlelUwOVhoZVFJWnIw?=
 =?utf-8?B?TTdwZ29NaloyekZFOTA2dnlzd0xHQ01wYmh5Q2d5c3E3UnJWcVlIR01BMjAy?=
 =?utf-8?B?ZXN2VU5TaklXejZFLzlyZE91RWNDMnZhY0FBYmdyUWJHNHoxcnZ3MUdxQjRx?=
 =?utf-8?B?ekg5b0dsVFB1c1dsMnRrcHpNQlQ3Qk5KdEpvOHE5a1lwc01pNXVMcDFHYlB2?=
 =?utf-8?B?V0gxYXd2MkY5ZCthTFBZTE9zdUEyc2w0NnVaMk1SZEZiaDJOMlFKdmNlbWZ1?=
 =?utf-8?B?eWk1M1l0SysxVHl3d2JWMjFLdFFKbENpdkkycmgwaTVWQmVLN3NLY1NjNzFR?=
 =?utf-8?B?ZlczOEJtcGJqL2ZOQW1ZNzR6MGZIcjZ4WDZtUEVHSzdiL3U1cGJCVWxNK1Ev?=
 =?utf-8?B?RlBEVlpSRkNaVnlLYmtnYlRRZWswdXFkdDJCSURucWVRMVNidHNDeW1IVlVO?=
 =?utf-8?B?YmI5Z1NPbk5EWXdrSnl2cEw0YzFLNkZlQm5jTlR3TEpvUVh3UjFlSFBWbFJQ?=
 =?utf-8?B?NmlIUzFQZ2hyTCtvUFlDSmxubkZZYndrTmhRN3VIQ2d6WHdjMW1QVGZONE9C?=
 =?utf-8?B?c1FrOUNBU2pVajN3RTNaYlJmUDdtWjZFdkd6ZzFSandaZFN0R00zVCtiS2o0?=
 =?utf-8?B?Rk85b056a0dEVFVETEtPbzhFUVdiV1RLTkxLR0NKUXlWVkJHWExTcXRMVVlp?=
 =?utf-8?B?dEVYVmVIczc3aVhjbVRLRUFMelVZWlZZVTcrWURYbmYzTzY1R2pCT01mZklY?=
 =?utf-8?B?RGF5WExxa1FObzJnbk1aK1NiRWdZZ3IyZEZpb3ZNUE9Mekp2N0NnSy9VZVRB?=
 =?utf-8?B?VlRCU2R4eE9la1EwRVVHWjJxSGZkVWpwNWM4K0VRczNaeE5uOWVFclhZUDF2?=
 =?utf-8?B?U0F5MjlWWWdtVStMWG5UQ0R1b3NjVEJnWTlsK1owbm8xa2s2UEZLZGVQZ3Ix?=
 =?utf-8?B?bFJZOENBcnI2a2VnRENZaEpvY1hmbmloTEpCMmIyc3F4M1Q1V3h2VVprM0h5?=
 =?utf-8?B?aDJkWmU3aFNYdG5FcUtzVEtSaSsvQ3ZCYWpHZUZpdnNONzNjQVhCTlA0K25E?=
 =?utf-8?B?MUM3S3lTVkJaU1JnWnJLem1CbnJxaTZSRldNQnlGN0F6R0dUTFlYNGNIR3ZZ?=
 =?utf-8?B?dmtlZzRCQktuZWhuMmp3NFkzdE9wUnRmWEh1U0FQeXRxLzZWSEhFTXFHbGMx?=
 =?utf-8?B?ZDFBR3hSQnVnRW1ueE54U004RXlLYnRyNEpueXdzMFpRYlVPRUcxMGlNYkVs?=
 =?utf-8?B?NTcxMHFoczZwNFgzby94R0VLMU10STZtcGtYY1N4RXF1ZFBZc1dUSzZBbTZH?=
 =?utf-8?B?N2xzUlNRdVRkeGxDckFLYkRwTkk1RXorZHpDTVFkdWRkTy9PQnJTSGRPSlpB?=
 =?utf-8?B?bkp4S0pNaWs3YjJmMHNDeVkvbTh1cE5XbUZ4aDlrd0J3ZzBZUk9Wbnp1QmVJ?=
 =?utf-8?B?My9zVEcwTFdzWmVUdjhSTVNxelhLc25UeDZaZjl2QldBd2w4emdMZ0w1Q2JV?=
 =?utf-8?B?TlhodXJzZG5wY3BacE5GL2lSUFVTMWo0aW9ieENBQmM4eXE5Y0VPWkcrbnVp?=
 =?utf-8?B?U0MxV1VDd1dPTUlPdm5Ma3NnT2lOWTBSdElDTXZxU2F0a2pOdmlrcUdBQTVo?=
 =?utf-8?B?MnZyMlNoZDN3YjV6YnV6eTBXcXd3YldyM1ZHeCtmUE12T3hQaGx1aE5RTm9K?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18299fef-0bb6-48f3-5be8-08dc711b3327
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:01:21.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtkdiUnb8mXEnJ66GUq2u2BBF9y/euj0VY7x05G/G4zYYfXmIlAy/iNd3Nk4CxQPV4Q+r9vTEeex5nJd1pN7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

On 5/10/24 2:06 AM, Ilpo Järvinen wrote:
> On Wed, 8 May 2024, John Hubbard wrote:
> 
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...two types of warnings occur:
>>
>>      warning: absolute value function 'abs' given an argument of type
>>      'long' but has parameter of type 'int' which may cause truncation of
>>      value
>>
>>      warning: taking the absolute value of unsigned type 'unsigned long'
>>      has no effect
>>
>> Fix these by:
>>
>> a) using labs() in place of abs(), when long integers are involved, and
>>
>> b) Change to use signed integer data types, in places where subtraction
>>     is used (and could end up with negative values).
>>
>> c) Remove a duplicate abs() call in cmt_test.c.
> 
> In general, instead of filename, it's better to refer to the actual
> function in this kind of description. And in this particular case,
> cmt_test.c could be replaced with "the CMT selftest" which is more
> descriptive and still unambiguous.

Sure, I'll change that.

> 
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Thank you.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 

Thanks for the review!


thanks,
-- 
John Hubbard
NVIDIA


