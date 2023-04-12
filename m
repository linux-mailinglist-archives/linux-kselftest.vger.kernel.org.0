Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CAF6DF30F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDLLUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDLLUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 07:20:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD24489;
        Wed, 12 Apr 2023 04:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6m3A3RJ4HCuNgaQWvEV1g5PCdjzJ74qL0atqbKEEdIltPtV2X1wrUV4oowCCXEsLhkeIZk7zygvdYxqnnoT3FScxA97pX3V1LMw3CPlvEnPQo34fXGTwSt018RwEw1rhBNUteTCFTz0A0S+8NGBVUYMSdEWQCGhqtdPTyd18mPO5w/L5DzP/+IVml51Ni2S5E8/XzGOdBmMsGG4nGAX5RsMHgqu4Rhx4NIPF+oYBl6K/U7PZ12ixjW3+5U5p7s/QxvKCqTrrrT8JAutgQALdwo3+51QV71u1uj6OETD8pHi9fqk79LvOjRzqVVMTUSQr3DyMyBEGVhaWwgpzvOB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYOYFNihw42yNGM/egOrKbv2w7phDrOesXZSREPpbWo=;
 b=aKmsFGpGJeubbNi9QBpSTo42UeeyNuNGcvXKjjjwx0nRVGqrpbQjIuG7XcpQ1p35jjzR/HqhdrIsZ/of2atgV5vjYKjO4dvli8XifCeGdqHyzwpj9bbQwnicH6sIxzB/xW8PCK+YCo6O0CROnsSC8SeoYPV5kbji4V9xEOz2CDeIruMtUVNjhdEbVZH75piASBO1fp++HXE2QIG/WzpXWj0gWEgGJJELaSwUZxmDzzb+zEPsZeueTGRg6y8xP86VJ8Y303SwCus1vLXjzrRX+zZI+lgI7sxPRiri7dOnyqYjMSi/oj0edXMPF4tCFrO+FfoPtyDuQGzdP3Vkkl+t7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYOYFNihw42yNGM/egOrKbv2w7phDrOesXZSREPpbWo=;
 b=jcC+aJ/0RhXLkqZXzFlRLsym3+41Va0zvG2NfeHgMTFy7rcRAaLm1HTA84JldHAaQxpeNvm9p9DsDgo5G6DqkLKCCFv0hCoSOQclNcjZUrwPGXQH+Rxd3N3aY0EITpEoyzwLN9Xv7zKjls7vyQ1G3vSsTi3Xg5TVWmhsl1mwFdPCpx22rAbG7MkMoSP3d344aPnswkl9vu9bW3v9k6cQJjZTM6dFtNQWhy/32z/wmnc+GyxWvFJ5XvVOSecCuVHoY+5feI9nX9nkzQTvAjb1X8dXvC5aCwB81geH6b5XV0cyPXw1S8caI0a3Wk75vbNLzqp640h3U1lL6hzPdgljxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 11:17:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 11:17:58 +0000
Date:   Wed, 12 Apr 2023 08:17:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZDaTY6OX8oR5w0uV@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDVvLbSN2TR1Er1c@nvidia.com>
 <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c2e1ff-e174-43b0-d9f6-08db3b479233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iy/sMmL4+Jj4xRyZ8zXtVj5OJcfDGo6hnE7tEQWOo5fEV7rsyy7nSKmuyctlQE4EXkPRtXDEpQ60dfJcbVN5btzDh6dnSbjEINl3qyKJ5si9G/xrrabG+uPfqU5jYwSf9lgO59j+Eyya4C7axNmCXF1o81Z2Wt/TUZZfkFUisSfhF8aCjP2Tjs+prVn76YZSEn8ykW4/0QAL55S8bPWRbKdzEakFu8SCBqYZ+EnKEJ33wxJzc6hyMdCQgoLeERpc24Y1Vz0MuKzo76un7Cazg7o7DcwRaP3NPTBNIgfL0vNiI0nLVYRXk99tiBIBVeKNASw0owMD1YVN/NjAJNrJ5LrRQKXjsun7p4SEmkXn3jOJxaicTofcd1n85ihD4UZe7JIY+QBh9l8JtbLaGNiLddQBJhsIL9R3v00HkVGbtWqG/pCCD7Oceg2d317rJcJVKGfUz6y08HqN5IHDHWOYZxz+0fvKWwQHym/UjbQzdXInXtwGfBIrgi6n+uAzZErd2ER+NQCdK9ONpqw8IEvRqUyrL8nHGGOd5OimWUSn3kRPbH5oknSX57Rbyg6PjrklZy45sDZipFvDG/g+66n/xjHItAPoJxbYBMKM6rNphhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(54906003)(2616005)(478600001)(6512007)(966005)(26005)(6506007)(6486002)(6666004)(41300700001)(66556008)(316002)(6916009)(66476007)(4326008)(186003)(83380400001)(66946007)(2906002)(5660300002)(36756003)(86362001)(8676002)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4AQ2ntoe6U4cet/k2vAVKVEGirlCTqvd6jGfbzOOcLIRd1daVeq9/OkrQ8r?=
 =?us-ascii?Q?lBzQlph9x5j3mfCnyEMqzTS4J7BU+nntnImPS28c4lluteZWG2RUpW30Wwk/?=
 =?us-ascii?Q?RGAzzPU3HHzjOW9sdd7nUFBtjA3cAZ8WnLESX2MYtv1L43Gtay/7/dwef6J8?=
 =?us-ascii?Q?8HW/ayFOvscrt1m3qi0JD8sJiYuZXYbhcJ8Og3K8ETT/O/U5FzJSVjherZRB?=
 =?us-ascii?Q?qREEYm3zdwzB36AlSCoDPReUM+KVivQAuxKQvqpzXlTrWap7tvuCVdv7mD0G?=
 =?us-ascii?Q?Zlqnn+Q5oOHmVv/r5A0wBwTXeIBYI/XHllixF7Ti5KAALLkZojiKQ4xbTtjh?=
 =?us-ascii?Q?/LMl6j4+JiR9KarhIYWZZ7iGJgI3vSPP2zdMGyK6+w0hYcz+cc7VMmloxyw+?=
 =?us-ascii?Q?ruMkERXd41nyLqT4PMLIA/b22In4mT8mZMFfcxGmQW9ioLX2jholrpA0a6cR?=
 =?us-ascii?Q?sJPxO8QHoqbn+DqgcUhtq2tcW4vzgm+KtlpYD+un4N3Z9XT9qFGuOnqPCkMC?=
 =?us-ascii?Q?9eBJTX/Q2ZBbM2uO2//9TjryxpeyNx8AJhxzdUgHbXSEalmqgWa385ky93LN?=
 =?us-ascii?Q?Mfj9Xk6hOC7PZL6u7wNwoPkq/hWXUARJ3yr/B0+bvBuGGPBjSmRCp3QJFTb1?=
 =?us-ascii?Q?zIuqil3o/4ozImnA4c2PzlBK0UfXwkpzOKjure8vMmF4VeJgBaPYIi6FfKXG?=
 =?us-ascii?Q?bc10EB7d2IHXP6C3BaauLAAUIYtjdx8xoi4d3ht60t5iRTBsdu2YxTOf6hMq?=
 =?us-ascii?Q?Uonm99SJs2Sz0fvFMfXw0vURnWjy4Sp4UFMqjazx+JqRTKra4O360l8nBxeF?=
 =?us-ascii?Q?dBekO5jDNBFJHzlim+bpOwetpUXpgLM3K37jwqYeRfK8MIskIHbAXcxA1XYc?=
 =?us-ascii?Q?Qzjnci8ynlFDXzMRAszJRBFk01JTBvQ84HOeK0w5fWko1yGLyzgT+/4q3mLJ?=
 =?us-ascii?Q?tKskEQhvdbx+gFVxI/xMMwECwXTykFz1sI2F/msCVWrcyAz6ayfPwgMZPCK8?=
 =?us-ascii?Q?TGvB8PvN7hIy84gcq9tRgIFLgCXQIK+mgQPaiI7XH1PJui5iLLC7UYdLhqEy?=
 =?us-ascii?Q?eAVWwBJ4S36oBx2es8b0TRGQvv61XHjwRjW6yuL16YUkU+O1ppf1VhbKn+vo?=
 =?us-ascii?Q?zXCG/M+uPHolrZiTkv10YQS9PYlIJ0SukMLiGSdJLGfEq6fanb6z/pa9yPyI?=
 =?us-ascii?Q?SB/soEZZuAaCk84YgKcnGOegeHM4OS++oQjmi8Suc7q76oZLq36eupr34ge5?=
 =?us-ascii?Q?3ntEMXB5A6eTHo+OhgVm1pLjblToVQt3nFh31bhzIcIwD13PoVnqiSgtiNQ1?=
 =?us-ascii?Q?OsMZhOpG+xGtJDE9lvBm6QAGpvwZYMAL/6/YLgu7in7ls/YASZMBOYbZv+vD?=
 =?us-ascii?Q?UKputpu3V5M0Kfao56O3UNEny71K14tad8L5ZkXAUTJjU5IJA/2fZtVgMhFr?=
 =?us-ascii?Q?b0zRq7KWA0lZKQL8jli/x1gQ7lIlVZPRjEfcvAh52EfqIWVhtsvtVAavpHUr?=
 =?us-ascii?Q?5AvI8e8/EsdMRw1nADOHxouBniXZEcuWnxNAE89bo+5vwvbxpJJzxeQREU52?=
 =?us-ascii?Q?mYtIuVesLlbS2inMfd0FxSjQFk2F/vPLCZdksvah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c2e1ff-e174-43b0-d9f6-08db3b479233
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 11:17:58.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M7j/j242fMprCue1LbB3aatusdgMgI/7CVfWiZF2AAvybdEVZsSn3lSBoZXBWdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 08:27:36AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, April 11, 2023 10:31 PM
> > 
> > On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:
> > 
> > > If no oversight then we can directly put the lock in
> > > iommufd_hw_pagetable_attach/detach() which can also simplify a bit on
> > > its callers in device.c.
> > 
> > So, I did this, and syzkaller explains why this can't be done:
> > 
> > https://lore.kernel.org/r/0000000000006e66d605f83e09bc@google.com
> > 
> > We can't allow the hwpt to be discovered by a parallel
> > iommufd_hw_pagetable_attach() until it is done being setup, otherwise
> > if we fail to set it up we can't destroy the hwpt.
> > 
> > 	if (immediate_attach) {
> > 		rc = iommufd_hw_pagetable_attach(hwpt, idev);
> > 		if (rc)
> > 			goto out_abort;
> > 	}
> > 
> > 	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> > 	if (rc)
> > 		goto out_detach;
> > 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> > 	return hwpt;
> > 
> > out_detach:
> > 	if (immediate_attach)
> > 		iommufd_hw_pagetable_detach(idev);
> > out_abort:
> > 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
> > 
> > As some other idev could be pointing at it too now.
> 
> How could this happen before this object is finalized? iirc you pointed to
> me this fact in previous discussion.

It only is unavailable through the xarray, but we've added it to at
least one internal list on the group already, it is kind of sketchy to
work like this, it should all be atomic..

Jason
