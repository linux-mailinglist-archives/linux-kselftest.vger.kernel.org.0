Return-Path: <linux-kselftest+bounces-18637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE7298A31C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1C91C22B67
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551C19992B;
	Mon, 30 Sep 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsFZ/OwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975218E75B;
	Mon, 30 Sep 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699850; cv=none; b=U+hz99FGrHY6hAszUy0debyDcA0H851tRESy475tPO2DeRHke4wXAJv7jmWx4hCjwjaVO5jeq51PTyN+krUBRRUbWIXvEIha2V7xUcemqiWe/TX85CeX28JvcKIhlBDHYj9C2XoS8DxTrxmstIxwRlgbdBLJLJSyQYEiN8F8tcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699850; c=relaxed/simple;
	bh=GW4Rr+cbxta/S5ZmpjxvZFx9ik9IVnXtOs8zynR7mhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAn+XobYD1szzU3bOxplLWiOkN5Z5rnscnXLUd2EMWN9CFa4pl/KEgVeiE9qg7dnLJZ8jOrlKcuR0Qgyd1HHH/N6LljFnKGzfVURkyZkoEL2ZgV7B2VIN4RT5I05oatS0Pv5tvRRqOcEM6LDgB0FHJBqRBSDWODavvoZN972tmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsFZ/OwI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb806623eso33176005e9.2;
        Mon, 30 Sep 2024 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699847; x=1728304647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlV+nN18yw3drRT6eHy6/2hr4o+8F6xizJomHusoOY8=;
        b=FsFZ/OwI7KVPedAXZqL5RU0ZUugr4Zw+67NEpEiS5v8V8+ZWxG7pC8i4zAJJ8KwtQy
         l1XoqjmmCa1wjsiSO/MiKOKHGF5TBa6rdh+P9vCFT3YwKt6pMgEG1Xi667CWm6JEFWOH
         km1Q9LB7F2VhxdismI2warTJYwUFGIwz3jjEoMfTugzMGfu/qQVEGDFTI1UJicLZGIoL
         CfILQL4OT28EeROA8kVwZt+5U0IMGhAAIxJLxzLiZPHLs5ZpuQXz9ECoq+WhnuTR8wN8
         9GX57spLU+o8+CpLXOpI+2tI1SGfzYtHvsfsYI4GbUb6FG4bHv7P35uSlsEsPJ4TjUv0
         OOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699847; x=1728304647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlV+nN18yw3drRT6eHy6/2hr4o+8F6xizJomHusoOY8=;
        b=eiwTizJv3GQxL7ta7cb5hG42P3tR1377OPuM00srtHsPS8K+uIHDobOc/kZ2dIhwNn
         P9Q7WAvrcO2KVGXt7baISharXhWd1y1Ni/ptkvm62S6FDDXx/huIR5Me2z5lxFWt8Sya
         XsekdbHTR9s0mv409ZoIDrW46mkS2bahTnSikHt89AzCFAWsQQ3xVNEP1uIIrzCotdhf
         joKzF6QhJqnbtdGglFL1OsWmD2BeWgL1QHAqdWVN9GWXuQznq8yCq3p68UIEph/qJusK
         huI7cR0P1Q0Djn8Fv8RFJ99UMHZ1WokHwIIRaZTY/LxOvRY9bo06RoJSHsLiEZt/wmi6
         awAA==
X-Forwarded-Encrypted: i=1; AJvYcCU2xTsKpvKIk1Y4rm/5OTWQtd2f6aKpxyzhSE2W5PncAwXSLgxNvY1GRltXN46DjktItW4wDq26ooivtQ==@vger.kernel.org, AJvYcCUCRLaHzURFZlO2jrjI0EPad/wZjvtUXbMsal4nIW+Wd2wHCeE7GsOZWZ9poIJUmw8cWYTkZiJhlXOwlYvYbq+c@vger.kernel.org, AJvYcCULhTFaS1sYq8V/9l+bFs/YsUQnmMC4gUHr2cO0awxmvD9D2xHHyM+iWDF3Yu792NOXiNp993anpRwxyjdr@vger.kernel.org, AJvYcCUakEnMmUDD8pUcSfmgYJjqtiVh8+lOylgQmbBFIB9RY3OmYKoAdl5SAKta4zjevy5tAaa9LMlZvnP73Jo=@vger.kernel.org, AJvYcCV9n5L/kJVXo8CdaZ0XILUN6dlVoqE5G+cjlwZORNJaTa4PvFi8PgtEZYm2d3Kwrz8mSn0=@vger.kernel.org, AJvYcCWgi/vrvR+JCOCQth3bMRJ0Y1PK565/stKaNztCFSMDxMcUPSSyGpW/6+NElAMJg3WUZDr7odaGcfK4DKfI@vger.kernel.org, AJvYcCXIQ6OqXhSsOx7D8q0mPxUMn54qvPgKO+i+6USbkkCGogmwdqwqRV/aWNJK1zxTc1+xb2UhVN7XjfnQQd6Z+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/f43haz5vckqIhAnRLvYERRGX2AZDiKi4hh2+Xw1gTFJHxBZi
	EeZPoCwGnuLUvJeYwxkoq9MVuDaEwiccSEDYz+XrMV412GyWdDDv
X-Google-Smtp-Source: AGHT+IE0AKmAHzGMSeF7N4UA2hEqVXGKPVEVP5SK27gagSW7PpUlsTlU5xb3Nv2RVaMagE1IaBh5yw==
X-Received: by 2002:a05:600c:6d4c:b0:42c:b995:20ca with SMTP id 5b1f17b1804b1-42f648a27f0mr40922015e9.24.1727699847144;
        Mon, 30 Sep 2024 05:37:27 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 14/19] bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:25 +0200
Message-ID: <20240930123702.803617-15-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index fa5edd6ef7f7..2eed1ad958e9 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14,7 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 
-- 
2.46.2


