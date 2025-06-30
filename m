Return-Path: <linux-kselftest+bounces-36085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABEAED21D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 03:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247813B47E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D0E28382;
	Mon, 30 Jun 2025 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgmG6aHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBC8479;
	Mon, 30 Jun 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245556; cv=none; b=CMtm/SsOL59fFpLkPIhZhQrEhVFxJj8aBv0lichilb9Ctz9IVdiJ9kDb/Z5bVXpUdV+aw6hX9zhEgY9SAD3yf8FivQenCVmrluEYeFZO83vV4gLGTVP3piuXDvQbpEOcjHZYcDcdtXd0BjTz+CtzhCGA3OUv1PVG/XD+Pl4uK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245556; c=relaxed/simple;
	bh=V5Wd72GZB031iFqt8kuZQzmYdO2l3n2il+57WOcxn8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APa8NaN5vUT77z5E4MQj+f9iKOBta+X5o4t9k8+EelGixFYbWmVw7A0g0eq/O9ayr3szab1lXPPMen+t1SdHh7r6hHf7ihAwGwsxZNpqen72px1yI6ZACU/h6B3MPzAoWTP72fUmdQzI3PNv3xjEMxcg7QmJBTxLx2fgBDxIFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgmG6aHK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4125000b3a.3;
        Sun, 29 Jun 2025 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751245553; x=1751850353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tnhen2Rw1k5JsQ/lARRo8Ino0meN+pohOW9LsCInMVM=;
        b=VgmG6aHK0SI8VcST02LPsPZ94O5bR2yM7EMmt3CeHwOFJnAAfxgKnaVv7MgL8rtJQH
         6pO6wx+jKCDUXLhhxvqXXCMvuCEJyag+4+TictBeeFFQF8BMa8/G5FQouiCU5SZdCnif
         kb8hwrcPpdhILgyrZESc2JofULYLBREDrvEFDLIYOV2BQuZLZgnv2T7CSWexWERYxKGC
         DaUqrVyiRa139/26hlhfGJYUYRQ5lEysnV1beqM0RcoDeKuHE4LK/hggVeWWgH37zMCO
         xw1oTZ83J150RCPYC5uejJFsmnls5w6ETwrIhFReccseuMDn0ERyaQFPTbSMPHY66t9Q
         rOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751245553; x=1751850353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnhen2Rw1k5JsQ/lARRo8Ino0meN+pohOW9LsCInMVM=;
        b=MQBtULLKs1aVUpZEASFlwi75ZUuoaPKtawILmcnxQlXel5jvNAsIZkOFtF5NMGzGS1
         jijiPDiQjLNFC94Zds4u7Q/+spmKQRjW0/RJ78NZLgEe6BwhtSpWI360a/4+e5wDONwM
         5+z97P3p1aqfrj1K2vzzJGKFoHOvB57vn4vGTb4Gf2UhT9ObGWJxevyJy31r3TxsbeJQ
         xJ7Mvrk0DG3k/HkHbY/1lkUFYUGAF/4/VvMlVS4gyzE57ioh64koMgSLlw9QVBw6cVnN
         h9+61xV2Jy6Aw5OIW9BPosLGSoWutADWulG0QX337Hvsa7dHck5PIiMc07mN8Ps0Z1oY
         ZgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5BC+fhV+GKM3pw8CG5Xw2/6JJBfK0/pvPFeQGsiCMlCqCrj5uZWNiOhq3V3V7Tl7w9iqs8BhhGeV8km8LT+VE@vger.kernel.org, AJvYcCVI0AMri2zdZVq8Py+PkMQ0BWxCYAkKQdYoPkFkJ1110gjrjw6q4ThZa3LKJZvTEXkD8AuiGPitBqZNz9YJ@vger.kernel.org, AJvYcCX9Nc0KECV/N3Kg9/ncqxmTKRC+PxbMx+0C1JYqtOKQzar1SotJYPjWTWycRK/0ipfwd8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xsXN5dXi/bIa/M5n9OyKDTR6ICtRzfZ6WCZDmp51oFb60soW
	q9sfIkrQl3x6jd8/KXS3TAGMwrqVmFGtlw7DlezkqugBkjrUEGlXBMjV
X-Gm-Gg: ASbGncvCV8Zke8LPm5pDARTVdOlz8krCub5ORrSpImlkq2XsKwdY7W+vvfdsi0f8fmu
	/PwVE/7hwE6BEeKx3JLn180LyMywZeQ7poAOt4WAvmoXUN3ZZEzyO0CiUxciSmTdezblO4Eftlc
	3fm53tEkT807HfrFoFrsWmpNKcLngiag1BmZ5uBhqnL+nkV7AzSGcrm+7HRm5/8Dx/Yg5iTTilm
	LCqT4LI1MNrfm0CAAlK9ZGJmxsyXMb49vTMvlbLi+ynFiLwR46SKEm3DwUezJ/zTHX1+LhZ3hZT
	pJEBxNYpAbTaCm7+IW4fJojxOkylBbKWmcfbYwCTxGRZB7+KKAcQrDcVDg==
X-Google-Smtp-Source: AGHT+IHj/+Q0HzChyZILMS4ZuNN2bb9vE1x2v8Syb0cINVrL1gK4PsaIyi5Oe+AltudjhrnZ+KsR8w==
X-Received: by 2002:a05:6a00:1389:b0:749:9c2:e154 with SMTP id d2e1a72fcca58-74af6e63144mr15581244b3a.4.1751245553134;
        Sun, 29 Jun 2025 18:05:53 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56d0002sm7942287b3a.136.2025.06.29.18.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 18:05:52 -0700 (PDT)
Message-ID: <34cb9cb46df58e118f7fe488ff40fd7a5cf7f224.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix aux usage after do_check_insn()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Andrii Nakryiko
 <andrii@kernel.org>,  Mykola Lysenko	 <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peilin Ye
 <yepeilin@google.com>,  Jiayuan Chen	 <mrpre@163.com>, Saket Kumar Bhaskar
 <skb99@linux.ibm.com>, Ihor Solodrai	 <isolodrai@meta.com>, Daniel Xu
 <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Chaignon	 <paul.chaignon@gmail.com>
Cc: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Date: Sun, 29 Jun 2025 18:05:50 -0700
In-Reply-To: <20250628145016.784256-3-luis.gerhorst@fau.de>
References: <20250628145016.784256-1-luis.gerhorst@fau.de>
	 <20250628145016.784256-3-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-06-28 at 16:50 +0200, Luis Gerhorst wrote:

[...]

> @@ -19955,11 +19960,11 @@ static int do_check(struct bpf_verifier_env *en=
v)
>  			/* Prevent this speculative path from ever reaching the
>  			 * insn that would have been unsafe to execute.
>  			 */
> -			cur_aux(env)->nospec =3D true;
> +			prev_aux(env)->nospec =3D true;

I don't like the prev_aux() call in this position, as one needs to
understand that after do_check_insn() call what was current became
previous. This at-least requires a comment. Implementation with a
temporary variable (as at the bottom of this email), imo, is less
cognitive load.

>  			/* IF it was an ADD/SUB insn, potentially remove any
>  			 * markings for alu sanitization.
>  			 */
> -			cur_aux(env)->alu_state =3D 0;
> +			prev_aux(env)->alu_state =3D 0;
>  			goto process_bpf_exit;
>  		} else if (err < 0) {
>  			return err;

[...]

---

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a136d9b1b25f..a923614b7104 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19953,6 +19953,7 @@ static int do_check(struct bpf_verifier_env *env)
 	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_insn *insns =3D env->prog->insnsi;
+	struct bpf_insn_aux_data *insn_aux;
 	int insn_cnt =3D env->prog->len;
 	bool do_print_state =3D false;
 	int prev_insn_idx =3D -1;
@@ -19972,6 +19973,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
=20
 		insn =3D &insns[env->insn_idx];
+		insn_aux =3D &env->insn_aux_data[env->insn_idx];
=20
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
@@ -20048,7 +20050,7 @@ static int do_check(struct bpf_verifier_env *env)
 		/* Reduce verification complexity by stopping speculative path
 		 * verification when a nospec is encountered.
 		 */
-		if (state->speculative && cur_aux(env)->nospec)
+		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
=20
 		err =3D do_check_insn(env, &do_print_state);
@@ -20056,11 +20058,11 @@ static int do_check(struct bpf_verifier_env *env)
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
 			 */
-			cur_aux(env)->nospec =3D true;
+			insn_aux->nospec =3D true;
 			/* If it was an ADD/SUB insn, potentially remove any
 			 * markings for alu sanitization.
 			 */
-			cur_aux(env)->alu_state =3D 0;
+			insn_aux->alu_state =3D 0;
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
@@ -20069,7 +20071,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 		WARN_ON_ONCE(err);
=20
-		if (state->speculative && cur_aux(env)->nospec_result) {
+		if (state->speculative && insn_aux->nospec_result) {
 			/* If we are on a path that performed a jump-op, this
 			 * may skip a nospec patched-in after the jump. This can
 			 * currently never happen because nospec_result is only

