Return-Path: <linux-kselftest+bounces-48627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1E4D0BA41
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 18:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D76F3004E1E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19DB366546;
	Fri,  9 Jan 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQBahsxX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDE365A1D
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979744; cv=none; b=QRO42gBKMhikHmiOMq0e4ms2JvD7Z+ZUjLSgrfRhXQt3V6g1StBMUWphcrAHgIgzRuadRwiMIOKkpVea+hFvO7EoycUnPchE1ilkDGx2um+b7CLhX9phh6c3oyOTwFc3wpKpoxWpTYM22eaZFk/w+dAlguq74RSa+ZMEC4mwdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979744; c=relaxed/simple;
	bh=1/l5R77pUR8ugOGX34HyrKOP4wsUDpK5m1qtPnOhuYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j288Zx+tBT7BBKpdwqyXB/8DsbN+NwNnaMzb3u6cwZxSJ9mUTGSSlNzikNuA8lOrFl4eRlG2Xr7y3kO2NaEiRBVora3/vL/baVrwVYisJz6l6KYjFtVBeTGzV1PWSCCPmsDWnqxMExeadpBkovHHwg1b/TCIHIzgtqZqxBhdkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQBahsxX; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6455a60c12bso4310271d50.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 09:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767979742; x=1768584542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKdaUjJqG8oeq2ClRcu/iEJwRqPBhkw6Zp5ahsqycmE=;
        b=lQBahsxXPnOH/KZPTShPRqKHY4qkimUMfMwDJmnvp5szoxARTm9Ry9Lng2ScfMeXtF
         jH7B3aYuWQcfIKY7KlbLsT2Tl1cgj7vgmSyNekswLOvjWjDBOTLbFNPgUlk+Y02xzdJt
         o0SkjUgK03DW60+Pz82p/CxKylEdmU8gp1hMEdExIEhq9E+DedG+ibodIrg+tAc1cfd+
         YY/F8ZV78pb2TDRQ/8zzBoferookHqj0uvbJvG8xDCy4cNzgLj1+ICU57+N6GGRyRrg2
         36FO/1E6CzwQTtGS5XD3MY3za+vY6CohV6INXolnXPPLXlFHYuxz+hJ0DWkKikxSDpR6
         keqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979742; x=1768584542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKdaUjJqG8oeq2ClRcu/iEJwRqPBhkw6Zp5ahsqycmE=;
        b=QGgAi+xi2P/bErofSGuFIPnJSSjbZmQsJJmQu+7FLpPziOiScS1P5jiTkY5m5ZThZt
         WNbUufqbIqVSEC0svS8952UvG2QHv58q6lmrsQNrWcFJfriBGdpQDIMhbXudWBTDgp13
         Q8iGW82O+8X2n8gwVRrZFiY8E9IKlmFEOBbfPyB54xBIozRMUjn5+ZDleNAuY/YSgaIW
         SEbOgJ6owXwCTfKTrrzIPSZJnlXh8zJJ6J/0i285y9uBwE4FqS7dnStp/Ty1qsUYvx+K
         o+u1WcNoL5lmgYWHQvJOC0gEN0/AFpZqYzz9RdGLu1xcSyMfSxvqqBP7iA923D1Votsr
         FuTw==
X-Forwarded-Encrypted: i=1; AJvYcCUhoWEBYEtmxgBrnvrRA2m2Yn+HXuVisXTJnA+mMM0Pdc53OTggGHECCuoNUNbexsMHfuLDQcuCdc7iwsdGsaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/n1q4EJjtLjtX0A5WzqSaORP4oJ+ilBflbpxm2dxzDkA/MJE
	/83nGo1dRsDTJwvp+OJiTeaEgwDDuaxGAQK0H0LrqzBwz++o2HPWakDd
X-Gm-Gg: AY/fxX4IDw/ynBqbwR0Pguqj0pD8N/abzd7CsXWuqp82zvkJPZAX8w/WozGNBR9aHjr
	KGVkfb68kbJGQTh1nFEKyikzXkuupoTYDoU9ceJhpTIUVRrqnKRIrbhaT26/L5M1Gy9KWLSZOfG
	xnnFyYikDMfDmsY+OGfYdaT1qfsnTTgsddvN1/BHbrmoQC08D93mVtOsPhLqV5qK17bIWhLrYQX
	RSJTi3+roLvThFDTrnfv7IktsIBO9XYZyKPtWYzb5HjZhi9qmbFZkuyKRozjglO5BA2wWaptKQj
	NbZJu/49DMhg6wK47iYiNw94fXgxhGGC0DLHerfdPrqGbz3618o8NaKBaLa0EHsPsFeDwhVTCUS
	W9sgkaTorl34y4E//eaDXTiDIsGBw5p4GW5blGXLhjUCH6wC8lJht2WIBp9TlGBXBaXrVG3ITjT
	9Y7AvOPdEOLvCrl7sXaPxTwkT+ISAzMJ0qR41+Ts30UysTVgDMcjETjtERSbdCsOLDz412BMgM7
	sVUFNU5pMKvkg==
X-Google-Smtp-Source: AGHT+IHucay935+PHPaRqMUBculLyFxfPX0jedTkWAnBd1oYEZ+/yHB0cl9/8egf4uBxzRx82kDPfg==
X-Received: by 2002:a53:e03b:0:b0:644:6c79:62d5 with SMTP id 956f58d0204a3-64716c797b6mr7021100d50.83.1767979741960;
        Fri, 09 Jan 2026 09:29:01 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d607sm4721595d50.12.2026.01.09.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:29:01 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] selftests/mm: run_vmtests.sh: fail if invoked from the wrong directory
Date: Sat, 10 Jan 2026 01:28:33 +0800
Message-ID: <20260109172833.2989-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108031604.12379-1-sun.jian.kdev@gmail.com>
References: <20260108031604.12379-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_vmtests.sh assumes it is invoked from tools/testing/selftests/mm.
When run from another working directory, relative paths can lead to
confusing failures. Detect this case and abort with a clear message.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index d9173f2312b7..b7025afb56fd 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -5,6 +5,13 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+# Verify invocation from the script directory.
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
+if [ "$(pwd -P)" != "$SCRIPT_DIR" ]; then
+    echo "Please run this test from $SCRIPT_DIR" >&2
+    exit 1
+fi
+
 count_total=0
 count_pass=0
 count_fail=0
-- 
2.43.0


