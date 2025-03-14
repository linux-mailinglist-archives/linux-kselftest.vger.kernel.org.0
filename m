Return-Path: <linux-kselftest+bounces-29064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFDA618E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706373BAEEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E63205E30;
	Fri, 14 Mar 2025 18:00:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7F205ABC;
	Fri, 14 Mar 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975201; cv=none; b=O8ur3vc2cWKYcP5dNjSBdJrKYvV8GXBmvmHCs9Pe3fq19igVQ8IpU9RqKS/xE/AodnRgY+txIbeZgXFPzRZIVGciHCxIIFDF5Y3irTazQ9RYrvKiuCO3zWXoLuPhNcFbWNzbSSjOt4bQXP28XYsfv8YcBxqUxL4axpvRwiKzXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975201; c=relaxed/simple;
	bh=UipaB9hoJ9sM5A99ex+560BlTWBVYtNKkcy/qL7TVJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akC/DxqXG6JqtRVg70UL423fRtozs25FBBASTvDjfC/B3pRMdKULxSGZIarSaJi5lh9VbTilwwvVsc3fTlp/UgMFNxlh2WnzwVU5bwTxVHFcJpdNJn2Q3jLV5EsnImgEVTwJ7dwu0C3dt4eaKRNF1lOmhieZ12oOIfrWk1hCJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbb12bea54so475998666b.0;
        Fri, 14 Mar 2025 10:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975197; x=1742579997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zi5Ya6zVuc3o3JT7UrajdwgOkm0Us2iQ/oS82X6tSs=;
        b=WWRl8CqkD4TnH8wEhxGRF63yMk2RvNCu4Je0k8Vf4z71fhZM5sHS1KTmP1oZqBUNoY
         ds1Evt3rJEEZnt3Pc+KLcydJhiaZT+tXDzy0YOKLFfy9Jm+Vq+vTNDTroJ98oJJPMS9l
         o63gZu0ndXdbmdOt0KnCeLNE9jBGljzRFtbZ/2rJIfB34QZzX15dz0eElQNUOYz4RCDd
         0DYYUlNJhwdckzBs9lzx1JGd2x/eJzU7mJ056/nPg+EkQFRGeyqnajOMJo7epK4LEGlh
         hewhW+39F0o9GODC24bRaWzWxtPuuhodhUrEkXv80DsV+4RW3bdmztlrbob0k4zIaPUo
         FKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ajmA9/5v+0Te84YQ8OpX+y3KE41qNKF9xLzpcT+2eZ42lhf66293ndZzUp1prXtGRBelPEOfVqjmPYsQ@vger.kernel.org, AJvYcCVE3fF7Sb73VDv8cQGkg9l8kVrOfs5Dx1+KfJqPbodbKDBpWNX3U5TwA2yCNxQbd23Y5kAvX2ln9rzG7tE8E8wD@vger.kernel.org, AJvYcCXsmbtbHtXf+pt9FXg0IS5Iu8cEfWtq8ywdGqrl3Kz++7ctWrIh6eWBR5VsnWYerVZ9/4iAq9R5Rw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lICnUVUdzeT5F08A2TadS4NguUWqfv1J7y6/NYMsNIJtZO9p
	oKtVrfIzAopelglIXeo8USIhiS4pu4zZZxUdvnl+z44isWfoPxLVXRgldw==
X-Gm-Gg: ASbGncvr2ux104ed5eQXkazJk7lIrmLA37xXAzDxXssEUQgJb8epOpEK2aAWvRzs4Ns
	gtypPHkWB3tGEX6HCnE5S0STL8waoYhLD9aGzj4BMzicwkzlq2Vo+SZyuerb9kRfeOYFWH4iRtq
	RnXPYxHWs/XFpxoc1EGllXJZ/iinDq9IqiYgmQc6gdkGnYhkekhuDsBSQmd5THxXyzpaWtX/iAZ
	gIEY/gthZpJv/ejzSjwzyXFR+OeoB59cbk/FwyFhgR1/zgjwsrACNasX8yFNW6ENHSzcEAOHXbK
	z66Z3SegZSZ9sFDAB9WmT4fq7nYh7oWn1oM=
X-Google-Smtp-Source: AGHT+IFYSwyoRIkMY8R28iuiFyPTQOKqMHeVIyMj0cmy6Hyucv9clb9+g1mLe8JmnRF5H66i57J7rg==
X-Received: by 2002:a17:907:7d87:b0:ac1:e00c:a564 with SMTP id a640c23a62f3a-ac330397ccamr448558666b.38.1741975197448;
        Fri, 14 Mar 2025 10:59:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3f651sm250088166b.125.2025.03.14.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Mar 2025 10:58:49 -0700
Subject: [PATCH net-next 5/6] selftests: netconsole: Add tests for
 'release' feature in sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-netcons_release-v1-5-07979c4b86af@debian.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535; i=leitao@debian.org;
 h=from:subject:message-id; bh=UipaB9hoJ9sM5A99ex+560BlTWBVYtNKkcy/qL7TVJQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6S7hj423DEaSGHFSTeENNKhsWXvfeG0Ito/
 dBrtKGBbMiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bWTRD/0Sg5iDHe7VIi3WRYRp1CQEXxh/362toOluMWjUh/0YgXcHjK6QqirqlrPgxs4beYKbVyH
 HsONNBbeIN9BXHLstNP5PzrIWAlihgDVhyAmOvt5fGkyXd6rnhWPzSs4AWRTf7Ct6q9kUpulgA9
 jkejcFCkzqumIuIAHFp/IGX7DGo3SqQa/X/xYL+g2Zo/nwPWIBV/9TaZvjxMYFPsKkuPt2NVubC
 3F+qvTziB/GkHT7UT3W4zb/0ngadRJRc0R6X9JL7zCR4Wa5qrixiuR3q3FB3n0FBq/3DqcXLWBB
 peEl/Cr/iPou3ep8mEoqcWveuVabbUtKExNzUUZeVmLLw2wClyVQPAPf1P7TaG7JbTkamljZJvR
 e4gnXE3jOVl3p+doDYfa7qvbw77096BI3ekn9kyvOeTRaPvie7xzIuNm7org37+lyQV3p7Sw/Sv
 7HjeU0rzJ15iX8Mbxed7mgDFA3b96Dni/EkHiAGgpk5Ghi80Aqv3kXULCd3wYDJfubGoYJ9hZAs
 W4HEXIG10+3kuRImewiIbSN2lYx+du+EEEgM8ykQPkL1ZmCjkGy0zrxLzcavwR3cW6MpYKjv+VW
 w6DAVIIIjE/+bJCyl1zT2Ky+yOrYJlKV0wYVZuvsGUDw+BXFKXHO9vakOwLWHjB5T1Bc+F7FfIJ
 comUpbUr1lTYJwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Expands the self-tests to include the 'release' feature in
sysdata.

Verifies that enabling the 'release' feature appends the
correct data and ensures that disabling it functions as expected.

When enabled, the message should have an item similar to in the
userdata: `release=$(uname -r)`

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/netcons_sysdata.sh       | 44 ++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_sysdata.sh b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
index f351206ed1bda..a737e377bf085 100755
--- a/tools/testing/selftests/drivers/net/netcons_sysdata.sh
+++ b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
@@ -42,6 +42,17 @@ function set_taskname() {
 	echo 1 > "${NETCONS_PATH}/userdata/taskname_enabled"
 }
 
+# Enable the release to be appended to sysdata
+function set_release() {
+	if [[ ! -f "${NETCONS_PATH}/userdata/release_enabled" ]]
+	then
+		echo "Not able to enable release sysdata append. Configfs not available in ${NETCONS_PATH}/userdata/release_enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	echo 1 > "${NETCONS_PATH}/userdata/release_enabled"
+}
+
 # Disable the sysdata cpu_nr feature
 function unset_cpu_nr() {
 	echo 0 > "${NETCONS_PATH}/userdata/cpu_nr_enabled"
@@ -52,6 +63,10 @@ function unset_taskname() {
 	echo 0 > "${NETCONS_PATH}/userdata/taskname_enabled"
 }
 
+function unset_release() {
+	echo 0 > "${NETCONS_PATH}/userdata/release_enabled"
+}
+
 # Test if MSG contains sysdata
 function validate_sysdata() {
 	# OUTPUT_FILE will contain something like:
@@ -93,6 +108,21 @@ function validate_sysdata() {
 	pkill_socat
 }
 
+function validate_release() {
+	RELEASE=$(uname -r)
+
+	if [ ! -f "$OUTPUT_FILE" ]; then
+		echo "FAIL: File was not generated." >&2
+		exit "${ksft_fail}"
+	fi
+
+	if ! grep -q "release=${RELEASE}" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'release=${RELEASE}' not found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+}
+
 # Test if MSG content exists in OUTPUT_FILE but no `cpu=` and `taskname=`
 # strings
 function validate_no_sysdata() {
@@ -119,6 +149,12 @@ function validate_no_sysdata() {
 		exit "${ksft_fail}"
 	fi
 
+	if grep -q "release=" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'release=  found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	rm "${OUTPUT_FILE}"
 }
 
@@ -169,9 +205,11 @@ MSG="Test #1 from CPU${CPU}"
 set_cpu_nr
 # Enable taskname to be appended to sysdata
 set_taskname
+set_release
 runtest
 # Make sure the message was received in the dst part
 # and exit
+validate_release
 validate_sysdata
 
 #====================================================
@@ -184,19 +222,19 @@ OUTPUT_FILE="/tmp/${TARGET}_2"
 MSG="Test #2 from CPU${CPU}"
 set_user_data
 runtest
+validate_release
 validate_sysdata
 
 # ===================================================
 # TEST #3
-# Unset cpu_nr, so, no CPU should be appended.
-# userdata is still set
+# Unset all sysdata, fail if any userdata is set
 # ===================================================
 CPU=$((RANDOM % $(nproc)))
 OUTPUT_FILE="/tmp/${TARGET}_3"
 MSG="Test #3 from CPU${CPU}"
-# Enable the auto population of cpu_nr
 unset_cpu_nr
 unset_taskname
+unset_release
 runtest
 # At this time, cpu= shouldn't be present in the msg
 validate_no_sysdata

-- 
2.47.1


