Return-Path: <linux-kselftest+bounces-44399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F03C204DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81BB74E6368
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA89126C03;
	Thu, 30 Oct 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BWgPcoTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic313-19.consmr.mail.gq1.yahoo.com (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544C1A4F3C
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831922; cv=none; b=m+V7VoHd8d3zwtAlE22T0CkLMgO4iFKTzOYp3eU759o5XH6UzADhAvrpRC3vXP1JslqEvgQQPLPBOhUcf4aq2LY6gSwYpvgsQogpgpUCmkSx9Tg+H32jIyopFpOpOphRnasYopWcMcwXFuCRA23V/Jdoh+gg1PeeG32DRDzsGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831922; c=relaxed/simple;
	bh=aEFqZw6aFDt12WHgRCSu6gwStoG5nCd1PZ89+g4e2cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY+j+xfXSU/y+mR39Ntjt+j3uYCfoZWI3tM3P+JOf76fZfTKLf1IpTqsS09arQuXW3Qjk64Hjn1sTw4P8XpDzlYl6z5mAlP7XNn2SISX7c0vREE8uNiz9ECbabstIQ0G2rw7p/ej5tm3Lah/izx07LUPJccdsfwUhP0cTr9pJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BWgPcoTP; arc=none smtp.client-ip=98.137.65.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761831914; bh=yHIYzJpxqjSw6u75ZKXfrlyGuW7/O4GYojD4cOMN2BY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BWgPcoTP4IBJEW3c5l1JkKC/uIxHI8GuQK5DLi/XL/gv7cq8NNoSMaO6jXQ67Wm0fnXRYQqkSn43wnBt/mHW/7aUFF3Cg5TMDcghTd9JPR1iijDTsVO873U98i3ivtILpvD9NA9AB8CjCOSKzGDBBWEj3hIXh9aJNEehuiIEKNLLpypU1MEQePmoFToz1wF2ENmRAipaJLNS3EQycZN7QDSKbssfpTr7pjYykBAGGMnIcsBqfQQeDwspkq0thlS5dJhLcFSWI8pnKi97JJ7M5QI087EjJRlPkPmrtc8NU7EFbvDC+6ovn57h+7fMVf0pp7EPmME2oAzIIOMXIheWVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761831914; bh=SyOwVI3iAJvJeZyJQI7ZUsndvIHuoBcRhfbwm5M2LSm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mCvHaZ2rd3ByBmrEDxaKS5H6K8vlC7hjd8jHuiUhNzDD5m8DZfw7LRnBNWq2GErOFsoyrTZddRixMK0Elquy6pCNebZj+fw2KNFOacgmny5fQQcxyXy2zQSRQpXL+76D/A5k9Dgwx2jSX/kTxhpFSUyClPx//LDYzdRIEnk8MSBmpwdPHz27y0Jp892MrBfdHxh6ZfeLYQnUPIeN0mTiiKgfqosrK04+JqVYzZA53c5I1nsKC41skzCojPtwnl7MZtggK4WwB/mYIXmtndU8rlrObwkZ2UY4qLWsn+c6pMI223ALU9u7MeScBtvjVa+VjMixEghz1+LtqA3+lTJvYQ==
X-YMail-OSG: AKm.6p8VM1lVwk1bXEhluTH5IsmruEtbX8HHpv9cfMmjhm_HKG0ApgFeK7OKgZR
 kJ7rnv.faU2W2A57LzlArpGNm0HuP9rQVxV.yxnYUo8QJY7MwPJVxY6TtkUcsYBAXvyucxwc3Mez
 aEQXAIv7hmdJglhqZrQ._Si3_A5fXmYwwaw_mtUY67KIGMjpxLFog0WsP7K42Bpff3_Dvbv6cdCg
 682vKE0F3lniKm6OOGwmii2KD8xKa50pI3Toe8NeW0yLAgNrCedmtXLfR3RrLh0Zxb82lPEJshWu
 e9cz3VkINKRbhFWAIs5eWDoLIV2rLOj8BzcHeMA.X5IATxdLbtZfCIjRCklLN.HkeTrtlyXLM3o3
 HSB39Efru4iGok0cX2KCGKr.Gz8SM5Am2yqFMJZEzUPt9zrEvXeeVI11xU.FAkrIFwXkhazdh9Ez
 porORi.ODYzq0cZ7nRtwbNf1rYukCoEya0odvJOvIRRcwV5XSCnkYzn_KXCwH2aOe7ro86ObrdHT
 V1JJHtZ5Pjtl8aW1rO_LVXbI_Cp5MHXO6hXW.kSwFrWSt7Cxj8mUh3dTyuHU1iafJBjbow9AsjJs
 6uBT5nxSDONiSB.U7Hkr0kovEW21EOHT51AyS_n75LR98eyadKNHhgtnUymdYLJX8bQoXBEDTICt
 m0ZkR110Hi9X_hFzyShKHRykIODfYUlepPnSTxwh4kZZvxhFEKbuxvap9Gm_dubBYqGZcb_ixo9N
 5MZr8O8RpbdO1RQYeKnM3Bc7rEG7Yi5cegMAvTIQLx6ZuMfFOlTJU40VNLkeN3xeQ5ggTdZp6oRu
 SiROsYYqKR7EeaF_l8HjP57qtFUmQguusGBXbhu2PiUorQKLw2JpJkIdK.WD6T4N8CgVf9uK.78F
 lsQcyvG2p07Pcaya_lgZgQTR8L3l8vAhezLInfacoiOZAQoZnILFc8uThe9sKzCb7NCJXqGZftc4
 Dxbxeql.d9siyukTp_MxegirI0NtXoEoKXVVYYJhUNO5aEZeuUqgrVYG_m.xM.XZ18f_onkGhD8.
 RoCV5eAqv1nSLJT5DZ1GwgPZvsQrRA95vd3UJEsy2YPjYERQCnmfPKsuATzDqR.V0xpJ3v5IbE_Q
 bY0AxIc9yo1m45iYF8_meCN9K9IrDpuFdEPs4.dPuDYfz3NsHuS76WSmI6yqo27M5_VYeZXQtcS0
 qCsGgxjnAc2AkA4e1TGpGeybPaL8QFQl73b8FIJulT0rvKBtFdRgTQBhZ390buGf9ZbcE8gimAN7
 EKFGllnsXjSzoAlsdN8vm0W.5x4qHMs7pB48n2l5Pxw.fJmsTeJOAIsqJ2olKs4K7wiNABf46qiO
 e3tc7wqcXN5UpnWBSL.nn29R.7m2r4rqo3nAGTDzLW_DcdHiqYRERFX1XW9B81pQ6qb3o2YuVa.I
 lYsX2z5TqfBwIrl_TRft0vGMTf3TMqwsGraD53_hSLN7vmj9rVh9zPj161OzmyoiZrQcatWu0FZv
 emugkz9rAETL6Q1Llm6lS6AiTySJdh7LwIBsEvyGUS9JXmnaMne2XL8ovcRnc5XXyZY.8FGqPflQ
 B1QSysKDQyxUKD5xU5nog_p_TfZUD8yiXsqeUki.spHxzAcH47X.m0VppQdeTkmNaxxZAKlG_GB.
 A.bUm5r_7acc0ekx3So9Ch6wCAT.3inj_iPn_fEjUIauMirCJfTm21Zebmwc2ldkkvzPEGtdb7jJ
 YybGg0e.Jjh9ZMdCxnnHUF7uIO3YTXXhIDf0LAgQAkcilUcMzEirF1hWoVzBB0LwVloUS5ddKuM_
 BhzdFXCs1ZDZO8NU.prNdZNFLY2iKT1VaZ4.GIooo9OVnwzivCvePaKxAqQTuP0iSpeC2SbeZYC3
 SxNfDW4ZfIaoiCgzmdmqUm09CWQFSuoBjBQHCc2oOY9GvupWByWbYqwVtsZ0j9K63APmFsyFk.5A
 iQ7FxBOsetz8lLTOOqfLRHb6cXrDUDpyEBrsr442_Y.DGy.kWpiXd56VKF7Y.oJ1gpbQgK0xA5NG
 ulVFx.bmzje5ugVYQH8bOvIZrZkPfAc2ae05cfUOfvLnffrmgpQ2q2KOnKTi56lLuFLsf60jZDsQ
 VzZuCz1dx.gqXH7AMBGTgYLrH05fYRDzdHDBGmhvekdkEPiCRS8Jzn3P8usBg1gw0WT0FLPgzpyO
 .I3bGlR9i3DqEh2vXllLbliy71Ca.rAxm2.Sww9yJMzuFpokyjW1DLQok75OsWpVyM4KzLQDd0l_
 6HSJNWZcqrE3ugAN9Dmxau4IBivIfnSTVFEK_BFuqS8OaiTkylhHheK_3dVO9majLt2JEQkAYdY9
 o8zObVTpxkqf9ziUm
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: eb168b63-a1cb-4d05-9a35-dba5ad33248a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 30 Oct 2025 13:45:14 +0000
Received: by hermes--production-bf1-748c868fb8-6gpbb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 80d5fd42e856c29b84fb2d08d66114ff;
          Thu, 30 Oct 2025 13:45:11 +0000 (UTC)
Message-ID: <7c4070ed-1702-4288-90c6-7edb90468718@yahoo.com>
Date: Thu, 30 Oct 2025 14:45:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "=David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 David Hunter <david.hunter.linux@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251025190256.11352-1-adelodunolaoluwa.ref@yahoo.com>
 <20251025190256.11352-1-adelodunolaoluwa@yahoo.com>
 <CAAVpQUAbDfaiAZ_NCppGE5vsafWoU7V1xvnqtQQM44cwv6jHsA@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUAbDfaiAZ_NCppGE5vsafWoU7V1xvnqtQQM44cwv6jHsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/28/25 19:28, Kuniyuki Iwashima wrote:
> On Sat, Oct 25, 2025 at 12:03 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> Add selftests to verify and document Linux’s intended behaviour for
>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>> The tests cover:
>>
>>    1. EOF returned when a SOCK_STREAM peer closes normally.
>>    2. ECONNRESET returned when a SOCK_STREAM peer closes with unread data.
>>    3. SOCK_DGRAM sockets not returning ECONNRESET on peer close.
>>
>> This follows up on review feedback suggesting a selftest to clarify
>> Linux’s semantics.
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>> ---
>> Changelog:
>>
>> Changes made from v1:
>>
>> - Patch prefix updated to selftest: af_unix:.
>>
>> - All mentions of “UNIX” changed to AF_UNIX.
>>
>> - Removed BSD references from comments.
>>
>> - Shared setup refactored using FIXTURE_VARIANT().
>>
>> - Cleanup moved to FIXTURE_TEARDOWN() to always run.
>>
>> - Tests consolidated to reduce duplication: EOF, ECONNRESET, SOCK_DGRAM peer close.
>>
>> - Corrected ASSERT usage and initialization style.
>>
>> - Makefile updated for new directory af_unix.
>>
>>   tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>   .../selftests/net/af_unix/unix_connreset.c    | 161 ++++++++++++++++++
>>   2 files changed, 162 insertions(+)
>>   create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>>
>> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
>> index de805cbbdf69..5826a8372451 100644
>> --- a/tools/testing/selftests/net/af_unix/Makefile
>> +++ b/tools/testing/selftests/net/af_unix/Makefile
>> @@ -7,6 +7,7 @@ TEST_GEN_PROGS := \
>>          scm_pidfd \
>>          scm_rights \
>>          unix_connect \
>> +       unix_connreset \
>>   # end of TEST_GEN_PROGS
>>
>>   include ../../lib.mk
>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>> new file mode 100644
>> index 000000000000..c65ec997d77d
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>> + *
>> + * This test verifies that:
>> + *  1. SOCK_STREAM sockets return EOF when peer closes normally.
>> + *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread data.
>> + *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes.
>> + *
>> + * These tests document the intended Linux behaviour.
>> + *
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <sys/socket.h>
>> +#include <sys/un.h>
>> +#include "../../kselftest_harness.h"
>> +
>> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
>> +
>> +static void remove_socket_file(void)
>> +{
>> +       unlink(SOCK_PATH);
>> +}
>> +
>> +FIXTURE(unix_sock)
>> +{
>> +       int server;
>> +       int client;
>> +       int child;
>> +};
>> +
>> +FIXTURE_VARIANT(unix_sock)
>> +{
>> +       int socket_type;
>> +       const char *name;
>> +};
>> +
>> +/* Define variants: stream and datagram */
>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>> +       .socket_type = SOCK_STREAM,
>> +       .name = "SOCK_STREAM",
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>> +       .socket_type = SOCK_DGRAM,
>> +       .name = "SOCK_DGRAM",
>> +};
> Let's add coverage for SOCK_SEQPACKET,
> which needs listen() / connect() but other semantics
> are similar to SOCK_DGRAM.

I will add it through:
if (variant->socket_type == SOCK_STREAM ||
		variant->socket_type == SOCK_SEQPACKET)
  

in both the setup and teardown fixtures with a little bit of modification

where necessary (especially in the setup fixture).

And also the fixture_variant_add macro.

>> +
>> +FIXTURE_SETUP(unix_sock)
>> +{
>> +       struct sockaddr_un addr = {};
>> +       int err;
>> +
>> +       addr.sun_family = AF_UNIX;
>> +       strcpy(addr.sun_path, SOCK_PATH);
>> +
>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>> +       ASSERT_LT(-1, self->server);
>> +
>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>> +       ASSERT_EQ(0, err);
>> +
>> +       if (variant->socket_type == SOCK_STREAM) {
>> +               err = listen(self->server, 1);
>> +               ASSERT_EQ(0, err);
>> +
>> +               self->client = socket(AF_UNIX, SOCK_STREAM, 0);
>> +               ASSERT_LT(-1, self->client);
>> +
>> +               err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>> +               ASSERT_EQ(0, err);
>> +
>> +               self->child = accept(self->server, NULL, NULL);
>> +               ASSERT_LT(-1, self->child);
>> +       } else {
>> +               /* Datagram: bind and connect only */
>> +               self->client = socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0);
>> +               ASSERT_LT(-1, self->client);
>> +
>> +               err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>> +               ASSERT_EQ(0, err);
>> +       }
>> +}
>> +
>> +FIXTURE_TEARDOWN(unix_sock)
>> +{
>> +       if (variant->socket_type == SOCK_STREAM)
>> +               close(self->child);
>> +
>> +       close(self->client);
>> +       close(self->server);
>> +       remove_socket_file();
>> +}
>> +
>> +/* Test 1: peer closes normally */
>> +TEST_F(unix_sock, eof)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       if (variant->socket_type != SOCK_STREAM)
>> +               SKIP(return, "This test only applies to SOCK_STREAM");
> Instead of skipping, let's define final ASSERT() results
> for each type.
>
> Same for other 2 tests.

can I use a switch statement in all the tests? say, for example

test1:

...

switch (variant->socket_type) {

case SOCK_STREAM:

case SOCK_SEQPACKET:

         ASSERT_EQ(0, n);

case SOCK_DGRAM:

         ASSERT(-1, n);

         ASSERT_EQ(EAGAIN, errno);

         break;

}

...

test2:

...

switch (variant->socket_type) {

case SOCK_STREAM:

case SOCK_SEQPACKET:

         ASSERT_EQ(-1, n);

         ASSERT_EQ(ECONNRESET, errno);

         break;

case SOCK_DGRAM:

         ASSERT(-1, n);

         ASSERT_EQ(EAGAIN, errno);

         break;

}
...

test 3:

...

switch (variant->socket_type) {

case SOCK_STREAM:

case SOCK_SEQPACKET:

         ASSERT_EQ(-1, n);

         ASSERT_EQ(ECONNRESET, errno);

         break;

case SOCK_DGRAM:

         ASSERT(-1, n);

         ASSERT_EQ(EAGAIN, errno);

         break;

}

...

if not these, could you kindly shed more light to what you meant

>
>
>> +
>> +       /* Peer closes normally */
>> +       close(self->child);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>> +       if (n == -1)
>> +               ASSERT_EQ(ECONNRESET, errno);
> ... otherwise, we don't see an error here
>
>> +
>> +       if (n != -1)
>> +               ASSERT_EQ(0, n);
> and this can be checked unconditionally.
did you mean I should remove the if (n != -1) ASSERT_EQ(0, n); part?

>
>> +}
>> +
>> +/* Test 2: peer closes with unread data */
>> +TEST_F(unix_sock, reset_unread)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       if (variant->socket_type != SOCK_STREAM)
>> +               SKIP(return, "This test only applies to SOCK_STREAM");
>> +
>> +       /* Send data that will remain unread by client */
>> +       send(self->client, "hello", 5, 0);
>> +       close(self->child);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>> +       ASSERT_EQ(-1, n);
>> +       ASSERT_EQ(ECONNRESET, errno);
>> +}
>> +
>> +/* Test 3: SOCK_DGRAM peer close */
>> +TEST_F(unix_sock, dgram_reset)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       if (variant->socket_type != SOCK_DGRAM)
>> +               SKIP(return, "This test only applies to SOCK_DGRAM");
>> +
>> +       send(self->client, "hello", 5, 0);
>> +       close(self->server);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>> +       /* Expect EAGAIN because there is no datagram and peer is closed. */
>> +       ASSERT_EQ(-1, n);
>> +       ASSERT_EQ(EAGAIN, errno);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> +
>> --
>> 2.43.0
>>
Thank you very much for the review and comments.

I will send v3 after you review the questions/clarifications I asked in 
my previous reply.
Apologies for the delay in responding.

Thanks again for the guidance and patience, really appreciate it.


