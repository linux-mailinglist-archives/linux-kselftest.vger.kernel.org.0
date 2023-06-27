Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB996740042
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjF0QBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjF0QBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 12:01:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1A2D66;
        Tue, 27 Jun 2023 09:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOQCx/2zIlLrOQzwnLh5dzAmblW+GKjGj8QDb2Qhui6khpXBxz+m2M35zo/5gJ5jKt3iy+qh4zGcyvyCwuvjXli10dDxR8AL5kL/BWZ5y8kpYuUgoqtVY9WUZANgOxJ5hmQhO3spV8DVdJyz8MwZ1fMuprmDPXgwNiu1LLUR1Er8rClLZhKlqgnt2RYchU0sw5ZqC0YsOXPSJLO522iNTOybccoXK5UEgTASYfMXbhSImgxq4kiNq3rHUtXd3r5l0dkaiUZQmRK93IL+NHGpM46i9gczcnhfP9TlkX4pOtom2B0WTVqqWm1fk4VnnYnsSYIk5YEXanWdDexQLzF21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKhsy7Lq1U9tcF+Sp6OKsaX3XmhN3KGYFN6VGMI4MnM=;
 b=X2vVhJ74T2jSAo0B4dSTp3NBKSlVovtOZ41RK6JH+PNgkuC80P/aBCLWrQNxyv6Fzm375mKUqYpM4ZI6l9ueoe4CRx6q9MlA7ZPQSK/KWuTcdS6Iq9evAuePc0NYNLMn+UBIvZZZoqeFoRYMgiswBwMXDs5VlA1JCFHUAURELc9Fz8Davbwq8gphnqK4rJUtteHTZkCwHHXp3qbPwXFnv34/vSdNpaBO4N3iW8bEqfKAuBB19PazZQHewNieuMnx9i3aZwnthVm6cdwgFM90SjU58hNRQVEp3a0DHPqUahCzBPCsMof44kndVOKSfSWJ7/FmQfwlNd5mlM2x+3pgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKhsy7Lq1U9tcF+Sp6OKsaX3XmhN3KGYFN6VGMI4MnM=;
 b=H4BmNtX2c1BPQe0Kt1LXQq2lSOxhVJ2G4upVHEV4LfkcsTj5UlrhIi3KMUdzbF7XLFyRSTxQw8/jIVrsg+s+bLihuh4Py1ffUWkQvjKgIBW0SZHMwveLKgnEdiNhzL3DvMfg9Le2usaaSoB1JAsiaYk4JXdbDqqn9J2MUt2HWx9jBkf8P1S2xC2Z40n2nQ3ypIQ6sDwlDmNHHSVzereQ+LwvkrFEY0AkzDZxsBTHHrct3g+Y4GuP+4lTxEimz9t4rjY7Ha2cEkupbXmsKUPJda61nRP5qMffKZ0q2TuQehgwC2qxUQ1In7gNpdVY9bquRMBsfMQfYvw7oIU0R5KwNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:31d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:01:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 16:01:26 +0000
Date:   Tue, 27 Jun 2023 13:01:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJsH1NtUJIDfUthO@nvidia.com>
References: <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
 <BN9PR11MB5276AA174BBE2C4A91C5E5338C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AA174BBE2C4A91C5E5338C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:256::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e3f0bb-dbc7-4426-a9a5-08db7727c2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0/3WHlcJGCLwDFG2uJmamC4Go/WMY8sTSo8H2udYUi02mEw73UxSxF+65WeweFn0YTITaS6pPTi9DDSKhqt05qTAuqoOOUgwI2NZ6wbDxiS2MzWHPE6kXYRt556kYFqu2vSnUCsu+YG2dNvACYiUdDe0zJCL4tIt0K2b752U4UGGPNuiWIhsMzyJqh7EDHDLeh5jN7V/Ds6iY0DM4HzFaBFXgxWcSdtOzPAeqOyZ9aII4edkGLnnfa9mdQbFMVjA88cbkptSL91vaN4emVl6MmlihsJ+iTFq4Yuh0SteBtHCBq7mbhyAcM+NQhkOSPZ1MwJvh5+PR96FU5YmPM/FwA4Mr6+xR14pry2ELs7F8Uk4DLQcu18lSYRBSX3MeibrKccva8A9jej5sSETAoUpb0wKQX3KH2AHzCR7ESZGyAjgiM9s3e8nqyBGnOiVKN//2kS05ROKE55GWaLR4/UtRCoRk+t5QRDWIMrKGuh8GfIuZbNQAjVpHK8GU3muW4L2WBbw+G8nw6/oqYDXWMDkcUmC0zQO20WthEF978gLh3MyJxQ+A3bYXAV3KvsGMux
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(2906002)(2616005)(186003)(66476007)(66556008)(6916009)(4326008)(66946007)(316002)(54906003)(478600001)(7416002)(5660300002)(6512007)(26005)(6506007)(8936002)(6486002)(41300700001)(8676002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ys+Er2xC+I6bxChisQrco8Jj/waJCmUUOUoO+KhvGFmMcUXghVQfp43xr2kd?=
 =?us-ascii?Q?XxHzaCaKp+f3S7XycDGikn0s029haqCUIIJenDmjkr0kUrUkjDAoHcrdS0hD?=
 =?us-ascii?Q?UFjc94Kk6OVt0BfA3w1sp3OV0kbqOI2W452UyZ3+ly5qeOhFy/bw/ph/rX61?=
 =?us-ascii?Q?An+EMdKERgh5lpk+bT+TGTx+5+U2pGMoXDPjxR0Jx4YbTNXz4yyt86Ib7n4A?=
 =?us-ascii?Q?a4voTNskfmd34wLb8we3CbcDe0ttsH3dy+Ao/V6+27wPk8vpgJUQluZED+zA?=
 =?us-ascii?Q?hfbxVeB6P31D7112bToBdD0APlACdIkU7fPx3f74Iig95dnco0BbqxV/o0Nd?=
 =?us-ascii?Q?UIEHy4d+3GPwdsBpbaT5auXHH6RWMS1LiGGumbbfw+12P3CxO1WMa6xHGf9H?=
 =?us-ascii?Q?OMTKr9MNp9Ub/3GqE8XyNFJdlzO3df5Dh/fhvhkFf7JvwyRt8O0cJK32f2Ev?=
 =?us-ascii?Q?4E/koL6UA2x/THeR55ssWngBjQazrBeOtJLCPpnVBkPM9a8Z7LKMDMazZGyr?=
 =?us-ascii?Q?XPIoD1aL4O2rrbaDDLyJvEXiOuqTjuhSBSsTcYj1DxZpf+oRzrNN5qM2psj+?=
 =?us-ascii?Q?A6Xd+8ZyFbrEsJGsgdhv3UDE8FQrJS+EI00kC+JPHwdUygDOJm2kso+IRKvk?=
 =?us-ascii?Q?ARFghDE4Y4dfU7kqvxAAUDVAZCC3D1JAXf8haUhjsAM2Ob4ExguLA88pS+Aw?=
 =?us-ascii?Q?1yK8YusnyuDvQTOlL9AQ5iHrILZnu9iGrQZ8BLdCRwa38H9dOJVdXDUPjYqm?=
 =?us-ascii?Q?ibWNnr+7lEhd2okaRRKBD8M9z2JO/yp5KnplW7+RGThcRaMgDsVUGKxNgB7W?=
 =?us-ascii?Q?hU4DVAPp+86HbxzNSdz8VbKGTDrn5jjAGggcBmp0cc7xUvIkvLnsvMgGFKQ1?=
 =?us-ascii?Q?eRhFBt0NXxns2IZRUTayFOy/cL2DFVM+nC3fdPab/GDZ45IMqpO6FHAAFUzL?=
 =?us-ascii?Q?QyqlsZlfWw6LZ9uMrt4rvAQyLYeewQ0/aGRf3PGsaKVlETwCma7dQEJ1P3Rm?=
 =?us-ascii?Q?MlWnQysPQ3eiynd4PyBWmJW/ytf9ZJlKDXHcK5tLUiXr/RkMSOUxbKIqbQvg?=
 =?us-ascii?Q?caQHXs7wASYzmN1PlZ/C3UBK1V1v2CJTDxvbenc4eicvfh4M4oljL0Z+/Kov?=
 =?us-ascii?Q?sUYQ+FEdtk7u4snAHl4SHMbAa9ZDqLgMfgPAgHGuvN1I7BwXUZTDBzSP5Cow?=
 =?us-ascii?Q?er56/iPZRInlR9/kbN9aLn9R7fd2Kzumb3RhgaR8fgQqUaCi3YMOfD9r1Mor?=
 =?us-ascii?Q?Rhy081dQIVOQ884zl5zS7B4sdqFrjQIOQBhClX8M6ZFwmEY4YCUGsA6U7Ot1?=
 =?us-ascii?Q?/+bHaXeOVt4zU9tJe4MadOZ2Sz78f8tVTxNsfzUugngmazzYblmDvtfda8F0?=
 =?us-ascii?Q?SIni1CEliOMrgOzouA8Gcr9iGJ0j6by7tCgR/dbCHYCQudMjwqOWtVuNmtrS?=
 =?us-ascii?Q?rNkTu6p//q4CnEourE753ddlgeStZE2Zpm2G6ttyoE5m+IxAANtUH/0kRW5g?=
 =?us-ascii?Q?nT2AAUUvNCz6rI8V2KKJOfwYWaMNv8MP2Gmro8l+56DgNDBrG5RnL5EU78UX?=
 =?us-ascii?Q?uiPnWVQUOO74YqTL06u293JVe8fMZWB3hJ33KIm7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e3f0bb-dbc7-4426-a9a5-08db7727c2d9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:01:26.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uyB9S7v9C9QBa09epmi8UKY9qltMIG6/do15nvTVxoTmDoJrbJPmfziHaQvIaXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27, 2023 at 06:02:13AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, June 27, 2023 1:29 AM
> > 
> > > I'm not sure whether the MSI region needs a special MSI type or
> > > just a general RESV_DIRECT type for 1:1 mapping, though.
> > 
> > I don't quite get this part. Isn't MSI having IOMMU_RESV_MSI
> > and IOMMU_RESV_SW_MSI? Or does it juset mean we should report
> > the iommu_resv_type along with reserved regions in new ioctl?
> > 
> 
> Currently those are iommu internal types. When defining the new
> ioctl we need think about what are necessary presenting to the user.
> 
> Probably just a list of reserved regions plus a flag to mark which
> one is SW_MSI? Except SW_MSI all other reserved region types
> just need the user to reserve them w/o knowing more detail.

I think I prefer the idea we just import the reserved regions from a
devid and do not expose any of this detail to userspace.

Kernel can make only the SW_MSI a mandatory cut out when the S2 is
attached.

Jason
