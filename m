Return-Path: <linux-kselftest+bounces-28224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBCA4E8D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C430F7A5235
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867227D760;
	Tue,  4 Mar 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XLQLVXUP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P2VsUW0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305D276056
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107899; cv=fail; b=iDX/3JnabcCnFSybUeVTgHctRJc0EKXh7RdCuIclpqmo0M+8q1w4fG+zi61B1wh4yBCpdnfMSnNwRtd2KDM36vaoXDUbFW5pG8Y9ktucuIQ735fAnS4mUlJUTIaDPWUAENU7zQHy6hfiZXb1zm/BTOr0KSRLR1ekxNxadXtUZ+4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107899; c=relaxed/simple;
	bh=ednP7Nxr1N7eOVb8SDu7DnuIxIM2bRfL/MsEB4/N6mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kkW2FmoJ6v3XVenbVO4oOFVeBsU7w76Q1Yk1r3YEcONG1W9ltTt8Xuf9PymDKBHtPTuLGzBEdolOJHQaXj3SMOWZ9UEtt1Td32i9/akAS2v7k7gSXMZ3006FHL3Q1msiMq+5ShY8VtwdgHeTUrAeXNBwWbp8K/VRCPP6TzDZCK8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLQLVXUP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P2VsUW0V; arc=fail smtp.client-ip=205.220.177.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 28DA140894F2
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 20:04:56 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hFt3XbJzG3lw
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 19:38:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0234842759; Tue,  4 Mar 2025 19:38:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLQLVXUP;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P2VsUW0V
X-Envelope-From: <linux-kernel+bounces-541674-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLQLVXUP;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P2VsUW0V
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id E483E424D8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:09:49 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7B0B22DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:09:49 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21F316CCAF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493020D516;
	Mon,  3 Mar 2025 12:09:40 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6520E30C;
	Mon,  3 Mar 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003774; cv=fail; b=Z8utbz6OAeCMUdtTZ/AtwiLeXsaHdxhQ+BAENAhVu+UZ8xKrSUIaRh/KP4K12iBz5rPSnBYVew6dA0yCe+tFN9Ot92Qj7CW1BBa0aLTZqN8hVcKPCiaPzkZlsdN937d6UkvLFRS0dZZ7b1grA435rJoGp4z/yFuMzUhs4gdkPos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003774; c=relaxed/simple;
	bh=ednP7Nxr1N7eOVb8SDu7DnuIxIM2bRfL/MsEB4/N6mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U/B92IsrpaK4oHiIPwYLE+Qhm2/xPiwUACYJQqDDDH8G19xlLlJ6QvmF59KTLYlwrdWHJwrmLn/CsAX5ysSQmkEM5WAHquY+DYthagzdqIDEekLcmtSA/qN8VYDO0aVTOMAIEMxRXtAiEsS3IgUDWzkdDs+O8VnFEOPQLD3LSZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLQLVXUP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P2VsUW0V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tfGa030063;
	Mon, 3 Mar 2025 12:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ad24i9RVQnjI3t1hu3
	8flu9G+cuT0Ic/yam/8L0LBBk=; b=XLQLVXUP7dnlMxluZotnpVw/xcESdMjZhX
	UszcmNUwvSNyWXArwYcJCnKRYsoYPDAb1X3nzIqP0d7tNAWdYmd3kUM7TrVpJjem
	WNiU7vOhscH6OQLHlfRRDd0Igp6K/aj5K6vUSYwwG62PFxwiRO1dlJTt0MHDEn73
	zrbW3kdcFj46i4cj4rve2hXylh6uG4wKTXuRX+4NRlv+Q/LUb4BbSvd583RlidjO
	lp91Y3pWpnrwzwTMCZnl2i9UvYKgdNhVumYc0eJnAxg97UPK++x4wbZAAw3+Xxh8
	m2EymolvuyLYnsJDW/wUDJYefzwP9efPfZbE52ExGZO0o9Dd8mVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86jgm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 12:08:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523AGx6q039093;
	Mon, 3 Mar 2025 12:08:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp84eku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 12:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy8D8TRhW9UWx8Pr2Dw4J2qDT5hZRZIX8Qxa/nibqfBIz9f2EFuPMcVcZBbkQnMtlOTAuGXkfVcaJTUC6npxEtkvyQN+N6AzUb1LR1XCw8ZejIF6P4cG5RgNOEvVLTPKuwuvrrRdV2SxRU93Ab6p/7a6SJZx8doxBtOCeVzpSZT2HZDEkBqE4IOwCI6yPApep67JdvZvvqGVTl4DNzj6biAqcv53L2VLqU9aUBPT1i0JLyHGhul9LFe3+Endb2QvjyN3dpTE5NpxZymliE8wR7JVyX1HXKEmA/Q/cWvQKDjxraGeCoTHMwIHsPiw8woSm36hcOt6lE5iUdycs5+GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad24i9RVQnjI3t1hu38flu9G+cuT0Ic/yam/8L0LBBk=;
 b=JZRQ6Fu6YrPZ23q6FC7SWAPxDaA4eeUd1WUZ6O9G1i2AnoNGuCm8iSjkXVezKDda7J9GNggJZdV6ZkdvKD5DcXRWNPm5W0f5fCStaqnSzR1Lc/qZTccndo5g5lDuuUTJJuW7aO7Cc/aZkuAo2aqPcUs5Wnk24rmg3kBnSLXZATOxtPpP6klPqijlNHpYTv0PWFiZhvQAGGGkaA2QOxIScZYtS/qkFaeAB3t33k16bxOHkaQa5/YKw7/TX+n2sGGHqjbUMpGpEl0edAOBOfFUFazrBDXFS4UpEwzMRdI3c0RRRzLjfIhOBeZ0/mF801ai+pP7F1i5Of/ScvuZQvqWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad24i9RVQnjI3t1hu38flu9G+cuT0Ic/yam/8L0LBBk=;
 b=P2VsUW0VZYUwL8BwJrtun8UrFD6SX4xzh60GByb3sKTc1Q0JuC7gZO8DhgeEWQ413/JLneZxzP5FPS61KmTSTfzgq68iXcmTPr4FWzQzx14bj0PN8hN9v3nFcQXSoaLEisdS3tXStfz6iCjxu5db5LK1EY8Xi4Xmo+KK8UAgzrI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 12:08:51 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 12:08:51 +0000
Date: Mon, 3 Mar 2025 12:08:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
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
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
Message-ID: <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-8-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-8-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3de22c-5ed5-4017-e0a7-08dd5a4c291a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vuzmaQ9rl43zihtizr3DMKd4mLncp87hm4yyDnvJvmHKIy+9gUh/AhFI9WmS?=
 =?us-ascii?Q?xFicsRKs/MLb0KSCImWeZ+wgrISR7CMM7vmmBbUV98DOp835kRqr2SDnGDTa?=
 =?us-ascii?Q?k+xyrq2EnOjBykZhhkMWga+u6liWvnZOUoXedZFh+sIS0OdFmMjZrBYCZr1B?=
 =?us-ascii?Q?Ae8JlQFW7wjYn8MqtLGrGJr2WwLhrQ7eogkrjkF76WuQ1u/MDTL6GGeQfBm7?=
 =?us-ascii?Q?oNqNpSVI4H3mr41eniD6tYiTrn173ToLC1YB0cPw2Wcfp10vRe29Ss/MYmhl?=
 =?us-ascii?Q?XzpFLk08zIISC7IPFhr8TePho4Kp9Xuq0BAgROWQCgU+axyx6qMyrMVPd81U?=
 =?us-ascii?Q?r7UG1goMxj5eMsrqfwpY8BCA/Kaw0GZfqOWWyZ93YSPgdaEXmmkxOwNSlogk?=
 =?us-ascii?Q?7pMjdwokyojpMFnhPUqLgeINJEiPZd1D967n6KVg67PyrqXUmdY0G6TtaWcA?=
 =?us-ascii?Q?to5OgG6XOnBsV658dwrWb0hpsjV0t9h1P8gT7Rjnpr93zhv7ejsVZaTR0CLJ?=
 =?us-ascii?Q?XmW13TAbhUMGft+4e3gF5Ars3gKhmGZ43BvrXpNiYyWAAzJoQIbgTK+DcWt/?=
 =?us-ascii?Q?CT/tuxJITuNUO4/jyYwXc2BFfk5sIiKT31wWVgL27Tij5CXwuQva5i36qMCA?=
 =?us-ascii?Q?zK+BV/g6TDBbAikF2C69vIj23c8zwMqaPX61l54GxRdATrs9BY6Og95mUkCS?=
 =?us-ascii?Q?RSIkFWhePnu8aMunOK+JD/F9idXBdEeTJhfImez7bBJjaSp3RrAzUH9da0d6?=
 =?us-ascii?Q?/w5I/sCtZyta+fzKW648QO7pxYhzRKTtXCv/wwcZTORu03NsZj7O7bRf/9Yy?=
 =?us-ascii?Q?IMXoqRRbt0Wwi3XNrg6DvdJiTO41ILvNJZ6WMjEmm+Gc30BbgFqyFFxY0WP5?=
 =?us-ascii?Q?mFiPAwHekT0einHunjHY+aVs2IzUvUl+iOq1WaCeEV3Fe0AZKK+aJUSZPmmY?=
 =?us-ascii?Q?E9XfrbkcrrCOtIYuawrUQZQBhI+QHPUVny2O0rC/1gm05OJwdGA01Fnisl1l?=
 =?us-ascii?Q?QDYu9U9FWtRMGilmK0Bs4yDMcrgDILejUPgpODtMav1z/v0nv8BR8TwDF3IT?=
 =?us-ascii?Q?rz+WlLy0Oc5hUdV+fkoWWFL7hStVEByPxoFc8otJhB2OIRuuzv+/1NP+FV/t?=
 =?us-ascii?Q?epzn39gSEEQ7VXV1Gf/d6LQKFpLj9arS9MTz0QJGWQY33c91IhuiShCth4ej?=
 =?us-ascii?Q?ehWSolkKFfxKGFPr0q4tkiAett2QqNoEMFZH5OTDceG1G9uEFMVrNu+YbsO1?=
 =?us-ascii?Q?9XdH0KK861hVMQZomFa/cDfShsi01Zt6qVVXO1WR3tKazzb5Gc7zgfX01VUL?=
 =?us-ascii?Q?Z9grbQ12SFfDK68Ut/+WoL+vtmcrR6ega/ohtuRM32RplqCADBlt1c4WH/Rb?=
 =?us-ascii?Q?TQuN8mgk7W6zU2gJgK3MkXgkCdlO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jHmR+70smI1cTMXfwu84PHPyQdBl+qa9UXDQL/W1NraCobQ+6nS8Fgn53cEV?=
 =?us-ascii?Q?1pWkebHfI5hGayfU3bi0xvtvCZiBBLkPP6R4oKyFfxjFS3uJF5xSx4Pjoudq?=
 =?us-ascii?Q?WjNZAHjJ635GyutC+nASyxvVRQHBWxCByp8WKqp55O5Qt4PpiTI6mjzYHgjD?=
 =?us-ascii?Q?O3hbpCKDB2fqJbRsqsfvFapcm8z2ukMc1iB4r/stmdGcGAgoa65woqDW35n5?=
 =?us-ascii?Q?WdhBF1HRE1YorhE5iyEkTXELBIbpMBCAMTPRuA7O+uWn5Zj9MQKLqfTZCoXu?=
 =?us-ascii?Q?YA0ycL/qgvi8YgNkqeW+i1ojr4l8sWskZaEqZbZrV/YgwFhDGd5mdIoDzZYA?=
 =?us-ascii?Q?mvgRKKWMUweXHj5hOx+PLt24L9r4LlQvrw6utaoJMsfhRgWhUVJebCXWt6Q5?=
 =?us-ascii?Q?FLCMrHoi3WTR7+/9Opz2D3FXNfAloFPGwK3ioCIqfYQRvTkohELiQU5t7X2M?=
 =?us-ascii?Q?5PYjAjflr4zsM1XXnUFWKYwXPSoc7mskmLz8s9zDC1zKnXm1eONJxsLGzlFl?=
 =?us-ascii?Q?kDnMs6lafrSWD7gRcN6/NfsibQThX5sLpv9bGWz1AarD9rukt+6GRSnBEo5+?=
 =?us-ascii?Q?g3apCps48Rn6yHpAUTHBHpOkdmhOFxBdshxxQR6V+JCdYRpoPMrLJth/znJc?=
 =?us-ascii?Q?eI1vgcBzK7XQhmq7IPt4vMcPl/JblxU5KSrqgl5CqfQxZNn3yZO0vJVq0zww?=
 =?us-ascii?Q?2azRzi0xDABPU+LjD/0vko+YJ+n2RS+RW9mcIl419yVry5rd3ALTp5SXK9DB?=
 =?us-ascii?Q?djaefi1EfygknTzlEGnIUjwUMq9msjpCVjFlJ0KjWkEqpkc6+Witu/t4t0YL?=
 =?us-ascii?Q?8VQJgqhbmNgxE+WAnmR+UlxHgMpLVAothWCaahFnzCjCGqXQ973NVcP6qllS?=
 =?us-ascii?Q?Pf4OEiiHBe/BTOtS1dxBkCnrsJrTYyQPyk46epVmmGbl7UWlAhzwuZIVbH52?=
 =?us-ascii?Q?xIpIaGBauonzNAtL6AlLwOVMLmmJ98bRbfo8cm5UiPG7VZrrPeJt8eZDDgJ2?=
 =?us-ascii?Q?cmOmJT3SHys+XAcVNCGGUnwNT7BzReq6r8VtVNLhaooD+P7dRFSzGgstsMs5?=
 =?us-ascii?Q?qBAFZStXxmbjReMVyLj4MBm+cp9eUdWFXHt0TY2mIXQ9vLuQAAJ05KUsc02D?=
 =?us-ascii?Q?umq4eq/EwUsEy4ZfTxh7ZUz0QYfcmT5OMNWEulxzZZsMayRhBeuaYXdy7pJn?=
 =?us-ascii?Q?fqpoI9PLYYkP7mcP44L/L1SYnmU8BGRCbswny0sbLlhXDZ99ZmAcZuJ1IxSe?=
 =?us-ascii?Q?KRfgqebhjOKMao0/bXMahtwh7nI1VkKErffonht4kk1w56HmYmCjoYOD4fhv?=
 =?us-ascii?Q?EJhkorvA9yU83iZAY/Q4n4F7pjAz9DUasBZYUrek3YUC4EGAGC0NkKmTqrEI?=
 =?us-ascii?Q?gpyjDaxCmY5rNNuskiOkze62XfhNiFAVNtIWQwB9HLx5aIgIxWNJXF71xyLa?=
 =?us-ascii?Q?g30ZNZIlEOB9ErqILiOSghaZUW6fpV4m0tcGpeqpSh2p/9zkeZmmXsg6gKSY?=
 =?us-ascii?Q?oQ+ou1vewqZefhWhjcDwhE+DkFZAdtNVnpr3tPiMvfN5qCN8Nb+aRQKNlKK+?=
 =?us-ascii?Q?VOY7u0nPA2+kRhpt2FEjxM4ldCpDTUouBgZHEvjwhIGKblFZ1dcn/XnK6+IM?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L8zIRXB+ucJidKSIBXBuprcS83EDrSo6pFEHADnfd5sn+c4RazGRDQDNF2Ag990gJafn6SDO/VgHDtHwsotya9HC7uWkFRzA5Hrpjm3XDZiKyMb5xavQKQ1vUZc7Os9FNu2g6CR4YSFjb2SHjvqAoj0B0k2jnAhlaJzNjBYMhRPcZkNDa80rcZDv2winVKZSP8rbpejoVvzfoNlL3rFGmjEH/drGitMreS/5FBxwfvXhiiKozFT8p8dJDDKYUhb+rjQMboDTHa9tQ/hNezBpoUH+CkZHxKaiVOU2JRfW4p6B6PlXjkrHDeN7KDs8HUeMY4xgAt6tNchSobhQckzRz9WBpjV+iKGBWE826fy2RrHi5pzHWVtgcUK2zRJzSV8F96HlLE1w4xjf1uIrUVOgMYNpxT/jgYzUL0BFyJavSH0zSs+hhayAgaJnAki3n7Shft6NLp1DLDnt+/IHhZyyEuMhvc4/vGbu5RtmZZjRQKpFGRkcbPl55c+/NRrGDk1GhsS5jg9otLq2Xtpdl+qawmgshZnYw4clpJ3Cec172hycuexl2RQ524kaDovLDeHvSbWQZbRpu7mdwNj0QV3unM7BXe12Pf/L8L4cdyPlHus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3de22c-5ed5-4017-e0a7-08dd5a4c291a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:08:51.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K56rTpRF567gkJzvKaEqydb/RdRNoqnKBgZc3Ndrxiod40Okmx8AVcIXv0t0ODXQWgEvBBnQrlETX6Y1BCH9JNeyoS36VLnb4nj4Yp7EwO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030093
X-Proofpoint-ORIG-GUID: ucIHrbBFuMp1JKpfl8NZ5v2yvHmwAI-g
X-Proofpoint-GUID: ucIHrbBFuMp1JKpfl8NZ5v2yvHmwAI-g
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hFt3XbJzG3lw
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712569.68279@ckDTjAe8RF9ZUBPxqROrNQ
X-ITU-MailScanner-SpamCheck: not spam


On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add sysmap_is_sealed.c to test system mappings are sealed.
>
> Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> config file.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

We do need to add this to the general selftests Makefile, but this code is
fine, so have a:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Congratulations! :) and thanks for addressing the issues that were raised,
appreciate your efforts on this.

Maybe you could send a fix patch? As it's such a small fix.

Cheers, Lorenzo


> ---
>  .../mseal_system_mappings/.gitignore          |   2 +
>  .../selftests/mseal_system_mappings/Makefile  |   6 +
>  .../selftests/mseal_system_mappings/config    |   1 +
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++

Can you add this to tools/testing/selftests/Makefile? I _think_ adding:

TARGETS += mm

Should do it. Thanks!

>  4 files changed, 122 insertions(+)
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/config
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>
> diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
> new file mode 100644
> index 000000000000..319c497a595e
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +sysmap_is_sealed
> diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
> new file mode 100644
> index 000000000000..2b4504e2f52f
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := sysmap_is_sealed
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
> new file mode 100644
> index 000000000000..675cb9f37b86
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/config
> @@ -0,0 +1 @@
> +CONFIG_MSEAL_SYSTEM_MAPPINGS=y
> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> new file mode 100644
> index 000000000000..c1e93794a58b
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * test system mappings are sealed when
> + * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdbool.h>
> +
> +#include "../kselftest.h"
> +#include "../kselftest_harness.h"
> +
> +#define VDSO_NAME "[vdso]"
> +#define VVAR_NAME "[vvar]"
> +#define VVAR_VCLOCK_NAME "[vvar_vclock]"
> +#define UPROBES_NAME "[uprobes]"
> +#define SIGPAGE_NAME "[sigpage]"
> +#define VECTORS_NAME "[vectors]"
> +
> +#define VMFLAGS "VmFlags:"
> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool has_mapping(char *name, FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, name))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool mapping_is_sealed(char *name, FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +FIXTURE(basic) {
> +	FILE *maps;
> +};
> +
> +FIXTURE_SETUP(basic)
> +{
> +	self->maps = fopen("/proc/self/smaps", "r");
> +	if (!self->maps)
> +		SKIP(return, "Could not open /proc/self/smap, errno=%d",
> +			errno);
> +};
> +
> +FIXTURE_TEARDOWN(basic)
> +{
> +	if (self->maps)
> +		fclose(self->maps);
> +};
> +
> +FIXTURE_VARIANT(basic)
> +{
> +	char *name;
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vdso) {
> +	.name = VDSO_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vvar) {
> +	.name = VVAR_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
> +	.name = VVAR_VCLOCK_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, sigpage) {
> +	.name = SIGPAGE_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vectors) {
> +	.name = VECTORS_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, uprobes) {
> +	.name = UPROBES_NAME,
> +};
> +
> +TEST_F(basic, is_sealed)
> +{
> +	if (!has_mapping(variant->name, self->maps)) {
> +		SKIP(return, "could not found the mapping, %s",
> +			variant->name);
> +	}
> +
> +	EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
> +};
> +
> +TEST_HARNESS_MAIN
> --
> 2.48.1.711.g2feabab25a-goog
>


