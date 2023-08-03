Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0C76DDE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHCCQz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCQy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:16:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5019F;
        Wed,  2 Aug 2023 19:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwWnBmVHMuXDtIexwLYH4U3hgaeLx8SsG0DYymjwNX+FC3EpWsci7LIiMo3hdRv9tevZGEdR7hDQ8KU5utHm2qvn9QLA/Fhp4C1gPwHLj+RG5cxYKj5rlVuKiXhKbLNOFhl07veT8Su2g1JBuOdivuUZ342aWCwZO7/JgFPPWBMCE+23SK4AZpanj86uce93wO5A/rdEUWyrLINWbZ997WmRFRnGuWh+jz5joZ0DoPxJH5wJjD22/3cQF0txn4ToOzYlH3hopxGz8kfB2avfGZHFW/7KGH74c5jXZycAiea0mdI6FBxhZldFcvAU61d6CfJvdN/AqUzhzjzj6EPxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3OXPCizP8mz6RonC30oiLzTHHdWDCGp0SlqZkJqKhI=;
 b=MdWnlhrXFE2uW8uQ9ii24CD3ax/DQMddWZ+LZPYf+RoFhqNbuVBT1nCIFq3RLITI+zQsCm+AJrstVSQcKUNqge1o7scb0mDy32FSewG87dw6XsQTg0XghF9T4iM4uBoEQxhwTo5wcKA3GZnWCCpMzIj3Czomt90V7Q0fAFrs9Ls+ftYEL1cl6Ef1NFWCzjudUbHQ/KDAa6ERZBEbn+DjkjEtlFXUmrQlE5twS0WAjNV1ACY6eEfDccvi1Z3issq7a2De7+kg72ryvfqWaC6IWYqNriT1EeN2GGm41vIBG2OKd6jnFgTe993YrYiL126avgUl+ipFF3j5YumypQNWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3OXPCizP8mz6RonC30oiLzTHHdWDCGp0SlqZkJqKhI=;
 b=inAAhB/qtCR/mcWffACU1por/kanIkk/CPimOHhuO85pJssvwYZlKyu2AJBwzLlNNfmjItUNXbWIWqMeDIJZu82oSeKHaW7XRl1jbilOihlbo7lkSWH1cnX4wKUgksldPHewbSeh1OaYcRujOVPzvlRo5BPRV7Cx6/BznHuLPomHM3zw7dvbqbft6bHFdM3B+eyD7mTBM9NtZMQZ9Bc8r29vkGJ/oSpNRUhRlts0NsmkGDScBJ3eSeJ2iT0lyypX9MHZMtzmD0ii7C5TP5QnOtU8SFraiGatdyFDwLrzXQWTkv0YlwpZiQggAvNUm19w116SYJPh7FO8Aft6KRtYVw==
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 3 Aug
 2023 02:16:50 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::31) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 02:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 02:16:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 19:16:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 19:16:37 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 19:16:36 -0700
Date:   Wed, 2 Aug 2023 19:16:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZMsOAv9PjZpLaf4z@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com>
 <ZMQCw2iiIqa4CXNG@nvidia.com>
 <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZMe0zQ/29/gLGBwZ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMe0zQ/29/gLGBwZ@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: b486cdf8-99d9-4a44-27c2-08db93c7b275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3UHHz0POo/VchLzEYmN9c8Ld+ZvaQpPM9GK9lRoqyIsmu5v675PMNIOCn/QL+VHbK010epZa7ApaL60Cg6VKbMOvYHdqHsRlYP9MvlLMA/n8zPbyraSNuMKF8ka70Ys5DKW+zd8s5sACQmI0EBrjCb0NUahSiM6U4VFbbz7cIPxjZ8qNLUFrCR9K2V1KUEUViieNHjJY5P5dYDwu0cK9pJrY9mBqzLn3tsVxQlsfr3GUclKCFHZhxA3IdydlYLswAQQWnIsmXvjB1uzlfllLJMDVKAFyd0tI5yNVdZrs82MSvEkQ4bSELnsfvhDXgQYVdGftUHMcA9gTH/iBHgCFALztNEJPUPe+3fDBoBcINBrnltC+bdCE7u97kDzDCx/GrsByYKP4ZaUPAaH+ds8ArpaQg+qIkuoyQqZz3w6emcKw+xA0x3ZNT/KzCgIVZZITwtUNBiZei8PeVZiSvhRdeBVJ90FIJlR0jVCiWTvfyiH/kmHun8/B5oPj8UYL7bwGcRzuJcNXi1OGPsYg5aKT/bSS+VguYJFg0gCuZfkrr0Keaw8CCygsxZORFd3hgzpj4s+9WTLvQoFzBxn7FZZYlQjuZcJprOsM/Gea5EkBWfbFeieKblV3xVLP4QNODwf7GNZ5WDHgUE4WMdmA8hCM4p0ILi1bj7smdSV+De6V66MgiJVNpCBFTjFkY5WcHEjqRDbq+C3kZUovUpS5WWDU4hxSymBcowDBYAEyV5/Cn0smtXZ65izgcQjFhNMU8mZ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(70206006)(7636003)(40480700001)(83380400001)(426003)(47076005)(36860700001)(356005)(86362001)(41300700001)(82740400003)(7416002)(5660300002)(40460700003)(316002)(6862004)(4326008)(8936002)(8676002)(9686003)(336012)(70586007)(6636002)(186003)(26005)(55016003)(54906003)(478600001)(33716001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:16:50.3916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b486cdf8-99d9-4a44-27c2-08db93c7b275
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 10:19:09AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 10:07:32AM +0000, Liu, Yi L wrote:
> > > > +		goto out_put_hwpt;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Copy the needed fields before reusing the ucmd buffer, this
> > > > +	 * avoids memory allocation in this path.
> > > > +	 */
> > > > +	user_ptr = cmd->data_uptr;
> > > > +	user_data_len = cmd->data_len;
> > > 
> > > Uhh, who checks that klen < the temporary stack struct?
> > 
> > Take vtd as an example. The invalidate structure is struct iommu_hwpt_vtd_s1_invalidate[1].
> > The klen is sizeof(struct iommu_hwpt_vtd_s1_invalidate)[2]. iommu_hwpt_vtd_s1_invalidate
> > is also placed in the temporary stack struct (actually it is a union)[1]. So the klen should
> > be <= temporary stack.
> 
> Ohh, I think I would add a few comments noting that the invalidate
> structs need to be added to that union. Easy to miss.

Added here:

-        * Copy the needed fields before reusing the ucmd buffer, this
-        * avoids memory allocation in this path.
+        * Copy the needed fields before reusing the ucmd buffer, this avoids
+        * memory allocation in this path. Again, user invalidate data struct
+        * must be added to the union ucmd_buffer.

> > It's not so explicit though. Perhaps worth to have a check like below in this patch?
> > 
> > if (unlikely(klen > sizeof(union ucmd_buffer)))
> > 	return -EINVAL;
> 
> Yes, stick this in the domain allocate path with a WARN_ON. The driver
> is broken to allocate a domain with an invalid size.

And here too with a WARN_ON_ONCE.

+       /*
+        * Either the driver is broken by having an invalid size, or the user
+        * invalidate data struct used by the driver is missing in the union.
+        */
+       if (WARN_ON_ONCE(hwpt->domain->ops->cache_invalidate_user &&
+                        (!hwpt->domain->ops->cache_invalidate_user_data_len ||
+                         hwpt->domain->ops->cache_invalidate_user_data_len >
+                         sizeof(union ucmd_buffer)))) {
+               rc = -EINVAL;
+               goto out_abort;
+
+       }

Though I am making this cache_invalidate_user optional here, I
wonder if there actually could be a case that a user-managed
domain doesn't need a cache_invalidate_user op...

Thanks
Nicolin
