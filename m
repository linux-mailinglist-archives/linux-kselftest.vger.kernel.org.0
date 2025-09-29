Return-Path: <linux-kselftest+bounces-42585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B110EBA9E79
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C13A50E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30F30C106;
	Mon, 29 Sep 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWJBQvKT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5030C0F6
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161531; cv=none; b=uWS/prP5WzXIAiUHWPZqHzRSfRtRVtOual/DIntZivwCPivHOjM9ExkRO714Q01U86n5V1pcIsScl7OVsHygrTAIia1odSSShyzhA2qAlwEDJOFkFq6LJOJSpZqSG621FjBtMRWMm8dhWHGmsA6V4ECjNOcXRNVvyiT1Q6ralDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161531; c=relaxed/simple;
	bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4923dZ0VdCxRRMvW288IEOtIf5AXbLrPj5S90b3Ap8d81iC4/NPo+pbJq3Mgft5AiiXTsweysuM7E+tpAS9X5vSsFLktW8rogDJgdmRJq4aDjQxQutaw5jjP6CkI3GGJb0sOuzzyxx2mZi/sdBRrjnb4opP3LRpPSxwfR27pUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWJBQvKT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07d4d24d09so952430866b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161528; x=1759766328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
        b=ZWJBQvKT9Qc5PmNyldyHZaLCt3fwNojyu977328l5tFx8x1FT10gVhl8DQFhgpBpuW
         wKoP8TajHfA3LEezjyvdudvDtyJpPLd4nQ1l6EP3rMvjgRT97rWShu2jP6YgeH+jMSiT
         jZGaBmt3cPJneNkKbaLPDm/T6/JnehPZQNrw0DV/+8/BVclpkEUyexlc1wjjMhl8OX+c
         /JNPJQD4vKsVnFs+StQM92uXQWiyG2+KlJVF+8Fwd+Yg/b6SSUnbiDnUC+4bwW+U1pSh
         4rDQpya8OMl10l91QqpUNLfYXD2bEYp8XZQ+Qh25jHzLL9NnCZ5RcRJcAbVMJFDBzaNO
         /SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161528; x=1759766328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
        b=cc23joRwVj+l4kNhUI6dBLTpNw9Bf1eUFkHBYeEA85KlisuwdFU3OEetzTMXRsvG8C
         sZNAl+EOc2dVpBfQSwSUwCNfSMGPAgiFNG4ehsAZrYU7JkQ6ugchHUgleDe0iMpGUA2R
         VnHmmSgYf8/it5D+/caD6VykonZuAqYV78h2mmSNjv34jGOfeC0xw1Q0oHnrkaMBEGKP
         iuskw0dB4m1zIYfxe/9Y+/TgirJtqF/2h04hNzDgcsxjztgxF9jVy+myKy+wkh8wxwmN
         76X+zFcXFHyDEdYFqC4Tdjgzwwhz2iYFdJUfYKFcGSqVho9GIOcWt7O1yZZ24ACpWPRE
         JAuw==
X-Forwarded-Encrypted: i=1; AJvYcCUJwREI4JjSCmkIfCqAgi2dN8QhzlOgHjOyHPvDj4qTWxcK3WuZIyMBmiFdoohLzN0gvey9EPJwFFcg5lL5q4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgufB2LjDCw/oKKnTAM9BcF86HFVl+/rj1xvkKVhsFSUXCHV2
	hiJuIirb0WRc+XYG3IODvYJ9OSGE3IPrK0tzc6HU4tXET+Tqm8OorewFms6wAPW2gAyfafTH2eR
	uomRbyR5HdzYszp9OW0MpSPAGmhIOvNI=
X-Gm-Gg: ASbGncv9nI5Vc8SEuIii4UCOZ6sd5ml3jhq9cD74btqG8EsxoVqvY+M93oEiy39BBO6
	2eGP5mdjrEzO69NkZ6Luu0reAut4LTfaHFFuaKWOGK/+Vn503PP2rspuOmec58rvZ72E7NzzgKA
	HbOBL+h8RgPYj9Am5xyFZpM1AjI3KRxJzxTonrfUydcbp0mmatKMMKfcXN5+7izs9IqUpbdFROh
	TybyQ08T3ZqlmmhgS2yWc7ATLA2RV/q2tJo8SF4NQ==
X-Google-Smtp-Source: AGHT+IEyCADO6J8WiEBVdrcDX+0EvoZzPtvlyZ0fcAEpiz0fGzu77FQXIwzegr8XJ0+/55shLRsQasieeKC3kMA42EI=
X-Received: by 2002:a17:907:9706:b0:b3f:6e5:256 with SMTP id
 a640c23a62f3a-b3f06e527cemr412737666b.32.1759161527436; Mon, 29 Sep 2025
 08:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929114356.25261-2-sidharthseela@gmail.com> <willemdebruijn.kernel.a37b90bf9586@gmail.com>
In-Reply-To: <willemdebruijn.kernel.a37b90bf9586@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Mon, 29 Sep 2025 21:28:36 +0530
X-Gm-Features: AS18NWCgnPycz7t2entTrmTu5YC-DafC0Q0uYk2zgNL_KC7OWEjNYY7xyUDcjPI
Message-ID: <CAJE-K+C9_En-QWYrTJmMH-H8CP_1wgpREjFst1ybiE-bJtF13g@mail.gmail.com>
Subject: Re: [PATCH] selftest:net: Fix uninit pointers and return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 7:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> [PATCH net]
> and a Fixes tag
Thankyou, I'll add that.

> Does not need a fix. The default statement calls error() which exits the =
program.
> Same.
Yes, you are correct.

> Agreed on all the occurrences and the ovpn fixes.
Alright, I'll send v2, with improvements and a changelog.
--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

