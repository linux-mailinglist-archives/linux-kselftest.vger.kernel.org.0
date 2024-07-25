Return-Path: <linux-kselftest+bounces-14219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39993C012
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C78282786
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF211990AB;
	Thu, 25 Jul 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDRdYgwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D740198E80;
	Thu, 25 Jul 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903967; cv=none; b=PI3Xk7xalJWtBs4yZ9vm8V4T2w0y3eDUNEH68YPIMTRASWLpfb5S6OTWVRD7yvLMaHOPi6+VZEslBpPk94/UMKLt/kGORX6LhqVRDPd90EJffJzA5OiThiFq491yJd4cV4+d7Ou4XmFE5I7HHDwpwPNpvEF5ws1/RW0QmlKe1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903967; c=relaxed/simple;
	bh=dpEwF1Cqkmhw2dlPnlRWZ6TZAxaZdsaXm+4K0XPeYKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwdGdHa4fHKXu3Ip1tLDler9EZlU+goxKfFe7R1K1Votd3R8/TSvrkpT7Xy415JTgCwwieTEkfcSrOFarvF/4PBi6TXiu/7hHG3gEG9fCZiSjPK1c4SZDVPuBITGF0n9kV0GMUXhjEHUpeGRmzwhcp4e2o9le5hPUI9264ofUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDRdYgwP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd69e44596so5859025ad.1;
        Thu, 25 Jul 2024 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903965; x=1722508765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/aaV17KP26bQPkrsuL+XRw6Nra50MTDjCsVlM0bqEk=;
        b=mDRdYgwPOQ+Wg2rSQyAQN2AWkkXovsY9TUXmwOWB0jxasyfqy8wUmQ9wVIV2Bgb2Kp
         JMb5B58Pm9iv4k17MnaFaYoHAaOHy/QpRQ7TvA4l1LncivJK094MaXy484el1GgnhVFE
         FTdfc8sWOz0ttGYywKXv3EEfHpQCCHu3rQhXG6P7Gfwx7bdmReojFwGt5X5G9EZ6/h/i
         GK6oj0ZNFBaRxtl/kRooodEFldEP2UTVZ3i9kXm/bWrUfvXI4WlCZ8ZOBX7MS8H0+l5v
         SPGvKUGDfj7MlCbguybOK1HjpU2Wd+DF+klkdmCEjzkazC57IKGYyHhiQ4KwDHMoN939
         CUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903965; x=1722508765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/aaV17KP26bQPkrsuL+XRw6Nra50MTDjCsVlM0bqEk=;
        b=g+5MyK0xcUiviKmNmovM9ZVVei6eXucRx9c2+aqPsysQzTkpOoInep43iP4gA4kzti
         6cP7V+I6bs4DUnmQQ8jrMdMzTzoTVXTHrxXKOpdtLfXM7TjhfYzFSKTwpjB88TXRZJeh
         5+b7TOEmSXWn95BpbTkpwEEstiOaz/SzgvwSR4Vblm2LmkU7cnCq10YbaBXsp6EwuXdc
         cUnAxNV2iv3/eF01OMmWc1Zm8KA5AOLmeEf9gP9kSNjjvk8mNiBJamYIO1nRzF6jCWPX
         tGwaGiH0RcpnsZdrZE2JURUOTxmvAHwTgbU7rTPUaP7KZXOtKz0pT4c6TIosTEjTdydK
         zCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUwNy19g71vd0S2Zddo8cRSZMhu3iP9m/XkI38P48IowggOJrA4HQKqW8cECobGOT0Ne87JM2bCsInnyZUot04Z46uvH/7RCso/lBGpDTUPjl93IPk+iZ+xgs2la8+RXA0L/69jBcYb
X-Gm-Message-State: AOJu0YxOMYgbUZ6MtiqFl7TAyw5pDFzsSrBoLpGixmrBNNjl/UmfvaLH
	8Iq9FCUrYfbX8tLgSIZNm2g7XqjPeuRIWC/EuqRTwCAmFU5MUN21WTb4wB0W
X-Google-Smtp-Source: AGHT+IFoGGfrWX4G6uu4Ef18RliZIoXj2QSHAb/E+hdF3XX4s5OytOk02DSczzI2jQRJb7/ofzC9Rg==
X-Received: by 2002:a17:903:2308:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-1fed2854b27mr41183435ad.26.1721903965132;
        Thu, 25 Jul 2024 03:39:25 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:24 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
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
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v1 4/8] selftests/bpf: Fix C++ compile error from missing _Bool type
Date: Thu, 25 Jul 2024 03:35:56 -0700
Message-Id: <2637cf3bfed4d550d2a6340ce052a8ce88426260.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

While building, bpftool makes a skeleton from test_core_extern.c, which
itself includes <stdbool.h> and uses the 'bool' type. However, the skeleton
test_core_extern.skel.h generated *does not* include <stdbool.h> or use the
'bool' type, instead using the C-only '_Bool' type. Compiling test_cpp.cpp
with g++ 12.3 for mips64el/musl-libc then fails with error:

  In file included from test_cpp.cpp:9:
  test_core_extern.skel.h:45:17: error: '_Bool' does not name a type
     45 |                 _Bool CONFIG_BOOL;
        |                 ^~~~~

This was likely missed previously because glibc uses a GNU extension for
<stdbool.h> with C++ (#define _Bool bool), not supported by musl libc.

Normally, a C fragment would include <stdbool.h> and use the 'bool' type,
and thus cleanly work after import by C++. The ideal fix would be for
'bpftool gen skeleton' to output the correct type/include supporting C++,
but in the meantime add a conditional define as above.

Fixes: 7c8dce4b1661 ("bpftool: Make skeleton C code compilable with C++ compiler")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_cpp.cpp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index dde0bb16e782..abc2a56ab261 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -6,6 +6,10 @@
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+
+#ifndef _Bool
+#define _Bool bool
+#endif
 #include "test_core_extern.skel.h"
 #include "struct_ops_module.skel.h"
 
-- 
2.34.1


