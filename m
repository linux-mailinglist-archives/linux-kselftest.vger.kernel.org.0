Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE667518E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 08:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjGMGkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjGMGkR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 02:40:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDFD1BFA;
        Wed, 12 Jul 2023 23:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag9o4Ka8nFBVudCoI4zSm0I0aGz6qjxqfqaELQnqRq0BmGvZQhRF8TLuqHBqto5MdyFC0JhhRJ7IbvZDGY2+rfi7ElPbU1ivYP/aesBp7sy+ImG7RTSlmRuoc0L0+R/aBe4E8r/BNX6B6fc/G5shiC7eiu8jEKe7byxGfQfIl2Q/3L1NyntXti6e6OnrEQo96I1B8qDkZDOELPwkeiImYbDqad2qRSepklH9GAW4hJPJbZlGl72K5lIPeapzs92ctmuHpyCbOLKbPoV8yP2VSkqE8JYv+ozaN1s+0z4AeoV2wZG696+VWrAbBKPGkGAE4/GAXsreoPB6N4IwCkN5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDK7/h0k9y+S3svS8/MptrwbbdL1lpsgzerhhY6a/5U=;
 b=M9B4wRWVZ7/1gdY6We6WmErVbJZ05HlIxjd9OJ52DZdIPvdzTwFbyhR5d3tKemtIZOT8SUINNY64dpLZG7aBOX0Qi7Ryf6U20HArSga3lB8PB13znG26wqpi/tDrizIjAGNQjegnNrf/SK3rROYDARf+MZX754nZSq6s+8sXer3QGETFZ2gmEH2iDUSzgldZdtnIS4N48GTF98CYEqG4m+QPJk3H8KxyS6O3Wn8jsx/qPBw9jGNMtnYYgLLk1vULV3OKQF684mWii6mjrd3s3Z+0HWVnTbjEqJSUzEiBlM8Cf4FxilsUbh3atiJrXl+tgIpqwUpnkeWQMu3nE6w5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDK7/h0k9y+S3svS8/MptrwbbdL1lpsgzerhhY6a/5U=;
 b=jVEPn99ITO9s7r4c3mGqyGh3I/7IqoZvc0gdAoVPf8OHIddxTEggMp9eVDMWD0F8H/gPM05lkaBaf24WuieUIqyxoudYwHEnE/pcAH1wZzcVftCUW34uoGDo8nE9YNCGdJomwnF8VpIJLqx08uSOf6ZfZxP3au2KqNGLGNRVFJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Thu, 13 Jul 2023 06:40:11 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 06:40:10 +0000
Message-ID: <c1d632a3-4e5b-6ab9-3ac1-cb4d696becf9@amd.com>
Date:   Thu, 13 Jul 2023 08:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 2/2] drm: add documentation for drm_buddy_test kUnit
 test
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Gow <davidgow@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mauro.chehab@intel.com,
        "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <cover.1689171160.git.mchehab@kernel.org>
 <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d515c3-951e-4c07-8ffc-08db836c00ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exun5vGu1n5ICnlqcB6b1kqVulntcG7l7uk12Q0+qLViv0IB/2bN6iTgp19elTGWff5TC5bDPFGzsj6EnKvq1zX3TvW4C4IzWo5MbFmQKqlZ5IWFXtBLaeR9zc1A8xLK45SKw1Mwv6h2Q7U3dk6nmzvotI88O8bzx7u1R8jztmOUyBmQYbEbuahDVLfqaNGddO61qHClerzd5zkqpXfdSUkRlvbzrLpHkAlzI9R0lSKj8v0UdiCsZI50y+2lNSicX/Qx4DrgxtLXyIMuPHc+eFVAYnudFZMY6Hfi09Nado1xOUv3nuJwKRYNL4Xmxc2Z8iG7QrArfXQUijkV21zfMCBzfJRqiPm0z13BCrox3T1p4UFsLGNuEXsaGeY6Cz7CR2NfXz8GPzm1KQfmFU3XnklrgDY66EaqKURaJDyKNNnXFHvFWl9P4ESUhvNiW1wzxRXJnioqyMIMZPgvSNT7UEmHJN6+zyYisKGmcY6Y0ljRCNTRaeru0zwUakGWbdBzbs5CUmuKywV1joNwG4Izx+B1UpIjz9dMHZQufCPbC6pqgOJer3CAbYeSNi0DVJIf3OyBJMhdjl5L54ZwhTOPPUB2SBIz5C2TKfEzocCettYZ8bTKp20wWMGV2s63MCm2nJmcBgZcaBRTWRfHt38SRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(8936002)(8676002)(31686004)(186003)(2616005)(66574015)(83380400001)(5660300002)(7416002)(6506007)(31696002)(86362001)(41300700001)(6666004)(6486002)(966005)(316002)(6512007)(66556008)(66476007)(36756003)(2906002)(6916009)(66946007)(4326008)(54906003)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2wrQWF5RkFzdUtwMkhxZm81aXlMZjlINGljK0FncjRQNEN6Y0hZWXB1RE5G?=
 =?utf-8?B?ZUxJWEdIQWNNTkk3ZE9nTEd2T01VN1ZNL1hNY3gwRmQzd3cxK2tkZ1ErTmtU?=
 =?utf-8?B?ZXNTMlMybE5JNHplNmFkbG5ZQnkvaXpuSHpPdkRFaU9CejJFQzFZalQ0US8y?=
 =?utf-8?B?NUdDZ0Q4eDFRVjlmQjhaVm5McG4yYm1LOEg1YTd0cWRhNWdpSkc4b1hCOFdw?=
 =?utf-8?B?WVJoei9INStYMHdqRW9oUTBoVlVTRWxPL1FDd1VyTm5pNG1QUk4xQTVCSy9Y?=
 =?utf-8?B?aFJiNjNnLytMYUFRVXJTQk0wWTB3SW1PaHBzSC9hbG9uU2liQ3gyNE1qNXc3?=
 =?utf-8?B?Y3JyWTZ0WlcxeDdURHVSOElLNTJ2UGQrR2QxZnVtT3R4Q1pzdWpJaW02bUJx?=
 =?utf-8?B?TEhpak9sV3AvRitiWXJOQzNaaE93S3hoRHBTNmlpVHpwdmJuVXpMVkJsMkND?=
 =?utf-8?B?V0xkcnQyQU1zRVJNdkxSTmZERWd0dGJBQ2hpWVNodjRxSmszeFZrVW5hYzhU?=
 =?utf-8?B?OHRPM08zYUc1T3hsVHVWYys4alJXZkVjcU1WaXRBbVpOR0IzbDhTY3ozakU1?=
 =?utf-8?B?SlBpM3phTm5QT1UyY3BBM2RkTmtudU5qdWlnMzVtTEltY1hCMWhRTUQ3Zk9K?=
 =?utf-8?B?QzNPME52S2pqOWxLWkV4TW45UUJyNko2MkttQmdLc2lxemdsV3U3Qlc5djNC?=
 =?utf-8?B?akQwcmZVbTNOL0p1WlJPZ05sRDdFQmxXT3Boc2Jobm5BUk81ck02WVNGdFgx?=
 =?utf-8?B?WFBCT09FVG1ZRll0dVlqV2ZQeVdPcXFrUlZPT2d6ckxERFlyaVcxd3FSWHpp?=
 =?utf-8?B?Vnc4aGJSQ1lvcjhzaXp3QUFhM0dCNHpMR1NPRThXY09yTSt0VVI5VUUxbGJN?=
 =?utf-8?B?U242Q2paOVRVMVVmV3Iwb2tZeWo1cEJnWm5qWDlIUjVtc2JrYWxWekZoMjRi?=
 =?utf-8?B?V1ZqbVFSa1pnMTlKUFNmYVVQaE8zbnd0L0ZuU1pZMWpjYjQwR25ycUxodE5z?=
 =?utf-8?B?RTlqMVFqNnF5L2xLTlZZejExZno5Rmtvbk1DZjUwcWw3cDZEVXhVSjAyVEhO?=
 =?utf-8?B?Z3FacVFIVERGSStxNFBaSDIyYlRNS2RxZnZpc2liZXVncVV3RUxEY21TSXQ4?=
 =?utf-8?B?Z2ZTcXA4dzZpU3IvSXczUDY3T2o0bWk4Qy81d2V6alIzSW41M3ZrRFZhMkVk?=
 =?utf-8?B?bVVtRHFrWkhORXg1b1k5eCtKMVRlYVJ3S2V0aHBTWllNdkRpWTk2dlgxcDN4?=
 =?utf-8?B?SzgwMm9CSTMxZlE0c0NwNmZzU0lkRGlPa2dRcXhKSmNDejNFeVdUUjQyY1Ny?=
 =?utf-8?B?UHFyd0plMGZBaUlScHdodWRCV1RnVUEwdnNGMC9aVEJDR2NjbXlQYVN0eE56?=
 =?utf-8?B?bjJrR3M3RVFaSkxjUWlCOStBUGVGdUdjd1VjaDVIR2pwSWN1MGwvY3FBSGVj?=
 =?utf-8?B?VDg5RDBHUXBZalRJM2xDb05rU2tPT082TVpXUkZ3bGx6cnJOT1VqSU51S25n?=
 =?utf-8?B?aG9aQXpCb0xoeUJPQkJmVHlmMnd5dWNidGE1SkUwbnkvU2M0QWxOZE5zRlky?=
 =?utf-8?B?dWFQTDdGeHNUZGI3bHVQUWNoZ2Q1bWtWYzBOQmF6UExqbXNnaWd1dDU0aWRV?=
 =?utf-8?B?VnUyN201M3RGQ3QxcG50c3lyZ0kwZ08rNVRYMG5Jem5nU3hyUzhiUDIxSzVt?=
 =?utf-8?B?SmdRL1hZQTdmcFB0ZHR6bEVJbnJwUDZxOENHZ2tKZFYzQUp4VmhaWVFxL3Nu?=
 =?utf-8?B?dzA1ckY3QTNsMFE3bUIrb095TzVSSTdSWVVpb0J5T2lqUHZnd3Faekl6WHFy?=
 =?utf-8?B?WHlJZWZ3ZWd0ek9UbG82dDlGeCs1R3F3eG4xbEdjaEd3WmpJakFDL3Y2czl0?=
 =?utf-8?B?YWdWUHhvK2JlQlZQaU84VzV3OWVrQzBqLzJJSEhCYzlXZXQ0aHpUMUxOcmpN?=
 =?utf-8?B?YjF1Yll4S3pHd2FhYXQzNmlSTjdoZHJqMEQ3NkFKaVlLU2NCTUV5bnBCaXl0?=
 =?utf-8?B?NjZoM1h3OWpyQ0RST0s5cFY5NHNnaXd2amwrdTdpaXZOTy9RSlVwU0ZPUERH?=
 =?utf-8?B?ZHBNQytMTVhyZ01aYjVyWXpOaGZmOE1SY0FLK1V2MEJTR01EZTBLdmNyN1Z4?=
 =?utf-8?B?dEhCN0d0VHlvZ0JBNThNVkE0dDFFWndVVTB4M0QrdEppakNGU0VpUkYxU3Zs?=
 =?utf-8?Q?VGRaio+HYoHVtp/IxaKk6gZeJ3Ycqhtq/NHfeUVQtbOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d515c3-951e-4c07-8ffc-08db836c00ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 06:40:10.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftgk/fQ4bIONa6SivRDcQ69R+10orfe1HhwsCccj95bdOf1TfN6a5zDzjruWPObZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Adding Arun]

Am 12.07.23 um 16:28 schrieb Mauro Carvalho Chehab:
> As an example for the new documentation tool, add a documentation
> for drm_buddy_test.
>
> I opted to place this on a completely different directory, in order
> to make easier to test the feature with:
>
> 	$ make SPHINXDIRS="tests" htmldocs
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

Arun please take a look as well.

Thanks,
Christian.

> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH RFC 0/2] at: https://lore.kernel.org/all/cover.1689171160.git.mchehab@kernel.org/
>
>   Documentation/index.rst                |  2 +-
>   Documentation/tests/index.rst          |  6 ++++++
>   Documentation/tests/kunit.rst          |  5 +++++
>   drivers/gpu/drm/tests/drm_buddy_test.c | 12 ++++++++++++
>   4 files changed, 24 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/tests/index.rst
>   create mode 100644 Documentation/tests/kunit.rst
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9dfdc826618c..80a6ce14a61a 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -60,7 +60,7 @@ Various other manuals with useful information for all kernel developers.
>      fault-injection/index
>      livepatch/index
>      rust/index
> -
> +   test/index
>   
>   User-oriented documentation
>   ===========================
> diff --git a/Documentation/tests/index.rst b/Documentation/tests/index.rst
> new file mode 100644
> index 000000000000..bfc39eb5c0aa
> --- /dev/null
> +++ b/Documentation/tests/index.rst
> @@ -0,0 +1,6 @@
> +========================
> +Kunit documentation test
> +========================
> +
> +.. toctree::
> +   kunit
> diff --git a/Documentation/tests/kunit.rst b/Documentation/tests/kunit.rst
> new file mode 100644
> index 000000000000..6ffc151988a0
> --- /dev/null
> +++ b/Documentation/tests/kunit.rst
> @@ -0,0 +1,5 @@
> +Kunit tests
> +-----------
> +
> +.. include-test:: drivers/gpu/drm/tests/drm_buddy_test.c
> +
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index 09ee6f6af896..dd6c5afd6cd6 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -737,6 +737,18 @@ static int drm_buddy_suite_init(struct kunit_suite *suite)
>   	return 0;
>   }
>   
> +/**
> + * KTEST_SUITE: set of tests for drm buddy alloc
> + * Scope: drm subsystem
> + * Mega feature: drm
> + * Feature: buddy_alloc
> + *
> + * KTEST_TEST: drm_test_buddy_alloc_%s
> + * Description: Run DRM buddy allocation %arg[1] test
> + *
> + * arg[1].values: limit, range, optimistic, smoke, pathological
> + */
> +
>   static struct kunit_case drm_buddy_tests[] = {
>   	KUNIT_CASE(drm_test_buddy_alloc_limit),
>   	KUNIT_CASE(drm_test_buddy_alloc_range),

