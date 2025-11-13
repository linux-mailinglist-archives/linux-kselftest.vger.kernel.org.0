Return-Path: <linux-kselftest+bounces-45570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5608EC59097
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B22C424196
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB936654E;
	Thu, 13 Nov 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuJ4IYJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4433659F7
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052157; cv=none; b=p6/neuCLBpw4YQ03JHLTjTlopRnV2uglEAYMwJrmqSEv18ErpqZFEtJiGIZE4Nog0R2ty+OjX21+j2HMg8wE/ZKMbm7daEmWSvnspYTL25ChoECDluWU671LECUgIDScSIbnXC4Rqid4OonKJjMFaUrooOcg3dttNiG8fQ61gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052157; c=relaxed/simple;
	bh=AZDhgFsJHk/7/ccWHmuKjRVzzDMIUsT8B2xszzmjcS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+RjydmQmWyDie3qi83OeAP2BjnZtxdlsbhwJFjh9UAwxc1n90NJ/RHrSPgCbCvzLuXzMIGB9nkPzLnyIvR/Z/tgNUXAVQ0o+TjMl8r1w6A7XDzuKcvsl2JRo4R0r6tt6UZnPmtGbU1Y0FP/2SAetRSHaDJJ1xjC7fkVwamEEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuJ4IYJX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b305881a1so116628f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052154; x=1763656954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnv5GvLZO90fssK5mBO/V2ejb0VVnidgq+QHki0NiLw=;
        b=IuJ4IYJXLJ2V5+7Y5+mRDTUTL2yzgqfIK7tEPsOTetMWojJb6Y1g9LSVir2GIvKVRf
         Yv+a1pGGPiP6Gfxk16B/uaFurp0SkXbX+hphQNp07ksmvhtcOWOV7mjdOuI0BqjvYYKU
         zDONzb9C2el/O/eHTD6PIjHk62BdfujD1UdFvbAhW0UuvYcywIzbmM9w7oUWYdX62qrk
         DFBCpTUbKm+UhP7HXJ7dusVMcE2FsBbdwYrOUlcKBjsaVC2379pTisGc+099x7tO//2V
         e/1QdPmECdMRPGnOfCRPRTJO4BLRv+D3Hbpl4s0fCD/vFymEydKWRfbkioWs0E5X+Hzt
         glvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052154; x=1763656954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tnv5GvLZO90fssK5mBO/V2ejb0VVnidgq+QHki0NiLw=;
        b=dEMUdnW3YPujf5OS+qD7ueumJrzusNOrJYR/3hRqKXEwG3p/E2FDu8qYgbYO4KgfkM
         2jwtK19kUi39rRBj9qb+srtSURBuz5h4aUBW4FbBZVMUmXtkfOgL4lG0iQWWW7Pr2hRl
         9xBnUBBhMp5Rdb0xhWjF67yB+XKDdutyDXrAJrhyrnlyzptfZIcyQWO7rIala2Misp3f
         4r9EHnCgTE3NVHwZZD9c5s8eNr6ih+ChOXR/UQ4l5/GimsJJrm/urfIn/omh2DgaF4bB
         huffpOH3ix9xLiiU443ycWp358P6e/Gr3kGzUQNm8GPkEUvUxv/710orSrj93Z/aG+2f
         FUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZC9nMhjkC4SY3xQzrD8bwW+PDafP5OXLnsH1HeK/HWgJjLgeuLn3VTkgrzwKOu0i90iUOxtR3Hdb2Zympad0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1pOB1dShhmire5Qau20UodFOkrzEBAUt3bE1wEju3Pq1mFHI
	FMqTG/EQeRBBDwybEewyzFNchxiqFmYs2RfLxb8fotUSHbSMWv7L+J2q
X-Gm-Gg: ASbGncswxTsLAX3d1j2brcG2ZZ8L6eREcjwguadGErRZhmhS7XLjj49+KGg38tzXE/I
	2M72EsXV47PyXpbih3jbVQtxXouoLB778MJyBJwCb0fPov209KocY10PvQ0OwbFcLExIWuNB8W3
	EbjjUvBDXlD2+XsjHjcms+QOjIpNYt/G+pV/7rxf66kywLWgP76NJw9g4PlZn60m1Pb2DLLxh5+
	W0lXPO2H6YdkCCz9o+2tnkvtgVWmraUQVEVoUZkg6cQ8Oty9qVUDXxt1u8tYMD8TaLgBWdGm+ya
	2BrOH+FLBOOKMnJye0Vx4Jt+2U96SvyYISWVRGkJQd6hkBmYfkDNfekVyBtRwcadWgmri46M31D
	9lApMJBD+1YC69YswF8GXIVIxVA/O7H0Hq9kzKWeQfqvNczBdSn67GRYWCGJqoL9n6q7IVs8n/3
	hAguEy3A/SdF07R6c=
X-Google-Smtp-Source: AGHT+IFlJhZQHRbGLobb3YLbAsBiS2Koyw/Ec1i06oLS8N0XCLnx1tPyDdy1oAHB/rz71WT4cMX8YQ==
X-Received: by 2002:a05:600c:c4b8:b0:477:5b01:7d42 with SMTP id 5b1f17b1804b1-4778fee8183mr614895e9.5.1763052153366;
        Thu, 13 Nov 2025 08:42:33 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:50::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f21948sm4877254f8f.43.2025.11.13.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:42:32 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 13 Nov 2025 08:42:21 -0800
Subject: [PATCH net-next v2 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
buffer is allocated dynamically.

The previous limit of 16 was necessary because the buffer was statically
allocated for all targets. With dynamic allocation, we can support more
entries without wasting memory on targets that don't use userdata.

This allows users to attach more metadata to their netconsole messages,
which is useful for complex debugging and logging scenarios.

Also update the testcase accordingly.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c                                | 2 +-
 tools/testing/selftests/drivers/net/netcons_overflow.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 12fbc303a8240..36ce19936fa39 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		256
 #define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
index 29bad56448a24..06089643b7716 100755
--- a/tools/testing/selftests/drivers/net/netcons_overflow.sh
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -15,7 +15,7 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 # This is coming from netconsole code. Check for it in drivers/net/netconsole.c
-MAX_USERDATA_ITEMS=16
+MAX_USERDATA_ITEMS=256
 
 # Function to create userdata entries
 function create_userdata_max_entries() {

-- 
2.47.3


