Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECED6B2BE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCIRVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCIRVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 12:21:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B661312;
        Thu,  9 Mar 2023 09:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deOa48gyN54cotpHu4RmrMDdC0YT1d+w8D2tkGJXqb++mFbRna7aqJFGMU38zjU0XowR/psrS5kS6hIQ7Rxj3uYowGxfM9KZY8eQ1yKMaBmnKsD2b/ejUvFDuBo7rbOOJnkEV+hZDaj4pf0LD+C9yN1p9U/Yf1zf8lhtla9PmUOtDmQDV4mJlcboQj9OPVt4lbYFcDAemG8pz8KXwQ1SanoggNjlHFdI6/XzQujkGb/NChAuDIvTkE6CNq6cEyAig/YJuKZg/+Rvi70YfGBXmr3LXVKqzc1HTOHBPtcY4c8YNZTHITzJ4fGorVp0Y9g+6k0nsCihKuDYoKuv6ReWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2ColwMjueZ+u0KnqnMFLSfhm2F+7iidraEBEVbTypw=;
 b=L7/4jxxxzn863xeVnTtq48kgzKWGmMO63OmJ2DjW0vg9H0dtuOj9Ss8GjCEg8AApNo8OGIuh0Ji8gwtSvwm52a+QVAdNMOg2ja5gFm395xyEUO6hqUwaNT1e5oEBvQ101B3PmnYuXR/eVyDmvQON5mWPzZces1Jy4Rbth2fjbN/C++qe2wfrX0k1ZFt7+3NBrz2BxiiIjTDwAzPt57IFPzKxLCcwCbDscUDlkPN0x5BDAXcRjqdZOi2X1bBzEvHM8031IIkkz5LHuBTIWEyMmjYKfOcl9PmT1gkK11yen01mFwyxKYQiABJJOaNoUq6cR9jHpZSzX6+tPUwniShvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2ColwMjueZ+u0KnqnMFLSfhm2F+7iidraEBEVbTypw=;
 b=cEVx0kUnpa6PHUxikye8ju8uO2xU+ekdi/eL3SPfotyy7Q6WxN2ZwoddlnZakmBkMpcFaiff1zyEHm3wEJVPsz3sEmaX4SCPtFyectO1OVOlVyE33hD4K4gjaKRN3dAhNoqY8aNkNHci+2WF8e5sCSukXigkBIT1A19mXbsCA3KITD7FVFDzdPegDDlMKXLghg9UfstxN6iGy926a0Jw68n7MaRTBO+qnPDl9Cnp4UTiVxqimhs9z/7pVKyHF5ON9ts5ERKXJN6Rq6g6jOpW8MftVkOqAdIo3cLqS/g6uAqMmwBbZGAGYvOS8CszuK/kRUIkBS3a+RmnASfo23+3ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 17:21:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 17:21:01 +0000
Date:   Thu, 9 Mar 2023 13:20:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Message-ID: <ZAoVemZoGpx16P9E@nvidia.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-4-yi.l.liu@intel.com>
 <6c1b221e-df8d-4b82-10e5-aa3027819d45@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1b221e-df8d-4b82-10e5-aa3027819d45@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dbb63c-e221-44e6-94a1-08db20c2a7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT1nl0c+OvHMYgMlqI+4AS39leT1VGIN7iENUds09JmQIqfL6dwmhgqger0+pm1b/9z6/8p5Rery0UIbVb8rU+zvrjQX0S80aYg2yo9sZRobU7KIcdR4TZWHtHknD9EQXwAL8MzP0Ofqm2XhpHLLEGQrJFJ9nWa+Ar318V9CXQfUHEtPpaTN3on04hrAWlH0+eFw7Mts3iM7agyaGD3K33iq+VcogmCPkDIkAOkW+0g5T1G45Ih2Aj/ael8GP8c+TD0Sez4tZsmpJzeHVirIdeq4z/SYy4IUdNgh8egWckIMS0JgLYeLXOIEKhiwHZfOW9BDsLhrQQK43pKDmKm5xrpM0feDBVjN68aWs4sVRBBg1cgr7MNBWChwKV9p5iFHXQbkUEmI+MaDPkaslJtWLI3xM4CnsNEnWSdaN7t5jOeqVyGYBiZmnkAx6PGl0esWk56w+5h0XNa35OBMSOZyyUW4C2aHhSlw5vEJTDrQE3bMIRieue4FZXHgJQSrx44ctmIsKanqk/FmVebWijd21o1bz84VqIaM93vzIja3pKgklDzucyx+NjYGxP1WQyPeDR9EmZpKufti10ysNoN2KIQHU4Rh+spah+S2Mi6IiOs+ni4FuWsF7w7e/fAAH3re1txX0fY4uwlxO8mzxoh7aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199018)(36756003)(6486002)(316002)(6916009)(5660300002)(7416002)(2906002)(8936002)(66476007)(66946007)(8676002)(66556008)(4744005)(41300700001)(4326008)(26005)(86362001)(186003)(6666004)(2616005)(478600001)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?giTJ0eotKAMxQIF7wp1ZUApxmz5yMAew0KcHZTLWr/sIGrAmyUq4Nt7Iep2q?=
 =?us-ascii?Q?VIRb+hvU/kUJ/pyDh+BLX86wLAOo7kc0x+jzQQS/8kgjdOzbm4Uz0aqYYHy9?=
 =?us-ascii?Q?UVAMSOlfQNb/Gqlcgs21oGJvwqDu8FBOim6a+8lA7R1oyQl+zUxNEtfq+wtW?=
 =?us-ascii?Q?g4CucP0l2PmpMXMKBLfEHUmxFDvLtdk2KZwNrsREgb6CVHCctvCO4AnxeJZ5?=
 =?us-ascii?Q?Qfb8892r6oK4gNQgaKpMu5/2Roprouh9Ay8l2nk6EXlYdqzfjNmreNBO2GtN?=
 =?us-ascii?Q?y/R4hu4FnB0AXkQWx/p8GdAbZhcDybTEcYHEBFvD6w+pkddLB0YOGuXgVKlM?=
 =?us-ascii?Q?MY5hQv1qHscNdQJf873X3/ISP9F6PGgu0mOpMGm4Jrgcsoce/P3T+Sauhbcw?=
 =?us-ascii?Q?UIhAPPWefz8ah/LLIfX5IkZzzIyMq+wL+eMyKX3Tolk5QMK8KycyXMFUpkiw?=
 =?us-ascii?Q?l6ogq+Q0VEdkCZ1mQh/KToy/k+ekSS+96v/+fC91eMbFIuY5wsgeXZT9fR3B?=
 =?us-ascii?Q?f17iYH2XoxykM/pYzFg7n/UcCfSpQjAs9TtWEz6LBfpvIN85O7omJODCBzlx?=
 =?us-ascii?Q?u7nCPFtCcHRJccOYRIJIARdftJZKx2sSBqsqYKm2CkfvMEM7qK6nTc+0FsWk?=
 =?us-ascii?Q?mo+93kNk9YXz1XcllsbsMyMvvzef9dim/Dr+2OalNy1ZxeJH/kGw2DK3cWYr?=
 =?us-ascii?Q?CLTzwRQqfX0fllTLwFvVYVL+u6qCW94lTWm44PXwyCyu1raSej1sS9rRaV4S?=
 =?us-ascii?Q?vV94w2Ip2g0oS0rEol+T+phmLLUAqdS3EboLe38zhx7yWXMcuallun7choiE?=
 =?us-ascii?Q?Q3blllUhOfjdyZr7p40oWi5+TJ8JLSeAmliDtAV7Imb38NRfhoj2fbaZW4GB?=
 =?us-ascii?Q?5EMRgXD/JttfQUO2Kp/daLeEucp+/kSyQQXPRWTspz/2aZSgdjG+HQw2nzdG?=
 =?us-ascii?Q?J8F4hh6+q+7+SN7U8L8rfJ9rESXCI1D6TeoL757pMmgnO44D2GAD0Npwgx72?=
 =?us-ascii?Q?IUPJiGXY12uaG2ffoX+lGoVtm+4Vxht4hE0Sm9kkw4J9nUbgFnrIwwtfqhYO?=
 =?us-ascii?Q?ylATfeRAfCyI+etZ89CJz3mwbq3SWt8P5RvON0WQrg3nEtPGMXDN0b131uiH?=
 =?us-ascii?Q?0GGG7N8h5KVAxVvh6QJcgslrw7yobB20ZxcmDXsimNc/VQiSFoAt66RTQVgc?=
 =?us-ascii?Q?BuzKOmyYROdlh3wmZcYqZfUB/y7dPoLrs3RXrfhteIy/Aym+HoU56hiSRy2t?=
 =?us-ascii?Q?HyKcFjmEAJa1qRSo0yKiqb45MNouHE7hxD2KY13XI9Xd9gJM99FfKsPEkz1S?=
 =?us-ascii?Q?NIMK4YiSl2QhxhfS7DAjjIe5gLnI4biwEtc9cJ57WBONC/g+koOrKsemf0Fs?=
 =?us-ascii?Q?QqO40jC/K2r0y5pD5pHZ2udur/nag3wF84E6DKYvU8EeY7RBDoY2UvHQtMvJ?=
 =?us-ascii?Q?OIh07oIpTD1ztND7gWmV9BUw1mZc7C8zLJpOE6gPndKNaFK6j5rnfub3uApi?=
 =?us-ascii?Q?PJrc/cVFz9+dEputYfi7GlyBDsRkdD0Ht8c4PK3h2JWpGKWVGn0xXbnUP615?=
 =?us-ascii?Q?9y0BN2dW35AD8jIlmMwLeLgq4jDlglVRm4Bhb1tG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dbb63c-e221-44e6-94a1-08db20c2a7da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 17:21:01.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv61OLbGV0junHtjKKjf8Px7pNcISTq5M+T33gFlGN+xJHeH+WWst7skgqF3ugmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 09:50:18PM +0800, Baolu Lu wrote:

> > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > +		return -EOPNOTSUPP;
> > +
> > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +
> > +	ops = dev_iommu_ops(idev->dev);
> > +	if (!ops || !ops->hw_info) {
> 
> dev_iommu_ops() will never return a NULL.
> 
> Need below check
> 
> 	dev->iommu && dev->iommu->iommu_dev
> 
> before dev_iommu_ops(). Perhaps something like below?
> 
> 	if (!dev->iommu || !dev->iommu->iommu_dev)
> 		return -EINVAL;

At this point the device has become owned through the ownership API,
it absolutely has to have an iommu and an ops. No need to check
anything.

Jason
