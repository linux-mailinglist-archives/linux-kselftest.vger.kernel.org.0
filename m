Return-Path: <linux-kselftest+bounces-29715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39992A6E64C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF513AD20E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7521F3D21;
	Mon, 24 Mar 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdTZU7pl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006B1F1818;
	Mon, 24 Mar 2025 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853713; cv=none; b=S5OrYNgLbqmxeCPjMoXhvGrM6xOVsk5tFK7mQ89n7+3MBLjDRfQOe1GYLG31cDppMTHAv8bYzzjt3aKjblOl+FOHjPX91DAjILVn+yJP77LfcRbKjBBY0q3YsEvwaxXajHR7DDi0Txtivc8pUoMo7LSkqOWGP6N+HGrYPwxXeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853713; c=relaxed/simple;
	bh=eOC8GNYrVfiMmJjIlMnjsi5R6euOkfd+217Ym/0TGMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esM+UXoQu2vzK9hDGdmoDZdyOAiOcOTwc72mJF2g+HMc94eJuZleb34qg+VinoR6yneqsPjschC0N10SlaY7s/BWwmLN+lFh7CbgBRyHiJd9154kcPncl0UpuEnIJmL/OQTNcemcBPRqLae4vjX0ny7BB8JWVbVx0tHx8nVgVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdTZU7pl; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476f4e9cf92so33006231cf.3;
        Mon, 24 Mar 2025 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853710; x=1743458510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=WdTZU7plV7GkbNJFye/EY3dsg0YQQ1lWbnpT2YLuAztfsL+W6/YDxH8ZOrmQuo5YHf
         NlseHKPxgsmW3Z9R1+rmDyj+ifQZvmpeLRLsykULvIOxMmbZ6NOQMNcFy/C/0lzN1dFv
         q61VkXDNtQdCLff/FCdxrwzSeiO77prDXZHDc3HRrmR3eYCn1gCaz/9Oetfapu78ckhb
         9AxblaTrj2FGC7Ps58nBU4903myFAx4EYh/nI/woj17ghVx0BdQDIKd/JbjzIp/f0WqR
         sG0eNKkkLCy/C+aUMsgg4eA+MLWxq673u5G3xQPaqy6YIypE6UboE6vYS16o2/AWdogQ
         1P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853710; x=1743458510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=kcBQJhslX1gDNDCoZizjwbmx4cqhAfI3z5lgd89deTQ/W5UOsh9MH2p28LtpR+BDti
         DcWzN9/ElpR+UqKzMVXWW9svUkMyPlvUEs/pEPWf25J7rYYsn+LBx/UfCDQSKoK25Ttb
         NIfiWrDM12srE3BMA5ThF5MTgAzgVlCdKHXy01FU4pM3kcoGBFvJDhj/ed1lkvwxpJMw
         o5Fa3A4VU+kOpcV3e7kILtOUOf2PbTl3Bj7zNSkER2dwwTKu1CfOaG3ZDqfpmEoLoQuv
         m5a4e2ecTcbRcIaO8OPRy5PjxDluEDmeTmcMh8isdT39rdHzf4+XsLRmezBU3iwL097T
         pfUw==
X-Forwarded-Encrypted: i=1; AJvYcCU0EQMpI1XlzWJyvzoiNGQbCNhu3YbdmOCwdDJ9p6hNV9bbr6J5DqOQ4lxIPY1dkoaCwpHl/qY4tfWX@vger.kernel.org, AJvYcCV/LPNg/ILsQpFaEobWTq6XgJUvcSR+Q9Cc08lkeC896AxHOc4Gz1jhjKDhT0sES81Tkq+jm0f1@vger.kernel.org, AJvYcCV73CQu3lr3cap7ijqQzpZK4zKajWquG0PzbN9IUV9G1EY4DLBMplQZY9gSqzEisj+Z7IqMAr05EQJx50f47Co=@vger.kernel.org, AJvYcCVUZBCD0ZtiURjR9DYUI+htUhsODuF4rAL4WohjANwFVMxqGxexM09HDCPdGRPg4Pb0xHL5FeAM/80AAqUv@vger.kernel.org, AJvYcCVVZG2JgzwWJ/JsyFGKOvdkRfQTpV9Lc18LwA+ymdabagMecfjc8mFrJP3zu6I49xbxJ23BCC6VH8r+@vger.kernel.org, AJvYcCX1WbRlM7JMf5GmLevgRltfeW95OVuQHDazgOuQ/CJLsL7m5ZZR4N3956KOqSoV68gKMdz7Cm7N9nOi0B8GUmRL@vger.kernel.org, AJvYcCXO63+ql1JY5K9OQA+swORDZ/uR9SxO+tleMoomEHehSCKnsCvL1dO5dmQg5xjHhMJNbOIO8fFsw9furk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+Aivd/i83i//HyhIW/kU7SNyp/e3w+2uvj2+suNWN+BB9tXj
	LpKEliBX+AOVztohhXNCs7rgnrSzBn55xQmOObvMaOAQXC+GPY7k
X-Gm-Gg: ASbGncvcq1b8Dc+3/7+ayrb183Wc0/JZoCRD1b0K2aVtXfgLDXHz7jCNhW/qYzfeP2Z
	DSMyhGbaEnf4p4PKHunRr0CE4M/xjol5LjLQvsq+0zWAZSwRMsi1A4nsobnAZDOfbu2Zn56jmCw
	9/9wRH/8dqxPnm9lyV0OA/ttNow59ePzDTFiomGAE27AhKmBuq19DKaVF3nWfQRVtaZymVYpqsm
	aNyOGK1ZSmnRoRnIGn1FR5Qofg/MSTD+XkqfTFbnEeAHNpzyaCWMuabjdsRjrO0gTK0cMRyN4go
	NQfq3eZz9Xukd9gxhK3z63ewQAPqK1g0+p9JGu3OZYwDedXNH86QBy4/L3xVaEzFxE+5e8ckoBB
	q4sxirnugYf9Jf8Iok3K99k9lCEAUpLunB4eCYkUnU99jLUvWZl568w==
X-Google-Smtp-Source: AGHT+IFmPbwb4p7A5O3ShEsQauN8bwD2gzq9L0MWbRn2vSApft5OKiV5A0a4gUNuHtVtJVvTJbnmZg==
X-Received: by 2002:a05:622a:17c9:b0:476:7d74:dd10 with SMTP id d75a77b69052e-4771dd94dfcmr252627141cf.19.1742853710412;
        Mon, 24 Mar 2025 15:01:50 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm52129541cf.0.2025.03.24.15.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:01:50 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 18:01:33 -0400
Subject: [PATCH v6 4/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-ptr-as-ptr-v6-4-49d1b7fd4290@gmail.com>
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
In-Reply-To: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

In Rust 1.66.0, Clippy introduced the `as_ptr_cast_mut` lint [1]:

> Since `as_ptr` takes a `&self`, the pointer won’t have write
> permissions unless interior mutability is used, making it unlikely
> that having it as a mutable pointer is correct.

There is only one affected callsite, and the change amounts to replacing
`as _` with `.cast_mut().cast()`. This doesn't change the semantics, but
is more descriptive of what's going on.

Apply this change and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_ptr_cast_mut [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile              | 1 +
 rust/kernel/devres.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c62bae2b107b..bb15b86182a3 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3a9d998ec371..598001157293 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -143,7 +143,7 @@ fn remove_action(this: &Arc<Self>) {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
-                this.as_ptr() as _,
+                this.as_ptr().cast_mut().cast(),
             )
         };
 

-- 
2.48.1


