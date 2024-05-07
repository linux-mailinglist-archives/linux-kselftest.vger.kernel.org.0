Return-Path: <linux-kselftest+bounces-9597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410B18BE42C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E1C1C21D56
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584731C9EB2;
	Tue,  7 May 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNcm/+Xy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F31C9EA4;
	Tue,  7 May 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088010; cv=none; b=aZW7AEDSYXH6b5yod1LKODtwyOTircouDRb1IrlxFq2DMfGLWr6ffCr/hGnPvdUI+uKnm5nyOxSsy5XBv6d6CtZAeaMaGN9V3Yzyljz5iOkQVWP2D8HMPkw/m8Eqi7VsvmpWGprr/cVEUIKTMCiKkVFT2iF58KPhRNCzHcon49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088010; c=relaxed/simple;
	bh=egkWOz43eHGtMFIY140aoiyLqrnrPqlvPykxlJaPgaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcnZ+D7f296qmkbIU5CFTt/j48rNB8VUILummu1r9VhraVf7kTvH8h+IN45v5aDxGPgWd6wghxgdrWroMT8DHKeRL4fNgHzkjWjX9r6OYFR2cPqFuWiVj3qn9/04+d4Sx2We7+sJawAo0OjzhWMEexkHiZzgdPgKbwcyA8lIGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNcm/+Xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C210FC4DDE8;
	Tue,  7 May 2024 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088010;
	bh=egkWOz43eHGtMFIY140aoiyLqrnrPqlvPykxlJaPgaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KNcm/+XyBrTLdm7oRT16OCMb3/Ap+qDbmQqv+Rp6gUHxh5DyiIXAwUGp2BmaDz7v0
	 durzb7hgX0XX+Nagbwdc9gc+66y4/uLfnF0/0fFcEAMppdNqi6oySRmeC29LEjggyb
	 M+a84qUFh/pFTcKg14xZ65dTwyNT7YqY75ParDTdk0D6536ARVspSebS5ZBBsMWCWo
	 M9x8b6yREDX4te0TwoMkIEoyRSBSLAioBYFubWsR5n0k4pZiSnWw+69JC6Uta3fFg2
	 mbhPoXK6Gm7sGdV7Jm15JdEC2pPof9EmHUeZPd3sQjj2xruBqjOHal8cNcHyLSJOcP
	 8vzR0dIEyJJkQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:35 +0200
Subject: [PATCH RFC bpf-next 7/8] bpf: implement __aux kfunc argument
 suffix to fetch prog_aux
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-7-b4df966096d8@kernel.org>
References: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
In-Reply-To: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=2673;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=egkWOz43eHGtMFIY140aoiyLqrnrPqlvPykxlJaPgaY=;
 b=oJAmtA0r9hCIs8UUHfZHyxXeyHI1ooXguBzR9uFMgWiwn0xOIIL26fN4pkiWwxNCGDAFC1RfH
 wIqjJqkgIp0DKjQK28Gx8oOq7x3Y3Ne4Ttm9fOagKbeixtvtfxJxGGc
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows kfunc to request the prog_aux environment in their
implementation, to have access to the originated bpf_prog for example.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/verifier.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fba9e2caa83..33b108db0025 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10909,6 +10909,11 @@ static bool is_kfunc_arg_sleepable_async_cb(const struct btf *btf, const struct
 	return btf_param_match_suffix(btf, arg, "__s_async");
 }
 
+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__aux");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11807,7 +11812,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
-		if (is_kfunc_arg_ignore(btf, &args[i]))
+		if (is_kfunc_arg_ignore(btf, &args[i]) ||
+		    is_kfunc_arg_prog_aux(btf, &args[i]))
 			continue;
 
 		if (btf_type_is_scalar(t)) {
@@ -19950,6 +19956,38 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = ld_addrs[1];
 		insn_buf[2] = *insn;
 		*cnt = 3;
+	} else {
+		struct bpf_kfunc_call_arg_meta meta;
+		struct bpf_insn kfunc_insn = *insn;
+		const struct btf_param *args;
+		u32 i, nargs, prog_aux_arg;
+		const char *func_name;
+		int ret;
+
+		/* imm might not have func_id, so create a fake insn with the expected args */
+		kfunc_insn.imm = desc->func_id;
+
+		ret = fetch_kfunc_meta(env, &kfunc_insn, &meta, &func_name);
+		if (ret == 0) {
+			args = (const struct btf_param *)(meta.func_proto + 1);
+			nargs = btf_type_vlen(meta.func_proto);
+			prog_aux_arg = nargs;
+
+			for (i = 0; i < nargs; i++) {
+				if (is_kfunc_arg_prog_aux(meta.btf, &args[i]))
+					prog_aux_arg = i;
+			}
+
+			if (prog_aux_arg < nargs) {
+				struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_1 + prog_aux_arg,
+								(long)env->prog->aux) };
+
+				insn_buf[0] = ld_addrs[0];
+				insn_buf[1] = ld_addrs[1];
+				insn_buf[2] = *insn;
+				*cnt = 3;
+			}
+		}
 	}
 	return 0;
 }

-- 
2.44.0


