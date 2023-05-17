Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E40C7076A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjEQX6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 19:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEQX6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 19:58:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51660A2;
        Wed, 17 May 2023 16:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO9hpbQP91OkU4OX56qUqnV5F1S6yy8qBgHJ0OsD8ZTnzMXVpbhQp5GrZbERE9LiON+lf6zDxWoSjzNO5CSF83LzZiFlGjnHFWZoH6nabOQBoseXXHawrq7a3CyY9JTH3D1RnYEmXkyKBkevQLQX62IUT44W4/xP8lZJUCoka7KJp7vac5v12UKpQVkNs4z2bTcMS72Qr5/bXuFIhwJYusUJy4wgfoksvSkJZ+MZcy2LTZtvE/aAI9j3cWjr/Vf2Gly9+T66IrFtI7JUrZ2PY206Rzslt5F5HBfcQWKI7ClkgBKowFl0XBQaEYNdZVZsK/pp5+ECTszizZFaC4Qkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eShCiNFEwQfEPDYNKN9ny1utiW/8ckQj/QK2Ta+URwQ=;
 b=FTO4b5x8XoFvX0G9vb3ztX59BbOfAlM62/Eyoi3Rj039Gy2CiXoILO52zc9VWyrD55kqjFU77RGyFeyDpSB1rkB6XEUKUsS/vvcOfbSP/ag0cpdxiB2q/DWLrTl995k9qx1ZJdqMdd/57yWdwNngdV8+l/AL1zZIID3Zj7H7AlZiC+53clNBgF4dIFDPNdV4mIUk4Em5AlccUCW2bLl8bGjjwOl4KZtRWWM9rC/fDE4Zy0Rgl6zcO7WFblYTcBGTUInVdT7oX3ZEgOKmHun7TiW2sDPDe2qd2gHOg9IUW+JTjzFG9oGEXNfoYdrgNqsCMmJfG2DsNNt9ajQYl0vgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eShCiNFEwQfEPDYNKN9ny1utiW/8ckQj/QK2Ta+URwQ=;
 b=HFkbkBoChx5qZVFgH5Z00f7GinBqfP8KBDufzkT3G05YsKKNR4sN5yAG4bWg9D2r/diEz8OOEei+zyuXtfXJt9dGFLhjdc7wNns4G3vxHDv0SNPgdt7oUMzDE0kLPfgimCeRXNAhYcFSVOYvn7Ynv/IZZ0CJzxQKwHK8429i/Q9aDGxergxQqYoOOhJjsj7ss7MeOJZwqszoZwVEwPLSe5JECjP72QgsCeiUH1QS39Apu6gZLnwZUvO4Dfg5vcDMNm2gBeiymF7ATpsu09WVRwg7lRGFnZv7OxQhYrFrSSvU2p3BykMJJtqsF7Plb3JewzIxzbu6m0EU6hrIAr/Afg==
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 23:58:05 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::8b) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 23:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 23:58:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 16:57:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 16:57:53 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 16:57:53 -0700
Date:   Wed, 17 May 2023 16:57:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 00/19] Add iommufd physical device operations for
 replace and alloc hwpt
Message-ID: <ZGVqALvA5OfyAY3m@Asurada-Nvidia>
References: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|BY5PR12MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d711848-3522-42cb-5314-08db57328e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIo0SZsvu3KRoZ/0cHXTj19RMwPjS+mZ0yZthpP3vrMZnaDYMwelc4BwDGH2sJkeqf9mY6wijrGP/UUV6zWUoHIDrQfqCLwb6yOIDdFXX0FB1pFDIqEwyepS40sIN9Qqkrt67cBS7Br7a6qa0G278WzRYcU4BivXS8dMY4TTSoj+NqnSyyRvvdRF4kYTBPZwdz5IsdJXVqxKtqWCiFshi+EUETlNGcWyi3vIVc57wHa1SvX5YYoTzZ0bTuOQUrWU7Z6bowltCcrp0NWLCJBkxvOYaPYLOT/TzaI39ggbxqe1aib3HbUuRbGkmrfE0hd7GFrp08NYvt/7fnHSuk7iDjFM8UBCSaWlsZNrebpMbANIeN3QSfojybid+2lb9jcfQ4b5s3GAHDc2aDHKFGPMbfO0FOKwLlcFTeO28KDL9S3Op5jLH7YzfJEi2+Up9/8ETWNPpQ0LkftjLMOs9g0+Q80W7YABnvz8IsJ3GAEteYFxIgHzoYDH/2iLbWdVqgn/xHMTKzOz6oLU0hxOWUajsURP40fAFbw7hpTCEzfH1pifSfVkeJkQTR7Ri7acR6Ai0HTKBFLRB/sVKnCWyP0lAhL2i50f6QFid0uIy+QxKwbgrvFyVdWRT3MKeAc+acUdMQaa4qxjieuDG4E+31It+hbYQDEj6m1N2KBAFwfGp+BwjJk9UfC+dfNElE7Cc0C00g8f9l8q6eDX3/y7YlMiutNYOpFzPL7gNU27dhOMMtIG57OXj2EiWk5O6e9D4YiXHcVCHzUJDVSZwgFwvNrqEXKOtth+vIfOenxee9m0JYXT4NL5R5tTnIg5emzpfXco
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(316002)(41300700001)(8676002)(966005)(8936002)(6862004)(55016003)(40480700001)(356005)(7636003)(82740400003)(40460700003)(478600001)(36860700001)(86362001)(336012)(54906003)(426003)(33716001)(82310400005)(47076005)(26005)(9686003)(70206006)(2906002)(4744005)(6636002)(70586007)(4326008)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 23:58:04.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d711848-3522-42cb-5314-08db57328e4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 15, 2023 at 11:00:15AM -0300, Jason Gunthorpe wrote:

> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
> 
> v7:

I built my latest nesting branch on top of this branch, by
git-merging cdev v11, and rebasing nesting v2 patches that
include replace, hw_info, set_dev_data, and SMMU series:
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-05152023-nic

Things work fine with the nested SMMUv3. So,

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Hopefully we can merge this and cdev soon.

Thanks!
