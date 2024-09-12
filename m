Return-Path: <linux-kselftest+bounces-17774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A7975E30
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E71F23B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36422301;
	Thu, 12 Sep 2024 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR4f1fOt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B817C61;
	Thu, 12 Sep 2024 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102406; cv=none; b=dRNzunGKaQ7pyx1PSUQf/Txkv83kfV3vLb/d/dcxdIVYWqBeHsOASc05fjtuok8J7EZSwLdWBLlufSLkOcipJRutkWDnuoXNs0idpIPHVD9fxipAhOvmP8U4Tt7MMScYwjhlqjJUPHXb6PgGgJcCi5y38Qnx3ltkIsCnk/waySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102406; c=relaxed/simple;
	bh=OCmVlv+3juG/078tYC5i+5rF0H5NgbOSlmivmpzkFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2Cf4rDBrYRJZYnKP0srkKQV2gx28McI+rBmSUF4OE0n6owz1GFHGzpruGUMSihsfon2XcpLcY2zlRre/sHWKQzYFY8MNbclQ9oiEsiwgQKS69T4EkDz0EqvazECVzsOVoCcoT86ZWG364zf+6zyeUFzBGc4j+swjYMOSivg43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR4f1fOt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c34c2a7dc7so2299776d6.3;
        Wed, 11 Sep 2024 17:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726102403; x=1726707203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYe1dcYrMqeb8MG05frvJPi53ooviqOgpTqqXU1/f4=;
        b=nR4f1fOtC58YwuD8zEny4I+JtIC/qYbz1jlSVtDciDPUgAFhzTOd+C3NlMgN7SIJIr
         7abOU+GpWpnkJgyTC5crJ870a7cLLZvTGDEyBnfjKk9m6bJT/PVX/dA/af37l7EXEDp5
         Y+/+ou6p4XXobl3TkOYBr8ZL+Oq0Ecppe+uR49BM95Ck9niemvEEhO2zSeKezRNZQqy2
         mROzAKIUjxo8q2aW/NEAz85LK0WobN+RybuihzFMgUbPcV/G7rmZuv6OkfhEOEf9b9V7
         9cSzthDTfKYdoeLUHN/gedFQdf45sEEkm8yJ41Q2DNg4qSc6mgpX10VWU3OPs2nNizNG
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102403; x=1726707203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqYe1dcYrMqeb8MG05frvJPi53ooviqOgpTqqXU1/f4=;
        b=M95lFVYlOoNycPR8ekRlm1V9/Rd0VZcQeciJcQTDIXSzcxTnEyhuPEQ5kTdYZHpQb5
         0D7CHTR8jjI1oCQpBN4PoUbAyPsmlGjfiEFT1pCRMYj71NOi6IeAErV3+O3zgxSHbtOm
         CN3mrAUfxq7Vekj3yjSlimKbFMXAGKHsU146ePDDyUlT1zf7qjSKRY2HRkpcBfsdae2P
         noc1TD2/vT+61u+KqzAspuRaPauwyKIr90RHrqcUY4x+PhsPu6aHrA3ijDmHmdrgdGYl
         7qqNS17qAUpEBetqbYfhSFLefeSK4H/78eVPf5HqH9SsNy6+GxvSvXVeQZdhNz4NDMVw
         VrVw==
X-Forwarded-Encrypted: i=1; AJvYcCWZaN4/MutOCOY0566W62NAgA9J+cWcKeYhEdzkMgoGedO43d0FPUUXxikGW7RUvQXKGB4pm7Yh1TgBM+17Aek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWgDPpMq279tT2Jm9qocKjV2PcunvVrtNERDdmqQYrNMINwWH
	Zx+swLbGr2jhUpOT1RxiZ2NOIfHnDlpQW8lFkYFsNbwCrJycQ0MV4pURvQ==
X-Google-Smtp-Source: AGHT+IFLUf8/nhdOf7lVusmSkYa7xXG/id3ZGq4sxGnfoOZpcWajF1iM8QFg9QRl8pPuQNeAsIzbhg==
X-Received: by 2002:a05:6214:588e:b0:6c5:62e5:f348 with SMTP id 6a1803df08f44-6c5735578aemr12551476d6.29.1726102402570;
        Wed, 11 Sep 2024 17:53:22 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433b69dsm47947656d6.53.2024.09.11.17.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:53:22 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/3] selftests/net: packetdrill: run in netns and expand config
Date: Wed, 11 Sep 2024 20:52:40 -0400
Message-ID: <20240912005317.1253001-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
References: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Run packetdrill tests inside netns.
They may change system settings, such as sysctl.

Also expand config with a few more needed CONFIGs.

Link: https://lore.kernel.org/netdev/20240910152640.429920be@kernel.org/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/packetdrill/config         | 5 +++++
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index 0d402830f18d8..a7877819081f5 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -1,5 +1,10 @@
 CONFIG_IPV6=y
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_SYN_COOKIES=y
+CONFIG_TCP_CONG_CUBIC=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_TUN=y
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 2f62caccbbbc5..7478c0c0c9aac 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -33,9 +33,9 @@ fi
 ktap_print_header
 ktap_set_plan 2
 
-packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
+unshare -n packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
 	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
-packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
+unshare -n packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
 	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
 
 ktap_finished
-- 
2.46.0.598.g6f2099f65c-goog


