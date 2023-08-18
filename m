Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA609780281
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356580AbjHRAJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 20:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356569AbjHRAJQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 20:09:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0493C2D;
        Thu, 17 Aug 2023 17:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIR4Z6QuEgNAS1qjCKr6FB5d9YxkTMh+rlE1gwp5igPbbhmqV3dEiYjS0lwO7jIG9tgDvmZJemtAyttIPjNG/MBOCLk5AnaNArIArxV+93x/l0Jz1DDz1SH0tLMq9t0KbzQ9KbZTTTJ8wgjKrOLEI41O7HP48V0JAiYYb46pwnhLIzAIKsX49mRxN9efpRolnpn+BEiH2p2vArcVRDU+tpLSunuU5ZVph6IDoj20qlFMTkbYs1iuPGRn3CrgwKP3nzz6C00eRFMn8poT6DcY4e201fQpv7qTgkw+0fkQSWP2x59t/96FjV0D81UBF1lOd1ZUaLhK57Cr5WwNvRuINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5aaoKWr1Npg5QvKKgL0DlKfnmSsr9i4m43nlYQ7uMo=;
 b=ixfPtSeMZOA0nQa01ASAfdRYaljI2Bw5UqPJjmzUGqXizG+9BQCpi5mpshhL8syY+raM/TUmXZc2rqRsymIigbnaG+oJ4oZZMTHUV/raby1ED5dQ0dsmjrBpDSjGvEof8xA/9migWR+XLxDj1exVXvi0H5JCFPrj9cQcsmMgk897cZvo3048IQ7Euidd7hJLNZ66AURaRohG3sAw7OQRgdazwYZh5kb+WebZm28XWukTqzdzL2nSysog2nb1f09Ytfdet8XaGHl0iC+Qze9GpM1Uf5jqE/ds5EjJCSulIpwK8DILFKMbOGTLBLctJzY8KLaJlAgRxJEpD6ut3kbCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5aaoKWr1Npg5QvKKgL0DlKfnmSsr9i4m43nlYQ7uMo=;
 b=Lk4acWfbUOhYBNPFZW+OLI9ovG2DKAUsO6jCS0sEEopCV5Wttf0Bh9s3HFZQhKEZPZlTRdKaSuDtUeAjvsWOOWHNgpqeEPWav5IweTHrlLtjaUpLNMmSSd5Dap7x0S83vHUoJLzkpBzrxa7wdsx6mVjk246NeYi85imxm1sMhY3UNMSnpQNQ9oR9lLLVrb4CDlJwwDlWT8LupPj4ijniCWGYFNlGRBAVCX8DIPSUh6Br8FHnEh+N1BzDfOsS08Uo7dy58uObHOIScemIMR1rW8j+tFmF7s8O96YVI7YfpUZHCQpb0blTmpHZpTwmqDd1y3xNi53QosrXyw0Flnnyag==
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 00:08:45 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::63) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 00:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 00:08:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 17:08:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 17 Aug 2023 17:08:33 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 17:08:32 -0700
Date:   Thu, 17 Aug 2023 17:08:30 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZN62flrw24cVcMLq@Asurada-Nvidia>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
 <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
 <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: c57af4b8-cc0d-4ddb-5ab7-08db9f7f49a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj+2/8I7+h6f1BjGc371CppZLtHbYPT7H+2iSqNjV0emw9tvRuWla7/qxIGvLU0s5FBmirX01lfUbDwp0DvyDd2g1AATVHmD+p+RIHvkzL1RVhZcADa5Bbx6wkcjp8QUOztK6BwhzNlhn2+ROnIKwn8AVcxkkPtilw5O6uWIDwtRuhrlBPTEAc3t1iSaKdM6gw3hF3dvsWskE0+kTgGNiETuCu+i2Oxp9fj27qR+93Bg7fWK+DVhsGIgrcxDeoc6MPmHilHKBE/li9rUnq7xwRDqsCQlu9lPcwEopn9FON1+LxuvEKMlxYNm2Ldy9mVbUiQNPhv/M4ZZIWxOJcBtVMSanxnJd4zfajzI3aGIORETyhcfOFGhhBdpfQANlcpLsDZ7xPIA5w3GxZMNcGwrBh02ULWMhxlT15VLe2pjrLKTjp2CvIoCXOwumEyPDJw9TgJoSk+sUBUddN4R8WaLVWqklVzgNkoZZbJTMYKqpUsYKnxmV3VgWbQfBx3Wa30zn8UidTZT8BXMk8EXG6J25cRVVYbts5fSLoveXaK4M7FTwdHofvY0LCRKyxufqc2L/cUwkezknMnM8tkJ+M7lnpP3OT3FtWuQfZYkmHjMu1L7xVTnPt6jAX8tD6mPos/1GACP9W4TGQe75w6udqP2qtG2dVZwGtkier/Me51T0hZtm+9kia4dqNZS+9nYxt2BbdPZl99K9GwPOOzMRrjKIiV5WWnj2p/I8rW+pzGw93h6Bs7TBqejrxtyfH7UMDJY
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(7636003)(54906003)(316002)(82740400003)(356005)(70206006)(70586007)(6916009)(5660300002)(41300700001)(36860700001)(47076005)(8936002)(8676002)(4326008)(33716001)(26005)(40460700003)(2906002)(55016003)(40480700001)(478600001)(336012)(426003)(86362001)(7416002)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 00:08:44.7224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57af4b8-cc0d-4ddb-5ab7-08db9f7f49a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 12:04:29AM +0000, Liu, Yi L wrote:

> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, August 18, 2023 5:08 AM
> >
> > Looks like Yi's latest code has not addressed these comments.
> 
> Yeah. Not yet. In progress to incorporate them. 😊

I fixed them all in my local tree. I'm finalizing with alloc_user.
Let me send my branch after that, and you can edit upon :)

> > > > +int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > > > +{
> > > > +     struct iommu_hw_info *cmd = ucmd->cmd;
> > > > +     void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
> > > > +     const struct iommu_ops *ops;
> > > > +     struct iommufd_device *idev;
> > > > +     unsigned int data_len;
> > > > +     unsigned int copy_len;
> > > > +     void *data = NULL;
> > [..]
> > > > +     } else {
> > > > +             cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
> > > > +             data_len = 0;
> > > > +             data = NULL;
> > >
> > > data is already initialized as NULL.
> 
> Probably we can set data_len = 0 and the out_data_type to _NONE is
> the top as well. Any preference?

Yea we can do that. Let me change it.

Thanks
Nic
