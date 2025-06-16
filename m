Return-Path: <linux-kselftest+bounces-35120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD0ADB7A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917073B4009
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211528981C;
	Mon, 16 Jun 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE+u/5Az"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB392BF016;
	Mon, 16 Jun 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093813; cv=none; b=uwLmomWGSA8g5Ts7+JBkWt9UMjdChWP346qpMoQzKqSpK8jdhSN7ITjWoODxPfinhard2VmdHCCt5Jzf5Z+MiGbMyT1OOG+TdVuK1Oqcc6Ihq6iT3E0k+n5X31DiAggCifF3VBV9l0R1zYFt00H0/4lqXTBUVzP2xL2/olxZOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093813; c=relaxed/simple;
	bh=6QEznI5dDLWlKvkkHo/QuzqxbGMfjbjAro9UR7sEabw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGr2JNHrsVTcCrk7FosWyPskt92E0iGbxKpBkQC4RzU/9pdxLlYQQr1AbKIPWp7dpeYtRm1cn8PHaQB5iHp0xDBCtLpWB/awyJAtp0j/ubk7EitpIyBMe6FXwEimuk8BdMEkmP27KlfYUm0eG1889nfIvLBhP56xWiL6a5BvSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE+u/5Az; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d094f67777so98050285a.1;
        Mon, 16 Jun 2025 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093811; x=1750698611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWTHHniH+bU9oQ9NHxDCHqm92WzrmLWSDAFi+6Fga6c=;
        b=TE+u/5AzufUMSs6DQF/zIe7q9U/Gr/9qwZYO5iM5lPwDJR/N98AwL/ScD/q55lyac+
         9IG5QHwuLh79Mg3NFiUibTyAYgFR5mqcaVo1xWKGaDpx7VBax20bI/E3FUNOuMgp/Abo
         8VSyqVsPBOlefT3lB8TqTRqpChoOOYnRph6s5d/7KGMsj/VYfvlHdPT6Z+iH5bRIHQh2
         G1cFediAdUiBJqWvHFKjTXJg2z+8A+vqEM2mKlomtMGLWXerHAltFygRZdmNVMchwGFx
         iq1qQ1tdlHiNKayt1JkuSm8FjdpitM35bFrRGHgBbRCn1U9/QcSZhkhhRMFD2HVWeXar
         VFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093811; x=1750698611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWTHHniH+bU9oQ9NHxDCHqm92WzrmLWSDAFi+6Fga6c=;
        b=vR/ryuODuZh1JU2KFoLyC0SWSJl5HHgDZqtjBN8fs1DpNHqDitPPRSR0E/i05Kldmc
         gVIJzR+Tz9eQ455yJTeUYKZxoaxDwGqHqSjOFswlfbsU4AaH3tZqVdd6tJ0PZJJ10xv4
         yzUlKiKsOYgwfmBTjxsVGjJ303UX2pifnkacNwvrXraVrHyknLHB/2VMykdGp4T83hyN
         sgss0fpz7rVO3jB6UaxmkYJtcc52fvWgLURKzcSOfGXLLDwp+fguscPOckDKCNBQTbCK
         dPe9GAhgLdo6ope+yn1OJWYObtW0su+eOE/J/HLF6J/lw7inE58QiaO8jtk7PDh9djNH
         GZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/nlfoQ0IjTyjKnMt8ArK8Pp7CXbdA4IY6SCc0gNZId78XyiX5EV5+GqmN9EPTgW/Cv+2jTO7Yr6TzrxK@vger.kernel.org, AJvYcCWWanTQltftHuivdMS4OPKyJ7rEVN91AI68q1LjiuePupYhpOxrxaXFeWkbGgpqfqryI6FViQnPNi7/5LfUt7ey@vger.kernel.org, AJvYcCX51Ic7w+NniMbxWMgFc6x/7qwFMo+PMPbkj8sRLyg5eBOZEdUER9yg1Io0n4Hevi403eAcmjU3FF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YYUZqqwDknIYhbFTU/LP+zyHOwlv63cNR3bIF9y3RDPnqE0N
	GK3jkEm/xoV0gg6MNhMLOzh/J/XVjBF9Rw6njICNGeaUcFwl0Z66+28VYtGs4wXRz20=
X-Gm-Gg: ASbGncsh8nZlLZd6wkLHsVaStFpcb1LFpI7pdYTZvHV2crHVv4ntMDXcrPBm20bM74D
	s2H4s9KuB2QANZjPBUcKGBTT7N6M6TDLYzPtb8o7zaDKiKaRMwcJ+Pd7EPlXp33gCem0FJ1pInh
	rpjOhhH3nZFKUkyz3pXxA5DlDOZ9SMMfm5J/GcFjYuLkGLPGAq3JW1C3uRrj/nmboFp4zHtfrT4
	V/HKIG9JX19W3ZxkWGi44sg9+1WD6ikyKcVU4VrkRn9kHwxKfQKj9xMn8Niz83oQSgHd8nOMqu0
	Po7D7H+nZCGFHW2oV56VnQc/HeNL0GqnSHLv607NklWXKbVxBicxHr8py9crwaow/g==
X-Google-Smtp-Source: AGHT+IHlQ8QZJbkF5GAqftCl6EGNscf+S4SIKCVSErUg5r/DpUZTbk82Tml3X7EBCIGWkskgG3nSOw==
X-Received: by 2002:a05:6214:3211:b0:6fa:ed8e:372c with SMTP id 6a1803df08f44-6fb5b1ac9eemr3164046d6.1.1750093811069;
        Mon, 16 Jun 2025 10:10:11 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:4::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20f35sm53562036d6.8.2025.06.16.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:10:10 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 16 Jun 2025 10:08:38 -0700
Subject: [PATCH net-next v3 4/5] selftests: netconsole: Add tests for
 'msgid' feature in sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-netconsole-msgid-v3-4-4d2610577571@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
In-Reply-To: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
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


