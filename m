Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF174290D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjF2PDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 11:03:47 -0400
Received: from mail-bn7nam10on2097.outbound.protection.outlook.com ([40.107.92.97]:46049
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230525AbjF2PDq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 11:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnASM9qE18F1ekcwqTdTz/BL87bsVrFi7hQG+rPbYC2AyScKOhCjoOr9BSpO1myXJsJGPxBfsjGyf+5NTC7tPDjcsFk6We8imcy4f+ys/FFAdQP8dSvkKWxNUvBRLBftIWTAZDqb3oJxVXUgy1kr5laUuU29r+GfG5v74cGUqlDBOuNTJNoIemtR2R+YvXspDoxqsNjyMeGT0H82ie8eVDXXqx+Bs50LcGlYBf025Od95J2CRwD6yKnww3fJ4dMgrI+KQy8vG1/3uTIFHkcE2Gd0SKLHMy28x1KNaNpChLbf/MwxEJxxsr7bLotZKV3UeGMspAxttUBvWv5dGDmjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cEMS8Ufsie7P1Ld0XWryXW1snMpnTII7rVR0uiRVSg=;
 b=lhjPhkgEAOqsVIkcFZODmz9kQ3FsddggG+4u9zjHY29450ca4fhrQOhDBJZPs4P4zm8GgKop+hGtCvK+/lqUhDZe7LGCHxkXDLNQZLfxkdYf12pKwNtPWcEyaCRdQeeuLTR8I70tnmM8i//N8hwLPv4Bq/v+lbyWEFVM87WgB3YHaRMao2OmxK6YkaNm7z9IQAsGNRiAcgWA3xmeVMoPDmSLxlv4mu0Gda32k6ogjY6+NqVkMxI04YOVaJWS6hiaWQa/vNk+fmF7CN990zvsnyg8xslo3PExzPKB+gpaS6vT/LEqUPGSoxu79yHUHKP4qwra2/5C2ydTVNWhTkY26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cEMS8Ufsie7P1Ld0XWryXW1snMpnTII7rVR0uiRVSg=;
 b=VdS/3qyHhEmcydFGwEDL2PhrjGnswNVCc5s5MGW0l5kE4UZPdfbzRs/5IeZyzHWEGn6dx4oxCDiqfaWgTd/goF0+EdKZY4kS9K/fI13b6dfiwEkvPSgqbXb1g1BHiz9eXXaXEym12ZmXUCsIbp7YcVvNtWc6gslK2wq3OGcaaXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL0PR13MB4482.namprd13.prod.outlook.com (2603:10b6:208:1cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 15:03:41 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 15:03:40 +0000
Date:   Thu, 29 Jun 2023 17:03:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     dev@openvswitch.org, netdev@vger.kernel.org,
        Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 0/4] selftests: openvswitch: add flow
 programming cases
Message-ID: <ZJ2dRueF4SG3sG/O@corigine.com>
References: <20230628162714.392047-1-aconole@redhat.com>
 <ZJyUoSaklfDodKim@corigine.com>
 <f7tjzvmmp4w.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7tjzvmmp4w.fsf@redhat.com>
X-ClientProxiedBy: AM0PR03CA0088.eurprd03.prod.outlook.com
 (2603:10a6:208:69::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL0PR13MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f856c9-21ff-454c-2b87-08db78b2063d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlldWT/qklkfvQ84OINYsWKfau+OvHGBlh/ctyyuuP6Y9KQpl9dRLKE4CF6xVnI6eksvwk6XR25f7n3807rTofcLf5NiO4vZ/O/eEnIfU2UpUn2t4W/eckXvjayu75uptBk3T0pixnaZGtYpyk9GtPt4oubhznI3xsCgQJuGRXOfgYsKko3ieymj/415OnElwaNTZ5LXwAQjtNOz2he+fbmt0ptRCYqtcwTJeVdPSQ32zm70i79usu50slk6WlB72VeZGFbWXKbvZwW4TeF8qNqAcnX1qpbCuXU2DB0sUrVM5wZoTJfIJlIAxOkVa0uamiMpsSIfjQcy3q/H5r6sN9Abzn4k5Prk/Mykc9HhPMxyqmzmc5nVx3+10vsfy08dMH/Bwrj3Rrq91yJvG2Fmq8YqahmlWFCFlwKATcwZwXlC9dE1fnt0lcZ+T67xIaWtQTlvdxnLaUA1tYMTykIp0rRsGxa4x5kUZBdXU15ylCGeDJyfaY1N/0yQvZgM7LJ3AhAbXgfCQznvhvqXlcHGqta4HSxELWAqLQOpHPqAJOEmIfnIwMvrtbeDZ/czE0tX1INKUfVOOz9qNkzSDW59aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39830400003)(376002)(136003)(451199021)(41300700001)(6512007)(966005)(316002)(83380400001)(86362001)(186003)(44832011)(6506007)(7416002)(2616005)(2906002)(38100700002)(5660300002)(36756003)(8676002)(8936002)(478600001)(54906003)(66946007)(66556008)(66476007)(4326008)(6916009)(66899021)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BsYGI5RG9L6NISSrGFThfGjpzqqj8JjPJecd5yOtHG3NiOxAdHXXEyvKA8tp?=
 =?us-ascii?Q?r0BCn3fHGHnbrVWQCNQt+D3cYle3rYchz3znsBjkAl8C9ZUMLUpsnZ0+j284?=
 =?us-ascii?Q?B5ZEi6EP8B1K0ey/90hJBeEo6QvjrQPwPen8J9LmCfWduqAmccth3CAAgxyH?=
 =?us-ascii?Q?TgM1ivvVw8v4CP7yEq12OxcWA6eAYsHKoFXS16h7FKv2KohY1PfuwQVs/uMG?=
 =?us-ascii?Q?ZoScWtQt9G9X4MvcB63ofFVxZK21BhyXDHZ7gfU/NDxoxk1AFGOVX5hMK6CB?=
 =?us-ascii?Q?swjhgr5WfjfynZqsIBlzj6cqBA10bAmAUhdMndJcgqILBypfOlz0z458AzZ/?=
 =?us-ascii?Q?mFP9GtKOiKlBW1PAuzigGSVq3JAo/wvXH+Ndyugr3QFAmMc0xcay+SMOa1Qh?=
 =?us-ascii?Q?GdrqqZ9yDvmCXZt0BVUp1bmVRbQv7mjHk+51s3M8KCNLGKKM1yJSiKUbLt4c?=
 =?us-ascii?Q?oHyAOhKbirNgq87ePgKOabnOJ2Vw2kF0wmmBqZKhJMmvsLce1hzA1zc/0i0C?=
 =?us-ascii?Q?qZNRTvd2sadut6SBrILUXmjsoSauD96Fg1AtCi40mrDsKnPtY+LPNN7NUJR4?=
 =?us-ascii?Q?1ptOmUyhoyIZbePP7V6PPXtNsdqsM37PZNbQEeX1V105q/Y76P1kq2epI/ft?=
 =?us-ascii?Q?NTuI2I4947GnN24EfIYZsViszNtSQtfdiP816QdUa0DW5VVaTVYwXS5rDLVc?=
 =?us-ascii?Q?8UF8muGMcF+QgBk8r6u4RYs1eXdEuk+3NTtINj8TJZEwCcCLvTJKfyvt81kX?=
 =?us-ascii?Q?wadfRFabXd/XWtItygEIiqvO/DCkty6+MrP4rcRCeipayzg83rXZdx1iME4b?=
 =?us-ascii?Q?FwK+BsQ+jCiqPKBSZtD7qofWcHyRlGfZUDCmsw2tFTBZp1xM1cy2QgRDOmxz?=
 =?us-ascii?Q?eGZsoWgH1cow7c64W2MfkVrFQS8evFiuJXSqcj0oyiFiaX4nh/N/dA2BNXAo?=
 =?us-ascii?Q?zts2w4ZxNry2UN+RHSIxz5VyX6WI+A0j6CzLCRKQmFL9VSWmcUkTP04M63Qt?=
 =?us-ascii?Q?kpNwS8gtK2/Af4m2ViX4fkW8PyVAVPrP9LxUYL9zk5p9zXu7WALYqm4sGpbk?=
 =?us-ascii?Q?NP30sAwsZJnLT4MS0G2deZAnzYnGhNF8Zv5UeuoUGNxNK5Npm+vESEg7/hnL?=
 =?us-ascii?Q?XmTnvsCMs7aOsJQ1zyXRhE/D2/fut5b360N6zNhTQpy+fQOOdy9vZa5+Wr0S?=
 =?us-ascii?Q?rN6WQy6+rELa0eieO4e2yLuX7MPiAs57RhaB5dArfCD0Wng5/4NPjEcmLkZj?=
 =?us-ascii?Q?jKfvgzRGQHJ3C1D4f0T7rPG9Vm5VKOPpE879qCk7dA6OJCfc0JwailAE2WjS?=
 =?us-ascii?Q?MrUTNpE5RC32nb/8AvNfW7pxFMagqXiJkBRsQbGGVsfoxmOh6Pdd9bzT80fx?=
 =?us-ascii?Q?g0YpGM1Yf0+HVYHl3CMDIIt0SREcBwfKNTCb55cm3WZiNW2eIezOyVIaRRUh?=
 =?us-ascii?Q?NtMDGVBuBbGrSLWjm9T8w8v9WWRmESGSQnD/9bVAFm6+A3WPS8yKzATysGLS?=
 =?us-ascii?Q?QgFeTfUfIzZs70RYTKxj4MU5jBnltjGZ708dBaaHu03KUYprI9v2dL/6juQe?=
 =?us-ascii?Q?EhE5lgDda2sMoG3xjAOq5f6X0d7dU3LlFN03Eb4v2KINvQvJphueO0jTf09E?=
 =?us-ascii?Q?rW570Xk1QpruCND94pStZmAcTNuQhqKe1HZVZGSnFg1QVv7gy+p16lozkl9B?=
 =?us-ascii?Q?DEvYUg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f856c9-21ff-454c-2b87-08db78b2063d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:03:40.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+VmdUfx1xYcwNGbSjSI07Wfdf/iYKzS03wP41tbYziRNiVkOPp4bzjo5oc7vwnBvHSnE2Akc4bLCDPyQX18g5qRf3eM5fKP3k0zDrAdOZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4482
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 08:25:35AM -0400, Aaron Conole wrote:
> Simon Horman <simon.horman@corigine.com> writes:
> 
> > On Wed, Jun 28, 2023 at 12:27:10PM -0400, Aaron Conole wrote:
> >> The openvswitch selftests currently contain a few cases for managing the
> >> datapath, which includes creating datapath instances, adding interfaces,
> >> and doing some basic feature / upcall tests.  This is useful to validate
> >> the control path.
> >> 
> >> Add the ability to program some of the more common flows with actions. This
> >> can be improved overtime to include regression testing, etc.
> >
> > Hi Aaron,
> >
> > sorry but:
> >
> > [text from Jakub]
> >
> > ## Form letter - net-next-closed
> >
> > The merge window for v6.5 has begun and therefore net-next is closed
> > for new drivers, features, code refactoring and optimizations.
> > We are currently accepting bug fixes only.
> >
> > Please repost when net-next reopens after July 10th.
> >
> > RFC patches sent for review only are obviously welcome at any time.
> >
> > See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> > --
> > pw-bot: defer
> 
> Thanks Simon.  I skipped looking at the ML this time and used the site
> setup for random German tourists:
> http://vger.kernel.org/~davem/net-next.html
> 
> I guess I'll stop using it and just check the ML as normal :)  Sorry for
> the noise.

Thanks Aaron,

unfortunately that page is not always up to date.
