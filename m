Return-Path: <linux-kselftest+bounces-19774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C596699F59C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84721282236
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091A2296ED;
	Tue, 15 Oct 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDo40xoj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ykf00hC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBA1FC7E2;
	Tue, 15 Oct 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016956; cv=fail; b=EOpLvFR+hFLTQ/R0cFXxxSbhjy/SBkPEsIotC3V9IHoMUioOZA6nSG+3WMTqb7mEQnZmd33FKHw9uFffiGzMi9bmFTd+jcAdmzg5igwRWsZgpoXPnkvA6inUld1s+BLqY2RgsUkTEe1xBYSIPjeOj5F+jM3K4uUQ56OTiyH+Qcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016956; c=relaxed/simple;
	bh=m++saFBJbHZycGDnIYb0OrJSxzhUdL/ULRrvJCJlUhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPnCEWBC8oz6Tc8bMu8GyX4FEkiExS+EDCk8l6LWE39YIqufXRoziHQulOXXaOh8/BTqyHvlZWv7/GERsF1Mkj9Im4SMoWd/tqEEFjN6UgTG9lUO+60oFTYBFHtlpIHBG/VtEj8PQNgGXQL9aXiwgAWkzh8whbLpp5/QXAvfgOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VDo40xoj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ykf00hC2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtg6L018280;
	Tue, 15 Oct 2024 18:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qCTqehcjqoAeihjUFd
	PV7l7DZxj30Yt3I9eS4NwWb/4=; b=VDo40xojnky6ImwBN2tT9mZ1dPRATZ+M6B
	0i2tUaqN47KkhMIZPSBLJOWXFPOfP91PUegGbSOuMFaMqKjIjFiiOjr+n87+eWaW
	dDxaXvC2YvLQLpDjr7e53C7anZZ/naOC6SEYuzoFrzOzLIJCK6fNK4AyctX4HnUK
	37AVGhzqZrLoABfRvciaueA3Rvnt06hP3y0aEEmd7pkexivx3RzWt/ClVwYK+j48
	WmzLhc+xg+XIrN3i0ocBnnQx02ierbZjBSAU7U93V4tE8Xieeu07i+0+/MqwzmEn
	L9XOc17RIoPvn1soOSFnM6YDP6RCsIMMT7GxCrPqzPJqkeYJPifQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhchexq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:28:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHxpP9011105;
	Tue, 15 Oct 2024 18:28:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fje4rgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjJM9piqO7oUZYpU13wrWacb0cVqcL2F3AXdXtuSwtRBYkEjD33CxsMW5CkLNbwTZJzO5toRS8Pg8W1yh48vKkzMO3XrSCtz92l6L2uGvDcV346XY6qy2IlwjbBeWefawk9bQpv+xABeBOITIve8JC7ZO08+NU+mwv4Lqz0EYANGFCDYeC7s+r7jE4QO8995flxE6lL796eXd/UE45NkUpljSkvkJjgg4vFrCjMYwOTVmZvxnPsgXWlK/+au8Z27DIVkIOi6kh5yUNeDdjllgz4h0I71a5/hFXfRoc4grlWYt1ZVSUT9bQFvw8KGerqRAwVGxbVpehikKzIy2dulSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCTqehcjqoAeihjUFdPV7l7DZxj30Yt3I9eS4NwWb/4=;
 b=N6uOmzSqMoPNjjxvHDNJzuRiOcenMLpT/DUXFVagUhQsJ1g2UKp+x7bZbOHDxHD3F440DebwgH19HdS4Z94xcembU7z7E9Gz9zB74Ch262m0hyXp5I3EDkeKNYqXjGWnZRelqwO4sNkva92opO6Oe6VhF78NYmUyem2X5qi7CoQs42F6+qjV1LnQs8yN3+rD9Zn2/YyLWL3a8a/eXVHm6TDCQhasdr98RYSbMiS3rK+ZQzCq5csekiysnq8GGcrpTLG/SWTu1anL5zCwDmDw3AVLBdPWg5ZApYkVuQZ8MfhtUOIs5kA3JkZTDOPm2cDBIDMtB043jXFanTdPj+G5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCTqehcjqoAeihjUFdPV7l7DZxj30Yt3I9eS4NwWb/4=;
 b=Ykf00hC2FkBNsPW1CHGLwDWrW19yaqyVYcgBSGWmEvk46zYvG8p/9NrMPaB6/iUuZeZx4ZDubcGDLeot5f6FAgrzDPb4WBTMwOOn6AYklLJIpttxSFapsaYHm1ojalr6Zc1EI/g8fpYDCJ0slr0yl7IEdXkEgjjTGgxzHteqOf8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 18:28:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 18:28:44 +0000
Date: Tue, 15 Oct 2024 14:28:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v2 1/3] connector/cn_proc: Add hash table for
 threads
Message-ID: <h2kgrfr3ru7qqq7xc5yplktyz26kr6x23fycfh5zzwq2cc4ai5@5alik4kqzoji>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-2-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015173014.1083069-2-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fee85ca-2521-497c-130c-08dced473398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnOCNdMYfgWYBquVYDlOeHfbwAlZBqOwXbsecWLVkZZIyb7egn8h2ZNB1TyS?=
 =?us-ascii?Q?Y7mcCI9O75HVmSP0WDrBUZLlxLoZm24Y6itqs3EOP7rta7Orp5kVTPxZkvA7?=
 =?us-ascii?Q?MWrpLsfLxuG7W339kfXRIlV5aXGM6KBVmpq/NVQxRcPOYj00Z0FNFE+kRd4P?=
 =?us-ascii?Q?3Dryewqwq1b4ALCFAlbvSBW0MiFWF3tnASTjISykrhotUo9AM3jWIkpL8CZO?=
 =?us-ascii?Q?kTgyeamELY5awl2YDFKTTEfaLnAbpvUCqUez/CbQCfIRJXH0+Z0DqgJvy5NX?=
 =?us-ascii?Q?X8DtmjyY79+JgyV0SfMXQp5CpgDlPGkyOyz8D2dztjzAVDLOQU1f5nfPXNHv?=
 =?us-ascii?Q?pkdqVqQRaPP0MsKMYckOpDfktALxsj3B1bp2Vyl+yQeI2dJRyqWAkN5SH4pu?=
 =?us-ascii?Q?G7SXPdB9xAjkgzb6WrAlRjMMh4vz7EYxhURQnhWllU1kYkjUqbBhbJStwGGn?=
 =?us-ascii?Q?hfbQrDnLDo+L6GPCRpHuplYO9Jsbxbr2khz4nMF1MK4EdRl0NvyuM7qTqWaO?=
 =?us-ascii?Q?mS29ty+3ejfeyF2GrDDJxK/nz0AI1TOE7nAjwM0aUw2vASpE+ZYwGGiTv+dg?=
 =?us-ascii?Q?WbfnP1iNgS6dUas6Tqok8GkEiiZKE27F49Gyv+dDvtDasOmlsBVK8ftGZlTR?=
 =?us-ascii?Q?qYVk5VihPOxTiu/SAMpTCtDw2NfJQZYWAuoeYkgwJQNpfxmfyraD5yMpA20W?=
 =?us-ascii?Q?uQeNLzRAYZ0O+pXcsMXjk36CSo/Wo+e3aQjQmASkYqk03xOZsO6wPRsPwAbu?=
 =?us-ascii?Q?Nc4CMH+671GkSIvQqJYdurFh8xu1MgQoxg00CdhaeylxdOjQMrbqPlVvUWdP?=
 =?us-ascii?Q?8BeIm9y6KEAKXbYGap5JLoGObTpk+8UMvfveuyZyWuo9qEI74h6QRz1zS75z?=
 =?us-ascii?Q?eSkW3OOPKC0vlBB/CNNbmdddrRKzKPv5SI1NVy1fq61NBk7X6MVaRchsbnlv?=
 =?us-ascii?Q?B3SmYgyhE7SQHtOq2st6bI1czrpiIXHbdsNSs2OWDxYL7NqONO49MliPvHOq?=
 =?us-ascii?Q?zJssOGP6vi7ap4FOpK/3FtLpOKUaPvJBssTZ5JHbZn+hV7EehmE7oo7z9BKu?=
 =?us-ascii?Q?y+aO7qslkVVhA/Fhgy5s0wXlF76U3DzPff5KreXl/185/UyWL/EwG0tEuI5W?=
 =?us-ascii?Q?/mB/Drz2PFIMHfzZlGmjUNvfzaN+LyauL+BZpgmzZqX5Y88Nmf9oDzNx3846?=
 =?us-ascii?Q?h4hRxmKmyRlpTTRiRT+ZiSHzNv1g7+35AUvuuG7mzXDnGge2agRS0fYY8YpL?=
 =?us-ascii?Q?XC1dGGbK549RUZTSYmLEEqGjjQFhHGOVrRPbPrBTyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWbVveNddWGlTjKwnf9NklF2/hoI/XExoa2AsJlmADgQ4KPzPRwyYlW45kKf?=
 =?us-ascii?Q?WrV8YWWpKLw3sbqufMpIU/SKz6KpYU9LFFBh/75sv0a7Kv0cbjqNsy1Yf8OL?=
 =?us-ascii?Q?ZS5Lh7GIQY4A7FerZjZw2s5vY7gUVSBbeTJTLUx4mUCoaTcxW2boHSNueQsE?=
 =?us-ascii?Q?SF1JZmJndEx3Y0m3HF15MclW1o1EyjxbqWyl0b2OXGw7vm22JR3V02V8+KAJ?=
 =?us-ascii?Q?6vaO8ATH54DbX74KY66jFJu7SuDDQvNASW61VYWD0Z2Z0KNRsO6RXLqinrjU?=
 =?us-ascii?Q?JH65kAiQq0EtEXFqm6VmP2Haj/j32Oa2xg5+gSPqPBnTjLO+MFTq0NuqnRy2?=
 =?us-ascii?Q?DcipAMYkh7qewCLp+WHJBjgEc8wteZ/BZyfymr1D+9jep2ZbHvwa9e8n3ZSd?=
 =?us-ascii?Q?igv08x9yQ44aJbKWbuinbZaGuGoZKaAZr9rlfnltgp/zjFwT/+r2MulCnU/b?=
 =?us-ascii?Q?X85A7pOmI4vFSmFqPU7WcWZk/4Zn3ZzaqrkYTARILbJYU9TSxGIdSckx9EnD?=
 =?us-ascii?Q?8gRSQ08Q3og8dYfN2ZMa9SnHut1ZJqxX38A0QvwWMA7ZEirxyBMCfeFqU4pv?=
 =?us-ascii?Q?LixIb/tgDXu5zadRMiMgAuFeyNzdKBUfnxIM2XNyICIFrBBxkdWoTyS78NtP?=
 =?us-ascii?Q?8chlBpDlhXIjLESg3lC98iWAR5dVDiBpS4cWlQByDzIINV5JqdD/LLZJaT3h?=
 =?us-ascii?Q?+LM2vPBtKal1YtB3sg5twyW2K8k97LSNHY+UmThX2EHGAfYtUlEuchXuN1UJ?=
 =?us-ascii?Q?6F7fbsJBdNc1KC0FTFiwXFim6pyk5t06pVf8yM1vR3qtLOIXilh5yHoHy6IJ?=
 =?us-ascii?Q?mXJFiMcKvLzMGVtbCFypTvqEeAdmYhaUO/tUq1Y11SroKqlpphkwbHg58cdW?=
 =?us-ascii?Q?1CCOzDsh0CCI1RUYU+aOZkAZQmwF4UjZYhIBynQyrUBjNu+s59lDs0epUjUl?=
 =?us-ascii?Q?D/GiHwleXfDVfqtkPRLL/58ZPs1X7norlWjawfDuuPl6xy+gRwQURNxMY8Jz?=
 =?us-ascii?Q?lJT9UAlzT/3W4AlnDK+G4bTYFhAQW0tvu2oRiRd/rgnUJaPYlNlV/zH5VQ51?=
 =?us-ascii?Q?NmcCrWa8jypNlEEPDVFb+Iw4/ndFHo+tgHNYqrvgLlN5nKTghskdUSNF00Tf?=
 =?us-ascii?Q?osrM4a+85G2frtv9QslpMVcrPQKOBzsKQVwypHWEp0RY02KIfqNZ59qSanZ9?=
 =?us-ascii?Q?RG3tj3QqK9pmAsRAEuiMkWZUqC1MWipY7kyj6c7FxkJzXb3Pegu6dXqHkewW?=
 =?us-ascii?Q?j/oFu/oGBJcZrINaoVcCA6h8zdormzYQxYWRy35Vlf2aLYGZTaTp9fyoK/3u?=
 =?us-ascii?Q?0E+PeulcuVGzz6NQUXxQxyeB8hIb1iVCqveMA+szX7CXJe6sufFgBUdJ62XN?=
 =?us-ascii?Q?Ek75YVyqmj0DVS3TTv0WCAkbWAJ3aIYw5dWedgccfH5nPEDzqfgeQzr1q16a?=
 =?us-ascii?Q?OtiKRqinNgOAJuXcHKQ5snjaRROLmLOCJiEJyDttHFPcZPopDAV8GnrHwaS8?=
 =?us-ascii?Q?FIkR4Qv+LQGhprPR+xZxC70dTyTcg2FqIyJaIO7eF1yVSKJgdAjvPgWsjKvD?=
 =?us-ascii?Q?ThiE0/E7p6g91hkZc0A/1mR3aynaudg3oLwRNjonAT9YNXBYhcqksTQ3c/6z?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	91yc5rBn5eEz+lZsNJsNWSlpH9510QLtCJqZrklxjpZapqybaE9RB92iMwQq5qZe40neK4vU3DdOOVQ0vsmXMWoBl1ea2YcMQ7SjXiBwV6r9w+vMUd/358S4i+hxBLn3Fp3hi+oqel7OSqkGYbxdt/oeX6eCea9TPkMLdZadItJ4x4UWGI1BQ5iLb6+vPrxCpx/EfnW1ENBmwcu65aMEXBoTlNy6tSqirAqChlWCd4ONn4VwJSNrpJELgQoSeigC5xfdoFP7H54iB8KArYqRxqXy/Fcox6VR7XQye/AZDjiS0WDzpiUsjoGH/YRqOsJZa/ABoJj2VQjkT2cGRnonitYrj/yz0QuJ2+vPkmma4xvzjYEGhcy9gyIgZe2agmforvUElQItGsRTGo+q0aEsUhKlCKqAuws4BYrg1eAZTlSFyK9PCimM4DmbdE9Xb8WnSN3B/eB9oJxqnD/HJWS2L05lv65oMrcNYPFJ5xu7KXIu6+D+f8Qsv7R2HIB8YPmXxWU4zEKSip1s6z3wNSkDFEaAUtssb4Va6W2OygwdYdGYGW8KjsJ12Hry/dJccOgvqHTzfpnUETfV/kEvWDntm0/ZCV8xP2pkNumJs+XTwTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fee85ca-2521-497c-130c-08dced473398
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:28:44.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3emyRs/MKhoseO6a2ZkQbFqB5G/8XB9dVzbwlpyTTRSj700sv80zsNvDPybFfWyEioYmnW35tJLXL8CWNM2Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150126
X-Proofpoint-GUID: 5bu3V0o77m5veoltFVGd4KEYNe-H-vsq
X-Proofpoint-ORIG-GUID: 5bu3V0o77m5veoltFVGd4KEYNe-H-vsq

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [241015 13:30]:
> Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
> thread to notify the kernel that is going to exit with a non-zero exit
> code and specify the exit code in it. When thread exits in the kernel,
> it will send this exit code as a proc filter notification to any
> listening process.
> Exiting thread can call this either when it wants to call pthread_exit()
> with non-zero value or from signal handler.
> 
> Add a new file cn_hash.c which implements a hash table storing the exit
> codes of abnormally exiting threads, received by the system call above.
> The key used for the hash table is the pid of the thread, so when the
> thread actually exits, we lookup it's pid in the hash table and retrieve
> the exit code sent by user. If the exit code in struct task is 0, we
> then replace it with the user supplied non-zero exit code.
> 
> cn_hash.c implements the hash table add, delete, lookup operations.
> mutex_lock() and mutex_unlock() operations are used to safeguard the
> integrity of the hash table while adding or deleting elements.
> connector.c has the API calls, called from cn_proc.c, as well as calls
> to allocate, initialize and free the hash table.
> 
> Add a new flag in PF_* flags of task_struct - EXIT_NOTIFY. This flag is
> set when user sends the exit code via PROC_CN_MCAST_NOTIFY. While
> exiting, this flag is checked and the hash table add or delete calls
> are only made if this flag is set.
> 
> A refcount field hrefcnt is added in struct cn_hash_dev, to keep track
> of number of threads which have added an entry in hash table. Before
> freeing the struct cn_hash_dev, this value must be 0.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/Makefile    |   2 +-
>  drivers/connector/cn_hash.c   | 195 ++++++++++++++++++++++++++++++++++
>  drivers/connector/cn_proc.c   |  55 +++++++++-
>  drivers/connector/connector.c |  83 ++++++++++++++-
>  include/linux/connector.h     |  43 ++++++++
>  include/linux/sched.h         |   2 +-
>  include/uapi/linux/cn_proc.h  |   4 +-
>  7 files changed, 375 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/connector/cn_hash.c
> 
> diff --git a/drivers/connector/Makefile b/drivers/connector/Makefile
> index 1bf67d3df97d..cb1dcdf067ad 100644
> --- a/drivers/connector/Makefile
> +++ b/drivers/connector/Makefile
> @@ -2,4 +2,4 @@
>  obj-$(CONFIG_CONNECTOR)		+= cn.o
>  obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
>  
> -cn-y				+= cn_queue.o connector.o
> +cn-y				+= cn_hash.o cn_queue.o connector.o
> diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
> new file mode 100644
> index 000000000000..a0211cd99132
> --- /dev/null
> +++ b/drivers/connector/cn_hash.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/connector.h>
> +#include <linux/mutex.h>
> +#include <linux/pid_namespace.h>
> +
> +#include <linux/cn_proc.h>
> +
> +struct cn_hash_dev *cn_hash_alloc_dev(const char *name)
> +{
> +	struct cn_hash_dev *hdev;
> +
> +	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
> +	if (!hdev)
> +		return NULL;
> +
> +	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
> +	atomic_set(&hdev->hrefcnt, 0);
> +	mutex_init(&hdev->uexit_hash_lock);
> +	hash_init(hdev->uexit_pid_htable);
> +	return hdev;
> +}
> +
> +void cn_hash_free_dev(struct cn_hash_dev *hdev)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	struct hlist_node *tmp;
> +	int bucket;
> +
> +	pr_debug("%s: Freeing entire hdev %p\n", __func__, hdev);
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_safe(hdev->uexit_pid_htable, bucket, tmp,
> +			hnode, uexit_pid_hlist) {
> +		hash_del(&hnode->uexit_pid_hlist);
> +		pr_debug("%s: Freeing node for pid %d\n",
> +				__func__, hnode->pid);
> +		kfree(hnode);
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	mutex_destroy(&hdev->uexit_hash_lock);
> +
> +	while (atomic_read(&hdev->hrefcnt)) {
> +		pr_info("Waiting for %s to become free: refcnt=%d\n",
> +				hdev->name, atomic_read(&hdev->hrefcnt));
> +		msleep(1000);
> +	}
> +
> +	kfree(hdev);

It might be a good idea to set hdev = NULL here, like
cn_queue_free_dev() does on free since hdev is passed into the function.
Although, I cannot find a reason for this or a comment as to why it was
done - so maybe it's not useful.

> +}
> +
> +static struct uexit_pid_hnode *cn_hash_alloc_elem(__u32 uexit_code, pid_t pid)
> +{
> +	struct uexit_pid_hnode *elem;
> +
> +	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
> +	if (!elem)
> +		return NULL;
> +
> +	INIT_HLIST_NODE(&elem->uexit_pid_hlist);
> +	elem->uexit_code = uexit_code;
> +	elem->pid = pid;
> +	return elem;
> +}
> +
> +void cn_hash_free_elem(struct uexit_pid_hnode *elem)
> +{
> +	kfree(elem);
> +}
> +
> +int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid)
> +{
> +	struct uexit_pid_hnode *elem, *hnode;
> +
> +	elem = cn_hash_alloc_elem(uexit_code, pid);
> +	if (!elem) {
> +		pr_err("%s: cn_hash_alloc_elem() returned NULL pid %d\n",
> +				__func__, pid);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	/*
> +	 * Check if an entry for the same pid already exists
> +	 */
> +	hash_for_each_possible(hdev->uexit_pid_htable,
> +				hnode, uexit_pid_hlist, pid) {
> +		if (hnode->pid == pid) {
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			cn_hash_free_elem(elem);
> +			pr_debug("%s: pid %d already exists in hash table\n",
> +				__func__, pid);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	hash_add(hdev->uexit_pid_htable, &elem->uexit_pid_hlist, pid);
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +
> +	atomic_inc(&hdev->hrefcnt);
> +
> +	pr_debug("%s: After hash_add of pid %d elem %p hrefcnt %d\n",
> +			__func__, pid, elem, atomic_read(&hdev->hrefcnt));
> +	return 0;
> +}
> +
> +int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	struct hlist_node *tmp;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_possible_safe(hdev->uexit_pid_htable,
> +				hnode, tmp, uexit_pid_hlist, pid) {
> +		if (hnode && hnode->pid == pid) {
> +			hash_del(&hnode->uexit_pid_hlist);
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			kfree(hnode);
> +			atomic_dec(&hdev->hrefcnt);
> +			pr_debug("%s: After hash_del of pid %d, hrefcnt %d\n",
> +					__func__, pid,
> +					atomic_read(&hdev->hrefcnt));
> +			return 0;
> +		}
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	pr_err("%s: pid %d not found in hash table\n",
> +			__func__, pid);
> +	return -EINVAL;
> +}
> +
> +__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	struct hlist_node *tmp;
> +	__u32 excde;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_possible_safe(hdev->uexit_pid_htable,
> +				hnode, tmp, uexit_pid_hlist, pid) {
> +		if (hnode->pid == pid) {
> +			excde = hnode->uexit_code;
> +			hash_del(&hnode->uexit_pid_hlist);
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			kfree(hnode);
> +			atomic_dec(&hdev->hrefcnt);
> +			pr_debug("%s: After hash_del of pid %d, found exit code %u hrefcnt %d\n",
> +					__func__, pid, excde,
> +					atomic_read(&hdev->hrefcnt));
> +			return excde;
> +		}
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	pr_err("%s: pid %d not found in hash table\n",
> +			__func__, pid);
> +	return 0;
> +}
> +
> +__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	__u32 excde;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_possible(hdev->uexit_pid_htable,
> +				hnode, uexit_pid_hlist, pid) {
> +		if (hnode->pid == pid) {
> +			excde = hnode->uexit_code;
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			pr_debug("%s: Found exit code %u for pid %d\n",
> +					__func__, excde, pid);
> +			return excde;
> +		}
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	pr_debug("%s: pid %d not found in hash table\n",
> +			__func__, pid);
> +	return -EINVAL;
> +}
> +
> +bool cn_hash_table_empty(struct cn_hash_dev *hdev)
> +{
> +	return hash_empty(hdev->uexit_pid_htable);
> +}
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 44b19e696176..9205498fcf0f 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -69,6 +69,8 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  	if ((__u32)val == PROC_EVENT_ALL)
>  		return 0;
>  
> +	pr_debug("%s: val %lx, what %x\n", __func__, val, what);
> +
>  	/*
>  	 * Drop packet if we have to report only non-zero exit status
>  	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
> @@ -326,9 +328,15 @@ void proc_exit_connector(struct task_struct *task)
>  	struct proc_event *ev;
>  	struct task_struct *parent;
>  	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> +	__u32 uexit_code;
>  
> -	if (atomic_read(&proc_event_num_listeners) < 1)
> +	if (atomic_read(&proc_event_num_listeners) < 1) {
> +		if (likely(!(task->flags & PF_EXIT_NOTIFY)))
> +			return;
> +
> +		cn_del_elem(task->pid);
>  		return;
> +	}
>  
>  	msg = buffer_to_cn_msg(buffer);
>  	ev = (struct proc_event *)msg->data;
> @@ -337,7 +345,25 @@ void proc_exit_connector(struct task_struct *task)
>  	ev->what = PROC_EVENT_EXIT;
>  	ev->event_data.exit.process_pid = task->pid;
>  	ev->event_data.exit.process_tgid = task->tgid;
> -	ev->event_data.exit.exit_code = task->exit_code;
> +	if (unlikely(task->flags & PF_EXIT_NOTIFY)) {
> +		task->flags &= ~PF_EXIT_NOTIFY;
> +

nit: extra blank line

> +		uexit_code = cn_del_get_exval(task->pid);
> +		if (uexit_code == 0) {
> +			pr_debug("%s: Returning with task's exit code %u\n",
> +					__func__, task->exit_code);
> +			ev->event_data.exit.exit_code = task->exit_code;
> +		} else {
> +			ev->event_data.exit.exit_code = uexit_code;
> +			pr_debug("%s: Reset PF_EXIT_NOTIFY & retrieved exit code %u from hash table, pid %d\n",
> +					__func__,
> +					ev->event_data.exit.exit_code,
> +					task->pid);
> +		}
> +	} else {
> +		ev->event_data.exit.exit_code = task->exit_code;
> +	}
> +
>  	ev->event_data.exit.exit_signal = task->exit_signal;
>  
>  	rcu_read_lock();
> @@ -413,6 +439,13 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	if (msg->len == sizeof(*pinput)) {
>  		pinput = (struct proc_input *)msg->data;
>  		mc_op = pinput->mcast_op;
> +		if (mc_op == PROC_CN_MCAST_NOTIFY) {
> +			pr_debug("%s: Received PROC_CN_MCAST_NOTIFY, pid %d\n",
> +					__func__, current->pid);
> +			current->flags |= PF_EXIT_NOTIFY;
> +			err = cn_add_elem(pinput->uexit_code, current->pid);
> +			return;
> +		}
>  		ev_type = pinput->event_type;
>  	} else if (msg->len == sizeof(mc_op)) {
>  		mc_op = *((enum proc_cn_mcast_op *)msg->data);
> @@ -432,6 +465,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			sk->sk_user_data = kzalloc(sizeof(struct proc_input),
>  						   GFP_KERNEL);
>  			if (sk->sk_user_data == NULL) {
> +				pr_err("%s: ENOMEM for sk_user_data, pid %d\n",
> +						__func__, current->pid);
>  				err = ENOMEM;
>  				goto out;
>  			}
> @@ -442,21 +477,33 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		}
>  		((struct proc_input *)(sk->sk_user_data))->event_type =
>  			ev_type;
> +		pr_debug("%s: sk: %p pid: %d event_type: %x\n",
> +				__func__, sk, current->pid, ev_type);
>  		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
>  	}
>  
>  	switch (mc_op) {
>  	case PROC_CN_MCAST_LISTEN:
> -		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN))
> +		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN)) {
>  			atomic_inc(&proc_event_num_listeners);
> +			pr_debug("%s: PROC_CN_MCAST_LISTEN pid %d: Incremented listeners to %d\n",
> +					__func__, current->pid,
> +					atomic_read(&proc_event_num_listeners));
> +		}
>  		break;
>  	case PROC_CN_MCAST_IGNORE:
> -		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
> +		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE)) {
>  			atomic_dec(&proc_event_num_listeners);
> +			pr_debug("%s: PROC_CN_MCAST_IGNORE pid %d: Decremented listeners to %d\n",
> +					__func__, current->pid,
> +					atomic_read(&proc_event_num_listeners));
> +		}
>  		((struct proc_input *)(sk->sk_user_data))->event_type =
>  			PROC_EVENT_NONE;
>  		break;
>  	default:
> +		pr_warn("%s: Invalid value for mc_op %d\n",
> +				__func__, mc_op);

nit: Does this need to be split to two lines?

>  		err = EINVAL;
>  		break;
>  	}
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 4028e8eeba82..506e3cbedf85 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -271,6 +271,67 @@ static int __maybe_unused cn_proc_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +__u32 cn_del_get_exval(pid_t pid)
> +{
> +	struct cn_dev *dev = &cdev;
> +	__u32 exval;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	exval = cn_hash_del_get_exval(dev->hdev, pid);
> +	return exval;

You can remove exval from this function by returning the result directly.

> +}
> +EXPORT_SYMBOL_GPL(cn_del_get_exval);
> +
> +int cn_del_elem(pid_t pid)
> +{
> +	struct cn_dev *dev = &cdev;
> +	int ret;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	ret = cn_hash_del_elem(dev->hdev, pid);
> +	return ret;

You can remove ret from this function by returning the result directly.

> +}
> +EXPORT_SYMBOL_GPL(cn_del_elem);
> +
> +int cn_add_elem(__u32 uexit_code, pid_t pid)
> +{
> +	struct cn_dev *dev = &cdev;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	return cn_hash_add_elem(dev->hdev, uexit_code, pid);
> +}
> +EXPORT_SYMBOL_GPL(cn_add_elem);
> +
> +__u32 cn_get_exval(pid_t pid)
> +{
> +	struct cn_dev *dev = &cdev;
> +	__u32 exval;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	exval = cn_hash_get_exval(dev->hdev, pid);
> +	return exval;

You can remove exval from this function by returning the result directly.

> +}
> +EXPORT_SYMBOL_GPL(cn_get_exval);
> +
> +bool cn_table_empty(void)
> +{
> +	struct cn_dev *dev = &cdev;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	return cn_hash_table_empty(dev->hdev);
> +}
> +EXPORT_SYMBOL_GPL(cn_table_empty);
> +
>  static int cn_init(void)
>  {
>  	struct cn_dev *dev = &cdev;
> @@ -283,18 +344,35 @@ static int cn_init(void)
>  	};
>  
>  	dev->nls = netlink_kernel_create(&init_net, NETLINK_CONNECTOR, &cfg);
> -	if (!dev->nls)
> +	if (!dev->nls) {
> +		pr_err("%s: netlink_kernel_create failed, connector not initialized\n",
> +				__func__);
>  		return -EIO;
> +	}
>  
>  	dev->cbdev = cn_queue_alloc_dev("cqueue", dev->nls);
>  	if (!dev->cbdev) {
> +		pr_err("%s: Allocation of dev->cbdev failed, connector not initialized\n",
> +				__func__);
>  		netlink_kernel_release(dev->nls);
>  		return -EINVAL;
>  	}
>  
> +	dev->hdev = cn_hash_alloc_dev("pid hash table");
> +	if (!dev->hdev) {
> +		pr_err("%s: Allocation of dev->hdev failed, connector not initialized\n",
> +				__func__);
> +		netlink_kernel_release(dev->nls);
> +		cn_queue_free_dev(dev->cbdev);
> +		return -ENOMEM;
> +	}
> +
> +	pr_debug("Connector initialized, allocated hdev %p\n", dev->hdev);
> +
>  	cn_already_initialized = 1;
>  
> -	proc_create_single("connector", S_IRUGO, init_net.proc_net, cn_proc_show);
> +	proc_create_single("connector", S_IRUGO, init_net.proc_net,
> +				cn_proc_show);

Unnecessary change here.

>  
>  	return 0;
>  }
> @@ -308,6 +386,7 @@ static void cn_fini(void)
>  	remove_proc_entry("connector", init_net.proc_net);
>  
>  	cn_queue_free_dev(dev->cbdev);
> +	cn_hash_free_dev(dev->hdev);
>  	netlink_kernel_release(dev->nls);
>  }
>  
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 70bc1160f3d8..094e1730a4f6 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -18,6 +18,8 @@
>  #include <uapi/linux/connector.h>
>  
>  #define CN_CBQ_NAMELEN		32
> +#define HASHT_NAMELEN		32
> +#define PID_HASH_TABLE_BITS	10
>  
>  struct cn_queue_dev {
>  	atomic_t refcnt;
> @@ -45,6 +47,19 @@ struct cn_callback_entry {
>  	u32 seq, group;
>  };
>  
> +struct uexit_pid_hnode {
> +	__u32 uexit_code;
> +	pid_t pid;
> +	struct hlist_node uexit_pid_hlist;
> +};
> +
> +struct cn_hash_dev {
> +	atomic_t hrefcnt;
> +	unsigned char name[HASHT_NAMELEN];
> +	struct mutex uexit_hash_lock;
> +	DECLARE_HASHTABLE(uexit_pid_htable, PID_HASH_TABLE_BITS);
> +};
> +
>  struct cn_dev {
>  	struct cb_id id;
>  
> @@ -52,6 +67,7 @@ struct cn_dev {
>  	struct sock *nls;
>  
>  	struct cn_queue_dev *cbdev;
> +	struct cn_hash_dev *hdev;
>  };
>  
>  /**
> @@ -137,4 +153,31 @@ void cn_queue_free_dev(struct cn_queue_dev *dev);
>  
>  int cn_cb_equal(const struct cb_id *, const struct cb_id *);
>  
> +struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
> +void cn_hash_free_dev(struct cn_hash_dev *hdev);
> +struct uexit_pid_hnode *cn_hash_find_pid_node(struct cn_hash_dev *hdev,
> +						pid_t pid);
> +void cn_hash_free_elem(struct uexit_pid_hnode *elem);
> +int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
> +int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
> +__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
> +
> +int cn_add_elem(__u32 uexit_code, pid_t pid);
> +int cn_del_elem(pid_t pid);
> +__u32 cn_del_get_exval(pid_t pid);
> +__u32 cn_get_exval(pid_t pid);
> +
> +struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
> +void cn_hash_free_dev(struct cn_hash_dev *hdev);
> +struct uexit_pid_hnode *cn_hash_find_pid_node(struct cn_hash_dev *hdev,
> +						pid_t pid);
> +void cn_hash_free_elem(struct uexit_pid_hnode *elem);
> +int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
> +int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
> +__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
> +__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
> +

Why are these here twice?  Am I missing something?

It also seems like a lot of these can be static inline and removed
completely from the header as they are not used externally.

> +bool cn_table_empty(void);
> +bool cn_hash_table_empty(struct cn_hash_dev *hdev);
> +
>  #endif				/* __CONNECTOR_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e6ee4258169a..a2339ae6208b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1673,7 +1673,7 @@ extern struct pid *cad_pid;
>  #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
>  #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
>  #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
> -#define PF__HOLE__00010000	0x00010000
> +#define PF_EXIT_NOTIFY		0x00010000	/* This thread has sent an exit value to be sent as a notification to listening processes */
>  #define PF_KSWAPD		0x00020000	/* I am kswapd */
>  #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
>  #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index 18e3745b86cd..2b12a24e4651 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -27,7 +27,8 @@
>   */
>  enum proc_cn_mcast_op {
>  	PROC_CN_MCAST_LISTEN = 1,
> -	PROC_CN_MCAST_IGNORE = 2
> +	PROC_CN_MCAST_IGNORE = 2,
> +	PROC_CN_MCAST_NOTIFY = 3
>  };
>  
>  #define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_UID |  \
> @@ -65,6 +66,7 @@ enum proc_cn_event {
>  struct proc_input {
>  	enum proc_cn_mcast_op mcast_op;
>  	enum proc_cn_event event_type;
> +	__u32 uexit_code;
>  };
>  
>  static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
> -- 
> 2.46.0
> 

