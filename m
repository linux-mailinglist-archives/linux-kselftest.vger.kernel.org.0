Return-Path: <linux-kselftest+bounces-33748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A06AC353E
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B6416CFDC
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4321F4C8B;
	Sun, 25 May 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f6b6z9OR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42338F9C;
	Sun, 25 May 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748185063; cv=fail; b=fZOdiHjzxCoPeFv2S80kvDWtMeSzxy2C0vPMGENqxlzKw5U+TTLy5nJhjHoWWmMHHJbwCewbGSHnI9N3I3IxZT6CLi8ACDogE6S2sgSLCTLqZGs4pRb7cMcUDJLOtuu95V8niJlFO4s2mjYDMqO4JvUB5Uyrt9/cDSHwIJfYlEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748185063; c=relaxed/simple;
	bh=eqxHjFP1slItwHheE+ET/mgptKbEUHFYJb+BEtBun0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5QZrOWD+VUM8EXUGht2JbEf64dyPgFbOtcImlXI17garf+yl1BjTKmZP88X16TJRm7s5hYWVtSoruIGWtmaPDB6fIVdHhj24N7T2cF+HSyVMlOTLXpMpcRIoRrb8Xw1lARA/zT3x6j6fa2V7I1XBxb4H5TDhrY7k18IicWMfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f6b6z9OR; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crTvKitJgYDoR4/4/1RXOUVYTHb22qAbZgIapkYZCq4JRTUetgmfQMOjWUKXp13Umcn+xGEZkEDvaTvGCXdDmxh6GDDeFRSZJzrH2F4ehOvZbCGxWpGZi/ldYHZ8QHS2DVUDo67qG8j5fJY6+3MHAdVzWGAUXoKRQuAG9ZtZzd9CCmcBMMN4wAB9QCi7y+ny/4wlnnMp5+8L/91HZmYeaK1Uqv7hqfnMoM9wYGyapJrwA2q8elS8wH6gbgpIjMa5bOEQSI9wU8GPZnAN7P7rYWNFdT3j7iPrBesPRXBiWjLEEom3xu9PdPWb/xx/rK3bIulz/yGoeVh4Pktd3FqE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s68dYAuv0y+tr+l1WkZ1fUlRMkZk2z0Uj5FfnB029Hk=;
 b=OGjhvq42VEnN9UpmTxyNKvzrR8X+dPNxaCeRkjTzTxJY1SZxLMGXiTOnJZNBn43L6xzz/ahwEnECIV2s+jMkH91vsOFDd1CglHpq2sSpkM7gIvBn/yeY1IHE9fiu0zgSiDiVW1YzB8Zozau5uWwg1w/52XMIKSvC7RdcIssD/2IJIHSOfc2of5nuTAbFnb9ln3NpV3Ux6iwZW870mUC0jaz0w75dIWrg5Pc0qjT2gHNV8qkpsKwIhenwt02CnGVV051zWv7BAcgMTffwQUCc4KrrUxMFuFOtr2QdRmSPMdtUB2qRcacMszycBWhl5LhHubXroEvlF0Phwfs2Ag6okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s68dYAuv0y+tr+l1WkZ1fUlRMkZk2z0Uj5FfnB029Hk=;
 b=f6b6z9OR9TBzsI8nQYPUMvmq77Li57GFEWIST4zmx6S8yCaOXB4s+XJaQWjJYKxcR+LfdVlrFal3EU5uGK5r1+GzOJ186THbN878znd6mwnC0tiC6HLPu9gdBt1Wcgc3azBURUj85zRrParlQ8piRGsH3EApDKFIRK592mlK4QOxKuMJNuwXmc3kxRBAajrV700w/VNpzv9sCWhpjLSMWXEbxK/rlKuwn0mlOhw3tXHRHX7EPdUelICizMn4BND8Bs1jwa9QfkdY9O8Pd+GRLPvzP4P4SCE9026ffq8mz3eWcNm+Y1GhrcR8N1QiWkCgMVsOy9oLfIZAAJuRsU6IJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sun, 25 May
 2025 14:57:38 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8722.031; Sun, 25 May 2025
 14:57:37 +0000
Message-ID: <3dddb35c-d3cb-453d-8e60-70f241abd018@nvidia.com>
Date: Sun, 25 May 2025 17:57:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V10 1/6] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
 <1747766287-950144-2-git-send-email-tariqt@nvidia.com>
 <20250520155301.5217dd81@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250520155301.5217dd81@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a772c49-57c3-4a21-a8a9-08dd9b9c7d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElDTUd6cnk5N0hieGx0ODdhdjVHODNKNm9ROTBIWFFkaDgwQWErSktBK2J2?=
 =?utf-8?B?ZzlPZEFGZlYwMUpqazFMK3FjV0FGbitFL0UzV09DeS9SR3h4US9sUmlmNXU2?=
 =?utf-8?B?OS8xNXhNRFBSWW9hZzk1QmZMN2VXMk5zNjVpYTkvVVg4RUN5aDZCTVAxeGtY?=
 =?utf-8?B?Uzdsa1hPQ1ZwWXRuaHEwbHppUnNGQ0ZicnFVaENrb1VUc1U5WDRWRzNUMlF2?=
 =?utf-8?B?b2lwVTRqc3B0akFudnZwZUdGdnJhOWJCUG1adEprVTNxWkhxYTRTWU0wKzA1?=
 =?utf-8?B?Q01GRDJoZjE2eWwzVU1kSFcwcVhVS2RCaFFXVG9GRHA4QTQybjA4aTM5NW8y?=
 =?utf-8?B?bmJ6eVdRSnJpWThpaWlOTGp6MC9PU3lMdGhWWGFhL25rMFNqUzNycjdnYnNR?=
 =?utf-8?B?SmFSWGtZWm1PNnRzeDhJM2VOMkJwUmlTV0RyTjErQktFSE83ZmtoNllpRWhm?=
 =?utf-8?B?VEhQRHBDSTdaeTFOeVo0VFV3b0dJZlFNVzhycng0QVVUZElDVTF4WXhXS3pE?=
 =?utf-8?B?d1dCa1hOREVjbTVwdTVLN0R6V28yOFV5ZFBBVm1zalFKdWpaak0waGYxLzVi?=
 =?utf-8?B?eFpHR2ZsVTJWcmVMZ3BmNURCd0tkMXFYU3Y0RkZ2dzNkVENLWCtOdi9NeVp2?=
 =?utf-8?B?bnBiem0wRkZUMSt6Z3lhY3pEN1RNNFNTMEN1N3p3dEJ1dXltZ3U4QWVZMEl5?=
 =?utf-8?B?dmdBZ0hTSE9TYlpoRkYzcFJMOUMwK29ITHN4QkZJYkFSZWpjUSsxTzUzTGZM?=
 =?utf-8?B?ZmVZTnZmWXdzSCtXYWlpc1VYc3Zoc2wxc05KdDZ0T08zdzJyRmpUNDFCYjQ3?=
 =?utf-8?B?WU1qNHo1bEtZM3dYVlZTZ3RTSjRpcGJwQVN6TDJTRnF3QmdoalpuVUhPc1NN?=
 =?utf-8?B?TVE0U2RzRkc2bG01bVdnZ3NxbTRLQXZUcjkzVnVuSVpXaFFnNktyaGc4TnRM?=
 =?utf-8?B?ZFJwSmwvNlNEczBKZ2ZCTDk4NE01UlJob0dpUm42dEhvTnZHaVBLSlFzS0Vm?=
 =?utf-8?B?Smtld2pCWTk4NEwxMXhEeFNhU3pUeVdxYU8rQ3ZCQm5iL0tLajlZbkM5dFFG?=
 =?utf-8?B?ZzZhT0lqeGxHb1dNbDJTbEcrYlg3UVZJNCs3bkE0NXRUNFh1QW51NldTaGhs?=
 =?utf-8?B?VnlKR1puKythdnA4bGpWWnQ0RWlEVmUrZ2FhUXRPWThaNlVMVUZRbzV1QTVL?=
 =?utf-8?B?OHZPUUxFTWlTYXpubmJBZGQrMEl2ME9WRkFGS3dPbU0zU2U3NVhPYWlPLy85?=
 =?utf-8?B?TENZZkhxcVJLUFhmZm9FVk81WUpOTC9PZ2J2UkJhRThXRGM5a0lFMDJWUWdr?=
 =?utf-8?B?Wmora3pOSVpVZ1pWRGpWU2xYZzFJNnJzU1pjZ3FpNWhMY0NMR0s1M0J4amtw?=
 =?utf-8?B?UXhDK3JUYkR1N3JieVBvNW84YUFLOEJZb3RKaExOQ3BWbCtUdFROVXdmWExS?=
 =?utf-8?B?bFQzci9iajNrZFZicDlNQlhMTWRxMU9xSzZlZHdyTE5oTWxMZXpxa3NVeDhQ?=
 =?utf-8?B?UmU5V2NrODNyS0YxS2hkamVzTjNyTkJCb2FjZldKWDF6SUgxUDJTWDZYTys4?=
 =?utf-8?B?RTZsZzZHemF2QmsyZXp6UkNKNlB2bzBWQzBDYmdqODhMbThOWjM5RTg2RUVs?=
 =?utf-8?B?MGdmNjFmcUxSMXJzZVhzaHdVSUhTcHMxdldxQ0Y0UWZMWGY5QmYxSEVrK3Nn?=
 =?utf-8?B?enFodXpPVGpjT3hLcDVyZDhmcVJkZTJpeEk5YS9aQmt4L0VKQ0Urci83SDZE?=
 =?utf-8?B?TmFMcjRUSE5CaHpCNTZxdTh0ZjQzQ2pQK0tqWlFBeUVRRzRJZnBQVWp0dzB2?=
 =?utf-8?B?a3ZDa2JQcFlJdHQ5eDVyNndjOFhNOVB0M201TEdCOEtzYXY1ZEJVZC92YXNS?=
 =?utf-8?B?K1VJOUtWSjFlaERsYUdINnppYXJWM2h5ZnZpM2hSVklQT2lCeER4TkF0T2dL?=
 =?utf-8?Q?TJiSw3Fg9DU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVhaa3NVNlVBeUJvTzQrQkZrNUtYQ3d4ekV4c1VYZ1hCVzdYaXYxcnRXZUNI?=
 =?utf-8?B?UGUrUm8zdWNYZ3YwUk16T2RyYy8rSzh1czVoU29jMHVPOVFTVWtnYVEzWko1?=
 =?utf-8?B?QjRwRWtocXBZTE1NclNmTjhLTTdOdW9zLzJvalFJZ3RiY2RGVUF5SlFpYnlw?=
 =?utf-8?B?cEc5eTQzOGk1L2NOKzRzclg1Z2I5YnRkVlNIVWMySWdyeGdmcHlBWklMMWtZ?=
 =?utf-8?B?andpMXpUK29WN1NrcFN1eFdsbnRwTlVvSVNWeklSNHQrVFphY0k3dndpcFRV?=
 =?utf-8?B?K09ZbU5pcU4rRkE3anFGTnVmdFo2OHR4R3NaTVhXcW8vVysxWnVra1FrZlhQ?=
 =?utf-8?B?cDZyakpXdlA0OUtXT1VlU0RaanRHem9vV2JicXdJNGx6K3hvK1hNSGljY1U5?=
 =?utf-8?B?WkNmWEcyNnhPNEY5SlpoTENnVStIMUN5OGFFZmYwOGRDSDFIZVpLd3VQU09I?=
 =?utf-8?B?R3NhSmhRU1dxMk5XS3E0THhNVmFCSndVZmJGOS9GdU1jb09jaFZ6N0htd2lC?=
 =?utf-8?B?eitkN1U4aFYvT1VQcDJtdEp3c1ZTeW5ucjNFOUZKdElQcHZDUTVZdnkrVlpX?=
 =?utf-8?B?OGJFdDNLZEhDY2Q5R3ZYTTAydys1NjFTSWdFTzJ1dVJpUS9YRmJ1TEloeTBV?=
 =?utf-8?B?a2R4QzA3ZUwzWGNDd2ZRNElCVzVzdFBieWw2RHQ3TDE0c3VEdytCdk1tYXhz?=
 =?utf-8?B?T0ZTMWtnK3VISksxYW0waURRbXlJTUZnaDM2bkhBcWUrL0Q2MDljdU1KR2Ur?=
 =?utf-8?B?emlXNEdXNThxeGxVQ2FNRk9WR1pPU3FMMytiZklaQjJwOElqOGo2ckZHK1l1?=
 =?utf-8?B?QVhUMWdrWkY5Yk9UMXk2N1BOckFJTDB4d3QvUnVpM3A1ekFnd0ZQSFNjRUli?=
 =?utf-8?B?V1ozeG5qTkpjMlV2bzBCNmNIWENtcmhGWHNzbVE2akpma2pCYWJkVGljS0J3?=
 =?utf-8?B?NHQ1YU1sOVozd29BYms4WUx4dWk4RkZTakZNMFdCbVNrSk5velN0QklzeWxI?=
 =?utf-8?B?d0NZcnRUQWdHc1g3V0ZmWHhBbFFNSGVEMkFDY2RETTBPMU1WMjRScktOYXNC?=
 =?utf-8?B?Q2ZodTdwR2doenNMUjdxamkwS25BcGYrZ0tOY2pwRTIvZUZYZFI3K0pGVjJt?=
 =?utf-8?B?LzU4VytScVNkQnRWbFlGNWFqY3Y2SVJtemFSdTZYTlRJcmdDd1doeTBEOUVs?=
 =?utf-8?B?akZsbkRQZUI0VEx3NnNrUCtpUC9Jd1hkZFZvalZka21Qa0lVV1ZpRHFWNHJL?=
 =?utf-8?B?WUpUUEhEV2tsQzdtV2ZuSkVGWnU4LzRiV3VvTkFCV25BVXl1bW1lMnZma0JG?=
 =?utf-8?B?dGRLWk8yWGFTOEIxY2tSNTFpVWVzTUxzWnlVVlk1REZIYzFmOUF2bE9OUlZT?=
 =?utf-8?B?NGZTQUdDR0dCSW1ESEVvYUhjQzRoVU0weTMzdWtwYzJRblpxdjJVakJ0cmFH?=
 =?utf-8?B?WkRjaE1CSUtiQXlVSnRsT0VaLzNodXFoei94L3VtdWlGS3lLemVhVVRCUk5S?=
 =?utf-8?B?N0UyazdwMDhSN0tCMURNK2xuNWxzU01JOUJaOWpwMUtWY1RicmFKbHdUS0NV?=
 =?utf-8?B?WlFVbFlvUkdWYUZwYSs2a2l5M0Z2d3BmZUNlZmxmNmZLTEMydmlmNmhwTEV1?=
 =?utf-8?B?NlJzc1E5cVpsdDhleENhWUlpTWc2N1ZDeU5RRGU3ek9nVm0wTm16RXdEem5O?=
 =?utf-8?B?cDVwOW55RERDTmNsTVg2SEpucGpVM1lOL01OazVpQUVyTmpRWlR0c1J2d3Jk?=
 =?utf-8?B?ZzdMdzk4L2pvNEd3NlY4Y21PL04xckVPVjZyMVcwNlNTSk9rT3FnQUV3Skpr?=
 =?utf-8?B?RXBYMmJoT1VKcm51VFJ4NXJCamtZNHk2ck92ZHJmN1cwY2pzbE5vWkV1T05V?=
 =?utf-8?B?cEUwRmQySVRkK0dnemVRYTBqNHVxaHozRG5QMSt2TmtDd3AyUzVXQmZLY29F?=
 =?utf-8?B?VkVOWWROL2RzNFNCT3F1RkNidFg3Sm1pZDRadDVlc3RVUDdoa1NudmJoQmNx?=
 =?utf-8?B?NmpJZFBpeFYxcklFVEZGZm1yVFdpSkZUQmY5SmpkQjVmUFY1M2t6YUtGVVZz?=
 =?utf-8?B?Qm5kUWc0ZEhQTnhaVGNJVFpQRzZ1cWZIOXFsczh1YmMwMEtiZVZuckE0TXZa?=
 =?utf-8?Q?aUhbVirrbS/sDGi9Ew4UeS8+M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a772c49-57c3-4a21-a8a9-08dd9b9c7d24
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 14:57:37.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skrIVkcm4uLpQLQbzBCKpSUw+HkA/Q0h8uPXsZEukOPhyRdkzqCKJEFqaccSEV//UT8L4t942Fv/ElWb14r9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328



On 21/05/2025 1:53, Jakub Kicinski wrote:
> A few quick comments here as the test is failing
> 
> On Tue, 20 May 2025 21:38:02 +0300 Tariq Toukan wrote:
>> +      -
>> +        name: rate-tc-bws
>> +        type: nest
>> +        multi-attr: true
>> +        nested-attributes: dl-rate-tc-bws
>> +      -
>> +        name: rate-tc-index
>> +        type: u8
>> +        checks:
>> +          min: 0
>> +          max: rate-tc-index-max
> 
> no need for min: 0 on an unsigned type ?
> 

Will remove them.

>> +      -
>> +        name: rate-tc-bw
>> +        type: u32
>> +        doc: |
>> +             Specifies the bandwidth allocation for the Traffic Class as a
>> +             percentage.
>> +        checks:
>> +          min: 0
>> +          max: 100
> 
> Why in percentage? I don't think any existing param in devlink rate
> or net shapers is in percentage right? Not according to what i can
> grok about the uAPI.
> 

I thought percentage might fit better here because it lets users clearly 
set the bandwidth share for each traffic class. While this isn’t the 
same as tx_weight in devlink-rate, the idea is related since both use 
relative values. If there isn’t a strong reason against it, I’d like to 
keep using percentages here.

>> +static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
>> +				       unsigned long *bitmap, struct netlink_ext_ack *extack)
>> +{
>> +	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>> +	u8 tc_index;
>> +
>> +	nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest, devlink_dl_rate_tc_bws_nl_policy,
> 
> Let's error check this, I get that we already validated via the policy
> but what if we do memory allocations during parsing one day, or some
> other failure-prone operation.. better check the return value.
> 

Ack. will do.
> nit: over 80 chars for no good reason, the line overflows anyway.
> Please use checkpatch --max-line-width=80 for core code,
> at the very least.
> 

I noticed the current code already goes over 80 chars, but I’ll update 
it to follow the 80-char limit. Will fix, thanks.

>> +			 extack);
>> +	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
>> +		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_INDEX);
>> +		return -EINVAL;
>> +	}
>> +
>> +	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
>> +
>> +	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
>> +		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_BW);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (test_and_set_bit(tc_index, bitmap)) {
>> +		NL_SET_ERR_MSG_FMT(extack, "Duplicate traffic class index specified (%u)",
>> +				   tc_index);
>> +		return -EINVAL;
>> +	}
>> +
>> +	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
>> +
>> +	return 0;
>> +}
>> +
>> +static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
>> +				     struct genl_info *info)
>> +{
>> +	DECLARE_BITMAP(bitmap, DEVLINK_RATE_TCS_MAX) = {};
>> +	struct devlink *devlink = devlink_rate->devlink;
>> +	const struct devlink_ops *ops = devlink->ops;
>> +	int rem, err = -EOPNOTSUPP, i, total = 0;
>> +	u32 tc_bw[DEVLINK_RATE_TCS_MAX] = {};
>> +	struct nlattr *attr;
>> +
>> +	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
>> +			  genlmsg_len(info->genlhdr), rem) {
> 
>   nla_for_each_attr_type() ?
>   or better still add a _type() version of nlmsg_for_each_attr() ?
> 
Good point, thanks. I’ll add a _type() version for nlmsg_for_each_attr. 
Do you prefer this to be part of this patch or should I send it as a 
separate patch?

>> +		if (nla_type(attr) == DEVLINK_ATTR_RATE_TC_BWS) {
>> +			err = devlink_nl_rate_tc_bw_parse(attr, tc_bw, bitmap, info->extack);
>> +			if (err)
>> +				return err;
>> +		}
>> +	}


