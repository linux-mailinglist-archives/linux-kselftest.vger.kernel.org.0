Return-Path: <linux-kselftest+bounces-39985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE9B3712E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FD98E4573
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357B2E888A;
	Tue, 26 Aug 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPW6x21S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00B2FE04F;
	Tue, 26 Aug 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228739; cv=fail; b=W+ReTDHCqfu2Uz7R9/5GZlUHh+KBsYIO+CG5kZRDLqsquzG5RgTktXFO2uWUHPWdrEI7/ScOABOBHyQ+a+Yyo6JDAbg2qKPfL3z700oCaRm2Tx7itMHbMT2gYRAskrMURMM1JHcSz9qFEmfs9tIfaG+UbMGSyF32QG8PyMU40OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228739; c=relaxed/simple;
	bh=Wz8xoneIwUB88+KbXdpWOTTu03lEVs1IXgaG9oa6j88=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hlOOrcdf2UtIVQaOaxCJDa73jCu1lWUm7Y5jYx2+66zdiMYZdaVEF8Wg1G3N7F2Pj+0NfhLHcyQK6JPqCwM0i9cg3+GyRXAtyrHGOFJ7TOe+A0z8Ojp9my+j6bg8VInXusToHrXWe+F/hlP4hnu3BElUJtubbS8ay2CXp25NS44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPW6x21S; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sV0II+lXQuIvcdzmROYGfqRM6aAxEVejPvP7ONktXQmJwYCuwvSCtJIoy0N28Lmnu4ci34e6i2FKQ949yW9wtXzys+7p80SBMlAWIogOEWOe3Gj+X0WXea1DD6fX4Xth/3yo/anXiVGg/NZPBfRhz3imMM3xgJ3G0aRIb9VHU9VHxraJ4+exJaWqDeIFwUvz6av//f8fr1Ml4Nb108QEaKzwyjs4upvkPBjbAw5tU9QuYKGdX14dCIEJSQnlGblUzfMstjN8Zvk0xFVdNdIB6Fa/SPTSsda1wctxPhpRwm1K4LiF09MVwl05K/+Mna6K4oMqPsOgOjjMxYfbUkE+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM0S7lIIZQOViLkSIjHJ5af+GuHk7BIP31Fna+aS43A=;
 b=MKXiuDDqXl+6at4UA0aWDAEgJUbuCgsOjmpbj93m0FZPGN4TLGacQS/r9Qm7sCGscTlQEWZwCQ1SL7sj6VhCH1vNGUjjfyse5/UhvOm5HMx46/GGXsdcBV/VEKZ6f9dEETgnFhqXBjmjkl6610Ptp1Ze7yN82FgB6z8SDE4iWKgGw51/zY5HGCr7aG5uBlJ9tiVZYz3LtItUVgKe2b2wqlg9Oqtjrc7LBToCPtfP/QrQZrRW7LNoR0l1eJXXVatWRTHA+qOvagJOiKxUL7sawoxOmapHs6Wv9UgZnM5e49D7rDU+L523v245GuI//+/6Qzjp1TKQucDZeooylk1Vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM0S7lIIZQOViLkSIjHJ5af+GuHk7BIP31Fna+aS43A=;
 b=aPW6x21So0NAYsJwbq1HOSG5wviRSIUwgFSpE7FgNEUE3XJ8xpIsk90n0cq6FlMP3+vtfRWdw9su/ufRsYDCPMASI942OjZjlG1x4P5zqx0a5FrhmJibeswWNwR6nKZu+rhTmgfyTZv7RZ28PtW/RERxXRwkvVORSxqX2eV+ydBIhdMhUj6mAe1ForLCYCKqKsh28VSvTNY2+ThztBKINUaAdJoo6VffZzev2k2rgKcNkbr5R3X6jTnkjYpKFO7vK5RokZDggjVBVvz6t44pXUyrdxMrP5fx9RN7i6uj69c2wmDzXFRcF6UCZwaqi5SOZr7NJGtXRnbGcjL2Rqzzrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:44 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:44 +0000
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
Subject: [PATCH v4 00/15] Consolidate iommu page table implementations (AMD)
Date: Tue, 26 Aug 2025 14:18:21 -0300
Message-ID: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0171.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::26) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a185b6c-8ca8-4e5e-c5dc-08dde4c49a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X01ujbRgAKW00qCsGVUaJaAqqqMq8ffHrWuHnG7hN5HQoapGKSCkxUtgZkpr?=
 =?us-ascii?Q?robMXcbbfOs5WrhubLByERD1nPobSw9m0BZoGDgtMUudBaMOBhJiNYHohZhz?=
 =?us-ascii?Q?ofWFSqCVVZpww51iT9M0/HWnpkAV5W7x81Toy3acqEgKYyQg5cCzvqxcoy4I?=
 =?us-ascii?Q?pof9p6RIxP93IKZorD/K9Z+CrDCSlADeCjP6F4B6oIko7wvDZnpjZphJr0wc?=
 =?us-ascii?Q?YJ7ZDClTUav+t3xg4WtCf04znsbghR6pXtUw/xvqyx9ReeYISYphROxfvQ3F?=
 =?us-ascii?Q?VsgOX8lTe9e/mrbtyatYF8rntjb1/QdhAk75O5efJZz1QboAugNKZ90cMIB8?=
 =?us-ascii?Q?0UFgAj0cveasI7kZOIc9SlFZVXdTY0z2zNXdt8JOSPJF2l5HoWfuRv56LKTs?=
 =?us-ascii?Q?3j0G2eEAw6wr2VR3JDK2ryJP90L9MM3G8O/UpnzREYkTxwl6pocHj6+O3Xr9?=
 =?us-ascii?Q?W9feQ8aSADWEZBsRJFRKdBfbwY2QVPBoG22UbaRhV2KeBU8ANodypVTuMeTC?=
 =?us-ascii?Q?2kz0uIZS3Qwo6RVAtO/c3JDX3j78aHuV7911HBXgdAg2c92Sk8NFwMZDs1TR?=
 =?us-ascii?Q?CZenr4Hf3SaZn/4pzTxHT6EHXMOFohqXNcXuP5ygVKP5Xvr4Ktbl1ymrlEHQ?=
 =?us-ascii?Q?A4hSW6h4eKFAwtXhU0TKZwczaN16NFCPm2wGZ6Uk2PWpn5Z7ZPVg7GyAb+26?=
 =?us-ascii?Q?imYmhnrpFST4C+ITBwOPXKObDxdCE8M/TK2WZmwysMYbYkGAs6etk5cJfP+x?=
 =?us-ascii?Q?aMN8E9/Feku5zX7qZvQOXLEIgKJtEwaVRzm6UpNtu3HHfz5MNwtgKUAxxYFD?=
 =?us-ascii?Q?J/tHGpyi5hHc2FwEF6GiSnf7W9uwyre23GCzF9LtUhTi0/tG4t4n+SFIE5Tb?=
 =?us-ascii?Q?pOtHGx5TI51uGjAUuwuhZD5Y90xThsUd+mUqjsJ0C7HC0MHIbEskNOJcKq3m?=
 =?us-ascii?Q?0mEO+720nP3AImUxrrmigYgq+QNqKkT8w9QFxx0kbJBJIQ+9R+mw4ZDORPco?=
 =?us-ascii?Q?/g99hn12eyA1GM2n87ZMQo7K4G9mpbTh7tTDiUO38c83E1L4sy09XGp0Cydr?=
 =?us-ascii?Q?NJZTZKjcNWmNlxxUA0vo2O2huCzHb90CPsbE+QEd5Vx/Gxuj3A1lP6vQ7+yB?=
 =?us-ascii?Q?ETZGuAFEYTr5FngNY3FtPWCQN+p30ERkEYnfukJcDIlLQO/XDQ+cKj2DIvCd?=
 =?us-ascii?Q?XHnbVJzIFdVw5kLim/Y1aPIlhAee63BbJ/zbjFDHQv1gSUaCdr8IdJ8XNL5P?=
 =?us-ascii?Q?goBleBSO4fgC9Ldhj8yTyyqiae0urDUQxdMUuyyM7aoi07CF0ARuov/4QsEV?=
 =?us-ascii?Q?lABegR25GKlF5ev1cP+25CWp1Ks6fXMED+Be4tBQH84e8K6Mh6zAXg3OgF10?=
 =?us-ascii?Q?KP92k9OqQtAmW6I+h/Q1q1PJXqfDzpG7tbjczk3Xda0PTpPoX8BS0heSa+e6?=
 =?us-ascii?Q?DTyDIvG3es7pDO7MCm5+njbvvlK8twgrxnkpQn3GxXGJY5X8StsveYHVIDrA?=
 =?us-ascii?Q?JzC1RPFLxEQZ/z8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGZknea1G/ub+gg/kSLqtFHEeLIKLpynGnWlLcUW2scEXRF51nZXsmoDR6Wo?=
 =?us-ascii?Q?5Xeirs5wXkn+AX3i4PWWwF4R6YbVt+kbh8f8N39CBUx9sASSNWl18W5qC/Fy?=
 =?us-ascii?Q?ii3v4SeuGSehl3zQItQ1yWWcTSqyzsKKCNFAFoWrzrYhbPzXwqCTIpNQKdIc?=
 =?us-ascii?Q?c9kIDrnLaywdHhY82tN7iVePO2LN620tTfwBwf9gymNFylFhrOyL+gwFHeCU?=
 =?us-ascii?Q?xhpG57cyhuU6/+jXmvSgqKn1wGgq84BrBN844NbgprP/y0w4kZPZbJLjjzdG?=
 =?us-ascii?Q?uB3g/u5TdkJMtc+om/FE1jURBce4/g2tcyWQiUJtxh0U/VUIzGxKPI/aYEth?=
 =?us-ascii?Q?SzbxyRs+t/eJP61v9XG6zMfP9IBUg5ZBBlGUFZ6YzvzXvEN25qlLcv5sdABr?=
 =?us-ascii?Q?zrViD4cdgpgMb1/CVFF0sFHwtFvwpl+0YNl6Il7zioYP34po7TrWBOYz2SZ/?=
 =?us-ascii?Q?kRsuYOxitI6CgwBB1CrVbYDEBx4kaHTxZ2cvZok/4r4CpYvki8d1FpiA7YYa?=
 =?us-ascii?Q?6G/MtqR/C6IX6teGQKw/cfh2OEm76Ypl7poEH9R/8OoKort6OafOSPVeJchc?=
 =?us-ascii?Q?ZTBkaERcuQfrqYVAR10hSB2vBzctWNQciJGAMv+K4Ont4z8pZBjAinnp/UAO?=
 =?us-ascii?Q?26WuQLhr4NBPLa1Zqajhp2dRXtwc/gA2q55BO+Sn+6khnijJAjxbeRqV0uVb?=
 =?us-ascii?Q?z4Z9Rum6QK7YYVGQowjvIyGPqtBi22q0fanfXfW6dqDVDLMF+PJL1wp1Ggp6?=
 =?us-ascii?Q?BTyXLMuRdrYAXfJK2MJhmMPtbWfHJw2y7UPPGkvhKbGPCNWz04OWhdqwH+CV?=
 =?us-ascii?Q?oQf0pAPpsWjmpHYAOZ+jTNszW44MDgdO7bSqf0DrhQ9Wz8dn4OI/t0gTY1d5?=
 =?us-ascii?Q?Jxeklts/q//CDr0+zV80f+J/2thpbN8NZe9Q3IxbI1IXOZ/alrhO9nsPcy7s?=
 =?us-ascii?Q?IAdhCU4E53iK3wrj9/3iE8FExucCkcD2X3GD453AGdG2NBa6sKf4l2PuPiCw?=
 =?us-ascii?Q?oK0OW0helinv6+K3hMhFmAHoR/ifx+8fWA/BduTNQbdF+c9W2WmUZC3rJrpX?=
 =?us-ascii?Q?QLZa4CLe9WSSP1xD5AFHMx2gis9RgwUEKxw0xTKTP5WkSKYJRpzTaQEtYJO2?=
 =?us-ascii?Q?xOaCiUFtgrfDWSNw2mS4uC624pSnzf6DgPGHrQtseMmZ5sdQORsWBp4hRFMu?=
 =?us-ascii?Q?faNVzxCTkF8JuKSKxYqFIqtEWDkPnpFZSE4uEHsWtZHOkiJlXhucVNZdQNsR?=
 =?us-ascii?Q?e4VHE6oSB5UH/jIJ4REvGil3gxAZ5api/NpOSUPHwZb4N9R9pB5TAhlCOFTP?=
 =?us-ascii?Q?Fdb7QjlxmKzU7nqpBX4p2EKJ3JpOa+9h6ZoBcafX8cGnYKVwzjxh7LG5cDOM?=
 =?us-ascii?Q?SXf4xTIACpqek0A6AKtLRbwKq5MfO8BFgHeOy/Xbr0Q2QAVEoeSrJmtl3taW?=
 =?us-ascii?Q?t356dlmltnlw9NFgGvE/vJTTLla47XB2DQShW2SOkiSMxr1THZAbiBwSJl88?=
 =?us-ascii?Q?emogqPHNkBEQ6ZodQ3e6xdQDsOMs/Pc+oTA3DOl8/Emh+xOP9PbG3a93OwrA?=
 =?us-ascii?Q?ZCEHy6GH6K4J++1lEYhZK5etvzzmcg/RHf1dFfvI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a185b6c-8ca8-4e5e-c5dc-08dde4c49a80
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:41.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pm7MEM/Nyh0i1tmqAQQX8Tndw+ZWoJwBqm7SLqpmxx2Xk9Wp89HgaVRYHEkNcBE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

[All the precursor patches are merged now and AMD/RISCV/VTD conversions
are written]

Currently each of the iommu page table formats duplicates all of the logic
to maintain the page table and perform map/unmap/etc operations. There are
several different versions of the algorithms between all the different
formats. The io-pgtable system provides an interface to help isolate the
page table code from the iommu driver, but doesn't provide tools to
implement the common algorithms.

This makes it very hard to improve the state of the pagetable code under
the iommu domains as any proposed improvement needs to alter a large
number of different driver code paths. Combined with a lack of software
based testing this makes improvement in this area very hard.

iommufd wants several new page table operations:
 - More efficient map/unmap operations, using iommufd's batching logic
 - unmap that returns the physical addresses into a batch as it progresses
 - cut that allows splitting areas so large pages can have holes
   poked in them dynamically (ie guestmemfd hitless shared/private
   transitions)
 - More agressive freeing of table memory to avoid waste
 - Fragmenting large pages so that dirty tracking can be more granular
 - Reassembling large pages so that VMs can run at full IO performance
   in migration/dirty tracking error flows
 - KHO integration for kernel live upgrade

Together these are algorithmically complex enough to be a very significant
task to go and implement in all the page table formats we support. Just
the "server" focused drivers use almost all the formats (ARMv8 S1&S2 / x86
PAE / AMDv1 / VT-D SS / RISCV)

Instead of doing the duplicated work, this series takes the first step to
consolidate the algorithms into one places. In spirit it is similar to the
work Christoph did a few years back to pull the redundant get_user_pages()
implementations out of the arch code into core MM. This unlocked a great
deal of improvement in that space in the following years. I would like to
see the same benefit in iommu as well.

My first RFC showed a bigger picture with all most all formats and more
algorithms. This series reorganizes that to be narrowly focused on just
enough to convert the AMD driver to use the new mechanism.

kunit tests are provided that allow good testing of the algorithms and all
formats on x86, nothing is arch specific.

AMD is one of the simpler options as the HW is quite uniform with few
different options/bugs while still requiring the complicated contiguous
pages support. The HW also has a very simple range based invalidation
approach that is easy to implement.

The AMD v1 and AMD v2 page table formats are implemented bit for bit
identical to the current code, tested using a compare kunit test that
checks against the io-pgtable version (on github, see below).

Updating the AMD driver to replace the io-pgtable layer with the new stuff
is fairly straightforward now. The layering is fixed up in the new version
so that all the invalidation goes through function pointers.

Several small fixing patches have come out of this as I've been fixing the
problems that the test suite uncovers in the current code, and
implementing the fixed version in iommupt.

On performance, there is a quite wide variety of implementation designs
across all the drivers. Looking at some key performance across
the main formats:

iommu_map():
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     53,66    ,      51,63      ,  19.19 (AMDV1)
 256*2^12,    386,1909  ,     367,1795    ,  79.79
 256*2^21,    362,1633  ,     355,1556    ,  77.77

     2^12,     56,62    ,      52,59      ,  11.11 (AMDv2)
 256*2^12,    405,1355  ,     357,1292    ,  72.72
 256*2^21,    393,1160  ,     358,1114    ,  67.67

     2^12,     55,65    ,      53,62      ,  14.14 (VTD second stage)
 256*2^12,    391,518   ,     332,512     ,  35.35
 256*2^21,    383,635   ,     336,624     ,  46.46

     2^12,     57,65    ,      55,63      ,  12.12 (ARM 64 bit)
 256*2^12,    380,389   ,     361,369     ,   2.02
 256*2^21,    358,419   ,     345,400     ,  13.13

iommu_unmap():
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     69,88    ,      65,85      ,  23.23 (AMDv1)
 256*2^12,    353,6498  ,     331,6029    ,  94.94
 256*2^21,    373,6014  ,     360,5706    ,  93.93

     2^12,     71,72    ,      66,69      ,   4.04 (AMDv2)
 256*2^12,    228,891   ,     206,871     ,  76.76
 256*2^21,    254,721   ,     245,711     ,  65.65

     2^12,     69,87    ,      65,82      ,  20.20 (VTD second stage)
 256*2^12,    210,321   ,     200,315     ,  36.36
 256*2^21,    255,349   ,     238,342     ,  30.30

     2^12,     72,77    ,      68,74      ,   8.08 (ARM 64 bit)
 256*2^12,    521,357   ,     447,346     , -29.29
 256*2^21,    489,358   ,     433,345     , -25.25

  * Above numbers include additional patches to remove the iommu_pgsize()
    overheads. gcc 13.3.0, i7-12700

This version provides fairly consistent performance across formats. ARM
unmap performance is quite different because this version supports
contiguous pages and uses a very different algorithm for unmapping. Though
why it is so worse compared to AMDv1 I haven't figured out yet.

The per-format commits include a more detailed chart.

There is a second branch:
   https://github.com/jgunthorpe/linux/commits/iommu_pt_all

Containing supporting work and future steps:
 - ARM short descriptor (32 bit), ARM long descriptor (64 bit) formats
 - RISCV format and RISCV conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_riscv
 - Support for a DMA incoherent HW page table walker
 - VT-D second stage format and VT-D conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd
 - DART v1 & v2 format
 - Draft of a iommufd 'cut' operation to break down huge pages
 - A compare test that checks the iommupt formats against the iopgtable
   interface, including updating AMD to have a working iopgtable and patches
   to make VT-D have an iopgtable for testing.
 - A performance test to micro-benchmark map and unmap against iogptable

My strategy is to go one by one for the drivers:
 - AMD driver conversion
 - RISCV page table and driver
 - Intel VT-D driver and VTDSS page table
 - Flushing improvements for RISCV
 - ARM SMMUv3

And concurrently work on the algorithm side:
 - debugfs content dump, like VT-D has
 - Cut support
 - Increase/Decrease page size support
 - map/unmap batching
 - KHO

As we make more algorithm improvements the value to convert the drivers
increases.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt

v3:
 - Rebase on v6.16-rc3
 - Integrate the HATS/HATDis changes
 - Remove 'default n' from kconfig
 - Remove unused 'PT_FIXED_TOP_LEVEL'
 - Improve comments and coumentation
 - Fix some compile warnings from kbuild robots
v2: https://patch.msgid.link/r/0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com
 - Rebase on v6.16-rc2
 - s/PT_ENTRY_WORD_SIZE/PT_ITEM_WORD_SIZE/s to follow the language better
 - Comment and documentation updates
 - Add PT_TOP_PHYS_MASK to help manage alignment restrictions on the top
   pointer
 - Add missed force_aperture = true
 - Make pt_iommu_deinit() take care of the not-yet-inited error case
   internally as AMD/RISCV/VTD all shared this logic
 - Change gather_range() into gather_range_pages() so it also deals with
   the page list. This makes the following cache flushing series simpler
 - Fix missed update of unmap->unmapped in some error cases
 - Change clear_contig() to order the gather more logically
 - Remove goto from the error handling in __map_range_leaf()
 - s/log2_/oalog2_/ in places where the argument is an oaddr_t
 - Pass the pts to pt_table_install64/32()
 - Do not use SIGN_EXTEND for the AMDv2 page table because of Vasant's
   information on how PASID 0 works.
v1: https://patch.msgid.link/r/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com
 - AMD driver only, many code changes
RFC: https://lore.kernel.org/all/0-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com/

Cc: Michael Roth <michael.roth@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: James Gowans <jgowans@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Alejandro Jimenez (1):
  iommu/amd: Use the generic iommu page table

Jason Gunthorpe (14):
  genpt: Generic Page Table base API
  genpt: Add Documentation/ files
  iommupt: Add the basic structure of the iommu implementation
  iommupt: Add the AMD IOMMU v1 page table format
  iommupt: Add iova_to_phys op
  iommupt: Add unmap_pages op
  iommupt: Add map_pages op
  iommupt: Add read_and_clear_dirty op
  iommupt: Add a kunit test for Generic Page Table
  iommupt: Add a mock pagetable format for iommufd selftest to use
  iommufd: Change the selftest to use iommupt instead of xarray
  iommupt: Add the x86 64 bit page table format
  iommu/amd: Remove AMD io_pgtable support
  iommupt: Add a kunit test for the IOMMU implementation

 .clang-format                                 |    1 +
 Documentation/driver-api/generic_pt.rst       |  140 ++
 Documentation/driver-api/index.rst            |    1 +
 drivers/iommu/Kconfig                         |    2 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/amd/Kconfig                     |    5 +-
 drivers/iommu/amd/Makefile                    |    2 +-
 drivers/iommu/amd/amd_iommu.h                 |    1 -
 drivers/iommu/amd/amd_iommu_types.h           |  109 +-
 drivers/iommu/amd/io_pgtable.c                |  560 --------
 drivers/iommu/amd/io_pgtable_v2.c             |  370 ------
 drivers/iommu/amd/iommu.c                     |  538 ++++----
 drivers/iommu/generic_pt/.kunitconfig         |   13 +
 drivers/iommu/generic_pt/Kconfig              |   67 +
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  409 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   11 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  248 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1146 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  717 +++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  451 +++++++
 drivers/iommu/generic_pt/pt_common.h          |  354 +++++
 drivers/iommu/generic_pt/pt_defs.h            |  323 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h    |  193 +++
 drivers/iommu/generic_pt/pt_iter.h            |  636 +++++++++
 drivers/iommu/generic_pt/pt_log2.h            |  130 ++
 drivers/iommu/io-pgtable.c                    |    4 -
 drivers/iommu/iommufd/Kconfig                 |    1 +
 drivers/iommu/iommufd/iommufd_test.h          |   11 +-
 drivers/iommu/iommufd/selftest.c              |  438 +++----
 include/linux/generic_pt/common.h             |  166 +++
 include/linux/generic_pt/iommu.h              |  270 ++++
 include/linux/io-pgtable.h                    |    2 -
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 41 files changed, 6124 insertions(+), 1592 deletions(-)
 create mode 100644 Documentation/driver-api/generic_pt.rst
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c
 create mode 100644 drivers/iommu/generic_pt/.kunitconfig
 create mode 100644 drivers/iommu/generic_pt/Kconfig
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_generic_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/pt_common.h
 create mode 100644 drivers/iommu/generic_pt/pt_defs.h
 create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
 create mode 100644 drivers/iommu/generic_pt/pt_iter.h
 create mode 100644 drivers/iommu/generic_pt/pt_log2.h
 create mode 100644 include/linux/generic_pt/common.h
 create mode 100644 include/linux/generic_pt/iommu.h


base-commit: 8da0d63bd5726ff656bfa1eacb45d6f5cce65616
-- 
2.43.0


