Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540386B0C27
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCHPHB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 10:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjCHPGf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 10:06:35 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12ABBD4E6;
        Wed,  8 Mar 2023 07:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR2dXDnxLP1Vbbw8BAgwEVQynP7FQI1avA3zgDRdVZGUAOEUrhMkeB7P3cwccwZLKhbM3RS1VucQTxk6sNlzewtUM2f5m06ZcoPcl5y+zLhi4qsK35X/JAv/xSfWSqUvfBEuT1E9BBu5tZCMff8+gIeARb/ejWGtsRW8121MlH1zYRxy3Z0P1h3RgNVo2y8aB6zHFWdMvGPnA0XUtzozSqZ10eqkXHcl/pmbnI7Qz7mAZQ+NlbCqly/K9mqdCXHxpP+AwcFLfEnY1ezFBl6UNcqhXa1tXK5MFRTBWql3tAk1xj0hNXt2b6bxaGqptsFA2ByVtsHLkPzqLMvOJGvlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTSO5vISvR0it0QjBnEYJPf6uigalVlxXDvn1bRFhXo=;
 b=ljvPlAbK6L3rBoeCEdOUz7P+Kj9s9RPd2OC3d0LMLboeEQKM7UIEOqJew52J8ZIy9131G2Zml1x+NaDq8u+jB2vpRBGA+H7b1lsYhCVhbnhkQMJ4G5P5IClKfjI/BSBxf9w5ILOPp81BtbIhyFcBcHZdjLqRz7yp3yhYFUAdiUcYE4AZnGBUAcpaUpTzVng1QDIt1WU92PEKpyHkS6dEwAB2bC4ETj5fjoPrcOFljQ8uE3ALUUIzRkWFbg220fJKYDf+GgZU4RKZ35uIzvIbvUzjbhxKPtIMZA2A4ghBbgS3wWQZzZ7WKURaiKaWN2+qDh9pHDGyLYo2Dsv7zEFcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTSO5vISvR0it0QjBnEYJPf6uigalVlxXDvn1bRFhXo=;
 b=g8n1UN3R3cALVUhFC5u9lbUi1f+4ia8Lq11fR9CcNuMggU/UEnRV414Fz79lE3dQW7XutI1U5MCZj6OVCivM/rVRvuD02PW0dwoCjkujHVMxDAk4tSIAMWLl9+5zC9wKhnSk6XPpB1cCrgWqYviSd8VsoxHh65QWSQjApmextymAcAPyXg4NQpH+p4R4CAQqD1iQGQSny+eM9rDzxJ7zBsO6WRV7lEjwb38Bfr0vogJTcXv6yDwkfY0SJuVpVa/iguaKP1Kn6i8BZoz7PyYRiLHMktcZj4KWU4sn3FwZnWqE0gN4ZhZj/8/5AYFNroVpZj1jfIShmWRZxGVv5LGNhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 15:06:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 15:06:31 +0000
Date:   Wed, 8 Mar 2023 11:06:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 09/17] iommufd: Add enforced_cache_coherency to
 iommufd_hw_pagetable_alloc()
Message-ID: <ZAikdKoQkSfqxMxc@nvidia.com>
References: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <07b337da-e215-434b-b84f-8fadd07e3020@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b337da-e215-434b-b84f-8fadd07e3020@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffd74f8-15be-496b-3e74-08db1fe6b356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 303V9ZP0/p4nP/Owxc2Y4VZCJiYycL/rPZZsg3tBfaiuhRns67K34XAyLktUy+om2JSVBHrnPe8Vi/ztoa767hprb/7+FFL0TEFIvT2twlibTNq6YrZg6T8gx4+QRHbBn0d3ngtbLhbHArtnauJ5UXlPFalOozES+Irzhs4l3qep+NPs5R7+0SuXpXID24nSsPY2dbLYpvIfdjxJ2cRF01N6vLnwNb4tv1G3X+iWccboquY+aFWj7iCi9oXqVuTvlToVqHtsLVJ6JODWL/jWqp4t/gGBmX7gdo6wfy/yYS1xaZPQMVBFYxjHvd6vgwaRwmqvZl9Ro+8bx+gTGMawxEoGAr46wgpddsFfrkN5IKK5GyIBWsiCBEM3vGrk9QkTsThQMPwnxLo4KGkFyLa27nQ+Z4Q/XUOglu7UJAterjc6LWRTD5sFmxcNUVQ5wNe4nz5Gj/+muujp71Yd1dP4/pAgmgOCFgM9/5qKccCgKg+pW/Y5FZ6i3DmcRHSjYxNSC+QRdMuyp6P9FKZ/9vrTeLG0C3fmFCdETP3I7nvZR546NDaLF2rT16q6ZYj2BHaihWqoOidHsD9IluHQkCaJLGx4W8YMjhi6BhJ77ZZWEKuELd1sSxjIlAcdpJswgsuEh4/AsorXzHxTGRznsT1YPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(36756003)(54906003)(6486002)(8936002)(316002)(5660300002)(66946007)(2906002)(4744005)(66556008)(66476007)(8676002)(6916009)(4326008)(6666004)(41300700001)(478600001)(6506007)(26005)(38100700002)(86362001)(186003)(2616005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fz7eszz0sjyjWDaoz7BDl5jYw9caiv7OXYreRcveaO1UvhiPBd/YwXcgqBfF?=
 =?us-ascii?Q?dAYwWufTRGHee0iw8UTEHN4NdEA5b8zkKWsrCtMjUOKDolxiqPuF/g6cGc4z?=
 =?us-ascii?Q?lcu56Lwa/iAt8LodrRdrBZ/qG2GsDPDW0xy9iXodOiKpzAf0T+Ku7W8MykZ+?=
 =?us-ascii?Q?O2xLPnrq+SUvppOX21eu0zIrAeVllh3f5I1a2R3YmzAEfy6aZ7dEYfd7ENMc?=
 =?us-ascii?Q?qIgqhHgxhLe3ZJPYDiYNIwXIf+DLakXtP/yKwWKg6t7MgBfUY0HKw1cemN2Z?=
 =?us-ascii?Q?5gDmYSJ5ffC3ObJwtsRyHQGvohHOFpUU3AVz0qN9UvK4QOzd+4nu2HiYa6zq?=
 =?us-ascii?Q?jqJef9kzCS0vYJtpnysAgZztSwrZ88ibXIbVU8T0qsJM3QxmfHfwEmX6wq0r?=
 =?us-ascii?Q?/Qn7hMF3audzEm2ZZY8erO4zWc87euJHHnDBoBR7RWnHRX07Ic2dVsxa1W92?=
 =?us-ascii?Q?jPHgt6YPjgskRe8KQ5w3J/3HPpewCETgdgkTRaS62d0FqU6whOboUILEsS1D?=
 =?us-ascii?Q?zTojzwSNFa/4t0gXLgx4ouiimikAQM8dWX+fdXFrl3vEbqemGDx0pdawGVpK?=
 =?us-ascii?Q?poCxra+mpDlO1chPj8B7RWjMoKTqZpmyP9wNKbudQBCsVabgBuy+ZWjY+NKk?=
 =?us-ascii?Q?XQC3RtCZR4v+Eo/o9N/hf4214tn2CkvuZsprHNFuE3J1tHGCrOyDBgb+8qHV?=
 =?us-ascii?Q?0vyqzCxzSXFtnFYjv19WEJKGX8xJMxe6/yk0Hw3hMo7Zb576O4o7JjadBNNH?=
 =?us-ascii?Q?8nVGG9UYLbPZtTPngfbnh6IlZtGIZqI+ZeUnDHJpWRbiUDXVVB/j7h0pTHye?=
 =?us-ascii?Q?PtBMV/39/PtC97NyAAFuUrp5WdnX2OmJ3AeITtIy7R0iSMT92OJMz3iMyg+2?=
 =?us-ascii?Q?xw3bJVn7O3rODyUwXo6kgHOyckPOgfDWYK5fx+ZKLsyXJmgP3rO+hTU48JjO?=
 =?us-ascii?Q?RqHJp3zelke16aUSn5GErGlbBNoX83yYznd61649SEOydx6EIZPIROLDEcfP?=
 =?us-ascii?Q?1hzH2Vl+KdALseyND5lDbgzxVpIYsY2PNYv9tJ8GrZeiimO5hxb/4Fk+rbxK?=
 =?us-ascii?Q?uc81dFnAHivs7ThXoCrYknpzrbCgbnjLZttjscZdioH81NmpBYp0Lpcc/ie/?=
 =?us-ascii?Q?Pur/WToq/1QHV2AJZXjgJqTk8Elql7815oHOP4Zx5M+7w+oI1Zy/VnAMyn46?=
 =?us-ascii?Q?cihVXN/oOvNvmBddSY906jXt/E/g2IKVEKFb8d7HUhBbhn02x0usffLH+YbU?=
 =?us-ascii?Q?g9tHsJlXV87w7Mwy+OsACn9VL1etZv6jEKwI0ki4X2/eoHXVPe55l/sA6F7n?=
 =?us-ascii?Q?xsMTDdwkVV+n9EZE71WD4TcKtP/ls8cjFj/KMnb4gnI4htU27ehWApbVdLdy?=
 =?us-ascii?Q?qY6JdzRUOutvvK2DodbMQpXJkKttQQbFHeYNCHClL+6YzBIvR2hAcvyGvrj9?=
 =?us-ascii?Q?IAYhujHyZWv3iuZNZxI0IXKTvFhU8ue5vlX4V0E41BV76iLqgimZP6Eo7nqS?=
 =?us-ascii?Q?Kxv+Cuq6anPsDyl3eT9vU4jHddMW/OSZ8g+fVAQhA4bw3hXkK/0vdeUOLWxN?=
 =?us-ascii?Q?caya0Sbc4Q4sH+CShVRxiBLWpytXxY3Y8Kid1SBZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd74f8-15be-496b-3e74-08db1fe6b356
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:06:31.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OY0ylvH+YUNkzYpzy5cyrTXLn5+NHQGErnvAG+yW6du9Kko+BbLJe+Xyu1hH2y65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 09:04:47PM +0800, Baolu Lu wrote:
> > +	/* Try to upgrade the domain we have */
> > +	if (idev->enforce_cache_coherency) {
> > +		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> > +		if (rc)
> > +			return rc;
> 
> As "HWPT should have the coherency set properly for the device that it
> is being created for when it is created", is it an incompatible case if
> 
> 	idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency
> 
> ?
> 
> If so, why not,
> 
> 	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency)
> 		return -EINVAL;

In principle you can create a HWPT for device A and then later attach
it to device B

If B requires coherency then we try to upgrade the existing domain.

This is an effort to try an minimize the number of domains that we
need to have for simpe IOAS based cases where we don't want to spawn
two auto domains

Jason
