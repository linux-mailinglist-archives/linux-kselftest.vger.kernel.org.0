Return-Path: <linux-kselftest+bounces-7323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01ED89A9C2
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 10:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B337282929
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748D22EF3;
	Sat,  6 Apr 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RQXFG31G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED64200BF
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712391923; cv=none; b=e20Zqjbtq6AmkdtBHrLUVJtfDEIpeGEUy1/h6ZJ3Ny80lebEGpi3Z3RPmI3q9xOg2hn5EJZ6Dll5jlhJt7JC09bnJc8wnxbDC6H3ybwj5zLaAotDO3ZqoUp13cvD9UnfTidajULDOc5i1iAPGp0EgKSAaSFp++ca43TKBWi+t6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712391923; c=relaxed/simple;
	bh=Yp70LyV42TC86owiqwUo+ei2yFC/VLhbCv0icbZUJFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjGS0ncEmp8ku4bX8vQyUihquM5RadbFyzbPf5fLKkhn+5NL1EuVdQkiVyH8OUJ1zXDOC6KriliIFE0mqiGKsD97dXTKgIi9+FbDq8jgwL3en57bjIAVpPNXlGr4i9enpVxYBy8DHlkpwNBpo5rr+pB21qqJGKDfnv9PmH008os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=RQXFG31G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-416434311eeso201225e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712391920; x=1712996720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBJNfaYHzuiXuMZUpgDPs9xtiQNCWuPWeZpuB9UBK3o=;
        b=RQXFG31GJAWymDTWNhTKADUAB9uLWMTl6XLDZsCjsq48E0qlICb8X5ZIYM+ZFvPxY+
         2iTmDH2B1OdN9K8TMnnATglFXoHTbTWRzBWWDkwJ3o+vYAyxonhSKaU2L6EFlUFJMeVk
         5eKsxULDCoQlQLghZy2H4tfZ62ywrUO4qnvkpTZCbil65UKBTo1Nk6cLNBkuuNAfi7ba
         dnIVBhElxMmNSPRnwBE1OAan/2MXAgTo7UfQp1MkFaMFcRlS+vyE/6rw/Mn/VpWuJp3N
         JETK06m6C8UTxZxjVMsd1Cg6mpJZwgChIcsqmUAK8gs32cNQoI7Ugv32HgdBYOXF7rHr
         ++ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712391920; x=1712996720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBJNfaYHzuiXuMZUpgDPs9xtiQNCWuPWeZpuB9UBK3o=;
        b=hkekcRCRVzm7CQ2trOXUm9ED+EgSso6TDFZn6NtAnyOVtO+wz3BStGfPnTTxxMtvih
         2vJ6X1UTJUiaQwpi6drqrtx93ND5Y0vQmSGCqS03gqhxPgfPasbYqpr6KNsfu0jMdUME
         kZ/xdXR21WBNqXQoiMQkJGTKAWNzVWouFhZ/yI/w40LcetUc7dy05d0NZH18HSf0Xcd+
         MRd0EpCp6YrpMheMVE5cxFoIEZvxj5QwvpDKjcXHo1X3/fU23tZ/+JYFbHoa4znhMMJW
         jycqfF8VeaRW39mL5BBH8s7QfmaWTtZJ2lxXIBLXghBp0zBUzS1PyT+gFrw7+POteZpb
         O6oA==
X-Forwarded-Encrypted: i=1; AJvYcCXuOJ2FfX497enNHqoWBzrtTSDaqDvHvNN8elTdrzdleFzL1N39NhpTteTmgKc0x+v9otxgQk/P6LKKZkSQbXxMoC+UOUlb/0d090HPNt9A
X-Gm-Message-State: AOJu0YyAbDv+rkBWdfNyytLy7E5ahT+OPGwnNEOHUbGUT3HXc+xbpMEy
	O0ucN1Z0wC9ZhF/a/2Y+6+yPgqCfQdO0i+KfKbVOnz4UNXXbDjA1LcBRLiF+b/I=
X-Google-Smtp-Source: AGHT+IErFMsFHaLT/wvJseM7VLt7L5c4EEUPJNvPHKcBFR7A7uLC4IE0vs6uWbJXA8BJb/8NdN1U/g==
X-Received: by 2002:a05:600c:1c13:b0:416:3de5:1364 with SMTP id j19-20020a05600c1c1300b004163de51364mr437857wms.18.1712391919991;
        Sat, 06 Apr 2024 01:25:19 -0700 (PDT)
Received: from f1.redhat.com ([2a06:c701:46c7:8900:15f8:24e1:258e:dbd5])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b00416244a53b8sm5794220wmo.4.2024.04.06.01.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 01:25:19 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH] net: change maximum number of UDP segments to 128
Date: Sat,  6 Apr 2024 11:25:13 +0300
Message-Id: <20240406082513.78692-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier commit fc8b2a619469378 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
added check of potential number of UDP segment vs UDP_MAX_SEGMENTS
in linux/virtio_net.h.
After this change certification test of USO guest-to-guest
transmit on Windows driver for virtio-net device fails,
for example with packet size of ~64K and mss of 536 bytes.
In general the USO should not be more restrictive than TSO.
Indeed, in case of unreasonably small mss a lot of segments
can cause queue overflow and packet loss on the destination.
Limit of 128 segments is good for any practical purpose,
with minimal meaningful mss of 536 the maximal UDP packet will
be divided to ~120 segments.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/linux/udp.h                  | 2 +-
 tools/testing/selftests/net/udpgso.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3748e82b627b..7e75ccdf25fe 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -108,7 +108,7 @@ struct udp_sock {
 #define udp_assign_bit(nr, sk, val)		\
 	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
 
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 
 #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
 
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 1d975bf52af3..85b3baa3f7f3 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -34,7 +34,7 @@
 #endif
 
 #ifndef UDP_MAX_SEGMENTS
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 #endif
 
 #define CONST_MTU_TEST	1500
-- 
2.34.3


