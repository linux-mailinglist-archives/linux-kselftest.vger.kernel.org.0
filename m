Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F688766D36
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjG1M2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 08:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjG1M2N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 08:28:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794B19A7;
        Fri, 28 Jul 2023 05:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1O7KrLJMjNnUTJnjmDZV+Dxw7KdIvwzHYxnMY5ysoun5GaQJ8/1mySLIBBdkyBQYsyd8R9LFKtWXY3QL0NfjEBoGX0Hlv2tLQJfIgnsOY2JXmGONdX02RaqN/wMGhZQf3iR2yE3gfCEdAcGiI7Tuy5DwnNnNOSFMvRo9TM8/Cmx0ezDUgdXZ8/pO1s7wiSMVfZU2GRuQQl+HgmtGKCwbbce+t9MYvtew7axSboaz8Zr3OSpIzi+NP900k7cGAgdMpb9O8hk0t4h+nZo+V4lq/Wd1vN5MOromtJgbQK/I36erIPbOZ8nDAIY+u+H9q8fO6s7ZyDxETeXyhhkcfq19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2iI95q9esFG6fWPG+0R8tRmmufZhLpUn8+Hng1Rjic=;
 b=CchdvXBLT65jGhj9atu5ohe2TaBj/myC3j7nxhvQkTq9TmH6KJ1mGeKf3S+Z6rMi407O4OfiqWz/UG+svDS/m3UYxGsc3Ev04OtiO68N6rco6BFhftnsshsuvPkI2BRGxS4VdXohqhZbEO28f6EzKDudM5qDvxSRIwYV/KJ87OhsvFmuu139AXbwICpXKoNeusvmMBvnrz5YtbJCShUDk5T8vfOORBhfCwWseravMOmv3IAAdA/QVyHyNaQKRY8R+BJ4W+ot+qGn4OBpMWdF1noLUOAeXZyl22jq7V+Drkrh4yIBZY+TDEqkRoGvzWYantye74HuD9HnijpovqVy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2iI95q9esFG6fWPG+0R8tRmmufZhLpUn8+Hng1Rjic=;
 b=I9Zcx25VjhWdCkLOjDv8BHbtm6WD4nEFgPWlWPT/Wwf2pUl5a6aQEH76yhYdS6rQlsPcGRk7jtUVXcXSzIh93VMo902AjzZLc+klLC4ppZBNVicY8YaCx6NpFWc/Z/88e/r+EFYCqI/a/tZeephc40+kx4cfTjww4VquFsvLlVVrDZltFDl+M4A6Rz+J5o4QsTerceQYWnZar/ZMpQnQoDI7ExQJzxUYZ521zKosPDwCtIlsUWSDlzUnsJV4BvsW1gVoDqtkxMzg6zbbqizaSekFEipFD0e5dezLG9g+uqNZWp+5cu4eox7ykwvlj7LTYlhs7k0UP3M+Lw9ji6KhSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:28:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 12:28:06 +0000
Date:   Fri, 28 Jul 2023 09:28:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMO0U/agT3uj8J7A@nvidia.com>
References: <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
 <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
 <ZMJc9elDILpHaKP6@nvidia.com>
 <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
 <BN9PR11MB527691E9B421682C7B88AFD68C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMNHarPX7yA+VTdT@Asurada-Nvidia>
 <BN9PR11MB52764347180F8166910819FB8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764347180F8166910819FB8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f8f2a2-cd25-48f4-727f-08db8f6618b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: polwVwCx1IMtvBBdgcQwSU2yU5HXwbGI7txUyc443SiJfOx8D6O7t+L51Ob5hx+H6trcroTLzn6p/2FXsVOwjhWDq9HxBp5CDyDzA8rPW4fQlq6ScFMQe1FeeN7C3EwK00N9SJgx0hwR5zYS4Je+J4MKxRemdD3pp+44wtUJCGfKu5YSDf6gM6O1p8QnWt5SL3xUQoqpf7yznC7h0G0V/L8bMXCgeWcLX2e/kdYLxRIXPPzGdBg4QjRjYw+/NleKb/QaW6FqlIlsb1ijd0TOvUG3nz1kSCrEM0OZZ+E2PLEJmQa+F5tI8Bcw71rId+jnaY56Qj9J3iEda9205h4ZymfLX1gSZMZbdUjxMwUSZ1EFQ3eUN353rdqcdIoFoTBj0SXlIj9xvYhcPou1L4y2jC0jy6XjzIFOXKhqdrZnPi2xKB6xL+Ak9JS54G/ESL3zyc3dmIEAX+U/+FAYmtxgFeodNkP8JJLEVY4MlhaAUdUqPsMATOjLyry/o9ob+P8XsYifC3kl79xjwM4GA85/Fx4QmZd+NPzN674b01t9BbyZ5WvwXwcSh/6yxcThkvwt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(316002)(8676002)(41300700001)(66476007)(8936002)(6506007)(26005)(66946007)(54906003)(6916009)(4326008)(478600001)(6512007)(66556008)(6666004)(6486002)(38100700002)(36756003)(4744005)(2616005)(2906002)(83380400001)(86362001)(186003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPlZUK9JbwQcLouk31Y1GQRKx3XYNBSrETd51qoDVYYIWDBJxb8aikAApZYc?=
 =?us-ascii?Q?oFAKV1aZMUn8oPSzpoOj/ps5Xq6KHgDhAsDY9ANBy3DGqA3HhhvZWQHl6mXy?=
 =?us-ascii?Q?ROXGVu0VZ0jJzBSvyZMKRi4KDgGk1lW1/f37krg8sbhm6zZVhq5mKF7mz/qI?=
 =?us-ascii?Q?WWeQqDhtVy5z/cRubm70p7t2UbGF97AVK8dlMzHNCJFjKSUQ5c8voekhgXuv?=
 =?us-ascii?Q?yjhw89IKlG0DTTdQBmkbcA/KNiryHSI92elMMHsuwT/8+t3sGr9TX9tPTmaR?=
 =?us-ascii?Q?BTU175+qao7QoSpVpGTb0GNqScAydbYaK7MIsyyopgLUwa9N4HtYWrBNXzzS?=
 =?us-ascii?Q?DfaRsJAjEKMw0EGbBOCc1Az6Hwee/tCSnCQicoeIteBzUyunThyRFdQ2PXLO?=
 =?us-ascii?Q?DE20Ji+WYxM6UfMjtjq2sqmYOTuMVMKXnFZng3RI/8j952nLBWZAgzL3DsYv?=
 =?us-ascii?Q?f/0CElRUuZIeErZG3XNwCB131WZIk4DQ/rgj9OahIW1vmbS4hOnl0bDLyKyM?=
 =?us-ascii?Q?MYc82BwcIvfOwFz3GvuSXCK2K5STbA9onv+dNbd+SQJD7/rw5lpTFVSwvSZm?=
 =?us-ascii?Q?rc3XKxh9Jo8n/XVNYbuthhGzHj8y5aOpTJEspskicts7UAiaIwk0ROpj1LFr?=
 =?us-ascii?Q?Nh1haw35AnRKo3+Fpq/UbyE9UlOSRPWWn9QtBnmlIJgCqdplXbHhUaZiSj8h?=
 =?us-ascii?Q?W6g5mErhFmuMN6Y273+eIetjwfwsSLyy+z3gyXSROmCJGroTi9ms3ju1B6Gg?=
 =?us-ascii?Q?b0A9UO90kRXpXI6HuRnwZi+YprKk080vJ7Bvj2Ua/gJekwUgwTCOIk2eVVGf?=
 =?us-ascii?Q?JDmAFVx/Ilb6PyjKUUTmIeMLGRcr3Bnykko/IFrwedER8Mk8pPIwA8jHymyg?=
 =?us-ascii?Q?KJV8iNAJLgLPjAIYHbJiBhOe3tl/IZBwuinwT1C9pczCi/ux3TgMYXdphTvU?=
 =?us-ascii?Q?62fSSJFkLHdXQ2SyXaG1OPycVmb4Wtx+3OBOLWrxD7nx1xZ8f66aNwjlndg2?=
 =?us-ascii?Q?9B+kuDIMLxIzefS3YHAGVqItg9P0Nm62Z8sxiv8w/1KQp669Y1NBsrZxO9hl?=
 =?us-ascii?Q?WrqNlWoGThlKvgPFnCvSgI0Fm8mTi6DBGaqrt267mylhQZ3F77u/6Q/IGgyP?=
 =?us-ascii?Q?P/WEtaITGQb4b0rPr5h2kf0H+0v5zWzgJVHf78bNC3eJSOMKSDYlBCN+q1Ll?=
 =?us-ascii?Q?Eyz2rZ813FRNcSsO3Ozk8hUtQqKb5KehR9Yi1bqLim7aNtrXmC+jjDNHYgST?=
 =?us-ascii?Q?Unm2aBHLazwMBcwW2VrcAcgfIavXIfg4TV1zXzQ0ugX2OT6KFW21UHwgCpHp?=
 =?us-ascii?Q?BeOy6vZxjIiSeCKX/C+jtW1UVY8pBpRbU3BHlk/03r+LjS+c9NQTKUmLjYLw?=
 =?us-ascii?Q?TZUMzcD8LftK8dkQon9oguYZAuDskB1WIAEE0vVfFZexFm8nGxxyzr7/1/Es?=
 =?us-ascii?Q?qULLkLckhVPAEiqOcVFWiPv1lvoHY8pVWSszKt3e0a6AFheutIaJZeehIapk?=
 =?us-ascii?Q?QfexIQrO+uBGHCzTfasHoFk/jxexjrEI7H2JQuN8wYsiEQ53UdVCqAXmKR7S?=
 =?us-ascii?Q?ao8hU99S91PINygGCbam1/sddIla+LnKEP2PuV0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f8f2a2-cd25-48f4-727f-08db8f6618b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:28:06.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWrQIG+BX+QxT3ITkWxXMNzBivLhzenGOwWG2YyNNvCgYo4A2jUKRXiYg6O1LD4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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

On Fri, Jul 28, 2023 at 06:20:56AM +0000, Tian, Kevin wrote:

> But this does imply inconsistent behavior between success and failure.
> Not sure whether it's worth a fix e.g. introducing another notifier for
> mdev drivers to re-pin...

After unmap drivers should re-establish their DMA mappings when they
are next required. It is a mdev driver bug if they don't do this..

Jason
