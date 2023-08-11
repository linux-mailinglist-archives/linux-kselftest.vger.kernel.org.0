Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AD4778E90
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjHKMBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjHKMB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 08:01:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6810F;
        Fri, 11 Aug 2023 05:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdtpoRRlcxmHX5u+kfAQkQJNqzWbPWrnIfSxGKavozWjzIpZlLNZ4mZuSICnDXuycs4Dg/UXr2FNST3q10P5f9vF2CEqDo6eVV3gbCshwD3AyvuhCVVh3KtfuAmDZYNtjiwkAi4s9KsKw6A/mZsMg9MhrMFQauP9y/f70LJwyw4z71JWYILfv+a+al++XbCqNUhNs4lUJL2FNN7eRwIkMJTYcWlMv2Zr9/NNiZXlhvp7lzRK+WgQbDl/D3XoWsv6F9HHFehoyukZmPICxUA9N/tv2/R8Q1SfIPWz3QfGYnrZomg5HFraoViH2+tEuz+7jqOQctYqsri1B+/XP1DxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbrmd25XzUS/ENsg3zVYb7bdv4mXhY13qwTWphzyWZQ=;
 b=VZBjGkBSpc3wdOFLMdc1V4Q5MP8TXbUxALi8BPOwUrnd+4imbc7DGAc0QlsxxGSuAI9Dfx9UNaeED5GXSBAiHhO4PvfiCUJQjPQLVkVKcvzvnChVMFIRSLXmxfMr/LCpg/H8KWbVllV7u7GfO408wgjdmPmoM2q3rcXrn0BnbLNgRvCLYOk7i/inwjRacz4gDqWApOH6NajIAXjVxy85CSRNzoUZI7Mb8CibD8GIQgPGIqXByWxNys6I8XEuc3mzvrTovDWX671SeC7M6B+TvYMNAqPjgwOGMoEnk/ESUphb/fM8SsVWUOAMFgcF5xw2atlTevZl1Ninn8JXKhZgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbrmd25XzUS/ENsg3zVYb7bdv4mXhY13qwTWphzyWZQ=;
 b=o9kWHrkbINAjIGdihbBZjDRoJ9X7HARHaENQjNQTC+MAX1HhB/cYMirAHwdCEAh5uhKGQzvjYlDALQFPJI0noU8iHfSykQYXLY+2n/VZVeU98O7MfiYC7zuBAENyC4cEYv4FpqNfgXmzk1vBpSzJKLpF/FLUmrOdwr0ivLn1QXhs21TltfGnk1pHPArtuKSuQMZ2d9QVfB90YSMalIYpFjUvvQTFifyKAB7hHNDvXK4IAX8s3T2IMZp3gmpvUzXxWu1vPwA7+YT8WelezwJD050IZ8TFGWAbe+xBwRFhi163K3qCTMdsNRgFKkAJZTXTwWrYufUIRISYsm+xY+Fk/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 12:01:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 12:01:23 +0000
Date:   Fri, 11 Aug 2023 09:01:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v6 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Message-ID: <ZNYjEFpN7iZcM0sE@nvidia.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-5-yi.l.liu@intel.com>
 <ZNPCtPTcHvITt6fk@nvidia.com>
 <DS0PR11MB7529441BE81F24EE5C947B5BC310A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529441BE81F24EE5C947B5BC310A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: eb40e61e-6e2f-4086-401a-08db9a62aeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnN3n1Xw+GH+OoBFiC5FonvJo2Tyh+g4wnyGaYheyfltd25r9Pao4ego2pK806LQA/K4TejYVQ2L7QgiMlh57ZkcEu+f+wCeY4uv0N6SHSiH09O0SGHN9jc1yB+9poNcKHJpM77Tv/aWN8IGNnAXfOJTc7PkpCAXNREfovM24kO0P//Oqd0fFDUV+QNfmeKIFeangoS1a0z4ELqNJaWP1K0tEYpXfjZFpWk5TG83d19YgXa3ESC9duRMHTV51omnr4hSJTAeM+DWzGaM2YB73tArUMLEy1tgIQaNt1VJeo46MyBUbT3uFzwqpu0nFonHunwT0N4V/JVHPMSZ33CQ/detNSd1I8qC5ltK0I8/9v+WHjdjL4xzSbKadVYXnJM26RC+15XAE/woSfmcjx6lwvNPwha1CoRF2h2LsA3luShadFk75KuH9ymkqCOllQpwsnzZIMBb7c+NzSsHVXYrMNSISHxW8RxamfxZFkgqlwlQxd2mSdWR3rugUWDioDU0tQUw4Nuxzge8BM6IbxJDnj6UlcaPs+JiNaaXJKSiRJPPwU1QvmyrXYStMOoTCgr9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(1800799006)(186006)(26005)(5660300002)(6506007)(8936002)(8676002)(41300700001)(36756003)(38100700002)(2906002)(83380400001)(2616005)(86362001)(7416002)(4326008)(66946007)(66556008)(66476007)(6916009)(6512007)(54906003)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2QBgZfifIFIPvGM07Jp3JWxtj4Lj55yCkkTyFP4GR0B9djPHZ4ogw2xUnfV?=
 =?us-ascii?Q?aYzZCCUfxP4C2VxLytl9u1nyL2FV8uOfu6pznBwComTrlIfXNeq2QcEdIYkD?=
 =?us-ascii?Q?g3Qxj0xsJHEdGUdMVqBYjbEiKu3qV5wmRIP4rHMgFzo9ToqG6u1NCb+cVnxD?=
 =?us-ascii?Q?RckYRqoVN9EQZvD8ntpisjkelO9rX/baGAHhPJRw+MoMOsdj8rLp6gJx+ufg?=
 =?us-ascii?Q?wey5nuI0/DdnkYzfQRa7ShRcMk535ykP5j1EN3XkLcp65ICjmW41Dq6+Ys+k?=
 =?us-ascii?Q?WPjOzVQH8RdtPXT4AE0NdEsfRKs3te+Vymp8Rb/qqArID6lJREC8mypdv/KZ?=
 =?us-ascii?Q?VSS8YqWhrEdqsc6WpOvoZLdmTP1IY33DyPRr4LcFHv1Kdglp6xvvXA60tP5B?=
 =?us-ascii?Q?1YLC7wAe5bsBtMxTMfDa/mUpQKGogbpKUfxIZhHMrXVTWeWuOObQ2SGbWPr9?=
 =?us-ascii?Q?cmMWb2U6vg9PBjK114Dix910DsUELGeVHjAjKmXWFfHSzKayfNNjZ1sLrzC0?=
 =?us-ascii?Q?b1S24P/pSsHPRBFVHAlbTglmw0oziAFcMSkMzOC5gw5Q5QJCljVUAOOvwLeh?=
 =?us-ascii?Q?0h4F5/CVR09DgBPH+bDBisvtlbcHpJES+Tu/fl43dLEFrRag70934dIPU3pS?=
 =?us-ascii?Q?ieSVZgxXfjZIQ8VYWRad0war4M1kO54kyCCkrY+KeT4bLhEFK7NZBoYfkCxs?=
 =?us-ascii?Q?h1YyATL3IyDbdGKILY5L4GPhIfvCvSPh0eAZZIDVcSEWE8TX+uCIMli1ieNn?=
 =?us-ascii?Q?euHBnbWmacHPZx67WYnza78ZA9VcO13HNL5s29BQbgxltdeorSKO4zWw0bE5?=
 =?us-ascii?Q?hpQlRFFBl4ZuL1gdSeISuH1SRt7vnh1m0kRA8Fl2uoq/Cmq1NOe8uRLoaDwy?=
 =?us-ascii?Q?7nDkBPZ4jd3PWvo0DkRmEB1sN4XbWFJ+XeP7AyjdoLKw2tn5tswGWvWYHIgv?=
 =?us-ascii?Q?/WWLDRODqWgieUhjvzSRByusxYLnj0vzzK/2x4yes10n5bdBoAf6smB1Efw0?=
 =?us-ascii?Q?XtbDWcPEz8Gug1az5eyV8M78wLEjtepkhClps+pn0LT6nLxdYsZY4cxXzUNC?=
 =?us-ascii?Q?JnmOchtsNfrDB0GuMosSMjo0xP5G0L2/tU4q1L4lmFxW8yYHzU8+ClukzpJt?=
 =?us-ascii?Q?r9xtzelsOEDV+Jm3YZnDP5Ik8XIoKKnW4oKuWxZJAuedjpU7R+bLKXfDd355?=
 =?us-ascii?Q?eJwlTBP3eVhSaOX8uGeQ11a9L8mEvHWaWZEAAcDlt0kEZIpBFExwt6N6sGKy?=
 =?us-ascii?Q?dgOR9cSPrw860VQFZNjRSM+qgi7pGUD74fpz74f9czuMryetRKeBEQicXjHU?=
 =?us-ascii?Q?ycYFhfhBaFI3jdQ99oUOhfOH5gJIF0q5nGWR2IPr2FqCPyVuz9PHNInKmuoD?=
 =?us-ascii?Q?ENX6BNLovucf30mHcGtTazog3/alCw2pDdZcoczq9JIwcI9pJCUkMq61xZxi?=
 =?us-ascii?Q?9oPTelXvRrecmPu8rswRxd7CTfxry8ZHFn8IY2M/mrVIu/N8alsKdwyBukSv?=
 =?us-ascii?Q?R+nPJkleYOgkjZXki3PwGoqPh4KGDjENpn8PJSwvY5EK4vlW1YHpmm7ohiZ+?=
 =?us-ascii?Q?zclWJ5GYOI1LxZBWJr/QwWTszFx4jJ+FWNPza0Q8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb40e61e-6e2f-4086-401a-08db9a62aeca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 12:01:23.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+n5XNE234IC5Pxrn99Yf45tx4wZT30eKg0fAbcU6pcFAoAPPuEGOOhpkxGasElB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 06:57:34AM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, August 10, 2023 12:46 AM
> > 
> > On Tue, Aug 08, 2023 at 08:35:10AM -0700, Yi Liu wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > >
> > > Add a mock_domain_hw_info function and an iommu_test_hw_info data
> > > structure. This allows to test the IOMMU_GET_HW_INFO ioctl passing
> > > the test_reg value for the mock_dev.
> > >
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  drivers/iommu/iommufd/iommufd_test.h          |  9 +++++++
> > >  drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
> > >  tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++-
> > >  tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
> > >  4 files changed, 67 insertions(+), 1 deletion(-)
> > 
> > Don't forget to add it to fail_nth
> 
> Sure. Btw. Would you share us the rule on determining whether an ioctl/path
> requires fail_nth case or not.

It always requires it :)

Jason
