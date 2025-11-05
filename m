Return-Path: <linux-kselftest+bounces-44832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF2C370F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20EC94FE5E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5D34167F;
	Wed,  5 Nov 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzW3I0El"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AE33F8C7
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362436; cv=none; b=E+NFWT3Vk2NrJJ+EN+B6DGkJUjS2X0N+fOBx/Rj8tMIQ+fG+fqjc7uCLIw5HA915GReSNPKvOFLlmqfUwJkzwTd2JfTn+zcHQBROBdGkiIqIJHPdYd+oris7ukmn+/3Gf6q/sOfFoHYXIuMAqzgMt8bjPa6AmH4QFf41Oq1DwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362436; c=relaxed/simple;
	bh=SHevSYfAflYvIOjcPM2PiuslQ8TTF9Z0OzcTTNZ+A3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6KDlkVwKPKL6UceYb6p7gokRXX80STmDUfal0Ck/PFbfz17uPpExxtRMgaSwRYEerNhhU3MAjbgbao8EVR2Egb8VBjc2fOARsDvP5c+6pZxzuq1IDt58MPtLqugw5x0epeo+KysTt7tewjAO9YcHRPAhUJ2vQXhmS66HiPmpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzW3I0El; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso6946f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362432; x=1762967232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDPGEALHiJj9n97uz8lWTxmttupO8bbW3KYaPlpx77g=;
        b=FzW3I0ElRS1rVF1u6ENGSVlsZrvReJOydBvhHHJOsr3/0m3WtZ1VpQ7sC19qDCEkHN
         FsWiRug6SUBYNjVMpzdrzy7qZjTVlYstiOl2q36+degyAcXX6FcqCp2xo/r9qjZsUNBr
         05JSvJgOMn3yYjqFJlBtsG5+fheEh/xtoiy+JTotfcNvkcSay6Kp4LuWjXxQ/SkTT/ID
         SeHqdzUPjgrGL/4GCsKnWMxKNwQ5atiDPC71ISR6Ipa8yOsi/6ZV/cIGr25wZcWrSaLH
         OFir/51nrK+f1xbNl0055mZDoRyFUQ3+tYjQOwuzQimQuq2kAOai11SyqOrrmaNhR4kU
         B2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362432; x=1762967232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDPGEALHiJj9n97uz8lWTxmttupO8bbW3KYaPlpx77g=;
        b=KeoYMXn7YLrfgbfciRNKRymYItEi115pPi7vEQMPL5AtPX6BNYWjUnmB9VmXegoafT
         HX587DFXGvBU+FYfXkPtlXf0H4mbab4I2sX8/DE3/HrG+Jtpnxf8sGtYrgE/Q8yqZzo7
         W0TWpkwxGSPAxST9O/7vIC+2du32OHmZPBYVbyijuTY9Zs2O3ibhNWlu8qDHHQpxyeoc
         UTXG/MTNOwToHAlXwi8PUPjzNqDh+Zp4BXZR9ONmLtkCvh7yXQI7jSmj0C0BL0i0wjZe
         rM2KaunAU/YMGZXZMTOP/nleNsL8iv2y7pAb6wy8Gd2THfhwk94jQpfOoYiuRfYXlCl7
         7b4A==
X-Forwarded-Encrypted: i=1; AJvYcCXoGcUyregs6VrYhN9y2TbeCwgp2wjd96J7L3l31tR81fuclHqiJYhKdvwD8IBLH7gzlA5lPLd3aMoXjLmrz8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthHzkuEQswRyvDZYoJM7M6yfIXAQ35QdjIII8KwliDMnTMUMv
	aAZhznRQfGckVE847cNXbHBm4ybkPlZNN1hQT9nGJ69cCuuvIjy12y9J
X-Gm-Gg: ASbGncvifTAMmKDzSLLaZnuaLaFUKXlKxkd1RUfeyd7WtbdueXanJn3lIM/HulTkT5+
	KMSA3w60/+T6vQ5MjCHAT7yPEpc/guXo2ElvT/TcJ3/xo177LLbzMmqA3P7WWs2j9JDxvRSvorl
	dq3PeBypVnrXNGomYLHK/jFPW4CAyI+7EcdCCV+2Ehe37w/EyUtF6gQm+FBSoGE4Vra1VVkBUkv
	k8U6LGXdAnB96IWEDkzB3q2fW2wMy/2PVP9F57eYCH76f1zguae+l5BVcPk9GvEKib4kXvoCw4x
	V54ziZT2iuc3x/rkHZv9lnSCnW2uEpdsB1Gisw/ghSdDlitz4HhrWI21qYSyclsUQ0oXIHRF3Nj
	BJsA9hBrYED8c4XtTTSiXT0L4g+XAtwzlgzfi2ZON19MuJojI9PrMU8szOWmZsyLuhrpw6tdZaE
	id2c4=
X-Google-Smtp-Source: AGHT+IFGFX9DslUYNk9iBEXMdGr7oaOJipOJWDtvY1Tg3EGRYJjFwA8CB5hzyW6XylUnko4CikmxTg==
X-Received: by 2002:a05:6000:2f81:b0:426:f590:3cab with SMTP id ffacd0b85a97d-429e3275af0mr1981253f8f.0.1762362431350;
        Wed, 05 Nov 2025 09:07:11 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9d33sm11871563f8f.36.2025.11.05.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:10 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Nov 2025 09:06:46 -0800
Subject: [PATCH net-next 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-netconsole_dynamic_extradata-v1-4-142890bf4936@meta.com>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
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
index 8a11b3ca2763..040bae29d485 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		256
 #define MAX_SYSDATA_ITEMS		4
 #define MAX_PRINT_CHUNK			1000
 
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
index 29bad56448a2..06089643b771 100755
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


