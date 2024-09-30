Return-Path: <linux-kselftest+bounces-18681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4698AC59
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7BC28178E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD119047C;
	Mon, 30 Sep 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzpE/FBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C491991A4;
	Mon, 30 Sep 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722041; cv=none; b=d7xvN+bCEtyf5Cf+PFXX31Slhs2P4xChJcB0e85XyQy6TydpTN0/7gfi+aQpRF2qmFigY3HR8lDY4VduUJIMI9hGlumDJ2mit0k98k7b3vxggHMERzR3kuDRxNvaNNXZ+xmZI2sE1g8qYPKp1ihrxd/YfEUDa67CCKpFAyFXyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722041; c=relaxed/simple;
	bh=wlKR5YJKB1mmVV3+WAkqqj7X5XgFZixGlMgFKAXGVmc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nnqMY2uLNMHDSFKAJ51H0LJI/qlUSe1NLMjpsxXgxcszsiP6GprjwBksOkmQD0tqQzlh6yy9u2cAlYvlB5HfKuNY06LtuDrD6vVJmD143GsEBJCG9owvmCa+4qAzXES9Lz1r6HTngew7gZwYuiwuKZnn+ugj4PR2XDztyQCKu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzpE/FBd; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e25d15846baso4028748276.3;
        Mon, 30 Sep 2024 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727722039; x=1728326839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9KMPP1jbyyxtbkcgcPK1qa0G10Iw9wXQN8QIpti5/w=;
        b=AzpE/FBdmvwqeFfSMy9IFlGrjD7dbuHrJNtptwrpk0yhq/JfaqCFJ7nKDnxDY0JP62
         Oyb+SBnnw2047oe6z/Ue0aPpRUvrJ4Nz8DedkjF/tW8ciZ2/6uVtcbQdCIwYgwxuzlAT
         nyLZ0exLdJfIq8skTXhBf0/qnpEmCQhhY6H1Uu/tYNhWkieIrdSpp5dbuR0HqFf0Q3Gq
         aTRwjJh6TAQjwlt8Y+WCacX8QWn3uk+iKx+xmvFgoiRwwEgpjcZwDLpXfAYq/Jhr5Xnd
         OMTDZeEko8vI+kx7Y7PqHgaU+txO3mGCycsUaCKFSZF0ZQoCs5CNNXvg0cobwbtF4C8f
         iyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722039; x=1728326839;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9KMPP1jbyyxtbkcgcPK1qa0G10Iw9wXQN8QIpti5/w=;
        b=MT0FATLN/+HDLmgqG0M3r0ny0YNX0bjuFYk3RZGIC67BsNOcSYmyqjEkOC2v8ygqpL
         VWfFRGOZgLxOi6VWQp0/KJuF/DXjw4NufF/V5cs6ch0CnGgFPC2GuLrgvJWG+rcsAAgR
         XfAm5nfXvOtnnMCoNvkWroZcVB442E7555VTSDAwOZ1uZ87mI30YG7mUOndYf9YrrmGH
         OeWvERJUQt2xT91P5VyB7z62etkUMQwiOe+ph8AOCuzZhorI97l/CRh96rSDleQ2zuu4
         NCK8FKfCQO5caBjO7jltg8WjRemkClSd6jMs3u/BQMUWf9LLNOdxS3Q/0S77xUg7/uVf
         HaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCZbKvFlB8TiMe/dZcILuCgTPYpIk1lQbLeDqK6jvWWtvnQ/7wCjm7YmzF3XI1g2RPYDDuttqXL/A9kSM=@vger.kernel.org, AJvYcCUMJJFjwjtq+ODWOV70gyJVrOO8I4xaH7mb/uiNf2rBaOftMPkqamGQMrKh4lsrirh0W5Ocb7ijDIY6Q0yLMyIM@vger.kernel.org, AJvYcCW5s2AVST0d84qQHF5fnHTGWbinxWZx+PmfKLWA0HLRbPgC45i5oQ96Xaa6w33UT2BRnK27Bm2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaOYsima80fouOTunccWkmDaqVjkxXBjQkHfTdE3QegnPomvP
	xeM/1ZEe6lej8G1XRm5qM6P1oXHwewcf2uv1AJDPu379NL85YHKp
X-Google-Smtp-Source: AGHT+IHL1BKLenw0daNrXqmMBT6YtFG5iCpdSCAsluFTxb9w7Gu9kxwH/P1PDrObdQkb6/fTphuFKg==
X-Received: by 2002:a05:6902:2b03:b0:e22:515e:7e7d with SMTP id 3f1490d57ef6-e2604c7b782mr10782836276.35.1727722038983;
        Mon, 30 Sep 2024 11:47:18 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff1basm42375786d6.12.2024.09.30.11.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:47:18 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:47:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66faf2363787a_18c93d294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <83297afc-f2fa-4fb6-be0f-f73905f726ef@linux.dev>
References: <20240930162935.980712-1-sean.anderson@linux.dev>
 <66fadcd4b8f08_18740029417@willemb.c.googlers.com.notmuch>
 <83297afc-f2fa-4fb6-be0f-f73905f726ef@linux.dev>
Subject: Re: [PATCH net-next] selftests: net: csum: Clean up
 recv_verify_packet_ipv6
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Anderson wrote:
> On 9/30/24 13:16, Willem de Bruijn wrote:
> > Sean Anderson wrote:
> >> Rename ip_len to payload_len since the length in this case refers only
> >> to the payload, and not the entire IP packet like for IPv4. While we're
> >> at it, just use the variable directly when calling
> >> recv_verify_packet_udp/tcp.
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > 
> > Not sure such refactoring patches are worth the effort.
> 
> Well, FWIW you commented on this in your review, so I figured I'd send it.
> 
> https://lore.kernel.org/all/66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch/

True. I meant if respun.

Whether such changes are worth it as standalone patch is subjective.
And I get where you're coming from, given that thread.

Reviewed-by: Willem de Bruijn <willemb@google.com>


