Return-Path: <linux-kselftest+bounces-49389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ABDD3B592
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E054D3034433
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B1387379;
	Mon, 19 Jan 2026 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8IskktY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hZvRaqNA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212E36C5A5;
	Mon, 19 Jan 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846968; cv=fail; b=qrcZouSJdvYbnl1UPrGimLvm13TC19ROpY+qX0wvnG5ukGqESr7s5bg+EvF9rT21cryULBeOmjZ+xaOv/te1gBv9wuPDWV9JlWPQg3rCAGxvnFv+yctvwf4G/pMk9J8F2AWeULybbvkMS3d4UkC+mXzgS4DGdAeY3RTjLD57bdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846968; c=relaxed/simple;
	bh=T2uS1m4G0XeFbbd6NcplebnGOlyk4G3m1f9DTY7ubfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spLt/xIo/5vcVmYW5MygKlI/1vir3uez1EKR7hRmtFKN0idY+VQIblNiy5mMuI1hnKBKaN3f2Yr1/0/WjcsFFhoIGKAe7Fcou7HDiv8otxrrwslJSM7W0bOYAGq5QMjZbexF5oRIxSLevH5C34vsVdjBNRRltSWqodb7iv2fmis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b8IskktY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hZvRaqNA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDQ0M1341821;
	Mon, 19 Jan 2026 18:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tShFKC7MdT5vK392y87eGqlDEYvmWhtm0Rsy7581o+E=; b=
	b8IskktY3MeuH5nLW4QR+x0dVcIlOdGjru91oDQH023CAKQ5KGW8sUwMn5BglbPy
	XMxrJ0jCqu9x6RbUSEkiL6ycE0+YsdsPQv/jmb/fClSwvspRTnYB/ueRoqXPwXQ/
	fjNKeZBDtJ1JdXj7qGIbRmj0PAwyLtTjv4P8RbmWNtcRccZIdG4raZNp8eYCzyEE
	9E5u7vfw8yFa12H3DpLOvuUWUJcspi10HC61OucFVOxaWxFTtXhn18ibWodh34RP
	Dh5PTPFN7cBxOG/yr0L//bO0fWuDpI/axWjNk1fnXQQdF5toUv1BAYeTZZWQmr8o
	aQXnDvDL4s1GExPbLOx4RA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br170anvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 18:22:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JHwPBl032223;
	Mon, 19 Jan 2026 18:22:40 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcdq6e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 18:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myYTWsrg7uaGIKPiszhZkVJteB4I9T/sPgqWhwR+CPprPlgQP4bplMytIU4jkNo+o8/P73Is6aN3XJcfpJN1/MUDZm7PGZLttdOTkCMRcqbpEJDLmIXOu/SYJ7PNR/sl8J6fZuWOHSwSgAHET0KRce4Hkcv/olOeDKPwSw2AN0zJxtJk4z0Wb1fRNZrO1NAmaX56gXowFLZ9F7R2wmGztZ4O6S0JJGdhZYwtKyeiffh3u1r2n2dvxu/ce3l3KytnjUTBeDk0jSkUHx5KJcYEz8/Hup6ElL7EYyiM94DuaVYslodSpkRKm+kZKNbNHfqQS6P1vA8ZEDfj6pwR7Zu1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tShFKC7MdT5vK392y87eGqlDEYvmWhtm0Rsy7581o+E=;
 b=NhiFME3cuoT6b3pnfYDbXca2XAoyACoYxLZbtyzv8s1RHD/lexR0zPKskw7hEMnZTpymyKAqQK5goKfvs3xX3ar9j6AfJIDjiIb4dTkWtmcVU8cCWw+dcJAf+oRey55bUBeO9tcM3l1ykX++Hice0kZd1Cd+evC9EaoCJ/Lpq63xInTk+C71VHrSah7bfYYxjN+QYaJic0+TzYJ8YrPm7vvgNIVOmpidX08qHjyb55BG1Rk3bwXDePMvl2zbPF5d68xtTS+ifVTxNpzYGIVJjHv6gWfCzdINVBXK+VCwQgE4LKUTeiWt9OmhnieA+PKncVtrdYdzExv5NM0YxIWMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tShFKC7MdT5vK392y87eGqlDEYvmWhtm0Rsy7581o+E=;
 b=hZvRaqNAkJOCCFVJuiqkWpeo6BSalRuvYUTGh4bW+TjDi5Er1/CxmWwIaBUCMgOg+q3b5YHQJwEq2uX8LI8l9atGeVkScmOBOX2K+IsSCPHly6r2EEYb5mX1xPRQ2j1yc/kFVAKcTo/l736TzoANovb8vLIgo8pSziC6bH6Iyjo=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 18:22:37 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:22:37 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
        linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: [RFC net-next 2/2] selftests: rds: Add rds_stress.py
Date: Mon, 19 Jan 2026 11:22:30 -0700
Message-ID: <20260119182230.1296164-3-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119182230.1296164-1-allison.henderson@oracle.com>
References: <20260119182230.1296164-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::8) To DM4PR10MB7404.namprd10.prod.outlook.com
 (2603:10b6:8:180::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7404:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d5634f-e7db-4934-7881-08de5787b907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+p8ETINE3EbB0nGLeF4NlUDyH3FLr3Ig0od4hinxrr+HRcokCXzYeHBJ7pZc?=
 =?us-ascii?Q?ZKT+8M2TJZWxEPstGDDm0xPebt/qGIg2thLby95R8uOLCrTs6bj0JjNc4v/V?=
 =?us-ascii?Q?jaeVJ/LIMjYg9mxSC9WVfc0NFiAiV4+q2fajRCCnQigaDVa6V3A8N+no28SF?=
 =?us-ascii?Q?VWDjVV5yYnX0oWUZq1ar2JTNn+E45v+vsGoiylvJ99OIj2Rswf+X33S7pWX4?=
 =?us-ascii?Q?sMdyb04abMdyNjNQwndGX6MDj0XiXuvcTtblhquuDtL1BWTPsnbbV6rJfV9O?=
 =?us-ascii?Q?0+bbgVo7nT/fgQjgRtcLxmYh+3M6hwZrLE3gMY5Tx6E26mLcQLZtZfl2Ehr2?=
 =?us-ascii?Q?T2SK4vCUEgaBBeAnmCdYuQ9oHtPj186haYeg2738+4eeXobDHTa+D0ycVx7P?=
 =?us-ascii?Q?ZIoamcqS+/KX9HTCz2CQgVS6TQREAJVa+mZmzGHSkidPg+l23vo5PoC6K7Qg?=
 =?us-ascii?Q?L+HB5PZg/45XfwrvlkGTnpC9vi3YzgAPfd+5I1ALJzDzGtkkJSbQsWN6XXNe?=
 =?us-ascii?Q?nV4JLsNXWZ1PNo7KE53hFSc94FYtQWAacLl3Bn29yK/+Qk946OnEuJm7vzGV?=
 =?us-ascii?Q?jMJl1eWqsVl5CFsKwQK9PhvL+VoQTp6zQcOSOY67pHjLcFBb2NQoyXqrAhTo?=
 =?us-ascii?Q?9aTtbeKlF6C6CoQNmC2XlgyPU5AYHqaq50RRfMuOooLvw9rD2aXJoVgT/tKl?=
 =?us-ascii?Q?z2NqFQXLknovfrrf5H2RbGvju3ho4olUIYh4OtBgTEQJO4Dmp2rUVH/CBFpA?=
 =?us-ascii?Q?tZTcrX6XSfAWL+RuKmWSqUsiddKqWfmQ6bprCSjHshV/xvEdRqbQjLTb9l7E?=
 =?us-ascii?Q?IBTvcmGVTBvqIAcIOXl9lpHVyW+PGP0sgAGDlhydOfAp9q2N2iegSU/ozAR8?=
 =?us-ascii?Q?85h0o1TeyHChaLvmutcLC4KWjduchY/4ZWaUVx8NU1vmGtkV3smRb12vVtQK?=
 =?us-ascii?Q?Y1K/4cxSF157OycW9M6QOIj0/jTSdOKX+zu6UXycYq+vtpHLIkQKQCKhNhHX?=
 =?us-ascii?Q?ALZ+y3Lz214tEBpYjisbDXe2EkoSq/5EUIlfrtdrSFGCPBw2xmvh5os+0pLu?=
 =?us-ascii?Q?flLp39nW8nTljVF5BwlHIjYlFD2HKt7m62ORO4alPaXQL+/BKUyEtGnrFBEQ?=
 =?us-ascii?Q?lJYP1ObJaJFx9LydiMG4UT91kUcO8AHX+8fmR2JYO3ZTu9QMdDKMIBvIL5pf?=
 =?us-ascii?Q?KGVwt/B6rk2cuHo1fDLH0GxyPeHcdov13ciYScgJWa/oiIkze14Ey4oJD1Jc?=
 =?us-ascii?Q?oWJUiu8xmhtsKX0WcaH6LKPxU2XfLpPJ4JghiuyALOD36/m+cazdj3CpZXwP?=
 =?us-ascii?Q?fe0Wxui7V0nf+8IciouE3AzL+49R+itnaBEj60TiXbHW0jMEMHBoDK8rQ7Gz?=
 =?us-ascii?Q?eIn9O7GNPqiaFYA5Js8aPTqDjrzg4iVlM7vBnD08Kx87qWqeoQysdLqn59Zg?=
 =?us-ascii?Q?u+Dtgysdf47SPjwkHrAwDJXiKu0NpFj8OKne3m19eqSnsd0h8cuWEVBNKW+r?=
 =?us-ascii?Q?pxiXa1aAAhVndVuzfhpzbvkgZGadb1pL/+QBEwH9d4lgJvnl0pZgpuog+hQW?=
 =?us-ascii?Q?YSbFmLynrbbyvRvN204=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/0w1hM2L9LtMWvX3xXbY86+5beX9j2HBCA75NMfUzcUKkNWnQra6XFQYFB0?=
 =?us-ascii?Q?YgPd+gmxyKXB6T8sYn5owt5q2bIpg38KRzXqqz74BH//OmDB4VlMrlFB7JSU?=
 =?us-ascii?Q?qUMAx9vhx0OudD4NKmqruyCr309t6j43GuNCYPqW/IRoAObmOV+sw6zh38Iw?=
 =?us-ascii?Q?rMeCuUIdqMp0MJWOzU9pAKIM2fwCZxMGK1LEantWgxHOY2oP54PD82h5gcCL?=
 =?us-ascii?Q?VRS7NIwwNcGIqsCXZ3wzGkizqlTzdkKi/3bIWmLR6C92Dq15YeP2eVQ/7uWG?=
 =?us-ascii?Q?68/zp4ZBVc+nMtmvtZuz7f3St8GfgcRMesxZShU2UpL0OSmKhZMDz1lVPZk7?=
 =?us-ascii?Q?W9Kbow9y/yxDmhidRdVnnmiO52g87UG1DrG701PqYBI3sQatuLJDMzYEWKyn?=
 =?us-ascii?Q?DXF36TdRYEcB2wp3VGr1fhPr1Sj79VoaFaAG94zF/Brmpj737/7Ari798TfE?=
 =?us-ascii?Q?G97vKZURPlwIeA2nOdj5+ZiQ7ircC0zsK/MYJ+fLOpbe/pqo8GktwIRgP85y?=
 =?us-ascii?Q?HOrQixM+cAI1czg6nVNtx0dYhqi/Ui/dpMOuqNvv2uogBXScmEPYyyTVSux5?=
 =?us-ascii?Q?ro+pmYNcbx7Y21sLZLJPy2BD8g+M2PA9HXvZtm8u2IUnnbqwQXgaadzbr6iO?=
 =?us-ascii?Q?wI3ykPAoUzSgSR9EFGZYs7TaHprSQikzjoO7aihs5W/RL0bVh5FEFHgupXxn?=
 =?us-ascii?Q?WUA3sqw9z5/5N8/IWv9wJWqV453PM2iRwQFZvLBZ8sj+Ommk8jJ2yFH11myL?=
 =?us-ascii?Q?VPq02he3hgqOk4tu81bMmALExH+XTVN/UNJHEc0/mz/IOYsZzhTGQ2AdF2U1?=
 =?us-ascii?Q?+ZCNT+dFkfQfQ7Q+guXeRhz0jw3S3XGmqBnneVuKAkf0jHG75hFa7t1vC5CB?=
 =?us-ascii?Q?KJTaJ2oKPPUROHGTiuHKGgH/qbSovk+OjxJWLZZdeldZF3X0KfRSSSE6RLGZ?=
 =?us-ascii?Q?IhFbl0Kw4CjJkrMoKDkBJ9XjexdhKNq6SS/ogPaxhM/jMvhEjqFIcMnGKFD0?=
 =?us-ascii?Q?pjGtmmg4a09s1NP6CCF5fHSW8QW/kRCG3SPtmuQg8/L0OOFbcIQOQA39s/tM?=
 =?us-ascii?Q?tXKo3hRTQD4gwLYBeYLv2yyt/I6N0mGK54T3TOkKlts7D/1wqZYuAoUGRJEl?=
 =?us-ascii?Q?fY5NEq8nZFnkXGUJEsyVcnUzkOFyKUO1AHHLDRaZTTgtWy6+En3jNJv1b9lI?=
 =?us-ascii?Q?/EDOM7WyfbwrH4qTLc7BD2vgGFMa6GEx5LQSpH6ZAOZ3nOYyo3U3oE2a3/0i?=
 =?us-ascii?Q?4S361MvFd21CB8c/Ta5DIhuhiH+rudeE8BdEunSYLahCncGgoGNbho3fRVo2?=
 =?us-ascii?Q?fl2Ty+X+KyM/901Sam9/usrTGcX6ATsb3dTZIOAXljCP+VE3WJ7AokUxzQhZ?=
 =?us-ascii?Q?EVK+Dhq9HDHipfuNpfKvwsuxZW0zT8PbG8LXz2qEQ8BnRtQhyM19fYE8caQL?=
 =?us-ascii?Q?l3ViikXmLNbnRk4GD/2XmrQVSQ6tVUTtJ/vNpeI8IxfHc6JfFkI5A7ip6Sxz?=
 =?us-ascii?Q?FrJ/OMY57QhgvUm8wRJiRb3tngpFZ9G0UzbGS0QnzwVybADa9lcBs1jA9e1+?=
 =?us-ascii?Q?b1wL85GsXOkPhU2AX2lBbSDQzP5JFJnoCK0lVod86ySu2jCGax+bBTAwg0dN?=
 =?us-ascii?Q?fz8jFyB29zot7em1Nop416+jPCMwuEqHxVXLD3feSIsSZScmyOBoEFVJowD4?=
 =?us-ascii?Q?2RpZ8gMQquzY0A23Oex0JYxvSssz7Kd8jT/AebKvKLf6Q1JwiQrUQuu7rzht?=
 =?us-ascii?Q?9AWPdnrC4yE0g1MwNfibEAg+qFDmYE0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AH8LJpy89xTWa7EWd+uzsuk55kwvL9+9ZcFAKUMpTI1UsWt/mflAhh8YQS/x7H6uLAbzBCTCM8RIx4dS1JQiOk4xoVK9XhphkkImqralTtDQq/vKc7lwemq5zCqCAya9rskPc/uUhOPvNi2xE9jRS2mcqj3/L05x0tgHO1DJphDzj1RfEkXZ+RBn28tMRoaAi6DeX+wK6U+/d7yqFzleRiZubACwBv77hIss67MxuYoh8+UUeS7JgbSMJ6G2pCbsthKFlw5aUxQPA2nXeU+ng5UVZsrlBn9s8o4dRHZiHuu2o6mE09wrZm2zOA9HfJCcYacM5IKPnbLPLNqE0xFgHKzhFbqtUO8JozuL8myjUtL6blccr4/3UPNMtbDovGGAOk/IchmLjSTJ5YD4FTbu9n3b0lbMy7m8WPRojxYIPZMojPyRB7fkP+cYSpTcW5URC+GB3CpiVj9u1E6/kXxMPNmZ+WGrX+W1NxjCUbO/Wi/tqg0rMTc+kcquYf8aLrxbJGLEXcEf7npBbLZCtPR88elcaQhLZi1ZOCJGgVqpkTbYFGXCk4MXTp6iz+AbFhPajWSVh8/FzBQ3owXCMPQhsIH0GZGv2S5DIrBI5H3lsog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d5634f-e7db-4934-7881-08de5787b907
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:22:37.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0luNXnX8/o5iKISKSkpYQIvFaa8qIgd29SB9Z1aIshTjzUFZ6VXH8PGAPVRUbT/7142MU8jZAT/6Gea40nXQe2ut707rZ7doSNRVExfa1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190153
X-Proofpoint-ORIG-GUID: rCm7FdzQQW9oZBo2QzHA2Aq8tOreP4sr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE1MyBTYWx0ZWRfX7T2KEqjiuVvW
 EabT7LNScg8LSUKPF6JL8uTqR364ZF/qtUnCOwTVkiIMvMqyghQi9IbuXnt8/b240+n5SWVAvHj
 Q0Ywem6BjqnZKA6PFH0eZ7rfBsFcY9ONAyR6OyUSYATU5ZYbznNdOX4OPVAkB+LsSs6PzlbOUlI
 8PGwctTnjp/gr0qjMo3sWP0jthTXOvCOmF1P6PKDkNc3naiRzIh9uXD6TEag33nCFY2wzfLBrkx
 pXGrCWltr5XYq4vNX6CZLoTsJmPcLy/27r95QiiatoPKDqwkmP8rXKxwWj10lfSAtILp/hbNFSo
 n+pbMpe8vGsEVNb/gZouxWM/y66J7BB+CkM35MZ2n02+v2lHiM2H0kGOGxeRO5nvvL2kacp7zbQ
 I+cLXMfkhhdsRaCxyiJk4gkwiTrevnBZuktb9ggSPGqHzEeCABl7Q5UdaEY79ewY6WHkxmW+Vtz
 IgdpLpIA4OFgjAOpNP9VAlBo0rFJQx8+FoWqJEoE=
X-Proofpoint-GUID: rCm7FdzQQW9oZBo2QzHA2Aq8tOreP4sr
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=696e7671 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wOah8M6GQR862QlEiBUA:9 cc=ntf awl=host:13654

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds a new rds stress test to the rds selftests suite.
rds_stress is available through the rds-tools package, and can be
run in the selftests infrastructure if it is installed on the host.
We also add new test flags --rds_stress and --rds_basic to the
calling test.py script to run one or both of the tests.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 tools/testing/selftests/net/rds/rds_stress.py | 58 +++++++++++++++++++
 tools/testing/selftests/net/rds/run.sh        | 42 ++++++++++++--
 tools/testing/selftests/net/rds/test.py       | 27 ++++++++-
 3 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/rds/rds_stress.py b/tools/testing/selftests/net/rds/rds_stress.py
new file mode 100644
index 0000000000000..8a86fa0b050de
--- /dev/null
+++ b/tools/testing/selftests/net/rds/rds_stress.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+def run_test(env):
+    """Run RDS stress selftest.
+
+    env is a dictionary provided by test.py and is expected to contain:
+      - 'addrs':   list of (ip, port) tuples matching the sockets
+      - 'netns':   list of network namespace names (for sysctl exercises)
+    """
+    addrs = env['addrs']      # [('10.0.0.1', 10000), ('10.0.0.2', 20000)]
+    netns_list = env['netns'] # ['net0', 'net1']
+
+    a0, a1 = addrs
+    recv_addr = a0[0]
+    send_addr = a1[0]
+    port = a0[1]
+
+    nr_tasks = 1  # max child tasks created
+    q_depth = 1   # max outstanding messages
+    duration = 60 # duration of test in seconds
+
+    # server side
+    p0 = subprocess.Popen([
+        'ip', 'netns', 'exec', netns_list[0],
+        'rds-stress',
+        '-r', str(recv_addr),
+        '-p', str(port),
+        '-t', str(nr_tasks),
+        '-d', str(q_depth),
+        '-T', str(duration+5) # add some extra time to let the client finish
+    ])
+
+    time.sleep(1) # delay to allow server time to come up
+
+    # client side
+    p1 = subprocess.Popen([
+        'ip', 'netns', 'exec', netns_list[1],
+        'rds-stress',
+        '-r', str(send_addr), '-s', str(recv_addr),
+        '-p', str(port),
+        '-t', str(nr_tasks),
+        '-d', str(q_depth),
+        '-T', str(duration)
+    ])
+
+    rc1 = p1.wait() # wait for client
+    rc0 = p0.wait() # then wait for the server
+
+    if rc0 != 0 or rc1 != 0:
+        print(f"rds-stress failed: server={rc0} client={rc1}")
+        return 1
+
+    print("Success")
+    return 0
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 8aee244f582a3..5917c32222372 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -152,7 +152,34 @@ PLOSS=0
 PCORRUPT=0
 PDUP=0
 GENERATE_GCOV_REPORT=1
-while getopts "d:l:c:u:" opt; do
+RDS_BASIC=0
+RDS_STRESS=0
+FLAGS=""
+
+check_flags()
+{
+	if [ "$RDS_STRESS" -ne 0 ] && ! which rds-stress > /dev/null 2>&1; then
+		echo "selftests: Could not run rds-stress.  Disabling rds-stress."
+		RDS_STRESS=0
+	fi
+	if [ "$RDS_STRESS" -eq 0 ] && [ "$RDS_BASIC" -eq 0 ]; then
+		echo "selftests: Default to rds basic tests"
+		RDS_BASIC=1
+	fi
+}
+
+set_flags()
+{
+	if [ "$RDS_STRESS" -ne 0 ];then
+		FLAGS="$FLAGS -s"
+	fi
+
+	if [ "$RDS_BASIC" -ne 0 ]; then
+		FLAGS="$FLAGS -b"
+	fi
+}
+
+while getopts "d:l:c:u:bs" opt; do
   case ${opt} in
     d)
       LOG_DIR=${OPTARG}
@@ -166,9 +193,15 @@ while getopts "d:l:c:u:" opt; do
     u)
       PDUP=${OPTARG}
       ;;
+    b)
+      RDS_BASIC=1
+      ;;
+    s)
+      RDS_STRESS=1
+      ;;
     :)
       echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
-           "[-u packet_duplcate] [-g]"
+           "[-u packet_duplcate] [-g] [-b] [-s]"
       exit 1
       ;;
     ?)
@@ -182,7 +215,8 @@ done
 check_env
 check_conf
 check_gcov_conf
-
+check_flags
+set_flags
 
 rm -fr "$LOG_DIR"
 TRACE_FILE="${LOG_DIR}/rds-strace.txt"
@@ -195,7 +229,7 @@ echo running RDS tests...
 echo Traces will be logged to "$TRACE_FILE"
 rm -f "$TRACE_FILE"
 strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" --timeout 400 -d "$LOG_DIR" \
-       -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP"
+       -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP" $FLAGS
 
 test_rc=$?
 dmesg > "${LOG_DIR}/dmesg.out"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 1ac52e9c7aaa8..1bb6f5b306141 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -9,6 +9,7 @@ import sys
 from pwd import getpwuid
 from os import stat
 import rds_basic
+import rds_stress
 
 # Allow utils module to be imported from different directory
 this_dir = os.path.dirname(os.path.realpath(__file__))
@@ -21,6 +22,20 @@ net1 = 'net1'
 veth0 = 'veth0'
 veth1 = 'veth1'
 
+def increment_ports(addrs, inc):
+    """Increment port numbers in the addrs list by inc.
+       Use between tests to make the port numbers unique
+
+    addrs: list of (ip, port) tuples
+    inc: int
+    """
+    new_addrs = []
+
+    for ip, port in addrs:
+        new_addrs.append((ip, port + inc))
+
+    return new_addrs
+
 def signal_handler(sig, frame):
     print('Test timed out')
     sys.exit(1)
@@ -31,6 +46,10 @@ parser = argparse.ArgumentParser(description="init script args",
                   formatter_class=argparse.ArgumentDefaultsHelpFormatter)
 parser.add_argument("-d", "--logdir", action="store",
                     help="directory to store logs", default="/tmp")
+parser.add_argument("-b", "--rds_basic", action="store_true",
+                    help="Run rds basic tests")
+parser.add_argument("-s", "--rds_stress", action="store_true",
+                    help="Run rds stress tests")
 parser.add_argument('--timeout', help="timeout to terminate hung test",
                     type=int, default=0)
 parser.add_argument('-l', '--loss', help="Simulate tcp packet loss",
@@ -102,7 +121,13 @@ env = {
     'netns': [net0, net1],
 }
 
-ret = rds_basic.run_test(env)
+ret = 0
+if args.rds_basic:
+    ret = rds_basic.run_test(env)
+
+if ret == 0 and args.rds_stress:
+    env['addrs'] = increment_ports(env['addrs'], 1000)
+    ret = rds_stress.run_test(env)
 
 print("Stopping network packet captures")
 subprocess.check_call(['killall', '-q', 'tcpdump'])
-- 
2.43.0


