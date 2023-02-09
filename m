Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6409691196
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 20:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBITvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 14:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBITvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 14:51:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE568AE4;
        Thu,  9 Feb 2023 11:51:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRYzh6kqqIO/y0UFtnUsi1+aNcpLs5/+p0zWNYN9kUbSMLtxFvxtaSv3UgwLOkSpOFJSNWzHh/DEdaIoClM7Nr16/JR/remnp8r18Uw1R1x1LsXBuOFpIrga+n8Q0xrgsALNbyUdIQAAUrTuhATtU1yfKv6lapSgyhcOecsQ9tiTUcvXb/Rmy6b2QU0ZHWn35/ZQaPZudMtkdkbimCoA3duNHBJbBMU3o2YwqZYPe9+kYRz3ot7evj22on2xIDTSZrbfk8Kdh5mLnPxQzh9y1KcsLLg25NHQyEIOh8UoSuHffWmuWgRCCXXQJ4xFAkL+fSrlLaBRJgPME5wiNS+uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE5TJvdAUMtxLKM23i8X8UnR5cCuC+VGKQL7WgvLMCU=;
 b=ZZIUKFE82hw2jLdhK9jirCBvgy4z+pbyBsLxSTbDiU2R6CGP+Rgy8kyxdJYzzFOU4IlCALzlJbl0SmFOR+ece5Edi8EvqV/zCaj5wgZWwcoFOMWSJpDFfAOlJ4IitsOU8pM8Qpr4Thd2rdOAg4zb+62zNMVo0DS+JIKZt4FN6+ZYFT7aEAoL/GsreFc+VSMXtO8J91eot+Lsdx52wLD8YtA8EwblnG2wjXDp47EWAwxs/KHKSJcExtFngv0+tOu+qFqmSGeptDFIiW8ehPw7KNVhbBGYowy3+erqTMZHf187FNUzWoNmHSkT/St2hOU+ZN/sixobyqdExVAxowBYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE5TJvdAUMtxLKM23i8X8UnR5cCuC+VGKQL7WgvLMCU=;
 b=Xxhmhemt/nPbjwOTqIoTcTbLrTuaG0njdtP10c0TRCZhRccrKxEzo/K/3sh1vs0Rw9JNI9ykOZD0uetPM6Euso9030NNGuYjUEhDLXAmlTlfqfjToKsE2qbJtiS9f+2bmufqWMacpgGnhVsk3qMYw0+J7ySJ+5rIeXqfZrHKWLFYEyjSGSXo0o/xMMRgZuYykWXaiWkB+i76RREA+FUpu3eji3WtQVACZztTHhdoFu4CbqnRCtGoTXfNDxRg9TO8yJupIc2L41mpH3K17PlPsigyZAXNrtXkANbzJu1H7sjqr+C5P/YuaXy0c0hakaZUCns8Ro4E1WaCd15Uz10C8A==
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 19:51:43 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::f7) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 19:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 19:51:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 11:51:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 11:51:34 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 11:51:32 -0800
Date:   Thu, 9 Feb 2023 11:51:31 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
CC:     Matthew Rosato <mjrosato@linux.ibm.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Message-ID: <Y+VOw6dTnGapMm9L@Asurada-Nvidia>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
 <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
 <Y+U9QX4p5YX3/B3k@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+U9QX4p5YX3/B3k@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3e9322-5ae7-41b7-57f2-08db0ad7118f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwmwsP57xtleKg9U0eZ4oG/BnGO06cFCtIcV5MR2QUy/yDqMyMmaPf+8kxHAt3aeS0HMzH8wMCZs9vxN+zcgUJqnB47taUpSb7X+11ADMVoSTdj+M1LsdBG3gxY1tis6PUAhlRDblyChyJUrQvQyCcUMZ4M4KdsxZlB8DyoRdEWLWiwBBUhLNfExCxDcDuUKcK8T9I12eLd1a1wFE45DHkDlhRcPdofvavq3pcUxv33kHFftF+jE3LjtAzQNHvIO0Eslji0gAJMjNmQuVQPRISQn3qg4JZyBHtoX0vZMcQFJCJfqfo93IioK39+hjTPA1/TPBjUDIX2GJuDKEtwUemhWF5fgSch5B6mHPG5l9KiGl8B+THsfeF7fCW8zTbwwl2xL/Q0fMJZGFoRjVoEv58hI+vAkgBkNu/0/R6JLv8aMk5XMRCQK0lBTbdcrB3xyBaYXg1ZQAb46rFP7ks8eLDPUC96F+M6NvwRcaPvzPcWaQSctpelnyGJpsEQs6Gc/ZNGipInHBqrmYPAxXffN75ceVIyTuQgO/sgJaMHy64y4cl6CYfJUgnD24LJbx1ms0pyLJl5Ul0BZaolyo6naM4a6yKnMfxTdaXmN6VQOHt4SJVDcqex6bTgHgk1KvCkfVYtDacJQ5VXrARDP4F4wvXikNkRmZfMFtLC39oSrBF1ytcFbVgn4jpnNM7JkBc6LHhHCzt/Ti0zlLPVk/2oydfA6XKMv2dI/gTBxbNbgwtw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(54906003)(110136005)(316002)(478600001)(186003)(26005)(5660300002)(40460700003)(8936002)(7416002)(9686003)(2906002)(70586007)(8676002)(4326008)(70206006)(41300700001)(7636003)(86362001)(82740400003)(40480700001)(55016003)(426003)(47076005)(336012)(82310400005)(36860700001)(356005)(33716001)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:51:43.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3e9322-5ae7-41b7-57f2-08db0ad7118f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 02:36:49PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 09, 2023 at 12:59:58PM -0500, Matthew Rosato wrote:
> > really should highlight that).  Otherwise, conditionally calling
> > iommu_domain_alloc(dev->bus) when !ops->domain_alloc_user (instead
> > of returning -EOPNOTSUPP) seems to restore the prior functionality
> > for me.
> 
> Yes, that is right if the input user data is 0 length or full of 0s
> then we should call the normal driver function

Maybe I am wrong, yet I recall that doing ops->domain_alloc_user
without a fallback was intentional to rule out drivers that don't
support IOMMUFD?

To be backward-compatible and concern about SMMU, we can opt in
ops->domain_alloc_user upon availability and then add a fallback:

	if ((!ops || !ops->domain_alloc_user) && user_data) {
		rc = -EOPNOTSUPP;
		goto out_abort;
	}

	if (ops->domain_alloc_user)
		hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
	else
		hwpt->domain = iommu_domain_alloc(dev->bus);
	if (!hwpt->domain) {
		rc = -ENOMEM;
		goto out_abort;
	}

Yet, even by doing so, this series having the PATCH 07/17 that
moves iopt_table_add_domain() would temporally break IOMMUFD on
ARM platforms, until we add the ops->domain_alloc_user to SMMU
drivers.

Thanks
Nic
