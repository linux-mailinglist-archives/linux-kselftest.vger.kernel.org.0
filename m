Return-Path: <linux-kselftest+bounces-41948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC536B8998E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42158522557
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5A30CB48;
	Fri, 19 Sep 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SKM1GNEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8423B62A
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287200; cv=none; b=c6m+9MsZ2JdEqFEp6b/PiSgQGfADRa27EonYzkCrqIFLodfDkE0AbQCNiZKWZr/yrSvjUjX0g/5r15Rv2bLQQQC5M666GR8tYDEbteXkpnhoqocJs6yMQPqdt6Uw1nO0HblVSXSP8VlUm+s0JXHdE38OJEW5SLWRdKTcPIPW4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287200; c=relaxed/simple;
	bh=I1KnJytDI98uzyU9VR0CMYknvs4wi7QfemM11ZziiWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wc3s1Tu9cxcyulqu5gr7aE2wsu6NIdXZTkmIBkJiQ3jky1Q1qRFdEpY0m8FOA0a4jPGqvCPre71shfON3hWoi/Wi/ZZCMrY/X+IkSwDQ8snZSOrJDdKiJEYOtjoXyFgn304odcEGT7v00EhSko8N++XktwbTHbDTwLnA5wi5slA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SKM1GNEb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so1416472b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287198; x=1758891998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=SKM1GNEbSN8kmER8148BHQswjuTRp1VL7EwXAy6KuyRuXuFZNUtKDH2+1F4bEjm2aG
         Cr+KM3nfDR0z+T0sNxlMaoVsnq6KJvvVET/BUdun01b5RG1UFf1jiepkl/WaE3QmIlOT
         gBs9bt/dxwcuJTY24YjeXcDL9NlWHhBmAHZgGv9K5eB/1St0qorKDyua3gfDGk+0RASd
         n+xtg2ZugwVqhlneoCH7VwPl0P/Tked6ExjjaPy7lVl6hABI+f5BI7lb+1x6KgItmSvL
         FLs1T6AbP1jBZ1s04VJMHoT/aYlipTmRtjJJK/rlCjBT5nrhmMGXxDHymRnO/QdboWib
         /z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287198; x=1758891998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrNbcwSvagaIiS5O7F6FLpYe+f/n3DenUIqxElurVQ=;
        b=Wao8dR4Pl3tV8ch/CKfivFXdrqq4aHrfewYSn1lVmf1KU0aApUJsBGcTU0EBZ91N1r
         rGsDHmdBjZZnVMMG29ioWzNSIuFJQ605TmKJzXzp2CYwKKRLVOKa+KDEpFVH/fBd95I0
         cRXkYziGb4iHN6hatHAfwwUDv6fOqzQmT4HKYRxpnRJa8qLyGT3NSYWqwWKRk2B0f4WF
         rrCzeAtIpVGUZDXVLK6I2V8R0OcosP30Vhgdg8p+rvrPXaK6hnXTio3OaZ1rpNw2sN4i
         lEbPxbN0Bo3/RXmruZjpql4++Ks0LSMD3xZHYhCR9//cYP6tbdq263jJeDzW40xe9fEF
         +kpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmQFzdYEFjMfYu0nyMMxXvHHa5jky97tm1wwQ8SF43BHK0QzmanSO4/ZIAPVxH9XtPq8UwEG8Ec/tyGo2/Wrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayEQZvxyjHqc+1aCDacR9o1t8yXwy9nwWB/JOduotAoAdy6e2
	k5p0Jr6+BiPI+/IpVW4wiAV+XtuOrjzlP4hq8Q2sI+wEPmKT1g+BAXp/jVpeMwTMf9g=
X-Gm-Gg: ASbGncsHlyCpUwpOQzJ6z76CSvSdrAhH5qK+OKlhl/NGmAuRH9MpxaoYGf1ftTdP9z6
	RL5+qcaF7lD96gAQ0uV8NO4vznBIsVlP3sVovje60LOoYj36Ipp3ul+XY8LtY1a4fiuLye6fCyG
	Fwf04eHt9IWIVTsu7v8e/umi+8iSRWss3TtbjTidDWNGjw33RGsaLn0aZw+udnYiEl6B7gMVzKR
	nhnh+dYt07aWS2RCUod/GIQDh+lh9muEQHVoGlSYozMiWknAKy9Q7lWIIwSiEPbfr1YXMwQIGve
	YdE2XPYnph5br+GvILJ86GJ8cCPr3kBMV9WQNCuCCTH6+GV48Xd0o50KHvO/ftSPfDfRny1QH1O
	Nci/dECcayregSzJYS2cB54NWSGB7C6fpazH1FiVlZQBnctI=
X-Google-Smtp-Source: AGHT+IGjrAZ4ana6L1lfOx9cqydZTbCutC99XQcIBsreys2Dh65escr5oEpaYr4mKrnWMUardvltDQ==
X-Received: by 2002:a17:903:290:b0:26a:8171:daf7 with SMTP id d9443c01a7336-26a8171dbcamr33445425ad.16.1758287197311;
        Fri, 19 Sep 2025 06:06:37 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:36 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 2/8] mshare: selftests: Adding config fragments
Date: Fri, 19 Sep 2025 21:06:15 +0800
Message-Id: <20250919130620.56518-3-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshare test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mshare/config

diff --git a/tools/testing/selftests/mshare/config b/tools/testing/selftests/mshare/config
new file mode 100644
index 000000000000..16fd9a3ca12a
--- /dev/null
+++ b/tools/testing/selftests/mshare/config
@@ -0,0 +1 @@
+CONFIG_MSHARE=y
-- 
2.20.1


