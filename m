Return-Path: <linux-kselftest+bounces-48274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A024ACF675E
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 03:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980AF3032AA2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5515D258ECB;
	Tue,  6 Jan 2026 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQBgRXrS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4say1wM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B585240611
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665843; cv=none; b=REU+IPMFfheyyrKGoTR/I1U6+Ls8dRfEleZncSCcnb7ooxXfrIFTEo/8z4pWNGKTyC3kELhjPMlR/MD1PN/n68mYI11sf5MHUjrQ8wIsUr4edLeh3RWf8HpJPWDQarqMJ8bdB7QXevaALUJfOmArZ23+TjO2ZGCJx7wxAnu4H6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665843; c=relaxed/simple;
	bh=1YgllTBL+1iViT1gzw0aL6fOdOScWmVAQGM9pEnlsmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh5PNRq5eUVfdlhsA8aSsncCWwWdIN3X9yWDHexMHAP3F8CG2RqwKuDkieX2MM+JVN56PcFUqog1kD3gCVVrBskewttOyJcQONjK+n/ZPUN8unRTABJRC62SraxeyfoaCn6ybTWTsJMW0QumXCbVLgJzAF5YPLk+cPNJcSf5e64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQBgRXrS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4say1wM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767665840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppqIeQWJ2ZsPz/DX4aNgRg6SKOktRzCkfGgYgisHCjQ=;
	b=AQBgRXrSWtYEPUAZY0A/J32vTTm4yHuHba6GJbX1RwiYM2rN4NeL36TXcxN00YKt728Z1O
	JedCOicb8K+jfhTRjLvmsfsXHvbeouSKCtyUE/NI+mocyYlzocBkI5r4FCPj74b/7G7lqQ
	PQUYBMP2mqAnt7KXyqW5+fF5abWLu5k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-4ClF0UOsNhqtGJN_4dnTvw-1; Mon, 05 Jan 2026 21:17:19 -0500
X-MC-Unique: 4ClF0UOsNhqtGJN_4dnTvw-1
X-Mimecast-MFC-AGG-ID: 4ClF0UOsNhqtGJN_4dnTvw_1767665838
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b763b24f223so55493766b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 18:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767665838; x=1768270638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppqIeQWJ2ZsPz/DX4aNgRg6SKOktRzCkfGgYgisHCjQ=;
        b=i4say1wM97rv+YvlAEA/Fg+eWLVQZBE0xFK0XbhxrjgS893Yr5LqtvOG+800zXWbup
         ExnB6hkj85coXts5QqffJ991deGzMZoQvsDPtPz0S379kJH9rgM5qSVGq4jMp5LsOa5q
         HQ8ad7XCBIKze210AODOIm5LfZVj2Zv2tW5j2rU1NHkMKaImc/4aEXmaOhtt6Qs0jfMe
         KsEmsHYvhSmCsx2ZXvbE9zvUX4YDmPUaxSleJsjLJBhglgJHbOwX+bcEFojRT5FQFqIN
         ukaZmt7HIOS8uD4st6SB4F+zi9eGWoNBMyv/K/QvpKfo/TYmUxloZen7G80k1gmv2Ob8
         B18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665838; x=1768270638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppqIeQWJ2ZsPz/DX4aNgRg6SKOktRzCkfGgYgisHCjQ=;
        b=p2XJv1Gkqq9TNVhr4un8U+3PJeQdRIxhO4ZnPLNvFIi2nsLN3KdcFJL4PhxjVTq56Y
         Lpg1TqepleTjlDk+gRbKMrx0YiD9woZ8Wwig+Sly3lcV1pxqizK/F4julReYv0S8znyN
         6aoZ+YygQQ0zS53dqa6Ol0lZXeD803HVC9luBRBjwAm0dqeIAkfKpiv0YDBiCuVnDxKE
         P/uY/EdbWEzUWyLHOnyhyXzwKjty6zT7jofwB5YDQEMhFj+UAMS3DEBa017/ZH0oBoq/
         eLuTfWN3fBJ9LmBEnogOKcxe1hDIFV+iom3BzeUor8MrTnI8ruNoJk3z8rTzzjnjeyTW
         vNzg==
X-Forwarded-Encrypted: i=1; AJvYcCWkEX6N/JzdDVZsWEVIXI4DOkLXFHX+NHvLASPbMbvkjmnsKCDeoSo4oBIf/4blMew7IT4U20HVnlr2t/mtA+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGYHw+0dGckBJW0ARyrchyLGPbbiP3sOfyV7gxcbhcr4mHTq9A
	oHusR7k9qho3IsDSkDa+y/FxRSCIvfW0uPlVY0Od30xP/wVnvnSTnLfYs/LUst3XfP6gE0fprG3
	SmydNM4JHgdl0/HN+AY1buV7ZuMNbmuE4CXOmM4460b8pbmBkcnd/XM6Sxll+fRx94a65H8Acnd
	JR9Q5WZ8Rb4TToAsyRdC/RMZWRul7tli1vS0ix004BarTg
X-Gm-Gg: AY/fxX4NczjKLW2J2TI0lY2w/cAT/G1tg9yYc6KWOAfiXWqHY+EnJP4PlLU42NX5OXK
	uaYHgQuklvJN7KolO/oTdzDuGnBGVHlUzd4pzRBbzw8CP1LOTXjnyXsdbW6zAeHIj7YnLTxrMcv
	PCTyrHD8LKLttELvnH2cLranAhxSGI2EofM4nEYE7K30e4380u/ix37yUkc2vBX0kQ0Ag=
X-Received: by 2002:a17:907:6ea8:b0:b75:7b39:90c9 with SMTP id a640c23a62f3a-b8426c0d8c5mr182759266b.51.1767665837945;
        Mon, 05 Jan 2026 18:17:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZpG50fCpayB+gpP3wEA88rQP0JbYq5H+7aAiS8pjjgd05jGSbAaPR1ublGR+/mSAXJKa8nFxkktRJ13qufE8=
X-Received: by 2002:a17:907:6ea8:b0:b75:7b39:90c9 with SMTP id
 a640c23a62f3a-b8426c0d8c5mr182758366b.51.1767665837572; Mon, 05 Jan 2026
 18:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767597114.git.xudu@redhat.com> <20260105175705.598c8b0c@kernel.org>
In-Reply-To: <20260105175705.598c8b0c@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Tue, 6 Jan 2026 10:17:05 +0800
X-Gm-Features: AQt7F2qI23fgsuMf0a99Sv12MnkBvt4O2xUWTuNqwoXecH1KIcNn7bGOiu2261E
Message-ID: <CAA92Kx=UXmsxL-2VUs6M7sVzZr9-Dj7Pz5NLU0st1KOGP-4b2A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

I'm sorry for the trouble. I actually resent the patch before
receiving your email.
I will carefully review the maintainer-netdev documentation you
provided and ensure that I adopt better practices moving forward.
Thank you for your guidance.


On Tue, Jan 6, 2026 at 9:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  6 Jan 2026 09:35:13 +0800 Xu Du wrote:
> > v3 -> v4:
> >  - Rebase onto the latest net-next tree to resolve merge conflicts.
>
> I just told you not to repost in less than 24h.
> As a punishment if there's a v5 please wait until the next week
> with posting it.
>


--=20


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China


