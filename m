Return-Path: <linux-kselftest+bounces-44707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C5C30AE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F6A4E19E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393522E426A;
	Tue,  4 Nov 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="llUsdMuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic301-21.consmr.mail.gq1.yahoo.com (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D92DECCB
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254797; cv=none; b=ZhFp14r5oJJnWSscB66E65XUQ5J9njwnXqngQVo5+PDLLDyYXwHXtML0B6u+igIrOE1kiIEnOPX3jZIHncf6BKnEbif8O9apX5/dNXlWS/bX6oegXXiX/hoFH4nmFRzkZ0Pfo1gEk9+KV3vC1RaLamku9zmdLUgySW38tMkBIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254797; c=relaxed/simple;
	bh=/xif9iFChphzkZILfZnXqpD2LukMgwOvc6Fsw2eQ8SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN8AGt30xA9uaAcFmwDn09Muqg3t0YPbvchK5QWQjUyBccaeWKAH9KSUemZ4dlrq1B5T3JnOpPs9DuJB1UAf/T6qa7Crc//EZdRdkUx2eyfBKO1VyueIGeVp2cfm93e9HDN0d4HQ4r96z751D0WSZyWKXjddrv77TIXAJHpBa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=llUsdMuk; arc=none smtp.client-ip=98.137.64.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762254793; bh=gfSX9iWaIqI7Je+pA4dj54zti4xAYjuab5g4WwTgVC0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=llUsdMukZoY6Ohu7aQXC62zJUMfmegXvKJOH8uFKZrnnzULKssW8+7eAyaJzZcOV/yqfoGUzIVmre8RrbVFMYAcz4VWSyZpt6TjmC2Y1Uco6UHj6qs3FXP3XxtvS2heezAdDZP4EOzqDj2nwDas/d+7fXLq/hrXKP36InDFrzTsLy8wgLvcIKGuNjXPKoweE0ZSYCJE2oLnY4NtBohmuN2/ZvZ1z1GwK6CXzUoWBARApMF78YvsafHy8kJWJ0ZYuncJLRiMdtsXB0N/IVyd4oQ4zyfSrSZKPxeRjsy4Ql8iJ5SPga5WkZIILKPy4GDJvDnMzTFpzaC15jA50JNwJYw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762254793; bh=oqCZ1ebG+ORBNhfcpFaWryEz73JkvAjYhhga+RRXl5w=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=P6gJf5MdtKkENWiaAMHU6jt8ZR7Zvx3XaG4PPozMEPCJkT0K7DTIBNwJ2II0lItDNkdQ7i/YDRGaLXagVwSTbU2p5+/aTIVA9nM+uzWVI54k5ujO1oEK6+b4YzhV5y5inmDxhgkcUbhqf/Js/mWmUgm4SssXriCdF0KTIeQr33tYmtRzXG2W0Sd7za6jlgH182vD/UbcZtGuNuNwh2CMI4itE/x9qAkaMtC07w9GAEAIRxadBnF8goEG7eggp1jBZnabJf1S5bqzxsbqI9t4zZUYCsKyM/iAW1gQq9mxs6JpMyrZERMu4tyeZWvKYAQJW7yT5Ss5eHMqO1SNmvcNHg==
X-YMail-OSG: B_r1wBUVM1mfdoq4681x9KLPdbUMEqRlgjUHcEM8iZul7pZ3Q.BXMs27tDXGSlp
 vRadj0R8wyd65_Nti1Jzv0x7HX_6U8owdUMIf5QSY5KDUnWMHSBVt4S0GR0_lHUOR99rkuHMLpt6
 GC7uCJYSoVVn6iuBvNlDWNpxjKNRIkQrFNUsOXlVekfuH_iauKocR.zbJR14Dt62YE3D3NU.8aB_
 in80eoRLFZCUFM0bKsFqcA3M6CJAEl6rVdRkJwjcokGvTsi64vT94Qq3gvCosT8JaLWAK6mxs76i
 zC5.Vb.2uW9lHHEvSxSvvaw4SYs_2sCavHqB3hdMQYUyL73g2IVDDF_1jy_nFqdh95rqyXRdsq.0
 Iag3nUOfZKtXHZ9kIISFaIzyrq9FatfZHKQK23r0wWLqq5guFrQjx7UzE1nxoFQKluD4zvEvAp3l
 Vkaun3gV9kABI07Lx5eAIoJxrgP.EmJtVZnrKrhBmz7yNuBDNsKfiDkkpg.Wp5KRm5gYFYMLyBg3
 WWWhkcl3xhz48uRy3cWnv8NbmJqr9Ex9cSdQpQdtA2zQumuNwbMVpShL8Lsg2NhF6EHcReZjsMsz
 GdPtCMrg8WAO.tTFmepcW1.C39w2QIhT9IVCzzHzzzy_ncejnNDy2B3RNslAJ5R3eYRK9m9kKxND
 c0byGsFBOZlGHdKrP.asvLBgFOdLoK9aLt7G4JUuluSqROT.Nome0CtDpSMVBYoGDP.we9Far6kv
 WeCLNZIRqrVYrw9V5fNnDYpV_8UQ9wwXTRESu8fkLbbwQvLBgGHsVd8i6YHeCcmdJvrmSD7MUuJQ
 WCRXzZ_L8p7wvUG8O0Lv4HTknjSoMtRB.CSW8.cnMX454uMKm5pYn_4uUw9zq102T8LME4bMH3mC
 ZgE4pp_Ie05Uo2upT2GcB7xx9QFsBtVNgb4x1lrhNbxU0kcoGHFQ1Z8MvK.24XLyerVR3QqM25Oa
 DmQbBmBopEUvjV3OjZtpHJRC.76By.5qShKo.f2ZxL0tvJLnASRkk8kFbLXN0XIJzdrG7l.7WXaF
 B_7PuoEYn4s2ZQ2UOuRkUrkjGKvf2IL649UbCucmvvwJdrC9MaQK_6w6nFCjocRZedt1tw9T9jxG
 h4JQq43SjtQ5hIU7aXtzPWr8u61NQeiM4hSoo1qyCXB9aebWYXylEBGIhGOG8bbVyprzHv_vv_.c
 vI5hlKasJLUp8x12bcp74YOD5Eql92H_57jc6GvMwV400ccBNTfnWb5cJCztT_PnGmWQXQcbkHqw
 Red5RAlwitVZou4r81FvuRzSHgMhxcvPXwx0rhx7xqKrUjYb2l8.HBQ1opKkqvKBadErLZthokRQ
 Oi43RmWKfSC7RmWpfysUuCsWVZiKlYU7W5_XTxZlpo_MNVHw88VqigctZRsQd0WU.z.7xqW6eaKd
 1T0UFsPbuvp2RiLzYS1GDXcsro24cms.0AGYa19WoYuf1HJhIrVCT_Flyc_3r6T7Eyb820aGElOT
 TAtbmrTgQXeOhgnH.x2pTKcYMs_xiKs2NqMFebbrZSgvlZWXonBBJMfpwBm0xPF944ckTPdTF6DA
 df7MeiFxe4mUHgtQJ5gWg1mVY_MrKvSFi9HckgwDCWbIEQLSQQj412SjmTq5B2YmLzrpsJjA6ar2
 p_4sHxjBaRyKCaANomNsXvD1D7qZm4tXGg9hZz2BgYhZz0JHturxwzpelJSR8suRausuVtZDKEIC
 i0rBKuIG.0ebzDnaGxxRtQKovzX7wMNcr4oprOngPd9J9LugfJufODrcuJ6Bxfu99ioKVJeJnRMG
 EwY9vMTkVy4.3YkIxAmCTzQfQo2jfqGk_54OVM3UdI5Yrh6JbLe0nOcpJkoo6G55Z2QMWr9ohuji
 0OnZmj1EgdDY6LelNKgNMTPQNP1Cug_AYtNwXi1lhqhKYSbbVxtnYKw1tLfjOc59_1xe6XCWtQcI
 MVg.ecXvHiA6sIWeuv7227kQvhTUuTg4YmWVOk8ZaMapKLskQHEi_YL4O90klwu.I1fo2bTRxtKL
 VxHQYxao7M5L11R44cA.yoGR6e5fLZ2sRvcd3ktUKViXV1To409SYd8V5e4UCFVNQPgz8RsVs.s.
 m20S7RnJLevfxobmb4go5_aXAlo4LrXc84ZOKbnEzi0RDuJvt1MrHk6KGZOvGuSExOTlnjA7QRk9
 VxsION6dIhRaMIVR1Zo9p8tT8gN0Ac_W8i5Ujo9oLQfV1jguLzf.uQjA3SX.NwA.aw7T37RiroYM
 DrkFV1E1GMMvFt6dlVGGCQEW3jVJr8rD9SIwN9HJ04JJnsKFk7ipcK881HAlSqGNByL9SjlFEarN
 34_bdDFOI5jXsHkXG9ed9
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: d47ba694-bc02-4164-8250-d475ab6f442e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Nov 2025 11:13:13 +0000
Received: by hermes--production-bf1-58477f5468-qn4m8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4df625031725f4cf5e0592022f64b07e;
          Tue, 04 Nov 2025 10:42:52 +0000 (UTC)
Message-ID: <26835ada-4e3a-4f78-8705-4ed2e3d44bd8@yahoo.com>
Date: Tue, 4 Nov 2025 11:42:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20251101172230.10179-1-adelodunolaoluwa.ref@yahoo.com>
 <20251101172230.10179-1-adelodunolaoluwa@yahoo.com>
 <CAAVpQUDL1FB1nFYOZ6QuO+cGTqnpYNSaFtFD=YN742pyspe9ew@mail.gmail.com>
 <7a162b38-3ff8-4f97-aac3-4fe2ab50fe33@yahoo.com>
 <CAAVpQUADwghMj=SgdiZEErC5oy7RVpam4i9S2RwP19bA=Rbynw@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUADwghMj=SgdiZEErC5oy7RVpam4i9S2RwP19bA=Rbynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/4/25 01:30, Kuniyuki Iwashima wrote:
> On Mon, Nov 3, 2025 at 4:08 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> On 11/2/25 08:32, Kuniyuki Iwashima wrote:
>>> On Sat, Nov 1, 2025 at 10:23 AM Sunday Adelodun
>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>> Add selftests to verify and document Linux’s intended behaviour for
>>>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>>>> The tests verify that:
>>>>
>>>>    1. SOCK_STREAM returns EOF when the peer closes normally.
>>>>    2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>>>>    3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>>    4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>>    5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>>
>>>> This follows up on review feedback suggesting a selftest to clarify
>>>> Linux’s semantics.
>>>>
>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>>>> ---
>>>>    tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>>>    .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++++
>>>>    2 files changed, 180 insertions(+)
>>>>    create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>
>>>> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
>>>> index de805cbbdf69..5826a8372451 100644
>>>> --- a/tools/testing/selftests/net/af_unix/Makefile
>>>> +++ b/tools/testing/selftests/net/af_unix/Makefile
>>>> @@ -7,6 +7,7 @@ TEST_GEN_PROGS := \
>>>>           scm_pidfd \
>>>>           scm_rights \
>>>>           unix_connect \
>>>> +       unix_connreset \
>>> patchwork caught this test is not added to .gitignore.
>>> https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.10179-1-adelodunolaoluwa@yahoo.com/
>>>
>>> Could you add it to this file ?
>>>
>>> tools/testing/selftests/net/.gitignore
>> Oh, thank you for this. will add it
>>>
>>>>    # end of TEST_GEN_PROGS
>>>>
>>>>    include ../../lib.mk
>>>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>> new file mode 100644
>>>> index 000000000000..6f43435d96e2
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>> @@ -0,0 +1,179 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>>>> + *
>>>> + * This test verifies:
>>>> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
>>>> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
>>>> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>> + *
>>>> + * These tests document the intended Linux behaviour.
>>>> + *
>>>> + */
>>>> +
>>>> +#define _GNU_SOURCE
>>>> +#include <stdlib.h>
>>>> +#include <string.h>
>>>> +#include <fcntl.h>
>>>> +#include <unistd.h>
>>>> +#include <errno.h>
>>>> +#include <sys/socket.h>
>>>> +#include <sys/un.h>
>>>> +#include "../../kselftest_harness.h"
>>>> +
>>>> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
>>>> +
>>>> +static void remove_socket_file(void)
>>>> +{
>>>> +       unlink(SOCK_PATH);
>>>> +}
>>>> +
>>>> +FIXTURE(unix_sock)
>>>> +{
>>>> +       int server;
>>>> +       int client;
>>>> +       int child;
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT(unix_sock)
>>>> +{
>>>> +       int socket_type;
>>>> +       const char *name;
>>>> +};
>>>> +
>>>> +/* Define variants: stream and datagram */
>>> nit: outdated, maybe simply remove ?
>> oh..skipped me.
>> will do so.
>>>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>>>> +       .socket_type = SOCK_STREAM,
>>>> +       .name = "SOCK_STREAM",
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>>>> +       .socket_type = SOCK_DGRAM,
>>>> +       .name = "SOCK_DGRAM",
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
>>>> +       .socket_type = SOCK_SEQPACKET,
>>>> +       .name = "SOCK_SEQPACKET",
>>>> +};
>>>> +
>>>> +FIXTURE_SETUP(unix_sock)
>>>> +{
>>>> +       struct sockaddr_un addr = {};
>>>> +       int err;
>>>> +
>>>> +       addr.sun_family = AF_UNIX;
>>>> +       strcpy(addr.sun_path, SOCK_PATH);
>>>> +       remove_socket_file();
>>>> +
>>>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>>>> +       ASSERT_LT(-1, self->server);
>>>> +
>>>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>>>> +       ASSERT_EQ(0, err);
>>>> +
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +               variant->socket_type == SOCK_SEQPACKET) {
>>> patchwork caught mis-alignment here and other places.
>>>
>>> I'm using this for emacs, and other editors will have a similar config.
>>>
>>> (setq-default c-default-style "linux")
>>>
>>> You can check if lines are aligned properly by
>>>
>>> $ git show --format=email | ./scripts/checkpatch.pl
>>>
>>>
>>>> +               err = listen(self->server, 1);
>>>> +               ASSERT_EQ(0, err);
>>>> +
>>>> +               self->client = socket(AF_UNIX, variant->socket_type, 0);
>>> Could you add SOCK_NONBLOCK here too ?
>> This is noted
>>>> +               ASSERT_LT(-1, self->client);
>>>> +
>>>> +               err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>>>> +               ASSERT_EQ(0, err);
>>>> +
>>>> +               self->child = accept(self->server, NULL, NULL);
>>>> +               ASSERT_LT(-1, self->child);
>>>> +       } else {
>>>> +               /* Datagram: bind and connect only */
>>>> +               self->client = socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0);
>>>> +               ASSERT_LT(-1, self->client);
>>>> +
>>>> +               err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>>>> +               ASSERT_EQ(0, err);
>>>> +       }
>>>> +}
>>>> +
>>>> +FIXTURE_TEARDOWN(unix_sock)
>>>> +{
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +               variant->socket_type == SOCK_SEQPACKET)
>>>> +               close(self->child);
>>>> +
>>>> +       close(self->client);
>>>> +       close(self->server);
>>>> +       remove_socket_file();
>>>> +}
>>>> +
>>>> +/* Test 1: peer closes normally */
>>>> +TEST_F(unix_sock, eof)
>>>> +{
>>>> +       char buf[16] = {};
>>>> +       ssize_t n;
>>>> +
>>>> +       /* Peer closes normally */
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +               variant->socket_type == SOCK_SEQPACKET)
>>>> +               close(self->child);
>>>> +       else
>>>> +               close(self->server);
>>>> +
>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>>> errno is undefined if not set, and same for strerror(errno).
>>>
>>> Also, if ASSERT_XXX() below fails, the same information
>>> (test case, errno) is logged.  So, TH_LOG() seems unnecessary.
>>>
>>> Maybe try modifying the condition below and see how the
>>> assertion is logged.
>> Oh..thank you. Didn't it through that way.
>> I understand.
>> I will remove the TH_LOG()'s
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +               variant->socket_type == SOCK_SEQPACKET) {
>>>> +               ASSERT_EQ(0, n);
>>>> +       } else {
>>>> +               ASSERT_EQ(-1, n);
>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>> +       }
>>>> +}
>>>> +
>>>> +/* Test 2: peer closes with unread data */
>>>> +TEST_F(unix_sock, reset_unread)
>>>> +{
>>>> +       char buf[16] = {};
>>>> +       ssize_t n;
>>>> +
>>>> +       /* Send data that will remain unread by client */
>>>> +       send(self->client, "hello", 5, 0);
>>>> +       close(self->child);
>>>> +
>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>> +               variant->socket_type == SOCK_SEQPACKET) {
>>>> +               ASSERT_EQ(-1, n);
>>>> +               ASSERT_EQ(ECONNRESET, errno);
>>>> +       } else {
>>>> +               ASSERT_EQ(-1, n);
>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>> +       }
>>>> +}
>>>> +
>>>> +/* Test 3: SOCK_DGRAM peer close */
>>>> Now Test 2 and Test 3 look identical ;)
>> seems so, but the only difference is:
>>
>> close(self->child); is used in Test 2, while
>> close(self->server); is used in Test 3.
>> Maybe I should find a way to collapse Tests 2 and 3 (if statement might
>> work)
>>
>> I am just afraid the tests to run will reduce to 6 from 9 and we will have 6
>> cases passed as against 7 as before.
>>
>> What do you think?
> The name of Test 2 is a bit confusing, which is not true
> for SOCK_DGRAM.  So, I'd use "if" to change which fd
> to close() depending on the socket type.
>
> Also, close(self->server) does nothing for SOCK_STREAM
> and SOCK_SEQPACKET after accept().  Rather, that close()
> should have the same effect if self->child is not accept()ed.
> (In this case, Skip() for SOCK_DGRAM makes sense)
>
> I think covering that scenario would be nicer.
>
> If interested, you can check the test coverage with this patch.
> https://lore.kernel.org/linux-kselftest/20251028024339.2028774-1-kuniyu@google.com/
>
> Thanks!
Thank you!

kindly check these if any conforms to what it should be:

TEST_F(unix_sock, reset_unread_behavior)
{
         char buf[16] = {};
         ssize_t n;

         /* Send data that will remain unread by client */
         send(self->client, "hello", 5, 0);

         if (variant->socket_type == SOCK_DGRAM) {
                 close(self->server);
         }
         else {
                 if (!self->child)
                         SKIP(return);

                 close(self->child);
         }

         n = recv(self->client, buf, sizeof(buf), 0);

         ASSERT_EQ(-1, n);

         if (variant->socket_type == SOCK_STREAM ||
                 variant->socket_type == SOCK_SEQPACKET)
                 do { ASSERT_EQ(ECONNRESET, errno); } while (0);
         else
                 ASSERT_EQ(EAGAIN, errno);
}

OR

TEST_F(unix_sock, reset_unread_behavior)
{
         char buf[16] = {};
         ssize_t n;

         /* Send data that will remain unread by client */
         send(self->client, "hello", 5, 0);

         if (variant->socket_type == SOCK_DGRAM) {
                 close(self->server);
         }
         else {
                 if (self->child)
                     close(self->child);
                 else
                     close(self->server);
         }

         n = recv(self->client, buf, sizeof(buf), 0);

         ASSERT_EQ(-1, n);

         if (variant->socket_type == SOCK_STREAM ||
                 variant->socket_type == SOCK_SEQPACKET)
                 do { ASSERT_EQ(ECONNRESET, errno); } while (0);
         else
                 ASSERT_EQ(EAGAIN, errno);
}

OR

is there a better way to handle this?

I ran the KCOV_OUTPUT command using the first *TEST_F above* as the Test 
2 and got the output below:
*$ KCOV_OUTPUT=kcov KCOV_SLOTS=8192 
./tools/testing/selftests/net/af_unix/unix_connreset*
TAP version 13
1..6
# Starting 6 tests from 3 test cases.
#  RUN           unix_sock.stream.eof ...
#            OK  unix_sock.stream.eof
ok 1 unix_sock.stream.eof
#  RUN           unix_sock.stream.reset_unread_behavior ...
#            OK  unix_sock.stream.reset_unread_behavior
ok 2 unix_sock.stream.reset_unread_behavior
#  RUN           unix_sock.dgram.eof ...
#            OK  unix_sock.dgram.eof
ok 3 unix_sock.dgram.eof
#  RUN           unix_sock.dgram.reset_unread_behavior ...
#            OK  unix_sock.dgram.reset_unread_behavior
ok 4 unix_sock.dgram.reset_unread_behavior
#  RUN           unix_sock.seqpacket.eof ...
#            OK  unix_sock.seqpacket.eof
ok 5 unix_sock.seqpacket.eof
#  RUN           unix_sock.seqpacket.reset_unread_behavior ...
#            OK  unix_sock.seqpacket.reset_unread_behavior
ok 6 unix_sock.seqpacket.reset_unread_behavior
# PASSED: 6 / 6 tests passed.
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Thank you once again for your continuous guidance and patience.
It's a worthy and rewarding learning period for me.


