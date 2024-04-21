Return-Path: <linux-kselftest+bounces-8582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364478ABFA5
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38741F21454
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1BD17BC2;
	Sun, 21 Apr 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxvwQP8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7810A3C;
	Sun, 21 Apr 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713710840; cv=none; b=R/GCjMUExnKaWO9Em7dnpTPJ28pIcIIuOuYOPLP/G9Xg9Pjg+V0bP1XUbS8CFB3DLtEBbKth6HQZkQVZd7Zn8NOJQWdsB6i26vmJu8lz1vcpW0V2msuZ1mVuRbbAPQkL6GCSRfqwth0KAkpkj2sWK/lX39vZJyCfycXqxGQOnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713710840; c=relaxed/simple;
	bh=1MVDXkIkLu+31dgg42UixSS3lU9y6EjMItKxvfEfbVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P64V6XubRHYaHh14DeNMEbgJt0LC7jg2HxngOuqf6iMahfn18kV+pG1jKRSstOyd+KaoJvAKnBZcw7B2ThApVx3M3N8wiUtj3M+YW/Gbs23VAsLaAmM6vM/L5pGiaPVPBAIJAdqUz0NBiZpcIOR6xBlU3mLuKdXLGbtGCwaK0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxvwQP8T; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa3af24775so2585738eaf.0;
        Sun, 21 Apr 2024 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713710838; x=1714315638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6DewHTI1xOOKPoL2CHAtSGTVefkyM1uCnfzqZO37Tg=;
        b=CxvwQP8Tqk2GAEDppzT+bGicicRZQ+U0qiAiWCRLC2U0yl1aik92/5iizIxSGYjZXi
         YquWmX2j6IxhVMPHe6K72UeiBmLx5m6ZTrxmLnYcSMdsfbJ/zPO4Cm+/J23SzjFE+xEt
         wWR7oADwh+a+brcz71w1qjYstv3pfnelodRmJB0cfe8oJQugsJd8ffnv8F7WKVjdvWng
         8rf1MIH08t8oFZR9kuPSh7k5qliODhpMLSxDLa+62Xmrb3yMNs4hQrLuiqh3jhGUOikw
         3w1yO0NON9JxaB8gJAmV47D+aAftxRe149sq8KFty1NUMd809cdk/E+Yfkcz2LcIdIat
         HoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713710838; x=1714315638;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e6DewHTI1xOOKPoL2CHAtSGTVefkyM1uCnfzqZO37Tg=;
        b=F5Phttvm7mhY1VMTOUMhGRCHJimnCYgcZYgDOmLJP1nSsLG3zluWDhAx8oLKgR8bah
         IijuDIpVhQolqzc7PpAnJ7y1gMXrbOs5ema6yvMVL0ZcI0fmqjIYmAu5jxC10DF6bhvx
         JB1hXTE28Lty75xy8JUhW5satLndgNVzCyamJ9vQzH2kUObySGPfzsnfXUtlhxMd12MN
         hl56DbmO6e1D2LzlhIwSxybjJ7bn5kygnOb5Fh8YTROKNuX5AvW1k9UZDgjUX39xGV0s
         mmltAdWQWlOKykAidCwV93d6rjxkMN3A6DvshkPmCJev9k0e+ZU6k7VQN7RlCYRJRz3k
         sfhg==
X-Forwarded-Encrypted: i=1; AJvYcCXOtizGvm2bY7F+lZpRXEHThtL6ZsxQPzQ5lawDBDvYOzXxzkBq15GP/e5rbo3IbTEw/MAse1zKQhSI6hXuJavWlA0BxTVZCXGDIGKbdoZX
X-Gm-Message-State: AOJu0YwVoDRzx1soitbrWeGpfJoiTT/KAZkwsxx+eg/E+7CGejYFudR3
	JGAL3qaHmyouVljRsaoEsp3oOqno3l6SIqAJJIuN8aANjLXG28/U
X-Google-Smtp-Source: AGHT+IE0XztwoR29xhql47OOZy9KKaTWe6U3LARIOGFBlItpID9/uPHk0oEVi74+vwMBKGRu4Ar17w==
X-Received: by 2002:a05:6358:5bc1:b0:183:d2fa:ff5c with SMTP id i1-20020a0563585bc100b00183d2faff5cmr11804663rwf.12.1713710838300;
        Sun, 21 Apr 2024 07:47:18 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cf0d1000000b006a04769b5a7sm3359356qvl.110.2024.04.21.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 07:47:17 -0700 (PDT)
Date: Sun, 21 Apr 2024 10:47:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240420025237.3309296-1-kuba@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing with
 a remote system
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
> Hi!
> 
> Implement support for tests which require access to a remote system /
> endpoint which can generate traffic.
> This series concludes the "groundwork" for upstream driver tests.
> 
> I wanted to support the three models which came up in discussions:
>  - SW testing with netdevsim
>  - "local" testing with two ports on the same system in a loopback
>  - "remote" testing via SSH
> so there is a tiny bit of an abstraction which wraps up how "remote"
> commands are executed. Otherwise hopefully there's nothing surprising.
> 
> I'm only adding a ping test. I had a bigger one written but I was
> worried we'll get into discussing the details of the test itself
> and how I chose to hack up netdevsim, instead of the test infra...
> So that test will be a follow up :)
> 
> v5:
>  - fix rand port generation, and wrap it in a helper in case
>    the random thing proves to be flaky
>  - reuseaddr
>  - explicitly select the address family
> v4: https://lore.kernel.org/all/20240418233844.2762396-1-kuba@kernel.org
>  - improve coding style of patch 5
>  - switch from netcat to socat (patch 6)
>  - support exit_wait for bkg() in context manager
>  - add require_XYZ() helpers (patch 7)
>  - increase timeouts a little (1,3 -> 5 sec)
> v3: https://lore.kernel.org/all/20240417231146.2435572-1-kuba@kernel.org
>  - first two patches are new
>  - make Remote::cmd() return Popen() object (patch 3)
>  - always operate on absolute paths (patch 3)
>  - last two patches are new
> v2: https://lore.kernel.org/all/20240416004556.1618804-1-kuba@kernel.org
>  - rename endpoint -> remote
>  - use 2001:db8:: v6 prefix
>  - add a note about persistent SSH connections
>  - add the kernel config
> v1: https://lore.kernel.org/all/20240412233705.1066444-1-kuba@kernel.org
> 
> Jakub Kicinski (7):
>   selftests: drv-net: define endpoint structures
>   selftests: drv-net: factor out parsing of the env
>   selftests: drv-net: construct environment for running tests which
>     require an endpoint
>   selftests: drv-net: add a trivial ping test
>   selftests: net: support matching cases by name prefix
>   selftests: drv-net: add a TCP ping test case (and useful helpers)
>   selftests: drv-net: add require_XYZ() helpers for validating env

Reviewed-by: Willem de Bruijn <willemb@google.com>

