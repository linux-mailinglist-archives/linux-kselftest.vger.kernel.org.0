Return-Path: <linux-kselftest+bounces-37663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B258B0B276
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E6D7A6B8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D228BA98;
	Sat, 19 Jul 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js73WRWw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3582874F3;
	Sat, 19 Jul 2025 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964962; cv=none; b=tbgy3EnVbchn0zJCabkc6FkAplBeZhng+XdeqWlME9GsJQnvmiARsuCORiR7pi1QrgDzH0k9ANLEB5IHiVjoPW74/VwsNFXqJw0Hz3p/pIKuTtWmVGPYYjGq46FjqWag7xg6CIflSxj4r1WF6WDYR/fTF/7FMOCVQhzA+QrEpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964962; c=relaxed/simple;
	bh=krK+3YMl5oU/necDPLT7VgqDzfPLDYadhp25r7hehrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXmq7v607nZfpdaQ2Pyl/nev6TsR+0Gzjq94lVuKFciqfsz7B7WDh0r57SQvg+sky0IVazvytX63RTJXX7THHDxRAU5f4zSwrdVpB+JMjHbEGsIhpTZZVRNsvjqKf4f4ty3LeFQNvFrO0GmQCvfDBWEkweY5ZPHQCpbe3+dgnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js73WRWw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab814c4f2dso63861171cf.1;
        Sat, 19 Jul 2025 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964960; x=1753569760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDyvCg6OCGjHghiPPtdJYx7X44vJDB73UWdtSHOk4Co=;
        b=Js73WRWw0CtFVyYIM2krcAM9uQwrCyuUgBEBjmiC/xWNIXrkXERr//gTBYDZennRtN
         btK99c82oKVjjUtrovpxa5nsV12j3/W7ilg2PPRsJz8ODYNHSvl2cF6Hgr0zOkWu1a2q
         qb+byddGcJ6ZRV9sOxSyuUTgo6KwraTnOZssNTEhQhag6rFi69kvLyadEwnMtnBg6Qjw
         fKx+ImLNADHFse2H7jBQ1QDkIWG0ecS7iw18imDdL/D5PdMUCdEWtEXy+zmQgjd5AuvF
         WO9yzidBgT0W3UgmVcbO/4eE2WAxThWKBhUY98j3RUk4TyoD/X7fVvHasyw75MbdeDUB
         XFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964960; x=1753569760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDyvCg6OCGjHghiPPtdJYx7X44vJDB73UWdtSHOk4Co=;
        b=U6dAwgRaCGWsr6aZgZu29WYRdE042TOnc3X3rLtq1ykmbamqUQqmEXcRaUVqEwd5D9
         PxTYRpJ6Wy7d4pCUcqDF0Vlz6wuD+D9SQL2/9CRCL+HkHHjL953V1J5YBoGRxmpHylFp
         UPkAoSux4JuYOZ3k8JUy1OzSyasNCjNXWoJB8iyqT7AYuJ9L9jYDAM6WqMveQkzgKaUj
         GcveRumCnjWDnDBS/ZCjlgJyfzt+IBWWM5YPWmVRd7KL6gwblH42MR4L1lbccchxM7Lo
         r5ii+wWP2wGMcbDR33AwL+JjjOOfhOuKJ8sN+47D1756faCQt2pUVG1PyiWIskgB7nCz
         eWGw==
X-Forwarded-Encrypted: i=1; AJvYcCU6FJbsGcDN14v2bOeud4zJYIdUKp2jZKeIl3k8I9x6AcpMD4cLmF7JLDlR+zzSJ4AWYWI9UQtDu27Z+beo@vger.kernel.org, AJvYcCVoaI9p33hqiAP5l3h1Pq1Cj3UONA+GxoxHAQTKCBR9sPTXZh1K+iOuT8mXrtmRGKiZL5PWmFSh@vger.kernel.org, AJvYcCWROBN0dtkRACQTTtX8d+Xvuxj4xmhs/kDmQCVb7eVh+oNNlO0PYutWiqHXMfuh80FjfIVGBVMObLctqPTKYh8=@vger.kernel.org, AJvYcCWTlkmDs+bllb1swdhvu6k/9uj9LQ0sl7i3TaOiOjZNjb+anAiN2WH1alrBmxt0GoEWVqj4sAcsB9s=@vger.kernel.org, AJvYcCWySmBnqJiicJq+SIWBlvreLxI8vZG/fDJlIqh4204FjGQFxpOIVGrY1eZ/Jkfk1gyCgHVu8iqW6mGCKdYxTBHK@vger.kernel.org, AJvYcCXv7XbTcQaFVxFnpdIG2nDj1uiTFtzucK7AbP+ubREuT6fIpXJ3mGU4h210KUWygSqQWU9MQnWYwXQg@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1x9zV9UDpHLLIRvmMJA7SOE5AuFfq+FCgsXITBonTINIAvgd
	FyM+SJZkm1OlGXsYAAnL94KZ7gA4EaZGI/zq8RYBI3/EtE1IH/u0ErVt
X-Gm-Gg: ASbGnctGdXXYMOsvDF1FCAbnRM6NXnw62O/2FOaVQYiWdZ8J4AS1X7Rh24+6qwwG8il
	5Wn4IPdmLzRj/rw6s1MEkDWPDd8mDZ19o4xq5UJZ2eBDG6s0gKDw6/f20kpPjlKgGO/obxRCChD
	seMUPFMWUB2m9bjA4AJA1dQ+eIklJ9AztCUO10JUQH8OF/ZUl5SeGshEjmoHxdlLwKAsMogcWQJ
	25W5vQwNReAJr/70h7+I5YFXaC27oQ3KfykRxbVHiwSeRDVyVJ16vYaLW+P/rG7qMS//AmmT8tJ
	vQBZ0yS4d1LXoCdWEIHxYuYYBYynj/7y9U/NUTN0m+UOZ4cyEGz5L9lUT9EEUlUogjqbKzWalwB
	KJXberNHez8NdBoCISLqQqXkjpuCK7ZOTu5nbjrqY96HWFGZIWGE3KwxpKuPUpIhGqnsbBHXkGt
	bRcV80SRAXndvD9Aa2TLVwvwb3DUgiIhUYUbJF7xI=
X-Google-Smtp-Source: AGHT+IHBfhdGXApBiVWQorGUCWi73mqLnvE4gnHm5ZaJ+siueYioUFLzEt+GvjWANDcL9kctlLGzHw==
X-Received: by 2002:ac8:5a04:0:b0:4ab:6c19:d098 with SMTP id d75a77b69052e-4ab93c46869mr278593991cf.3.1752964959752;
        Sat, 19 Jul 2025 15:42:39 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:30 -0400
Subject: [PATCH v2 01/10] drm/panic: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-1-e1cb53f6d233@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964954; l=1187;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=krK+3YMl5oU/necDPLT7VgqDzfPLDYadhp25r7hehrw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHhiBQtj1RxNjNRICZbpjlofaISy1qzCpySnu0Qgl6jFOoJQZcOHFnEGcqwbaywKSIXH1ZqIPur
 3oScZEqsysQM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 6b59d19ab631..fea062cc0383 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -948,7 +948,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
         // nul-terminated string.
         let url_cstr: &CStr = unsafe { CStr::from_char_ptr(url) };
         let segments = &[
-            &Segment::Binary(url_cstr.as_bytes()),
+            &Segment::Binary(url_cstr.to_bytes()),
             &Segment::Numeric(&data_slice[0..data_len]),
         ];
         match EncodedMsg::new(segments, tmp_slice) {

-- 
2.50.1


