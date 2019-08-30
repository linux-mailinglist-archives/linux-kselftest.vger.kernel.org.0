Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F847A4009
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfH3V7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 17:59:01 -0400
Received: from mail-eopbgr760094.outbound.protection.outlook.com ([40.107.76.94]:8390
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728166AbfH3V7A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 17:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YojT6NMqMrFR9UafV2lpoZsZG8NklHS0zLBqNjCK/AYFpyb7O+hCAkBcMU1W0Vz890TP6fTTBK30NwLWGeebwm3q87mUCyDZEZRUAYbvZrCVdzh4muu60aWgXwOlXWWmriYXjK0qhCb9GNlaLEDyywIuXVbF5s5w1VKpqQwD1M4F+xoI+rkt/dzR2TRwSif/J6Ec5oU81gAsICIC4qwvNsHajTzZ8CJIYoLvJh+nnWSKODGnm0hMcXO0gZ9ntI95j8b9CyV0Wxda15l0chqKhjuKS7L3OWrqpIR/5ndpwta//anGYE0EfsIUk+fotDX3c7BBYa4KgJw3vfsgve06Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqeDDZ8jGznC25FbPFt4weI9E+2cJuw8UNti5yPPaGY=;
 b=MSHQP1xTe/K/620qKgdI2v+ztzrY9qu/ecXeZCYomdFgurJoJSDP4DAup9+rdNixefuMW3nzszaYdrJPdcDqdKIvXTfy48ud+YIL7WP7g+5XuqdL8dpoD8godv6jpWXWHd3XfUlB+/XbPj7/aM3lj0iksq5ml+kQxiI7ISQlDL89Y968gAMxvmarT2B6LQ3Rj92f61KVN2JsXjaDYJ4zt/ZTECtHm1C2/8BVkLCuGwMjQKwDmrj11yZCnijNHiQ0lLuZfisrbusZNaK0ylVmzGxJx1VGJEy+xEysJvsaCsTmy7NF+0QaTva71sRjCrt31iLh75BKN31QQPCBlal5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=perches.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqeDDZ8jGznC25FbPFt4weI9E+2cJuw8UNti5yPPaGY=;
 b=xB5V3Be6MuuzaE+B3PjkZ12FPMPZKgO+ACNQPwEJ2uHZ9mmbYsPc06tTinRlyfhU+fkkw2T9OpAIruPada8BwQULhO/X/Vmh0odm+gHAksqoZak0APUw5Zw0X+LEL8Rua93k7O1N1T6cBEgbQz5n/49zsk1fr/jxhaMhoDpFb38=
Received: from MWHPR1301CA0035.namprd13.prod.outlook.com
 (2603:10b6:301:29::48) by DM5PR13MB1834.namprd13.prod.outlook.com
 (2603:10b6:3:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.15; Fri, 30 Aug
 2019 21:58:55 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR1301CA0035.outlook.office365.com
 (2603:10b6:301:29::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.9 via Frontend
 Transport; Fri, 30 Aug 2019 21:58:55 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Fri, 30 Aug 2019 21:58:54 +0000
Received: from usculsndmail11v.am.sony.com (usculsndmail11v.am.sony.com [146.215.230.102])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7ULwqZw009987;
        Fri, 30 Aug 2019 21:58:53 GMT
Received: from USCULXHUB06V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.44])
        by usculsndmail11v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7ULwpD9011256;
        Fri, 30 Aug 2019 21:58:52 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB06V.am.sony.com ([146.215.231.44]) with mapi id 14.03.0439.000; Fri,
 30 Aug 2019 17:58:51 -0400
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
Thread-Index: AQHVXYOHSzY8I+qIqESnE7HuJlTJpKcQk8yAgAIK7gCAAMSnAIAA6NiAgAAj6AD//87t0A==
Date:   Fri, 30 Aug 2019 21:58:37 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
         <20190830183821.GA30306@google.com>
 <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
In-Reply-To: <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(189003)(199004)(13464003)(186003)(7416002)(446003)(6116002)(23726003)(70206006)(4326008)(966005)(7736002)(2876002)(55846006)(478600001)(70586007)(33656002)(6246003)(305945005)(6666004)(6306002)(3846002)(8676002)(5660300002)(50466002)(8746002)(14444005)(2906002)(229853002)(106002)(97756001)(55016002)(46406003)(76176011)(7696005)(336012)(110136005)(426003)(486006)(53546011)(356004)(54906003)(102836004)(316002)(37786003)(86362001)(11346002)(8936002)(47776003)(26005)(476003)(66066001)(126002)(246002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1834;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail04.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae7006a-7942-4010-e3e1-08d72d95404e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR13MB1834;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1834:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR13MB1834A0635B6494E4ED51E416FDBD0@DM5PR13MB1834.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0145758B1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zZKWsdsvqoperXgLR1sPW5HH/awfZ+2LH7kEtJIR3Kd3R1afT65AwSarmgJH2gMUqkzJ4A+3WDGAK6zEro47+ATBuSZ9UKoERaprillaS9pFcjfe/c5BM6EwGZeNekgTzfNNoUEBcKt6zSEd1fplWJxA9xE7lQUKW1urDXVkx3XwAUE5b22zG9YFKAVgDcZbXq3+Hq5hnrgZDRIAqcJl4fChPYqwhEypx3R2OAlb0Yvb78okqutXzUWdCIr7XapDuBv/Ot9tm49lCZS5F6YW28tPRERQGop1V7kVqrPeVlN0cTSmTgItAcX5o94zYRliXPIus5uck3ieoCAhbM1hnu/gl/AXf0tKvkxKGZ9kbVjYxWjsgPtC1b2MIBzct9UlQZuNiz/+Izd5N/IULRiXJrwKSn3t2alWugTu5Bb+HWk=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2019 21:58:54.2298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae7006a-7942-4010-e3e1-08d72d95404e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1834
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Joe Perches
>=20
> On Fri, 2019-08-30 at 11:38 -0700, Brendan Higgins wrote:
> > On Thu, Aug 29, 2019 at 09:44:58PM -0700, Joe Perches wrote:
> > > On Thu, 2019-08-29 at 11:01 -0600, shuah wrote:
> > > > On 8/28/19 3:49 AM, Sergey Senozhatsky wrote:
> > > > > On (08/28/19 02:31), Brendan Higgins wrote:
> > > > > [..]
> > > > > > Previously KUnit assumed that printk would always be present,
> which is
> > > > > > not a valid assumption to make. Fix that by removing call to
> > > > > > vprintk_emit, and calling printk directly.
> > > > > >
> > > > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > > > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a9=
7-
> 715a-fabe016259df@kernel.org/T/#t
> > > > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > > > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > >
> > > > > [..]
> > > > >
> > > > > > -static void kunit_vprintk(const struct kunit *test,
> > > > > > -			  const char *level,
> > > > > > -			  struct va_format *vaf)
> > > > > > -{
> > > > > > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name,
> vaf);
> > > > > > -}
> > > > >
> > > > > This patch looks good to me. I like the removal of recursive
> > > > > vsprintf() (%pV).
> > > > >
> > > > > 	-ss
> > > > >
> > > >
> > > > Hi Sergey,
> > > >
> > > > What are the guidelines for using printk(). I recall some discussio=
n
> > > > about not using printk(). I am seeing the following from checkpatch
> > > > script:
> > > >
> > > >
> > > > WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ...
> then
> > > > dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> > > > #105: FILE: include/kunit/test.h:343:
> > > > +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> > > >
> > > >
> > > > Is there supposed to be pr_level() - I can find dev_level()
> > > >
> > > > cc'ing Joe Perches for his feedback on this message recommending
> > > > pr_level() which isn't in 5.3.
> > >
> > > I don't care for pr_level or KERN_LEVEL in a printk.
> >
> > I don't think I follow, how does your version fix this?
> >
> > > I think this is somewhat overly complicated.
> > >
> > > I think I'd write it like:
> > > ---
> > >  include/kunit/test.h | 11 ++++-----
> > >  kunit/test.c         | 69 ++++++++++++++++--------------------------=
----------
> > >  2 files changed, 26 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 8b7eb03d4971..aa4abf0a22a5 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *t=
est,
> size_t size, gfp_t gfp)
> > >
> > >  void kunit_cleanup(struct kunit *test);
> > >
> > > -void __printf(3, 4) kunit_printk(const char *level,
> > > -				 const struct kunit *test,
> > > -				 const char *fmt, ...);
> > > +__printf(2, 3)
> > > +void kunit_printk(const struct kunit *test, const char *fmt, ...);
> > >
> > >  /**
> > >   * kunit_info() - Prints an INFO level message associated with @test=
.
> > > @@ -353,7 +352,7 @@ void __printf(3, 4) kunit_printk(const char *leve=
l,
> > >   * Takes a variable number of format parameters just like printk().
> > >   */
> > >  #define kunit_info(test, fmt, ...) \
> > > -	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
> > > +	kunit_printk(test, KERN_INFO fmt, ##__VA_ARGS__)
> > >
> > >  /**
> > >   * kunit_warn() - Prints a WARN level message associated with @test.
> > > @@ -364,7 +363,7 @@ void __printf(3, 4) kunit_printk(const char *leve=
l,
> > >   * Prints a warning level message.
> > >   */
> > >  #define kunit_warn(test, fmt, ...) \
> > > -	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
> > > +	kunit_printk(test, KERN_WARNING fmt, ##__VA_ARGS__)
> > >
> > >  /**
> > >   * kunit_err() - Prints an ERROR level message associated with @test=
.
> > > @@ -375,7 +374,7 @@ void __printf(3, 4) kunit_printk(const char *leve=
l,
> > >   * Prints an error level message.
> > >   */
> > >  #define kunit_err(test, fmt, ...) \
> > > -	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> > > +	kunit_printk(test, KERN_ERR fmt, ##__VA_ARGS__)
> > >
> > >  /**
> > >   * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clari=
ty.
> > > diff --git a/kunit/test.c b/kunit/test.c
> > > index b2ca9b94c353..ddb9bffb5a5d 100644
> > > --- a/kunit/test.c
> > > +++ b/kunit/test.c
> > > @@ -16,40 +16,6 @@ static void kunit_set_failure(struct kunit *test)
> > >  	WRITE_ONCE(test->success, false);
> > >  }
> > >
> > > -static int kunit_vprintk_emit(int level, const char *fmt, va_list ar=
gs)
> > > -{
> > > -	return vprintk_emit(0, level, NULL, 0, fmt, args);
> > > -}
> > > -
> > > -static int kunit_printk_emit(int level, const char *fmt, ...)
> > > -{
> > > -	va_list args;
> > > -	int ret;
> > > -
> > > -	va_start(args, fmt);
> > > -	ret =3D kunit_vprintk_emit(level, fmt, args);
> > > -	va_end(args);
> > > -
> > > -	return ret;
> > > -}
> > > -
> > > -static void kunit_vprintk(const struct kunit *test,
> > > -			  const char *level,
> > > -			  struct va_format *vaf)
> > > -{
> > > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > > -}
> > > -
> > > -static void kunit_print_tap_version(void)
> > > -{
> > > -	static bool kunit_has_printed_tap_version;
> > > -
> > > -	if (!kunit_has_printed_tap_version) {
> > > -		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > > -		kunit_has_printed_tap_version =3D true;
> > > -	}
> > > -}
> > > -
> > >  static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > >  {
> > >  	struct kunit_case *test_case;
> > > @@ -63,11 +29,9 @@ static size_t kunit_test_cases_len(struct kunit_ca=
se
> *test_cases)
> > >
> > >  static void kunit_print_subtest_start(struct kunit_suite *suite)
> > >  {
> > > -	kunit_print_tap_version();
> > > -	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", suite-
> >name);
> > > -	kunit_printk_emit(LOGLEVEL_INFO,
> > > -			  "\t1..%zd\n",
> > > -			  kunit_test_cases_len(suite->test_cases));
> > > +	pr_info_once("TAP version 14\n");
> > > +	pr_info("\t# Subtest: %s\n", suite->name);
> > > +	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
> > >  }
> > >
> > >  static void kunit_print_ok_not_ok(bool should_indent,
> > > @@ -87,9 +51,8 @@ static void kunit_print_ok_not_ok(bool
> should_indent,
> > >  	else
> > >  		ok_not_ok =3D "not ok";
> > >
> > > -	kunit_printk_emit(LOGLEVEL_INFO,
> > > -			  "%s%s %zd - %s\n",
> > > -			  indent, ok_not_ok, test_number, description);
> > > +	pr_info("%s%s %zd - %s\n",
> > > +		indent, ok_not_ok, test_number, description);
> > >  }
> > >
> > >  static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> > > @@ -133,11 +96,11 @@ static void kunit_print_string_stream(struct kun=
it
> *test,
> > >  		kunit_err(test,
> > >  			  "Could not allocate buffer, dumping stream:\n");
> > >  		list_for_each_entry(fragment, &stream->fragments, node) {
> > > -			kunit_err(test, fragment->fragment);
> > > +			kunit_err(test, "%s", fragment->fragment);
> > >  		}
> > >  		kunit_err(test, "\n");
> > >  	} else {
> > > -		kunit_err(test, buf);
> > > +		kunit_err(test, "%s", buf);
> > >  		kunit_kfree(test, buf);
> > >  	}
> > >  }
> > > @@ -505,19 +468,29 @@ void kunit_cleanup(struct kunit *test)
> > >  	}
> > >  }
> > >
> > > -void kunit_printk(const char *level,
> > > -		  const struct kunit *test,
> > > -		  const char *fmt, ...)
> > > +void kunit_printk(const struct kunit *test, const char *fmt, ...)
> > >  {
> > > +	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] =3D "\0";
> > >  	struct va_format vaf;
> > >  	va_list args;
> > > +	int kern_level;
> > >
> > >  	va_start(args, fmt);
> > >
> > > +	while ((kern_level =3D printk_get_level(fmt)) !=3D 0) {
> > > +		size_t size =3D printk_skip_level(fmt) - fmt;
> > > +
> > > +		if (kern_level >=3D '0' && kern_level <=3D '7') {
> > > +			memcpy(lvl, fmt,  size);
> > > +			lvl[size] =3D '\0';
> > > +		}
> > > +		fmt +=3D size;
> > > +	}
> > > +
> > >  	vaf.fmt =3D fmt;
> > >  	vaf.va =3D &args;
> > >
> > > -	kunit_vprintk(test, level, &vaf);
> > > +	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
> > >
> > >  	va_end(args);
> > >  }
> >
> > How is this simpler?
> >
> > If we are okay with dynamically adding the KERN_<LEVEL> and %pV (and I
> > don't think that Sergey is),
>=20
> Sergey may well be in the minority overall as %pV
> is now very frequently
> used throughout the kernel.
>=20
> $ git grep "%pV" | wc -l
> 241

Hmm.  IMHO %pV should be avoided if possible.  Just because people are
doing it doesn't mean it should be used when it is not necessary.

>=20
>  then wouldn't it be easier to pass in the
> > kernel level as a separate parameter and then strip off all printk
> > headers like this:
>=20
> Depends on whether or not you care for overall
> object size.  Consolidated formats with the
> embedded KERN_<LEVEL> like suggested are smaller
> overall object size.

This is an argument I can agree with.  I'm generally in favor of
things that lessen kernel size creep. :-)

 -- Tim

>=20
> This style is also already used in the kernel.
>=20
> > I don't know. I am clearly not an expert on this topic, but I don't see
> > the merit of the while loop you added above or dropping the level param=
.
>=20
> The while use is only to avoid misuses with consecutive
> KERN_<LEVEL> formats, which had happened in the past.


