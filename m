Return-Path: <linux-kselftest+bounces-36101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654CAEDF95
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2D5189737A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629727057B;
	Mon, 30 Jun 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r9GzfkGw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AxVL4P2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38139ACF;
	Mon, 30 Jun 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291510; cv=fail; b=p6/3xiF80KGZ1Y1bUMQv+uMdqFKv7W6mYfpf3Qmeu3UtkUjecl5qcRFyIpfhG+roNm+Oay/63moUDAyvSR+pj5kauafBKN72Jl5xFG9NnQDuBZ0ofL0EfAU6y2tNh6Zye8dwLeZxE4c1/G4MIjZ6Vt43VEh00ktSzwrnDu8zDog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291510; c=relaxed/simple;
	bh=90vpj+7s+lzLPJH86xNXQRLos68Cc4e3vhIHlY5NnTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HKGGSQ27igGDywfQINPC3b6LWWlVpBm7mnShLNMp1P4yAJmNIicblJ2YW1tuSW8fsCyaSsYAGy4NvKQAYGNuJOddh9co6K34gEVGl/4+AtGG43GeJkCFp4sS8oRRv/iuOv1KyZCV3Se3O+H+AWZz19ZVQwQKSVeZacXqQqI2GKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r9GzfkGw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AxVL4P2o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDfh3w011052;
	Mon, 30 Jun 2025 13:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ViWq4XDC+Ov7lKd6rd
	jLZ5NaNrlAIdKurLgHt5aIxKA=; b=r9GzfkGwjSzDAmHI5jRC+cGvRm7z0WWvlg
	+g2e1eXUfKYqioPyKupVhJgiPIzfgbF3bBqXzd8EpVoVPOxBhSBg96RAt17qp6Y6
	tBRqMaAM6tv8u0fscge5PL9jdy3KcgnOldfr5b2ruoGq3eiaWkXw+p0EtW/Oeo4C
	E5NEkH1d4Vhh24hOhT3swjU5eRDG7Q1uc5uCoZ68q+4z2nc67n1k9/gRoMdUjp+n
	FxBIRqozfi+/sZRI2HN3FZBVZXGl4aq2pqJwy4Qo9o3rYc92KPyX4LPY4QuzM4W9
	Kq0vu9PGXgTRu06hhKyqohnQwI/6l+TKVFA1DUGcwkcosMEMYzuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af2j7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 13:51:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCE8T6009035;
	Mon, 30 Jun 2025 13:51:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8ceef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 13:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC4suoUI/yaqvaBoY9xFUqSP7O7kMKowhk+8CaLlhm3oYgCgSOqqn27mwfX+O8B70lA00W6ncPf6XYatV17JyHPhWT/g6M1Rts4oMEERb0Ophxd1wpZU+4SNVbq4/ODQawhrbtb1/LjA2mr9af9pMMd193BqRXy8Re+venKQEA7q8+o9S6zakHZ1R5VoLWr/8mPTcvWPUvZKNnoqL5Q09ztA9I32k6GiIjbe/c9dRW/aGnI37+hEN5E/19VUxOYfTxcAExUMf5eXFjiQvLx9c8GRRKN0qftI5tAxuYmDGA4UWutLR8vy0MOX2tYdYmE4PIC47AzdPeDiRZO6czonqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViWq4XDC+Ov7lKd6rdjLZ5NaNrlAIdKurLgHt5aIxKA=;
 b=GYCIX6ITu0ItmeYgCZecr9doL2IfwZ5XaPEtqUhOGHBUhVS2uCG1HdS0bm+XtXHTuXMRrKLwnY9wvKvfHSkQCFikoPxvY6nnTvxOoIGIjezhIJ+uwp4AFDqxpXohv0avDzLNl1JsJz3QRKdrpOo5M8xxmyQi/jLxw6HbC9eBbcKBehWkU7Rs5fKhj0zm4j3ZgiEGeyTR8/eBuwx9ovFJPumKufCkVcNOuS0x2WsjHCD5dZ73gcLvcDSIa1uaHLo6bDJxlWNknPwVpDuNr4N3AwPc61RcsxqYLghLoecxxE1FOa6GGu4u10tqDSKohr6btxXAxe0ywj9V8Oe6Giy1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViWq4XDC+Ov7lKd6rdjLZ5NaNrlAIdKurLgHt5aIxKA=;
 b=AxVL4P2o7F6hD5I6Lq5U6QUF1/s1uic8p2oSeRCEF02RRssQG6wIAdf9+K+BPOxuKhGhLU5zakoiSd3fCQqbVaaHFIeN7H+gH7OSCymLUJsImqHuKn4bUTwX0DniAIiIiwyE9OCvo9X3p/zAybeXcqhrFTf7lnDGrOhPlBKGqtc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 13:51:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 13:51:07 +0000
Date: Mon, 30 Jun 2025 14:51:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: david@redhat.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
        jannh@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, p1ucky0923@gmail.com,
        ryncsn@gmail.com, shuah@kernel.org, sj@kernel.org, vbabka@suse.cz,
        zijing.zhang@proton.me
Subject: Re: [PATCH] selftests/mm: Add process_madvise() tests
Message-ID: <694fca1d-1584-45d9-9e50-5c219b9c7c94@lucifer.local>
References: <20250624104654.4418-1-lianux.mm@gmail.com>
 <20250628113945.145588-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628113945.145588-1-lianux.mm@gmail.com>
X-ClientProxiedBy: LO4P123CA0593.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0559f9-ed85-4097-cc68-08ddb7dd2977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30ngVUBOO9L4f4TBtQpOMfjR5Gsb2kKJMUlw5Zq5dXFRtVgyra/QABf2uluL?=
 =?us-ascii?Q?1psoJQ9iLdi6TZmMpda1rGJV/vdadb4xRfyZ7OQskDw+GnFCda7vuNiXmt78?=
 =?us-ascii?Q?b27tWpM31AWjfggfd1s1AlPjFp6OpA+gdP81f7yJCYXz3YjI7HrWmquP2Dme?=
 =?us-ascii?Q?d2zh0wuQCxMyLgMoEhZxiqJVkJYCz30fWI3ru+fmWePn7uTMcNTP8kN3QMEP?=
 =?us-ascii?Q?zPQZcwLAN2Zo8lkJq3vZrpspThGUD+c0i3Yn3dR494aKLmBGzCZx8NO2HhOz?=
 =?us-ascii?Q?Ypj64pSeKxCCS+6aJfIkx3/ZxDUQg7RIijgp7iB5uV4OiU86/Q7WC38HWtzT?=
 =?us-ascii?Q?Ikj8y5aEs72h//nuLuiTHYLZIJcFN+TOVoEJ7/52MHV1nw+7uVeiANUbvXDm?=
 =?us-ascii?Q?J2qKbdxJoBRIWX9Z7gb/xj3pbuf0sw82LPNCnC6XlU77teTntIZhD5VLqJYt?=
 =?us-ascii?Q?J3t9JS0L8ZZoBDbCm68Nz5H7vuSnVKmsuzIL7B+KHkX97GB3H4a3QSoxmtOI?=
 =?us-ascii?Q?mypST4BuNAk50a2SWgxfMY2ru7+40gk8XTckQGI5WsZEEIp3pnPsCAFTL2yU?=
 =?us-ascii?Q?BAg98k6Ei/lriCcjgVIPoSdkhzWi/NEb0xiDVBYizJXhNLopLcnih1BRfjzK?=
 =?us-ascii?Q?tm+rdItXRFlltfndaPRQlVVK0i0TxiCc9zdfiF6OH+urqr3dW1J/Ts5m/65Y?=
 =?us-ascii?Q?w9VHBU8ynjXlEV/Jf+EwyJ9wGwVFtxmnIdeULL613HC8aeAtfdvMSBrEU7Kn?=
 =?us-ascii?Q?hZ/v5snqvZdiG6uQKTqh3Y9jEpKP+833L5K+w8S3W+DdW7zLGiO1AOIjHgXe?=
 =?us-ascii?Q?HEQYLxah3Ro1KUsqVwUZAUdMiw2vbGf5xvhTnymMnQ/LhYVzvsseR/2GvBNb?=
 =?us-ascii?Q?LsAfKQ6MBj72Vxv/37pV7IlawgEOdI/yCNDFewFc+vEFzEqiN3I2fsdC2qNv?=
 =?us-ascii?Q?yHklOWDsTgYQCOl/OKUsvKQnkx9a1VHWKXlxL3g/fIZDSlUoSUiaNGeQdN7+?=
 =?us-ascii?Q?bMkOJ68qxuV4b6b42UhDYnvQ9Vu8SjTLf51DxNd+NwLoxVcqmqvRBF0LGoty?=
 =?us-ascii?Q?0AQipOIS1e3j4N5sCX+iv8LBE8ZoymRO/dm/ZMc/8ywpY79CofBqFm0kU2uR?=
 =?us-ascii?Q?dDKTl+l6JbeCgoVKniKU1qGWG0kUg6kRq3buoX2R2RkRF5+52cjsTSLsoIfV?=
 =?us-ascii?Q?vAh1psIJEsxG2+w+LwcEZGfUYyLME+X/AMPY4Y59jklJy4S4IDjkkJubfT37?=
 =?us-ascii?Q?9p1ITK2vHByvTx2jEQCPT2oO/BgrlgKj8CM+5gvbWhrxkZZ20YG9LFZlm2d8?=
 =?us-ascii?Q?MUbb1KDh0Q1ZZk2/WTM2fJYaJZpxbYanYk9hn0Z7Q61fRL4xKMiGG+7QMdpy?=
 =?us-ascii?Q?YGAT27/AQnCh2JXR5g31bWKtehOfnGQyMFY1FTUwNYsPp4Z24e3cyElr2yIL?=
 =?us-ascii?Q?QfFRgrHD8YE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84MgMC0oEb+AlxO6bk6eSsBibzcfamBpmcPUOxwMczdQpDej0ZewE34D7AT9?=
 =?us-ascii?Q?lQMA0xiZt0mt8B1aBAAK18x0aX4fbsWbsS0BohZpSkxOnSWKjP6G7wALJ+AI?=
 =?us-ascii?Q?sZabr8uLU7AFhLnfayIwwq5e2BQHH5cpVLn9W1BG94EYQNwHbDIyR542uMdT?=
 =?us-ascii?Q?04Yp+3zfQJqMPtczFLxal6u3Cwyentte79tRnHLSKi5YNTDH9N6MIdOAz5wa?=
 =?us-ascii?Q?8g0lItW3QC5aDf/bhnAwRzVz1iTYf8cdvAOmmhWyDebhrhB+9uITk9JtLKAk?=
 =?us-ascii?Q?g0z/T9J0zwmQ6gWbOGKpYFvdAdGQ3ddOM0xaAJF7tlLGV9zDM351FD09RV2m?=
 =?us-ascii?Q?mi1qs4UhxD91HK0ImrdYWfpBRBbKRSyyH7H0NoFJ80kev2OGgFbHYM5LX+ix?=
 =?us-ascii?Q?N0vQUff7Kr1uWZHBZwMwvOJqJ1psBqYGnoHqwL3NvzQHhQd1hpSq1tm6sWzQ?=
 =?us-ascii?Q?qZ/DaNAC/uoUTdsLhH0bVZrIykdVbhnXrZmM7H/bL371yVu266kfFV5jLRKS?=
 =?us-ascii?Q?hdn02ItSR4Lq5uFDmAq/CpDTPBOZWA+AruQwjKrBH8piRZK1xctXkPy1A4BI?=
 =?us-ascii?Q?CLNcFeF/noZIIkyJ6chBme1INwMXU+6rfd6Oly6YksZFneHFfllDTgu6c1/V?=
 =?us-ascii?Q?91jen3hdzuJfaEIsw6MsLtylFaV+JaIKeq0lxFOs+RejaMoXbxCJYYWHHjCj?=
 =?us-ascii?Q?V3qb8DwHRDAXPnJsZdyQUtY88JJLEI13abwA68lchSxmqIOamDdHmdQYfh/Q?=
 =?us-ascii?Q?Ke2zz83OW9gRViLKiXwLNV1ZAkppfNwp17Ar2wrUhjKFvqzAGmAGNCf+04fE?=
 =?us-ascii?Q?aoLFrofI5NmfshnWd/b/j73pyNqh7vk0T9JBK5kwvoKFIzfOLcIEu/z682hr?=
 =?us-ascii?Q?lg86SDskqM+zVjc/CZCIKvNYiD07n9JsDbnMZ/VmzQTxy/WwSCInbwMh0r0N?=
 =?us-ascii?Q?G+GaSTeNqk/x4tUbr5ENbA9ktHt0pqcNKbWJq3yqx7r7ZNKPl/aCwWavKqPs?=
 =?us-ascii?Q?rjzYnXstBOHkljf+mbdAWES/RnJTdfmMUHaXW42NgB6nkY/bdM8Fo9bvHG7X?=
 =?us-ascii?Q?dGuF0W3EEHDTpiogzlhYOVAK55Kw9gapk2gDkWfTuvj27kRHT3vOVFPeE+QL?=
 =?us-ascii?Q?VCeDfDTx2BZOqOK2D8KOC9Cymm1aT9PMK7zs4Ub1ydOtAWZt6Zm2PnNVnzeL?=
 =?us-ascii?Q?F5M6FEBU9hVN9VgLfamCLX27AuM/3UCdqJ1F8yHjzJ3bqqFsEddZl83VbRWx?=
 =?us-ascii?Q?nz8ATm5TxmZayMfPEYGTN1J1IJjLzwjoDmobakI315FPTJXc6eDXPx4wUQNA?=
 =?us-ascii?Q?EZA836SqUG91vmNMYpt++rIYz1Udbo/QtsxHiroJTJjUHykaVtdPsEK1VjeC?=
 =?us-ascii?Q?ct2bnoT1tqOOHGeQwprMjdnWe+vbd25Fuzw8Bjb0NPBkPgmXQfB+0BVYUSQ2?=
 =?us-ascii?Q?7+OXvxrXrfkrnyIxZOzov4x8e3zpKQHe3ZaM5NcXh1OftPIR69UT2bsn9Y5g?=
 =?us-ascii?Q?CDZ+8VWcggvQZeosgVMHjrjSb8gOggLPOMYsFKRQr17bZE+HXAuNcj+jGnQ/?=
 =?us-ascii?Q?SAJ8VsVXyR4iRXfXm3D1i8sqmG1VbvJwy0OQu5dSNJwuHiDYeNL46APO8QVp?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eAYJWOkbAVetZv3TbMCxOTkzEyEUPbEOLdNqSu4L505BP7ikKuKSe5/FWvqmRnjOm+wH/l8Xo9RYdz7WBB/D5dWtVpF2zMY0NFV+cKFYU8298uWyp292zNsDP2kEw99+IQ/lYOI6roDFq93n57C1iwBVzBy3YeDFey1XopsPkqCd6Zixcm2RE6H6z87bORcvINA0LJH1YyXj+G7xaiTteyEw2jB8eiBW+GdQ/n43jBEFyuyBhRPBmf3KvAl+uGp4dB2jDFk8sDe6p1v7qXaP2fXgPTZcuerDAUACgFNxWjYF7mDi/RD1HzNd5X/OOnqqxoY0Zk0HF1q0tPc0dNC2WhkA3pV7fNwraAyO7rTIZY0VJhPkyQlo3ENnLGWCmAWbDIYocWjtOpe9Is/mIZPWsYu67OOd+KwE93WD7+f5vXklDb5QUkzPVBHty/QVlrOqjWLPA1gZiOjhnB5v6a0u2l2rDLrP+xV94fsJaQLsp0hy0GhEDesB5Yy+myVtNqV7F1p/qhFZg2WnpN8yzGj1/EfyzUaePOrcLYaEVZOXbE2PwiPJehoAxzyCwLsjsK0+a6SiqpukXmff0ZhB8ZthhNUvwBkN//BvP/5dlCdwX/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0559f9-ed85-4097-cc68-08ddb7dd2977
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:51:06.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI0bsk7G8/+zi8qMZfbD4EtKqu5ZDOO/3MLtYpEwB4T2BQO1+ErhCE95dV5MbHxVZ1lXtywyHy85SIRlg4inhcPLrkwIEeTeDLbKKUEwnCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300113
X-Proofpoint-ORIG-GUID: EmxLHj3huVSAsQqONyjQRsjzaGbvrHNz
X-Proofpoint-GUID: EmxLHj3huVSAsQqONyjQRsjzaGbvrHNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNCBTYWx0ZWRfX9xRYc6VAEX4x SgaQ9ZzMgXoFZZJkVpDl5fc7xY27Vu7r467T8Po8M05TXqoaQp8v21j/sXcFWv5wfqCgUMwk0y7 5pZlRTS59pcYjhHPMKh+m3I1KAmkNetqlTZfwXn/CtvJFQcl3DW9MS+ZrWKmZFuxhccpNxw+mzR
 caii4sp2YR/pYcQKl1qAoxusBTSg545plEwvZFB3A4zp7PAFk69GqJuxrT2K9nwNZti/88mBMOZ P3iyJ4UCnuVjVm7OEOej7YlfKV6oKj2A7mQD/gZsTRhPbIlrmxS0vmfls4IOGT2dK/8m5iOGkji 53oCEv2mAZ16HR2hzkmVxSixvVtmN3+NOgL1moPj5hRcfxOU4c0r1vrevzV42jOJyU8M539hSie
 RP4AyrHhSbyrk9h0t5i1vbCm1yxUWaUVXgn7jGBx6+gX6ngySG/iP6yQW65+cIMdA0o1GyXq
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=68629656 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=kuhvCPSaOwMGUiEJtDkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723

On Sat, Jun 28, 2025 at 07:39:45PM +0800, wang lian wrote:
> This patch adds tests for the process_madvise(), focusing on
> verifying behavior under various conditions including valid
> usage and error cases.

Hi sorry to be a pain, but I'm not sure this will get picked up properly like this.

Please resend this _not in reply to anything_ and with the subject:

[PATCH v2] selftests/mm: add process_madvise() tests

Note we do not capitalise the first letter in the subject line.

>
> Changelog v2:
> - Drop MADV_DONTNEED tests based on feedback
> - Focus solely on process_madvise() syscall
> - Improve error handling and structure
> - Add future-proof flag test
> - Style and comment cleanups
>

^ This is good but please put changelogs under the --- below, otherwise they end
up as part of the commit msg which isn't appropriate.

Once you do that we can review in reply to the new email.

Thanks!

> Signed-off-by: wang lian<lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/.gitignore     |   1 +
>  tools/testing/selftests/mm/Makefile       |   1 +
>  tools/testing/selftests/mm/process_madv.c | 414 ++++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh |   5 +
>  4 files changed, 421 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/process_madv.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 911f39d634be..a8c3be02188c 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -42,6 +42,7 @@ memfd_secret
>  hugetlb_dio
>  pkey_sighandler_tests_32
>  pkey_sighandler_tests_64
> +process_madv
>  soft-dirty
>  split_huge_page_test
>  ksm_tests
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 2352252f3914..725612e09582 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -86,6 +86,7 @@ TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
>  TEST_GEN_FILES += pfnmap
> +TEST_GEN_FILES += process_madv
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
> new file mode 100644
> index 000000000000..73999c8e3570
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <errno.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/pidfd.h>
> +#include "vm_util.h"
> +
> +#include "../pidfd/pidfd.h"
> +
> +/*
> + * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> + *
> + * "If the signal occurs other than as the result of calling the abort or raise
> + *  function, the behavior is undefined if the signal handler refers to any
> + *  object with static storage duration other than by assigning a value to an
> + *  object declared as volatile sig_atomic_t"
> + */
> +static volatile sig_atomic_t signal_jump_set;
> +static sigjmp_buf signal_jmp_buf;
> +
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to do
> + * anything with it in order to trigger a read page fault. We therefore must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +
> +static void handle_fatal(int c)
> +{
> +	if (!signal_jump_set)
> +		return;
> +
> +	siglongjmp(signal_jmp_buf, c);
> +}
> +
> +FIXTURE(process_madvise)
> +{
> +	int pidfd;
> +	int flag;
> +};
> +
> +static void setup_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = &handle_fatal,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction");
> +}
> +
> +static void teardown_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = SIG_DFL,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	sigaction(SIGSEGV, &act, NULL);
> +}
> +
> +FIXTURE_SETUP(process_madvise)
> +{
> +	self->pidfd = PIDFD_SELF;
> +	self->flag = 0;
> +	setup_sighandler();
> +};
> +
> +FIXTURE_TEARDOWN_PARENT(process_madvise)
> +{
> +	teardown_sighandler();
> +}
> +
> +static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
> +				   size_t vlen, int advice, unsigned int flags)
> +{
> +	return syscall(__NR_process_madvise, pidfd, iovec, vlen, advice, flags);
> +}
> +
> +/*
> + * Enable our signal catcher and try to read/write the specified buffer. The
> + * return value indicates whether the read/write succeeds without a fatal
> + * signal.
> + */
> +static bool try_access_buf(char *ptr, bool write)
> +{
> +	bool failed;
> +
> +	/* Tell signal handler to jump back here on fatal signal. */
> +	signal_jump_set = true;
> +	/* If a fatal signal arose, we will jump back here and failed is set. */
> +	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
> +
> +	if (!failed) {
> +		if (write)
> +			*ptr = 'x';
> +		else
> +			FORCE_READ(ptr);
> +	}
> +
> +	signal_jump_set = false;
> +	return !failed;
> +}
> +
> +/* Try and read from a buffer, return true if no fatal signal. */
> +static bool try_read_buf(char *ptr)
> +{
> +	return try_access_buf(ptr, false);
> +}
> +
> +TEST_F(process_madvise, basic)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	const int madvise_pages = 4;
> +	char *map;
> +	ssize_t ret;
> +	struct iovec vec[madvise_pages];
> +
> +	/*
> +	 * Create a single large mapping. We will pick pages from this
> +	 * mapping to advise on. This ensures we test non-contiguous iovecs.
> +	 */
> +	map = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	ASSERT_NE(map, MAP_FAILED);
> +
> +	/* Fill the entire region with a known pattern. */
> +	memset(map, 'A', pagesize * 10);
> +
> +	/*
> +	 * Setup the iovec to point to 4 non-contiguous pages
> +	 * within the mapping.
> +	 */
> +	vec[0].iov_base = &map[0 * pagesize];
> +	vec[0].iov_len = pagesize;
> +	vec[1].iov_base = &map[3 * pagesize];
> +	vec[1].iov_len = pagesize;
> +	vec[2].iov_base = &map[5 * pagesize];
> +	vec[2].iov_len = pagesize;
> +	vec[3].iov_base = &map[8 * pagesize];
> +	vec[3].iov_len = pagesize;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, vec, madvise_pages, MADV_DONTNEED,
> +				  0);
> +	if (ret == -1 && errno == EPERM)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or permission denied, try running as root.\n");
> +	else if (errno == EINVAL)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or parameter invalid, please check arguments.\n");
> +
> +	/* The call should succeed and report the total bytes processed. */
> +	ASSERT_EQ(ret, madvise_pages * pagesize);
> +
> +	/* Check that advised pages are now zero. */
> +	for (int i = 0; i < madvise_pages; i++) {
> +		char *advised_page = (char *)vec[i].iov_base;
> +
> +		/* Access should be successful (kernel provides a new page). */
> +		ASSERT_TRUE(try_read_buf(advised_page));
> +		/* Content must be 0, not 'A'. */
> +		ASSERT_EQ(*advised_page, 0);
> +	}
> +
> +	/* Check that an un-advised page in between is still 'A'. */
> +	char *unadvised_page = &map[1 * pagesize];
> +
> +	ASSERT_TRUE(try_read_buf(unadvised_page));
> +	ASSERT_EQ(*unadvised_page, 'A');
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize * 10), 0);
> +}
> +
> +static long get_smaps_anon_huge_pages(pid_t pid, void *addr)
> +{
> +	char smaps_path[64];
> +	char *line = NULL;
> +	unsigned long start, end;
> +	long anon_huge_kb;
> +	size_t len;
> +	FILE *f;
> +	bool in_vma;
> +
> +	in_vma = false;
> +	sprintf(smaps_path, "/proc/%d/smaps", pid);
> +	f = fopen(smaps_path, "r");
> +	if (!f)
> +		return -1;
> +
> +	while (getline(&line, &len, f) != -1) {
> +		/* Check if the line describes a VMA range */
> +		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
> +			if ((unsigned long)addr >= start &&
> +			    (unsigned long)addr < end)
> +				in_vma = true;
> +			else
> +				in_vma = false;
> +			continue;
> +		}
> +
> +		/* If we are in the correct VMA, look for the AnonHugePages field */
> +		if (in_vma &&
> +		    sscanf(line, "AnonHugePages: %ld kB", &anon_huge_kb) == 1)
> +			break;
> +	}
> +
> +	free(line);
> +	fclose(f);
> +
> +	return (anon_huge_kb > 0) ? (anon_huge_kb * 1024) : 0;
> +}
> +
> +/**
> + * TEST_F(process_madvise, remote_collapse)
> + *
> + * This test deterministically validates process_madvise() with MADV_COLLAPSE
> + * on a remote process, other advices are difficult to verify reliably.
> + *
> + * The test verifies that a memory region in a child process, initially
> + * backed by small pages, can be collapsed into a Transparent Huge Page by a
> + * request from the parent. The result is verified by parsing the child's
> + * /proc/<pid>/smaps file.
> + */
> +TEST_F(process_madvise, remote_collapse)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	pid_t child_pid;
> +	int pidfd;
> +	long huge_page_size;
> +	int pipe_info[2];
> +	ssize_t ret;
> +	struct iovec vec;
> +
> +	struct child_info {
> +		pid_t pid;
> +		void *map_addr;
> +	} info;
> +
> +	huge_page_size = default_huge_page_size();
> +	if (huge_page_size <= 0)
> +		ksft_exit_skip("Could not determine a valid huge page size.\n");
> +
> +	ASSERT_EQ(pipe(pipe_info), 0);
> +
> +	child_pid = fork();
> +	ASSERT_NE(child_pid, -1);
> +
> +	if (child_pid == 0) {
> +		char *map;
> +		size_t map_size = 2 * huge_page_size;
> +
> +		close(pipe_info[0]);
> +
> +		map = mmap(NULL, map_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +		ASSERT_NE(map, MAP_FAILED);
> +
> +		/* Fault in as small pages */
> +		for (size_t i = 0; i < map_size; i += pagesize)
> +			map[i] = 'A';
> +
> +		/* Send info and pause */
> +		info.pid = getpid();
> +		info.map_addr = map;
> +		ret = write(pipe_info[1], &info, sizeof(info));
> +		ASSERT_EQ(ret, sizeof(info));
> +		close(pipe_info[1]);
> +
> +		pause();
> +		exit(0);
> +	}
> +
> +	close(pipe_info[1]);
> +
> +	/* Receive child info */
> +	ret = read(pipe_info[0], &info, sizeof(info));
> +	if (ret <= 0) {
> +		waitpid(child_pid, NULL, 0);
> +		ksft_exit_skip("Failed to read child info from pipe.\n");
> +	}
> +	ASSERT_EQ(ret, sizeof(info));
> +	close(pipe_info[0]);
> +	child_pid = info.pid;
> +
> +	pidfd = pidfd_open(child_pid, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	/* Baseline Check from Parent's perspective */
> +	ASSERT_EQ(get_smaps_anon_huge_pages(child_pid, info.map_addr), 0);
> +
> +	vec.iov_base = info.map_addr;
> +	vec.iov_len = huge_page_size;
> +	ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
> +	if (ret == -1) {
> +		if (errno == EINVAL)
> +			ksft_exit_skip(
> +				"PROCESS_MADV_ADVISE is not supported.\n");
> +		else if (errno == EPERM)
> +			ksft_exit_skip(
> +				"No process_madvise() permissions, try running as root.\n");
> +		goto cleanup;
> +	}
> +	ASSERT_EQ(ret, huge_page_size);
> +
> +	ASSERT_EQ(get_smaps_anon_huge_pages(child_pid, info.map_addr),
> +		  huge_page_size);
> +
> +	ksft_test_result_pass(
> +		"MADV_COLLAPSE successfully verified via smaps.\n");
> +
> +cleanup:
> +	/* Cleanup */
> +	kill(child_pid, SIGKILL);
> +	waitpid(child_pid, NULL, 0);
> +	if (pidfd >= 0)
> +		close(pidfd);
> +}
> +
> +/*
> + * Test process_madvise() with various invalid pidfds to ensure correct error
> + * handling. This includes negative fds, non-pidfd fds, and pidfds for
> + * processes that no longer exist.
> + */
> +TEST_F(process_madvise, invalid_pidfd)
> +{
> +	struct iovec vec;
> +	pid_t child_pid;
> +	ssize_t ret;
> +	int pidfd;
> +
> +	vec.iov_base = (void *)0x1234;
> +	vec.iov_len = 4096;
> +
> +	/* Using an invalid fd number (-1) should fail with EBADF. */
> +	ret = sys_process_madvise(-1, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBADF);
> +
> +	/*
> +	 * Using a valid fd that is not a pidfd (e.g. stdin) should fail
> +	 * with EBADF.
> +	 */
> +	ret = sys_process_madvise(STDIN_FILENO, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBADF);
> +
> +	/*
> +	 * Using a pidfd for a process that has already exited should fail
> +	 * with ESRCH.
> +	 */
> +	child_pid = fork();
> +	ASSERT_NE(child_pid, -1);
> +
> +	if (child_pid == 0)
> +		exit(0);
> +
> +	pidfd = pidfd_open(child_pid, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	/* Wait for the child to ensure it has terminated. */
> +	waitpid(child_pid, NULL, 0);
> +
> +	ret = sys_process_madvise(pidfd, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ESRCH);
> +	close(pidfd);
> +}
> +
> +/*
> + * Test process_madvise() with an invalid flag value. Now we only support flag=0
> + * future we will use it support sync so reserve this test.
> + */
> +TEST_F(process_madvise, flag)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	unsigned int invalid_flag;
> +	struct iovec vec;
> +	char *map;
> +	ssize_t ret;
> +
> +	map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1,
> +		   0);
> +	ASSERT_NE(map, MAP_FAILED);
> +
> +	vec.iov_base = map;
> +	vec.iov_len = pagesize;
> +
> +	invalid_flag = 0x80000000;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, &vec, 1, MADV_DONTNEED,
> +				  invalid_flag);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> \ No newline at end of file
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index f96d43153fc0..5c28ebcf1ea9 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -61,6 +61,8 @@ separated by spaces:
>  	ksm tests that require >=2 NUMA nodes
>  - pkey
>  	memory protection key tests
> +- process_madvise
> +	test process_madvise
>  - soft_dirty
>  	test soft dirty page bit semantics
>  - pagemap
> @@ -424,6 +426,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
>  CATEGORY="madv_guard" run_test ./guard-regions
>
> +# PROCESS_MADVISE TEST
> +CATEGORY="process_madv" run_test ./process_madv
> +
>  # MADV_DONTNEED and PROCESS_DONTNEED tests
>  CATEGORY="madv_dontneed" run_test ./madv_dontneed
>
> --
> 2.43.0
>

