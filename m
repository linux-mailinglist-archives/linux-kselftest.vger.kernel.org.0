Return-Path: <linux-kselftest+bounces-9731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDCA8C04B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 21:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D011C214B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 19:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF212BF23;
	Wed,  8 May 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e57Vi184"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0B14A8C;
	Wed,  8 May 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194987; cv=fail; b=d2qqpSBVRr2tFl+bX7SQmAV2EOoDA1SyZp8qVG5OlvEcHhCF3ne1iDuZHAANeNU/wvEtBAMheSkLmnRNjqvExVuHLpXMqQ+XOrvAMATmLGe5E7u0jSt2Jl5v3nNwgjHeQox3iAlbtpLIRxG04MlAO4xczWZhD536Vrfr9bAugKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194987; c=relaxed/simple;
	bh=pSJKsdH6oOHNLLuI2Ic8jDxSl4kRvmsdQkQl194Y5Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fkoUOwaCsJifye7nOAIbo9Wted+wzdsQkIH2QvDDHpt7dnpopUGkvzrrdEgE0DFPHjvrULsWfFKgmw0S7mrNeoNLXwmsxUwGSxUZfapgCQ/OAXAoCN1B6XoPftOk+fNK5IR6tHufvuvqVgNeymNz6MB4aSVAOYCBV4Lb8QgW3U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e57Vi184; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac2165mAs+uRjqmafdF167jw8w5tAlcSJcUsSSoXAQtpWEi354wYIbOa/ZHyCUsZK4Iq4+tm5iI68fVi4W92qVO5qzhk6BIhFtQllr9t9T5mDvERbXTtPrknAzy4rr8Q9K/YDG1B5VOoJzIyLn/6PigKyz4SlV5j6xqUhYafCSnswcRLT0cURnnrhkimzSmXD8yiUjzUBUPZdvHSrCJIU1IDP3xLw11n0GSUkLYcMNNnuDI3y+YTX66Q4oKweSpHSgKNUa4E0Moq+fFROtOGwLVynNkys6c0DpLUcObH9WBBtfKTVYvX0BUfg1f22p6vaWemXhDtv4a0GU6WNeosXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHIi6izlW8bmJsYQU6u3iaOw0Z/NDGCiyMf/jA1QRxc=;
 b=Vfa9r053MAJwiEBamk8BSglvnJPgiWMQ2CHGPU+JndO3VTEgtlK75A2G1iq0H3y7fjn9VXLwFMIStxj3SfX9P1dcXNs2PCrMI+id6eYRkKIZtJNSy7Ag9xm9UdjpnmbaNEgDOEG0Oaa9mTfGNYKDpHcYB1f/i6be5eNhXANK+Gyu+xGNE3hFEDZHXI0fM1fIdKQbFFh06CTwlQlRSChikYK4J7wMP4mhFtRQXhYUSIIEPdsLdT7w2BgKg5LoAOZnoYn/FoCZGLHes2SMgNRqsxK34HgHpi6xi/EUwDwhm6zx079YyxXwZ7w3TGge89UPT2ADVXNLPs0B4wy4HHswUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHIi6izlW8bmJsYQU6u3iaOw0Z/NDGCiyMf/jA1QRxc=;
 b=e57Vi1842zugvhXMim2snXySwreWw4hF5Jw2F2xHEKdHfTxv5N4ZP6R4xIV6JjTsG6mPVqT2e//fZGe2iGWdrzeACD4HWH4SJx+nkcsBn6m2NyOI7Dk2wxFCrgi2LWDbjqRhCqDnoSlZKlcoBGjT/gvuJFNJZYh7kS3fn86QVd+eacUQncl1yRGJ0L/+pjNPHIVH9Nf7FFj9IHxy8+p6yWPnVxLIb1gmFRbdypFBHqQSgNy0M6QrM0PKPuTRi8vHzwrig1ogwTiCpn9Ox6snEdvPdMqqSek7uM23m/34H5bfRXM3mZPMtze82ExLi2ti7mESXj9g4zbGi3rNvfVaaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 19:02:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 19:02:56 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] selftests/resctrl: fix clang build warnings related to abs(), labs() calls
Date: Wed,  8 May 2024 12:02:54 -0700
Message-ID: <20240508190254.266892-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd635b4-e693-46f6-f4d0-08dc6f9178ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFRCL3M3RkNmOW1XemkxNC81RW5KdW1WZ2t3MUlyN2VxZlN3RTVHYWRhL3hk?=
 =?utf-8?B?YWNPb3hxR1NsVmx1bFo0UnMvK2dUNWNjTzJxSjhIOGhpenpwRkpiOEp0Vk1G?=
 =?utf-8?B?R2NKZ09KeWhkSTc3Qm44VFBLYkdIYm1kV3dpaGF4ODlMWU9HR1BtSzlVRndB?=
 =?utf-8?B?bkp0VXNOYVdvU1BWSjdHdGhod2FiYmJMZ1NWNTk4Q2VBdFA5L05kM2VJOFV4?=
 =?utf-8?B?RlZReU9NTXloVmNsbUl5WVhOc3dBL2lEcVJheVk5VEFYYzBmVm0rdHdMaG5j?=
 =?utf-8?B?UTdnMzhpVTB0R1c4RlNxTzN3a2dreG1HRTFPTUhtWUpaa2Q4V1grWUVMRkFF?=
 =?utf-8?B?aTRGTHRsejArbS9hVThpd0hQNGZUaEtPZkF0RThXSW8xU1ljUE1IQnpEOS9C?=
 =?utf-8?B?MUlEY2k4NExyaDIwMUozeXBBdXd2MGt6VnVjOGlieldZNkZiUUdmSDFBUjFk?=
 =?utf-8?B?NGZPZCtna0ZVZ1lwK1EvUXEwVVR6OGhWeXowWHdna2FmWmVBL0hEK0I1RkI0?=
 =?utf-8?B?T0pNM2ZNcDJqR0s3S0R3Y2xqNDdvNWpHQVhHc0NmQ1Y0QitZeWovU2Fmb3l3?=
 =?utf-8?B?emN3S25pWUxPSlRhbEhyYzVVYVpwbElidEFpTUp6MFRwTlV5dElwcll5dWda?=
 =?utf-8?B?OW5nMU1CakNpWnB2R1B4UmppZEhiQlBQUVdydGxGNnFZVmF1eUJpbGlKckNJ?=
 =?utf-8?B?K2RvUDBUZDVVK0I0RVFaWGUwOU1nb3lRMXg1T2NxamtFWVYrWktxYi96Vmw5?=
 =?utf-8?B?eVpLUERSb2ZIVklLRWdKaGxhMEFkaEJxQWN1M25YbUhJODBNd3RvYWE3NmpT?=
 =?utf-8?B?VE1qVEFSRHpER1BKNzQxdlpLUCtHWmI0eVhMOVNJWEs1UVIvRG9hM0ZHcVVJ?=
 =?utf-8?B?SjBoYm1xS21BYTdVNTFtV25ETWVOV3dvamo2aXVlbm9QT3FYbTFFdFUxWXY3?=
 =?utf-8?B?ZjlDa1Y5Y3BqWkZ2b0tBcytUcGNYMTFJMW9YcCtRVjFuemp6dXBQcVl5RjRu?=
 =?utf-8?B?NkdaOXA0RG9kODZBOHV3ZUpKc2dLOHZqRm5ONzBRVWpMQmF5R3hYejk2bWZl?=
 =?utf-8?B?d0orTml1QTdpTlR2MFcyWDlodmhIRmp0SEo0eGFHUm05TzAzRnRYa28rbG9y?=
 =?utf-8?B?SXdUUHIyTlNFSUNzTGF4Y3pLWE03QzFiYmRtQU16ek9zYlcrczViaURSeGd1?=
 =?utf-8?B?RzdJTWcvN2l5ckMrR3ZjaklwaVZ0UkIzQXVXTU9pamtEVEFBS1B2T1hqbXF6?=
 =?utf-8?B?dnNuVjR0bHR3Q0gzNDNFM1lEaUlDTXgrMXJlQmE5VnIxcFZzSVNnTlJFZnh3?=
 =?utf-8?B?SGs5LzZ3VDhidmFnR2lyMHRrdUJZWlo2bDhmcjJWOWQ4aFNhWXBISCtEY0lq?=
 =?utf-8?B?Y3VLQi80Z096Z1kxY01sLzNBTkd5djFuTGVYemJ2Ni9CajVkVUgxT0JudXpo?=
 =?utf-8?B?K0FUdThZSC9La1JLYTFNK0lvNW5UK01kSHVINk95VU8vSnFYN1k2MnpxYlRO?=
 =?utf-8?B?STYxQlVlS0Q5d3ZqZ3ZjRGl4NEhXNUpnRk5yVG1NUitoQnljbnVIQWtLZDhn?=
 =?utf-8?B?Ri9ydk1ZL0dGeWV0RHlXRmQ0djlqNVRZMU1kK3pHbktDalpFV3lFUzhTSkhm?=
 =?utf-8?B?bjc3ZVZYSG9USkk5M1g0cEl0eWgyU1RHckZ2V1k3L0QrbHJTc1JhOHQ3RDhH?=
 =?utf-8?B?aTdJSHJqQnhNWVBwTVhLRm1ROStKNURyNHZoODZoaTNrMytHVVVCUTF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWp3aHMxUWh3THFsMFltRzB6aWJTb05JYzJwUllLWVV6M3RkSUdMZzAvRS9l?=
 =?utf-8?B?dWZ6VXhsWmxjTE5SaFlGeG4vUlF4Nk40RzhidXZYMjA0TE5GcEVqTmIrWmFi?=
 =?utf-8?B?Rld1NXp1S1ZqYmVSL0cySWpNZlc4YkVXY0hyY1dxajUyZTlJR1M5b0pIajhu?=
 =?utf-8?B?RkhkWE5FeEV5c1VqcnBzTnI3M29kQysyK2ZJekwrT2JGTUI4aitKdkcvcEVO?=
 =?utf-8?B?clN0bW9OOThIa250bTJWZ3hTamlQdEYrVkJabDY5QjRKai9ER3NEK25HaWhp?=
 =?utf-8?B?dGpLelRLMGJMUDF4aWVHcHZFR09ETEF1NGU2bWZybTViQkRha2dkR0tRK2RS?=
 =?utf-8?B?RkVVTC8wKzQrMkFOTGF4bFk5NHJQUW0rOUZpWVdvTFBza2F0aTlWalpYU1li?=
 =?utf-8?B?akxXd0ZFOGVaa0xMV1o5ZlhHRjFYN2M2Umc5V0U5MWltVmtYV1lOQjRmSjlG?=
 =?utf-8?B?YXpDYW1jQ211SkdjTHMva2kxNTMzZHIwUlJvMTd3VnhyNkxxTWlQd3BKQlZW?=
 =?utf-8?B?dkJMZHpmZ2Y3d1dCamMxQUNpa3hpSGhibHlKU25DUlNta3p1ZHJIN01CSi9W?=
 =?utf-8?B?QmJnN3hzbnRPYVg5ejk4RUNwYjZ5Qi9Gclc5R2NwWkpoN3hQSFVIK3JLQ2s2?=
 =?utf-8?B?SlNMeTN4a1lPQkt1blBjZHZWUnZNWkZZdktOdjIzNkYyMkhOdGtxWkhTVGNk?=
 =?utf-8?B?Uk1jZUNtT1o1c0JQb0ZzVDNjaTU0OGNnTWxqWHF5SkIrYi9rM3ZGRi9HS1pZ?=
 =?utf-8?B?UDhDRW1Yb3hEaW5HSDcrTFZQZnBWUyt6QTY0bEs5Y1I0QVFRWmc2UHpzdys1?=
 =?utf-8?B?bnUvbTNBOG5rUzBkMTVLLzdBZHQ1L1p3NUFuSkN0bCtxdEVlRDd3YUN2MG5k?=
 =?utf-8?B?RWVSRWJSUU5QVWhLZnd0YkVkZVF5ZHEzQTF5dCtySy9SeWhFQnBBajNKQVdy?=
 =?utf-8?B?b1JkK3lpOGRpYUNNcU9jcFFNNzBtdGtZUTlTME1lbUlMMENlYUJiREU5bWRN?=
 =?utf-8?B?WUUzemdoNjhoMDhoVGZzODIyU0JTZGUxK0E0eUY0bVE3M1o1NmYrVGNuMkp3?=
 =?utf-8?B?c1grRGV1cjk4QTJJYUV3dkp6ZXltMjJQMjBocUJuRVFackNXVEZXeGpGaGQv?=
 =?utf-8?B?SkRvWDdSYm8raFprM1FsNHgrRVk3V0t5SnhKc1M5bkZCTkNwTXFOcHBBc2Z0?=
 =?utf-8?B?Ry9jbHZtZllPWW5xeW1jVXlNRkdQVUt3TDFtN09OVFVUUE1DWVlDOGkydC9C?=
 =?utf-8?B?MWgwRUtnTmFpamd6SU40M1l3dWY4YmxkelM1T00zRFRjbHN0VlpIVFpkUUhF?=
 =?utf-8?B?bEo4M3FsWEZ6dmVrOHFabFptellBM2NEWnN6OUlxQkhQblVPR3F6SE1BdkVI?=
 =?utf-8?B?R2JWSVEzMUxvR3NNeEJSSWZ6U3VOeVNzZjUrTG9aak1UanpFQ0dnZjBiaS9L?=
 =?utf-8?B?Wng4bHBFYjlUWFVWWlMzaHFVSHU2Wm5nNkRick5FYmJkd2pOQWU0V0hET3ZX?=
 =?utf-8?B?OW9oOGl1eHpCU2c3RWZaRjdSL0dDcW1ZRlVwcE5XOFhwYU1NRnFTa3lVM1F4?=
 =?utf-8?B?a0ZsYW9LVFhEZWtZUlFQbTRjOTNtSnMxTUFYakZTTUdsQzkza2FxZEJDbnJ1?=
 =?utf-8?B?SU85d2dHekVpeVZNNjFlM0pNMHlhWUV0UmJEVUJmcjgwaWx0ai9HdWRWazEx?=
 =?utf-8?B?SXV2UTg1bXFYYUhObjNyUlp2NGZZMzhDM0Y0SUFDeWF5N0hIbU5WenBKU2t5?=
 =?utf-8?B?WDlMdnpMRW9rWUp2T3g0NHR2bDVkZ3AyMFNwRzJ2c2xBVE93Z2JSSERXbWly?=
 =?utf-8?B?RTlqSVB3Z0hTdllUQ3RyUGdHRjdlbjFSbjZWNjlyZ3lsMG1mbXRxRTdiWnd4?=
 =?utf-8?B?YnhJaXgwc2xlYTZFbGxBQjlhWVhtNGZkbE9PekZCQUNUUG1uTERZYUljck9m?=
 =?utf-8?B?b1pzdVdtYzdnbWx6a09VR1JnN1FITTN2UWk0OFhvTnVybHRVUkkvY1l2bzRC?=
 =?utf-8?B?eWVjYXZ2S283L3oraTBBQzBjQVErNFA0ek8vbG1ud09ZN2owZnFOWGs3aGNt?=
 =?utf-8?B?MHNHajBGR041aUtLc2NENWtJOXpMektieTRKNlRWdjNmZVpyZW11U3NUZzBH?=
 =?utf-8?Q?D8CZsG2sB3VehLuG3JEdHbGmv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd635b4-e693-46f6-f4d0-08dc6f9178ca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:02:56.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+nJRsp5/6mvd7vmz3RzwSXdJ12bF2UYRws6cuwkVOHI57C1Y6N1He2ldXGp/FKjqbfVkR5jprYlCvGDSiEVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...two types of warnings occur:

    warning: absolute value function 'abs' given an argument of type
    'long' but has parameter of type 'int' which may cause truncation of
    value

    warning: taking the absolute value of unsigned type 'unsigned long'
    has no effect

Fix these by:

a) using labs() in place of abs(), when long integers are involved, and

b) Change to use signed integer data types, in places where subtraction
   is used (and could end up with negative values).

c) Remove a duplicate abs() call in cmt_test.c.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
 tools/testing/selftests/resctrl/mba_test.c | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..05a241519ae8 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
 	int ret;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	avg_diff = (long)abs(cache_span - avg_llc_val);
+	avg_diff = (long)(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
-	      abs(avg_diff) > max_diff;
+	      labs(avg_diff) > max_diff;
 
 	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..5fffbc9ff6a4 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -60,7 +60,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
-		unsigned long avg_bw_imc, avg_bw_resc;
+		long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
 		int avg_diff_per;
 		float avg_diff;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..a4c3ea49b0e8 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -17,7 +17,7 @@
 static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 {
-	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
+	long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
 	int runs, ret, avg_diff_per;
 	float avg_diff = 0;

base-commit: 45db3ab70092637967967bfd8e6144017638563c
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279
-- 
2.45.0


