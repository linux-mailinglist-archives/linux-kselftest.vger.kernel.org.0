Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BE70ED00
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEXFXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEXFXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:23:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641E189;
        Tue, 23 May 2023 22:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4jtPyhfO5rNs5meBJTY8pIfU3o3TL1X5c2e3mdgsB1lnaOWmc2zdTX3fe9DbYWeJOfA4egRlsRnv18AOWYcamVsQ4Z0AF4Ysw73nfFdiSi5pEMksdYcrt2Wna8YIi9lBHdLFToR0abRo8qP+o0S2r8f2oHQxi+XWDQZDHVKaz7X+HsvLMMgi0uyFZ0wSVf/4HEsm90bEBZ70M5LBlZxrppJfyHbb5JgFDNnaxjBVoqyhXFL2dmwuAJNGGCFvx+8nQUyJ41Bx14pXKkNbuiADm//4t4/YOzwdvFInXmcrEsSB+HFA7r3KZrmLzhypo7RQOlBbXDz7yL1rq9QOctx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcBOniU5Llm5AaeNuxmK12/Gegc6EKgCJq2vRn1E/zM=;
 b=EGrExBH4dHNiU3e2xjTzX9odHI+P1U/3VGi2BrGx7v3RcfHkH+JoDOxu8+avNqri+4sMZ5U9Te3OY3I3fxbdBud1YMFzKKRkjs3vdSD+6g9FKaBOM8yPykLor6xI9sXFufbhg4qW2mWoOZU7BPb1e7khCZgwCovqdOOhzHs5yYgBnl6+ENt46gwwnpP+1E+4Mno0mTQJ4n9IR2rS6S5B1wvlLqznRYEn7YEYkLA6X5M8rocDK8mTgPmLWLK9H+1v+i+1wnlCvjNbj2ppUaebMXSs+eVC1Gj3l9aPlunm7mqRaGcJTmOh4HF08Lo2phE9VE7OyXrtUC9A4rSUDKcgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcBOniU5Llm5AaeNuxmK12/Gegc6EKgCJq2vRn1E/zM=;
 b=bIcLziDIyrFGZEtPyMnYY8UD2wVylZN7/lPXgWrSPISVCiLhiB8jVrtE7gDzh3ggMcWFPybJDv3NUXCAns0NWpRC8FhcHCBIH3Z2jTZftB/nNuA49OFuMiC4ZChdpsrmYIg4R0OzCWkEJBxRBcgQRJRizaoJkXGKdUzsrX7d6pRVlTFRPxrejbIHyNWJSbmSm0HyPM+N5yTojVcIn+ZXvJr8r6EcR4VKj1o8Xt6tCPVlQZC/bcxx8eDkGJHzdPs8MSAlUVuYIHxl5ylcXZj9OQh96U0je4pQU7mSgN55UY6OzJbVmhRrdwFvIOUhHr+8lkRlFSIQn0T4pRYkEWe8gg==
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 05:23:48 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::37) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Wed, 24 May 2023 05:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 05:23:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 22:23:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 22:23:36 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 22:23:35 -0700
Date:   Tue, 23 May 2023 22:23:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: Re: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZG2fVj41GgosR1dk@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
 <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 679d9960-1646-4bf6-9f42-08db5c170d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLe2/XlUwZ6xFMQkksFD7sCEdIvqMWdyLGHQJ3ruFIGg2u/l8AVgGnH+NAQOlj1Ti//B5j35yqii16LjoIX8+O6ntpo9mbV2hEc4QdDUJVgKRUqFG8dbQhXIvawSgU4LxstlGZgBiJpVK0IIh3arN4hrwtu2TVh8fnQvWfUuaCbkmWNzAaQV8Eh2pAmBWlnOqraK7te0pY3jjfITZK8v7X4odAlPK2sfBb8gEY7HdPSxoWD4dpxR0X5qzaL/swOHk9okDHQg9vzk1wQVp4o4fRJQNawqJPwO8JMptFofQasUYDgIt4WqhVdCDmtrVJuCtvY9xgj17PkW+IwU3ZpQsLPPqJcTPCEJtBGjp/osJvpP3/cp7G5eq2h9RwSz/Tj/4nkMq2VkE3cBNeNuRpAtLmwqojlY2oHqutkzB2uFMb/VcaO3CgtmVJVlbMKwnyqFBtp9DcuHercweGWTvzLsXeR1ntqSENIGr2oAi0vPJgxpdEh5M8VT78gAI7ji7jvt1QwwADvSmx8UOU5tXDu/IfxilB/Lq24DN3HbENQ5vj+g0QWCCvEORbjJ1QGTkP7XQZl4av1zo+wS/1zxJ+7Df1IEmD7cFlfwd2DdU8vh/RrXJ8noPwOESMTd7mqN0ZLrlmbkXjavjKzAW2z/BD5dVCoTpT++G/7tqyEF6M16lV2nv56/5bh4b1MexJQBPo8C1lAohzUMatUNlSWi7JTK20yk9kMP568M90O5seW93b84OLHRaQNHYQIAs0hGetFW
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(83380400001)(47076005)(336012)(426003)(36860700001)(40480700001)(86362001)(55016003)(7636003)(356005)(82740400003)(26005)(9686003)(186003)(41300700001)(8936002)(316002)(82310400005)(33716001)(7416002)(8676002)(5660300002)(2906002)(54906003)(70206006)(70586007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:23:48.0367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679d9960-1646-4bf6-9f42-08db5c170d69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 05:02:19AM +0000, Tian, Kevin wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, May 20, 2023 2:45 AM
> >
> > On Fri, May 19, 2023 at 08:47:45AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Thursday, May 11, 2023 10:39 PM
> > > > @@ -229,6 +238,15 @@ struct iommu_iotlb_gather {
> > > >   *           after use. Return the data buffer if success, or ERR_PTR on
> > > >   *           failure.
> > > >   * @domain_alloc: allocate iommu domain
> > > > + * @domain_alloc_user: allocate user iommu domain
> > > > + * @domain_alloc_user_data_len: return the required length of the user
> > > > data
> > > > + *                              to allocate a specific type user iommu domain.
> > > > + *                              @hwpt_type is defined as enum iommu_hwpt_type
> > > > + *                              in include/uapi/linux/iommufd.h. The returned
> > > > + *                              length is the corresponding sizeof driver data
> > > > + *                              structures in include/uapi/linux/iommufd.h.
> > > > + *                              -EOPNOTSUPP would be returned if the input
> > > > + *                              @hwpt_type is not supported by the driver.
> > >
> > > Can this be merged with earlier @hw_info callback? That will already
> > > report a list of supported hwpt types. is there a problem to further
> > > describe the data length for each type in that interface?
> >
> > Yi and I had a last minute talk before he sent this version
> > actually... This version of hw_info no longer reports a list
> > of supported hwpt types. We previously did that in a bitmap,
> > but we found that a bitmap will not be sufficient eventually
> > if there are more than 64 hwpt_types.
> >
> > And this domain_alloc_user_data_len might not be necessary,
> > because in this version the IOMMUFD core doesn't really care
> > about the actual data_len since it copies the data into the
> > ucmd_buffer, i.e. we would probably only need a bool op like
> > "hwpt_type_is_supported".
> >
> 
> Or just pass to the @domain_alloc_user ops which should fail
> if the type is not supported?

The domain_alloc_user returns NULL, which then would be turned
into an ENOMEM error code. It might be confusing from the user
space perspective. Having an op at least allows the user space
to realize that something is wrong with the input structure?

Thanks
Nic
