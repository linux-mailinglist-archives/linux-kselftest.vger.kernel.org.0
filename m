Return-Path: <linux-kselftest+bounces-22835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD59E3FE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E216437C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38120E00B;
	Wed,  4 Dec 2024 16:41:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97A20DD66;
	Wed,  4 Dec 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330464; cv=none; b=RQv3ZvKW5jN6PgT8PZHSZTUIW2UKE6i76T+Wpv9un5H+3ZRzZFxTiSjQu7rzfVPodiAmp8IEQuZfAf4r7bxdbhZokmntD/92CqTmnR3LZj0TG9/r2B7Jhi0V1/FnqIbWQPcP9iZAUKHOsdsaQcGSQ/1OLtp+Njrrpei9nJuAngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330464; c=relaxed/simple;
	bh=jqv6quzS+t5dQGxDInZsb8SJ7DLV2oz6qpzinEOXBKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRYcuyjYk3bnLpd0Qy3AARs1FU9eqaSidzeKa8toXGuVdIH1hNHsHyrnBCRi3sUG1/A00nlK5qQCea+4SSXvykcsh9TWjuTDqKumO5tasoZok/AZpcOCWJwOUOuI4URllna3jn97lvJ2RnXgmaUZCS5lzboe/ccrSAv6OBIv0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso985660366b.2;
        Wed, 04 Dec 2024 08:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330461; x=1733935261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNlLMLrY7ZdfreOo5yiUeo8bDc7WwerZARy2ex9nAhs=;
        b=bkRbXrovMTnhDo/ugZG4ClIjmCRHm11WpB3GU6KSVsqq7SE+Zc8ZyQxorGpy6Bvy72
         Ha8ahAMSc2+zCSBIt51U1hNxmsppVptx+Jctws1HKUVZhveRQPE+2v1cLFLWibwT7p13
         zUAPHL6A+vdU1zp3gQvXrzeGMMFcFnr29pg7d3WnIT0pKkHJkHvbsq+KZuXuvHKC7m9s
         1PaLNhAqkGCf9ZdbTcLONothutuRwKdn8YXX25XzreShjNChvGP1HIV86LwczKHkK+pg
         eaoDJLaHjognc1JNNZWuSQXTWRhn0MFjjlTBtr/D6fBzfev2q672K7GBnYfoN6zpJZiB
         WrLw==
X-Forwarded-Encrypted: i=1; AJvYcCVAb3tdN6pWUFc2CPjhCigXErDVIlD+Hkzr6nLbgFFfnnKlw8+leBnsb4u2G3virk4EswbGNUD2WtCFeR4VNV2K@vger.kernel.org, AJvYcCWXJwYQWhtH+wAmMGK6sK5STVov9WgZ/V4HzbxBkuJ51rN/mW2n8pzJJAc+qdLXOxKBOuszZvGPHgcAwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywba8Z6/9sdeq2PF0AcLZbx7Wz3iljUNHgL80EA0PIxofOrGnGH
	4t3MkGTF5OfwoSfjAOQ0I5QQ9TIBIOO72H4xdCsAmkRrwbH4ibd0
X-Gm-Gg: ASbGnctwoo5FkdU0dOzZwJJyesGSGwoWf7+YDxsl4PsfUj9lko1lhmmHI282Xu+GyUM
	T8IHc1689QAFJ5hlc6Tx61Cbfp9GSSjnByOo/T82bzlDgpS/mKHb3aEidiuUUUHNqMX7Q36YAj1
	eQ2SsKpEELg6S2zRm2lEO3E9rBu/QRo1y1BextP9iuk30IyvVqQlnYVYVyxZAAudQxdFgSduukv
	R8EqeTPYY9LEW88P7CJcDMLxM+deqYysI7TWXXr8BqQ7pPWXy/DcxtXSBtSGxpiOzxnm8LF1hK/
	fA==
X-Google-Smtp-Source: AGHT+IEO+OSlAxFAqaLTZCaUND+HFxd0UiHFbMhHTVi6kYxV4hCnTX5VZ8sCvvsqwWXQwsacUtVsBw==
X-Received: by 2002:a17:906:32c2:b0:aa5:4982:abca with SMTP id a640c23a62f3a-aa5f7dbd8dcmr588139666b.25.1733330460604;
        Wed, 04 Dec 2024 08:41:00 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d40e9sm747153866b.78.2024.12.04.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:41:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Dec 2024 08:40:44 -0800
Subject: [PATCH net-next 3/4] netconsole: selftest: Delete all userdata
 keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-netcons_overflow_test-v1-3-a85a8d0ace21@debian.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
In-Reply-To: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=leitao@debian.org;
 h=from:subject:message-id; bh=jqv6quzS+t5dQGxDInZsb8SJ7DLV2oz6qpzinEOXBKY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnUIYVQbbOwSTL+EokYvsUJewtdhNm5vfM+05aL
 juXhZhi2LyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ1CGFQAKCRA1o5Of/Hh3
 bXMHD/9i8eqprJvV+FyTNZH6qA5YEBuyMCrkciPrwsrYHPIrwNg3fXG/Rbses8i1Wf0ZZ1AR5s/
 /M4M/rF8pGGpQti8DdoLujQKpr2W3fiv/jM/zz29AUZQUS7tv0O9rpq6R2yj5IwgCv9/j48Vgvx
 Z/JhZ8/1SZm2ZWVa2gEXV/qP1Bcf8Nbi1v2cnFwuoCdGKBSxQEcdBG/QznCYi6/Q7nZoxu6lXqV
 f1yHMoOKzTiodybFdTp82PQOEXeB6Ea84NeHhrvgcZTS86fjEUUQ4RvRaz2QXGXLCIvUelvFA13
 p0gW88WDpFkuezWI4jxwIsFKpxthYfd8GePvpmFCTjCmPmW9/w8UQ541IvbEYX23TNAiV3SFXbK
 v4j76Y6i8uzwnBKVWY6u/O6cTa+rdDSd9Zb01MEnylGp3aQd1hVtUdgJXLbJkPUKpArw1IEXKuu
 4bypGCh3Tsu9HuVVK0c/nfCQAeqRoRKqMXRcQAvAq3ZcUjjOVd2eMTz14+E4G8ZFp+CulJ64k4u
 n5qhtZFj9XiJo1Y8uu1GYKJ/1UARW7seHtrg8ZIBVjB3XJHawYU8w1T1/MbNJwISiXPnpeFVgrO
 6B20I5ff0j7baVKWDmg8FNutF8Jpd5e0KxxiUJqdyufFXWxCjszsMSe+qLFiw+VnnuAgX+rMso4
 0HjnAsH7jxkFvSA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify the cleanup function to remove all userdata keys created during the
test, instead of just deleting a single predefined key. This ensures a
more thorough cleanup of temporary resources.

Move the KEY_PATH variable definition inside the set_user_data function
to reduce global variables and improve encapsulation. The KEY_PATH
variable is now dynamically created when setting user data.

This change has no effect on the current test, while improving an
upcoming test that would create several userdata entries.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index fdd45a3468f17449eeb66d9a808b7a3b2107e47c..3acaba41ac7b21aa2fd8457ed640a5ac8a41bc12 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -23,7 +23,6 @@ TARGET=$(mktemp -u netcons_XXXXX)
 DEFAULT_PRINTK_VALUES=$(cat /proc/sys/kernel/printk)
 NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
 NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
-KEY_PATH="${NETCONS_PATH}/userdata/${USERDATA_KEY}"
 # NAMESPACE will be populated by setup_ns with a random value
 NAMESPACE=""
 
@@ -116,8 +115,8 @@ function cleanup() {
 
 	# delete netconsole dynamic reconfiguration
 	echo 0 > "${NETCONS_PATH}"/enabled
-	# Remove key
-	rmdir "${KEY_PATH}"
+	# Remove all the keys that got created during the selftest
+	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
 	rmdir "${NETCONS_PATH}"
 
@@ -139,6 +138,7 @@ function set_user_data() {
 		exit "${ksft_skip}"
 	fi
 
+	KEY_PATH="${NETCONS_PATH}/userdata/${USERDATA_KEY}"
 	mkdir -p "${KEY_PATH}"
 	VALUE_PATH="${KEY_PATH}""/value"
 	echo "${USERDATA_VALUE}" > "${VALUE_PATH}"

-- 
2.43.5


