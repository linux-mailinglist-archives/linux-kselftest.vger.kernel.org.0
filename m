Return-Path: <linux-kselftest+bounces-29138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B2A62E3B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66753B9BFA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98831F76C6;
	Sat, 15 Mar 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="lZC/tbK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691872E338C;
	Sat, 15 Mar 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742049339; cv=none; b=Z/i9041a4f0Xu1187qBZQQqQsFxWLE5ksYkmZJpnN3Xm1KRLGzgHmpk2oqTa9cslYAqZibGkRXBYYv/JvF/8XpuBXO5+ef0fyUFsgFC3pyRcF5TvkinLWtzxPoR8ap89smlVhPzEKjJRSvCXYckv6QQBSZxZzdz5VVBiXOBms3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742049339; c=relaxed/simple;
	bh=OkhF71d/bZ8TD/llrAXXX4wBjozRHz+q4IHia73yoww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UChh8eJJwE/2BT0EgMGNl71MQcgDQ4GIr5s8ja/oT4bQuRineoySI2etjvmEm/SMhGLZy0fraibvELfppZCzJ2Ret1IcmdVzF7Bhz3oj0iXae6EdB3T7v4vcUAvUid3M+vdZ/okjn0fvqiNKlenGL3RPrMPe6mch50ZGZq9UomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=lZC/tbK4; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1742049327; bh=NKq80W2W/U7t62HvKju2DWkfvvmrMHzUgfKCh8A8fD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=lZC/tbK4VA1jg6uUg1xFVHXsgRkGYB4xDIQmrxlQdclI04AhPC93jh5VD4OdBv5eI
	 7GKzMV5fU0+jZopO+yyfeQgD5mTn88lmVWySqSBYA7vaZ+sa9kTqJHD3CzJU5IgtQO
	 65xS31s1PE/2sIT0BhwwKBYy8dECHGUbyX2lqtBcBNroFt2ZyJ76QDQkNKI/XUvLw7
	 zmKTiGRoyxyCr4lVjsCGDfMH8w/8yPy49Zh6SzuHz4Rnynh4PgFv6z4gM6UOh7FsMY
	 NQJ7dKsrP79s06e8VBwleNRYG/EdQwb8DUYEfLmRFGR0lEpVCKUohyjEt1N4Vxozqj
	 +lZs4Wu8/hlyg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZFP0b3yp2zPlS4;
	Sat, 15 Mar 2025 15:35:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:361f:c600:5210:4b80:a502:1f98
Received: from localhost (unknown [IPv6:2001:9e8:361f:c600:5210:4b80:a502:1f98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/CUai+vFSchsFbhqVGYGLtiAUlGPs0iho=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZFP0X0QFczPlV0;
	Sat, 15 Mar 2025 15:35:23 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>,  Xu Kuohai
 <xukuohai@huaweicloud.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Hari Bathini <hbathini@linux.ibm.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>,  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
  Mykola Lysenko <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,
  Henriette Herzog <henriette.herzog@rub.de>,  Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
  Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>,  Daniel Xu <dxu@dxuuu.xyz>,  bpf@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kselftest@vger.kernel.org,  George
 Guo <guodongtai@kylinos.cn>,  WANG Xuerui <git@xen0n.name>,  Tiezhu Yang
 <yangtiezhu@loongson.cn>,  Maximilian Ott <ott@cs.fau.de>,  Milan Stephan
 <milan.stephan@fau.de>
Subject: Re: [PATCH bpf-next 01/11] bpf: Move insn if/else into do_check_insn()
In-Reply-To: <293dbe3950a782b8eb3b87b71d7a967e120191fd.camel@gmail.com>
	(Eduard Zingerman's message of "Fri, 14 Mar 2025 15:47:00 -0700")
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	<20250313172127.1098195-2-luis.gerhorst@fau.de>
	<293dbe3950a782b8eb3b87b71d7a967e120191fd.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 15 Mar 2025 15:35:23 +0100
Message-ID: <874izus6ok.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:
> On Thu, 2025-03-13 at 18:21 +0100, Luis Gerhorst wrote:
>> +		err = do_check_insn(env, insn, pop_log, &do_print_state, regs, state,
>> +				    &prev_insn_idx);
>
> - `regs` remains declared in do_check(), while nothing prevents
>   pushing its declaration to do_check_insn().
> - `state` is `env->cur_state`, so I'd avoid passing it as a parameter
>   (just to reduce count);
> - `prev_insn_idx` is unused by `do_check_insn`;
> - `pop_log` is not used by `do_check_insn`;

Changed for v2, thank you very much.

> - given that `insn` is presumed to correspond to `env->insn_idx` in
>   many places down the stack not sure about this parameter.

I don't have a strong opinion on this either. Unless someone objects I
will keep it as it matches the other check_*() functions like this.

>> +		if (err < 0) {
>> +			return err;
>> +		} else if (err == INSN_IDX_MODIFIED) {
>
> Also, I'd get rid of `INSN_IDX_MODIFIED` and move `env->insn_idx++`
> into `do_check_insn()`. This would save a few mental cycles when
> looking at the code with full patch-set applied:
>
> 		} else if (err == INSN_IDX_MODIFIED) {
> 			continue;
> 		} else if (err == PROCESS_BPF_EXIT) {
> 			goto process_bpf_exit;
> 		}
> 		WARN_ON_ONCE(err);
>
> 		if (state->speculative && cur_aux(env)->nospec_result) {
> 			... bunch of actions ...
> 		}
>
> 		env->insn_idx++;
>
> One needs to stop for a moment and think why "bunch of actions" is
> performed for regular index increment, but not for INSN_IDX_MODIFIED.

That certainly makes it more readable. I changed it for v2.

If we have an instruction that does not simply do `insn_idx++` but
jumps, the `nospec_result` check should never trigger. Otherwise, the
patched nospec might be skipped. Currently, this is satisfied because
`nospec_result` is only used for store-instructions. I will add a
comment and WARN_ON_ONCE to document that for v2.

