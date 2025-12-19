Return-Path: <linux-kselftest+bounces-47730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2DCCF449
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7620C300766F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AF2EC561;
	Fri, 19 Dec 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK1vGGt6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD127280F
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138680; cv=none; b=cRFBjnsHIYIAauEuFYlYTPwu22OEDZk18OU1AE8JkqeyEHxUabZtzJe08adTDr+s4muiDASLGy8n+PU4AclPBo1nkcSIPUZlBbwKifORz0EKck+XS6OlbhJYnmHrby4Dcz92le0khys3LVoiFY78emY+Hjl+xCsZqDW1ZRkbULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138680; c=relaxed/simple;
	bh=ihMVyDllurToHeLiN93dhlOh8p/bZUYBfmk1fHtLRA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPqKeGkhpzH6VxKYeowG4bJZi77nXc2Bz6tFNpioUFzUgCucWiOv8s28W5Og7RTnhAknzLn8ANy4dXMYvCELb1ttfE3YCzStVvfgwZFU4+WZRhmWhtHc7f8qrVMFAbn1EWo2IjyDqq4jbayYhw+FHqQmp1Rm0cDLk9HlT6sGqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK1vGGt6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a110548f10so4388045ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766138678; x=1766743478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1VrxEK+gDnV8ugE5t26U+jWY1Ysmnza3WwUpdmSU7o=;
        b=JK1vGGt6H73ZX0imlh38isbvIAthLBakm1IXpjITZKLC4B8dNL8OlIg8ImxNH3lzO6
         OC+1sGyiUKxWr+CIj2t8+oVaE2TUlpg9XyIPAt8mGlizqHUrobpl9IzHTzywb4qRwzo4
         oD0AkWERaIHnduAXqYnrt5kGgzvGUfqTvnjTaeHl5aNw6sFCSCMsWU/6ixziOrFEBSov
         tX+fKXljIVG3DX2Z+Mh8PVyFh0nJQqZyyVJuxnc1YAC5J9BL1fA1Od4BsDJHus2zXIfq
         cJcwB3OMPR9n26YU1kx54gvEXAWm4TClRg+E1S0a6vUY9r8K++mf797qtNJnOgnW4f3S
         ASNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766138678; x=1766743478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1VrxEK+gDnV8ugE5t26U+jWY1Ysmnza3WwUpdmSU7o=;
        b=CWH2dazmGHoKMTC9bqNOh0mYG0ENN15n+k060CS78hc7TfjxXO3Rr6ZNiOAJBUPrkp
         x6R4twBeyzzvmFYExmEn+iYvh1hm2ic35IRBm3mECj62bNqQ44bBYOL4m5Pe5eXLQL7P
         hpuDpjKY4FBPW7zTuNYZYvwWm/hmWX5jI34Lg66UNKZrHkNrDHSaV5z1uRU+4PuCCCEM
         2Zo7MHIQU2a3VY3HrWK+f11fySMjoy1hQk/AGx9g0KesxICFEkCdEEAnNCKx0fkWPKpa
         lPNpQ6u3rmD7Uy0YfApeQP1iCa8QkxM8g563YPhmRJan1Tqk87lY6PFpuVMwB0KRoUmA
         DNwg==
X-Forwarded-Encrypted: i=1; AJvYcCWn+rRRKBG1cYTSMpPTpKYCkL2z4MIGcvGhmngTw6b9gM3hqAo/0JuLJrE7GAtNuFv/rNLi1rKTJcPFXSmUrkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMY7tI3UimIv4wwGW5mhe3S4oM/pK7ltgqkE5OYskhgFwPMsV8
	DJl6tcO8hDFgEw8uspeH11ANOGUVO6k5BA3kT7iu3lH7happkOTOBIh3SsIevjMxlXdMFP+nBfG
	2wQdjJldNVKi0bRZSh/gQaE5r6rai8TQ=
X-Gm-Gg: AY/fxX7ItOFA4mzqnaedwPUFtcQnLAJ8Ai2PIqlSK/v1E4eohyZGr8ilI21i7JQjBCB
	3a91fLUwdCDZYHv4vtsINacOskzDh/lsyztwPLuCOPOWsHK94gmlRodyHHNcaLc2+o5pSkzDcqF
	e0Ir3wDD2qnj+Qan+eefj1frpqeP4pReOJ9sCGmYe6937nsThXB6hmJ/FR2XPD6X93rVeThYsd2
	w2R72R7kqFQ/7Vb3OP0+XxrAGnK8kDLD2tUiZ+yMlZaGvYlcqoUbq6R4gFA5pwNoijvr8tDfbki
	JFxKv0jMaKBRv7ua3tvbsI9I4JdFZSk75Djyo3sKVhJb/0nEVHAx2EnskxF8TdiPNHh17QcrL9V
	ZEGPJRDUgYlJoHA==
X-Google-Smtp-Source: AGHT+IHtUE602FvgMsT8GOtnJov33zxYYov4x3dhU+tYUl3Bs4Jcfe4thjZtl5QPHbP1Vrw5LKSSxaJg77FzcCaSzio=
X-Received: by 2002:a05:7022:6294:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-121722e11famr1344359c88.4.1766138677829; Fri, 19 Dec 2025
 02:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219092537.1227513-1-davidgow@google.com>
In-Reply-To: <20251219092537.1227513-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 19 Dec 2025 11:04:23 +0100
X-Gm-Features: AQt7F2oEuGq9y_76Xm5CdUbTK6H7VwI7P-ClCTr86yLdf4auZUg3tY0uCinYqK0
Message-ID: <CANiq72=ZKGXpsmvKHGsX9=tr9Tbdkd-7baJ-RN4crBdXkcB6Yw@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: doctests: Number tests by line numerically, not lexicographically.
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guillaume Gomez <guillaume1.gomez@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:25=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> 1. Is it worth renumbering all of the tests (hopefully just once), or
> would that break too many people's test histories?

Personally I don't have such histories just yet (and anyway the tests
generally work), and even if someone does, it may be best to pay the
price sooner rather than later.

> 2. Is there a better way of doing this in Rust? I can think of ways
> which might be nicer if the whole thing is refactored somewhat
> seriously, but if there's an easy numeric sort on strings, that'd be
> much easier.

We do essentially the same in the main loop (which is where I suppose
you picked it up), so it isn't too bad:

        // The `name` follows the `{file}_{line}_{number}` pattern
(see description in
        // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
        let name =3D path.file_name().unwrap().to_str().unwrap().to_string(=
);

        // Extract the `file` and the `line`, discarding the `number`.
        let (file, line) =3D
name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();

However, we could perhaps save the information so that the main loop
is cleaner instead of redoing it.

Having said that, given we are migrating anyway, this patch may be
simpler to avoid reworking this code. So I am happy either way.

> 3. Should we wait until after all or some of the changes to the test
> generation? Does the new --output-format=3Ddoctest option make this
> easier/harder/different?

We could do it there -- it would be easier in the sense that we have
the proper data already with the proper types etc.

On the other hand, it may be best to define the order we want to
follow (independently of the approaches), and then the migration would
be a smaller change conceptually, i.e. one less thing to decide then.

(I have to send the version to finally integrate the migration soon,
by the way -- I would like to put it in this cycle if possible).

Thanks!

Cheers,
Miguel

