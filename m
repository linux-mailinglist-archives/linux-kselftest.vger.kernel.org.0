Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410D9109E0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 13:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfKZMg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 07:36:28 -0500
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:15681
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728538AbfKZMg1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhjhHxnD7Nl86nWZDxthfgZXcyaeZU2vMdDu14V9n9DVlMYHJ3l5AIF2Vz8JT5FI7pYl1CxzFlobbhDwQQwCQ7M1uD6zUFbd6qUODOQBoo+17we8+o036MTyDYbCNdQrrWZajeoxlz/sngz0UpPmTlnfPDSisCltLTb5IKtpxUkoDh9FNaa3Lrqwz6hRwBauOi5ZRuLC5OL0wJiBWa7YQJryX7VA6fG/rMQl91Prl9f5qZq+TE2FadPsqnXjuHOLAssRzSwY75zUig+H7XbRMbK3gGbSyQWwuH1l5fhVmN6aJAhwCSuRAphzqz4rPne70F0rfh/Q/zHnar7Ut5mIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hv+YQKO3queUKgU8JRxEieQBMEfvpJIs+qr4tkZ8/o=;
 b=H+nWZi+/q1DS8vNRS5YBQ1NDnYYdd9cbDG/BOyimSLSFs3oALg6RslSUlfK94KqDWHWHMzTqyIW01ThAuXk5UTxjbPLXiE1k/f9LipY6aZlvxinuWxeda9HC8dF1l9qYNPKKlbvv46KSQYJvldKe00za57M4mQKKimxD6qW+ac9KSsvky+EI+Bf3jpPF+TzfXxYgQfbfC3DzYSCrN3eNcaP4gFFiCMjw0hAmUC38c2kBlmjZtsDZTzTri11gZvjeDjsM61U+iEW6vlAkbF6qTl5QpF1NaP33MpNgG2NXRQxvuDF88E26msvZYecAk2QUbVxRtd2rg8C2LocmbDdO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hv+YQKO3queUKgU8JRxEieQBMEfvpJIs+qr4tkZ8/o=;
 b=f/p5RQM+/WfWsf4znCgNESz7u0VDE40NxK4rTA8AwERoY8StzJKhUbWbYBxGiWO82LL0jjYBgmlbqPG+ODjuyYXEchnuDbTe3p6jEAnIOe/dzlUdRkUB3U9f2KuEdSfdSqSwUbhUqEFuoL9qBqBNVBpClUE6MrJ5GBkizrTd4+Y=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4672.eurprd04.prod.outlook.com (20.177.53.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 12:36:23 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 12:36:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 1/4] PM / QoS: Initial kunit test
Thread-Topic: [PATCH v3 1/4] PM / QoS: Initial kunit test
Thread-Index: AQHVo69Vkiab2WNf8Uavz0kAKoCkHQ==
Date:   Tue, 26 Nov 2019 12:36:23 +0000
Message-ID: <VI1PR04MB7023D1F8F0085897E55BC084EE450@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574699610.git.leonard.crestez@nxp.com>
 <023ab2f86445e5eb81b39fc471bebe9bc173f993.1574699610.git.leonard.crestez@nxp.com>
 <20191125201959.GA228856@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01867fed-531e-452f-96f6-08d7726d3f7a
x-ms-traffictypediagnostic: VI1PR04MB4672:|VI1PR04MB4672:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4672596E0091A31881F4C1C3EE450@VI1PR04MB4672.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(6246003)(33656002)(6506007)(6916009)(9686003)(478600001)(86362001)(25786009)(44832011)(74316002)(186003)(7696005)(102836004)(4326008)(4001150100001)(55016002)(76176011)(305945005)(7736002)(53546011)(71190400001)(71200400001)(66476007)(2906002)(66446008)(5660300002)(52536014)(54906003)(7416002)(8936002)(81166006)(81156014)(76116006)(66946007)(91956017)(6116002)(6436002)(14454004)(229853002)(99286004)(3846002)(446003)(66066001)(316002)(14444005)(8676002)(26005)(256004)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4672;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBLc9RgLUP8fD0yNIomOJ5IlfD6hTX71WXDGYqiZtU2hOojBwfUlY2htYHMp3uDjLGaiP0Yw19DN9h20BYfqNsQ2M+g2XYyuYkrdnZLas88Cbo+F8Km4/srex0dktacVqn8qS9/GH6W6mtblrqLxjp45DNSg2+4097W/Ez87BHwpUHRrvytJROS50K0kLbX0H52dDEqqao5RZtkICJKYaZS8M2vwJuosUj5plBroprzWGhwhakHtJ81A9Pm6S9/w05o6Fmqr+4riUnQHwazpQBlWa9gnrRumQSguYVFaVTgQFDTytJxkdkSEJeYYd25LVkavq/Tik6LBFQAg7VruJ1mcuWF5Z8i6zbQBQbqQGx5wXV83lxOMqLY9TOdXRBvs2VQEA0OZ6ZnUqYEcM2M85YwVagiQVKqmzx+yYH5jZ4cgvG+H2U2TJkeqhfaY9nt8
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01867fed-531e-452f-96f6-08d7726d3f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 12:36:23.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YElGOdlTVR0I+9gYMWuIgJ4Zjk76qjG2T3JB1koaMAbHW4dS89U2j2VDeNLYmTwX7SHmcXfdk1sR0YmPrHzhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4672
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2019-11-25 10:20 PM, Matthias Kaehlcke wrote:=0A=
> On Mon, Nov 25, 2019 at 06:42:16PM +0200, Leonard Crestez wrote:=0A=
>> The pm_qos family of APIs are used in relatively difficult to reproduce=
=0A=
>> scenarios such as thermal throttling so they benefit from unit testing.=
=0A=
> =0A=
> indeed, a unit test is useful in this case!=0A=
> =0A=
>> Start by adding basic tests from the the freq_qos APIs. It includes=0A=
>> tests for issues that were brought up on mailing lists:=0A=
=0A=
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
>> +	freq_qos_remove_request(&req2);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
> =0A=
> This checks (again) the return value of the above freq_qos_add_request() =
call,=0A=
> which I suppose is not intended. Remove?=0A=
=0A=
Should check the return value from freq_qos_remove_request=0A=
=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MIN), 1000);=
=0A=
>> +=0A=
>> +	freq_qos_remove_request(&req1);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
> =0A=
> ditto=0A=
> =0A=
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
>> +	/* Remove max 2000, new max 1000 */=0A=
> =0A=
> the code doesn't match the comment, max 1000 is removed=0A=
=0A=
Fixed=0A=
=0A=
>> +	ret =3D freq_qos_remove_request(&req1);=0A=
>> +	KUNIT_EXPECT_EQ(test, ret, 1);=0A=
>> +	KUNIT_EXPECT_EQ(test, freq_qos_read_value(&qos, FREQ_QOS_MAX), 2000);=
=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Test that a freq_qos_request can be readded after removal=0A=
> =0A=
> nit: 're-added'. It took me a few secs to figure this is not a about=0A=
> 'read'ing something=0A=
=0A=
Both re-add and readd seem to be valid, I'll change to "added again".=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
