Return-Path: <linux-kselftest+bounces-46696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51CC92D87
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 18:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15774E276E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C912D6E52;
	Fri, 28 Nov 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKXKYfTL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDD2C030E
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352342; cv=none; b=pFRcP7hCzb1/WhAgT0Iy8cBlv2tvjo9QSAtmVlbDtMecNbrt2D4uQkjFz2QIxyZoeOnvDa7TECPhMu20dfkOgleWKBKRBFPn0SLWnueanjqFFdZ2kxKjbon1typbPTAW2eshDckwOwubdE5tuCZ30DHhCYBMzWmEWqh+r/Nb/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352342; c=relaxed/simple;
	bh=GkebHRZ4hW0W7hKq0Uj4FDaIkukgfjcfiLZIR/1thWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OMYb26iKJ48PYn8jO0lnvLas81QpUIqcyxYlt6v+HJQ1ISSsCAJtX58tJRaT5ZOol/lAcO4JfMgsUPuOBrKZvJ6AKT3pSUPJ/+fSik2+i0Dlnn+FUTDemt94HB2s5dM14YA4RAXL5javATpoDSIE7CxNBLgaKuGJB39yidX//jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKXKYfTL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47755de027eso13868745e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764352339; x=1764957139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAfyF823/XbGGGKg2P6nxUijTsKpVqaSaPrfyNHwf9s=;
        b=BKXKYfTLWed173LFLR9je6NtxzsImQGF4s9UD0lAxP50BiSrS/pAFPpoFakpJy2Nc6
         cMHxJZwD/MuBGz4awUmZLNZOSZ8+6d5jymZBV1WPpQpaHW4j3s7DYMFpjmIi/UKicP5V
         YP107sQNpznju3d4xVo/kmrr+HZOsm9Q9LcRDMEJck9/PDy5ch01nSS8GCnrECwpigtf
         lElzEcQXctdaxFaOq8GKSLQskgTxtRDE+2Lbu8fmBKy+0rP5Gv1d36V95SiH1kADJ/st
         bLuLWrpIcwwM3wBZxTRzrRFOoIo00DlaqY9DP0edUD8zNRl6sePhFajKRi/zg21pONtm
         /kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764352339; x=1764957139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAfyF823/XbGGGKg2P6nxUijTsKpVqaSaPrfyNHwf9s=;
        b=pU6d4UcnPSnu6cRtuhQxpN8lckH8T+HLlGpyn2ZckdG5bGZUzJd0Fr5CTNT0Eslu6+
         8GfyxiLIknKHd2hFtRuK2FibnXzddeQGfXP8wjRlHZdKq65q7QG4ppTdC6JAECBgnFvD
         IeZPc/raG5cfacyYsEe5blrZ6eX81/Ay9ccZgbl3WWqKGuoQp5iH0PMKaJxsS+nV0GWW
         ics//h+3FYNUZPTNewR7GnKnn+OkLBKpPDjv0EryQgw96CAry72q1/XdtLOk2sDGp592
         TrzKbbgfdiSYHCvFaz7nazCFToiZoLajGytQD8DM0UgjU2xLSc56KpLOwa4LvmgYdl5I
         C42g==
X-Forwarded-Encrypted: i=1; AJvYcCX17wGqYzygtjxG/ScSoTevjvsAVyTLzAC0EBOVek/LPcaeKF35r+0iT9hG/SVASbpoEETMMoABdT3ObTu5OS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DmKuT6jYAil7Zy1kbKi2QrcGYpA4OzsaH7zl229Xk5rjczDj
	BV2OhItR2TuaomDvDOp41jpAbdajzAP7aMaV0/qvstwv/kpriahgiEa7
X-Gm-Gg: ASbGncue4XCr+qhAk2AmFmV0m/CIgkXDraiKHSVlTGtM3vt7gcYxq7LAmWjms4M6OzC
	D2fTsU8FIP5PaNxqEHtpxBLFD3MF3fWAg2ZxtXLvBK3TJW3a6YgGmjoEKQtXkmnNzD+y6SOLLXx
	qHVouOlJTJg+TYNL8a5H8djVNmBS2fumG3QEmcW8O5B2m7XQoAMN+PUlMBxmwZwPaa7iIwg0fPK
	qYbQA62xT/e4ogQaz5OrNRHjX5P2FjzkQMxLr+JidonlbWyRUaA3ABYotumRHaqWn8ip/Y9HfXF
	1oW1iijZyKHVNnBVNResAFXaoxA9hgyHknYOVAcQqKkLbJXA5UuQOO0sLCoyM19pkHUWIywyo0s
	ZbHTPGESa8sAJKGhXE7nj0HAGRIuMLKq7nH1j1C41NfHQvec4Iu5WDwcGtU9mhSRx1/Ft6AUMW/
	pgBGCYeIELtg==
X-Google-Smtp-Source: AGHT+IFNrav6emQa7eo4LXuc9QahSL2PszCgaxJFgT0UH28eKJZFTLEzFFZCoVSa6zVdulqINe9u9g==
X-Received: by 2002:a05:600c:4e8c:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47904af05b5mr178200545e9.15.1764352338440;
        Fri, 28 Nov 2025 09:52:18 -0800 (PST)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47913870b38sm33438875e9.15.2025.11.28.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:52:18 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: arm64: Fix spelling mistake "Unexpeced" -> "Unexpected"
Date: Fri, 28 Nov 2025 17:51:24 +0000
Message-ID: <20251128175124.319094-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 tools/testing/selftests/kvm/arm64/at.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/at.c b/tools/testing/selftests/kvm/arm64/at.c
index acecb6ab5071..c8ee6f520734 100644
--- a/tools/testing/selftests/kvm/arm64/at.c
+++ b/tools/testing/selftests/kvm/arm64/at.c
@@ -137,7 +137,7 @@ static void run_test(struct kvm_vcpu *vcpu)
 			REPORT_GUEST_ASSERT(uc);
 			return;
 		default:
-			TEST_FAIL("Unexpeced ucall: %lu", uc.cmd);
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
 		}
 	}
 }
-- 
2.51.0


