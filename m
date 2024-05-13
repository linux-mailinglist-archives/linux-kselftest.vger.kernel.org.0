Return-Path: <linux-kselftest+bounces-10124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22188C39AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 02:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1D1C20B21
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171C7484;
	Mon, 13 May 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOqVZq6v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0C6FC2;
	Mon, 13 May 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560990; cv=none; b=e77eJPBhzmQMYDQWzF7JSADRPEoDmq2nfF6B63RNaK7vCbQ1GViUxuCP/TxRDAkeKwmjuNDGpXX07T4/qBtOjgdCkr0h7o+LLPD5iVCcZrlZZCLn5XQiVro3+lkP224jc2KeDejSjwJEGp2EpKYcGH9HBE2rw4VXzGzIq7mPjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560990; c=relaxed/simple;
	bh=dLUHedqTLE2k6E1OvZAEYDSZFfIFsDbOzJeTJwXgdUw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IJLPs1nsncV4wWCkPmiRptCUsEN19ZT7/yb5H3sHIMWmSJf9bUV/LxS+bUN1DXYA0bzoOSmgaAUrjNHlQO/oDtwO+DBhqHZohMjeGfRZtMMo7AEHzGfkzJnOJcYPWqf3MAiXTn0Y+1vTQyRCheu3EQQ1WoGRcndq5osR57Kwbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOqVZq6v; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792c34f891eso314382985a.1;
        Sun, 12 May 2024 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715560987; x=1716165787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etKO/mOZpG5gRuJLHMhccLvQr/g8BHMhEr7ucEVcBD4=;
        b=gOqVZq6vxI1Kp0L+MhHK5lZhGw4jQo20eKkg8Is5KVf714T0srg5grk8lNxjC1VbsQ
         EboQhK7Wxp/LnxeU9KLLumzvjSX0/YFRas20LZBxJvRRVmLPND+yR3IET3dlszqgY3FZ
         4m39nI7Cjy02WPp6Th+ixFteL9se+APGyOKboRol1a/HjKcKWzzz5MROOapXefUb7d9e
         EVIa4+yUuC8efm7TRkTbRZGbE/i0SCXLU2DieWMLb3MbTAIi6rXNtrkZjkoun6BfT78e
         Nh7W6ZeC6KZCIQtp7tLm3PkjT/rNr/fX1AOcvaWHuSmqrhOoEiZg3E9Y6cruFLZHKRJh
         vAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715560987; x=1716165787;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=etKO/mOZpG5gRuJLHMhccLvQr/g8BHMhEr7ucEVcBD4=;
        b=o4RTRMUMGE1KVlAU+TgkbgE5WQoBY6WkRBNVHQmEa7p9n8V8vLu7YUrEfiWOF4tiX4
         RiHQGDRL7EZfCviMFhDATTTxl5jYqXaV3H3TIIcqJUiYGEER6aDrS8qiByfGGl+UCY5e
         VX4i8Xx/jNpPhqbR8Tbn93jQBuc9KwSa/Qt1CVh8/sGb1ncB0HXCzA79T0YPxe3dJomn
         oS1oDjCajnxdb0+jBHKG76wtKqCsf3IN/M9z6BHMUqu8EgWKDKCfuHWz46vUbyq40TTq
         RT7wcOLLnTrqxiKNk4exfYv6ojkcxb5rn9u+29bnGSzfP+E597YeGUmrKL4vVEDRm2xf
         +bMw==
X-Forwarded-Encrypted: i=1; AJvYcCX4aBLzLYwVxY0YQvrBnXEbbWeVDn2+o6tqHZT53oVO6iUqkn2RJznUWfBdgaO3dcZDK3nd6fb1DjNXxd8fbpMcVy5yEH9Ey7DJTNVyiiRSRCdfnlSGIlt9LE4tBAIWC4fS1Sock+sYErihPhNLSahi+yZ1S80cjov3sIsV38lQjSbCM/r3
X-Gm-Message-State: AOJu0YzVkyafgFFIiXOyXum8FWbRvm8DAl1M96g/bzh3s2DKVDX0IjpI
	3iLYVqNKEbhvnnFPo+1bRj/Yy7Mk90xoUCMiY+I8Dglo0rQW3Yf8
X-Google-Smtp-Source: AGHT+IE+qHC/EvACXpTQJp4HbD6triYEnSehqBb+djbiw0RtJzx4W4lQ12DF60j0Raa88xz1VBg0ww==
X-Received: by 2002:a05:6214:448c:b0:69b:a42:5c85 with SMTP id 6a1803df08f44-6a16819ef55mr94597756d6.30.1715560987503;
        Sun, 12 May 2024 17:43:07 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1852fdsm38808916d6.32.2024.05.12.17.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 17:43:07 -0700 (PDT)
Date: Sun, 12 May 2024 20:43:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 alexander.duyck@gmail.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6641621ac1e27_1d6c6729465@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240509190819.2985-2-richardbgobert@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
 <20240509190819.2985-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v10 1/3] net: gro: use cb instead of
 skb->network_header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> This patch converts references of skb->network_header to napi_gro_cb's
> network_offset and inner_network_offset.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

