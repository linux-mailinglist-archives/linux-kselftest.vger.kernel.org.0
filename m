Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458AF74112E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjF1Mgs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 08:36:48 -0400
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:62398
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231526AbjF1MgW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYG8phsstl3hwM1tHpDKcp55C2hm0z9F4AhwjtTkLETp6GU+AMEvDUCj4MQUSDZJnVgiSxZ6jnew0Wx23Orz3buWTj/2YwRW45QpUsp5yBtBnnsVbIYWir7kaBHWEBo3/6+jl29NsvEddBliWQMG3ZC/XyazXUaFT6XYNDtgOROIn/YozOueXxCQXMaKjuh3xo2mEwMJ4rz106siu2ncgYbOYU9mJo8kxd2IKEiUWN5oGtSkrgtf0hEl9lr1+d4V5n2Fhfeit+vkL9x0Vl2nCP+XqJF1OR/f4FI4So2EiEwbV+0TVV18yekNguYnkbLCR5l7jpnl5KWIiZ7i7NiGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mge1M4XFy79bx7z4xx4CmPwdbJFJbbzOFGEehEjNAJY=;
 b=f0ckeVbRpVnBJDJ8+M0PjWhu5feSP9tI3gAYuapEBDVupx1149XY6wbNTWhevWiZyv1R1GA4rAd2sZJ4b2KJwPJnxyOkQzVzWNsaBB1VwzYaDbi5aw26b7YyUEdWi3mH8vj3OKeL87e63HcA6i2f7FeuwZGiCjLCYzea/MJrOvpfg1QBOb6EKcl5Ra2MJCRvRyvEoWp3wmjmX6z8d5k8XHtVxmFBO1e3t9Gmk4ljmUqd52DfH9VEzMk+ZtIkE3HfOWmC2YDO0nd6T/Zc2yFBTkn5Z8ZVUPyuG4aOBgBnzeUZdJuA0hK8/u1Sx4HspQDKQ518I2uWfjxghDSqle8Mpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mge1M4XFy79bx7z4xx4CmPwdbJFJbbzOFGEehEjNAJY=;
 b=SyM3zqlLl44lLJv/9LQ2sV6Ws6UMdqyCMhUH3aXJ0KUgtP3AFKyaJB9FbuAWVJZ90Qnd7a2NYgrQo1hlkOn+2WnSNQpjZ5X/2jxQStLY6fugY0koF/OL1HyifUymHV3vilw67dIgw+X3r46QggYPOAMaJmxyC2u0WWOrPg0pCN2AMpDqAHikzU6cZ+DKlBig3kyCm0yLUAkK0rtbTmLCXJT89FOkpOSp075jXOdjPZrkKnITd7G5iCxgpnpIeY4q4NWW2BlH3zdzMN34JIV2TbB8XZ4+PvzYNuGgr5/Apa7tuH+P4cBJwvcES3Xmghx+lZHtv46CsxMpQiY2skoYNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 28 Jun
 2023 12:36:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 12:36:18 +0000
Date:   Wed, 28 Jun 2023 09:36:17 -0300
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
Message-ID: <ZJwpQV6oBBsIAtHD@nvidia.com>
References: <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
 <BN9PR11MB5276AA174BBE2C4A91C5E5338C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJsH1NtUJIDfUthO@nvidia.com>
 <BN9PR11MB5276BA9BBAFB8BCC8B339AFA8C24A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BA9BBAFB8BCC8B339AFA8C24A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:208:fc::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: a406f046-bf27-40c9-8acf-08db77d44567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWecGsArctsq4xBYpuBytLC538zLOW8XW9jTvipKH+V2ik+t4vkOIN9nmS9BmKGB2FcjGLVhrp1KcQ7pUgAdQUaP53hTdE2BZHnOyTnX2c+zVGKMGdOLN4nheRk7UViEJbrhKSit0imgW2tO0rwr1uqsKp/D59vVCVyAhiwaZkYm28RMedJpg71gt3sPzLjs4b4vgiSBiOw1dVuV1/8epZLDawgHGJ59R9M5+MAI4bjfa/qG6nhWhgNy4pBEXrUJAes2mKh7VbNa58rFK/KqOqjcEH3h7BdH4A1jUqPvdYHj0al9EQswfeThjZCWbcGm7Qh8VsOUmwWYNB/WY4cE4PxRwDD7TbTRYeSrTvDe0Kd2yOvEX1WE9fy44uhJWvGce9HYGArW6aaaC6/OQ/esRFzVWaFhCRQo0pVPcW2k7ApA/2PK8wK+jW1lDHqNi582C2nJbxDkwVoIcIgH6UG1xf9xtOLe5v5TSIel45+94f4PdJuD6Jkmm32IuE9ygwPX6awTQ1K6u2YbxMAc3dOEGWBHqU9Q520OMW3JPBAE6+YgsDRm6WaI77QlwGJsmP/D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(8936002)(6486002)(316002)(8676002)(54906003)(4326008)(41300700001)(36756003)(86362001)(38100700002)(2616005)(7416002)(5660300002)(6512007)(66946007)(66556008)(66476007)(6916009)(478600001)(2906002)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6gq/VrV+ezLO4M4WC0d6nQU+PBe7UP10Au8NY7BrxWlQp0HEzAsZ89wNF+Gi?=
 =?us-ascii?Q?ySsRYZc9h61UoVWb0ByI4tA504d3OMAo4r5E7TEVvQyLsLeOZdrMxY9Uvb2z?=
 =?us-ascii?Q?JNXV7S8iSZEvlliSSvkKrWqwe8/C9mYW7rQYwHT7TDZE9wmb5QwXPHLU6Z1u?=
 =?us-ascii?Q?MxCzXNY8ZYxQ/x6VNq5LEk9r+fommzoibXR1yeUM2x7NlGDZF8wBTp57bi4v?=
 =?us-ascii?Q?jOmbn7XtbkECeIdAG/7CrmD8j24Sc9FWJQVjvSkdJbUIpzAj1ufUmgszy2ur?=
 =?us-ascii?Q?1U3wDHlStNLk5obgRsLhcER070hOyXgOneYrhX8G1ewcWyZS/cauTh82Etvv?=
 =?us-ascii?Q?9F0rIqaU1h785OlG0pxc/gPcxpwyLDA3QUc8yl5aOwx1+WhKZgleTyH2ovyq?=
 =?us-ascii?Q?tLrO/PLbxx+59cAk2Q/zfFbJhHSOHI2Vzm7agIAM4wau5EvN3/t9+aWflkDS?=
 =?us-ascii?Q?FH9vci0hThsoBBLZBV/wGAkSoG1yLuIvnGpkvZOwwAonnJyzjUBFKIg512Oo?=
 =?us-ascii?Q?Ht2tbrULJzAJsDospNf7Q42tqdmKc0JRKRJqD3Hh8hjvfdGY0oXwO5wweSXr?=
 =?us-ascii?Q?nGh1UiSGz+bgQBh1v0uk5VJx77xDSNwjByiPBNfPVa70galqA6e0pRf8ZQ+c?=
 =?us-ascii?Q?CN+hnGcjKGSqFf9X3Nm1qwvOxxa/Z33HzA2WGsYF68TUly0zXFilnG/BFbmH?=
 =?us-ascii?Q?vF1LrCWANxyTSTMcjd6GHHbmPHHDnj0gTykZQEbDdf1AxpdUyDZTyejx+SKu?=
 =?us-ascii?Q?fJ6nUjEj+QmBr95Sn2lcw33Mwnr6YJnvxzje6B72D2YUwNz4EmSYEL+4M+4j?=
 =?us-ascii?Q?b8nD+63EQZdAAIathBkYrcHzDHyaujUUxV+2q3cwTzEEST/ij46vWEVObKTW?=
 =?us-ascii?Q?z2VPEjzx//kaMZ5kCwqfrURQIQZb9oLWXPGXAzc7JKzJaC0q5cMxOZTwynhJ?=
 =?us-ascii?Q?lh7E8lZjp7PCv0J3949XRoKJXSVcz8svgj4O5su2k7QlsCI/SOtulSulpXMB?=
 =?us-ascii?Q?6qbZs/yNlD1Gh2K9X2BIFPgvl0K5pzwvy9QfyR4OqGLb8tdm9FK9ryv1tYJ6?=
 =?us-ascii?Q?JZEXf8MmaeR5Hl0K7P6+jKCdOHj63qAy91JMng8GRX5ouGdnDI+TrrCMLg78?=
 =?us-ascii?Q?p8UjIkcBrGy4DYg5gZIZImV24ieavIt2uf5UiOZ+/Wj9zKtzRBMETpjfCkYZ?=
 =?us-ascii?Q?aMYsGxFolO16r6jC+8li3hnqjnb/NVoHRnamNn0frPWiQn4UbRoiAmbDLXzs?=
 =?us-ascii?Q?5W3VG4vnWb/bS9un/ioJmFbVaLlgBwyaK88Js75tqwH1PcquNi0ElSULGZvO?=
 =?us-ascii?Q?kBb7MNtCitwvTTcc2q/IaOrHwFxww/cPVcYvjyBBAv3mmQ6+oF9Ztn3pNIJv?=
 =?us-ascii?Q?GgNV8AvXAcjzzV7+K0Brjtih38YjX7A7Ia7fhHiaU4wsvJbzsiihebrZkKjz?=
 =?us-ascii?Q?/fEktD/vcfoAu8nUN22dtywg85g44B8c1umEptD6iy842vZmm2XVP0jNFUpW?=
 =?us-ascii?Q?gvg8NdHO1yvrr5eC5L/G4e53y9dTAYF5mqexyamCNbsu2RbvxA4igr1kh6FA?=
 =?us-ascii?Q?0WjIszuf5PcqBZZPHk+hlX3U5jm4g7IVhdFddF4T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a406f046-bf27-40c9-8acf-08db77d44567
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:36:18.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a5DpKh5j46c4wC2DnulpQALIAkM7Mf09f1ob4GyKg+U++Jga2rUdhR5cAKYyziN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 02:47:02AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, June 28, 2023 12:01 AM
> > 
> > On Tue, Jun 27, 2023 at 06:02:13AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Tuesday, June 27, 2023 1:29 AM
> > > >
> > > > > I'm not sure whether the MSI region needs a special MSI type or
> > > > > just a general RESV_DIRECT type for 1:1 mapping, though.
> > > >
> > > > I don't quite get this part. Isn't MSI having IOMMU_RESV_MSI
> > > > and IOMMU_RESV_SW_MSI? Or does it juset mean we should report
> > > > the iommu_resv_type along with reserved regions in new ioctl?
> > > >
> > >
> > > Currently those are iommu internal types. When defining the new
> > > ioctl we need think about what are necessary presenting to the user.
> > >
> > > Probably just a list of reserved regions plus a flag to mark which
> > > one is SW_MSI? Except SW_MSI all other reserved region types
> > > just need the user to reserve them w/o knowing more detail.
> > 
> > I think I prefer the idea we just import the reserved regions from a
> > devid and do not expose any of this detail to userspace.
> > 
> > Kernel can make only the SW_MSI a mandatory cut out when the S2 is
> > attached.
> > 
> 
> I'm confused.
> 
> The VMM needs to know reserved regions per dev_id and report them
> to the guest.
> 
> And we have aligned on that reserved regions (except SW_MSI) should
> not be automatically added to S2 in nesting case. Then the VMM cannot
> rely on IOAS_IOVA_RANGES to identify the reserved regions.

We also said we need a way to load the reserved regions to create an
identity compatible version of the HWPT

So we have a model where the VMM will want to load in regions beyond
the currently attached device needs

> So there needs a new interface for the user to discover reserved regions
> per dev_id, within which the SW_MSI region should be marked out so
> identity mapping can be installed properly for it in S1.
> 
> Did I misunderstand your point in previous discussion?

This is another discussion, if the vmm needs this then we probably
need a new API to get it.

Jason
