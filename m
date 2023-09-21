Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFB7AA3CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjIUV7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjIUV6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 17:58:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E9373ADA;
        Thu, 21 Sep 2023 13:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg2CYPvR7t8XibpYE1eJETNwlPcnYVUrm15n0Cm32h6OqnmvUJy64HAToFW10h0SKjNAuLYJ1WQ+tcFKKOlsqLyv+t5YkddL5a3FOjAJz1KovVebYfXw9XKWDrRQh2bMVih/WLFrFk7NBTynILBSC1/hNAt4JcliFmonrADe2RsNntsd97CZxj4iWlo6hHs1x8xClQQ15i8psT4XJPX5wSeqI5Mh23HgqFNKKrQIalVoHWPhmRBwkzBpmlrIhOvvSRs2PffX5jiR0mkLzuIhhHUspC5BnFKJaQcEacq4+6E2xn+5aQeNjdFo/jnZDXG1Z2sUzw63rAFatfMxAI0Tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUEjex5AJf/d4KLWl0875UcjAlpgtjQ8fYIqLBL6Xmg=;
 b=nPQbH365n7zFVWRmcefHAPw3BayRVc3kVHkRqwk5cSdXZiBRsi0xdtueO66MLR2u/IpecuOfGpBskaRe9lg7/+H3yeVtcSqw90ta/kY4THoDcQjis5X1YhBVHAWcHgGFgC506bVD0MuXPhKNOdWa2XvvojSgLEovDIODuwuZeyJewdLcuVtyFLdfTsNZrS07hFqbOrlpLqErzB5PijdjDaZ5bq8e/EEDkrYvlOsQl/qPNVRSidYVPHzg8SsFs6w0erOoGHyQwBEJI5N7KSUEFFEbTVs7xY0np15RznVeWFB/PVSPFOSUPhNJ/enLO6k3VXmKRMKQyNSvxKG7T9i/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUEjex5AJf/d4KLWl0875UcjAlpgtjQ8fYIqLBL6Xmg=;
 b=SOyBYqe91JZagDvlL6Ctz7x4Qy/AM0Q5nyhdUoG55H4JhMJt2ZYZ0cAw/keQDbzJIXCqY5LsOXAHkZA/3+2LlHnbhJjbGbWbIoo9Wy3bf0aQ7fpNmjnnOgmAF5nSpp0AP8+CRacY3PaK/GcbQBXIbrMjY9P1gizDpQx3RK/fPVrugvnlpfmfMV96nf5eeoKz53nY+BhQGRa4+KWOwnhHTcrvoNHXawkMKBTGOSb3HA6biVs5S8WV6x10qKoZ7edhFo1K/vlgub7+eNe7ZX1XyEfw1jyLweVBNdbxp/xok+lVyWLLpuqRM7KbDG2mGuHtQetfUmcuAF6WL4yqUTLCKA==
Received: from SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::9)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 21 Sep
 2023 20:58:35 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::47) by SA1P222CA0161.outlook.office365.com
 (2603:10b6:806:3c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 20:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 20:58:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Sep
 2023 13:58:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 21 Sep 2023 13:58:22 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 21 Sep 2023 13:58:21 -0700
Date:   Thu, 21 Sep 2023 13:58:19 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <ZQyuIQbyVk9p8C8o@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 580382fb-957e-4964-85a0-08dbbae58522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRxDg9ZRcm7kUUJVul3p89WhGhgSixd6IzzjGEDRoT/0jjXnkQr7IdRtxkkh4eNiRmvW9eWnyKSwtOJe5u+EQssKAh0Y80FT5qC1quKN0BSQXvqA9HYYvonOgPpQAD3U+Q9F6H8AyEwF38iz//lxzifYjPQ5XmkAiYZa4lRNW7MGnixHxhyOM+ClzsETbBUsz1DUP/zARK2FwzBR2m+CWCuSTvgMme/G0SxCKI1xgr4ruouESFlkEIRpIAmkRQj2Ou1CtZH5g19/HHwm+xkqDHwHCm5bqc+GC0IgzDO7n76v7PyyS+/GVwv748ux3nerqk0sHaryBGDpB0wmEm2tBhgj7iVkqGBzLIpp3CCKi/MFZYPHDrpvAteialhpjjwLIAbPKXacPNasBrfHqYWob1Zuby44txAAnb+BLRZzoWyXIpWa2LXwbNS3IhpqRColzugRkD9RMcC7pyISIRjP5S+ewcyAXBsrBQljvczibWAUkDTTk4vY6jniOddg14yZMZ2dlYnMxUAr6MChx4zasgjoX+OyiPMJLQow0uNjNrGU1+PgUgqF1DH/P0bHNPGHfh13XF4UfPGqz/BapnCkvYVO3087DdJAwGrfYSjGoOvoGbtcNelCkkvkLSxgksBFAU4lLAWz69KbZLZWEL0uCaZ4neUYGMUh9vyQh6vIOSzAWg5TGcDG14VweZS+eaGxFs/Yhz83qULqsrOp0s/WcaCjViY+vIXW0L7udWaAG0C7y95tB8dgZWt1RDrqagbew4Yj23YDOeaOHydzov2Dng==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400011)(230921699003)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(66899024)(356005)(82740400003)(55016003)(7636003)(40480700001)(40460700003)(33716001)(86362001)(478600001)(6916009)(54906003)(4326008)(70206006)(2906002)(316002)(70586007)(9686003)(8936002)(5660300002)(8676002)(41300700001)(7416002)(53546011)(47076005)(36860700001)(26005)(83380400001)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 20:58:34.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580382fb-957e-4964-85a0-08dbbae58522
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 08:10:58PM +0800, Baolu Lu wrote:
> On 2023/9/21 15:51, Yi Liu wrote:
> > +/**
> > + * iommu_copy_user_data - Copy iommu driver specific user space data
> > + * @dst_data: Pointer to an iommu driver specific user data that is defined in
> > + *            include/uapi/linux/iommufd.h
> > + * @src_data: Pointer to a struct iommu_user_data for user space data info
> > + * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
> > + * @min_len: Initial length of user data structure for backward compatibility.
> > + *           This should be offsetofend using the last member in the user data
> > + *           struct that was initially added to include/uapi/linux/iommufd.h
> > + */
> > +static inline int iommu_copy_user_data(void *dst_data,
> > +                                    const struct iommu_user_data *src_data,
> > +                                    size_t data_len, size_t min_len)
> > +{
> > +     if (WARN_ON(!dst_data || !src_data))
> > +             return -EINVAL;
> > +     if (src_data->len < min_len || data_len < src_data->len)
> > +             return -EINVAL;
> > +     return copy_struct_from_user(dst_data, data_len,
> > +                                  src_data->uptr, src_data->len);
> > +}
> 
> I am not sure that I understand the purpose of "min_len" correctly. It
> seems like it would always be equal to data_len?
> 
> Or, it means the minimal data length that the iommu driver requires?

Hmm, I thought I had made it quite clear with the kdoc that it's
the "initial" length (min_len) v.s. "current" length (data_len),
i.e. min_len was set when the structure was introduced and would
never change while data_len can grow if the structure introduces
a new member. E.g. after this series struct iommu_hwpt_alloc has
a min_len fixed to offsetofend(..., __reserved) but its data_len
is actually increased to offsetofend(..., data_uptr).

Perhaps we could put all min_len defines in uAPI header, like:
include/uapi/linux/gfs2_ondisk.h:442:#define LH_V1_SIZE (offsetofend(struct gfs2_log_header, lh_hash))
In this way, drivers won't need to deal with that nor have risks
of breaking ABI by changing a min_len.

Also, if we go a bit further to ease the drivers, we could do:

========================================================================================
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 65a363f5e81e..13234e67409c 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -147,6 +147,9 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+#define iommu_hwpt_selftest_min_len \
+	(offsetofend(struct iommu_hwpt_selftest, iotlb))
+
 /**
  * struct iommu_hwpt_invalidate_selftest
  *
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 117776d236dc..2cc3a8a3355b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -263,8 +263,8 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 	}
 
 	if (user_data) {
-		int rc = iommu_copy_user_data(&data, user_data,
-					      data_len, min_len);
+		int rc = iommu_copy_user_data2(iommu_hwpt_selftest, &data,
+					       user_data);
 		if (rc)
 			return ERR_PTR(rc);
 		user_cfg = &data;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fb2febe7b8d8..db82803b026f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -282,6 +282,10 @@ static inline int iommu_copy_user_data(void *dst_data,
 				     src_data->uptr, src_data->len);
 }
 
+#define iommu_copy_user_data2(dst_struct, dst, src)               \
+	iommu_copy_user_data(dst, src, sizeof(struct dst_struct), \
+			     dst_struct##_min_len)
+
 /**
  * iommu_copy_user_data_from_array - Copy iommu driver specific user space data
  *                                   from an iommu_user_data_array input
========================================================================================

Surely, the end product of the test code above can do:
	iommu_copy_user_data = > __iommu_copy_user_data
	iommu_copy_user_data2 = > iommu_copy_user_data

Thanks
Nicolin
