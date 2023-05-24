Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71570ED12
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjEXF3c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjEXF33 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:29:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31BE42;
        Tue, 23 May 2023 22:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4b+fQv4JoFY4hH0XkJRifxXeGZHoLRlS3Qegz5rk+QAGTnVFJpCLPiIKHY0RHevFa75MhY6+jUAWjkRpsuxQB1MbLMOrlIPsyR5RvqSogMmA2+710Nsqq80sU7WwTJwnyRBDvJ6bA7lN/sXGngYCr1mt9dr3YKpJOOcLRQ2lLSVTsxRGy3m6x4Cv4xwqHAFJLD7K9smg5K7oP0hIxxyn8FmuaPsxJhI2S24WZKxQIMWuDM11NtdvEMQVAsh9OV1am6h6MTGoY7UjTxm9ZTK0Dzaalu7JYsggGfs0iWZsn0XsTukWmuKU7SrmEE6NXeE/GIWFKisAXFJ5N0sTQvbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvfwQoZfrqTObA72tgti7k79DDvDqAnry1KMIR7N3iw=;
 b=l9GkFmQPoPDrgl21opvExFfOvIkfwIzObrlyi29Q0hn7erOK3fkI3qs+OMhcj9Q36FImn+Xqh7wyjwPrLxCAqxZNgEoaqfcfNTAlW6WZFgPuJ18QNpLSZ1r2/AIagcYGpBU0+fddeYfzpdCpaT56AH7abbYLkMBvKRWGtOJKA3tmkp8DHf8opsNUZ+roSd20Tz8ueR0GlpEBsCcC7zO28+YBMdbbUZbsUnLCJCVBTgSKqjzrQII8ewBpEBMGAiuTIr0WWhX6o/r1R2gfPhyM/K3HDk+39rXRjiZvE4OtIjauPyBHV4R4QLctkgryknWU8cwf/JxFdYkQ7Tv+W40N+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvfwQoZfrqTObA72tgti7k79DDvDqAnry1KMIR7N3iw=;
 b=OsumY7yaUOdkAkL2EacWUtfFmZd4i/IJQguipc7HQfWg67wpPfdbRpDxkiGsx+VUtazL1rMk5gSfUZR5TksuGRWhhU4xbS00FDDxcHVaOwK8c9ahdWkZDljuyzhOG8VRj/9G6PQ73XPYVWykg7nu/FU3O3rQQToBMGDPbQDa7IdvDiYjvOUuOmtETQFOheApUfiNxLqAjuVkk+hbKFDw8t8s76/jHtU5eGedfcNvY1nBcw2rAOtiqJA/C3WftrpXCJOBuwOofDZFv54zE4VLle+AxnDeT30ntRaX/3S9cnSpckKN2GgFyEpS0TUUs8bvBmcg67Qa9G6+u3d7GCZBMg==
Received: from DS0PR17CA0011.namprd17.prod.outlook.com (2603:10b6:8:191::13)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 05:29:06 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::b8) by DS0PR17CA0011.outlook.office365.com
 (2603:10b6:8:191::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 05:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29 via Frontend Transport; Wed, 24 May 2023 05:29:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 22:28:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 22:28:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 22:28:45 -0700
Date:   Tue, 23 May 2023 22:28:44 -0700
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
Subject: Re: [PATCH v2 02/11] iommu: Add nested domain support
Message-ID: <ZG2gjCdz7FoggnZZ@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-3-yi.l.liu@intel.com>
 <BL1PR11MB52717388249F052433A7FBB08C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfEqmD0mrE0NTDW@Asurada-Nvidia>
 <BN9PR11MB52764EEC5A6048FF2487F61B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764EEC5A6048FF2487F61B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 50647eb2-b656-422f-9b58-08db5c17caae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6BaTrH7Ex0x5mToGJyfMKmD6z1bxlGxge4S64oeKeEZTPtdMydje+tVb+cWBPPNwRWAEe8vZ3kQFylORzz7lkU86wcZzDkgdwHyyklqMNwtui3/SqEsxBGGgK2rZ+LIZkSQ/BE3ioouzI/cRFfFaIvNAII1RJzABJZ7PdGKZOP0T9QD316a3BzDZ5Rh1vyu//lHNB/ylbmBOhsO07caibWJRas0Jedmgzv4wLnEvDMJzLyfLNQXiFBm3kDdme7IbuDDby1YGguNQ4wULTvcGD4j8We3MvDo/yL9WIKD2jS3eDy2+M9t0p1+zL32HEaIyN4VvEzA0hUl9+c2LlEi9hVOTXrSU59kKfcHqoK7PdBVdKmV+0vCjIqmxxgFIM1h0DCAgxVxQLi+AxiTEUQI9xygWzOmB1aYwRfskPkaO1ktU9Tu4rZWn9YFYRXUd1vcKfBGPk8aKPeYjfRPQBalDl9Zi7zGirLnOO+rBD2VxxmEZidgPKUcsW4WILjkYmeaX1IqZyZT7fOVk8X8iBaqE6SKTFNQeyxify78XFHUk/y/mQR5hAZ5Q8VJEVe2/JLSYffO7QC/pXyI86dmgFRRFUgOf+v78SkmYzmCbLbx6puoe3XgjhH2HLbLzTUOZULBDGuVBCE8tkHqCKr2Fk2wBYF/Hg310krSM7rEmtFyLxpGiXEiWrv0MsQnsLrK14/CkrxDh0SE3WF9dojtSDaAh+hccUpi2h8GhLoexQM4dFfD5HdMi0XDyb8ztNACL+9W
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(8676002)(8936002)(86362001)(26005)(9686003)(47076005)(83380400001)(2906002)(336012)(426003)(36860700001)(186003)(7416002)(40480700001)(55016003)(70586007)(70206006)(7636003)(356005)(33716001)(82740400003)(6916009)(316002)(4326008)(54906003)(478600001)(82310400005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:29:05.6094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50647eb2-b656-422f-9b58-08db5c17caae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 05:03:37AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, May 20, 2023 2:49 AM
> >
> > On Fri, May 19, 2023 at 08:51:21AM +0000, Tian, Kevin wrote:
> >
> > > > @@ -346,6 +350,10 @@ struct iommu_ops {
> > > >   * @iotlb_sync_map: Sync mappings created recently using @map to the
> > > > hardware
> > > >   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and
> > empty
> > > > flush
> > > >   *            queue
> > > > + * @cache_invalidate_user: Flush hardware TLBs caching user space IO
> > > > mappings
> > > > + * @cache_invalidate_user_data_len: Defined length of input user data
> > for
> > > > the
> > > > + *                                  cache_invalidate_user op, being sizeof the
> > > > + *                                  structure in include/uapi/linux/iommufd.h
> > >
> > > same as comment to last patch, can this be merged with @hw_info?
> >
> > I think it's better to keep them separate, since this is added
> > in struct iommu_domain_ops, given it is domain/hwpt specific,
> > while the hw_info is in struct iommu_ops?
> >
> 
> Just be curious whether there are real examples in which the data
> len might be different upon the hwpt type...

Likely "no" on top of my head. Yet it's a bit odd to see the
data length for cache_invalidate_user being added along with
the hw_info, since they belong to two different structs, and
even two different series?

Thanks
Nic
