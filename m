Return-Path: <linux-kselftest+bounces-18029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F5979CE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7761C20A9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0E13E03E;
	Mon, 16 Sep 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsuP4mBV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC14E1CA;
	Mon, 16 Sep 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475898; cv=none; b=rPb/o0Edu+7ay+3G4HUmfCrtkqyEaaJKkHtwAeD3xIFT/aN97m9/nRjj502PNo8Lq5Mfed1uX12PbchZhrOtTSW+2YnfzlJ/kRyGv0NfYV2fAXWrcAX03fPRhmkXQFi9W1LCQGvlPEvTRyCMn5I+ygd9bVsw0GKUVcY23rhcdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475898; c=relaxed/simple;
	bh=UJoIZbAwd0dcyPldGPlUH3SNsQcKTlS8LGIL6P+fhDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGqRR/ud+YK6kJReHwnFcAaPQEmK/brVCOcQb+49VfDENgIsnavKyrGFT8c6LJ6vVYqzP2/fZlyQb0ZUTi0aU3WflMhgL8sFTenVjaQg6Jh6eD2HbqQY/EI86CloAX/vn5NXt2WFLRs7XwPgyvixM3L7OtQ/VQLNfVs4itKBRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsuP4mBV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2db85775c43so2808536a91.0;
        Mon, 16 Sep 2024 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475895; x=1727080695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=ZsuP4mBV/w6iQRmvkxsHYmfq/LyS5Us9Z8z8oNpd/7muh2mNg4mNvMHBDgyno5ZL1q
         FyaFTKBSgC40wFdMlgMK8v4t+c57A53pUoRtj01+vGW9pKZcH8BL+EiLpo1ifHT9jaZk
         VORsKAG4hE6PKKe3axobyGYWb6CMzNA59FtH5qMsYZfsAxJuRFXa0ajr2nFOh7kiLK/A
         +JIadGzHorMFODCIy2z5UBYGqx+/QTwJZlra05bazD1VIusdbsBz5mIpJtt3sxnngjTb
         c83FUfYFL8x20hAaYvuJTTM+oC/j9YqSBye8AyTG72nAcZRj9zzysY2jLowzCEkRqfE3
         RpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475895; x=1727080695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=wF1iW5atomTZ2lhDhlzT2Sh4ONC9st96ld8Ou69gXYJaHfOSQsF+zXiDQLZ6vdxs27
         ugpazQYspRN5cdsnOOsShOmHXb//Ufxp4Mfcq3H3ZzaqLV9Cika+JflyyFwE3+3HdHlJ
         AID+OTDfJKCr1fA//GHUJxkGUiUM2Ty15BLjNhtqht5LdeUtPyksv2WfIPuu65CS87OX
         Vnjc+y8ZSOfBcjtY0apfmm9FfpBmC6Qr17hNRJYnjbk+3J9Kqk5czOCfmp9iMwnFzatw
         1jfJFwz+J3WHCjx8X9EUWckvGfxi7RMNpHUdt2iOmTlc9Nu8iIN+9my9c8ik3vfWMjXu
         DZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVCabD4VL3VP8U0O7dbS026UwXBtsGP8mzEoGviI9gzHCM2M3585R/9rIDtKAFVU8zX/j+QVtMC1KY/vRFx8WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOHvJB/D8DPIVfcjXlCs+hsfOSiz+jVNwzvZ08pbmfXRpgOfr
	/uxan4Ez0tBvB8/cY9azES/6UJtgjpjHj3KEpX0LkJ5oh35p32qZrKM2bw==
X-Google-Smtp-Source: AGHT+IEpuMgG3ocY3hNmUB2TFpEfKCErZx7TxFtM8FiM1LANfEeknbzig++/xwKq17FGFPTFYYF0hg==
X-Received: by 2002:a17:90a:62ca:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2db9fc1adabmr21470454a91.4.1726475895456;
        Mon, 16 Sep 2024 01:38:15 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:15 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v6 2/8] libbpf: Fix header comment typos for BTF.ext
Date: Mon, 16 Sep 2024 01:37:41 -0700
Message-Id: <cde65e01a5f2945c578485fab265ef711e2daeb6.1726475448.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726475448.git.tony.ambardar@gmail.com>
References: <cover.1726475448.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention struct btf_ext_info_sec rather than non-existent btf_sec_func_info
in BTF.ext struct documentation.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 408df59e0771..8cda511a1982 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -448,11 +448,11 @@ struct btf_ext_info {
  *
  * The func_info subsection layout:
  *   record size for struct bpf_func_info in the func_info subsection
- *   struct btf_sec_func_info for section #1
+ *   struct btf_ext_info_sec for section #1
  *   a list of bpf_func_info records for section #1
  *     where struct bpf_func_info mimics one in include/uapi/linux/bpf.h
  *     but may not be identical
- *   struct btf_sec_func_info for section #2
+ *   struct btf_ext_info_sec for section #2
  *   a list of bpf_func_info records for section #2
  *   ......
  *
-- 
2.34.1


