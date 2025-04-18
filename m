Return-Path: <linux-kselftest+bounces-31137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B4A93A50
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD841B6537D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E51214A6A;
	Fri, 18 Apr 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f4qIYwQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A51213259
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992432; cv=none; b=OWwIt2tCUh9Df3/VwKTDrauU9YMvNggviS09m0SZ8+U1SaAQ4BTkBeSws6wQvN2jFpeC5ri3BUkTzNC30rlFpCQWVVtwOw0RwOa28DW37iR+fsK+EgktS2cyCqyzOeItrt/XnViZFEAcug9Di1x+SbcF2/WbQLKGdN/NWRdtMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992432; c=relaxed/simple;
	bh=mJDJYr7lVaC8wf49jlEbGffCUgODVQ8wlaVjxXpd9NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bE6OKNmmCzgppeC5KS29eD2XqUjEy8/JxpsBsqFABzHzH5cVww99cEkrIOh6s4Hwlf2v1nYVSL6XchYgMPii+L+x1pxOseETpJm7sSDCtY7aDNF7Zh9Db93u8h+cjrPGSdE/ATki85lOYskZ0ut1CRB2jCEnWss2NwBbIbaUvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f4qIYwQc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so3042624a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744992428; x=1745597228; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJDJYr7lVaC8wf49jlEbGffCUgODVQ8wlaVjxXpd9NU=;
        b=f4qIYwQcWNfstcEj05cGQ6wxM6ZVHkbgt2n8qZ3xy5J5HxdCEqKcsnWGOZrvjMRT1I
         a6x2Ko6aVbvtiDzRGEveqOi3v3ciEG31INr1o/O9VkwlPy25yYLK/r3zEnym7lgzP9aD
         is4fHwXQupWP7/coXFHK0uFfKSHeW9hVADg8zEl5GYHN0ev3XCBzYEhH8lUOkQstrF4T
         nRq/kdKQWdJ41TEiznqhRPugV1fNG+ZDBu49p+5mF4z+6WaQdtcNVrn9WOOit/OikQ+T
         rjw4SxM5scU7cbvD8Z8icpnZgetRXCbk/LMlWNfnhA/dozN2T3PTUEzN+r5BI+hBfDvR
         PRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992428; x=1745597228;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJDJYr7lVaC8wf49jlEbGffCUgODVQ8wlaVjxXpd9NU=;
        b=Fxsa9uU+OXHHMaqw9YjsZgG3+LZlPf2BeHPeY7nBWADEtuAjnRMpk9Nfo+ngSVzTGf
         rToZKia8gbOT69b+tTURxi98UESbbjsBRRVuN+ePOESVv6IT4N0BZh0gMFpQBSGnO3hB
         4ISc1kpfSMhyta9m4iBmmm7YjjKYKbDRMS8kIX8tro4aPnl3d/pnSTFW7uQofEMVVZsX
         9xbQ8PzfxrCn4L76Wl9Pho1opEIjk1rSl+g5FF5qryWVBgRuUcpPuj+uPqH8G6ZC9bMR
         yjhDiYwngHW/t9yF10zmx5XHGhISODkzDPdzlTg6DwbSxdIOxQIWn4Hyl0KJOT3mQaSC
         zfEg==
X-Forwarded-Encrypted: i=1; AJvYcCXR9C8g1rNDD974RSLACOczqKnH88uw1/QJZmbFBaLbqwZ50NPdnC5jQgvF209gN+li+jZSsBzTW5p8cCqyBr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJSOFHmipoXj7sIY/m+i4tUDeG1t6LewwmZJx9GYM9bmf+Umjp
	GTjHRJXGz3m73YGXRX+f3iOLftlgubEyFxoixDVUdIGyJIpA1XwtUznb+Xz3ZWY=
X-Gm-Gg: ASbGnctAu/t8SpGUzVTLM+DgTGxr12SdrvIZAyA+ecm7U18tewTiSCpcBci1TTegeaT
	a+5pO9mfMiRD7idYb9vMRAc8o3KXi5G8pdtTcYGMWySMC4vFTsoz4bmPx9RhUNY5hi54NjbsMbs
	ugHwbVznyLPbV5ZY+vAuLzm2jL6lbVTj9OX+ozT04F1x5uZd7TOon3NObSt0MdiHOVstUUcuyQb
	WAgCx3KL+oal/a4xRJMAEQl7UDYM+md2NggiqD1rwYFQdoQQi5wIfwgpIQ5Qywn9EWR4vKyJWgx
	yqAIkjzXHuIyMBu30+LwD8lY6px4vq+hXQ==
X-Google-Smtp-Source: AGHT+IGA0mJvYWhzAc0oNHZeKO+KGsF+25BJMfzQI0JM3A/aTXEi+UCjUxCGApuU0msTc2ARl0raKw==
X-Received: by 2002:a17:907:1b22:b0:aca:c6db:2586 with SMTP id a640c23a62f3a-acb74b18d90mr295654566b.14.1744992427833;
        Fri, 18 Apr 2025 09:07:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec10011sm139200266b.14.2025.04.18.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:07:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/9] selftests/bpf: Support af_unix
 SOCK_DGRAM socket pair creation
In-Reply-To: <20250411-selftests-sockmap-redir-v2-1-5f9b018d6704@rbox.co>
	(Michal Luczaj's message of "Fri, 11 Apr 2025 13:32:37 +0200")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-1-5f9b018d6704@rbox.co>
Date: Fri, 18 Apr 2025 18:07:05 +0200
Message-ID: <87ldrxa1xy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 01:32 PM +02, Michal Luczaj wrote:
> Handle af_unix in init_addr_loopback(). For pair creation, bind() the peer
> socket to make SOCK_DGRAM connect() happy.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

