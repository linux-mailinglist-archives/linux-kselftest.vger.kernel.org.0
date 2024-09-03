Return-Path: <linux-kselftest+bounces-17024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC89695A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0971F24B86
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FF1D6DAC;
	Tue,  3 Sep 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R27sSowq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E651C62B1;
	Tue,  3 Sep 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348825; cv=none; b=R55Wwa0G0pPGd7EC8I8XbOL3sLyMVbQiPxMNGIpXFnguvgWVmAMzWm8XYDrLyI/pEAAehXmj1n8zT3Knzdg857IzhywqcLscGpcb4XBvXjrO/8p1Op/hjtWWwz+D64xkq2q6mI0yc+MCeFk0MjZYOqNgEFrah8+Ae5kxuJybBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348825; c=relaxed/simple;
	bh=p+VcdB9HCA/6O6oQIVFwtXKCMYlajKRORAljsPWPaw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbmgBlWK5fGikGI6/gW93G1TQqGGLuO30qF9JD7i1ClhkyylsyRLzqEa3hpXRGDyuDOndCS4hPaYPK0MEXapuT/a64Gnm5KzpaNRPcf+3gQPB7tRx9iF5Y615C/WOmUxUOH1BX8vNUxRpThJaqkMGxejBufHqJOgAm2oI5qnd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R27sSowq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-715cdc7a153so3430362b3a.0;
        Tue, 03 Sep 2024 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348822; x=1725953622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=R27sSowqSPBnTmx1fFvB/PvSs+AkjSBKC/NGhqUzdzyapyUnowFmbGFJjbBHeLDxEa
         94PFXyGOPD+JUnw79RPQ9kADqbLviVEBtSvfLALE61+9ufP7cRyqibVT64urCL2Ph6JI
         HrYCPZ4i0AzgBEEDUO8gWgmWfTx7ZNCUL7n8BAImzdI09iEkjz1vXbESwwo2uJOOQq9g
         qp9scxMDiTSxxSTo4sL3jrPQ1a3RdX2xbA8ADCKnie9AxDwMwbT6sEjlPCJdXkkjibVq
         Z50GzdIgmmp4x0SfxCF73bGrh50nEfbl3f6/xJHsoaGxNwGZfTxYQw+/fyWfUSHl/AnR
         heNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348822; x=1725953622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=JLDewiSWTGC68KIokK+08XGCrHca6YfXk8Tqj70m8tUFZyKTE1q4pEHifnnnjAh4Xg
         sz7EzRh7DsqgUnHSVjt+Crzj8pzCn/Zjm1YxsLz9B25Re+PAx8dLApsPTj+Ii0ein7Ho
         BZ46BQaotHLsg6jiDuMTwPnY+31/sKsdy2Ppj8cFEybxpYzn9c1CL/gUfs4A7jvVgCYB
         wmhcty6PScq7ZMuQRHmMMyoUzp/009cgzb0gVSwZTEXTgSWjNtCBwq16J878he0yIbmP
         ynSvYA76yGfOgI2Y9hvFu03ejAYgyu1p/P06tZ5ajiuvKSBHD/kikCxBMMcUJXGzPHyV
         Cm/g==
X-Forwarded-Encrypted: i=1; AJvYcCVQgHzgrfbqZi+6DHwioq/rUkGzi2mgKrYy79NIySmgWNVmTex2IasSFDAOB9PxGR1JwfNCStU6zefwd05WG6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyo2gCWh0n6lUiid5Mkg5KSVKctijFOADXOGaD9LiFPMg7V6m3
	DPCf49Ljjw/O0s5l3/yiMO4HA6maZ5Il9icaJDPsQcs6PIn/doMXTx/5jxvh
X-Google-Smtp-Source: AGHT+IF+XlI7tqv7CdWv0SK+4SHLRnnseHMVWjthrPslLHAZwW5EzGBwPp6ms8yBFZkHEGFeTp1YJg==
X-Received: by 2002:a05:6a21:3991:b0:1c2:8a69:338f with SMTP id adf61e73a8af0-1ccee7ab706mr22263159637.12.1725348822081;
        Tue, 03 Sep 2024 00:33:42 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:33:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/8] libbpf: Fix output .symtab byte-order during linking
Date: Tue,  3 Sep 2024 00:33:00 -0700
Message-Id: <aa23df20bd777b6106e6f70607426376a5b9c75b.1725347944.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725347944.git.tony.ambardar@gmail.com>
References: <cover.1725347944.git.tony.ambardar@gmail.com>
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


