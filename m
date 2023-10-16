Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505047CB2D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjJPSos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPSor (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 14:44:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1956F2;
        Mon, 16 Oct 2023 11:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMu9vQI2vjI86PbOFjXp4W8Vop5WhcgX+R3tEh9wpCLdQj2IQV4At4edqvuxMVv6lS17zxjjc2wHXgVbfkD5x7QcIde5jQ3IxSQ8GrfXgRUZ2viBKZbyafkD+K9A6ItTbKikV1KcTZoPJ94O9vufYa62R+u3IyWA+XsjzIB7ifF1uWKOoexaZ7X1VMyOSiH8oLmrvAUnzsT53niQ03LnyOLHYt7YomcBiih66N590lOEm0rJOue3hDnvOYKsjp9PpokMe4dG4u+eiqQ+eZwYaa9gTg1RKUHQxu9nbt7RmM5CA269DIclKnrpDSR18gMJ9RxYzrbU5hoeCSWfGtXElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9vZm9PB9ER5WdLPH3mvcIPSiDOJi2/FBlIt+m8svIQ=;
 b=RS6o3sCKkyGiOr2oijuVm1vHw4zrpkXIM7ZbY6S8MQupq8fXRd1oibDn7a+Zf5n0xYzT7eE3OXgC3Ht2NuJGRbie1DyCKs66TfLnv3c+YHWK5CTRUQ7GmtL8sPZNyZ1TIH/3YP0rnXbJv2iHXyLHOE/YaN7xQamsxqwe2i+dmcHPBVMMoACmqTKSCjvU4YAtrqW3TiwcI8yAIt6bGJtiDhr5PmSZLxgczonDmKv8/aJ/bx9oYFCGhDEACyG/LrEqVK3qzJ2pOo1YsvEwAflCFBGo7zygFuY6RXP+G0r3c/ZM7tlh9EvNUbCJh7kyAxOC+Frp6Ytnj0KsH85AYkNzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9vZm9PB9ER5WdLPH3mvcIPSiDOJi2/FBlIt+m8svIQ=;
 b=qwp1HCLYO8jETT5c61CYYn0PGOk0QS0HJv0dqhmaH/Pr81Vtc3yg+bbjGCCMq7waE3eKLMm/KpQDnZ3vfj4ciMmCx0JuDos0HmiRd6tL5XdOZ6TQIXo5PPJ90ZnMhUYHXRS31qyR/MGVWaaPRjir8emth1gqxKa43qY73OoysZ+kxXFaN+xvONghlwoHMO5h46hC0gvYwR+C2thGMUv+ptqndgoYAYt7FgZ1zdsAtxP+SLV2nGsgU98X/qsFEySaS39eJHjTfCiT9S4+4kNGVIDApz/3iCRt9beaflwlpsUArIUhm/eKRRQPR+Zhpw7SnsSzFomXPiRwp/ZE6GoRDQ==
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 18:44:41 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::68) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 18:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 18:44:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 11:44:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 11:44:29 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 11:44:28 -0700
Date:   Mon, 16 Oct 2023 11:44:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
Message-ID: <ZS2Eisb94o3inW7V@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
 <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com>
 <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
 <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
 <20231016115907.GQ3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016115907.GQ3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH2PR12MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f48c29-ca15-4679-c824-08dbce77f4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MAUEtxx1IMMFiAe9xyeJ0rAV99fKkOuF9UdU92s1ZaJNSEJW/Q+TJLLZga80FoyXbJNtjQ6tBJd4tTaVrBvUJrdz4Hlc4woqsKkr9gRgdbtkOGS4ZIsvxGgSO+fsLG3R1TUEhHF7EREgxJ0k5uPoiyhgcVCi/D5L60VD4vArS0F2sIcuLed30HLMiWWEcT/dN90NB+RmIk3CgUACLs6HHF1iBvinuOfa67cEt7KY4LQEZS7bzSxTwnOv61/qfAic2kcb6rkogPtb/FDweIoVcMj6DY+FwHgQAwXoFxFZmLj2DABB0eqW1OOpULL3qhvKtI4RetaFFnqb0zMkv1PRDFQd9nUcgdEMRz7eJXbu9VPeHrk1fRqginjjRVMjgR8e9kezcnM1F4tklmJiL+y9rq6nWD0ayJduDVx2tOp40ll86Ap/dYOnI/uvM/6brloWw8rlp8DVwoloZTco8jbwAs/9TPUAZmka571n+6z8dwihzO2u5Ozlu2ZDn/kvPsclchBUUB1zOX+NFQiXFSmY1SNYIiDbryif1o9s+U5OygnUr800R+BJFjqYXAZCd80PvTpu2FzCEf6QnfZJsxT2/o18Dy7YcppVbsYqB3rAXlHCnhGEg5Ym9ErTA5rrpSd3X20Amb58bsl9wwjEES0FH4tJt1xeptbvhrbWlbRW0ZzhhN55/NstNV/c4zoSr21TYMYuSaEUaENvpTpNbFFkyxWXKki/5AfvbmSLynK0A0uKgtEWuW6RCyicC/N0eP1
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(26005)(356005)(8676002)(4326008)(6862004)(82740400003)(8936002)(40460700003)(41300700001)(36860700001)(55016003)(9686003)(5660300002)(86362001)(7636003)(40480700001)(7416002)(2906002)(47076005)(70206006)(54906003)(70586007)(6636002)(336012)(426003)(83380400001)(316002)(478600001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 18:44:40.7839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f48c29-ca15-4679-c824-08dbce77f4ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 08:59:07AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 03:03:04PM +0800, Yi Liu wrote:
> > Current nesting series actually extends HWPT_ALLOC ioctl to accept user
> > data for allocating domain with vendor specific data. Nested translation
> > happens to be the usage of it. But nesting requires invalidation. If we
> > want to do further split, then this new series would be just "extending
> > HWPT_ALLOC to accept vendor specific data from userspace". But it will
> > lack of a user if nesting is separated. Is this acceptable? @Jason
> 
> I'd still like to include the nesting allocation and attach parts
> though, even if they are not usable without invalidation ..

This is the latest series that I reworked (in bottom-up order):
 iommu: Add a pair of helper to copy struct iommu_user_data{_array}
 iommufd: Add IOMMU_HWPT_INVALIDATE
 iommufd: Add a nested HW pagetable object
 iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
 iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
 iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
 iommufd/device: Add helpers to enforce/remove device reserved regions
 iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op
 iommu: Pass in parent domain with user_data to domain_alloc_user op

Perhaps we can have a preparatory series to merge first:
 iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
 iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
 iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
 iommufd/device: Add helpers to enforce/remove device reserved regions

Then next cycle would be basically 4 patches + selftests:
 iommufd: Add IOMMU_HWPT_INVALIDATE
 iommufd: Add a nested HW pagetable object
 iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op
 iommu: Pass in parent domain with user_data to domain_alloc_user op

The preparatory series doesn't involve functional changes yet have
a good amount of pieces to simplify the "nested HW pagetable" that
is basically nested_alloc/abort/destroy.

> > BTW. Do we still have unsolved issue on the invalidation path?
> 
> I'm not sure, there were so many different versions of it we need to
> go back over it and check the dirver implementations again

Only this v4 has the latest array-based invalidation design. And
it should be straightforward for drivers to define entry/request
structures. It might be a bit rush to review/finalize it at the
stage of rc6 though.

Thanks
Nic
