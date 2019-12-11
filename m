Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7D11B560
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 16:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfLKPxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 10:53:30 -0500
Received: from mail.efficios.com ([167.114.142.138]:42358 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbfLKPTH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 10:19:07 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 72F5E68774F;
        Wed, 11 Dec 2019 10:19:05 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id WKPvfOPdR2rD; Wed, 11 Dec 2019 10:19:05 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0CCDE68774C;
        Wed, 11 Dec 2019 10:19:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0CCDE68774C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1576077545;
        bh=Els775lt7VbhSm6uez8HB9AuwfSHPUeqxVvc2FSjROM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cFiH4KIf5SmtmlttI/719OAaw5HhviY/mN++Yv4CSa7+yfMW60UxEA3/qxiIY5Y1A
         Y+cdtg/ZAp1QbbvoVCTQhfvNoW4kOWZAK8yuJSPMPkQbw8dY8S0RuWZz1IOGGB6rEj
         jC9R2ziP+ftZmh6YFaSBYSVZajd8QMLaiDMS3BH3y6YQR4H3ai3z9ci7jucs/OwJmd
         GOy25GT8X7IxiDJGnu16+HKvbUJQvdzegYEVDGOIAwvoGrRVOutv2bB/1n74HrzyWC
         xue0vzmAOv2CpkCYFIzELK320wBqCwD5MBloLBrjGQdj65x4cn6KOyrkkOSdWiUoGN
         Ohz66cAHcADPA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id yRR1NrW5C_RV; Wed, 11 Dec 2019 10:19:04 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EB0FA687740;
        Wed, 11 Dec 2019 10:19:04 -0500 (EST)
Date:   Wed, 11 Dec 2019 10:19:04 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1871753014.2121.1576077544796.JavaMail.zimbra@efficios.com>
In-Reply-To: <2d53b409-31e0-2245-e163-1ab26f52c841@linuxfoundation.org>
References: <2d53b409-31e0-2245-e163-1ab26f52c841@linuxfoundation.org>
Subject: Re: Linux 5.5=rc1 kselftest rseq test build failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3890)
Thread-Topic: Linux 5.5=rc1 kselftest rseq test build failure
Thread-Index: M//PaePCYQ98sUQtyT/D1GN/cpAq9A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Dec 10, 2019, at 7:27 PM, Shuah Khan skhan@linuxfoundation.org wro=
te:

> Hi Mathieu,
>=20
> I am seeing rseq test build failure on Linux 5.5-rc1.
>=20
> gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./
> param_test.c -lpthread -lrseq -o ...tools/testing/selftests/rseq/param_te=
st
> param_test.c:18:21: error: static declaration of =E2=80=98gettid=E2=80=99=
 follows
> non-static declaration
>    18 | static inline pid_t gettid(void)
>       |                     ^~~~~~
> In file included from /usr/include/unistd.h:1170,
>                  from param_test.c:11:
> /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous
> declaration of =E2=80=98gettid=E2=80=99 was here
>    34 | extern __pid_t gettid (void) __THROW;
>       |                ^~~~~~
> make: *** [Makefile:28: ...tools/testing/selftests/rseq/param_test] Error=
 1
>=20
>=20
> The following obvious change fixes it. However, there could be reason
> why this was defined here. If you think this is the right fix, I can
> send the patch. I started seeing this with gcc version 9.2.1 20191008

This issue is caused by introduction of "gettid()" in glibc 2.30. I don't
think we want to introduce a build dependency on glibc 2.30 for kernel
selftests. Removing the gettid() symbol as you propose here will break
build environments with glibc < 2.30.

We could eventually try to figure out whether the glibc headers implement
gettid() at build time (not sure how), or we could simply rename our own
"gettid()" to "rseq_gettid()", thus removing the namespace clash with
glibc.

I can propose a patch renaming gettid() to rseq_gettid() is that approach
is OK with you.

Thanks,

Mathieu


>=20
> diff --git a/tools/testing/selftests/rseq/param_test.c
> b/tools/testing/selftests/rseq/param_test.c
> index eec2663261f2..18a0fa1235a7 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -15,11 +15,6 @@
>  #include <errno.h>
>  #include <stddef.h>
>=20
> -static inline pid_t gettid(void)
> -{
> -       return syscall(__NR_gettid);
> -}
> -
>=20
> thanks,
> -- Shuah

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
