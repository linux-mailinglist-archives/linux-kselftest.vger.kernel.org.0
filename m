Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32456E1103
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDMPZk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMPZj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 11:25:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FFD2735;
        Thu, 13 Apr 2023 08:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izBy0zhYZhiJKinXwQiO9vKZyc3WpOuLxn3oPmpY5pQOQQGfEwBP9lQ/voyFPrRIsf+mLZP2Ixb1naCoOXclew1S1xrYgJkPitiZpzZ+XA+kJ/TIjvAEBKJjDYixakBpNHysJWCH77Qe4SpxP0cNWubJNv+H1LT18dNNd3CbZETiXehD+wYx1u1bw7XPzayEAbYjIIJiOt6iYrTd9qcfpzziO1iFlnSZNF3SwsbaCdjPUUsbpNcAH1GyNItxDdPqIzvjPhEFF5UKjUGOKH/vUiGP3xi3eQUBKVU/q3l/42nBderpFexe2ivqUyuWSRaPvsnKiASHSBYbVWMhulws2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypv8l+79dwEuiUVIAdXpXEYVGH6y76Fauz7RwPzRIsw=;
 b=WGDKVq13BVHTaLfuW/pcjmlq/XmBLMdm532PJR9Sry+/Tl2zZuhgUjuEOz5PCi1EM3R+E/K9ftak49PJVTSf2uhSSyvIP07Hw9pcWUWCNiW2rP2sfwUtGv2SEtYBAU/W2g/HLRLx/5Strn80IX4hTv2uHGI0u+dY6X5ueZF12NMUretLVO3Sa4ZRPIHMvSDg0pWY8vuYbJnB69sc2WeSqVs3yyhE1WUtsQCg4LVIsJ8NUcfWMFTXWCZ71rjxfwo+0VN35Ol9STiufpsU4ieDxRShJTudb4XDHQAR547yTS6oVb+LM88/4Tnpy+vUwbvQrN8YVWrcCqfjqk4ABI3EWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypv8l+79dwEuiUVIAdXpXEYVGH6y76Fauz7RwPzRIsw=;
 b=Xct6nzMuGoVXGN+1PiVIJI6x7lPGT3MbEbXEaivRzBHnpc0eIe5XNu6IVGceB9p3fl/YPOl9NgA8Qf6HEOz6D/a28KjiaBbCjWuBV0/I/mQeXzKr0Q+L0jgpgWXDWb1vBYmc8RY/AYTx0ls1gppl4vT6hj6Ak2TufKYUBpzTgjwPI9f6DL6yLqH05o+3wNCH3pZxX4q+wVe27CnZpiYswtXgii8WNEKzIVq05tft4QvWXb7Lm450ctrrWbRM03o9dvQ44imAyivse3ase3Q5I47KpurzVjBRFTF6UfV3VEfnXbBilGICR/ENIjYJJoFl2Wl3z9pJ3M/vXLUrwMfAbg==
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 15:25:36 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::8e) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 15:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.33 via Frontend Transport; Thu, 13 Apr 2023 15:25:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 08:25:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 13 Apr 2023 08:25:35 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 08:25:34 -0700
Date:   Thu, 13 Apr 2023 08:25:33 -0700
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
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 01/12] iommu: Add new iommu op to create domains owned by
 userspace
Message-ID: <ZDge7fiLQqKqwAUV@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-2-yi.l.liu@intel.com>
 <ZAqAJgoQ3f0L2Gfo@nvidia.com>
 <ZDdQVEksXbeilBoo@Asurada-Nvidia>
 <ZDfpatOGY7hTkC/G@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDfpatOGY7hTkC/G@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc0f3b0-f917-4003-5d07-08db3c3354ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UQUvYMHwcmoKeF4hMMFhI/yFr6AC1iQ7tts0Olll4+P+qk2D1RAc31pgRTMLiSvV8aJf50JJWCbgZnCGbTfAwLDg5KhnkrZSVmnfWsSc/X8SU5JD63nzeGH1a0qbaJBx9jWO+ltvdFTeFjdQYvfzpIMeIr/zktV0gGivODaucgGiQZ5Pnxhwm6KTKdKbr1LmN6EckWky1JqxR7EuJ74HRt5mW7fDDoRmsg4I5oXhqKWwFtu8weQW0nq1gOz3TVxItD4DNILqWivO2pnWFzI+WjyqVXhKyW/e1ITEDoyEGBh/DIfE6Hx3uS0o1BTH/wePD8TKqCzDK6J3wnQI0Q3kh2kkaiZiAZa4xYtcNfnyl7LAuRwro4Dw9JDaWUhM7ohWqrQg/1RBrzPkbhUVHwWpWL9znXrtUgVr2blKEuTACzBoqg/fUA8dYQVehT80YfhaOxv/O3OnkNRBccwMFSV3qrAuj6fuzIhKUmnW3l2Ucw2BS9EdZGrVuz9G8YC3tud6xN7Bo92McyyvZkPtz2YLWduvEhbjn2qTqWUbDqG5Q2pEBkM0QUOJN4NjNfQwWOqdq1Hc4UIerOBCatuE7Kx/qBoy8wNBYNs4uLDD0s9uFId1rKAtYYaAc8tqep31p89Lm9KsZFta6y8vnX4RdhvwbNT1kc2J52BWBbuVenVUNnv4fHqkWSACCZFjwMDJXHW26LQhM1jfz2u8LbUb1OO9os75hq6rYN73mh024fifwpH/Az6SLj4G5zQU9eYw9m8pZK7lNiOmJo5NnTNqB6xApQzcvK4rKElzeTldLl4/ys=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(316002)(83380400001)(34020700004)(6636002)(41300700001)(33716001)(54906003)(82310400005)(86362001)(36860700001)(478600001)(426003)(336012)(70206006)(8676002)(4326008)(70586007)(82740400003)(47076005)(356005)(2906002)(7636003)(6862004)(8936002)(186003)(40460700003)(9686003)(26005)(55016003)(5660300002)(40480700001)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:25:36.5197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc0f3b0-f917-4003-5d07-08db3c3354ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 13, 2023 at 08:37:14AM -0300, Jason Gunthorpe wrote:

> > > > @@ -266,6 +267,9 @@ struct iommu_ops {
> > > >  
> > > >  	/* Domain allocation and freeing by the iommu driver */
> > > >  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> > > > +	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
> > > > +						  struct iommu_domain *parent,
> > > > +						  const void *user_data);
> > > 
> > > Since the kernel does the copy from user and manages the zero fill
> > > compat maybe this user_data have a union like Robin suggested.
> > > 
> > > But yes, this is the idea.
> > > 
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > We pass in a read-only data to this ->domain_alloc_user() while
> > it also returns NULL on failure, matching ->domain_alloc(). So,
> > there seems to be no error feedback pathway from the driver to
> > user space.
> > 
> > Robin remarked in the SMMU series that an STE configuration can
> > fail. So, a proper error feedback is required for this callback
> > too.
> > 
> > To return a driver/HW specific error, I think we could define a
> > "u8 out_error" in the user_data structure. So, we probably need
> > a non-const pass-in here. What do you think?
> 
> What is wrong with err_ptr?

I see. That could keep the "const" then. Will try that.

Thanks!
Nic
