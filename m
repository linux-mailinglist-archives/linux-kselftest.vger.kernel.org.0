Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4476D1FC426
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 04:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQCau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 22:30:50 -0400
Received: from mail-dm6nam10on2133.outbound.protection.outlook.com ([40.107.93.133]:20513
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbgFQCat (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 22:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O45XG91kwVpRW9W0Igxo5h0+E5N/fW3mmXEdzkYG3pbEHYuCWwxjPgDKNMeFEtxRjuAYnQlRCi80ZtsVtoqef0hKOOHwRJWV0Cxf+Qj/sOP+WDHrd+G+JqHvQggDsBFAa3T9xlao9DIdQ8tK/p6c9qSysb4fAMmH7r1jr2o2EG08bSJVyDr8PYZIGhOA09fTL6X8A2oYhJjXVGIZKQftz4nyVyx4NvN6OzlaBLICKkJ8dXfYsR2PIGb9OQINo+1IG2qt4UGtfM5Nqt74xOPakPwe/M4mA3sad8HgSkYZfRtPkEnbRoospa/DTdC8/v2ykR5BSYgK/NRyBQ2LOl0KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH9MJfBzDTmOYAn47dlwC+0lp99Z9cxtad6I4/XFsZs=;
 b=nYZPv+N9kltIORY2bD9YX2U2T6FxcI3Xyn6WSrSBgb8zcuAH4YgbmAcNtIIAxrGU5PmzWDl/HC0SoJ5PGXE2XUy3nHRDb7Pecv4Q7Mw33kqORQT/2YxdYtVKGIwwsnslVfMX4Q3niVOuvRRoz4RdAqYu5lKZEI/mIQA35G5BhiYv9/2HrK6xPt5TGhylfkvZV01lxX0eFiaKe8JvvhZgxEJyrnMlTYqcIlEeoqaKhoVUDQunDDtH3bSEfPx+3oVojpKc58a9YjkbcMysz06K83chbqiYpMcbAKZhFR7nTCD92XNoF+MdGoaJ11/bYcPBixfG/Tkpi1mwc1316scYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH9MJfBzDTmOYAn47dlwC+0lp99Z9cxtad6I4/XFsZs=;
 b=ntvDjUw1MILJ7AFiovWrEXRDBOhOE+8sxUEpDyvM0M//Xnfo8KssbapHCSJ3kj+1Lm46DNCNi94XQzN+IJMdE/iBMzTziI4XlGuTb+z7qPgdmF8w+wwFiPYfW95F//znraD+/FLbSmBkBfBBpg3m64wpG+kOE03fQqTig7iTU7U=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB1957.namprd13.prod.outlook.com (2603:10b6:910:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.7; Wed, 17 Jun
 2020 02:30:45 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Wed, 17 Jun 2020
 02:30:45 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: RE: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQogEzX+2AAAAmIWAABsPVgAAExn9A
Date:   Wed, 17 Jun 2020 02:30:45 +0000
Message-ID: <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161703.B2E51605@keescook>
In-Reply-To: <202006161703.B2E51605@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cbfa04c-9439-480e-2783-08d81266706d
x-ms-traffictypediagnostic: CY4PR1301MB1957:
x-microsoft-antispam-prvs: <CY4PR1301MB195759E24D0AB5C96F4F8220FD9A0@CY4PR1301MB1957.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDa0/sR19yWNZqoXxE9xMro7IgStIHpnkvzml/iM52ctXR/RGpHUb2Wsqzf3aQiNgTH1hIm8tHONAscCY5QnWaerJfTk5NPzHG/3mqZw5iacg0VFaAf431aloQYMranIZaN/r8zspIbdlCy9O21Z0/OnrGaQIKJJcgaTjYify+ic57iNUUv0xrQ3Ls7AhchE3mwimMUr24RiK9XBAcCDUwzPoNV5spPtK2J8DGyyLUtg6lNhAbw1NiZiJ1rLVBxle0t4T1BltNi396bmoNQoH6mjEGC6ZmShrKoChocRsFAmC8frjkKbo0GE6EejDaO1qCxb7dIBC3TG2zNRckO0TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(5660300002)(6916009)(186003)(66446008)(66556008)(66946007)(64756008)(76116006)(8936002)(66476007)(8676002)(71200400001)(26005)(2906002)(54906003)(316002)(478600001)(33656002)(4326008)(7696005)(52536014)(6506007)(83380400001)(86362001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +dZFu85551v9018U+Fmi5yNKByKY186v6fW8S6XDVweWTFH51otWYmdjvKE37+dfKtN+WH1709/UhvPOTNXUD/Ol3V0tmZF/0VqPgu380ij7PMOkyaUxlITyY4a7jv4+EKKYdY3dlvNHvDW4rqOTJVwSMmijsJSe//fMeTYSZpm50UPKsHSP7fM1JSqGSwILKeJbjUWEMmpEJwGEdsoORmNgbfqEVFpM5w5fnTzE/sTEZcAhaOq0XbSNsjFgmEI4bWESjWMQnTWIOE3GVzP+rtAWkjmjnPbD/edoZOg+x8GCYizpsoHwz2CY60njpN+xbZAqGBFISd+u7NSYfS1doNz+xC3xFwOvgD0J6+N8nRfgj+FQfVzT0nktMDbxOA1cYECdbHs1e5xpPhRWm0fM5h9CJw3RynnwH//m5+vzRmR5rB4BixOw23uSrLpGMGjiq32yszd0gItE1Txl1hIU8uc0+R3cUNf0FjaliTRczo0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbfa04c-9439-480e-2783-08d81266706d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 02:30:45.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akndlvcRFDy+Gd3ayiJdXLK2pFHc3KEBAQLudAbWoGXA37yev4/5s6hH7YveJRHEFK5zlHCbg5HP/mzsCtfJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB1957
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Kees Cook
>=20
> On Tue, Jun 16, 2020 at 09:16:01PM +0000, Bird, Tim wrote:
> > So far, most of the CI systems don't parse out diagnostic data, so it d=
oesn't
> > really matter what the format is.  If it's useful for humans, it's valu=
able as is.
> > However, it would be nice if that could change.  But without some forma=
lization
> > of the format of the diagnostic data, it's an intractable problem for C=
I systems
> > to parse it.  So it's really a chicken and egg problem.  To solve it, w=
e would have
> > to determine what exactly needs to be provided on a consistent basis fo=
r diagnostic
> > data across many tests.  I think that it's too big a problem to handle =
right now.
> > I'm not opposed to migrating to some structure with yaml in the future,=
 but free
> > form text output seems OK for now.
>=20
> For a CI system, if I see a test has failed, I expect to be able to
> click a link to get the log of that test, which includes the diagnostic
> lines. The other reason to have them there is to show progress during a
> manual run.
Agreed.  You only need machine-parsable data if you expect the CI
system to do something more with the data than just present it.
What that would be, that would be common for all tests (or at least
many test), is unclear.  Maybe there are patterns in the diagnostic
data that could lead to higher-level analysis, or even automated
fixes, that don't become apparent if the data is unstructured.  But
it's hard to know until you have lots of data.  I think just getting
the other things consistent is a good priority right now.
 -- Tim

>=20
> > > Yeah, I think it would be nice if all test frameworks/libraries for t=
he
> > > kernel output tests in the same language.
> > Agreed.
>=20
> $ git grep "TAP version"
> exec/binfmt_script:print("TAP version 1.3")
> kselftest.h:            printf("TAP version 13\n");
> kselftest/runner.sh:    echo "TAP version 13"
> resctrl/resctrl_tests.c:        printf("TAP version 13\n");
> size/get_size.c:        print("TAP version 13\n");
>=20
> Looks like there are 2 tests to convert to kselftest.h, and then we can
> just change the version to 14 in the header and the runner. ;)
>=20
> --
> Kees Cook
