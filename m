Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF31BA410C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 01:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH3XaS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 19:30:18 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:60192
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbfH3XaR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 19:30:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mkn7tztWonQXR6p3o+nvqQkiUVSpi/2s3px1I+cIfmztMxtFAr9zmR356LjXRTBlqmdV5NS0U93qNq7d5SIEfsalhlqdF2I2wAgECB0/p9wDpPClznVQGsaQLkG11JqDkH+9wElIaw9sfPKv5DYNLrAYx47nrKm9hNb+vovDc6yacgqKXAUREsB7CqOMVt7g5YrbVz6EWKh9uRFLFgv7qPkpaO/qA6G0nt/2CUysYMtcygTx3qGhYvP5IIBUELFP1rkAItGQAh8gikUr1CWOG2TsffR/SFAhP+jVBQl5sRsGZe2z7/SfG0pJY2TPojr2oa8svCT66GCHaG9/D3aR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PMNBV3gMDyZQMtj27wOiDZXN36+3TRr/2z8zgeJVJ0=;
 b=jRqhd+BV6U4Op7GdgWRLldUKObTwi75rditxLVlvCUdb7sKehaIIJYIIBoSCQ0MNCb4qVVQ1m30NuhI+xlticeTqMt3kxtHr70EDDTbEXugvKFbo5V/hjxZx7uhOZ3TMNXg4OzPEy1hSTV5CcLASBm5Rkaf1TqLNN9QlSVnQd9w+u7er+5b4eDsNb/o4mvPuC0RiAV6+IdDd/5ykVh/8YDTmXyrEHA0zk0Htpe40l9oLllwiXbzIkUsiNqHG+bSByMg3Ah1k07emprdf+9edsfgUYylUxyT5dfH2NClgp6BQ1ZOOWqHrRFm8wK1Kf2jpbdWMgvqtMdFCYb5vaBA51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=perches.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PMNBV3gMDyZQMtj27wOiDZXN36+3TRr/2z8zgeJVJ0=;
 b=Bakzpgd9Rd8mEJGUrshuB/w668cIvbV3my7bzMiY8NS20PWXuLj5EXA6e271QVZnbn5zDquQMr0PIuAKT6LWPkuCjkx9rGkyjCjKdcsvY0ey45gEl6SUGQrmK7HllnvVr7Os13wOhSheBdP6b8u6PkxZoe6sfq/7Q8h3rIm4cd4=
Received: from CY4PR13CA0039.namprd13.prod.outlook.com (2603:10b6:903:99::25)
 by BN6PR13MB1826.namprd13.prod.outlook.com (2603:10b6:404:146::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.13; Fri, 30 Aug
 2019 23:29:34 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR13CA0039.outlook.office365.com
 (2603:10b6:903:99::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.5 via Frontend
 Transport; Fri, 30 Aug 2019 23:29:34 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Fri, 30 Aug 2019 23:29:33 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7UNTV9t004119;
        Fri, 30 Aug 2019 23:29:31 GMT
Received: from USCULXHUB05V.am.sony.com (usculxhub05v.am.sony.com [146.215.231.43])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7UNTVml025674;
        Fri, 30 Aug 2019 23:29:31 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0439.000; Fri,
 30 Aug 2019 19:29:31 -0400
From:   <Tim.Bird@sony.com>
To:     <joe@perches.com>, <brendanhiggins@google.com>
CC:     <shuah@kernel.org>, <sergey.senozhatsky.work@gmail.com>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <frowand.list@gmail.com>,
        <sboyd@kernel.org>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <rdunlap@infradead.org>, <sfr@canb.auug.org.au>
Subject: RE: [PATCH v2] kunit: fix failure to build without printk
Thread-Topic: [PATCH v2] kunit: fix failure to build without printk
Thread-Index: AQHVXYOHSzY8I+qIqESnE7HuJlTJpKcQk8yAgAIK7gCAAMSnAIAA6NiAgAAj6AD//87t0IAAUmyA///HYMA=
Date:   Fri, 30 Aug 2019 23:29:17 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977A842A@USCULXMSG01.am.sony.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
         <20190830183821.GA30306@google.com>
         <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
 <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
In-Reply-To: <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(13464003)(189003)(199004)(316002)(70206006)(47776003)(7416002)(446003)(11346002)(336012)(486006)(7736002)(426003)(476003)(126002)(66066001)(7696005)(46406003)(186003)(97756001)(76176011)(305945005)(26005)(70586007)(4744005)(6666004)(106002)(54906003)(2876002)(246002)(110136005)(33656002)(55016002)(55846006)(478600001)(102836004)(23726003)(3846002)(6116002)(356004)(86362001)(37786003)(8746002)(50466002)(5660300002)(229853002)(8936002)(2906002)(6246003)(4326008)(8676002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB1826;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail03.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a15656c-b915-4f7d-0a20-08d72da1ea1e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN6PR13MB1826;
X-MS-TrafficTypeDiagnostic: BN6PR13MB1826:
X-Microsoft-Antispam-PRVS: <BN6PR13MB1826D3049349E7185FFC81DFFDBD0@BN6PR13MB1826.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0145758B1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kCKtE67iKSJOI1RDlsHLTWv+uiVAc6Ob1nzdtYziaPcgXfyQayBV8a3EYUD+zXMRHIjC2md7COCe/5ltuJoKupKUyIgQn4kcl6lOiSRhJFiHrOC0m2/AjfVeBixPARrfRLmmiTgxusk7flwUn9lTsD8xwImpzPJjk42rXvXQW96ScY+xoImKasCDNTLheCiRFPBZzftsoL55Unf9NjYbQmctjmoBjm8xYvk0NgCS1wCOJcdx0qUUingxgUpmTInNEy5NK2PyTq7XzOWyzCuZup8d4aznFX5+LFYpuD3H+BO+je2AlH0XR7DIV78hvGrsGToF8IbXNI7stSA6qxtDFKNmmEtbIFJLov5PdeDKX01pylY50GAFHBcteXPTggRz9Kdq5VJT6xk/o8IF6o/8ovmmAGZukHvcGaR8R5We3nQ=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2019 23:29:33.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a15656c-b915-4f7d-0a20-08d72da1ea1e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1826
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Joe Perches=20
>=20
> On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
> > > From: Joe Perches
> []
> > IMHO %pV should be avoided if possible.  Just because people are
> > doing it doesn't mean it should be used when it is not necessary.
>=20
> Well, as the guy that created %pV, I of course
> have a different opinion.

LOL.  Well I stepped in that one.

I don't have any data to support my position on this particular printk feat=
ure,
but having worked for a while on stack size reduction for a few Sony produc=
ts,
I'm always a bit leery of recursive routines in the kernel.  I vaguely reca=
ll
some recursive printk routines giving me problems on a product that used
a sub-4K stack configuration I did many years ago.  I don't recall if it wa=
s
specifically %pV or not.  Anyway YMMV.
 -- Tim

