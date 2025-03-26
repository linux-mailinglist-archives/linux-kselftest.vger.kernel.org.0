Return-Path: <linux-kselftest+bounces-29840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FCA720E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 22:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AD3179BDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A36261396;
	Wed, 26 Mar 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egkW6/X1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7E1A5B8E;
	Wed, 26 Mar 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025282; cv=none; b=oZGuHXo9QQCJgXhFTbWUJSjXLm3NsW1V4fZprAtcusy5YHfrtaqGFhNr0yDFdgcZ43/uKTbnf3mCCKxjpsWJrUIoIeswyO0N7A2/xTY4rP2ApPgcqypGF8iLDYBhATcy2mfhauBChX5fxWF4ERXuVB1Z9Axh9SS4a0G254qzJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025282; c=relaxed/simple;
	bh=XPtYS0ul4743X7wmk39kQREthn/srdHqkuLRRws+L7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muAWi+bbT3ChktrBbWSwgpaWb0r7tMYGxVDeYRHHkug8RXya6pmb68Iuq/G1rdpFL/sKDVDROG+N9XYiGHl0OxRZ3evDTdxCc+WNdiu+5u/eNE3qD/xCnkLuJWow0F5VcL4gAdrceS3veGoj6v/WhqJCsVnpxhFTyGE6hD5CP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egkW6/X1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30332dfc821so382943a91.3;
        Wed, 26 Mar 2025 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743025280; x=1743630080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMsucVvxGJgWy5E5JgVuhP4u313WUb25G3PqvcbV6wE=;
        b=egkW6/X1niIQxenAr5W5wLr4Kj1/AgMvnMCorbL0+D2jTct2nZUeTB4xwXWUkSnToz
         m6FkMFGwtSpklWZ9P6YfakAUXCOhnC2YSO+DuX0+rmLJ+QoccrCOJ6YMR2PNW7y11KDV
         eGP0j1uNNI7KqSCH8tdfZLiiF9SL7Habxr2V7c8KiCR0DVmS2mfnNVlLO+59Zr+/Tvlj
         NRgIyWI+hYfDUtBHGCRhawj8OmmxPejs/FsKUmOfD578LLyyq7gMCegGHr/R/IC+/EER
         gVDMfrHY7QUH18Kq91CqBlDl6y5MPW8pXE/RD+PF1guXVOvl7ObCCnSYoiZrfatgIcqd
         owIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743025280; x=1743630080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMsucVvxGJgWy5E5JgVuhP4u313WUb25G3PqvcbV6wE=;
        b=QVtQa8LviArb+DUqCCBB5r3Gq5iM1sV5miC8hV47uMR6fClRjNEFhWebgxBRkmZRtt
         hy2AYKDVZ2OFB7xZTjGS2i4a6a94Jyg2EXfwnLNikIiks4ClHsmngwnbT0tgu0v9/+4o
         cFuHN0Xg73IN+X9mC9n8Rf/psf3sFRtOTt9TPJLEyBAq6Y0NRRu4PTWnystdo8Vb2o9q
         rMGFLC/FLhg5ad+oreI6aOWaiC2AQB4iv5PWYjQlv/vlnUB2fzxiW3Z4veW8KB9F8amQ
         GJHcMaayWP6QF1mm5IHWVFwrXcuIQadA5uYGUSZ2Kq1V2BRXKjOdgyadDwihkxDU8AKP
         QC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUQPpj4NPVcpc8Z4V4jE/d4X5Cca+Eu9Qrcf9vtTTUa4uJjavVPeUsPTcA9FAuCx/oklff4INYITtJrTrI=@vger.kernel.org, AJvYcCWrvqi5mX34ZBT7pe2IFlhK3XoJkvnikeexDnozm/jupuuF3lt+F5JS/hQgaOA/lYRce6g9xde2@vger.kernel.org, AJvYcCXQk0iUu3aV+Mb7jnFFDhXh7mUTG4S1jOToh5Fm9Wp0/FtTbgQxTdJO9V9l403A3ukAu+QIDqZaSyKP0DPtU/f7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xbBhG+wb28Wvx67sag8rt5AqLCF5k/Ltfimuy5xT+O7uYaGi
	E4A9stx6isV2vXSXiq+lwH1QwZ9pJZJncsBHYSr//sB8GSqVUE2LoGE1iw8qlGd/ghipokjc+Nr
	lNgwumQEA0Dv7qhw6YPkBV6/D2dA=
X-Gm-Gg: ASbGncuXyIhNYorpJ3v2MdGAmWvv3b6Jg4Nxt0cGt6rF8scJgkofuUe/1x1umxcKTlY
	1cybx9BEB2+SwwdKiwvG3I//BsA0oNVBu/UEfPly176Ll8BZMR4KSvWpNIKvYjbv7beq6K/LuS2
	CaeHYBxYKVJASLrUs9czMvHVU/yA==
X-Google-Smtp-Source: AGHT+IHJ7R1UFk58IEiMFut0asR/eUWy1XSjookypawS1eNEqRJQE40wE8bZFNlcS08YUnlnyHsDGWSLn1BkkPONWHI=
X-Received: by 2002:a17:90b:3c4d:b0:2ff:7331:18bc with SMTP id
 98e67ed59e1d1-303a85c8389mr1527123a91.26.1743025280063; Wed, 26 Mar 2025
 14:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
 <20250325061525.01d34952@kernel.org> <CAJwJo6YoGz1aPv5nkJJKa05mxF-Zhc+B4U6kRw95KSduLCApaw@mail.gmail.com>
 <20250326130005.0f12741d@kernel.org>
In-Reply-To: <20250326130005.0f12741d@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 26 Mar 2025 21:41:08 +0000
X-Gm-Features: AQ5f1Jrs_2ISpI4K_R5ayTBFqMn7YOSiUc7R7H_Qzpc-litNnB3y2ei4ujseGN0
Message-ID: <CAJwJo6a-fODO+r3u_CEpzRzNsdKNMTuX6yN7Zb8Pqt588J=rsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] selftests/net: Mixed select()+polling
 mode for TCP-AO tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 20:00, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 26 Mar 2025 19:48:16 +0000 Dmitry Safonov wrote:
> > Should I send the potential fix now for -net or wait until the merge
> > window closes and send for -net-next?
>
> I reckon you can send it now, maybe other maintainers will disagree
> but to me test stability fixes should be okay during the MW.
> You can tag it as net-next for the benefit of the build bot,
> tho we'll end up merging it to net once/if Linus pulls.

Thanks! Will do!

Thanks
             Dmitry

