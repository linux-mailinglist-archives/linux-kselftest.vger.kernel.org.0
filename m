Return-Path: <linux-kselftest+bounces-26676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C2A36548
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB23B175B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE3E268FEA;
	Fri, 14 Feb 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svfSxAat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC6268FD7;
	Fri, 14 Feb 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556477; cv=fail; b=Kq2CND6qZThvSoJ68jTvemJzCtcptB08Zc7fMGGDH0CRV1B1zhvCNRzi1+wW+YvLtK8OjRaUprSyBOY6DwdWiGi5QoxmzN82VobdluHaKpJ185cN6+ExYwCL0PC6hfapHuY5GpoGv9O4QRTrwjPePh7o2cWgNGgrzgdJghSbrB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556477; c=relaxed/simple;
	bh=eQiL6g4GVNL71R6uzJOHqYaqQJ8hDVX9puZXYiAx/Jw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0fute4+pZSUPNhwT4PExgCLzhaUMzau1ZUdoXRfOH54H8spwXeXa12kfJ4nqO+v45H7hpDfFXV2dK7h1v1QGdsuI52KFxbJ6V20+pBsGCpM+xy/fhe6hN+pmEYib+LNosZUeg3t01bRy3GMe3CivIhwmqX4tTdo5m1Bt8u+Czk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svfSxAat; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKCpWl6rbciSnMQRlnm1J7TjDr0pTZipaG0oNeAvmAAc1NkHzMNaSr4E2biOgAjbUphjMaYFnKaUyWkcMJZZeoPrZi2U8vSydaK4A4/pstkjMjekPDBPzthN2D0RAyAlwOhbTSOIcX37GGRNxxqrgoNLnVkzDCcHLA3Z354EovRXkNlk1XV2x/ru6LjHKFSuCwGjRpuB/9bfM2Nxw19q+URbMoOUd+HE11sHGaa8qMIJHQPGSjkwUTz9Ie8fHoqyGbbuzwcvrdf1zvLbX4/x5FaTKXAkm4AVhhETzU/+yCNyonOf3cx8KmzhAEj1yjioetuaG6+g56OsDQ9B8CdOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fmU4GLwoKEcrNjrasFaD45wnL3cb1mpUMZv3Lq4azQ=;
 b=xWfchmtGUvP/AYgiODNT/s5OlPUBsDk5BauU5nIoIDh7lzEB8bj5sMy5ISudXmsw6gXPLreGy1cUcsJJYk3auqKqIKkeVLmsykHczhs65T5GA6Jr6oVeGrL+kQemlX/lNmvlZ8zSH8LdrCGLi+KzMlmmwBZFpeENtmdK4TNCCawqaR4z52NIFJS1b/NZPKo20RgEXAnqpv0ERJoWhC1GUWTb//ZgGkB2GZIYvpFHmsIrHGpNSlwZi6m28EiBHPHT4JSy6PKVItCwuafef6kk8xwK/3F47KhrWds2J36QcWYRjHLDFI7Fo+mMRgBtDMBxQ2naJeHdd1Jd/88Uuxtssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fmU4GLwoKEcrNjrasFaD45wnL3cb1mpUMZv3Lq4azQ=;
 b=svfSxAatqNzUWOLFdExjOjO2uLRPaFzPPLZrRbE1+iqQWZW2jPmxn2e5coHExMGIKI6sbVVG52J3qGu0Wk+KZA1R+FyLfTOIUW1HukSGJNpZJQDArFLdT3BrRtuFJnyfltx9+IcHsUL/rwB7PRT/XYSzhtb4aALomrmsrye9Epw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 18:07:53 +0000
Received: from PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f]) by PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 18:07:53 +0000
Message-ID: <ab433246-e97c-495b-ab67-b0cb1721fb99@amd.com>
Date: Fri, 14 Feb 2025 12:07:51 -0600
User-Agent: Mozilla Thunderbird
From: Pratik Rajesh Sampat <prsampat@amd.com>
Subject: Re: [PATCH v6 1/9] KVM: SEV: Disable SEV-SNP on FW validation failure
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-2-prsampat@amd.com> <Z6v_UjzEpSMyMZN2@google.com>
Content-Language: en-US
In-Reply-To: <Z6v_UjzEpSMyMZN2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:802:21::23) To PH0PR12MB7093.namprd12.prod.outlook.com
 (2603:10b6:510:21d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7093:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: e36f0fbe-74db-4ed6-e38c-08dd4d228019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlEvclFrdldhSzRmQzk3ekR6Mk9ZT2VXejNFbjREUVN0WjN2QlNIU3dzRU5S?=
 =?utf-8?B?MFRaNnNYT3Iyc0pXS0kydHR2eGVSSC9Da2FPNVhKTmJSWHBMVU9sRFYzbTBZ?=
 =?utf-8?B?ZGs4Q2RxZ0M2T2lUVG1YSU0zWTRvZWdoM3c3REpSRkpJSHp6YTBVbVdsME1M?=
 =?utf-8?B?RFdBTEhCbmt1TkE1S1JmbCtwZjI5dUMxdmFIcGUwUHVDdmdUUDRaY1VEZzNw?=
 =?utf-8?B?Y0hwVnNmK2g5M0xxV09ZSnlYT0I0UFp1eDBPZmlzb1pjZmwvUEZ3Wm1aS2Rx?=
 =?utf-8?B?ekRXaEdxWFdlck0yMkhzVVA1RkZwK1pZVkdNYW5DZWdiOGo0NkN5dlVCbFVK?=
 =?utf-8?B?Q08za2pTejU3ZlJ3QUZUWFNkOXEyZDA3TjBidFZOTDBFZVJTVDN5aWJ4YmVz?=
 =?utf-8?B?UW1zVS9XVGRqclg5bFZaR1F1NTJBV0VZQzYxeEVzQWJ0U1FVVkh6NXUzN1Z0?=
 =?utf-8?B?TGw0c20xR3hZVlZ2QzdXa3RWcmxBeHdhSmZ1VHhYb2I4Y1JudUtEenNhWmNQ?=
 =?utf-8?B?dVZCdXp5S0d0aGdhNHlwU2NzcmtZSEFUT3BKdkVsY2ViVTFzRHUxcm1pZ3Y0?=
 =?utf-8?B?OExIckpyb25hWkV0eHFYaHlQNjFLamp1SElHTTR3bERrcVdsN2poWUdVMXp3?=
 =?utf-8?B?VGh1RDRjQVV5VG1rK2dzZ1E2OWRwNVY4YTJ1eCtpYXJRczEzUU81VVcyU0xr?=
 =?utf-8?B?QlR4TVkxMW9MWHZoTmtJVE1NaGppQnJaT2JRSkRHaVNMTjlXTzhENXlMOFk5?=
 =?utf-8?B?WXBIcUFGOFpyeUFFZm9DcHBxTzI3c3VMK2dXU09tVmhxaXFwbDB3WTgrbERl?=
 =?utf-8?B?bjBjdXUrcmtabGlUN1FtSkQ5REJpUEwyK1BwbVFJbWNyOW01SnhYZTM4VkF3?=
 =?utf-8?B?c2JUWmZIZE9JSzRoRmF0a3BXV0FLbDlGYnZkeGFTS2daaUtjUCtSUE84b2hM?=
 =?utf-8?B?MlBqT2ZQSXBOQys4Mm9saWE4S0VrV1gza0lXVDN0TmFlenJoTllBUDBjb0M1?=
 =?utf-8?B?R01tSTFLYmEwQ3FlN05TVU5IOEo4YjBWN3N3N3Rtb3pPQ2d6bnZxU1huc3JV?=
 =?utf-8?B?TEJ6anBic29Mb2t3dmdrRysvYXlyT1hWRkErRzMyNm55L0lvYW9NU21TTXA1?=
 =?utf-8?B?U0g0Q1FzYkVGSXdnTG1naWVrU2xoaExNbmd0RzNMT3Z4aC9iQTU4VHh1Y0tT?=
 =?utf-8?B?MFJENVZXWXI2UEdkWTMwVWhwTXpkdEk5SjY4YmJNZ3BIOERFclM1VWJEZTN2?=
 =?utf-8?B?OGY3cktycDIvRU9Da0JVRDAycldTVDgybmlwYUUzd1NXcTc5RW5qRHdHaUY3?=
 =?utf-8?B?WHczNXhiajlrazJJWndUSHpKa0VGeTZCb0dVR3dlckVFS2lMUE9CUzRwQmFi?=
 =?utf-8?B?VTlOSU5OeTQ0TVo3elhMU25PMmdTUm9JaHBDb3NrRHNaM2FXZnVDYXg3MDVO?=
 =?utf-8?B?YTJtMWVNMnAzUUt2SHByRkl6aE1ETjlETnF1QU5rYnNDeGZIOEdneGpPd1NJ?=
 =?utf-8?B?WVc2S3NFNWJhZ1ZySzlmcCswTUN5WVRMRVRCZjVhOGFyTytWZnNuNHFaVWVk?=
 =?utf-8?B?NlNJWHBwdEFRQnJnUHhKenNRaHU4cnYzUXVCTEdpS1g5bGlEdEFWaVZLck9t?=
 =?utf-8?B?dU5QNS8yRGF2N0EySVhSQUtvQWttSTVFTFZ5Z2NyL2NPd044VlFiNjZINlRp?=
 =?utf-8?B?aG5uL241RzhmYWp3Z2NuV3Q0bVdOSkRxNWpiMk1lVjU0a1RPMlNjZ2o4OUZU?=
 =?utf-8?B?UEVJVkVsV2VsVjZYL3hUc1NZaU5Qak1uQlRKZ0FHTmFrUDZtV1JHbmdMRVZB?=
 =?utf-8?B?UUJEWWxaekZZVzhZNEdDYi9paVc4RE5qaFBJZWhjZXBnb0ZzaTc1L0hYaWJl?=
 =?utf-8?Q?761RO99DqPWrW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7093.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm5McGlMUDZMOXRSY05oUEp4OTZQTnM1amcyMWwzTU5jU0ZTa3l0NlEyYWV1?=
 =?utf-8?B?azJrZE5sd2JUbXJleHV1eE9SRjN3V1lwYjJWcDhIbEdUNmVVSklubjh1azJO?=
 =?utf-8?B?NUlLdkNpYWpUQU1RSmphYU4vYU92eFBORmhGZXRJNms1Z0I2Z0w0OUNUT2hx?=
 =?utf-8?B?M0tvWkFDWTNEVEdEdytCbytxdGpQSTM5MGJwNzVoc0I5QTRNZXlWWm9pY2lY?=
 =?utf-8?B?RlkyZDlsTUlsRzZNdEU1cGNGbUJRWjlnZFVTNGtqangycVFNVW5hakJwNUhl?=
 =?utf-8?B?NWlpaVNmK0NnbVdXV0xJNncvenZ4bFFwMnlYbU93eDZUaXc3Wis1Y243amlK?=
 =?utf-8?B?c2VmeVFUQXFhU2dSc1Y4QzEva0V6V2IrTmZJWmNBaEJGTGFkcUV4NHNvSXBN?=
 =?utf-8?B?YnU1K2daOWNxbWE1OE5Iem9zMnRic3Y1NytUeCtnUVNBYkNSWDgyK3k5RFJp?=
 =?utf-8?B?Vm9hU2Fab1hZNm9EV1dLekIydmdrSW5NY2lWSnZTMDR5aVU3by9qbEQ5N25q?=
 =?utf-8?B?dll2R05mZ2M4c1dTc2NXTGRZT29EODlUelBZcjRaWC92YktQdHB0RldQd2h2?=
 =?utf-8?B?WU1UNU5IanpPYjBtTjdCc2VYcEt5YzBDeC9HeEVLTWl4VTh4ZFlWQURwTVlP?=
 =?utf-8?B?aU1DaGEyMGlncG9TTjFFNnp4dXo4cVNEaXdxbkhGeFE4UkNlMXgvNTk4dDY4?=
 =?utf-8?B?RlNMTEJkRUJMc2tCcVNWUGtxRlRFMTJ6MFF4eGdwK0FiL2xhMjVqQTQ5Smty?=
 =?utf-8?B?TGx2NE9xS2NCUzNLV01nYVFhKzJlOHpWelphWFJZS21QbjBOR0o1QTgzQmhh?=
 =?utf-8?B?Si9hSTJTZTYya0oyWlVBeHJFQmtvOEJ4NXJuZ3ZINUo5SGRwY2paRkFvRHRv?=
 =?utf-8?B?YU5hTHdhRFMxVC9mLzc5cG8zSUFDSXJtZDdZN0tVVXBrK2RNam04QUs5c09M?=
 =?utf-8?B?RHB1TXZRSHhhbmZ3cGl1bmgzdG1EcVdHVWtHYU9JcVNoNHBrZE5mdUMySHFm?=
 =?utf-8?B?QUlkeUdsWExJWVFPTGdyWnJFMlpWTFVRWFZjdmp5TENLV2t4bHRYdVpwV1g3?=
 =?utf-8?B?NGFzNkFYdzNHb2kwUGRQdlFsa3htWEJEM3EvWCt4cnhSSmxpaTRkRzF0bU5w?=
 =?utf-8?B?bGI0VXZOakU4bVZjT1ZHNlo1MUV1M3NmUXlpSGg0ZVczbXJiYU13cXkxNzlB?=
 =?utf-8?B?NGM1Nm1aSktETUM3M01kOU1TaVUwN3hSdC9XemN0dmV0aXMvZDBGTVFmMkpT?=
 =?utf-8?B?VXdMcU1DNWZDT0drUGxaeXVXQXFXUjdSR2JxbzdPK2F5d2o1NUViYXJOajNt?=
 =?utf-8?B?S0Zhb0NkL2hZMGlpcTJXV2lpSmhCL3E0YWlvdmlrNzhkNmVRaGFFY2lPYjNh?=
 =?utf-8?B?OWRZU3JPTXBxaEliOUh2YUZ0bTNndVlXWk5Vd2N1OVdNL0RodkFkdmNXWGFv?=
 =?utf-8?B?VWJkYUJ4eTVrNkVIRGRkZ01IUFNoc09HeVQvYjNaVXB6NVdwN29xN2xORDBw?=
 =?utf-8?B?OUx3MWtjVTJNeSthT1M4ZThzaTg5UHJ6SUFPMjdhb2NBNjFMVmRkejJkRXEz?=
 =?utf-8?B?UHN5RVdpbHByRkRsZ1VhTWJmUkh1SlFyRUxUYkVpTlFsTVpkZlhmckpCZU9s?=
 =?utf-8?B?b1ZCQTBTVlRodzhheC80RjlEOHR3RkEwS3NhVkUrS0lFMDh4TlB3NEFnb1F3?=
 =?utf-8?B?SEV3bzY3cmhJc2VGWWgwL3dZWDEybi84emlmNjZ2RU9JbVVKeklINUV2Vktx?=
 =?utf-8?B?TVJTMy9JNk5uT0xhQnVrbDhPMUcvckxtMU96NnhJZjI4Z1N5bU1xM2JCbGdj?=
 =?utf-8?B?d3JZQ1E4Q0NWcGdCRFpzSnhPSTcvWDFPcHNsNHl6cGFMWTdhUHh5ekZzVk5t?=
 =?utf-8?B?WVdHMENZS2M2b0lqM29ET2VkN1JocDVxTEFlVGpxc3pFUUhDRlh4Z3piUkhw?=
 =?utf-8?B?djBkNzNrMngwcjIwQlk1b01sbDNsVFRnMVV6Q2xvY0FNc0hjYmdyMEtLOUVF?=
 =?utf-8?B?aWdvNU1LWnZZRWNpVFlHd0hsOHI5Nk9rZlV6NS9YMExCM2Vkd2tUUWZlZnhF?=
 =?utf-8?B?NmlQS3E2c29idTZsVmxqUWtUMFM5aFkraGdTMEpZclM2ZHE4blA0MGo1aWw3?=
 =?utf-8?Q?yZDXBQCBPb5bO1JJE+cTgz6VA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36f0fbe-74db-4ed6-e38c-08dd4d228019
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7093.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:07:53.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfC1qJnHKBfDnQCiM1UW1hiLZ+BviK+1O+UVVcWXJuWxFV7kWA7gYzHK+j6hnByKtNh6pPBUK3JD7BRonxbkOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

Hello Sean,

On 2/11/25 7:54 PM, Sean Christopherson wrote:
> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 0f04f365885c..b709c2f0945c 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -3040,7 +3040,9 @@ void __init sev_hardware_setup(void)
>>  	sev_es_asid_count = min_sev_asid - 1;
>>  	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
>>  	sev_es_supported = true;
>> -	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>> +	sev_snp_supported = (sev_snp_enabled &&
>> +			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
>> +			    snp_fw_valid());
>>  
>>  out:
>>  	if (boot_cpu_has(X86_FEATURE_SEV))
>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>> index af018afd9cd7..b45cd60c19b0 100644
>> --- a/drivers/crypto/ccp/sev-dev.c
>> +++ b/drivers/crypto/ccp/sev-dev.c
>> @@ -122,6 +122,12 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>>  	return false;
>>  }
>>  
>> +bool snp_fw_valid(void)
>> +{
>> +	return sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
> 
> This lacks any sense of abstraction.  KVM doesn't care if the firmware is valid,
> KVM only cares if SNP is support.  KVM _must_ run after ASP initialization[*],
> so I'm pretty sure KVM just needs a way to query sev->snp_initialized.
> 
> [*] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com

Thank you for your reviews!

Sure, I can instead just export this function (with a better name) to
return sev->snp_initialized within sev_hardware_setup().

