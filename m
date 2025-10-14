Return-Path: <linux-kselftest+bounces-43133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2ADBDA1B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 898B1355EBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB6301470;
	Tue, 14 Oct 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU7eZR7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897B30103F
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452856; cv=none; b=DnwB1UniLjiu5OsjSQT2kN7z6WVz3AG2C9F6a8Cc22NNuBf0qDXZLWFwvX8dlYfFi2n7tb1mN5+ScDeHXFaeTBPnxCQ6R/GsgvqP/iBJex2sf1yJ+19ZjCdTTjGShu0nf6tPKPeqrmZypBzjjujfLXup9g3FGF9bl23N3vFM6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452856; c=relaxed/simple;
	bh=zQl0PXoTYkJaRbM1iHFgNK6CBXrdzevy/TEH5ZCbwd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhkgJ5EJHq+/9SdNQKDGw7WmKbNeP+nyWHDkqLofvZX8V0A50oU7sv/kgStBAtC5fFf7Yq/ff8PxERMnQnzqlnUsp1tdRRTIgh7DKD907al9bjs0s0iMIcjY+Bazbf0Zb8hxYYlEpXo2PoUtAdLiWUw8JZPLgceT/OjqcWElEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU7eZR7V; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so735195ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760452854; x=1761057654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQl0PXoTYkJaRbM1iHFgNK6CBXrdzevy/TEH5ZCbwd4=;
        b=qU7eZR7VWY9qR/+uMfAVJYTItPxnppqItwoUpkzZDiaJ+0GBRMbgx8bheFrXaxUQka
         W582Xfwdp8pZnLF3mNWNWq/iupd4SH+SsZeQzuhGKeKxC91qeJSbNDpOKdmwluv1iut1
         7Oqjdlcfs1WcaBEZ2yC+laDCKH4/GtcWjJiqKIWyIWe/VdIojn4JhH03xtslVqeu+SHj
         Buy+w4HjDukQivw0tLGtKFnUC4huvXtpBSGDnXx6YYQoZnFgrveYpTz154uNNuIM7MM6
         7oIX5QFEbI9NM4M6dBw0OxYyjqx19O4ggf3s0wad8FLfxUlDaQq4TkQwO3U1PTrrfRqQ
         Xj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452854; x=1761057654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQl0PXoTYkJaRbM1iHFgNK6CBXrdzevy/TEH5ZCbwd4=;
        b=OtLGpXm88GjVk2Or2/qfTjPvgR3wfoSwnci9ScZb957Og6qTdlUK8UeNsmLVbE2YSi
         8BGpXpbokkS/i4zfAl4BhXSNPTF9SV02Z7nfdl2M2yt305rfa4gwug0ZZPvKM21EYh9Q
         BA7A1dzYgOXtmBMJK/0PYdoEcbmLbypoz1JNhjCYqz5c5ZEv/r42xgYOriw4yS8+La8+
         Eqa3jSnSOXSwqA1NFDQzAakBXMLG+/lfKp1VEjEkHUFinL5MmtJx6T/4H7bOiVLlZJf4
         i/scs/CSKSzAOJCoOOPriXnkq7cERKCm17dU2zNKm+4o6xVjRND4WwWhLwjWyOUjWCrd
         4VaA==
X-Forwarded-Encrypted: i=1; AJvYcCUHt1MFzzmOv9uEt1A9tVrE/zSzXKskdHzr3ovK7AzkJSzbRUERkpfwoRClwwC7JcoFLoDmudDwqiVZd12Tg/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZ1bARor5HceijWfkWQTj7j7iwVwqR98G5QIdcemSNakZ93lS
	LFe36CcvUjj20QgBjY/7u0hegLnRPLRQ/Pp07leTXmey7Qdt3prNNdykyFLDovqWALJ1tR5Hwau
	zehTsGHY5FsrwTjnUT8DUpCJBW1CkwzsrJtqMPVNU
X-Gm-Gg: ASbGncsOTriQEQH1alW3ccDRqQtxEXAH7cX6/8SBItmadtTpPScsQwLFoK/uiH6Re0A
	KNw7rmxzxuhzMkX5n8iqUjWwzNUy4ANm8Z0DgPBpXzhVQJax7tr+4hlRqh3z13oKf0+ZRVH7YVs
	ddvPty5jn5JKynY3hpvd4q4CDDFXCmcJ65hF8InwmLLLs9oMl8Dg4eaxZG7JwgvEHADA0QgUtXd
	q5kbj0QA6RFDoboXMlGoISUbC33nVAmtOeCM8pw9oFiLER9V8TxH0jUbX3fKH9zEOuerffR/Q==
X-Google-Smtp-Source: AGHT+IEEg+Qlx1F8v6GOZqbMCmMpwPTSQkRn7icyC0J4Ul7WK+r/sh3gEihm7+CRTLWikmx7RGdEXelYtrNLtfx9tP8=
X-Received: by 2002:a17:902:ceca:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-29027600f6cmr35086445ad.3.1760452853859; Tue, 14 Oct 2025
 07:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com>
In-Reply-To: <20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 14 Oct 2025 16:40:41 +0200
X-Gm-Features: AS18NWDK3JVbrYrBllRzjfsjRSq9Nkan3UUoQRMetB4LzmgAZBq5PRB_jdQIyt0
Message-ID: <CA+i-1C1dU8gP=phC1UD=sc62Gy=ODUN3oAeUUKRnLJgMFW-OKQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/run_kselftest.sh: exit with error if tests fail
To: Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 16:35, Brendan Jackman <jackmanb@google.com> wrote:
> +kselftest_failures_file=$(mktemp --tmpdir kselftest-failures-XXXXXX)

Argh this is still wrong, I forgot about Thomas' other comment from
[0]. I am just gonna send an immediate v3, please ignore this v2.

[0] https://lore.kernel.org/all/20251010082310-b25e69f3-4568-4886-a0c9-3bd611bce073@linutronix.de/

