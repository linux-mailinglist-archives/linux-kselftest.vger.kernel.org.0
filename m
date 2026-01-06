Return-Path: <linux-kselftest+bounces-48341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEFDCFA468
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A38304A8FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648B2D7DD5;
	Tue,  6 Jan 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDnm99A9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HTGDYjFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D12C21DD;
	Tue,  6 Jan 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724716; cv=fail; b=aKPwqUenZcd2sSnrSf7JAiyoJSLHpLSluJGlt7UHSwivkShGqgLWpi/R8pyYEf5Uv5IJSArFE3lFZG+8Owfmz5N6Hbt+9xbjb3zziRztKnYJ3ANngJbaChwwtaZs7TDHT4VULH0QM3asmCZvGVvt0APiD18IorrVEhBu3x0ivBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724716; c=relaxed/simple;
	bh=mD/V9lcrVIwQpInz1TDNxTC2w7WIzPueRRj2rVMwVUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tL33HJrsr+8RvQb2/RtUEpLZh3oSOlcvfjrY9IPJ0OVJ7eoIVN+hkNmqgVY9rigE+HZx+KqIVOqayZoRZgsOyepYQrJCfGIKS73JCqTQJs+Fg3T8pDEVn9nkydjj6y9RCzqg+VqjRyRgYs+nWluSpve5ry0vxnPe82+9xwaagJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDnm99A9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HTGDYjFj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606Hp3C74066031;
	Tue, 6 Jan 2026 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=y5Gc1QwbHFI9JYg43q
	DOvET44ZF0ejp5shYwLgeI1wM=; b=aDnm99A9T+2x1NVyf5xPnDr+wr4C3CPVUd
	SMaxU2Nrc3JI9B+0h5gqzBwIIaED7CNJLbYXxYaD4sXoKfa8oQu68MMA3BZFoHrI
	cGYBRakBTpusCEKiajNEYWjdZvfibZi1CSlFXNhtJ3u/FPh0dPGAJWGlC90HLk9h
	n2wgAKjhGE77i4MPCOkyOrZt2xPWLz8itflzejCbgzpULKAI+Qy/+QFjt3+y7f+5
	0JqSRm0JRZJNTFxNaZ4CM3Pn2H4MkK7z9wDiFz3p8b58TBVWhh9U/e1LPmET1ITY
	w93woYZDeamvPsLu7mbKNsZO7TxcZJdavAQpLC63nsN7a20e9E6w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh75h82q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 18:38:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606HFkJd030432;
	Tue, 6 Jan 2026 18:38:18 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjk6u74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 18:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOslTOFfZLztlsOHoho1Q8O5OU8E9pD5WDJ6VvKtfyuk1PY6XA5zPhLgiITXkbMy3KnaEt9YRYuolbwRvtiSVSfuzRPkx2VRfc/rEAwRx+zJo1eAeEHysyFw9eIrfwyN7tEQJ+u58LQgwcNpkizTf9NynF4q2rM+CHLshnMfppOQomqcMItLBdo1izqG30yRISW/qY0GZu9RWmdcAA6SYrSrn66QzvFOQ8ngccXR+STR1jhHI4TwukexSgS3N7IlVerukAgztgc9/NPFHoAytW+/fWrFO1thgsHXX2Dt2C+cLoRxJ8x5EJNj6SQZFYMqcOMH1Qh/iy2M2ZxMUsfIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5Gc1QwbHFI9JYg43qDOvET44ZF0ejp5shYwLgeI1wM=;
 b=toUBeTAU1hbzMZv2pnP6FHJ2RxQ3u+ds+Ol5NMSj5+uB868pRPmDTDYarXJsaBC4wZ/RlPVmjOjxPcSQw8kbvOhPBDhpJEZRzyYVHl/NRCzRCbcwc2836X7fj9Tj4YoLRZuRpBq7F647brsTRY2JvRA20JbylQhAG6BpKGDfB4V0ryyU6gEVx8sKn1R+bCrVgs4fc2lATK9e6ayq8S6QO9RNRcTBA38kuI6EvDKQv0x35qXGdOaqvkb4QamWXcGySKd5UQLi09SDqYFs1V89sCRg4MtQ8APRQsFq62z7iyQllz1tG8kWWzY2ecQAnUa/K7/3ghmDlE4WIo70P+MufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5Gc1QwbHFI9JYg43qDOvET44ZF0ejp5shYwLgeI1wM=;
 b=HTGDYjFj37emjt6zeXt9QiK9XNzDKYzqCi1BGA1hhPy+jJjmvDN71YLM+8JGvTM9qQzkmTzqZafWVEgnCiOA3yCJeI9UkwaeFUEOVK4tVqlrfdxf+kOMRj/023CCFGMM6GUCE89HJN+v0KBPUAsI6IT/2DQmyAvUKbNjvCcHN/Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6893.namprd10.prod.outlook.com (2603:10b6:8:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 18:37:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 18:37:48 +0000
Date: Tue, 6 Jan 2026 18:37:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/testing/selftests: fix gup_longterm for unknown fs
Message-ID: <09292ea1-e722-4897-b42a-dda517ddd02e@lucifer.local>
References: <20260106154547.214907-1-lorenzo.stoakes@oracle.com>
 <20260106092836.d6a4fa77b755bd989d1521b9@linux-foundation.org>
 <56b7d3e2-fcfa-42c2-988f-907086f031d1@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b7d3e2-fcfa-42c2-988f-907086f031d1@sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d71d3a-b8b4-452f-8027-08de4d52b0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NJIIUwyLToxebhUn90AnlAM9doBs/75UccgQ7qLTFhz+ZX5npay6SAXEkqf4?=
 =?us-ascii?Q?lw+11PJpvyzRGqWY9qKaGBqickm7S8jIE/X4NVsy/i15GIAzcH8vMSQQ3Z3o?=
 =?us-ascii?Q?ahY5RBdK30ghw9SnqXC/D9VkUdrOaBif8h/r9zutKeXkSbJMVqNBsCS2eCNV?=
 =?us-ascii?Q?9ynyXrgVHwueCYz7gi+NH1QCGt0UYhQ0QzT+lSclWZIjSzOxsZLTIlL/Gjwu?=
 =?us-ascii?Q?MgH/ao9Dx0JimQ72YAA5927QUTDttdHuAhM/mkRMgp/DAS/HBgDAiJTFf+++?=
 =?us-ascii?Q?DAp1voiccMC0VekN6SFGMcNM2f/y2MTGh0mF/K2s7uoufESG+Rt51Loov7dL?=
 =?us-ascii?Q?imv/iDoabJBcT7hUavXXSpf1AiBh4xOT49nhvVNJE3TWKkY8YgPxyFIPplee?=
 =?us-ascii?Q?N/1lUQUVoXIOflkX/2r/QJ3soiEVeh6Ity2/j3d5+J51BjWRSjvod5XFVESj?=
 =?us-ascii?Q?2KGSShdDoxNfeikrhJZnN2VPZzpUt6gaRera4rCrB3bF4LCntmfiBShPzvkS?=
 =?us-ascii?Q?6LcYkoNgSJDYkYkCmxgdadv75MNVz90iLHfEVkISgEl0wMfW2TCKFsXGETAA?=
 =?us-ascii?Q?KBVEWQ32870IZfniOO1eWft+eRAkQKoRhQD03728fNvfC/2oiVGhH4sWBw8w?=
 =?us-ascii?Q?SVreWhorv5fzxDaKYgsvdhaDx6Ec4dg/CjeQRhIraZDVDXiri/YaHEe8qrAu?=
 =?us-ascii?Q?qx4H9XZa7RnQcQKJDJR7F32v89jFVdfyfNe0THoTLgXonldp/ey1F4UXRfoI?=
 =?us-ascii?Q?teW2MlA38Gs9yYerhNjxLmW5ddPDToXwDkhw+tQSpxuAtRRDPGfWG3SDMTDF?=
 =?us-ascii?Q?ef81L2liLZsC6xtL9TXrpTlTBDBmA/OuGlViKlHD78uIQ7eDpCAJ625LQXD+?=
 =?us-ascii?Q?LAK9H9Ojj+pOX5XC3VyCg+a9L2QyV7WN3W9Y4+MFaoH9JwOaNEcrreMAnBFn?=
 =?us-ascii?Q?nHAZZeQ95qlzAgEXQ7idHGBvOJYYZLwhxxKY5DKCVltVMMb0piPasB+AeaZX?=
 =?us-ascii?Q?m9UDlqO7TpJ6djdwl4CiVK7N++8o3WgA1RBQDJHPC2vW0yVidWE3ZnY87Zsk?=
 =?us-ascii?Q?EYK8+JEdtBBQq0/CXKFBr2gMLixmr74xOjNxGCEyBZG3wStN0LT3r7OO6uyD?=
 =?us-ascii?Q?KkBbt8TlH/zmY0xts7c0s4Y/c/oavH1DEFMn3LSy50+E3aah0hDNky/kVmEp?=
 =?us-ascii?Q?yd0P+c9L8Sni/pAd9sMf1f+8HKt1zI09SAhzkdbx76wLqbf4ILdITjnE9tRM?=
 =?us-ascii?Q?nwtCtEJH/722Et/o/AkEHlYyyBboPNGfVhJIK51csIKckUphwskkY3G24G+R?=
 =?us-ascii?Q?ynKMC7Bn3jiI4BkSTDX0x06wFk9c2wVoyYgcuaf3zP2Bv4d8PsgbbHqvsrth?=
 =?us-ascii?Q?daVj4py1bwUyJ2jPBDPMBTSlj1CXXyWDRix6hX0qH8R6vCbguYBInorhK214?=
 =?us-ascii?Q?YQjqnYrHgI7faWcWrcErxXyJgNup/Vxx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooF9UKL+z/0rKFMpSyWstW3GgIx3nHf6Rk4Ruo08bNdqsjD6FIf544jE5Rz5?=
 =?us-ascii?Q?GvlRszjFhH/KARzyxdnAjvFt9BgvAZURZxcyZ+4xiBQBxeuat7oMGazFvY4P?=
 =?us-ascii?Q?squczS9epD9t2H8BtwSBYVm0PQkPCreimoCZI+SE1hzUFG7qiIOAXdwsII2g?=
 =?us-ascii?Q?yeoGoRYWVSK0IqPdvc7jKpthMiG0okCMrD2NIqAqKb2fDsrGIRmOfqEBecir?=
 =?us-ascii?Q?68swmTc37qIU03KhTtivsjWwpQtOgiuf5APgpjHe08M8Phe8BWmixK5tbDMc?=
 =?us-ascii?Q?InUwklc2jpGbaDnAE5lzZqsMNfjvmMIdSHFbmG3INTiYyfhSehkojS2Tlo5Z?=
 =?us-ascii?Q?8mMUbYZp25mEqPqujMxdoJEyglk7zhbW8rRyUdhXZTNXVi3XCl6bhAk6PYcW?=
 =?us-ascii?Q?HDngaJ71P+9hDQMY5dV5qL/XgXvQxWnbGTtvWXP7b89+Ehl6ol/E+wBXJgM9?=
 =?us-ascii?Q?qe3k6RZz8YTliu02M6R8yuvrs+j4S1nNQRTPvlXBCHb0gaAF65qpseArUt1r?=
 =?us-ascii?Q?bTxNv8UBUqTMmgC52RsUm0bzcX0VGLQHRbxzyjB2TzC0IogIeXS+Z3CEZhVZ?=
 =?us-ascii?Q?z7q7zu7MnIZSabynzquNiPcsXhBeS83k+5XSZEz226sZUD33ConAy2xEj08U?=
 =?us-ascii?Q?cEbmIod0StEA6NIHg6oIfKVhKCLIpKhxt4KB37xRJzr2AwZseQBGa27+lYe4?=
 =?us-ascii?Q?NSiDhwZCoasFO3YMXq30IYb2sMKT8ur+UUQ6ZZUC3wSr8aXhmLkFC2niZUMz?=
 =?us-ascii?Q?fw5RYboMDOGaqF+Y2B1VGOOHnuhDKmZA2G9XrtHe5TGlnA8NGBmeqB2BmaE+?=
 =?us-ascii?Q?qFzSMDCyWuWamWUiEx0incCqIHN8II0/IchFLQr45NlhzXdDOgIK1EyyRh09?=
 =?us-ascii?Q?QzREtH+iOiXcGc6f+5TLpdyjzrddY0pX5+q+s6MKI3wamMfdHcj+fP1kKr4E?=
 =?us-ascii?Q?IPJaXuSebf/bVPJuqO5EQ+WKowhtUZDOZfR4wKbBIHxVziAVKdbogOxCg2W+?=
 =?us-ascii?Q?Kmjy7+JQXMaXvi1gcoQ9rd45fPEM7MZAzy2dDvaBMVaSsAOspL+0BayChXYX?=
 =?us-ascii?Q?HyZW5+aqLpTJdWqg2GJnVN6nVemTJFrOxkyjfi4mLYme2LvMsNWRr1yUoy7M?=
 =?us-ascii?Q?fTSjhFHYQl8CtPlmhr1LwKzCGUT4XTyP1S7FtI0oHusMmr1virX9+894K/K9?=
 =?us-ascii?Q?F9ve0hmh7zAsNOpunhrlYOeV7y8KMzySoW8UiVZXUnd/m14S89oTqP5d8VQQ?=
 =?us-ascii?Q?eD8ziU2dd68thSRyt2wCfToBcUVFygnbdPu7sGA2X91688rnRbGr16TLTB2j?=
 =?us-ascii?Q?5x8yel/OVxBoOUOGCIAFVZowxd7mTkC0QpPHaABW5c8hGibjTWXpuh5CJpke?=
 =?us-ascii?Q?3TbbWIQ4gTS/xDoKzRGxEbd6+pkXAioONPOGE2Qs58NV2Pa3Yqno/fCn5qTj?=
 =?us-ascii?Q?CDz+NYeCeJinps1QChQAnUKQpMppU/ECkMT+QNnCbQwpNK3KLOWUBIH4OTuU?=
 =?us-ascii?Q?bviJFTTxyPLL0gEbcxC8Rbz2c8EV1gcn1spdynsvuU49DS8eYDvgosbonhCQ?=
 =?us-ascii?Q?gR6z1L08JDoew6sPu0ZKz8EP69dqN2iStKrUOQzViGR5lZCIHOAGKj3pVQKO?=
 =?us-ascii?Q?wOKZ1FVQTVKjSz5fFxiyiRMN/lh0zxKQVuRalGwJ8thVyBQQ5rJQ3SSGECeq?=
 =?us-ascii?Q?tvws50/zZkFhvuFtAAJFnroSTgXlaFe4TXXc4YMZj6b21hpdAoQJ55tooEsr?=
 =?us-ascii?Q?3yx2QocVdzWHdrueYH2qMzQ6U9UfXV8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LxlJYcV474K3KClTaTKoIXAoKuZpvLv1FcI0SqIvstm+c9NfanatKtOXv+jKo4/wdxY+wJdR1Oo/T5dgn5zFEq47PnneS2FDHEsCVWZoNDRdEAASVG7IkMKJO5iWuLkIMIAYKEmX9aTmKT9mVGmyrxyFYnmCYWOnbVlXHd6KcVaZ3XNcEa51QJT56PZ7QTZwKpymwly45NBMRNjfM98Dplnf+nZH8YBCCgXSBaGdxr1nrY7lyhHw/ro4ryJWgsw3kpSFYNMOO/3BDWrsljgL49hwyDLUo8AjaPwWNGsMDw7dFDXBD2sxhOEnvW98ACkzu0apwlXR3V2SE7/sxkUDkyyCfT//KHFaoTH92khQd0kRZOgG5DHM1KmHAYmYR0L/80K/Ws2wiX/KUZtmQTRjtiCaL0o6LiymBEWlmiT4z1LCLgEab9HG4DhxNrs/FVr9nSgyidV8hgwch8Ua47P3Z2ks1/RBJwaipDoOG1AVQmLy31iM5oYDEu6luv985I4fhtRmA5eG+GTQ1EhCK88satKF8LSlfc27IbkUnRouLHLG36jtJ4Lvsiq6cItjwW30ewqge1Ydl9osJkychf1Bfh9AxACsr9R3OsjZoWYfYmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d71d3a-b8b4-452f-8027-08de4d52b0dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:37:48.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXZ9H9c7n7M0p2/+Ys/qYqRNFRVwaqc7JxqHy5B8WCH3a5MaIVxDWz1DiWq6vIFAOaXNbDQhXKzHnWnv7LIvTeEd9g81KNPtNdkFpWf2mi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060162
X-Authority-Analysis: v=2.4 cv=evLSD4pX c=1 sm=1 tr=0 ts=695d569b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=2DWC-cbkqVdxtKH8_V8A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12110
X-Proofpoint-GUID: gPiXGncdMg_IZOuhdHbKe9UWZQQDvgUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE2MSBTYWx0ZWRfXx1+uj5H+RtsM
 HiJC3DDOiiWqq8dbFY46um17M47UdV32fZN4zpidrvK0fDmvzvcTsQ8s6LA/jsDRJubNV228+pi
 Bl40sC98ztaZxdAWpu9Ls7cpJlIgII96K1SjYH1wMp9eqHoIk60UYsow/XwxCbiPtPPBM2bj/Sh
 bV64gq8DD70X9Kcm15uCRUZUQst5jc5PWzRUYV/3rR1uxQbNRE/11T/k9Bvm1tsQO3PSLTUui0P
 4O6O/AyXUh15yV+28XzjrA/737qYS2WhjtLaBckY284g8ghjEEZEnMVlAxVLTymVvBG+yNxuDtL
 dFGyGnHdGVDTpm3NLMJjFuhbLTJSIOHbGFir/CfcTBzQLaDWDxYK6onOoml6DpB6cGga8doV9+T
 AO++7WU9s5pvS2crQAYnTHeEBXooyRRlTSluf7upEK/MDwRke2yP7s7srnHcE2wKp2wkIxvHyxH
 UmjlD7V+XH1uNSgXVeLcSH1tavPFjxXdKUReE4N4=
X-Proofpoint-ORIG-GUID: gPiXGncdMg_IZOuhdHbKe9UWZQQDvgUp

On Tue, Jan 06, 2026 at 05:29:51PM +0000, Mark Brown wrote:
> On Tue, Jan 06, 2026 at 09:28:36AM -0800, Andrew Morton wrote:
> > On Tue,  6 Jan 2026 15:45:47 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > Commit 66bce7afbaca ("selftests/mm: fix test result reporting in
> > > gup_longterm") introduced a small bug causing unknown filesystems to always
> > > result in a test failure.
>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Fixes: 66bce7afbaca ("selftests/mm: fix test result reporting in gup_longterm")
>
> > -stable users might want this?
>
> I think so.

Yeh I did wonder if we'd want that, and I think you confirmed Mark that people
do potentially run tests on stable kernels? Or I can't remember :)

Anyway if so then sure. I think this should be an easy automagic-backport
anyway!

Cheers, Lorenzo

