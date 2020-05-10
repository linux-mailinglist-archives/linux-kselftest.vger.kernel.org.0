Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19E1CCD0D
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 May 2020 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgEJSow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 May 2020 14:44:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40820 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728866AbgEJSou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 May 2020 14:44:50 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8638240507;
        Sun, 10 May 2020 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589136290; bh=q4yMUYxy7IbxuEFWHFtTBwZR3EjIUP/s0d1is1lGyms=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=a57mKTuIQCudNKwKUUnA1BQHdbPACj/JCsofoHCw2AmtEtSvM+zwB68P3UkD2gH+y
         Lvoo3sv4yzAgAJryEpaygrU6BDKty4AtfWrQ0voVBC5lAaXCbSGz8Zf6FaxjM0TLqw
         Rseao577qCmFrhBjY8o+GX0QpAUY6dFma0ZVpVEGirz7KOSIgrQVtKvy4Tq7Y7S4HS
         yGIo8sbm5iYqmwg0dYdT5rLVqUInnj+YDRmfETjn+u0gGic/VSLK4UkJbUrynCSooF
         qfDFvNeAqPZ0LDYUURpMfYX19XXnD2UGIn0GlL5UhYIv90gk09186AstcqZkWPbSM0
         kZCF6OOMhPe9A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 569D2A006E;
        Sun, 10 May 2020 18:44:47 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 10 May 2020 11:44:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Sun, 10 May 2020 11:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj9XAsBZPmyjZacF1lN1QsAxM5WQkS/648+TgBzlhHiN0ecvBt+vbtZgpVthpcA3dGFHrM3QVm6U6yrRYJTQj88M3utnPl7AIDMh2wQaxIgNEFoJaeK/jwm/cK+myuXTKsc2kJrMvIYbeevr4H5eBaf8/sXuslI6YdhYQznaTE2e70tLjx2RECXj1fQS/8Z2Lathup9gyyYGtMKMwluLa0LSFeS2GZs+E1qK5RFCt0Nw6L60MXFnrWAu4IlgwvcjeH7mpAr+ImHQmYp3xL+52UjesC5yQOYpPPuT+yUUyFBMPi0G9YzfWnlA5vF3YgEoE1ANCjMI2CM4+40ZRa3g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz7SZcvwsMIgiaTRAmc25u5K7X9zEzGssPuGBFFu+PA=;
 b=FrMWfj8pG6KNiNSdt9fMRtqP1kKpmzUPClRa5QGB3HL9qAbbYXwCsgWRT0Wy0isBpUiOHcXazBxK0ClsTR0njG3aTwVwXg1VmQZsVXz2dB7ZtbPRdcwqPEZ6yrIts60m3fun+jhRfgG9pn5Rj5SPaz0QLL5b/kYHGErzC58O5CUQt8T067LSGKb0aE9CVre9m8gRDNxkbha4K8JR7Znu5W4D5d15c8E8iwQD2UfPJyNV8IvKLM42YwE9CVqhz1xadiHntVr1wZx6paauT5HpbDH1e0hnJFQnpIAn8xXz/6G6yLpLd9QA2vKol+MqRLHCs+IqHTcsNZFeP50k+mI/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz7SZcvwsMIgiaTRAmc25u5K7X9zEzGssPuGBFFu+PA=;
 b=KcvOQJUTbylvdpCWEDDlBF6LojqakkS2EhF6V4zMCI7kLnnqN08WW8xyK9GBGrodl8VApzb3AvIK7eaEuYRCEWz2q0O7VRKX/ibWZwHcckxiaZsi92pqoRKJj48PUKgTY38+YMZgMdf/6Pc6vsM95XW+gEt/Pay/qDTjbmd5pvI=
Received: from DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) by
 DM6PR12MB3146.namprd12.prod.outlook.com (2603:10b6:5:11b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Sun, 10 May 2020 18:44:45 +0000
Received: from DM6PR12MB2684.namprd12.prod.outlook.com
 ([fe80::f913:a5d2:ee95:5157]) by DM6PR12MB2684.namprd12.prod.outlook.com
 ([fe80::f913:a5d2:ee95:5157%5]) with mapi id 15.20.2979.033; Sun, 10 May 2020
 18:44:45 +0000
From:   Nikita Sobolev <Nikita.Sobolev@synopsys.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Eugeniy Paltsev" <Eugeniy.Paltsev@synopsys.com>
Subject: RE: [PATCH] selftests/tpm: Fix runtime error
Thread-Topic: [PATCH] selftests/tpm: Fix runtime error
Thread-Index: AQHWENRSg161NCxUUEaLItlFtz6YTqihyzSQ
Date:   Sun, 10 May 2020 18:44:45 +0000
Message-ID: <DM6PR12MB26848928AB4CE7B1D5BAC4B3D9A00@DM6PR12MB2684.namprd12.prod.outlook.com>
References: <20200412141118.70688-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200412141118.70688-1-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [46.47.223.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5445fdbb-e229-4796-658a-08d7f51235a8
x-ms-traffictypediagnostic: DM6PR12MB3146:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31462E4D59623935571957F9D9A00@DM6PR12MB3146.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 039975700A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UnxGVObGapqUguxIPr87Rtc0LrPdqbmOLJ1wOZ+8Pe3C1RpDRXJ3r1INNKkfawxsmZCre3ub6Wg3siIGNYQ+vthtxztoQUTdJLJupi5yds5yHqi1sKYvUx4UZxAvhptLP1Bdd38F9cf0k+VyRars5+MrspK1Da0zQHrgTZsv/KDJzC1jCy9Bfq3pyWbjmtK5n38tBzi8ihzDXpevPeSLs+qUNv1X0UDo7zF0Mpc4+Fb52RJXdn7mTqFIe+gSrpTeRRrn3+Y1cCYW8k27/4ma34UG+SFIhOTKGZfjFZIk1R4EC9FMnPQGpY0hg/7jCCLDMWHs+gE804jKWCAuTL7EuTtWoNtrI0/SLw9tu+pQWBN9BtP4LasXDAG59hvDfusfAYjqm4wRHmmm7o9zE6dIHz9BqDlq6IlqHpgAg6FVJ1GWnz8pmrCaSNFCBoMURiovognDKZ4qRT+ZvvSbNyn3zVwWLFT2wsaXy+bdfdFLqIFvtqRiLgHmt3ozJLILnle8ucW9TFdx3ZPkyaNLqA6DmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2684.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(136003)(39850400004)(396003)(33430700001)(76116006)(66476007)(66446008)(9686003)(53546011)(66946007)(55016002)(66556008)(64756008)(6506007)(86362001)(71200400001)(52536014)(7696005)(8936002)(316002)(8676002)(186003)(107886003)(54906003)(4326008)(2906002)(33440700001)(110136005)(26005)(19627235002)(33656002)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X52PfnVLfRGI6t7Iv/T5h26HrZUfMJ1toRqQSCm4VlMIW71FCDDmxMTcXBv7cRJFqfNd3y4UFBpbBIvU258m52pNvwVyuvkRfzsXH6TDgSk0oJIXxy+khL8j1S9Qv+0hTpM7yXnMMhc4acTtNFqeLoWUJ3NUi2p2b6jup/mXHF4AGLSUyctubbU0BI0PHXXL02Gs3b6g488PY/C3Wn4tV5/x1uYSJArEFznD5uMytCrBB3Z6IH0dBNA8ya3aci2X/aAo4wcdhODN6zkQNY7jgqMzlkkDI5RBYWVVgyXc/jDPwFq2c1ARTYMqyadGLrlraj26X6s32/1uO241/GfqwzMwFiJMGayatT9Pc78z4UevxA113O2ioFRjjizoF7OANkU2++zJZeMzDO+cSnfZoaeKP9Blo0Gp0+oOef5ycwCg/al6SzMgY5wMmy2InEcZCq7tYAehQGFNL++s8c0o/GjTTSfgl4F/qWf5dmawzWs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5445fdbb-e229-4796-658a-08d7f51235a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2020 18:44:45.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ENgsWdbtDUmAv3z3ejI9Iyq5hCCk/BPpHRirZx+dmdicHFKGvu4nJ8ZXPrXbz77012s6nEoCv7QkAkEmqKu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3146
X-OriginatorOrg: synopsys.com
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Jarkko Sakkinen, all!

Thank you for your notes about commit and sorry for not copying the message=
 to you!

There is definitely unwanted line of code in the commit.
After deleting that one, introduced changes work fine.

There is a hardcoded usage of /dev/tpm2 in the kernel selftest. And if ther=
e is no such device - test fails.
I believe this is not a behavior, that we expect. Test should be skipped in=
 such case, should it?
That is what my commit makes.

So, after deleting unwanted line of code and making cosmetic changes (new d=
escription + deleting
excess newline character), can commit be submitted again?

You also mentioned reviewed-by nor tested-by tags in your message. Who shou=
ld make these tags?

P.S.
Also there was a question: why do I declare exit code with a constant inste=
ad of just exit 4.
I chose this style because it is used in other kernel selftests for such ki=
nd of checks.
It is proper to follow common style rules. Should I argument this decision =
in commit message?=20

-Nikita

> -----Original Message-----
> From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Sent: Sunday, April 12, 2020 5:11 PM
> To: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org; linux-integrity@vger.kernel.org; Jar=
kko
> Sakkinen <jarkko.sakkinen@linux.intel.com>; Nikita Sobolev
> <sobolev@synopsys.com>; Tadeusz Struk <tadeusz.struk@intel.com>; open
> list <linux-kernel@vger.kernel.org>
> Subject: [PATCH] selftests/tpm: Fix runtime error
>=20
> There is some random clutter in test_smoke.sh:
>=20
>   ./test_smoke.sh: line 3: self.flags: command not found
>=20
> Remove it.
>=20
> Fixes: b32694cd0724 ("Kernel selftests: tpm2: check for tpm support")
> Cc: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> I rely on these tests and this was not even cc'd to me and obviously was
> untested. There is neither reviewed-by nor tested-by tags in the commit (=
not
> to mention some cosmetic things like short summary formatted wrong and th=
e
> extra newline character).
>=20
> Please do not do this next time. Thanks.
>  tools/testing/selftests/tpm2/test_smoke.sh | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh
> b/tools/testing/selftests/tpm2/test_smoke.sh
> index b630c7b5950a..e55d3e400666 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -1,11 +1,9 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) -self.flags =3D fla=
gs
>=20
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=3D4
>=20
> -
>  if [ -f /dev/tpm0 ] ; then
>  	python -m unittest -v tpm2_tests.SmokeTest
>  	python -m unittest -v tpm2_tests.AsyncTest
> --
> 2.25.1

