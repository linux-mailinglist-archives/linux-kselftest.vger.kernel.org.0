Return-Path: <linux-kselftest+bounces-45661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3AC5E957
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E459F3A4517
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD72BD5A7;
	Fri, 14 Nov 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Awmdgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF97285C9D
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137416; cv=none; b=dEKZUfjijpfPyRVE7VYYapeGfvltlfVuPsZZFGTXAGM9KYfGZJwU0derIGjWujy/7SrhkfUIKNG7dH33GbTK0oKx7lcUrYl+Jc3CsZMMmqeB6GdvGCHHsJlblTJ4slEi+WoD9qfPFvInmk8yHhmNlkA1mvE4oup2W4RlM8au7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137416; c=relaxed/simple;
	bh=08UMhVekfnzODHg258j6v7alIEul93sizWVdqDK755I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3sgvFjviIzL2PKF+ZPYDi0dUe8jDGS0F7/6fYAkn2t+D8ihTLE2JE2/zGZbkJvFGRFGrqFbJ249iOJljMWQ5JwP9DCHH+5ZwjwtvkIj4W9qhu6pm4c0O2x3DCbsvGiFYPok66YLsrFVVITB3IiRo21uoM2hMJe003vy21j+SxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Awmdgx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3434700be69so2747455a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763137414; x=1763742214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YlbrZzTl/MWfTO6W+9TMn8CctXsku7j8hxAqkLvD38=;
        b=f8AwmdgxSj9eznwehU65Xpfe113Vl494Cehacz8/OilpO2fZMb2QgIDXwhZ9GuJsMf
         NBtqlAHbhwf5XKXHxS+IEP5l9hEi4uhe8Hx6pjm3IkcITB4AY0c2AHaV26VO+CKyeMtU
         3D826JKSqgye5b8aizBshN1NhDziQBDyucTefC57YgG6za3U1DoWhqTvve8jp8avessN
         b7n1zVS2bX82OZzusK3r7Zdjp1TQsNbrOl6rIAyBWlIRofEieprgk3JouLKYjeMXJxe/
         TxlZXNRE7KYPJtW5nQE6DwTipfdB7KPozN7Y3M4xKLCI5ic7VmYvaR7ME0AmmwGgEjs+
         S5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137414; x=1763742214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YlbrZzTl/MWfTO6W+9TMn8CctXsku7j8hxAqkLvD38=;
        b=JdUuW74PlfXkjx9FUev4QKmCs0qnCxh7tA4ZP9Jb4T9opZ96cYI0I0vakHeqZts3vO
         m8j9MDjAGHFncq9irdVOQFtyN1Cbofb3vFa8Ur1d3jwpBecvTbopva1g5V3a8DzN7jRA
         L9fO4UHGADu6jT8A92+AYBunX5DtyKz0OQAoTT3s7sjqXWYBhWNiOAzPGYWgrKttUEvc
         Inn3Dxx2n4r+nLU6PgIjd7f5aupOpXue6ys4/QPk733xmvj67r85FSDm2Edj7N9pILNd
         OA98GOl+wrJ6daaF8EjlULRJCuqKSIBMtgDjDnu0R3f4hfx2ZAkBQcOcKUwy5TicUeij
         XvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp6LXdMW5fsuu8eu0upYplKgqTy2s3bCSY8/qE5KLNrFtl1wOj4L41TIyRuur2F5sZHrPbhCRCOGylkI1gy1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx3yU680eP8Z+hvvs47QMh3nohIYfQwI9umboLn6xsSD1nX/F
	frXG/pQfP2RPArud9kafNH3JPVV9SR1lV0NDSPFnZ+VRFpM/TgpxvMQ=
X-Gm-Gg: ASbGncuzyud0G35GypKF1Cu3tdYx/P5boctbtKhYlfSHVIL9n+D21XpQPSofQ/w2cd9
	ESEPHRWo/X81jDC3JCzzYIjWX8TfpnB14cKoZiATgNw5e7LmG4pNnARXh509jm8L1kFM6STnh7K
	dgQ9KxQVx/BsmM9Gl/c+NLsna81xmULfM0MTOSBNxgT7BSw9zVLuM5EIq1dRYmIvQIUDMKoVyD5
	EYjjDdeak+4Z0WHhOIhVGGFMYnkjPpYjA8Prv2b0ZSxkD0Ey5OxsjQuoCqKmVCY3sea7/4WXc9k
	a+lTqeFrmy0GKSfqxaKcJkyKAbjHP0V4EN0RpnyifXYm26I+IK1Jx0l6+LwNPAVzW/yxGqdqnWD
	5kXhQ2W6hdmAtOqtWghO9MDIqXxlZ/NzFHYdqjcfYq1eIdi3Ig94DAb9NWxG2dmP8MWrhM76ySH
	bEIe3j8vucTAHXZzIU5G2wkhcAp0kBhS8hOKdQSnJwmubthN4KcydTQrIfOanTL7HFlvIiTTR5C
	7OfNx7W4eddlih+zrNrU+7dsKmFeUCha6XiTnQHf5uYn6MNqU2wXPGHvdFAK5iWjvBeBC0SWGk7
	OQ==
X-Google-Smtp-Source: AGHT+IGmHmCEt7ubcY4pkEZLszbXZLk6Ci4T9fQqgSf5JbWXKIXcZ0Pqm/APxGewYx9HSHzcYBRGmQ==
X-Received: by 2002:a17:90b:2dca:b0:340:c179:3657 with SMTP id 98e67ed59e1d1-343fa7569femr4452805a91.33.1763137413401;
        Fri, 14 Nov 2025 08:23:33 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456511fa6fsm949975a91.1.2025.11.14.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:23:33 -0800 (PST)
Date: Fri, 14 Nov 2025 08:23:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ast@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: xdp: make the XDP qstats
 tests less flaky
Message-ID: <aRdXhE0a-P3Ep1YE@mini-arch>
References: <20251113152703.3819756-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113152703.3819756-1-kuba@kernel.org>

On 11/13, Jakub Kicinski wrote:
> The XDP qstats tests send 2k packets over a single socket.
> Looks like when netdev CI is busy running those tests in QEMU
> occasionally flakes. The target doesn't get to run at all
> before all 2000 packets are sent.
> 
> Lower the number of packets to 1000 and reopen the socket
> every 50 packets, to give RSS a chance to spread the packets
> to multiple queues.
> 
> For the netdev CI testing either lowering the count or using
> multiple sockets is enough, but let's do both for extra resiliency.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: ast@kernel.org
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/xdp.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
> index a148004e1c36..834a37ae7d0d 100755
> --- a/tools/testing/selftests/drivers/net/xdp.py
> +++ b/tools/testing/selftests/drivers/net/xdp.py
> @@ -687,9 +687,12 @@ from lib.py import ip, bpftool, defer
>          "/dev/null"
>      # Listener runs on "remote" in case of XDP_TX
>      rx_host = cfg.remote if act == XDPAction.TX else None
> -    # We want to spew 2000 packets quickly, bash seems to do a good enough job
> -    tx_udp =  f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
> -        "for i in `seq 2000`; do echo a >&5; done; exec 5>&-"
> +    # We want to spew 1000 packets quickly, bash seems to do a good enough job
> +    # Each reopening of the socket gives us a differenot local port (for RSS)
> +    tx_udp = "for _ in `seq 20`; do " \
> +        f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
> +        "for i in `seq 50`; do echo a >&5; done; " \
> +        "exec 5>&-; done"

TIL about bash's /dev/udp, interesting..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

