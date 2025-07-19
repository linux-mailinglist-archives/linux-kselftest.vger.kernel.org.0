Return-Path: <linux-kselftest+bounces-37666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D956CB0B284
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBFB17F16F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF328C84B;
	Sat, 19 Jul 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghkw7/kl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4328C5AF;
	Sat, 19 Jul 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964967; cv=none; b=s2r1eWc3QUQU4Ad2mMN3FG6N8syRQZ8k1pyMiNaAGWWj0qoEsDKBcw3iFPB4d3wfNwor5Noh2LyE3oAIt8Nsoewwu5pAULuzOy6KxhHQu6ZUwYVK418bMY47IwmiyT4mBXweCyGtboIiqBZDdmhoXDMfj2jrZhazI+E1iZtrGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964967; c=relaxed/simple;
	bh=Md5viX5GUz2R5mJkUWEkGx2lyxvokj0qp94Xg8uiCEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hm5dg9cHVUmhN3Wg1zXFAkFjDy4bXYJGqmC7vGYRUf4iIYA37FCi6BH1QOS32x9PvLZI+CGPtqy+0oOubZZzlpmpCnnaGY+B89ALNOa4gGRG10JZinMCgucW4WWvJgGKype9+enL6ab4Edc8og9FYLcThVnWdCnxk4nCCkUho34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghkw7/kl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e346ab52e9so420317085a.2;
        Sat, 19 Jul 2025 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964965; x=1753569765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDWC2vJajr5e99NLv/Ti1ax5HIYUjw/FV4qUgNUzVj8=;
        b=Ghkw7/klOCj/PNtIiTnO0RF9NUvZ9VZYdPrY9UzkmYri5CXZkQNuSAkbHM/TjNHkV2
         AktkN65i9IcRIhUcq+aSbgXT81COHdF+h5NKk9jX+5sr1KNFLECCs+nVY9c2p0JuR36i
         aN87QOWzZongsszEI4VUPcvylnF8BkadJHuZptBpHwMfBsZqbfVtaBtfqq3ttjtt/HHf
         iE2FIX1HlwZCVnzy4ySYINFed/ia1s2T6UHXzbkjKkk24wqvJjVb9/URsuGxQ2SEBXMc
         s86rYf+9QqXfxz9BcBEIhAT8zk5P8A0IExbOcWSSaZPPFmbov1Xu0uGPmrsdaYrvely8
         Qf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964965; x=1753569765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDWC2vJajr5e99NLv/Ti1ax5HIYUjw/FV4qUgNUzVj8=;
        b=sFCv2MAF+seEHnu5qD+oz8OhcgHzUGAVVcnEbx3nCq4pWNo5Kv6zqsHtQLRB4hsHCk
         JEaxT8ptx4be09FOqlojSFvCRnlUjUeq6y6dRTRBvBM80nYtFW7dL60YIJBmDRAvtgo4
         l0SezUNLCr6SwIqWkL09C8dImtTkrcqq8UoQhVy1hBCWHGw79QElPoBtSMzjht0VfHNF
         cvpn4J4XkA2IGxXVuVIPLhvZPpz1XJVCWhqo9lZnHXxUbQSawnEUwJATkD2PEXc9KNcM
         ZryXm9RMl4bkVHscoX/q/XN6Zl/eDFS4j4lKIgKG1nxpEut5Ul51YWvwIIwLafnOZRty
         IJJA==
X-Forwarded-Encrypted: i=1; AJvYcCUDk6qEC9LuCgPqpTKzjaw8XJmKHG5fjmH8XMQ5Q3ESf04Iy/oNJDjl20SHgSJLmgztKjl9QuqC1U8=@vger.kernel.org, AJvYcCUoa4fdSV3cCiIV79hzIFd6rEI/KQsua/nOo/DkSQemZYG9ey8qvPN+zUEu97X6BL93r6bXdQauZMSai3l3vORd@vger.kernel.org, AJvYcCW/0LhM3n/vPNoB1Ol2ovQDM/pEQPGwgTAD8cOLlD+9NSshqwIXVmf0nZl9EZJDzWbROeaiRT+rlOI/fr8pytI=@vger.kernel.org, AJvYcCW7o7WIo4rgoNIr1xAMeLCo0ZMpOxk8pUKQr/H17J8AqFHnTrBw/jPSQ48IW3pOp6omRImkBN0svyix0Awn@vger.kernel.org, AJvYcCWbWofA20vgVqYo8KIYx7YOdx5gi2OwY3Bp2pT4K6DvM8Y0en9vRXhSwUm864Mv5fFLZsDETZ4f@vger.kernel.org, AJvYcCX9xnWfvhq0OZR/YuvDzpsslyai8Rq4rd7QM7ZYehDUo5lRrlNYv+EM7bnLabIUsdQsBYSNl+E5OtwX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XrBOHDrbdWiU2NH5GWmMBR53Jf94k/T6ZOs3WXok6OZXmU13
	gSYYUs+lAHifhqOTtULXUPWyUqTpqawkf3l4IhnWPP9MOpzWbDVGf+j3
X-Gm-Gg: ASbGnctETnA1Ffg3f8LWVnyTgiACxq8djZGxg3kLMczFIA16sSv7p9ZT4Eg/Yfc+owf
	dEbhr074i/f+VOB51P+CfR37eiQPAfPbk/lgiEegSWSrEI8+fNhlpqNXtpGSMLjDIRJ8axlDbqb
	Hbs94Ik8ZgjOuGDoP/3cq1ZKsNquA9UTHG3VcNmxky8RIKdaSxV0Eq91XWiTBnYuqQXyacag7CE
	WAHKc97Zuo/EZoso2KEOkxFolck4R2iEqIrLven9uaYu2VcnZeuhCDHZS75GOgKVs/csVLmNwgL
	ecN/PH1304C1NShVyApcX5A4dA1oPQWyeX6Opm0G1MMAhG5N3T4xRoDadwV1t+r+aMEh03OIXd3
	9v9to4q+AtbFtVeD0T3yL57+oXYKCBQtXCwb9raO2asHEBpy9tKltfxFDujeyh0IP8hqZcE3dM/
	goD8/p+ZYyS8/ggDlDzdUJIdC3v8+fcO0w/WO2kkk=
X-Google-Smtp-Source: AGHT+IE9V4lUrp6+KizRk5T1lH1N1yFglQFV1kwy0rjAllnBSIOC4NKWikOxAmpD+50/9TKsIJOTpA==
X-Received: by 2002:a05:620a:6019:b0:7c5:3d60:7f91 with SMTP id af79cd13be357-7e34355ebc3mr2518295185a.15.1752964965239;
        Sat, 19 Jul 2025 15:42:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:33 -0400
Subject: [PATCH v2 04/10] rust: cpufreq: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=1043;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Md5viX5GUz2R5mJkUWEkGx2lyxvokj0qp94Xg8uiCEU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBE0v/HGS7nTLm+VoHQjFRVbHknYbIoX7Qf4J+/U3Mp8SY1LNU4ZJaFGEgU3gct0Sxv0sDo4F/t
 03jQu+PPrfwo=
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
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index e8d231971276..71d601f7c261 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
-        let src = name.as_bytes_with_nul();
+        let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];
 
         build_assert!(src.len() <= CPUFREQ_NAME_LEN);

-- 
2.50.1


