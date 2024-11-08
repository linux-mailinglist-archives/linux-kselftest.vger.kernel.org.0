Return-Path: <linux-kselftest+bounces-21684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD49C1FE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB96C283E7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784501F4FC8;
	Fri,  8 Nov 2024 15:00:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F401F582D;
	Fri,  8 Nov 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078010; cv=none; b=NnbJJ48+aEq+vgHSrq4imA/kirAtXFzLW4E8a+UB5NiPqWi5OYlwJjohfLRavfILkb2PYKbcz8tzdNrzwORdCnsNetyp/XHzTZJVGVOILFxB5MNIOj2bjHM27IzFhA4SGw2LsAPqJRfaq7o07eUH7xzZ+4gzeTCnlEtXEoMrjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078010; c=relaxed/simple;
	bh=YVyjPtBUCXQML+mx+jc7/cYnCoF5ihFnuGgGv89CzPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XES9g0XqX9H0axvUhbAxmtIn+Z4MMh1Z4ZFlJUhsmXyUTtrQz1KP7lrH9eIUr6SGRFEI8a1KfP/QUIKa8xvSUITroMS2AjMxc479512WiHurSn8K9xZllK/GPX2sr+0HBLqhSk0lp3zTQ2d7cwHfmgkAwPVAacRdxll8c258PRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9eb68e0bd1so308720566b.3;
        Fri, 08 Nov 2024 07:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078006; x=1731682806;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo3vkaxuRrTU5x90V/3/Esan3LgS4AhbEUfNLjlfsag=;
        b=Mbg6/Jx0CygdqAyhkmdTDyow4o95lpKLKfwT4kDiIrrf+3VWOikPssGYdh/kw6e5K5
         /lMg3TjQbkD6pBnKND4N0yHFPuKqHw7iLFqkcnIY9zw+jDDIg1KdJD3figS1RjITkKLw
         tVypbMvTfOp8LwaIJFK6nK7BNYKc34r5EeC6xq/kjP1bC787NlE3nLU1lejhYcA3FWgv
         RMFYKq7rMPZkTtcBBFfwYpcGDvu+gckH++QXH9YJsaxblLQatJbakalKLTzuYeG2XUGd
         eqI/Vx+0YOPuc/7OlmV4J4bwd5MMG4+FHMsFXZXYve+wJYFq6EwsPs/xsV+c8R0UHReh
         oaQg==
X-Forwarded-Encrypted: i=1; AJvYcCUr+PhI5xjt6dBZHsr96VG6no2qtj+1jIghxOhNvljluGsJVS3Fbtxp/NXtFeCzhZRG/aLJwSzph+zHHhRsqV9W@vger.kernel.org, AJvYcCUwhDZKqgO/3bQWliXGeSH6iJD6OvNwNi5qv94DO2iCOvW1cZZ61ZUYWeWLRzjyqJivdPJVWsCNAkxRFlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54CdAX9KtmiGtOjXLEnwuR4ijnbjZY3mkwG/U4sJ0iHXfrBrb
	q5LekWPH5mDPnGbYhhLzuRA/et72zw8K5J95yKhLN10ekTXO035p
X-Google-Smtp-Source: AGHT+IGnMtUwEH2vwVLfN9QzL5kBneHKTNEQLBFh/PAg5G7H2dPhaje7iFo/5QgurB+GhveGRsrAZg==
X-Received: by 2002:a17:907:9411:b0:a99:35eb:1301 with SMTP id a640c23a62f3a-a9eefeecb8bmr294193166b.18.1731078006299;
        Fri, 08 Nov 2024 07:00:06 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dedc3dsm241291166b.133.2024.11.08.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:00:05 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 Nov 2024 06:59:25 -0800
Subject: [PATCH net-next] net: netconsole: selftests: Check if netdevsim is
 available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-netcon_selftest_deps-v1-1-1789cbf3adcd@debian.org>
X-B4-Tracking: v=1; b=H4sIAEwnLmcC/x3MUQqDMBAFwKuE920gSVVsrlKKiL60gbJKNogg3
 l3oHGBOKEumIpoThXvWvAqi8Y3B/J3kQ5sXRIPgQuu9G6ywzquMyl+q1Dou3NQOjxT6tuuTe3Z
 oDLbClI9/+4KwWuFR8b6uG9Ef66VwAAAA
X-Change-ID: 20241108-netcon_selftest_deps-83f26456f095
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=leitao@debian.org;
 h=from:subject:message-id; bh=YVyjPtBUCXQML+mx+jc7/cYnCoF5ihFnuGgGv89CzPg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLid0vzygrmxBK+fLcNgwH4l/wfXUeKAQftRQH
 Lp0etORCH2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZy4ndAAKCRA1o5Of/Hh3
 bcWHD/4+fb0Xkj4iGsWHHdl+yPdrOofDpqiduyu32zNY1Z7Q50EG9vXwNlLU/o/+LNO5haNyhWP
 /CBjsFO7+21seIg25Xhnfx41JQV3Pu4V8F2zIaCW99H/j2v/juUZndBTzIba3zzJl+lsu/o6056
 PLHueA1YVnspRFramskgNyDyH3IFVig9Wbt7o3qHeybDAdRRlgzJ8FGxt7cQ9+zYzJjW+Z/79vv
 fhrWx4WSgP8l/dEe2l40otii2p9Gd+HCe2zGavUFZO1RSSaPfZAWo3DYRtwkw4bngVPYu9/J9DI
 tUNPHdHQk1AxShGHH4He8Oh43FY1ul8sKtjFXo4iEShDGAETCh1VwIvPWZ69gLXrH2eas4M445V
 QsoVV1SVANyReqXPPNuaF72vwVBx6quc1rc/31nOx/u2hWl2+CyxDx+NhT0vuDOHaDHsHM+jAMQ
 p6OTKoB5e07mI8r6G3aE71Xk5DDZuKR02ptdRwLgINHahfzmFOMbwhsB+uiur8/1YIpJuSLvPMZ
 l3aDDEE8cCYsdg/mztfj0MUmF2au/wJavFOZgD+H+IkFqCbZvuYIblcYToe86S1B03M9JZgVjvo
 HmtcRR0Z4YVeb4CY9Kp1fb15bF1WTS4Ie5s9WH5Wd2b19wDnV4GwxLuruHl/G2dpEe6t3hpQE63
 HAetmMLUdpA2VSw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netconsole selftest relies on the availability of the netdevsim module.
To ensure the test can run correctly, we need to check if the netdevsim
module is either loaded or built-in before proceeding.

Update the netconsole selftest to check for the existence of
the /sys/bus/netdevsim/new_device file before running the test. If the
file is not found, the test is skipped with an explanation that the
CONFIG_NETDEVSIM kernel config option may not be enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/netcons_basic.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index 182eb1a97e59f3b4c9eea0e5b9e64a7fff656e2b..b175f4d966e5056ddb62e335f212c03e55f50fb0 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -39,6 +39,7 @@ NAMESPACE=""
 # IDs for netdevsim
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
 
 # Used to create and delete namespaces
 source "${SCRIPTDIR}"/../../net/lib.sh
@@ -46,7 +47,6 @@ source "${SCRIPTDIR}"/../../net/net_helper.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
-	local NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
 
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
@@ -212,6 +212,11 @@ function check_for_dependencies() {
 		exit "${ksft_skip}"
 	fi
 
+	if [ ! -f "${NSIM_DEV_SYS_NEW}" ]; then
+		echo "SKIP: file ${NSIM_DEV_SYS_NEW} does not exist. Check if CONFIG_NETDEVSIM is enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
 	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
 		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
 		exit "${ksft_skip}"

---
base-commit: 4861333b42178fa3d8fd1bb4e2cfb2fedc968dba
change-id: 20241108-netcon_selftest_deps-83f26456f095

Best regards,
-- 
Breno Leitao <leitao@debian.org>


