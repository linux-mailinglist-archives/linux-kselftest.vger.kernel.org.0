Return-Path: <linux-kselftest+bounces-39978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1CEB3711F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0FD367589
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF02E3715;
	Tue, 26 Aug 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mztGJsPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3492E718B;
	Tue, 26 Aug 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228734; cv=fail; b=uWBUgPrYYsWBiq2uI8wRLzL4GY2oz0pmhEj1vwcvrGtUdpnOjk9xPFXls0dw4wM3+wvH+kJ6mKsB9nCofA71ojhqZKnc3+x8J62bpDKFbbrIl6Fnk9mX0K/dIQDtygUMjLqezzUtoyxnaWVev9dsEFOJs3Ja2zVl30AKfbWNZqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228734; c=relaxed/simple;
	bh=DFsWV/SSBddaBFH+EUNK3aVLOLqPSWWqj3a/naPsp04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQ2DvZ2TkVpWrTJ+r8UZ4DRZ4H93dksSHa1f2qr3zwf+iytt7PpioexBB2UtCKVndxR2u/+A6lTxL9UjUDAPJYOSsOQuG1hPvnr7qHKTT/fxR08XhViDQW2K9TPV7GojBuywpORcU5LQEWA9oWMVe0hXJ/1wm1Qzu5hEp/Z51Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mztGJsPG; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpmDerVqbhnZSy+Ay2CRQmmJZJi0BCOJGEeIvJQJl8OtvVaw3o50Deh682c8bOXl8AINZ90nckJE9wJQpHiYMCgga1yzeAiQo6kRMpJc12yTNXrV0q9d/leNV19Z1zC8NczcyNs7zL34XS4tACtANL77U9opx4ID7q9zAy5YKvGXZX8cqfn9aqspLjFG5eeF1CWcs4Tffu5aJjwlaQFkksKCI5CemX5dqAgy772szM7Kq8GIHM1+M3ZDcfoJwU2MvuNhGvgBx62B/wLLIn6O19bq5iXkGQ4/vjX3kqQAjGh48VS7D0F3suDEnG1TuMmn81Jhb3+7X84HG1QUobqTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg4Deuc+NC9F/X9/y9DWRYAJQ7gfPyZ1+xv3paYWa9A=;
 b=r4yz5sO5oKNjDfvlEGX7S4KfkuLVaRtSFFchjXzckFygsiLR5PDKovQNoaYChGYjDfLzE2vGC5doeIkI9PUdWrajn2s1wDDGQyr3z3fMA0pyQf+ESgvOvIzkDa8DO/Z298ujEhs5Un7V/u2bjcjXxxQxn9NilMIEfzgpN5wrR3cvhKStx5qAP29BrOQC3HmD0ejxX+kQOpc0gbAxq047dDfIMM79xG2OiULa2/W9Lf7HxQGD+9DqeEdLc3D53rzlSQpP8sVNcOfo5AHR166Zbtqm4ZUmYyTdjDeeAqCMYMjwoNB+RHCL5+CKZ9Y3rlx8CzkK0TtCpKJU+/whIK1ImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg4Deuc+NC9F/X9/y9DWRYAJQ7gfPyZ1+xv3paYWa9A=;
 b=mztGJsPG+/HZ3tCEsDN9P5HU9OnTI8J5VRLBL+eRW/iS8Qf9mZ8OntQoft5UYcyaR6Q9UyN1g/OYVa3pqcGs28M/CNcMKTQHzFJ31baI/hzRbE7K/UJU+uJEVVerD5q8J6E1yw9DcNGBIV4aoMJ5QyzwbxywhbegZTU2Ljq3GMm7FgAKlgscokU1KfZSIp0Ujr1xKxZf/MgjL+5R30Fje6qqZDKuZ87pHlpGRI5IdUD1d+jG2AUtfX9Ozbqt852I/cW1lYvJnKfB2v0SvKire3fd4Ts+K7S25P+l71LxyGWQZCHuxSxcGHQMztMYlUeDgVBwDrrtByLHNjfRN2XxGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:43 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:43 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v4 06/15] iommupt: Add unmap_pages op
Date: Tue, 26 Aug 2025 14:18:27 -0300
Message-ID: <6-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0169.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::24) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ae9316-d291-46f9-43bd-08dde4c49a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yuqG3noUq8VHmeEHBaq4OGjKZBmBj79TtQ1OzYdZXHyCozqRrzp109TUN6LS?=
 =?us-ascii?Q?LzJtavFWQ5DEX/SjJhMvaKhJqhU9YsWBt/FF+Pa3HEEa+BNvQoVrpTY5H3XP?=
 =?us-ascii?Q?q1vrpfVvVgtbMGTteILuudveTSgi+HAnCDkJQBUrLmmtVKIW3eg2PjCTnfib?=
 =?us-ascii?Q?5s7psWhtwz2mNFBDfSHxPRietJlx/jomEQ3TuyarrEb4TzKtRujoOkqiSHxW?=
 =?us-ascii?Q?fKoWmBMAgCqSW5ul5cznyDUOvEBIze8cWWvEhS+j3sCmi1CoRdpztNN5tgEG?=
 =?us-ascii?Q?7GVPUPngbYwY+SdWxkFTJZB3QAw5+iLL3aH07yP8F74sROFE58grELNzH04C?=
 =?us-ascii?Q?Qe3KBM8dllUK64ewajlJ75194PM1AUGyH+gVIGdvycYTF4cEAxyhqQ0rL/7b?=
 =?us-ascii?Q?1HETzRy4IWpoURj5PmkrMLYJcmektXpdQsBHT0DTv5PG0+9soUd/7r6iiOx0?=
 =?us-ascii?Q?ClTBusPanNT63bZOPEswh3MMPR9G7jn5sH7/62vq9Hi89GInDHv5nr4FLCVx?=
 =?us-ascii?Q?II6XE9fvPQvB7/h5FNr/jpVBPHqKQx5yVSbDJeLcvNvfw3l/wgE4vm7PfrMt?=
 =?us-ascii?Q?RVkOZdq//QvJgUKiRZ7bLZc7KjG3EAN6eK981E9WdmnNfi1MQBQhHGPFEhf8?=
 =?us-ascii?Q?iikcwiSFph8xlOOIuFEgLcBBzCgetwugm2mNmjDf1F8gAq0Q1R0sD42qhpQG?=
 =?us-ascii?Q?VYniV8EA6Do5MWJpydIyWCno4Z8jmW4mSi8h2TuG/qTyBaoCnhjIxY4/+ixd?=
 =?us-ascii?Q?MluBDW7cYlub4fQFieoy1uW9zjUIvQNh9UawH+t9WHCsds4vu1CNT4RwnkwI?=
 =?us-ascii?Q?iJCnGxm04LPoGQWuV4zPvVl2r8MBsbJGDIb4WS/V6EeNrKQ3HA/OiFBTa+Od?=
 =?us-ascii?Q?qGlYp/KOo7YEmPLL1wsbQDjIml7BUeIAywAN85Py4+/re6+ByTadja8E54bG?=
 =?us-ascii?Q?Nno6xQdVED3MikoVr/yFCqZyqbj+Zsb5xvMYwNjPGI9Vs3TG2BUVVIR6P8H4?=
 =?us-ascii?Q?TACpgZXBNKeY43drRN9RDgDV/TSiRfbtBormmypYzp6n3QrwQsXh2RKHwH+g?=
 =?us-ascii?Q?6k0ypI71IFgKbYmF6ratxqxWn9YzUPeoX/kq4HCYyP/eWeNER+SBHBYZa+az?=
 =?us-ascii?Q?1Fb3hZ7mx7y7ypGmRYSfh3dbwfrfaS/eT7SsFzdqzjTvnFzAaPgJYKm5IdSh?=
 =?us-ascii?Q?Kqq2dn/sbc7Vy+DAmlYcy/Vv04BJrecQ/DeN++MreFTkdH6AFKW/+LaHgKYe?=
 =?us-ascii?Q?1G95D3jRpU2IgG12uJoH7NOw6Sw4wIWWhLat/+bD1FrAcFLE0yxZvSA05kqy?=
 =?us-ascii?Q?0yOd8quQTx05Xh9Npj01i3zfOkZFy0ieQixUSAGxQbPIufcVm4UKHwDDTy09?=
 =?us-ascii?Q?eiA/75VGnbJs9/YwoGjB54DJN7JQ5K4crlhJAm/KlcM1FNy7wqF8cElY41ow?=
 =?us-ascii?Q?S6JZvGD3r6IhflqR31PnES3YuyQ6i5klnsQt+JMky7q0D/JvUcKLWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77b5ooYOV4DPKXgquQEKoUOczzuDHJ6ek32bPvswfYfsfwBuNnLTND72yjCQ?=
 =?us-ascii?Q?hWAK9mTkJTY01vB6H3UtxCNzF0/dkjtbf2YT3Jsz/REqssdcU++E+ax0i8/5?=
 =?us-ascii?Q?ETmckmLsu55MVRIFqsZ5135+z1F6GdmwPQmczz7yzxtfpswN+C2pENBfuKjU?=
 =?us-ascii?Q?K4HC+wWAt/0ZfvEd4WK/0cEyMAJgQActCnrx+0r4iz2KM4xRAT2Ko9IUXqlx?=
 =?us-ascii?Q?KPxcl/RvMMIgg37jGE8ynetP90kX5GeEnNPnQYmFj96VwU4+UOSIn9sbk7uX?=
 =?us-ascii?Q?naUUvG2mVbd/9e1j5+hnCnTQ45ponaQxzMBoVi9yJ4GCmhLUtSsDtnCcIwCR?=
 =?us-ascii?Q?DmrE1Da/bOk0BSBOO8m6JYwNQ/s/LEj1jjeJ1hAWDPFmv/IpAidD91+f6Y/C?=
 =?us-ascii?Q?/Jnz0i9BEEna/3ZxSgMUXSVnK48v1v91QFVwqzqlJfk3ioYY50l3o+PxcEz1?=
 =?us-ascii?Q?C7SmbNeqn7TvhCZuMgN6fyGGlYxU9Q435If8SQetw5U110HJIB4EUFZci57Z?=
 =?us-ascii?Q?iQlXfGnW2vnFnvYLwS8/1PDYzqz2wipuVHjX6jms2VYJEN4Y3SrpxGqJUKB6?=
 =?us-ascii?Q?BAfGKgeytV3L7Oaa6RcNze8rhNGI4rxc5DKhnvDfPvoYbbM38yi2zcKsR7Pz?=
 =?us-ascii?Q?IKboyhpeHS5mG2eQv9iCgG/3lYRTHLcEnPuNd7w3Z4s8x1JwQQrnPKareH5p?=
 =?us-ascii?Q?YGBFduVWvoTx8r6Mp7X41VmKHDMFyBokOQAWnKfzKcBnuJQr5mt6P9vvKAbb?=
 =?us-ascii?Q?SUcoGLn92jCpzKtYTB/ZgyI7lQ36OZr1Q0DPzkrI5yr74WOvHYoOb8tsCLcO?=
 =?us-ascii?Q?EQyJLAk/0mFga8sJdV9kTTbeR9lllUvQcpGPz1z8l85Cl+ab55zhH6hjRRds?=
 =?us-ascii?Q?vG2Lx2lnxI7vpCR6eeKAv7+ka6/2U3RsqtHRGvmMQGIfg46kv2rawIV/rFsf?=
 =?us-ascii?Q?1FwLkpHuaOgzs7/00ARLTvXPzLpkWJMf9WVQqONfQrcj/1rMEQHfYpOopft8?=
 =?us-ascii?Q?/Ykfr8PdPme8s+R+FkpZfpUJ/DX/Io/3mFR3X+eVDDlsVnLODkpy4s6VGTE0?=
 =?us-ascii?Q?ov5Rd3Qrmjr8jIYCbO8GDgrk+Pme5kmS3jch96Mi6XB7tUKbQJSBfc2Y9OMH?=
 =?us-ascii?Q?cHFNmUVeL4oya3aWNR2NrImE/iOGkP4BPmh3DDVgq1qc+n17vOeRs4deuIyB?=
 =?us-ascii?Q?8o0Ljgzx/H0zBEe7spttWPaorymSiZxFlJZ1CNS3WHexTzD4gxyVPeC32BtP?=
 =?us-ascii?Q?2u0H/ScTFreAdmFIwvKuWRy3JFskOuyCoOfaQhvra9T+30Q4ZiTIEUMFYtyu?=
 =?us-ascii?Q?iY2G4GzilGqUJmWs1uIOOcmtjeAoj8DPkPhnaCFR6tr3iVpwZ1esWsu5TeiG?=
 =?us-ascii?Q?tcq1tpoDgBiUVCbq+/N0QVQ2i3UnE6tZBLkhVgiZ+gQlbxzSGBkfR2rQ96Sm?=
 =?us-ascii?Q?tjWU5E+L1OY9MDBFwTT8zxPpxgUep2LhjOXwpwX1WA3uySMNI1tUhVxxdCVc?=
 =?us-ascii?Q?aMWp+5d9QjBCpvUrsAnIR8GFj9fVXkHlp5JeT1e+v6+6el+Ema57/UIdYubT?=
 =?us-ascii?Q?txiv0r86/4dZJ99TV+uN5FqzTn37+GnjZ2jzfyEE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ae9316-d291-46f9-43bd-08dde4c49a6f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:41.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6tqYa1NSpT5OihT04QRI0YkCvnYKjbHD+yiUFUK0xyw8JMNkc0Ipl7tVpQW2j8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

unmap_pages removes mappings and any fully contained interior tables from
the given range. This follows the now-standard iommu_domain API definition
where it does not split up larger page sizes into smaller. The caller must
perform unmap only on ranges created by map or it must have somehow
otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
scan for them)

A future work will provide 'cut' which explicitly does the page size split
if the HW can support it.

unmap is implemented with a recursive descent of the tree. If the caller
provides a VA range that spans an entire table item then the table memory
can be freed as well.

If an entire table item can be freed then this version will also check the
leaf-only level of the tree to ensure that all entries are present to
generate -EINVAL. Many of the existing drivers don't do this extra check.

This version sits under the iommu_domain_ops as unmap_pages() but does not
require the external page size calculation. The implementation is actually
unmap_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize __iommu_unmap() to take advantage of this.

Freed page table memory is batched up in the gather and will be freed in
the driver's iotlb_sync() callback after the IOTLB flush completes.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 155 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 9413f868a65bfa..53901a4a977935 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,29 @@
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
 #include <linux/export.h>
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+
+static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
+			       struct pt_iommu *iommu_table, pt_vaddr_t iova,
+			       pt_vaddr_t len,
+			       struct iommu_pages_list *free_list)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+
+	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
+	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
+		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
+		/*
+		 * Note that the sync frees the gather's free list, so we must
+		 * not have any pages on that list that are covered by iova/len
+		 */
+	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
+		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
+	}
+
+	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
+}
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
@@ -167,6 +190,138 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+struct pt_unmap_args {
+	struct iommu_pages_list free_list;
+	pt_vaddr_t unmapped;
+};
+
+static __maybe_unused int __unmap_range(struct pt_range *range, void *arg,
+					unsigned int level,
+					struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_unmap_args *unmap = arg;
+	unsigned int num_oas = 0;
+	unsigned int start_index;
+	int ret = 0;
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	pts.type = pt_load_entry_raw(&pts);
+	/*
+	 * A starting index is in the middle of a contiguous entry
+	 *
+	 * The IOMMU API does not require drivers to support unmapping parts of
+	 * large pages. Long ago VFIO would try to split maps but the current
+	 * version never does.
+	 *
+	 * Instead when unmap reaches a partial unmap of the start of a large
+	 * IOPTE it should remove the entire IOPTE and return that size to the
+	 * caller.
+	 */
+	if (pts.type == PT_ENTRY_OA) {
+		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
+			return -EINVAL;
+		goto start_oa;
+	}
+
+	do {
+		if (pts.type != PT_ENTRY_OA) {
+			bool fully_covered;
+
+			if (pts.type != PT_ENTRY_TABLE) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			pts.table_lower = pt_table_ptr(&pts);
+
+			fully_covered = pt_item_fully_covered(
+				&pts, pt_table_item_lg2sz(&pts));
+
+			ret = pt_descend(&pts, arg, __unmap_range);
+			if (ret)
+				break;
+
+			/*
+			 * If the unmapping range fully covers the table then we
+			 * can free it as well. The clear is delayed until we
+			 * succeed in clearing the lower table levels.
+			 */
+			if (fully_covered) {
+				iommu_pages_list_add(&unmap->free_list,
+						     pts.table_lower);
+				pt_clear_entry(&pts, ilog2(1));
+			}
+			pts.index++;
+		} else {
+			unsigned int num_contig_lg2;
+start_oa:
+			/*
+			 * If the caller requested an last that falls within a
+			 * single entry then the entire entry is unmapped and
+			 * the length returned will be larger than requested.
+			 */
+			num_contig_lg2 = pt_entry_num_contig_lg2(&pts);
+			pt_clear_entry(&pts, num_contig_lg2);
+			num_oas += log2_to_int(num_contig_lg2);
+			pts.index += log2_to_int(num_contig_lg2);
+		}
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+
+	unmap->unmapped += log2_mul(num_oas, pt_table_item_lg2sz(&pts));
+	return ret;
+}
+
+/**
+ * unmap_pages() - Make a range of IOVA empty/not present
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @gather: Gather struct that must be flushed on return
+ *
+ * unmap_pages() will remove a translation created by map_pages(). It cannot
+ * subdivide a mapping created by map_pages(), so it should be called with IOVA
+ * ranges that match those passed to map_pages(). The IOVA range can aggregate
+ * contiguous map_pages() calls so long as no individual range is split.
+ *
+ * Context: The caller must hold a write range lock that includes
+ * the whole range.
+ *
+ * Returns: Number of bytes of VA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */
+size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_unmap_args unmap = { .free_list = IOMMU_PAGES_LIST_INIT(
+					       unmap.free_list) };
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
+	if (ret)
+		return 0;
+
+	pt_walk_range(&range, __unmap_range, &unmap);
+
+	gather_range_pages(iotlb_gather, iommu_table, iova, len,
+			   &unmap.free_list);
+
+	return unmap.unmapped;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 1fe5106997f833..382596b70e394e 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/mm_types.h>
 
+struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 
 /**
@@ -119,6 +120,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	size_t pt_iommu_##fmt##_unmap_pages(                                   \
+		struct iommu_domain *domain, unsigned long iova,               \
+		size_t pgsize, size_t pgcount,                                 \
+		struct iommu_iotlb_gather *iotlb_gather);                      \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -135,8 +140,9 @@ struct pt_iommu_cfg {
  * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
  * iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt) \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


