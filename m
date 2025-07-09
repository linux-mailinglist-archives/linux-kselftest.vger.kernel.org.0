Return-Path: <linux-kselftest+bounces-36856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20872AFF229
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8715A5D2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC72242D8A;
	Wed,  9 Jul 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6nR+H5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A882238D42;
	Wed,  9 Jul 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091139; cv=none; b=UpOkBU0IQOvZa155ee8p1e/Anhu77QwSIIYk7la4pTTVeiJrFe9jZ+x8XQCwM0WFx452zS5PiAW8CtAi/SVXg8mlmodSKvUnrn7/60PondSveC0fdI4exJSRRsrli++go2yiiSXGNAuQC6Holb44t6/fPFoxSInA8vVzoX17JXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091139; c=relaxed/simple;
	bh=nBlkFnTcckjF5CbJjPS9IWrVMsJlh81nI5aNSP2eMQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gy6l1Vu74YasholVHIDYDA3ItZJiscLef5eUn0LNfAKdBdobofWt9hyfku6sTfwsmO5ICB7ZARScVNDz2rZSka3Lh4uEGQ3zPiCbIi0Spsr2MGe1N9peXcQJwHwIPBfgoDeCQS5KyxSQ4fe1ikFcGsmRwKmDjLolhcY03IdHJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6nR+H5r; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a5903bceffso3752541cf.3;
        Wed, 09 Jul 2025 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091136; x=1752695936; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugaGedfdExj0AxEbdScIbc7eibANo0qNIkwwni0XDDk=;
        b=j6nR+H5rQfjSzOb7FPh5oa38yswzeA6PcfpOlRP5pTp5z2oy7xPkoZ4ObsUNuaD6k/
         ShheosKIgDfokI5wfjg9twiF/Q9FVPWbDoWQfhxoFOM0K2tXVnvllB3nq7QIbTRBhsPP
         vl1dKrdWq/Z5NIKI5t5ZI0BapLxq3nk38psFFaIUT6n0Vn2VrgWHk++98tseB+pw6bKQ
         Ju6g3Vy/SjjSMtAvsqU/M4BcNrdCkQH6y+50P2jUYKQlxOy/jUyuwmVldKL6XnnHML74
         5pfh9iyAifA6nTV9TGI91p4JuQQ39vRNccH3bJdgLPrv+rq/pNrSD7/ONs4oSL2ICo56
         UYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091136; x=1752695936;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugaGedfdExj0AxEbdScIbc7eibANo0qNIkwwni0XDDk=;
        b=PH/yEn5cHCvjGy7cEwJiAu4aPIEdtcgC3+3XGDUARZS2/hBo7k1zslMiJB5mfHuxuI
         AgLhKeD4K8XCdJwImbVoIJXJslTGT7Z4n7oZzNR3RhBMXjQavmtFC1S2yiMtIx92NCaW
         rvUhUlmQs/hn97EYuBPkWj6pi9uGFn/M79BYtLpHvx0keryFhRCRhFBhuQ0Ji3QFjunJ
         tC3ePW7Mq/EFbzT2fPfRP9uMKNOzf+zUYSJGeJH+qxIdEVtG8q96ln9cpNjBBN2/w/wn
         uca62MCpQFRT7zH4bJdkFirP1QQpsxCYI86sbD/NInU9AbjticgWuaQu6HlScn92NrCV
         oJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74P+ZENs14aiCkkzjYnqj4sfbPawN36YwlfdfYVIs59p9G9cb0XSuCctHA89AZTvebP2T6KplqeHtJPEJCCo=@vger.kernel.org, AJvYcCVyTINIyFtHWlrC3CErVIcdn7fJv2RJXK465rP1gX+xsbBt+Id4xodU8UfPWU5OEWy9wz0+bvek@vger.kernel.org, AJvYcCWC+LviKilTHcCxymysTrmgsWymJhcr7vRviMn4E40gx9+0dClPwWELI1jLweJPIZdtQtN4q6trUxqi8ng8@vger.kernel.org, AJvYcCX/idahRA+edWwzVA92S+Il0qam+PNw5ad3IeqbVpYn3o3fSLOdxk5/Ba3ZT2Q0hG+Cr2c6PXkQeOkX8mk1hkjg@vger.kernel.org, AJvYcCXlWw5QKaphLtRNNvP69Bd3GVqbfLsSYRL9ZtCufBvx39KuawGiAwAVQC+LMTjw3cHMLtKatWBOl2CU@vger.kernel.org, AJvYcCXwqDdbyVPF3p3FcyGb3cKPN0gwXltjBRsaoiV2QgUHAMfb59LbZWCHTwuFaQ4sJ4SEWj89nPk/Xds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotZx+clUs2VcQysSmDQuVmJXIQHy3RyKsSmMDWAXQQ0iIchH7
	IiiFvcN2KRBgM+j7pijAt34OGAcgwC9OzCfE8qKuaztyD1+Y6ASDiCTc9BaL3+MxNzUEUw==
X-Gm-Gg: ASbGnct5aD0uC7HSfnutOd0s52ur5xVvK5p9F677/aAeE38G34znPLguoz51yeLIt0H
	S0EE7nlwrUNIKGUYERNMG7Mg0vUlCNR5LFOaNWmNQE0I6RFSFMrTIIDpq+jNeUB8hoXWEaqID1M
	Qmbp/4G2oRDIvd9dIR/JncJWkc3Q1mL3gG+P3MxsEn05mQbZupypYWEVkAio3l9xCCoyiJyOOX8
	/4e4zHUEXmnwQE7+U2uGhs1NGleW0gSphBEbbdZX6PD2kyUq832ZiPoXLx9PGbUdnLJzxyUmfd0
	SFWibW6rIblr5kVSyRp+zNFZgsVhkUFpoaVEkU7+FFRaptV3P3Y8IqPQoFLc8wMfSzcyDO/00no
	CYcBs2KzRzlyD/+Id4SSR7rY/r1nMRSqG+TljpMSJg1hTExwDMcerX5F/OA==
X-Google-Smtp-Source: AGHT+IFRJMxckO2ZQvxVzuz0BTX9q93fp894dtK/TcLSk4gRDmqByiX9UXubFC3KSQukPV9ZDJz60Q==
X-Received: by 2002:a05:622a:1825:b0:4a9:94c7:f34f with SMTP id d75a77b69052e-4a9dec94b7amr59291501cf.21.1752091135769;
        Wed, 09 Jul 2025 12:58:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:58:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 00/10] rust: use `core::ffi::CStr` method names
Date: Wed, 09 Jul 2025 15:58:50 -0400
Message-Id: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrJbmgC/02OzQ7CIBAGX6XZsySwpaz0VYwHfhblYKvQGpOm7
 y5RDx5nk51vNqhcMlcYuw0KP3PN89RAHToIVzddWOTYGFDiIElaEebCItSliOSmeV2EEgmlUer
 YIxJCe7wXTvn1kZ7OXy78WJt7+R7Bu9ok8+2Wl7EjY7lH7Y3xMlqMUqdeDVEGPTiZCKmnQNpq+
 G8au1+R/itqQ3fXwHrLxpGPA/H4VHDe9zfyzQPq6QAAAA==
X-Change-ID: 20250709-core-cstr-fanout-1-f20611832272
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091132; l=2312;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=nBlkFnTcckjF5CbJjPS9IWrVMsJlh81nI5aNSP2eMQM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QL+jEyeJUnwusSTpkUHLNcdvrxo7ekehQIgOJYoy7eGmGdn3FOTGxYt4+VTVEjFPwFYmYhRb1/P
 mWbFKLWIEewY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This is series 2b/5 of the migration to `core::ffi::CStr`[0].
20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.

This series depends on the prior series[0] and is intended to go through
the rust tree to reduce the number of release cycles required to
complete the work.

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the other series must go).

[0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (10):
      gpu: nova-core: use `core::ffi::CStr` method names
      rust: auxiliary: use `core::ffi::CStr` method names
      rust: configfs: use `core::ffi::CStr` method names
      rust: cpufreq: use `core::ffi::CStr` method names
      rust: drm: use `core::ffi::CStr` method names
      rust: firmware: use `core::ffi::CStr` method names
      rust: kunit: use `core::ffi::CStr` method names
      rust: miscdevice: use `core::ffi::CStr` method names
      rust: net: use `core::ffi::CStr` method names
      rust: of: use `core::ffi::CStr` method names

 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 rust/kernel/auxiliary.rs        | 4 ++--
 rust/kernel/configfs.rs         | 4 ++--
 rust/kernel/cpufreq.rs          | 2 +-
 rust/kernel/drm/device.rs       | 4 ++--
 rust/kernel/firmware.rs         | 2 +-
 rust/kernel/kunit.rs            | 6 +++---
 rust/kernel/miscdevice.rs       | 2 +-
 rust/kernel/net/phy.rs          | 2 +-
 rust/kernel/of.rs               | 2 +-
 samples/rust/rust_configfs.rs   | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
change-id: 20250709-core-cstr-fanout-1-f20611832272
prerequisite-change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e:v1
prerequisite-patch-id: 83b1239d1805f206711a5a936bbb61c83227d573
prerequisite-patch-id: a0355dd0efcc945b0565dc4e5a0f42b5a3d29c7e
prerequisite-patch-id: 8585bf441cfab705181f5606c63483c2e88d25aa
prerequisite-patch-id: 04ec344c0bc23f90dbeac10afe26df1a86ce53ec
prerequisite-patch-id: a2fc6cd05fce6d6da8d401e9f8a905bb5c0b2f27
prerequisite-patch-id: f14c099c87562069f25fb7aea6d9aae4086c49a8

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


