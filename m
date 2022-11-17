Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801C362E3F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiKQSSb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 13:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiKQSS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 13:18:26 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3ACD1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 10:18:20 -0800 (PST)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIGDM2007300;
        Thu, 17 Nov 2022 18:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=sNVypt3H9wUUA4yzd3lr43Mw2nwOq/kLmv9U7wqM1xU=;
 b=p13OJQqgUq355Fxy73xZFtq0XYjOvle2alJQKCAzTnzqH1CqUbycpVR6BfDDkQshWfuG
 mmd0OrNn1bOb3Rltlb7+OCi5ef6AM5JXk/OjIM2mNVTN7cjFp1ssLoaH0WTbMnIqjqrE
 SAY7OdBYvJKMTFdKmddccDMIJrEJ3k6dCOAxIMTphISBytaWkcMcY1g0XRYSTGNNYekg
 ER2zhMLn37JP9dSMEVQawyXICr32Os1kBqSuWdzqZ5mFrSdDLtpcZzm9ANtOyXDR6I8U
 3splZOLPn+DQS7qqNlHybkrgk9IoyYcUxoJvlopRF/8gY+BLpStz8ko7DczgOyMUDbqU vQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kwhwcgf4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5LcwTWiu1VgRJAhPpDRiUKqIp9AZq0l9e2Pdz/TODXp8s6r3im2q1NPAF263qizkpzBtJGD6asYrHzOpKhmBslvZqlVa885MjEOyQ93xRvULEiUfRmFeKbqquHY2909U6MoWXkG0pSYC9sWc48EgHBtS+9JPT8iIrO1mQjyEyuM4TmjCdCE4B8CRrm616a5b8BWwLYCBpju0NM+HCLrBVDsn+mcM6ILEAgltsKxcCbLZPMNY8r2hluH12f/D5SXuWOy/dlOxJvhaHXp3YpY9z0jER7V0PETHKFVIc/JBLgI70/bMzkDN1YDZC2m2wv2oLf8tge4bxkOryidq2p2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNVypt3H9wUUA4yzd3lr43Mw2nwOq/kLmv9U7wqM1xU=;
 b=hvIb5rzy1XugwSJaNG3O1hp51gUikfx35pJKtjGPB9DHQ0ary2jEHEHTc5Ijyo89aukKENxO/1tTkvJGvFv5UJ5VY78HW1WK6pIgs1L/GI6H6IvqgAiUtk4vIF4t+xj4POTQF+HjP9sw2JXyXRJ/d2oNop10Fqk0xi5umDNf+lYOHh69k2xUINiRdQcsFua3Fj40c58roPBBBZgM0e5eRGHen7IkegYhWkTkHvVMyZsMtU5iTdUeqKfPaK6SNOsnlG6xzaMrMPrtAB4XBPvBiFd7X43JxNAaLxGzzhEr1v0fZ0rGWWDmEV+OtONP2y8uWiYieJwSrg4vBwuj5b0Oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by MN2PR13MB3629.namprd13.prod.outlook.com (2603:10b6:208:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 18:18:03 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::d478:3650:b65c:8787]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::d478:3650:b65c:8787%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 18:18:03 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v1] Documentation: dev-tools: Clarify requirements for
 result description
Thread-Topic: [PATCH v1] Documentation: dev-tools: Clarify requirements for
 result description
Thread-Index: AQHY+nJRheuE1uqiEkqMbV8ZQsLs165DaMhA
Date:   Thu, 17 Nov 2022 18:18:03 +0000
Message-ID: <BYAPR13MB2503FB2736B3929F9AA44AFEFD069@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20221117104636.639889-1-broonie@kernel.org>
In-Reply-To: <20221117104636.639889-1-broonie@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|MN2PR13MB3629:EE_
x-ms-office365-filtering-correlation-id: e6bc5c4a-cf5c-4d5b-c18a-08dac8c8113d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+xJ2hz8A1wfwFl2bNTn3rNbIAYLLPWyzFb3iwNQv5JGYsjwzJM2sgNgrxrl0XjUjqdRSbAqawbn1odDMpWKEsBaXfPBn8vISi9YFnKBTbxryg2qoVY3Xqj00SWr/gBz9hL24r9seKcV7j1z8C4oAvSOAOilUcvOi/WMHV5hFCwIzm7EzDqsB0Zk5HT6EFmM0/Gc/02JqSiHVoXVl/QK2aurQFASszAKB/nmDkdkF7gFruGmDH/XdQ5qpi3h1Kz1oMcphywP1Ff7bCxbaNKCUQl5TZbU24xRX70OYS4QuZzSu7OedtrHtWnw31xaSaCHBdos3ljBPfRb3e9h40Yss2w06rmyJKgTavlqE9LjgYpJ9FaV7WFz4uEYLTUXJegJXCad3pvMgo1wS1308Gpx96BH2NSZBYD+3zd+TLQsVLepKVapc1CLmo9dZdy9oXlH7xGGLatwwz+itnMyWNt7PZi7K0uN5mW1L/EvJeI7LQAyRs7pFdb3C9qPgh5eZ5/z9LleOqgi6FEOg0JHzavg8gq1Oure4bLgMNnR0iRbuRL1Jwl40G3fNBWrap+TdJugsB2WZOw7tvL7wVrJwjO2LOKtY46lVIGnq2FI/JwZ/jmpwcO4jXJ7HqbF85WxosvdyJjbxAF9Fiw7k6aqDRYE7bmmmzWhAP+T/tWKXwAESpwVlQwdgnAfnCDPVyTOJXi/SxcUjhXqHQ4CXmynyHlJHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(66446008)(55016003)(83380400001)(9686003)(8936002)(186003)(7696005)(26005)(6506007)(86362001)(38100700002)(38070700005)(82960400001)(122000001)(52536014)(66946007)(41300700001)(5660300002)(8676002)(66556008)(33656002)(2906002)(71200400001)(478600001)(316002)(110136005)(54906003)(76116006)(4326008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rtPOGHKMWb/37cPR67o5XqYV9KpZRJlE6fc0JvD59MSmvgLwjaXPWcFONLyJ?=
 =?us-ascii?Q?OSkhDg5vBBHVKYFt3ZQ0eYpMYmAtRM6OnlFifZoH4L14omfYnC/XfFqEpgZt?=
 =?us-ascii?Q?T93RamQnoDvVVgpxfi+5kTqEZhXrwnvIcKxsU9lc2ODJ361vHhunaiUBkyqy?=
 =?us-ascii?Q?89tGFBEj400kZMSTXXgFg0/BxgjdrRun09cgUj4Tx1Cyilcwdc2/f8Hb9qZe?=
 =?us-ascii?Q?bvCTRimddan55azgkSdzZL+qjx6JJSGL+kPJOgBLTi2N8fMRDo1ziHskJEwZ?=
 =?us-ascii?Q?ReuyocH+NGpL+OOR84eKfn0iirOm8bA7xAtY3lzOkn9Cd4V/BRem1Gs/jYt7?=
 =?us-ascii?Q?gAGd4w8f8FZMAoKCEqgPOhAuvmodtqlPVcqkWv0Q3EPXyGvros3JApkPM8KS?=
 =?us-ascii?Q?7Jb+IQRYK8h+YIlYTG218xh5tRv1xDjg2b6A+wctyNBCF7zdoVgRLBaECwVm?=
 =?us-ascii?Q?3NAD4C3TYwtIwnLgIPcG9+E9iwZWU5t26ZXN5qBh4qvG9L5sdixSagL9O7Ng?=
 =?us-ascii?Q?5yn+HIXsH4Dq05D50mu2KXXLresImmsuNNUviaM2HAwqN5Swy8YaqkV8Mjqs?=
 =?us-ascii?Q?cs6hun8Cm+lrzIerCHNLI4kg+32SoJ4mKbAsGhzrpzz3yIt+EB/YF1lDY27T?=
 =?us-ascii?Q?vbdjdb9ZO86ZFmg6vOc/PVUo/zct5nTo0aCbJMVXpJhrxyA+5NwDeqqAjoJP?=
 =?us-ascii?Q?ndJ3irDaqUyuQ+rAPBb96/dw6ki/8nYYrq+uaSwuYd1m7Yw0pdLMyEPgl/bP?=
 =?us-ascii?Q?85+tbzGH56SLe7oBWz0k9rO+gshawYr2oCuRl0fIBFM8/TzEjbaHdmUkHDLf?=
 =?us-ascii?Q?VX6sZbaqOIxOsG9zrsE32rixHhcbClLtfGYFYG5q2GwYJsUGvc984qe3N5To?=
 =?us-ascii?Q?cUPXrmC2VrlALttKkhQBUx3trvGduJ8B2oRvG8mZ4to2ZFjwt7qyopmTRtVA?=
 =?us-ascii?Q?kO3Xv4DvK6M5BY5Lmm8qaRjjFpbngq1pjFwuIO6IomUwti1s4E23XI8oDy0e?=
 =?us-ascii?Q?/lnW8JG5OqUC9Gd2S3BeQbMyQnQBWJRJn9zNTihQztVBGTEM4+ydA4E2kYJH?=
 =?us-ascii?Q?wrVigvXXyY3ISJhOatxKYDf9ist590+8xouvy2bh+9wjie9MceDmgYGZn2BK?=
 =?us-ascii?Q?QGqKHqnmJajZ4LJ02kKIF8xzcXGz0+vAyDs1gxpIPFFcI0MSN0ZGvFe7dVxG?=
 =?us-ascii?Q?yfH0EItc305zZdooj3eWgXEGZ6Qq2yUpPeEo9vDUwQpzBadP9+jkwoWcE6Gq?=
 =?us-ascii?Q?3vtrtpiELKhkfUU6GI+6DEnxnAH8ueWoFAn+Jw5n2RODdQCFioEmIclakoyR?=
 =?us-ascii?Q?bjt+1Zuh3MARHmyQY0ytITBiciK3S6+6pbCqzc5ONm4G76GuZJ1y1J6IlpNz?=
 =?us-ascii?Q?ltnoX6OFZ88DSx4U330ig3IeV8Tx+WIsQKmDV6yZSP23ZFh6Gbc2LL65clEv?=
 =?us-ascii?Q?atJ3TJKKXjyXWpFYkBMLhkWtpFGW7Sgn0/EJAsJAz5Gz41f0DOBvuXhWjiwo?=
 =?us-ascii?Q?91SaNjNc02rtp7IThYgr2BnSx2q6Md2DhIjEOHTzqqUkrjJ88luiYKR/vHf0?=
 =?us-ascii?Q?bSptQ2s+dyne0gQZuhvelT8z3he73XdJf3rEhBZR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XcDj1qGx39sypFzNyc6xYVV7NSqOz/OjUgRMttyqwY/H9wTdirMIz13W6j8wuVEXuvW8M4J+tAxzGrehhL232rb0tQzFOKDBXGPqFoGcl4gJxwwym3IFapDgIzTU1j8FWpqz0blF//LTh33A2iY7fWa1s2AQf+bw1NH1GwwwAOChBJxtniq0RjP/ylv7cziJxunFQBaMN1GEssZRFvvQzhevtMWgesbtJTFnmYso0ZULmlRskzY2cfwX2WRoT4nqfsqxRuqCITNkzDoWkilZdxQZWx6HrnnrBOdDJ3lraxa2i4+Nb4pSqCRPu7jlqmUkFqcg+3jpEqQYhBw15kYHYdie5Ns379077gwGApkXeWSS1aAng/NunXoqWDDTbTLbVrnYKs6B12CNufkMg5eJ+y7EMsWCyGbSczseyz6e0sxvr4e4d0qUCbTbenTn93S9VwbfJl/CCd+plYImP20STHiHNVGx8vP3bgkkX9fasbLcINVOCWM9benBtGHeMcHGhFdcDXBG3YlOq6yqIEuFDea94tXPrqk9iODnugWZN9gwA9d1mcDC7Z9mX9vNMgglZVEg23TuCZdfx3QDge0B5Bax2uuyYIqWF1VwnNoitUvJmH6jxUaZVn1RO3S8i9QNy5QAXxoxvvcBSelYtXqPyJpwJ9fjJioUMiVap2sSqvuxsoOizIrk3w0+5hwfVbSAlbGerPumyncJYas+rm6FqoEfAhDiLud3yhrURtStfNBfga4yU30a12KXX2QBvgY+HqzipPe/6+FqUBS/J2ohAuEYxsYQdBtHm+hkFkoqiVgg2QLwexQxtXbjiS2WWZhC4TxXYfcO9h9QtfUG7A6xOB6dRSbJG8UqX3omfPGEhMAUAoMCmkut28K8FGQmpx4NTRDqX1vXusDMsi5oruQDDEUvnOgecIkfK+POg7nXcI8=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bc5c4a-cf5c-4d5b-c18a-08dac8c8113d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 18:18:03.4308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4k/Do+z1yeGp9b7O31BuGNbV7K+tfg3UsLT3pi4fFlnOHtI8fRKErKtoscSvYooN9Z2ILZNrVpYjjThI6BmtxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3629
X-Proofpoint-GUID: YP5VX2byPqJube4pPZqdgk0S97D6PPQk
X-Proofpoint-ORIG-GUID: YP5VX2byPqJube4pPZqdgk0S97D6PPQk
X-Sony-Outbound-GUID: YP5VX2byPqJube4pPZqdgk0S97D6PPQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
>=20
> Currently the KTAP specification says that a test result line is
>=20
>   <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>=20
> and the description of a test can be "any sequence of words
> (can't include #)" which specifies that there may be more than
> one word but does not specify anything other than those words
> which might be used to separate the words which probably isn't
> what we want.  Given that practically we have tests using a range
> of separators for words including combinations of spaces and
> combinations of other symbols like underscores or punctuation
> let's just clarify that the description can contain any character
> other than # (marking the start of the directive/diagnostic) or
> newline (marking the end of this test result).
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/dev-tools/ktap.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/k=
tap.rst
> index d0a9565b0f44..414c105b10a9 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -80,8 +80,8 @@ have the number 1 and the number then must increase by =
1 for each additional
>  subtest within the same test at the same nesting level.
>=20
>  The description is a description of the test, generally the name of
> -the test, and can be any string of words (can't include #). The
> -description is optional, but recommended.
> +the test, and can be any string of characters other than # or a
> +newline.  The description is optional, but recommended.
>=20
>  The directive and any diagnostic data is optional. If either are present=
, they
>  must follow a hash sign, "#".
>=20
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> --
> 2.30.2

This change is OK by me.

Just a comment while we're on the subject of weird chars in the test descri=
ption,
I'll describe what Fuego does with these.  In order to create a unique test=
case
globally unique identifier (TGUID), that can be used in databases, json, fi=
lenames, etc.
Fuego converts spaces and other non-alphanumeric characters in the testcase=
 description
to underscores.

In particular, it's important for Fuego to distinguish between testcase ide=
ntifiers
and test suite identifiers (and Fuego uses '.' and '-') as delimiters and s=
eparators for
those.  The underscore conversion makes collisions possible, but unlikely w=
hen a
testcase identifier is qualified with a test suite identifier.

It would be nice if we could get some consistency between LTP and kselftest
(and the rest of the tests throughout the industry) on the delimiters used
(and allowed) for different test element identifiers.  Maybe the kernel
has enough weight in the OSS ecosystem to set a standard here that others c=
an follow.
 -- Tim
