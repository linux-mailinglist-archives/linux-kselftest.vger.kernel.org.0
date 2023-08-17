Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231C77FF86
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352598AbjHQVIm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355211AbjHQVI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 17:08:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592B30FE;
        Thu, 17 Aug 2023 14:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cofL+tLE4PPK58M48uT3ITcjfR+6n9GfB5k2yLJR/6AYLPFzsQtZCT/bydVijczg4zh7NYE4YFR2Kez6r6oJuonJ6DHzloawKRjKwqb/RYNLrNkFgabPlQwKapnwce9BbB4PtLvqnxO+e5vpy7871FqXGKR9XL4PVIomgyRjRXHgbZoPNiOMODdpMdIXSZGRVO3/EbLuzHE/bFG8zDE5L7fB0lxITtlbpWiIjjqGdhztMkl5l+WSVO8YA3O0jcQ/syZtXhQlGknEanAKxgxt6Spp31cSK1T/LjuDfMCAfBkbdR99vHWIDYIk6vXkbD+jPDPzMflxehvAHErO3mnNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNiQBu1eiQX92+Hz9iwKaJK+rwZkZoYeRyX+9bci9Hs=;
 b=C/7MLyzO/QkwaQSuBcuPMdu9EU30hPJG8tbO+GWFXR3rMf2TmACjBkGLXLxV57wOMHxi1QjmeAINyHvKiZF9U2p/HcoiozkAvvmyOLVP+fW9T7hX5Y6sYA3JZ244gvfY0ddE1nrNuFdaW6puCsS3Jnzy5NhmNMZL4NTL9JiIIy9CdJr3ZHnIZIRylAMT3y5zLkbJzAqs4nHQN7Y0HgOwINE9TSSwbisB9+JoXmKXNk3famnen92Bbn/LdAiE5zwZVojX+8GD9IMf9585YLQx8/UsZXKhb341fCwi7F5b//rqMCM01DN5bEiJME0csKMdDkx0JGLSUeuFOA8MEoeJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNiQBu1eiQX92+Hz9iwKaJK+rwZkZoYeRyX+9bci9Hs=;
 b=KfRYC2vI/7H8T+Fh0TFhK/ViWVFPLF9yPIUwmoAhZGIgKUK+Uhm9dvn8P6kIeGhM+UxVfmkoCOcMH8VZlEGNzT/dAUuNUhICL81C0bfNF3zAwWbZKB27p5sBYOU0RAzUONSqYucozKO4DFbcfnfFqccgL6Xl5UwbsLfFsAlLdoOTHR3AVOXxPHIne7MDRpvNxH210lmsk5DujKGyN+LbznXuPinkA8tkySZI9FuMb5vZWOUGDNntVDWMxWaPYrbyffjZi0AMUP08HmRHVhZnI5+ee7uHhxoz/7R5lrrkjNHbgmboqZ+Nnvs19OhwoOglHqp3o79RtAlBxoldoz+nVw==
Received: from CYZPR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:8a::6)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 21:08:06 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::9c) by CYZPR10CA0002.outlook.office365.com
 (2603:10b6:930:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 21:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 21:08:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 14:07:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 17 Aug 2023 14:07:56 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 14:07:55 -0700
Date:   Thu, 17 Aug 2023 14:07:54 -0700
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
Subject: Re: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
 <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a43c977-307f-43bc-496b-08db9f660d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgE4WtKwn0xCJno9VlYnOvFelg+KPg4f0T74uCj3h+jR2ZWytwMDxbtZacT8MzxpNk5A3gYOj4XPUPYlsIyx/OUbEDDGv+4kwn1RwYmDAmdDWVWfO3YdBw44nYZDA9Ra1AYgVz3Dty0TFJmoPHrvCaSnUOpyvenu6WC3heUm0eELs70GNOIyqdFnbVVBd0x7EUOg2evNYAFMO26l8ku4qtS9gBWcQV6pXw1p1p//TMGt7hcRDu67/6Yh7bB/XHFE6lLWxOGtPyLMHkFA9JpJR7v5kg3qAIs1xUuNTY9sa7PTP++PvWMc5wecRadDr1BECnz45A4pi4bF9W+Hg92vI2WBDTLZ7JAvIxeQycVMwAEV5sW07F9BouBMUpSf455usTEuhbnIGUW5WSLRVEvK5MV2o3NBXXIj+C/SroyyY9xm8K3Zkrj9YOd7axZyejV9cAfX6ibo+2DnAIU4qBEipV95zfEeIpG5ajRxRYaaHsu4XyfIoc10N50cGX0C/YjFnuYW5FkZ1Rh05DXQMamEW1LJ7DkTSp+JiqGAqw7t8Cw8z+Tyi5xIf+gMLRLcaXqSiddVsMhD5aYjJN6WhQKD8Vm70HEjtLjK/wcYLSoXqmow+ZhZO/LVOw+vl+Orpy5zIihdCR4omDrlAcWTnd97wAQLzYFnd6CdyRsXBEYpT12Q6IgQ7mfCGBGaNLzNDPrGxiKvfNdMSBc80nXmSlSgJhJHTc/DDGapx+1e2EwJounA4btFty5FSZIazYK7rhj4
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(55016003)(40480700001)(40460700003)(8936002)(6916009)(54906003)(70586007)(478600001)(316002)(82740400003)(356005)(70206006)(7636003)(47076005)(2906002)(41300700001)(4326008)(26005)(8676002)(5660300002)(9686003)(83380400001)(336012)(36860700001)(426003)(7416002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 21:08:06.2079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a43c977-307f-43bc-496b-08db9f660d61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Looks like Yi's latest code has not addressed these comments.

On Thu, Aug 17, 2023 at 07:31:42AM +0000, Tian, Kevin wrote:
 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Wednesday, August 16, 2023 8:14 PM
> >
> > Under nested IOMMU translation, userspace owns the stage-1 translation
> > table (e.g. the stage-1 page table of Intel VT-d or the context table of
> > ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific, and
> > need to be compatible with the underlying IOMMU hardware. Hence,
> > userspace
> > should know the IOMMU hardware capability before creating and
> > configuring
> > the stage-1 translation table to kernel.
> >
> > This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware
> > information
> > (a.k.a capability) for a given device. The returned data is vendor
> > specific, userspace needs to decode it with the structure by the output
> > @out_data_type field.
> 
> "The format of the returned data is vendor specific and must be decoded
> according to @out_data_type field".

Ack.

> > +int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > +{
> > +     struct iommu_hw_info *cmd = ucmd->cmd;
> > +     void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
> > +     const struct iommu_ops *ops;
> > +     struct iommufd_device *idev;
> > +     unsigned int data_len;
> > +     unsigned int copy_len;
> > +     void *data = NULL;
[..]
> > +     } else {
> > +             cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
> > +             data_len = 0;
> > +             data = NULL;
> 
> data is already initialized as NULL.

Will drop.

> > +
> > +     /*
> > +      * We return the length the kernel supports so userspace may know
> > what
> > +      * the kernel capability is. It could be larger than the input buffer.
> > +      */
> > +     cmd->data_len = data_len;
> > +
> > +     rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > +out:
> 
> out_free:
> 
> > +     kfree(data);
> > +err_put:
> 
> out_put: (since this is also used in the success path)

Ack for both.

> > + * To capture an iommu type specific hardware information data,
> > @data_uptr and
> > + * its length @data_len must be provided. Trailing bytes will be zeroed if the
> > + * user buffer is larger than the data that kernel has. Otherwise, kernel only
> > + * fills the buffer using the given length in @data_len. If the ioctl succeeds,
> > + * @data_len will be updated to the length that kernel actually supports,
> > + * @out_data_type will be filled to decode the data filled in the buffer
> > + * pointed by @data_uptr. Input @data_len == zero is allowed, no
> > information
> > + * data will be filled to user, but user space could get the
> > iommu_hw_info_type
> > + * filled in @out_data_type and the iommu hardware information data
> > length
> > + * supported by kernel filled in @data_len.
> 
> I'd just keep "Input @data_len == zero is allowed" and remove all the
> trailing words which just duplicate with the former context.

Will do.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Adding this.

Thanks
Nic
