Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A843E52FEF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbiEUTj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiEUTj5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 15:39:57 -0400
X-Greylist: delayed 4645 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 May 2022 12:39:53 PDT
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02hn2211.outbound.protection.partner.outlook.cn [139.219.17.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2393B28B;
        Sat, 21 May 2022 12:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxlQ/ygfVVPEINRL0DLOXYMdl9sT00YnYllRyth2gly4mi6G9OT6Tiq/JkcTbzIwsSlOd0F4n3F/ZbuB5Y0IZ2Qm6XpImiGfdxSkBJr7P/aWV2pSmGfCoU2xXwW7LgmMiKqfpGFWuGU4Ix9H+lo8RqBsrt8Cn/pCDQ3Fe42q0f6Uci8hZQMzHZRYRJoBgySbFPv7InLbuCVuZBF/gHSLBe0e7lDgZArFRAwyjjidPRitk+S2ltawMCPVLJobS8W1Q77knT4ueg/TNr2j+EH+OPD4qM+Sed7ADsnynpuOI4gw/W68U6p0JssYPQApdHjQRNh70U4FfMwNB4z2BuLxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=oPh1klGPXJWoQL+0vdik6ZeChVZyWeGF4YIZSD5D+wGXEXWu2iuKnNlsBIorz4HeH/4MLh1KuVUwFd69aFuRyWczMim4ZGTKG3qf+Jh5TVtP9we+2t0EGUSERawzUPvunQk6reYI7EnBdSHvHW2//TVSSDcUvhV1s9YOaz2iFwU8zT14P8ZvsqsLxhV2XMaPi4nTid+DjyLXCcmIZ/ng0NMwJ8T4VaESNHCYiQmasEsRadUlQkhuPoa37NRlnyeo2N5/ayaZVb8SbOaquZQeVRgrXgqDd90K6OzoEaGYGo15geNkxUG3wZp9mYPF4FnGoLMkqSRsFaKjIDetRSBXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=WHnNPDuFriuL2nzAkI1mck2cj+/OMC91GgRxuD+N43tXDnPbeiVP4PVZLBPjijJ7ot8mOOKxNtZ2ZQ5O0zf3x03I2K6twMcXnweH7DWmIChF6/t18uekZ4TPnKXGSQ9y0frjfP8iJswRfQ0749GSbItVK6lLuYAFUStjB5/ZR4H/qzQ7m9U3qTYSudvHvzcpDbSQI6xvCUB6RihEOZqRzJ+vvCucD4M1bokc/YQ/SH4F1190HH7+vxO2dmaq0uWZUrj4yxbnW/s6YM9ZXKf5s57aM/uWrmpcDQvS4zi6wIzVrcTxs1g5racvOrHFZPm/elEr3ZhSpmtKcnMTYdGPMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85) by
 SH0PR01MB0635.CHNPR01.prod.partner.outlook.cn (10.43.108.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Sat, 21 May 2022 18:06:25 +0000
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85])
 by SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85]) with mapi
 id 15.20.5273.019; Sat, 21 May 2022 18:06:25 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE..
To:     Recipients <tianjiao.yang@gientech.com>
From:   "J Wu" <tianjiao.yang@gientech.com>
Date:   Sun, 15 May 2022 12:39:17 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: SH2PR01CA016.CHNPR01.prod.partner.outlook.cn (10.41.247.26)
 To SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85)
Message-ID: <SH0PR01MB0729C099185546056248DCE08ACC9@SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 054d09aa-bd06-4dcc-0df3-08da366ff9a0
X-MS-TrafficTypeDiagnostic: SH0PR01MB0635:EE_
X-Microsoft-Antispam-PRVS: <SH0PR01MB0635BBC0862A5718E75F65E68AD29@SH0PR01MB0635.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nTBVRFoLQC9SwW4G6eh49CBemDcEmLOr9uaOxMruhwWCAfTAWIpJQIjEPT?=
 =?iso-8859-1?Q?We+NJUwE0Xn96rKZnN6lLa+4oPnUpMSLwgHcB4btBMfFzo4SXhO+FzvPSI?=
 =?iso-8859-1?Q?T/10v06uAI7UGTr4dkP3pmuYD3xP+bXqzHkAJrWJ9LCKCjEWRPXOqYl9l+?=
 =?iso-8859-1?Q?VvROtXLuKPfJCiAFxYafkffzRYr+lJXDZA2TaeYiSjecvGYx6szMgEwgTe?=
 =?iso-8859-1?Q?A1J5Z8Cy4+wymTlScllABbJlyAbGOAjDD3yrXtkwbmr5ko1CsZqmQX0uT2?=
 =?iso-8859-1?Q?SHGx7TGH+IDZi+OJzFN7K3TTtKlZn5Oa5r+8xlYD7jnTCjajNGwHwnNLZj?=
 =?iso-8859-1?Q?fvqygH4Ej635M5ZHdhuoQpAWor6sqZAzExKLikW3+VUwI4sSD3YIM5Wrxx?=
 =?iso-8859-1?Q?Bc97hdK0ST5LKoU2j4OvHu5xHUbfHwb4BPqYA8iPhDYR1W5buYlQoyMizN?=
 =?iso-8859-1?Q?t4pEQWvZ/BSk2nJaGY/iPczTQLYLJYe4rDlLvt6o8rC8e3JxjhDu3XEWMh?=
 =?iso-8859-1?Q?CSjBtwejbAij4/FdqWPgdAoKhJC4qcYUNNmMKsNpP+NktgOArS6HFRt+w6?=
 =?iso-8859-1?Q?DgUvs8b+Oty9l8kiEvYzxquDXwvZ+pG8HreWJEzfHTeKaQdH/FrN9CInkw?=
 =?iso-8859-1?Q?FP8vlNnyFAoPe8EtklX6kA1WiEFhMadRZhdt2GShOc5TJuZGPDo9Psnh9G?=
 =?iso-8859-1?Q?tuNyJzylQID2F76bKhczcXEubVSDbbsCV17nD4jpxA1Q8ROU9lItMCxdkZ?=
 =?iso-8859-1?Q?8e7Jx/PrvTVlRFTkg/4X+fty6Kyc0QVK1LKmCa5cxXXWMUHxstu9iZw8+y?=
 =?iso-8859-1?Q?9pskNM1pgQVj1P+GcThBwuUJKfyy6prFJ0PKwVd847/iDZyzETKu0PZ8sg?=
 =?iso-8859-1?Q?xEfhmBwd03DtStYuquTa4xYGGqhtTsMLBWEgp8HmgbU7de+b/wXi6ufAbV?=
 =?iso-8859-1?Q?syx0fUjPMpzke0lCpLGjTjNoDlIkXYrQ76EMBb2Ryx1KYyxJbB80NnD70Z?=
 =?iso-8859-1?Q?SllBKdG9UMo7QCSTBEWY2ij+2X/waYMsXSc5Ph+4ox4aN4x5NqJeg2eA0Q?=
 =?iso-8859-1?Q?Mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(7696005)(9686003)(4270600006)(26005)(3480700007)(52116002)(38350700002)(38100700002)(2906002)(7366002)(7406005)(33656002)(6200100001)(7416002)(40180700001)(8936002)(19618925003)(55016003)(558084003)(86362001)(40160700002)(6862004)(8676002)(66476007)(66556008)(7116003)(508600001)(6666004)(66946007)(186003)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gg00/qmx7frMXAjMpazWJYG/cGG+QL3LQ6yx7w330QrKDoZ9JTelPHhUuJ?=
 =?iso-8859-1?Q?MqV5KN2qTxNgrOlAM0U+LzMOGnEPOcjmb/o6UAMhBijJFjFQDk4gHGilt5?=
 =?iso-8859-1?Q?oJj+xO+2t8siNzkCLiaBG3WEXK7frkFavNOsYsnA4xeknBwEVmq+8RTEsO?=
 =?iso-8859-1?Q?aE5Y2+RIBApKK290nHRzF1v7GlCDQPF0d0ZSqfAtbAde5gneUWV6mpcFRA?=
 =?iso-8859-1?Q?RtqHgoxXHkf5qkrbhvkRfmH6rOOeh8e8WpbvWaMwJZUzELNxwrMiPiV1vt?=
 =?iso-8859-1?Q?sGY4gqSbpgURUwIDUkfjxMP6BZG8wdhMYR8FONAzF5aY2HT1qcDdQs7LsC?=
 =?iso-8859-1?Q?PlDqUQVp3WisgqbIlgSp8lOFcihZIjkl2XwhaAk5moJIud9THg8xO0Smj0?=
 =?iso-8859-1?Q?OcuWW63VVKCGf/4iq7ZYthc8mCYUOVzrPPDCfgfHJR2XzzKt6yt56EQEI8?=
 =?iso-8859-1?Q?BDF4cigTJxbgo3NrqedT8wJv5p7stNqRWOcYkYOlhmpSaj0SFAzAQHvKHm?=
 =?iso-8859-1?Q?HdMb7fEEHuucXqZ1V0O+9Y9AgpLgppzyyA0mpXfwhmxCGPJePitKUAtJk2?=
 =?iso-8859-1?Q?dvxclVSH4qBJhmPd9dHfb/dVLdclJ/2G6Xulh6kGHwVekuxXLA5l5JKC+C?=
 =?iso-8859-1?Q?CodOSEmgk3j7u4Lmh7Bb7c4PxTAyq2XwiEv1C2Tmrt8ObZio1mxruZdu7/?=
 =?iso-8859-1?Q?cm7oKNTcGmpdDwCOmXp6XXMCwohJBieJD1yLSbloCaoJo4eV50xHOMOcl8?=
 =?iso-8859-1?Q?2747XHqTEKmJ/Lo6TZAgTmSF4H/4yXLYaXJDNyMLMZnqtpLXvefalO43ho?=
 =?iso-8859-1?Q?jFqOy/8Ha4+OYvg1bH/Cx69ecL3TasQULkLwIPs31bCFDxYN8tFLyzI8Ay?=
 =?iso-8859-1?Q?Bvp1qfLXWhCYiSxdnsO6jZFRpSJgxpo5pPkdd+kZ4D57i2dtkpcZ+e3Omc?=
 =?iso-8859-1?Q?vpVj2JejanJfF7dwkk8le/nXFjWKGG+237hRhQIL3lVWi/kbbiTDyyCKT9?=
 =?iso-8859-1?Q?qwOp8IDSZli4wIHzFLcyyUDUkHEwKXWbFyrqd4xSgriOmiRPdbn4KIQfG/?=
 =?iso-8859-1?Q?5jwTQR+V1D7hLPgafXGI4hOCp1XoM5/aDDxGUgfQc2gJ5OQZvwK6UboCKI?=
 =?iso-8859-1?Q?WNxiXwCQ3BLS++z03n7Asct6emHyPvgceLfjpii8eRhYqbsTsNZvWT1Pf0?=
 =?iso-8859-1?Q?tNO8z7zl87+a4JUybGe4l2HxBxyCnES0N7aLR6/QVDQEJB1hiLs8FF52Hl?=
 =?iso-8859-1?Q?O5GEXFe7LzzvZtRpc/68wgc4W8AiA+orE/CIQKiJLhIFQ/13JW7GmmMGiP?=
 =?iso-8859-1?Q?Ncq8kPI8rZBjjn8onHcioJruFfIT/1RN5tRn92BRQp+OuMa1r5wH1FNqn0?=
 =?iso-8859-1?Q?lsu3PWSi94nt86oMW6Drk6+eV3Jr11oijBsURb3GVdzpVuludjtCNAj59C?=
 =?iso-8859-1?Q?BL7/knTwWxXBLOI1YU6oLv8BHuwADwxnByxkw1TxDaSbltFBluAimUuseP?=
 =?iso-8859-1?Q?E7A29t9p3GM3vLYEoNnJFGtOLpWk2Z/QlaUXEVB8xEfGwxzuI9VWi6MDZI?=
 =?iso-8859-1?Q?DNejtfqES/Txc8ruDpK6u+x33/ZxUwYijfn0RsOtzNRwj8a8RJsNKGMkhW?=
 =?iso-8859-1?Q?OD7+eRNSmt7xSlYF/8HnPJQ/sn/FdIjE4alRgSOK35UVJvjjHrW5bOk+FC?=
 =?iso-8859-1?Q?P0JogiCbAbw+2aeXIXu/99XF8QvAJ8/WqRyhUFkxBTMJVLVZh0QvRUa1J6?=
 =?iso-8859-1?Q?BpheW4XB/UArAYGWd47Utde1g=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054d09aa-bd06-4dcc-0df3-08da366ff9a0
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 12:39:38.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWSgi5LZh61AbMJ1oyKwdg1f/5vonCgmw47j+jrumONtPndlfPx584af2wCFZ9V/3yj8Vo3EricyGDZIrFA9ZuhwdZgGbFkuaZJGU+72IdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0635
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_96_XX,
        DKIM_INVALID,DKIM_SIGNED,NIXSPAM_IXHASH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4864]
        *  3.0 NIXSPAM_IXHASH http://www.nixspam.org/
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  3.4 DATE_IN_PAST_96_XX Date: is 96 hours or more before Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Can we do this together
