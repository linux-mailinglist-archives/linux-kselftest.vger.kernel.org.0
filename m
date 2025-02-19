Return-Path: <linux-kselftest+bounces-27011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0BA3C8F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 20:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8496D1887FF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9322AE7B;
	Wed, 19 Feb 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpIRhM1M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C0214A6E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993869; cv=none; b=Uo+J+YE5JOm6TJrN+PZcrNqDG5n1mtij9kSRC/1UcUuWoBr8nFebSlwXbmVSq/3rOly8fYhs/875LpnNnzQI4t7ztGaxa2ezWiTQE6Gn2vpGpI+MowhnTmZxxTZye2kKfHkxP9VQjJZKEd60nSURPwF49pNh77tvuDzgRGLKbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993869; c=relaxed/simple;
	bh=7oHGDbyl6Dcne/MfjHorGpTP8FaYWX/p4gX72iBwpNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SGQwbO1lVGyjgQMm+goFy6CZglLTzeXwpdNUo9QcXQyyo59dpMPNbmzyrWsP938SStcJ2MN+aGVUG1/hov7lBSlu9NjVmod4e6IVNgr4b7pZD+Ja5bdWh47+VqPwCVRUbYdvJtkHcuJyxyP3Cy4zL3R2KvVsuRAP5uBt4qnmvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpIRhM1M; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso124275a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993866; x=1740598666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3M+NteL0NuFSIEdJ9tl3BPKdfOAXHAX8E50cvBMx5DQ=;
        b=jpIRhM1MoeUFSvaTci4xJYpUrUAlBdomNLOFLiRraF+uaFwMrEtXEdV2A72WGg/Ezv
         GD+0INza4oym54Of2Ka/lmWiu79nEHFb6xhez54f/FFfiPOcH0VqR0oU6leZ4z4Z/0NS
         ecqV2C4xwPfJtHXq9Sc14GYN64Gw6un/S5F4GMmvSY2bDRSL3lLc0jNM/+hRXGhKy3gC
         uGK+58/NFBT0sL5mQdCm5HyVjoV6gmGCP6QPefQiG8T3G5YN6Z3GoG1DMADVh/PTm9w1
         aNGiFw1SsFIhymFvoJqQaw0nplYgTsj7YSOqO4kKiQ2+Ogo+u/72dx+8+LV5x1aLdkdP
         X5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993866; x=1740598666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3M+NteL0NuFSIEdJ9tl3BPKdfOAXHAX8E50cvBMx5DQ=;
        b=i64T0OApwW4pqOzsY/vrAkq0c7bGHAxd+GXYX5D2p2x5mwRQen9PMcK2Caa6kBaJiJ
         iSdFIYDHFdm2E7/c4puM6ZSJ4Cx+9wxW4sDyd82nb7NBpr47MPkuBft6w2PS4Kt/yDk6
         +JgwSZmNmBIhBH7ZWcajiCIqBOXDEGPwDEBulKJ4NSVI99tBihKiv9IXZMNjfWAEe4tv
         EKPpr+GfFY0mmq7tEZryTzQcwvPtx+z+oP48Mb1iqGYX3cJ2SEMip67d63kYG0mSdM6H
         ISUt6dW6uXGWRnNfZ2Vb/uT7WQ6WBYilOwGrh3uAOzqCcVhNaDKTMN0y3X/YHT8Kepy6
         m5YQ==
X-Gm-Message-State: AOJu0YzNkY3u3bdhKQvnINNBoybvp7CPWl1SJdu08UkEWK8NEXoe8j0W
	TqFY6gUEprt6GUT5/Xp2h+4uaJIPSUOHT9RrBTyZ+WYIgYLdNQEe6TIuVJSb
X-Gm-Gg: ASbGnctr/FGRYWUCRi12WwdwN2u40PGxa1Q7XleydhViuji5MiHl+kzfpemx9AAu7ZG
	7YfT3ikrvIDV2azZEJQmaz6qR/Gbf/QBnmd7HUSeb9s80hAi3mTFXnJ5yBGQdUNVJiBo7Hv76Pz
	CpJHG3bOXLATWbv1NSPO8D0Iw90ZPUfXBENyiW7My/0kabjEB0JRym+/+MTo5nvNI0/AX7bYDp+
	Ex33AYi8a0tB5/rSzIZ5dHcqAoofi8czDGO/q/9vMLVwQaIrfJp4oFJYM7yHt5AXFJblGrvM1u3
	fqJDygmZKE7VYdWvRzfx8BauCuiH4A==
X-Google-Smtp-Source: AGHT+IErH0JAkyub+sl5wsFC6El5Q7pr6f7XUo31hsy5JQiPIsZtoiyPZ8iQ2QZrfNr6atRPYUofNw==
X-Received: by 2002:a05:6402:510f:b0:5dc:c9ce:b01b with SMTP id 4fb4d7f45d1cf-5e089516781mr4518988a12.8.1739993865748;
        Wed, 19 Feb 2025 11:37:45 -0800 (PST)
Received: from baris-HP-ZBook-15-G3.. ([78.170.145.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4483sm10971527a12.25.2025.02.19.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:37:45 -0800 (PST)
From: goralbaris <goralbaris@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	goralbaris <goralbaris@gmail.com>
Subject: [PATCH] spelling mistake
Date: Wed, 19 Feb 2025 22:37:41 +0300
Message-Id: <20250219193741.16620-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: goralbaris <goralbaris@gmail.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 068e9c69710d..db442bf3b8d3 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -457,7 +457,7 @@ static void guest_test_msrs_access(void)
 			msr->fault_expected = true;
 			break;
 		case 45:
-			/* MSR is vailable when CPUID feature bit is set */
+			/* MSR is available when CPUID feature bit is set */
 			if (!has_invtsc)
 				goto next_stage;
 			vcpu_set_cpuid_feature(vcpu, HV_ACCESS_TSC_INVARIANT);
-- 
2.34.1


