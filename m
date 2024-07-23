Return-Path: <linux-kselftest+bounces-14053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066E939977
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36824282A8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CADE13D24E;
	Tue, 23 Jul 2024 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPzwlvAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3C13D538;
	Tue, 23 Jul 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714167; cv=none; b=rrJApyCq8aFWG8AdXEgVDcyUPVSADHYulQRNclkXuYFU0FP/RLjyGiPMDJTek7gEtJ4CX+ttzsN7gYiHad7p4f0mQ6zkxdkOcoqdzROV3WalxDxo8B3h6TzeqA0rk51OP869m6Tn2D9OCbCZvqcYJEDlZGgt7CW4F2MoLUCfvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714167; c=relaxed/simple;
	bh=iyYPpn+hXqyZjmPQO9B6qx+fPPrlP1Ik7gugpemYUw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSuQ4nmShKJAzghU2pjkzVG6oyetveGear+xavs9vrKOpsJ1mLFSJ3LP/3T6YQf68sgY64HgKAeJFF/mbsp0619L3/YoTBXkjY5wMjBtVeVZ8tgZ679/FvrwgVxcSnCy4MuIKDF8ZO1Ddk5DF7Z+OFVKi8BdCEu6ga64oUf/4lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPzwlvAW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc5239faebso2168345ad.1;
        Mon, 22 Jul 2024 22:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714165; x=1722318965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7Poq16VwrjI6K5TQu0XyFE0O+HO7fJqUE55lzfibYQ=;
        b=iPzwlvAWkYBp/8Zk8zaoDa6MJIvImZI46SyLbsmJqH13DX/ty5BLJXBtuyhd6hzJVf
         fJPEZ5g9SDkPlY/+o8yOpZpnd/qjLEbBQOEah0seyoRP/C9zC8i9oJyVtJpLT30FpgNU
         IxVuKGia+SlvusxqISTo8UHRP7CetOytwTbfv19uGkxWy5Ssb6HIpaRDlPZsXmUJV42c
         oyiHEyvi3fwrL6dlfmipjI0xJMq7BPoj+4XSREAqSG4mgzAmngNrL+8IXliaYf22mYBL
         IizNbIKcu5D+D/A6b//bEZopKNRXyswAMI9oCL5y4GPWhFfkBJV5/yqwTWxEBeE43Cr4
         dqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714165; x=1722318965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7Poq16VwrjI6K5TQu0XyFE0O+HO7fJqUE55lzfibYQ=;
        b=bSuuLMKKb69ME/bw8trg7jkSckqj6aDBKhOd4RalkdAtRZGbQc+6ZMaNRo9XjPyaHQ
         GcFah2EhLXeGEVq5t1boBK0ys3M9CyFppocRQmy7zzoeMePALj6v+h+VjcLjBmFpIeZb
         F5uq2glYaLM2DD2modJ9T5IECAH5c5BvmMCeGUaZScGYeYhXzazQjyYzqwgkwHf9MDSS
         khEeTVuhfdADFe4jwPFHFioRmPTpeR2t5u5Im6UEQW8db6pkM1YA6UKzuZpcdyPy9TKo
         OYmrroMJFtqtTZ94shNSLDJmUqWBvAZfKQT+ZCpO4ZOD908WKMgNO88vqNMb+2aIEHUe
         Hm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2v3k/7hnzeKwXGcbiXo58XuMoyTYIy28jYaAJsFG+wZaEQSBMzuXmHmwpooYFyVenNadhd47h6u30AJxxDHGCOvRFXncxHV8MhWSSj30Z
X-Gm-Message-State: AOJu0YxBr8/fiHc8jx2Ee1R/Szrzg3pW37dBPui2pnSMNin8P5dNyRS2
	mp4N5iIh1M1az/J+siOKyXkyZ5ABs5/GiDIgX2nNYI6VaZDBux5tE3Hot9j0
X-Google-Smtp-Source: AGHT+IHX8nDGUYAR1rrFPblUOqoY6qc03OpITbzbp6hgcUAkvpDy51TQ2F6RLswuRwt2fqOMih3QLw==
X-Received: by 2002:a17:903:22cb:b0:1fa:a89:fd1a with SMTP id d9443c01a7336-1fd7452553dmr65970615ad.10.1721714164941;
        Mon, 22 Jul 2024 22:56:04 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:56:04 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 16/19] selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
Date: Mon, 22 Jul 2024 22:54:43 -0700
Message-Id: <3869dda876d5206d2f8d4dd67331c739ceb0c7f8.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a redundant include of '<linux/icmp.h>' which is already provided in
'lwt_helpers.h'. This avoids errors seen compiling for mips64el/musl-libc:

  In file included from .../arpa/inet.h:9,
                   from lwt_redirect.c:51:
  .../netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
     23 | struct in6_addr {
        |        ^~~~~~~~
  In file included from .../linux/icmp.h:24,
                   from lwt_redirect.c:50:
  .../linux/in6.h:33:8: note: originally defined here
     33 | struct in6_addr {
        |        ^~~~~~~~
  .../netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
     34 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../linux/in6.h:50:8: note: originally defined here
     50 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
     42 | struct ipv6_mreq {
        |        ^~~~~~~~~
  .../linux/in6.h:60:8: note: originally defined here
     60 | struct ipv6_mreq {
        |        ^~~~~~~~~

Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index 835a1d756c16..b6e8d822e8e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -47,7 +47,6 @@
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <linux/if_tun.h>
-#include <linux/icmp.h>
 #include <arpa/inet.h>
 #include <unistd.h>
 #include <errno.h>
-- 
2.34.1


