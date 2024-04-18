Return-Path: <linux-kselftest+bounces-8338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6658A9D70
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8242F1F21991
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00DE16E88E;
	Thu, 18 Apr 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFDoa+hC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442C16D31B;
	Thu, 18 Apr 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451482; cv=none; b=moAls9XMBMIVtyiA6waxewtFGsVh986ubu0Vs49YhRTn1LGgu/9HiIB4081aOUX2M9oEuTyTdt9RPKq/+FAfy3+c2Mrraibam+hZgnFWKvyoHppJlM8pznHzYPMjDl6jzJETbKdlekz9V7ElryRooqUBW4Vs/ueRmndY1LdAjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451482; c=relaxed/simple;
	bh=R6gQDxk/AVSPY13qLrS8VUjm4XJL2skes44sclvGuTU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fsk5UEcKu1QB9njsQE0E4aCGujsLhoLOSjMz03VRA5bIFnrB/GjqsFqDP46p315SwAYkcWuCVOxaivxc5APaH9+m8AVQm+pqvSePWeP9e70WpCr8ntL+EvJD109zct2qLXlc6MB7SK/llQRBDAH3njXPGpC2Klq9tLomDOXeyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFDoa+hC; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ac61cf3fffso573168eaf.3;
        Thu, 18 Apr 2024 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713451480; x=1714056280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq1vypWIfxUnRPCTDZEjhD0u0Ss6rb5dOW5rIK2r7Q8=;
        b=UFDoa+hCAf32T/ECkrbfkwHF/2cTwsCs6RcppOJAFlDD1Ryv1/YOnQh0oQ7gUDXK+w
         TWbQ7mjfz/jlRsw3FIz8hYu0XjBzfNoKMldN0BfOzoHTzKw8sAuxeUuT7xldRDGzCOFc
         to2slL+URmYdBKW3el3oSf2O84T5OCpGxwNDSKj6GQZpq4rjSawebXBv7QqKG9P4eTxI
         dtqv4iwxXCh/8ks5rI3Rqqkd96neNwvWWUxVA3qHUKgrxcRT5pe0NZ+n1KNVXL+45xDj
         e59bErLWFIYW173UNafGb6YdoPN3MzSYTItGAHnVxFJciI884vXuW93gLBgKi9BTP9C5
         TPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451480; x=1714056280;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dq1vypWIfxUnRPCTDZEjhD0u0Ss6rb5dOW5rIK2r7Q8=;
        b=tR8HhxPD421zdmYjoyjjRkvlah6fVI1jUmiPYNiL6r5tz7alEOhE022YE9giGnePnX
         WgV622tNY1s2cOojCQB9YF+l38V7yHZr5tpKC6x9cDwefwF71Tq4g28e0tcZby97pZmY
         SXt8v2BOt1Vqib5tu0l0IPZHbtsFrcoxyMJoASB/YDEO0S2UTQ39er1LqpZmkzbNcFAI
         pjcaW1o3FDSlAdybAybDVqS/jXGfisPMnGoRpJUlaY6KHEqaUCmycEE09hcNKRKwZNMX
         3YSf7gHLxGHxAtKEWWh61pDk2almblP+fL/srh5+y304PeFzb0Ojrq7hoYuiAVSHDf4O
         Ttlw==
X-Forwarded-Encrypted: i=1; AJvYcCXQAxGBzuJMbJHuB6T8Oyq8tTMUt1HExZPep/DhHy1hw/yO5icCbU2ZBx7XMLrge95gzsqh4OoQQVzPVNpA6fp5OrWYiVJmExVem3nhiGEO
X-Gm-Message-State: AOJu0YwSwx20p1R9zdF//bqLvZ7DwWo8/5nM9E+iyS9QTu+UBQOLq8SK
	772/zyIRrlVJW34o20UeXcuMRFbjFqOBPM/oRdMjyc2gvxR8FMuc
X-Google-Smtp-Source: AGHT+IFLc0rsC1uK8SMFsHseRW7GChJrJMvu2GM2IPUF1owcGeVPXEhBPPaBMHK2qwpcvQFIAOhQhA==
X-Received: by 2002:a05:6358:7b91:b0:17e:6a4d:777 with SMTP id n17-20020a0563587b9100b0017e6a4d0777mr2309780rwg.19.1713451480169;
        Thu, 18 Apr 2024 07:44:40 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id ol2-20020ac84142000000b00436570bb9efsm718421qtb.56.2024.04.18.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:44:39 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:44:39 -0400
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
Message-ID: <662131d77b55d_ec9b92945@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240417231146.2435572-9-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
 <20240417231146.2435572-9-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 8/8] selftests: drv-net: add a TCP ping test
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
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/ping.py | 24 +++++++++++++--
>  tools/testing/selftests/net/lib/py/utils.py | 33 +++++++++++++++++++++
>  2 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 58aefd3e740f..8532e3be72ba 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -1,9 +1,12 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  
> -from lib.py import ksft_run, ksft_exit, KsftXfailEx
> +import random
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, KsftXfailEx
>  from lib.py import NetDrvEpEnv
> -from lib.py import cmd
> +from lib.py import bkg, cmd, wait_port_listen
>  
>  
>  def test_v4(cfg) -> None:
> @@ -22,6 +25,23 @@ from lib.py import cmd
>      cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
>  
>  
> +def test_tcp(cfg) -> None:
> +    port = random.randrange(1024 + (1 << 15))
> +    with bkg(f"nc -l {cfg.addr} {port}") as nc:
> +        wait_port_listen(port)
> +
> +        cmd(f"echo ping | nc {cfg.addr} {port}",
> +            shell=True, host=cfg.remote)
> +    ksft_eq(nc.stdout.strip(), "ping")
> +
> +    port = random.randrange(1024 + (1 << 15))
> +    with bkg(f"nc -l {cfg.remote_addr} {port}", host=cfg.remote) as nc:
> +        wait_port_listen(port, host=cfg.remote)
> +
> +        cmd(f"echo ping | nc {cfg.remote_addr} {port}", shell=True)
> +    ksft_eq(nc.stdout.strip(), "ping")
> +

There are different netcat implementations floating around.

I notice that I have to pass -N on the client to terminate the
connection after EOF. Else both peers keep the connection open,
waiting for input. And explicitly pass -6 if passing an IPv6
address. I think this is the one that ships with Debian..

