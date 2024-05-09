Return-Path: <linux-kselftest+bounces-9842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3828C163A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6661C235CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30831136992;
	Thu,  9 May 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZ1i/hQ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BEE136673
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284904; cv=none; b=LR6M2+/GFwcOLbgwvmczGjzgUWotJfp/MIKl8z9d4uZushfkoEot13MEvesD2mnd8iUA/Gj7fxe4N/vAoXHbmMHX+QhOjs+bFHWGDN8lD3IzdGb5+3VzQBtfy7iEAxEYgiklySTHMt5fIB6nWIOsjX09wF2IxfOJ9Dxg3iUTsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284904; c=relaxed/simple;
	bh=IwTjZ+QkHecjItm4ac17VTR49XMvagwZXgy5gGzNQGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oL1MaLRF24CTs3Oh6Ty4+p0BoLAbcL2D1583clhFmloSf31LeimBTHo87tX7frQKj8gu7Y58gVBWbxZRSNQiztfNSsWKpGDw+v7Fz2UlTWuN69oymNMzXkiLv5g2PWPFmLCCi9/X3Dlq1KmVENp1m/EBvBRXDoHq+VRbrMVa5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZ1i/hQ3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso23820827b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284902; x=1715889702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=hZ1i/hQ3iQYjcf2650k3wXoi0TtKjLrsTyOhLuuTzHrQfURK5hdVS4XfEvSiLsPFpM
         g/S2AeXQFJb0jMwwhSYRy/chnRePBxIJwgDq24ueEa/o5td+sslYBrmiBahvYan0jCWH
         pZlQZwu9URZtWSSo5/pvUZ8HFU8fe9aIYDYha369Y+elTzT0h8sRzFuLO4VkYAo1j+uD
         dfqa9H3Sn+OQbmG4Knz5s+MW+0xK6k6p5B9YviwXnlun2rOaQmPtHEQSbB4UTM/TV9Om
         m4fW35iF9TUfeacThNS5809727tL6HRWPgTYIqjM8PRkssbguoXYaokaJ5lRiuEQcIo+
         vOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284902; x=1715889702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=qIJ8snPp+jywZ3SrBrpKBtHVwSFAvG33lpkFsO3JQN9awTAVe6SaJ3b1JleSi8zV0/
         B7ex1w15eVsOjgNOey8UVhFlAmAQ+x8Zq4iXJr/S1lU0lJjAVnbeZHzXsg/u+utg/ufa
         MnT0nYdw/reyiY/r5IRKDXryHebiqcKEwxo6eWNGiSyS7KhA7ENcbfETwK0qbURTNt3+
         w5gs1fjdd4/Dhkgaw1h6J9VKY0U0HrX/8jSuXqrkgabTsDGfVjtMnDmUVq1G+JebT+aV
         uuw23JusBuI2sSSs0TV4yg6DLAO6U3paBjOnKB9bEXRLf8Qe2q0MwrHsE5Y+3mUAt6IP
         B8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWQkDSvqBQj5aTxr027V+gO21QEHHJGNsR18XuQ986dVAnCCX2L116QRaCg4Zb+gyQvDW0RKMTo0PogSbRU9JpVVRV05wV/khLXkzG9zCjL
X-Gm-Message-State: AOJu0Yz7ZgbpVSAYvCjZIw4rusaN8YBD3hC5EgS5IWMpw6YZouYe1w4D
	18WF4Uf5UN20CUpLskTsyrHJN4lbDVEAaq/bJZNfyDCZ8Gu58KN2rmXMuGJ2QD1zGTV1HbhcHaL
	c7g==
X-Google-Smtp-Source: AGHT+IHyuWY5940dXI+8MYdK3cHUYO5oPq33T22zpT2ioJu3FvZMtTFAIbDVKX9sxGXi1YbC+ZrN2B4TRNI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a5b:182:0:b0:de5:4ed6:d3f3 with SMTP id
 3f1490d57ef6-dee4f2e03c0mr141982276.6.1715284901753; Thu, 09 May 2024
 13:01:41 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:11 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-20-edliaw@google.com>
Subject: [PATCH v3 19/68] selftests/firmware: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


