Return-Path: <linux-kselftest+bounces-36453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA9AF7902
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6B4583BC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326D2EF656;
	Thu,  3 Jul 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BC2XsUFt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDA2ED143;
	Thu,  3 Jul 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554437; cv=fail; b=MSmp3PywUpmCYVddAt7ZG6n3RD333sg9hzOplsbM2RS84HUO8HxOwlszPam/m5G2BCRLLQ2jTQw9801BuRiE7h7y2E1bSNCtf7UkSEvc5GGrZYRqm5mswK+Q+UGj2elyT4jxoeJ8FGi/uUorBwyPWokKAokPLAncCT0m/bXs42M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554437; c=relaxed/simple;
	bh=2JD6b8s7yVcwsmcOXzl3oJOZqyY4DAlX3PrwpRXVtJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXdQfNzxALz2UccBKqbHHaWBePehwX8zwC4nhfSdHKS9lGrlYxTl3FeoTqLtMebfC58Ns8aOb95+zUGQLPdtSqt/arqTET6zBxoKO4x0R827+fpEUcyAniOA8mg6xQMdKqX19hbCI3o+O0xzlaU4PfGImKzWuCc3jo9dScAV7Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BC2XsUFt; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKWpKEUhQKAGFyBdzfRUOlE2kLBvOY+V/oXiMaD1M22PApeavIRvaZ1B5YUSf7zxjZWiANUc02HmU3Wwb5QmYJHG01Ew9EnrYKEqACN7pg2GmXK7P/M0q3oPUfkuOjQwRtBbb3YZXzgBTBAXF8cIiE/eNFdDmbT66X9j72X6OBFISl7YXLYEoP5kLp6WhGiUE18mJFsrtsj7THZuUoiAYzYtrIUktfD0U9KE2MSaKKIuuKkT7ZkorLaj/D6gi5PbSrjWjvB3U/RFME3UsezARLh2PQo588iWLqCO3keqF6vMU54S6rh77b24U0En7VBIkUQVwRWFRiaZVipitx9G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzQNqwIz4P7pkuT0YjwS5/fhAj9HQDAfXJQYwsKJqwA=;
 b=xyxwNy8elzojS/lep1I4/Y9nRAIFC2PdqJ3++CFNcsHYWCguX5Y7FXa0c+68jFrzUR7XNLarxFGuArv3y5fwxHSr2ay90/vol4FGyZRDASSlPt9U9j4NPw8um1JRMtw5UcZdaWYUSx6ZmjV2TezasuC1leMRMBkJyVszeGZ31hdnb60RfmRvoHz+dY/VmgQXD5TCw79Z7VlZxY35huQOvqJtHde9xHw5jRFnT1A1GeJy2JzA5gRXokCR7cegXsltiM/MpFzR/98G1chPQuMGC2ZQGrgYWFqX6h4us+J/p2XLgHHnCy388R9s217DvT9nGsaWgeUo7FrvBlMfmwWKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzQNqwIz4P7pkuT0YjwS5/fhAj9HQDAfXJQYwsKJqwA=;
 b=BC2XsUFtJL4meU7uaXPGoYdmIRjVGBhBq9v431tmtXVCvJNoVzCLWFDruFF9oLTprsEN8LMiTFq6Dky5g7qfcuC42475/HbKFoGaRAioja5jjNk8vVRwHxTdnwl3iPjVuJgfUrY6dbwCHtxHSUjq4gnO8NdBaJTPDRI24lyEoGCmprlQSWfNh6GMQm3D5Vd31eU/cN2Nqq/Z+Xfh3RJtR5BH7NPcT2gZFEv9fez/K3JHx6IzsTIFE8QfJuMkCFv0DYrUUrXsHOePAFBmtDNDbczK2WTC/MmexrxrKcsA/q9bfwKZimRpRSf6FdPX+sz69Z7aUwBqLjYh7ypRFuht2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Thu, 3 Jul 2025 14:53:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:53:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2 2/7] selftests/mm: Add support to test 4PB VA on PPC64
Date: Thu, 03 Jul 2025 10:53:49 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D7E8E7B2-3F2B-41C5-AB0C-78170806C69C@nvidia.com>
In-Reply-To: <48b7cc42-e5b9-4103-85f2-7a33543329a9@arm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-3-aboorvad@linux.ibm.com>
 <5FA05361-1FA8-4CAA-AF23-7BB0974DA78B@nvidia.com>
 <48b7cc42-e5b9-4103-85f2-7a33543329a9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4adbd9-20ed-4cba-951a-08ddba416d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0ZmdzcxdEVyOWxROTl2QjRMZ1J3azZVMEg3dGFab2JwdndGMmNnTUlPV2Na?=
 =?utf-8?B?U1lJcDlOaWFkUzAyOEVkMTgwa0ZYMitwazJxQTJDOGQ0Q0VzWWRuU1hvb0N3?=
 =?utf-8?B?NWt2ekJvVEpnM3NSV1V5cjlnL2YrRHdmeDNFdmtMU2cweWRSQjZzYzVId21s?=
 =?utf-8?B?ckg2S05oOXZVbUpqd2h0czNucDJObHNKUk5VYnNjZHRpbjVsbGxlN0lYQzE0?=
 =?utf-8?B?bzZrU3pzazJsWmNZNEdVTnN1ZXRQWEJESWE2RXRmVEo4czI0cDJyajlZN212?=
 =?utf-8?B?Q0hsM3FrQTdyS1Z1TUY4bkhPVEFYWEpOc0hvSUQyMnZ3ZC9VdVVMbkZHWHkv?=
 =?utf-8?B?Z0krdUtERE5UcjVGTWtPdzhiTE9Eb1lWY3dNcmxZa2hRWThPZGlmZ09GOG1R?=
 =?utf-8?B?Z2xGbWNWQlozdDVVR3kyWTJqZ0lrMWs0VFZoQjFib0VjZ2s0MXFZakVpa3B3?=
 =?utf-8?B?UWlHNW1MN28remYzeXVIbnRnVUYxSW9SRkVhQjA2S3Jsc1RRREdjV1dYZjE3?=
 =?utf-8?B?U1lheXFuUkdOQWEwakx1NnVFZVVvUmUyUzhSTjBMaUZJOGsvSHN1Z1FUN0w0?=
 =?utf-8?B?dSt5eFZPajM4NWEvYUNsdjRaZmtib3JRSTdaR2FWTmIyaUhlOGo5eSswQkd0?=
 =?utf-8?B?a2ZFQkx1VWZLeEJVZkJQcWpIaGwwWVM3eTdoQlBGdEE5M3lyT1Q1cUpNOTc1?=
 =?utf-8?B?alNOcllsR2wwVmdWVU5wWU1wWTVETlE3Z1I4M2dKZE1mVkloZWQrYjFlZFA0?=
 =?utf-8?B?T0lVZDZtY1pNdW4rMUp2UHBoblhuUTFvUGtZVEw0YSs3b1gxUTVqYzM0VS93?=
 =?utf-8?B?UjhvNWNRaVp0Vi9uOTZFajAzRVhKWXg4WFNhZjgydFJHWThGNmNMZFBWMXQ1?=
 =?utf-8?B?bkk5cGF1ZkFoNnpZbFl6U0pwd1JTaVJNcUFGNTNYVjNSanFIRk9oWFFRY3Zt?=
 =?utf-8?B?aTExZTI3KzQ2dVZ1Z1JvdkNQVTJVNG9jTGpCamttTDFSSWlHWDFyQlk4SCs0?=
 =?utf-8?B?S1EzZElWMFAyQ0ZzRW5jUXU2LzRMTEorSzhEaWJDQVUvTEVqZVRKUTNIN1Qr?=
 =?utf-8?B?MWdveVN3N3N6Qk9PNHQrQXJBOWhWR0F5WHBsejdrd2dCTDRWSi9nVlYyNG41?=
 =?utf-8?B?cmZheXk2TTJtWmpZa2llYU1DVTNsU1E4ZkJ2QnkyUE9xbTlXaHpQVSs3WjNU?=
 =?utf-8?B?REtnMHBwQnA1blVJUkwyZGUxQjg0dnRJNTQ4OExsUTQxeFVTbklZOGw2MkV3?=
 =?utf-8?B?bFF0NEhEbTFFTWVZTFhKRnhKakI1YWQvM0Z3blFXSXJ5Sm02OTdHQU5aOVND?=
 =?utf-8?B?ZmRBRW5EZDcvRmtSWnYrcVhQMWNuTC8yRXE5Ykx2VXZYL0poOHpxSjBzL0dO?=
 =?utf-8?B?T2dRWWU2Q0tSOXl2dU9TSUp4K2NYbzdwUEc4SngvMnlYVG1GTkZBUTdqWFlD?=
 =?utf-8?B?V2NIekRhbVZHbGtzNTJ5NkhBVDFvR09ZSEVhVGlScnRnY1B2OFFtN1VXSytS?=
 =?utf-8?B?TGJyaG9vY2VwMGxoNXlleVBGOUJrbDJpUTdWY05obGVaazRRMjArU3EyQ1d4?=
 =?utf-8?B?b0xIOGJYazBPWGZNVm5aZlRIbEo3TzYvNU5XQ2ZRRnpMTXRtRUdwZTZHK2JJ?=
 =?utf-8?B?ay9PYjFqVGR2TlFXRmRXd1hZWGhJVHcyNk5BcEhWczFIOUxzZ05PSGorRXJu?=
 =?utf-8?B?T0IyUWR4QmZ0bUUzYWoyaXBIaFpYOEJ1cGRNWkVZekVzWHVxQkxsaEp3TjdB?=
 =?utf-8?B?L1c1ZXZNZ2xTMmsxUnNaSlJJMjJWdVVGWERVTmc5VUlQNDZBODA2RkpoNE1q?=
 =?utf-8?B?N2ExSTRPamNxdnpsdXo5TGFjRzI3Z2NDWlhUOEVpODNiOVpybXBFbXFWNU9p?=
 =?utf-8?B?WVZLR1NQc3pOT3JHZnFtTkRKSEYySjhMWnpmdmh6L0JoendTTlhDbzNWb3d0?=
 =?utf-8?Q?vl8OcAAnAt8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTlyRTY1dXpwN3hQRDYxK1IvNGVYSGhTRmw2bm51MHkrckJHUU1uRmFZUjVy?=
 =?utf-8?B?SjE5NXNmc3lBOU1jdmd1UHE4RW01azZlSGtYdE16UzZCRVNIOWhhVmhSZUpv?=
 =?utf-8?B?TldMNTFxeWVRQ1R5YlhPRS90aHVHQmZvRS9LVVh6dXZiS25rakxzL3N0N1U5?=
 =?utf-8?B?Vk1uUExwV1hybjBRT0hxcUNadGhzanF2UDRCbE5MaDAyN3RwakRrcWhENmVV?=
 =?utf-8?B?aEZyUWN0dTRyY2JZSlU2dXlicUtxNC9xUUVpTTdFcm5sOGVFc3kvN1R5Sm0y?=
 =?utf-8?B?WHN1eHZsRzJPUDR1c1F4R0VyWTYzb2c0UFcrd1VNTEtvbG5aeUFzNU85ZGtn?=
 =?utf-8?B?OVNPd0ZLTEJLMnVSRjBDYkh1Z0Z4dTExaHcxOCtaVEtMcFNRZCs5OXNyK0RS?=
 =?utf-8?B?VDF2azBiU0h3RjNDY0RJTjcyRWZBTUN5cHNhMmEzaXAvVUZLMllEVWFkZmZ5?=
 =?utf-8?B?eFh5N3d0R1kzN3VzSWpaUGtiYlgvL3ZoZHdaVVpEWTZqbnJDSUc2UXVnaFlm?=
 =?utf-8?B?cDBLUnI5aHZab0FKdXRneVdvc0d0ZHdwcHY3VDI2SGVUakw4d0lBUXh4TWxG?=
 =?utf-8?B?bDZMS1BHWVh2YWxRcTg3NkFoM2JCSTUvS2tpOUVyWEhNbXVVdTQzdWE4OGJF?=
 =?utf-8?B?VHJMT0VVdCtEODd6SXJvb2xUdVY4Rk81VlltU1JLVE8xUXhvRjRBcnVGMmJw?=
 =?utf-8?B?MjlaREpzMjVnU2NweWJKdGQ5QmMzdEM4S0Q5RmVjWlpzUjZMMzVFQlZBakJ2?=
 =?utf-8?B?K2xJRklWdDRQYVVLQTNvelhwVlhOc0w3TnFVdTZxaGd5cG1hUlJwSVZ1Y1BH?=
 =?utf-8?B?V2tFOXZPT3ZIcHFYQmo5T2FvTkhWRXRRbzVxMHQ3eWRZZElEWnB1N0drVEFr?=
 =?utf-8?B?Sm9YVXlSNHZaSWpRamhYS0JId1R0NkZhL1l3cURUVU4yUkJYOTNnemU4M1Bp?=
 =?utf-8?B?VWxacUhielpOaVRLN2JKV3RpMnNOWFNCcmR5RzRlekxCSTZjZEwxWjZRVXlz?=
 =?utf-8?B?UVZBeHFWNVBpd1ZnWE9QeUpHWjhnYzJ3Mk5wcmxpNEgxSWpZbHdhWGV3SnEx?=
 =?utf-8?B?NmlReVA5RFdTckRmSTM5TGtRQ0FrU2VHQnNzcDNhblBtTE5JNkVvdnc4U2N5?=
 =?utf-8?B?aHEvMHBGaVk4OE5xN0NuVU1HQVFVTlYxMHk0eVlaU0tZYVpMN3hwb3hIZ21I?=
 =?utf-8?B?ek05RVR3UFEwY2dlYzdqUFRwaXFjOXZLajZOZDEyaHhFVDBibC9NRnRrZVpM?=
 =?utf-8?B?aFNnRHJOSFdsVkVFR2hObFZ5TXhBYVRmZ011bnFEeno5R2Q1S2wySW4rYy9w?=
 =?utf-8?B?S1phZXdPNDQwSmI4V1QwQ011NEZCNGFwei9FRXF5L2ZHNEY5eXJWTVJvRzFM?=
 =?utf-8?B?MWQ0VS92bWZpdzhlSmR4b0xyMFBjMGNUV2lFTGpWMUJIaVlMT0NZc2tWcGxW?=
 =?utf-8?B?QzZBcWQ0ZWlXaDk1MnJZeGFrYlRqdUt2U2libXViNEdENFEzcFQ5SG1jTDEr?=
 =?utf-8?B?T2YvOGovYy8vQlVpTzhmd25mRjVxM2xlNWZhd3FjMHhuSnRHN0Q1R0w2czFw?=
 =?utf-8?B?dFNKZi9uOFZ2T3ppQW1Ub2NjSHFZRi8wMituOGR0N2RNQmdVUzl6aWZoaGsy?=
 =?utf-8?B?ZUx0UWMyL2lQMEZjUVp5SWU4TTlDNlFEcHB3Z2FtN3hzdVBLeE42ZWdBT29o?=
 =?utf-8?B?Y3MrOEg1L0hjTzkrNU5scUhrYnFabWY1dmthT09mWDV2MGlJZ2hWdjJSMmpt?=
 =?utf-8?B?V3MrSnM3ZWllZysrUDlHdVJEY2tUWlgyK292MHZOTVg0Zkd2emFZRm9GK2tI?=
 =?utf-8?B?WlFTT0g2dVUyRXg0U1VNV3RFUWtBYXBXVzFzSXkrSE1lZnY0Wm9hcHBjL0ZD?=
 =?utf-8?B?YSt4L3o0S3lmaU9IZ3lwRHlkTS9vVzZHcjREeHFFeU9QSVQ4Qm1GR0I3WGZX?=
 =?utf-8?B?eDNZWUdjajZ0dHVtZkU0NW1JRStFTGVzbmlNNk0yeklkaEVFR2FNRGM2NXFL?=
 =?utf-8?B?MUs0ZmRMcXhZaFNrZ05uRUFxS3V3UnRYMTNONW9oa1I4ZjBiRWNHelJMenln?=
 =?utf-8?B?Vzhad0NHeTFvbnc1RVBSeHFRVCtJSGZhRlQ5bkFuWml5cFA3Y295NDQ3bzR5?=
 =?utf-8?Q?ikt/JsQXQkkiiI8OMDaI5HId0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4adbd9-20ed-4cba-951a-08ddba416d0b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:53:52.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuAGnFpH6t+U5oHnhShNSfhwMRLSxsTUqjypcLUVtYRYQZ2G/eQWSj/sEueaauR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

On 3 Jul 2025, at 10:44, Dev Jain wrote:

> On 03/07/25 8:11 pm, Zi Yan wrote:
>> On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:
>>
>>> From: Donet Tom <donettom@linux.ibm.com>
>>>
>>> PowerPC64 supports a 4PB virtual address space, but this test was
>>> previously limited to 512TB. This patch extends the coverage up to
>>> the full 4PB VA range on PowerPC64.
>>>
>>> Memory from 0 to 128TB is allocated without an address hint, while
>>> allocations from 128TB to 4PB use a hint address.
>>>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> ---
>>>   tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools=
/testing/selftests/mm/virtual_address_range.c
>>> index e24c36a39f22..619acf0b9239 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -50,6 +50,7 @@
>>>   #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
>>>   #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
>>>   #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
>>> +#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
>>>
>>>   #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
>>>   #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
>>> @@ -59,6 +60,11 @@
>>>   #define HIGH_ADDR_SHIFT 49
>>>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>> +#elif defined(__PPC64__)
>>> +#define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>> +#define HIGH_ADDR_SHIFT 48
>>> +#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>> +#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
>>>   #else
>>>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>>   #define HIGH_ADDR_SHIFT 48
>> Could you also update the comment above this code to say PowerPC64 also
>> supports 4PB virtual address space?
>>
>>  From the comment, arm64 supports 4PB but its NR_CHUNKS_HIGH is only 384=
0TB,
>> whereas PowerPC64 here can get to 3968TB. I do not know why arm64=E2=80=
=99s
>> 4PB is smaller. ;)
>
> The border for high VA space is 128 TB for x86 and ppc, for arm64 it
> is 256 TB.

Thank you for the explanation. :)

Best Regards,
Yan, Zi

