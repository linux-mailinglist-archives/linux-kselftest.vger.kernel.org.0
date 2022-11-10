Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9D62458D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 16:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKJPXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 10:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiKJPXy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 10:23:54 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE5C10B56;
        Thu, 10 Nov 2022 07:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNLfAa4gaj8HlcbbPWdD9JJgm52BO9Fvw8ZoDa17dNv/tyfu11xyIvsInfzLenOVSOMoiBTEenRp04HY3EPfqcV2FdgA5C69ZEb7pm3QrfttjYZlCnJmQq2TQR683/fJuoxhPmlxiA2FC851MnXUmKXn9pdPDePdoZaHIJpKYpmvDpa4thUtgJlR22KNKh/laYPNnqQ2PLo/8D5lyvCP4U4XQDRI8ia3nbo/+y25t8xZxGTz7FcN3MXxfdTCLb9mhY4Syksd5CFpuFbOgA0ju0PkdAR9Kb7ndGprTkNhdtP3pkg3bHYKqVHpMTJmrEwG1cAn+0q9j9HXBi6FgCTF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuBrsZUGxatMxpECdUFpjHC3F8LSs86dBo/X3c3Dom4=;
 b=Lbikur7BEeQxisRxW3OUnOYdr0Khg731Fej57KDj5hALPP5B/XMs9RPcAGWVMno9KlTkLvYehGk/+nQStYDahanisW4DJJzPEZ7tO9Z4WHj18+Cy2h5WYLApWejnOnt3hxWpkUJYFF2lFe8MRNy1y+lA7TrIX93VbGg3G96Cc74mujvgU14KwuTmTaMeSAuJcWRNZHbY5V76IxYGAnEv6vS64tvmol44QkwjFFTWPUyu4itpz7WjF/fORhvNzVwwNCVO4ohvZCyhoIOWXy5vrineGHh6l7GpYY5/MLCfcKpe2D3TD1JI0NRa+7IMxoV8HQOTai7zucILEx5kERfqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuBrsZUGxatMxpECdUFpjHC3F8LSs86dBo/X3c3Dom4=;
 b=GV4P5yFXm+Mg0LWVboVyVNXo/evz2nwKs+iOTu7FaVYzKOMCQD7Vdf1WDYETZUPx497naNO1V/1Wimm08y/PgCkscd5LmjxTrZUfCXvxPDkw/RLBYe6otqt6sjCB+2h/d53Ah+smuQ9JnkYMU0fPJq9mTK39XrcZlEMCbFC0lJZMp0jUkMh4ivRAdGqXN7go2yHeFOgvSDePmXT5SlzylKr8ZozrRf4rJDCdQzEWxocyvMYtGHh1N91enO2l8W3z58diiCjrKgR2RrsJFQ+v/GE0EiZfNswxDi61pdHbhX97rLN0W8uXEILngTO6+nNX2IW9IKbQZAHXJymsyFaffw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 15:23:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 15:23:51 +0000
Date:   Thu, 10 Nov 2022 11:23:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y20XhjH96k4x7qdx@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me>
 <87v8nmhnkl.fsf@meer.lwn.net>
 <Y20QotPsxivvV53l@nvidia.com>
 <87r0yahmlg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0yahmlg.fsf@meer.lwn.net>
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 97932dc2-e2b4-4a0a-a7ac-08dac32f9276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d81FpIV7aRbQDOEFI+5KBmaN8gSqkeYE40ln0oIGMfFqA53wryTQP0g0a9XKjCMRvXb2MOsqF4OiygKo9uQ4iTEJn3d2kOnSg0NvrAFHVWHVLvWgvSmzXFKN++zDiEJxToJ/mNtImreMJg+838zpQGkas3WTnzW/sWf1NUS9gW6ASJmew4wdRw9UNPj/kHd6fG8g6XaGb+vr/vLTbV9LEuV+GtGHeAzbCgNkrMYT9X8KO5BamLAuzT+ftA+RV86kzn7pDD7ZX3kAcJ/cEkedTzDcxqIZkWtvNt5/gqCdEmIgRjcmCRFulJFpnEhW6mGvgf/grWoY+NgNCZSBEgN9pR1iWiz8E6Lh4tYhxhlap91Jm/aZoWv3MC7SWczz1DfWvF5FkDdBZhYfcYmq84h6IBc2CAhNkKCcu8bw85pf2LyZX/hxrcRYE3JK0bBzpRablljnnHW9hcfn914YuWY7p3ej6EtVyl6iGfXoLc5+TjSjNh+j9b7imm4Pt4vW8D53kZWQADSGQYsvH//P+xcOuyLv4hbF6fe26hEpSC+LYjaeKi0oU2kupxz/BsSkI0LLe1VWuAEtQo45rzaIXKa9VEXv55K3y6o9gquQBwr3VPTIVQtv5Ybg13RWZsMh/m8tE2HR2HOWOBLVc9Ey3BtRvyScu2o7SVemaaIlTPNCheoxqZ9+JDqgLrD5Jj3X3Yn5rZKbspzoyqhghKz93kCVVYv1uGoqGu3LK5HPXNgnFRrRlYP3XhfP4VabZnaggIEJZk4OY7ywMBjv4UuaMmJZ1JFMHTnDtcAD/XvmS7bhYSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(41300700001)(7406005)(5660300002)(26005)(8676002)(6506007)(6512007)(7416002)(66476007)(66556008)(4326008)(2906002)(54906003)(6916009)(8936002)(6486002)(478600001)(66946007)(966005)(36756003)(86362001)(316002)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tax7Ty9un6AFP6cwrqO4OYbxPLYtYWa/yACkWGYix7KmR2yixPJPJy7wHRKk?=
 =?us-ascii?Q?1ZqXWtHW00mYASfpu4kIkOR0TWY+CS0zYKhosPtll4FaAEPcM0U4af3QAqbX?=
 =?us-ascii?Q?rEwp5ZfggN/8wR1i+sgssOKTqx6resq6I+3oe9KNw0OJE9Mz3gzeX7tNlfP7?=
 =?us-ascii?Q?RPECHD8LhDrDktixFJzy2IIuQMuYx6+/pd7cXhvc/RRNXQ6DzAx/qvlwr77g?=
 =?us-ascii?Q?7bvB9mbWZd00754fiLHq5UqzQw6+XDTFtouQy+2xfihrkd5MRVprwWoBE6Er?=
 =?us-ascii?Q?M+3FQWOv2FCI9sRYhbSsSCgPjgfwvAZQiN4PYSYQ9gtfDIvP6GDUrtDlo14Q?=
 =?us-ascii?Q?ywQipLbsX9YjVsyyTAUlaJEauDLI72PR2jyI9lWUeL48yNb3n5hdNtsHsEEb?=
 =?us-ascii?Q?4J9ROzRkNENi7ydTu/LrhYgUfLhO2hXTpGQLJq0so6laBMEr1g3cEAmzHp/n?=
 =?us-ascii?Q?OTdt6+RZ7+SGQf2xDFVZF6+A/7pUMzDrU2vV9p2y4T/Pgkw+m03LWv8KznoW?=
 =?us-ascii?Q?4t3ZuAki8YbXKLfe1jWTZNJeY93GEug1jFSXSYfA5LfnyjtVmPNSAm9DpnD7?=
 =?us-ascii?Q?dvL4F0bs1Y6JAtQevu1A1BESxihkIFa62pHrqRSJLXMrVSVV8tW4OjcIZn0r?=
 =?us-ascii?Q?N4M+b5ASPthxY3Lt0Cbw7XJi7lc3laF15DycdkSlAi4WRE5y+lQbnNeNg7OZ?=
 =?us-ascii?Q?MHXVHuDnRrsmtkCqSkdNlvmgkRxIeWPr7Y2rsn2/BIpwBz5wiKy2AWvYDfol?=
 =?us-ascii?Q?y8aULTKDZBzYKPrZHeUx8R6gy0oaVdnAcRG/bxVECJ+KmFEHiDPU1Jm4Qool?=
 =?us-ascii?Q?bjDKGnOpnbUZQwlSET7GbCb8RFggY72xnZWMbkC15p222M1/FdykhNYtWLHZ?=
 =?us-ascii?Q?gIkrv5xh1iHPJt+DSlB8yombH8y6JBrRYRhGgZOFi7AIk1VDaatiQl3ViRdK?=
 =?us-ascii?Q?3q+jRdvQ9zIHzcJL4wcX2xL/wxDlHO683AqjRoOO3sVCUUmAdQ5YipQlgdjE?=
 =?us-ascii?Q?KOJc44njh+aDXmbx70YIHXWC067VbugKNUbr8WUwBaezM5x3IzRedNjILI+H?=
 =?us-ascii?Q?adTY7y/GXjkCoZmXaxmeKGZwtNCPWsDccFXZn2SsRUlLg+3ELxXP3T/m6/ht?=
 =?us-ascii?Q?GJx1G8ybGgVYcRnQkNAqWJVVCV59G0cWKNNIMDgLiHHnCk7lN0FtYbKNMgm9?=
 =?us-ascii?Q?OZFjQ4yMudLfbOmUGUgB8+CCZRvtLc/nq4Vv61C5kc36l3DrmV9YUl5pUiK6?=
 =?us-ascii?Q?DRHa876jlNeDxOz/+P0/BFWSEnme6laJsW2ta16Tdu5jpfJTVm+vuj5QDm6A?=
 =?us-ascii?Q?glZJXqRVQk3huRBceRIdYq52m5R4gE/Rq0ldpP2ssvmwn2Dfr1clrFWsZlsn?=
 =?us-ascii?Q?tdni9SXLOlXBiENeW64FXhHPHwz5pjt/21+atuO/Ou3FQTIeDS53CBYVRn8p?=
 =?us-ascii?Q?UptZi6cFb9FIO2MG8lcMgbOzHpW0s/iBc6t3YyQib3YNEkzs3vupMrj7qYfe?=
 =?us-ascii?Q?1xl40M2GQSIRGpLd3DbQ42GbjBBoCdFfEqHyXgSYqa86DmdFM7AwXdHOaiBJ?=
 =?us-ascii?Q?8KC3yb1q1lYX59Cpx9k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97932dc2-e2b4-4a0a-a7ac-08dac32f9276
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:23:51.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRn2n6r7o2tsaFZu9N/nYUvtgqDhhXOgAI7N5yc6F7/bVh6csGnGTZODZ5qGwRc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 10, 2022 at 08:10:19AM -0700, Jonathan Corbet wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Thu, Nov 10, 2022 at 07:49:14AM -0700, Jonathan Corbet wrote:
> >
> >> The *real* problem, methinks, is that the directives are added in patch 4
> >> of the series, but the documentation doesn't show up until later.  So
> >> the real fix would be to simply move this patch down.  Or just not worry
> >> about it, since it all works out in the end and nobody will be bisecting
> >> a docs build.
> >
> > That is half the problem, the other is this:
> >
> > https://lore.kernel.org/r/0-v1-c80e152ce63b+12-kdoc_export_ns_jgg@nvidia.com
> >
> > Since even after the whole series the EXPORT_NS functions don't parse
> > properly. I'm going to put this patch before the doc patch and ignore
> > the bisection problem.
> >
> > I'd like someone to say they are happy with the perl :)
> 
> I'm not happy with *any* perl! :)
> 
> I've been sitting on that patch because I was under the impression
> another version was coming - was that wrong?

I can resend it with the single regex if that is the preference - it
is not quite as exacting as the first version. I have to test it is
all.

Jason
