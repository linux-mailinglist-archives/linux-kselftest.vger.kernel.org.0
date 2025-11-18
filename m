Return-Path: <linux-kselftest+bounces-45822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B539EC66F94
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50AF7343549
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1A313E2B;
	Tue, 18 Nov 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c34mmzoJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110E30FC22
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431649; cv=none; b=Yj41CUYZo1jn5Zdvy0wU6ixMyqs7hDcqVta4UNsXHVTTwbU2ZSScWtJs0CMgkyhkBd4ce2Jtktn17CBb2wD+H0YveZZLz4PV/8hjOGQjzEl8IKijB3gl05i2TcQSawYiGmCvajpyk/4lO9WEEZbHgrdWZAbtC9F71DGB7iAgOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431649; c=relaxed/simple;
	bh=d0NCOZJJNo/QvvUVi+5418KFMdeGfap8AvEyEU4ZiJk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=huQ3T/Xm1QauLlIV2QJbwXc4FUS5VF4QOKt0/aUFX0YWRrTLqVvBpts8s1sRaTzqvzO5leAIAumR8LnnGFNawUrfkhPtrOtPxhnduQR9mL8QH+E3LBGF+G/tC6kDjlEa8v7exsApVQs00oHpZdP9dFqcO9evJ8WDk9rGgDLNL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c34mmzoJ; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640d0895d7cso6138063d50.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431646; x=1764036446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+bbE3OhXJxIQdLe1DhINb3qNSZ6w1hgqNqphxg+ayg=;
        b=c34mmzoJxihUWekbUYpyYxN+92101A8A2cSY8feYKqnncI6wTJ78/e1BLvxxcQawZc
         mETwugMfWobxO8DWASEwYwXH8TcR5tNZPbuLw/Y1PIR30Rf0IFUOK07XbG/ksS8YNrGu
         KcIU+4fa18lKigC3Xq+IvJO9zbVp0UskVOt3IrCCf6q6aKNXcqQGV3VYHpohPU8Z3DBW
         OjryhBmUThWRjxsfIIxuDgCbCcgT5Nsclq91CUlSyy7AbjQn8RsJHouBJL1VWP1nGBwm
         sY1GFu0bNaMn18yl4xWYWB5uV0jnIbwXu29UNI7n9YJxXVtJy6bJ20+yrM1kIuIOPuHi
         mDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431646; x=1764036446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+bbE3OhXJxIQdLe1DhINb3qNSZ6w1hgqNqphxg+ayg=;
        b=tkl1PUolAYVPT6DmQ2AjsJpjqX0xsfnevLCrFnlTHP9BTRbBmwXF+x4nmXObCob8Ut
         p1VPaLLsfvm160wrikHKkF3Nhwzw3hAEnWn7qFLVUX3izt4FUzQUBjG71XhLenDFe2jX
         0Weh4gNYr2WTF8K4wsgrDmLYAAVMFuU/7hWsZzBmEGnqI7mKsSM85PJrjHuUTPFF08yO
         N8mmWCSlzRWiPxN+pUbCHHzDr7NhkIyg/0MKrDKDZoQG2mekPUsGGpOsWDBh1wjF0jME
         oljr1bDkdzhq0fmMEFuj/27Y+QZeIgJZrXvYO7dZto+OzP2eBT9D9Ww5byU+Z7PaNXOM
         70Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV3+s3MDGIhhyDhC+EqeY2IzybutKop4cgzlbuO6bSU7uKAUPbG1gi/ISooZluluqdFzreuB/XeD+FSfny4iAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZo27OQyUphN2pLHYMO93dSzsJIH70DEpTG34bhRUBHHkbo/3
	HIDcjTAl1rP6O//an9nLnj59r77zz8MBGzLSJxhy3v/b0jeCbhPCAir2
X-Gm-Gg: ASbGncs5AD5PPMOwqLzD74/8yjj4Qj7tRpEMzjlF2tUQohVm6S3jCG1i4CR9IOEawAg
	wDmFa0nFP2Emvo8FnKc8Bw1Qcjvt2m3W0bvkSO1mgSGHjRcYFXHB6UfQ3keJgJWj4AN1vHT53mh
	pYpDGzABS9/+hRlioAtJoUJQsrQFMokKGpshE5KCn0025ZK2GbqwDEKiLLVHEiksbNdJh8RhOYt
	Y2AuQ8xLMsprQ3MCrUlrT4nty5tAOokm0+HD0FL3LbBaZpxR6R4OoffZa1HLHn4zhsnM3xO1KjN
	yCjEnPBmN6F15WIZv+BVKiNf8VZmNCvLTmU4l7YbI9H2HnRxQ1dl4D/48KKKyEnjg6yPhgY45Aa
	0JriNhTuUXL+SaL0QHc9BeXo2RppvceDEZehQ0SIZwZrXQz6kasTUjLoG+XVoN1DdCVAiRYfscC
	iDBs058c42XFkfzwkz7d859SNhwNTlax2l6aOIekdlSZwn/arnJz/Yo6VljB7E0ryM8nE=
X-Google-Smtp-Source: AGHT+IGQSis/hizaYu2fWi7q3sXascE13j9zagyfvse+heGgaTnKZy7u+/QE7GqF+u9UL/OH1zOwhw==
X-Received: by 2002:a05:690e:1306:b0:640:d1cc:2be7 with SMTP id 956f58d0204a3-64213502521mr1374662d50.30.1763431646034;
        Mon, 17 Nov 2025 18:07:26 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410eabbd71sm5309016d50.16.2025.11.17.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:07:25 -0800 (PST)
Date: Mon, 17 Nov 2025 21:07:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.262f4158d9fe@gmail.com>
In-Reply-To: <20251117205810.1617533-6-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-6-kuba@kernel.org>
Subject: Re: [PATCH net-next 05/12] selftests: net: relocate gro and toeplitz
 tests to drivers/net
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The GRO test can run on a real device or a veth.
> The Toeplitz hash test can only run on a real device.
> Move them from net/ to drivers/net/ and drivers/net/hw/ respectively.
> 
> There are two scripts which set up the environment for these tests
> setup_loopback.sh and setup_veth.sh. Move those scripts to net/lib.
> The paths to the setup files are a little ugly but they will be
> deleted shortly.
> 
> toeplitz_client.sh is not a test in itself, but rather a helper
> to send traffic, so add it to TEST_FILES rather than TEST_PROGS.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
> index 6942bf575497..8feb7493b3ed 100644
> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  iou-zcrx
> -ncdevmem
> +ncdevmme

modified neighboring line

> +toeplitz


