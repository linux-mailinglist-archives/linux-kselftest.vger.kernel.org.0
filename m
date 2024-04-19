Return-Path: <linux-kselftest+bounces-8424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C180D8AAEDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581281F22D69
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174568565F;
	Fri, 19 Apr 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O18/6UxX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814741DFC7;
	Fri, 19 Apr 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531305; cv=none; b=e+XDrvj977H9RD5IL4P2w9MemZx82Nhc0ShB6WUSAkCZ/eYAD2+FJvb3M5MzCYHsLYTweJX/oRkHOb7A6KlzD7/j1KY+QYS8icrhzy7EPbiRD1iSJHgfiHN88WvsWqerYMl6U+anPmjruqvAna5JRHzecO9KhwqNzEQcWjslpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531305; c=relaxed/simple;
	bh=AUCkt1kK8U9Sn/QbGufhk58XRsFaexENYXsHPMuK5JI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nl6kEEZj7w1aj68lHEHUy77CDf8VFYjeiw7xebhsqDCzMsBIjsMP8PppsEWvruwjs0vFb5LJ+E8jAnKTMpIxYVCWR2D0WHQl7U4/50t5E4t6v0myhUx1G9rEP0aSCvHSAkpw2iziqqY5J1NJ4zfd3HLMYTTZ9PwgRnOMx9yTUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O18/6UxX; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-617dfcf80aeso22111597b3.3;
        Fri, 19 Apr 2024 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713531302; x=1714136102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k/zISqeTAlPurWEOHJktO+2lC/J+SuXwkImcovDbVY=;
        b=O18/6UxXBZkT+qkGzNrpGuX9yL3DL4v0tDoG8hUZl7kn5j0aYQyPssDAaySqI4i2ow
         pxALCZvwUzOq1lGsWQHY+NEKN6DckISQI2KDg+rat7Q2H9aiVi0fEGN4CzJz9VrrkZAR
         Ehm0ETDIlz01go0qWrDyLP9uaSMNdgL+VTraBhImaac0l7Nuv1j0xUK3nYOdiwHhPgGS
         Ld2uAUnCKbdK6MYt2t/wNhW15zGJXhPcu53pW2ebWHunGPOJrl2EY5snPGOf2S3daqy1
         HYkgvNPher2ujyuZbw7/wv/dlA1CZz+ZiUWS1WxnYsWvDwh5/kV1k0GgJuL6xmmWywha
         380A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713531302; x=1714136102;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3k/zISqeTAlPurWEOHJktO+2lC/J+SuXwkImcovDbVY=;
        b=Gz151NE5CnUy2x0ZuOCJxXCUZ9+10uJnU4AyXtNJV2doLHMUuydLwdEEQASumBwQ52
         rd05lcx4VMy4f1NyUt3f/JInrsQOFMZuXLV8XhQVPeA+h+CNjyFu0Ox5ysEXJkclWZ+Z
         MCLSb+9r1e5MVbzHmc3pf9XTe652JuC7sy5gAaH7bk3KkqPaDvTWhdC1vXZq1CH+Wjls
         q2nib51WRCwIuOQCcvub7B2rW9JaQF7jpLTAN5qKRKMHFFBXfU9laJQFdUpRhxiPdNgz
         LeZbO1rs+t4a+hLQHwuEEKgTNpa2WM+cXZQahe6sW8e5/oWK4wumwJlE3gcWfKJHfLR/
         TR5w==
X-Forwarded-Encrypted: i=1; AJvYcCW3gdbJJUOw7pKyTphSzXFiIH1RWufy5Upp/QFIkH6PWOw429bvZ84xJFX8tTXBm6uw2TkiNsWRf+RvmnNIndAQ97czHa+Yh3P3p2p96SOe
X-Gm-Message-State: AOJu0Yy7ewrZ9ibqR/40fBk2WrIrCtS4FghTv85I2qIJ/efWQocK0Gk0
	NCfnYb0cl6v3tl/F6jIpFlKgaaUOA6sGvIWKS3QLx/RsZCp0Cn4r
X-Google-Smtp-Source: AGHT+IEbewqNCYrqVL68B212x1ovRfytMXJkimMl1lCcqOmm3OkF+bRUQ+dcGB4HpQH/Rh/ejOOIMA==
X-Received: by 2002:a25:fc04:0:b0:dcd:63f8:ba32 with SMTP id v4-20020a25fc04000000b00dcd63f8ba32mr1528533ybd.65.1713531302258;
        Fri, 19 Apr 2024 05:55:02 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id c18-20020a0ce152000000b0069b4d64ab0bsm1511115qvl.138.2024.04.19.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:55:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 08:55:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <662269a5a74a8_116a9b29483@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240418233844.2762396-7-kuba@kernel.org>
References: <20240418233844.2762396-1-kuba@kernel.org>
 <20240418233844.2762396-7-kuba@kernel.org>
Subject: Re: [PATCH net-next v4 6/7] selftests: drv-net: add a TCP ping test
 case (and useful helpers)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> More complex tests often have to spawn a background process,
> like a server which will respond to requests or tcpdump.
> 
> Add support for creating such processes using the with keyword:
> 
>   with bkg("my-daemon", ..):
>      # my-daemon is alive in this block
> 
> My initial thought was to add this support to cmd() directly
> but it runs the command in the constructor, so by the time
> we __enter__ it's too late to make sure we used "background=True".
> 
> Second useful helper transplanted from net_helper.sh is
> wait_port_listen().
> 
> The test itself uses socat, which insists on v6 addresses
> being wrapped in [], it's not the only command which requires
> this format, so add the wrapped address to env. The hope
> is to save test code from checking if address is v6.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/env.py       |  4 +++
>  tools/testing/selftests/drivers/net/ping.py   | 24 ++++++++++++-
>  tools/testing/selftests/net/lib/py/utils.py   | 35 +++++++++++++++++++
>  3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 579c5b34e6fd..2f62270d59fa 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -110,6 +110,10 @@ from .remote import Remote
>          self.addr = self.v6 if self.v6 else self.v4
>          self.remote_addr = self.remote_v6 if self.remote_v6 else self.remote_v4
>  
> +        # Bracketed addresses, some commands need IPv6 to be inside []
> +        self.baddr = f"[{self.v6}]" if self.v6 else self.v4
> +        self.remote_baddr = f"[{self.remote_v6}]" if self.remote_v6 else self.remote_v4
> +
>          self.ifname = self.dev['ifname']
>          self.ifindex = self.dev['ifindex']
>  
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 9f65a0764aab..15a0bdcb46e2 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -1,9 +1,12 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  
> +import random
> +
>  from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq
>  from lib.py import NetDrvEpEnv
> -from lib.py import cmd
> +from lib.py import bkg, cmd, wait_port_listen
>  
>  
>  def test_v4(cfg) -> None:
> @@ -16,6 +19,25 @@ from lib.py import cmd
>      cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
>  
>  
> +def test_tcp(cfg) -> None:
> +    port = random.randrange(1024 + (1 << 15))

Intended to be 1024 + random.randrange(1 << 15)?

> +
> +    with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", exit_wait=True) as nc:

Perhaps add reuseaddr to all tests with hand picked ports?

I guess that here the client initiates the close and hits the
TIME_WAIT. But not sure.

The odds of consecutive tests picking the same random ports are low.
But as we add tests and they are run in continuous testing, that
can become an annoying source of flaky runs.

> +        wait_port_listen(port)
> +
> +        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}",
> +            shell=True, host=cfg.remote)
> +    ksft_eq(nc.stdout.strip(), "ping")
> +
> +    port = random.randrange(1024 + (1 << 15))
> +    with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", host=cfg.remote,
> +             exit_wait=True) as nc:
> +        wait_port_listen(port, host=cfg.remote)
> +
> +        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
> +    ksft_eq(nc.stdout.strip(), "ping")
> +
> +

