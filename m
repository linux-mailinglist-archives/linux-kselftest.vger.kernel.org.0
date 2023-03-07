Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51426ADF06
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 13:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCGMq2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 07:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCGMqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 07:46:18 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA77B9B0;
        Tue,  7 Mar 2023 04:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmoEVav1a4QONo2AQJ7qXTVA7SzfHrrZlqUkanA905+PAIebaVlsnaL5YMy5tB1K/opmfO1RCD3wUTfakjkAWUaEeeqs841Bj76OS3VDEcnkficl2w1Tp/ZxkRfr2toeHl/jrT59gGVTIPjrlyK8HPNzi88/h/Rqu8fABJTKh+0hvUYWAVIkEC6/xlFZCAX3SZIrtyV6Y5SZD/rl2Bx/CgGVpyMAinSOJmoKeS+Ki3TGqHXWejnrwWofo9/mkRCqiXKyXGR35mDGKJkl5/cff1wXPNgejD9itGfxhLOHRrukqAU39pUII01CIVfaWO3DzfdxIWqjOS6tmdybaM8ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IHtQ5pSbituyIMe8qElK0VedRnq37HWdDAFR3sy+I4=;
 b=IAru97uwcwmrSZqejVBc9TacIpBHsUTwhQOnew/YhiEplgFH7PRwHRknZiI/8QSoD0CL/Nt5ldrnOXvl6J87L2AUcutsFl/sj0axkLM5P97EJcV42vgeIuuX+K8/HvdG9xMKbvN9FAwjiPodI766x0ZPtyUC8DZkX22w1+fQaxYh+NvPRVoUOspyc7blvzrPlw1gC2SpQphcSXJD40IrcMV2vDmPbKM9bi8D4iEIzpCb8pEiVvHrNhxum+XbkM+vaJDzXbsNRmz6LH+LThYx83Hz8DzPTVj/Yk4ARMwTt1w06FZrQh0ZvnN8NX/3iIWUqNan6Zn1LF7ISNlP0bQcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IHtQ5pSbituyIMe8qElK0VedRnq37HWdDAFR3sy+I4=;
 b=gYifKjS1okQ5z8+LFEbQ/vHB1RojmsHw9CdEbWAB75YWqeNoO41t4rZvN8kEpSws7sL2d/UvVz7i6Nhl9wvy5qJ+oY1wxWSfMYfKASvfjhxFBm2zV463jxyfxApu/w92PxoKqvSQomQAUYnvmyIOODvrhV80++gvkvdMfUBmFzJYwhUAG9BKHsRg3c8xeK90s/ALB/cnKscAeF91kHxA5ohdujw+GcTo2nygd3AAkiBSmNTXVGXNbUdra2Yxe7kVtrjsOR0+8YeAYFJwmLv6x+43x3gea3tGttl7fZqkHmrfjPF2fX3v2Aqdm1y7OlX2Q44cd4On8aXqhgZb4z8M6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 12:46:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 12:46:13 +0000
Date:   Tue, 7 Mar 2023 08:46:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Message-ID: <ZAcyEzN4102gPsWC@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: bd893ed1-f27f-4f41-c6ab-08db1f09ef2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaf5JJiHT2DwJHEIQrOjbD/DhwHxyRcd631l5IkKZbIqVvk34pB4VfHJh8oidITDWMPA6c31hcD+EO/1CYsp6I278ST29gKAgr2gI63jhlwNVzmx222uYrsA0JRvz/Eb/9M9Ta1Y81difYeI1av6uN/qIObUrc8VymMzGTRttY8JSZ8dKCK2oBUmaMgjpXBPszEwth4bMya/OwIuirbCD8MfYK6n7/iTfv84UGVnmMLhryyQBi037WjT9ZqZw/np9k9nAJtNKi7DHNhfcZIa5x3vW9H2R1W3RGo4ZNooznj/H6LN2Bx1kiYV6C5nqwJzdAMMWywytmXcWL11b2VwnzWO7zxFjrjke+46/TfIJ5auagW7xrqZvGj5/7XLxdxyWMKkB23FVPOecSKpFN63km/wM/hHnI1D+7E3L9fOY72hi50ihaEHxcAT1mSuEdZcS4ghcocfXevkjv11vbBxvsuGPg2B76Vz/C5Wz0D5LeAEoNBqpbAn2k3SpBwNHKlCsjgGgu0B1LWlhnSUw2Gx3m14wleJPN7kw2GpMkM7bPvZHVjcU9hf/FAyfS+6Ay/SpLCVJ5BAGx1/iMLWIbBz9m0J5JOHuysi3ZJiWNBSo4ldkLDeDQcKVeXpX7iP9vOSjf1H0m7jNWVFliRuYFI9fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36756003)(66556008)(66476007)(41300700001)(66946007)(6916009)(4326008)(8676002)(38100700002)(316002)(54906003)(8936002)(5660300002)(478600001)(2906002)(6486002)(6506007)(6512007)(26005)(83380400001)(186003)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFm4+TJ1DGtD78bg61l7nlUr2d2PIxC24gGvVJKwEkCkS1aCZrj4n/Ojqtwd?=
 =?us-ascii?Q?sybhufd5QW7OA5B+39aAaV14a5HdFAYGpmLIFce4AP7JOM4jhXXfkEAOZNn1?=
 =?us-ascii?Q?tSb9QqsjIslPt0t/LO2CMxzOdDofzaywKTF/Bwsod1FATahGGH/BCjrNxixS?=
 =?us-ascii?Q?NvpXF59SX4sm1hmNMinRzpaPM1C3iyt1v/A+XdhX4gAyFWJz3FOKNggUkWmL?=
 =?us-ascii?Q?6ON4z8ST2P1mQ1l/UCVSaSqh8ZDpJ5s9FlNfNTR1Pbco+WRe0qMtst1FWk1X?=
 =?us-ascii?Q?Zb6LPqrmA+WWLznAcSYgInBA+lBHabA/KG6v3wOnTKHjj9a6NMRWZqnXs7Oy?=
 =?us-ascii?Q?6ZH/DAKLK7aRpdbNbiqSQLK8MW3LDynq5nAhnRcizp+liYXXjkLdLsS53zCY?=
 =?us-ascii?Q?BiIo990E0fg58ScyTaa7n/f76Sxj1uhi3BCWoZSZbEyrkTGY5/A6rw5KFUmu?=
 =?us-ascii?Q?CekohPsvw7GgioucfkCeV0h/db+mOoUkR316VWgN+d75xDgo0It7hFDF/NQe?=
 =?us-ascii?Q?Bqp6/9kEgfRpyNUWMwSPiQWDN9xhviuYJcXzo22nas2oeJo9ExguoyXv2xxq?=
 =?us-ascii?Q?EIOQfkatz21OJv6ai5hlLKNN4xqxhYBbNJiKDzbd8C1glrzN+x8TyQOwypq/?=
 =?us-ascii?Q?eAqbZFXIgi/ta3O8aqH4lUJ6hG300b6zLQRJ+iPYaQnotTiiw3o+0v4rCP+R?=
 =?us-ascii?Q?XR7mLbAAREihrMhWOCgovri8u4CMJdcVysHQLutrQxWvOAy+y2FEYEBgtgvh?=
 =?us-ascii?Q?TFpE2zLjyueIlrpQAFUtARppriAKl9E/01AEnA0iJ4efnMeCCGIIyebzipax?=
 =?us-ascii?Q?RQJm70zjkaU7xvASx+VG1g19t+8/6+qRfr2eOw5imz4YAT6HjdTjcOmtqVHw?=
 =?us-ascii?Q?pGnp6of7RoQKvOX7iNUrk0ge6PdzNgXzfloy2bXdP5zhiO3hJBk/2biCfP9Q?=
 =?us-ascii?Q?IxB90PnKMWparmt5jw+P2yEq2aFEUW7jjkUDJS3/MNzNlfUzSB5lTqgqhurp?=
 =?us-ascii?Q?CxavXSgVGVPPEwnWH2Xu1ocu5qwRWIguMyhFb8kzo4ngNfwDXZ9K3j/9PjKN?=
 =?us-ascii?Q?9hZWNSgGrod0KddvDr7rh3otjmV2/DNBhTL91W31AefsWXyxbeGqmVD+Mhpt?=
 =?us-ascii?Q?UA3XMvE27I+0oTI2yBQE1jXlC2jSEcc0Lde++ZH2vgke0C7ADpLOn0xuHfRZ?=
 =?us-ascii?Q?nKh7Ux3JNqOW1WdTmgu13CHSfNLbo4G2h5Y1OQribNgCeTBZxQJTBaVZliEH?=
 =?us-ascii?Q?n4hraoGnsCy46leDPkZhJF5yn4qOnuvz0AXKR+srGplQSjRctghLoOUngu1s?=
 =?us-ascii?Q?5OAQqoOka0C9PwTmonmGjbpcvfc0IvpiGpsu+x3GeKfCpkFQ5at/eir+0jJi?=
 =?us-ascii?Q?NNo39wlj0AKfT9DqewRCxjGhpQQa3clR2v10ziHlr8txb2+FX64zt0vXah55?=
 =?us-ascii?Q?8dPn5UXpBRp/mkXAqfUOV+k3OhCQg6hmDCeRaXMT3G7TbTFv0sAytPAsk6Zp?=
 =?us-ascii?Q?74DdwgytnpvsH03dZFGOAc67NbHXGBH4zhBIsT1CiGx/clITSy+T6Aiqj1kS?=
 =?us-ascii?Q?gtSpP8EEWDdN3dbJVNUSMS/vve14bMJOgm2kLfAP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd893ed1-f27f-4f41-c6ab-08db1f09ef2b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 12:46:13.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVC9hsc+KumZK5M513Qk3CGzqZq2221puyFB3ie+Q0KwiEG/G6tPQi16Kp4rhYO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 07, 2023 at 08:42:06AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> > 
> [...]
> > The implementation is complicated because we have to introduce some
> > per-iommu_group memory in iommufd and redo how we think about multi-
> > device
> > groups to be more explicit. This solves all the locking problems in the
> > prior attempts.
> > 
> 
> Now think about the pasid case.
> 
> pasid attach is managed as a device operation today:
> 	iommu_attach_device_pasid()
> 
> Following it naturally we'll have a pasid array per iommufd_device to
> track attached HWPT per pasid.
> 
> But internally there is only one pasid table per iommu group. i.e. same
> story as RID attach that once dev1 replaces hwpt on pasid1 then it takes
> effect on all other devices in the same group.

IMHO I can't belive that any actual systems that support PASID have a
RID aliasing problem too.

I think we should fix the iommu core to make PASID per-device and
require systems that have a RID aliasing problem to block PASID.

This is a bigger picture, if drivers have to optionally share their
PASID tables with other drivers then we can't have per-driver PASID
allocators at all either.

> Then confusion comes. If we must have explicit group object in iommufd
> to manage domain replacement per rid, then do we need the same
> explicit mechanism e.g. tracking pasid attached hwpt in iommufd_group
> instead of in iommufd_device? and have a iommu_attach_group_pasid() API.

If we make PASID per-group then yes

But no actual HW models per-group PASID to the VM so this is a
complete API disaster for vIOMMU. Better not to do it.

Jason
