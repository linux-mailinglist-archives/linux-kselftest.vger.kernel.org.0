Return-Path: <linux-kselftest+bounces-27092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62434A3E1AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9946519C6499
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136B20C00D;
	Thu, 20 Feb 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TGpBSv7s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AE17A2F0;
	Thu, 20 Feb 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070579; cv=fail; b=Ypyf81Bdxql1YDWbXxmOJwFU9+RVhvCvRo5KWwOs64ZlBr0tdVzhlCaiK1uMsZK8s265/s0V7BFFbY9BuPJBaMjDyDaYK6GEuHv6pgfk7fT+mkh0lAFsNwec12DEycvsWWUKfM0QnA7h7TCU9S2uofYEq/299tl4jsTh5BiCpGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070579; c=relaxed/simple;
	bh=5rxotAFbPU1Mz3TiSaoWHEeE672X5vboVRmknwcMT6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J88kNE2Rsv8jsMzlTQWqek9YalCEagki2kORc7NoL6yZZrnAvf0WgZt5CW8izNdVdAKvulfvpxtWbrWAqG+IoGGl1waPDyqXqBD9qJl19MNMnWXjOqMGQgvOlnnr1suQVgmWC0q1rpJy1qWZ+bvmP5HFaVhesCE00qDpo+nlg60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TGpBSv7s; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW+EwnSGJloXf3WusifbY/0thLHe72rOcvTV9W9UtJDbv8rS00BMV1vNi78zunztd4taEhVK6GqvV6szVgA6j2D0SON+f/uG+hVVDel5Jqq0LGdAP4IU2GxU2CUtaFY9ddG63fRtW/vMb70DuuTPtjPAn0QERtufHPZCGabg4pRRT3Iru9SINTzKb8TtFNLj5o/5o6qPv9LzW7aPyYsaDuHe8hWBkK1x85febnQY9keVAVFRYRpnrbkKC99mDW0iX5Ne239bCri64Xysb3qH0NqTt4iSW2kGBC7+q3XUclCnxw9vPlrdIx8DGhldQVb4cQ/IMFpURIf8vrhMHxv8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HxxE/A/zfWy/8taLKaULkgtUVrVfZA9XI89oehlev8=;
 b=l7evWMqndVIRtgR6tlIt2alWQywTreENfm9r6U/8f/vFMjl2xU8O+edjYgjyZDzP7+V+gFfJFxBfx049iWdKsv0yLUb3t1fzyeQt2CW34MqABMUzabSMdXFBVOBbupfAifHzn9XepNxX9EqPag8cvcf+8Kfm0xJcg9eyWamynJ3OOxT59AJgPWUpia311amEcHVP08n5BwLVVhFBanIJEe3Gf/XzrZPyO34igonvJ1Zg5Iku3K7nN8i+HmmfN9PPGyeCMyssQOB8E7cnhXLO4YTIa61xuVNL95NAiNux+/jEQ1rp7+h6sXBFos3quOYHIBgsZp7KPCg6vo1AU7bP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HxxE/A/zfWy/8taLKaULkgtUVrVfZA9XI89oehlev8=;
 b=TGpBSv7sGxZa1vwGIiIra0YOkFDbsiPv3/ViywaYPDTgZZnNAh58p4hQqUgYy0YwLjTsL1bNMElE2Il5XBZSJxBsdhi522eUbMx7mcRa4aWH6FlCPoWURYPR8mq90EO8bnTEFzgjgpXzZMg4mVI66YHX2x3c2MO0PyHJAZgjGRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 16:56:15 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:56:14 +0000
Message-ID: <a0b3ca3d-4f16-4f2b-95b9-cb7df51b2f09@amd.com>
Date: Thu, 20 Feb 2025 10:56:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] KVM: selftests: Add library support for
 interacting with SNP
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-7-prsampat@amd.com> <Z6wDiOGjSElatLBd@google.com>
 <ecaee27e-c121-4831-9764-043d2e6230cf@amd.com> <Z7YM-hu-xfVGbAad@google.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <Z7YM-hu-xfVGbAad@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4af7ef-1883-456c-e369-08dd51cf7c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXcyRzBDaGNuSlVRUjk2UjB3ME9WK0FaNnNnbldLaG1BakNYOS9FZVJOdTVv?=
 =?utf-8?B?bmZTWG1nT1FoYUU0WFVZdHpkc2Fvc1JKMDRIbXpJMFBiUysyZ2tnL0R6dml2?=
 =?utf-8?B?aWlVQjFYd0pIaGdNOWR3bnRqSVArMXdNRTYrVTc0ek5Ra3pkQzhrc281VEZk?=
 =?utf-8?B?RGhXUHlWT3lRV2NuUWJvR1lNU1pYTUpxTFJ5V1g3V3ZWVjF3Y1ZIWHlRZURU?=
 =?utf-8?B?Zm50S2Q3SnBSRjFCNVlEMVQvVDBTQ2dweVBjWElaZ1RJcTVjb0p5dmNSdXQr?=
 =?utf-8?B?dHAyNW1CVWdvNGtaeXI2VUkxSkNtOVozaU81Vi9YbXlMN21iRml6dXBCd0Rv?=
 =?utf-8?B?L2dBT2ZCTVExMFNBS1c1RG5teTJObTZPRTdCRHFBUWpIaU9yWjBXTnpDQ2hX?=
 =?utf-8?B?MytZd0VKdWtZUHYrWWFoUjRVU0x1S0lYZE9jVEJCUnBnbjVRdUd6MDM4RHhQ?=
 =?utf-8?B?YW9zeHNFaWpwV1g5RmQ3T2xSc1JZQUg1ZjdNUnh3cnZ3WmNqZlkrYzAyZGR2?=
 =?utf-8?B?QVBQMWpqT3h0NVBnL3pLVGlCdHZIcGpBQTlCd3hBdzJ4VnlWWURiUzBBQW1F?=
 =?utf-8?B?NDVZb2ZmQWtPendhdGFzRmFRd09GU3JQVk9yVmptK0dOSFJralM2bkdNa1ZH?=
 =?utf-8?B?N3U5NE02QXhUcENxSXFhemJHamdLV1cwSmo1UVV2YVI0aHltS3cyYU1jOVUz?=
 =?utf-8?B?eFkzbkZXZm5rSWZja3NDUE9STTVLbnJtNDNpOWJUc1JIVDhyVHJMdExHTHlL?=
 =?utf-8?B?b3M1aHE1OUZKd20wUFJlUW0yRTZZU1dZaUY3akNob1dWT1QzcDNIL0JVd2FC?=
 =?utf-8?B?YWJ2a2YrMnV3eUppWHUxZGpaUmw3WUJtZHJ3Qktqd3E3RnIvOWpIUS9NMHVh?=
 =?utf-8?B?QmkzQU5naWJ5eXczalU4N2FjdFFJN1Q2bjhZNEQ0RXdMS0xQcHQzaXVSYi9y?=
 =?utf-8?B?UGM1YndCWmZKZkI1NzZCay9VeWF6S3VPQVRTaHM1RnVUTzgxanVFb0h3eldo?=
 =?utf-8?B?U003cXRIWTlob0NwNVRSRENrQ2lwekhNVkdiRjJscHlLQkFNS2JEVWhzSzJu?=
 =?utf-8?B?MjZjSEJsQ2tXUHB1UXdaVkJnM1FDR1kzMldYei9uOXdTeGJ3RUtpNWlXNFEy?=
 =?utf-8?B?dUViKzZkNmhYdHVKMXBwckc0elprbzdmSVNYNkdNcEtUbzV0eVBVTVlQdS9x?=
 =?utf-8?B?QWRFem5jcVlianFHT2VGSmEwME1IRmFuajBSVTI4Ty9GcVp3Njd6c012K0Rs?=
 =?utf-8?B?RWkxQUpMOERHVWZ6Wnd1K1JsQTgzeEJTVmhjcDNWaHZiVVZTN09hRStUbjV6?=
 =?utf-8?B?VFBSRjMzc0tLOWY3b3VVeWdWeHVIaC8reEdTaWlsY09lUWc5S2xjRzNFdlhI?=
 =?utf-8?B?YXpNbGlQL2tCckFMWk1yRzE2R1dnZEI0YnhmVVk4WTB2WmtmZVN1SkVvS2hO?=
 =?utf-8?B?VkhLNXpTVTN3MjBiWjYzSlFHTGZEbUVtV3hoUTEwdS94cTRMSmt4VVdJUG9E?=
 =?utf-8?B?bisycUg5NEg1UTFSKzVQT004OUF5Q1ZTbllwZFRyM1E5eldSR2lMa1RzTHJ3?=
 =?utf-8?B?ZW5MR3EzSE95VllOZUN2YW0zMlJwbW1sS3VzUWlvN1A1U0ZScFJTZmFzTHpT?=
 =?utf-8?B?cDFrSUJURGtnMnIydnpPQkgydW8vVXE5ZCtHM3hkcGtKM2czTXNQRmd1Z0Jm?=
 =?utf-8?B?MzU1QjNkeDdoRjlyZ1htNEdZZmlramY5bU5TR1FsMnZFekxrWnM0QVpMT08v?=
 =?utf-8?B?SGlqY1pxd255ZmZLZHpYS2psVXhtdmFueHE5Y1ZjeVpRWHAyTTlvZ01Xa2lT?=
 =?utf-8?B?QVZUUzdOTXl6R0hvOWs0Q1N1YzFRR1J5c3Uzdk9uWmwxZEh6dHo2QVZtc0Fp?=
 =?utf-8?Q?GwIBBcstlkZxs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0pCOSt0ZS9JM1hnSDg3aTIzQjZUNlhqL0ZZRVJHVWZwRVRMZThFT3NHMDVR?=
 =?utf-8?B?OXhENDV6Z1lEVlgwUmxsaldQbjVmWWZiRFlGMjE2dUlrZFE5MjR4SlAzUlRj?=
 =?utf-8?B?VFVORUpaVEI3UHE1V1V4NmVEMDg4SDcvL3d0SjB1WEZkOVU4d1hHMVhDUy84?=
 =?utf-8?B?a3VpdEtBKy9DYnZLZ0Fta3llT1BURm1samhSdW9zUVA5YkhtTVRNR3VUVTVo?=
 =?utf-8?B?ZzlLMTBxQmZvKy9mSHcwc1MxNkJxWXNZWnV0V3NDWW1sVHdHYlE1VGd2RnRQ?=
 =?utf-8?B?cjlnbnVkRU9xRnI1dXV1QTAwMkpXZTNpdDFnUGRCNVpzZzhQNy91TUdRc3Js?=
 =?utf-8?B?TWp2R0JDb2FPT3RXNlFzQjNwOWh3cWlkUE45V05UcllYekRZYnNWUUh2QzJz?=
 =?utf-8?B?L0NhNjFuM2Fkb3h3bnpTZTN1SXhJd3ZmSzhsdENtM2ZxZXJuVFFUR29LTGhL?=
 =?utf-8?B?bDNKT3VZU0hpR3BndW8rMm10L1JKY3ZxTkFBQ2JEZXowUk9TV2tLRHM5RUZ2?=
 =?utf-8?B?cWFlb2p0M3d5YkNReGNtWXo5UHhWbFd4Z2lYYzhNS0FWb0cwcmtLdlhyTFlq?=
 =?utf-8?B?RlhsRjZ6RWpYU2Jkb0JpNk1FbWN4Z0VSYVpkNzRnMk9QN290QWtzNW5za1h1?=
 =?utf-8?B?cjRTMSsrclRPZE12NjYvMTQ0anFETjJFRlRVdGhyRGRDYkxkL0g3dW5FcU5I?=
 =?utf-8?B?VEJ1NWdvY0pCekRnK1hRNUxNU0prZFNQMnR4TlZlQytYM0JkZFAxcWhYd1o3?=
 =?utf-8?B?ME82d0djVFRVWEZsRlllR0NwMXRXMVlDOVJMZkJsK1dLZm14MlJWVnYxdWp4?=
 =?utf-8?B?S0Jod0RnMlBGUWhjbUZWN0NQYkdJMjNWeU83Vko1aXRGZlZzK1RXSGpwZ0k2?=
 =?utf-8?B?RTNPdkxyZHZEZXgwVmVQTU1uSm51UmErcnJXYVVqMmFVNUFJWERML1dwa1d6?=
 =?utf-8?B?WFNsWHZQRXlDUW5nM2NMOTBYMkxJNGhWWktublA2Uk5pNEdLWm8rVjFpZkNa?=
 =?utf-8?B?L1ZUY2RtSklJY1dNR0syNnR0a3ZPR2lHTWtJVlEyby83SHVCbHAzVUFWdG56?=
 =?utf-8?B?QThZbjJqZEcvb2NqUGllZTRQRWlxb2VtUXdDejZoTExLZGkzNnpBSkJlSlJ1?=
 =?utf-8?B?VkxPT1NFdUllZVp6RzhwUlBZZHhmWTJzSUF5VllWS2VPQjRwankwRkJOai9w?=
 =?utf-8?B?dzNtYmhtRFV0T0NoZVUxY0ZvbUJiS3JWb2N3OWZpU1J0YkV1NTNTNm9qRVNP?=
 =?utf-8?B?RE9NbWdVRTZNaktBQXFFYWpwUmtvaEFtN3JuT2trdlJJYlFXWUEyS3hYVy91?=
 =?utf-8?B?S01qZHJYcGJ6TTdxY3J0YUhNYU10ZkFNNlNmRDFuQlNqREFrUitSY0RBbnZs?=
 =?utf-8?B?VUQwMU1ldllRUUpVNlYxWHI4aEZHUWlwRTZmd1p4VWV6TDFCT0pXTmI5MStu?=
 =?utf-8?B?V1VIanlEM0FCTlREcUdTbUFOai9la2tGU0JrdW5hYmdrVkVWdTJpMmJQWUtE?=
 =?utf-8?B?RUNBQjRLaVlyWktOTVBmVVp1LzFLZGZ1YXN0N01ObzhnakR2SmxiRWFiakE0?=
 =?utf-8?B?K0hOMHp3bHZoT08rL3NQbU5YTnhNZnlMTTNobFdhUEhVSml4VERGaTR4YUdh?=
 =?utf-8?B?MTFaQktnSmQvaHYzdXFrQk83WTNUOG5mYitjWEt4a21qa3FzZURNVmh3ZnJW?=
 =?utf-8?B?K1JPWkxqU3hkS1NBdWxRNnl6WFZDZzF6S0h1b2lkcG5pMDdCREZmOEhBZWJY?=
 =?utf-8?B?NHZrd3lRNWVZWEFnMElReE93SXF6TlphWjJrZzlsRUVDVUxLVlIwUE05bGRI?=
 =?utf-8?B?Y1FDbERuQWJkbmdVajN3dVBpRmEvdVlFa0pNZzhEWlV0NzRPa1IvMGl0UDdy?=
 =?utf-8?B?UnVLMmFSSlBvS1UrNkNFai9OYjlsRkc4b3d2a2ZjRllveVVCby9GcE9YSVFG?=
 =?utf-8?B?SEszQ2lnSW5YeUI1MlZRUVV0aGtaVENPMUNsRGJaOGRDZ0d6ejN1MW1DVGd2?=
 =?utf-8?B?cFVtZlpZdnAxQTIrRGVscXY4L3pqazJueVVpY1JvdjBIVjdUeitGbjQyZDJs?=
 =?utf-8?B?MUlhTzBTc1VQNjBwQ1NKY0k3aWxJSytVb2ZEN3lmMXZXMlA3dTVQMnpkRE55?=
 =?utf-8?Q?qjHcBOwrUDkQUWUXqGjnxmMAh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4af7ef-1883-456c-e369-08dd51cf7c93
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:56:14.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLPqQrh4XMuxhtzp+crzYAkR5z2ehMrkR6disoa8zVUz3ddsdIVJgMPrtd9Nmitb7LUm5TICX5GPJnQLVkKdYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491



On 2/19/25 10:55 AM, Sean Christopherson wrote:
> On Fri, Feb 14, 2025, Pratik Rajesh Sampat wrote:
>> On 2/11/25 8:12 PM, Sean Christopherson wrote:
>>> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>>>> Extend the SEV library to include support for SNP ioctl() wrappers,
>>>> which aid in launching and interacting with a SEV-SNP guest.
>>>>
>>>> Tested-by: Srikanth Aithal <sraithal@amd.com>
>>>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>>
>> [..snip..]
>>
>>>> +/*
>>>> + * A SEV-SNP VM requires the policy reserved bit to always be set.
>>>> + * The SMT policy bit is also required to be set based on SMT being
>>>> + * available and active on the system.
>>>> + */
>>>> +static inline u64 snp_default_policy(void)
>>>> +{
>>>> +	bool smt_active = false;
>>>> +	FILE *f;
>>>> +
>>>> +	f = fopen("/sys/devices/system/cpu/smt/active", "r");
>>>
>>> Please add a helper to query if SMT is enabled.  I doubt there will ever be many
>>> users of this, but it doesn't seem like something that should buried in SNP code.
>>>
>>> Ha!  smt_possible() in tools/testing/selftests/kvm/x86/hyperv_cpuid.c is already
>>> guilty of burying a related helper, and it looks like it's a more robust version.
>>>
>>
>> You're right, a more general helper is in order here.
>>
>> Since the hyperv_cpuid selftest only seems to care about whether SMT is
>> possible (i.e., it may or may not be enabled) and we care about it being
>> enabled as well, for the flag to be set. I should make a more generic
>> variant(s) that can be accessible to both. Maybe I can implement it
>> within testing/selftests/kvm/include/x86_processor.h?
> 
> It should go in kvm_util.h, /sys/devices/system/cpu/smt/active is a generic interface
> provided by kernel/cpu.c.
> 

Sure, I will move it to the kvm_util header.

>>>> @@ -93,7 +124,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
>>>>  	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
>>>>  
>>>>  	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
>>>> -		encrypt_region(vm, region);
>>>> +		encrypt_region(vm, region, 0);
>>>
>>> Please add an enum/macro instead of open coding a literal '0'.  I gotta assume
>>> there's an appropriate name for page type '0'.
>>>
>>
>> For SNP, we supply this parameter to determine the page type for SNP
>> launch update defined as KVM_SEV_SNP_PAGE_TYPE_*. For SEV/SEV-ES,
>> however, the page type doesn't really get factored in and falls through
>> unaccounted in that case, so I had passed a zero to it.
>>
>> Having said that, having a literal here is quite unclean. Maybe I can
>> pass one of the existing page types to it or, better yet, define a new
>> KVM_SEV_PAGE_TYPE_[RESERVED|UNUSED] type instead for our selftest
>> header?
> 
> Ya, define something new and arbitrary.  I vote for either KVM_SEV_PAGE_TYPE_NONE
> or KVM_SEV_PAGE_TYPE_INVALID.  RESERVED suggests the page is "valid" but reserved
> for some entity.  Ditto for UNUSED; valid, but not yet claimed.

Got it.
Thank you!


