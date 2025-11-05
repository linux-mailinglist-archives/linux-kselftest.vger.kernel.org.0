Return-Path: <linux-kselftest+bounces-44853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0182AC38523
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 00:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE5218C55F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C32F60A7;
	Wed,  5 Nov 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWQQ1J6x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4E2F5A33
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384629; cv=none; b=C16xKNFloBrEMRyiq6Me/KEIiR1yly4gfHH9ovPPklK5F/1gCyS4Dkufm3spKwF0HbagESmcwN/sn/JFSXcUJPwMzMYnPaBZfVszJdjsU2Z7RlM2HpxkyB7bK1+qU7Icn+4TiQuF5Q5NmfTYp+By+GcBkuAh2P/mMhys+hv/k2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384629; c=relaxed/simple;
	bh=WMvrekpPCbw2lO6Uf+oSI/IovWgn+h5aIgixbccy4To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNZhieTzyOJR11mA28COdDyV9vVGXfyMVl8ImambGqB50WqzlSsVRO33nhnIdNtENbkKP2wgeyJVTyhW7a8drP/X6cLVo+18EgRYSTrxb3suGn1fDFxv7bHlZBU1hS0oaljZRuI80wpC3euWWodAr01iLWheJr2Hx2Dj9iiOteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWQQ1J6x; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782e93932ffso331747b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 15:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762384627; x=1762989427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ifl5YAD6qLo3j4ucIccvW3+275rOUebLENMn+Nd9X+8=;
        b=LWQQ1J6xbKmCwFassRT+pe4S+s30eeYv0U/YGlW6gIjEf/vGdat5wdbPk4JpgYW0Hv
         ZvwxaMg+dD0MB0X7NBtcfmSyiaOTgzH3+azMdQHUDq64cC0HinoqBVzEzRW4F0wOdN76
         uF3o5dH1leUENq/m4qsNgDGsj4t+IAXgRpU5srShvyWkiblNKDSlQ98WVdr4HiOuNiP+
         ZSS2oVR86Zt31ARecgPYWxbA+4zh3R/UlAO8DSN2iEw5kj85YpfN6OGUq/tEz9lzrpZg
         p5jfTHlBFDiCkJuHStr9+HVKz/JSVAuRHO1O54Mdi/lSU/8+UqhocYxUel2D1VV+mvxM
         qGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762384627; x=1762989427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifl5YAD6qLo3j4ucIccvW3+275rOUebLENMn+Nd9X+8=;
        b=dcvwPBvvgcbTToN3vi1Jk2eEneFmMfQQebunkEjcuvfiqMbHQbGt564mETwaaLIH/6
         nFLQRJnc17ZofjNnyFoOHp0qses+IwrDBclYWtoSwk/4J0HW1hzDshHwJdKlXRi2rYWp
         3CtQXM3ovi51PgHeVcQWGqRR1N1IiJZK9iT0uylbaEV2TwyzKx8TBOiufvuBSnh2X66T
         erP7nBBxAzIV1o7peWduBLf/++Snt52X5mR0YbbUk7t583tsz+ZXh8rEqsbiTpAZz50L
         Xx86Ee3p8++dFPzRC9GMKdoXwXURI0bxScklqiABk0q5qcvEXG6K3kT/sRJ9Wfr1jAH1
         yY8g==
X-Forwarded-Encrypted: i=1; AJvYcCUsbBUjMO7uWy5PRR01PM3uVGz2/T6n6+9TJYuFjH9+XbWu5t7XbuwYhERDtsEyoTj674mKhyCYNjk48afjQ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fXn4XeEqdMGe5pglX5NdJc7bUrGFU0H3KGEtYk0whv8aIJvo
	3SxgMi/A4FwbbTvSSiwZaoCEjbjPi8cHAJLbhqwfgivGrsk8U+PPVFo=
X-Gm-Gg: ASbGncuvD4PKVl8Ytt2PmgzXGcp43MP95Ecpvx41E/uQa1L7eRXTJVMeIZTG8E15XXt
	FFIg2D3ggWtFjTwPFrhEAIHr4M0whpxMES/eAh+T3NNQnQxQ4Uqfk5Z/3VW2dOU+UPR2HcE4IN2
	oum9Zdsfctmce65wuCUgwxgEtnmD2TMs5pzhSc9ACsRYXgQHDGTWKF6VmQZ75DkRCf3D2g91qm2
	+8x/OlK1zEt0HXkCy3GZatspU/PX8ariGl78yAy/ARKvO2/WzO7UG2+zkqDGGT8B99oAzY1H+On
	lAV4BcNJ+458PF3403Sabz0I9qkvwPDvq7wKGGjBdM6ThWhUlVNW0TQkO00nmAYEx8z8KWDQauG
	3uAhHkauk65XRhT0ZpDZBYb5QBJlRfWTEymx/pLYpo2b/FF3c1ycKnV0JlWBjOByR7YcJ/z+XAq
	LiV5V13R9z44EhTBfW7+7mQISRCWYZs+0KWquq7NJaMN7+LJQ9sELHI6a65hwkf8i2JZg6jxZUQ
	QVIEw3aUoxkym7eriAvy1zWEV8Ltz1/oP73Gq10jjP//5y5vv4uECxm
X-Google-Smtp-Source: AGHT+IEroDXv/s12OnxuxUiI5O9ZkRDWKJ27KuhHefG4WvDrZ9EhDglR9rBCbFC1jc+d0xM1TFbisw==
X-Received: by 2002:a05:6a20:94cb:b0:33e:561b:fb22 with SMTP id adf61e73a8af0-34f868ed090mr6455660637.50.1762384627202;
        Wed, 05 Nov 2025 15:17:07 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7c4115a9sm603995b3a.0.2025.11.05.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:17:06 -0800 (PST)
Date: Wed, 5 Nov 2025 15:17:06 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQva8v22RVQEgPi_@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
 <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
 <aQumHEL6GgxsPQEM@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQumHEL6GgxsPQEM@mini-arch>

On 11/05, Stanislav Fomichev wrote:
> On 11/05, Mina Almasry wrote:
> > On Wed, Nov 5, 2025 at 9:34 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > >
> > > On 11/04, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > >
> > > [..]
> > >
> > > > +Autorelease Control
> > > > +~~~~~~~~~~~~~~~~~~~
> > >
> > > Have you considered an option to have this flag on the dmabuf binding
> > > itself? This will let us keep everything in ynl and not add a new socket
> > > option. I think also semantically, this is a property of the binding
> > > and not the socket? (not sure what's gonna happen if we have
> > > autorelease=on and autorelease=off sockets receiving to the same
> > > dmabuf)
> > 
> > I think this thread (and maybe other comments on that patch) is the
> > context that missed your inbox:
> > 
> > https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.com/
> > 
> > Let us know if you disagree.
> 
> Thanks, I did miss that whole v5 because I was OOO, let me take a look!

Thank you for the context!

I think that the current approach is ok, we can go with that, but I
wonder whether we can simplify things a bit? What if we prohibit the
co-existence of autorelease=on and autorelease=off sockets on the
system? The first binding basically locks the kernel path into one way or
the other (presumably by using static-branch) and prohibits new bindings
that use a different mode. It will let us still keep the mode on the binding
and will help us not think about the co-existance (we can also still keep
things like one-dmabuf-per-socket restrictions in the new mode, etc).

I think for you, Mina, this should still work? You have a knob to go back
to the old mode if needed. At the same time, we keep the UAPI surface
smaller and keep the path more simple. Ideally, we can also deprecate
the old mode at some point (if you manage to successfully migrate of
course). WDYT?

