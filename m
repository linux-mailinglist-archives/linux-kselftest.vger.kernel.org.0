Return-Path: <linux-kselftest+bounces-27203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5ACA3FD50
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048D4423DC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9F24E4CF;
	Fri, 21 Feb 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vjadLOlp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022102.outbound.protection.outlook.com [40.93.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120E1DC9B0
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158563; cv=fail; b=O7lw4cF3Q/oWzAXpgDRq/gvV3k4FCdJyhDkezNUzFIBXTiQ3BODiw8OLcbIxxByiXIpPZmpCDYk16KDZcJFYfs1YdXLPsBUADtQxC/IUfGO88DAZTcn/KpAV9V2BCN1LpE5+l9J62XhGFxMuvBmnYS0Ty+JAPKao/eLteX372uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158563; c=relaxed/simple;
	bh=LD7Q08ZDzk5a/dXbJ+8nybis8oUhMs97kwyxc+jv5FQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwrrtzmskuuF+hlyguJgmXpVXKds+sYMRMe5jjbm+OQN3FAMnZVq0W/GbK90lgdClen334AcnD0+FTsPDD5TpCC8uDMta2TOHezNteMb15tiTi51d2nxvY3uKU6dkCJynxJKch2MCfwoovcXkJrTFMN8IyUcDd6n8SpSdHBGoU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vjadLOlp; arc=fail smtp.client-ip=40.93.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugu2yjJQlO5A19G0KtZSGerdBSUOBnsO+/qDCfUEDvBBgk5ySjee6z/wgFNTieU6UI2F9Z2iW++ySSKMe7zWcXFwNWdeTQfi211ftrwBBCuKt/ouRlwbn4QHMNNW+l3+Zq65OT3dlvSnvx/zjivSDjZtZqpnZ9fYiQPlP9kJgnInB7R8bM3BcGcpjvXqRfBhnmcq30WTRoSG8o72/T8hoFXcHKKUFrar13HpHw0NZLS68hLBgxP7xVPKkK3XelHg+Nzi/JzUQIodme46gNDFqEA4rFOX+ocI7c5Bak6lXw3gM9qi8ML5lKaCnPGtRN1o3zBHemACunZhlrdDn1an4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHM15m9+1jS72EU30LnDFVRalbdMGEXvpAWYRthXnd4=;
 b=OBdNVxd+Ykmlfwxif6gLeFCeBXMB6pZmCl9Bj6Jpqfz7N688MPz6N8lQG/tttRyMQx/RDYAa7ykbalURiiKiBcfdO01vf+RSUw5y3YT+UOaqgsGO5V08xVE/3jarEkhWpZGcWq8v51MepBFbQpDS+vEWUAfiu5finFVPNBaSPainLgFTNP1uJCEt99BgzTyWG8M+2u4psymqQhobKXFWXl26YeHIWa4UOM5Mjp84DZtgVb8IzfT0o48wVVzcroInU8tIa7S72qEvWaepTi4TtAAU4ihIybmkSLAma+lFJkqx6p7JaK3FGB3KH55tpLSRTfx9y3ojfNrR0I/CiO4fCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHM15m9+1jS72EU30LnDFVRalbdMGEXvpAWYRthXnd4=;
 b=vjadLOlpBy/bREAM4ogpXUShh69as/qQKus9WN6NLQN5P3bg5TkHR8QBUFs66KA3NXO68JVv6p5bMdcK7QCTGRtau1R2jnNr/xJrWZzYGOWRtrmKbLd0qAyZDHHbZCCTW4Llh9CQ7cnpViFtgJcSNeronjr7ZOvNX6K5bUpWFPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ0PR01MB7511.prod.exchangelabs.com (2603:10b6:a03:3db::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 17:22:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 17:22:38 +0000
Message-ID: <c3139c93-b08b-405b-9725-40c5a4235160@os.amperecomputing.com>
Date: Fri, 21 Feb 2025 09:22:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kselftest/arm64: mte: Skip the hugetlb tests if MTE
 not supported on such mappings
To: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250221093331.2184245-1-catalin.marinas@arm.com>
 <20250221093331.2184245-3-catalin.marinas@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250221093331.2184245-3-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ0PR01MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a208daf-7083-47e1-8992-08dd529c56d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sjh2cHhLeW9ud0krRWlUZWQvS0ltQ1VUMjBZYnpHenlQL2ZqeUthZFo2aW5r?=
 =?utf-8?B?d25FQXZWL3BYTDlzMHovdFU3Q0VQRVFMbG50TVQ0aEkxbDFNV0twNjhCY3Av?=
 =?utf-8?B?aTJ6OFNxYVlqS1BBdEcyVFdZQWZnTzFJN0R4NTNwQ0VmWkdPd2U2MzJhV3ls?=
 =?utf-8?B?ZEZFdHRFcktXeVMvbm9waVFmV1ZnMUJiZVR4aEl2MmM0cDZqR3dRNmVVc3JN?=
 =?utf-8?B?eTc3VThkM1ZFMGpXUXZYcUN0VVdGYkFtejMwTlNNbk5DWWxUVEo0SVhCalg0?=
 =?utf-8?B?dXZHR1J3US9yMUVTZlVLTjVpaHQzMW5MS3NSMVd1MjgxWmllNEJGU2tpRzBK?=
 =?utf-8?B?NTRneWFrMGVCcUFlTzdUdmM2ZzNPeEZobWZieGFHVVFUSDdTRjVZbjR3ZVNh?=
 =?utf-8?B?dUpqTENmdE1xUmM3eDlhaVA1OFZRMUU0c3pSOHA2NTZCOG8vdktmeTNSM1RI?=
 =?utf-8?B?clhtUnRySWp3aWNQUlRYaDJkbmFrekJZRVN5bnJWZW53NXh1SVp4TmptZStE?=
 =?utf-8?B?cEROeVo4aGp1dUNhVTJWUFdKUnRIcWdYek84UVNXTy9WeHU4SEZlbmcwWFpn?=
 =?utf-8?B?WmtPUTc1NTZNV3NlUjMya3BDTlE2N25mTkV0MVZVNTJ3a3YzaFh3NGoyYkZq?=
 =?utf-8?B?RXliKytYNThTQXZ3OVd6WXVSOTFhN29BOTl4Q0hEb0tGZTJMUFpSNUVTRlZK?=
 =?utf-8?B?RXBhN1Y1UmFOblFsK0N4UVEwWHJMK3lNbHZxS3BuZm1TRTZuekQ1TFMwa0Yv?=
 =?utf-8?B?RnY0RGo4OXI3RUY2b2tjNlVha2U0eVI0MThGUUJQMW1uMTFVVnRDYkJqTmJH?=
 =?utf-8?B?bmhOb2JrcDdKQWJjRUdtV2lOT0hLS1U0OEQrdVJsenJyUnNHUHVxL0FlR2xl?=
 =?utf-8?B?NU52WmVraU1aWGt2cWtmRGR2cTVvdHRMMUZMS2xJWElHUzljYkh6SU1yN1Bq?=
 =?utf-8?B?ZXVLN3Nic2ZST29NcWhVMHpTUDlGRlBROVY5dGljMzY3bVFMUXljTlV5Rk5a?=
 =?utf-8?B?T01GVjdnNDJWMWFjTi9kemhrVXNGNEdUdTdzbnNQUnZ4YTFSMVptU0l6aFpy?=
 =?utf-8?B?dnhLR2krSzZOT3NDeVVlRzE1TlBHQ0RieEN3TGIzZ0pZdHBDOVlnZHFWbTVD?=
 =?utf-8?B?TXZESDYwZmU0UFpHRmMxYXpjcEZiSkpwMHdyV1BIdENUVkdLWXJsN0tIakRR?=
 =?utf-8?B?UDFKakQ2aE5NRXJyQXNIRE1SVHNRTk1JbmhNSG93blNZbVlHYytPcWNwWXpl?=
 =?utf-8?B?alozQWJmR1lTR1JRK1ZicGpaWkpmcDJ4S0JkZjlBeUMzVW1Menc5amRBbGxY?=
 =?utf-8?B?eUcvUzhhRGQ3YWhXK2RxUjBjQ1lNZERRNHR1bDdVaGk2bEQ4OXZBc2hCM1dF?=
 =?utf-8?B?SXdPcHo0Ymh4YTRtQkdsUjNUNFJHSXpsVUIwc0dXMlVRd2tDaG1uNndBK3JH?=
 =?utf-8?B?SVNCZ1VyZThUNVM4TkErajFsdFYyc3Y3TnNMVVhYRGxnU0hDUTdFNi9ycE1z?=
 =?utf-8?B?TDdmcjkwNlhzSGpOWjJ4dWJGTytoZ2o5REpsNnJONlNicWVGMWY4Y0pMWXVV?=
 =?utf-8?B?b3NoMHYwRXFzQXl5MWp1dnpSb1AyTUxiNkVETmd3eDlvMDFtU01VZ3J4WjJs?=
 =?utf-8?B?S0E3RGd4emRGcUJpRVc1N2dpUWoyQlp1YzQ0NVBmcHZlWkRYRnlZa0h3a0ov?=
 =?utf-8?B?cDlSempYc1lyYWsxald3YzlqV0ZveVhjZVB4ejN1bm9PLzRMbHBPdk9kWnFO?=
 =?utf-8?B?T1cyM1ovcGJIWEhYTGlnYmEvSWJITjBtc1M5bWsrak1LMUpmYy8zVktxYUU5?=
 =?utf-8?B?b2p5ck9sUEtydVJ1RUhRaTNXK29mQ1RxcFRTanNNVGNJUFdPTEFMN0l0TkY5?=
 =?utf-8?Q?DbMy4FyXYWRYN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2t4L1RvakNSUGFRSGxZSENjei9nTjFaM2R5a2tuQm9VaUJBdHNlc3Fhc2hE?=
 =?utf-8?B?c3BGRXE3dlRabVFVY0pFVDl6QytmU1RlQ2dPeTJEZUswUWJwVFpDV2hpakZq?=
 =?utf-8?B?dkNFSnRHRTFIUmdJUHZmLzV3VGVDUys1RnNKKzFlZkhHTUJyWnZIYXYwZVVp?=
 =?utf-8?B?MldJdW91TVI2a01ZMldSUlV6UXFJY1RxSkt3UW9oTUovN3plZTRyMFBubUF4?=
 =?utf-8?B?ckc5QlVlNWFkY056OEJlbGdheFdMWDVmcVRQYXpFeCtEL0UxVnQ3bDlWSElX?=
 =?utf-8?B?bmoza1kycWJ5VUNYbitTZ0tpV05zUFkwbDV4TkRGY2VFbXJ2SDMzZlpxa2hK?=
 =?utf-8?B?cmFlMlVsQXpqZldVdTg1VTJTbktNVGVPUmN5QU5HbkVKWTI1L3pPeDNRd0U2?=
 =?utf-8?B?dWFqRTlDa0Z4bUR6SHZLMmtxN21OcTFIWU90bER1Zlo5WlIxbElJdkk1OVox?=
 =?utf-8?B?SWozN3lVazRxUUo2UFNFK01peTk0MlFzejE1czA3WXZBNVdUQmEyaHpJQkVl?=
 =?utf-8?B?VHZCU01LZWxzb2s0YkZmWVVQdUdxaWpqMjFoYVhPd3JCTWpzZnpBRjVBUjZ5?=
 =?utf-8?B?R0YzeStndW1uUVZlRWpVajNwOUdheEU2bzZ1b0VQaVJKL1pDNmhxTmFRaEE2?=
 =?utf-8?B?RFBlMjdwR3lMYVdrMHE3M3F1ZVRMdllVb00reG82RVpXbG0rK2R0RHRIaC9N?=
 =?utf-8?B?OU1vY3VFbmdRSW9KelViVEVsOFlyTitpNEY1THhTWlZBZ3hwdGNxK1JCcnZC?=
 =?utf-8?B?RHc1bW0vMXd2UGk2ZU04TjZ5cGhkSFFEdTl5V2x2NmJzTmxER1R5VnNIK05J?=
 =?utf-8?B?cXQ3MjVUaFR0QnZpcmlJcWo1THU2LzJVbzVSaElaNE9pVWZSNGozZnVwSnBM?=
 =?utf-8?B?WmpwMXVTazJZV0hnTHRMdlVMU3NoQTFGRjlPb0V5bU1VcUM1RnRXZUp4QzIy?=
 =?utf-8?B?QkRLQkJwNmd2YWhqSUsxOXlkTktBRVVZUVgrTk0yWDlVNk1aM2ZDaEFwVGM0?=
 =?utf-8?B?dk9CL2c2aDh2OGhZbkx3WFFpQVBpSUxxR1RlcTFVVEFNU3l1cG81TVhJTXQv?=
 =?utf-8?B?aTNBZm81bVU1VlR6VThZTTZQYzNpVnlFVHI0Q1pHTTlsb3dwU2J3K1pHSlRB?=
 =?utf-8?B?cDhTMXJFRzJ3blFFbWQyVTl3Q3VDLzVvaThEM2JGMlBRV0pZcUIzQ0lJU1cx?=
 =?utf-8?B?MGo2NjgreFpCTXdBTmtnWVJpRDFrR0pmVHhOaktJbjdIczk0SUxla05QSFpT?=
 =?utf-8?B?NlVUVE1jcUZRK09ZMkdJY2w4bGFUdHNqditnNW4wMnR0bTlMT2pkU2dhZUdW?=
 =?utf-8?B?WmNaSmI4VWp0RjRvdldhcndab0hxeGVaMzV0VGVGNHhxUkU0NWhxK3NORzBi?=
 =?utf-8?B?WmdRT1dNTkFQMW5JbW5CSHpJU0F6MitPd1ZWTWhsVDJMbmFsSG5oYVg4OEl2?=
 =?utf-8?B?LzZ2VDY1T0xhYm5MY05DS2d5UTN1bklFWXBIZC9odGkxNVRYWnNwWHVwNXpx?=
 =?utf-8?B?Y2llMElTWkNkbXA3MzVyL01hTzUvcmExUldjUCtyZW93T2p1Z2pYNElucFpv?=
 =?utf-8?B?eGxkd2VGZk52NDdMT1lWQkFkL1ZNNnhxNDRYaDZ4c2JPdnAzYndlMEgzL0RN?=
 =?utf-8?B?UGVkeEpCOFBBcHhWekJ5R0QyVndaekY4NXd6WG5TL1pubnNJd21NUUFOZUF0?=
 =?utf-8?B?a3U2TkcwOW5GdFVVM0RZRVR3dyszSG1kQW9qNmVOdUgrVWdacTBVZThJaWZk?=
 =?utf-8?B?REtGTU9lcmliUE5SeGo2cmw3TVJKY1VJT3BTdUNkRFo1OGpYakxiUy9OSVN5?=
 =?utf-8?B?aGFmNmFGQzBHbUdGc2U1Y3RhVmJIRUFjWjhsZlRPeDhPNVNNS0RzMVdYdGRx?=
 =?utf-8?B?bkRHM0lsVUtWSDMySFZsb1BKb0ZGY1lWMnhKeW82MzFHTEZ2WnFLREFkQnpG?=
 =?utf-8?B?dGYwV2l6YnVDb08zemF6R2Y1MWxHS2o0N2FRYnpxZkltZlpPQzlnam1CY2Uy?=
 =?utf-8?B?VFBHdm5kN0tIVTQwT1hRbDZkTzhQNEFqRXBKSHdXRldnUVlUeGFZdVpUWWQx?=
 =?utf-8?B?eXQ4b3dIVk1WOEhpbFNUakFyS2x0a0JJK2NXZVY5WlpOVVBwK2ZpTStOTU9B?=
 =?utf-8?B?NllXMUl2Q2JabEdnbXN2ZkFBbzZsQWV5c0ZEd3NKMDZXdm5ZZm5aQ0h0Q1Qy?=
 =?utf-8?Q?F/GAOJ6uPrkyHjq4VvwM+ds=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a208daf-7083-47e1-8992-08dd529c56d1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:22:38.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smS/4Ct5rPtuqPesB67pThO5lIgBzLZP50EUvATaKJgHpqk68HAqtbHyEZL7POEPa5xJzqokStcMnEH5YfaBvWFmQomjDtwa0VtDffWZcEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7511




On 2/21/25 1:33 AM, Catalin Marinas wrote:
> While the kselftest was added at the same time with the kernel support
> for MTE on hugetlb mappings, the tests may be run on older kernels. Skip
> the tests if PROT_MTE is not supported on MAP_HUGETLB mappings.
>
> Fixes: 27879e8cb6b0 ("selftests: arm64: add hugetlb mte tests")
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   .../selftests/arm64/mte/check_hugetlb_options.c       | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

>
> diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
> index 11f812635b51..3bfcd3848432 100644
> --- a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
> +++ b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
> @@ -227,6 +227,8 @@ static int check_child_hugetlb_memory_mapping(int mem_type, int mode, int mappin
>   int main(int argc, char *argv[])
>   {
>   	int err;
> +	void *map_ptr;
> +	unsigned long map_size;
>   
>   	err = mte_default_setup();
>   	if (err)
> @@ -243,6 +245,15 @@ int main(int argc, char *argv[])
>   		return KSFT_FAIL;
>   	}
>   
> +	/* Check if MTE supports hugetlb mappings */
> +	map_size = default_huge_page_size();
> +	map_ptr = mmap(NULL, map_size, PROT_READ | PROT_MTE,
> +		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +	if (map_ptr == MAP_FAILED)
> +		ksft_exit_skip("PROT_MTE not supported with MAP_HUGETLB mappings\n");
> +	else
> +		munmap(map_ptr, map_size);
> +
>   	/* Set test plan */
>   	ksft_set_plan(12);
>   


