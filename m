Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B746568BE15
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 14:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFNZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 08:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFNZX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 08:25:23 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77F7687;
        Mon,  6 Feb 2023 05:25:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCFS1RWkx1vH24ZxyTMiB1nlTk3BaRmL5R7MPoAsvnz7NoDZnwjj3V/1wYt/QM96eT2h6o3H9oioN9heEmPnfLM7Z26YJ+T7DCFlOjMUjQ9p3czhiHX+Q1zRywD6H3hPCJVvA7OUfe3SENuqewPOaiZ2UWUKz35GYiz8FkT0E1GGRDq+svbD7LpeYGzGWZcMl76t4elW51LqJFe4H+R8GKQJnARZLZqmncvWAotqA2ZucMp20rOWhze4/8Elk+N/SnkeEfTXW+g50TobDkUfDAjdeakarMa6iwbVtzaLp/EqNPUehkrJrmpu2Y1bkcWTL5AWt3amQjLFNevyL4Xwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVf502sn3STVOBBGOfSE8py0qQljcMP5y//7PVVmCYE=;
 b=Op1AtwZCm/6Xv1tWsbtffZ0RwmQxoIbVAI8ZDz7SkrorrvoCIw5MFIdC7Bc1fGjSwYlyB011gk9aPpInsxIDc1NXv3mRff/t7Tfo4LYq+LIJav1alsnUuKxtdHm7PODRzt6SLM/6biPDUrUbHu3M8o49XjpeauuyhrXcIL536sgp8leHuhIMNzfNJBU/kLNM/76/YagiMVqly1k90FdZGQPhm9Oj0cbus+9CZ23KkLfghfRADyMFSMLYdk7ArVpDbDT3cTbp15V2q9iHyFGVKNMJls8HgKIG5qXtl7VZt9H/tI0f7xxiJyII/MHc1SKuB4j2PL9yvkNkJal9AEW/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVf502sn3STVOBBGOfSE8py0qQljcMP5y//7PVVmCYE=;
 b=czPu4IhRuBzdVzm8aJj2iI7pf38qYgSINm+tuUJ8y3vv4e/lNMoCbNQLlbDGQD7pR67qBIiax1CCCmNTrrYdUdsGtHpaho1URMeBDZxQ/EugxX2Rr1u1L6bLLLMTDbZFjUDJrt5qFUlgRBUd2/0aHIgqxVFS+35F1m3ZYieAtB3g0xXpmKUt5s7qmuvfl9CHXCpchKJzeWcXgYul0BGVFFb39a5oG6xH33173OtmuKd7F0JZs169rha7LK7vGsjL7mdrzEkjabjM7AA+Fp4LpDIMsuRsgyBvT0SnxUhNUChT40kROW03g7NWy8hqu7EfUrdLWwSiDFhPKgrOZY7Uqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:25:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 13:25:18 +0000
Date:   Mon, 6 Feb 2023 09:25:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+D/vWwRLD27slQz@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
 <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:208:15e::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7e4e9e-60d6-462a-3af4-08db08459711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9pVA0Pn8AyGFrj+hneD8/MXkKmdw8io9P+GhEHTYL1c9+SttS4tzrRbbh1IB0/pOFHhuy8bOnVqMdBha9BiHukCGObUrCxP10cZwf5TX8q1hnn3e6C/iIo6e8yac79ZNAq/zPmXAf2rgXNTwEewf6NLHJ8REP79/OwXsvJ7wxg9kXfQf5HqJU8jCFUcEt7w/M0vyC7v6l+uPFGbDEZjfVK5Zqg6BJO7V8olycRHKJHhatImELJGOSeex6Ort9OgJ7q1yac5b3slLvkpiewA2lQ44uDq9YVICaqJRwM5AiLWw5NBxTa0Ob5EvyXzkTyj77t6TgNZFr7+q7w0IN4nISANPFZvR4NI7bgcwrV1hstANtK0aYKFYEgwQrPTdeSGIIyDS454VxYhfSIsu7MzQHb1ZZdvyNxl5uM/u/oJDi3V02e8DacfNrxx0bAzsUPvv5TxYaE3AzAnRfWjWsSZkHPoJtI6RN1XJCXd9uiOZkF2ZZpLNV2jm/DObB39xpv3P5i/ZnCLhQdhS3v72maF4PoLzmwSVuGzQhuTvhkbv9Gu+qK4dcX7D+Z3jWlwz0DS+qWcYI0rgB7kFRVVGOVq3atmnOzcfK0Yk5UcMTFIlMQ0yjcKb/YtUMKwwoQ62xsfnSGPhQqTpV/ZU2bSBYpaQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(66899018)(36756003)(41300700001)(83380400001)(86362001)(6512007)(38100700002)(26005)(2616005)(186003)(8676002)(6506007)(478600001)(54906003)(7416002)(6486002)(66946007)(316002)(8936002)(6916009)(4326008)(5660300002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkqM8VWrvN5sDb97PQLfBK3WN8TkQLSJjz59/9gF5E3kGlN1TyFgtFmZfRQF?=
 =?us-ascii?Q?2JhIb2aQAsE3E+rmbiEkT2O9+7SNJ4uGN5RKE0R/Dzn2rGm+yyM9Vh5j1B8j?=
 =?us-ascii?Q?OFK+hmkPqz5796MJGkDTuohZi09/M1s8KP7Yye+ZoLRLNxDCO1OruFR1XAAG?=
 =?us-ascii?Q?wNZzMKS/nIo7Nq7XIi2a3XLqZK75P6uedQA5E8zzrTa5Ob1TrGSUY6DYacQE?=
 =?us-ascii?Q?eW5++anoEaW6g0TJB0SI7aPwlqATZ6oGaQB81uQQjj32PkdkZTZ8PyNzKhwt?=
 =?us-ascii?Q?jpTQjScO0hXV1u4Hy6/eRV6SzT3CCbWtOqI+tGABYuUhPrx6Y5nJA6FFpXNd?=
 =?us-ascii?Q?UJ6svBdBJ36kyyozjxapxo6RrJT/8U17wWJMTOojDqK4Fec1oXwdEm+UioSt?=
 =?us-ascii?Q?hNNAjoDHkkdSUq0ifuwLs5D86xrO0zd4tO3n0wRD9byeTgpbZfp5xfTvgkTB?=
 =?us-ascii?Q?C61c2MFIFfQrF+Mip5dnve+hhZCg3jOXM0JhsooGYA1bBsEhokBMlrKvoxXi?=
 =?us-ascii?Q?Sf7IFVwiMlo2Z+QnYTUu9b8Px6c5+JvklBBvKhA91CbPi7UdSHfd+YL7T2rA?=
 =?us-ascii?Q?pzOV8SfLvaRcf+yZoUJixutry5eoeZhpGhuswKTWkaZVxwEW5xxvHq5oR+0N?=
 =?us-ascii?Q?cVaGErkSHirMfhegEVwtxELfh7cbwF1fkfC9Pgrn9mszcF7OCSZn0T4AunjM?=
 =?us-ascii?Q?8d0oXuHu6O6J9pU/R+uwc7uvRVtzS1h2cM0igXseYYu1beWgAB3nzSLDcyJ/?=
 =?us-ascii?Q?SikKt/EjwineeCh8rhx+ieHy7RHUDsrUc2EMlRvHLdwLK26nkUxs9p330FZI?=
 =?us-ascii?Q?ES6lLL+iSj7MlhEFlwQHEcU/UdEfbJeEJdJ7EzEp+3Ow6n1JtGx0PV2I6dB2?=
 =?us-ascii?Q?WkRQODzs+OWnUJvgqex2L5I4g/TmNZTXTwMVStbE60s1kvGT1Kuy92zvfSt/?=
 =?us-ascii?Q?VSjGkGsuTLugttypmLPHQ5GC6CIlEPRJwHV5cyI0FnYqvOquWCIc4YqK+pyv?=
 =?us-ascii?Q?Q9c1Dwd8sf1tXWRF+laxoThIjlQZWALnu34qZQy+TSp7Vc1LkOQKS5VqOSkZ?=
 =?us-ascii?Q?8xn9MTPAbffVV3AbdZ5XqGyejQUPFRjqZZSz3+3J53yrbHjeFe1XFYaGc0SP?=
 =?us-ascii?Q?rPynk95rb4J9Q6vMV1iFqOct94SKX4ssnWdsNWkZdjucG3ZmM4FTHcLhtJAc?=
 =?us-ascii?Q?eCY+P8GFLWLneMoJ2Hovzse8V6fLfRTv/lcrfS4Sj3QGFMy0X30eB7RFqFvO?=
 =?us-ascii?Q?g0wTcPQ1ZaLS1Noase13fZBNJaDA2z6acPl+c1pFLbPNyEf551jIDN8/yVwV?=
 =?us-ascii?Q?JrxzuObG6zZS3FMvBJ6a4Xxg8BPhWNXl7CYkW18u5Y1mMZer2iue5kG2SYxL?=
 =?us-ascii?Q?ejoZzjpDI5gKsf09JSCja8RNwVdH5EC4QwQj8deIiqDteAsHixbVIWdVox48?=
 =?us-ascii?Q?Tv2jjxSTR+9RZRZfaqfcOtxGXY03ScD08Vdo1jgEqYo1nco13bnxUgKI5owf?=
 =?us-ascii?Q?LrreHm2YJ5pIAYITaOLwbCWNJTt7/rktcz6utWedWni/AYlKkkqyrt+KpxHm?=
 =?us-ascii?Q?+Sx/++M0bibvN+TNui+o+hkSDHqPMoMCGoywu0FG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7e4e9e-60d6-462a-3af4-08db08459711
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:25:18.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TCqgLs3/DodCUtqV6g0aRvVz2ni7E4anlOdJeROXC4WLtbHhXC8lp+iG2cgm17W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 06:57:35AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, February 3, 2023 11:03 PM
> > 
> > On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > >
> > > > All drivers are already required to support changing between active
> > > > UNMANAGED domains when using their attach_dev ops.
> > >
> > > All drivers which don't have *broken* UNMANAGED domain?
> > 
> > No, all drivers.. It has always been used by VFIO.
> 
> existing iommu_attach_group() doesn't support changing between
> two UNMANAGED domains. only from default->unmanaged or
> blocking->unmanaged.

Yes, but before we added the blocking domains VFIO was changing
between unmanaged domains. Blocking domains are so new that no driver
could have suddenly started to depend on this.

> > > Can you elaborate the error handling here? Ideally if
> > > __iommu_group_set_domain() fails then group->domain shouldn't
> > > be changed.
> > 
> > That isn't what it implements though. The internal helper leaves
> > things in a mess, it is for the caller to fix it, and it depends on
> > the caller what that means.
> 
> I didn't see any warning of the mess and the caller's responsibility
> in __iommu_group_set_domain(). Can it be documented clearly
> so if someone wants to add a new caller on it he can clearly know
> what to do?

That would be nice..
 
> and why doesn't iommu_attach_group() need to do anything
> when an attach attempt fails? In the end it calls the same
> iommu_group_do_attach_device() as __iommu_group_set_domain()
> does.

That's a bug for sure.

 
> btw looking at the code __iommu_group_set_domain():
> 
> 	 * Note that this is called in error unwind paths, attaching to a
> 	 * domain that has already been attached cannot fail.
> 	 */
> 	ret = __iommu_group_for_each_dev(group, new_domain,
> 				iommu_group_do_attach_device);
> 
> with that we don't need fall back to core domain in above error
> unwinding per this comment.

That does make some sense.

I tried to make a patch to consolidate all this error handling once,
that would be the better way to approach this.

> > In this case the API cannot retain a hidden reference to the new
> > domain, so it must be purged, one way or another.
> 
> Could you elaborate where the hidden reference is retained?

Inside the driver, it can keep track of the domain pointer if
attach_dev succeeds

Jason
