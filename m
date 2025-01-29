Return-Path: <linux-kselftest+bounces-25381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E5A222F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8B6166E90
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9C1E0B7C;
	Wed, 29 Jan 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bNwpE+z4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xdx+bPpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563E1DE3C9;
	Wed, 29 Jan 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171810; cv=fail; b=ekBo5gNc5bznKNJJqqYuPFhfgw0ufKdmP3JStJSm1KC98478TJXifFthMSMYF7COgXCBm8iuLHBxegLhEI9CQBKlm/wtPnfGAyflOAlV0QUw8MI7ksh88D1C+ecr1oWxPHwZzdi4mngI9HVs+rxJnjIU9kzAK7xHMR6WapHxSFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171810; c=relaxed/simple;
	bh=wNILryH+l+NygKQ2Sm2XTUTPHYNkg3qcwkq+FqSOa3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZr1LJIKDIocBhpratknqXqQR5CyfwQSFEw+pQLfhxcZuzAS4orsHzne1IJF5X9UhjaYlcm1L0FRVrWSdHIueZ0kIiDa1Wj6RhBQhFvBgCAdmcpRAkBnrhl8/zRHM0MK7wZzipayiPY8vIslhLHLr2XXeQVqPApbTi8fGc/aNv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bNwpE+z4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xdx+bPpA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50THQnIY016937;
	Wed, 29 Jan 2025 17:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eAF9NAHQMhf8AnWJkp
	SXDOuOzvzO6Cbxvirou2/Va34=; b=bNwpE+z48cpRkvS3BZCPjC9cCYYPPwzgDc
	/Vd1Q9NWN9BuHL6DHtfCjfin6Qsx2OvQwK+U7La4dTCLqyhlCcW8LT7xl3QT5Yg6
	izvaP2OOS+l/TdJUqY+NVhpfjFsqeTdO6LmlyMtFMLB+fNf98Ybvys1NbmzqRfKd
	whCINlKi9JOGARLxRbrB+Gmh7XP9QuV15eij1ivnjyD7X0gOKuLM7ySnQdmBjypc
	QvI/B7YeV0Fi44Fbc50ZAWir4sv93gPvGIH5+A6ZQojNpdAQdFdPeytTUVsKXPEB
	VGmPIpa+rCDOvVQPB3EgGFtGNBfOcQa6sbxj9ui70pLDNUpo93dw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fr0n856h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 17:28:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TGOi13035833;
	Wed, 29 Jan 2025 17:28:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdg2p3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 17:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTC3LuV2Ex4kl2ZAaLW8Xa7soe4/6LuWedaEEwlFiyOoiDoBRESTaIWNEtN/lfgnGSi9BxS4GZMwbXWB3t7GknKHTz6Fj3UY443iXdLZbE8DHVKLCU8fRAOvtqpINR9hwKLSI7wTCxTOlL9rbkbBFAlJM1McaKvy2tfVLpD18elJ2PpTxQJxqNta91rYkgd/mcWoPa+MiFc58AFrXHj/cGBDiA39J8AIapiOu7agTcpkMSczyIhZucmNB2wY+bLpuEhJFi975PKPLR0xNEmZIeKjySQDl75ZW97b+Pp1hp8PSrttRa4SceE1ndct0cUEAEMU71TbEdauSvGONCM3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAF9NAHQMhf8AnWJkpSXDOuOzvzO6Cbxvirou2/Va34=;
 b=BBOtP7yGMHYNPcg94jrOfnj6ofcDmo1MZexVUVjwcoYtfj/DC6yrMxgVgI2ifAsv8Xg4DzoDLVp+QXSSkDDzAFUEPcbYOYzsO+EE2JKHTQPa4GBF6PpzsDJRNWL0Coobbo/jrKanP/VScra2bMh0KJx/TFFaYcaPbBk+dZePGch6OpZvGZicXyyHeDSS4x+1eUQafBInMENIIKQ2cbJUl1eByeOIrXHUPd796VRWWnGfuB9vgvInft50aynbz4vkPCwW4+bTNVDknWJkFSKDAODATHC0m2jKURKW59lLPWRT3er44n+U1tfKSwDA2+qdA0+iB1UvTyN+QdbIYipKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAF9NAHQMhf8AnWJkpSXDOuOzvzO6Cbxvirou2/Va34=;
 b=xdx+bPpAdipL0Zbl/I0ftL97l72LyDaV2Gaec1tWXGGMAdBG+Gtuv6cHn0wBGJuZb9BqvhD/VmpFmtsYkcv7vIdJMnF8UefpVr1GQLSjYORF9P386KgxehYc3dT4iXyJBT4P46XWu0bJyMLIXCey+MQHF6UKGn68B1yuH/XgMdE=
Received: from MN2PR10MB3374.namprd10.prod.outlook.com (2603:10b6:208:12b::29)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 17:28:49 +0000
Received: from MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348]) by MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348%3]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 17:28:49 +0000
Date: Wed, 29 Jan 2025 17:28:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Gomez <da.gomez@samsung.com>,
        Daniel Thompson <danielt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jiri Kosina <jikos@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
        Petr Pavlu <petr.pavlu@suse.com>, Rae Moar <rmoar@google.com>,
        Richard Weinberger <richard@nod.at>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 0/9] x86/module: rework ROX cache to avoid writable
 copy
Message-ID: <913fdbe4-d77a-4083-8378-4c8a602366a8@lucifer.local>
References: <20250126074733.1384926-1-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126074733.1384926-1-rppt@kernel.org>
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3374:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e98315-5260-452e-cee3-08dd408a643c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCgUK2jKjtUcwppRE0ICNtppm/N+86wOGAVlLsV+48KjrFumH5YFJrlcw/eZ?=
 =?us-ascii?Q?hx0UrqdFFJ1jyQw2XphZK7O8UrAxkuJbObnutbdsHlAi+2SFON+QDjYJSPkw?=
 =?us-ascii?Q?xXlNBbKMNGI84xJfF9gvE4OBkYslPws1zOjcTeXG8HBGr1JXZ/iQF1h1L3E8?=
 =?us-ascii?Q?Ae3585/Ib/lcRFypdK4wH/liA+w4u4CZyEe/zVrR602IeAIRnWdng6JDbYzD?=
 =?us-ascii?Q?38MwP/1OEVbjCfaTVVEv3nxaBDanCUIQ9N1QPNKj0VoPF+KLvuWl8Ca8btuw?=
 =?us-ascii?Q?pc4SbLzzc9at5UMl3aHsT7l1jkyLlOgSoORzOGbS8Oe5ETuh8Yx7d3ajyvfi?=
 =?us-ascii?Q?Xzgn4JD2AeUupUkPnx+dTmQWej737H2DWeTQdkXiYJPoU9ltOTCwtXIg6cxK?=
 =?us-ascii?Q?mzMCGAxeIkOcxxYb7hOWy6loOruW9bUUEhStXJOFbnJFQMXlOxhQF/l2aeqd?=
 =?us-ascii?Q?xeJM5Nm4iThv5AWlYd0I+RNnzKvkieM+E9F6FIrt5wPVquJgSCPqk45N8UfJ?=
 =?us-ascii?Q?j9iC9j9ghekZxvr80CCPXvH4U+CqzxsRYE9H5+Gvgyf1wRDKM09ffjSj/dBl?=
 =?us-ascii?Q?GU5qVH1QWcXnDsPM4Ay8pC/t9R+ZuuGGuHXYE8oFmzkLK9l3MXZL52UMsbls?=
 =?us-ascii?Q?XVCTF28vypcwSQSYKrBv2ZRF5KwD2YNo1krOipnGRPauWWYcett3Twwdi9pT?=
 =?us-ascii?Q?aQ7o3sI6Z216+xkyhlb+2ZkCvn+DHCQlZ19fTld/kcAaP2kwe3v8zYH67OS9?=
 =?us-ascii?Q?V6K7N1hXa3FBpdYsvtfjAnSEe1Kj9a3Uy93xcv+wAmNs0filmtc/kFFgx9nJ?=
 =?us-ascii?Q?PWB7n8M7ExS8OWEgG4SzmLE1afU0uQ2JkL0N8EVUh2FEci33TO1oT+PGF6Kb?=
 =?us-ascii?Q?pW+fWtYvQxJjQhYmTlZzWFDnKX5w/uMjmPeCDdGVL/HHxPynPO2bFLCPN0Z/?=
 =?us-ascii?Q?X1Z5YP62rlJakEfLWbj4cjxx9aRef5f1qufxka1Aix1D2xt5QuEaXqhMWUZL?=
 =?us-ascii?Q?CXeZqXCNG3m8LPlLoy1FRBkdsC74TzUVpipqOJee+UjZvgFdKGUS5Vlmye9f?=
 =?us-ascii?Q?0svDyyP4A54u+nln170V3kTvCr8sRTWLvYs1b9ucA0ID9unDV3ABzFXnYQzp?=
 =?us-ascii?Q?vtHWdW2XPSKMMZj9WxGxc7oCicGeLXe392F9gJCrUhcKy7yccVTP766n351u?=
 =?us-ascii?Q?MtRUOpnVdwRAMpBOumkVR6lnURbDQmuGQQ2lWY+aIc9e6lR2TIKgFwtaJGV/?=
 =?us-ascii?Q?h5UH1q0DhB9PkpAVulalUZxa2kJ3qYokVq2rcqAKuSvo4EUj8Y3/yB9RWzCW?=
 =?us-ascii?Q?Ouq8APJELrEuh3EhgcfKEKlMeaHWEjMXfTHWHLp67CBPPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3374.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hke05wlicchuSDG9yzQ6oiHW5CuGYOqb4AC5MRlFiQYfp7XjfCumSjVS78G?=
 =?us-ascii?Q?8T4cZI0HnuU2M4b2UdajvlqSsIw587G0ENGMMS3Bd/qWvu13J1qKbJvhD0mO?=
 =?us-ascii?Q?AdCdI9YObvumQFWrCYeZtzOyzmgB1R0TC6KPgb0/8BD2+iWIuwelqipoJJ1B?=
 =?us-ascii?Q?QukwhaetTJNpbzWz7wU1un6/Mg58j+vhRCa0p4R2I1mBr8bu+WVLEOi0MdHX?=
 =?us-ascii?Q?gvB8mS63X5Lq8QC2KY+W/WcxJeqmyHs7EH3DQLt9ikf/JGoKkFb45ZPAyXfZ?=
 =?us-ascii?Q?XFnd0hFmgrebglI5hbxc7JuPWVOVY+gAh54PzNNPdmWXMwrdyHstwELpzJoA?=
 =?us-ascii?Q?v8Fxg38wsjuq045J9ue39zCITnD/NuGSMJ8z+10qTZbYfd19H2gL4rUgWFEB?=
 =?us-ascii?Q?sL1NRItQZ9yUv6GjIwMaWA/qszI2fG1DNV1zyOmKbmRuglmaQeb6uqOWc3pm?=
 =?us-ascii?Q?yK7kWrjir8uiXSFf6ZJ3F9mQ6YsJbZmeBt/82P+InoYIkYhH7sg3JP6rxfJK?=
 =?us-ascii?Q?uKv8vqa63gXPhs9SE0t5t3f5mdCDdf7i50/p6nYN8BjuFq1f75PUDrFHvi3C?=
 =?us-ascii?Q?6ngmPIlAmvQ5+1uzc4KsHiW5uL5oRRqsBFSK4cTnegk8yc8gVhB6iZKSpEIE?=
 =?us-ascii?Q?/gFrw/UTuAUQ2XXVHgJLN0uMUYRpL7SyYsckvkic+sFakZiOs292w2JRelSd?=
 =?us-ascii?Q?q8miJH+ouoR5z5pgRzJ3Ct+wjb1m7ElKG0UMR1zjppj33fFAfpiHiXm6ktrM?=
 =?us-ascii?Q?32rheL/du2H4A0o3g+P4ITYyYQgd+QQ8xh34Q8kiDPH7iJQOFyhG7YNkdsyI?=
 =?us-ascii?Q?HQLzF9PwsP4rOQH7d5Wz6IZ+ms+hQ4L2HaNFPmt6doSuDlJyDDjE81fq2VPx?=
 =?us-ascii?Q?BM86R0/4AaPllHUsInEO51F06N5oH5d44KHfdgqLuv83PidDAsTNp4qf3RJj?=
 =?us-ascii?Q?S81M2KVLzi5jB4zMlICi32RkkSUBF76juDze1e6/nasKbMV0GM+sIzfX80T/?=
 =?us-ascii?Q?fVQ9u5xkbmzxIzb6Msyo+IjwR/O40nmd0Nqcr9fmuHJrnEH2NZet5p9nvJEP?=
 =?us-ascii?Q?UyPThQWFOsPDtJ3PcukIifMzD+rrnSggY5Rfpb5cCUYqdtN65cBQX6jPyl7I?=
 =?us-ascii?Q?sFdxRe/V0Vqeoyo40u5sOWJcxOIKVP4KYCewz8CRPX2UUJ64Og67wmBA9K83?=
 =?us-ascii?Q?+JZnN09aO3mZGahAyn7t/meXVGe6QfGiRZ3zjIfJBUxVJVknOizDyphtxb7v?=
 =?us-ascii?Q?o0LymjHUJ+ZdoHnM/B9rlvW9wOcLgn6/QgCK8GHgTaKh/vlU4xrRvROw7Zta?=
 =?us-ascii?Q?8IFlqrJG1pkSGp3xCNe+X4FsvOFAimsRvgBh6wYZTS85XJ9SEfmV6HudDigJ?=
 =?us-ascii?Q?nbTNMEvHqNnn+iWxKLQjLBl/GKemx34wQucC1YsRI1LMF/NuoP2T84O03Io9?=
 =?us-ascii?Q?+27W48o4vyCP5tN6E1yrl5vtTOGhDBNmMmlmOEWppXRGN2RLIZGpAArfaG4x?=
 =?us-ascii?Q?BK+IgYW8AFPtNI3zi8/yQwupnH32HySlXE9z2svNDaq7S/qXTMQGD52KvLki?=
 =?us-ascii?Q?reKzGVnHh/fhDLmmRaNV+zfiEytsEeQqqmSKJ2CxRdBdeMQAkwS6ta0PhHGo?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DQm7wXG0dd1fJR6z4FpfkLwkVzBjRv5Rprm04FtDe3HGRQMDxx/1EYbibuKy4iAUlUVbYnWBugQPbIjZhShvuFBmUeL9ODQQ6N9VZ5wZTxIJ67SvFJgvY1fNB7nsuCfdZEIMD/SU/XBUUlFZv2Y6c7iwHA7LFP134HHMBrAVAx4jYdrqKTsOhzV17sTNfJsQKrlvDl8oa0Ja0i6+1CRKLQSPIIsHve12j2H+LihYjc0OcqXrK8AGahUDJpZ5A/72URrxbSQyzSp2kagk/Udb+fZhTZRvVwdAk6JavWNAaK2MwCNHQu1t0kZ3AZvpiU5Z5hWJXnTuY3PtlXQ9xBo+v7bgOx0dQl3zmU6Y651n1Y745IO51WIW9KzPIIjCXAg3dPQAbG0dMPs7MXpAPIkh+coa/zj33Ed6kmdqemD9mNtApg0RPe2avTrLUMXAGWlSNryEEPWMvjQ42YZ18Nb3EcR+GAEJR0bPAMFKgrLN2cGQNGTox4jW36klAhfGQZ7HEL9VmySkUDr1lNH0rvmVfxc1Ix00ZEtDJwshB8MGThelKY4UFnl/9M5SML8U1RtMcRqR2biOiO0xSDn08uPaQij0fzfWtt0oFc2zujy6r9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e98315-5260-452e-cee3-08dd408a643c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:28:48.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuAG5LiOLH94GPoC9yzwU+UPwekQhWEIlUWmLnCl61RViqAI4vOdMLDQkgwpo3CfDLEvtzT/rqIC2HozVO6m65GG+nXWsMaFhmjG617IFQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290138
X-Proofpoint-GUID: loC7OqfvEGnz2FlH1C4ml8sFwP3a87_6
X-Proofpoint-ORIG-GUID: loC7OqfvEGnz2FlH1C4ml8sFwP3a87_6

Hi Mike,

I bisected issues with the kernel booting correctly to an earlier revision
of this series [2]. I have now tested this series in the same environment
and found that it functions correctly with no issues, so feel free to add:

Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Cheers, Lorenzo

[2]:https://lore.kernel.org/linux-mm/86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local/

On Sun, Jan 26, 2025 at 09:47:24AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> Following Peter's comments [1] these patches rework handling of ROX caches
> for module text allocations.
>
> Instead of using a writable copy that really complicates alternatives
> patching, temporarily remap parts of a large ROX page as RW for the time of
> module formation and then restore it's ROX protections when the module is
> ready.
>
> To keep the ROX memory mapped with large pages, make set_memory_rox()
> capable of restoring large pages (more details are in patch 3).
>
> Since this is really about x86, I believe this should go in via tip tree.
>
> The patches also available in git
> https://git.kernel.org/rppt/h/execmem/x86-rox/v10
>
> v3 changes:
> * instead of adding a new module state handle ROX restoration locally in
>   load_module() as Petr suggested
>
> v2: https://lore.kernel.org/all/20250121095739.986006-1-rppt@kernel.org
> * only collapse large mappings in set_memory_rox()
> * simplify RW <-> ROX remapping
> * don't remove ROX cache pages from the direct map (patch 4)
>
> v1: https://lore.kernel.org/all/20241227072825.1288491-1-rppt@kernel.org
>
> [1] https://lore.kernel.org/all/20241209083818.GK8562@noisy.programming.kicks-ass.net
>
> Kirill A. Shutemov (1):
>   x86/mm/pat: restore large ROX pages after fragmentation
>
> Mike Rapoport (Microsoft) (8):
>   x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
>   x86/mm/pat: drop duplicate variable in cpa_flush()
>   execmem: don't remove ROX cache from the direct map
>   execmem: add API for temporal remapping as RW and restoring ROX afterwards
>   module: switch to execmem API for remapping as RW and restoring ROX
>   Revert "x86/module: prepare module loading for ROX allocations of text"
>   module: drop unused module_writable_address()
>   x86: re-enable EXECMEM_ROX support
>
>  arch/um/kernel/um_arch.c             |  11 +-
>  arch/x86/Kconfig                     |   1 +
>  arch/x86/entry/vdso/vma.c            |   3 +-
>  arch/x86/include/asm/alternative.h   |  14 +-
>  arch/x86/include/asm/pgtable_types.h |   2 +
>  arch/x86/kernel/alternative.c        | 181 +++++++++-------------
>  arch/x86/kernel/ftrace.c             |  30 ++--
>  arch/x86/kernel/module.c             |  45 ++----
>  arch/x86/mm/pat/cpa-test.c           |   2 +-
>  arch/x86/mm/pat/set_memory.c         | 220 ++++++++++++++++++++++++++-
>  include/linux/execmem.h              |  31 ++++
>  include/linux/module.h               |  16 --
>  include/linux/moduleloader.h         |   4 -
>  include/linux/vm_event_item.h        |   2 +
>  kernel/module/main.c                 |  78 +++-------
>  kernel/module/strict_rwx.c           |   9 +-
>  mm/execmem.c                         |  39 +++--
>  mm/vmstat.c                          |   2 +
>  18 files changed, 422 insertions(+), 268 deletions(-)
>
>
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> --
> 2.45.2
>

