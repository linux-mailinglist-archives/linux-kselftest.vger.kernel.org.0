Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF333BE641
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2019 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393083AbfIYUUU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 16:20:20 -0400
Received: from mail-eopbgr810122.outbound.protection.outlook.com ([40.107.81.122]:8640
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbfIYUUT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 16:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K08C5SrLVjH7pG+jmuYN3DKP/7I6v91hC9J8EiQYA2nnaUJ6nSQE7JrlazFruSN8kSAQF3ztsiGnl1z1Woh8Nvu436rQGx5exhWmqpxfyExUvSRVfdLoInpSOkn48VbQn0Kb1vUd932+SuWrspIKNadhjxPpWzWOebvZZXz1MYqklAkfDHXsNeUJ5nk/mDaylWg76ooG47zghGxFZQ9Db/idEIDxdejWEPnfrzZK+EEio+OcighQ3iZt6UPMMUArga16okMqQnUArOCnAqsTVcEX2J7aY0yaNG3PHgL8fwVh4KCr3q1rQdDnMaVtSj/zTVJyyTugxyLHg+nSVPDN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiwFRSJv2GVPFhdUNhsFL2MMxzWIVAoiq7Vz0F7dRn4=;
 b=flU5fHSjhRfTyiBWYnb/3Xdbjqchr1PRkVsqJlKkQpqaWkkEqY5DJjvoOJRQ7en/2IKibENerzuC13IZbgiQ1xFd2JHByzNv4hGV1gIlhFNe2FQOZCwZL2BOf2tKnd1+Q+BWCNhIhaebKj+Zrv0KiYkZSJWc+oK4jtloiDKKj784D0TpAg8qEeQzW4qmioCA/LN6HfzS8iihWbXlOBGf+rAlXjPXVWLK5qE+AH6sRk6HMhjYYaXdZn9D4dcSsaueOHOkxgqNj6q3etQw2B5pOWbR/SCcSDnEopSQ3sAvwfcWiXHGcwJMO4lE85tvH5OmPeBX0IL9gBqsmfHbgmx9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=arm.com smtp.mailfrom=sony.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sony.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiwFRSJv2GVPFhdUNhsFL2MMxzWIVAoiq7Vz0F7dRn4=;
 b=APJW2ACwoxnY+Lh+nFdQuWc0PIH7MZ1QcwHu5nBANawqt7LkV38dsMj4MHDtwEBsDPDSvO2bx0e7sXtIHZ2E2IRX79wQDKQkLkl398SgteurQv1JHzn+wbobm8y0ucOBg0zoybSg6qaQaavaZ/QL0zzuT3e8lC0YeBRWODpI7TE=
Received: from BY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:180::25)
 by DM6PR13MB2939.namprd13.prod.outlook.com (2603:10b6:5:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.11; Wed, 25 Sep 2019 20:20:17 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BY5PR13CA0012.outlook.office365.com
 (2603:10b6:a03:180::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.12 via Frontend
 Transport; Wed, 25 Sep 2019 20:20:17 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25 via Frontend Transport; Wed, 25 Sep 2019 20:20:16 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8PKKFRF001393;
        Wed, 25 Sep 2019 20:20:15 GMT
Received: from USCULXHUB02V.am.sony.com (usculxhub02v.am.sony.com [146.215.231.16])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8PKKFmQ019631;
        Wed, 25 Sep 2019 20:20:15 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB02V.am.sony.com ([146.215.231.16]) with mapi id 14.03.0439.000; Wed,
 25 Sep 2019 16:20:14 -0400
From:   <Tim.Bird@sony.com>
To:     <cristian.marussi@arm.com>, <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <shuah@kernel.org>
CC:     <dave.martin@arm.com>
Subject: RE: [PATCH 1/2] kselftest: add capability to skip chosen TARGETS
Thread-Topic: [PATCH 1/2] kselftest: add capability to skip chosen TARGETS
Thread-Index: AQHVc6S04USvYnGSCEmE8aUG8m7ED6c8zSQg
Date:   Wed, 25 Sep 2019 20:20:07 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977BD152@USCULXMSG01.am.sony.com>
References: <20190925132421.23572-1-cristian.marussi@arm.com>
In-Reply-To: <20190925132421.23572-1-cristian.marussi@arm.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(13464003)(26005)(316002)(11346002)(336012)(102836004)(8746002)(426003)(97756001)(55016002)(126002)(446003)(66066001)(186003)(55846006)(7696005)(6666004)(86362001)(47776003)(8676002)(478600001)(4326008)(46406003)(476003)(356004)(8936002)(110136005)(70586007)(7736002)(106002)(33656002)(76176011)(246002)(305945005)(2201001)(486006)(70206006)(37786003)(6116002)(50466002)(23726003)(6246003)(3846002)(2876002)(2906002)(229853002)(5660300002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR13MB2939;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail03.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94766a6-4690-4989-eab2-08d741f5c79c
X-MS-TrafficTypeDiagnostic: DM6PR13MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR13MB29392F9B870059F913D511ECFD870@DM6PR13MB2939.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 01713B2841
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyo3VxXIsoOy4MyKYdv6YVhQqJeXmezW77xOHuf03UK428c/1DWrwRl6FxAoJvuxfemFLV1Pd7Ay7RQbY9JwR2BU/9zKbShuXhJDJgO1wAjDPdpG+wuxZuDLymvYDoFYz2lh1VQsmegWS7DSuTqAIVAOsri17olXtY3LyJfilz43YdYR3Gbr9/TsD1RWKNvwaiFTvHUeyKLx1BWvRsNQGeLs7Jc1gxn5LEV4La6iSwY9LpRHTVkY7vV/scfCXzqkXO2Q0b1ZpYzqZQKrJCcClJ/Bzjl3/qbdlluN76H+mCwU3bJ5uYTgfQllOlKkhag9aCx/Z/NcEfRPbcvr0lB+QSXrCYavhW05JZMNnB0hcU4nwYczbLPhvpqJ2qSM+pZum42ndEMrAFTjvU1TBuzw3Y0AkQaShtJ0zCzVm5dPpjE=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 20:20:16.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94766a6-4690-4989-eab2-08d741f5c79c
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2939
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Just a few nits inline below.

> -----Original Message-----
> From: Cristian Marussi on Wednesday, September 25, 2019 3:24 AM
>=20
> Let the user specify an optional TARGETS skiplist through the new optiona=
l
> SKIP_TARGETS Makefile variable.
>=20
> It is easier to skip at will a reduced and well defined list of possibly

It seems like there's a word missing.
at will a -> at will using a

> problematic targets with SKIP_TARGETS then to provide a partially strippe=
d

then -> than

> down list of good targets using the usual TARGETS variable.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  tools/testing/selftests/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/testing/selftests/Makefile
> b/tools/testing/selftests/Makefile
> index 25b43a8c2b15..103936faa46d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -132,6 +132,10 @@ else
>  		ARCH=3D$(ARCH) -C $(top_srcdir) headers_install
>  endif
>=20
> +# User can optionally provide a TARGETS skiplist.
> +SKIP_TARGETS ?=3D
> +TARGETS :=3D $(filter-out $(SKIP_TARGETS), $(TARGETS))
> +
>  all: khdr
>  	@for TARGET in $(TARGETS); do		\
>  		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
> --
> 2.17.1

Great feature!  Thanks.
 -- Tim

