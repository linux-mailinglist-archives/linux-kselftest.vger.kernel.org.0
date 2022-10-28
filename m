Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D682D611E6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJ1X6S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJ1X6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 19:58:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6771C77DA;
        Fri, 28 Oct 2022 16:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeKckybSauTX7pvMlZpRcsAClz803TguJPRZ9HVdKh3hxCCUw8MIWGIC/xsgtzI3eRlRKgjaPQIShBKU4TTyAwnLo55uhlGj51+uxEZyLhV466Pfmq6Y5ef/XvClGDSj+CzFI8JZ++cN2NK5FnzqvWhfywsv59mraRT+v2L5uVMcs/La7E6L/IaSlDskBf6FggxqQxy4SIFuPJCY/NPlDAr/2ON/c+wTMpjHDwPNy7E9DblV8GzVeK1AGWXoCPK4cN4wJS7nz47buu6vOL/0KqA6Eh9BNUWqbm7K8GuY9lChVOkkhHZ+326tNZxchy3/TX6LaapUgXkx1P65nMnlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvAZVAHcG+zU2Pu+pDcusZ2lToAwyAoJ6UUc79Z/gw8=;
 b=nb1ABB5q4AYQShbxUmyEihFjtryqhwewWXduFB6+Qph2Fjy6utaip6gBmRjm25dKam5KySoRLizrewxVbf07QYA+rYRq2AZwMuoj1JusOVHuEpLGyO0eSqsXPS/04mcBfJ6jUWocQxDnkLTJz1sfRo9yicsGX4+BTUetmfqXKKjZZntc2yx5JG9x6nb9NA51pq57okTgnGh+jVbo0KRM+430tDgZQwmesdH/y1WESTVNYkOUw/U2YC5Ne1ym9dh+yO3XpOMkYOGQYWsSy+2dDh3iQmBJIfx4Boz/GZGHjx7jfUbzoCwF36sTciA4l/+PW7OV/8XMM1n/fGNOi/dilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvAZVAHcG+zU2Pu+pDcusZ2lToAwyAoJ6UUc79Z/gw8=;
 b=L4wQcSCGzKOFcMAeNlDqHMveFL1006kc7DcFXOt4Tj4Z//sRqcQJ8e7E7/Z4AILfOJR6uSshJwQZbk6rXfgjsYPqw/DIwVbdm2J7A2PlUCglNB1W4bpPDz1MVjbs2sV5li5KY2RNlrAyACZqyCd7mfHfSW9xldV0IWlpuaPswh3RalJUoGPZ/zcCqCW7Kj1nsovmItuZvIM5DNwqHDWsaE02GbKkCw82PEO7Rwg2OzdGSYvSolPc+4KP68UDkDhV4tBOoD0dIuRt1RkrR+UHseNTmObA7OsMOnq8907GsKdrUwzBfQBeJd9S9B97HrbsqnaBNlIjxSi7j3z0cJyBjw==
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Fri, 28 Oct 2022 23:58:09 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::3a) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 23:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 23:58:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 16:58:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 16:58:02 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 16:58:00 -0700
Date:   Fri, 28 Oct 2022 16:57:59 -0700
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
Subject: Re: [PATCH v3 00/15] IOMMUFD Generic interface
Message-ID: <Y1xsh8K7Xsrnkljg@Asurada-Nvidia>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 544f334a-a28d-4c2f-a24d-08dab9404402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYVL45BfY2rOGp8PqgIKMUEXlXohqdJLZY8ucx8jDU8mFIZ9bhxxu10TwoWyVu4JmGf+9cf7kfeZtGsGieiQK/rYXNDyhnEBMI5W3/93Sh9Y9PlQcdAnt2ka/PpF06hBF9GQlUUw7EYTB8HWYxuTCK+bVB74/MA2oYQL7AP2lUVO+bcXnVAu+GRsDC0eNzV0rmy9zvdd48ztZJnGsj0afoQ5HoQIWldZUEo+sUiRbZE4bpcK7p2ln4tLAq0gaoKf14YduTDugYwLoJvLiSRJhJgecGxInTlksWzi6LTvdqvZTAdERsJopaO2Q10e6WskM4lOmAm5vo12/sick1+uzFa68hH/ul1l4a/MyclyGgp7CLh7G4idSiUxgpVDxFsT6qoKcMTXXmVrRWKcUCsMGtCieU6XIzAEnsxn4x1dI7m2ycxCMyTxBVV9/J0LMGvxVNui4gzY3bSwauzLMaXjSdvh63boN39SPrzJBGl4A3epUGGCpdCQYrjLATV8NKBouxaa+W6/DthJRvksX8uFhY+7mda3WVTwNQZSJJtFuk24avBZ/Qgn6r8ZsboZ2BrxK1GvEDMPulp+ON8eiZbQjblFNGImHZlxqK7xlKRdOUW+371mv0P4RoIUw//Qt1YV8/EhMY40eRExDLVJRnPtYCUts/Y+u3dPedqvQFrMeFROr3VWKeDpMfewjLpAJpC0yYFv7K8jSajG7eg636pbioA2LkGX+EtPqPvwzNX8G1DB4YU6RSUsoPHvh7+B8/XYSgUq5ia934TZBJc/8A8sL9/JzPD7n//xWf119M9FLcFZjuxAAF6xL3hKlCTpJj5ch69IA2e+ZXP+8UZFh4ObGosLSFbvks0zvMvsoIxRbPJKTPQiYv0aEnpI2WtfF0PM
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(336012)(40480700001)(40460700003)(47076005)(5660300002)(8676002)(2906002)(7416002)(7406005)(6636002)(86362001)(70206006)(54906003)(4326008)(55016003)(6862004)(41300700001)(8936002)(4744005)(70586007)(316002)(26005)(9686003)(82310400005)(33716001)(186003)(478600001)(7636003)(426003)(356005)(966005)(82740400003)(36860700001)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 23:58:09.5009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544f334a-a28d-4c2f-a24d-08dab9404402
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:09PM -0300, Jason Gunthorpe wrote:
> [
> At this point everything is done and I will start putting this work into a
> git tree and into linux-next with the intention of sending it during the
> next merge window.
> 
> I intend to focus the next several weeks on more intensive QA to look at
> error flows and other things. Hopefully including syzkaller if I'm lucky
> ]
 
> However, these are not necessary for this series to advance.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

I tested on ARM64+SMMUv3 with the other vfio_iommufd branch that
includes these core changes too.

Thanks
Nicolin
