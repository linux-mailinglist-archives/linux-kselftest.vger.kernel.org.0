Return-Path: <linux-kselftest+bounces-5642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D563086CAE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FE11C22FE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71C1350E3;
	Thu, 29 Feb 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuw+ahxL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5C1361C2;
	Thu, 29 Feb 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215243; cv=none; b=IJ8C2RVo83hR+IJIMoIzRpbw7RQzGxEq/MLuFIyjoSSX2Db4en0PB37bms3c186XoUivVOYXsi73vX1iBD/ksTkFU9PZvKWogWcwNudrgFDALJN3ekeqVmDdWDSsOPJF/FjoJlc3Yxp6pDFDlxNw4jbHWDBjAdpcsJ7zm7nBb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215243; c=relaxed/simple;
	bh=wwJQMdpI6wzPFkGbG61u25Um1c0sM/55HL3azw3uZDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=RO/2z2y7zdwL+16b7EJKWwfA9KzqH8/nkjxBVGbJqHXov3NQkkViUVFkCdcCaph02mJMRYb0vv7BG/MenB6swa+mv/GYMm9IFOD8zQXiIw83r1wKAMdwWSbMEsgcyjSBDsf2WvBGXx/VXH0HGwf8UoDj3nKj8LnImlReZEIo8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xuw+ahxL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412c29da53dso1239545e9.0;
        Thu, 29 Feb 2024 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709215240; x=1709820040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TV6GRMDY8Scq8jpKm5RnkX4lQVf+6dmwO1naHKeWIUI=;
        b=Xuw+ahxLqRqSRI/JEigA+SohwZhihulykE/iIuXMl8xEVf4l5DAN89baFeDxoAbiIf
         OYr0xonMSL9qbJ5Z2NuavZzlw8c1kMj65D57glMedBII1fiJWlRpVi7bVS6kH7OLaXbb
         DxX/iytfOnxKJpg/obhlTFAMLZqKMllCbt5Tr4wwHlVZK+c9HfmAIWo6auBlDQjHLni4
         GMx+qL3MRmcOM5CglWARNVER3XjlmEHrhPPfhtRm6TimrbBRcmAErHShvLacYlYUZMgC
         DskH1PMxs5F5epa5lTzrKQssneS2e3OFLofGpgfxnv1tAueu46Y1e4OW8GTPVm0JoJSk
         wYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215240; x=1709820040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV6GRMDY8Scq8jpKm5RnkX4lQVf+6dmwO1naHKeWIUI=;
        b=j6F0S5WJ0V0MJFAGKboReM+AU2J1N3DdgKHI023b0jp2hLuIKyuOrdXBN3cnfgb5Gu
         fjVTOgtxTUl1jxqcyvDlwnSpPdM95qxRbdSodlYgUYr66pbrcYQCEgr8MulZSgIg0pIE
         Qem1f0aKb8OE5reiUCvevqO0vD4noctTYj/BL3ZXEyE+W/2LCziKXSVa6ZVWEEZbtL7i
         mPcx8cKVdO+IUTa/x+WVBTxwx1wr0EKj/WOzWXoqXlCz2TQeZwrpeGdMff6wkNwPqH9Y
         u6Vo3woa1pe27LPcGvhYmDDnZBhVfdNv60XLXCwUrB91RzAdii3vg+gVifEvJxu0wPIJ
         Ko8A==
X-Forwarded-Encrypted: i=1; AJvYcCU0TmzmY3rxPRQLoiyeYwmn5wAbNZ1uyltMuuYEsv2uoXGzfqhbUGv14sPV7vtw+XyGAoz+P0nTbuRgJ9FkKvWFKU46Ir3NwZ8pBXLVOCWhtRJgyTwNKHUCCQXQlujHWIbzi9lM1smUTyAlw0c2jsfl38hEXUPYj02GxjwFvLWcgj/X
X-Gm-Message-State: AOJu0Yy8oDQyMVdVybdr8Si/rjbe3lYoT92j7Tt/utF1Q2SWhSoCKPe+
	Oe6CjSipwxd6ssdNvuWt6wkZZGRfD/cRXpR/zzTViWSJ0iDB+7HO
X-Google-Smtp-Source: AGHT+IEwf+/RVY7fF3mXhgA46Gx6Z7+tKPEdgZuVHVJ3dqiO6lqa68xkSLU+gRMERE5GETkvkB7+og==
X-Received: by 2002:a05:600c:3512:b0:410:e43d:24e9 with SMTP id h18-20020a05600c351200b00410e43d24e9mr2137532wmq.22.1709215239735;
        Thu, 29 Feb 2024 06:00:39 -0800 (PST)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id g8-20020a05600c310800b00412b0ef22basm2216853wmo.10.2024.02.29.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:00:39 -0800 (PST)
From: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent client connect before server bind
Date: Thu, 29 Feb 2024 14:00:00 +0000
Message-Id: <20240229140000.175274-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

In some systems, the netcat server can incur in delay to start listening.
When this happens, the test can randomly fail in various points.
This is an example error message:
   # ip gre none gso
   # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
   # test basic connectivity
   # Ncat: Connection refused.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 910044f08908..01c0f4b1a8c2 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -72,7 +72,6 @@ cleanup() {
 server_listen() {
 	ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
 	server_pid=$!
-	sleep 0.2
 }
 
 client_connect() {
@@ -93,6 +92,22 @@ verify_data() {
 	fi
 }
 
+wait_for_port() {
+	local digits=8
+	local port2check=$(printf ":%04X" $1)
+	local prot=$([ "$2" == "-6" ] && echo 6 && digits=32)
+
+	for i in $(seq 20); do
+		if ip netns exec "${ns2}" cat /proc/net/tcp${prot} | \
+			sed -r 's/^[ \t]+[0-9]+: ([0-9A-F]{'${digits}'}:[0-9A-F]{4}) .*$/\1/' | \
+			grep -q "${port2check}"; then
+			return 0
+		fi
+		sleep 0.1
+	done
+	return 1
+}
+
 set -e
 
 # no arguments: automated test, run all
@@ -193,6 +208,7 @@ setup
 # basic communication works
 echo "test basic connectivity"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 client_connect
 verify_data
 
@@ -204,6 +220,7 @@ ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 ! client_connect
 
 if [[ "$tuntype" =~ "udp" ]]; then
-- 
2.34.1


