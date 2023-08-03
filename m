Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8D76DDD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjHCCHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCHb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:07:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F0135;
        Wed,  2 Aug 2023 19:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWDYULgDpM9XvRxUtdu0/ViENZWHI/Gms3IaHrRe8hC/CT7hR59qPM8eHSpFfFmtgt1Go2LOBkzXCK9Z2XSva4Dzp1by3+0qizviP731AM35sod6azIU0Efk59rHhKkbd9R+qFq8h02kp2lj05HbroP8Si2TRE5mE7GjkJyf9ytFlMKSXNmb5M8scnkAG2Q/70GD2SXqeVoDjWk5rx3prWYJTSVFlvFw/15Ab95NAcsl+GQuIMy1RCgwHsC7tEeJaEZ/0+r1t13HAGuPh1h3862cUhTBSWYvA8oXTFuC87RhKd1Pd0Bm8hznGrY+goEB7cq5OASp3SNN3h44A7bRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlIa4Z/V9Tgld7z4WRYq33OMLj/vdzfkNgndpY1xryY=;
 b=Y9Qu24DQCvlix5bL7y+mhGYaKYRS3C3s3qp/GBgraydlArEW63Yua79WLDO7lRBMsvQ3351xAbm47na5VvzJr0s+FVIZxOTvQ8kYoNkDfoqoYNBRTnJFN4AXjKuAt13bP6Tr3ggSxGPvw2H+vZoWMzENWWvorcRa+RwNVUbnEj9AODUpDUFeNdriFkJE4SQRkyNzHiIXJxwyrD1EkuOV1o8Q7SJMQb5pQtEN677ZLm+l0YqbccHuoQNQVqxQg7g9YTAS1oyL7zpj9jk0dNSlWj0uaXCUEefRQufQ0427JirOP29ZQo1SA0laOCWs0b9JzL/uuvkmNrOP/5IoKtc3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlIa4Z/V9Tgld7z4WRYq33OMLj/vdzfkNgndpY1xryY=;
 b=OUzlF+1d+3I1DTxw3HWbnzp9Xn4S9uF5CcDrbuoZ4OO7BN1Qwy9y6+E8UmgtqhSituPLSQDCpoPMqrFATedMaQ82fUaPhqGnveZZz0TxfZCu6MoDiqGnedA6fBnlCMJ15L/T80XGgq8jAHOi98AmEVE32O1ky3vBglS50NsqQl1uCKjkTWQ/rP2oEHWE6Fj27hSii7EdO3AZmdtLqd5FdWKI4YHRRIR12+lB036IdeV6oRiFHvA/zo6tSG02xPBGwJH30bUp8BYU+ia9YCKvXTolEGCAkF3C8gc1zH3bWHKEnFWlRBVEKrd4vFvxxydEvVxXIycCXcDRuPxrmYTCow==
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Thu, 3 Aug
 2023 02:07:27 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:5:14c:cafe::61) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 02:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 02:07:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 19:07:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 19:07:15 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 19:07:13 -0700
Date:   Wed, 2 Aug 2023 19:07:11 -0700
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
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZMsLzwfoiybMXjtD@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com>
 <ZMQCw2iiIqa4CXNG@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMQCw2iiIqa4CXNG@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: e264d200-b593-4955-fe57-08db93c662b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oonge00JV3gSX0FIv/+HA6yLU+AEy/TnbW09CC2H47fsjxE4IqA0vg6vuThDqBCYOVkivolG7X9/P4QB322GxsfIA8PViBDoKNMGjE5FVLDBXqSmOgi8tKmt+dJhKouHl7WzIGQb9DpxaY2Pb0F2zPAOch94xbXm22rRDPR1VNJzHq3PjTy6wIGuflwFiOdW95vfGeV9hQCWKAfC5cGwYuIzz+RVFwlhRlehw8o0zARn3uim7sGFrk+bS3FV+dyxlpJxE6kOjCqJMEIV1B2js1lIvHA7GxUZr3uSuZxpC6OSleQ1J9oqqsGhSIkxy8m0xSsEkv+li/G+ytsGWkKW6+SU2eClPB0Bh6thu4mVtKBJPuSfEhLn2232Lcwdxv1IdKHWozdZNVDeY1OFE+Powy78LIsJFOQ8Bs4xk6eTlz0ZEXenfrnsd/2RfeyCo5WXDv/mhf5vOOQ55L/zxpiF2JE/TF63Ip4aR1rt6pCvA/zsu0RrRysQrz6u2DY2kSMvIyvUIPFCS4hfw1wcmoD2+r1CGAQgXMI82/0msY1ChffBgX3dOzlDC/LTZiUDRkKxHA5Ewr930+MCGWSh84g/htDqlLiboawEW9o5XS9URhzqZ6gqrt/m2+CXKb8o7RSKObiocoiFCe1gIyYLhC4hp+aMdRJ7NO5iJX5kchaZySA+hxeSrNMsNsHlbrbiCgkFdpI8GCPWi1Ki/gO6CDbVRrhoLWs7Sw4MMxeRWybcPvA3/f/ZuTzJi31fb1RrKhIm
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(86362001)(316002)(6862004)(8936002)(6636002)(4326008)(8676002)(5660300002)(54906003)(33716001)(7416002)(70206006)(70586007)(7636003)(82740400003)(41300700001)(356005)(478600001)(2906002)(47076005)(36860700001)(9686003)(26005)(83380400001)(186003)(336012)(40480700001)(40460700003)(55016003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:07:27.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e264d200-b593-4955-fe57-08db93c662b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 03:02:43PM -0300, Jason Gunthorpe wrote:
> > +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	u32 user_data_len, klen;
> > +	u64 user_ptr;
> > +	int rc = 0;
> > +
> > +	if (!cmd->data_len || cmd->__reserved)
> > +		return -EOPNOTSUPP;
> > +
> > +	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
> > +	if (IS_ERR(hwpt))
> > +		return PTR_ERR(hwpt);
> > +
> > +	/* Do not allow any kernel-managed hw_pagetable */
> > +	if (!hwpt->parent) {
> 
> I don't think this is needed because:
> 
> > +		rc = -EINVAL;
> > +		goto out_put_hwpt;
> > +	}
> > +
> > +	klen = hwpt->domain->ops->cache_invalidate_user_data_len;
> > +	if (!hwpt->domain->ops->cache_invalidate_user || !klen) {
> > +		rc = -EOPNOTSUPP;
> 
> We need to get to a place where the drivers are providing proper ops
> for the domains, so this op should never exist for a paging domain.
> 
> And return EINVAL here instead.

Fixed those two above and added the following in alloc():

-------------------------------------------------------------------------------
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 08aa4debc58a..7ddeda22ac62 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -123,6 +123,12 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
                rc = -EINVAL;
                goto out_abort;
        }
+       /* Driver is buggy by mixing user-managed ops in kernel-managed ops */
+       if (WARN_ON_ONCE(hwpt->domain->ops->cache_invalidate_user ||
+                        hwpt->domain->ops->cache_invalidate_user_data_len)) {
+               rc = -EINVAL;
+               goto out_abort;
+       }
 
        /*
         * Set the coherency mode before we do iopt_table_add_domain() as some
-------------------------------------------------------------------------------

Thanks
Nic
