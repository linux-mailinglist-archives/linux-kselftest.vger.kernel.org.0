Return-Path: <linux-kselftest+bounces-23531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A019D9F6E66
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A534A16E712
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9071FC10A;
	Wed, 18 Dec 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZK6MbXx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202A1FBE8B;
	Wed, 18 Dec 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551022; cv=none; b=bsnGbxol9IWrZ9wLkuGpKkF1KC3+kwAlHAqOPgMhk/KDu3KgVe7M5TG1TgST1dhwDeZxKvxms4I49w6lCGGuHo0045FOBI/0C7NnuUmMYrEEX/KJPXlnK95+HqJM1TlTyBEnCr1hC9b6ZOUg0RfmhqwQh0oNC/BU47CpHzABVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551022; c=relaxed/simple;
	bh=l7S33bHbPv12y5MB/1TViiOYMzTYdR78PVLDT5uOyFE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cFHS9/akHrqFbij3hWidyZ8YLFiEcwNT0EvrjFbM2F3iqvKbt7zoKYCe17fNVoGhdpQm9QU0kt430eJiHbWITYjBdMFDuyPERKH4L/5xrWnrnYA9V6Ld0aV/8uYQrEMLY92a5y4lQNJXUga6WVZ5SBI2jiWN5OIeLLI0Di6ZQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZK6MbXx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6ea711805so674202185a.1;
        Wed, 18 Dec 2024 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734551020; x=1735155820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxHIHcJISlyh3hvAawthVoj9sM8ECvEnIfpSQ48jers=;
        b=mZK6MbXxsnaIsxHkd5Sf/SBrerM0aZY+cBQA+ZAl28drlPO+qr8EANV87+P4K1Msd6
         WRin/9TPyJw0d6LBJlFPWaDiz5DhigcNKdGOE+vTiyZTLUoxTRx0JiZiqOAusQwglNz7
         xLFBPXKqr6OAa8La1lnG3VBCm/+AJi4sB995RINLAfn+jL/VSiKtlZ0qxL0JVcckEErF
         fFr02nw/2lYur6n+plu5f8X2+4En37RRz0VHrjIIV3msDJKKsiNW6L4SYxD7P9aFhe5D
         RKbOdzm0n5tY9Y1Rfgsy1TV3EsEKpKk/db/3SrbGzuQov1RwR69qifBaHEa8J6DcszH3
         fEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734551020; x=1735155820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxHIHcJISlyh3hvAawthVoj9sM8ECvEnIfpSQ48jers=;
        b=XLGkZVdGZo1AqVN88hjTsyVHWwj4Vn+94KgnXGQ2CmLI/gBKe9DBqPwCogU0fMTmzV
         KPpxx/v8s2iW8AV0p/M9WabgZHO6Kpf0p5pEQUXfkFipzw6IQd4Vyace9w6drYLaZ2R9
         E3B3VLrwq5PSq62lfFx8JdFgUCSFwSt0VCY1wG6mG+DeuAUVj9UzDiGpelSE/OfEtVN4
         PPpyKE8kmvwUEY1WKKVV5tw9SZKa6fuaHs7w2cZnyx6cKBM6LBIlk4amPP8LGmuwxuvB
         msAdboTN4QRfS19zYHXGgydtz6R7BoDngjzZPLlpR3A1Qilyp67FxJMh+JuGvzEdlACo
         gjEg==
X-Forwarded-Encrypted: i=1; AJvYcCWsRBl9x4IauV9eHQYClRP4WdDc+JJ/8aADoCR8ku/zZ5f51CJ0oo1/WmBW17dLSqpEs2T3EBEi/XNb2Rck5ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyepdqGvkxT3Khnz40PL1PNLfBme1Vb+fS+qGgLqnfsstgpX0ev
	kwKf8Jn8+I7SvLlyfFBKPUo0F89jomac854wHP4WjHgV6ibmcsSw
X-Gm-Gg: ASbGncv1q5G29c8YJwyDXNYlTUhOEu8rOtcibjQuSKJtBH9ZevqvsMnvU7Iyn6sDPDm
	RPt4rk7Wzu+dS5FOswiCncMKEE3nBVcELvNLF7XN8J5zTCDFfHuQQ56QSSvH++X7253RQ6MG/Yn
	aMs2ZKdUcfOzVEl193QmbqOeDtOtZyJnazMBZD4KhD10h+uu98EpEzOZJRmesKFV4VlStEMvAVc
	9QaNO3gAlRkE2Z1oBJVkCHq8CzGyAR0eeCN1YNLJ9/HzdsxXtrofxCsNff55EXV1PxaxoAch3hp
	sZ1faiw0Rps6pG1MLwgD6KCv0pLmb5+SAA==
X-Google-Smtp-Source: AGHT+IH/ecVVUVKtNKqq2lfFmmL8wMcCOOUq88vGvAYCM8VR8V5fbanjnDzTzGYCMzE3Nk4vcffkqA==
X-Received: by 2002:a05:620a:28c3:b0:7b6:cb3c:d523 with SMTP id af79cd13be357-7b9aa9a9c54mr76745085a.46.1734551020131;
        Wed, 18 Dec 2024 11:43:40 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2cbe7f2sm53947831cf.45.2024.12.18.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 11:43:37 -0800 (PST)
Date: Wed, 18 Dec 2024 14:43:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Soham Chakradeo <sohamch.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 Soham Chakradeo <sohamch@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <676325e9c736_15b53229460@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241218100013.0c698629@kernel.org>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
 <20241218100013.0c698629@kernel.org>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
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
> On Tue, 17 Dec 2024 18:51:57 +0000 Soham Chakradeo wrote:
> > Import tests for the following features (folder names in brackets):
> > ECN (ecn) : RFC 3168
> > Close (close) : RFC 9293
> > TCP_INFO (tcp_info) : RFC 9293
> > Fast recovery (fast_recovery) : RFC 5681
> > Timestamping (timestamping) : RFC 1323
> > Nagle (nagle) : RFC 896
> > Selective Acknowledgments (sack) : RFC 2018
> > Recent Timestamp (ts_recent) : RFC 1323
> > Send file (sendfile)
> > Syscall bad arg (syscall_bad_arg)
> > Validate (validate)
> > Blocking (blocking)
> > Splice (splice)
> > End of record (eor)
> > Limited transmit (limited_transmit)
> 
> Excellent, thanks for adding all these! I will merge the patches
> momentarily but I do see a number of flakes on our VMs with debug
> configs enabled:
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=packetdrill-dbg
> 
> In the 7 runs so far we got 2 flakes on:
> 
>  tcp-timestamping-client-only-last-byte-pkt
>  tcp-fast-recovery-prr-ss-ack-below-snd-una-cubic-pkt
>  tcp-timestamping-server-pkt
> 
> 1 flake on:
> 
>  tcp-timestamping-partial-pkt
>  tcp-eor-no-coalesce-retrans-pkt
> 
> LMK if you can't find the outputs, they should be there within a couple
> of clicks.
> 
> I'll set these cases to be ignored for now, but would be great if we
> could find the way for them to be less time sensitive, perhaps?

Yes, let's get a bit more data how flaky they are and investigate.

Hopefully it's just tuning. Worst case we could back out these few
tests (temporarily) to avoid polluting the dash.

We did not observe this on our end during repeated debug runs.



