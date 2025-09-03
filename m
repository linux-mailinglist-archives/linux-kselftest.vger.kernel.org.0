Return-Path: <linux-kselftest+bounces-40693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60CB4282B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E2A567D94
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA37324B36;
	Wed,  3 Sep 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nD5mVUZt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13132A81A;
	Wed,  3 Sep 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921614; cv=fail; b=dwPtKZlNw1O6gFm03CeuRdI2nWdYjxQA45uKUeK87nK+rd4Te7mZNfsgoNmuBrbsaHNzHH/pbNFu9zF1KMUiQgQFFx5bNZ7Hq1dI7q0PFzEw1eu9CV8tZitKXAyOz235f1EGNcs5VylWfBZZPOu+L+Ovnw8bRMieT6D4iTthwGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921614; c=relaxed/simple;
	bh=JnhIiP/ccdP33q3+QL+d1rEJ4YstyiEEJsYkGQCj9vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/6IIejjxvMIH57L6PHpmyw43R/kgi/kgoqr/mb/7GAgDYb2vsL0hfYOTJgpSc0CQoY9nsEvVM2oVHyYJ5YMhNne4rEEfDwDth8BHH+CG9r/RUxg/juc2OtpvTCwwRzgqQFSTb0+j62KgR48d51u1CuACyNtWN53WtHutSRmZQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nD5mVUZt; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW6MCf1YoYptATT8dPdEGzmvquViL7WS2WATKUFw8eiLPpk+gOeB+/I3kJed+9mSjhrwlMe1xXgmVqtTOIfzSDW40rCEFZQSeMrRXZUWOzfOHGdwFhbJBTaSFyAlNjZ+365SQfXr1Ti39elTBfRSt3iFRqhCLoi7gLM300sdfIxxYEJq5hN/IbopXuATzgb9TzzULq1YqL87wJ1vf1Faegj1GYyk6NlsZqzpLm6BCLWXmA16re1Jp/9WdAQJeA2AgSX+Hp66BDbvX2YE0TvabQgI5dRqHUSZVUn2mo1YedjwYEl6d8mglmYeP0fdHMTN83aRpeaVH0eATpXJNM7KYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNVFW+nOJ1u/GLASLFA42f26cpFL4JYTR1WDdNhhYuI=;
 b=TsQgB5DqeBR9KP/rAUIu1fOlwmCvNpbTntuUT0v1fc/hX/YbVwerqz129qbzYEN9c4tGNDP4xpedMe5Uv+VlFveM/20eg3+Js96DUSIuE0d9PcRMXvXnkvFORvCPV1ofrcCrD8Py+aJaulqDZqNZI8WyIlgxVU0PntXNgG1Bv5pJrVScJmXKmh3b0odPuVdw0YiBGasxcHmTRu6sJtKCGbE8RxT9UdZlX6x+ptVnbkJdOGf6ChmCdCGEhjuYfKouJSxUU4YGI4tiEUM/tRyqsG5D+Ytnjm6ZhwyKsD1tjqnbTxcgr/TnCc+QCmZxYv5HuDJqmwzvmjESFx0/BsgjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNVFW+nOJ1u/GLASLFA42f26cpFL4JYTR1WDdNhhYuI=;
 b=nD5mVUZtXDWG8pvXEu32VvXntwxg8BQ+JDfybVtvtkWF2CaQixHGk4OCmpxFx4duJ4i4f89IrjCac8pa0cBZI4GYOc1vhlxRjnRZZ0oqaGV/7FprIYZseCUdbFyRSVADyYBi+Jkl8O3QjxlVOXHWECMbCtR+Z+T0/EfV+y+EdvagJKJwGPuFNsYrXjhfUqrqSxqLRA3KKmWwzdvLUljQLdZ9+RZprzLyLUFvoYCPCiMmG4LXILxMG9Wxbthxwc2oNOwVru0Wu1+ow1yMdmXTlMGf9bvbZ1S4rtNUbooB/rNc+hfCERKfnCra/CFepkHutPvivaqU0/F9r6ZWe1vRfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:46 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:46 +0000
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
Subject: [PATCH v5 02/15] genpt: Add Documentation/ files
Date: Wed,  3 Sep 2025 14:46:29 -0300
Message-ID: <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0383.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dd3103-a007-406b-92e9-08ddeb11d8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eiuRqTMpD0u8jf696/4itkDLB/dixEibfWGKQi7QGBH38A6r7sLd8CdOOm09?=
 =?us-ascii?Q?mShbsXBm/7p0IwEvJMeyCeUvl0f6WLuYZoUaPbjgGTkJ4ED8jmkF0/krr43U?=
 =?us-ascii?Q?VqUYbScBOnrRE+lI47JyTIcM2CaSo/iYa5RMlcAA9y90r8RBFZsdIQmwYJrt?=
 =?us-ascii?Q?L3rqQ5CSnke/4J4oeVN/FtLciMqM4txKopb+7H33w+HSZdbKxZNuVXrpQU3R?=
 =?us-ascii?Q?YHVI3umI1VQjGUY11QqQRti3oP8NLpV25CVrUyX1ETxPKX/xcSdJz2epgbBr?=
 =?us-ascii?Q?XJjKP1cRdfqo48wOHQnBF2XKaRgZdvhXTdLsgVWOvgs60WfB7Bug/P1G0jOV?=
 =?us-ascii?Q?M6P5+Wn9ZiyGaOw76Nr/QYIsqxuxFACDAnYVIr7BzNAXG8CDAUd/Wk3/SQhl?=
 =?us-ascii?Q?BcIJc3k8nIT8k7QyNa2wfQ0cSPsGhUkuVt5R6+8aF5cJ0z5xTcKNkm87+0He?=
 =?us-ascii?Q?OmHORknlyo7+gC0y3PMSXDmeIFsYN/Y7Qa0LeeQx0CDhcsXQQjmGKWTr5iyT?=
 =?us-ascii?Q?pum0+FNH7gYsO9Y/8kFG3ZqJ83SN64DTgE3TcSzH52iQncPcp+5eAf5wJ336?=
 =?us-ascii?Q?2uos5448qiy5wyf35ER57B62IxzTKRZvATpnJ+ZX16klU5LYZYunsgJbcEnL?=
 =?us-ascii?Q?FxGvKcQ18Kz5XVnrOyWLUD2HFWF5cR4FK/CarYhr42ewKoDEpC1vkOVX1Mf4?=
 =?us-ascii?Q?52/p0WOGXKIco9RAdgRzURLGsGKM5WhLE/SxIHRsoQ36IAZh9BgZ2NcOGrCp?=
 =?us-ascii?Q?JgajjEXMAO2LB31GndYI403+iH92utemCgqbFiO/FzY/AddGmXN5XtjzvPVz?=
 =?us-ascii?Q?E/pEYPMgce+94qft1qLdd+bCeDsgHT0d//dC0nDWM4yajzF8vZmuBqezaTWM?=
 =?us-ascii?Q?HIOediuIuGq7BFKhvhusWbPNUF9naJHHlQEgKdTs9tdhRfaRW3tWZBjOGyRv?=
 =?us-ascii?Q?K7dXdplkwT1X0OiJ9qjDOy+t+7SGEGiVAYBN/w1sJc2jC4Yv6lowrzfCaTXs?=
 =?us-ascii?Q?mt5Fmq2CSoJV38LwmcF5fEwng9lC9WC3ntoLmo6kP+u/bbex8vcLV+H2mXOD?=
 =?us-ascii?Q?ry/UbMDmCayrprPzCwnwhQbVS03zij3ows4wsOlbrhaQ5W7GT3tQIhR3H4v+?=
 =?us-ascii?Q?DJJ8b2fD2dcB5hPcLIp+UoDq9nbiDZF9tJ7ZDf/RKoz9HTZZYkfWsRYdcy7+?=
 =?us-ascii?Q?WMKB7jiGyt1+rqpouIYVQGEKN4Fl5a0rYsD/SDVoCuoN3Vc3ik2MXu6bPN8B?=
 =?us-ascii?Q?f+fC9/Vjyl+2Hju5v9jFzsY+WLc5DEr72AgYWCnBHY+bkFtHRtUKK7UwQkrL?=
 =?us-ascii?Q?anzPxFbODLeMU/YJ+uNRQUN69PDlix/VKFCrW7of4mMn/RCDiPDk7X13RJqL?=
 =?us-ascii?Q?+cWO2ruw7Axi4NDeck99Z6Wq0bGCpYi+/OwwQ5oDIAMUSW8R1aZnWTauY8kL?=
 =?us-ascii?Q?8fTgmWZ5Q2UZR+O70lXeHj4xyzdvId9emzsr3EHrndq8ScXJB34Iqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1D6kpifp4zqDkUlBKBR6tesh6WMEUIIt9sS5AXdPHS+5gAwxR/V2vnoPtOh?=
 =?us-ascii?Q?jRAU4or3ARrGTRdrtNMIXlO3ffoa/Ut3h+Xn9DVvtCBSPj0jnQ8NBqkSwA0k?=
 =?us-ascii?Q?NUaMbgOLKvlt5QMgHLwZmuWLduVFNsBUcPtOzxUk2xz580MxjkHiuCaySIdk?=
 =?us-ascii?Q?7NqF1uzqUwslb7431Qtl8fuV4Pxmu4QfjzL1hoaKHSBbWGXJ51lkQj3h8KTL?=
 =?us-ascii?Q?BkpzA48JILtiGTZh+8DBZ0kIYIf+DLcGpEVNWrEloDYlKxTPKy4f9bFRCQ2v?=
 =?us-ascii?Q?R9j+vM67QMCOLv++tVTkoGhpj1jCIDeLVfSunhiF8wREbFSi1/XM7SMSWsPn?=
 =?us-ascii?Q?BoKBdAjsCTrfNvQ9q6Km/UXDSQ63YVZSVUQgjIYLo0nb6uV2EjmzGQc7K+6e?=
 =?us-ascii?Q?4Dfsw31yP7BdWR1OXVFCd+hFpLsQcFMVyG+CQDSwm/dBHtS6do1y0H8ZzMPF?=
 =?us-ascii?Q?pgC3Uu5hDeLhr8gy+X8s27tH0fFGeVchwKQs8ycZNrS9CjPccWgf+90hoJ2S?=
 =?us-ascii?Q?ilOD90Jrd4hk6gJX17Y6CojGO3xRBwDbgDlJD6I3vEQ59a9JNPIcXaDamnvl?=
 =?us-ascii?Q?hzK5vZbcTVQ2rCQOvzetFEmfE0BFOw5OgZKmoxIKi/10wsY83VYjggBSMNva?=
 =?us-ascii?Q?jCGPIe0zb4v987Azgg24fSlDetDPXvWoz4Sgq7NbhPCjDS2fYr6bsBxzXVOM?=
 =?us-ascii?Q?iE3DfCHM5DpI+aP40JXWfH+8ximr+T8RJVYRmOec8Jord4fMNNE03PHaeoFt?=
 =?us-ascii?Q?kUaz0MpZoLxmc3BZt0qhHOtaTpez842FZiVx/h/MPcaOAfLAYK/T9dScofeZ?=
 =?us-ascii?Q?DH0nmUqpfirRj6Op9b5Vg7TtIu7BXbtq+BTpsO+EwP/ArS+ROda6Br8GA1X8?=
 =?us-ascii?Q?WCHFVPlODViB2OASc/irbEjE4DEKC7reS8ZxMcqpZjxcf+/yR9lOFI+prGMC?=
 =?us-ascii?Q?nbrWW/8UApB/p9tguLG8COyzBQhvs73YICG3apZqb5sYwcjkbEu7jFvVCN57?=
 =?us-ascii?Q?mSBsB2HYSsMAWN4hrk24Fp31rlggLneGQ3KccfeaRAKWgBCFPKAgHlXAVsor?=
 =?us-ascii?Q?2P6ER1PcDq5FYnjsCis+P7J+tFo+lK1nIKJJFajwe4vj7iITgcTataG/a6QV?=
 =?us-ascii?Q?QRPSW1Uk84b57J9GnccVYk8yOWRACk/Mqpaq0vMQOXScKpHTjp5LYL+czLb6?=
 =?us-ascii?Q?5PTf+eASqQSH2TgKBgnAZM2zFjrGpPPtXaGO75Wx/UA08ZThDZEoDXRQEMIE?=
 =?us-ascii?Q?RXc4JsjETl0vUX/olGjfnIOpZ9/P6HSssgnDas0L9SlSdGW1d97/qqHY87uL?=
 =?us-ascii?Q?VjsrBSMC0ctA+ynUALtuLXtimAOTlU/HpM1ExD3Q1T2uXBuJ8rPCL3cNQUyb?=
 =?us-ascii?Q?kK/uKnWdpRyP5S6Ppf8dXJwmHmGqPLW2WvGI9R6jYH+JdwCYiSSD56WyZ4a+?=
 =?us-ascii?Q?dISie8r6cKnmeQ1w/0pVUBvUdy1AK3sSkjE82vDIzaXCmxZzk7vXdDJcIf+c?=
 =?us-ascii?Q?+Tsby+aFJYEoz2NTbb1rRk+CUTBuSpHBpqOIXVhOIn8VE8jI7Dja3TWAAycE?=
 =?us-ascii?Q?ieCTIq69QeBYkRKiB2c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dd3103-a007-406b-92e9-08ddeb11d8e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qpmnEktKMRQw046Emwt6WTvwswJJMbYrOtv6QmesYm+NayFoWMYOZhkDLuWued2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/driver-api/generic_pt.rst | 140 ++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 drivers/iommu/generic_pt/pt_iter.h      |   2 +-
 3 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/generic_pt.rst

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
new file mode 100644
index 00000000000000..410ab24e9a1fa6
--- /dev/null
+++ b/Documentation/driver-api/generic_pt.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Generic Radix Page Table
+========================
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:doc: Generic Radix Page Table
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
+	:doc: Generic Page Table Language
+
+-----
+Usage
+-----
+
+Generic PT is structured as a multi-compilation system. Since each format
+provides an API using a common set of names there can be only one format active
+within a compilation unit. This design avoids function pointers around the low
+level API.
+
+Instead the function pointers can end up at the higher level API (i.e.
+map/unmap, etc.) and the per-format code can be directly inlined into the
+per-format compilation unit. For something like IOMMU each format will be
+compiled into a per-format IOMMU operations kernel module.
+
+For this to work the .c file for each compilation unit will include both the
+format headers and the generic code for the implementation. For instance in an
+implementation compilation unit the headers would normally be included as
+follows::
+
+	#include <linux/generic_pt/common.h>
+	#include "fmt/defs_amdv1.h"
+	#include "pt_defs.h"
+	#include "fmt/amdv1.h"
+	#include "pt_common.h"
+	#include "pt_iter.h"
+	#include "IOMMUt_pt.h"  /* The IOMMU implementation */
+
+iommu_pt.h includes definitions that will generate the operations functions for
+map/unmap/etc. using the definitions provided by AMDv1. The resulting module
+will have exported symbols named like pt_iommu_amdv1_init().
+
+Refer to drivers/iommu/generic-pt/fmt/iommu_template.h for an example of how the
+IOMMU implementation uses multi-compilation to generate per-format ops structs
+pointers.
+
+The format code is written so that the common names arise from #defines to
+distinct format specific names. This is intended to aid debuggability by
+avoiding symbol clashes across all the different formats.
+
+Exported symbols and other global names are mangled using a per-format string
+via the NS() helper macro.
+
+The format uses struct pt_common as the top-level struct for the table,
+and each format will have its own struct pt_xxx which embeds it to store
+format-specific information.
+
+The implementation will further wrap struct pt_common in its own top-level
+struct, such as struct pt_iommu_amdv1.
+
+----------------------------------------------
+Format functions at the struct pt_common level
+----------------------------------------------
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:identifiers:
+.. kernel-doc:: drivers/iommu/generic_pt/pt_common.h
+
+-----------------
+Iteration Helpers
+-----------------
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_iter.h
+
+----------------
+Writing a Format
+----------------
+
+It is best to start from a simple format that is similar to the target. x86_64
+is usually a good reference for something simple, and AMDv1 is something fairly
+complete.
+
+The required inline functions need to be implemented in the format header.
+These should all follow the standard pattern of::
+
+ static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+ {
+	[..]
+ }
+ #define pt_entry_oa amdv1pt_entry_oa
+
+where a uniquely named per-format inline function provides the implementation
+and a define maps it to the generic name. This is intended to make debug symbols
+work better. inline functions should always be used as the prototypes in
+pt_common.h will cause the compiler to validate the function signature to
+prevent errors.
+
+Review pt_fmt_defaults.h to understand some of the optional inlines.
+
+Once the format compiles then it should be run through the generic page table
+kunit test in kunit_generic_pt.h using kunit. For example::
+
+   $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig amdv1_fmt_test.*
+   [...]
+   [11:15:08] Testing complete. Ran 9 tests: passed: 9
+   [11:15:09] Elapsed time: 3.137s total, 0.001s configuring, 2.368s building, 0.311s running
+
+The generic tests are intended to prove out the format functions and give
+clearer failures to speed up finding the problems. Once those pass then the
+entire kunit suite should be run.
+
+---------------------------
+IOMMU Invalidation Features
+---------------------------
+
+Invalidation is how the page table algorithms synchronize with a HW cache of the
+page table memory, typically called the TLB (or IOTLB for IOMMU cases).
+
+The TLB can store present PTEs, non-present PTEs and table pointers, depending
+on its design. Every HW has its own approach on how to describe what has changed
+to have changed items removed from the TLB.
+
+PT_FEAT_FLUSH_RANGE
+-------------------
+
+PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to generate a
+single range invalidation for each operation, over-invalidating if there are
+gaps of VA that don't need invalidation. This trades off impacted VA for number
+of invalidation operations. It does not keep track of what is being invalidated;
+however, if pages have to be freed then page table pointers have to be cleaned
+from the walk cache. The range can start/end at any page boundary.
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS
+---------------------------
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE; however, it tries
+to minimize the amount of impacted VA by issuing extra flush operations. This is
+useful if the cost of processing VA is very high, for instance because a
+hypervisor is processing the page table with a shadowing algorithm.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 3e2a270bd82826..baff96b5cf0ba4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,6 +93,7 @@ Subsystem-specific APIs
    frame-buffer
    aperture
    generic-counter
+   generic_pt
    gpio/index
    hsi
    hte/index
diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_pt/pt_iter.h
index 6bd84f96f5ad6e..0956c8a45646c9 100644
--- a/drivers/iommu/generic_pt/pt_iter.h
+++ b/drivers/iommu/generic_pt/pt_iter.h
@@ -21,7 +21,7 @@
  * pt_check_range() - Validate the range can be iterated
  * @range: Range to validate
  *
- * Check that va and last_va fall within the permitted range of VAs. If the
+ * Check that VA and last_va fall within the permitted range of VAs. If the
  * format is using PT_FEAT_SIGN_EXTEND then this also checks the sign extension
  * is correct.
  */
-- 
2.43.0


