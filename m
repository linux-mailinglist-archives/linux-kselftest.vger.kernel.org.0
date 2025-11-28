Return-Path: <linux-kselftest+bounces-46705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CEC933A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC54E3616
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB72EA493;
	Fri, 28 Nov 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGXJVnti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4432E266E
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367710; cv=none; b=RX4FOOfnK8J6botp0mWD/GwEdXUb7oYACIrpD9RZFUjnmB0F7jgjsFivmw++/uymZn4znyUnRhJ7bTRWuk3P2mqFNVXlPOaajAJUvmJr2aWA6M84/09tO2JD5wnpysXDA3t8eGiZBrl0MTFil4mEWJ3yt/w8Ynt2u0nd6X5b1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367710; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrgQ90Qkzb7V1RKgCToph0LzWHlu40aF85Z0tErzbjTkEmFl6b3egWDZWlW886kvrLLNuFj/Dpq49luhIizBAL1APo9h41YOpVa7ftQVcTOitlLo21cw9XRjZiH6rUsL+ZVZSVi5KKTsCMxCK1xD88t8mvO6n+JhfxR4iSDoLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGXJVnti; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1930349b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367708; x=1764972508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=dGXJVntiSZZidJaEYQWYuCXXdwg4QByX3kDzwShDuhfPI6XVLwcgUtmaN9qZbF5+wT
         Lw+x8n5rBVq91z55Q5bpvj2VClxgbo5oVz1HqtWViBrbRuZe8QppnsOmCLfBVuabEcsr
         BS1ByUHd+mc2eNZyUyi+OEgejnsULwit/q7wtX0O7l47kPKc6kaMRv99qVRh0Kn6kxAv
         6HkAKiaGByk1Dwd6jTrE+Br2V3eh0xA8h/GLSEJ9+cdFoo7rJfqX6Vv5NdHdJLw0Q1HU
         3nzQw4dZQgJNu7ISRaXqELscEzdNrTcgdhTbFAEjkkFe0MpPiS2yPurG8/dk3S/GHI54
         OEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367708; x=1764972508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=JE0mwir12Bu+snMbRXtzoC3oyqUCzbm5nsitxM6YszZfdwLMaz/gvYPSKyO/kemxPJ
         8Uzv1H7ef4xASZDWjSKu3nCJIs8WK6lZnWs+hNPX1LC8MpvGDXbq1npADYxmWmMa+nYz
         oQ6WO3012Q+01zjlNSbgawvGrPoaXihEde+XYI+La9gr0gv0pGMAEpNt7fM4/7c2kn+j
         Hy7LggQ0DaSEdM9DyxkOsOGnRn+axq/qxJVQ65jWRicdb5BEDA3k7PZM0SH6MhikxxIs
         4T1MiNCRN2wYKv194W2kTXe4JG/ZnP46n8GE5nUkGHU0E04mfQyuYwsZa44qrUvSM7ep
         BMyw==
X-Forwarded-Encrypted: i=1; AJvYcCVUmQCEBtNaljYMap/Olp5Ix61hWtBlKdW7v7UzLjEN6eztKseFimesBNfrYBIM60BW5MJ6HCpfPvJdY+XXhys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfQKNQP11695TnKTxpBJMexlQgoAKnv7W6YmQ9F60nhag7mzl
	kMSGdBjEteD/iLmrPzdLERHQmwWXpr0KF4uidwKfMdlk76Fh3BCCpR0l
X-Gm-Gg: ASbGncscPaOYbg3TIMooI+PNH2eOhr6x5W8n6lUWLlMUKsS5QQrUg8RIcH55n90V9ab
	cGCMIE4bJw4HrV+FHamreUTNvyOyT+t8oPo44a9U6LpxTAkci2ruWXjYQO+8x0cPyLvUiH6T9VH
	cIYlUtwT2DSEZYpJkFIJrbdrDAZjiVoVdOPPGeY+2xBCSTREDWxfpOGT2EAlQwP1Ha9hEKouSbh
	4Vbb0+8q5PegVrwboc2mB12eyTJmPQFYA8SRQpbhdj/1kFGUiMhwbuSP9lTOoLAe5z8YUZGvpNb
	z+G095QmkjX67kDaipCOY125uN5oI5m0dUCgIZ76roX7GfmB9V2jkghaAxpUs+57kFPdjchxuzO
	6CH9VT7Y6kv36mgoi6i1TwEM+BgOA7uxIFeenLqUSzwcQxK1qeegpUBEU6GV+cTdClkpkcs2Bu0
	rDD9axQocnj1T82bIrag==
X-Google-Smtp-Source: AGHT+IHP9cacM3sLthbsJDzciAEys52jMWZBJESkwrB9/1Buq/1iB5QinbxCfCe5nE75YPOMpByUNQ==
X-Received: by 2002:a05:7022:1506:b0:119:e55a:9c06 with SMTP id a92af1059eb24-11cbba6f374mr13160663c88.34.1764367707518;
        Fri, 28 Nov 2025 14:08:27 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:26 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 28 Nov 2025 22:08:02 +0000
Subject: [PATCH net-next v8 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netcons-retrigger-v8-3-0bccbf4c6385@gmail.com>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
In-Reply-To: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=OKYBLhWd1IZ93XaJ9r5FNHNxrv9gpqahkExk6+Sfgd6RO3fy3SSFjwyesY0i0145zbiJbCC8N
 kESIR+0Us6cCG4UmGvJUiw55zckCUS23UxCkJ2i8G9SSdcO+03E87C7
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b21ecea60d52..7a1e5559fc0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -580,6 +581,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1445,10 +1454,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


