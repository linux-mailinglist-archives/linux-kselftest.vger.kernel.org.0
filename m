Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560C765322
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjG0MDM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjG0MDL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 08:03:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6A326A4;
        Thu, 27 Jul 2023 05:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAxze6tubQ6cJzYpFwokv4HxbTuMZqBLOiz+0J2IwCmGz1XhjaU+ZFYunOMv6rFWxLaWxS5VxD22b0BZpDm/wwPKeFSJ/pCZ3Jw9PRX/gpTW2eDmNDiw7rylLLYy6UrLUI38i2ne479UuFq+EZQp4Vzmrrx4FPxHzp03J70fzYngXOrf/zqEOLOgVyG329arpN5SALLW9Lm2L5RfXDwN+yDb9tV83yQMcxT+l+szdb538iO84Ae0klAxA806jqGVtl7gzM/llztLrNbl2u2ZDPb05SK5ZAmoBXjk3QiGdS4UR09aOhA08XanooaX+6JVGCBIOMnanvgoVP+s0Ljc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTBRua/PRS4tAua7Jn/u6KLRLer8rTd1f/lIkVpfDC0=;
 b=ii58WyMK5+Rt3rFqtKW0S/X21U0uR9xmrt7Nz4MFiML67GGX2eFTmDbv7fpfGuyikcldyZAIJ5l6LRdKW9g/MliDhrxA22Ob/iEVEVnuXgD+AB/t7cUBjfIlBCClLjKk9FBj9LxA9nwO4JKwqxn7bxC8nuolvjXPXatx4BKR+Bdfd4b4R/8WB2H082H+p+Nth4mDpfpiLHMqBiR8ZfPSngsDZjIjmiaiwronCNPZWwftyFyEpy3f3M1dyec/DDUv7N4jaotv6AAdWClJo+zO5CJXKW4IWTDpyemI2vU1HccXWbk7cgRRK3EOmRMv94TfsBpO5y29HaF11KdLVD5pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTBRua/PRS4tAua7Jn/u6KLRLer8rTd1f/lIkVpfDC0=;
 b=paKvZCFPdxpE2rGwkHNZ7N1140HbgUtat6hNW5KiILImU5HseyXExleTDYOLZJjMRu4JV1xKGYXsLtrh4GoYhquXzA72fBrDYDhvSJNqa6/faUSZpjPjorpZHNJzEJX83Lrl3WldbUkVjKQFhY2osU1Inbdm9gpwoB9x7mqpvoUsj2zAJpu9EhqOX7d3+5yMcCizhoFfYCQmVIQjI4aQtEhM++0PHdGzjQaYb7mdMbwLODHuaSYSMPpPqvClkAo+lAbTO+WLIa42CxhfRUsQLd+Nio+A8CWpHQw/2gAaRDkpTYKeLpW/ySDwii1QAlzcOikLCMVZht/pknaGAdvimA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 12:03:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:03:08 +0000
Date:   Thu, 27 Jul 2023 09:03:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMJc9elDILpHaKP6@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
 <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c674d5-f716-44ff-19d2-08db8e99710f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKqmCBIkyAKUU50ueymG0ztF7TBmILiJtwqNz7o5L5a7QSLPJ0lxMnT0dz2/2liCmgxugFon4wkDMJ4D0TWfA1OAyVh2sK08FmGg1w/KCDZ7k5Ng34/rhhYlmjFMSvKvPJr3tZsZQPPVljW5oTZTtYGu58d1BwcOgrLyDEccm07qiUDTQzYLB/eMTMIEoRvlP89eNqx+IYBvg1raCcTEnxJObqg564zSfTbWABZbI92JK/jTDbG77vi1T6Pn0stpj4j0PXJx3uSda7aQM5yBhku0+S4bCBbfGe/T+9I3KxnuFMAnMaUpoSAu/vxNSlh57+UHBO35V90fcLh/BNv/v9LsCIDjSBvCSigrP8Ej6SncTxqrUktSJNXTdNKDi8oxQVWPKueUvWX5boOlxdZKxpSrFkbhHarEu6dLWX8hrJlQ7P/lgoi//DDpiOWtbFOF6qhmgHNCcFy7ltndReS6NZOCIoa8yJSMG1SKJwpc+Sa5rwpMDZzXrCUqNfjPIdHXMI2DQfkzPrsp8oDRAeAGN1bZOSryrdBvlFBJ3spbCebWylGGX0NutpszVOAxTCsJjzeJoLCWSI7VtoWyGnMXm+ofzqqzeO7Nm5uaWChKlwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(2906002)(316002)(6862004)(8676002)(8936002)(7416002)(5660300002)(4744005)(41300700001)(36756003)(86362001)(6486002)(6666004)(478600001)(26005)(6506007)(186003)(37006003)(6512007)(2616005)(83380400001)(66946007)(38100700002)(66556008)(6636002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQUf6vCbWA/biqpG9Abk5FRK7cOnZAOPdlzjLFTetunZ5NWrM3Zyl3qJJFQ1?=
 =?us-ascii?Q?4fnIJ8i6814Bia7gZL6b0jhYY75KKAnVqEwFyMOs8oLgfOzVjuztCshzQf9B?=
 =?us-ascii?Q?ZvlUeq22yGn8DyJv9IB4sb3mU5bcr4daSsmycVVfyvqstX1ExQm5PVcQXIhr?=
 =?us-ascii?Q?TrHV7CaDhVLSlXU3+YU05kkf0Kw1KfdsoKBohPCMNjrr3heAt66NSRPIl7tL?=
 =?us-ascii?Q?BcYMdHUyZuKjC9bMC6lTsn2MK7QVzC7UF5FClr3XH21jzJZ/Gup+GgKSVbMH?=
 =?us-ascii?Q?btHuS56rNDMyFBjvI26B3n4vNmgxY1cNLlHkuDi3yoEq89/6zG4mteY6Pz0T?=
 =?us-ascii?Q?Gulbd0VextIHed2M2eTApHFiq/f75sQQah1qaRj9+gJeWOesHE/smwvqlzG+?=
 =?us-ascii?Q?YCqE7noEBgFmGCfvg8ZuSB1uX4bV4PnE3MjnK4STrJ3AM5gkwNbdFxNwQ6bi?=
 =?us-ascii?Q?GDQOItoEFxGZga77SrrKGcQbyIcxMrowE/MJ+AjhHA+tVuWqgjxahuD365m2?=
 =?us-ascii?Q?xVgvCBWOYfKIu36MI9zkPIasyc4btPbAUgvTNNSO6NABhvCtOaRKs57bIQ19?=
 =?us-ascii?Q?RJRQtAU4jUuxYtySzlNscbAu+3gwGXY4kO5gEJB5YTzIYiCNQ7eQoYqU8Mya?=
 =?us-ascii?Q?f5NQ6XmF2qU7TuCe2Jb81SXDhTpBrNnkzqj+oRZAn4Y23lOFwhdRV/5zkEBO?=
 =?us-ascii?Q?3DqEleUqX66TKg3OfcXxvo3LnK2XthwBvJGDzqTEqcM0WYhmMMJir2Yg464q?=
 =?us-ascii?Q?Q1DcejWnGuTFBkPKutu3dCskhkqTnVlpZ/a4Uarpcbl7kWPTW3QyaD5OzVph?=
 =?us-ascii?Q?hTy8lgnLWl1P8acP6McMg2V55GqM48JwC7gP0dqtTXQnR6EwpWk01TjUKZ/W?=
 =?us-ascii?Q?haqy0DI+TxDtY74fXRuaRRcLqAD1GrV0l4+o6w2BU5bLZZJRMTdvK8+AEhWc?=
 =?us-ascii?Q?Ghah+nDSimBz4We+P/iO8Bh6DqvNgxVZnOay+lJGpitD819IrevEl9/COaED?=
 =?us-ascii?Q?Xac17OAn109buoPRReQBb316Z9vE2Zz0Za/2842rtu9QOXYC7cAK0hklFJZR?=
 =?us-ascii?Q?y32VQ25t+Ikvyc4dNzY62L7uhCdWQYg+9rR4t1LLGzBKUN5SuPKV7+tndspF?=
 =?us-ascii?Q?8Gb8bNYrvsJjkoKfU70hR4gODYXO3sMKSIS7hffuF/Hy3A5uf76WgP2O2YEp?=
 =?us-ascii?Q?egnOeIGxeAkZnzR2C5z2Je8oJEqB9SSbG3UrRKXe0KD7oHaAB9QAf5hoMi94?=
 =?us-ascii?Q?kF9Ix+YdB9h/mXjpNXo2HgyAqGfeI0EfcLPg9uYwimtexYzk6xy/UqA/gfTB?=
 =?us-ascii?Q?0rci/uBaRq5TrmqnjzzrRRqKrwvhr8jTwh5HrFdR2y3XYmyIhKVzkaiLp7+b?=
 =?us-ascii?Q?tolkPC7wcwkJGI4rv+WvsiV8tuksUqhd1riSCrUoTbW9LuTzEr0voXEqyBGR?=
 =?us-ascii?Q?+mwk839ADlq0lPC6/ki5GSS3ifDb7aNWi0Xc7nZkpuvvGYimOyQG4TOZ7rES?=
 =?us-ascii?Q?AWA33PjVfYKIWNYjhNlw9i++yuEIt8a8FNUsVGHUlTSFjX+E8RBzR+1+A+HZ?=
 =?us-ascii?Q?0KmDP1t+qelSdBN4MSwLQPXTRySFCJR5PmVBSauP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c674d5-f716-44ff-19d2-08db8e99710f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:03:08.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b06A3GwTkdHgWjHP/2Z1IdYqFCLQjY7EmDbZ90w3I+oUf8DpJr+ZIOU06yifn1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 07:59:11PM -0700, Nicolin Chen wrote:

> I just realized that either my v8 or your version calls unmap()
> first at the entire cur_ioas. So, there seems to be no point in
> doing that fallback re-add routine since the cur_ioas isn't the
> same, which I don't feel quite right...

The point is to restore the access back to how it should be on failure
so future use of the accesss still does the right thing.

We already have built into this a certain non-atomicity for mdevs,
they can see a pin failure during replace if they race an access
during this unmap window. This is similar to the real HW iommu's
without atomic replace.

> Perhaps we should pass the ID into iopt_add/remove_access like
> you said above. And then we attach the new_ioas, piror to the
> detach the cur_ioas?

If it is simple this seems like the most robust

Jason
