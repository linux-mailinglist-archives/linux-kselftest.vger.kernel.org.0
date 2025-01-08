Return-Path: <linux-kselftest+bounces-24059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DC5A05A6D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46CF3A039C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD81FC0F7;
	Wed,  8 Jan 2025 11:50:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525711FBC91;
	Wed,  8 Jan 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337045; cv=none; b=o9EDziNWC7HRyk3N4SAEpy4tbHtbS5ld0eaIvXdUTgTqwpeNlNCwfDGzHIOKyPb8vL11x7L+QsNLAl3C+q/y/kR3lxZAap8KVSwLoOsMmdplv4Zrz5O9bAHtAaOAqmXZ1ym+CBoJ3XSCZfXZ6MVMo48jjMh7aYIIw3lWLhG+k9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337045; c=relaxed/simple;
	bh=5NsZyre7dhB8gjVJrgCTRYi8hSfLC+Af6awHSBnzZaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuYnOzTMhKDqhMB0svLZD64dJhJi4bCCT5vNY7FsqyekP9zBYMCdZGb9RqQmT8incoYzJ93JPBf+y3h5NQKhDCQsRjpvU1MXEtoBG+cu7MNiLKm+27KsJh5WRVuR5Rk+jC5IB6o8iZT2tXMkmsU4c/l01EUxh/4pBFiSgI1LqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so24759579a12.1;
        Wed, 08 Jan 2025 03:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337041; x=1736941841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10Sv9Y7ixrJh+da5K4zI/xAp2zqjv0+XI+pN38JTjZ8=;
        b=cKJ5eVE5pVWL21KQQGfiJsX/PptL4v4RKoh9tbFJ9CgzyXdypFcFu7iVoiaUpYsqaL
         C7d+wauGP5hgM3BDuMzHX9HVK3GYI3Rds8ux/epyzGKhvsJzzorokzQxxUIksN/HAcww
         MU07cmyznAXrkBZsbOcDqBF7ww5u7tNcGdl6w7ufCCNF4n/HxaYc+LzyyP5dEhoSLkzP
         gCfdSK4/OZVoBUa2e+wC5StiJzGp11Y5JZN9ioBE4GYsrpKvnw6pGGaPhbklu1+bDVOv
         y86jpD4MF35vsFxQEAAo0SML14YZc63mObP37BNTTYQSeFVSOBhcoJsnFtAYp8KrHSVy
         1kfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEmYFgCGpSv59kgqsj0b+PYKOzuAYlrq343QjJ5usOhcaUOX5+RDHrqIpsknztjMhP/82uqlpNG8dmJcz8skwN@vger.kernel.org, AJvYcCXsvq4LQ1RdWcE2UrdEWLtE6xofIRKA3nCQFLPCHzavD/2lzJjKF0FrsVo8r1KxboAO9HcHLRO4aARGlU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBRT38jZc8YSTQ6Sp6nCIAhobeylSClMWqldEHKs1zMZ+cDrd
	kmryP/+TwmSIDE2PoIoLPZ6s42hoafvIiTctkthXoPerTB4rue01
X-Gm-Gg: ASbGncs8UhngJMMJ4ybMYEMNts8SWjncp48+7co7TaMoTZwFnBsiY31JSFbDA4VtPEv
	caW8vlnWrKj3g+yXXnmFE2KJr8GnZNmVGC59DXybMoFkqTBRDHzlRMhG1p4yvCihmbjWY4HYvQw
	OKiesGuixv5haxqMCryFT8q95O9fIRWLYneDrXuHdPp8gYVu5YuKEe7ZrRpimZNBZVWG6S72Au/
	gD9y7xoG8WAPX3I6f3N+nYfRHs6Rlewr33r+k3gvcACpEGm
X-Google-Smtp-Source: AGHT+IH7NRytDkgi57nzFn007chLWDtnMegqO5CoMn01qjqkiJcL0beA2O+M/nI74hZBU5K073h7fQ==
X-Received: by 2002:a05:6402:2548:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5d972e639e4mr5337731a12.24.1736337041391;
        Wed, 08 Jan 2025 03:50:41 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aae8b7de1cesm2321862666b.23.2025.01.08.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:50:40 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Jan 2025 03:50:27 -0800
Subject: [PATCH net-next v3 3/4] netconsole: selftest: Delete all userdata
 keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-netcons_overflow_test-v3-3-3d85eb091bec@debian.org>
References: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
In-Reply-To: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=leitao@debian.org;
 h=from:subject:message-id; bh=5NsZyre7dhB8gjVJrgCTRYi8hSfLC+Af6awHSBnzZaA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfmaKFSsKWkOpGsBGb+V3+6JtTu/T/ABaU304s
 fNMMYay2/eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ35migAKCRA1o5Of/Hh3
 bZzXD/90cStCYZR/lkixASdyf3TlSbyXMF4991WY+3N0N2Kivj9DRwkBaG5s5TP7+76Lhx3Xdej
 /QG6rTZRrd3SiQ67wunmvXuEwtIjeR6YVLHNxXFIwK1nFbXwEeq/T9kXffs/PS1cgSMAn0BzbTj
 l4IxTehF8k6Lhzm4bEZrjsAkwtrwL+eeW8PhUljQ5BAonIVxHzm3ZLYd4AQwwdaurJNEqCgMsz1
 aiKwywDOhQ7kOl5NiLU+c5cFpcrBjY054pu1hz5CZYHMD/sMmudRgiNNDokXT5CT8RACJ3AeZv0
 nfFppHLgQWjk0ANJzbjPgMrd0r3lvvtnC4NPzI55rFNCG1goIvKuSEo6Mm26VXozLOwn9YWVTH9
 TX5XH5Qc4+kYJV0xnDssxJ4tZa+n8+AgEC7oy2VSIxcu1Z4DuEUqMuVX+v8ydjUEg+PDOAKbKvF
 ZimAezn1GtQqSp+EA3/xGYzgklDPDZooF/dJbB74nItNhKam6vZiS/BPeSmj5TTMawZhsusrWJq
 4ssbm6tff6hZQxt/jo7a9F4GEoKeTccwMdmop0QMNv5BTJYogceVtEDSNIaAs03pIhiRfrU1G8+
 62oBetljrc10Ya43KTcXsWUw9+5r5K4Df8gr4aGNlUBVT4rCxPtZc8oa8/ZABW/4sVkc56JRDaN
 LYuwkCrzMQgaIeg==
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


