Return-Path: <linux-kselftest+bounces-41604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4DB59CAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06C5189346D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B7371E8C;
	Tue, 16 Sep 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjxFln4l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFB341670
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038218; cv=none; b=n5c2ajk+GaC/F91vLEMQ/yH/oM1KoLtBc8i66Ss4/dTrYie4zo9Q5jiXyPVaSh5Qb6ohCC0y6EFo/dF/t7Rz42IPnQeM8Ic5auDwr8QZqULtJdb9GDPrNtpb5m4HEAwVa1yZI+gVlpUu7iu8YOfkJKWH7sICBsJw89yVnym1exc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038218; c=relaxed/simple;
	bh=IRzTmLRNWRkXwuFptgz6+mmRL3Z2PH68tG2vbcPSId8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qb8EDTc9jFDAdL4mYUvwW3Ne4/ewmU+E+3EvTyDk9MJ+2Hkv24Q7mkvtTSoyOnFoYNgcB/dJORgRGFXqvmi9/Itczn/4L3nto1xPtNV5ixwPYNxY2z8YO6L9cjBVdJISMJ7UL1WJkchK3mxQ/BzfJ/G/BbrKF3Y1EN00rScFooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjxFln4l; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54b55c6eabso3484746a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038216; x=1758643016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiAINEhVsjWg8ki6Sy+j8WcDazb+q524Nc68fNbvg74=;
        b=AjxFln4lyiTGkSRtI44zl8OPox8ykTfyKO8IHj77PjF+kr9+8XCbQt9/ar5iJMOxyW
         TTFWMjXMoCgJr/Q4XnHIrEH6zsy1ucwq4wHkvBHJrauAf7YADvJcnI+bNnZonYVBC4io
         HkZAgZq9Et8xxa6cK1aBHy5nzwqK3vUzKk0+PpK8sJmYfo4o+YxSJ4eCi1bg2piAuxz5
         WuOYYnljvwsZEje/hmQ5kEp3Qw2ZE874Q91WRJZHKDaDOqmQ6DViAejw0Bu8cIJDbMF5
         1NzGPXtuTdGmeU3QOWgKX5JRWJ5YdoX9i42Qst9Odij6AduPpKQjBXtNMcgf5gTNcw0y
         VHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038216; x=1758643016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiAINEhVsjWg8ki6Sy+j8WcDazb+q524Nc68fNbvg74=;
        b=HiITjBteFitc96OEF3atJNauKzmqhTGCVLhb2uftFrmOdjLurO5ljQI+OuOCOsqRgz
         lgYuIU8gLB6d8SAmLwR4jZgP1AVa0PPPwH392o+EfYWx45xwdhzr+rd6hEPSNmPF0fvl
         Y74amun83H+Ta/BO09O6DgbexcUX7dwox5LG+MJyc3yi2VIhBQvjLupOLWqvlGj2XE+z
         jZs8azakhWfWf8KMkmjajLZZ54PUBh8+eXeHh5fIjkmSQ9spspXytvFcSVEHbbHjQeeK
         ndXYFE2MrcOCy4wEsEes+4+9hD5Sp1juewBHj9OdTfiXBSNQUHPcD70ZPEONiK0CWvQD
         9elg==
X-Gm-Message-State: AOJu0YwZgqHxABpl6wEW1seg2H1Ml06ZzZMwvMmzHxMjK83fx6K6WUVB
	gkIuCnEclLCvmeDFk/g2a+Kt/vqcLdSXwOWDi2OTUfp/YvHpNUsRHk5o
X-Gm-Gg: ASbGncvpyoau+QKD6OfrvMnt/DaOuj4GOJUfHdumF9HAtCmZw8yscFFWkGikWry1kdM
	DfLQv3I+EezDj/Rw8M4UVXU7855wCTDD5kHYL8QxMUwUX3WqwqfOAYQllSaFR0UnYLH52w/iJ1k
	x26GWUlv4rhU1xHQj94ha1Z5IQF+3s7YcRzdnP+K05odiHisZk/umNEA9acYhKDv+gc8AIcFfgp
	wiwuxrvFymjEUDIpFyfMgrJGDqaXVAPy01gDzJd6090bkAEtE4GlSWJYmWzTYqKBWmLRSR/FEBU
	CmJmU61ZqlCmIO4zgVC5BkI7S6kR3Rc4T+ncAfN2XoUJUU6F5iUKoZ/iQjJO9lFHj6+n5dQVjT4
	37gJeza/PZHRHPJAeccH/+mIqbzfupPb5YSpwz/upuaTzam+vspi0j3If8gW1
X-Google-Smtp-Source: AGHT+IE/gas2vRtfvf0jFsXNDu2Tg/is10TY7CsOk25OmfpGAOAy9tXtVXYdoht/7haciXVgTf44kA==
X-Received: by 2002:a17:902:e545:b0:267:e097:7a9c with SMTP id d9443c01a7336-267e0977cd1mr24188785ad.53.1758038216190;
        Tue, 16 Sep 2025 08:56:56 -0700 (PDT)
Received: from laptop.localdomain ([104.250.148.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261d3dd029bsm101320645ad.25.2025.09.16.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:56:55 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	Xing Guo <higuoxing@gmail.com>
Subject: [PATCH] selftests/bpf: Add back removed kfuncs declarations
Date: Tue, 16 Sep 2025 23:56:49 +0800
Message-ID: <20250916155649.54991-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These kfuncs are removed in commit 2f9838e25790
("selftests/bpf: Cleanup bpf qdisc selftests"), but they are still
referenced by multiple tests.  Otherwise, we will get the following errors.

```
progs/bpf_qdisc_fail__incompl_ops.c:13:2: error: call to undeclared function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   13 |         bpf_qdisc_skb_drop(skb, to_free);
      |         ^
1 error generated.
progs/bpf_qdisc_fifo.c:38:3: error: call to undeclared function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   38 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
progs/bpf_qdisc_fq.c:280:11: error: call to undeclared function 'bpf_skb_get_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  280 |                         hash = bpf_skb_get_hash(skb) & q.orphan_mask;
      |                                ^
progs/bpf_qdisc_fq.c:287:11: error: call to undeclared function 'bpf_skb_get_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  287 |                         hash = bpf_skb_get_hash(skb) & q.orphan_mask;
      |                                ^
progs/bpf_qdisc_fq.c:375:3: error: call to undeclared function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  375 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
progs/bpf_qdisc_fifo.c:71:2: error: call to undeclared function 'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   71 |         bpf_qdisc_bstats_update(sch, skb);
      |         ^
progs/bpf_qdisc_fifo.c:106:4: error: call to undeclared function 'bpf_kfree_skb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  106 |                         bpf_kfree_skb(skb);
      |                         ^
3 errors generated.
progs/bpf_qdisc_fq.c:614:3: error: call to undeclared function 'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  614 |                 bpf_qdisc_bstats_update(sch, skb);
      |                 ^
progs/bpf_qdisc_fq.c:619:3: error: call to undeclared function 'bpf_qdisc_watchdog_schedule'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  619 |                 bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q.timer_slack);
      |                 ^
5 errors generated.
```

Fixes: 2f9838e25790 ("selftests/bpf: Cleanup bpf qdisc selftests")
Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 3754f581b328..7e7f2fe04f22 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -14,6 +14,12 @@
 
 struct bpf_sk_buff_ptr;
 
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_kfree_skb(struct sk_buff *p) __ksym;
+void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
+void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
+void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb) __ksym;
+
 static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
 {
 	return (struct qdisc_skb_cb *)skb->cb;
-- 
2.51.0


