Return-Path: <linux-kselftest+bounces-21949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF39C75B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E491A285EBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD79201262;
	Wed, 13 Nov 2024 15:11:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFF201036;
	Wed, 13 Nov 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510685; cv=none; b=YHy8NbPOkPGMn2ixNivEZHrVHqO+ucM368DesHX62OoqT1uQP/NyFXMwOiAqBmvPYoxyB3ibyY9250S4jUtymjpJu0a8ccD/30AH0TTdDuYK7SZufJyQ+aoeQGDUufxQ9tsDDboPK3leg4aOFL8nx3sF/9yJvIfHmtWAq9lzvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510685; c=relaxed/simple;
	bh=7wSSxIUiXUM5F3CnS/GS0ih6ZK6ssmZ3fx3f8y0jNi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzaqvfRx/jb+XDM15ZkPQDWC7maU9jqMnfDLNFuVnxw99MWJCBrnuJRZOa768nenrH7jLmda5fwXN0YuxYvyVhYP2Rkd0Y4o59cECHgKSsJtcPVLHLHY+v2tWQO9ph2pFdmHwuTf+lk3kJK4Mz7IoSqY00B2P3dampf2oMTikHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa1f1f2d508so185377566b.2;
        Wed, 13 Nov 2024 07:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510682; x=1732115482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxJL6/w7ib7tor6B/awKjwacI8QkLWn7spqQywUygr4=;
        b=T7hIDV4+icgtau/zZ/DMVhNWSUcjXpD6yNKrrTyCQh1JuIifz/GgBVwh4Ohmi/7Uaz
         15E5Ni34rDzseG9DxuRLxlFUBJFuqpwO+j5DwpUVx+GiJdT80q2EAT33+5SnTTXwPW6q
         EdKWsfF20FTZaQ11V2PoplhxL9a7W2+AkAN7jlRYLKG++e6lyVB2MPJH1PaTPr4jlUEC
         45/ZRpZmZaQc2F3V+TEyhYU68/BbXC4CmjiFpNUnv29kHMjVDpcHdHozG/7MBjt71zjw
         iJQGJnQ56zVT50NMfWxOit1T4TogWn/vFwQV81gjWtDnP/v6yLENpvdjtUBmF+Bv2G57
         bPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYEoqF8+0qwDEI4DL8KKPobYd2DOebmCbE2wxd/mHsVGr6KmR0uN+ir3hN7LbX0kOx8nOEM2yTwlAckGdRuMbs@vger.kernel.org, AJvYcCVkFUgNHgMu0zF0uEXKbQzR0C647JqglOBtl+5Cb/Hh7NoqXVZSmnf8twdM9gJUOwZIbNl4LrHnUmX3s+CH@vger.kernel.org, AJvYcCWdolYDYnLssxrwbHPFhCIhKCcC0Nx4e3NegcjJguwGLTQNsRLD3kImSIHI7SvkOCh+mXdeGhOi0f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxHhrpWiqxZaBoQCC7U8NWBM2JoWy4BUyu1jPT/z8ooPzhszL
	fjZWGlB3E9f0rMnxf3eb8FrE6WIHYaQs54u+zCj2S30Xhrlm6Qvb
X-Google-Smtp-Source: AGHT+IEoLyfigi2UbiHSBtCcn9AV7B2W8zEBzkfRzr2dXQX1hG/gGL44SEj+d1F3HrwKO/03w2g9Ag==
X-Received: by 2002:a17:907:944c:b0:a9a:8a4:e079 with SMTP id a640c23a62f3a-a9eeff44660mr2145146866b.31.1731510681944;
        Wed, 13 Nov 2024 07:11:21 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7cabbsm7293671a12.79.2024.11.13.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:11:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 Nov 2024 07:10:55 -0800
Subject: [PATCH net-next 4/4] netconsole: selftest: Validate CPU number
 auto-population in userdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-netcon_cpu-v1-4-d187bf7c0321@debian.org>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
In-Reply-To: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, thepacketgeek@gmail.com, 
 vlad.wing@gmail.com, davej@codemonkey.org.uk
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=leitao@debian.org;
 h=from:subject:message-id; bh=7wSSxIUiXUM5F3CnS/GS0ih6ZK6ssmZ3fx3f8y0jNi0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNMGOZOdLZzudSzkfczgpbLOO/6uj8tFPcG7Of
 HLb1ouaDDGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzTBjgAKCRA1o5Of/Hh3
 belgD/9MXc6rZacHAL5a6Pw8kYf5u9hon846XtxERP1sNGQjSjmWiMP2V0KfSMLk5ZvHoFKKcQR
 bpP9ExABuvB3TKLEPd5Foldv7UOybHnj+255l5mHYh8zBBsDDlj2r0KSkegI0+dRyJnom7L87+e
 B7QJGapMQOZiXWoVeuFPb4dlp/ls0f/ZMyIynfJC4VV/G/mnAIPjdQYE9XiQK9b5ISbxGL1EYds
 zLZA9vmS9sw75WXjIGrXBX86UFxtK1pZ1vDqDYxA61YFjucv8fYw/gQrGZQ7DJMFLljNuur1Qcs
 KhEqfNOMCSLJ1/zQbFlCDrB3dvJJREFS02hY+q7bWnygKouaOsZVTY2l9qiZsiSg+FIKuJ3ilWI
 3EXX3o163FxKuWTJOqRXv5/N9Pe5jEKYfhoQ6O12eYuDJoUKLj2pmx1GpxeG2zUdrJB+0GqFDWk
 U4m+hcSpOwcCXP3CLGfAC7DgmsIhYA5jmtXBQc8wpNt6UC/mZCQg/z1pqTF4sw/W71I4du91WO2
 cZCFn76yqO+5ZgSSqnWM/JelQE0IYWjCGFVPDL+vBZi+jceioXYMZLl4S1tBGo+/FIwFNA1Z+9I
 x+5FnBSn27Hb8LXecNdZiaMt+bXo+8LpZFsxZmfYte/n3jIbvbww6kFfhbEJdSRE3fRyOdWzgVR
 0gtaa+bvWxbtz2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Expand the existing netconsole selftest to verify the functionality of
the recently added CPU number auto-population feature in the netconsole
userdata.

The changes include enabling the "populate_cpu_nr" option on the
netconsole target before sending the test data, and validating that the
received data on the listener side contains a "cpu=" entry in the
userdata, indicating that the CPU number was successfully
auto-populated.

This addition to the netconsole selftest ensures that the new CPU number
auto-population feature works as expected and helps catch any
regressions in this functionality.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/netcons_basic.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index b175f4d966e5056ddb62e335f212c03e55f50fb0..92538a188f0696b3e54071d1d32c7b2e523db839 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -153,6 +153,16 @@ function set_user_data() {
 	echo "${USERDATA_VALUE}" > "${VALUE_PATH}"
 }
 
+function set_cpu_nr() {
+	if [[ ! -f "${NETCONS_PATH}""/userdata/populate_cpu_nr" ]]
+	then
+		echo "Populate CPU configfs path not available in ${NETCONS_PATH}/userdata/populate_cpu_nr" >&2
+		exit "${ksft_skip}"
+	fi
+
+	echo 1 > "${NETCONS_PATH}""/userdata/populate_cpu_nr"
+}
+
 function listen_port_and_save_to() {
 	local OUTPUT=${1}
 	# Just wait for 2 seconds
@@ -185,6 +195,12 @@ function validate_result() {
 		exit "${ksft_fail}"
 	fi
 
+	if ! grep -q "cpu=[0-9]\+" "${TMPFILENAME}"; then
+		echo "FAIL: 'cpu=' not found in ${TMPFILENAME}" >&2
+		cat "${TMPFILENAME}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	# Delete the file once it is validated, otherwise keep it
 	# for debugging purposes
 	rm "${TMPFILENAME}"
@@ -254,6 +270,8 @@ set_network
 create_dynamic_target
 # Set userdata "key" with the "value" value
 set_user_data
+# Auto populate CPU number
+set_cpu_nr
 # Listed for netconsole port inside the namespace and destination interface
 listen_port_and_save_to "${OUTPUT_FILE}" &
 # Wait for socat to start and listen to the port.

-- 
2.43.5


