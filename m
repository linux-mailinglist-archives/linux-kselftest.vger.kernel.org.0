Return-Path: <linux-kselftest+bounces-37259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC1B04175
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F9C7ACAB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F725FA06;
	Mon, 14 Jul 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NExFRIYz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Op9iVkLr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289362580CA;
	Mon, 14 Jul 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502848; cv=fail; b=X5E4DAK3bR4ZhOKmrt+3ieKebmrlhWlPg1P73ZvDhkWzPSVhgTeD6KNuWeqDXvlSu5CkItyBrrc8o37JdzmKoB46EgsbN1eML1r/oGTFv5Jl+gLTq84TCm9okGu1quL8QDYmXdUGzzpBI9d5dnA1vZy+T9MvX7v2OQppY++lPGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502848; c=relaxed/simple;
	bh=nMEn7afEV3XSafpv8mNOEQkL5otc7glCCJVCO9wAUcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBbMnwpHSvFxMQkRdeYKuUOmKpAHQo+TOi4zDevp/rPw2XUDDPLdHqsOJxDooUwOGEwTTm1hGVGz7YBbpmFH0FqbEjJ18KDl7q703K/oiI0sRtdh344g5nN09rhMVBA2eDtUfCmoB8LwHjC4t7et2ipb1+zPy1GmfNmBdXJ6o/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NExFRIYz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Op9iVkLr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6lc019053;
	Mon, 14 Jul 2025 14:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2V2nuN8th7adSgj4Em
	RVacpJYkbve/jmijRMyZLiMbo=; b=NExFRIYzMIh9zoiIcTdp7VF2452/AN1Jb5
	uDwYKHcbeAKblSa7AEX+Q9D3uzsM3OsYKO9n5876FktrCdwK+MR+TcVdEa+gRhg6
	Rmac5OSecEM71UYjy43M12ZLaBdJn8rha8YTj1BZ3n/E5K4fF7itsdt7ct4hDN2g
	JLWkUFZXvJMH9/PNznn3HoRRr0AgvBvfpzMn2WjXe6GUXKFd37BQT57WNx3xMZAL
	UZlzA6dRqobno7CC+SeVdkqTOvFTec+8OZAqovC1F8lOZ7LU279D/7S7sQZDMM6L
	yhIpefx68jVzmb6NUQoNa/EOntvmDL2AWtzUfXqm/eKZNUdfFP2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66v208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:20:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECYr8N029659;
	Mon, 14 Jul 2025 14:20:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58bhy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x02ztLpqqu7s1MGmR1lCNjM5plr3GiigaPdKCMkgGBL0O9vZEND30RUcCh6vHQfnS278sCGBmbrDqBC98NnoEteBgldgbmthaKJcXYtI1PdMRYOEBz9ggLzKwhHZcLBSWey6eBStYS1xcmtVsNOzo2CulHF494hxlvjs8heeEW5wFC4enBb+1mKzbysKOB10Z3zjW+7brvzkc1pRteLH4BkpNNfSpLQZ2YuaM67heDXNBEF8Geeo+oYaojh0uq8PkZiiG/ZWTfX4aH41uXyeIG4TEjq6HkW9YISUEJ2gsd/zZCTiX1+t+CyjPgCd8d+W/sk4fBG6jNfltnn1/NQMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V2nuN8th7adSgj4EmRVacpJYkbve/jmijRMyZLiMbo=;
 b=xUpI/VRizR4Q4sR8/IgbUG0Wm2a0E4KTnup8+LUFJN0jsrml506qDoC8nIwp2clrOnvOJFWcL40XqOu4xT5BYi1nujBmU0z62TbxCNSLuuJRKahYMEHDbaoY2qqGpQze3JjZYL2YMaIfzZCECV7xfven6OniilqLUMfcvO/AdMiaZDj7+tdK/JTjEveaPEdpcf7pa/6O3HkBbKTp1VQM84m72zHCcTVYSJnnEXe/TJPpCfr0v8C7VZ0dUvrZ6wjSE8IpIXACsa2VKyI4OYxHqyIaslWOmXhZdE3wC5UYSStByaHaWMXfhLxnazDQ7LpC8UyZjj6PwgDWBgNm1gvhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V2nuN8th7adSgj4EmRVacpJYkbve/jmijRMyZLiMbo=;
 b=Op9iVkLrvgP1ebjVdJfwP/rz6i3BTneRWhT9gxc0VAK7UtVkS2C5ScyD8twKM6Kq7k+/wtnODUEsNb0O9tBWmrYIKpa6nq4a+BnF9qyJHCrFkBdVr2ojMA2OoCnTaIMbh4qXhNLREz+FNXfRmd/JEbeXhTQ9BvHmT6CNCIUVDMs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 14 Jul
 2025 14:20:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 14:20:11 +0000
Date: Mon, 14 Jul 2025 15:20:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
        Liam Howlett <Liam.Howlett@oracle.com>, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, gkwang <gkwang@linx-info.com>,
        p1ucky0923 <p1ucky0923@gmail.com>, ryncsn <ryncsn@gmail.com>,
        "zijing . zhang" <zijing.zhang@proton.me>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] selftests/mm: refactor common code and improve test
 skipping in guard_region
Message-ID: <1efa2f5a-d93f-439a-9363-ff3a24a5e209@lucifer.local>
References: <20250714130009.14581-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130009.14581-1-lianux.mm@gmail.com>
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: a8888030-3142-4b29-9d76-08ddc2e18acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Iby5pxJ0UtHpZ6kfSS0KXVNkye6UM1oPC1mMoIjIzE7VDl3mbaolzWUCU1E?=
 =?us-ascii?Q?KSUJjqsuudG/a6TU6/LIN6KGmz/uvQPlLKtazm3D0ZyAT0tUgE4lFWzffyHx?=
 =?us-ascii?Q?B7LaSa6YWDMNGIO1Z9lfXXUmfCH/gkxvvsURa8t5FvT5RQKxkc1MtJIwHB2j?=
 =?us-ascii?Q?4WV3VqdOzI0Dp6fYaXHyU0sC2j6TVV/ktXBc0dALeskerYKhGhO5Gcz8bZcQ?=
 =?us-ascii?Q?efuXfqKGUB7u1N1cBMasUzYaHDyC8tWF2jWgc+gUC10nZDlOIA+m/oQBJg6A?=
 =?us-ascii?Q?LKN/jFn3KpMKV7RNZktFAKYjzhLZ8KJQKBbseUeNX381GZwM+RgPzOquqHzb?=
 =?us-ascii?Q?cVihWetELbG55FAYqir5O/Tfzv1ojgdQBcW5YI0o6l6N07DnglWvoDoPk15B?=
 =?us-ascii?Q?Fc+n2KUdLWiTlstuS+HIQCnzq2LYbZLmE6xUeRiKAsfDC5XYQ0YVHh3fpEVC?=
 =?us-ascii?Q?ZO51YcQ1aGk707WchlxMTjkzCxV8PSftm7YIGEqNfMNQNbktplClBBIX16qD?=
 =?us-ascii?Q?5LPVwaxeg3xVffthPb4yVF62/Tk3zFKwdcUvc32Q1P+lKx04dPqdRaaq80mt?=
 =?us-ascii?Q?jpIBSKJlOmXEQE4YR/ffoYGtwPFoEiEHbVxY45zZ1kWfiRcCgkKzd5xlMIoL?=
 =?us-ascii?Q?haTXe7mxxNs7qIgUfeiOqYp/aeHrZJFXcgVsgQrcX6QgLZoyEYDCsSCe3igt?=
 =?us-ascii?Q?M5U8YWAYSzf5k95SFtKac2HHsEGGwpfU8E/IvpmK6v3t2bS5igDzr/6VBGCK?=
 =?us-ascii?Q?2Xgv9pbdxMkmj7LVQQee6rErMDsuByfsGrggWVMMgIFUuZ8YrVTkB4KtMk9V?=
 =?us-ascii?Q?5NgDptC+zKW3wh9HykGBhpdrNxQpqT7tEzuhKZ0xOszPPOsT9txSOYWHOZcd?=
 =?us-ascii?Q?oPtDUE2S7yXbKThphGjT+7o7tg9aaK1TzOazGcF3SpS3Re4L+a9L1URGFtLP?=
 =?us-ascii?Q?ZKTD96WflLbeocuN6xEi4j4Mx9yhmcGvIFo6vFFisTUu/sZqcLQm4LtP2Znk?=
 =?us-ascii?Q?Go+NyZ2dbO/r5TYtaMtEbxBsOftf5bNlJT/F9GfrK/bjDuMWMQHOeAXZupcN?=
 =?us-ascii?Q?Xq6b9vZbyv3xlCTrEt/GEzVISBn1ioSchWe857+XukedeO3jcKoHUG5MgUk0?=
 =?us-ascii?Q?uRMz739OEr7n5UJgQNSam3bM8KhsJbpxJ7xDQpJpIv7XGwmXrWtzp/FrGv5C?=
 =?us-ascii?Q?csIGzLrsEk6a9R7DOd3BZVcUY83llPq5WBXhgfy8RpTBni1kaCKYE92sfmPz?=
 =?us-ascii?Q?FFgZdZ8W2Jpp+LXRsg3HiDQwGRQ5LZXJkvpVp0XtuF292kW7qMVBT7YENPJf?=
 =?us-ascii?Q?6tGcWwK+kuKvOKrZdJIEF6Bqy8ZYkm+oWxga8k7nBDu0aJ0+Y3l6x98MXSlw?=
 =?us-ascii?Q?1vwMV2AIXObOwx2O2ZtVcYVtZlbIsx5VjSolq5tppvqu42Vpoa9cPhBy2vS+?=
 =?us-ascii?Q?cnXgHe786PE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nE/Tvdv7s9M75b8a5k0t3kFkNooT635ABXbzJdl9rmOa2cXyQRQ8HxOQMP0E?=
 =?us-ascii?Q?RHfgKnfoVTmK+XmldZnVoJARULkXEbLCzCH7dNbh0s1ILRk3HURXazXyhF8s?=
 =?us-ascii?Q?9MaAvnVCpoUE8IDql+6gFTrLuO6rPI7yt0vZ7EvK/I0upEaa4L8Rap7GxQa4?=
 =?us-ascii?Q?TUwGg3VPAjjC1Wa2b3IBFBDLdsl2+ZSe0dfd2uuc84cgsux9nLKQKc0RrnqK?=
 =?us-ascii?Q?jPbSHBM2uhhCoSQgM735JlO+1BLXrHqjlz6ySeTq0VKW/vtb0JMn/x8gEMCK?=
 =?us-ascii?Q?XM2N4/3JiEVkGVgFy2l6Q0jeJS3oM2Kek7SErssRiAskf8QLNiTQeTNv9Xnq?=
 =?us-ascii?Q?dsJD/T/Fj9GQl4vrMakYXuAlBK/MAKeM0bOFyWxsCKbRncxwkUqQTHNxLP4p?=
 =?us-ascii?Q?ghnq7BQ8vVZ/OcU0YrAHv1uQRxcm8eZVd+Fw09tOqVwAFz9848S61v4zpzy5?=
 =?us-ascii?Q?5ucwqSZ5ZZ+ya4PEMdOP0+5liSprhElE6QMKiijohT8vKxAv+0dG8/WdDowQ?=
 =?us-ascii?Q?j8fDd/oYLlfDyt8jZAq2h2qyRjfJSZcB8eZxDpv50KONKx3Kju8VUJaBOwGJ?=
 =?us-ascii?Q?HQ7w06wOXQIr6HXdQNrC1nSq48WFvCFJoiw6pgR1uEuVrYGrpyn0bC+Ps/Gz?=
 =?us-ascii?Q?m7MQ05Vzrc3joeYubgbKPVbL7i069gwKIzVs+rziCrdup+hyDbFbdIAJIxHa?=
 =?us-ascii?Q?oL11VfkvRk3jL2plGZCEOFEljPMSl/S0kwAAC47Hi43LmVLra7bfQd2SjA9D?=
 =?us-ascii?Q?irsXKvz9TfTqN9bw1RRscMMnDmN/onJZiVOivFXHlXWP/oQxuNSzt19RR4Hq?=
 =?us-ascii?Q?1VQkC9rwd0oNLruwblcrWYTsjamRUaUq6ZWK8RAeuHe2gj5nr8C4mof4HzQP?=
 =?us-ascii?Q?ZjZIiZZyoju64v95WM8eGHq/+K+4WOekOoQz58vNiJiYJmWwM0BOgTMuLBor?=
 =?us-ascii?Q?n+soeVsjUEYcStb7YjFI0QK7XTjUJ6F2WiMwuUIHHI3D888Qap2YG3YMiXvc?=
 =?us-ascii?Q?qkziAo/1ZIwn6+A7XM5v8gWeG5NUTL2U+ZiTzEOnVZ9UlVKeAzRzY9qrhGxM?=
 =?us-ascii?Q?dizKmLlIJaERNXMaxCzPBJicDgjA8fpXur5+8tUnZl5UAczVARNQPyk9JyMR?=
 =?us-ascii?Q?yqYleMuGmUidqZDp++HA4rZqiom8VK4YHFdo2v4Nok2R/er5ueq4SO5hU8iw?=
 =?us-ascii?Q?3Vy8+ToXMy+BuEaYrHcvhdgkniEQGsK1qRuQb0OQcJHjZA+SLkiqk+48b+oO?=
 =?us-ascii?Q?HsQ5eMOIi/zbP4wcRK+pkJ8ctl+kmq0xcHCKDnutHh8gRRQyociNr/obvlSR?=
 =?us-ascii?Q?Japvrbhqf2sQxIwZcd68h9rvMfrR9d/22+cJIKEDl4Dbx+X+rvd3qoOrbSf/?=
 =?us-ascii?Q?bAT2adacgXhwUtBd1F7DeFBL7TzG1Cudwk5i9OKPsJ0UlEO0wtOrHLKNYLm+?=
 =?us-ascii?Q?W3DKzoAC2HET6kVMv9SPMEVHHR3GhFV58YmJkqbLFeGBF326z6yKOGfphy7s?=
 =?us-ascii?Q?oy+TeieFO8RREMGZ1yqr1pGDxli+NjDI68z8UFhoAefwOphbDproq143Ccz9?=
 =?us-ascii?Q?z+ChjmI/AIAy10ecOtqxS2JrK8fEFk0UPq+x/iIW95ft/QOnEET3iFmDQlcU?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oIIv3rOsiQQKjoT1efPsLSw48k9fHnJB0Hd3jFhbU+CVh2Q5Dr3HH7uoai5/jFGHIf//5pDdbObtSowfBXaC3Qvq10LZv/KoFFAI4hznPU3wBaeqDoF1+BRysUVV9NzqDMCSFHjS1ONblDD1aCa9n7UNtx3s/SO+4ocsHSX76Dy1pE0R1yK+N/jgOrNpG7wQ7kSrCiTAotLK3YJdAnh4Yz81NWjD+JH3T5aS+GFNbFwx2AFSN8Qy2R1BQctjXx5WyUQZ4ruVouC7YBTPvnguTsVpe0ttdwY/mSTYvIpAHCjoq6pI3xFP0RwKbYxi5NMB/tB2jh4RxqXY6DqN0/DCB6CHNIIBDEbkn4Jse1P248qDhR2C9pUEJRepEYk6fEwmhhgZv3a0AvhOlU2YigPDdgNTh6kc1NnQQ6sET+fBWKAQNKY9lgjnIeZ8QgWOII7j9a3VHKjv/E0dHgBlrvZn7JEFU4/f7PcWI1VX46Qho64BZM8kEEAuaQNjLeVDZQeHx+CvU4DiVgxWOMgw33UCsEsFWGII0FlaCR5CnfxpuvemIq88wIYpf9BK8s8xA+dfS7usBwN9oEHqIVv2+Z0A6XO7xerJkNXpLnINjDFJ5cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8888030-3142-4b29-9d76-08ddc2e18acb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:20:10.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+DYtSrRBcJ8lhzisBE+ZmtP5P2OhBuOP5F3e1p+FtsQuJS5zPke5FWH8ARVxL6jU+6/cax49abjvkBTSdL3/xeje0EFJJxXyJcQrp1w63I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140084
X-Proofpoint-ORIG-GUID: QZktHYayhZxpOf5gwwhmw9rUPTMNTuV2
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=6875121f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=oMiQD3CW9Wv3RCB_-AgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NCBTYWx0ZWRfX9rK47uDbqQBj L2vz9GmGSN4XjjJOzlX0/PU5xrdzX8551TOFIrKsxX/7Zi0GTgmv+TGH+4FC03hglC5LS2CYpr9 FjqhRmIekouNavgwVCZGhmztBuBaLq+4E/71hbx8T68WAv9h2Ol5WOmNeZnuLNzN+bbLoe6hnFQ
 P2p4t2bPfUQ2iFKEVKnmSNC9SF9iKHSF5Sf/WZ2aj+4dKBSETanvKsk0gZHQ9ncqa+Dbqi3I9au 26oG6JY0/Nt4DyE9j3sI2CuLSfyozRPpZQcX4bJ5so0TEx9AicdZj3WfySVDqW/BFn+cZCv924K e+Ods6ULjqoR8rEEC6uvKCXE3mlYTFBWtR4XZYsPDfY1r152h6Bz8L3AQGEn1mFZ1Km5cbFtun6
 ZUbZc9ztTUzrfSxtLjBVKJm0RCWJGYSSCHWAZHQDxC/p9hYyzvA78jpVBXQV6p4odo7Kp9HG
X-Proofpoint-GUID: QZktHYayhZxpOf5gwwhmw9rUPTMNTuV2

On Mon, Jul 14, 2025 at 09:00:09PM +0800, wang lian wrote:
> Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
> `vm_util.h` header to promote code reuse.
>
> In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
> to ensure only the current test is skipped on permission failure, instead
> of terminating the entire test binary.
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/guard-regions.c | 9 +--------
>  tools/testing/selftests/mm/vm_util.h       | 7 +++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 93af3d3760f9..b0d42eb04e3a 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -35,13 +35,6 @@
>  static volatile sig_atomic_t signal_jump_set;
>  static sigjmp_buf signal_jmp_buf;
>
> -/*
> - * Ignore the checkpatch warning, we must read from x but don't want to do
> - * anything with it in order to trigger a read page fault. We therefore must use
> - * volatile to stop the compiler from optimising this away.
> - */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> -
>  /*
>   * How is the test backing the mapping being tested?
>   */
> @@ -582,7 +575,7 @@ TEST_F(guard_regions, process_madvise)
>
>  	/* OK we don't have permission to do this, skip. */
>  	if (count == -1 && errno == EPERM)
> -		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
> +		SKIP(return, "No process_madvise() permissions, try running as root.\n");

Lol oops! :P yes thi is better.

>
>  	/* Returns the number of bytes advised. */
>  	ASSERT_EQ(count, 6 * page_size);
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 2b154c287591..c20298ae98ea 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -18,6 +18,13 @@
>  #define PM_SWAP                       BIT_ULL(62)
>  #define PM_PRESENT                    BIT_ULL(63)
>
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to do
> + * anything with it in order to trigger a read page fault. We therefore must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +

Cool makes sense to share this.

If this contradicts previous review, take this review to be the correct one
:P

>  extern unsigned int __page_size;
>  extern unsigned int __page_shift;
>
> --
> 2.43.0
>

