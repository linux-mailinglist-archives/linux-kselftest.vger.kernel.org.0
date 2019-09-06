Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A708ABC86
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392659AbfIFPbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 11:31:38 -0400
Received: from mail-eopbgr790104.outbound.protection.outlook.com ([40.107.79.104]:14752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392618AbfIFPbi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 11:31:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMlpSL5YePak2aiAYzHzviaAZFM35skJObBUbiWZdnWMTv8utoH0cqw0TLUKDsyf3lk6ubY7tCvSYRRD5Vi8+lJxvXUyY19BSSIB0H192A8GXYsJdhFBGIfweAtyvIoyTd7S5pfZt8UXw0V/5eWfQ69ENmabIYhbBH8Ui0xZ8spFX9JRrKB75Ait4wL7EfC1Y1+5z1O3/T7EVAHhH7EqSRD+F72xwMYn2a8r4mCLaVSpJ+ZbsxpgKyd+g9u3k2TbNT0PI+1qKylpJ0e21vk7kwhwQ+m40f42n1k13A1cB1pmtAJTsH06sJelmCOnxT4QCrWBxoz8IRhCidb+QU9daQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyE+PxJ5TwXReCpIsuIrR1fYs1ELh5SA2r4ZGBnKs5c=;
 b=YDI7OBezXDzz9XdiSO/0enarHksv6djNVx8ktYkttSay2FW+GEQdm4FPJqduZhbPD6QE+/6ApMvbEz6sZxMBoXpy/wAuZhIjo+efp3qKBesXY0COngNBo9h08/hYL7hPaXdfhx9pQvsdBS9zj/tjawj14xVjGpjoP+DJfjsSbNu54vWKuY7nOVieyDgcK2amsaiZkM+3uKFll7QV+WyoU6WlYoV4Rg+tRW1JJ+420WcHAPthrQvyc3zt+84WV2FUwPl/slhWJjdO77V9lIcKfNhX366UaOEiLqG4E6PHzCDf2wd5BU6l0axiO4H1eWLAye0GHiexC4U1b0IUdyB3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.229) smtp.rcpttodomain=arndb.de smtp.mailfrom=sony.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sony.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyE+PxJ5TwXReCpIsuIrR1fYs1ELh5SA2r4ZGBnKs5c=;
 b=MUFV9SjNFoSH1V+NTBjH3dHx0oGY4/M3kDuffq+oDpSZpfD0HJaxRSK8x0Zv8bV45voX1YAoHWLVAQhB6X3UpoqikWZ1DjmBN2Be9ZP+blJjUm+Y9kqiZpZfWjBeSkqet3seY0HVtnDgAJrhuE7//GO+j/1NBRdpmgOSXpdcM1E=
Received: from DM5PR13CA0050.namprd13.prod.outlook.com (2603:10b6:3:117::12)
 by MWHPR13MB1839.namprd13.prod.outlook.com (2603:10b6:300:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.10; Fri, 6 Sep
 2019 15:31:34 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM5PR13CA0050.outlook.office365.com
 (2603:10b6:3:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.9 via Frontend
 Transport; Fri, 6 Sep 2019 15:31:34 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.229)
 smtp.mailfrom=sony.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.229; helo=usculsndmail02v.am.sony.com;
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14 via Frontend Transport; Fri, 6 Sep 2019 15:31:33 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x86FVWxp030012;
        Fri, 6 Sep 2019 15:31:32 GMT
Received: from USCULXHUB07V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.168])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x86FV7cH013061;
        Fri, 6 Sep 2019 15:31:31 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0439.000;
 Fri, 6 Sep 2019 11:31:21 -0400
From:   <Tim.Bird@sony.com>
To:     <arnd@arndb.de>, <brendanhiggins@google.com>
CC:     <gregkh@linuxfoundation.org>, <logang@deltatee.com>,
        <sboyd@kernel.org>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kunit: add PRINTK dependency
Thread-Topic: [PATCH] kunit: add PRINTK dependency
Thread-Index: AQHVZMfa56x9Vc3vGku2oQRhqtfXBqcexmWQ
Date:   Fri, 6 Sep 2019 15:31:02 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977A9B7B@USCULXMSG01.am.sony.com>
References: <20190906152800.1662489-1-arnd@arndb.de>
In-Reply-To: <20190906152800.1662489-1-arnd@arndb.de>
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
X-Forefront-Antispam-Report: CIP:160.33.194.229;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(189003)(199004)(13464003)(246002)(54906003)(46406003)(8676002)(110136005)(14444005)(97756001)(102836004)(478600001)(106002)(4326008)(86362001)(229853002)(37786003)(4744005)(55016002)(316002)(8936002)(8746002)(5660300002)(7736002)(476003)(126002)(66066001)(11346002)(486006)(356004)(6666004)(3846002)(6116002)(47776003)(6246003)(305945005)(336012)(426003)(446003)(33656002)(55846006)(50466002)(26005)(186003)(76176011)(2906002)(7696005)(23726003)(2876002)(70206006)(70586007)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1839;H:usculsndmail02v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail02.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54bcd044-0d71-44a3-5437-08d732df4c7f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR13MB1839;
X-MS-TrafficTypeDiagnostic: MWHPR13MB1839:
X-Microsoft-Antispam-PRVS: <MWHPR13MB1839CEA675912A42BD7FACE5FDBA0@MWHPR13MB1839.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0152EBA40F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /Bd7KzrEtCqDe8Jzwv5xGV7SA9xd0UNbCWrjt9+qsnldsp5NF7qxeXi8hRDtuDgMSnPQy5d/De4PzLktFA9gpasXuTDsceq8JGDNHNVAg4kPros6TXxpOIyVJ9KzBotlEfSZLfsbQsdJzYdAGViMZiLO0p9woLZU9v4858qUbHkdktLZ8xfGeRJ0qt3aENhVbfwE7PCZmTWdKXWtq6jFg0vW/XJ95/B9Z24Rsn2yUfxh3WlzpWCC/f7rwpYRPWFE5aYZpAi2AVzf0xzK/WU6k27rW2C1UP6aFaupiTMDz9hjtbo1rF1+43b+dmxRC+0W7+E3kLZ8Gi6QEFJ98eXUmZBagw6Z2cKffRj73We4+fGvMaXWhQKSAZZPik8MVsboF4URgNrcn8y6PIr86FFqZwl/Fa12Hb6Wzu5dTu7X8Lo=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2019 15:31:33.4109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bcd044-0d71-44a3-5437-08d732df4c7f
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.229];Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1839
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Minor spelling nit..

> -----Original Message-----
> From: Arnd Bergmann
>=20
> The vprintk_emit() function is not available when CONFIG_PRINTK
> is disabled:
>=20
> kunit/test.c:22:9: error: implicit declaration of function 'vprintk_emit'=
 [-
> Werror,-Wimplicit-function-declaration]
>=20
> I suppose without printk(), there is not much use in kunit
> either, so add a Kconfig depenedency here.
depenedency -> dependency

>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kunit/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kunit/Kconfig b/kunit/Kconfig
> index 8541ef95b65a..e80d8af00454 100644
> --- a/kunit/Kconfig
> +++ b/kunit/Kconfig
> @@ -6,6 +6,7 @@ menu "KUnit support"
>=20
>  config KUNIT
>  	bool "Enable support for unit tests (KUnit)"
> +	depends on PRINTK
>  	help
>  	  Enables support for kernel unit tests (KUnit), a lightweight unit
>  	  testing and mocking framework for the Linux kernel. These tests are
> --
> 2.20.0

