Return-Path: <linux-kselftest+bounces-18329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D7984DFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C828551A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DF16DEB3;
	Tue, 24 Sep 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SLqyPgRt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE513D8A3
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217668; cv=none; b=aWlnneN8XcauQ6bx0vIUpWMf+bB8B7BFjpPWpmVOeT15mpQhLdY2beNht+rqABaoDKp9zPjXBsK0vYCIAzr5U1YFjRvvGYWGpYc6VTCgYUuGuFAgiO4wccK4dsM0kiKs/58pZ5W+3LhcJmw7d1I5CCNCqH+q8Eqk1Obw8RHg3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217668; c=relaxed/simple;
	bh=NhMixv5kl+9QH6xYXoXAIcF/J3IXlleAgXvIX0252z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oS2bx264Mq+xiffIYjtKNoRbsKLmqsxv+2hQL/Esy2Nht2O90XXiT6mBUzS1Jz0eV9WS/yrsxmrCkNtUIBzA+GZKmpDJKpLcIQw1C74hWRUZS77wA5HhpwKqsu66Km/FzLrjTyNR1PBWknpwmNNR/lWHOGlvUy8CDQXG4b8wkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SLqyPgRt; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7c16253-eff3-4d34-80c3-884790ecfdb4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727217663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/3ql7hSu6hfJ6OUqVAGGrToVQdofg7CuYaFZlYBk80=;
	b=SLqyPgRtLkk/M3T3thMFA4Fk9htRI6ziWWflbkjrvNW+jLBX6iVw63Kg2ZVUh+c6tbkWgP
	GVAB6wHaVDQijoBgFZclOYkd22LPH2GX6TUK7HEr9HQm3yldyj9S/BbIczOBrPWqRi4188
	1IgMXcJqtnKIYjKEqhuEFpd70PjRN3k=
Date: Tue, 24 Sep 2024 15:40:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf:Enhance bpf ability to detect
 ksym read error by libcap
To: Lin Yikai <yikai.lin@vivo.com>
Cc: bpf@vger.kernel.org, opensource.kernel@vivo.com,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240914092426.431066-1-yikai.lin@vivo.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240914092426.431066-1-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/14/24 11:24 AM, Lin Yikai wrote:
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 04716a5e43f1..369c5ad8fc4a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -183,7 +183,7 @@ NON_CHECK_FEAT_TARGETS := clean docs-clean
>   CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
>   ifneq ($(CHECK_FEAT),)
>   FEATURE_USER := .selftests
> -FEATURE_TESTS := llvm
> +FEATURE_TESTS := llvm libcap
>   FEATURE_DISPLAY := $(FEATURE_TESTS)
>   
>   # Makefile.feature expects OUTPUT to end with a slash
> @@ -208,6 +208,11 @@ ifeq ($(feature-llvm),1)
>     LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
>   endif
>   
> +ifeq ($(feature-libcap), 1)
> +  CFLAGS += -DHAVE_LIBCAP_SUPPORT
> +  LDLIBS += -lcap
> +endif
> +

[ ... ]

> @@ -31,6 +35,55 @@ struct ksyms {
>   static struct ksyms *ksyms;
>   static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
>   
> +#ifdef HAVE_LIBCAP_SUPPORT
> +#include <sys/capability.h>
> +static bool bpf_cap__capable(cap_value_t cap)
> +{
> +	cap_flag_value_t val;
> +	cap_t caps = cap_get_proc();
> +
> +	if (!caps)
> +		return false;
> +
> +	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)

Instead of adding new dependency on libcap, please check if capget() can 
directly be used. Take a look at tools/testing/selftests/bpf/cap_helpers.c.

pw-bot: cr

> +		val = CAP_CLEAR;
> +
> +	if (cap_free(caps) != 0)
> +		return false;
> +
> +	return val == CAP_SET;
> +}

