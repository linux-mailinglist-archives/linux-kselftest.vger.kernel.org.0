Return-Path: <linux-kselftest+bounces-23832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D08A000AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D187162C68
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 21:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308801B87E3;
	Thu,  2 Jan 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="crHtEdBs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="luclx7jQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5B1BC9FB;
	Thu,  2 Jan 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853510; cv=fail; b=bf+cofP17tkUo5vbre2DQ3MsauF9a1WdiA+/kKahmNQ3Yb7XfyHPwJZJrnJ4CZpLISf+JCJDlWccV93sDERx/6ziXxQFxbpmteP2n1IQtwFW4m2kBnVYOPhi262uRD3BpO6ujdtuPVCOxRlwWeDhVL1EMtgb61M060AcLjpT6xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853510; c=relaxed/simple;
	bh=vLeJ7DpsWqIdKm68WnufOBinEHnb+lHwVE4aSE16tcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/zxUYJRfyCPj8E7FG2Z02BPnE4c7aEIFJRRD4FpDkkQbcX+zsPDMZlmIrghgsqWa18koyXa4AEQoS3bZbihDT3Dv/+57eGunYy5h94YjlAMvBNFSq4TJr1AwZTQa2XL6h+1faTv1xahenqwLDRAtd7E2So0KP3yHj+pts/EyQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=crHtEdBs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=luclx7jQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Kg9bv011971;
	Thu, 2 Jan 2025 21:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JirlaFmYFbONLEP5PO
	q4b+uGu/LR8DPCxQT4U62pgfQ=; b=crHtEdBs4UQDnpySiGQ315lHUZ3LBRs+Lt
	F8nK/J6b8NodItmkbvkfAQrf6DuvoF5eodm0n7t7W3YKX360bwIMhcjILZjQa9gM
	r7A3jqJ9lVRtFY/XZEoeZ50WcDT5e2JxwWPXneAL/T448pFChWmhuZTZePkvidrZ
	S3kX3g03c8zTgbi4lUTDjdo3Ubr54QiZNGWWtrQI9XeZ3TnK8NcdpeWiTSv23XIk
	/8QMz6n5QdAk2O+1TdIKDqHEoPcccFDYPJnwkN+Gl5WY5ICUzZp8xwhlxcutCUzL
	UWDFu/g9BT9zhH9Cdcehg2OcR2ApDmFwM1mTaC14MidQKBdD3xdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t841y9pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 21:30:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502KAETw012313;
	Thu, 2 Jan 2025 21:30:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s926jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 21:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8Dr53wPIm8Ujzm7P1qFR1g7OIbUKfnL7n5yQSg2NLoB0fEq7I1AbduCchOFqVnIesd/XlZGPRGamOs/auNQqZCXmJ8rP5zXtnfG0xpqs7kPrBQp0h9mWmQ+wy8szO+Qt7/sz7BAzJKJUsoKXo3vvX1bUYd/uvxYqyootJZRhEExPEsjZ72t4WYm8AoCxseOpWi26HpMLRLTPJmZiTy4InAcA6/+rSWqbaEX4PEPImWyo9W/sCZb7fN+4C+Siy87iTBcyGNAovGvzKaAvd6SeroB6DobeBSjziRtqiilSqdaH9QGgduv81cyNdQa2HzQWFJvTMFU7GHdNQO+hN5eqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JirlaFmYFbONLEP5POq4b+uGu/LR8DPCxQT4U62pgfQ=;
 b=P66qdc9evd5SnSGz1RH6bYU+4kqZiAa9oAe24rSjRAPpuzmKfI9z1X5IpRqoo/PjGZuLXcEQSLuDb/nPYnhLXCqOBFz8K96G2excJhcIKNTZ6yXXMo4D/+PrH7gAI23HtrjIoJQCwDT2f1+btp6dMeB5Qo6rrHGu1WwRdA5bOGg7lRdPP1oOK7Bli9uRClB/juCNbFLeCRZ+Tv9+TESZA1RJaMqq8gYq1iOK6Paa/DR821bFVBzMT8BU4uWBQ2iJgz/lJF9X2Rl4UBMNlVzkpKFZuiCiTSGosv2N6RzOHtOH7X8/7ttRZJK60p2wXFy3KyX6Oi8VSvNxkBAb18l5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JirlaFmYFbONLEP5POq4b+uGu/LR8DPCxQT4U62pgfQ=;
 b=luclx7jQt9EZuJ1DwDzl38SzD2CZDAg/XhwPlOMIYrVsgNdtv8YoJXm+ZbSGjVKXJKj+/pdhuUnt4e/OdoGYCgGoBbMYqi4tKuDtS0Nb+Usxqr9sjUa7rWteSrbLlEdFJkcR5ma9e9cUs1Pdk3Fukq8VDPWh8f+rdebLLeSU3nM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB4931.namprd10.prod.outlook.com (2603:10b6:208:331::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 21:30:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 21:30:20 +0000
Date: Thu, 2 Jan 2025 21:30:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
        live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Message-ID: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-7-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227072825.1288491-7-rppt@kernel.org>
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: db579108-e0f7-4b5f-ff05-08dd2b74a869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xVYZERhm2uGAS3E8CgqktDy0yNhj3PGeKYU7ALsW3xelreFPE3kTzCsrxQ2V?=
 =?us-ascii?Q?7MKbNH1/ZJuzlDINw3pXpTbrA88oliGADbO6xT4XK3ZWYbmeqaYtF0aZz44V?=
 =?us-ascii?Q?7yn8t8MoLisNUhx8TJ31VNr71ylqZC2Q65NTIVY+VEkXE6iI62p+2vfunSxR?=
 =?us-ascii?Q?4Fw1BZ6xRbKjO9T+EMEBQJdb9LlJ/febTVN8b4N95a2FmOpNI6n9SggxVftX?=
 =?us-ascii?Q?IBmmBVWKS0cTOpWwfixzmOGcIXrLPAGy9cSpL8q6RLqvaQs24LL2ea/VcUJD?=
 =?us-ascii?Q?knlowOIGKBsBsQHVUWdQ99Ct7nrdcfAupfHksgDAz8N4PkVLKWUy2698xHxk?=
 =?us-ascii?Q?IQoCMaQC7eYkchPOzH7a4VkVImf8SrAKfTjqCn9o1KsdRCtsj6pnQojp0X4V?=
 =?us-ascii?Q?92t/CYrONmCvdx7jyBjEgxGi5a9dzaBNQunohwC9wG65uZD8fP8k2OJttbrg?=
 =?us-ascii?Q?C1Lu4eVrJf3+yT4piWwbfC9b9t8JtwIv/W0VV426N9AabtU2MDmLElmAFsRW?=
 =?us-ascii?Q?OXdt4PXMygMLfgnyHwm4VKO6d/jD6cIyxmqmDmhuG7S7PyMpJkIa10dZHfxz?=
 =?us-ascii?Q?ifRcgmhzrUXu3buWjyk5EiXIUt0E+Annrliop0epDJ7g7eAfil4ACzdCQYBx?=
 =?us-ascii?Q?BJEfrqGaZP52+/Gtxoe+SXSmKe8M8tVljsTXg7p4pATGeT4Hh3Wf6ADKz/sy?=
 =?us-ascii?Q?mDtBdKl24Sl4Zkb7ll/olGjtpyGTsWILUTNFjEnqbNAVC2Sst0X+hlgDb/rM?=
 =?us-ascii?Q?rdduYKp7j1MJfRMqzqHmRas1J7S5HWFA5+BVxZFrvd1Dbt4craJXTJpZIrBx?=
 =?us-ascii?Q?m+PgKfRl81wUIA4O4FdQbjSKW0z7udf2xcZLfnod1dgyjf/v+6HGkJ1skWlJ?=
 =?us-ascii?Q?KjESjAHbPwv70ivGad1629coU860vznBZZGX2X8L/u+E16ihAZIHmdKczOFj?=
 =?us-ascii?Q?MIqEkLJnS9FhmrTJewAlxS4w8Cv7OHAx/qxYzX4Au43NSxUB7z9ujNUp820g?=
 =?us-ascii?Q?50H2WpBcV3UI6+FWT1+WANCFo5fepdy2WngggPxl7JJyTjpj+v+7yScA3OVi?=
 =?us-ascii?Q?GZUkhFU/UWErzWxp7q9FJFtm7hZjiPV9q304wBXjR2uL+Twp9S7nM2PYkZbD?=
 =?us-ascii?Q?BpmWMb/tX6HUQktIixqNxzPnsoZj4FvAUOg0cXoo/3/XdlHqICO45bJ/dYy1?=
 =?us-ascii?Q?nxGflVNLQ4YcWLQVb273/7nPzGmnLWe6NywKpjOWiiilYeaYew8NYAYlrbqo?=
 =?us-ascii?Q?jD9JIai/IM8HS/teacvz/BfBVpfYZSzq5Cu+yUrMrzCBJVPEeEh+uaIJ+Iw+?=
 =?us-ascii?Q?o7opCP1eWf17saEkxjTZUK0F4EB1sufLiWHFo4+07LWGypYRqIql9JUFGzAt?=
 =?us-ascii?Q?K4YEuMit4sl4QVpETtzt9+4/l63L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bn871m2SKOP5G9q1+CQRJn5Coh2uKjSkoPWIvrGo1u4YNbLC++sqasoHiP8p?=
 =?us-ascii?Q?XV14dZvSYKVLbmRMcHTblvxaH7/0Okk6xbtHSLzqdYZJWO7vFRcngBKliG0Y?=
 =?us-ascii?Q?Xx/YPeidCx2cMp0n/vAhFYWWVDmowkC14YgmqVne3ma/5rTQUkTrc/fX57oW?=
 =?us-ascii?Q?zG4mlfDh6eFuJdB4XfINnWng0JmpoWOsRgKqZXHLiecaABTTWK9CkjslyvE7?=
 =?us-ascii?Q?5yOdHFJWPKXdPGjegeR2s3UTjtGrlXMZAy6I56aDVA4DPaX36oGcQnn2sn+w?=
 =?us-ascii?Q?sWE6jt5ewe+4wTa0n0YJVaYxbFP7dy6xX0PB3eFVEZ9IKVOzu2TkQjaT0+Er?=
 =?us-ascii?Q?g2Kx2jExg2ARy8N4zep4lPW9DmSZgiWRrlYb99hE64m/il7A3znqWxCa+w3r?=
 =?us-ascii?Q?YUSfsWq34aPGs9+NjZBxLHllIJIB/t6oO8nMDkp1jZTp2PUjMtsH7TsJHrK2?=
 =?us-ascii?Q?EsFescZikacITW5+JVyYEk8bYn5vCY4vgPwfzCVExT8CAy3foRRt76pviVaI?=
 =?us-ascii?Q?oh1ArohwWGS43K+hp9aftunwNkWlXtU+gw8Eef2thZdYTl18RlOOBJH0Zjp0?=
 =?us-ascii?Q?h2c8/ghZuYSoqG/0JTufe77Ey6MdKR2pd1BTHq7bgE+MA3m9WYSu/tzF40CD?=
 =?us-ascii?Q?MbUFuL1F/wbcNuvsH/Dx+ank22dAsmkVzQsHdRVcfaPlEVhd2fm57MeBHscW?=
 =?us-ascii?Q?6+bUaqEjhDr4lCMRaTh9L8g5Zf5D5P8eXeqcGi2TQAWiEk9Oe6YWADoA+hq0?=
 =?us-ascii?Q?uXMxBI4b1BrAUt9f71JNcMr/Ilf2DJajC7UWXlsoBbb1P2BWivgveg37uWAk?=
 =?us-ascii?Q?1EJon5+ayAiE5/RNhM2bssE0i0/ZzIw8tgJJjGAWVTbp5kbC5oqH7jKIVmuN?=
 =?us-ascii?Q?X+7bgkXPll4VJQ4T+4P3wssx7Sc7H9zysjenVUdLbChsXDk+qCxgCwjUHwdo?=
 =?us-ascii?Q?fLmGRnmHNoU0M2L6tIwEJrnx6H+JO5ZGjm9WEDx+ofNfqetiABK3EJ7EvHhG?=
 =?us-ascii?Q?xWv6vWB6iwrcEdKVqfzY6WnGNKtcpyFFDUx/TDBI4okNQX68d0dGJ8eQr7RB?=
 =?us-ascii?Q?ACk3LTbLq1gWlUWwqn7vNZI31AhD0VbQr+btqlCpYwobaYJ33Fxkz+VCUAeV?=
 =?us-ascii?Q?jMeclCFSecrlNqOOi7CefTJsviQD83SfRS4QHh5oGc1Zz2VmIc7RngImxR7+?=
 =?us-ascii?Q?nNtcbVlgDHEv+qmplGTUpZPnPyh+rPsqmlWG4pOhMWCT5FYVvV2hGdPzg+BR?=
 =?us-ascii?Q?k34UIL9vlR4icc42jZrdpoRevwuJjVpyLrADekmJhVo0h5+hqwY2GVPLAuMg?=
 =?us-ascii?Q?suIksvf8TxB7affSHTjm4TVhATI+A+Q/ECdqTjKjWS97/j9zIqUDDL9STAK+?=
 =?us-ascii?Q?MYC58l1Mugl7XhhngUTcOurdiIKXtjP9LE7CltEvsKhXWrWxp8tUryA14i+F?=
 =?us-ascii?Q?l54fj8+yq2RYFF4PsH5mF9FnX/E+ItQezt/VZ+zGah42LDNveRVWnd4mPRP2?=
 =?us-ascii?Q?cH/SG6Ijk0vGs5+bWutUZQKLm1TLP/QzZO/9E1mVkb2d2ZkfzjSKwxPAkwfY?=
 =?us-ascii?Q?DtT/SvycgVFU1iBBOiK5qoL2N9cFxVWeAW0GuwM7KmW3ZgTQIPlxGU8gCoes?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W6tCtFja3JO89WqmfsOO9fUlVMb8xJ9G0IhUytRetdeV3nqnHmhsgSQlfQ/Iucpp1+g6883QHNWpaT/0X6SkOGXpPGGJfhNxIo89tIEHnP+luZbrepM304bNQCA6GaJRDf4NkjKN15ne9YbK/NQhM96iCi1kzFy2jC3+FSnAuNosESt+D7klkOklQon6kpNEP8e7u08nbAqQyU9oWa1qHCfiU9d92pRNVR20Gzj5m09B3ppQc35L8+SKE6RCR7ZD1sRuglDX03+u0xtR92vR7HHYC9Ohfc/mjQm2g/P5PmHBdXsgxFDKsUFkM7xi7XwdTtnN9npwMjk+RmoULRbbyv6kMGd3xI43JVBC7VaAQ6vooUUQ/rpkZK1ToL2snVb6bqy63BKPdpxcj9vMK7GVW2etGYJvm8LYykeL2eJWMWbmrv/Ua2qnVGW+AIAirqw5ZyVPtuWRX8xPs1EKyUVcCVZ1mq7qDAmLeKCz2JRGxc0qHXb/PFEc3mOi6FGpLQycl7NzbxhAnpv9dKoa0p6uHj0rFeDDhEUn0MEGNPXSjbDX9lgu7KTzL6yGX/exXWPn6XHaP8JVQv6BRyHv7R1At5Y7BeHCHSbvDGq3g1sExbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db579108-e0f7-4b5f-ff05-08dd2b74a869
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:30:20.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIqXdcSrt+qvVqePr+oK7KzN4olHIXQ6lA/Nu5hTehKOWRqWw/Fnxd09yFcePRmfKQyKYxBCPkHNiz/FdS8SsfL8UuhBplr/d/xdVIEY4RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020187
X-Proofpoint-ORIG-GUID: IgxVU7E_Me1X62EbOUKREA44ZXvavb1j
X-Proofpoint-GUID: IgxVU7E_Me1X62EbOUKREA44ZXvavb1j

Hi Mike,

This commit is making my intel box not boot in mm-unstable :>) I bisected it to
this commit.

It seems to be having an unhandled kernel page fault on exec, so I guess not
actually making it exec somehow?

It is a pretty standard intel machine (arch linux config, slightly scaled down
via make localmodconfig to make it easier to quickly rebuild kernels). Can give
more details if needed.

Here is the (vaguely annotated-ish) splat:

:: running early hook [udev]
Starting systemd-udevd version 257.1-1-arch
:: running hook [udev]
:: Triggering uevents...
[    4.231005] usb 1-11: new high-speed USB device number 3 using xhci_hcd
[    4.261646] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)

Guessing the execmem didn't make it exec somehow?

[    4.269136] BUG: unable to handle page fault for address: ffffffffc0641010
[    4.276009] #PF: supervisor instruction fetch in kernel mode
[    4.281666] #PF: error_code(0x0011) - permissions violation
[    4.287241] PGD 3027067 P4D 3027067 PUD 3029067 PMD 12a29e063 PTE 8000000129441163
[    4.294818] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
[    4.299695] CPU: 31 UID: 0 PID: 331 Comm: (udev-worker) Tainted: G        W          6.13.0-rc4-1-custom #1 5815a74228bcc318a2a967d947d4ca4aa132a5ed
[    4.312992] Tainted: [W]=WARN
[    4.315961] Hardware name: Gigabyte Technology Co., Ltd. Z790 AORUS ELITE X WIFI7/Z790 AORUS ELITE X WIFI7, BIOS F7 09/27/2024
[    4.327349] RIP: 0010:crc32c_intel_mod_init+0x0/0xff0 [crc32c_intel]

My addr2line suggests:

/home/lorenzo/kerndev/kernels/mm/./arch/x86/include/asm/processor.h:43

DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;

Which seems... odd :)

[    4.333702] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 0f 1f 44 00 00 48 c7 c7 00 e0 8a c0 e8 1b aa a8 c0 48
[    4.352466] RSP: 0018:ffffc90004223a58 EFLAGS: 00010246
[    4.357693] RAX: 0000000000000000 RBX: ffffffffc0641010 RCX: 0000000000000000
[    4.364827] RDX: 0000000000000000 RSI: ffffffffc0641010 RDI: ffffc90004223a40
[    4.371963] RBP: 0000000000000000 R08: 0000000000000020 R09: ffff88811adeeb00
[    4.379097] R10: ffffc90004223ad0 R11: 0000000000000000 R12: ffff8881278c3600
[    4.385530] usb 1-11: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=60.90
[    4.386230] R13: ffffc90004223a60 R14: ffff88811ae3ac00 R15: ffff88811f251b80
[    4.394497] usb 1-11: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    4.401628] FS:  00007f92de124880(0000) GS:ffff88afffd80000(0000) knlGS:0000000000000000
[    4.401630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.408850] usb 1-11: Product: USB2.0 Hub
[    4.416938] CR2: ffffffffc0641010 CR3: 00000001279f6006 CR4: 0000000000f70ef0
[    4.416939] PKRU: 55555554
[    4.423588] hub 1-11:1.0: USB hub found
[    4.426696] Call Trace:
[    4.426697]  <TASK>
[    4.426699]  ? __die_body.cold+0x19/0x27
[    4.434112] hub 1-11:1.0: 4 ports detected
[    4.436547]  ? __pfx_crc32c_intel_mod_init+0x10/0x10 [crc32c_intel 0c38f5da3bf5b6f9ab94fb009bb43215a1542e3a]
[    4.462776]  ? page_fault_oops+0x15a/0x2d0
[    4.466874]  ? disable_mmiotrace.cold+0x6a/0xaa
[    4.471404]  ? __pfx_crc32c_intel_mod_init+0x10/0x10 [crc32c_intel 0c38f5da3bf5b6f9ab94fb009bb43215a1542e3a]
[    4.481229]  ? exc_page_fault+0x18a/0x190
[    4.485240]  ? asm_exc_page_fault+0x26/0x30
[    4.489422]  ? __pfx_crc32c_intel_mod_init+0x10/0x10 [crc32c_intel 0c38f5da3bf5b6f9ab94fb009bb43215a1542e3a]
[    4.499248]  ? __pfx_crc32c_intel_mod_init+0x10/0x10 [crc32c_intel 0c38f5da3bf5b6f9ab94fb009bb43215a1542e3a]
[    4.509073]  ? __pfx_crc32c_intel_mod_init+0x10/0x10 [crc32c_intel 0c38f5da3bf5b6f9ab94fb009bb43215a1542e3a]
[    4.518900]  do_one_initcall+0x58/0x310
[    4.522736]  do_init_module+0x82/0x270
[    4.526483]  init_module_from_file+0x86/0xc0
[    4.530756]  idempotent_init_module+0x115/0x310
[    4.535286]  __x64_sys_finit_module+0x65/0xc0
[    4.539642]  do_syscall_64+0x82/0x190
[    4.543305]  ? do_syscall_64+0x8e/0x190
[    4.547142]  ? filemap_map_pages+0x51f/0x670
[    4.551412]  ? do_filp_open+0xd8/0x190
[    4.555163]  ? __pfx_page_put_link+0x10/0x10
[    4.559433]  ? do_sys_openat2+0x9c/0xe0
[    4.563268]  ? syscall_exit_to_user_mode+0x37/0x1c0
[    4.568147]  ? syscall_exit_to_user_mode+0x37/0x1c0
[    4.573024]  ? do_syscall_64+0x8e/0x190
[    4.576861]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.581003] usb 1-12: new high-speed USB device number 4 using xhci_hcd
[    4.581914] RIP: 0033:0x7f92de91b1fd
[    4.592102] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 fa 0c 00 f7 d8 64 89 01 48
[    4.610867] RSP: 002b:00007ffcf33fa0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    4.618434] RAX: ffffffffffffffda RBX: 0000555fbf68a870 RCX: 00007f92de91b1fd
[    4.625570] RDX: 0000000000000000 RSI: 00007f92de11e05d RDI: 0000000000000014
[    4.632704] RBP: 00007ffcf33fa170 R08: 0000000000000002 R09: 00007ffcf33fa120
[    4.639839] R10: 0000000000000007 R11: 0000000000000246 R12: 00007f92de11e05d
[    4.646973] R13: 0000000000020000 R14: 0000555fbf682a70 R15: 0000555fbf682fd0
[    4.654109]  </TASK>
[    4.656296] Modules linked in: crc32c_intel(+) spi_intel_pci drm_display_helper spi_intel nvme_auth cec video wmi

If I revert _just this_ commit it breaks the boot by not being able to find the
disk (!) so guess you need to revert everything after it too which kinda makes sense :)

On Fri, Dec 27, 2024 at 09:28:23AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Instead of using writable copy for module text sections, temporarily remap
> the memory allocated from execmem's ROX cache as writable and restore its
> ROX permissions after the module is formed.
>
> This will allow removing nasty games with writable copy in alternatives
> patching on x86.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/module.h       |  7 +---
>  include/linux/moduleloader.h |  4 ---
>  kernel/module/main.c         | 67 ++++++------------------------------
>  kernel/module/strict_rwx.c   |  9 ++---
>  4 files changed, 17 insertions(+), 70 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index bd8cf93d32c8..e9fc9d1fa476 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -368,7 +368,6 @@ enum mod_mem_type {
>
>  struct module_memory {
>  	void *base;
> -	void *rw_copy;
>  	bool is_rox;
>  	unsigned int size;
>
> @@ -775,13 +774,9 @@ static inline bool is_livepatch_module(struct module *mod)
>
>  void set_module_sig_enforced(void);
>
> -void *__module_writable_address(struct module *mod, void *loc);
> -
>  static inline void *module_writable_address(struct module *mod, void *loc)
>  {
> -	if (!IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX) || !mod)
> -		return loc;
> -	return __module_writable_address(mod, loc);
> +	return loc;
>  }
>
>  #else /* !CONFIG_MODULES... */
> diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
> index 1f5507ba5a12..e395461d59e5 100644
> --- a/include/linux/moduleloader.h
> +++ b/include/linux/moduleloader.h
> @@ -108,10 +108,6 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
>  		    struct module *mod);
>
> -int module_post_finalize(const Elf_Ehdr *hdr,
> -			 const Elf_Shdr *sechdrs,
> -			 struct module *mod);
> -
>  #ifdef CONFIG_MODULES
>  void flush_module_init_free_work(void);
>  #else
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index ad8ef20c120f..ee6b46e753a0 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1221,18 +1221,6 @@ void __weak module_arch_freeing_init(struct module *mod)
>  {
>  }
>
> -void *__module_writable_address(struct module *mod, void *loc)
> -{
> -	for_class_mod_mem_type(type, text) {
> -		struct module_memory *mem = &mod->mem[type];
> -
> -		if (loc >= mem->base && loc < mem->base + mem->size)
> -			return loc + (mem->rw_copy - mem->base);
> -	}
> -
> -	return loc;
> -}
> -
>  static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  {
>  	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
> @@ -1250,21 +1238,15 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  	if (!ptr)
>  		return -ENOMEM;
>
> -	mod->mem[type].base = ptr;
> -
>  	if (execmem_is_rox(execmem_type)) {
> -		ptr = vzalloc(size);
> +		int err = execmem_make_temp_rw(ptr, size);
>
> -		if (!ptr) {
> -			execmem_free(mod->mem[type].base);
> +		if (err) {
> +			execmem_free(ptr);
>  			return -ENOMEM;
>  		}
>
> -		mod->mem[type].rw_copy = ptr;
>  		mod->mem[type].is_rox = true;
> -	} else {
> -		mod->mem[type].rw_copy = mod->mem[type].base;
> -		memset(mod->mem[type].base, 0, size);
>  	}
>
>  	/*
> @@ -1280,6 +1262,9 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  	 */
>  	kmemleak_not_leak(ptr);
>
> +	memset(ptr, 0, size);
> +	mod->mem[type].base = ptr;
> +
>  	return 0;
>  }
>
> @@ -1287,8 +1272,8 @@ static void module_memory_free(struct module *mod, enum mod_mem_type type)
>  {
>  	struct module_memory *mem = &mod->mem[type];
>
> -	if (mem->is_rox)
> -		vfree(mem->rw_copy);
> +	if (mod->state == MODULE_STATE_UNFORMED && mem->is_rox)
> +		execmem_restore_rox(mem->base, mem->size);
>
>  	execmem_free(mem->base);
>  }
> @@ -2561,7 +2546,6 @@ static int move_module(struct module *mod, struct load_info *info)
>  	for_each_mod_mem_type(type) {
>  		if (!mod->mem[type].size) {
>  			mod->mem[type].base = NULL;
> -			mod->mem[type].rw_copy = NULL;
>  			continue;
>  		}
>
> @@ -2578,7 +2562,6 @@ static int move_module(struct module *mod, struct load_info *info)
>  		void *dest;
>  		Elf_Shdr *shdr = &info->sechdrs[i];
>  		const char *sname;
> -		unsigned long addr;
>
>  		if (!(shdr->sh_flags & SHF_ALLOC))
>  			continue;
> @@ -2599,14 +2582,12 @@ static int move_module(struct module *mod, struct load_info *info)
>  				ret = PTR_ERR(dest);
>  				goto out_err;
>  			}
> -			addr = (unsigned long)dest;
>  			codetag_section_found = true;
>  		} else {
>  			enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
>  			unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
>
> -			addr = (unsigned long)mod->mem[type].base + offset;
> -			dest = mod->mem[type].rw_copy + offset;
> +			dest = mod->mem[type].base + offset;
>  		}
>
>  		if (shdr->sh_type != SHT_NOBITS) {
> @@ -2629,7 +2610,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  		 * users of info can keep taking advantage and using the newly
>  		 * minted official memory area.
>  		 */
> -		shdr->sh_addr = addr;
> +		shdr->sh_addr = (unsigned long)dest;
>  		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
>  			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
>  	}
> @@ -2782,17 +2763,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
>  	return 0;
>  }
>
> -int __weak module_post_finalize(const Elf_Ehdr *hdr,
> -				const Elf_Shdr *sechdrs,
> -				struct module *me)
> -{
> -	return 0;
> -}
> -
>  static int post_relocation(struct module *mod, const struct load_info *info)
>  {
> -	int ret;
> -
>  	/* Sort exception table now relocations are done. */
>  	sort_extable(mod->extable, mod->extable + mod->num_exentries);
>
> @@ -2804,24 +2776,7 @@ static int post_relocation(struct module *mod, const struct load_info *info)
>  	add_kallsyms(mod, info);
>
>  	/* Arch-specific module finalizing. */
> -	ret = module_finalize(info->hdr, info->sechdrs, mod);
> -	if (ret)
> -		return ret;
> -
> -	for_each_mod_mem_type(type) {
> -		struct module_memory *mem = &mod->mem[type];
> -
> -		if (mem->is_rox) {
> -			if (!execmem_update_copy(mem->base, mem->rw_copy,
> -						 mem->size))
> -				return -ENOMEM;
> -
> -			vfree(mem->rw_copy);
> -			mem->rw_copy = NULL;
> -		}
> -	}
> -
> -	return module_post_finalize(info->hdr, info->sechdrs, mod);
> +	return module_finalize(info->hdr, info->sechdrs, mod);
>  }
>
>  /* Call module constructors. */
> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> index 239e5013359d..ce47b6346f27 100644
> --- a/kernel/module/strict_rwx.c
> +++ b/kernel/module/strict_rwx.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/execmem.h>
>  #include "internal.h"
>
>  static int module_set_memory(const struct module *mod, enum mod_mem_type type,
> @@ -32,12 +33,12 @@ static int module_set_memory(const struct module *mod, enum mod_mem_type type,
>  int module_enable_text_rox(const struct module *mod)
>  {
>  	for_class_mod_mem_type(type, text) {
> +		const struct module_memory *mem = &mod->mem[type];
>  		int ret;
>
> -		if (mod->mem[type].is_rox)
> -			continue;
> -
> -		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> +		if (mem->is_rox)
> +			ret = execmem_restore_rox(mem->base, mem->size);
> +		else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
>  			ret = module_set_memory(mod, type, set_memory_rox);
>  		else
>  			ret = module_set_memory(mod, type, set_memory_x);
> --
> 2.45.2
>

