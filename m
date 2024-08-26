Return-Path: <linux-kselftest+bounces-16332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D5D95FA3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D9AB23436
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74C199E89;
	Mon, 26 Aug 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0gHqOmP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF371991B8
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702330; cv=none; b=clleKSitCB3tWPuXmhLmrXhH9wcRtj5uuYIN8giifpnlc7EiechVEr5+X0qq5TOCyGFRPxj9ou1neHHOhvs31GC4dUjsxPy51W/zrbafmn2+hR7cOl4GG+/H9M45DCLP5KnCiADv3BgtkOt64vngUakQ9emLau54+tffdnMZ01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702330; c=relaxed/simple;
	bh=WNIzx5i3oPs6WaNJdhO4xjopJ3PNEal+LVVYV5EADJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9WN6mSMHcWfSMBQUuzQucBk3wzIt3mGJu1jryzlN6oWYAtZJncH8DkQhifP1WPvaOjHZrlGSCGH8kGjzOunmAYJKJ/sv62qZDQDeYfbm9rG0lvijC+0dkdFCcJFiXcAbSJ1JdWgMZ8N13rYlQ1IbaiOyw4t/93IeKmkoX+QOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0gHqOmP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724702326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZeMyJWkAVcCvry81yl0/4YWVdBPs30WCndQ9OE2fq0=;
	b=U0gHqOmPUAH4Id7Q4BTlwKjvmH01fzNt1mql8HhDbtw3td6MKrINYh6DA5oq7+2pfRZ7xB
	x+ZEDry33SR6MQdQUiRDX7bN8S3lmR1UbrQZe8BQO3YZXEyi07QE6K057kAgHRiF3rHNqh
	DqDBI7/RzAyn4WDMSCAc1TUNyW/kvqE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-krXymzW7McaHhTod_FHuhQ-1; Mon, 26 Aug 2024 15:58:45 -0400
X-MC-Unique: krXymzW7McaHhTod_FHuhQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c17f1a7011so24984156d6.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 12:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702325; x=1725307125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZeMyJWkAVcCvry81yl0/4YWVdBPs30WCndQ9OE2fq0=;
        b=flKo7faUzeksogS5byQ3/qSvrdOJXX3hgkaXq5KIn2WhYG3EqL3LExhgHZnWA2ab+K
         mJx7g7XJWU33CAbyITQepmYSXTbJdy6NsDJt9jTlJlqbRkzNTiSmRgkljNXLa4UdTFt/
         C0vS8JLX9VK8LwX7TKqamZLgcZg15poMwW9eXL2yzVQWIhRiAUoNGW/wtzzBsPC7HFUy
         2yxVEZhzkLtJC0XdLKyMcxbYXfgWzWxHIQr56xtc/0Dy7R52se0e3YS16+7Jxun+d1bp
         KClmp8F5gZ+Ayn67RePhgYJua5Ma9QSbp1+UBbUWC5Z5x1pe8cQIKDjkxTntvRM8UgbJ
         XakA==
X-Forwarded-Encrypted: i=1; AJvYcCWxe7aGg6xXgCV45+HyDl9X0nbv768PVfXeNe8XCyz74QV8uboLvz4i3LMT1WSXF+ENp05bOUaF4xd6l/EPWoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwSv0BVa1r20a27jHUWEDzfkMZGdwLDShYRVuK/AI7y3m9PkU
	A9ucX7CJVIxKHh/+4AMAmx/EuqWCMYvHsKZVz0cT8pVJn3yhXWJerb3FRQrdFVsnlRHfiLSRHR0
	E0fh0IpavOfd+mWdCrxijULKHZjkCO5QZ+wmtPGhRZ3Tg8MT4V0oAm+eX29rCMFEpFA==
X-Received: by 2002:a05:6214:5882:b0:6b4:4585:8e43 with SMTP id 6a1803df08f44-6c32b6bc8e3mr4885886d6.31.1724702325142;
        Mon, 26 Aug 2024 12:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHZaThSq1wtxJRl+kk1RkVzDOkBRPqIFqK0pqxMp5jgbqjVm7RZy7HnATCZO0XJItbPYBFjw==
X-Received: by 2002:a05:6214:5882:b0:6b4:4585:8e43 with SMTP id 6a1803df08f44-6c32b6bc8e3mr4885646d6.31.1724702324628;
        Mon, 26 Aug 2024 12:58:44 -0700 (PDT)
Received: from [10.0.0.174] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db07c0sm49711836d6.90.2024.08.26.12.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 12:58:44 -0700 (PDT)
Message-ID: <9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com>
Date: Mon, 26 Aug 2024 15:58:42 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: add selftest for tcp SO_PEEK_OFF support
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
References: <20240823211902.143210-1-jmaloy@redhat.com>
 <20240823211902.143210-3-jmaloy@redhat.com>
 <CAL+tcoCro6o5ZkhVJdKah9o2p=tPUSu06D0ZzNPPDB2Ns66kMw@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CAL+tcoCro6o5ZkhVJdKah9o2p=tPUSu06D0ZzNPPDB2Ns66kMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-08-23 19:44, Jason Xing wrote:
> Hello Jon,
>
> On Sat, Aug 24, 2024 at 5:19 AM <jmaloy@redhat.com> wrote:
>> From: Jon Maloy <jmaloy@redhat.com>
>>
>> We add a selftest to check that the new feature added in
>> commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
>> works correctly.
>>
>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>> Tested-by: Stefano Brivio <sbrivio@redhat.com>
>> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> Thanks for working on this. Sorry that I just noticed I missed your
> previous reply :(
There is still the ditto UDP selftest to be done ;-)
>> ---
>>   tools/testing/selftests/net/Makefile          |   1 +
>>   tools/testing/selftests/net/tcp_so_peek_off.c | 181 ++++++++++++++++++
>>   2 files changed, 182 insertions(+)
>>   create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index 8eaffd7a641c..1179e3261bef 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -80,6 +80,7 @@ TEST_PROGS += io_uring_zerocopy_tx.sh
>>   TEST_GEN_FILES += bind_bhash
>>   TEST_GEN_PROGS += sk_bind_sendto_listen
>>   TEST_GEN_PROGS += sk_connect_zero_addr
>> +TEST_GEN_PROGS += tcp_so_peek_off
>>   TEST_PROGS += test_ingress_egress_chaining.sh
>>   TEST_GEN_PROGS += so_incoming_cpu
>>   TEST_PROGS += sctp_vrf.sh
>> diff --git a/tools/testing/selftests/net/tcp_so_peek_off.c b/tools/testing/selftests/net/tcp_so_peek_off.c
>> new file mode 100644
>> index 000000000000..8379ea02e3d7
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/tcp_so_peek_off.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <sys/types.h>
>> +#include <netinet/in.h>
>> +#include <arpa/inet.h>
>> +#include "../kselftest.h"
>> +
>> +static char *afstr(int af)
>> +{
>> +       return af == AF_INET ? "TCP/IPv4" : "TCP/IPv6";
>> +}
>> +
>> +int tcp_peek_offset_probe(sa_family_t af)
>> +{
>> +       int optv = 0;
>> +       int ret = 0;
>> +       int s;
>> +
>> +       s = socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
>> +       if (s < 0) {
>> +               ksft_perror("Temporary TCP socket creation failed");
>> +       } else {
>> +               if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof(int)))
>> +                       ret = 1;
>> +               else
>> +                       printf("%s does not support SO_PEEK_OFF\n", afstr(af));
>> +               close(s);
>> +       }
>> +       return ret;
>> +}
>> +
>> +static void tcp_peek_offset_set(int s, int offset)
>> +{
>> +       if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset)))
>> +               ksft_perror("Failed to set SO_PEEK_OFF value\n");
>> +}
>> +
>> +static int tcp_peek_offset_get(int s)
>> +{
>> +       int offset;
>> +       socklen_t len = sizeof(offset);
>> +
>> +       if (getsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, &len))
>> +               ksft_perror("Failed to get SO_PEEK_OFF value\n");
>> +       return offset;
>> +}
>> +
>> +static int tcp_peek_offset_test(sa_family_t af)
>> +{
>> +       union {
>> +               struct sockaddr sa;
>> +               struct sockaddr_in a4;
>> +               struct sockaddr_in6 a6;
>> +       } a;
>> +       int res = 0;
>> +       int s[2] = {0, 0};
>> +       int recv_sock = 0;
>> +       int offset = 0;
>> +       ssize_t len;
>> +       char buf;
>> +
>> +       memset(&a, 0, sizeof(a));
>> +       a.sa.sa_family = af;
>> +
>> +       s[0] = socket(af, SOCK_STREAM, IPPROTO_TCP);
>> +       s[1] = socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
>> +
>> +       if (s[0] < 0 || s[1] < 0) {
>> +               ksft_perror("Temporary probe socket creation failed\n");
>> +               goto out;
> Nit: I wonder if we can use more proper test statements to avoid such
> hiding failure[1] when closing a invalid file descriptor, even though
> it doesn't harm the test itself?
>
> [1]: "EBADF (Bad file descriptor)"
Fixed that in v2.
>> +       }
>> +       if (bind(s[0], &a.sa, sizeof(a)) < 0) {
>> +               ksft_perror("Temporary probe socket bind() failed\n");
>> +               goto out;
>> +       }
>> +       if (getsockname(s[0], &a.sa, &((socklen_t) { sizeof(a) })) < 0) {
>> +               ksft_perror("Temporary probe socket getsockname() failed\n");
>> +               goto out;
>> +       }
>> +       if (listen(s[0], 0) < 0) {
>> +               ksft_perror("Temporary probe socket listen() failed\n");
>> +               goto out;
>> +       }
>> +       if (connect(s[1], &a.sa, sizeof(a)) >= 0 || errno != EINPROGRESS) {
>> +               ksft_perror("Temporary probe socket connect() failed\n");
>> +               goto out;
>> +       }
>> +       recv_sock = accept(s[0], NULL, NULL);
>> +       if (recv_sock <= 0) {
>> +               ksft_perror("Temporary probe socket accept() failed\n");
>> +               goto out;
> Same here.
Fixed.
>> +       }
>> +
>> +       /* Some basic tests of getting/setting offset */
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != -1) {
>> +               ksft_perror("Initial value of socket offset not -1\n");
>> +               goto out;
>> +       }
>> +       tcp_peek_offset_set(recv_sock, 0);
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 0) {
>> +               ksft_perror("Failed to set socket offset to 0\n");
>> +               goto out;
>> +       }
>> +
>> +       /* Transfer a message */
>> +       if (send(s[1], (char *)("ab"), 2, 0) <= 0 || errno != EINPROGRESS) {
>> +               ksft_perror("Temporary probe socket send() failed\n");
>> +               goto out;
>> +       }
>> +       /* Read first byte */
>> +       len = recv(recv_sock, &buf, 1, MSG_PEEK);
>> +       if (len != 1 || buf != 'a') {
>> +               ksft_perror("Failed to read first byte of message\n");
>> +               goto out;
>> +       }
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 1) {
>> +               ksft_perror("Offset not forwarded correctly at first byte\n");
>> +               goto out;
>> +       }
>> +       /* Try to read beyond last byte */
>> +       len = recv(recv_sock, &buf, 2, MSG_PEEK);
>> +       if (len != 1 || buf != 'b') {
>> +               ksft_perror("Failed to read last byte of message\n");
>> +               goto out;
>> +       }
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 2) {
>> +               ksft_perror("Offset not forwarded correctly at last byte\n");
>> +               goto out;
>> +       }
>> +       /* Flush message */
>> +       len = recv(recv_sock, NULL, 2, MSG_TRUNC);
>> +       if (len != 2) {
>> +               ksft_perror("Failed to flush message\n");
>> +               goto out;
>> +       }
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 0) {
>> +               ksft_perror("Offset not reverted correctly after flush\n");
>> +               goto out;
>> +       }
>> +
>> +       printf("%s with MSG_PEEK_OFF works correctly\n", afstr(af));
>> +       res = 1;
>> +out:
>> +       close(recv_sock);
>> +       close(s[1]);
>> +       close(s[0]);
>> +       return res;
>> +}
>> +
>> +int main(void)
>> +{
>> +       int res4, res6;
>> +
>> +       res4 = tcp_peek_offset_probe(AF_INET);
>> +       res6 = tcp_peek_offset_probe(AF_INET6);
>> +
>> +       if (!res4 && !res6)
>> +               return KSFT_SKIP;
>> +
>> +       if (res4)
>> +               res4 = tcp_peek_offset_test(AF_INET);
>> +
>> +       if (res6)
>> +               res6 = tcp_peek_offset_test(AF_INET6);
>> +
>> +       if (!res4 || !res6)
> What if res6 is NULL after checking tcp_peek_offset_probe() while res4
> is always working correctly, then we will get notified with a
> KSFT_FAIL failure instead of KSFT_SKIP.
This is intentional. If IPv4 is supported, and IPv6 is not, that is a 
failure.

Regards
///jon

> The thing could happen because you reuse the same return value for v4/v6 mode.
>
> Thanks,
> Jason
>
>> +               return KSFT_FAIL;
>> +
>> +       return KSFT_PASS;
>> +}
>> +
>> --
>> 2.45.2
>>
>>


