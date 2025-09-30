Return-Path: <linux-kselftest+bounces-42634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60117BAD0F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832EF164E06
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B13043C3;
	Tue, 30 Sep 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjgiDAm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D4230D0F
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238934; cv=none; b=EmiIbtxQNTDhqD/hSd0H8NyDZPAk4hK+6kp03kkku5+eQfxZEPwp3h4AD+e9s2y6TA+w2Us5B47I0ZlN83Z2OMY/noTIhOzpYSF6AdZ0fb91vU3rsB7KMmPpbrRQZDb5FAKmfjTdxhtyqZZx8TYe8YxXs1yXOyHumIF3fgTg5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238934; c=relaxed/simple;
	bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfoBOU4DrNbBRqNfx/mkchrMQ6M/1a69ljU5Q4e+pc2YvX9Kmwqi7exyNe05sSOBbP50b515T8ODBO1TPbdNhE0VWpwzcKHW/M9zfEWlpFS9vg9gw9VG3iKP7PPuyrYJiV3xc6ss3c6wVvjNvyyf/Qgu+nDuS0Rmz08IVqJr0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjgiDAm6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c2db014easo543126566b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759238930; x=1759843730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
        b=YjgiDAm6eY+UkUSBYSZn0Sk2Ax9nGsWUueV9rmcCSQkxCXyKHNC05yRmGQZGTlRFNo
         64Wo4iN0ACEQ6Edm8GeV7V8OhtjJKwnfOsZw63k9YxVWi7CH7jtDS/Mt9QoIqKNWmlfo
         yovJWq1q9BqUEyDszpShmrvqPvDqwcHCbfo2t8km/zSiN5Pbc9cMc/MUJSYGCsOPKIwC
         OfaTRfIEsGRVFWvaeP17hOgf6JC8vZW3LoXXaQDYzbRMWpup6OB5H9U/N3EWN52+hASb
         8m7slGXb4WWnTIsabL5ZOu3mhj03hKBGdarlBbyudTPuJBANNRQ9ZsXpXnF9+CKx0sB+
         iyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238930; x=1759843730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
        b=GV/CQMMo85IvVmyfHBagIoq5ZsWoqyEg8m2z+jW7RFaOxs/CHPQ5JzS4wffECX3kUc
         t1O12efAk4nblwzMnlacGdmxjKoRYTCZtqjIV2iWkoU+tpq+Jxy1Taj3uQlZ9MCDGsbI
         gCsc4TevsnX7M5OjlR8/G8F9D4jJ88nFnbjsnhecePjXiKh9PBxirgffVsosM5hyEVkj
         ZX6145/jU77GWpcVLSFiS5nPQXSkUr+3cqF2wDOvODDpyX518J4DQHF8nkbcXbsP7mze
         FzU4cgRBhr/XiLCaNy93uI/EsjzHujOh5mPX5Z/kB0/gAAkUvL0cdePtO6zxQicAHvz9
         xqfw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+b/4J+GyiHj8Gjpuu3XGgYfZcjTeXgiJ1n8rXuaRx+4OiDxvsROaIK2OCjT4AwpfGIoih1Hw1cQL6yqMxT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyllMHRzSU+Sik1gNdCUVIvvtxi9WHKtFNPNODa6k8znLpBkQpe
	gRBsfNV5FDejn+BFc2Wk3c1vMk+NKxHqt7oHfnYdCNjlSZW1TCaPjj/QWjT/H18bjZho6NF9dki
	rjNTMO9fOlK+iLw354c9eyZHpoBEzaCA=
X-Gm-Gg: ASbGnctPH3w74TScfTVoUp0qCYZ6ZEktxxqm/8QG0J7er94f92w4w8tXpKOZNjGBO/t
	oEF1Wi0yuHLjw0wqN09MK0HvGROS4l02gJJTsdWPkk2PleH4nKTaxt4QCztpEuBOI3KcpaB9S7W
	jj27WOw+HzPltPT4LKMYRM6h/Zq+WrMsfSOPM/jmeTtMV5MYlJG2IO74nKrinTcXe3AbT90VEfh
	nQ+iDdOVd/1erjb6b8PZTVNM5rNA6yW0grkjQVRzTJeGvCx00ps+Seii+dNTiHxifsxWbIiVxjs
X-Google-Smtp-Source: AGHT+IHaQVYd6ImpL5YTGVs15/2JsWNu+7AeBWUGR9qjk8XTSmLtzWaty3ikvQfPDC2IEaImvJGIcGSNpk+GMDcILok=
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b34b6449b22mr1942736366b.5.1759238930230; Tue, 30 Sep 2025
 06:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930120028.390405-1-sidharthseela@gmail.com> <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
In-Reply-To: <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 18:58:38 +0530
X-Gm-Features: AS18NWB4ZnK-hPHM15k8TTyVg96siZ4T3dlet_JRM5E66GuSMxv9aaJCvUWVRAM
Message-ID: <CAJE-K+BN8iAShdMkPUATbDD5pAgSrMUakst2+OzOvH3WkZWEfQ@mail.gmail.com>
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:20=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Since it's now only to ovpn, better prefix, which matches other
> patches in that directory, is "selftest/net/ovpn:"

Alright, this makes sense.

> Btw, review the posting rules. Leave 24 hours between reposts:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Thankyou for pointing me in the right direction.

> stray line
Ah, will remove in the next v6

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

