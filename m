Return-Path: <linux-kselftest+bounces-35624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB298AE46D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9504A6C22
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B6254AE7;
	Mon, 23 Jun 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hz5sKH/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4648252900
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688711; cv=none; b=mQhoG1JSoCpaKYsY+oohmtqrTfo1lDRvEaO4zNrypCV8BroxkqZvyW+qaE7PipOoc3aFGCPWycLBGhFoaadHSyyjZ3Knkzfq4GnYiyOXF81CD8fPqgI8jow8ACMcNirZSC0uyyb9UFK8Rmym97sm+STnrATpZurQl/zCwhZCJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688711; c=relaxed/simple;
	bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDK7MIV+a/XZF2KADI5e6k5c8JJWGNdhtNJ6a9C06ZKhC32M5buL+aEWcob4KulTJcnNy4Wh1cQqLLg4kOVdR65LbDlYrXJcktyP2H4OPDLT1IVU8QFIOVZQcs38PDunasAUJQYsPiQI5iEkn+8OEuIjHa1dJH+rlSFzXmjD6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hz5sKH/0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a77ffcb795so26593121cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750688709; x=1751293509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
        b=Hz5sKH/0CUqCVy+gyeVDbBluqvWvIWtW/vlElI3RC9jKg+1d9czMYTUOzn/Bq9qn/V
         jn/AMkslROBbF3BWXMUcA9zdtSPBa+WCLXbg2jZ99/6wwqaM7P4CGUtdZpuDNQEdqtww
         pUyRzqSnrdcKoi+RYigvfqbE6QWxd8xB8sjJLNt6ACK/2Qdscc0uamLizbxiGiTjyGGQ
         5YLU5ELu0j/QDsyNxSQOYb7/1aqLms3T4z7xhX+d61PoNO38zN0RauyUMpKY9aLSmNnA
         Il5fTV0bbasKtzVxXezUZCEbZAGNpU/2BcSXRkImS6nZeZ1RhLXpVibByaQOX4tYn86g
         wODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688709; x=1751293509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
        b=Zq95qrR/JjHEXeMZ7Y1/dLaPP17Qh2v7fcXHkgCGMoIf6rWNZTZyuJL+hlOykAKutT
         7yhtcP8UEUIhNQcRC1WVU6ZoGyLQujYjJtzMHoNXSNf1NBPHanP1lcpNGxvFwNrQvgl+
         aLDgNyjKB0wCtHFH7kIrGt5kZ1u2d4B74RgE7K0p9ToMT7cDcsClTZ4SpAAm6Ek07oS2
         6h+QePZmTVlNrjaXuJN4K0cFpH2AxXR6C40tud2lu4DsroB8LO2HXiBynwC0pZJXixYA
         PhVN5bnvMmFdW7pIfLo/IqGa7j3wYqmn2J+3dJbWy2ga0kUtxcvqOBA8gzGkt4klUEPh
         Tfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWOlfxgR21xirzIQ1x9iKlVF+00nVUxhFUBzCvRM2VT2Tckf4zNyoQfaX1tUgYnNjx2uK8J1Ye9j1KYG3YAZoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWtUAHivgwfLtERgrVw54v0pesNyORVxV3ODTq15FoS45WJx7
	xqQ8oG1iNxbwXMhEKj/60bMv0/UO14d3ceaMwctTFkw+SFQEraUxx1VeM0Ja5w9erVv6Dbzdg3I
	aY0UWYl4ACF0PJy/jYxw2IS9bYrYglw6JqL/iZmHB
X-Gm-Gg: ASbGnctR7xN4u0ImrZBEdrJooogECwF95tdnX2id86wV/Fq0z+aBA4XEab/Zx5nSQGP
	sfM2qXYrsuROEX+GQPxTUcDL0sPI+IpKIoIAgBb5ZapZwk76bIhLfDD1uSFVs2YZbmECCdSQg4G
	tfyEmWqV7vCBX8bs9XAVeXYuWECZF2O1HmdzpM3oQeAEc=
X-Google-Smtp-Source: AGHT+IEmKVWhHe3CQXXXmJ+3AX8EMi+q/7rsvjNQufpnZ23z/jr0CTEgZ/cgGqhdl0YDzCXcGLOX3ClO1xMMJtgKcVk=
X-Received: by 2002:a05:622a:81:b0:4a7:30e2:b31e with SMTP id
 d75a77b69052e-4a77a233d86mr212392981cf.34.1750688708438; Mon, 23 Jun 2025
 07:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 07:24:56 -0700
X-Gm-Features: AX0GCFuuumLhEceI4NFGCl3EfDcvOiQNAlPh4nu_8dUwfmmZX_i1-HOe9hb43D0
Message-ID: <CANn89iLzOJ6YqQuQGOm5b8vdbJ12jp_2YTbKW=aGZjsy6FM95g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 02/15] tcp: fast path functions later
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The following patch will use tcp_ecn_mode_accecn(),
> TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
> __tcp_fast_path_on() to make new flag for AccECN.
>
> No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

