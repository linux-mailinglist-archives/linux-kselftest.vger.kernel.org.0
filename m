Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1BF692C34
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 01:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBKAo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 19:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBKAot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 19:44:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3B6FE8D;
        Fri, 10 Feb 2023 16:44:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n565GDYPxpdaWYV+l+pXvsGFQfxQ4BTIawPTIz7mlM9KekKJJgy2Go/6Bx5GKdSAgCjej8wIapVtDvLr3MHzS66+wl17EbkoctHu4Gw/wdW68LynNazxjSAWEWRuh7+MBYpkKu6fOuT0iU8goSdlUpWS0L67wCsPAVSwSyPwmcJpGqky4Tt1a5a1HfnZEV69mWFmvC88bEH/rsHIU7iLJkImRGUFpLVphyGUGow0Sb+V5ZpX6aEe8EHs2z6LyFhQsWsN8A/pjXaV4HfYpqSZu0as1ovf55moM9LqhJaG/EdmbPHkZkT3/XJyi6R8tY9Yt078ul7X0A5lXza3H82GLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzyYI4SMIIRMKBVigltxXqbFrfGTHbn2xI+ZTH73ChU=;
 b=VjX1dgC1oTyx1gIpr0sVti+KHzFhBuFC7dEVE78wWFCR7mWc4mUXknH2//QN4IRtuSW6WWBwH38kM5xFUT+6YoBcSQBkvQUCQSUOKzY2ITZ4C2JeoCY+m7wV8tDfDUcUbQ1ECJXqJFD9HEW3HQXrnEOyrctM4HKV5FD3b2s39L/NaXZH/YioG7m3A3KSXF9P1hEYaYLJSEVv2t+97ta/fPOGFhj1Wvx63pu5Ng6McJhck1fUqfIMZQs9gauRYwFNbp+0hETpyazKa2if6k2UgAShE10L8EPitMpPO6oc76MwWjxK5c9ml8tqI2kcSByQVXlAApx6IXAkjFd9/0GgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzyYI4SMIIRMKBVigltxXqbFrfGTHbn2xI+ZTH73ChU=;
 b=lGkUmkGgWt80x0fKTa4CgJEZ/Z+XVZsZ3GiACK6ehXnzHfGNbx8axl4zVFvwRi5Y7ANx7jXkfR0LmnufJNXAdEGd6CnUTShsrd7sPdePbs+jDDWvFV52QRTZ68kLuhNzphMjmXlZHYLl+5UqKk1/K/W+Mv+VvYVHteOPq1Ga+AYRLv83Amug8A3FVCfPW0ICmx7R9YwstriKUlEkpJi4lvOjKnIbMPYQ/GL0sk462h6t4zbbGH2hVHzQnoV1EPuUyFU5RQDOd+l7F9a25oCa0gJX8SGx0U2siGGzbqew7p5GoSTnORsp7+bm5ZRMP7VGPeF4uzZXMi2PVaN5YanwZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 00:44:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Sat, 11 Feb 2023
 00:44:41 +0000
Date:   Fri, 10 Feb 2023 20:44:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        shuah@kernel.org, yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, baolu.lu@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+bk+GSCPKOJfr1f@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <20230210165110.4e89ce55.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210165110.4e89ce55.alex.williamson@redhat.com>
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a7c498-612b-4360-886c-08db0bc92916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6azTgrSvBTARk5lVH/3GFVnZeCr29kIXX2O6MBFCDv2vyRAJXc53y8JoLg1XNgtdBLS+0roJrg6JAMZpq4Y6LZQoKfdjwq10h5TCMrhxz7KTIO2qu6Ul+l1FqT0Fl1Qy0oRd5XV3OlxR31Z5EMJ9WpVDVPbszqtAxVogqjd9KdDceTVcVJkplQjYlKRs0YeNRGumTdGjLEZRDSJ9581cJBtimjsrRrMQXnB2nS/ogZBnVQonX8JedrOlORVwwcJ8YoP5NdczV+yCg3S+j5sNIxykYTF6QnsLTTY1nTX6psz5dU69WK1nytO6ETjnFHDT2OOA1G+QDZWi+gSth46n2aQrwhdIh7DX/zYfKkHpy54Uxt8IOhAm+O2TQRh7X6dbcxklvjYuvf07+KDJguIclpx+XxQ6EB+QrAuvzBIyE0CUFrkw943K6nSRFQ3+1eiKb51abXW4Qk+Dg5CoCiF48Iz2/pldgtvJGb4BXwE8mJ5nC3l21HslbMGYm58AIUYIdHBBNPmLUMN1xuKrKv4MGdhYB6RtqFsxW4yGacjvpsftI275X3GS63tCtjUitjuKim20KAkhkNi70SHlMfDtMXIwTQGTx6i5Pc8sitlVsoGPtDt/pQillrEZZBDH92XWvje7phzlw2LoLfn6++KHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(86362001)(5660300002)(7416002)(41300700001)(8936002)(4326008)(66946007)(66476007)(8676002)(6916009)(66556008)(2906002)(83380400001)(38100700002)(36756003)(2616005)(26005)(6512007)(6506007)(316002)(186003)(478600001)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drZ8aNO3mFW7znSRkjLQrHGI0eKPXMaGy/6Zm5KjOxmbiH1Hz4tllynDlaMX?=
 =?us-ascii?Q?QzZJ8Qb/N72pB8mPXkcoIOJCdVl5zQMrKeq5P0rosoCHMl5dSnjLW2urD4jC?=
 =?us-ascii?Q?MOOyW7sw+YPF8xEW3uFo71cWBIFoEL4EROoWyl6So7kP6ILj0p5pwwxdr2HC?=
 =?us-ascii?Q?F0iyQ7Bje/kV1NZi/Mv5ZSrNZKrvJ2CYVCKKzTeUICjx5HzAS7lKiTInIFcw?=
 =?us-ascii?Q?4KKuz8d8nSu4TJfpNskgwGClDjDFG3K1B8q+CUy7E66jo0+Y+jxGAJFJvpRi?=
 =?us-ascii?Q?i6RMmi82SfLU3Idysoj+DMEnsBlu4W/mJc1+OXKxnQzRnmXzvFIrFZ5WK0y6?=
 =?us-ascii?Q?LUaDrPOW9umE17ff3k2LqCB7LlcEBZ2zHYcjB5QDjO9eba8IbQYEU09TgPII?=
 =?us-ascii?Q?NlsyC/JROE3NHRMPv1F/neeClRYQ1OOH4PJuca53T6z7CAC8nGNtZ+j2lezG?=
 =?us-ascii?Q?Bd2tPcQn4z8bIJxsjCmkTkiRCPzaClN0pVI6YKAt/jCGr3Um90n/WrVzOTP0?=
 =?us-ascii?Q?qeqGIdFA4S/cZMEZnkLkPke8jpMcUZaPikcukPEf38hdS+2m2abXDPhv7vAg?=
 =?us-ascii?Q?2qhqbRpQ3n8o3acDs/SbF0paWx9tVnNCIk1j4BEsYve9PIU9RDNgJoX4ns32?=
 =?us-ascii?Q?P/WSkm4rAxi0MCo/+rqZkqrnDw4pfu+4ptfUQSc4Gt4/NUoFjIyQmOAXefkY?=
 =?us-ascii?Q?z5SamF3vKrIo7JeGgQdGbMobXStvJDDpd/2xPZ6GqXtDxsYoZT6tZXOHmbmo?=
 =?us-ascii?Q?OqblEK+ZvauYM4J9/8INb9JXIXJh68ba73FqJAedcF8eOVQTKxQO/YQk2Gck?=
 =?us-ascii?Q?nV3p8ZdxF1V7oFeR1/7+shIE37YUJilLDn4hLuNkG2mnSrugqkf3auDUAYQc?=
 =?us-ascii?Q?MzFP1EydTl1KDRzfQh9wjs4wdzliafhQLdBiJHzpBmp03hD0rn1Y6AEEQJE+?=
 =?us-ascii?Q?xr6eP2Y3FofCTHWDNGLAR2nNE/weCJDLP/k3JLyn9Z0QhAFqamx6vZ8rqdcl?=
 =?us-ascii?Q?spBt3DkVRSX1yWv6vHuOsDP34uENuGoxLCveziMOJqrto8EZoMSgwgBsVqCw?=
 =?us-ascii?Q?5o2vx5yriiucuMr5ea0SVWuutEn5sITI+JnzTKaFhUIzUxXnoTXcoBF3ZbAZ?=
 =?us-ascii?Q?ikD/NKaACSyYVWRntg+nbUIwFG/cNTIDU310LlVivYBrFHAJe5dr8RzNtrpO?=
 =?us-ascii?Q?UV90Jbc4UbSSi4VbTlawysB4UUZwfu2axaJjsGJNQZcF7u4OUWNQdpbMr9N9?=
 =?us-ascii?Q?Uh3aGX9siTAfDIANEfeD0i7lU991d7np+9+9lu2nZ3kFsSOv5EO95EbDVPeX?=
 =?us-ascii?Q?Ai0t5t83439EEeGmIWMeSxSoYYQ2V/41WnGQu8nc2s/+8EPvR8QVcfgIjW9P?=
 =?us-ascii?Q?qBRHVNY8PiI+nTbbXQX7EiTtsiWeTGaOgfq+Nxn0ugtf7ZoRPvMxxCXKVc8Y?=
 =?us-ascii?Q?1wWpGtDOiUOTVZ4wG2C4v0LjCUSW9UBFgwpTY5KgfRcWUsStrDIjcGIpiWW7?=
 =?us-ascii?Q?pC7+cwHSd/KYwKkYOuMbwCIshAVNwyuGA5xlX3wR0QI7IRenwobJzA1SurlC?=
 =?us-ascii?Q?itsTpRcZRjCc0toWUDxvonnMzHzEEcMTvc/FC96Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a7c498-612b-4360-886c-08db0bc92916
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:44:41.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRxw1X9VpO1SbKV1gAG7XALT9EMEk0dzKlP9mnVhETTo3ozmrx5qWGIed9sgbPQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 04:51:10PM -0700, Alex Williamson wrote:
> On Tue, 7 Feb 2023 13:17:54 -0800
> Nicolin Chen <nicolinc@nvidia.com> wrote:
> 
> > qemu has a need to replace the translations associated with a domain
> > when the guest does large-scale operations like switching between an
> > IDENTITY domain and, say, dma-iommu.c.
> > 
> > Currently, it does this by replacing all the mappings in a single
> > domain, but this is very inefficient and means that domains have to be
> > per-device rather than per-translation.
> > 
> > Provide a high-level API to allow replacements of one domain with
> > another. This is similar to a detach/attach cycle except it doesn't
> > force the group to go to the blocking domain in-between.
> > 
> > By removing this forced blocking domain the iommu driver has the
> > opportunity to implement an atomic replacement of the domains to the
> > greatest extent its hardware allows.
> > 
> > It could be possible to adderss this by simply removing the protection
> > from the iommu_attach_group(), but it is not so clear if that is safe
> > for the few users. Thus, add a new API to serve this new purpose.
> > 
> > Atomic replacement allows the qemu emulation of the viommu to be more
> > complete, as real hardware has this ability.
> 
> I was under the impression that we could not atomically switch a
> device's domain relative to in-flight DMA.  

Certainly all the HW can be proper atomic but not necessarily easily -
the usual issue is a SW complication to manage the software controlled
cache tags in a way that doesn't corrupt the cache.

This is because the cache tag and the io page table top are in
different 64 bit words so atomic writes don't cover both, and thus the
IOMMU HW could tear the two stores and mismatch the cache tag to the
table top. This would corrupt the cache.

The easiest way to avoid this is for SW to use the same DID for the
new and old tables. This is possible if this translation entry is the
only user of the DID. A more complex way would use a temporary DID
that can be safely corrupted. But realistically I'd expect VT-d
drivers to simply make the PASID invalid for the duration of the
update.

However something like AMD has a single cache tag for every entry in
the PASID table so you could do an atomic replace trivially. Just
update the PASID and invalidate the caches.

ARM has a flexible PASID table and atomic replace would be part of
resizing it. eg you can atomically update the top of the PASID table
with a single 64 bit store.

So replace lets the drivers implement those special behaviors if it
makes sense for them.

> Or maybe atomic is the wrong word here since we expect no in-flight DMA
> during the sort of mode transitions referred to here, and we're really
> just trying to convey that we can do this via a single operation with
> reduced latency?  Thanks,

atomic means DMA will either translate with the old domain or the new
domain but never a blocking domain. Keep in mind that with nesting
"domain" can mean a full PASID table in guest memory.

I should reiterate that replace is not an API that is required to be
atomic.

Jason
