Return-Path: <linux-kselftest+bounces-15831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC69597D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD08281EE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10519ABAB;
	Wed, 21 Aug 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6tFuZDf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AiZ5tSKg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51639193420;
	Wed, 21 Aug 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229801; cv=fail; b=cp3Pm0kmhrURhsBFcW/X2q5XN1gJyBo3qK6Jdz1AVsioTKHydbV099wa0G4QXQF7GhdqgepTDfHglnkJXrd0xkTL2tYmpgNblh7CYdkgnSDaGjkB67AAIf/OqsdYfXJ8gqAKOV1eR0UGufeVvETBHjRej/IteMyrbz+ZGs+veII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229801; c=relaxed/simple;
	bh=IfLSPsE22ArbQHA2QLVY7/WRlxQXldgJT2bT3MJssv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7LjFo3nN2qXP7/lcOWF/uwDHUBYnYXW6N6ps0zOmVBdRYSlIY3dfTKteZ9gQ9Y5Y2XJqmz0LG3dY1VYbJZVIOL3Ctf9/nz906DUOxufoavE2L14M3ZAwX9Di91vVruWRhjlcjDPYgDXFo+0OYMzdTS8RNcu89afQCrU51yZByY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G6tFuZDf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AiZ5tSKg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7tYuk011021;
	Wed, 21 Aug 2024 08:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=BdYynufT42FT/En
	drkzdaXdRaxovWMhHWwTQ4SHqDF0=; b=G6tFuZDftpdRhZ1lIaxQPf9sWZCSmO0
	Uk2UrTPUXwT6cvR1PS/zACmGwYxezE6Xhz2kjJy03KXwvmMptnsoqx8liFst712A
	cJapY1p8OZV7MAwgkmfiy8W/qwJdqY6+JO2pOMAs1UHWWdG2Frpr/p4oeAnMsbyl
	jHG6qyLeVv67DdgkUz5sjraBGTrgxP7aJvYSioVBJZpPZ047WbxEoeFvydV/iCsX
	1aScC1Asgo+RuecwXqhrGWEqiM+ECsDxpOicZOyrJvzeUlTEj3OL/Mhzm9KClqOA
	daJ9CAsKnUolujVd0S4YvVC8cOu77ux3wLLLT4hqLVkMve61GuNlL9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uy01w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:42:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L8dGkD035910;
	Wed, 21 Aug 2024 08:42:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415cwsr5wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZYhyS9O82opyZ2GkFlIBJ3P3BCQOW+Ckek0IcM+e5YxgYxiYDegpkIzTJ9FPdNiu3Ag8tvRXSHCauKtfuFmy+zsslbxd8ebN5kG3MoaRmy/OClg5VWF4qdSO79DuVBDlCm+rNqZCNhD55EtNitA1bsj7/clYl931MlpoYd3pf0dBB7UzEvPfqetRjw0NuduMT7j+HYjwqw/xns0HN1fnKg7NGTPm5ST4/CAlbuKmJE3Hf1QmU7Qt/eT3fJ6awdILHb+lHETMa0GtKmeDalq8HfUrajdNlgLkkK76g7Mi7RASAcMronCtMGVcIa0tNY0pBVRtu6t6vwavjKnfimc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdYynufT42FT/EndrkzdaXdRaxovWMhHWwTQ4SHqDF0=;
 b=Z1fAlRWA4Yh4cInc0DWmCxKT3CHMS1GhKh5BxOO+hc2+iuo4Z61yWdw6wlISeN434hIzmP1r8nsIXkGQsCq8SQ9wKEXvHnXeExijFdPmvhX5EtI/1nlw6UZKnz9aaTxXZahChAIb4dyA52R2nXT4flqyeZYWulnwB1xcvIH3Ku/IRsdovoqUcIuVfQg+3yX3ATTWEjZs5ZFhXkVQhw7wPMDnlpa09GTpjp8lFMI5CoIVAY8iWk1rBhPG0emfxGLI2eEvEbWmeCF0Vqjd38i4Gy+ESJCJ42wFMUQKCq8+XyWBS51zVVxzF7IUWYmiG95FE3wqhqVHheS1t2ze2UBuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdYynufT42FT/EndrkzdaXdRaxovWMhHWwTQ4SHqDF0=;
 b=AiZ5tSKgK+K/Us2hrqUjXIa9Yek98xMqFNqgG+qxncHKK5RMPWLw0GNaOAd8YDL3TOQfWyHmIItHM/tpUgFcPnun9qeie8YIsdzChtevPcWDoRtS1iJWTjU/IzqsqMloinSYKDBRad6Cd4zokll27t7GfmO1P7etKL2sxRBdig8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 08:42:47 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 08:42:47 +0000
Date: Wed, 21 Aug 2024 09:42:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 6/7] mm: Remove can_modify_mm()
Message-ID: <06f5e205-4b5e-4945-890b-0aa29828947a@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-6-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-6-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO4P123CA0467.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5748e9f7-3441-49ae-cf84-08dcc1bd3b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pVY5LPu2WJ/3jPPeJg5Uc4xnbc8kd+yYTOCGG35JZ/AEd4OITZFPzL1wFKQ?=
 =?us-ascii?Q?arHXFv7u9FHeoofTYJCODWudamgUs4+ZLoago+QsYwNelKZC6HNXr6xkwyp7?=
 =?us-ascii?Q?9/bz0xkH+/xmJX4HJE/1fgEcT3Ap28fDjwnjgCZKCOD6gmhrSr9KCo+aYFo2?=
 =?us-ascii?Q?5ehWTnz6urIzAiZ8rAV0ye+as5mEE6e/Rqry+tZStrCySlQVnnDZ87tY/blk?=
 =?us-ascii?Q?3XTIZfGi8222Fh0Mv6C/ijJVD2yZAcbMGfGan4OxwbznKP//tV8aQ3n4SCHJ?=
 =?us-ascii?Q?0+ZeMAlZuFM+wY10omD93FK6lzCjonXjAy6qtnXHGKG8jhV7SgkOuoOToZQ7?=
 =?us-ascii?Q?B3Hl1d6v+FKmNwM6n0RiuMZJORKefbiTP0xh98NdO9oCBg1E1a+uZCjVi4s1?=
 =?us-ascii?Q?uFAYt5cROhv8n1ebXzMmbvgzb+A8gBg/jH5D+UMfhPxhBSxggR8nerts+iJp?=
 =?us-ascii?Q?joz7sqVl9jLLtptuRxFVqI7891lnKXQR/7rVTCkePrPyZkypJA8TXgc1IJq6?=
 =?us-ascii?Q?HTJOxnyMeLDhfukKx3nheZGsQ8JRbsPwGPc1NJIGy+nC8A9xajKIC1LOoaN9?=
 =?us-ascii?Q?MWKHBlluI2ESEWGTahHXiyHsn/uTMrb7OOBUPehcH75DBiG8NCbK8lOB1i2/?=
 =?us-ascii?Q?VnfWnIwF4lV2vG2SqtjczQBW/6keX6d55BD7fKm7XB0Co/FbtUVaD9G16gM/?=
 =?us-ascii?Q?dVqVPnzFf9pLB6Pm3eck0Y9KXTjDJQjTLGnp5X/fh6ovGJUXJ24WrP5YfyUY?=
 =?us-ascii?Q?B3RRQst97RaxWtgmZsz2yQzA2TUAFTuv2hEjMzXoHGOQQRrzRGKZwKfJrsuH?=
 =?us-ascii?Q?MieBw/r6RfCU1PphxKrbv/SnXOCldgrehkFFDegFMBX2dGaZwmfHpgD04fYw?=
 =?us-ascii?Q?DL0TIXuVs+FKeeahJ0P8xd2br6TVn2to68IqkrTe1ql+ASXPHkQbTWAh7JQr?=
 =?us-ascii?Q?EQRx6NaDhQuhuz5jsDn59WaL3eVx+xLPuDaJydC34UsrL7ADyQCfcztykhvM?=
 =?us-ascii?Q?W5E189FQinmwiVg+dsD2Fs6oACvQtqtwGislr5OBA7sRbP791B7CELUDp8H8?=
 =?us-ascii?Q?/2UT36tqf36XT07KpnINzlr6JtNatC8lO0X1B4kc8k4uK/RJgeyEIVUfUfEU?=
 =?us-ascii?Q?FmVrZ++zs0P3fQShcdZtwvcIhwwyfGWHSKFC0iq3oTf0+wdT7fhbDkxYaA2V?=
 =?us-ascii?Q?qO0QOijUvBCUbE0llZgWkMRl+7J+2coBdTArKs5hk+bCsRJpbjzEH53lljrI?=
 =?us-ascii?Q?GXsTXiHazWfbVM4RQLxhmBCLLpaN/j7g9nz/QDBkibHwaS7PdNVZRKE8Oc2W?=
 =?us-ascii?Q?1GzvrdtIrb5rHKk39atMKiAEStfksowOK48HzRXEDoDDwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9+O/6n47acdVLNvaAiHRUG+INLHxhg1DsrzrU4WIa5Uzysz2XkiJ5qEpJdJ?=
 =?us-ascii?Q?qddPVhsm9slesJN/JPEsYm3N05As2cUOMnmtVp35enzZay1d5hn69Jkm4dvL?=
 =?us-ascii?Q?6SfjmGUgKnIlRzuBk9/G2laNUFtaAtkxp2ndJWynr9bR/A3jaoH7QvjSQefI?=
 =?us-ascii?Q?HqlXfXIO9wCDHGN+zYGYT73MakymTq4HM5muEwCZwSkk3odJuDqOpgCOVcQJ?=
 =?us-ascii?Q?IKCYHBF/dDsUgMGTz/lR1HOhL67/ao1qacIF/yOzeaDxHth69N0Iq/KSxuM2?=
 =?us-ascii?Q?5RwUu9wVarGvcrUvrCZBWDrXuvm82CgKo+hgTGHClAdI++YmUH3s0KTXsNql?=
 =?us-ascii?Q?5kIHbWdLjY0ksWqXANjDBzYNiF/zDobfE8SxM8+/73scsg+Kqwtizo2/0CYJ?=
 =?us-ascii?Q?heZHkTHQMFdMpA1wNGSC2AiNXqg41puc29cVKYxh//JIneGQPj87xEC7ky6Z?=
 =?us-ascii?Q?V1KSyhhy2+BzzGOu2s/NGebbYZZSiBm6wRKBPXQVx/91Lv4cegcMacnQ1Wl4?=
 =?us-ascii?Q?0g5o5ZotwMrCwOTTnr8uXGRJ2XegEuzts1Hpkj4CASrhniS7UVvuArZAg/yu?=
 =?us-ascii?Q?WMOiL6PQ5vFEHyFhUnLgD/QS0OUyatIh5gLBCZEpBksqeHR/mNjyzPr4Q2S+?=
 =?us-ascii?Q?m49gpqrrPY+fM5yQ9IUJuzn3Cqg3umVK8cPSSrzY32d0ZPi0keyCAvkOVBWc?=
 =?us-ascii?Q?ZqoIKtSUqYuL2cW0oL2abvTCHAU3UouB+1EKGs7WDZc2dtgTqxEW2e7y+Cwy?=
 =?us-ascii?Q?IweckqR2NVdSZog3xYC0Hn0AXmNHJ0I2AB5FX+SXxKgvGSnzEojFWwaVgO32?=
 =?us-ascii?Q?nsx6BERoU++bf13H7RvTlPxQskGiyjTDHf/BXmxMFgCtYJCqZoIinf2Z6kEX?=
 =?us-ascii?Q?0u418Kf7BODr0uC03Nug51Flgw2DGfX9BR+D4ZShNTkYc3hbJNTDwsAD6QkZ?=
 =?us-ascii?Q?VVyv9shtR1vG8RYrL0CwJsDLzGzwYLbM4otziau7ND/HkYoSu28GAmrbt7yk?=
 =?us-ascii?Q?UnqXpFDEPRMCoV7hf7VpAiqz9jTc+7dBem5s9L3IlRpO92LOBOLPdrJ02HqR?=
 =?us-ascii?Q?JO5UfkVzxBqvzcI5aXHZoFYRu8ORKvKK/saDPmKVPS4o8QpGEl5JyNb8vl19?=
 =?us-ascii?Q?F0gNp38zdVPEH7HyU18+GAQaXL3nCPE3m3ccV1noePGg9i4E6xMj6ci0PYNs?=
 =?us-ascii?Q?A0ewMi9jNpmQmT+czJY/0DmRds2qeG4MD7pdR91QoHgEMM2Fi0E7EehPd+U4?=
 =?us-ascii?Q?v3r4XJ9njuXTdCw7td2fiLcEZat6x3NXHNUxRdonkxwrWEfNQ3/JRBkvWvuT?=
 =?us-ascii?Q?mhAS+FhtCwRlcOL2yk6rmJqTc73iWnLeNOS/cS7dk3du8O3CerCCNN77mAtf?=
 =?us-ascii?Q?IofF8eLXXkMnCvKTBlRdqxi+zA1SNt06som8mmRZT7MB6uFZseCmckHvwDR3?=
 =?us-ascii?Q?/4HdBlw6WVWIVdcYeiOk8QJtHlj/pSRWZ2xYy7dNCRW9pGN09nPMno8Mvu9R?=
 =?us-ascii?Q?V5YVfiszbh4nGvewCTg3f0oKk+EePxPdliHOOwSIjSCX2j/KOIAyD0pYwRPA?=
 =?us-ascii?Q?lOdLmWRkPWWPHxVasVXsxzLdteQkNqXv9PV4zJa29JwzKhAtGEoHyZH6VPav?=
 =?us-ascii?Q?cZHCw+ge1yqsUzay9D3D//APqmbBIVBGdiop6YDUCwgm/+5U82Ms7CDtzOu5?=
 =?us-ascii?Q?0ssyYQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v7p76A7VH/kzETRclbKdG3x7kkDi2JIk7Zgugc9KcmXi4p3lHu/FH1JLu+LrJIaPbGweLdlLYDC3Bd9escrkwSijJuQqQYLaACCeSIYWtm6/FQpehyee6HdZCQ5hi3UtHVdxApMEDBt1XR4SfCfioF/4opFgGNUaittKEexRQNLiamrEJB9bkbvGWfH3YKSDbecthBfy8/fUXEgIAhiAhS88kW2U7C4nOK555bzqdr9RFFHSXaPx7NcZaluGCoWhIJ2NeuoyX9jsuQGt84lJjzYOse2phuAKCSMNTN6NhtY5jhbhlGH/48W/otlj19CZBZ3q6rOhrOYMOeNNojJi0vyEJKV07TJlvMANyVguHq+q0P3IwssPyqhsBaqD4FHXgFodg0etTE37+tZG3A+LO98Q2hFEXChu5IiUG1KuCJ8kSuqCu4pKf8nDP0kCgeKKYcDa7PPe1fYXRW2KVpY625NIXGelLRfjHnF6KVj58Xvng4F8lAR47e0F22iPGZhx8L4WNug+AxSgq6soq35B+gTHewzR/rKVaaPx4LKDpQOK/Dl3jmdK+eqVR1omjZlT/BQeBqwHILl0Y1I2eT9SF+qrXEtzfFVbOMkt66e2iKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5748e9f7-3441-49ae-cf84-08dcc1bd3b64
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:42:46.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNG5p7U3BgiiLVKhrWY9bH7PJlQ01NuzWr8l/EVD/JAY2uQvbxXIG3e0G0iqpeWMO0qqpFTjMRD9tXeyvr27DMktVGVH/zBSoQ0OCKi0GkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210057
X-Proofpoint-ORIG-GUID: MorktbNbgDVHvgydAigiyO9ZiI1jM6LM
X-Proofpoint-GUID: MorktbNbgDVHvgydAigiyO9ZiI1jM6LM

On Sat, Aug 17, 2024 at 01:18:33AM GMT, Pedro Falcato wrote:
> With no more users in the tree, we can finally remove can_modify_mm().
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/internal.h | 14 --------------
>  mm/mseal.c    | 21 ---------------------
>  2 files changed, 35 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 1db320650539..3b738b0ad893 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1361,25 +1361,11 @@ static inline int can_do_mseal(unsigned long flags)
>  	return 0;
>  }
>
> -bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> -		unsigned long end);
>  #else
>  static inline int can_do_mseal(unsigned long flags)
>  {
>  	return -EPERM;
>  }
> -
> -static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> -		unsigned long end)
> -{
> -	return true;
> -}
> -
> -static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> -		unsigned long end, int behavior)
> -{
> -	return true;
> -}
>  #endif
>
>  #ifdef CONFIG_SHRINKER_DEBUG
> diff --git a/mm/mseal.c b/mm/mseal.c
> index fdd1666344fa..28cd17d7aaf2 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -53,27 +53,6 @@ static bool is_ro_anon(struct vm_area_struct *vma)
>  	return false;
>  }
>
> -/*
> - * Check if the vmas of a memory range are allowed to be modified.
> - * the memory ranger can have a gap (unallocated memory).
> - * return true, if it is allowed.
> - */
> -bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
> -{
> -	struct vm_area_struct *vma;
> -
> -	VMA_ITERATOR(vmi, mm, start);
> -
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end) {
> -		if (unlikely(!can_modify_vma(vma)))
> -			return false;
> -	}
> -
> -	/* Allow by default. */
> -	return true;
> -}
> -
>  /*
>   * Check if a vma is allowed to be modified by madvise.
>   */
>
> --
> 2.46.0
>

