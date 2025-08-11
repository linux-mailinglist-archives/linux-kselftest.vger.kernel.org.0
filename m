Return-Path: <linux-kselftest+bounces-38666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F08B201C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB787AD5EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054E2DBF5C;
	Mon, 11 Aug 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVk5V2vX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B882D8DAA;
	Mon, 11 Aug 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900729; cv=none; b=BXvFvInAT0Ir+OifWwe/PkD2LxAqAWoTqW4acs9k7rQfyQ9pLIQC6KFCAH6aAPIBirbt3JaMcjOk/Ik2KhJWKaeEmKEcCOWO6c5zuG7WZp2OHDvaVgtdAKd/pTgxhtDSwrqGsrxLXtgCrSU3kdHMHZH2JXncGjoKxD1NKRmT9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900729; c=relaxed/simple;
	bh=GD0CZJPipj/scvOiwO86D4QvWu2bhvyPoPfEPeM7R1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EShq22+XHaH2ScD01Hau97M4hqDGBdo70RMFXTvDgDjXS5HzN3xfCh7Plt5HBZZBSSD0jmerqTsZJ1SOEyp7dtmzk76GgHeZT7gtdoGFJEQGcYUMuU1j5nf/de4PBiU6Vv5foOI3i4rzCTP06A9ePbNCEK4LybPRgRPFUN2tk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVk5V2vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC748C4CEF7;
	Mon, 11 Aug 2025 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900729;
	bh=GD0CZJPipj/scvOiwO86D4QvWu2bhvyPoPfEPeM7R1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVk5V2vX3KTa6TTrst2P85RRH05lSqF0XHkEtbdHC7XoprqtDZ1clLzEoeeQ8KLuR
	 U6PvynDjMIG3Eo9QnHWbTT+EKN9IVGPnwNaBEfjSi/uckjWPQn7KJFqgA4CacMTKw6
	 9wUZQVsVqwXh5eewwvehW8hxHCT52OMZG72LMZ8T9+490eIS1WoY9Rp1p+4OcK6hqn
	 Mzc/g6UG3olKoudsttAg9N2gc/ZMiXq445iE0fnbZLPRIy/im7Pd+LUShSAu+DHdfu
	 ep2YrMSWxgbIEqnKPB/RMVav5E7YKyX8IPyz7mVX+c1mKshftSmB3rxoI1wNbJ3ddY
	 PWpdlLQJ294vw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] kho: allow scratch areas with zero size
Date: Mon, 11 Aug 2025 11:25:08 +0300
Message-ID: <20250811082510.4154080-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811082510.4154080-1-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Parsing of kho_scratch parameter treats zero size as an invalid value,
although it should be fine for user to request zero sized scratch area
for some types if scratch memory, when for example there is no need to
create scratch area in the low memory.

Treat zero as a valid value for a scratch area size but reject
kho_scratch parameter that defines no scratch memory at all.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e49743ae52c5..c6ac5a5e51cb 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
 {
 	size_t len;
 	unsigned long sizes[3];
+	size_t total_size = 0;
 	int i;
 
 	if (!p)
@@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
 		}
 
 		sizes[i] = memparse(p, &endp);
-		if (!sizes[i] || endp == p)
+		if (endp == p)
 			return -EINVAL;
 		p = endp;
+		total_size += sizes[i];
 	}
 
+	if (!total_size)
+		return -EINVAL;
+
 	scratch_size_lowmem = sizes[0];
 	scratch_size_global = sizes[1];
 	scratch_size_pernode = sizes[2];
-- 
2.47.2


