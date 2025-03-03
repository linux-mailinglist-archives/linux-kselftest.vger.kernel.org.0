Return-Path: <linux-kselftest+bounces-28030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D020A4BF7D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B42916B5F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755320C48A;
	Mon,  3 Mar 2025 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="csL3i48J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qcBFjp9l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A755204F6B;
	Mon,  3 Mar 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002875; cv=fail; b=ZyOI1/rL8cUxWgX5bVdXkxsXbL7175TSpCEzeG6a1kap0TzFClEuXrr42rdAx00+pp0c4JOo8VTlev5vYBLhsnLq+6W7UsQ4GC5oiomk02HERdEhqN2am+fW2vVgL0BzFNgE+thN4+q51XO3zJnUunx/N5M7LcwVbY8wPWbZZ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002875; c=relaxed/simple;
	bh=03OTpLaRqJwVpPH85Tt7qljkBRxva5tM/WQBaSJhocs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YtYgXRO3tKpYdD3INPQx1Uu4jQ9RNBf1Up+QShmlHQkkFh3sWo/U1BxH6GTQ+xPuXody08EmP8dgC2KvWWjYl5WuJPH9eGGXrzpKkrzwHO9wjIxNvX+U3efB2lE3d5OAMgV/K63LshD5USDOW/iC6Rv2OS9ECt1b3RiYwPqm/tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=csL3i48J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qcBFjp9l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tiUa031358;
	Mon, 3 Mar 2025 11:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KDjE/CIxOjDdy7653O
	+CJGZxkYJXoQK4vzZruIcoXVY=; b=csL3i48JOMsX22YNVY8ya5tdtvJmccPmVl
	RTz4kItXuOTXa86m1BVWCHWMO4fl69+ahqeADARnsTpuZcAPCmu4SeJ37nDR2KqQ
	+KOx1d34RxKrtxf9EA1FAc2aIJbEMuNYnExbduAOl4kGj5ls3ltjwUsNio/7EvAR
	R4BkTjKFzeLS/3LFUEG+9njGT/UnRtEsEk8iOnMuWO9oxXBhut9bfDStNeh5z1V0
	ThUkrqf7oX5eBki4ET3Gsnrb/Hz3/k9Cd9kRHzwcm1HLU8/WhVPy0oEeh3xbwQqn
	SsNE+De/jggRg4q4TpeNkriGxRf+ONJRKMDQQEF3nddONYZWhNHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81tfd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:53:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523B3wjl039127;
	Mon, 3 Mar 2025 11:53:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp83vpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thzPJjXOIBZ/gGqBSQnIyMH+fwaqSIDQ9hGVU6lustpL/icyoKsyhuY3KflLiGT61QI01+lXT0jsuoD9orIY2x4g+FNXgjd6ICfNNBb7mU2kmtTqzigUjc9NISB0um1Ewudey4pXzWWuMdJoFEYxkzt/j0gHkwVERmVWDAf4aiWK/fgJrHdjAM72DTw6JHY6XjXha8uQYXGCHnz9csRMb15LPtwVAnsA2HKIORKRPa3spqLGxTExfEoRpdKS1ikrczttdkgYPHxjjZcMw04TtI4ghjBzkk44WF6/yfRxQClww4EkrekJ9sxh/UEcVBuwgUKsK6DVXytbfce2uCue3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDjE/CIxOjDdy7653O+CJGZxkYJXoQK4vzZruIcoXVY=;
 b=u23d53Cwgahjnnuz9sFLzt+gBBExopwYKmv6ig5/aTnK7tgZORI4M/Oh7NCgRuf3MtG6H68qKpuDGb8jlZfEItwIRubXkrZ1OznKXOQsrKiI2Bwu317G4uGJXoIq8+KRNfn4oQ/AaEhQ08Or5f3lTx1McnWe2VW8Clab0/JXXvTxos2fzg7sQvKPx4/+oSiMOlTfEDSKYmztSFm6AmmiI212UzE1KnJ487+SflG+ztmHeiqcamwCqwhn0//wQV5bULP8MiXjXUAQPfhKQJvsCxSAsltB65zxH5qCCoe9xRWfm6c2OvJhQKsxTQeeMYWNn5NooDlZFTn63XwKBgRrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDjE/CIxOjDdy7653O+CJGZxkYJXoQK4vzZruIcoXVY=;
 b=qcBFjp9lq8HNO8BKkg03TGuor3rkUHJ/fl2AJJq6UhaRcQotpR+yFxs/el4DY6t48kZllLEW1g+1BB6Or6qc0ibQ9pAKMrZqFLo+DgkqVnWRfSUvFNYgXjF1VYqonsXywpSpCrvqL6tmd1hsHaPQJXVZVkQKkkWCaoUgqYp73fc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Mon, 3 Mar
 2025 11:53:44 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:53:44 +0000
Date: Mon, 3 Mar 2025 11:53:42 +0000
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
Subject: Re: [PATCH v8 4/7] mseal sysmap: enable arm64
Message-ID: <47b4983c-e49a-440c-9a2b-cb05496f5c66@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-5-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-5-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::17) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e146a0-44ab-4afc-5b87-08dd5a4a0cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOSHLMRKj1owNX8PxJ6ZGh9WQrACOyxrW5gBq90bd6ksaFE3jp3zwdypUs/m?=
 =?us-ascii?Q?1V687WCA23Fo0cqMhrWlLM4BtpGgNWCUOyQ4NyOAkmm5XsUAyrY9eDhRw1Ve?=
 =?us-ascii?Q?c8eIdr2IWTmhh91keQo7zai/Kj66MYHzRuUVSEhYHC8rnx8i/MGoK7DrdP/t?=
 =?us-ascii?Q?IAfGotvdU83HFYY5iMQ8ClyFJtd/CT9xYRH8JY3icQz5OsqBOE9sUAgCAeo3?=
 =?us-ascii?Q?KjoaKeNCuS8VaaK2Up+uwd57cIbsU6X34BNYFQl4tjgGu0yLjORuCjgZudu4?=
 =?us-ascii?Q?yqkCBJo7zbsrK6y4Ww4qlpuMpZPpQI9EYSHLklC3VB3sWZH4Hl4L7+qCdNe/?=
 =?us-ascii?Q?vTqCJwaadP9hJ0/2w/Hj50y4Ld/uSPYL5BwndkTLjg4PLsV5J6PStXyevgjY?=
 =?us-ascii?Q?Ju4K3iOfmv6Ayd17mEEiKuI5mHo2653m5aNV2j4zPSqSLHqIcdeAjynup4P6?=
 =?us-ascii?Q?MzI2QRUGrQuNONmQbeLVA6QKtUFm3L0W/RnN6nV0TwpA+TG4JUkdtd3qBhQE?=
 =?us-ascii?Q?2FX2BM3veNYXDs9X8OkHJlLyJKKqvVofbTSSlZt0bzYlXxua+nkfJjaVjuD5?=
 =?us-ascii?Q?unIrLb9mZDjhQ1gSOOs3xm5WkHlMo9qYXdmcZnWfrAoJ1v+WddvP+FrY3cfr?=
 =?us-ascii?Q?ij2ZvejbF+V3wRm/2tzvyGScMjN3enLy9H+QUiouSuu8zMLrMIkl1OnwTWju?=
 =?us-ascii?Q?IjRZP3ce+iKM09ciEvCfnLUeFqtbDCel3twfDboH0a8MwsLhx+83KyMZb8hg?=
 =?us-ascii?Q?0xRwRjRy33W1d4C0pWbLhaPZCh2moqEgDP0TEp1VT5rV7YF/SJSX/5V6Espr?=
 =?us-ascii?Q?987lh+CrjYK+GdUnbhafMz5sQv8vx3Cc4V8lO2wDbD97xhFO/Q6QUYbq6lWW?=
 =?us-ascii?Q?RlXAeYSp7VXWeJIsnlBYsutNW+gciTuixrNU4Mn6U/bupMEKlRLA42QdSgMt?=
 =?us-ascii?Q?sEA0+GrvhC3ODRnJT1EGG3f66CdH3OIVYyWFkAklOf6X6h+b2RkNanSIL6xW?=
 =?us-ascii?Q?AvQOEHRb1/MRjfU1VhexyRH57mzzxTNWvh2c7NnaP8/WtOolPcEyn9oM+YC1?=
 =?us-ascii?Q?tdvGlK1Q9/oN3sQvdMcljHZcqEEabgPDlIbW08xtk2PKYIvUDns4DQy4FsCh?=
 =?us-ascii?Q?ORMUTBczTHL4Nf4P4xzBio0S1h1ra9wLyAFgAgKosRdRB/3vC0fsBe8BNJfa?=
 =?us-ascii?Q?bew+Fu7s7LBdU9tF5b3tr2xkOLVXKevFjRNmfEgg+IDjUhKqy+bcjY5b9Mjp?=
 =?us-ascii?Q?tzTrU9tBJkZUbfHUfftYfsTv5P9DD60UczUFGLoI03UcKAOMoXML1cr+qOH4?=
 =?us-ascii?Q?vwCp7Hy20Mk/zS/F9lxshSKAdlpyNwIsNve88EaKvntc1fgREhNv1iKXOcN/?=
 =?us-ascii?Q?07+h0KH9KKb7ech1L2nm1hbYijwe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVreTCwGw14lq/3LRjTjdQx4sAncihLhzf4mSQqDr6Nb+Y42PWnmI+3/hAMy?=
 =?us-ascii?Q?2/R/jryEJk94mHC7rdNZaH7izMq2zlTJ6oXZoxqYfh6dEnzul94lavRXqSpS?=
 =?us-ascii?Q?kk1iGswv42sn640V6MvFBh+vC7AOhkjTN1/6tHZiQEFDrN+xDOKs/o7unYUo?=
 =?us-ascii?Q?d7rar6q5FkdP6tQxewKMwKwLixIaX7RU8B6uC6ShpJvtGS1Wa/ATHPVGku8F?=
 =?us-ascii?Q?9Qh1oT8AyYHRUNWhA65nxhc41A8SE8ujClFp220au5g2SOPxymeh2ZXsICGn?=
 =?us-ascii?Q?1/MCNCuXWDt8gkILGbihKH9lC6/SwaWnMfH60HMXR8el+mcnfPkOuFVbxTTC?=
 =?us-ascii?Q?SMuHIU3V6mHRQaCN4JkoKm+d3FKByYUrYR2oEWWD9Zl/UkorTtI2YugNUZWA?=
 =?us-ascii?Q?Q9VShjLnmaI7Z+1XepCXXi75I5TxykEmnfmgUXkhmhuErYKujQ/YpPt6bDSa?=
 =?us-ascii?Q?xUF8mPzVETfeFMWDvWWwdeHtl0LNMQKlomMcRDiHGKsufORM4Kd1Jt7ZCwsu?=
 =?us-ascii?Q?q/tTEpFuSlnPDlY7TeiWMZf2DFvm5DVVXkaVg0mlqyaCcz62pucXxMc8no7u?=
 =?us-ascii?Q?5+FAKD3IA3jYznh3iT9zaL+y8S1Nsd0u1Pr2ddxh73BdDiPEZ1S1XWMcSgZF?=
 =?us-ascii?Q?jv+eIIczxFKmRAr4S3cfRzbCTsCRsPd1eCPHSbalJHI8dWthj2FkLoqvyk1u?=
 =?us-ascii?Q?SSsI7ySoj4fVKkcOCFnwHVRjRNBsTT3TGaVmKCYvmDgmskp8zf+3ix3iRSPN?=
 =?us-ascii?Q?DSeXhPs7YUslCGuAapFr3SVM685N0Q7izBTSWTkZX68D8vpYB8Q3czNvr0qV?=
 =?us-ascii?Q?+pBZFEtWnH4R+auUEyUuBa2O1oDA9sPFAW7Y2eyoDGs0EVoJiPAzNRR8BJEU?=
 =?us-ascii?Q?qJ93m1ZBrtfPkm9o5Eh6PigbFWO5nNVjsUNzlCfD+9/I0Mn0S4Op+mZikrLg?=
 =?us-ascii?Q?Nb7mwwKTxx6zwEi+QAZQGPoJ+yoctVcqAsVjjQvY6H2DJmFaDu1IGDKCRGus?=
 =?us-ascii?Q?yWCj+6ATdU3jtaPYajB5j69L8pGSPkGXwZPI3u3N/JOcDfo1JvRTXLwO2xeP?=
 =?us-ascii?Q?iKXvDZBGjwK08J/ZuOpFFBrZ+lG4K7eEh7T1ZvoRWAwl+FYhudVyFspK0OJA?=
 =?us-ascii?Q?hTyPOl8jETqfQ/wrB5o333nF5g/KV8WcZh96r3t8ctxhx4KBIG+NsLpIAq0v?=
 =?us-ascii?Q?SZcClMfiffsPzKBQ/WScicAJqiIk3CsyF2GTOBKi9N5gMqK+v3/vpPprtJAf?=
 =?us-ascii?Q?Rt8gWnGN620UdFHcL2QN9vR18UztYr5Ic2OLkahjJac0SLi5RyEuHO4SDNfP?=
 =?us-ascii?Q?Aog7OSU1IPRSzEUM5UIT3RQnwxSaDFVDKqc8PpOa1md+G7sapxAtN6pfSoXz?=
 =?us-ascii?Q?3M2LNcldtbdwTpJ/w/vsHOAARVb0VkDIcrMpDP0m/oyvUb4XbXOdMoWfaR++?=
 =?us-ascii?Q?wQcIBZquhxrTC4QN2gC/tL/VOe0/D8DBm1EKsu27Ylxm/Z7uY/uz5hTgUkfM?=
 =?us-ascii?Q?tjFa4xjzwAFUqfnxcTdtqntUGocz4lEjqYY9NeZAi6sG9IospjyGvnQ5jyaO?=
 =?us-ascii?Q?/SafpA/ZjadMR85oexlJ+pyQlBWwkUbvVvwO4kunT3Maj3uxjIGkVw5vo2wS?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zy0VJ86SUdpqVULJs85KEQeuCw/jI+QUyTjLqRIfOTTybB/h5xD8OjVjZD/GC/LGaBFoCxdFmTRrSxyZT7aFezKLokI4dtsAgLCJ+nENppmTfDTbJIJlhZjXg8aIZbjHmgIPe0KSwbLhISQO83z528WBfL+AwbnZWxm86bNuNcKm5HqVNX5zMLyCx4bSQEzTTHif18ZO+lyN+Ek+vH/XKMpuPNEO74RIkBKEk1fnZCkBFtEmDBr6+TjDczELBnh1cX4z0oX/H7kw8kyjdSCAQaLdo05EEqQJPqAFFq+csZWPa+Eqlf4VrEmh/Q5pLNnbTV5ZGqJnCUU9IS3x2ERm5MW15R1D1Xu2XLHk5KRmowf5OAtj9hnVZHYEuDHpIZAVJC6bdpZrpdZvBXYloRClf5Yj+/cnWOqkViFLycwZVZTr6+h7KaeINL+cyptRBlfK1cpZ9CjpAdVIgMr0AyZI3nLqNRTWPE9SOtzZSx9sQQOwC3szJM6xcKLJlADL3uFbCIXbX4HHNyIFLxN/sCgGqmGV1mNNMI0yyXRtM6WOMsqTdNQePzsvj1xghfPMkROP13GpPxnn8ijQmrtAZdLyIVe3advNNeOHEKGNj5cYFX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e146a0-44ab-4afc-5b87-08dd5a4a0cd2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:53:44.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpIW0OPoTLJMUvBwV4jc5viz4lNwUbUKq04mrQ8lZ/NGo4pNPb1bMgdCSJVqYIr+MNl74oGOYjpIfV0Y8julnMxgKfNy+cS7hKor6fp9uxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030092
X-Proofpoint-GUID: 0mErQ6SD4Ri38-AdxCHAIIZpmah7fW8s
X-Proofpoint-ORIG-GUID: 0mErQ6SD4Ri38-AdxCHAIIZpmah7fW8s

On Mon, Mar 03, 2025 at 05:09:18AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> the vdso, vvar, and compat-mode vectors and sigpage mappings.
>
> Production release testing passes on Android and Chrome OS.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/kernel/vdso.c | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..282d6cb13cfb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -38,6 +38,7 @@ config ARM64
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_MEM_ENCRYPT
> +	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index e8ed8e5b713b..69d2b5ceb092 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -198,7 +198,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	}
>
>  	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_PFNMAP,
> +				       VM_READ|VM_MAYREAD|VM_PFNMAP|
> +				       VM_SEALED_SYSMAP,
>  				       &vvar_map);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -210,7 +211,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	mm->context.vdso = (void *)vdso_base;
>  	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
>  				       VM_READ|VM_EXEC|gp_flags|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +				       VM_SEALED_SYSMAP,
>  				       vdso_info[abi].cm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -336,7 +338,8 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>  	 */
>  	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
>  				       VM_READ | VM_EXEC |
> -				       VM_MAYREAD | VM_MAYEXEC,
> +				       VM_MAYREAD | VM_MAYEXEC |
> +				       VM_SEALED_SYSMAP,
>  				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
>
>  	return PTR_ERR_OR_ZERO(ret);
> @@ -359,7 +362,8 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
>  	 */
>  	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
>  				       VM_READ | VM_EXEC | VM_MAYREAD |
> -				       VM_MAYWRITE | VM_MAYEXEC,
> +				       VM_MAYWRITE | VM_MAYEXEC |
> +				       VM_SEALED_SYSMAP,
>  				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
>  	if (IS_ERR(ret))
>  		goto out;
> --
> 2.48.1.711.g2feabab25a-goog
>

