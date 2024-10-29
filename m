Return-Path: <linux-kselftest+bounces-20952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECAC9B49D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10D71C20C14
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF7C13D;
	Tue, 29 Oct 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NRsuoNeB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lu/vsvNO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A879632;
	Tue, 29 Oct 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205552; cv=fail; b=WTmIGHfCJsCieApbzQQN2bg2JOgDJYjHb/HQE5CW7/iTVp9wVl8UdNUikI8XAP59UCgyuhuLTzDGw7DLMwQNk3oTi+za5GwvpDAodVH7wvnbJC5a+YEhTY4VvkOz0UTEh/1BRTXKcreIbRulQmfANGXeUHhxnOZHb5UQk2j3ZXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205552; c=relaxed/simple;
	bh=bi9J8woanA1BtN8bIKLbx6T+0PEio1MkEHJA+iQAUPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPZsy78oH6umRw0el5Y2Q748iaJ+VAW9TL0/669e2SZRRFCpA4xcyqCnz8L+Kib1p6M7BngR/ZNR0iibUkZvyasQ7TtdVpt1Z/iPHcoqRnqQVvv+aFocYz7ixbOyi2zYG0ZJb57co6YV+ulNiQSeS3Ua4kIczdR16mBLLB6Q8XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NRsuoNeB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lu/vsvNO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbuev003918;
	Tue, 29 Oct 2024 12:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xNllIHyBU1yE6D3n0w
	03jKFgecyULQc+F6pUtVaPFuc=; b=NRsuoNeBbtEv/WBpr1T4xMN44Uq4TE47GL
	Und/IyOmXGFwA+auaq62BrDpQSlty+WWGSdrtjccfZrs05CEv1EJd6Okwfujxxsm
	Eg0dHKbwuLCS0RwHXeEOdjUxYDOv65ocTWTJXdcxQ5eAcnxq9nKJ5OYpvi90xvIy
	bYF0WdKeunx4nmYTV4OR1MyAX5KrWgmVr5BVs4CsFwCNtq/ifC26B+9UvDcUCjQH
	UawtGGB7IRdU6mAYe/UbM8Nr0+OWqcpsCRZO7Ba+98ut0KxC5XFjk8zR/5bBMVeb
	Z8o8pAlHNiD4ytFLHdQfmuGOzKrb1SUvx7Y6ll/Ec4onPpGNF1Tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1w8hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:39:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCFXFv004746;
	Tue, 29 Oct 2024 12:38:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2u6peu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d23KcK+Cx/UgxSIPZ3tKscdKHLbGgh94tBtG+n4FX1FpyI32aE7B9ebe/t1H8ZBQvJ4iGeGYlK6XHXDKIe6puiAknDoiO+eUswt7dmTAVC7OgM4t1b0SmDmySDrDf4wh4nJJlHoKuUK5avI++PlMvnqPANNgegNvElnQreZxJpfaMzPlwokERoQaH40ZbxjjdUXnDaEpabDrecivOwCxNRUpl36JzDXa53R+rYtW/rdquQgyBBKYp5ABpEsKs6dJS2a/hGT0TFDNhngI134SMFJzBptUOhGNenZVH2BmJhcw8fgijbp4LPtqGj1XkbcNSwOOITilch7ep7iy36hPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNllIHyBU1yE6D3n0w03jKFgecyULQc+F6pUtVaPFuc=;
 b=tF/Hz6V/n5m53QT7ANVgYi2XiaPrgtqHBnNIrMCPoGwpjZ5IvD56UP8eRdNGrIEwWx/BiNa6AllDzP0ErSCYWo4+TF9W+DIrRDEi6axDLMAVmhLXhfB8vRwd5GeLnLa9/tz3QR7lwkimkyGtMUOIRG7GZYZhniVBz2zsJFKiTDacx5U5yBOe/48D6lb4j+GwbyPfLImhkGnPIOaNwlPzr8E92zuZcRZcP02GDu0AS6kM1WvUDeMexZ49KveLkAun5+PrN9zUBuXoGw/S4ZSJSamHLxO0Vxm4VlsXSzFI41zL8gQXJ14+Tdjggos/4zPmADvnlLH0vw0Fyt2eUDOtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNllIHyBU1yE6D3n0w03jKFgecyULQc+F6pUtVaPFuc=;
 b=Lu/vsvNOjTzgbIBYdEEd/nbcCmQCJwijjEePg68n+xFyBYN0RWn5uJgXfNTIeXzD5rlOl+nef/7oPP0xwYJSBTNnAZOZ/NHsSR8qIEB5k9FHzmua6L4F1L87S1jCe6zcapol5TejWCU/IMFjkSV7tYqCbXLnn1R1GZIrue6Mhcw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 12:38:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 12:38:55 +0000
Date: Tue, 29 Oct 2024 12:38:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Use ksft_perror() to log MTE failures
Message-ID: <afd390fe-6701-43c1-adad-550da27cd7e1@lucifer.local>
References: <20241029-arm64-mte-test-logging-v1-1-a128e732e36e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-arm64-mte-test-logging-v1-1-a128e732e36e@kernel.org>
X-ClientProxiedBy: LO4P123CA0430.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b57c69c-3644-46c9-8652-08dcf816a6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/dhVtAwG6ACZLfVtKE0ZHQlJ+hm6JGbqFRLmKkK1aDnXXi0HJJbjkUxn6zN?=
 =?us-ascii?Q?MKypI11q70biJkf3r5sKzGeXB9dSn7nPbowWpAt9Odm9QULuQKUVCBFbuLR2?=
 =?us-ascii?Q?JBUj2LCFry2zA8BJhuU3J8TCugBMwvg6APvwZbA2kWaLqgLgFoBfcFNeF/ab?=
 =?us-ascii?Q?qioJVAUrsx42Zb85tZAQbMXGJ7/StNHQoUSaiazIx9qrr4u1b0zC6fvNT8UG?=
 =?us-ascii?Q?hohUjltH6lb2TOTwOB5sv3pLwPrGKfQa+IWGP3+OwyDg6if81L29O+2sqLhc?=
 =?us-ascii?Q?A0HQ+C5VwlvX+sxXihkfvpybgN3sU4GzZUoVZ0BRzzMQ8fISEk/NiJFK9oW0?=
 =?us-ascii?Q?JewiIkiKt1AwYA1YE8t4nI8qc6ezhLvb8aizM7usnOkZmkJXIaP4CyYSETIJ?=
 =?us-ascii?Q?aobb4sUXfkX+76w/oVWRNz0SNL4e+osE69UU6ReirSri8Sd4rpFvBdXuy6MH?=
 =?us-ascii?Q?rG4bizRT3M4IyrtXoc9Ju4FXiXo038k+vCC+vvJzGt6enAdXzsL3hxpIcd7e?=
 =?us-ascii?Q?4yHEAEM51tYhXkVT4xuPu3D3zpof3vIAVOVSahYrWAGYa8QXuEfRUcKuVOnO?=
 =?us-ascii?Q?66Qd6a3f12MD4iCGxDoV97mIEcvNhhaI/sVDje0kuIx3HcynWHJW1Henajhk?=
 =?us-ascii?Q?2d3lpp8dqgOVuuXa0hgAyxekMy/S7lsQYDGeMUCRmDcI6XVvjkWjjwbcmj/l?=
 =?us-ascii?Q?4jfnY2lOMlXB2vNAy4/lubpWuk1B+mNrFclY6Yc0nlvo6adFZrZrnh3s+suj?=
 =?us-ascii?Q?yERErltKuf8IM/F7EaRURtT+MMv2zo42/OWRZyBMD9WL0Yae+AhlJejCg49R?=
 =?us-ascii?Q?a10xHLaLVCejwiTyyHWR574WgGonj9XeTBUfPzp1AdN993BUvXIP0/JBYz3L?=
 =?us-ascii?Q?HoCEheog9MMsB0o+EB8YtHX/uT0B4fbXr6Ss9NVkHj7B7vuFbdcDRqMQZBUZ?=
 =?us-ascii?Q?f47YyJtmrDdxpBMw5/oZWTDc0p1ZmYJnumxbFZ3XVyfYFZAOt2mVQcEpXBUI?=
 =?us-ascii?Q?oGsjG8O8O46R0t7vjZMAjDSorwKRfZMqvo0VfVqWXXvB6t4Pkcft1ACR0xRZ?=
 =?us-ascii?Q?QvwzTtYc2BHWwisrgGkjftKWevEJPxYeS858B/6bM/2PigEKFZ48jssdl2db?=
 =?us-ascii?Q?rJhr4zJ5BdpmkdhA1VqRuzHh7dQHEGFo4vietuXJCdWY5UVOPPcoY8Y3+8uS?=
 =?us-ascii?Q?XyMK3sSx8RcRzdaDSWq0FG7iGu4EhiH7urw4AODRDtvbBLFrAdqIPOYuhmku?=
 =?us-ascii?Q?LfX1B2SHkrK9MMBf5bfiG/XTxv97k4ozXpzq1vcMsAODJpCn/AQ0XY6CIKlI?=
 =?us-ascii?Q?vsd9XGHo9R11mMknTeygslSz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b8CwtPvTBfcGvznIpXUoGbqM/fD8szYlHdHg5PSyjHC8cDWuJldUXfn0zZxr?=
 =?us-ascii?Q?Y/xZDN3EwhsqBBhg1ySo9iwPPUNKr5QSdmO9djmMeFxwtgQRZn5RuvytWtaD?=
 =?us-ascii?Q?BLCm8GfNswF4dzrPCv7P0kNWX1gSiqLeqIfEnZHlyrlnuhwCE02SCNocrCoN?=
 =?us-ascii?Q?/tWvP/lmEzc+qdY5Unc548Ky72ibV0ekysewN8PIj3KllFHeugtJLmxxUG6V?=
 =?us-ascii?Q?31w/2Zf4goyJq+e9VAPb5vIFeEb2/6qwrCcDpWu9Q/ZU1N+1ssqgWOSmuH9e?=
 =?us-ascii?Q?Qpk562hCvjg1I/eEgWYQHQzB55CkC27Ew8ZKI7arsYgvAr8BMrhGY3MgRc8o?=
 =?us-ascii?Q?mbYrm1+Kntt3RjD6PgJSDk5ht+Z+FjplAvU+3mHdwPFzTNJYVeAgu0BhOOpV?=
 =?us-ascii?Q?xMCG+2g0f2oXyfVNZTqgjmXJKk4o0Yh1ji/EFI1aUQy9QQXiNEwqJgXMwbbS?=
 =?us-ascii?Q?90wJY1xak1jYg0kZBtsHoNiyzT0p82BqQA/NoesMMuNQZwOw6wMI2BsRYNbv?=
 =?us-ascii?Q?cNKxsJIsGpSjKB9rBUJ+mRLF1q/iuXKm7JCRzupjASDItOgQ4pXnDjV0BTjK?=
 =?us-ascii?Q?M7byV/a2alnoysD4wC8n2ZQm/R271nf7zv28wJRGpufEbMKx8V0yh5ApjWaQ?=
 =?us-ascii?Q?l/SnXqtFO1FINDvIUOCvhy02Zvl9MoGY5yrCHImxra23uNMz6ttycxUsqg6f?=
 =?us-ascii?Q?G6QvWc9v0/j0pnBW8xjloIOVXBmz3ilj/9dAKABVE8R3ejbi6rfQuY3xNmM4?=
 =?us-ascii?Q?bKyoei0y9k8ydHJ1Q3SX6W7Vq+HzVPwe6EleQsB7NZ6Z0etmmRnz6i1N4Pis?=
 =?us-ascii?Q?cSi2cjoDqhyrgw2yAMp2bXUcg9OwhrDRMDc5assS0k0ddFNqkSKD2jCLppKz?=
 =?us-ascii?Q?ZcCKb6ijNoAHydtdX8LKewNHISGcDza0B0ugd3yh9hWMct8rv7hrXZid2278?=
 =?us-ascii?Q?qcuTlbsXDb2/hSH5R3bnTsG0W1Xp1usio09i8w1A+kcRtnk3aDKHnVQkcOYb?=
 =?us-ascii?Q?oa7418nnxw8ilnA1VXu/5uemCcTdxpOiQ5juI0TvDRfOFq+Iwk9lRrK9lc/y?=
 =?us-ascii?Q?oWgIkDmKRmwBVYPEw+1u4mdeea0bVy5EptnaYZcoFPbKGeehoBg6lsM5Y2xv?=
 =?us-ascii?Q?NjzXawM9J7cdImMt22avUCzzUZGO8gHzaoDwxqp/YO6aoeTfCUzYIGPQEbUi?=
 =?us-ascii?Q?CowCIePcSBfja2GJ8rv3VyxbONqDMqpzY0VY3xG3svvE+A6JT9t6ANepHlrW?=
 =?us-ascii?Q?QVa7H2SPJuu0IydhfwuRSMlKWXd2zLGiOowrQWGrUsqMHnz4oiuxtJztjs4d?=
 =?us-ascii?Q?BOFlD1GngALNBlRUMfeOixlm9lmwcQEChPpq0n2png6qFBnrG/BUg+PtxqB7?=
 =?us-ascii?Q?iBy0RYdHNnYPSivb6dWrfUQ27qALqsOQiDTvfueu9Q/SInp29obVBsWPA54N?=
 =?us-ascii?Q?cxytYIgEPJwbXQ5griL9HWgAunp7VheVhZ01eKUwyfvNhn9/dqArgWXJrpbq?=
 =?us-ascii?Q?5/IMVwJMxDPjwICBbHfsJJW8Dc+McAPoSq0fuv1VNUqvRoBHpAjxZzZj+Dmb?=
 =?us-ascii?Q?SN1r7kK4SCaPVHKi7jcyeobfFR0ZYdWQVdwtRrh0TmdaxS2VfMrvvzhz+Kew?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ymGgwtVEyX23xVpfiYg+36YZRtpDRpOLc21cY2TUa4C3w6ltqTIlc8sMBMHAG5LHSJE3+NGEDiuE0/UoV0VXMuEeSpkH35jbolzb3TBRO0EbxFZIi8W2pPPSoZTthSASW93VmcQGr0UbVkNjKdwlEHUj84SGxlwF26vEt/XgL+bBylF6USEYUyfxak4xuCV9FuUJXgHutYTI6BPLJZTsqIwVvdgD7RNe3aJGTvQ/yz+r4iMidTpUewtvdgsk86TvRpqnmiVq5So5AA98HuyPiEQvBK5TSyjvToXxCz0SAvQvQ85oIAoMNBk7mtOlL4y+zSwCyCS3JT7j74uZtfTaUZu4K0v1AfE9IWURoP51cjgxN2icx2S4SAq3pdw3MJroAebowPn52bCPuhDoCFBjcwfKO9M7QTzJXFh4/GvpoBCvm9Oi5s5doIRCCzMWnjc08BcTGiMLBlh8+nfpYhbu9PHVW+9N7IZ/4LlhwIiuZBd4bpvS1qVSS4jPEoMtl4Q9Y/N5UQ+o1gON1BhcnzS5xXMJCuJ1P1eIfptxbndIEFrwhs2jQMJx8KmSjPfvQ/2VcOGoUmUmT7isqTOsxu8zSGfOI+zw5YUFH4iNtmDkZWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b57c69c-3644-46c9-8652-08dcf816a6df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:38:55.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08oPVzsZ7Fd2NQCAhABESe0GU6islMrd4+I4a/hXb2AzcnOFf3B7dmGVN2Gl6Pw+ks4s9evmtB6FRVFWH6esj8/lC76bm2WwBq0jGXETecw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290097
X-Proofpoint-GUID: ThVFpzwDBdyuc7o0v567O-3Fpsy9H-8t
X-Proofpoint-ORIG-GUID: ThVFpzwDBdyuc7o0v567O-3Fpsy9H-8t

On Tue, Oct 29, 2024 at 12:34:21PM +0000, Mark Brown wrote:
> The logging in the allocation helpers variously uses ksft_print_msg() with
> very intermittent logging of errno and perror() (which won't produce KTAP
> conformant output) when logging the result of API calls that set errno.
> Standardise on using the ksft_perror() helper in these cases so that more
> information is available should the tests fail.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks very much for this! LGTM!

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/arm64/mte/mte_common_util.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
> index 00ffd34c66d301ee7d5c99e6b8d9d5d944520b7f..46958b58801e90ceb79be76f57c7f72b50d43b3c 100644
> --- a/tools/testing/selftests/arm64/mte/mte_common_util.c
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
> @@ -150,13 +150,13 @@ static void *__mte_allocate_memory_range(size_t size, int mem_type, int mapping,
>  		map_flag |= MAP_PRIVATE;
>  	ptr = mmap(NULL, entire_size, prot_flag, map_flag, fd, 0);
>  	if (ptr == MAP_FAILED) {
> -		ksft_print_msg("FAIL: mmap allocation\n");
> +		ksft_perror("mmap()");
>  		return NULL;
>  	}
>  	if (mem_type == USE_MPROTECT) {
>  		if (mprotect(ptr, entire_size, prot_flag | PROT_MTE)) {
> +			ksft_perror("mprotect(PROT_MTE)");
>  			munmap(ptr, size);
> -			ksft_print_msg("FAIL: mprotect PROT_MTE property\n");
>  			return NULL;
>  		}
>  	}
> @@ -190,13 +190,13 @@ void *mte_allocate_file_memory(size_t size, int mem_type, int mapping, bool tags
>  	lseek(fd, 0, SEEK_SET);
>  	for (index = INIT_BUFFER_SIZE; index < size; index += INIT_BUFFER_SIZE) {
>  		if (write(fd, buffer, INIT_BUFFER_SIZE) != INIT_BUFFER_SIZE) {
> -			perror("initialising buffer");
> +			ksft_perror("initialising buffer");
>  			return NULL;
>  		}
>  	}
>  	index -= INIT_BUFFER_SIZE;
>  	if (write(fd, buffer, size - index) != size - index) {
> -		perror("initialising buffer");
> +		ksft_perror("initialising buffer");
>  		return NULL;
>  	}
>  	return __mte_allocate_memory_range(size, mem_type, mapping, 0, 0, tags, fd);
> @@ -217,12 +217,12 @@ void *mte_allocate_file_memory_tag_range(size_t size, int mem_type, int mapping,
>  	lseek(fd, 0, SEEK_SET);
>  	for (index = INIT_BUFFER_SIZE; index < map_size; index += INIT_BUFFER_SIZE)
>  		if (write(fd, buffer, INIT_BUFFER_SIZE) != INIT_BUFFER_SIZE) {
> -			perror("initialising buffer");
> +			ksft_perror("initialising buffer");
>  			return NULL;
>  		}
>  	index -= INIT_BUFFER_SIZE;
>  	if (write(fd, buffer, map_size - index) != map_size - index) {
> -		perror("initialising buffer");
> +		ksft_perror("initialising buffer");
>  		return NULL;
>  	}
>  	return __mte_allocate_memory_range(size, mem_type, mapping, range_before,
> @@ -359,7 +359,7 @@ int create_temp_file(void)
>  	/* Create a file in the tmpfs filesystem */
>  	fd = mkstemp(&filename[0]);
>  	if (fd == -1) {
> -		perror(filename);
> +		ksft_perror(filename);
>  		ksft_print_msg("FAIL: Unable to open temporary file\n");
>  		return 0;
>  	}
>
> ---
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
> change-id: 20241028-arm64-mte-test-logging-6c6e737b1c62
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

