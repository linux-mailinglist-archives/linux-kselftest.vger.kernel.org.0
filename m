Return-Path: <linux-kselftest+bounces-45519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C57C5C5610A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 08:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E40D34E3FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43B7326D6F;
	Thu, 13 Nov 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YdJrFlHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic309-22.consmr.mail.gq1.yahoo.com (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B6311596
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019039; cv=none; b=p0Ve7CBCFnJQ0xzgN9DGFuy78r3RMFx/AIHPixW3vPAvoaoyy1eQ5cfNIIb14EAUmalq5h4F4bxw5XejDGwb7YtKZWhdlYYmBJnCYN6TAS1AY/I8DqUQZiGFpnBQSGyZ90lhU4RQbvkzO/5oHnYaGV+ZHnvAPu9EkcjmfDftV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019039; c=relaxed/simple;
	bh=bipiMI/qfWSuAJ3wnC4NPJxUrzV0+z5UO40lEU1V45o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2W+AJSPqskqaVQjeAD8fMLASUAQaS5Dn6hLD9L5s+HaYv31XKkJns3ztEjkVQXr2hCn3P4r3TP8xbjTNzfRuy6nPuG3IrQBol5BHi01YK2XM/ceNuQDHKAtDrTiJC3TFXxobLWVM/qxqNKsH+w+RDR2eBULzgioQgTnuyDDqqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YdJrFlHH; arc=none smtp.client-ip=98.137.65.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763019027; bh=vhtB/c33uxa4OUD6Wsm09MTPxU4EGKamAQEd8oPw/yg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YdJrFlHHnJwtSD7IOxyhpuQty+1u6VRpWYszJgBBPC9N2MxHcIKgG8hef1t4kcI09pkSiExOZEn7dJynEJel1NKjFbzLkC+8iBArn/kRrDZ/7RwqsbqXvjh5B3hqyq69g2n3cHns7wS6JqWN3EpEhJfXzlyOjVRMQQxFT5/Kis7JJialWDDo+sfaSJhC73R55KkqDQzL+A+w5aoUsqGVY4vkNiidkp9m2M5VxCmeRE0twm4H2vF5kwuFkqBce+5c5Kjnxp7OeN2Kz/wD4eNHLhX3UwE/qvdRgfjOuY+ge0xGUp0FI2njLujUc4md/XVRN/sLxj9jH1PRl6MXwB/Gcg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763019027; bh=NK+8Z4PwW/lll2F3tt+sSLsojubtUGQUq1KHeXWSZpV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Afl29fMuobmnLqcAcAYVAPyUatsY/LvAz0S8ESbF1tsknEJdvaBBtEUHJRGnSmwpAvr/h13A8WEOw8y/r0nfJbYnKmN2/gZWS6cBMA/la/Of7fQVx07lB4ye6rBXw2WYRv+IR9Vw38WMFF/onTWAgqtbAsobBriD9SLGokylXGRm7GNMDyasKw/2h5ePZPrmdtTJSrOXRQU5PF81FgBUpINhzFSHFiAJUo4c0n11s5jI1nC/pwplWG9avqyoM3yY7kUtIP+fMjvy4gviEkwokh50NrufRd+uw3V22UYuMxYZziInyV5XeFgI+dIp98BulqAsiECTa/BYf6Fd4QMgYw==
X-YMail-OSG: njGOSx0VM1lF.YS2Jbkp5nZvfgakSyLL.IiZsuYmPLYkumf4E_JwqiPuib352J_
 iWr9Gnhu8A0HXnajrLYviVKRC_1iv2UuP5KxrVS4NfNSWH1xvUrFD3EpoonX.q2._8SWzWRku9D_
 uIhEgzjtq.TyU_ogxY.h7CvrRmxwLNQGi2nKtPzudj6KoGNVJk.qYKRrl8XOFCV0MCHg3DAYNjx5
 RQPfPU4Xh4y9seJDHG5xNGlm.p3TTT9SrxxDL7nNj4guxyBJADKpFqL.F2UQTKGjJzCCqvkOql4K
 tjNjElVPgvsBS6k0Yxl83dLOk8kd4I4nGsDHf44pkySc.yshYfkwYLj1cWQ_bmlQzM2vT.OQrWqF
 KvuAsEciXfC_IKsB_4rG9TbcYzRk.ez6BOuhWL_He_TYUhF3bHTX9B71j86w5guT02ofS0t3B653
 X4BHy0QT.xefSQHqYSVvy1fxf.JMJQC0kVbf.atTxZ8eUc8_eitUqm_5g5Q1WGn0IC_Pa1.n9olu
 5uKrPU6QSjKweDM5ptHRfhggobli32ifhF7CSbZboO9sB1lsBCypFa9H4zc22VIdaCs0WZpwK0Ns
 MQj14oTvRS6jL8XVkItDpR1fwNl1XkUmRH8P.XziRPpU8d.pESQKFT8OIcvQcILR_KDfdK1tYBwZ
 iFA0cUPSUC2uiV8m_wXhvuH4uB.V4R0I4W39UfkAloXHFGqaMiB0qHjYZkNe5.ne_Kus1RjX6Ekb
 XnLjLXTesaTmxd6FD9usvcuKo2FoHrfz7MClFbgeJd6eXTfs9ZzI0ERLKdTneyhHRc5QxG9Iu0Mf
 yM2Ez2asF_Hk8fa44th14frYkMrZLsDk5lc5r0DhOO_Vd00V4.DBBvQaioeaIdh_G7QRB1iqVuVs
 NK_wsIuFzpR5hN1U9KkafcwL5_iEU3GQiKLdynN5UGv8d_uitS5KIGh0K4mjP7ZxW_1tDNox2RXU
 fDp4rcXvxhzbYqmubgEuwYV.0xxuwTcvJlE7mVTszzRH1FGLCEX9WYxWISkCPfJTep5Rof9hh6qx
 zmggNp3DETmd.bDS8rCo.DzXO1r_rY8d9leg3r0sVrbL0U3KVoxOi48fX_Kna.3q.Pg9pWko7TQG
 b9tSVYV4EQ1KOX8jszrXT6NkYz0Nbfrl5TkxuSvGBSiq0rSCXkUrkCt_Bj0mmQDIuh2SUOY9Qzp9
 knW.49ObRtjfJh240_R5blkLu6J.ER06F_i5kzJ9gwuPeGK0Qz69XxIgdRkB8wKSp3Qt648dS.pD
 72Z92UE75aNCcTjjF2K.HmDWKdOyQpvc8DBEpqnXtBGLdz473_MPsEVPqF5dUtVUQe9i39QC6ebF
 0frArOACJMJVk9XsNZn72YtfeAli1Ibp6laTvwqnnrBIeQ.FdaD5_CMlUMNHj67P4PZcVYP664Eo
 dPNyX1AIlssEvH7ofsetsq_khe4qxrdfuhIkiF8NlZ0fRSD.oRiTYeFWm0nySNHzmmwOf5Wzzdf6
 6wLIsBNmcIpdJFgKfzr.1YyLbEJO7jWyW_.AtwaPHkxWNLaItkF4eYHcHcxEJxdQTk7p49Obrji6
 v85qXTTMaxRbCXWdWOa92IpIgh3SuPTsUwwJ133_Pp8B9qOr5H_TrD5JK8.X1W2uLyi6CfN77mED
 PDVY9HxK1MsEDWYp11su54sDmFGe5nq7wbU1E7_R6miHCbmKkWyIT0oOtJjBsEHewE.nYpW_YMR4
 rEJWfcmMq2GQ_2exmufQlEw5Yv81kcpRsQix1xBoextU_KlXmEayoh86FFz4bnXSlz9IcvGfYTkD
 _ocPQdtHb0qH1_9djzFS7KOTySIbmeHKuyWuBHuLFIeWFSEQdOUc9i9ZKB7gDkxTxq7YmPkXgzOf
 OAEqCRSQfzrIcZPHQYCCeKDcQM6G3iczj4KKV4JYFfg8yo.2EHVdz44osprinvCMOdKi7rJ7oTCM
 bH9jd_2xLBJYSU3Yo2TyssVmTFqHP_bHJT.mQMNJRwqUdNcsNZ2cWTur3iT_GUNtyDUh7BnJzkua
 YQowPFjf0VHkof4JAmfM8LDRxSc.QYt4G8YPLBkDKUigZxX1XKSpckotgAJlOEiLwxdbAd0rNgwq
 .lq7RY24Rs5VkFmmtN6WKMlyPpxC4XJ3E371CcKe1JDxo9pCA9lCqEqLDcakBkFF.C9t0tyFbcaV
 NiI1MZAK.CNTBYlS7exswR7mVi_VG_QNrVqnWKcfyRrIYm5LKP4YPHkm8GnwV7qq6n0ETAvhwraf
 w1FPrWLuE4f_hNjKyNR0J79jACKIWxApxlj9xiUuv9E3QPoL0LCn_HwG4BBrf
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 161470a8-a3b2-4c18-9f40-a9ca9c618b08
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 07:30:27 +0000
Received: by hermes--production-bf1-58477f5468-m6v5n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c412dc1e93a6f5fb8334dd2b670743fb;
          Thu, 13 Nov 2025 07:30:24 +0000 (UTC)
Message-ID: <233cb349-b7ea-42cf-8cc4-ce08cf3179ee@yahoo.com>
Date: Thu, 13 Nov 2025 08:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251112212026.31441-1-adelodunolaoluwa.ref@yahoo.com>
 <20251112212026.31441-1-adelodunolaoluwa@yahoo.com>
 <CAAVpQUB97EBnTbA9pKwdhPM0pHadiM3QhP4_1qLSKGg2LAwzkA@mail.gmail.com>
 <295e5440-94eb-447f-b4f0-4943e9d02f1c@yahoo.com>
 <CAAVpQUAyPwyG=aSnv-2w7g3dqhB3BLXGoo5VmbSNqQ0txpqqWQ@mail.gmail.com>
 <335f64d5-390b-4529-b2da-0af019c7f598@yahoo.com>
 <CAAVpQUDX2LcWu+u5CHSJUoPnHLuGNoPzEZuV+K67WoPUUvymdg@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUDX2LcWu+u5CHSJUoPnHLuGNoPzEZuV+K67WoPUUvymdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/13/25 07:52, Kuniyuki Iwashima wrote:
> On Wed, Nov 12, 2025 at 10:41 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> On 11/13/25 07:10, Kuniyuki Iwashima wrote:
>>> On Wed, Nov 12, 2025 at 9:25 PM Sunday Adelodun
>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>> On 11/12/25 23:04, Kuniyuki Iwashima wrote:
>>>>> On Wed, Nov 12, 2025 at 1:20 PM Sunday Adelodun
>>>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>>>> Add selftests to verify and document Linux’s intended behaviour for
>>>>>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>>>>>> The tests verify that:
>>>>>>
>>>>>>     1. SOCK_STREAM returns EOF when the peer closes normally.
>>>>>>     2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>>>>>>     3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>>>>     4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>>>>     5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>>>>
>>>>>> This follows up on review feedback suggesting a selftest to clarify
>>>>>> Linux’s semantics.
>>>>>>
>>>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>>>>>> ---
>>>>>>     tools/testing/selftests/net/.gitignore        |   1 +
>>>>>>     tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>>>>>     .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++++
>>>>>>     3 files changed, 180 insertions(+)
>>>>>>     create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
>>>>>> index 439101b518ee..e89a60581a13 100644
>>>>>> --- a/tools/testing/selftests/net/.gitignore
>>>>>> +++ b/tools/testing/selftests/net/.gitignore
>>>>>> @@ -65,3 +65,4 @@ udpgso
>>>>>>     udpgso_bench_rx
>>>>>>     udpgso_bench_tx
>>>>>>     unix_connect
>>>>>> +unix_connreset
>>>>>> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
>>>>>> index de805cbbdf69..5826a8372451 100644
>>>>>> --- a/tools/testing/selftests/net/af_unix/Makefile
>>>>>> +++ b/tools/testing/selftests/net/af_unix/Makefile
>>>>>> @@ -7,6 +7,7 @@ TEST_GEN_PROGS := \
>>>>>>            scm_pidfd \
>>>>>>            scm_rights \
>>>>>>            unix_connect \
>>>>>> +       unix_connreset \
>>>>>>     # end of TEST_GEN_PROGS
>>>>>>
>>>>>>     include ../../lib.mk
>>>>>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..9413f8a0814f
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>>> @@ -0,0 +1,178 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>>>>>> + *
>>>>>> + * This test verifies:
>>>>>> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
>>>>>> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
>>>>>> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>>>> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>>>> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>>>> + *
>>>>>> + * These tests document the intended Linux behaviour.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#define _GNU_SOURCE
>>>>>> +#include <stdlib.h>
>>>>>> +#include <string.h>
>>>>>> +#include <fcntl.h>
>>>>>> +#include <unistd.h>
>>>>>> +#include <errno.h>
>>>>>> +#include <sys/socket.h>
>>>>>> +#include <sys/un.h>
>>>>>> +#include "../../kselftest_harness.h"
>>>>>> +
>>>>>> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
>>>>>> +
>>>>>> +static void remove_socket_file(void)
>>>>>> +{
>>>>>> +       unlink(SOCK_PATH);
>>>>>> +}
>>>>>> +
>>>>>> +FIXTURE(unix_sock)
>>>>>> +{
>>>>>> +       int server;
>>>>>> +       int client;
>>>>>> +       int child;
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT(unix_sock)
>>>>>> +{
>>>>>> +       int socket_type;
>>>>>> +       const char *name;
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>>>>>> +       .socket_type = SOCK_STREAM,
>>>>>> +       .name = "SOCK_STREAM",
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>>>>>> +       .socket_type = SOCK_DGRAM,
>>>>>> +       .name = "SOCK_DGRAM",
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
>>>>>> +       .socket_type = SOCK_SEQPACKET,
>>>>>> +       .name = "SOCK_SEQPACKET",
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_SETUP(unix_sock)
>>>>>> +{
>>>>>> +       struct sockaddr_un addr = {};
>>>>>> +       int err;
>>>>>> +
>>>>>> +       addr.sun_family = AF_UNIX;
>>>>>> +       strcpy(addr.sun_path, SOCK_PATH);
>>>>>> +       remove_socket_file();
>>>>>> +
>>>>>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>>>>>> +       ASSERT_LT(-1, self->server);
>>>>>> +
>>>>>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>>>>>> +       ASSERT_EQ(0, err);
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>>>> +               err = listen(self->server, 1);
>>>>>> +               ASSERT_EQ(0, err);
>>>>>> +       }
>>>>>> +
>>>>>> +       self->client = socket(AF_UNIX, variant->socket_type | SOCK_NONBLOCK, 0);
>>>>>> +       ASSERT_LT(-1, self->client);
>>>>>> +
>>>>>> +       err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>>>>>> +       ASSERT_EQ(0, err);
>>>>>> +}
>>>>>> +
>>>>>> +FIXTURE_TEARDOWN(unix_sock)
>>>>>> +{
>>>>>> +       if ((variant->socket_type == SOCK_STREAM ||
>>>>>> +            variant->socket_type == SOCK_SEQPACKET) & self->child > 0)
>>>>>> +               close(self->child);
>>>>>> +
>>>>>> +       close(self->client);
>>>>>> +       close(self->server);
>>>>>> +       remove_socket_file();
>>>>>> +}
>>>>>> +
>>>>>> +/* Test 1: peer closes normally */
>>>>>> +TEST_F(unix_sock, eof)
>>>>>> +{
>>>>>> +       char buf[16] = {};
>>>>>> +       ssize_t n;
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>>>> +               self->child = accept(self->server, NULL, NULL);
>>>>>> +               ASSERT_LT(-1, self->child);
>>>>>> +
>>>>>> +               close(self->child);
>>>>>> +       } else {
>>>>>> +               close(self->server);
>>>>>> +       }
>>>>>> +
>>>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>>>> +               ASSERT_EQ(0, n);
>>>>>> +       } else {
>>>>>> +               ASSERT_EQ(-1, n);
>>>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +/* Test 2: peer closes with unread data */
>>>>>> +TEST_F(unix_sock, reset_unread_behavior)
>>>>>> +{
>>>>>> +       char buf[16] = {};
>>>>>> +       ssize_t n;
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_DGRAM) {
>>>>>> +               /* No real connection, just close the server */
>>>>>> +               close(self->server);
>>>>>> +       } else {
>>>>>> +               /* Establish full connection first */
>>>>>> +               self->child = accept(self->server, NULL, NULL);
>>>>>> +               ASSERT_LT(-1, self->child);
>>>>>> +
>>>>>> +               /* Send data that will remain unread */
>>>>>> +               send(self->client, "hello", 5, 0);
>>>>> Could you move this send() before "if (...)" because we want
>>>>> to test unread_data behaviour for SOCK_DGRAM too ?
>>>>>
>>>>> Otherwise looks good, so with that fixed:
>>>>>
>>>>> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>
>>>>> Thanks!
>>>> Thank you for the prompt response.
>>>> I thought of putting the send before the if the statement , but I was afraid
>>>> STREAM and SEQPACKET connections won't be accepted before data sending.
>>> connect() create the paired child socket and accept()
>>> allocates a file descriptor to expose the socket to user
>>> space.
>> Thank you for this explanation.
>>> In that sense, the comment above accept() sounds a
>>> bit weird ;)
>> I understand.
>> I am changing it to
>> /* Accept client connection */
> I'd remove it since it just repeats the code, but up to you.
>
> Thanks!

Sent.

I removed the comment, but unfortunately I didn't know it didn't save.
so, the comment was sent along with patch.

Thank you for the guidance and patience.
I am open to any feedback if any.
>
>> If this is accepted, I will send v5 immediately
>>
>> Thank you for your guidance.
>>>
>>>> I will start working on v5.
>>>>
>>>> That part will look like this now:
>>>> /* Test 2: peer closes with unread data */
>>>> TEST_F(unix_sock, reset_unread_behavior)
>>>> {
>>>>            char buf[16] = {};
>>>>            ssize_t n;
>>>>
>>>> */* Send data that will remain unread */
>>>>            send(self->client, "hello", 5, 0);*
>>>>
>>>> *if (variant->socket_type == SOCK_DGRAM) {
>>>>                    /* No real connection, just close the server */
>>>>                    close(self->server);
>>>>            } else {
>>>>                    /* Establish full connection first */
>>>>                    self->child = accept(self->server, NULL, NULL);
>>>>                    ASSERT_LT(-1, self->child);
>>>>
>>>>                    /* Peer closes before client reads */
>>>>                    close(self->child);
>>>>            }*
>>>>
>>>>            n = recv(self->client, buf, sizeof(buf), 0);
>>>>            ASSERT_EQ(-1, n);
>>>>
>>>>            if (variant->socket_type == SOCK_STREAM ||
>>>>                variant->socket_type == SOCK_SEQPACKET) {
>>>>                    ASSERT_EQ(ECONNRESET, errno);
>>>>            } else {
>>>>                    ASSERT_EQ(EAGAIN, errno);
>>>>            }
>>>> }
>>>>
>>>> Thank you once again.
>>>>>> +
>>>>>> +               /* Peer closes before client reads */
>>>>>> +               close(self->child);
>>>>>> +       }
>>>>>> +
>>>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>>>> +       ASSERT_EQ(-1, n);
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +           variant->socket_type == SOCK_SEQPACKET) {
>>>>>> +               ASSERT_EQ(ECONNRESET, errno);
>>>>>> +       } else {
>>>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +/* Test 3: closing unaccepted (embryo) server socket should reset client. */
>>>>>> +TEST_F(unix_sock, reset_closed_embryo)
>>>>>> +{
>>>>>> +       char buf[16] = {};
>>>>>> +       ssize_t n;
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_DGRAM)
>>>>>> +               SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");
>>>>>> +
>>>>>> +       /* Close server without accept()ing */
>>>>>> +       close(self->server);
>>>>>> +
>>>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>>>> +
>>>>>> +       ASSERT_EQ(-1, n);
>>>>>> +       ASSERT_EQ(ECONNRESET, errno);
>>>>>> +}
>>>>>> +
>>>>>> +TEST_HARNESS_MAIN
>>>>>> +
>>>>>> --
>>>>>> 2.43.0
>>>>>>


