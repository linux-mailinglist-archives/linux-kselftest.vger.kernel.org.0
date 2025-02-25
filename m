Return-Path: <linux-kselftest+bounces-27519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA49A44A36
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B119C7E5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44B19E998;
	Tue, 25 Feb 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXf4X5DW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FB19C554;
	Tue, 25 Feb 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507818; cv=none; b=iVGjlWkt7WINgQCXJIFWrB5s5fbMzizHwVlIbE+SCG9/lZtBCQMmM7GTblOy1Fhvfqb/H5BeOoNAEzOvJEPsazDbwldzJrhFdAf9cs6XtExoNqH6UhA9WxrtShvLdx4EF31pi7j0LTpXmNgQqVC0WxoAnRX6Sto/Bs22HMbi9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507818; c=relaxed/simple;
	bh=lWR9ZhfqT3Bv67jIPPD27ihMnSVP5uwrvTX15okoLkc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NVzwzo0+BWH+Iv9qokRuWyGKVUzFstZb6dVyLIM678HtpmaeuIHlCPPp4cS9fhRSKDwNily02hFb96xAnKsXKbuWvy4ykLTfIsIplz+NZu03Ba2oe62o8yUjR0IAUvJC+wdh55TfRXHkCw4D0E8R/NqLmnmeHrLxsEa0fBG8xkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXf4X5DW; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4721f53e6ecso54424891cf.1;
        Tue, 25 Feb 2025 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507815; x=1741112615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiB/fe1k4Uf/k4EA3SbSx/T++Ad/tM1CJM/bJ+YtZPU=;
        b=YXf4X5DWKiH+BchWbMr+cSaE7JoLbbhtiJYO+Kfqywg9t6Nu3EyUnCPSUsNi1h4tLF
         Sia7dO5EqHQFv3alWgHzDWi6t0J3pOGqs4lnEgeMiRtRB4wVXiG8V0J+cL0UKUOVONp5
         1bsVeykCSflAJ03mAkoMohSzGjj+28+wkox2G9tZbi/QsLPKzM82/meoMMGKvsdoG2av
         mWiL1FDQJFMhZ8AMxglvBeoqCg1kQ4ctcLnf7JbAhs0GU6HTXcyKvdohLAemSzHgOf5j
         ohUxKTEZ1vRupMKAV+f+2IgyiSdaaKlgbEv/0ytmJRc3MDbN432NviYnCay1OzfSOSJG
         Nuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507815; x=1741112615;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yiB/fe1k4Uf/k4EA3SbSx/T++Ad/tM1CJM/bJ+YtZPU=;
        b=To4FedeJvWSSmG4cfbMhwoSHBcVb5iIhPLGGWrZ9vmE+1/GQ6eANx+YCZdRJWirKcw
         xDSVVPTk6zXqNeeBdG47cxufaFXmMnr1xStidTpcrGWzc+WPhF6Xx6C5N3pZV7w8yYOx
         QfUdt7YPTD9ywyme7Iu8Y/nJKS5VVD8CkV4ZTJt1HjuVjlSiay6mdkOLaVw4fHrMGLX9
         zBoQlNMOAne3I2pCsnKj01vG5ht6MOkM7uRh2N4YabGSkGvBAMpgi9YqegwiFV/s/Knj
         SQ8OgIjdWa8ypIci4I90tmdZlxjtxXr5MUZeqVhQWuz6+EBDLwurOWE5l7cjFp2guff6
         iHbg==
X-Forwarded-Encrypted: i=1; AJvYcCV5+nN7E5sH8nuGs6jsTSZwh1yX1zGBHZMd/BcM7tk+/mW86l8PBnYEEnApHNzzYg7rAVVWYQSR@vger.kernel.org, AJvYcCVX/NIWfDh9jIQX4tlkIFUmO2SLZPKNqWJy5qLj+XUzLcWWfWiNxxLSJiIf1k/ayObm6Ee8HgY6OT/ZHnVMQgx7@vger.kernel.org, AJvYcCWesA1XHDUac1x1T3Kc/udstifnM6JbDcr4RY0WlmTjaMfCMUGFTRLXu0ehGk19HuTAL/0=@vger.kernel.org, AJvYcCXSo4960T1daA87qA1PC5VEJA+V8aZgzc7cisPbFYI9T5tJ0L/Rx6Xb6TdnBaQMv1jSK6E6GV18s1qmYk81@vger.kernel.org
X-Gm-Message-State: AOJu0Yxug6wDh2I/DfKvEYBYBTMjhBhdZNrbMKTPudpgZztaleO2JYV7
	cEqXW+YsgsaEEHr071tcxzHiN2v/nYuguNR6Z/nP/sN7/LztB+S+
X-Gm-Gg: ASbGnctK5F1Q/UN9iinsVlH3fPsxNdLY5aM2sUnVXfRGl2MS8qJPDcG7iEebaAb1wrh
	BCy6bp0ZDVpRX92fF0REjOZsC78qweR4Bko+sZkd5lYLC6gQyO5k9MBWeuYLvVY3tNJoUY+XL3C
	4q9iJPCcEUVmTcWRQG4v+BWnUpUAjvYC5FbE9UJ6qZxJnwaRpbJh+t5a7es21wc5n8GyrtQvUF2
	6PH755KqX/VaFAfKocmEj97kvtBVZZFmV7NUmmNgw48P7KNdFBXrjAtvnmSsidkqSh9FDvSGbUh
	N0zgfY+XUAfllynLKEB7j8fZNK6K0L2wXSq0wkgpqyjp3qjDla8BiceMnu2PD7NSnK1zMJch5Nm
	tcnk=
X-Google-Smtp-Source: AGHT+IFaHBS8n0aQ9zJrj4XBYciVZAF1BuQgnxQ6bsbcGDqmkd1fbgUyb7IL/cXKQNEnFfHujzg+jA==
X-Received: by 2002:ac8:7c52:0:b0:471:f992:8c24 with SMTP id d75a77b69052e-47224909608mr224383651cf.49.1740507815296;
        Tue, 25 Feb 2025 10:23:35 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e22008sm12838371cf.35.2025.02.25.10.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:23:34 -0800 (PST)
Date: Tue, 25 Feb 2025 13:23:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org
Message-ID: <67be0aa61e400_25ccfc29426@willemb.c.googlers.com.notmuch>
In-Reply-To: <efcc6e11-2d3a-489e-80bc-cbc3f72f7afa@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-5-marcus.wichelmann@hetzner-cloud.de>
 <efcc6e11-2d3a-489e-80bc-cbc3f72f7afa@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: refactor
 xdp_context_functional test and bpf program
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> Am 24.02.25 um 16:29 schrieb Marcus Wichelmann:
> > [...]
> > +	/* By default, Linux sends IPv6 multicast listener reports which
> > +	 * interfere with this test. Set the IFF_NOARP flag to ensure
> > +	 * silence on the interface.
> > +	 */
> > +	SYS(close, "ip link set dev " RX_NAME " arp off");
> >   	SYS(close, "ip link set dev " RX_NAME " up");
> 
> Hm, setting the NOARP flag seems to have not been sufficient to fix the flaky
> test:
> https://github.com/kernel-patches/bpf/actions/runs/13507111620/job/37739614229
> 
> I was not able to reproduce it locally or with my own CI runs unfortunately, but
> I'll try something else in the next patch version which should definitely stop
> IPv6 multicast listener report packets from messing with the tests.

You probably want to pass nodad to any ip -6 addr add.

This is a common option you'll find in tools/testing/selftests/net.

RFC 3810 section 5.2.13 says

"
   For stateless autoconfiguration, as defined in [RFC2462], a node is
   required to join several IPv6 multicast groups, in order to perform
   Duplicate Address Detection (DAD).
"

