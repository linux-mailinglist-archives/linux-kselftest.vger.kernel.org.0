Return-Path: <linux-kselftest+bounces-26850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C35A39D14
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7711E174B23
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FC2690E9;
	Tue, 18 Feb 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hXU8sw9L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ujlO+9lS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9182690E4;
	Tue, 18 Feb 2025 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883940; cv=fail; b=JpkcOYKUNkT1Gpd857XkR8KdTwz6/nI8817n6inQewuGQWnHz0SzWgI8QrvBOhNUyVT5ZAXsGXVf0xjkeLnreEaeiJsnJVLtz/nYhVl2nM+2uujFfv90oCn9d6lDgXM8mR5dE+1EZ62upZNGzPBMqc1yOyr6JxNpazbpA62JxO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883940; c=relaxed/simple;
	bh=lGosusbOjC9WSS6R7M1czGnOfvu4VeSUVnzA0ruoVr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q6RS9OnLyD3NioBOpCwZpWAGXVPcoI0TuK6yUAXQV1qKRuAfXceKDKYzmzMppr8taRsu7HCRZfZHZLUbBuyjMyo9zCFp23Ydjcdt/wnqndboQuEZ1EEU+w6R5ilW03vCSzRWvhWN6zNlX0DwzysJsIQTpxBKWnzHpiLzLBLLIjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hXU8sw9L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ujlO+9lS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBqYIY028093;
	Tue, 18 Feb 2025 13:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lGosusbOjC9WSS6R7M
	1czGnOfvu4VeSUVnzA0ruoVr0=; b=hXU8sw9LrW6zhYNbjexyQdqeT+vkMpKfY6
	xDaNCKx+NPDf3xdEDKJCuxLF4GGDJJroOiRixGqEBMGTL2sIzLr5Y7padVHwWjN+
	J0toO7ZevbblI6jOIUvqS1UNZaHg/XkZlaPLr0WoZypiWnwy63iXt+6+TAFS9eJa
	WjnZHPcS8nwvHu4pu7phBMSASgSi9D/1YmwxTQhm825Y3Htqn8NrsCaUdzlUkQVx
	/C9LN13kfwW9OsiEwmY+V/U5DfqI/UzzW6Ske5KonoBqh9V4lRQrJ+xk9xhcDF2S
	v0hKQe92C99HRWdkMtRCiLanmo9Jm7HHLFY2yWx1FY9xYh2UAHXA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thh06esv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:05:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBCMEX002043;
	Tue, 18 Feb 2025 13:05:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcf9pe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4dtMA6ic3PRetCZGoCVu+5dnZz7N2uIV40TQa7coKh9kW2gZCe+0KURVNIg0rrfS2n64d6ccS1pISGiQZvWQIfBCgBqus0H0Ihn6jd6DrUiDaq7pt2zMidvK/dQm75zpuC0h3aqRO2SP9Ur4Y+YCftps+He+ZEZO0sm825gfPHac3c2kOg1ON5ZdVTwZeL+XchzYbW8hdcaqa+ZXWZ3L+eO0cXAI5gfa/M0e12sjyBg0SZzm47OLcDmUV/1xzmPPUXrCZ+KBl6QHdclnWSD/3deoEdspDege77+n+WvmzZHOic4DUjbzENh9EeqAI/h3c/c9R2JwSjAvn2Ho3332Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGosusbOjC9WSS6R7M1czGnOfvu4VeSUVnzA0ruoVr0=;
 b=AuPxoVTc/CiDIyZ0H4dIgO70HUZjew3G+g3/gmhs57SSV7jBiJ804wKX8MnM6y0Y6PgZw2V7ypoiqsMy/RcAmqUKEYsA5Ne8acJB/I4h5qBDrD6yhihe9BKuGdB4K8TLUG2e9arzKD0ubyExz7A1t4t66kVgHPA65x4j4OvD3low30REKfESupTP8R1GevZtApPrMfHX5EHkIcdiruNJnPUlrJeO0fjEAtDuYs94rk6lQgZFSr7zRW0HYBq8Ug+Q5n1VotExXz6R91/PTcMYdDacCY/ZyE5etuGU484JNExCBr6+zN5VCzPGzRffnCxPi+xCg7X1No3dX2RuBm7dWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGosusbOjC9WSS6R7M1czGnOfvu4VeSUVnzA0ruoVr0=;
 b=ujlO+9lSUDWQGfehdd0AMIdglYsjw3U+3nvgVvqNr+hyk3DUY2cCIM+l2N2iNdWQiPwPEiNnumI7ZdbqGDDVYlwftN8vw4caoEdDaYpasLjZ5/ROoqr6QzUkF8uCBXzprrUlPK0MO/vyEO8T3w1qyNLrbvxLDTXIhVTKzSBoBnw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 13:05:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 13:05:10 +0000
Date: Tue, 18 Feb 2025 13:05:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 033af739-9056-4a3f-c058-08dd501cdfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1QqIP7zkMo1YABEjXdli3menf5xeLorZTF7yDAYlVRb93P1zxONRlc4mBcY5?=
 =?us-ascii?Q?BXa03Fj2H1kX+QNtsc1vtygzD6b9pxMfBcaJ5iT32s2RfKeJ7eeuvIlGLSNQ?=
 =?us-ascii?Q?98fOZsm2Hzq8tlCOkhcy3O3nNm23s9Ph3UKCnKqGF/0awz5T2LB62fPAR8gZ?=
 =?us-ascii?Q?U7nhdEfG4sm8MLbqI5F0wGiVFO4gPdGKkhGP+gflkx4ih2U+uR6wPQkOY+23?=
 =?us-ascii?Q?yIxMbX9Lo+klT+S0zHWSMtTOqAXq6rF/ANboeRM8jD6aP7oYJrPGJpVexy1O?=
 =?us-ascii?Q?V7l3JHP36aazSuMOT6KgBl3qwzcB37A7zBFU88k7caAwTkRF5+HSlWi784tj?=
 =?us-ascii?Q?0y/t0/wf2lXklh1WIka3bmsBXlotZfds428LG40MQ569gHgO5NjKM8oUil+g?=
 =?us-ascii?Q?ZE8Rz5MzVkEvpVPb/8LzvRZXZCAMevlvcjyW12vixCtFlp0E+PXNdgjo2uCu?=
 =?us-ascii?Q?7faQTv0MfToxICNras/HDY2LifLTwKGS3rfpbbZ50ifBtzwNRRt599/E3JJb?=
 =?us-ascii?Q?bRTj6DM4AA6tY3VbFtAXOGro+6BTQgfGh0GoTKef7sErTaCCIWAjmSQ7ipgO?=
 =?us-ascii?Q?QGke6OwC5o5IuWufFSHC7XSMIDhG7fIufDCAQe30SZAbApkJ61WlTm/y7f36?=
 =?us-ascii?Q?O+nhvBZP3owmiWcnn8vtQFmCYJ9AwsM49DbmWq1pws9Xv8WeMIi6KKwF5VOg?=
 =?us-ascii?Q?nN4ZvweTuchOsbc1XsSl73mUUY771HDw6dp/f5RLA7pbIIG8mXSkTUCJW8Cw?=
 =?us-ascii?Q?8Q0+vqmsWyIxDboY4ETQWdn5GGuRXG3iZNqhZ7iYWcJMn053u4Bil0M+DE1D?=
 =?us-ascii?Q?XJdTGFysQAyodDxf9/YJtJMII/qPiDDwX/Scd0OIzKx3LQni46bhShfy7yBL?=
 =?us-ascii?Q?dgnwKmIZLA/BHIHqG/AbPKAsl8s+da0/AhvQg8fNs+s9mDaltkia88wsf5IQ?=
 =?us-ascii?Q?HAU71QguAZhOoefFBgYTfyPiL8XBYt3PNtJPCLWPrD1X0SPkdbUfGl73U/Dr?=
 =?us-ascii?Q?/sIOCi9SG5O0WYYQyUiTH9BUOI7d080nXfeVA65AYr0MsRp76Jf1B0UzawmF?=
 =?us-ascii?Q?ncAKhS3HpDFslKpp2BscJCbGmBpMXhAlwBhdfBL3kh9N5dMDElMhTQb6CDVa?=
 =?us-ascii?Q?COFIMmUL9TASUYWE5b5VQz/ghGTCvIlnTkAr7QZAJCnr9tn1Ep7Oxaji+bGL?=
 =?us-ascii?Q?+1lsRQp/Ki2v4s+7JodudoGxeLnoQ5KsW+MtqMwqfzGnOuOWv1W99IZtVSma?=
 =?us-ascii?Q?XLQ0zKDHhaY19hBPly5Puj1oQLj1bMPfhHa+kBoTV72X8GtIXp75FfYA/uor?=
 =?us-ascii?Q?YWaHeF9X6LNpEC+0nRQJFg/mN/ofoWJuu/RU9USz043DPYBmzdMc0DsUl9h3?=
 =?us-ascii?Q?qdHCJhLHxz+2cjwUZasU/haHJpNE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qks8Aynh3aH23DDtv3ch9NZdtcf45/+nd9j9Ruwcbr47ifkguVnN+8/WfJS5?=
 =?us-ascii?Q?nAKWBAFapAq1EBrAZFR+F2N0ADW1e0vQfYPpxex/C/bVDZJf+EszudhheQwP?=
 =?us-ascii?Q?tsivTjXUcTJf22ifVEI5QDdeF6QtptC8oMYDVQ+ovu+12PX2ZrM3dzj3HqHQ?=
 =?us-ascii?Q?4442ZqCOAFbiw+FlvTBD730YAY60cIKE+VnS1jDwaUN7ClauyIJrJhNcQFKz?=
 =?us-ascii?Q?O4kv/JR9575K9PZG/Pk1UOBX1IaNKX5mNDSHRlsI5AmcoSen64QWv/bFkU+m?=
 =?us-ascii?Q?Snmcy5xPknKGswJip4UzoZE3m+X6RXd+cRuVM0f0aCQ4/W1G5UcSLENuE55/?=
 =?us-ascii?Q?XUgSEPBaxwrAO2ChyQkweVX53VcRWRcHs/37RpmaZbX1LXTXV6HlPgVszuz3?=
 =?us-ascii?Q?Aik8rhybgZkkERfc1GwvMK2BFecJ9qgxtO/akQkOMgI4rIacIBlX4IOAJsRm?=
 =?us-ascii?Q?djRI0Z0kr+Uh21J8O0ImhpBox52EGNh6c2i2hcnBSOswQI9tQeUTMRAGgiq6?=
 =?us-ascii?Q?yqA5+B/SpmS046YVfdbmHPF93JnmjaTW1UVh6Od+dixDhud0StVLuLPaKArj?=
 =?us-ascii?Q?HBH8q9zYqjVOipmWiw6+P0Q7JPkmUctNa4g3M/q+0ItuZDpV7U2lkAdskBja?=
 =?us-ascii?Q?4r2GIoMKV2Vxh5uS4ffBG1XlGrRu1xiPTT51iO1cC3WCNEEnwIUQzYszYHYY?=
 =?us-ascii?Q?7v4cE4z37VueReSABnsZyhGjCOdCN+JMSe9HPvfVuJz6hAo0JNZXvVCQsUPY?=
 =?us-ascii?Q?Q+J6d8FKqxhelC0NOK7yiSA9wxkaKHMrBWTylFHthJ3pVeAs5L6wVUcpovlB?=
 =?us-ascii?Q?LexBl6QOzg3uTiZtmgVHr6u/tkQ4uVHUKmqYW5FbrxvOUzsaAg2emJXjKW8x?=
 =?us-ascii?Q?dovM/UcYGCvUqG09GYA5PGGYBJAlFvxiljNTGmK/k27OVWHap6W6RQk1rhyU?=
 =?us-ascii?Q?SG4vxAc6M6tKuistijMg6gb7AGduB7RCSa1jiuXHm0ySMZYB/imEFRjDJTHY?=
 =?us-ascii?Q?bst+trrjMDEWRgH1VE2s7LQy8YHzKbIKQhATcaac4cVqsFyB+hnehgUQa9Ww?=
 =?us-ascii?Q?1liASiVwOq/74rZgYC9BrTL/dntd73utsu6K/MjOuvTKJQQTmHSQxRjvpaBk?=
 =?us-ascii?Q?hlt8f+k3UXOV6ZX9UcLjqQHArE8xS5xDHH+TB8La7Y5Mr83Ti6z97ebjXoBd?=
 =?us-ascii?Q?Jdh5o1N0m3cmJNChprA7+n+SFvmaOrBq+fYAh3NLJ34rpOF2/fiM9dF1m+2u?=
 =?us-ascii?Q?ciy5fqXjuaZB5WSRwngFh6TRQ29rBo4dPGuQlGuTN6Uv9catpJOJ68TkLi7/?=
 =?us-ascii?Q?LUtu4FpJaUH8lEpFEppcQ7h7cw4jBFNP5/O5SIh+l+BOYaeoK1aUFaCZL0X5?=
 =?us-ascii?Q?NSD8pkBws2BpKSgJtdw3MkxKV3W9l28ae5zePvGkXWWmxZtJG2/WiWB9UX7f?=
 =?us-ascii?Q?btf0OZOgmIqLjL6Jt3tptQ8U6b1R22HSS3+Uf71d2uvAIs2ohBqwPgJNaPcV?=
 =?us-ascii?Q?ZfJ2i/Qgf6iDIJf1nlZHcW0+CM6g8OZykA6lzf/hMHZ7aZo0AKzLcz8s5WeB?=
 =?us-ascii?Q?Jn4GR2FA3udW5llJXinpzA2h5BCICZRgLzmGdQzZ7DELitkQXrBARGOzfL5V?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zxaVM1Q0R4BgyA9wgNOzSoiMkQKT9PIJrNEXvWz99Y9jXOGUdU7cIDl3jJenFAsI8/83BKs0lv+VzmbwzgueNUyqf8Nez0G1/pelhDB5SlI+2jMGMPAoA4Qyl7rZAQHloTURLMkzveuZ2guh61eFFP0Jx6g/sG3L61OxQyF0E5+BJNYEa3/ZouP/2gJPyIwkgZ1iOmDLFdYOa7ReuIr9whSGwK9SYRcTwPWMrUWgfcY8vY13aRXdz3Dj1qgSitGQhpmZUab2Hn27hkkzuTJKig20TID6jDQEXxgir6nqam9s1+p1/+2TQzDcP5jU2iw9T3f7pD2e2bQovSUgl3hdw9F3xBRujGUrNxj3yGRwSM/BflwTMIFY9kmiCY0TmFEUg8Dh4zsH4HqHiVgzx70q7MMqA2kZIT8dX9MDLBUVAbAusqFFUslGqLKfIJEzSq6G/qolKVojbMuerBWlLjSxchTNfUTZoag6ak5Rk+V7atMVzNbcV1cHEYjzmI6V0UEeAq6ei0Z/LTVGqZiFH0uvLRKXPzgvbDhIVly4eQVQD+1nimuEw58DYIsGmPG2oFUHOkfzioJC51e4RoRE/yM4RMNzyC6y3PVMLI8mahfyqYs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033af739-9056-4a3f-c058-08dd501cdfc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:05:10.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHsDtqVjB5eI0D8Ysw+42KBseg3Czc2EoG3/jKdJ9VckHVJuZKzHtM1ycpcZEvnWNaNgNst/0SIS3J4G/jLdFdwVFhNJpIPDeb+FHi4gi+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_05,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180100
X-Proofpoint-ORIG-GUID: RSra4MZmGGvgJSso2Bnyi9fX8wlv9leB
X-Proofpoint-GUID: RSra4MZmGGvgJSso2Bnyi9fX8wlv9leB

On Tue, Feb 18, 2025 at 01:12:05PM +0100, Vlastimil Babka wrote:
> On 2/13/25 19:16, Lorenzo Stoakes wrote:
> > The guard regions feature was initially implemented to support anonymous
> > mappings only, excluding shmem.
> >
> > This was done such as to introduce the feature carefully and incrementally
> > and to be conservative when considering the various caveats and corner
> > cases that are applicable to file-backed mappings but not to anonymous
> > ones.
> >
> > Now this feature has landed in 6.13, it is time to revisit this and to
> > extend this functionality to file-backed and shmem mappings.
> >
> > In order to make this maximally useful, and since one may map file-backed
> > mappings read-only (for instance ELF images), we also remove the
> > restriction on read-only mappings and permit the establishment of guard
> > regions in any non-hugetlb, non-mlock()'d mapping.
>
> Do you plan to address mlock later too? I guess somebody might find use for
> those. Is there some fundamental issue or just that we need to define some
> good semantics for corner cases? (i.e. if pages are already populated in the
> mlocked area, discarding them by replacing with guard pte's goes against
> that, so do we allow it or not?).

Yeah that's the fundamental issue with mlock, it does not interact with the
zapping part of MADV_GUARD_INSTALL, and that is why we disallow it (but not so
for MADV_GUARD_REMOVE, as if a VMA that contains guard regions is locked
_afterwards_ there will be no zapping).

We could potentially expose an equivalent, as there are for other flags, a
_LOCKED variant of the madvise() flag, like MADV_GUARD_INSTALL_LOCKED to make
this explicit.

That is probably the most sensible option, if there is a need for this!

>
> Otherwise nice discussion of all the potential issues here!
>

Thanks! :)

