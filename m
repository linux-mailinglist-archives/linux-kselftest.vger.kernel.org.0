Return-Path: <linux-kselftest+bounces-5292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2009A85FC19
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433431C22459
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB5D14AD00;
	Thu, 22 Feb 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JydPCJe5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F675149013;
	Thu, 22 Feb 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614986; cv=fail; b=C5sNyJxiLghDuKPo7CQfC/a/HLDPgNv8IzyWL4UJe+szpf7FI4tBPaUGWXRJ6w185bjqRAYCAwB9jRCukjYgUEalZa56C5/xX6DBa1CGxI5B11cKOQbM9hoDsragMHEY7RHecIlzooMdyP3nbYIcqbH3lSn3MthL9EJ3w96lBUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614986; c=relaxed/simple;
	bh=k31XIHRpapVioGz2+Ionxp0er+Qz412zviZ4G6+dTXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/pg0JYdYD407+ptXvtUDTj3XzdRV3D9VZGMA06CZe3RS6/MJEj2oBCBLq3G7j43pZC6cufZHuxgkXW/DNEkj1/OG3ROb+tayqVr0VMZla1CEmJKWjzbdWvU3rZxcUN60qR26JiEN2zo1blOBBuV2GcSelmkPmEmFNlnFjJh6C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JydPCJe5; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx2GAZ3bbmopCZwRQJVdjd7nKWP9w/9Ybg4LUWoYMJFX/Q38AWpJs7be6uOd0XimX7oOvfpGb9Ayfb2XTlwzx2O1quTgzBa+nn4LdBpZ5YYXG/5MvAQa2BoMMDvtixyvSu0Y78w55tZ1QD03gWX7lE7dhV3Ls4LlJ5Ar/pOfCbcPVMlaanAmVyW2+b4RydefW6jvI2iwT3Wtlvz6uhyvPVgHYw0SRLklppcCcAp0EJAs3lfIBeRoQZZgOQApGikfm4pxH+oZUa/aM/72QcNPZP1Ip9/MKPj9l1Wb1pgk798gAbXQp9cSLzM2ZeXGEMCvzJ//mGlFCufsZFeNT24J9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi0yUJ7Tr0c48CouNKbmPOyIQVyrrFvFLBE+jxZwMQg=;
 b=JgXL5bi19prhSFdeY4yp+ZBAGNdGN8brukq/OkGLyAfpohfNLVr92iIX4ev9469qT5CR8dyQT/4x3PNvA0Lmmo71s2oR/w5w0T5erwZI/met2XwgLJIZA1IRbTB8SNnw0sRKIeG0WS2yuxciGIQfERhmGquNv4PD/XW6Gls/V0i8Bx3xz9gmvmp5xpD/b/wtJJ3lEB3WBjzEDcOlmKFzvN2M7oRwkpSMfCqBKezckUK5mEbLaq0VdL73KeuzZZahKivcSGJ07GHMK6ERW6HY6eambEU3d5BJldoT3ZAwbMiw9Fql0+n4r45dYdVXOuGnDuIejbTZDxGRstU/2QZu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi0yUJ7Tr0c48CouNKbmPOyIQVyrrFvFLBE+jxZwMQg=;
 b=JydPCJe5QqzHSobMVXP6VHvZNvHO7HjMIC5xK+RDEwpOcHAu91fnBD92vun1fk7UAwuviFUSrOHM3cVCnYyxMzlIcIAddTOgvgh4nL/w/d+bfzyF/5dgMlfPEpyI2Yw5a2Xk0mJl90aKOZ4UGdl+caqymvw1yrV/5A4w3UKzPp4g3IUPDe7IrbdnO1Xj6Raf+QbbXgQ1S/rnwGQ/WuC4AsmSl83vCiqyYHC1fyQKY21dxtmqoWyOWXW8jF+CchNTZwpKzjf9XAD9rNR2urqjwcF+Nz+wa3TH7UWElm4zVtR2USjCxcNTIRk9ApQu4D8cxibf4j5L4Ct26l6mC2bJIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Thu, 22 Feb
 2024 15:16:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 15:16:19 +0000
Date: Thu, 22 Feb 2024 11:16:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, robin.murphy@arm.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: Re: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent
 domain
Message-ID: <20240222151618.GA13330@nvidia.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-4-yi.l.liu@intel.com>
 <20240221151923.GU13330@nvidia.com>
 <d6b9ccff-3aba-4508-b83e-4bc3bc859e96@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6b9ccff-3aba-4508-b83e-4bc3bc859e96@intel.com>
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 497ab2bd-b21c-4df8-0135-08dc33b938f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rgazo0c53szyMiPz33NNJ0LI5gvWaGPBk9aEK6aa017Cy2Ec0ptOD6AMwpBKNqv8dHvr9LV6qRKCKUUzUKd7jLi++xpEb6TqwK87Rn28S3KX6UcnaFwpW4HXktDxyiR+jTlCVRWdTMYFHu3lzKpxVgP4oFZdTcPl4ID9Ew2sYRFXWUTJUtmi/Ovf7BwJRG+cdTRM9xwK8vCg06+9d7xH4uQFRgNG3hWegICtNdGwlA/tZU9O3EfLA0sy04pdQxmBBwG2G4pOKILhhNBHB1V3UVDzt0vdoTESUG5zbvw7o+JDvBQJT9k+Z6pu/7GnrAt9/Zi0QcSNPjjVuMGZyGKmJAUy0NAr/sUZE4d/RIHYA7kpJYgKScLxZZiwQmW8pciU9AAQ6dbuMAM7DZVlTHz3X7YgtixkglZbzrlPyV51EsnJgI2ysyskcD+OnPbXDS103zqdDX2bNm+oKba1aGik/kR/IMrjFnhC1JaOJRLHxDruw/CZpiVuPYrjaIYavGtbvACqeQeCRjliyzEvEmn4nUvsAJvZZb99Zo9/4MC33Fw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dCeOQKsApvo+84MN3JcyOK0pSMP/5p4ffsT5sBhrTU0XR4WHtT721zeokwA?=
 =?us-ascii?Q?h6pbCEkHtXkRujCJxK0Nk6qNWyOCD9o0ghS9Vo2Ir9Q82CynaqLQ2DBWeCcH?=
 =?us-ascii?Q?uuU8HiRCuMZPAE5bacDJBlsKJyYdZXQlwwHLnio6q0E+fkXodG38TuEX5shb?=
 =?us-ascii?Q?nUYE8u6TJ7Z2tI2SvIgATcv0hT8urDYzmooEUE4BzPnX33I+NjY19NrFncif?=
 =?us-ascii?Q?+baaqW5PMs08EC+Tzzo44sFstM/UD1E4d9QpvBH6PpD6+juhM1laIHx2bUd6?=
 =?us-ascii?Q?oqFqkSonzd4M42D7U5/iT9wIBRCn4q1ognJdoeqotu+h6pbfRHkNFmmqIEAa?=
 =?us-ascii?Q?0e5LjdtASRwDTCb+Tg6+58k4lrWxzNI8GasPVAyJ+GVkUERtqnNH/llQR9+O?=
 =?us-ascii?Q?nKm2AUJOkSLkmtKF5ROd5HnQWzLBVSkMpRBOEkia9I4OI//vHMVxQgOFJdE6?=
 =?us-ascii?Q?qCZ5TFM4//KJjSXLAS26YI50MY6yseDlglYeFzqgcQEzIR2dIkBViF/uAK4+?=
 =?us-ascii?Q?enWMf4P9PLGmmcQcW+9+oUzk5XwDtWtlCGquaxKl/0kvBYpwbdB1BdnqInrh?=
 =?us-ascii?Q?NVrqhLn4S5/HNyWEu+u9pSDk6GM5iIlSotC03EMrmgSm4gwgm9W2xWv008NX?=
 =?us-ascii?Q?ZiYmvSaUX0MNBovnj9psFIy4qk+Le59nLUQU9JkS0KJ54KxZwdHMe7aJtfXQ?=
 =?us-ascii?Q?iBzL01mg2MTjIhhr+WkOK36i/CK8OVFV5wGy7iHWRrS2mqVbNFLbqHi6TaVi?=
 =?us-ascii?Q?NuyienkOlX9zXt61LGnNWtBHdDN6zZ0deXnyxkBEmdMrWBcpQrJ7bLcIeSyw?=
 =?us-ascii?Q?DF7QJ3a+Vz6aTEtAkYxsuPbAOBp+m14LGF+eo30AAysh8ElXiPcrQtHM9adU?=
 =?us-ascii?Q?57L9XBho/cABojL7t7nknp1po+St2gcVYxFR8kSjYoIFY4o3O9x1V7XgRgEA?=
 =?us-ascii?Q?reYvwuFYWDCHfpPhAEvjRiz9ow/IP5sWZG3CtUpRiuC13yM8tIZLBrE2IEIJ?=
 =?us-ascii?Q?YfSgREdJGb1rrpt43nP1ibsBDmdXAaTGhk9JfpnfIRUTuITZT+DVXFjVYqQe?=
 =?us-ascii?Q?QYGKSobRGFGto74lZKl15yNyBNNdR9VkG2i7o3NmLeK4wn0aoGK+GPQEIgDw?=
 =?us-ascii?Q?ZAiFjAIpUbpKxqMQ+1SrOBgQjAN421bu05NHyPKe6a6OcOTRSlhX0Ux6U9L5?=
 =?us-ascii?Q?zRJy6iWVpgikgKNtvd2i2M/e80WJtPB+jb0YMbexsFD1JKK6xh1O5DH8g9jn?=
 =?us-ascii?Q?SztLbGqsRLYsNnsMY9f4p2ZFISSY02WyIjpWh9Eh0Q7GMuGzhMbx/h4wU+le?=
 =?us-ascii?Q?9rxidXJEuGZtv2A1Ve0367F7njO4nwms/6TK60sKT72HiWAUmpYrdA/SxS9o?=
 =?us-ascii?Q?gV6c0ZxANrqqFk8UwDu6HbgPB/4P5G6tc9Crf5AAvwkR8Nh9NanlC798Pw4h?=
 =?us-ascii?Q?0kfl68zq8+Wo1aUIdMdROLnCIYZYR2pxdFBYKLqsxPsen50CgzNIOhV42i5H?=
 =?us-ascii?Q?LuKG5aONmc8M9vB6tdvuni6HM7pvEnudsui4CKFyH9fxk/UVCi8F4TqndQcT?=
 =?us-ascii?Q?YH7U3jRC3/Q/LCvdyR6cHFHLwOrXbWcSPybGaGdl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ab2bd-b21c-4df8-0135-08dc33b938f5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:16:19.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTKpMm0iYT1KGJVWmuTD0sHkIKA0aznwvp4uqfk2nvgAmWIMaaU13qeDnWT4KsQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380

On Thu, Feb 22, 2024 at 04:34:10PM +0800, Yi Liu wrote:
> > It doesn't mean that the S2 is globally shared across all the nesting
> > translations (like ARM does), and you still have to iterate over every
> > nesting DID.
> > 
> > In light of that this design seems to have gone a bit off..
> > 
> > A domain should have a list of places that need invalidation,
> > specifically a list of DIDs and ATCs that need an invalidation to be
> > issued.
> > 
> > Instead we now somehow have 4 different lists in the domain the
> > invalidation code iterates over?
> > 
> > So I would think this:
> > 
> > struct dmar_domain {
> > 	struct xarray iommu_array;	/* Attached IOMMU array */
> > 	struct list_head devices;	/* all devices' list */
> > 	struct list_head dev_pasids;	/* all attached pasids */
> > 	struct list_head s1_domains;
> > 
> > Would make sense to be collapsed into one logical list of attached
> > devices:
> > 
> > struct intel_iommu_domain_attachment {
> >     unsigned int did;
> >     ioasid_t pasid;
> >     struct device_domain_info *info;
> >     list_head item;
> > };
> > 
> > When you attach a S1/S2 nest you allocate two of the above structs and
> > one is linked on the S1 and one is linked on the S2..
> 
> yes, this shall work. ATC flushing should be fine. But there can be a
> drawback when flushing DIDs. VT-d side, if there are multiple devices
> behind the same iommu unit, just need one DID flushing is enough. But
> after the above change, the number of DID flushing would increase per
> the number of devices. Although no functional issue, but it submits
> duplicated invalidation.

At least the three server drivers all have this same problem, I would
like to seem some core code to help solve it, since it is tricky and
the RCU idea is good..

Collapsing invalidations can be done by sorting, I think this was
Robin's suggestion.  But we could also easially maintain multiple list
threads hidden inside the API, or allocate a multi-level list.

Something very approximately like this:

Jason

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93a0..7b2de139e7c437 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -38,6 +38,8 @@
 
 #include "iommu-sva.h"
 
+#include <linux/iommu-alist.h>
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
diff --git a/include/linux/iommu-alist.h b/include/linux/iommu-alist.h
new file mode 100644
index 00000000000000..7a9243f8b2b5f8
--- /dev/null
+++ b/include/linux/iommu-alist.h
@@ -0,0 +1,126 @@
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/iommu.h>
+
+/*
+ * Place in an iommu_domain to keep track of what devices have been attached to
+ * it.
+ */
+struct iommu_attach_list {
+	spinlock_t lock;
+	struct list_head all;
+};
+
+/*
+ * Allocate for every time a device is attached to a domain
+ */
+struct iommu_attach_elm {
+	/*
+	 * Note that this pointer is accessed under RCU, the driver has to be
+	 * careful to rcu free it.
+	 */
+	struct iommu_device *iommu_device;
+	ioasid_t pasid;
+	u8 using_atc;
+	struct list_head all_item;
+
+	/* May not be accessed under RCU! */
+	struct device *device;
+};
+
+void iommu_attach_init(struct iommu_attach_list *alist)
+{
+	spin_lock_init(&alist->lock);
+}
+
+int iommu_attach_add(struct iommu_attach_list *alist,
+		     struct iommu_attach_elm *elm)
+{
+	struct list_head *insert_after;
+
+	spin_lock(&alist->lock);
+	insert_after = list_find_sorted_insertion(alist, elm, cmp);
+	list_add_rcu(&elm->all_item, insert_after);
+	spin_unlock(&alist->lock);
+}
+
+void iommu_attach_del_free(struct iommu_attach_list *alist, struct iommu_attach_elm *elm)
+{
+	spin_lock(&alist->lock);
+	list_del_rcu(&elm->all_item);
+	spin_unlock(&alist->lock);
+	/* assumes 0 offset */
+	kfree_rcu_mightsleep(elm);
+}
+
+static struct iommu_attach_elm *
+__iommu_attach_next_iommu(struct iommu_attach_list *alist,
+			  struct iommu_attach_elm *pos,
+			  struct iommu_attach_elm *last)
+{
+	struct iommu_attach_elm *next;
+
+	do {
+		next = list_next_or_null_rcu(&alist->all, &pos->all_item,
+					     struct iommu_attach_elm, all_item);
+		if (!next)
+			return NULL;
+		if (!last)
+			return next;
+	} while (pos->iommu_device == next->iommu_device);
+	return next;
+}
+
+/* assumes 0 offset */
+#define iommu_attach_next_iommu(alist, pos, last, member)             \
+	container_of(__iommu_attach_next_iommu(alist, &(pos)->member, \
+					       &(last)->member),      \
+		     typeof(*pos), member)
+
+#define iommu_attach_for_each_iommu(pos, last, alist, member)              \
+	for (({                                                            \
+		     RCU_LOCKDEP_WARN(                                     \
+			     !rcu_read_lock_any_held(),                    \
+			     "RCU-list traversed in non-reader section!"); \
+	     }),                                                           \
+	     pos = list_first_or_null_rcu(&(alist)->all, typeof(*pos),     \
+					  member.all_item),                \
+	     last = NULL;                                                  \
+	     pos; pos = iommu_attach_next_iommu(alist, pos, last, member))
+
+/* Example */
+struct driver_domain {
+	struct iommu_domain domain;
+	struct iommu_attach_list alist;
+};
+
+struct driver_attach_elm {
+	struct iommu_attach_elm aelm;
+	unsigned int cache_tag;
+};
+
+static void example(struct driver_domain *domain)
+{
+	struct driver_attach_elm *elm;
+	struct driver_attach_elm *pos, *last;
+	bool need_atc;
+
+	iommu_attach_init(&domain->alist);
+
+	elm = kzalloc(sizeof(*elm), GFP_KERNEL);
+	iommu_attach_add(&domain->alist, &elm->aelm);
+
+	rcu_read_lock();
+	iommu_attach_for_each_iommu(pos, last, &domain->alist, aelm) {
+		invalidate_iommu(elm);
+		need_atc |= elm->aelm.using_atc;
+	}
+	if (need_atc) {
+		list_for_each_entry_rcu(pos, &domain->alist.all,
+					aelm.all_item) {
+			if (pos->aelm.using_atc)
+				invalidate_atc(elm);
+		}
+	}
+	rcu_read_unlock();
+}

