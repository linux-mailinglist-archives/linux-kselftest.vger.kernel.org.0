Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1EE6A0992
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjBWNIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 08:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjBWNID (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 08:08:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8614233
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 05:07:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDXS92C4ginw6BUlhpAQPT6VDmDZjPBdaYDbuDcjp+dMQ6izjOcPz93ghaDzFzpHQXqfsPiFZAtAmWKoTX1gTzDNwzbat1tqbWLmI0bJvtU6YRrF9g8YiYGZA+drS7rW+/8msv4pFPkis4n0cTMZSeWgaAZuQq9HCWLxGBUA2Pq2dMR1dG5ahuCU5QPiBlepY1X+dB7YbT7NvtcoMcwMLlctYvRb2izUU5/S9V/XFZJmxi0JZc7M5PfJmIWAEzZ2en9VeTnSoQYyzSxjEKlGf4FdGvav8nn10UFO02V7fxop745rVww4lhksHGzE+cYsePaThQXYPh0LVWUV3Too1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkDWxLVpcqUK1M8fiZ7mxXimpd8Ym0cOvh5BWa4CKLE=;
 b=PQIu8f+0ynrrJVthbCTFU+A4y/3kbPTpv0FNF0PfUCV1vRYcNEaS/N/W6VxG9oRjjpz0wxJsggLLW3ogTTEVyISlGUP8vgO4ro+wTClhzpP4DDejUDZZcslXkJ+DT+hX8pd99YMpZoZ58Q9NIQ0AuQt2LctgApay4vvaO6BL6/SutsGFUfINrzwkeXB8BTgzxICePF66ripZr6OcH1DHA8muxKj9MWJRuHO1DEd3ey2iSZiXKpyUvEwmhgRJ9b0PjNI2USiDW+UEwdkWogZtBJ97b+Z1FhUxO6zw2buxUsg85WjASiKtXi1fuLJgKEqm3ojbjKvYKR+ptvzW/SR9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkDWxLVpcqUK1M8fiZ7mxXimpd8Ym0cOvh5BWa4CKLE=;
 b=tmSNs6supzO4vXR3k+bXoor1DsCNFU4YF5UZIwpgpXAsEbOJNq9XnEX3IAvtzdUzeX1D/rw7AQgsd4o917Z7KHXhBqGb7ren6G7zuxjlec11e1Suf2AvK3BaU/Cz70+oKUTBwoNdNC1lBKZHkiRwxUg72FO/3TWLVu2A2nv6k10C1DdIeEV6kGCRgjV9pfCezpsdyw0q7KzOm/l+vFpOoTahRtBaaZ3lH1V7MuEqAOJDvNTjmV9bOAJgBBCRS+kuhCH6Y1UN3Nrv6Y8C7iNclSOPPvUkTxrGXEa/qWqZUPhK/T5a+7qpodmA3OKpF+MJ9RmAoBo6eXudsdk8P1dfuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 13:07:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 13:07:53 +0000
Date:   Thu, 23 Feb 2023 09:07:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do
 iopt_table_add_domain()
Message-ID: <Y/dlKBZkbtClMcQC@nvidia.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <BL1PR11MB52714B54BB1BE16E99AEE11D8CAB9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52714B54BB1BE16E99AEE11D8CAB9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 37256e7e-61f1-4e41-62f2-08db159ef931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HiKa0bV6ItFC+bABhU2PmU9y7A5Y5L2QRgOJAB3Dp5EP4hxzpElZ7Le31JQoDAh9TKs2iBMS5pri2hCVTcX89lNLBCEea2TlZvErRu2UeaWB5CtpWLfQYQLD3apELN+rW6kE6qBBhNSy/I0P1CNb+7/TmZCoPolEZIB276UWA4cIp+g5G+LwZE1iyfr7kDRroWWOwi3ZCDfJf6knWtQd01rBBSUkOK300YOiTcHg8Qqsku6b5Bu0TkcHfT7dgoNPtojmSwQslOmOkfznpn4yj1UIU0DkeeJ4fhc5heuSltMK3yMfaq8rakN4EUWb/tJu1juaMybdGGyn37Fih5S5lTQOP/BmioLo9f74ZvsfUnbTEI32pqfRtPi3+ylVrZ7rQNQtaNxjamMi59o2bZs6kTSa52LvTPeMQrx24uUsXB9MmyN6t8QV1g3zA+wNvytetPPW8VBWQq2fkos02c8C+h06LJmgZybOGEBciKmTKarg3b94Cv5sFkJcxB5+5iKJPSGfYztBtW/Xok4IjZ8W+3YaBZyEvgbRMeUYHukiMMR5coCRdwBvdCIX7QHY36KTbkZkTI+XUtXZP4lsI1K41CITueI+uSP7GRYSwbO19Q7Lce15F2mGSZXvAieqqnUH75TCqDgZ3Z0JTKLNsxkUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199018)(86362001)(2906002)(38100700002)(478600001)(6486002)(26005)(6512007)(186003)(36756003)(66946007)(66556008)(66476007)(83380400001)(54906003)(41300700001)(6916009)(4326008)(2616005)(6506007)(8936002)(316002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S1EhP8mW+5OPqrhL5kFxzhB7b1KDjrork3vDAD97E5Fg+8EBR6LAo38UIwK6?=
 =?us-ascii?Q?VIHpdWUNrRS+IHsDLH0GL8z56+qn0BmzMYqFTAYbq8IspJX3PgSdiu9WBlyS?=
 =?us-ascii?Q?u8otKnOy0eyf0izbU0tZRxO7POCMycu/uE2iTrb3svfYPya4HTjUxZ+1VbJ7?=
 =?us-ascii?Q?rTujvTtzTuYO7HXcY+gUFtl4l4xu0tFCL+zzWE9TaxQcNwrzAV9IqYIAo66o?=
 =?us-ascii?Q?PrDcV5UU3Gvzr/prLMi8vKleIb7CeswQo99JwdkxoqGoS9F6nfy7pSz4CagO?=
 =?us-ascii?Q?3vMg6fnEFl2nmZmamYDTXeYy6AVTGKGBi9jmpfNrZ6CONQURmUENPUbftySB?=
 =?us-ascii?Q?gOA0tKgdkqXmxQwWRC47YKr3kFdq4r9mSxBgtwt0Y/97Iz0oL53DirdOXQ4r?=
 =?us-ascii?Q?Zxhqy4IpG5w7XR343cQeu3hYhElR2Go1oFI2hHoOsFNRm65cJQJwIVbEGlaU?=
 =?us-ascii?Q?0ShMFOJXYGasy2Ki7LYJ/R5S2wjNOv/3S8otPD5muO0iBwDtEEvsqcD1NV6+?=
 =?us-ascii?Q?cyZqoNEZqvkuAtvnhTs1b81ylblsKHVDyoO9KQ8syxPhcLkpBc14Lgfr7DY7?=
 =?us-ascii?Q?i8JFE8WHNvxw7ZgOKrnSfEEKcWFvs/qVmJsBvKvVAX8CPn1oN5uu7ryYBfUi?=
 =?us-ascii?Q?mqhFPde8t/a6n74Yd2RcoHt/o02IYjbBLdgsu+afNcW6g+1uVA5LRr7dwqUu?=
 =?us-ascii?Q?4YOzdmtmL/O3U1ZdEQ6RTvrJy0sfurYIKbMXtjc29NEdvGQgsz1Bf4t1pTRA?=
 =?us-ascii?Q?FCdHywC4DAxKu43e/HG9gTa2s3xnIXUJ5snC9KW0cEb+OlA9spBTfmWeYKX6?=
 =?us-ascii?Q?OjmLqZowjanCFAfhZ9vanaK9OQ2wI4Ba3lOYTLijhXP+05i6STEq3ef07Qok?=
 =?us-ascii?Q?zu0VIzzw90yR2TEQc35LOWKtNa8mqZ9RvY4uDYU5MS836wO5SjEBm1AppgjH?=
 =?us-ascii?Q?5Bz47qY7a7FQAvZyZVkCLIXMXxi1bN6QRiU/zEa1FPO9nimRa923ohaLVcBQ?=
 =?us-ascii?Q?xpW09UGlbIFoPDZ1oMeGeAZrL6glaDZh4ZCBsQfwgcwjd7H7P6K9RxsrsLB5?=
 =?us-ascii?Q?wopKsYlus82+BmgrxleE6JgdwpF5KhdacCOgitPeecO6MH8GhAOV0kNdDKPC?=
 =?us-ascii?Q?yEtfBqHsUmLCQvFXjdTTbmdI2IcTI7cBH9vqhBgoHKIsBKEWKH4vBMt+BYEv?=
 =?us-ascii?Q?dhTWz8OrkxMyxc8xmm1F/cVs2WIV8r6135c7ET6tnJzPafhO3Zkoet+LmEJq?=
 =?us-ascii?Q?gevhCRbQIZqZZWDkOvpyTGHgc67hjeoXoauXLX8YZqtv/adbo1H40KixiLwH?=
 =?us-ascii?Q?NkaQp/eUtXgIoSu07ow0oygyP1nWMIDEV16KlX43BfrJdzqizccrOcfy+6+1?=
 =?us-ascii?Q?Fnz5HtsaTjFBTxgnuf4QiziZ28tPcQiffntViZ1OyxL8wYPhNOAmYIIKVKY/?=
 =?us-ascii?Q?zL0V6bs6Gsg2IdvDl+oVTdz4oXxC0M0oi/ygt/zpZPzr5Tdr085CrZ377pw9?=
 =?us-ascii?Q?Yglg6utOnqO2+Lv+92PxcJ/220cKGeSxMhpB8EeYqGO8dsMX4GiWAA1B+adz?=
 =?us-ascii?Q?BShXU+5l41wkNNn9svut+p4orbRhHOLBztYujPQG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37256e7e-61f1-4e41-62f2-08db159ef931
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 13:07:53.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWAV73opWNRANjh5mNA9TUvDHMvXZ9JbuD0fTIM+bczcuwjM24qeRa0c8ekFxFzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 23, 2023 at 09:03:14AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, February 23, 2023 5:03 AM
> > 
> > The HWPT is always linked to an IOAS and once a HWPT exists its domain
> > should be fully mapped. This ended up being split up into device.c during
> > a two phase creation that was a bit confusing.
> > 
> > Move the iopt_table_add_domain() into iommufd_hw_pagetable_alloc() by
> > having it call back to device.c to complete the domain attach in the
> > required order.
> > 
> > Calling iommufd_hw_pagetable_alloc() with immediate_attach = false will
> > work on most drivers, but notably the SMMU drivers will fail because they
> > can't decide what kind of domain to create until they are attached. This
> > will be fixed when the domain_alloc function can take in a struct device.
> > 
> 
> Is below understanding correct on how to retire immediate_attach?
> 
> 1) immediate_attach=true in auto domain path for back compat (what
>    this patch does);

yes

> 2) immediate_attach=false when adding hwpt_alloc() uAPI and VT-d
>    support;

yes
 
> 3) fix domain_alloc() to take struct device so the SMMU drivers can
>    decide the domain info w/o relying on attach;

Yes, this is where Robin's patches are going.
 
> 4) remove immediate_attach and enable hwpt_alloc() on SMMU.

Sort of, the domain_alloc_user already takes in the device so SMMU can
be fixed for that API immediately, in theory, but it looks like some
amount of work to get there.

Jason
