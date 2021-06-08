Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182E639F4C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFHLSR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 07:18:17 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:38752
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhFHLSQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 07:18:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMCgd4tsKAF6CN5+ffSddHKMEisYx5dbrWBTJhXc8pny00kVUxze/RUADk+hm9L6VOB2WKFrFEePstKvXLdjL0gV6cP/fkUfm8tUpW5yVAsvjmVKpTBNt2CLrP6UuKcA5gQaZfp82URJf+wrQ59Z2DHB3MlB0/eYepsSkoTkgastF/Bxn9Kr54rWLNkBxRoBCL+IlilM/iY1zqKX77m9/GWfVoMsBYqFqPl2IvrDkBl/XbA4thL2ukuHcMUuX4AWjEr7pLwWMBFI3iuaGrkbLBtVDAAWS4KoSDrXk2nGcmiMmTc0SQuBvRrwOCvSGNdlSv8YPUiYWTqRoDr1LDs9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMQRqdfrNlnVHrOoND/pYx50cwbDwRW62CaQKzZZjEY=;
 b=G2VYndVLjzuXj7tH1DcdzeqLR5XkBC4mnlRmT4My8aFl0PIRWRCYPpE6QCPL3FfG/gYhFYT9++Ocsn5GuGY8SWNRWu8tYsJdcJNvK4EeWnH07IYHu5lGAf6s4+JWRdXmVg805sYD2ne/VIqocMTX/V7RTkYs5ctEhDRM7b0kNZZVe663e5hn2vxwZeAIjLLd8ofMWXR79WOzdow349eNmi5NQNm18+eOYTOBRpuySCeF2Ig8DjlAU6VSpyVlnJrTjmubnNi3pAmq+GFD3wngkKlj4A0lf5GmsoxX4c87Jmx/SmR9owSJC9axMwK6vNxPJEkjLlmBHSXsQ4xfgLHcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMQRqdfrNlnVHrOoND/pYx50cwbDwRW62CaQKzZZjEY=;
 b=o6YSUc8FpJCgnPXryPLBmy8RJmIYImRaEpMWF8xY+yyzdeOjC0fEapEbPn4c/mTp2n48uxujHce1kyIdx2osxtgIlIKoUBWRheee38zahmIULtMtXWAwqTEC7KJDRuON+tCWytWBGwJbTShNGzSRSk+PDYt6XY4T/T27DL1mNIk=
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by AM0PR10MB2660.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:12f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 11:16:22 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2045:8ad3:7c24:79e3]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2045:8ad3:7c24:79e3%9]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:16:22 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: n_gsm testing
Thread-Topic: n_gsm testing
Thread-Index: AddcUwsbkicpjRrGT++L4xiApDAcbA==
Date:   Tue, 8 Jun 2021 11:16:22 +0000
Message-ID: <AM4PR1001MB1378B2157237608D4A989035E0379@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-06-08T11:16:20Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=feec5f29-3f64-4266-bfb7-e15f364d52e6;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=siemens.com;
x-originating-ip: [165.225.194.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd2b2066-9e0d-4186-0424-08d92a6ed8f5
x-ms-traffictypediagnostic: AM0PR10MB2660:
x-microsoft-antispam-prvs: <AM0PR10MB2660B2576FFB5BE29AB75EF7E0379@AM0PR10MB2660.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQnZaVp/Ayd2hDxADxSpdw7nF110udUoLj1xWDr4OGlgqCj2FU4JJpQ8FeflmYKr2fC9YHj5LodYju6mLIk78Auu1zyrD2mhV0bDemIYsE6QErSQ5Sa7Ppso9Y6879TM7MaWPjyshUJAXyklQ6gDegt9i+pE8w9XhFd/95dlTX9LQtcm65Igq2fedD/OyGrBb8cqjvf5SLOFg1kyAsQip/r1yiZrp/Kps0nad3AP9WPdwaCVKDFUoTFh3xvPMq4FFcTCOvcH0nmVoEPiEY1FjrvrdX4SO6xga19Rk7knN99Fy2QuziDNqgNe58J2U1/Gk/p2L00Sy5q8lKe1+rDB0zNmEfXkwoXvjSbF0hrXKeIwjASq5OFOKXueTgWi2uQvJ8kHdoxZ7XVuILuOXQ4xxEM3QbukTnoHdrOzFqEC9wHM368qoYCXon1LDdO5QbZSE6IYfU+j8jlYxnHPbhF7MNmlxBU/T2emsEdi9XiFguMtxtip6yhTzI0TRz9REe7u8j7h1STKXHNarKODlPhDHCtRjpgxNhcPss7JPKX7hRbwAhLY8Ye9RyeFdsyIa2xXSDiAurzUwnsi/KIzEqN7TDGtxtHWWsagjfBYQNY2hJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(76116006)(4326008)(8676002)(66446008)(110136005)(6506007)(7116003)(66556008)(66476007)(86362001)(38100700002)(64756008)(122000001)(71200400001)(186003)(54906003)(55236004)(2906002)(55016002)(498600001)(33656002)(52536014)(4744005)(5660300002)(7696005)(66946007)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JC3kWiN/JC7IN1wMPuxWPfuey6IsOYof2vor6Yh4QpSnjNs4jLUz8ipgqXlt?=
 =?us-ascii?Q?5LWKkejwzmgWGVyeFRfcRHa8JGHbJzUdjci2T5mYbp81ZoSh7Vb5VYaAtHwM?=
 =?us-ascii?Q?UqW3Iy0mzkN41oBGyCzpMZSwTvQN+6rHOm8qN1WMKZV+1/aUoKOk7tcmeJqd?=
 =?us-ascii?Q?F1mMTybHI5FV8thA/jF8Z8DzVoBCxKo1JlcaPf+5XLDA+1OIQxmm/DlnSisG?=
 =?us-ascii?Q?3Kks+OeYRAHXWKsu9UCrHXJu59ppZKJkiz0mmAz+VuzYo7UcR74DKo3iVVnT?=
 =?us-ascii?Q?Mzb1vZEOdBWIp9kE5OgpjPM7+MUsaoEy2okEvnia1PpRuUqGnM3XyrPh4C//?=
 =?us-ascii?Q?imVXwjWHqCCka7YllClJPBx0+RrZSswsTkRBVRZqXSm/9yJslDRnmyNqXhWP?=
 =?us-ascii?Q?CpiszdQvf9a/CJe0cBg7BV1SLouUJh19lKgBTm1pjOrgMZ4TO7SwiwMN5Eii?=
 =?us-ascii?Q?DdTtIs2ah/y+v8Wo5eECuo48xaW2OobQcohr9JUVY09GJnpAIPksweFuZ5Q/?=
 =?us-ascii?Q?m0Uh/utbS3CXr8wiAvJSgMl8iSclhtGzI4bcwF7z56kOhhLEhNhohoj0NztZ?=
 =?us-ascii?Q?zqoZ2ATyZTI4IFkj1knBgde14sfxOkpZB1qBdWOadKyvjmmH7loGitsBEG7q?=
 =?us-ascii?Q?LmW4evz9Vgxz+ho6yM+2p0gbpxErWxKVuRrnRD621lbOr2Vj/5aH6PqGMoV6?=
 =?us-ascii?Q?zWTnpph9pnR6u5ODNbkY539aEJGCg2HFzFzA9ZSzZKsGABnm+nLCTGrfeb3f?=
 =?us-ascii?Q?2SfZgF+ff/++3GJO4fpcGk9yXwiohoNpb/7MNh9wjhQFDCf4Pb+IVTZtw3P0?=
 =?us-ascii?Q?dcN1LR8jFAsLoaybrKV+l9CipwnaDMMO9LViErTOY7uzATmfAnxd46Wsg5sX?=
 =?us-ascii?Q?eLhKrvspADQC+UsnEVi8lb9OU7MtPcwz5ZhLDfSB5ZeB+LihUeIl0L0ndalo?=
 =?us-ascii?Q?EcGmGHyG/COGmXD5W0i5VW71u1pDYnMW++avRHdigsClW02Wq6XifnIcTNaI?=
 =?us-ascii?Q?vEhg2PF+uVOBf005NRcS1vd6QVQ8XxHYh21kUlDtTVwQnMcf+l6FxGWr+kkE?=
 =?us-ascii?Q?A4tDji5v8Sxu1WGSU31fZXGdlMo1Pzqrb0itXwgDoKFdf1YeyY7/VX8Rjg4z?=
 =?us-ascii?Q?tmudi6AaM2a3NkfrXlyvM6ksdZeHtXe8Usc5SDZ9+YcPFa9d4fIuW7cQ+UK/?=
 =?us-ascii?Q?3mTSVjPSD58F2Fd649LCPGnH5dB7k9POnD7UxZmj/LfgyGlTy6QE8YRRO3DW?=
 =?us-ascii?Q?zgUvKhLp2uBZbmRID9IeKrREFlE+xNUimIiOiMuRr/4b+AE6dTwxWNtIBwZP?=
 =?us-ascii?Q?3vNLuciz+AKeVnYC2h4w0f5E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b2066-9e0d-4186-0424-08d92a6ed8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:16:22.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geh0sNvdFfGGgBAhmeZ+Jy6l+nsKvHJWfWbcUK+EyVkw/+es25p0kC6C3/Tx95+g2QX0DSB45UPzffMKGnegnR2VRBjdpqT0SHnbwzi5fMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2660
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

I plan to contribute to n_gsm for better support of 3GPP TS 27.010.
Is there any test framework/suite for this module that I can use to avoid r=
egressions?
I could not find anything within the kselftest framework.
And if there is nothing already available: What would be the best place for=
 this?
=20
With best regards,
Daniel Starke

