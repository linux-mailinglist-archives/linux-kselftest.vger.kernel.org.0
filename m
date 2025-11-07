Return-Path: <linux-kselftest+bounces-45134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77696C40F22
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E306B189861E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5743337B9D;
	Fri,  7 Nov 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RBmIzOPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2E336EF9;
	Fri,  7 Nov 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534198; cv=fail; b=UJ6GMoH/OxqTJ5lMCBrHHBvkjc5J+3HQjyHKFJlEzAkpQiaFiQ5H/Fu+sxRRK3CVca/mpcRSEippCQt4t/wrdXgXvPb74xinJTT19NrwDoANCzgWZpd6+GnjdC6F1Ebt3yvSL85nJAaxxwmlhqTPRPP8wv9wM1KwOmI/1gmhGwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534198; c=relaxed/simple;
	bh=vsrZFLXGMsRvDJv2zAycPL5qtmJq6uMWL8PVjSECN4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2rHfcv/mHU2lT84PoHKeMpGB8I8jJZMwskMNv7f6yJeKl0bAAnCvSF8wumQJgFiBWKwah4mMFffwINl4B4LCPUxUGx7WnahAOBldmkU+aAxqSVl8LrVu/aF3otcVlKJOz0m515chvFSNSq64TO1XoP2Ozys9fJzABaAXaB8lQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RBmIzOPF; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqXFWmwKJQw7bcWHQMqqOW07FzA6/v+sbx1TLnREBLOIO4Ci0xtqv5DOoGdqgO68IMKhZrnwVTHDKjfLMgkeh2A/BGEO3i2ge2IxIAjGRKskZFGM7CyY0kF9ALQj3SMtpFDqW36qvga6P9O7oS89upK9oSn9LhCXIlt0YzVVeKPXFI3++04GKqsMYef2/y0EBI7hddOKN9opnewfc0TziRm48LcjyYcvoeGmaYSVBXAs3g1Fj6KWdRlA/AaDGpnGjjiRPtqs8wpIUQssl8wJfPzZWSQwA0ECFmQbq9jTgZi9ufeh9WuMgzE9K0tf4qEgiwVH+E1igIm6GsGntEVnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Df9m6Q/GPpg4dpwQQEQDNvNlnJB3Xhl8MD5mFvYWlY=;
 b=SRN+9otaso3yWd88stSizZ5gvX48pQYhT9+M9Tl2Kk9CkVyX5iTfFSyWWfr1imRnSclZSdu7Lc2bfO40rBsOP7PTz5E4HQvxWNzXn2uDCM6wJzF+nXZYeuyrGtyPZ2d9qP7tHygfUTlNFbr5yxidAusTOL8tRg7BA87+TxgZo9QOP6TtE1/JuG2BIXDEg0YWTTXqXl7xinx1sezOq57c+5zBfxi0rJjqUblFObpzFeF/9QYNnrRGCmsPXX3bW/PJtoG4crUwX0jItmzcEh5cxPq2U4x2Y5emo263jLbKENYUu4Cv3bliub5i34jsYqobCuaFYHVuM0chxw2/fhvT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Df9m6Q/GPpg4dpwQQEQDNvNlnJB3Xhl8MD5mFvYWlY=;
 b=RBmIzOPFLbxHohky1WEOnsrvLTyBSdMnpGyQ7sncdV6n4lpGViaYT1s6RzSnsr2DiTxc7/cRcVVhDy6URoGMzP/2DSVt/P1rhZM632IikJhI43Vqvtbd0lcvK58+NGH2XC/QRLWYkRSQi0WBjjQeYeYiP8f8VSoC27J0zEgmCaRl/wurlVu9RVwc5Qk2e04QV5W0iIStnw+tTueJU7QJk9bwhDsDG96gdVnRJhfvYKOUUgnzveaODneXrteLSkuZqlQs+6Z0GbNYW2FEjYRQZa7ynh8P0jmQdMv4QjfWNc+4DQFEsG7QvBh6ZzNP3WCNRPdqL5sO98RMZahyhNv8pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 7/9] iommufd: Have iopt_map_file_pages convert the fd to a file
Date: Fri,  7 Nov 2025 12:49:39 -0400
Message-ID: <7-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0709.namprd03.prod.outlook.com
 (2603:10b6:408:ef::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 1084b1a6-4248-47a7-b970-08de1e1da74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1AWLtjrikxP3IAKKjTRNjTRZKRhJkBeqwG0aTVbakcWzFj5v73qFe+BxWFJ?=
 =?us-ascii?Q?8PwmPhI3wRvGy3+FN5lvlAxkrQQ1ka3UklmT/u7+EPHvIgGiD4JRVVF1797g?=
 =?us-ascii?Q?i9hEpAMym1c7eOqDNB8LjNfpbf0XQ0FP/vHMQXJ8RYkVsQYKc4gtJd+pJSqq?=
 =?us-ascii?Q?iKmHU80JU0AV/mYjdDDFWphHuSmtMURvJkNSQEkHYtj2Gkt0VaDXEQ2LPsdK?=
 =?us-ascii?Q?sXAmjWZ2kvJoW6YP6knaaagM94KtWCYUeVi/nVqSkXFv93VZMhqntLV41j/I?=
 =?us-ascii?Q?7QmdBKghXUkmy1oMQ/SO1PKmpU6BaKepdZN/MBY15BPVOdnZ1/1LJnIjBL29?=
 =?us-ascii?Q?jjSfR53Rf96wg1/XLjB51tL8Uf1J3aaAivoY43zjTwlQzxPq2XYSuFxJbF9V?=
 =?us-ascii?Q?4Mciufwr/ZlRfNLpXi3J6EUrSFwkUgUaZe7enU9j8Vgkr/kegBR7rP96VOQH?=
 =?us-ascii?Q?dC3dx/YYBYl4jnXfqHR5lOCwJ/9Iez3cBUDrbPYyBg/2iDc45AG+Bb3jj7vR?=
 =?us-ascii?Q?EdfyCcYGBtK4jw4VHBxrt1H7UxB3y1qDiuW0qBC9t7Age3MK1DRiaWs6j2He?=
 =?us-ascii?Q?nF7nJIgP8lN3u35NbFwx52xeeenWYguE1s6JgmI57coXVX1sKDHkgARi7jZ8?=
 =?us-ascii?Q?/FV72LD72E+p5qwfb9RLzPx6DfA4WmXorBt+k+VraqTx9Dq+VYAMbbFxwiwf?=
 =?us-ascii?Q?mXnag7mm1KJpv9GFF+7Ub2QLJ4OmSwcTPcLMWDZVPH2Q1WuKrVpQ5xgW5eMP?=
 =?us-ascii?Q?tSKCqxIQJA0KTKmvGbF67lLgvDZMSpd3KBy3wJp9EeAEBO82+/0DBUCfS7H8?=
 =?us-ascii?Q?WRqNlHduc33JZ6Rxhr6r75UnaQbTZYbw3J1ukq2YPnTrnS45nxJYeZYy0Os/?=
 =?us-ascii?Q?/pPL+Hq/bosI9T5Nrnwm9q5/S7v4K3yMRCYeStR558IsYbwEikex/SWut1Qh?=
 =?us-ascii?Q?NzzcrSpB5pa029O84YeE1uHQwn48UabmsZAEB5d8VBx3lEaMYDeSY3KebXER?=
 =?us-ascii?Q?oPouo4Cp9WcIfTciRT4d+sAAfQT9+3kFsvNJZqlJZT264J1Cwrme9JKYWKOo?=
 =?us-ascii?Q?yivxVd3KCQBix5Ad75OHnedVRsqxAgS6FknvodIXWF0SdjG5bTYT1cxgIRPK?=
 =?us-ascii?Q?JT1W6yNz6zf/xuZ/E/ogS0LFlrxVB+Wa1yxVx2rh764H4w8fXheUpsvQqT7D?=
 =?us-ascii?Q?PR0VC3E9/cvI8FhWuUHcFfcSlDpXyM9/7WTATNM+1iBaWtENIvE7pUgxVBBu?=
 =?us-ascii?Q?vZDYZTs400jOWq2RWuKWYmeNoMbLcXnDpzOyntqUOnl6NVU0RAMlgappgvL1?=
 =?us-ascii?Q?SFFiZWqT8Doj8VyZJV5fCTSSHvCI2w8kZZWsvEmLN6NnJ+uwcbmRyLWuctCf?=
 =?us-ascii?Q?BhcXKaw0cryl/vpcfLQY2LwPo/uW085jZYwumXzXkHZe/zOpLnqmi2bg8xQR?=
 =?us-ascii?Q?BE2voiwfelSDiqgaMqoSavd8jcho9sdglwZX6j05woH+FCnIDx8aKeoXcRIQ?=
 =?us-ascii?Q?Ocbeozg3WJm1/6EVP/A09W1aKdfXY0NdeQ4W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQzuGmVqgeG11H5RMFfSKpbi+WiuoTpVotGlZwVI+z2dQ2xipi3OtFdhbCMb?=
 =?us-ascii?Q?T0C/1NO0+ZDiyt9TqnakpzEB2XHVe5b4bmwRvq5R/O42kApHwtS9QnwCqipz?=
 =?us-ascii?Q?EVGrm+gLNq/8utzq8DYi7FPy9r+8HrkclKs4Do5+MgSTld0DaQOTcLy2G7Xp?=
 =?us-ascii?Q?IKSLpRL45DHGNF5SUT+D1ZdyrsU3eURXVeiGybGexq+WDk7DXyFER5MbWw6H?=
 =?us-ascii?Q?eXosRCZuE168Hdgjh4MSnjLQ28NAxwdpky267/7eP8NPAwKTIOaHqpdQqyTo?=
 =?us-ascii?Q?qq5DzINOAckU9hlLWVtMrEB3bVUaOmVxxMrqaMRCLSwEHatU03KLKp75l4oF?=
 =?us-ascii?Q?HpMHFFfRuJ4XnmQxqa+kNo+AFZQOhO3m5aL/jNTIsYerP9lqLgCmZgNG8jmd?=
 =?us-ascii?Q?oibc9XaTfTmhTcPAnRbsqHb1V8uAxVtYLQ4wNdruGk1yaS5fGxpQflfElp2q?=
 =?us-ascii?Q?bqQRjcO+xNZgmtlTbcS/g9JzkfNVc/FnJckss9pyX+nlLApu8yDT/ZRgfR5O?=
 =?us-ascii?Q?l/zAuFI1pVcaXzsMoKOXmUGcpuypZkAKkwcLwEMxTV1MrA/Lq6G9fsfDlpGF?=
 =?us-ascii?Q?einrdthKBcUb0Mv9u0g9teCFsgtiF8iMZ6pqwQNwRKdaqJPpLS+kKyU6Z7aF?=
 =?us-ascii?Q?4aJMGvRGcqjYVJVWc0ah7AVsMggYjkibQpH7G0mrtkCjLa3JEucGnk/wcd/E?=
 =?us-ascii?Q?2NVplGG2vRvHW/rt009G43Vy0P4eX+A4iy3cpcVSASW9jc16kaS/VmrFiYHh?=
 =?us-ascii?Q?OoifAtX0LqK9Di52NIrit57PSI7DlZIzwhr/Vz6iu5pXaRn3OIRZaGbQlhmm?=
 =?us-ascii?Q?WuzJimxgmGZ70hnqm/NQT8Kl/Mi/fBqHSoxh6cnAVc1QzCh26Lk9/1QEiJft?=
 =?us-ascii?Q?xG7AdN47zbTwNm0f7FKz2HT/DaoLcEPnMgWuSaUfcUrdRQaMvPRSEDIQZa0N?=
 =?us-ascii?Q?ebZnJNGV/un2H8kTjkoCr0tckCqOGnfsuDsnwRBAHTjcVbjOt76c82K+JdyO?=
 =?us-ascii?Q?fwTCcWFLXmxGZPc/S01vPBtzRx6IyaAEtEzETGpNWD0xRGrGnVSi+aUN0U1w?=
 =?us-ascii?Q?kAInUu082s8zOtQiNbteDTCV+6aJTXLjPZmtjmN9Py5JyphMPnTv7OkY0dkx?=
 =?us-ascii?Q?1DEO3FATjvT3D0Ks3fPz0fc8EdxzG4Uo7gc9ErmbJJ98aFYxBJTjiA/7Ycnd?=
 =?us-ascii?Q?/2eDLnHIqTgwuAgbCIxqxyI75oZpnDAZKk6b1RLrQ68ndYu6Bcv2pq6g/z0v?=
 =?us-ascii?Q?63+3eNeLCg9q3W6usbCUxA4IXrp9QZQ+3Fl80Xv0i7la9lqEsg/cnLElW7iI?=
 =?us-ascii?Q?inc8COkc4rV0kBaXrF1/YwHUlc7XOBuKGLO6uG1hg23aQyiVoZAtKZ7UMIDj?=
 =?us-ascii?Q?K6XwFl56KHJvlNk1qHsBONUa3H5nqMEkqsWvGbzHeCrDUTVNuxyr1JlXAm9f?=
 =?us-ascii?Q?0VIM9OX6qTA3XSmsiDurIG5wwG68mGvuSAfRZ8CyRtPNL5ykQ0UkJeaGk8Wu?=
 =?us-ascii?Q?nxzsTw9MptFtTuS4BKhm/BYlt2voi0LI2TnbgbO8duwNGwN0DDKYgMg/8Iuy?=
 =?us-ascii?Q?bGl5x6KMRpExt4A/Wec=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1084b1a6-4248-47a7-b970-08de1e1da74b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:44.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqiwLEct8oiiV7lSP1SYLMqDAxDwF5YXDpTo3S7TYnFXTaqPfdjqEsjuAXZgJ8uS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Since dmabuf only has APIs that work on a int fd and not a struct file *,
pass the fd deeper into the call chain so we can use the dmabuf APIs as
is.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 15 +++++++++++----
 drivers/iommu/iommufd/ioas.c            |  8 +-------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index a120c2ae942a8b..0bf6ca77888c0f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -10,6 +10,7 @@
  */
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/lockdep.h>
@@ -471,21 +472,27 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
  * @iopt: io_pagetable to act on
  * @iova: If IOPT_ALLOC_IOVA is set this is unused on input and contains
  *        the chosen iova on output. Otherwise is the iova to map to on input
- * @file: file to map
+ * @fd: fdno of a file to map
  * @start: map file starting at this byte offset
  * @length: Number of bytes to map
  * @iommu_prot: Combination of IOMMU_READ/WRITE/etc bits for the mapping
  * @flags: IOPT_ALLOC_IOVA or zero
  */
 int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
-			unsigned long *iova, struct file *file,
-			unsigned long start, unsigned long length,
-			int iommu_prot, unsigned int flags)
+			unsigned long *iova, int fd, unsigned long start,
+			unsigned long length, int iommu_prot,
+			unsigned int flags)
 {
 	struct iopt_pages *pages;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
 
 	pages = iopt_alloc_file_pages(file, start, length,
 				      iommu_prot & IOMMU_WRITE);
+	fput(file);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 	return iopt_map_common(ictx, iopt, pages, iova, length,
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a85c..0dee38d7252df4 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -207,7 +207,6 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	unsigned long iova = cmd->iova;
 	struct iommufd_ioas *ioas;
 	unsigned int flags = 0;
-	struct file *file;
 	int rc;
 
 	if (cmd->flags &
@@ -229,11 +228,7 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
 		flags = IOPT_ALLOC_IOVA;
 
-	file = fget(cmd->fd);
-	if (!file)
-		return -EBADF;
-
-	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, file,
+	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, cmd->fd,
 				 cmd->start, cmd->length,
 				 conv_iommu_prot(cmd->flags), flags);
 	if (rc)
@@ -243,7 +238,6 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 out_put:
 	iommufd_put_object(ucmd->ictx, &ioas->obj);
-	fput(file);
 	return rc;
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 10ee3510312132..a2786fee7603f5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -108,7 +108,7 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned long length, int iommu_prot,
 			unsigned int flags);
 int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
-			unsigned long *iova, struct file *file,
+			unsigned long *iova, int fd,
 			unsigned long start, unsigned long length,
 			int iommu_prot, unsigned int flags);
 int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
-- 
2.43.0


