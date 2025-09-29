Return-Path: <linux-kselftest+bounces-42604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94546BAA9E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 23:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EA51C340B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A64253F11;
	Mon, 29 Sep 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNzW64kw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006923A562
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180223; cv=none; b=eKHoTa/mVKBwviiopseZgJyF9ZLL7cNX/8M9g84i3RjOhAti6eZUVSJDAb2/qJKo7AQKcWrzAwpRIwdQZ1ao7J3ZABtY0EJcHAGPyyqz/dnk3B7cTtmRASRqk+Y+kX0YFbGQ8jcqbJLOSiy+mUWr53ImfWC9TCnnSpjeARx6MSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180223; c=relaxed/simple;
	bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X35zcF3IOOPXzhiXm+64NaJJvwW1iuJXqQyueim7BV097lxRZ03d3tweBqBxLpFl1CKlRNteLrjla57gvaZhf+x3ZTGbpA5eyJu+ykVdP91oW2Utr3iaf2GPVRNRIvYSC/8ex8UMJilHxebxEFBUK3NK5GK/b3x3E4AFYWy4Ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNzW64kw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so10109153a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759180220; x=1759785020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
        b=bNzW64kwbZdLoiCXBuNIKK+v5tbJpTqExvDDCFPrkP7sMK90AF9hZtMGVWEjmRuo7h
         2hbXiBxMxNHuHZUij7i0cI+b3Oh2j4PxM5SZiy9F3a8NgmrtaF2yXWM5qQ8yb8qmdpsw
         kYs03kwZUlDwfDgaQPBHJULnvFW/drSJ/uhuhaBaTKannWQn50ehWCj+GMAgR828qYFh
         X4N6y1woELjh5uFcL8tZBDHuWwQeqPNH9c64YXV/HtYlLLQv+VSj+hJHlpivIOTMzCqc
         xJQzcjFr54S7wqsY4YH+XeUawl905JKvvjnuUdjMsuFjOcUqyqxeIBR3yLMH8Dtv3cb3
         kAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180220; x=1759785020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
        b=CmVq9kHG/W2t52/0HMUrIX0UJIdnf1b9Iqm5I+eSUEhyp93hCAVEOyN9U0Vthjjhvp
         EnTRPunS/mtalMkmN8hu8O2u8LqzB9L9103UwIX5nXU++nctclnGuYeqNSSmekU5nF4u
         zcuWJUIKhMxNV+5Tc6w9T3qiyswXzFJo4O/hp+js4f//koFcrez40gLc4IpYxxnB9JlK
         tZoga+s7/bhAnrky7LH3Kv+I/y46DdBDSEl/+ac7Mi1qn5lowFKJrxSt01fbt8TdAtGg
         ZBBjh95uPPmhSEArDfeLncc6XTAIgN+TdeR3SW23vOCS3ulsn0A1XExLnNZySLab8UVP
         D+8A==
X-Forwarded-Encrypted: i=1; AJvYcCV4d+omytN1znuvocS1IilLnGngc3VKNID//VjoBXrtSAlB8VRiPWUYa+hxd5wyi26wZ6fzrYaWQkXyW0wKsVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYmKaty/HohSvfP9lFX9lm09fSJT3vlGYxXl1le4j6qNAvst7
	x7W94gsxgirgvtcnMTzQD8EO4CnchhfhK/YYaMEyYf+tk6Y6WVg9Id5gVb+bB2iPgu5v+EWYdju
	Za4Xxq4j0uHdzRMK9HuaPyYJ8S1pFlck=
X-Gm-Gg: ASbGncspmheXuOGbL8C1nx639mC2dLErz40pWyynzf8iWiKrj+AE7sFIQMRU8qgkI0R
	u6vrQyp1pFAT85dFCTrY3s6uC0RH7LPm/DxbqjhhYtpPGjGJGslTJzzf/DGAeDEp8yfvmu1MWid
	bz/95mPb+NmtFqdwHMRIBFv842rrpuM5vC13SDukoPMWxrKAc7hlweQ4sJfdLu5Gz6SSakHgCsE
	Np8H6SpbNRtWIjTqv4Rr2xvapPDhbomPdpwk9NRXQuFYsGEJefg
X-Google-Smtp-Source: AGHT+IH6lV5eV1Kt4fx4PJQ/xnpUMkEAkksSmL0ApQf1NYE5kHd4rYc4X1ZnoqKFvlP4C5fI0NBai3/kdLcOSzqbyko=
X-Received: by 2002:a17:907:7289:b0:b43:5c22:7e62 with SMTP id
 a640c23a62f3a-b435c227f87mr12156466b.50.1759180220317; Mon, 29 Sep 2025
 14:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929160230.36941-2-sidharthseela@gmail.com> <willemdebruijn.kernel.321e70874e73c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.321e70874e73c@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 02:40:08 +0530
X-Gm-Features: AS18NWCEmn2M-D5zHU0jlR919m1nzZwmzKwrlDEi5S-4Vw12GrNcqqXAq1DzRds
Message-ID: <CAJE-K+B0xssX5TCwxyUwGu=vGMR1u-7r-3wDiMvs4GnqCkYUqA@mail.gmail.com>
Subject: Re: [PATCH v2] net: Fix uninit character pointer and return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:28=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Reminder: use the net prefix: [PATCH net v2]
Oh I thought you meant me to change the subsytem in the subject.
Changing.

> My previous response accidentally left a state comment. The main
> feedback still held:
> This default case calls error() and exits the program, so this cannot
> happen.
Alright, I thought error() is like perror(). After checking man pages, the
status being non-zero leads to exit(). So yes, it makes sense now, the
switch case, either loads up a value in the 'reason' or exits().

> End the commit with the Signed-off-by block. Either move changelog
> above that, or below three (not two) dashes.
Alright, Thank you for taking the time to reply. Sending w/ changes.

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

