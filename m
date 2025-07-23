Return-Path: <linux-kselftest+bounces-37898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C5B0FD19
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 00:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2B03B3E3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B2272E48;
	Wed, 23 Jul 2025 22:47:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2D1ADC93;
	Wed, 23 Jul 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310839; cv=none; b=BtClGQ8mfUkVG4ouIHASIGzNBV8ANfKJgGZmsbzfYmeZbnE9sBieqprKvD1TtYF7wnLFhQRMtUdzyRqViM8Tr/SEkcXZO+QgZndK01MDMN8yEchRuYrIGRQgxCjxHM8bHmQy57cHowMkfNHsaQL3WRfV8Dj11z04NHr477iZ/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310839; c=relaxed/simple;
	bh=gIZ3Gg4GHsNCeHTDxIT3z/WY+ARBDqVZGC0oXyvX9Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFVW1q9yNYkZmTn379N9IJi4EC/xaYdEqje866RoVMTm2NOEqZpmLFM2MyGlSmDnu/OQTdSGIAf5isypaUd03zr3tWFx4T44ao9VhRCiHTDNc45HD+vk4jTXJtB9mQOVaWj0CbWHpUjcvIlJpP6hXLLmlKRuOGBiRdJuyQQMbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-236377f00a1so2733055ad.3;
        Wed, 23 Jul 2025 15:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310837; x=1753915637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIv0ABc2hZ3qEcGwVWoX24Ijm7AbP0wuivuZzCaSDck=;
        b=hkiQ/Ffg+igedPR2KHV/0InzJgGsj4q1KEMlFVcOyDhLHteMyUsbDueVyf/d9WJbPw
         x1BHMmutgBP/j4ykRk+XXwCU1ZJxgpXmHuLVpBcxB0T1igKY9lrzcd8KQjMCDJJNdFOr
         TkXNqga80YE/7LNj//SuT+X0TuUVaXAg80ZG+VFcj8QuISMJ3CeqdMM5e5tM1s2atw4E
         YawLCrSI/IMptsyLna9gM1+Ll247Rc37pgkKX+ZPnJo8y/2Ml8bu6Ofj3fhWqPTrlbCr
         6TlrkdLD4lA/Tsa3H3ysT3P4YobJGUaqecAwRELznxlutmig35kypcRtpUHPkVfCLKBO
         wR6w==
X-Forwarded-Encrypted: i=1; AJvYcCXA3jIncQS6jYo4BHBbjvs1+ovKKOQbY6T5sXHzjK8/pInVfOPEA+U/wqurSamRqS8B+3zJEid1oXiAlmGs7Oiw@vger.kernel.org, AJvYcCXEeaneqAp6t6H+ocqX2u92HgXwESc6jiah8xN5aBOfdOILJT3DgLRo26wvnrj39u6Iv93z08FRSBctzgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QbXMkYsEMehutzOC7lSt8lWC5Dp+zYZnWTriCFQcGilaPEk8
	85zyjnKZSD6RTWsB1EnTa9Culd0ff/HqBNSgRSx3SGmZkHCwwKdSNpZfiL8n
X-Gm-Gg: ASbGncsW/DL8uUyWtlQJam2sR7bTYRhFo18RKau7jOm9VbBIfvtlykF8jD68m4f1Oin
	qHvG8mgq8CCkhtXKdlOn4/P/0FIpivhln5MT4qg6C+FdUaOUvhtISQomlrI7OkbLARe41C1eKLZ
	mRDk85tuTo01p5I0NyP9MfXpwoLJ/+nSR0ftAIeLuWkN1mSM719ciBEogcIBgau2PTUdWSsgPEQ
	RVDI1HH+AWOMZC3QlkEQ3qJ2T/MXtLie0/s+xb+cakDFMfGBeyC7mfR2EKYlvoKDfoXlzKmEj6/
	E295smbT8uHS6JSbydmYhkit5Dtma3S54WHQpUs2MLfAJRGJtL/qh3bBtglx4WM+WPF7jzUsAwP
	GAP5ckSAiGwKZGxn8Dp7fE3McP9B2FcbxQkjBUhZxLhu37Fw9WMTeifNDofTBnznLDQl2VA==
X-Google-Smtp-Source: AGHT+IG9CGSEp3Qw45UQnHd6uj+P20AwcVqjHQKhcpdUnznQ9Sg0rN1CwtHG/GLgdDSbf6t/F3/BtQ==
X-Received: by 2002:a17:902:e546:b0:234:ed31:fc94 with SMTP id d9443c01a7336-23f981ba3d4mr58873915ad.26.1753310836823;
        Wed, 23 Jul 2025 15:47:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23fa476c131sm995695ad.45.2025.07.23.15.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:47:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 2/2] selftests: rtnetlink: add macsec and vlan nesting test
Date: Wed, 23 Jul 2025 15:47:15 -0700
Message-ID: <20250723224715.1341121-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723224715.1341121-1-sdf@fomichev.me>
References: <20250723224715.1341121-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reproducer for [0] with a dummy device.

0: https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com/
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/rtnetlink.sh | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..d786aa07829b 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -21,6 +21,7 @@ ALL_TESTS="
 	kci_test_vrf
 	kci_test_encap
 	kci_test_macsec
+	kci_test_macsec_vlan
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -561,6 +562,41 @@ kci_test_macsec()
 	end_test "PASS: macsec"
 }
 
+# Test __dev_set_rx_mode call from dev_uc_add under addr_list_lock spinlock.
+# Make sure __dev_set_promiscuity is not grabbing (sleeping) netdev instance
+# lock.
+# https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com/
+kci_test_macsec_vlan()
+{
+	msname="test_macsec1"
+	vlanname="test_vlan1"
+	local ret=0
+	run_cmd_grep "^Usage: ip macsec" ip macsec help
+	if [ $? -ne 0 ]; then
+		end_test "SKIP: macsec: iproute2 too old"
+		return $ksft_skip
+	fi
+	run_cmd ip link add link "$devdummy" "$msname" type macsec port 42 encrypt on
+	if [ $ret -ne 0 ];then
+		end_test "FAIL: can't add macsec interface, skipping test"
+		return 1
+	fi
+
+	run_cmd ip link set dev "$msname" up
+	ip link add link "$msname" name "$vlanname" type vlan id 1
+	ip link set dev "$vlanname" address 00:11:22:33:44:88
+	ip link set dev "$vlanname" up
+	run_cmd ip link del dev "$vlanname"
+	run_cmd ip link del dev "$msname"
+
+	if [ $ret -ne 0 ];then
+		end_test "FAIL: macsec_vlan"
+		return 1
+	fi
+
+	end_test "PASS: macsec_vlan"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.50.1


