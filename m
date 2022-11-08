Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD31621A23
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiKHRKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiKHRKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:10:17 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40C1D32F;
        Tue,  8 Nov 2022 09:10:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biiJOePkxPPsyTz6q6pTT5Nc3bc8ndIyvvqwtUNUqn26xM0Lv9a9AoCNm8jdxpeeJGvbCfv7ORL/HqSrz2OncxuU7076+BIdreNWknGhQthkjZHA7heLcYvyuapXoyN5Cc1WiyeX5AAtWv3GuI9h6/c3QcsQ9X4DXYWXd1h0TQm3t8VE9LkhK2k75HrfSnRMnOr9oWW4Dampz9GmXyPsE73DYfHPyVnnerH712du9S9ZOT0gTmq5YFsUvIdOt75M7qh2hNDCKwWSOOx2OVr1E+o4bzQuHNo1bjdo4/YMOWQdJQznb9ntm+ondZFurxOpjl2o9cpecs9mDJq8chPMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX2vjXDRYbf/HO5x/Cg5em+CyjB6l/I5VC9dQjlVnmI=;
 b=MuFvgrDwd8bg3lS+CSz9ux7noX3P9MF2Yr4Cp5eBmnso/ofSbVjUX266hiZNYMTPqcbT6r1Iml/aednWGzoiu7RDyHoxSv67FJAhb+3LY7rxYM2nROzYSiyEIDLboO0MXcbh6fAeYJCOtav8xSCmPFZDuUhcDEFna37ahNTLrQR/U3kcFwuhYwwDIrAb7rH7Scx/hkNufhIeUwuq3/CFRtJGG0xWLEoRvHb+DFYOc1CPLVWiZvijW9DTmQpgA56e7Ln4DJQdurArqoZONkzfcSPLsBRrrq0mRnxdb0M3LrwAz6erO2grCLBYL6ubc0xuf5LD7U61S6wl0mftW0/Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX2vjXDRYbf/HO5x/Cg5em+CyjB6l/I5VC9dQjlVnmI=;
 b=bqI2zzZyeMryON85KClzmAEjL0o+ggKWVdcvwBSmCslZF/DdfqzXSEFen0KpHThGi6vL5kwLXxerTFu5l8T+BNNjjwUaaITwwSgCyhkqz7bEjjwfc3WQBg1/mKPQktFIy4OyO/wLqcPUOrrLCaDBap8R+sNRh/hAMRWylwt2A9pPBIIRsT/ZIfaDw8vXMKrkWWa++YSX2qQeKDx7trHZbgt4+rN4O0LN5PtdgsisJ5s7DUNCu1uYTd/wx00khwR5+1ATmLxhfOTD8jh86h4PuV55scMKAfppt4ob7I2MOfsF1EiegcuyH4S4IW+REL+ZtIGx/GUSe1x5UxOuxJ6SjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 17:10:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 17:10:01 +0000
Date:   Tue, 8 Nov 2022 13:10:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 4/17] iommufd: Document overview of iommufd
Message-ID: <Y2qNaNfpBG3dcBV6@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: cf21d261-4eac-41c1-fac9-08dac1ac128c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAqhtA40JqM7dpYXzs8MYcwpyyeJNpR/hqRj3HEG4ulBRvRF4FkU6UhwoFV7B+udwYEFgSWBK5tmn4N5bdZzr5p+rsdDn9hJeez62tLMcxbW8fDCkF2/2A95jm8dvSLZM4n14g//6qA1ArJzGIN9vsniDBjzr2v0tY7+IUVKWgeEqUc4EI1ztdYfATna/saWAOMxg/3BzcGrB/oznCLE6VC7XnkUsJBV/JfbQ+L7CSDiflqdsZcB5Wl3EiG0VCM0b4/OGl4o+1H/5HodaD2eNMTyYAH+YY9oQVL2e6BkvqJJL9lP23m5CKWmCV7h8BSAALvnoBz5tsFierAkk2DMV97T9XJS/UENPoZ+1PYbGfpgY2tUJ5UxDl2l+afBDHq52anzVBG8Jwk3DlBCWPCGoZj7PwzV3pnthl3IwfolWeRdl4dg0KhGMBzDijYOagyQKnGL5XvSdXVH9eE/VyjtktjfzwoqhrXFHAxkvE0+Z6nmmXi0XUN3FXX6YZiP+TymDGAgdtB5+JVDIJah0aBtpZ+mPaLWrHQu8P0hnCZFQjqyu5ydPL7WhtHtHn9ddlc3SrfjYEnWqN0t9bTSgDZ/D76XDRpRVHCwpzY58XNHyi244SFwr+q7/vNRCvh88UvZHpxcKq3jb9El6o9BdcKkU1UgBBvW7kOuSi7ImsDu1Q8Nr00dyEWX7246ePeOPcVd+gm/6wzUpcit9LL9EmtkmYq8gP7CsXxuIRzYpDbCGikv6ESvLzSHGE9YbXHcxAUybeS173RBDDl1KPlU+URlVirJtzC78FvTpMxvJKkGJ3uH+dy6OwXMKk30tKn+TUaQKFy9qf2kRHfTWNqPwMy0DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(2616005)(186003)(6506007)(6512007)(38100700002)(83380400001)(7406005)(5660300002)(26005)(2906002)(7416002)(4326008)(110136005)(8936002)(966005)(316002)(6486002)(41300700001)(478600001)(8676002)(66556008)(66946007)(66476007)(54906003)(36756003)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbJqDZRQPp2rCBfNyDRKWfPS6zGuvKogs9vfaBfitTjjnSx5sZI+zeqIodL8?=
 =?us-ascii?Q?71f62UGO7teEx2ZMLMPMwL6nQKWYHDz5Y7dG1B5b9ybXAciiTe8FBBVOiP0l?=
 =?us-ascii?Q?lRa6SumBczjp7st+GRRcdGhBhnVTmEq61+XBbLAQAfb16jl3M3LdhN7R/qC+?=
 =?us-ascii?Q?nteQ/iLT7L8wjmwzdmItJBhG3IujGafEDA1lDO7jXVrCsyAfAVe+QXSZ+oou?=
 =?us-ascii?Q?660foGWFknIlyNzWW5WM5gB2MKMb6xkYOC4J9mQjXlLID/nFjF+Cmy8pDUfi?=
 =?us-ascii?Q?aEucak71DGonap94iUHgFXUpNMDcTgL+4ZqTSwiqjtSAMcvPgnmdBYr/OJ+j?=
 =?us-ascii?Q?KYJNWgCPp4apW3HuVEtotd9RWPHt437DBdi0Rr4Z73iNi2e1A11lVCldRy3y?=
 =?us-ascii?Q?tCETOneg2YJiXZ//NZ6jTy6l7cFma82AXPFt4CO32k53bduYiamd/QNlvm8T?=
 =?us-ascii?Q?qxF8TStaLcoR6HFQDrx5XWWIJFlPrBKR+FKASHZ6TOOuLIQJAOOoyKRFOVWk?=
 =?us-ascii?Q?sUAp3eM/a1MyerpNGrOP3Q0ZZowfd+eEi1d3jrVyh2yf7PHYaFWT/YI2haWc?=
 =?us-ascii?Q?0zX+gLsodBOXFtJzSAaz1AdD7xH4o3Wrow0gyBfsZMYmbXINVE32neFdHFuz?=
 =?us-ascii?Q?iGr/tzlyDBFX+1JEUR+qw9z9kyneIMtA0UaIW4KpVE0vwQYyscRIsbzfhWJc?=
 =?us-ascii?Q?eW6PDUH6qsYgaVgTWwRI0AKlN/9yUA1VtItheo+FVsGdrTI3LyzUBlTaIIWq?=
 =?us-ascii?Q?1kV9RBZi68PQGuueMGQcd0oeG4bqGoe4ojWwQ3YSHUNV20+/RJ877IeCgEhZ?=
 =?us-ascii?Q?ms8k3dMpCIKBA2Gd8vX4ENjJ56Mq3hTPsalevHLC8/EKO0kQkCR+NH+w3vfr?=
 =?us-ascii?Q?AL0f4reGXrRK0U6vb67Nywyd9XKARHVCZkwEFX78tQUfQ04hGAooQyJTl85t?=
 =?us-ascii?Q?wfUM225zgdYCl9fhLHm4pGs8uLUPSfyDjYACw4KU9eph+USKW3FZsxJPkgoZ?=
 =?us-ascii?Q?Q2YM1V9fTJBg0GZ63DWiwmOW5pJofHY7NIZyK/QXHdkVb+9/XawjFdvJDLtj?=
 =?us-ascii?Q?bPYOWrXkQJ6yxTV1HHrRycVukUA/fgWqPwxSe/v7IaN++Qmj7o72erD+aRpr?=
 =?us-ascii?Q?dm2a8l/M7e6+mvAbzvJ5B5bTMFLuungWOKXKWx2ebF3/0A2cLfq3Gj4nZQ3i?=
 =?us-ascii?Q?ZDUX9ZypJ3ikANtVlsJ2sNRD0pUZAh3WUUfeYYvJgmbAyIusnM7iKvwWd+BD?=
 =?us-ascii?Q?JxcqK9xf5CSW6U7HEXUsoc53BVw6MuhqT/HV5zE6WCUwLSPV0c8BOTAfYX4G?=
 =?us-ascii?Q?Di7yxD8VOVj2xU6f5xNS/qd+e/dBaRVrG+Toj9Tz1cEBHnl1xFwnzmKDIHsH?=
 =?us-ascii?Q?8QwCcJGfYK3QE7dkojMzqzDWN+pZamJTjzbHujEaFqx8Qd9Hy0cT0cSc5add?=
 =?us-ascii?Q?l9fRvFyEr/u5l5kkx0nHzjoL0r0h1E8A945zr6vb8ZBBmX0coj46jdwAdB4e?=
 =?us-ascii?Q?Ip/KWxlCijUmi3iecaojUFYIlYdh0nOqYvbefmhJ0B4udiPDzS8xlQvD07/T?=
 =?us-ascii?Q?PFrNJuHeKQ944r8Lckc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf21d261-4eac-41c1-fac9-08dac1ac128c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:10:01.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQfJxCvEXmDvlm8uiJT/UCMFVWGq6WwVPneoqJ3b3yTBkq804XMSbmByimshOrq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +IOMMUFD User API
> +================
> +
> +.. kernel-doc:: include/uapi/linux/iommufd.h

I noticed this isn't working

It needs this patch:
  https://lore.kernel.org/r/0-v1-c80e152ce63b+12-kdoc_export_ns_jgg@nvidia.com

And also some updating to capture kdocs for all the exported symbols:

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 64a135f3055adc..ffc5f4bc65492e 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -186,6 +186,9 @@ explicitly imposing the group semantics in its uAPI as VFIO does.
 .. kernel-doc:: drivers/iommu/iommufd/device.c
    :export:
 
+.. kernel-doc:: drivers/iommu/iommufd/main.c
+   :export:
+
 VFIO and IOMMUFD
 ----------------
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dc3058e063d8de..8f4a0e11c51bae 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -107,6 +107,14 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
 
+/**
+ * iommufd_device_unbind - Undo iommufd_device_bind()
+ * @idev: Device returned by iommufd_device_bind()
+ *
+ * Release the device from iommufd control. The DMA ownership will return back
+ * to unowned with blocked DMA. This invalidates the iommufd_device pointer,
+ * other APIs that consume it must not be called concurrently.
+ */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
 	bool was_destroyed;
@@ -372,6 +380,13 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
+/**
+ * iommufd_device_detach - Disconnect a device to an iommu_domain
+ * @idev: device to detach
+ *
+ * Undoes iommufd_device_attach(). This disconnects the idev from the previously
+ * attached pt_id. The device returns back to a blocked DMA translation.
+ */
 void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
@@ -412,6 +427,19 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	refcount_dec(&access->ioas->obj.users);
 }
 
+/**
+ * iommufd_access_create - Create an iommufd_access
+ * @ictx: iommufd file descriptor
+ * @ioas_id: ID for a IOMMUFD_OBJ_IOAS
+ * @ops: Driver's ops to associate with the access
+ * @data: Opaque data to pass into ops functions
+ *
+ * An iommufd_access allows a driver to read/write to the IOAS without using
+ * DMA. The underlying CPU memory can be accessed using the
+ * iommufd_access_pin_pages() or iommufd_access_rw() functions.
+ *
+ * The provided ops are required to use iommufd_access_pin_pages().
+ */
 struct iommufd_access *
 iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
 		      const struct iommufd_access_ops *ops, void *data)
@@ -461,6 +489,12 @@ iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, IOMMUFD);
 
+/**
+ * iommufd_access_destroy - Destroy an iommufd_access
+ * @access: The access to destroy
+ *
+ * The caller must stop using the access before destroying it.
+ */
 void iommufd_access_destroy(struct iommufd_access *access)
 {
 	bool was_destroyed;
