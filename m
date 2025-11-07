Return-Path: <linux-kselftest+bounces-45096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE12C403FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E0D3B527B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4295732862C;
	Fri,  7 Nov 2025 14:04:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA4322551
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524250; cv=none; b=NZJ8Z9m18undDUJWFdEUvXZaBEJKJboUZ0A5gu7BHrNG+i0bfUm4vKyhBowXQcu9gaqj1xhMndlXsQ93u2J1nZ+H6hYpkc8/Mq+1dLFFCsZzMo/KkSoNT/synp3PkpBtWlmPexS3JMgdNuxtWjfqpJlezKa3pi53PaX9GYZjaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524250; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jj0u5qOyZM3dqYe8ARhBgHRVPi8Sjw4Z3B6a8PpJ34fujFsZf778H6Qo/yo/yru5yk1lWrjFJojSdm3Rv5I7ZFWV0RpgwW+4I0Cp5v385uzresQlA9xk/+MiI5PGYlY6WHkaiTzVcEYdMSjwCpOYly6K7G3mXg86dIcHd2En0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so1509463a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 06:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524247; x=1763129047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=dorhe0Uii1KycjP8dIT9Pk9hgwWjGGUGbKIcHv3Xbuqcyv4UHWIRGUohBLF0NwQpgg
         rHg5/IMaiGWz2Nx5lfQuCRWjVTYqnzeFVWzag8RrK+wxA6cl3xo91dc50MnLGlNOgBFX
         n1lTcB6f7sjMuYVH5p2taAIidC0vbJ1yqXfUMYFj45twuXN84xTnQ4CpHSuh4mr+WGTp
         CqDneKREMOhQM1JivCR5kkl1djlRX+I/o8jCA/XF0alAvo/lHgbJ0DjOsuwPFLkRKVbr
         zM52sHGV2yw6TsuJdm3AfREPmE08kfCz1zGG1Tm2WDEa3hv5z9bRR4YtqqCYuT8DV+0I
         JpeA==
X-Forwarded-Encrypted: i=1; AJvYcCWpqBqEBC2oGLycWhnnJWjy6VSGrl+z4HQMTxRWkMRU4fFA8Ci51hMrH5kAcqBO8GdvZFR+QMi3/eyH7L+bFmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznB4nA94uNU6Q2JMJbNcSfcReW6FaxAzKTtglnV/pHMmvFanXn
	dAZ/OE4HvxhyzZfHVAIcmRxci1c4jodQdHG4o41PZm/Q6IOIqyUBhd3J
X-Gm-Gg: ASbGncsigBq+YeUUzkNGIN8tQ0VaD4Hr36k8dOEyj8exPoqRlPdcAgZ+kyWojNSioz4
	mf03bjgFOLg5sqW8bOJMZAv/hxBlVWvUgGlDZhR0FQc9PLPxcpjW7djUq3FmjWHutxy5gIXd+Eo
	eC8PrLkIJM+9aflOzc2ztgbc0yHXCJPOHT6tcS0omOnHqdXzeTgNI686miWnEzA2mUJhWZY7hLL
	DFVTJbmxQOOdlkZlMadi++LhmEJzxlKtoKtvuw+gwEpyuKIFUBuaxQazjfNm3yrnAhByuxBXuN0
	Z0RzfHAwCBNIMJlKJNU1jj3eaNcoxd+fZiN5Yeqc85LB0OhQovaDqASwoxaBZB3reR/+opaW4qB
	nbraBT/5kO2rHM2bLdmAlySXxuEVsJL1B3El8tjO+hr/vltzuEhVf1cvjWyGDCl4i7RrgSiydTW
	il7Q==
X-Google-Smtp-Source: AGHT+IEnA4n1oxvAuSZNuAYTNl4X2XL9nFJEKYukQiqovNv4tfPvYkpSeP2M+nuQbeHb6r6bCT8z9A==
X-Received: by 2002:a17:907:6ea5:b0:b72:60d9:32b0 with SMTP id a640c23a62f3a-b72c08ebc4fmr370881866b.3.1762524246382;
        Fri, 07 Nov 2025 06:04:06 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11271sm250694466b.66.2025.11.07.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:04:05 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Nov 2025 06:03:38 -0800
Subject: [PATCH net v10 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-netconsole_torture-v10-2-749227b55f63@debian.org>
References: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
In-Reply-To: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=leitao@debian.org;
 h=from:subject:message-id; bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDfxR3LFcagYoQMxeE/hGFckSp2YiaItTI6fZZ
 WyOjHlh5E2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ38UQAKCRA1o5Of/Hh3
 bbgiD/oCTfTa9SezvgQamYx3/71IqxBEFN7xAq//c6G/xegLPcC/Y42hzoXD31o6kw8GZ0BPvkE
 15dkvjCNmtZOyV65fIMM4py2qpkq3JkFLrsIyLObUWyVrYrS8ST09aTTnUpxzontmX02p5imi10
 +Zr4HIRDS/LDec7SDfUSGEojFyiOXnUBjfX2gxSj1T7w40zZjHwEmaJWL5tBSru0NaLEi7n/7NO
 NFA7dfOr8RGydsida0v4kTClq1SkozT2ILBXYosANpILDFdtUcbBMc9XdvTStojsQCKtegFtexS
 PQT1MEqozoF1000nl85hrLBSW3uwzubMRGDXW8RPF5UYzFEcHGvlg5SFs5h07DejgBRg2ecpvYt
 dnNUxB2eYy5lDCpVnPHd+z0t1e6BPrmP9yuM2oH03j0A23IbuXPRA8+yvsu+E7rJ5k20014hVMz
 NNOg0KFkBBdCNGPPde/W8d0XQ2VMLs98+8vn6lbfnwMG97FPnNYse4fkMLpZZCj/ws2iwkwgXHL
 17h03ykkIz/1QT82HcX3NDMjsXU1Uw8spiqo7yLVtCUOF3dh1Wea1tcVzmgGHTl3jtiokgNGfkB
 t3Yf15n/C8SJspCfqG95kKROX4TCIK3ZJCUxXXDmWliG0XS0FW3NzlVOOrYf7E0NwxzAhvm+qx/
 Qt+EHbHzAhtQyxA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472..9b5ef8074440c 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -113,31 +113,39 @@ function set_network() {
 	configure_ip
 }
 
-function create_dynamic_target() {
-	local FORMAT=${1:-"extended"}
+function _create_dynamic_target() {
+	local FORMAT="${1:?FORMAT parameter required}"
+	local NCPATH="${2:?NCPATH parameter required}"
 
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
 	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
+	mkdir "${NCPATH}"
 
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+	echo "${DSTIP}" > "${NCPATH}"/remote_ip
+	echo "${SRCIP}" > "${NCPATH}"/local_ip
+	echo "${DSTMAC}" > "${NCPATH}"/remote_mac
+	echo "${SRCIF}" > "${NCPATH}"/dev_name
 
 	if [ "${FORMAT}" == "basic" ]
 	then
 		# Basic target does not support release
-		echo 0 > "${NETCONS_PATH}"/release
-		echo 0 > "${NETCONS_PATH}"/extended
+		echo 0 > "${NCPATH}"/release
+		echo 0 > "${NCPATH}"/extended
 	elif [ "${FORMAT}" == "extended" ]
 	then
-		echo 1 > "${NETCONS_PATH}"/extended
+		echo 1 > "${NCPATH}"/extended
 	fi
 
-	echo 1 > "${NETCONS_PATH}"/enabled
+	echo 1 > "${NCPATH}"/enabled
+
+}
+
+function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+	local NCPATH=${2:-"$NETCONS_PATH"}
+	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message

-- 
2.47.3


