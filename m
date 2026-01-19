Return-Path: <linux-kselftest+bounces-49348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7806D3A688
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E37130B1B5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F473596E4;
	Mon, 19 Jan 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VtQzgAYJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZgbFo9Zx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE4357A3E;
	Mon, 19 Jan 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821096; cv=fail; b=lomAKd6BujxqRkvW02qnrco2kf6XsFSMNkJYPqhlPx46NSsFLcfqT1neU/ADHDrjb956Q2zoFK35UWytEkoKape3yh3/CbnsXpoNpif440XGDoFbimq6dt5AL0FxFjO32SIOGdueuAmx5cnybIPwVSWAiiiMJayzPNeln4GDJXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821096; c=relaxed/simple;
	bh=hJLrya/OtEYGn5fVmpMTNkeQRMIrQhTwI3XxYzPyy1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QuYy0V21Cwwtocu9EirrFjvH5381gg6gnJOG0gXZojsm3kLoPTetH4bVtGntrVuS2sAF4GarqaHri0P2pHbNTuc/ATaGiNbSqJLIDdcuLnr1Xz+2C+qpCzAkdjX4AeOCA3YrU3+xjIRIxqC35Vchmcl1Q9owSQfjYL6OJKrOcZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VtQzgAYJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZgbFo9Zx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60INj2sR4130755;
	Mon, 19 Jan 2026 11:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eG4Si3cpLsynTz1Wpj
	+83UW/t9UM21hWiSAhDWGZOg0=; b=VtQzgAYJEXH/tADZyJDBhpD/P91YRA7n0L
	BWW9V2lLTLu5kcAEo6KzVgSIOZ6g088sUs29X0kHv6x5/VQK44rY6izEV20TlF5k
	iK7gEIcBielORVviliCCNZfB8pl+aql9I8oOsrHGPcqo4K5ihUt8rgWnMgBeVGkX
	1K8jCSD/HPVFc+aF42I5s1fscM12let0PVT245HHupEYvCjW/I1uzg0OKgtTNrwE
	H5xawBHJEPD305XY8xKuez1u1nwp4zY8GtybD2rcG1LKvWw1GKyfxCNf9RzK4t2h
	vgYemDjNdIDTK0YWejAmnBQwf+4PQlIufOf3NQyMNSJ5medKvhUQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypt1gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:11:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J9bdhv040587;
	Mon, 19 Jan 2026 11:11:18 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc0sgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jda+mKed6OhQs0HnE+50C4+Yid2EuB1ycvziC8HrBmNpg+XT/GhdncSGHXg0bqg/pp2o1UWLhHBoiUjfmEVagUIxOqu9yEMcF2Btz/n5VzzxkpNjv5/hP+6hUGI8bA6UqUBw6bzt2zJUHtkCW0HU2WMAoxqaABZks/JAW+teCnawbaSVPBqq7pgR08rbWrhyGmx3XCPm8q4ZQoR9HYAJkULVzU1TFAAefItHSceQoIu925ewh9HhsgAU3jujFCY+XFcmIl1qY9Fx/VjGMAFqJfxLrfgp7HPfX9E2fZjd3xZtsxaPOfazHX5LSyOhI+ZqmfX7JKYdsDC6zi7o/asrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG4Si3cpLsynTz1Wpj+83UW/t9UM21hWiSAhDWGZOg0=;
 b=pdFVByrWPjmOI2qmuQMLMu/QnsIFd7tiTqhGHAvEOzfcRA33kY14kcRXLxic1kG4QNMtY2OarqXoh3NMOF/mZH//s/1aCVBg4iqwr6U7ke7UaDgLsNmB4vmXt2TljGC6RjqwN+1fLSj4q86juZTTYsRQQ2E1P2MXbsH6SC1rYuS/CfJ49HCvalb04OBxQKM5MHvldlIwuFXRbNPAha6YS0IcoacCWUYXQXUPiKDkXEiamerjQDiH++ATBTOG0QU0NYyGhTPO2TV0Nxxpd0L8Nke7yrylwBCOygOOhiyTVOIerDhGo37R+NjkIYtOtTNdONsq78o3HOW/V8wa1g+XJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eG4Si3cpLsynTz1Wpj+83UW/t9UM21hWiSAhDWGZOg0=;
 b=ZgbFo9ZxY3igWKOPc8L41KDcTqTWBUgBFCG7Z38zNqpJtQQfe8tMBkUNeZic/F1No9FCf3HMYChSozBf6lIeZ+MOk1hzEp0QQxAjNEyBR7kji2Zbwv6yWJFRXiWHhPm8gyd9Sj1YuSS9tLOVGR/1GK5uc8sreiR02LQ1GKfunDY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB7225.namprd10.prod.outlook.com (2603:10b6:8:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:11:15 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 11:11:15 +0000
Date: Mon, 19 Jan 2026 11:11:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        aneesh.kumar@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
Message-ID: <53c0f278-6029-45f3-b3db-e2b70f323abe@lucifer.local>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <5957ae48-87b8-4981-a6f7-8113141e7b6b@arm.com>
 <f44fdda0-80da-49a6-a9dd-75b9a46e1f76@lucifer.local>
 <e71ffffc-8623-48d6-88b7-4684af4534aa@arm.com>
 <f7ed83bf-3554-4bfb-8d77-30ed4785a4a8@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ed83bf-3554-4bfb-8d77-30ed4785a4a8@lucifer.local>
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef14255-3412-488e-238f-08de574b765c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48uCoq5ovoyONDVUDNyc4FshudYbybV0kDWONjmbFXInFjM+918/JeHfKbb6?=
 =?us-ascii?Q?VGL+JkfLwJOM91cGJhwnLSmELYGgYgQGIbhJpHd6kxh/3KS79saXOXt2qz5D?=
 =?us-ascii?Q?ILy3uSBEaoSoF0frp6rlcrHUXvyDpRXPDHA/2TMsvo/D9SD44c8phAdeTvSj?=
 =?us-ascii?Q?geiVeLRoH/QCUyHQlj1bHwqtBz6Woe5hZI4yjv5zExCs0EAOT1p21zFWYT8l?=
 =?us-ascii?Q?5xEF8ZVlUixAO6rCwMaEUVI/pUg+qrE9otjLx3QoAfwbnC8xGYTJfAU5vXjT?=
 =?us-ascii?Q?egjIxenHpVS74NF+Njri9W4zabnlKgcrz/muR3h+Yx8f5S14XAwfI3HzYjCy?=
 =?us-ascii?Q?88qNgm805+VT1kpa0v727ufTPCEJ8BDEJFkXKsWwesYvf+GjlCDvlbQdiClR?=
 =?us-ascii?Q?tywO2gBSbXsmRQJjk3sXoLFVaPq4mgcMx/THb6+ugvG16NHJlnqdEYvwtW37?=
 =?us-ascii?Q?+AEvHOro4Cr9ZglRTdC11n2sLnSRaz+I5+bxI1knYyWOYYr35ko9TC3tVzAg?=
 =?us-ascii?Q?91wkcbpH+2UmLcK9udfDZBIdXFkqM0IlvXir1lt3wGMRU+ue6mZOSXANJO0o?=
 =?us-ascii?Q?PTKUlQEaM6IRhvfGi1lLJSejc4ENazcZ6pgUUEPtVBsv6xmNHeqo9LQ9NEs/?=
 =?us-ascii?Q?xN5LGGTAwMktFPPHgsIv0AhUIfku9IIJvB3HowjJiTCF7dj1nX3u5+HXxy+c?=
 =?us-ascii?Q?L3MhWdTkVR7itDOwzFeSsoXflG5mw514ny2nhPrjB6E2/DKj/d/t2aTB1lWr?=
 =?us-ascii?Q?dIE/p8gahKstYHUPNOASuoEjKMmtMlDL3qgz5rrAaBp/x+vnStUUqRYZ0nhj?=
 =?us-ascii?Q?7XahOCtxdxpYJYwMZLRwUB3EgET0xQd+ys2zSAC1GhRtEGAKTuIsKU7s15CZ?=
 =?us-ascii?Q?RvIWLbNVIhEOESX3p0CAb+Np7rDQTMVInb0aiiApt6lXgtIQX3I2W7UoeL1c?=
 =?us-ascii?Q?j1kGwWZeTAmLmLVnB2Tmw+Pw3Ye8vNESXVWoj4az2bPlhb6SZMoPdi79GtKB?=
 =?us-ascii?Q?008TQYCdo6cYBOaYrVOv/orqxsdWgWHnutcvzwu+LHGoq2vwzhWxqc0RTfO7?=
 =?us-ascii?Q?OyjuhiX17uWmxRyTqZ6jsha41xu568mJoqUiHmndZD2mwKa2/Wp0H/+iMkcf?=
 =?us-ascii?Q?egr+2ccp68Rly25hiYbcr6Bdsr6KykpeKkNyKgishlLsu8mo7/hPEO266TE2?=
 =?us-ascii?Q?F6NIeYqzVqaF8RGhX70DWdzKG9m7pIqIkL/Hb1WP8HK5xjSfukfb+SiXZ14t?=
 =?us-ascii?Q?6N0VFB+/SYGEIFy7pQ0cnG9MXsW07Pp0TLRylu36Cn3lKGaiaDe8M8ekgxYr?=
 =?us-ascii?Q?9NI5LIYEBI0GBC2cksInqMRRwd2ZqosY6IOLMD9syKjFVWuZq/E2++faQPG7?=
 =?us-ascii?Q?vEvzmhItWirjcB9ufeBklVd8f4ynpuHLD98l1b4eR3VbBlmS+wVZZQ2Gas4E?=
 =?us-ascii?Q?RBbEaElTIhYp10G4EG8eZROcUwgyDt+1ZeXaEKzmM3o94hzUNyIXpvM2xP2R?=
 =?us-ascii?Q?Z1lqTJWPqywmi7YeWckBvkSsoO/7vprsiFtjoZuzLkY/d920zCg8TqBprGGS?=
 =?us-ascii?Q?59Rf/TJEwh0TLCXmMgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIusUZOlMfmH33nRLgmHv/CGxq1ECCF2x8FGTnTotS34RPKOZys9oYQ8d9Du?=
 =?us-ascii?Q?n6pkqzwyAxZwCIg8f6dqOYBfP5XAON9vHmchqSQlhgScbZkm5EOKa/tef1Li?=
 =?us-ascii?Q?BFlwU+D11I0ucPo/ARZsEYZ3LW5e61pu3QBf3z57AOIfH4pC+S+p+CwM+1UL?=
 =?us-ascii?Q?EqgRghZ6XAkfagMg91oYlfzceyiq+tmay1Ut8sgnKWfZH+Ijb3CrbBl45FNc?=
 =?us-ascii?Q?9+GQBqB4z47uqQjxzU1OCBxvJ1YQx3nlDBIRRgKANxab/LtV0zHF3KyyRWxW?=
 =?us-ascii?Q?7Ecnix8RtqnMY5JnFvKDjXB+OiVcbNm9zZkmkCVroyRs/X5AziCo/YhSV6+/?=
 =?us-ascii?Q?cof2w2klovKlm/ng8k9VorN7yiD/kwEURVKUwiMW/MaR0PpSUPBmt1fncWn/?=
 =?us-ascii?Q?j4HYFBsb7b+/H9Q6e0yFD5VpW9WSvSt5tyr0wga22Uw6QkaOhjtqosmZXAfh?=
 =?us-ascii?Q?kiBItmY1J8PTPvTK3i3AVB53fEg6NGYZ6VtIJ2RRR8E3wht1UcDpPExmzVjp?=
 =?us-ascii?Q?ZDMCR41Z63qPhe8NFAcdT27UsSCpShRDZYRVtDCwVDeXgQ0G/1sjUzst5k+2?=
 =?us-ascii?Q?SKf0Ksq0gQ+MDNhJhnMAAfzjqMeY/YhZbXaTtMMYNqlZiwNRdRQ+LCviCUIT?=
 =?us-ascii?Q?MFHyRX2Xvd5L86MES5NE50BUDMPzSd7Gdh9Y4g0JxMYCWJSz+Fe42T+QHJ6b?=
 =?us-ascii?Q?TS5pImjbfC3irYbDRfzgVZxhJBsHFxZPU4J54AkpGyVSqezbGuj4lNxcu4SM?=
 =?us-ascii?Q?uB7ADFkPqj+gkjngM97XbEUVBaoNilBaAqs4rbPW0Uy9ocqbRd02zx/cEhlt?=
 =?us-ascii?Q?eyl0O/8Fo5pTJhHoQbWPjZdrLKWx5P/MvmqahEIeOvSCO54NKwkdK+AANMNg?=
 =?us-ascii?Q?0RDA/6XVqL6znh5R/uP5LqQ4uIctjdEXkEOVi5KHV0OkHqbweOYy67WAyKk7?=
 =?us-ascii?Q?HJsTjBxZP1Y6XM631oOH3+cr7eSF3Y6yoiMwAs17IYOHiSS0CqjzDBf9qOmX?=
 =?us-ascii?Q?pRRTu99aS2rdPR/3woaTGQyQpFqT5LVdm+wRpXOcQlQQYffKCXIBNAPG7Tg7?=
 =?us-ascii?Q?dVE4Z3Wg8B1i7f+lrV/qi+sXL8g+Vcy8n+7/IqvWq4cRIjlGdU1amxjinJkU?=
 =?us-ascii?Q?oEEfQC/TPLMgG0S7BkhRZKa+5UXEPW9eSQCPbUPoON+wnKKbTXiIpUIOkHFH?=
 =?us-ascii?Q?IrlDvshsr3rp/OHY9Qly5HmyWPM1apGsFgOXwwdFSpPjCm1U/glMCvvGQQlU?=
 =?us-ascii?Q?R66d4UaeLvGwVocPGRZuNUY2/xh4CEl6KYDA4Ni1+qkDezGyMHdmcDHmJxSu?=
 =?us-ascii?Q?TOF1g2sGMEdXu6AmszDTui3Cup2JgZUJ+jphoGjbZaw4ongfnl9U2T4sp+Mz?=
 =?us-ascii?Q?rycmKsB37rAPBZEHAQq8v6NaVmnqjl5Qk4IJ37+1oPjGys7mnbSRSD1tMApK?=
 =?us-ascii?Q?o0puFOEUhlHobHzT0tnG5QoI+XHqdOchN/iatnpv0XwzrvEZCeDN8WDo/xpq?=
 =?us-ascii?Q?di9Tw/ib0JtbbQWIBC/3XOeiSwWPsT3EHEr8J49ACDDYxZ42hXv9DRNsDws1?=
 =?us-ascii?Q?RFjXK/gIsB3+Imo08itzqzrBjyp0wXP9rgrLQX0JjyoFEgOa5nM2ePTa4onz?=
 =?us-ascii?Q?Bhk+mtPkKNlj0ntzXkzXS56NSn4EDKm8wQ8KwxPMI78AEMDhT7BRHt1kFJ9n?=
 =?us-ascii?Q?ghP6uC0HLdCXZueFBVTvmDAKq6KFFZyfCQdYqusphUg5k4HJwO3fPGUfsq5V?=
 =?us-ascii?Q?E+TVTF1P8apBSqULGvmcIk+YdjDCOWw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RSLVyh64OH3uKHgUcp9pR5VlK6KHV59HVYGvTB4hhDQfGMB88idVIZyAqtXY3+h9cn4zl+ytrpOFibYYOS36dRAPgFLnZBVCneaXaMbNchMr9efoGwTQlS2zE/e38TsFBrLgLbb5UsZ7ziZOu7Anetv+U5Jzo2wdtOAuNNq7HpNMJBNxqE/58gtV9mGmm+BAsKqmp/bUWMEcB4jLUIbUUqAAniIUQgcNTltY1peKKmjsKQdPAqhnarQu6ub6qCxUyVM0FmvgtzwEZy0XVDVOe3FMcoersmPY0EB+uZ9ylU5U8fdv3CJRjgb6pUtgPSl3RyN9hvbz5x2hZtjCAnJZF8LK+tcPgrHezo2ukH356B2deMqbee58OcuKRTaZ39g55LNSIlMbLMdnqDyhTaebYWkX3l+HcnBj2la9zI1k7X4+qVLm6vhWyq2bNvQKc39atackDYeISaPQiIEc1USGrEH+GuSm0Ectd9lOadHICPuPiC884K+Qd5TrM92z334JNTYxkp/P6o4lJgKX7/o0IfeGrrpYAEwROoBnPOv8ZNVKPhs6NjgOkfyuT3WzPmAno/UMg33HjTGwIJFHPudUTQV8XQLwYU1MMAuzcxshrzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef14255-3412-488e-238f-08de574b765c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:11:15.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykm15YJ7uAmgtZ/Thb0myJg8BQ+izvD0GbMuFymbpcUFZpeL4rk3Rdb1SVO0AalrmJHVINx26eWPCaNwYMBK+uj3o7M5KlaV/MGnoJQt78k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MiBTYWx0ZWRfX3Ll3Dpc0G4si
 uq/QNExyvmELp25Du0TWjYJSbR5if3XFbQUboAgZj8oy6cyesbLAaLCohtkZRukUhpmJgBAX9ew
 g9FK7FDJbuR/No/5QwsqI3sYOhpxLgf1oM65YUJc3upjXdCgNujsNiqWkOGxfc1CbWNu03vhuDo
 Nci07VBmssLvaf8fRBAyJqLFeU/3arTfaQ8YodqjWN0c8dHl41CViEwFsOl/os1ZGpFDuYv9urK
 vPx3rezHWPLC4ZFewSQmuOkxPwf4z7VuZwXl3ridxAAx/iJYfAlgBuY+L8TxjUFsHJQndFUNQ7/
 3vi5xIECx/1Gdk71nMnPAznxG6UCrBcE0eqADGOnrmQqAX5XUmcvY8CjDzUTNFoIdyZKOmTrSG1
 TR9Jng6UjZd6SobgqtSIn987tra1ZUnaKd7ojRooyRXwOH3o8jUTEHfmy4AOqrsKKO0Vx4gf26v
 ObyzNJu6O4gLtGjvX0AR3cSBmgGRZxKWOg/Mn7t8=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696e1157 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eyRnKbbfnRT_ddGtOXsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: HSGAOD0geD1QY3dQgbBGSffIiLlus0C4
X-Proofpoint-GUID: HSGAOD0geD1QY3dQgbBGSffIiLlus0C4

On Mon, Jan 19, 2026 at 08:59:01AM +0000, Lorenzo Stoakes wrote:
> Anyway.
>
> Practically speaking I think there are two ways forward here (not mutually
> exclusive):
>
> 1. Implement something in kunit or similar that explicitly tests
>    get_unmapped_area().
>
> 2. Add a _new_ selftest, named something sensible like mmap_hint.c or something,
>    that runs only on relevant arches, and does NOT try to do crazy stuff like
>    mapping the entire VA space, but instead simply tries some trial unhinted
>    mappings some hints in 48-bit space, and some hints in 52-bit space and
>    asserts things are as expected.
>
> If you do point 2, please please use a. use the kselftest_harness.h to write the
> tests in a nice way (see e.g. guard-regions.c for an example of how it's used)
> and b. use the procmap helpers in vm_util.h to check on VMA ranges, you can see
> how they're used in... the merge.c tests you so deride :)
>
> If you or others do both/either I promise to dedicate review resource to the
> series(es). That fair enough?
>
> Thanks, Lorenzo

It seems to me that the va_high_addr_switch test is already asserting all
we need unless I'm missing something, so unless I'm much mistaken I think
simply removing this test is the right way forward.

A kunit test for get_unmapped_area() (if possible, as not exported) would
still be useful, however.

Cheers, Lorenzo

