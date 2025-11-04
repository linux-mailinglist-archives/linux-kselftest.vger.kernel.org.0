Return-Path: <linux-kselftest+bounces-44735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A213C32A5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28A118C3E39
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9F33DEFE;
	Tue,  4 Nov 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pR9pB9FA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A82727FE;
	Tue,  4 Nov 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281031; cv=fail; b=p/xpvQ9AyWARB94cymjOA/3q6RhqSsUMaLBpa+pKwyA8GESgzZuzHrQTbkx28SDfD/mSMmhqOPwG+4NDJlfH5p9k+nzWa+9xFRPzMxh7xKHdLh/bCCeLjr9lQrC00g9bFq/buHD8AJpYq+5bTd/S7ReOEyo82C0ObEQiHhkCdCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281031; c=relaxed/simple;
	bh=Ea81FDw48ll4DI5X/jJkmPwSlaSk7EaQ7GHbQd/xILY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkwLa/xDQmhDjBMh0Twbomas+ZUCZdic49Hp2nO54JmsSFzG1/QqnC1DkwwdNTzmo9FfGMUjr625BHQuN1YOYPoG7xy6EpUlvjbg/+7KXUEYIZFx/WAcE0lzmKGfYB8pDRv+NYEg0YQMFgyEejXk5BsWCnefLHW/QCUvNIqdYbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pR9pB9FA; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wONFnYwz8rJJXLi87kOxZsQoisHA6/nDVtsiDtQS/GC1d8MNoiR3HuW6HCWfIGOQbOFAIvBnyv/TQM2u9cRpZ5xgxd8p0AZwQnTKOByTm4S/xMkhkjdp5NdjDlXwwgy6MOQo4/z3OumUROTqKaAD6mpuDzmq5refNYVIS8GrhbOFH9rDoscPNxz7hn9SaQio/ujloiT/TJEpYNr+Xri7o6cmNh0uOSwp8777HMlWlNC5fzN/EACN3jx0ThlBwnlljwYnznxzzb3RKxe3Z/hha9NQASptnhQmBp/D7m2voXQemuCEQKaO7iESjlR7piWgLSisygc25hRgXsHNmBnX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZND/QoW4wRPmictiEDLn0vvHW3AKeQKGbhjUP+Lh9/E=;
 b=YNPt4OHo1MtjC9HHOcfdkQwg8HHiwxilks7L9vdoceyzd8+U8Xl4QU5TgKx7WZzV45zd6oLZdSrC0yMmLK76lm/MekBzFy2MPmy6jqqtKuqagDa97cpjNX+utcmDKDTIqoo1LQryND3QNrYHN56D/od30XKlNgvzQYQ7tSryCCRgjqxIwdt1ZVKH3QFFtycDe6mej2EkIBcSNgssyO8h8y+j8gypJiEQROtXrE43a/OPJ4TI2CrWIYc53gpfpjdvaUq+G0fMOQCEmwDNgn3dnswv7OZr3mfjFEx9xwiE61UYzvXdgBx0ymMs9ildpufVbfEw3z7CzfwuwbcIi9UYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZND/QoW4wRPmictiEDLn0vvHW3AKeQKGbhjUP+Lh9/E=;
 b=pR9pB9FA3xcon8xvI0f/xb6//K6tF14N2l/5A6N6C/VGeN9r0qIabzxz7n5fRTdZzdOFWYueHQlotrOfJu4r8e2OA8CaPJZbMTSPZPta3PhN51d8B4izxiRQTxQKwqG25/wLyec6CPX8ylDcCh2xxU9tR8P1PgcLy/pjmSLxh5WqA9hv2wVeulDjiEVednMdWd6VxjQDjcvB2iCkeZjYlTKqqFUr9l1n9b93R6gHT/gPikqOqxBzFKAHsOoPZxsKn6YmzB1Hz1JAHW8YE42VPKaXjl9uIdR0GOouM0hHqiDW3n3wGLrUKIaZ9r02SRN0W71bGnVDlyrMmlf6JU0e/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 05/15] iommupt: Add iova_to_phys op
Date: Tue,  4 Nov 2025 14:30:03 -0400
Message-ID: <5-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:36e::18) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: e48eb3c2-3080-49b8-2178-08de1bd03329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZmxuCXwjIJvFu1cJdzJMROoiNqnm9mEzKpdlgDIZTLIpu9aErp7ey+dsk9+0?=
 =?us-ascii?Q?ghJDgB534fgJtqXEfgpeadX8K0e4oxLncIcoL3TWH4QLye4aSsOvp1z3ZMcp?=
 =?us-ascii?Q?uwSSeI/4BVP7mPOOo7R4lYudU2Js/VCsWSag5Gz9CJjaJsBL7RFU+x9WZr6g?=
 =?us-ascii?Q?FZCxvYqCWeFga6vvMiOgs28icEmpN77I4lzZh+GbKzmijbYmn48wYAKMFfGE?=
 =?us-ascii?Q?XxnnI06wACTijNY0jhVijNozQiPEHSsInLkaK3uZrZxk9ULl4Kxj3rH/QoEl?=
 =?us-ascii?Q?EISVvsVoMnAUsgaLRbeK7XbLVcQlvOkqG1cvM82jFtWXqKNlgKYfQcO7oy08?=
 =?us-ascii?Q?+etDITFKPdi9HzZ6xEQFHpvuhfZ/wxpQ8th0mmX0bDZ6G4goHuIJaruBDAz+?=
 =?us-ascii?Q?usCptKov2I2o64xIO/mNVDGpTg+oJDhg/ATM828ev/UUg9VBVwp0HL4vp4w6?=
 =?us-ascii?Q?n8EK42urR2bDAO3O/r19HMLgGBgAmkzXR6konqam5EX4r3zxQ9SfFqZllKBy?=
 =?us-ascii?Q?eLwHos7AjUbzxdw8LxlGzR9Ooe5C7jYRQmqIoAjfTXviq8q92+G1i1ZaDvSh?=
 =?us-ascii?Q?HtCYh03oQr5hZeZjkC0XmNLD/jAVmj4zNdTxZOra336l9yZhdY1mG+s/G9rr?=
 =?us-ascii?Q?fk/iOH4YdrO+7mhtG/APJ/Y63Kya7+DUmdZnDcanMX7P7j5PcDF2SBMF246J?=
 =?us-ascii?Q?cQ1plKMz1ZOE+al2UZvZD1zR+MneFY2RKdWLEYSTOEYezo40cLbQ5u8ZNU+M?=
 =?us-ascii?Q?YgcbswtTngiLrvzWkhFwAVat5TppK+wPdoh03AgVRuzSxMfJ21sSV1QGP15A?=
 =?us-ascii?Q?xlAn7CN0yVmmtvChcLT5muSNOEvCKPwStwLxBiU1lAnZlCyfnNcky/FqYlPu?=
 =?us-ascii?Q?qLZpIC0XJxh4GqgpKbg77/si4SvBzB8RcF0rISPbSUxdux8Fh5i66ehY2fCA?=
 =?us-ascii?Q?ZIoodE6q+wI7m9RLg/IkM0IhaYCm7lxp+onyLRaRrlpXITajfz8D5G1gFZL3?=
 =?us-ascii?Q?VCCu6b+A1JflrNBI2JaieUX38y6427WwlnqZAdQBPNomNHG6f5+KHZxA0PpG?=
 =?us-ascii?Q?GxTsOhPtso8M5SJX7Qjc0GdT5XTmw1ylZALZEZxRg7dWmEipVAFDo/zbNcgu?=
 =?us-ascii?Q?71qztQeMBDskzNQX+K+Wk9mIB2tgmnKMjYmA4AaWeOER0vr/80FCzQU7NZQN?=
 =?us-ascii?Q?BdxQgKRft6hc91hRKP/rDQ/aIUkBZA40UrgNJqcLAzmEQ+ASYERVVH7pN1L8?=
 =?us-ascii?Q?FJ2dxg/h++1zxtQEVAiafTq/9aeHowVJqqB+67SDIfv6ioyvw68esEz50A1C?=
 =?us-ascii?Q?8/uSoKJbpuZDqsy5q9kmevn/oTCG/unq4+9RfmwU98YXRBnIhFs5ZxKsZ66T?=
 =?us-ascii?Q?wu8kIbwfc3/CkuZz7BeRqBFpq0V1fQ9lt5yIg0iqXdpHonL9r4ZO0Qq0WzzU?=
 =?us-ascii?Q?i8TVAGjwR/3rs6nEKEMx2eR89cAJhC+c85TdY55/N5j7O2SgGmov0otsT5r/?=
 =?us-ascii?Q?DoWU5BWeqjTrBXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jR4EE/XoRhjfwKqEOYFl/jyjKxpRjfvT6+JMsuxYlS1RFBj4hGfRpE+h5ckk?=
 =?us-ascii?Q?0veXIxG7UMVTUXC5RIByEGEagkO+oFbJh/3G52dXl9wRiEhQF3hdp751uU2m?=
 =?us-ascii?Q?n/uCRLM2m+XD2C0mPPNQO3vG6UjbCHAgdZofEanKceS4oeI14VoskLfsFgB7?=
 =?us-ascii?Q?EkCDSpD4e2J9JYEhECwwzNj0U2XPeGEstIIHfzhnO58VV6KMspnPPcH+zBm5?=
 =?us-ascii?Q?Wh+ngXw7wtvp8SKzFNg1WDtsnFC4pamtTyE95D0a4p8RLHiz0llqZDHvGn08?=
 =?us-ascii?Q?+yenZ/6Nyh7XIR7XK7r+YPdZ4ue/r9KF4MC+hnYNdDOBCVZyrVL++DTT6SaN?=
 =?us-ascii?Q?WXlFFk2FGlVGveF0wss3fuhxFvbV52SMd5oNp8FDbzQnczX08IBALtmRcauX?=
 =?us-ascii?Q?H6ZYCsaeH0RZP/kUVveOZxaxb9InKaGerFWTxcvw8MxaJL8etDv+QoudtLHm?=
 =?us-ascii?Q?SmCtu/aWv2sp7nEBJsF1sLPx3F8hWq9fa9+Y7XIpmFTLR9FMj6ireAd3FooY?=
 =?us-ascii?Q?uSAB3BfEpigz0rfH7XY0FtKA6xV0qnRJao1S4NVELEIIgFuh7wqwWwSXMJbv?=
 =?us-ascii?Q?37h9am09WVyXKKgAKXnzCzGQLvA/6SJWINpd1p+862IlkbLGvB4aYSerZA9B?=
 =?us-ascii?Q?NvqYOAy888dPrX34WS9518GETUgBhiWvNdvc3sqz1X4EhomfKQgArGmV50/S?=
 =?us-ascii?Q?tVTVUim46UGC1XgYZB2E3xR4kiGzerGlhP9g/ycxIH6Wpiti+N4f2TGh/JRO?=
 =?us-ascii?Q?eArD3mhn5TY+7UYqYz/FxzMu+7ejrbKfb2+ccYKh+wzM8bJAEBrfE66IhrOR?=
 =?us-ascii?Q?2pANnuvkQV/SKGNXlUCz9G4sCD2PNw2vKiyqEo7X9wVQAaBvudMLht45juM2?=
 =?us-ascii?Q?BInHEA9NPQfUjW7wh7r1kNb6bK8Ms1uCOxuhNF/e2/ganotguBbDIyYI9aqy?=
 =?us-ascii?Q?V6gQyE/qe0dt8q+moyZlROc6DhghFsq/YeNZzi2Hmg9GDqoNJdS1qpqJ/T6w?=
 =?us-ascii?Q?Equc+5t3kgvXEVi7QBqBXs509V4A672t4MZpDDp3J0i7ac3tqTDpmzOy9h/N?=
 =?us-ascii?Q?GZtGfw+XZy+ob/2A68ooavcqfbmOf+dO1GOT3pJYBGE4ul/pDx4ebBmhxUxW?=
 =?us-ascii?Q?KxQuFOEXe/5jMVLZtJJRM8yzROD3k9lnesns34IKZOncu84sK7VYUVjPp3h/?=
 =?us-ascii?Q?sPpRT5IvIc/car2EQNGEMahfZ33MexclqF0OlNkEXpziB6ybvMEulEFRgJUf?=
 =?us-ascii?Q?41YYW0kJpG5dit7jgI/NOVNUHeNO/zXLOg9stjP2H8gklNFE4hSPwjltjg/0?=
 =?us-ascii?Q?yrSqtDPHWGKxrcX+xTFaKYBr9svUbGscKeJX+Z0G7fiJA2sxvF8Pyg5Alnwh?=
 =?us-ascii?Q?ykarPqBMW2kbpyWyY1YVw/aMNuG8stayddnhufq5gQzD2CWqcCahnXdcqBuA?=
 =?us-ascii?Q?Vd/DwsFztCfP2qFMS84inlwG8OopKXk1n4dT9ctEzbJJh6uMfaD0SJChuM+b?=
 =?us-ascii?Q?N+RCXj9djig0jd5DkN0EdCLxR96NpsSz10UaKbU7OvKy0IQBkgTszQt1iwr7?=
 =?us-ascii?Q?NqLC/VhiXU4RAPlczwI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48eb3c2-3080-49b8-2178-08de1bd03329
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:15.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5T0qe1MgNn8AYJ6cXqvMtO+0HWWxjPYh0R70Mpx8hmMpYnXvP79uPQ7eQP3BElw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

iova_to_phys is a performance path for the DMA API and iommufd, implement
it using an unrolled get_user_pages() like function waterfall scheme.

The implementation itself is fairly trivial.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  19 +++--
 2 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 564f2d3a6e11e1..5ff1b887928a46 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -17,6 +17,111 @@
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
+static int make_range_ul(struct pt_common *common, struct pt_range *range,
+			 unsigned long iova, unsigned long len)
+{
+	unsigned long last;
+
+	if (unlikely(len == 0))
+		return -EINVAL;
+
+	if (check_add_overflow(iova, len - 1, &last))
+		return -EOVERFLOW;
+
+	*range = pt_make_range(common, iova, last);
+	if (sizeof(iova) > sizeof(range->va)) {
+		if (unlikely(range->va != iova || range->last_va != last))
+			return -EOVERFLOW;
+	}
+	return 0;
+}
+
+static __maybe_unused int make_range_u64(struct pt_common *common,
+					 struct pt_range *range, u64 iova,
+					 u64 len)
+{
+	if (unlikely(iova > ULONG_MAX || len > ULONG_MAX))
+		return -EOVERFLOW;
+	return make_range_ul(common, range, iova, len);
+}
+
+/*
+ * Some APIs use unsigned long, while othersuse dma_addr_t as the type. Dispatch
+ * to the correct validation based on the type.
+ */
+#define make_range_no_check(common, range, iova, len)                   \
+	({                                                              \
+		int ret;                                                \
+		if (sizeof(iova) > sizeof(unsigned long) ||             \
+		    sizeof(len) > sizeof(unsigned long))                \
+			ret = make_range_u64(common, range, iova, len); \
+		else                                                    \
+			ret = make_range_ul(common, range, iova, len);  \
+		ret;                                                    \
+	})
+
+#define make_range(common, range, iova, len)                             \
+	({                                                               \
+		int ret = make_range_no_check(common, range, iova, len); \
+		if (!ret)                                                \
+			ret = pt_check_range(range);                     \
+		ret;                                                     \
+	})
+
+static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
+					     unsigned int level,
+					     struct pt_table_p *table,
+					     pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	pt_oaddr_t *res = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, descend_fn);
+	case PT_ENTRY_OA:
+		*res = pt_entry_oa_exact(&pts);
+		return 0;
+	}
+	return -ENOENT;
+}
+PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+
+/**
+ * iova_to_phys() - Return the output address for the given IOVA
+ * @iommu_table: Table to query
+ * @iova: IO virtual address to query
+ *
+ * Determine the output address from the given IOVA. @iova may have any
+ * alignment, the returned physical will be adjusted with any sub page offset.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Return: 0 if there is no translation for the given iova.
+ */
+phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
+				    dma_addr_t iova)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_range range;
+	pt_oaddr_t res;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __iova_to_phys, &res);
+	/* PHYS_ADDR_MAX would be a better error code */
+	if (ret)
+		return 0;
+	return res;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 };
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dc731fe003d153..5622856e199881 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -116,11 +116,13 @@ struct pt_iommu_cfg {
 };
 
 /* Generate the exported function signatures from iommu_pt.h */
-#define IOMMU_PROTOTYPES(fmt)                                             \
-	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
-				  const struct pt_iommu_##fmt##_cfg *cfg, \
-				  gfp_t gfp);                             \
-	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+#define IOMMU_PROTOTYPES(fmt)                                                  \
+	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
+						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
+				  const struct pt_iommu_##fmt##_cfg *cfg,      \
+				  gfp_t gfp);                                  \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,            \
 				      struct pt_iommu_##fmt##_hw_info *info)
 #define IOMMU_FORMAT(fmt, member)       \
 	struct pt_iommu_##fmt {         \
@@ -129,6 +131,13 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+/*
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
+ * iommu_pt
+ */
+#define IOMMU_PT_DOMAIN_OPS(fmt) \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+
 /*
  * The driver should setup its domain struct like
  *	union {
-- 
2.43.0


