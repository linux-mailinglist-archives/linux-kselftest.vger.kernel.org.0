Return-Path: <linux-kselftest+bounces-16527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA3962593
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078AD1C21D2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1716C873;
	Wed, 28 Aug 2024 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCv7wRhW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455316CD13;
	Wed, 28 Aug 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843546; cv=none; b=HelKnDKbVvj0KGTCQihN9A37yk7HNF+DY6w9C45e6VuEmKyr/rtMnFm6EiRXBjl+FE35glshFfEIE84uxMRwbjVNqlRkMv2eFTXA0pLvXg5C/iSpK/07x/jvrl20PRZHFawieObp0/CT9SmLrS1qjwpon1NFC/wB3284zYqHH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843546; c=relaxed/simple;
	bh=p+VcdB9HCA/6O6oQIVFwtXKCMYlajKRORAljsPWPaw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9h0xjSo/Geva6jTc58zOrY3fE+9z1wNbLs2+VltVyuH/ZC/fKD/2atkBOf4W5g9eX3eEU2QRpoZqXQYM8u5evy6ee3z/ixv/y93HkrydbrI1wNZL+9F+cph0D6KdTlHuNrXju0YtBWbXDUfSzWPIHdPeWwMXS2t6OfG6Xnp3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCv7wRhW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201f2b7fe0dso56591905ad.1;
        Wed, 28 Aug 2024 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843544; x=1725448344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=dCv7wRhWmxqSGs6D3tw6mS56m0cELcD3pqlANtoDd0hVP9muyGC3ZMCemN7R67V3wK
         mlEtaUq74KZWDu2LIqP2vLw1OaqDeVtw9TdCTae7azsuwBziDGhKlOWDLuFtuQn/PyvE
         Swtn2Rzk+paOg+KMN9l2niDFDc7KlsT4HFuSHiZ1I31F0MImL9cTeoNkhpbjvSMuMoSS
         GHpzWmiPNKkCU0eq+BsZcshM9njoNjNWVBldG88skSPdmTha2fgfnOsP0Grs3Txgp5z+
         LsZYnijSSxyk7H2xnSxmvLT5S7HxEs7h/NoVFX0yG4p7ceeEB3epekaeFsnGPYK4fD+b
         yg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843544; x=1725448344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=mygeHQc1QvnakQQZruPUc0DkOTo/c/Ws9um3wHu7emjoWCsRu0XvWGUmvcHyEhrWb2
         zlrQzogZOBQP/GkyPFyL3NQnVGrPDFsVyi3CguWBX1KDdql6hm5HHGyq4A3gsQgoyahN
         yZvb6hn2ZnjfVFzcwliky4npEZxleP/PpgSdCvAtHkYazlGAphBMFjDPJcUYjYb6k/lf
         lLt06PJQBeqppYzcbGmydih7aqNLG4OhnNEwgUaRUT2BlBedqklmdDBTMmite7nZQMGI
         l+qW+0Pn3H4so4wmmxSPjx6CJ+osx1j7LB7GQQEg3RbsZ+Vl69xYze0VOWwRgGeGQtfM
         O/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjdelNcUSmTAtZItv8VVmk+FXtQlx4LDwALh/cOYs0EI7SjduZna6YuGSxXVTI09Vkoe9e6DYLJjqCj6w9FfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSiGfzubFjrhObAxkGXjgRWekJYQe/tycZJm2rXgySEThABLY2
	XAEmB7FxwntCRQtQV0P2eWqntvUHQZl9668KLvjncBtPHSl5alnm9pLtKBD+
X-Google-Smtp-Source: AGHT+IHA56i203JmiU+eFcmRoDAIfwWdWWqvblFBbcfXwd85GoLcPbhzIPIhPdcutqkyRjzfjplO6A==
X-Received: by 2002:a17:903:40c6:b0:201:f9c1:f543 with SMTP id d9443c01a7336-2039e47a4damr148843695ad.18.1724843544199;
        Wed, 28 Aug 2024 04:12:24 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/8] libbpf: Fix output .symtab byte-order during linking
Date: Wed, 28 Aug 2024 04:11:53 -0700
Message-Id: <290a54c2a1a507c265cf19dc068f3186da78de06.1724843049.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724843049.git.tony.ambardar@gmail.com>
References: <cover.1724843049.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


