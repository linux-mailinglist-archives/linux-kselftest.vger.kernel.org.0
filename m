Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00C6AC99D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 18:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCFRSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 12:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCFRSN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 12:18:13 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C996A57
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 09:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRjVn9wLD/khRokp4lhv33PfVY69iF8/zK+dpzVFT+noul/eqO1Xrgy7qPGhTNgBio+7gEyCJTX8mM72GfQWaupoueJ9P0mdo4twPC5Ryo6jyJJ5UHowYe04UBO86eR0Sn4LaPVRDK0YROT8FlGm4wbY69R5tJuX1woZa63vNt+TNVVB+SdWgpaoXRSWon2cYlctMXlPRE/7h2TGurtBSTIoE6xgEEsvGcaY/AZnFu8e7tohLDCZHfUaGiRlC5QgMJ7nhyGqbca1aufFLq+TamnW47lM4l4DsT4I/Y5hLPyqa9ckQLhnVZja6+ZA1Z+iwlrYD15vsXbqPP9pIpiuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75a+fWIvD0ryM9Bp9uQ/y6tWDRFLhEHMQGskgVI9w7A=;
 b=DWlV3NBV2AzzhmEcHSKushY+SnJQhcNSTnMfJj5ltG5I2BOipBKKYzVssoRjpWv4bXyhjfyzrqh0rSUs+JfabFsUeuv7wHN2CqeY0fmKtP2JU4LVxtX8SPEeD8ZzzNgVKXlZMNtX7h0WcQajCDHmdSmWtjjzWTLhqk4k/CPuEDDo2yxH6R08LxSGEDPqGflOYscO4arApMhTwIqfACrTU9DxWLxI/XiRM5A/aJGQfdS1cHmwWwt/B3ZlEwM/Ua+YYH73KEhCxNyMhaNUlYK3/G65Pio10D9X2M8IFofaNoTEpX5Mqb4SBmDm3gIFiYc27T2AO3eFMBg6iyYmYtJKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75a+fWIvD0ryM9Bp9uQ/y6tWDRFLhEHMQGskgVI9w7A=;
 b=aNEpzRFgfUAWeZ9Ginyp4fveD/1hzz9Ta+wjy1AgLl9uAQgIaaSelL2ntgDVKuhfQWUolAlPcYZ+ZRlQJ0+HDlPA8NKwfHTKarCa9QU9kb9j1pFwbGdXstiloOijtnQf7bkV0Iz1AhYQOEuTsLXB+MswNlN0+g0Vlc9n6e1ZvWjwCx+6gEZK/Ww00Y4Iy1V3+phaAXHT60cuy50ojn+tDMMWDx2cjJU9txiJXnajvSC3XFBdN/6fHrTMAx9XHjMqha5hdwRHe5EAsHkQqd3qWS6LxP4AxDRBUwtLA2UY1X6icGIAhBCt9c/wZOO4oYw76Ri7k5xXVvDR6PB9CDLJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 17:16:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 17:16:50 +0000
Date:   Mon, 6 Mar 2023 13:16:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 00/12] Revise the hwpt lifetime model
Message-ID: <ZAYgALkSB4/gFiTU@nvidia.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
X-ClientProxiedBy: BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: 926b5e9c-e825-49d1-bd5e-08db1e669284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKAz/9AQCl2+LIMZ14qdVaHjfyZPk7yTGaGfDvrqBu721aWx1jCp6pIuboIZ6Pl2NSjECtwVjurfgXK9psZ3BwKv+Lnrldp+V00E+aOVyY1sBvYrtKzLwSxnY2+41TtiKiPUNrWTD/9ZYyzKbuzpEVbpSiGQ1o3FRIv9SaYK6gZt+nkHJja2f0PAH2p5483PmIho+MO4ah7nr0OCYZ/+FeAngUQn14IfBDWwg9kq7DzR3svfC9t/V97+MO2w/QWTkz8inHv/Tf0ruMwFbmJ7BFX3GEITScrAp1v25FHLduelo5TI4mVMt4t+mfOugg74yFcJSrT5PLStjaoIIKB70UGQMO/t2bba1BzDxnL/CPvVX/F/70zLKOFGQ9K/C9mtzgQTagDZiqpz0jimiP/zZ5BLFXavtUTFDngAGcx86sRkX6as/bW1q6puanPtH48JI67OUXVzfqhf/RqQl+0BXN3v8Dar6BTe2XtGEdaJ5S4uxRpxst7P15s9JhWuA2eWJtJpUiaei+Tb+p/PPFtnU0atXHYMOZIO8AFofo3nTKsxatIs66ZVrfCObLQ7P3biLRIlfAxkZ2pSJPzFg77p5sSwbV0n7nBWrrz3mFr+uQt+vHOJWaLy/EEO0pO9Ng9oV4tgwYMnhNqBKydnd1W7N1hSPJ92FLBXAkIUhbYEL288/BgnZDFKghCQUyJFdVZacpTSvF2xCGyOfrkoFtRLzbbevSODUm+/Yz1ikl4XR28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(2906002)(38100700002)(86362001)(966005)(6486002)(6506007)(186003)(478600001)(36756003)(6512007)(66556008)(66946007)(4326008)(8676002)(54906003)(66476007)(83380400001)(110136005)(2616005)(26005)(5660300002)(8936002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZrUjU9IXDiV3pLbL5MgQasD+kPoTk9NQdrGKBX/oJZXd+euIUunNoknnw9j?=
 =?us-ascii?Q?Sac90HC8JUzyXUUXsYQHMzUilLp9yoV+UYNdT8TzVXi92JUS8Q/zTtaOjDkW?=
 =?us-ascii?Q?oTLIwIBf7cj0ZS9QZ7cNPGaVByUJIwjCCr5BPasIzoPtSDlWzBpeoHw9/liA?=
 =?us-ascii?Q?auxZKBrRrynFil07tcJwzaFK3inV5sj9RHLb0yIbR4Nac0GhS4A9qMfO1R3h?=
 =?us-ascii?Q?Fj1P7IAO/86TOVprzEK3gS7j+ANMyRhZxGYnowBdq0Vocyn76JmjdPX/0ZC6?=
 =?us-ascii?Q?3KYtcJzzdhdZruBNqwUU6H2jfs8WhvYGRtW8UncH1WTko9hzVKUBhhrRKtb2?=
 =?us-ascii?Q?6WKsa/ZeS59am+eMZlt2WfLXoq9/h3gmWF0G1jbgB5d9GHIQUt9/jE1nNGOT?=
 =?us-ascii?Q?1V9aaqzDYyNMhJGTyFhNWGg2cSWUr/Ln+M7i3s/K0cojpVugmbDM6/dn1GBE?=
 =?us-ascii?Q?WqdIj1QICWR976rEREH6GsS/mD8y8SPRYCeINej2S/dEuryL9HojDOk+QEGi?=
 =?us-ascii?Q?okUfrrnvUfPJXpZsQ2FiG93y9aWqSOIdGwxO9I1B9jNqrF3J7+opHaH8NedK?=
 =?us-ascii?Q?TQvVu2MzA/4Qm70aEAAGpFgWvKNmaOxoZNB5NfjgXv/09RTkWdvFXOkTrHxE?=
 =?us-ascii?Q?fD70HQL4zN31slDmiKZcxTfDRXzEhSlvhSRHaeJTWd386zAWbohry997BC/p?=
 =?us-ascii?Q?CO9fYYe3nTwz6coXfg8HLG4bTvJRJEBp1QQFSNcFLAB3iBRizuOYA9qu1qtC?=
 =?us-ascii?Q?4rudlQx+UiY/5AF6NynQLwlzYM6VyexL9mQ3IrYUSXXsRuhjqiBPSQybmPbL?=
 =?us-ascii?Q?cBVxu95g9vlSTTBSXiMwWNgJh4vt978XoLbDFph9zK8vSmwBBYa216ih1cRE?=
 =?us-ascii?Q?9FAUX9AfHVwoFdFTL1usx1PVsglJCdughsWMPTlKAN3Cbn6YmM99z0SIj45s?=
 =?us-ascii?Q?n3Nc5JrMrC+8YNrr+qR9tbtAZJH3SmfDZuJlwUT+DoIYJ7LL8FgqhzZPeU6j?=
 =?us-ascii?Q?zm5TgbZuwAV67ExW+xvAWYzSitAQY3UGYH04C7GGVCX1sjihar7XrkRdJQhm?=
 =?us-ascii?Q?AZtXbEd7GNpAbiffRKvjNINLhLMcgKfGbVmlncnA8myQ1lXWhZ+cDEeLi4sM?=
 =?us-ascii?Q?ISi/c4mJO8hik/RgxivbrySpLoW/0Iem90wseikxRAhFUNO0GycsD7d4c4la?=
 =?us-ascii?Q?Z2m7PAvq4ajP4RQ76KTevTkQdEKIcwf7fxDBE7R0iXdBTwpkR28HLFqwWjm1?=
 =?us-ascii?Q?sYN+o+ONAcE51dpdKy6t7APakTt14hiuFWJCp/a1DDyfubEyIsfGi56IA8HP?=
 =?us-ascii?Q?MmwCSMLODW2u3cPIVk581j+iU2p4v4xrcMHXThfGIJOTbkcr6Pcok4u2fidq?=
 =?us-ascii?Q?9cgestsY9oHqLSlEYBa/liB3BKDbn6A5yFnZNKzBwpql9B7xNN8wS3Fn+7fm?=
 =?us-ascii?Q?nF1+JGfQyHQz55F6zTHXWgmH+30E8tDiS1yoTFHAM8V+Hrjgwv5HvABeh4Gg?=
 =?us-ascii?Q?tDavKypusBJk1RX3cRSIo1d13KHAKODqPf3QzGgI5QovV9cOcXUbfUHYWqBG?=
 =?us-ascii?Q?/OM937jauxFb/mhHqmvBUnHRRD0WWEeThUQCiMY2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926b5e9c-e825-49d1-bd5e-08db1e669284
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:16:50.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGf6Xa8IrFXsTYAIn+bpPoNIXdH2qKBp6h4NDxiMeiqgjqdRFxQlGCJuf6rcGwQ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 01, 2023 at 03:30:17PM -0400, Jason Gunthorpe wrote:
> As discussed here is a small series to address the confusing lifetime
> scheme for the hwpt. This was some leftover from prior rework that was
> never fully cleaned up.
> 
> Make it clear that the ioas and ioas->hwpt_list are associated with the
> hwpt during creation and never changed until it is destroyed. A hwpt with
> a positive reference count is always valid for device attachment.
> 
> This also improves the selftest handling of the mock domains so that we
> can implement more testing for the hwpt model.
> 
> This is a step toward the nesting and replace series.
> 
> I have this on github:
> 
> https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
> 
> v3:
>  - Split patch to just make the hwpt_item handling consistent
>  - Remove two confusing comments
>  - Four new patches to clean up the confusing 'domain_id' in the selftest
> v2: https://lore.kernel.org/r/0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com
>  - Basically completely different
>  - Add a test for HWPT cases by enhancing the mock iommu driver to be more
>    complete
>  - Move the device attachment as well into iommufd_hw_pagetable_alloc()
>    so destroy is more symmetric
> v1: https://lore.kernel.org/r/0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com

Applied to iommufd for-next with the noted comment update

Thanks,
Jason
