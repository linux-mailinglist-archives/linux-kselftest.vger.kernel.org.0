Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17A709F7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjESS6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESS6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 14:58:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5718CF3;
        Fri, 19 May 2023 11:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVQKBkMHiQHfWKlNbnlGa5hHYo6W8gPskjrozp2wkrX0US2kOuCNl2Ce5aufwQBbncFYEKuhAjIJiBB3DqREZRsM6LYVz7yzaMTye3YZ9xIJOOv6f4KfTjyf0EJeJyHSpmPNqrr1gvb3jYZWLGfTzQ4Gw69TLAKB9hlXg6Nn4q0PGp+lc6L+kYPfdCy4ghBOdUh/JvFiF2hLwbU/baAOxw4Oo666am6Y2GemBGy7WNaTKRGsBbr4V94qncpi0In45WY1fZSnm6nSLppDXzAfrnmVU++qQDmFK+7zIMF7QYE+NasBm4Aeq3/90yYLkFnXgXX78S5IGrW/V2feIGZkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2t67dAkX3C5fc87sDQLoehTgLtv8rC7EOW2c0zFUGM=;
 b=FXg0xKPwYxHKLvQ/oHQvuMFvmlCQC8xpEVE66GrV3V2nHaWXTIGQufGlWc5nSBIzCo06j3/e4AIppzCxldPphXNRfj3dGz4ZttgSXhIMTpOUe28kzcTPU3BNxv1bb4zkiB5DEHV4Ev5ckZXF2UWaENZ0KLGYb90q2PP21nTN8wVK0vKsVxAT1BDt7QmuOWkc+y7OcDhK7KLMZZSAUXHill02Cfgki74QktNWZ8Om/lOrDzqV2MwJ1N/TmIqFkvNDo//NgQU7su5jNiOnPJ8RX0cJJibGmS9qdZfh6/KSCRHUQ3eBKtewiem8y1G+t2wpw6eWlzwxXeUbVDV/7N616A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2t67dAkX3C5fc87sDQLoehTgLtv8rC7EOW2c0zFUGM=;
 b=qRHxV55hW7Dtsss6kTdIWIWyU0SqIQ2/hzvYjtzFQp4T2MKf6IWk3L/ezyRBSpZT/ZYbg0dMdMZwS51MMJYqbffpCFXNagiZOpKwwapCI6Yh5LgoEuopEUwUOVsogqKa16urv+PGPacvgUFn2e+FOoczzsYH8NByox2h0NFTCRCTrsR12lmtjuMTHWC2MmiVUz5YLBn/FhXe5uSPLPkAyxNyItk5F/gyV0uBw+GmUUe7fpd50Ow4T+poatYz2oyotVTFS3WtRYShbMa91bBHiRfXp6CgjLZX0j8gaYBt1HiIZv/MxsZzPNmZ0S6oxjtfc53pPT9JlCKyVts+NFa+Rw==
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 18:58:12 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::a7) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 18:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 18:58:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 11:57:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 11:57:58 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 11:57:56 -0700
Date:   Fri, 19 May 2023 11:57:55 -0700
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
Subject: Re: [PATCH v2 03/11] iommufd/hw_pagetable: Use domain_alloc_user op
 for domain allocation
Message-ID: <ZGfGs85B4hPBBxXc@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-4-yi.l.liu@intel.com>
 <BN9PR11MB5276FADBA5E22DCF3FFA2F838C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FADBA5E22DCF3FFA2F838C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd6de8a-bd0c-4040-fe18-08db589afe87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PRADzsV8OqgDazRaW16jwAd+04G6hQO8NCd2qUwnXC3t2O0Sk0VHhMiHqstnXeKeP721+bGRho5WTmvng3fdULW8ElCvwP+qul6wJ8QiPO77PscCyb630E1TsP6M+ciQjZ+xyasDzpkugslQXitzioMf+TChI36notEpfDBXiRhMlMLLQE3hKKv2FQUFpUrV9JS6+oKv+mR3pwuwYjWFu8bzFLcLwOze02UZYZz4lSA6sm00HSh/g/1bud8suJtNkCg8nOYh4GJKbiCR5bf0iqrIjl9NXmfhnrolw6RI1/3y8XR2nXpVZMrPxeMsqj6r3mF89juMwwlhEfFGoqbMsxHko4OtDFWVA19SdVTf8ouGNdwfjF2RUyGhgIZ9/jU6Koqab09d0T6SJrxVb3o64e2DGK9HrmxqhXpubj0YKx7QuNljxwkd+eeYmyhV8r3jWFzUn59+rKp2uBSRDk2cPr6OnUdW1hilTeppmCNA7xLrissqLtc3DOynlI4KkoeCrec/G8Tul1ScdKS9kPbTd4/oBD36oBngQeDVYyi9AA9x9cVkHXwx4bMLTp8MdhJSqa+BpkFPOsqg+kGymXUIK5rgtoNTOStwjX143NicS6z5orVAeEQxpXbVrArmyBorZcch4qdWONqK9bMNOnI3mDVXCNRacZys2sRppWpME4dChKlxSluOdd98cnlXV5VoBTGXO4T0ygGAxdynfvtX2eHT4YA/9NwQi4KBnG7neZkP4iGSb/qwfJ57kxM+FXd
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(478600001)(6916009)(70206006)(70586007)(316002)(41300700001)(9686003)(8936002)(8676002)(5660300002)(26005)(186003)(336012)(426003)(2906002)(47076005)(36860700001)(4326008)(7636003)(33716001)(356005)(82740400003)(82310400005)(86362001)(7416002)(40460700003)(40480700001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:58:12.0027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd6de8a-bd0c-4040-fe18-08db589afe87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

On Fri, May 19, 2023 at 08:56:25AM +0000, Tian, Kevin wrote:
 
> > From: Yi Liu <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:39 PM
> >
> >
> > @@ -88,7 +90,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas,
> >       refcount_inc(&ioas->obj.users);
> >       hwpt->ioas = ioas;
> >
> > -     hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> > +     if (ops->domain_alloc_user)
> > +             hwpt->domain = ops->domain_alloc_user(idev->dev, NULL,
> > NULL);
> > +     else
> > +             hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> 
> this reminds the comment for @domain_alloc_user() should clarify
> that UNMANGED domain type is assumed when no user data is
> provided, to be compatible with iommu_domain_alloc().

Yes. Perhaps:

 * @domain_alloc_user: allocate user iommu domain. A valid user_data pointer and
 *                     a parent pointer to a kernel-managed domain are required
 *                     to allocate an IOMMU_DOMAIN_NESTED domain. Otherwise, the
 *                     new domain will be set to an IOMMU_DOMAIN_UNMANAGED type.

Thanks
Nic
