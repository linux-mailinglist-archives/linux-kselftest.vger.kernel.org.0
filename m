Return-Path: <linux-kselftest+bounces-34899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E88AD8A8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426687AD24C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E622E762F;
	Fri, 13 Jun 2025 11:32:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7622E6D1A;
	Fri, 13 Jun 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814325; cv=none; b=moUfC6OfCrrbGzSqoeONcrmxbPj5CnBSyVKoAp6dRWXA28Arv+JwiY1IEdvZ6paXErCGoJMCQ28ALE+vzz1+N1HODfs4gEA9sP4eI9XHcpn/JJNEGqgGVje/d71wo7kMcM/NHL2450W4dNRHD4QfG+kLb96nS9gz/MB2iIxClts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814325; c=relaxed/simple;
	bh=8fFTCY2/FkrInRH57zGLYtSnBzyGpWeIyz40n/hRaYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYmw/1V8hkDIH9eEyqvzGm2FVLjJ+DjsBXDgAEHE7xeNun+5Y0eZq6kSqBuj28njyGlcQBvDOnoWwieQbU9T6kSAifJXtKFOWWIW13yJQCXnkNaohUU9GeWwSvf/M1iVdTM9XXv76K8pwkLC3B8iOcprLTdzRx1tgfnFjkFWwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so322239666b.2;
        Fri, 13 Jun 2025 04:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814321; x=1750419121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+IbNQVCy4OC057F6g21qa7ouXuJTn2/HEWvlOhb4a8=;
        b=VYkyMfGIFMdf9TXNYQXXXNqkbEtVDDNR35pH/FLvOY+CRmk18hN47MQBi4iIgTHjV+
         FYlma7bvXUTVHfLG+d0aEsqXC8zuP7OG1km3kQexX0tX3/0ClvUuzLnhU44Bt5maCsi5
         dYRpdtzhWfz8lXmfT0+e0a3Oc+dtjvPr09jEUrl5r4egYHqG9wnZXic8NDooir6Xlbo4
         riQnXbM10pSqP/ZOJqmaXOG6Pkh5Gy6NghiHqen7DNDW41I0+GX01v+ghmxk0r2ytAOE
         BjXpGeFh7F0LUDnpehWBQ3Rbxw7XeJVaxEv6o0lP/+cGQeg8moG6tmC5oR+peI5Zu9BX
         ZWiA==
X-Forwarded-Encrypted: i=1; AJvYcCV93WZaH6LkqpQ3mW1JQp55bX9O0X3GgcT195QzBW8pTO/VY02VqsEZIb+ZDmapfLKuORoTTmx5/n1F4eg=@vger.kernel.org, AJvYcCWt2TBm3mCRzPKK7lFZO+eHjU0Vky/zv82axKtWmNOXc8rTst+JjSiUN2P5nqq5tQWOEZ0FOZhbGU80XL8YuqPp@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4kk1P6bhJV5Q/Wk/a5LHvqUOAT/dOWyPiZSnAUusL1ljG3LL
	uX0KNXwoXu6wjm2+xVu5e8HZllC0pb8dSkYCYdjUwQPSTArOdfm9uGhdXxnXtA==
X-Gm-Gg: ASbGnctBuoIOEiF11yLWBXIAsN3ysEaVkKLKBKOeOwolDCLOXv0ZH9JbWSkUfRSt/qe
	+DVuaTnunMpIpO3MJ5mL06ubMRrzPvRh5Uh3HFxtAQRl1409wUD/beldQQlS3VPhjHZzYh7AkWR
	I/a/W/fjZ8L38n2D9eoq03wfoNMcy1rjgD/8hyc0Cmd2eNKHL/I1wKRljCiYxOd+IQEx2v+pSvY
	IgtEXa1gp+wv+hU+9T0du1WoCqzHK2lEc0oix2VLXzQCxhmLzMiMY78fEC3XxNWXAi6ZezX14yi
	b1ANgd3Za7C4DJfWFiapebCNd+XjrCFyWTTdOGUuELcOwwSTmwsW
X-Google-Smtp-Source: AGHT+IHZxUVFmP4e15j+pA6R0kuoGa5hkFmV3frmO9LeCWjUF36fXXCmwGK7yWRxeqDP5HoAv23V3w==
X-Received: by 2002:a17:907:7faa:b0:ad8:85df:865b with SMTP id a640c23a62f3a-adec5b9b856mr243340466b.33.1749814321196;
        Fri, 13 Jun 2025 04:32:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c5be2sm115161766b.64.2025.06.13.04.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:32:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:36 -0700
Subject: [PATCH net-next v3 7/8] selftests: net: Refactor cleanup logic in
 lib_netcons.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-7-0752bf2e6912@debian.org>
References: <20250613-rework-v3-0-0752bf2e6912@debian.org>
In-Reply-To: <20250613-rework-v3-0-0752bf2e6912@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=leitao@debian.org;
 h=from:subject:message-id; bh=8fFTCY2/FkrInRH57zGLYtSnBzyGpWeIyz40n/hRaYA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwl5fiSjY+nxre8eeQLZ58PIHIj//vLU5cLE
 +V4A7iVKqmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bbFTEACKLB3raaOhaopyolqpWYgr8LaJt8mbiTlmLtiDY9JUsvgO1FNrGj+pJKW8Bbr4SgKE9BM
 Iv28gSzrX2MFdwSzl0v8Jb2nBVPZ8Qrwalo7Ytd6NjJSb68OPT7Q5XKd96I4+bg49+qSZq7R1o8
 hiLaHGcdY+UUt1uJTqk9Jtd8jI50yfS7+l5omic+gGTZWhzEH3cimOLTxAUybPS01hlpRVz+Any
 PuEf3EzY2UZcjIwSCy6/8GYz46Bk6PXw2Xfj6rVBY83snAahDWewklnkEA9Nu28WCA45Sr1LoDk
 hqFcpxvC5nuUKo8fbLYP78X6Lsl+p95vyKXRWHX90Vt8ZrzwqT/q0PvL3U89N7d3yjvFmZzgRTa
 gDd3Q3sf0qZE1zyXvofdh6zEwWEZuOUzsYUjuAYoCHEFaHDPAB9u11nM2CVfDYgXVUR3zkZyhVK
 S7anzHmIOXZj3KVxcF1Qnb/GXsnwOBqZpB1OyQrH0UpWg3oSucIyhmHzWjkNmqHUWwKtaWkH92m
 DNn6B0e/y6A9YVwxpn5MyxynWFAsL26YOIJKYic9sGafED3SIeyxX43X6WmT+SPMZlG0HfBIi21
 QZUhqsdYzEG9hRPP3GqxdOqbytkncXbqSd+/RuxCv+i4GoBf1pyPzjT4ENx9Rl/Kxx6Q42VNJ8E
 0cgqJ05TCMj4B+w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the network device and namespace cleanup logic from the
cleanup() function into a new do_cleanup() helper in lib_netcons.sh.

The do_cleanup() function only unconfigure the network and
printk, while cleanup() cleans the netconsole targets plus the network
and printk.

This refactoring let this code to be reused in cases netconsole dynamic
is not being used, as in the upcoming patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh      | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 71a5a8b1712c0..598279139a6e5 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -128,16 +128,9 @@ function disable_release_append() {
 	echo 1 > "${NETCONS_PATH}"/enabled
 }
 
-function cleanup() {
+function do_cleanup() {
 	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
 
-	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
-	# Remove all the keys that got created during the selftest
-	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
-	# Remove the configfs entry
-	rmdir "${NETCONS_PATH}"
-
 	# Delete netdevsim devices
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
@@ -149,6 +142,17 @@ function cleanup() {
 	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
 }
 
+function cleanup() {
+	# delete netconsole dynamic reconfiguration
+	echo 0 > "${NETCONS_PATH}"/enabled
+	# Remove all the keys that got created during the selftest
+	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
+	# Remove the configfs entry
+	rmdir "${NETCONS_PATH}"
+
+	do_cleanup
+}
+
 function set_user_data() {
 	if [[ ! -d "${NETCONS_PATH}""/userdata" ]]
 	then

-- 
2.47.1


