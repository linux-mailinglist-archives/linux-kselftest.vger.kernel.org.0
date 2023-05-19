Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09797709F4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 20:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjESSpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjESSpV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 14:45:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F51A8;
        Fri, 19 May 2023 11:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl9/xKrCC2Ogvl3T06MUQydZtW7WqPYRVwMx3SyE/JTV/j8X3h67HPvk+gCyF9SkBrcpGUOQmx36naz7fY9+u6fprNy/XHn65kKhZYmVphZeOr5twaHpVrBFa/yP0rA5UqGnUJedow6uYo3g6dx2d/IBLKhF+QIZNTsJR/MAXnpeODyF7eB4fckRFVDqzxPzu/aHaoA+2fBkymIDQJOgCoLbyHoQImJ7LeuZn1jXXmq55krQCNWsS9EC3dmvUAAxxOFbgsX7ipzSLAtNqPfeioQ7QC28gMKFg77Pz4J1VeZFTDPGYNwX+2KjwUuucHs58mn0Z1oEdwD3aCiGvEpDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGTij30m2vHCIJlfg2iTmIpKiS+DypcwMz378KeP0mo=;
 b=Df3kCifeXZAejUXFp0kjTTcoYJXikIbgLCW49lkTyXAaTP9Vf8F86fZGLPQWcBz9mKeveu/8SbVedbKkt/fIMo0zj8gKguhLOJxlEKj5TG4FR+L9wC7mjBYHpOytN7Dzc3Dit3rdNhApoot0zqR1rOoTjXX1SvooYkYA9NCIgkH4QCz4USupahL3oV+MW9PlKjZW6lD/KcB7Qugww5D03GCiB2bDZyfeIkOlpnSUnh7jz6l0KS2SC80p57uk/VX244qpYMU2bL5UDugF1T56lev5n+NiaTTy0U6k/2pwezY1/ajib724g5uXLTgzPEt+y5b5IPTyAjzcW4KVOMykxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGTij30m2vHCIJlfg2iTmIpKiS+DypcwMz378KeP0mo=;
 b=AYkZuv3zGZWPYKPjHvnBubkkxdSKQEYuvnF0LcJB1GQGdjPYAKQMfI5/a1a9sD4ys4PVGYb+g6+gExFlaqeVBbbr7iJeavXjdgQWVay725g45lNd8eoo3qMuoxFrxdm0BIVhyP0y2aTY4kXPXc7jl3dATr58rwK3QtcPsLDFpPzG1OlK1BsxHvD/cgS0lP9io0B62WSk8e3bibSZKWZey7ifYYuQo5I778lk58y4HhSF+4/ZFNI4Yx5DySKviBSGdTgkrOBnFRMdV7C0k0oKLiu0NuNywy3CFBwednILH0Z+OX+XT/42AR+HfPjCdEkZwlx3GH1d5/4Mwy+O2kjzfg==
Received: from BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) by
 BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 18:45:17 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::12) by BL0PR0102CA0068.outlook.office365.com
 (2603:10b6:208:25::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 18:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.8 via Frontend Transport; Fri, 19 May 2023 18:45:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 11:45:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 11:45:04 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 11:45:03 -0700
Date:   Fri, 19 May 2023 11:45:01 -0700
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
Subject: Re: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZGfDrRDI50oGih2r@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a869991-4370-4f43-bcc4-08db58993063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7yUV6O+yfSFlF4ybxjSFHg5uCkIK6JQk54+8TEME2ngKdONb1ODGeSi2u8jR/HKDV7cU6I1Mb0cboupYYH9MR/NxO+lU7GO4UVrg+Yv549ni5icta5KWmncQL6fjyCO9bauthKsi+KRAyNCUZpHrC+s7kGfb7EgTbqlde3UwePG9Wut07OsTlGwDh0Ic70wMXADH+7q+o4KfoEPQgG7nRnPGX3I5sPy3GOHyIRnBn1KrzQnzVQOFlGp3PAhnvIZWf1yDcw9A4x56WU2p+SaVYd8JWmVLeu1TWdPyVfvu0YJmZnenKuc+1OWmFAKYCX0T4MLhLz5iGhSXKy2avnWua3b9pbf2HhiZ9TvMFUj2siWYUMv3bIKBxGfmR5fPJH9lXJGUQzCCDE3LXdLcdE3tRzjOxMK1BSSQzjjhyiX+2D3YAmf1hiI/CNIksc6vWVPThG9KJm0+JZN8wtqKIwxRMO3xnTjEcGbz/D/t512mRPAf9/rmCYcqAnLXoAJt4Y7eLlbO0xSwUpiX7DBxoq2TJv1DKYMnY2tfj+qRTrRmTomqqjLNsOXKUdHHESngbTBqaiHftkCWfnMM4RRJnIV4n6h/Bt2r4C7dziGK3QjoSfNV75Bs/pifA+A5Y7NaRQ7lt9pDWU06hUMI3HJg1LJEemz1uZTtED6DqfcI9wpT6AA8EjXyuw7QLlX95UTuRB2Hlf0EPqODYH0Z/AlgDkq/NL5B+OKpiJ7nVPsvSLvg+eK9/BpWr+ESOM25bhBhl/4
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(70586007)(478600001)(70206006)(4326008)(54906003)(316002)(86362001)(47076005)(83380400001)(9686003)(26005)(186003)(336012)(426003)(36860700001)(41300700001)(5660300002)(8676002)(8936002)(7416002)(2906002)(33716001)(82310400005)(55016003)(7636003)(82740400003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:45:16.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a869991-4370-4f43-bcc4-08db58993063
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

On Fri, May 19, 2023 at 08:47:45AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:39 PM
> > @@ -229,6 +238,15 @@ struct iommu_iotlb_gather {
> >   *           after use. Return the data buffer if success, or ERR_PTR on
> >   *           failure.
> >   * @domain_alloc: allocate iommu domain
> > + * @domain_alloc_user: allocate user iommu domain
> > + * @domain_alloc_user_data_len: return the required length of the user
> > data
> > + *                              to allocate a specific type user iommu domain.
> > + *                              @hwpt_type is defined as enum iommu_hwpt_type
> > + *                              in include/uapi/linux/iommufd.h. The returned
> > + *                              length is the corresponding sizeof driver data
> > + *                              structures in include/uapi/linux/iommufd.h.
> > + *                              -EOPNOTSUPP would be returned if the input
> > + *                              @hwpt_type is not supported by the driver.
> 
> Can this be merged with earlier @hw_info callback? That will already
> report a list of supported hwpt types. is there a problem to further
> describe the data length for each type in that interface?

Yi and I had a last minute talk before he sent this version
actually... This version of hw_info no longer reports a list
of supported hwpt types. We previously did that in a bitmap,
but we found that a bitmap will not be sufficient eventually
if there are more than 64 hwpt_types.

And this domain_alloc_user_data_len might not be necessary,
because in this version the IOMMUFD core doesn't really care
about the actual data_len since it copies the data into the
ucmd_buffer, i.e. we would probably only need a bool op like
"hwpt_type_is_supported".

Thanks
Nic
