Return-Path: <linux-kselftest+bounces-17167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D196C78C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F7BB20C9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47D1E5015;
	Wed,  4 Sep 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4zImRp5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nDO/Kkz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAC14037F;
	Wed,  4 Sep 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478150; cv=fail; b=OzYQQwJ+2JVJMIwrbFucpmZoHQ1k73xjN6Mp4Gt6CeeHQGyrOFftPjH577re/7Zx/b66eaJSJn3xkaF7CqYBVbuKzVqIp10EnA/RyTWrKO3bCMZBZOCSygmmAJIuroI/HPuw6PFXpUG2GMorktxhDSxYVtcLtYft+6Aal11qoRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478150; c=relaxed/simple;
	bh=T7dFZfWQcpkIZdrU2leI7dS9TOHoKGvvgtofVMeR5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvteDJN4by+KhWo77kyGO82ezUpoc1KwlIwiWkNp9fDpGSrVDoxlHriWBCdmij+Cs1pfWumkVYBxvAy3dv+KHZM7F8+I7ni4eaJtXTs1dCX6GqufNXnMWpPWCWp8hRYMZai6LWAJz7VdYImj24avyIzynjrc0VAY0f8yNVMv03I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4zImRp5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nDO/Kkz5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484I0WAc003755;
	Wed, 4 Sep 2024 19:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Sy1diGiuTmU7VIU
	fM5JFBDSfz0cjC33Q7PeB9PGQBXc=; b=l4zImRp5tdjQuNkiJwgMLtE4Ht0N4HT
	XMUVxYrYrTeX/Q/sH0FVbGSTmqajMBspQH2rWJHwIaipgrjubtGGyYXqomAyGlK6
	eJ361EPQqX2FhZm225tw9Mmd/t3rMdLL3P2mfQ7nxW/D9Znuu7C+HH5RtJLJoUQY
	tbMMfA1vfv7VtjnzKck30TU8FDgP3UJDwWkUAoUmNFKYgSIbcUlRL9VIBPAe1KVe
	fCLs6O0+6FBuyJDbm5OMjp0H0uhFR5SJMMbAAlIw7XMYuvMs2aeG9tKNlHPXGQwj
	lZUv2Ud6ZWQziwLSSdCH28KPpHROmo1TpLUDaNs9UFqKYYkKYSoob7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7verv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 19:28:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484IMBKp036727;
	Wed, 4 Sep 2024 19:28:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmah4qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 19:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6uWq0Ji0qbrQksUmy5RoRdHKQeF1isyUlWihgsWCxLJKXPtpVBhb2gIOeJMsrhwsLNFDy7t/S1ORaeYy/XKtKWBN3mIL6YLrDHAykCJP+Y2+zaaVRjwrOi0KiSdxIqBCWKEbVK9LQ40qMiMst/h+bBY1QoAx8of6Kjo9lpun8Udk1TF8/3L8XiMrKjMFjVTF6Y16gf0TS0fJQYeG0llEbs8LG6JbGKUmubnC2RlShiONDfPXSPAKK1eqxKKIuGH1BrJpItJzYMobGy8EaE7ZyIgi71qnvemc1Bjl0JWlwRD648kRRPy6dAJ72Px0bgecGJ4ctG0j2Yyc6XXf9z3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy1diGiuTmU7VIUfM5JFBDSfz0cjC33Q7PeB9PGQBXc=;
 b=lzz92Jx6TjYenVnLS9gvS4+1OGU9qkcCHVuQk9HiZOOnbh4P5D7U7R1A7jiotP1fh7OUYZreHKPu3/lNdWGjCrTs8SaxGG5t7rEmqmblJlZL0DJRzsZckfH5fV2W/Mb5/cLYqX2yA9cgeKJ26/4TZ93sz1Cya2IGEGpHKAsTsYo1u0kxs645Knd3b8ZXw+EmsqjMwOF6cY0gb/YXQ+chtVbz/vw2n1GhVdaGOEVrbK+ugM/8yRPVvUY+DanGa9Cl2QfypnKp//zGKwC1eUuAtimmdWO0RgkAgRrcl2jZMCz2v0kdM4lEFRBT7X1f2RjLoxt2IWsGU0hDsXwlND5m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy1diGiuTmU7VIUfM5JFBDSfz0cjC33Q7PeB9PGQBXc=;
 b=nDO/Kkz5jjpX7pugK6KAwf6NCPRsanhDxWlJoEBKjmJdCTc3dEGulTyihopsV7wvLQ1P50jnrm8pH9SlBYc6XubIaj/08h/Lv8vx1LAeww7voXwtC/+Qa3zDO2l1sGjyt4OCfBWSoXnIAPiQZ6zqUkixufKyMec6EsbdgFyMeKs=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Wed, 4 Sep
 2024 19:28:09 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 19:28:09 +0000
Date: Wed, 4 Sep 2024 15:28:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/vaddr-kunit: init maple tree without
 MT_FLAGS_LOCK_EXTERN
Message-ID: <kuy4nfsjxjul54dj6u7p3gazov4mb2no7svxs37arbhcv34hhf@qmk7fmgc3ns4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	SeongJae Park <sj@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <34f3e9bd-9323-43cc-8371-00d8847d8664@roeck-us.net>
 <20240904185347.2253-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904185347.2253-1-sj@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b3d2c5-e3cb-4221-241d-08dccd17b582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lcT51v2aqBU8sOmgYo/qBmE96iwxRn4+8OFCIDubC80VmLde0SApkhhRLED+?=
 =?us-ascii?Q?oBKRMioS4QKgQoiMDm+UnFNEdg5EZbVY07ldHfwkAYA18j7UElMGMtDZofr7?=
 =?us-ascii?Q?DVxIomkH24Dio1thJxG1KlzbIDWaFDti6djrneXSBiq9OfmE/NG5Tae+xj5k?=
 =?us-ascii?Q?gZoZyYnPtpI1JyjRFyTZ92vGtkr7gF9VEZA8ZTuyc8Rc7lw0v7KsJe3f1TQm?=
 =?us-ascii?Q?doia4GHOOjpxWX4NyLcjhTen3H7Bmufw1jNe5f6nq1g2UsTBU5GXnRkYqtwq?=
 =?us-ascii?Q?be4+Ghmd/j/eeyyoCSdFl5sNc6+92Fc4Zh3PMfOrVEIUAbtm2ZgApaM1Cd4S?=
 =?us-ascii?Q?l6XzibkbQvhV/B6M21wEPWvsQyz64pCttoxM+iCoJSp6tZqzSZPQ86nVGC/A?=
 =?us-ascii?Q?K7qo7qo2gdEL3RFJ52fUnIkzWUyST8uWJxOXn+qPQq+QjJ+OCjYh6F1PPRLl?=
 =?us-ascii?Q?2IsAqzcVFtrjDuGf6doXsYT2vzLGbVAROdu3HmDTvnVWC/C44wjwusEU61jd?=
 =?us-ascii?Q?Lo7okfG4vFDF3lbzbhuS1LQQAXHjpRoGwmq4Gb76dIyqk6YkP76yVkKSxSx/?=
 =?us-ascii?Q?xCcqdrInDdw4MhU9StbZYDF0bsakAUQv/BSVBtVbida9b9JGB7wedMOm9IzJ?=
 =?us-ascii?Q?DkybofBlmeZR+hIDTJuMRmVjb6DKMPvaCp5Nwr13lYLgqZSD39AS4DXkOpsC?=
 =?us-ascii?Q?552rGn9Tl2GYhqtalZ0ETzj3ynZ1JjjK079uFPbfKUSo3Rz91Dw8e6MnqJt5?=
 =?us-ascii?Q?tSju5NMhvfYbou+GxO+xDqYu1Dh6izBepeaa78E62Yu1i4mhp83rkr/ReJ6d?=
 =?us-ascii?Q?bvIK/jQEf62bVf+SYO8dCAWG5jTW77tZvrMvtwOBwWzu/KIvrd9ydr8r0Wz3?=
 =?us-ascii?Q?fdtKF0KsbSLjI7yH3VnLlyhV0lRVRTXmCqkNIlwvufH6/jYCEejGWF/6MkC9?=
 =?us-ascii?Q?1TpX2Q4mcXZPZsVQTv/2Eq0LvFlBBS1Z2n9Gj6zbqJXFgy5iuJatErzY03Aq?=
 =?us-ascii?Q?NuPYx0dmyZa4TU6DoTcBpjSetyZTUey6aCM/RaZJ6Hq6JzmUDK6oH+0rvleb?=
 =?us-ascii?Q?dkwGG8ABrQ7RhWO9BQoo9ARfjuQXWrDCaoh2v9o9pYMzuRAuuU8iEc0rYTLD?=
 =?us-ascii?Q?Z3qPsJNsjOAb7XGD2ud8W6sRtQOHskZkAamfAmmbEhnZfjg5x15eTKYOZbVG?=
 =?us-ascii?Q?zzkV56iAlZecWflY9rRRN8bWCArqHKLMAWSIJjuo5UmmbtZKlOeMfg7G0aDK?=
 =?us-ascii?Q?t7s357tXyX3eRJoJ7nnwa3ZJ5E0oECd+EjOaT7kT8F19ZMryezgZGWbzaK/u?=
 =?us-ascii?Q?aw+vLdg/GZcSj2yDRYlATdWEqZs+4fdeuQnKLy4M4tWO/jvdK5UJD2TIpb2r?=
 =?us-ascii?Q?uvuOhps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNNf7VqedfvryQPG6ZNJcaXa8pbR1IrxEj8Y4i1x7rFXDOCdKZSo+wy8GtcJ?=
 =?us-ascii?Q?hmI3W4pQAbXIbE1xg16db26A1xNkCTqCYVFhBMN3JodtOKGZ3zQWJZnovpqI?=
 =?us-ascii?Q?DZkiwxRreYFnISoebVog5uxLkTUImJDZU6twN35poPlJSZCD+N0WkLmQ8kiZ?=
 =?us-ascii?Q?BK0Ty7YZ7HMFCxibpW8HqJlrAZ9m7Gkri+xHPBrN77mEtamWseb+iBdng9ix?=
 =?us-ascii?Q?YWhpoPyp9u4gUllOeGSnekK1EeVGBiIrOBGkMIpqurhCTbrVTUCGJYobaQFK?=
 =?us-ascii?Q?xq/5X49VKHxZ+VLFDD8DBE07jH84AiqmmynO9cPcv1GKl6uSiANfNdx+dYn/?=
 =?us-ascii?Q?B22DZrHvqrj2FaiTBWj2esI/LLTNxKJ7EooMP6X2s8gd3QRNatNdRwr0fkHa?=
 =?us-ascii?Q?qt0c7EADlND20IO46Jfwr+q48xJOeYP99t5a8mq583JOK4yM5p6diuuoI6cq?=
 =?us-ascii?Q?e1P193aspr2IprsTLPRv0hur4WupGwLDSkaJOq6oqKsb4Ty/kAPuCEq3W291?=
 =?us-ascii?Q?VkWgVpw1eDc6jcYcnwai5ZFJkZS1P+A40KDDCboTVwYGRQwzrNV9dhseKq4j?=
 =?us-ascii?Q?S/Ok9gbWRgaslu0/+WGxnrzpIUOUBqnYxoWbJnXQY0w5CjSo8J1G2GB6R6BW?=
 =?us-ascii?Q?cu/B3dktq/ckvWfG8Lwt562iz/9SiS/cio4MY9xw7n4DwOT1E1FMWKe1KrrY?=
 =?us-ascii?Q?gzMZcw7NAJQONJf8RCsTW7ipEHZ3nMj/AiECzWb1+i51a6w4jAJY9J6UFUAI?=
 =?us-ascii?Q?AfB0aOv8WoEPAR+jglygb767B043Ys+HdGu86gSGJTKb3BGO7ZCTJs/LD3/2?=
 =?us-ascii?Q?2gal3+dcC/VS8F3KaqxM6673i+jzzeJXkWJBuzUFxxY9MTcr1cl1IibzPW/e?=
 =?us-ascii?Q?dcn9cU7yGPc2MzuNx9cOfGvigisy6oABjoS+tYv5TMDvBecKOTD9XrCGKnl4?=
 =?us-ascii?Q?M7Ys2QB6oM9xVebxYnPYUHMUsytB3e5qbkLM+CgKfvjoCybsG+j/7ntqZ+zD?=
 =?us-ascii?Q?UlcxtuGJOizuT+kKrQNfZePwZha532orFacdqDxIao/87p1Ua8PWsgBjjZDH?=
 =?us-ascii?Q?4KVyBNh6/uoni3T8NtQvOr9ww/lClT0eFcYzxdlKjxCDQt/SInAHKx0UYHXJ?=
 =?us-ascii?Q?hz7akHDgGDtiRcOkirfjeGGvdhBNTHo4bf8fsBU1M3u7PsbsVj1gqQbgUJRx?=
 =?us-ascii?Q?usr9ECj3Z82Ps6nJiXnLv5hvqSQgbem/6t52UNiwBZk+ElvR8YP4BkylQs+D?=
 =?us-ascii?Q?AP4muImzE1eq6eFlQH0xVfET973B+cB2bHP/L0jHZ1EEKynGh8mSzDW7+47G?=
 =?us-ascii?Q?9JlBIlfPqPTKxIC60HsxEi/qbUOmbVZQ2QTdZ+mpXRnOcJ2b+WjOnia8JLF5?=
 =?us-ascii?Q?pfA1vqN/3IuBExJP+H1qqKqgd7g9EfiEmXpcOlel26Z5xxNoR61lnv1U3j5e?=
 =?us-ascii?Q?7RT/s13RlZokc4ZPkLookQJsbP6spzfve087nnrYJXmp0Qc6tzKs3Uf5Ilts?=
 =?us-ascii?Q?qrhvtqj8Q6KbT15vGVvXGGnXfJv0NJhaaVw0XhPQDrHCwhYEG/3JZ9zNeIj6?=
 =?us-ascii?Q?coSG8Xeyfh+R7OgvcAzmM4pkIoORRESvAnwgGh3ULXDQTrQqcEexeAMH2Z1T?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Le7HdHiTGTNzf9hIFgFtlMhduNbFX910xM1zTnFgOaTh5iUkDM7jgc5iDLjCOA+Fjyr39M9jbAJJxIksmijss4FbTX+jzzBzZv8K/8voIgj8oOwUJ+PrDjGmI8cdMgSYacbLwY0YiVNSG2o1KL8bGxBeGD9GCONrCakSUtNBhHshkIz9j/U6tI+E5cM9gSPMgALAoPJW6A9xhO3vCt0g93118e+7lPa13xiF4HvveOaSdwqso0szz2qPnw/IjY3y85igoMcPBM5hCYnxXb+rUJqrl8DsKaD/41+0RuPiRJywLQrk+WJMROpQqbWRRQZUiKzQALzli6YsXC2dZySvY10Ni5ZLhxR5oSi1zw28WXfBv0Hwt7/KuhnHzOT0X9iM0aJqGSnyXXIkSBjUlD/zt+JrL/hjVybrxrGpan/R1gKMLzdpV19Y6dErENm92PmiuVpiF0AHaepuxSQjiMjmc/BpGvHgcW6GZsuUO7zaAYWajmLCI/RPCzyMVYtcKeAfMigeXKHE815JfaCn8dXG9faqJr8aGjLNQJieZqEQ6hePNeuetircgsJ6DEJl3FRbop3Sb/j4El6Iyo6MoHOibrFC0Kd1FkTNlSdyzAYBc+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b3d2c5-e3cb-4221-241d-08dccd17b582
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 19:28:09.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1uAElgtWT26aQtusCkZpngdtY3azDYEMGou+5Ei5w4MeTZbyRhU1m0zqJsgZBf8kBFBwV39K4rnU2ZwB0WBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_17,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040147
X-Proofpoint-GUID: KkEHw1o6ZvnYfkAumSxJQsq9zdOD9HMH
X-Proofpoint-ORIG-GUID: KkEHw1o6ZvnYfkAumSxJQsq9zdOD9HMH

* SeongJae Park <sj@kernel.org> [240904 14:53]:
> On Wed, 4 Sep 2024 11:41:28 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 9/4/24 10:29, SeongJae Park wrote:
> > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > tree initialization code skips initialization of the mt_lock.  However,
> > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > problem becomes clear when spinlock debugging is turned on, since it
> > > reports spinlock bad magic bug.
> > > 
> > > Fix the issue by excluding MT_FLAGS_LOCK_EXTERN from the maple tree
> > > initialization flags.  Note that we don't use empty flags to make it
> > > further similar to the usage of mm maple tree, and to be prepared for
> > > possible future changes, as suggested by Liam.
> > > 
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> > > Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> > > Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > > Changes from v1
> > > (https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org)
> > > - Keep lock usage and update the initialization flags (Liam)
> > 
> > Not sure I understand how this is better. Is the resulting rcu warning
> > considered to be irrelevant or a separate problem ?
> 
> I believe it's a separate potential problem (warning) that deserves a look.
> Meanwhile, this patch is fixing an issue that is definitely a bug, so better to
> fix right now, imho.
> 

Whenever you walk the tree, you need to hold the write lock or the rcu
read lock.  I believe that __damon_va_three_regions() needs to have the
rcu_read_lock()/ruc_read_unlock() around the for_each_vma() loop.

I sent a patch to the old thread that I suspect will fix it - but I
don't see the issue so it is hard to say for sure.

Thanks,
Liam

