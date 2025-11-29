Return-Path: <linux-kselftest+bounces-46726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD27C93D77
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 13:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A363A6A77
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BB030DD1F;
	Sat, 29 Nov 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMCoC0Ks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EA26773C
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764419078; cv=none; b=XuuZn6QPnEaYVUogmmX6n26MGrLcx3ezCbypijQstmqbUaQ6czNHd6v2SR6bcwUbjSWnSl4qfh2rafZCrcZEQIK5Rz+RUjKVQl19reFYwpPRnKRb/Izke9QP5CBC9xArxMthkmv8ynxvua+BXEc6eqVC1KcqpemtOOL/3fZctq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764419078; c=relaxed/simple;
	bh=j4M3sD7us3SFWkNnnn8dW+s68JoCxXMcwwPqxafnGfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a+9SntcbuKuyMhUJstKxLuC086nb2FeT9arEmBQDlbw+mnttN7LF0aKlf5xBH10YTGJxT1tUrNdcVGAAl8cbuGNdNeCCgqTT+rRdHi0Amv/8YE59LLdfDm5faITalncahqTml/9S9MPBf/Do0aIdIiwo80DI9txNKpAEFUKjMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMCoC0Ks; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bdde8f1814fso2238330a12.2
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 04:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764419076; x=1765023876; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IAHXxP0perjKgqVFHaakct3L+cU6WogaBTck7Ta/YA=;
        b=kMCoC0Ksyelru6n5qEFSQ4h1NRrjozO5cjoHZ2gY+E3f3DnHr/0lX1+DwDamKsctTk
         nCr8lwmu9p4+ZhzWc+laGDjum5X1v+/uIxtNcfnW+airsSbu+gOlFkq+YaQ1CFzVblxa
         FiELlD3IajwzLkiQ7bfgmgGEp0eegoP3zTTo7I3rzPn77wApDaW7vcRQIVmOmtAC7PJk
         W/gTKszWwxPyVwiMWkZ6zWyA4JoIOKYmVdkaOG3C6a9Uqm6+lgUABOTXEe+LHhKevwCH
         3aOAxoMKG54L08fhGcqjAIC3R5jJyIZTZkq4ovFueZgOKFJiCY9mgi/faEZKIdStDBTC
         G+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764419076; x=1765023876;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IAHXxP0perjKgqVFHaakct3L+cU6WogaBTck7Ta/YA=;
        b=ohVX9yPcynRIj+F2Djm8ZMVUeud2R+1SsVXwGwjA8o8jmLCCDjnIMrlv1FC0xYHeen
         zf303L3U70wz/4U0Pe17te/mcER3pi8rtebif85PEtkw5/cfDTZ/2KI4Z3KwocH4pard
         jXFiwS+jaU2B2z74VNlK/8Vz3ol7PwtDv4uqDeTnB9h5ByGxmj14cjpgWhBu5TSJ2MMs
         YMlInLUE5PrgWa3EcJX5CqpmbpHGv0yMhoesHGrPbmkdh861fU/tF6YigLR0YeSARkcQ
         Pc0GsXDcH/+oJaP6uX1nac1Bimu8xRECXbHHQvjlnd70EX4wEc8Jo0aTdtaHFLAA1+7F
         OYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1LC5nVaB+7ns9I0Edj6wJsTd11ova3LiDlbk7xa+XLBPa4siQhGWORWCkz62Hm1hIwauoC4ufpNqcajd43IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDtYJJ6r8ySRKNq1GMXHltr4EtchecIV/QzroKFJF24jCq4FJ
	a5te1HT3lYZTPMm4ZCOZezMxjbl5vaIZwjYaoJIy6mYpXBDNGqw8h0qB
X-Gm-Gg: ASbGnct9cXcMHUzUmW5f1Q3XuAah1C/VDQJjhSkVOg6A0izAmwpaw1OBN0UHPOolfrB
	vwKhGZiSqq9+o2hCGfGJ/buMDs9XI5oME/f1GdldmWGbXVnI8OZlZ/pLOPyDDZbVKKTZQPoMamg
	qkndcd8JFCVoXI6ATciPExtlksnX6dNkLTE990USpyhx9pzCcoCB7rKAzvK4mlGZNIWciJIiZxo
	eeNLY5uyiXJw6gYVdnir1uCXWZZ+CU9rxQk/tOeSQRw3we6CxjZZXtM5a2B5X9JTomVt/lvJmEj
	w+9yFAXv+NcH+d16xxrlhAeP/jMnzON/+H+Hru+NMu0DMEqgp0XFvrUJ5VpSAF19F+GR5ZVIfx6
	gt+zPdAJH6KW1LtveR8rGwBwkUjSVKEls8lzos1s+GQ4FblFTWK3DVUCaLAGxFoNdXapxggQeQ6
	BAtZmgxNiouZM4bAbCcQ==
X-Google-Smtp-Source: AGHT+IFqqjQCrjafBGerzux+bnYn0h6zaVMzfv/X2v6ipqlNqLmeskBvtmHH6TaypCX1w0aozzuKew==
X-Received: by 2002:a05:7300:230e:b0:2a4:3593:645c with SMTP id 5a478bee46e88-2a71910598amr20080944eec.12.1764419075780;
        Sat, 29 Nov 2025 04:24:35 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965aafd17sm26059595eec.3.2025.11.29.04.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 04:24:35 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sat, 29 Nov 2025 12:24:19 +0000
Subject: [PATCH net-next] selftests: netconsole: remove log noise due to
 socat exit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-netcons-socat-noise-v1-1-605a0cea8fca@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPLlKmkC/x3MMQrDMAxA0asYzRXYhjSkVwkdgio3WuRimRAIv
 ntExz+8f4FxEzZ4hQsaH2JS1SM9AtC+6ZdRPt6QY55Sygsqd6pqaJW2jlrFGGPkmajkZXpGcPl
 rXOT8X1dw4Ojs8B7jBp0h7yJvAAAA
X-Change-ID: 20251129-netcons-socat-noise-00e7ccf29560
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764419071; l=2303;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=j4M3sD7us3SFWkNnnn8dW+s68JoCxXMcwwPqxafnGfE=;
 b=fDjLyuauUZfyqZFtv6U8FQeGA4GFqfX5kDx2fHj4giInAyCTbTejxvoXnmHfc9lmAuXACbG73
 LpnU8hvhGW6DyL6uHFxqnVoEW+VhFPzqOpM6HU4IpA1EcQevvxvKoOp
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This removes some noise that can be distracting while looking at
selftests by redirecting socat stderr to /dev/null.

Before this commit, netcons_basic would output:

Running with target mode: basic (ipv6)
2025/11/29 12:08:03 socat[259] W exiting on signal 15
2025/11/29 12:08:03 socat[271] W exiting on signal 15
basic : ipv6 : Test passed
Running with target mode: basic (ipv4)
2025/11/29 12:08:05 socat[329] W exiting on signal 15
2025/11/29 12:08:05 socat[322] W exiting on signal 15
basic : ipv4 : Test passed
Running with target mode: extended (ipv6)
2025/11/29 12:08:08 socat[386] W exiting on signal 15
2025/11/29 12:08:08 socat[386] W exiting on signal 15
2025/11/29 12:08:08 socat[380] W exiting on signal 15
extended : ipv6 : Test passed
Running with target mode: extended (ipv4)
2025/11/29 12:08:10 socat[440] W exiting on signal 15
2025/11/29 12:08:10 socat[435] W exiting on signal 15
2025/11/29 12:08:10 socat[435] W exiting on signal 15
extended : ipv4 : Test passed

After these changes, output looks like:

Running with target mode: basic (ipv6)
basic : ipv6 : Test passed
Running with target mode: basic (ipv4)
basic : ipv4 : Test passed
Running with target mode: extended (ipv6)
extended : ipv6 : Test passed
Running with target mode: extended (ipv4)
extended : ipv4 : Test passed

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 87f89fd92f8c..ae8abff4be40 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -249,7 +249,7 @@ function listen_port_and_save_to() {
 
 	# Just wait for 2 seconds
 	timeout 2 ip netns exec "${NAMESPACE}" \
-		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}"
+		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
 }
 
 # Only validate that the message arrived properly

---
base-commit: ff736a286116d462a4067ba258fa351bc0b4ed80
change-id: 20251129-netcons-socat-noise-00e7ccf29560

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


