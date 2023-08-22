Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83978784634
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjHVPuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjHVPuP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 11:50:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53662CF8;
        Tue, 22 Aug 2023 08:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfK6clpub7lbGH9QXOSiPNoqec7j9bZ8zVXq5O9zDd2k7a8/GT/oh+XwWY7CKgFT83ujYDJiP012D0QOufkt4qva3W/LysmLhj9+Su8uScgHbzRTl9PpgJipdqBxj5o3IXj/7xvNec1ONaStdUSOPSZD1l2ptKpfEvlGGv3W+JVbBL8wF3spxmIQ6XFI5JUaP6993HMo/QycDMYP3auNisL1mlMcS25W5XoUeE9HahPvQIB79VeKDZrpH0NVmkv4Sqh03sWGCH8J+Rc4TbHkCDYpKvKX6S3/8uNW61AHTtXtJiM/wbm4XqtqFmmxQ3GgYSfQc8T++LZHr1zwhXjdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEmXOsqDmqh8OG4z1c48L3siQfPLTJmd0zV5dJlZynI=;
 b=CvVenPoK6SB/o08x/d9yMZpClddzJPKqRFbZ5iwGdkbHWtNHdp3S2A2gGQmr5ADzmY7SQ8o5d7gtbwBr8Umnpk9C05VQJBjPrlRZb/nE7rzHJI225g3woA9eCouDXKEJz6BWkgMWiVcasaZ7/hWk89168Bx2Dqmv88/6jcn8yM3G3R7qDBHXYJX6FcIIm4Yu1x0lYlR+xiDioGDCjL46Xxm+nRnNpuNk0UBaMcxqqv8dRD+kF1jwhmb+XY7RxkEfvn2c8zPQPYHGE8O1L/X4wf3yo0+aN5C9oHortxPXYy2FiGnfLXTfr1fSABnliRKuhRXhvcyhwJ5woM679t1+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEmXOsqDmqh8OG4z1c48L3siQfPLTJmd0zV5dJlZynI=;
 b=PhJYHIMWROcWyNp/agwQb1pWAi7DcLyZ0ZM3b29lTN16MCJgNOXTdy5oBY15NBMvWjXNh9tehD8iZMcQIsiOI58iTiENE0DNzjq5d3eLc7eJ/u87LFV7/FVEQKjK/5f1pJUi3ZF0qJPP73ot/tYog197jgmuY8lRCLLZsRLQ96CZSyAricgKTsOSXccrOCdvQbJ17Kf7l0ON26U1Qp1FGgONUfakujFyJBsZOkbwUFb4CoF6CcLV7VHiMglXz1ubuvsA21YXnBUIV0JJrbF9nG3Q3U5Vj4emD9DJ1yUEIkCVSKoBWNwulPoYU/HGf1A3/CcC5/CJgi3jmMOwQz377w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:49:56 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:49:56 +0000
Date:   Tue, 22 Aug 2023 11:49:50 -0400
From:   Benjamin Poirier <bpoirier@nvidia.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jonathan Toppins <jtoppins@redhat.com>
Subject: Re: [PATCH] selftests: Keep symlinks, when possible
Message-ID: <ZOTZHhGLnQKOhITt@d3>
References: <20230822135837.280967-1-bjorn@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230822135837.280967-1-bjorn@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::9) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: ade76065-5cfc-45d7-12c5-08dba3276ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AbJFpKQFcv8BpxgqVFjFMToXDtxJEIcvzihHMoOUS4LDRAQ7ku0AnpTR2GZZIpEft8bkTDREfWPGb8M8LKAmQ2Xq/+ZFNso44H0cQFkWBqdZ8FqpT1e2AqqcSqRipJeZU6cg8YhFpdrj/DJKwhw7Tp7eZ+Zrtb8xbKIvKz8GIstrd9N+STzRqKJfWFXxKs5vyCTHS8KXytOkUa4nh0C02zBjdXEct/fYsT5HvfChZbmjKGrmppLzLOk5TdZvDI7f3noBvP75qYr67fnwXGS9iIK3roSdBsQkjgClqZCcT8SClB6Gtbs2vfDPy7AyuD91sLtHfu6Dck7new2jxwOtJ2R+O6kguS3A2K4N+49FqP+XM04lWGMK3qjSJ01kjU6l5IpINQKb9qqCEwqGvkTIhLdTMVb4RvHXdOFH0px/6s7fnSkZiA/OCk2xwH08TB8MXmdyDm+RLoXYGCOTiYde6UFHDJVsMnyICzCtnUqvoBCHlDbGNg6ri9D24JRom688KuxCi95A/9W0jnZucwe8/bPBYMUEMGIyUDDWrMn0cgbQ7R5myHZe9wApy4GixU4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(4326008)(33716001)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nGyA6R/dd646QlasJGpsjnAIMqq7xFYr1GdVBHSfN2OBzlrkixTNnh3zcW?=
 =?iso-8859-1?Q?FwUuKo7u6hg+XCV8tq9CUQaGj2pbftArRuUINvbeMJF1Ta9eztSobY+k/U?=
 =?iso-8859-1?Q?7paaMga3gn5eUw1ReW7q+fk4DQ6xM0jPwNDVbGNCyp+bltn/Ncp6l1Uvls?=
 =?iso-8859-1?Q?/uKZLS9aDBqsQUrNW+6RjVFqp8O7jLlkYnh1KtWM/pPug2+Wy2nKfmwNxK?=
 =?iso-8859-1?Q?tvRxV2QFAKFZgmu4ubQjb++4MALXkqmPwevPa79+z1Yt9cGXtquU+Jo7xO?=
 =?iso-8859-1?Q?CNb11uD0ih17dk3BOQQUUf/KNbtVmTcC6uxLCiK0X9HQIbLzvxOHJXLE9A?=
 =?iso-8859-1?Q?qU9Ml/V+j6VfkdHaBO1cPYCU1qtMBM3VUXbPLZuk3t5Z0YHVzrT2pFmw4H?=
 =?iso-8859-1?Q?RiKCJumJA9ebPOXAJTaRNMgWTQ7vJ2xR+LSkNmZ1ssUhNTufh7opI+BZrT?=
 =?iso-8859-1?Q?TPCA78YAo1RweFnlqEI5R3osHbnyDs3eVu4nhZoJiMkdXtInlq82VNKIb7?=
 =?iso-8859-1?Q?PN8FJJ4N8KEMsOGpcO7WXdQw7O0gnohlmhqK7lIFsvtff36nSnuWJwIbdV?=
 =?iso-8859-1?Q?etQs6fJZqXoHbEocC4XJ6S6DHJSBvk7kacEfo9pQ31g0FYnHXzOAYuNuOP?=
 =?iso-8859-1?Q?Tx1KAuKz99SpPVZnogZgKrG1/T44F3/aekYmzKzLI5A6KksoxNg2ARptB+?=
 =?iso-8859-1?Q?ILTAic8oW65Xq9QKzBtEHb2la2tihRd8nGZxbTJCyxwYSvZHUBYIjpfgr7?=
 =?iso-8859-1?Q?Wjb9PBhTSa+O1JY2KZ6JptPAz885sPmL9KuYU39rWzfrwSpGqVKLgtdIPi?=
 =?iso-8859-1?Q?k/nTuQBsxbJkJv1DRH28ps1Ph+SoYhti3qUeVR9zd57OQ7bcMXP4vvqWQb?=
 =?iso-8859-1?Q?1JwechwKyMi5igqRn6/v4fA1zg054yBFXt7qK8ehNunZV1EmYK+wwSXUKj?=
 =?iso-8859-1?Q?+Z3xu6HyjGgsDzOEklV6YtsWiN+K6VEU6q7UyqRxuMyOpsuK3Rqguoh3Tl?=
 =?iso-8859-1?Q?fYn8GKbK+/COiiAZ8OwzeBwGV9H0rslbChRTiJTE5gmErGRsJ1AbB85357?=
 =?iso-8859-1?Q?SVBWH+BsL7jac+GDmHhpDPQh0GfK6fXhbhFD2Euo0VY+20JC4ize1PxGEA?=
 =?iso-8859-1?Q?fOzAukEYI8eroJKmTzqaa0NB/iKbySIZ0yuYloY5XS//bn5usiKle0+IiZ?=
 =?iso-8859-1?Q?RJH+iu+WbvwcLaZBcsmitphpmiPjaXfLmiuKH4sOKzynwK2g1Ke2yrzrvd?=
 =?iso-8859-1?Q?xihZ6FJP3h3vIvxAEp6yhNkSdDrTBphVoBCPwCK3xx9x2IjzgNGmY0NooS?=
 =?iso-8859-1?Q?jScUDkvMenZZXy8aQbkoka560ELD2Q8AdFa/J1lvlgqF/wXXxToc5So5WR?=
 =?iso-8859-1?Q?8q92CUOCxN/TTjeY+qZ9r2L02dMSTErGRC4aH/TzvKSFqvZR80WLjjb1Ev?=
 =?iso-8859-1?Q?pvxWUTa5PLzN0VMc8RNKO025UlAFDAvKEF+WOGTmgoNOqdUGMOWRGWTJMC?=
 =?iso-8859-1?Q?1nTTM9JB5rd7XTY42ndmYbLGFiai1L856H86vrmoeMXhN2D9FG4bb/GU71?=
 =?iso-8859-1?Q?06bMhK4djHzj2Ymmogib3TyLurzhXu42hAx6AWXblChDUtWBWLqJ/stJEC?=
 =?iso-8859-1?Q?OmAgCgpbBWc0U3EYsEPP4mcPybJJv++WG8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade76065-5cfc-45d7-12c5-08dba3276ed8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:49:56.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rskOYh3FkG7NCBcUAdqzk0ky1cL/vxHVJDWiEXfZ8RAKEBszEDoz7BdvCPb/2FQpqudrdHhuB4L7LXbmNVG+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-22 15:58 +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When kselftest is built/installed with the 'gen_tar' target, rsync is
> used for the installation step to copy files. Extra care is needed for
> tests that have symlinks. Commit ae108c48b5d2 ("selftests: net: Fix
> cross-tree inclusion of scripts") added '-L' (transform symlink into
> referent file/dir) to rsync, to fix dangling links. However, that
> broke some tests where the symlink (being a symlink) is part of the
> test (e.g. exec:execveat).
> 
> Use rsync's '--copy-unsafe-links' that does right thing.
> 
> Fixes: ae108c48b5d2 ("selftests: net: Fix cross-tree inclusion of scripts")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  tools/testing/selftests/lib.mk | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>

Thank you for the fix.
