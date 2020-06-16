Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295EF1FC0E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFPVTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 17:19:53 -0400
Received: from mail-bn7nam10on2126.outbound.protection.outlook.com ([40.107.92.126]:21569
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbgFPVTv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 17:19:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2CPxkR0OvTP1/qYNqKAH34RT8V5ME0BHviL+B+ldtXDDkhZN+ktpJ6tZbhuBdhlxAZ1+3AcrFaPpwrzMvon5/wfV48bgyJL+R6bpFM7WOkbatV6cOg5uBBmf8CNr0uk+ErfW8fDQhmOBWgLGGsWQny6UXfEeK37scAUzZdau59tbl11vizdEuJIP+bVzn3V8gKcxzA7wZ7orowlI4MHlVivPWc19hFppkF6ykAdaL+TudLFKCR4hhkcUCRf4SeKRyA1nlgBsMB7MNrF+CyXVmZ9SR4borwmk/XR3nRmx52PaqPpytZUL1IukTcm+293x9EYksXRgPYcs68juedstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foQN5EN3pNaATvC7oXONodXPGjiZKX1D9GuON2GnfOY=;
 b=P0eINu70pd3IFJmPQ3g5y/HtnnzTIzr1fOf3N+MkugtAxMLOgBaNrm2QnyTBmUxIeviBerXXf8x+ou72cZFz3ZTXmyURRWud/lyBe5K7EHjkAyp+BeeCPEyeWOkntW7IUcHax0K7SfJQpa0Ko2GOPaApmbIVRRTeHh0bhXrjEyTloNEtqEst1hLN6BSASHPPJ2EuLY1XcsJjA4fpOJsv9lIn1l8m0oARUd4vyG5U+kfWLpnk9mgJbo4khUYPFAehC/CVkDaJEx6avsBh24WOcnD3vak1uY7durXaTN2jLh2EFNGOKROGBtlGJhJ/hej3HWcAIYNPyFD2/A0TDMUW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foQN5EN3pNaATvC7oXONodXPGjiZKX1D9GuON2GnfOY=;
 b=pbuF+IDYflw20KZNY4k85Karh/LxPCuZPun0wgQbL8Px3ein+zmjELGg+B2BPGIU79Ykl9bPg8pjrml0htczfPUhYHTItb8QKjeOaR+4ddJkL8sZoqXuA9eF56yTnV2aOy/dHNvIXgRdeesbB/JjdbSV4YGXPIir3wLOFeNnA2c=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR13MB1591.namprd13.prod.outlook.com (2603:10b6:903:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.12; Tue, 16 Jun
 2020 21:19:48 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Tue, 16 Jun 2020
 21:19:48 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: RE: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQogEzX+2AAAAmIWAAAOe/cA==
Date:   Tue, 16 Jun 2020 21:19:48 +0000
Message-ID: <CY4PR13MB1175FC88F500C25C6D8799F3FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sony.com; dkim=none (message not signed)
 header.d=none;sony.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3b39c1a-3c3f-46e6-7580-08d8123affd1
x-ms-traffictypediagnostic: CY4PR13MB1591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR13MB1591F36EF8C7A0CE5F6C6FB1FD9D0@CY4PR13MB1591.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWcJ1CJfGI6iVUUPd5w/Uobp53ebcgG+akrrT4lw0GH3X7HYmq197vHAj6kzcWJIAbNUVBRSuOWsZ/JjxgMW1tLQVEurrYHluaMmFtgNPorOhke0ZvMWqvJ5YhOcVbhWKRMtJjj233VUBA+irQYOys0U2iRAGC+A7X5aANCkqvrqs789Pzt57C4IHPL7XBBeWGazlXlOCj3CI+IpNBjq+nlVWtKT9110+yiO3Qs3ZwCMPkLAMCjSnMNyI6RyzEDOuXopBjZ2X+dFrs5t/zpyt2G0c7cXFz2Gx8ZQvukTCZZcPXDX4Aiq/DMhDJDkyUbGB6Y8sa/Kj9PKrn7qCsyFMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(55016002)(9686003)(4326008)(478600001)(558084003)(66446008)(66556008)(64756008)(76116006)(71200400001)(66946007)(110136005)(33656002)(86362001)(54906003)(5660300002)(66476007)(316002)(2940100002)(26005)(186003)(2906002)(52536014)(7696005)(6506007)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZBPAZsPuPToWu4/ch5auTdoR2ZVTOFzjCiPi82R/PDXRHPUCeSyRt6mYLcb9RqX0HCXrQEv0Af11Z41Lx/5ZugRTydVAIhE6myTMkUZmZhny4MT80vVIoJF6qRfnEgE4KSwQ/riGlZRfbEgel+xB7CKnVYqca3d6lOFJy6f+RBjajVEgg9V+zb1Xr/7FvlnXS7iWgnNoMVYu4wUmTxEdU/qFPe3Q23Rovs3M92P7sfLfEOY1Bu8eGWZPC3r9qwnS8/ejNYjae6KRXFZOFxwx/rXnHc9XM2vadKah5CQp/z9MlZ9+UawdScS3/A9zcKszD9J4zf7og0kGgEJMpD1ttemiBK1UMKrvt+twNZTDAuDlWjFWRMbg95U/XB5yPz5cU/PMUTz1pe+7SZmffc7mwYhqOZHZBOgy3+3GbozHKlwQv4J36Qb10YV3GI09F7Stutceh5lXWtnyeVI+6iHreJzCVKpwsncRcZwFIpi2zME=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b39c1a-3c3f-46e6-7580-08d8123affd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 21:19:48.1885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mol11urQmaweqy4+riycww9rxR3JsYZTKpsBN8RFP6EsOtcr1DbbQEXFU9bA9V/9+Sh7JSlX+bWCw3z2NieLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1591
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Bird, Tim
>=20
> > Maybe in Documentation/dev-tools/ ?
> I'm leaning towards Documentation/dev-tools/test-results_format.rst
Ummm.  Make that "test-results-format.rst"
(with a dash not an underline.  I'm not insane, I swear...)
 -- Tim

