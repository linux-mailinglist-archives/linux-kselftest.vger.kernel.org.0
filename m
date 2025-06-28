Return-Path: <linux-kselftest+bounces-36031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC0AEC5E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5B1BC37C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112C22577D;
	Sat, 28 Jun 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B08+/v2f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38E221725
	for <linux-kselftest@vger.kernel.org>; Sat, 28 Jun 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751100304; cv=none; b=okKyvRtQG7m/3NJOmykmryQvH9JJSBcm4ggtw5JCH2SjZsPOgxvHhDpGlLX0eDR9UvBuJxtOtOW8k+uarNwrdumL1NCRoKWpSXF/lV1HaSrvwcG6Hp4xxIy89az7eL7lZ08LdY62GhyvMzSEUzoPhpc00aptrQ0Aai2R8kfjBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751100304; c=relaxed/simple;
	bh=f3o9OoZUEbBDeBbUxOB3GnLGKqZpAG8HFhx3v3nlo/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZC8vKCOl7ahsrpFqAQN1PryDSPecAyEwXtVArU3PbGeE8O2DugqXj/BQRMHB7f3pnCvWo0wYfqM1Ky1DjxFwYFKGF62CPV1Yt/+fza2csa6un7N5YYr0WhK9TBEt3qJKRsYHqof60VTFe5lszm4bRFB3f50CQlf2VVcdpy44fWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B08+/v2f; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a43972dcd7so7879511cf.3
        for <linux-kselftest@vger.kernel.org>; Sat, 28 Jun 2025 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751100301; x=1751705101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nmnfrusCNXdjpYHJ43O4MY52XtsNNDAe7B32gXZR/A=;
        b=B08+/v2fGg+9DMi96O5lWHnkIwL9hBfG/wZVW11A3dfylVQAL7PBgRCbPFXewsYolW
         TBOPcyswj4KZIA3xmvaUE3mScm81a1s1Xg3IkUvcShQSgi10WLhImnOKPbKQP+0c9kN+
         NA/19wHB6OkvJYnmEH1Olmu3rsHPSbCsOxJ2dYdPWM8IO9p3NLF6phfpO1TjYKiR9qlz
         Gf6JBgLNnYVnsO1okmSa9xLVtEOOG4yMg/tn7QMq2oixJch0oRuiagCEDZEuvLUW5NbU
         8Ik5rbUzyAbfojkRH2WYm+HS8X6Zq8+dWOr36Gslq5o8wuN4aPC8wZNS9xW0OVoTo9W+
         zQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751100301; x=1751705101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nmnfrusCNXdjpYHJ43O4MY52XtsNNDAe7B32gXZR/A=;
        b=jlX1qv2ONUHOMcaFB5EG8ztwxyB4EXfbGw0OwWGHA1hfXf/CmjcBh9RLzRafdCYLXw
         UvqQJNTR0mENEWk1BqLanCZBUZPHBVA4gie9W0znuNkoj3s0SngmiGRd4sgwSMFsi4kK
         h+FNLMcQJHuFajF4S8u5nBjdwusbPeiKSOnTT92h87U0TE5DB01MZHXwtvwxzxKZklJ2
         r6igbzm7WullwMh8tGMBP98psDuZzNnyy4SM9nOR3v/3uzTgdXIYTZ4f+Li6B/GCi3u3
         OiuAINLWI/iVLHcNYJGD38Fjy30u9B58rZBf/bdIFVyPb2oyOH4kUKTCs6prHuG3pJ9Y
         iOsg==
X-Forwarded-Encrypted: i=1; AJvYcCVYE7C+jxPY9fqDaWjS6jnzdVl/di61ZwypUscYlQVNgQaqxqia/kE3cYC7ikEfyGEA/4VMSEZzYVxZrfb96pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlumXp1CFWW7JwHWaZfHd869krzik/cxWXiq6+kvNHa50ikTg
	zYQRdo8gzR5tQmDD94M8nGX7lveVuJAFng/YmRmSUSSDr+TiLfVJF5guZe/gaX2JqdG43JY/eVH
	hL6w1+Bt39WE7KaI3J2VIUp6MRwBE9+CAib/WVzUd
X-Gm-Gg: ASbGncuyVWDyZLOZi6T0JLFnlTneyfcNAPnd57ASRZ5PuJNjmQXrQEZ7c2Vc0Exdzhg
	tzVaum/FSB8FhCtCtK/qXsfNENpFlDoYrn0l+HfTvrJdPLjKlgFY6Q3aUG6DD5tD9q6rCDl0wm5
	Sqz6+oGIC0lcOpnXO8iTQbd+d9iTCuJbVsNtsCy4ZGnrED
X-Google-Smtp-Source: AGHT+IEOmVnyFajIJ8a0GhgPX2/JYD/n70Gv15+Urivpy9ZmnV3HQI05bvkqKXfOyYfw16w5ldtEaRL1UFR0A99MQpw=
X-Received: by 2002:a05:622a:1a27:b0:494:993d:ec2f with SMTP id
 d75a77b69052e-4a7fcab93bcmr96209851cf.12.1751100300350; Sat, 28 Jun 2025
 01:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626083512.GT1562@horms.kernel.org> <20250628081918.523857-1-malayarout91@gmail.com>
In-Reply-To: <20250628081918.523857-1-malayarout91@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Jun 2025 01:44:49 -0700
X-Gm-Features: Ac12FXx7HbqsaSi67Ecn8j0W_HA9gHLw_rRrRWO3BQVTSD-WwmLZmje0U1gXKqQ
Message-ID: <CANn89iJUz2EXu_h-YbiNswixHo6z1EwcmQrfSk6o-MmBznWfWA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: net: fix resource leak in napi_id_helper.c
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: horms@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 1:19=E2=80=AFAM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Resolve minor resource leaks reported by cppcheck in napi_id_helper.c
>
> cppcheck output before this patch:
> tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resourc=
e leak: server [resourceLeak]
>
> cppcheck output after this patch:
> No resource leaks found
>
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  .../selftests/drivers/net/napi_id_helper.c    | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools=
/testing/selftests/drivers/net/napi_id_helper.c
> index eecd610c2109..47dd3291bd55 100644
> --- a/tools/testing/selftests/drivers/net/napi_id_helper.c
> +++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
> @@ -34,7 +34,7 @@ int main(int argc, char *argv[])
>
>         if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt=
))) {
>                 perror("setsockopt");
> -               return 1;
> +               goto failure;

client variable is uninitialized at this point.

