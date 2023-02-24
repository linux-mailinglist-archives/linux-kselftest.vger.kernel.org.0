Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033C6A214E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBXSTH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 13:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBXSTH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 13:19:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8216882
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 10:19:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN4ZNAUDT81K8X14BKnZFeY57yOuyNyUb+xIh796EZppShOojMBUYpR3sB6e4eXDvj3ww6sCUmWgPdvB/ou0RKH+mibgBLXs6cguQ9ima42bxorApdA5LSRfgiY7xxdyIRi+GNTDcHx+mVuZHThY3s0ZrAMzwCJ9adEIAHaaWHyChs1J/XrsdK0mxn7g6ZjL5eF7TXXVArlbntC1iixurd7bDVYBW+4TuR6rh6Aioa02/ulPOsXt8xjRxQKCdoWu2+5LCMjJn+iaNOgJ3CxFvDXtQYrZtO6UXu0YYD8vlZaosiSJHBF3mfEQnDgcSLvbdcPSHoVnj544pASB0eJ5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdUMqpTABbYgGAW6Y6VerrFG9vvhA65vtyu/FZ2bAwg=;
 b=ZT/N4vaYVF5o+t5bcyCmvM3+VEQ6wxZmngAeVuuY2vWFkrUHc0TebRzGt7Ei+cc1qhfyUb2W61BxSEAc4v0za3sVzQLRIQ61IcNn5hEpKbgGMAfTD6NJIijkTMChSRSwuEUT+UzL30px5+JYDr8mH3E/Cn5Qw4/LZBJKhSBobictbjjwiMdbTwzSapooQNAybS6N12xA9c7WNPjMyWdMFKI8gfeqelE49CNffGCivkjf6WH370NwQf9sJSQZyAvFALRh8ciZrRKa5VvKF7RXkR0fgWrPai523ptIbDqBbJjKXWCBuSsWzS7mNeMYdN2a/pqlgE7ewr+1KhT6sSZ+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdUMqpTABbYgGAW6Y6VerrFG9vvhA65vtyu/FZ2bAwg=;
 b=bbWA1MwMY2ybg9/C6gUmb181n6BhvT0iL6ORBu4cNUIxjgSyVZrWQ1J2VNjwtWdz9IfI5ys+hf0rZro08D4JpvtCseSABC9R514InLAVjPLsK8ggSWnlFrRD7bT0uWN2gLvhfCiPw8Yk/nOV4UzPyNy95un9R/IcgWkmHx7MA0GZL8s5t0RjBIYWVL+/6LG0EH862ZnApV3AR3iwvrRlg9nAdysz/yOXp54N2fnAzDcSAJ+ldwdi3U+Lk6LGAf0wq0cwBpPVrVEGR9CaxYqDpyP49hPKO4EJiros5EB1CvZLhi9RIBEoEOI3gjCWvt0r3EcpK+hChu6YuK6i37Lmzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 18:19:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 18:19:01 +0000
Date:   Fri, 24 Feb 2023 14:19:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 7/7] iommufd/selftest: Add a selftest for
 iommufd_device_attach() with a hwpt argument
Message-ID: <Y/j/lKB498EyB+oW@nvidia.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <7-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB5276995EF79AE2557ADE27BD8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276995EF79AE2557ADE27BD8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8da737-4073-4e3e-dbc6-08db16939ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /doIdMNNaxDl9rjgUia5txbDcL8wLJSZUjrA/HqvBdWZxAYDkTE9uNcYvuKmKtsEbkci/ClhkpVHkCEnygqvgOo16ziw95LjSIuXacs/tf6aPt8pNux6Em20/c+ONvMh9Tzzi77cI7dFImn/JT7GyWMj8eidNi6mX2RuyyJ/bMWkA7vNbsW0VJPL5C5/JR+ORzNw0jv2TY5Xwqd2pxPZsftQOBMdo3Wdv8MtZDFNZrmGerHgJSxcJp8MWPb//w9qxGjyPTRWDC+sPqKtk5rX9X8Vf6kl9mhi22jgqxPLeA59rDlAf0Jo9PyExlZKG6nyoau3+5zZwVbj4fMwpZSF+5ZYcN+cw8BDSurMRWKWI3DRinE10PqHT9A4ZDoZjSGnY4OSpLjHvXgo1TYojyTknmPEUJRi6JFAzWMSxQGPRTXYhRlmbJCfEdZ8etTdgQSn4EAVbh+xqC5tiM4LcrP5+ti/GXIDNHRJw0U6lV5ddJ0IwBC5fanMyINL5aVPABjJH5cycd4DrSxMaI+sPVhBgSNUNqT7m/2l1vfj1bUoAgpaRWsp/4yZ45nwZkZpK4eR02fNiHmMc1DQuf9n/eZduauQFT/JGIPy5KL8K7+kza4wUWQldwNrAyDBYBl3nVEWeFpwy3a2ndGKeHiNZWbboA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199018)(38100700002)(83380400001)(36756003)(86362001)(2906002)(8936002)(41300700001)(5660300002)(26005)(6512007)(186003)(6506007)(54906003)(2616005)(6916009)(4326008)(8676002)(316002)(66476007)(66946007)(6486002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9X1xXmQrzgIn27tivwbf4hr6beNZR1Wh5H2zdko3SKk3KAiIMlVHgVLidW62?=
 =?us-ascii?Q?zUCj8Rf2RNEb9D/NC9L5X5JgQrVfDjyujw4mGLOCQPa8cRO0pXiN4TyZgPKX?=
 =?us-ascii?Q?DH5nR0GQSsssGHjq/FJ2l0+JKt8soxo++Cl7J+Cg0ddkShy6SpoCycMzzEpP?=
 =?us-ascii?Q?rp02922xtvzzi9wYyiJBjvuhx0krgxqd98PkXxyFOtRBTjIh7yC3xRl9E8Vq?=
 =?us-ascii?Q?MIVc2TLBPL0nUBmdFGztGAYgv02VHae/Hjv4zOtlwfLYum4yUlMdM81sQjd1?=
 =?us-ascii?Q?DcS5bynDTJL25YAuhopx3hAkpyqrVzsQWlVQ345gsrwbWAPWvJUgbtXbNvtk?=
 =?us-ascii?Q?VosiGq400ZVWBmCgL8lnD/CQ+zH6xzNXmSTylpRd/Oc8Hs65xjgSNqHd/TuA?=
 =?us-ascii?Q?TfarsGV1coBj/HrNavovXCVqREJRgvWOys5WzkcuLcxy2S73tXolYI8p7US5?=
 =?us-ascii?Q?ZbCCLId9uyV/HDOu02dyy0+0f5nFCaN0jwgJJEtdylUzQL1vlgbxn6jLlxIi?=
 =?us-ascii?Q?sJ//NcaEhaZTLKhvyDZIoVrKsoHUbPS0vkuI7BriquApwKnnMuacFirECiQs?=
 =?us-ascii?Q?QhfNWN2+HQ3FEBpRJ4pM3UDG5cABMBq/8CqTHl5TmJDcdXavu+hwImmbWg5Z?=
 =?us-ascii?Q?0XEXgCj+O7VlN7j5MR/yaxKT1TcAEFOrSng/p2T/H47qf9R7fxDK10PZu1gv?=
 =?us-ascii?Q?/XCW1B68ab94MB5GKSXzZE9vaaLI7g8XJzUm/FaSLJNBLPii6IP47CR3TKVn?=
 =?us-ascii?Q?reImv7xFNIOeiR+MzjrhFZ9YKhXNNcEg3NqD2Uo8fEAPavRxboCwWqeOEgVD?=
 =?us-ascii?Q?fJq2MDyI3EmPqXNQerznrPP5+jQogSkpeu7vayfOohsZvxE/Js0+F2Njc8rO?=
 =?us-ascii?Q?dehKC2MsFraOkvJE7KUKm29mh8EZleCgaHAjRrQBRt10DO6t3aea+vTV3Bv6?=
 =?us-ascii?Q?deDwPym0e6C/t3B8yadR6owrREUIKk5Fg9HoQzlWDmW7p/I+7LO9CmDaLKN2?=
 =?us-ascii?Q?yT4F3zgQXw7+6Oqh1UYQa1h+SJqFCF0JjLbSHvFRvFvdkPQafGSqFrDoIHnU?=
 =?us-ascii?Q?jyf93q5BU/Tn5ELcxIaiKmc8gHAEE5576IQa7CWENCZXt8AnVgrvuGXhoFov?=
 =?us-ascii?Q?j722L6jd+Pw4nvR+xTL7MGzABtyoZJm2PxqppIZ68ckAsf2az1CPPeHE6XIR?=
 =?us-ascii?Q?FpEY3sMgDp4ODXSS6U7KlvN7BroK44qiWvXv69PEdYF5/eb6zXxJO+aedBh7?=
 =?us-ascii?Q?vqLcWljL7ugBhvpnOk8kVOZ7kPpwg1pac4TS7Sfgcd/EIlLs8EiLFIobHhgD?=
 =?us-ascii?Q?lpP1M+QNRxKlAzMrmroh1RABGDsGI1hEue30NgKjYNA1KTZcw2J9HvzVWTQi?=
 =?us-ascii?Q?jbQB3yQcmqQyXzsSmSAsKGginVJqGdKWAAlTiSYYnLenWeoBv7mdUc9m9pfq?=
 =?us-ascii?Q?fGVDqNgzbYssfLXgsuLMSv0SWq+viCt5M7GK9QGATks4j23YZpM36m5HYreB?=
 =?us-ascii?Q?GuN9dU5H6icaIRO8n8+T403qNqFHFOpIs9kqowgrMKrRkiVdzSMgK5+P/UDD?=
 =?us-ascii?Q?DVYkfPoNGNNAfmzKmsiVNdKCer6JINNaG45KysfQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8da737-4073-4e3e-dbc6-08db16939ab9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 18:19:01.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys/v3PiBur/vJppXo59krb1SvBHbt3FF5bHUn+/44++2bkzlElFQwDR7WAw8NLTU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023 at 07:02:06AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, February 23, 2023 5:03 AM
> > 
> > This can now be covered since we have a full struct device.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  tools/testing/selftests/iommu/iommufd.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/iommu/iommufd.c
> > b/tools/testing/selftests/iommu/iommufd.c
> > index 0c4bbd4079a425..69cb79d6a0711d 100644
> > --- a/tools/testing/selftests/iommu/iommufd.c
> > +++ b/tools/testing/selftests/iommu/iommufd.c
> > @@ -187,6 +187,7 @@ FIXTURE(iommufd_ioas)
> >  	int fd;
> >  	uint32_t ioas_id;
> >  	uint32_t domain_id;
> > +	uint32_t hwpt_id;
> >  	uint64_t base_iova;
> >  };
> > 
> > @@ -212,7 +213,7 @@ FIXTURE_SETUP(iommufd_ioas)
> >  	}
> > 
> >  	for (i = 0; i != variant->mock_domains; i++) {
> > -		test_cmd_mock_domain(self->ioas_id, NULL, &self-
> > >domain_id);
> > +		test_cmd_mock_domain(self->ioas_id, &self->domain_id,
> > &self->hwpt_id);
> 
> I didn't get how this works. self->domain_id now means device_id but
> other references still take it as a domain, e.g.

The names are just wrong, Nicolin pointed this out and I had a later
patch to fix it, but lets move it earlier to this series.

Thanks,
Jason
