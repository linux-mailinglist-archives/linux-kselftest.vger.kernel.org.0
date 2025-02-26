Return-Path: <linux-kselftest+bounces-27614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3CA463EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802F03AD3A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E0221DA7;
	Wed, 26 Feb 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMjZOfTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632021D3E6;
	Wed, 26 Feb 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582038; cv=fail; b=btirChwJcCE3/AvyJGU0DXY9kt9PfBQDnfgCFeZB1BeAaFgc7/oEkbhhk4HfaIxJ0XaFigvhyQQkC/KUMvmCOPJeeihc7fidXwWpuOuUd0e7xrTdnA06p4pMZyVpQwk78RCqeAc1IKjj/KPPiVBP/8jwAtgpVJgBGfxswa4hXTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582038; c=relaxed/simple;
	bh=XWrtUPcxGgNOXTRTcSRUNlS+Xe9XmUSZzUtDibumbAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEiq7/rCYwkjmD97YMbkFyKLFBR4Q0TYXbx3E4Hwc40MhIin5Wi8CXzqvO3oWTz5PKB4QUPiU/Y1CActjasC+WczB7D4uro+fYRTZsGkX/URg0BNwk+KnTU47gDB4aXKeBOWJ6UvA2YlNYzBDDHViwZIB8sqAorkBlARF3lsRrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uMjZOfTR; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ+pk1bvcqaKE7O4znNk64YW2xOk06NkSWQU0PJroksdBesAfvmL7skD0LlqmA87nKowakGW+dYKXatl62/IztTj6gm3LpfPXlRFBLEzjSZBps6wsdi4O49IBpC7zBBiHTCYkgUIwlFUQPrvwSjnwbXoQYXYoxKLy2d/A9kD+a5XhtIwjncR6BH22xQAFUuiisBuZxZ5bGnNbI2yoMudHXu6xIXwLDOiGR9Ej7/RvHqWjJbkdmslC9cWVsmr85JFOYCJm5MoqS0E52FppdsuHVOITq5w6oOkoy3uMiywZ1megnymhc1KwhvakCFi9f9m7LfeyOKQojgHUnbwJ9988Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIQkrFarMjpufCouOsby06lL+9IvhoBP9akGnh8Qet8=;
 b=pUG/8pE48ZhJtX0tVUAly2J9RwSPO8J2J+8FlD6oSMEuYniUc5dJY8gaucHLFH+PJzlJTbr2kXNBgEl/A5i+VQhzlMvDDaakRCMIm7+lukb4PXT92c7j+G4qb8DK78GVrEWIWEwPWCv05tqOr9yWbXoEHLg1JcaY8KqwO31RaEkfcEt70tsVhZzO6ZUxzoEv94RJ2QHUEktnLZAZMOm7qzqkfKY7gEDHH4KzcrRGPG7z8H5le35MNfye4402hQyqqiti2t4sipIJdXROtrutn8/N2obotkBzZYNBskHDIzh1R4IhazAQzf2YdRhEgF4cuLg54nz4Bk3tRAw61SoTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIQkrFarMjpufCouOsby06lL+9IvhoBP9akGnh8Qet8=;
 b=uMjZOfTR9yASk2GuPbeOpmVXTjAnHLHqJhv3J88y37dpDFAmjk8sTsLFIBxKLkDWlrhG4wTd8quOWbVqUtFzRNUv3r9CHWBm3QQ/35i9+nRG8ZNOmY5xehmuFbU7e20cKREqIiSUjrWKMsDN9VTICCk0hoT7lCP7m5quu43WLisfxfC1ads6NOnZK3zYDnFQ9rW9PCBfEV34+Vj7K2psMO2fOiCJnqSpGH7kJr+ysHKnoJdrXJNXTc/yZU+uLDwmg1WMj7mbFpO/LGlofi21P3Jz/pZtP8OjMDNeWCc3qknWoXCMOOfn7YimerQ7GG1GOypN4RVNc/Q+XtT8v4ZqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Wed, 26 Feb 2025 15:00:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:00:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] xarray: add xas_try_split() to split a multi-index
 entry
Date: Wed, 26 Feb 2025 10:00:22 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <8FC0353E-EB2D-4C4C-B96D-8BEC06FE77F7@nvidia.com>
In-Reply-To: <e5d967b9-fbc0-497f-a4a4-6f2bdc902400@linux.alibaba.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
 <20250218235012.1542225-2-ziy@nvidia.com>
 <e5d967b9-fbc0-497f-a4a4-6f2bdc902400@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 824263ad-86f0-4d6e-b838-08dd56764e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2JYcWpibGFqUkJEVWFrbXFoNXJTdFhCVkFlTnBRckR4K00raXB2YkFLVHRW?=
 =?utf-8?B?ZWZMcy9SK2xraHhyMkQ3ZVlndkg5ZHFEV2hxRzd3amkwMFBpTzQrRDlNMnRC?=
 =?utf-8?B?ay9ya01EWmI4bi9rUHhzRTFoZVQwQi8yZmVpK3hmNzVhYUF3Um9aNUNLeThW?=
 =?utf-8?B?ZXNsOGZrUFkrdWlBZkNpWXNvdTd4Z1B6aXJJTDVncWtGT2RueVdjd1o5Tk9F?=
 =?utf-8?B?UVJRSHlURUZsL1BJaVh3QnJJVm5WSUVWSnRXL1FUWldtWW1SaFZST2RMczQ0?=
 =?utf-8?B?YWd0MXBNbStWb1N1UDEyRjlPenZRbFFyWHp2WVJnTFhNL2Z6ZmlFOU9uczZu?=
 =?utf-8?B?eHVZR2ViRjBrcTlQazhzNDF4TEl4TUdJOUQ4N2lZVmJJVUs0b1BVRzZyLzhj?=
 =?utf-8?B?bjFYMlpTZzkzWVRpaDVtRjh5QmV0RVFvaTE1UjJVOWNvbXByUU9EcE1ZWXVq?=
 =?utf-8?B?akZmblVodDJCWEF5VU9qOGJvUnJ2MkFiOERNUmIwbFBBcWk5YmdzdE1CM0p0?=
 =?utf-8?B?cjFlQ2ZpaVJtN01QUzhkbWVzeVdQejVwMGd4QWJtdmhYMWYxZ0s3QmhaMUcx?=
 =?utf-8?B?S2FoSFowTzFvbWRRenA3Z1psUEN5NTBYczU3MlBJbFhDaDBZV0tjZ3NMYXBn?=
 =?utf-8?B?c1E0S3JCa0pMa1BVQS9mS0JjUU9aQlhLK3h1YTNaQ2R2OGpHbEhydTc2TnNY?=
 =?utf-8?B?dGlCRUFRZHp3Qm91V0xrOXNzVEJnUDJTelVIcThLVnFnMWhxdzJwdlg3eXVh?=
 =?utf-8?B?cytRV1ZJeUFiMjB1Z05jYno3UVRPWjVQTXE5VXB2WUo3OVhpendhV3NTVDkr?=
 =?utf-8?B?MGpKKzFMWVR4MmFzaGx5TDhBVDY5WWlncUJNK1dvNnJyVkF3MkI4enZrVjJs?=
 =?utf-8?B?b2lIbE9ybkRDZU0vZk4xSmZhN0NmTElZNEEvcjd0aUFBN3IxczA2SUZUbm94?=
 =?utf-8?B?TXp0d0tFSWhSZCsrME94REN2QTg3RjB5UmJmT3I1dUxodE5CTlI3UkhpM0tI?=
 =?utf-8?B?QTR5aXZjeHAvWk5kbjRvN2QyQWhRc0JxNEdxaFhLdnVFVTdlVVV3UCtqc3No?=
 =?utf-8?B?S0FvYU1OTjNDNWVERmxDUmFMQy9sV0NjTzZrNW8wTk9PNUxKMHE5NTlwOXhq?=
 =?utf-8?B?K3NUOUlJSkswajRjTU5PRVpJWWFqQ29sSk0ycXhabE1nR0xpSmVBT0N6V1Bk?=
 =?utf-8?B?RzlvdzVMbG1qSGFLc25COHhiVXprelFORWhhNHFuUXlETC9xS0NQZjhSTkFP?=
 =?utf-8?B?R0NkdUNGK1kzWWppR2NYME1QV3FTcDhEakpKL1BzcjRKeFRLbUhocVAwRXRE?=
 =?utf-8?B?bWNleWlYVk9XQmhJR0NGdVFzZGhvcmIxWVpRaVVYV2J3VTJ5dUprcmYxeVRq?=
 =?utf-8?B?SHNTcGY5bCtndkxpOElkVWxXeW4yRHRJRXZZUGNNbHpLaUl4cWg1aXVBUjZO?=
 =?utf-8?B?OWl5OVlyZnVhSHZQcUkyL1dkSG9xRzdvaFBWWlpwZlRUcXQxQ2N6ZUJsMzdN?=
 =?utf-8?B?Q1NkZmF4SndpU0lRSmtWK2xpU0RvOW8xZjVLSGxJZVkrQ1pTYkRYMnJrOVhL?=
 =?utf-8?B?S3ZuWEhBWmFVcERnSVd2cWpjY0VkcmhzN3VTMFdka1hRSWRhaXJLcXlwYWtz?=
 =?utf-8?B?MHhMSm5WVzB2SWI1UDBOMThwWmlPK0JyQVh3Y1dKc3pPTDM4cDJvWXZXUktR?=
 =?utf-8?B?djZzaHdRMFNKTEcyVjZYLzluV051VDkrVGZrVjNLaXMyUE1oc25HU09pc1JF?=
 =?utf-8?B?anJxa29VMEtLRUY0amJKWk5wdXlWMGJqQWgzUzdZL3g0VVhlQnRjcWhiLzc0?=
 =?utf-8?B?emgvbWl5U2NuWlJrZlVlN0x2Nit5Y2k5cGxYWFhvSTNTWWEyT1lwbzBpaXBy?=
 =?utf-8?Q?/QqAmqjZhBTsV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnM1Ly9pREVEK2tOblA3aTU0TDhYUWVYU3NtVVRRa0xzNmUyK2wrUy96N1pi?=
 =?utf-8?B?Q1ZZZC9sZTVwVG44elI0amtIbzRaSzlYNElMYStwd0Iwa3BwYlJiQm84RjdN?=
 =?utf-8?B?L01LRkZJM2Nqd1ZldzA1NEFIbDJXek1GaXpIVUp0dnNGYzgreS8rcCs4bWZa?=
 =?utf-8?B?NnVEbG5RSG4vMmJhUnZlcWNCNnY0eXo0VjdzVHdWTWxkb0dQdCtBaUZPRXdz?=
 =?utf-8?B?am1NaWJReFU5akFwYUlPbmtnYzNGbzdIVTZsVlkzdnFXd2FqYmZpenAyQ3Q4?=
 =?utf-8?B?UE9NRVRTcGxWc0tSZklHV1ovNHQ0aVZPa2U3Q2ZwTEZNR2trYit5Zmt2UUZq?=
 =?utf-8?B?YTFubmtLYzNXdVFCVzlFTG8zVUJNNlU5TjNWNEYwM2h5ZkJxR2FXTkh1TEN1?=
 =?utf-8?B?ZGtCSHFXZmVhU2xOSnM3QmVZV1NDbGZoS0RJYUZwaHFWT2hTUTc2SUxvTUJj?=
 =?utf-8?B?Zk5xbTNiSnpLbnNQTWNUaktEeWt0Vk05TWdRMy9lTVNTS1FRVmhyVHV3cC9G?=
 =?utf-8?B?eTVSYkZTcEZ0bVQrclpOK3lOUTQ5UjQrL3k1K1k0UWY4azI1eitnREFkbzFZ?=
 =?utf-8?B?ejdLMlh5RGNrckRCSWcraFR1NENjSk9MYXZ4VmpvMjNVaWtuZXZyZk9lY29i?=
 =?utf-8?B?T2N0WUhMcHQrZVhFbGcyMmN4NmV0M3pVNTJVS1dtMmdqOGZZaEtpTEkzcmVE?=
 =?utf-8?B?QXpKU3VacW43QlhaU2xtNXRIbThUWk1FclR5VmRzQ3VUVmo3QXpmbEdzdElJ?=
 =?utf-8?B?UFI3YVZlZlNEUXN5blp6aStmcnFMa2tLb09saFlReGFtS2xyODhOcFhZWkVD?=
 =?utf-8?B?a3cwWVJvT2JZS1p4ekF3MUNZdmRqR3pEY09UOEo1OTB1TTY3N3VxVDNmbkdO?=
 =?utf-8?B?MGFUajVSNVRFTTBtd1VtTGl5UGFWcWFmcVF2VWpvZVpFcjdUS3h2OEJiZXZL?=
 =?utf-8?B?bUxxM2pYRk43eW8yb0VyWjNNdGNGT1RsWGhiK2RZQnBNWFdqNUxlQWlKK3Ru?=
 =?utf-8?B?YlBuNlBTZmJCemJCK2cyK2lTajkrc1R6YkkvWG1FeFZzaFRKc2IyQ1JZSWdH?=
 =?utf-8?B?M2k1Z203am1HbHdQbU85VnI5M1IrY0ZuTWhTMmhnS2RXYWV4QjdmTndQa3Js?=
 =?utf-8?B?QUZHbDZBbnZiVkhGb3dad2t3ZDF3WHhqRHM3dEg3TmxSL3Y0OTV2R1dUVFl6?=
 =?utf-8?B?V0F0cnZFOS9YZTh1VEtodU9hK2dYcktzU295MWlRTTdqK04yUWdneXdVRHEz?=
 =?utf-8?B?Tk50d3dYc3FOTDhQaXBPLzNDaVNsSmltVkRyVzZUTGtGbkZVSnVNNUk5SXd5?=
 =?utf-8?B?R2NOV2ZxMmJnc0pVZkVxU28vYVpCVlhScXllRFRTVDVqVUlWejRpTEx3Q0Qr?=
 =?utf-8?B?bUZtZktxdVRMS0tZQ0phZ3oreUJUWnU2b1l1dmVkNEJEVUJTbnZtV2dPSURl?=
 =?utf-8?B?SlhhZVY4ZHVJZWlzTHlaMXlOa2llaUZzRWlpV0NhSFBNVSszaFEyYm0yZE1M?=
 =?utf-8?B?N1hONHhhL1dpZXFtUVpFSnBpbHJWZzFyb2U5WXJGSGFOY0Z6SFF6NnFhdHdx?=
 =?utf-8?B?TkxWaFJyTkRBVHJWaDlKMWQrUzlqWG5nTUgyWGN6N2dmWXNOR0ZQaFIxUzBI?=
 =?utf-8?B?cHM1Y1g3SE41c3lXTnczeENISUtTZWpkZkhrZXJpWURwdysrRFlHeWFUOWUr?=
 =?utf-8?B?ZVZUTFRpVUdmRWhwc29Na3R0Qm40c2d2Uk9hTHpEc0RWTjBQVm9PVEZhSHZP?=
 =?utf-8?B?M2NsWStQRTM4c3pNS0xvK3pWVGwxTXQxcGRuR01aUmNCY3ozUkUxRUQ4d2F3?=
 =?utf-8?B?ZHdEbjcyUDdnWng2STJDMVVrR2tkKzNGSjdtWUcvQjhraWhMRkJmNFJvS2o5?=
 =?utf-8?B?SDVQTkRkcUx6cG1tSllvZ1l0N0tRczBPd3FGL28rWnhTK3hZSzc2eFFVWWt4?=
 =?utf-8?B?V2lEOGdIdjd1cWhhYmxBWGR2TmdRMHgvS09SS0lQQS8wditFdnhIbW96eHNa?=
 =?utf-8?B?RDBhRldwN3UxVlBocDlDbVRLTTYzYjBzeHk4RG1TQk9LT0lFc1ZuQ3orUkZs?=
 =?utf-8?B?bjZMZTl1YWk1R3pBM3BMaGlKZ3paQWE0YVQ2NWpyT0xrS2tsT2JYT3lYdnA0?=
 =?utf-8?Q?Wms5wlEHXC+5AvV64eHoei0Pf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824263ad-86f0-4d6e-b838-08dd56764e49
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:00:27.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrUli/TY6b2vXxNHFR9yAOAiI0VyFHiwrxujwjb9Gh7rreQojkeQStqvZ9FTCbLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

On 26 Feb 2025, at 2:11, Baolin Wang wrote:

> Hi Zi,
>
> On 2025/2/19 07:50, Zi Yan wrote:
>> A preparation patch for non-uniform folio split, which always split a
>> folio into half iteratively, and minimal xarray entry split.
>>
>> Currently, xas_split_alloc() and xas_split() always split all slots from=
 a
>> multi-index entry.  They cost the same number of xa_node as the
>> to-be-split slots.  For example, to split an order-9 entry, which takes
>> 2^(9-6)=3D8 slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8
>> xa_node are needed.  Instead xas_try_split() is intended to be used
>> iteratively to split the order-9 entry into 2 order-8 entries, then spli=
t
>> one order-8 entry, based on the given index, to 2 order-7 entries, ...,
>> and split one order-1 entry to 2 order-0 entries.  When splitting the
>> order-6 entry and a new xa_node is needed, xas_try_split() will try to
>> allocate one if possible.  As a result, xas_try_split() would only need
>> one xa_node instead of 8.
>>
>> When a new xa_node is needed during the split, xas_try_split() can try t=
o
>> allocate one but no more.  -ENOMEM will be return if a node cannot be
>> allocated.  -EINVAL will be return if a sibling node is split or cascade
>> split happens, where two or more new nodes are needed, and these are not
>> supported by xas_try_split().
>>
>> xas_split_alloc() and xas_split() split an order-9 to order-0:
>>
>>           ---------------------------------
>>           |   |   |   |   |   |   |   |   |
>>           | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>           |   |   |   |   |   |   |   |   |
>>           ---------------------------------
>>             |   |                   |   |
>>       -------   ---               ---   -------
>>       |           |     ...       |           |
>>       V           V               V           V
>> ----------- -----------     ----------- -----------
>> | xa_node | | xa_node | ... | xa_node | | xa_node |
>> ----------- -----------     ----------- -----------
>>
>> xas_try_split() splits an order-9 to order-0:
>>     ---------------------------------
>>     |   |   |   |   |   |   |   |   |
>>     | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>     |   |   |   |   |   |   |   |   |
>>     ---------------------------------
>>       |
>>       |
>>       V
>> -----------
>> | xa_node |
>> -----------
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> ---
>>   Documentation/core-api/xarray.rst |  14 ++-
>>   include/linux/xarray.h            |   7 ++
>>   lib/test_xarray.c                 |  47 ++++++++++
>>   lib/xarray.c                      | 138 ++++++++++++++++++++++++++----
>>   tools/testing/radix-tree/Makefile |   1 +
>>   5 files changed, 190 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/=
xarray.rst
>> index f6a3eef4fe7f..c6c91cbd0c3c 100644
>> --- a/Documentation/core-api/xarray.rst
>> +++ b/Documentation/core-api/xarray.rst
>> @@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index en=
try will set the
>>   entry at every index to ``NULL`` and dissolve the tie.  A multi-index
>>   entry can be split into entries occupying smaller ranges by calling
>>   xas_split_alloc() without the xa_lock held, followed by taking the loc=
k
>> -and calling xas_split().
>> +and calling xas_split() or calling xas_try_split() with xa_lock. The
>> +difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
>> +that xas_split_alloc() + xas_split() split the entry from the original
>> +order to the new order in one shot uniformly, whereas xas_try_split()
>> +iteratively splits the entry containing the index non-uniformly.
>> +For example, to split an order-9 entry, which takes 2^(9-6)=3D8 slots,
>> +assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() need
>> +8 xa_node. xas_try_split() splits the order-9 entry into
>> +2 order-8 entries, then split one order-8 entry, based on the given ind=
ex,
>> +to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 ent=
ries.
>> +When splitting the order-6 entry and a new xa_node is needed, xas_try_s=
plit()
>> +will try to allocate one if possible. As a result, xas_try_split() woul=
d only
>> +need 1 xa_node instead of 8.
>>    Functions and structures
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index 0b618ec04115..9eb8c7425090 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned long in=
dex);
>>   int xas_get_order(struct xa_state *xas);
>>   void xas_split(struct xa_state *, void *entry, unsigned int order);
>>   void xas_split_alloc(struct xa_state *, void *entry, unsigned int orde=
r, gfp_t);
>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int orde=
r,
>> +		gfp_t gfp);
>>   #else
>>   static inline int xa_get_order(struct xarray *xa, unsigned long index)
>>   {
>> @@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_stat=
e *xas, void *entry,
>>   		unsigned int order, gfp_t gfp)
>>   {
>>   }
>> +
>> +static inline void xas_try_split(struct xa_state *xas, void *entry,
>> +		unsigned int order, gfp_t gfp)
>> +{
>> +}
>>   #endif
>>    /**
>
> [snip]
>
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 116e9286c64e..b9a63d7fbd58 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *node, =
unsigned int offset,
>>   	}
>>   }
>>  +static struct xa_node *__xas_alloc_node_for_split(struct xa_state *xas=
,
>> +		void *entry, gfp_t gfp)
>> +{
>> +	unsigned int i;
>> +	void *sibling =3D NULL;
>> +	struct xa_node *node;
>> +	unsigned int mask =3D xas->xa_sibs;
>> +
>> +	node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp=
);
>> +	if (!node)
>> +		return NULL;
>> +	node->array =3D xas->xa;
>> +	for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>> +		if ((i & mask) =3D=3D 0) {
>> +			RCU_INIT_POINTER(node->slots[i], entry);
>> +			sibling =3D xa_mk_sibling(i);
>> +		} else {
>> +			RCU_INIT_POINTER(node->slots[i], sibling);
>> +		}
>> +	}
>> +	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>> +
>> +	return node;
>> +}
>> +
>>   /**
>>    * xas_split_alloc() - Allocate memory for splitting an entry.
>>    * @xas: XArray operation state.
>> @@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, void *e=
ntry, unsigned int order,
>>   		gfp_t gfp)
>>   {
>>   	unsigned int sibs =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
>> -	unsigned int mask =3D xas->xa_sibs;
>>    	/* XXX: no support for splitting really large entries yet */
>>   	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <=3D order))
>> @@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, void *=
entry, unsigned int order,
>>   		return;
>>    	do {
>> -		unsigned int i;
>> -		void *sibling =3D NULL;
>> -		struct xa_node *node;
>> -
>> -		node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gf=
p);
>> +		struct xa_node *node =3D __xas_alloc_node_for_split(xas, entry, gfp);
>>   		if (!node)
>>   			goto nomem;
>> -		node->array =3D xas->xa;
>> -		for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>> -			if ((i & mask) =3D=3D 0) {
>> -				RCU_INIT_POINTER(node->slots[i], entry);
>> -				sibling =3D xa_mk_sibling(i);
>> -			} else {
>> -				RCU_INIT_POINTER(node->slots[i], sibling);
>> -			}
>> -		}
>> -		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>>   		xas->xa_alloc =3D node;
>>   	} while (sibs-- > 0);
>>  @@ -1122,6 +1132,102 @@ void xas_split(struct xa_state *xas, void *entr=
y, unsigned int order)
>>   	xas_update(xas, node);
>>   }
>>   EXPORT_SYMBOL_GPL(xas_split);
>> +
>> +/**
>> + * xas_try_split() - Try to split a multi-index entry.
>> + * @xas: XArray operation state.
>> + * @entry: New entry to store in the array.
>> + * @order: Current entry order.
>> + * @gfp: Memory allocation flags.
>> + *
>> + * The size of the new entries is set in @xas.  The value in @entry is
>> + * copied to all the replacement entries. If and only if one xa_node ne=
eds to
>> + * be allocated, the function will use @gfp to get one. If more xa_node=
 are
>> + * needed, the function gives EINVAL error.
>> + *
>> + * Context: Any context.  The caller should hold the xa_lock.
>> + */
>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int orde=
r,
>> +		gfp_t gfp)
>
> The xas_try_split() may sleep if =E2=80=98gfp=E2=80=99 flags permit while=
 holding the xa_lock, which can cause issues. So can we add a check for the=
 =E2=80=98gfp=E2=80=99 or only use GFP_NOWAIT?

You mean only allow gfp to be GFP_NOWAIT or GFP_ATOMIC?

Best Regards,
Yan, Zi

