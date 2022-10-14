Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BED5FEDBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJNMB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJNMB5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 08:01:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE9418F27C
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 05:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2+PhP79rNtkMXnkGO6dTNTqoY2/zSAV16I8IxgPfd0nRe4K5XNQ1m8ba4P1jHfJrHuP4xXYDlwchJ7RMK2YTUKTtpmvdz6QP1gQQESsV47UNFpqR9Weej5FlRvhrNX+9QmIVBThhPXhurBWvqea2IXLvHSicQ6eXLt6/I4X0PrJU5Qp0h54VuxEwrQxB13Mjy4pK1joJdMOriT3Ad7JApbw5ggRpedEJ0InqKgCKU1l0Roy1E+EmTg/H91urFdSNjtAeLuGVl0LVtvLNqbr7/RFFcxzpJNuDlmsJxXRVKsJNkgQ4Q+/Di8N1TkaUBTd1lavmz3E531TcTdl4nCvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60mzp0qN4msS5g0AfvMwfzj94lKp0QCYimtytO+GSnM=;
 b=gvxYuDv+djHWONQRwSPzy3/l9l/eebXuIYru3KlOpvIT8afY5hxH+XsPsnWp9JGumUib6sGKH7UdksFANncAxdVgHVIyc/mb2DwxIJ1qDoUG2HHsQaGYKkfrkECe9VrF/oiUIkCt5mp87645+tbhW+xdB3Eqcg5+IShKFo5tz7rcOpWHJ/xS5RI8ykNytxzpUvyv23aFMqfykVB1EU0xSKzkWg6zoHfHBgIeaT4AXky6MlkgVfFx6V/6+LjTwKRG5IH6dJAJ7coqTK+e68qa/PvjFUGwDpiPf29Fc2U7lMYSgX0vYWuGeAVzwlulARSySzYscx/p55CsiNsXD/GKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60mzp0qN4msS5g0AfvMwfzj94lKp0QCYimtytO+GSnM=;
 b=o8iC16912Cqb+Nd5+ENYgWVykJiKUyxQooAL7AqfeffGo9BdIg3A/lUL4nii39rdxegC5XSgPG8DnrzAhuJI8/b4DT85ux61aclHcZ/tXJZOC7XjQV5AHA6L/S6zZn0rclOqZVspEmhSdbPZ0lONbOb0eIgfEggNjG8m1hY1o4LZDMzECSuntGXA3UJEMzbwgxaTZmjgnWWHvKSHMeRAbOsgHv7pg2coPq4N928mpKy8OoECiupZQDXCjHBOk+mOsjKfYGBmaq4prS4P9UfboPC9NkMc8T40TSbHwTG7eVM3NwFInCN0Knkz2Z4GDCMjmc++7/ObdoKAvjeCiFo65w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 12:01:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 12:01:54 +0000
Date:   Fri, 14 Oct 2022 09:01:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: hmm_test issues with latest mainline
Message-ID: <Y0lPsbLKZakAGZeZ@nvidia.com>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
X-ClientProxiedBy: BL1PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 6836aca8-ece3-4b9c-376d-08daaddbe2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Civ4vGvS6XMdzedwnuC8DKgqzjKtsisJcqVdXiClHtWrYTy3Sm2Hz8uIa5148f9fu1zCwCoMlnuo7znqkfqid6ECuDnEdeXnXov2i1vPCBcnrDXUcr8WyYaInSRTqn5zT4hRBdUfsI+GgoUPnfS2rq1NKaq70RtjOlJdBR0nCtqK9mVsRLe7EjucSsGnyh9qAa8pa8zjkEDfx9OGxBhE42AiXFt4E/9+JrcuAzv7lhrafLrtyssQVScOs7cOQRD5rEzwKoSY2sBXbbo+7ZbTl7is0uDctX0a2xt23FXjhjeX0Zt+zpxFcJGow05FGzJgiXTMDNPsihz3Z4JIEhAZMb09NAI8PoVYjejMMIvoFicHOElTbXHzQxy3Vm6tSUPD1ARuIjaKhJczKSD4Tv1k3UZHl84zYf0VN3imU5KGAq9FxrQdRlmR4pHEPsDxxeRn2prDrR40pgRgMwaib5Z/G1YCvtr9xLKzdoHdCdfAS0iCGrJuZO1/Pe2gNS6R1f9ds8uvQxScYRZoWH+wrla8B1+pXztdS6p/lZVCeKnumPrziOjnd9Vy6TaZeB6/PmHLWj1b7Gi6WcvKVi0UtAxFwBgH/OfWLiLoxSriomKowvdbjZYVHLYVhVg1PkH791hWpAh/Hxwkb1VBQKTLPCTXwxxvQ3s5Qcu9e4jFFwPle41b8L8mZ0lIa3jGut4TNFvNsxjXWayvARH13MoGGVZzAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(478600001)(6486002)(86362001)(6916009)(54906003)(5660300002)(6506007)(4326008)(8676002)(4744005)(8936002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(36756003)(2906002)(2616005)(186003)(26005)(6512007)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?itN90WplxjN+0MrOjJGmIWJoF0wnKOL6ZQ74uBK5b0obJxHvDa5pvOTU9DR4?=
 =?us-ascii?Q?ch0is1GrwGyxu631gSZVFISZhbQU833VyVyhAi7FAK3vonj8ijfrNIX1lpV1?=
 =?us-ascii?Q?7WEymyaN+iBG+O/AnmhCiB+UUhmxe0JDAcE2G6/Xs/wK0wEGtAeFYpurOouX?=
 =?us-ascii?Q?EYxqGllSWwKlegEy9q/3QwvQ9qvPabzdWXrtSaciugKTbTzdN6n44AU5GzTs?=
 =?us-ascii?Q?M5aruFG2WhT5ZrzFn8HeK/M/qCeLQm3azbBhjG9jfMlTJ1eRzeesGUgny9Sw?=
 =?us-ascii?Q?r72cCp8FDmaV11btIzNY6yzMY4qUqKs8a+x7YgTMND68IX1Cqh3U5WubzSih?=
 =?us-ascii?Q?0mTOrLyVmMpPZUwVO80123DOx6AwLqmBU5yEDMiYv3dCVm561PfsrmAeGOm3?=
 =?us-ascii?Q?HHuZE6ihx2EcqOM49kyAAUPoB5iPiNWcC8v6D91PXz9tbuWVIBHOFYVMa3pd?=
 =?us-ascii?Q?inPHK97dkcZkWjA+EXFqI92mLE7UjSkFv1hsAwVmsKwaUJSiRPj2smIoHZyt?=
 =?us-ascii?Q?TR8Az4C/KdSiCrh1Qtjj1KRETqtKnDU+iRgVJXgVCGAV1OeDt+4qd+2KDg3m?=
 =?us-ascii?Q?O+TpdqSlaE5pM/ezWD0+wqC/iK182wAAIoQ+9k2uvtodhAFgxhYmGgmkvbFK?=
 =?us-ascii?Q?wxZAz6+5lRHLNkebDliOARgFOu8G89EV7s28AAG+pC+aJvao7Ct4d8+PZfQU?=
 =?us-ascii?Q?zmqF9aKjEqiFjikHHqNXSdypTsAVOL52V7DXlisKYtgpM4EMI2Nw7wG4Sp+h?=
 =?us-ascii?Q?Eas6/KrOrt7xrfh6+yMywkUp7yEeo6bVzKOELqhKzfjNQIO7/yha/XrcDddv?=
 =?us-ascii?Q?1uN20crsNCzD2A11EaWkkWwacxDsyJ/CTohsvos+SVlqHnH6wOia45DNQHuJ?=
 =?us-ascii?Q?yhohNspw6WIVTxXSiM25yUxowNgqvR2cuJzQcG+QOej8u2o/hYtuozKem/81?=
 =?us-ascii?Q?HJ+ojKTVZvXu8GPWWtpPkXREb9lYVBOr8UZPu00RB94nDkLG133/RBLxWheV?=
 =?us-ascii?Q?ubdQzE1TSPSU+SXbD3I/TIOojTq+AGxJtKbxdL/5NS860ckV8IIo3kEsTL68?=
 =?us-ascii?Q?LjwLzQQNf6v0Sp5zIKSrZ7SbjwUqq9yHpB2YGC1BK+AzLhsG175/x33Amq7L?=
 =?us-ascii?Q?YtYAtMHOv0wH7HQAMK9KJ8LoGP5XqhitYsQERg7jxj8PZV2S8+GdRJw0PHmt?=
 =?us-ascii?Q?YkrJ+o6Z7Dr40wr3ERF3Pq+Q+TWNDXWuIX8VkaXu0cyOTmpOxS8hieORAJkC?=
 =?us-ascii?Q?l2ZZhMuVt5afT4UiKdC1OpdWxRmSwgc+JsZi3Jtw/dPLZOyOJHgEAg6or/1g?=
 =?us-ascii?Q?dmHENZ7jHf/PPW1lC7aOkBwwRO9XYkA5MpocgzN/q/TaYd6qJ4aaK33NC7pY?=
 =?us-ascii?Q?F0qPDvbuXn0cJxvW0SvawQahb3uC21Qf9BN0PTOD6jym1qIAdSr+kSmdBPMY?=
 =?us-ascii?Q?7UQrFyzjZarHy2VDzYRDLXclT7qEfVrNFTpFedUmdpsBBnCm07XZ+1zreUhJ?=
 =?us-ascii?Q?Zx0TkAXA5vRjl/Q9e/PX74bYT9ibe48CC0J+kkoWWGoXx66YrQ1x37KjI51/?=
 =?us-ascii?Q?WfG+EWo8iXLgi2s1kMg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6836aca8-ece3-4b9c-376d-08daaddbe2a1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 12:01:53.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6kl9sNndd84aRFY+7stfM5a7LERecwj+MRNebzIhK4+Apab+4+Tc4yDGrPVTwEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 13, 2022 at 06:54:24PM +0200, Vlastimil Babka wrote:
> Hi,
> 
> I've been trying the hmm_tests as of today's commit:
> 
> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
> 
> and run into several issues that seemed worth reporting.
> 
> First, it seems the FIXTURE_TEARDOWN(hmm) in
> tools/testing/selftests/vm/hmm-tests.c
> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
> assertion failure. Dunno if it's a kselftests issue or it's a bug to
> use asserts in teardown. I hacked it up like this locally to proceed:

I've seen this too in other tests, it is a kselftests bug/limitation,
AFAIK. You can't use assert macros in those functions.

Jason
