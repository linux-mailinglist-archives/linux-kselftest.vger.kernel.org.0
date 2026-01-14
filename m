Return-Path: <linux-kselftest+bounces-48981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE61D21820
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11112300B379
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E783B52FC;
	Wed, 14 Jan 2026 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddWWI+FR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FB3AA19C
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428754; cv=none; b=enLax+RkrogK/m9VoyFrZ6lSh9Hyk6AEEGT7oNXmojPugB2bTEQsESvmQQ3LEFfqW8cVEjZynmsBhPZINC7rySiaqILl/HwL3pLNmru8XCcZkvZwSwGKI9poSB5VVVikWK0T5WljcQfXmcRhZ7jd8pvhtaGdfw8E7aZ6+EeH8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428754; c=relaxed/simple;
	bh=v/6ny77OEhOTDZTQ79j46inEoAHozIzSVLV54SqB5XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2iT0526lII0doXMkv47yR2cyAsStg+6HQxManEp8hAXx5uGysq0YX0noYBn7nZs7phbJXWru9tKM1lZU9NKHYDJL96cLWc8xOtqwErCGfvzp+4FRklhYtWaAyyfTTVF6rietEeTjmoKJKnoF7VkJzcpAxmLVMZlqSnFeEQCZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddWWI+FR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4fb68720518so2553301cf.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428743; x=1769033543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=ddWWI+FRLumCuusgHg2nvzmSWJc0Ve1vPjN0qxW3mKB7ybPluQdol7T3MJfDcaW840
         woR2r49G1wj9G31aWOSJptkBrwK5yQYUUWort0yJMvFhc/eCEfv3tvIGBv1BFkACMkOt
         k/7Z03hf5gKEn9FPVZ58A/PM4/xQ4vSZHtGzS0iInqeZP1ypwBUJ9XYby7Lprs1gXkCD
         9DhW9BUFb3+5iWGkVHx7MvOzySCwUNXuSIq5Y+xraCVPkYooFcBqV09c97aPqYY5VMbN
         K24M39GB9uTFdiYO2lx/wA6VfiNWIEupMYhnCT8UkuSeT0dhtFZAlDx6qxzwcRlsLcIW
         2seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428743; x=1769033543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=MG+b9luYTSN+wOpfs66dDlJ5PnXbxXn6k3Z0Ka630YXaArgGV/E8D8vKStWH9L8y5U
         VO0swNxu2W/azUDZdgbjFFnlS6QajJDt5rENHBs2kZVwOJaulKX1vP3warVVelqz8vwl
         +EHWuTYy6sNrxKGXImYP+iqfL5PIrsOil+dOfRAFO8xH0pasdqyHlM8tCs08Gxzz5+Lc
         XmtAsyh2Nyfsn9P9XiMI/0ptw08I7ie1PwGwL2wB874iHAbY8gYfvDFGcSEU5xmXA4AA
         5DeZYwUIbyLZkF62ktE8LdF+6WwabrjoiPKVFkoguSAlr+gmLrUqN3Nw4sbXGEyu/EX7
         8KKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpnSvAOyW70XGTGMKpyUHkR7Sq0gHueyqbS77ZyOFbC28FkMK9uQFSspf++MjXpnlZPrju3gXv3S4CfcUv+Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTufPXtbjZbGZL9XVoH4kUATPULURG/1isSFHlu0kuMy6/LjJJ
	673Drcj2+CAi2kXZsWLwatQdoafXgYN0FzNhzWXT4MlZa8OiQBtdqLv3Gkm2Pg==
X-Gm-Gg: AY/fxX6cbY2B3NuL2B7TC5ySfoaoBhMKPBsxc+/ON4GwrGcYw1F97tJneaS6YURGxjZ
	1YAvyHOEfLRsLejG8BuQssFIwDuoNLdArElaVmbdgHzc4KDM6rWo/L8E7vRA5ZzDzyXoGEHc7kQ
	LYlL73KCK4SFCItAFpXACQp97Ii67f84cqqcBmwfYQWqp2lDjIzyOZULmtGo3gblc08Bjhgi62Y
	zTrK2aMDwf9E+mdh18rAzabz8tEpbJzKrd4KkxdJQP9LnvSPBTCapPh9hTcWqSG3raYEbHd3mnU
	6z3nzKymVAfXmpobzwL88EbPTKVUIRpJrwrCEETY875lHQy+4JlFDu9C9OvqdZwCsAHnAlTIgaE
	6uByJS16pA0ixeh4aFx2//7xXaQnoTDEIlu7HHpscXWMHGpYeDy8IaC2rKtSMKwpMtecIXEcg41
	BtSj5vcjGkIzkiMr3CRxg9Uy5L5xzRrQGdOsCUqzw0k6KKqCSCR3o3QqQRqH8a7UVb8CFLhpw=
X-Received: by 2002:a05:622a:ec2:b0:501:48c4:28dd with SMTP id d75a77b69052e-50148c42c2cmr38121401cf.72.1768428742964;
        Wed, 14 Jan 2026 14:12:22 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148dd766fsm21715341cf.7.2026.01.14.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:12:22 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 0/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Wed, 14 Jan 2026 17:12:16 -0500
Message-ID: <20260114221219.127777-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends fprobe dynamic events to accept a comma-separated list of
symbols and explicit/suffixes.

Currently, fprobe only supports a single symbol (or wildcard) per event. This
series allow users to specify a comma-separated list of symbols, including
exclusions, and to select entry/exit explicitly using /

Examples:
- f:[GRP/][EVENT] func1,func2,func3
- f:[GRP/][EVENT] func1,!func2,func3 (exclude with '!')

Logic changes:
- Refactor parsing logic into parse_fprobe_spec()
- Support comma-separated lists and '!' exclusions
- Add / suffixes for explicit entry/exit selection
- Preserve legacy single-symbol behavior (single symbols still accept %return)
- Disable BTF-based signature lookup when list/wildcard is used, since one
  function signature cannot apply to multiple functions
- Reject mixed legacy/new syntax where applicable (e.g. list + %return)
- Update tracefs/README and fprobe documentation
- Add ftrace selftests covering accepted list syntax cases

*Patch order is adjusted: code first, then docs, then selftest

Changes in v5:
- Reordered patches (code->docs->selftests) as suggested
- Addressed review feedback on README help text to show both legacy and list
  syntaxes
- Added missing traceprobe error IDs used by the new validation and fixed
  parsing/bracing issues found by automated builds
- Removed the dedicated list_mode field and infer list behavior from presence of
  filter/nofilter and keep struct trace_probe as the last member
- Link to v4: https://lore.kernel.org/linux-trace-kernel/20251127151218.4763b25c751bb2aac4b1ee36@kernel.org/

I am not fully confident the runtime testing coverage that I did is sufficient
across configs/architectures, so additional verification would be appreciated.

Best regards,
Ryan Chung

Seokwoo Chung (Ryan) (3):
  tracing/fprobe: Support comma-separated symbols and :entry/:exit
  docs: tracing/fprobe: Document list filters and :entry/:exit
  selftests/ftrace: Add accept cases for fprobe list syntax

 Documentation/trace/fprobetrace.rst           | 18 +++++--
 kernel/trace/trace.c                          |  4 +-
 kernel/trace/trace_fprobe.c                   | 49 ++++++++++---------
 kernel/trace/trace_probe.h                    |  2 +
 .../ftrace/test.d/dynevent/fprobe_list.tc     |  2 +-
 5 files changed, 47 insertions(+), 28 deletions(-)


base-commit: f0c13b210e4366e03bd9e8967347b06b227e20a4
-- 
2.43.0


