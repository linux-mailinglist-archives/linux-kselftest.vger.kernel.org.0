Return-Path: <linux-kselftest+bounces-44702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23448C30A16
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C87C4F819E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB392DF147;
	Tue,  4 Nov 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dekNHB2U";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dekNHB2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1E2DECCB;
	Tue,  4 Nov 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253799; cv=fail; b=RurHUeuqEDQ7giMz699VZAcCstkxvtw3FvwuYb46fZql4Eseewye5IUUTuHrhSxyXyA8TSKkgJ7gEjJt8R7sRdPtpNGn4Y/vL2rT/IxXWJPpXbjuTHbAB0ctBtTHBsn2RshOpkVjL2IrAuIMlOz02/pZdemkwfG6n2900DIGQLg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253799; c=relaxed/simple;
	bh=rheO7/SHRsJ95q4xHbhGtvHsHy+xTg+9uOviFvk443s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g1Eg5D4aGuRm5fGl5Icoz55hivcYJiRUt8lKCVFUx++R44ZBa0SgGuPcdJv+5ZdCTl3gs1EOShSbItet8dad+eV/GP0TT28m+EYFC9oqBm12s1RPtyXc3kST9az3LPaUJ4ZNdUyP6HsTwaPNut/ERlWV0Vfgfx3L0SU+9JgB0hk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dekNHB2U; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dekNHB2U; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mACjAS+y2vl7vbIyY4y4kTxsi5fXwdec+CcJhCcjzm8urGciskU6Rli9GygSxkLjmHYmi6UOlZ+vPyrT6AzCKQ5rlwuqlZMZuu0nXHxZ0I42KVfux1eCpOmEMSvNHsK5lUFt8fcrbpwMwnZh8tYbmFX8gi1jxhvlwc+9MTMx6rcpmpDxB7jCgOCuknrvBJGghrP7lgZzjzEahIgLhtvlx+a3A1b26U5KM0SZmqZCRspSFb9jPg6kcHMC8SiOjgZ+gXxCF9JuTc1h3qvisPJA0Xdg+tcQsZ06PUrlo2maWnUW/T2vGpp2b/WRQDci+FzM6/tD3+qxI2/+e5JKKxFMUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz9sUTxgd8i35MnPofnScDL1PQybPK7Bspb516H+/h8=;
 b=FjX1Xwa5TTOn+zU6sQxzSnAr35S5eOblxNcy9mSfM1qG0vQK9XyfkcSbn8EcQEXzx4CoLFgMzH/ekFkXAWGAhDbqvCGhqH2/OKKT4N8r55878fgaWgpJvDGGx9grKqoXU/pIJVBDhRjsOE+P36/0QR0tZlFowWwGPso4aY4kz01Z0nrr85/KWQNmVGA3Hww5BwyfFHob1l/+Gzuya4tEXM37Yr8SJ47POo6BVN8+gFPhA9wCBhp+cCFNOBjjueJVTGWXMzlKr9BD/QxlQ0R2JgN1felXwWEpaBHbQxl3vNp0kCbkQ1u/4S8Z3TfPwTQ41hzVXagLjYNA4laYgWYbVA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz9sUTxgd8i35MnPofnScDL1PQybPK7Bspb516H+/h8=;
 b=dekNHB2UROs8Lx3pPaQfpdhovIlQf5E5+4kR1EsGKduzlGFEwxJy5+1Vi1Tmd3GYRTppMTbTFiwTJoBXmJ6T3xbEjnQEvz7UwEPOlnYDD688UREpu42Zbfv1Td8go0b57E7aagfoi6jVr54fUV5a8TXYPh1uHMASv+UvHUth9Io=
Received: from CWLP123CA0106.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5f::22)
 by PAWPR08MB10184.eurprd08.prod.outlook.com (2603:10a6:102:364::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 10:56:32 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:401:5f:cafe::1e) by CWLP123CA0106.outlook.office365.com
 (2603:10a6:401:5f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 10:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Tue, 4 Nov 2025 10:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJTfxY+0cqFoG+rVbyqa0NChVtTTTyYg52JMmi9/nvy/S3WuJvMjiPIkJvt1zGEOObq6I5pbLEzaO74QPaZHbQaC/sl+x/gIw5fYPIOvpZ8A3EjR0LsorMUbR/DxzhByA9xS9cRrbhWn+jVz0gEEhvzM983IveKAw1QgRLB0w7oGJ0flIQ/BGemAghlzRKDfVyYC7tFbklS52A5tPYexRmCQea5AQwZzjPGBNKOpcC4984pIXkn2IWHxc26Jf8ptLDGV11E0Q6FvulMKA5t/yldZO7gVTXYWjB8Mv8dqP5br5vAJ7cnIDvhnBKfiBxzteJqdDXyR5HeVdKzULHk6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz9sUTxgd8i35MnPofnScDL1PQybPK7Bspb516H+/h8=;
 b=izf9L0Jmd8elv+j4rdBJFQlBVTaNybThjvGRKJRTPhh/vrEH/b0d3inGnwFchbFtAUN2p03SdK6Ix6LH/N+gKamM2/wdiTw0Z0vmlO+hEOLSdAImfYZvlWrExc0TghyV3Tlo4WfMak7IAQdaSQ+M8tGMPieRemdqJfOeJltclXE6meBTVv+BpWF0V4G5pyMRGYgPwe2JtPF+4mQ0rEAr2ctfLt2hf+wIiphbk4LQLmLkZYjXfidFMykyr71oMPno3cdS5tmIoCwJIGKIwGrmqFMKSyBlvrPQb2H0nqHAPTlc/ehCehSbmBbUk2LJ2fP4Ac6iwIJceSbqph3uUwtTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz9sUTxgd8i35MnPofnScDL1PQybPK7Bspb516H+/h8=;
 b=dekNHB2UROs8Lx3pPaQfpdhovIlQf5E5+4kR1EsGKduzlGFEwxJy5+1Vi1Tmd3GYRTppMTbTFiwTJoBXmJ6T3xbEjnQEvz7UwEPOlnYDD688UREpu42Zbfv1Td8go0b57E7aagfoi6jVr54fUV5a8TXYPh1uHMASv+UvHUth9Io=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by FRZPR08MB11070.eurprd08.prod.outlook.com
 (2603:10a6:d10:138::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 10:55:58 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 10:55:57 +0000
Date: Tue, 4 Nov 2025 10:55:54 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 3/9] KVM: arm64: kselftest: set_id_regs: add test for
 FEAT_LSUI
Message-ID: <aQnbukTOkz+bHDrP@e129823.arm.com>
References: <20251103163224.818353-1-yeoreum.yun@arm.com>
 <20251103163224.818353-4-yeoreum.yun@arm.com>
 <aQjcYwHstanefv5L@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjcYwHstanefv5L@finisterre.sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|FRZPR08MB11070:EE_|AM1PEPF000252E0:EE_|PAWPR08MB10184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9376f8-071e-41a1-120d-08de1b90d06b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?AOHDN5CQ/k/ucOAwyrFDkYz+J8HxOUpuR8kgauIDmmssc5Rn0skmETv+NVms?=
 =?us-ascii?Q?8385ZLcEdHzt/L2OhXQEka+X4WErXj7xbojb5F8ypPDTWqH3MRyCcwfC48/G?=
 =?us-ascii?Q?wjvALDLsVkoKcpB2sp28CVTSs3o6ylNIJl+K3LZcSHi5lHve6iDLWMzTnKUE?=
 =?us-ascii?Q?9BEYc3euHsjNmqOu8ho0tf5Z4IUz7TOTTqg5W5LAh8NDkm+3cO3rNKHFJNTj?=
 =?us-ascii?Q?Urf5uTa3UUpqHKtD24qkxqdpfD6S85mh2yymQ7VpNZNh+4DBmcOQsi5p4ykL?=
 =?us-ascii?Q?0nC8KhcdYz1NvoqCxDPI021b9v2agbzPKaRsN+Cp/g2JKCdFeyk/FGY/DKzy?=
 =?us-ascii?Q?tGhsUWiiTw66gVpoJNM08yYS7rMNsy47X3PgLDFEDxBhoNWjN/Kdx/m6hdfM?=
 =?us-ascii?Q?E808RdrZyuDNN+B6XLlpnQigQaDkpl0WnY3erYAgAr2NWvt+X2SQQ2TkTZro?=
 =?us-ascii?Q?d9zHLtKCk+2B6ni9OZr1QKI46THTd05Cl0mxWETImE5Oju/G4RxwM+cz8NOk?=
 =?us-ascii?Q?uQBiOu072+Ws7dPAVmYLrVgutYldrqn9PcBP1BuqGRG9ft+WaHb35mKuTIpF?=
 =?us-ascii?Q?o6RjwCKFDHfXlFWSmXwEWhN3+85fDRsy9RjcSh4i8sMGjugWhu5MX8l6dPB7?=
 =?us-ascii?Q?u4gZWYcBIcJ0+Vz0jcrSoQyLK/V1mK8Ya7aQzxGOiFY0+Fip18IumlcwYC5Q?=
 =?us-ascii?Q?/4GwA3rTx9hcnjzqiuPut3AI3jEAHUEFqqSks3DVigMGz1lKpf154zxpIC0A?=
 =?us-ascii?Q?ZRIq49GE36oEnjk0WgRDDMdkePLiemjVp+cAsXbI5C6jG5PVycbm2X0SK76Z?=
 =?us-ascii?Q?9Vr0ckLfJQQv0P2eyuoLRYHmuVK/QGqApGqmpQr93KWzKlomOeSgM0xqk+/+?=
 =?us-ascii?Q?QJ9CnU5r05kpgD5gXzaFtgaPoEiuqsHN+cEf8jNs4N7C4nIpINTm2qeUKSrb?=
 =?us-ascii?Q?PjBseusfDrNRpdMdXAIwvJEk0tFclpYelngOqhcIZLxDB0v4PG1/Nthsu61X?=
 =?us-ascii?Q?P2EqrF3hmyP9Fa0MYls7znVSI8R+DQhiVXPF6oQ2Qw3YvIza0DsUmtXjR9tr?=
 =?us-ascii?Q?AeckoXCRFUtuOejcAkA3bGx4K5yu8tAgvWEYLtuLPqI81bRt3Lt89ITptXU+?=
 =?us-ascii?Q?yqEOTzvitYfRkLsT4fC9fR7MO99IAaUaJP64l+g3CRTCf+0NNvQZYoJdU6hc?=
 =?us-ascii?Q?yQVUKxPMZVTrAXFF9WaMh/0QsoJf/V+SsDMQtmkDrK4DL0/03AHcz+KElZCk?=
 =?us-ascii?Q?UfIxmWrh7EwWgJeYnO3uz4z7aBtI7DmKge5vPvlYZ+p+38qlD1Rn+6yX+Btv?=
 =?us-ascii?Q?fZwPUAVNvDWzFNbb9M31M3SUmait3H7Jp3/V2I3WnbsIJqtfzPByWBPQb8hY?=
 =?us-ascii?Q?2CKtg3lTgfyGshss+qVVS/mRzXSZzHFZ24ml0mM3MBoW2hCO/FTXlwF7SYqd?=
 =?us-ascii?Q?oewrnOEltHomepBxnyKJjM+tv+N06dsH?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11070
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3c7b1e85-d01b-4748-4bd8-08de1b90bbee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TUgOKT3YWs22rJTE9DGLSOpAfyffUKMdpR5rm60F1ohiYwQAB+0xXIb4jRSG?=
 =?us-ascii?Q?bwjCk0AVHL3jKux5KS+/+KgLDzTXWx5LuoRzEfaW2HulgL0qiqyUQxbYQlwK?=
 =?us-ascii?Q?A4oaLMI4TqdizCLskmRYOuBBn5DndlgdSCKYmVWVtjDxeyeFxdNxllmgm5mY?=
 =?us-ascii?Q?voW6ZkQqAsq2dE+9d3qytEbCuROtoT5G+S6wN9hoJ39qxNZ0Y+oE4vtorCij?=
 =?us-ascii?Q?GaCu596bU5G/zwevQm/TSiw4eHf0BcpUBpC9N5jxQOX9ayebWhmYCNhfDOpi?=
 =?us-ascii?Q?t9GwyKecQs++GdMfuEAoi8sv8iGqhIl8OOjsX+MwaDAlKw87MHmSojSUjVt7?=
 =?us-ascii?Q?RfeZPyHgw7kyKjE1TxC4XCpV76uf6/iZdnnKPmyAH9RPen06uxX4OPxyV7Tm?=
 =?us-ascii?Q?S/an0BtDM4fJcPhbK88oqPXMsx1o+6jH+CWeUTQz5DqRgyF81KISLJ4pFVmH?=
 =?us-ascii?Q?FrGxF3mOrpOm3wKy6y2Sqj7fvHN9xWXE70G3BqRC92wIc7L7T0Lo0BHvoqMY?=
 =?us-ascii?Q?gPsvY5RBIbaIvnyRk+ZWg55XPQEL3w4Dk7UscO6XWzuSHVmWfzX+W6w4ctNM?=
 =?us-ascii?Q?wPSLTHxnWx13Au+onwBXhBjS0F6E2oVBWa+ygbzggeOnK4SgI7+Jd8FU2xxG?=
 =?us-ascii?Q?LdmtYJ8SHkzo/DBvxel8CUhKV4ceTHcTnBwXLTO6hOBWsA+Fzw2gF/V14/yJ?=
 =?us-ascii?Q?Tm+qXyZOq6u4MCKKp68iYhImoaOqQWcb6Zl9IxZ5bAeKVQ6YMEy8qWSnK35G?=
 =?us-ascii?Q?bw/cSlNKVKK8JdZtBMOwGeBdr+4BSLaTQ0KIXErmwRbiAwoxNVIPu9zbRXr+?=
 =?us-ascii?Q?iH3woZEWu2dapSX7WbLdB9X0jdIuOd/JQ1dPzXBmiGetmJSf18GKL5fs29Wa?=
 =?us-ascii?Q?vmDQDIeZVpZl38fUEzRMt8/khJB0gAslbnSQ1gEqK63s0bHF63hT+JlnlYFD?=
 =?us-ascii?Q?bd6KRiX65dFwFryLvd9OnQdl53KGMIEKAOr0c6aM/yWp7mzz2NJoEOw3Whsv?=
 =?us-ascii?Q?XXyMkj7Je2v4FypWZ9RAhsyZf//PO+MhM+bQ52nXfx5e4hhEghsXvhi5Oge4?=
 =?us-ascii?Q?rr9XpY63wW89feHwOiR+2rHjrZTe39bvfOYz6ImREG2OpLCWrOrHD3gD4qq6?=
 =?us-ascii?Q?WixZIQBH1OMd0c1sp0EEb3FlR0V08y3GT/ou433y7YmgTO4uU9q15RiYxCku?=
 =?us-ascii?Q?7HTHtgiPN07XvtkNAVlO+AYxiIxu7vaac6BjIYhqTT49zvqFRju60QRoulYa?=
 =?us-ascii?Q?W2CpkWLvUPyt9Aq1eLPb5GGddWjuy9+2+BLXbo5YDF8A9PRSC+DXCoPhAGpx?=
 =?us-ascii?Q?asTO6Oz5qRh1mlMc/vk6fpMQL7nwwLsXrABdhVs5dimFLa9P6+eqMWPxDtOh?=
 =?us-ascii?Q?O1AtzrpD4T3YLSPcqv5+rF3lBNtqz+sajJ0L4ivkLaIbANotiteV76ea95pB?=
 =?us-ascii?Q?sbt6zinAfdM3ADpytYav5uB5NZEirFttJWZBFohUU5sfUxBuANTQlT2MQAOj?=
 =?us-ascii?Q?/M2LqRRXWIrepYCjWMm7FQpyCsOB5K7KG5uY4gHXQw2WdHw2lblFbuNxHz3M?=
 =?us-ascii?Q?HRdISVagqJPFk3BvpAA=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 10:56:31.8209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9376f8-071e-41a1-120d-08de1b90d06b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10184

Hi Mark,

> On Mon, Nov 03, 2025 at 04:32:18PM +0000, Yeoreum Yun wrote:
> > Add test coverage for FEAT_LSUI.
>
> Ah, sorry - I see the set_id_regs change I asked for in my previous
> reply is here actually!  Usually the selftests patches go at the end of
> the series after all the functional changes so it didn't look like there
> were any for the series.

No worrie :)

> >  static const struct reg_ftr_bits ftr_id_aa64isar3_el1[] = {
> >  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FPRCVT, 0),
> > +	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSUI, 0),
> >  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSFE, 0),
> >  	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FAMINMAX, 0),
> >  	REG_FTR_END,
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for review!

--
Sincerely,
Yeoreum Yun

