Return-Path: <linux-kselftest+bounces-33817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B4AAC4486
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 22:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55823AE6DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3882405EC;
	Mon, 26 May 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ5fm9IU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A81487F4;
	Mon, 26 May 2025 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748292148; cv=none; b=iMzJqPjYe72E+9uDXrrM1y6dbQC0A520x1TbaEJrDWq2scc/+d+h020ROj/KSKomzHJjhnTqOlw4yg7ua7AKF/WgfQ4gRMct4cooQYpqZ0Y9zgR5yeG5LBMrELq/VJeaXpxqXXpXU/Rl7tvV9bdOkC/ArIRIRERdgKbQfzIIA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748292148; c=relaxed/simple;
	bh=3gRNXhmVhQUXXi3jmcxIfz8vm/k3JI7NUoNq7z7BuyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KprkRjATMgN2mi2hcqbi88gKGYZKgRBb+WxjeUV+QPD24e7roqSzvhMTnfz0RoLF5iwMa4O4qhOivn/Tl6OR5ybqQsBweYeNS61kAyO+SyFnH3HgYq0UowTmzG+zXRGYlpw1Fn6BkeiADSpQ+x7aUqMLnII/br6fScSqQrq+eUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ5fm9IU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32923999549so25112141fa.2;
        Mon, 26 May 2025 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748292145; x=1748896945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUmUNbUCgQeGYiOspE2SyC9Ks1s3ZxLZ5UKKm2WjJzg=;
        b=JJ5fm9IUFoQz3Xi14v9VQF9bp/Ns1xygdZXoSDR022wp9Pl8qWefMuCxpgeSwPoxbg
         uxxAqV5UeY7BYpKVBwa5fh0TAMHAvDjwW+roCqY1URO8BQ3ZyQIa/98wKBxYLLLvILMW
         XOm3hr3bvgUOBiWAEWk/OfJUjJvsGS5ocNrZvkQ91MZDhrmyix7St98KfoJQOQXK4Bmp
         pmYbXIeJ9QJFdSkrrgbnEAWxxt7yUuVLwY24Ozp5jVdayxGnpCd8vYYAvUDmFvHNihBO
         88wjv1+lb1ZXwCCZ0LWiy1511CJiUsQvN9CyLfkogMoWeBPzKDOZ1kYZaMpW69KRY0Po
         xp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748292145; x=1748896945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUmUNbUCgQeGYiOspE2SyC9Ks1s3ZxLZ5UKKm2WjJzg=;
        b=pU0571OOdlRFc+kqOTMMXcF+p83QXVcBujPDhgzNPnnZblYKQSl02tnfw4DhVYXDd1
         R/c//cVUEJCCP+7fFT1pHJRwhXbYj8nFM/6fVeDBmf+k3xySmyZ6HP90yPtEz0Q6aD2F
         S5X7oD3+ecsvawfsYdGU8UZ39kyr+QFb4f5tuEip2MLQ8GxmdjCdawd1RX2X4mueOybC
         JHUbso/pXeel1jodktcMX2OCuss/k/O1AXk38AejMCBdKd1hNi2mtNJdYdfY41QBNCPv
         XusMGoEOtPpupFMHYq0wks1ATgEWTk2Wyj/iMFe5UYSrM4hx5j7GVMQLr4aE/lga57Cd
         itRA==
X-Forwarded-Encrypted: i=1; AJvYcCVDNOfCh5iR5R4M5eD4/bHFwKNedVNcQrLQ80KSPu5OTXdJwYTeeObQXJ3xXar2lJtMwkoM+HYL@vger.kernel.org, AJvYcCVQtdWyIzD3vz+XfAJ94E7M1snVPUj/nonzJ6qJT5kn33KawtFbvN9FC41J8JbfPyidR0z7F9VPWbpSdXE=@vger.kernel.org, AJvYcCVcMF+k/IfNQwTGbODvsDSAbh5QaE8BVO3O9wdpa9Yh6yzlz+SJ18Gjk7HKSANpIctI+YpLYnxQJmS/@vger.kernel.org, AJvYcCWDtDLG2CG8541e+ekXCp+NqDuX+H8oSyYJzlk/r6iAs+4I+vX0+7Ax5kpwz1kzZNXJs9nBoR7qVuzpCLiS5CM1@vger.kernel.org, AJvYcCWKYLD/FH37RLiGzqnjwlORb0RjdJ9U+tS3X/5UJKh6Cp7kdzwOFSZTGlPjhRsjdQKC9P8qb9+o5IT2@vger.kernel.org, AJvYcCX4755Cuj7NXfsBe5TFfcJZx3Y03epPRtTnq9H/cjTeyq0ItKjfFOrvVIXRHnl8D9ghKuk7s/XgDwbTwM2EFU4=@vger.kernel.org, AJvYcCXDFmbI8wY6G3TMFYpYR90ZmQMRzW9k9D3iMzjNeBvXz5eCR9NwUOT+hq/+JLWHIbp2WNIsiIrmJYyiEvHU@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqlYiuC3OT/RzITTw9va7U337zabhkr5O3bpTQ69RCu3NCh7c
	BrrawKqhtGRhlsqpMjfJECrkPinTATQU3dDhs7zgzy62BmEswA+N/6BIIa95r4xtIFURv6YM6qt
	EP5HNHD2hdO18foO76r4oxZg7nmdlTZs=
X-Gm-Gg: ASbGncumnEsySrTs4gSgIBk8cC07W5QcDK3lqmRWlUVCfs0oTYOng7hctCYjnnIR5VI
	geKcGXDeVW2jLnOxyexJuA+MLXu39rM1utg4i0rMegmMjqW4OKloauAYQ3Chg3pt4ETO78UwV3+
	7r5MHk6ui2HiJxcFzn9GX/doW7z/KYtBlTDGizWDdXz5f2CxzT3yhF5/zMpzAQzKZry9Ay/agzz
	Zbl6g==
X-Google-Smtp-Source: AGHT+IGPgo+KZWDTPWJ/8ifTkY1Vatt42x8Q1KGRg7v+MsCMTuGoZeMjT/G3sX9/OWQr2VdJiIhB6KXrUJ+SLPtTc/w=
X-Received: by 2002:a2e:be8d:0:b0:30c:317:f3ec with SMTP id
 38308e7fff4ca-3295b9e2b19mr25881171fa.17.1748292144402; Mon, 26 May 2025
 13:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-1-6412a94d9d75@gmail.com> <CANiq72nhNmLMdFTzpSQSxxMLanFA7Od6tBZ+3CrVERv9Spou5Q@mail.gmail.com>
In-Reply-To: <CANiq72nhNmLMdFTzpSQSxxMLanFA7Od6tBZ+3CrVERv9Spou5Q@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 26 May 2025 16:41:48 -0400
X-Gm-Features: AX0GCFtRDT-ngLir-CN5e7tolI7SMct6WsZy2xxM7WLN6cJzwd9Ur8Y0NvGqQWU
Message-ID: <CAJ-ks9=8QXn9wQSX8frRqN0p7=nL+eUwLC6UV8HdQyY13=wx-w@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: retitle "Example" section as "Examples"
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Patrick Miller <paddymills@proton.me>, Hridesh MG <hridesh699@gmail.com>, 
	Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Mon, May 26, 2025 at 12:15=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, May 24, 2025 at 10:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > This title is consistent with all other macros' documentation,
> > regardless of the number of examples contained in their "Examples"
> > sections.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> I was going to say that I could take this one independently, but we
> already had #1 of:
>
>     https://lore.kernel.org/rust-for-linux/20240906164448.2268368-1-paddy=
mills@proton.me/
>
> I will take that one (which given the `checkpatch.pl` one got stalled,
> I should have taken it separately as I mentioned at some point).

Sounds good. I'll drop this one.

