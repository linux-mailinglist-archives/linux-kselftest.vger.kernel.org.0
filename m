Return-Path: <linux-kselftest+bounces-16845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CC966910
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 20:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BBAB22A9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D51BBBFA;
	Fri, 30 Aug 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I51FAjV0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f86xYlES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AD1BA260;
	Fri, 30 Aug 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043431; cv=fail; b=bXnHNDbSh7TBCGApjNwpRFMF63deDZ6IxnCJJP6AJNVCtJMLHCbGcAB1/dPY9VEcSAB91J/D+HUY+nBI3oaFiPgGfw8ot44kWgLtyGpDodPm6NYzgVD6JtwurpS8Bg1xgd3bNgCdfKWt372eWv/va1zNQQ85LjD11cjmAsrLbpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043431; c=relaxed/simple;
	bh=GDJbSM+v/k0rXHXxTMIXQ9fjLfQnOKidSOT9+HAR4PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eEShfBEK5BgwSHe8zV6+8aXOIJMLY/Vvsybs0lKv7d8mgkaFQRgwEVccMVCex0m7pZOFasKnLg13Il7ltrQjsw5AGXLwMU8exfrnVHTIIe+Goo0sfdU3JWPbmAAYj4FWRpey/U4dcDRix6WcKXbuj6Y+mHmmXta0tlQ53l2X6jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I51FAjV0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f86xYlES; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UIg0fp005904;
	Fri, 30 Aug 2024 18:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=xNptx4FzvooKrcy
	5YsdzUIN/RK12Z0a5+6EJbvC4mr4=; b=I51FAjV07O4xqUhmy5TPUbv2yfZJikr
	mwPOOCIC1NjHq8O6GEGiqMJ2cq5/XqpUoFlIdQA9SUW/OjAFR70GADqiBWhfrPDF
	bS+zDHpkFsMajekD0X6owe5/nobXAKoyRN4+k9JxXj+8tXyC2xqPOe3h4f6eD1Mi
	cIpA5kIWQanKG97eump3FEk+ByYs417OJzdRBKge0AGVWp/t1gNSns6R0fVxHtGD
	TA9hx31v8u6Q6YSi6E4/jDunl+qrrimGntkK/H2YLD91hiQ5oSKcvAJNd/vr6F6J
	w1N+gGh+RB5M9M6L2Alzedp/D7+dteOL8oxarxuYTUebOCEWm9SYmGg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bkk8g02a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:43:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHDvIX020303;
	Fri, 30 Aug 2024 18:43:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8s5ek1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snJreWAmyC+4LQo/XExARp8WUWDhvRv4kPk57pFAGpo+VllwMhSZMc+hyOr7B3zdTrHn0qUi3Sjllvws2Od5US39fWRH3XslE+t8vnL21m6Ssozgxb9sYI4HYRSRHlP3/p/LRPlArdHPGp5hkhQzSy4YZjJ+nhy2BkVwLrk+A6fGCpa0kewOSEPCdA9eX8pyZmcq2fX6a+FO4tCgJGodqfQRbZGVH81Y/e6XXrhWoJZ6pukv9rL4weYQYfwDgSbPUWDHFK6I69wod3vAmIt60yCcTHI5WPWA5Ge7ompm1Xtd9yRSe9aiOD9lOHHc//RyvUnCadOCs5yhzYY1XFiiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNptx4FzvooKrcy5YsdzUIN/RK12Z0a5+6EJbvC4mr4=;
 b=eoPZgIQNAp4Azv4SWY7PY7zeHLTMyoQdVDouQAlU1xCrSj3HuMP/GqgDwg4AJ0O5PAkNSsjOY+BcZ5Q8ik1TddcJwyQWEG09ZSFEgo/9/7HnduLt2T6L4rZ9sljw2MUGvVYEai4aWkEX/OcutcnhLgj384LG8/Lprbj82ZVIkBKcXKtueX+jbfK9GHhBkXu+6naCEzlB/Ekh90ik7Fi2HMqq+CWZI2cWb8SqTWbCl9YX5/fJQEPRAgSrQuUGaR0Mxu8c2X2qkikYMbv686adF1fhAedhL1rl6BsK8BtC80BMXAOpCKMW8JVZCopLXEU/NZtWQzoryv6E8HkYi5vb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNptx4FzvooKrcy5YsdzUIN/RK12Z0a5+6EJbvC4mr4=;
 b=f86xYlESVr4JCBPjyi3fo6u2bFVmgfyuUCF9nc8IkUeG94FbUwDT22U4W/OJxqLjWbuH1rU8mrJhJhUUb6f/Ra1iHrqj00IWGmIZL2Cesk2xuExWGZzbosDzrq7Kkk9COH5EuaHQ7mUSxjn5JLph/pDJZx1RW7KuDYcd234rNoE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 18:43:16 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:43:16 +0000
Date: Fri, 30 Aug 2024 19:43:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830180237.1220027-5-jeffxu@chromium.org>
X-ClientProxiedBy: LO2P265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::36) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 280f1278-260d-4caa-178a-08dcc9239c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtZCKZUYWpsI+iYIRZwl1E/xuONvpg1MtLIQ2L3ejHtRYz/2t5ZI7+4GOVp/?=
 =?us-ascii?Q?L+O3ZINvW0R5IHcfjaEQIOk2RBiSgbzcEYn3kOM7XF/ZhodD+NSetL0j/Ohm?=
 =?us-ascii?Q?525hCkyi1iZrb16PEtdPqI09rYgud4icxGJiAagcZqSWWheVZP3g9kSS/Z0l?=
 =?us-ascii?Q?uzTlTOtw8rDsPNSFF00JOAGP7hCCyohE3o5S3LiAMW32JB7Xgqu4SEy0zY8j?=
 =?us-ascii?Q?5v2uPj0HgVSoaZ93X1JcKNQYUn3d5x83ug3BVZHB1ATQbk7qKJFSZcYr+nz8?=
 =?us-ascii?Q?WT24S1wftLU1WgmndoJodaMee9QpYkbdCApt2PArUajeUBMdDLb4PFoZAOCo?=
 =?us-ascii?Q?njjYobEHhMKkE84Ahc4VMaUfLHSEse+sub2ezZVZBRP0D/wbwrjMBJ7sPalg?=
 =?us-ascii?Q?/UVSsk5eRXbKUybuA+X9jGMjDcNVqkbSt/e0hpkp7dkItiCvxLuai/dfii3Y?=
 =?us-ascii?Q?/32I0rIUUw+TskHJBJpthHUEj9DXahyFTiDEKv2rq8Hxt9qhDnOgRB0yzIz7?=
 =?us-ascii?Q?DqUwbtFm/0VVsSSPVVn7e7pVf7Oaxxevck4e9KOMJIO6jZo8JIGLL7+RYmKr?=
 =?us-ascii?Q?nBKdeW40rckPG8JKpqAsWJIg2HGILoFiwYpNDrGvrnDPe3d0zUepjIyG5gV7?=
 =?us-ascii?Q?njFCRHqew4zgq1IwYCgmfq3phEj8bqLAPJqQtnx9WzrtmeeY9T+3XcIUBEwZ?=
 =?us-ascii?Q?hsoZpWWATWOZ89SAnwDBGOuWrl8JEiuLdxU1Mvdp3DzfWbSrB1qbYIeoaBZU?=
 =?us-ascii?Q?4lnFGY/KYGPkBkB857QXdORHA7vXh/SxpmByLidQAqpylortpzMbn0fkVRed?=
 =?us-ascii?Q?oiNUDwhoVniG4YV23GR2Yf52EdeIdAJTpiDzeRZ1JJc+lzcVCMrIpaxrmNgE?=
 =?us-ascii?Q?3acd2LIpM9Oe4ulVMvkIY5GT3zSDtxPi/F2Er6o75QOkZTOpKyehXuH4ertU?=
 =?us-ascii?Q?oF5DQk4hxofNxoMA57X2bqf+93TYuARefP6xJ313kTShO1exGpullDv5LRp1?=
 =?us-ascii?Q?ajA2LF10PYzFHcwWtMqle+zL1FhvBW26wIdgmugNOUAiBXSIVrXC3BIoPj4d?=
 =?us-ascii?Q?kgYszeZXgRfajD5+aUnfuBHM2w++6d9PE1IZWShFrZwZHVfPJKyk6CFX4Sak?=
 =?us-ascii?Q?ZZy4rwe5Epj1waL0Tkowq8iqmLmD2PFq7FHiH2ait3OiBa2uRGsgn9C71g4e?=
 =?us-ascii?Q?pkwj1T8usZUgmw/V/qeadLa+DSXZ+pDHuapbYdwS9WezRGvP14pvGbo4jb2W?=
 =?us-ascii?Q?R6LzMHOd1uu6MSxAZUsdQShr7zHiW7t4f025OhAA/i5EbOMBYe1/33lC03Xe?=
 =?us-ascii?Q?7duK9mLHhDrWMqIcVgtLMki59eX2Q9QZt9Fhm11PgC5PbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQnQzogVl3IKMmq4WNSR91wkb0WBEOdH0FRz3RHw4wkT+MQtVGJqeViHanWw?=
 =?us-ascii?Q?+z/Je1EHddcuwgQU0hSnRG0Oezbmlie8yKa8SiGTfMK1rp2QZYflpCMuP5Gp?=
 =?us-ascii?Q?nZOOYNZstScjgaer7KM5Vyi6lqYuwgA2+ruHDZ4MMe6iXqzIXq9/a5dka7yS?=
 =?us-ascii?Q?l8Ibb1AZpp2P1VeAmY62N9uS0yB6Sx2io2sxHOwGfUbOQ5RoFrNiDWhxySrv?=
 =?us-ascii?Q?ZOLAp6yT67E3q3irtRxQ3G5VPKqVMJ2LZPoTC8xZOUUr+XTeIpnSAjZiX0JJ?=
 =?us-ascii?Q?YpB/devbTQZCA/rx5YNhkeIt7HPBph2NxdXJaXce71mGSVLr3y6Ff3gCoiF3?=
 =?us-ascii?Q?piu+aBqj4iaCNBDhsXlBA9oe3NASs31AdG9UwxvSI0ZtF8DN7iXB+ZRn46PV?=
 =?us-ascii?Q?z18WLr++pNpDFprTqKiWjhCCYdZpa85aZa0EFMxCx+03zk8YgT3IqZ5TfP4i?=
 =?us-ascii?Q?IWYvJgG2HSoBo67cWeV3yaY2wb2UR43kGxwo6ccfAnOLRAvLzxh+RGNuEcPP?=
 =?us-ascii?Q?0kFd2coQwvpFjUxByLW+fWpCiuYBPUUNsjmvjpb/T66Jix0ovFeSS9SQaTpS?=
 =?us-ascii?Q?HdQeLYViV5tfLxmmUZiih8wVIxyjFMocJVD67ZwtFcNqDybL4KKHE+bjp3kE?=
 =?us-ascii?Q?6nCnWhT39G+5j+ga3NLupbCWrzy/ibonF2pQLtbuVqcb3kLToVxAaHxv/7kw?=
 =?us-ascii?Q?whyMP3D4hqyEBqQm1QQixsNDKV6Jc6iUBuvXBXCOnYTnwJ9L3NEcKJ7JAL4p?=
 =?us-ascii?Q?QRSwOw7vRQdn0o2CKA572aLHUCYOnFLgbY1L+pVCe/XBKCRp1N5L2ORvZHoM?=
 =?us-ascii?Q?8RvQ+Ly6MXnKwM4jYsChO3ZUymm0RtKkJ3EcAXtDPLko7KEmN9NuVnNm1KmF?=
 =?us-ascii?Q?zyptU2wPLdE0JIBYmhnVZrStnt4dkMIP49sNnT7BZU/0N3OQ0bNxx9Z6pViX?=
 =?us-ascii?Q?QJEwecIuViG9FIt5a6txaTzvI9MkW7ikrF07mQhjwxKIVxtxeXSzvdqPu/+E?=
 =?us-ascii?Q?FuSi4pcEwk516GBY3GBRTnBQ7u+ccZhwLvtBAk/QXOC2ltUgMgQnxQKcqsD/?=
 =?us-ascii?Q?IJ0mYp002iVE4P4vlu0MKiFNgNg4Nq2PHHy8S08ax/0/1kPFqDO11EZEwEdm?=
 =?us-ascii?Q?8ATad43knCBhAEIY44XvRkLqOBwZr/lf5zpOtNkERu4VzcpAE2Pu44RkyQD9?=
 =?us-ascii?Q?zwyBCAn1fys3UhQhHvMxXIsg8uIRt5cSkb4Muy/lCdi9icW/UQTgCKoaiTOh?=
 =?us-ascii?Q?uyxrNL5BzRIF7eyjv6vVjR+Cxd+WVnJRuxVSp1O11sJKQsI45Y0RjXyoOaRq?=
 =?us-ascii?Q?osxbvkKj4NnUjT9/YONbPNscVWTJCHlV5ghzwSuWbzfxqkbUVsS+2+h8I/Qo?=
 =?us-ascii?Q?INowTrojr22ZuacRhjuuP4/CBOEu3ss6XhFj6gVJSds98ZmtiB563ljh/9md?=
 =?us-ascii?Q?45gwwtZsGvqAIg/XPx+Lq4icH0b/0f54ojEF9qNVH3oyoB7ypFlENpUWPY61?=
 =?us-ascii?Q?AutIckxmhiv+jrWIQ+T8Ck9KEZnPuURKfsYdOCltcvDZ7lVVDOJNLjdvIpac?=
 =?us-ascii?Q?SnrhVRZDlFkYH2eUNzJX+QOaXN2XefFhzF7ibPbQtyOs+wUEaY+a+ZRt7dLA?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zOM3Crp9/NOemdtx62XQwUgDboFyZwYZEpVI3PGyLtYuBAppY2EBPLuZeH5309Kq9hJcBfQBe2BsKyImUXL5/+u47AibcebHUh/Y6LZHZdy+Ltu8t9HyRKoEGiy6RKdSDcWO4YucfeebWP1CvtHqNarxj5cnVWieGhqPP5sVV4/UYjzwgHh6qZhnML0+x8yO6whbMbNXn6Pm1+COBRu1w50QnzQNSbaNGrZ4d0+jmRsJGuay40VJrS63W5+Hah0qswOAAefOQPmKuufllN2ohmiIydCknGHyDjSK6E4twOdQoQ/FYhBrnxQSzRMNMHDNphoBb1ZfF5Y3qxmAQl/O+rGl6qXyAU3ItPevQuxbhHzT9MJ3aqccT/GrVNl6H4rC3owqnkG+YRv+fgfi7tFPIcNc9DBqqhPoMO74TYxi2w421fDmhFBvUA/gp+SHmztTrJA9BV0lOzu96Fuz4tfOnuTAXgeY4t7q8Ll/LSAnCiFy7w6baL1cpmmqmSpUqa/sRzjx0jhH8r9cowD3wza7TWDebDpyoCJLJ+Iv2ImTbb1J7vlxrOdRmtoyLfhnf3T/zHkxqNmqC6qPwtVZV0sogyZkHEtlP1z/lykaOuiTmxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280f1278-260d-4caa-178a-08dcc9239c23
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:43:16.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ+fpRwxcPd5IntaFWc7udJPPwdxdhdJpvkUzgfsyp/ofl//70FFFoOkiY0NgkbQ13z7bep53OGgOdHhnoDykQKtdVrAp6a8LOGrdgOifMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300143
X-Proofpoint-GUID: sKBdbWo3e_hrNchLCEcwSPKnxtd3Qu5M
X-Proofpoint-ORIG-GUID: sKBdbWo3e_hrNchLCEcwSPKnxtd3Qu5M

On Fri, Aug 30, 2024 at 06:02:36PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add sealing test to cover mmap for
> Expand/shrink across sealed vmas (MAP_FIXED)
> Reuse the same address in !MAP_FIXED case.

This commit message is woefully small. I told you on v1 to improve the
commit messages. Linus has told you to do this before.

Please actually respond to feedback. Thanks.

>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 126 +++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index e855c8ccefc3..3516389034a7 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -2222,6 +2222,123 @@ static void test_munmap_free_multiple_ranges(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> +static void test_seal_mmap_expand_seal_middle(bool seal)

This test doesn't expand, doesn't do anything in the middle. It does mmap()
though and relates to mseal, so that's something... this is compeltely
misnamed and needs to be rethought.

> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 12 * page_size;
> +	int ret;
> +	void *ret2;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);

Please replace every single instance of this with an mmap(). There's
literally no reason to abstract it. And munmap() what you map.

> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);

Pretty sure Pedro pointed out you should be checking against MAP_FAILED
here. I really don't understand why the rest of your test is full of
mmap()'s but for some reason you choose to abstract this one call? What?

> +	/* ummap last 4 pages. */
> +	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);

sys_munmap()? What's wrong with munmap()?

> +	FAIL_TEST_IF_FALSE(!ret);

Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.

Would be nice to have something human-readable like ASSERT_EQ() or
ASSERT_TRUE() or ASSERT_FALSE().

> +
> +	size = get_vma_size(ptr, &prot);
> +	FAIL_TEST_IF_FALSE(size == 8 * page_size);
> +	FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* use mmap to expand and overwrite (MAP_FIXED)  */

You don't really need to say MAP_FIXED, it's below.

> +	ret2 = mmap(ptr, 12 * page_size, PROT_READ,
> +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);

Why read-only?

You're not expanding you're overwriting. You're not doing anything in the
middle.

I'm again confused about what you think you're testing here. I don't think
we need an arbitrary MAP_FIXED mmap() at a size larger than the overwritten
VMA?

You just need a single instance of a MAP_FIXED mmap() over a sealed mmap()
if that's what you want.

> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
> +		FAIL_TEST_IF_FALSE(ret2 == ptr);

Don't do dangling else's after a big block.

> +
> +	REPORT_TEST_PASS();
> +}
> +
> +static void test_seal_mmap_shrink_seal_middle(bool seal)

What's going on in the 'middle'? This test doesn't shrink, it overwrites
the beginning of a sealed VMA?
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 12 * page_size;
> +	int ret;
> +	void *ret2;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +	}
> +
> +	/* use mmap to shrink and overwrite (MAP_FIXED)  */

What exactly are you shrinking? You're overwriting the start of the vma?

What is this testing that is different from the previous test? This seems
useless honestly.

> +	ret2 = mmap(ptr, 7 * page_size, PROT_READ,
> +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);

What the hell is this comparison to magic numbers? This is
ridiculous. What's wrong with PROT_xxx??

> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);

Err dude, you're doing this twice?

So what are we testing here exactly? That we got a VMA split? This is
err... why are we asserting this?

> +	} else
> +		FAIL_TEST_IF_FALSE(ret2 == ptr);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +static void test_seal_mmap_reuse_addr(bool seal)

This is wrong, you're not reusing anything. This test is useless.

> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = page_size;
> +	int ret;
> +	void *ret2;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size);
> +		FAIL_TEST_IF_FALSE(!ret);

We could avoid this horrid ret, ret2 naming if you just did:

	FAIL_TEST_IF_FALSE(sys_mseal(ptr, size));

> +	}
> +
> +	/* use mmap to change protection. */
> +	ret2 = mmap(ptr, size, PROT_NONE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

How are you using mmap to change the protection when you're providing a
hint to the address to use? You're not changing any protection at all!

You're allocating an entirely new VMA hinting that you want it near
ptr. Please read the man page for mmap():

       If addr is NULL, then the kernel chooses the (page-aligned) address
       at which to create the mapping; this is the most portable method of
       creating a new mapping.  If addr is not NULL, then the kernel takes
       it as a hint about where to place the mapping; on Linux, the kernel
       will pick a nearby page boundary (but always above or equal to the
       value specified by /proc/sys/vm/mmap_min_addr) and attempt to create
       the mapping there.  If another mapping already exists there, the
       kernel picks a new address that may or may not depend on the hint.
       The address of the new mapping is returned as the result of the
       call.

> +
> +	/* MAP_FIXED is not used, expect new addr */
> +	FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));

This is beyond horrible. You really have to add more asserts.

Also you're expecting a new address here, so again, what on earth are you
asserting? That we can mmap()?

> +	FAIL_TEST_IF_FALSE(ret2 != ptr);
> +
> +	size = get_vma_size(ptr, &prot);
> +	FAIL_TEST_IF_FALSE(size == page_size);
> +	FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +	REPORT_TEST_PASS();
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	bool test_seal = seal_support();
> @@ -2243,7 +2360,7 @@ int main(int argc, char **argv)
>  	if (!get_vma_size_supported())
>  		ksft_exit_skip("get_vma_size not supported\n");
>
> -	ksft_set_plan(91);
> +	ksft_set_plan(97);

I'm guessing this is the number of tests, but I mean this is horrible. Is
there not a better way of doing this?

>
>  	test_seal_addseal();
>  	test_seal_unmapped_start();
> @@ -2357,5 +2474,12 @@ int main(int argc, char **argv)
>  	test_munmap_free_multiple_ranges(false);
>  	test_munmap_free_multiple_ranges(true);
>
> +	test_seal_mmap_expand_seal_middle(false);
> +	test_seal_mmap_expand_seal_middle(true);
> +	test_seal_mmap_shrink_seal_middle(false);
> +	test_seal_mmap_shrink_seal_middle(true);
> +	test_seal_mmap_reuse_addr(false);
> +	test_seal_mmap_reuse_addr(true);
> +
>  	ksft_finished();
>  }
> --
> 2.46.0.469.g59c65b2a67-goog
>

