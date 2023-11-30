Return-Path: <linux-kselftest+bounces-871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3A7FE806
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205792822F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C68154AB;
	Thu, 30 Nov 2023 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkhAQPs3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803B10C3;
	Wed, 29 Nov 2023 20:01:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b84e328327so285626b6e.2;
        Wed, 29 Nov 2023 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316917; x=1701921717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tslWZjJgd95/g1cWfyDnjS7aFLYM9YV+Bx4s7bEiQ0w=;
        b=DkhAQPs3ku61L09zZ6zfuazN2+bviMbKXwMi7SwcwHrcEwDTSD77NC/exxlAixYtQs
         25wwIJaJkBAdqOgLoz6X56kl6j1sCOYwUKVcyV9yChTALx4w9i6o8KaQO4CqvcSRQpHL
         L4lwXLSJsUYCeliXxtpIckw40kSvuqbDnUKsWzA+0feQ7yaQfy/gibDzBAKrbDOcJDiW
         NC/+B5/lgLYxuS/kcfx6KewhDiEsoInCmptyfL/2KtjOyCXGLsLHbGaPNW2urkCqglcH
         1vozPY8jKct4rsCXByIBBzVq0Ae9gue9G/fDJZx3X9i64HDbwQKzxKXf7bdcUxHhSX96
         nhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316917; x=1701921717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tslWZjJgd95/g1cWfyDnjS7aFLYM9YV+Bx4s7bEiQ0w=;
        b=ubPAIaCbAPnVfRIBni5/BAPMV9yx7AdqVz01WdzbSynrSN9vKQXDrliYwKhJY5g7fF
         Q3KDYuU4brJrPzNoKVNzWyVwgvlrsJI6Ib5LEAlwHCEPwmGgqlQiWCu+VEHFngIrF6fV
         eqrYZU3FjPE2ygTdyoa6tJt7pm+TSyFITQ/2lkIzpMweKJfnvPolicCFBzXl/FiIE+/4
         M2XFN79+yM9LX/ep7hBEUXo1EuU6x/XQx/f2wFvGPqxKfgmpGEBPUcWfSKC1VQqPURQQ
         BCELU6XE5jbESEqlOCowqvAk5NEO4k1aj5lSRV+aGgYko09L2lwhMh9VPbqXD7q5+qux
         xPkw==
X-Gm-Message-State: AOJu0YytRllulcgt7TBGos3rOv+xGhzWWAK4UTtC09F5dWzSQzIVzgK7
	bjfawAL4qbW+SJQcJvioqbIZanMg5xMCew==
X-Google-Smtp-Source: AGHT+IEriaWCRFyfNiDQo5m4epuOFxS9KvezY6zvToO8O3ABLKM8SLjyE9q/zS1JU4Xv0MOYcmwc0g==
X-Received: by 2002:a54:4885:0:b0:3b8:402c:7072 with SMTP id r5-20020a544885000000b003b8402c7072mr24527259oic.25.1701316917660;
        Wed, 29 Nov 2023 20:01:57 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:57 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 09/14] sleftests/net: convert icmp.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:01:00 +0800
Message-ID: <20231130040105.1265779-10-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./icmp.sh
OK

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/icmp.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/icmp.sh b/tools/testing/selftests/net/icmp.sh
index e4b04cd1644a..824cb0e35eff 100755
--- a/tools/testing/selftests/net/icmp.sh
+++ b/tools/testing/selftests/net/icmp.sh
@@ -18,8 +18,8 @@
 # that address space, so the kernel should substitute the dummy address
 # 192.0.0.8 defined in RFC7600.
 
-NS1=ns1
-NS2=ns2
+source lib.sh
+
 H1_IP=172.16.0.1/32
 H1_IP6=2001:db8:1::1
 RT1=172.16.1.0/24
@@ -32,15 +32,13 @@ TMPFILE=$(mktemp)
 cleanup()
 {
     rm -f "$TMPFILE"
-    ip netns del $NS1
-    ip netns del $NS2
+    cleanup_ns $NS1 $NS2
 }
 
 trap cleanup EXIT
 
 # Namespaces
-ip netns add $NS1
-ip netns add $NS2
+setup_ns NS1 NS2
 
 # Connectivity
 ip -netns $NS1 link add veth0 type veth peer name veth0 netns $NS2
-- 
2.41.0


