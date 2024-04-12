Return-Path: <linux-kselftest+bounces-7860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492DA8A3607
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBB1C2091A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705ED14F13B;
	Fri, 12 Apr 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw77vnIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C114F136;
	Fri, 12 Apr 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947951; cv=none; b=EQ0YAwq0ePIlOb7bR/OPLQ1NpzzectJnMKm5xThHwSqQR1qLq7lASJnQoHpcZNaoBjLroUqBDrNIEUPoT5GFGnWietBkQbiSinBw1KDZORNfBDg0Xy8BP+8HYuAHstGWhb82PADONXBfw+zeCr50pmcfyTyc8Pb4YsG8yrNS5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947951; c=relaxed/simple;
	bh=mTcXGw4nugqGSRxGCjG4A4MX8meoxqzJ4oLOi0eBJCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZ65762ykOET7F3fLpRLuINAFfBvGCCJZXZRTK1AoF+LcMViC5IUZg/jJNbl9WEEi5uetghMryV2oT6l69k2Ae5ERvpYabnGN4nhAC2b27c34noxkmd7VDPLhmpBUwTMBoSqiiMeW0wWrH3m/SE+BvfNuENKsviMpEOrAzJx4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw77vnIE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso1469287a12.2;
        Fri, 12 Apr 2024 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712947947; x=1713552747; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHtXmJuMK5U+UHjTruXgW8Ixfi7zQSR0MmnJiv0r0VI=;
        b=kw77vnIEi+zHV3UZgsZWA6Rcvd4XAXaabBAWCnGYVWKNy8qVvdQIOxCcuyjnG2lQpI
         XlchWN2t7WvQHamDZSU4eC3a/YS13pw+trtksQfDrnvk+9oCNvX7VLv/GF4S91lZxuqe
         JFIBqQW4zPiEw6ztMYlqYYuZlkcgaz6FAvhjt/qZQktFu/a3IhsTS6f2ZaKvYBpPfmIz
         nClSwHVIlArTh/wKiKMHza3X2va3NQyD6119k++SaR5QpbiDKVTgE60s9+AgIXuT8qsF
         pBg3Tlok0k74a03YBoxHCD6Wzm/s5KJkj/S8wZ0Vlx8haQ4c5Bc0Xh24xMwNPFArTaaV
         lftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947947; x=1713552747;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHtXmJuMK5U+UHjTruXgW8Ixfi7zQSR0MmnJiv0r0VI=;
        b=qDrL8uRFijMKuGPHm5ZLxJeaOVQRE0seah0ew80CvsIbyt++wKf68F7IBshBw8/Y5s
         Go6N3NKe6ktQKuelUv980QYb9EQOT6Pcf8Ea4bqnQGqB4nIImGsoSwGkPY3FKytcRhlN
         TQwHzXDgXihxk4x2Ufn6V/T1Q47PBoasTaCOYphOqEtoTMRJk8T6tY3mupX8dS3VoQtH
         QAibgfBIDuYoMJ+VgnmXiOFg5QRD68cYsQe+CqbeQn8FM2P4IFJHunmQs4c5nrnvLWxw
         UtNuiPI3JsAicQdwCrDEjQRLxxTNRglfvIJDsVr91gdXPLdo0dJAwFIgMV6Evuj22Qdp
         Gkrg==
X-Forwarded-Encrypted: i=1; AJvYcCVMjELUIHkz31t50MnGnttxJVPBmsswTOVxFgflrGJfuL7DnFdwVOhaXfZxRAyQO3skTBne6dolNe52PaH/iN3NauUdyCTly8gDXZ5EPstDTs7KnK+eIYg+QkDlpWC38Vx+6R2t
X-Gm-Message-State: AOJu0Yzd6jh67pI6VCU+m+fluiWLDwxSMw4921Xp3AawrOKlGpvS5L8D
	tT4Gv4+MOTyeWNi+EngcnH4L9MZ78zgSo382VkZSkbc4LTPlGTO9
X-Google-Smtp-Source: AGHT+IEjJuMiPSy1BzMREQ4B6uMKfyuDaIcn1eUOa6GD7uqmlWt4T9TGBAfSFgr/vI5sXt/kYtUMgQ==
X-Received: by 2002:a50:c05a:0:b0:56c:2785:ca34 with SMTP id u26-20020a50c05a000000b0056c2785ca34mr2212442edd.5.1712947947132;
        Fri, 12 Apr 2024 11:52:27 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7cb86000000b0056e3707323bsm1917169edt.97.2024.04.12.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:52:26 -0700 (PDT)
Message-ID: <905e8d82b369b5de22936c202b19d783f594c33f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] use start_server and connect_to
 helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 12 Apr 2024 21:52:24 +0300
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 09:03 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> v2:
>  - update patch 6 only, fix errors reported by CI.
>=20
> This patchset uses public helpers start_server_* and connect_to_* defined
> in network_helpers.c to drop duplicate code.

Modulo feedback from Martin and connect_to_addr() not setting default
timeout this series looks good, thank you.

