Return-Path: <linux-kselftest+bounces-28288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F69A4F6BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 06:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B306816F186
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8D1CBEAA;
	Wed,  5 Mar 2025 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EtZETw/V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQz15HPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F443AB7;
	Wed,  5 Mar 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154135; cv=fail; b=A6Z6lVnWQrboakjw2/3nHc01fwo2OGe1CslNdrDJJe+u+klYOci7L6cxfGn0n1TJjqJS4cf929lXrkWBipn+CYzmQPjMcrA9U3F9aN6IVFQj4hvfJRHbxnAbTb4ZUj69UB+gHrM1l8wlPv5VNwOpiv9cFAtttmpEQqNLS3Mc68g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154135; c=relaxed/simple;
	bh=F6iia0grab1Ugq6dik3KswqzKtaNjdKloW9RcM/AOVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWi6TF4hMtFxr8w/s+2Yp+o1Q/f/FY9X+U4U0j9/026y43AuxuZw8CwUTjUZKAj/xAd59j+yeL/+UpAc91ZK4wyAEEB9Je6W+vCcNPMBoXhv6YHuEe9EzjDgyQ2V840MuaIMeRSIVDVMK6h+uB+aFAI7gl5XGKBX7LDtpyWzNMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EtZETw/V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQz15HPS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255MkqP006805;
	Wed, 5 Mar 2025 05:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ds54k+Cq9lkEzz6jH8
	XEDHWVx7+GkPRNduK3jfmplRg=; b=EtZETw/V3EwTSHRvbBa74bRBR/0seeHVC8
	kChdwroD9dG/K26PNDYatL/+dYSQKuaEAlA/FHCbrkSRGOH98o0raevO3PP9AUyR
	XpeYYZ0UAXUT6RFtiCxBDaRxnFfNHyt2EtfFuizsbwJ13H0Zg5IQTuTMT4ZRS5lm
	awcKuPbfIgjzna3K9oqTP7EWDwDLrsElQg5aUdTQarW+Pl+JfRDAl8w/fyw/S7gT
	F3CdG+J5ot7JXl38nRKGmq5/PUel/ivlvowlGvAs0VbXbANpxJWtTh6HylBC9MGd
	cbdjbCwXyROgo1xe6KNstbcivL7N+SKGD677Ny5iAtlWFcbBiGSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r46k1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:54:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525348Ho010882;
	Wed, 5 Mar 2025 05:54:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbg0km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvdWBjmYOAueoiWt70VdehZiw/t7G6QzzKTR75YoiJfjfZbLdsvNkg3iCJkIWUQTuiI/oOusovla3l1XQr85gPrL7XzR/+rGH9JUbTD/tu45uZWeDTXAaNCL3sPLbduOf1fOiy4HrP3PCfMyKrROvSffdatR1o/fNtAUhZ8MJebdbrzQg9zCrncGDxHzfnxaXEsyHgqUDgR88arUYiFxSBICKZk934bQVPWzB9NY4mJfYnWzZY/QJk3cSVxhuOpOfg7f+sDfka6iPf0P+OllfzEhpiTfISD5RvY5QqAlaDVcd3VA9gbeXNHKkp4xBECEZxufMszPZB+1OQN/lfe7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds54k+Cq9lkEzz6jH8XEDHWVx7+GkPRNduK3jfmplRg=;
 b=Vs4VuT+fm6Meb0BaDK04U2yU7/PIlXUbBbyJL0mWx8xWwgQto3Hlu5EgFJ36xKbBUJs1oFUqZV1Vs20xq9TfCgK0Sz31Fzyrz7qJcppgzac1F+OCOVMGe0F5KjJ22sJ3H41TPhKK/DzmTqJ2hvn/on9h4rcuW7AI/ckM70r3/gXlWVyeMOlomNQhw668EdRxyE+M0ZsKSkKzookluNKBaOv9eO3w3YfF8DSqmoB8ReufWHNSxKS4cwdBSFQfE/a8mUY5PYOZYC/950ffA3MzMI64U0f2YeWyIlxDUM2xcIpvqMW5ormYFPT5M8SXt/kHIv5+xYG1Y8pEWz3G9Zve+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds54k+Cq9lkEzz6jH8XEDHWVx7+GkPRNduK3jfmplRg=;
 b=ZQz15HPS07CjM4yozfGiflweY1a5s6GsxwYDyoiPqZnanalQiCqwvGUDveYACv0/vk7D9DA8ES0fyeo7K8646UGC31uR5cCz7S4kSUNpjGaDud6bTEPHGINgpNr3mdMtVSWfGwP8wLBCHvs7fAshNGNp/Z0sJ3ijEUwwVDFCjtI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:54:26 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 05:54:26 +0000
Date: Wed, 5 Mar 2025 05:54:24 +0000
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
        mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v9 1/7] mseal sysmap: kernel config and header change
Message-ID: <2a42ac63-d7a2-48ae-ae86-568d0fc59d51@lucifer.local>
References: <20250305021711.3867874-1-jeffxu@google.com>
 <20250305021711.3867874-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305021711.3867874-2-jeffxu@google.com>
X-ClientProxiedBy: LO2P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::32) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: e38dac4c-7b1d-4271-6f98-08dd5baa2fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLTaYtCv/cIrtp4BFB/NGNxTqnFvSQQlkOoUKoGQgAMxH3nQJx9qgCxxYIql?=
 =?us-ascii?Q?Bq+6BbSj48oFKOKvezQ3xywURALtLvhGbHRZr23iLf43c/M+G8ca+kwV7sC/?=
 =?us-ascii?Q?zAjbzPV1SU9iG9mMgUEkeqGVdlnqOUJCbYRnAaONM79PLcZRNG8uDPWjMWsl?=
 =?us-ascii?Q?gylAX+dBNvNWCzfLl4go0NGIQoVP+kL4tC7gjUkZgkHQ3NtnI64Vg4R425gC?=
 =?us-ascii?Q?E+6q67cnLW9QtuwrlJRKtlXKAt2UTo9LWr86FmCQIN0ncsjT2cQ24omeBDSy?=
 =?us-ascii?Q?sKJ8FB7WI79zE0ie91jbMFnzeWBpsfjPgY7ilmBVnKmcnsUlhqRckORJsfvS?=
 =?us-ascii?Q?Kpydu2p1tYeQ7UKVku6dEHKiTv36oO5K8qlEijgsTk+7votGTxHrotHam8oR?=
 =?us-ascii?Q?VhHEJNLpprQN7yQ2jT0N7VL1I9amSYZlmKm9DX0F2VB/9ODhz/ORshqWvHjl?=
 =?us-ascii?Q?qHgFTFNEcyc667qZl8+2Qt6NuaojvZytKaGAKY4RnsjnaHC4C+elqWvsyCbV?=
 =?us-ascii?Q?dsr2d9HRA9KUNRj8lguhKCpUd5PXr1UqxUxdvo28jUBPKPNG/kSK0eFY4rfA?=
 =?us-ascii?Q?P1go6e2qin8meaocgS9Y1XL8QyzQqAFmWGfjihiMVWAPOwP0H9cFRiI5QNI6?=
 =?us-ascii?Q?4ctx/4PmoKt5WJgD7o25cd/tZXbDzkSQiffLMV00rNGJbmXSyRuSMQB4Nkdf?=
 =?us-ascii?Q?1k2zrT8mUW/9nVqjQ5YWt2DMohffyJHoSZg2D+7SI/9dtmK9oJSgKPVQ8iDg?=
 =?us-ascii?Q?CUERrVGoqxWLQEZestH/EfFIWti3GnJ4GjeCGA2nLhByLPx/w6doDnLirldH?=
 =?us-ascii?Q?ulPUhVRNcbViXCPLGXJzVfFK5QQ72ijVjsCu6TuwYbBTKmjsQpE8/ss5i/ue?=
 =?us-ascii?Q?QbbDyKxzOkTD7lwXY4RtLJMQ+63J8CdWJg7i6V0KWVzzzcBNwL2iX6U0zU7V?=
 =?us-ascii?Q?6z3U/ucfoPqRgWN4Yn5Y/0WP/VocN66v9Gn7g3MhsKOnbtMOtar8ocW55Tvr?=
 =?us-ascii?Q?N3DbeQS7zonNk63XAaDMjT5qxdke6UNCKzvyX4NpyD3fMFrG4EGsqRCgNSJX?=
 =?us-ascii?Q?Vye4xfkDMV/PicYNcFkmdagrm4iY/OLNpRAvBbgL6LnwgSKTmieuXsZ8CfNk?=
 =?us-ascii?Q?Us1tCDE5bOxycbm5DKr6oLDlAw+Grhd84sARqepK5+xhWeqbuWEF3MqJnWIf?=
 =?us-ascii?Q?NHXmEK+cBWnlgMzYqcSklT3YbDBma7JbbfNfAwuXCyfCqRXDDO7lrL4YAZHi?=
 =?us-ascii?Q?5xQGmxgulS3YMqQdkg7XaMywPFo7lac9KLAhiVWFO02CwznzrmpiR4tqNSE7?=
 =?us-ascii?Q?cfP00/qlzAATcneaQW0rdGM1gnLKORdE5/Xf8iim4q9WwODMbYMw1L6BSHHT?=
 =?us-ascii?Q?2MviSsGbfkjwLh2OALH69umhBXiO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chdj1uXLPb/p2aHta5wiaE/tiKuCaDCdv1InxZ1tuuNBi5qIsNCQG3PgXknC?=
 =?us-ascii?Q?+zODLAtDCSSrD3vAEtK+eGsVTw2ceNEnmO/gunfBl4t+0o2B415l8KnCRhlH?=
 =?us-ascii?Q?72nj4oocWEmkpB8Zo7HjrLBrlYZ7ny/ufA3CoPWq6hsiLOD0CLSXNcIHf8xj?=
 =?us-ascii?Q?NFP34Oti2wA4WhSdx/1VyyIeY2AbykjcKoTZ4G4Vx0bn3hvO3EIIPOVUoenP?=
 =?us-ascii?Q?EH2NwmJKsAV3Ha6mJeszLrKNd8071O9a60G/CvEvXAz4zSk2WvO8fWZPwvmw?=
 =?us-ascii?Q?tRUT9FOsyHAy2qAewW1GrjXm0Gw1SLg75Of76ggfJRZ7Nq302V7V9xImcbtt?=
 =?us-ascii?Q?X4YT2OHCGCqnLHihLFqAGnUkLu5dZw+v8m4Fyqm+qWhrAbigW6phkmtd8nuo?=
 =?us-ascii?Q?A6JjqXphO8Nuo8+nTLockqNe2eu6+LP+5W5arWOTS3GW5usAvjspLB84lWxP?=
 =?us-ascii?Q?XQSn4VrjFhZDQnOL8AeE4Q3mR8c73jx77a1ZgLD9Lh9hTtqteKEK68Mz6QRX?=
 =?us-ascii?Q?uj8btrjG3evgbpsA0Y/bQlWi2H/9NSgzjalClm/BrJ8IugeHiAFY41w+/QoV?=
 =?us-ascii?Q?yp0alL+td/UpMsv5zHVrZW1cbEzO6Q3PjawYGAY4Q9k2EVO9Eh5WC9ERQQQI?=
 =?us-ascii?Q?siafuA9w493j9Dba0wOYQ68nJfLIVrVgwZbGtu4W7TUt0bC6xwiM5XYRRWWB?=
 =?us-ascii?Q?Bgg74Lca+ua5lL7r8O8c+393YA7Sr+mnhGlA/Cz3hjQ5iMuP95u+rH6iz8pi?=
 =?us-ascii?Q?FwFKugXPu1vWQo3zUMe+Om/n+JfO8mZE+KqKoZlBcaWRbFYkzC1bkK2eo/iL?=
 =?us-ascii?Q?0POhemL97OO4YTzoxMMDRuJkuMywwVS7oWqq30rJ1NqdzhTwcwsCDw/bh0lg?=
 =?us-ascii?Q?B6Uuxa4aLGw0jgtU7bm8+MT0dXyPmlP0f1P1ej8voag4COFh+t2AofxYsn9N?=
 =?us-ascii?Q?v/qCAMdirmnBl2RB97/GqojCOkKBpjrGsGB4qKcPmKUv1/WyeOlr7bH/D3gL?=
 =?us-ascii?Q?IB04auLoFrgutlNXue8I7XbQHvg4qZL88bbOg5iOLi5tpJwkpfXGjcDDaSv9?=
 =?us-ascii?Q?oHjKBTJJI7ygT4PEOEQr0VerzHIjFqK/16L469TxdOn+nBC5jUD6Yo6pCM6e?=
 =?us-ascii?Q?+Xjk8n26F2FUyxzSdELALWMsii3aVsMGBptQqO56lvF1qzySDQOyxmPubA5x?=
 =?us-ascii?Q?uqxYELY7yiwwMqXfQaH9FsihmSb/+/SvS9hi+lgob+h09m+PEf8tCKlKAIYc?=
 =?us-ascii?Q?5rBDkq5LeniMgHF8bmfHM3iC4vig/o8xEUxuu58zn85PsE21fYqEKZygeUSd?=
 =?us-ascii?Q?9fWn//qDO0l3f+vktvK1HQq58m67ghHr8W7OrDXGYitSTPa7Vc/GM/QF+snI?=
 =?us-ascii?Q?Ti/ac4XzuCvm64rrGaLNFl6o3msZWBgVI6NybzbaIXbuLxnWwc8OgIx4MwJG?=
 =?us-ascii?Q?XQy9syLCOchudI0yGtIuz9X8/W8UVu6z7b+VTmyhf898GtLyNl9O7jZb2Bl5?=
 =?us-ascii?Q?lrZbSQ7IpYMJ8bgZl6BU4Bo05CFV4TIsA0ejlDgL4qJMPx+30IrSIKJVLJiu?=
 =?us-ascii?Q?WbwMADH+yAjt9vMmCgXP1i3QRiICpl1XneWS1O6pOHk6WJTcjq/KOr3Sg0vj?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XBTRzPJ7Do9ymhYbN//mxVYPzN+sC7u5XER4BgckhfwjxcAmjaxZFJINJFU0GyDZc2FrtBiOFwtyHsLXrGNnsNyUZx72cHCsUZitWYcZf5+mxLJH1xBVqHJ2FjnKL0Rfb5shWeTafTlxxzp3sYJVH0GQcugRB4uLtO9NfXGbcSolw1PH0dv9S030MpBfO570WmUJfSisuzcw4lTJRkcYgxyvHg0xiE+k3u6vzMmbmDnUqoBZano/Qyr7WIuHTa5LUyjylHefnKAP+dK2ujDq2KD6GRMVgpm0sQqJz/jdhnWznuN3Dsa9fRe486ULZZ+KBqCqYJ2fVaBY6ajyuevkaTtD0uyFnZUo7TmEpd4slB0qs24Rb66u2lgOPCrKuyE5KKVPNtVeGSQRARfGnkYejan0TqpbhO11UenCBEo1mQyT9LU6ysTCR6/Ll7x3VnuuMqwxKHBUW9IFYLFuw+JVPyVZoXH+mhH2QtmdWTgcoIUx6j1008zVlR394pU8gZQgbuHRL70V00pWRels6wIHmEKWpx4sM4m5JWi0auqlMbe7pQYZKAKOEDKEx4cpt8qA2Isxcg3rx6dPaUIURbSZ8vObUaFg4wxauOdOZYnmxtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38dac4c-7b1d-4271-6f98-08dd5baa2fe5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:54:26.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noCAgweRHLfXCs5xRU+g8pkc5fZWOm0rsBjt9AQ5o1m0KR/Nbp+9PhSnIDtSc/XYP2/dxe7M/WrcQQsXyGjJIkNhtQPHnMZJBJltwUv66UU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050045
X-Proofpoint-ORIG-GUID: 68l4hqiqeEYTyBbZPdnAYX-bXja5NAjR
X-Proofpoint-GUID: 68l4hqiqeEYTyBbZPdnAYX-bXja5NAjR

On Wed, Mar 05, 2025 at 02:17:05AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide infrastructure to mseal system mappings. Establish
> two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> macro for future patches.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Kees Cook <kees@kernel.org>

Umm... I reviewed this too? :) unless you made substantial changes here
(doesn't appear so), please do propagate tags for each revision :>)

Anyway, FWIW:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 10 ++++++++++
>  init/Kconfig       | 22 ++++++++++++++++++++++
>  security/Kconfig   | 21 +++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..8b800941678d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>
> +
> +/*
> + * mseal of userspace process's system mappings.
> + */
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +#define VM_SEALED_SYSMAP	VM_SEALED
> +#else
> +#define VM_SEALED_SYSMAP	VM_NONE
> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..7f67d8942a09 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>
> +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  special mappings calls to include the sealing flag and confirm
> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. The existence of this flag for an architecture
> +	  implies that it does not require the remapping of the system
> +	  mappings during process lifetime, so sealing these mappings is safe
> +	  from a kernel perspective.
> +
> +	  After the architecture enables this, a distribution can set
> +	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c294..a914a02df27e 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
>
>  endchoice
>
> +config MSEAL_SYSTEM_MAPPINGS
> +	bool "mseal system mappings"
> +	depends on 64BIT
> +	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Apply mseal on system mappings.
> +	  The system mappings includes vdso, vvar, vvar_vclock,
> +	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  WARNING: This feature breaks programs which rely on relocating
> +	  or unmapping system mappings. Known broken software at the time
> +	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> +	  this config can't be enabled universally.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> --
> 2.48.1.711.g2feabab25a-goog
>

