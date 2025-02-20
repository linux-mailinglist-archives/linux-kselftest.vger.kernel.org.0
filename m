Return-Path: <linux-kselftest+bounces-27060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB4A3D647
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 11:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E24F3B1B08
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66291F1508;
	Thu, 20 Feb 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gt/iynS2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YHma1XW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6B1F1312;
	Thu, 20 Feb 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046570; cv=fail; b=VrglfTSpacOtq9B9J6Dddc37xWy0fz/Te1Q4sxSG35VRAhLXG7iFPDIZY8485qHs5H5oBrgkjgUIp0ssgBy3jrq5EsZcGSSAsjGq7NlOlY7nqeUNrxEq1qBanKbOqqHnTp/JMQYnWW1v0q2outZgrAuz0XhYfliyPXIyV8KxYEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046570; c=relaxed/simple;
	bh=8/JigRBJ66HdV65WRtY6oIsLhojxwFvz5Vm8/S4jbp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNTQzmiBk7gpHnirmnnJ/RrdKJQJ2bF8ft0hGfojxHAsFehPKo8y3NQf/rmyREud8xRHPBNQcnoNgXC1DIZS/lsGSMsjcT1lb0/Eu/jC5X5zOAlWZuJsrKQOaYXRi0HYTYnLvG4Zy2sSG0ROn0p/pEYefsKEozqZbVp1rH+W6ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gt/iynS2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YHma1XW1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fiPG004331;
	Thu, 20 Feb 2025 10:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8/JigRBJ66HdV65WRt
	Y6oIsLhojxwFvz5Vm8/S4jbp8=; b=gt/iynS265PwklvkzJ/S6jVZW/hwNjuYsY
	oApVzmAzczPHOsIJ4U26PbgM5TaS9Sto2XhF39M7FAE3X3zir/tDqB33lO6lTMnW
	Uw8Mc7o3olgWTMCViTK4pQ8mrvfLbkOrkRQh4dSK0UsPevbYLZ/pwUjMsNYmIm1+
	HLa5P/U/SQU9RJzCQzxjX1EJ1rdzQ99LvGgNRinktJfsyxPTdIkDOp+rn19P+qF5
	yU8+sFExDitHJH3mem0qfUpiiiBgJ1kNtFC2cVXAe4nQNXGVxEwLxE6ntQN6oan9
	+qlHb+CBHYn8/1o51V9buAkY+YfMeWLrnHmDGn06aXphJJEVPO2Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nks4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 10:15:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K86aVw025289;
	Thu, 20 Feb 2025 10:15:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08xpukk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 10:15:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAvluB07vxJw78xQ9di4/5urUdpgsy79pvvRp3w4Hp+OyLtPHAMgEl4sDdGBdMrUDikeGfNb+QpGcncWdIsakhqJYNfjZ+46aZtwNBVEOKlfyn7+01FRDLQ6r3sYD1ZyeQWBnHmpVEXioJ9WHB99P2+q150E+tPcrbn63uugkAZhFkMC+Wum5n/opiYajGBITsbCM3Tg7iFnhcrEhM+NfyCEzD0/qLRzSbnCjTYGjDRTxf/12eGER4GG9UaHuVqO/aHTaWyWG9cA1M/b6J2gQeXwSYFzGDNhvDoxEKRqpEWTJ3WZiMFuAC30xE5BV2oQX0cFFMMPG5bQWIqPweWF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/JigRBJ66HdV65WRtY6oIsLhojxwFvz5Vm8/S4jbp8=;
 b=cNPG826EjwSOzNWRhMb46SQfrPsIx8JL0LmuZ9F7Auzg2thoW/gAtmdNnqzaUWg8/3sJn7PFHiFoROwGE86dQOf1sdybwCliJl5M86PMZKxfFvqk8B3ojcY8ytlbfAA7r+aVwdG4VSYPzl+5wIC83yI68FlNd1/Z1hxw8kaYDwxz3uSaK4n5B4UHcq1klLg3T1xDPp8L8Vk6K8uYTvP7Zk3KfzFV5fs0ctX8tre2diVSIxZ71CK9C84bKOj4fc2zNLXgTAPABe25Fja4Mw/nrZNd6QPhhSJ9KDhhR85iIYk/3hf5jTCWW4hWRSjLjoXfNTiyegDVUSmkwnUZd9bcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/JigRBJ66HdV65WRtY6oIsLhojxwFvz5Vm8/S4jbp8=;
 b=YHma1XW1pItJg+XTdKmXJRMng55zDnqlLCy86JYD6edrgSoyLkN2pl53e1fAfyT6pp2DFx2DN3qmdDOxBU/bBUf4n3fTFYZ2ODTH4Foz647niFfu2Y0Q890mFqv7YOBHtNg361FdJxfOFMUKGbPwsm6N8KH6/dr/DJ5pznT92aI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 10:15:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 10:15:49 +0000
Date: Thu, 20 Feb 2025 10:15:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local>
References: <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
 <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
 <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
X-ClientProxiedBy: LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: e508f5da-de35-4a44-ca1e-08dd51978c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXUqRutaDMenqlLIJ576DX4/w9YvmGr9D9d/3P1f2EySLUk4xOUtuLD38oeN?=
 =?us-ascii?Q?guh/3tGxNIlQhHcCfsCCcVR2qB2IMglu8JeKVO6pAFceZNaKxfz0ka43hegH?=
 =?us-ascii?Q?qc99yNErIurrpAYAU9rrw5+imK15+TCvr9c/evaNfCBxoT3tYaCYnMM0eMw1?=
 =?us-ascii?Q?YlnAGdZ+1/10CLRytxfJYvVHUTXrIhvoUGyPgt+igzcg4AMhzL1BNre3e1j5?=
 =?us-ascii?Q?kMTpiVS7tX4boOFU925Fhr2mQTnw10fRKfdTkKng1/z7Qnemd0Y3qF+beAiv?=
 =?us-ascii?Q?wnLyskJDTNR7guhEWnZl9l5+ZLS077qBCEGOPIt/Joyj0u5JpHV503Oo9Ojo?=
 =?us-ascii?Q?9gmQdRLdHBkGMu6AE1qeE3pHqmtNkKBX4mpgm78Yx57+fJ32jZei438AplVp?=
 =?us-ascii?Q?fByV6pPirgkynHf18RtGHUc0SZiLW2FEudGEM24+jDbI/NInIohqGlRBX1gF?=
 =?us-ascii?Q?5L2JXs9wUfMYBZYRfM9acxYkZJLRbpKr39iBau4X823tmpmcdfeYxxeXmGLM?=
 =?us-ascii?Q?2Ti6gVwr9pm/4qiPRJr7/pVBG1eeZzqyU1sfGe9KEV8+yLJn9ELhGVY5dtsy?=
 =?us-ascii?Q?K1lPyMnMpfmRy8pa2Fq2wBOzdjGYEWTQhsIUEK5bYBHwPpdEUz34oH+cFdy6?=
 =?us-ascii?Q?Q3azMldtSU4dPnRt/wrtQiCdAISdm2HMgof3hDuOAuxZz18SJ+2bCNYJ+LNX?=
 =?us-ascii?Q?JyF1I2RZCbzuaP9ILSfh9R7PvajO+mHfK9tCPHymSqxouEboyOmTDdscLdq3?=
 =?us-ascii?Q?nIm9OXFd/eaFKiKPoFqNFIo/o//nR2aaB1XWm5LiwPN3f6eH5BYXxaeHtZCB?=
 =?us-ascii?Q?cfALR5RyL1Q9gmTpFyUx1RvzhPNBnJu7jxdvO6drTos5a3lKHxxyA6c+MWLM?=
 =?us-ascii?Q?0RSG6oph6OPUMiLMM3WM4c1c9G9AdbPkgCQazD8nyAOAbhIOVGuzvZ5vY8z0?=
 =?us-ascii?Q?6yIVDTE9EixrZtWjVDHyLJLl1BkoMdLWZwxZaHoWnhhYp3G624RVERu5JE+v?=
 =?us-ascii?Q?wGrr11WyoCotSgikITeVbLWSTkXibwOSCwTKxv1jOmQnxtlf943n+sBFeB8F?=
 =?us-ascii?Q?Nyz45duHfCd4cnY/kjsXA1rvNC84tDCt8ennznzr+HKcLsPdQUhu8lmm1DNt?=
 =?us-ascii?Q?7r+oFgz09MMc0XkpDW8+8djzJULyGsCAYHib2FqCnHA2cDM1/0A3feqfryfT?=
 =?us-ascii?Q?OZYt7b5fela0ydDb8442Xxh04TECq4sHTUMVL85tIYWVYifSMAAuS6VxqtU8?=
 =?us-ascii?Q?Xwl0ZC0VdV2cGYhm+FVyKhKPivixwiDqYA2gMZjH05aiAlojwgH/6nDc8kEG?=
 =?us-ascii?Q?s6swSVoUnB0ODAZeI/tfFw5/TlbWFebG9r2NcfZfU/HS23NNVlc7IyYuPDpR?=
 =?us-ascii?Q?e9zULuiPY5TjxaFxQDnNrrynQW54?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9KUbYagdyymxQEbGK+Mxo47RRZzQx7xiJvoMTIpZNZ6d+XW/cVromhTs19H?=
 =?us-ascii?Q?yIWY4cyzNv2OhJnM219uCNmffGLDkArp2H739LwGE+h+ErEuF5h0igSR1Wuo?=
 =?us-ascii?Q?LZQ0MODL9rNUiO7wEaqbDC9m9Mhe5RdsxBMN0/WjpsRFaMbxZ18qi+7EO4IX?=
 =?us-ascii?Q?+Vyz0mHmIMBzPkMf4hsFGe2r0Pd0kVFUPzdJjBydUWw6aUhVPxPKcQhJAMXu?=
 =?us-ascii?Q?qV6rU/twTYCAWuCHahmxotywlvO7TKQH3eNbtcdv8pGaybnNeCDSBidOGUOo?=
 =?us-ascii?Q?N3Bwzl4YznFBiIRT+Tmy0Opm9f1C6dS2pUR/qckiI+CYGEWhwgscjMPjBoFU?=
 =?us-ascii?Q?dt8QYLQfivs3Kde/azYk9AvUc8nPhM7ZjBuqKGPZYGQHvwyfc1l4OHgrnX3z?=
 =?us-ascii?Q?g8EpGt66u7VOti8EL71jT1cZtS4Ue7Wx84+CouwbCrYC17eeGWDJaWGlpemh?=
 =?us-ascii?Q?eNWjV9z7YWB5QjLHmhJDW0O2Lh0PL4BKAOYtYPsJ/PlEjDEZq9lafmgOIu1c?=
 =?us-ascii?Q?UHCoZlAGpsVgP7lM4IeUrvpJUs577PrQ4H/4fnsrJ+GhQ6iv71bajW/Kv7kn?=
 =?us-ascii?Q?DEpItExTVxUC0zpmNm/XSeg5/KOJhO2R6IOSgezkuEmdhtWI7gPpB6yHxCc6?=
 =?us-ascii?Q?1U/iHfu8Ze6K8susnI16vHEarXng0/DtTYKJ4LeeRyj5lZg4fySC5BT5lnp2?=
 =?us-ascii?Q?mMGappx9Zb7kVE4Mm/yEErtqFcXjqlZokl3O6PHyHfAeKi75m52TcJmqK9pB?=
 =?us-ascii?Q?N7J7tZS1bOpogkpY7Dn6A3JL7j6MW/CRnG+Na8imJ5VqdqDABbBE6jCWBv50?=
 =?us-ascii?Q?btUfZPHgHiLuKlYJgaL0evBiPUVitDi8XK24z6Ywp1vzbWMv9pKLlgnvNUNY?=
 =?us-ascii?Q?1q4KDOT3XsMymlE3HVJyR2SSA0Lp84osxMVgX9iBYH1Z41UG6Ariqjx9dFAF?=
 =?us-ascii?Q?yDfaCJZ85EJuTs47125QTKUHK3zsm8NaycgkME7K+lEgGHBFM8ZSEUJYGU5t?=
 =?us-ascii?Q?mlSJW0qdMsHfpvFaEtCvQdJMzOn9KITpgdwE6uZJRv3tRU7V/Fp0DrNlYkmb?=
 =?us-ascii?Q?4t1lLYPnHcg/RMKnn/qYrhyA9PhXVdDl6oQSaO+JDBN+ac2scNdBrbAc/ZBt?=
 =?us-ascii?Q?XEH+K+xbOAhfv+7TxcMoJ00r7a1boNMy+00tPfe7jYawoJn3gte/oS5doO9o?=
 =?us-ascii?Q?tEZqA/2HhOCZq64oTHpiJz33zfqdepQQQjic4VP+6ac53l6qHLjdAVGED7lF?=
 =?us-ascii?Q?F5HpjjOd8THBUUwORufAf2xOWhbSSxd8CI0hptN2Pmm6jgfKjj2l9416xrD0?=
 =?us-ascii?Q?0+Muga9+NSPP30dhwCMn8hej8WIX4jypnOi7CAEwrfKqy0K1uBCXxydiz8dJ?=
 =?us-ascii?Q?lkDpqmy2wcNBCB3hBdTt2OQHDRm6uwYqbt1Iqu5EP9mYMlR9kXX9/BPl0W3d?=
 =?us-ascii?Q?Fq5zANaRICduyQJf0V05vILlT1GaamYcGNqrKSg7q5eTrCZBoL/dvxiuFrNH?=
 =?us-ascii?Q?/Dnf3SB+1hpsg8On693GkYHEs5UBbAqsv3DJ4vfeSxQkwhJwoX9OHVEQGzM3?=
 =?us-ascii?Q?GFh+Nfs0WVqiPELFQySbbU45usZNcaAg/R1nHrjklApdUsjLBVdHB+tOBV6A?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igxln12qRMwm40q4IwE2l6ShquU4iP0l8OHL8xWGfK5WeobjlwcLz2vkiARdg6h9raPo7FghFfnzKdCZZdwmkyrbyDfbxaM4aoeeFrPPTL0UZG0nAhevMfjz2YwO6P5oHvoeXWo/gxXWE4VJ/oSm+/PG/gJTy/yYyFJuK1VOfOEJoiAGDetEqjr9qd9mZLZdbBxBMGO+x0wRTlNVstdjvetfi65qhM//Q0tXcOTZnqYG9hZGQ+m6El+Mj/BpeCuUHXNcMR7KIJwxZWtY/Yh0bKlG2Of0OfBRIV3py6VX9qh7NHMcmuIG5qzvbFZkM4XuZjG8O+qzWkzdvfX4JKMy54V+hznB10+GsLMmVch5GTfF3FNXUHxkn/2+ybSrg+gyrf1wUnQeHiSmkVcMekj5iFuwOCtfAKXoto743eqT/PLQ4bp3n/+Ptag2Fv/2AmsQooRqAzhcjxJPqcpL/CDUx1sxULNqFmwE9ximf88VHWQ+e+upMHcgbzdHFWFlKXBziWBTf5AhMmB0Ps6oropK8HQrbNkS5srX0IY3rtiKceXGdTyn8/ldb5jUjVRX9haTTYineqNHaCqkGEFC5uC0aF+I8ef9Rq+X8B/0o/Yargw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e508f5da-de35-4a44-ca1e-08dd51978c2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 10:15:49.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvIS+4ika9iPg4L7qyTBg91cMs9Suwj9ng8EaaTnqdGtA+7CDvqxhsOpltFsSX1Id+0/9g8zCWpSTnmHftruycCA3MI4U4xgtpftVeqtc7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200075
X-Proofpoint-ORIG-GUID: NpeHblSQnszMcZh9_Ql6Dw6lQzqQHP-I
X-Proofpoint-GUID: NpeHblSQnszMcZh9_Ql6Dw6lQzqQHP-I

On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wrote:
> > > Your conclusion is 'did not participate with upstream'; I don't agree with
> > > that. But maybe you and Kalesh have a history on that that let's you react
> > > on his questions IMHO more emotionally than it should have been.
> >
> > This is wholly unfair, I have been very reasonable in response to this
> > thread. I have offered to find solutions, I have tried to understand the
> > problem in spite of having gone to great lengths to try to discuss the
> > limitations of the proposed approach in every venue I possibly could.
> >
> > I go out of my way to deal professionally and objectively with what is
> > presented. Nothing here is emotional. So I'd ask that you please abstain
> > from making commentary like this which has no basis.
>
> I appreciate everything you write below. But this request is just
> impossible. I will keep raising my opinion and misunderstandings will
> happen.

Well I wouldn't ask you not to express your opinion David, you know I respect
and like you, and by all means push back hard or call out what you think is bad
behaviour :)

I just meant to say, in my view, that there was no basis, but I appreciate
miscommunications happen.

So apologies if I came off as being difficult or rude, it actually wasn't
intended. And to re-emphasise - I have zero personal issue with anybody in this
thread whatsoever!

I just want to find the best way forward, technically and am willing to do
whatever work is required to make the guard region implementation as good as it
possibly can be.

>
> Note that the whole "Honestly David you and the naming. .." thing could have
> been written as "I don't think it's a naming problem."

I feel like I _always_ get in trouble when I try to write in a 'tongue-in-cheek'
style, which is what this was meant to be... so I think herein lies the basis of
the miscommunication :)

I apologise, the household is ill, which maybe affects my judgment in how I
write these, but in general text is a very poor medium. It was meant to be said
in a jolly tone with a wink...

I think maybe I should learn my lesson with these things, I thought the ':p'
would make this clear but yeah, text, poor medium.

Anyway apologies if this seemed disrespectful.

>
> > >
> > >
> > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > >
> > > > > > As I said to you earlier, the _best_ we could do in smaps would be to add a
> > > > > > flag like 'Grd' or something to indicate some part of the VMA is
> > > > > > guarded. But I won't do that unless somebody has an -actual use case- for
> > > > > > it.
> > > > >
> > > > > Right, and that would limit where you have to manually scan. Something
> > > > > similar is being done with uffd-wp markers IIRC.
> > > >
> > > > Yeah that's a good point, but honestly if you're reading smaps that reads
> > > > the page tables, then reading /proc/$pid/pagemaps and reading page tables
> > > > TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
> > > > /proc/$pid/pagemaps and reading page tables once.
> > >
> > > Right; I recently wished that we would have an interface to obtain more VMA
> > > flags without having to go through smaps
> >
> > Well maybe that lends itself to the idea of adding a whole new interface in
> > general...
>
> An extended "maps" interface might be reasonable, that allows for exposing
> more things without walking the page tables. (e.g., flags)
>
> Maybe one could have an indicator that says "ever had guard regions in this
> mapping" without actually walking the page tables.

Yeah this is something we've discussed before, but it's a little fraught. Let's
say it was a VMA flag, in this case we'd have to make this flag 'sticky' and not
impact merging (easy enough) to account for splits/merges.

The problem comes in that we would then need to acquire the VMA write lock to do
it, something we don't currently require on application of guard regions.

We'd also have to make sure nothing else makes any assumptions about VMA flags
implying differences in VMAs in this one instance (though we do already do this
for VM_SOFTDIRTY).

I saw this as possibly something like VM_MAYBE_GUARD_REGIONS or something.

>
> --
> Cheers,
>
> David / dhildenb
>
>

