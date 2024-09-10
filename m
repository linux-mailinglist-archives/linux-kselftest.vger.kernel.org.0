Return-Path: <linux-kselftest+bounces-17561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF49972675
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A7BB237F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 01:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2756A332;
	Tue, 10 Sep 2024 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoYdAhKL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142B54662;
	Tue, 10 Sep 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930096; cv=none; b=hdheeq5t4e1uEvAe5O2Aus6hDC20khEu7Pgl/65w9nLMSxDhloehvCCMvCLM0B4TBAMIf0Meq7bgwLzbJTNxVqlGGIKjNA9se06XqsIrDGV7TPnbVrr5j6k2Klg1dlOjZogyZ4wzDCQbK7r6Qwv2t6o4i6RXxmz3rrTAyb9ndMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930096; c=relaxed/simple;
	bh=LUfQhwriBKepirj2qSaUwq1Gjhmr8EhAYCNMjIWARUk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iZ3+ka1fqdmN7Ei34J96IVjozlXhlrMhIk0PLXuUuKS8wjHGFTH9P4NqmlFaZHqphWCRBCYtG9xsLbab49YrM5UeMaWLIueAG3MVRuaTNLFfrMIrJVi4RsGqmAAodvw0l8NKiYblH86YQU+7k2RWyqI3ThQcmdJBWOWNs8f8SBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoYdAhKL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c353f2f954so35001846d6.3;
        Mon, 09 Sep 2024 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725930094; x=1726534894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KPcddmPEw7t5j+56lMMqK6CWJ7aWyI9WS49cu283Vw=;
        b=GoYdAhKL2CM6JvuxUODifNAgW44CAQhOss1izYmD+deuQQTZYtmVQa5dBdxoR2qtHx
         zZt9/M4FQ63lGG3LjPpgLc42JB3EaC/1Ex1kScCLOaiOJsCVOBxadMX+37H/YY0IQKKE
         aUKR+j7n2hsnHAeMJ1nokRkqfUYzv2ygUnTOrufggo1GPyOx5+V7IaVrTOip42eCD6nu
         04GBA29eD95JW9tJ0nwz+PSys+hsTLueHUDYddV6802DcWVLfpaz9wdft6DIwvGKePzn
         Lyl6xQXhwjFMwkXUhTgU7KJs7JAr4O2WW9HrZGkgMpYzBjprtDHEeKNmgKq8PuqWdjrS
         fbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725930094; x=1726534894;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1KPcddmPEw7t5j+56lMMqK6CWJ7aWyI9WS49cu283Vw=;
        b=p4IattDOT1KsdfdrFwsq4V3+huz+Rc4gkxKeGbD56aCPBt9Axy61HQcehWTOVt5tku
         8CYJj9kVxL37Rg1qHmEd8HfzZNRRFCbWFEZ5JGn6ngkxbpxIek2lOmUuMeKem18idHjb
         uso6/XVrp7U7HMu2icxeOokpUBSmV5z2wX2E/M/e3ePqdCekr/11Hgo2A9bK53zVAJig
         o8wFPqErGqfrLWrxrETVnTcFUTUVajyYpmQmI9woxhXEoXOkc+KuPJELJWw2bCOfTGCK
         Xezn1g8efOrYIc7aEkUF/ARaeegSBi9HuDOdL4RySAXiz/SrqNkQcpULv9MU+xxtEUiN
         U/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUzPMZ3skdL8wtvQwZ2raw5Q9F+tZ3M8YcXB22ijd15XjUZUpXi3/1SxRRPSNlpgmW9/XoBQxr6Ymcv6xwRDPq@vger.kernel.org, AJvYcCX57E/xiIpnLefpKD21Qj4fozmdXb3OwFbbDUaF3xbfXB3f9jqh3LLwgrW3go7BzMlMNQJHpgWcqKn3H0c=@vger.kernel.org, AJvYcCXuXEIeJmxHr5x5dNDefsCQiM0zs9BokdAuxWuc/F3RfAgxPj7kR9GUe0oBfw97/vLlXSk5HWSx@vger.kernel.org
X-Gm-Message-State: AOJu0YzemNE4bcdkyw3pFRdDvLa8EFZYe2Te0hzSvfmBzUiYERtUan/Y
	FuotZpLjKAw8eqlH16eHpp6p0JOnYNvtPJUzFEm5pb4G8DbnY87Qku6K5A==
X-Google-Smtp-Source: AGHT+IEjXvFct27d7exXJ49Y8l38HsPhfF3k6B0wu56M3kB2z14oGMNdvuv/mGu7xVQjjmNAtAjVSw==
X-Received: by 2002:ad4:4046:0:b0:6c5:5086:4431 with SMTP id 6a1803df08f44-6c5508644d6mr34839496d6.41.1725930094047;
        Mon, 09 Sep 2024 18:01:34 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534774752sm25654496d6.117.2024.09.09.18.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:01:33 -0700 (PDT)
Date: Mon, 09 Sep 2024 21:01:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 "David S . Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <66df9a6d42871_81fd3294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909165116.1bdb4757@kernel.org>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
 <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
 <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
 <20240909165116.1bdb4757@kernel.org>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
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
> On Mon, 09 Sep 2024 13:26:42 -0400 Willem de Bruijn wrote:
> > > This seems to be a bug in the driver.
> > > 
> > > A call to skb_put_padto(skb, ETH_ZLEN) should be added.  
> > 
> > In which case this test detecting it may be nice to have, for lack of
> > a more targeted test.
> 
> IIUC we're basically saying that we don't need to trim because pad
> should be 0? In that case maybe let's keep the patch but add a check 
> on top which scans the pad for non-zero bytes, and print an informative
> warning?

Data arriving with padding probably deserves a separate test.

We can use this csum test as stand-in, I suppose.

Is it safe to assume that all padding is wrong on ingress, not just
non-zero padding. The ip stack itself treats it as benign and trims
the trailing bytes silently.

I do know of legitimate cases of trailer data lifting along.

