Return-Path: <linux-kselftest+bounces-15388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CA952A77
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EAB1F21C89
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AF19E819;
	Thu, 15 Aug 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3uZQVr4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F719E7C8;
	Thu, 15 Aug 2024 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708821; cv=none; b=rT9hAPYBRhLC+ZtgJzjgNuuNbUdKK5O21rf/canTM3Kkcexb3tTP9SdKxjuk9+2q2ofKgHeJmKNuGgF/Uc2loTKXZT486JiF9mlY0+PHNlXnJGQcvAZAOf/DleTJTo2waFGQQYse4Jo8/YWVV2cj+8PeLKmam2lqvvRKu17Y7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708821; c=relaxed/simple;
	bh=/PSAS6fGscIZZGwr+tXSEVxTQmx2lfatLsRY05pzoyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX4CdbJdBvFnEFjAbYUqnDrTgYfGSrBlTP7bOiBs6beFMGwZE4T49lcQmfZevNgsd9k2GTj3MX+qR/jQOMS1TJ/vcUH62QrM+iTRiT+6o6BvoIihLBENXIXoksKrwiF0r/w2f5Ys6hM/IJ0Bxt+E8h/TfY2rX+esXRDjSWughSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3uZQVr4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a263f6439eso550054a12.3;
        Thu, 15 Aug 2024 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723708819; x=1724313619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfRMP9yHEwG0TQMvHjZIar43XCUon3TZcQShYdfW53A=;
        b=M3uZQVr4tsM1Ru3DPDysrdxQ/PEFpweGv1YOuUU3oK0qx3bxuc8v6/6RXYmpKuB6PW
         Ne/iF4U3ADhW+Gi4GkKYwQ6Ibdp2MLVoBddlWvlgH1UB0ZPaOZOih4KiZ8IIVP6ay4tD
         SfLzRyJF6Az134uV5iSdyDC+e7YeTlm04xkThHevdjMn8CnZIDa3j5DU1IYUoHkW+3uw
         AE5JvEpyNxE+fDo50IgWm6eBO1dHXZAFEG6P5UB/bhY+jMivLUWLKv8iKXXLm8//4GRU
         aBKZqgt69ExVuhvvYqWdIsLO6FdxtASTv1BW/zTekSNWaOa/ZGj98gkAMnyzz+dCPAAL
         0Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708819; x=1724313619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfRMP9yHEwG0TQMvHjZIar43XCUon3TZcQShYdfW53A=;
        b=iUSj0QJaCK3pvUup3lXW0/WJYVZn7MnX/V2/KLCEgvkSx7U1Q0ABnd9B8QEtK56vwR
         lGuyRlKseto1ZgwV9yKK5p8TeLirTTM2YrmjXSyxx4UKB49h/7y/x4sBOTQz0MwOzwqx
         jNBTYc0+DY/PIC4Idiha0zBWTq7QFrnqbrhXhKzMtsZFny9ZLs+QDfL0z1zzfUuN6erw
         THoJnMKtxX8GG6WWzB7slOrwJzntxYoKyPqC6B3NgSWOfbWP3Y094T5Pl+kaEHLa6yP9
         YBTSw3XSdJSHDX3x07Bnn3fb8M/G26b7mWLCg7kpBlDrRalRWRega8s0OMl8rL6iSFkc
         4dcA==
X-Forwarded-Encrypted: i=1; AJvYcCVnIRyDFF82t2MGUnvc+AKFp9lFQ8BpCUTJUt681TCkPOG212gTd8DbFoxoBRlhrxH1zuXyTD1P0GJkn/1ecFDIDT4o6KRKs4y0wvbqk7O0mKuhcc6ULdpCY4x+6d2OeVDhaj3N
X-Gm-Message-State: AOJu0Yx2pebVDRq23y1xaZAIL8K+96kisXtSY5zZ5jkutEdlWxgB1XLG
	IWFQCa+c7Gz801I+K36e2pNwAoE7Wct1jFIm+MgbpP2zX4S3qU6g/0Cc9Mc2
X-Google-Smtp-Source: AGHT+IEbYTmoog3EB+Mrw2CDH49mp3bDC5vNbIyQ4pn+4hrgp7pS8ROqq/Rp5zAOYTdiWuRlhgfEvA==
X-Received: by 2002:a05:6a20:c887:b0:1c2:8fd1:a47d with SMTP id adf61e73a8af0-1c8eae59c9dmr7405017637.6.1723708818277;
        Thu, 15 Aug 2024 01:00:18 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm6250515ad.124.2024.08.15.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:00:18 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Yi Chen <yiche@redhat.com>
Subject: [PATCHv2 net 2/2] selftests: udpgro: no need to load xdp for gro
Date: Thu, 15 Aug 2024 15:59:51 +0800
Message-ID: <20240815075951.189059-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240815075951.189059-1-liuhangbin@gmail.com>
References: <20240815075951.189059-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After commit d7db7775ea2e ("net: veth: do not manipulate GRO when using
XDP"), there is no need to load XDP program to enable GRO. On the other
hand, the current test is failed due to loading the XDP program. e.g.

 # selftests: net: udpgro.sh
 # ipv4
 #  no GRO              ok
 #  no GRO chk cmsg     ok
 #  GRO                 ./udpgso_bench_rx: recv: bad packet len, got 1472, expected 14720
 #
 # failed

 [...]

 #  bad GRO lookup      ok
 #  multiple GRO socks  ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
 #
 # ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
 #
 # failed
 ok 1 selftests: net: udpgro.sh

After fix, all the test passed.

 # ./udpgro.sh
 ipv4
  no GRO                                  ok
  [...]
  multiple GRO socks                      ok

Fixes: d7db7775ea2e ("net: veth: do not manipulate GRO when using XDP")
Reported-by: Yi Chen <yiche@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-53858
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/udpgro.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 4659cf01e438..d5ffd8c9172e 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -7,8 +7,6 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.bpf.o"
-
 # set global exit status, but never reset nonzero one.
 check_err()
 {
@@ -38,7 +36,7 @@ cfg_veth() {
 	ip -netns "${PEER_NS}" addr add dev veth1 192.168.1.1/24
 	ip -netns "${PEER_NS}" addr add dev veth1 2001:db8::1/64 nodad
 	ip -netns "${PEER_NS}" link set dev veth1 up
-	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
+	ip netns exec "${PEER_NS}" ethtool -K veth1 gro on
 }
 
 run_one() {
@@ -206,11 +204,6 @@ run_all() {
 	return $ret
 }
 
-if [ ! -f ${BPF_FILE} ]; then
-	echo "Missing ${BPF_FILE}. Run 'make' first"
-	exit -1
-fi
-
 if [[ $# -eq 0 ]]; then
 	run_all
 elif [[ $1 == "__subprocess" ]]; then
-- 
2.45.0


