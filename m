Return-Path: <linux-kselftest+bounces-15837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C571959871
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE6C1C214FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786541E3008;
	Wed, 21 Aug 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUFGkL3S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1B1E3003;
	Wed, 21 Aug 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231402; cv=none; b=cElC9H9EUG737Ngr3OFwHLVHmzyufgnTqEp1UFFv/VCXFTFWtlC8r0Vwu8SNAo5/JcYM8LWKvu/dZygr2YsBQtiZwdAIfZAAd0bKUC847s3AQN1KvMXTsd0e4Z5aXZX8TRUPtkIwofl2NEZNNYimef+sA74R6qxpSqkLVRzsUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231402; c=relaxed/simple;
	bh=p+VcdB9HCA/6O6oQIVFwtXKCMYlajKRORAljsPWPaw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INkORzG4TvDmymSiHmOVE4uceUYfUnieWw7oZkiY4AjAN//eCbIhgJ1vX7AHZ575dCRVvGvuGNsGxInuxeSRghJX29SP0KL8iei9d528vOQotrgaJRQsRMQrezNkIPz+l5ly3ia6ovU2/EpGtnpe+peb4wb+Pkleop8/IE5ZGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUFGkL3S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201e52ca0caso48479065ad.3;
        Wed, 21 Aug 2024 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231400; x=1724836200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=NUFGkL3SGXmRGjiLtyBoh93D1wq9TK0eBox5v4HAMuGwInrhe+30O85Ws8NUkHOg3Z
         x6SBibCak7uOHDqxcq5f3yY8OSTpNiJ9xCep8Ig3QIDVL/RVvhAd9xsjb7reRs9bCa09
         jd7KKMda/IcmAtXoRIcvvzQQCy+PUSHcHpMi+0pqotkUEh8Tq4dx9+cLylKJb7wilzJr
         TEJQ3SbMXJUF3PPY9N000nCaiJ4OJqN8A6AuYwmQ1qWenNxU0PcKXjU1FTWszVP8FoX2
         yF2a1qDtk+2j4ixZgdDG7+2tLHd0XErGrD4JUS5XHv6Fb7SzPCTB1BuS5wkJ8FurL8O6
         Ho0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231400; x=1724836200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=MnkzHdKTuHmUWFb9gvTtlMFnj+uXMd8/rHmRc7Tx03J2p1OpJhFVcBVGFNGhTFRE2I
         3iCJU1Cvw9t4s6whI8RpC8IQxe0tMjo4AtwdKl1CaKuzv3jpB6s2v6/AwFxvHvY1BSwX
         ogLcam8BUvRY8+ABiWLxRGJU83RvBYwRAFbsDl1Plm9w/nXqVCv+Qh8n2JZwCfICbGjO
         pzuPA1U0r56g0pTNRVV7wTsHi26SrY+K6DP3K0IUA7fhriZaid38rOGEZ1lGKeP5fLfl
         nB4yquXy2WEcphJHyoUdXBWhB7P6mapeRJFD31aG37w2hOMiC0zFjikVxgWEPq6fJqUK
         g4bw==
X-Forwarded-Encrypted: i=1; AJvYcCX3HiJuvrtYwVZn6zS7f9bgKB+Ufv2/9/nBd4XoQV5B35JXLJwIf2ruFc3dSzzTqyuVJQu21EGmMgUCk5Tt4jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnz7ibvHLGtrMWMRZZqK++aiv819ZMlolD1cyxxmssOYfhwKJ
	5rZE1+8NtCwZDgPX3kAwcXB2OiPPTapzVF0GESfD6DreSqNyU17BqtKR8B9P
X-Google-Smtp-Source: AGHT+IHAozIxcg8F0MvaXToyw1b/Cz9pkiUO3DZh1uuuK5DSSTePym4QeklQXj5YhXEgfGjI4+zucA==
X-Received: by 2002:a17:903:2305:b0:1fd:64ef:da17 with SMTP id d9443c01a7336-203681e3d04mr17719495ad.41.1724231400282;
        Wed, 21 Aug 2024 02:10:00 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:10:00 -0700 (PDT)
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
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v1 3/8] libbpf: Fix output .symtab byte-order during linking
Date: Wed, 21 Aug 2024 02:09:21 -0700
Message-Id: <fff59f0e8f1de81a4b44f4c3cde118ebd1d20a96.1724216108.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724216108.git.tony.ambardar@gmail.com>
References: <cover.1724216108.git.tony.ambardar@gmail.com>
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


