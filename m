Return-Path: <linux-kselftest+bounces-37891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05AFB0F963
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C493A2747
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536CC22FE0F;
	Wed, 23 Jul 2025 17:35:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D3205AD7;
	Wed, 23 Jul 2025 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292115; cv=none; b=HOhRwhH6xaYQv8WlUkF7PkQvUAyW+yQG6AXVaUwN3VVn6xO+FWtg4Ma6dzLN62VkymiVLW1hyDODzfPaLOiPBlj5WvZjEoXGVReTPGRMcYE3m32Ab+mZbNDCrStfZxeqs92cONifsaT+u0R6xAMC/gUu7/HB8IGvBysaWVdmewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292115; c=relaxed/simple;
	bh=91INsPsdxBFFI/zWaMMYJeeLrvoDO/8ouWtSyEeaMI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RgS8fLGLyqGYGCw5NUncnwzrtrdzqlo8KP9atdH1jbTFg+Exdztde6JXB33ZXCEEDpAIIfy3cBxf+gmEDHWaO5eJyLzOVBqM4UaXK1PTSlVYPC+JQRBUyfJHCLLwt/0MXQ5uVliLSe6DW8XyYatwoyDDg232kK2rQACXEgqEFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so234371a12.3;
        Wed, 23 Jul 2025 10:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292112; x=1753896912;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5gvn9uX/JC0tC88L9529o6DxOpiDK/opniYSwWBROM=;
        b=IKxxaLkGPqYnlt61aq7G2BHbRwXJGIrmLzvjWE/hLx2xMQwgV7nsuwabL1T8yI3cAI
         2PX+lNqgG/YmP0IVDLWYTJLClvYN9ypXpJpsHxYw7M2Uox4J/dMc2YJ0CGtBWbDrCLWL
         80CQtmEZ+OhHlcf7rufvh6OsIVcO/WVT8YmddRIyLxgngE69qfNoN5lfQiJuGup7s1x7
         ZXAji4UEZ1pHt5EuJfnQMV3vnzB8cHZqZXeqQ0ztTAg0katmO3Mzm+tCrb1jiPNMevvT
         AGYvjvV+2tklrOmJ7HOWZ9+jUJzOEylcMa8zsXCPEuoO5NIHvTxcpvl9+uE3QYKjrkWN
         PbKA==
X-Forwarded-Encrypted: i=1; AJvYcCViOWGKQEsAQI0h1CSl98esPA4cQd6jHCLvXVkE00mhT/jyb4RcflQAACFoNVCnLIJ8MsSD0mr8tNkvvbqWva5b@vger.kernel.org, AJvYcCXjeofVeKZR7TkOE+RvhwUk1fECJ0Ifsz59Ddx+uxkfKUEl75Kj6mWVeD/tahYnev4i1fpZi9tywV0bmlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hr2gESho2UH7ce1WYKXNkkgKqubiuF02fkvD8x74tDi4Hais
	/lKq3CkLmcG+AlqBxBz13/4Oqm/0sKKd0trT5qQPThU4CErKuahkS5aI
X-Gm-Gg: ASbGncv7bfzrWoQ0HJmnoTyjGnqemAa31ObZx3YYo4r0jcxVwi0vVhmDtg1CjApQVOc
	IP9IoZmMylC3A5WjwAaDPSrdGhjES+pwSiCv/gHjr0J8k15oE8n37bo25mRDG1iFj4AUNywazCy
	N1mY6sDsRL/+HQRY0Q4k8CNxl/LYj8rqTfLEAQWTvtppRO7Leeu6aotMQZREvjcdRbxLlIT8ygb
	41vQw3ZRnTMV08wi2q4xK9fFh+K7rBccjIiJUncYXGKAnujkhWkdE3L+/d6xNtv/X4CG35ImUlu
	/vYm6cvvVKIfbI3hAqHy+lPLBJv9DeJzmpqolq2uHYbTHengqpFSb3gBchVBLEUM7F4SN+zSYWH
	0hPu09Ga9wUe4
X-Google-Smtp-Source: AGHT+IEWcerF29kCR6JtGb/wdgkYVXcfbLYSSC1q0GRr0Ci6DK3V/gCgMuOh7Ucf3ktD8rzKmH2M4g==
X-Received: by 2002:a17:906:fe44:b0:ae0:dd95:1991 with SMTP id a640c23a62f3a-af2f9384e0emr416186066b.51.1753292111594;
        Wed, 23 Jul 2025 10:35:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79cd11sm1071638966b.16.2025.07.23.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:35:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 23 Jul 2025 10:35:06 -0700
Subject: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
X-B4-Tracking: v=1; b=H4sIAEkdgWgC/x3MUQqDMAwG4KuE/9mCrajQq4whVuOWlyhNEEG8+
 2DfAb4bxlXYkOlG5VNMdkWm2BCW76wfDrIiE1Kb+nZMXVD2ZVebnM0nOc4hxL7EMg6lpC6iIRy
 VN7n+5wvKHpQvx/t5fsAmwHxtAAAA
X-Change-ID: 20250723-netcons_test_ipv6-15b1b76bb231
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=leitao@debian.org;
 h=from:subject:message-id; bh=91INsPsdxBFFI/zWaMMYJeeLrvoDO/8ouWtSyEeaMI8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogR1Or7XB6Pb9yrJnuHb+LoC6UxmDJI8ChlmYq
 CSjPwFBe4+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEdTgAKCRA1o5Of/Hh3
 bS+6D/4nbg9TaJD24jJMC88Sr39RPbJTDWg74mI+XXgrmZWMj+dZcGjzO9tyHfslkIHzIMs3Atd
 1MZyUv0qc3Mp1w40bf7PGAWrom8Dw3JFLouoXXlG+OBxjl0TcCdyUYbJJLAoKx3t0ASaKmZdFfK
 THrrzKR9uRpw0cwIE8Jao59rmDhwknGXKBFb6K8WDVybfimuuoSR4N12hbyYedgxWUu5tcusAjy
 Dv9Z8ej4WrnPJtVs7l3CFUz4hQtYFoInYY+SdATLbrWl9QSU6XJkVQh/nBhH7Ww0vkhmOd0q36o
 XLKp/yb0Mdi32jLwJW1AGjXsyuwu0MCwI6QTGqm/ez0Y5mdF9QrUxD1J6Coy0aaE1Q1n5oFVlmj
 x6oVvNA8NPd1K9FHAYeSfnmzw72NYILA9wGg9ZtGfXmS4v78CgykdvA/HrdvXbmOw/nshvHbodd
 DmRvk/z/n28bMcaGtw9uR17bguEsa1bSpdOvfjSPddK/l5+RayszCtSeD31+y4gRqFTGb1bcEE3
 eQ1zz1iRWYBrjP/Edxzfnqqaoug7bk7cd19/W5JayPr3AJy5sSI5YJGvzKqDCYwLYHYC3ADdBLr
 ddFYiz7S6s8oRUoybo6aujZafTS+YPfqIDXW1KB7/6ose9JfuKjv+h3ZhR1u8N/3Zqn8sTT/gv9
 lFAv7imFcVDzHaQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extend the `check_for_dependencies()` function in `lib_netcons.sh` to check
whether IPv6 is enabled by verifying the existence of
`/proc/net/if_inet6`. Having IPv6 is a now a dependency of netconsole
tests. If the file does not exist, the script will skip the test with an
appropriate message suggesting to verify if `CONFIG_IPV6` is enabled.

This prevents the test to misbehave if IPv6 is not configured.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 258af805497b4..b6071e80ebbb6 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -281,6 +281,11 @@ function check_for_dependencies() {
 		exit "${ksft_skip}"
 	fi
 
+	if [ ! -f /proc/net/if_inet6 ]; then
+		echo "SKIP: IPv6 not configured. Check if CONFIG_IPV6 is enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
 	if [ ! -f "${NSIM_DEV_SYS_NEW}" ]; then
 		echo "SKIP: file ${NSIM_DEV_SYS_NEW} does not exist. Check if CONFIG_NETDEVSIM is enabled" >&2
 		exit "${ksft_skip}"

---
base-commit: dd500e4aecf25e48e874ca7628697969df679493
change-id: 20250723-netcons_test_ipv6-15b1b76bb231

Best regards,
--  
Breno Leitao <leitao@debian.org>


