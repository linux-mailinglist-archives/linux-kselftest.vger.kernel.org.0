Return-Path: <linux-kselftest+bounces-6323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF587BBA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 12:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E994B21748
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80226DCE3;
	Thu, 14 Mar 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl+37VDK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AD6CDA3;
	Thu, 14 Mar 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414001; cv=none; b=R2NCsply3UiR0iDFYxHmCtV4/TK+hHCePHGa+UlDaQi3PEfbADvtZGVizStDHgb0dPem1n3APfjZo2rKVyn/aAvsXA9Kf3bB+VAZzK5Pj5DrFpLtWu9Q0/Y7alKwky9heFmxUcAehsU3I3yNSEidRoJRuSC9BEy6Zvy5xQXOxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414001; c=relaxed/simple;
	bh=IsShSKe2XWmUERLMrTIUxY+uPPipgWDxAQnRv8B+s/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=IaB7jtHs1IfbflOTYeAtzrw5u/PR1vZEvz/2FT+TeJYHKMAeokjpoBJI07gIQumESKaE9pdEUdyxCDK40a0Vi3l8s0IOgPCD0sT/MzTEEYvMpnp04cEYm48GKzGMyiz4wMD7Yg+xKrJe/+sDOd6x9p/QkD9P0iw5r32Xfrgyywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl+37VDK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a465ddc2c09so86150766b.2;
        Thu, 14 Mar 2024 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710413998; x=1711018798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f74il14ZWPvRtCdOjQ7hLLex80lpQ3c6JxKbsOjU1Ps=;
        b=Yl+37VDKuFR/LB9gRdq9EDL10s4hClWdHIoN8yG2edq7s7MNmb8ArRbyCQqX3eJQ13
         QKg8aFGkVYF7mhqJasCixxLN3JWHXukkCxQ8dcTDAfPAd5LZJrO/z698HRkmqrQYgKkn
         tMBFR0p3oAMICT7S2ZzsFW+EPk6xWbUWmOfe1CAB7sSBmNdawARdRieLLYHdQEDJOtU4
         XEbh3aYf7sQsHirZowNIGR2LZPh+7nsai1HwLgHaj64jhU0xbhKdfImuqsYe7508JTiy
         4dqLEIsi0xn691fdF6m5cLeLbmCGsm3rtW86dt2IYnAUqAKjl4olbe5bojyW3tSBQxf5
         IagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710413998; x=1711018798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f74il14ZWPvRtCdOjQ7hLLex80lpQ3c6JxKbsOjU1Ps=;
        b=Q0SxjE4/sPaDv4NIvCotLujG/XN5qVBvGDrFYaqp0JeZ6SVwBwefZf2F16tZbokb/P
         oq8dzDDLP8IoxMl4pfGzdz5MiE3kJNfRh4XEjWmOxXrk8fVPzk4RZNQ2EiOkimjRXPcR
         EhcwlieIo7ARiZ/6slS9jMJP0J9XSPNL4Z8aufVHgKoRDau+CjgOScZE3YpfuAIAtiW8
         qyrXl/Xf58btTRv7xlgJo73l7Dv0ct6VCyloD/DDRrw3mArSvJ+01dQn+G4G5ucOgIwx
         aHo3MZGyBnRnVwWy2qjJCdzVEq4OtZtndGySOWc8k2uRUX7C1eVfxXZxCmBrsJPPLRu+
         Pv1A==
X-Forwarded-Encrypted: i=1; AJvYcCXqbBX6zSPq6erFypttOIWo0tNz17HYq8VUKS4aZpxBfBQCvMtFLC0G5PxDp5NH4oP2WJ30i3Vrg+z7BFFGiRknJwA4NkDYp2KFYA/fDqdHXglGFcAlePB/eX2AylJPslLX6j26bquYATa5MtMXG+IvS/iDJ3uCcYhlFWrvN6cSy8EN
X-Gm-Message-State: AOJu0YyZXIbcdlVeqdShdlem87+t1BTFoOUPB0oadzKkVlrtJji3n6f9
	KyLMfIxsKfQ2DoRrEFUD2cViu5+sBLJ2At85F7A2SMwepK1l+jpV
X-Google-Smtp-Source: AGHT+IG7A6HdmcY9jUncbFxRiJeisYCCIEcG3esBJ+ZAJKVpFR+ycbzcM3+TaJVxKNZ8Teh9Wgu1fQ==
X-Received: by 2002:a17:906:7f06:b0:a3f:bd94:4d80 with SMTP id d6-20020a1709067f0600b00a3fbd944d80mr804119ejr.76.1710413997949;
        Thu, 14 Mar 2024 03:59:57 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id en2-20020a17090728c200b00a4674ad8ab9sm371988ejc.211.2024.03.14.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:59:57 -0700 (PDT)
From: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH v2] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent client connect before server bind
Date: Thu, 14 Mar 2024 10:59:11 +0000
Message-Id: <20240314105911.213411-1-alessandro.carminati@gmail.com>
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

The issue stems from a race condition between the netcat client and server.
The test author had addressed this problem by implementing a sleep, which
I have removed in this patch.
This patch introduces a function capable of sleeping for up to two seconds.
However, it can terminate the waiting period early if the port is reported
to be listening.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 910044f08908..7989ec608454 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -72,7 +72,6 @@ cleanup() {
 server_listen() {
 	ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
 	server_pid=$!
-	sleep 0.2
 }
 
 client_connect() {
@@ -93,6 +92,16 @@ verify_data() {
 	fi
 }
 
+wait_for_port() {
+	for i in $(seq 20); do
+		if ip netns exec "${ns2}" ss ${2:--4}OHntl | grep -q "$1"; then
+			return 0
+		fi
+		sleep 0.1
+	done
+	return 1
+}
+
 set -e
 
 # no arguments: automated test, run all
@@ -193,6 +202,7 @@ setup
 # basic communication works
 echo "test basic connectivity"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 client_connect
 verify_data
 
@@ -204,6 +214,7 @@ ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 ! client_connect
 
 if [[ "$tuntype" =~ "udp" ]]; then
-- 
2.34.1


