Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63213D8474
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 01:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbfJOX2E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 19:28:04 -0400
Received: from mail-eopbgr810115.outbound.protection.outlook.com ([40.107.81.115]:10608
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbfJOX2B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 19:28:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUQrR8DOSNf3FrsKXoXjamJstrLGrRXIXkYCMfK3q7JRLnoeBun36D22WQm2Xa3N50mY5en17tpBAAiooHbmekRtakkChbEsfOcYQfIzHnS5QFa61Tltn1zDKyvt5smoKlCLva0swlJBSYfbKscTC/knq0XrpRmo7DqSvd2OP56cpTtm07f3W+zy7548u3l6RnMlk/T3MEzG9fps48WnNBy2zWbPcKkTXn9+I25aq1H3uKq+jW3no0L63VJ44xHSaKQgUBiC9MZAX82UaEUQ+bTv4z9SiXDkeq7jTbKmbtg86BVKJYv0Q0EFQPoh+xydA+8ZFio3dsZqXfwoCjrNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3AzObqYewUfQRyGjstQ09tuSOqGehvu/CiWWnJKCek=;
 b=abjQeeaxYrycYimYYL+VRJKLdqUQAZo9mosCpLCvLyRh93I0h9zMoMSeqcDYBJwW3wg4Wh5NW/5+kifBPc+4c16vb9fwa6UmXQkWLoYzea77KjgRnkC/jncowSpDauk8dgMuSnyQ6azWWOwY1Enpdin3CDz0f1GZjzAob1QzRE9mxUTq30KVs3oAnGOrSxi0ZTfGB6eKr8QGeDKr8Y7A7DmLYXWYoAdw2SoXQBj21MhL8bu2rrPzhQJLDR5ABS37zUb9hhflHDRVr/Ms7gdbjzKnsaCAYbU0lhzLXtJTnSXLIoh1yDkj3Pim+bNQrKoa+bTUcNhco23/QcAWcAqWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.228) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3AzObqYewUfQRyGjstQ09tuSOqGehvu/CiWWnJKCek=;
 b=nx4CISjRvFkh9HMN11LAIxfTwx327pYPdNe8EviNg5/ADEj/D78+YajD9q70OOBG389l0RiXSue6DYHt/kFabKZH5Z9KRdZmv5DIldrtQqUil5hahgcIL6wzUOpJcj6BV1SdnoBxrxq2tO/1GKBBMkoPTWYdsJYirvF8wffMLlk=
Received: from CY4PR13CA0024.namprd13.prod.outlook.com (2603:10b6:903:32::34)
 by DM5PR13MB1657.namprd13.prod.outlook.com (2603:10b6:3:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.13; Tue, 15 Oct
 2019 23:27:55 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by CY4PR13CA0024.outlook.office365.com
 (2603:10b6:903:32::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.5 via Frontend
 Transport; Tue, 15 Oct 2019 23:27:55 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.228 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.228; helo=usculsndmail01v.am.sony.com;
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2347.16 via Frontend Transport; Tue, 15 Oct 2019 23:27:55 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9FNRs6c009590;
        Tue, 15 Oct 2019 23:27:54 GMT
Received: from USCULXHUB04V.am.sony.com (hubs.sonyusa.com [146.215.231.18])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9FNRsvY021747;
        Tue, 15 Oct 2019 23:27:54 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB04V.am.sony.com ([146.215.231.18]) with mapi id 14.03.0439.000; Tue,
 15 Oct 2019 19:27:54 -0400
From:   <Tim.Bird@sony.com>
To:     <skhan@linuxfoundation.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests: Fix O= and KBUILD_OUTPUT handling for
 relative paths
Thread-Topic: [PATCH] selftests: Fix O= and KBUILD_OUTPUT handling for
 relative paths
Thread-Index: AQHVgvpKf3dnntyBoEuzaoa6lbCUbKdcV3zg
Date:   Tue, 15 Oct 2019 23:27:51 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977CC2AB@USCULXMSG01.am.sony.com>
References: <20191015014505.14259-1-skhan@linuxfoundation.org>
In-Reply-To: <20191015014505.14259-1-skhan@linuxfoundation.org>
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
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(13464003)(199004)(189003)(186003)(11346002)(5660300002)(316002)(54906003)(50466002)(229853002)(70206006)(66066001)(37786003)(55846006)(47776003)(476003)(70586007)(110136005)(336012)(126002)(426003)(486006)(446003)(97756001)(356004)(7736002)(4326008)(305945005)(6666004)(26005)(76176011)(86362001)(6246003)(102836004)(2876002)(33656002)(7696005)(478600001)(55016002)(3846002)(6116002)(23726003)(106002)(46406003)(2906002)(8936002)(8746002)(8676002)(246002)(2101003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1657;H:usculsndmail01v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e090cddc-76f4-40cc-7f06-08d751c74e72
X-MS-TrafficTypeDiagnostic: DM5PR13MB1657:
X-Microsoft-Antispam-PRVS: <DM5PR13MB165753E09C3EFF709B0B0B3DFD930@DM5PR13MB1657.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47w08ft96K7yVP2RhEdaudp7vtdK/mDSCGDmhOuzOPcxmOTUws6Ti/CwDA3moHdnl4ZYBRi09icBdNqwQzcCp7XoJuLK1Rk8mJDB4N3ZUiwLG7HzYMy2lqdle20MB5B6NCHVDXCBmUp+ds2y2BRQro+E+/ypSXCOn9ZSw74Nkbc81K9WJJkOe8fX6YW+YSRy+4nwnkMzN66lCiplJOC7RvF7VeUoG5RD4FseMrXKZcNk/CNxfef00KBUCi1b3R15WCP5DclnjPUKdaS4jy4dwPHfiMvODh7ka/6uP6toRqEa8xEyw2hw4LQjKD8F9+UWaFELHr7HiUeyCAlWR+pEcXWufMJUcJnSwgiSb+11t7xmcL+j8F1Pvh9gZPioY1bjUkVBUjYGOd+qqw6YbkbKRAiqsp/0XjWvhlIIadYNgAs=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 23:27:55.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e090cddc-76f4-40cc-7f06-08d751c74e72
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1657
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Shuah Khan on  Monday, October 14, 2019 3:45 PM
>=20
> Fix O=3D and KBUILD_OUTPUT handling for relative paths.
>=20
> export KBUILD_OUTPUT=3D../kselftest_size
> make TARGETS=3Dsize kselftest-all
>=20
> or
>=20
> make O=3D../kselftest_size TARGETS=3Dsize kselftest-all
>=20
> In both of these cases, targets get built in ../kselftest_size which is
> a one level up from the size test directory.
>=20
> make[1]: Entering directory '/mnt/data/lkml/kselftest_size'
> make --no-builtin-rules INSTALL_HDR_PATH=3D$BUILD/usr \
>         ARCH=3Dx86 -C ../../.. headers_install
>   INSTALL ../kselftest_size/usr/include
> gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o
> ../kselftest_size/size/get_size
> /usr/bin/ld: cannot open output file ../kselftest_size/size/get_size: No =
such
> file or directory
> collect2: error: ld returned 1 exit status
> make[3]: *** [../lib.mk:138: ../kselftest_size/size/get_size] Error 1
> make[2]: *** [Makefile:143: all] Error 2
> make[1]: *** [/mnt/data/lkml/linux_5.4/Makefile:1221: kselftest-all] Erro=
r 2
> make[1]: Leaving directory '/mnt/data/lkml/kselftest_size'
> make: *** [Makefile:179: sub-make] Error 2
>=20
> Use abs_objtree exported by the main Makefile.
>=20
> Reported-by: Tim Bird <Tim.Bird@sony.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/Makefile
> b/tools/testing/selftests/Makefile
> index 4cdbae6f4e61..3405aa26a655 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -86,10 +86,10 @@ override LDFLAGS =3D
>  endif
>=20
>  ifneq ($(O),)
> -	BUILD :=3D $(O)
> +	BUILD :=3D $(abs_objtree)
>  else
>  	ifneq ($(KBUILD_OUTPUT),)
> -		BUILD :=3D $(KBUILD_OUTPUT)/kselftest
> +		BUILD :=3D $(abs_objtree)/kselftest
>  	else
>  		BUILD :=3D $(shell pwd)
>  		DEFAULT_INSTALL_HDR_PATH :=3D 1
> @@ -102,6 +102,7 @@ include $(top_srcdir)/scripts/subarch.include
>  ARCH           ?=3D $(SUBARCH)
>  export KSFT_KHDR_INSTALL_DONE :=3D 1
>  export BUILD
> +#$(info abd_objtree =3D $(abs_objtree) BUILD =3D $(BUILD))
>=20
>  # build and run gpio when output directory is the src dir.
>  # gpio has dependency on tools/gpio and builds tools/gpio
> --

 This works great.  Thanks very much.

Tested-by: Tim Bird <tim.bird@sony.com>
Acked-by: Tim Bird <tim.bird@sony.com>

 -- Tim

