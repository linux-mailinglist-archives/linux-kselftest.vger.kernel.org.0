Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94E76DD16
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 03:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHCBXn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHCBXj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 21:23:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC02D5F;
        Wed,  2 Aug 2023 18:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/48XVvGkE2US2WdUSVfkeMGtd99ei1plCuYescKlPOwfJMp2VxTT3832t/aP0Q1UROU54tNbcmqXTFQ5Zx3ki3CMFG1UmlUCQuu52wV+fubeJasgqe9TTkWGv7w/Z8vTrTCa2FtOJ+ZVm0uYp+if3EpjoalfjOAE6hEq07eP4tozzcA8jmpFefebgqehFJI5JbQlnH7F9/Iet0XcLCoCRHrw9PchRRC1+077DWfj1RG5vRTtnIJ/aL62mettX/6P3dqfCznTSEU4U01WprNIoyvkeEyCr5l5GuR/2Jp3uTQcOIwaiY/pp67ID0FpPhSDgnZy0A9mp8ELeuZwB9Zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aai24j/OcrBIqidtkseSPx5gYRxa1j0X+TVn3zHHRfo=;
 b=EDQx51KvokOE2RvlZR0eNb6qSo/QKfC0Y6mA3ogxzM+p4gxA9jHaElHrbfcdXKtqAdVZbdccAf3YZeEM3ugIz/fbXL5P4eM3dkQ1NdTeYoRtcKyYuZKSigY4JBFNEoYPAlHmvjwUb1N59XjoYN5lleoykvjhkDvxHTebhX77R2OsqLO/z+Ezjbang7B2ivhyPlku6YFffC0jsM7qgS5qcusAZ7AgwsNL0cdvWL6AZ0mOX0BM9jgPvI9NF0MYLLWllkJnb0t9DLkTLlahMf8eaCYycF9XfHyuf3cs1Y9FoPS5P545dupFPi/Kp54LpYmJZdUbsp3B3UelxwlHSOiXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aai24j/OcrBIqidtkseSPx5gYRxa1j0X+TVn3zHHRfo=;
 b=Ed704Dx/ZzJNqDMm+VVa+FsTCfcFzRjQC1hWNID6miEoIX3jsoTeY819Za/XOMfrhxnFaAcGNY9SJFJ5medc9VGOMJrCeJJNyzgav+mxeAs0nfYCauOf8yKm37I7ThB17+RaW5i4gXbOB70zQ67z/RFUuX7PgYH2fZHBZm75UHHvzSkXx2jqNIsfFdxsSs7B2+gQarZVDjHdIrOt8G/ja5qbwvwkXYxdb8fccT9bmvynCnjnvQAzDl6eVrniomRLDxJYPn07L1/FX9Fbw+gkuaqlTs/zYXAC9qcjIw1tbbVwu6VQSWb5hd+zadnrhdLihPSODB6GLHajVFiH9QHnWA==
Received: from MW2PR2101CA0036.namprd21.prod.outlook.com (2603:10b6:302:1::49)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 01:23:35 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::80) by MW2PR2101CA0036.outlook.office365.com
 (2603:10b6:302:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.12 via Frontend
 Transport; Thu, 3 Aug 2023 01:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Thu, 3 Aug 2023 01:23:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 18:23:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 18:23:26 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 18:23:24 -0700
Date:   Wed, 2 Aug 2023 18:23:23 -0700
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
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMsBi24W2+ubtmkh@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
 <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZMlNcRgMYatv/YqO@nvidia.com>
 <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d16bd0-85f0-407d-b6fe-08db93c04251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+uVdJj34q+phnXT9hKziOVlOIBXgBHNufRCSAj9K/WFN3cIux5s6lBhpw8HYmG+TM33IYObTvtfYr7njZYFnHsMKyLsIvfOzvcsjoadjNRSiEcFpKXGn+wALtANXZzImKWrckDGCOaybRxZTuxze9W+OGv53EQTexdcUmWrwKfvS+INtTUu60zGV10lS53Nd3XThEyQCYopbdD2QN1USzVDhNo97WA8jqz5ScIyKXHGDV1tKhPf8qp0hh05vH5y6XHuFK6rv/x60hEK5jsoff7MDUwP/oZNs1mrv7lvSI1/QdFVZLJ5YtYQpq9XsH8jdXs3mDkWaJ6hDmTnTtajq+3nhJSRN30pFS7e9FqNWVYPt3Wrq++xVYG/F3ikKRQm8GChMFTsmXoFUWx+Vol0sghFZJMIfzu8sgUh8vtChVkEAXtEWQEZjqRFWMV0RfteeZhca/hKqWpEQvK+a0IpSj8SVH915fIJeQra5U3EfztVbQYtkOS9a7tZBjJ2MecrNL9zU+ts62vig35rZplaFJVuwcDxyND4bTKNaTNYCH8op04VN6DdoWu+NmZ9A6kATDba5Y0u0dYD6bREKhOdSBG2FeyzAaBGBG1a/IhMFfd3lhhYWLX1eAkWTq0BjI3eh+CgxAmjswFbIX4D7MSiWy6V85FWUph0ENn2ldN4CPcIz5QjVSGsptBxUGrww0fg0u1dpiaU8pSfUtiFgwmmgSQD90dMnWPBpI4QEwVbDlXGSBr/Gu9f21qwMnC0jCYiZ+tzoteI7cu01HwUCtmAbQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40480700001)(55016003)(336012)(186003)(40460700003)(9686003)(316002)(478600001)(86362001)(7636003)(54906003)(70206006)(70586007)(33716001)(6916009)(4326008)(82740400003)(356005)(26005)(41300700001)(8936002)(8676002)(7416002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:23:35.7775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d16bd0-85f0-407d-b6fe-08db93c04251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 01:09:28AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, August 2, 2023 2:23 AM
> >
> > On Tue, Aug 01, 2023 at 02:40:44AM +0000, Tian, Kevin wrote:
> >
> > > > So, I guess we should leave it like this?
> > > >
> > >
> > > Yes. Along with this discussion (including what you explained for sw_msi)
> > > let's abandon this new cmd and leave it as today.
> >
> > You sure? This makes it basically impossible to write a "correct" vmm
> > that is aware of what the physical memory map must be early on
> >
> 
> emmm... I thought it's what you meant by "leave it like this" and the
> fact that existing VMM's memory layout happens to match the reserved
> regions. Nobody complains lacking of such a interface for years then
> we may postpone supporting it until it's really required.
> 
> btw even if we add this new cmd now, getting the Qemu support to
> use the aggregated list when creating the guest memory map is not
> a simple task given currently vfio only passively acts on change
> notifications in the guest memory layout. It requires a new mechanism
> to enforce strict order (probe all vfio devices before creating the memory
> layout) and then injects vfio reserved regions into the layout.
> 
> Preferably let's not making it a hard dependency for this series.

Should we drop this and its selftest patch from this series?

Thanks
Nic
