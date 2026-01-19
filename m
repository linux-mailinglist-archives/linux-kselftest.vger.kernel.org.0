Return-Path: <linux-kselftest+bounces-49390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D1D3B58A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9079E300DB3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB436CE05;
	Mon, 19 Jan 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IVhyIaz6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XHE/7PLq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48B36E496;
	Mon, 19 Jan 2026 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846969; cv=fail; b=VZI4lSnjCaCsmMGCG32KuIfojiXC0YNfdOWewPQhCSoUWS52bRCoq92RrL3K+zsHcYD5LaFTI1DukeRUc/vYCaxfjSP5PjGaJVgqLol8oAh5c6YjzN1mCEHyiyzzW0/kUvYq05iBCL5siUfHzGSQy0yjr1PdGQML5Zh+mE/Agq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846969; c=relaxed/simple;
	bh=zvFHxtDiBiNZUu22Vn3dzJGeL30wsSBJ3g/kCNYFr24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aESpdt4NztT0rT+OWWfZLuwKr/mb0g3s66GEyTcIVDaxXo2X7I8ZhvVlDTER1rqn8tbBqUNk+swv8Cm99JunxEOtwJihKTUJDb3FzV/QzIjNxviXFdvUrLXz6clA0XjG8a2SLn3oi7/xNsyEoB+t/zSPYHS+2yAAnbB6/UEO8no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IVhyIaz6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XHE/7PLq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDMmK1269344;
	Mon, 19 Jan 2026 18:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nKcWct1zHOAUra4CknpT4geq9JdUg19ALW0RF3EbFUE=; b=
	IVhyIaz6n33uwCKO1/mv0W9JEBFiRLFIXuv8/y8gmn7Z3epLrcoJDQvozN+O9lh/
	C/GwLfX4E2Wm47reyZ7wTVGv+dlB/74nrGyeVqzjreDeGKUrmlo2A1sFV008An81
	Ffo86UWoOTlJuLWjj1XwmofQDQEFDxvBWJ3GI/0AE/BliUSst6rMa7ydpiuRYG7W
	cD9a8WW+pf+BxSEAy2jQix6g7OVorvP+VPaVdds/b1NVcpnguIILpoz3ewknQojw
	qCQ1QJgRUiK1Mh4yWD1wos/vzufsP2yQpSOwnUEBHWVadZfX8h3FunQJWC2/BRiT
	AnTBg+ybnI5FqJ1gXHTk4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8ampg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 18:22:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JFhup1018004;
	Mon, 19 Jan 2026 18:22:38 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8n5y1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 18:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRWCaRhZp3uuM6/U27yVbnAy8/Ll26LxrfPQ7+53aO6FEl4dXP45CI6XwWicUGDGDES7YLqJEsKOWAcQbOkt6p2OKn3JvaPVg8KFjKqWyDjmbopSQ5BlLvhykZ8cy7Dap6dC47ji81ABBzIUDgI8BQjR6o/Jv5yknFppD5a9g8lG//nPlAIrBpuoBdgIMNiJbXKZF0LsDFPq4P1dfZ4dZXSWiaZuZDANoF/Q42HDkXlv4hb2CxeULyxgETClyU9gRBso2nh176LoZAkQwRfbIk+9c/qu70hw3rvlk5OPAjJrfjZlypQTUdIfhla5UlsakPMcXtLaK1EiWVFTxwp11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKcWct1zHOAUra4CknpT4geq9JdUg19ALW0RF3EbFUE=;
 b=i9U0mHbZYdxzVFcFkc5IffDXMF5Vg0I8CqA2M4eDfQbFV5tTiIgHF9/0ZmlPBDeHqa+Ay2A3XMWMW59wKpYIjU6+FMIOBB13uaWUJ6lbIRdagK+C+KNYfMZte9+gT5+hKjRATWr5/tsuSCmH0x2w86VYGVTQemEbkKKpBolSXVHZRxQ4iGTHUi7no25VgypRbEsWCHTJ5Jyk/ZpzQP6AcvtdxxS6TbA1rjp9zBM1QjcKBw4M6xvN1mAob5oT9bs8U7+MRo6o2r+LszBAqaGteX2/LcreRJI4jkIxu3hyTDyeIpZg/pW3aLqhjSiF3ebRIINnhEp1w17M/lULu0JLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKcWct1zHOAUra4CknpT4geq9JdUg19ALW0RF3EbFUE=;
 b=XHE/7PLqvowXMejUNo7emh8JN5aAZORlb4mVRw33raq87ty+lT6CYIo0t98Pb55hAsCOMmCUuOGtAidtUN4lLIUCGFdWyuDrPD93JnytPf/8LFDDMehw50I/yiRFwWF1rA8S3UVKUTSSoo7QzJjyZpJ8TFJz8M//pS6cnMA4yNE=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 18:22:35 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:22:35 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
        linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: [RFC net-next 1/2] selftests: rds: Refactor test.py
Date: Mon, 19 Jan 2026 11:22:29 -0700
Message-ID: <20260119182230.1296164-2-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119182230.1296164-1-allison.henderson@oracle.com>
References: <20260119182230.1296164-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF0001330E.namprd07.prod.outlook.com
 (2603:10b6:518:1::9) To DM4PR10MB7404.namprd10.prod.outlook.com
 (2603:10b6:8:180::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7404:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: b2698c58-0050-4016-0b26-08de5787b7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++1cegxzkdZscy8IQVO2sTv3HPuQ0S5qI1wdQIQuNV9pUUacEV/7wyPe5H7H?=
 =?us-ascii?Q?K3Dk5I1DeRRii2l/fJFeVGHKF4AnXpLSKwBSJBfhKrRcT3wN+dXUMRs75n0Q?=
 =?us-ascii?Q?JNlllXGWjI7jp2SLQlqKLWYUmPRpeTjGd5O3QrbgY5Ml3kIWacWlrACspdpF?=
 =?us-ascii?Q?9UBCzijKEoSejJ79G0+Tgx+kzyZO/UDYjOVSPO18EvB2yEPjgWSpPtofSIJP?=
 =?us-ascii?Q?x/EUIg2C6jiaf0Yg/WP240nUkygNJUtfLeWXlgrMEba5bz4ZwBcz8K0lYhMC?=
 =?us-ascii?Q?yDp54a63fggbSCNK0tnBcJQtAiqusK8pyqaRMxcYZWbnXabVwESvUugW75Hc?=
 =?us-ascii?Q?lgaG33/9mwInleUUdjb9MHEClLRIjQEZgJStho5qAa629lWzpf1Tqkw59rMT?=
 =?us-ascii?Q?pNimNbbBYCkOriTIabEgvT/HvYPTSgYXp8d1tvohQBiNJxiu835L5OkHPsoQ?=
 =?us-ascii?Q?2KCeJQ4Jld1wqXhBxYCQAPmdudvkoO4lJozI1n/e0+oSwDUhCoEAYlwfb2xH?=
 =?us-ascii?Q?QcuE+GUsBj7z+z7Q62bevhbjoW6qpZqI3boU81Po6nL9fVEGbKYeRWujQ+/D?=
 =?us-ascii?Q?S4athwtRSQ01HtvlxjZh3RgDhdSC5/2CcFuazeKEQS3QeDWCspI9IkB9zEFM?=
 =?us-ascii?Q?5YhcmrHNlbAOKG01FYt0SkUA95cngAO3QjeKgjprwaSNjn+qeYubpKQ6EOsm?=
 =?us-ascii?Q?yO9rPctXcLNXVkJesyhJlFbo0k7M7HI1gyYAtPIIv8Lz1LLdKKWXxc5ZDIO5?=
 =?us-ascii?Q?Ur4ePxn39tcjSUH5W8ADMebH25S5hvummwcB8OCgrjULDZFMCRBuI+rb6/zw?=
 =?us-ascii?Q?sbPj2K3iXnNFqX7ayK4pVSUJGnFOuE15am44YMtMx46vnLnDRofTwR/IPR4i?=
 =?us-ascii?Q?MJxMyOkLmhTzNScH12wvml2oHWDzE1iukBAYZSTSwmvggb8lZERRBtGy4KEc?=
 =?us-ascii?Q?dK/KRUQk9OzePVHmvsSnL2jFLfFooqfulXuz2gbeJN+V85u40gvd1Q+hiBNg?=
 =?us-ascii?Q?BUs3jmnYyPSXq8tZvApyS7bBf3/sH/aL9VYLupoManEofZtZKxviS2jrg1fT?=
 =?us-ascii?Q?tVdeNdDydhlS+sKlHQl/uKVb2jK1EmvoyDnBtbHKDDikJzhH3CUnHlHY3dzC?=
 =?us-ascii?Q?JGCxQ6VM1uCwXWg91ZNgBowGvb3f35cNbVtvgpaop7Tb8ZbbMDstc4KNAeba?=
 =?us-ascii?Q?bmyUl5DQH+mEg3jAB2JXrJ/O1XVjkhCrjEo/mLLj0XujpAUs22Vp3ONhlxYx?=
 =?us-ascii?Q?fT+5xGOEY02J5ntBhUwYqomeJi0JPclo/V4lzfXyoa0GevcBqiElr86RLYqz?=
 =?us-ascii?Q?3cssgrRP/Gn6HBkzQfL41u1fWodQ9BrWa+N2vgguMJAej+ryDC+s+l8ix9nG?=
 =?us-ascii?Q?9cjyF/BcmsvaBFRRnYfR+S9+jZE9Hp92jb2heMsCYxylb7CrHh3PRYjwzDDf?=
 =?us-ascii?Q?o9hzM4CItRy2V7damszRGUblTIe9fEaHQF6Pu0e5cl+iSMfa2zDPQouUjDa+?=
 =?us-ascii?Q?GU3w4C1sgfsAsjTL8PjmMNfIBZmKKU765ck+2Nv3btgj0VDXQEDMd9/Olow5?=
 =?us-ascii?Q?J6f2jrdFGUcXQ5QmazQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?++E5wjJDJAWzoXtYxCt+81YvTaVwbIaKqbwG3kENFl91V5dfiDzO2mbFKI4c?=
 =?us-ascii?Q?OijNz+DwgsIMJPgX9ZqMVoq85HNlt1+TOiHzju7A1OkGk+FsnMTWNYWqGXEf?=
 =?us-ascii?Q?G878dYu/icQhKNCJg7a6Xoyy4+RgWur2Lw6/PwADtRdIauuBTOzkKMbWm1Y5?=
 =?us-ascii?Q?CwrEYvyxqYYHn3Om09BFNgnsRHuEfMhBsSPYoYHQYf40gkCSGS0Z0O08Bw0B?=
 =?us-ascii?Q?SAg0QUh8DPSW8VMep+ahiCdy/1Scj7JxNMN1LFxpBJ7iOKQRnQgkCxreBBY4?=
 =?us-ascii?Q?V/oSy9YZQCuzVohs0HOxkNHXbOwBTvLMHZW5NjJKxpAn8YzVst19qJx1j/TN?=
 =?us-ascii?Q?dVy+ToUCCRyPl0aw0SD/78WYi1nVQXTVtL19WarxOK0G7fSZ5VO08ojNzHmD?=
 =?us-ascii?Q?SAav8yHhkiru5UGFHp6XyQ1HOjtzUH7SN3MPYyZ33LjV7xjeWOEoGyqef/1l?=
 =?us-ascii?Q?ENGNrUQ6RWxmcuhXFEeBPJEXeJGilWd/QMT/xJBdP4AqWEOR3JRCt0vJj1Os?=
 =?us-ascii?Q?f+y9RloYqQaoRZrwXyszyqvkKDXEr4q8ftEl03kCQ1rVoHIbtCUNW24CgVHw?=
 =?us-ascii?Q?Dz6z8m+8uVOiGRQ/rZ4ygJYQONfWyVvYDfKOqpfPjhT0x4rskCnKKOneu/Lg?=
 =?us-ascii?Q?ysdXm1DQrR4MIcwt1Ip2UlQXBpNN3O3nsrmJQcm6ewfa+Lg0l30+woS7aw6/?=
 =?us-ascii?Q?Fg3zoNBbTJOks9VXSbNUFEavzUm0Qi+JS1TM9+ZXumsLpWXWGwaNx6LUBOeo?=
 =?us-ascii?Q?PRGWPzaaQTe+DWsPicARUo8h/qAXMRzb1EBojfQhkRwViOzukdqUnOZ3NmM7?=
 =?us-ascii?Q?7V+R9R/DVpHjvZUiGfiRoN0m83cefi4uJZ8lWkZ5ta6U2TMJnpBJy59Idli5?=
 =?us-ascii?Q?+33HjA8R7USwpFk4tqSydnQTldqffC7YhlF7bJPEv3zJ1uZsRdUpxA46Pe7B?=
 =?us-ascii?Q?V1IFYFxHY0jNuXbC7B0jfFTBhZnKoYgmx+Ejkft8BOLqZjN90smNENnPIPlp?=
 =?us-ascii?Q?faO/hZR0LWLAMLyxnBT4EZEaCaZPqOWjbE9vhQ7WY3EGw0bBHcmSr118QtL2?=
 =?us-ascii?Q?MNl5gtDty6XzOoy78AcD1YW7FEYEE7wqdUs/yZzpa5cefU52ZmjKiTZRHpZJ?=
 =?us-ascii?Q?1rxCBqUAYOLP1oNbxO03grr3gSwaH5HSrA1pOVEgqHv/4bXYZ7Rk+E+wDQ2x?=
 =?us-ascii?Q?UOzW/k3zryiKqkzYnTKy59NXB0HUwJXcW2//8EIo4RJPmE5XJvubcKxTmA6z?=
 =?us-ascii?Q?ZBMXiHA4PcWUjGOF6SmpeB6f+vlkH9dNbS20cMIzr83X0XvRlrJqjTxgabtw?=
 =?us-ascii?Q?aaKV3Zsg+68UOk7Wyej66Wpiqfj3sjlLy4dkMd7kKJ88Xz0TbhPSnzK9uzhJ?=
 =?us-ascii?Q?fmF8+sUGvHlhpcZjLjl+hYoCt67Fxx+1/C8sBXHlYpB7iMFDSL39GKUXyi0G?=
 =?us-ascii?Q?21UAImsNA7KRzgG3GlnKVoeNM1vrUEWXXLhMVi50lcnFt1djnrIoAAxyEQyp?=
 =?us-ascii?Q?6IQmfHg1K0cuPyf9I3w5nRnqgaToNKhxMuLJZEl655CpnS6vmM1zgM1B70ei?=
 =?us-ascii?Q?ixbVLh6qA1giZ67OfO9Doj68oH64vR1zMqnPoBdvwMGhCmghL4Zf6lmLxb70?=
 =?us-ascii?Q?/mw7HxWfFg6OjFbOYtsCBxPlYvwEOCyqScKQp3GZtPMUqZGnQtKlbSg0AoZw?=
 =?us-ascii?Q?h6tNvFBIr9igB61JoVmQHQKWdz4p94ZYI3sptI/o/9eoVuuMpmmbWtYzuOS1?=
 =?us-ascii?Q?d5xoY5xbf7Lzku9VP7jRew/3P1Z6L94=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xo+HbRwDhTIxU93pVzWxhR0rq/siw0aFOti3Nhcc7rXXXzKjjaK4l8W3DwKwMw15HkY1+QRK/O3V0VS7/QhDJmn3XQIPM6/7iPN2d3Z6sw+EvWOHCTVR+Lx9jkpk7vGYWh2NxGWCheND/Ui5szGK1KRknBD4qH3Uty+VaSzuCu18QtfzF1zQDHW4T0SyWDT4mRsmbxLSOfwCgs/g/ArT0UclQ5/xVZaO2mN5x/YDbclzyQyXJvv2CbzdMxlPP0734pHSRrt+h/ZThtcB+Wo9DUtzFQsU1CY+RRo9eMzf9wmxhbAFZ4Z/V6I5QaWFwzlbML7Lg9Rdvo2+bED+b3HLQuylG745bz9V+Jzdz308znu4mJa/dhCIQZZH1xXkjhLn/9lyiWVsI+QZ2BfDfClDnHuvog/2p74kOVToO0aYTm2TsYZaCQJojEFyj2QCwix8Hd1li5qrWXsr7vcyLqf2fZoVTNGlWQye9oJgBkNgwndSdDCz5DW12AWT4NfTnbqwWpa7i1JezDN8nxmB0YkvqDuXPg6V/BHyGzKBSdzIEajQAMzvFSaQHHUkg0GnSoLfLQECdWawji5MYEGxY2dXOPlL2+n9V9IRtgGYZEiHkT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2698c58-0050-4016-0b26-08de5787b7d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:22:35.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEcZI4OfAHXiiCbtaRNOsts8AzLY6PImOM6vqeQsOD6cAcPR4x536S7C9W7lZE6ussF5+TYImKR6dr1KnZMlcPb1koALG1vwbCBr2sEaQTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190153
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696e766e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=qMj3VtOZF7H93MODZ8QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE1MyBTYWx0ZWRfXznmljnz32RgJ
 +NE+fk43fq8X0NLFYlFHWp3memPpgThTTTAM6zdU5tyaIPBdjAu5i4wnb1DyJfH8OXedmfbZxHA
 xejqhS4cH1p4FyDX14ooaR575x8Jus+034eSNHrkm5wQtw1vuuR8K6ue9Zm2ZtnyaqYKlLRXKCM
 Vnf2Dnun0AzYuK0u4g+b+ZNGdvQBuCqFZa104JE48OLcDS8/jFFQc/rW8aSHeX1rskUmBrPYM6W
 Fnpv+XG84qTGb4DaxZp35b88ibMl5L25dpp7rpXwUBF7AcCw8iAnSAS2QZs6c/4exLYB3eY6jZP
 e7BfYr0Mt/r366BiJnK8IFgt7kMtxWJnv6J1bOPOlokl8VI6OCAXQme+0l8LOH3KlrRQlTBL+3i
 bsgRSDq/xlQq7zBfmNNA+vXY/fQgC3sjdhczojQucUIGkKkzLs/GIohcrMpca66tTCPtHfMrq0n
 u4+9WUmxyQytC9rmLnw==
X-Proofpoint-ORIG-GUID: BwYJqJCdjS-M1KRwuOoVYXeBrRvUdtgD
X-Proofpoint-GUID: BwYJqJCdjS-M1KRwuOoVYXeBrRvUdtgD

From: Allison Henderson <allison.henderson@oracle.com>

This patch hoists the send and recv logic from test.py into a helper
module rds_basic.py, keeping the namespace and networking configurations
in the calling test.py script.  This will allow us to reuse the test.py
infrastructure to add additional rds tests.  No functional changes are
added in this initial refactor.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 tools/testing/selftests/net/rds/rds_basic.py | 184 +++++++++++++++++++
 tools/testing/selftests/net/rds/test.py      | 167 +----------------
 2 files changed, 190 insertions(+), 161 deletions(-)

diff --git a/tools/testing/selftests/net/rds/rds_basic.py b/tools/testing/selftests/net/rds/rds_basic.py
new file mode 100755
index 0000000000000..f585770f77096
--- /dev/null
+++ b/tools/testing/selftests/net/rds/rds_basic.py
@@ -0,0 +1,184 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import ctypes
+import errno
+import hashlib
+import os
+import select
+import socket
+import sys
+
+# Allow utils module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../"))
+from lib.py.utils import ip
+
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+setns = libc.setns
+
+# Helper function for creating a socket inside a network namespace.
+# We need this because otherwise RDS will detect that the two TCP
+# sockets are on the same interface and use the loop transport instead
+# of the TCP transport.
+def netns_socket(netns, *args):
+    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+
+    child = os.fork()
+    if child == 0:
+        # change network namespace
+        with open(f'/var/run/netns/{netns}') as f:
+            try:
+                ret = setns(f.fileno(), 0)
+            except IOError as e:
+                print(e.errno)
+                print(e)
+
+        # create socket in target namespace
+        s = socket.socket(*args)
+
+        # send resulting socket to parent
+        socket.send_fds(u0, [], [s.fileno()])
+
+        sys.exit(0)
+
+    # receive socket from child
+    _, s, _, _ = socket.recv_fds(u1, 0, 1)
+    os.waitpid(child, 0)
+    u0.close()
+    u1.close()
+    return socket.fromfd(s[0], *args)
+
+def run_test(env):
+    """Run basic RDS selftest.
+
+    env is a dictionary provided by test.py and is expected to contain:
+      - 'addrs':   list of (ip, port) tuples matching the sockets
+      - 'netns':   list of network namespace names (for sysctl exercises)
+    """
+    addrs = env['addrs']        # [('10.0.0.1', 10000), ('10.0.0.2', 20000)]
+    netns_list = env['netns']   # ['net0', 'net1']
+
+    sockets = [
+        netns_socket(netns_list[0], socket.AF_RDS, socket.SOCK_SEQPACKET),
+        netns_socket(netns_list[1], socket.AF_RDS, socket.SOCK_SEQPACKET),
+    ]
+
+    for s, addr in zip(sockets, addrs):
+        s.bind(addr)
+        s.setblocking(0)
+
+    fileno_to_socket = {
+        s.fileno(): s for s in sockets
+    }
+
+    addr_to_socket = {
+        addr: s for addr, s in zip(addrs, sockets)
+    }
+
+    socket_to_addr = {
+        s: addr for addr, s in zip(addrs, sockets)
+    }
+
+    send_hashes = {}
+    recv_hashes = {}
+
+    ep = select.epoll()
+
+    for s in sockets:
+        ep.register(s, select.EPOLLRDNORM)
+
+    n = 50000
+    nr_send = 0
+    nr_recv = 0
+
+    while nr_send < n:
+        # Send as much as we can without blocking
+        print("sending...", nr_send, nr_recv)
+        while nr_send < n:
+            send_data = hashlib.sha256(
+                f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
+
+            # pseudo-random send/receive pattern
+            sender = sockets[nr_send % 2]
+            receiver = sockets[1 - (nr_send % 3) % 2]
+
+            try:
+                sender.sendto(send_data, socket_to_addr[receiver])
+                send_hashes.setdefault((sender.fileno(), receiver.fileno()),
+                        hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
+                nr_send = nr_send + 1
+            except BlockingIOError as e:
+                break
+            except OSError as e:
+                if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
+                    break
+                raise
+
+        # Receive as much as we can without blocking
+        print("receiving...", nr_send, nr_recv)
+        while nr_recv < nr_send:
+            for fileno, eventmask in ep.poll():
+                receiver = fileno_to_socket[fileno]
+
+                if eventmask & select.EPOLLRDNORM:
+                    while True:
+                        try:
+                            recv_data, address = receiver.recvfrom(1024)
+                            sender = addr_to_socket[address]
+                            recv_hashes.setdefault((sender.fileno(),
+                                receiver.fileno()), hashlib.sha256()).update(
+                                        f'<{recv_data}>'.encode('utf-8'))
+                            nr_recv = nr_recv + 1
+                        except BlockingIOError as e:
+                            break
+
+        # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
+        for net in netns_list:
+            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
+            ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
+
+    print("done", nr_send, nr_recv)
+
+    # the Python socket module doesn't know these
+    RDS_INFO_FIRST = 10000
+    RDS_INFO_LAST = 10017
+
+    nr_success = 0
+    nr_error = 0
+
+    for s in sockets:
+        for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
+            # Sigh, the Python socket module doesn't allow us to pass
+            # buffer lengths greater than 1024 for some reason. RDS
+            # wants multiple pages.
+            try:
+                s.getsockopt(socket.SOL_RDS, optname, 1024)
+                nr_success = nr_success + 1
+            except OSError as e:
+                nr_error = nr_error + 1
+                if e.errno == errno.ENOSPC:
+                    # ignore
+                    pass
+
+    print(f"getsockopt(): {nr_success}/{nr_error}")
+
+    # We're done sending and receiving stuff, now let's check if what
+    # we received is what we sent.
+    for (sender, receiver), send_hash in send_hashes.items():
+        recv_hash = recv_hashes.get((sender, receiver))
+
+        if recv_hash is None:
+            print("FAIL: No data received")
+            return 1
+
+        if send_hash.hexdigest() != recv_hash.hexdigest():
+            print("FAIL: Send/recv mismatch")
+            print("hash expected:", send_hash.hexdigest())
+            print("hash received:", recv_hash.hexdigest())
+            return 1
+
+        print(f"{sender}/{receiver}: ok")
+
+    print("Success")
+    return 0
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 4a7178d11193f..1ac52e9c7aaa8 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -2,65 +2,25 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import argparse
-import ctypes
-import errno
-import hashlib
 import os
-import select
 import signal
-import socket
 import subprocess
 import sys
-import atexit
 from pwd import getpwuid
 from os import stat
+import rds_basic
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
 from lib.py.utils import ip
 
-libc = ctypes.cdll.LoadLibrary('libc.so.6')
-setns = libc.setns
-
 net0 = 'net0'
 net1 = 'net1'
 
 veth0 = 'veth0'
 veth1 = 'veth1'
 
-# Helper function for creating a socket inside a network namespace.
-# We need this because otherwise RDS will detect that the two TCP
-# sockets are on the same interface and use the loop transport instead
-# of the TCP transport.
-def netns_socket(netns, *args):
-    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
-
-    child = os.fork()
-    if child == 0:
-        # change network namespace
-        with open(f'/var/run/netns/{netns}') as f:
-            try:
-                ret = setns(f.fileno(), 0)
-            except IOError as e:
-                print(e.errno)
-                print(e)
-
-        # create socket in target namespace
-        s = socket.socket(*args)
-
-        # send resulting socket to parent
-        socket.send_fds(u0, [], [s.fileno()])
-
-        sys.exit(0)
-
-    # receive socket from child
-    _, s, _, _ = socket.recv_fds(u1, 0, 1)
-    os.waitpid(child, 0)
-    u0.close()
-    u1.close()
-    return socket.fromfd(s[0], *args)
-
 def signal_handler(sig, frame):
     print('Test timed out')
     sys.exit(1)
@@ -137,129 +97,14 @@ if args.timeout > 0:
     signal.alarm(args.timeout)
     signal.signal(signal.SIGALRM, signal_handler)
 
-sockets = [
-    netns_socket(net0, socket.AF_RDS, socket.SOCK_SEQPACKET),
-    netns_socket(net1, socket.AF_RDS, socket.SOCK_SEQPACKET),
-]
-
-for s, addr in zip(sockets, addrs):
-    s.bind(addr)
-    s.setblocking(0)
-
-fileno_to_socket = {
-    s.fileno(): s for s in sockets
-}
-
-addr_to_socket = {
-    addr: s for addr, s in zip(addrs, sockets)
+env = {
+    'addrs': addrs,
+    'netns': [net0, net1],
 }
 
-socket_to_addr = {
-    s: addr for addr, s in zip(addrs, sockets)
-}
-
-send_hashes = {}
-recv_hashes = {}
-
-ep = select.epoll()
-
-for s in sockets:
-    ep.register(s, select.EPOLLRDNORM)
-
-n = 50000
-nr_send = 0
-nr_recv = 0
-
-while nr_send < n:
-    # Send as much as we can without blocking
-    print("sending...", nr_send, nr_recv)
-    while nr_send < n:
-        send_data = hashlib.sha256(
-            f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
-
-        # pseudo-random send/receive pattern
-        sender = sockets[nr_send % 2]
-        receiver = sockets[1 - (nr_send % 3) % 2]
-
-        try:
-            sender.sendto(send_data, socket_to_addr[receiver])
-            send_hashes.setdefault((sender.fileno(), receiver.fileno()),
-                    hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
-            nr_send = nr_send + 1
-        except BlockingIOError as e:
-            break
-        except OSError as e:
-            if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
-                break
-            raise
-
-    # Receive as much as we can without blocking
-    print("receiving...", nr_send, nr_recv)
-    while nr_recv < nr_send:
-        for fileno, eventmask in ep.poll():
-            receiver = fileno_to_socket[fileno]
-
-            if eventmask & select.EPOLLRDNORM:
-                while True:
-                    try:
-                        recv_data, address = receiver.recvfrom(1024)
-                        sender = addr_to_socket[address]
-                        recv_hashes.setdefault((sender.fileno(),
-                            receiver.fileno()), hashlib.sha256()).update(
-                                    f'<{recv_data}>'.encode('utf-8'))
-                        nr_recv = nr_recv + 1
-                    except BlockingIOError as e:
-                        break
-
-    # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
-    for net in [net0, net1]:
-        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
-        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
-
-print("done", nr_send, nr_recv)
-
-# the Python socket module doesn't know these
-RDS_INFO_FIRST = 10000
-RDS_INFO_LAST = 10017
-
-nr_success = 0
-nr_error = 0
-
-for s in sockets:
-    for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
-        # Sigh, the Python socket module doesn't allow us to pass
-        # buffer lengths greater than 1024 for some reason. RDS
-        # wants multiple pages.
-        try:
-            s.getsockopt(socket.SOL_RDS, optname, 1024)
-            nr_success = nr_success + 1
-        except OSError as e:
-            nr_error = nr_error + 1
-            if e.errno == errno.ENOSPC:
-                # ignore
-                pass
-
-print(f"getsockopt(): {nr_success}/{nr_error}")
+ret = rds_basic.run_test(env)
 
 print("Stopping network packet captures")
 subprocess.check_call(['killall', '-q', 'tcpdump'])
 
-# We're done sending and receiving stuff, now let's check if what
-# we received is what we sent.
-for (sender, receiver), send_hash in send_hashes.items():
-    recv_hash = recv_hashes.get((sender, receiver))
-
-    if recv_hash is None:
-        print("FAIL: No data received")
-        sys.exit(1)
-
-    if send_hash.hexdigest() != recv_hash.hexdigest():
-        print("FAIL: Send/recv mismatch")
-        print("hash expected:", send_hash.hexdigest())
-        print("hash received:", recv_hash.hexdigest())
-        sys.exit(1)
-
-    print(f"{sender}/{receiver}: ok")
-
-print("Success")
-sys.exit(0)
+sys.exit(ret)
-- 
2.43.0


