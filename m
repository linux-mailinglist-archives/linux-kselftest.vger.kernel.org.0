Return-Path: <linux-kselftest+bounces-46910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09981C9CD06
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280B03AA41F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3C2F6160;
	Tue,  2 Dec 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrzA+pEp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E12F39C4
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704300; cv=none; b=tx1yMJ94peybUipWGUBgjeEaw5rfw8G1RKrbnsFJMca5TdN51lvjxUSWzciss6b4Ac+hUrxRUfUCKrxtXHOzma8RsnW7y6+pQWIrQNEzJuLfTCprS1BxzIXCBrl/va6K3yECLxSzcb1hpmuhUonLGGKt04zhc0CW9kWjfyak6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704300; c=relaxed/simple;
	bh=b4hkmeC+wFUlheAh0FzFDJuK+/w3bz7OF5SAt7uxYag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K8SM014ilgJ1HjwFkJ7o3MtCn/7Cd+zA+jykiROJO99ZJoSVzyXXlD8Zsu1FsuO/jvLzaLaQQFO04z/sS+ouetP3FEEhJVOTCuKELvVGInm3Pg1xClJmIADNh1RTj1CIhvJKiOfa1YvCNgzw55laAcHeMspsbQ1pmcEcGducDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrzA+pEp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b56125e77so3131104f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 11:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704296; x=1765309096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9I4jS+CkOD8WcMHOPpX2Laq2znDkJHzIQe6va7xDus=;
        b=WrzA+pEphUfmU3Vlzk8uqm0dnUCGcqEtQbymBc3+xfZWXuRoqkIGsQywNgAuSjwaDI
         l01Jb1Z7nFyPnb1YEoBYGCjgo/XvQgbNF2uVNky6SzF2aUsPc+xFrflxpxgO+4GbIIXH
         gs00R+mU7oXG7bl6x+9sUC5vp/c72H6YalIc9dGY4TmivGAAncHxKQBECVlAY3pWgNQq
         kuy47TzdDVBhv6u1xAC29wSdtp0+mUB/0Jh6LXT+aKIDHwXqjikFukOXutQ2Hig4hKKf
         iwhgrirAWLhd/0nDmkiuZHY3m9Wfm00bsLr6XpXFqJezDJQLPDtssMFasmfJf9xReVcb
         dKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704296; x=1765309096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9I4jS+CkOD8WcMHOPpX2Laq2znDkJHzIQe6va7xDus=;
        b=XTWofkPB9WgmAlNFua41KuR5l0JL6V8PfvULkoo+zmnaKCRkltlePOePBLw+dZatk7
         yZ1PCg9Qz7inUSAicQzLhm39CgP4vmXYxtyiCpcyUbU3ZJ2RcySuzzg2K8tWkUYl7+OW
         Rka+TDPDfBZYEetrcwKPf5nE03XxKlDWhKfHkgWTVOq7NCAQ347XjjhBgroD00fYJSxY
         4saJaOd2T+nVB3PSSYRF48K01Fu2Nwt8ml/Vj6bEev+B8fkCzeihQ0kwi9EgKFBK1V8U
         kRHu7LB/VcKyjzDuDhdahrI/eJiT++vtaYWSvTa06jWLgC0UEP4wnS/NgxsSEvRg9If0
         g65w==
X-Forwarded-Encrypted: i=1; AJvYcCVfG+sJ3jtElnxUFjbbGqPui+rMHvy+KCOAdwEX+zXcSjZb6ruC9wQZUNjO+nK5qbhbas65dJDS0qBgcFJ8z30=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbw1yhoV9RrQQm9puMrwcFkY1ADbjb/QKfXQjb+b3gjD5AxAOY
	rcz/ett6ZULK2Mx3mdrrlEPSsP0SHMUO4XdrtpYNpiWoEwBGWhctmM2gZUhdblN6TqH+st0lgCP
	Mg0g625JkWf2ZXDGclw==
X-Google-Smtp-Source: AGHT+IFafOW37ZpmXOGIJbp/0M7mmCXdck1lXQ8qYTVq025nRVZmT5HEkDQlb5GS0Sbcn6sHCWPrq/xZgSglm7c=
X-Received: from wrpc7.prod.google.com ([2002:adf:ef47:0:b0:429:c1fd:61fe])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2410:b0:42b:36f4:cd22 with SMTP id ffacd0b85a97d-42e0f344714mr34472907f8f.38.1764704295819;
 Tue, 02 Dec 2025 11:38:15 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:46 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=b4hkmeC+wFUlheAh0FzFDJuK+/w3bz7OF5SAt7uxYag=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AJBMbP/V8F4ca/e7BxIHaBBhe7jbhS/93kZ
 23C/DV/phqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACQAKCRAEWL7uWMY5
 RiTQEACcavWxpeD7XyNzmd9xA3CRvW0Gkngtveouc4E0U9uCwR7rKcVHB1yAAzYqnbsCbLgeHMP
 twUdVG7qDGJy0WYD5pf4m1ITBQTdQ1dlw1Kl+K0MSVEuwpuaE0TOyoaHF2fNZ4okPQoqAi3eF1r
 5RwBQjJ1WjzQSo/wLXB3AyWkARC8rJcTYLESNiEs//zLaf+dx6gTrXsgyMUofoAfiM6gDl5sU8o
 3pB3iU4PfIzPYQd1iAbngPilPm1o8KUkYHQX7AI8vv5Fu9P5qDeDcfmNLoiI/CP9pxCQgyUhtPB
 sZ+RSFnM6Aw6FDvmpN2x/RpePJ/fnvuva55OGCTxwexo4zD3EWjkDxu+w04bWFWfdAYnZry3F8v
 hNWa9DuAqZ6RormLBfN6/BPuzoX6smAGPLzC1yVKlP7YqymgEkm3W2/4e/wBxiF9BXFDJYWtN7c
 Mg1sI5bVQnpTlMwA2dMcodkCbCkiLLMaU2NFMB4LFIWdQXDTmdHt63nZiHMBRbOa4ah1O3lmjd9
 e2/T+8DI8iit9jF3eYiZgICWpHEm19947slxtTGzd3rrc+ThYMBLgKMfkULezQfTXCHGmnhdSWW
 77TfecTGBNYxVrhFqww9fnhQNTP/7k35F0rm9wWmkkzhwldmf8QbjnZTjY0m56Rc7hf3d19NfVO e5N26Dt80LxNLHw==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-22-a2e13cbc17a6@google.com>
Subject: [PATCH 22/46] rust: kunit: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
---
 rust/helpers/kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
index b85a4d394c118906d35ffef85221cf1a8b3c6fe3..cafb94b6776c07fe505e1749de71f91125006131 100644
--- a/rust/helpers/kunit.c
+++ b/rust/helpers/kunit.c
@@ -2,7 +2,7 @@
 
 #include <kunit/test-bug.h>
 
-struct kunit *rust_helper_kunit_get_current_test(void)
+__rust_helper struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
 }

-- 
2.52.0.158.g65b55ccf14-goog


