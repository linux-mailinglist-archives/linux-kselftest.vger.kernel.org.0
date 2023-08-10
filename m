Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2C778184
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjHJT1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 15:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjHJT1J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 15:27:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEB090;
        Thu, 10 Aug 2023 12:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VunhK0bY2RLxSuLOxiGo6jcwVEUKRxq2/YjYdqoHzNppkr9B8uhyB6wUo8R1xUjEeICwLAmb9xQcWkbjhXbPxhTy2PrmiCnW6BS9SeyN49h+INQ18fjbReaTg2kALHDapifBn/iKmDhJ+sFSvjhVZlRYvzHOrc1KdANOl7pTHEFeBloFf0nejfQnYjlIId890V+mEdsC+XxzniI5oM48Whkq2Jl/FrYwT96choTvjJb86FVbHvRoV8qwVop6/5xLO+jBli6ZSpOYfzBAz3S+qfbaiHeWVFbldGRMPfcSBp/WJTMk7b1t7uDjXDltutT6cJMMKPXKcGO7OBxD7/TP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3F4McPyFxGqcrpFD3UnsgWBqRYbCUWXSaak2/JZivU=;
 b=GUObhE3Zr0JxtJD/vPDy1QLhz1eHUwguyXp45Q9uON8Xi8TCg8y7inFIKQekvZkvXmpESWD8wLebYAjJDq6DYgupnC2VkzwrG8BTSS5VcTHXEMOd9z7T0wKI8Fv3VYKKBfRFKnXKQRth79AKHAMqkHLvtkUcldXqAC+mxGeSgxnTbSdky6HaMLD4wTLowecwMgZrTSQ8+/TibzUI4PK1zLdor21jZxjAeQVAqitifUS60Ef/5wN/jSb79sYWjD0pwth4N5yT61Hmy4oPpksrAQC5qo3KRAQl+NBy4t2lI5gVDOHvkoRwMpNXvvZ0/F4qhkdWTn2c7kHG9lgN0Nv/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3F4McPyFxGqcrpFD3UnsgWBqRYbCUWXSaak2/JZivU=;
 b=UN8Dd8bs3bsLkSocC/LvoCdFEKwlJhV2YE8Kgbm99JCuDOR9pIrhAM4uklXj6HMmpFH+OzuYx2JL3MKKDuEcaQMTw+v9Y5mhNiYBE6vqVBhUBDewvkCYkPVXfI6/v7AcqGnNxFajCJCejr7OVAqU8NI7EotsanlLFwrp4P7S8fkC/0/EuSmX1v/HL9VAT4qTcjZIIP8rrDxol8YfIZ/e8uNBJ7W3OKl0gXYTkTQ/cclYwOJQ2jSsQksa0n+0C1V9sMM4aWLpxF7jG9zVT8itoFnCd+g0+Jb7FsyRdAl9hUFXir1PpOnNmt2Mo3G4mkwI9GNta8T5u84higCYtYpytA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:27:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 19:27:04 +0000
Date:   Thu, 10 Aug 2023 16:27:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <ZNU6BnTgNEWlwNYQ@nvidia.com>
References: <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
X-ClientProxiedBy: CH2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:610:58::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2d4786-e341-4705-9f6e-08db99d7c70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7iHKiaUzmgHIbafO/X8+Ewcw2ygAYMImHit9QvUWqIqsZmbBQw3SyDxTMhvIAeKrNRbfcLjus2ge/r2xKAq1FoX50D7vTERNQ4VW0h00YjStdYFUv+/MASjIADF9/Nfgwx3JNj2vUjeedaixUAJT2tbDVF0Mvu+Mb2m4bnG1tRWf0MMz5wsaYV7mk1z77RlJ22wKedj/eFhAU/uZ6ruwrS8jZG6ir7DDZudHXkFkVNuOM+tFUQa5O6VLLzeukL8BLk9gz9cjBHzdUlTkAfN0PLfG/BZHCYrhzPPwMJOBtdQxROQvBYzhUJ/8OeVBbIgHOL34LLDCkmRq1phlOs8q1/JimvfiJAIc7yKbZp8P1riw62kRToen6YwRj98vda5S8Qlxnh9DDSqkeuoGAEOX8bIndGTomDZtlfN7yqwwUt8SbE2IyUfCk+O8SHyqXbRoQK9x8o7u/alN6WNR0vB9PZTpV2ysJhZpr49e08t5xAd+cGZ2XJ26w5k7p1ZLhURkPQbJbVyN/j3APjK1SEYHLkF6kAK6xvtg6nh4F8FEHJ1+z9uRLl2+yA/Zc7XAOAw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(186006)(1800799006)(451199021)(316002)(41300700001)(4326008)(6636002)(38100700002)(37006003)(54906003)(6862004)(5660300002)(8936002)(8676002)(66476007)(66946007)(66556008)(2616005)(86362001)(7416002)(478600001)(6506007)(83380400001)(6512007)(26005)(2906002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KyduxKgZw0XSBy9TAkWCnsPc20pHa7ucJkMflrYovsentoELcN1fG59WFHM0?=
 =?us-ascii?Q?IgHeD+wQN38LzBoz6Oyn+OZNPP5QzvhaggkWe5YMxyp0IwvSmWUuHTmtPYeh?=
 =?us-ascii?Q?zTisgYvmn9VV9bNr9p2Zhn9H3nOO+xLZvKqeOqWauJk5gZOH66LPU8/dSCFD?=
 =?us-ascii?Q?+61H7oqyky4RvGj0o4rkvZ9jKg6edk3BX4+LcjYzRjm4F+0Ct8n2SAWc1u61?=
 =?us-ascii?Q?lHaiDyiBiw5U51FOuMOAUSI5uYAmZLYsbSrPtxTkq1h5xhU2mDJbR1xTXCYj?=
 =?us-ascii?Q?lo/SUazrPLSY0ecIjOD59U0rwWW1xfWs2wdwwHNgL+YESXnQsW6MVcXDnGP/?=
 =?us-ascii?Q?b3Clpg4FbFUtKOr9UAPSH3hk+EIXTaVm2VezRdSr/5QVvR+1kRcmqWNPcyLf?=
 =?us-ascii?Q?WG0PvxEh3XFgOcwlN0AeSye71AQA2oJEvCNZc889wyvsHpOflMkgqBvidwm1?=
 =?us-ascii?Q?gnsgzV+71uY0u6/dgkF8f4Lk4B4drgW8FJlYjpocpcV5HvL2vOu0lwhSBHXn?=
 =?us-ascii?Q?Uvf85CFrfgDFZ9jH5IU+EFQsid8+wppnN01btDzAfYP7adtYPF9UdlCAEtnM?=
 =?us-ascii?Q?Smqp5bOaaQf3FSPUg15wXHb/kKcj5fpHoahBvs0nSY67p16bGjh6dJaTvXTL?=
 =?us-ascii?Q?Hz4QhnfNG5LtjhWeOrDI44Ja7ApLigIrrR7aLcMEsyKZQjk+miyLggXyZJTg?=
 =?us-ascii?Q?PZ482LtmmorMrxsUSt0S8bcLa/a38Ek+8WC1VhYeMdnguOKgKRujKmjWPqPi?=
 =?us-ascii?Q?HrEeSVi1LqhLlfjbsVQXxdSelp3hm/5jkizJ8v5g1/xHJLR2i5+kR/hI01Ev?=
 =?us-ascii?Q?LAjKZKbi5kzUboX4ikUUiDHhTtMFfr3iWBu8mYoMLHZUn6n+aZKDix/j/GzD?=
 =?us-ascii?Q?rMgYEG/VXWjK27UzXZJTlsh2uCIcKbsrCgYW5FZU+DrIL/n4ONQ52BxK4jy7?=
 =?us-ascii?Q?Oz0NDk4/Myn0FXcMPxgsqKQ6bvP3B5cbQrsjmQ5Z3hqiyGBiR6BitgmU63hE?=
 =?us-ascii?Q?OvZqNUL9Vm1cbhwleRTWokQ0g+qHfqEsjN8RZE8nWAYBMu5f2/uqnTduS2+7?=
 =?us-ascii?Q?HdPq25VaMK18dIOmVCKb+DQdXvnsdvdnjIXKxdlXzOd4obCrL8mRnhT9uatY?=
 =?us-ascii?Q?qlkUbUW5xdwBkU5oNug+CHhzI3TOByonIzYNYrIJkL+ofFzhCFvHcvOBHeNj?=
 =?us-ascii?Q?4sJWhc5hDaImiY3cvLA/q1n2J+JDZGFBh5pZo5zm3lvhtfRahjAAiKZIMULo?=
 =?us-ascii?Q?3MPBbSySS575NEZUMr0pOwDcCtWYuX6D3lLz1qv48NlcyTyvC9dBv9KVGF1P?=
 =?us-ascii?Q?zWbYUpBv7FSZamU/Cs1t1LrmF+J06RaFfqO9pRSjweDgC6YxjngRhrzu18vF?=
 =?us-ascii?Q?93Q3ExXEqEiakk5HT5rEsETeUbni6L1pVn5JtO5GObdhs91WwDshYqSc8utz?=
 =?us-ascii?Q?rXG/VGB6JgfvVpUyK11lKK8sn3L4CGvt8TKkVR3eQCxQ8whOApRHwvqwi1Fd?=
 =?us-ascii?Q?PWzo/Ldz2e3wTNNKm8UP04ZXLruihjKpD4ujMIBRQKemGLSeKlA3CcxzoNFO?=
 =?us-ascii?Q?a/C9Llg818afBYLoHTyav1BMqve7KDqglNuC24u2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2d4786-e341-4705-9f6e-08db99d7c70b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:27:04.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bj/FKG76Eokwkq7mGq50quiMf2cWgV1u80Sh/S2XGaozloJz1Ih3JqcvsV57cmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 10:14:37AM -0700, Nicolin Chen wrote:
> On Thu, Aug 10, 2023 at 12:57:04PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 10, 2023 at 02:49:59AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Thursday, August 10, 2023 4:17 AM
> > > > 
> > > > On Wed, Aug 09, 2023 at 04:19:01PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Aug 09, 2023 at 12:12:25PM -0700, Nicolin Chen wrote:
> > > > > > On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> > > > > > > Similarly for managing the array of invalidation commands.
> > > > > >
> > > > > > You mean an embedded uptr inside a driver user data struct right?
> > > > > > Sure, that should go through the new helper too.
> > > > >
> > > > > If we are committed that all drivers have to process an array then put
> > > > > the array in the top level struct and pass it in the same user_data
> > > > > struct and use another helper to allow the driver to iterate through
> > > > > it.
> > > > 
> > > > I see. Both VTD and SMMU pass uptr to the arrays of invalidation
> > > > commands/requests. The only difference is that SMMU's array is a
> > > > ring buffer other than a plain one indexing from the beginning.
> > > > But the helper could take two index inputs, which should work for
> > > > VTD case too. If another IOMMU driver only supports one request,
> > > > rather than a array of requests, we can treat that as a single-
> > > > entry array.
> > > > 
> > > 
> > > I like this approach.
> > 
> > Do we need to worry about the ring wrap around? It is already the case
> > that the VMM has to scan the ring and extract the invalidation
> > commands, wouldn't it already just linearize them?
> 
> I haven't got the chance to send the latest vSMMU series but I
> pass down the raw user CMDQ to the host to go through, as it'd
> be easier to stall the consumer index movement when a command
> in the middle fails.

Don't some commands have to be executed by the VMM?

Even so, it seems straightforward enough for the kernel to report the
number of commands it executed and the VMM can adjust the virtual
consumer index.
> 
> > Is there a use case for invaliation only SW emulated rings, and do we
> > care about optimizing for the wrap around case?
> 
> Hmm, why a SW emulated ring?

That is what you are building. The VMM catches the write of the
producer pointer and the VMM SW bundles it up to call into the kernel.
 
> Yes for the latter question. SMMU kernel driver has something
> like Q_WRP and other helpers, so it wasn't difficult to process
> the user CMDQ in the same raw form. But it does complicates the
> common code if we want to do it there.

Optimizing wrap around means when the producer/consumer pointers pass
the end of the queue memory we execute one, not two ioctls toward the
kernel. That is possible a very minor optimization, it depends how big
the queues are and how frequent multi-entry items will be present.

Jaso
