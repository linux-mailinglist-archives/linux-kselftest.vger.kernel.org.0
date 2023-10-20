Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B947D1605
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjJTS7c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjJTS7b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 14:59:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178DFD70;
        Fri, 20 Oct 2023 11:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve6JK0qztnEsW2XhC8TXM4wsm25mKpw+4Htd2mJt9im0qzrQrvEYbcs7oaFSUhJG/sCxLnZdBmRPHSIdxNeDxbawMjscMw/iocqaFeChZSjdjg8WJGTn4OgpebXusNxincROfP+tLNk0xdFlsOTQ7nYwOPVUNwKU+pYkGDKIDMPAoAMbUyBS9IPypYMy6mcfT1EiqMcqes2E69yvjpaQ2GHFv8lLqzwu+lkBSvbmONNuMUPwyPK5ovV0Xs8kzvblZMsNozQr1Ms+fsIxB3P9uzYxQhHoDeTbGt0AbWXEYbsvWbiAFnnubmGQPFh/PKZwrhWqbI0IKYISFMrh0erb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1sntpRSYS4mEFqBki+vFeXsoVmLmMSCA9/ZbuFyYRg=;
 b=hUJnqGBlaJX1XaLcPR8bP66/2AEuRC40Xo4SS2zU6+cUP7V4tSzBH54hX4wMVa1+hxcj8G/axYFUgr7R9lfqLeWbMf7wBj9Q6R1wZ1wQz3T/7MurAHWQkw9qEhmBMNoQTEtmlzbiSmYj6YC/+l0LEd8hr+WQmQUG8Xdn9OchY3VkWMrRGXMp8vnVUMKL/5kaEtRTGI0z+iZVhDkk33Coaz1qmwrInEGjTV0SEyGdzBJSPWLMRFRocCsLJeT+96WqlUyn6+3HwWTNFkVasaHTphKHpjlJ9T8J0hWbJEaTy+EBsSqst/rlzb1YkyIx66yaA6ydl/WwkHw6jC+nHbC4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1sntpRSYS4mEFqBki+vFeXsoVmLmMSCA9/ZbuFyYRg=;
 b=aw8qAwqApw9ZoorRFA1Q7Qukrnif111cD3KvF1LgLbOupcGskAmYYVYb1m/YBTZoWQJN/gUXYc/9n7sYzWLiW1yZ8AIwoMr7D+xbOaHZx/bQsYDK0ebGV7IPV8yVdRK2SSNkOihb6B3CILLgfVADbShvJSIb5GPSOBubCsSAFnXnvAP9OJjFnkXj72cp2hvUwr3SuXtKJ4ztgYAFsbmgN+fBVVhJClCNW356wGrVg9eIVaEm2PuGzvFaWpNbIQ3Vti7AmUgBx2GsuWLFCVslgVDwbCXDO0H/j30b0IUIUPJH5DcZYqIlreSpuC5bfgiF1ZqB0rH7bZNSS7xd6wa6lA==
Received: from BLAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:208:335::13)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 18:59:27 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::6f) by BLAPR05CA0032.outlook.office365.com
 (2603:10b6:208:335::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Fri, 20 Oct 2023 18:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 18:59:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 11:59:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 11:59:15 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 20 Oct 2023 11:59:14 -0700
Date:   Fri, 20 Oct 2023 11:59:13 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
References: <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020135501.GG3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH0PR12MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9220de-c3c0-46dc-c9d3-08dbd19eaed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWzxJVAMmxDRQOKqvRoQxXPonmAJp37qB3TEe6drWr/YT9lI4low8cfT/qmVmY2n6Rb5Xc0UXQ9Po6stDoz261kwA3nlHK2DwZekoL5YPam2ts0h+JZCJPSIcrZynD96ymtrksVrZYy2aI26ZUxDVOLt0DWnEd47TYcPqHhTXdwtl4c2ZAwSmra8NtFr9G0cwVxwBHLQ0U0WCgtKYhQSvKXrD89aRtQwAB469d0obRk7xoqWFaVjB+E8WRnSM1c4qxnP2+GkJAu0ckjP3sIn9Th6YLBihAKLwEzPDboBMouaYbhHhOmPdaM+HIgj4hUh+0Aw6sDOVsLJhRCKMTNcX1DA3QmbKLMszAD+FIu/VH+GAjvkeQnmhbVNIruq63/jjECMcSKIKziGlH6oIxmlDmCuNmzhjnxd9JdgQ8bAsc4q+SSN3n11FK06T44WbxoVR9xIxi2QD5AlRUwOEEN+LovVQf7060MmoMiI/0P6gSepGhMC2w0C2l2Ta1c33iJMYeWcloflj2uMGqgp6znk3j2D40VnSQXEH6rjcaPy2gwtGeOVkR4ZxV1ZcBcaViVD8OKR19LMYpEtV+1nv1irGxuznFY59s02uYYAC+ldOY44B/gq8G6r4nsVqyG+KN84WUbgstUfyseCZd0ofU+q764DhoSBztE2ooPGRTVzPYNw3UIMeQCAy68l2w/i0GBOLhF2ax3YumzOE6JaUsf8aP3xSqLAFSmWhFIbQzcR5VpoZmEG9J0paWU9r9HNNBcL
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(86362001)(4326008)(40460700003)(55016003)(478600001)(70586007)(70206006)(54906003)(6636002)(316002)(8676002)(8936002)(5660300002)(41300700001)(6862004)(7416002)(2906002)(7636003)(47076005)(26005)(36860700001)(426003)(83380400001)(356005)(336012)(9686003)(40480700001)(82740400003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:59:26.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9220de-c3c0-46dc-c9d3-08dbd19eaed4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 20, 2023 at 10:55:01AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 20, 2023 at 02:43:58AM +0000, Tian, Kevin wrote:
> 
> > What we want to prevent is attaching a non-CC device to a CC domain
> > or upgrade a non-CC domain to CC since in both case the non-CC
> > device will be broken due to incompatible page table format.
> 
> [..]
> 
> > Who cares about such consistency? sure the result is different due to order:
> > 
> > 1) creating hwpt for dev1 (non-CC) then later attaching hwpt to
> >     dev2 (CC) will succeed;
> > 
> > 2) creating hwpt for dev2 (CC) then later attaching hwpt to
> >     dev1 (non-CC) will fail then the user should create a new hwpt
> >     for dev1;
> 
> AH... So really what the Intel driver wants is not upgrade to CC but
> *downgrade* from CC.
> 
> non-CC is the type that is universally applicable, so if we come
> across a non-CC capable device the proper/optimal thing is to degrade
> the HWPT and re-use it, not allocate a new HWPT.
> 
> So the whole thing is upside down.
> 
> As changing the IOPTEs in flight seems hard, and I don't want to see
> the Intel driver get slowed down to accomodate this, I think you are
> right to say this should be a creation time property only.
> 
> I still think userspace should be able to select it so it can minimize
> the number of HWPTs required.
> 
> > But the user shouldn't assume such explicit consistency since it's not
> > defined in our uAPI. All we defined is that the attaching may
> > fail due to incompatibility for whatever reason then the user can
> > always try creating a new hwpt for the to-be-attached device. From
> > this regard I don't see providing consistency of result is
> > necessary. 😊
> 
> Anyhow, OK, lets add a comment summarizing your points and remove the
> cc upgrade at attach time (sorry Nicolin/Yi!)

Ack. I will send a small removal series. I assume it should CC
stable tree also? And where should we add this comment? Kdoc of
the alloc uAPI?

Thanks!
Nicolin

> It is easy to add a HWPT flag for this later if someone wants to
> optimize it.
> 
> Jason
