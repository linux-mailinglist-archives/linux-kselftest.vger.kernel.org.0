Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608137DA490
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjJ1BQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 21:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1BQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 21:16:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2103.outbound.protection.outlook.com [40.92.89.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E658116;
        Fri, 27 Oct 2023 18:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGnP3soB1RBBMiQw1QmFgWbZSCEOjVtAyIIcY3lpHWn7cjy4V9u5NKuA1McAhbH9OGt+1Xp4O+LlyFBPWMX+Yyk8N9zePZCYFZZsKMi+Vph3WrZTQf/epd5DFmZYu9nAbMKmex0gu6c34lN5feKjleTk7Lm0djhZYXgdOzmbcwXCqQbfXAZCHcWpJoZrFIgw0ZG2FqbRH7rypmJkZsIzAi1By9ncSvHUPreJSAEkMaCI1mbbItMU1mzvNiI1RuvJ/k88zay3mdVHnUrWY3cnPn+l2XDdRqBMv0S2dNSJEeK9/+YLoU55U4UlqOTpLHvnvABTOkg21BueHG/mqwDPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7WUzJ7kr1/39hE6hxmLlu+QI6SQsCt5YRuHWaP9kjE=;
 b=VRBO6uaKqLb1IjnBOnV6YVbh1nulm3qxmYbVVz5uLNRX7Jt5/Etzk9PeIhfZX5dAF5Bq1A2kMak+NCDKLfIYFLEefmWe4Foa/ZTiVjssQpqHxkeJyI8HDnEEGyhAMh/GUikUQTNsYz12HlTlVnYYxH3gSje6fiJoWs2AM4uLoKMsSIXDrBUT3dEW987tDqj+uhgKIVSqpObzNJQmMHjXEUfkQ649LumikCCvXrer9xfpmFpYAZ3Jr3tlpfmyDcVswt3FPtwUhDJ+9aXhcMxPTwDedzxS5sJ0T6jMzXn4EfJH6U823IpVIX3GQ8HKsfkxGEeRSJD32PykjbVsD1wIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7WUzJ7kr1/39hE6hxmLlu+QI6SQsCt5YRuHWaP9kjE=;
 b=NDhtJ6qA/NctWcoQh3Zmbmyo358lnH+F2a0BVPmxQ5CLnmWgRZrwoY24j8R+xvv26pFn+DTUVmqIbiqLN+sEQ904/rLZmMJvveqzWHaDfw+i5BHcjKCH8wHGHMQ18XIem0Pk9NlNrsxSnKk1+srqJWmDvr4bKhz17uFvr6eU6Zl13oSfcjq3APGqklnuLR4PtATU5oQi/GVOCfbI6EhaM2AwXFxuSujGFxy1g8QKHCGO6x+s07oLKkuG9KSBObiFg1dRXzJdypJkyxGaCpzQJzUHb4uyL9ysizPs1Hf8RJUWH7LcmlIpyAioE5A84nZgroVC8fnxtzPQ+8QCu2Lvew==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by GV2PR10MB6741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sat, 28 Oct
 2023 01:16:17 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 01:16:17 +0000
Date:   Sat, 28 Oct 2023 06:46:06 +0530
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     bpf@vger.kernel.org, yonghong.song@linux.dev, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        brauner@kernel.org, iii@linux.ibm.com, kuifeng@meta.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: Replaces CHECK macros and
 adds malloc failure checks to bpf_iter
Message-ID: <DB3PR10MB683516C89C063FEC4D94D45BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB6835598B901975BEAEBA8601E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <563d1ae7-8d1f-48d5-b742-989ce482c4f1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563d1ae7-8d1f-48d5-b742-989ce482c4f1@gmail.com>
X-TMN:  [4HdNbtbKo7XXj822lfe06GbG0v8M3hMA]
X-ClientProxiedBy: JN3P275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::11)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231028011606.GD1301832@nmj-network>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|GV2PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 663dbcf2-a07c-4010-0544-08dbd7537c01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2h7dN9zDgoKYKD/RRgNfzd9pBTu/eop+gpT8qIevFwrW7//NUuGBvssaVITFjiSX+ZvTS+iBUSp+R182zd0DdjemU4pLcNHUZlCLBTjkJxwby8SNTwE4bpNaj8bL0JXj/do8Cq5sqM3CQCRUB0WdynhdpVJBFknyeQN9n/o695pI5UI+4FEWUlj8gQ1FBQeqH71uQeUWxNsO4h36qR0jjHS3mUxjOA8UZytp/l6d3NLOy3ZgqXRbp22DwRNMl6PqUQtNI3+jLIO/0NVO2p/ZHKtbnU3wJ+nEFwYnYBsDcovdceitSzmW+EjATUcFDgVlUoBTgMkwPDMQra681Q/cxyqbKRSTtOAMXHkfFGhucbJWIjZ489c5p6wVoY7ZbrEwG+5r7bjKmDW6vfQ74mhRT0uurYspTfH47O56k4G1t9NBFFkb4t0ARVfeUd1958tO2/Vlp6QrYzRK9QbFGWojb3gpQFfesxwOG4FOmfdWeLxNbubZc1ohxbjUwGdRHk5O7yTFPEuQ5rLtC4OaKvHBTVdus5ogWsMGLqX/307CVTskq/Ho4iSoKroNTHeMzRRGjOfBeHhHfw3T3Zmz6nIDP2PN3O4ZU2cX+W9gy6mzI+hQg5QaRdbU3u/lgdZndmgYAzmuexdxFgLyD4QAnkfyuA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leT5kOuzGx6hnpiBEm9OSSpsPxqWJ5023hU2Mga2G99ghZ2nUHs/TLUyAfR8?=
 =?us-ascii?Q?Ktp8YeYYzxVM5YjZAFOrL4hZS3LgQoY8N5DAU8IKv5QvVf6mIeVA9uH2TXAe?=
 =?us-ascii?Q?yFUOa9qAEN2tfttowoN3SmVpFAzR59da3hmFQw1upbNTy5r7bp24bbyGKNW/?=
 =?us-ascii?Q?TiVNjPyHbuYhozy39q5M2ai6nteZgmHjE7OxPOOgCt4EAhhVB+J9NvHMH7/J?=
 =?us-ascii?Q?iFjm5ooX7H+ddWEPuaCaxLWEEMuIok90bBzoLLLQ7x27REm/w393l/hh4lLi?=
 =?us-ascii?Q?hUDk/Y6y5IMVOI3Q3fqaEjRRV8zn8dG8kNHjOxQ9oMQraDU5sh+fGEMNmuXz?=
 =?us-ascii?Q?IyOLIQHk3JEgNeaRyQfIFW+9lVuvkrDF3dnBxTNHKPA120ekUyNM2TjHr0Bz?=
 =?us-ascii?Q?M10VAqCfTY8vwo6ZTJW0TMdM87UftwQItHsv0sXI3ssHiprIZcI9oItagXdO?=
 =?us-ascii?Q?UG2i+MMvH4DGlc/fkUSjrCfOw2ENUlsx0jjSFQbm/cfzI5n1YJ0do1I9JfAm?=
 =?us-ascii?Q?vLBDHr+k7rvCaGmUBxA69UOcoO1OiX3CWpQWaCVdom5DxU96T7lu7rRtASz1?=
 =?us-ascii?Q?WcIIwBXEksxDGRBVZmXTXKJE9BHWOqoWfd0C9z0mHOcebnvqXvyDPl8EwTKK?=
 =?us-ascii?Q?C/9vjL3F79lPU1fjuaGxvxyIuGBSnfx2NJVMRdBeQWiqUyUOdOWuCuq48MA+?=
 =?us-ascii?Q?wHhz4XTpdncAeHo3uHVZxrFeslxF3wak2M0dD42PBLeBgexxwp4ok3V8vpe8?=
 =?us-ascii?Q?tD3YdM/wS9u/U89SUj4BD00dYQsyLWAFI2lO2eG1U2ya11bbT3+dKlI0aUpN?=
 =?us-ascii?Q?le3dduhuYc+tO/Z59d+y8XaunXkmpuVsLIQcgTTh8S8KHnwDtgvZlrjlpAFh?=
 =?us-ascii?Q?uGRHi1rp8MbXZEeTAvbfiSj6mY6EVRlEzUMO8e5P0rQlMopOHkZRFy2rqXSm?=
 =?us-ascii?Q?OeUiIbuq9vCIdweZHWdhJojax9lZ8P83upXvnHipAFqDs2APIpFdg85zfZd6?=
 =?us-ascii?Q?gzW/gcXPuI4rVKAxGV2ocRGN+FYN/yZo7Yn+YDtbDIpO9STR9IH8uBuXzGu4?=
 =?us-ascii?Q?1b4DwhiidW5S1dsWyGmTUvZYN6ByXWJgxS/NBNCjKc0uQNTTixcJ98h3xN1d?=
 =?us-ascii?Q?c2cAmraCPKQME0sZ++UIXIWEn48qviQNQxH6Q/CQE5x3yavyELQP72slI1We?=
 =?us-ascii?Q?eA9e0wC52iMG3GNjDcsw0S+6ZE3IlbN2yBKKOF0bLpaqGmN6iC5hVyz+9CQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 663dbcf2-a07c-4010-0544-08dbd7537c01
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 01:16:16.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 25, 2023 at 09:37:44PM -0700, Kui-Feng Lee wrote:
> 
> 
> On 10/25/23 19:03, Yuran Pereira wrote:
> > This patch series contains the following updates:
> > - Replaces the usage of all the CHECK macros in bpf_iter
> >    to the appropriate ASSERT_* macro calls
> > - Adds appropriate malloc failure checks to bpf_iter
> > 
> > Changes in v2:
> > - Removed unused "duration" variable which caused compilation error
> >    as reported by Yonghong Song [1]
> > - Improved malloc failure handling as suggested by Kui-Feng Lee [2]
> > - Ensured propper patch formatting (i.e. sending it as a set instead
> >    of two distinct patches)
> > 
> > [1] https://lore.kernel.org/lkml/3531360b-c933-4c5f-a84c-17edf0592519@linux.dev/
> > [2] https://lore.kernel.org/lkml/7d703c4c-1a24-4806-a483-c02efb666059@gmail.com
> > 
> > 
> > Previous version:
> > v1 - https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
> >     - https://lore.kernel.org/lkml/DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
> > 
> > Yuran Pereira (2):
> >    selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
> >    selftests/bpf: Add malloc failure checks in bpf_iter
> > 
> >   .../selftests/bpf/prog_tests/bpf_iter.c       | 88 +++++++++----------
> >   1 file changed, 44 insertions(+), 44 deletions(-)
> > 
> 
> 
> For the cover letter, you can just put it at the same directory of
> patch 1 and 2 and sent them with "git send-email" at once. All of them
> will be in the same thread.
> 
> "git format-patch --cover-letter ..." will generate a template
> of the cover letter along with patches. FYI
>
Hello Kui-Feng, thanks for the feedback.

So I did use "git format-patch --cover-letter", but for some reason
"git send-email /path-to-patches/" seems to be deliberately sending
the cover letter on a separate thread. IDK why.

But "git send-email --compose" seems to be working as expected, so
I'll use that and manually copy the cover letter generated by
format-patch to ensure it's all on the same thread.

Since I already butchered this thread, I will send v3 series on a 
separate thread. But I'll ensure to reference this thread on the 
cover letter.

I'll be more careful with future patches.
