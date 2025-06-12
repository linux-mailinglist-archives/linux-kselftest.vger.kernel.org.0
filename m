Return-Path: <linux-kselftest+bounces-34843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD31AD7BD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B281898340
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D22E62BB;
	Thu, 12 Jun 2025 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyeH2gaM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01982E6115;
	Thu, 12 Jun 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758608; cv=none; b=ei1snKGGfG5EtxFpbeD+FX8MYPKQ6sjHu6KJCDD1l5CWE/Wd5TAS0yqiCTv8u9yOdx0GhnpjsBazWy2iAQCLfNB3INp0vmJStUZEMF1jgXSWu0b2OcDxUZvlD+Kw+1YeAGAj809KsPhcJcLCHuWoF970NLa8mwh/y7oOq1d+4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758608; c=relaxed/simple;
	bh=6QEznI5dDLWlKvkkHo/QuzqxbGMfjbjAro9UR7sEabw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NI+owrPHYsgehc7d6s5s0GPmubdKmAqpqHQUxCedRdxAOvZqebaf8WynJmtiNjZxv6B+7cvnosOlpPK5WBZCzQRpte6a3kAQx/iwJYktrKHDtV5598xurWSH+enFfEcb93qXHMDla51sWvv7LuH9ytj578q9q9ekhRQpKu2gLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyeH2gaM; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a5901854e3so1979561cf.3;
        Thu, 12 Jun 2025 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758606; x=1750363406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWTHHniH+bU9oQ9NHxDCHqm92WzrmLWSDAFi+6Fga6c=;
        b=jyeH2gaMsM0nnCQtSp86xsfS9ZWvYfVYp8vsXHi5xMUzNMr4Tc6eVgSQ1c76me2AZC
         n9C9iQFlAoclb22F5YPWC7nND44Kf9ImjigWYQZf13QQUPDLjZ71MMLoZwA8gN0D3ekv
         ZSyWv3znNCZ31wjdJoC8w2PfoPQW9tWXBZJHhWa2DnCovmYB8KUIHB2IhJvCbrSBh3wQ
         epWGWpE2UnfP0pdvHnmr6lQSJqMqpW17Y4MWO17A6W+QSfJkR8WIxBRjL+gP4wiSRBfG
         iPRzcMi7v46dsfyoCNmAv6wbRzuIb7nekLbxQhj23KnrwsvPqlhAA6FKeLW8A2m3zQ2T
         1PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758606; x=1750363406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWTHHniH+bU9oQ9NHxDCHqm92WzrmLWSDAFi+6Fga6c=;
        b=Xxev6XffAq4eYW2rQd4xofMWwCFUKrCnpH2NmMDnStJuoJ2g5zLNBdYT9a6xoArLVY
         Dmjr51gHlLq763QeBDkgDdNHIraRI5K4Whmvr90aDuI1LdZ9DltWI66e/1Rvnui4ZAD/
         kyw2N6lXOcvdz/TLrlX2k/wF4mSLukPzEambb1A6L5sP/EBST66ZP79UnI+PI2poQQfc
         3+0HvNVtsuSz2Os/k3031QLnJVhJwFDrGV/KOZOAdveko+ndLb75rfyjYc0BbDTSxMtF
         TLlrAzIGnKLNXd4qqMOnAWFw4QZfTKkmljgCmvmXMMytpoAcPNIJX5ZrMzP5aaLBYkMt
         c4vw==
X-Forwarded-Encrypted: i=1; AJvYcCUt7gZa0loHJXgpsgetH0crHURCxKkche9Q/EA3FHxUxsK38tNjuCHfpORo+IR7lgrWO+qURdkG5SCaGJeQ@vger.kernel.org, AJvYcCW9KvhN2ysAADj194ulkgTe72igi7OST+DUwbUNVP/Kw2H7wHRdDwp+uTiK+3HHz5IHKdlmSzMyX2zQxMpjDWHT@vger.kernel.org, AJvYcCXJvQjc8hjRHyRHB+o1G05rcB1TyLn0MfyQ0QnG5Rjqon4HhA7yqI5hd2H0l+Ne9cG7m5wpFnCZ0rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qmJict2qd7mClVpWrajjcT+Yg04cWAsPCqDxq878CJ35C43C
	8uGT+TdAHLQe0xwDy/Fe6A9AbtUb1+bVqSQOT0r7HVwH2wCAfSEpm02E
X-Gm-Gg: ASbGncsX18Qhzt7gqAUgQDee+nUyvSb/R1uPBL3sMCi6XCEGbK15aHSdhfE0BMOna2P
	4Bhox3PsQ6Z7zxDg6wh3IyAhCcfIDnW0mcWqOkipsfoDEmta7HarqEc/lkU7UgykKqkuo0x6t8+
	VcpHdsdmJVBDYy9YdMn3zTHgNzecjKkl4VDUVA6N94vfZE/Ym76owKUc4DqvCdfol5hHz6BCmlZ
	gu6oGqRNCe81821ShjgNpGR6COQsBcc/o96BIu1+Bt7J5OiJJ1yH2MZfIqtHcU5qJw2CxW4aRwM
	RYDoEbpdwWORoJic8g43ew5KDjSz4oSdhR4IYn+25dLyQXcB/p9Z2mmq
X-Google-Smtp-Source: AGHT+IEXlJsA9JHwVKpKYyaVQkMwIEHESKyeUJ+v8mSb720LphVg12UBG50EL+NjcnbhGF9OR1DQOQ==
X-Received: by 2002:a05:6214:c8d:b0:6f8:daec:8b7c with SMTP id 6a1803df08f44-6fb3e602161mr1169246d6.6.1749758605749;
        Thu, 12 Jun 2025 13:03:25 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c7ba2fsm13418386d6.104.2025.06.12.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:03:25 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Jun 2025 13:02:17 -0700
Subject: [PATCH net-next v2 4/5] selftests: netconsole: Add tests for
 'msgid' feature in sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-netconsole-msgid-v2-4-d4c1abc84bac@gmail.com>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
In-Reply-To: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Extend the self-tests to cover the 'msgid' feature in sysdata.

Verify that msgid is appended to the message when the feature is enabled
and that it is not appended when the feature is disabled.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 .../selftests/drivers/net/netcons_sysdata.sh       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netcons_sysdata.sh b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
index a737e377bf08..baf69031089e 100755
--- a/tools/testing/selftests/drivers/net/netcons_sysdata.sh
+++ b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
@@ -53,6 +53,17 @@ function set_release() {
 	echo 1 > "${NETCONS_PATH}/userdata/release_enabled"
 }
 
+# Enable the msgid to be appended to sysdata
+function set_msgid() {
+	if [[ ! -f "${NETCONS_PATH}/userdata/msgid_enabled" ]]
+	then
+		echo "Not able to enable msgid sysdata append. Configfs not available in ${NETCONS_PATH}/userdata/msgid_enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	echo 1 > "${NETCONS_PATH}/userdata/msgid_enabled"
+}
+
 # Disable the sysdata cpu_nr feature
 function unset_cpu_nr() {
 	echo 0 > "${NETCONS_PATH}/userdata/cpu_nr_enabled"
@@ -67,6 +78,10 @@ function unset_release() {
 	echo 0 > "${NETCONS_PATH}/userdata/release_enabled"
 }
 
+function unset_msgid() {
+	echo 0 > "${NETCONS_PATH}/userdata/msgid_enabled"
+}
+
 # Test if MSG contains sysdata
 function validate_sysdata() {
 	# OUTPUT_FILE will contain something like:
@@ -74,6 +89,7 @@ function validate_sysdata() {
 	#  userdatakey=userdatavalue
 	#  cpu=X
 	#  taskname=<taskname>
+	#  msgid=<id>
 
 	# Echo is what this test uses to create the message. See runtest()
 	# function
@@ -104,6 +120,12 @@ function validate_sysdata() {
 		exit "${ksft_fail}"
 	fi
 
+	if ! grep -q "msgid=[0-9]\+$" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'msgid=<id>' not found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	rm "${OUTPUT_FILE}"
 	pkill_socat
 }
@@ -155,6 +177,12 @@ function validate_no_sysdata() {
 		exit "${ksft_fail}"
 	fi
 
+	if grep -q "msgid=" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'msgid=  found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	rm "${OUTPUT_FILE}"
 }
 
@@ -206,6 +234,7 @@ set_cpu_nr
 # Enable taskname to be appended to sysdata
 set_taskname
 set_release
+set_msgid
 runtest
 # Make sure the message was received in the dst part
 # and exit
@@ -235,6 +264,7 @@ MSG="Test #3 from CPU${CPU}"
 unset_cpu_nr
 unset_taskname
 unset_release
+unset_msgid
 runtest
 # At this time, cpu= shouldn't be present in the msg
 validate_no_sysdata

-- 
2.47.1


