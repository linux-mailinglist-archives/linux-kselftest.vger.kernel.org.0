Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412C764E64
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjG0I71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjG0I7E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 04:59:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E91B968;
        Thu, 27 Jul 2023 01:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U353+SrdgeYFNf8koTBhy2hWlj9tJns4mJeKX3wolEL5j74RVuqE8BBg1be/vHshK6h6AICakWElXjxSnKgT7vikr2ArcYO/j5v9XibilGphcqNxu2lCDUN7109Vrx2RgdmOWq+xZ6aEJCFBjf0eD5dy8eWSII4XDMLs+qTNYGA0Fl51YRqSaCInQ4hntAH7u8sFpABEVFfz+RwYUXCzv1KhNjRdlrEJSped9+YrrDeDHQodARsoYpcSL783qqidctUA6UT2l7lPCr+/j/1azSzrkZF9N4wnQye3tEF8FFUe7GyJciPeMQWgdwGrMN2ssiMG1c+4lgjRNDaqUw4A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEsbCDO4hI05Emk7G0J56F6e1bTGBzcCpu5LMSYssIs=;
 b=GHKjYWAiwRPPMRoybrRdjvl5hbr/5i1OdJC+G/ets9q+aMr3u5PQR5V4pMZnKrTVBTBUM66GOj6IsJi+4ydbXnw8gdgl7FgbH2+MB1o1pEYQS3vQfrnSgGkjNtZK2Wt+YQdM9mT923WwkIuDYbqVRcbqZ7VHHFS6srdUfifwc2zAOkCd1Qlzj8uPUp1aD+aS6Fp8sfSm+6PgSqSB8fKF+rSV7T5Z1syiIBa7eYvmnqyamHMq9ihdenpQ1lJBehD9QNKTCT6i6i6iGZfwRA30D1NQtzjgqBBkIn9zbkRMFdwuCB0QXFs4VxfPY/G+dmJZD1oBmCEhYk1VSMK/nPhNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEsbCDO4hI05Emk7G0J56F6e1bTGBzcCpu5LMSYssIs=;
 b=NGDHeSqwY68OXUjK+Zs2dM6xBxm2togNsD/NvkBa3uMZkiPEKlwDPxB860mMkXl2m8FWXFCUJnpMn7D9ICDr9OtGv7oJ73dF/V4d0F7iA/E5qVHJFIhqzzyEEFEMPR65uwgJGsYsACeTfeJZ9nQKcAPhTA1Fa3HCyHf5MqXS5isS4ufsVmrdGdiB5WiJfo5kL1BMnrkA7VLmLV3YUiXuvGBz1iy5c+KClyy7s315HQEadmT+IsJ/TxhLpfRbOGJVwvjU/RvdvZpL47iQtVIFXv0RSb/C72p369hN4gut10lD0TMRdCEZiQr2tRKw/IbxkM/MIh1nFe0cMB7vh8RSXA==
Received: from DM5PR07CA0072.namprd07.prod.outlook.com (2603:10b6:4:ad::37) by
 DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 08:38:31 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::5d) by DM5PR07CA0072.outlook.office365.com
 (2603:10b6:4:ad::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 08:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 08:38:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 01:38:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 01:38:21 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 01:38:20 -0700
Date:   Thu, 27 Jul 2023 01:38:19 -0700
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
Subject: Re: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Message-ID: <ZMIs+6w4vF3X27L7@Asurada-Nvidia>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-5-yi.l.liu@intel.com>
 <BN9PR11MB5276E70BEC76AB3D96CCF5028C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E70BEC76AB3D96CCF5028C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3971c499-d87c-4b11-5f4f-08db8e7cdb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqAq9JPKpLalLBpv1InbbWrhWAnGFmT0eqkEPrQm0BT4wGdE9W9GKqJnnLgmHSwV237qgjf1Fav1BwRfkS00SeMYlFhgiEvfK6LFITnzbvukdxZTQXvblqG4/gNEO/7uf6EsEa42JM+65XoppMpq8lPJbcA6ByubMvp5cPy/7Z5OIg0rxSTbYNXYTs0vUivNYMdPYTukNkNZqPxYdzRVaRdBG6g9G9sTay70OW1FOGi3kzmiPUoT2hhlrsGDVdPV/NcnX/zgdIZrvXqLmzuzynwAlvg+FQadxOpqAh8qneU7WT6cOAPLvagMsgwxfnTs3I2zb9FTrHmcbjvqBHmZu0Er2c/dWJt+SO1mWJ9xnUg/rIqdm9JZesAvvEv2SgAmbhFaSWuzktp6wXhfeuFXrWF8PXBpsEhqQ4P92N3lBZ5DOwWWNtdVC/hDkhUHCFjyfqeYOlTaw41TrBMeeKjXlsPee3EKOd63RrhuWi0RTbpklZ/ThQ0nOC/euAB7/lhPVA/iTpm9JADi1mnHIWmxI12gGSrr1G/mQx7WMVwnyJgxLVRMYyt5ykWtySEhBjS2Kf4lIDJoVu/cYerrXW8rQDtafmtrw4SRlPzV7resUNIiiYCXUrQInyQEu3Kr9GNrpKjuunch1YEy8g+zaGYzNdjwHgrm6gvIdueDN/5UObZEvkYspL5tlWz2uS8LY4fAmM0HVDIaE3I0+ez0kohHgktQ0wq4lvuGac5+JKmyC8BnpqeJdj0QVX+aKjtabzLBKu3Peg6Aoznefb7UIIArDQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(316002)(41300700001)(9686003)(6916009)(47076005)(4326008)(356005)(7636003)(478600001)(82740400003)(70206006)(70586007)(55016003)(54906003)(40480700001)(86362001)(26005)(2906002)(7416002)(336012)(186003)(40460700003)(426003)(33716001)(8676002)(5660300002)(8936002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:38:30.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3971c499-d87c-4b11-5f4f-08db8e7cdb10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kevin,

On Thu, Jul 27, 2023 at 08:14:45AM +0000, Tian, Kevin wrote:
 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, July 24, 2023 7:00 PM
> >
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -8,6 +8,7 @@
> >
> >  #include "io_pagetable.h"
> >  #include "iommufd_private.h"
> > +#include "iommufd_test.h"
> 
> Is it stale?

Ah, should've dropped it.

> > @@ -211,7 +213,7 @@ FIXTURE_SETUP(iommufd_ioas)
> >
> >       for (i = 0; i != variant->mock_domains; i++) {
> >               test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
> > -                                  &self->hwpt_id, NULL);
> > +                                  &self->hwpt_id, &self->device_id);
> >               self->base_iova = MOCK_APERTURE_START;
> >       }
> >  }
> > @@ -290,6 +292,19 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
> >       }
> >  }
> >
> > +TEST_F(iommufd_ioas, get_hw_info)
> > +{
> > +     struct iommu_test_hw_info info;
> > +
> > +     if (self->device_id) {
> > +             test_cmd_get_hw_info(self->device_id, sizeof(info), &info);
> > +             assert(info.test_reg ==
> > IOMMU_HW_INFO_SELFTEST_REGVAL);
> > +     } else {
> > +             test_err_get_hw_info(ENOENT, self->device_id,
> > +                                  sizeof(info), &info);
> > +     }
> 
> If self->device_id is invalid it should be reported right after
> test_cmd_mock_domain()?

A device_id is created per mock_domain. And mock_domain is a
variant that could be 0, so a device_id being 0 could be a
normal case. Here the invalid test is for negative coverage.

Thanks!
Nic
