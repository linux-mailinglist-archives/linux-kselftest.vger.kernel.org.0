Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9170A00E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjESTs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjESTs4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:48:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDE19F;
        Fri, 19 May 2023 12:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK08sKhD3nomrv8OZT1PVztWfyoQKBHoIZIfKTb9yJSh/4lUbyFacTNzdlO8QFyfTFRgMz+t6iSttvUkdcMXFMiouoUgRrCQPYjMYoDGYdHvqWpl86XkAS+PIHjFDiPsh/lc9dfdOZteRNf1ODupwiM8cT4Odi0h7QssUldHTffqTViP6L8qfBWHXEjaMLXotQOIlJilhv1CZxY6Ijwkq9XpCXLRqQbCNRzNXpChNo7nBbCCF5eSNRzILfKGFpLxSlja7JOm3k5NKveE14JXnuJbad3ETwMP+OvW3wvEC1uOjMqja+VTV0YUkg8lSvhMMffM/sl2nQDOimJP9gl1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jxEsXgJI98k/z3IqOECTL/vn2LsOyK0Yvtu0DxcwS0=;
 b=khj+LcpKqC70AjT4ZXxix7V6vHCGoLuF7UUG3/v+0fR/H65h+ZGRiXPo4HHLIgDUvs9BMlfFumJZq1bXUBniXW9csZ2/Degnirygbp+QO1FueHb31twrfQFHHZl9uYLSGS848Uk+vyVVW3srB1iI7laodRKww5z8fSPMNz6J4Ln0dv1AZAFOKRIRqcYUCTD5HzoE4c3iqLMXJ3Y1B8MuOZ770iEtN0iH7FqMJpXAE2/9S4TMuPllpQnGhUEzLgC6fsjjOzAdRVFGprAS7WHikaB/4CSOZZAb7MVpwypyxYRqiY4aetfk0BbCPjbQ7GBP+WNFLBXYSJ11PmA5zfWO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jxEsXgJI98k/z3IqOECTL/vn2LsOyK0Yvtu0DxcwS0=;
 b=fI6Y/d5U2Jy+922AcZRhL4q1k/9vPhrgrR+G8Fd3JL3g+Snizc5d6hRnB3FyJj1l5g3f+XTg8+wAstEzufwbyLj3pT0FmdfnpVGvMG5I3iu5F9BjnLperRi8kN/X0GsiO/wt3igZL3n5b/U3gQR2XPol1CxQ3Fnq+mK9NMgtwkEMVfSmlrSsPbGnuhSv17z4n8s6/U+uPVluwAsyt6qW5FIrxJXwmYmVveJi0fTM95azzPnbhd82aHRWeIK4vHCKFfHcba7V11yZnfIOX1AjUBJOcEM9TBQxy4cQAZxKwBqqw3Z/jYcgjLfZ55J9sCJscuvc7ZPPzFNg7WqU+W0BKA==
Received: from BL0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:91::35)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 19:48:49 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::92) by BL0PR05CA0025.outlook.office365.com
 (2603:10b6:208:91::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15 via Frontend
 Transport; Fri, 19 May 2023 19:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.7 via Frontend Transport; Fri, 19 May 2023 19:48:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 12:48:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 12:48:31 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 12:48:30 -0700
Date:   Fri, 19 May 2023 12:48:29 -0700
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
Subject: Re: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZGfSjYMA06PmaI+Y@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
 <BN9PR11MB52767257B1AC401121F3B24F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767257B1AC401121F3B24F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 65411883-5093-45cd-75bb-08db58a2103a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZucyivpXTxXVoKGnd4mXmcLFKYMxsxMRqdVM4ywVP1HbXjOHccSE9HZcb5AXrw253ECBRYBtUnDV3v7RiQ5AkXNMo8mCZ0WF8YLGqDsyDCFZ5tCWOnipnLmO9izElz4yCQR2w1p1/msAL6D+CzLqJ+TfKLSQGI8t2qG5o6pg02dRGBtKjorK2jjhyp94Tes2sl4ep5htGVuIjkN2ok447GvbEeJQXkhGh4zLQiIqZE1J5EIiKOlDDRJvMNyb45ZTCHPnXbd9sS6IboOBFkKwu71RSk0/qY2RSdwqL9Vt/7pyj4Dg14s+MnKIJDXAB08dZPgUL8gyewescSOXyw5kKRVQOw87gJahAltvE3kHs+szrl0toHgHDFJvoksdRJnEKrkP8wfJI9QLXy3AmoekzSyfJ4rNNmXc7EfGihBgbjxHMAhmmpG7fVnGZcKW2lXr7JicwxPSQTPTRquLfTFHZ+hYZFCY3YIhRP6AAwJzVCDef99xTNOgn5aShmQHcweWhhYRCQfYYdCot5pY9Wagi99xoD3UDdpupblccKyS5QxabNI/+ezTyKvnGxVsEi6Ywt6WF4YJVa7/9nntP3wuPhJWqci/T8lYKmJbI+hEKMJBrWpDMS6spQjBTkvXvlPpMJCiH6QBFer00EkXTHqtqf5dlGIfLbxePnveTq5rY9v2bECvJC4kgIemlRyC6edfyG/SwAQcM4j87kehYtRijR1ikzZ2Y3WGPrWNGWKYmIi7Ot5StXAnLxJNaPfYXiiTPM01f8x3PDo0e9DBV6TyGw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(33716001)(356005)(82310400005)(7636003)(82740400003)(40460700003)(40480700001)(2906002)(55016003)(54906003)(478600001)(86362001)(36860700001)(186003)(26005)(9686003)(70586007)(70206006)(316002)(4326008)(8676002)(5660300002)(8936002)(6916009)(41300700001)(7416002)(47076005)(426003)(336012)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 19:48:48.1395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65411883-5093-45cd-75bb-08db58a2103a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

On Fri, May 19, 2023 at 09:41:00AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Yi Liu <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:39 PM
> > +     if (cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT) {
> > +             if (!ops->domain_alloc_user_data_len) {
> > +                     rc = -EOPNOTSUPP;
> > +                     goto out_put_idev;
> > +             }
> > +             klen = ops->domain_alloc_user_data_len(cmd->hwpt_type);
> > +             if (WARN_ON(klen < 0)) {
> > +                     rc = -EINVAL;
> > +                     goto out_put_pt;
> > +             }
> > +     }
> 
> What about passing the user pointer to the iommu driver which
> then does the copy so we don't need an extra @data_len()
> callback for every driver?

It's doable by letting the driver do copy_from_user(), yet I
recall that Jason suggested to keep it in the iommufd. Also,
we are reusing the ucmd_buffer for the user_data. And the klen
isn't really being used for its value here. So, it is likely
enough to have an ops->hwpt_type_is_supported.

> >
> > +     switch (pt_obj->type) {
> > +     case IOMMUFD_OBJ_IOAS:
> > +             ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> > +             break;
> 
> this should fail if parent is specified.

I don't think that's necessaray: the parent is NULL by default
and only specified (if IOMMUFD_OBJ_HW_PAGETABLE) by the exact
pt_id/pt_obj here.

> > +     case IOMMUFD_OBJ_HW_PAGETABLE:
> > +             /* pt_id points HWPT only when hwpt_type
> > is !IOMMU_HWPT_TYPE_DEFAULT */
> > +             if (cmd->hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) {
> > +                     rc = -EINVAL;
> > +                     goto out_put_pt;
> > +             }
> > +
> > +             parent = container_of(pt_obj, struct iommufd_hw_pagetable,
> > obj);
> > +             /*
> > +              * Cannot allocate user-managed hwpt linking to
> > auto_created
> > +              * hwpt. If the parent hwpt is already a user-managed hwpt,
> > +              * don't allocate another user-managed hwpt linking to it.
> > +              */
> > +             if (parent->auto_domain || parent->parent) {
> > +                     rc = -EINVAL;
> > +                     goto out_put_pt;
> > +             }
> > +             ioas = parent->ioas;
> 
> for nesting why is ioas required? In concept we can just pass NULL ioas
> to iommufd_hw_pagetable_alloc() for this hwpt. If within that function
> there is a need to toggle ioas for the parent it can always retrieve it
> from the parent hwpt.

Jason suggested this for simplicity. As I replied in another
email, a user hwpt still needs ioas's refcount and mutex, so
it would otherwise have a duplicated code in the beginning of
most of hwpt_ functions:
	if (hwpt->parent)
		ioas = hwpt->parent->ioas;
	else (hwpt->ioas)
		ioas = hwpt->ioas;
	else
		WARN_ON(1);

Thanks
Nic
