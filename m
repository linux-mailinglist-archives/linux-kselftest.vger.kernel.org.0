Return-Path: <linux-kselftest+bounces-46401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC478C823B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 20:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A84E79CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC2723D7D0;
	Mon, 24 Nov 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHlXhYsw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF82147E6
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011084; cv=none; b=KH0z6Am6DZnbu2g1qEPWm+QiDRSGnCcb+M8YG6ReyLMLfowQa7k5ODhvbOQ0f19GIjMUJ9+CpIYQhtGWewG96brRqj2Xum/SyTKzN1X2LP2Y3oWH53cQJ6zVFxJHYCq721MVWIUAlpmy45sj2ioDMDo2KqoGs5WXosWWqO/62ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011084; c=relaxed/simple;
	bh=CSQKuJk84tG5ZuWblxkRtwsJUOaSkI60JAWLrWLe3bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm+/Kpa5+g3qD3VBvEETVcvbVNr+KP6l2+5ixP4zpIGVsVKrdc0GkhroU6JTOzbQSJstQ+WmG8w6gHyqBbneLw+EaUK8J17R7DDWWtoflk0Ncef89TI1rKIFPcJFGdeNGsCgshgu9Ln4vRFqkUb/QVz3Z8BjapFVQN0S89WiSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHlXhYsw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so3950860b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764011082; x=1764615882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR+6r0zKf/drbXIpCKmIt1A8MN9jIT0Qrpcwq+dE+OU=;
        b=uHlXhYswLIxZZc9O+ELh8/kkyszDHsygulhXg5vmgqWPufbMyBhd/X+PacxI8OLiRc
         zC5RrB5LqUVeAWcJd2juQhy7vrXNeknZR56C2L2EsS9LRuu6YSQS/j7YXPLCozJng1VI
         neg7EX5tF7UbjLqc19CqP7jczM2F5REvpSf0CzVy+hQCUbmuDA9j6IZ6XrRG4l/KtdK+
         Xvgc7UyTZeVjWum1MtXcaraqzT/GNXoKefJDg5/5cxIbBlRkVztmvDieyFWcAC2WnlFd
         oMi8FTF9M/Q3nmmi4vAlym6lnLHJhmwEVWy0vt81T/XtLDX+9KJjrb+3PsApg6bcW/Cr
         WCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764011082; x=1764615882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR+6r0zKf/drbXIpCKmIt1A8MN9jIT0Qrpcwq+dE+OU=;
        b=NMA3bp+VLJ+LIbSMXRw8RsKqdFYNsKGhnKTtaIr66CYXcxm9+4tM3FR/EOcabJQH59
         ayJMU+I/h9JdDo5NtAG7mVoWhOQdW3XDUy/7x7QI6RnHYc8zWlPNPB7FCNzjpFgSkHZp
         iORDCbYs72pEzCucLrwNm38Z5J8DMVeb06QB843RFr7GL05X1VqlDVYvJKme+OZPNDOt
         F0nG6HTc11b158mwLkxVYHCA6rvTC6VEwssQZJZUgx7xy73HooeYc/xijun5QxcY4Zjf
         SJyN+sxH5wYtHJKEMvZkp01M5pXJANxNXni6gIkzfoMEO8ZSFS2u3mgBMqn24jV6Bd2G
         nIdw==
X-Forwarded-Encrypted: i=1; AJvYcCWjqwN1ry4VK3oEPRn0miRLBuY8BnT/QV04Jy/06RrBJK2R7wn6AqBnofEtMlr3mPB7EQnuV+fBIQCp6RPbl7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPl+J99jpMaipf+XmHZa4XgRdVMiL443nRSv3pU0nflSN03Sa
	SYiYyv88oRZExxfKvZJxEkxSpMQqSZnIyti8r0mBT254Unw0VwRtjFfcpp3bcuIo99bpekGGleU
	96K6ARNoRDNNDX+MeYxT3v291xuUTE3yR6WlG++Zp
X-Gm-Gg: ASbGncv0+YfrsEEJH3WcO7i+adDI4pDx4405dCMFmpevI9rBJD4UV0LnBD/7V8w+ImX
	rbsM7H9Cji6cI7pQ11RcAB6Dkdkc5zF581oV01Czv6POv3WqoMg9Fl30Nge6JKxCxCNJJ3bf0KC
	PIGhC3fZsWTSyOY+bZZ9mvrQJJNK9LcDAXylPEnPhTkTOUKd15fZyDM388SEZkPUnCuU/GAKnr0
	gXFB/cpwoUlD0VG4em+bP5QcxZ27cHOs6F+O5RFwv5M7p3LvWkqbgFUiC+8GXVE9FXDKsdJTab3
	3wfHE4qwqQPVHjIyHyPjGo6VEg==
X-Google-Smtp-Source: AGHT+IHh5m3hlVaahpzcudnWQ3fCeNJ3tekhi53iK1WM2SS3hAZv7gdQapj8YFpy6+Ki/IsS63hBQp0tvIEyLcMAXZ4=
X-Received: by 2002:a05:7022:ec85:b0:11a:61df:252a with SMTP id
 a92af1059eb24-11cb3ecc587mr92399c88.6.1764011081678; Mon, 24 Nov 2025
 11:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123021601.158709-1-kuba@kernel.org>
In-Reply-To: <20251123021601.158709-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 24 Nov 2025 11:04:30 -0800
X-Gm-Features: AWmQ_blSdvmtWJwNQ8jGnk9Px5x3RGff27Wq9xqCsiFfSeVUkAeaeoS6umNClMQ
Message-ID: <CAAVpQUDBGYf_2vt3yjYO_vPFyV_bH8rNoNJAAxiSb2OhpXxKkA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: af_unix: don't use SKIP for expected failures
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	adelodunolaoluwa@yahoo.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 6:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> netdev CI reserves SKIP in selftests for cases which can't be executed
> due to setup issues, like missing or old commands. Tests which are
> expected to fail must use XFAIL.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Good to know that, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
> CC: kuniyu@google.com
> CC: adelodunolaoluwa@yahoo.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/af_unix/unix_connreset.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools=
/testing/selftests/net/af_unix/unix_connreset.c
> index bffef2b54bfd..6eb936207b31 100644
> --- a/tools/testing/selftests/net/af_unix/unix_connreset.c
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -161,8 +161,12 @@ TEST_F(unix_sock, reset_closed_embryo)
>         char buf[16] =3D {};
>         ssize_t n;
>
> -       if (variant->socket_type =3D=3D SOCK_DGRAM)
> -               SKIP(return, "This test only applies to SOCK_STREAM and S=
OCK_SEQPACKET");
> +       if (variant->socket_type =3D=3D SOCK_DGRAM) {
> +               snprintf(_metadata->results->reason,
> +                        sizeof(_metadata->results->reason),
> +                        "Test only applies to SOCK_STREAM and SOCK_SEQPA=
CKET");
> +               exit(KSFT_XFAIL);
> +       }
>
>         /* Close server without accept()ing */
>         close(self->server);
> --
> 2.51.1
>

