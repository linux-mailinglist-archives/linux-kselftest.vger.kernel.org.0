Return-Path: <linux-kselftest+bounces-38177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9DB180C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC45C1C81962
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE723C51B;
	Fri,  1 Aug 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OR2TZtdM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u6w3Uqx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFC19AD48
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046898; cv=fail; b=XgFcWA0yY/3N43oPDSgmJHeiBc+6cmDulixAGjnqbNMmJGl7s0dfGLgSp7NNfB84O7CzOgcvMGHJxON1LbhMwrYZgs6YX2UgYk/bgM0VGRX/B0VNkO7Pm62Gq7w45nHE/rx7NYx5EI3wDG3Wr1JL5Az/9PqMyoQs1J9diLagPwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046898; c=relaxed/simple;
	bh=eHnRDx2eUZTAYM1dczaGguAX57mVqMpP6SSsfuHwafU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9wlnyw32rQi8I0XgUwmxBecNK9t77UvimLh7qxRBDPSZsBwmW3gjaPDPTESYnzavruV56zyU1/ImsVOXEOb5aEiOKZqiFuGpDCWcr/4sfpl+DBl8sP/oDwAUulL6HmzEBvRv1vg5KHMhbCwyXxKZawb1yTbmCEfUe/B93LmscE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OR2TZtdM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u6w3Uqx6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571B74xo032152;
	Fri, 1 Aug 2025 11:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eHnRDx2eUZTAYM1dcz
	aGguAX57mVqMpP6SSsfuHwafU=; b=OR2TZtdMKc+YET8OaclDTsIkENbAkoI2D0
	KsbCdVMhtu4fmAF+ymDt0c8KR3CgNvtU1JO+AQgXfbizQtduZ4kxMnptN+fYAjh+
	1pj/5hX7MUatYtvC6aJTCGY2nyyYxIhZrCkv55gLY/B2pnAkmD7P9f5v6+xsBBPw
	7zU946N5c35ek0zKmS2HD9NjowYQZz2/FINgpK+J+TB6KzBlA2FtCFihVmJjm0KP
	iZ5Qqle2IAFdH5Sbw7eJhrPllzcCBXs7OBl4aYhocQAR6JPBr9pzVWurOECJkHX/
	NH8SJ54B+pKR+tN5U+FmWdqIerGPAXrO07vfrALOzOFVlh3OrBIg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2e6b79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 11:14:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5719UW54038558;
	Fri, 1 Aug 2025 11:14:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfddvvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 11:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxvKE93gFz6d6va6xoPhryFSoLvMNKTs3a9oN3qk0W21GFpgYz8YrqSjSCCsyg2YmGyjWW9Y/X51IX6FOij/rRG3nWMmSLuNsGvJdJ8vJqGQOx2tRvMPsOf/hw2nV7eCHby5bNc30azUW2ihHg7H07T25lYQITYz+tqwROIKXvhFgYZiXdvbli7xqSopvHBIHtXMqoi4pkkh64UrE2D12t/RBtUIzilx8+ZcMNLuk/pdvclwIrCF8AqwiJK7sVWgVvqSgj9AG9AxwOFL6xIsf5FnO3GYBdXXZnoHN4CnTReR9ylruEINLygZQjb3U02vEeXgA83Oogju6IX6vpbIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHnRDx2eUZTAYM1dczaGguAX57mVqMpP6SSsfuHwafU=;
 b=N3cvboz/kfWMcMZVzuV68tSC/jrxhQbr7ydS4V8Kd/HxdNZ/jqMSbQ8MrJmExRIiSuO1YCDIxTMXpZmun2w7sb123YaRMEn68GV+ZKM2VARPR+OwPzJiUl6PcWXt2E2TDdudSSgiQQc6QmNUOZcKrmST370bjBXgFduoo47GGAIDRB3TOSYKIBWIxnW/AR4qj9CsKJX3kOXn/xrNUSHjd9R8rMGl7nxwVy6+yGcvuN3Ph5oWXsg1SVFCT3nT7XJJtP/qbGwPYCgkrRS/zbJ4xlmq8tIdjtLc1t+9rnPbR6CzpuqTg6tLDJNzxICHhZOVnNsrlyZzkV1csKtAvjUSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHnRDx2eUZTAYM1dczaGguAX57mVqMpP6SSsfuHwafU=;
 b=u6w3Uqx631kEfMGR5exIs+1U9HH/yHyT5wUxhFEUPAKMxf4GNmin1dr28Xj52kCZTe8TivGrMWx77mkZ6+DSmwuJ04X5VKZ5vUdCPvLSiiS9fgXi2Q0zG5ZLrzIFVyqhsmTaMgBvljMF14b+sCh0qGiEfMIk795oFsR5zNRSyLc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 1 Aug
 2025 11:14:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 11:14:38 +0000
Date: Fri, 1 Aug 2025 12:14:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] selftests/mm: link with thp_settings when necessary
Message-ID: <de1d81bd-0178-4649-97a7-016f6f349cf4@lucifer.local>
References: <20250801085444.27182-1-richard.weiyang@gmail.com>
 <566ff1f0-e6f4-4888-a901-4995a84d15b7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566ff1f0-e6f4-4888-a901-4995a84d15b7@redhat.com>
X-ClientProxiedBy: MM0P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0e424d-ea64-444e-9756-08ddd0ec9ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6QFtj4aNAJ/X7rkw1vU3T868eHsU20QP7ztGuPYmRKoGcJLvkgF6AjjRxcj8?=
 =?us-ascii?Q?Mo6Ox5NUaRbWAqWgVvjec28Zdb8aD8YoSvVYKKD3YBhskjidAxX0LmM1Gvjd?=
 =?us-ascii?Q?Ao3oBsSmFISxBXshI091uYlsre+QHQUJfOywmVZmPDyvJEwJrUaCjo2wxW+r?=
 =?us-ascii?Q?abG5/g9qhIrSEpnKCaAxiDtlKVzZDmnRjLZJ5z7v+sMsN1sK4BftGL6AGQlx?=
 =?us-ascii?Q?4ut3yORGABw5tAUo6UPaW5j9mGJSQsNDZn4U8n672gd+UW8DWvW1OseYBpWp?=
 =?us-ascii?Q?uM9B3cvKlvr+Rw+vyGbeJIAEuwvvhGlRwOxCreukM3Nyk95qCc0MpdaHOprD?=
 =?us-ascii?Q?XaU0uWaw3XKWhnrPtwrJqKFC1rpez+rXYM0Hvb+a2S5oG1iPcB/HVPrCdFyA?=
 =?us-ascii?Q?Hz81SJblgYFHyEg3ialZJPaAd6Un3TyEG68dh4BNgSG5bgjXcUHTwBvPZQPS?=
 =?us-ascii?Q?i5HGJvie7FzN8zG3AagLLmfnocarli+yrx5bjc3witmkuIh8Hbb9NEiqO/g6?=
 =?us-ascii?Q?s7Lwc5eok/Zb/d/tFJD24A+OD7N9cRbxR/ArXmlWZynLFG65JmysA1Wh0sgz?=
 =?us-ascii?Q?QumPg1U63i+QUA0H5lQLkMmjpQy49MrJoTECR02KLwSZsY+4MEPTGfGyMBDl?=
 =?us-ascii?Q?mbId5rvgyF0ubYsRLxMgipBsyQNSrVZD99bsED4Ge0bidVlhJE8R9h4LYLyF?=
 =?us-ascii?Q?tmoVHpXfp9abFlgWebaKBUGbOj8bhb8l+vi3Fb+9RIsVO3TYmX6ZbIPRwzHv?=
 =?us-ascii?Q?GFkezcXouIwB4DNEwtiC4R3f5AuBZjQ9J489LG3KNtuhZGIuBGhtz9ScUJp9?=
 =?us-ascii?Q?+eGl7uAh0CXb6VgWA+A839dBNhbAsZF0+yv7Muspe7ehX+mAXcTwsf43PrFA?=
 =?us-ascii?Q?IQP+xgMOL3dryDTCwmL/0j/r18OL9FbkrWuW+1Ft9y8hwMl4/eclaoW8jQM6?=
 =?us-ascii?Q?zFTZRHaXIOT6KkaaeTsZZ4GdC/VEflgYt2ghEQdREfUzPImX3dMVmUzoxfeE?=
 =?us-ascii?Q?/BULVm5q8RjOeiIRGDNQ0MSXevNR0PyK60NF4memdfh7Re0qpCGdufnZRvDp?=
 =?us-ascii?Q?x9Hk1GzGRxpki0LJhVdqsnWJJ+7GTLpEtvjWFzlUBgIcFs/f1jR1jX7oyXG1?=
 =?us-ascii?Q?mggyst4dhPVI6chSlXlgmBEH4azZBYp4ETuKHKD1E1jSQReQUG/t1NyiwkN2?=
 =?us-ascii?Q?InK/FA6IWWI5+3ROAIoh1f/NB2wo5qJ2i182dy7GLMjCDdsFewxNYVA8dCl0?=
 =?us-ascii?Q?z5o7N/C0jWKoMX51v2yPVdNY9rfrwjcHhteB/+B3c1uOpw5Livm3CN2sA2X3?=
 =?us-ascii?Q?QwyROLE7AVA/ANFQ/LFWK764tEqINtUs1upBbh3ijAer5hQrn0mEwBagdEN2?=
 =?us-ascii?Q?DZAscM59M3vdaWTHk9C4XZ2OpPipSyD+cm3XUqgBMfc8Y8oTDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIz9unoyCG2kKPCdyZOz4/IcOOymmPAdwH8B5T2pc8RPQLQHRQBHR0ABEk07?=
 =?us-ascii?Q?DcFuqCSdI5xufcBMQMc1574KzQbQ48Amp4arHuOgcAcIMwK5ooG3AHzhmqN3?=
 =?us-ascii?Q?qt8h9Jfk7zOD8V+fdiSLspvNCiWPN5CSVJLLw07CCxRhT0/n2Hxg/ezezIZU?=
 =?us-ascii?Q?PxeNxs6vhTSYyeBqbrI1NsVzkXeskRoptkQJhQhjMBcl8JdUXbNRXp8gWriY?=
 =?us-ascii?Q?6KxDKOpz+hT+BR14wXGEHzKW87SOIjoDcllBnBaRfDNcTRyVcF0nJZXPLfER?=
 =?us-ascii?Q?7em2z/Y5MqvV0mcTMNEZC/cFgb6mkTQKLsvqU4e1PbtO3munPa7BD2L2D8df?=
 =?us-ascii?Q?h9NBQsREuUK7qJYE6rOfWOwif1rSTO/IISjM5goWmC/oxghbrrmS4FA5esXm?=
 =?us-ascii?Q?6vNVTLCc/VE3gJFpJd8qDZw22d2rN6XpHfmkvG1NEa6go3Cr8tSwlarcXgf0?=
 =?us-ascii?Q?uPTiZ2O1ZQSTtg/sLS4sb34Z1GZk5tFRUK4x5p93sbPuIMyu0YFuP67TkB2j?=
 =?us-ascii?Q?hMFLWDDVvEOXqWP3ku+omIHTdxS3ZmtnxB4aW7EZ3wYyqHqMIj831sdxcKLC?=
 =?us-ascii?Q?q0pL6MM1lRvBEGY6KcY7y7xfsHFh5iH6T+Tw7UmuCGZGYQr6AH4eFHD6XSip?=
 =?us-ascii?Q?2bILAAoErxbi1BY7NWhGie6mDsn4UrdZz1uookgmv76G5TOz7d2skRXpakIi?=
 =?us-ascii?Q?wyexyWNEYDc82ZgGqo+idQpNKgRzH4vurvD4f3MxFNHybttAz5ag/NmfOicd?=
 =?us-ascii?Q?ik942R7tGFNUH49+edjcRsz2DOhtSv/3A5skRrNglC4P9B/WFpQf+6Hx/lU5?=
 =?us-ascii?Q?NXV2e24UzHOhNJJgUjN5FwB8VVIj/v6Wn487zo7X3o+8tDy+djtLr/j4/aJs?=
 =?us-ascii?Q?Yx+2P77+ej6DhQEuBKM/lBzUy/1BzX6ZptEYVvURMT9nAa3mYSn7OAYIBVFP?=
 =?us-ascii?Q?dLW6oFCrmNu+OtLr8wuGBvUXWoOcNI2ERGxe9mK7/Z7Do5TnMXWygXICWdwo?=
 =?us-ascii?Q?mDOv1Sp9hakWDXysLQF2ekFqLgi0J3xmFd8hnDM/yrzbHJL6MMk93vurJEdd?=
 =?us-ascii?Q?j8Nrxjo/8cwyuO8BMndxO8lZsGtMcBhP/hX0rU1SeBvdjfjKH7DXBEznQPiQ?=
 =?us-ascii?Q?C+Kxb6lijs1U8eR6FH7+dg1gqV4Gk88sqFQDXjijhItNuviYDNxOpVkyxRL9?=
 =?us-ascii?Q?PJnxMhCwU2VcUThbGVKgRyyKDdHFQNi8nsxhXvOJZ95HG34wzEvDRHPDZucy?=
 =?us-ascii?Q?2cNCXiaXf+TbYTTwouo72G31tS13J3nPhSbrj6G3RszJ25IoW+X/AIa2nuxf?=
 =?us-ascii?Q?C65j8Bb7MrxKe6SCpE9mdNqYCy9GWDyazvi4rKwEQGi33CDQZjd/QnowrOds?=
 =?us-ascii?Q?7VMfN1eJloeRTYVrHcjQ63Qwse84r65/NmyVX1Vr02Nn9icvJ5pMzUJO1L8g?=
 =?us-ascii?Q?VVSZ5DrBO6ErgbM5GLSHt6ROX28xB4exUEoHTDSrbu5H8ZeHkLlh7MORcSs3?=
 =?us-ascii?Q?zluuKjUmX5Pm/X+bVRKN5pqOL6OEZiECJqOSVOiAj8fSKegMXK0tERzDwvC/?=
 =?us-ascii?Q?GMycOYL5oz78XmSFZ/TiqNeJ6COlW23Oqf9QFsmfqkdQQjzg63CAky8Qvqqf?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	44FAtuVnLb4k+bpedcWk9n5Kzg9PrM1qPflSb8I6hWnjAtsXq1Gn6hWZrIW1R8fNb8Et2oB6Tw2eoEK1GuZfg0GCPOkRvSzeRkhnCV42yqJXYzJWEFpyNMcj/cNuzdMdv4PKNfnT3EJ6yoziPsTV+4guZtMToaijOm6ZawKhbeq3l79ef4wqdk0P6AjsQb5DMENLdbxc7y6dnG+KGR+bTf3BwmbhZvVerub3vb3fRduoK0de94BxOY4gPTo2SgZS838wJdbvYPtoMzo1j0PrBU8pMokOyLJC2JmAszmIw+dXTKn4oMNGLC6hUKky0hAZt8UgD9mXaulgUDX+IWDEfBIKMnGkxqOKXmOXD6pGCcMaiQfYAFSWTiU5cKPwyzDeDVAE1eUuNLT1o7fUqBuZmhchWGfmgYHq+Wrx0hFe6A6vIFUVGfINdFu2tt+ioLZk+EIcQnj0GfRPUAmCBMSX/1gdZyl4cXwwB8ZrEIuv1et77B+MMQqGG7VZAwoSv+/4BnABT2Y/2UIFryVmV+UpbK2LQcBvkouC6CgPQqLqnrOZVIfW4STXGQormnDWXTUN1Lwspdkchpso1B3pm+XYrrwk7dDD1KQsewI4zwJPtow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0e424d-ea64-444e-9756-08ddd0ec9ae8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:14:38.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqYVi8C8DtBvwNQ+F+vujXi/A8vSoyCsS55978bXR2FrYtnXi6KDmAwrH335QX1GGnzqVZw4X3/fyCwE9+2+v4Hwv490OutRjJLx9Ofq31w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=749 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508010083
X-Proofpoint-GUID: Fb6swUzVyhSv-Nup29db2AyLo7iIw3r2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4MyBTYWx0ZWRfX/S6P5ehAiX48
 RTepkt+/ZA1Kxq7gvP2f13uFx0ueDRI0KWg/KQ7iZyfIRl6+V8p6XPbDewHhT+70SqFYzpKTPiS
 bitsstuYDGjuuh/+zvfOPmqyz7b62IkqcSXOPeaDVTLZm3Y9fHESsdbwlQwtH6pwHLfYZbF8k7o
 kfNDkby4CDwH19BaKlGcbL0lFfOh5LUthr6PlQF/8CfbAux/1GjfVzbEOR+QZiw9R2dzQUhlYj+
 LFD1obft4dptNvzfvYqG8PRxR1ChpwcGnTtCCHlnl6s2F0abSodSEHIFC+rL6ltCXQm7FpiHIEe
 b3nl5EFhDc5ef/xQqb9TtH7Lnl9ZwPVnbiINIPy9iDLqNLyJoS0pH5YSWbFJ8XxCVA5as1vtVjI
 zBGZfvv6D/41nOOocFXs4UgyENlimQXUghJ673HlCaKCeMqYWjcRBY1LkQser8IJ2sDhDflT
X-Proofpoint-ORIG-GUID: Fb6swUzVyhSv-Nup29db2AyLo7iIw3r2
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688ca1a2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=baIP7ji8i1j8hJXZ0igA:9
 a=CjuIK1q_8ugA:10

On Fri, Aug 01, 2025 at 11:02:35AM +0200, David Hildenbrand wrote:
> On 01.08.25 10:54, Wei Yang wrote:
> > Currently all test cases are linked with thp_settings, while only 6
> > out of 50+ targets rely on it.
> >
> > Instead of making thp_settings as a common dependency, link it only
> > when necessary.
>
>
> You don't state why we should care about that? I don't see how binary size
> is a problem, why do you think it is?

Yeah overall I'm with David on this, I'd rather we keep things simple (so
you don't need to remember to link against this file) and just plonk all
the stuff you need to link to together in the Makefile.

It's not really a big deal when it comes to test stuff I don't think.

Cheers, Lorenzo

