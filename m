Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE331B1C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Feb 2021 19:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBNSBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Feb 2021 13:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBNSBe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Feb 2021 13:01:34 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A1C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Feb 2021 10:00:53 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Ddw5J1FBzzQlX9;
        Sun, 14 Feb 2021 19:00:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1613325650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3WbmafDNcCYjucUAexKSPTk9yuhRyDCdvMt+sse33Q=;
        b=rcHlOFL07blaXI5Hggtx3YUSlxwCxMeb0+tUTzkM1iHDh/j2ouEfSWP8EtH0Ws6I2kTpi8
        vCWoXBa//3eAkfBeY7n5rTuKkr19xZUXUnL103T3yh2eCzl0gPxAFX80jkEr8Jq+9RTJYl
        sclOMQ5FYUzdMppFIjkkqbmC4xvkks3kuajAO+PGkj4l4RBrBsgLxBemdUczXNAc8ZUkM2
        zKCkKlRRSSrQSA+Nsa14r9M8xR5Caaht1FMFOM90Szm3lIrpN5gwjuI4eR2VHR1E0YB6mH
        qbJB/gc4v/0jHwrIaTU4YXWGRNmpac7LEnLgvSGfB3h8dVegLEoG/rzzjJLkyA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id yiHYCMzStuR6; Sun, 14 Feb 2021 19:00:45 +0100 (CET)
Subject: Re: [PATCH] testptp: Fix compile with musl libc
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     shuah@kernel.org, richardcochran@gmail.com, davem@davemloft.net,
        vincent.cheng.xh@renesas.com, christian.riesch@omicron.at,
        linux-kselftest@vger.kernel.org
References: <20210214170940.32358-1-hauke@hauke-m.de>
 <20210214173716.hxzb2nk6f7cx262n@skbuf>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <07b844e0-ea27-8607-b631-f946fe8af7f9@hauke-m.de>
Date:   Sun, 14 Feb 2021 19:00:39 +0100
MIME-Version: 1.0
In-Reply-To: <20210214173716.hxzb2nk6f7cx262n@skbuf>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j8HX4ftHpd09W9Fwh05X8Jy7PD4ombGVK"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -8.16 / 15.00 / 15.00
X-Rspamd-Queue-Id: D59D51848
X-Rspamd-UID: 467781
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j8HX4ftHpd09W9Fwh05X8Jy7PD4ombGVK
Content-Type: multipart/mixed; boundary="0cQslolJofwAAahOaGut6bYbwOUIaTqcA";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: shuah@kernel.org, richardcochran@gmail.com, davem@davemloft.net,
 vincent.cheng.xh@renesas.com, christian.riesch@omicron.at,
 linux-kselftest@vger.kernel.org
Message-ID: <07b844e0-ea27-8607-b631-f946fe8af7f9@hauke-m.de>
Subject: Re: [PATCH] testptp: Fix compile with musl libc
References: <20210214170940.32358-1-hauke@hauke-m.de>
 <20210214173716.hxzb2nk6f7cx262n@skbuf>
In-Reply-To: <20210214173716.hxzb2nk6f7cx262n@skbuf>

--0cQslolJofwAAahOaGut6bYbwOUIaTqcA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/14/21 6:37 PM, Vladimir Oltean wrote:
> Hi Hauke,
>=20
> On Sun, Feb 14, 2021 at 06:09:40PM +0100, Hauke Mehrtens wrote:
>> Musl libc does not define the glibc specific macro __GLIBC_PREREQ(), b=
ut
>> it has the clock_adjtime() function. Assume that a libc implementation=

>> which does not define __GLIBC_PREREQ at all still implements
>> clock_adjtime().
>>
>> This fixes a build problem with musl libc because the __GLIBC_PREREQ()=

>> macro is missing.
>>
>> Fixes: 42e1358e103d ("ptp: In the testptp utility, use clock_adjtime f=
rom glibc when available")
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>   tools/testing/selftests/ptp/testptp.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/sel=
ftests/ptp/testptp.c
>> index f7911aaeb007..ecffe2c78543 100644
>> --- a/tools/testing/selftests/ptp/testptp.c
>> +++ b/tools/testing/selftests/ptp/testptp.c
>> @@ -38,6 +38,7 @@
>>   #define NSEC_PER_SEC 1000000000LL
>>  =20
>>   /* clock_adjtime is not available in GLIBC < 2.14 */
>> +#ifdef __GLIBC_PREREQ
>>   #if !__GLIBC_PREREQ(2, 14)
>>   #include <sys/syscall.h>
>>   static int clock_adjtime(clockid_t id, struct timex *tx)
>> @@ -45,6 +46,7 @@ static int clock_adjtime(clockid_t id, struct timex =
*tx)
>>   	return syscall(__NR_clock_adjtime, id, tx);
>>   }
>>   #endif
>> +#endif /* __GLIBC_PREREQ */
>=20
> I guess this works, but as you say, there is still an assumption to be
> made there, which is that all other C libraries provide the clock_adjti=
me
> syscall definition. So it is likely that this set of #if's and #ifdef's=

> will be revisited again and again and ...
>=20
> Maybe this is a matter of personal preference, but I wonder if it's not=

> actually preferable to do something like this?
>=20
> #include <sys/syscall.h>
>=20
> static int compat_clock_adjtime(clockid_t id, struct timex *tx)
> {
> 	return syscall(__NR_clock_adjtime, id, tx);
> }
>=20
> #define clock_adjtime compat_clock_adjtime
>=20
> This way, everybody uses the same definition of clock_adjtime, and we
> bypass the definition provided by libc if there is one, and we provide
> our own if there is none.
>=20
Hi,

glibc 2.14 was released 1. June 2011 and musl libc also supports this=20
function since version v0.9.7 28. October 2012. I would just assume that =

the libc has this function.

musl also does some special handling, probably for the 64 bit time=20
handling, in this function:
https://git.musl-libc.org/cgit/musl/tree/src/linux/clock_adjtime.c#n37
I am not sure if this will also work fine with the compat function.

Hauke


--0cQslolJofwAAahOaGut6bYbwOUIaTqcA--

--j8HX4ftHpd09W9Fwh05X8Jy7PD4ombGVK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAmApZUcACgkQ8bdnhZyy
68dD0ggA4RKnOXLGujNriLj8wEG1+FZhAip8PSZNZ8w4SKMWjRlqgRv1241zbf7r
mcUp11iP86llnkb4YEydtZ4tcnzetIbsm1378ItWyCVNdabU3r6VQPspYX1XZF8y
4sNilh8NxpMJGbp9ACrFsUjK89RHstn9V/OdzbN3WN0pJTNEYi4Ly011SDi1f5i6
GFbE4kamkFw5G77lmTLkG3aZxschKuKdmmPZjOO3eHimU1dMvK0+iyeNa6aP1Jbh
Wdl/o4PQHkppK5wxOnrCHdhTA3WvM1eMoc90NnnlYttNyvXZOowPWCEU7vl0yQHQ
JDJ8zo1IVlnjBjWGmTW66okMqNao3w==
=/XUL
-----END PGP SIGNATURE-----

--j8HX4ftHpd09W9Fwh05X8Jy7PD4ombGVK--
