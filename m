Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7473B0F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFWGx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWGxW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 02:53:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2091.outbound.protection.outlook.com [40.107.244.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44931FF2;
        Thu, 22 Jun 2023 23:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJbuoUG+45zbEPGhmilSbGy/xfmdV99w8TGSxmYoVW3pZaxGkwBV2N4hYE0kw0AvhB76cSL+JPZjamCBbvUEzCA6RhYWhnPGXw45Sno11BT1O6yVSfE8PawfS+bDxmj9tJT4AXgEz0/x2HYjMoLGTS6h4yI13sAx9msG5ihwiuTMdMI0LO3wv2RtPaF8VSp5z0c5x/hIlvvFqFtBguto50bRZWcahPfDNbs7TJpxi0HLrcQOlxOy3/u/GsTBYEjr7XM29Mlu0rmlI/SFKx7ZkTslIQbeXvGsliPToCwRM96HHz68oKIo29fGNkzEfvjYQgH+uYtYw8SuDycPcPWGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N876VrQO2M1qP/rtJ8ppkVe232DR0bbs7AZtD0Mts8=;
 b=K4PsNQD9e7aRMcN38OewqjJ+EYktOQ21MUao7YcEQhX3vdSGsG+1rbmgpqMnybstvacyKlJRti7ByeKxYS4kpoPSqX430ivJn/PqaFWM5nXSMqhJzzZYC87kJ+L/cXDwaBMaZbosPJUaADVDf06APiVtKw/0jl/9k7WEbXX2f1r0esfIzyh4VIx8/hoqHiEn2NQLnu+bzBsvUk3eloZRSud/1noADwCK49DbTb0KhL2dyVJ2SRw8xVi6y421tj+hQYJyWTPIK86wILv28HewxZFZbzBcOxKqG4HYe+9UxmGodnZeGLsWqzJZNR28n5iIM02hmcM5btJj02sFIOh/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N876VrQO2M1qP/rtJ8ppkVe232DR0bbs7AZtD0Mts8=;
 b=MV5jLlMr0jlgtxbIEgaoyn5imudJUHldG+3cRWDou2cnEyTbRfh43/nnC/mUSeJRVyUcz9cVYC0H6ulf0ceZ9XqhVUy3P6/6HsbXgrcSfLY5sU/dxt+PqeW4xFmmyB+qkh79ZzYbs9mq3z3YZngk0db7txVZPlrjTxPGyhh+UXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW5PR13MB5948.namprd13.prod.outlook.com (2603:10b6:303:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 06:53:18 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 06:53:18 +0000
Date:   Fri, 23 Jun 2023 08:53:10 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: remove netdevsim device after
 ipsec offload test
Message-ID: <ZJVBVk5UihR7zjnD@corigine.com>
References: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
X-ClientProxiedBy: AS4P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW5PR13MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e7f7f6-4f74-4e8d-cbb4-08db73b68664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmNoAIZlC8oVVBLP/etcO4FZQu7rK6hpWaZTm64dNRFVKsNIXjTMvA1tt4FDkPXyIFHmtuRvU8X9lgcBiJBTsM6F8154R7y8Nt+qfvX90kTmC5rLpO9vOFcERzredLXTXgghKyCIQn0ieasKMUG1D9VBwgIRYnWdt8YY49IUGzA7NFUS+BlfRz7qsKPH8hIfCCVjslS44Kb2CAH+5JRh/6uj6Ynzp6+8mtPFJmm+O4FPHpJOuDBqTaCJQUNbfgvIQdUCQTmGsRkYuSDneBWV7McA3z5wd0olsGBC8EMvbdvWqaJZOWoDKr4NfiOTvJSiXTNbASKNcFL35glr5NcJYtE1VNtLHkEYuWjIGQxsXR14rNOLMmOVr+vnqckA44navupQITBvRgwzzxPfglw9VL1u1cRric5j1KhPTnqGOq4jwMF9c3PofLyCPCJ9EhxlMdySFK6ggpjp72R+LNa+yNOITkUSRA/DUxACGti6JtaHWw85NmLdbZlJu2oPUQVkRwYVxVYFBBLwoiiXKHtoJCAw9zpRs6jeythp625BicfdDOWHQS8Sh43Bky2M7HfaLWP8HbqwZdsFgaikIXTdrEBroK6pExakrxBlxJ1TewE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39840400004)(376002)(451199021)(86362001)(36756003)(6666004)(38100700002)(6486002)(186003)(44832011)(6512007)(6506007)(8936002)(8676002)(478600001)(5660300002)(6916009)(66476007)(66946007)(41300700001)(2906002)(4744005)(4326008)(54906003)(66556008)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQZipHehABKnGKNCMbdoHnFjG6zdmzqqHY2XkIKu6A+GzmwrTcL1TZ+8lOXw?=
 =?us-ascii?Q?d70vvjJKIBfKFG8VfB2U6ryCMKBNFByNJtfcTQxvQAdWY+pfWH8Vb6HbnE/H?=
 =?us-ascii?Q?jDNyR1du8TO1Y6dPI+efucireugjBYPfKgDWmpQOXfx1pcrYu0KLmEMPrU0X?=
 =?us-ascii?Q?cWMpsVYP5oFYIt/nutKApDUd92vKm6qhyAkB+KwgOoHZtFEhDUuNKkLZuyRb?=
 =?us-ascii?Q?aYmvNIy/Ql89b6TNGO2piFiE2pBksyULOiT0+afacEkBvxQTqaZX7TdOJmZ5?=
 =?us-ascii?Q?px15HHfwTvqcsotSV3incfB0jhdhyl5lS17l0TSZHp2cCYzO7kdO72Ram9/H?=
 =?us-ascii?Q?RgMCJQK5iuTt0KEvZmzav5041/CFdLThDgmeeX2dW/UdX8tBkN1odben+qce?=
 =?us-ascii?Q?dweTLjpsW+1BiQl4GSTMy8JXG+iFF+l5pIPw8NptFGHW9/QMzsOC9P9lZ6a6?=
 =?us-ascii?Q?kXxFvAV2akugSufXBHTe5pJaK+aJuTnvgDmJTahE5bCPurqNiRgeopkJFSdu?=
 =?us-ascii?Q?q1wn3qUIYr4w+S5M//epB+TRrOMVu2Tlbay3GV8wMbanGOUnsjTWquhTv5fR?=
 =?us-ascii?Q?pwr0VR3MdCkNqAbYz7gbDoonFWQT6dS+F2LWZZzQeLuvhG0ArNgNsg7ttFO6?=
 =?us-ascii?Q?1c9NoObDMTUkMhAyFzTEu+1xoLpvE5y7BIUByHBgDzEfrTYZnyLN2f6028pi?=
 =?us-ascii?Q?MbOWXM3102cytpt9OSZm5egd59XebgN0i111SLbdYxDCZWGtUqblfBA2eU1S?=
 =?us-ascii?Q?oD+V/ULVw+c1pZf7gihcdID0BEIWaFXHmxZfoFQpULn9pSFkRL8EctNwuFMn?=
 =?us-ascii?Q?glf94ej2tKOko1iO9sVwFfgLTpw2mz8Ev2R9qfp5cZA8QUQ/cFGoq2+4MNoh?=
 =?us-ascii?Q?j1E0e6PP8If/BswfVsExEU8+Pn1zOfFhQk1HBJ3NPFYzzeX9pkU3WzUyUO9m?=
 =?us-ascii?Q?TT601QXdwSrdUI0M/vuoNkHg/cAn5I3CZbgQXQ0K6h69OGYm0tkpE0w0H6Sz?=
 =?us-ascii?Q?qct2/YjM3ImxGq6LmriQ1hgaSO+tsFnWESjCpJmSlpshihXRdOmt4pBBOLqj?=
 =?us-ascii?Q?2WV89r06ZuJlVuKb7iv57BwjVlXLJWhoJht45pu1Zm0W7wbJElJHF/GoIbqI?=
 =?us-ascii?Q?Mme5xIhjFDamAWwnfBx+J6ifad9e2FNf4qsFOWIMNqVSgv5SRr0tHvTseUy/?=
 =?us-ascii?Q?l24JJlBT0VfBAIBmArovUQ1jJh5H6myTFsoTpr/MovdJ77r+GadvQKajjanG?=
 =?us-ascii?Q?gDyLwrB7MxUYSL9U5Su6BfdJYO7SnHnSwFLWkaXITdjsOrExGX4udBcvxFk8?=
 =?us-ascii?Q?teRSrruDLPlxxHfA69o+TphhG1m17zebJd2vvGU7ryYi56RrbP6zbyTPbb5I?=
 =?us-ascii?Q?kcN59+KDAKtmWxs1YNiQKE/rHAvUBymSizYDiZD1l86zSreE+tyDKSPI/ktF?=
 =?us-ascii?Q?C2Toko0SHchU69sIy+FY1Dg2rB5OuLPThK1tarKnrHqgzcBLNUDAA3VBuMaC?=
 =?us-ascii?Q?LAZMZkdcWwfkP03DsiZehJQgKHj0SD2YL8E2g4kAva6w0byuVBXXXT8D7cyz?=
 =?us-ascii?Q?vPOjdobkjJTENjtFc3cpyEV/V6UmPoT5Px9fxph9yxVbdh289N7yE3z/pAy0?=
 =?us-ascii?Q?iyZ0yB7rWH6toaqYVv/39BM7KvOmBMLBX6jfuzGKOFL0hXjhNvQLgszl9NSk?=
 =?us-ascii?Q?AYz++Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e7f7f6-4f74-4e8d-cbb4-08db73b68664
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 06:53:18.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eucIWcFpT3BSCeflx692AZ5CImbmHu/Kx+fSiMfsLpuD22EAcrI3WfFucTNxMrQGLrh03Rb4PubStYZTWUd9pJORM8U/Arw/Uq6I09XXidY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5948
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 22, 2023 at 11:03:34PM +0200, Sabrina Dubroca wrote:
> On systems where netdevsim is built-in or loaded before the test
> starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
> created during the test.
> 
> Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

