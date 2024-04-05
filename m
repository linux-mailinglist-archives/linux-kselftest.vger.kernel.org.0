Return-Path: <linux-kselftest+bounces-7291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613BA899E4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844EF1C2238C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBB16D4E8;
	Fri,  5 Apr 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0dpdXlM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5C16D4E4
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323808; cv=none; b=D+b2Vk5xptuH/HyZz13kbvXEdZDujv+Ypa6slCrfDA6qx3UHVSjCHbp5IoLDxP8o6EV4EGEkKZy4peYIj0VOfQyA2BoAzKJJEbVGmdWzrMnHwwcx8UPsJt45ngQKGTqZjt2xMV4R64FgCWo8kiPfqC/i5FkUq68hCPpRpV3qVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323808; c=relaxed/simple;
	bh=wSswXutQJ+wCZIDOdh13zZfPNpNOZaTJPxJxnSQYIrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntnYOs50vyB6uQ6VsRDocC9dcD20tzRCubiBYakuV0JwGcmuVbbmevpRiZPUvrkhKJxxZBmpt5EhgDkMc6GCd80+UKJC0dNPrwsIAxbYyW/foRx/VILCGUpu/g57VHr0oSKoUVB1sgU1+s5/Y0h8I8M53tBAve4PtBIWgQEDz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0dpdXlM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so10437a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712323805; x=1712928605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udhYzo9d/0PPqGVdd4D3LGjxi+bDzO7RIJlIIFERmQE=;
        b=h0dpdXlMP0f9BdNCgI3z2niKFXY9IYX0Nco1p7nyhoLd2RFtzrVsqFiIjztlGdKcx7
         wcyCekVug7fXUGKUXGx5ORzxP1flB2jj7auYgifZZ5v5fInbkVYHYRKdln0OP6jYD3pi
         Xrv6ggpi8FVSsputPRghJWQWJ4s4eEaDTdjH+Rlq4RVRJIs/Rx5AlZgSVKEi3h9MbmGa
         gQtPAikTtw1tQDjJxSxH/JL0aOakrB+KFbmYjCdKmLPE1EyobbmSLJnyMPbrkoTqX5k1
         CUjKDAqTaF/mn3kknxmnVsUo4HaIa30jD9yu2vX5fUmOMLvVRCtdIOHp7FG2/lBbYGJN
         ORxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323805; x=1712928605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udhYzo9d/0PPqGVdd4D3LGjxi+bDzO7RIJlIIFERmQE=;
        b=bl17Q6WQncINaaNP1ektsUywpNTvUIajNOLl2vJQDwyWUK7r5riMYz6sC3G7R/rL44
         /sUOOPwf5N33ZqkSt8atD2YAnmQuUSoU6qynx2wT3pmiUmcUDZHJpQYm4cMfNfN3ris/
         xcQOkGX7UvID21Qu/EX4F9+Lb3/R2vKf3WQH3MoM4qNfuql7aFg4Yw1ES6FtpAqWCWa/
         JNx5cidvoPa24GqpH925CtsY3uetFMeQS6YO4xRAMf81AiSGLcdzrqelsCHGOZA7FoT7
         9AfFmiqIUX9iVN4BZ/0LlCpEHkfjXNYwujh5N4EyErKbgP3Er0nk/lU40LBuht2pyEa0
         dmkw==
X-Forwarded-Encrypted: i=1; AJvYcCVnrYtydSkU0obs/zB3Zv7jeqWERLGfcsHWOj+gygwQAlwEKURMKbeSWONa7YY0ErFU4Ge25AZ2ZzPCBCg4lLIBAAVe5MlwRHpeDO2ewYiQ
X-Gm-Message-State: AOJu0YxxxuObGdXdtCfXFePxpXftYhksoWgC5ViAAKOJoGd36a9M5q1C
	qB/2k+4b9jhNiet4WWAMx325wxRd+W3LgpHat7f1gllY+nHM99sSGE1IMjtTVEmUvkZxU3/AcOe
	K0k0ZiQhwnyBzdaFobO72HDBTQpc/7QCmfa2/
X-Google-Smtp-Source: AGHT+IHKnNwfoWVM8o54afDpZXoYzLLS0/kJjLYpGez23Xun7fuG7ohs51CmC+MLEwtVWDcCBP1C25v11O1H+kvmdgE=
X-Received: by 2002:a05:6402:26c4:b0:56e:22b4:fa72 with SMTP id
 x4-20020a05640226c400b0056e22b4fa72mr347542edd.3.1712323804808; Fri, 05 Apr
 2024 06:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
 <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-1-52dc49453649@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-1-52dc49453649@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 15:29:53 +0200
Message-ID: <CANn89i+2TMNF7chYaDFEBNRng3iLPaXBqXKNtZYevDd95-PqmQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: add last time fields in mptcp_info
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 3:06=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds "last time" fields last_data_sent, last_data_recv and
> last_ack_recv in struct mptcp_sock to record the last time data_sent,
> data_recv and ack_recv happened. They all are initialized as
> tcp_jiffies32 in __mptcp_init_sock(), and updated as tcp_jiffies32 too
> when data is sent in __subflow_push_pending(), data is received in
> __mptcp_move_skbs_from_subflow(), and ack is received in ack_update_msk()=
.
>
> Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_rec=
v
> exposed with TCP, this patch exposes the last time "an action happened" f=
or
> MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv a=
nd
> mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
> deltas between now and the newly added last time fields in mptcp_sock.
>
> Also add three reserved bytes in struct mptcp_info not to have holes in
> this structure exposed to userspace.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/uapi/linux/mptcp.h | 4 ++++


> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 73fdf423de44..2ec2fdf9f4af 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -896,6 +896,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptc=
p_sock *msk, int level, int
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *inf=
o)
>  {
>         struct sock *sk =3D (struct sock *)msk;
> +       u32 now =3D tcp_jiffies32;
>         u32 flags =3D 0;
>         bool slow;
>
> @@ -930,6 +931,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, str=
uct mptcp_info *info)
>         info->mptcpi_snd_una =3D msk->snd_una;
>         info->mptcpi_rcv_nxt =3D msk->ack_seq;
>         info->mptcpi_bytes_acked =3D msk->bytes_acked;
> +       info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_a=
ck_recv);
>         mptcp_data_unlock(sk);
>
>         slow =3D lock_sock_fast(sk);

 lock_sock_fast(sk) can sleep and be quite slow...

I suggest you reload now =3D jiffies32;


> @@ -942,6 +944,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, str=
uct mptcp_info *info)
>         info->mptcpi_bytes_retrans =3D msk->bytes_retrans;
>         info->mptcpi_subflows_total =3D info->mptcpi_subflows +
>                 __mptcp_has_initial_subflow(msk);
> +       info->mptcpi_last_data_sent =3D jiffies_to_msecs(now - msk->last_=
data_sent);
> +       info->mptcpi_last_data_recv =3D jiffies_to_msecs(now - msk->last_=
data_recv);
>         unlock_sock_fast(sk, slow);
>  }
>  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
>
> --
> 2.43.0
>

