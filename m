Return-Path: <linux-kselftest+bounces-8830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F18B1883
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C01C214C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 01:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87678E56A;
	Thu, 25 Apr 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RccAAbAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C426AB9;
	Thu, 25 Apr 2024 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009388; cv=none; b=HWgoYru1c3IXPfakxxLeEYFyDuVNL5ser7OhHu3fzzAmhdNBHYcBP8kZF6pM9loBOMwaPsh82O5VjeWDB+Jzk4Vns/rzSHi3mnbyk2eZ+tfUSfRuy4R5QRmPD5nK9zfXs4THMXGikV41xKcC9APEh9BINNuVk+CuH2DiNtp1vgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009388; c=relaxed/simple;
	bh=WTiS/OqaxaKqgUfxTjUllxbnKiWSzcXskK15D5kUzgg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sCS0tB6V0s4+s2oVIHrsNwroC50LnNiV5+U93MAztwv4EPdIvHLlBK5c9mtGai5fBfIO6cHMjTF8EA9UcRPU5tObiTPqc/mATe03tdWpODumSFzFDMZBdzJdXpzb+u4tcKNoxW0U2Z3RLn2VWNiw0Bt+niUKyNkeNgZFSUwC32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RccAAbAy; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78f04924a96so34237385a.0;
        Wed, 24 Apr 2024 18:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714009386; x=1714614186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62NZG8CsMCdvSnNIt6hH75YB5ujg8R6XbQq14L7TtKc=;
        b=RccAAbAyQyyA+PCbb1tRZX0iWIYt7MEEYE6iwish4XWk5h/sVkab+tifmXcecHKP5Y
         6TI+J/4j1hEb85nrStGqS54K2d2MPFSUOfaA4cb7pRpL0kHZuDGuvmb5BBQakVHjWtg9
         76K7JXEgGLl1AP3QKgO3PzcO0fFiwXczRcCT0T0Tao0QLtjp3ST/99KFhZkI1eujjVVN
         n0vf/Io9sp/muOaOEO3oLzBg+NfMVN8CZ7AsPwJHGb85AZHvLAiyT9s3ZhPQLNcFj75D
         jb5Ht15SqKoUchGfzmBb1y2MVAO9ttDY3/Yianm0W9ahuCzrbKymJxzugU34oQSKBS4k
         jHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714009386; x=1714614186;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62NZG8CsMCdvSnNIt6hH75YB5ujg8R6XbQq14L7TtKc=;
        b=k8hyccGTBIuPUVkW5IzyfmwZGgTJMS0FEyLVZlP4IKNooDZKDSOQfumj0wZUqaYii4
         HWFOjx7uPUkRnOgUKuinE2Pl53ZnsEGmuYfRxV+9dPJiv5AWyRy1Dy4dDUb0ZwtXbEWr
         vv+s04K3i4iZZmsy/6eJezWXibnDP5D03Yo7do404iRRch5Lkc3gSZW/x3OMbxg9oXVR
         1u6upxMweXOLz+gOAFDa7qz0a2Yc79MwTkdgyna+P94hpCkuJRD9TyCRfcU+PdPPKpZh
         5iO189ltHb1Iz9w6P82hF7u2/ijKNk+DgafCHlKXt0Z55pQ8FPxAckGSMK653LMcqJCc
         W/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6K4poEeuSmvkOVkWaSIGkeketKb4gEeSbqrq//NR+rWtZotgl0/iT4kSG4AFLsSc4Qd3HEqD0vOARduyywQZFgtmPpszc6ePzeHxtz2x
X-Gm-Message-State: AOJu0Yx2qTTE4w+Wd+CVgy1B67qwvjvCN94r+gmD4wdxwDcVVw3gH8+x
	3FDF5hBeQvpxWR0pu2WcXAfDr5PMdW/s6bwqpXI7AsuLPMCJGk6e
X-Google-Smtp-Source: AGHT+IEiYL2fun9BuQAnFIi1BOvG7WfKdfItEt3fc6NbTxbcg8hVKzUxt7CIU4T59bP61iJDVv4kCg==
X-Received: by 2002:ae9:e643:0:b0:790:88e9:5b68 with SMTP id x3-20020ae9e643000000b0079088e95b68mr4322051qkl.2.1714009385771;
        Wed, 24 Apr 2024 18:43:05 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b0078d54a6bb76sm6581094qkp.117.2024.04.24.18.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:43:05 -0700 (PDT)
Date: Wed, 24 Apr 2024 21:43:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6629b5291e1a7_1bd6b0294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424221444.4194069-4-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
 <20240424221444.4194069-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/4] selftests: drv-net: reimplement the config
 parser
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
> The shell lexer is not helping much, do very basic parsing
> manually.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/env.py       | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index a3db1bb1afeb..a6a5a5f9c6db 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  import os
> -import shlex
>  from pathlib import Path
>  from lib.py import KsftSkipEx
>  from lib.py import cmd, ip
> @@ -16,17 +15,20 @@ from .remote import Remote
>      if not (src_dir / "net.config").exists():
>          return env
>  
> -    lexer = shlex.shlex(open((src_dir / "net.config").as_posix(), 'r').read())
> -    k = None
> -    for token in lexer:
> -        if k is None:
> -            k = token
> -            env[k] = ""
> -        elif token == "=":
> -            pass
> -        else:
> -            env[k] = token
> -            k = None
> +    with open((src_dir / "net.config").as_posix(), 'r') as fp:
> +        for line in fp.readlines():
> +            full_file = line
> +            # Strip comments
> +            pos = line.find("#")
> +            if pos >= 0:
> +                line = line[:pos]
> +            line = line.strip()
> +            if not line:
> +                continue
> +            pos = line.find("=")
> +            if pos <= 0:
> +                raise Exception("Can't parse configuration line:", full_file)
> +            env[line[:pos]] = line[pos+1:]

Or line.split. But bikeshedding python is a deep rabbit hole :)



