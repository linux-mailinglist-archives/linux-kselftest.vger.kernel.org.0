Return-Path: <linux-kselftest+bounces-34703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEEAD55AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B963A5B82
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6E27E1CA;
	Wed, 11 Jun 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CIPQVLF6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tUIndLYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD218271446
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645361; cv=fail; b=TDLFQfc8d9SuZE6P8jRQS4MoHFLwqs+W9jgHKZGbQoIqbLHlE4SrrnLl4KpJ5jprbolkPzlN9Z0MPH2xRHO2qSS2tXOVceJR0QwwcdOP3mQfqWvTA51QUflyXrIoiGDMqC+NenRv3rXiu5HLfG59MWN4YBeIiA9A7qoYYug0Tos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645361; c=relaxed/simple;
	bh=b/8VIlZ7CAZwr+YTwdDgV+Xj1NGGycpgRODLs58dwy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BtlESNUHOPZJK903d+ZOZtYIGBCCC+jG4JbQdtakrDW8b95mjUu755TKNzT0lnRT/Gz4A0QK9tz9BJH3NfiVXbfj7Tj/ERMl3QXjsrDjpLeSjaZyIhYrYJt/RgDBvfgMV8GG3aPP/9Uj0+SUf3pmg8Hp9PBGB/1bBETrEvU81P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CIPQVLF6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tUIndLYJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCHbPk024047;
	Wed, 11 Jun 2025 12:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QmDJI+OnnyAqDWoUiz
	LXtjmBJzLChU2hQWoBajhFqU4=; b=CIPQVLF6rqSKJk9ubD8mYG+nL+eDCSJ54B
	AOyQSYU23QKTKIRmNefbCPJrm+ZWbRfpRzXh25nPTAona3y5J+wUJ6HrDVGiYyhb
	vqx+X7WW/7mVoDkwUGyEiGjaUIExpnVhJ57YOJmt6AhNuyDXVssK6lTcI7FNaJlG
	sEJRHY4GKxGoBy4gNYuJsuY2cEthoKkzLnwGWHoWgxoezq8hA13KOcJ/K54LgObZ
	HIV5ODfeo0jM2Cpb+TgJK5HEKtw3PCe+Y5pVsqcOQb8sPcKQSNiJ0TiC31+bVdJC
	b7TtLhmC2J1lpwwFzRUK1MzNTNySnFkQ7OvPosHMiW8+H4LYkLfw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v6dhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 12:35:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCE1P2011880;
	Wed, 11 Jun 2025 12:35:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvb3phj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 12:35:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoGDJlSKmi/gsIWSXcHaHwIgBE8nNNYSe0yNL9BGJNuA+IRCEWDwiRx6vygaJy5ujy/lEE5A2VX8jIZLVbXn+/463mR3iRJVYxajDSUj0pVg7n0VIYNJPyH7GAxZrCoUfh+avOXPttkhuUMb2bsVbgY1y8tyadSwnnB7DY+9+4yOMzKCq45BgI4MmpcruJ2T7qmcU7vgvPRPI3irAHw/Hmr1jxuTQMwoXdw45ROs0TWePjPK0nzQk8zCGzbwOmjR3YzRik1D5Uy/xk2EKDoXr1aKBoTU4DYXZu3WVpvOMGi1w8iWJEQonVeauVZ5l62gZmCTqdacB5XuDY0xQoxgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmDJI+OnnyAqDWoUizLXtjmBJzLChU2hQWoBajhFqU4=;
 b=PIyBElVQtJTxLpuW6dy88U3aIRHDsvnWQJSH8IYA9T2F7WNhMPcftjh9Ktc+mS0JENnRbn04UhaigqXZd0NqpM5y6hmAoapWML6p+ckEvQmsnSNz4KL2hCZECJyHqOBtKpDYLVBPkZrmHQ/ytbsLFYZcpHHOIfKn5/81GA5Ehf+9QTp28rLYYmrk2I9ckD9NgOmj5Zf4EWtnHOy8JZyRNU1kNu+OgHtR1TVF/nHTEuLfztFvtFuYT2HhqGQm7DeXEcy5fnOQgowa06Wx3+TNLh4pjh6Qx5r834inClT6iJ1FuU9RcWlRULDRmNOaaRz4dN/B8LpP66lV/IaS9l5onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmDJI+OnnyAqDWoUizLXtjmBJzLChU2hQWoBajhFqU4=;
 b=tUIndLYJy/3YMsvX18yau0XTUw0C/f76xvu4vY1pvKpvjTM4Irp7P/HjKWiNzVwtWTRdy+rE9LD7L42uv4PZmgK/hxViRozFLlkzl0jrXJBmcJaC/14b2IRgT3v4uxb0WYOkxh+KjhcvLDsVGtE6ywjbQMYBuFHEVKd1IhGJSFU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 12:35:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 12:35:36 +0000
Date: Wed, 11 Jun 2025 13:35:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, vbabka@suse.cz, jannh@google.com, pulehui@huawei.com,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        aishwarya.tcv@arm.com, broonie@kernel.org, ryan.roberts@arm.com
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
Message-ID: <452f1851-5511-4326-a206-86e119b58841@lucifer.local>
References: <20250611121011.23888-1-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121011.23888-1-dev.jain@arm.com>
X-ClientProxiedBy: LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bef83eb-2962-459e-a028-08dda8e47770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkB9hPQDsVORwGnZG7w3sRInv6oqnLPw6AqXJ3QHGPgzP6evGmp+vPmDIBL4?=
 =?us-ascii?Q?MUTBWvqGgIllO+ZRH7Kurvz1XETRYmAc+lEhvzUQ+aLX+bM25tGDVhN6tNkf?=
 =?us-ascii?Q?/dPlEQ+pIp4f3LVr3KM8JA13e5j/xFMBLeXksuWH8RwYBR/oJkyryiQrzcea?=
 =?us-ascii?Q?XnetdHocM8vql/fb+/596Ty8mErLc6nCT8oNkXg8uyUfE0wRiYemz2WL3akN?=
 =?us-ascii?Q?7smPs3JcUzAkOsAfLBguQjpTpufZ0Lc2zB6uC+ume+VeFMmV3R8HepJvJ8Rm?=
 =?us-ascii?Q?G40sAZ6bVVVFktMXpNJ0Rkk+ScrrblXbAMML01ScIAmZJndi7aZaAg7ILbtp?=
 =?us-ascii?Q?ci/kfCBsMeCMEQn/IApwmxBGrqIVutg9CSnUBft3qxedrL4SqPaxpm76adp3?=
 =?us-ascii?Q?sjQXZcKaq9MTz8IkJbWBsAsDG0a/DGeP2oJ6fKZgeUt6m9NB9jUObJ+INrdL?=
 =?us-ascii?Q?d3VUW+/nHhRhFSI0gwS2yTQm3NeyNvejxekAxtCy1kSUGDyHYtc0rRDfAyeC?=
 =?us-ascii?Q?1Ky96PUOYuOMnUyX4cqZ8QVHh5ciE8LJZ7jO01PRGFozHotmKZpSw4wid2rk?=
 =?us-ascii?Q?uGM7TMaMD1ri4Mw48MiEJcN9GFuHFJzTRB1OY4Joxe0mXWliRuXQ0XDiOxZv?=
 =?us-ascii?Q?F4ttP9vSG1cx5cEUC0rjBQ/S1vWYCryZKvOvphU/aKoXSs5areFFXQZF+4oi?=
 =?us-ascii?Q?s9WpoD7T83UO9RvzKeXO6sMoH7g6rqjRDZkGJf8hI8TzMqnaVVWb9bFSUeV0?=
 =?us-ascii?Q?XY2pPXrpk4rMIhoCCYTEAOKY3rc+h9v+9YmXFLKen8EH0afobHdqvjZnIz+5?=
 =?us-ascii?Q?ErmgafGyY3qoSlbzcw2ew70ATqCdy6FhEHc9d+0uopLGZ1g4Snk/pDh7ZCUn?=
 =?us-ascii?Q?2G5pSQS9hfwTiGOtpjZmGr90Rp/cz6PbXNqkpBbiBLQSfZY/EumFzXcn4hB3?=
 =?us-ascii?Q?VUxOZTY1OmJ7Zn3pxlqFVZu7MOD1sLenqWhVgJgZWWp+kK/78PRwlFrEQ598?=
 =?us-ascii?Q?vlFGm7F1/OKzRUcm/jXltA5AkGt0SDg6GZXvdcpakERnK1BEsFHYVib4uU2u?=
 =?us-ascii?Q?5cMuKBJHVBpQ32cqyOAxktSzteDvKpPkKzTSzpIU7NljA8GjZu/2+bwRgr9p?=
 =?us-ascii?Q?JDxcosnADJy+wjI5wIi66/4FYeL8mRZCADmRgmc0DJ8W2r8f9TV5qVx+Cc7i?=
 =?us-ascii?Q?u67EY+koHYoOsm+U/Si7xAXFalm2t0BmXiKsn79HVoOCBglM7zrhiOTmSjK0?=
 =?us-ascii?Q?ougfWPEKoXe/86RHfIuJmiyq70Jr3SKfLPEbpjUhCP/2ZcKbT4Q2qT8sTpIA?=
 =?us-ascii?Q?SH4H8D3RKnKJ2IMIgC+DEmKVJNWHQnBX6QBrKK+ux8aaGacKGxZZLUpI9s6Y?=
 =?us-ascii?Q?7vb0gAGmE3cs/7Cf/8yRzyd2rjmvw2zEO0ygSBQ6Rd/iL1gP7uZyhn77gyev?=
 =?us-ascii?Q?lSOKBZaTF64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opHOkxcaqGaBhGSHgL99Lr71ruon35yTvMpcdeGr21cPJg2IKROoKF3y/Ny4?=
 =?us-ascii?Q?LmaRS4tysNzLR9ZKDCZGc8fEZgd7FuKoeNMl7k+jG6uyZpGNTOjfvmjvY/W+?=
 =?us-ascii?Q?RJwhvdK4I1JoP2M9yuR2orPW1N/AhNLvknCpY0liigC06+KTX1NiZr0PPk9A?=
 =?us-ascii?Q?iblN2RUnWeAo2RhAePYTTla2ehvUMDgVp9a10Juoz5T7d0lUVnHbJu2x6g+6?=
 =?us-ascii?Q?WRIf59lfno6e+/L+veySb43ZM74uD7GAXnyaAmki8MFU82Af7g4iKkfTqc8X?=
 =?us-ascii?Q?KxaQTp6YwK5dEkZVYGGrOis4QjlnMaHoYSV1w3slkaLDyHK/ctcFqo9N0wTm?=
 =?us-ascii?Q?Dea5tyiUH64Ej8jUIPIzeJ7UKtHHkO7NjAX+HW8eY7Tm6uBJKlFF3CkhbtJ2?=
 =?us-ascii?Q?P5MrnHdIqUYZoING49uxC4jWjpQbQ5JgjCNn02qLrVrgfQCYRsKwQmyqdvYJ?=
 =?us-ascii?Q?k0uvR054sv0Bk9ZWweAO92G3m+euIM5w10b5DPaOqrZx+ODvMvmadZoameuz?=
 =?us-ascii?Q?FdL/Gb0PlAjnG2Mc/XV7s4G16qLAWaqfWynLhyBcBsiGHKVRQJFRjV/oGTkb?=
 =?us-ascii?Q?DJGzryean2FQHWELYuH8CftZtKEYu34SlQOUagMg1yjichOnIW7KUbwDSf+5?=
 =?us-ascii?Q?KK+AqbaE8PQnTPBW3/e6tfrZ63ePfxWswxWxMvMQ8nWGrXzmIY1FEkXSPubB?=
 =?us-ascii?Q?mOSg0naSEUlXz45scw8MfOYmxtYn+49KgXGiJoIyaGO7bVUTgdNja1W+f5R6?=
 =?us-ascii?Q?elbXfYn7SwlqFTzC1EuQbehaAd8TOBRcAdMA3Z+xVeEaZHonJannoP+0HcS+?=
 =?us-ascii?Q?3gQiBt86HDy2HuPS7HgSEycMnfsgxeg6IiApvb1Y4pZgMi2S8tQl+Yb96Kqx?=
 =?us-ascii?Q?6HtnU+kVe+f9VQltS28xG59K5JPHeYcEaQuaKQF7q9G4fUosDvphgIGQy2tk?=
 =?us-ascii?Q?7JhLFqLL1m6+xtzpqCzFkkuKAmA/MnssDQxOF6oSlsdO7rSFy6j8iJfLjWfJ?=
 =?us-ascii?Q?EFi3EOoMNpHXShQutVDibNO4h7KB/KwPVUIuIGDzxas1EHbVXOMR/UMcGt48?=
 =?us-ascii?Q?3K54mEHh4oczHfRBErgTra/n3bvCu3Es5nwVCOMubLJ0LTCwGgmXpE/+fZjJ?=
 =?us-ascii?Q?e2AvklewMCvyRuUrjPm14KzQLSR+ESaZ6k7ZqL145fyOzcsxbbQ5dZMsdWHF?=
 =?us-ascii?Q?yHfx0+ZfR8oTWqYSuKMr5NPj1pzfCKNn5/BJmmVBTICRHz6pOrkEr0T2TLZM?=
 =?us-ascii?Q?P2eUZG0FF+Nz30hEh6xwYZBYryg8kM2BLryKQR6C2kKYLBL9ZwxILU/S8gab?=
 =?us-ascii?Q?FxgOHsaiZMcTWq5jRANy4djBdIWgVNIxnIebew/sWe55K1+0zZsjqkRF2NXD?=
 =?us-ascii?Q?wO5N/HKnyX7nuQDuKKFSqLaMQlWmwVFni6dg9CO+ZMjTZba3wK3/thIlsv+t?=
 =?us-ascii?Q?hUWJIDiEIwKMp6fJ843jyjIGyRiIWc1HxDhdmyLDg2U5J2Ddnuz/1bbVmeSC?=
 =?us-ascii?Q?pHlqrqmJg9JPZZN75oa2dW3Ex5l8ZuevopWzctKiXQdGz9QIsKA2sr5GjiFk?=
 =?us-ascii?Q?wVvE+LqH9nlvimwg1WMVuVG0cqVp0tKMHl1kw0QsGj1rZN9gaZQ5UJsSl+Wr?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7bg0Bhe0BwMNY5vi0Gt8ruo/AA2R65zvdY2JJ+8r9BwPJgeWcAgu81LbPU4QBUb+NLMBIgYCQsHm2aqsms7HUxmyftfa85Na0cnCjZVsdFFOkQ72JOn+UF0E9if5LMIGl2Sf45wpyx8x/EywWuoOdAWBtno3EcSHyxhGqF5OSwGzXa8WPXof/zYwhJHLkonvn747xaOSwHP04X+y7eVkdqjB7jobInqtIx2iVDLAY70l3/r5FUymrL7UpKUQhCPJj+8iUituQhlcs0wDbwnYaCGvaAEJI1VxhcCS6dPHV56vSTx+ddBVRAOqrwcf8aislCX1v/sgkDI6ghDOkgbo8QiONiUrH6oKrIDR+EnOv/hrshKpsMCzDx9jHA+9qTNFqeKGEHJyQgZRKuW6TSBLZLidliSRbGSNA+6P3i0LyHZO1iDkyaUQRxKTjyTM7fhFsmKZdFpKwKOIAOnFBmFYQ2GbGtqID/Jt+iACGjG9HIKTlXiYTRjw7uVwvrG6Axh4CrLAfUWwg0XdUItNZcmX4pR/odj4axNUGczkRY1xlfxObiYq049K3pJ2sbfE6i/8sQ/U/s94FPvnmi0/BGN63jZH5Ft0Mnvd4yp4jlAX1SE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bef83eb-2962-459e-a028-08dda8e47770
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:35:36.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOTJmUJpSw/LicTIFj6DFsTUm48eQTRshAYfRLjzHVofFsl+aampybzpFSAJ7oqJg/tZHaxqASVQr0pDWpu/mIe57v5xYDlAteb0x9CPU9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110108
X-Proofpoint-GUID: DcavVqY9YGhUfjQnPtwbKCi-d3gTM16_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwOCBTYWx0ZWRfX6i9hp21pUo5G HQovSRjCzExnSeRuJG0CTIkwrzJ2TXseTlqNvOJz2R8vJL9MCG/VuPO7nw4uQvmjkr7m5DSmuhj e530kANwSw9ltBUQvj+PWglisQt3QfKabv/4DcoiPhtliQRPspXoZRMuBu2d+t4NlifqJcp3Rmp
 2S/pLJBKz9tS5qU3xdvbDxFJG1WuBcuUMbHYwjwZ5zHhz1gTyfaxbE1yI2Cycv3NJ0vpQCopz2f xjD/FKaYtevgBNIMGazroeBRtgXJ08bWBtqHvEMekPxL8VSWq07JrAKoBCPKEMrIbhNx3BWec2c BH9IinZs4pDA7zjKrtCFF2I5/v1rOlFjBxq5d/v8mdOeBl4dwjC5i7S5zHMF3HTUjHCvSkw8v4s
 a4w+zRNCGLhqvxyIR3jkFAFrXf9wFOkWsmmIGhmfWKMrm+TbcZSEy+K0PQsP1kpHpICXMXKq
X-Proofpoint-ORIG-GUID: DcavVqY9YGhUfjQnPtwbKCi-d3gTM16_
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=6849781c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=5NOqdC8EcM9_utZJ4NwA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22

Thanks for this!

On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:
> If CONFIG_UPROBES is not set, a merge subtest fails:
>
> Failure log:
>
>   7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
>   7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>   7153 12:46:54.639306  # # fopen: No such file or directory
>   7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
>   7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
>   7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
>   7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
>
> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
> CI systems can include this config in the kernel build.

OK I see the dependency chain here:

menuconfig FTRACE
	bool "Tracers"
	depends on TRACING_SUPPORT
	default y if DEBUG_KERNEL
	help
	  Enable the kernel tracing infrastructure.

if FTRACE

...

endif # FTRACE

..

config UPROBE_EVENTS
	bool "Enable uprobes-based dynamic events"
	depends on ARCH_SUPPORTS_UPROBES
	depends on MMU
	depends on PERF_EVENTS
	select UPROBES
	select PROBE_EVENTS
	select DYNAMIC_EVENTS
	select TRACING
	default y

...


However we also need PERF_EVENTS w, which is defaulted to y if CONFIG_PROFILING
is set:

config PERF_EVENTS
	bool "Kernel performance events and counters"
	default y if PROFILING
	depends on HAVE_PERF_EVENTS
	select IRQ_WORK

...


config PROFILING
	bool "Profiling support"
	help
	  Say Y here to enable the extended profiling support mechanisms used
	  by profilers.

So maybe to be totally and completely pedantic we should add CONFIG_PROFILING
here too.

>
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv@arm.com/

This is already (semi-)addressed by
https://lore.kernel.org/linux-mm/20250610122209.3177587-1-pfalcato@suse.de/,
perhaps worth mentioning?

Pedro's patch is still important, as for any system that hasn't happened to set
this up, we get a skip + information rather than a failure.

> Signed-off-by: Dev Jain <dev.jain@arm.com>

This looks correct, see above for nits etc. but:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
> index a28baa536332..e600b41030c1 100644
> --- a/tools/testing/selftests/mm/config
> +++ b/tools/testing/selftests/mm/config
> @@ -8,3 +8,4 @@ CONFIG_GUP_TEST=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_MEM_SOFT_DIRTY=y
>  CONFIG_ANON_VMA_NAME=y
> +CONFIG_FTRACE=y
> --
> 2.30.2
>

