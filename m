Return-Path: <linux-kselftest+bounces-31520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843CA9A49E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD37B05BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7C2116FA;
	Thu, 24 Apr 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ePtbcWyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBC20E328;
	Thu, 24 Apr 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480669; cv=none; b=HO4vHfa3ZJTVpwx5XwlEmQpVlhG5qcbJEO8TL+ZjPbKpHz/K3ODO+/pd5xVpe0LNRsLJfuQWKohuPyVzyJq14fuYoFLpwbV4vWxEY8ODqAkcAiIJmbQQil4vKpgyIzL8AC6YPYWy9dJkdbLsDHlbBdp4/sKFHNN2uNLEKxEyhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480669; c=relaxed/simple;
	bh=wxzB/VwkxnSOr6SZIQ3uhuxhGI1wRmjwoI8tZnJh8as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBt9XQ5ExK4lag4BxOEHBYxWDwtQQKevGKpTWNvYpMnzqOWRkPpDKuCFFr8gg/pd0ApNAgQxYHOSSsTCWv4AfMovpMYJReUQaUdrrsDUkEY8sAFHrP5vF8pp/EfFXVF0LGxuAfcwwDL4eg0PeAsTj6Q0mrJ284oE84TIffSmvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ePtbcWyL; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by smtp.orange.fr with ESMTPSA
	id 7rEluyXlGRaJG7rEouYdju; Thu, 24 Apr 2025 09:43:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745480594;
	bh=GpCYqYgESUXy9AbmEPELLgxMlDG6aDvjflLva5bv108=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=ePtbcWyL9O4S/P0hMXaDhUIQFS1IvV1PLQTUk4tYSXkDyLVlN0nlm4G8Dpw+/U+Rq
	 69/vg47+dRCleJxM2eQ6q3hMp9HzfHLkikzoTO9g51VMmFHjX8nF9+LjpiEK/5+JsD
	 SvE79e8AXpUE00h38eoQ+yXklVPBR/tBSU98YfE3SU1WPxoWCg4iJVT4/hbhy1CZXi
	 Y6cSRU0yR8HvCCgqUuHteCbWmQWLos2mAN4GuJPEqj5QOntxEkDJlMTBDFbzjO/qJo
	 HNbgqg0ZJ1qDN1d/l0pMtzPU40hTqlNXDTiIZu34a4WEBgXVgZN9kO9sM+TmtNTRhU
	 7cMoxKfGd8WVw==
X-ME-Helo: mail-ed1-f54.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 09:43:14 +0200
X-ME-IP: 209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so1005598a12.1;
        Thu, 24 Apr 2025 00:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNeDMoEsGa3++1pog3QhyKQApLqblOzX5H1dYBX8VDUfUpKBR7llUo/IfasacEaz8IVioD9t6BeMA=@vger.kernel.org, AJvYcCUZrGc7rWFg9WsOc+oPTcd9QOOgiDn8R0V0lF2mSYLKFslLlulkEdtO8yLcTi7mD4W68nEOfFS8yWiAfq+bMjMw@vger.kernel.org, AJvYcCUi6K2b+ix2210taWwSFo5ZHCoboW+3pdvhYUrBNasICcAf+GLkAkciof0NooGQmM3nDFJDKmkj@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJbc1L/hbAb5TT2Enulh1uIgTt++9cU3kKVtHjoaT+yuT4HVT
	PZfs6hmE5xmxdA0Sflv9/ozkr9DqypDAkg/qD3o90cRQlM1fF9DXD+y9FnDCIoU/GTpN9pzCg7Q
	3Zy7G9uqoCl+6RdI1j5jwO/7ft94=
X-Google-Smtp-Source: AGHT+IGKQ2Hb1W8ksOwYYkOEVke4r5x+ql8aoYIftHFyctNFYKmNQjjw2iuGu45nBY61XZBpa9tJ8EMiAnBTZWR+o8o=
X-Received: by 2002:a17:907:d90:b0:ac7:391b:e685 with SMTP id
 a640c23a62f3a-ace574952aemr152768266b.59.1745480590939; Thu, 24 Apr 2025
 00:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745323279.git.fmaurer@redhat.com> <881e71d14711e1e16d74d26fe381fca240163cc5.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <881e71d14711e1e16d74d26fe381fca240163cc5.1745323279.git.fmaurer@redhat.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 16:42:59 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLLchj4oJUJEzObBpK4_dDHooo0ZHNz26tH33DQh7Ugag@mail.gmail.com>
X-Gm-Features: ATxdqUEhNxHk0ZntfDcA2pT-jzKLhhp2N5MwWSYLBbCoJGerra68ui3Wp3i2Olc
Message-ID: <CAMZ6RqLLchj4oJUJEzObBpK4_dDHooo0ZHNz26tH33DQh7Ugag@mail.gmail.com>
Subject: Re: [PATCH 2/4] selftests: can: use kselftest harness in test_raw_filter
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue. 22 Apr. 2025 at 21:04, Felix Maurer <fmaurer@redhat.com> wrote:
> Update test_raw_filter to use the kselftest harness to make the test output
> conform with TAP. Use the logging and assertations from the harness.
                                        ^^^^^^^^^^^^
assertions?

>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  tools/testing/selftests/net/can/Makefile      |   2 +
>  .../selftests/net/can/test_raw_filter.c       | 152 ++++++++----------
>  2 files changed, 73 insertions(+), 81 deletions(-)
>
> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> index 44ef37f064ad..5b82e60a03e7 100644
> --- a/tools/testing/selftests/net/can/Makefile
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -2,6 +2,8 @@
>
>  top_srcdir = ../../../../..
>
> +CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +
>  TEST_PROGS := test_raw_filter.sh
>
>  TEST_GEN_FILES := test_raw_filter
> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
> index c84260f36565..7414b9aef823 100644
> --- a/tools/testing/selftests/net/can/test_raw_filter.c
> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
> @@ -18,6 +18,8 @@
>  #include <linux/can.h>
>  #include <linux/can/raw.h>
>
> +#include "../../kselftest_harness.h"
> +
>  #define ID 0x123
>  #define TC 18 /* # of testcases */
>
> @@ -53,7 +55,38 @@ canid_t calc_mask(int testcase)
>         return mask;
>  }
>
> -int main(int argc, char **argv)
> +int send_can_frames(int sock, int testcase)
> +{
> +       struct can_frame frame;
> +
> +       frame.can_dlc = 1;
> +       frame.data[0] = testcase;
> +
> +       frame.can_id = ID;
> +       if (write(sock, &frame, sizeof(frame)) < 0) {
> +               perror("write");
> +               return 1;
> +       }
> +       frame.can_id = (ID | CAN_RTR_FLAG);
> +       if (write(sock, &frame, sizeof(frame)) < 0) {
> +               perror("write");
> +               return 1;
> +       }
> +       frame.can_id = (ID | CAN_EFF_FLAG);
> +       if (write(sock, &frame, sizeof(frame)) < 0) {
> +               perror("write");
> +               return 1;
> +       }
> +       frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
> +       if (write(sock, &frame, sizeof(frame)) < 0) {
> +               perror("write");
> +               return 1;
> +       }
> +
> +       return 0;

Nitpick: can you centralize the error handling under a goto label?

  write_err:
          perror("write");
          return 1;

> +}
> +
> +TEST(can_filter)
>  {
>         fd_set rdfs;
>         struct timeval tv;
> @@ -67,34 +100,26 @@ int main(int argc, char **argv)
>         int rxbits, rxbitval;
>         int ret;
>         int recv_own_msgs = 1;
> -       int err = 0;
>         struct ifreq ifr;
>
> -       if ((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
> -               perror("socket");
> -               err = 1;
> -               goto out;
> -       }
> +       s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
> +       ASSERT_LT(0, s)
> +               TH_LOG("failed to create CAN_RAW socket (%d)", errno);
>
>         strcpy(ifr.ifr_name, VCANIF);
> -       if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> -               perror("SIOCGIFINDEX");
> -               err = 1;
> -               goto out_socket;
> -       }
> +       ret = ioctl(s, SIOCGIFINDEX, &ifr);
> +       ASSERT_LE(0, ret)
> +               TH_LOG("failed SIOCGIFINDEX (%d)", errno);
> +
>         addr.can_family = AF_CAN;
>         addr.can_ifindex = ifr.ifr_ifindex;
>
>         setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
>                    &recv_own_msgs, sizeof(recv_own_msgs));
>
> -       if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> -               perror("bind");
> -               err = 1;
> -               goto out_socket;
> -       }
> -
> -       printf("---\n");
> +       ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
> +       ASSERT_EQ(0, ret)
> +               TH_LOG("failed bind socket (%d)", errno);
>
>         for (testcase = 0; testcase < TC; testcase++) {
>
> @@ -103,36 +128,14 @@ int main(int argc, char **argv)
>                 setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER,
>                            &rfilter, sizeof(rfilter));
>
> -               printf("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X\n",
> +               TH_LOG("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X",
>                        testcase, rfilter.can_id, rfilter.can_mask);
>
> -               printf("testcase %2d sending patterns ... ", testcase);
> -
> -               frame.can_dlc = 1;
> -               frame.data[0] = testcase;
> -
> -               frame.can_id = ID;
> -               if (write(s, &frame, sizeof(frame)) < 0) {
> -                       perror("write");
> -                       exit(1);
> -               }
> -               frame.can_id = (ID | CAN_RTR_FLAG);
> -               if (write(s, &frame, sizeof(frame)) < 0) {
> -                       perror("write");
> -                       exit(1);
> -               }
> -               frame.can_id = (ID | CAN_EFF_FLAG);
> -               if (write(s, &frame, sizeof(frame)) < 0) {
> -                       perror("write");
> -                       exit(1);
> -               }
> -               frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
> -               if (write(s, &frame, sizeof(frame)) < 0) {
> -                       perror("write");
> -                       exit(1);
> -               }
> +               TH_LOG("testcase %2d sending patterns...", testcase);
>
> -               printf("ok\n");
> +               ret = send_can_frames(s, testcase);
> +               ASSERT_EQ(0, ret)
> +                       TH_LOG("failed to send CAN frames");
>
>                 have_rx = 1;
>                 rx = 0;
> @@ -147,58 +150,45 @@ int main(int argc, char **argv)
>                         tv.tv_usec = 50000; /* 50ms timeout */
>
>                         ret = select(s+1, &rdfs, NULL, NULL, &tv);
> -                       if (ret < 0) {
> -                               perror("select");
> -                               exit(1);
> -                       }
> +                       ASSERT_LE(0, ret)
> +                               TH_LOG("failed select for frame %d (%d)", rx, errno);
                                                                     ^^^^
Nitpick: the Linux coding style suggests not printing numbers in
parentheses (%d).

https://www.kernel.org/doc/html/latest/process/coding-style.html#printing-kernel-messages

Suggestion:

  TH_LOG("failed select for frame %d, err: %d", rx, errno);


>                         if (FD_ISSET(s, &rdfs)) {
>                                 have_rx = 1;
>                                 ret = read(s, &frame, sizeof(struct can_frame));
> -                               if (ret < 0) {
> -                                       perror("read");
> -                                       exit(1);
> -                               }
> -                               if ((frame.can_id & CAN_SFF_MASK) != ID) {
> -                                       fprintf(stderr, "received wrong can_id!\n");
> -                                       exit(1);
> -                               }
> -                               if (frame.data[0] != testcase) {
> -                                       fprintf(stderr, "received wrong testcase!\n");
> -                                       exit(1);
> -                               }
> +                               ASSERT_LE(0, ret)
> +                                       TH_LOG("failed to read frame %d (%d)", rx, errno);
> +
> +                               ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
> +                                       TH_LOG("received wrong can_id");
> +                               ASSERT_EQ(testcase, frame.data[0])
> +                                       TH_LOG("received wrong test case");
>
>                                 /* test & calc rxbits */
>                                 rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
>
>                                 /* only receive a rxbitval once */
> -                               if ((rxbits & rxbitval) == rxbitval) {
> -                                       fprintf(stderr, "received rxbitval %d twice!\n", rxbitval);
> -                                       exit(1);
> -                               }
> +                               ASSERT_NE(rxbitval, rxbits & rxbitval)
> +                                       TH_LOG("received rxbitval %d twice", rxbitval);
>                                 rxbits |= rxbitval;
>                                 rx++;
>
> -                               printf("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d\n",
> +                               TH_LOG("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d",
>                                        testcase, frame.can_id, rx, rxbits);
>                         }
>                 }
>                 /* rx timed out -> check the received results */
> -               if (rx_res[testcase] != rx) {
> -                       fprintf(stderr, "wrong rx value in testcase %d : %d (expected %d)\n",
> -                               testcase, rx, rx_res[testcase]);
> -                       exit(1);
> -               }
> -               if (rxbits_res[testcase] != rxbits) {
> -                       fprintf(stderr, "wrong rxbits value in testcase %d : %d (expected %d)\n",
> -                               testcase, rxbits, rxbits_res[testcase]);
> -                       exit(1);
> -               }
> -               printf("testcase %2d ok\n---\n", testcase);
> +               ASSERT_EQ(rx_res[testcase], rx)
> +                       TH_LOG("wrong number of received frames %d", testcase);
> +               ASSERT_EQ(rxbits_res[testcase], rxbits)
> +                       TH_LOG("wrong rxbits value in testcase %d", testcase);
> +
> +               TH_LOG("testcase %2d ok", testcase);
> +               TH_LOG("---");
>         }
>
> -out_socket:
>         close(s);
> -out:
> -       return err;
> +       return;
>  }
> +
> +TEST_HARNESS_MAIN

Yours sincerely,
Vincent Mailhol

