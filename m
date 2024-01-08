Return-Path: <linux-kselftest+bounces-2731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E32827998
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB5B1C22B37
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0756464;
	Mon,  8 Jan 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWJ0aZ4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E15467C;
	Mon,  8 Jan 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55745901085so2786256a12.0;
        Mon, 08 Jan 2024 12:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747179; x=1705351979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d/FIxpPJtgATfH89NHC2zsxYFMsV/1h0vIJMGRORcc=;
        b=FWJ0aZ4d40FRBCrPPLv1OIFFfjWBGUyGNmh8BaD1XMe9jAlho8eXYBgX4j4XoBSq36
         3iolxRa3EYj79Wk9aLqmedQmUkJcFmhYPG0DNvN/aDKY81PqXIiu1oejo3OrVSFhpTUO
         IPXQF4Vy9mo0rJqeQDJFxLWaM8SsaM3GUlGMHSgGvmRAoWjibY9yAJrn4WP0aQvYXrzn
         XYIr+K5B6IgCOvwVRdq41SH/dx1m60bid6QHeKQUNghEjvnOFEaGVWno/YyXQQV3BEu0
         mMiwuOh8jclMADxXcxjLEIYZmNFz3fmWA+FXRPv12mVSUY/3ufYF+bF4JqYcE6GFkqoy
         TxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747179; x=1705351979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d/FIxpPJtgATfH89NHC2zsxYFMsV/1h0vIJMGRORcc=;
        b=IEYmF7yZZEd//Wd71e2nyJsXdSx/J323rUxys0Wy3G8rKuNLg1d3+EsO77vp5B0hzL
         WzE2s77VyAP9rqHnWdLEDWdur/DYEK7CbhRc1KJ0dJ+aX5CYBkOKwDAceD0VSS1+BOtY
         U0pTTsh0akP+H+yGb47tW3/cDnOejGAPbXIX6jkpNT34CPqqlL2uKB0Qm+57+v2PH5OI
         vTQ/sgA31uKa9UA66FdE6hSfnjXXJJmmmAjEkW0DdiBOSRHHoZGQdBYN/o7nqgcaEKHZ
         vbarwlMBB6BAhKTwEzKMy332ol6LdojiElAXGuSGemenxmEBOLslKrjokU248Ts7eOhB
         oRhw==
X-Gm-Message-State: AOJu0YyU+/XhaQsCCfbmGJe7kSJW0uascDcC1g5HT1TVyfGr3C5X9or4
	pSxS58/z2jWtNR1PqmibaVw=
X-Google-Smtp-Source: AGHT+IEq4hA0Q4TjZhbtBQ3f8rnS7QTIYFDK6Om0y0vMZ6I7l8K76VO1V09LqnPK4E+yqDbsbPDlzw==
X-Received: by 2002:a17:907:320b:b0:a2b:3a97:205a with SMTP id xg11-20020a170907320b00b00a2b3a97205amr18923ejb.52.1704747179138;
        Mon, 08 Jan 2024 12:52:59 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709063e4d00b00a1f7ab65d3fsm242866eji.131.2024.01.08.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:58 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
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
Subject: [PATCH bpf-next v2 08/15] bpf: Assign ID to scalars on spill
Date: Mon,  8 Jan 2024 22:52:02 +0200
Message-ID: <20240108205209.838365-9-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Currently, when a scalar bounded register is spilled to the stack, its
ID is preserved, but only if was already assigned, i.e. if this register
was MOVed before.

Assign an ID on spill if none is set, so that equal scalars could be
tracked if a register is spilled to the stack and filled into another
register.

One test is adjusted to reflect the change in register IDs.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                                     | 8 +++++++-
 .../selftests/bpf/progs/verifier_direct_packet_access.c   | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cd82a7c1318..055fa8096a08 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4505,9 +4505,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
+		bool reg_value_fits;
+
+		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
+		/* Make sure that reg had an ID to build a relation on spill. */
+		if (reg_value_fits)
+			assign_scalar_id_before_mov(env, reg);
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
-		if (get_reg_width(reg) > BITS_PER_BYTE * size)
+		if (!reg_value_fits)
 			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   insn->imm != 0 && env->bpf_capable) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index be95570ab382..28b602ac9cbe 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -568,7 +568,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("direct packet access: test23 (x += pkt_ptr, 4)")
-__failure __msg("invalid access to packet, off=0 size=8, R5(id=2,off=0,r=0)")
+__failure __msg("invalid access to packet, off=0 size=8, R5(id=3,off=0,r=0)")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void test23_x_pkt_ptr_4(void)
 {
-- 
2.43.0


