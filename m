Return-Path: <linux-kselftest+bounces-45524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C64C568B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 10:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0C0E4E3716
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5329ACC6;
	Thu, 13 Nov 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="miZkR8ie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic315-8.consmr.mail.gq1.yahoo.com (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D51230BDF
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024942; cv=none; b=O9ZgCyNGc6EeYM4tCXHVa6TEwFPBOLoyv4radFNp8vAGtL/k3Gd8Ie1gXlq5/D1/ZAAQmkSD/MuDX2ORJAGbfgj104lfWUJNoWp7a4raeS3c2eKHkjbZCi5Z7ONnLY+t29u8d4eM9s59y/wv6JzlkVIFblLyroCKTjwQabW3D0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024942; c=relaxed/simple;
	bh=CwvV06c0j02ohPrWnmShptC6or4QZNgaNdyuGU45zpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3pRJPFeDBMBRjv9lW0Ve3wb4uHA6Ocdqv5dfHkIcZOfLLgtxGKLFeU4yDyHMI3A46OH05nO0FYHbS3eyympT/fS48AQYCGIx/izPvxyGgzpgw25ogslOIyEB2eJ9USOqyGegmmv06nM4qfFjvFVycB34tAdBdGga/MffPr3AxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=miZkR8ie; arc=none smtp.client-ip=98.137.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763024939; bh=MMknRcqQGM7el+Tdt6AzBBcCY6hjBX+ZqSYQZHHoMbM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=miZkR8ieFjOzi4aCKS+oTXZuj6CHcmUgKg/wMOIQm8a8glya7jefRzhwdxJnZzTG1ZTcHAyaFlvmYHEEOetwzPazNOCieDuiO30iZU5Q+DHFdq/s7A2XTEnGNVSqX58e6RHKntixVfDwJ+jtwbM2/XLSxu4H0VY7qB34/AnKO2o53mO1pEtYolC4efW2T7BDHjb0zQijiMlVaY1nNpgNjA4HuWlUT2m9epI5mNzakzjAM9M/pc/oQnhh3S+qWbcaoNRHBSgMxXVgWEo03Cl2GbP6DvD+7tqk0rPgH55p4++kxt7uRHQNKBnjaZFDEmLaASvodYEHgTllVllgJz0hhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763024939; bh=P2dHwo/jICi09YLwJjlpT6Tm3t0BAZ+WPScGryLaK58=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sNMlncDkiRdgJY+Mj3ZMdnvP8gjUbUz+rXzxpWt+ZnGQrbgkkermk88Qx1Ke+Wa4jKhEyhCKMPSzhHlSuYKyGnfj+P1k+1TXOYY5W6elsqurIzWZMenteBO2zSkMiSafcoBUPKjA2GXqBUEnSvATxXsA9J3eiVclRcydrnKX+9hPS8CtWivzGORpeXCFjkRkBDsOUEr2v4attM5GMKSM2HotgwJne4Po61Krhra4eqwsagG272mV2xc4U0OzceYFE0yIin1oteQNm+Xh3Rtk+Z6xoPxmtU43Ot3Ra1noGlUDS6oEBqjjkQhgNeaJsaf1I70KMPbdjvV2/t7eZeXeuA==
X-YMail-OSG: H3QI864VM1kjGBAIJ.lfiRLwJjx9DiZVbw67QVtfkaQ8w6P_UBT2yZpNbR23EQj
 9QoISeQZ4R3JZHkZWFcBZxAbhrNAy7T5K2PEAtp3CgLl.jnuqdJXoj5YhM70OAJ9oP.rXeyoTVGF
 Mmk2GVVWh6xpBIazDGCgwbczhvBlPvMkqLuRs9a7IxUvVdV9fZm7bLpacfZwuKnY_FhIrUlB_Avp
 jPuGa3n.D3J1XDO8rCPrJ.kGVOAIFH1xvS9YqaqNkJ9Roxyhb4HE1AiHMIdvYiK6uy6JsXH8q9Le
 1.EuUBNAIXqW86LYPBwXQEwk9Bs9nMxNpwnMTQWZgYDS3kXlv_Vwwm.EVJP9rDW3EEl7B0ufN63T
 5SzdnzTv7Xitm6VeA0pHUGAsUYlGxourIzehzih7NAOTwgg9rrre7cmZ8Kd2VtEzY6_40QcVvJ01
 dL2bg71vqfF.4QzRn5qlYNmyfJRKz6FTSiXo1kWWX6M9SSU7ZnyEJHLjLr6FmzJ.S2N8KjHwZU0t
 ajBmS9nk8M.mughghobnQbJKyf76OgMkqckyhIsDbyuhyeiH7n9RjBKPiprZ3w_KkR8aiFp9PdWE
 HA0ltt2sqUfsqxcWlVRr3LUb2e7AMguPRHFfb93U0rhYcbJQB4CPx9ezzviHa_3aIzWUx7HwjCA4
 .Cm4Tqpk_lDy.ncOmWtI7kTtJYbDcmJwxmUqJHRbtgHJCUmljGfQxi11PN7RtUYmh0W3JC_fJP0T
 9ezDZkoY_V1y3_58vsdWdQSSGU6xPFlu7n4WFCCstWT7giMsaEruoa3wej0F5mnl8GGGNXR.LZCl
 QF3xWdvT9l93TeeNovuUc2XZoxUV3wdHi55mM44Dwa22PJVlSzMwFH1JE21OVCk1glxwRPE7QEWm
 9g3EyVLrdpr0RjxwXxiXXn773gTUmoQaD4LcocXHMyaGeqKiQM6ttlxk.2G8mSJRo8MTzGZi8qYc
 zeni2NW06v_x_CGrl9aB.jOPn5kepAue319pM9isEZ5mAj7kUs3DcaWpQDis9_HaNA2NQ6e7eiNr
 fuO6Q.fdPonkjHGgnRYdDreZvAF8.kTw1z_XOX.78.fBSZQeq2dQOG70mTIcTPfYY4_N2SJNLrsr
 4oxPBgOtM0sKjSiHV3ImIwPSr4U7JZGBgx3A.o0oO9B3YF.lGPuET91.lbUPM_AyGMGxPFZ_kJAK
 LkSitBA7N7QgKzOCBuNe7Ym1KlWJw8kLfVh8fA6tPHFE8qb37DwCwvMAHxgbRqPc4LnN9Zttfckf
 29Gu0FHzuIo2swVQdAYswHLoLSB_WnbqSihz2liZp_RvWPpDCC6hqdqZlUhOhg6e6BNZ8Un5Nzyg
 vj1VNPsrtwKN163IrOt3mjLQmJFACVgv_xMFrLR1GYaMnIsMvjHirStceitOe6v8chJ0VJEMgU9O
 jQXeJR7fG1gZnBgpvN9UIq499h2n_jP32BGz4MNbILvG8TIFeomHPeqm2vSnglqfxNphYMA5eNzC
 WgQqaEOmjipSB4W_ZMnlZ4WEwFIpadCmt6GgfxTJg6hV4GUcYJw1WDLeUxEGQy8CJS08a4Gr1XzX
 8QvoShpTW4u6XiygwqlSXdhryLoZ4eDTZ6V6wUUD09nIYk9yTn9cChi9UDp4RMbNq69N8lxdEujb
 ztOKudXfpw4hhBDLPsifnfo5d2RfPhQmUA8BXtTb86XRY5zB_vBLIyxIKLzctQdc.cERXj33pC.2
 4pxDGy5MeDrfNqjfYIO8vFELVZK8aDDTQxuGenR3ZxzXIUj5DywwPFqJV1m2kJz_Hyv_lbsx0_Oz
 pgPUEHZEOIqTiTwyx9YBQPkskzDrHaezbtQORA169H847aoXRY2cqWUzYEdKOdfv91NyDTTGLHFA
 oCyxvMLAw2eCf_NOSkhDDJeSMj8e66xJ12dOjWJjyfDnIovCio0fXqySp5_ndUMEi_as3kYZXtfC
 favETqF2wuYsa1Ofn1.NHQ2ADXv9dH1L1tOH2hlZ95bU0Q3F51BKySxixzaYhZ2JFyeoOJA2KOPm
 cOA7yJQlt8eN01C3Pn43M_CXgEDrKpEVYk2yKXx8XG7eCG9if88HPKIQGvtPro2hgmW8zwUfB.ig
 CDRgWZt8Ucm9o9ioGcCGi4WiMZ5P0rxUw14WOFgvxP4fFz31mrkx1gFAGNuLPI_fKbcXwY5DX4ni
 9ZMRtUFbmQ9aTs7kjXEBvr85YYTzhLoj0NM4N0__gwpdBafc7GHhWQGtkvqVGq2lnNDdI3uSXZDH
 i.fuTDoG8ouA2z578d0eW4lOf64Faht7ABkI1imGdiorOjd2WUyDM7_cIqVGGri5LgkW8pPUc73U
 F7_gr8y.9vwR4KviA96mWpvI4tA--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: e4833e3d-7fdc-413d-aca0-8214303fc968
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 09:08:59 +0000
Received: by hermes--production-bf1-58477f5468-tllkx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d6fd48f5390c9041d0017d1e906ed9be;
          Thu, 13 Nov 2025 09:08:53 +0000 (UTC)
Message-ID: <216b2c7d-09eb-4d20-b8af-b8160ce14e32@yahoo.com>
Date: Thu, 13 Nov 2025 10:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251113071756.40118-1-adelodunolaoluwa.ref@yahoo.com>
 <20251113071756.40118-1-adelodunolaoluwa@yahoo.com>
 <CAAVpQUBvLN=sRVb8cbMngwm3o=KZkVOeCYdyi2p5sYjjZQU=HQ@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUBvLN=sRVb8cbMngwm3o=KZkVOeCYdyi2p5sYjjZQU=HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/13/25 09:43, Kuniyuki Iwashima wrote:
> On Wed, Nov 12, 2025 at 11:19 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> Add selftests to verify and document Linux’s intended behaviour for
>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>> The tests verify that:
>>
>>   1. SOCK_STREAM returns EOF when the peer closes normally.
>>   2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>>   3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>   4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>   5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>
>> This follows up on review feedback suggesting a selftest to clarify
>> Linux’s semantics.
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>> ---
>> Changelog:
>>
>> changes made in v4 to v5:
>> 1. Moved the send() call before the socket type check in Test 2 to ensure
>>     the unread data behavior is tested for SOCK_DGRAM as well.
>>
>> 2. Removed the misleading commend about accept() for clarity.
>>
>> 3. Applied indentation fixes for style consistency
>>     (alignment with open parenthesis).
>>
>> 4. Minor comment and formatting cleanups for clarity and adherence
>>     to kernel coding style.
>>
>>   tools/testing/selftests/net/.gitignore        |   1 +
>>   tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>   .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++++
>>   3 files changed, 180 insertions(+)
>>   create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>>
>> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
>> index 439101b518ee..e89a60581a13 100644
>> --- a/tools/testing/selftests/net/.gitignore
>> +++ b/tools/testing/selftests/net/.gitignore
>> @@ -65,3 +65,4 @@ udpgso
>>   udpgso_bench_rx
>>   udpgso_bench_tx
>>   unix_connect
>> +unix_connreset
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
>> index 000000000000..9cb0f48597eb
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>> @@ -0,0 +1,178 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>> + *
>> + * This test verifies:
>> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
>> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
>> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
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
>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>> +       .socket_type = SOCK_STREAM,
>> +       .name = "SOCK_STREAM",
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>> +       .socket_type = SOCK_DGRAM,
>> +       .name = "SOCK_DGRAM",
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
>> +       .socket_type = SOCK_SEQPACKET,
>> +       .name = "SOCK_SEQPACKET",
>> +};
>> +
>> +FIXTURE_SETUP(unix_sock)
>> +{
>> +       struct sockaddr_un addr = {};
>> +       int err;
>> +
>> +       addr.sun_family = AF_UNIX;
>> +       strcpy(addr.sun_path, SOCK_PATH);
>> +       remove_socket_file();
>> +
>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>> +       ASSERT_LT(-1, self->server);
>> +
>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>> +       ASSERT_EQ(0, err);
>> +
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +           variant->socket_type == SOCK_SEQPACKET) {
>> +               err = listen(self->server, 1);
>> +               ASSERT_EQ(0, err);
>> +       }
>> +
>> +       self->client = socket(AF_UNIX, variant->socket_type | SOCK_NONBLOCK, 0);
>> +       ASSERT_LT(-1, self->client);
>> +
>> +       err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>> +       ASSERT_EQ(0, err);
>> +}
>> +
>> +FIXTURE_TEARDOWN(unix_sock)
>> +{
>> +       if ((variant->socket_type == SOCK_STREAM ||
>> +            variant->socket_type == SOCK_SEQPACKET) & self->child > 0)
> Sorry for missing this one, but NIPA caught this.
No problem, that was my oversight.

I added it because, in the third test, no child (no accept()) is 
created, so I wanted to avoid closing something that doesn’t exist.

Looks like I was just being a bit overcautious.
> see: https://netdev.bots.linux.dev/static/nipa/1022816/14311938/build_tools/stderr
>
> +unix_connreset.c: In function ‘unix_sock_teardown’:
> +unix_connreset.c:92:68: warning: suggest parentheses around
> comparison in operand of ‘&’ [-Wparentheses]
> +   92 |              variant->socket_type == SOCK_SEQPACKET) & self->child > 0)
> +      |                                                        ~~~~~~~~~~~~^~~
>
> I think you can simply remove the "& self->child >0" part
> because you don't check that for self->server below anyway.
>
> Thanks
I will remove it and send v6 right away.
Thank you.
>
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
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +           variant->socket_type == SOCK_SEQPACKET) {
>> +               self->child = accept(self->server, NULL, NULL);
>> +               ASSERT_LT(-1, self->child);
>> +
>> +               close(self->child);
>> +       } else {
>> +               close(self->server);
>> +       }
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +           variant->socket_type == SOCK_SEQPACKET) {
>> +               ASSERT_EQ(0, n);
>> +       } else {
>> +               ASSERT_EQ(-1, n);
>> +               ASSERT_EQ(EAGAIN, errno);
>> +       }
>> +}
>> +
>> +/* Test 2: peer closes with unread data */
>> +TEST_F(unix_sock, reset_unread_behavior)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       /* Send data that will remain unread */
>> +       send(self->client, "hello", 5, 0);
>> +
>> +       if (variant->socket_type == SOCK_DGRAM) {
>> +               /* No real connection, just close the server */
>> +               close(self->server);
>> +       } else {
>> +               /* Accept client connection */
>> +               self->child = accept(self->server, NULL, NULL);
>> +               ASSERT_LT(-1, self->child);
>> +
>> +               /* Peer closes before client reads */
>> +               close(self->child);
>> +       }
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       ASSERT_EQ(-1, n);
>> +
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +           variant->socket_type == SOCK_SEQPACKET) {
>> +               ASSERT_EQ(ECONNRESET, errno);
>> +       } else {
>> +               ASSERT_EQ(EAGAIN, errno);
>> +       }
>> +}
>> +
>> +/* Test 3: closing unaccepted (embryo) server socket should reset client. */
>> +TEST_F(unix_sock, reset_closed_embryo)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       if (variant->socket_type == SOCK_DGRAM)
>> +               SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");
>> +
>> +       /* Close server without accept()ing */
>> +       close(self->server);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +
>> +       ASSERT_EQ(-1, n);
>> +       ASSERT_EQ(ECONNRESET, errno);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> +
>> --
>> 2.43.0
>>


