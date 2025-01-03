Return-Path: <linux-kselftest+bounces-23866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E27A0098F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87086163BA3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40461FA8ED;
	Fri,  3 Jan 2025 12:58:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A671FA8D4;
	Fri,  3 Jan 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909101; cv=none; b=nExvKNLLRwqgf2ZVaQF1ofaV7D+Pci5jDNyRaA+oVEZ+PqPBN9uSzyxbuOi3EAi4/aVNJbLewyz3Z3TnAdyvv0t0343mL/o7+Ywh/VBqrnfNDnJK048MSwm7L8yQ5x8hj+BVqccGw7Vv1ZpOg12MKh9byINxlPWLDYqtIcA+Swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909101; c=relaxed/simple;
	bh=5NsZyre7dhB8gjVJrgCTRYi8hSfLC+Af6awHSBnzZaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKI1sNpUsStByrnVgCYvgwWxf27gFGrVp/KfMwoez2c2c2jq3plpKv57w92K7FYUSc1XpBDnU56RLDqqvTr016yCLqkuHRcNCLoKzE7DUlPMjbQOZjwJinlSgdN/BKfZ8eczi0PDWfi+HQczPR84h1HXYhrMY3Sh7ovsE5CW1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa692211331so2320720266b.1;
        Fri, 03 Jan 2025 04:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909098; x=1736513898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10Sv9Y7ixrJh+da5K4zI/xAp2zqjv0+XI+pN38JTjZ8=;
        b=Nhp1xELfJh56Qcc2quI6Pter2a2oH5DvVngXlJRevE3VdnvsoEHF9RPk2Rgw1jPtOy
         uF2mx5d+YR+DcqyBd6CUGHAYGMF1KELCsjP0FZHX6zGL1mA2CYAp9W8j3GUIqkW9wlGQ
         5zoN8sm+kpGVW21JdGIIOjqjtZnCqJ2H0WoR/seMFk+cK9Wa4Vz8ZKJcPLligeOKGinX
         a9xGIY6V/rmpjIy/EMRShMuvfNsPw5mkT86CkqipMjy7ESzDpxGsST7oVG5ImlQfMWY1
         W4Jm184Ma32bsg2sp1qOvX+wa2qb7pkVVGThEv10k0M3Fh7f5tz4JbKdTniwyu4I9T8k
         XCXA==
X-Forwarded-Encrypted: i=1; AJvYcCWvCpmX2G+VWhCdIncHUASQUnUBpMbpy2UVtj+Q0FjfYEPUUQZzWmUWhe3hdGaam2ndw5PREhQfO3X8HCjbclRt@vger.kernel.org, AJvYcCXIHacz/P9zet/29OgW8l2ySI17uDJO6L/X+uN5t6P121lIe+bqEnYeaxL5z0qnr/q8W8tQ/vbbRdofMbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhxF1uT7Z1Rrqv/+LHDo3DRBmSfMWkMq1yO8K2JHKveMgX8dN
	l04SmGLeQYwiIkv3DkfWwFjHM66UTIskbzBRDpnZbg+NqNopBmiziCfgDw==
X-Gm-Gg: ASbGncsSSiUqOfZ7BhDFtw2rl7viOOilVF8qYO58Rpu4IZccHP2cpOHtLE37+VVKpRp
	kB4iAOCIwYm9pbPxYukmrogIkBuv0zKWiTxE9cPeFoaOc6RXiUyOf20OKj7/bGy6Ae4NKwH1KdK
	tR0koPYKsZV76TDbEUgqOe6Zo2msNj6L8F176bkCSK0Ft0587RcvLOnF3Vfo+Ev3MKMN5jFpvpT
	6y8eV58Zcr3E9pIZUZOdLTHjQt+y6EYNstTc2vJ36SfijQ=
X-Google-Smtp-Source: AGHT+IFJ6D8KKTsgrukGXKDcZyE8XBTNBKUwAzN0zbi4EAAGVn3A9rYz94VL4XVi3YLoZqJJdFnOaQ==
X-Received: by 2002:a17:907:704:b0:aa6:489e:5848 with SMTP id a640c23a62f3a-aac34695112mr4164882366b.25.1735909098064;
        Fri, 03 Jan 2025 04:58:18 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe467esm1901792566b.104.2025.01.03.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:58:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jan 2025 04:57:51 -0800
Subject: [PATCH net-next v2 3/4] netconsole: selftest: Delete all userdata
 keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-netcons_overflow_test-v2-3-a49f9be64c21@debian.org>
References: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
In-Reply-To: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnd97hSoHFpgMkhs2gqTnuIeSSZtPnMI6iWEr+j
 H5Ju1V/2A2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3fe4QAKCRA1o5Of/Hh3
 bSS4D/wJDpmGn8v61/rtYEhTniWGnI4IiuQcZpgIV4jM/OqbuUsaxjBHRtK6Wt/aDVkT6ab84dI
 encvdRyMFgDoKGv07nmz3Vts3gozj/f0q8SNk6kyn163zWYtAjFyRu2/3G1ec995FwE5D0I0Fin
 i7R4gNUGOszzjRfNE9Fdrc4ErL/L7FRglieuN7z6cJEHMxjLyzmLHJ6SxMdvXuCayJee4D4RWlE
 eQJxjpUfhtbMQSUq3J/uSfpzIzxiQFiUs/EjOVxlIyYPxGv6J47qclYA6DRqDtG+Jsr1Y0yLT6Y
 nVmfhEwJOwQfTVu8W/jNq/niVXimVrsOGjLH24cgS9rZb6ephygfnpdhhXEt0i7PgeqDPghClWi
 lP+n92n89jjEbuj8VIyNvhoGe5WUuVl5GNrVgKCvUbxbOIZlJxfzMh3qyox2XQkGhoeffN1IA2d
 A7k/4bu9LhS+vx3dopKI+B1NPnMS30iD8OpnnLfwQCCxOlyA0yVr0SD2RrrZlcTXW5y1mo6hREK
 l6b5NBQPKm4MWRjq7/Jr7xBLeqD3vf1lCFFDCkkSC4PcYO4jsQpfLVxomUNsEB42Gp6Y7NXutel
 IZwww++xbZFYo71am4o8QS8PqzZUekJE/3PArK2vsgP891/7VOn32IB9vxGcn7GDj3HkmUmQJHf
 pIeZnk3wpHTc/qw==
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


