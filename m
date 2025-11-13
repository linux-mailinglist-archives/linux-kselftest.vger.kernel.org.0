Return-Path: <linux-kselftest+bounces-45547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D4C585BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA235AE5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04D2E1EF8;
	Thu, 13 Nov 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="adWxUVeI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ba+r9lZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EE2EC542;
	Thu, 13 Nov 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046239; cv=fail; b=T7dCf6Bvo59k2k4p4d+6V1cOcdpFXDVeKZREDNR4t/GNC4xRe4ieYsWfvS29WohClK2BOUIN6w2Br/LO6kvByJ33tk7MOoNwE/IKM32bCPBh1O6epuYt5gBDqCCNq2/cTI7f4/GCd9pEzAc8qFG5tyOh2vmmF6yn9A6wzELkG7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046239; c=relaxed/simple;
	bh=lh2Tck/6kWIcTXv3uNpNjg9tHvsqehaETL9z6Ej41sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxYiQrtsBBs/HgqTcwkAIpQ/zPMor1gUOwxvrgFr+Beg9PXsmg8ZlywFPg7OBFxGT89Agp3dC5vOQ3rJAyu2tKTHeznIs1yA0fZnxgU8RTkxGkGBOhH6lG8RyLvfspsiSyUFDXrq27kUqAfy0EWdVvktyv7iT3vpKhrGA933m1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=adWxUVeI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ba+r9lZo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA4BI028279;
	Thu, 13 Nov 2025 15:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lh2Tck/6kWIcTXv3uN
	pNjg9tHvsqehaETL9z6Ej41sk=; b=adWxUVeImAXFGxEVpZckpnzEz+WWQzKeK7
	g6iUdf6kXF8WnPndEbEuVqhi4Qc4NFD9qyNM3klp5k6RTRwbrwqc40yfUUEAM1I5
	H5AcV92rJ5u5K/R2aWzBbaQHyv9IPFaCRCo79JBtxhvIl4o4ZMBJFRIC//3krk6h
	8B4VDqW0o9l1LQUvDmIqTyanyUKgw/EOdZHJ0aiDqbiq3T88OHNzWvJAY0pvWVZq
	0h0A2sw1FbifazUzEzUq/VM5d70SUmXhyp5/d1EqOMMVWI7yd0scs8e0xXD4hyHJ
	yVldLNdPbHY5SJxxGqiFW0hDmQlSomqUyFEdpi12ct4XbJzill9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjs9yd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:03:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9WGv027718;
	Thu, 13 Nov 2025 15:03:38 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vag9vrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+4jAdLFHXysCGbhoj9lpI3j2aQVyFeEQixN4mD2TL/rCS4Nr+e0Lt72wILL8nx+Q1RDHIjVOjDqoU6lX7EGKCkD1N0tS6tkm+E1znoUyuU7/tjuMcsBXLeTudWMoUXA0jdoF6pQeU3SK1FXN9f+PreVVjXGQ/c6xkJ/OGcPcNUS6XHaNIFrIH+38rMhO2XYSqy5+b/MAjcArevVo/ZZqNfN0P820kp3PjPNZ3Wf/wIUWJRXardqjbB5LyioiMol7W8tR+IiRdLDYztjhw09TKDaOXU+h0dvrU5+Na4Ho+7vXYwKkCjHXfeDrbve03clkJ1g5IDVWywvbn06fS1wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh2Tck/6kWIcTXv3uNpNjg9tHvsqehaETL9z6Ej41sk=;
 b=Fil0ZWIkLmFB2ELNszunsXIvQvhKtXsKiYYh6Au37wt/x4ScSEQZzTy0H+/j3iZmvxPr1H+VQje0uh6KiAqLLYma1xNqA1oTR8wvHfK0Y2ABLF9J0gyeGVKkhIxtllosOR6/pNH+BvG3ECOLCT0yMBAOMhvtv+y5AhSbGNaDSLbRB1agAJ2Q1NY7pLFgpbe1KqeRQehCic8//1RRncP3TPvesTCfJpDQCR8OS0KY5yr9kp/FfHUD5T/2TjicyqZaIhKN0N4qiJOOJjvsMU4wY5kQQ0cbwIBf/ua4xl1jYAWAk9O75F4i9xae/vPcC262O/ZOL/wTXaxHknUAjmWEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh2Tck/6kWIcTXv3uNpNjg9tHvsqehaETL9z6Ej41sk=;
 b=Ba+r9lZosMhwL1YK20JX3fnDKwkTPMmbeBu11MQ8/PMXeHt+ADcnZXvoOxVNSbk+79zhHGLgJR/tEZ5BgAFGBfLc7VSCru+r41CHlcGpfaXxCHnI9SHjOI++2oiFOvT+7jx98LordJkuB5QEy1yF/lva1LHZVcKogXt52kaxm2c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:03:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 15:03:09 +0000
Date: Thu, 13 Nov 2025 15:03:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, Ujwal Kundur <ujwal.kundur@gmail.com>,
        Brendan Jackman <jackmanb@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
Message-ID: <b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local>
References: <20251113034623.3127012-1-cmllamas@google.com>
 <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
 <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>
 <aRXyxWeh81-aTHaC@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRXyxWeh81-aTHaC@google.com>
X-ClientProxiedBy: LO2P265CA0430.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5d2200-56e2-46b0-7f64-08de22c5c1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/qxQ6gFiyOKP+vyzXfS0mTYcAI230MMazksdAx0X+dkty6Yg33OnozK/uCr?=
 =?us-ascii?Q?PrTUJAiVNh2mgE8Wo/0XRHHy93yvrXGBRx1G54HEIh/bviTauqX7qfzo6Etv?=
 =?us-ascii?Q?2//f5eqFWRSrkBQ3ylNIWR7mBdNEV0LZHdAFFduk1uKv5AlrffgIdAUk9HRv?=
 =?us-ascii?Q?y0RY0+ETnK4tQBINuy/vV62rF6IAX2Ot1Py1mHZW0cQNLyx5bRb3JxG7XKNo?=
 =?us-ascii?Q?vjwSR4WT0qHGrYdD2lz3ihQxsWbabHpo6DhMnEPo7PlSd+5B/TI1tvhXSkMo?=
 =?us-ascii?Q?6DlkPkbgkJ8rwFL/lnaBITFbSGsgdvX8kKEfZqe0c7FwlTw5fE8H/7fwuBWu?=
 =?us-ascii?Q?UGw7GzMSpGd1AwA9Tv/yjPWqFyhA8dBwtWbHVi7GntPnwuZGyPYIpy3bfaAi?=
 =?us-ascii?Q?8lIGq147oDPaQjQhZqNKU+u8wMKHRooZ87s2dpfSwHy8XTWy99+YI/t3zqb3?=
 =?us-ascii?Q?e2qOdBeHJOoyFtXIP++rVzizIJqQud7Ef8mOGYXU4TsbvtVs9AFCpzp/UNDf?=
 =?us-ascii?Q?gyU1gM3FxfwPFnoYE22LOhbHM5X7M3Wn5j2f0Tuobi0+w0uc66EA+pHRcK66?=
 =?us-ascii?Q?8ZGIIp4hAE4FM51Vb83hg9in0/QMSYQWE2EoQUYN31xfiVmgdQuevywF7UOf?=
 =?us-ascii?Q?99WWH1Q4YPM7vjxTJpKbTpqjKsb3HWaq4VaJ7xG8Kzcd2/WkkJJ9v6pO6xNW?=
 =?us-ascii?Q?TnFSEvIMihAjZR1g2pJCE36wUtl2z32AihOw1LRZKDqi0+8alaHiQhQcVizV?=
 =?us-ascii?Q?sCPrRktFerjw2cASDmg4zfij8FKW9r+QWHm9VStzJGS850edC0eyQEKr7c9t?=
 =?us-ascii?Q?xeJvQmjaVOGPGEMk4HpiAbu4h5qvTFyGmlRQoFS0sSIju2kqH4II7AQD31C0?=
 =?us-ascii?Q?NR/iApk8iExs2iwdZcEUgq1qSeQvzs+IMIa1StuGEmWEViCV0BxACy+8w4vA?=
 =?us-ascii?Q?wGSLcjib9jgiSzgn0gSm0ucT/6WpIvSqgLBB4YPpe0zDuncfhQJtnQiIOtLc?=
 =?us-ascii?Q?3MdBTbCw01gDx5boPPEjLksv9Hnbj0lYA6NBnhrIeBAfgjuPQ6zg5xikzaDc?=
 =?us-ascii?Q?+SpYdGFnVW1b8oIWNU7L/7T/JTrMiBF0duQY63RVixITZi6wazOvc644Z5Ni?=
 =?us-ascii?Q?vI7sMPdJSumdklz6m8OMLSAmnEY4PODfRjaumTnZ2x1ZK5jvtMrAATScH/So?=
 =?us-ascii?Q?bCxIROBrrTPFisooZxO7NI8c3uvDbc4zhOhfhQbataxtZt6Y5Yc2niHv2/a3?=
 =?us-ascii?Q?NW0X2l/pMfpSaa8k8kqD2YMfaQKhieWtRcSDPP8mEmVPBzzf7fDSLDeePmYz?=
 =?us-ascii?Q?W41kpvurERGP+XK8d4VTqiH/O4CgxH1haZ2H+qPCdy+2YTXALZPbqjys9ib7?=
 =?us-ascii?Q?vx/n1C04KdLZeLMZU6jhrqylm4Y63SMVnkzBAuQVTnH6WTyvcpj6+thgdtNS?=
 =?us-ascii?Q?rgxFg7jyihs8eqRg/AkeemcgxsdlOfRt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyYpBPLuJWcsZiF/Q2k9d9oL2f0iJxEFqg71z4lN6oMvjCLfEtg8jnpl121C?=
 =?us-ascii?Q?LIlQITa9mxcobHCkVkOGYqAyuqIl73DtttZrEjX2cT9ktmuGnuOK5WiCcJiK?=
 =?us-ascii?Q?72s84dX4p5JehXG1pjoF7Iq8CnNW+LvMyATvNQBuRbSSfhtrO3/8XJBgraCz?=
 =?us-ascii?Q?NJGoPE9R7cu5PUrB+ttOp7Te83/rBJcLEL5zTALGS/C1OGKhNmXPl3NrwzFo?=
 =?us-ascii?Q?ZMzIHCPBF0rWkOn/5YilxKJVDO4nYzD6LpZcjlGfP4edv7by/qWLtPhBxnF4?=
 =?us-ascii?Q?KBIBVn4YxI/Z8ikKFsJP3tzwMTzM+XjBEoXozoQlEf8ai66Ktjehehj3iU3a?=
 =?us-ascii?Q?zAJU7SFbNaQGO579I9Ab6KPgZZ37uEHLIdoo1MgxtN8hcHfuk95KlNa3Mvzz?=
 =?us-ascii?Q?DRBwMoHW7kku8IqXr+ZEXcA7oNMMRIuuINu4aocWrOPmgIPksLVRjBuMVWUD?=
 =?us-ascii?Q?SdXP8mdqTUdpcVykvHB0wOXkA9uFzjz/A3+/B99Oc7dGSNVweonPKXJHIeoU?=
 =?us-ascii?Q?T1RWX35gK8gt7JuLsf7wOgstWEgB1Do5dKsT5KdgJfrY+iY2R5teWmCtIxod?=
 =?us-ascii?Q?zRkEqLYbX+ccudUBo3oNgytmM0UNBjttvo0E6TXYMi7aHVx9We1WmBM/4H+i?=
 =?us-ascii?Q?9tk8YTMKKEV2KPIyoyfFXgZvTOdvZ0I0XSDQzp9QfPOhyfrdYCOk9WwK3KFg?=
 =?us-ascii?Q?fGhIwSur3J8uV3sHZxB1+Xv1ZzSpZh/Zj5LtR1hbx0ko6WRU6X+EpOjhAHbs?=
 =?us-ascii?Q?R89ClkyzwrSAdCR3eC7EknVpP+6hCu8QuA+lUOfMFpCnEhgsD9jq3uKFDrJq?=
 =?us-ascii?Q?AwIZOLQ37Xykaa7SK15vYPAjS48+o5f9SIrYewFGgq+fRabnBQBjOvi6e6bs?=
 =?us-ascii?Q?KXsS2n14llkA5/zTatTuh7hJvaY/ljNMqGsPDncbp744Gen7jjGrwNBoclM/?=
 =?us-ascii?Q?y9zigXCv2JCd7fiFFH7JwP2LY84wWqDdOwCIIBpBF27tiUbpBP88REoHxpmC?=
 =?us-ascii?Q?ziggwqnp490oMRbCE4lajsdj2977Fq8HwSuiYyFPn2Pe0JdPsuEtZUf6dEwp?=
 =?us-ascii?Q?y9SyICfoLTBBHtgdSOKRSVtN+GrWaXW4IhSKAZ7QyOuCwdOFZUypxw2gmU9I?=
 =?us-ascii?Q?HizPLcSMLQ0sgHMw3d7M6SFV/4go+d2vlPviqa/yevpD6bJfxiMxTr4UZUc9?=
 =?us-ascii?Q?fjAEbTkLHtZU23kqpQJSOAsY2AAOwAofnC3IyX0EDLnr4zRSB8RygdxRpZto?=
 =?us-ascii?Q?aQqVnNblNu+YKvTulcUo6qC5pwiQfkp77lS7wO5onCCshCyC8IgoIulLRZHe?=
 =?us-ascii?Q?iRS/hnXVYsqaZgb1MM9t0D/9BxPmTS/h4qBH2hRWwhD6zaWNzPJVtE+ORn4Y?=
 =?us-ascii?Q?O844xwzhPu8XT/seTces1dt/a+9V00At+R9L7FkbRMnfz86cMHyIyXOm5Mwc?=
 =?us-ascii?Q?jI3r/qkFXuPcLF9jzLt4+7483UX+QxpZphXXqePO8ANPkVcpyrcMu6P6VCsY?=
 =?us-ascii?Q?BSK+eybTWU4RtjITZeTqwuLyefoduTI15/7qlULEyNEgs2jlS8RdfDXRSNkG?=
 =?us-ascii?Q?Qn9MU36E1rx1LA/l5q0+OgDcoHkWJN7oYPmCrqjgEpOJvZNcM4bWrAd/aTv7?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TcqL07nUwF81hIxiC/nNS5mU6NCZH2hljUntWZHJWnwes210kXaZ0U5FIQfs7WQyS44awrxK68lfI/DCZiu3RjfoGz7Pvs44p8QGs2WXuf7QUSzjY1pb6uZYfUAEHt2ztFqIikWelBP/ccTeTqm8BRgz4+hcgy8E2YdSFeyCm2C5OVwX9W8WupHXfDoUy2H3D8H3VuhD8edSxFyWPcrH4OgMXq2KD3xe/TlEuO7PvzEWmyIV/IJYudqZQSoklN9g5hTs6Ow+30TCQuRviciSLw49NaPo4xuFM8pLQv3H7viVBymRPl174nD1bMMQdo5qUVdK2DaoQF5cKKG5oWtwMXz6/jvzQZ8p+fJ6hQrwYgjmeMXpZQ8QPe9XkFAyr8TNhXBXzXOa9geh+kb3q99BobXCtnWs8NZJCAYqCOwHI/K0QDvDYorqa0kvqLiyOp6FnQpKGTro2RMf+fBgiSA2d7jzsmxfb1h9BzcQJBCyImkHL48v/oMbF08Zs+Ekboe0bD54MgobPqcs13Nfr0brnVlHiw07cWLX5Q/sl5jxMPl9dC3tqzbtuh+QXT5SLZriR8Dw0hIyHWp+uDKYFvMFkBV70zE+OaV6jifib9A83tE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d2200-56e2-46b0-7f64-08de22c5c1d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:03:09.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kq2kb8w1FWEbPHFxTxINZb/t9ZKKHrOiupYRHYygoytcTBqlzDvw4SIIWM5vpHuawW48tEDQWm2/SXt/MysQ1zRkNJqCUkFRMvtG4Unc5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130116
X-Proofpoint-GUID: 4cl9qzEw1F1HSHZq-1haqwt0pfygUI3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX3rguAl/iiHF3
 spAX5zpp40sZaegkMOUcvZCObXKmxx8LB+hxp3XEnXEvuRW459vazS4FFhxQnbTBahMAXt+spMI
 b8H9ApXR9l4ANUjkxITarIKKSwlQx3MBxR36Y8xCMSrJRsmtgl0DqelvMrnQgoE99GvvKnx+eKi
 LBuYtlU64TjONsyeD5rHcWHFtdSMH2qEi9EdWudzy5OWjF7cViPuaurx1jHGtu02sBZm98LUrTw
 ynP83Lgqf7OBtQQuKGUhhlDUbSblUksBiSAR8qc+QLlN02tMYrtu7QUHYCSmV+IYeAbm5FYDnHI
 447aBHtIqoLGVfT+fQYRa/k8Z39IhY7EdqNyD7O50WPLRiTC36xFbvOggJGPkHaidpyjcQt3gfK
 G9Lw/7udTrorjEsW/c+gN2qHvYUUQlSSrVE1s44ObXlOFpsIMaY=
X-Proofpoint-ORIG-GUID: 4cl9qzEw1F1HSHZq-1haqwt0pfygUI3Q
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=6915f34a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=3_K5e9pNeVQcAuYCUocA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13634

On Thu, Nov 13, 2025 at 03:01:25PM +0000, Carlos Llamas wrote:
> On Thu, Nov 13, 2025 at 09:54:37AM +0000, Lorenzo Stoakes wrote:
> > On Thu, Nov 13, 2025 at 10:06:42AM +0100, David Hildenbrand (Red Hat) wrote:
> > > On 13.11.25 04:46, Carlos Llamas wrote:
> > > > Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> > > > vars into struct") moved some of the operations previously implemented
> > > > in uffd_setup_environment() earlier in the main test loop.
> > > >
> > > > The calculation of nr_pages, which involves a division by page_size, now
> > > > occurs before checking that default_huge_page_size() returns a non-zero
> > > > This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
> > > >
> > > > Fix this by relocating the non-zero page_size check before the nr_pages
> > > > calculation, as it was originally implemented.
> > > >
> > > > Cc: stable@vger.kernel.org
> > >
> > > Do we CC stable on unit tests? From my recollection, no.
> >
> > Yeah please let's not.
>
> Oops, I keep getting confused about this Cc stable thing. Please let me
> know if a v2 dropping the tag is needed.

No need, Andrew should spot the objection and drop the tag :)

>
> --
> Carlos Llamas

Cheers, Lorenzo

