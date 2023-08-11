Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E0779502
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHKQqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHKQqF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 12:46:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668530CF;
        Fri, 11 Aug 2023 09:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+EEMtDIl2QsaVJpNqdY4RhtaQBrZPE1OAA+zWGiCoUeu0TazPqJxatEUINI2bud05anopeYgSqQCWBGtKlj1LgNceAMQn7dtTI+OeDZnPgaCb4CrdMmyUlkzTlTSc/WBRbkfKQLt/AY/VUlzoe8nSPDP7+9PPLHU2Cckyxmr9je9sVUK8ivzdgh4Cv0T3tXJ5AlEP7umT8XSSD6W/vRqGe6HHDrANbJSj6J6PZlnZwh6x4wHSRXXQE1TfV60VQrPTObMa0cq2Od5ZKWgswrCUxIxTU4JI3ZXyrUsNRRtnpnxK4RhVgke0eNYxKeaqSacpA2necY8mZ39zWk4IDXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxEv3kdh7Y3oPUDR/cXKlVfg7Z8PMG719tE7nLKO/TU=;
 b=J9w3b7sIFrAozdqXTb2NKYR3ivO0RsdTAqKIMeRT3Z+nnBwpUXxhCfh6gaYpW5BD4j+KCprU2vlIPXxRAYPLXy6VfUK7HhLUIFJQ2WQPe+IDzJ7zXjhGrHnI4sFA6aWLl5Gvs00PSbvredsyLo1cFtVb7z/9PvH9+2Stb3aQwOwBeHd8S7eSYb2QKsVYUql227vrFkC60tAiOBVpVnRkADTvsnaGHBCK3Ch/bZ9Bun2vNXYC8bBupLvTlzq4XgEU9pUgR37Q5YotDO0n2LRiIruN5NwdX8O+/NWyGBIb9s/trD9q8r0sndfIj36M6Z2iEJOfsgG8l19sNbTeW/DEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxEv3kdh7Y3oPUDR/cXKlVfg7Z8PMG719tE7nLKO/TU=;
 b=QTVJASBwXya7/jt8IpfckFTyqUz+3ifSqQfGxTP9+7WMse4SIg2hQaCb3Y6HHxNMYdQ7XepMV2naFLK2NDECXOUPMz+gObiUbzUxIFO4+GMsgh3hbYWir+JBd+MZ6Y81QgLfTv3bCSLPs9hXXb8oR6GUHsIBka1rkkny60hlNn/Cpdyfi/Yg6zAsS//PUBc90LCqGdDrDWYZNABTDmlpSsK31rZAK2h8rHwC4bsNJeUS5sbhixB7jIRJ2k6CY6n/jcBWun70FOZtPWJY/07ZiD0JzHCJ3dQabtn7j/fmb5IiATB4IvwH9TJsxcb4LQThre1OR7aI+9k+disbduftDw==
Received: from CH2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:610:4d::29)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:45:42 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::6) by CH2PR19CA0019.outlook.office365.com
 (2603:10b6:610:4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 16:45:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 09:45:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 09:45:21 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 11 Aug 2023 09:45:20 -0700
Date:   Fri, 11 Aug 2023 09:45:18 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
Message-ID: <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
References: <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
 <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: edc32989-36d3-4487-fcf8-08db9a8a6672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szGgPs26a6i2y1b83hmDK1Y3irF7cAqtvAlXi+X1cTxEbgKqfvAPapRDBimxg03cGHuhnM8XQIbIqKFAXXpI1B/Nr2wFtOsgBBOWtMxO7zwwlhNm9+ZSg34T1T8Aj2b6SgkymNquE+wBdse+M6rtMESeAcClvh7AJUfB3LUXcM8uo/hBDUPFCjYRfRLxX4NS7vvS7apfSdIo9VkzJPX2b7r1TBKy7ObCZp/2OuXT8WSRKfBd+tncSLwnFeMTlkhwdgD59SqhfDwlBuDCzontTEtkimw45D0W3R2dE9QEOkAgez2RiWi2NEOGn4Sj46SlmBDiJa2Gv9M5Ul+Ate2YEGT7j7Dlnj38GKKR2DHSlrtpU7wxSjIIdG6Vrfh3mwc+8OUBAVf6MrUqqEzKO78b2FndAFQV+vm7OTSAPyZT4yTEbsv55Irq1X5gEMLRtMfLOCODeaN68hSMcmWQgD3KLBEJ9jR+m4cfcqd6sHCbltPGR01+LbOptn6aG/5Dlv+Rb9Ae0AYLchXMK3tWPpWIAgjXkdhdTAMXannRsFQvF1G0hMg5wExrnNMiLFJQcj+ouDV/eMwDINcU2RZ1zgAl5aGl6yGq0FruaeP3+7nCgpElopf0D3ycLMzj5PZSHP3121Lik+yPOoRFaQw/CVjqTvFwXCkPMbEESHTMMBOS7xCVk25hRviOHkMloT5faxe3FknAxQD0LjLEl+qddZIPQ62jSaOXkw4m5FsZWOnES3UpMtHRHaAh3carwRApNji8
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(1800799006)(186006)(82310400008)(40470700004)(36840700001)(46966006)(2906002)(55016003)(40480700001)(478600001)(82740400003)(356005)(54906003)(7636003)(40460700003)(5660300002)(7416002)(8936002)(8676002)(86362001)(33716001)(70206006)(4326008)(6916009)(70586007)(41300700001)(316002)(9686003)(36860700001)(83380400001)(426003)(47076005)(26005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:45:41.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc32989-36d3-4487-fcf8-08db9a8a6672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 03:52:52AM +0000, Tian, Kevin wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, August 11, 2023 5:03 AM
> >
> > > > > Is there a use case for invaliation only SW emulated rings, and do we
> > > > > care about optimizing for the wrap around case?
> > > >
> > > > Hmm, why a SW emulated ring?
> > >
> > > That is what you are building. The VMM catches the write of the
> > > producer pointer and the VMM SW bundles it up to call into the kernel.
> >
> > Still not fully getting it. Do you mean a ring that is prepared
> > by the VMM? I think the only case that we need to handle a ring
> > is what I did by forwarding the guest CMDQ (a ring) to the host
> > directly. Not sure why VMM would need another ring for those
> > linearized invalidation commands. Or maybe I misunderstood..
> >
> 
> iiuc the point of a ring-based native format is to maximum code reuse
> when later in-kernel fast invalidation path (from kvm to smmu driver)
> is enabled. Then both slow (via vmm) and fast (in-kernel) path use
> the same logic to handle guest invalidation queue.

I see. That's about the fast path topic. Thanks for the input.

> But if stepping back a bit supporting an array-based non-native format
> could simplify the uAPI design and allows code sharing for array among
> vendor drivers. You can still keep the entry as native format then the
> only difference with future in-kernel fast path is just on walking an array
> vs. walking a ring. And VMM doesn't need to expose non-invalidate
> cmds to the kernel and then be skipped.

Ah, so we might still design the uAPI to be ring based at this
moment, yet don't support a case CONS > 0 to leave that to an
upgrade in the future.

I will try estimating a bit how complicated to implement the
ring, to see if we could just start with that. Otherwise, will
just start with an array.

Thanks
Nic
