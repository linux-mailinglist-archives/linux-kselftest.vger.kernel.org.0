Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63E3181A61
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgCKNwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 09:52:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55751 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbgCKNwn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 09:52:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so2176534wmi.5
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rxH11306lWeDbP7QaiW9KYqcGSQz8G6vvv/cRVSV/WM=;
        b=Fv5Iqnyn1gdF978L/4cLKCAkNKGWgjBiwOreoEv3QaRNWO/9DU7Xs2ybmv7z3AGE1u
         nZ1rX5+bKy8apT8M5SzmjL7GBXPTR24m4NqPPubcDE8cFOq+FabTGxkPWqW6xOteisLR
         bTZx34JTds4l88bNzgi6++PQ+lhHGZw6spHno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rxH11306lWeDbP7QaiW9KYqcGSQz8G6vvv/cRVSV/WM=;
        b=Qij2sS4COtVx284JFlxlr/OsAIXscG6FU8I4DBljByNSqqeiP9JAyv9PaynoAgzgpy
         hspbgaN9y8Fv/n+rSWSIiQmYdgNk1qLqkM95wTP4pVn8FV/ErahO4CP+Jzx7T+l+p1jf
         kUmPLPIMpbxi/AFSy2vfpRmb6VzFW0unjkEAYZ6LH3tp6MEr2gwLFZG7dn1Mw/K4xQ1c
         1r5L3PYim3SMo641qRFq/LhfRrhIKCq2yxdtgayigo+UYLimORlgo/bnNkyk720JLWA4
         nub2aHn6a4hLgqgZhV6fjumLpKjgr3N2dR3ozl9Fjbe2dcnPZNVmKASM184dlDJf1y0B
         4oHA==
X-Gm-Message-State: ANhLgQ1QCacCnPkDxJ1dHRp8MCjtIyARVX3rijlowLvs0z4RkvzR72nE
        t/RKaG1IPJoWipp3QQLBFyZKNQ==
X-Google-Smtp-Source: ADFU+vuo+4xqkMzJGeG6/6DyfbLS3Y3jsPMS2HMgekvRv41TjxsVjFE/ARVg3j+ncuoQDcnGNjCfmQ==
X-Received: by 2002:a7b:ce0d:: with SMTP id m13mr3766203wmc.135.1583934761107;
        Wed, 11 Mar 2020 06:52:41 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w1sm7920404wmc.11.2020.03.11.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:52:40 -0700 (PDT)
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200310174711.7490-6-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] bpf: sockmap, sockhash: test looking up fds
In-reply-to: <20200310174711.7490-6-lmb@cloudflare.com>
Date:   Wed, 11 Mar 2020 14:52:39 +0100
Message-ID: <87wo7rxal4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 10, 2020 at 06:47 PM CET, Lorenz Bauer wrote:
> Make sure that looking up an element from the map succeeds,
> and that the fd is valid by using it an fcntl call.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 26 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 52aa468bdccd..929e1e77ecc6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -453,7 +453,7 @@ static void test_lookup_after_delete(int family, int sotype, int mapfd)
>  	xclose(s);
>  }
>
> -static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
> +static void test_lookup_fd(int family, int sotype, int mapfd)
>  {
>  	u32 key, value32;
>  	int err, s;
> @@ -466,7 +466,7 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
>  			       sizeof(value32), 1, 0);
>  	if (mapfd < 0) {
>  		FAIL_ERRNO("map_create");
> -		goto close;
> +		goto close_sock;
>  	}
>
>  	key = 0;
> @@ -475,11 +475,25 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
>
>  	errno = 0;
>  	err = bpf_map_lookup_elem(mapfd, &key, &value32);
> -	if (!err || errno != ENOSPC)
> -		FAIL_ERRNO("map_lookup: expected ENOSPC");
> +	if (err) {
> +		FAIL_ERRNO("map_lookup");
> +		goto close_map;
> +	}
>
> +	if ((int)value32 == s) {
> +		FAIL("return value is identical");
> +		goto close;
> +	}
> +
> +	err = fcntl(value32, F_GETFD);
> +	if (err == -1)
> +		FAIL_ERRNO("fcntl");

I would call getsockopt()/getsockname() to assert that the FD lookup
succeeded.  We want to know not only that it's an FD (-EBADFD case), but
also that it's associated with a socket (-ENOTSOCK).

We can go even further, and compare socket cookies to ensure we got an
FD for the expected socket.

Also, I'm wondering if we could keep the -ENOSPC case test-covered by
temporarily dropping NET_ADMIN capability.

> +
> +close:
> +	xclose(value32);
> +close_map:
>  	xclose(mapfd);
> -close:
> +close_sock:
>  	xclose(s);
>  }
>
> @@ -1456,7 +1470,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
>  		/* lookup */
>  		TEST(test_lookup_after_insert),
>  		TEST(test_lookup_after_delete),
> -		TEST(test_lookup_32_bit_value),
> +		TEST(test_lookup_fd),
>  		/* update */
>  		TEST(test_update_existing),
>  		/* races with insert/delete */
