Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45C696193
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 11:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjBNK7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 05:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBNK7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 05:59:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33239ED8;
        Tue, 14 Feb 2023 02:59:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2f8eHEulqUV+vFf3sm6oi+TRRH1T6auyACizgn42SPVr/BGBSBbUT0aPS1ZuAKEdNWB5kgOfJAKAQpPvJe0KYzqUDF8CJ70XmaYsLZ+/CZ4fYqkEyvHpppLeoCcD4FZtS+lrfrIteBsIdmytIHye/R1s54P5DXvRMlPHLbodNYRNCpSk1rEDXBggwLRSIFcKk1BCVej8hIFJpHSU6/MQj6HxVQAAQU35k2jNnQ0GrHUUWqL8x5NxiinS5o2pLRI6bF7fZBfj4QdjSdV15kMKCkg48O/SjTwdSdG2ljCnAAizzmk4ApLGvFlnipmUzUrPowBgpFw87NRaIaXyjdTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fPX2A7kQWYVtVadkmJB4zZhLhPOkPyChPFaoQxNZ0A=;
 b=VxVskvcK3VxuqUT/BIoMbeQq+ZDX9RXIykKNFMShhUelEOnKO2aN4xUFVAcUsu9E+gedFdwjZAWtJDgQ2d+Bl5WjW/B4PYsIy0lcxj0GbB3YEJjI+ce7cCaS5Oz5YGPLrpl7kJibaBFC8iIXCLlgcVoORzRhcYeez57FiFelBuPcFcxPnca5hCygi0q1BlcxQCwZVn+WZh1ijbJeo/qVZoXe/dpk5wPugVHXoVqooFNfUjAfxorbXHuRVUZqxjA0rSLlVzk0tYP4k88NKjdb0VJ3cqIHY6DUfxpExSMrodrf3gg67pmwks4iC5M+jNK1BaCO31UmuairXKh+gtcfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fPX2A7kQWYVtVadkmJB4zZhLhPOkPyChPFaoQxNZ0A=;
 b=kBctSnpb245sMr5C/VxU9wVbMIhMWl7egQswn6FaNyC6y5YK3jyEBC10FkMGPRASAsRC8heipY3/5f2OLppPK5dvmJLehC0JTNQejK66svhIpJrrrDEgKT1JZYhOE3n5pn6wZSjrcfo8+w+Z9JAaQsVKDD9wMd0Wet+FN95rn30P+KmgyC5efqxwaXij6qcDiQJvZe8GwYR/d3voVP8VW64IYsXCwV1tileH7mnU/bhidvxxCFIESGV1gejrm8HBwmTHKNJ8cwmCQ1XI9lTg3gc9JkJzP3+Dyva8kb5nuCAd5tPlBYbn+WVIKhtAe+M10CxRx3/2ejuFew7W6DYs4A==
Received: from DM6PR02CA0166.namprd02.prod.outlook.com (2603:10b6:5:332::33)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 10:59:32 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::25) by DM6PR02CA0166.outlook.office365.com
 (2603:10b6:5:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 10:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.8 via Frontend Transport; Tue, 14 Feb 2023 10:59:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 02:59:32 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 02:59:32 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 02:59:31 -0800
Date:   Tue, 14 Feb 2023 02:59:30 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+tpkpNYil3duTIP@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b77e759-e524-47c0-6274-08db0e7a8d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QBCsZeABtFR+8fHv0RA5nvdgyE8hmyobE+ujpDxM7Qh1+bl2qdpK4RnP9/GvcpZaPeGnxOAwX/3STUFdQ2ENdMtk0IFmEQvyc6VaVxhf24grb2p4RZxCMZSWzJgRBXc2/wTlcLHi2Eex3CvHbjwGvTNoMT7vzxAuBjL6nwYo4iP4dh9wF3OWQa3OVa0mOGy6eOwLbjdcXDqn0J6xqdE8tey7dUyT39eJLui3B85vk4iaaq5pOulurdXoCDaW4MoXPJ4fKay4qDyR6A3JmohO6rR88DGFI5K+eGvsLVvUQ9SblzhDG3KZGAyBEv61EWTsEpnjXEyc3MDhyW3inkdJMcALDZRF1VgsI/ITzSYM+7eJSM9sm3k0T/QaYmmNu92y5cMWjBYII9FBUnmd6NqVU8xggF4xs7dr08ECiTUhfpUSnUokbofkjD7itvM/U/exQZeYBggBkJkxMX4JRczxxnS/VIHlOynF0hNFewAbVicPhnWpZjc+Yk1ceSwzsG/Mhl8DChckJPDcYvYK62pYNShS0GRwOI4s7VXnS+TZIpf+DhWoYd6cyUkirJKetp6C5kFbFRCzB+/SVKW+5mC740AVbcDuWM3g7Rno+casvZ3q6cHDa21BUFvQuDROC8zEAQMsgNyFZ69nokZOwer52VW9w9pty7S//yYqjFbmAKpqnBtQ5+XlXVE9DjDvXxg62bU5bjB/NakZOkDFo0xv7qkwjItLYlKB86Of1wLsBI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(4326008)(41300700001)(6916009)(5660300002)(33716001)(70586007)(70206006)(8676002)(40460700003)(7416002)(86362001)(40480700001)(478600001)(356005)(55016003)(426003)(47076005)(7636003)(2906002)(336012)(82740400003)(316002)(82310400005)(54906003)(83380400001)(9686003)(26005)(186003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:59:32.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b77e759-e524-47c0-6274-08db0e7a8d9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 02:11:23AM +0000, Tian, Kevin wrote:

> My confusion is that we have different flows between detach/attach
> and replace.
> 
> today with separate detach+attach we have following flow:
> 
>         Remove device from current hwpt;
>         if (last_device in hwpt) {
>                 Remove hwpt domain from current iopt;
>                 if (last_device in group)
>                         detach group from hwpt domain;
>         }
> 
>         if (first device in group) {
>                 attach group to new hwpt domain;
>                 if (first_device in hwpt)
>                         Add hwpt domain to new iopt;
>         Add device to new hwpt;
> 
> but replace flow is different on the detach part:
> 
>         if (first device in group) {
>                 replace group's domain from current hwpt to new hwpt;
>                 if (first_device in hwpt)
>                         Add hwpt domain to new iopt;
>         }
> 
>         Remove device from old hwpt;
>         if (last_device in old hwpt)
>                 Remove hwpt domain from old iopt;
> 
>         Add device to new hwpt;
> 
> I'm yet to figure out whether we have sufficient lock protection to
> prevent other paths from using old iopt/hwpt to find the device
> which is already attached to a different domain.

With Jason's new series, the detach() routine is lighter now.

I wonder if it'd be safer now to do the detach() call after
iommu_group_replace_domain()?

Thanks
Nic

@@ -196,10 +198,41 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 	return false;
 }
 
+/**
+ * __iommufd_device_detach - Detach a device from idev->hwpt
+ * @idev: device to detach
+ * @detach_group: flag to call iommu_detach_group
+ *
+ * This is a cleanup helper shared by the replace and detach routines. Comparing
+ * to a detach routine, a replace call does not need the iommu_detach_group().
+ */
+static void __iommufd_device_detach(struct iommufd_device *idev,
+				     bool detach_group)
+{
+	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
+
+	mutex_lock(&hwpt->devices_lock);
+	list_del(&idev->devices_item);
+	if (detach_group && !iommufd_hw_pagetable_has_group(hwpt, idev->group))
+		iommu_detach_group(hwpt->domain, idev->group);
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	mutex_unlock(&hwpt->devices_lock);
+
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+
+	idev->hwpt = NULL;
+
+	refcount_dec(&idev->obj.users);
+}
+
 /* On success this consumes a hwpt reference from the caller */
 static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
+	struct iommufd_hw_pagetable *cur_hwpt = idev->hwpt;
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
@@ -237,7 +270,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	 * the group once for the first device that is in the group.
 	 */
 	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		rc = iommu_attach_group(hwpt->domain, idev->group);
+		rc = iommu_group_replace_domain(idev->group, hwpt->domain);
 		if (rc)
 			goto out_iova;
 
@@ -249,6 +282,10 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		}
 	}
 
+	/* Detach from the cur_hwpt without iommu_detach_group() */
+	if (cur_hwpt)
+		__iommufd_device_detach(idev, false);
+
 	idev->hwpt = hwpt;
 	/* The HWPT reference from the caller is moved to this list */
 	list_add(&idev->devices_item, &hwpt->devices);
