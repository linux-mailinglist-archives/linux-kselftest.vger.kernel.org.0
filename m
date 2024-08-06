Return-Path: <linux-kselftest+bounces-14847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE5F948F35
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B411C23639
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EC1C68AD;
	Tue,  6 Aug 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kq7JkNFB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DZ1HNRNT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D61C57AB;
	Tue,  6 Aug 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947978; cv=fail; b=lCrcIOr2q+WK67liCro/l4D3AN+/avFURkLVDD46uky/3z7bk+ITZlQmwHTvOS2xAwhd0h6khFQ/t72O3Y8pSHgFmQkeWZgQvlKTeih4vlDW3esc4aTEBZHkmdmk8xPkU2ktJei/pq/H4FiZZ7ZeRVbmi8mfIwGQ6ix3oBP9Yq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947978; c=relaxed/simple;
	bh=uKFmzDkNfzJJXLYnVWq2y5NoVDD3m5/DhBW2sIClYwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LakdqQfuyxG0HsGjKmagAkN2KEH0+qfcmIRcJXrmH9Nlzw5fjGY9qVRSG/UiP+AyEAtyo3ju8Pc2lWV06Ip7uAYyPfb2mSoLKH0qC4MOxu7OWCUBW7s3Leg7C/GyDSwl8+ivB68rTDSMHAXSKUMxr+nM3iaaQ2pnRLb6ROhFauo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kq7JkNFB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DZ1HNRNT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765lDm6001748;
	Tue, 6 Aug 2024 12:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=L3WY6PHkIlvdIxhPnAxQVlI6xaRbpl7u/wgjeX1iJIc=; b=
	kq7JkNFB/ip1cVRwW9EMRc8PSLTZxmioEqH5thxwpjXyHuioao7tZChAH+F8LtK1
	yvKFAAaPgr8lVLsExeQ+N8lJ36XBN5PlDphDX9MmH3WW1S+ZXyDLoy6OlqSH1rwu
	dkzX776CcSzUUDvJ+jBfqeSoqaD5Rk3G4GAu4Bs61YOzccZk2Qv/lh6NsApfKtSW
	/u04V9OvIlDPXzFxvPuXj+lhUshyOBV61mftC5atD7Xc1KwL1ROZ+/SCkC6nhBDv
	xd1+XL/DliwpqOv4SVcyCX1AgmqL84csJpVrszRR8pcXr6k0EArQ4DAY0ub+e2e6
	PZiG4roxLB25igLWJLpt4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfan81n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:39:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476C5b2D034972;
	Tue, 6 Aug 2024 12:39:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08sw98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dciuQSWwtWmID/snWqIG0pVg2Qbr/KCYrjbGnvHXmO7scAulWNPUYyuxUebJzQm6MjZJLxyE+1rWuzrRnQc5sYtT8aFEzVEsYT21GEZ/YAjxx39J58ubww2+21p6k4sS3INZioWNEjKY48EpIDb5t6F5coPHJcj/kd7qyT9XTK6iS1DpDkkBx17AUdDImS5IUmjBIU9Td0pzxP8LcpRUu2YthkzgNLNynqQO9lJ9DfuRMiT65pHCuh85earxlPQBwOYmmNjxYqLNvi3XUZI5sDUw8GJWBKguRLtmRNTlGFTdNUhesn7CuUJSl2Z1QCGgoaXBD6aJr+MOHBH+jKRa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3WY6PHkIlvdIxhPnAxQVlI6xaRbpl7u/wgjeX1iJIc=;
 b=HWfo5o7TQld+HoNe4VxK7qMtu1pCjm21A0iDSynJSA1wkDmZbHN/afBN3dLeNYsWsvOJGCnlV64hW8qsY434Q9aTm9XJ3HzWlWN3lPHNmCJOm96nJLvCFBcatzEdpLhP3ZCq/348KlPIxKfOaps8daF2NAY6G/6apKdT876EuyrbCrN4MY93unN18aFySklymaLwNQHYeo0SuJCA74ahJEtNmO9KSGi5clqYYBRpQ7i6mXZ+qdnA5SkZxUloomDBvXS7o1HJpM026jsu+N5zs71K+KFcME2ckTCFLvibwG/ZfkRqeRdIsHSUuwBnE74WI2EQOq32SbOVdpl1UrkYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3WY6PHkIlvdIxhPnAxQVlI6xaRbpl7u/wgjeX1iJIc=;
 b=DZ1HNRNTdF3l4htLLBrChz9wRHx8pJ5j/jE9IFeWDKJX3LCN/6N63rClCXbO3al4ZETmVItZC6AoHwoX6ZL3zGJgfvSmhVOYHDhkW/H9o5K6KwzVULeI6RmQxxViAQDnOdCBCwWDKoVMocCYpxDaF3Vam1CUG6qbfr2t/6v/Rzo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6240.namprd10.prod.outlook.com (2603:10b6:930:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:38:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 12:38:59 +0000
Message-ID: <629eaabc-0a30-44e6-aeda-60dbbbe1a637@oracle.com>
Date: Tue, 6 Aug 2024 13:38:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: convert test_cgroup_storage
 to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-2-14cbc51b6947@bootlin.com>
 <295cb8d1-89cc-4528-b255-f7d815f20a24@oracle.com>
 <40683bcd-14df-40b6-9110-ce5c61e543af@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <40683bcd-14df-40b6-9110-ce5c61e543af@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::27) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b81aee0-3357-400d-6897-08dcb614beb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TThaRDVtYkNWaTUrYzRUNUF6bVB4R1hSOVh5M1pZYXBHalB4NS9qV29JeFZ5?=
 =?utf-8?B?SmUzNS9KeUVGZGlhRmJ5NS9mNndJODIwU1RvdWtodWtURzE1QVhmc3dYczNZ?=
 =?utf-8?B?aWlJZkVpd0FEbFdrTEJuTlJPNms2dmIvbDl5bW4zdGxwTGF6dEpMQWN6WWdY?=
 =?utf-8?B?T245TW5mOGFmNDFMTzVaTXBHOTV1N3l5dmJVNFpVY3ZPaTk5NGlWM09IY1Bz?=
 =?utf-8?B?Ty83REVVd3dEcnhHUE0rMjI3UHpCUmpTZHZKUGIxQTU3R0pQRjZ0WElIYVp5?=
 =?utf-8?B?U2VmNmh6a3RObGpjZ3Q2MXpxcUM1QVFGdHlCS2NDSnJsa2VKOEJ6cGYycFlR?=
 =?utf-8?B?ZDRBMXlHbExXcVN6RXZPZHp5Q2dLVVhib0pRV2tvMzR3Znc4OTl4MEQ0UkEz?=
 =?utf-8?B?L2h1V2xrRnhVc2RaRU5rWHlWU2RhbVBWVUk3amRNTmx0S2RIR3E3MWMzbjVs?=
 =?utf-8?B?cjFpVG9TdldQbWppRTl1dWtxUitaWG5PSHV2RThRQVdBc2FhZklpM2xnaTQw?=
 =?utf-8?B?aDVXRUM5eTU4cHV5V0lKbUo0RGhhRlh6NlErUkROWXJiTENXY3VHOXcvWjNR?=
 =?utf-8?B?THpkbHd1NzMyRVVhZHU5c1hmUnEyNlhoMm40MGFKRDg2TmJWMW5MMnJqMFVV?=
 =?utf-8?B?MERka1RhVTFlOGczYlhNU2NMT3h4UC96WnN5a3RvV3E0YTB4UUpwNjBsUlhX?=
 =?utf-8?B?SU9MZkhHWmx1ckJQWUhOQmZNK3dlYkRnY0dIelFhRHdvaXFVM0JFaFVscGdN?=
 =?utf-8?B?aDJKQmF4bjVYR3Z2Zlp2Q3hta0J3Ni9FbEhUMVNEWlNzQUp5NFVXQ1dCZWJE?=
 =?utf-8?B?czB1am5oMXRZOFhCSzRiNDc1S2FnSGdrNndmM1FXaTh0N1QrYzVJSDVpSThq?=
 =?utf-8?B?VUoxcVZURDZrVTFrVU1HUnRRRm5pWmUycnhZemVLWUh6Z3JJSVFxYzFJSnc3?=
 =?utf-8?B?QlgwcFZqOXBTdUpCTWpjU1p1VWgvKzA0eG5GS0krZU1IZ01Qb01kQTJGZjRa?=
 =?utf-8?B?dEhtKzJHRWpsa3FGZkRHeDJicTM5Qmk5R0ZCd05IMWcxUFpVaFk5SkV5OGtm?=
 =?utf-8?B?ZXVVdEEzUGZTdURoQnVOVHIvN2toOHRlTXBlNmp3T2IwRHZ6ejlJMm5RZ2c5?=
 =?utf-8?B?ME9yM2lOTytLZ3FFeW0zQWJUMW55SHJrTTRHaDJkMjZqMXFNb2ZyTmVzT0Yy?=
 =?utf-8?B?Z1VlSVkvVGUvY3B2UVlhdnFtRGRUcGFSQjVHdDFoYkhTWm5Na2ZSaGNSN2wx?=
 =?utf-8?B?a0h5MjJrdU5pUW9LSklzaXlJaTFnQkt4K2cwYzNDZnJaSlFuV3Jpa1BVeFBV?=
 =?utf-8?B?NEwycm5jUStPdThjNzV6K01xaEFmV0x5eWpPeGFGd0k3QmpOaytnNzhiaCtj?=
 =?utf-8?B?NnRmc0d5MFVLTFROZzc0T2ZXY1pFam5sRXF0cDczamEveWo0TjZyU0RDUWF4?=
 =?utf-8?B?V0ZDbnpQeFhJYlNjaFF5TVU3RWZnd1hWamNoVU1aRWh4ZVdwalJJdEtxL0oz?=
 =?utf-8?B?T0dBVFNpK1RyRWIxbnJ0Q1pONVB1d1hnc0pSR0JNMGtFeXROc0l3NW4zRGxq?=
 =?utf-8?B?QVl3ckJtQStnRUtvUklPei90ZC9ob0lwdnRpbWhBSW5XMUxoNDNvdTdtVDZj?=
 =?utf-8?B?VzBTMDljd3N4bVNhenMvSUFQTWt4VGpJWUpyd1JqZWUySkJQRE5kMXJtei9p?=
 =?utf-8?B?eG5FREszVzAzMzdWWFJ4MWJqVzc0UUJuUjdrZ3lONitQaFNaN0pTcFQvMkMr?=
 =?utf-8?B?YlIvdEpYSndwREJFYjhkWkxzbVY5bGNrWWNNNlMzV3NpSUU5VkZtc1hiVFBO?=
 =?utf-8?B?WTlYWHhZK0VGM1hmd0FuMEgxRGh6VG5kNHNUQ3lsUCsxL0Y2enRwOVFMTUR5?=
 =?utf-8?Q?3Y9Z+qpoX7wvd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ovaTJNbStIRFY4dm5odmVENTByZXcrRkFOZkp3WGJaNml2V0k2TUl3ZnUy?=
 =?utf-8?B?UzlmWUJNak9GeWpWQ25EcXMvNFZVdkhqTWZ1dkNpWTQ1K2IwWnJidmhQWVZ3?=
 =?utf-8?B?ek5FVGE4Zjk3VG03MVcySkxnZ0V5Q1p1TnorRVJGWDNQV3Nvb1Z0VHZacGJ4?=
 =?utf-8?B?RDZtRlJOdmkycWlNYzNlb1g5U3ROa3M4MTdLUDN4T2l0aDR3Qk51Ny9oZ3ZU?=
 =?utf-8?B?SWVoSll0dzNVZXRxcG9kNEZtNWI4aGliVVVFYURxM3BHTlF6eVFVdUNKRkc3?=
 =?utf-8?B?ZmlKcWRvblFPOXpFbHh0aGMycko5ZEkyNVBiRnhoSWo1VVhrc1BwYnVEZ09Q?=
 =?utf-8?B?dVNyTXZubzA4NzFtTHAxZk1uQjgybEhwRUtYY1ZkOHlLZGc5TWtiS0pOM3lS?=
 =?utf-8?B?N2FHUXFTeWlvNkk5d2l2UGZhS1BNT0NMN1A0Nmh0dmZnOFVxeko0cEtDODgr?=
 =?utf-8?B?SjNSaVhVOFZscmoyYUhUY3N5c2ZxaEVyN0R5eDdia25zNm5Ndk13a2loaklY?=
 =?utf-8?B?eEErUERENVdsQXJiNlA5NVl5K3RSbERoSCswbElwQTNuMzVWTm5sSEZtU1J3?=
 =?utf-8?B?SVU5cXFrc2d0MWRVaFBJdzBLQzFkOUpaSVdXbHFQQlg3aE8xSURJMldPbHJy?=
 =?utf-8?B?MFBBQmtHcE92R05DQlJicVVaVmxYbGdjWFBTczBmMWpLZVhXaDVyREJLMm0r?=
 =?utf-8?B?SDB3eTBwUW95QXV6U3RpQUt5Vnl3eFR5TnBQTDBOZExvbGtUSHpQZVFOOVJX?=
 =?utf-8?B?YmlJVnVQR0ljKzBPQVdvNk9oRFR1Q0pVa05pdWVEZ1ZjOTJKK0xQZlZuTnZY?=
 =?utf-8?B?b2xCRjZaUlFXUlZ3ZHYvYkF2TlhKdVNQZW1kaENLd1VrTUhSVDhYL1hxNERq?=
 =?utf-8?B?czFkTW10eEhudE02U2lQZkxIRkc1cVRsaHM0clIvdHNaeGNVenZjR3MxdUlF?=
 =?utf-8?B?N240a1BEb0l0L0FkUGVuT09EdDFmZFRvTHpxbkg0VlUvWFBjRVdPRndSajNP?=
 =?utf-8?B?ZVU3eTVDQk1aQXNmNmZmSTlheFhnVTdDQWw1d0JOKytyMHQwQVppdmx3dmFJ?=
 =?utf-8?B?Q1c5dTUyWjd2UWdHQjhZYzgvdmFqR3Mwcks4ZjVxRXJ3aGFGa0JnMU9vcDF1?=
 =?utf-8?B?TERkdUNSVzhCZStkaEJ2dkRiVkg4UTNBeFc2SWh2MEI5TDdvdHFKenNJb2dW?=
 =?utf-8?B?U3lUNS91OHpZRzVMdzFUZGdTZDJnVTF2OHEzTTZ2NTFUeWQrdVhsaDcybGll?=
 =?utf-8?B?Z0FTVTBXNHplU3lRdi9La2xzaFFmbjZlRFNWajgyKzVmZ3N2UGlJN2JlcEpm?=
 =?utf-8?B?eFdlcnN1TzNYWWdPNHA3Wlp5d3JhalZBSTdSRXo3MGEzTHBoUnBVaGs5VW5i?=
 =?utf-8?B?Y2FIMlNVS083TU1TcFZQSjVjd2VLM2tEN0Z5bGs1SDZybmE1ZzBFS2dma0dQ?=
 =?utf-8?B?aS9wTVlldVNRdmlSY1I4M2t6SlM0Q0FvMGhscm53ZGJPejBuTi8vcGpMek1N?=
 =?utf-8?B?MThNbnlWdVdoRGMvVjVEY25PQ2l4Qlc5MWdMNUhNU0s1Q1pOYTlUWWJteFpO?=
 =?utf-8?B?RWsxazVWZmR2SlI0enZxK0xJR2RnbVhwdHExV0oxS2tJZmtMMUc5T0ZKWGdH?=
 =?utf-8?B?QkgxaHJwT1JvMG9yRTRnMmJkcnhOYkRCRS9oOGVjZWVMZ213L3JRMTF6L3A5?=
 =?utf-8?B?QmdwWkt2SVNKNkFLcFhQVzc4M3JQQnVKbk5qMndPc1QwV0JTWnRxUU9mTkhT?=
 =?utf-8?B?UUJYWGFxaHBXK0w4SW9SU2NmVFlhdHVGOGhTWXBKNW1tL05udkt3WStpbVht?=
 =?utf-8?B?c1VTRklLQXZrRGNRSmlORFo5d3hOVGhwc3g4dDZVUGR5bm5uS0xacEFmODJR?=
 =?utf-8?B?QUorUG5RWjk5TVptb2k3SWpaOWM0dzBTaWdGSUFNeHc2QXM3R3RQVDNldlVX?=
 =?utf-8?B?bVZmb1V1b3RibktoZVhQNGhMc3lEWlNDZjZSMmFISHZ0V3NEMXBYaHQyQTFK?=
 =?utf-8?B?bEw0Y1BKMURKYnVJWmVXbXppOGpPMUZCUHZWUlBGaHROQzZkaFh4SmJrVjhv?=
 =?utf-8?B?K0JnSC8rTEd1SkxoMXExUVJtc1NWaFVpalVqV1M5TlhxdWVoUFpmdmxCNDJL?=
 =?utf-8?B?VmlYSVl4dEU3eTZpbHhZWGZjUDJVb3VnT25kNVU2YStNaXBlWTcyL2tQWHBN?=
 =?utf-8?Q?5D3gfQcVIF2P0xWjP+Pu8+s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FiK4sLXdltRZPilDe+UYNAQtqkyb4cLcNKABzkwH0pdinKhfqTzlExssx/U6rO2e/AWIlvKAnEryR5vfvDIEGFt058/0S4OZHdX3WefyCIfW//AKIzMqLuq4NXONlcRPehQ9S351WdieGicxrnSSJ/O+Aa2MQGsVPc+M5NyhVrxhEpMwfQhfPCrG790TaXA04T/WJ3fGeZezEQSp4ZA4Uqjb4h8b5ExleF83aiyLUbBw7S5+VEpzHPLHv92+g/f5BfOSm03F3S6BfydPs0Fo6NnjzhS3hRk/oW+47WUNnyzGSodXYrRQDoAntiCyjBX7ld5wnSoWxpd1ir74Umv7t9LbHI7y7JWAR3ScTxt8TlZVnJFLFmbGMpKtKWqFRKgfGWSEtUcFKNtpAQ/EHatlAxirdj6HC5rYMk+L2DMkOz0HYgZl9WK1hCainANhSwUTD7cdgMZzIR8VWt5SNN9C9i4BEUQ01an2MwfmT8eufadJ8zcFsagRCUsQA9PQspYcQH2pCVX20etsCtVMtKmVE7JsMepeiV6JB1lB9bs27I06eWxAGcjSAg2Cw5ssoIHISrhrV7+H73IYQ7QvriStnu3ykJChR78Oey1zqAZPteA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b81aee0-3357-400d-6897-08dcb614beb2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:38:59.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRO2kBtUWjoKnpaw2yvJitAimKZPNNqypVoszu9+14/fitD0of6swMj5aWWsRwGOfJm39BiKEMCYMaz5K/QldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_10,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060089
X-Proofpoint-GUID: 9mTTWeNPeo9uGdUosZG6Kmb3JTgNFh-q
X-Proofpoint-ORIG-GUID: 9mTTWeNPeo9uGdUosZG6Kmb3JTgNFh-q

On 01/08/2024 10:21, Alexis Lothoré wrote:
> On 8/1/24 10:27, Alan Maguire wrote:
>> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
>>> test_cgroup_storage is currently a standalone program which is not run
>>> when executing test_progs.
>>>
>>> Convert it to the test_progs framework so it can be automatically executed
>>> in CI. The conversion led to the following changes:
>>> - converted the raw bpf program in the userspace test file into a dedicated
>>>   test program in progs/ dir
>>> - reduced the scope of cgroup_storage test: the content from this test
>>>   overlaps with some other tests already present in test_progs, most
>>>   notably netcnt and cgroup_storage_multi*. Those tests already check
>>>   extensively local storage, per-cpu local storage, cgroups interaction,
>>>   etc. So the new test only keep the part testing that the program return
>>>   code (based on map content) properly leads to packet being passed or
>>>   dropped.
>>>
>>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>
>> Two small things below, but
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]
> 
>>> +#define PING_CMD "ping localhost -c 1 -W 1 -q"
>>
>> other tests seem to redirect ping stdout output to /dev/null ; might be
>> worth doing that too.
> 
> That's in fact performed automatically by SYS_NOFAIL :)
> > #define SYS_NOFAIL(fmt, ...)						\
> 	({								\
> 		char cmd[1024];						\
> 		int n;							\
> 		n = snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
> 		if (n < sizeof(cmd) && sizeof(cmd) - n >= sizeof(ALL_TO_DEV_NULL)) \
> 			strcat(cmd, ALL_TO_DEV_NULL);			\
> 		system(cmd);						\
> 	})
> 
> [...]
> 

Perfect, I missed that.

>>> +{
>>> +	__u64 *counter;
>>> +
>>> +	counter = bpf_get_local_storage(&cgroup_storage, 0);
>>
>> don't we need a NULL check for counter here? Or does the verifier know
>> bpf_get_local_storage never fails?
> 
> Good question. Since the verifier accepted the prog during my tests, I indeed
> assume that the returned pointer is always valid. Amongst all calls to this
> function in progs involved in selftests, I found only one performing a check
> before using the value (lsm_cgroup.c). So I guess it is fine ?
> 

Looks like the prototype for the helper specifies a return type of
RET_PTR_TO_MAP_VALUE ; if it was RET_PTR_TO_MAP_VALUE_OR_NULL we'd need
the NULL check, but because it's a guaranteed map ptr we are good here
without a NULL check.

Thanks!

Alan

