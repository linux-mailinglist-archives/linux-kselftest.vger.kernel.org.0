Return-Path: <linux-kselftest+bounces-22884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8C9E5E98
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C1F16B1A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F066217F29;
	Thu,  5 Dec 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XnST4onY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MBgoqD7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16D2EB1F;
	Thu,  5 Dec 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425693; cv=fail; b=LHyBSCyRVpDS1izNs7IMtt2JlBkYbQ2YYCXQHLnhax9g1815jOXl5sEdymjH3jAlKBl2bM7iXc9GOk24POGf54V3EQj5srYGdo5SvSFgHrmbWFORKFzezxrhrX9XPX1ybuLrWDNxulblMEQLDzvzDHH/tdRQlDclN99dTkBY1x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425693; c=relaxed/simple;
	bh=aeH3CIjH6ZUoB5EEA5dLaTU4Jr+BqMkuRQI+nCUtfJc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ciTFAL2oT2KL+vUI6g3Dx6Lg+H0cUUfd1Mj+AgbMKO52UPm6g9yKjGxb+Z8FkgKfwuWN66Zd76cAI+FFh8iNSX6h/uVq+7zh32KDeeSwf4DnLtDb6PvrKE0cSChtAPridraGx6pyn/b/O4OI8Kjf+9KIRfAU12zOEqjGCCxKeW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XnST4onY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MBgoqD7r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5J7ScE004597;
	Thu, 5 Dec 2024 19:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Jw7+No8Q8NJt3qg4
	bciq81qxw2MOHFfpRoOoPMtFOaQ=; b=XnST4onYCTNeekdbGmTzgvd94m4memY7
	/DlrhPkup4oe8pIJsdEqGvF+hENtYgjN5q5IBrB5W+Z3aT4mD7VJD93yLLdGK5ul
	sopHm99ea2FdP7S5iWPCiRXqh92t5ZQnmxaNQ7FaZyEhLbNM8ImmIiZ1ibdWc/6I
	9xHV7ifhoPyT1BH0lBp1IizuzC4ZyudTFKop7I9/bMEjF8+hwY4y+qOgk0AFgCY0
	5rFwsT9HeJDR+Rlra/gnrMwPEFPN+lm/gEoHJYhIwwLzhy5TWLF/yIuqfdWlM9+2
	aX69NJK8sE2XCaKS3wBmmO+0rIlCyCPCxtVC0ZjU1Kgtw38SPuQ9Rg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sa04015-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 19:07:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HtuPr011691;
	Thu, 5 Dec 2024 19:07:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5bat5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 19:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLA9/byjZ3NppYz7JwR1KYfQJYGMkQdsdIX5prVeRSVukJzPBxlZ7rlXFUzNswmCNtlcswxC9bwRbwZ1F094oGyscoRH/tjlLMHN4bIvth1+a/C7o6aEumdwsCliQKnic92HE/voaPKR86vb+OgrOozYNmWDdzK6RnIjRXnyzdj5Vk4k5lmdtHPgdbOugvhDkQwVHz/Z6x15b1IXsw2P+fRy5zHspJiorDgreWkOuz5IB0W4NDSjezO+Yk+bfk/T44WHhQROGYLrZFuvTqSOuBWbY1qUXAUU7HSCBNWsWkytrGMXOOdOk79yVPYhFNrcf6NI6jTCSpY9XL077ny90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw7+No8Q8NJt3qg4bciq81qxw2MOHFfpRoOoPMtFOaQ=;
 b=nPJ4wL/bQ8Ta3RXriBSWVaTKqH7RZ0638NtoRBUlfHJMuPUR+rDTP9GEFcxOOHkzNyjhRTNI6qb41AFRuKu5iBGFwP2Ctv2Bhha3kzm0Vi89GgiQIashNNMGtYsvqqtUQfTh6QiICs+VALUhpsD47HWv7FFOrQkhQvmMICdm+iZ6APkCogXTKlv2BA3oZ+ZT7agUGWY82M+IIZ9G8ld+CyP4DiQaWYsEgXO3i153ky4pFLEkKXAyNgA3mvsx1GFBLSGtERuRGtsF9k6xe/8ZAs19lQjUCL8ZzPpGXWhOX0XbnN4kF4ApTDqGQ5IocpMdAzVSfa+z601CQwcJLzuDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw7+No8Q8NJt3qg4bciq81qxw2MOHFfpRoOoPMtFOaQ=;
 b=MBgoqD7rlWlcq8hBraUn5g4oBf90RfDynAeiKGrV26UMsPvYrMZFQR0bFQ49KfsY/ddYCs1KTjTSgCruhPqHEw++IJgDg9ioxJ5wo4iyjM3R4Gln6KEYQa3lWcq6F6MSjlsnPdLsQ7Pp7VrkXZbhN76189MxXG+2Q01MV4YXExU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6624.namprd10.prod.outlook.com (2603:10b6:510:220::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 19:07:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 19:07:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: [PATCH] selftests/mm: add fork CoW guard page test
Date: Thu,  5 Dec 2024 19:07:48 +0000
Message-ID: <20241205190748.115656-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 75295215-0925-4849-4d8a-08dd15601ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKoRxdyMd4PYgDvmsJfw/c1oWrKe8Aw3NbUrtLpbpXHVypXaWHg5hUVS4L1/?=
 =?us-ascii?Q?4CSKMkXNMYGGDjhui7ki1E6dSmZxpjVgCtzCUCpFkmbLx9KLkRwb6q1UDNFJ?=
 =?us-ascii?Q?X5Kg23VcUCFCqRm0lpNzJmssjZ/phgu4tGazJcqOmf8J+RUtGj9kGZt9L3zM?=
 =?us-ascii?Q?8lHeI7mdU0AcORGMz6TLUXQgj0wa+vA4/Cl3mybi47XwIuTiputH8xUemKWb?=
 =?us-ascii?Q?Urdr7wmzOm+c2QxSO6wKFInBGI8frpXgQW1pvm4QryO1rn2ClRU3Q4TQ3Uyk?=
 =?us-ascii?Q?alYzTFHzhqsvzKjXesAti+264B+ouui7W6iGj4+fbfwEa0TiPiZPFL9RdfbA?=
 =?us-ascii?Q?+wrsRGqwV5tohrzGFBWSWuevTD4v7V7qgSJMC3aqnvXpDYhPRplxe5yHG0B1?=
 =?us-ascii?Q?TeQ4j0p54XFd/xTBs4Ls1UCXC6Rwyop/k7NC9fZTgwevaZRj2EDtNFPmtaN+?=
 =?us-ascii?Q?rYRTDIucXWbNKPYTaWuwQXsx1Lmi/X18+jeVg002VIQb3IHVtpqzXaE8bmP+?=
 =?us-ascii?Q?w6x6EvaUFGsy2RYnYIzbqqIgRroPIQQQnL6obfEhKvhQ7KWetjShJE4ujrs4?=
 =?us-ascii?Q?mTbrbx3BFHgOsZUIGrjhagiqd4TZDIyh70HaJ5LGS39ekVEoUNwv9WjE7Rvb?=
 =?us-ascii?Q?4zSvMb1JNomp3kro4/7qJMxPQMB9fi5eqFczMP9pWWHT4w1Wzyga+d7TWNjm?=
 =?us-ascii?Q?nwjUqU9mhTaL5sIaylmkCRxeXb3dz3y84bfW2+icLycRTWv3NGWbmLk/3BZ0?=
 =?us-ascii?Q?R5Lmr1S7ctogTyS3b5lgDwru99logRYzoEpAczqHRzii0IFVNtf9bcW599Uf?=
 =?us-ascii?Q?PfdVYtpGxHvSxR8jMt2akhs5CTXXO0fHY4uFX/kmimfXzlYllINsg0vcXP51?=
 =?us-ascii?Q?kNFmLTrpHg0rw06/RZOU/je5oxxc9RKJZs/sCzr2V2bW8gkD2atOL6TinbpO?=
 =?us-ascii?Q?Pse/ng4W+0SzSAnwbCTVIr3fOPczcT3K1YZLmCgMlcwGAxHYv294lhtPG/lG?=
 =?us-ascii?Q?SlsbCTsV6ltF2OIqfuwQ35is9oW7jj5D1b36/fRpJfARXEifNggoDvqQV/y0?=
 =?us-ascii?Q?opauaadS5wOJiDx3kNNq5xa4djLFH+iCvIw5aBVXw+dJcaJYpCPSFUZ+uLAC?=
 =?us-ascii?Q?teBYZY2KwR2ycwNVq8jcDyyvFeLYeHi45Sq3w4kk3FxL1BewX+gZ+GOwUIdv?=
 =?us-ascii?Q?yxMFPAt13s3QY3aM5YuEFg2lSEmnkbasJb3F/DYQKL6XoK9uxoGD4G9H4kdN?=
 =?us-ascii?Q?McIEZM+CyoLNncTA8TliEqHYa0p8nLlJJfQDPg/anjecQsGHcEXKfbj81y+d?=
 =?us-ascii?Q?20mNX4h72zWtkL2iLmYRWkeKCsBimGGW+ctPMXE+nGmpeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fcp7RugxSgAXzsbOnnUj8qugAJQEMq0ufJcW3imp315yJ8ablVFHa/f8p2kF?=
 =?us-ascii?Q?scy1y0lyf4ZtFmCYCwmqXtC5xYCeYiTxidL4TPS/HpzA0/Usz8nwHw31daGU?=
 =?us-ascii?Q?po+e5yE2UbUXs/sMnKukk6W4EkA+mXcK6I/OwE80AOOHpH3JXYYc3PDm2xgB?=
 =?us-ascii?Q?1mBtT9dpAmI720auQzSUGa5VaoRI424Y/nfijp0NcqfBIvkxvpYzse1NFwes?=
 =?us-ascii?Q?4SZbWJy7yIOD248xAQzOGuTkSlBGZ8ZZEcKf/zncNz/EQwMefmI/BLrBjTwA?=
 =?us-ascii?Q?fMF/seGgrqpALqM9sg3Zw0qKO6huekp9ZTjFcGNukvTxU8lcYm881GqKa6SH?=
 =?us-ascii?Q?2C5D1goIDuji42bQE47pF/EtjQs1yQPSYEql62AqFNZQ1tmfMseda0NtRpZN?=
 =?us-ascii?Q?Xdhe1Nqk2MY6raYEI5bJII/44U/1B4rGsxAu76RWGWPW1YQKI0xtx2p7tmXg?=
 =?us-ascii?Q?C3+WuqkLDMUP/QVKHs4RIQQsMhif3TMI59j8u8uLBwZrPdgvvuzqx0Ymfjpj?=
 =?us-ascii?Q?blgn5GleZh3lKJms56nmkT5azLaoxG5PRGnehb5qOgbioiJbSKlr0S8viDrk?=
 =?us-ascii?Q?Rj1d+b7S3xwncJa01HGZfToviJ2jQvi6CasatMgnrlbGjrCvBbDjLxBuhcmi?=
 =?us-ascii?Q?MiIApqcAj9mmG7BV6nSJIbol7xUGmPkVOo8DSBBaqONrZ2L3fFbNhtBwN2Zm?=
 =?us-ascii?Q?U93IMSgXFbzdDPVs5awPMBrKGbhXxKlc/UNxOVcJYFdXHYo5mfaiiP36e/jP?=
 =?us-ascii?Q?NWoR0oFrmXf/McTpRQTItkphH0wW/gY47vT5jVwmHhTUGIkCYyq17QL/U8Io?=
 =?us-ascii?Q?zvepX+Balm1twxFybBn6F5rxCM4o3WHHX0Qc2X+EOGtCczE4wv1Nq+QNtAM1?=
 =?us-ascii?Q?9fWgIbyn11yehhcVUBlim0spltgvbngYbk5Ndw7CsXhzaNTX2Xjz5fw33OkB?=
 =?us-ascii?Q?4w4GtQyXIDgz4iD3aZRlBIKDMV9l7jZ8VOKHCOFMtpTBsneFWkawcajZ5d+3?=
 =?us-ascii?Q?PwR8dY/jByBCi+z7FFo8cdtihKxgMO9JfyEWgiZzHyyr6Re4H0IJyC05K0Qo?=
 =?us-ascii?Q?vFkOKGSzBXWWLzS7yaLYSSuNaU3q+2E+ubDnZtx9gdke4++BcgQ+aGTZ/xZ3?=
 =?us-ascii?Q?kpPU/inrFPHTVPQkiz19jGbb1AN08RtWMzQXnethLSgfsTtI4jyA+NPHaIHq?=
 =?us-ascii?Q?eAFh2G+Xixn7Bsx2r5tvB4QjRhO/nn4O/9K9oALlleS5wkkWl1Wa5O/n0fvo?=
 =?us-ascii?Q?b3BI0Bx7/3gMsx7ueqQLiHdAaO5iZW3WsTpgrUwb5pP06XvIZIXnknVIVkuZ?=
 =?us-ascii?Q?Fefset+M9PNzHjhkeBtXCseAKj22mMHwao5xFGRn+6LeOsxwgqrSJ0r89Rad?=
 =?us-ascii?Q?LOYgw7bA0q6mMRXRIybeAazVs9UagbZH141mmEvtPgcla2bhPTDmL/oqPEuL?=
 =?us-ascii?Q?olxtamBWcXOcOfPsNcWXpy4yEbgaRwT5TYjeYSuujwmtu7ntImm0eAoZ+A+U?=
 =?us-ascii?Q?vm2d3Q+gpDId20cxp4qPeB3GZk1Ps77Nmmzz6mWHq333M1uW/eNefjA2H0y6?=
 =?us-ascii?Q?G2gh4yZTytValTHjHX95fwctKZVoCD6jrtnAV10KmB+z8tjJ4ERgUoZ0Q1zs?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/NZ3EAEquP2Czbl4ZIr8guduZEEEDCA1YpjE0d1O2+IUf4PdSljy8i4eOQqXrRtBW8dNEZha2A5WAORDs7iKzNL9N3iV+U8NNahaBtc/8AB5a1oZCo4sKi6NxsjTPyP8ciM3SCRzyZaLUUcRZoOFJ2H514/wXOdPsetiXir5x6GzwABxt7K28XQVu4YqYTUFhkcEYsZpI53tG1p/pddtSrGPJqjzo7jZEUqlJ/CgSqN820SeGomQDhCGvYElY28mS4ziUZmxRFvLhKwWK/NNAhH1jd1Nvq77OQTIwXvE/KTPB+zDxWIkQrkCjGC7NpTTuM+o8QlTApE1W3QvXgiDYHsi8fwcdUMTPoXgH55ajL/MFgnZyHsDuIcu4ct3ysmMdieCHIdFQ5T+t6rZi8gqAjuqUHCBgaIDxVYl+hszVWou1j4/2Nm2+IPT4lRkMqA8aKqmty8/srfOzzMYEcv/VDloNHLfSDy8Pe9B4C1CSleDASYLOYXTa5yNLzpdQJKrCrVikJ6ZueT/pqViPtuscQsE/6aFZhMITRGhwLo5eZoP/OnrrVvMD7R6oM7IXVj1sVIAEh5IxiMJtjXsAXe0B+thJ1bs8XDzGivCv5mvk98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75295215-0925-4849-4d8a-08dd15601ec5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 19:07:53.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ1qhSebHeqdvgLJF9zMKyXusZOsivoBvUQDh8nM5lODy58RHjly+XC2RT31GE88B5lAn6OHyM5kZ3omWygn/Jv7qjG8Zy9FLctC4KM+lzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_14,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050141
X-Proofpoint-GUID: amCL09qtX8V8AJ7CAZXc1RSqEfUmPS9g
X-Proofpoint-ORIG-GUID: amCL09qtX8V8AJ7CAZXc1RSqEfUmPS9g

When we fork anonymous pages, apply a guard page then remove it, the
previous CoW mapping is cleared.

This might not be obvious to an outside observer without taking some time
to think about how the overall process functions, so document that this is
the case through a test, which also usefully asserts that the behaviour is
as we expect.

This is grouped with other, more important, fork tests that ensure that
guard pages are correctly propagated on fork.

Fix a typo in a nearby comment at the same time.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-pages.c | 73 +++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
index 7cdf815d0d63..d8f8dee9ebbd 100644
--- a/tools/testing/selftests/mm/guard-pages.c
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -990,7 +990,7 @@ TEST_F(guard_pages, fork)
 		   MAP_ANON | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(ptr, MAP_FAILED);

-	/* Establish guard apges in the first 5 pages. */
+	/* Establish guard pages in the first 5 pages. */
 	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);

 	pid = fork();
@@ -1029,6 +1029,77 @@ TEST_F(guard_pages, fork)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }

+/*
+ * Assert expected behaviour after we fork populated ranges of anonymous memory
+ * and then guard and unguard the range.
+ */
+TEST_F(guard_pages, fork_cow)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Populate range. */
+	for (i = 0; i < 10 * page_size; i++) {
+		char chr = 'a' + (i % 26);
+
+		ptr[i] = chr;
+	}
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Ensure the range is as expected. */
+		for (i = 0; i < 10 * page_size; i++) {
+			char expected = 'a' + (i % 26);
+			char actual = ptr[i];
+
+			ASSERT_EQ(actual, expected);
+		}
+
+		/* Establish guard pages across the whole range. */
+		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
+		/* Remove it. */
+		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+		/*
+		 * By removing the guard pages, the page tables will be
+		 * cleared. Assert that we are looking at the zero page now.
+		 */
+		for (i = 0; i < 10 * page_size; i++) {
+			char actual = ptr[i];
+
+			ASSERT_EQ(actual, '\0');
+		}
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	/* Parent simply waits on child. */
+	waitpid(pid, NULL, 0);
+
+	/* Ensure the range is unchanged in parent anon range. */
+	for (i = 0; i < 10 * page_size; i++) {
+		char expected = 'a' + (i % 26);
+		char actual = ptr[i];
+
+		ASSERT_EQ(actual, expected);
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
 /*
  * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
  * behave as expected.
--
2.47.1

