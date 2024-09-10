Return-Path: <linux-kselftest+bounces-17618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F817973BFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9581C23E03
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B08194C77;
	Tue, 10 Sep 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxDz43hr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jfxNNWS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D34204D;
	Tue, 10 Sep 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982318; cv=fail; b=cfbj2vkdmo4kgChbKSlPqkR8Vqna1e3elqTOe5ZHXFjR2GgObcQp0KNqQwAVGdtf48w6gnZjlFAemZ+jwAqjUxpuA8Ej9K3awk7eqHRdKkTZMqIde2b2/Sk7umL064H42d1czfvBhCEeKrmH+8vCbeE4lKmjFGM/M9yxzqzXnUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982318; c=relaxed/simple;
	bh=E7Pd35crUMUCj97z4VRMuCeU664jQQMD+5rU+8B+grk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GNT8JE8RVX1DxDFd+YQc0NeyZMhP7+pmXB0PApruyyJqNHABJSIdkDYEzK0jdLYN+I8K24w3uzE0ALIacFY6qXmHdunGty9EZy43hdvhC5dugpsvZuqq3EotFZgent8NcRM0SHeDy5kM09fuVPjLBV41hK0PmDexhxqTGrHFAfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RxDz43hr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jfxNNWS7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AF3TY9032333;
	Tue, 10 Sep 2024 15:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=8qlFhkXDh0LDIORuV86uCm6yMlNcqXRh+Sp0a+aLWzY=; b=
	RxDz43hrcjA+fkFyPHZFLgdv+3hbMLVj8Y58c7qIqHSPi1XDFZKVQLtCGBJLY5nC
	fVn86M/GP9K99JB3dkSaUK4HpWdy3JbuwXDZgE/SxvyzPMa0iQacD22UvkDjVUZr
	q0SdG0EENYzwr1peK3Bogs/zYAc+EXI4htjJocF+6a4m+1qV06FOrVOiYCzyJsTR
	jDrvAJasntPCLyKnNpyPOhAznfeEHKK5haUS0L6+0JYAT1vv+w3+CVs/73wh9rJV
	XCryy1ZxWOYbsvtseNlj3WxvGnFCE1hbrHpC+wiNaaQvIBGflc/qVVkF6CPwIiOo
	DyY3j49KmQnsttYq7/mctw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8cwuha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 15:31:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AF0QVv031630;
	Tue, 10 Sep 2024 15:31:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd997uk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 15:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/Ynmum/x3xCmSzj1OVmMws8gh3v02po/RMCXfNqxECSLl0mivRb3eu7Fp6Wwbm5MlUDbtq/HkXtcw7kA4mf9dOdAQ+gUvtRlTJb4iiVo5TlAFqjzigMPJ1YoiLPuKqBDgFWwZ+wNU++sMIq7QSC2bAER7+mrez0QrVxvw0W04YeK65O3TGyU9vsdqsX/bObzDGaLwrSiisYLfw0Ra8qWIQrR9oAsUoTKFC2osKxCrnzc/zJFsa+qioIpEyvMw8r6ytSVS2onsONXfxMO10Wp9LIjV3jPhzluJo5HbeJ1e2s2uWym0ihhXD9KGKaozjGPgp8aYHIXS3yE5xnVUB+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qlFhkXDh0LDIORuV86uCm6yMlNcqXRh+Sp0a+aLWzY=;
 b=jl0iQnZ4vkyEZ8LXz/dTbZxIPtBAkXzdSpKwdK4NnU5gzyiyqQbG03Tbu6/T5ycUC8wtGohPXXNO0KWIt3OYbocGOwEPhu8vVypXsN2stgBedPQYpMacoegXvTcNjCSmbGmgvkVMHGXgXzSXYHcqCU/8uzYDB2Mut5IIe/EpjdxXrnMkQ6XvaQHJzemb/540lE+hBM4z+R0IZYMiTg8iRmGxGufwewL26BvhaSP8oRcGw5h8kAb9DRJnBuh8TGOj+gQarWFxNurz9EpTu7T21ILrGpUv5BJcIpDq1dTN5C2PEI6t3eR1miCbHSBjxDT+RiUIqv3uuUpR4MTaP7hmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qlFhkXDh0LDIORuV86uCm6yMlNcqXRh+Sp0a+aLWzY=;
 b=jfxNNWS7em5WN6WU6slFTepXWb4+MhREYl8x3IUMJIjV6iErnmvUK/M5kcFNVwCKnquaRLTNDooPeYwMb+c1AEsy9Nynt70ov8WY7a93f99Laff+xBQ/jU63hVr8S0BH7ls18mzd0fGvpRHe8R1YrZTMbrvcI9iqpoYjWADV3f0=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 10 Sep
 2024 15:31:41 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Tue, 10 Sep 2024
 15:31:41 +0000
Date: Tue, 10 Sep 2024 11:31:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
        kernel@collabora.com, stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: Fix build errors on armhf
Message-ID: <pvdw7s4uorkbi34txw7zkrpunjigoahcwt7vepbpgtm57rlehh@zy5yxjr2g62n>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Muhammad Usama Anjum <Usama.Anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	kernel@collabora.com, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240809082511.497266-1-usama.anjum@collabora.com>
 <CABi2SkWgPoWJY_CMxDru7FPjtQBgv61PA2VoCumd3T8Xq3fjbg@mail.gmail.com>
 <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
 <CABi2SkUih8XrA4aJwngAoByCytg-PthJ8JrkKpzJRFP=f9zyKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkUih8XrA4aJwngAoByCytg-PthJ8JrkKpzJRFP=f9zyKA@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::12) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e66981-e86c-40aa-558d-08dcd1adab67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?di9vNFlPaEFTdktLdit1MUlRZElTVkNub1gwVSs1cDcrNEdNTWdUdW1XUGQ5?=
 =?utf-8?B?b2pTb1ZTL1NwSUhDZnBWc2hwMzlkRzBjRG9xQWRXLzVwYmVoVXFBV0g4WG1M?=
 =?utf-8?B?aGFlWmtzMlV4NHI4TDFuY1lST2d4VlJSc1NFeGJkaktsWDBTWTdIOEVRRGNS?=
 =?utf-8?B?djEyeU90WW1FR3UrK1ZGMTczRmhIVVQxMTM5TGFmV1k1U0ZSTGdYVmxXd0Uw?=
 =?utf-8?B?Rlc3bzI1RUo3TUpNb1FnOU0yOEJJNFVoMzlENEt2Nk9paGFVdm5FdjJUMjVV?=
 =?utf-8?B?WUxob0ZYNU1aQndxdGgrSFdEdWxvOFM5Sko3aEdZM1lpWVU5V0FLY1RPdnZM?=
 =?utf-8?B?UndyRWo0ekxNdXlXTTlMUWNHY2dqVjQyOTZZTG5UUHNhSFp0RHBmckJtOEFK?=
 =?utf-8?B?SkwxcU5YdWRaRFJsa0krSEhYM0QrTW10ZmplN3RsVTdpcVRkaHFlLzlKZmxK?=
 =?utf-8?B?VTNLaThOSnQ0ZHhBcWZWaHFKVHJXSzJwQWo1S2V6eUhCNFNRdGUzM1lXMEJP?=
 =?utf-8?B?a1lVdzRiOE5EVGJDczViTWtNdzRIeFM2YWpoTmhLeFhEUWVFQlZDNWduS29y?=
 =?utf-8?B?aVVEWGN4eTVoZ3h3OExNbnBLL1k0RHYzYk5zNmJFVzZ2czcwNGw2ZXJscG5z?=
 =?utf-8?B?RWVaSk5ZVnJsNFlnTXJMNi9wTHhJQ1ZDeHVYMUN4VmxqNEg4K3MySEcveU5z?=
 =?utf-8?B?dnlJbTBHOG4rQTdxZzBaUTJmMlZjb2V3TUg3VXlLZTZBMzNHR3MySFhZTGJN?=
 =?utf-8?B?TTJzVHMrL2o1OExHMWl4TDlSRm8wYjE3RGtOaHI2U2ZhWFZLWkxCbTY4d0V6?=
 =?utf-8?B?OTVvaHJiS1ZEdmxPL2FZNE5GUnNOM1JqVklzZjY5eG96ZkFiNzZKbnNIcXFp?=
 =?utf-8?B?aCs4TUQyTDMyeDNOek9TbjJqTDcwUThtUjVxTmlSUnJXOWxMVCtoWElvTlZa?=
 =?utf-8?B?eTJsdThrMUxoTTRsZG9FTDIwWUZPL3d1KzlJK0hmaWgxWm5WS254Wmp3LzRM?=
 =?utf-8?B?c1ZSa2dxNWFDYk9lRkE5WjN6Z0RXYkUwYjdCdDlUUmNaRkhxU0h6NkR5Tnli?=
 =?utf-8?B?bWk2VWFxaG5EVnFTTXhIblFVTExBUHdteUNnbWZyMDl5RTZrUGUwQk03bHI1?=
 =?utf-8?B?bDJLd2IxeE5Xdk5YSWs0cUpmUmIzZ29tai9rak9ZQ0s3enU4MUo4dW80TERE?=
 =?utf-8?B?eUYzNUVmYlVLSXU2dXpZeEtwMGdjTHFqZmloeVJEK1FEa3pLbC9nZXlUYmtn?=
 =?utf-8?B?aWZTS3A3aUEwcU9VQ1diNTVNWEZKUkNyRmpGeUF1bGFHZG1DN3liTkFLZ1o2?=
 =?utf-8?B?dEt0N2pGUGszWWFaQ3FNMXBkMjI4ZDl3YXFUWWZQVEY1YjdteUc1Y0xjWTRZ?=
 =?utf-8?B?OGdnMEVpaEFwQUtKdXhBQWNmUWV6MC9sK29wczVGNDlESThBTWEydG1SRDUv?=
 =?utf-8?B?RGRIZFdvSHFBSCtXSEN5R3dYcStjU3p3dVFGRnRqR1hteWhnVHJTWGJpTW8z?=
 =?utf-8?B?V2RQVFh1czAvS2R2bW94UUpUcXFFQ0hZSlBtdlRPazQzbi9DU3dvcEFvZlh3?=
 =?utf-8?B?bGFFTVNLMTY3Nnp2NkJhWk96OWVEMVN2aW1LaUhrUm5qTWhwR093V2U2VFkx?=
 =?utf-8?B?bTc2TDVUSFMrNTk4d3VNOWY3YTVXV1V5TUtKNHoxVzYvc0dXOWExTzdCRE50?=
 =?utf-8?B?LzgySi9ZcFB6RVlyOStmenJMTkFOeVFET1NPTmpjaVJIZWdlZ1Y5clpiTml1?=
 =?utf-8?B?bjFzY2tIT0cyWlBSL2twaHpobWhPS2dnLzFscFNiN0ZkRDhHYjhQUHhmd3hC?=
 =?utf-8?B?Z1FaVC9tRE96eXMzbE52dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VENNN3pJaU5XOGVvbnFaeCtWeVhkQWxDblJZOUc4RnA4dVAxMklCemNobmRI?=
 =?utf-8?B?c1VUaTRRMTAxQ2lKU3c2R3FXNjE5Y1pTblczK2gyL0VNTTFPeGJEM1pydGpZ?=
 =?utf-8?B?ekllTVVlbWowanBiU2F0VDNiRExCcFRDT1Fnekljcnl1TTVqb2NobE8xTUc4?=
 =?utf-8?B?QzVHdFJyM25sWGxNQmxteWQyU0ZBMG15VmlTSzNjZEhzcVBBTTBMVFI5VGVi?=
 =?utf-8?B?blhseGI3MURHaGFiMk1LMDlMUjZXQ2tNUWlVYUxYRDF5Tnk5WXliK1lad0FV?=
 =?utf-8?B?eVRUZDRTZHNYbFRNQjdQcUJSK1IyQWo5aXpaM1EwS0hPb1VRV3NubnVQZWMz?=
 =?utf-8?B?N20vSHN4ajhyUjRydXJ0ZG9xMklEVyszWWRSYnZNZDZqZEFjaWt1cnYxNkYy?=
 =?utf-8?B?VVZLQ1lwdmptazREVDVucEYwWWNkVVpvMEh0QWZ1ckdDejhQUjN4bndZcVk2?=
 =?utf-8?B?aDUzd1RIa0E3aEJIdlp1Z3VGcklncWpNY0dUNnlidnZaZ2NRSzZKVjFYbEY3?=
 =?utf-8?B?cTFJaXhGN1NqakozSDdyc0JhbGZFWlo1VFd1eWE0Rlg0M1F6Z0VYLzhGVG5v?=
 =?utf-8?B?ZzJXc3ErZmltcHdxUVRIb3E3RHk3WGZsbXl1eGpiNXhQQ1A3SEpwOFptWVQz?=
 =?utf-8?B?RXQ3Q2dSR0lRNTdydEtsYzVSRzlINWNLNVZaTllsaXJBTXM1T0FoVnJQT2s4?=
 =?utf-8?B?RllDQ3pWaWsybVFYNVVPVGxFTCtpS3JXMHRqak81bWI2aDg4R2IzM2NqMHAz?=
 =?utf-8?B?NXRLeER2TXFDalRqYlBoRmpOS290SnptdUl5TFd1TGMvU3FKSHlPeXdiUGMw?=
 =?utf-8?B?UEhEOXpsVWdCU0k1UWh5ZVFNaW1ONmFoT3pPdlU3T29Cajk3Rm4xUzhrbGdo?=
 =?utf-8?B?QTUwUXMxWXU4NVdOVnkzZ245ZnRwclhiUVdyMEVsN1V0NzllUVFrQkF5TXh0?=
 =?utf-8?B?eEVCdlloNnhZRDhGL3J2UjdNNDk0WXVkbDVpWit5LzY5NzQvNStkdnppR20x?=
 =?utf-8?B?Ri9TVlhLcW1rc1dsanZkLzJaTld1Z1JIb0FwYkI2dGRydUVUc3ZWdkh5cThK?=
 =?utf-8?B?S3lqQklDVTFFejNzS1hoRUZObFd6eGI5T3RvL1JqWEdvZjlhdEpMRnpVeGpw?=
 =?utf-8?B?VjNGZVk0YUJFMDByU1RydzdpL1lkVlJpZVBJV3lmSUpFcUt1VUNJME9zQXRL?=
 =?utf-8?B?L3owTU1qTU9CNGlLZjlQaWYrZHJBb3E2OVFDcER4L1RGL1hja0FoZWUzbDRE?=
 =?utf-8?B?V1FkYjI3OWR3dHptS0dKUnVpcXhvK0UySU9iYjRZdmlsVzd1akJzUmlaMGV4?=
 =?utf-8?B?NG80eHB1bktFMmR3ZGZrZUNxVG5rK1RPY2ZPVFd4eXVVbUoxQWdPUnpEY1di?=
 =?utf-8?B?QUNIdzNYUlRxaWlpSlBHWkQ2YUF2R0NSZldHQVJWT0syRDJYNHJZSVpRaVB0?=
 =?utf-8?B?RHJBTk9Bbk5uaEQvM0NSbEVFQTRkazV4NHNaMzFPS3dwbkFRdnlFR1BMdXQ0?=
 =?utf-8?B?d2JZdkhRQ3NrVzI0S1IvNU9ZKzR1cm5LcjU4K2h4K1N6UEo1UDJOU2VYUUxI?=
 =?utf-8?B?K0FsK0lBWjR0UWt5NCtEUk1yUTlyOEw0TmppVjBsVFd1ajVDcll0dVZTU0lT?=
 =?utf-8?B?WklDUE9aNDZRYXVLcEsvaTE2T0NuUndaOERIT3ZEeGdRN0tOMzNaU3JJZ0Nr?=
 =?utf-8?B?LzAwcE40SXcyTTJudm1yRW8xcGV0eWJpUzcrUWZwYlV1UTZ1N21UUTlRN2NI?=
 =?utf-8?B?Y3M5K0UyMytFV3cwVTBtcThGb2o5NU5XUjdYVm5GMWYvVzJDekhmWjM2cDBN?=
 =?utf-8?B?ZDlVSzNsUEszbUJwOXRMbVpaL3gxS1BZa2lFRDZ3cUdPd1RHRjlJakFGMTB5?=
 =?utf-8?B?Wk9rK25vYUpLTmZ3VE41YzVxVVdkUzFYNms3dG5ZLzdab1dyenY5eWRvekhr?=
 =?utf-8?B?L0ZzVVhwN0o5S0ZScGVVNW5FZ0wyQjhNc21rR2ZnVG9VeHFCenBtUHZKUk1r?=
 =?utf-8?B?VXN1TkNnRXM3NWRHcVdoWG9xR2lQMjlJU1I5Rk9CcUk1a2YzRngyWkdocWJa?=
 =?utf-8?B?elFVMUUrODMwSjBEZnBDRzZHblpUT3RHQWYwaFZOYjNZMHhUemVDSWdFVjdk?=
 =?utf-8?Q?LyHdciojpztH31pv96VDGO8zO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0zeIQUPat9dVJtnyEVUojq/kiUz3Ti4VYJeWuoMOq2KwkBVZthsWmoczKinh+HJ6N6lh2sg3bDFdXSaqDPCVQ5AWA+oLE2aHpqAkCRlTlpwO+DEnsj94sMh4EqgFnMPxilXXI1aPcTbE8g6laHtRAwHwdKLoeUW+J8ddrg+bsYswSGvRXKRYFgrKtOds5/On9qNC4XVQxQRv/MCX/Nij4q+wrroyj5SS5iWjMVvER0WMkuyP6pWC5+jlExsdpkhXb6YAUOerd5C5g1yoqhzs6gdOzOuCn5coS3X/YR3F5QVifQqYcuLAthlY93/ViUjWhfOP2dpEqRMQ6K+aFGpsBPTs0IFAVHfmCnIvfJ/d3HPF/+EiGNcsBjLSrb5oW5ZfzVNDHmhjvy0mfpmpKYA+ASyvx8eVZzOwxUQnAtIFvUgxCzawTnJkaFXj2qUtlMdrn9mcHj3l+2TlUZPvhale/gz4sSz+lspD+S2YmfnNjZgSPILftI+v7S2koB4IRvgNsPPFTdgxLWAddcAH/tn94aaoMn6m5p2ym1f6UQQNeWe7bEiSLIS3K0C0PIxV9o6JOrgRPbt22fKFKfWEqf9T17WINspxzAwcOPNbvdQTEbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e66981-e86c-40aa-558d-08dcd1adab67
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:31:41.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znL/v0u/RRifOCqaYM2m81TnwSoOAt/vsPR2A5ozMXZK/bTr62hcp5CzzVlXcDxWYE5ZL52zfG7irEZ3qr4/pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100115
X-Proofpoint-ORIG-GUID: OaVhnbUcOQW_59y30qXZ5CD05gROq3Rx
X-Proofpoint-GUID: OaVhnbUcOQW_59y30qXZ5CD05gROq3Rx

* Jeff Xu <jeffxu@chromium.org> [240910 10:15]:
> Hi Muhammad
>=20
> On Mon, Aug 19, 2024 at 3:05=E2=80=AFAM Muhammad Usama Anjum
> <Usama.Anjum@collabora.com> wrote:
> >
> > On 8/14/24 3:29 AM, Jeff Xu wrote:
> > > Hi Muhammad
> > >
> > > On Fri, Aug 9, 2024 at 1:25=E2=80=AFAM Muhammad Usama Anjum
> > > <usama.anjum@collabora.com> wrote:
> > >>
> > >> The __NR_mmap isn't found on armhf. The mmap() is commonly available
> > >> system call and its wrapper is presnet on all architectures. So it
> > >> should be used directly. It solves problem for armhf and doesn't cre=
ate
> > >> problem for architectures as well. Remove sys_mmap() functions as th=
ey
> > >> aren't doing anything else other than calling mmap(). There is no ne=
ed
> > >> to set errno =3D 0 manually as glibc always resets it.
> > >>
> > > The mseal_test should't have dependency on libc, and mmap() is
> > > implemented by glibc, right ?
> > >
> > > I just fixed a bug to switch mremap() to sys_mremap to address an
> > > issue that different glibc version's behavior is slightly different
> > > for mremap().
> > >
> > > What is the reason that __NR_mmap not available in armhf ? (maybe it
> > > is another name ?)  there must be a way to call syscall directly on
> > > armhf, can we use that instead ?
> >
> > It seems __NR_mmap syscall is deprecated for arm. Found this comment in
> > arch/arm/include/asm/unistd.h:
> > /*
> >  * The following syscalls are obsolete and no longer available for EABI=
:
> >  *  __NR_time
> >  *  __NR_umount
> >  *  __NR_stime
> >  *  __NR_alarm
> >  *  __NR_utime
> >  *  __NR_getrlimit
> >  *  __NR_select
> >  *  __NR_readdir
> >  *  __NR_mmap
> >  *  __NR_socketcall
> >  *  __NR_syscall
> >  *  __NR_ipc
> >  */
> >
> > The glibc mmap() calls mmap2() these days by adjusting the parameters
> > internally. From man mmap:
> > C library/kernel differences:
> > This  page  describes the interface provided by the glibc mmap() wrappe=
r
> > function.  Originally, this function invoked a system call of the same
> > name.  Since Linux 2.4, that system call has been superseded  by
> > mmap2(2), and nowadays the glibc mmap() wrapper function invokes
> > mmap2(2) with a suitably adjusted value for offset.
> >
> > I'm not sure if behaviour of glibc mmap() and syscall mmap2() would be
> > same, but we should use glibc at most places which accounts for
> > different architectures correctly. Maybe the differences were only
> > present in case of mremap().
> >
> We shouldn't use glibc to test mseal, mseal is a security feature, and
> an attacker can access syscall directly, so the test needs to test
> with as little layer as possible.

This sounds like you are concerned about the use of a library
artificially reducing the attack surface that exists by bypassing the
library to access the syscall directly.

If you have an example of something that is restricted by the library
that can be used by the attacker, then we will need to roll our own
caller with wrappers so that this works on random archs.

It appears that the existing tests can use the library without reducing
the test coverage, so why would we maintain our own abstraction?

This patch is also upstream, so it is obviously not going to change at
this point.  I'm sure you are aware of that as you raised this concern
on the failed backport email [1].  Neither of these locations are the
right one for a discussion that you are trying to start.  It would be
better to produce an RFC patch and send it to the mm mailing list and cc
the people on this patch.

Thanks,
Liam

[1]. https://lore.kernel.org/all/CABi2SkV-FdDQy2bjDkpgpqz7hX7ybeTjCrUgUf6Wc=
YqGkuxWMQ@mail.gmail.com/

