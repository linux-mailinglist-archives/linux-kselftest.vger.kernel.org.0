Return-Path: <linux-kselftest+bounces-30957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B15A90886
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B35188DE57
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA520101D;
	Wed, 16 Apr 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKyeDiFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE11C27;
	Wed, 16 Apr 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820290; cv=none; b=lhu3WQLMXj+5sfahVEhVLTNApSnjNFnhtJVQtTE/kLrikKM708tIkFKIUuWF94s+Jdn2nMo/CX5jP1NWb3hjONFmjiS1hG60Elt3In7Kd9wI5aKiUffvL96L1Mu8KU095wZouP9fNYdQwehYgfSX+An7kM9H3oMaGqvIrTQ63s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820290; c=relaxed/simple;
	bh=RBLa0r4h+YxQRFk+SoGNqLqtEBKlPOcAQAm96XMWW28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tztt6nujLUT/hTFMxxdAqfocvMK51czMMc0+AOZINELh/8YFa2xhMR4EOSyc5G1ie1tMK/yFGDdsWk21xms96/RGzk0hj9CcM85QxiBuYF4YTY1/Lxwl7hwsdzL3z/AdzTffdiauNhIvfvS/0jXBJWskVDOzvYBOqSY7VuBoLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKyeDiFK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73712952e1cso6837408b3a.1;
        Wed, 16 Apr 2025 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744820288; x=1745425088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9ugrg/YNvUcO+CbH7JWt9oRFLNuuyWcJoELkFvViL4=;
        b=RKyeDiFKtW6Rvr5QlgRVlP9JWjHEI4EYadikI93YrNblW5xz7QCuOB4GUv9mt6hCin
         GZCvc2b6GN+7Asar88iZo5dDEtCqE/+O1nOobfq3Ka1NDcaAEYw6gTuSzSG5BvLRlTyZ
         YJF4n6XBaQmjQ/YkZqVmef1lHjVtgfppINBzd0g+wj2bynt9JlRTcakjKnEB6cRZ2Vqy
         se8M0CQ2XPcm587oTDcC4ptYJQFTIFB3ELTUlIfZDOVBLAdywT2iqI6M0+iWRGvfB8s2
         /2i9uPb/Qb21CFs08pc+nmSNmxvzyq2tWhCzffP0jBnIpYHOxjeG9UZJQ7ffV0YCGCDq
         PFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744820288; x=1745425088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9ugrg/YNvUcO+CbH7JWt9oRFLNuuyWcJoELkFvViL4=;
        b=Ao5MjLcGkMf4vjRlbJ63rPMQRVqYL8+H7wPQSs6bcPVWIUNLwEYH8rXIBFIv/VHdVG
         YNbCNZ3yfLrc+CFxyf7cBhh0SPm6Wi3P8/zSQD7EjL8eRJWFDQHYukPHCtefGFlcgiAV
         NzP+OnYyBiqS6xE7IJDrp9sucKm8DStx2gHV+VGZ6mVhjSSCjSSeUSM+BoA48K0/AgMF
         xBqjVprJ5zGjEEaqpyC5XuaROSBW+FexKJN4XmKPXkWn9vX7Ro8L4nmPqOV20pxz+l2z
         ejVpZ2rXDLjsDwF+6E+I61N324MTJPIQgveTmItSKTWWsVoQ1IVRB0HNzBfu1D+3eQCS
         0tag==
X-Forwarded-Encrypted: i=1; AJvYcCUK/VpFfXsgEv18NwHZLbgXb3E866A1eqk1MiaXIoqnE2L6fjsB4MQjGhn9vseUlAyAUAJ7jzHXcKMUgNA=@vger.kernel.org, AJvYcCWco7NV8D9JnT8KnItLqrbu1KzuN7wUKqaiMakBdrAXp30+0DviqPkdm01R2fBOS7eOby+Y7x+K9XwhWj3dJxTk@vger.kernel.org
X-Gm-Message-State: AOJu0YwklyYDMpUxOpG9u9B8YyF0IiyEDiLGt9OeZp9mVHqWst77JzyW
	XxulflluY+fy1hlaWSY6RQ8ybSfmKl4Wqv43eYC5b3j04gQNmcIbQ1YhxQ/8HBoOHw==
X-Gm-Gg: ASbGncsGiI+El8vg7iP07P4sNvGZItxWcQM3uG9G/9WMdyPK4jo276CHhfjex2cs85T
	eeHHOzYC9wzJ+RFLdvrDsb1KJfjycPzwwyXEOO5q3mPyd7zQfVNML6AEQPCis41iIvfblzbbdtK
	sY9pQt7u7oszvT3Y6Ggrm249mmxKETGI4Zpk/9cy0exJXhQ7cwnZFwH/e0SRVE9kX54WSnFQ8RJ
	LeIa3tHPZCbWBPXLMZMGWs/VKxxgWbGTmovVSxJWtaoI6z28QakN7XqRKCd7OxPk1x/YGl3+BIZ
	gdM9Y2KQBFJwJkxFFzWu07gH59IGPShe1a66vTC19Ss3
X-Google-Smtp-Source: AGHT+IHdi331Qj4y04I3CoH3mvPZ1E2R5zjIQJHGA4eVn/BqBV+tt1HSsuLaFPlmii//fADPV049ig==
X-Received: by 2002:a05:6a00:4ac6:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-73c266b5fecmr2898501b3a.2.1744820288343;
        Wed, 16 Apr 2025 09:18:08 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e355sm10921939b3a.139.2025.04.16.09.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:18:07 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
X-Google-Original-From: KaFai Wan <kafai.wan@hotmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v2 0/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Thu, 17 Apr 2025 00:17:54 +0800
Message-ID: <20250416161756.1079178-1-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we try to access argument which is pointer to const void, it's an 
UNKNOWN type, verifier will fail to load.

Use is_void_or_int_ptr to check if type is void or int pointer. 
And fix selftests. 

---
KaFai Wan (2):
  bpf: Allow access to const void pointer arguments in tracing programs
  selftests/bpf: Add test to access const void pointer argument in
    tracing program

 kernel/bpf/btf.c                                     |  6 +++---
 net/bpf/test_run.c                                   |  8 +++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c    | 12 ++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

Changelog:
v1->v2: Addressed comments from jirka
- use btf_type_is_void to check if type is void
- merge is_void_ptr and is_int_ptr to is_void_or_int_ptr
- fix selftests

Some details in here:
https://lore.kernel.org/all/20250412170626.3638516-1-kafai.wan@hotmail.com/

-- 
2.43.0


