Return-Path: <linux-kselftest+bounces-45511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E6C55D6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 06:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5820734BAB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10A735959;
	Thu, 13 Nov 2025 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fdRBel4l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic301-20.consmr.mail.gq1.yahoo.com (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310035CBC7
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763012736; cv=none; b=dZbE8OTbizFXKrp0hYvGJ/gx6uoch/cVccT+UXaQ0seWN5JYpdGBq129DZ6jeIlpDCc/f9gw9yDb23wz2qvThEeiv4tFrkiK/wCPbQ82muw6G5lrPY6WWN/lqHuLYixBYswkk27yDiRdicOOnZWMBlu/9zBkHzTcWT8zUZO35Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763012736; c=relaxed/simple;
	bh=ellQoDe0zn9Mzc8Rt1N6Pl1byXtrra1NBPBq1BPme1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnRbUrnE817l/wfll4jSpDk8bb0yyUXkJP1YNHWiERBiQ9XHW7/tFl+NCrcZuFRfsPZMRbAf21R6ksPGq4hCKx29Wwo47CMth2PPEWbwxD1a0pXWsxgrJzvGU3qVgjPLSex8DfQkmosp5vfo3QMfpXcFkpDJTGcR51Vvvyf0A0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fdRBel4l; arc=none smtp.client-ip=98.137.64.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763012734; bh=pqHHx0xRioM927rk6Amyk4pKg0mdmT6T3XiJuBhI2I0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fdRBel4lS6fogJaTbkaMvSZjPBagcgisixOLqoRcDkq7uuqJ2MzovIRMe7U++uDswgtclMql7TmzixY49vmRsmNJk92TWiSEbeMcrMqTwBjm9vYjCsvO08esVeo3+Hnc46ay1lY8sVJX0iWInrvmMEIg3akpWHjfg5DbG2XIFPcSHZBOCQ6zcRQFAkjmXleoh97rTgixEDscTg9DyNAyt1uu6x2S0afzk4KLp2BvxaKfm8AAU/Zra696iW+I4KlF887m/CPILoCn60pIEkjbSbvUTnz6yn+0FZyTuYme2WJ0IbgGGQswotcVrs+wIeUfixHwUTsiQqbEz1DxXTfkkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763012734; bh=VkzTpGTXvzSZwcCypPl9tMSVmdIv4h+0c5SBlcbtcpv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZxetmrBICcY/wp2kNXZCQ99W0cLSaCXoef/igwIkgfkdpE+T5x9Z7/Mx16sXAt/kMK8mP5ow0lS9pK61PPoNSFnondMmpnRy+HX/HhUNfUEEGCMs9CBjMylLNmQEfdSCSPjTydS+ApHWR5EWgDaOCrQPLBKtkb8S11jm+ojdKjvGgLrjJeXJZ6wnC6ZSOvlFeXOBQ1TUNmVVWz1Tyr1IyxMyAd+xkdhEwBE9Ah74jT1Mf+QoDw2QrEVcHgfkKdpnrnwi91+SYlTOP9D3UhVcH8O5XRLg2o07EkZJeYX6IT0FuH6/IGAS2OIPDYOfyWTuIsfohM2VkqS/ziaQZYWkNQ==
X-YMail-OSG: b2whGB8VM1nQmdWEy9lRs24Md5_HNx0J5QHa_NWUcwVLKDtJgAd3tNQySpaTmV6
 XQx9Ok9x.g4laRWO1VsdVYIVKIsfEVm.u.6IhrINwKL8pMIwtWFRmC.h0TvcsVEJifhRNrxDIJFw
 GowaO2QTZZ0FVV7oB1oFsZ9X6SEZbsJ_B.2C2XKzvqQszNU7r_GC1TCiI9.pSjDO0VJzGP_AujTT
 LmPju4DLSrRNu42GzucOYqwO.Z50sqc2O5tIO6CNEw6YJaqfBB6tokJOeH6BKGUBTtewqJe7p1ri
 uPrJEQuC_7NeBFTwh2f0PL7kDKOugFeNMIKAHdLwi.9cdGTusaHEXg44.ogYU1R_WzB4XL8fEl37
 yFUrsKEJ6lMQAxOqUX8L8A1OZdp5hfVa_KSHpXxliHzIZCFXkXHeBkOXelrZcH2FgASsgy_jvnZ0
 6fWpapuVi0BYladhtarMODTuhi_REfyu3WOP9uIkso6CZTMvgzlQStatniJX1GLA4rT8QAa8dgvT
 er9MMZfGNx4GNIwnSs7WNVLPaNNZfb1tHN.bMjG3NgtmCplIPNsRNUBaieI0S_exQJfwgSE29M5Q
 cuXTAUER2JTFP201m3haGG4IJllnV2DE216u4yeC8l5U2dRhcXIYZLpIBhZckuqnDM6RUAttjuhc
 WhO3SgimV279gIXsCBvb4dhsb516QAxxnElbYydjiW5ZwpTXe_XCZ.OYBdklwmr9xW5gwg0UDBSv
 Tp.gwkoIB1J0MKp1JN_i65yAxa59kTNgQfk5fEDxI39bJDULa8wt6P_EEKPlThl7K4a_lnKHp7Kx
 NuDWBXZXSPL6rVq.pf2hLevkLTQAqQQ7yDiPlZ_Oa8rFGJ_smCcPJuuka84v8Y9i4lo16pY_b5W7
 WS0GOnPrUCLwjyNnjDON8uRodbwQH4DTQ8.jWBwcSGDoMfwYaOfKdoN19TeQL3uNiS_BpbUE0ZsF
 hNzjDd1KCUS57aTdG878h2P_hoXAtaQs1Ur.qbFy1YnVkIiqiQwDxeSEMoYclfXZilsvntUrGBt4
 Tqah2hztT3Y43_9n.l4hmnqY0SrZkZk1dLh6pnaOk5kfkr7fNIeSHbq.45w1xkXGKn.FFpFNkkzT
 6.Dp687L2Bu9ZqNa5d2df2Cf1Wxim1dAuH6_hBnUAjvEzU2I7WB5IbBnWEZpEwv3RRe4gN.HUQQs
 FzwV6fnXaxrtGMKpvj_xn.L8DU6nyQ5KgTld9LcvfTFnw.QPVzRvZPzlnpTp7MP8_MFughPG9cEl
 xwk_Wllvg8X25toV9FWZryJoQD_2mx6Q2F6h4Vw9_vhRdyG5pjz4pnO8DejvYribBXPayOgEtWhM
 BLxb7fWN7djgtLu7G3NdTXrcXQmQ3f5..34f6lx8YCcqFyjf9VT8RZtn7TNa7TZ1N.YDhXS.73bg
 mSczSGHwZKnz77mtlpW2F4_OEZrW9efHiqBKNgnioeHyk2_u5rCWMpxglLbfdaVn6tNLw6jh8Elg
 b.LWWhhfMh_J5SefR1NTsr10Bvc0uvrTS3rie8gGbJaxIpWkEn2xnACxRRw904SQdmkVu0Zq_iQV
 hBzqMnMwoHfoDzok32gkqA9toqdIgKtPP_FAvVuHdY1ziODbjD3DPWc.6bRUMVCTZk89dsppjSF4
 4n545kOBefVt7uv7qg3Nmp77YftbZdoJN5kyffUlig6gRMoiMZckRSySRbTitkt8LIFuh4MCvItw
 2ax5ej0cKqy872B2yWU0U6Qxr2GI_LXE2TNVNFb_yT5fyFWxUwyonSA4sasIcdxr09vJkT8UuwGR
 cHA2q6QOv5kaWzWcpFtcOJWxX3Kvq_O_eNa0val8RvVqBJhbbB_GXrl8JelO715YrfhcxqG9sxr9
 hs7BW3_47ZiEnNHfkID5hxwkdc.9EdtD2.oYYrZCA1s5oQPEpCyYlse0twMT1iJeWGbo5ZCxUawV
 vDuAHfUsJs5RegrKecwdJuGxKIugMAyqlM0Wv0LPhrZZFDZAmppwlmDUJSlTYUdVeZ4oA89ljtGE
 s7aOnL6mhK5fUx6BWKGWnsmFXYIPaXKDbqlj3G8WNDSpC4cmRm3kC5_kfr1FOViUNRaFHVg4WABA
 2sImY9Q7Npv8wd1n9NjzXZ7Qd4u.v7EQ4YzfW8nPk_zgnLHOOw2vxs8GkX7NYSySDo8CVvgocYaL
 61JbHd_s0DRZDb9XmjH3w3L0DpdN6LyNtcyHIEfQLG43ebO8CXygjmGypoMQjvQq8iYW7LQfuL.O
 CRHTR9LN9OG0KpZsDFvhZRrAd_QwlTzF70_JcMthQxcTWSzLyWMk14oKvefjq0KDGNPvV_lLs.Ko
 wYfhn7_ZBU9VNTVzyWjSU
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: e30db744-ed34-4199-aaf8-969ff9ff8f6c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 05:45:34 +0000
Received: by hermes--production-bf1-58477f5468-tllkx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c1e756a13efb6df5979ca63cecc158f4;
          Thu, 13 Nov 2025 05:25:18 +0000 (UTC)
Message-ID: <295e5440-94eb-447f-b4f0-4943e9d02f1c@yahoo.com>
Date: Thu, 13 Nov 2025 06:24:02 +0100
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
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUB97EBnTbA9pKwdhPM0pHadiM3QhP4_1qLSKGg2LAwzkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/12/25 23:04, Kuniyuki Iwashima wrote:
> On Wed, Nov 12, 2025 at 1:20 PM Sunday Adelodun
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
>> index 000000000000..9413f8a0814f
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
>> +       if (variant->socket_type == SOCK_DGRAM) {
>> +               /* No real connection, just close the server */
>> +               close(self->server);
>> +       } else {
>> +               /* Establish full connection first */
>> +               self->child = accept(self->server, NULL, NULL);
>> +               ASSERT_LT(-1, self->child);
>> +
>> +               /* Send data that will remain unread */
>> +               send(self->client, "hello", 5, 0);
> Could you move this send() before "if (...)" because we want
> to test unread_data behaviour for SOCK_DGRAM too ?
>
> Otherwise looks good, so with that fixed:
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks!
Thank you for the prompt response.
I thought of putting the send before the if the statement , but I was afraid
STREAM and SEQPACKET connections won't be accepted before data sending.

I will start working on v5.

That part will look like this now:
/* Test 2: peer closes with unread data */
TEST_F(unix_sock, reset_unread_behavior)
{
         char buf[16] = {};
         ssize_t n;

*/* Send data that will remain unread */
         send(self->client, "hello", 5, 0);*

*if (variant->socket_type == SOCK_DGRAM) {
                 /* No real connection, just close the server */
                 close(self->server);
         } else {
                 /* Establish full connection first */
                 self->child = accept(self->server, NULL, NULL);
                 ASSERT_LT(-1, self->child);

                 /* Peer closes before client reads */
                 close(self->child);
         }*

         n = recv(self->client, buf, sizeof(buf), 0);
         ASSERT_EQ(-1, n);

         if (variant->socket_type == SOCK_STREAM ||
             variant->socket_type == SOCK_SEQPACKET) {
                 ASSERT_EQ(ECONNRESET, errno);
         } else {
                 ASSERT_EQ(EAGAIN, errno);
         }
}

Thank you once again.
>
>
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


