Return-Path: <linux-kselftest+bounces-2281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA03481A865
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5966288527
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582784C3CC;
	Wed, 20 Dec 2023 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSP+Ji6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543E4C3B7;
	Wed, 20 Dec 2023 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2370535060so231232766b.1;
        Wed, 20 Dec 2023 13:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108433; x=1703713233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCxFxUWlX2zy+ADuI9jc+/uBDewXnutA3SR5fl5N6eE=;
        b=FSP+Ji6PfVGEK5nUlez+PeVmYnCcVPSec/SbNw4uTcUH/6pgsv/3qXyoSiAfOmRHQt
         Dv9vW3lVkoFqheiCx/HhMMYUYdMFIDXX/iXWlpNfMtGDuPFHipgZv8c4L/qvvjK8158w
         YckajLss5l7lPN6WB2hh80btPDnPVddhnqbyN72rcj63TCMZhtDHvQTgRVqaJfvevzaR
         4/LudCWGBTeQZxxNzbkorAIwVwoqLcpLo79YudQPtQkerkwnxJ9HfbQqLa1gDv0J4Yc4
         ouEtqzVuG8dSR/1KrjUwH7NnjuAxYGRCpmYdMRsnpo7pH7Nddmvgzlb2GPoOfSKihwxm
         aX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108433; x=1703713233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCxFxUWlX2zy+ADuI9jc+/uBDewXnutA3SR5fl5N6eE=;
        b=l2jNcWf09CJ87quAym4EG03Xfm4rJU3ObjUE1xPiYsu8++BUxeih1UTue52VrNi1pF
         uzX8P71ixZfyp87ljtI189T3zA51QTJrLwSesPHvaSBnJfGeOnVL0mj93ytV5wOVhw3v
         Jh65h4Fk4fw8Mss98KLoHFy9L3F6ph2FcxHHbk4eItbNt1Z0eIj+jRLYltCkfwLRd/Fy
         gXcpaUD/8i7SPb3EjddekC+mNmYbsfGFQwLOrKXcTM7P0X7xl2+im9vElUc7Iewax7IM
         eJLsiEMfrMevhdEglIGtDpUoIPuBNA4kDBeWM2mouGam/GzeXcOh9H5irhE3LRVx2ob7
         Oi/g==
X-Gm-Message-State: AOJu0Yx/mRnFzhBPeinAoYExntdFPcArlsl2/nILEsncf+4eQr/qnpU8
	JsMCUxfttOVeB9ImC/Cm+b8=
X-Google-Smtp-Source: AGHT+IHTSYZCijtb2PvFKC8vQ02KuK23QZ1yD4xcYtThic70H3lhnePX7yqDJ1jIhj8eOCND01vcdw==
X-Received: by 2002:a17:906:3f59:b0:a1d:3511:6674 with SMTP id f25-20020a1709063f5900b00a1d35116674mr3656540ejj.13.1703108433051;
        Wed, 20 Dec 2023 13:40:33 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id wi22-20020a170906fd5600b00a2693ce340csm237378ejb.59.2023.12.20.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:32 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next 04/15] bpf: Make bpf_for_each_spilled_reg consider narrow spills
Date: Wed, 20 Dec 2023 23:40:02 +0200
Message-ID: <20231220214013.3327288-5-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220214013.3327288-1-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Adjust the check in bpf_get_spilled_reg to take into account spilled
registers narrower than 64 bits. That allows find_equal_scalars to
properly adjust the range of all spilled registers that have the same
ID. Before this change, it was possible for a register and a spilled
register to have the same IDs but different ranges if the spill was
narrower than 64 bits and a range check was performed on the register.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d07d857ca67f..e11baecbde68 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -453,7 +453,7 @@ struct bpf_verifier_state {
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
 	(((slot < frame->allocated_stack / BPF_REG_SIZE) &&		\
-	  ((1 << frame->stack[slot].slot_type[0]) & (mask))) \
+	  ((1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & (mask))) \
 	 ? &frame->stack[slot].spilled_ptr : NULL)
 
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
-- 
2.42.1


