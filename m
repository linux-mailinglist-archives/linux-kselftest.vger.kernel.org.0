Return-Path: <linux-kselftest+bounces-16031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0E95B190
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922401F21BF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AB17C7D5;
	Thu, 22 Aug 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA7uhL3B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CE16F27E;
	Thu, 22 Aug 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318697; cv=none; b=dEKGCrzuZdIU5ba0osOHO1vKmMt1iVHqextsCx4Avfh8+LEC7ku3oAHCcVTtVyZ7gVXBpH8TaRR1hWA5LfY7LmY4hM/K86sdAOw5rG4y0uSRBOIuLBdO5Qu7mEJygmRTkpcdfpBNmqkot6X+zIRr7TAoFNLxc+MBeUvj5zBAW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318697; c=relaxed/simple;
	bh=SPaS0CNuTHL/ufDMOW9NsyS5JNzQD9xoiWPpMupOO8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbj8cKbOsi5vWTEtKhPc4YjitbGCbBbG0Usm/GignngegZ1unl/gG0f3m+C9YJZng9m5z/xCbfIEZRBZ+d7koacxqVGc82zBVy2hVsZ2mhP9wLNMmQIJm35TM34MKxCnk4BogHH1kMkSISd0PXVxCEF4R5BF1JS25Izzwz/Kf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA7uhL3B; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso457338a91.1;
        Thu, 22 Aug 2024 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318695; x=1724923495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzyqOirBVYrCbnvRdKY3/sWPWtp6YYJZw3JHvwNRh1s=;
        b=SA7uhL3BeVVmZHxSVlLkxD1Gug0x9wcvCug+GHB9i2y3B9cdsUhKl74HruixnH1jW9
         Ie/pUEPdNissdQMYZyxGi+V2i1Zq+36INm3Vp44xaZciZJaHkGhp/ukV2eMk8bNmfryx
         NhaiztLZR8qIu9DY9PSSOG54Nh8aLv20n5+gWOs38EWJ5LxWZ+KKx4F/QB/u48drBmg1
         fnW1OItCXct6NN7W1qsAff898WLa6e5ux9/80dVoXs21M7h9ZxXzNb/gf2RFJr5J21OP
         5ct2Oz12g6KVQ6xcz4zWeo5R74P2OJoESRSOYgbixe/gCBsPrhK3gHOUoRmiP/159zSo
         +1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318695; x=1724923495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzyqOirBVYrCbnvRdKY3/sWPWtp6YYJZw3JHvwNRh1s=;
        b=pmRZJEWvb26lAWgHSx3WcB6udd8JTkQ9UcPj4E9H3filSKXrmGdZIu61jHemAPB6b2
         xsAvH5eWg+jO44SNiiDXmpvXxO3WwVtVtGyvbRS7eU+6D0OACXVfCLbxjYHPqmSSwNFD
         u4Oa7QGz54tgXso6uGmxCDr2D4cE2iwIEY8tksY6qFVsotNWtEVfseavfU89m+2L3riE
         kIlffqG6ZNvFzwuKP0Ei8FvWhZDnX8K5ZW5Neb/kej4Ue+N4do5XGbEWHhVHWbcxZYP3
         dCvph1O3aH5rmJdO2AOodjrM9i5MsUUDD2EAxZr5hyVtJDvkj2aHVDVnbUJpNjgBDEge
         K5+g==
X-Forwarded-Encrypted: i=1; AJvYcCX71Km1VV7KU/zpEwXyTPiXvXvaaHkg8+qcZMHqA1oguRxgSuqOqz7pccsFO5ogRajbSoFtpb61JP7bdi/Gid0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMdU66st/oxDhcHZWpzXIx7Poin4E27QjGtQ2nc8zYM10WTHn
	8C7X8ZvcgaiW1lkTl14STIDG806egtw22Nj7Er0QnQKyGje+6sRd+yeO7xO3
X-Google-Smtp-Source: AGHT+IH3YNoFwSFw91LF9bFUj522IRvk+GYylZd0RcXJndhWcrFuv2egOPEFH9ltvthADYIz3FsWDw==
X-Received: by 2002:a17:90b:4f89:b0:2d3:dca0:89b7 with SMTP id 98e67ed59e1d1-2d5e99fb6d1mr6494251a91.3.1724318694935;
        Thu, 22 Aug 2024 02:24:54 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:24:54 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v2 3/8] libbpf: Fix output .symtab byte-order during linking
Date: Thu, 22 Aug 2024 02:24:26 -0700
Message-Id: <501a1b0e34bb9db377a81a6fd088c36cf3f98df3.1724313164.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724313164.git.tony.ambardar@gmail.com>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Object linking output data uses the default ELF_T_BYTE type for '.symtab'
section data, which disables any libelf-based translation. Explicitly set
the ELF_T_SYM type for output to restore libelf's byte-order conversion,
noting that input '.symtab' data is already correctly translated.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/linker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9cd3d4109788..7489306cd6f7 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -396,6 +396,8 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
 		pr_warn_elf("failed to create SYMTAB data");
 		return -EINVAL;
 	}
+	/* Ensure libelf translates byte-order of symbol records */
+	sec->data->d_type = ELF_T_SYM;
 
 	str_off = strset__add_str(linker->strtab_strs, sec->sec_name);
 	if (str_off < 0)
-- 
2.34.1


