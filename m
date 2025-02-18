Return-Path: <linux-kselftest+bounces-26867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E675CA3A247
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55146161822
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6726D5D3;
	Tue, 18 Feb 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYVIiehL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nws7lA1L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7A16C850;
	Tue, 18 Feb 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895154; cv=fail; b=XIASXxKQ3FHkbfzaBFW8ayD8RKwmSCmXilN/Juc+dzV9ygtbIcVR5+S6w6dIsWHf3838RHNAUsn28jCUyyimYf6z0x06LM0pLpc5FD4GmYMvPdY2QAdqk+g1qqmvoHre+DG+rWiiYOyysix2jaQmLSzrv25CwkcEw7JeSgzGkmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895154; c=relaxed/simple;
	bh=7GeK3gs43i3yvWPVRvE3gWM8jsMCKuvalfbRL/RasLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9umfLEdZMoqlb+rRsfTZwSkz6BUEDqObOh1Vaf/tifZNGJQczA6qRAIw/BP8xunJbjvhLAd5K4mZC44vcyyL8AFf5OjeWc2AQSwogOazzmzJYg4iduESVz47Ey52OpCnVkwdecUu6mJxJ248Vye82tT7lYozWNknBaX8QmUWb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYVIiehL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nws7lA1L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFtape013287;
	Tue, 18 Feb 2025 16:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=5chU9l1AbthSwfSQhf
	NBUnoLkVj7lZn5bmjvyev1NKI=; b=nYVIiehLnyDCgvSRnYSt459mlUENUjOTxk
	JY73OB3QcFc36Qu2nDpX3OhA2O8oMxgN1XxVFiWmhi4Ywiu6Rcmy9cLBWTNcstQi
	gb/81gJAFlBNcga7JAPYRVJ/PrmgLJkCTwWV+Spe+yI8f5WpCpKZO3A0HiKus+zq
	b1PL7+LYx/cpG19a6mDLfCSoCGX6CLmbxnytOJvENzPlsvttr32Wwt9250P2dl5h
	jcbX0wE8fXkgrKXSbHnLKKE62Pmt/YpQz65ZrbRqkWIm7YCBrAAiMGtN+6cTvsUD
	xXlYQPtatkqi3m3s0NBunc60kbsYHClmRlsyqPEVrsteT1x8jiGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tqxh6jgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:12:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEfKHt024889;
	Tue, 18 Feb 2025 16:12:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc983ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qc4zy5oUFpTlZ2v9Fsmd6nOKJNNSt1qUZzf2TkNtWpAgAESaWV3HLb+vqb5ypeUbBZlntzj3Gd98VR1ZHs1go1A0NtCQK+e70ErcaPkfyuOauzBaJBVtg5IcLoCEkgn4zYJoCQREiUAnOeSMF37MvHyMKQROMiBo6l8ZtC9uVjqnBTO7UdDDFmL7QAyxRyWIdQ4rQl2u9WCoy8tSd7T4AE58HuC7DhsoIPTZTNnR0h1OYiRqEhwsPLhyYAcqY2dR1YhRXv06J/ubRsJWUUfLAw4bVu2gHjJdGdljkgR/RhXkNL5z1WHNRQyjUrOu++E3khUPq6nnvCigSHorbHJWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5chU9l1AbthSwfSQhfNBUnoLkVj7lZn5bmjvyev1NKI=;
 b=m/lOGMldNIO5Hp2bKD1rLoB+j+y+S3aMAt2yGAlvyhAxcRla+NTr4IFcKTM5gAaGx7lF/+dUrpjMstU8S1T/dUKk78czygIWsQz1pmhnNrkLTQ9+cN9ddf/1+SBHMzmDMQOYxFCebLiQXV8Cc5m7QoGyBomdYCmU+kO4vc+JRYAvJnPIbyGnNLQYey8TEqZiCC8+36DZnpkThISWiELH6jgdGK68EBr3x6X80Wke//lopAaOHDnxW5AjLC69EgQqvA7t+6O3F+hjCirvaMUsRcKpKmYRV/kQtliVAjtoA/KNtRpBLXds3KGpylXCSp5IimKsx3uDqJUoSMzytyMsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5chU9l1AbthSwfSQhfNBUnoLkVj7lZn5bmjvyev1NKI=;
 b=Nws7lA1LIKD5HwNzGaSmHXckZo0iKexD6wkr6VRoeGsfGvuHkzCfgXpTPbFdQujRW9/PSl5oDfFFG4zCTr/loR373+/tw8SxrscTj9ay1s7O0edy1Tp1AKMc7XBwbP6faQ0i87lmQ0ThpTgfmSZ0ifRzm6V8PS2kGhwKumwR9zs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7561.namprd10.prod.outlook.com (2603:10b6:610:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 16:12:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:12:12 +0000
Date: Tue, 18 Feb 2025 16:12:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 1/4] mm: allow guard regions in file-backed and read-only
 mappings
Message-ID: <4d6d2942-10a1-46e8-93a6-7ce52b6af3ad@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
 <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0cac3e-2026-47fd-8b77-08dd503700fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCWRpQocu0upqulrWOe1vEzgPZ9rWV+n46tdmCpyK/YKfrfQ50nz104WtVBk?=
 =?us-ascii?Q?qy13C0pQdkJX2Kwo1ghVthMLeDZyNF82/qnJIlCu2Yc9zzRI6I7FObqQkFvj?=
 =?us-ascii?Q?yW4sWR6ANCWA4ATLzCo+1VJeQVa1zdib4vcnmOUoMN3MLsPAkgjB+Qw9R+Pz?=
 =?us-ascii?Q?RWeBOEPBobbKQdQj31hD2Rzib+0S9fwwIw4wgBQoVnHukd2nFe3iiTQ4Xh8u?=
 =?us-ascii?Q?3z01en0jIHQVynP6DxdlrbEJcCUNW8qfKzxwVAaO7dam656pL//9wSmzp5lj?=
 =?us-ascii?Q?s/RBDDfHL1enx4SvYcbVb7vUdiQgr6+4FY58CGowQ4Bp5E2RzF13wC3pnAWg?=
 =?us-ascii?Q?BdGqmLwzMMfmf1fyOJzNxRVD83UPxf2eEsBOJSEgorjDhSLCn3Tpmxj4OHKa?=
 =?us-ascii?Q?vFv/ynRv7NyY5mnIM2N3YRJxq9axUXIV7JgR5+qbHDPJo5GJ8K1yB0YGnyl6?=
 =?us-ascii?Q?4a4AJsvpHQdRiAq9MyQVf0rr982RxhPLuS0d/3Aa8dwU0HnICG5AFPohXk5G?=
 =?us-ascii?Q?W/sq+Airf60V5lQpkLpbmN7md3j7tOTM/NMH/csK3Fz/e2p2/nlq4TfhRGSL?=
 =?us-ascii?Q?CaBmkZtMyUGUqqS2WIQrRFxls5KCBmX6ZAvblgCjXb+ZSmZ1kSpptsPS1YWV?=
 =?us-ascii?Q?NcDTkHt3DAegKSp1QSSL8EloMFX869flxxs1wJbrQdjctZxD9ihrE+mMC1Ii?=
 =?us-ascii?Q?NSlymqJMCw1qrXXF9JxbIvH5ruIzlAa/s+zvsgiYJfN/BPO0EqzUXpkaMFTO?=
 =?us-ascii?Q?ua3+BFn97qDqDGAXRkhUkJ0cxTdOxOiTcZQo6E4xoGogkuFnu9RngbfAzufh?=
 =?us-ascii?Q?NdnyDmcEwmN28q0RF1ngTA5ie3H0p4tsGuBJJUUCFusrqGx0m/nmi5VcC+zX?=
 =?us-ascii?Q?o3vPIMDKMeHFo5XPAJGtESL0uNeLuGcmdTVn2GqiSHIwkptVHS37dhO5kPyC?=
 =?us-ascii?Q?GDodwQCgyI8II8/7VsxrIwwncRhS7HymVWX+8BmUGwFHKGyN4hWkfC3+YFTp?=
 =?us-ascii?Q?vjiW2dGqu6P18SfDxeq4Y7BQQZPZQolg2usdbdOsagwm4eKOGs1fbHRqKchR?=
 =?us-ascii?Q?KcbXRQ5lRR1VtbN5OcOpln6uKWWGeRPoKdNYfKl3gwz4NbuuC3diUeEdrWFd?=
 =?us-ascii?Q?j4R9oVQkjXcC5jxDYaJqcREhcu5SeYTTzJ81ChzL7yjhoAsr/6JXOX3deNCG?=
 =?us-ascii?Q?Fj/fs8Wck0nMt2bHD+MkqdO9YaD8G84zvbXyyw06OJ65QpLWSbum2xe06TCL?=
 =?us-ascii?Q?A8swD0nIs+oeOWkqx0sdFZFDbvCxopYTubm7y/cpqbh8rQhjuMeNuGeWqxrn?=
 =?us-ascii?Q?Fc6RFEe2cbFxokFKsEH3ZAGhSgDUqhpxwwM5EUOmmZZr0DFJuSJC3lErZYzW?=
 =?us-ascii?Q?sTdCV4coikHkot9OwiYr3fhJNANU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzq+CJjUnKeiHchW3YvF7WrTX4iz4DMQsbcjWNMBVv3xBBmNgxMvf5Svv82W?=
 =?us-ascii?Q?YKJIcZxrQ4OLd/5CeIaU9R0B6+PmL5Q1Cz4qPao98t2w6aZtzCL5C0kcs9kK?=
 =?us-ascii?Q?k1oMG+USt3L4C2OWhsOKK0KjBbRtrKV84L3EZSfX9+9tMRRcRnskR9r6ZfwT?=
 =?us-ascii?Q?Po/zXujl4UeFJqN33dFA7kPuu9rEN58jtRyRCXQ4sgW+3N1FrnlOKJ2lbI3k?=
 =?us-ascii?Q?SD9TyBDrUzaEMoon1y+yhnKoC1hI9uV6Ixr1xnd6mN646M30zWV3w3l9jEzh?=
 =?us-ascii?Q?VroRJOfMHYro7cPVNU29l22VlUMSXrwsN34jMjKrDDPy76fbmWu3bJ3dL1s3?=
 =?us-ascii?Q?h76oyaUaj2Tsdy3tNeqdgSMMKQ3nIKe1fBK4En6SVbxA6KEQudJVAz/G1rI9?=
 =?us-ascii?Q?Y/lfHx30myFISmmteyvpB2POHaLLF5zkN3rDDv0py5bZvCfM35Hbujy4Ji2G?=
 =?us-ascii?Q?7ZzC8b7GR5L0ZZUo9jc4BoSd/wi69HxAg2/MfWeAOBUFSnsQPQnv0OepYFiz?=
 =?us-ascii?Q?XwdrQ3IFAuaGnlTqtjJ0a0Ec+oT7gDHPj2Au/XW31faIgdyZxnHMSV4t56Sf?=
 =?us-ascii?Q?nBYHYwQznw+ABTPmLFqVDLc03LdBezAwuXyoCKe+0rtYphmTTLq1USBAzxNK?=
 =?us-ascii?Q?LZobPl1T6+1GJU9ajv2PPkuUJ43BB5xZusM0kzFtLjez+fWPV5cIfP067Rba?=
 =?us-ascii?Q?gaelbYKyP9iM2qrNvjBnD11l9AYSeMQaFbEex3W/u8M/E0BgGmAnPeM1i0ng?=
 =?us-ascii?Q?VsKRZUEMfl4foG3rArI18ppZFe33BCKNdmRwWgW7UajNUKFps1jgeLX4RpCE?=
 =?us-ascii?Q?HMhLtvFVffv7PIuP9uvA3eo9aZ2dFPaiNSI7uQf6wXHPw0O3UDTj9hW7UdqC?=
 =?us-ascii?Q?47QfyEkw2y8izPM+JbaI3//o9NStbPq15OP0bBH+41JLtV0sjo+VBvbWWudX?=
 =?us-ascii?Q?Ny2ehQnuN2sPV+v/PNDyuxsWT+fplZYGZVWYHxBIcFxb7o26GGVk5+iOfB7V?=
 =?us-ascii?Q?qjOfZkZnFt+hTmKKgMaSXJxMpuL+KSGvQWj5kaAw8J1G599EngjKUjWshWt3?=
 =?us-ascii?Q?5LYSycvessf0r2DMt32UTkxe7F5V4Ow2t/ETfw4Py3qp0Io08FrZldhlfTNX?=
 =?us-ascii?Q?6jA2uCNU/H3mkPWofyfO4mnMhZaxp3thxTmxjcKlqVMWPDB7dWbHJG7crI+J?=
 =?us-ascii?Q?BdX8lhAbIbwPbkBUOkD6JxgiWDcnQT7gIeZH/O/XBTUZvYFD+8kqLxpSeAD6?=
 =?us-ascii?Q?d2+wemTCyttfXNQYKPOIos0nbFr8f1jd7+f+OGHSGcJWtZtsTLVHCGPVghcP?=
 =?us-ascii?Q?hCM2LbYzGsQhDYeifLRs66hyUQpQ1o4GWEU56GkLOEvhSgwAn0+dKkrUVLBc?=
 =?us-ascii?Q?MDsG7oix9REsrVeYLLJmu0da6VB6OpJ5DJQPkM5oRyltZAYNW3YNDWbMma5E?=
 =?us-ascii?Q?GyE+ND2S21w/mkfln6fmjyBaOsZ5/vha6mVKFQuNiqSo3by29x0W+5zYBSbH?=
 =?us-ascii?Q?SJBuHdvaRrgTs21lXeRoL8SQ4/eWhTUHiUumF6IRxNCl69x2sEosc6p83tzX?=
 =?us-ascii?Q?RReXyUVkugbyqtvmVbtCd+MCHcpoT1ect08Vtw/gZAjr30puMtnpkimjVP2Y?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dXabuA/Bf3lZeitV4RnuvyegG45hVYYy/cMsc7KdW1dLUIRCeN/oKEkEEy4tKMi/0DhlOy41de/ggZ/4gmMezcE+M/GqoiphPeFCvY/L9Twd+5siLPCb5wMlzZ3OJkCQZnNqNrIJpAX0lbWWszgd10QaihGSUn2zk/Tw8dJ3HQWb9NmG85pMZrIwZ4RrzAhezyAgWgHujcflAucPPbUEQM7og+NTDt6Ye61FUm6TTMx/l3rRKjGMDPrTAYuxGySlga6naUQ+9QX5ARfFqxV4NUTsiIZL7P88ffNbyZJfWF1wDGRYzbr/hfOUdfeiNP8A+eWabNEmMJC19uo1FC9HYhc+c3PP2tN9d48zyAyMOgqfd7dAMg2LPZuGf9vROtx9O1/gFmXV599/rSmSxSmX/MLQNwtZQ/6FNS+8LLbn1LgnOtOA2+Qc7WbTxQP0eMmV1u8gSOJoheCXqhM0iDKaQeKnBjzdj7Ucm97xZnF6zEKsU+BYnGrQWj7pz7O7btRj6XDhM++uPrPLbgsBNZ135viqyZBSmX+pTC5HuiAg4AOs/CGqzE0Qax9/PCOxV/tA3un7IDlR4AHhid+LKPfz23WMhoiwi939cYnShcs7kps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0cac3e-2026-47fd-8b77-08dd503700fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:12:12.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG+5O6c+sNP/AAzryyI4SarQ1InUUfQP6CWcdlV8NWMIpFi5+l8+Vn8L2r37NcFyf+J+cfLyHOOyP0gumMPK5eUfyPBI9V8cERVAQdqygbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180117
X-Proofpoint-ORIG-GUID: G6EbnS01ikcfGP4kfL1_yMJw0tIaFmjV
X-Proofpoint-GUID: G6EbnS01ikcfGP4kfL1_yMJw0tIaFmjV

On Tue, Feb 18, 2025 at 05:01:16PM +0100, David Hildenbrand wrote:
> On 13.02.25 19:17, Lorenzo Stoakes wrote:
> > There is no reason to disallow guard regions in file-backed mappings -
> > readahead and fault-around both function correctly in the presence of PTE
> > markers, equally other operations relating to memory-mapped files function
> > correctly.
> >
> > Additionally, read-only mappings if introducing guard-regions, only
> > restrict the mapping further, which means there is no violation of any
> > access rights by permitting this to be so.
> >
> > Removing this restriction allows for read-only mapped files (such as
> > executable files) correctly which would otherwise not be permitted.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   mm/madvise.c | 8 +-------
> >   1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 6ecead476a80..e01e93e179a8 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
> >   	if (!allow_locked)
> >   		disallowed |= VM_LOCKED;
> > -	if (!vma_is_anonymous(vma))
> > -		return false;
> > -
> > -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> > -		return false;
> > -
> > -	return true;
> > +	return !(vma->vm_flags & disallowed);
> >   }
> >   static bool is_guard_pte_marker(pte_t ptent)
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> I assume these markers cannot completely prevent us from allocating
> pages/folios for these underlying file/pageache ranges of these markers in
> case of shmem during page faults, right?

If the markers are in place, then page faulting will result in a
segfault. If we faulted in a shmem page then installed markers (which would
zap the range), then the page cache will be populated, but obviously
subject to standard reclaim.

If we perform synchronous readahead prior to a guard region that includes
(partially or fully) a guard region we might major fault entries into the
page cache that are then not accessable _from that mapping_, this is rather
unavoidable as this doesn't account for page table mappings and should be
largely trivial overhead (also these folios are reclaimable).

>
> --
> Cheers,
>
> David / dhildenb
>

