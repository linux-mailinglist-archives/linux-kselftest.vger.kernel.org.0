Return-Path: <linux-kselftest+bounces-32572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F0AAE097
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74894C61E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E2288CA3;
	Wed,  7 May 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTzKtAQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF9288C91;
	Wed,  7 May 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623960; cv=none; b=hFBrhi7M73aKo0qkwM22tSpNgzAFhN8ZQSzr71prlxsDX8FsPXxIZTMUNkbfv4d4YPRZQTu+YnbP1JbaTwkY6Z8BezpkV8djPUF4Np6tZYG22kx97JfP4EFRXQVhfw5mHTpa4U42KW8tJKifFmGZzm5eVvJwumXqwfCY4WtHitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623960; c=relaxed/simple;
	bh=hQhbhaO8Zx7OtDKFPagfIJ00HDVkDQ+YZmYffxnythM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpDgHfH4wxW24k9S//390Bbg4Np4GX9jIYIkvXtHYCxbVNEeVyNiVyi8DjCvhVzEK9D0UOM/NHv1ACB32nDtzCObmVFEPGiu9Nxwpvsen6/Rl8whosmGFYYFJuNoBb3ltQtjodKrYUbJyZ/9pMS8kk5gMLUlaoWEvxfd8I0RWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTzKtAQT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e661313a3so6143425ad.3;
        Wed, 07 May 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623956; x=1747228756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=KTzKtAQThvU6pwmu4FKFuMg0mar6tC4ZcRuunrTm2P6yS9spQsuEix3Er/EyxsAx03
         Vp9hnrDPhjUv25Zo+3fEI1mem/RjxpxMa0dRB21+ThlD+yLIOmkty8pBMgf1ykgqcmVl
         gVzOYxPgSLmj0Bfy12sPCuUHjmYQ1zY6GnCTbp70V6xYKwXHPChN0ElorvJdrbYrWhGf
         XmDt5J+Lw4aGtGj3pKSh9COWb7011kZlROYqxq/dAxS4Mr5jgrgKDi1VRqBhZtIbgXKw
         ZhI/2N9HzCOaOrFkhF7uo0BLIBYM2cEpm1rpfvPv1vi98f4Vc1K1aDem35YvyilSU7vR
         VD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623956; x=1747228756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=ZVrvLrjuNiSsmFlT7Muvj8I13QS80nurOfdywkbyhPdh/JJDGxywrOa728dQ1a/TRO
         TyPtVwr6nWaMM5/nBADHfrnv2/smRguTGN1qtP+XbS+Ala1RdhMqLk9Op/kJAOCpucko
         pZ63fz7Onc5Pi3QMJkvbm0J5EWFFdubbWSctfkDCgNDs0S9/zCntGB+M4+woyu+IKUK2
         QjXyHVi10aleilV1bK3+BYhkmCYMSYmPR2/mjVkPjqTb1RCvHZcKzo5R4iwi7PGPezCJ
         ICeI2wtFSdvZwBr0xNbC80iKlCdsUy2fwH5mhX0kpu7Zo7bu2SbFsKVPmdXlUZxw5ILV
         GxMA==
X-Forwarded-Encrypted: i=1; AJvYcCVlj9//u4naBKnCmsTaEDCxPHEqHZqGK2or+Ak9MP/Bfp27cEabZC6iesWSHcZ5HXCDyMuqT4aZ7Niwc0LlXcFx@vger.kernel.org, AJvYcCWvN7WGrIrQND0Se7ppr/oTTyV6H3+KazVhmDU26/iUI/C20HT6GMgCVJ3/4YyY53w1VRsGXSxt4atTPADZ2oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2o/g9xlcbvSxjrn6/t5Mo4WrJrjSvvlgQhkVvPCrVUM5NhErS
	F+AzMjJ99SH4Piv15fR3TyU2XrsvqatfZkQ/pl5CIgrCfmC7Y/nViqHl94X9
X-Gm-Gg: ASbGncsT953FnoN4OAw6O1s0MF6Fx085U8HAHcOXEpEMqnsaGIq35QJnc1aBpoVoMMS
	4oGl3mhnWtZ4nysY+1wZL2xULmn2GR4ZGUMQWmfst/d9fFuTQqBdT3qBlD3pVmWJZaSzALxGhpz
	NGBoQCNJPZyyipMdC8GHLeeDRENlKL1Qvk6Hjbo0rCXzOUruFWZ2cyS+XLD37AIk+X/N5Ua4mkc
	6L4NQmA42yvFBB6INBgbhZEbbUWZVShUjM6Evspf8byLWuc21flLZoVs3HNxctJP4s3ERgjU1We
	G+1oqlha3YAk4XtggP5KS4IkbV7QitwbU72W0OEuw8FLKXuHmknqf+K0PL38Ru1/vrKsgG0=
X-Google-Smtp-Source: AGHT+IEmSA/X/ltq+9bYqidRcUx+l1yCtCkXp79+kBle4WIzaMF62NW5u2ryRDoKpCzRQfwyr1fwDw==
X-Received: by 2002:a17:902:e950:b0:224:194c:694c with SMTP id d9443c01a7336-22e5ea88891mr49968655ad.28.1746623956382;
        Wed, 07 May 2025 06:19:16 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:15 -0700 (PDT)
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
Subject: [PATCH net-next 1/6] selftests: net: disable rp_filter after namespace initialization
Date: Wed,  7 May 2025 13:18:51 +0000
Message-ID: <20250507131856.78393-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions enable rp_filter globally by default. To ensure consistent
behavior across environments, we explicitly disable it in several test cases.

This patch moves the rp_filter disabling logic to immediately after the
network namespace is initialized. With this change, individual test cases
with creating namespace via setup_ns no longer need to disable rp_filter
again.

This helps avoid redundancy and ensures test consistency.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 7e1e56318625..7962da06f816 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -217,6 +217,8 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "${!ns_name}" link set lo up
+		ip netns exec "${!ns_name}" sysctl -wq net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${!ns_name}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 		ns_list+=("${!ns_name}")
 	done
 	NS_LIST+=("${ns_list[@]}")
-- 
2.46.0


