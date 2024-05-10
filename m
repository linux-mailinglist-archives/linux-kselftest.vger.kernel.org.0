Return-Path: <linux-kselftest+bounces-9947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580A8C1AFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70361C224B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C2136E35;
	Fri, 10 May 2024 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jymQnQvF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47B1369A4
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299852; cv=none; b=CPayTEYcc5lMf2VgTS/8IwvNcRU30vaJAwRxA328HGZUxTF7MTHlFXlwtOi7InB34nP8HKEbmnAkkSaEUKcdDtaPEvRGFuoVm/kI7cMKpFpxe4Mj33JUmN0ny2tNoLMD0u31T4DlQwB10UFyL1U5IptWMEdUJ9rNHloFld/a1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299852; c=relaxed/simple;
	bh=3599aDO6WJ8pRytY2emWkuJQ2LbOev5tgOUVnN1o3YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPQLFZ4gumQVK6XGWLiM5iK6T0KrNOnMRrFiRAhHJbzWhk4kTJwGRZxSTxQz1m4huZp8aQOxXAPl83JUPT+Yuo0wl/7fazYWF6KpAewk8HbXjof9JixjXeKYARXb+/DABLfjTiazm2N91ROAE7AW1dq8lrABz11aFDzCUDhut7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jymQnQvF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so1183584a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299850; x=1715904650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bektZwrY6X7Dpw89yPQbwlH2LMGiwkQluDbu3J3hz3c=;
        b=jymQnQvFtEjvQief/ZlpSZaGP5OlEPtcbvldH5FAN4cfd7AMH4wSYjdVd9WvgAAVk3
         ddRK/j1poEUOJZTeEIux/DjV5hE5BtWDQUWhZdThW3IJnyWiPxdFMdLimLai4hard+f6
         Uu2IqXiqkboYoc4fID0HlYe9P+KhhgXGFYc9A5lXpHkOVC5nn8e7zkAn7fdUtIIgr1HL
         5ewQ97KF6us7LDZQVZGtkxuZDPCJ2HPgPOdz8e/56o4SLimqRMdss7Itac5LJjnapB8b
         C9uQMjdjt1lI+kj7051czIt9ohhp8e4d9JSj78rT9cr2xjhjhteeBVUJ/S7JOpIEZB3x
         WSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299850; x=1715904650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bektZwrY6X7Dpw89yPQbwlH2LMGiwkQluDbu3J3hz3c=;
        b=HzJq0EN89I7OHXWAJAPScvQffPRVVvhuUGri6QVtvkBZYgDM9NkNfCj9stHufKwFA0
         hEyH9+qh32guybbFuRplx2N5HvFKxRfVFWYtFicOK9VkWIHbpumBYS0/ZDrJbzYKW5KT
         E/BfxCX17RVOnx7CD5rv9oV69eVU8cwl7xl0LloRavyyXZ5e19VOGugHmmXxTAo41FUI
         7HRoaXd+87e0xvITKtgHlJUVgOM0mB09AkKOaU1H0qpIWz+NOa/gcbhXQD5fRMdssp1M
         56pBCh8vej25XYhp5537GURW8LdCqfwG/giM5KF825qn003pB3bEUqFXSZyvhrp5lZM5
         MqIA==
X-Forwarded-Encrypted: i=1; AJvYcCWlt5CZ7mDAm90igqb/AFvuvM9X+vjBCGvVmM/454AITyCqw0To8vV45rawMBcYuA8E4DL6w5mTguu12FgH+ujlBJiBfUpdWToTOrW4Gc/Q
X-Gm-Message-State: AOJu0YzEt3N6Iitdz6Y/NsSoc93YqT7J7pY9g9/heLark0ME55L6+TmX
	tcruEXy+QYICQjlGeuLEQE+I+8blDF14pqteVSJJJfhWYE8ex+J+EDhUUNQk4V+uhmF1bDb/TB8
	pew==
X-Google-Smtp-Source: AGHT+IFR++Zjt53C83A0ZTqwu8l54Ivkf0uoSk3K8zVOgmN6xwNzb6wjdLB/lVbnRF6C4M3ptYxz3Wu0FZs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:4504:0:b0:5db:edca:d171 with SMTP id
 41be03b00d2f7-6373ce415d8mr2316a12.6.1715299849968; Thu, 09 May 2024 17:10:49
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:53 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-37-edliaw@google.com>
Subject: [PATCH v4 36/66] selftests/net: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 522d991e310e..c608b1ec02e6 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
 LDLIBS	+= $(LIB) -pthread
 LIBDEPS	:= lib/aolib.h Makefile
 
-CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
+CFLAGS	:= -Wall -O2 -g -fno-strict-aliasing
 CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
-- 
2.45.0.118.g7fe29c98d7-goog


