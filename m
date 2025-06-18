Return-Path: <linux-kselftest+bounces-35303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E7ADF2E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C850A3B26F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9312F2C5E;
	Wed, 18 Jun 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSN70s40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7761D5AB7;
	Wed, 18 Jun 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265303; cv=none; b=ju3BIYdeRr1ATXJXy5u0UUIuag2F3bWmcetEoa9lk6775jMjJlVeoOPNk1La+0J+KpWAvJhLUyWAsmVWwMJ3sJrz+y0PxUOuwdibA6/0Wue55jmiCeGOHarvQLX7pY7NPFyJn4NTGkdp/2LYqPT60NRdNZZt83OIs/3YjStq16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265303; c=relaxed/simple;
	bh=QycIY7NfqMtlDVCZpA26roUZJ6kC4SKuXb/WNtrRUQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKFOymZ15tOvD9G/mbi9VJHr3K+F8wNUlqKmzAXN9gFHMZQpHQlA44OOt/GUCafOC10FM3znvjySW/ZnWzCuZs+e97yBqfPAyGScZ2cJJnO0uuscCj+DT+rgWiHVu1lD7honcryyYQcemPXvTpbuUkHUXWQTXcUzJPOQb2uTaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSN70s40; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so910784a91.1;
        Wed, 18 Jun 2025 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265301; x=1750870101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW9mBOCDobrkScz6UXkBCPboXEmZQ8/FnXiXbPclB4M=;
        b=eSN70s40qpq7jnkX+oy9DJbYbnuh2yvstI4JCzutMEL8/l+ZERcyWFULmj7Ox04Cyn
         2D+TOCYPnc2AW17PuFKd931+NX4lGAVlQlmlzVKz6nD2sNpU5NR5shtIlDnbUMMuMIi4
         IlbY8WUMgHNxL1c4frZeXsx10nYDbxz9yXs30UJp1Zs/tv9mob+TB1uX3W/+CjYlBnC6
         cPLD3TQPkJBkeQd80Ub8BCdMNz/m9t9sEIPkC2BZ49ilm5kiD28bvROiRhM5Jnzla6ts
         PTnqBV4xI4cof+wA0VsL/htv1d68XJzJSuwKbAxgnsK3uERKd1JtHgSWSzkRushpST8G
         kIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265301; x=1750870101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW9mBOCDobrkScz6UXkBCPboXEmZQ8/FnXiXbPclB4M=;
        b=txgNJZ16L5HZf4XAYhvrJwr1CBjIDGiKG0JvEcSquNeTREObqgK/Nw5xogix8ebMhM
         PQBd0xtxHLpkj6gxuhidvlC8cMUw406FWW+6bA4VR2IXONmE2DDLF0l7FfpcVOE5Ypk+
         EvNimnzLkr5uXz3FXZof2eng0lGb1wenSxiA1dYZSL1Xg8grk06dyAhPXGESqH1tBOe0
         umDP0HIr5NLxivtF7YtPSnbkdPHxeAA/Kqz4qLWVCcMGPtLX8XvO5/svgql39iO/0h7u
         u38Nl9hv9BtJ2lOhP/D1bTAU5VJpo4wn3oKdV1Iy4e+2howGCqfdQUwx6Eyb8l/om5nP
         kn2g==
X-Forwarded-Encrypted: i=1; AJvYcCUS1twIx4zM0kIUdlSaYFJPppDicW29q+DWyRKpKZwhvDFvJzigVrfFpRSo0Eye7dq1rC4FRw//pcrXf0NF@vger.kernel.org, AJvYcCUgR7TZUvAixNccqH+QQ6MDp89JCqXpHibI5WHmUyLR9rvCbwjYbuVuAx0gKwB0D/qUatUfNPtv0CxAXHgH/5o=@vger.kernel.org, AJvYcCVf+UWMu74r6A8YgWbtwMQPNDrY5IFbJc50lzRtisOp5Vro3SvsssvTqAbJR/krT0/RR/qr4WOj9R5P+2qu75kr@vger.kernel.org, AJvYcCW0FEho++f/s0vjVDOOz8eWWO9kNi9abotd8uJnEw6ZhQAARoAJG+1oKpib686hOZVM2V1ZSPNY3go9@vger.kernel.org, AJvYcCW0n3L3rBkKP07SIUj2EkJbXo2zA8qv3FqoJ0ldwbQiOJSlyCwbhn/NoON35Uoi9G0ID1uWdPEQA50=@vger.kernel.org, AJvYcCX/VSWQCRoa3TDibxvoGS/PuWu0CnCweSXLkimURE3sLaFj3SbeFAotwZXHLLIclyyLCtLBPsYt9doff/A=@vger.kernel.org, AJvYcCXC6rqSwhKJz/UnK2XPW61btCv7DIZUb2qTGOf2SZYv7SORhBh2M4Kk/x58x5v3lc/0bwUgVC75W6GtEeGn@vger.kernel.org, AJvYcCXFO1dpz3RkMW8uBiLLhO0WSnXn/TeLS+QgloUlN/bm9xVdS7W+nLFJf2i6PCfXSygYt9TQJBGC@vger.kernel.org, AJvYcCXJn2Tjr7pG1tGq2TmojsvR+btpGazMV32zKMnkjMlzZVrUq5UaBbQIIKKQPcq6UxYfZIsMBhys+aj9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LorzkeLySDEATXmw3X1EqHD8gruSLbA6vK90uiyawzCQUyKL
	FCaSHF+ySVfRPQfy0f6KxCFGCbxfGfIiJzd/4MCwy7wrKkfya74IGCbXW8lXDSOd5wgqgheJ2K+
	Gw4OdmpOgrrVc1+vxQrjDHiiLL/WfLk8=
X-Gm-Gg: ASbGncufnTPvqxr0Fa+2M23++5xjOaQz9+61RfTIL0mo4TeY1f98P7OPmojvg4dF4EA
	xqocYsR4OGzU0GJADp7xrcb8ROkl2ZugIxywSMdMB/5vMi1KeYszzp4NLvHOJRs2vvw2TX7stSn
	ZPx/zPxfBBhrL6C2RxY9TnWI9JcZSaY1Ync7aHgZOoeUU=
X-Google-Smtp-Source: AGHT+IHbZPpDlzhGTWnV2PLbhxK3FWVyrT693fd1mp3Na/PixMVTH2mNNXQ1lkOox0fBpQYU583IqtWRcabC98kzYIs=
X-Received: by 2002:a17:90b:53ce:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-3158bfee2a1mr6435a91.6.1750265300581; Wed, 18 Jun 2025 09:48:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com> <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 18:48:07 +0200
X-Gm-Features: Ac12FXwww27fRmxpneEil4Z01A67o6MlxDze4sqqmIR4CifNVxQNGBiXiJdR-J0
Message-ID: <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
To: Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <vireshk@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Apply these changes and enable the lint -- no functional change
> intended.

We need one more for `opp` [1] -- Viresh: I can do it on apply, unless
you disagree.

Cheers,
Miguel

[1]

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index a566fc3e7dcb..bc82a85ca883 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -92,7 +92,7 @@ fn to_c_str_array(names: &[CString]) ->
Result<KVec<*const u8>> {
     let mut list =3D KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;

     for name in names.iter() {
-        list.push(name.as_ptr() as _, GFP_KERNEL)?;
+        list.push(name.as_ptr().cast(), GFP_KERNEL)?;
     }

     list.push(ptr::null(), GFP_KERNEL)?;

