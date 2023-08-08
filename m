Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C4E7744BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjHHS1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjHHS1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 14:27:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE7238E3;
        Tue,  8 Aug 2023 10:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGuV6FfVLbEUFR8RJgVimj9d/JyzuKo0Ywku6HURbKFtdveAbGT5A65suSIgOUz+tHc3OgHkTujQsiBgPbHwAjkAn7NlXifmhAg1sRXqxB4WvjcrkR4ym6/HGw/hk+zxgIA/ZZPPGLv4Nh75WGWGmjLcM8fNL+oCcBO6XPp+YCRHDJDFj5vmNN2pXUFX8w2PjKaLNEgGzpiLIEszhtQ5QtVUwgYmo4kFpekJDCDxeIcMRwT8adNEs77CCIufvc+TR9yawfVInY9dl8v+bb7FYsDRk7U6RLSoPGjxXrO3xpWdrwO/ikgpx/TEahB9gMsz0T2oO6tyL30QnGRHZ3RZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spIGaO4/zw0S2pIKf3YwYUO8KFM+Jm+Hn2CgzFxrPGs=;
 b=ClrFl7gcEmiZ4AwhIGQ0uwonegjWbKAeVUTredHP/yxe61+icvtHdPcVbvrUaAO8/mdaURwX4YMcN8qk2C6aIarjHE6Mcl/5kweGMNgwXR4SHddpmYYue3zWixL1xc19yd7UxtwHWdnZ18sDjQUNPIaHVCJCv/UhWnL3XXUkbkcj0XcNkpuKK8ptzsXpXfkSE2g6bLQpZVDjl9JqR1tj+ZvD7omuEYpjatIin2EwmyzYMmDz7Tnr5/v4KuNCRWFMb90bGORgCS3QUHkRSGRCFYhMPAHgui6OO7JcdBDC85KfiKzPwPJxzSK6LwwiJwqoKIHj71WPRRZXXQ0RQz/ufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spIGaO4/zw0S2pIKf3YwYUO8KFM+Jm+Hn2CgzFxrPGs=;
 b=gwg3mwLfhXmS1oVYJVWNrCmDuUysb2uxJfyMInse7OK5i/vQ5tk4TP4kBi7VVaqlJcZLQ+aA5XIl2PqhOQ2yKImH98axNUDoqLQmKgfluuXHVfpZwf+/0o/16qY+LUgU40PhWJmIC3+yGfvW4+5kOYSdQHoR/S8FUPi4QO0P46+YEOahdhtPnP5gaXs5nn17q+7AIBoFPfjupNDhEZ+H5+jQqq6Ha+P8FEXpBoUEHvJKqt9sBkK4nQYVLbbdAqvSDE/CCuWUBcAdM27K5/Urnh1uxiLYDnFYBCr1vz/WDrhtmGdcK177b+sMDykfj5GtqdGu+H76QAxTVzNE4GrV7A==
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 17:42:04 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::46) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 17:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 17:42:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 10:41:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 8 Aug 2023
 10:41:41 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 8 Aug 2023 10:41:40 -0700
Date:   Tue, 8 Aug 2023 10:41:38 -0700
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
Message-ID: <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia>
 <ZNI2O4Upyna5AWDA@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNI2O4Upyna5AWDA@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d06e0f-a556-47eb-0254-08db9836c72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNwW95xE/152GDh3p6HsMf64Ckp337R9sWcaY+b9FhsHQJN8LnxOGOvRJ8T3Neu2HM1mRmbpktnzfwtqFQDAt6b33YvxX9dq3pDcFhsllqJGXigqReLRXfXro+4FZ7juKGdbAbsNKLH3OdytfFqaYK7UEja9HrF088iWg4HpG9MMij919g9eCPxCQTIDSHua0usnRJv7fgZhCmP9dVWkSwXnn8pIR9m8kLf/q4eCCa7l424AoBnT52yLJZSsgR9/m8wGLb7C84iFoj7d4DIV6gmGFsyiZS7mEjzI+Vram7EtQQ78oP9gl1e+RFQK6co47zbO0ios47rr5lFtsuoANPUjuPLoxdI5MLoWmU7pA0mZ1ikEebcslhDXhMpCaax+glB6n+sJnfgsdECfv0fw43CO8A1b4yBn40DcS8z1KkYD62THmE215r13/mNNsVKLoSpDNVgffvFUrfIF1aVS8A2WKFru021fwHW1988itqj0Vbh/08u9f+e13rUSMDyWwaT/uh9SXOE8ceGrhHHQt6r6vK+v5LsKJc8rOEJTM+xjP9QBwcCjvHtXl+Ytok3kBLI1EqU5Xkg78OMk4yOzsUAGMR6Urao1zceM4D99K5jd0mu/phXtpYVLV02X+qgqanlgL0DhXhlE7zKOdv6SsWCvm2/D5k2qGgI9ReNysINF4J4BZSWNVoF6UycM+XpiX1RDz91vonwseC1ktRTlDymBAJKQFQV1jlOCpTAv1kUowYhTQixhKsQ/rPozE8iY
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(1800799003)(82310400008)(186006)(46966006)(36840700001)(40470700004)(40480700001)(55016003)(336012)(40460700003)(4326008)(9686003)(316002)(6636002)(86362001)(7636003)(54906003)(356005)(70586007)(70206006)(478600001)(82740400003)(33716001)(26005)(426003)(8676002)(8936002)(41300700001)(6862004)(47076005)(36860700001)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:42:03.9678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d06e0f-a556-47eb-0254-08db9836c72f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 09:34:03AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 07, 2023 at 08:12:37PM -0700, Nicolin Chen wrote:
> > On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Monday, July 24, 2023 7:14 PM
> > > > >
> > > > > +static int intel_nested_cache_invalidate_user(struct iommu_domain
> > > > > *domain,
> > > > > +                                         void *user_data)
> > > > > +{
> > > > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req = user_data;
> > > > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info = user_data;
> > > > > +   struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > > > > +   unsigned int entry_size = inv_info->entry_size;
> > > > > +   u64 uptr = inv_info->inv_data_uptr;
> > > > > +   u64 nr_uptr = inv_info->entry_nr_uptr;
> > > > > +   struct device_domain_info *info;
> > > > > +   u32 entry_nr, index;
> > > > > +   unsigned long flags;
> > > > > +   int ret = 0;
> > > > > +
> > > > > +   if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> > > > > +           return -EFAULT;
> > > > > +
> > > > > +   for (index = 0; index < entry_nr; index++) {
> > > > > +           ret = copy_struct_from_user(req, sizeof(*req),
> > > > > +                                       u64_to_user_ptr(uptr + index *
> > > > > entry_size),
> > > > > +                                       entry_size);
> > > >
> > > > If continuing this direction then the driver should also check minsz etc.
> > > > for struct iommu_hwpt_vtd_s1_invalidate and iommu_hwpt_vtd_s1_invalidate_desc
> > > > since they are uAPI and subject to change.
> > > 
> > > Then needs to define size in the uapi data structure, and copy size first and
> > > check minsz before going forward. How about the structures for hwpt alloc
> > > like struct iommu_hwpt_vtd_s1? Should check minsz for them as well?
> > 
> > Assuming that every uAPI data structure needs a min_size, we can
> > either add a structure holding all min_sizes like iommufd main.c
> > or have another xx_min_len in iommu_/domain_ops.
> 
> If driver is doing the copy it is OK that driver does the min_size
> check too

Ah, just realized my reply above was missing a context..

Yi and I are having a concern that the core iommu_hpwt_alloc()
and iommu_hwpt_cache_invalidate(), in the nesting series, copy
data without checking the min_sizes. So, we are trying to add
the missing piece into the next version but not sure which way
could be optimal.

It probably makes sense to add cache_invalidate_user_min_len
next to the existing cache_invalidate_user_data_len. For the
iommu_hwpt_alloc, we are missing a data_len, as the core just
uses sizeof(union iommu_domain_user_data) when calling the
copy_struct_from_user().

Perhaps we could add two pairs of data_len/min_len in the ops
structs:
	// iommu_ops
	const size_t domain_alloc_user_data_len; // for sanity&copy
	const size_t domain_alloc_user_min_len; // for sanity only
	// iommu_domain_ops
	const size_t cache_invalidate_user_data_len; // for sanity&copy
	const size_t cache_invalidate_user_min_len; // for sanity only

Thanks
Nic
