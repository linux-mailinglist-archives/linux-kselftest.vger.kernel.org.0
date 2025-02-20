Return-Path: <linux-kselftest+bounces-27053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 339CCA3D427
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37566189A331
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391161DF962;
	Thu, 20 Feb 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MeOwgl1c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gjpuQOWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440211C5D67;
	Thu, 20 Feb 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042327; cv=fail; b=G/Hlo+AaQCie31QQ80BHz7fKczUqNYhxJuL/LLzQ37nvdsyToeVvsj7fIfboK8lYeVcWPZgTD3IE6d1od2xitoz1l9MnWrWMXQRF/7Vn0AnZMbZv4g28EIcXVzsUxv85RXIxELvq2bi5GnZOKw+rdwJSdiRoeaCg7MUK135Cufw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042327; c=relaxed/simple;
	bh=4ILVqypVQOUyXwuAm6I3aUqPf56VXuoReyXM4z4vJ9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LX+gTYxGYvW9276r6Mgx87FfEvL6lLhABuZIemuUubeqJrPh1+2fnkX9pdqWf6SFqTAkxlVA9hnTQS47POkf6ZjR3bk0GTgShwawqshRijXZojWovlA0mJTFrRUCDFu3xGDiduYt5eL2FBe7WUpO/DNefT8oEbm/XADXufU26Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MeOwgl1c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gjpuQOWf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5g0g3012130;
	Thu, 20 Feb 2025 09:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4ILVqypVQOUyXwuAm6
	I3aUqPf56VXuoReyXM4z4vJ9w=; b=MeOwgl1cCh6ubUFQCamZGgpqpMsepDE6x8
	pfnQxHrCMrUL+Uh6QIx2SZIRYrC0Ps8HHd2LewuWHSzmX5NXTMrFxjKadkIwShxH
	bwR0k1AmMuM8LTWaKZCpy/yAla9k7+wQ+lZuijOmCqg13nSo/BmsewRJr55bmDXY
	6WpmVlcqrBhtUcdgnKtbiJznaPUNqkMfMpQlkjD+ECCX+xBJFnN7KA92wBWMobTN
	NtNWEOZWlbk810qmxU9r54fnWVipF6xh3dLze8AWj0XbGVMQI11tixNQrVgT6yl7
	HsuzdfVqBkM4TAkmc9Jb2tXYdLKaf2V/rE5yfM4c89tOucWOaHGg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n3p9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:05:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K8A3Vq010612;
	Thu, 20 Feb 2025 09:05:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07enydg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJkyGtNW98PkvWDMDQjcGEg7KK+fQZpJcgecoLUh4i5gFSuqHPpS35hCG/M05DJwZqLmqjIJmtgHt+UpMOCOkxjs1CrOtBPiLrRtgsnlsJLEXZFUvkEvDxpjDbhgsM2wrYDoAh5PtfCAXD06wI0CHS4SsOQlvHSIht/sxu8QX5rumChdbBYBmNPhHcjOtJxWOH44Q1YxFX9VvwUT8uFTPdj+ngSdW4K0FHsuVtnKEmBlFWN6760fgLy1Sxd1MT9FjZmPxEbcOJkIEP5xg4RUQNCNtaLsksFj44ts1+f4Fc5OfrTMUJbwiIU5/sp3LaiZtGTyj7LYJVFxO5nAKPt9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ILVqypVQOUyXwuAm6I3aUqPf56VXuoReyXM4z4vJ9w=;
 b=Z1sUOsv9hOzjZpeO2TKQmojOhEcU5k0Yq66wbtEpX2EefAi7chSdv4ps/1au8N4JfkZFA5WO8e/NXP0IoUHBShzfXjhBvGATG9GccheD/gn4QzlkmT0Bdo38hYnhXKYfbX6kYyN1ikfHDvo64f7jWiKB1rdFsLglkGnSAlnDh+9RDhC+obil3QoGrAdcBJmHuHPYb3f3J1kTScXEhXLHNLszHoTaDXZeF3xglRPcoMw0zRt1tzXMjcUld6GEwNkL0+6CWZwTR2RdjjEnVAK+eeqocsxcipYoYiq/ePlT0pPgl3OSQJTA8hesDbsBE1AWS4Q41z6aKHvwUdlsdEu65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ILVqypVQOUyXwuAm6I3aUqPf56VXuoReyXM4z4vJ9w=;
 b=gjpuQOWf/wDT4Bx6EmBOjV0uFd5q4CjKuiew7T6tjc09rZKvVxG9yX33ts8Zg4Q/WlGiR4b+Osk/OVPX059Xgin2yPLH23/bnpgn+Y3CYjH/jiFpJzrN+RgsEWexd/gRnCw+UYunxB1FI9CcSOB1heWJZT4NuBjRFBzjfWoyny8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4184.namprd10.prod.outlook.com (2603:10b6:610:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:05:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:05:02 +0000
Date: Thu, 20 Feb 2025 09:04:58 +0000
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
Message-ID: <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 267848e8-75e4-4b9f-7a72-08dd518da918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aY9SZ1GOF5nYV3mYC7Rtgxtn0h7tkcPFB6trZehl+DeJaDGlyECZBN8ge3/N?=
 =?us-ascii?Q?Q9yWVPtH0zGsR1MgQBs32J2Ue/jP7mo45pSXDT3Ixp8MRFT0RapoQW/f7FSp?=
 =?us-ascii?Q?lKtsda+mNrbdhF3U6QXTa1WoWLtPy6eKa8BNf62SrvbmNSKJVozGu73nJMEM?=
 =?us-ascii?Q?56XB0ud/rDXscELYbFL7bs5EIbpKhVL/v2zpGv/QQ4PtDsgU130ie5mHEp0X?=
 =?us-ascii?Q?m39m5liE7vutAxgh+XP5riO1GwPzu192T6cqj2ls7G/1/LUX8pEFLYD0nRbh?=
 =?us-ascii?Q?BJ1cNh2YenOJWY1DyL4TT6uMiwey1HRxTQ2eMZL99OWKmOjP0ZstAhKzok90?=
 =?us-ascii?Q?Vp20//moUWQCi/eOTjcFsvgf+cNfKVPW0GsaGg+EmNVdfSvHMgEDoz/GvOHk?=
 =?us-ascii?Q?jahOWwlskrG87Br1lZaWaBD7ViQ8cs7+6PP9bnKLkMKt+nfUBAdp3m29FsTT?=
 =?us-ascii?Q?tgDh3h5W7JHS0iK/9L6ccASb1tswBN07O7U5vURH/Hdyxhav6F7Ea/7mt8Gz?=
 =?us-ascii?Q?Lm+Ia9+6HPEz2Gm7CN0+CGMCMUjOlzXxWUqbafaietaE1sr2KHX6eumP9jUp?=
 =?us-ascii?Q?weUDA4nfvGv+p1VeQtLFIXhavNDhSLWLWr7GVG2iN7UF8X5rZt2PsEOWS5Il?=
 =?us-ascii?Q?4+eQMfDi+WikLDXGQPPyKwSZd3K5unn8DYQUPhiSt36NPjjP7NTCqFgif3Mx?=
 =?us-ascii?Q?4DiV6ynNje2goSTRhUbt6wJoYMSqMql0Eqm8LdzkgGUYMdteMDOqd9isnDti?=
 =?us-ascii?Q?Rb//2Dz0Zc4ewHCbimw13A1I3agFpbiVgmvBCiDGnRFIonCzszZRghKhjrJT?=
 =?us-ascii?Q?WGnC6XHAzaWqfQ50XelVynpRs9mtoX92pMH2pVGDDt/aijJ9EWBlR0eFfhq9?=
 =?us-ascii?Q?QX5KaLoqaiphKdNYAUf/H/ivEYGIe62vfJgVWziWPmBglMWkrA7P1zsHhLOy?=
 =?us-ascii?Q?f3D1LLLCwM91WfpnksNMhiQNW/Tl9CHYcxidj0yxTPL3QKkL/q+Zd6cEaioX?=
 =?us-ascii?Q?GT/hW93yqu6ZRlrwysQSvzlC52m4AZudUonkg85UC0xzNIydTZABELmffBDi?=
 =?us-ascii?Q?usLj0rEA+obJnlOyT+KTLiw9stSfn3pOj95ppRAkuyHq+/NGfJl65uxtHa/G?=
 =?us-ascii?Q?6G5xoV2HVzRYsKoQSZvdXRRdplyYUhFefjoVS/cJDREYlzaYVfVmNBC9tI9C?=
 =?us-ascii?Q?YXE5yl1J+z3broCYwH9rRHLrBZRO2oyKASacvlugK471dJOuHGCjrUAoXJKr?=
 =?us-ascii?Q?OKLDjsJilMd6PZcoZMQB01olzGZPGzfBSBhx/e6W+3AYS/P5gS5dduSwH6TT?=
 =?us-ascii?Q?m4wmCd4czCh2kinpCjYN9KQ3i459U6vE97My8p1FquxWOM/s9PPOigBXfZuo?=
 =?us-ascii?Q?BIp7Rz/NcFAQoVNtd0n/j41HNDDc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dL4QfNU9y7Ay7Aahpr/nYIL0LxrgdZtsNlDxAJANvE9vwIe90h3W7k/MNYsi?=
 =?us-ascii?Q?FVEzzrnRh1MWDbGibRXu0gpMvnvJZMNFRRyF/oF08+cLtAeeVLV2vRSAumt7?=
 =?us-ascii?Q?f0PXUdbG42gd54xBiP3mfDfN9WPj/qcgJOZaVk5axDmDUiMpR5censhFGSOm?=
 =?us-ascii?Q?PWX9mXQI0CQH3Hz2HwbuK/zc6QLyZyjyTa+s32QpJT52OAyP0TcuQZq9uVZ5?=
 =?us-ascii?Q?e4vcUONHjNOjBqoYK+AywrAiYucouY/uV67X6CXM5WbIFsR87HOeoNyDr+gV?=
 =?us-ascii?Q?JZIkeIxRR8HsHFvfaCdrKf3/pZh5fkjw6W9SXa+7jySG5v/xu1cY7IT72TnO?=
 =?us-ascii?Q?ExPqMD9WFyg7i2vYDzwhVp94QGs7OnHyq9eb42W1zweG8gqn6R9cVb6XEbLo?=
 =?us-ascii?Q?GGi/vWYHjIuQCIdY9ysqHNngwUVKxVqgNYI7DSb8HokXYO1KEOqDnSYk7165?=
 =?us-ascii?Q?Xhm+e/EwbNhGl/Vta85K1LdCdbmV9LYYXkfG8h/qPE2x7BxHxqLakW3U659p?=
 =?us-ascii?Q?AMhb0MeDffwPJypWyq7aMXKWZhutekx2AbDq84Ac4PsSFlBEMPCec4ao+LFP?=
 =?us-ascii?Q?+9wnuCdwB3HEzemArPLgqCqmtC9R74F+GIWmsUbLu9tHwu8TP862aDUxEu7m?=
 =?us-ascii?Q?+q6KT0eTFDz+N8IpHYJdrgdAO/XKpV567i+zXbOYVfTV76WoPq8puNjHzLls?=
 =?us-ascii?Q?otblEdl3WmrmPpRi9ZOZlPLA32irdKkD2Bj4dm0gcHR1wGaKojCdpLA8b6Zk?=
 =?us-ascii?Q?bnFK4WcwDDP1qKCiZn61UGPkUy/x4zkXK81hVFWRuEiX4DeD9hT/mCN36Ws/?=
 =?us-ascii?Q?yIUnKvYdQfqQPGJEORSJU3wp10+k+ka2KK82/mFKvcO9ZzWSAkVUdRQu2qZb?=
 =?us-ascii?Q?PusblppHnZ5qyh3wVQS//TWoeu8+TxDdDY8KmtH3dihqH51T2RDkhrNdK/TB?=
 =?us-ascii?Q?pScBWQu4ZK21ybL8k++hWyJaiF51yJU5o6DWRkqHkEvoOC1hmtESs0+Y0RX8?=
 =?us-ascii?Q?BDFUQvHuBS120eIxoUjsb7DI5qjnGsN5Gyx6wkwAh53w50CllUrZnfcIf+jB?=
 =?us-ascii?Q?zFP3AvwDEdTXCUhcQdDKUQGetnihMBdVEWasaQ2oX5F9Sy/hf5gYLONU9a14?=
 =?us-ascii?Q?dz0abxvpsER11qYAV1GMVBbQKFMs7iHYCfA2VLdCL0UM31LIm4TTECrSuZ63?=
 =?us-ascii?Q?JnDfNeJUwKK2mONNH2yeB8WuD/zV0g59ACLSKwAsuV3IJmalcmqxUMmPVGcy?=
 =?us-ascii?Q?gM8U8whJ7APnHd7x6ZEe6ep82ThdvU7iLGZihQ4Sm+vqabIFaimycAXIacn9?=
 =?us-ascii?Q?1d1ruhRkO68z3ei7YH3Znw0GwdAE0ydVEGYjr5hbBlb70AtCZYTF5q5HTExu?=
 =?us-ascii?Q?X0Ykwoxg2SfEtYJ4wpRGtErv7tC3ujRIPfDvTxDRhMLlyXhApEhTvMv2oOHM?=
 =?us-ascii?Q?v1IbbHxefYBWpwbYpJJ/KhjCQxmasyCbrK0g9AEYX745g/nhmM+e7Euyh21B?=
 =?us-ascii?Q?j6NvhOnFZlM6hHTZxB958kyaDgaoiPjOoRzK1JSmulG68cIg3YjVGXspz1+W?=
 =?us-ascii?Q?vQvsoFJ1cnctBTKg/ldFG7Xc/iMPYVkx5UWcjk5ETCJSIsuUagd3ApLYaJD9?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+di+vaRM4k9Xw7blc7jmBuABkmNv7pq6T1lJC+lPxybGDtiJhEJqOD9DPNHaaAqsF7/Ppb3SrMla2bLNs3tgMsLFWp2MsSE6fPrsZ7c/+C5eRbAU+T3HDelzABvB96nXegKtp5hwwhjLQ5AVKyVAU95sC50zWh25gNO6+Iy3ejVTlw7fjNFbcG1qwMSqMxhJKOw0CtJwl8otl1mK8gEqghF4MiYTUU6l9NiZUxUm43Xmb6su+56MGVQ5YBGSTQSW6y+zaUUjhjCf+wnpuDiqTzVwdZ7HIUnS/LNuLArPjxRiWqA8TlkKk0s6N7w6wskruJEO41BnuszsXJr0F34NyXB0gkGpgBv7CdJciI2IAkIM1ClrBI/j0DWSjSTI5+EStMUKL1CG3cz7WbAmt+r9/0ATntd9QFPpsGmqrax99HAwS0BUF8kzBNjrNywc0lzdc4Bx1MJ2tD7JOS4m7HMAQJ3zS4IEcYhjQhvI71LZRgn63+XZSpR3cE6XpBzwZzCLCO1JLKrOmJ4RKMqzR3dOYJhH2C90aDOqjltds5jhpgAywVjEelAQ9kw0D6EmFC73BHvqZo6QZKUrFzXxzS+h8GyOxKJtrH7NrB7T3VdvLRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267848e8-75e4-4b9f-7a72-08dd518da918
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:05:02.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2fzCOHPAv4TqPNtL7FBspetno+kqAr/6gK9tn+vFOPySBSsvIWEf8ZdSU0JuAD7v1IdHI4Pi9EhQlQQOLoOG67/567Yei1H8uwmm8j7Vx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200065
X-Proofpoint-ORIG-GUID: dkf79gws3-9IxMajiXRNPCtI15eI7NJx
X-Proofpoint-GUID: dkf79gws3-9IxMajiXRNPCtI15eI7NJx

On Thu, Feb 20, 2025 at 09:57:37AM +0100, David Hildenbrand wrote:
> On 20.02.25 09:51, Lorenzo Stoakes wrote:
> > On Wed, Feb 19, 2025 at 12:56:31PM -0800, Kalesh Singh wrote:
> > > > We also can't change smaps in the way you want, it _has_ to still give
> > > > output per VMA information.
> > >
> > > Sorry I wasn't suggesting to change the entries in smaps, rather
> > > agreeing to your marker suggestion. Maybe a set of ranges for each
> > > smaps entry that has guards? It doesn't solve the use case, but does
> > > make these regions visible to userspace.
> >
> > No, you are not providing a usecase for this. /proc/$pid/pagemaps does not
> > contaminate the smaps output, mess with efforts to make it RCU readable,
> > require updating the ioctl interface, etc. so it is clearly the better
> > choice.
> >
> > >
> > > >
> > > > The proposed change that would be there would be a flag or something
> > > > indicating that the VMA has guard regions _SOMEWHERE_ in it.
> > > >
> > > > Since this doesn't solve your problem, adds complexity, and nobody else
> > > > seems to need it, I would suggest this is not worthwhile and I'd rather not
> > > > do this.
> > > >
> > > > Therefore for your needs there are literally only two choices here:
> > > >
> > > > 1. Add a bit to /proc/$pid/pagemap OR
> > > > 2. a new interface.
> > > >
> > > > I am not in favour of a new interface here, if we can just extend pagemap.
> > > >
> > > > What you'd have to do is:
> > > >
> > > > 1. Find virtual ranges via /proc/$pid/maps
> > > > 2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.
> > > >
> > >
> > > Could we also consider an smaps field like:
> > >
> > > VmGuards: [AAA, BBB), [CCC, DDD), ...
> > >
> > > or something of that sort?
> >
> > No, absolutely, categorically not. You realise these could be thousands of
> > characters long right?
> >
> > /proc/$pid/pagemaps resolves this without contaminating this output.
> >
> > > > Well I'm glad that you guys find it useful for _something_ ;)
> > > >
> > > > Again this wasn't written only for you (it is broadly a good feature for
> > > > upstream), but I did have your use case in mind, so I'm a little
> > > > disappointed that it doesn't help, as I like to solve problems.
> > > >
> > > > But I'm glad it solves at least some for you...
> > >
> > > I recall Liam had a proposal to store the guard ranges in the maple tree?
> > >
> > > I wonder if that can be used in combination with this approach to have
> > > a better representation of this?
> >
> > This was an alternative proposal made prior to the feature being
> > implemented (and you and others at Google were welcome to comment and many
> > were cc'd, etc.).
> >
> > There is no 'in combination with'. This feature would take weeks/months to
> > implement, fundamentally impact the maple tree VMA implementation
> > and... not actually achieve anything + immediately be redundant.
> >
> > Plus it'd likely be slower, have locking implications, would have kernel
> > memory allocation implications, a lot more complexity and probably other
> > problems besides (we discussed this at length at the time and a number of
> > issues came up, I can't recall all of them).
> >
> > To be crystal clear - we are empathically NOT changing /proc/$pid/maps to
> > lie about VMAs regardless of underlying implementation, nor adding
> > thousands of characters to /proc/$pid/smaps entries.
>
> Yes. Calling it a "guard region" might be part of the problem
> (/"misunderstanding"), because it reminds people of "virtual memory
> regions".
>
> "Guard markers" or similar might have been clearer that these operate on
> individual PTEs, require page table scanning etc ... which makes them a lot
> more scalable and fine-grained and provides all these benfits, with the
> downside being that we don't end up with that many "virtual memory regions"
> that maps/smaps operate on.

Honestly David you and the naming... :P

I disagree, sorry. Saying 'guard' anything might make people think one
thing or another. We can't account for that. I mean don't get me started on
'pinning' or any of the million other overloaded terms we use...

I _hugely_ publicly went out of my way to express the limitations, I gave a
talk, we had meetings, I mentioned it in the series.

Honestly if at that point you still don't realise, that's not a naming
problem. It's a 'did not participate with upstream' problem.

I like guard regions, as they're not pages as we previously referred to
them. People have no idea what a marker is, it doesn't sound like it spans
ranges, no don't like it sorry.

And sorry but this naming topic is closed :) I already let you change the
naming of the MADV_'s, which broke my heart, there will not be a second
heart breaking...

>
> [...]
>
> >
> > As I said to you earlier, the _best_ we could do in smaps would be to add a
> > flag like 'Grd' or something to indicate some part of the VMA is
> > guarded. But I won't do that unless somebody has an -actual use case- for
> > it.
>
> Right, and that would limit where you have to manually scan. Something
> similar is being done with uffd-wp markers IIRC.

Yeah that's a good point, but honestly if you're reading smaps that reads
the page tables, then reading /proc/$pid/pagemaps and reading page tables
TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
/proc/$pid/pagemaps and reading page tables once.

>
> --
> Cheers,
>
> David / dhildenb
>

