Return-Path: <linux-kselftest+bounces-29477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E4A69DAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 02:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F664665F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E401CAA63;
	Thu, 20 Mar 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="ZAGMXENr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03031C1F2F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434774; cv=none; b=Ot4TqtgfOH1KDrnchG3Tw+sRpfg4ziRAUIoGgfn7FayO/UgR2XSYKWM0hq/W+OI1oHuNIW6HXNZ0bcKysl4BRZNmOUnLpt2AP9dWUXv6zpYPgdcQ0rk1XDenvNO48GD7CU6Qe23huvZZ/yrM7+IEhTLFqPJJfACUKhk1gg0ISEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434774; c=relaxed/simple;
	bh=27mpZuEVEQno+5TPJE+eEzq0bBK6c0B4p2xQ1RoHrmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGqazltPIrOns4ri9QMNPNNV7oqh1/3NBUgV/5kJaFCSmCw1M9zPJfCnKX2bJSs7ik96K83asJdw0mn36jSv9ZLF9t8BBVY86XiXKoRPZcjmqrDehhoCXiiuVTihVez0u30GQsXjAM6eJ89Us4U+kvJ5lJfBZKsS3qNSZ9CeJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=ZAGMXENr; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so186261276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 18:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742434771; x=1743039571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7jNVH6rSqYVR4bOYTIgJDwm7uMfL3wte7+2+Ir1kGk=;
        b=ZAGMXENrrk0PBIXYkodP7VGh+BxzSW49W+Bz4tNKTQZFH+LDiBj7qF/FIhqgNKATxl
         5PptI8MeN6MAVDqxCfOtg2mRMNTeBHE9APlZJNIpsD0OKb6HMGOAzhBfCCNtxU95/huG
         UAnzPGuYURBQQQRVcjPOKJUQ9/yIM6lJ8M8xcaw+2Ne1VwrD3rwm91BQeMUvYLDMzyyu
         m6JCVqnmnvSjvOT1RRAAmiXDSE7539rfchsWcgiq6thhzfkjyYRYKMnT3iezqr+NQz6/
         xkTsQQXs7H/+xXnOTsyiATCoNnsiikpHiqGCMf3I9ke00w2MwBFJsBaiIy6A5JALFIuN
         1/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434771; x=1743039571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7jNVH6rSqYVR4bOYTIgJDwm7uMfL3wte7+2+Ir1kGk=;
        b=rDxP2U0NhfAmHdDhYeAQBmGU86cfhr60hY9CbH5qrxk7YFuQg2f4pHSGLT1TrsU3uF
         gqwTznvfTpszv+U9u1ebVzXZkBCfYMgt2PBjccuY6Mo71ee0V3aRAIckoeJLzbApYwoY
         BlxpTehmgZUvPrPzE7nnMs+wByQwh5K01pIDrc5ULYCmtaka4EEWC9aSm0MTtyb/GB+t
         7EsPrhFFDuNmyva+NTh085gARUyNHVbl7ALnfGLilGPIDCSY5Rt1ApjyZCK6P7NELkOT
         gAOqWfgVxiz8a3707sbKQgVwsoFbJdG/DEzei/r6vMgDZOZjVf5WMiAKy0Uk5nHqvgir
         H5BA==
X-Forwarded-Encrypted: i=1; AJvYcCWZY0M0p445PngY/GjL3CMvCpxWKuk+z6JfYhIFrZoyUH9gvMMHQYK3UcufPcICvwrFCXpBN4CIVIYJEVYoYyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr9qBLXbvnfmWWdZ1k8wgSZ25yz+lZYjzEqkvrwBLre60vCrqm
	ANoswVMXK7YBLaElpn+W3upIyryfRVJk7iioaQvjXmi+oOUoy3i5wP4pgTLnL3Y=
X-Gm-Gg: ASbGncuirdZDlEg47X9cLQ2qMcMGzmHSdDwmxwwaus0y/ONQlOthoAXQLWUgxBvGj5F
	6fmPNrbVxqBTA58a9kM8ZkfX3Tn1YE7fNicDzctyBfPg98/eYxUu2nQTlBKDVcBQZqdvmVCxBPn
	FtS/+dSxJws+ob+AZxe2oJmDgpG0iEIQW4XG+WjTiMTgcL9GZq6maM3dPHEKoqUmSWfYr9cVsKZ
	/KQt3sETLqJv2EbOdcLW76esyOHQTd6opBrV4l9le1fRNxeMWjDgYeAZOnerWY62jwE5sfvghMF
	147DxelVswna9FqdEmOx2MQSM62RTh5gkli3j7Tx1otShU5iY9nvgJ9So4Gu8KI3LlIy8me7K+S
	Pc/9x+LukkQ2FhXN8AaAvUJhN22w7/Q==
X-Google-Smtp-Source: AGHT+IFL6cyWgnxfRgdiB3jtlITSX9PQTiA/2jd0FNeP8bLOx0MbABDKhlIhcynnouA1DM2N3q7f3A==
X-Received: by 2002:a05:6902:138d:b0:e58:8e82:5345 with SMTP id 3f1490d57ef6-e6691fd823amr2021927276.4.1742434771477;
        Wed, 19 Mar 2025 18:39:31 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6414a21a08sm2158969276.17.2025.03.19.18.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 18:39:31 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: davidgow@google.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brendan.higgins@linux.dev,
	contact@antoniohickey.com,
	contact@byte-forge.io,
	dakr@kernel.org,
	gary@garyguo.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rmoar@google.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 21:39:13 -0400
Message-ID: <20250320013913.1624829-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
References: <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 18, 2025 at 04:02:15PM +0800, David Gow wrote:
> On Sun, 16 Mar 2025 at 14:20, Antonio Hickey <contact@byte-forge.io> wrote:
> >
> > Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> > with `&raw const place` and `&raw mut place` respectively.
> >
> > This will allow us to reduce macro complexity, and improve consistency
> > with existing reference syntax as `&raw const`, `&raw mut` are similar
> > to `&`, `&mut` making it fit more naturally with other existing code.
> >
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1148
> > Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> > ---
> 
> Thanks, Antonio.
> 
> So this looks fine, but it's also a bit annoying, as the remaining
> KUnit/Rust integration patches[1] were recently updated to use
> `addr_of_mut!()`, so either this patch, or those, will need updating.
> 
> In general, I think changes such as those in this series are going to
> get progressively more prone to conflicts as Rust is adopted by other
> subsystems, as the 'rust' tree won't be the only one carrying changes
> which could be affected. Maybe in the future it'd make sense to split
> these up into a series which enables the new feature, and only then
> put the warnings in place in the next version?
> 

Hi David,

I understand your general frustration around this, but I do
think it's better to have a higher frequency of change now while
Rust adoption is still early than later on. I know you're looking
at this in a more forward lense of the future, and I think you have
a fair point that this can be more problematic as adoption increases. 

> In the KUnit case in particular, since the patches haven't actually
> been merged yet, we have three options:
> - Merge this into rust-next, and send out a new version of the KUnit
> patches which depend on it, which then are also carried in rust-next,
> or delayed (again) to 6.16. I suspect given how close to the merge
> window we are, the delay is more likely.
> - Merge the KUnit changes as-is (either into rust-next or
> kselftest/kunit), and send out a new version of this series which also
> updates it (probably in 6.16, but maybe sooner if everything goes via
> rust-next).
> - Merge both, and accept that there'll be some clippy errors until a
> follow-up patch fixing them is sent and merged.

I'm currently preparing to send out a new version of my patch right 
now. Depending on how the timing of our patches plays out, I'm not
opposed to updating your patches KUnit changes within my patch set, as
it's very much aligned with the scope of my patch set.

> 
> As someone with a vested interest in the KUnit changes, and at best a
> mild academic interest in the addr_of_muit!() deprecation, my
> preferences are with the latter two options. (I'd also, in general,
> whinge that the frequency of new Rust versions / warnings is high
> enough that it's taking a not insignificant portion of the limited
> time I have working on Rust things to understand and deal with the
> churn.)
> 
> Regardless, apart from the minor irritation of having to learn yet
> another new syntax, I have no objections to this patch in particular.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Thanks (and sorry for the grumpiness: don't take it personally),
> -- David

Haha no problem, you have a fair point.

Thanks,
Antonio

> 
> [1]: https://lore.kernel.org/rust-for-linux/20250307090103.918788-1-davidgow@google.com/



