Return-Path: <linux-kselftest+bounces-33849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939EAC4DE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 13:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984E917B363
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2C25FA05;
	Tue, 27 May 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BnJLOYFo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KZemjLb+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647025A2C4;
	Tue, 27 May 2025 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748346826; cv=fail; b=TTkt4+PStiuCF02fefIHaDU/+mLzknQK/pfUtoibo84exx0xnwWMXdNIZaDTZ037NSDe/7AnY+GR16ncokMTM9YyjPY5EQM/L8pLfem9UxqewPFFSSVzsJ10WpSq9T6VqtM8ferYy1dYwqaTVjDQYQbT5Pa82yXSRTpNiw7O3fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748346826; c=relaxed/simple;
	bh=S2qllDxL8QDAILEnAEB/hRYSLHb1pndJT2uworOpZD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGjX++lAIG/gWlv/wC7p0GaXrh9B6X5NMkUpRvphjRMYtCBoVdSiItLOhrFrwTCzNZKkJKmq+Pik9Glwvu0VeaxmN2jFph071CB97BFnrBLtrR7y1wMpk1FQHbwHqH5DxJF6shyY2+tdfYILqvCOblvgNzDg7xm65B3ueISsXPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BnJLOYFo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KZemjLb+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R69kYf002790;
	Tue, 27 May 2025 11:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Au13LGbHskyyz6vuG1
	mGWye454QcPg33V0zAnq94uaE=; b=BnJLOYFoxM13VNwiZSXIU/2L1re8dB5ZyC
	6jqtqRVH5J9Xk0jjgfXfGxLwqb8UpYYhpi2JC3PTAIfwUVXD1YCJtbdxWGXwI7Mg
	jnAwid7rRQC7cDPFeIn2nS64zdLtpjoGSuxSf7hPEQ5w+RmjJlE/5LdT/+xyGIS/
	N+tGMwo6Gp0I698/XZmHE5juwRmpwptgoRjXKPfxcP59Idc4VzmA1KvT+BBlyytM
	JBlnfZqhQDYmSiMU54Tr5WNpoJR5GkORK6lEKs4tNdKwYm58ypaR9w3V+vBqkQRI
	i3bYYahx/y331MdKpI3QfmdnWrvKQV3f+sjBOBo3+unOZFgu8lng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd2wmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 11:53:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBE6wA027802;
	Tue, 27 May 2025 11:53:34 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j8snua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 11:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC6olQSAt+3Pyv4QeICxvPi5NXdgDvH/3tmruj4XoM7NqMRVs6ntBHYblAFGqcWuDdeKgfZHQbIHt7wp8D9tc7ieD8U/28vh3A60pBWQuQ+nzyT7F+FPVW5dXf9sBhLkY0OexmMCBCGZ6fk1mPyZyUVq7Uw1Z9f66h2Jv1XRZg1kQ1nOZnSCWC27qabmKu+cLHezFN9QerdqYJIWoj/rlTQBq1sC0c5nmwC94EjABax3aozssSl6tkS1xcLhtQFAC0fChpVRW25kcRNZR18yL0cgNat1cT20WxPZ1T9MptnBfDXm2gac3LpXT9JgjUV38FRqja/a2ay0a4oIr1dNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au13LGbHskyyz6vuG1mGWye454QcPg33V0zAnq94uaE=;
 b=DQspjdlGWfz3KwYyyxb1ruVdxoIU3sOIO34YNa2d0jDYDOrJfnD1ajYdsIossKosMiYZ4UKeJ++9nqaf1C243K2XKmsjxVuQD6WMC9pVL2ZIOv+cjga5Rnl9ahM9IIXHrgjWmFKJJTO2Vh13SqG/+21qBByiSlha/oNfYQKCplRVpIQQ6MJ+XqrO3eDwrTSRrloSeU7BkEDgiv7RDgpYUGEnkqcFRXP6NLCH8hWuC5nhwyoBkUHZdhFDW+1/14Fku4HUJrAO25RnCdb8ItCQnHOA0fQVOMg436gemUM2bJPte/g4IBYILayzHr6n3Sok45GpW8HnOp3emDtSbbU8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au13LGbHskyyz6vuG1mGWye454QcPg33V0zAnq94uaE=;
 b=KZemjLb+y5h/zDJzi9WMCglT/EZuBrKyG6/eOgcBmLvw25PkEFXmR+zIIYj4W0SXOFNxk20Jf1syBf5h9h7nBHQBcCrpczEg7N5F0nt32nYjQAoRkwdbZpTxth65eGxm7pl8VPyVxm+eCYVp+F1spA4drTkL2H4MVU6W434v2Dg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 27 May
 2025 11:53:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 11:53:32 +0000
Date: Tue, 27 May 2025 12:53:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/mm: Report unique test names for each cow
 test
Message-ID: <675ce51b-a218-4fe9-a571-56387d72fffb@lucifer.local>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
 <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
 <3745cced-199a-4c9f-a282-d9587f2edd41@lucifer.local>
 <3729c741-fd02-41f9-9668-7575871e7acb@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3729c741-fd02-41f9-9668-7575871e7acb@sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0ccbe3-5287-45c3-9881-08dd9d151aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7lfSTAI6IGGVxK/zcLYZkgTOndhvhDxWwOKY3BsaO+HTPAXG/ZOZDBGivFD?=
 =?us-ascii?Q?kUbRgOgUqTwebW/o0W/JNSh1oDjWBHgpW7VT8494/o1yfo1D7gt4RjcSsGYh?=
 =?us-ascii?Q?9HlnP63zuJ+eODlhkYf9lsulh2E54jvhMD2TA8tLoOP/42iquZjDJ6ai7Djf?=
 =?us-ascii?Q?2HAJ41fJ5RtqQIFWXi3IUDKoBGZppJfhMLm6Jw8WcE8Sd05UhGioL+Y4rzbp?=
 =?us-ascii?Q?RGIxub+3VsaHc1AHgp1p+62Qy47dLS9ESsQINoypTbkdcAR1AFxL4Lm4i0X2?=
 =?us-ascii?Q?uozF38w98uFi5NGk4MVKAPZoRgVRrIKz+7S+A5C1wXF82y3Hic6Etg8Bnd5+?=
 =?us-ascii?Q?NpOKA7/f/9mQopGldbtUtSm/iEMULgidHFFgYVIm9ta/vlvbmIXTfU+t6QCh?=
 =?us-ascii?Q?sfycgAdipq4wWNM8DZ3i+nEhSOYVBBD/JYcQI5PkaoC5T2c5KmwY4m5f7K1H?=
 =?us-ascii?Q?vZGJ5LGRPtHqV8CI483gMhS3EFuW39udNz4idDAHxkw/LSTnK9L/1kbjxYOu?=
 =?us-ascii?Q?Oh0Z/dA5v86TiglnISy5aXfPePCY+KmM84tYOTM/yULtD+iV5obtEBk5SVL0?=
 =?us-ascii?Q?/FAsiW28IzqCVhl/kzh5+xuJS2nxHBb6dpLBDle+LVTqj7dYWf4UvlbmSbKN?=
 =?us-ascii?Q?Ek+lZM33LgY/a4YXy1KhMb8VgbkB6PIE9Kl9COp6OOerxuhiIzADogK/Vanu?=
 =?us-ascii?Q?Ffm9lILXFhd5dfQ/W0X5pXmpOpFLdpfM+vEk85h+V22djrXYd70YPPua4hS8?=
 =?us-ascii?Q?kaRT5Bp6xZv/4gpEaLdHpynYKGA7iFHckoHFs4v61chgpKbBPCPhtYppavwD?=
 =?us-ascii?Q?rMPAzfVbs1VPs05Q6mQa0VaY06GvT98bht1AOw76rJktd2ti8IquAmGBPDFH?=
 =?us-ascii?Q?BFXU3eihFt+/mTJfXvCmN5/+x2vCotQIt76FKRcTvA7et2TFkoBQ2aiHojwJ?=
 =?us-ascii?Q?OF/madJhFRjhZKbuf7ReudR8DtVOs9NYns4N6hS+9Pe2oX41ImtZ57mVILas?=
 =?us-ascii?Q?DjQOvUyPHwJpN6O2k8TfKzIGOe/8nWefN/ynaVpIDZHqPgwyH4/CYuI26jxG?=
 =?us-ascii?Q?m9vp0jInxEJ6iv3/ZkSCsUO367sFkeSQo08q/uMot9NLSYQUdy3YX8jKlKCz?=
 =?us-ascii?Q?GHbHOgGPfEvtfCaeLftQr6IuNWvRgYEh4wXGdSCJ0xL5GnrGckUwkeE9Y7+K?=
 =?us-ascii?Q?mR1xeOQ7Rp5Yx49mONM3ZAz6cf/mhHyoVbnSOs8J4Ueus9Fbqriazlqi8pIc?=
 =?us-ascii?Q?lQ6LkfV5cPPWiDyEXPlGYzm4c4kT9CQ09xVDPaXi55pZ03/6d/PBRw+mj/WH?=
 =?us-ascii?Q?HuRt0SPS/9QD7QzbOsTTNV0czPW58omBv7BC0GRdMa/WaNrZjKwZijRAav2h?=
 =?us-ascii?Q?lQt5wnzJBs7J5S82hQVNb5yRT2tA3a2AwixkHTFF/ceEmoXVBmTN8Xei2prI?=
 =?us-ascii?Q?nfRszXKyDfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ysv6/db3AoFxwRG//7QI+hBchv7gf0NlizeSn+oFLHu7sT0r4bTYKP7Sor7z?=
 =?us-ascii?Q?tNBdeLyBjZTrE03SVC0/S/6FduUSXwQ7trkrqFfJxjogob1AiMosK/t0CBQP?=
 =?us-ascii?Q?b8gb9ARQ/Opc4WfgIev4SMP9ztiKTrKk7jEFTBMvY8s0rt5KJLWvP+OsHAP7?=
 =?us-ascii?Q?XFKdUi98sTBmFzIhbKoCMpRIjUR1ZiszdDvTkWYxWTpoNXq2ezvLbedHAHEH?=
 =?us-ascii?Q?hjeWrKoYizAiSXnnk0TCjCrQOEvDQ9VSSWXnaP/9mC2VeHtkM3aWlw+kDwJa?=
 =?us-ascii?Q?w+b9JwemaqdtFbTzohX3TsrDP92VvCpENM66euOfhjsCAm2M/cI+ntD++kJR?=
 =?us-ascii?Q?/H7iU3tCLOOHi2cDcwVi1+YnRHrdqccVFZuznpIFzty0Zs9J8yCEHIIM7qHk?=
 =?us-ascii?Q?nVY0jxFKI7U+SvZ/8Gfw07Smi3/UJLsy396mpIlm1ecqL09PySVdMvRsj596?=
 =?us-ascii?Q?Gqam8rMZwnL0IW0hGy7ErrgfRD6Y/HkhXlL2rUX1VmWuWDwnw6WcnrHNBn/b?=
 =?us-ascii?Q?Dkvz0Dg0e+2t7xFL1tbI8WxKD/gnHTTYULAoW1Bn/sWSudMKTA0sgMhlGnZo?=
 =?us-ascii?Q?j9xv4oGEbpld+Y7RrxklBc4ash6cGR8ofkOKOOXsuQ/tY/LnXjOI9UUDj/KT?=
 =?us-ascii?Q?pXvaLHYy86XSiwm3g9IQ6lGhj9LO50hwkqHCDxGdodkYUueQz19h7wWTSpZD?=
 =?us-ascii?Q?bR6XAFUynM1obDqThhLaYX87LZDiWpCQhNBNM3YP/3omjCVt0zyAUtZPWuDS?=
 =?us-ascii?Q?wo7EYCHwNQFQzJbeOwXAONS0YaoMcZ+WICNPV88gbgv246QXDQJ1sZYWh8bz?=
 =?us-ascii?Q?3wm2HQmPPWrFYQ3W1izW+I4nFwEX9fkyaCr+Ujh6gjGfLycvpDMNmsK+QXKj?=
 =?us-ascii?Q?jHM80lj5vzPkq5bfKnF7aDL97mJmOt72zVtEbzCzv5ZE7fF6a/csXaWfR1UV?=
 =?us-ascii?Q?zeWQd50x6yW5HWThekXQJIhI013lfjVPrRIQnJN3fQHd+4/HBQyv0rBosS12?=
 =?us-ascii?Q?VA5PgwoN0r/H226Lvlomjw+39ycZb/bVJzkSx/cek8d5bmazXLzrkdvlXuYk?=
 =?us-ascii?Q?99QkxPyAbfE1RPlrPkxc58YE5Jd3sOOQaknZXC1imP/s8IuiO5n3ezKkyNji?=
 =?us-ascii?Q?PXSxQDDRLN72AkSd4ddqWmwghGrkLB6p+XPuSbnFw8xbTBdKtO6dIoE7o0JV?=
 =?us-ascii?Q?yLWPRTjln2jwDdbjuXl1FyaZehqkbAliC2d5+d7zTZwtX3gXoMISE9SKEOxx?=
 =?us-ascii?Q?tqJxPWxDeUaqD4u0pzvUZHsam84x4dZt+WJ5jTV8JD7AGk6Li/mcVC29RI/L?=
 =?us-ascii?Q?YWgaWisZlwYLNVkBWWGb/txxgtMoPZcqTiKNUrAhQV2IENxyzUQzfqKKI2X6?=
 =?us-ascii?Q?EiGcApKzpuLyZetuzT7LQ8Fo9yo2VQe9dXheoY99mL5MnqzTdspk3NHDPdvn?=
 =?us-ascii?Q?0BGtoDZIVy1nkpL0YUahqiXweowQ2ZEVGQuU1OG02rG8sQMfOHMqOYmZBKfe?=
 =?us-ascii?Q?YlG7NrJXq7nm8iOnpylrDkR3Oj767fMsmcqhLW1WkcP9HOMH0VvbMUuYIAG4?=
 =?us-ascii?Q?OijpsQqLP0EIjRbG8DtVgSADHgcUyW6eNuNPzNykZoDCyATFRdIi8AzkB22J?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hHm5eg6sP9+YXV5aM09nUEu0XiR5j2djgRwVRWY5J+47Y85NYu1Gcso+qQgf5vTxsQIxp9u6ipO5L/rqFKQeGCw3KyEUeTeXWvmZqOJMeb+ynZAxQDp9s7vHypDDzxIx5kvnW6iEinfpyR66Bd5+M8fMEDjA/hkFe9fppUSkbLdM1wbIlofU4huisjgFhdLuGBU1M7oKeYC/Ta85mlno1voPXWWRfsKRjZSk/KNAGhE8lRdHu1CefTDz4WpB4RmZZ8ad1e9ykQYKsLti/hgEdFziMSbYyAmslLxKZghVnkpPuBgFgi1ZnxGf1CiCfBdtJFMxnI3Ks6vanGuB4qXnd9BEOD4asXWwfI4bVjXBWwsqNw+7oNoh2nmsyy7OVxInbvyUTbOgyWbklckTBqwwqUx5n2pv/w3My2reCIpFs7L76f+iM8vTx8wb+C5RFDSgdnGpnrqoD3HRcNpkV2sBzuNpJM3ASOAslV92IIEnrfWLhDG5L8axSktQbaCPh/CmMGQsL7ea5cB4Ektd4XQJkScVgPa1wa106qKhyxzz5qquLvL/J/PHaT1RNvr51ymBlzLbU7/BkInfahgIID8S71/qBaaiLrgYboDqd+uju3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0ccbe3-5287-45c3-9881-08dd9d151aa5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 11:53:32.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrb/Dkhlvbsie9sMArBAq652F5NAHMeHkF8wFRDn3h1olMUD5kAdoAQczNo4C/aBl6glQK++WN/NvWBGXuxK4zvecgE4KOgZU+3QGPlzhY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=722
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270097
X-Proofpoint-ORIG-GUID: Fp7TibMrggydF42h9v1IXWvYLJptZ-DW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5NyBTYWx0ZWRfXxsKYEVOm7nKB MTDp0buk2AMU9IL2xR8K8VLw1qkDkFWAamaqO/w/3+lDqiqNduokH/iVEVcfCdyc5CboNxRvRAo FtdEja3ay/LZXJJm3V1VfLqFV/X4aARJPusOVzPnnhJ5jGGKE6kotpZNkm5j4hdi93hdZOCiilS
 FlQCnHyptPkTzi+9Lk3HleS6Ef3kYKe5/U1ADML3lufX0X2ZKIlVhIoAGvxdpPFgOp+wPTe2Mwf dAX8ud0XD1341S+9Fj+ufpieVyym3JkWgQzIFMKzFpm0B0+rxqOOdirLgnZBh5uZSihlb+5EC0L v1vEU73FhtGsK978FTLOs7d0G/z5weLVl6UBanAzA/02oUXG6upVZZubu3YDAdeitHpnV4P3/hY
 8OHVymvXniyXOb3mKW/6T4ULhUiZLFdmDkjC3T2cqXZT4jArF8hlF2RsTaWOO0BXsGGrDtNe
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6835a7bf cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=aPbuqLBgUDyCDLZGjj8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Fp7TibMrggydF42h9v1IXWvYLJptZ-DW

On Tue, May 27, 2025 at 12:49:57PM +0100, Mark Brown wrote:
> On Tue, May 27, 2025 at 11:08:05AM +0100, Lorenzo Stoakes wrote:
> > On Thu, May 22, 2025 at 06:38:52PM +0100, Mark Brown wrote:
>
> > >  	ret = setup_comm_pipes(&comm_pipes);
> > >  	if (ret) {
> > > -		ksft_test_result_fail("pipe() failed\n");
> > > +		log_test_result(KAFT_FAIL);
> >
> > Looks like a typo here :) Should be KSFT not KAFT.
> >
> > This is breaking the mm self test build for mm-new, could you fix-patch/respin?
> > Thanks!
>
> Ugh, this was masked because it's part of a series and among the
> problems with the kselftest build system is the fact that it eats
> errors.

Compile errors too? That's... not great.

>
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Yup I normally do, I sent this out quick and dirty because I just happened
to hit it when trying to do other work.

