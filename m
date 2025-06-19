Return-Path: <linux-kselftest+bounces-35340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE11ADFD4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 07:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9809B1883188
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94801242D93;
	Thu, 19 Jun 2025 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOTGhZH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04852242D69
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312456; cv=none; b=EKe0tFrBBpzZVnn136al2twRmuq9CLage/LmHqk86Vrwhtqn/mqkYe/HFtip4wCuXE/VRJx+w1VwjoAYzRj+/tBEMCbMYc85SMmAxjLPYAZ094g8FSt+3cC96aSjNbbSe2hw7CNYPOrWZkEBLpLfwNkaR0sPoE8FCz3FEQ6r+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312456; c=relaxed/simple;
	bh=fkIz5c3VvVkstShK1H66lgQuGsJWH2TH8Np1JEM/A24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFiA0+0Nt3CUXpbefq/JUt+Nm4v6+NcZQ17xsm5hh/njGk6yCl/LBsQjhPWHIV+cT7jqFHLA86LeB8f0pJeBGNgCRd6sVFJ2LwoLXox7Gt+dsuIHP2Aot4anxuxedgAeOpdCtm+hh74al+QwUueRRgxvyEpRicCHUHHTQYilfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOTGhZH/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31c84b8052so537808a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312454; x=1750917254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNX8x8v1rA4gsmPSGKn+LRzfhgT9AcyvzOiTf8D9D0s=;
        b=IOTGhZH/le/QrGXCHdOlyg6gZQ+WzZiUdWkKMaqT+Z5mvDRUIaz1QkAt756uVuCE9C
         4Kv9q6wWn2WbCQfsaA0IB/Ku+qiYU7I5a/Gq3mx5AL7AQ4Pz9+nIuepfTu9oDrrn4zwr
         u9sCo6nFmir+otOLZnZejGSehnavUs2n9U0v4thkYBQu8nqg7VQ4TvGRqO/akgcqxqWr
         669oO5IgRxVrcDT3D8hhk1w4foq6zHYu7R6gXlVjfArJlk/Q3vAjRGjo5ZryTCDwGq/d
         ctx4ng1a4cnvBmpynR4ALxU5ae6WvTUvIYaZQocf0tffqdKutuL466toIQqz++aexdb+
         mwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312454; x=1750917254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNX8x8v1rA4gsmPSGKn+LRzfhgT9AcyvzOiTf8D9D0s=;
        b=iYfMUisUUpu4qhtvQ/p0m5PYFNrEquYeRgu7zcki0G2+rMxKsL+xtrekuCSmsxubxP
         HZSEbxVgmKuKdrSfw7aBbw2SHntMHDvhm2Gq1bH7v4y8UmxfWsT4Y1N1//nQU2JR3zX2
         IilyadjC0S8vHvGnNMlFRgTWffU7tR+mUvSm8be07bMSfyyx2Vmmh4GFhXCt44jwLGUF
         1nF7LVubGS2boOw3e1xvGfy6J3jSv8Nasc/fErznMZlh7K0NwGIGx2mqCgjzroA0NRsC
         GLbJRZMiXcTDMK7f7Pz1pdFgS6ZlhI7+UZgF3sLXvcaqpFVXHLzkrb4ODCcXCg5uOLt0
         hC0g==
X-Forwarded-Encrypted: i=1; AJvYcCUt1h6xIUXOFy+52XrLux39bBuSnkkORIegdyLntaR5x1TNuNoW7HtA9t6UzxYGfIcW2I71nbVjVPL4U7/+eiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz06m+14JZ8RgLQRiYVqR62Dx/HWre79x4gmLeUqWBuvuLpMib
	F39XovC9rrQuzYMFzSKTLX8QzjO/bw1nnl88/uAOweOREEZ1qEIv1/pLYhQkoZYIU4s=
X-Gm-Gg: ASbGncsWHYhUAHkE33iTJkDP8yc+byA/S6wPA+OxjgHd2raKnenSUzzD/gpW1QFmLoT
	aCBS+G1rfbTx7k2w7zmdAMqrs0sMyp/LNwixYjTGAhMQ+H6m99zrTK801L9yR6K7HkMfIB/Dwio
	8OpcJeVkhxlhdtswH5STYnqkkF0uTRGWf/Wke+0ymdZjQoLRhkcSMdcoqyXZuomjanUUm6OkoXx
	r1Kn4PcbLyEW4mbyc50rqVGWkbK1JDDl3qO3hj8k7QWgzJiuQihGSQQ1y/tsfbmRp0w94ZRoGd/
	peUPfcakvmCAWwgTPzeiwkW2joSv53TzHxSMOOosm8kVwHGZlOyNpz4Ou2wP+uBLb+omsJmM6w=
	=
X-Google-Smtp-Source: AGHT+IHpBy809k4j/mgtJ3pLZAei1vSVsYHbL1LodLYl1qhBrEB6gEr4Vdl8NOXI+5UF/UVojJEPMQ==
X-Received: by 2002:a05:6a21:8dc3:b0:21a:ede2:2ea3 with SMTP id adf61e73a8af0-21fbd4d2985mr27026444637.17.1750312442235;
        Wed, 18 Jun 2025 22:54:02 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b04e4sm12287505b3a.121.2025.06.18.22.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:54:01 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:23:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Breno Leitao <leitao@debian.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <20250619055359.tormmysgxxcper6q@vireshk-i7>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
 <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>

On 18-06-25, 18:48, Miguel Ojeda wrote:
> On Sun, Jun 15, 2025 at 10:55 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Apply these changes and enable the lint -- no functional change
> > intended.
> 
> We need one more for `opp` [1] -- Viresh: I can do it on apply, unless
> you disagree.

Please do. Thanks.

> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a566fc3e7dcb..bc82a85ca883 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -92,7 +92,7 @@ fn to_c_str_array(names: &[CString]) ->
> Result<KVec<*const u8>> {
>      let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
> 
>      for name in names.iter() {
> -        list.push(name.as_ptr() as _, GFP_KERNEL)?;
> +        list.push(name.as_ptr().cast(), GFP_KERNEL)?;
>      }
> 
>      list.push(ptr::null(), GFP_KERNEL)?;

For cpufreq/opp:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

