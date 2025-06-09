Return-Path: <linux-kselftest+bounces-34456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98039AD1AE5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB38F3A4276
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1CB207A08;
	Mon,  9 Jun 2025 09:46:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA843ABC;
	Mon,  9 Jun 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462401; cv=none; b=RKWuKial/4OAvpVWEGG042Sai4oIAYyzZHF+RD3G1B2PwIyXWYqyczJdgcBNDkX71xUvRr1wulKhMaGbFqpmkT2KrVGoXN6PJXfTh+K8HtPgXaW3xUL41xyykVx88vzpl+lTehWjXdIAXdCdEZnIwOC2/1VlGi2nUAOE9EAXYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462401; c=relaxed/simple;
	bh=S0zLAeHsvrQely1Eg98rRJ60Qe7vUeRLcvUYKnD+2dY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZljJu1Gm8/mr8WEyAF5xxt9uCHWwdFjPnDOnPcy5y/h1/dhE9cJhZatzz7d43/RNV5CvnHsS8ra0FQIf05pDbgMmSvQNB/2ytDOQAxzAM11g6IIA5S75QXvYebIK7q8DYQlWnZs4ki8MvV3aD6nITtiblqQz7baKw70rf80OO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so4930248a12.1;
        Mon, 09 Jun 2025 02:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462394; x=1750067194;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTWm875t3M6R+O/wif88xNULhJplDQ78uU2/bqyGyzg=;
        b=PU1DA+h2RPWYPU+ciOqkb8tERCGjDDmzeVtvOWFPnZi1r0WX0a8vitr7QSLNVXue6f
         SZEZEnm/1AmTe8cvfXtP+9G6rjM56S8vtMjh/fZhTAOGWljUx7Ccz0hEq0MngzN6eeVV
         x/eLRqe2xj/ol5RJe1oRhOsBMN2YDTvUYXriOowRWvwAV+m0Em+7Bs0IhjmpjCWAKGWM
         +sIO3EmMpFQsBC78Z31t3WJG1N8jFMuDfPauzKW3INnf8c5mwqzWPJFBK3NpRJ+oOyBT
         HHxNCtX9df6l8UfaVf3jI8sxRKLlhxmTH4/2yS8amsaR6d+dIhFHFo6IHAd/fsbChor0
         briw==
X-Forwarded-Encrypted: i=1; AJvYcCWUTaohM41bjZZAJtnctklGTxkawtp63MqHbdcJRov/v6YWkC/j8I5De8u3ZyEvHM40/NSgI4Jc0jMpwvQ=@vger.kernel.org, AJvYcCX4WjwsdCGq2+D9KMlE55X3VepZq9q8aMQ6xOUnmSM+Nee2CQt6/zm4ijIKQkEcZ1eK4Z65Cp65Dw7ik7+GBNXD@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlL4PvW2Me22VzbP7MDmDURg2YxTN/Mvx+bLkaCEQ36ZiKxT9
	GZDj51qVaL8Qb4O9OhiCMgIKL2OOe426TNbXQxBV0wFUQVvrmCJXyk3e5+tiBw==
X-Gm-Gg: ASbGnctxBJ5888DMdxnAOvNvwMMdc/dTg6le7Gbng7VABGLi/5H7Hnx5WPMEGgttT1J
	rrTMwBUu6X7Cj2PwP+fcEGXLLVqIEzmKpNQJNB0BwZL2G6pkExy7jjP+JPXZMxxBDRsqjlpfPf9
	pqwwH6tBRodoRR9NhBEtOyDz6IkPzfLufi5ia4+f/rRgv9dkvDeMFlSxxXQpbCgs+Fi5otnRQcF
	wvtg2olDRCeMAmPdNWUzQBc2MWb795pi5O2grptSKO/pbJpSfk/1RbdDGIGL3F+kM0r8NLDx5Ut
	FuUi6i9hapfOlL/xQGsO/o1NGAk8szFT5lQyv55vrC9WIA9RDsqG7BaE9hxRJQY=
X-Google-Smtp-Source: AGHT+IE77dDQ9ytDhfYQaoseol1SrMwVYetw2MHEsjZHaMq/3LNPtCCtli11UGUK9q7VGMW8OzpZbA==
X-Received: by 2002:a05:6402:34cd:b0:602:427c:452b with SMTP id 4fb4d7f45d1cf-60772a65fc3mr11750323a12.3.1749462394257;
        Mon, 09 Jun 2025 02:46:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783de35bsm4427006a12.67.2025.06.09.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:46:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/4] netconsole: Optimize console registration
 and improve testing
Date: Mon, 09 Jun 2025 02:46:25 -0700
Message-Id: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKtRmgC/23NQQqDMBCF4auEWZuSjBoTV71HKUXNqNkkJQliE
 e9eyKYIXT++/x2QKDpK0LMDIm0uueChZ3XFYFoHvxB3FnoGKLAVLWruKU/BpxftmbcdGo1KmpE
 GqBi8I81uL7UHeMrc057hWTFYXcohfsrNJsv+t7hJLrkycyepEQ0Jcbc0usHfQlxKaMMfVgKvG
 LngNGttjTE1KnvB53l+Afgh7inuAAAA
X-Change-ID: 20250528-netcons_ext-572982619bea
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=leitao@debian.org;
 h=from:subject:message-id; bh=S0zLAeHsvrQely1Eg98rRJ60Qe7vUeRLcvUYKnD+2dY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoRq14GCabtcxMjK2YejjIEZqnAa6sTG7YBYGUf
 EFrBeC3RMyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEateAAKCRA1o5Of/Hh3
 bTf/D/4ubFlvfMPN6Ia+28eIX5AyBNVi9hY32aWLi+kp02fpuzs11y2sd8air9Y82LbgHHHpe2r
 CnqZqKw/XnoHmKulEd3GPE1fdMPC0ZqJrJ39IPV2h3D3yAawR2K6us+nYJUElgKxeg+a9Rjc8ie
 XIyA4eL47RsykFwr5SoXW7CTU/njU+xHdtpECCdugjgrzDMInWStu+vlISMR7GZXq+ZSoQBEt0X
 O/BRYujrr0jtwKqVchpyjFsQlI4ACvncm3CH0BfdDG1cPY2DpTd9xpbNVUW00JGzJPQfuZ2PXS5
 c0by9C6rKEKSngRwvk730dtLWNM301VJvmDNXH+vAyMiY1pM54bbc3CsLobsrbs5hdcFIyz79IQ
 Lc3MMrFHlcbAnqrNHVrdGE+aJPNOWguviBhXMfq0XZTrVGndPdbu9qDKtoZhDUlx/cCWiFYRH5C
 1Q2izO5WPCNEQJQ6S5Z48aQbIR6d+vA4c2bcPggqRBXDfcbvkyaBrXeVjMy1EFQzGY21RMtB/YX
 ZFwQwqlT24bMmA1ZB3s5KdmlBaDZ5tyXo/JPbJV0B1pKZpq2RQZKxg4k6Y2UL922tQrTKYqC/cJ
 JhzznXfCpo4zQIeH1k5V6edd2PAd72XMSRDaEujxovlD706NvRb15KF6hXblGFqAvAySkanwtZo
 EEui9EvMW4XJg1g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

During performance analysis of console subsystem latency, I discovered that
netconsole registers console handlers even when no active targets exist.
These orphaned console handlers are invoked on every printk() call, get
the lock, iterate through empty target lists, and consume CPU cycles
without performing any useful work.

This patch series addresses the inefficiency by:

1. Implementing dynamic console registration/unregistration based on target
   availability, ensuring console handlers are only active when needed
2. Adding automatic cleanup of unused console registrations when targets
   are disabled or removed
3. Extending the selftest suite to cover non-extended console format,
   which was previously untested

The optimization reduces printk() overhead by eliminating unnecessary
function calls and list traversals when netconsole targets are not
configured, improving overall system performance during heavy logging
scenarios.

---
Changes in v3:
- Set CON_ENABLED before re-enabling the console, to fix a selftest that
  was failing, as reported by Jakub on v2.
- Link to v2: https://lore.kernel.org/r/20250602-netcons_ext-v2-0-ef88d999326d@debian.org

Changes in v2:
- Added selftests to test the new mechanism
- Unregister the console if the last target got disabled
- Sending to net-next instead of net (Jakub)
- Link to v1: https://lore.kernel.org/r/20250528-netcons_ext-v1-1-69f71e404e00@debian.org

---
Breno Leitao (4):
      netconsole: Only register console drivers when targets are configured
      netconsole: Add automatic console unregistration on target removal
      selftests: netconsole: Do not exit from inside the validation function
      selftests: netconsole: Add support for basic netconsole target format

 drivers/net/netconsole.c                           | 67 +++++++++++++++++++---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 27 +++++++--
 .../testing/selftests/drivers/net/netcons_basic.sh | 50 ++++++++++------
 3 files changed, 112 insertions(+), 32 deletions(-)
---
base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
change-id: 20250528-netcons_ext-572982619bea

Best regards,
-- 
Breno Leitao <leitao@debian.org>


