Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8176720E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjG1QlP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjG1QlP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:41:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC414202;
        Fri, 28 Jul 2023 09:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY2ZbmBkcmFT2NKh5zQnOE2gLzOwzW6RLK9I9FzPM9zeVRIfMieq9v4iXNh0mAyBBZ1y+S1gEhXoOnx4mQxfaApjryERYRzZJfF9S9/rop1JeypIYbgKsDi456h4AbASs+MEKTnIoA8XGs9yFxyod2K//g1cH1ZMavwLpZSxL8FqFmuLUDUF8jVNXoBDuOKUPrlummFkLRW9FhZRlPl0+MZm6Gqk9GY6v3CqEeoukkBnB4f0o63rC8wFisJ6mY4Ifm4WmZG0p264qm0JgAo7pgkiywmHjfF/gI9pZQcoCGjpXL9Yq0aD6jxkQdCEfQe4QC99FMskWDFgSomc9rIedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEfhOZ2FF5oRJyEJeuKzREsnb7V/eYQmD1aJlFcDCm0=;
 b=UXI/BEwa7VIZ8nzG1dDiPa/DXVjLHSQya4zELnol/DMpEowHASRMjUNwUsjR260EWFM81vnT1V+viqIjSVJJlPubJtfldILiwvMx4baDvwkqGEt2DeWGyV9KVFCctkFC0VOG+Ax9p2JqsVZ1w5u5ugM9WlXYRVhtKFo5owqMuP0EQyQvVTRNiQFQrReVvS7GEGtdhsEwAQWZh5Osk3vK8C8DVq8P/xTF5Pb9cqrPcUKrh1R8rIKUpDz2MqTDDCj/5u2IaMa5Q7ZeQ5MEmTMp7C1F/w/l7nHvqGv5mEW1RnXLUQa9GV4LwC0KyMZAHsF5AVW5pLyb8wqXM8vksNcGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEfhOZ2FF5oRJyEJeuKzREsnb7V/eYQmD1aJlFcDCm0=;
 b=LR9VvGsbhJw0i3NBA/7R6gvXn+Hhg+VoKRXJ8d/jo8NUPzYYKU61WNoftf8oy/m7T4OB4wIenTOQNH80SJCValg6JlKV/roUeTDHLJkZIDbhoAaAkSdCEuXTjLoKJ2CdxvWMA8SEKfl+ksgm9ItdAiXBy9u2o3D45ARC2CW2QCWjpqv6XAB9/tHcXOK3W/+6EK97k9AnevnS0Kfz6zno72Frv8H6XHE6UmoHKCz7EXhD6jbt1UnMYFo7SeAkOXqYVw9ge+pVThk8HL8zKbfMMYeHgQB+GQX70byntdxxFU0qJkN7RS6G36B/GFPKIdS5+5WiUywZqf4Qgi6oy8c2YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:41:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 16:41:10 +0000
Date:   Fri, 28 Jul 2023 13:41:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, alex.williamson@redhat.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v11 0/7] Add IO page table replacement support
Message-ID: <ZMPvo8y1KQRFqefi@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BY5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:a03:167::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b75266-83aa-4984-70a3-08db8f8972e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miiX85YYF7UMhi3xa1F7BA5Ji4nqWzMamC7oT56NmgoUhSjAjZdfm2wQRxpQW5XesR0KNiVUlT5/tL3nnt2BaWcM4Uk0WeaKcWI6JKmZsVjN2BClLtPgf0aN7fWnk9SbhTMG2X2PNq1OsDeANb57lTKFx2ZpqOS/9UYqb9PUFbB2HX0ngOsctndv5HUTEOQmf2RLZmfXtdvmhb5T8xAXT4DZN9LPL4kxvBHdmcEurskbRXdAhmohWGnbufafDJQ1/wIddENH3yy+U3447CF9LTA9/o1JjCBb453deb/GKdPb7SeOxlwiN8eE+g56FZiDgbs+6i0TQi0OorEByhmWNQmPJLLHiQSiEif2H+IBM25oehV9oVhLps7Y3EXy7i2nSaZTaRDJkel1nS8kl9AwyVN2yGAkOrZtHWciv62wYpHjfZx5tIiI0TJo/1qq1RW3IO90KAXbYd3omRJAWVwktbJVqpv9OtAePQOrLgNC5GfWiU/QG9YFgwEa2/98O84r38Yhf3RrzYhDXYAHNmj164azgSnTM52qEQf6hglCFoqf2kSvnSqbiqARF54xfjHf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(2616005)(83380400001)(6486002)(2906002)(4744005)(38100700002)(36756003)(7416002)(186003)(5660300002)(86362001)(6666004)(316002)(41300700001)(26005)(6862004)(6506007)(8676002)(8936002)(4326008)(6636002)(66476007)(6512007)(66946007)(478600001)(66556008)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jBY1yPpTRqjAaM4hCYMojR0+qp/Wn5+KfHWZJ28Sg5U3oYw+P1wIG0rVGDO?=
 =?us-ascii?Q?tzmrpWEN+XqD990knyBWPvGJ+Rw9XJxpPKGWXirlWvEYXTD1M32gKHhLwYrx?=
 =?us-ascii?Q?9BXNGdjTxt5b8eDUW9EQUCvKln6QW1hmjCckDB2GBWcEHoKr58enEBE91CyZ?=
 =?us-ascii?Q?T2woq9CeqIfq2CayPMXeEC+yrC352zTPtDEa6EKu8Hsx7/VRqVNri9JSqExt?=
 =?us-ascii?Q?k8pro2bQO/ZZ+9qxS0PzwZSj0IWkAcZEhB/IVL7ONJu4aWISDQK2Gh0rDM4U?=
 =?us-ascii?Q?3RnbdG4ahgRKFS1Hq/AEmOd2xbZDT4/rYP4uEhUhIBMXLJSUajB0LAUbSJeM?=
 =?us-ascii?Q?PQTj6sR/Q/A9qKr3gfjaKPiv41SoMKXva75st9+LAy0Y7fiUeelBh16c/xcr?=
 =?us-ascii?Q?bhg/7CpfF+7r7+dSl8mMC7UmVIGWl/ENsiKch2TvQTrqf0lYUrWXiPXw02EE?=
 =?us-ascii?Q?cOWZhNAnZDEwIVHUTJ7mpEMLgSwgCrvw9pBgcd4xFmxmjKvOrg+zJ57jib7X?=
 =?us-ascii?Q?aognXCQrRlPH5B4xmD0MfhI6n3savcu/eSV+IMKCzDyAoHcKPvMFmIoOh5z9?=
 =?us-ascii?Q?d2kiQa9gWxPHvuxze2+zOL3oNuq2fL8UtovRXzcX49EyjuG2aU4dCJNeJiA4?=
 =?us-ascii?Q?HJVYIa+vzZijBJkwgTPBGjlqpxqQjtkumy9V2wifE6mnWeXGzCgf/UTs4BrO?=
 =?us-ascii?Q?ioSOyMBdW8Jewl4H2PNGdtRmFO87PgPEZE4KvAC7HgMkjXdJOYOaUBf4uWkR?=
 =?us-ascii?Q?DSLwZfVB1HLdrRDYKkWBb7VpOh9QMXI4R0t5gevZqAE2OtkPCfpK/8ROwIO6?=
 =?us-ascii?Q?yQkrk3EEB9F2FUjoVYgH+M2yCGbAB/uU5MgYjeE9mZXP0MDLIloADuM+Nocy?=
 =?us-ascii?Q?tujPxyDi2XHjl/Yf8MdeZhsqHd1DSKJ/A2kV8+PtePXuhNbjpRKFVZbPv5gW?=
 =?us-ascii?Q?j9axgv5hOKIGlh1QlW/stwkdqwb1Se/She3pJ1eoN02TIq5keEaKdFct9SYj?=
 =?us-ascii?Q?kglcffP8K7CsXUR42Du8VfRHvkElvPa7rDoecIXnbmBCH3MNq4rmApiXqkQm?=
 =?us-ascii?Q?qQWgG96mLqC//Gq5yLkCsFORpjNjOu0vlKw/sUxZCLpoX6h2ls5f0XlwGmde?=
 =?us-ascii?Q?j6NcNZ5mA0Mgry4FRb/r6GbnNSigJWnPlKz2h0Ak4HupZnCIVlkf3TWZeXTj?=
 =?us-ascii?Q?s6HVowz0aJINu/g6caw1Xh7RVMrE9UPMdueti0DFzn+JdFC246eqANz4bLeX?=
 =?us-ascii?Q?rGSN0sDiw6clCeejAIdSzVXgtnVuzxy+SW+GOb3NAFMiwQHjlWuZqmK1Il9J?=
 =?us-ascii?Q?GmkUhiTNYsjVpKLF7gupA0UYTkn+/vNX6P2hOJBEAoEKGVao5332rXiJcz8u?=
 =?us-ascii?Q?2hLcZPzQhp5KwMJCuDH+ji/LVphnzePwytdo1/cb9jdU0+v74AaXCEMa/ZBa?=
 =?us-ascii?Q?wMcPyIgwK+bjWLXdouN1/BFDve/DlyOkjq4bqYWVjyTlgKcWbNoH7JL4+lM7?=
 =?us-ascii?Q?dTi/r0Nb9pUE9t5PFogI7X4pEQ39bSeveY6YR8Nm1yM9OGkc++Xgjk7kr0j9?=
 =?us-ascii?Q?Knf7/ggYqmfottir8+Fg2byzClNaJE7IoDB+uIIr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b75266-83aa-4984-70a3-08db8f8972e2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:10.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn/4lOzhMu7+rwyPEj033jnJjpVt7VHlffjE+FNKenGLMHxfO6gAJ+zrU2bn5ITm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759
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

On Thu, Jul 27, 2023 at 11:33:22PM -0700, Nicolin Chen wrote:

> Nicolin Chen (7):
>   vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
>   iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
>   iommufd: Add iommufd_access_change_ioas(_id) helpers
>   iommufd: Use iommufd_access_change_ioas in
>     iommufd_access_destroy_object
>   iommufd: Add iommufd_access_replace() API
>   iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
>   vfio: Support IO page table replacement

Applied to iommufd for-next, thanks

Jason
