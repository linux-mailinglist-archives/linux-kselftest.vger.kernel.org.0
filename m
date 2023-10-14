Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42567C91DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 02:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJNArv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 20:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNArv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 20:47:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14AFBE;
        Fri, 13 Oct 2023 17:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJVQ94w4wEN1Dx1MuDeaUP7lEKSmwZuwV8tuH/ZjVRHYAluEhpfOOGZkdaLpLfXfLxLfVf/1xCM+d5B8KPH+Muo64U5GYPco9Tq66nZ1CHks3xmozcuZhsK1KTIhA4Oze76qv1SiHAQRXjSxvB/gD6ee+lI6p2RLjG92iirp1AABbg0qnKrNc0M9kmEcRC6fawOrtpWqDAIjUfQGeXIs6Ny87Q+DgYKmD8io4JTpbFiMXm+MwYncq1WmV/P1tiHKtjHH9t5iran/ibhI6Avjc5oiXaiRAGCtVQkSmomlgwKH0vbyiHBSchvPkL8uyO9qj+3mOoyEaCbxmb2TWudT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lUPW/yPgRPeVQpTwH0sGPM7GD2EHJZqrfRKwxRyo3g=;
 b=JdPAQIuVcOjbHfvHkDK9Gywek2XxooZcxl+5HwDUEQXJUqSnv/nbUlYT02W1qx9bQUSOwpTtLmf0RS5bDgsG6rR1+covxLKcfZ5VQlADOaR3B7F2XpLeQP/5DRNhWEEpJY4ovkynY/HliEq9Xf2t5eehEoWk4lBf/ELaGkmDQpGQL9qSakkjgXW1ZsXzq6UNxM+X7E7AyRX3vcrk03CcrW1pHgAnxwSNewVv6YaAiuly3/z9QDjRf4G9WXJq3rX3KjUi7vcmtNbSDtJtJHOE8kaKifdMb5f58hS+LaSjjHCmqpfWCZxGK4jLUhpXVIdiTt4EZsSy3ZkFLEcPWa1o0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lUPW/yPgRPeVQpTwH0sGPM7GD2EHJZqrfRKwxRyo3g=;
 b=jSkTbHxpn8H5Lwvc7YirYhgjIRXBnVfV55tsG6BjW2aGsEI8undY8CiHy2Cw0KTq0HtFx0Jz26iZGGpTDtEEUdfQTS85Kuic9L6kqnYASVQl30ir3WNT9nNll3Jx+XGHeVlKHB29WnsZVyAAZ+4QY9bioAtTXwLP/7uineOZ2alQO3F6mT22ps/HHCBPCnf9zB7Tq4+Ae2tu0FZKrcTY74qrU0R9Rg2njYUhvbklRJelKwilmoXbwPrvgGh3MfbbWYRa2PuZ/ui6KR91+gbHRF3Zujg8ofUIqUp8SqnpUzf9+KqLsQXfscLSD332euBuTBm2CnJ8bkJrtbAIEfHYPQ==
Received: from CY5PR14CA0007.namprd14.prod.outlook.com (2603:10b6:930:2::8) by
 BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 14 Oct
 2023 00:47:47 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::9e) by CY5PR14CA0007.outlook.office365.com
 (2603:10b6:930:2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31 via Frontend
 Transport; Sat, 14 Oct 2023 00:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 00:47:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 17:47:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 13 Oct 2023 17:47:46 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 17:47:44 -0700
Date:   Fri, 13 Oct 2023 17:47:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 02/17] iommu: Add nested domain support
Message-ID: <ZSnlLuB/7SVjHRfl@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-3-yi.l.liu@intel.com>
 <20231010172139.GR3952@nvidia.com>
 <9f311322-8340-c0ae-a500-ad9926ceea58@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f311322-8340-c0ae-a500-ad9926ceea58@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: c89ffa84-8517-4a91-f3fc-08dbcc4f2f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fumc5dxUTysgzyPNPr1Ai3/AlyBULIFbiKhN+aXP8U8/WPrajKEvs7CBFcVLvYVIEn39onollPu8xC6vD7+CddFZ+kP9Xm40KXClCu12WrFwxRFBGHjezy5Z+uV8FtCR9DFQkKrI7ltXK8bxCZTR3KfH1LVXONiUAOFFiwXJ/crx3vRxhbLGvINsfjQNcTQAj+6/DwTbWNVgDF0yjpTLmXhHD3F9fc7zoMtYL72orXuqmtm2jOkXVJXLDAlMjHqScgzrDWJAPAl7NvwrRXX1tZbUKY5uMOolbHEfoi4uMrnEJozmF7VxvBGDpT6trmj5gmea1q4zOBzcwkYdflvsBYJXsZeqd065w7H+NihQ/BA5DzSYhV7HrMNgPfWq56Bjb1azbYT4/LGZECKBU6vceBJRKNTr7iE3ay1llPpnpCy+3XqpolUfcQvNJylOWzMq1hkw0MPnS+hd4vDbM0lnv5ZoX1OouC93MRjpirtgeLPTDv06mTW748sIpo7JZRE4zCpZy0FskAwKt3HfgXAOcm5eXYf/mi3mr+ht5UMFLUhxxs8vkkTg44lRHwSSdaCECqklfrY4WPqN5p2nMKzd2rlFNkwA5O4b6bHhuOIoitpSL8nQ5a65CBJ5a2kUaoX1Gox2U3TW0bbx/6VDyGAL0Ah3mHQxNIASitxV8yI8zPzJ5A11PH+EwGEqEfCSUNAcpWrwN/+AMWxFOo5PexkyLEhAv0qH9BHTyXMuMszU+y7jHG8O44Qeim2jFU9LY1q
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(41300700001)(70586007)(70206006)(6916009)(54906003)(316002)(7416002)(2906002)(5660300002)(478600001)(40460700003)(40480700001)(9686003)(36860700001)(7636003)(26005)(336012)(356005)(426003)(55016003)(47076005)(82740400003)(33716001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 00:47:46.7553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89ffa84-8517-4a91-f3fc-08dbcc4f2f24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 12, 2023 at 05:13:59PM +0800, Yi Liu wrote:
 
> > > @@ -241,6 +245,21 @@ struct iommu_user_data {
> > >      size_t len;
> > >   };
> > > 
> > > +/**
> > > + * struct iommu_user_data_array - iommu driver specific user space data array
> > > + * @uptr: Pointer to the user buffer array for copy_from_user()
> > > + * @entry_len: The fixed-width length of a entry in the array, in bytes
> > > + * @entry_num: The number of total entries in the array
> > > + *
> > > + * A array having a @entry_num number of @entry_len sized entries, each entry is
> > > + * user space data, i.e. an uAPI that is defined in include/uapi/linux/iommufd.h
> > > + */
> > > +struct iommu_user_data_array {
> > > +    void __user *uptr;
> > > +    size_t entry_len;
> > > +    int entry_num;
> > > +};
> > 
> > Ditto about iommu-driver.h for most of this stuff
> 
> ack.

FYI, I aligned with Jason in another conversation that we can
defer this iommu-driver.h thing since there's no more need to 
include the previous uapi header in iommu.h

Thanks
Nic
