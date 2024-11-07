Return-Path: <linux-kselftest+bounces-21634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B09C0D8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C681F2466D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323121892C;
	Thu,  7 Nov 2024 18:12:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6B218338;
	Thu,  7 Nov 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003144; cv=none; b=UjUlhEy+oqEtv/xSvZ8TjvFY8VMibsOajKoeh7wwXrykqyNQ73aNBjmr3/k4XEKF8km+rcvuegyJD9tbbCD1zdltJV8J5e+qROGoKHtVUddvtj3Up91mCBwh+ndvlWQJOAssFmKaDDrovuBLoLhdbuxHZD8Y51RarH+T/xaJPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003144; c=relaxed/simple;
	bh=9qqAnoRvNDzm2DIP6UmeNvVQpyt/Q98tePSZZ6r1O4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp/ZKLHzoOmpynLXMbACjf35FpN6USIDHhHRs2gXL9gl9bw51eRMSJj+da4tUmY7eJ7qdR1Uo99ride1bRIne9G4Nt3Vh3lun02x4MQqD6vCRQnL5JKaUpdik8HysIoH7zJ64EsasW0czUdwlf00/6L4l2WlLUuRABgZgQdMDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ee386ce3dfso1880333a12.1;
        Thu, 07 Nov 2024 10:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003142; x=1731607942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDZD8Z6wjohcMulNg2Bu3w2bLGAhxse6AUuUhWisEno=;
        b=TDkXXPtoP2Ny6ZCuqxsCI/NH/ksA1NtiTHnLvwIL/MvsTZ7A4YbeSSezEqrmOrwah0
         N+gljXK3H6TzpkLmC1rIrwVXiMSAkP3+RDAmS5kgVdGw/UM2FQnSCFeKS0qYzplLCh6y
         1UZ9nZ9kkDPg/T61MtFwFhpEeO04MJdx98WRgnXOSzeASWkS+FkSneSh5oPsDDm5PZxF
         URymZCVuazQkaSvErBqLng+uCvnM/D310ari/qMXc/cMLvitDwVLpnKfvnJWGOoQ3W2Q
         YEhE9NKFcZap4S6HkksU7J1Ul/O4YK6xZbOH/iKoddjTo6efIff4licTihTeWHHHXQpQ
         fmvg==
X-Forwarded-Encrypted: i=1; AJvYcCWP5JbFczRYTKBClGbIDBXdbc9o4fMpmxihztUhHX+w7os0lPCsSXulULnIIisI+GcO3J0t12pFYKb7O5lwjAvM@vger.kernel.org, AJvYcCX09l0kaweDeq7uqaO4QCM5JkfXoOtqGLpPqqNMxt1B2R3hhAmYaAb4kWY6iy/sEiEGqg5jv1KuIzuAW7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCUC+kuSdDHl3vC5btvgjsr0oOcqFZ7wk2q2liynbMXx0J19U
	aR6tVqruuBMrmpx2NiuXV1ajQSOhmGAFXoIBN7q5y5jdDPGZbjx0ksN+
X-Google-Smtp-Source: AGHT+IH/ZB7QYbw7ZT12XZgjggR2xsVIUCn1idVt2hn4syh/aOYp/QYhzWesS9VEj2B0MiQx7tIp9A==
X-Received: by 2002:a17:902:c411:b0:20b:c043:3873 with SMTP id d9443c01a7336-211821ca239mr6906005ad.21.1731003141593;
        Thu, 07 Nov 2024 10:12:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e418d6sm15274015ad.142.2024.11.07.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:21 -0800 (PST)
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
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Thu,  7 Nov 2024 10:12:06 -0800
Message-ID: <20241107181211.3934153-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
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
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 645ef0bb63ec..ad6de8e0e97b 100644
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


