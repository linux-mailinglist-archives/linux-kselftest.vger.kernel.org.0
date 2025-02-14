Return-Path: <linux-kselftest+bounces-26680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B641A3658C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AB53AEFEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC12690C3;
	Fri, 14 Feb 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdhGv/t7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029F268C69;
	Fri, 14 Feb 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556865; cv=fail; b=QUdgwFyUZW9yESvP0gxRd4hXuEBWJjRvXHDmEaE353nMLQC1fC+B2vIs5nvKL3zNUmbfVPV9HZW3vfrx2stndBC9ig/pNVjpdk06TH9twj19YvjTI9FXusecj/DF4l+QBTDvBE5fqj2gb9l/dbySvl4127DmJbhm3TpDgPyNAPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556865; c=relaxed/simple;
	bh=Stm8KoDp9N4keSS96mrxoJEQptZHffMzeIMDIOhDBAc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MI27tKMmex6c8EV5Qg4OeQvc4tv0BueQEQYyCraEDGP/SwikNZ0I04kXVhFHFb1ja9t2+58jV7xEMIqraFymFx0uQxhZonGp55ocnCXlF9ZT6yhca9LsxQBnNynFT9ts2tR3kyFT3/LEMzh3cMfaoCNAR9gtPn7dAdOux3LmU/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdhGv/t7; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzhH/hrK7yDvWFN/cTpTbZBp5UV36Sa3n4ht6fOxGr4AMIl/FKlgvRMTM800HJTtzRhtVKtudf7wrTtd80iJr+4wWqnm8WdD0/FarMlEii2QJcJQCE9/bi72BHh6t0T1x6BtFtNGCr2ED/FOpFiP5SuARv9UjUBSyw9kr4++JSb3ZE8LIAGk5+Ei0ZZdlm34FU7hTAeZq59eN1y66aByP9R/sshkmgmWW2pFqreNBTsOYX6ETCmcRPNlKJZkq94stFndEjMocopdGBOV6sjFR5pS3jTdDlfrQC2HSHCPOxuiiKev938iIuzH+8MlDgr6AbR1Uj7nzD9sHcqDeTHeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBuXNLYS12lfAS6YZu8EPKIr13iWXkxNTk6eG58nJi8=;
 b=VApoNBD/lYUh42VRtU79w4Hq9aNazJPLbVeOT86uSp0ULJAVTozsnHTfk3wq0vVVKj5VBrZrp7GSDBpFdOc1VTxZ7oR3ji0CgzjT+svOE1rtCEM+0hVy+TV0SxnfQbBeayGudPK+0JCV1yKctFpBAT5xSvKoQMBhSORZTmE+borCo0/8xxNiZT4wV1A7FSHZwun2CwWYc1v7PbKh4tDZrubFMBbfVXUmBOc0rU0htdLjRcp+HeRFW9eBCbC5l1hZ07Owt66oUcORtsIfEFLjolJe6YMXmCepPeJ67UHAi4i7z5HREKLCyJyzh3cPqoulQxKne0H752zfnbFveb9klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBuXNLYS12lfAS6YZu8EPKIr13iWXkxNTk6eG58nJi8=;
 b=sdhGv/t7BLq/aFR3uTC013P8IQG3mbWcV+8OCP22we6ovDMqUTcq2s/xn1iOHxUK9i7E/v6lyENzXuEvGiOHNeZZFoepIGzjahSvrzbmett8wW5+9PpOqu7XVTbDJCTsNRuDGPOrEkVeI7DEbmiSY/cdKVEF1T/HFtSQwkJK6EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 18:14:21 +0000
Received: from PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f]) by PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 18:14:21 +0000
Message-ID: <e3136d20-977a-4e2d-ad7b-c04be1dca1db@amd.com>
Date: Fri, 14 Feb 2025 12:14:19 -0600
User-Agent: Mozilla Thunderbird
From: Pratik Rajesh Sampat <prsampat@amd.com>
Subject: Re: [PATCH v6 9/9] KVM: selftests: Add a basic SEV-SNP smoke test
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-10-prsampat@amd.com> <Z6wIDsbjt2ZaiX0I@google.com>
Content-Language: en-US
In-Reply-To: <Z6wIDsbjt2ZaiX0I@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::21) To PH0PR12MB7093.namprd12.prod.outlook.com
 (2603:10b6:510:21d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7093:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed21f52-e2dd-4df4-c5ef-08dd4d236775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzZIYUovSmZOUmkvTzQ0YmlDU1BGK2NHcXNZWm9wT2FVTkdRcUpwdzU1SVRS?=
 =?utf-8?B?cjhBK25ybTdlLzJWaklBWnVwRjduVUFmZ1cyNG5QemNLVEtpNnMxUHB2SDFo?=
 =?utf-8?B?S28wZmkxT1pWc2NQaHorQSticzJFb0NxMExuaXpMRWNpQkswbmloMy9OazJV?=
 =?utf-8?B?SnZzQ0NORTN3SjZtMlc1RlRsdk5GbzdldDFPYXErK3dhNjlZUDgxc1luYlpj?=
 =?utf-8?B?VFU0Tk8vc2tQTE90RTFuUTNjVlpUTnJZeEtwWnlMVSthZ2dkVll6NExBcXlL?=
 =?utf-8?B?ZDhjN01QeW53MUdjVGRvVnh6T29rTWJwZE5DTXFwNXpHS0FiUWM5czgvVmtX?=
 =?utf-8?B?V3k2Rkc4QzBWWkF6cHFzbzN1dDZKQ0FpTm0zNDhTZ29zY1lqdEphSHluRlYv?=
 =?utf-8?B?L2NsM1hRY0FPMGJyNFdTRW12cDNLeS9STGhIL2tqYlE1T1NlcmN4bWVRdEo5?=
 =?utf-8?B?UG55OHZTNU1FSWNvSlY0N2M3dGZkcjlReTIyMnRNanZVOFFpWFJleTd6cWtl?=
 =?utf-8?B?SG9XWDMraVkwZFhJcDFPSHd3UStkZDZpaGhJdHE1R0VSejNYajlqcEFqS1VJ?=
 =?utf-8?B?WVN1SmNnYUZsZ0Z1d0lKc2VGdy9NMitobENpSmZrQnBKdDc1ajRvd3AwT3Iy?=
 =?utf-8?B?Qjk5RWtxYjh0dXBwY1pXUnBNV29pajlsT3Z3QjVMbjUzcHN5cmdCUi9Ob3JV?=
 =?utf-8?B?czMySG1iUGhZY1NCdXFrY3VJdVFGdWloK0wwbkFCbEkwR2lBMTF3NWVxWEo5?=
 =?utf-8?B?Z0Y3elRoOC9LaElObDYzVSt4UlNhd1B5aXA3MTRrS1Z1RCtmaWQ3UGJ4KzlB?=
 =?utf-8?B?UThtL3E3RUdTdjlrUHdEVFV5WmVZYS8yZU56cXEzeUw4elVnQWcyTmoxbjFX?=
 =?utf-8?B?eW9Hcy8rRkRUUTJqMkVSVHhVUUVOVU5ZV0EwVmZwMWx1VEpVK3U2TVY4RXhK?=
 =?utf-8?B?ZmlUUnZkbjNVY2xWRzBwRjg5ZktWejNuUUFkSnpnUkVSZ1dabG5TcU1YMExF?=
 =?utf-8?B?aGl6dUlVU3lXTnNJZUlZK0svc0QrWEhNeWl0b0dzVEIrSC9oWHhDMWdSMWUz?=
 =?utf-8?B?UkJkQW5aRDd1T3RFaVltSExPYVNNM0hhK2o5N1l2c3R3b2FQN2NWZUYvSzRs?=
 =?utf-8?B?NjFYNlVWak5FTFFodTR3UG54UlFLK0pzVGZqQVdzMzM3RFQwUU9LMWVRVXVL?=
 =?utf-8?B?WEZod1FRRUpCWWQ3T2Rnb2d6SkVjOENhMThKUWpHc3Z3eUR5OWpFbG9tM2Zn?=
 =?utf-8?B?cVFmSVBscGJZYzd3a09SVTFCQ1JFUU9wL2xFM0ZxVGs2K1M5MXpXZmdReWlU?=
 =?utf-8?B?U3JSRk11MWJQWkgwQTRNZ1BDSVgrM0ZtT2M5azBXMllvQUtvZm9wLysxU1FZ?=
 =?utf-8?B?OG5ia2M5OWF1R3ltTlc0QUVSS21zdEtaTC9RQ2tPOE1mL0s5Y0p6aUZYUHk4?=
 =?utf-8?B?L0Ixakcxc1lFYzhzMnFKN1MwRVUzUFdZTjFBb0xiYVFPb2Y5dzBDb2prcmg3?=
 =?utf-8?B?RVNyUTVlSW90T2RaVHp4bzBYK0VZcml0YnhSTThRVXkzdFNDR09VeGxhYloz?=
 =?utf-8?B?UmZJeHFZUmlkSE5LVVV1UG5wM0xiREJ0aSs3dDFRL0JKWlo0UW1Ec0g4b2Jr?=
 =?utf-8?B?djBNc2l1WnpCSFJZYkZmUE41WnVDcTZRcDB0VFMxTzJrN09Mc3A4L0RrSFZP?=
 =?utf-8?B?YzlNcDVrc3RDbktjeGtKQzRNVjdqMzUrM25qa0l1akw4aEthV1J4TWNIL3dn?=
 =?utf-8?B?Vy9tTG1kSEtpaDFEbzJhUHRLMGd0eEpBcnNNMHY3SVN6WkpxbEgxYnE4QUdB?=
 =?utf-8?B?RkJTV3Z1QWFmM29XbGkzbjBPalJybkxSVURDV3g2dDBWNms4dFkvRU1UbnRK?=
 =?utf-8?Q?D1JseH5E3hsqY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7093.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXhYV1FXSkZvWWlKQjhvcUhsSFBZMWhDYklPZHBhejgxQmNKbk4vTHd5TCtS?=
 =?utf-8?B?YXFwQWh3cVJobEk1YVgrcHowVGluZy85eWc0OU84RXVtTXJYZG1yR2djdS9u?=
 =?utf-8?B?UW93VUxtSFNBTm55ZmdTZ1d5ZWFKencza3lFOENYempPSEQyK1FaM1VXMDdW?=
 =?utf-8?B?dVBqKzNCbTB5YVdpV0tINHo1SU14UlJQUHVZbWNNTXhDQVgyZEd5anFqcldO?=
 =?utf-8?B?THJBR05NMlJPYzYzZnFzMXVwSlJPS0M5bmkySkdpdDhGRnEvaEFxOURZQmhY?=
 =?utf-8?B?NUxHVjg3SmVMMDZXNjk1WS80eC9qa2swV2NuK2p0K0poZ09WclY0bWd5VGFV?=
 =?utf-8?B?Q3IvcDMzUXZwb3NodDN2SGxoeldQNGEycmlEYmZNRmZHQ2JQek4xR0pzWXlo?=
 =?utf-8?B?cDZOMGt4b1g2U2NWQ0szZmFxUjJxemdVNlBXSFRCTEtCMUZ3NDhNa2JyTjJv?=
 =?utf-8?B?cTNMU3NtYXB2RlBqdXF0R0VOcVlIWnhYOEdiRWdLSHFqUTR4Y1paNEdqbGpI?=
 =?utf-8?B?YlVOZWRJeDhaUFdqdjBpRGtZanRIVzFxNUhFa0tXMnRnZFpvRDF1dlI1U1A3?=
 =?utf-8?B?SDVyVHM2cSs3bXJjdHBXTXBuMVZUeTAwTjlDcFkxbmJIcC96OWhXRittVEJD?=
 =?utf-8?B?TWFSc29UOGFUSDJ5VTlMUnBXQnkvZjA2cDF1dHA5M1ptNVdsQ1VKTHE1QS90?=
 =?utf-8?B?VzUyYnZCR2s4aHR1b2NSUEZESWttRjVRUjloT080ZlI1M1Z4VStxRWQ2TmlB?=
 =?utf-8?B?amcxSmxNbWQ5MS81VmE0YTBSalhCQ1lEY213cTNvL2s3VEdLU3lkekF4bWl2?=
 =?utf-8?B?TUJHaExvRjV3N0lBZmlLMlZYb252eU9XMFpENGNEdU5yYnRHcUs3UkdVQkZx?=
 =?utf-8?B?eTJuUkZxRXZhUGdDa000Tkg5V2JJQkJYbFJPOTdhYkNyeWtnb1ptWnlKQTVF?=
 =?utf-8?B?SXVrOWViM3plM0psUzh0SGs2VDRMQ3NmMzA2cjhpclBPT1l6aDhhdlBRaTlD?=
 =?utf-8?B?TG5Ob0ttZFRWZ21kSWcwUWdJdHd3YXhNalViemxJUEJBbnpwNGh2VENhN3pD?=
 =?utf-8?B?d3lkMSsxelptaU9FK1oxLzUxNVY2aEN0NzN4Y1cva2F2WXRoelRyb1pvOURB?=
 =?utf-8?B?QWpiakFRM29GQlhTaXQzS1dDOURhZCt0VjRrNzlYV0w0Z2pkZnJTaGxZaG9N?=
 =?utf-8?B?MGM4MzlKRFk4OGt4NEk2Z0x1c1M5VlBtUjJnUTJZQy81QXppQXhPVlVNczEw?=
 =?utf-8?B?N2EzNVNHSWNmTkpnNXpKMk5NR3habUR6aXRXUDkzUHFHYXBHandkVlhSWkFV?=
 =?utf-8?B?eGVORjRjdVFqTHR1NVBvbGNYUC9ublNKUTVKdEcvWjlBMzZtTzdwakNLUytr?=
 =?utf-8?B?Y2M5QS9pbkk0Vm43Um9sWVhaUXZWZjhkTUY1cFZoMGdoSEFLdzVUK2lUL2JW?=
 =?utf-8?B?Qi9mb0pSNTFKcFRYVVZDMFZzL3ZUczBkM3RnZ2hXRGpyUlp5d0tXUkpScTlx?=
 =?utf-8?B?R1BSTUdiMHJmdmk5eW5QTmw3cTJxM0krZzNKWHFaZDhDc2xLR0wxQXVleSt1?=
 =?utf-8?B?RmZrcUMyM1R4bXZIOS9MODZ2WHBpWFZNY2JQYVFIRE1rYkZ5WWRVMjhSSEk0?=
 =?utf-8?B?ZVFJSXlDQkJaZHQ1Z3ZESEVNRk1wbC8yU3Vpb1hrWUl5NGdGTTNla0Ridk9C?=
 =?utf-8?B?eVFEQ1o3dnVSMERYYUdCd3JCbmd2VG5UR0p4QjQrMkNOVUlUamc4S2YxWmhJ?=
 =?utf-8?B?ekxOejh4NzduMEVUUS92SkU5TTBDL3RxaisvZ3l1UGNxM3J4UkpycVRQME81?=
 =?utf-8?B?cTFzdS96TVFCeldiYUhENXpyUmRaMGFZTUpVUnBuMXRMdDV4OW9wcVVDU0R6?=
 =?utf-8?B?b2RORGhoZ1FRcDJaTzZqcStzd1JiaytPUTFnTzc5Y3RBK3RzMjA2UDJRM0Ny?=
 =?utf-8?B?Y0pUa1ptL0xCdExRcnNaRVZQdUNpRGJ1Z1hjMDRrLzRXQmRKaU9WWlNMVk8v?=
 =?utf-8?B?c00yQkxXY0NaMVJVN3puNGUxekVjUHNNT0pHdUhEbTZ5bWlUak1qRFAxS0ov?=
 =?utf-8?B?RSswNzBob05lMll1UkRQZW15bHN2TzZRWW1LYjJ4cTlOYytNSTJEOEcyamNs?=
 =?utf-8?Q?ZTCkfU8z6S3sS6ADtpVgtjhY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed21f52-e2dd-4df4-c5ef-08dd4d236775
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7093.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:14:21.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRG2aXjPBRFe/PYrIOho/FyGzMEENF6zkfjuDlMdPCddffHdcAo0p4kyAqjosByn1mjL/oy2GKMzNxh15ZzQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192



On 2/11/25 8:31 PM, Sean Christopherson wrote:
> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>> @@ -217,5 +244,20 @@ int main(int argc, char *argv[])
>>  		}
>>  	}
>>  
>> +	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
>> +		uint64_t snp_policy = snp_default_policy();
>> +
>> +		test_snp(snp_policy);
>> +		/* Test minimum firmware level */
>> +		test_snp(snp_policy | SNP_FW_VER_MAJOR(SNP_MIN_API_MAJOR) |
>> +			SNP_FW_VER_MINOR(SNP_MIN_API_MINOR));
> 
> Ah, this is where the firmware policy stuff is used.  Refresh me, can userspace
> request _any_ major/minor as the min, and expect failure if the version isn't
> supported?  If so, the test should iterate over the major/minor combinations that
> are guaranteed to fail.  And if userspace can query the supported minor/major,
> the test should iterate over all the happy versions too. 
> 

Yes, any policy greater than the min policy (defined in sev-dev.c)
should be supported. The sad path tests were intended to be added in the
upcoming negative test patch series so that we could have the proper
infrastructure to handle and report failures.

> Unless there's nothing interesting to test, I would move the major/minor stuff to
> a separate patch.

Would you rather prefer I do the happy tests here (something like -
min_policy and min_policy + 1?) and defer the failure tests for the
next patchset? Or, I can remove policy testing from here entirely and
introduce it only when the sad path testing infrastructure is ready, so
that we can test this completely at once?

> 
>> +
>> +		test_snp_shutdown(snp_policy);
>> +
>> +		if (kvm_has_cap(KVM_CAP_XCRS) &&
>> +		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask)
>> +			test_sync_vmsa_snp(snp_policy);
> 
> This is all copy+paste from SEV-ES tests, minus SEV_POLICY_NO_DBG.  There's gotta
> be a way to dedup this code.
> 
> Something like this?
> 
> static void needs_a_better_name(uint32_t type, uint64_t policy)
> {
> 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
> 
> 	test_sev(guest_sev_code, policy | SEV_POLICY_NO_DBG);
> 	test_sev(guest_sev_code, policy);
> 
> 	if (type == KVM_X86_SEV_VM)
> 		return;
> 
> 	test_sev_shutdown(policy);
> 
> 	if (kvm_has_cap(KVM_CAP_XCRS) &&
> 	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
> 		test_sync_vmsa(policy);
> 		test_sync_vmsa(policy | SEV_POLICY_NO_DBG);
> 	}
> }
> 
> int main(int argc, char *argv[])
> {
> 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
> 
> 	needs_a_better_name(KVM_X86_SEV_VM, 0);
> 
> 	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
> 		needs_a_better_name(KVM_X86_SEV_ES_VM, 0);
> 
> 	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
> 		needs_a_better_name(KVM_X86_SEV_SNP_VM, 0);
> 
> 	return 0;
> }

Sure, I can definitely clean this up so that we have less duplication of
code all around for this test.

Thanks again!
Pratik

