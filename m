Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D37C8753
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJMOED (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMOEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 10:04:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1625BD;
        Fri, 13 Oct 2023 07:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsQaYWNgxGtdSWsa3o9vz5j9GgO0omISMvIKkNeVXisJghtrHBKhOCWXadWT0GICkCUc+55mhdBcjHtPxzcQ6HNvvueIvd+ckRWkgwAib5DzZs6IjfVo9C1kViDfg7mQWw3OvIf2Y7Vu2lvFCGn4VNJ2gS4xX4mhMBljtoVZT/pxtvphr98f8Mw+KQz47/JbeOxiLDDhCixFQJGEqLPC6RdZTKgXMPJIRay9z+zOFelyYnDWnbz40k7bAM1weKfHaZi+DtNX1jn+v4JugIi51RXnmTiV23Ztj8mRJGf9oA+nqoxVGRFdgfASDMzJP2aM+Tff/7WHSPFr67vlnENCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM5mqRHNuoiBybh6+M/0F+mRF9Ta9oF/jn9jea0dqcw=;
 b=Fk4iBRkFIW/pkWexlnG5f6tgsbYlIKMXn9magTB7bqmLX0/B6U4ihkxSGm+Tb1IoIcUJNcEF7mDoFFXf/6WSOjNJ/PuTdJW/a3VEjdTJBdjYcBdiRUXPnDJ/RO97fz0odz9V1XatNw4Okbmy0XDR3zjuseIFVUGUlUM53XHPg4Hhreh75R8+S8sTN/kTHqFakkW1Z+vF7rgTzMe38kq0LjyGxLRzFFdYEdgdzpZDcUSOYCL/WkSfepkKJ9LE5TNO9Ao8jJ83Ou0q2hSFPHOVjMjOr1DOIUk3um4/uRb8zl43dMZx/RaYIujKnZUIA+7GTqWbC/W04UYocytEkz1TTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM5mqRHNuoiBybh6+M/0F+mRF9Ta9oF/jn9jea0dqcw=;
 b=gINvxmIF26Fgf9xlvHHgemfjNTJtfGRX+SQ75Fb5Hfs9sVdvAildCYNsSXRHpcE8QvjKR3LSNZ8dNctHNwRyhTg/SyGGxe5MnSwlPBLQ0B0kHp3f3ex602er8XEfukaKTnl36tIzMfxTP7SWBIAE34J4mG6eT02m7yf1wBgMDYEZjnINyq6TosS677jCMrNtTjvFiSRK5Zx1XhA3UinrX5cZGLRvslidaWsDgU45t8/McCWuAnPadmMTIcoKPGd5t6QCmRVnWZtWMlIzrpQd2JyD1wl/khfW/VnGsM6j8nCidJ7GlB6WYNihRmRf9RlGf59GoKCbDNA7RP+SOEvN/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 14:03:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 14:03:58 +0000
Date:   Fri, 13 Oct 2023 11:03:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20231013140357.GQ3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <ZSiPH4WlGrbKpdfp@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSiPH4WlGrbKpdfp@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:208:178::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 51549654-a768-4b4b-87ce-08dbcbf53ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AHfwyENaWjG50SHwi6VkRbc7OWw6UUvhvFVr1xpPYdwI64Rtc3OK2bRwdqU2WfXvC0sYH0a2KO3ia/AVNMXZs0fjPmniiKcihYeqoZ3wtDTLqanrvQOhZtg1PBCkE7Cg2cryRYQEZomNXkYYcydlJ6gKP6IumXeV5xEnqZWoDzvtCHG3zrznj4RCsNTpcazReP/AvvTPs+a1ebrY6tVqhZvqv8n9jzt4DZ/iibP/nN4gKQsjgpAOP+gyoaqMbeIWcgJuoVJ7+OzbB7TwdWEaMLQreoUzizZPa1j4EE/QlPZt4+WFsH4qcazVTKLoRPirz5snt+6N4HaUFWMHDav8NqaOp9dOJM5MvIhF14qJxUvoyKHy+uwYZ5yaucQfBSsfFN7Ke6o5xf2859EXNpnnUSJAE+goP7wMLEnG7HgvSe0SO9Pg66ueQFZCPzKd2K9uQItTCa4iTTEkAW7zo+i48IOv17nrvUIyHw2rGdjhEOM//DubT55L7UCjYy/Pv1l3gJxNHlU9e5rSChu2v2tiOQMLTjpYX2XXR55xYrfyMJmk0/JL+VWT/C+3nDmB9Yl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(316002)(6636002)(8676002)(38100700002)(6862004)(8936002)(33656002)(86362001)(37006003)(36756003)(4326008)(66556008)(66476007)(66946007)(6506007)(2906002)(41300700001)(7416002)(2616005)(6512007)(6486002)(1076003)(5660300002)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qRtn/FVolHxLM5Dlxcge27x+dEi45NR4EyoufFw812iMfn2A61ICWiy2us9t?=
 =?us-ascii?Q?q+X9Nz7+WBx1CIDZMQ4xAkvCvFuQFNNG6SEFK7DTtOyqliCNeQif3wtBQzxZ?=
 =?us-ascii?Q?MzvEL4965RjASKzUa/x4SKPWfunNacnkYQ4rehKuw+KcVKxhuE8n5NN56MXl?=
 =?us-ascii?Q?P1tgCgPKTEC/Jo8OJo6ffWfmRho2tPeyzp9ycmxEFqs8EMUblJnh7ochmmSu?=
 =?us-ascii?Q?9Z3piZYFuOXk6uGXNLqe8Kav3Rv2MaSo2SIUDbYMcpnx1xAtGq9m1MaWKO/C?=
 =?us-ascii?Q?xUt+CPpoY6+N52VbNgAkbNcjPTe7ioPU3xJnYfin2TOfn9mPexe910MqNvsB?=
 =?us-ascii?Q?9bmF9uWXijw5f1TXdKbMeBG5cEpV8f8lrVh64n0MggA2ecXc/E7JnHglhqv5?=
 =?us-ascii?Q?Jc1L8H8Re57Dh0WNoGFfjFp4r2ETqqA/bEBUxmRDJDMMh0elK67MP83FYs9Z?=
 =?us-ascii?Q?w5MPz2qIjjqbGmL1+p2eK7qlpGqlvvJXq1ZCP7pmL9p2IbT4XTKvXWas8j7X?=
 =?us-ascii?Q?NC9TYNrxARVt2u6k8Y3+Frs9Fx4QyinYeKRmmA6ZEPHcbBDwaQ6/y9BNHmSR?=
 =?us-ascii?Q?7Tta2/mRNL+8tYuUs85SATy5K9LqHNYr9d0WAkquL1gBZ+oYEaGPag++ZF5W?=
 =?us-ascii?Q?wIRYLzCdpjWh4X15yOM0zOYsu7P45dVnaf1Mzt5snYeLnz8lUBNzWfG71917?=
 =?us-ascii?Q?VnfcYGcr4Yr0cBDWBWcG1s1dsCnSrncZEQoDXEVx5TOgHzt47lKTiBswYFXZ?=
 =?us-ascii?Q?88n8F9vSmPPb1JBRktcvfnd/G8OCu+HWO68ef0Kr954NQK/t6sMA23EVXY+e?=
 =?us-ascii?Q?/eAwWT+qqyMVAlAxPxQZmmt+bTaGb1KrrDvx+6MFWGnIp3x0NMCZR1Kow4aw?=
 =?us-ascii?Q?d2DNzt/fIAwzBpnklSXDVQjNYmRtxC7jZqHhLGYUMG9cTvbTgP02itB6/uNo?=
 =?us-ascii?Q?Mru8eYtGlYHUE/YhZsge4LKqSDgzOiie++GIo9+BZRGB/JkAQXAoEt+NXCeB?=
 =?us-ascii?Q?fKdJ3zOFjP0YJqPsUFvtH97BXq0knDemtFwWX7XIpWUngd+GjJz+0sqI7el2?=
 =?us-ascii?Q?UC32TPBjgElGSDZs5tAxPZgGt+ng0HMMJb//dKtWafynHgvlLVXGcYubXPSM?=
 =?us-ascii?Q?bKEvyFnaS97tEK2G4CgV4z29G2DJt2OxKV6b3HiVyCV1vlbxwSjU/XDR8EMx?=
 =?us-ascii?Q?c0brgDkQIRAoUN6aip5lN0ZlyI0cMJhVrjv32vzsHLr9KvSXTv6nZesSwS7c?=
 =?us-ascii?Q?10at5WxGev84vKDkeachUb+eDprPWMct7+iMRyrWP7Of2d0vELePCUAhBAq2?=
 =?us-ascii?Q?X0sTk8UKoKvyhOFKRrHNvjRGuiFfgywt3GV/0mwhU+cdcxMMR1pZn8Dr06g4?=
 =?us-ascii?Q?alKEcFiUtZmsxfzfAX9IuZZvRVXPlvQFPyD2p6i3KwYnjwVtXd/wf9fl4+f0?=
 =?us-ascii?Q?pLxFy/VaYiM0Ol9c62/zGWmyq3P+U7vGF79KbqatAWiFaF9m3pNDPsh20CIq?=
 =?us-ascii?Q?hP7Al2egs1RoC6ijb1sI6EDKzkT8RzgXE0XVXyGAWuU03oQaAg0CFTUBXlnG?=
 =?us-ascii?Q?h3IQUkFzYWcDeqHfUec=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51549654-a768-4b4b-87ce-08dbcbf53ec4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:03:58.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fxvEC2YTHlYQGfYc8mjdSUFGhDix+4WaATE4r6NksFRcj7O/g46ephe6p36Sqn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 12, 2023 at 05:34:58PM -0700, Nicolin Chen wrote:
> On Tue, Oct 10, 2023 at 01:58:44PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 21, 2023 at 12:51:22AM -0700, Yi Liu wrote:
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 660dc1931dc9..12e12e5563e6 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/of.h>
> > >  #include <uapi/linux/iommu.h>
> > > +#include <uapi/linux/iommufd.h>
> > 
> > Oh we should definately avoid doing that!
> >   
> > Maybe this is a good moment to start a new header file exclusively for
> > iommu drivers and core subsystem to include?
> > 
> >  include/linux/iommu-driver.h
> > 
> > ?
> > 
> > Put iommu_copy_user_data() and  struct iommu_user_data in there
> > 
> > Avoid this include in this file.
> 
> By looking closer, it seems that we included the uapi header for:
> +	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
> +						  enum iommu_hwpt_data_type data_type,
> +						  struct iommu_domain *parent,
> +						  const struct iommu_user_data *user_data);
> 
> So we could drop the include, and instead add this next to structs:
> +enum iommu_hwpt_data_type;
> 
> Then it's not that necessary to have a new header? We could mark a
> section of "driver exclusively functions" in iommu.h, I think.

Yeah, OK, though I still have a desire to split this header..

(though can you really forward declare enums and then pass it by value?)

Jason
