Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D8619D2B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKDQ0a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKDQ02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 12:26:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF631C402;
        Fri,  4 Nov 2022 09:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiGgEmzLwdlM25C7Of2ZVlBCAUODi07ifjOBwGTfB9ALUm8qCxfLuV67A5JQCNHjoEsoTZIQCK5J1aJHwqyLWca/k6l0IIAlhE/SgriHikfloLmITMWysSKXWy622kltV2kUi//2VudGhanZw44H9F8at1ICOJH/ngJCp2q4GmeVJ2INod7Cu6ipC2gMKwXIQo+gQEl1Wa9IraL9NUL5qEHHNmMgtTR29MNGEHV9/9XmFN9/tCDwAsewittZjDIjYhgd05mKYv/EQhajVlHXjC5qBfYVipwScTx1J7limKBTX+snIR9TkSG/yWwEjkqQY8n27xeKwkijdJrOe8mXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkldMygYQ/GrtnhorFa3NOKEfolO4WnJ7WHZzMyDovg=;
 b=kld+4zRlUUow/66K3MuTcM0MY+nxgJdL+ZWFMztfRxguBTT7OH/N45LvS16rw2wXb5TzCpbshQtLMc29hGxi7LTtmi+MigzxUrUyP4VSIxQrLNfbPXwA1jCw/KRR79ybzDDeASaZEs93+tah6cdcePhRpQc0ghJfnl/zcRdY6XZwmHiKiK1/lYr68gN7ofWAvDUQ648AYNxsnP+bi1n0dyvOlvrLhPbilDn0lgeT6Q94ZnosevWEjSiRnBSsT6krMLuMSIiepuk5qHsiNS0UOJL8CtW8xTiNzXsXUo0ye4WE8TZdiUdg75bZdB1+0D80fMGr3JqorEfTGb1pJ1Focw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkldMygYQ/GrtnhorFa3NOKEfolO4WnJ7WHZzMyDovg=;
 b=T0IZcEMeP7y1nznSqvdFQX4W1dCiOuiV/wc435VSaIgLDlMH8OFhyvsmJfBRRvwD2zUF1d0FV9LdXRGrX8jSNCP5Z3JtxhEpUGbaM6QL33xYIJSRfoRFjtjoARikJ30IOl4JnKrajTgDN93p9nMDG3iGDgN1pQN06W3G456H/ELhZ2toOABJvHH4X2i4KpRMQDGJgUh7mJnW0RdmlLg1iKfdXTfS31s6VlhRlBOgf3paFQ3wtfpLir0l0YJhKE7mruX1HiY+XaTJAip+V6NlJ/9b6HNCnPt0J2u3ZNfS7ASJFXTk96M5NVuzS4r63mApe6FKkdLM1BFjCVa0YNv3gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 16:26:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 16:26:24 +0000
Date:   Fri, 4 Nov 2022 13:26:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 8/15] iommufd: Algorithms for PFN storage
Message-ID: <Y2U9LiwXxPO7G6YW@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2QfqAWxqT5cCfmN@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2QfqAWxqT5cCfmN@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:208:237::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8321a62c-a3d8-40bd-f216-08dabe815089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jgna2tqqPqq96YGI2Uu0Us5j23OPsMrB95gbMR08p51+1xXIf8fPy4VGqvZ2tWPdBRfdJZcLQBMb+bsr5Yep7DZGGRhvdjHgYqm6mleJRhEX08MAKl5Kbv6zBXsZ+tHh+qcBfAmzh/rLdA+NXfygpSNIr8QLnsMKNOmKFZ/SVBuPsQf5TP3kPFeppQ/SOYyZa/xoUdVnDy9tyOHkFa5CJ+semO6K98Xau4kPO0GNJ9LF6l0HCp4mM/KAIDwltRRDTAOAdZLpyS/IG8/634M7ZVicedCrYabTbm/w1/CI7Fs76pYDbUZwxbufDl/gPIRUOdSUaON/nzjYb5txhOajD+LXIqF0yE/tHtTB5E52sQhtVOEiPhzlmxZC1RS5mSpSZvFVyuQnRy40v3CJHMtLXBRDBgQhV+eScDMEuRuNsTBmChm9n3qshIJjTnWaahfPybGblDjK3ypgcmxeSE1K0VJCqyE4EjnTQRdcJmFuy+lL0aAkh/h0g+9wJE4A6rBKRlF0/OxBuUFTsosObby00hWVcEoLA/objQzo7nFHuSRk1N03ISomHNIu3JHdMgkWBPLQe2c4k2sac6+XyQtRvZg/yhugYTWkjixOGYTZxACAkmi1kga93YaldqvcS2RmKONiB4Cw/nf3eoTw7bXpV/W7SHJREH7/W3RzwqKbm0XZvtWSaKvXHqCX7AMo21flLjC82/3s/0PvV4kdtbWiu8O6tB3WCguCdwv1eOyM5KIuF6MHmKFNI631LeXDrCQ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(54906003)(110136005)(316002)(6486002)(478600001)(5660300002)(8936002)(4744005)(7406005)(2616005)(7416002)(8676002)(36756003)(41300700001)(26005)(6512007)(186003)(4326008)(2906002)(6506007)(66556008)(66476007)(66946007)(38100700002)(86362001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRHBZ0UAc+ueLS15gRUdPNPurwz45MSAR2C3KlPlVR8LLx1gc70u4ZYB/JkK?=
 =?us-ascii?Q?tTqVwbjlajVu3uNPuHLG9iNfqo38x5PKqBB7fVqLeEvKYdxSijsDaZ+H8xFO?=
 =?us-ascii?Q?Dk2QCEwRYbY49inSulOY95YEpLEkdIKrPhksBcXFau7ULrjZF3f0L4XldGQp?=
 =?us-ascii?Q?Y9DgvIlY7rc4joPBmj30pk1PFB/8NEmXICNztekNaFyC1VnWKJz4N0rEw8He?=
 =?us-ascii?Q?jcKESajXrFj7iJENXVhwPI0Tu7OuR1Y/2gi1cXWwiPpHXJ7KNAAc4MBB+1hF?=
 =?us-ascii?Q?Bnw29Ip2WETwIskXbUgfYEVuA+21r8feL9Q63+4Aay0BJpmoIMz5VzIzDyyr?=
 =?us-ascii?Q?P+UBETCJQtGQot01xUojB4bSJdG0hBNvM/yqYe1P3fAKiVjfJKZhB94hoClJ?=
 =?us-ascii?Q?lwWs9arCyK3cf+r+j2nyI7vWCB6NkIF82PpQHonWwIQSjMpApayqEZopTJfi?=
 =?us-ascii?Q?qCKm7jfLQvWysUSiS/cB7cbBbyyebbLJiFtgrX7sAxSb+cMfL4dybPKZpUNA?=
 =?us-ascii?Q?Mb2uijoquM+/lrpsb6nu3UkfQGn+7vwAdCUZGZxQftmRpZ81WSB/BW6Cfdy4?=
 =?us-ascii?Q?V3MHHJ0Umlq1GHTLwhDuyt08S7KPcHzuushrL4tst5bLSu2PnKCMxEH2k5FD?=
 =?us-ascii?Q?daFs/DyIaSj1aEITBfb94BN8xa86hADitfd949N5KgGKUy88N0O0b/HrMzuU?=
 =?us-ascii?Q?QIXhzyPskCAuCl3uhcif7Q+Aj2lqCP9eixXJJGcWCSb0VOKJZIFdEYkFBjqA?=
 =?us-ascii?Q?3uecjK4GwiEDlKBWmKYw96ZNyDXNTAFYPIt+rXoXbCFDCjQy17BQvBVNO/qk?=
 =?us-ascii?Q?lhcq8Hor8smEHrKDTVQfHuRVTRqqLINn1Z+G4QvNlaHkRZ+3oM8bLL6VGXCN?=
 =?us-ascii?Q?2ZUPU0b96EQReD0xbQCCT4V0qjXSq/KOK5YeqhLZ5glJE4LCRpa9s56EBzex?=
 =?us-ascii?Q?gSPR9iz9InCjF2AH1ji6orTELF1OrevyCCmNBBEXvKZWDEYRCx/lhvAx2riT?=
 =?us-ascii?Q?Vrq5E4Ha/RTKk1F9ewQrvRVkgdjMScdYYiWD+kNw94MOA6TLQ8pgvBrxzWa2?=
 =?us-ascii?Q?GrzEfTM6xJK1jv+NOtjUfTtKtnYuwNBrbGmr+SCUqyGSiUPLVVs6m+H+AVX0?=
 =?us-ascii?Q?XqIYSxPkhglLq+6zrIt/S/6xG8SluUYIkdQmR31Zahd/S7GnLs6OdhsMi7gP?=
 =?us-ascii?Q?CHsiHVdD4EjUf/4K18D4YqtO6G+qG8wwyyG5Bk6ETbih2RoNGuN0/Thj+phw?=
 =?us-ascii?Q?7qFyFaVlQA/s6ii9MfJZbm5bYOdmvSKtVNF/e0NxgrGrIZN8ML0kinGfZUFi?=
 =?us-ascii?Q?8Ks+I9MQlq49pi1cTIN+HmAFAE0t+SA1lT8POslyjcsr3D20cEq26+6m+W1W?=
 =?us-ascii?Q?pOTbNCT/xV1Uy2e4/ikJQAFx+DpF1PEWxXzfN4AXFRp+1dg2/IdX1gShFEDc?=
 =?us-ascii?Q?NSoNHqTc00fVXcXWS0cmlwSERawbQTsU1QOp2axwFCgka4lqtHe4ydFpcHqO?=
 =?us-ascii?Q?YcY/GOcl8ChzQbNfI0k6KqqHN9wXLfhj9v+cBki9n2JxcqHwiqeMTaN/1qLg?=
 =?us-ascii?Q?LcJsv3SKXdIxi0dIXs8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8321a62c-a3d8-40bd-f216-08dabe815089
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 16:26:23.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1glTGEXH7f8IvZpWPhKisjTIPfIU+D1LjTgas5QSGiFWgEkEYEmUJzhSmDkMgwo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 05:08:08PM -0300, Jason Gunthorpe wrote:
> +static void pfn_reader_release_pins(struct pfn_reader *pfns)
>  {
>  	struct iopt_pages *pages = pfns->pages;
>  
> @@ -1005,12 +1013,20 @@ static void pfn_reader_destroy(struct pfn_reader *pfns)
>  		unpin_user_pages(pfns->user.upages + (pfns->batch_end_index -
>  						      pfns->user.upages_start),
>  				 npages);
> +		iopt_pages_sub_npinned(pages, npages);
> +		pfns->user.upages_end = pfns->batch_end_index;
>  	}

Syzkaller says the hidden if above is no good on error paths where the
pfn_reader has already advanced - it makes npages go negative:

-       if (pfns->user.upages) {
+       if (pfns->user.upages_end > pfns->batch_end_index) {

Jason
