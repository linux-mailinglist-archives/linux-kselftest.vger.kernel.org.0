Return-Path: <linux-kselftest+bounces-15778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6491C958B97
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F011F22364
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95219EEC9;
	Tue, 20 Aug 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nWD3XIxw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bmATuNyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564819D07A;
	Tue, 20 Aug 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168736; cv=fail; b=E2PbelQFuBr9KUMKAnOTfMplozriknYPr5pCOBB1TNySxzxSupwQG38cvJBgrAXowUz2fm+zMNXSnwa6Bl/1XTQuLUGt9+DM25+GwdsDemY1Ek+0JNEAzSdy6iZlu3UMxxGZa5mZ8Vfr6J4/ZutlTwzVkOkW6kwnNoY24yBXBUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168736; c=relaxed/simple;
	bh=6qrAioHwUoPcHGHj/hcLUlwLyhV5CGdOqp5pKkdPh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSC4SgeJNi7jhbkIS2eRyRMaX1fSsXzmYTfhDagYtX6kBpbRrIdx/VRrY2obdv6wv8cLvWQqdp7cAW+u8BsbSdwS0rGAfylN97BwiVmABFgIqgzuccNBp8iEbExt6yr+biXUvqjv6lHKu1qk30QmYcrhk7BQ1k8ovWO2k1Xlcuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nWD3XIxw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bmATuNyd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KF9lDV030700;
	Tue, 20 Aug 2024 15:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=RJ7mUdo30RJJQ1YTMk9o1Uty5sBW6yWmmE9Sqinq+fY=; b=
	nWD3XIxw63qNhx8NkZHGT//SUBCnnrGz3FN6yTWMAzSwxtNwmqfsI9vuGWmyuXuj
	bTKzA5CyOiGdJtJM0JkV0zYtOgVGvB06KzU53PW86ZgJ4fHxBOHmvEO68lgtbdeh
	vjchK6m/D6lA2wmAEXFb1nQgshIQEXNa8YTNoP/UEVZy7t65v86u7gTltupwZl0I
	TPb0K5C0BhVu9RHe63mMaqrUrNzgi1qVkv0eGglUdA7aRjOxl6xdqnELfhQDf5np
	Tt1BiKnoqeFmX1Oqn5HWbpoQz5zk8JCsHyzWz7mJwLKXP2lYxhCTLabjZDJmddmj
	zgaXXzEBNaY1H5fN6BBjBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdswcyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 15:45:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KFgL3e033756;
	Tue, 20 Aug 2024 15:45:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 414vtbkyvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 15:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMAXRnGnGAZunAEe7mXIRieuD/4oZny+dBvk6dY9gEYt31yVRywCV2Qo6WFcj8C3AncwL2DxNVhJAWxibnOU1nfr7cWEvsMXduksE4kihUOvwzQ4VzHnn6clUGx5ztKifuSg0tLU0EnBPH/39GrvxUBBeUCfUrvjZZhzSXKtiSU5b639K+MsNWU1Wf3bcOl9G5sA08GTctWUKnBNyVm6xTl3jpa8hR6s35bmcaTuCV9XVnG402ZBVM+F0JL6BSnPuRfQFS3krONG4vztEuAWCZ71cG5O7tsL1RvDhuT5k9j5u72WACGzxg0eN9jN2Ssf/jVQHx5q57qbFx009f8kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ7mUdo30RJJQ1YTMk9o1Uty5sBW6yWmmE9Sqinq+fY=;
 b=lru7PIToGAQKfBa7ljN5XuSvjwljsHIDJXm/bXxVGZ8jiOr6e0mcguYrVV/bMlriu4qbKF7PTYW9VMVX4jk7UORGeRt2DJjdWNt3fK/fa1C8KurqTxd+0KG7Q8M2hVx1GtTyWGzTfT4arDNYUayps+x1JJejjRr0HF6tyfrjTJap3RTcn1BHu5UARNM9X2uemI94d5TcYdoy8h305CJaKjO4OaWIN+JAAeLB8v6k9I5cu5H6gLhNlVBdCIVhVoKzV6fM8akdfSAxSHlDobJUfBiPIDV9m9mDxw+8g2XGrXvP74+OKVde6nTh1js596YnJ9BHfOQCry4qDcnJXeTVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ7mUdo30RJJQ1YTMk9o1Uty5sBW6yWmmE9Sqinq+fY=;
 b=bmATuNydbJ5k6Lzc9W71nQCdyLyMG6peu6GO9C8wg4zzDCh4SkY+EFC7EqFtCmyQWmXJ4ZHmwneMn/TtC8Ice4jYY8cCOiR3GzdRrnrG0nNKgrcr/mrz/RoNCuf33SmG1aI8ArvJSap8ZskbXcXU7O7LuCnzl1CnibfFQ2O7akA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 15:45:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 15:45:12 +0000
Date: Tue, 20 Aug 2024 11:45:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jeffxu@chromium.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
Message-ID: <nogvezta6maw4zv6pkd2rkyklhbeyfkjo6o7lsibgvwbuswvlx@2wufbiv6bn3h>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
 <CAKbZUD1dA2q9Yv_Z0S4SgvddHxnR9KZddYHAbMLsV+dt+bf8dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKbZUD1dA2q9Yv_Z0S4SgvddHxnR9KZddYHAbMLsV+dt+bf8dg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f551b2b-04be-49e6-0004-08dcc12f1429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zkg3WFFCS0VrWDNmblYyVzJ6d3FHVWlBcEtOYUZkcDc5MmNubHQxSmFtTFdz?=
 =?utf-8?B?Q1B4RFI4L25wQ3dWNWUyMkF2MEJ1NUxtZmR5REo4ZGsxSGJXTExLdnNEUWpU?=
 =?utf-8?B?NDBYR3o1M0F0NzlqKzhuMnhsbHEwTWdYaUZaWmtLeWlwZU1GS0Rva2kvOGVa?=
 =?utf-8?B?cnNUTEF2NzViTEgxUFdjMTdRSmJzaTdadmcwZ25uVnFiT2NSSnlRQjB5bEpX?=
 =?utf-8?B?SmJSckkySHFsaHJPaGlXdW9UZ2pMSGtadnc1RXRZY0pnbDI4ZmlhMVRjNkpD?=
 =?utf-8?B?OGY4dEViRFExRWd3akN4Tit2ZytYTC9oTGlMSmxSdXN0b1g1NCsvMFJFOFV4?=
 =?utf-8?B?REN0M3lrOEdrYktOcEVGeUV4RU42blIya0E5bVBJZW5QMlNhYkNDUTB3Q0h2?=
 =?utf-8?B?WnlxazIrZHVnbFdZckc1akU5WUtzM1I3TzltbmNTUEU0Vjh0MkhtVnY5MUNw?=
 =?utf-8?B?R083Ymx5YVJVNUMweWFuZUxjN2IzZHVNWHhIR3huQ2tPbnhiN0x2KzZzMjJG?=
 =?utf-8?B?WWNqTXByVlcyUlJhbFJ1dTBKWTJTN0E0RGQ4eUFOdlBkL0x6THdnb3BGVUlG?=
 =?utf-8?B?ck9hQVRqTktjTHZQVm9yVDVPWU5TcVlsWm9KTFFtckczZUdJQmpkVnN1UG1z?=
 =?utf-8?B?SWxhVjMyVEl4b0taZzVEOE9HYlZZODh6bVkwcFJqRUEyY2lMMndPczFiRzhk?=
 =?utf-8?B?VHZybkx2aUE3aWtUNG9JM3hTa2RDU0diUUJrL3BSS213aEt0Y3J5QXgzbEhj?=
 =?utf-8?B?OEFiZllySHdTeXg0QWtKZi84TW5XbzNueS93UzNwdkFVOUV0cklwOEYrSzdD?=
 =?utf-8?B?N25WV1J6LzJNVjB1L3pVaGtyZlJLNkpLNU5xbFBYaVowemYyVlNWdHR1c3pY?=
 =?utf-8?B?eVlyZTg0bXBqRmg2OEYwN1hQT0Rib1VtQkhPb2UzMjFUWVpVUURpKytUWDB6?=
 =?utf-8?B?dTFwNmJDaVJidVMzT0dWd3VYYVh2Zkt6VnpVYnhFeTZzR0EvWlo3eXpWdDQy?=
 =?utf-8?B?Q1VGVzVyVDFibzU5NWQxcVN3b3RGY2tucHVUOTk2Q1BRdkxzYkRicnArTXRh?=
 =?utf-8?B?OCs0cTdsRzJYTkdJd2Jra2xBVkRQTll0NFh1b2Y3M2JmellYZ3U0QTVlaTNn?=
 =?utf-8?B?TVpEUjFxZlFkVkZkU2NIVVhzcENERXA1RnRET3ZoUHA0WWZZWi96Zml5d0Zy?=
 =?utf-8?B?amFvV2NrclpDUmIzYTNydU1WYWNwMFVxT1JIcFdLNU5DMHhDVjV2NWRObHor?=
 =?utf-8?B?M1NFdjNFcy81aU5PTXVOMDFuWjJIcDNrKy84cDJTTmZaLzlCcENUKzA1eWsw?=
 =?utf-8?B?RnVZc1RrNEUxbFZldU5LaE5peG51WCtYYVc3dkUrWCs5Ynh1clc5bmxwL1NE?=
 =?utf-8?B?QjNja2g0dzdmMWQ3K3Z1c0x4Q2R2SFY2NFQ1Tk55c2lScGhVV1VFeU5DWUt3?=
 =?utf-8?B?dTBuRFo3RndyY2hZWStqMUZzVElhZDdNdGVhQlhDaUxaMU9sUSs4NkhqYmFW?=
 =?utf-8?B?alk4UEc3Q3RmcVBROUFPMjJ0dFVVY1ZPY1Nkd3F0VmJGR050amlCbzFVL2t3?=
 =?utf-8?B?bzhBaktoZU1QNnc2cEhaSUJtVVdQYmVqMDd1Z1d3Y1JPOGFUY0VyS2pLRDZr?=
 =?utf-8?B?NGpWNUQ2WGJPMGFZMGVVKzZuYlRiZ3BKMXVTa05BbmJIdW10YXpqSE81UERM?=
 =?utf-8?B?R1Nxck5XbFNyakxDVEU2dnBIZmw2N3Bzb1luVzQ3YjF2d25WRGZGWkpTbC9m?=
 =?utf-8?B?aHcwc2NvVm9qQkh1K3ljLzdiS2VPay9DYnc0QVFOSTRBYkpsdmh0SG9vUVpG?=
 =?utf-8?B?TnEyc3NxN2F1cno4QS9jUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUtUb3VWYzl6a21xemZNNFYxMXRTWVpqZjVXUDluNk9xbWJRZDZyNzliVHhh?=
 =?utf-8?B?T1ovdExzZHQ0dVorRnVIRTlvWEhTeDNDVm8xaVR5YUNsN0FqNG9SSXRUVWY0?=
 =?utf-8?B?T0pIZm9hMFZBUWVpK3pMNkZaMnc5bDI5cG9IUHBkZXp6bmZnYk5IbjNQT2p2?=
 =?utf-8?B?MnVLQUViaENBTE13OENzb1R0eTc0YlNDNzQ3eXFrZ3VGQ28zSWx6d09Eb0ZV?=
 =?utf-8?B?TzFUaVdaM1ZWSjBQc3lYcDhQVTFDYXA0dk81T0ZxYTZobnJMeHVpYVQ3S1Jz?=
 =?utf-8?B?amZ3TkVUQSt1enJuTXIvZ0p5Sll2S1RCYjcxazNFQXQ2Tm5aRmJFUVFHOGx5?=
 =?utf-8?B?L0FYT09VWVhUVXhlbXZ2aVZhSVJDTU50dklKWFQ4ZFlaRjhiNTNUeTV2US9V?=
 =?utf-8?B?NjRWeGo3aG0xUW9yaEVZZTk2R1VTSFd3Z1pBQUk0SDJ2Sks1SUtjNHU4K0Fj?=
 =?utf-8?B?SFV3b2xVOUhBV242U1N5UkNRMm8rLzFWRXg3STBoeVRVSHJCRFNJeVVocmFD?=
 =?utf-8?B?a0VxRVBZbVRiN2dYNUFyMmVteUdhRWVTL0EzNnlSY3NLcVZNMDNFcDR1NTlt?=
 =?utf-8?B?dy9xVDFWMzdjckwvREREMVY2cC9Tc3FmcG53ekFTcFpWWTRQNU9RNkdQNUFR?=
 =?utf-8?B?OS9YTWJsTThyVzdJSWZ1dWh6TmliMTdxaTRtYmRjK2ZiVGo3TTJ5U29tNjFH?=
 =?utf-8?B?bmxrUWdyTHNJVmRpM2NWTTZObHM0RExZcWxvV0Q1RWJteHQzUlIwU21PTVpy?=
 =?utf-8?B?UWo2Nm9GQ2syY20wN0wzYTdLeUN3K0lIZUlKWHZIdVFwTDJRM2JmSmkvZlZ3?=
 =?utf-8?B?WUFMMElwanhZSHBCZFBQMmRrU2RYWkE1WjlXejRwd1AvNmZnODdNRjdCNlJI?=
 =?utf-8?B?clNFbXF4dTJOTzFEZjBKb3E3dDVuV1k2Y3ljSkVIbjVJaVhsZzBkemFtYjJq?=
 =?utf-8?B?U0o5MEtIcDdTWE5TYjY4TjVaQ0lKWnlRaFErL01FN3RSM0J1cXEwRWVVVnd2?=
 =?utf-8?B?ZUlEZXVTN2ZGZWZxalN2b3VjNkpJcnR2T3ZxNXpwQ3lGLzJvU21yWGJGSXp3?=
 =?utf-8?B?amJHa1o4ZDdHQXU4ZEdrQnB1OWpJUm5qSFZOZm4wbHJYUlJPaWlvRndPeGx2?=
 =?utf-8?B?VlJyT01UNzFVOERVSUk5dnpVR1BxLzZnZklVeG1BTEQvY1VnN0NkeWRJdmd6?=
 =?utf-8?B?L0N3UnI5cWpPME9UT1JQVzRYbWtsbThsbldhY2xTYk11cHB1NUQyZ1NhQmFI?=
 =?utf-8?B?aVozNHVLSHNMcVVHODVKOHZZd0dXWTVJRlNSSFhnSzM3aXNrc3VlTG95NkVm?=
 =?utf-8?B?YkpOMHJrYXBiQTBDdTA4ZUdJYUw4UW0xaDFnaVNTYU1pa292cGEzN2JjZnQv?=
 =?utf-8?B?WGQ4VUs0VVhFWG9NMkxjYXJGVDBTbWlpcmlwek1xelVSdnNNeVhiRWxkSTJN?=
 =?utf-8?B?ajJVREo3OUN0RG4zSEJWTkNyRGJVRldCU0hpdDdLZTZYMmNKTktzeGxuNjd6?=
 =?utf-8?B?eEhhbUwxSzlCaE5IMjJOcDY3dzZ2NW5wVTRqNWdZeEpSUm9iWGt3NmJsSTA0?=
 =?utf-8?B?K0gzUkJQS0sydExBemp2eHF4eUZkTUIyV1RnZ0lnVjlkM1VlS3dVNUdDSjha?=
 =?utf-8?B?anFUOFN0SjhsQjNBckJ6R3ozS3lwTm93ajVOdjV0SW9jQzc0UGV0RUxlcHky?=
 =?utf-8?B?YXZKSlB2ZzFqTWdLMmtQMnlDeFdlTGZJaUIxV3o2eFkwUVRzWk16amM1cjE5?=
 =?utf-8?B?dzkxMDNHSHJ5cTcxYUV6ZU1uQUJJelRQd0VHcFJmcWZVNVRiRmhFU1hpWlR6?=
 =?utf-8?B?VWpxb3BFSnZtb0h4V3FSVkNxMGhKU08zT2FVVWk1djc4dkI3ZU5UM1M0aW5E?=
 =?utf-8?B?VE14emRiOTVPNzZMa2haa2VZd0NYVVZxK0wyWWVxMkNxczd6WW1TcWNCV2pS?=
 =?utf-8?B?NGdJanJ2eWtJV29NOHpZTk42am5OOGFOS0laT1ZTd0pkUCtrZXYxMHdLeGxV?=
 =?utf-8?B?Q2MvK2hUU3AzUko2Q3JTNUtzOVBUaXFGK2xkUGhoQlpYUFBuRUVhQVNyNE5C?=
 =?utf-8?B?bFlKdWtFZGN3LzlTRmgvMlMvSVY1TExodW84TDM4UnF3OHdRWURRNkY4cXRq?=
 =?utf-8?Q?wIaP1hR/rpGBV2HpMpHfow4E0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iiSYcfRvKFTUPex43n8eZ0py79usnqCjoA7dxoVSPbwHTBZ/rJgGftuAu/LbOdYqLOpp143sU6fYmJgHHBB5UWHGnm+O4bD4hPjhaPYGwwnxqVFjPqZy3jfztNSAOM7mrU+k/IsLDIRtHg3jfbwY47CKH5lIN2+ZdvG4bIagthbvpzMDnUcOyfZ3/4+TBrLfpdAEI65bA5m3/4e+ttMe47wz3hVWyn/XSeP7o0IrrSTdGXqjE1AgrRzTnOoburBkciNoiRPgS8WUoQOTVfb3w/3JxD/SDym/Euh5MhR5luHjwJQsCZe24caya/QQ5U4V85ko6ZNEIfmUBMfSeGyJ9tZNuQGMzgYA8sHB+pShRPpcqru0Zkn0+zwqN8u5IowMjHNgolDd1+EQy/c3qnkUK5FSrb6BJTB3ashczqCTkIu/CCzxeZWcK8NRPOCE4pLHR8RpqL09m7aCF9Ti0WgSxcbnBpAtmd0BPzaQbYtT6aIMXdQ4P/oNmPaUjFnWxymbyNSc67+RE7JklETfbBmSDEhS98njF83my+fPfpPW7A7+y+9mgfa4zaOrZz2egKFfqhED766iAzbr45I+hGjHF/ET84pftHe4I0RSu3GjTVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f551b2b-04be-49e6-0004-08dcc12f1429
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:45:12.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsYZwVil0QB0CuULHr1z9eLqY27EZ1gHNhtuBO0NEW+vp4P+0ELni1+q5qtvhApSnxQZ+PpNgGaSBeUVz8v/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200117
X-Proofpoint-ORIG-GUID: efzD1C3_f0HvWzmT1m7lPrWXdClCAOjq
X-Proofpoint-GUID: efzD1C3_f0HvWzmT1m7lPrWXdClCAOjq

* Pedro Falcato <pedro.falcato@gmail.com> [240818 02:36]:
> On Sat, Aug 17, 2024 at 1:18=E2=80=AFAM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> > @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool se=
al)
> >         REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_munmap_partial_across_vmas(bool seal)
> > +{
> > +       void *ptr;
> > +       unsigned long page_size =3D getpagesize();
> > +       unsigned long size =3D 2 * page_size;
> > +       int ret;
> > +       int prot;
> > +
> > +       /*
> > +        * Check if a partial mseal (that results in two vmas) works co=
rrectly.
> > +        * It might unmap the first, but it'll never unmap the second (=
msealed) vma.
> > +        */
>=20
> Bah, obviously this comment isn't true, munmap is never partial.
> I'll change this locally for v4 if there ends up being one.

Besides this comment, the patch looks good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

