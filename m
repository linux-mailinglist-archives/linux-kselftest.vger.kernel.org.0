Return-Path: <linux-kselftest+bounces-37260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5DCB04178
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6521A60D0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29EC256C9C;
	Mon, 14 Jul 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QHZhcP26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XzMLKnLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6A19ABC6;
	Mon, 14 Jul 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502905; cv=fail; b=ZpAnCmy7CR5GhkOnM0sqiNDwYTXS02F37P5UxCzDNwdWZeRgkHr+PAYlKs9VR6wCYJptoTPv9VtzZaeQwHs0+bYStuYuhwMWHxV7PHrEFY2eRsv906WXjss/j7Dn95CpdtRkbvmFsyQdUsBrHOQPfOaLFeoVxOUX74YCdsyQiNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502905; c=relaxed/simple;
	bh=CJiu68f++YzALXDQ3W/BRoEpncjhy0aETrzfTAo72Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heKH40eB+JDAEPkT24MFwI9dveeOHvlxUeFwH0TYq6JcExsF7Ov0YoYNX9UZIwtnGwN8mOv429RMMugiEXo3SOgJ0mov86nLFbBsb57iIY2FXCpgg7BFTzDL/Cbnw2FxUQqibyI+jj+oYvaDssa9e26EKLSGD+r2vR0aQDGrjuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QHZhcP26; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XzMLKnLi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3Q0018922;
	Mon, 14 Jul 2025 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wSpNiNqhMMvMxr7r3q
	1L1x0qGoug7sD2yIE/rg7JJSg=; b=QHZhcP263OdytAYTWBKtYc4Ocxq/NcvZom
	ag6s84Dsk+4cws3lVyheHnskjk0FoR4NnBd8C+8yOSIx2Qg19/aJdahjzq9siRuM
	b8xgRJpVVg9k+gvYAKLRcOFiEKGkRL8FoIhH5iq4JFKviaTKAmafdSMsa5MFcxUn
	MixEM2keqHv7SYDFhSweb7sprWWMS9eyAwdbepS0volliz64EDuW2nkeBVEOtmxN
	e3+bnAEMrSqBqb8s9kTX8sXD8N3G+YESKkz9UpHBOOnmRlPobKYX71BRGSPMt2de
	mOOihzz+5xKqj2PlpLvZEWxN2TpyE4M1MiQE+vpS2nxinY8lRIIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1av7ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:21:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDiZHQ040541;
	Mon, 14 Jul 2025 14:21:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58ktc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY5v6NycKTV6LDQOsDXf+mu8wN8YKuS5W4e29rfAow5wP9pCbobcm056n6gi1mD/1Q9lhW7f8a2XBtgKzjmuxHKdyQ1qE/+qGch6VbaZi1ym9oyZEhHY87SGhhlbOA4rBRx1gT2AIHyumkR2y46P2GjZ32ArIsiCGHSwUgG3nLbwMaTte0/SA5rByoKwwc4FmnQabvVb2QB4/nv+0ZLYaheiIkHzRpukoHAycvalPrHQZ/XWEHGIstPbneZDmDJNgVxsPE9io1oNj/xfX6VufEFAx6mal9pebkKohCKQgd9wi8jLRenOEAQmevE2b4lx+xDu9MpLRlJorafslsV1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSpNiNqhMMvMxr7r3q1L1x0qGoug7sD2yIE/rg7JJSg=;
 b=Sc7qopiO58+dftlgZ2LmmFgMZ6b5u8dby9NlDnvfkLicGf+DuZvL5sUp+zKOPsrm00+f4XSXujPmvN07WdZtyLDLtCqFSrPn1URXEGbnztvfZ2bm5opiiQowE5LWqZj0SCsRAIBhnrU3LE5BxI+MSkkvzwsBmH4H10fG5Pehu516/vVIU+z0/Rdeht3wgRrztpM/3uSUviCERYNiurxRb6x00NML+nhHs+0JQRTTSHaiB2sCzDlG2vNfftvNEuqQ+a9g9rrDRDkUpPtoxbH8Cov4LeeunonUsE6HuhnghkQ9SrVtx5Dy6fQELJmV+iMsNCyUcZiMp7y4cnlLqNfBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSpNiNqhMMvMxr7r3q1L1x0qGoug7sD2yIE/rg7JJSg=;
 b=XzMLKnLiE0UD4EoRWxr1MqnASnDvOkJZlJOn2jiHwMvb5HaUoyyQEZ+9AW5+wsYyHfn0JPHxFWS/rvet6CBAeLEiHcQAYPQGpSzFjYHprdv5HEF6HrmY9/1Hyke9Ag7U5x1cWtuEPRW0Ot2DV9DEShIV7KffoDNWjTHCWNnwzEY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:21:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 14:21:07 +0000
Date: Mon, 14 Jul 2025 15:21:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, wang lian <lianux.mm@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, Liam Howlett <Liam.Howlett@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        gkwang <gkwang@linx-info.com>, p1ucky0923 <p1ucky0923@gmail.com>,
        ryncsn <ryncsn@gmail.com>, "zijing . zhang" <zijing.zhang@proton.me>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] selftests/mm: refactor common code and improve test
 skipping in guard_region
Message-ID: <5e2b88e0-84ef-4870-b472-bd2aa7e88c78@lucifer.local>
References: <20250714130009.14581-1-lianux.mm@gmail.com>
 <a3457ab8-8bb7-4a43-913e-2eb73149ff20@sirena.org.uk>
 <4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com>
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: db90a59b-1c8e-4b7f-6417-08ddc2e1ac65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QiiK2qxgIAHuzbinfiws8uzjt8sCRQ25uKJc1zL3GHSVcf+qh+9nVKGgqF2z?=
 =?us-ascii?Q?bq8uqS3JOxQ9HSIt3M/i9ouRpOagBWrq1E3x4yvJV+FdIdjrdDbvtYDjbjBB?=
 =?us-ascii?Q?uFZQFlST6xRXEqrUvoYYsb5vh0irMENoYt0zKFAmyim9NwSyXB/qsTB1av1X?=
 =?us-ascii?Q?Ffgooy+hEE/2nBa9H4w+3I/RShGJjD3Z0TBYvaJuAPb4gC8p1liqBGH4+CUx?=
 =?us-ascii?Q?KvdBvvCxQf9puO7xRKi7sOFUSS8Qfxc3hf3DM42Qld/4N1RY41M+iVym/J9L?=
 =?us-ascii?Q?x4s7KpxIQO4lkghKZ+Wl+4xwNmO7iQg8V4lxmTilCC3T88TgpE8RlugK17X6?=
 =?us-ascii?Q?ocUuTiCxCxEAzgTDePYYfe5UNlrSdoPwZTI6UG/X8FzOVEtxdkGQoHB41kxL?=
 =?us-ascii?Q?Wux9TzvNetkXeQP7h0pdn41jyCU3wfMLp6v/qkeB1ifgUn3JNoikJxwtPC+M?=
 =?us-ascii?Q?yxnfD2DdUjyW4rO/xLY4D2DKvjwcyyJ/y5dOjzoFnqxzI7wrutsq4wBLc1gD?=
 =?us-ascii?Q?TfjLAIme3KB+n3XVZSCLVF7tvsI/4808EFQpRL93L5IHG/QMEBPxmoYXc+ea?=
 =?us-ascii?Q?TW8+hoaxx8PCYsoAzAWVQSOjkUzwbL5pD2k+78xrv2Y/hcIYel/Xn7sm2IaX?=
 =?us-ascii?Q?Km3Te4+DaZvqteKwrJ3/A8nZ23mmALW9w94eSBaVsq86mVO/LBcy9Su3d+dv?=
 =?us-ascii?Q?dkXDRgm9RXaI/wa/KwxiIY6qsWnfEOKzY4dCunNDzTXBo7qthYa7w6QfnDOA?=
 =?us-ascii?Q?V7Mq9xVjDCj+5RM/WRfbK82yjlGt7uecd0ryX3p1X3QTKnHUPdADsVTXWZtc?=
 =?us-ascii?Q?4klgdJ6ZOJfxPupTO5lGObSO6brXLzBxmkcqTHGCwiAzj61T3XPq4FcqShMm?=
 =?us-ascii?Q?C79kZQ0UaHHOQuxNynk8FBgVXCg3UsSoKcXdu2LNU5aEB2jL8HmFj34XpLvK?=
 =?us-ascii?Q?0vluEAMz3/IOzD89cXeJlZK0ksTMQu6LnNVNse72VdHaP7GjpATJImyWVDi+?=
 =?us-ascii?Q?Anu10BuY9Z/XEIizA4KR8/GpLuqN2w1U0dtvIdL8u1cjnN/vAtloiiAzdSNG?=
 =?us-ascii?Q?IrlvszxI/7KmX+NppQ7fxB3RnwwPMlX5ezZopNiUiHhYokXLHH87AOB7ZG+s?=
 =?us-ascii?Q?4HETxrzxClbqLm31onIT/m+fHOJX7IurUZOBJdzMGhjeAUeIM0vykSke9TAp?=
 =?us-ascii?Q?nvpDE2nY7T8GWp+GCvDUPplJ41v9eOZqP3yGQVI0iWUtikWPCuz44WbdJPFb?=
 =?us-ascii?Q?yx7Ql1PesXrOchbu0rW0zNNlc/RL95x+N3A13RKM+rFd4NDAoP9ICzWC8JXB?=
 =?us-ascii?Q?A+6cBQ5xdglt/ZwKA57IxXc6ZDWmFEvGJ+EOtXAhEpNDrAjhGZ6Vi6tbhG9M?=
 =?us-ascii?Q?I4XsEzP0Y/xaMAK7kdsW3RWZvSt9jcrTQtul3TUPqN2eDNl48w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T0ueMt66mI/ZCBqk2qmTCPpoUwXOZgjHQdB08tLr1EHHBh+tBdh2kRbvSXBh?=
 =?us-ascii?Q?Cx+CqEen+gKM4J8cRfnAvghM1fWpLg0fquJzoJaUVMDLf+JAQc9EVeGuh0Uo?=
 =?us-ascii?Q?hXsB9XO5ZRVRmtqZHUXTgYP+yJuuSEvV0nYywhYOnUhDdVn1U0Mach9vHZAj?=
 =?us-ascii?Q?tjM7m5Hmzxt453cwZazcU6cm67izjZb3m0GrtN+pM4a0AvJLFHP89ub5NvWd?=
 =?us-ascii?Q?MNt3i+LTEwE1EJAmczwynL1sKRmhlUfil38HmM4Ah84aiLBr4YaAqEa6M4va?=
 =?us-ascii?Q?co2vGSKy9TSsa1u9gy4fhon0xm+1PR4ZEMEIlw0dT/2EhgEZIKXLx6uAV+aW?=
 =?us-ascii?Q?GifdOV+iYFh0VYFmGZfgc/LrjEtms3qd8BMTrOY0jWmYv/b+hu3mviLHEBFr?=
 =?us-ascii?Q?n+HVAtphwkjPdErlk36J2gQOfBdKyKm0FtHNKfVKXLVM4GuXQMKtkcvQut7i?=
 =?us-ascii?Q?9jpPdsFeJg0xsdfpiTzs9+sq+yfTLOrska80oKw/AOEEVtXiCa64aewods+A?=
 =?us-ascii?Q?4vW54Ao4O5JatU1CvZmz+XI5QuUaaB3bw+i5wBiKGTmvctL7i9KCIhE8L7ME?=
 =?us-ascii?Q?PeQ41a78YAgs0KaN1s4xYdFDFzoai4X5H7xx/hDxMI8mJKR+/xN2WC4xECG7?=
 =?us-ascii?Q?oPvPdeJcerlT4rbU7jBrtfJJ4RriEvY+hXLjiMhMzvnDhBeluO4TLIslfaVa?=
 =?us-ascii?Q?Aah+G9W3myU/bJ7fGf34lhhf/xXrmkZFe+4MamgfZh9EIn2enOa2FY+QR29X?=
 =?us-ascii?Q?/UzoSxV/rJMk600CyqVvxrveldyS/7ra7C9SS4GG3D/KsG8ccOwpQXUwODRo?=
 =?us-ascii?Q?6DtAg1l1tP6ckpW951+6WRpoxXC+sXlfEDHivq8IyR04SSyNns7prdOQGIJ3?=
 =?us-ascii?Q?GEzXuR8yZo0rs/NM1sjzkLmGst22TexsJj7ted9By0Sx+8+9RtzDF18+SHCm?=
 =?us-ascii?Q?57JXcTxFV9I3KG/bLCWDEz8dIF4k4RwLuNAWB38LiwBP/mg63aKCaFqjLrgs?=
 =?us-ascii?Q?FMETxN2v2r12+Jkz2yPKZr+jSC23RKztNxYMGQ4kgVloStcWLbNE3FuGUlfb?=
 =?us-ascii?Q?bw1nDDczxFDsav2g+YnzTNEoHGUNcpA7MbkFj+7ztvosbqEIQ+mZc7wUD+15?=
 =?us-ascii?Q?IJTsqwNx6GYva7e34uttIozXYUyo5zx+xyVQ1/OL6IANDRmyHWgZcLd91A+M?=
 =?us-ascii?Q?cZC6x93PJtWT7AhM5JD/DPUBSp16doXjHW0pm7yH7cZdOYV3zcvXoBnINypT?=
 =?us-ascii?Q?Nymgjhsy8jJ+/p6ItbkJNwShGgc+MeG1LRVeqEg2lWbtU3LTbLWa3Kkx3RoD?=
 =?us-ascii?Q?6+6G+qxTCaUZYP/6XbEvD7T73buXCCAsh3ICSzkEUAI/4LowZqR+JcBMoIUH?=
 =?us-ascii?Q?Hv15T6rcM9KEGqBUUjUTBLSRiHxaSjMzm0XTr/wjvXxoWBpyBjZuJmqTminD?=
 =?us-ascii?Q?UmwCGeQdVOlvhCPo7SXB8CxfPdz/szvtzaL5GWgpUzAhXho8m/Xt3kfxl76C?=
 =?us-ascii?Q?fDI7qXHNP8b+mh6zPLD3jr8lbX73PnQ4mA8c1qoX2uKrirWD38DmfQPwhHcY?=
 =?us-ascii?Q?cXOV13xCAkc4y59M7+xHtpd31WLk021rZtDBeoG1HpfqoA+pMh/3SPMrTAcZ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GxDMgcxQtiXAMyMGgXwbvtNA4VUCfjhdDUqmRQCXRpOelduDRvTmtWWWKqjlKE98y2Bbf3ZkHFswEFGg7uaBN3uAE7w/uf5oayQ91K4DRHitj3VON1trtlVLNF2sTIUloMZNeA3svP7TM2Uhw7UJpGrIInkKl+oTtNvZ+8fSb3euZxbec11ifyPmxlbLaUtQ6iF8tZp64PueRwr7IAuzPKptZ/h5BH+x4tl8jxpnJWoXqsx0YxnSHK8hVcN0o9B8p/3UbG1X5f/GrclZ/B1HRRphhMeTVB7nWaJllI1FxY2QxkAFrcgAQWXOXRMu224s8qP/m2X3dyDwyeLPg0aRpZwmHfP3Oh/zAoiUYw5EGTRju6778tW/lMQvgPp0tOuesjGqd+LDmgXXT66HYsS2YzMdxpyXIv3YFk43i4yKw0S7qylEArRZctSIxyxjox1gnz4ZKNFgNuFAkxB0ySEtmqF1hVAJ05naOgF0HDdtxonvIUz5Y7hdTqgu4hUCYLLoCqPuRo65fQefbMZrc8w/bgfnAqJs4xK+OXmaZUvD46Jur+S907mRrjbdf24+32/Q4Hfb38x/zTpkBfc6EyO/L5B19GqGze0/5mfxSBNORfY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db90a59b-1c8e-4b7f-6417-08ddc2e1ac65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:21:07.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrrFeDmkLErTP88Rz1BA+d7dI7f+8h1h2pN1tjmflkCrPZoZB1yCP5mHzBTZYZYxfFVHN8QKJEBisnv6E5dQW313Vq/KYTNzGmVh2rNoEX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NCBTYWx0ZWRfX8C5AnOb13WJx +sq5Io1idmvSuFtb4z4QntCvfBrat1XhiJ85MOogIu7WZhfOOS838L+iauniLLvKO2Qgn1gY44S q++ippoM3f1L4LJ3yxOH3CijqGh+/1lBkOGu2nZUO4LnHo4UoVHsEzAvMiDzSQp2KWjRUNfZ3cz
 CrENjHlEb+538dJAitbJ2MOELp8sohDnZEGOXlD3aEsmbsH7C+t3XeSLKdIjFsZkjdMgh1Fflps x7EAgHT5uzjhOLSSZEHfmQczUFZH089s+AFB+STG9d/+S30apc9jOBDno8RFE2YlA9uqHgrIOQe 1zOHBaBkQNJYx5jPpUpwrkOaH6wpLqRg77CaYDOh/Cvn6v3xLsAYQvwWWsrZwxyuwgIZ08yXlB1
 in1em+/Snj/uPiAEGnKyRNzH0Eg5ylYcAUHD4AA/1z9zMsbJXqrF/3iQyGoX6e5tDV1Kg4dr
X-Proofpoint-GUID: W4u7ty0vXP9o0JE0u6yRSibDwqkzmLv8
X-Proofpoint-ORIG-GUID: W4u7ty0vXP9o0JE0u6yRSibDwqkzmLv8
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68751257 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1gqbzPxKHkSD9P8evAEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Mon, Jul 14, 2025 at 03:44:28PM +0200, David Hildenbrand wrote:
> On 14.07.25 15:39, Mark Brown wrote:
> > On Mon, Jul 14, 2025 at 09:00:09PM +0800, wang lian wrote:
> >
> > > Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
> > > `vm_util.h` header to promote code reuse.
> > >
> > > In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
> > > to ensure only the current test is skipped on permission failure, instead
> > > of terminating the entire test binary.
> >
> > These two changes look fine but they're not really related so should be
> > separate patches.  Looking briefly at guard-regions.c I see a bunch more
> > use of ksft_exit_ functions that ought to be fixed as well, but your fix
> > is good.
>
> The FORCE_READ() could be factored out separately, and as part of the same
> patch, replace the "asm volatile("" : "+r" (XXX));" usage in
>
> * cow.c
> * hugetlb-madvise.c
> * migration.c
> * pagemap_ioctl.c
> * split_huge_page_test.c

Wang - Feel free to put my Reviewed-by in any such series assuming you do a
straight up replace.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

