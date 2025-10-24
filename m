Return-Path: <linux-kselftest+bounces-43972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A282C05569
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A7C1B847BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5E30AD1C;
	Fri, 24 Oct 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MjC+EVsS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic310-20.consmr.mail.gq1.yahoo.com (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E12309F1D
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298121; cv=none; b=X8QUr9qx5sFUR8C4NKlshyO9/Z8K8NkeKi47Zx10ERk1vfntkf4Cy+Qfu4hpXD1/K3KuGguRyczBv2eks5mUGWjmEZUiqzGiwdZ854ucd0byUoVaJa+TGGrw1E16rv+BeuAF6bguT6QLo28NZsL8Uu3otZy17GZYMH5IZHs/yLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298121; c=relaxed/simple;
	bh=Rlofpw0zV1YlVnOwvVHonOOAx/aZ0PQrSDVUelnGe1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji139JUmFtL7EBflLUbCWWUrrJbL+qi7OgW466xFG7VoNGFmIiW6dVd3ddqtmpp0Yw65FJK0YHDzv1kCDTRYB8/vOsXAMDw05/FB1C7+y/oCnWN+JX5S/2jDK/DdkIRw45fz07QzuPov4b2KyzMzAKNycc9NiicoBuGXLijMopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MjC+EVsS; arc=none smtp.client-ip=98.137.69.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761298113; bh=OHbParr5JEMdj7/NtgXk6RTxg3ZbMwcB2YmkwopRKN8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MjC+EVsSfhMBVrj9oU+p0rpN47x2qxSQq0roKCGirxEl1sMBwjcBEekI4Tk4VwJKOcUONioH9YkJQNALJLF/fjuFLd5XaCPG8o7RWy0hEWNCRWKSb9A/f2H6pQgT7kXxBEk/bL+2RlVL/1xZjja0PFY0LVYn8k5NTiY7oK5Ig4dQcnWomMquutnRV3b0CNV97Rxw/4A+CD6RLtlCLOED/oWDbPjEv/9q1z9fJ5AKpZZ+n/3A4J5GcoqbII2rq7mJr4+dFOcU2YwRKPNc8yEe0wSrRCFSParQp6WFdVb1mvEtcD2VGA1NtaDP2QGDirkOXbvrvR3lgWDRHjnXhD8fIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761298113; bh=0v/vTnybXE+BifGxsLvnoUVGUgTV3oxSYBKAhfXLgYn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ujmY4E4hCSJYbQG8Pf4Ma2T/P5FAsJ0LI+ca0S1WRRa2F3oawbEfU2g/Z3nx2oSxfX+DzvTeKK1erPQeTERbhg7sjBiyYb72xZVXSFCJhnTrF2AdLCgrGrYjY4afLqDG4mWe1wqIgo+TgHOC7jUw9HaYtkcfyyN+h1YAD0m5Mcaea5kreAd9Er9U189xUFwznB+8KbGddf514CReTefYJ8KH7V43C7D1D4v99559Sv1FzIMfyyXySN0nqROhSdAHQpdUiljJy0qfseM5Hrn/PzgkrPmmYQ5xtDYW9KksoytNCqo+TAy+/u2q0niu+184ivITWo4Sfbw5bPo2dd+Ipw==
X-YMail-OSG: UV66zLoVM1nCSaBmJ94PX85NWMJGpjvFqWJV4YdfwfzZlqYDuzct_a51FCEKIF1
 fAja7l2ayZ0P6h5gCoR.wbloSWXr4qem_BXDbMtYj1i8qWDlTmLQXDl37QVRu1Ih.VV48S9Zz7sI
 vIb0gfxfvxyCR76HaOcEv6ee8p_Qa5zX3N1p1dGkYB7.vzxWMwS_WeFUdK.vJQ2JHMq27V5ueH0c
 6EycFRXE3BbDzZf2JFV_MWxFln5sUnV4YGj52pPO.I0O7kNpr2nfRYmcvcx4a1EH814zlu4qH9pY
 x_7q56UYGjGTQeS3Q_xtMqEBPkCGnHl1sjqTBJBp40pciT3kK7HTieB0zKTV8iYthRmMNTEOCF2j
 pvvztFpLtFEZm.BoFE0feB9bgvwEixor_hkP_vtfzkWQ_ZNkD9NyIe764J8DNcPZiWk97xtofIdd
 WGyymAgRjyhyxzVf0RWgbypmTVOj4j1uOPpQB74PRiPAIqCvB5FWLbWo9zIA0V_Dv4RL1E98LEv3
 h5CEFQTvHT62.kI_OWGUXr29El5RFQKt44YF2zcduWw45X4OzLFnZe1kk_i5mfEIPpC5OBLZHp28
 73JRefR3kkZMhFkB4Px9Njt2YhnWRDVGpgYvRKrgjInsERAjjl3bV8qsD5Cnpb8CWZXAprGvcbza
 48PBwWLqtoY6rKHbUYfM5Mcfj.abjYe1AdbbF0LmbrzpttIq9fcTYexYp_GHHoXb6oDXxoGnepmX
 HIYfRPI9q5txREAIlVNkz3F6NiCGWyqfEpI9CKFu5PDDj5D4VleSPNZRMpEf1MWvYMoucrJRQ4SQ
 7yvp46y0ugFzSj98TzlRphFMAJlggcI1pe9D3nfGGfMLG2W5JZzZJR24Pgaw8EmTMORsxGHFjuV0
 iaXswd_k.NBStNSQxVzAGPFyPaiIFqlzRf6fR9ff0uuKxrlI3Gl3ZS6RYi0Zn_olh2H6fK0yNWbC
 RxZBBw2p8EBlKAPyYzv4Luuej3XHlQyhpOWXmwhZaEsYLQ841AZPMitRC8Pe31zrCP016.oX17ta
 M.Q9bYciVyoeDxelixJ0uoKOZwtEO9VJsPuI1FielJCQkNXHtpPBvnL_vEp.e9BG12ie2Mq3Dp2T
 vSZEGgn5sUY90xT3uZid8GA1Iaj9mWH.f3F2jUkDux7j.RWFYKCGMYwOTFA5wlMMTutRjRV.WwVs
 nRQPYTsUbD2MkXCKMEvm57i5VP966.p.e66W6kMFbe2r.TMGJx3yEZNy1B9p3.WtpAzChi38o30y
 jUHHjNg.Quv7dI0cU8SFD6ctLqnoEKi4EEZYqphiP_B3UZp_G_PgFNCr6KAwBgXpHKWluoGBpoB_
 SqURW.1KGt7FPRHvB4CghnKiNoXyU4yOV.Yogqjp2ZSaDDW.yus_BwCJXPzHIcCvWrjQlTov_pnB
 KydrRhaOWqn7kFrq7g_pAv3Wqcj6B4drOOlynrf4N3uY6IGqiPK4HQEvUlWVAnbQ9ohvFFcpW9V6
 Y.JtcKzMSzlDatyWnabl.HtLTcu_sg3klviJlBv_tQuzo4M0gRjRlWZGWuTwJHQCteEyfuyiluDT
 KmMc2uzk_CkC6xRVp6UC.t5_UQAr9K3eYLISQJPNeg2poFXA8MtPSCrZfixRRGfM.xWXSCYuUOrJ
 l0s5nam9mr6JbvW4UOtqmLdf1km0h95qaPkxzckQPwmgjK1qWQQk3.gqm4PNC6PaFyvH_DRnGOtK
 F0e.dV4rW6udpGxpLrL4STdbS2PfJme.r_Xj4NrdEsakE1.ZQ1I58aNYIE03Yf_blMiwUr1EBBBk
 20Ig6f2z4sJoiobBg7m9T1qLiXNggQRQd.9WKnFCVE9zSa2rl2wCB4.qbxmM1XHT85shzwVakKEX
 o1xnFY9hSQVH00UqKk6UG0d.FRToa1tdc3kIQ5.600H4RYWH5NKENxUkQNf5XQjvwVIMz64A5La_
 tB0cgbpNL286gwWrxn_bMhjIcpqTwSDPhi97YIuarIH1hf2fqKlu391_2OYFvbl_FZSOaU4muZjY
 cOXrchYtrz7dI164DN4VbIkCx53HZComrkN0trthVra35wGSQh87q3I7W2TppzA_B7OE8.nw3w.N
 0og0skGoi..2XQ1G5ECaJpPJtR1V8mhmS58Asw_QwEVh4ROqRVJyiC8zLGMCf07GhDADE0Vw8ZIy
 1P3.L26NuTDwFgBWX6HOxaeMoaRumjw.zjSF0iQqO5TkRwjasIDqr531gg7bj8ZOdndOI6kfSU0y
 j.UvEdHq9MmSH.3.PzYqdGVhw9BDcC1Ef5jAS9JgfZiyHuTIFdQGXU7u2KRZDFQ2WCshHFVPFxtk
 x.DPdo_jYhJH9bGsIFW9QVbFTYk899tjN1P7Cqw--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: d6187e88-e384-4912-a3b0-ad22b20415ea
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 24 Oct 2025 09:28:33 +0000
Received: by hermes--production-bf1-554b85575-4l28s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 610de680fd708467af4a7d8c71a7708c;
          Fri, 24 Oct 2025 09:18:22 +0000 (UTC)
Message-ID: <565914cb-1188-424c-b8ee-16739f350ddb@yahoo.com>
Date: Fri, 24 Oct 2025 10:18:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/unix: Add test for ECONNRESET and EOF behaviour
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20251023165841.8164-1-adelodunolaoluwa.ref@yahoo.com>
 <20251023165841.8164-1-adelodunolaoluwa@yahoo.com>
 <CAAVpQUAX-+5cOCaZrA1DbMTLrUEhCsK=6JSHAQgSNhbOyQ06MA@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAAVpQUAX-+5cOCaZrA1DbMTLrUEhCsK=6JSHAQgSNhbOyQ06MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/24/25 04:00, Kuniyuki Iwashima wrote:
> Thanks for adding tests.
>
>> [PATCH] selftests/unix: Add test for ECONNRESET and EOF behaviour
> nit: The common prefix is "selftest: af_unix:".
>
>
> On Thu, Oct 23, 2025 at 9:59 AM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> Add selftests verifying the EOF and ECONNRESET behaviour of
>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM). The tests document
>> Linux's semantics and clarify the long-standing differences with BSD.
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>> ---
>>   tools/testing/selftests/net/unix/Makefile     |   5 +
>>   .../selftests/net/unix/test_unix_connreset.c  | 147 ++++++++++++++++++
>>   2 files changed, 152 insertions(+)
>>   create mode 100644 tools/testing/selftests/net/unix/Makefile
>>   create mode 100644 tools/testing/selftests/net/unix/test_unix_connreset.c
> The test for af_unix is placed under tools/testing/selftests/net/af_unix.
>
>
>> diff --git a/tools/testing/selftests/net/unix/Makefile b/tools/testing/selftests/net/unix/Makefile
>> new file mode 100644
>> index 000000000000..a52992ba23d9
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/unix/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +TEST_GEN_PROGS := test_unix_connreset
>> +
>> +include ../../lib.mk
>> +
>> diff --git a/tools/testing/selftests/net/unix/test_unix_connreset.c b/tools/testing/selftests/net/unix/test_unix_connreset.c
>> new file mode 100644
>> index 000000000000..a8720c7565cb
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/unix/test_unix_connreset.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Selftest for UNIX socket close and ECONNRESET behaviour.
> nit: s/UNIX/AF_UNIX/
>
>> + *
>> + * This test verifies that:
>> + *  1. SOCK_STREAM sockets return EOF when peer closes normally.
>> + *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread data.
>> + *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes,
>> + *     unlike BSD where this error is observed.
>> + *
>> + * These tests document the intended Linux behaviour, distinguishing it from BSD.
> I'd not mention BSD as it could be outdated again.
>
>
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
>> +#define SOCK_PATH "/tmp/test_unix_connreset.sock"
>> +
>> +static void remove_socket_file(void)
>> +{
>> +       unlink(SOCK_PATH);
>> +}
>> +
>> +/* Test 1: peer closes normally */
>> +TEST(stream_eof)
> I think most of the code can be shared by defining
> FIXTURE_VARIANT().
>
> e.g. variant->unread_data can consolidate Test 1&2.
>
>
>> +{
>> +       int server, client, child;
>> +       struct sockaddr_un addr = {0};
>> +       char buf[16] = {0};
> IIRC, {0} only initialises the first entry and we had a problem
> in kernel code, so simply use "= {};" everywhere.
>
>
>> +       ssize_t n;
>> +
>> +       server = socket(AF_UNIX, SOCK_STREAM, 0);
> Try using variant->type for SOCK_STREAM,
> SOCK_DGRAM, and SOCK_SEQPACKET.
>
> See unix_connect.c, or you could reuse the fixtures
> of err == 0 there.
>
>> +       ASSERT_GE(server, 0);
> nit: The 1st arg is "expected", and the 2nd is "seen",
> so ASSERT_NE(-1, server) (or ASSERT_LT(-1, server)).
>
> Same for other places.
>
>
>> +
>> +       addr.sun_family = AF_UNIX;
>> +       strcpy(addr.sun_path, SOCK_PATH);
>> +       remove_socket_file();
>> +
>> +       ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0);
> I personally feel easy to read this style:
>
> err = bind();
> ASSERT_EQ(0, err);
>
>> +       ASSERT_EQ(listen(server, 1), 0);
>> +
>> +       client = socket(AF_UNIX, SOCK_STREAM, 0);
>> +       ASSERT_GE(client, 0);
>> +       ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr)), 0);
>> +
>> +       child = accept(server, NULL, NULL);
>> +       ASSERT_GE(child, 0);
>> +
>> +       /* Peer closes normally */
>> +       close(child);
>> +
>> +       n = recv(client, buf, sizeof(buf), 0);
>> +       EXPECT_EQ(n, 0);
>> +       TH_LOG("recv=%zd errno=%d (%s)", n, errno, strerror(errno));
> I printed errno just for visibility, and you can simply use
> ASSERT here too like
>
> if (n == -1)
>      ASSERT_EQ(ECONNRESET, errno)
>
> (I'm assuming Test 1 & 2 will share most code)
>
>> +
>> +       close(client);
>> +       close(server);
>> +       remove_socket_file();
> This will not be executed if the program fails at ASSERT_XX(),
> so move it to FIXTURE_TEARDOWN().
>
>
>
>> +}
>> +
>> +/* Test 2: peer closes with unread data */
>> +TEST(stream_reset_unread)
>> +{
>> +       int server, client, child;
>> +       struct sockaddr_un addr = {0};
>> +       char buf[16] = {0};
>> +       ssize_t n;
>> +
>> +       server = socket(AF_UNIX, SOCK_STREAM, 0);
>> +       ASSERT_GE(server, 0);
>> +
>> +       addr.sun_family = AF_UNIX;
>> +       strcpy(addr.sun_path, SOCK_PATH);
>> +       remove_socket_file();
>> +
>> +       ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0);
>> +       ASSERT_EQ(listen(server, 1), 0);
>> +
>> +       client = socket(AF_UNIX, SOCK_STREAM, 0);
>> +       ASSERT_GE(client, 0);
>> +       ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr)), 0);
>> +
>> +       child = accept(server, NULL, NULL);
>> +       ASSERT_GE(child, 0);
>> +
>> +       /* Send data that will remain unread by client */
>> +       send(client, "hello", 5, 0);
>> +       close(child);
>> +
>> +       n = recv(client, buf, sizeof(buf), 0);
>> +       EXPECT_LT(n, 0);
>> +       EXPECT_EQ(errno, ECONNRESET);
>> +       TH_LOG("recv=%zd errno=%d (%s)", n, errno, strerror(errno));
>> +
>> +       close(client);
>> +       close(server);
>> +       remove_socket_file();
>> +}
>> +
>> +/* Test 3: SOCK_DGRAM peer close */
>> +TEST(dgram_reset)
>> +{
>> +       int server, client;
>> +       int flags;
>> +       struct sockaddr_un addr = {0};
>> +       char buf[16] = {0};
>> +       ssize_t n;
>> +
>> +       server = socket(AF_UNIX, SOCK_DGRAM, 0);
>> +       ASSERT_GE(server, 0);
>> +
>> +       addr.sun_family = AF_UNIX;
>> +       strcpy(addr.sun_path, SOCK_PATH);
>> +       remove_socket_file();
>> +
>> +       ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0);
>> +
>> +       client = socket(AF_UNIX, SOCK_DGRAM, 0);
>> +       ASSERT_GE(client, 0);
>> +       ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr)), 0);
>> +
>> +       send(client, "hello", 5, 0);
>> +       close(server);
>> +
>> +       flags = fcntl(client, F_GETFL, 0);
>> +       fcntl(client, F_SETFL, flags | O_NONBLOCK);
> You can save fcntl() with socket(..., ... | SOCK_NONBLOCK, ...).
>
>
>> +
>> +       n = recv(client, buf, sizeof(buf), 0);
>> +       TH_LOG("recv=%zd errno=%d (%s)", n, errno, strerror(errno));
>> +       /* Expect EAGAIN or EWOULDBLOCK because there is no datagram and peer is closed. */
>> +       EXPECT_LT(n, 0);
>> +       EXPECT_TRUE(errno == EAGAIN);
>> +
>> +       close(client);
>> +       remove_socket_file();
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> +
>> --
>> 2.43.0
>>
Hi Kuniyuki,
Thank you very much for the detailed review and helpful suggestions.
I will send a v2 patch incorporating these changes.
Thanks again for taking the time to review and explain the details, I 
really appreciate it.

Best regards,
Sunday Adelodun


