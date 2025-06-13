Return-Path: <linux-kselftest+bounces-34859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388FAD813C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 04:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5453ADFCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C524169B;
	Fri, 13 Jun 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AokiwHl6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C9433A8;
	Fri, 13 Jun 2025 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783091; cv=none; b=a6yG0/M5r1MFO4d0HgpK77QgnuQI47G8M3u1NX1ZhJ49cL5YRXTjjq96Px+9Rl6EGMqoaS4671BZpT/c6QTogqtTPuB2EyVTNQgOPXK09z6Xs3YMgvc0VOCOqE6NNJ0LkrG7+taXUGcdnCXUErzvefzS5yCjhFMM6dk9X1kq1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783091; c=relaxed/simple;
	bh=Ra9cExndnBnCkprKs7BLcYcowBm6Cm7GgCObHl8u7B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvJhZhOk1f41asSRLKysZeLX42JW8Fhct1Ene2YXZRJPu3zLAplD6BHbJCxcVV5sgD3XFjsH5hEtPvh0okasdjaNNBX3e/fhWwiYCMd/5GfzUPkX+ayRR9EeaNx+yUNlscvBO0d+6KwYKNo3wNgO4C4sXc20Mtd/cLjonozUwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AokiwHl6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3134c67a173so1841314a91.1;
        Thu, 12 Jun 2025 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749783090; x=1750387890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra9cExndnBnCkprKs7BLcYcowBm6Cm7GgCObHl8u7B0=;
        b=AokiwHl6d/jyml5ILrFuY7huRpvYTofjzLAJEPrTOAR3z/TMc1g7JrvaPYO0Rc1xON
         HnrxAEnZUJbdR7X9OVsDimlGbQheikrBIjU0JFDzm6pBl/Ue+DW22bE4jPnzNLh98Kra
         U6QWH+dsANuMp7wKCJ/nrOum341BaNjv98ogMQU1FMb9whRpY2peT1Gwjkt4dz9B950B
         vgcGHp6ZXgEPAvn90+9sZg6zHbe/d5E6KB6CWyZ4elKzREbLkW5fqb1VEr2Bs4EEcc8P
         sy3LiLXgFHZ8ro9YeBvEgXBXoEW3tRljx86GW7xpzDVmgrvU5uOEWSKHbdBmfqGy4RR/
         T1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749783090; x=1750387890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra9cExndnBnCkprKs7BLcYcowBm6Cm7GgCObHl8u7B0=;
        b=OqWmhLg41PX/mr2NBSHzo/HP2P0vy44hBMBxZOuSon8QiU0of6ALLl55/+cvn5eKWP
         EjEXJ/8ynVG9rA1IKGYUE43b0/K0mpeX+CkGwc4FNWIcIhblBxv1eNIcBXNC0X2HEtRE
         efdOjoOGJw11wwH3dplOrgo5RA3slMDVEFuf6cjihWzJbCAo8JvNLU4x9tATINoa1k/R
         Z/xZKZUHtoQTyLI8tEdoL+vvBDGl5zeHV/wZqOQMr7ysbV3V+kphBKWTP+scCkHX0yM/
         7DjI5pm1qtrjvigODNDHcd1/CU1WWYzz8vhvjP2Oudp+V6Ah+vF2XNmHgTcSQ7ZEA2Lc
         RuNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2NDbs/Mx8yEdQwYUQb0J88Q4mkA4k5lEb5mvaioVmbFpYVmUWaXmLtcv78otYwl3wGpZMy040xRv5aphJrQ4k@vger.kernel.org, AJvYcCUs5H0OHeaxyjb2ppopheX90tL9K6FS22tT8gV75AfsiDzynkpUHJMJoDa7yNWBeic2Z7VfsI5cLYI=@vger.kernel.org, AJvYcCVUoxpmAOf/k8nyw6vgNxj0ucPYzNKivlrKBXYhkuh+bFzmCtQ+zfCcaQMImuQR5BwSDxctY+IqJVNerBfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kuYhXPPniqLlgWD1D0o9ZCgD6gio1gYrr5vJbeIRkRe0NA8n
	pIuk31RqGDid84S7HI1HiEK7FqpzBoWoRvtlEHS3mEVbYMaRTefDr9jYI7bDFQ==
X-Gm-Gg: ASbGnctGAfLjDdzb9eYYSN+9MndRH4tBNaierlr3k32qlIdW6IaI7D1NA/m7KBeTFZr
	DHwnmkt/0iRRskc+CwWygIUkWybNTVxM39F2OdHhIJMvVAv51OjuWZuip8fTl60s8humkIeR8ue
	6x59takVQcHBNkPLOEOR6Fy3a/N/26BHRZjNJOQ8DCMl0bwLo88vUyVasj7Jo5FOWBx0B1DcW5d
	svAZGWTBfa52MtpTaPHcRpT24co646F6d9Z5jzrp3L9iwD3Ob3aqHfJpSgJzyXSSloDXVL2wMws
	M/kV/S3gg3/1iZbG/RebqeXOD95gmdxKCetwACgYWlgXwqq1KE8muHlkWzCryQ==
X-Google-Smtp-Source: AGHT+IEFIW+hk55erjdfvMs8q36sV6zpZxBoIumsFRAZqHkWRlvOCXoptdP/6UKJRq7CoUmRh2oN1g==
X-Received: by 2002:a17:90b:3f88:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-313d9c34df7mr2183375a91.9.1749783089653;
        Thu, 12 Jun 2025 19:51:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca40fsm4395705ad.208.2025.06.12.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:51:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B52B94209E8D; Fri, 13 Jun 2025 09:51:26 +0700 (WIB)
Date: Fri, 13 Jun 2025 09:51:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] docs: netconsole: document msgid feature
Message-ID: <aEuSLruZE1Vaf3E-@archie.me>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
 <20250612-netconsole-msgid-v2-5-d4c1abc84bac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jFl0jUX2FPV659L"
Content-Disposition: inline
In-Reply-To: <20250612-netconsole-msgid-v2-5-d4c1abc84bac@gmail.com>


--2jFl0jUX2FPV659L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 01:02:18PM -0700, Gustavo Luiz Duarte wrote:
> +Within the netconsole configfs hierarchy, there is a file named `msgid_e=
nabled`
> +located in the `userdata` directory. This file controls the message ID
> +auto-population feature, which assigns a numeric id to each message sent=
 to a
> +given target and appends the ID to userdata dictionary in every message =
sent.

/sys/kernel/config/netconsole/cmdline0/userdata/msgid_enabled?

Confused...=20

--=20
An old man doll... just what I always wanted! - Clara

--2jFl0jUX2FPV659L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaEuSLgAKCRD2uYlJVVFO
o5EYAP0ezHyTgY2PjRyMobbqwHdfe23hVWaliduCGUpmgbr5TQEAzUNwXHGufsA0
9GM35k7IsSSST/8lNYnfO56GF/TSsgM=
=bA9O
-----END PGP SIGNATURE-----

--2jFl0jUX2FPV659L--

