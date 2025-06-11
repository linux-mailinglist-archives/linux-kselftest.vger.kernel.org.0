Return-Path: <linux-kselftest+bounces-34730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6CFAD58F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA71A3A502B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1422BE7DC;
	Wed, 11 Jun 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaFE6AvY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AB27815B;
	Wed, 11 Jun 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652677; cv=none; b=C5GS9xYAQsTaBXokh1RVmRiW2k/fCx+qwCpYKqPRUa3p7zP/EuvrcVaD5lHpZvHTuRIB4BqjRQ6GI+jlr6WjncpPolEC/j5JKY1XnrN5EEBXg/kntLvySrCDgA4bq38GvuqVQFCR6AO/1HG4vNkN3nuHIbrkgpRILADLxE7RBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652677; c=relaxed/simple;
	bh=6QEznI5dDLWlKvkkHo/QuzqxbGMfjbjAro9UR7sEabw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vC8dBNwEZ/KctaE5orIZKkOIlikTKXloadVffbo9yPhgLUeu3KA/kcrwBooDSBUf4fYdH4ENsRb9oK0tw+jIdeqCnsZ8O934YelHVGgRoE5C1Jrm/OBNMQiVZpU5dRdsy6EJLXktaVOKT4hkSCx4TE4E3c2lm8cX4lLbvWeHc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaFE6AvY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a5901854e3so592711cf.3;
        Wed, 11 Jun 2025 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652674; x=1750257474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWTHHniH+bU9oQ9NHxDCHqm92WzrmLWSDAFi+6Fga6c=;
        b=jaFE6AvYz2dJTlkvbuKo3C4VfF+Ooj27hEryW8eU2Ymx8YMyBhBy24EUZtAbgb/E9B
         BUvDTwy1M41LyReGZn48M8cDpWjb3SjXPePBl5TqX7dBxUgCJ/48Jq2aqGqKJ9TJcs3x
         gL47ZXOejE6dmkXvyZRR6bCU7yGesWQwkzJ7rEvc2WsOEn2QE1FrtsWoTQ1yGDWT+1pb
         UUimyyQKNDORSwWXT7XMV0eqbjvdUmHgNCCnoynF5Nqykwsuh2CyRhSp7z9DN4i2PZTh
         pLo4JnpXi9jzFvtk9O1KYh+LJBHOvaXLVR+RAfurrviLMsb1To0Ipw6TLBGqaArxMQEo
         lMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652674; x=1750257474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWTHHniH+bU9oQ9NHxDCHqm92WzrmLWSDAFi+6Fga6c=;
        b=Yv5eMoWL9apqaT20E3kqKAGi2pArnrUJ4OPEuhFnnwLnA9b6SbbPEp2WfAZFX5AWek
         sT6vMyunrvyxFfnU/nOrcIIDMlCxSqCwTLG1qr6HlnIvkFWsW1eUMQNCLDAdzju14sIb
         MoEpBBHLb0bDnCQVj89KrhSJVFJwSbE3oMGfEzj/jbKzqYjlxlNJVSfTOJoy/TyHu9U7
         sxheQzfp8riG7wx3YYvjXik33rZcH0qXd3sJ9hfXIh+uQvngm1k6uzyjZjjp2zBAWPg8
         IUPw3nFZ2kkqZ/qPx0N5nCFiUIG2Wajz6By7xM4noAxo/VhNzqtnta3uEhpAbrOoITLR
         ZvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Vi1kt82T8n+9OrCiHlAH9P0B96RQaJOBksUFKjwbrVHMKV0UZiALRRHDuHcHbiS5nV/yrCeKS2RaaDcl@vger.kernel.org, AJvYcCVtPraL4mmjR7BRqPYIuomNeqMqS7SchpqrCRjiKnPgtX0sn16xN+bJFXPA2cb4RKjju1IpYOz13jykXLADC4fx@vger.kernel.org, AJvYcCWOeKON0GSw/5ey7kRQ4tuI7SpWy3rsSFVUZqoTJ50/QH0UrgygI1bdfbw03g/7Kx+8682GWunbAcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6PdenEzxDpVlHsdxOAoX+aTOs3Dte3whWtYXufFkpcL5tyne
	mkC/vMDPbUilgsxNG/ZoVV93HT0tnEEEv1ojz98tLdiAHHGx4MWQuItZDa3pxol5UfA=
X-Gm-Gg: ASbGncs+H9itNFPlwua0oPIDDLPH7bqbpc2nz6snGi9F88K3kUust6O+5irJ7G3JNER
	gAh33t3IamjwrWJvgANeX+5H4qRzUPep+8Y7DSl2zWYJiZfmxh6bjeVbIxcFbnRb2AQPt3JP9wm
	3rqb5uvT6aHl0wG3y14R+nH0OmRnAg+tlYPH3VIkQ9hmoc4cjc+8z/vGdtdM+D8pqsJ7Z+jht4G
	dZLrcnq29dV+Wj4CSJaJM31X/4Y1RZL+1qF+ctXmhMm0KQkeOFc3v6y1W0Ew7yv/fPvtEmNbr9k
	M1yxz5byo2AB3mdR7p/IN2QhCx/ebCh4ESYOEcvv05kNSMS57RFSUqgz
X-Google-Smtp-Source: AGHT+IGpoQb1VZnYZFkyUPWRdqFbZp2QlhkzTSMnfG7PGjcKk2oqkZ6BSv2d7fW+qfiyp5LbxQ0IJg==
X-Received: by 2002:ac8:7f52:0:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4a713c2128cmr21232271cf.10.1749652673543;
        Wed, 11 Jun 2025 07:37:53 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:7d::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619894b05sm87327141cf.75.2025.06.11.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:37:53 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 11 Jun 2025 07:36:06 -0700
Subject: [PATCH net-next 4/5] selftests: netconsole: Add tests for 'msgid'
 feature in sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netconsole-msgid-v1-4-1784a51feb1e@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
In-Reply-To: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
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


