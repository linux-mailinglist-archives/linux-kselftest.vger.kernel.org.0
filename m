Return-Path: <linux-kselftest+bounces-30051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FAA79F92
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA1D175971
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90C254858;
	Thu,  3 Apr 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGF+M/YQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C4254847;
	Thu,  3 Apr 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670785; cv=none; b=QauNL2xNzsWNdMkJbBHfKgxtLaeFjpUu6VHkPoDYbrOiSepVcx1OIlB2ku7EyQ61r0ZGTiul3QEsM1lnTjmdcpoPFKGBJeWUML6eL1nxlfPKQfDZJkdya4l0HIvR/zUV2cqs4gWzNLfvQBB6d3dyDnA+zNrR2GCq6JHI0F8+AEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670785; c=relaxed/simple;
	bh=vfw4cOguzxxLv5iG8cXVFe2BJm5ymXMhTDgmA0Y1scg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdKQgvk/eYpu4DAV0Uoc92/HhU87vwpokb5KXBOMFBYWlIgzjCmMS26wsaPRXcrgmwQ/M6A3n2+bcvarSWBWxM4ZuVhfZ0R14bV/FeO8bRtNhb2G7HAX+UF0/BQ1jRZXMvpP9ygi3YMR85IbjBsZA9slKFUPs6xw1UIW/gPHwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGF+M/YQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af5a4cd980dso503151a12.1;
        Thu, 03 Apr 2025 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670782; x=1744275582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQoCdAZ6ZRNfTAkLkS2Ze1AI+2sYrEYh1iLVELMs+EQ=;
        b=fGF+M/YQ0OJcjpnY8tn8HyZRm5dDd2kSWjgE1y+whIozegseAX5f8fEoiTeOIr459z
         GGvIU0aX1CK7o9iaKnokfovr/8nOfJ5QALjbEoxwjsoJnIQsaoRNSGwwhSB710YPckXN
         A8QEYuNFz3hnzrt/gwFHNrPVO1HY5hEOZhJnXHKYTN77U7FpqRieqXavbulWeovnUNr6
         w8LsqiYeX0P2dH8GJ/dTO+m6zF4jMGAvYBoGzImO6mQm3YKjeDh0YTSF7HtXkXxq26s1
         hBDsDa3gRg9fRlUXHgOrkmOISK3qpSe/J1+/jIMa6GocAtk4xjF+M8m6ydZra+XmfGMt
         sPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670782; x=1744275582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQoCdAZ6ZRNfTAkLkS2Ze1AI+2sYrEYh1iLVELMs+EQ=;
        b=NOvWEKQNaSZh7OJljRs8AkRkbW5zMMN/8v2FuNHmVDLaY6/cVhW+RoNf7F/0kaHUfj
         gQxWet6ntpZkpskChezQFSA5VLFkzgA24pBXijmqDzKwjyyJnIjSpQAwHsOA0x1/IbI5
         QENSxQsWDCg82caqtwK5euOTTVB65wk0vxXZ/voFJmBB6pk8/r1BM92/lvjaTwUK7MWm
         Faai9/iwqubovTLtRN4z6jDK2CKSIqpYGynUzj3z6pMn1ntw6Xm9aGubzeuEJTyeR0o6
         +oiGDD7zn8+1fu0M0pPARcTBzWOzD5dJRcKspHfan45Ce4JOEaViRellNGvJOygWruNt
         0Uvw==
X-Forwarded-Encrypted: i=1; AJvYcCXF/c4PP2farp5vQHZxgxvMLGwQJSLsB7dDWMcNo3IHSiB5VWm/KwQ927Lb3L0Hn5SBujviKW3PpT+zB080dKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRiucts/tEV0pDtsZMuSs1vDxaj0j+MR8n5e/wn8mCav6eyMs
	puvhqeGrUuxTSeZdRFDRa6zoxtHM7m50s+p07Nq5eJl03F4EjYA54rKMcbMLrDU=
X-Gm-Gg: ASbGncuatzyRjfA3p2EwONnSS1krzfvYXbop5DCu8b9pxCXtharur+d6Q7ZHsXlU9NO
	4aZGM5FSN0GfEHto9YQ4xczqG7ooUMLZe4jmj8FMacp3/T4i8kax0lW2ovxuV8iJvM5tbf3UJCU
	wHhJ8RheGpMHdtw2A+LX/ucUECIwtweey/hx3HIwwQonoN+fD5IlfwZhH+Zd4VeuPV/IGxGTbFJ
	35OPROBLZvSzEzaENw7Jr/CAb4FgfRPlVme8kaWQfFRIcitQ5OoBPC3OzCh5LkdMSzI7wyvh0ix
	QsezhEw5JLSWnjCCZn0lUVvP5T65rxhYHqToDe7oiRM3nvP6K7noaZ1KpuXXqXJS
X-Google-Smtp-Source: AGHT+IERSDq8mrh8/5r2HejtuRMwYArP2+4K6ZXYMStSkQ9alZ3LLhbSWS5Bp1/522V9qRB4ww1xrQ==
X-Received: by 2002:a17:90b:2648:b0:2ee:90a1:5d42 with SMTP id 98e67ed59e1d1-3056eca1a6bmr9983957a91.0.1743670782307;
        Thu, 03 Apr 2025 01:59:42 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305827d710csm937620a91.10.2025.04.03.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Di Zhu <zhudi21@huawei.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Travis Brown <travisb@arista.com>,
	Suresh Krishnan <skrishnan@arista.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 3/3] selftests/rtnetlink.sh: add vlan/ipvlan/macvlan link state test
Date: Thu,  3 Apr 2025 08:58:57 +0000
Message-ID: <20250403085857.17868-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250403085857.17868-1-liuhangbin@gmail.com>
References: <20250403085857.17868-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to create vlan/ipvlan/macvlan over a bond interface and move
them to a separate network namespace. Verify that the upper link state
correctly reflects the lower-layer link state.

 # ./rtnetlink.sh -t "kci_test_vlan kci_test_ipvlan kci_test_macvlan"
 PASS: vlan link state correct
 PASS: ipvlan link state correct
 PASS: macvlan link state correct

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..de2f5bed8777 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -30,6 +30,9 @@ ALL_TESTS="
 	kci_test_address_proto
 	kci_test_enslave_bonding
 	kci_test_mngtmpaddr
+	kci_test_vlan
+	kci_test_ipvlan
+	kci_test_macvlan
 "
 
 devdummy="test-dummy0"
@@ -1334,6 +1337,67 @@ kci_test_mngtmpaddr()
 	return $ret
 }
 
+kci_test_link_state()
+{
+	local test_link=$(mktemp -u test_link-XXX)
+	local bond=$(mktemp -u bond-XXX)
+	local link_param=$2
+	local link_type=$1
+	local ret=0
+
+	setup_ns testns
+	if [ $? -ne 0 ]; then
+		end_test "SKIP ${link_type} netns tests: cannot add net namespace $testns"
+		return $ksft_skip
+	fi
+
+	# 1. Test link state over bond
+	run_cmd ip link add dev $bond type bond mode active-backup miimon 10
+	run_cmd ip link set dev ${devdummy} down
+	run_cmd ip link set dev ${devdummy} master $bond
+	run_cmd ip link set dev ${bond} up
+	run_cmd ip link add link ${bond} name ${test_link} type ${link_type} ${link_param}
+	run_cmd ip link set ${test_link} up
+	run_cmd ip link set ${devdummy} down
+	run_cmd_grep_fail "LOWER_UP" ip link show dev ${test_link}
+	run_cmd ip link set ${devdummy} up
+	run_cmd_grep "LOWER_UP" ip link show dev ${test_link}
+
+	# 2. Test link state over bond in netns
+	run_cmd ip link set ${test_link} netns ${testns}
+	run_cmd ip -n ${testns} link set ${test_link} up
+	run_cmd ip link set ${devdummy} down
+	run_cmd_grep_fail "LOWER_UP" ip -n ${testns} link show dev ${test_link}
+	run_cmd ip link set ${devdummy} up
+	run_cmd_grep "LOWER_UP" ip -n ${testns} link show dev ${test_link}
+	ip -n ${testns} link del ${test_link}
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: ${link_type} link state incorrect"
+	else
+		end_test "PASS: ${link_type} link state correct"
+	fi
+
+	ip netns del "$testns"
+	ip link del dev ${bond}
+	return $ret
+}
+
+kci_test_vlan()
+{
+	kci_test_link_state "vlan" "id 2"
+}
+
+kci_test_ipvlan()
+{
+	kci_test_link_state "ipvlan" "mode l2"
+}
+
+kci_test_macvlan()
+{
+	kci_test_link_state "macvlan" "mode bridge"
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.46.0


