Return-Path: <linux-kselftest+bounces-37764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637AB0C91F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED64545D4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C12E1C54;
	Mon, 21 Jul 2025 16:54:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D92C15B2;
	Mon, 21 Jul 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116868; cv=none; b=ElPpeQLQE5vQCzZE58905RD1VEEPIXdoZV0jmwAs1fBpKQm6mcHhn+bD+8Up6F56MQMIkBrcbQmGeF79CkJ5xikeLzX0bX5O2Zp/VxF1N3OQy+6O+Jkg1h/f2aCsfRH8p9F7fZWZnzykBPI93E3DnXWCVZ4N7gjcY2VtG09tGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116868; c=relaxed/simple;
	bh=GBqbUp6sE8f/rXc4E4JiViq7VpsWdjKXsX+n56O6qVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTqcq9TfxcckEt5Cbfkct6b9xZMPnxIIOZsb72raF8ou0UTavneYY1TCMPBSMJRkzbN8I7yQw60wx8qEvQu5q5GG9wD86TFStfLy53xFlKFUMrvxqI9yhhYjjxxFVPQbSBEAiwrcEiWvOfMpUmjWklJ+fGecYf/wEjzncc0Xn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748d982e97cso4078348b3a.1;
        Mon, 21 Jul 2025 09:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116865; x=1753721665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpdVYv0nYpd9DC0WlvTylBOxeD8UZphYAJMRGZuk9pY=;
        b=fMYNKa+7Jjwx8M4VsKNsc2HhjaUdr6YfCe/vYJmH+1bSzKMGCrK37zVs/LXP5MQyJ2
         GoGh6C8X1Q1bqm2s5qpk/XktWF8PGxX7kkDPsr0Rd//J8YOO0+VBI7AdOSWwLx7HLshx
         zfoytJoxgP9X/hUXRLPVmrl2yMnnvawY61IgM/S/K+R7dDCovKi4YIlIs5UfsZaM1A8O
         75vuX6+lJtUxVSlm913bOxfjDpLgG6lDfMXm3ESjHDkVxl4cdxn57wJ1TRiA3GZir9gS
         aD/ycmMJ6+ty8kTsFKVZdlC5Hr3S+eKzen00lulyCUsqEf9Woz9AygxcXPMffW0GTaEw
         zKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlsut1ccC5YZP9bl6sarD45wpulKMIBF/zgMiPdqMV24AeA2fzH/KL05IATEsjlb6u5+gL6fmGNCFrLcwUmiMz@vger.kernel.org, AJvYcCV3Pjw6WuviqpReVW0v33ndGt2SrGxHcq4Z1NZ2XPDycIPt3vDjNDcy31hNEmMv3zPsAnQYGJfYFPL1ZgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8q+HFJkAEn/rcv30dgLHlcxGgoZ5P/VPDAr7Lc+nIcd3adyw
	5hu3CkqztY5bAVNublT/lqTm/luNn6oeo9qNNP96SMbAGjLMnIjQ8odC9mww
X-Gm-Gg: ASbGncsRNfm4ycdPNPnJpI5iZmVwn4kP/I4Ox8wVoNs2ZX+XdISxLHm1zri0GG8fP9v
	9YoCi6vYoAv1UKmhMfAYqwx1Gp/NW1ByVC7B477biLbS7LKrFgJrcCBv4K1BL3uDxua7s7gzGUv
	4hkX+ROdoNlhSh1FkjKxBaPrqGlUMRRjRk1y+o70ZWyoD/9NXKCK4DyPnRRAGImTl/BmSuUYlWT
	KeqOBVIN2J3B/840Vmvwysx/H3AIF2wsXWTGL9fRGvKJMzGljt9gdwgagNo3b6gRWiOFPXQKV/I
	6oK/T9MPqWslOXEbUGo7vj83JGR++SVpsFbsjk6gf9I+jNBWjjB/Pn4OjudKs9aZ3wXl3n2TLox
	GycofKozsgBIxpsD1VpG0brB84Qd12krsbaSm0lfOLFb73I2a4DMCoe1NVCs=
X-Google-Smtp-Source: AGHT+IG5Uy/FsGnbWhF/hvFAxsmFmvd3oxdR/RA86cte6CdxbKUKzDhwmPOq40RbZ4D6xmOaINcawA==
X-Received: by 2002:a05:6a00:2e92:b0:748:ef3d:3247 with SMTP id d2e1a72fcca58-75724876e61mr28357344b3a.20.1753116865452;
        Mon, 21 Jul 2025 09:54:25 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb155de8sm6126517b3a.84.2025.07.21.09.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:54:25 -0700 (PDT)
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
Subject: [PATCH net 2/2] selftests: rtnetlink: add macsec and vlan nesting test
Date: Mon, 21 Jul 2025 09:54:23 -0700
Message-ID: <20250721165423.990313-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721165423.990313-1-sdf@fomichev.me>
References: <20250721165423.990313-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reproducer for [0] with a dummy device.

0: https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com/
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


