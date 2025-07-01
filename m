Return-Path: <linux-kselftest+bounces-36204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C8FAF0150
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D73AE08B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5A2797B5;
	Tue,  1 Jul 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiYjz8NN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA301CAB3;
	Tue,  1 Jul 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389678; cv=none; b=DzQ31oN7SZmke2fr2O6CZnSDhdF4Z5d/Y4Fh3lHz80izJPctXBhiA0frJIwJwcMQ2wfNa/yc7tceegr9I/2yJeBACn8sUwKp+YhNQdbOIh74fq1l5oWWLGLsDhYkahgCRa4mHv8NNe6wWtXYEROGeqzK/awGsfmmzzjYS+Mn8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389678; c=relaxed/simple;
	bh=otvAmKrNgrGmm953h66f4Y1tIUJExy7j19EPbj8H6iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imsI4lm2o4Pp8z1ePpt9l/qTXI6UXqkoK5uxY2bLaAVDr1CYRqWqCLjVA4xvQQBltQGUl/qkhKRTENZmvDB+7UJjszSlJ6B7s+erbTGlbPpZ2593r/AqaVLaLPh8lWYICkDRE3R5NtZ5ilKOV+ZJ4PKB5njIbCmz4ZErvBVyxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiYjz8NN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so857584a91.2;
        Tue, 01 Jul 2025 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389676; x=1751994476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otvAmKrNgrGmm953h66f4Y1tIUJExy7j19EPbj8H6iA=;
        b=kiYjz8NNpOJxrRXlsqGZ3oeOj12/hks03K2uwKszmsm2TKO6PWHasSkbSal/thUBtP
         j5KUOPmclpaWDZWbSJyFhYH0BjB05x4Uoy+zlqWSFYFbmvc4UQBbHF8jboYIAfa39HDO
         2rGOETIxlw98tSfVouySSyy5vYhriVOqZp/YrhLQtsfa7FKg2KZY4ADKJiW//84H4U2T
         ilhk25nr3cCU/Az4xLDd1uzeRfdXQ2GdyMDDDoTmPcH1ia/62JpVltVwDvstOlAxR+Me
         VVEwudhStPelyFrY+k/SjljkeeGSABxeiY6qoHiI/WgKnHZTbxUuSdR12PS7o5bIjWFG
         EgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389676; x=1751994476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otvAmKrNgrGmm953h66f4Y1tIUJExy7j19EPbj8H6iA=;
        b=Qu/ukY7nmnNyvhSFwBW4+4Wv8NSNoScJYtoEyaEaiRMHt267/igRxaQQGBzBEgPBSp
         eHkKCVhbvUHPoKzcaNJlcsRuIYNwZdhEW64r1oMM/7PwNDieaClizqupLTSUIXWwvfYw
         Hh/w4tjmgU7XcwRPOHfLcT6+uIYVfwVrOr5MO/eT4NpZ5SMIiFenKsIHTHvZ/IR1XQmK
         f7xRF9HuvdtuBGon1X9Q7aa7ASv52+im3uA8Nl/MDUCvNaWjpEz7qVN2lGu0Rd4OkYM6
         OJPpf7QNt2KFEU7ceV7HTU6OvwPSbmiBSBTP4WG7yFbFwXBb2zKZYPDo5/R88jMFAMsI
         LSuA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ajjKB68SLN66QP388B5a/X7BCzoLsOMq+SfWmFwqq3+55TFvY5KGlGB7qsXtAqUE6H312HLIRoO1@vger.kernel.org, AJvYcCUC8uVNBMVzrKos7qCAdYnISml67mR+0S+WrG7QyK/waONB/H0pFNhSCyqiEo0tqVovsQ5HPMu5zk82067N5S/g@vger.kernel.org, AJvYcCUyCzEanLJJwP/53KnufHUVLGcO3o3tr8kmdqNPogv0SIpeK8/Zu0ZoHTaRwv5aPoHlOABhZ87S@vger.kernel.org, AJvYcCVdN7uuRg1cxOK3xoX2WB5VyLk6Uam+qw6eVl5wIz+XDOai5C+jEJjMZV1ycYwCY8V8rVz8cXx9YyFjpQ7X@vger.kernel.org, AJvYcCW3EbVRy5zWudWdXbf3hgDtVBOAtNVI6bv3hRWZzJ0u2yyYyGsft9c640VCtONXq08Dbh4cPiuRgiM=@vger.kernel.org, AJvYcCWIV3pR6hmlBX5LxsK62Fk32K6TIXO0TpC4k2cVma7qt7XP9FIEc5vCxKX1kqOZSTjVLZJH06/+wCnX/ZdYVEo=@vger.kernel.org, AJvYcCWg/WQDlo9Ef/L+RGBOwstLuIo4VbR5EhAdIbM6QWFQ5TIhVLqUv6D4G2Lp6IVZcjCeT9ucMhbSyuPp@vger.kernel.org, AJvYcCWnrObpUbMViM5Zj1qjfHzMvTWiBdbtESKORQw/R4LBL6sk8uliH2SH0I0+SSgbjtYYfIkAOGtbLt9l@vger.kernel.org, AJvYcCXzaRYlXuOY354Vn+39W80azjkjQ3lyNaESXCrWfLPFW/VH1HVe4+T5lIA2it6dXNcy/fgWcb4ZQG7UJ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyLgeDCVWKHE0b6GjKargB9+UP52wtiW7s4avvvT35w/W9OSH
	FgDcOTOKuSe0JZ27YeijfbSuGgTK2Y36vmlUUB6I3yyevLt+YK2+L0+O/vwMSDNKtwiat762zf/
	kaCKzl8jfN9C1N3kgqtzIMC38Fg0Nk+E=
X-Gm-Gg: ASbGncu3GsJU777MZ/9SlyVeltVoM2EU0ZNPFl9PwUI+tgKHXu/P1FJrFO1FyLmCuIr
	h9PcFrNdZwZSp3iEj/fZbq6TZbfGsVikf/oPwTSGcjkG0VcJ040+9y4MDWWuZx2OUvRxqdQjS9c
	9afKGcCqIgB2XweBlczKVrhglD33ZCWn8l1a9LCQSW+KntSvWZpntyng==
X-Google-Smtp-Source: AGHT+IGgyj2cxaLL1I/RbT9oFzMdK+mMcfN6YoSZuvCYWImRFjEfnNWMRG/RDCPN3KNKY0Jv5Rbef8Y4TKqAiOAmPyk=
X-Received: by 2002:a17:90b:1843:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-319519ee90bmr2461781a91.4.1751389675613; Tue, 01 Jul 2025
 10:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Jul 2025 19:07:43 +0200
X-Gm-Features: Ac12FXxPrxBmeSfKO3xPaPnHZ9Ojlak6uQ0jVcG0JF2jdPMZA5As1xRK0OZ6894
Message-ID: <CANiq72kb5b-Q4OwASfGg6gz94fCQSLH34u29umQRsF8MEhR+6g@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@gmail.com>
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
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:49=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
>
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vador=
ovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for keeping this up.

Let's see if we get some Acked-by's -- otherwise, we may want to split
by subsystem and avoid flagday changes wherever possible.

Cheers,
Miguel

