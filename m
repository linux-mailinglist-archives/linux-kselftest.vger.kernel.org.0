Return-Path: <linux-kselftest+bounces-41742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95716B81138
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4457C17E779
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6832773E9;
	Wed, 17 Sep 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0w3m6Zw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB46224B04;
	Wed, 17 Sep 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127661; cv=fail; b=pYmiCyk7x9vglikknR323fFgeA3VBYWwLaG0WEEOV4s1MfqYe4W+cGQoKfPi1mzM0NbBZwNiNF+vG0YHZ1x2xMzdY3aGbIxj6EjEHM65dd0omJpFF8cOEvES8DOyyl453GxjjE7fvaK2KqZX8fRcET3g02lxmGZ1fxufYxvrWqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127661; c=relaxed/simple;
	bh=NPz39gSVNqZ9IFiTZbA8FVFvgK6YJCwPvbTjthLe1BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cABrye2tukMDmpWz14HP8P2RCHcnevxn7woAgbmZQwQcTu60//Q0uEcd1h3jADvPBQne2x8WMcy05BhYN16ntfi9z98fHUzUb1/ZT44x4bK5tnzspbaYxfVQPgze78FP16ueLJ2AjMvzi7eJ8WtJCnCE/vUREWJ1nCxPNhCzou8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0w3m6Zw; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8IMGtcnAgjkclNEPeSyLMSgwnFT/t0tPbC6N6nPyONWmqsCfLdAQmxEJQXC9xLEXxxJftQsfPVMtVroDFLx8lhDGnQl92pMuJNhgDxeAZEMyE3Z+WYDPbtT5cwJFDLiVCJ092liwP2dkH1N3dHJKO3heGcWUsx5klV+h1pxYmuJU7X8VIh6vINI2uolyc71r5Nox77sFGWNLS4KMhnXi5+4STr/3ku8WzUhhdksUDvLVo53Q77FesCYdpLjrUAQpq5NsCbqXziFJShCvBRdneeG9Iwd+aUBF8RzSl/SEQyyC7N9OinHrIPxUzG7lHsw9u3PNmUQvjvDMuB/isNrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKHYKAfqScRJyJgTm6DuVwXKlj+lku0G0GAsCsqyuuc=;
 b=l961PD249CulytHf99DX3JucxIXlS3yLq6Jed72zbPtMsNAjnPtbbWdWEsqk/SM9cGB7+S1V55Fphi9CLqZ98ZS62r3dH7OE+8lk5v8WTg90aWqbtAz/Oc/a6uvgf3fQ8vdJ/rLTfODvKsD6rsIgZYzrmdTubMmV1Q3dx+bk+O/3NTt4E4yMyRKl52vvx/Ch5LcaeqOpO9Qh931vS6VQSEyx+hHogvvRJvzZIT1hqzoXuDge0pEzyexOVLc+rqsWNe097b7uXz9rUT+xEzsT6d6p3MhOKfkTAEmPfv9d0cdgph+tknVNxguAyUwnS5HlHed2Bz0VrMZDI1d5AOpHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKHYKAfqScRJyJgTm6DuVwXKlj+lku0G0GAsCsqyuuc=;
 b=N0w3m6Zw/qc4YYXkPpHdP4lUZ3QivHxjE1bPGY4PO6hKWNzoYHlrQk8P3QpjWmyIQB2RrgymP1nDVzYBIXrBpQwV162HTjAvspIRixzOk3loo5RXrZmcZgu+x9nPu8/EOAXHH+vvppK17aP+ezdXVWZ5vxd3YjewBEA6QUsLT/SAvyOFW58OIB2AD3Ahc5eJtv1BX7dhvBUI3z9C7WEJUPcQfLPEtzKDyjQ6KQz0FhGks5QYi2RvxdBooB5fraZWWtvvBni6eKj8QUiJrwUc3A63vBYgjanG64JXJK5mRzE5iHWM+eUiH85X7exuBn9Tk24pxXC35t8j2jQpw5i5mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 16:47:36 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 16:47:36 +0000
Date: Wed, 17 Sep 2025 13:47:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Willy Tarreau <w@1wt.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 16/16] selftests: vDSO: vdso_standalone_test_x86:
 Switch to nolibc
Message-ID: <20250917164734.GA2047227@nvidia.com>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
 <20250917153209.GA2023406@nvidia.com>
 <1f64966f-ef7a-474a-9641-561b6b7cb0d2@t-8ch.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f64966f-ef7a-474a-9641-561b6b7cb0d2@t-8ch.de>
X-ClientProxiedBy: BN9PR03CA0521.namprd03.prod.outlook.com
 (2603:10b6:408:131::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a08dc1a-79ab-4696-b8e3-08ddf609e79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2hhSHBLZm1Ld0s1c1MwWW90cEdCNThXOHU1T3FSTnN1cTFPbVNZbXdmWHIy?=
 =?utf-8?B?VGMyWnh6ZVNSU2wrR0srSGpSRkZhem9COVhYM2tPTFFpV3dLZVIzb3ZkdG1u?=
 =?utf-8?B?YVJWb3ROeGs2WElabjZVSkFoNUV6cUdRS2Vod2tJZ2l0ZDA0YVlMSlNzbkVD?=
 =?utf-8?B?MWIrdnBqRFFWR2xWUHpSeW14dHl0R2wxRVk3LzVJZXo2dGtiNWZTVTY2d0ZD?=
 =?utf-8?B?QlorTG5aRGViQW5Db2J5NmNmNlYrRFArbnlUbGoxdGVOMmYwTEIrU01Sdi90?=
 =?utf-8?B?YXVqZXczcGNtK2ZnUTZYSzZDWmpxZEJJY2x2V0ZteGMya3ZkNEhCRm9LakhS?=
 =?utf-8?B?RC9aNG5MZStibzZ5bGkxNWpPaUtVNlpuVlY4bU9LVXIydTJTSFdDL0hqb2Jx?=
 =?utf-8?B?QnFZTTJXeEJWd1BKRnhkYjZDQk5CY1Zld3VFZmgrZHo1ZGU4ODYrYkx0K3k1?=
 =?utf-8?B?cVpwMkNHNjJTdGR1dWlyNjEzZC8yMGNUaytFaXc3ZHFvUmtYbUpGaTAxcnRC?=
 =?utf-8?B?N3VhanMvM0daK0UxaFBueXdRb0trd2pEb2dOQ1ZtdFRKZDJBRUtZTlJpM3V3?=
 =?utf-8?B?K1J2N1F3cnBnSlN2OVhWd3dGcTJYNHVRbTBPcVlNeEI3eXlQNGtWa1Y0cjYw?=
 =?utf-8?B?NjB2MFpmNDJncGpWOFZOSWhuTVkrY3g0T3B3UWR3Mm1JYmdwUGNsclZtN1Ru?=
 =?utf-8?B?VzZLbWovSFNZekRHQzA2UkcxcEhZSWsrcDFSRnZwSU9QdFlOM0gwemRTVEhJ?=
 =?utf-8?B?TTFENHduczYwTmVOc1NralJBNHE1UHdWaUFVMHh4cFp4MUlvcnBsM1FRTVhk?=
 =?utf-8?B?S2tod0dZTW9XclI4cGNYbnhBSGtvZXlYSHo3NFZoQTQzUTRBOVpRcVFzSHh1?=
 =?utf-8?B?TlBiMnIvMlRlQ2pNdDJpLzNFRTZUbzRsQXA3RWMwamxmRHlDMnIzRUlwZEI4?=
 =?utf-8?B?OSsvR0dVRWdHRWxvVElCVGVMNldvektDU1J3UDJndnZCN3VjMUQ0L3Q1cVJu?=
 =?utf-8?B?OTdXRlZyWU05NHNmd3ZVR3ZIbWc5NFZmQ2RWbnBDVXprWXlySk5CU3ZtaTg1?=
 =?utf-8?B?cVNkbDdWMXRBK0puTVFSaHFUWG0zOXU3UzFXbG1uMjYxdlpqY1Vvc0dBV2NH?=
 =?utf-8?B?OWZWbStNMmdxYkZQQXdLSlF6T1FFRWErSmZaR0QvQnlyeWtyUUNscDFaZURa?=
 =?utf-8?B?Szgray90WmFGaGt0dk16dEdDT0hoWEVxeHFzTklmSXRiL3Y5L3B5ckk4c1lH?=
 =?utf-8?B?OCtVbUxGSDRQQkxDNDBIRWJ0T1l6SE83T080dWZ4VFFrbk56MHphOUFUcjRD?=
 =?utf-8?B?TTZ4RzUydENXazZkTUpQT2x5NExXdDdTN1RBU3Z6VEgzQ2FsWXQyYzFEd0FU?=
 =?utf-8?B?ZXo5ZDREeTZIc2FDc3VWdi9kNGtWbTBJc284bnllNXBhbjdyRDBPZWF3UFdt?=
 =?utf-8?B?QXh0RjNDZ1U3dEZKVmY2UUE5TDVhelZEQnFML1lOMFRxTVFEN0IxM2xPS1VJ?=
 =?utf-8?B?N1lkM2NObWMxMTlKT3loQUltMGhhYldiUnd0Z3A5bFRlSmIyMlI4YzBCVGhI?=
 =?utf-8?B?K3FpN3dTVWliZnIwZzB3ZlRvRm5ZT0Iwd1E0YnJNUTI3ZW5mdHNnMHRSNDZs?=
 =?utf-8?B?Y3R0ZC9xQ2V5WE1Yb2pQZ2lGUjhXRUU3dXZTa3hlaTZidXVxMlVwWDFaZjQz?=
 =?utf-8?B?NGtkQzIrclU2VG1hK0Z3eloxaU9yeEtoOEx2WEhkT3g0QTdmOXNwbnlYRy8y?=
 =?utf-8?B?R2hiQmNyUHlzQjRUV1pINWRlTWdDNkF5SHVYczBwdVQyZUlNeHF3ckNyeGxj?=
 =?utf-8?B?RUhhL2RQSTZyem11QkM5S0tqa0ZrWi9vTVBFaC9JSENPa0UzVm1tRHRPQkxX?=
 =?utf-8?B?aTdyWklBUUlyUU1LMWtJN2ZvWnQwSk1pcTZaV1Y5M09aUkxSdUw0cldwN3Mv?=
 =?utf-8?Q?EFn3PHIgiLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVKd2lMN1U3T1U4RVBUVFdMK1BVUFlLdHZlbHRQNStWdDk1K2F1cVAyV2t6?=
 =?utf-8?B?Yi9YbStrSTNEU3Z6THdEV2wzVnlkSWN1OGh1OVAyZG5iWE1TUHBZS214d3F2?=
 =?utf-8?B?UE5ZN0ZaYlAvWlA0RFVHQVY1TC8ycVR3Z0NLemYrZWozSFM2TWNHcGZWb3dT?=
 =?utf-8?B?ZDRiQTFKVERCaU1YRXNwVFQvdkVwd1FzWlYzM3l6dXBIRkFpd3dicEpyVGRa?=
 =?utf-8?B?RWlQckdVdjQwRDUrdi9KTDR6UGoxUnYrSFlseXZBU1dxckJ2UEt1dDRDNEVm?=
 =?utf-8?B?aktxa3ZFZ1dVMGU5dVJGeCtKZ1pubkhIZnMxa3ZtV3VFVkVxakVRcjNIMkVr?=
 =?utf-8?B?ell6c0ZjdjhKUzRZdGVRMTFRdytDOGhwY2Fram5iY3hxTFZXd005bmpXSlhj?=
 =?utf-8?B?L0U3SE1EMXVuQ044cHllY0JNOGErZG85UmJaRjJ2Vi9BNWRDZklzcThBb3BO?=
 =?utf-8?B?YWJ3eFc3OTI0eGhNVjRuMXFrZWo3ZDZmQWVUeVdsem9NbjBEMTdLalh4Q0Vv?=
 =?utf-8?B?ZURnQUd3Ni9neklmOFpSc3ZKMHkxbVpwRzJ5MWV0NmR4Q0dqVFJBSVBhaTE4?=
 =?utf-8?B?ZU1MTU5BUlJ6M3IwNk1wekVwQmwvWC83SEtiUGljd3N6Nk1pS2tXM2hGQkZw?=
 =?utf-8?B?V1YwbmdGb2lLWjMzS0VndGZYTXZ5UGhwdWlCNEJxSU16bjdEczgzTURBSDc2?=
 =?utf-8?B?TWpNTDJ2dHlVM28vTEcrMFBIQkttd2pndWV6bHJua2tyVkNTN0Q2dGNwVkVh?=
 =?utf-8?B?V2hPSXRaODJ0cHpyYWdZR0lxUlZFVmpUcEtSaEFIazRNbjNXVkRDK0FCc1Ra?=
 =?utf-8?B?ZE5FN3hFNzVKS2FiSFE4dThQQndCVzZsSFAycmFSd3kzcE5hQzRwSitZSGdm?=
 =?utf-8?B?djBoaHNGYVc5aHJLTzBSSEFmZmdNeGgzaFB4RGtGSXBKV2h3MXVYcG1NQUNX?=
 =?utf-8?B?aWMxWnVnRXNIellHMHovemRoMkx6cHhPWUxiMXZUeXM1OXBXY21LQ2xvYjBL?=
 =?utf-8?B?OVE5V1Vram85WG5sZ25CTVZ0L1dXVTdqd2ViOFdLSGQ1TDl3T1pteG9pdDNo?=
 =?utf-8?B?N0NnY1FCUHQvL3dQNkl6MU5SaEhSZUluMFZvK3ZjYnF4ZkZLSDdhWFdidTV1?=
 =?utf-8?B?Y0k1T2phWVRwUVdETy9NUDJYY3RpSWZuSWNPZmtsNEFhLzRiZ0xDdi81WHRR?=
 =?utf-8?B?SUwveFBSZnBtSFRnQS9HV3VOZmV6QWNoNlFILzRmU1hWWTQ4bzRwenlWRjRr?=
 =?utf-8?B?VHVBSENDL21UcGFYdEo2SWZTaDd2cCt4VDhkcXNlRENXZkU0YUt0SjU5KzJt?=
 =?utf-8?B?L3VJNVJkQ2JvODFUaml1VmZTeXRiZVNrYlQralhkejZJNDFXK0lxcGg1cEt1?=
 =?utf-8?B?N1JoMHgvb2hJQUxBYTg0Z09qWnZVZ3ViVDE3eU1YSENOUDBPWVk1a3VBZis1?=
 =?utf-8?B?VzNWbk9VQ1RjL05tSkZPZFlVVEUyUFNNUkRBUC9wK0JOSnM1K1crNkkrZTVs?=
 =?utf-8?B?aUpMYzVCOW03YlgwaFBXN0czZ0l0UU9LOEhVQTdodmFFV1czTllkaVVtQnR2?=
 =?utf-8?B?Zk0yNGJHNmNLWU52aVMvTWNnRi9TRFFtUmZvY0ZmUzZwY1VVcWp2eGVXWVA4?=
 =?utf-8?B?c1BBczZyQ2REMS9IR1RZMm5DaExOei9XSnRmNVNPelAycms4aEp5TXBaZzEv?=
 =?utf-8?B?Um13OWt0NkppZjRkd1h4d0VlWHF1WUFyQ2NYeE5DVDB6bFk2VnBYU1VxeU1E?=
 =?utf-8?B?aEVXSjZSZDlhSkpUdkhpUERRVUdvcDdjYWY0ZFlNTXFvbDdPdDNERW9mUngw?=
 =?utf-8?B?NlBsanExSHZ5R251bHhzMnA1WXd0dEJySmdWUkY3RVZ2ZVVRNUFjSUZjTWVZ?=
 =?utf-8?B?OXlTS05PNmRBbXcyZTN5RVQvNzVBOWp6TThwRnVhVHNzZGl0eWJIbExNWGVs?=
 =?utf-8?B?d3FXR0ExaG1LMmdoeWJvb0FaZ3RUVjhlTnZtMkVIZXBkZ3VsLzNlOVE2bmRL?=
 =?utf-8?B?U0Z5NDVITWJXNWN4dDllNmJrRk5RdjhtbmRoaHNCTzZJRGF5MTVnL1NBb2ov?=
 =?utf-8?B?VUZEQlRTT1UyNXJkQ1dlR25HOUNEeWpDbzRscFBKZDBMVktZK0k3YnVJTjd5?=
 =?utf-8?Q?Vp/AuTmQJAhRBCpVrS/x7VKI1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a08dc1a-79ab-4696-b8e3-08ddf609e79c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:47:35.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJFL1IDqFQiCJidNFfWiqR5h8yjvG3ya/IjgcCJr+JwLHA8JYFcr5z321IFDNak2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092

On Wed, Sep 17, 2025 at 06:24:13PM +0200, Thomas Weißschuh wrote:
> Care to try this:
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 530390033929..a448fae57831 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -228,7 +228,10 @@ $(OUTPUT)/%:%.S
>         $(LINK.S) $^ $(LDLIBS) -o $@
>  endif
> 
> +# Extract the expected header directory
> +khdr_output := $(patsubst %/usr/include,%,$(filter %/usr/include,$(KHDR_INCLUDES)))
> +
>  headers:
> -       $(Q)$(MAKE) -C $(top_srcdir) headers
> +       $(Q)$(MAKE) -f $(top_srcdir)/Makefile -C $(khdr_output) headers
> 
>  .PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir headers

Worked for me, thanks!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though I notice it still spews stuff out of the build directory:

tools/testing/selftests/mm/local_config.h
tools/testing/selftests/mm/local_config.mk
tools/testing/selftests/net/rds/include.sh
tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test
tools/testing/selftests/prctl/disable-tsc-on-off-stress-test
tools/testing/selftests/prctl/disable-tsc-test
tools/testing/selftests/prctl/set-anon-vma-name-test
tools/testing/selftests/prctl/set-process-name
tools/testing/selftests/uevent/uevent_filtering

It is not related to this

Jason

