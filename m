Return-Path: <linux-kselftest+bounces-15293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E035D9511E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 04:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EBD1F23637
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 02:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB61182B5;
	Wed, 14 Aug 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E91PY0Qh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B661CD06;
	Wed, 14 Aug 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601523; cv=none; b=dYr9w9L6fA4BgYXEkR5LuRbkvkXr3QSzIaFqMXN2oS1uU3diQVxXhMunHB7lCxRN2SJfy34n0PCAYj5UPDmyE6DRilUqcziJfyRG1iNLFJAvV1tQ7cVuUbna2zbBIGkVbOpp9DBNERi7oZQAmnNPK3VrZOK3ivTrkIxgWfS2LcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601523; c=relaxed/simple;
	bh=qjWNxatVepm9lmO+9FgXCva7g5Nu5Dg8pKaKKJ0IaZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE+keru5zwvK/obBDWl70QIGFogcd5vhY/16npg6qoPiMdSeSiwQA53rdGcllKgrwwCqThANzGxMcQueGlsXzLMz7QpxXaSMTs2jV2pK+kppjBq4LM/34/kA6P3tCIB+4Jgp8sRwEyCh+hL4Xv0EwgOL5TAwZiKXgjJq0WParWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E91PY0Qh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-710ffaf921fso305290b3a.1;
        Tue, 13 Aug 2024 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723601521; x=1724206321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgQt2+VGAGY/RroWfxhoKY1UxciJC2B6QVwLu16mYH0=;
        b=E91PY0QhHecGN+fgsE0mKtaSMJ6kZAsP2oeXqOaRbPggPOB9zG7ymvfkPNbq+8OtdV
         h8Cl9EimMTbDGJARLJXkBTRGqWM/SHz6W3WD+y9I0Os1iYn+w6R3FPpOWYWHB0E/SMgn
         DwUsxo2XgY/YrZtRz1Drlf1H2f3gyYwxWEN0KCBwr6ZXH9TexacY9w9omipvWdU2SYFU
         yB0PMU3nugGJ9XCwbv8Yv1qh35KwbWCo/6ZRH+orieN+vmaeYN3GRHjHuVh3rlS9D5iS
         t+lHjS4mhWpzrj9TYPfBaCZvFzsgQUWYLLTVdOaHUegc0/wPa+7BBT8xNGQjAtBMEkrH
         JBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723601521; x=1724206321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgQt2+VGAGY/RroWfxhoKY1UxciJC2B6QVwLu16mYH0=;
        b=lppxgbgSD/d57dHFGCk4IJkn5MpFdWWeZ+tn+8SmEKs6f8tAWyK4yjefV/StvCDg9p
         +JWVuayv8KWu9Oz7bMRvx5MPtzgwcpaCMCcEEWwT1ZGKKxYWDFahE59bAqDNLLDJBR91
         0gefCxhBYjQxnti03DrkF0q0qAA2xNTgn4iS2REklphZXErzZ7w34UjaQA/tmYMUj2M1
         A9mAAnm1qCB71rY5kCvek2OYKpsRK8IfAhwfOIkb/KmxkCb0b5ZXqxB6cSmVrnZeYdCT
         RQYcKYe70ZcrfNwiRwtkFhV8XlHaAIZ9pfdyGh9UPuzBkr7sC+VGrZp4K+nDyqcwIP9k
         GYBA==
X-Forwarded-Encrypted: i=1; AJvYcCVdS5Y2xZzA/mmENx2jH9pGzOuVINHio1Zp7WB2I5mYExPHBMSwPCx90p6pRoZv9vBi7y1TlHhHiQU3BcUSdPae7zTlWW/y0EPlbN+c+sLsKa+mic/7nM0sWM2P8qPru+6lcbfonLkBim3W00PGMOxMHm1ok/G2F8fXRF/gRwJgmWnVoCcV
X-Gm-Message-State: AOJu0YzePsbIPRlldkuIgrwZlk7QYNqcFTu0M7NO5IfqR1bXOneBsOaA
	Vw7slS8KeZUfOUYQ6E8seprpjmoTWexztRLBrhBx/liZ3rqxAQTk
X-Google-Smtp-Source: AGHT+IE+JEWKhfRkf5F4tu2TR4+I4T+y1Sh8oOhAQItB9Y0LNz4oM5JPDKC3DoLO2lBxGaMuMQmtkw==
X-Received: by 2002:a05:6a20:c889:b0:1c4:779b:fb02 with SMTP id adf61e73a8af0-1c8ee9c68fcmr1101408637.21.1723601520808;
        Tue, 13 Aug 2024 19:12:00 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a99acsm6363636b3a.71.2024.08.13.19.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 19:12:00 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:11:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>
Subject: Re: [PATCH net] selftests: net: lib: kill PIDs before del netns
Message-ID: <ZrwSZGj-BgJJADaG@Laptop-X1>
References: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>

On Tue, Aug 13, 2024 at 03:39:34PM +0200, Matthieu Baerts (NGI0) wrote:
> When deleting netns, it is possible to still have some tasks running,
> e.g. background tasks like tcpdump running in the background, not
> stopped because the test has been interrupted.
> 
> Before deleting the netns, it is then safer to kill all attached PIDs,
> if any. That should reduce some noises after the end of some tests, and
> help with the debugging of some issues. That's why this modification is
> seen as a "fix".
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Acked-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index d0219032f773..8ee4489238ca 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -146,6 +146,7 @@ cleanup_ns()
>  
>  	for ns in "$@"; do
>  		[ -z "${ns}" ] && continue
> +		ip netns pids "${ns}" 2> /dev/null | xargs -r kill || true
>  		ip netns delete "${ns}" &> /dev/null || true
>  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
>  			echo "Warn: Failed to remove namespace $ns"
> 
> ---
> base-commit: 58a63729c957621f1990c3494c702711188ca347
> change-id: 20240813-upstream-net-20240813-selftests-net-lib-kill-f7964a3a58fe
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

Thanks for the fix

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

