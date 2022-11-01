Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23CC615287
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKATpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKATpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 15:45:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E502186D6;
        Tue,  1 Nov 2022 12:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA2F0wS771RVltijfMwWtQO0+dbS+XB6Cz/brgljjQNN1VYSQrCysBUsO6GEgkWGO380/1uElCZBiYetXVtZwOv3GFX/DrawkKLLVEC04WbJdPlAsitfoYeklBDqjRS+rE34nekx5rhpId6cGGmC6t7F4aDSwVDYcc3KFtyaVqPhTb8qBGc32tdFoIcqW0jJq3YCTVzjJ0nAI0cttBdy8e6BLuPRzpgzOjbFtMWc3CNxUJiNI66YlbfZ0woczg7vC6fwrk5mKEffU++XwWv4rKrLzVa58Qw1hv3kFU8b8lQPsVFGYWyYFy0F4hCCtph02//79nqkbbHxbtcj31oKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W0wtRtRD4XdFuCDo5lUvrd3tojKIthad6bNrerQ0gI=;
 b=FU61+SYmsLgWDEFyCbWRM1ZxJxabDy5x3BWRmfWTmiknTRc48ugF9rNBbWcD8PjqHmjATehxW1pxdPBnnO5qIBIabdgv7sUxnVLY1H9xBY0OH4SyrZyvlqdrvBs8ZGg+1gdT5ajJZSvGNt1l/zy+d+rqLkUA4t029MNyc/XAGTKvC259jV7yarTZaXRMf/+ahFRB2pvChBI0R0OMFfUXRDIEXqQsMXXE+SQmZtJFYXSpZKTFfLpWgY/ht+F4iRiIDjI7QoQOb1Tvq/X4Ff6c7s5UmDtkWduFt/+iaJcKA5jI2Uev/pgnx5DRFnxnZ+BEELKiqmzYpcxq0bdvQHTapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W0wtRtRD4XdFuCDo5lUvrd3tojKIthad6bNrerQ0gI=;
 b=N5xW/yROB3ZQjvs2p2Ybfc1OkuJ3bFnz81mbHYRpaq8IvZ7/TeSqxCzV1fisYcfP3oklckD4Qle8LmrEeo4Jt6e1nyzHrmZoSY9zsUGcu2I8z+jFthSfgAVKsYiUPPWshEQ0kiirrOKoK9auxqI8rinKthHqSTeFZuHriTaLAQ+7g7tQvwJoaZC18a3BNFLfUPS0qeRNFEylyA1iQiwVBr1x+sFksruARtcgBYQ3UJDcGH1fMGMvX8PWcFR4gYTOMqVK+gfI0s/aTVhTWQbOpMMsPbQ3q2YXh6DyAlrjSKPgrCXGf9Nv8cO9KGLDxRlI3KDGayh6Vq10+ioLVw/a5A==
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Tue, 1 Nov
 2022 19:45:16 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::f8) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 19:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 19:45:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 12:45:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 1 Nov 2022 12:45:04 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 12:45:02 -0700
Date:   Tue, 1 Nov 2022 12:45:01 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>, <bpf@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        <kvm@vger.kernel.org>, "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Keqian Zhu" <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y2F3PVS2JflqrMI9@Asurada-Nvidia>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3b2a1c-c0a4-4e62-e3eb-08dabc4199ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEOwmZW47+McFUN57NN2WaF7Yp1AINn9ZTEE07CikzFR89sxAsic0oCTXPbFpYTqNv1bciAbiPTvkFuIyFA6oDIEsMiOCjRq9SMvIhExYetllir/yMyF49G/FmNiwif7HXy62DY+VP13+BunuJQ5lDWJuVFDBo4hpXm2NxpXpzCMEwLnuSIcJVbv50/fXxoSNxqSpvSkCXmhOvo+vONVq9GJTW8PxDho6nYYVCDJnx/VlA+2wAAod0XMxui9G5QDPuonzaCnBmxEJJQoRBOpdT7pZGIQmkkOLzvsj7Io6B4w6qCpiU7QBRp0PSHYC6LNjgeSlmzM2rk/Ue2dfDZn9vulLi9hAS+3seuslKTpfWxP8R7f8n0Dzd6E/vJDq7TtUtnql5kIrZybfTXksxvG3+/rxLpOK9JioBU6mhwDsa7xHcWTUuQM8xguMV9glTWgZApF3UGJCjMmkBHHtz5ac6Tm2BRaNONmryzWNDYbvTN66w4EW7xLKtwsMYiIsqTaOTbYFjiMNBG4bEdtYWqIZd0OF2taM2tbctL2BEKsWyfrVgB7lmdvAA6oQYOv7ybFnfQM+Dk1nyidELDhjiaqnItu1efN6GkNsPW4BRQTXo8LYnEmVQuZS4HXqtErZxQnShdQ1Vqsa/g+vFkK/3OJF70E47tXbxc52XKGm7tTe62QiP1v5qtwG7E9I+Cqfc2SV0EDDQXEzHmz1VSkyxCgH4Y3Kfgxmvhy+8BusPVMeql4mIZpK4WSujAV1BUrX6Ow92hxqrM9ZpUO4OhDZrCJfg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(4744005)(70586007)(316002)(8676002)(70206006)(478600001)(4326008)(54906003)(7406005)(41300700001)(36860700001)(55016003)(6862004)(5660300002)(7416002)(40480700001)(40460700003)(356005)(336012)(7636003)(26005)(82740400003)(9686003)(186003)(6636002)(47076005)(86362001)(33716001)(8936002)(426003)(82310400005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:45:16.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3b2a1c-c0a4-4e62-e3eb-08dabc4199ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:23PM -0300, Jason Gunthorpe wrote:

> +static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
> +				       void __user *arg)

> +	if (copy_to_user(arg, &info, minsz))
> +		rc = -EFAULT;
> +	rc = 0;

Coverity reports a value overwriting here:
rc gets -EFAULT first then gets overwritten to 0.

> +
> +out_put:
> +	up_read(&ioas->iopt.iova_rwsem);
> +	iommufd_put_object(&ioas->obj);
> +	return rc;
> +}
