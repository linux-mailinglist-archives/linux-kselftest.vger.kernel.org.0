Return-Path: <linux-kselftest+bounces-23994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699AA0431D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86A13A2316
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694286330;
	Tue,  7 Jan 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SfZFTf2o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fxoro5C1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FF2C190
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261328; cv=fail; b=eqo2rP+C1DNJd022R4PJGgppCnJBrt+4ZCrGtpOPlNFW1Og8uuVzrJlC/X9gXm0mjsiY8VAgky0zQBMq8eONIyLmfeia1N9BbeDPgMpY32MsGRjg8R3LKwx21KlpfGg0wfzf8lbm5xDdp2Bmf9t9Yc/ikCCqxDNpmKPOfj3aGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261328; c=relaxed/simple;
	bh=Aa9HV2tw3oKWObb5McxiZ6friQDzk6TGgcUKjM83IYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R2W4FlauWl4EWHWvEjIoI2VPndGSoBp+1QBPUFAoZVaUyEljm8x/JRG6gZtD1EAYJYctuVDfx8YAJFxOolswHRM/vfj8yxY3EEj/jLJsObZnGZ5kW/dbmbmGcKGpXjLFGjZyFu89jiyLTeRrWSDMA31shBUv4/l/K18ISYXe1oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SfZFTf2o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fxoro5C1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507DmrWO013195;
	Tue, 7 Jan 2025 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=d/SPpRR1SOD9ZP2g59
	0kDi/Hnpj41puN7X0U8IybF1c=; b=SfZFTf2oc76m40GhBNwJpR14uwuamO+4Wi
	hmivbE92YoZAICEJDYN0mggMlpyaoI9fFbNAU03+/rGp5SFZiGkZmPdOMzeDVzPn
	muBPjIDyjzI6LJCqFNgCWrbffaeLUhIKvkZwPYaeFWuHsFmM6x9Sp1t52WaGBpa6
	bdkA51yIJa7ob6YPGyaGzqWdpoAaQoK2gda/c6KRU6NJ8ulIThXPoFoB6PSL5Wmm
	F+ZRy6T06zO1dNIAE65Th5xnZOrf8SdMJJ8IYh+k2qv0rn+IVG+BPcPjwALvyFeG
	hJVMwhbqR8iQppFwVU8voZIEp7Q8LvqfJH5A+TDYZbiYrmc0xNRg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvv94k3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 14:48:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 507Dh7Hn011115;
	Tue, 7 Jan 2025 14:48:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue8c8bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 14:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7BA5C/lJiOOY0HtEVCrRUgO7zGCw4e1w7QY5Prj95+AwQdb5esi6mms6B30N6ipo5PRmDh3YHdw4IfpX8pDrjd7lICpU3nJiApmmD2qGloTNdaNPb65qhUKZ6jLxqXoUqMBSHbwD9htiP3anwg57pNK7jDULFXkHnV/op7oRh3C1NbfmI+Bh5by2LRBtuki7s3tuSrxISBa5NhM7Px+PgRmAgCKBLUMpwQmqtU3eFwBhbvSOz5ytboEGZDiHR/wg7PB+uiiATzNHerTsgIXsByd5zKzI8ViU46IGBuuKX7vx0fYNHAu2kcs9pXdDOZW1m6MjJ2vADIaaDfmErtVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/SPpRR1SOD9ZP2g590kDi/Hnpj41puN7X0U8IybF1c=;
 b=dFqfNBVxR7VdNozBo/TrKNJGCxcP8MMa06BZraEO5/ZDJ1Vr8DIsmdLoSBYoYJLBOwf2vLY124pjweTyb7c2INC5hdwvnSA6QNpr7B/cyTOheCq2nPx7Wm/pWuLBlQCuvXPluW4KpbJas5ST5tpFqu1E+4NMNS7tj2s0EN4+DRmkD6ChezUJthi+PO5qCf7o7KARbFh5Bo0a/Pr3Y8nMgrXYO4UVAqjkf17j5mtsW9LfI4XZGnnzRtAGLKHDhexN1Zhk3r008UeYLv5p1+mT1CU47e0kcaHzHONsQ0QrFqz3ZaJd5C+l8BzvqN8yHb/oy32uHx4Gy2NBqKsYjCDc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/SPpRR1SOD9ZP2g590kDi/Hnpj41puN7X0U8IybF1c=;
 b=Fxoro5C1nzIyXxvr/o5QZQa++6qWpXj7f1mItysubHgKDYTVyecERASPNsNTxY0h95Vxe6P3xgXKbRCS3uXZRbbb0kkKXonoGeu7lMmsvAUDQvhFn4DExOLQIk0yKVKsjJfb9iWh6YNKxyvFa1CruXYs/Yb12OByaGK7mgM3WDQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB8141.namprd10.prod.outlook.com (2603:10b6:208:4f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:48:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 14:48:25 +0000
Date: Tue, 7 Jan 2025 14:48:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] selftests/mm: static process_madvise() wrapper for
 guard-pages
Message-ID: <fcb6cf10-7789-4eee-bba1-55a2c131d935@lucifer.local>
References: <20250107142937.1870478-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107142937.1870478-1-ryan.roberts@arm.com>
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 440e6d5f-09f2-4129-adf6-08dd2f2a56de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mBwMwXal7m1R7wwRfBF3S3j0z/+NmwAA7l/VAeOt6nss6oIc9pbzFQ7HY1P?=
 =?us-ascii?Q?WHb8BRAgNMWZE8ebRBgNGUSrDQgdte72I2pQjiuide4yi4YjIr5+cvzEr4Gs?=
 =?us-ascii?Q?lV5bfJ0s6uYcQp8ZTSc/Kj5GAV64Mj0yun6TcZ8eom2vVCkM9JpvUUh1ht0w?=
 =?us-ascii?Q?/HxcNNML58hTfgLO8WhkOs8GkEAMrTT0UvaxRoyN8tg+sRSPV1lAoJOaBceN?=
 =?us-ascii?Q?dCn0F+mSMWfXRPmmyS+YSsuRuip4xgoKV0oZUNj/wOmGc6BLd8DiyWmVFgiK?=
 =?us-ascii?Q?nhIADYFaAaDrm7SyYgB4jlbd/QfxkxpEqRz3Q55ydVfjGozzoDNSyWWqGPng?=
 =?us-ascii?Q?dCsMTR4VkSTmXwV/Aetf2Y8LtOrDBvRICVN9CiJXkizbawIi7KhMuvY44mYl?=
 =?us-ascii?Q?s8U5TogSdUJSx1AwbEdspGLNPIl6MPzNmbhDwP6/iB9FsO7AjUowCoc0vDLQ?=
 =?us-ascii?Q?5cc/CnT77ci3LC/8ROdJxegEotZ1mfA1OryGC39SIuPD5et29ap/rWpihMGK?=
 =?us-ascii?Q?JGFqOtP49iq7mLIC2hDRXHIH4JzdOZjaSNCrIgBViboC+4dYthotgGoIYVBF?=
 =?us-ascii?Q?9cs7gWTpH3C8UOEM5jKqbjqT2FkChxJV2F52dBut9CsnOGAr6GSObfrNsAN0?=
 =?us-ascii?Q?e5/36jHPRwL9C9H/S0SqTqmCZrl3OBePD0n5gxovGNBaQeD8sMCB+QeGQ9PF?=
 =?us-ascii?Q?OTQ+sT0EMqf3ClFYVo3Iq7I2DA8LRSnfgbnK0k4Y4b7NJSN8ogbMugwa19tl?=
 =?us-ascii?Q?6/s2ZH13l4f1MxxoqJcHP7GjZudOVoObnbX7fzS357NXXUPUZyokS+Ed6YHc?=
 =?us-ascii?Q?hcZFUxEOTPjIU1sYai9skmmoFJymtLPQFytIsuG2OmN6NNRK8QlrK2ZIp4oj?=
 =?us-ascii?Q?elOxTlvFn0pwFsUOAo1pypVw+oW25stRMeQsDkwmaYA8zMeulhJFe0DJl5HW?=
 =?us-ascii?Q?U9QN0z5tvEo9CEHyJ4C0GpzUHJRmwQKrcgfC1RMaluYX2Qtl2OjJbyLkdvAE?=
 =?us-ascii?Q?bJCzo/bUo2J8dsG/sq7lgCipgUqfXeVyxKhmYq7xmKst80vWgj6KEinkf/1b?=
 =?us-ascii?Q?HEvKgWx+FOC+7Kzvro0ckMiawJP3VguTx4tc/diN/I0o1v/8R4UNNAsUHOm9?=
 =?us-ascii?Q?DU1zLBwNP8oPDylUkY9VzMZKacvRsAP3NHvi/vA1vMD9i8lD+wPcV3Suqhmq?=
 =?us-ascii?Q?yJZ96k33EvlN1FAAwiSgXM2Jxeju9VOflKY9Dw9s93qcIs1syhXtNaFrmUqL?=
 =?us-ascii?Q?TYX9wiBI/gh6e2zYGaWqcVIhLyu6q8y5D/F2Qe8jvh3eirngBa46fX83Y6su?=
 =?us-ascii?Q?mcA09oqFg9F0FDh7Lq5qBxW8gi98NTJQYzv4JWDTJ0EOOgvcJ1gk7vo4sqa5?=
 =?us-ascii?Q?DxU4BHUD/IPOBgzNw/6gNtjNAUeS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2nN3Nxp4E0cIJsXu29ZN5v1jXiM6Z9yB0I3pVpYqQZwtepEhk7NkYWeF54O?=
 =?us-ascii?Q?fZeUEk8DKHOzB3aNWDjm82ps4KJtOWpK10xr+grg8Q04mNVNeeTGsu/jbZ6Q?=
 =?us-ascii?Q?k9Bj5PlBFeVwaGNXlrkKg9jD78fbTXqYGTXXrTR75sLkKGTkESnb9CZCinxE?=
 =?us-ascii?Q?hbBYcnU2i+i+UJhTx45N0y7Ota4cbU8Tc1+pA6otugXBLTBfAk1puBKBPKmy?=
 =?us-ascii?Q?YJarEoy2/U7lnOik0sb5dZdNcty59rCuWOjqkJPuFVx+B/z6Cgcpta16sIpi?=
 =?us-ascii?Q?PAklUb0x8sXiE2DeoSAfN56ow4+aVl85NLXp3gOewE9laHJz6LoOoNGXCL9U?=
 =?us-ascii?Q?fVvNGfP3+/Yw+hUWTJ7O8HSjucOcUgcwlWBe2X0+Ow7i/zXUT90vKhNaOd+3?=
 =?us-ascii?Q?sRVo2av4hTJLM0Lrqn2hdQ5Nh1ONthwivnjaK9kTaA5f9HOxr9JDg1oD/qlL?=
 =?us-ascii?Q?tUcFx4b8G5RptxWj9TjRqYaJ+WbqyGRJeKD5ExsBzMhyOlrSIQ/qm95Rea3N?=
 =?us-ascii?Q?llHmqg1+QDOURMyPQc/s7ylb3wIzQRtINIOXWS+qoejWyfST/sPWQ5NZke85?=
 =?us-ascii?Q?qzvSRHuLbaEj1Fg+23OOEWlc2p0GGlm9JY0RZNFtMheDC4Nhpnx16y4owk9W?=
 =?us-ascii?Q?upqRjjGBdcPepPiSm3IQNWhzWG5XYAl6nHfHUW8wHTirQwuAv1M6S+eDZgnE?=
 =?us-ascii?Q?0pl1de4I0lwP+EEb5zCo97qYlYJSgSD+Pe4WhBuJ1oddQo2/BdQD3pE+EQa5?=
 =?us-ascii?Q?/fRo4QLfpFTC5HBqyePNOtr2uM2+BuDffYB8Ag/cZz9abzK1pLGxESq+6zJ6?=
 =?us-ascii?Q?j8BIaqX+DOlJpIRn6XQCEY1uOMY9xXbl65HSgSYZNLSTjiFEdHzk4PR7UkA8?=
 =?us-ascii?Q?vyvbtjGIXhxkYZWD6PsxC537+STQIBrt2KMbjhXzY7TXyk8wJEjd+m8Rxjvg?=
 =?us-ascii?Q?XF9eliypNkPt3GIGrmb/bITwBPhULZpqpkAw7gGcWjQu10sxXBGVyOFZDv8+?=
 =?us-ascii?Q?8Upg02XKTnMHD49jkkIO/nQp5Ua7D/v0hGh9FE/0SYjcnF4o+VlcSDao+821?=
 =?us-ascii?Q?dhl2SdxTZbI0AyJBWkELxgm4qVqytNbW8r1UVhBhj52Xb2D+C7WVhoN48hPX?=
 =?us-ascii?Q?qyjWfQ8LhhJ6U1+BxqgfaD28wOmBwJ0G8nxT9wi9FupgNAUaj9uZeIRKXXuX?=
 =?us-ascii?Q?Anqtf4OwS9vLj6joYGAOR0RFNAS1tgCZS8GbDWwhNrnesOoreCEsKGWML+CU?=
 =?us-ascii?Q?aBBVU5I4DRY8TgNeUzmxdjFgKr1GQTwNAl1b43pE/PEPL3L1XJo6gzsTmG4k?=
 =?us-ascii?Q?Z7+qaYKZq6pWaCkyiJXXM1Qr1w/koiWqFD0zDLXq2ZeCpgbWZMO/ev1WELGd?=
 =?us-ascii?Q?3JoFh+R6cIguO7bqUnalm2qzvpMJSEY+iLftTEZW2pm0Qg5g8jP2Mzt4E1mW?=
 =?us-ascii?Q?gT0Cj2LRB9MeJJgzoN4jap9FcUxaBa/Ofc1nmZnSJiUpaLiQPe+mJu0nk3lA?=
 =?us-ascii?Q?BmtMe81mKVX+KHb2ILRof5isHnbME423LEjLeDOaUSzKhSJsAYqvflDX1SJC?=
 =?us-ascii?Q?R9h4b7JO3TVm2ugLHi+9yzGmenuh7Gu60jD0TeENkZ+DXdYFxj2jmfiA3IOR?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5x2nfoV6yfEdy4fpNcFC06VcI8XYj0VErZZ/AW0onb5dwotPmPQrpnV+lKGZ+E4wW2TKv9rgrICIy8HhAc0YE7fxAMuKGLmWB1jUYdTiIKYEmNgdRfpjaPqf+AOTNXdULUpugchzWLayAKEGmRwGZLfRIfGAXLLarGoIrh5jUw1MIAROgYyRg+xBcPvKjvYbakyzewTmmrnAwjHl4IURSgtsCGnXsrG8LcytUKK10WIBMUARLXH3FvYSRkSBzkSFPvZ/khPq6wKlgIGPD8DxZiuTHCOyjpM4hEvQ7ayIjXGJoZZwXtE8WuSkyIHiuB9F3Vg1mBTnUk7V5zw/hsa8maHoQSRPrUEZT9Gc9i4hOn7ZthLjVc9GnEPuOLf5DpAgyBvIuJ8h6ueODClLF1c0tHEftjH1JHJEEhZqSzvKrdrjgUPTtjGgAujeeWVDcizAx3dTLTrj0CNb09CZcRNkpXvCs/gAa+Xp0QpSXvTsz8AYvSTpDDKzKz6iq2CoCDR9y07ktNqjHdcLTxpicyEJsI1H79cSbrwhuzRJsHakXfXKk+qUZe3s6q1XAvNY8rI7O6VPgpA0pzl/40cxNGjFIoE+5ej/9ytffLo2xzIbOLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440e6d5f-09f2-4129-adf6-08dd2f2a56de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:48:25.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLJZpJhIoqCgJqbmpVaTksUcfBHxuWtEaXWYk1jgunkYYIBRKZ824/gWICZeWLwf8afXpG4ZHswnpwb57WbPibTRFf1UnD/9H4sS2imqi1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070124
X-Proofpoint-GUID: PprYzSVCFBHHiZoLWVmLM8sQMzljMmJm
X-Proofpoint-ORIG-GUID: PprYzSVCFBHHiZoLWVmLM8sQMzljMmJm

On Tue, Jan 07, 2025 at 02:29:35PM +0000, Ryan Roberts wrote:
> The recently introduced guard-pages mm selftest uses the
> process_madvise() syscall, a wrapper for which was added to glibc v2.36.
> For those of us stuck with older distributions this causes a compile
> error when compiling the mm selftests. For example Ubuntu 22.04 uses
> glibc 2.35, which does not have the wrapper.

Ah oops! I didn't check glibc and had erroneously assumed this would be
trivially available, but perhaps using a rolling release distro has warped
my perceptions on this rather...

At any rate you're entire correct, this is very much needed, cheers!

>
> To workaround the issue, let's introduce our own static
> process_madvise() wrapper that uses glibc's syscall() helper.
>
> While we are at it, add the guard-page test suite to run_vmtests.sh so
> that it can be automatically run by CI systems.

Oops part 2... I was sure I had added it there... thanks!

>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>
> Applies on top of mm-unstable (f349e79bfbf3)
>
> Thanks,
> Ryan
>
>  tools/testing/selftests/mm/guard-pages.c  | 10 ++++++++--
>  tools/testing/selftests/mm/run_vmtests.sh |  5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> index d8f8dee9ebbd..ece37212a8a2 100644
> --- a/tools/testing/selftests/mm/guard-pages.c
> +++ b/tools/testing/selftests/mm/guard-pages.c
> @@ -55,6 +55,12 @@ static int pidfd_open(pid_t pid, unsigned int flags)
>  	return syscall(SYS_pidfd_open, pid, flags);
>  }
>
> +static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
> +				   size_t n, int advice, unsigned int flags)
> +{
> +	return syscall(__NR_process_madvise, pidfd, iovec, n, advice, flags);
> +}
> +
>  /*
>   * Enable our signal catcher and try to read/write the specified buffer. The
>   * return value indicates whether the read/write succeeds without a fatal
> @@ -419,7 +425,7 @@ TEST_F(guard_pages, process_madvise)
>  	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
>
>  	/* Now guard in one step. */
> -	count = process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
> +	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
>
>  	/* OK we don't have permission to do this, skip. */
>  	if (count == -1 && errno == EPERM)
> @@ -440,7 +446,7 @@ TEST_F(guard_pages, process_madvise)
>  	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
>
>  	/* Now do the same with unguard... */
> -	count = process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
> +	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
>
>  	/* ...and everything should now succeed. */
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 2fc290d9430c..00c3f07ea100 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -45,6 +45,8 @@ separated by spaces:
>  	vmalloc smoke tests
>  - hmm
>  	hmm smoke tests
> +- madv_guard
> +	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
>  - madv_populate
>  	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
>  - memfd_secret
> @@ -375,6 +377,9 @@ CATEGORY="mremap" run_test ./mremap_dontunmap
>
>  CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>
> +# MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
> +CATEGORY="madv_guard" run_test ./guard-pages
> +
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate
>
> --
> 2.43.0
>

