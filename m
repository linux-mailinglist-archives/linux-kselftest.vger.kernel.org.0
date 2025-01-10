Return-Path: <linux-kselftest+bounces-24210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07AA08F92
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 12:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD041161E7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D762080E9;
	Fri, 10 Jan 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJmzoecL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136491F5435
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509038; cv=none; b=ssS6tuInz4M5Z4AnkQVyYLKvCtvCHYcrEHB8IuhLHfP0CNW43KwiRFWbDkUiTbZGheM32FTmm6PtN0xcpVK//6+lIxw0CqzZFz/wV1RsACGwDnq7282aNCmjbZsrLxeoZtt/KzgyMocZdsMJNO1pcOBZABI8R6kFv/yJu2pRl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509038; c=relaxed/simple;
	bh=7zmvdbFWSKbkAV4KyjZZv86GYrGfYPkJHSF3xMZZcb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twz1lwqqVDQYti2YuHur/MFSxRjg7AAOkUTRQ5Amqsg6w4T2oZ9S/qktsGR/EvieWaCyyPPKGXFm4BjYGCnSpxWC2R6UMMYCC7XAx+JbGpK+NjDKPm7uiZClvpJoVrHrQCpdOrNu/lDactUsbbw/EEzpy4nFB8Qk1/exSVaHQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJmzoecL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a88ba968aso1756871f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736509035; x=1737113835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zmvdbFWSKbkAV4KyjZZv86GYrGfYPkJHSF3xMZZcb4=;
        b=MJmzoecLUdC2br+CmUw5U/rdCaFGXDaIzxCSb8KUDc2ufTwh6wC6NDRE6fAuEtzOoJ
         le1vjeq+gnbIyTPXnVXFeTZg6nv1XLwFZB3MOM4/hg5F5kL+QMF8K/x7LDu6kabrmGgL
         NvpC2pU2YVy5McGdQGGVcufcp8oDvs5WNIXx4LIzIWmNxiAZE7qJfeLenRUUFWW33p0P
         oVYEYurLrwGI8MdG4GUV5uttdLwNTy1pJdGgEM0eTlHH2DDZQClkdM6drla/EnO43OEA
         BbYFGIFPXooa8YXKEIdFo2AKneAI0SCLqenWN0lFak7nD4DSXh0R6MrUiV4bPHsn/E4N
         JHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509035; x=1737113835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zmvdbFWSKbkAV4KyjZZv86GYrGfYPkJHSF3xMZZcb4=;
        b=LuVv1oZ/PLUg8LnmVLrAHIUJlI1u8Eq91o/UO8y67ue3O32iI59JhYF+5lU1Eg6bLo
         GeM3035a6B97ClxEjV/Z2sgyaIkaH8vRvVPQcszSWGM++icjTFRWMUOUQTvchhncgjMr
         MjumCU9oRE7y2ug2Ord9A7N6LlaxVyHG51pY+cxF8UHc5CAjTJmJU6PIV9dTB3boLRCU
         TGebDNaJdeh5B1Uy/2U1tNRNMukCFXjQvXimrnVlQnWFkN1cn2lksTLzev8PrPE7nrje
         H2oH5kEkoVtHtsqY67TKGUp4TP0nru+Tc2JFPyTq/03Lw7f1YloYWtFEJp+hAFnbihur
         p2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyuD3d4uX6QwSdljC9rKWNLKvYIsR5ehowo11bcdYXlUjG1yurGnFeAW4RMS7UZ+5OVJ3eVe/07uz6wd2NhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPIaWhDjx8VMSHOQ1JqwxBTbAf6CyYI5BG/Lur+GrN2VGpzlO
	wcnlqZAXdpM9SPwcDmwxGV5dvXdS3MH+CBsBI3oOm208Tq8ZuGXNfqj79b60hR1/eFLHEuM/Kvx
	owYFfUYeGD+4usTASugEzfb13jH+GTZqGoYiv
X-Gm-Gg: ASbGnctBzrS8oR9GR5L8M+DNFE+3VaE+wrqMnY5mjxJlO376GciCMItoOaxQ4yMfWrQ
	NiGAy1JougXlbmJAJt12L4SlcSZwOaDSO5mvLLWURHnE7bzcL3f0QjfwzXUo7gtRa
X-Google-Smtp-Source: AGHT+IHTjv7ZEaDdnZKccljFWwP2cqfKG/YwK1Bus+BafuIS4nyzS6/p2+0zJfumRICahytHtsKlLLgGE1/LM/YxhoU=
X-Received: by 2002:adf:9799:0:b0:38a:888c:7df0 with SMTP id
 ffacd0b85a97d-38a888c8017mr6861676f8f.1.1736509035458; Fri, 10 Jan 2025
 03:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227015205.1375680-1-isaacmanjarres@google.com> <20241227015205.1375680-3-isaacmanjarres@google.com>
In-Reply-To: <20241227015205.1375680-3-isaacmanjarres@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 10 Jan 2025 12:37:03 +0100
X-Gm-Features: AbW1kvbVlPrXTHnA7AqgeRpIk1UcxEJGcZCoLyM-wZBRKWBCXPeNHX_wgjxQVTQ
Message-ID: <CAH5fLghiNqhLeO0199kvyJyqDkGO=d_n7--J0nhTHD+W3=wj5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 2:52=E2=80=AFAM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> Add tests to ensure that F_SEAL_FUTURE_EXEC behaves as expected.
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

