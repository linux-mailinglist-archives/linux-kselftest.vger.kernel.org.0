Return-Path: <linux-kselftest+bounces-28290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0EA4F6CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 06:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54C83A70CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 05:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2C1D86C6;
	Wed,  5 Mar 2025 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRLSuEUM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WTUsSQL7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EA193436;
	Wed,  5 Mar 2025 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154389; cv=fail; b=tCMd9X6GlZB/s4ZdX8uIfXaOKVm4manvUvr9A8NLwKYVbp2cwUqFTj0fSjTD9vPMVkdKZl6EMUzLzRNQaCoQfoOz7j0w+53X83ELUO1/j4PUPt9xkgq34oPmn4hAZjnJZoOTIerTijA77gIDAG/+hLMVxmvbSq8bS7nYKubqurg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154389; c=relaxed/simple;
	bh=Sf+dSz1vxCTQSAm9E6OIMrynxZpvF3E74zMwLCJTUEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIIax+W+HGvi47+lBVPJRQpQWFqWQbjjm6tp8JK4g7bRD8nzrFCPAkNQSsBBuK4Z/UP17aO/cgBzv63hSQ8r8LS2YndrGGqcHLASZPxn+wvhi55w/gx8lJCDMWXwHZpGuEwid2I4eKBNxI4L3nB0dETp1TnPy0idQljV1K0+8/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SRLSuEUM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WTUsSQL7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255Mqw6003967;
	Wed, 5 Mar 2025 05:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6k5ouswOuob2YWgyn2
	IRYHa8tcfBuRPIYlGllL7/n9I=; b=SRLSuEUM/NAVDukXH4eI3dP2WmnayDSgK8
	EsmYWW3mJRwn/+PthSzOfx7pTypOQM6AZ9vMyu5JyefXA9OHPNJVFYOWiuC5ezpB
	aZ1xsnQm1cbuyhMj8VdKk6WkFOQ25+iAZdsRgAyCanZEdCnwvH8g3crq0aErHpIJ
	8uRLd8sPIbNnzANjhoyvMUbR7QOV8Pw1MIhsv69D30Q5hcfQyTJlH+D8ojojUPb7
	USDxuTowv08Du6B6+CE5ShIGImaYKGwkccfndC5V3wE+GLhT+BOnw9Yx6BtpVr9y
	Wa3SB4K+01oF16ntcRb6gKg2rDMCDXESDdv3YB1GoqgvVtDpHrIg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86pr1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:58:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5255GHbX011064;
	Wed, 5 Mar 2025 05:58:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbg503-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el0HSHduRV5KzE43YfYHJxh1Z6LhG/6t5dTMBqp84U9B9JKZVDaNtqCHfGd1Dco0evRC0Humb0EdJhl5VFULRNdWb91AWoId1QVRFTI0U/oW9gDdpApL4X8PYJ5K9VMZe50OHnu3H0N4aePH+DKN7nbWXwZJwGYq7+//f0zNmNMjP7T0HcMCIhk8oGeNytSSScijrrWNXQBO3g4ebn3IljNz/W5NlIJCY6cn+PgdZ/qZ41rSE++iWWK1HATTW0MRziqe+g186sTtNwWb/3bbFakuud9sw86RBY9Zt5HPMDWTPJkT6VJHCVa6GkXhJ6TgGLWgMJi7pJh3J+xyljP1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k5ouswOuob2YWgyn2IRYHa8tcfBuRPIYlGllL7/n9I=;
 b=UFRNdKkWvTXxbRTYKL+RQq0B0bhyEHnt84Q3zhM63eOh82XiUOMA7Mm+TGhfBa4+s8WfHk6sGjLkbnrvQrh7mbHzVZTP3uBFHVxSfNAcbXcEbJCsL0l9z3oiX541uuffNZoC+hOog6GlwCbYWI8yjeDfnZpZYhbhpHuDjeGJMaLT6u9l+oSpqByKwdRK9In7RPfJxhegMtJAPpaFs7g7Q/Q/pB+fzymtQoTUNnNvGJSyP5Fz6D21+GjjiNqACMjP1DDV/O1uKtVCBTmf+3qkEEILIWVHB+1RKxqIGkJJ0WqOJqSETaT4R0GP17XXTQyqNrf3saYaE75B2zhKjkZPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k5ouswOuob2YWgyn2IRYHa8tcfBuRPIYlGllL7/n9I=;
 b=WTUsSQL7rc5sdu9ONNyx1+eDGb1DdfG+qPatEQFGlKDo740Ue5qkTSvCrhM0qqdEeHAE+BGjsblz0WFX7gM0evfAJOnXMvLykwyCnPvVHaw4x8k32wim+WZ6JdtEv4NeJylZTQzm1uam83X2CP48BSACphKktaAPwEMi/aj3vOE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 05:58:46 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 05:58:46 +0000
Date: Wed, 5 Mar 2025 05:58:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v9 7/7] selftest: test system mappings are sealed.
Message-ID: <5aee423a-d8fb-4857-af49-80ae38bc43d6@lucifer.local>
References: <20250305021711.3867874-1-jeffxu@google.com>
 <20250305021711.3867874-8-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305021711.3867874-8-jeffxu@google.com>
X-ClientProxiedBy: LNXP265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::30) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c251eed-0eec-49ab-005e-08dd5baacb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JzYK9xeEOLdlHhS/VC0Ch2IXFihSUsK8nmF5LYB3ZxLs7wAwig2+eoca+zZs?=
 =?us-ascii?Q?KNAF3l4JrnifsoAGf3BM4TogX8Y7YVAhSoZ+TgWCfINVH5H32EU5dx7ClFTc?=
 =?us-ascii?Q?aL+USVr9HDM5/3ElAk6q/HM8LcYXSpC8WNmcb7ii5oJm4Aa2XRDPIHvrW1Na?=
 =?us-ascii?Q?WVufxCXOUUDAdEzPfilcVx7p9vOUOrnUTp02QC6PUDimfKFBQlD3pKDzpYW5?=
 =?us-ascii?Q?vXik/6Lz+0gIBMeS/FvhYEONaJWv8E/K0LdL5RDH/b2yhEPnLQp5yAH7NsMS?=
 =?us-ascii?Q?UezlPDes3CbtEqsXbBH2ZYMWFtDX2zy2GSxsT/ldABE8pyNEzkbisOqtqEMu?=
 =?us-ascii?Q?cc+C/3rvg/vQMHsa48FIm+wmBldPX8LioDQVM2pYQ853s3kNq56vPlh+5NT8?=
 =?us-ascii?Q?nPOqMegRqbU6C8v77JGvI9D3C1mMkCHwoCTNWOocPrXeTU8mBu2vekBs3EmA?=
 =?us-ascii?Q?jXk6OizOGxgv7R0yVNCrtTDsNcn91TwJRwck1qUaeCPsz0VEeqyNIE01moH9?=
 =?us-ascii?Q?e+wthy6+qgKsotqmSWMAKj/rrWuTUDY6cJwZiNe2zNAjWPzKoZ4R+fuye8Oi?=
 =?us-ascii?Q?JDeHPoH2TpQrQvjQ6gm4SgTZq29Lv5RJSycV/j9+m/3VMI+zLHXhI0KuTGJR?=
 =?us-ascii?Q?URk3gayaC9XGaADC7lkWv5Q3Ymqmvv5CZ6DObr8s2HPf+e8XIZGmPxcSHi+X?=
 =?us-ascii?Q?68dY2LEo4PGvsd0ZnBQnedNk7qH/yebGjrYbkrFFH5PXwcoR1I2bKJUr41F7?=
 =?us-ascii?Q?wnY2x48nDhieSdJyEk7Wn/dh+d3AT2KJ14hBwU3Li8NHi7s6uVlNYUwTyI2t?=
 =?us-ascii?Q?JLAM1rUfjMoewxz2MQhFw3iGmY0ZGwOmG7sGdvxh1QOLM8zZpOjq1eQqAdqr?=
 =?us-ascii?Q?PeW279yHVXdvauYDpvMrjjGu7wphfI2QJnXnSDnd4EV/ZYRN3e+5PYX94Poc?=
 =?us-ascii?Q?E5LQpdr3suoVWfEubkCrU2/DLx5YcIdkv1mI0uF5JMtzFj2lIVttd48nHKLC?=
 =?us-ascii?Q?kbLBEw4bfcYwG8z6dqNh9Iaml/k7C5gwSPJqbaDBVfbnk20J4IrKMWuTmtXR?=
 =?us-ascii?Q?CDsZXFqZjzC0sXilc77y7wcQzuniGVm9gl1nDpo+6koVXCSepg2u91a+iKtW?=
 =?us-ascii?Q?1c4W2O5S1hl1g7oFc9sd672A1hpmOsqREpxdyYHHWQjsjoTBJBz93w/Af05q?=
 =?us-ascii?Q?vaxx4Iiz9jq3feTLd2FX1tlkOmDAc3erKq3qFPMe03jmamYguashgxZibQnD?=
 =?us-ascii?Q?VTN4xosj/tOVxf8Pr+4iFGl8zYP77NnxsttDIZLD1SrHOvOUMv6lrFia7gvl?=
 =?us-ascii?Q?R0K8MhB2L4nfPr2VMF0bZAsAZIsg+u1bVnevgdNqxaFAYy7Vf7pTrRZUe3Ny?=
 =?us-ascii?Q?+pzNpUPxKCBy5k/0YxzxIYd2MaJT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmOw45jnorI6X2UJPNHhO4PCBwTlDGxWpQrCihoQK8EnTwCryKvtjVY7xwWK?=
 =?us-ascii?Q?33Eg+PmENNKRhxUs7kgHPNiVHWlZHg2M2qOLzESVTiAjh7Cuc3MZNStL/85s?=
 =?us-ascii?Q?y1SvdBCGRYIE7oHSqOfyLFKiYBEtR/GIns/OO/Rn0lHTrhvzX5AmjPNuk0yt?=
 =?us-ascii?Q?KgRaHB1K1ku42udos96RYPL+UtwgeEvJNP51793FFwLQSAffi6h8DmLA6lOm?=
 =?us-ascii?Q?SSUz3ATZ4dv4wEMQ0Kq2qcUgcQMEGdagbj3+d8MR70GOa0BjmKHK8fn/CS0j?=
 =?us-ascii?Q?aK52q7MhbdHFMoPwTrJa41bZw7yInj3t82jeF7v0KGEIZBEIUbB3s2qO4tLd?=
 =?us-ascii?Q?A3Tili0rdVOu52asT5RaV99bneNsfHsvTMNXncKaUqWfdAEAmSRzZ+CKLCGC?=
 =?us-ascii?Q?Jpsuy6HtHFf1mFKVIo/m/UqMlND/UQ1h7EGC8d0TglzShX/rBj6wmpsuS1a1?=
 =?us-ascii?Q?ghgZiXM/b35mTtgCg6tfOuzMFbp5U3W+a981MIeD/D5v6yF3vI/Lpy8hspUg?=
 =?us-ascii?Q?UzGx7j6G07GM148shiug93JTdil3H1d/RrLR9QkmYpl/siK5f0ENSFM1YOnV?=
 =?us-ascii?Q?wKrMYPrHLbuMMudFOfjPWvIHj8Uc7xeypFv9emTCdiSdzyarGo5ud83qWBjF?=
 =?us-ascii?Q?6CwfIUQJe0L/QAGuyYCtouQUX2YaDNg5Y5jpEI0tYjvLDTIavEksP0ho0ly5?=
 =?us-ascii?Q?PykL75velpc+Xo2rRHHerS+766oj71OrvjJNhD4UnHtxrwcKzrbMAUgBB2iT?=
 =?us-ascii?Q?A9xwn0M7B056lFk8fJJ8kic/jM4QO+zla9pmryBxwc3n7w3Lq3jBqWSArRe0?=
 =?us-ascii?Q?92a/E3alUQ8PTGwWe9RCLaWxEZhzjKTQEwns/y22z/DTDwzeLL42WtNqGoa3?=
 =?us-ascii?Q?7PG9cNGSSqKAA2TtMPK+AGYtm9Sq+T2DmmHC2JVJWQgpRApaLdaR8AZJqq4X?=
 =?us-ascii?Q?9QfFgptbbY0vsI8E3Rn1KirNzE1aTTtmMrpl34RDV+QUuWuxEsNvdlDzcJ3j?=
 =?us-ascii?Q?ir+/I7FzgsFrrfE6jincxeK3+Q/8khl2KacrE6XtDSGHUI+37sBP3BIG2L+q?=
 =?us-ascii?Q?LZbo4wwCduSCN2JbD6FNvX4zwVpA35dhaoE5Gd5ZpJC3c7ttVi4UYEdmlonK?=
 =?us-ascii?Q?tRw2FUjh5nk/8J2dWYZlYNucQ8BFQbR83MkrEnU0ySfS87ki4PpKrMTMXuFF?=
 =?us-ascii?Q?W508FkijEvxKeMRwQeaIWy6WZ9OE6CrL4xsr9Vi3Ts+HFrwdo6TX+PgRvT/L?=
 =?us-ascii?Q?boqa72EM8K7kvMBVvMVx9yCGzCBYO02YCutAJtMXJqa3jc8N8oYIxjPxuYDS?=
 =?us-ascii?Q?2CMyHhGD7VO6UyQzNZT+1Ps0htIM0Ij2hW02kvABUTYOt94oxDJl2iCAaZJ6?=
 =?us-ascii?Q?LaVSMzbNJ3qNBqd9T2wIBz6a/9idsG7cS0n8aiBmRwZ30V2xkkXOapr52LZL?=
 =?us-ascii?Q?zsNJRNdPbUe3dZdn0wCUgF4KbX0+fIzYSXytADWpJ90Grg/jd6I1MkxwQTMQ?=
 =?us-ascii?Q?SY5MC6kwNgJTFD9JxWnejv93SyVF5oAfuc+BjDnXBg65ip+/aMJ9Ysp70kSj?=
 =?us-ascii?Q?ilSENoKm4fnb8pdKqPneFvPdUiiakJZN02viRmCmT739ZozRTHD+xot7T4d5?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fM0M+ppoqA8WdcGrcsPGBHIwQckCgBPfe64M7ZOmlFRlSXFHp41eMxYkginRVgue3suqSy8m/VRNTZCNWCbnVpc33Masz6MkKThHqrBJwlEpfqPlMH2ciOpinEgJl9dZiEpBpPo5/EyyFzX+uUWLISX0WoOYA6rchdLR/H4qnsJjFLYdg4/JTZ+HsJiGY4IKPgxAjUxMyWB4UBEJ7z2HOoXmd9j0kWOwcViXtYG5dTEVNw8CEvIL0/83wLQQJcXO1gm9dYtn0jb0LnswBxR1sJxN5rqHIlGNqVcEWMaLMSkfCEnekNxbHH2/L06FbQkFAsRpW7HtW+qAMqF4Y/CFWGWHSjx1y2jBXfu3cxPW8CkV8EjZENfflPUOe3jEaHY6T+Q+s8SkfLSci7xx2hqRRJd3CQZ5Qlw118jVCl/3w2W0WgiIJtXwyoxHRRQ0iPStsOpbwI/hWqPM2yy9T1MCBzKQZ4AcnLn6fhANoqvQ6fzDK0IMhdElazMPnJerVwaPuX1z8FFkahEI4x78S7wN5T5DYkUaVKuJu0/O3MJ5pdwKr1yTOfvIBQDM7WhngegewwIRwqrhesHzqBQKSyqVykBMJ4W05qUtOCiyI9rTo8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c251eed-0eec-49ab-005e-08dd5baacb0a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:58:46.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUaAOUwW2W6mWEJZ2gO6zuVNAJOOe+2KkG9+bxLjz+zEcRiKxyWLCTKI2t37oOtz2njzz0VbP12uLEsJgEq2nwqvDuD6PAmYn9Q7TAiOlAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050045
X-Proofpoint-ORIG-GUID: lE8PJjuCzcz71f9mq1WRJG14B9o3lOff
X-Proofpoint-GUID: lE8PJjuCzcz71f9mq1WRJG14B9o3lOff

On Wed, Mar 05, 2025 at 02:17:11AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add sysmap_is_sealed.c to test system mappings are sealed.
>
> Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> config file.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../mseal_system_mappings/.gitignore          |   2 +
>  .../selftests/mseal_system_mappings/Makefile  |   6 +
>  .../selftests/mseal_system_mappings/config    |   1 +
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 119 ++++++++++++++++++
>  5 files changed, 129 insertions(+)
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/config
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 8daac70c2f9d..be836be8f03f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -61,6 +61,7 @@ TARGETS += mount
>  TARGETS += mount_setattr
>  TARGETS += move_mount_set_group
>  TARGETS += mqueue
> +TARGETS += mseal_system_mappings

Thanks!

>  TARGETS += nci
>  TARGETS += net
>  TARGETS += net/af_unix
> diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
> new file mode 100644
> index 000000000000..319c497a595e
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +sysmap_is_sealed
> diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
> new file mode 100644
> index 000000000000..2b4504e2f52f
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := sysmap_is_sealed
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
> new file mode 100644
> index 000000000000..675cb9f37b86
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/config
> @@ -0,0 +1 @@
> +CONFIG_MSEAL_SYSTEM_MAPPINGS=y
> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> new file mode 100644
> index 000000000000..0d2af30c3bf5
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * test system mappings are sealed when
> + * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdbool.h>
> +
> +#include "../kselftest.h"
> +#include "../kselftest_harness.h"
> +
> +#define VMFLAGS "VmFlags:"
> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool has_mapping(char *name, FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, name))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool mapping_is_sealed(char *name, FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +FIXTURE(basic) {
> +	FILE *maps;
> +};
> +
> +FIXTURE_SETUP(basic)
> +{
> +	self->maps = fopen("/proc/self/smaps", "r");
> +	if (!self->maps)
> +		SKIP(return, "Could not open /proc/self/smap, errno=%d",
> +			errno);
> +};
> +
> +FIXTURE_TEARDOWN(basic)
> +{
> +	if (self->maps)
> +		fclose(self->maps);
> +};
> +
> +FIXTURE_VARIANT(basic)
> +{
> +	char *name;
> +	bool sealed;
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vdso) {
> +	.name = "[vdso]",
> +	.sealed = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vvar) {
> +	.name = "[vvar]",
> +	.sealed = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
> +	.name = "[vvar_vclock]",
> +	.sealed = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, sigpage) {
> +	.name = "[sigpage]",
> +	.sealed = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vectors) {
> +	.name = "[vectors]",
> +	.sealed = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, uprobes) {
> +	.name = "[uprobes]",
> +	.sealed = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, stack) {
> +	.name = "[stack]",
> +	.sealed = false,
> +};
> +
> +TEST_F(basic, check_sealed)
> +{
> +	if (!has_mapping(variant->name, self->maps)) {
> +		SKIP(return, "could not find the mapping, %s",
> +			variant->name);
> +	}
> +
> +	EXPECT_EQ(variant->sealed,
> +		mapping_is_sealed(variant->name, self->maps));
> +};
> +
> +TEST_HARNESS_MAIN
> --
> 2.48.1.711.g2feabab25a-goog
>

