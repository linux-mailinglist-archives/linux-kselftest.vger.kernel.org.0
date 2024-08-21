Return-Path: <linux-kselftest+bounces-15818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078409594AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F76284AE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180816DEBC;
	Wed, 21 Aug 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dbyLqhrz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXQpyIsh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29F79CD;
	Wed, 21 Aug 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221921; cv=fail; b=f1bCVHbpNbH/ka8tJ9Gx+HK7BKk2+D7jkTh++Ob6+/dtCxNUZKsTqKKJz+RRGXPCp0qORNmuOMFmhjLgq5Bc1mSZ+Yf0dV9wZ79eA9+LnTLbm4KC2AMSPc7U2AwKr8nCtjklnmcL0vNuHxhPZOLCG4IK4jelVYyDbB5FJdug6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221921; c=relaxed/simple;
	bh=UOm6laqJpk62lY2dlll2kmuKbtezjF0yxAhSCWZnkKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZORr/9LK3i2nq1mav2o0c5Qm1B7+69y6cNFxfjzwSS6ObIpHxxPVou3scU5lzdJyIxSpDGl3E8BcEbGUvuClgG0p2zwaFq59c/ux4fruWcmMec3qTNxJH4lVWACcVJjBfQpCY0H7+epm82FsBXwbvRs+U+PmmOlaxEKdqLQtJmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dbyLqhrz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXQpyIsh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4giWY001625;
	Wed, 21 Aug 2024 06:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UdKbQQjgDrIdDBi
	zO4Yq+7UuzYfhTGtv8KxgH7FfMNA=; b=dbyLqhrzEJ4h5QVQFPnKySE/NIolLiE
	GwxM2MNy2aS3ipF+JTktkVadjSnO1S/sHr5oewWY96UBDx/Y/S/ycwGtIV4U4DRb
	PN0lJLcSMp7lUA45dMq4zkNqfLr534zKndvpYXuVZVaJEeVIFxnsz6j8QO/Fsp5Z
	TAJgoNU37U1LH2rLJmRSzWzBmKy7m6kOMGkNHPIiHSozY6FYrNw0/FqawfQ7a5bL
	cgQcjh7KjH4iaOEcU7uWNGeFdfAHHJo1ZAltHk16J3+y3lX/elDdLFWl8nqKEuli
	bs/fi/VkeEl8lvXczH3OWqMyh+REOYJckLvAFCb8YlTAWLy44mTbDpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6get9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:31:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5J5gF019843;
	Wed, 21 Aug 2024 06:31:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4159yythke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjmvQHfUjVtap9LX96/ofTQkOH4SoH+25g4clBth50AjkYNqRDGDWaUBmqrnEC3s/idz+QYGC5aA1zoZyV2fFEEgiHW7uxcvPAxEkuyZn0hrCZUk3z3W7R+wPKBkq5+zmjAv42LJrR1bcMTyfT19UgYc91RJKI6hLUNIvh5nHtDMHKrlQTdW4zFuRcBGpyliJ4UGansJNIV9GCC5MZ5HQ1kJpRJGzOmCzKZu1BfFAN51ilTHT66vpeZjLQ0RNmeXxQtRzuAzrObYIxKRzFfAASGyCtPw+Pz2/WLBmp/Ewfs6XD1uIoot4dkP1rVSFoZ76LRA3HzE5TTeFBjGG7d2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdKbQQjgDrIdDBizO4Yq+7UuzYfhTGtv8KxgH7FfMNA=;
 b=yH7M3xh6f7Ds9glYBBt4cG8oe/Ab6oeL4slvf+HB5nBmT+XqaNTMzTbM6roZdW3250zQQhlhf8yZ3oGwGm1XRWodxiEkvIwsQ7mQPKH8byR/h0ykeiRkWSo6/R+xpVXS4lqGMwjE9MpvJaOgULcN7ntfEA+U3/fRxV31mSgRh1FD6iIGkOcpl31259hBjyozs7rxpWYafq4/3hMgnoBQOBqxjnjTHyN9teChH4bk9wtQw/ZI9Gsz9/tXkn/TEJ+zQc/+13BkFbJ8Fp8yea6MaCba0PDv1f0QVyEbzKHsA5yhsU8+Ct7CEhxhpkTirrjZstftDYaooLPktu+MzhSPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdKbQQjgDrIdDBizO4Yq+7UuzYfhTGtv8KxgH7FfMNA=;
 b=DXQpyIshlqZyBNZ6AG6zxXyy2djHHnRABndRh91GEFpNsVGYCdz980A27rOqGL5SH0oXrVcoBM1S9XKkyWE133jEsyYffZrDEqspaHDkxqCymciTnqK4BXxUtdFVgYbMN6BzIJD842F2U18gnkmsZbHvagNO8D1iZ8CMCZryWoc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6484.namprd10.prod.outlook.com (2603:10b6:510:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 06:31:37 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:31:37 +0000
Date: Wed, 21 Aug 2024 07:31:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 1/7] mm: Move can_modify_vma to mm/vma.h
Message-ID: <3b4770ac-6fdd-492e-a05c-aeae008dd1f0@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-1-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-1-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO6P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ca96eb-31fd-45f4-8708-08dcc1aae893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cq4de8IKhnY1ZKGQ4bQ64efZyou+fXtTCrkdDwUDcpbpgJkfOdQ5WKWessJ7?=
 =?us-ascii?Q?jBhtQqIVR8shoniO4LGCrEPv+WGHdR6ODRaajOpVu7oc/psISMss9Hn0nvO5?=
 =?us-ascii?Q?iOlN0R1M3rY1FZoNSXt16gR8/94wQIogLbXgZzGRdtWxQqa+rOE4ieiFcO+i?=
 =?us-ascii?Q?zkROOqDVHkPixZiWi+xVd+TvBVeG5Ux9+iJDzD5D5UfaYnStEYFE1VocodrU?=
 =?us-ascii?Q?f5yYcMzdIZn/fgkqPxZYjRavi3n+BIn50u96/JFqSR11dpQXp1u8ACJQHaah?=
 =?us-ascii?Q?OuCKC9figz8QZhgIbet7QG2vmJjysqqGl/6+J11yTC52LbgXpIJ6uHkGSWCM?=
 =?us-ascii?Q?Km4DWxHycDEE3eSGLO44fMc+Fpys06Rc4jBhdYqh+2ac20yGLNCak6PvjfqS?=
 =?us-ascii?Q?WYvISRLwaqeXlCHO3iZntlGR614MrciCwN6Ogjh3uOJH1/VZQmxJWMHw6i19?=
 =?us-ascii?Q?tUot+xAvemwanw3Yz3+gfUwBjkVziu88Nb2Z9T60VJgN6xkFjfbRPe4bDyUM?=
 =?us-ascii?Q?ygD2tBP8XGBJq7Bo0RhELF2US5oeEEoHV2KCeDhPp9t9pYBhvKrGAH1ltKRN?=
 =?us-ascii?Q?cyT51A/u6oUkTUAKlMCX+Bx3lwiC2qlvvIaGcc5AXU+BDby5Q7sp6WZmuL9r?=
 =?us-ascii?Q?mW07CPB3ZV1PA02vYhKXkEzFPxg9iIs1oJh243kvw8YWqKQoIf1BdS83Tlic?=
 =?us-ascii?Q?LU5Y/T11GyxDtPCnnnWvpsa0JdXFRcMxsoHoXyD2b6vanhyTETMTzuwRLzzX?=
 =?us-ascii?Q?P//lVnByQm1yfHN2cFC7X+q5jeKfJg+3LLMQLjr6PEhKNhesXixe5eNFlASt?=
 =?us-ascii?Q?NPbNKsRAl5rITvxp2kuv4GiDZHSUnRJgUNGIIYV257sa9hgUFqGQ65tZfIuv?=
 =?us-ascii?Q?EwoxIjpmqJIsrmgJ/sS4PdY8chL3Rceqyc4tQL5lw0TOFG84M9bN6k7R/xXX?=
 =?us-ascii?Q?/ymEiKYO+BXzvtvxIE7Ehx8B+Bz15za3ehv1GzoiiZ42lCIEipIwo2w61z9h?=
 =?us-ascii?Q?hXRs3yNTs62AT01XR4O0APJMT4Qa8Ls8P2GcGLADMYKoIMynrTNdJqrPQ4xV?=
 =?us-ascii?Q?W226DpnWECRh0dkgscRNAt32Ooml0BFj64ZIcjFb7rXD7ZQliVot2yUf9H2k?=
 =?us-ascii?Q?q68XLAmC+gxfHA/Xs3p4LEkt7z0W4klnhW8yt+G4NAqTvchfiNz0ZrJ4Hcfv?=
 =?us-ascii?Q?a8FclMNCdYmYEDo4aXSCeMQE1ar9x9QrMKrs3NeyPagCuBX3x2CHDGpBn8gm?=
 =?us-ascii?Q?RxlHNILjB5j2PL1BQJJtnu7WHBNDPk2zuoSbeztHlLClJLTWR3ZcDCv5xM4/?=
 =?us-ascii?Q?t0tBpcshYAgbWBM6Vp3rbe2uFMCh7bv6qOPFOABlT2Bvug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9wKwMro9mWmWt3XzMrAp4jcWzGOujrkjhSRqFYBFHNVJ6fRqXCOLAiDxNbm?=
 =?us-ascii?Q?eRQ90+EDa4oHxQozYGS38Zr7/rbA3iHNoEAJBcLDNwgXJ6v95icwf0vRk0Ag?=
 =?us-ascii?Q?QwqAsIaldVIbDA83Jmt9mNJg/F512kslHNnkgSTpneWFT+unlP7WmX/iBnM/?=
 =?us-ascii?Q?UWa36kI77QisR1NfE6NCWmA0NlekJvgvf7C0ITu3FRogoT/Kh+89DsWA7UeA?=
 =?us-ascii?Q?m4R5UVGF4ZIRODcVBcUZ1klvNUHZ3lporhV1xAEEeWZvkNOxwLBjSlfP1k6V?=
 =?us-ascii?Q?NoOCTsguEVmBT/lkKIryWniGP3cMbX4YgWzHrvbXnJup8J3Y4AVGLvSOp9Fq?=
 =?us-ascii?Q?Z91DpDm5AlMxdju2thgdJCb1ZRBS3NP8LtnufbMU4Ut1UVWFrJ6iHDtMddsb?=
 =?us-ascii?Q?NKueSmnw08l4vx2ZkxU67XAMZlGIOpvYiTwq2qfOzPVi9LYBClt/0mzk9Bs1?=
 =?us-ascii?Q?CLSXwMbQLm7lU0rSkEz3tqaV+/haiin7fDHTW/jmvPIh/4RH9FVHo3s8bJEf?=
 =?us-ascii?Q?F1Tqz1qEWTcfCDNigfAL4FxvCP/jFJHqR7x58Usiyv3QSbFxOfwOke8bX31n?=
 =?us-ascii?Q?Inl73cmClMeBhnZNnifOpHWDaxb6Kyc7/Nv1Zq08KYGSME4tQH5uIikPuCWc?=
 =?us-ascii?Q?F688dldtkyn9de2L/+EU88/PIvy3a//5kQJWP0R/WdduGnEx85Kf31dTLkfO?=
 =?us-ascii?Q?+kdBsLhxGb3x5vCUXBWjO8oGqVT/8pl2mh4CDiNXpV7tBHFrqS8Na12omGUy?=
 =?us-ascii?Q?tdGk2PFHUk+bFiXtR7oaEDPAhHHW7X63IiTqG00ACe325T97Dj3cwMfLGDe2?=
 =?us-ascii?Q?o5aI7Up9een/5Hb4+wE6pBe0qD7zzxKlp0+aYzFv2ghfu6kceB3CrSHOYWE0?=
 =?us-ascii?Q?nBPOenBt6M6Kcolm2N4DcFdUY+m5O9nDpbMugrUf5kneHtrdbuvKKCHIFNnM?=
 =?us-ascii?Q?yFLWeOr5Ein9lJLP4uZcGqb7dUXJQ3dJ8HgRRpQTkkheJeX3hPUkSVO2o2FQ?=
 =?us-ascii?Q?gzZqlmJDZq1ML9zQplSEhTHnk5wd2r1cGs1HtbOXcDt1mqcqHipkFBo/P+ym?=
 =?us-ascii?Q?lFlQqfaqN7qy3qex7mDpNsjm+JsGV5/kn8bAUf5p2VlcnvXaF2NmrPRM0p2F?=
 =?us-ascii?Q?4u0fzYFqQizyO7feneAlbu0GEBP9fd8VAHuNldAuAKUHMsH1243M9i+E6pbt?=
 =?us-ascii?Q?tSUnuNmpirtRXDSP1m7E7fgyKjBeDpWqKYsFcApQ820LRu7LGCTUil1/VHik?=
 =?us-ascii?Q?Sj7wDdzstcuZmPRwfn4qx+7M36asucoYtuK5zXWuXoiORunOTlu2RtEjmZKH?=
 =?us-ascii?Q?1YvSuC64n2fFXDFOryvMBVqsOj6d+DPHE592eW5yFaL+X8MSmqCAxdwkNecl?=
 =?us-ascii?Q?WyuUeGugTmA5hbh/AA16JhdxU7D9FZ8ZPJ22CkINnlcIvyTC+XO6RPZakwiN?=
 =?us-ascii?Q?GCI4IVeBnbH93dkuFgm26bj+s7WgounaNNyeAD5FAuTswsvYqlk7uRz8K24S?=
 =?us-ascii?Q?Q64tnEEu++nDNMWfDkQYvGX33K2g3EOCdmf6tLSsvfRwlU2Bn1dd9o1MLeHj?=
 =?us-ascii?Q?s8JnBDVT/ZHHtXtAYWa6uZh4nJ847HuAeSK9aMiuu9sKZd/to+8e95MWfa33?=
 =?us-ascii?Q?1i7aiQHGgyapKRkWkXuFbrscWQKpSs8LtiIbJgfP1LzCiRG5FO1tRfBgr+Y8?=
 =?us-ascii?Q?d/Tx0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zpD1/hBD2cG09B5xlDHSVJ3aJNLB5UPRRMaExjvFPf/OueIRchum2y3vMbXFai4Q/vsCoKimCJskaPj9/NojLeHZhRNwPzA3g4DqZz9zB9qCB4oyF09uGfsqusu3TxumGf+w5GuTMbpdrvc77lfI6L8Sc+BN4i7qAAH8EyFJ21+jPq3mDBzrNnxeGUaC56CwUEp6DQFLNPO2+1/56Yg0YMwHBmaLCM01WQDvBdwsEWdffORIq2tqDsIEvVBaaVzWTZo7mnkQtMIFG/gyYo4WqNlLWpnOw0qPUMF4KojoCyzz0xZaLDTTXO7Bt4CyzqD2vW/H2jMv1mYwOXHdqKWcpi/JGihanPotxJiJK/dX1dPPjaQ8b4VOWPVPFsNS4+YtnfRNyNCrXHityJJyzJWNRaIXAnHnizDYPfF+tYZAAYKFHMpKjg6y88I9NRdDVUAeVvh+w5rNUBcBHL0Q6NimwYGhuLABNynvftNTYN3kE3Phiy6zViQ/F4KZmv7rGWMDc6GBLrJyt9YaqPuTByJVPO2lKX2eOn4Ek/Zz4+MblkWDkcQwuYPJovNM9n28/CPZVeOF/f6vivhOYI2vIiH/hG1UjeZN374ahWuwWXmvkQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca96eb-31fd-45f4-8708-08dcc1aae893
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:31:37.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uemla55xWgXMMpFUtvoG4+fZyg6sKWgdWjIA+6qF/z9Qpj9w4wXgP2Yg7pYHp5kADedOYDXEWfg9Y12YEzZ6J1X3birGsxXS2X8SpsGSh+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_06,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210045
X-Proofpoint-ORIG-GUID: pPntuOCkFs9hLlkyFw-tGt0ufx0XBMVq
X-Proofpoint-GUID: pPntuOCkFs9hLlkyFw-tGt0ufx0XBMVq

On Sat, Aug 17, 2024 at 01:18:28AM GMT, Pedro Falcato wrote:
> Move can_modify_vma to vma.h so it can be inlined properly (with
> the intent to remove can_modify_mm callsites).
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mseal.c | 17 -----------------
>  mm/vma.h   | 28 ++++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 15bba28acc00..2170e2139ca0 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -16,28 +16,11 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> -static inline bool vma_is_sealed(struct vm_area_struct *vma)
> -{
> -	return (vma->vm_flags & VM_SEALED);
> -}
> -
>  static inline void set_vma_sealed(struct vm_area_struct *vma)
>  {
>  	vm_flags_set(vma, VM_SEALED);
>  }
>
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> -static bool can_modify_vma(struct vm_area_struct *vma)
> -{
> -	if (unlikely(vma_is_sealed(vma)))
> -		return false;
> -
> -	return true;
> -}
> -
>  static bool is_madv_discard(int behavior)
>  {
>  	switch (behavior) {
> diff --git a/mm/vma.h b/mm/vma.h
> index 6efdf1768a0a..e979015cc7fc 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -361,4 +361,32 @@ struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
>  	return mas_prev_range(&vmi->mas, 0);
>  }
>
> +#ifdef CONFIG_64BIT
> +
> +static inline bool vma_is_sealed(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_flags & VM_SEALED);
> +}
> +
> +/*
> + * check if a vma is sealed for modification.
> + * return true, if modification is allowed.
> + */
> +static inline bool can_modify_vma(struct vm_area_struct *vma)
> +{
> +	if (unlikely(vma_is_sealed(vma)))
> +		return false;
> +
> +	return true;
> +}
> +
> +#else
> +
> +static inline bool can_modify_vma(struct vm_area_struct *vma)
> +{
> +	return true;
> +}
> +
> +#endif
> +
>  #endif	/* __MM_VMA_H */
>
> --
> 2.46.0
>

Thanks for moving to vma.h rather than internal.h! Definitely seems to me
to be the correct place for it.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

