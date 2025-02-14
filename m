Return-Path: <linux-kselftest+bounces-26649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA7FA35E54
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC383B3034
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889C265CAE;
	Fri, 14 Feb 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI1xvKAL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1E2641C5;
	Fri, 14 Feb 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538153; cv=none; b=akbAptXKrR4nycLaVn+sSVnLZFT6DScrWdoxxZWT1BfwNvrrWQml5klzkaj+7iHfx7EL2flc8knDkfUEgR37PHme4TSHlT8oVyJNTZgWAOWL0YL7+2z0nOA1yLTBsfcuMochfIkgDzQ8J7aOVFlBXjQBGYNZ06A3HVPZa6ezoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538153; c=relaxed/simple;
	bh=bvDayo4W7Ir1V06YiXtUNvxaBB7oTUm5Mt6/eLf+GYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uq6cuA7VHNQuxx+Zz0IPgADOqSkebZrVB+koO4nPltdshMqqkm5vl3vXk7nNTBbqO0kA4IALQKUVLMevz8Sr/Qh9On1JJuQGCY1CwAtA+s3X5HHI41GamlhZBlx1DMx01KjVBm1VINWEG9vrlo01LsuE20MaZIdQKDY/q8X04mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI1xvKAL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dd14c99c3so983877f8f.3;
        Fri, 14 Feb 2025 05:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739538150; x=1740142950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyKRIHbKEkE1QGgK/gObgAcYMvHFgxUHygHIci6W7t4=;
        b=eI1xvKAL/GWtpIhrDGw6su0VbD/SHtWkVd6wq+xrJjEZjsa8DZpNeDYfhLqI7E75eS
         +CDh2DD+GdkjxicnKAZgGeevCHOIljohAtNq60oTiVz43/QshlhJGQfKflWUsHcNntmD
         dplyLkKPeiG3liKXMLYXTHswyYmQmJYBxYzBeOMQuqS8WiuRgox6AX+JgnwICeE1THe0
         7ema3QwHi7TQ2FJZ2tP4YdS4HtD+WsFKSceJgis1ypEE/3aTnVlSxQU22mhkPdwbaRo5
         E531f+a1sdAOTvdw4/GIUeY48rD43N1dzDrjYAhvC6vtCOgzIzmowjJS4GmlgBJwiHXV
         mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538150; x=1740142950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyKRIHbKEkE1QGgK/gObgAcYMvHFgxUHygHIci6W7t4=;
        b=Nq0AD9ERUodwhSrefxI9/aYCBqJK+jGhDFnHrtAGdIXdR6MM3D8Vk1YSqhiGdXyHoP
         AMaVAunSt1UwQf7x6yIiJTUtCMdKt1UEqT2re0KE95yLIRINmswfysrbVkfrN6L8CcDJ
         k4ZHEsNseEDtXpPkP1XOkU06GJI2uZevzfYXFeepWbHDV5OGis04B7Uv85ci5hV4ezla
         ysLJlTglHzifqXTdgrou0LTrv/YaSUqYktc9eptVLtY4wJMk6oC2og2ZZdYwwbSWQ8hc
         x3xX0TvXbsHHqLDzdYmYP0FCUVRTcIHVY/LUsx+Z/NpM8eIzA9bda/4qOr9m7BfKEYbo
         RfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLQ0iIsSLsklu7ihtJXDkrrWUy/tJ6QX5aOOUUkQX9N0H0MJ4VTcTkysHJ9/LxFUqdmBH49g13Fb3+lO+F1t/d@vger.kernel.org, AJvYcCVWNDZ081YCd4OP3rVvq2LwEigsC1/OXiDnjN2tFtGVCjQjK/QAFmCzwu6ltJaENiHtCM4=@vger.kernel.org, AJvYcCWAdW65HOVhklNF2j4HlanWPYMNeg9E0/u2htRwruD2qz85VTA9MFzF7WSGezkuHm0E58qNov9dJXX/6AMO@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHMinsupI/qfiMPmReZsTmDHpD+8A8mvU+ili4ug2xRxmGely
	oT2shHYyUjqIB8ahC16CMd9pA9NkyrBxK2HHODMmwpyhgEL+yV7n
X-Gm-Gg: ASbGncvK+/zI62r4PxL8oh78+18GLq8jc9mg0Dxn22X5pQh5Wt7pUvPbQ/jhN1U0lJ5
	xW6SquiVBoQ5EVPMikvuT1wa0S6wzIevgItaEqYPvK4Yfhr8yLjGrY2Cg7jqS0irFBflLYwlAz3
	H0tfG7t4/CsMQZOdBlD9v7Z2gzEPuoGuGmb1JQJjYD2NBdgEXK/9NEgMafHZ9iO3n4QxQPHao/s
	ICS8iggXyVwsv4SuYS0yUYi6kPmvMqUdQ1m7soEi0d2FYfZ448hez3N+GM8YfWyW2cyJVIKw9Pm
	iAuBQ2hob6CGT70G
X-Google-Smtp-Source: AGHT+IHouc+Aki+tl4UdBdywYmjxaxz/I3TwzUU+dPQ1APxG+jIS4U0D3BOFN/hb0yYCUgHMpoANuA==
X-Received: by 2002:a05:6000:1863:b0:38b:d9a3:6cff with SMTP id ffacd0b85a97d-38dea26e512mr14714634f8f.16.1739538149352;
        Fri, 14 Feb 2025 05:02:29 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4396b0aa4e9sm6809285e9.16.2025.02.14.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:02:29 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "Unabled" -> "Unable"
Date: Fri, 14 Feb 2025 13:02:01 +0000
Message-ID: <20250214130201.15903-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a TEST_FAIL message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b1c3c7260902..279ad8946040 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2283,7 +2283,7 @@ void kvm_get_stat(struct kvm_binary_stats *stats, const char *name,
 		return;
 	}
 
-	TEST_FAIL("Unabled to find stat '%s'", name);
+	TEST_FAIL("Unable to find stat '%s'", name);
 }
 
 __weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
-- 
2.47.2


