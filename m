Return-Path: <linux-kselftest+bounces-49388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036ED3B586
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AA4830230CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8D36405A;
	Mon, 19 Jan 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KHibO9X6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eWFMGwUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619635FF53;
	Mon, 19 Jan 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846966; cv=fail; b=nUOwpD6HmN0IRy2LtnFYZlmj+35N1Q5l5hltylUkJUloHHDg52YcL2T+YrWoH7rHnC7hWm8srKd3tK1NIsZCY3c6Hd838wqsgc2t8cBOFpBEWOazB4jqZ98K5BuKVarGuEo+Dx79T/cnGz++uiMxAHpeKbekQSw2SU+MYoJeWuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846966; c=relaxed/simple;
	bh=9J4bRrPaE9GZioVWTXHeUMA5fIad3gPsX6EGvRuoLiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J6jhg8Q/vBbe9oP6IPy4pQVZTV5Im8GeE/URXZG6xD5+4bUweVVRIZYf2uhgkJCHsCZYH6FvPW81oJEUue8LJt/webB3W0h7kjoofQxMsbS7ufbXOhkt3nBO2Gf/PEG29VpkTo2TajOMFULGiPNCOTeNo/adNDLIsPOHLMh49pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KHibO9X6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eWFMGwUd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBD3ea2082864;
	Mon, 19 Jan 2026 18:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ixDTuZse8to/Ecvo
	/jiJoQzi3sTowARocoA87YZQzaU=; b=KHibO9X6UTQ3TODz0ttg326pR9jbGhSD
	1HnMITzmMuuaujfb222lVx18xKyNH0vi9A8VkoRwFQoUHDwxTnqJdXX/xSkeW9kV
	09ktQxIa3dRaokQjoP3HaK2asMK3QIcdYYexpVH97zrTAA6tEnlHgaICvG3V+KI0
	MNcpB682+otlWc0FGxq+oCbuCCphWGHZPTh8HKeNcc+AIXHbhgRnW+gTde1QsNkg
	K6N9EBnbCNJKKznbqmjYaAwq7EQ+T9Y0UwToJfWsoQMUO5a1oH01aMSnrWci+fz1
	s646A1iLYn/41vZ8dLzeSE1IpkbLTsb9RkKJQUHNC0Mn4ZmChHDaJw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa2n5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 18:22:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JFhuox018004;
	Mon, 19 Jan 2026 18:22:37 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8n5y1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 18:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyLG4be1XY+S7rbv5nHFvWusuMcQTKjCO9OuT9Y0v/Nfo/M8Aw6g36TinnG4vDl/mp5+UBUG0wmvg2GF3fUPlsPcKwyhSJ93kOcTXCYoIwEYWDG+vqMtMjGJHmyTJ4ke9KffkHpXZVmO7W5xP1xPbZ2FLWgBR/Stc9NCeezh1/N6Qquy/tCgYfQ5JB08hWwCwjIGm0GVqlhfIeAFxNc2RK5JvOapAJ7nG7DOP1wsNlnpoXccWtoL8Al82Q/Xg8ZkmaksOlD8kV3uWeXMpqzuWbwp2/Fu0dwZuX5S7mldrQNKglarXNPpMvawTZEGDxxthTVhyafaozmDr12FEQmq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixDTuZse8to/Ecvo/jiJoQzi3sTowARocoA87YZQzaU=;
 b=ZtsqIN620XR3XsVVMrkluKwry5lheawnSdsTbi2qKjlTk+Q1tE969grPRljerYYV4vkyFdgK7Cxj/CtESY8VC9aYQVF7jHyxIseOvWrrxTDNY/c1uj9Mjlso9QLgnWqiiKBmPLk7vWiRVgvVOGdWD1ibld95jBWyEmbIjCnBrChJ+03Yzuh2Ro5XWthMwaxF4aVLZxXWgwb5bm33UzGU3mYzZ4H/SlGMwCcNvDv6xH+Ygsm+oDbFNXLjTDSk3eNd87geIhjTPA2bOM22Ho6nFG7uKdkKKRZZjyMQQrXMJAxr/CThMwg0bzHaaaSpTpSVdU/bQrjgmJxnhrk73U/0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixDTuZse8to/Ecvo/jiJoQzi3sTowARocoA87YZQzaU=;
 b=eWFMGwUd/pjfhmsw946NbDNZuyA9U1DbEkRnQZZGhhEnLmdUbFPFCIchnRzHsr7ltHEJpR1iQkO1jvE/bWr/CbsmKHa2iMi8+I16tYMSCB/23X3jjjKQs5mt6zw1VXrVnVAUwWYHE9GzoymzosAY7S2MYUw2nrqvyspPbaAuE6U=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 18:22:33 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:22:33 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
        linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: [RFC net-next 0/2] selftests: rds: refactor and expand rds selftests test
Date: Mon, 19 Jan 2026 11:22:28 -0700
Message-ID: <20260119182230.1296164-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::12) To DM4PR10MB7404.namprd10.prod.outlook.com
 (2603:10b6:8:180::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7404:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbade2e-5e92-4823-9263-08de5787b69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2J8j2CAPJfLMgqO9LYHeIYglHDEOQgQ6mHl9+ttxdW0MB28hVQSuJKcD6Fl?=
 =?us-ascii?Q?bgjUmFhHzcyihtr4EkzFIGWJXxol4SxT+akxBLDBywNzMkmiNTYdaZQfnA5r?=
 =?us-ascii?Q?heWrvqQdd38+5MP7FEJQlXeSpjOdZFsMieih/ILw/EnouqSlzeq5IF9zLpNE?=
 =?us-ascii?Q?n+fQfhM+b2CpvrHE9N5qceP7nHhsYw/W4cA2gfH6BrN3YzvNNEOsV+waKvVd?=
 =?us-ascii?Q?P+R3FSWE1qjxGC1mFpl5YXtlSdGDby00dwfEowte5lFnm8z45iMvp3Ha35Ar?=
 =?us-ascii?Q?vcoSgj4cuby5XaPa/e8GbpDQ9T+T9aSOzJk0Rp9VeygjMR4d8S+N7kZ970i6?=
 =?us-ascii?Q?2cRX8/7q6AFlk4ez27rdDUAKR2U34ZFUELWsZ3Lf1iQkK+V9mHt7F7U7xI9I?=
 =?us-ascii?Q?IOIU0rbpSkjEbadfyErFv16twD4eAbvjghMNY/VOreQCNsHV05zZINzuxzVx?=
 =?us-ascii?Q?rPmiavPM4csfcBFSkB0aNBPANJksOLieXFZPledHcmMf6MoczIam3VykyMqm?=
 =?us-ascii?Q?TQS6dTfJEK3w+tIqxY//ukUBMRo8dSBmj0RtjGI9tBV+GNBu7FGJhA7Dof/+?=
 =?us-ascii?Q?yoSehv2cMCX73jGu0RruSlPGIqMckL9tYuyoirlwagxjA+ijOcys7JKyWXfO?=
 =?us-ascii?Q?XfQqvP0brrdmvzUwK/7vvMsHLhkkOAayNHEEsr7nKcEeywSsnldtgb075qCr?=
 =?us-ascii?Q?84WhAJawgCP/uSzVdMP7ATsibHGyvzojdfmy6FK2cSJzw3NrL3jwyF8FBY7P?=
 =?us-ascii?Q?oZdYgYV+eB5AFK8Gm+NI7pPN+SKkKIoCrAP51pOmHMB5e3N5vebMylbsnukU?=
 =?us-ascii?Q?ted1Z4Zpxa11JqM4y2/8vgi3+f8NRDUsnR/9XOeQSe9juhoWGfBvhAN/stQr?=
 =?us-ascii?Q?HM+czM/EWgQx0c8tcZyiEmjcnE7uNAjXDK7KdqLkmGAYa5b5PBrDLBKkjHrm?=
 =?us-ascii?Q?cPW/bCjt6X5OylIcnEjYBtyoDGO1xS3axpHfdRKOTcV3bRr/IhHRjw/OaD5L?=
 =?us-ascii?Q?kszqjMDb66XFv71lykfNL64i7HPlrBzCuwrheTvMIde9i7kqLzd33ws2TLU3?=
 =?us-ascii?Q?QeRcsmlw+FYgfKT5t2mroKD3UD3yoEytHuP+sV1y+pWs+LamZ0HpLRyCAdwX?=
 =?us-ascii?Q?qd+aDzsINt/HbJzsD2TWIP7XKZlpOILHH6/ENuTLowq4+0vafaahwUdSflNS?=
 =?us-ascii?Q?G+/diUijm238Z3Pvppti5TnzHp8oZ2Pyc4C9DAUb9Ak0rG+lTallpxBgYhYg?=
 =?us-ascii?Q?6ObvACaX+/vAA3Zw6Vhes6FQvW7gG2chOH/GJzNZhlm5qwJGn3QLQ2x3XoRp?=
 =?us-ascii?Q?5VI8+lpKOxvv/lNYgrwv8Q5Ie6dBbE+7Z71yn8kWop0vmTUlru9/SygaKY1j?=
 =?us-ascii?Q?OI+T5qCxpK5AhS8DEGL31BtS+gwoGK137j71dzFGctx0j1YqKcPU2yoAJd6Y?=
 =?us-ascii?Q?cqDwEWd6F/d7xt9Xi/O/QpYe+Ay973A5SurCU1sF/Xip16cmsqVeBJpjW/s4?=
 =?us-ascii?Q?37EGKVS3I0NNsM9ViWgxVcnat6Q/2qBSrBZshVvVCG8UpXI6DPeQwRgNSvnE?=
 =?us-ascii?Q?RF5qqxpRbtKrEGku3LE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1tS2S0HNhUw7rpxNF5t87iLpI56NxAJ0lLuMCLuTzs6PuyDY0aCx7RhZTkK?=
 =?us-ascii?Q?P+TwnmSuCVleiBLYybZq4xKmPxfI0S3UUqwVTuLs9LpYIBtpcSalb1gbCgoq?=
 =?us-ascii?Q?7h2NNADV1S84KE6y7vw6AfHdN9MLqiLEPMrtDZ0tSKrHqQmY5IXUCq6qQwa2?=
 =?us-ascii?Q?IfFQvvocYwdcftPdirZZgFBQZ18n+Jvpo07HK9HbghMf5VQ15vShk1MEq+4U?=
 =?us-ascii?Q?pHMvkmxHTmx5o0eRxMLWbx6z1McibnJ0ADE/vUkUSLg8O7tgykr2P/6gxBgg?=
 =?us-ascii?Q?IkcRdz132IIpa1CeEKPFd6K3hVeEJk6GO/gyi8PnR5h6c+POIKmueTD9WrAo?=
 =?us-ascii?Q?pJKyFVwoHu/tK2U5wSFiL5b9ZY1ISAIuTEodP7EWZuwJfPCOEiCbydJ7CH/X?=
 =?us-ascii?Q?BT0160rwgonn+WlgziSDMxDSSwH+DK3gKf4nzEnmoMY5UGL1JJ3RP7sb8R4E?=
 =?us-ascii?Q?L6L+JGtujGFV5SJVojpAWL4znx3T/B9stwRV8U6nxR9+EePdjajR1VPyQ87T?=
 =?us-ascii?Q?yQ5khd9t6nU6gUTMcg3JaIybljACFjIdut5q3JbFmR2OmP3c/lqgRIM4eh80?=
 =?us-ascii?Q?GhZ/mSBsxH/4arqkq8M7/5iiWzpm9GRktLRSiUMViSf4y5bvaNRGrT18OZwT?=
 =?us-ascii?Q?rdUFo/At7k9u39YaSIlkjRJ+fIZKTfvWA0SOUsrAloPmYJI95W7/C1U9fnFu?=
 =?us-ascii?Q?FgsCnz0prdJ0eHEV5fnIjrRc7x9fKqq0AXowNVLBtKoFSb2JL+Q9+z/GNTg2?=
 =?us-ascii?Q?4Kvjl1/abDtjKelI2EgcLrZDmdV9jgyJ8wptvx1beVDq3HO3p4v5u34NSEWW?=
 =?us-ascii?Q?Q/iva45Vs6336GLgcghha9CBlgdTuixnjjjiWyUWgQLbk70wYH1ZxJDqRcU2?=
 =?us-ascii?Q?iOOX9njQNXrcEHbMFmrNd36o5gm3D6ahYImuwf+x5tKPrNjYj+1fUFpBc+n4?=
 =?us-ascii?Q?YxNTr5Ty5rwi4bzM4pj65HgAHEzFX9TZJd9L6mtrhHERGzmUMpqrlpd25Kob?=
 =?us-ascii?Q?bo4DNtuNDxhGASSmEiOmrKoVhMwGNKr/UYj7Ynxnd6q+Ph8HrQphUyWn0cWq?=
 =?us-ascii?Q?ZUEunMN9+Ytt8ScjvC1r9pcrmphs/d1rkhmJyLLgY9e+sHFvmXygIbaPA634?=
 =?us-ascii?Q?PqnKalXCPCr2PJQT4QEq3sM2MRjJRBMVd9bE0LOe68uv4/9g//03Hvmda2oq?=
 =?us-ascii?Q?K0KYUkS9mFDm1Y8HTTC/3vobZt8bdJgqJgxb0WyZUvU4PNl0lrp7UxPocvNS?=
 =?us-ascii?Q?e0/KyAS+1WPsvZ3ZiXfcnZ6G0Hciu+EyWeSgRDgnaKHFQt+N9a+m+DkFjGYj?=
 =?us-ascii?Q?Lyd87pzxIaQGmGstemY9jZXM5nVLkZj0Blh/0QkNKFq1E2xrHnTJOGrYytQn?=
 =?us-ascii?Q?vVRS2eowuW5Vw82C5pahzrfdl+HNaG4+mEA6t1aEusYR8G5wtLAaLb2+8c03?=
 =?us-ascii?Q?uH70YIXgAYFc2BUW93VKdSaFUahur2chKSQKAX/EbCql1pfvtLO84fjItqbz?=
 =?us-ascii?Q?HgHNesdrwQ6PQufhLjFIT4LiNGuECe3uwZxEFrz3sKVaNnz88KhJeXrTUJEs?=
 =?us-ascii?Q?NjILxNlNTYRhQ1bFyvgS70bKYmB12f5usvvzrK6SF0HgfkKbRWTCu5gW9vmc?=
 =?us-ascii?Q?+858/i5H0jsyEgtNEt46DUJTNBLeufS6GzklUgt/ryVBEqnABG0i5Sa/Of65?=
 =?us-ascii?Q?KM4MapGgGpohcBhu7uL9NIY9XzAi6z4z4fVajHyi52Wagfyu9S+AXWz1FoQ2?=
 =?us-ascii?Q?6/fxCtTUa+g0AEtVlqyYMVNlSL1+dKg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+EkkQI5SAuvL2DCKRG2g7DVj9y1ncEl9sdMregyFg3AwWODakeT7+o9M1jXPTx5EEFS0WfpcmJyjeP+yguFbwffWAD9z4+bHG76ELJqeefXHzJT7KxUGEeIFMFJEj4+8fTvuYhkqRG6n494gqfr96ieOtJYB2UGJPU2Ks4UwBU0ypOX5Q+GGpFG7RCOPzeU11oyCd1Dr01+kRZlAdxNOLqNAGNAq2SSwecSWrQ5Xz8kD4amoMmSubGjh8ibhOAOq85cddQuqOQxV7ZbyETT/K2Ab62SJnrOjd6kVY+noH9DjUeQVx64IXsb5pUMK2IyasVVDGtDG89sd5yJezd51a+nPNlh8vkxzonxfxgTePkE9rZ7QxJ960ATI1b0PTfB056t21a5NRv42jo6riWgTQg8xCkJ0F9Tqf51OljdhmVP0A1ey846Jd/tRDsByLqKVGbghwksYR1nUHVFHofhCgGC+fLmopV+GjDZ1ynLnTdOo9boogNzzbcG1UHg96svLSKeW6fVrKunqgmKLShS/cRTt4TeNb6xeCbzcZT38cc7t/V8y1hHuswnfDLR+NUA9RSotHuXBzdpJbJ1SOu/X12dj3PNGV9LwLaYnYApQ2fM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbade2e-5e92-4823-9263-08de5787b69b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:22:33.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCGLppq6Z17HnJz3Lh5rkPqm1O7SsbJbxCNI6r3EtxZrIsCxPKGN74tLvQLQyGMBzmGv/Acyl3l84FahUcpXRHpc6f/0fvEKrgc2zwydRIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=873 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE1MyBTYWx0ZWRfX81t6C1+7dc7e
 HDHkWlz3WybqliuVz87yWiosxZCce9IHUYyZ5jB5sRXT1JbYTs9FNpool92Hix+lZ5BRBB2lDff
 p/fkYGaehmONU+kvid0dmqmo8TUwToZy3bfcdLEP8aUjTdn3+Jgj4NcHTJ1sY5GC2FX03lW8hw0
 ulWshJ/kIZTKW6x1Eir4VGoIH14VCfO8zitpPyjs6l92bQcPvMxlPt+ZOiUTiE5ENYTok2FadPO
 dL7kI1Orozf8LDbJtvvHkXP0VsUyNZUcTKfKGpu6Iu06iHdiaOU9r1uvLoQhmF7Jiz17JJ23vFe
 ecIOQml4iqZ1ocOT1KWNsSQoV05lF5ukc7N9L164LlW7jBq3EMa9wK15/TJMM6ZhXcfUokms6Gu
 LgHEqz6tQw0npR3NDOFivZRWYNWcGt4ieHJPvSq8xjcyWsVlcmJONhG7cNT5H3AkNmP7omqgX7K
 JMFLi1izI5r1vPW1lmQ==
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696e766d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=CQ2ETe8rVkLRQgWGSPoA:9
X-Proofpoint-ORIG-GUID: sx1ZJxo6ameeK6m0CUaqNEolO9u12Awi
X-Proofpoint-GUID: sx1ZJxo6ameeK6m0CUaqNEolO9u12Awi

From: Allison Henderson <allison.henderson@oracle.com>

This series aims to improve the current rds selftests.  The first patch
refactors the existing test.py such that the networking set up can be
reused as general purpose infrastructure for other tests.  The existing 
send and receive code is hoisted into a separate rds_basic.py.  The next
patch adds a new rds_stress.py that exercises RDS via the external
rds-stress tool from the rds-tools package if it is available on the host.
We add two new flags to test.py, -b and -s to select rds_basic or
rds_stress respectively.  The intent is to make the RDS selftests more
modular and extensible.  Let me know what you all think.

Questions, comments, suggestions appreciated!
Thanks!

Allison


Allison Henderson (2):
  selftests: rds: Refactor test.py
  selftests: rds: Add rds_stress.py

 tools/testing/selftests/net/rds/rds_basic.py  | 184 ++++++++++++++++++
 tools/testing/selftests/net/rds/rds_stress.py |  58 ++++++
 tools/testing/selftests/net/rds/run.sh        |  42 +++-
 tools/testing/selftests/net/rds/test.py       | 182 +++--------------
 4 files changed, 306 insertions(+), 160 deletions(-)
 create mode 100755 tools/testing/selftests/net/rds/rds_basic.py
 create mode 100644 tools/testing/selftests/net/rds/rds_stress.py

-- 
2.43.0


