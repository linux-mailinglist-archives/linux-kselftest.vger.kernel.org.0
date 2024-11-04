Return-Path: <linux-kselftest+bounces-21400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62E9BBD17
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEB81C224B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6577D1D1E77;
	Mon,  4 Nov 2024 18:14:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9931D12E6;
	Mon,  4 Nov 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744083; cv=none; b=n0njrZrmKFHUeQSM9Q/y48r4Zws+hsPdh7MvRr80JOWPTnPNEYwREnyN+WQ4EqK89V44NGGmQha0g+Y9m4Zn4P2sq9uTCMrsoMWucnr7ZN9cTFzrKYdI6okQ8uL0ksUeNe6DdkqZptcgiZuxnK4RMqNxUZClEvtrr1WNXjjKUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744083; c=relaxed/simple;
	bh=t4oQZFMur9cxBRlJZS0+COIzhW6jkWYV4QpeYt2kroU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwvzS5O5NJ15RFXtmWKj04zEuVv2cadXHXB7izVl3d6snY7YiqarydjFfaGt7sZphOlekhMwlSzteSQz/vCB3XE2lZAAy26VuXGZzL/ICSO5fueQv6v6PFzY3tTnpbrDAIDP3akWDOpZOgJtbCpsoJcbl2g6ByV8hdBdbam3Xig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5a62031aso3675308b3a.1;
        Mon, 04 Nov 2024 10:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744081; x=1731348881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ1Tvv0gMz3ty3u2/2A4hNdfs43uiaMnj09QJfrx3rc=;
        b=Xqp1rY7CxdZSOtbupRsuoeiIgvnNTMIwy5HDU//ByqSqx5vXKyEh8LYRtzS8EMjACp
         QSYFMr25e1FCG2FGDN+scq1voTG5eX/iKcHrtmR9G0dvAhNIlfVGtnbEq1BqDXp0tMuh
         dQgIvzMbbC2lfUiOjH8n2BeMMaIJB7fTfh+td4gnl/sLFBjIgCtnsd098k9xOeg/leXM
         KCaHaKgu2BFpLWVQIWx9W0ITbRF4qHguGeMgacs+041qz1m0Ba96uFaT95HNbJyaXKSa
         6v/yWgI9kLVxYw+RMozNAGXGl4a0wZ8gA9iQV7vCKma7umwDO+l8SI7F/Qye09VgWv/W
         Rf9w==
X-Forwarded-Encrypted: i=1; AJvYcCWSxg51pJZgGdXg8qsvsZui1yh2bv72OrKV+GwxyWOf0dIW7lILhmXYIfUfms8wDycAg/BwYbVkjrpskQk=@vger.kernel.org, AJvYcCXOvY+F5yN2S2advxvEupTKqhAHXlpgSFeQgiHXwTtiHXjl7+oAyfTScELX0iCmdMfxmXnehihTmrJUZSoYQN/O@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+yRlm6ofmQhJ0Ar7dcr6JsNz0qh0aTlAVZYnQbiA+mGmQyPd
	37Mk34o5sKZ+gXTz5+/6/iXuGFvUuwWYJQuNde+4UJ6dQ5SPD2/sxwjE
X-Google-Smtp-Source: AGHT+IF/BD2lQwztMAI1ojDceoAS38rYjiPu8o9NbmTwOVFc4a3eYhaRCVDtH5kTKDANMtgJuJRNgQ==
X-Received: by 2002:a05:6a21:6da0:b0:1db:eb2f:e281 with SMTP id adf61e73a8af0-1dbeb2fe2aamr2308494637.26.1730744080885;
        Mon, 04 Nov 2024 10:14:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72119bca1ccsm3616749b3a.128.2024.11.04.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:40 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v7 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Mon,  4 Nov 2024 10:14:25 -0800
Message-ID: <20241104181430.228682-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple off/on might be not enough to do it on all NICs.
Add a bunch of shell crap to explicitly remove the rules.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index c4897b2bdc7c..8062d26fbce0 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -217,13 +217,18 @@ void validate_buffer(void *line, size_t size)
 
 static int reset_flow_steering(void)
 {
-	int ret = 0;
-
-	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	if (ret)
-		return ret;
-
-	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	/* Depending on the NIC, toggling ntuple off and on might not
+	 * be allowed. Additionally, attempting to delete existing filters
+	 * will fail if no filters are present. Therefore, do not enforce
+	 * the exit status.
+	 */
+
+	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command(
+		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		ifname, ifname);
+	return 0;
 }
 
 static int configure_headersplit(bool on)
-- 
2.47.0


