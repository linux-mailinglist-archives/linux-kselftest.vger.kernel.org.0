Return-Path: <linux-kselftest+bounces-7776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DD8A271B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790221F22BDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB04482FF;
	Fri, 12 Apr 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lXqK8B1b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26B51033
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904577; cv=none; b=miWGHNHh3lqlguEERh8wrfGJA1HVemao5UFfW6aUM1qWHN9C+nkhNvkM1XslpLuT4MUvE2LKXSnR9dxghCz7RWwa1fCzYjw0L/KZAe3DzkWglxuU9nRkqgSCgwhvUHhDC6RARu3dpcjjXt+EJ/SV2n5UbimSoO0q9I3gEIdgyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904577; c=relaxed/simple;
	bh=HTwXq4dfdPMm84nIH+ARCZR286B+TcB5da8GClM6ty0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5n652JB9na65lXrx9i3WUZTi4Iq8Zutj8h6CRPGjsOgBO9RzaRfHzSbfeVwL8WrR2Wfc848dwocvC76YojWIr/72qla7brpjQorF+7WThM+PBVasVdorOqxPGvMHv5byOS73wWEdXoTSO1SFs6k32aK2h45W1axdhYp6xwYATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lXqK8B1b; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e2b137d666so5014225ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712904576; x=1713509376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6E6ZusRhlxuRh8LTz85NPr0A8l1rMIJWkDOWsfceGk=;
        b=lXqK8B1bf+ydQAIRJSxlk+JFBVbFAlmZEOGdoLw+uvbIXhZZyJP2d9nFAc89iw2jqF
         8pHWMmrotqiZ5OYIbSYRBMps55WVwusV0b0GYvn3y5vTZ9KJaxw58izkQ5M2wA8l0kkQ
         rQQP9zChf32/mA4svWcTvXLXZAqrexcRMKz2xQLxzBdwIp5+/CZ7vHTm4y299sGhq14A
         FiIs890N4zgCul5epcDZ4S73DJxFdYI804CHOl2ywQ3/P1fCqNF2ybtYv2hlDeTiQFl1
         8DNZ3FcJMo+zGySJvzwz55g0IrAJJQc6yzpl6lRNMqC/m+Yj0ZwaPugZ3t1xsL5Z1Wov
         YuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904576; x=1713509376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6E6ZusRhlxuRh8LTz85NPr0A8l1rMIJWkDOWsfceGk=;
        b=hj55ZZ8OIVCLrOulrdZsa088j50fv8MXaKSEmanHq1pn+tFcsVu17cc+VCktYonb60
         4Iq92Txpa7wMd3d6AWp4IqxZptxVVWF4hpoENkcO+l+LUBTk/K60NlXlxSMz3yErkzeN
         kmToA1Puchn2lE+GMlVT6ykAvKWGIPZHjOwfcpAeqeka80nRE3H5TFHw8oLh/CeXMSOY
         sp42hKQvExLduIxTY8XWgI6qv5M3clueeQgwbjlvDzUMimg1kTOeIxRLQbVa93YwFluK
         6Nk7PKiWv523LVKOFyN0+eWmk45s5zQDXmoOX0bHBBjysOzotqFt7TxqLcymItgwrWYh
         /apA==
X-Forwarded-Encrypted: i=1; AJvYcCXpy0x8l0y80ZDlr8BpThj6ShSNt4PoLPM0Lm3RkZzK2p0AbUPYwIIu0yDNFUBpY4+ctZ8cREQ4b/oIaZL26VmrLPxl0G3CLNrVqng2dACk
X-Gm-Message-State: AOJu0YxhdJvo+AwzvEFr5f956zz+MPY5ZvVtuWVYDzaZG+ZTFGK8mloe
	OIzk9LvKLRgOoCnVvNaTK9fDK28ctO6O5Msu9purZbSzcx0sCc6OpWa7lmdzeKk=
X-Google-Smtp-Source: AGHT+IFN+2rlBM0atFvz5drmpqdxYuReC7akcGJxFgtrZUemr79CcqpTCReQ9/O3Fl7hLYkZ38tKJA==
X-Received: by 2002:a17:902:b187:b0:1e0:b62c:460d with SMTP id s7-20020a170902b18700b001e0b62c460dmr1459758plr.38.1712904575557;
        Thu, 11 Apr 2024 23:49:35 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e107222eb5sm2258818plr.191.2024.04.11.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:49:35 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 12 Apr 2024 14:49:05 +0800
Subject: [PATCH v4 9/9] selftest: run vector prctl test for ZVE32X
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-zve-detection-v4-9-e0c45bb6b253@sifive.com>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
In-Reply-To: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

The minimal requirement for running Vector subextension on Linux is
ZVE32X. So change the test accordingly to run prctl as long as it find
it.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v4:
 - new patch since v4
---
 tools/testing/selftests/riscv/vector/vstate_prctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 27668fb3b6d0..895177f6bf4c 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -88,16 +88,16 @@ int main(void)
 		return -2;
 	}
 
-	if (!(pair.value & RISCV_HWPROBE_IMA_V)) {
+	if (!(pair.value & RISCV_HWPROBE_EXT_ZVE32X)) {
 		rc = prctl(PR_RISCV_V_GET_CONTROL);
 		if (rc != -1 || errno != EINVAL) {
-			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without V\n");
+			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without ZVE32X\n");
 			return -3;
 		}
 
 		rc = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
 		if (rc != -1 || errno != EINVAL) {
-			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without V\n");
+			ksft_test_result_fail("SET_CONTROL should fail on kernel/hw without ZVE32X\n");
 			return -4;
 		}
 

-- 
2.44.0.rc2


