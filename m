Return-Path: <linux-kselftest+bounces-37514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFE5B094AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 21:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6615862D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0F2FCE3D;
	Thu, 17 Jul 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsaZw6QD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE012EBDD0;
	Thu, 17 Jul 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779719; cv=fail; b=sUxVA/MKVqctQHGnYBSjJuFMdmkRqYnUYyJzuTGMtTZYgvbhhNuEdSqW6vD74jYfklcMl255UdCS/Fzvs5L50pcH/Vyt+xK3OtZrpMBEqJEMXT+mllKYpzV+LP5Ps1PY8Z4TpxaRV1tZWEL+0WBLSVSkRG+4c0zbZS2cg4R9O4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779719; c=relaxed/simple;
	bh=8F0+AfEQm4M/cjklO/xN4u2WCt3mIOEqFA3mH4VNzEg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mymkbb8Y6UF+fFMKJt1z+CDR4r7zDQtAuIKfsxfAv6XIXFdyesbf73cxfDiE217V62NltJyVcDsx+j6QYtcfegYBe/4ItxB8rSXVUo2x06tDtk/0HHL8Jpgqyj3lgUt2+odGlttNY0FLEiDhR5TlllgVwrWGEm6pzcllhzq976o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tsaZw6QD; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJbx/fxhkXFSr0uqIBK2tw303lJtzjnzLt2VxFs6UqGP2r/qPFUj5uXXzZq9I84FSwIQ8Qids86h7QL6w/Qn/vvVaFeOuDICr3bJEbTySWwpqMFYo6Y970O8YWKVwvx9XzS8hSQduuh/8L+D4C1Won0C5slc2++ZYiUFHR1feewXv7xO795HtiXMeMRt6Ud4RNSiD0Ws0PAWaNxqgrwD37Bmo3sE4Nt5wec8pGqqEpX4z/Te11KUCkky5OgFNU2f5lSmhigiJnmf9/YXMWwELV5SuB0YcoQlaCJ2Or+2jl6YD5onjeqCMyyKolCmjYMukWk841fO67eV5ejc/56fZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rD4ZldDsdBzIr+LzWy/iL+UkbbuNd43KygfW/wlsfc=;
 b=njWQQdMwZQVG7Wm7+sp0kFclBJiCSUie/4c7X7U9ZkvikBTaMiPeumcwx3SBXnWwUeInYdc14JBd09Iao0JQnCg0163QJP3pmDsfJPCmmsJStN7XynP2GTz041SO58nPUDr0Nef1ubxMg9AJLx87d+0H0Atow6BfI71Nz84RzvZ9Qr2w6wKdAwWMJuNz5M5sosUdUs4JKFWZ5qwqMXp6JVlcU64DdBKQcXVFoJQvIAJDaN5pdKI10OM/lYkLy7RhHV+RsiVIQW4wyGHhXJGNRiysdThaYB6o0TPG7US1nl4dA1fg6+cz6k2xdLmWNrBs1M7Rn8kMaO/ypYCLlItLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rD4ZldDsdBzIr+LzWy/iL+UkbbuNd43KygfW/wlsfc=;
 b=tsaZw6QDjS9/x4hSBAaC2KZRp7W1pq1VY4P+Zq7bLAKwEfSj2e9RY7pviIdXO3UBd3QUy2IWGNjKxJUU3gwUx5QqTKwnXMCKWPfVCYT9KcJtu4DPYmw6b213PaqwQ1VmcQxy73EPKj5fVwVzkqUG2tP2+TPadW89yYqfNn0+yxTsmrhJvorTTmUnoFVUoQDboJeJZKVBf37AU+GqMqZzcHdVsXFcjxTdHCEXQaqChH1o7ksQUdCI+qOdv0fWacJIAw80wVxnyGWIkQnfUBf45hpE3G9bLE3sntya/55DEHUadJTm9fURX0PjOSZBD35Fy3gp6nuoikLJ2f39RE1YCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:15:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 19:15:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 0/2] Fix undetected overflow when allocating IOVA
Date: Thu, 17 Jul 2025 16:15:07 -0300
Message-ID: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 51958027-b626-44bd-705f-08ddc5664019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9n5v5v9UiseM56kJK1lKRsAVdQrk0wTGOzjqABleDj4Ouh0jMOX6Jk8I2PaZ?=
 =?us-ascii?Q?dxeGmIx/+eOoKnNsAWzvtEBqSKQ0MpdoBrxRPzDcRXC3FCo7/0K7yUEYHkFh?=
 =?us-ascii?Q?OA5/YLoC6HXuaGoZRIAGpWXij8iWOJxrFQrxrR6qW/bAwfRPhnWNI6GiHQnu?=
 =?us-ascii?Q?H9h2g2E4g9xwP/9rT0JhKzWuyRhKUw8zJh45BpO4g9uqY7glioWNIJitF+h+?=
 =?us-ascii?Q?4D1/Inh3vKVBd1lOJf1aYOnyh5LuXPv1nIAidsefUsqnfoQPmJjXeHIFJVa9?=
 =?us-ascii?Q?O/RYh5okFKS1FsUkxni/b0XHE6aU+TmDJH+Up7kRQCNtF3ScDaF8TsXf49rK?=
 =?us-ascii?Q?gqzCn3s5FU3oUbUZWbjvuZBDRvb03Wytv8W0Rz2AmnjvHn9GbgqPzBbjZIwo?=
 =?us-ascii?Q?5iJ6CwLU73rbw5DvyT4LKKv4THKsi8lkZCugt6JEUu47SVhYH0bXPw7xslDC?=
 =?us-ascii?Q?4AHmyz+f8kDCN98Z9b2ojpwCi9QF4mYiPhxipXn0dUq+6nEZFvzuq1hUOBqz?=
 =?us-ascii?Q?FYYLc4bRSjL7SbBUE+uXw/6Vik+3hX0uMsBPfpbSktbCaFIVIgGqAXFTPfIX?=
 =?us-ascii?Q?EAa8HKq442NVFEI9fpaeC52I+Z7F4Rn7RbjZ/kZg34fEAsyD2rzV9dbcUpsA?=
 =?us-ascii?Q?os+/peQs6JuXse2aU8Vi/sYs9Oxh0lSpNcwlDx/3X8d3E+ZTi7pcVJKLzwDb?=
 =?us-ascii?Q?c/Iy2ugnFzuuYgQkfB/B2EN14GXQRuMN5MJMcwgd5tMaPuG1N6LIljx0uDLv?=
 =?us-ascii?Q?tLTxMxG8L4zDx760DnKGmur3Tn1E8Lbe9d/yb7YR1eydzuEcNiHm5ZtUc2iJ?=
 =?us-ascii?Q?YKkkv9fiWQT2oobT9HycIvavJ+StdrRriKvRbfIKKkc5GQ4HYU29mb8cBUAA?=
 =?us-ascii?Q?CI4Ne+bOxWbk0OxsnEMmlLPM9peB+H0A/4E8kNlv0LkZLpiGo/volESVOmms?=
 =?us-ascii?Q?znyTVUImdV/Mz4Z5Fhwuk7iqw/0KdujygxJuLv/1q95LSP81l+jBCrSn7QZf?=
 =?us-ascii?Q?mn3n5Qb/iJguZ90yZcRPAZJTLVs4ICZsi17Ed68MOLwMfHkjjgszbryiRMfl?=
 =?us-ascii?Q?3PgiHH/JhkR7sGh9eoFMjqT6yTNqt8yDjJdmyFRtJSLRsXfhh5++RWPQb5q/?=
 =?us-ascii?Q?0FFOxazADEruy+SlL2PZSpH8KINsG5OIk/6TVVcaGnvsY6ENHi1CtorVm07a?=
 =?us-ascii?Q?CxNHmGRh9ZILMO+kiT2Tvl0P2/9dbr2C0C97NoRGdmmdmv1aUX97ukBD66e2?=
 =?us-ascii?Q?WILGYCUocNtnKyzS3Rf9C9xnKpkOS0zHzi5YSuQm3ua60+toiPjCoJDFn7ov?=
 =?us-ascii?Q?DRJ5+PvaS4gxHcgKQUo1i8W4OOhjXGRnseRxUfBdXPYh8mX3Q/PeUbFUo0T7?=
 =?us-ascii?Q?67EiTuZFWUSZdbez2mj4tkLd8caxx8+fPbA6Y+zEnvBwoOKIbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrFkboKWjisjSedoe+e5bTpyvgcJi9qOWnXTS+EPt5DYGNlF/vSxRhyOyj8H?=
 =?us-ascii?Q?KL6n4bk+aa1audCP0JybOw1WIlWZBnx4BHHWi3STcsgRhgG4xwCAk3Pwp5N6?=
 =?us-ascii?Q?DB5vRq4talohWxbVQCB9jZyhDpTp9x1ebnoHkobBykGlIKChNLx4K+G3MqEI?=
 =?us-ascii?Q?adYwrwA0tqjg7+DiveF4Rbc7GZt3lB0ljKbUEBweIgKTQM99nE47Fl5folAB?=
 =?us-ascii?Q?lnMyhTMxBxx9PYkgpqx1dRm063W2GSmCvJpzLpn2pWxZ9qC9JuHubqGDryMI?=
 =?us-ascii?Q?4EYvPgjLr26i96rdJfwV0dxNgX2NaOo7g84pYn45+Do762yKx0DjyREj1c2H?=
 =?us-ascii?Q?e7aUBB9vWpDJEdP+yeY778YLQVIq3PIvaUSODatAmTVSrqnPZyC3hwLszH9W?=
 =?us-ascii?Q?G1TW5VGsMgk0H9oikDwXTOZWUgPUwjuTvERvm36EJokLyiwTEvol8PDizNog?=
 =?us-ascii?Q?GcxZPkrddSc2tuyjBus0k6Jz8+5jG8R00L2fDr1qybbh6vx9Fn3HwZsaTGJq?=
 =?us-ascii?Q?24cuWO9hzukyvggvALceUL8YlChO6dMJKXPQ2vbxY3sDpO99l9aK5+2Ibpgr?=
 =?us-ascii?Q?saizQ8spgWhLU/Uc4MOkWIeR7L3hjltWl4uW96VtjNoJ30rYVUrh3t7kDVQm?=
 =?us-ascii?Q?BKSrFPInE6PCJxOAop6KCFj+1N/0ANj8DG4AnuUJ+CYFbbK/cThT2Go/YWHC?=
 =?us-ascii?Q?S5GMwy6AwjeHxH0mMQDyIy3S1kzD3QZfQfmXaYxfcV/FKXF/+2uL6dBoZ+jR?=
 =?us-ascii?Q?ykzE4MT1KmhwazMIIBlrTTucTOlKSW3UEm3UPz0uGgvwhuqmZ0yA8l9A80pF?=
 =?us-ascii?Q?64yyS//K7PzcHtvrVM6cFqs1/I2COhtvQ7rJ3Plqkzsw6CO9+347mjgvmtqp?=
 =?us-ascii?Q?8LmQTvak+xwUTmEL99MtCRJYMNa+275E5lDM618HNs/lEvUGytjYBu+5zm2c?=
 =?us-ascii?Q?mpNDjXpmc//sMv68cIbUW7L56GqsowJc5juLanE9rHOV2bM42GknJjUm9uI3?=
 =?us-ascii?Q?CO0rQSEB/Gnk8uqRKQVIqxfhOG0WyYrlfX3aKfToeyJhky3YC34ot5+TeS14?=
 =?us-ascii?Q?g/Vqz/jInLnhCKuYwhVqXdZUayq36hmHOVY2LrosDysFFKGx0AZsSwImmCyC?=
 =?us-ascii?Q?ELZVQGf7HHBHzHEys9MgjMVKLfZYV5DmOUwNl1MBD0a9HNNCd97AsHJkd55M?=
 =?us-ascii?Q?k+ILeU/FbgrzvMb1OTOzpTMqOWiC7mw3jsxwk+qbC9BLBRJPvsGCKkFfJTYT?=
 =?us-ascii?Q?DptMMRYqYNWw4nwMglhcD/j887udPmwov8AEFBAC1hG4ij2BmxV9LmK7BSwU?=
 =?us-ascii?Q?UCkcc6vO39F4A+htOjAFdBpKIGHos88yjWGRCnwiz/KjT+xohVw+QWsRH48T?=
 =?us-ascii?Q?SCui7oU7szk+jDAYgCQMEx+doClvK6RMlhdvuQ5OXetZ+33FijDbpAiakbE9?=
 =?us-ascii?Q?tvyMw1EPaoPqKHodbWIgi0Y99TXBknTvT61iEiPhEzVzfEBIakHBffX6dnEZ?=
 =?us-ascii?Q?3j0j99xmPgHX8UBlPxKkaKdaKzg/1y011AG3IaDGF45F+Ue1lLfscL+GKvqp?=
 =?us-ascii?Q?cYcpENwPOu4zEkULaWwFKm48syswfBOQf5JNVYur?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51958027-b626-44bd-705f-08ddc5664019
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:15:11.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYKkwrjzzy2nnJBrm5H48aruModMeXh3lEjxndPgj2I6j8Qs34CvZxNHN+EfeH7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

Syzkaller found this, the ALIGN() call can overflow and corrupt the
allocation process. Fix the bug and add some test coverage.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (2):
  iommufd: Prevent ALIGN() overflow
  iommufd/selftest: Test reserved regions near ULONG_MAX

 drivers/iommu/iommufd/io_pagetable.c    | 41 +++++++++++++++----------
 tools/testing/selftests/iommu/iommufd.c | 18 +++++++++++
 2 files changed, 43 insertions(+), 16 deletions(-)


base-commit: 601b1d0d9395c711383452bd0d47037afbbb4bcf
-- 
2.43.0


