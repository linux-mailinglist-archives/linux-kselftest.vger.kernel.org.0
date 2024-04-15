Return-Path: <linux-kselftest+bounces-7991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAA8A5664
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747471C2040F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE72178B50;
	Mon, 15 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laIGp7W7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66660EF9;
	Mon, 15 Apr 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194930; cv=none; b=bjjbOfqX/Td0BoaRdCpLs58ge1WPGZXxmWrgfr5H8XquyPK9oF5hC3bo5VGk4Q/iQOFD1dAxWJ7bx9NNIyBnP1JuB7ugriCQg/JalRGXcdxwoSWZdOl9X30NkIN3gzVh4BTBDf6Hsjq4iGElywOFLlyI5+a6d75/A709mBe6zcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194930; c=relaxed/simple;
	bh=m0sB9eCjIqzz+E4+mSkrkZ3C/EaeCzMVFfX5BdgG2g8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Um5CXQcSFkh6pwA9cwDPFGvuwdMUpSX3MkpNQiRls/5y8ECt0ApSLH5WwwSLOD8jRarjVTYLZ7CVLlQTxZwqofQKY6ltJXfD3XQMPPeKg8g9gWNbW7fI+sUCKi7bsi7J5YPNm2E967dskUDBt7jugSCIyNMCuNITO/+hqie642s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laIGp7W7; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dac5a3fbeaso1115274e0c.3;
        Mon, 15 Apr 2024 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194928; x=1713799728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu/hutXJUSv7QQ6eI7MoPzXs3chbYRHqkbwVjfaG0ms=;
        b=laIGp7W7emPO4VfRKPX/rOUOV43hkwKMO9H9FAjZE8HBGn5LC25Ipp2Quq2/sQ7fVq
         xxZRjziyqXlqy7lIlBSov9uaLUm2KZFd6ISYgY7Fb9uBatIVK34I0dHkNVtzyXo7hkfQ
         IiJxvqIKhcX+EfFAOdHjriHUTndHCas1TmXL3nP7QAVF8HVPhUM8cxbqrmUVqumOkuwm
         h3z9xaOCSiYbWT5RDSkfKi2Cmt15Es6S0AyA+2Wib5KHCiKgL9Q4hjyRFvOsO3iZGCCx
         8h7Gy90q7auv+GiRfmkJJynWlWEwDxW2NdRIk4Lrh+99p3ihpW7oLiAq4bDgnHeCwsul
         Zcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194928; x=1713799728;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qu/hutXJUSv7QQ6eI7MoPzXs3chbYRHqkbwVjfaG0ms=;
        b=XGQGcnpvM4XVmzW1MZ3xdeAJm6rwjWUIaHMD3IjNTvPnadYY+rr9VoCZ8OrWrtOpX3
         dcjv6OTstDacU5A04Wy1oA65yOMLuSol8ZuLb4rWUcXtIAZXUwZD+emvYU3yip11UlPm
         yKqcl8Q4i5YMezLI/g7fnEhQiwHh23v7Mi43HtNFqKDIyzT2odhcb/gGXn36oKfyFzVr
         E3uebEXJDJTImV8+zjRVq6AT+rWKvoHCcAVQUC8t/gsFjylYIuxOb/ZcaKILnZ6Wwkov
         0UCEtossolzTa7s5/Qw/YmrxFpDpoZ+3elZiqWpv5WqC5f8BKIxK4o8djQM50c/Xraeq
         5NNg==
X-Forwarded-Encrypted: i=1; AJvYcCUwQE1iQSiEQ5wK0ewjelDVRDxymGhCv/8MnMzUb8eHCI+r3eGg+0piVQOiFr+dMdtnmYPCQTOZGVKHaFnSZZrl7gfAYawacUoHm5soxBeQcH7oC/fm9P8ZwnJ79tlmRGt/yzY4aDRe
X-Gm-Message-State: AOJu0YzeGj9ZWBku29yxchoI0ArRFwc/Y3zewHCEScwVDs3BLHV1zDgG
	lU4sxTAHL3vc6XM2wNymJ8yrM8Q7QKJe73Zr4B8h7pekqrW9XuGW
X-Google-Smtp-Source: AGHT+IE1ruwx2bx3t3L5mvRshVQehrkGa2QMVh2CwfsvuWGskZVg978sAMZwtYeFlEOHXkqL/AtEmA==
X-Received: by 2002:a05:6122:2009:b0:4da:a82e:95f5 with SMTP id l9-20020a056122200900b004daa82e95f5mr6711632vkd.5.1713194928317;
        Mon, 15 Apr 2024 08:28:48 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id bd14-20020ad4568e000000b0069b7aca529esm1596806qvb.14.2024.04.15.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:28:48 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:28:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com
Message-ID: <661d47afcc6a7_1073d2941a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240415073109.57629e54@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
 <20240412233705.1066444-5-kuba@kernel.org>
 <661c0837eb5a6_3e773229499@willemb.c.googlers.com.notmuch>
 <20240415073109.57629e54@kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: drv-net: construct environment
 for running tests which require an endpoint
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
> On Sun, 14 Apr 2024 12:45:43 -0400 Willem de Bruijn wrote:
> > Overall, this is really cool stuff (obviously)!
> > 
> > REMOTE instead of EP?
> 
> If I have to (:
> Endpoint isn't great.
> But remote doesn't seem much better, and it doesn't have a nice
> abbreviation :(

It pairs well with local.

Since in some tests the (local) machine under test is the sender and
in others it is the receiver, we cannot use SERVER/CLIENT or so.
 
> > Apparently I missed the earlier discussion. Would it also be possible
> > to have both sides be remote. Where the test runner might run on the
> > build host, but the kernel under test is run on two test machines.
> > 
> > To a certain extent, same for having two equivalent child network
> > namespaces isolated from the runner's environment.
> 
> I was thinking about it (and even wrote one large test which uses
> 2 namespaces [1]). But I could not convince myself that the added
> complication is worth it.
> 
> [1] https://github.com/kuba-moo/linux/blob/psp/tools/net/ynl/psp.py
> 
> Local namespace testing is one thing, entering the namespace from
> python and using the right process abstraction to make sure garbage
> collector doesn't collect the namespace before the test exits it
> (sigh) is all doable. But we lose the ability interact with the local
> system directly when the endpoint is remote. No local FW access with
> read/write, we have to "cat" and "echo" like in bash. No YNL access,
> unless we ship specs and CLI over.

In cases like testing jumbo frames (or other MTU, like 4K),
configuration changes will have to be made on both the machine under
test and the remote traffic generator/sink. It seems to me
unavoidable. Most of the two-machine tests I require an equal amount
of setup on both sides. But again, cart before the horse. We can
always revisit this later if needed.
 
> So I concluded that we're better off leaning on kselftest for
> remote/remote. make install, copy the tests over, run them remotely.
> I may be biased tho, I don't have much use for remote/remote in my
> development env.
> 
> > Use FC00::/7 ULA addresses?
> 
> Doesn't ULA have some magic address selection rules which IETF 
> is just trying to fix now? IIUC 0100:: is the documentation prefix,
> so shouldn't be too bad?

RFC 6666 defines this as the "Discard Prefix".


