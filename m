Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154317812DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352400AbjHRS01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 14:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379479AbjHRS0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 14:26:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D930E6;
        Fri, 18 Aug 2023 11:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh3sCToGqRWvMsXxebzs7IkYSXU8lTDBdcsDsRqiXn0y4puVqVIvfnp64AkTFZbE0bqa7r459A59twgDbpG37H7ISNBm0NJLkQoer4JzsFL5X+O6wGcfjDI1JClKJU2aFroOTyfAvapNWoq3OuYgmY2Dx0kPPplveBqXx+maJz5QAf2L1WlSLgqpniZ27F2uMOqdc+1ZelNXXC0EdSuNRkDFR4dvD60gUV1TG7z8+kn3EMTJsHAzPLdgEDDmKsWJBcqwBLNu7YH4/HIyYMb/BlgzMFZktLlsDKeNCewbzcmB4aBuuPNNrfA5+YJxbr/uhgWi9CumEuOZ/fCXKEzIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX3wc+WFwWbFGcxhW4+aWoJPJma26gO3eOloFJQuV9U=;
 b=G+D34DXOZt1FCNjEiry22MNPG7C2YRfNPJl/KcW7nnjUrlhh1ukKr37YBUU3ZZhwSE21B2fJPkP5j5zSkZriV9OEarc8pwOARfsMpQ9ok+f6CC24WWarABGDTqOVuvXKDS0Pa13ZCgQ8Ua3cB8kfPzr013cHfuq4BiRIH3hsuAr4J62XS9sUX1/tuPqB43pFaPade2jNFjWFSP21uK0rugq/U9uO+Et7uDvKmYxulav+RjK4+amux3/2YfvmHqtfefUJQOQP6iquHMdCuV11hY9Y8i6lL+MQPoBCZ+4y3sFSwxnWn9nFzImJuPRbm41k8akqhWbG31Sa6IeH+KuZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3wc+WFwWbFGcxhW4+aWoJPJma26gO3eOloFJQuV9U=;
 b=o5QR0W+g2Jrk0H+BixIe19F1Bp2idZjpwbFVNu2E6iv1UCvwPtZVJ5BeuGpyYHo1QxegVZu2Agvk369bQYx2WGYmvbtzvxNLCVcSmm6fcFnrtN69oiCOwbsKXkqdEEO9+fbgHihkje+EttnQa31Dlfpt7z5WlK4q1bRLy5s7r9/mBiHazBeipx8iQco2gdV5LB/ScZLEznH3nguQiwta/G1mkVjoBJeI00I/nugXENMgbexeQgzLC/P+TEYU3uOwmWiPDUZ9xZgn0NxullI2RZQU7tia7dSMYrmNNpngKfveIFT9sgkrEkD7/01cKkPdNhuj6yTUDmOs2WIApIVgIg==
Received: from CYXPR02CA0083.namprd02.prod.outlook.com (2603:10b6:930:ce::18)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 18:26:07 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::e5) by CYXPR02CA0083.outlook.office365.com
 (2603:10b6:930:ce::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 18:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 18:26:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 11:25:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 11:25:57 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 11:25:56 -0700
Date:   Fri, 18 Aug 2023 11:25:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZN+3spv3/8N2IDVa@Asurada-Nvidia>
References: <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
 <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
 <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
 <ZN+i1pEoN/NsWPKS@nvidia.com>
 <ZN+w3fahQpM2W9Yx@Asurada-Nvidia>
 <ZN+2h5rpTUI5aG3M@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZN+2h5rpTUI5aG3M@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: d283e4ff-a1b7-4fdf-50d4-08dba01896bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f78JlCcgbamYaiP684t9nsjVx4/Xg+2q/+ZuMi2ApFiCpQnwHUS6lmbU+LKXyBFSu8hj8GwKhPK+wI+QmivpcN0LLg6joUqtOJqgyNg/mQ0R+gqDTUqzTfx+s/plIZLLa/ZZ193DoLmuSeKnUnxmGRD7Nfjs+8dDCtMbopL2vwFjPtc7X/CBBt7lhaU7ex+w1Xcs56/GrLsgozTJinfQXr3kBVEv/WadirTFHWLTxVLFvjNN/vH0iI5lGX97XEPkSkBWLv8SNFtgWFwjJov6TjVd0kuaIES3PCtQJ8XxpmdzH10Ze+xYCTZJeyyvFACxGefaGghYOJjeGKcqxwQVoSBTDruFMKbDxCwhEphJUIW/EBlFQ0tTG2InKxU7VY8JxPYh7jQGils6ho/qbDQNdQCYb9PEMjqu3jOHaFYqcwps40GhXqor9EqVh6vBxvlKbMMYrUyBr7TTJLwrV/qBrExQFoAjFR2USM9/2OZbGWjCeV6mPhMpd8GCWpNbOVfgCfvlgKdfrUq0RBcVGs0tMNrRc7P9FAImMm36J5lNY945JcqJ9FM8N7Exj1HmgOZ/BmIZzRMm/3driEbH4QwPA0RbiqeY5T/uwx4TDy07AtigQW/TE19nZNbtSe9OxniFGtK5jyZzIx7R2UDUD4O9MPPuDIb0Xp+yRnD//gqiOHgAof+fODDOECU0vxoNXdajjvcK7lrceK4ZOT+qWsM3kvrE+0wSzNJkKg7lbCi6AdvNGxuJUxZlHw+tZhqvLTO2
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(54906003)(82740400003)(7636003)(356005)(316002)(70206006)(6636002)(70586007)(5660300002)(41300700001)(36860700001)(47076005)(4326008)(8676002)(6862004)(8936002)(33716001)(26005)(40460700003)(2906002)(4744005)(55016003)(40480700001)(336012)(478600001)(426003)(7416002)(86362001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:26:07.0637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d283e4ff-a1b7-4fdf-50d4-08dba01896bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 03:20:55PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 10:56:45AM -0700, Nicolin Chen wrote:
> 
> > > The highest array index sounds generic, the error code maybe is too
> > 
> > We could do in its and report the error code in its raw form:
> > 	__u32 out_array_index;
> > 	/* number of bits used to report error code in the returned array_index */
> > 	__u32 out_array_index_error_code_bits;
> > Or just:
> > 	__u32 out_array_index;
> > 	__u32 out_error_code;
> > 
> > Do we have to define a list of generic error code?
> 
> out_driver_error_code may be OK

Ack. Will implement the array in that way.

Thanks!
Nic
