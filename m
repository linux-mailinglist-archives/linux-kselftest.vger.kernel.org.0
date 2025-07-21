Return-Path: <linux-kselftest+bounces-37737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2CB0BDBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D4D1884E25
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D4928466D;
	Mon, 21 Jul 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGGSv0HF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA7283FD4
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083320; cv=none; b=ZEL6iErhWed7O/Pb4R1SYbthimq4WxbB89wPi1p1Xo4nsgHa8YLPMNww5IAXlfZHYJOruEFwJOZ6oYiHE1lZGQmCAIbYRFelH52/U0K9SNfrQh/Q0oTiYd5D6m5Ricb6ckYbVS7YXVxMqnQniV3GKhq+euTXZgyJaP4NXWaKK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083320; c=relaxed/simple;
	bh=75yem3WjluK+t3HLkk9qsg5NT0tv+wkaJxCTWsY2V44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMZCRA3oyeVhq2rSSN8SWCpgiiJS7Zhu2dalJQmZYCHBkHLDjtYzzekwlqIXtgTvQFOBONmck7krH0T/VG2cPjz+DVSO1JAfP2ueAKPzUDow1xNtGuiI9Z1kyFDid6cHx31ghtMCIKWiLZ+RupSukwIVPTQ8OY4n95mRcr9+xtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGGSv0HF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237311f5a54so30456645ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753083318; x=1753688118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=kGGSv0HFtXZDd/hf8OoliuSHGqTcVMDJmtt+p69A1UB+zSfVBODkqmNY2aiPHYoJ14
         jKSpkiU4TkRSUkRSbw0Ul6L+xEDsIRhAU14VTBOpBdsVfZ7bDP/mYjfhawa56kHmO+yt
         VfYUKhjdZ2yZAEx7YrVTb7EJhbrpEa4qkk/D+9qoZPDhY9pwkq+GWNJR7AA4k9U8D+cP
         FlcC0hoB9s2ztApoLKJoZi4qBmhHvI9z5cGSCjJzgfSWVGJrSElYYe8wV54Z7Y/UyQcg
         GrZva1rov1N6CJUCRIDCDHOpo6BODt7/TRHIWuLhSAAQYB8fZ/Trcnban2blXlBgKjbp
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753083318; x=1753688118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=w1A53bfaFzW6uIZi1O2bYT1q/JseP/ZqFx0ek+6oVFH7zYNlbehXD9yWfhKKl7DwmG
         WF1OAeCu4MTuCijLq+B2BjcpMrbrVPK2p1Z9iEQPuq22pY2Dz/x9TQli7W3lHEnmguLW
         XUPiZDRMWYeITYZcKXhdTdMfdVW/XPs1uI2FvVTibEnUq9N4WLul8ar6poNRyj/ro7ve
         nVBMxO6qelnN+cExQMQYqqocr25fLp7888D2dAzp6BvWyWkIKhPqg1EuLMWbqmWqxs9k
         NTlWLBJK2ZlbyQhzEJBIVKBOgPZiq6nGtBZvpZAmbzqysnCj3TeONjBr64fax3iNH36a
         uPwg==
X-Forwarded-Encrypted: i=1; AJvYcCVRMwWXUYnkC8qq4ppoMlXfeBETxB3gP0RQ6fle9dyPFYiRsAJkN5vBPeXQKBYObnk9uhxPADijbElOxyWzgMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaqzIXav7fzjTnsou+E7V8E7RxF85PzExGp7HgCaa6mK4YTHnE
	1KzxqM7YsP0b5GIirE3gDEYmxzOhBBxxL/rQPfuvDlJ9jAA4pu1s35K0f3N54jEjv58=
X-Gm-Gg: ASbGncsZ8+aHNO8p+xO5LdWQiIQui36VpZPQO/xrUq612Qq2KoGGWDWb1KycTqPFEHB
	dPot93tSY1mLlXoQH6l5s10Ra07NYBGKrDj6w8B5NYFQwnDnE3N1fVJhhgI/M/cawTzsStjZXrQ
	JDHz/uAEiWaFAz3wjyzuvMUm302K3qcWqJUJZAeeOLkgQCRxwYi1CTVq3oQnIAGQIVW8Zd364De
	ty1jj2DcfF4O91OtKqYYxhhnRIIk/ZGpxiNTix9bEKlH+0/qjop7S/DZkedHbBtc7bGpJ0y3WaX
	T/I8lPrk5DySHF9f7jcu4iKSRX5yChhtdx+tVk4+NfMy8RT+oKr510UN4ErhfWgNUdNlSjPK74W
	fg3e6rkG7/AvH5VgB0cRL6wsBFnkqZL5eOg==
X-Google-Smtp-Source: AGHT+IETNDRZoddMesKOQhKRvcZzakzOmMfiCHJxW7eO5wvM2qbmpmfxE8rY5ugFlkzEUO27/HUOzQ==
X-Received: by 2002:a17:902:d58c:b0:234:a139:120a with SMTP id d9443c01a7336-23e2572ab00mr258734915ad.32.1753083318367;
        Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d239dsm52577175ad.155.2025.07.21.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:35:17 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:05:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/10] rust: cpufreq: use `core::ffi::CStr` method
 names
Message-ID: <20250721073515.2srip46utnyap7fb@vireshk-i7>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
 <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>

On 19-07-25, 18:42, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index e8d231971276..71d601f7c261 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
>      };
>  
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> -        let src = name.as_bytes_with_nul();
> +        let src = name.to_bytes_with_nul();
>          let mut dst = [0; CPUFREQ_NAME_LEN];
>  
>          build_assert!(src.len() <= CPUFREQ_NAME_LEN);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

