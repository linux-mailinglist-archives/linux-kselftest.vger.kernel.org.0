Return-Path: <linux-kselftest+bounces-38371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D75B1C46C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A3A18C0438
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CD2571C5;
	Wed,  6 Aug 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q6W84D7V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WMCvq5ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3112A145346;
	Wed,  6 Aug 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476675; cv=fail; b=bYq3YyUpw9weZ8i5L+uMilcr8b9mnZDecSkY1+MyFpHnWISX7bjr3Kk8T6q9X98XXUEsA2/5A9Zys/YjD3zvdYbipB5quy4xZBhASEqj/vcCRRRL5wzoZQm36YAJSgXVGrV9hqnDuYSz8Tb7bKJ0+doodQl9Ke1IAAwHZ8jRX2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476675; c=relaxed/simple;
	bh=tBgJqoHr0eqoaY4R/mc7S57cTlJv+WGDu/1CFi4cHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8653L3JpOJJpnplzNU6A9rZDkBxmEndF7KDVghT0XBwTbS15tpDL7lwkWnBXdye7k6BlX7wN1awgvGuLe0AU+MeVQC8LI3sZlsxNmG2GBrfv7VLGlfczGi+i9EtY1yDscK2kGUh2A+eHBc60pKlQC1ngvp3v3N7ou1XEC2LvdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q6W84D7V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WMCvq5ho; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768Riid006323;
	Wed, 6 Aug 2025 10:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5zLjBJCu2tSm4bgava
	YUjWzFXqbD6w7yVVobLSA263g=; b=Q6W84D7VGM4Xgb4DxJUEPLp4wy28c++q6y
	DzjXDxdkzdB27HNjK3nACufqp7VDAFJDsYCUYlOJ56kpfoAf7Jmy5Q0Y40mwGdyt
	4DgR21VPGuCpSMeXfSJ3TD2jGBdhJCjr5SoiHkBBvzk0HLNKKWu+Btt7diERolhI
	+zQNU0ZEtCMwd0vZB77ook50fL8JJlA3e4DcNsbstwvNLSkLUa5QgaWxmrSXxeaa
	hr7GME9uEBgD1htTUj9pXtdVi7O4fYamCQ6RASAarmAmVwFAu7UdMXS4FLvcnLaQ
	vev6bNmbdbjWSaKldhSXq9qtkJ73q0omklVGor3CFkUQszyIlzew==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve1dc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 10:37:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576AXpwW032063;
	Wed, 6 Aug 2025 10:37:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqbx6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 10:37:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwWzd+2qXi+ExkIDSa68Iypxg1z9urrvCSH0iCpId0SV4x+kNNKBS3BURP8BHtHPjGxtamHw50XkvCa3AUYxc13vseblNESQ08hb8LMSFEFMrZ+KDDxFUAJxMUA/AfAUp4d8JoFccTkEU6JSM7eQu6nRw9+phNZTM0gqR8KDyJZb0Lbk84vRk85x47gzXZVvrgFpQWEW0v899xQYxdu0YDgJn66Cq2oEeM+XMd3ffheFTP7Okb+sogkoWPzVwq32LI5zo5iaj1X/S/Bss61qSkxshDJ3bIy08ovT2idBxi9y0hQgbVknck1EJpxiy6cFxRA8dR7j2hidCylRh2A4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zLjBJCu2tSm4bgavaYUjWzFXqbD6w7yVVobLSA263g=;
 b=MQK027GlhWZgLvhFktKx3kXU8o4bsAK/PCdbgzWEi8/yjNqYMM8LEk8XKyFGbvaQG+9H80PHBdvcr9xp3YNyU5ANCBDNn8/HqwdSlnqW1dXYOuTL6lBGumHhqjkP55TGTWI6qZ0ZKqrugXfMAGD0znkt3tMZ95jym86S508QF1ppBwPFiwebo6DfwGB7vKLrRXx6ZseJGOkrnF33A5wyDdleloWFVGH4La/wKmWmvVst8oi8cvKprvoGT6a+O3ZoFhBwi0xbDFWL4MlhQRwMORZbJ9MU93rI6xIZVvyR/SyhRNVM7bEI8Q0VCNxk2/6rJn79HcEUIM/MGJwau0bxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zLjBJCu2tSm4bgavaYUjWzFXqbD6w7yVVobLSA263g=;
 b=WMCvq5hoQ0+edk6PkfoGTEFm4jAKm8emmTPy+KnVOifjURCy2/Iq6mt37yiEADJNB/caJ78FEAdGU/Ak2MERhUhtyBUzLK/mLrP/wq3mlslL4v0ZbSC9waS4P0uRG0+cBQHhor+UKqQTfMmGQVouhJ16ddaUXNYNQ12HnHS0wwQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7190.namprd10.prod.outlook.com (2603:10b6:8:db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 10:37:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 10:37:35 +0000
Date: Wed, 6 Aug 2025 11:37:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Zi Yan <ziy@nvidia.com>, wang lian <lianux.mm@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
        Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Message-ID: <ee51c074-c061-4bcb-9bd6-c25e6d286655@lucifer.local>
References: <20250805175140.241656-1-ziy@nvidia.com>
 <7eaa1660-06d3-49b9-ba5e-28df1c35dcd1@lucifer.local>
 <6E5CCF4D-CB63-4E4C-BEDA-6FE533E0DFCD@nvidia.com>
 <dc139b0b-e461-4edb-ba1d-fc824f875142@lucifer.local>
 <vahlhhwb3vh33c7nh67usxfraeotqq5pw5cwfak5ke3ysegv5l@bgtlqmv2wqyf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vahlhhwb3vh33c7nh67usxfraeotqq5pw5cwfak5ke3ysegv5l@bgtlqmv2wqyf>
X-ClientProxiedBy: AS4P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3adb42-8e3d-40e6-7267-08ddd4d541a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/mLRVy8oskO79FoPcS8LRvdgeGc2JegkKWzmFEr2eGLaXTINyWUka3Uxfh5?=
 =?us-ascii?Q?nIpLdJW4NRLktc6RAjpNY3lc23NMUQa6CITWaN+mkAaVCmWi+uXoGRSo1Fsb?=
 =?us-ascii?Q?yliT4t+legPMwCdz14TXQgZjdRN8s/bpag1kVRx3RKQ07HODqaGenc1Q6rwa?=
 =?us-ascii?Q?9rjrYfvLqmGMTbjL9XMY9uXTx7TeNwg3zx/UOi/R2kcHdGyfAIMZEwFx2oph?=
 =?us-ascii?Q?JOXuEFrvNS90iDZnAFAWqCITSBamYWp6bFtK0aZv3gJlVegQd2T6zsgRRYUa?=
 =?us-ascii?Q?HYaMf/Yxw+6ql3qXv61u/0OhlVrFzoPZnXHrx+Yt12uZe979vLUkJWEV9dr/?=
 =?us-ascii?Q?tHMRXBC3lCcI0KqZ3Qh+rWqGCPXU8F9U5okOrcDoq/VzX048HBJeqgDgFl+l?=
 =?us-ascii?Q?BCgnc4j/onkqX94HtDzEfo4vP2YZBh6RCccoM4U0rC02BlGWiMA66JLAU6qY?=
 =?us-ascii?Q?hA7zthut3aw5JtTCmGrcD+alQdNlLoxtrCFZDrju9IoSekibhJdUog/DlZfM?=
 =?us-ascii?Q?Oh9lvXhhftBNOjqGRY18SwRl8g9I69iSCnAB7SbEOkunlO15rn5UHzOm1vqR?=
 =?us-ascii?Q?JPmdppntL4nIDkoUe/ORBXHEuwIijXMP+bI+IeDvU+2wd5YZ2ySfPgwY5hrS?=
 =?us-ascii?Q?sXliV2TrMvR8soU1twOF+EL1pnM3q74d9Ir0ujo2h/FTcSDz4Q21ST0nDRLf?=
 =?us-ascii?Q?jdiGZ0x8o59H2GeJPg7Ow3qal/ol+4o6qCFIABAcc3e0mHbqZlsW3TgLXSpv?=
 =?us-ascii?Q?5vPeXC6FN5Kf6sBbA+1uxxKrtnrwtDC0ZYcCb+xnGKHIh56d9B2Vygp8+Ukn?=
 =?us-ascii?Q?P1tS2hrEkix6uml+IsAJz6traQKKnIMstYa351Z94uaj/hme9E1GKlQpFN+S?=
 =?us-ascii?Q?44lNRaCZTbtys34d90YVU9azhZE6OVFflt5MI7X0+ISNx5cPoNx1iFJLrlwq?=
 =?us-ascii?Q?UHOIrnCcpnUByURmTLqrkwZj/R27XWUZ1c4DcMOauQNWaTE78Ot61NhAxMlW?=
 =?us-ascii?Q?iLqbDD6h8UAIG8TO3jYz0MPpV8UEJdppDr28NIgKBY1lvcl5VBfyEeg1qj/H?=
 =?us-ascii?Q?O1kvRaG+u7siibq3j1oISwfXL0nPp+k/YB0nA0f0mZT0ZpgQujcYpmpdKHOg?=
 =?us-ascii?Q?Ns49yhbUAmmNXpdhxC6mHMiO001ioKnJAs43v5MWfDne+ea2eManzuSOTEWT?=
 =?us-ascii?Q?evYYrnsTL+A6KyyLZ3Ku+WRYHX62SMDY9SAZqJS/XAWotM1D33CLJ2hNQbyH?=
 =?us-ascii?Q?fZBTAXXTV6lRZdxJDu7tRZD2TF/hAr32hV47y2WHNDRT/Yc0Mecn7Xo+ezJR?=
 =?us-ascii?Q?sbPnK6WfeF5PK+nDHXLbewjjsTvBFjy+sFPVo4VWMnA5q/U21Tma48WNg8iK?=
 =?us-ascii?Q?6o8t7nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtBBLvqgybdjh+Bf7MJhetCI0D+BT1TLXZi3pH5J5A463H3+x7ZcOXbgBQwe?=
 =?us-ascii?Q?zqT6IwRWBxCgU+19KyObU90puca6zSB+LO2ObBlU/qkGiWfN81EhD+7B0yT5?=
 =?us-ascii?Q?fi6srWOp8wSLcoIRvmLGLFF32WJ6wYUH6KDuKmBfJAb4EremaUP6qj4oYFs0?=
 =?us-ascii?Q?7Ey8TCuxZ+bOqsKMjvrL7qiiUoCw7k15+BvkoAyorJR8wsa4qS7RyhlGBhPL?=
 =?us-ascii?Q?br/cy95uzszjkhQ154DOWkwLFjz/uRM+sAJ7WusE/T9j3GNdgVT+hfceOR1Y?=
 =?us-ascii?Q?j3QHB0WgrgiJ8Q3FhwJTHZVb9AYTzk5YKctEXLrXMXECUKr4ql4EU8fOIqbA?=
 =?us-ascii?Q?W4FJxA5wxJ7yA0x/HC2+F2vZbBXPcE5CU50slhIf6VDhDQHqLxu5MrhiVOZ3?=
 =?us-ascii?Q?IEi++ivs78L2icMTrCiVF+5KV2Ywh9K/SRtPPmRH5QMVzVTjaSQUVzInb8PZ?=
 =?us-ascii?Q?7aHoncgJsQIhw4HEaSyXt/bVmEiH3+CJ8eZYaTP0LdGuSTHWn1ohbVreg4MD?=
 =?us-ascii?Q?Guwp7p4MneG3KktKvo3RBG9lO20pkce8x3yUtm8o0aaphuMy42C7Xw4C5bak?=
 =?us-ascii?Q?8/ahedNRCyG3YIcVVKbWoKwanGqWDaNtxXn79yPDN+AlfpGMWbs3pm1GzFp8?=
 =?us-ascii?Q?Pya7kViAAfdn+YehTiIV/T+RqnH4pIEzhohLldFGrvHFKwyUxk+gcaxCIphR?=
 =?us-ascii?Q?jXp8QJ5+b4E62Oj0r5cZj+pjoGgLaeArzMh5IVfGlyT5QcOTVXSOS/ajDMAt?=
 =?us-ascii?Q?ABrgEVrr2aEryNojTkkoafKdeEfjYDdkIP3jBgjunOaKGx7oekK7G/7CIM19?=
 =?us-ascii?Q?XuCtUbJzc5HLwHwGb6VBFY759AYR1VAJefSUrEuogGY1c/BpYFsCrKAG9+NF?=
 =?us-ascii?Q?nUsJTcHaE+nLME61Z4JnW//219ijm0qeeCVxz6iAe2wbqfMWYCld7iFsFaon?=
 =?us-ascii?Q?b7F9ZSbjqGOzEmxKldLLBDlWq+QsWCh/mzkVWUXaQj/f1YqmLNEpcM1t8C7j?=
 =?us-ascii?Q?ZC3iQdcsvG4Jog1N/L3MKashTwZMxhMoXP7wU17iaoTUGmpjTugGkQabczPf?=
 =?us-ascii?Q?55bOPwljFBaDhZiRSgXXNKPHZ1jPxudAEeiIKeJjaYcTvFdI5luX17w/pt92?=
 =?us-ascii?Q?r6/5e9EqaM8oDpm4Z+35VCeh6P2ZYDUaEyXFHJwAWxWxpCUTBPskxWCr0WYI?=
 =?us-ascii?Q?To3rS7mWmflLYwK7QoIPZAjrgO/AtnbKPwAX161iZKb3E/4/tGsvA90MRd1e?=
 =?us-ascii?Q?1iBx0NyE60NSpLdyALpzI3ixLgMo4BZ9sDfvYxu/0wTQm1NCt5Qd5oUZHuFw?=
 =?us-ascii?Q?ETW8HzvYkenGxWbi2wUO0n294DxvCg81z3IMwJpzIBslgwQO5wOX+Rx/2O+q?=
 =?us-ascii?Q?mhOGaw6tqPPgjyKoQE4v6Yq6HKe96jvlV7e0vGpsOjPtOP698hRZb7qeIdd1?=
 =?us-ascii?Q?2/TD+Lt0a0ocZd/NGwXJ0JJZeSB9vfZm2CPrhE+CcM8PZv3OuUMFCkFwn5B5?=
 =?us-ascii?Q?fHo7Fub1o+Q7RU1YmHCAuLLtDpoubosewAIu7kFDwwxezsZxDF2orF8FIzyj?=
 =?us-ascii?Q?LflV/I+D1Y0fzgbGQEsXrWEEm27aPVU1HMyy3tpQlq/uO4GjwjRPxpWt1rdS?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JChfwzduuf6r22oTzbXCh0V924eKdIuR8eF9O33Pz+S73Sj4EBVxAFjvQNDoP9KpSscogAb7FMpGLs7xJsd1Jhunql1ppU+wAlnGMR/fEySybA8zporsHcOKzmXmB0GHOEsI9aBPv7gWlN6q6mEx5zPufiNQelhB7dwvgS3vjOh1gg7wGKirqw652jQjQs/lvPoYvxM3KogEfAwX/BcT0sY8R0Ue43zXcvZUIg9FxgS6EEEcjDbpp0XUlw0gkN7NPp/BVyneTq10xgCk64TAS8z9oliO1OCW2wdPyQb7DEXYhJ9gMbUI5aizW7yk7NU5BlWlFxPnsFdbEgjLdgfUmtn9X1DK1c24ywXXwdaEw7pMCTn6TH7AiXK//YAiH3dyZv6y2Iq5/9fNJ6esBWkUL1XWxyjWANbSV8kg6CqjabUJwRwwGgsvQwm8ycWPo0/zhPpQUSdj9KCpGRAJwC2Tlz13+1huXFyPXy2OQjHE9gybyEsatEi4PmLIqGBow0HN7wvGNmWJrVyQ8UbgHmIQhBsIKJSetwjqq/ygTBodta0pKMHd6KcK0uEXz0JYk2As05SXTpo3KyPShrw12p1TPoziWnu+Y6MhpOssBInpHsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3adb42-8e3d-40e6-7267-08ddd4d541a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 10:37:35.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SD8FYqq2sAfcyGLyJtToaWUazRneni9VFTJUeTjuS6WjP++00ltyUv78JoUzl3XybybsJaOAP4WwG17ZT0qarshZOLR92Q243HvHVPHZRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=921
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NiBTYWx0ZWRfX0mVdIyqI89ZC
 HczffPCm9gGa9S1Upr4jbvSLLNhpeyBt+Vncf40qaRao9gOl5KiE8SgTg/loBkGfJk1uJU8ueAF
 92S3ylQBk1fK1EQs2Ncjc4yErKapVEPDQni4OF8TgnKgrBQcSTrjSCVgIxV6PkIbHGC37TAR2QG
 4QA5hSsZ0mbjK5LwYJ12/Jve7OV7U27jXwbK3KHvpiZ9tqIjvQu9aSBB+nVqqYJyTqlP9FW4M5S
 pal9r0CDjItGjZFEYNol7MLqan/zYgEqoiFzfLLc6HL61M5YNJB5zWmTIbA19H+yfJgQzMRkZSk
 XgH7kvPWXU+nj4woHMjVgfnqQgnVrvlkwtKMo+nBtZ+We2Nzu+Qx/6CvLsqbecoQEw17evqztbM
 eXERo+oYu8mTmc/GH+o9ZBL83iTAU6n0YZzhu/cHes4LUzPC350VAVZaeGLtkRvJ1oC8ZoRd
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=68933072 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=PeOOapuUAAAA:8 a=t5Z1ltRNYdm_kn9AbggA:9
 a=CjuIK1q_8ugA:10 a=0BaqRfgCL6CLbWgV2pdm:22 cc=ntf awl=host:13596
X-Proofpoint-ORIG-GUID: wcs3YW5FcCZQKVDuasUuuSK1HVCkJc4R
X-Proofpoint-GUID: wcs3YW5FcCZQKVDuasUuuSK1HVCkJc4R

On Wed, Aug 06, 2025 at 11:34:57AM +0100, Pedro Falcato wrote:
> On Tue, Aug 05, 2025 at 08:21:23PM +0100, Lorenzo Stoakes wrote:
> > +cc Pedro
> >
> > On Tue, Aug 05, 2025 at 03:09:54PM -0400, Zi Yan wrote:
> > > On 5 Aug 2025, at 15:00, Lorenzo Stoakes wrote:
> > >
> > > > On Tue, Aug 05, 2025 at 01:51:40PM -0400, Zi Yan wrote:
> > > >> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> > > >> index c20298ae98ea..b55d1809debc 100644
> > > >> --- a/tools/testing/selftests/mm/vm_util.h
> > > >> +++ b/tools/testing/selftests/mm/vm_util.h
> > > >> @@ -23,7 +23,7 @@
> > > >>   * anything with it in order to trigger a read page fault. We therefore must use
> > > >>   * volatile to stop the compiler from optimising this away.
> > > >>   */
> > > >> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> > > >> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))
> > > >
> > > > NIT: but wonder if const is necessary, and also (as discussed off-list
> > >
> > > I just used READ_ONCE() code, but it is not necessary.
> >
> > It's not end of the world though.
> >
> > >
> > > > again :) will this work with a (void) prefixed, just to a. make it clear
> > > > we're reading but discarding and b. to avoid any possible compiler warning
> > > > on this?
> > >
> > > Adding (void) makes no difference, at least from godbolt.
> >
>
> I disagree with adding (void), because volatile being properly propagated into
> the type should hide any Wunused-value warnings (because volatile reads can have
> side effects, so discarding a read is most definitely valid).

Yeah, I just wondered _why_.

I mean this is fine as-is. I believe Andrew's already taken the patch as a
hotfix anyway.

>
> And as I was seeing in https://godbolt.org/z/jnWsET1vx yesterday, GCC (and clang)
> can silently drop the volatile qualifier For Some Reason.

Ack, would love to know why, but don't have the time to explore so was hoping
you/someone else could figure it out and tell me :P

>
> --
> Pedro

Cheers, Lorenzo

