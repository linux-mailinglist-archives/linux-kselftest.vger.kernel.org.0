Return-Path: <linux-kselftest+bounces-22885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48299E5EB0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 20:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB542841DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A29F22D4C5;
	Thu,  5 Dec 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXxSPScT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2X9KtOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E367229B1F;
	Thu,  5 Dec 2024 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426401; cv=fail; b=kSwnvFMqsaDMKtRoNblGo4md6rs71mK9zzbV3dZPZVoTbUbsNEqXtkEFVkXGSeBkY9dJ8bwFvE+kSQHXAYNekIEyhqDDvrN0LKURm3DkBVwzSJt9RCSXxrRI038XfOuQ4Ms6qyPvWmzWJ9ZpCxdL2WaWLZ6wqtw5ZZqoww1Bn9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426401; c=relaxed/simple;
	bh=bvMFm1a0NwNcXkrmzi3QOuJM2xmxFpExP18wmusScLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FVukw8s0gNBw3np2oqEfQAX0pwfy3c+JL/8bcLXZGSKore03bGmJetDtxSNuggG2AEyouxh6Y6uiYEe/TyedDSEGY48fo1VNL65HUx3D8TdZyjJ2u6mQycivdyPXyspbzk+15K2yis7wicovsAlskrZZbhI0VHSZ6l7KZCk1gKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JXxSPScT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2X9KtOg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JCHns022116;
	Thu, 5 Dec 2024 19:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=HVW0fIHo3KY7Lpx0IQ
	5ntNjWIOU7ChdR0leG0TSVvL0=; b=JXxSPScTsaNM2gnv1lPRNZVxLkuY97XuVJ
	P0avLw9WlA7pkOJ8JLPpDCQ9jp/q9fMNYX0TjA9KwJUmxapnky7LOEswJHvq/YLl
	RgBiz8kLiu/B2xAIM2b2bQEqo7KyXCjm3Uy8My5S4JsbkNASBBi+VXWO3Ckr5uto
	mZlj+u6f7ga6L/6IH2nChN3kMvBbHPoXxeTHUJmRIhJtxi3iHUSjOg5X8MGNLOU/
	NDW+VA7zkDnasNTQqnBy0Ln8kG0yTI/w0EbHbrgUh2+a5/xHMzAD1WsJaK21jCoS
	TsdDiQvhE/7A7YdYHNwgbUvkW3NfK3PmMpTeKZTBgAz64hMGX7Cw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2bv1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 19:19:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5I4xcm011646;
	Thu, 5 Dec 2024 19:19:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5bb7k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 19:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buWuXAIw7WuFrZtPs6MqLEeKpMG6lrXcwhX2uZes6BGqvDJSChlYuC0Zdz/aWuxSfQyJEv9eRCxcPIwuvtNGcOG89J1jCbhskR1mLTHkHflRZzb+vFVQYovThOIUJW5O+y0r/pw2q+KbMRDMQgs0Rl0cOfiRXqvuqALaDZ+2w7f1/Qsxxz7tOTPMPge6yeiOVFhbr132EuKZsgiMY2dadYsJwVvK1AZDT/JNXJcguYuras7WLINqBM9l+1I1AVfgRd+YjB1H/9TZs2hFju2Z3+P7sDzG2ZNkfyUcSYSHpxrinpcSDuZi5Y00NNto6soszGPxfB0zL7fVK+6iyVbwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVW0fIHo3KY7Lpx0IQ5ntNjWIOU7ChdR0leG0TSVvL0=;
 b=AlUjHKSWirJ8i/QK8/ibRJq5GdulCESaEqlAo9X25XvN7+4EDeRVvFEVBlUIWPTvbjlQfE8QJWqbJq5GaDkt5XpSonvwLETSxgprQXO55R8pTgx3tMM2JvwLQdv1yDKMU4Lnv3P1vCcE9rcKXX1RVbPfmI5CMliSTNauHNavX4SR+3TxYiiPY8PTULPyBXuGx3/7GuIONKW64jP35I21wFMAgS25+BOtSrAVZhi/1noWtDqvB+TJS4D0wKaOES75qTRsY7sgWhopmRVYgTH4M/94gUJEwVlUT1ls+lGyn+TSYIVtelWoRHANIYkEKh63yMK2x/05U86eDX3sXWZk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVW0fIHo3KY7Lpx0IQ5ntNjWIOU7ChdR0leG0TSVvL0=;
 b=u2X9KtOgveh735a2V0zwD77e4vxxT4qaow7U9J3Z9muhqjUwVZRGURdztovy66tIg6Vg5AYccvs8Y2jmHt5oWrAsSmd9S2zpoR4tuyUFNdP+OH/NvZgBG7QC+hjIVSY2XkoFZPJ4e8MsSo3atZYnG8eDBRtGFqI7dqlE2EHTmJQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 19:19:44 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 19:19:44 +0000
Date: Thu, 5 Dec 2024 14:19:41 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] selftests/mm: add fork CoW guard page test
Message-ID: <qbzzv3lz62it6gitcttsxe2f2i7uq56pz6sfcbjtopatryeukn@hfy3d3l2uvoy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20241205190748.115656-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205190748.115656-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0442.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN7PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 63db5f9d-ada9-4c02-6812-08dd1561c6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXrpRnEuSJDVTqcaoN6ZPXSZ6oq9Jrx7Jyfmm/61rJFD9biRkvzAad2gPiFo?=
 =?us-ascii?Q?KNUUXCvkhOU3IJQCuDC37R9RIs8wU1SMjg10PuBZvOFcCqcBL0/Emp1INOI0?=
 =?us-ascii?Q?A3jps4WfbwZkn8rsZIECk0caAEPMvjVoWESy5aLfajoFU0ykYliAVFJS6J49?=
 =?us-ascii?Q?rjIAJ7tjSbjpga3gSbzdFgXMcdugY14gO4SLHSiuzgDoZjpSDd/ZmqIKXJyk?=
 =?us-ascii?Q?dXgzjrqwp8/5KNFH5p3Lo7rm509fEwlGQiVWd/HZO7lVV24/DmFPgqizkwNI?=
 =?us-ascii?Q?X6nXfFT/gxTPduw3Z73Fftxtms7yNmjYfYeeyJCXG8/r1nZszeH9iq270b7a?=
 =?us-ascii?Q?aXraTODKtpI0yHjZI4X9tp6xgbFQHXeYM+DCppKDv1Z3b4TGRIChj15IXdqI?=
 =?us-ascii?Q?Avve2aku1qSqA9eZTtfwCWBYCyK0rxNXKy9FY66WQBGBS6CqSChmgrZWFpNn?=
 =?us-ascii?Q?2vquKOhhr0yzpQL7YkEKzkzLA1AQvFnshizLcz2meOuUZLPzwjmbyUF+CA2M?=
 =?us-ascii?Q?AG2fi1DsipZY4lCmn63yJE/668aC39Q7yYZhbtiM3RK+8+uwoU0n2FQN1DNW?=
 =?us-ascii?Q?Iix8FpcNadm+uZkRnkZ9dHOuFENmfLmzAU512J1tiNsnuh9fDCgL9Y7nBBc4?=
 =?us-ascii?Q?0CHEa6m7hYObiiohCIvginhcmpOuiVoQ1h5Di8xC8plVRZU7UHCPbpXCI1F1?=
 =?us-ascii?Q?1Brrb6YJapTWfq21vzdQ6CZioTJst3u7q3r4Rm57J1q8Nw6UMCpd8pTI72+u?=
 =?us-ascii?Q?NmA3Op8YOE2wGtw98+xXPrk6Sx1A/9/2oE7lOqeUVdi+wpiS6fYGgHY5sM7v?=
 =?us-ascii?Q?Zmquk4WmhVMwLIa1UCkdtBdBVflCP+tTurjWVQ+O6a2MrYRbRltGqfusU5oE?=
 =?us-ascii?Q?8WhwwE5FcGlK3ou0ylSGUBDkeXcVkeCpAA41N7NK6YAsmZZ4n+GRyvAG5W10?=
 =?us-ascii?Q?kg1rl25SKFuP1PvmZQ4s2yPuD1r5ZKbPPBg50Fsf+zXqdMul7vp/cOw4zQl4?=
 =?us-ascii?Q?NmLCijfik/DC8OWp6QoMxdb59/KYJ+rRCMHhdwJKtBRachqj2CTz+wuWis/J?=
 =?us-ascii?Q?9du6/2r7D7tXnUDCFt2izQP5Afh1ysM6XpfBKIIIkFqHu4troJ5GtS1IeKZJ?=
 =?us-ascii?Q?vI1mOWURzlbQhbDjmhGCbrpsRBzFgsbW7GfKJbCzj7MNuoDZV66mYKScZort?=
 =?us-ascii?Q?DR0dSnCg0VT4AmxngmnplQ12ArgR+4K7DRywh+RlPEuStCbaG+euOrHF0kHD?=
 =?us-ascii?Q?Ad8bfIpHwoul3jFEJ/AOT+YM1UlQeZPFxr0e9LHRUAs4zH7Zw5lGfw881HbG?=
 =?us-ascii?Q?Loo2lHJVZ7ECnuokMobMB6HGPVoSAb6KJ3O2Dwzqmt2NhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?um+bVhP0GYHoLn7BAr3/xg51bXGLEeb4+zo960iS0oqY+o7cUrzI4pf7JIZB?=
 =?us-ascii?Q?yk61Qerbu3++5bxyNZsHyYWwBqmmJQVXlnLJFgE9p695bXkwom7xO8VIZROW?=
 =?us-ascii?Q?HAZLfD1K9eUvxbELLvd3eb+um+L98IvlVC5vFdQ8uFlgp/DOY+xtJ+wxUboW?=
 =?us-ascii?Q?A9NcbndyzHo0TccsrQZF/4PsCTQ2nhmpwGiwFjYJWlDFRjGjO4CsHI54nL6Q?=
 =?us-ascii?Q?IPdP6dCnuz31/GeofltRmv5E69fR5SaSb9Tg/TtKiP3Q2NlB11QJ8EBLYZZj?=
 =?us-ascii?Q?zJFXFWJ5YGO45eKp5BbYg9tNwxnOowjO5YZDGxFH3au+ZxZNkDU2/rBcAI71?=
 =?us-ascii?Q?1W9RJ/5r2woNaIFzZKttX0dbmap9HINPSOFmdP2iH6GWQB8kqyu/idNhPtQe?=
 =?us-ascii?Q?J7XXUGsOyASYxXzcblGAAIFwjBvKipbX9xr4DAH2fykRSiYt6cXge/MN6Esv?=
 =?us-ascii?Q?rIyYfwHYjQDvH7krikLJZxNjmFRc9PqICmChRNGhUnOhlW/ruIPv9XNo0Vq7?=
 =?us-ascii?Q?6uXvCYXLm5lYcwL22FWdJOYn4KYk1YGN1T7zMy4FlArKAxc30ovPWpUAUXqu?=
 =?us-ascii?Q?6n/j488fIyUcaBRujYB2sv2u5dgYvMRb1e7eCknyBU0xYTjIzKNru0Yaj11t?=
 =?us-ascii?Q?BB/72UCgm3dEr2Z4fZT/WpIlkw9qyN0tK9kcK0zI/eY5y+AGtO1YUeh3xBsn?=
 =?us-ascii?Q?dukzYqCRBs8XsDhkQAgVJMhoY/5CAQx4v4CuY2mz5MJkwRTuENLwE8UnvydW?=
 =?us-ascii?Q?+jtGlaYPTfDLZf14g1nheGvdlsc79P/Eu8EoLu34sNf004TbHneXAczQvM1t?=
 =?us-ascii?Q?2JIhe4sCS97AQvqQbTp806z2DJDeHJsBBy3xSoLXQ3O4r/uZ8PjFKg1EW6bf?=
 =?us-ascii?Q?kznSlt4AfXtEcTpSLDenT7J2YQmibm+RIUSdiIgJqwfUH6qySZ0l+oCPfKB4?=
 =?us-ascii?Q?0G9b2E2pgwlOi5eIFVy8HkmCWJ+nRtq2dc9OdhNdHDeV8nNgBFViWcPWANB8?=
 =?us-ascii?Q?U1IGIXsL7jYsXi3bma91ZxBacrUQe7oCVeYwSRMZKfBvmbAdR9XDfRqNw8Oi?=
 =?us-ascii?Q?miP4EaS4FRxmkPB9vlV6Bd8xcimppsn5h2a0oXKPCrz0SSEfPQ0SA1unjfba?=
 =?us-ascii?Q?oZkucM4HU3wi8aRD50Y70PUyP5CKZ/QXbOzsIcl6NdDqeq9mMf6HNP4h+S9F?=
 =?us-ascii?Q?gA1KJ25J9HwLt+KTUUztIXQnlWDHicnD+fIYNa0jFn6hs9mbZXppPkR/QFX/?=
 =?us-ascii?Q?j/Gm+uRXsN3IwtzzrdVkMTRT8uQNqHlDDm0jRkUsV9+GqMkMKDFyEuNS28Xi?=
 =?us-ascii?Q?e1cMiSLnfOvFnjQM774vGg9eKuR/MqJSfOpEiH2eNw3Gu7g4e4X420ayro7C?=
 =?us-ascii?Q?StpQgI2Nf2leMveiTWJ9RwBghkICJOWT5dkVpWuj2QDudBjkoCcz3Vg1yebI?=
 =?us-ascii?Q?gxKT7IznvkLS7bUCkDJxPYOXnGtff/GRK+Y88UtxAwu87HCUvmk3HKfjbhyw?=
 =?us-ascii?Q?mX+urC6/NK8TUlc4RIgmfmvPLM97RgCo5FD/UltRPw77IPqZVNS9GiRAY1my?=
 =?us-ascii?Q?s5JImulRfc13DnuLR1nXmdaqaLTZC5xjvAInCaK8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LtTUEVLzIRnwUUkDD/VdoVNcALFRHJ143LU2w3sI62kmwNMHPDTHlOrE6NEABP9cdShvQKSTcrU7rGLZSFXHlo9tNA8WdNSdN7SgeZRYc76kzdhRr3fbZFiv3UYMDdFeoIkBSRu+wju0v/0keCMxkmNt3tnIzt9GqN6K/SZ6QIdySnPPdTnVmc49+M2zqrhrVgI8KqZ9VchxkpyoAITirhAPPZXfOnmKyXmPmxmSgO1UArtyNePfCFPaZptjUEKymHKOwZW1M5VD39cjhCoKY1hysTTTbGNp0HUsITIu/XL0lnpTMHLK/2LU7B1FvjQO8+ejCqxyW6SGX3ah5w7LshJutCat953gnh0E6be9eCIZy4lIX1cOj0S7n3TYKQkJuBKX38YB6euRGbYf25NUalGOSl/yE0TuxsMkwuAr+CUiUP8Oeyhf83JbQqlzMf6sv+svf/GkKMTX5VoaWPTVVjVQKpkCSA2YsNjLGszDIX0P2NmE4ZUXTOCxiqKbB+vNoC7CXUGMPtJGk9+22rIu4c+9DHX8irI1DToT3mrMui566DjmNVAir+cR8tIguyHBx1gthZj/bCDlRIClq25PxHm4wkPDezkqJXT5cfXKNqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63db5f9d-ada9-4c02-6812-08dd1561c6b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 19:19:44.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Imn0meJnhqbGBImpJBUaPHJnfAignVZTltDGfm5S13k7Dk+4OwIIzHH/FUKcwpnHeYhCNE5DunWCR7LKibTaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_14,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050143
X-Proofpoint-ORIG-GUID: qw-dKikVE92iqlGYUJg-p1RtpnkSA3lW
X-Proofpoint-GUID: qw-dKikVE92iqlGYUJg-p1RtpnkSA3lW

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241205 14:07]:
> When we fork anonymous pages, apply a guard page then remove it, the
> previous CoW mapping is cleared.
> 
> This might not be obvious to an outside observer without taking some time
> to think about how the overall process functions, so document that this is
> the case through a test, which also usefully asserts that the behaviour is
> as we expect.
> 
> This is grouped with other, more important, fork tests that ensure that
> guard pages are correctly propagated on fork.
> 
> Fix a typo in a nearby comment at the same time.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Nice to see some more testing going in.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  tools/testing/selftests/mm/guard-pages.c | 73 +++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> index 7cdf815d0d63..d8f8dee9ebbd 100644
> --- a/tools/testing/selftests/mm/guard-pages.c
> +++ b/tools/testing/selftests/mm/guard-pages.c
> @@ -990,7 +990,7 @@ TEST_F(guard_pages, fork)
>  		   MAP_ANON | MAP_PRIVATE, -1, 0);
>  	ASSERT_NE(ptr, MAP_FAILED);
> 
> -	/* Establish guard apges in the first 5 pages. */
> +	/* Establish guard pages in the first 5 pages. */
>  	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
> 
>  	pid = fork();
> @@ -1029,6 +1029,77 @@ TEST_F(guard_pages, fork)
>  	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
>  }
> 
> +/*
> + * Assert expected behaviour after we fork populated ranges of anonymous memory
> + * and then guard and unguard the range.
> + */
> +TEST_F(guard_pages, fork_cow)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	pid_t pid;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Populate range. */
> +	for (i = 0; i < 10 * page_size; i++) {
> +		char chr = 'a' + (i % 26);
> +
> +		ptr[i] = chr;
> +	}
> +
> +	pid = fork();
> +	ASSERT_NE(pid, -1);
> +	if (!pid) {
> +		/* This is the child process now. */
> +
> +		/* Ensure the range is as expected. */
> +		for (i = 0; i < 10 * page_size; i++) {
> +			char expected = 'a' + (i % 26);
> +			char actual = ptr[i];
> +
> +			ASSERT_EQ(actual, expected);
> +		}
> +
> +		/* Establish guard pages across the whole range. */
> +		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
> +		/* Remove it. */
> +		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
> +
> +		/*
> +		 * By removing the guard pages, the page tables will be
> +		 * cleared. Assert that we are looking at the zero page now.
> +		 */
> +		for (i = 0; i < 10 * page_size; i++) {
> +			char actual = ptr[i];
> +
> +			ASSERT_EQ(actual, '\0');
> +		}
> +
> +		exit(0);
> +	}
> +
> +	/* Parent process. */
> +
> +	/* Parent simply waits on child. */
> +	waitpid(pid, NULL, 0);
> +
> +	/* Ensure the range is unchanged in parent anon range. */
> +	for (i = 0; i < 10 * page_size; i++) {
> +		char expected = 'a' + (i % 26);
> +		char actual = ptr[i];
> +
> +		ASSERT_EQ(actual, expected);
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
>  /*
>   * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
>   * behave as expected.
> --
> 2.47.1

