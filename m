Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241A277827E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjHJVDF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJVDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 17:03:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811F32704;
        Thu, 10 Aug 2023 14:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmyO/Xkx0hwBYH++lZMATKY/H63MAlCRFKIn126KqxXDXv5LqkwC5crIyF8+3DvO559urAtqi9OGNlVCF6iR20AqeXlangX8+yOyaDkLhuvTlgpX3MgajMPjTprDGoamHSR6ibKNAe/tuB4+O/XeKu+h6oek/OyoXirDipRx3fv42ax/34cpjgDDygvznAtQIouQns3UhJeUc7dwV5DiR8yEQXwbpfq/09GEvZ4YRrjlLwAd6WMkJFSUM3CEKAm0c+YBbGhFlo5QIU6Z8cvJ/N1A0ZrlMgwgd3evpUZH3LBkqYlaEcds1PZ5ZpGPJSzo8sa6DakcPwsR/sGifOvF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu4AzyScbEr9wdNlD75ejP3HMCwR+6elq9MSWuprd+8=;
 b=hi0A6Za+45vUI4ov890ev9JcpDsP6g/3gwAcTTFOE7XIOZknslOof/pbj3kGDV5mohNm8MP9tla2oayponCnqTv5ydZg77IWI0az+wz9n37pth1lTblRxjykWHDdn9WO/2HZs6t9XjlypSxY/cXwH37sQQZEspzT/f6dBq+yPML6pCmrVsLxbHUXMc9ZV7wdzuWhnorMP5Cfowzx4iUlpeXX/0Nf3SFX2tHKwTjhTwYHtn1QLClWr70bAMZLitfhx2nO/8PcdwUdeNYJnzUXr+XaCSk6fHusBLsX0psUOgjkul2Z6cluz/xvvJUgUHTWgIaZfQJ223VV6fWmj5Uucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu4AzyScbEr9wdNlD75ejP3HMCwR+6elq9MSWuprd+8=;
 b=gxTQvlrJk7squYgcET/x8jgtaX8YsAdg5zv5Xyd9rcMyVzdbmUDr9iDyJJ7wVqDhA7GMnnIerHyS87SdrPYiO9BrjUO5c63HicjbM2nYEDrBDpVoab7H1J1VOolNXfFAEyzrjvCTwgGVj/TxCK3GtIorI1R2mt3MWxyZXZD24NA+2bovL/zXwCS9XTj0P1JsSGO5ESnQENM+MCgUNlV1ITxfH2UTJ1cdVGKunam3STc5ZpNT3KmUBsGXgnHj/We/32r4v02BILOmyrbQEeQNLqZMFpINFvbHntQfJT4M5rpWzHATQ35zCIUFu44OlvWoZdupKPqi65Btbmz0Ax0+Gw==
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:03:01 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::3f) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 21:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Thu, 10 Aug 2023 21:03:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 10 Aug 2023
 14:02:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 10 Aug
 2023 14:02:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 10 Aug 2023 14:02:43 -0700
Date:   Thu, 10 Aug 2023 14:02:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNVQcmYp27ap7h30@Asurada-Nvidia>
References: <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNU6BnTgNEWlwNYQ@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 7233df6d-f93c-4afb-00be-08db99e52ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guU1s9BnJCWId/SQXiuCBBTwOMzVRbOxHp3NsIUvtSolkeeu+TRzO3oYCWBDsZFZjQ7HjCwpO21FsUlaPALtDUfSAfNp11Zw4g3IQLZyxXMk5GH6FTxO48oVcaagNJ1KtCrGirZpV1gO+nFe7Nvv4X7SSAGFV9o7YOMXqby/tsMq1n3Cy6m4fg9SaO9avZktIOWpsWicaLVU6ywl/WidyYZflmrC+hdbgW6rIjGXBfc1q5uZcanAOzRm/k1/XcD9fMISd2j3ratxpjzay1qA00UsjmUyimgvnJA09KMWwFVGxsuuhkD8oD3rZkIXVZrftm19VT8l1vtE0wPuzHYYnXQG5WGaYcU+Qo6n/EiJlAmkQ4BFX+FemV6nFAF7y6kxz/YjCcKFFkFa4so/SpgyhqOfKhLLFRTSm5sexcL4EJqPZNhvmTndkw81RjWygWMZfj8oTjSKLwEVqx3P5owAHmdynhu19CoEbtrT9gT80njN56fgvrhkcqEJ7v2+n+j83sYEkpSu7X4EUif3UaIyh7jK4FIH/CFHNZSpfKvAWwafM6WhHhoD2IBM9HbSvumlasjFN4KX+WDbMGoT7NsM4YwXZWFuZ0h9IUUoLhHturGqZWyL22sKCv2+QM/fWskP/9meYzyLrZoBZprT9vmm0/Gg3zvNZT3dUshcFLuMKdmyQMyroVNjDUo5f5QKZQWQAtCP/G9uGthIu4Ix3bu/BdDdWYOcBLosczlWJr3pGvQcKx2RGBVDvUlKCTwEy/SP
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(82310400008)(451199021)(186006)(1800799006)(36840700001)(40470700004)(46966006)(70206006)(36860700001)(478600001)(6636002)(54906003)(70586007)(26005)(336012)(316002)(2906002)(41300700001)(7416002)(4326008)(9686003)(5660300002)(7636003)(8676002)(356005)(82740400003)(6862004)(86362001)(8936002)(33716001)(83380400001)(426003)(47076005)(55016003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 21:03:01.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7233df6d-f93c-4afb-00be-08db99e52ed8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 04:27:02PM -0300, Jason Gunthorpe wrote:
 
> > > Do we need to worry about the ring wrap around? It is already the case
> > > that the VMM has to scan the ring and extract the invalidation
> > > commands, wouldn't it already just linearize them?
> > 
> > I haven't got the chance to send the latest vSMMU series but I
> > pass down the raw user CMDQ to the host to go through, as it'd
> > be easier to stall the consumer index movement when a command
> > in the middle fails.
> 
> Don't some commands have to be executed by the VMM?

Well, they do. VMM would go through the queue and "execute" non-
invalidation commands, then defer the queue to the kernel to go
through the queue once more. So, the flaw could be that some of
the commands behind the failing TLB flush command got "executed",
though in a real case most of other commands would be "executed"
standalone with a CMD_SYNC, i.e. not mixing with any invalidation
command.

> Even so, it seems straightforward enough for the kernel to report the
> number of commands it executed and the VMM can adjust the virtual
> consumer index.

It is not that straightforward to revert an array index back to
a consumer index because they might not be 1:1 mapped, since in
theory there could be other commands mixing in-between, although
it unlikely happens.

So, another index-mapping array would be needed for this matter.
And this doesn't address the flaw that I mentioned above either.
So, I took the former solution to reduce the complication.

> > > Is there a use case for invaliation only SW emulated rings, and do we
> > > care about optimizing for the wrap around case?
> > 
> > Hmm, why a SW emulated ring?
> 
> That is what you are building. The VMM catches the write of the
> producer pointer and the VMM SW bundles it up to call into the kernel.

Still not fully getting it. Do you mean a ring that is prepared
by the VMM? I think the only case that we need to handle a ring
is what I did by forwarding the guest CMDQ (a ring) to the host
directly. Not sure why VMM would need another ring for those
linearized invalidation commands. Or maybe I misunderstood..

> > Yes for the latter question. SMMU kernel driver has something
> > like Q_WRP and other helpers, so it wasn't difficult to process
> > the user CMDQ in the same raw form. But it does complicates the
> > common code if we want to do it there.
> 
> Optimizing wrap around means when the producer/consumer pointers pass
> the end of the queue memory we execute one, not two ioctls toward the
> kernel. That is possible a very minor optimization, it depends how big
> the queues are and how frequent multi-entry items will be present.

There could be other commands being issued by other VMs or even
the host between the two ioctls. So probably we'd need to handle
the wrapping case when doing a ring solution?

Thanks
Nicolin
