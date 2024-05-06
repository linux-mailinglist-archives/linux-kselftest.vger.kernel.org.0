Return-Path: <linux-kselftest+bounces-9555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C237D8BD558
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 21:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12DA3B230FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE77158DDF;
	Mon,  6 May 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGpr+Ki1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0A158A2B;
	Mon,  6 May 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023428; cv=none; b=Dk8Ty4m/KLuicZ4zLtZHFdHFZnDWvpVwzNx8tiSKXVoIFj2py5lCDSxNtzFavi5hTCxZMeFwxFSenJCeMe8JJ5lM2mQsMkJozsxvUX7wlhrxJ0RPp/qa6/mE3xxx6Pq0M+ASb93RXRKRvinaRFr3KA09Gu7QzsCgFvS0qEKDUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023428; c=relaxed/simple;
	bh=VjKGuE2C0thOxnAgsCwVrGWxtDbyC3SnKsv1KFItiOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bauFyQlaLraV6Z81ZrpUStqYOfrSCTmxAKQbNojHXR4/EXsnMHQzmnimlYxtOCxaowbR/Glr0c4MCtnvqbpJWCyuf4Sa6kUWnIPyhJ/F4nnBM0rFv7C31pwvldmRbFk7qGZdqdckOObaTlX5SkGGJiRIQ7lHchuANAHsm05UtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGpr+Ki1; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso1594145fac.0;
        Mon, 06 May 2024 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715023426; x=1715628226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMEDQp7jecrc8iXiBOXlaMlkv7t0FOpm2f19JeLxtsA=;
        b=cGpr+Ki1Mf2ipnnzIeaUmB2GCJekJz+FVvz65hI04tN6e3WP9AYIpyXKA2yRQwTB/B
         E3SEDeaJtPrtheIAJxEUvG6AAmcCPuRKrcsp2OO4aQO5biv+6a3N0/Yr9+j4qYHQbM+Q
         5HOTNkIEXO27sQi53M2/oq/bUHTiQcKNsovB32WaN4wOtX3/zG/+TG9+fkD5a8fKM3do
         1lpipF7AadPERi8ZGnOVSKASW9KBVz1tVRj++6/VCO0ENFS4FQzXT92GXYUMLGMfxhNw
         Rp9vcgKsXVBfsW1EqffrzQ/RBbGpUqQM8NcB9LZVKMn315d6YYFcoCuQSu9FNgfdSqMW
         9uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023426; x=1715628226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HMEDQp7jecrc8iXiBOXlaMlkv7t0FOpm2f19JeLxtsA=;
        b=NTnr9FQPHiyC7tOXGT3R3QH/Bx9aGMuiuOtHNFA3unxdWOs3PlubQMMbSfJbk+aUZe
         BqkA3hcNFMyTs6nuRQ0zWXzk88zh3frwTtf3OVYgWbSx9AipS26EheWg+IL7k+5GU8f+
         f+alklC0hLnM0dl0pjpyYn9TTaQM4+yelr9Yf2k9n2jjPZOYHmP6EcCjnqie7aFTB7gl
         i4v++rRSqJbI2Hze60hFR+k0z/sFVjJPjOVT4+k9FyE7E4oEDdA8f/0SeadAumUC6zpe
         U+WoS7mDGl8a56FesHG24qrhGtrlmclIdooS4r4E7dRoSKhz6m7jY5a2KGMesUTvexGm
         1akw==
X-Forwarded-Encrypted: i=1; AJvYcCUmnJBa9Esf7H7iz6ziDLEtvfUKX73yZNk5MHEgDCHcUv0UL7vVD5wOfSUQwqTnMpvYVMdFgMAF9qIAiXSKnJ5FSZ12VG9E56rPhTsRsUHY2FARRMoMrlq/jkTtKXHGT/r+H5FNz4jJz+e4Kx+3xsEaFIkujNCrSIAO9dOnDdtRR6lANfjT
X-Gm-Message-State: AOJu0YwreOn/linyfjWi6E9TGmNo9CfyTUtWYp1PM2ol+O2Xr/xuXt/N
	xmvwT3Ad2pwUE+6XsA/8ud0Fuv4OR7+kEXrGqpUDBkZsZeOx6i6L
X-Google-Smtp-Source: AGHT+IHf/3INeYWfNXb4/rpQGjmxAqtkFZ5EKMg8ufpMcJVGnz6iF9K1N+nuOnOSpdZrqR2k0xN2tg==
X-Received: by 2002:a05:6870:8898:b0:22e:b96a:375 with SMTP id m24-20020a056870889800b0022eb96a0375mr13017922oam.30.1715023426523;
        Mon, 06 May 2024 12:23:46 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e718000000b0078d5e60b52esm4137182qka.114.2024.05.06.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:23:46 -0700 (PDT)
Date: Mon, 06 May 2024 15:23:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 zhujun2 <zhujun2@cmss.chinamobile.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Benjamin Poirier <bpoirier@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-actions@lists.infradead.org, 
 mptcp@lists.linux.dev, 
 dev@openvswitch.org, 
 Valentin Obst <kernel@valentinobst.de>, 
 linux-kselftest@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, 
 llvm@lists.linux.dev, 
 John Hubbard <jhubbard@nvidia.com>
Message-ID: <66392e41e6889_55f25294dc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240506190204.28497-1-jhubbard@nvidia.com>
References: <20240506190204.28497-1-jhubbard@nvidia.com>
Subject: Re: [PATCH v2] selftests/net: fix uninitialized variables
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about three variables that are not initialized in all
> cases:
> 
> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> not "ip". Willem de Bruijn pointed out that this is an actual bug, and
> suggested the fix that I'm using here (thanks!).
> 
> 2) The addr_len is used uninitialized, but only in the assert case,
>    which bails out, so this is harmless.
> 
> 3) The family variable in add_listener() is only used uninitialized in
>    the error case (neither IPv4 nor IPv6 is specified), so it's also
>    harmless.
> 
> Fix by initializing each variable.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!

