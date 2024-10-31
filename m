Return-Path: <linux-kselftest+bounces-21238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321E9B8116
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416651C2350E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70591BF7FC;
	Thu, 31 Oct 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkWMWtWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DD19E7D3
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395231; cv=none; b=AWiTfBOydOon3bXa1fext2VK9P2OVD5V3/EJYNsDkHORhrGMCQGSq4fiozy0Iik6HLpBshhi3Az+tu3yIXnUPj+x1Va/hvlCcrbJXb3tdbsHaVNFw42h9zKUULT35jQGkJulhlDVIgUbooQFK1fNGnp2gwSXcuctCWdAZ8KxM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395231; c=relaxed/simple;
	bh=Qpfn1aqERxQIIO2RpljK3QlpdUDGs/PQ+KjnHTvZPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skp2efpkBMQbiWytziaaAisZPafvrbXDzzEio9yaw4NG5K3ECIbTBjQ/hHZE53QrOhnd1ZX4oHKyMPrNXXJrTdntZ/Jl9x4lwhuvD2sgk48jSR7a78LnuiOTI6u3CdPejQfCk0zzTWflGO+3xd5T++q3WxRYKU1BnXqIYAWsY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkWMWtWD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e681ba70so1562e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730395228; x=1731000028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+rF3bbkwD/l4VpYrtWhBYduAyO2UrjlFMGIgBxxz8=;
        b=lkWMWtWD46ADG8jSwjfHnEmlVrrgNDA0o6MP2JOK85moVKiCMLk9+DwYBoc5vUypqM
         M5mpsiALO/I8YrL3Pe4+U5FpM9tbBlqBaI5TLpn4aNhv6COACGcZFgivkSAnVUX6Zb1m
         lDDuOYWaBYi/WqzKWF/s4CrD0SXEjsRg3VPB0NBPlEqqJ/2lasFxT70La5l7RtY8K+j7
         /uN+NyE/s4IW5Ewr2VU2PAE4z3f+SJ+iM0nbHpSpECHt+K7R8Yq01Uzdu5lB6Bg8UpQb
         VRAz634vKYXRMHUS7ePbhf4HhMsDVj1hlCa3E47zpGflO8zVkqkCqORQxN/tEvc6xVk/
         Uu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395228; x=1731000028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg+rF3bbkwD/l4VpYrtWhBYduAyO2UrjlFMGIgBxxz8=;
        b=ZjwKlO50AeQbBTkluqGIXbks6HyI5UTYQ37nf/69qDlDhUnLVtIs52OvxDFVVm0+DG
         uvRz3IcdigmWyuBxWxBZ8AWJHvBfLLRMAgw3JboaW+xdUZG3WomfMVfz8ucoRfoO2JyZ
         vX0QDGrF/WX5J2wnrLYd9yn/hDScKPqH89G1NMuGUXrKj44NNcOvFmoUKAIrlQ8eNjS2
         gIIJ5pmCJ/0DkdgLcLNJJz2EspAJ7BbPHCpBuy7bsD3gjySzrJAi/ydKLb7Ff8AQSpmF
         qLYCTnVsI4/f/SsWxNwzoS7LDj+xDfBNit8Cyic6lwqKQGcmWJSCAUinmZpuqoUtoL+E
         +Spw==
X-Forwarded-Encrypted: i=1; AJvYcCW2oVVNopz5rbG2lYdtsKM4IG/0MgKz7WAXRc9deKWFk8COzXXEFRYzBjPYcoxbp15olyNCD5FiYN1uuDV6Dhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPX5UgwBjMeaQPIEwRFRq2RbeL2jqqiR3gOba9EhPHZNBFqG8V
	UiVOSul8fD6rSyjbwK2Gf+yekv2VDrF8h8OMhe7+UG5SpN2T46by4dQ72JO8v9VqJnIAgSDe5JI
	Z8s3w2JHcV5grFBnx1neIuvKYAlq3YNhTQyba
X-Gm-Gg: ASbGncuGuNZSdEuKeckoWmSPvpdGBQbLjYNp/omLgNojnRN0n/vjjwBfi4oFBxFkdc2
	U5xX+lPbFzhDnyHMCnhUN1Wxs5QYau3u7KFovwUXxIZbKxoqBpqVivIhunOhumw==
X-Google-Smtp-Source: AGHT+IEv90dd5q1CIH9Mt3/RPC+ncg8zHsWLi93i93FxiGZUohh8fnGc3oCrDv0I2EcVmSgpEDXcHBPyCl2iNQcs/7c=
X-Received: by 2002:a05:6512:4024:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53c7bb8e9f5mr285304e87.7.1730395227548; Thu, 31 Oct 2024
 10:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me> <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch> <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
 <ZyJSpBrhz7UJ0r7c@mini-arch> <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
In-Reply-To: <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 31 Oct 2024 10:20:14 -0700
Message-ID: <CAHS8izOUx=_HqS8foFoyv7H2d7zz6+jchG2r7w+LL9fq8CJvLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org, willemb@google.com, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:45=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
...
>
> Sorry, 2 issues testing this series:
>
...
>
> 2. Validation is now broken:
>

Validation is re-fixed with this diff:

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 692c189bb5cc..494ae66d8abf 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -568,8 +568,7 @@ int do_server(struct memory_buffer *mem)

                        if (do_validation)
                                validate_buffer(
-                                       ((unsigned char *)tmp_mem) +
-                                               dmabuf_cmsg->frag_offset,
+                                       ((unsigned char *)tmp_mem),
                                        dmabuf_cmsg->frag_size);
                        else
                                print_nonzero_bytes(tmp_mem,
dmabuf_cmsg->frag_size);

Since memcpy_from_device copies to the beginning of tmp_mem, then the
beginning tmp_mem should be passed to the validation.

--=20
Thanks,
Mina

