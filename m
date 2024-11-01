Return-Path: <linux-kselftest+bounces-21295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C8E9B91A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D578E1C221EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC91A00DF;
	Fri,  1 Nov 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlZ9wyTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF11990C0
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466870; cv=none; b=n9CGUG6JuPhqGJkoF7rbkHrq8S0r0KExfkgHcp/fh1PxvMPPNEjj2XrmQ4HoP9E4GlQekUoxmPNmWF1318F1ZIoiPcZ3douHDASrEBvdAtcp2jYEQ5iI80dymOgvAfbTogFmoOy69mOTG5pRzPtnfjTBfHY2wFg6qC7V2t/t+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466870; c=relaxed/simple;
	bh=6aAmFsJss1QRu8uaL79qqcvFWlGka3N/28+aWyODFkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRqPTmVVGRyp2PbavpvPt+5VwbZdAz14N+XaAHVokh3wUjzGu4q8EHQv//E1CupTH/84GtSeptxbPurAzxj4XEZtwWv+JeCYaHvYz4QR4da02/hPXJsFdWXJymZgY3y6AyTjrZtCaA2ma3F+baPmsYVRV8yo5uqdupDEmFIdMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlZ9wyTy; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so293455ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730466866; x=1731071666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWlXIahODzpoNdr0NLzeKSp3oyNmpJuqBRxB/KAVeiw=;
        b=mlZ9wyTyoHQPVwpDfsBP3O56lnVDYrr3wKodSOtNYp2fs4X21iRRssET5xOsUcYybV
         jman7LeX4aGQqdgZZjuF3qEZBXqBRu+76J5w6GZcZyn3NldjfTgwIi90Vgn978AgiBfd
         vYB0jYR5arbGmRRKk2PJJ+6ILWr5UugPjRwrx1DsTbuwjd4ZrgpjRMiusEqPot4Esi4N
         qizfMsUeq8kdzQB6gwW3aVSTnZ3njHfnq560JsDTKvNruRmfI+8cxr03THKNKdoCjF32
         VYufzQwIT1dB3Oh6sDAinR6mKX3JytM5DPrVd7GBLz3C8ZXuDS1PXTa/wAkLlwFEYT/W
         5Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466866; x=1731071666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWlXIahODzpoNdr0NLzeKSp3oyNmpJuqBRxB/KAVeiw=;
        b=MUMfVI804RFnvozbCp80CGSg3lPjB1wSKy0TdeX0Q7pNUd176B1tc2nlOD4zthX4TC
         3MeBFdiKJjTMupqkxM5uT5+NStjaef1vmk/F0oFI4dVaSzBqN7nT9q2IPUm8KyXDf7dA
         ++X8esvALyVygjBfbjwyMHYkPB3GFqQ5eYttVmah55sc/8oG7gM5hCWj65z0F4ee7X4Y
         f8su8vCZ1rcBjf2fA1TpePHqdLIfeXw/ESGEDr9+4XZacdqXRQtr2G0NzeIWZ09JTb4+
         VSEPaE/l/0hfPsrtnZjd0ElvKYhGOAaIFxTPrYj3KFi/cM5PlS/woRI1WKrjDAZ7og5S
         r1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXpgsNgcyuqep75oWaK5KxByC4TPH3LoNPDoO8fYJZQKgwcNJmgaASWs/cZr2ISIkfZrGwE4invQ6/EQWFcX6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zeWOprm6+RMtD07othWihWCKVNDH+rM4Q7UX81JbXEZ6i7v0
	ZBkKHbXx35QtjW81nJlY9idpoYMWyCVmmraFHGWDKAT0q4Wx0XX+yGrVpt+FlpDC7ETveLUrjqr
	CVWPjX1n7ipPA7gR0N0H2hIaWKSpl/Ge5/S8C
X-Gm-Gg: ASbGncsY+dtW7wgkw3li8PXZgmO82amVT505451G4CQo6JO4UBAWXjlX0o6EtTc4mKc
	T20+7Yyp9fCdVUS5S4aApb5pxrlqex20=
X-Google-Smtp-Source: AGHT+IG9zSpv682re0C/0/lu+w1kkJ6uERs+tlXRbzXuyVLvZia/fQo8HxQNYuQYLETlY2WFrk/vuONmvkFszIhPjCI=
X-Received: by 2002:a05:6e02:3f0f:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a6a94371dfmr7307805ab.13.1730466866197; Fri, 01 Nov 2024
 06:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com> <20241031194101.301f1f72@kernel.org>
In-Reply-To: <20241031194101.301f1f72@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 06:14:14 -0700
Message-ID: <CAHS8izO-UhDfctAsjpdipRV=WyCvUAu9VnAes0mBe2wSvV3_9g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/7] devmem TCP fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 29 Oct 2024 20:55:20 +0000 Mina Almasry wrote:
> > A few unrelated devmem TCP fixes bundled in a series for some
> > convenience (if that's ok).
>
> These two should go to net I presume? It's missing input validation.
>
> Either way you gotta repost either as two properly separate series,
> or combine them as one, cause right now they are neither and patchwork
> doesn't recognize they are related.
>

Yeah my apologies. I made a mistake posting the series and posted the
cover letter twice. Looks like that confused patchwork very much.

I'll also repost targeting net since these are fixes to existing code.

But what is the 'missing input validation'? Do you mean the input
validation for the SO_DEVMEM_DONTNEED API? That should be handled in
the patch  "net: fix SO_DEVMEM_DONTNEED looping too long" in this
series, unless I missed something.

--
Thanks,
Mina

