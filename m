Return-Path: <linux-kselftest+bounces-42632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C0BACEE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B279B189A2F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D330302767;
	Tue, 30 Sep 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvk+UXUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1730146C
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236604; cv=none; b=SRMxfAtsd13Ou5h21BTVXVcZ/J7MbBRE0jPwD+uj6A0zbEEYoSLWUyODMAhkTs4dvjgOZ4rWECpSn/3q4bCMW5UxO1HHpbsetXGNWnanuVIk1dJ6fx5/IsX5hoY6LrlV1ZkFOTLdRKBtQ2ADl7B5/Vfr/UwyzOX2fKEwWYY9U/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236604; c=relaxed/simple;
	bh=CXTHR3+ruv4b2NmSi2QyXZZoVB+RVVvtqzPGciNVlhQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FjkdRg4pFILv58MetObFPU+rM3INZaKgyTtoF5jrvAvTSuGOnunO1PgxEs1gxdWocmxCLc7wnx7iKxOt0ux7yh5x1SABsrDQ3eOr94Rwvl+qwGkj3OcpNqhWD3FSmwtO8ysKn9/6ft8ER7Xvv1ZI5Z8699GHS7dEtQWiqdYEis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvk+UXUK; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1504967241.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236602; x=1759841402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DIF8xxMKs45jgicXUY8+fOYkrHvhQ+64uTG3AYNzDU=;
        b=Tvk+UXUKR42fXurqNX5CdCRTrz97ra7T/rehDSWu/Kv9o1HhYT1Kx5ECY9DTL80ne/
         pm/LtH+QDZ4usoK9jUR89XgUGnJUZ2Qe4pL/wCUgBCTn4d3HWF4zsSlMM/7zzx7JhvCc
         g9pnajzLLnXM4AyclMxKSnLnBL3Lcts5SxwNDZvmOB1A8ORKfpZ2RXYj1snSoUBw2ikm
         tIXrQwN/XULzh30zcPbF2cz1RAsObQHv6TqDXXIhuWhOsdm8vAefd91xpIoH2SUdhSwW
         lMotnX8RjG4AEdvUIDVp/wT98drwzwzk1bS5bkuBnKZ4qfaOXdbInW7ZRLKLhHhpStv2
         gJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236602; x=1759841402;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/DIF8xxMKs45jgicXUY8+fOYkrHvhQ+64uTG3AYNzDU=;
        b=LNdYSrFxdge7SQqCgpUwW4xhIjpi1D70hPwrFRrX3sacnie2mYDiHT6fvjDe2QEAz7
         MlQW+zlWxfG2f8jI07PwY91es2XcPc7IN/1a3PtnwObP4Hp6zkRaUlk4yxkIgiZSQOyu
         t2gee/qhdbxA3nwK/V8Ffi8OxZmJwEKlNBuZ0a2qvbiSajokwSAs0QFJKmN+h5PuRDIo
         L+0kwWO2BoqkX2kL/oyEczSOjId5aWatrcnF7hp78UO1qt4kGGeoBFuvwsp5BwmqLKvP
         0xAd2OxvnyohPXgpycBJSeDpD53PGp7jj36D5x65HWCptDnMBVAhiFlIW9bwyWMIDxxm
         uRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7RygSI86y905ngQHOj6pbpLBYHggEubfkhEknfMZLsA/Zb19J/lzcY5DAYmTqvhLPZIvIWppK1O3U2294EuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGfyFxi8CC6dS7/pMSbwCxA2FvSPDBHvrP9GvNHlVttE+D6wG
	9y/IbfYB/D1xfbgg97ktOnaQgCcMfAK+2G1piVB21/9Vj3uYCOKe6f0L
X-Gm-Gg: ASbGnctTZKKcQt6fkKmrxxcWg8FL8jncIdaSntUdbbxS+JO2gxMl4SuSNjDhtep0pI+
	ZO9OkwQIP1JqWt7HTExhnVcNPe6wLoX5peWkvJ79bJcnSDyZ7KXg2G3E9a6sdkIag46/BpMyr9V
	mTD4i41dliDgs+vTk5ubOMBYhP+SM6baIpIbTk6Myyxg1cKC/x/iaK1ZRWYBPkdZ9dTTfj57d9R
	xOARHlVRCVg2VMbFsjK8tpSlg5QRDAdjxw9ohhyr2IWQQq3J3mbwtR+X5vVn76HhHDmir9r6VIL
	B60JP9Et3ykmyOOd/Zdw1gEf5Sp+uKglmQ+cxJE/pq1N8r/9GkcXjx6dKCYoFneNbhpM5Uw0pHT
	5quvxNo7AA2WDo6h5JuGWUa8E7oBr9XUfDFAEMyVnacARubbp/f6LPtu7ni11SlX4q/ToCutV7h
	qlwkV49/LsS1LFPsSBuUg2Z7NXOoMrUa99gkUhdys=
X-Google-Smtp-Source: AGHT+IF3jXqpSXTJaRkGEMK7WKJd7LDbG8wy3D5EeY7LmVpdZLbKNSI6KpFy0rL2Q30+2atZz2NZEA==
X-Received: by 2002:a05:6102:3906:b0:4fb:f6ea:cf88 with SMTP id ada2fe7eead31-5acc6240067mr7922871137.10.1759236601986;
        Tue, 30 Sep 2025 05:50:01 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5ae389dd1fesm4532961137.12.2025.09.30.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:50:01 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:50:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sidharth Seela <sidharthseela@gmail.com>, 
 antonio@openvpn.net, 
 sd@queasysnail.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 kernelxing@tencent.com, 
 nathan@kernel.org, 
 nick.desaulniers+lkml@gmail.com, 
 morbo@google.com, 
 justinstitt@google.com
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 david.hunter.linux@gmail.com, 
 Sidharth Seela <sidharthseela@gmail.com>
Message-ID: <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
In-Reply-To: <20250930120028.390405-1-sidharthseela@gmail.com>
References: <20250930120028.390405-1-sidharthseela@gmail.com>
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Since it's now only to ovpn, better prefix, which matches other
patches in that directory, is "selftest/net/ovpn:"

Btw, review the posting rules. Leave 24 hours between reposts:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


Sidharth Seela wrote:
> Fix functions that return undefined values. These issues were caught by
> running clang using LLVM=1 option.
> 
> Clang warnings are as follows:
> ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  1587 |         if (!sock) {
>       |             ^~~~~
> ovpn-cli.c:1635:9: note: uninitialized use occurs here
>  1635 |         return ret;
>       |                ^~~
> ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
>  1587 |         if (!sock) {
>       |         ^~~~~~~~~~~~
>  1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1589 |                 goto err_free;
>       |                 ~~~~~~~~~~~~~~
>  1590 |         }
>       |         ~
> ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
>  1584 |         int mcid, ret;
>       |                      ^
>       |                       = 0
> ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>  2107 |         case CMD_INVALID:
>       |              ^~~~~~~~~~~
> ovpn-cli.c:2111:9: note: uninitialized use occurs here
>  2111 |         return ret;
>       |                ^~~
> ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
>  1939 |         int n, ret;
>       |                   ^
>       |
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")

stray line

> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
> 
> v5:
> 	- Assign -ENOMEM to ret inside if block.
> 	- Assign -EINVAL to ret inside case block.
> v4:
> 	- Move changelog below sign-off.
> 	- Remove double-hyphens in commit description.
> v3:
> 	- Use prefix net.
> 	- Remove so_txtime fix as default case calls error().
> 	- Changelog before sign-off.
> 	- Three dashes after sign-off
> v2:
> 	- Use subsystem name "net".
> 	- Add fixes tags.
> 	- Remove txtimestamp fix as default case calls error.
> 	- Assign constant error string instead of NULL.
> 
> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index 9201f2905f2c..8d0f2f61923c 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -1586,6 +1586,7 @@ static int ovpn_listen_mcast(void)
>  	sock = nl_socket_alloc();
>  	if (!sock) {
>  		fprintf(stderr, "cannot allocate netlink socket\n");
> +		ret = -ENOMEM;
>  		goto err_free;
>  	}
>  
> @@ -2105,6 +2106,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
>  		ret = ovpn_listen_mcast();
>  		break;
>  	case CMD_INVALID:
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> -- 
> 2.47.3
> 



