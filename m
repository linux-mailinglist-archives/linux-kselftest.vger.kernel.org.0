Return-Path: <linux-kselftest+bounces-33473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B4ABFC30
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF4E16CA12
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4663281524;
	Wed, 21 May 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bT6KtZdl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA122D4F3
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848184; cv=none; b=ti2puENcMANKsFTz97I4qJ5F60YeNnAk6ZB1UcYawXfpexdMHlGwtUHwEGF3bD0k1LpRK1D+sUPh/UbxF17Ato5d7i27uY2sJGhsMy1VgdvmoQXnsnBrandrgc/2msKqsFc0lY2ewRA4woytpSaJQZwLxTmkTtPRJrldFojRLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848184; c=relaxed/simple;
	bh=0HDB1mZctYwt/1x+gyO8mvirWFsYyU7+iUgWF/+t5Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVT/fy8Y3aBBKPe828KBG21jzSKfAWlXRf+QfTlxnp9fND2sCxE4E0ywQ03hPmw9V43Foc+OcfLZMweXoGr+53B9I2lmjMyTWlSjKNxLt4aL4f3/BJWZayBPmeUQIIT03Eq1cKqYo05HgcRQns0LajuJAKjd5OEgEZzHanm1gPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bT6KtZdl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231f37e114eso1057315ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747848182; x=1748452982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpxEducQ/ZX5Sur11fICgrAYM05G9MHT3sn7Odt8Gss=;
        b=bT6KtZdlogdw+hII7BKLq5rKf1R4Ai+5o5IoHoRw2VY46RdZ5wBbuvESBUAA9s4Bx8
         C1ryyfAMUFb4DlXRmMFsVPqGIt7ibHz0IzMlyIDdePiwCC/1cjSVx+Vo+Fv7XD8qqGhi
         eHLhmmJZKtZ5zxjfhJziLJIGj8k5Y4JHxFO1QbUXHckzBEHMqUDi4RVF/Xp7EwACwnyr
         EodBoB4cjAgHGFo+KoWuxcgVSjbXPgdY/9iVEMou5SeHpK6FC8omQBTe4dd/Z3rD/eWg
         v9HntJY0W+MGlar4PraEHCC/GTbXuFPA99lECHnKoEOX9+UoAZ3Ws0aLhz/qRupjVWDc
         SqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747848182; x=1748452982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpxEducQ/ZX5Sur11fICgrAYM05G9MHT3sn7Odt8Gss=;
        b=kl5UH/58DR1BH+MwgFDggacYh6qDAieLALOgtTtuLNNulxefc8sPAQ58VsmosN3cHO
         br4eeGUdZVzil2b7WXPAG2LRCrlqvbmSes2NsHXThJFmUVy1aV95yG4/GtD9pFDr2tN9
         88rpob6yxJhJ/Wq4yWV1G/hpbOg+DUAbqAUKF6WVsDJVANOb36pszyWjKwfbKjUMymsT
         +2w1LsJSYdvwHXpGcAe8Az68rphSDRRfQ7wEvAwDmzqspV25HvwskADNP5rMpLrX/5DU
         bBb+B82VtwGv0BDrnz3u+GqcVo54lCQ42DTL1QwDjO1ngAmCzBSKPkTkqG5j4BjlW+H0
         T1ig==
X-Forwarded-Encrypted: i=1; AJvYcCUq8Ow/7+tG01aKc3WpQUeB5FGU60uZj7gaGWVx4T1lu9lzzZ5IcU/STuSIdbBIMHIXrXx0QMEQpuWP40ICDZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFByIxcf5sVRk139CtV4NfSY1/hrpfS9W1Ckuh2d4xCXmDXm2R
	byREQI97OK0AcswZ/uBMGvaWKoN2HMwp4cI4dbvyR+RqqXVcvIjl3sjZHdXwAHwS0nh5fRq2SNr
	daiO7V2RLFmBUPLzUwiliaQIOihpINoOBGiAyBa5s
X-Gm-Gg: ASbGncul4KDHgYz42O4NaE2P0O9JeVxyqX227ozIAQaul/7HMlqIuiUyz5bgeDNb3mn
	07IlaR4WRjcW6nNoLkD3+9At9T/tLueedmXh6k5v0TuHdjLjOdt1e14s+DhMfqyY0KTDpFxAHcX
	9WeK79JTfgokMJIoVOGodgTacn6DFke6QxlteXIII6h/tMGY2lvI1ju1YVc8K5SEwPmFTkd8sk
X-Google-Smtp-Source: AGHT+IHQy1y1txowNTVDdNmkO0yuk9mOPneAGMpXbtWyrWGlg5kTnUBe78IqwiCm7Zm3DXAq7Gz4CkE2rtLd1AuzPOY=
X-Received: by 2002:a17:903:3508:b0:231:f3a3:17c6 with SMTP id
 d9443c01a7336-231ffdd4a29mr11949205ad.20.1747848182102; Wed, 21 May 2025
 10:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com> <20250520203044.2689904-3-stfomichev@gmail.com>
In-Reply-To: <20250520203044.2689904-3-stfomichev@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 10:22:49 -0700
X-Gm-Features: AX0GCFvBiMczQ9BTZi5IZOJlKyDYL8gD7ekvpiMI_rciZyfjmZfwhxoKPDFEucg
Message-ID: <CAHS8izMEaPUDnoQaYTaTMY719FJ_-Rb-Ui7ika_yZGQ70VWiVQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests: ncdevmem: add tx test with
 multiple IOVs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> Use prime 3 for length to make offset slowly drift away.
>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  .../testing/selftests/drivers/net/hw/devmem.py  | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/tes=
ting/selftests/drivers/net/hw/devmem.py
> index 7fc686cf47a2..d7f6a76eb2b7 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -49,12 +49,27 @@ from lib.py import ksft_disruptive
>      ksft_eq(socat.stdout.strip(), "hello\nworld")
>
>
> +@ksft_disruptive
> +def check_tx_chunks(cfg) -> None:
> +    cfg.require_ipver("6")
> +    require_devmem(cfg)
> +
> +    port =3D rand_port()
> +    listen_cmd =3D f"socat -U - TCP6-LISTEN:{port}"
> +
> +    with bkg(listen_cmd, exit_wait=3DTrue) as socat:
> +        wait_port_listen(port)
> +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname=
} -s {cfg.addr_v['6']} -p {port} -z 3", host=3Dcfg.remote, shell=3DTrue)
> +
> +    ksft_eq(socat.stdout.strip(), "hello\nworld")
> +
> +
>  def main() -> None:
>      with NetDrvEpEnv(__file__) as cfg:
>          cfg.bin_local =3D path.abspath(path.dirname(__file__) + "/ncdevm=
em")
>          cfg.bin_remote =3D cfg.remote.deploy(cfg.bin_local)
>
> -        ksft_run([check_rx, check_tx],
> +        ksft_run([check_rx, check_tx, check_tx_chunks],
>                   args=3D(cfg, ))
>      ksft_exit()
>
> --
> 2.49.0
>

I was hoping we'd add the test coverage without the need to add test
cases to the ksft. I was thinking maybe ncdevmem can do rand() each
sendmsg loop and send a different set of chunks, so that we don't need
a flag.

But it may be too hacky to have the test be non-deterministic, so up to you

Acked-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

