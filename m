Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B010C0B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 00:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfK0Xkj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 18:40:39 -0500
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:52893
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfK0Xkg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 18:40:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX8HP+c/j/REXMqesHHEvxbJqBIghS9BAdULPHybUtHRsoEJaxVW8zk7HYm6S1QXu0DmcAtv5B54BXtdI+GASeFlEKbS+eq/hFxt+FKtx9gGUIRqfSZyewZ/gFtA5lBfM2spuh6oFnUfUSKQnddkfYuu7i4GedhG4i079l9nJ7uLzZlc4n10NGU+EFsLfgwL3YDyh9YABH1PT18rQo0miln2ATPd+WUYeRVvZ4oXnbbd7S+JNPwYQtwjKevMeH0kQBtRVE/uM79NitsgOHzFVJswvkR7jpzWWrn73fVb2Ij/7Ks1MDGlfCsKGXDghOjmP0DNNSYqI8wAPycS8z40lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPt/RvBl8ql+huF1E38lVjdcd9M47l0t4COuFwjzmd8=;
 b=Es5gsGUL4qPq66/eomdv6SXQHZfXtpltY/8ihiaDSOQ28637lL0CgwD0pQ2wv+zAO2Bz8UtrZ8Yg2MqQbGlV6PsWtzvqdBNgOu4Tc779eoTe+icqsTCWlAGXWgysSJ5piSWFoyRp0CJ19tRSxzCPKlDXk739lgQmEBYuyv6GOmgDgGSuSOQqazqpoq1sD0Tj45TZU+Oawx+5vNSMFR2YCAirbIOhFwlxBsZjYuoeeab+RbCuu0ys5LiUMsNCQgKK70YAlDWGLha+ANVFMu0c0RO+sYeiOo668Ys/7w0FUOAZX8mhXbC/cO+FVoy29iCLV29UvyvXbnvU4PNQajqfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPt/RvBl8ql+huF1E38lVjdcd9M47l0t4COuFwjzmd8=;
 b=CkI+crQyez1YQ6Ep6cvGPUw7p+FFgON9r2Ciuac8uUrNLOR08Y07BRfM9SAwY8fIVZOtllZPQ2MMLXIlBsJL3jDRKmUn2kNYtvsRzf7AVCJO+sNE6Z7c1o926LJkcDX4bm/DjxyDEJ3EyzLoZpDh3MKr6c37n4tJhVMPfx1u9iE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4942.eurprd04.prod.outlook.com (20.177.50.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Wed, 27 Nov 2019 23:40:32 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 23:40:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 1/4] PM / QoS: Initial kunit test
Thread-Topic: [PATCH v4 1/4] PM / QoS: Initial kunit test
Thread-Index: AQHVpGyaJy+qk1jZxUut96Do5LWNDw==
Date:   Wed, 27 Nov 2019 23:40:32 +0000
Message-ID: <VI1PR04MB70234D1D3953E6E7C69A5ED6EE440@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
 <be196b656bb5fbf2c59a179e6453aa963b862109.1574781196.git.leonard.crestez@nxp.com>
 <20191126200414.GD228856@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b3ee1a1-d431-44f5-4ce2-08d773933169
x-ms-traffictypediagnostic: VI1PR04MB4942:|VI1PR04MB4942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4942F86F8B2F02ADAD13CF0AEE440@VI1PR04MB4942.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(199004)(189003)(52314003)(8676002)(99286004)(71200400001)(8936002)(4326008)(54906003)(316002)(6116002)(25786009)(14444005)(256004)(71190400001)(81156014)(81166006)(55016002)(6246003)(14454004)(6916009)(2906002)(66066001)(478600001)(229853002)(446003)(6506007)(7736002)(102836004)(7416002)(33656002)(52536014)(53546011)(66476007)(66446008)(64756008)(74316002)(76116006)(66946007)(305945005)(91956017)(186003)(66556008)(44832011)(9686003)(6436002)(3846002)(86362001)(5660300002)(7696005)(76176011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4942;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbP7GFrswjdP1VcuSX/Kdo8FUChESe6miSi+WG3Bgf5as067kZfFTrad6CkXAedOdZ7Qid8wE/Wg5/prfJvE+8OnxxXiVVxzJinQJEnL+99YW1xn3sDLNhTjy8ujRUYA2a9XjcXtAbdCfqPh7VEnYiiz7+UcnGWl9GnslVYcd6MSngG07LgqQCJNRLNxlL9SDlUlYVLkEfwoM6GhHc1Hog6Z5iI2Fzxg9mLQknw+wyBuhftg1/OXlnknJXm06F3epP7wYrhYDk74Tylc1CS4o3NYsFNShBVcANrwJxMmGcKFOYb+Nw1bq5Hc2NDieQA8eT7zPJdrNCy3Iwq6ryh8CF3gSnqLryMetIDAfx853lcMWje+Mor55Vlq9zBw7+TIwIo/Xy4XhW6rVeQ6ukxg+SAmROdFEu0jHd4pYcosHkJsPqf7qOjfX2XVQ0tROLXm
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3ee1a1-d431-44f5-4ce2-08d773933169
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 23:40:32.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHRSXsH9Lr9uu3pixpkLMnJktDAkFqBg+Ay26ipcTuLe4JTKw2kXPS/3SvualWiktJvooW6HSuO5bQy+PXt26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26.11.2019 22:04, Matthias Kaehlcke wrote:=0A=
> On Tue, Nov 26, 2019 at 05:17:10PM +0200, Leonard Crestez wrote:=0A=
>> The pm_qos family of APIs are used in relatively difficult to reproduce=
=0A=
>> scenarios such as thermal throttling so they benefit from unit testing.=
=0A=
>>=0A=
>> Start by adding basic tests from the the freq_qos APIs. It includes=0A=
>> tests for issues that were brought up on mailing lists:=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/base/Kconfig          |   4 ++=0A=
>>   drivers/base/power/Makefile   |   1 +=0A=
>>   drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++=
=0A=
>>   3 files changed, 122 insertions(+)=0A=
>>   create mode 100644 drivers/base/power/qos-test.c=0A=
>>=0A=
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig=0A=
>> index e37d37684132..d4ae1c1adf69 100644=0A=
>> --- a/drivers/base/Kconfig=0A=
>> +++ b/drivers/base/Kconfig=0A=
>> @@ -155,10 +155,14 @@ config DEBUG_TEST_DRIVER_REMOVE=0A=
>>   =0A=
>>   	  This option is expected to find errors and may render your system=
=0A=
>>   	  unusable. You should say N here unless you are explicitly looking t=
o=0A=
>>   	  test this functionality.=0A=
>>   =0A=
>> +config PM_QOS_KUNIT_TEST=0A=
>> +	bool "KUnit Test for PM QoS features"=0A=
>> +	depends on KUNIT=0A=
>> +=0A=
>>   config HMEM_REPORTING=0A=
>>   	bool=0A=
>>   	default n=0A=
>>   	depends on NUMA=0A=
>>   	help=0A=
>> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile=
=0A=
>> index ec5bb190b9d0..8fdd0073eeeb 100644=0A=
>> --- a/drivers/base/power/Makefile=0A=
>> +++ b/drivers/base/power/Makefile=0A=
>> @@ -2,7 +2,8 @@=0A=
>>   obj-$(CONFIG_PM)	+=3D sysfs.o generic_ops.o common.o qos.o runtime.o w=
akeirq.o=0A=
>>   obj-$(CONFIG_PM_SLEEP)	+=3D main.o wakeup.o wakeup_stats.o=0A=
>>   obj-$(CONFIG_PM_TRACE_RTC)	+=3D trace.o=0A=
>>   obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=3D  domain.o domain_governor.o=0A=
>>   obj-$(CONFIG_HAVE_CLK)	+=3D clock_ops.o=0A=
>> +obj-$(CONFIG_PM_QOS_KUNIT_TEST) +=3D qos-test.o=0A=
>>   =0A=
>>   ccflags-$(CONFIG_DEBUG_DRIVER) :=3D -DDEBUG=0A=
>> diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test=
.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..3115db08d56b=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/base/power/qos-test.c=0A=
>> @@ -0,0 +1,117 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * Copyright 2019 NXP=0A=
>> + */=0A=
>> +#include <kunit/test.h>=0A=
>> +#include <linux/pm_qos.h>=0A=
>> +=0A=
>> +/* Basic test for aggregating two "min" requests */=0A=
>> +static void freq_qos_test_min(struct kunit *test)=0A=
>> +{=0A=
>> +	struct freq_constraints	qos;=0A=
>> +	struct freq_qos_request	req1, req2;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	freq_constraints_init(&qos);=0A=
>> +	memset(&req1, 0, sizeof(req1));=0A=
>> +	memset(&req2, 0, sizeof(req2));=0A=
>> +=0A=
>> +	ret =3D freq_qos_add_request(&qos, &req1, FREQ_QOS_MIN, 1000);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	ret =3D freq_qos_add_request(&qos, &req2, FREQ_QOS_MIN, 2000);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 2000);=
=0A=
>> +=0A=
>> +	ret =3D freq_qos_remove_request(&req2);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);=
=0A=
>> +=0A=
>> +	ret =3D freq_qos_remove_request(&req1);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),=0A=
>> +			FREQ_QOS_MIN_DEFAULT_VALUE);=0A=
>> +}=0A=
>> +=0A=
>> +/* Test that requests for MAX_DEFAULT_VALUE have no effect */=0A=
>> +static void freq_qos_test_maxdef(struct kunit *test)=0A=
>> +{=0A=
>> +	struct freq_constraints	qos;=0A=
>> +	struct freq_qos_request	req1, req2;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	freq_constraints_init(&qos);=0A=
>> +	memset(&req1, 0, sizeof(req1));=0A=
>> +	memset(&req2, 0, sizeof(req2));=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX),=0A=
>> +			FREQ_QOS_MAX_DEFAULT_VALUE);=0A=
>> +=0A=
>> +	ret =3D freq_qos_add_request(&qos, &req1, FREQ_QOS_MAX,=0A=
>> +			FREQ_QOS_MAX_DEFAULT_VALUE);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 0);=0A=
>> +	ret =3D freq_qos_add_request(&qos, &req2, FREQ_QOS_MAX,=0A=
>> +			FREQ_QOS_MAX_DEFAULT_VALUE);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 0);=0A=
>> +=0A=
>> +	/* Add max 1000 */=0A=
>> +	ret =3D freq_qos_update_request(&req1, 1000);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);=
=0A=
>> +=0A=
>> +	/* Add max 2000, no impact */=0A=
>> +	ret =3D freq_qos_update_request(&req2, 2000);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 0);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 1000);=
=0A=
>> +=0A=
>> +	/* Remove max 1000, new max 2000 */=0A=
>> +	ret =3D freq_qos_remove_request(&req1);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 2000);=
=0A=
> =0A=
> nit: this last part isn't really related with MAX_DEFAULT_VALUE. It's a=
=0A=
> worthwhile test, but not necessarily in this test case. It might make mor=
e sense=0A=
> to set one of the constraints to FREQ_QOS_MAX_DEFAULT_VALUE again, and ve=
rify it=0A=
> doesn't have an impact.=0A=
> =0A=
> Just a comment, there's nothing really wrong with how it is.=0A=
> =0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Test that a freq_qos_request can be added again after removal=0A=
>> + *=0A=
>> + * This issue was solved by commit 05ff1ba412fd ("PM: QoS: Invalidate f=
requency=0A=
>> + * QoS requests after removal")=0A=
>> + */=0A=
>> +static void freq_qos_test_readd(struct kunit *test)=0A=
>> +{=0A=
>> +	struct freq_constraints	qos;=0A=
>> +	struct freq_qos_request	req;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	freq_constraints_init(&qos);=0A=
>> +	memset(&req, 0, sizeof(req));=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN),=0A=
>> +			FREQ_QOS_MIN_DEFAULT_VALUE);=0A=
> =0A=
> nit: you could do this check once in a dedicated test and omit it=0A=
> in other tests to de-clutter=0A=
> =0A=
>> +=0A=
>> +	/* Add */=0A=
>> +	ret =3D freq_qos_add_request(&qos, &req, FREQ_QOS_MIN, 1000);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);=
=0A=
> =0A=
> similar here, this test validates re-adding, another dedicated test=0A=
> could verify once that the aggregate value is correct after adding a sing=
le=0A=
> request. Checking the return value still is sensible, just in case.=0A=
> =0A=
> I guess it can be argued either way, checking the values every time is=0A=
> extra-safe, omitting the checks reduces clutter and might help to make it=
=0A=
> clearer what the test really intends to verify.=0A=
=0A=
The complaint of "too many assertions" is odd for an unit test; I just =0A=
wrote enough code to validate corectness without relying on a pile of =0A=
external shell scripts and DTS hacks.=0A=
=0A=
If we had more tests then the constant checking of every single return =0A=
value might get tedious, but right now there are only 3 and their logic =0A=
is reasonably easy to follow.=0A=
=0A=
> Anyway, my comments are just about possible improvements, it's also fine=
=0A=
> as is:=0A=
> =0A=
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
