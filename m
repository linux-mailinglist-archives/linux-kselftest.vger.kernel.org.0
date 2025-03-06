Return-Path: <linux-kselftest+bounces-28427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5BA556D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 20:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D1917621A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B52144BC;
	Thu,  6 Mar 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUM+hBqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701B1862BD;
	Thu,  6 Mar 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289712; cv=none; b=oz/4StS1z9eo55frrGKEx0Yxh0BPucFNXHNLPEy5aRE6QvYb0jvqjXI1VMY7dVqpuhFIonp+rmQP1rTo8w24W5rxRQPJ75zSMedI9fgT0EJ94CnDKr2qStotxwEI43BlYWt1bb9/JV0+Gn41qZJVRUJ3BYTKseSxvuSuIWC6x1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289712; c=relaxed/simple;
	bh=eUBRx9zrJOuo2cMJ67QLDl5g4eHEppyXry99Vimhyrw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LlEaXO9XNt9cR8M+PVqJkZJQIVSPix4u5xzZhilaxH6sBIerY7dfgRuVd8X58TyovyftAV7wkPcM/JqSffQtSLSBBT8EI3ta6twcpLdiieagW9QsAqtwKV9WrcrRA26IGqDI2Nr3F9FyctevoOUwI3+zvEg0yD58450BvZt8Br4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUM+hBqW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f4503104so8220576d6.3;
        Thu, 06 Mar 2025 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289710; x=1741894510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nncCfojn+eOfHNfAM38v/adQ/H6A8XS9sVQrG87maOM=;
        b=CUM+hBqWjCEson0+oD8eWiTtER1HZutxXSmPwUMyz0jfC7nFMa+4Mfur4KLTOOlC/V
         pZ4aSU94BPSmg3bOHmdimrgYsb/IkIkhNUXh73UQ7eQbYnw4Y83KAWm17BuS/U2Y6ysi
         WSCRYv82BYzyHqfSjs6W6HtQtPWk60fSgX0Y33EtGWRf48x1DZ9l5ZJVtG4DI0GI58SV
         L168eVZr3tkIh27SFsU1XbYGkn8N9XBMknlV/amQgcoc8rWPQpsryPrdCqc/SX8u5nJK
         Sc6axrXgb8GqNNDow1va57LIMS2qy6bH3euvm4pWAwDVZ6+VE9HMHsM0vX/W52vJZcBW
         CIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289710; x=1741894510;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nncCfojn+eOfHNfAM38v/adQ/H6A8XS9sVQrG87maOM=;
        b=C7xnJvvi81xRHXUqlyQAb117hy8RyguAMxlN0nJ2/2JGOzBOEAMoW2c7qp0scUvMji
         0R7XLK5mO9n3kbWNkUSJdhjdHthf7mH8/73RYYAveNp7TlcEde6SiBPpySwhLOomxbSp
         wjzWKcKneqd08lE+5w88ZE0pK6yLJpIZDxgeu1jUv4RIvLU7UsrPytEw9S7706dZoBRd
         CZQOg38iImx3tUP99Mn47IE97og20aYH9r16qK/Kpvhw8HpNyB3i2NnOUPKB6P8ZSsfJ
         6Py2iqrmLfK0HQPxuROKDRKoKUuaO8t6Nv6+4/aW163lkWRkuRqBmbqwK+/Z1MQBLwDN
         pcww==
X-Forwarded-Encrypted: i=1; AJvYcCVe87R0rvwHvYvtEEzS9JOCpJmXUzc0vlyqQH+WLGUJpySgi3iud9nSJvDLrbBgPkdBinQW6r2AqgSAAt86O0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0SZ3nlQqCGylNHFUO5c2FYu+h2FPeWOK9CVMV1iKDS9vj8cs
	Wd0A9CDhIT3U4D2bS+oQ8iotPQ7dBEm3w+ugWlaykMb1VcjStqY+
X-Gm-Gg: ASbGncvLdz48ZnU4KjesusP6xcYG6Vgkx0YtBfODypdIAXphnJtUheAqoiStUBMW+gY
	N1VZ8MYb0LlNvm2qTA9r5mrGdmjsxc9IHAMUhYG6PG9RqqNWtvwcDAFW+jQKP3eJAtupz/RIc8d
	zWY9o7PhkiKXEq1Szq5wU+ZhNJsNXQY4b8qEJVYTbxjXogXHLgVCrf2k6MAvDlEJI86NXNIWQ3s
	e4Te4xgWfCSbZibFwnhOKQbb/22Mh/TUPM4PBAuJn0pVypDtzM0RBYMVTiKwtkrGFvNBG22Jsah
	PzqlGNYDqRrTK5mj2maPVpirtSfLwdN2Htc6XcqSuJTYBxk3Ib2cE+OsBtjaqZUrGXxXJPM9BDS
	/09VSVt44GBBFiixGRKLrGg==
X-Google-Smtp-Source: AGHT+IGgWNnrb3K0RdtbFdzJTK5KID8LLekqZUhrHo/sOGw4xMDVR78n4rCAIQfrFlTRQ1obzcx4rQ==
X-Received: by 2002:a05:6214:da9:b0:6e6:68e3:8d84 with SMTP id 6a1803df08f44-6e9006041damr4717946d6.18.1741289710173;
        Thu, 06 Mar 2025 11:35:10 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090d6csm10412936d6.29.2025.03.06.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:35:09 -0800 (PST)
Date: Thu, 06 Mar 2025 14:35:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67c9f8ed24f9c_1580029416@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250306171158.1836674-2-kuba@kernel.org>
References: <20250306171158.1836674-1-kuba@kernel.org>
 <20250306171158.1836674-2-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: use the dummy bpf from
 net/lib
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
> Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
> the ioctl path") added an sample XDP_PASS prog in net/lib, so
> that we can reuse it in various sub-directories. Delete the old
> sample and use the one from the lib in existing tests.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
> index c51ea90a1395..815fad8c53a8 100755
> --- a/tools/testing/selftests/net/udpgro_bench.sh
> +++ b/tools/testing/selftests/net/udpgro_bench.sh
> @@ -7,7 +7,7 @@ source net_helper.sh
>  
>  readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
>  
> -BPF_FILE="xdp_dummy.bpf.o"
> +BPF_FILE="lib/xdp_dummy.bpf.o"

Just curious:

How does tools/testing/selftests/net/lib get compiled? The other
subdirs of net are separate explicit targets in
tools/testing/selftests/Makefile

And what is the magic that avoids the need for adding bpf objects to
.gitignore?

