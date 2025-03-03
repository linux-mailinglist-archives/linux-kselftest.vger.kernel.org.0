Return-Path: <linux-kselftest+bounces-28065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB025A4C440
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37863AA032
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7A2144C1;
	Mon,  3 Mar 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i5sGCaXN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rzJrxkf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919492144A4;
	Mon,  3 Mar 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014401; cv=fail; b=hx2Ge2wBgZzXCYZ+Z4FGSIcfDhObRWA08NmVRJPeDPupQNE+SmqU2gDcFNMypnKcv1wIBL2FCEYOZMFF9pP8KyjgYQxve9B3ADByJh62K1J+UW25GCCorVO+EoCpQP9JkXPDWMqWE3j4lvHVCnQ0ojkawPu5vTHrLzlqKVmBGOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014401; c=relaxed/simple;
	bh=kqZnmM/4pFAblKfLaDBxHbULM2MUIJD15Z4T3XxDFz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ug8lB/Bznf1+VSAUnMd/yVu2BwXJqNJjEhbZ+P3HQ5YGU9pOhqn3/WzUvGnoUQHFhX5l20cUVaH2yJg9bZfQIDTeZ1K14Lmm4bnnJHh1keiRPq8gvhmA76mUOmephDoaTNb/LTVJhc2rjuXXL3SQc2RSqTOSGCoW85UDgcsLGWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i5sGCaXN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rzJrxkf2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tqSG026480;
	Mon, 3 Mar 2025 15:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zovB/ZXzgCLrzlPv52
	OY5S3JD+043Ijv0JMZ3IrpENw=; b=i5sGCaXN/s5AqimgMUnv6nJGS0V27QGlJN
	xi8Pgb6tNO49RV8HSbTZcHUgDxp4Iiyl1n/V5GnZM8RQhTkpqPR8zeLGV9mJR/qa
	DUL4RzkBExTslFMTO2jX/XuoyqdzklErbyCGM+afK9ULQdywXhyR1GTZJ5h89sJ4
	TafZzx8e1docc0oT/B+gc24yM4JC8UThC4nABsfT+KmylS/nAdFbNbGEnKOme6jF
	VoZUQ2zAFCBOdIlCdLbXXOcb9Nvm7bOlUmCmE387HvT+PMIQu99ceBuwvuZ054cb
	VFlliOEebygHK25TXyLDu7vyTp25Go+83czCW7TGQj9pWbNg/TJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qavts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:05:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523Eq3Sr015767;
	Mon, 3 Mar 2025 15:05:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8u9na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 15:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQEKBXNB2UEbY6b1xVW90YAAop50u05EKq8KLamGud3F+1xPeqA75zojPdvDOjLvUjtsvgLSw8VIxuKMRt2ANuopTVDURRG6gyuMq+2smLk7wwVX/eDwoBoAvYQ7Pp9EQkGTCYufHwTJ8n+2jAo0oHXMP1j41EDAmzTAdY2tARNcplCamnO3BFU5FUnSw/a0019tksR+dojQxEq6FnhseJl+XOw+CTQeDre8CYQoLxXmyirjcoPUPzXSVBFEd7omS1BbpCzcsdvkFAerAYPTplhQtamdBOYtQVaDAFZMvt0lHF5ovZuAVj9EyUjiipCK4a0t5pjaDI9aiT2PiSDc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zovB/ZXzgCLrzlPv52OY5S3JD+043Ijv0JMZ3IrpENw=;
 b=uppSFvCO6gqQFQVaJF0zZhlwqdcwMCXYumJH1L6azaN11lI8DMHYddXvjdY3t3CYbvg8rhEf6jrZYo8dbTQb1Rh/6SL5gzp1k0nX0nAGr8gWwXIjudNMYe8ds3YKjjOxm4kmj3aWNlGH2O2/odJNuOzo+TA/sF25+DRY8kUOclohSzCxlYNyghawVS9N+BgLH00BTmNDktWp+kEU1gz7aKuLNM7J9pyDvpjCC1l6QIT4nM5hHnF49XV7dZysBvqTuR7eXzmqJuyFwh0XBZ8C56SZAZ6WigmcubhZUL72WJRyaUcUnLSFQc4Na3bHkcQPou7HdkgEVTVrUl9Tp8CAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zovB/ZXzgCLrzlPv52OY5S3JD+043Ijv0JMZ3IrpENw=;
 b=rzJrxkf2m6uSpPTo2K4FGaXrKZzhY0xfs13qwjGfTJv0WeCMT7vVK+v9tGpy0cVkIPq9V93wOQfB2fbm5/CqFix2/2jG+6jHKsbcd1AzeKsk84xk3hJwWUOTO6PeWQxKhXXVkt6Aw0z1lQJZx8um9LFYnNB1M/BVv4IxcVKkRFM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA3PR10MB6951.namprd10.prod.outlook.com (2603:10b6:806:304::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:04:59 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:04:58 +0000
Date: Mon, 3 Mar 2025 10:04:52 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
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
Subject: Re: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Message-ID: <hvxurzpnaxey2sxc6gq7xllyl36hmub4qvyjahfu7piywyfbjs@fns7b3djo5cz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-6-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-6-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA3PR10MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb9938b-4ceb-4ac1-a1df-08dd5a64c3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VG2ZTeqIGRoNrSJsyKDmffdLk6MP+3NlfgxoBRc5JWMTBgUwqc4JMLR7zrzs?=
 =?us-ascii?Q?YiWmAAPqJuj57ojq0VTx7VwZWQhsh1TiU9xcOhKatphsTHRwRpWdZM2ha3cI?=
 =?us-ascii?Q?F3Q314FSrw1KlCqzyg6UvAMzfb3i5OSbcDTMKHk7J+qgxY/Do3+EbVdniiAy?=
 =?us-ascii?Q?9haMC3XwIUdp2MOCdN3aeNsfPDVM3XHwXFthVJEQLys19ey0qHMDEqJr5sqJ?=
 =?us-ascii?Q?6FQ79Og1XhMhcg2YKx1jGTwDVC36KzHRmisQxY+ZJwO3tQWVjThqTnPZ8spk?=
 =?us-ascii?Q?CiHrvzLCywJkoDfq51gMgPdUc1dbPE3Pf/xxM3Zcpy+wv4/va8oXhxbUzV3R?=
 =?us-ascii?Q?z1WBia/c8jhHyTiXEVRH979NpnvWMiLTOLTsZjg3yFoKsOO6naZEpTQWxAr5?=
 =?us-ascii?Q?wqkRoXAI2ix6j7PcYnHza7/Ux91vKTciMmq1b/De5W++lXrVCs5N1yzyurzL?=
 =?us-ascii?Q?00quPmOqJa4F0mjNqzjkxbvYC7EOHw4c7lPeFMZJDuIKKpidGyvzihCTdViA?=
 =?us-ascii?Q?ZbmOo/ODJgKAwrpqa3t3xlh/Kx80jEEFl2xu0p3Jjz9Vo359y6OmysFGyH2R?=
 =?us-ascii?Q?mJ6E1FBEaG5OWiLGEPQodRQaYcd2S6Kgg9JQBUk96mSgBVyC+8E0n1NiFIPb?=
 =?us-ascii?Q?Fuzik3elUfWF+NyQGbixVVgysfhq+vKukxGFQdpXy6/3ETshdbKj4JsBWydi?=
 =?us-ascii?Q?iedPk+rnUAZM0xbO/ltXHuUfXD03b3dfir3t4Fr3oc+qvNhpAfD2jx1VVRHN?=
 =?us-ascii?Q?iPR6355eAGQrwUb9JDWca/ZwoVfU6sn4y+hni7ogYNTqYClj7lLQvmDJYZTO?=
 =?us-ascii?Q?Q39IEOQaSkAOJWAie3Em4EUMfF6F4bN0xvRdRl4rfY/612lpVu5Mfmm7oCbm?=
 =?us-ascii?Q?Ds3G5UX/sYeMzKdceqcGBzNfdhsqeEZzmWQdQIrguO27mRxwk2gEeed27VG3?=
 =?us-ascii?Q?qocTokTBL89wQnGUQnJER3yEhXSDs4f/l/bKr3tbQ8c7ZQDk/tzN324Fyvoh?=
 =?us-ascii?Q?0vXjBidAsM3iCNREQnaJlC89/onvmIOz4aVm6Ra8/mvzNt03fQ5JaC5GSbdh?=
 =?us-ascii?Q?G4yj/b4rPrqxQaAZQcRrkGXApaW+ZAmJIFOb114X1WMhjV4rexJdkMohEUkA?=
 =?us-ascii?Q?lVDdOVbjOaG8VsIKgzNqhN1keY4NZZWm7BXN+T3zxqzkaKmeiDG6pY06Pl3/?=
 =?us-ascii?Q?nJloz4QgXM3ig8+27BO8TS3I5QjKcPYDjdkXnyIvaQPln/4ofCPSAHOXG7jp?=
 =?us-ascii?Q?UPyOlhXoQP9uK9BzvPfzIZ8p4nkK0wCktSQ+kVZTzBtwkrQ2t0+vJ2PsxOyo?=
 =?us-ascii?Q?ReYA7yCHHwPYJvVqc/cMsEkHvHkqA1/SnlFfbgLGBrphbdXlbYJO45bC9/vy?=
 =?us-ascii?Q?AGJMQ1YgO1rbpwW9q908FhYQCP14?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6oNHkNvazD3Z/uliC3OJBgEc7MQOiC8FBHtcid1sswxfSmj7U9ryqkpAg1/u?=
 =?us-ascii?Q?6P7R6ksv5pEq9iSWPHASvDIPopuvh5fL/YJ9FuU9J9JV5LsLnlKbWLu6VMjs?=
 =?us-ascii?Q?ITbrzoB0GgbPAcUUUSPsaBl/T3dW+ueN7qkAZekDpCnRamN2WwPO6c139g9y?=
 =?us-ascii?Q?fwoxnXVScXKYiuXrgcNJurihgQenk5r4zdSiCnzdb6GMy1A6mUrggZK2y8aR?=
 =?us-ascii?Q?NRMDUEagvBmfonxZkRgiKeAvH4vR92qdqlCAABoChHyH8ygCg+k1/xvHlmL4?=
 =?us-ascii?Q?afEu5vZilQDdnYi1v0360hRxkNFGrD6wvwziYLFoV3SYzh8EnTXZearcslNH?=
 =?us-ascii?Q?Qq548brtKgv12U+gYFJLop0F4VBPzhrFt3Z7l97Oip2bDqmWxtiuZkkcVdB5?=
 =?us-ascii?Q?zpVJ7S+IxzDYHPn1/3r3JI2roWmLl22DLPety06/qZ2axzc4NRYrGi4MBaqq?=
 =?us-ascii?Q?xZ1ue/ytqnBsUr0PYZCn7fHPN6uQ18fPfzY0lVM7p36ZO0TvaxozJ28bx1sl?=
 =?us-ascii?Q?PUo2nRWdQ5LsQbkkEDNP4Y0hGrb0Lj1683g3J55pzf1O/nt5Y8CHhYZWifBM?=
 =?us-ascii?Q?PRrzq2nhmd6CPpYw1pO54BEy7s9S08GHmtynxUnoL4ttgRFw3eRG9c0HwWRP?=
 =?us-ascii?Q?ZGGuOgFYHCkthp+MRisKs9drUc0tl53hfwZ6Ov5K/hILh7DugoS6NiyvXeXv?=
 =?us-ascii?Q?xKd4vS5U80ZygAebUwMbvLnOmbEm4RN0Na+WutqmhkSP/jvf3sOazKL9Uo9R?=
 =?us-ascii?Q?caGXskzB5IjpvzXJdPERd/Z+iiuwpzHWsAflgVGt/7RperZthm5Ay8NhOM9Y?=
 =?us-ascii?Q?8Tk7FB7+Is6c/ZBabUMH8HWTQvR908luhQ28xdOj0Vh22ugSLxXKGzHU084b?=
 =?us-ascii?Q?LraLUYwK6o0BsUUBDK+4mUptuISjzQuT4xJ1bm82WTVPxx1YMbcEBVZ3KbGu?=
 =?us-ascii?Q?8LCBvoz/CLqbx+eIWfIx6ymAQoJ3SuzITlkXtBksX7AoiY7fRjJzvhEGhS0A?=
 =?us-ascii?Q?HNr6jaumic/fauH7Y+ncAyQFfsyq6XZCYHRTQSfPIR/IITxPEFmxGjtrRfvP?=
 =?us-ascii?Q?zY8i8/Y7rlqiNrigtTlD9aW4BXaxwUQ/JqnGmCaApIf3rMX1neBEie3Wj3M6?=
 =?us-ascii?Q?NucEZ0Jqb8+TPh9UIrbCziPRdBWB4cNgefJKi6f0rJn0w/+c9N3umQS+hRHr?=
 =?us-ascii?Q?Dct5Iv2F2KaUbuxcVRjH54aqVNuUdzZ63Qvh0I4s8PU/SwPfwguCnq1lB7Rp?=
 =?us-ascii?Q?t09U4vzSMr9yWuUkC/nXZgbBfXBkdH/czmgaBjO6JJKRGroRs7MJXph6x7Zx?=
 =?us-ascii?Q?Zhd9MHf6fmfXwaJCBoD9HwYko8otIozm28gnZGbiG8aQKEyG1J2qivEB7peP?=
 =?us-ascii?Q?uR+47Se3QeHVnqYO3BFW4czt+Pxgd8K/Pru4fJaQ4WQ4Acz4iMvG0zJBesw5?=
 =?us-ascii?Q?m4gCvKT9iivgaI0EXJAKb+HBcX2kk1NhT1HS+JEkMAKj6DnoyT8f9Q4pS6V3?=
 =?us-ascii?Q?OPhLORHfszjW6k449/cJpUWTaAumrdLLvFiCrVEcKxC2YuAnumoMsZYmy3Sd?=
 =?us-ascii?Q?8SZBSdhKjtvrZU3YDOnOMr7NMVUFZYSOqBeoPFfD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	97pksrKdt6MiMazVcEaIX+NGauWU6cYbmfALU3rFTk6UnEqHwgzMEuIF2H+Orry5jjLteCohT2VXMdBc8v+zR9bS5EM1f+XZyHvIE8086tNllT8r+hLc2inAJiFqyyfMZCyrkk+72sLRrND1EMHHRCrzlqCRuDFXzTx/uW0oZtlG0H2GzdyCkwE3Q8qMwnaRXNj0Q/SYBi0FyoF4CK9yV2vnnLoC6IyxPf5A5y0dBERaBPTc4d6dKZOzCgWQkT4IkxXoCEmFyjlBfUk3LPWVyQHjRA6L6js7V5NONRnVQuOCHnPPMDk0l4pJ8i1o0/qpGky8XjSnjCiZIbpVeJrfCvIHpS6+XooXKreX5IQ5oixbntyDOX+1SfmFBMrGgn2JvLiKllWkr+9C+/5dtCpikiCSrDg2cSYivMqQU4ybuOMEnYGg09dzfbK53Va4Rjwh2nPwu/mzZpyECy0vwNgfBfnJGTE+wFSD/GjdjaFPkYl0lPxg90ZTq8ExgdY74pghsUYLX3bdS8kGn5yxOe3r6Lg6RASdILJwuUG+PEp4q6FYnb/wAy3XYhK3HK+y9mNf3Hwm0uzylnCGaFQ6Ir/aYtllBzhfVrpiBNOKRPoerfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb9938b-4ceb-4ac1-a1df-08dd5a64c3ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:04:58.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JOHn2QP/VoGMulXeCAVLUgqSqUdi6ciDvNL3diZwi4nPv+LTuYHnIwVi5Kj/E5RidUZCEThXN5+kytqIe3MeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030115
X-Proofpoint-ORIG-GUID: ANV5jjyQ9kUKj53lpUovGp4l55a2jSCq
X-Proofpoint-GUID: ANV5jjyQ9kUKj53lpUovGp4l55a2jSCq

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support to mseal the uprobe mapping.
> 
> Unlike other system mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime. It could be sealed from creation.
> 
> Test was done with perf tool, and observe the uprobe mapping is sealed.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/events/uprobes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index bf2a87a0a378..98632bc47216 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	}
>  
>  	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> +				VM_SEALED_SYSMAP,
>  				&xol_mapping);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

