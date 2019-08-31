Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2CA4137
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 02:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfHaAId (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 20:08:33 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com ([40.107.68.126]:65027
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728122AbfHaAId (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 20:08:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFYvw6nIRTckUkNqh5QL+MAfwhFvPBeUiFqe5gV1XAUVXV0Z6Q1+p82pto1chuAtMAsglHceeMwL6qpofxLI6evwra/1cZHDNXf+UDRcSRIya65slcL3ncieulgyQ46szECemMBhqv+m07uyLy3AqCVTUJ+0ndbqr29UNC8F0Otg4DpZ0QVnJPfnnfld+L7Hxw2Q7rfJvpeXPTQGPWj1O8R9GfhJpuqr4YkXXxVjXkUcNwbayPm2aWoB/CBW9oqeCNIcEE99dgdhItRTfmWJ570JuraVTTXTCQuseOgfKdJHRw6fGycIBo3tiadROZ9W+BSGO0DCOGb1oUwgMDmnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Iep3jfkvZJvb+ORJBfGYPOdXWSewjNmkS/UiObIH6s=;
 b=lvsgitFye9HRFCPYC8HhC42jhknDGXGZFV06WX0d5wgHtszSo4P64zffbsKPflTJfA7z4skVRlp8HI/2mefTq8xvoEKzJfvU+zkMrY0WMOR8Ssn1duNfrph/niz1X5rTpX8bA5b0lW/+m0d3CgAweboKDKtrfTUiQ0ILcz36Bg3D45OyV51swSTzZ75CGsqU3ULpneg24/J6wg/+hbWsWA31VZGwLpleEXbBFGSIhN2cDBXu67nwKBkF3f4LVaf4apb/4AgBT2p9q1RJod8ygG9v6V9SJy3iIaKpB06VDpXuUrZSzSVt3/tAAv0TYlMRfBWQnxdQIxYTHk0HNaE/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.229) smtp.rcpttodomain=google.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Iep3jfkvZJvb+ORJBfGYPOdXWSewjNmkS/UiObIH6s=;
 b=V6APz3GPRds54Bq4PMcZCZdRgzwSVUASaEwR5g9dIxVE07iiQcWsug1xdWT44wKUtjkBItVWGg3Cz61itFJUH0HTxeP8sTKJOXZsnR27mp1E9v5KRjUsehmBYPB1xdbniTWxPzLMWRm9GPdOeTRuDMga5Ec6A36wxFe0tS8wARM=
Received: from CY4PR13CA0094.namprd13.prod.outlook.com (2603:10b6:903:152::32)
 by MWHPR1301MB1968.namprd13.prod.outlook.com (2603:10b6:301:32::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.6; Sat, 31 Aug
 2019 00:06:49 +0000
Received: from SN1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR13CA0094.outlook.office365.com
 (2603:10b6:903:152::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.6 via Frontend
 Transport; Sat, 31 Aug 2019 00:06:49 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.229)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.229; helo=usculsndmail02v.am.sony.com;
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 SN1NAM02FT030.mail.protection.outlook.com (10.152.72.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Sat, 31 Aug 2019 00:06:48 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7V06lmN008029;
        Sat, 31 Aug 2019 00:06:47 GMT
Received: from USCULXHUB07V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.168])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7V06k5D013957;
        Sat, 31 Aug 2019 00:06:46 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0439.000;
 Fri, 30 Aug 2019 20:06:45 -0400
From:   <Tim.Bird@sony.com>
To:     <brendanhiggins@google.com>
CC:     <joe@perches.com>, <shuah@kernel.org>,
        <sergey.senozhatsky.work@gmail.com>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <frowand.list@gmail.com>, <sboyd@kernel.org>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <rdunlap@infradead.org>, <sfr@canb.auug.org.au>
Subject: RE: [PATCH v2] kunit: fix failure to build without printk
Thread-Topic: [PATCH v2] kunit: fix failure to build without printk
Thread-Index: AQHVXYOHSzY8I+qIqESnE7HuJlTJpKcQk8yAgAIK7gCAAMSnAIAA6NiAgAAj6AD//87t0IAAUmyAgAAEeID//8ADsIAAScEA///D07A=
Date:   Sat, 31 Aug 2019 00:06:32 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977A846B@USCULXMSG01.am.sony.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
 <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
 <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
 <20190830183821.GA30306@google.com>
 <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
 <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
 <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
 <20190830233710.GA101591@google.com>
In-Reply-To: <20190830233710.GA101591@google.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.229;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(13464003)(189003)(199004)(23726003)(46406003)(4326008)(426003)(336012)(7696005)(47776003)(486006)(33656002)(446003)(11346002)(14444005)(126002)(476003)(50466002)(106002)(316002)(76176011)(26005)(478600001)(186003)(66066001)(6666004)(53546011)(356004)(102836004)(8936002)(8746002)(70586007)(6246003)(6916009)(97756001)(229853002)(55846006)(54906003)(2906002)(55016002)(246002)(305945005)(2351001)(7416002)(2876002)(37786003)(7736002)(5660300002)(70206006)(86362001)(6116002)(8676002)(3846002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB1968;H:usculsndmail02v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail02.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 597ce40b-7c6d-47e0-4186-08d72da71e83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR1301MB1968;
X-MS-TrafficTypeDiagnostic: MWHPR1301MB1968:
X-Microsoft-Antispam-PRVS: <MWHPR1301MB1968888A451E8986D79B31FEFDBC0@MWHPR1301MB1968.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 014617085B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: i9IuKeSX7iGuQ85rlcxNFx4qGmprFJbrD+aT8c7+NTHfhCRnyqPPSKodbu1q0O/PEGs9PVu7E/VAB6zKC/4DVANYs9QFrfnhNKZDidfKN/fQ0bp/doPHxJgFrzp/O+mICxc1+sr8MYPmqtGE3vajg1TDA//oI2swaH41zcXMCZ3003JXqNYjgUqWOyJItxqH17Jo/7QITw/UJkQaXbNQcmgdmnlyP4CNtmtp9zgor1pwOstv7Fy5kLX/4V0d5AywodErAjXSiXRyxVMaYNupjVT7NFfrFxkF3E3s2Y9HySBGgIj5osX4srecUZR/I4dKL49PYnmbrjEX79pO2YzgdHG6WhEQq5UOjAr8XIz9KHFaPyAWeOXO+nHhutaPkEAeMY9TWSqK1UvyAUoTEnKVHLCmjqUnC64BTONAEfYPQRQ=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2019 00:06:48.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597ce40b-7c6d-47e0-4186-08d72da71e83
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.229];Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB1968
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Brendan Higgins=20
>=20
> On Fri, Aug 30, 2019 at 11:22:43PM +0000, Tim.Bird@sony.com wrote:
> > > -----Original Message-----
> > > From: Brendan Higgins
> > >
> > > On Fri, Aug 30, 2019 at 3:46 PM Joe Perches <joe@perches.com> wrote:
> > > >
> > > > On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
> > > > > > From: Joe Perches
> > > > []
> > > > > IMHO %pV should be avoided if possible.  Just because people are
> > > > > doing it doesn't mean it should be used when it is not necessary.
> > > >
> > > > Well, as the guy that created %pV, I of course
> > > > have a different opinion.
> > > >
> > > > > >  then wouldn't it be easier to pass in the
> > > > > > > kernel level as a separate parameter and then strip off all p=
rintk
> > > > > > > headers like this:
> > > > > >
> > > > > > Depends on whether or not you care for overall
> > > > > > object size.  Consolidated formats with the
> > > > > > embedded KERN_<LEVEL> like suggested are smaller
> > > > > > overall object size.
> > > > >
> > > > > This is an argument I can agree with.  I'm generally in favor of
> > > > > things that lessen kernel size creep. :-)
> > > >
> > > > As am I.
> > >
> > > Sorry, to be clear, we are talking about the object size penalty due
> > > to adding a single parameter to a function. Is that right?
> >
> > Not exactly.  The argument is that pre-pending the different KERN_LEVEL
> > strings onto format strings can result in several versions of nearly id=
entical
> strings
> > being compiled into the object file.  By parameterizing this (that is, =
adding
> > '%s' into the format string, and putting the level into the string as a=
n
> argument),
> > it prevents this duplication of format strings.
> >
> > I haven't seen the data on duplication of format strings, and how much =
this
> > affects it, but little things can add up.  Whether it matters in this c=
ase
> depends
> > on whether the format strings that kunit uses are also used elsewhere i=
n
> the kernel,
> > and whether these same format strings are used with multiple kernel
> message levels.
> >  -- Tim
>=20
> I thought this portion of the discussion was about whether Joe's version
> of kunit_printk was better or my critique of his version of kunit_printk:
>=20
> Joe's:
> > > > > -void kunit_printk(const char *level,
> > > > > -		  const struct kunit *test,
> > > > > -		  const char *fmt, ...)
> > > > > +void kunit_printk(const struct kunit *test, const char *fmt, ...=
)
> > > > >  {
> > > > > +	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] =3D "\0";
> > > > >  	struct va_format vaf;
> > > > >  	va_list args;
> > > > > +	int kern_level;
> > > > >
> > > > >  	va_start(args, fmt);
> > > > >
> > > > > +	while ((kern_level =3D printk_get_level(fmt)) !=3D 0) {
> > > > > +		size_t size =3D printk_skip_level(fmt) - fmt;
> > > > > +
> > > > > +		if (kern_level >=3D '0' && kern_level <=3D '7') {
> > > > > +			memcpy(lvl, fmt,  size);
> > > > > +			lvl[size] =3D '\0';
> > > > > +		}
> > > > > +		fmt +=3D size;
> > > > > +	}
> > > > > +
> > > > >  	vaf.fmt =3D fmt;
> > > > >  	vaf.va =3D &args;
> > > > >
> > > > > -	kunit_vprintk(test, level, &vaf);
> > > > > +	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
> > > > >
> > > > >  	va_end(args);
> > > > >  }
>=20
> Mine:
> >  void kunit_printk(const char *level,
> >  		  const struct kunit *test,
> >  		  const char *fmt, ...)
> >  {
> >  	struct va_format vaf;
> >  	va_list args;
> >
> >  	va_start(args, fmt);
> >
> > +	fmt =3D printk_skip_headers(fmt);
> > +
> >  	vaf.fmt =3D fmt;
> >  	vaf.va =3D &args;
> >
> > -	kunit_vprintk(test, level, &vaf);
> > +	printk("%s\t# %s %pV\n", level, test->name, &vaf);
> >
> >  	va_end(args);
> >  }
>=20
> I thought you and Joe were arguing that "Joe's" resulted in a smaller
> object size than "Mine" (not to be confused with the actual patch I
> presented here, which is what Sergey suggested I do on a different
> thread).
>=20
> I really don't feel strongly about what Sergey suggested I do (which is
> what this patch originally introduced), versus, what Joe suggested,
> versus what I suggested in response to Joe (or any of the things
> suggested on other threads). I just want to pick one, fix the breakage
> in linux-next, and move on with my life.

When in doubt, do what the sub-system maintainer says.  I'd go
with Sergey's suggestion.  Maintainers often are juggling a host
of issues, and weighing new features and usages of their system
against their long-term plans for their sub-system.  Sometimes
they have time to communicate all the intricacies of their
counter-proposals, and sometimes not.

But they know their system best, and much more often than not
provide sound advice.

If you don't have a strong feeling about it, just do what they
say.
 -- Tim

