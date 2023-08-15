Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850577D109
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbjHORbx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 13:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbjHORba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 13:31:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0F1BE2;
        Tue, 15 Aug 2023 10:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FweOPhSVgYwwGfacd+fc15Aq7bw/cuqD7v+iRCNS8jeoiuVX6x0mrqO6XbrGB8y/KLa6O1yOhq0LulT1KkzDdjmyPRsLhpKWIsSIEtZbUwDZnm64Wewo7TsAIlJacj3JfTGuy7WFmYXkMlbz9wHKWI4fiqpubuQSWrtfCzGk9PpDhu8kr91s6RKwye5FCFSuEHxppDrYlABZ7KLZwdtIcr3N+2EJgOFUJ1OlNLT9RcRZ8gTykBcdfrnELuzpzZFsD/+I8WMyfqtxi3gvJHjYtP7r3hJ+ZwMp+3OYg7sYfYY6pwMk3ky8lKXjUsYq7zBCQhxAgC6WWclxW2D+ojqz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9FbaoEe96RqhW2dtgjewBqEdVWmCr5m2eL/3jQZHgU=;
 b=SxTR+KQBzMd4ayrBYhb1kXm4Bb/7oTvGm3VWiFWJ0/AdGOesMjniREslR0OEaNdUDeFb3UvkUX4oi1BCWLxPy9NdK8hViTv2ltdXeVOSfdTM/Npnhzr9f1NRxMXuWr5rUJRNa/6Q5dNOtbq2LQzhi0ac1ieWcsoDvnEmLkRcAMj/iglYYwhSQOfW7+D/vOuvh8zVNYCEv/egbX2JI+F7JdDuqnX1dW54yKFv9oaiV9rydqIRphm/TqG1/kGftynpTWf1wIhkIXyL+RJwSY+tVf5xXyJ70k3kYL1TiD2ypDfAuQE2BkclebBcayq8thw9SavTRQ5MuO8vqgdmvcF8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9FbaoEe96RqhW2dtgjewBqEdVWmCr5m2eL/3jQZHgU=;
 b=qe1MQmp0mJr8qV2YQHDHG+vi2fxoPztU/N6pjSV3vANFUnuAo15yCdZGlAWn3h6osRQz9sRRqGfynweYm3qCUuLG1V6mcCr/g984rr5rOagVRmi/FxHFE3PtjfaShzscGQFua+pecc0zozzPZBpo0vxEeFt28MH0NBXvPqqSQ/5dnjjZhg2vNycwdcrZ2ms8ikgl9Vz5X28P19aqwBwObPphTi/IcTfA0s2PqqVy7N0nq00Q5pxz8QKL4hPsiMmo2RpKj9NjvwF6EpJGsutIbaLgWz5AMMNzTgF9sYBO5XaGX/x3jsf8UGyNFBL/OyADxsR9Uy0b4P0wDSFJ6G/TOA==
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:31:26 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::80) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 17:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 17:31:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 10:31:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 15 Aug 2023 10:31:11 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 15 Aug 2023 10:31:10 -0700
Date:   Tue, 15 Aug 2023 10:31:09 -0700
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
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNu2XWS0BERqykIA@Asurada-Nvidia>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuogZV2eEeVwNX4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNuogZV2eEeVwNX4@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7994e17f-ec5a-481e-f7fc-08db9db573cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9MOTQS7lma19Q8RdHO7KQx+bWMmr0LDelcV2d2HccAQCVllzPq+dpB+/S1jF0f9e8zWH2Zw8WrxnVN2dABI7fjQ0fB3XbYezTu6hWsRYLvBvS/qTwLqExwFTgwp8LFWIRc9SwDcy4qXgSu2bfp2vt+cj0qk3NDwsom8rwfutCGWPoo7rudUlCOpJV2yr/1OnTua3c47WtWvbm7g4Fc7LrVbTOrGrP/GY32efINQ/MsnuGJMLbNUauRX1TFmS+iEgDKy+P4++sO8hLDWvAOTftENkyYbtkBJztbi1EmBaYRNmDh3vZXbMX+eR8wpnATUn9pmAfyTh6jdPGppD9DthNoWaBR4Vxc+fE/hcuIo1iNYZHrKu5S1+QP1aA9y72eMriA0/3/p/QFq0EhTvFXe42zT5f1VNmeJV4eZiA5OVXSJYqWlWGe/4Ugq2hMbqMh9SYCh8Yk58TECDb8FAZKUserKhDiosY4ibJTgRhzDIBXQnmU/SPK2yUa/BdYSGVSqwZSxLNc9cUplTQkQQM5DFKaA3lGbkhHPr/fRg5eA7vg9pYBfw8b6VBnHB808PdLAtsfbVyGp64M+mc0BT+KFPvqpcz8NJw8gPKeuGsDDwfby/SSghsv45gc+IiINLwnor9RgqLSVAr0AomSeucqh8U3YGkhljd0wKZN5aQK+QLNQ4UgrHou8ENObw3Tlrty42emRcnzMr3kL9oUiKkpCEHlZU7zLE/XIMt/wPZKDDtAgupLU0doRRmz1tDslKe5Q
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(86362001)(55016003)(70586007)(356005)(5660300002)(47076005)(316002)(70206006)(41300700001)(4744005)(40460700003)(6636002)(26005)(9686003)(36860700001)(7636003)(82740400003)(33716001)(40480700001)(83380400001)(426003)(336012)(54906003)(4326008)(6862004)(2906002)(7416002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 17:31:25.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7994e17f-ec5a-481e-f7fc-08db9db573cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 01:32:01PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 11, 2023 at 12:15:00AM -0700, Yi Liu wrote:
> 
> > +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_hw_info *cmd = ucmd->cmd;
> > +	unsigned int length = cmd->data_len;
> > +	struct iommufd_device *idev;
> > +	void __user *user_ptr;
> > +	u32 hw_info_type;
> > +	int rc = 0;
> > +
> > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > +		return -EOPNOTSUPP;
> 
> Is there a reason to block 0 data_len? I think this should work. The
> code looks OK?

I did a quick test passing !data_len and !data_ptr. And it works
by returning the type only.

Yet, in that case, should we mention this in the uAPI kdoc? It
feels to me that the uAPI always expects user space to read out
a length of data.

Thanks
Nic
