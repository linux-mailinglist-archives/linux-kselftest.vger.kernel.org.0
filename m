Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A931615222
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKATSM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 15:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKATSH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 15:18:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5B1EAEE;
        Tue,  1 Nov 2022 12:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg+k2A5AJ4X6h04pD1emr4BPqXxGi+wfenXOmob4/Mzx+D7XmK2+dyqoW71w3cegAqZkW3f32AQ7xZacEsGePvUTSZ9SJjFROBNyfu3nL6Ta2xuUWF6ka+MrSxZgsVydVq9DasUo2URoceLXqGvFPT5VNCTn6kvdLkB5Q9Kw9vQEpSRa2G4zITHloke2OkxVsak7MafPgSHmIuFYj5zu3Xs27s+8N4sTlST8WB4o7IZHHOmgj3dJc+1OjOFZjKIflug3NKYqppqBrvJNDAkQQ/LkjFMVDaMHLeBf1stJOArSRTqK7wufcxKSft3LwOfSi2D5sXgl3DX6sIW0y9HeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Hj5W3rVaIU0gFrNM3j1dhZkA3BpedesQsKz9UiGNqM=;
 b=KxMVFBfayUb4T/WZcKX02fn3WE8eYv28vcBYs777//uR22aBsImdtsVIvzuDPq4LOmXkMQnZeQXe4eeajXCpdBrVtrTS6iq4H2OVgI7TaE7hst+QXsOLFnd1wgT2r4TfjKHyDIzwBei7Kfag+2GnEz5ZqiXAMN9PCiwQKa4UHGDa//YyBr4ZUIi5z2t3VjhZPXJmqlxd0ylIIEx2BVbZCscQF74x6/v4aqrTiaKFV3XiNKSJvSGruJ9yhSiBPVDToEIbYBfgeaUSYmAmq49gRDDE0lygzXezttC3rDIsB1eqs8KfBK/+usnaBg6GyjrnrMAirL567N9x31Lj2PqJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hj5W3rVaIU0gFrNM3j1dhZkA3BpedesQsKz9UiGNqM=;
 b=BEm7tvIcTK6gSFWjmJ0qJLfZ/vRzTA1le9yjIwf0vFkRLHdVwQJiQZT+5pbyBDL4eqGjOODMpuMjusxu2sNqydG0Xee+yea1PUeM5bcu0fKN+a7Y9SQsTPSfUFDPJQGO8fu4Ls14iWZnTbAdxjnPvoA9B4Uf3AFIDFBNuQ9x2SZd5V6nD3YuxiQoEpGAiStcRdgLc73zakdMSbabY3FAEYfDbvdvGWKNo62N/aLwVlGCvTefjaVdByBpqrfz3DYgUKXllYIHmkr0hOrgO8+HpRYis5VSHdgkT/ODXaSaOeUDAP3T88COqolzd7lVj03tDsZ95XpsdM6UtgNoYPkBiw==
Received: from BN0PR04CA0130.namprd04.prod.outlook.com (2603:10b6:408:ed::15)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 19:17:47 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::ad) by BN0PR04CA0130.outlook.office365.com
 (2603:10b6:408:ed::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 19:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 1 Nov 2022 19:17:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 12:17:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 1 Nov 2022 12:17:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 12:17:30 -0700
Date:   Tue, 1 Nov 2022 12:17:29 -0700
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
Subject: Re: [PATCH v3 09/15] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y2FwydZzhcQ2vpdU@Asurada-Nvidia>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f66620-a4e7-4680-c37c-08dabc3dc251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHltHxwgGfDR2GhX7Qh1bqvq9yawPePAYkbWYh1vac8T6Fyv3424gr10XIQc2LOSiPdk62VRGhoBc/Cgo4zFh1ElmXDIhOk9HIcKK1OdhpAoQ806LJ/Ra/gr2nPI0E7qwWqM0XfcRE5cv/Eo2iF7wUjIaVh8/6v/4EhfI7yM+8ox4H0tokV5VZg1X5oT4KsqtHavUNmKFPceZr5v5nArhpy5BADTv6PbV4fd1DelZy45MALPQ9K1Wrr+YJdBS64tiOx5KPw07CIiom/07Z3yPvkZphTpkzbq7F8R0wJ4v0iJbZHweoqrAtzNa6P3+2r90b1fO3bOfFHZHtnmSQgzpvuU2P/jkWsPBogPsVr+X1LKypgoIRmnfrK5VXy+3KldzVJpRQYaoObqN0rJ4DV8+PKjQrk2Ca2CRxYHplsuf/h16NpJhfpdDexAylkZwC1aEov1qQDcKh9gLg21IA/aL1VMEl+NFpAe7Sy2Wn5U1I0oUihoRap0ao0KdwdflzrqlL7WGZGUBBTp9EHKik19kzYtY0DbxSNt0Np52OsnpTWY+3pniDz/M0hZWKwcPjlQyBr/bRYoNpTPaeVuH0GXCBrUaJZCkwVJkhWDli95EeB2eNt642YnGK/WsOgczRthKMrQWaiZoC89Nr9kYbAdRhK0SZpO2CFBGadanYK/ZymAhZzAgHtjJOlxCUjt0Rm4/pD8wFsP5zFnCO9bSJsEPxj6Ucfn7RGTYD5HKqJQ9wnZj1b3SnMPQBvAoZWmSq5K5HQrcrZacScTRrtZGTnx7A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(7636003)(356005)(36860700001)(426003)(9686003)(4744005)(86362001)(7416002)(7406005)(2906002)(5660300002)(8676002)(70206006)(6636002)(8936002)(336012)(4326008)(41300700001)(82310400005)(26005)(6862004)(70586007)(33716001)(54906003)(186003)(478600001)(40460700003)(316002)(82740400003)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:17:46.3480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f66620-a4e7-4680-c37c-08dabc3dc251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:18PM -0300, Jason Gunthorpe wrote:

> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> new file mode 100644
> index 00000000000000..27cbb652ee33cd
> --- /dev/null
> +++ b/drivers/iommu/iommufd/io_pagetable.c

> +void iopt_enable_large_pages(struct io_pagetable *iopt)
> +{
> +	down_write(&iopt->domains_rwsem);
> +	down_write(&iopt->iova_rwsem);
> +	WRITE_ONCE(iopt->disable_large_pages, false);
> +	iopt_calculate_iova_alignment(iopt);

Coverity reports unchecked return value, perhaps WARN_ON()?
