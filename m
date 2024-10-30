Return-Path: <linux-kselftest+bounces-21118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAC9B65DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7042F1F2495E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A381F9AA8;
	Wed, 30 Oct 2024 14:27:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8811F9423;
	Wed, 30 Oct 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298459; cv=none; b=L4pf68z3Dr4zjTURNpj7Tqvqx9YtC2sfsV6VOCgiNGXbALHGR51HM9Y3LCFJ9EVDE3LEB+4x5McUzU5Oa5Hyho9gXtjp0GGKDX0pgirh/cOUw3M/TLpi22bJPvIFhFIfoImyBS/7AK/EPZwq6ZbGWf1A3pNx0ACMuZ2T9l8LU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298459; c=relaxed/simple;
	bh=oFNEdZLPtcjUpbqtcRQsl/ELJcA51ONRPBDy5kQu3qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+9DT9P9TU7ycRiOznPJ3S5zl+uYwjqpewZ0Tk7Opc+OWiwSHsxWkdpIbLX72fhBIAHALpEaCHwfkEBdLdEeS+TzjnQ1/RGxtxuQs4mG4RT9VCkt+NUF0w7lrHkuy0B7R7RTU6GSXLqMREKX+UquNoJkRZhQ4PznjbiftUGU76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so4848951b3a.0;
        Wed, 30 Oct 2024 07:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298457; x=1730903257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MebxHJqXK6owyg4bREmStt7nVbsj68A52KHrJWNeIO4=;
        b=YxK3naE6kS/LlqtnIZXvVzxZKl/mbm8H216TbgHZYtYAt0DODRiY4wvtFtqYRkNM3q
         Q7C/lLVOZwdROcSncacyVPmdr7ohRR1rNUx7G/D9d6rfXxItc76N+UjsrUvQH1PeKR7j
         0f1qvCwtQLSwiMwedIKB0E/ipmAsyG2QExK5v3iKO+MoswNkX+3g/dMzTAOPM5p6Wrc3
         mJSmsmZCvNXGnxiN2ZQqGQ9tZeRlQeV7Obcg8NjX4aIleM64jlDTBRGHjZwTuZyl28k6
         C3SKLnWO5ui3ChL/jtN5xlkMlZcEgAXhAULRUdTglQXV/0v0twMlWcumwuf19eYufL9a
         ow/A==
X-Forwarded-Encrypted: i=1; AJvYcCWPH8dycwaZXqCYdBHgeTiKvjNcXDfYaTFpsH7scK6AzpBklYUYyefwh34BLRwwM5cl34Wdo+kk+qqnqBcjCPnW@vger.kernel.org, AJvYcCWrjdRS4Pb5uLwVhCs2o9Q0RGwoppVf+f/qDGs9PzmnBfBNZw1TaNZZ65YEpdXPbDXqPfdwO6Mv0VKdihA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2+Z8jx1xl+jU9JrKPPUZ/uElY1ARF1XWlY76XlgAdD47d1aN
	8UDHh3TUJVEIyXeYX+QLhb6NFgWYY7pwSpU6MBxS4GSPs5xwFb6PaKyZlmk=
X-Google-Smtp-Source: AGHT+IFf+tmAlRwEcCyViWcW+IoTTFcT2WOQzOSIcRvMn1akHgYmQJnJrFGtwNsZgIcV9kgtZKzF6g==
X-Received: by 2002:a05:6a00:3c87:b0:71e:21c:bf1b with SMTP id d2e1a72fcca58-72062fb2df2mr23094235b3a.14.1730298456897;
        Wed, 30 Oct 2024 07:27:36 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c2c9sm9252837b3a.196.2024.10.30.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:36 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Wed, 30 Oct 2024 07:27:20 -0700
Message-ID: <20241030142722.2901744-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used as a 'probe' mode in the selftest to check whether
the device supports the devmem or not. Use hard-coded queue layout
(two last queues) and prevent user from passing custom -q and/or -t.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index fe4d81ef1ca5..07a91516103a 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -76,7 +76,7 @@ static char *client_ip;
 static char *port;
 static size_t do_validation;
 static int start_queue = -1;
-static int num_queues = 1;
+static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -718,19 +718,31 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!server_ip)
-		error(1, 0, "Missing -s argument\n");
-
-	if (!port)
-		error(1, 0, "Missing -p argument\n");
-
 	if (!ifname)
 		error(1, 0, "Missing -f argument\n");
 
 	ifindex = if_nametoindex(ifname);
 
-	if (start_queue < 0) {
-		start_queue = rxq_num(ifindex) - 1;
+	if (!server_ip && !client_ip) {
+		if (start_queue < 0 && num_queues < 0) {
+			num_queues = rxq_num(ifindex);
+			if (num_queues < 0)
+				error(1, 0, "couldn't detect number of queues\n");
+			/* make sure can bind to multiple queues */
+			start_queue = num_queues / 2;
+			num_queues /= 2;
+		}
+
+		if (start_queue < 0 || num_queues < 0)
+			error(1, 0, "Both -t and -q are required\n");
+
+		run_devmem_tests();
+		return 0;
+	}
+
+	if (start_queue < 0 && num_queues < 0) {
+		num_queues = 1;
+		start_queue = rxq_num(ifindex) - num_queues;
 
 		if (start_queue < 0)
 			error(1, 0, "couldn't detect number of queues\n");
@@ -741,7 +753,17 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (start_queue < 0)
+		error(1, 0, "Missing -t argument\n");
+
+	if (num_queues < 0)
+		error(1, 0, "Missing -q argument\n");
+
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 	ret = is_server ? do_server(mem) : 1;
-- 
2.47.0


