Return-Path: <linux-kselftest+bounces-36367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A713AF68DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26F04E0503
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF38228CB8;
	Thu,  3 Jul 2025 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3pV2vBS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE9225D6;
	Thu,  3 Jul 2025 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751514728; cv=none; b=uMNroSrTcExQ/HhdgE6Sstu8P3rc5HuDpz222+Tj15tLQjm4YpsQoPigkUqGP3wrvdMVHfNDA5VSoHxqGVPNC4aJ9xuPdgpIOz2SlM1B4pfB7IFOeHSrbVrvO3zRvEosEeqJTrcE8dFO5+kBtCKzYxwp6Qhug5v+hCNDeRsxD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751514728; c=relaxed/simple;
	bh=9L3OxoFJhj2X6mmDuLUW7hIWdOK8GGMg/eog1zKbTbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsTgZwoyRs7sSqf2NxAr1CU+5f+/+74geMDIKs8nqhxZ90WKEQaEAtMqt9v+ltB8pgG6Le4dxlx04iYWxbWiQyKvUSjShXkVQUL3PvjZfNrPVHPCAcURgSyy+NxLRhfrQdq/T2IOlNXXL647lYFv8fl2D0l0d2XTIwsg/i4KmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3pV2vBS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso8116006a12.0;
        Wed, 02 Jul 2025 20:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751514725; x=1752119525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b02Al31mOHYf9mmDMFXOknGM6+JzXhM/g5/Uo2Yhy4E=;
        b=k3pV2vBSsWIi4cvg8yJzauDmU97vbaCDNJthNGmynjsHbKPvzRgmKsWQIik126BnpX
         fy5ax1NUgeHhJVcVlNDhsq7b/cY++lh6bExLDV9q2bVAoSLXw9XYRdihM5ILNRFLyTPb
         j9Wz01xbcmZqJj3TeY4YulnbCqe5Ac5v3mgme1lRG0Tz3wlafWvps3T1ANl5aM5rCL98
         QFMMoDwaQCswWShGNXK9ZQlWsK01O3nCdDYa0SrL46sKmP3zuyDMmK+AK/fl6RTN7Xau
         6PXvX5XF4leXDKCGPynZPTP0JdZTmlHeVbhh6lE5DInFzHrAAATP0XdOLUcMJLQV3iE8
         XKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751514725; x=1752119525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b02Al31mOHYf9mmDMFXOknGM6+JzXhM/g5/Uo2Yhy4E=;
        b=VESjkQlue0gCMX1QMA0RmtVslf3rIxO4ZoEeaGpLaR4+Sp79an1yUxOA3LKZ4Aht4j
         9HdMhO8WixA/57/bpXljzH6PT5jey/meebWAJw8Yf2JfcsQHmrJXqEVoBshO+v70egws
         SJrU83J4V+9QlhHBUfZLgqz4JT1Oyf1JykEnPultG8/R10ekLdstYgpN5Mgi+VDyLr+p
         /jaM6RO5RwLY5X90ACaxoWofmqo2/iSgbNzUTjoKT/y6fyIr1EXqJt1OG07RaQxlyCiS
         SaEDhrNMARuTLenbfPz4cD2ljdEjZI+nRT7/x/EE9oFuYwAdjQMFMueiMrrH+4t7KANI
         0D4g==
X-Forwarded-Encrypted: i=1; AJvYcCWJqI63n0OG00/RLlVRItGDAqqc3DyC7tguzbNF8Eo4bWBWMQp6e6PG+sWJ+he/y+TMq3qOG6LkOFqMXjhlcks=@vger.kernel.org, AJvYcCWpNALlALUn6fMMip4G9hy6nbpI9K+gqXt2By5O9QTf0WyT8caCxcCqaOnBL048nFpYmlGh0IW6@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbYomwSviLx1jfTG1qO01HSD8+QzJ2IDZmyt98WZ6mZCGysUn
	WG1UB1q+ItFAOrCqpAP/iz2Y6kwUDGO4M4fEKPE+QlNcZ8RBotFJkhWbrv3Me2UVIG9OMmCJ9ww
	O+eNTDTrLT66rW9i7IHtukO0jOU/UG2s=
X-Gm-Gg: ASbGnctzxUJI8g0H2JOQxHNWMUNqCl9KLYiSZpm3j6NGajTtrwsZ5TSpAnId7HplGO2
	Ye8xcNBmB66DtuB+Z0VBir2esyfONHs0/BEF4EplDCqv36Z2GZwJImW79lH8jTQIw6OmC/zyjzu
	3oKmzjZrcrHM+92vRdboXpiD0sdS07HHM2NmWUqqdwVCtWYA==
X-Google-Smtp-Source: AGHT+IEW1jWDQ7cVWvWC+xl6RFuTx5QAXvi9aUUrYkVftaVUM78GsPULsQVqhnNZ0iUGuPRWaPs2zIbQsJRCAYxiySo=
X-Received: by 2002:a17:906:c14e:b0:ae0:ab3f:36b5 with SMTP id
 a640c23a62f3a-ae3c2a6c748mr583244966b.4.1751514724973; Wed, 02 Jul 2025
 20:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702104249.1665034-1-ap420073@gmail.com> <20250702113930.79a9f060@kernel.org>
In-Reply-To: <20250702113930.79a9f060@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 3 Jul 2025 12:51:53 +0900
X-Gm-Features: Ac12FXzO98GaAsaJAVUoLTm5FA7ipupBexnpOgJODdq4yTy4ZCtkvHc8QYIFgrw
Message-ID: <CAMArcTVqsD_sbXTM9JLDWgALNpYdj=V_Xyp6Lr3dpWqc93P+iQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, shuah@kernel.org, almasrymina@google.com, 
	sdf@fomichev.me, jdamato@fastly.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for your review!

> On Wed,  2 Jul 2025 10:42:49 +0000 Taehee Yoo wrote:
> > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > change it automatically.
> > Therefore, make configure_headersplit() sets hds-thresh value to 0.
>
> I don't see any undoing of the configuration :(
> The selftest should leave the system in the state that it started.
> We should either add some code to undo at shutdown or (preferably)
> move the logic to the Python script where we can handle this more
> cleanly with defer().

Okay, I understand it.
I will fix this in the next version.

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

