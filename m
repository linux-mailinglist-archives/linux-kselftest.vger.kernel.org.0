Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3145176CC83
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjHBMXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjHBMW4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 08:22:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC5269D;
        Wed,  2 Aug 2023 05:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rddgs0e/bwj1INs1hIPNyED7e8h6wamO3R8+Yt0M0hVYBoDH6kI5AURmqfYxW1MT85ueWB26JdNAjiqG7r1qVFtnlz+7Qo7RcqJ2i/t3gnXdrQXulx6K3hWwfWiwuYwidaqBaNqaxRlq8hqLQ8wpkVc6vrJHSE2sQcl22qBrAAWzKC9oz2xLCBdWJNJgiHSSOqxj9QPI3F1p6Q2C6qZSWUe4UBvrbF1/c6nm2Ub9y8/JzXc1qau63wTkFC7Vx6BYR2LGKxm17QUZklUVdUnGHbr6PtMrMAKznGTRgS0+0IkX2/K0vBirC+M5a6JL62cDyfOOiRHZzVelkk+RHexw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsAgb/288HnGXuKTlNrDhydZiLy9WgCkEaM63PHRTkg=;
 b=fRubR/I8h0felRyCPzQd0o8SYER4Lz4548/iCnbjrFZ+PCeVVHKDFX4whlxdZipnp/+PpC6oeYuk1ZE1j/ZWFZRA3LS6BcQ6CwZskSEzEdMfV2Qv4XRBm07Ni3HCMjA9I4R9+LKTcKqE6qIgb+k2XvCPaifLkbUvifmhLvf77KNQ2bqWaf9iskSqvqFNiOsZIrUQfriQhC2OhVr+XUFGiC0E9TTv9FyNntXqtTUTdhkU27swVUm7WoV2M0piM50+B4xlv3EhNnGasrOKVEic70Fxdti2LNn5Yvr7k7Ttt+QPlFynf+kee7SBDtmNj5SgvPmb1whHhvtyIOf9Gug2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsAgb/288HnGXuKTlNrDhydZiLy9WgCkEaM63PHRTkg=;
 b=SH1U65Hoj3UQovsxmCIFFGLV1Ny6I+o5ZBuw7Bpxhlf4xqod6FiNZPDcpnKwDZIT1izkX5/T/g/qsF9EROYhG0UH9C4722273T0AT3ZpetdhW4o6cLY9l1sN4XV87iqT8U/RsEuz/cNmKStAtooJAIN+hBhotB1rTZBh868UpPyneQhuw1S+ZfdDY6A73Qj7A5wjkp3L4L7BMHNtpKTC8HRw4bbroOcyBwsDfrJHSkUDzEkqPu2p8yQpcAOoLlkhvxZ6h9rO8zqCNleHKHEU55Y5MNI2wI64+nIeENC9fK2CfxGEuiNpYnOVmyTk83O3cX+zEg5tCJCLHWttjWdLnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:22:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:22:52 +0000
Date:   Wed, 2 Aug 2023 09:22:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMpKmgPAuQDI2nDx@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
 <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZMlNcRgMYatv/YqO@nvidia.com>
 <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0294.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c1affa-262a-4d90-5cbb-08db93533163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PasOuCLVaFAafI4JlQKL6qT7Nqve7PI5y6KnxqwUOxiTuz0m3TtvCXZkjuJo74CetBHrhfNHaOCKl64gebMe/l0y1EZ3np+hcZ+WGQ+u+Vy70ahJPEBDHXPjvGjIHlaDEZCcjaLF/+oPF/U1eql4mxRmjsP2JLmhG6qFajeDlojaDJLdR91jrW6xPjSWDMRu2H3kXXACN+HnGNE8mFANIt33kvjORWAELJ3jxXKh2l0w6M/9MLm1hBgdJG5wlFp+gUAGfylORFvR1UPp9lhZWX+IBfcxWCrKgWs8hZpw50O4249TXGPRtNkK6UREJ5W7IH7FTRCZoysyGe3I2kBVZ/wUeW2kyHCFRXkFhB3R+zeG5eJH7Vc1/XKbLLXvI6RlVarOyELPUSo+1g72Rp6LB8/PGYEsGrqG+U2xjIuG4NNGeHETfulKlORtNwRniqjTxVC43UrSm+2IYljkSHlIrPckyjL8zSLaeVJFzDcUL5BVnZUQHYhfRZkkDoPmHke3JB7JfqavKiw/iZHkhEik2LUbDrQyPJu85dSRtq7f9F4xcVIVQnmk9SNEZvwbF/7F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(7416002)(41300700001)(5660300002)(2906002)(83380400001)(2616005)(186003)(86362001)(478600001)(54906003)(316002)(26005)(6506007)(38100700002)(66946007)(66476007)(66556008)(6486002)(6916009)(4326008)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CS5xYKzR3pkP6I/J8qLJScgSDG6FQaZTlKw2LyoXRczDqa5UvMEjU5rL6UDI?=
 =?us-ascii?Q?jN19Z37bSnoTusS/3839b4AR45zL5tlZul+FtMJCcmfjzuBoWrTiE21yQxAl?=
 =?us-ascii?Q?Wtj9OPdGjAi93b7hFHGGmrIn5vMo7QTuPI8vQcz66HmzJED7CwIozH6LEkXb?=
 =?us-ascii?Q?hp7sstKKwih5UTa2KqpEKXVsgWB72+dq8ctsZbbW/jIHns93cHaiJffxhnS/?=
 =?us-ascii?Q?oF/jJCQW/iGdLAozM1UGu1xEwB+yONeV+uromuiQHcN4d42gxoN1wvKUGuwZ?=
 =?us-ascii?Q?oY3TNxSJ3OUd2EdM0EQX7W5ffgG/PbVThyxXYc1dmLl5AasgZjyAdlgSOXr8?=
 =?us-ascii?Q?1d057xWJEl/mGb89yMxN+u0EeJcBdrxAvBNA2u3UXVi1oNoKxg6KMF+K3QR6?=
 =?us-ascii?Q?YP35tAp+oT9QS5j/3ICRsc6VAhRYSgwubrcDdDOnxBer09cCPE1NW6RS5wTz?=
 =?us-ascii?Q?GHO/VX/O1rNlY6zbajXdR3SMvV+N0mrCS+ILOvBvVTq0KMe4IAAz3I20kFbZ?=
 =?us-ascii?Q?M1fUPSQZYADygnJM6VWjkqD4kOOkHohyIXi3l5m/49ZnGkmPqAx38xgYoAf+?=
 =?us-ascii?Q?oDmqf9PtOwWzESoi5lxXKble0S5OVadiHltQOioumYnFvG1cMqngWeNRGUvd?=
 =?us-ascii?Q?BO/afHAwtz/owEaoRLTrBR7bWWeHRmFj8Jc59CFI9sWYV0scTMi2RT7ACMkq?=
 =?us-ascii?Q?1scD9haG4flA1AFFcRBIDT9SM76Wbn7CAHP6tT7lB8h6h7Axs85hzxXIP4Am?=
 =?us-ascii?Q?CVvtX1TS8ZHVZnfkd+HWM9WkMk9ib3HVpq47srUjpFMEJoKLwEPcihHJGFxz?=
 =?us-ascii?Q?m1yg+QgawrInyhWx5HjeqZ3JMbBQ9job8A6e98c/5aM6ZyL0WPcLJxw3ebd8?=
 =?us-ascii?Q?dPnGfmFGt2QwoyZCShHsLTzDsWGbaLTGsKS/xT1EoqX588NezJ3NyiumLEGq?=
 =?us-ascii?Q?RRESdw55Uta65Wj/Nv5j9KMNqyTQelS3ni8lQkWV7BgB+yw4hYu2Owb9XmTQ?=
 =?us-ascii?Q?VsR11BvdLtRsMzqwncvs0/9GOuKXB7NwMfC70t1lJGDG+Hw6ZpvtUauzAxEB?=
 =?us-ascii?Q?oe73ert/IEuDw4ZOEWGgdllsa96pGPvo2Ve1H607wJ1r4GUZma7YrmMrBTUr?=
 =?us-ascii?Q?cEbuQ/F2fqgvd//C4bk+kCGxGpK1yVW7hEiCLJWxzCY+lyXGyVGy2qmiykOF?=
 =?us-ascii?Q?oEWshFUfJNLmjzCrMyFHdcJ8UFSOOXS2xMUksV+VLrP1bHrO2A1tfhcutnLk?=
 =?us-ascii?Q?5BC77WOfE5YjPKr3rKmdaDhSXHdbvSjAupdMNnE7frWlcqMiDMQvIhJA1wHF?=
 =?us-ascii?Q?/gxJfnzyVZDZf1V1qbvpaNBTJn1MdUb7nw0iP5vwKyZHUCC/BPr6sn6N3+Hf?=
 =?us-ascii?Q?1u0RZBJP+dy6CURz58hfWIis+0uQthB2PBkyF9C8kN+iGJ044fJ1ocljhQg0?=
 =?us-ascii?Q?xZ1XspxGBF7bGjCqM7hRASvxxyg2Dozm0zYIuBge+gnYIgLlkElOKs6D/6/2?=
 =?us-ascii?Q?2Vjyzm44Uvw7ZGbjhGxe2vNI1pamrYhuUP39AtTMud29kAPFkH2GLhyEoaVc?=
 =?us-ascii?Q?I5tBHQnb8n034BxjmBSrOUVTecJczMJKXJujWGXt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c1affa-262a-4d90-5cbb-08db93533163
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:22:52.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbTfgiEzr6k7ATsC+0ZUlBE1cO9TgXk6wqjd6jHqZjKqeoJTdY7y+8nd825yusSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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

On Wed, Aug 02, 2023 at 01:09:28AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, August 2, 2023 2:23 AM
> > 
> > On Tue, Aug 01, 2023 at 02:40:44AM +0000, Tian, Kevin wrote:
> > 
> > > > So, I guess we should leave it like this?
> > > >
> > >
> > > Yes. Along with this discussion (including what you explained for sw_msi)
> > > let's abandon this new cmd and leave it as today.
> > 
> > You sure? This makes it basically impossible to write a "correct" vmm
> > that is aware of what the physical memory map must be early on
> > 
> 
> emmm... I thought it's what you meant by "leave it like this" and the
> fact that existing VMM's memory layout happens to match the reserved
> regions. Nobody complains lacking of such a interface for years then
> we may postpone supporting it until it's really required.
> 
> btw even if we add this new cmd now, getting the Qemu support to
> use the aggregated list when creating the guest memory map is not
> a simple task given currently vfio only passively acts on change
> notifications in the guest memory layout. It requires a new mechanism
> to enforce strict order (probe all vfio devices before creating the memory
> layout) and then injects vfio reserved regions into the layout.
> 
> Preferably let's not making it a hard dependency for this series.

I see, if qemu won't use it then lets not do it

Jason
