Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFFADBC28
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409531AbfJRE4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 00:56:49 -0400
Received: from mail-eopbgr680098.outbound.protection.outlook.com ([40.107.68.98]:22499
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409506AbfJRE4s (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 00:56:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgEpyxErnmwyG5cBS8TutWhmgytY3kndGb02/nbFBaDUW/0adEluP6DlUziT1ajJ+Y0XrBCnbyIAD8wqq006Lo7hUL76vqbJU41BijDiAoi8XSGlvH+htIX1jplr8ylKfn7WApJtu7g2aNBA42NC6GQzxDhMuNUzRF26vJULByNQDL/S4IZZgPVbbvNXKLwOcdlICMowNWmiBnEAPgAvzUObFg8m01xbkLByz7maxVYbBrVOqxdew/A5C43iMWcnU/9zDUvO2jj/FVVxay386mcX7rk2iB0Kp43aD+O83E8a5p2PH9MvwfSJQqdRPUeDRHrbn/uuyr6ahAqrG2FvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2riAygWKcPtg1Fnh7u/mT71FzSAtZSdf0ENEeYlM7P0=;
 b=Ans6YOaYUoeYHRQWCiOi907TKwS7PsFP8J1gUEOYJgW8lL+DAJrOtgvil7kPyxa9hw05HKH0wWb6ItU2FhEXygevGsUw5qpiKorW6DNGbTBC7bX4YYBEBIhGp8WVFVktiqjadVhotWFWG3Hb1dOn/CzRNQ/VLebujE1yoFC3w0p24PLMwmvHClCxv7TBZVqrsrphu6sn8X32Z9utuWj6B03T2HfczGWg5aZj8840bwoplQczq5YH1+7Xc2NP0RlZLlCQwfuHhLTYxNv/b1E7Lt25RhV8dkh3c9YnIR5voRQX1T65ovg9px/dvgGFGKQA4xkPQ2UG3SfMAF3HUiZSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=mit.edu smtp.mailfrom=sony.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sony.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2riAygWKcPtg1Fnh7u/mT71FzSAtZSdf0ENEeYlM7P0=;
 b=PL4SpaW1igksjWXTn7h8PSOjh+jsDkmyBAlKAtN45DcJ9RWn99O81fdxuGcUHxMXSxTaf0kKEIsFN4RKVVWfdVhN5vTNspgidtEQwRiudrvP+WugR4FE/+hwN63SEXI2MWgkrJiy2spMr6++cVyJ7xWxHQ7r7+sg2TBfflUGh64=
Received: from BN6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:404:13e::22)
 by DM6PR13MB3644.namprd13.prod.outlook.com (2603:10b6:5:1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14; Fri, 18 Oct 2019 02:40:56 +0000
Received: from SN1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR13CA0036.outlook.office365.com
 (2603:10b6:404:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.6 via Frontend
 Transport; Fri, 18 Oct 2019 02:40:56 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 SN1NAM02FT030.mail.protection.outlook.com (10.152.72.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2367.14 via Frontend Transport; Fri, 18 Oct 2019 02:40:55 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9I2eskj032424;
        Fri, 18 Oct 2019 02:40:55 GMT
Received: from USCULXHUB06V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.44])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9I2esP9002562;
        Fri, 18 Oct 2019 02:40:54 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB06V.am.sony.com ([146.215.231.44]) with mapi id 14.03.0439.000; Thu,
 17 Oct 2019 22:40:54 -0400
From:   <Tim.Bird@sony.com>
To:     <tytso@mit.edu>
CC:     <skhan@linuxfoundation.org>, <brendanhiggins@google.com>,
        <yzaikin@google.com>, <linux-kselftest@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <kunit-dev@googlegroups.com>
Subject: RE: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Topic: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Index: AQHVfxQJt5KYyUfdIUCqjuPcGwlYBqdUYHYAgABUYYCAAMbxgIAANgMAgAhyYYCAABMAgIAA1OuAgABbSgCAAFnHgP//vbhQgABwDoD//8Dh4A==
Date:   Fri, 18 Oct 2019 02:40:50 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977D01DC@USCULXMSG01.am.sony.com>
References: <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <20191017225637.GB6371@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
 <20191018014027.GA21137@mit.edu>
In-Reply-To: <20191018014027.GA21137@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(13464003)(46406003)(37786003)(186003)(2876002)(23726003)(2906002)(5660300002)(3846002)(6116002)(6666004)(70586007)(356004)(7696005)(76176011)(55846006)(97756001)(126002)(476003)(446003)(11346002)(486006)(26005)(336012)(426003)(70206006)(102836004)(305945005)(229853002)(7736002)(14444005)(316002)(4326008)(54906003)(106002)(6916009)(6246003)(246002)(2171002)(8746002)(8936002)(66066001)(8676002)(478600001)(47776003)(33656002)(86362001)(2351001)(55016002)(50466002)(21314003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR13MB3644;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail04.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e38f2cd-6375-42a0-250a-08d7537499f8
X-MS-TrafficTypeDiagnostic: DM6PR13MB3644:
X-Microsoft-Antispam-PRVS: <DM6PR13MB3644B32F1A5F465801E69772FD6C0@DM6PR13MB3644.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01949FE337
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HJ2E5QjMwYPGVlP44FF5DHMYfBf6nVs8+BF+tLkDHBnVLMR64nhdRamq4QMiYilE6O8E8imLXaCvzzk1ZrErf6DSI0Y1D4x5rGyP0QGVpogJyZsgCSgYatj32SxuceKmHoVO9KMFblunfe9lzKbQgNvgX/ZGl2FbRvtk0+fzNOs4+1UnLTQlwBSGuZ8lMLHhZ7n7yZ1srM0GRS/Otgp/nE5hskQLAVo22M1V0vvNRlZn5r+lFV6bpHcoSJ3UQpvmZqu5A0J1aSm7B0YLai/I8uHbQwry17TTjHRJy/nwfnkwuKxW5yNxIdyd5lZfQy7bMESO/HbWrUAZwfWgxs+iZtF6nZGoAx1aDyDeYD5rQNuN0LP4TGoMw6Bku+d05POEY0JaQ7i30RGPh7N6H73PdZFEPd6txHwGUlKidAHCpM=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 02:40:55.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e38f2cd-6375-42a0-250a-08d7537499f8
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3644
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Theodore Y. Ts'o=20
>=20
> On Thu, Oct 17, 2019 at 11:40:01PM +0000, Tim.Bird@sony.com wrote:
> >
> > No. Well, the data might be provided at some time independent
> > of the test compilation time, but it would not be made up on the fly.
> > So the data might be provided at run time, but that shouldn't imply
> > that the data is random, or that there is some lengthy fabrication
> > process that happens at test execution time.
>=20
> So how would the data be provided?  Via a mounted file system?  There
> is no mounted file system when we're running a kunit test.  One of the
> reasons why kunit is fast is because we're not running init scripts,
> and we're not mounting a file system.
>=20
> The fabrication process isn't really lengthy, though.  If I modify
> fs/ext4/inode-test.c to add or remove a test, it takes:
>=20
> Elapsed time: 2.672s total, 0.001s configuring, 2.554s building, 0.116s r=
unning
>=20
> Compare and contrast this with running "kvm-xfstests -c 4k generic/001"
>=20
> The actual time to run the test generic/001 is 3 seconds.  But there
> is a 9 second overhead in starting the VM, for a total test time of 12
> seconds.  So sure, with kvm-xfstests I can drop a config file in
> /tmp/kvm-xfstests-tytso, which is mounted as /vtmp using 9p, so you
> could provide "user provided data" via a text file.  But the overhead
> of starting up a full KVM, mounting a file system, starting userspace,
> etc., is 9 seconds.
>=20
> Contrast this with 2.5 seconds to recompile and relink
> fs/ext4/inode-test.c into the kunit library.  I wouldn't call that a
> "length fabrication process".=20

I'm not sure I understand your point here at all.  I never said that
compiling the code was a lengthy fabrication process.  I said that
I was NOT envisioning a lengthy fabrication process at runtime
for the creation of the external data.  Indeed, I wasn't envisioning fabric=
ating
the data at test runtime at all.  I was trying to clarify that I didn't env=
ision
a human or fuzzer in the loop at test runtime, but apparently I didn't make=
 that clear.
The clarification was based on an assumption I made about what you were ask=
ing
in your question.  Maybe that assumption was bad.

> Is it really worth it to add in some
> super-complex way to feed a data text file into a Kunit test, when
> editing the test file and rerunning the test really doesn't take that
> long?
>=20
> > In this case, the cost of parsing the data file does add some overhead,
> > but it's not onerous.  I'm not sure how, or whether, kunit handles
> > the issue of reading data from a file at test time.  But it doesn't hav=
e
> > to be a file read.  I'm just talking separating data from code.
>=20
> It's not the cost of parsing the data file is how to *feed* the data
> file into the test file.  How exactly are we supposed to do it?  9p?
> Some other mounted file system?  That's where all the complexity and
> overhead is going to be.
>=20
> > Not necessarily.  Maybe the root privilege example is not a good one.
> > How about a test that probes the kernel config, and executes
> > some variation of the tests based on the config values it detects?
>=20
> But that's even easier.  We can put "#ifdef CONFIG_xxx" into the
> fs/ext4/inode-test.c file.  Again, it doesn't take that long to
> recompile and relink the test .c file.
>=20
> Apologies, but this really seems like complexity in search of a
> problem....

We're just talking past each other.  My original e-mail was a rebuttal
to your assertion that any test that was data-driven or non-deterministic
was a fuzzer.  I still believe that's just not the case.  This is independe=
nt
of the mechanics or speed of how the data is input.

I also conceded (multiple times) that externally data-driven techniques are=
 probably
more aptly applied to non-unit tests. I've heard your pitch about speed, an=
d I'm sympathetic.
My point is that I believe there is a place for data-driven tests.

I can live with having failed to convince you, which I'll put down to my in=
adequacy to
accurately communicate my ideas. :-)

Regards,
 -- Tim

