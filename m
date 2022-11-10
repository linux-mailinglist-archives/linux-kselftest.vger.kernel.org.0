Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD26245EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 16:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKJPc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 10:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiKJPbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 10:31:37 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00B26C4;
        Thu, 10 Nov 2022 07:29:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZknmDsKZkil1Qvw8M9I6xxsA0bUkwsGEVw+UO4FEEhwiHbb59Jxirx4hj/vjrUvRw4SH3xTbfIceDPra2PJH1P6MEXE6Jx4cLgTWMoI/k1r8+ERh19ENrF1uXHjyW8gX3jBFTJfaFNzmsEK7Z/RHp9v4PiJ6lNI7znU5q8ahaCclqCWKn8GUp55zh5ndtLgZ4Y3hJM/ZHDnpUyxLyCyPrb7VgbnBUQSVndxj6108YyAbDDpf2E/7yt598zbpPJ2ip+uuNx1ZGwnTaWdRgB6sf11Qs7evHb/IL/Qx7BJb5VMa1V7NPZ1bt/877azKYhLKXf2miz+8KNADq4e5mBaPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFRiN+uBGp2VfcvNsRnXzV867pzsloeyfrZoE463+Io=;
 b=RLScQ9Cg1pyZajNKOxPT/IHhYmF1cGc2mFySJt5EJW4tql4DiNElrsOGXHhstFb8ToewiLpy3gS3UfurCsgPOl54qfzLZBODBtNMIJjRnV4kgvE4IDT3SajdEoV+Xoj4mxUWV/yKUCw5tFrZxkXjlw0kt629iqZBjn74AcWomr83WI36fAHGu6oW8hBbJspMzLNLxHPOMAGwnh9aKtWruwoyWBIQ0jvmQic2fRhqW9cako8Un96XEgfNiGq+WGiRrah7E0QLafd5578s0kLxPhg2yYBFzeGHzzDLjxfTKYX0blsvPSq/qKE1bpIMmzdhhCT/aA8VqqlEWinuvXACug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFRiN+uBGp2VfcvNsRnXzV867pzsloeyfrZoE463+Io=;
 b=RRKeNDkx5qcJdGSTtsXee0GRrWtU1Za0z2JCNsDcWsloo6hm2uGVev6YNU1pe7fQZvddPd4BJsg40bpIacEhvQbl8m4qK81tRR7EFS9RjqhsaU27HjzPNMBnq3S56jLIr0u8VXaiHgDx7f0VBxAhaKF70G3csa2zng6QleeNGo97yWT468/uc9eCO1bXiDSpldrWOZb8U0KA5b477kl8RgtYBrF3AiDxgJdLW4EDRaXXPN0vZ0FJ1rnioZ2vyppD9sTcDbQU1UvMoVrsaoOA0JIe9nYTWm9IGfJKXZnS4DYuiEM9P9LXdJVWfnG212qHS8zuictzk1zgUaCCTaYAJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 15:29:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 15:29:57 +0000
Date:   Thu, 10 Nov 2022 11:29:56 -0400
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
Message-ID: <Y20Y9Jlp3vG8x27a@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me>
 <87v8nmhnkl.fsf@meer.lwn.net>
 <Y20QotPsxivvV53l@nvidia.com>
 <87r0yahmlg.fsf@meer.lwn.net>
 <Y20XhjH96k4x7qdx@nvidia.com>
 <87mt8yhlqr.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt8yhlqr.fsf@meer.lwn.net>
X-ClientProxiedBy: MN2PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:160::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fed99f-6e69-4551-5e36-08dac3306cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V4ypmlnpLFUtfssd60T6OuwQqnS7s/EKzUYPreZem4A/8V1s06pPWUjKDrAW162aCABXZwTO3/noAmb/+X1B6Na8VfPF2eLP832ihicn6/37MMx7mBoH+Z1ug6rjcJAdn+0RT2Rw2KRpjdT2s/FcWBem3VTZWxulsFu6yLj1Bqz2pp2K6wU2by0vi7kg4KZu1aOKGqm3ZjJdvpxTSBspxbFZovEviD0nqJB5DMhWwkSFAux8t5QmtaeXKmQ71m5mp4wVqQZYJg8VXVD34slvm8KGrZLHxwZm5ZyC8gnNrlq1uWNOUnl7mjwmxv1jOw+7I1hTtYhZ5aWFm1QFaTJl8N+VnE+pLquEMte58gGfqniYXyz8vU8OZT2kFh8Y/LjKQOc3f4JZS591aTjRJjEWx/LAZviyNLIFPgRJ6nt6njix9WU8rtFebM11ioyxSAI1AKbt8SnjvpdNdgYne2Jk8CSDrNLhtDXVmX9CHxpKP5e1oimyqXxevNA0XqM2xUWRrGAChy7Pen1PyzLK781Hb2w1zykER9Y4n0EuZWhfrqMmBObOn2cFUw52cu3Do4J3fg1t+E6rwMcH2PP22wQSIbN02mI5OvpHZhF8jcwVxjuDTIEL9BxxcjgIZt1HRoTleMJ3MiuCcSFSuwVkGVpUmSh6bay6W7q4tAnnQShZLkAEhmx9zaycwv8mwNOVHKMQuUoZwabM5DxAATRqM1Kj8xZENJKiU5LYhIwWVppLgQxgKXAumh19yQPZR7W7hfRV6QN0uXvDf0h9bVz863zFtgHcaNdWOWrFMJhQ/sMg30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(478600001)(66899015)(38100700002)(6486002)(966005)(2616005)(54906003)(316002)(6916009)(4326008)(6506007)(8936002)(36756003)(86362001)(66476007)(6512007)(26005)(66556008)(8676002)(66946007)(41300700001)(7416002)(7406005)(2906002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYbtHQyN/jwSqXwdWxl5Wy+gnuvCLd2wp7vwVcC46+gFnQlkCJk0AtRwJsEZ?=
 =?us-ascii?Q?nGmL4/jS469Qh7A3G88/3fAN9TFiN1H8SIEsGxysrnQse/EdXKd92gCfyBoF?=
 =?us-ascii?Q?l7tfkyelI7TwsQOmeaf347FpIpohEez7TX7qMdBW9SVMO69fIX9XhTdlNFCr?=
 =?us-ascii?Q?Bw6UhB7IzyfkDanPMNtzDnVm/9PnuB2CE9HsFhdgEMHfm0nYO7FmI/QWuefc?=
 =?us-ascii?Q?3BJjwcERv7MOchs1aGjC1oGbLpzU07W0yCI1SiVySt8SLZIDP2FoEpwiGcdL?=
 =?us-ascii?Q?9GJ0YYEH0Cr2WMQDBCB2GxDxfshoaVsA/cwmA5IUOdf9oj3BLZ7vK3aC1yuy?=
 =?us-ascii?Q?SZITRXgs/dmAshwsXkPAhVTy90/+zrWPLo6drToSegaQtYUxRz9Ax1yC+n/U?=
 =?us-ascii?Q?d59yWuxx8E0DEWGWIKx2OjcXmvJzrFvuTQ62PYoqXjykvYdKUIh9LPmOMeWv?=
 =?us-ascii?Q?lzfR9W3MK0phklwQ77C3d4yzJOCHFGAPZjscbgPICkMOpkZso5PAygevcCSu?=
 =?us-ascii?Q?nTRnAvx4SMHLWDaycLvhuorHdVBOxdOtgE0IiV3ChJ2mkFh11zAF80nwmZYk?=
 =?us-ascii?Q?wKQ/VSuacVFP1K2+3ViSDSPjshcErF76MWnotID8Hn6YBL7Dn/emyxn3YuRT?=
 =?us-ascii?Q?nkkUXHeMpjc4aWdC8YoA+K2kPO8jF6m9uI4F6GpqqJaeiiXOpRQGZ4FGB8/Z?=
 =?us-ascii?Q?od0Cg1ia2Ea6UOh9UkwpRAJTIA+z/Ejk7MdMLyWOI9GbeSb9tpFDugLmEST7?=
 =?us-ascii?Q?kP9SGBWtUmnJH8/fyNuJ+QFacfsI2ZJ+K7ApCDqWg3sjVgOh0mhqSlKJ8Znu?=
 =?us-ascii?Q?O6uxy8LLCOIVYqRoQF0v3CdDvmC3poWuK0TC7ULGLgFJ8oF2IPjWaX4g00e4?=
 =?us-ascii?Q?o0t3M2XTtJSi1m8kpzdrMikysU9Tf/tFY5xb7vQAwllzTHd4m2IRIAEKoIca?=
 =?us-ascii?Q?OzOxMDgtois+vTtjNQVYQa/q+JBBp2H/kUT0EOS18eG/0FqxgydT8pZZywG8?=
 =?us-ascii?Q?vgAv5tmgjKhqZuOl6IJItBBEpKXSrf43Dat97USmqNeHa+OhFZNcq8a//6YF?=
 =?us-ascii?Q?PKX82boWLOUkaMHJzo5OjfWObyVnkc3anFeT54C+zqIENkceatXFdXt/NMgx?=
 =?us-ascii?Q?9JzpEUlyTmediLqxzAOJO3Q3bALHlQBDMRKlDwbsEXgLBp+OYaTuH2LGfBvM?=
 =?us-ascii?Q?n0LKspcaj0zBg+iMsuoREIdOb1f5VFlcSUvm/1Y9KdQFXIvxT23dtS7XIt+1?=
 =?us-ascii?Q?g9xa4qe995MIy6qVWo8dohn+snbHOMijI20Rpu+lZPu1sfJ2pS8XeI5esafH?=
 =?us-ascii?Q?8XVInLqXmT0nYRDE1Cmb6TUjHZJo0B3GlmzQbyQxrKHcjxC3TsaPwYjyx2Kr?=
 =?us-ascii?Q?SleMHlMJAJZIC7r+UBYf1tTo8QUTEpOarATesMyss0CGFQeSwTLV/7H+jkLb?=
 =?us-ascii?Q?36RrrtT26P7b5fqpyhCvAYr/YFyFHxbcA8TB64ommfY8uWWqRtpPe1KRRVy7?=
 =?us-ascii?Q?xfhHtcb3/ib4CSQiVGNii+FotiQuXeJfWQf5mNxg1tlEKU3avk2NgFqPgydq?=
 =?us-ascii?Q?iD4dhy2U6DH1eJck3Yc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fed99f-6e69-4551-5e36-08dac3306cbc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:29:57.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOPMZHwBYEugdTk5GmAn6Ga6vbiZSToeTbf1IMxgDWTtusPCMVEfivMs7bXsuSEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 10, 2022 at 08:28:44AM -0700, Jonathan Corbet wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Thu, Nov 10, 2022 at 08:10:19AM -0700, Jonathan Corbet wrote:
> >> Jason Gunthorpe <jgg@nvidia.com> writes:
> >> 
> >> > On Thu, Nov 10, 2022 at 07:49:14AM -0700, Jonathan Corbet wrote:
> >> >
> >> >> The *real* problem, methinks, is that the directives are added in patch 4
> >> >> of the series, but the documentation doesn't show up until later.  So
> >> >> the real fix would be to simply move this patch down.  Or just not worry
> >> >> about it, since it all works out in the end and nobody will be bisecting
> >> >> a docs build.
> >> >
> >> > That is half the problem, the other is this:
> >> >
> >> > https://lore.kernel.org/r/0-v1-c80e152ce63b+12-kdoc_export_ns_jgg@nvidia.com
> >> >
> >> > Since even after the whole series the EXPORT_NS functions don't parse
> >> > properly. I'm going to put this patch before the doc patch and ignore
> >> > the bisection problem.
> >> >
> >> > I'd like someone to say they are happy with the perl :)
> >> 
> >> I'm not happy with *any* perl! :)
> >> 
> >> I've been sitting on that patch because I was under the impression
> >> another version was coming - was that wrong?
> >
> > I can resend it with the single regex if that is the preference - it
> > is not quite as exacting as the first version. I have to test it is
> > all.
> 
> Single is nicer but it's not worth a great deal of angst; nothing we do
> is going to turn kernel-doc into a thing of beauty :)

I will leave it be then because it is a bit tricky to tell if the new
regex breaks anything, and the first three attempts to create it
didn't work at all...

Thanks,
Jason
