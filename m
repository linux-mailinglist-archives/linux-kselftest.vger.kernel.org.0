Return-Path: <linux-kselftest+bounces-44060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21024C0A4CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 09:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AE43ADB66
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649D28468E;
	Sun, 26 Oct 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr4GcKvx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070CE611E
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761468630; cv=none; b=YitZa6o0prGa82T8Al6WtJDnD2uNm0gfHbZzn/4WkSnKWl23dYlI8BvjU4l4q7s0RNfvkGe25A928zqNN4b/98SZbEexUqifFO9JJf2RG3EdohG2BPv4/amer6AHSk7KxX48Z9NA3d6FNN1IkiNWP0zlM4VVA/L+qrg7yORaA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761468630; c=relaxed/simple;
	bh=qUv97I7rJ7EfeUfzdIMw6A9QYkrO8FwT2r0vGFlDE0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pahQS9KX3eJ9Fa3t6ObLtPMz0gtZb67b/TRUeBhNJ9Y1mAJZeQwKHdWa4Mdl2uZWNZuIzA0vh65ihhU4g86kl0pMf/Q8KESIK6PQSlVFzSDfrOcGzX1l2B749vY6TEhZDsiBJ+QkiIcqXO7mpMPCdnr5nOFyW496bkWcIgOniOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr4GcKvx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290d14e5c9aso49582495ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761468628; x=1762073428; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4erMBwQ48N3S4QlFMJdE0eCyGlP05V530oLjHStsso=;
        b=Mr4GcKvx/LAtW1SssMM2PWEumNXy4snQNK6JCJ/s7U0old5m/wLeZPPW1WPbLsK2gp
         etP6tLgEBBVptpxrIhVPh82Zxy9YQySOWLLf6ybPoezzda3U/uNiS5FHVjAsd8kNPyh0
         2JK/By4Lhn2mm3+sGD9NQEJieMInCXif/F/QO3GmaIFFvSwItRb6xl+DA1JBqTlKoGwy
         OmMmOon3TlcGxsaqjVCoBWZNe+hutEoCEfv0jvTOQn3iyHQqzPm21rf3smocNxpdFHEw
         DN4S2fzQV75unZHQv4FV2uUoJvJy4MukvhhIddleb9p976y2tzrgIDwWEv3Wslbqf3V2
         MZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761468628; x=1762073428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4erMBwQ48N3S4QlFMJdE0eCyGlP05V530oLjHStsso=;
        b=FyQJ42JBa6e+0AkBwEiOAUaIGSZYdDjlx6N3GGKrlL9n+vXi+5uWpeMD1P7kTsT+GN
         GCtXbUaf2Bw4+OQrykxeHQ3wHDx6S2z3gNYs8r5PrK8sba5nI/KeC+QhVVu/KOQHHE53
         kRT9iihd5T734IfwO5e+54335mA1ChoDsijM1q5OnARtPGIFqX+1TsvDbCZC2U6tfLi7
         C5pY5V6P5Y6C8bgRWjcfP+V1vYLNWtHUg91h+ptU3fNP5Tu+W4CMnby7dX4CsL0haxA2
         SbryLCcN87dOeS3VzG1xxhbFQaoc7Mze5rJk1h3/xwI8CBtO3RhXB4gdx+1aY7D9Q5SB
         muDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMORjQ+jne/t1hdqiqALT4kVDi7iK4vL6XZDba9iGQn9t/qSYs9SHR7HjEUU3DtkK+o5ZwZJHV/qPSVKtuVgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAtMl28HN8Mz1EE0Y/ys5IiF4sakuc0ldXTRpgAfJ7oKWL2a2
	h/Nu3yRqDDchEL2R8HTqQUNNF15t0kgoI4DXMohgeSJ06+U/U14oOeGv5/l5/aIb
X-Gm-Gg: ASbGnctZvF0l9nJG0wucbwcMYaXcNlkg3EYDc8XOZ3MMhw0Hf9X0LLBpPKHO/XkrEYw
	Hn26HYkKDWuPIa1Sdt3UlFvhXE6lrlubJmCvi+GdkxnJOLmv8vw3D+3OSrdZPCc/iFeZrPZz4O8
	kmRH/XkiPXqD6tKF6Az9O4lWUPZZvQz9Eouadg55AfuIuEa6FXLtPokG6D1cdxEvSMt0bJo3Nl1
	UgWBvriwGiQ0rVSTa8THaw5+6FjNkzpvS2mcSoAbW7xBzNTq8/MXDKkqxI7riaIY5j2pe7SjvWe
	zVsgA7ERSyNa7vVmYz8VUr93xz7vz4mtSxkoXJ8VXoQr3ICjj/VkH8ofYIjc9vmxzduWQwvDc25
	mF/or0Pb9WlGH3rJjsmxnEgFgo0/nLySOC6RvTB+zpLECJ7kyud/fy74RP3nUCFSZiYjGbIMzXV
	6rVJ/FvR9h4uq10/g=
X-Google-Smtp-Source: AGHT+IF/m6/+800gB7/6liHmYwj+jJvYjxHcXB/tEA5NbSYwquOHX9mUISDWYTYNNgTYOtc6bmcQGg==
X-Received: by 2002:a17:902:f689:b0:294:92be:64d4 with SMTP id d9443c01a7336-29492be682cmr90289775ad.18.1761468628250;
        Sun, 26 Oct 2025 01:50:28 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27541sm44678205ad.61.2025.10.26.01.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:50:27 -0700 (PDT)
Message-ID: <d52862c17afab501453c3fbb5167f78d24b1f807.camel@gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,  Simon Horman <horms@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Date: Sun, 26 Oct 2025 18:50:19 +1000
In-Reply-To: <20251024163336.5fba5cd1@kernel.org>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
		<20251023184404.4dd617f0@kernel.org>
		<cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
	 <20251024163336.5fba5cd1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 16:33 -0700, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 12:11:11 +1000 Wilfred Mallawa wrote:
> > In the previous record_size_limit approach for TLS 1.3, we need to
> > account for the ContentType byte. Which complicates
> > get/setsockopt()
> > and tls_get_info(), where in setsockopt() for TLS 1.3 we need to
> > subtract 1 to the user provided value and in getsockopt() we need
> > add 1
> > to keep the symmetry between the two (similarly in tls_get_info()).
> > The
> > underlying assumption was that userspace passes up directly what
> > the
> > endpoint specified as the record_size_limit.
> >=20
> > With this approach we don't need to worry about it and we can pass
> > the
> > responsibility to user-space as documented, which I think makes the
> > kernel code simpler.
>=20
> But we haven't managed to avoid that completely:
>=20
> +	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||
>=20
> I understand the motivation, the kernel code is indeed simpler.
>=20
> Last night I read the RFC and then this patch, and it took me like
> 10min to get all of it straight in my head. Maybe I was tried but
> I feel like the user space developers will judge us harshly for=20
> the current uAPI.

I am open to reverting this to `record_size_limit` in that case. I
think the only trade off is just a bit more complexity in the kernel
side for the additional checks. Does that sound good to you
Jakub/Sabrina?

Regards,
Wilfred

