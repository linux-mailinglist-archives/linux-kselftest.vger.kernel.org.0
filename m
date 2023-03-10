Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38B6B371F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 08:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCJHKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 02:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCJHKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 02:10:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB96664E9;
        Thu,  9 Mar 2023 23:10:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtVdIy48P1/BbSixPqkEw/Mrfy3pVgEgD3v019kvQ55BVQNfnF0kyjLjhdApcR2qfietIBnfafGDEQSSFUUcF2Sfksq4j6Wap8ya7C+7JaLKOCAhxG7/4Eztbjb/bKf5HgEOW4Viv5ClcFQw4MsJN/+CBmiCGCuVIQIsOAw16JwoOYT/1JMXies0K7jq5DBFvGJRDdC/pGIYVNv4sB0eTjRB3s3+qnLoIXrrNphprEyGw7ZVrJhwIDjk9becUsTY6mEmh2mHkhm6xfO+Kc3MCKPK8IpB8G5R0p2RAw7Sz5zPZwsl2YeREBT+BG4BQoj7x4yYzpKLy1fGf+9SYkbqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzBtBLQ4XXOAtWN9HJDXLaHf5BrvilqdfJueGcGZzrA=;
 b=Ck11SYGdKrxebrAvdPyzPASWA2lijJh9soLXJCsx9ll/oUBbCXQ0I02Pne6ZLzdGK4/slXYywgZK3A6aFgDMGs4WKdYqdZljVEuepkZFJYGpUWHavkGVX5d17Tz6BBKrEz7Fay7plUxtguGA8geNFSjwGEnqWQ632iqSoU7g+h7b22fhl1ZamQzQzgwrhLG9hkofSUh6YyWfbDHof3/MiU02W5Z/9I8d+u6C/bf4upyxeHHU4gIDAuTEPVX9E9McZDs1sQ5JCASHzuztUbnWcaO2icFsRk05qOKGxmE6X1vzvZqv/R8wJwYkYrEBCCU/FnA2SabV/PmPq6QculwHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzBtBLQ4XXOAtWN9HJDXLaHf5BrvilqdfJueGcGZzrA=;
 b=RcXDHTSw8E2CHqCZTYEqevB70WqJP9oCh+a67JkOPV9qvc4mm0DVqSkTAShD+Hhf6w9KCTfiUiJLVxy/P4KWK4BvCNtmhbw20DpNk/Ee/FUEZDkYBKCLUgjN/f84yuOViZtpJi1hXLf6L4YVnnbp6WgyoVU7rMNtJGTdqqslKZAjnGLWwl84PM68jH/tqHeiFOFsPq0FjGjNrlF4r3wHUAYK3POJBvqlPWPkTJ/aSyTihz3fG+V2R4JDivPoSx6qIueaQHT7rvd5vYXJq4H6W6Idvc0akcRzGH4PT9CbYvA/Lw6jFIpgp9TG5BBRmZ3iheqQAatLzCTtga5OjvKhnA==
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 07:10:14 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::7c) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 07:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Fri, 10 Mar 2023 07:10:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 23:10:05 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 23:10:05 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 23:10:03 -0800
Date:   Thu, 9 Mar 2023 23:10:02 -0800
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
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Message-ID: <ZArXyj3iiPa95aCu@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-9-yi.l.liu@intel.com>
 <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0076d6a-d764-b018-7442-08a6293f9553@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aabf441-f294-468c-b2b9-08db21367ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oo7K0pM/P8RKCHFsWW8Z4q32trZdr2hVZYWmV4FEyH8eGmGLWKvZkMEpVTAN6LvG7KGHYoCz0WA/Gvh8IM0Ml1RIustF8Yx+NFj08lQJdqaDEJUNkQ0tgm0qUJc5VdkSqHfYMbOOPyqqbEMz4cNhyPAYczWvb4dSQfYdcR/vIF5Pkq8ULlUp1ZM/TeyNeETnTLO2zim4cb3CZWyLoqBOak+/YhvAmrFSQJwj18+zBefnOML8BsLBOqWHKRfMVnEFXbFBn8vyT64STpgKbdXh/K7Lba/eH4pvLW3dgVqXhOWsiU8ZahDiZQuWSMoPWb3gRAl2L0YhON3Id1t3AxJiZU5mngRTGd54wCEE8Zp+7qaY4S2LAX1LRQFhdLrs0mclgDJ/CtI4LtR6quvjI7BPkemgY6tNUDzfsQdIfMdMANWs18HgrZTJ2qNioPTvN1O2MZKcREHqIqYvmXLXDj8AN1KFUeX7gY/MUaEZIl16yAB34sY/KiPaGNSP63gL4DkKo9O3nytu5FA6zrB4VuS6OmQfaoIrW5R2EccSH0RebsVcltxXRJiGYc6yJwWRXogQwV87D4VkN5uo9rZWorlY8zbYjTjBylNe/oIzAQtAKfRmLAEhjuzk4H9pKvIcJjbtoM5qwWOHfhW89ouo/JFpa/ljar7IdYhk34NKrMcOODiVIWSsICDXBKKt0VLfqYFKSkN1+yUqx+TgPtyjDuJFdFC5/3mV7KykSPv5bn/8a4U24Buf1R7OCkL6DtcgLQML
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(26005)(9686003)(426003)(47076005)(53546011)(83380400001)(54906003)(186003)(316002)(336012)(8676002)(70206006)(70586007)(8936002)(36860700001)(7636003)(82740400003)(41300700001)(5660300002)(4326008)(7416002)(2906002)(6916009)(356005)(86362001)(82310400005)(478600001)(55016003)(33716001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 07:10:14.2231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aabf441-f294-468c-b2b9-08db21367ee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 11:30:04AM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/9/23 4:09 PM, Yi Liu wrote:
> > This provides a way for userspace to probe the supported hwpt data
> > types by kernel. Currently, kernel only supports IOMMU_HWPT_TYPE_DEFAULT,
> > new types would be added per vendor drivers' extension.
> > 
> > Userspace that wants to allocate hw_pagetable with user data should check
> > this. While for the allocation without user data, no need for it. It is
> > supported by default.
> > 
> > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >   drivers/iommu/iommufd/device.c          |  1 +
> >   drivers/iommu/iommufd/hw_pagetable.c    | 18 +++++++++++++++---
> >   drivers/iommu/iommufd/iommufd_private.h |  2 ++
> >   drivers/iommu/iommufd/main.c            |  2 +-
> >   include/uapi/linux/iommufd.h            |  8 ++++++++
> >   5 files changed, 27 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 19cd6df46c6a..0328071dcac1 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -322,6 +322,7 @@ int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
> > 
> >       cmd->out_data_type = ops->driver_type;
> >       cmd->data_len = length;
> > +     cmd->out_hwpt_type_bitmap = iommufd_hwpt_type_bitmaps[ops->driver_type];
> > 
> >       rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > 
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > index 67facca98de1..160712256c64 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -173,6 +173,14 @@ static const size_t iommufd_hwpt_alloc_data_size[] = {
> >       [IOMMU_HWPT_TYPE_DEFAULT] = 0,
> >   };
> > 
> > +/*
> > + * bitmaps of supported hwpt types of by underlying iommu, indexed
> > + * by ops->driver_type which is one of enum iommu_hw_info_type.
> > + */
> > +const u64 iommufd_hwpt_type_bitmaps[] =  {
> > +     [IOMMU_HW_INFO_TYPE_DEFAULT] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
> > +};
> 
> I am a bit confused here. Why do you need this array? What I read is
> that you want to convert ops->driver_type to a bit position in
> cmd->out_hwpt_type_bitmap.
> 
> Am I getting it right?
> 
> If so, why not just
>        cmd->out_hwpt_type_bitmap = BIT_ULL(ops->driver_type);
> 
> ?

A driver_type would be IOMMUFD_HW_INFO_TYPExx. What's inside the
BIT_ULL is IOMMUFD_HWPT_TYPE_*. It seems to get a bit confusing
after several rounds of renaming though. And they do seem to be
a bit of duplications at the actual values, at least for now.

I recall that we only had one enum for the types, yet later did
a separation into driver_types and hwpt_types after a discussion
regarding future PASID support?

Thanks
Nic
