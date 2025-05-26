Return-Path: <linux-kselftest+bounces-33807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C1AC42D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E73B9867
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9622F75E;
	Mon, 26 May 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaoFpGaU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2522E40F;
	Mon, 26 May 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276129; cv=none; b=su5mKCXGMGvdrz2Gt7Pj0DWEt8u1aoYQDv5+3vyB6H28Zn9WqsQTjscOn8opmXZKjmtcWscevpOCVw3XTNLFWCPlt3XwKLomFopsqTtW+N4xnoPUpWC56Q7L6M6Z4fNXnkCF1obTjfqEOv91tFAmMa5pKoJwjkXHPW8veyK3m8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276129; c=relaxed/simple;
	bh=DC66KEtFPPf6dRsTAkyJ8ORz4uW/csyD3M/JlX2dpLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzMX1Le6KQeX7pLs1ntwlrDQ9D5EKUjxZHptLIb7rAUTPXRF04sjjsubOV48q6Rik3OmfIfKCfPLdz9EUEGwmzGXLiQx8dA+x5M7pnXW80SPrIyz8ygxkazLL99ZAA9w6KMw6C1WHJy0rr1Kkva/z/u3Kz9PCHNfBmaJnXhtB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaoFpGaU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1276984386so329094a12.0;
        Mon, 26 May 2025 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748276126; x=1748880926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqqBHeb+ye/Ia2+xZyQMqJHybQMTShtOHZU6XZo753Q=;
        b=OaoFpGaUgnlDA3ra9JqyULkI2Qi0da6dYY4bVK9wKowW4vrHpaj7A3AD4RZfayBEy3
         q6hh5tkcQXCEWCGsaMqpFpTDxaVFwMtD7Tmm7sTW+JMwB0tRcriD3F5+ECTishNSnuMZ
         XQ4r0hZefJQBWaQKGlQFg2oB1r70JxVSRqgDDU/2kI7y4J1Lk+b9aPaB8mrfUMezFkSf
         8rj5y1wfi9WIhvE0C/63VSGLE7aIvuWWeBJkT1dBUXD5HUQ22tMY0MQfFtRbdeAtjhkN
         K//thMAw/jly2mHIf+SLE4yROfkKI8NzkydHMAI78rS3EUZhhT15MM6GGjKcGtccgL95
         JLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748276126; x=1748880926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqqBHeb+ye/Ia2+xZyQMqJHybQMTShtOHZU6XZo753Q=;
        b=A3juX01mS/2MWVA3WhPF45Y/LVGnmMamOH2XvndVR+Yzk2V6LWQrEGQwscjXyL1eDr
         b+jIaj4oQJP7ahHrPJG/PKnoI0MjLr4JYRY6eEmKW66AF+txQ4Omf4iOYDrx1LdoLc8j
         DWLv2LxBkPQ5bl8bCMA3wjacJsQS2LXLeGgiMQ/iJxzjrxPp1QC4hYMTb2+dxNLjfN1v
         66F7SpWprEcnSQYozNuhdfLRY3msj2ADMGWtQX6Ko84TNj1m4CuLDfSBvaZJXVban+Aq
         swhLdHz2H8zHUdlcmKSnqmKru++IxNHaegvl3vyRVDdrnQB+Z9RD/00Rx89H0oy00077
         miaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHAJcqZqZMzwTY8gAz2Rl+2/YtGTEFWgCwgNYrsON91EsDNiWpCGX38gZXQn6lRf8ON0qNbyt+5ffDH9Q=@vger.kernel.org, AJvYcCUKAO4cyBdrjl5Z+0VYTs0rKDOdB6cUDfE7sKF9pi7z+GH111XK3JLJWMajzCscqC5K4H4rNbBeOrST23+UZmP4@vger.kernel.org, AJvYcCUZWuqDoSmtmBkvNVSQB2nbobvIJVq7tZuXYhW58W8MSFSW/pLnSalODEq3hUw6qxpGYS5sBnul3gQGPvnHA8Q=@vger.kernel.org, AJvYcCVEIZ8Z8lZ8FjCf3DNgtru1684T9qDmyJ5MxLFAGFDD7izxk0DoVaLeTCoUY/JbRhWV/sM1f4bw@vger.kernel.org, AJvYcCW/eaA2Kbzkvqm9U+mvMOPdPH/auc1PNBWXOrpPWskFPSCg/Zcklr/M9nq5/mGKwPshDMFnVWTVRRrhpwSI@vger.kernel.org, AJvYcCXC96slXCOngaru1ZnOy6HN5JEfxlxjZBnyrZsXCwafKmr87WmgCMUw7rhNfvb6aIeHHuz2UHXVioBn@vger.kernel.org, AJvYcCXyP2eB07mxTjNW1ZMSgeq5X9LmlFvNjGZXnzp1CnLd8TKfjNXWytonN6r5cGhMLbiBX44DtZpMLghc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8R1ZW6FXnxYnNQqcAUjTyd6J74OYp3Ol+s3eaXTl0b12/lLk
	zzVkmHs9g3DRGLmeOWwNDt2Os3cxirCVfkoUyhpuUTkBT0t036U/3HGrj+EOQmrbE/ZqrNeNszx
	UF5P+z+GkGwyLy21CArOrbgNPfCqJItw=
X-Gm-Gg: ASbGncsLj8pUNKy1W7qgy/Cw/+uED/TPxvSqwF3ctuVhmGleWqEfG5S1wMklhdHZYJL
	GT/V9PyBfDeR5OI8I+cZSwAnYjkmz/ApgUwzLbFQpFHg5xIdhU+2bI+Sx6qaindcGSQnf3ZnEQ1
	pZxDC+cNZbO8kPN1Ojzaz8q8b5wlonvyXJ
X-Google-Smtp-Source: AGHT+IGHSiBqTNM5XKVporfsZuIAk8+0k1ziYJ6wqAO1b1FVW8Ifoco0RVgiuBOzn9y42qT5ODX8sdvF5WeB8wXqxCo=
X-Received: by 2002:a17:90b:4b06:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-3110f0be892mr5688853a91.2.1748276125761; Mon, 26 May 2025
 09:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com> <20250524-cstr-core-v10-1-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-1-6412a94d9d75@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 May 2025 18:15:12 +0200
X-Gm-Features: AX0GCFs4zlXhbhwkFm69GRcSGgMcjMarvAu4nWr6-nQj7bz2FlpzmLVkBB1QzB0
Message-ID: <CANiq72nhNmLMdFTzpSQSxxMLanFA7Od6tBZ+3CrVERv9Spou5Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: retitle "Example" section as "Examples"
To: Tamir Duberstein <tamird@gmail.com>, Patrick Miller <paddymills@proton.me>, 
	Hridesh MG <hridesh699@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 10:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> This title is consistent with all other macros' documentation,
> regardless of the number of examples contained in their "Examples"
> sections.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I was going to say that I could take this one independently, but we
already had #1 of:

    https://lore.kernel.org/rust-for-linux/20240906164448.2268368-1-paddymi=
lls@proton.me/

I will take that one (which given the `checkpatch.pl` one got stalled,
I should have taken it separately as I mentioned at some point).

Patrick/Hridesh: there are new cases arriving (i.e. singular section
names), so it would be great if the `checkpatch.pl` patch discussion
could be restarted to see if we can land it, i.e. there is now even
more justification behind it just after some months. Thanks!

Cheers,
Miguel

