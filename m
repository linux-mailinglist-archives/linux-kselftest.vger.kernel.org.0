Return-Path: <linux-kselftest+bounces-35295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6107ADEFC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5495D7AE456
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE62EBB89;
	Wed, 18 Jun 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECOKrjt7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yAGv2e4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045F2EA746;
	Wed, 18 Jun 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257392; cv=fail; b=KWLhFqJvLwed5tuQplpbIazuBA4wA31wi6v0Z4pHLWNOzkeYsijJtwXWkx6i8HszzOpCuR0wvhCuDAwO1P5CgMLNk3V+V1huH9E1qy8hCEE7w5r+uE5eo9AhVLJhJCaXndF4zj4XMyI5E15dPT+M7fVw0bU6FDhwlebjrenWz/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257392; c=relaxed/simple;
	bh=Q9K2SuOL+0Zfr/kbjndNqGfFTWhIJ4aDh6eaD/ifdes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UAIlxTfGoKhrrLFP8hwnlX+h4QU6bgNHk/rQJmeJyyR4rr9zKglW9S1nO5NwmBSd2nn3H9DJA4odGrduJV7Q9aFJmubP6kQlNnuLxxQr52UT7zMwqmNPrIdjU+pdSqR+79RQ+155QQGYBVk0+4PlzTCpqwjGEv3HMnVUni9HpvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ECOKrjt7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yAGv2e4F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ICQ6dL007787;
	Wed, 18 Jun 2025 14:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=my5lDlGLN7SgoB+cqy
	2IwlZITaFrRmL4emU1TcbFFbs=; b=ECOKrjt7VwFXBhg7DwYtk3F2GuQc3ivwfr
	fumRzGTzlQP3nbye66ZrizZEYQdsT2SKFZ3gSZvPwSYeuvtTQdb3PZiZaJq+ZvAw
	x0vLDhc1MiTRPRB2I1qGcQ27Kpffr6nT66GJuaLZFMjBPKnykeUkQvAIXBbu5l4Q
	y5kE45js2S/9fC/RkSmGLCC4ft05hFRxEU1lMgDwNGLQHCY3uCMjudt5uo8+MLPm
	zuV17syHFAX0OXXZ3/u+OiytfU0QMsM0YB6fteBjFJDv9zIFXXpHKRnlTAOid/ua
	g75HVLoL3qTapdgQIrq0EQ2vNozDBXbExeoe3F9MyPJcWI+kDsRQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f009y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 14:36:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ID3IkJ001519;
	Wed, 18 Jun 2025 14:36:03 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011003.outbound.protection.outlook.com [40.93.199.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhar104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 14:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcxryIchxqB4ssim62X4/01UAkUaQNwJAX8SWuupyRrNmGzHJYKlkVHtZu3nnL9mG5PI1/1IxKY605JD5DBcsG4oBJfL4wUewDnBOFTF6WRbGDC+FIHrX4wfhihVogGbg+cCnefU3Riryb6hneyf0oG2KN8ge6Cur8x55Hk969lmw5ifNWLylI7EV4t9v9UVuAFBdcIHT5+3xwh97w4aGt4YBLcBgWPfHrkARtkANutPGyYpSjUNJcLjjvRhOml0jx1qLiE9pv5LDAo6cus+qzEVgNL34cDX/DjGxDFkhSrmQ28rHHq/K+aLmnGNkOmfkjkUx1jmz6GTtA7IdeCK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my5lDlGLN7SgoB+cqy2IwlZITaFrRmL4emU1TcbFFbs=;
 b=UzFm0dKG+JQKQETTHWBmK+7XiyLVdtVN3Uj3jwokAPixJfhGluv5+SbkajFzKDcDCbbCkw/wS9IJh5laDY6VJXfWRFRQK36KsWSwye8f1JEGQzNFBGKghOy5F/TrmZYVkY3dBqXpObSeSC6Hujg9ozoP/3HyCp1NdxxEIhIBUqWCOzQ9IzejKNQGZNvDQsm47yA54q2nUf66D086wbYqZ2BRvlr+iVxCqMglDfk8sCEyUmH5FzH2zeBdUZ8OXuhCJiFngRANAXRRgf2E/H2uyDIUDnIbSyTp/PCJo0ikQujOwlRzuok2TKPLJ1Hn5DkAfPN6+Mg5JJosYE0gfeuiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my5lDlGLN7SgoB+cqy2IwlZITaFrRmL4emU1TcbFFbs=;
 b=yAGv2e4FHoTAlK69UK9Zzf25D9nRGEpZofxQbKPYtj3j7PtBCiSge2VR6ITBQgRNHR3IInqHCM7bRtrN+S6yn+Zk+kEXJl4EhGdFnLty0Y4RQMthZOvSWWYYi3FVAJr15Sgi/Flfh0d6T4aZ9d4poTuD2AKFAfFSq5Aqdnx3xEM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 14:36:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 14:36:00 +0000
Date: Wed, 18 Jun 2025 15:35:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
References: <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
X-ClientProxiedBy: LO2P265CA0357.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d88ea0-3e84-460c-2790-08ddae7571fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qmQPz0ixY1z5aduHECAEXnl0anJ65K4G5Njt2HEPdDLD3vXnKZ1/yN+CFTTg?=
 =?us-ascii?Q?zXUOmL5gnFCrJ4kFXCmPwuFFv/xtJ3QHbF1hZoQYNtBbyyRJSWSTnkDoPdzE?=
 =?us-ascii?Q?LsX5c91YcO3xp0ZXEgRDD+eJy4JMnENYI3ebC9MSMcQZY1s01K4lSwvntWXC?=
 =?us-ascii?Q?ssR2FyJFx9QAJvNJeV7lUTaoTXgDKYYUhXPhdGXg0LX9b0cwX3125qOBB2QO?=
 =?us-ascii?Q?rNicsfg4DRJTT1en7zxBOwNFiSyZ0Kaiom04ndj0q8pZ6CbuE/uhnqJVj1tH?=
 =?us-ascii?Q?pa0IZjVeSzIBm6GrrTAjyvycN0/dISNjI/MowNVPclazrDGwJrpKEpeCgWqz?=
 =?us-ascii?Q?iLVxcUv26KjIuqGvNpKROKKyxUdQtV8h0dxwH8e6qfxW59ZamHX076RRIIg9?=
 =?us-ascii?Q?LF1aWacQyiDFTc+tmQhW5R6rLQJ0YtCJki0GR//UM9am9nIFK/1lz3tM+wIw?=
 =?us-ascii?Q?k9BFQfgEtHzu/boDLFZa2//EwcWnWAl6Ldjcl0Ln5dctkdGrbuyqFifrvUwr?=
 =?us-ascii?Q?ui3IW0ESOVdTmnfm6XP9PnK4BWGR/GMOn2NA8vEDvOGfRTJ+ojJvgYpChX+8?=
 =?us-ascii?Q?w1ntzkO2zJWRaGKtwi4xAFs14yscUiNbhMMw1rGG7CDx29OSOqp3+XCbtsyV?=
 =?us-ascii?Q?WJXfnG/J6xDHvqgnzNZC5SkNJJo/+t9mp0xnVoZ1ypkxFjze7jkklKGiMny1?=
 =?us-ascii?Q?qh7MX6xbGlIx84cAoIm9vFfoN7gklNt9nnCqq8Ffn4LrhJx3G5HGqYVIcstw?=
 =?us-ascii?Q?QzAzwOKKKxhzjFE4rgxDLYMCxNH5hER8GnTT+8v0Yb9tYwpZq1i5jbbHxGsO?=
 =?us-ascii?Q?9bYq3E40IBaGE2vQzQ71IRCZNbMDTExCGzAYMmc+RXCQnfIHXclqSyDdYPT0?=
 =?us-ascii?Q?T7Zb/FCRIbfD/sS/WnoES3wn6ecNii8XVAY0p5r9nfEXi96qTJh9vdQfhU9g?=
 =?us-ascii?Q?Kf/BnSwK+P/NLMDwuaq8pp/mGGnrsruBWC2U7UTbuEApFuBraEiZy1u1yDSF?=
 =?us-ascii?Q?J68jX9zvJGsd/eS9qG2ZMPiKvKbWMTiSNXL/nCMSS16LrAbybxd4VKJaloiR?=
 =?us-ascii?Q?hkI7+GZd0P87tREXUCACkWFl1GvdppcuwdpMoR1Vzup0AYgogsBuYh0Yq6H1?=
 =?us-ascii?Q?oiC8lAGCaUKtLbJ0gD86Mn2NZ6l+0QsW3C4G+7D997S5FYV4g4HrTG9A3DuY?=
 =?us-ascii?Q?bvm9hAkN6NJ4iF4aMhikSn1reRy6iyDdpaokWhsXaS+QlkXYDbIMVNQ0X/nm?=
 =?us-ascii?Q?GHoaWDNsrCxakYECq2A/BC7dUmIwIKI7PBjWaR4Lm/2IgmXGP9TVYo+F5sML?=
 =?us-ascii?Q?WhILw4YisDHC10VfbEMtDR/u4jZ9ZR5t+2z5VwmnQpwbKYhTJdNOs1u3yrLV?=
 =?us-ascii?Q?uPDOX1aDSXPclFSEqmykOldnIuGU4KiExO1lT64K3AW5kJanpwk019GiXUwY?=
 =?us-ascii?Q?9iNe7ilgYCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1VJ4iyp/SrmKS2Q2ux0jZvZ16HzWxj4FnRT+p38oFm7ueUkNHLtcFcEWLbtC?=
 =?us-ascii?Q?QPYGANUGZHyCeCT0uIBQoXmRmO5moumt/ynllcV+8CEceTb5MISdBextE4Bl?=
 =?us-ascii?Q?r+cEC2AbD74euXOF7ophnSb+yMgS7JKIPBWfH6kOByLJ8Y0FomXQL58Rh6fh?=
 =?us-ascii?Q?nEWeZKgpEFiM9wryK89R+dD5+5CU1gyCHhOtj/0XEiODMQcMlPKi3jt5Rix8?=
 =?us-ascii?Q?vxg7dYuIruCjWFvagvvZVin+3jcBQvJjK3YnNmNxVmc9LYLr5qddo8p5atd7?=
 =?us-ascii?Q?n0V6lQX21uTdxWhQz7jw7I09PXhjWCbzSLSghBAIsgjboltjf4x0srlcQKTi?=
 =?us-ascii?Q?jo47l7vSYEuTaudUv36wOcoxv4zSP9rtL+ze7UsP3JJKotOxdcqxP/Vy0jug?=
 =?us-ascii?Q?k7evgZU8rzR9FGDZWz52K6uuD+p+fHzSpoxklPmx+L2Ic4RrOH5XptkzFhfh?=
 =?us-ascii?Q?FE+PgF/QyBq/M7eHDn6Skjp0yLxIbAOyK+/eirLXE98xmdm96R0rpwBZ/sPx?=
 =?us-ascii?Q?sHInx2DwFATwJohIwvlVMamB9JYCU6eM2vTVRirSsXsc/k80y9eQdVjoSJxq?=
 =?us-ascii?Q?yJoTndOz1eTVJg13K8eowhQ58UpNl5skMHcZVY/2dtqxlgZDjZOyuf0JZ1LP?=
 =?us-ascii?Q?HW/ZKht+2jXjglc8iRcf5IBPjm0ytddJJuZsbb+BssggCxyul5j101J2Mb/Q?=
 =?us-ascii?Q?FrTK2Lqubk21ujXoV/Qf0tEifYvbloD0TwO6yyDhh602Iy1546c+YHw3A2oo?=
 =?us-ascii?Q?VRtBEme45h+K4SRp2zUZPL12oyJs+uTUFqPChMBlVMNN4OYHt0q/C5CzXyKD?=
 =?us-ascii?Q?ptAH07zgkQH3Z3CNZvMJH4os7m1sZN4db2PYnSysSMEbAsU6u/ce1sQ7hC1K?=
 =?us-ascii?Q?lazX1r4eyem9lwgXReUC9tfrYGYbiAr5CVUKU/bk60UIAdrAGwt2w4pLGXcU?=
 =?us-ascii?Q?wm09P1aiGP9lt6MLY7JxQnWbwNOUzCdevng15gLkG4crp2Wc1GpNbn4GPj/n?=
 =?us-ascii?Q?Ot86q3kIPQq+JqQSzmf/p/CjbcOlCI0gRS53ArsVgcVK9pvPuQVhup2llMcO?=
 =?us-ascii?Q?ZlyhcZaGVwAoC+QhckaBLSXQ3TA298t/5obLiO8wTrmK1N/DGSJaXbM2atfK?=
 =?us-ascii?Q?/QNs/eH7y4yqJ70hcupKjlQWBmggWbSExcu0kRwIOAmjSTh/oDAMko4rRFHz?=
 =?us-ascii?Q?oEld4UzykFMtETGpeQ9Y+H0muUxVDIZcRYaBaquymERYW+BbVXbkHS1D6wwz?=
 =?us-ascii?Q?NkyHA2+gBXheorr3ygY69UQeU6UWstpAG3W3wS3IBeHtu9KTLM0Mb+Ls/eCl?=
 =?us-ascii?Q?bFld37+cNiN6GjfOMIe1yRgrosisj2nbdBI9Q7qPy4RLuDgqnD01HileZ1S6?=
 =?us-ascii?Q?WjKkKRzdc0kxmChjZfF7F1ZiGDGzEp8SI+y1jcnqz8hWFoWjYbFThFVXDV5l?=
 =?us-ascii?Q?2tF717yXmPoKKIyVa+RRP3f51K21Obyc7GwOWUEAQqjWePaLdQCm6CtLVBcg?=
 =?us-ascii?Q?AN7cni+CD0qrlsHC/Z/F2Z5TFjuEc/r8Cdrb02DQtAPa4eeOOjud1W6qralI?=
 =?us-ascii?Q?dwLs+I/6NePTFwSHCiyDBY9EM+DyQQp4GKoIpVk9JJUDGAzB4N4IRPPxYyPA?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n3M0J0rA/9z9YVNPn1oo+p6iktO4oHbSzxyKlx3qZBHzIm6BRwoDuz1Y36HWAnAujhnewoANJCkZ23ekx0zJlj4/dKW+xeDEjbnQKLytnkeWobzHzESwolyKMMcRvvGHG1FqqZyK+QEX6yeXuzuYhzDW7PELp3y8W4fDrcNZy6OMooI1o28jgvVumxhb68bKPZ4uw2Kz97oa6CZ28X6Nv91UK8uRg0IFUekXV96rsBZ+z3nhAQmEZ6+jBQI2euDs0xOgWbPWIhQZtlg2V0jExxLfCFf3fpmXpTEvJKSqEICpulRBRw3gsj5zepnvvVhfgosN1rCwYWCQTlCAypTJX8YWlvsgFgEzz0DHYj9NHG2MQ+AZTxhVMhmhoHawbcb8+V84VbfcnShJU7+u2xXzsFt6KY+TzmbPFYHtiPWst3/VXIF4PfFST4hUNSQwWr7gcqUD2IPiEOuxmj/ifFVnK/LQV7sFETQid70TKdngYopWJFJp0CT766O+XGF0BhWO3snjUGJSV273pbikO3x9g08/FIOoq6wa9sxnAMRBra/BoxVqhLVx6UEPY6y3n4MTSShUfAxGBULpCFh5QkofpFU3uHmbladj0PD46cy2984=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d88ea0-3e84-460c-2790-08ddae7571fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:36:00.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG+ULsXbA4rHVzYi2vjl+2EgawTVHGb2AqN9zXu7+n0vCgQuHvpPneocxtcG4kA1Hwa9edA9HKnisxT6+hGY3rhOspQPtxTEjpxCrLb7lOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEyMiBTYWx0ZWRfX80fJ19vHzc4n hwvWm7qGfI+i2Kt5pXzUanKzNnz37HJt9Q46gDvIF9StdFCHdPMd2RPRi0Gieb/F1QVDKA5Zcn0 L9/kpIpvEDWnEeWXi/tUvQwZ0dBYsqM+X0L5NhisPFmP4WSaFjnKrnyd8qTF04NgNBywCJbAW+4
 nFLfYazJV8+qtkjrSkx2BExT/qNV1fJgvEh5yqPRTTqQZPlU+fMn7FVK8u2N4F3wDUS8ErYbAHu eS4cED2ghReOJiR9/sjvzlTab8ubr60rUgP+A0etnOWh3p9woZGOeAw4LJ9qY1tu9KvH7j298o1 oZBPGKQQmMo/F/6sxOoa3M/yKP7j+LGNLnWz+WyX/xBILvxWbL43HaC/bp7xUqW7OtZPIYan4mC
 rildXRTXZQ0L4ueyan24hr/oY4a0anQL+ok9Ij0Ou7E2N+A2i9I73KZARZ3FhiKo/vaqxCEW
X-Proofpoint-ORIG-GUID: woa_FzxMBSGot6fyDsSeWhZjVrT1w103
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=6852ced4 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=sa3bnzChzLWbDgHAXNEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: woa_FzxMBSGot6fyDsSeWhZjVrT1w103

On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>
> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
> > On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
> > > On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
> > > > On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
> > > > Are you accounting for sys.max_map_count? If not, then you'll be hitting that
> > > > first.
> > > run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
> > Umm, what? You mean overcommit all mode, and that has no bearing on the max
> > mapping count check.
> >
> > In do_mmap():
> >
> > 	/* Too many mappings? */
> > 	if (mm->map_count > sysctl_max_map_count)
> > 		return -ENOMEM;
> >
> >
> > As well as numerous other checks in mm/vma.c.
>
> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
> this.

No problem! It's hard to be aware of everything in mm :)

>
> >
> > I'm not sure why an overcommit toggle is even necessary when you could use
> > MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
> >
> > I'm pretty confused as to what this test is really achieving honestly. This
> > isn't a useful way of asserting mmap() behaviour as far as I can tell.
>
> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
> to discuss that but if you'd like me to explain from start to end what the test
> is doing, I can do that : )
>

I just don't have time right now, I guess I'll have to come back to it
later... it's not the end of the world for it to be iffy in my view as long as
it passes, but it might just not be of great value.

Philosophically I'd rather we didn't assert internal implementation details like
where we place mappings in userland memory. At no point do we promise to not
leave larger gaps if we feel like it :)

I'm guessing, reading more, the _real_ test here is some mathematical assertion
about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.

But again I'm not sure that achieves much and again also is asserting internal
implementation details.

Correct behaviour of this kind of thing probably better belongs to tests in the
userland VMA testing I'd say.

Sorry I don't mean to do down work you've done before, just giving an honest
technical appraisal!

Anyway don't let this block work to fix the test if it's failing. We can revisit
this later.

