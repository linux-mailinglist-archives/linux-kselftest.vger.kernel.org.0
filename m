Return-Path: <linux-kselftest+bounces-44973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B732CC3BBFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 545824FF1A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00490335541;
	Thu,  6 Nov 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MWu7cCVh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VWusjvDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA5302168;
	Thu,  6 Nov 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439230; cv=fail; b=FgbQiCunPKnDRNUVwPjwXz+0tVek4zRb0rFznv4ughz6efoQzUhBV1IoWLR0C2/nGSW8ItQB/hCFve8VzBd/SFtaeYjBRkrZu8gNgzevoLRWCz+l9R7UVaHpz3rN9JHRcHJ1PuMMJDmETX2X0Z02vUmL+8S5Knx9Dzks4QNng/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439230; c=relaxed/simple;
	bh=QA3JRxuagSeLRl61xtMxRdnnnRMqbyGr7ablCxZakFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSM9DXiMV1GOoUYdbmIDY3Wqz1iLzb/xxp314ebjTiTDeunuErBHrmaKt3HhV9DfOCfMOZ7OIfDCGbcx49XXw1EkhSyVApkTx9nFTmhNdlU7JZuYrRIflWL85NHK/etNR8Tby3sjxjdcB7SaWk1hGi6eowoYRRIhzqMDinkXlLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MWu7cCVh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VWusjvDf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6C8LBw025043;
	Thu, 6 Nov 2025 14:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IkYc1jIa9SxZ67QqIy
	qW0bDcF360wU+Y0Uq8Otjy2AY=; b=MWu7cCVhVpZDwJfpvayJXOZbq58lwNC8b3
	a9nQfuGGkIhG/ECfPQJAxmKCfH4C0xZNIkZMIqDFi3e5vPSuJyvW8fxYLl3nZU9s
	cjy+tXEFHul4bEOhJj5k/ILB4xtka/cS9JnCWCoFSbvCBzygBcnQUeEybR8GoUab
	bAiI8EuG/wMx5b5ycZtmxkzd+TXW7NJSVbCcJ3Dhh69eefoEJX7OkBKfnt+fyNJl
	at7ZXX9WIOHHQYjCHFCVFtHj47FUMKoXyNek+1Ua0p6I1hPnbY6b4+hxUnjOYwbL
	T+Bocn4vlcy8qpr6Qn4gYbiwN64OTkmzudy7RoJmtGb66j47gNbg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a88akahws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:26:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6DvUtc023110;
	Thu, 6 Nov 2025 14:26:55 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ng0yhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk0Ud6mG63FvOVYUkkjz3cd47L0hartmSGDihgJmz5wA+DJmMN/scAM26P2kP8R/3/SSG5QciwRsaf1WbkFeiX42+dsBGmZ48Ry4M2IKqq2DWdMKXTT9mQKCl+hLWb76FTJF/x5gKbm62AuKrFXVwI72CsAi/YjAR89ef2uLl+PQWDk4/feia15NU2ZG1csa540o6klldX+03vJjGorGlZOf5l1R2Ntvld3IV8ob7IRyqw38yEwXZYBb+g4bh+aDNekGXdvZIUUeK0+ZF4v3jwrY0ezM5uUaUg2SkBrB6gHIURdEVsrLE51tXIA3bWi4G4aLnuDCrqfnIkajtC1AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkYc1jIa9SxZ67QqIyqW0bDcF360wU+Y0Uq8Otjy2AY=;
 b=ZUmbliwds97rO7ab9+TMJS24kEeZ6JKvwl73Y1UphEdGvnCItz0Sega+848Y69W1AXbF8TwoeUuKaEyR6eCSabjj17leItlPt12FXTrTRX5iGZbyyKi30tpNc78OUjGhThDzE2bGWvrIzBs38TljE528ytEIBOTHMrFTekzZd7sobIpav3jdaA6nLH0q/gYdZueSKvQ0pv+93a3AtBZLh+okOusuGS6sozpLFE9QsSpGhRZzGJxHe6TxrxzSK88tKaYxTD1nljFoilnJezxwJaAATVFe/zlp9IgomWn1V7yknHROk4IoxcRELwnUz9YDor6pIGTv8WItXAkctDtXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkYc1jIa9SxZ67QqIyqW0bDcF360wU+Y0Uq8Otjy2AY=;
 b=VWusjvDf+1MWeQGBgWmScWp6PTXW1nOzSTnwQZYyQ2VXGBcfSo5AftoWiRrROTTnHlx+wcj8p+vemmGAR6auTecR3BPA27n1lHckxVqzUGkjls1dzbFnFjO/FDGoSx8+dFQeLpeszJQydjA5qAZP5wDBHXZG7MEcDIlDzJmy2Cg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 14:26:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 14:26:53 +0000
Date: Thu, 6 Nov 2025 14:26:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <6637c6db-bd9a-43cc-a1dc-d2adb097f53c@lucifer.local>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
 <aQyOZ6eYng-IjxS_@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQyOZ6eYng-IjxS_@fedora>
X-ClientProxiedBy: LO4P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a6d1f7-2316-4555-1104-08de1d4087ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HlKnJy/mT3zhNpEXTWtk4KYLKgo98LqOZ9v5JNLW159uVyKwbjFyzahTQEOM?=
 =?us-ascii?Q?abLhYm4+9MmPkyE4yLI7WuLGOSYfH8KvM0Shcjc9k9Wlx+5lrZLIYd7KfQ8j?=
 =?us-ascii?Q?bEQftCV34+y/b6TtSM4GtvEcq4LX9ixDTeEtGxx+cY9G4L8O8LgTmuTM9Xey?=
 =?us-ascii?Q?vboSVo3pY7KI/ECgFg9NPtKUjMBHpA6U08g9qBxsP3uxX+TZeBRCgq2ApopC?=
 =?us-ascii?Q?lehi+6rU6koPo/hhnkFwN8nkb+OsKVgJratpGdZbDnn/WVAD/kUp6fKJYBou?=
 =?us-ascii?Q?1e/Zj5pkzCu8/AUaNrKbGz8ASfdbTDgfCog5QbF6+yFfbnie19hb1+dJT0Hl?=
 =?us-ascii?Q?RVI6O/7BM9eI1OV6FcElexA9okqhI9pXqQRdqr6NODRG+Mg6Af/b3AfxEypM?=
 =?us-ascii?Q?nxua8nCMAajXk2TSiQWXeemg/mnzov6bRr7eTmO4U0btiXXSl6BTm8Qpv26q?=
 =?us-ascii?Q?k5xo5exeo0UCqfn495VKVcqY1Sow/eiFxXE2MukewRExCLA449B1WNc2BfGv?=
 =?us-ascii?Q?XqL7dXkpByFQJOmyY/RjiDZT/v1mxnLKmQVCEXiHzkG7mcGP/74LHh8RStWK?=
 =?us-ascii?Q?DqPN+tYrfmiGEEiruY3krdJOvRQJgcQC9yAM+Sf/OXd9Lk5XLNgoeaMwqR7m?=
 =?us-ascii?Q?qhZT24hLVfcMKexysO8VjSugyL3GOXCFY542Ff4P73rhh8a2NlY/iBw8eysI?=
 =?us-ascii?Q?a8dVXDJgT23p5D/7nNj/C6UeeOmpAiNSv/jOXI9xRFedqMomSLAO0p9H9pcc?=
 =?us-ascii?Q?T+LmypeajKiSsbz5yPiZqcSQYqoz00/LzcwfNqOjQ81fPcbnUSo5oZ/YLrP8?=
 =?us-ascii?Q?z5MnyD2oFAtC8jRhxFvNuRhF4GUq2pDPL1mSZoG0Xi5Unp83xHtMvINYXC/f?=
 =?us-ascii?Q?qKi1krVIDl01JmDwwGrs3ZMOQkAlbM7yppf34hS/YG/NM31uGcKYalVClLhD?=
 =?us-ascii?Q?HKzkAdfChHGW7rOc7QcrLUFHZ07uK25N3qnCZ++3JHcoX388g8PyQ8vRndG/?=
 =?us-ascii?Q?IA9AYxJEaXhU2aFUSd2hWI34dj8W2PmCtAo/hK5qeKvH1ofAjUG/r0bGOL5P?=
 =?us-ascii?Q?49R4Yk5/N8zStIrr/kTT6pl3J8bfs681YruXd6RMfBbv0nSnUm8O8JZI1OSK?=
 =?us-ascii?Q?uy9FHGMIGzjuKxwAkxG7LEEC++19Kfhx/Bnd0vAf3LBeW+fVU1MLZ7KfTpzQ?=
 =?us-ascii?Q?Gw/rAkqwoPeFzHRt5+QQQ09ThBDrgv1njag5GtQw3UKAu55Ibh/gDFYOHvGz?=
 =?us-ascii?Q?A5UILHS0E6acVGSaPs7dtvQ84g/hi47UNXyYiKcRmAngQBan2G4io8nOZQMV?=
 =?us-ascii?Q?q6Ws3VNT7MUGdYJT0B59buh1kPvjRei3nlDkoTon3NBY8bUA3sv1uc1MCEEi?=
 =?us-ascii?Q?mtrjckNk/IO92mn7ik7cY0nW5XTcifYagezSjCgw81ficH3Gkcl68AcwzQRB?=
 =?us-ascii?Q?DYf/aEiKskWgu27VA/zilzO7wVDMfTCi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JbDgDmtu+4/UvdG0BG9xhRAWyCowt0SFB7DWuZTD4ehz0vhFLHttuxzu7U8Y?=
 =?us-ascii?Q?4C0NBHb2veCdt3LUyXLz7PoEIkLLedIHQEdMaFpUrVq+AXFk1FAFAegjYlMS?=
 =?us-ascii?Q?ztXQdyExQH8EeP1Ul5Sa/hJM7S2Shfke1xxfVYkWV2LbU/wh8awr2whISfUD?=
 =?us-ascii?Q?neBysK8Ajppe7/8vGiZRNUdGTGM1nrphxcbkt4j4110hkZFbbDSIpvQ8wpPS?=
 =?us-ascii?Q?W7X66MKd6Sye0gTlDdIk6mx0i32s+XbujjmgM45vUvw6Wa9QQZ2NAEa4Wx9o?=
 =?us-ascii?Q?XQMXOjhnTcDMBy/E5eyM3xuLbd5Y5rGGa81tNXSaeAv3sCwUvA+gWpPUvof5?=
 =?us-ascii?Q?zYy0V96IeNAADBkuz7YxkSI7ARNB6PdFvYEXKtOyandoJ2VHilChbHiwBdph?=
 =?us-ascii?Q?02urDFtKJBhVNoH6kljz0dZrkJBrlFphjggDcRpw1ILlSorPIR+Nal/4EXiF?=
 =?us-ascii?Q?YvwMKZRizqTn0P5KN+bjm+j3amcfC75nzr6icFnf0CwJNgArv1Ox5WbUwbpx?=
 =?us-ascii?Q?YrdfooPcGMeSCeANPOHRdyXUB38qVLwbb+y3Al3OM5H0J4V8fH/tU2C7eEZY?=
 =?us-ascii?Q?f+lfpQhn8EkypytaGPXCPBBSZwusf8fqPO0e2DuvVa5eP+sWAbw49kxu/8rv?=
 =?us-ascii?Q?dY430P9zsEQbMZ90W4WdT7XKa+3IWOJ5Ph1Kb9wTEnwMAhReJyngzdPrT6Z/?=
 =?us-ascii?Q?DPgI1BMjikoFGAqsqOB8exKE90ycPJxVLbKCxEgns592EGP1WNrtwB18i1HR?=
 =?us-ascii?Q?Vi1O7fd8Itj0ZXwwJpPBqClx4Ipc32tfdZ0/pbJVzF5YlS8Cyu0II453+XQC?=
 =?us-ascii?Q?3J3XyLXf9B5TkCFeWTO3Ilco1t1JJhWPb5js9x6po9Y5eO3bjpUhsKP1/QzL?=
 =?us-ascii?Q?KvNOrH0/AdWLHxy/U6pGF3U8wSEcdORB5TXkptEKBH97ArYc8CKlaOLZ0N/u?=
 =?us-ascii?Q?kaHvCL6TZokySpKYeDgumKAaJcoyGjDDcu69BrwznzNGWbcatOYYU0zr63pl?=
 =?us-ascii?Q?lsL6AdhnMvquqZlLMArfF+ixHFzScV1J49YAOpLONhnPjdn58PQZOFtkZ00e?=
 =?us-ascii?Q?rFqc1Bw+EV5ma+vM2h+eA+qoUkTHuKnnnFXHFIJMWq2evS9H5RVXruL0/M+N?=
 =?us-ascii?Q?T174q8HzLKEsd7L8s4nDa0+oHIs9Cx+vUPi115RQhZJCGVT98wbyurPkCFAs?=
 =?us-ascii?Q?v43mlS8Er5oVWp/RQpHuwMVhvGur45Q5+kB/0piWS5jmAFa+JhZviohazwe3?=
 =?us-ascii?Q?cHhH0Z0a+C2nOljpgFmE3DikRnbwRAUkwdAH1eBycgYZdJ7abP95fXR8Yx9M?=
 =?us-ascii?Q?w7Loj9J4vZ+4ao4DqqtenvXhnL8d70pxasmIiL7QIYgXEilZ8fNMg426s/cV?=
 =?us-ascii?Q?/xgSaeJ9XzqYARvUCsmyMVOye6AQmKFpq0xAT0IhcK9iRBmTE7MfzROCzYwk?=
 =?us-ascii?Q?nrKqG1mprzZF56dDcpQB1TZZgtzR22yJDJzjbI6r+Ebx6h9tWrCNafBY1te6?=
 =?us-ascii?Q?c49yZJtHmNnZarJ00RrUQspP+ABRGDtFYkGk++UNgHZm+FgBQuTP4aAt61Ix?=
 =?us-ascii?Q?y0UBBAbnmVu+qF5jdoLNbBfGkWkvQZf/sxZ9TKdMid7ZE0Yr5ycTMSSCgGaT?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MkIhTfPnLZrLdhbG7TPAVdvUIk8MDzqG/C+YfRZDz/XMRLjvLbh66BVGMftowiYZYVBTfrVBa4U2zT3RjlClxFAXcq5yknsmhaapU6cwjKk9J3vQLv+Y7xyDUjfrNJm+OY6kZ5IGMIPF5X7sOlzlbYW8GyhiOHf5ghYawwtymdTTf0OaYQtoX6N4P88vGTkoVO8c2+l3FBsgMuTgGhf3lm5iBjqnOdBV/d+Qn6Y8TD4LDjULBMR74eeUWN5k/w/xpax6g2eOaBHblN3JITxGU8gX6UupEzHkrojFbB6DkqxCglfrJnBGs6dlp8xnI+tS+pXAd7/6Q8H/sMdhpmclLMpnaEl6ps0y5m/xosI+gEVZEY105QcH2MXPtTczuRMpNpkB4UkYPVFJFTGkq/LVFcMmo3uIKbxxY4HYvkHXXt9RQxx+MP+U1DueiXOSsmWEGkCPNUobKe5+l4y8YF20RnheEwWmSxeAIgqKWQvizHqzWfxSEaDdC96gzIC+wc+QWaJ4WI2esd+6sAwg8uSmIAIjUW4PjMVoyzwIYPRwClFStR3HI8k2+nK4DgSefpxZsc7v7VMU5zbflduNNODZIq9kydS408ynQenlXsDtjpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a6d1f7-2316-4555-1104-08de1d4087ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:26:53.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqqgnMngs1v24MbSbSRDeIiAFytEpsJT3WZ6S7aMeHiBkiWwpU0jDceuRwTwW5ic1Dr81WdGAK6AUmigUyckLBtULZEhoV2XQAYZdnLjwkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511060114
X-Authority-Analysis: v=2.4 cv=LsGfC3dc c=1 sm=1 tr=0 ts=690cb030 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_Di_JnMgyXm7Fo2uvtEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: o4NKD4G-_ArovbcgPPZtTbuC69LKkZoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwOSBTYWx0ZWRfX6X9G0Ee60DVc
 3NO4E0TethxSLIwr2mEnSfZo0S4d40NGgp/B4svcpzutOWLSxBgINghZAf5FIXdCYL3SSXfb7ee
 BDG12Kdhqk8kirGUhh8/CuEqSYZMSf5zUQNfsB0Kk+0ctn/H/Ua1oocBKYK6e2S7JEQGgT2/A8j
 pewnUqCFiyDr0mCowzBbroz1JlU9mYjvP7c3GqgcZt9LgXVrhmzN4ixemkVYH3n4w/mAJFZRaA/
 VTPiLq4qD9uBC25NqfaA6GEwu054Ybpe2Dtr5XF3j5sH7j8RdoJINPgM5kFmnEJ/8JzXLFLEA09
 1VPGwk1rFhZcH8mMpfqAZfOoOjnSwJMYaWfdyEB7UwgWKmK+CBDrJk2enmulgcaZt1/hZRLhMZS
 /LCc5C4/TI4CHs7tq/XIJaYvpmiGpr3/Ys26awMYjeyOMKCg5MU=
X-Proofpoint-GUID: o4NKD4G-_ArovbcgPPZtTbuC69LKkZoH

On Thu, Nov 06, 2025 at 05:32:47PM +0530, Ankit Khushwaha wrote:
> On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
> > On 06.11.25 11:49, Ankit Khushwaha wrote:
> > > Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> > > triggers following warning:
> > >
> > > mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> > > false [-Wtautological-compare]
> > >   1035 |                 if (addr + c.dest_alignment < addr) {
> > >        |                                             ^
> > >
> > > typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
> >
> > With which compiler are you seeing this?
>
> Hi David,
>
> clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.
>
> To reproduce:
> 	make -C tools/testing/selftests/mm CC=clang

FYI That doesn't work:

$ make -C tools/testing/selftests/mm CC=clang
make: Entering directory '/data/kerndev/kernels/mm/tools/testing/selftests/mm'
warning: the compiler differs from the one used to build the kernel
  The kernel was built by: gcc (GCC) 15.2.1 20250813
  You are using:           clang version 20.1.8
  CC [M]  page_frag_test.o
clang: error: unknown argument: '-fmin-function-alignment=16'
clang: error: unknown argument: '-fconserve-stack'
clang: error: unsupported option '-mrecord-mcount' for target 'x86_64-unknown-linux-gnu'
make[4]: *** [/usr/lib/modules/6.17.2-arch1-1/build/scripts/Makefile.build:287: page_frag_test.o] Error 1
make[3]: *** [/usr/lib/modules/6.17.2-arch1-1/build/Makefile:2011: .] Error 2
make[2]: *** [Makefile:248: __sub-make] Error 2
make[1]: *** [Makefile:15: all] Error 2
make: *** [../lib.mk:146: gen_mods_dir] Error 2
make: Leaving directory '/data/kerndev/kernels/mm/tools/testing/selftests/mm'
[649ms][2][review/loz-v2][~/kerndev/kernels/mm]$ cd tools/testing/selftests/mm

Even if I rebuild the entire kernel using clang via LLVM=1 it doesn't work.

The following KIND OF works:

$ make -C tools/testing/selftests/mm clean
$ make tools/testing/selftests/mm LLVM=1

But I still get:

warning: the compiler differs from the one used to build the kernel
  The kernel was built by: gcc (GCC) 15.2.1 20250813
  You are using:           clang version 20.1.8
  CC [M]  page_frag_test.o
clang: error: unknown argument: '-fmin-function-alignment=16'
clang: error: unknown argument: '-fconserve-stack'
clang: error: unsupported option '-mrecord-mcount' for target 'x86_64-unknown-linux-gnu'
make[4]: *** [/usr/lib/modules/6.17.2-arch1-1/build/scripts/Makefile.build:287: page_frag_test.o] Error 1
make[3]: *** [/usr/lib/modules/6.17.2-arch1-1/build/Makefile:2011: .] Error 2
make[2]: *** [Makefile:248: __sub-make] Error 2
make[1]: *** [Makefile:15: all] Error 2
make: *** [../lib.mk:146: gen_mods_dir] Error 2
make: Leaving directory '/data/kerndev/kernels/mm/tools/testing/selftests/mm'

Errors, presumably unless you build _the entire kernel_ using LLVM=1 :)

>
> Thanks,
> --
> Ankit

It may be worth looking at how to make this behave better because this seems
silly if clang will pick up additional warnings.

Cheers, Lorenzo

