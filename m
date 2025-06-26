Return-Path: <linux-kselftest+bounces-35871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09283AEA383
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 18:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489A07AFF54
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468620CCF4;
	Thu, 26 Jun 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0pJdBkO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12392F1FF9;
	Thu, 26 Jun 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955474; cv=none; b=LiKSUAEl7FD7JZpQPKwkEZa1OQYPInAFqOzd3Rx5gayc+O9JYL6IHTMV6+rDN5h5dwdBoxyyWf6mVq0K41fwM2NNmW25d9nKz95/rlyjEbEGgvrgCNzUz8qzKh9QdeiJM8L2q4CfyNrJrzt9Ht5H6Bq1zCQsWjpdOZ87/WyF1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955474; c=relaxed/simple;
	bh=HT7TrT+9RAo9P1265OpuBOUxaqxI8OngOWZcR/hl21A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AXtnBE3Djt/GS0ZoBIdwST20ELldEF5oeBTa3LpzOAJWq4/oBHlJWOOjNmlB1X942zxgQtxFV6R3mcYKmY/KCMO9QYt6npEPd/pniqnT5zspSKhAVqRQBmJgyaiu/IoLJEShJK9cBQyjRhKj3kQgV9EFfRJFFTu6Z1xW/FauglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0pJdBkO; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7387d4a336so1078278276.2;
        Thu, 26 Jun 2025 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750955472; x=1751560272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU907uMABVIuqhXrvaDd1M5r5o0uDZff62vwsqKDZWA=;
        b=Y0pJdBkOmarrN+IHFZDGP1iCHN3ett7qeY3sikhuq5Tb6PTJgR6Pd75I9Bm4O6aWWa
         tTQcZotisrw9Zn5owJmMvvmF0LzIldVxybU2S95vAIbR3LRYbWZVE8WnmtYIO4EaJI5B
         jV46nPYnywr0Kv3a2kJJOgDZV8CipTN3KJlvR9YM6dQlalDqTP2p51DE1iKxZHwsIvUy
         c9yHEdeEY7XXgu+LwvQEZft8V+vH9VSaEA+utcSlVGdkakfb/hIABa58WWnQpRyaTvKu
         YdYXccSZKZOI7DdNRgkixQhCr8RBukJGa7x9wuAiYKPMlv0lgWtfpucON7kFzv0r0veC
         uDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955472; x=1751560272;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sU907uMABVIuqhXrvaDd1M5r5o0uDZff62vwsqKDZWA=;
        b=LYoZMxa/l05giENjb2ZFg30TgxNYjqfZDNhbVLW4eot2mUNLvFBYKoCa4f5sJ89t1y
         a0DvFiASkaVQrKN93V2oLAQp9BFcIY7fOZjWJbRPR5V2pxE9f912HoP/QU5eSes4K35f
         u8NHcvIhreYT/Z/sHNhMxl6LF0rCXnhBtT+6AZMQfzKEGwTQFdIlcwRRCjjrvxBMqSXr
         ahkEk/+IOIsljzlcVh2NAkYqDfzxG2pGO4qSdBsLKGVnqvyYmyJSQmnPUQ/RzO7Hgfnl
         fNQbxR1cpVYtvyFJQJ1wUfmYY6X+cDKw7rPeG389GN5dfjRWBEACssgm/cE70UlBtT+0
         d0AA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5+T+v7aDBPq0LST+APP+XxeOY7cOZIJnM2Po4+5kClYOmFWDSkE3Aw3H8RHI7HN6L84=@vger.kernel.org, AJvYcCVQDccJMls02/QWF0Il5/wZw6Ro0+WSs+S4VU1hcHlS5MVgsrrunrqPC5F0X2N/AsVWTM4UQ/OLeOlUg3uYZxGN@vger.kernel.org, AJvYcCWuUvNckAs/bD4IBzyiN696nimzmRr0et09Z2G+TGDkWvQjBh/FwpmmAlbvO/Mtm27Zs7kTuWi6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1x4FuylZOjKf298XBBrPL+zrPXHpqlDfQZTs0x/ZeeVLjgp4Q
	8yLYW7YSGMxk8f5jL6POY2w/y6nXqeYzjQMnnc/KZ+HJ9h10Dfy0Fuf2
X-Gm-Gg: ASbGncvYWRsAvmdCQHu5cpt/0ZLbN+5t3w4HClg9ycGRyHBI9F7jNDPjq8WFl/veT27
	VV2hQYljb2wY7dpt5xuocfvuqER2/lQIjFSCax2jRbiIbAA/3WyFvJFNOFVWfmU99IaV80mFB9W
	Qgawmpa77qAiW0r1jILNcW1dfejLDfVfcmwDkaLaP23Iq9FWbp/+k6LuWtllGokMdgiDAvGNknT
	zLm7kR0Ga4PV8XCvykvf8kBDwWzvGJDmPyFjzE73RAtNHvY5H2IMWKM9SyDRSdfOy8zRm6ZGHjU
	JlgZSXFnOpE6LerfxC0cBjU1wAxYpbrdoeEId8DqjjqyiXuA8o5zNPLRTAhMFevBLULxz2D6Eo1
	cQGHv3QYapt5AUp4jUkF7MZB3qyKifZVAcrEwQSU1lw==
X-Google-Smtp-Source: AGHT+IFrPsJ7ocFnnJXVD1xPpmy2Gbr6SdxJFVUck73u2UFAzH256ovImqgekymICTAG/orEeonCbQ==
X-Received: by 2002:a05:6902:5086:b0:e87:985c:d69f with SMTP id 3f1490d57ef6-e87985cd8c8mr5729673276.41.1750955471718;
        Thu, 26 Jun 2025 09:31:11 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e87a6bd0559sm85077276.32.2025.06.26.09.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:31:11 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:31:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf@vger.kernel.org, 
 gustavold@gmail.com, 
 Breno Leitao <leitao@debian.org>
Message-ID: <685d75ceb113c_2e676c294d1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Add a basic selftest for the netpoll polling mechanism, specifically
> targeting the netpoll poll() side.
> 
> The test creates a scenario where network transmission is running at
> maximum speed, and netpoll needs to poll the NIC. This is achieved by:
> 
>   1. Configuring a single RX/TX queue to create contention
>   2. Generating background traffic to saturate the interface
>   3. Sending netconsole messages to trigger netpoll polling
>   4. Using dynamic netconsole targets via configfs
>   5. Delete and create new netconsole targets after some messages
>   6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
>      called
>   7. If bpftrace exists and netpoll_poll_dev() was called, stop.
> 
> The test validates a critical netpoll code path by monitoring traffic
> flow and ensuring netpoll_poll_dev() is called when the normal TX path
> is blocked.
> 
> This addresses a gap in netpoll test coverage for a path that is
> tricky for the network stack.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

> +def bpftrace_call() -> None:
> +    """Call bpftrace to find how many times netpoll_poll_dev() is called.
> +    Output is saved in the global variable `maps`"""
> +
> +    # This is going to update the global variable, that will be seen by the
> +    # main function
> +    global MAPS  # pylint: disable=W0603
> +
> +    # This will be passed to bpftrace as in bpftrace -e "expr"
> +    expr = "BEGIN{ @hits = 0;} kprobe:netpoll_poll_dev { @hits += 1; }"

Is that BEGIN statement needed? I generally just use count().

> +
> +    MAPS = bpftrace(expr, timeout=BPFTRACE_TIMEOUT, json=True)
> +    logging.debug("BPFtrace output: %s", MAPS)
> +
> +
> +def bpftrace_start():
> +    """Start a thread to call `call_bpf` in parallel for 2 seconds."""

Stale comment? BPFTRACE_TIMEOUT is set to 15.

> +    global BPF_THREAD  # pylint: disable=W0603
> +
> +    BPF_THREAD = threading.Thread(target=bpftrace_call)
> +    BPF_THREAD.start()
> +    if not BPF_THREAD.is_alive():
> +        raise KsftSkipEx("BPFtrace thread is not alive. Skipping test")
> +
> +

