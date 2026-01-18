Return-Path: <linux-kselftest+bounces-49306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F7D39780
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99ABC300284F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F3339705;
	Sun, 18 Jan 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDxtI9r0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41332FA18
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750736; cv=none; b=HGKbAmEmU+9R/qQIX5nENkoU1g6kwotKNWse/WcFfH6XugIxR/4usQpMgGe3WJ2whJOswOD5UzbMeeQU9x7+PmUqD8OGQ4W/uIfGhDhHxyhXf3OmtoLiXRa8ZIXRPPvtP77mclQTuzRnphJngNtG/msFTXrTkT6IBCUT/2O2DHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750736; c=relaxed/simple;
	bh=0Uej8siTetp2YLvKaTM5RSla4++mF7x4i2p8I4tQn1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqtXGld4iMPr6Dfvly8pMu+YEqqsayyN39WN5XcZ+gQrehqZgs2jRS6CqHLc1IbvP/kxERM1iiQMO3psLKn/Fnd9YULCs0VjUxlSq9LG9ori+YC6sLSYPytPrlm177eYCoD0Em0pTm+Imsr1jaBDYsdlvbSvRXMny31pJ6EBmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wDxtI9r0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-502a407dabaso20006361cf.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768750734; x=1769355534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekBEaeQvrWnA6L1SYJMBA93Tf+NpCQm7MMEmfh561wc=;
        b=wDxtI9r09ZWa/UuKS4mWFceyXYXcgWuTwpoigAZUS3e+0V5Fd/CKLJV1Bd3VRaaBSo
         mQ2seHmdOD6daVWfEvLqSb4UUd2OXxWcqZnu81Bmm4zibxgtbehY5FJkZl9zkfuvd7B7
         Iqjm4eYnw9UMlYV+vjNRNF60tmI8e5MzsAv9tcRW18poqu4v8GXTBjWam9Sg74GxKxws
         Y4+bYaOKSk+alOFcseBrigLXudzxEoPQtwtRy9TDihZr0B3aHDrj7FtFVAQFC/Dba2G1
         ZIEAWSYUggvcmykLKzH4GdEgu69x0tuMa8ikDNSl/gxzUVgc4Lf1DYVTpkPVuOdcAC7d
         TYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768750734; x=1769355534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekBEaeQvrWnA6L1SYJMBA93Tf+NpCQm7MMEmfh561wc=;
        b=fggqwDoqpVF7o8EG2Ytk+tv3mcq7QFyA3Uofe/jcR7Ik2AZ/hWdyh3Y8viWA+o+ICl
         VT/HGzybmQ2PL+2unxwXu0tS/6Keo26DqJdp+PjNbcIIKoCP5ocbpW3+qhu7EIjPFDy+
         m8jQKxj7ah6K2e78Lssyk+CNVTNJso7NZJd9KQtbdOU9g5L4wW1ZuZoSuf9Ns1DjJ49G
         2j6odksjAcpyg9dl5JM2NiL5OHWUqjx7MecU60vAzLpVWgSePrViuWpwnEY8mjolHhS9
         C0Lt0Jwa+nxo86ViULz4MVq0HHMAOVMJOuO8cqIyDwNzF2O//MHCdYnuukxRr6ilPEJb
         lwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAtwlrlTTbSc0JUe2aKHWPaCdNoG7gMaMBXydr3lw1WAYM5DLOCD11ms3vxS8GLHnnYZQRIHDvrNbE7hAwwgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXFySnPXTEikNXKX4eijI2qX8DrV9ijXGo9Tm3zGy+abqN574
	pQKHOlZda/ePbiKGGt5qMakxz875Exp1cfCw1BFz7jsRWxp8ecqOGShimok7Hlyn6stLeH44opg
	LmGMbaLjFjvU2HG2wqFfIIFVQI8aKDhzndQgSMe6D
X-Gm-Gg: AY/fxX7hLp0iAbWkgBkkjtdEhJtXpAKUzcjSVo1CKlKMj+0C6jyZ7iq6dKlb5MV/Lwx
	5WxbeZgrHSYaaq7+CS5PqFXHJB4hSxT3OFYw9RMgbwEulddFmMWGRJEHYS11/7GiMMEvw8MHynS
	H82bZl9+8R/FAzPawAHosbSwJDoTlwy3fStO5fANfRk4E4tXpTwFVYCXK4o0iM7u5uIsbZcwGcK
	hUumvZDUQdhGY9sBweex2FRd87VJRIfZN0O0K6Zs/62GN6bosoWlr41FZalWhuV0FQAnlA5
X-Received: by 2002:ac8:5e49:0:b0:501:b1d8:6376 with SMTP id
 d75a77b69052e-502a175951dmr127639741cf.76.1768750733402; Sun, 18 Jan 2026
 07:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118151450.776858-1-ap420073@gmail.com>
In-Reply-To: <20260118151450.776858-1-ap420073@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 18 Jan 2026 16:38:42 +0100
X-Gm-Features: AZwV_QhyLegESAi2BlCRxeQq4zvDdpzfT7LWa_O9LTFy9T7y82e2tFRcvSAOWas
Message-ID: <CANn89i+Zd2W_u665D=MExotaHtnnyqu8Z+LgfbDy2trmtqcAkw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: amt: wait longer for connection
 before sending packets
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 4:15=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> There is a sleep 2 in send_mcast4() to wait for the connection to be
> established between the gateway and the relay.
>
> However, some tests fail because packets are sometimes sent before the
> connection is fully established.
>
> So, increase the waiting time to make the tests more reliable.
>
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  tools/testing/selftests/net/amt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests=
/net/amt.sh
> index 3ef209cacb8e..fe2497d9caff 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -246,7 +246,7 @@ test_ipv6_forward()
>
>  send_mcast4()
>  {
> -       sleep 2
> +       sleep 5

1) Have you considered using wait_local_port_listen instead ?

2) What about send_mcast6() ?

>         ip netns exec "${SOURCE}" bash -c \
>                 'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000=
' &
>  }
> --
> 2.43.0
>

