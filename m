Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388E8194B76
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZWXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 18:23:25 -0400
Received: from mail-bn8nam11on2115.outbound.protection.outlook.com ([40.107.236.115]:41036
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgCZWXZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 18:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J68wwUk9/JVsuMNTlGsC+gbr0DeRNva3agSB6MF47H1mXm+ktWVi2cNwQZiKf3f2ztqTt/+oGQsFCTnAS7pPmJqwRW301KkbgOcbHAFl3/Aa2WW9AouCXnC24ilZkFJoJMRzigHOM4J84/XMvirMXbJtT3s3vRVd2mmqENtHHv7ujSLRycragVJ9yhsJhlkwXIRqmKR5xtyc23GkksMpgknLKJiH9xDvwIcUzga9BUas+PZwiXjzAUQ65q9PIeoUdeePaCSa20Rz6Bv73UKKpFEZfWuZLxEghMi5d5jGeYzQxcUmRlI/GC06f7B1TTNz2/XdTzzrTlVR4KrGbRgRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rscjVjeXkOoOfUwAsih5l2r50wO/MMafmb3AYxAsXPE=;
 b=XJ8I7MRXnsppg7yMouoC7tmBs4Paaw9v4zIe2yBz8fO/Q6jBlscUzoNO870heDfEq/6E+i7jmygsXq3GjFrAIp6fic04niWEp7MjVXQLUJOunudT7tGDZnAiZ2vTNZH3yBqadhyF8LCmCU8mUnyV/4efHZI0TRLY0L9wc+M01gZCJoHdliSnHVdIPdIgg/OAHdO1DD/QWPN1J2bS2nf1dKsgCf1SZSDntm63VT13TyAxb1/qz9M8lI10m2561aW+LEnDxGgz0txLkj940vIp26VjDmkelv1hFssK/rJ9urUlwi9kk5i4kSwoA91JgYsiXvsSR9XOs+jv9nvMBnJIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rscjVjeXkOoOfUwAsih5l2r50wO/MMafmb3AYxAsXPE=;
 b=IM3S9kK/QlO8wKrccjefcWw6i07TL6/VHc70ZGyBfakYJYiBlC1ypJPOzA39pwnnjdbuc+z/ZWy4AavWH8xSgcRu97IjCMES0pctgwKDxdTwEXJ5gNP4pzucfHv2/sToKrwT51wmOz6ovS6teeMcBf35cLvc6ak5JGv9eJ4NlGI=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1712.namprd13.prod.outlook.com (2603:10b6:300:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17; Thu, 26 Mar
 2020 22:23:17 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e%6]) with mapi id 15.20.2835.021; Thu, 26 Mar 2020
 22:23:17 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests: Fix memfd to support relocatable build
 (O=objdir)
Thread-Topic: [PATCH] selftests: Fix memfd to support relocatable build
 (O=objdir)
Thread-Index: AQHWAvuyby0OensDwUuQysJNU0GWAKhbb96Q
Date:   Thu, 26 Mar 2020 22:23:17 +0000
Message-ID: <MWHPR13MB08955F0F8C5D0B07CA86DA92FDCF0@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <20200325231709.13122-1-skhan@linuxfoundation.org>
In-Reply-To: <20200325231709.13122-1-skhan@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6709342e-4e9a-4051-06aa-08d7d1d44837
x-ms-traffictypediagnostic: MWHPR13MB1712:
x-microsoft-antispam-prvs: <MWHPR13MB1712AE27E40A7E1186C8F239FDCF0@MWHPR13MB1712.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(8676002)(26005)(2906002)(8936002)(55016002)(9686003)(86362001)(71200400001)(5660300002)(110136005)(66446008)(54906003)(4326008)(316002)(52536014)(478600001)(33656002)(66556008)(186003)(66476007)(81156014)(7696005)(81166006)(64756008)(6506007)(76116006)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1712;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iYfkdlgTCBgq9BNpgYUmDzs9aINMymHpEvxTh4MlHJASSK4wrBAzcQVDoUWL4HY+zrMZ9O3QokQ1RSIWKpFiBtrXCoYnXE0l3fETNZb+4qh3rBhz7dKl/rUvhDCloJ8u+HE2xFs2wzvJCeALk1NwqgJ97sTEaKvY/Mg+edqQyB9/SZ8HhCvOoCzk4sPDTA9mlCMOm5Egmuo3yVWHiBcYlrJeHkNQ+96eTvYIxrI4t2nz0b+4SiaBFDhqJPDG6gxbSdiXbjXeqW3/x/aTU7HNM6m6HnTg4Jbs/4xc/LMOgLIo41Rfim8ZijFzps1dVxX7ChGFzBcscZKx37Ieu3nheACCr2ZP1UFPIrbgzJVhnLG++cJs+cVAv++b4RXFrK2H7JzH82tvmDXBvfw5zwdAMmigv84Uc83Il8nAqk2nrIzRqiLM/bDeW4rYwm2/+kc
x-ms-exchange-antispam-messagedata: x+sgQpBk1CzEEuPw31BT5yHuwwI4S0L65hfFsZtNrv4wgbT+sr/s3azLIaCX8CXHl1qMuOFK84LZGHkbunOigr3IcgdiX/2AHhCowWibzxn7c5WTvxtctSLUqWdbIMt7rsaKI9ZhJEsRRD3N3NN9JQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6709342e-4e9a-4051-06aa-08d7d1d44837
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 22:23:17.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5I5c1fVzG7E3IZGIq57XADRIYhABIVyoeVsx6YY5b/uWeYzZpYCbrI+dpX1dkncyBDh3eUW5XF2z+nLBnAp1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1712
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Shuah Khan
>=20
> Fix memfd to support relocatable build (O=3Dobjdir). This calls out
> source files necessary to build tests and simplfies the dependency
> enforcement.
>=20
> Tested the following:
>=20
> Note that cross-build for fuse_mnt has dependency on -lfuse.
>=20
> make all
> make clean
> make kselftest-install O=3D/arm64_build/ ARCH=3Darm64 HOSTCC=3Dgcc \
> CROSS_COMPILE=3Daarch64-linux-gnu- TARGETS=3Dmemfd
>=20
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/memfd/Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selft=
ests/memfd/Makefile
> index 53a848109f7b..0a15f9e23431 100644
> --- a/tools/testing/selftests/memfd/Makefile
> +++ b/tools/testing/selftests/memfd/Makefile
> @@ -4,9 +4,8 @@ CFLAGS +=3D -I../../../../include/uapi/
>  CFLAGS +=3D -I../../../../include/
>  CFLAGS +=3D -I../../../../usr/include/
>=20
> -TEST_GEN_PROGS :=3D memfd_test
> +TEST_GEN_PROGS :=3D memfd_test fuse_test fuse_mnt
>  TEST_PROGS :=3D run_fuse_test.sh run_hugetlbfs_test.sh
> -TEST_GEN_FILES :=3D fuse_mnt fuse_test
>=20
>  fuse_mnt.o: CFLAGS +=3D $(shell pkg-config fuse --cflags)
>=20
> @@ -14,7 +13,7 @@ include ../lib.mk
>=20
>  $(OUTPUT)/fuse_mnt: LDLIBS +=3D $(shell pkg-config fuse --libs)

Sorry to interject here.  This comment doesn't have to do with this patch,
but the above line is problematical for cross-compilation.
$(shell pkg-config fuse --libs) will use pkg-config from the host
machine, and may produce something different from what's
installed on the target.  For most enterprise and desktop systems
library paths for are mostly standardized.  The effect is that if
you're doing 'simple' embedded, the pkg-config output on the
host will match that of the target board.  However, in some
embedded products the partition and filesystem setups are
often quite complicated (e.g. I recently worked on a TV set with 14
partitions) and things are not in the locations preferred by the
Filesystem Hierarchy Standard.

When cross-compiling for our products, we tend to use the pkg-config
from the filesystem of the target (a copy of which is on the host), rather
than the host's pkg-config.

I don't have a board in my test lab where this shows up, nor a=20
proposed solution at the moment, but I'm just mentioning it as a
potential host-environment build contamination issue.  Maybe I
should start keeping a list, and start thinking of possible solutions for
more of these types of issues.
 -- Tim

P.S. I'd ignore this issue for approving this patch.  I'm just bringing
it up as a red flag for future work.
>=20
> -$(OUTPUT)/memfd_test: memfd_test.c common.o
> -$(OUTPUT)/fuse_test: fuse_test.c common.o
> +$(OUTPUT)/memfd_test: memfd_test.c common.c
> +$(OUTPUT)/fuse_test: fuse_test.c common.c
>=20
> -EXTRA_CLEAN =3D common.o
> +EXTRA_CLEAN =3D $(OUTPUT)/common.o
> --
> 2.20.1

