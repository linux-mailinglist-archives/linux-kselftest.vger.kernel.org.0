Return-Path: <linux-kselftest+bounces-33925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F6FAC6631
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3971BC4972
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8E27815D;
	Wed, 28 May 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pN8ih9WG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w+b/uJ/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E53A2D;
	Wed, 28 May 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425588; cv=fail; b=Ip7H6XIDhbR+opqmPUlj2PuK6iXaF/Ahn3jA/WF9KRZb4XeY00qO3NCSrBzLUFFQGD+hWzuF/FhpEIDUfsexcnQjRYBexKLnZ/rLGqky2UnziNWnuFUdiZlqAJnEeW46QvVr6wpzily3mHGKDoKrNYLT2YofZXcFmhxxBmE51Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425588; c=relaxed/simple;
	bh=AnQoe46izpxHqdacrLDMPxEccAijb3TjkgIjtfaZg+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RNQR6CVNCeX7dc2JYZb3jNCtkYSwFN+KUpft/O7S+azJt6ScFn1KXf1dJtRJbrM8ckqLPolJZsCeRDwpqx0mXrMO6hGpG98YZH3Sg4QezZaczhM1wTQTiH8LIJb2qbaeKNwfdlxU7pswkw6XGvven4Dzx3fFyu6khH5dDXRtMWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pN8ih9WG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w+b/uJ/T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1g79q010495;
	Wed, 28 May 2025 09:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gUvHhBBL/B5MUjrUao
	IrkP8D6GUYpWpzn0LSxGb2s9A=; b=pN8ih9WGOp0oFhQVLsj9kJRVRWw7dRSyyr
	k6UziZK2JRylZRc9mRhpnVeX6CWa0JotYUK56KKIHs/0W8vKhBHtM7kX42BhEgio
	xNS/RANsjNHAIX9kTNFjbvwcuyVwZDbB6cb1zkNSMZByjFQ6zYaDZ7isykm0Ht3D
	OWdckjblbtFCwqUAWzmQaWUy8+Xp5XB9bjdIHoCGFDGVky57iGIHMrWGOvs0R86u
	/1EgdyndcHj7WbXqxqCwqEtVzmVUo1lydXznV6NuSqN5zfbMwxuMm51sEmQWOh8v
	7zyosWF4+nXr/TlzGMJY/Jblr8D4yei7u3Vc++o9qCKtTFfjQaZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pew8up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:46:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9XPKC007180;
	Wed, 28 May 2025 09:46:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jae5ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5YZqPa1hKnkjz0c6i0Z1f2HQsIw2k6/XFqqa1ZhYX+beR4wnxGJItuSFSPcuR5ZRyTycbhrDbEROTFxvKKc/MtXkBFotFlzsNpJXv7Pr8Bq+9/pPRGNjuvbyrsuXVnOnjlIccetE7iLngnFCvjah+K0u9cMVibmJyfb/RZ+WSlbfzLTkCFogMGb0/a92Lf72eeVd2KzKKcoIW6SDV9wKNGGzL3eX+xtbhyS3Z6qI/bDcaO+6NaoIcWTZ4+enPWQcm6X2zFMb737btyM7IKQgiaRtppqqbwEL+1Mrau4PuR0JdKG3xaiU2wG0GWOyfif6HKBYkeSvIdoLSPudVyx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUvHhBBL/B5MUjrUaoIrkP8D6GUYpWpzn0LSxGb2s9A=;
 b=RDSwCU7k4eSOIkOYX77Iz0RKh4L1Qti48x8bUnZKce1HtLnzFThjE7aB5lr8pjtbNjCzDwXSpF3ThmqI1KB0rVx0UnYHl6kaLDEz51tdt8ImIyWimlh/jOssaUiDxJk+Bq9o5ylyg/ezelw6Mfnn1exCHju/jVWNAn7blkNkBs2Fs/ZN4A9PIGd2wB3YnoOKysHg7guQjyWehxPdy1fzENjAfCp0gJpOEa9a6NhrTXMIFx7bTpk1kR7vDn6BgMYnMdFfq8svjTCryw1HFk7+77RdsZYmtWgM9Bc+6iwnlDJf+v0PCN4gmDasI1yM2aQjCxJMwXQTBb7FniPZAKCRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUvHhBBL/B5MUjrUaoIrkP8D6GUYpWpzn0LSxGb2s9A=;
 b=w+b/uJ/T/OXWbCV70Haz625JXGVu1sJ8spH1IUG0bPQ5E3mHsIzKbaFR2WtNTqPVmfoSSbekWG4VbIpaQj8Om/N/BeGMby+m47L6o1fmFQXn+p6DVLEl7lDM48mDkkzdJjU2qPmZMcC4JMfw8cmE7o3+461de5gPGGnHjuNU0aE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7731.namprd10.prod.outlook.com (2603:10b6:510:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 09:46:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 09:46:10 +0000
Date: Wed, 28 May 2025 10:46:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        Yeoreum Yun <yeoreum.yun@arm.com>,
        Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] tools/testing: Check correct variable in
 open_procmap()
Message-ID: <2a5bb577-375f-4b97-8375-8639bcbb1144@lucifer.local>
References: <aDbFuUTlJTBqziVd@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDbFuUTlJTBqziVd@stanley.mountain>
X-ClientProxiedBy: LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: e63bcaae-1544-4b26-bf4f-08dd9dcc79ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibNUQT6OiD04XKR2i6bDBtsSuhrkkAvQnC6My/Z8mlagEvNLFep2kE6qj5qm?=
 =?us-ascii?Q?fldDrxLKFHhJyh+ianKlQKGY0LaPAjIOnix1sr7C6HW80+BBRzvIjVVsKdz+?=
 =?us-ascii?Q?MqBa4vhCuG6KrduSxfs+8dFOt2G2VyRwBKrdTPks6Ck8wXxXBbg1fjtNLNuI?=
 =?us-ascii?Q?IA8xAlYkbB/RcW/u9zZPB38J+pSEcYEaxeS06BLZf8pSBHgra777oZHdpB2t?=
 =?us-ascii?Q?VISxLcqH9hHzu6Gvw+Xe9yZXmTc0yuM2nzrDdmotSOAdjlNVyg/kbQGmTe25?=
 =?us-ascii?Q?mqJpNJfDXh8lWkccME4E5VGGqHb4pCVwNtm2prTYSH13sXJCPaseOiCa3yGe?=
 =?us-ascii?Q?8gjNGczhMBrna644LryBZ2+FMkeKuDvLiGAbiU6mlNaT8a8y3WsIGwKqedPS?=
 =?us-ascii?Q?ipYBUFwzfbeYg3pH/A6dBuk5Nz8QBAjDWptNQB3lXRiir8STop04DO0nzUBr?=
 =?us-ascii?Q?oMHjw38WB6h6hGqeQmlI/bRWIFLQ7wAqftmexCMDBqSpCgPplCKwaSvbS1Zv?=
 =?us-ascii?Q?yGdeWxDrJt9uBJv16LNVkU5CGhsVW4bzAvj7B4qIQk1Md8SmsZvSbI7b5SQ9?=
 =?us-ascii?Q?14RVoFJQ89LmUA0OtYpjFd/R6NXpPQq1JHOlZrqrEbz0UBanbb99qESZ+rT+?=
 =?us-ascii?Q?rl9ljKlqCPa8cToju1BGvZAOPT6NSUmRP22qS6Lg4nj8vU9fEO1Ox7wQg6e4?=
 =?us-ascii?Q?TMfn4klRhq7RfMs/FhyUD7GGw0PhfvwJZ3FsPJMD8c6uErhzmE+BbQTBw9Ud?=
 =?us-ascii?Q?0TVwIQ/dHlzqgn4q/IRhP+uZT3LY0GhSgxqL7OC7Qkaa9iN4dF9cb15w8M6v?=
 =?us-ascii?Q?819sHHEEF66iCK4TZ6AilpxUJz3hbr5OloLU4wLAJBaG1dVIfYopy/OVFKV4?=
 =?us-ascii?Q?i3OkaH7mZpn64UIpahKiA5zfJdAEsJkvrRuJOxuZCAs4vf0p5P8c4RO3fgIW?=
 =?us-ascii?Q?VNug2bWlKeqGNKU8LYozAHEoUo3rNmW4HRR3jSefL0S87kfSDf6KM/w8rT+b?=
 =?us-ascii?Q?iUlKAER2EZMdeerKEtiu2V3AU/KZwuY9UWCF+zsGn+p3kpiVqEXM7fw9qMqy?=
 =?us-ascii?Q?VZqfzJEmqKD9tez9WBvNrC/frd/N3BEcHUz3VGg9tpOLVScSXFujVx5DbYKT?=
 =?us-ascii?Q?lxoknbb4eVIeQygMUmXMaEoFIfjs2KUzxS2ZitId9RW5pojHjZcHb5BKZIJR?=
 =?us-ascii?Q?tPJuW3V1SKvqfDY89maVv2dlUb7dGDpKkQECiTL4B130xf/ROZiTBZmCT+yI?=
 =?us-ascii?Q?3P2BY4A/NzaCMof1bng7TmDBPAv0RwECz+f883CMUDol1sIJSXqUZIc/zO4B?=
 =?us-ascii?Q?FemhIsCZ1iQu2FjchNMXVv3gDxFJefLwzajNRZB4i8nXvnpbuEjb1YaXeE+a?=
 =?us-ascii?Q?VRXX9gL6NVg6oQ5KV1+zoMS5VxBlcMS2jI/k/p97KrGerFzXS9/9LCfS+jj1?=
 =?us-ascii?Q?9ox+1QLvwxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Of8qb6xEYzbqOhsvOCiYC137hiqLOochzax6UgeZeH1T7th1FnfvXRMdx5hQ?=
 =?us-ascii?Q?GiZ6niLcSjT7Fg0XDROmkscYekAOF3Dr28XCYxngaZYYSeTp4/9uBkZcARrL?=
 =?us-ascii?Q?KJONV2KIxprDiagzWBR1Uz68SGDB1Zdkz08HlDG1dVAXRc/HgBZ9t9qwpKJQ?=
 =?us-ascii?Q?6j7GxFxZM9Vsw99uRhT9pwoJXiwF5VUpYAvA/2EQ3bgsYl2Rnj0b0vLGNZFN?=
 =?us-ascii?Q?3OK5cpqoyiRATU1Irrko4M6GOLmOxBKCqBprS1E/wJJxZ26SML/WcrwPxtFg?=
 =?us-ascii?Q?LPXRX9laCCCYvI/AM68c2b2WNBxJeJC0d+0bJE66AcMB5OK85K7SobCjWeUO?=
 =?us-ascii?Q?hSKQXGzw31KbpM9Zi6eBvjJMgHRcfI9OhdO4/x2fDyN1tXOex0LpKvdTTTTJ?=
 =?us-ascii?Q?W2xmV+hPePztvTWZSqIi8Gg5zzbc9GlUlyXQkbY5soKPKMU46to2qyQcLca/?=
 =?us-ascii?Q?POP2JA4yeh0NYsTqpmzKcKxvBe7x4tcoBgcAG00Y61pt8gPdhoYNjhTeuTMI?=
 =?us-ascii?Q?LJy8oVX5YnzHEnZ10WoI+gSS+dHrc6oU9l8EiHttRu1pioTgKq9MMeTgUqO4?=
 =?us-ascii?Q?baOEpfZurt+SnL1KRkOJnxwB1X8m8ofUScyovTkIl+480fcxVGGk3elpMBqp?=
 =?us-ascii?Q?QhukmbdZD/LWAUo3vX6IV0kTCuOEnX4eFJMZItWEinJA02eRpyoavt4ouegk?=
 =?us-ascii?Q?1HpCrLVr9wPViMtrwwCKDXnPFOykoPn9Esam1SDakEsx1B2kY09NfC81N0ty?=
 =?us-ascii?Q?UVgYfZ6WQ6gbsjakxEoXqjVN+F+c9/ZeAX6mVDRqHax2iCAyx8+O8wrwHBI6?=
 =?us-ascii?Q?e8Fig9o+UTUfjaKsFjcJk7oUSYQ2XlLJo5eY68utbp8ycIUoF4+SHa4uqLGs?=
 =?us-ascii?Q?clztezm5qhth3iG/8kV8fTZrUk3Sp/0bRK4mnbq/x7c+AEb7ELHM09FNFtK3?=
 =?us-ascii?Q?ZzQMtKtkxGfgxJmY3Q3Kb9E9kVCA30cox8a615mOjxvRaaI8tl9D+v/avUgq?=
 =?us-ascii?Q?Aud0qZjv0fJNNem7tAnPn78GELBEqRhaSStDs6p83FJuDxdtMwL9FxQ5xO6S?=
 =?us-ascii?Q?9kK53x8KMukP3PHSHEb9z8jdcK3NhT4LzIF29qPaD7SbS6F4ZZIhN+qI+554?=
 =?us-ascii?Q?HPX1NKPgeOtb2WPzpVODd/FnnxYBgepaB0d3f5pMVpikX3OaR37UmL97CoPX?=
 =?us-ascii?Q?DfjmaDgN/O3Q7idCN95idqUkWF4vleWHipp6WFEsu0B4T5iEmfsCiE9vtwui?=
 =?us-ascii?Q?yE3IDPjSzSoy7Rbwdn67t/SAoVDUi26Wr5aprIp5S8g1Ds78u4rYvDxJi9A1?=
 =?us-ascii?Q?aDaMuOF+Y5FacXS0KesdP4XZYz9diFR5FgFUZi5H3Jam9r9ahYO7ex0sn4E7?=
 =?us-ascii?Q?81j6MCWSd+veYyqI4Qv28Sz1ulsjq0A7KSTLt0P3nxBkoKdkJRs7AEnobKfr?=
 =?us-ascii?Q?oXgikAnKj1gMATovSBrjrultChAgoBp4Mxsl6TNMXduPhBtyj3OmszBYRhTv?=
 =?us-ascii?Q?r1XIO/0mU5HmvyS/RWf7GNsYlvNs60LpGi3WIeGVnXiL1z2bw30jHqPp04qI?=
 =?us-ascii?Q?PaxZPdSQXHtbdG17Lm/0z6m1bOzdBXnMdhnrL9tl7dDrMJZ2saC59r0zwBGo?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0+X5wFRro10/mZ9TrhcmQnL180V3tr2Akekjl4Y/xrEZtsdjojFbsYwIjXbAR23DBb496DncbugZ0ECsolDprZ2c768qMsgzHMz1cx41hdAM95N+iFQJs9fYxAIkIGlgqbkgIKgXeKe0AWVvTu/FRH06p3Tslas2X8YTCWo6r0BO7uZAbg0x8S2Nlv/Rsy7y7PgkeNCsge86ra3IuMp8VIcEfPedAvOey1bysQIoQfHVRyPdl3VKtNOB0RvnmsBznoeNxjkGO7Q2+qEjVLcEGYLR6rak0JW50c+U8jpiTDTrMjSmGPrnOtIODBVn4ThE4MwEiZ/plB5ivl0V2Jr778MSCmwARMWj+9RbM4HCe9F3IWCEWpQp4Rp4FER7P0zMNM61NdLqXdCA7cW2S89++PC8TZbwSsVi5og90qAnyMbxJeE0Yl/i9iX2/BtkYwZmP8a6woQ+mKnTXmWR/KIUSUGl6VXqffwihnPqybQVa56Vavx00/rk+5xUKvo6dRh0XZ/01OqnujKKWn9gIOOkpATnTXeJbFDaiFuMx8v1nVgCO6DIKxDpahEPCNULLpI5p+uWviQBFVUbc3vQi1sTVz+044PYMEt6tpEiPgSFVXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63bcaae-1544-4b26-bf4f-08dd9dcc79ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:46:10.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W185I/1gfzVprt8Tbz30ZgLX6seJ0OwQLmfGvEYNd/6VTaje2CqRZ5ZsNOK5+4cW8Npvboi5D0c0Iq3HRLp4o/SBJWmltniEcd01X21hA0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280084
X-Proofpoint-ORIG-GUID: aD6expOm3NgT3jnfKLe6bJJuwuKILBQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4MyBTYWx0ZWRfX03p/T2/ycziz uEpv5h5x1Q/gbktZbQYeBCtUofkuwI6/j3kAypWNEYyN7GsnVRXlztv6JPB2plQ8uGBemIPZgY0 26HDa6ZYS/owgE3F+8K3e6H52Xwk0lYG0uNWD9Oja71MZtzqu8kvsjK3o4eFcA57R/VZFcdlKwr
 KuRHmbC6KVQqx90Xy9Hdzlg61MJUAsU0AsV9Wzku1NozTKg8j+8NerrK8lV2PNKFqYvODGtZvZD RfafMZCh89SfYix8z3cPRXkkXdh+z0kfI9VivmuSLaqjUFxMTZkzQA0ZDmxqPrx+xOdyUVt+/A5 XXKqCO+4lsoFdC+GMJOr3vkP6EZ7QzTlFodn0G4irh3R4WixjXdVLUmM+bHBQBzpwG+RoyNPvPy
 wflP2uBkhuovKOrYOCqc6YsD3p62uFtRQnV1Quxbnfa9nas97JcEmugk2u3u8HAwr47Ton5j
X-Proofpoint-GUID: aD6expOm3NgT3jnfKLe6bJJuwuKILBQV
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6836db66 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=PTTUJNXYVEWVejtaFd4A:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22

Thanks so much for catching this Dan!

On Wed, May 28, 2025 at 11:13:45AM +0300, Dan Carpenter wrote:
> Check if "procmap_out->fd" is negative instead of "procmap_out" (which
> is a pointer).

Ye gods, so sorry for such a clanger! Entirely my fault, though I may mutter a
grumble about C type safety under my breath :P

>
> Fixes: bd23f293a0d5 ("tools/testing: add PROCMAP_QUERY helper functions in mm self tests")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/vm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 1357e2d6a7b6..61d7bf1f8c62 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -439,7 +439,7 @@ int open_procmap(pid_t pid, struct procmap_fd *procmap_out)
>  	sprintf(path, "/proc/%d/maps", pid);
>  	procmap_out->query.size = sizeof(procmap_out->query);
>  	procmap_out->fd = open(path, O_RDONLY);
> -	if (procmap_out < 0)
> +	if (procmap_out->fd < 0)
>  		ret = -errno;
>
>  	return ret;
> --
> 2.47.2
>

Cheers, Lorenzo

