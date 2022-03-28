Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE964E8C73
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 05:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiC1DMS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Mar 2022 23:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiC1DMQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Mar 2022 23:12:16 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45B35A97
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 20:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648437034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DkU+mU+GhDEs6LM8/HMq+F5uCetXHIy9elX/iw1YwcE=;
        b=Kr6+OMhjD/ayZMwlb79HOQb1IAA4mRxoBB2MVmtZhamHQMlROvdSJZEAJWHziTfQj5oe7N
        3ziqEBEvo63bHNlgvb4XzsHIDlpumm8iYFWjCZCwK9HKex4xsPe3bRwdnXsyDgGnJkJa3e
        OtYYmGXYeglFeIdpVPJeLCY2ZnucUhU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-fpYbqLErNFm_SJjZCH6Y7w-1; Mon, 28 Mar 2022 05:10:30 +0200
X-MC-Unique: fpYbqLErNFm_SJjZCH6Y7w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKhUziCYDeLcFTWePqxxDd6He3Ey9pKioTVtd4aMzZLYg5n2Wjy53j2AdJ2GNFwDb8Mg0qwd6NH4ml7P+uoCbz1mu2aer4EK+y8ngW+g2uVDAYgcgPrALbMFd3t5TkexifubESMaKJ6B0RWJnPk2QLMDxMIVBwyXe+l4S4plGuIwKKUOa+Zos5n0Sdixm9EiHbPYfq5Ltj2OUM9RUa9dXEd7UNSuVfQtFlqHyGDQEd42RnznCk0Z9iXt+Imct9Lx05Jd79tiwUpKqXNWSjzY3LzqE1t0Nbspeh5wwQtBY7XQ4/W/TljqT7lV0wTL2mL4Q6EETpSSeaCXFZbq4SZvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkU+mU+GhDEs6LM8/HMq+F5uCetXHIy9elX/iw1YwcE=;
 b=MKrj5yjGUnl+Gcb7XOt32zZoRz7qh2M3ug0yJcjwucR7vXMCjPIUctYeB+Mq4ixcSLjmOT0GRCSyPGvvZYiCPuAlDlWuwm1aRnhFaTq6SS3RRQjfKCzDrlp0LdpajTqvZA7Kgpe+4xSTzeFNmgD9rkYmZgs9+AXBlNYqx3klfVAQvolTPVi5GTKFFCzOmHHTGSKcPwzAyCbbet5C071ai2d80Af/Rvbhfhl047CHFJKuFnT5+wVC4PzpKJsND3HPUC8NlhXumOIenFhkfDH0XjnpiFmAnkndCFQ5taGX8WGnezQ64afcPuNXBiWrStoOsC6w1SmcM+Yuanbr1rwOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 03:10:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 03:10:28 +0000
Date:   Mon, 28 Mar 2022 11:10:33 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: x86: add 32bit build warnings for SUSE
Message-ID: <20220328031033.GA16727@localhost>
References: <5f22f4657cd11e541ab6cdbb7782b55891f63241.1648115583.git.geliang.tang@suse.com>
 <9a8bc94f-b087-c803-e8ac-9f2ea1ef9c5e@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8bc94f-b087-c803-e8ac-9f2ea1ef9c5e@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b79e1e80-0856-4684-e4be-08da10688287
X-MS-TrafficTypeDiagnostic: DBBPR04MB7850:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB7850D53EAA6AB09AA63D1297F81D9@DBBPR04MB7850.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grBcEvR2VnWyIRXsUIcuFpeNBWZhnUf5oVQcr9TQFbnX7oYRq6DKah14XXEzSs3bWPzUMsKu5hISXGURnvYsu8HLf8gU055e7slnuiINbEFMk4wq4NEOxi0hqcRcAgPpGXOF12wGdym4fgJ9t5nfvrrSr0xAntuWBDk3XLM18CxGht746q2NJmeXAC3+hZ3sP5a0LRspgRwwWJxPTyRCkZT60bawLwRftCSLO1YB3DX8Gt/8Cn3zo/MWc6SABBfov7OL13UG05LpOz7XHBIZtH3YLgQgKU2YvtjruBUk38KS192eQXF0O37zb64Z1UG2f/wCoZkdk/n4jVk/8IdQ71WHTYtYwU/B8NrfHqLYml117dBLciXRGaoCuSeYGX4uAYSuYklJPSDCIxWEab3kvcKBComvx3N1wVk0nk/mat+m8cdZAOEv6EjTXBMheTfAIOJ9zPZulbJVKBzNwJgL6B1Md17nffmpH98uS4LlBCGQxLX4QWcy/UXH7fKRJJRVHb26bIQ9xhcmz2OI3LKQwYKwZB6Al3P5ZKkKLoiefP90Fyei6QTwEtb5Z8byXWE0U2mSDS/7GWT9n+GH8844P4LhhIxUrpug7LjEKpCHHBRnPlZz8eO43pksiXMbzZJSAwvqkS4JDAeJ629lx8ThtDduQEeb+t2G/eXTIMtubVMQm48ZB71Gh0aIBWaI3K8r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(26005)(6486002)(1076003)(6506007)(8936002)(186003)(4326008)(508600001)(6916009)(38100700002)(66946007)(66476007)(8676002)(5660300002)(6666004)(66556008)(33656002)(86362001)(316002)(6512007)(44832011)(9686003)(33716001)(2906002)(53546011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fq+qJF+mR/ziKG7X6h1LL0YzBM8mFK5N3zly9lF9bQXhd+NarxJAH7WmSUwN?=
 =?us-ascii?Q?/Dd6KQ8NsEj3yTU1qY9LZfuuVNE85F37d8CB1YwcHdil9KQiysd2dQoEE/nt?=
 =?us-ascii?Q?B9/ZmGJxPn2AbWEU1kJvgYBy/P+lEj04jq7DtxbUIrGYdTgCKVmygB/6PPWJ?=
 =?us-ascii?Q?IPY0HH9mGs59P35jL8n+K58ipbNgA49BUkVsKF0vCmnwjddf2MwuRdBsvMLI?=
 =?us-ascii?Q?4GhmpTBw7KA3GhLxXEwj7kdhlm62Mv1/e8KkUUWsnCNP+33yYRKghPvNDcuH?=
 =?us-ascii?Q?98hPWjBeMijlnpWwsQnY6sWte2zDG9OYicwbfIVIckGMpLJVJYRlM/7/gW7g?=
 =?us-ascii?Q?Ch6OXpCkouPrdASqdl8Oaipdn2fcznFhE9P+TnxKLYKSjKrLZviFRxa3v8eX?=
 =?us-ascii?Q?11mYTBJEl46Kp/S1agSFvaBRr+j1FtSHf0hWrzzNN1VrlHhr68HRc63xp5mO?=
 =?us-ascii?Q?vgVr8DKsjnj36IbYAHxS9m1qbk6T1sUPnWnqTx+AWXnLzwxaRqxcjnku0suB?=
 =?us-ascii?Q?oe1nsY8cIpajv4FMSYGxTTl37SCtZdlmnt7r53nlaXIJakDdy99et5H+Q95R?=
 =?us-ascii?Q?aQSgdhuyOwkGarsTPh8ekTlxEd43w0TzHp9vi4SpEIMDzYHo5flV1Vr0iC8w?=
 =?us-ascii?Q?6k/EcMu53Yf7GGWqJk3DL0QFOTT+le51nR94kkUGRVDl9mdyMPr2kyd5u9i4?=
 =?us-ascii?Q?Tj//lW9vFTJAorKqYFTB3Xqh+jBKgcO0TURcFEnQ+xBKJIG3Sfrl8EfYQjAB?=
 =?us-ascii?Q?ZCVu7ly3XXQlpVXYXzDEPMf475I5Aeu/Si6DyDkiN592mb5d3212YZ/9roa0?=
 =?us-ascii?Q?Q/51ECb40UKCEsjaaBK6Nf8vX1iy5+3rWWNbnSLS0CN4OJ1KMikPGjrYEZMz?=
 =?us-ascii?Q?xRuURniQDfeS8IpRH5gUnRLRbDGFzUbSZGBfx+DhFUUtrNNk3i+dFz62gQ/B?=
 =?us-ascii?Q?qcVv33G0nA8g/dTNe2cOoyoPoa9whtyCHpeBtAbvy9otmXSepFx3NqSAH+IC?=
 =?us-ascii?Q?GCJNBXdbpaaqqs1PSU/VEGokD/rhmTVW4U6RKTpI2e+YvxynanjDwekd1fNP?=
 =?us-ascii?Q?eUbFzCX82rDRVJI/b3/Lb7pOllaSBMl1+I66PmFCxYDxWp+dkmGKKqRjyuJB?=
 =?us-ascii?Q?iT1ZuasutlSuBB6uvUW/GzXxWqL0fSsw+TId4ObaDWDOgv4Y01r7PI9Bp+zw?=
 =?us-ascii?Q?AfLzwOx06mZXptbAqHqH2LirAPIz2wHh+TIUg1fHJxcdsyUeOmivpGZYQ5pr?=
 =?us-ascii?Q?ENKAxDTz3MiTT0wD2PboaF/xyAT/Sy/bCtJC2sX01qTThlK01Fg2mpu9o+LX?=
 =?us-ascii?Q?OW4T2AmutoxqXU4SHG9jXhuXzLohgSi5RvWNxuXxAOdp57scCv3FifePpqbC?=
 =?us-ascii?Q?gdkDb7ZrnCo6U/BAFa0TOR3xagzpAUzoEr+Fy4q/PvmAuTciB/b8WbtJDWo9?=
 =?us-ascii?Q?afqKgCUlYG0T2SBuIWo/1hB1TExiLcHnt4fhXBTGofSCwTQnlz6hU0r3nuXs?=
 =?us-ascii?Q?egyWu4B8JHiX9yVbjBy3AdnioJZqZ/fIOCnBlmEbrxBRf+xCiC64wcsEUDwW?=
 =?us-ascii?Q?XDNGthWwj7h5tffes4eCI1LJcF9ANULNoikW1Fd+hBRJwVVTshptDkbr+0jn?=
 =?us-ascii?Q?R//du51ygCsYQnsiDebwzhnXHQ9Z7nC/d/di1Rm2moRRdpk0PgOJFFqRpTgx?=
 =?us-ascii?Q?muYCwhUjxw9Ao7cST9QfmTT/0NTmpqqwmqIjIKojn8FC/OLGMUY87FJbFw0l?=
 =?us-ascii?Q?e/zOnQWDjNoROAZjWDjNLK4o0e/kCdY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79e1e80-0856-4684-e4be-08da10688287
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 03:10:28.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXPEzSwufWoGYJmq2koK7eKRy+ReQ5TffVq0IgDS7ctIDndU3ffMELub8QYSyRl/FWY3w0NhXpJQHCGrtLSjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 25, 2022 at 01:45:13PM -0600, Shuah Khan wrote:
> On 3/24/22 3:55 AM, Geliang Tang wrote:
> > In order to successfully build all these 32bit tests, these 32bit gcc
> > and glibc packages, named gcc-32bit and glibc-devel-static-32bit on SUSE,
> > need to be installed.
> > 
> > This patch added this information in warn_32bit_failure.
> > 
> 
> Convention is to use "This patch adds" i.e  imperative, present tense
> in commit logs.
> 
> I will amend the commit log when applying. Please keep that in mind for
> future patches.

Thank you so much for your reminder. It seems that I have used the wrong
tense in the commit logs for several years. I will use the present tense
as you suggest in future patches.

Thanks,
-Geliang

> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >   tools/testing/selftests/x86/Makefile | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> > index 8a1f62ab3c8e..ffd7c1fa2c9e 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -92,6 +92,10 @@ warn_32bit_failure:
> >   	echo "If you are using a Fedora-like distribution, try:";	\
> >   	echo "";							\
> >   	echo "  yum install glibc-devel.*i686";				\
> > +	echo "";							\
> > +	echo "If you are using a SUSE-like distribution, try:";		\
> > +	echo "";							\
> > +	echo "  zypper install gcc-32bit glibc-devel-static-32bit";	\
> >   	exit 0;
> >   endif
> > 
> 
> Thank you for the patch. Will apply for Linux 5.18-rc2
> 
> thanks,
> -- Shuah
> 

