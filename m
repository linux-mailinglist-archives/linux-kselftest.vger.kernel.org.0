Return-Path: <linux-kselftest+bounces-18156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1097D202
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106FA2839FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 07:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22D43AAE;
	Fri, 20 Sep 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtXOAGT+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964418C31;
	Fri, 20 Sep 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818569; cv=none; b=lPfMPZ2qE/wmQjJehXY784tskHH4FMpYxxg1PdM97uEUHq1rrI6BpwBnYnFNeUURpnRX9Ey7QrYtH6osXsBehn+HP93kV4U1I8s9xAspyK/h2Pqo9XRuzq5Hvq6Zux1KL9HVnmFhi1sjTO2pgtFGHZAlAy2QQPlCu1cmaJrfSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818569; c=relaxed/simple;
	bh=exVcaMmnOCbzyNCCepDUxO+71CE0l3N2mM32mayVI5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cmTUZIdzAYAfZ4j6EESHCBc1Tw0n4aqDxbUnBRBPi5Thi/aCOvTfbOTnDcr0ooOBvbm/JHIij7c9R+LAD6R+S8eeDOzZL1YXrVtcpgUj1TjV+euQPlaT+pL3392VBJdge9S7mMw4SdTSIkASK/SfzKpkawMkaEpgMXgsinF7MMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtXOAGT+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205722ba00cso15695135ad.0;
        Fri, 20 Sep 2024 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726818567; x=1727423367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UdNBZl5nUJpkhU2F12KMNNuC+DdtU919TP/+dp/q6s=;
        b=RtXOAGT+u7pVD2DdIrawshilqT/87vHNckGvCKBYiJXFsRZsVs58M3g1qmF/cA9rGt
         oINcUnbrYyfJ7N0S0BHGnzhnTcMspGGjVTCT59M3gTzm88yiP+HG1r05Dn3OxiIfyZBQ
         +7LaATmlKnoQr8wDDkLIvIiiB4GEGTXl/M+SBzZ3ELp24dlo8DWEelkj9WHKmF+p2SAJ
         mP+8qaVeZ9s1n9L5h60hgHhrpkSfRNJznH6DMN/D6vwF/XeYkom6OkUhQGfcB7bzjZG2
         Jwkp42tXBT73/o60VmjhXUUPpUCfG6kxT1ZkOqSnxAZI+HlhuE4JYFXnsVTz6r2QQAm+
         PTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726818567; x=1727423367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UdNBZl5nUJpkhU2F12KMNNuC+DdtU919TP/+dp/q6s=;
        b=NmhhPnL9H2eTL1Et3mKFcHURswuf6NfOJsSuQjKvOa5fLwo+8MUD9nGKtYAyMZLFtQ
         /MEoHnXl79Gg6bhgz0nvg74KZovpRy/Zx5KKEzzDSl++gvgzCaRF0fqc9P7Q8Dgq+UJE
         YuwLVCocvx0i+2OeH1ObFF56k3cnGfBsRoa2kdOaUFLI3yNjVbCBwvp8eJiL9c6nghot
         CUpmFoC0YtrD3IomYeYPRsvwPSPArZbPZw2QzPSx09lWdda8ZttZIZGTDpZbWiReY7CJ
         QfcU39hir3TIOncnwB2HnzCT0QgmgB/qe0bKShICP4ChYbYfCdphKkaQ8WkKzMDVIeAz
         SoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdpx32OjlPNwqp34JvZLyofHMObffIu0wUkahpucxVoJBst5su1mY9C2FweCYfYa5Ndofy/vhf2/qlTR+RzVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMB3iLoIK7t+n6EkimAKkih4uw2W7DfTaFytdg9RNH7/6zrmX
	lJ0eyn1OzYiq3rgsYwV143F0zGxioptSOvtMuRL1h7L//2CuqH4HgeQBuQ==
X-Google-Smtp-Source: AGHT+IHIwYuw4Bd1m0b8sV5QQOS2TPfXkuxB1hnS5LNeunYLentUU751qZ57A5yvbso3tI4ZKuT+8g==
X-Received: by 2002:a17:902:ecc5:b0:206:a6fe:2359 with SMTP id d9443c01a7336-208d97f0184mr17762075ad.1.1726818567143;
        Fri, 20 Sep 2024 00:49:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fe8sm90481625ad.68.2024.09.20.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 00:49:26 -0700 (PDT)
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v1 0/3] Improve .BTF_ids patching and alignment
Date: Fri, 20 Sep 2024 00:49:10 -0700
Message-Id: <cover.1726806756.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This patch series offers improvements to the way .BTF_ids section data is
created and later patched by resolve_btfids.

Patch #1 simplifies the byte-order translation in resolve_btfids while
making it more resilient to future .BTF_ids encoding updates.

Patch #2 makes sure all BTF ID data is 4-byte aligned, and not only the
.BTF_ids used for vmlinux.

Patch #3 syncs the above changes in btf_ids.h to tools/include, obviating
a previous alignment fix in selftests/bpf.

Feedback and suggestions are welcome!

Best regards,
Tony


Tony Ambardar (3):
  tools/resolve_btfids: Simplify handling cross-endian compilation
  bpf: btf: Ensure natural alignment of .BTF_ids section
  tools/bpf, selftests/bpf : Sync btf_ids.h to tools

 include/linux/btf_ids.h                       |  1 +
 tools/bpf/resolve_btfids/main.c               | 60 +++++---------
 tools/include/linux/btf_ids.h                 | 80 +++++++++++++++++--
 .../selftests/bpf/prog_tests/resolve_btfids.c |  6 --
 4 files changed, 97 insertions(+), 50 deletions(-)

-- 
2.34.1


