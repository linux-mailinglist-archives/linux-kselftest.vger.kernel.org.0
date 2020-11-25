Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B72C44B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Nov 2020 17:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgKYQKy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Nov 2020 11:10:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:44248 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgKYQKy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Nov 2020 11:10:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E1BF02EE89B;
        Wed, 25 Nov 2020 11:10:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U1BVzusVbh0a; Wed, 25 Nov 2020 11:10:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8F4A42EE821;
        Wed, 25 Nov 2020 11:10:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8F4A42EE821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606320652;
        bh=bbYtCaZF/GOGSJXFnirWSqlDmYZg20zfYntl8p0YaTY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tOuPixNT9orFfsj4afPocQC33sHcl4CwIK6z80iMJKtbhQ2CXk1JP+aB4dG7lNRfT
         KUk6aeqltdAzp6FZImlJBSJtDdWqwhSC+H9Swy7uk+0RW5Cz/PXD0zsk5BGraZjaAt
         3ofM3pOrDmG/4o4yb4lx9dGC2By58MyOvPA6my+TyoSdGdR9bNdyq+yg/KF3/fM3r+
         /IsKQtpgtZqu56RPesbzbzuNFjYev1ykVp6hqwz3DGJvKTmDkd9Kd7W+qj0A/obAmw
         s7S5qR8stF++t8LQOg5JF4LkNt7GPM4qMyknJwA28cp9kckA5GVpI+abZ1EJo+7du5
         8rrqk8H3vbdag==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ySQ8Qyb0LqGu; Wed, 25 Nov 2020 11:10:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 830472EE820;
        Wed, 25 Nov 2020 11:10:52 -0500 (EST)
Date:   Wed, 25 Nov 2020 11:10:52 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Xingxing Su <suxingxing@loongson.cn>, shuah <shuah@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1169128156.59953.1606320652393.JavaMail.zimbra@efficios.com>
In-Reply-To: <1606277097-5853-1-git-send-email-suxingxing@loongson.cn>
References: <1606277097-5853-1-git-send-email-suxingxing@loongson.cn>
Subject: Re: [PATCH] rseq/selftests: Fix
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ build error under other arch.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: rseq/selftests: Fix MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ build error under other arch.
Thread-Index: KGBFEM9TDPThyQB6LroJ9QAZ00B1kQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Nov 24, 2020, at 11:04 PM, Xingxing Su suxingxing@loongson.cn wrot=
e:

> Except arch x86, the function rseq_offset_deref_addv is not defined.
> The function test_membarrier_manager_thread call rseq_offset_deref_addv
> produces a build error.
>=20
> The RSEQ_ARCH_HAS_OFFSET_DEREF_ADD should contain all the code
> for the MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
> If the other Arch implements this feature,
> defined RSEQ_ARCH_HAS_OFFSET_DEREF_ADD in the header file
> to ensure that this feature is available.
>=20
> Following build errors:
>=20
> param_test.c: In function =E2=80=98test_membarrier_worker_thread=E2=80=99=
:
> param_test.c:1164:10: warning: implicit declaration of function
> =E2=80=98rseq_offset_deref_addv=E2=80=99
>    ret =3D rseq_offset_deref_addv(&args->percpu_list_ptr,
>          ^~~~~~~~~~~~~~~~~~~~~~
> /tmp/ccMj9yHJ.o: In function `test_membarrier_worker_thread':
> param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
> param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
> collect2: error: ld returned 1 exit status
> make: *** [/selftests/rseq/param_test_benchmark] Error 1
>=20
> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Shuah, can you pick up this fix please ?

Thanks,

Mathieu

> ---
> tools/testing/selftests/rseq/param_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/rseq/param_test.c
> b/tools/testing/selftests/rseq/param_test.c
> index 3845890..699ad5f 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -1133,6 +1133,8 @@ static int set_signal_handler(void)
> =09return ret;
> }
>=20
> +/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. *=
/
> +#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
> struct test_membarrier_thread_args {
> =09int stop;
> =09intptr_t percpu_list_ptr;
> @@ -1286,8 +1288,6 @@ void *test_membarrier_manager_thread(void *arg)
> =09return NULL;
> }
>=20
> -/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. *=
/
> -#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
> void test_membarrier(void)
> {
> =09const int num_threads =3D opt_threads;
> --
> 1.8.3.1

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
