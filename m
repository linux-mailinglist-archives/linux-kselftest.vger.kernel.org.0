Return-Path: <linux-kselftest+bounces-32651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A73AAF57E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D468173A73
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3E2288F4;
	Thu,  8 May 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuJPEa/p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BC224B01;
	Thu,  8 May 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692412; cv=none; b=IuH9+6YF3SmfPl61Ab/LUxHLYGR79URAPvcm74bGuDOjnW8fBWvd9a1JgN8iovTo7shzrjtg3+Bwcd1OogyVxnQEqD9CIsJFK+ba5GuYzvXYkwUfyS5ankUj9MIlHQZELFFT0XwlwfOKtqY9OZgPEVykl4Yq1I//JmRKFK4CatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692412; c=relaxed/simple;
	bh=nfnnrkbD9lHq5M4BurhUV9GrLo0bCdesTsL9mlx9IRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7mFbAevGtxawlbJU2WmOpjqt+5aeInIdeaSh8tkrGieRB1Y73L9XlyfTGP0BT+kRiXPgbeHlgeSuwl3vkm9/0qoIqD9/ABd5qWNVJHoz/xIi1+IPUbLx+3xT3Z194ZS+y5yU+qxrvZg7XY4jjLqOolb2NHe1WQDYMGN9SUBmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuJPEa/p; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c062b1f5so808648b3a.0;
        Thu, 08 May 2025 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692410; x=1747297210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF/sCoumpbrrcZbQjjir0fJBDlQMYwoeVJwZhV5rgpk=;
        b=OuJPEa/par+qEgTVD4srDs99GwkKGLYrBAqd8GhX5x4RRAhLvC1o7i0AbSLtNEWmYi
         5IF5lwaTWQB5jqyaBtFhy79VNGbCvOGDSFQZSzJedc2Tnw3+UuJBMs0lMUtI/qE+GxxT
         yp3smE0buA8E5mLJZPpUEduWo9nL0PnyY1I//RC7rmI7X+o1VuqeNa9yQ9LxNeA1HJPQ
         haROEtqRS48MOi4VQRE3hOLKb8KLFoIhK0DPwDuIO1SYzo/dhk7w7AlwG5mVCDNT1uFL
         ubUWLxTNV+RNg5QLevPGTQVR/88rxf8ECaLiBcMHZnURw6YaxtW9IleEXLc4/NiKEaXT
         ilrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692410; x=1747297210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF/sCoumpbrrcZbQjjir0fJBDlQMYwoeVJwZhV5rgpk=;
        b=sktUuheLrgw0Lb9Y4u6AWZkC74doU4SQ/eoSFezLsgCVIwmy+xECQZ+gJ2MPYTYy4/
         sn/GEsGKQyrO9qxTPBQcXcH12j9MOqtenNwEX1qseJhHP3KbKCaFEGtn9pc5c9FsZOpX
         neJoetsHaftVAqelT6LsfDNh34ljI2zJ06Qvh2uCqGBizNmfVC6gStLnh545HwE8UokA
         1NM8FVngR4Lpee3Z+VBHJkkJcUVuyRJRrLuyJ65is1YHSjMz1l4gyAzYEcc4JdPyYQTg
         P6I4F6YNSDUvp54AF918Yqz3DRNETjWCixDhtnsyvAs7GaIzxnkwneuSAin07jNLzjYU
         WTBA==
X-Forwarded-Encrypted: i=1; AJvYcCVSZGWY62BtTjJpArZ6mdQ7t89bT/f+vmeJFTANgRcFq/BF2K2DbCKiVBz93VIGiDkKjjrisCzpvEcFF2DvWl7C@vger.kernel.org, AJvYcCWJychrfCAqOjkvVl9R0E1QhDnBUDaM/LTqFgBcwzFTm2oO0XnvkQC9/HdG0pw9Zcm81uCSHtsciLnLOp1tMWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0/OpbxsLvwDVWymcvGmZ7jHBUVr86AfVlvjVtCMqGyQedDi7
	f4DXYKooFZ1TQo7ZiF9LEqlRVnWEa8u+HAVpjU524TE/+RDdq2VIZi6kLlDvbT0=
X-Gm-Gg: ASbGnctwkfo5ckvauf0So1Z9fj4SPDCUEslm/AJzoiOK82Td7TN66fJGSNSuanaHnNT
	lfEbPeynhfxZw/GH8FIR7xfEjUYG2wGKtjY5BiVe5ySwbKj9/fvUYUFwFp+RMUDCNDTapwnrcXf
	NEHu7bv9hDKX+kTbFsmDnV82Fj8fNR5ATfpkeNGJTiXgbKrFj31t04TPfjcp1oSUg31qTVOHyGk
	GaKUkknP6nMKdLrP7KKfznUy8aK1NHMW1yccg3k0OkiZNdJ8hJF4i0cq6u74/1aW17lOgtq1Bz4
	2trJTS/dLci0FjCrnwoCdvCRyBSgjcDzZohZrZELOfj4NyqOjMAtP0SQnqw3
X-Google-Smtp-Source: AGHT+IHz2qi+IhB5F80jpVbH8rKZ54H2Ipi3hZso3Ha/e4qS4CiCojKLLFlE/kbvGrTd/XTIEbRrAA==
X-Received: by 2002:a05:6a21:393:b0:1f5:6e00:14db with SMTP id adf61e73a8af0-2159af4bf72mr3663176637.14.1746692410384;
        Thu, 08 May 2025 01:20:10 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:20:09 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 6/6] selftests: mptcp: remove rp_filter configuration
Date: Thu,  8 May 2025 08:19:10 +0000
Message-ID: <20250508081910.84216-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the rp_filter configuration from MPTCP tests, as it is now handled
by setup_ns.

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 99c87cd6e255..55212188871e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -479,8 +479,6 @@ mptcp_lib_ns_init() {
 	local netns
 	for netns in "${@}"; do
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
-- 
2.46.0


