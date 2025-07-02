Return-Path: <linux-kselftest+bounces-36280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5AAF0E89
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B203A884D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAF23C8C5;
	Wed,  2 Jul 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="rwmvd/Gr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FF238D32;
	Wed,  2 Jul 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446602; cv=none; b=twTy2pPm9hdoA04uSdgOVbP6NrojwvLO2/nfljDpxC2ZopeSX4CfRl2hO6wnehtmdndJ7/BwMd0usenDjs4NdosGTUhVpjoE1wJeQYG9LxiyiK+mYCdxwcQ/9bAFOb1BrU0Ic6GqER8jAYnDQf12hIIj3YhT8CmdO6Talz2e5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446602; c=relaxed/simple;
	bh=vjaZgPGHhQCUFi8kYGwclSOLMTA/Fx882MzioHTvYr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q0juImYvy/OPNcI1bU6vVrF52dStHn2AbbcTiZQL45b7Ewo/Owl7Hikj6JdM0avVPIqZKjmJ/H1XmVn1prWfSYa/3YQqU6r8f6xj/kwkPtNdFo4/DBE5EEJLlt+gmiSXsp1WiydrbmYT4oreLJWY8T5GFWPTLr66tzthw+kX4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=rwmvd/Gr; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1751446590; bh=ERByeJCe1cWWNS3vP9KS5ms0EJRSp6XZFQRU53DFAZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=rwmvd/GrM5+fy9sPDtVUE6VIS8OP+tdd8lk4e81LxGWsQrbI4GqIXt59d/yb5Ke+C
	 TBRgT6DsRTMPzSYW/jTpO/bRiKIFgoA4On+Jfeqrm5y0ZmhocqbHH1hbgBVAoDz6Xb
	 5DJPGCqJafwHpbdL0QSyHijizC2so+NX7T+rX9h3U3cZUUnsrKMG/ITamKuEkdUsPt
	 nL58RnEFHDo+EcLJWH24O/s3/I/lhs9SpWpICvinQY6qEVS0t48ZhhZPDOpKX2KTal
	 VSpF9Q4xq52tH/T8u13yTVIQcZWQ1kVfM5EO8Gmp29oXsHkOH3UaRYFK6aj3djxy+F
	 VMtrc6Fgoch9g==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bXDKB0H6lz8ssF;
	Wed,  2 Jul 2025 10:56:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3619:9e00:5b01:5faa:2b6e:b31e
Received: from localhost (unknown [IPv6:2001:9e8:3619:9e00:5b01:5faa:2b6e:b31e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1987lk1V9WunFiGUOuBlWS8JL9VHDWIwPY=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bXDK66gKqz8sj0;
	Wed,  2 Jul 2025 10:56:26 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Mykola Lysenko <mykolal@fb.com>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song
 Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,
  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri
 Olsa <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  Peilin Ye <yepeilin@google.com>,  Jiayuan
 Chen <mrpre@163.com>,  Saket Kumar Bhaskar <skb99@linux.ibm.com>,  Ihor
 Solodrai <isolodrai@meta.com>,  Daniel Xu <dxu@dxuuu.xyz>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Paul Chaignon <paul.chaignon@gmail.com>,
  syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix aux usage after do_check_insn()
In-Reply-To: <34cb9cb46df58e118f7fe488ff40fd7a5cf7f224.camel@gmail.com>
	(Eduard Zingerman's message of "Sun, 29 Jun 2025 18:05:50 -0700")
References: <20250628145016.784256-1-luis.gerhorst@fau.de>
	<20250628145016.784256-3-luis.gerhorst@fau.de>
	<34cb9cb46df58e118f7fe488ff40fd7a5cf7f224.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 02 Jul 2025 10:56:25 +0200
Message-ID: <877c0rdl8m.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Sat, 2025-06-28 at 16:50 +0200, Luis Gerhorst wrote:
>
> [...]
>
>> @@ -19955,11 +19960,11 @@ static int do_check(struct bpf_verifier_env *env)
>>  			/* Prevent this speculative path from ever reaching the
>>  			 * insn that would have been unsafe to execute.
>>  			 */
>> -			cur_aux(env)->nospec = true;
>> +			prev_aux(env)->nospec = true;
>
> I don't like the prev_aux() call in this position, as one needs to
> understand that after do_check_insn() call what was current became
> previous. This at-least requires a comment. Implementation with a
> temporary variable (as at the bottom of this email), imo, is less
> cognitive load.

I think I agree. I will send a v3 with the variable.

>>  			/* IF it was an ADD/SUB insn, potentially remove any
>>  			 * markings for alu sanitization.
>>  			 */
>> -			cur_aux(env)->alu_state = 0;
>> +			prev_aux(env)->alu_state = 0;
>>  			goto process_bpf_exit;
>>  		} else if (err < 0) {
>>  			return err;
>
> [...]
>
> ---
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a136d9b1b25f..a923614b7104 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19953,6 +19953,7 @@ static int do_check(struct bpf_verifier_env *env)
>  	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
>  	struct bpf_verifier_state *state = env->cur_state;
>  	struct bpf_insn *insns = env->prog->insnsi;
> +	struct bpf_insn_aux_data *insn_aux;
>  	int insn_cnt = env->prog->len;
>  	bool do_print_state = false;
>  	int prev_insn_idx = -1;
> @@ -19972,6 +19973,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
>  
>  		insn = &insns[env->insn_idx];
> +		insn_aux = &env->insn_aux_data[env->insn_idx];
>  
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
>  			verbose(env,
> @@ -20048,7 +20050,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		/* Reduce verification complexity by stopping speculative path
>  		 * verification when a nospec is encountered.
>  		 */
> -		if (state->speculative && cur_aux(env)->nospec)
> +		if (state->speculative && insn_aux->nospec)
>  			goto process_bpf_exit;
>  
>  		err = do_check_insn(env, &do_print_state);
> @@ -20056,11 +20058,11 @@ static int do_check(struct bpf_verifier_env *env)
>  			/* Prevent this speculative path from ever reaching the
>  			 * insn that would have been unsafe to execute.
>  			 */
> -			cur_aux(env)->nospec = true;
> +			insn_aux->nospec = true;
>  			/* If it was an ADD/SUB insn, potentially remove any
>  			 * markings for alu sanitization.
>  			 */
> -			cur_aux(env)->alu_state = 0;
> +			insn_aux->alu_state = 0;
>  			goto process_bpf_exit;
>  		} else if (err < 0) {
>  			return err;
> @@ -20069,7 +20071,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
>  		WARN_ON_ONCE(err);
>  
> -		if (state->speculative && cur_aux(env)->nospec_result) {
> +		if (state->speculative && insn_aux->nospec_result) {
>  			/* If we are on a path that performed a jump-op, this
>  			 * may skip a nospec patched-in after the jump. This can
>  			 * currently never happen because nospec_result is only

