Return-Path: <linux-kselftest+bounces-2859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B837D82B0D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 15:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428741F21640
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB2487AC;
	Thu, 11 Jan 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvyjbbKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399C482F7
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704984127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fFxwv0qni+WI52FYgq03AZcxlAZpnw2jut0+tbvW+qM=;
	b=RvyjbbKjYL2QvDCgOXRfXl0qMLORiL/ibX0pO/tEzfu/mugieu7hl9DXEsPEqClIWqf1kO
	S+C99pTqn5FDRRwSR2rdcFQ8uLOzxpertWB9vuczj0n0pLWeeVcNIogHsMNpGm2Gv/vNbh
	QHXqRwJXucFnP3WuL+TO42Lnx8Jstng=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-of5eWIvdPhmjrz9Ry4Q6nA-1; Thu, 11 Jan 2024 09:42:05 -0500
X-MC-Unique: of5eWIvdPhmjrz9Ry4Q6nA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a29de6a12adso96325566b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 06:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984125; x=1705588925;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFxwv0qni+WI52FYgq03AZcxlAZpnw2jut0+tbvW+qM=;
        b=rycVODAmawnSMhy8UYXb4nu3tuMuO7GCPeoitSkYDJK1EBf3xd1ZBpHARJ6HNgUuG0
         gNu/+GwuIIwXwlQ/O4yXiE9zdL5QcvcfY69Mn8hvoWT8Ee7HJY0et68wo07rx+JZZVnq
         IOJa1RbiY2QwfttOrIEkntNDxmFaVKl2K7UIPhwUvu/q6hd57BdNNkmiZqSvxygLhEQX
         FA9VlJsSQpHCKJ2CfOjONV9mFJ3P1Wa0iQ7fkRc9DHnHTm3eKshrj7yi7+TmxLBIk6DO
         /wo8H8dRYdxm6tZTtmUb1UOqbgaohM6OQYy+27NpGr89b7lVmP83fTfglh4GWX8JoR0V
         L7UA==
X-Gm-Message-State: AOJu0YxwKwreONgGWyJh9BRixRIvhZMd4111uYlSrtvn7Xh683scRbvw
	cxBY8EiTbxwragtxHYHI/RLtVhru6ZIULiFAsBfChWhjp+tWP9WxRz8HfoX2Y/CQcbJgdUAjCa/
	isiwbAFid8lWs4QOuu+nfPgt4ApQzqg8vFSzW
X-Received: by 2002:a17:906:abd4:b0:a2b:d12c:ee48 with SMTP id kq20-20020a170906abd400b00a2bd12cee48mr1444079ejb.1.1704984124804;
        Thu, 11 Jan 2024 06:42:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3iXMPhWDR3ZWGZOQcaKtLYN6/qHGPpdubZ7yiq72jUQPAzF7Druorhh5oXfePQQ84Uk68rA==
X-Received: by 2002:a17:906:abd4:b0:a2b:d12c:ee48 with SMTP id kq20-20020a170906abd400b00a2bd12cee48mr1444065ejb.1.1704984124480;
        Thu, 11 Jan 2024 06:42:04 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-191.dyn.eolo.it. [146.241.244.191])
        by smtp.gmail.com with ESMTPSA id mc12-20020a170906eb4c00b00a2b85ef0ca3sm641616ejb.202.2024.01.11.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:42:04 -0800 (PST)
Message-ID: <c68e9299e755b38c38d63d8cb121800639f5e07a.camel@redhat.com>
Subject: Re: [PATCH] selftests/net/tcp-ao: Use LDLIBS instead of LDFLAGS
From: Paolo Abeni <pabeni@redhat.com>
To: Dmitry Safonov <dima@arista.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Dmitry
 Safonov <0x7f454c46@gmail.com>
Date: Thu, 11 Jan 2024 15:42:02 +0100
In-Reply-To: <20240110-tcp_ao-selftests-makefile-v1-1-aa07d043f052@arista.com>
References: 
	<20240110-tcp_ao-selftests-makefile-v1-1-aa07d043f052@arista.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 21:34 +0000, Dmitry Safonov wrote:
> The rules to link selftests are:
>=20
> > $(OUTPUT)/%_ipv4: %.c
> > 	$(LINK.c) $^ $(LDLIBS) -o $@
> >=20
> > $(OUTPUT)/%_ipv6: %.c
> > 	$(LINK.c) -DIPV6_TEST $^ $(LDLIBS) -o $@
>=20
> The intel test robot uses only selftest's Makefile, not the top linux
> Makefile:
>=20
> > make W=3D1 O=3D/tmp/kselftest -C tools/testing/selftests
>=20
> So, $(LINK.c) is determined by environment, rather than by kernel
> Makefiles. On my machine (as well as other people that ran tcp-ao
> selftests) GNU/Make implicit definition does use $(LDFLAGS):
>=20
> > [dima@Mindolluin ~]$ make -p -f/dev/null | grep '^LINK.c\>'
> > make: *** No targets.  Stop.
> > LINK.c =3D $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
>=20
> But, according to build robot report, it's not the case for them.
> While I could just avoid using pre-defined $(LINK.c), it's also used by
> selftests/lib.mk by default.
>=20
> Anyways, according to GNU/Make documentation [1], I should have used
> $(LDLIBS) instead of $(LDFLAGS) in the first place, so let's just do it:
>=20
> > LDFLAGS
> >     Extra flags to give to compilers when they are supposed to invoke
> >     the linker, =E2=80=98ld=E2=80=99, such as -L. Libraries (-lfoo) sho=
uld be added
> >     to the LDLIBS variable instead.
> > LDLIBS
> >     Library flags or names given to compilers when they are supposed
> >     to invoke the linker, =E2=80=98ld=E2=80=99. LOADLIBES is a deprecat=
ed (but still
> >     supported) alternative to LDLIBS. Non-library linker flags, such
> >     as -L, should go in the LDFLAGS variable.
>=20
> [1]: https://www.gnu.org/software/make/manual/html_node/Implicit-Variable=
s.html
>=20
> Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401011151.veyYTJzq-lkp@i=
ntel.com/
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


