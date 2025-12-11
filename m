Return-Path: <linux-kselftest+bounces-47387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B37CB4BF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E293025FB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE3287257;
	Thu, 11 Dec 2025 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nj/B95mi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4128468E
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430200; cv=none; b=dAZyMFDaWYjIKy4YRvJmajAPd+KfxNx+293DPCNS5qu3slMtWpMIIdbwEK81pxfEV9oSkmFcCEeFYo2yc98an5m5dYqSbmEkqNfVytG0HXbwcaK8JQNK8R/C7gSp6kGPpQnlmoaNrM6VYtuBbDhuWI6x2Q4809T6kGUWGu3SSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430200; c=relaxed/simple;
	bh=ugv+L91iD/mMt+noj9DgZ/5IYV37F5CcVIOzFhnzFT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osmb9v6d5sx921+oGZV/eQbGr8BX2yc14yAUSDayLidk0LN0gumNkMRqjZzA8upNRRT1gSWj12r2QiWJo1CGmEo4DGZ9tFzuAAcSpu7AUY3IUiyAhrRRGUD4AGRocvLfUgIEbItDEFHVYvD55PwVyZ3Vit5oGNInMI9sL1mQYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nj/B95mi; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8b2e0a2ffdaso12708385a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430193; x=1766034993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTqVrM+5dB/aV7gHI1xfO04fFWnueqKpNcCVf0mzNKQ=;
        b=Nj/B95miIPSr2sIWs0H87r+i3K+uNy8PV6XxYLe2ANopteY7u0954rSK6jP6s+9qfJ
         CF/9aeNyoXDuEw+iDsQ9Bru6wRccI5jK1+gEK6y91Jm1B/WQeT20++28aObd+SaY3j/2
         aMUjHkPI7CMuYtms1fvliBjA8LYCYfJ++bCOuOsWOQDU5khx9azO8S1K4mAyqCtiyNcu
         6rYCQ124u6Jw2xcuwtBtJd9oTWtW67F8huw4KD3cz9E+Lmdqq4amyal0H0rvjtfHIVzF
         fXIT42+mmVnFCszrqgzh6ejGESx20ojMPmEXojMrMt8ZbLflr94/Nx3Sn7zVHnMxslgE
         7u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430193; x=1766034993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTqVrM+5dB/aV7gHI1xfO04fFWnueqKpNcCVf0mzNKQ=;
        b=mf9NLGyPD89LHzxrduB4PdkoFTT1pHqoqq8NPKQoAbchM9nqEDsr4reshllsVPed7z
         79By64RacTdeu3/YHi+WfoPILirbpF1Tszo4Nw8rljYnMXe+9JJX/5epsAXKFtJnFxPp
         vg6smT1fgkPmSedXTffjrGet11X2eKl4TCi9PJvEMgebQEaZbRUB9H7C1CNyN0l+XT3q
         XxKwMhZp9iCplYlbC/hEwRmIihJvnEK1qTkROLu0U+iH8vxai9GdxfzgqjCRohOpJbRT
         wa3l+vyImqcsU7QojBJXiwDHsk4QttMITtmtc45PY5iodvOwf35771KSchBazNc/P3ok
         HtNA==
X-Forwarded-Encrypted: i=1; AJvYcCXA7A0tTK2p+kWmsBoN+3WBiIyC4df6i3Y/41ie0mm2q+uSBzQe133ZxRHYmvS/AgoM2sbLARlQSb8Dmxl4Lq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4NPy7UCFBWln95JoINai4IzH6BCL1NoZIQAgAUU+WfwPMBK0
	EF27i6EhAu/oubJL5GTVpWOnTkOJgpRt9M1v98Vn/usmNzBQaOLdauJCeZOx34FFsBNfF5fnX8Y
	OtwApXqdLY3r6N0XaoP9/GFWwwA69nv6aOqGU
X-Gm-Gg: AY/fxX7UcpL/A5As5v8DEhg5bEdj+3ZKavBglDc0NN2CtDGIjLgwfCwKlwKb/96chLS
	ai5xxadWPG5xotu9fqMEhtqS95Bjjfu8gDGGffrmPnywKBkmj6YK6/Os8hkRJvTZ5BhPpzodXBc
	je5Lr/TCXilYfY0qPhl/iGCeFA2WlNOz4tIpfgWVBGiEDAw0TJptjhPPpuiCwKD+OybpijpKX+n
	fpExLDhmnqpK9ebicFFw9RxDnN4uLs+ht4fmUMGdu9IFyOJ45c86TZOxNM2sSaU1ayM9jgSDuhp
	APaLQ/LEwV6ZZdUoLYfpyWg0A3FjOSQ4Ei9Eu71lApUMXStfFGV54J2SPYRDNjHzydg34PYOHwK
	tqNVOLQ4B2QTnVaUyPs1KL2S4G8gZSkV4ZJRSJEFBjg==
X-Google-Smtp-Source: AGHT+IEVMLDi+M2lvlTlTsrMZUIr2MTV2dKnDHRpqfJSsfAFAo3GmlWwvbybr1q1ad2xu+lmxYt/buCaOMKm
X-Received: by 2002:ad4:5de1:0:b0:880:55fc:c984 with SMTP id 6a1803df08f44-88863ae917amr55498616d6.5.1765430193191;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8886eedef55sm2845916d6.18.2025.12.10.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CD284340B96;
	Wed, 10 Dec 2025 22:16:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C9DE5E400B8; Wed, 10 Dec 2025 22:16:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/8] selftests: ublk: remove unused ios map in seq_io.bt
Date: Wed, 10 Dec 2025 22:15:57 -0700
Message-ID: <20251211051603.1154841-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ios map populated by seq_io.bt is never read, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 507a3ca05abf..b2f60a92b118 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -15,11 +15,10 @@ tracepoint:block:block_rq_complete
 			printf("io_out_of_order: exp %llu actual %llu\n",
 				args.sector, $last);
 		}
 		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
 	}
-	@ios = count();
 }
 
 END {
 	clear(@last_rw);
 }
-- 
2.45.2


