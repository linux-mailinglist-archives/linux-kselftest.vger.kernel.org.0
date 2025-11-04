Return-Path: <linux-kselftest+bounces-44686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C355C2E918
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 01:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358E13B2C28
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 00:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D229405;
	Tue,  4 Nov 2025 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qtpWplIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic314-20.consmr.mail.gq1.yahoo.com (sonic314-20.consmr.mail.gq1.yahoo.com [98.137.69.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91F45C0B
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215547; cv=none; b=IcJP0cYTdbu9iY/M+pN1GYuyk/bnkyHMTUAi4ErsVt1jBO0TJR9BpISvZ90z3ZIIethh6sOFrmpcNm9nagdqXkwPt+P6GlB0BhLR+yHMPvRhv+ydcNw7Ty/eOJTAGTMalOY3HSXJDcmNmqyrsKT1zKegHq/zglAxihTJk/ypmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215547; c=relaxed/simple;
	bh=CSy4MCBCDgb9fcvKRUTt7pLCtBnvGK72b9vwibFXUBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu9VQokv3GSD7tINOGLrpaWYTNZbSHXCeA4xNEQBTX0otv9ZPGC/i3xmI41k5rIIcr31QD8THuLxXgjulUDJxkeSlSdfv9bia2oPkbd46BgbCnGU0541QrEqvzBn14McnJ3o2lBrubR5lG12Lms5MMksvCCyNdv142fvIBatW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qtpWplIr; arc=none smtp.client-ip=98.137.69.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762215539; bh=oaiUcUp5Hsi9n0Ln3TIg1v2DZX1b7caGKy5J5pPVByY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qtpWplIrEfGIumpgIXsRnRBUrOjjyIgpqk48zPwhCT7aYsB2Uea73IGuFTJe+ZIz/lCckXH4zQhG0bnzrSY8k3EBa2Pkqd0BberIlNVeaUtRe7cN+o+iwtLzsKrt4uEGxzEnPiBmL2LcNIq6ZKHLu+UYvo9+Q85lq4YkF6LfrNXdBeRlKTVsHuJAcCZdx1N1Pk6jRrOPI4u/lW/G43DPkicvAl0Zu33AEwadMBsOVwUNUsDWXkt1J/4aLlTg/Lm2oUiY+27JBXqC7xDMmD6loCiiOhU7OoY/Q0VNfFwI9/qR7o187q/3sbF6kcSoPAIRSVTe4L7gWAUvNW0+EsGqtA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762215539; bh=hut5iB1Q68x4khA7l1WtA3kN3SMiL4zeFK16NRXAJx8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JUPyAlyvEmud0W/Rc2uGkpp+5edZdV9bHTdJTwMwmOBUMq9A6bMpAbbaMiVDICK9TZPfDQO1rtgaCL2eatn0z5x7tCk9lxBuHb/EgvIyO9IKJW+UvhU+lySq8dd+9n+Ie8+Jkv9GXP+1sBXiTUe5IHJB7LfUPNmvABmtBfMk2PaGZY7SNN8ANp28k7jeY/2QEvt9n94DDMSCGPjKy64RN8ZHU44mevSZ5Aa9MFie2vcC3l9BImcq9gC3Pt8G49cOc7+97pzUpyv2GyEtQiEpj5pNyByGLngiPZjWNTZYNkID0y5WMhTngUdT4rB46c946vaE2OJjwE9YbzV1IXhp1Q==
X-YMail-OSG: WZa_aNMVM1lLuzCHRR24nt36LWjfpCEArEKZQ8O8qEWkJnjlYfyPMYFbGTigfTt
 L7LCK6dpnNk.mgRowWwQ.FT0COj5KX54XKkeo3Hx8_5lhr24RsKulvJ_DDkqUjKL6sFE35Vvr_Jo
 c1J6HLCmsl6Oszqy4kO42kSeoBZS4FmHxQIy1GR88YCKbJNwiK8kSFsL6Px_QqUV1dox1OrxqBJL
 qu_jOkUC095O1JaF5YNZNxj1ry5Vnej9G0JDsqRYGwC9pnwu8TBTtUtnfjR9DjCsVVLskGnMqFE6
 nUhc99NRA8MoiWFxPJG.T3Uds_iJ0OfSurzveSkq759JSF2R0xbtTmzE.GUsaIb1Q9Cjb027g6Xm
 KIby9JoW83oeLLT0ixbobszxqgiQMzJoAFC77BbXwAxPiZLvJzbpy0tbOmObLJT74JpnGd9bQ476
 KVatrcYnb8kHnz8gmXi0wI_710gJniTtPpNH1s6UGAJ4jubZJs8FKrtHp.5hyBaB6b_qMIQRQWXx
 ryMeQYW4YmuKU0f4ktKcmUCZbhLxnyXzW.6PZgwLrCF4aeeOoy402.1GsOn_8iUDToaIxBMcyMf4
 jPujCnmNQLi2MQjNqoFsHwxfvobhD5z9xr3wuuOatHxygnuHOx9ePATFyqp7c_y03a8ZOqfMbpLD
 3nV1ABfud4XEUpuop7VUafi58A0Lu6JyvD0CK_Wcwe6DCQcUENMSsLvF7LVqIZQhsR1qEwzUUtrz
 pOn7lRpKBjKqt2EvWGklued9KbPrtikaz7W4iUtLWVoLnz8MxJH39goX6SpR.k4Ntzniplg6nluO
 9HN7I89jwauy2PB4.BIZxeIJMEcZmINHXOI4OQ01BQnTEWpb8e7FjvJtb7tIu88LTLjyiiC__mCl
 dG5_pBPC7tJLkWdG8z.qjahDueHHoZ4GEYSONldNFAmSMrQ041ER0Eq0CNBn7zpCyLIGxQ5Z3G.T
 17NDsHLCDU4gSoyaKHZC9.DzVO1GW3QNdWVp3eDelWOEIea7ihbNl7epAtKOZ1uz577Io7BsFwQE
 vUW_Nufl0XG_QJkMUvO5kWyolz.X86QWkUWesy_gzpld6vtnzzkFaVDPOYddfJC1_39ZVi1bnqDR
 ElBd8WWddUgEuKFfR6_C5rNBroWIFnSItZxSTRI4XZu8t4b_daWxSWwaMk1RhfVr03wMzPpahYRP
 7tfEJrU6TtSNctFmr8mOFJX5TAm9.Yc_qs8KhYN7pnUVRTcU7He7tOX7hIhpdZX31EFTway7sP8E
 cEsmeLMMARaSAGgN6ooCfjyuRNls9xV2QZBayT5X3UoNu6uG9z_4jC5GghDpypl2vLLx.x2nFX5D
 3jqkQPRmrT1EJ078K1jwBOXSFWAlu_qvde0SKApy6s5L.Rb.pG5URLtXbYQ51HJIi_CGks1reWjd
 rytwRPwuQTVYqY4jfIqQE7iUSYYeYaquido8So3Yq97YXW1dAwVfRVKdVQuJFBD1_obsSi4LoZKs
 G_RCMKYCVIQRafJ9tU9sOkYGz9bl7mNM4mMDekHqfk0aDVX16XT3G4D7K3I1kAZBo.R.txjsdAV_
 gzZSGn_4aJiU_Iwkvc_OfC1cQ5syRg5Fx2Skrr3TGrCSGuOShPa8UA2k9VQ6rzFWumLWVdilU8ZX
 Rp2.il.htr647R9FVmJ3GGuIFQg3iLvxEU0NIoGAkye1cIe5z_IUKQ5PJ6NQZcJcYu6O6gcN27Fr
 C.lhlHtlVUV5fcImHOR2xv3OjUAvL6trxNAanY2tuHAQe9bhCAWlJTQ00blDUr4dSkPhQjKB5SrN
 KR8cimfQIv1GmDYypN2YokBhe7KwA4VCnasKS9WdkQeu2yACwjGFcNmD0ypys5DpW5.6P68VndHO
 S7WSCbRrJmmEylIKowJfmyARDe4iCF4Myavy29RBdt6t7aYSvgNxw2g_Aj1UzpyLapozOwZHT1AK
 Mc0FgtRvK_uaBYO6YuGRHRa9wuM_ZQWq9DvMknfwdeotl5GLzIljTCusWCNtVnyxon13L57tIM6A
 FmofW0IMal9k.RsZnT0I4UoSUxbukUp72u88EvSjlm6N._Web2S8gp3pOE4gLv6LIneTYhbUPURk
 TTd4bxgjjz98h4nSllp7B0NqWAYdQTUrsqitmQyZdFBc48_yWuMVOqZX.uUNtpZfFfH0ht1m6P.p
 wtXPakW_vHWLLVwFsU5c0hqGXMu_.UV4hz6ZY0m82rmJTIK.3uBoBJJIS1VAGANzdQPugU9YP0bP
 Swz.u5XlacqXfJ.VMKU1CM6NUViuSeklB1UegmKlHpQMGEbg0UwreVvBvfJ1gG07lN1hTeKssMv2
 hZjVsFxnBugHpWoxZ2g--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 116530db-d01c-4738-89fb-a7218f6444b8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Nov 2025 00:18:59 +0000
Received: by hermes--production-bf1-58477f5468-2sh44 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cfe9c5061b0e7e39df76b5fb6784a85a;
          Tue, 04 Nov 2025 00:08:51 +0000 (UTC)
Message-ID: <7a162b38-3ff8-4f97-aac3-4fe2ab50fe33@yahoo.com>
Date: Tue, 4 Nov 2025 01:08:42 +0100
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
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUDL1FB1nFYOZ6QuO+cGTqnpYNSaFtFD=YN742pyspe9ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/2/25 08:32, Kuniyuki Iwashima wrote:
> On Sat, Nov 1, 2025 at 10:23 AM Sunday Adelodun
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
>>   tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>   .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++++
>>   2 files changed, 180 insertions(+)
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
> patchwork caught this test is not added to .gitignore.
> https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.10179-1-adelodunolaoluwa@yahoo.com/
>
> Could you add it to this file ?
>
> tools/testing/selftests/net/.gitignore
Oh, thank you for this. will add it
>
>
>>   # end of TEST_GEN_PROGS
>>
>>   include ../../lib.mk
>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>> new file mode 100644
>> index 000000000000..6f43435d96e2
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>> @@ -0,0 +1,179 @@
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
>> +/* Define variants: stream and datagram */
> nit: outdated, maybe simply remove ?
oh..skipped me.
will do so.
>
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
>> +               variant->socket_type == SOCK_SEQPACKET) {
> patchwork caught mis-alignment here and other places.
>
> I'm using this for emacs, and other editors will have a similar config.
>
> (setq-default c-default-style "linux")
>
> You can check if lines are aligned properly by
>
> $ git show --format=email | ./scripts/checkpatch.pl
>
>
>> +               err = listen(self->server, 1);
>> +               ASSERT_EQ(0, err);
>> +
>> +               self->client = socket(AF_UNIX, variant->socket_type, 0);
> Could you add SOCK_NONBLOCK here too ?
This is noted
>
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
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +               variant->socket_type == SOCK_SEQPACKET)
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
>> +       /* Peer closes normally */
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +               variant->socket_type == SOCK_SEQPACKET)
>> +               close(self->child);
>> +       else
>> +               close(self->server);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
> errno is undefined if not set, and same for strerror(errno).
>
> Also, if ASSERT_XXX() below fails, the same information
> (test case, errno) is logged.  So, TH_LOG() seems unnecessary.
>
> Maybe try modifying the condition below and see how the
> assertion is logged.
Oh..thank you. Didn't it through that way.
I understand.
I will remove the TH_LOG()'s
>
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +               variant->socket_type == SOCK_SEQPACKET) {
>> +               ASSERT_EQ(0, n);
>> +       } else {
>> +               ASSERT_EQ(-1, n);
>> +               ASSERT_EQ(EAGAIN, errno);
>> +       }
>> +}
>> +
>> +/* Test 2: peer closes with unread data */
>> +TEST_F(unix_sock, reset_unread)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       /* Send data that will remain unread by client */
>> +       send(self->client, "hello", 5, 0);
>> +       close(self->child);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +               variant->socket_type == SOCK_SEQPACKET) {
>> +               ASSERT_EQ(-1, n);
>> +               ASSERT_EQ(ECONNRESET, errno);
>> +       } else {
>> +               ASSERT_EQ(-1, n);
>> +               ASSERT_EQ(EAGAIN, errno);
>> +       }
>> +}
>> +
>> +/* Test 3: SOCK_DGRAM peer close */
>> Now Test 2 and Test 3 look identical ;)

seems so, but the only difference is:

close(self->child); is used in Test 2, while
close(self->server); is used in Test 3.
Maybe I should find a way to collapse Tests 2 and 3 (if statement might 
work)

I am just afraid the tests to run will reduce to 6 from 9 and we will have 6
cases passed as against 7 as before.

What do you think?

>> Thanks!
>>
>> +TEST_F(unix_sock, dgram_reset)
>> +{
>> +       char buf[16] = {};
>> +       ssize_t n;
>> +
>> +       send(self->client, "hello", 5, 0);
>> +       close(self->server);
>> +
>> +       n = recv(self->client, buf, sizeof(buf), 0);
>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>> +       if (variant->socket_type == SOCK_STREAM ||
>> +               variant->socket_type == SOCK_SEQPACKET) {
>> +               ASSERT_EQ(-1, n);
>> +               ASSERT_EQ(ECONNRESET, errno);
>> +       } else {
>> +               ASSERT_EQ(-1, n);
>> +               ASSERT_EQ(EAGAIN, errno);
>> +       }
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> +
>> --
>> 2.43.0
>>


