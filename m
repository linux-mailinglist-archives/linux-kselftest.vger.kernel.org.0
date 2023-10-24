Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806BE7D59BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjJXR3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJXR3N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:29:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04905128;
        Tue, 24 Oct 2023 10:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF5QOTudQ4haiCQQVil98pBn7FnfmyTG9t1jrf3nbCb0gOTogNsJswHzhI5BGp36YfQ/qDJ+VM8RVZsBWyXSHP8dv3Vgx00PkZKr9rPENoFWzcZIjtEmV0AvH8a13Hyj+OT/ZsoVs8wGUozrYutDqaXXaZd7t9Nq8aSjz2CxwSTG+ZdmIENfErlzfkUi2sjmA1w/gc3wmfsegHqG1MHbP7SPOn76RU+uzhq7J8cEV1rw4dUv7TqiNwX/g7ZPuZwGl52Qc0Q0wadM4I+POltRzrzC5SOdQB6yjtzAWTnFhc+ki6xPCk5z0F8CQSoSCrNxrrU1CbIiwjkUiM41H3oWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGx8jUPDLb7aSXKJShd1zq+LozIkxOegH4u2yJl9rnk=;
 b=dSX3RfOIJRowKejDbVZVr91f6rgqiY+camAb00rcukEycJJ073EZZ2AU7WYtPDHFmbDPxLmmdGejyE+eDWKnrdXcOkql96j3eCsqEe8vdYn+a9kCYXNZRzdVUuhn/RDN8Kxj/2tjUB+Ny0zpgTB1a8w0gEOGVZBuNEUqfDYa+nhA/MIBYLn6QxWIRiQcfUvm/FGbYRE/T8XqYwxC42qnpd/FHyTFBCpMOjAYuP4ojkO58WcEPDBVD1srJScTky/hSVyxXSgqhHrjkOXohG4X+BO72ZgpM/xRX8kQHdJBZzDQtDp+al1dLDrcNHgvL49xPWYhxZkUKH/mcDRnDGm44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGx8jUPDLb7aSXKJShd1zq+LozIkxOegH4u2yJl9rnk=;
 b=mzcbE/M7cThbUkzOsATDQqO++y+lojZqPTFZ8HE2fKVbFY9iTBbjaES/zPtS+jIPTaO/YsdENLSnpI3SSBT9cbgYAFVmemGPlm/CBL8KQYiCtrPxVg4K/XH2iFXwcuERwq29Aq6i8trOC/q9kLWlEwtpy/e3/OADKd3TDZl1wTksXa+r9GzA/yjO2YpyJFM7p9DT1AmJ4QSb/MMq/i2f/gG7yfAPnwfaW2fqlYsy2cQtQfJdX/u8XCBjI2ifme9Cz3b7/PFkJAgRnjoAzgQI4zPtJQq2YudvkjaThypaTJ0PJY2VruDEuD4tbI5xUCQxvwFmzhkSo8vBmrsgGzzp+w==
Received: from SA1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:2ce::16)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:29:09 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::d2) by SA1PR04CA0010.outlook.office365.com
 (2603:10b6:806:2ce::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Tue, 24 Oct 2023 17:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 17:29:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 10:28:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 10:28:48 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 24 Oct 2023 10:28:47 -0700
Date:   Tue, 24 Oct 2023 10:28:45 -0700
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
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231024171810.GO3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM6PR12MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b71b35-92f4-4b1a-cc9e-08dbd4b6bb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckk/JEuZ1ytQ9/rwF/Qle3ZopOPxecX3wFJ/a5+MThL6a5Ra63wDM0urr9B8EDoJri3sZQGeTh6Eh3jwun/ZxoaFL+pHqDrfl51O42XD8r5XipAQBFITACeZxduC3Y9sfo+WNP6CB7a2pEikZDZ2tGH+OaPlGH69xhzSK48F3o2iDxJIDUESF5XKpOAAiR6qP/esaXlIXcjBnFUv3diYiynTg0Vgwo4uxrFxOb47+UAFjksPWZzvCszzzqCqJDWUZCJa5Qvmbw2mUyzjyUAFcMEHOgz3y/BB8aHzl+V9PXDWYKb0RS0g7+jPCFos+YiZ1LaRi/oM33Yzo/P3h+MYg7Z9xMJM13ueMsB76ISo6i+mXg7XXvsU8QEl3dwWH6Y1Lb48CJ5sWdR5w7irGSO93xvYJmDOmUstKwjm3G39Z9m3p3FhObrTRAJgHt5hMlb5mCC7arnqU238nDQSCkAnx+F4UP6hY4v0B7X25f7B/9hqgMHqpQzqTILW0m/zP2njqVc4Zcxc3RO6hAO9BmzYxCTxyPkM2+nMZW3YSCwH1jEX7ZqWL8g0jdegsKbmfFq01Um1LEAxihakqiC97of1Fy0k6sxDpo4fiNjw9dnGrKHgp80YB4Dwie9fIiUUG51UJTQ5JeO8IkfDOPeEplGRNyDzbJwFeSgbDMMZs+xDVwRhdmDwNt7QAUcd15WFtgx3tqtEbt9F93EgmibbNsHUjuwzf49tgbLnNn5RuL0e3XQDzGlsNP4bbIrNZV2mekmB6haifL52DoiyWqu83tNswA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(55016003)(4744005)(2906002)(86362001)(41300700001)(356005)(54906003)(70586007)(6636002)(82740400003)(316002)(7636003)(478600001)(70206006)(9686003)(426003)(40480700001)(47076005)(83380400001)(336012)(36860700001)(40460700003)(5660300002)(7416002)(6862004)(4326008)(8676002)(8936002)(26005)(33716001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:29:08.8899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b71b35-92f4-4b1a-cc9e-08dbd4b6bb0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 02:18:10PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
> > @@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> >  	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
> >  		struct iommufd_hwpt_paging *hwpt_paging;
> >  
> > +		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
> > +			rc = -EINVAL;
> > +			goto out_put_pt;
> > +		}
> >  		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> >  		mutex_lock(&ioas->mutex);
> >  		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
> 
> ?? What is this?
> 
> Ah something went wrong earlier in "iommu: Pass in parent domain with
> user_data to domain_alloc_user op"
> 
> Once we added the user_data we should flow it through to the op
> always.

Hmm, iommufd_hwpt_paging_alloc doesn't take (or need) user_data,
but we could pass in a dummy one if that looks better?

Thanks
Nicolin
