Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A7767611
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 21:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjG1TKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjG1TKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 15:10:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A23422A;
        Fri, 28 Jul 2023 12:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh+rQumYVsV8bwe7TdJ4CRcrN8U04ES9yG4vhW+D6535TSz4kHEbzpCjZADXRNvxrKmCwjmlh2vaPBsxlQ2ZYlOq0ApQKQl+JH9knzxEuuRTJmfHIfL9oLNzM2Q1mrh/nn2h6VYzVaunNskE4anw2hb5jH0ZTgoTNnZQsavy1oWG70cMlJwrASPGFoXiqeWFNGTnKxrH6IOeO5dI9/C9IFr/rha+1tSsbW4oVvWyV+wi28m86LAFFRf8vqoCBqbUCW76aZyQVpORAjZWit8CkJhdO/o/2JqyDsf4hrSAMmkVd6VoHD9lTFaYkUGPE0xyowhDI/RuOsuKVnkca579Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsGPwOhADDslDx7yDEitZFaA8RlTWyavgSyfAWY3qMI=;
 b=ByPuqLlJC1wL/WzL5Tj7x+O6oIXQjbJjOJAX+DkNlTEsy9z/mIAJttSrUpLsS1UfiXIKDku0/saaPqScQl3g/XyUM+h5Ppu43kYmT/rlPmVn+jSAtjFpiYJiNMjakF0bPv/jIYpKm7ASD2mpZTpLz4BJPxcM6vbrqTJ0bwS5kuAYvkw1dwu13e4GTB33kr4ZwALGzkoVAx0Y8hWapkV0wvf/j6LH0co+EmJGPtKeCRzAeTCeCiQTWfbWkN/8fa073bavXxfFn/Hfgwut95GYulCQ9MPlnuMMCi5QkbR0PVPkqAXWftYr0WdiSr5C6MAD7xdieM/T0yMemihos5/MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsGPwOhADDslDx7yDEitZFaA8RlTWyavgSyfAWY3qMI=;
 b=iTkQxyKN8+VDGHmfZEXtsXUdATOcG20AaPsao/OWZBOfCSXzinQDCgPI0nuFQH7DVwE6ZhwMRfTEkYjNOvZ5Ph35QJk2FIube1Sx/5W9n0HhrN0SytqjiaG4vwix7a/C8IHJG4Y0RwssFHbzt3kZW0vpg0W3CEWtN4xeTaXL6ytxFaib3zhR+6wUrezUvUpzh61O37edqrqcjNoXb7aHwh03a4J7dSx62QGJPtdQLjyRg9DLLIhMJumO/GxqaSru9VRlPXL9tUfoABEg6SPDT2F17FBVG5vuveLqRb7mga9fWS95tReJnJfv0TqcRB0UhrG4iDc4DwwV1QMFis0+uw==
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 19:10:32 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::77) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 19:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.37 via Frontend Transport; Fri, 28 Jul 2023 19:10:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 12:10:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Jul
 2023 12:10:17 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 28 Jul 2023 12:10:15 -0700
Date:   Fri, 28 Jul 2023 12:10:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZMQSlvlVEE3G4R/8@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
 <ZMQBLTm+U+5bgC/Z@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMQBLTm+U+5bgC/Z@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: d1813934-9e20-4694-6bff-08db8f9e509f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajN4yEF2UjOkhy1apFmbsPWCsJhEi4ksHEwiKa4xihY4BMKt4bDmtpwBlFI9LzQTtEVReVILiXoLHsiAVufl2Qy/rf+ewchg7iHXKXgfDkkPS9U3q2xufCAN9JqGSN7uECvjDApCXDX6bqo/WYEw9zOvN5vsZ51OKCQWomYdrvN0HV6SGAk79LCCMBUQuwFZbWaeh+blhOM1AFpwA6mGWEoyJEob2T6QyoHGOqjC6yG49LDWh0yzEIfRKt9w+7MRKe8vYOOFJVLUug9gx9nCgr7OQkciuT5PbBDwgcART9pn6DrjOTOJy3ww0rImbWbU+vwU573UwZ2M+pNl5pUbNnfYwt7MYY7IS74FOAJkc+6WkanvJ9JWFrxoubCAWzA6dwLIONn+P/nc8pN6SScLxYMvGEVm8STQlgfGz1mb4+HYBLpYxlUw/NdBHtda5wLqKRrxSpL06CnMQpSSEDVvUfUhUn3SZ01fNGJPvX8Z8ii8lqZs3bMTvreitBWYfBFSV6rWP0Y3I7eySIzYGQEvnOueOPdqexUg+SrFWXb2AJvk7RfEHeOblRFBCmsqtoJgT4HaJ542Ky1X+USd6wyh4eoEeKEfWzK9nMuq3F1uawpdieO9lkKjFBjGyFkAg9rjPoVZ7Rpm+JgUbk5AOrJJrsJs0MNDTTOLJohBcmy5jyAmx99qrHOh4C/bIELqennz97mxPCQKbFjvCYORTdp3WnjF3+erpriZyr79hnC1dITcTm88k6pj+RwnMz/o4YBl
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(55016003)(40460700003)(26005)(186003)(426003)(336012)(47076005)(36860700001)(4326008)(6636002)(70586007)(8676002)(8936002)(41300700001)(5660300002)(9686003)(7416002)(70206006)(316002)(2906002)(110136005)(54906003)(40480700001)(478600001)(7636003)(33716001)(356005)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:10:32.1255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1813934-9e20-4694-6bff-08db8f9e509f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 02:55:57PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 24, 2023 at 04:03:57AM -0700, Yi Liu wrote:
> 
> > +	switch (pt_obj->type) {
> > +	case IOMMUFD_OBJ_IOAS:
> > +		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> > +		break;
> > +	case IOMMUFD_OBJ_HW_PAGETABLE:
> > +		/* pt_id points HWPT only when hwpt_type is !IOMMU_HWPT_TYPE_DEFAULT */
> > +		if (cmd->hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) {
> > +			rc = -EINVAL;
> > +			goto out_put_pt;
> > +		}
> > +
> > +		parent = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> > +		/*
> > +		 * Cannot allocate user-managed hwpt linking to auto_created
> > +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> > +		 * don't allocate another user-managed hwpt linking to it.
> > +		 */
> > +		if (parent->auto_domain || parent->parent) {
> > +			rc = -EINVAL;
> > +			goto out_put_pt;
> > +		}
> > +		ioas = parent->ioas;
> 
> Why do we set ioas here? I would think it should be NULL.
> 
> I think it is looking like a mistake to try and re-use
> iommufd_hw_pagetable_alloc() directly for the nested case. It should
> not have a IOAS argument, it should not do enforce_cc, or iopt_*
> functions
> 
> So must of the function is removed. Probably better to make a new
> ioas-less function for the nesting case.

OK.

@Yi, along with the PATCH-6 (IOMMU_RESV_SW_MSI), I will rework
on this -- mainly breaking up NESTED hwpt with IOAS.

Thanks
Nic
