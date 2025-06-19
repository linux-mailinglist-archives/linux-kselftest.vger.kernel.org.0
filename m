Return-Path: <linux-kselftest+bounces-35382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6773AAE0BB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 19:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE52B1BC04BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75928C5D5;
	Thu, 19 Jun 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFexaoMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24E28B519
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352755; cv=none; b=oYLVc2PYqj+2IMUhFhi/zW/EwHQxiQa7sx41w7hpqWlfb+60AxxyQNG/Xbin2pXK/lF1+1UB2xXj7bwpVoMrWN0OZw2UVDCsuACqrmgyu7v5NAw/FZNak2sx5fg7aCAcsVZyewNGBKSReo7FHYyqu85UNtFibVnzRC0WaVkb8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352755; c=relaxed/simple;
	bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpkL7dveQoQjga5UDrVuyXFsFUCGGhPy7V1ouAIJgoBgV3D566yhxuXli7lSakh4hAWsvMnIa5bGb4g2K15HmAUpnJw3elzFMGaHEnJm5jtpTyIn/b5aIt9OfAc3/pDKJmVwHZh9Z4FpjcSszFJ3Avid6jNAFSGQ+NSPtU848P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFexaoMA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso236085ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750352753; x=1750957553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
        b=OFexaoMAKOV/tVthYS/EtHnoIm2b3NB3ePni/RQmFNtbaKi8dZpwZ3kWU1uAjIyCuP
         TSCYe335Apb6xf7wIvOimbdHHUIQ1u6yW7eQU9ICyDJcGu70kaEB/K4V5BLVXDahOSsm
         3F9US8gdqQA8F8gVmTysqAw9JDkImOwBSujqcu3mVWfQRUqjBeNxy7MYFxIIpIu3ZT1l
         1et++0bHhdOyKOX2Nwrt0WJZA3hLAdxXxyLqG+vWqoSMJjVnc3RY3w7w2HShMRpKqKR5
         Kfg9j+8w/Pv5eZ1TdDU41b4Q8hzXM/gjjGibDTcdTCDCS6c8W3kgbbLp/qc9GN8xjoQa
         dS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352753; x=1750957553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
        b=V7AIoYp5FNj4gsbBXyG/9FPb8p+Bbao1xcDgmuYxFOijbHMrmaHXP2/YIgWmbB+RWN
         1y4xNPEmE4lLVts3sxgJ/WyB0gNFcXw2V1ksS6Dn2rOJMLV6XuoT0DwPMlt2dbZMPWWF
         KWXPT3g1M3tSg3MpltdZADuw/zS2W38EY+R/eTr65Ju5g3wqVsqW1SCxF723l5ptFn3G
         iWA68s5g/L9dN1bKizK1DV8wfJT585caSe3kkkZEWAaX7a8/KfEwjdNWbp7mOYSBpu7G
         Q9UbEc7S4zVyE762TDsHHBMZVT46keAsGPjOALD3QCwUfzv2S7gF9tRw+Fkh+avLO7ok
         oEIA==
X-Forwarded-Encrypted: i=1; AJvYcCUSC+VuFlPGUWtjacm3ubXVUBngL+nvAyM7M/GAoFHzJmfbyIt+K13L8JR6SpdvlaWMBmZbyLM4PWi/P+2E5A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhcunISvyDzGM5VqPCYSZ0oqmiEN2CbIsIk866gu4Wn0fiDV7
	U/bz1eQ7Cql91gsT8MezkI/yMhm57SQZuJXuFZW4VFd7TeKslOffh72dDMOL36cx9EUDdvXFl8Q
	xHg1vmCcceRtKO4X3Q77Oo/LgkpFEQtH1Nk2YQr43
X-Gm-Gg: ASbGncuLZNo0vgJsQSRt+pcmNtQx1eXi0YB5YTskIt+r3AHz3mVSYjM4M9RLteZ8cMs
	TATcPTwCRpgQJBZ/uQXFL5x1woWgvsMSn0mqyTaCKT86X/iUAC9uNtqAbO7y7Qwe/xkWGR4weU7
	xivWdhJxDCXFiL7LPPojmIxlX+hffBh4CPVlea/9SgQUw1
X-Google-Smtp-Source: AGHT+IHBoqiPScR/zsv1kvJMCwfwqRmUY/QUQzO9Cn9XCeyjsUJZbuwfk7x6aYyXYdOhd+nVFvJsQ2gPWXvq3cUBLdg=
X-Received: by 2002:a17:902:f64f:b0:234:14ff:541f with SMTP id
 d9443c01a7336-237ce047d0amr2886185ad.21.1750352752967; Thu, 19 Jun 2025
 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org> <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
 <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org> <CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
 <20250619095835.6ef52aee@kernel.org>
In-Reply-To: <20250619095835.6ef52aee@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 10:05:37 -0700
X-Gm-Features: AX0GCFv562JtizA2SIM9AYmy8maTRimTtqBBXtYOtPbIo-G_JCECNhN71fZG13Q
Message-ID: <CAHS8izOeQ7RPHABQCLP8XWfH=V+hDwBg4HTyzWhS=7CS1ZzFww@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 19 Jun 2025 08:37:05 -0700 Mina Almasry wrote:
> > Jakub, this patch was marked 'changes requested' for good reason, but
> > after investigation we found the patch itself is good and the issues
> > were elsewhere. What do I do here? A resend of v4? Or does this un
> > 'changes requested' as-is?
>
> Do you want to update the numbers in the commit msg?

Oh, I thought it's fine as-is. I can update them if need be, no need
to trouble yourself. I'll upload v5 with updated benchmark results +
make a note on how to cross build it (specify the KDIR=3D arg).

--=20
Thanks,
Mina

