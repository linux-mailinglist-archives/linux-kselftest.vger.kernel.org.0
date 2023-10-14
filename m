Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9037C91DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 02:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJNApJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 20:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNApJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 20:45:09 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4A9BB;
        Fri, 13 Oct 2023 17:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxh51LlvYaWQ7c4YtT8g7EdimBYy/+BHab90TPertL18dxCWSqxjJLBOWOM3wyIdF6KuWGb3UGeWUQw2SjUc2S8XCOlvu2cU5pVoErmBt1G0F4JFvGjzHwOEWdqDD1UF+fHld8b9u2zekK454mNEFWsQnRnXzLeB+cPk3+IX/4t5UIA+/MeG1OCeNxsvAZMNHK3YeIzDdcbc7KTP6KF55WaYB4o9ky92cJc6bGM3HkiDgyokmLT+A4j2gyIZepq4qoBFv7gAE2SvTIe3QmNcM4mGVruxgB74JDjy8uksEsmnhxnqh2oUCm2tE90afKAOVEohS2eqFpavEEwh3mgnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWdCgUtTlK28CqW8N548n6VauxJe2IQFf1lRRrPih6E=;
 b=GcPTvu+f/sEipqWL1wmjLpjfCAns5TGcf93VULqHknsl4rfNTyi6hoW/LTuqXYHD6SX/WNQ9XwrwP3GBbdPYkeZFmLPkWFcssE99nlW4RzPmFr0k+v2bfJqQn1dZguHn8SX+Z93vXNy7rEfYUxOZsUEFMF5QcBBArWQd7OlnMzMsbROcr2vy5JmNwxmizxFRbvroSSeOtci2GYN5tERzUfUgLZ5sacY/dhuUQPgbVVuSgDWdNxBjhFvsqHFq9UDZyO8VQmlt8RHSp0qgTSMErzvPnpfYo2iSnHRNWuz2T25c4074oH+nwTewz1FIhxhVmQIO+1nuu3JDoc1+5yXyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWdCgUtTlK28CqW8N548n6VauxJe2IQFf1lRRrPih6E=;
 b=a0K68YeR8H9ovjGhuX5ATmMrXdG4LfX9DYFyOjvBZO38MVk4FNZLlArRXwlQ627NSd99GlS3RTbRIAx4Qsyv9e0yieiayFjYEg1VaQwKu88Z5Sj9mDyUodbXEg7x9VxAdB4rHZSiZ4w7Xd39QAw8Da+mMq/agt5SIQfbz1B9iFXknFY8p4lBd61/QJqKa0O24PzXPtPUCHbbeAqFMPPWEIXkWNHYNXQI4njqCYPx87jRtByFLlqy1oAqQgx8OgJ3jABfAiyOC0Sar3l/gtiiC3WJXm+SHvLZbBUF8ZCSZMqFlnIpxLG7xRdsGarEAiq7yqrdzjKNlZvYUlGs+8aboQ==
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Sat, 14 Oct
 2023 00:45:04 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::2e) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29 via Frontend
 Transport; Sat, 14 Oct 2023 00:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 00:45:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 17:45:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 17:45:00 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 17:44:58 -0700
Date:   Fri, 13 Oct 2023 17:44:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b682e9-8c34-4dc7-b9d6-08dbcc4ece1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6mRtJa7yc9jfzkaiel12st+VrlBgCZeAZQFj/q1VA+bHDZ5H5cujuhWz9Gi20L2m9XOyVi6sri/RS3adu9D/Ywgs6drUVT2pTWZOKMPDGQLOg7asKkNaN2x4vxgG7mkuF0UyceSuXBIobqKi6K9P4xljbze3vCRsBZys1uxYiUEIR9Y3PndSqJHvuULSMHv94+D6Cm+Ni9zm1o7S74sRG/TGDs740WuwrDr3ZCoykIEgIwoi/s5QkAxTV0iwOGV2UX7Jo+JuRc0EQsp0CzLdcbD5e88DPKwwG7x2OpJlZfhcBxEwmQIgPe8saPDDeDCkjdgVGIuH3D5fL86tTNZJPC3ijMGUIB+b8X2cH6MfACJnNstZMVOJp7BiFVHYiHuAmGb0DCdoOkrKSOzPfUfDwkV4hBp717s4dX9dlXqQtQMY7Vyf4rjoTvGxM2pNnMpdSEYzqnN2KTXdPOy1Vsi2d0mPCleJHLUbtz2VuHOA1d5EEkNTB3ElJVna1nvPH2uCnPCUSfoV2SX8ALvIfWpREJh2AdFF3FwCTP9RSY+FAJ9/NSCcTV/W0JPvCQLKZ7M1j2sMj90hJff7BEvrUDt6AjtvSYWCyD5qzbbeVhQqvSdGAC5ZW9+V0RS5txOkH+uET6KPTWB4pPQcbEKNUTFHKkJzPBHJJNEcXteIuJK/LaZ9sWfJ6oD6QFaxQsgaxtahvOYh5wBXUcH8zO9GNss60OWXEvfecaCr9lonfnPvGqNOmgohbXY9XpYnQySjxK/
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(82740400003)(36860700001)(47076005)(336012)(356005)(478600001)(426003)(26005)(33716001)(86362001)(9686003)(55016003)(7636003)(40480700001)(2906002)(5660300002)(41300700001)(70206006)(6916009)(316002)(54906003)(8936002)(4326008)(70586007)(8676002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 00:45:03.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b682e9-8c34-4dc7-b9d6-08dbcc4ece1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 26, 2023 at 01:16:35AM -0700, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, September 21, 2023 3:51 PM
> >
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Now enforce_cache_coherency and msi_cookie are kernel-managed hwpt
> > things.
> > So, they should be only setup on kernel-managed domains. If the attaching
> > domain is a user-managed domain, redirect the hwpt to hwpt->parent to do
> > it correctly.
> >
> 
> No redirection. The parent should already have the configuration done
> when it's created. It shouldn't be triggered in the nesting path.

iommufd_hw_pagetable_enforce_cc() is not only called in alloc(),
but also in hwpt_attach/replace() if cc is not enforced by the
alloc() because the idev that initiates the hwpt_alloc() might
not have idev->enforce_cache_coherency. Only when another idev
that has idev->enforce_cache_coherency attaches to the shared
hwpt, the cc configuration would be done.

In a nesting case encountering the same situation above, the S2
hwpt is allocated without the iommufd_hw_pagetable_enforce_cc().
But the 2nd idev that has idev->enforce_cache_coherency might
attach directly to the S1 domain/hwpt without touching the S2
domain (for the same VM, S2 domain can be shared). In this case,
without a redirection, the iommufd_hw_pagetable_enforce_cc()
would be missed.

Any thought?

Nic
