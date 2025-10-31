Return-Path: <linux-kselftest+bounces-44553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0FC26E2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1468D4E219C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3230DD01;
	Fri, 31 Oct 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DXP1uES5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic312-24.consmr.mail.gq1.yahoo.com (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1F309F01
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942145; cv=none; b=sH5bcjQtOCIT/97DcTRH4Z7dYct5eoduEsWAGyQkahYb1sjgW0NDdD0uRY5f+IPPpsUCqMXtJ1HesSSVM86u/VNZPWI8ndPXpCPdkt2BIH7kbb8jGX8DktrIxbrxPwHgKq1z/9HQOMBTpg6L2TPikfBbgJ5QA8GZEles6MB0neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942145; c=relaxed/simple;
	bh=zShKxfP0nVEMYim+rC7RNh4h8Uy6aeRNwb1snK7E9FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJWTz08POdOMtcvlL3H9PjApG93cTqTByAwBzmHkndCQMCuZzYPdMLuhYsAzp05hzr7hDHofaUKUbGOzGF1tVf0ynlbuYWgeCZfGn3s1C3mwIo+VRnkcIhja0WhPitgH+jYy570fsnY+l4FikU55qppoJWAlwtsgIEPb/EeWKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DXP1uES5; arc=none smtp.client-ip=98.137.69.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761942142; bh=BOJ5Jw7QZ2Hwk9e5yvlRJo3M6jwqiPaySJ51gXkIEA4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DXP1uES5yBVIPSvwNw7a5pl+R0z1wtiHhgPBFdgZf+YJqYBAGKgNXBysHEYulKpJiTof1VONU7sxhkaWS+tFVDHcy7SnkAXuxxr2+IRutmTlMku4kW15ZaVEENo3joAg0gjO/eH0cROF+pA8rU4luw16fzOCCkmTRwEwikmcDNQGxsTaM2/l7q3Rr2uEuqaJNvVzolsRlJvwgsRlXn2Ehgx3fFwdGFxYpKjHwyk2xy94//rnIl7296e1R5assxHwKL4tnbVhvR8hXO21/kF8DxjNQoGo4sTsXpLjjA2sSkMfJ6YZy2LrWne4OaleLWK3CGfv/MVMvLw9HZVfx1BxsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761942142; bh=dmO8A9Zc10xP0zxKVnuP6QUNit6TxDgmUSs4PLnOfG6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PHFBxgpMJ+/XI4YD2dE/tNJFBWrHm4yAZjZ+rVGZlnBLg4lRekenH2Qjf+yy2UkSkTrsq3M//YnctHRzJrzWknweS/YSUxgd3IwCneCPReQyfceegDmEqQB2X5NQR/6VpqRzYUxSNq2mcbDlKlHW+qejpkgKlmUPo2GyoFDpDCCFkIGeIstGh3jqbtlob42dsCkL4Iq5jX4bdePSZXyrsVETdYmND3aGoaqL1ikWlSZ2YYA/kKVBoO48f50agAra1DRetFZ6LZwZnsXlawHs1qWAZ1QO20yRsdJ9B8JsdgNivbHWKWBYuz33UiCAyzyk+lcP4Gq6yVtyr1QASt3zdw==
X-YMail-OSG: i5zodQ4VM1kZF8iwGb2vMiF.eay8FlyGapXXFu9sBOtutZnUc27RCNIt1yAbBPT
 eYJY4fXFg2tU06wW1Kzk1.EPVTGfl8Nf7DHjw3UrqEVQtjQx40Q3YsaVdrmCc61hUsOIABRcJtMT
 s9FB73Zz55X_Qn_C4SGpXAKrZcaPMwDQFzCWxEu4dJ27EAsc4UNQ2QLPGYQmMa5x0SWam5YjOAU6
 hwRA1zTkTHGv.TTT6Mm1vP2s9Szp4SJPW9Smwz3idbwvrB0WDfFus06o7JEeG5SAmrDt_xEI4wAd
 ei6D0Ym6JV.A8W__PJai890JQUvGraPj6VEkquHldVVge6FIHsYUOhFVU4sWN3rnN5ZEHbyfkqty
 mfkl0yYVwXwQYDOdZg8eAWpt.T7CMgHQcW2svAIYdzcKH3H3Hrb6OGgdjZ8O7VjYPB_J6C1ntvc6
 oJc7zZQzHZRlnHUlRZmAJrY7xGIuyQ8PYNWZRfPpiWLE.N.TkwfOsK9rr.2R0qQogaOC8V7hSneG
 gr93WUeF.dG8TxUQhZ1W6rV2b0HDb97qAYMTFobXoFySNYsylyTtdJR._UrEOwgyepWQLjOxwObw
 TROvUp69vhalCtdD1BCjHtR2LW5Jsv1.RjSSnorkErw8zOXy4v.oja5MtlR9T0OU3IVgUxDbFn3w
 5CPiPxFcB9HGMKJvRgm.M6w8iq07OFJlK_S0YEdev5Tbs4l0t88fkOek9Jw9Wyo46nqUZ9SqnPhN
 xA_lAe.BL.OvSjykC3uTtGJLab9XntTpMrUEK2330Tq5Eit5WjWxuktUX_lUJanb6.ILFVd3xjE3
 6dI2fnhFqyvvif.eT7zmr10kwuqidT6sE8NSyggts7jcOGbPOyZCj0IpeUImEwNO1pgQ5CeaFt0G
 smrNwJtqtP5IWtE3CM6c7DW8HR8c6wvhQ6cFbWNcZ9lpzl053lh2lOZ9OaRoRHjReHWYULnjKVgj
 mA3ZsIzB9Q3jneyWa4kKz8t9EZ.T56dbdtMD.ca2KVIb5B1rHWHT61qNCZ71A5hI95J661e.xUqb
 bZpfokGwpZdQvLqBlQMojrE5c8x.GFipmtboZHxZjFWo4VXg2Hv3r2Qr7EORTw_k_U_ZfV2vPtsC
 Fv7jYtp5GMHe5LL.oSnW6lSyoBIXSbI.seZJtBfZ6Ml_WQLHQeSV8rRufQZaBqHyHpJw7DHN3vTx
 lTpGgBAD7sK2jyaC9yTRpsUYROrV78OweE08YuUQkBPzmZIHFn3WSo_lFFnvThJriN_M26c9f8EU
 Sv.TYE.M9.Nugk7DwGzI1D7udctRkh3IkqWlwzUSyBX5IoBVsHuOfeVG0yimEPa2caYA2WKjaQ.M
 GtXvpZ9Y2mbUpzF26TxGog4llm9cYD2OOb4X.KbCFb_56mbSgpD34HMckU67Dt5dnZ9UhNbKbK_b
 x8BwMq8DpChmvg3Ay2TsnR8R1Vel2Ya8porV3BuOEzDHHyskEypjuaeRwQrQD57G8NziIXh.fnpR
 VekNsZ_FOFrryqCJnXFS2DjYKR337k6LPnW04hmeij7LbDtpP3lXiYawiP4l8lgPq7n3Cta01NCS
 uOgnpGyDllv6cjS_jUKeOLmhsiAQIXMeJAm2HzOZF9ZF7Jt0tiz7h6Oh15ZwV3EFVy0pz8LhNdkm
 W6NbURv5oS9QW8YSEUV.3hMzkoWZqLolGEqABiC17k3Gqe.gFi1GcJBxP0c1OSTSHWUQFFtMNEeK
 YiM2fdhl4bafUaggGx_VFtCr8G0hx3NAQ1smZosF_5wCoxcLqgoXxWTZMv89mb7SQL72QawEzk5U
 9HRgjcyWeN3bEPze6ll9p98VtsfQSvZftc7Wij_bozyWQjth_QiN0Ha.5kPPEz1QZGSgy5OTUZ2W
 KOIi9FFsRHNZAAky39q8F_yoY5Knsdmmh3xikNV0q0hS0bLzz9vRibzdl_a4WebMULZIMD.xrzKn
 fM3rsQ38Q0Muz3alVeVcytdrDwhgSUqbxBOhNlM70jz7xt4CUv36iLSgbn5CGz2qPGwIQPSaVDrj
 b2SAyCN.eZ9NiJfcZTC4lU92ltsl9n4bI1iV6ARRZ1ug2dZHtQ1ffO3lFL0Eto1Yur9YU14i57Ry
 bsXz5dTWnfJQMyN0FOA_6hf4ThW78gmDMXvLBEZ34tHqiNic0RaKNnF_cTtr9klYWWwQKeE7IPSX
 U6Az1mlwVowgUezrnRTyQVEv7Ul7HTvOUZfvnlQEUT0Uq4VCHKjVDk8MXbUMc0JJ0gVZ.WaNC0C_
 2IEUIE3gUgP6nBPsNtaHO1VxAxQrZ1cQH01wNQQJpFcp3UyRXfdB906n402KPL6FJFFtpv2R0hej
 LPJtxDjOeEthk
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 1aa3a47d-2071-4549-b0bb-ab07f69b22cc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 Oct 2025 20:22:22 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-72pzv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 047a24e14e331714b0dc96afdb1dc439;
          Fri, 31 Oct 2025 20:02:02 +0000 (UTC)
Message-ID: <939c78fc-ea90-4e5d-a9b1-e750dd6b4e25@yahoo.com>
Date: Fri, 31 Oct 2025 21:01:56 +0100
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
 <7c4070ed-1702-4288-90c6-7edb90468718@yahoo.com>
 <CAAVpQUAT8CVwQfSXq+P78kgPVy8gyD9thEgBcAz45Jpxh=1smw@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUAT8CVwQfSXq+P78kgPVy8gyD9thEgBcAz45Jpxh=1smw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/31/25 20:41, Kuniyuki Iwashima wrote:
> On Thu, Oct 30, 2025 at 6:45 AM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> On 10/28/25 19:28, Kuniyuki Iwashima wrote:
>>> On Sat, Oct 25, 2025 at 12:03 PM Sunday Adelodun
>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>> Add selftests to verify and document Linux’s intended behaviour for
>>>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>>>> The tests cover:
>>>>
>>>>     1. EOF returned when a SOCK_STREAM peer closes normally.
>>>>     2. ECONNRESET returned when a SOCK_STREAM peer closes with unread data.
>>>>     3. SOCK_DGRAM sockets not returning ECONNRESET on peer close.
>>>>
>>>> This follows up on review feedback suggesting a selftest to clarify
>>>> Linux’s semantics.
>>>>
>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>>>> ---
>>>> Changelog:
>>>>
>>>> Changes made from v1:
>>>>
>>>> - Patch prefix updated to selftest: af_unix:.
>>>>
>>>> - All mentions of “UNIX” changed to AF_UNIX.
>>>>
>>>> - Removed BSD references from comments.
>>>>
>>>> - Shared setup refactored using FIXTURE_VARIANT().
>>>>
>>>> - Cleanup moved to FIXTURE_TEARDOWN() to always run.
>>>>
>>>> - Tests consolidated to reduce duplication: EOF, ECONNRESET, SOCK_DGRAM peer close.
>>>>
>>>> - Corrected ASSERT usage and initialization style.
>>>>
>>>> - Makefile updated for new directory af_unix.
>>>>
>>>>    tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>>>    .../selftests/net/af_unix/unix_connreset.c    | 161 ++++++++++++++++++
>>>>    2 files changed, 162 insertions(+)
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
>>>>    # end of TEST_GEN_PROGS
>>>>
>>>>    include ../../lib.mk
>>>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>> new file mode 100644
>>>> index 000000000000..c65ec997d77d
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>> @@ -0,0 +1,161 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>>>> + *
>>>> + * This test verifies that:
>>>> + *  1. SOCK_STREAM sockets return EOF when peer closes normally.
>>>> + *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread data.
>>>> + *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes.
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
>>>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>>>> +       .socket_type = SOCK_STREAM,
>>>> +       .name = "SOCK_STREAM",
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>>>> +       .socket_type = SOCK_DGRAM,
>>>> +       .name = "SOCK_DGRAM",
>>>> +};
>>> Let's add coverage for SOCK_SEQPACKET,
>>> which needs listen() / connect() but other semantics
>>> are similar to SOCK_DGRAM.
>> I will add it through:
>> if (variant->socket_type == SOCK_STREAM ||
>>                  variant->socket_type == SOCK_SEQPACKET)
>>
>>
>> in both the setup and teardown fixtures with a little bit of modification
>>
>> where necessary (especially in the setup fixture).
>>
>> And also the fixture_variant_add macro.
>>
>>>> +
>>>> +FIXTURE_SETUP(unix_sock)
>>>> +{
>>>> +       struct sockaddr_un addr = {};
>>>> +       int err;
>>>> +
>>>> +       addr.sun_family = AF_UNIX;
>>>> +       strcpy(addr.sun_path, SOCK_PATH);
>>>> +
>>>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>>>> +       ASSERT_LT(-1, self->server);
>>>> +
>>>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>>>> +       ASSERT_EQ(0, err);
>>>> +
>>>> +       if (variant->socket_type == SOCK_STREAM) {
>>>> +               err = listen(self->server, 1);
>>>> +               ASSERT_EQ(0, err);
>>>> +
>>>> +               self->client = socket(AF_UNIX, SOCK_STREAM, 0);
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
>>>> +       if (variant->socket_type == SOCK_STREAM)
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
>>>> +       if (variant->socket_type != SOCK_STREAM)
>>>> +               SKIP(return, "This test only applies to SOCK_STREAM");
>>> Instead of skipping, let's define final ASSERT() results
>>> for each type.
>>>
>>> Same for other 2 tests.
>> can I use a switch statement in all the tests? say, for example
> switch() is completely fine, but I guess "if" will be shorter :)
I will go for if then.
>
>> test1:
>>
>> ...
>>
>> switch (variant->socket_type) {
>>
>> case SOCK_STREAM:
>>
>> case SOCK_SEQPACKET:
>>
>>           ASSERT_EQ(0, n);
> You need break; here.
Thank you. It was an omission
>
>> case SOCK_DGRAM:
>>
>>           ASSERT(-1, n);
>>
>>           ASSERT_EQ(EAGAIN, errno);
>>
>>           break;
> And also please make sure the compiler will not complain
> without default: depending on inherited build options.
I will look into this
>
>> }
>>
>> ...
>>
>> test2:
>>
>> ...
>>
>> switch (variant->socket_type) {
>>
>> case SOCK_STREAM:
>>
>> case SOCK_SEQPACKET:
>>
>>           ASSERT_EQ(-1, n);
>>
>>           ASSERT_EQ(ECONNRESET, errno);
>>
>>           break;
>>
>> case SOCK_DGRAM:
>>
>>           ASSERT(-1, n);
>>
>>           ASSERT_EQ(EAGAIN, errno);
>>
>>           break;
>>
>> }
>> ...
>>
>> test 3:
>>
>> ...
>>
>> switch (variant->socket_type) {
>>
>> case SOCK_STREAM:
>>
>> case SOCK_SEQPACKET:
>>
>>           ASSERT_EQ(-1, n);
>>
>>           ASSERT_EQ(ECONNRESET, errno);
>>
>>           break;
>>
>> case SOCK_DGRAM:
>>
>>           ASSERT(-1, n);
>>
>>           ASSERT_EQ(EAGAIN, errno);
>>
>>           break;
>>
>> }
>>
>> ...
>>
>> if not these, could you kindly shed more light to what you meant
>>
>>>
>>>> +
>>>> +       /* Peer closes normally */
>>>> +       close(self->child);
>>>> +
>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>>>> +       if (n == -1)
>>>> +               ASSERT_EQ(ECONNRESET, errno);
>>> ... otherwise, we don't see an error here
>>>
>>>> +
>>>> +       if (n != -1)
>>>> +               ASSERT_EQ(0, n);
>>> and this can be checked unconditionally.
>> did you mean I should remove the if (n != -1) ASSERT_EQ(0, n); part?
> If SOCK_DGRAM does not reuse this test, yes.
>
> The point is we do not want to miss future regression by
> preparing both if (n == -1) case and if  (n == 0) case, one
> of which should never happen at this point.
>
> Thanks!
>
Thank you for these.
I will work on them and send v3 shortly.

Thanks once again.


