Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8002C620498
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKHARr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiKHARq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:17:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3B240BD;
        Mon,  7 Nov 2022 16:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngpjbz6Y26jR0Wka/Tt61/e5wHcKGb0pZENhZoKV359DnpCQbpcGzXJLm+OluXzz3gswilJpDLOymPITHZMXHKtzFFOqSdFrA/MB1vMw1UQNT929R0m+GnKGtXrgv1dFfaeSPyxF1y9+8kBL16bRwNtgYn3bqpeP7h9tT9TPjZ9fhqTMP6QuAoS5qN1DEbXEcHG8i+wHr4U4mPushptAbALfbJga714/WgvYBWMj41IWC4rDx5tGyMXK7yWM9vqjhME0LX29u1pvAv2HhBOpOfm/+SttlRCTiuj6SIfQNqK4gHFabs0TMLZr6JihZq4LHWzdHFnQ3NAz9HeYIu5f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjpU6g8c8JRv5hiV3iq1V65p9qzCmgSBAWn+l/0evds=;
 b=fwD2mHNTfbtl+XhUHXt+OUX5wGNbIweYA97O78G+y4WIEkjSJZvYU6a3/5zSWLnCD46RIiaC4Lkd/N/zMJMJZO3dmzimaKRhjXzY6vc+Rx3IW0u3Zt1wBsM+isBnYQImVUmiRyPH4V6NVWGUtb/xShZQUl2oDTcPm59pgyRF0vKlrX9b1+AmRlVtAsjSzKSdpzaWtkLYZ8rR7JHv+DbBfU05qIooIFu1EUYTM5hNJ6FjbioyMHzYnln3KtGWGw/GQpkueaTYgXP5V7QiXHxp9pbDDtM8koajSKRmwHyVVokmkti3ErewpLM7rHq0u3wMPT5MO8nii/AoaFVVRmhYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjpU6g8c8JRv5hiV3iq1V65p9qzCmgSBAWn+l/0evds=;
 b=cd0mHfgOJhDJsD/a7Z0rnjCH1NrXihBFsP4tY9GUnDmXxdqYe682l08/HxybIiOI9uunB330mDzEwgXz3NRGLHw5E+3qEM38LnMRp3ypFFUi63T0a/LaRy4w+hN92th61tUTaYaIgWcLzQXAPLkAXklSvDw8zzn1q36wcHx4Oln69K8UcOISgyQs9X3lFs5YyIR6bOzRnaLhLUCkTWWDaW9M4Ko3wWmC8wLKanN0llFPoRRdapLslY16pcyH+v4lV1fz6+2iEyrS2oMmADAcW84mwyw7Mt0CrqQ+NESmtaVHlEFo9tCTN+R631GaEIeTtHjGdE3BhmhyIP+illJ+MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:17:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:17:43 +0000
Date:   Mon, 7 Nov 2022 20:17:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y2mgJqz8fvm54C+f@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2k7fkxSzxTPTXkN@nvidia.com>
 <BN9PR11MB5276EA038EAA0345CA0ED0438C3C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2meOyG2zY4iMupy@nvidia.com>
 <BN9PR11MB5276411B47AC310E928BCFDB8C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276411B47AC310E928BCFDB8C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: f14c7abe-4da0-47c9-4f6c-08dac11ea7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hviEFRBB6B8ngfuAFPLNXpfesdqPbtyAmax4lTLYO+Kswxl8vXmK7s+8gy2pRZhv0CBip9kZ37sxVmYexIa8W7HU2wurzl9MJVZpgoeHFHd7IKzbdsQZW0TRNtOypssEewz+A/qhKvlBuDXyUr8g8sCsnTZ8PmFVELXNsYATiD8MYDUxTyBitZxpGwaho21QAJ4r2uwdeOS3eemSq6hvBbRFAVG6/Ggcg2GTmfJ9xrWaoB2OnVyf2IjIp0vCVeCtmMAdwWsZ6WXlN6M3EHJbmiozDAqlfe2Cvv8f/DrQdGDeRSdBqNGm3To6dYmyH1EhlcBrafeN1Z+1tBiNDpGuFPVdlNn2sYPAwadSdT4NUyhYSXsUXa+oU/PjwZLtKEYhoQqNxvKPDec6iSc4ufbXeRdWG4+9jlST79I5oEz9odSd4v+Kqdhv2OueUVH0WUgGSqQEd0laslMUyJZxoCCQxGL1mYvFWqaNEkp/sZpfdy6RUAvwlxocSheQjMWBvtjLnPanH8+y+f21rURWW95IU16Y/HTGyIpIrYPbWMtbeJ2PJgDvzv2zGEPHr2WkgiB8SU82YlFZzTfSHmXC5Bo/ZD2JEENnLuvaBpMQajVOkbr2mJORGtOGZBfnO6s3HkMBbbCrHPlCuwzc/LAsiTZhjAT34j85xSn1VDsFYBV0ChUlWDnXQprzHuMFLcM3Tn0XkW5P70eXi2RT9BiW9ThdAS0WqL6qQgFlmoHTRQetBE1S0HNt6m9vf57g6vqXFod5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(36756003)(86362001)(83380400001)(2906002)(6512007)(6506007)(186003)(38100700002)(26005)(66476007)(66556008)(8676002)(4326008)(66946007)(7406005)(2616005)(6916009)(316002)(478600001)(7416002)(54906003)(8936002)(6486002)(5660300002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ceBt0DoUSp+rzhjy+JpWGVqA6tKmEv3WeHMr9LlIQevQWWIruA7XuW/bk8i5?=
 =?us-ascii?Q?qXTV4UzlzyvcmJBij4cZWl5flrrwapTzgOWGC+bdqhqmZ6FGT2vND6AF7+/j?=
 =?us-ascii?Q?86zuwkhDcVOrw5gec8j+wMaw/0DOKcyODKkO+CFgeQ1gCRnySWEynOzxRxar?=
 =?us-ascii?Q?xyWmA9SynKvCWEzncualYCbsPsBb0dJ2LPMCtc3f9UkY15eXIgj0BT4EwOjQ?=
 =?us-ascii?Q?bXPEeBbGDUNxb2LXr6tnRUOZDLlEN0c53Nh0YdJPvWkdXTwnCP2n51FkvoRQ?=
 =?us-ascii?Q?4KZluOosEzhSxP2s59TG0HotBFcKKfsS3aRGSKxgqhmk9EtAnoCMzmgw51Bu?=
 =?us-ascii?Q?w0+3iKSgsHAEy1kvCGZBkgQ7nMfWZPgwwWdGnlVEYUG5+h60u5oM9lIEH5IQ?=
 =?us-ascii?Q?E672p6ouKNYwbUTliXFuqN+GtvWfw13karF+C0eM5efJzjNQLbcllzNihSIL?=
 =?us-ascii?Q?XegEildUqYz1p5RcMLq3MNoWlqgr7ZuhPE2NWMSzYy7f/QBo8uqho5ZAgIdA?=
 =?us-ascii?Q?hfPotjXX0AlLvpdw8/M4Jypa3ZMYlM4T3tyC2aI2OmcIPYzBJygCgTLsSi0d?=
 =?us-ascii?Q?eGaiM2fq0Mvd00uJAG4b2MvAKiXSbL3Lf4zkirKiD56BLhms18nW3V5zLjS4?=
 =?us-ascii?Q?gbKN5qKCP2PP4EylnsZc5lDtzQjcdiGAtHIX5nc3WiA/QENMmqyiYurhOdDp?=
 =?us-ascii?Q?IVlFetkzGtFdvvXiSYUtTkkjq08JC8K7xzky7feAzVofcaKsPpE7r5HMBKyp?=
 =?us-ascii?Q?57xoNpPNLDqH5b/JI798ywXO5NUYZ6U9PjplU6O3kdJFQxZQvO9BD1ODSuez?=
 =?us-ascii?Q?nkDpdzyfdQe6A4swgMOsCv78/n6nxdzzvDV2viWfLhHgS1j1C0deNzNY3XB1?=
 =?us-ascii?Q?0loFvGVRlQPPpXb3Z0p1lHZ50w5ZU9NANWyOfZpT7iHXG3md8TUsMxq9N6Os?=
 =?us-ascii?Q?dnrvQ7vdxpSxehXeTNi07/+WxyUCHYZcGuppbbVtPqbfiGm9HAdBTHd7mSSH?=
 =?us-ascii?Q?+gguASzpnnBD9pz/Iw4FlXTX7LtQ6ZmKsG1wQjTjMskKcNiMbOhJn8YfrnX0?=
 =?us-ascii?Q?4hoDnFyhvrMVnAPlnj8GKRf0lTLVp1l3XvxYYHNlFSYpeNi9xpUMzz0y4KlK?=
 =?us-ascii?Q?Z1n55uEdkEMLQ8pIpMCHKlG5yPfl3aAVa0E7EuyWtlJ9KZZuGZ9kGyKTm+N6?=
 =?us-ascii?Q?YeSdengzBXl3TerDvTMmz+ysSS5QENyDLEKIbCXh+QgwqC7h1zuaaMyMFX2K?=
 =?us-ascii?Q?1/DBv4xPSDjZxhXEChyRrbi1VsPb9/VZX2ypP+dLUN6QIMOPmMmImxEq9zVo?=
 =?us-ascii?Q?JuNlEO2Ww2RSonZQXoYTV2sW7A38AGyNcF5N/5VIjGbsCrbDtCvehnWt+ztr?=
 =?us-ascii?Q?0cib4K7DacjrpVjb3eJoI2KFSOJ3J/tISY/t3xqCjmBBym+pMhwqHpyU9Z9B?=
 =?us-ascii?Q?s+vV1bx9oegrE4bmABWvQxu0CM6Pp4eGkYaTU2YkT1Ep4SvrXwlbmQGhxdcI?=
 =?us-ascii?Q?++cDA0YyRm94+IzzZLKPG2x1gcsgRhO3GKLJUNhrdylPa6HejI6WZu0cOyRo?=
 =?us-ascii?Q?Z2phBUfFKykV8J375iw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14c7abe-4da0-47c9-4f6c-08dac11ea7c7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:17:43.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fF+YOJAOj1zLWH75JUFwpgPn5GTCl4omlut13XTISNpsRQ9cpnMLZ0zKWKQuN++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 12:13:55AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:10 AM
> > 
> > On Mon, Nov 07, 2022 at 11:53:24PM +0000, Tian, Kevin wrote:
> > > > Other than that, userspace can change the IOAS it wants freely, there
> > > > is no harm to the kernel and it may even be useful.
> > >
> > > it allows devices SET_CONTAINER to an same iommufd attached to
> > different
> > > IOAS's if IOAS_SET comes in the middle. Is it desired?
> > 
> > Sure, if userspace does crazy things then userspace gets to keep all
> > the pieces - it doesn't harm the kernel.
> > 
> > The IOAS is bound during get_device, and that is one of the key
> > conceptual things we changed with iommufd.
> > 
> 
> what we changed is the timing of claiming DMA ownership (from
> SET_CONTAINER to GET_DEVICE_FD). this is fine.
> 
> But adding an interface to allow the conceptual 'container' tied to
> multiple IOAS's is kind of overengineering IMHO.

It is not engineered to do this, it just simply happens because we
don't have the concept of a 'container' at all - and the emulation of
that same concept is very simple and doesn't try to block cases that
vfio would have not permitted.

> yes no hard to the kernel but also no benefit to user. It's simpler
> to constrain the compat layer based on what vfio legacy has today
> and then position all new/fancy usages with the new cdev.

That isn't simpler at all, it is whole bunch more code to track these
things and decide when we are allowed to execute an ioctl that doesn't
even exist in the original interface in the first place. Right now we
don't even have APIs to trace when set_container/unset_container have
happened in vfio to even constrain this.

I don't see the issue, the ioctl that manipulates the compat ioas is
new, it is optional, and if userspace mis-uses it without understand
how it conceptually works then userspace just won't do what is
expected.

Jason
