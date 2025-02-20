Return-Path: <linux-kselftest+bounces-27048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28943A3D2DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52E918932C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4931E9B36;
	Thu, 20 Feb 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heF0dm3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840921E9B15;
	Thu, 20 Feb 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039221; cv=none; b=fFd+PLov0zswtLL97awYp+oAIw9+l6Nan89h4Tgl4nVYX43ddrnJvl85aUaUufa4SDLAOrG/FjlZQOSOs8aBAXBVzBx6kebvcq86YjSmhaquf7jC4NmwVSiX3cGJ73IHF9u7oqfCWitO5otEWvHvos0gBtRMD85igQpjW0t8sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039221; c=relaxed/simple;
	bh=NR1AzEHW3X4hTDfCdv4wws5y6bJ4IHoskvMdZyfEWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBx6E2PMbdkAEpbuHT/p0u9c5tSw6GZi7dbs53iuWm79rWUXiV2Wd3lFwm6+W9Qe9acpqXQAdFPm8FpTcmC2SbJZvCjMA6lD0jMWudB1+m4I1rXDSno9YdhF62ET1dvTB/4Mzl7xRTkIHa1+3HJTWnAA0uueWk3wiLhOro9OjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heF0dm3M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f2339dcfdso11382835ad.1;
        Thu, 20 Feb 2025 00:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039220; x=1740644020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz/pGvR+evldl5mhlvuI0J68W2mI9FP4/s36oM1FYLQ=;
        b=heF0dm3MjHXMA7y+n0ZoAaOZzdbNAxYTWs2GjGgDNo/uYJQ6lO2hsvafXPpn7nZ1is
         T/knW3AAniz+tpZihfOqP0QzRErEyLTZhuOm/CUJFE++/vVhJrxKvTmXFa7VB73am/Bu
         L6fRTACx215w+S24yeFLoFfAHQQSRaulBQ7Rku0+xRlb8AfhY4oQ+oW0KUOcsVUXCy0q
         paf3otP6lzxnJyJZ2txSeuZFrbsp0M8/Q6gOreMc0u6YeY3pi5OCt5vp1CQlnjuOK3tL
         hbZU47/3NsogqWH9eMn41qazt53EZncx89MVf9f7u0j3+x1J2NrHI3s6mkmy6jmtmHQe
         g0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039220; x=1740644020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz/pGvR+evldl5mhlvuI0J68W2mI9FP4/s36oM1FYLQ=;
        b=lwZm7CtAYxy1m75x9tC8mhNCbh2FrlEArGk7rmk8JoyM2rLY8lAD5rpdwMAy6VFy3V
         jv6uJ+0h6lHqFAjPdJ3ltZiTwn3QKR/CY1X5CFiPqP4FJeW/thliTW6oPtW3H+Rn3Gxh
         yVthrGiF8zQunOARlulL7lOL4BmvJHAlrx3Zp9Tv4XAZoX2TSovXn06xaW+8ycyUfR2/
         UeoR1Vi4HiwKLw3MAycf5DY7X2TKWZy9ba9tJJc+T38eEwAJVrtAoVQvO++OtsYmSXyB
         1sG9dveRIRAG7P0XI/inAk+CWvBRI2hEGWU+ch2qtRfTZjKJlCPRaKbZWVEFyzs38zAD
         dgOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPr/S2BkV5INySGwSqhG0sY5Nbks7dAafdVTfQMmsfRNFc411joUmKW6hWWyO2tPuk0K74RG9P@vger.kernel.org, AJvYcCWR31zaeVcuEM0bqAnDtUe1iIK2kHlfeuwtOFvgkGehAWptniK/A6TgLzNOflXLBKZ/N9s=@vger.kernel.org, AJvYcCWr4oLApZxYM5iStMQfO4rcDc6InW6ekEb5J/vopmjfAVIU6JlYbLdDLCIL+gL3VVwOG1uCO9R/UqYg@vger.kernel.org, AJvYcCWuC5bV4zUpc49+qC4Fa0eHPFhIoBgS+pUzu7H28Jy3QfvU4kAoB29u1qB/Vw7S6muiX0Vx+TZLF5pJ/Qvg7nA+@vger.kernel.org, AJvYcCXWrZKjCAXN5HOKHUyMl2wUM9dbsFbgNroODSjQpDTlaV+7MSwiD9pesFXJU0YaDiyj9To7I/48Wa15R7gm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ydxZhvy+b8PtpCQaTY1VSmt+yEq3kJudHGtprE6dKq9cK7fq
	lEOCBOk5/aWRrnRm9JWT+7fqCOzN4l/LLiEfBIM2WZK+HqtIJA68
X-Gm-Gg: ASbGncsdZ241q4QnLQ30TNpK+bwBKY8bq3ekRWjsk9Z1Qi6ztWQ2ZJYWDdu04kcfrMw
	LihueXm0WPHbWpP832Duih6aV3Iv07gxYlKNRHPVrETjU52ZUupuB//V0+72cSRzMlQSivr4NyE
	H6caGlD5P3iA0xkfO0aEvCM9nqCaGlTQrbbAln2UOJ2SVeIWtHqD7FzwoQGwaL+QCymnWAOS7C2
	A1chNYqgwSJndpinPTjFatGvIOmYbXAs5y5lc6myL+W+m4fY1+V5pClGP4TN6CZADKs1BlEMaN3
	yod3JTm0XeWeHBA=
X-Google-Smtp-Source: AGHT+IF3zZoqfKWUfFNv+FPNQ0UuIwZSkcWXCgHzMPO8Q84I63xMG6/s+7OLxm4EjnPNFrOg1ROUQQ==
X-Received: by 2002:a17:903:40cc:b0:215:58be:3349 with SMTP id d9443c01a7336-2218c41f67dmr48108495ad.14.1740039219629;
        Thu, 20 Feb 2025 00:13:39 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349634sm114661275ad.31.2025.02.20.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:13:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C04B84208FB6; Thu, 20 Feb 2025 15:13:35 +0700 (WIB)
Date: Thu, 20 Feb 2025 15:13:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 5/9] net: add devmem TCP TX documentation
Message-ID: <Z7bkL7uuy8prxfTe@archie.me>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3ck8zPX3Nllt0fQ"
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-6-almasrymina@google.com>


--j3ck8zPX3Nllt0fQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 02:09:10AM +0000, Mina Almasry wrote:
> +The user application must use MSG_ZEROCOPY flag when sending devmem TCP.=
 Devmem
> +cannot be copied by the kernel, so the semantics of the devmem TX are si=
milar
> +to the semantics of MSG_ZEROCOPY.
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +It is also recommended that the user binds the TX socket to the same int=
erface
> +the dma-buf has been bound to via SO_BINDTODEVICE.
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifnam=
e) + 1);
> +

Wrap both setsockopts above in literal code-block (just like other snippets
for consistency).

> +The user should create a msghdr where,
> +
> +iov_base is set to the offset into the dmabuf to start sending from.
> +iov_len is set to the number of bytes to be sent from the dmabuf.

Should above be bullet list?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--j3ck8zPX3Nllt0fQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7bkKQAKCRD2uYlJVVFO
o2s0AQCqEcmu39fAQOLMTwOYkn6NbqUyjT/e6q34LK5lpFeB7gEAw4iw+0dFGzFm
S+/rpVCO8Pfw8Mt4Xg/RDLmSlwuOhgs=
=QlMN
-----END PGP SIGNATURE-----

--j3ck8zPX3Nllt0fQ--

