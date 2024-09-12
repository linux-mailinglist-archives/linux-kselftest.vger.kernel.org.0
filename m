Return-Path: <linux-kselftest+bounces-17879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6919774ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97931F2500F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 23:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029A1C6F6D;
	Thu, 12 Sep 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YvcTjC5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09C1C6F59
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183058; cv=none; b=j5p0CNmf9UYZKJLK7CyGgAP3n8pC7HeyPaEDpUSVw423eM5Pf6c2JP7fYvNj+aaXPGQ/aVQ08FdRD53D1vGVoGW9XTA9aw/7OgGCHxSFxstuLezCI4iaftK8EmbLsvBovS2sTefBgBVtLA9lyOt3LQw0kCJvSrMW9FsUtXYoCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183058; c=relaxed/simple;
	bh=cwARFgjF2bUwAreZrfeSiuKLNwifZh7gPR/VBRlAnHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7oJxSQxkMhqxTh3qT/EuVexWNIeJDx98Nc9jNkVRZkfvQ2BEe9OGixedU0ecyjIGx4E9RBmvj/5IkCgbYXIi19JuEEaoI02DPI8UUqUDv2zYb+KPGhPaiOawq1b8cD92JWXHaGqG/ES0QRyewr8N0KHCI1DrYGkCeMskupSkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YvcTjC5h; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so289045a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183057; x=1726787857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veWGRHreCjgq8h7I/yOaDBNsZmlAimjJ+4EKqlz5IR0=;
        b=YvcTjC5h/5SNi5RsoBQt/PvIyBz8LMpFFwQr/jd0RU2tvfNt5BbzOgAb3dHMOiKcun
         BE0qARaMKoFjcOCThWcqOxxgT/qVs24vmCyClpHR8ETrOKh+GftGjvgWiWsprHblBzp5
         nGzaz0oCIRajl9+gFUfZw+rONPhVFTUhJdaZ+1fZCm67AR/9W6UhSyEdgRjnReXP4zCk
         lQIol3cB7zdkZPxHRMiQAtHFc2cjyYFKIWnfspEa9p0u9QLplek3nz7XT1BxctrxXE3p
         mwTc9dC8D8AOTNkq5KnNaihZLIbY8VMchIphiUF7ZvMcjbIS4YqzQ7a3EYbLlv7EAng5
         eoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183057; x=1726787857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veWGRHreCjgq8h7I/yOaDBNsZmlAimjJ+4EKqlz5IR0=;
        b=Vf6Zz0tQIx2wVA4ZsVmzSK3dsyI+AZzrKl2cJrfs5kiwiZhpeUyYLg6qOEY8ufLgre
         FjHoRwZiHo98ShwjupsWrztjrAI38pScOyycAzyFDObqWFiFZ3ZREs73WXl+xGYEGwoP
         lanzrNQ6MTgn6G1cfHp8Ly9UGCQ5NkCvhXc8OTxITBZyptnLyGhxRm60tKqXGjexwnZb
         n2uwMX1q1+wnnIg2Ass6AGiFHI3E8FQNkFjr562zxjSQjoAA8qr+5OkP8vZTGvgd88V/
         CKZ5FthsmmNHpB6Rhq+wjCOY96MI941Y5Gm4tmT4G9nL9Pw9Qt1OdaLKdb9nE0cUWelf
         bpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeLT4f3sYJCiUHmI9lklgYV6Y0YQKc9QcvXP5WitJojCN/ZUhpvpl02jgae5bPeH4ZHQGnTsCQN3o7K/CYpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGDekiTPK1cQTzkGDfwxQgqeQhq3RgcsQ2qti4jndYp6MQDiN
	Tbv8yXx3iC7AVK3d5kTGALNGK57vZCquYuGq6ZXVA497SR5UMH+Cdo4vfenxbKA=
X-Google-Smtp-Source: AGHT+IGi2PGJAtalAbRDIiYrcdX60Gd/jBapQHqvC1T650woNs+55FVEzfftOtbKP4fBLGwK941M2A==
X-Received: by 2002:a17:90b:1c88:b0:2d8:9a0c:36c0 with SMTP id 98e67ed59e1d1-2dbb9dc0f39mr1063170a91.8.1726183056629;
        Thu, 12 Sep 2024 16:17:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 07/30] riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
Date: Thu, 12 Sep 2024 16:16:26 -0700
Message-ID: <20240912231650.3740732-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..b7c86fb91984 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -361,6 +361,18 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity as ratified in commit 3f8e450 ("merge pull request #227 from
+            ved-rivos/0709") of riscv-cfi github repo.
+
+        - const: zicfiss
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity as ratified in commit 3f8e450 ("merge pull request #227 from
+            ved-rivos/0709") of riscv-cfi github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
-- 
2.45.0


