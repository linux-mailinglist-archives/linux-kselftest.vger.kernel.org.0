Return-Path: <linux-kselftest+bounces-33385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849EEABD3B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB991B647CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99419267F74;
	Tue, 20 May 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sXVpO4G2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UlCJ+oVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096225DD18;
	Tue, 20 May 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734208; cv=fail; b=P2J4VOskq8/MLLVr5qQrrbuwQYAX+IAIsLnlMGPVZJmNeQhmo+zZ6v10HEbRF2NMoPiX1a62k24gEE9vtsKlGPF0YaIWB+7o5czgZNvxfPKTE8vG/6ujLmpzCWSYW5SfFr8QAipPkQtH4VAjG69HX0a2LHlnFdW5Z90kG1FOiHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734208; c=relaxed/simple;
	bh=D7OGX+owInvfE2P29xncTC9Xtcis1DJdqgDimTbKSRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qj4ztdjebqm+gi+pC/AZxtGTRpTMSGdE6PF6HJ0DfCsGu7yuLagmp6Yyq992t+c7ihcisZiDYnvMp26s3GF3fLBLgEQCTnDRRL+aK9Xu0lpjqQpFMrMlwkOsoiTJkgXxCO9MqAhjVbwhzcxC8DRlE8MLsZwq37gE0GpV4Zt2z7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sXVpO4G2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UlCJ+oVd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9Mu2r011166;
	Tue, 20 May 2025 09:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2C1Y1AviA7ienOgTky
	xbayyazM7GnXhOG4CgTSfsXik=; b=sXVpO4G2EZyvjvcFROEfF6Fr55EIn9Cf8r
	VhohbJrY6ibWUwoDnsxmowXOLEIYIOuFu+zVR0iPg5Pq2nbRKQlWhDL5uf9FMHHq
	oFDjvYjdJm64TsmRk95F3jFUPb00FHvfJ10vShEg57+R5/72nSJUs5A2itbGX7w2
	cV4M8ZslrLGf1MZOO7eOCLhY1LnDdOfwB5BEOWe4cZ4u6o8p6KZieLbcHFAls5+5
	5H4YoA5GZ4R81LUS4flcAySNSrY4LwwBuq0J+tVCx1U3Nc8WXgQ7QG8bcv3oQu+M
	lvMo1XsALQYSpVLEt5wqV4FAk7tShfxfIIGQ4lZm2+y7Bp2ku9Cw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdcegvhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:42:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7tLwO028839;
	Tue, 20 May 2025 09:42:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7rrt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX5GiusWrOGyWm85b81rs0FKyLS7/c0UBfvyeXH40S13MW87iobyB++qFOCg19bnjrt3az+9alpAvH4b1Ix5quswTTqysDEZogIYV/sMuAHh470lxeC0xIeeMtbXFWE4Kt566zQ041ZulmYFGrA7s5SwAieV6MZNcB3vdxAGLD5Makoq5JKaSTYXlw1PmVeUMhiM9l0cJwdaiQYRIsJX4fhfDT6H5AB5J+PVSvFsr512B68rBEAYgkZsDocWmFGOrOLC7Cn6CJH1H/SCxntof6AtKckK2+xFG6Bv6BJuOndPBTx6sgkBQwar2aqrcKwXOTN4tnxtr3Vk15Vdd2Wjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C1Y1AviA7ienOgTkyxbayyazM7GnXhOG4CgTSfsXik=;
 b=W2Rl3Q7Ec9b2uoQdYcRDpfeKUA3qBDTDFsVNENHACKPFrDPYsZItYZ9J1CNvtUf3LI2s+7iq78e2dQRlydWsaLQ4rWgnxPKCLvPGPwuw9CmGtj8TZWQvE75zVgdCfJ+I4gY0NGJJApBMxecte80aVCKc69+jYwLF5YXLIZOtxWKDqrzK02xVhc+dCSn4aj96KNMjJJmHC6I39KgwiCcyrxJUbF4JQnentTCX4/dnCdaTNm0kBbkMfk/BHNRdiIqZImP8fZuQ50i3xHMZRWtqebP8SwlILhZR81Rnttu5do//anWoU6xgKiGzIFIfRJBYMCmfgvmepnr76xoshar8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C1Y1AviA7ienOgTkyxbayyazM7GnXhOG4CgTSfsXik=;
 b=UlCJ+oVd+6SYv3EVL6Djs8jzlkvrsIjJkUO02fZB44vo+V3ppjS5u/wkrtaWDAGBpOsh3CiRralqpdtFQvFuii6PlTKoTBtaio5KsOBLDC3DjPOm8E2077uPjd8HSn8WPHOlkjTUd4ryt4HHaVxpod0yDj/+4Q6mcthtqI5TcKw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 09:42:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:42:26 +0000
Date: Tue, 20 May 2025 10:42:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rientjes@google.com, hannes@cmpxchg.org, rdunlap@infradead.org,
        mhocko@suse.com, Liam.Howlett@oracle.com, zokeefe@google.com,
        surenb@google.com, jglisse@google.com, cl@gentwo.org, jack@suse.cz,
        dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
        catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com,
        raquini@redhat.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, yang@os.amperecomputing.com,
        thomas.hellstrom@linux.intel.com, vishal.moola@gmail.com,
        sunnanyong@huawei.com, usamaarif642@gmail.com,
        wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org,
        peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com,
        baolin.wang@linux.alibaba.com, baohua@kernel.org, david@redhat.com,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        rostedt@goodmis.org, corbet@lwn.net, akpm@linux-foundation.org
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
Message-ID: <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
References: <20250515033857.132535-1-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515033857.132535-1-npache@redhat.com>
X-ClientProxiedBy: LO4P123CA0452.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 265a4ff9-80ca-4b1b-3f56-08dd9782a132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCEn43Rw+NwpAWRRDmWt61Euw1nKcXIAA3pYLoKrVtZH5h0/Jp+pwtS0hQst?=
 =?us-ascii?Q?Qy+SMMohy3SdVRFAwNRiYN2z6jNiX1IR5Yciv8NpzWqyXUfZFQPgfXOWskOe?=
 =?us-ascii?Q?X6cUO4t9alZuXWLCRgjsBxC8Mp7mv6bYKwvg6hoI+pzppAoINFLTLwH142xm?=
 =?us-ascii?Q?q+upf/U8RLnbs7RHgiBLbVF8MpABdZx0iszsrqOtwgo6TiMnXzcSr7f7kiV0?=
 =?us-ascii?Q?8fWFI9B7Mb036R1o8CfHOpgE0jWIf0JjosSUGumexcRvlL+Tnr2NVCnvJN0v?=
 =?us-ascii?Q?vz81rtCLghgxh8OS2eEUu1p6gRIHueKCfD37fXiGFgl+3zEW3avgmNlrs5UR?=
 =?us-ascii?Q?euIkPDsLzXqQP3HCpISS/TOLXAGHEqeX2yBvfA6gHcMU2ieUvvae5Yw/zx09?=
 =?us-ascii?Q?bbZMubIjn908h57zaFF01R858SZN6tSvZr/8V7uL+tYQXNjAQa/tkEHn7cEk?=
 =?us-ascii?Q?JYzwz2CocydlfpoHsw1pYalnZs4baPS2Nek703FBeZGDZ2D9JWXuvZGzg2Fa?=
 =?us-ascii?Q?KX/WNbjRaIFwENkMhW+qoeb2o7q1LHOjPiPtNtMQ5+4k6c83t6eLGpD+bEZQ?=
 =?us-ascii?Q?gUcqF3Np6DZFbULuzH/bGLRe5n48hN9TMQ0U9YMN6c3a13Vo/JbziaS9XpI3?=
 =?us-ascii?Q?w0p5xi61mSCJXR64ekCRSNDCSfEFuKQQDeMIkCZGJmYYXUvQUx9PclNovYWw?=
 =?us-ascii?Q?CJpQ4jwI0JviEC6iAzIf9rQUvuD9nDrpbM64P1Ub4mW2wUHc8VYN2b2piQsT?=
 =?us-ascii?Q?8g9Ccw3ghaJKBV1M3t2kAMMP8Ii4YZ8O7qJyqDnz6LQGad0+vfkghFudJ/mk?=
 =?us-ascii?Q?bYciatZGGvgar4T6PLokLIm4DMyRrk0G3DJHI7m1wd1a6xaSChuwCsP3jR8K?=
 =?us-ascii?Q?lELrXMVl1qeuCHEB5GuMfXdE9RIKCc3Rh8RdI2bU/TXCwlzO93Yt9Es6sj6T?=
 =?us-ascii?Q?r66Sw2ZhL+iFaryOGhtsL325PDv5P4r0HFMlUpCjgb/cAA8gqW3d7b+E5DgX?=
 =?us-ascii?Q?hQXn5e/I4ELZ4cDvV5xvdz06dF0YDt0gl5fZlMCHdqXo+tuD6pw/1q2vrtcG?=
 =?us-ascii?Q?KHRy3HUosn6pw/qnWGJr+5j0sEHhOrO9M6QDNo2ccLpBbbfIq8JjmkY2vu9h?=
 =?us-ascii?Q?FBN8qjk9xElxvz2/s57kMWvuWSe7WrPZrC3xF6ShcRr1dduoG2Ugel5dQhD7?=
 =?us-ascii?Q?zd7YXM09wtxovqRcDfJo6cQ/nXmp0WKFomIGkgBTJz0K9HaLVWtudnhzYteq?=
 =?us-ascii?Q?fRDQ4Z/ApBIzZJZrfrL1c6l4FIHrVUmvg2ddaQxc42G+Ru6lMGfLz5pSH9S+?=
 =?us-ascii?Q?tVb03jE5YdEdtg2e+OdaXjPyFTvn0TJTpwXYiTkV4AvcaNf6Q7fmXEnMHfEg?=
 =?us-ascii?Q?dwsOJuZZHczh0q+9y3k30iquKhbU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dN2TLINk+uGIZX1nJc5/qjAvEBMCK4103Y6PfFR/CvHbVUNHNUIsA8An8V58?=
 =?us-ascii?Q?iZxmVK78PbogdjttCA+ILHQjkt9XLMTx+cba9b3kKGeJm1DU3CJTXVZbKyEk?=
 =?us-ascii?Q?dv9OBQR9qE6IU4ZFW7Ue/Qo0edPAXvOcz/6uIBBAmTlrncEsUYM6Z3OwsGQ0?=
 =?us-ascii?Q?Lc29uaYWnL7uPSl1juT+Iy+KUavH4O0U6PXgUZoAswvRrNh3QPNV8KtzgAWV?=
 =?us-ascii?Q?CX23G2J3jq7/oE/pNSBFxsZow7t8O/hfMbblRipu6F0jyhqPCkohHaQngLT8?=
 =?us-ascii?Q?veiH+59A8oM0AwN8yRQIJFxgMCErzBXB7BcHsMaTpYoV8UaPLTh0Z9gPjKCE?=
 =?us-ascii?Q?TxRDSFrtkmKbSEWyyYw2l4TP8AyuwK2XOrnwRqvkIAcJNDuzv4omO2wZjE8p?=
 =?us-ascii?Q?dvHOfaERyfRQVAhOegfoaCopqLaVN4PEn9kNvIxRmXZuhHPsfF+bMkOSLMWj?=
 =?us-ascii?Q?fawG1RtAi4A8JLwrS/4DO8TPXFX1ls/qp6IxpfJv6iUgGzV9P9timDOyJgAo?=
 =?us-ascii?Q?YW2/Ql0Ql2ybMHV+4qGH4DvEBZm/FqEuzwJtGQf4lE0pr1VJPoh8AqZeMDtz?=
 =?us-ascii?Q?Lmsr7CgU/UPN9GkhSeRLnOEOq1yREHPdLSBApY0BFQ1hIWksur6q/kI7TszW?=
 =?us-ascii?Q?w0RyzD5/wsikMri0FRRwRjZZaIRCRg0L777cGzbKhC283y6xBleODMdiYzs0?=
 =?us-ascii?Q?/yKLSFTcP0NUQy+GesAoJPOGvg2CD5Fn2jdl4JZrSAnODfpF3Hh8rkDCPwM5?=
 =?us-ascii?Q?OlosRZfTAgT2jWHGmALyUrWTi6yOoJzbwYFNdqk+MkbV4w2l/P6JLN4B1hOd?=
 =?us-ascii?Q?IJO+CpHJyZDh9g3eghQ9J+TC75xdokLdQHuxjUxdTgMgt2OGdpj+s6Cy4zzY?=
 =?us-ascii?Q?z+ak7SMj0SP75MG07MNq8k+QAONupCKtJik7QvQAjklHyDgBwcc8/71/o/df?=
 =?us-ascii?Q?xuHh+wTPUIJVDXd/JqTP2j2NuEQsl3nehMbj1vUVU3HBcv9Lo4W7F5qiHeDh?=
 =?us-ascii?Q?YJlnosubTTOXorLK2Sy0UKsE9+icEvy8gf4z4taDsNrxYZNewOl1U41VSHPe?=
 =?us-ascii?Q?skUO9jWnHwG/Wnu+FcJrugYJ7DVqA1X2MFh44zMHtcqROaGICCGzzdGai0bZ?=
 =?us-ascii?Q?pso7cY9e3zDVP56Wo4lIGy0WTvZejWRWGvWa63bLFEEFrAVm3LMNiFPz8sen?=
 =?us-ascii?Q?9YLp16PTCaC8mKCSpbgHsK+68uYY9hXCyea5dxzqIKFGIjuujtFwJu+TSZOl?=
 =?us-ascii?Q?BUWNuvBfahuD+R7GRlRbHHScEFy2D1F5o5UfWeuI3/gyKuUQoPlo09fwD+3C?=
 =?us-ascii?Q?uPK/kL4+LnWlZ1d9IJPVPS89Bweb7WQ19CQFKmYq2trT3yRbOgtyD0/9OGwS?=
 =?us-ascii?Q?+p1O9/pYGDoUG9bUbCrgLtXiFZL3KSXxxc9WpHFXzXcxa5ENzPZqJeeDSf5Y?=
 =?us-ascii?Q?bcDjyLBF+MFj3dGVR3l/ScyYXiCTi6lxEkgmISp+O/U/7LzRnYRlR6BET7I5?=
 =?us-ascii?Q?K9yHeyjTKwtrBr8EZGgzMT0twF1JnBMDF6+FQfxcjdLQW9AGDi/UeYZ9widm?=
 =?us-ascii?Q?z4SRq4Sxhu073Z8OTJwRxqWq9FaW0W8ijJz2r+El7fNt50CHiP2nDtY0kIVw?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+uo6AZl2p/A5i9RHviMynmr0XwdNkf9JBU/qXITmPyDqs7XtYTdCLvAZgozZg2wIySb0xUGHKHDZIHZ60NZXewr/znRDx/5kllcKyXpUo41wac9gqnkSrCYlKqH0ZtMdKtyvX4g3LL058aCMhDY+e+cg0e3dOD/FI/GISCWIQomHc/H6VHyZQ956YYlMDyQnm3v1Y2S9ZRKtvPhClqwzziRYZMSYHma1lIcX4EBAOWKS5xu6Lz/LQPGhM74IT5J4KbH5OSdfQDKiKptF4WM5Z8acUIerxHm8Enb/qNPKyNzYXkpyCvEJAqQd+e1wPV8zO6vKKj0L0My4YKdDv/kZybibUH4W7Egfr7NiClTuwIpv/6juetcRQlsoid7UsJF9l7/L51FkANZOnC/htQ70NIZAc2OJtN8mW3oaMfJI3csjzPzAw5mg0gAmTQFR5DnUAcVaVtLfwukTpW9AOkPTyt8FmEzSyHsAoCitukRnx/1gxW7TXK36YpPp6PNjaDRithbnoN4Y3QnJH9uipS3UoEj+3hZCIzO7/CPoPzXkXhHk47uUg0V8QBsM//6er22jBlMn7yRrpdiJI34v0ZzXDjE48hyiyIwdPduWilnXeNs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265a4ff9-80ca-4b1b-3f56-08dd9782a132
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 09:42:26.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjmE/khu4tu8YJ0SmryidcJWEmRnTVjxxKB3/CepIKa+rVOuEFCh2dwyTey76Kx0EvT8Pk8WoGJyvzn8ZyD07Geqt8i+N+e3dW72hR6+n/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3OSBTYWx0ZWRfXwr2u4kosHx6Z h97tqAkXE1FvVI0NrOVyOEIsvoQMjUvI+ahtdM82UbS13E0j4IiTx5PGfobkPTXFA8E70POHJqn Y1jFeA3K2z7fFjjvG7zPg8yIt6EzdGPjE4h8s1DtidhT3WupJdHAg43o0IQZHlBQenf+7U7W6mx
 mU7eIgLNqGKBsChpDz7cgzld7udqz5Vyf/+EJ11KqjS4WdjF6yGcVOt6yo2IAy9cbPMzTy0ldf8 vgnqU7r5HU6zfNGhjmKQhLw77XwQVcdVVyHsHv9z9AGTLOX73rRc42Aa7JpQkpgR+dkQL8O4zO9 GOtc5RvZi0HEX/WcihxMm6JcFl425nR5lhNvPZBx1MQC1VWsgyyhICl/tKNLkqm0dTW0DsBMF4o
 krDy+47ArRqWaE2V9I6R6g79bN9r3GooFEihP4emPNFmy8vXQF914ffn1VPSWyAu9TQnG7zP
X-Authority-Analysis: v=2.4 cv=WO5/XmsR c=1 sm=1 tr=0 ts=682c4e86 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=SyxhtnC_sLGWBsb-U_wA:9 a=CjuIK1q_8ugA:10 a=nT7k2FPyCkIA:10
X-Proofpoint-GUID: Q9YUAtbeQiwBFLzpBLnZmCc_u1u-O_NA
X-Proofpoint-ORIG-GUID: Q9YUAtbeQiwBFLzpBLnZmCc_u1u-O_NA

On Wed, May 14, 2025 at 09:38:53PM -0600, Nico Pache wrote:
> This series is a follow-up to [1], which adds mTHP support to khugepaged.
> mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
> configs to make sense. Without it global="defer" and  mTHP="inherit" case
> is "undefined" behavior.

How can this be a follow up to an unmerged series? I'm confused by that.

And you're saying that you're introducing 'undefined behaviour' on the
assumption that another series which seems to have quite a bit of
discussion let to run will be merged?

While I'd understand if this was an RFC just to put the idea out there,
you're not proposing it as such?

Unless there's a really good reason we're doing this way (I may be missing
something), can we just have this as an RFC until the series it depends on
is settled?

>
> We've seen cases were customers switching from RHEL7 to RHEL8 see a
> significant increase in the memory footprint for the same workloads.
>
> Through our investigations we found that a large contributing factor to
> the increase in RSS was an increase in THP usage.
>
> For workloads like MySQL, or when using allocators like jemalloc, it is
> often recommended to set /transparent_hugepages/enabled=never. This is
> in part due to performance degradations and increased memory waste.
>
> This series introduces enabled=defer, this setting acts as a middle
> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
> page fault handler will act normally, making a hugepage if possible. If
> the allocation is not MADV_HUGEPAGE, then the page fault handler will
> default to the base size allocation. The caveat is that khugepaged can
> still operate on pages that are not MADV_HUGEPAGE.
>
> This allows for three things... one, applications specifically designed to
> use hugepages will get them, and two, applications that don't use
> hugepages can still benefit from them without aggressively inserting
> THPs at every possible chance. This curbs the memory waste, and defers
> the use of hugepages to khugepaged. Khugepaged can then scan the memory
> for eligible collapsing. Lastly there is the added benefit for those who
> want THPs but experience higher latency PFs. Now you can get base page
> performance at the PF handler and Hugepage performance for those mappings
> after they collapse.
>
> Admins may want to lower max_ptes_none, if not, khugepaged may
> aggressively collapse single allocations into hugepages.
>
> TESTING:
> - Built for x86_64, aarch64, ppc64le, and s390x
> - selftests mm
> - In [1] I provided a script [2] that has multiple access patterns
> - lots of general use.

OK so this truly is dependent on the unmerged series? Or isn't it?

Is your testing based on that?

Because again... that surely makes this series a no-go until we land the
prior (which might be changed, and thus necessitate re-testing).

Are you going to provide any of these numbers/data anywhere?

> - redis testing. This test was my original case for the defer mode. What I
>    was able to prove was that THP=always leads to increased max_latency
>    cases; hence why it is recommended to disable THPs for redis servers.
>    However with 'defer' we dont have the max_latency spikes and can still
>    get the system to utilize THPs. I further tested this with the mTHP
>    defer setting and found that redis (and probably other jmalloc users)
>    can utilize THPs via defer (+mTHP defer) without a large latency
>    penalty and some potential gains. I uploaded some mmtest results
>    here[3] which compares:
>        stock+thp=never
>        stock+(m)thp=always
>        khugepaged-mthp + defer (max_ptes_none=64)
>
>   The results show that (m)THPs can cause some throughput regression in
>   some cases, but also has gains in other cases. The mTHP+defer results
>   have more gains and less losses over the (m)THP=always case.
>
> V6 Changes:
> - nits
> - rebased dependent series and added review tags
>
> V5 Changes:
> - rebased dependent series
> - added reviewed-by tag on 2/4
>
> V4 Changes:
> - Minor Documentation fixes
> - rebased the dependent series [1] onto mm-unstable
>     commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relaxed()")
>
> V3 Changes:
> - Combined the documentation commits into one, and moved a section to the
>   khugepaged mthp patchset
>
> V2 Changes:
> - base changes on mTHP khugepaged support
> - Fix selftests parsing issue
> - add mTHP defer option
> - add mTHP defer Documentation
>
> [1] - https://lore.kernel.org/all/20250515032226.128900-1-npache@redhat.com/
> [2] - https://gitlab.com/npache/khugepaged_mthp_test
> [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html
>
> Nico Pache (4):
>   mm: defer THP insertion to khugepaged
>   mm: document (m)THP defer usage
>   khugepaged: add defer option to mTHP options
>   selftests: mm: add defer to thp setting parser
>
>  Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
>  include/linux/huge_mm.h                    | 18 +++++-
>  mm/huge_memory.c                           | 69 +++++++++++++++++++---
>  mm/khugepaged.c                            |  8 +--
>  tools/testing/selftests/mm/thp_settings.c  |  1 +
>  tools/testing/selftests/mm/thp_settings.h  |  1 +
>  6 files changed, 106 insertions(+), 22 deletions(-)
>
> --
> 2.49.0
>

