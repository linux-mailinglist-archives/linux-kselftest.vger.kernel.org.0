Return-Path: <linux-kselftest+bounces-26361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9953A30D17
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 14:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A402164CE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2E221DAE;
	Tue, 11 Feb 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKGgyQhB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80C1B4243;
	Tue, 11 Feb 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739281092; cv=none; b=FhVbWXBOO2U2PSJrJts/vRUcU2ylBAbpb5UAUzyIkUC3h/ONCJM4pBSbcZDUzTMemWpS4ZHgSXZLbdVzsN3MSI+RuGdfa2CcJRu0b2zdakPJ3h9YqM9wJGN6tHGYUzi881ABbkFjKlSWUWL20Z5ZuLRP1HSs+tgx7Ig7kuPXhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739281092; c=relaxed/simple;
	bh=EeoFcYNG9Papmze2FRQ8J893pXeKTdGomDjuiMJ3hGY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lME0Fee8ZyfUy8so1sq1Fix0r61Jeq6DjVQDiHeWfjqpeBB7Z+IS31Fk2uQn6Po8CwIkEzDxACQkNVBiq/0jGQLnoUY+hbLEV99fmc4AUPzi2CaCzEeUQr2J3Ibcy9ciwC3ceveRu8pqur4fhQteZ3YQGYieuzoaEaSMyOtLRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKGgyQhB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeec07b705so877320766b.2;
        Tue, 11 Feb 2025 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739281089; x=1739885889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7BwISHyqmjGl9jMk/G92gil8BO6b9CN0gblbkBvfTA=;
        b=XKGgyQhB8FPsG9NL+n7CYUBIFzwNhyEseMnzw9EMpxzBsyKDgH/p35G7GrMfcNgKhK
         5WBws+JE3xZ3ZUObV2geUGRjFyU95LqbkqY5Mq7BYN3EbDEY0tj8uqL3tt+zPnG1N5Z/
         8MT9hV5MDkr0pbXCyq8aOwNRPMVdJRSMB+JLPxdPuqgof0HDGFsJmbI53CF5mHUqDNJ9
         q/GhtQPcxQiD7yWKp4IENtOaTGGko9CLjk08vJGNb+MFuKeRq9km5QjbFl0gT63a8MQK
         U1FhaYSR7QnhkyGAlbDVymk7zitjI9VYbvyJN9pQEXRia4F82F3hqt6y8pVAYl98zlX1
         Kz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739281089; x=1739885889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7BwISHyqmjGl9jMk/G92gil8BO6b9CN0gblbkBvfTA=;
        b=vQs9QpnK9r8qwTUJrOV+FYjPBv9Hak5eusflwrIPL1/2DOec96dxE+uW37mdwdP5W3
         oiHtyUQU645nAMyM0y78DjKkk6REmwLWnkVgEaHh+lMLau/F4w5SZSC6HIO1mQi4teBi
         OnPg0hvd0Ec4l492uB/17BJutnTdX3O4TyZJjp+WxrhXYlYluQyrZnkfsmzguqxP2aHl
         skZ7JQIl9VzJS8ujMgPqjSFtdcXE1dGBSuz/9zOUhLHQMn8CskQt5XxtE7j3INqpHgVA
         nMDHpiu0lCa2bKHzEfloDeD7jalBd5Mf5xismV0ykuuW2IcngtlzyiqebzbwylQSs0IV
         GBsA==
X-Forwarded-Encrypted: i=1; AJvYcCUIXnqvsaNcs+F1ZRfVnbyYJs44lS0lqVauNmqdp8On0YMYrkD3SPyQxn68S1LSUWtNq0zgHVWnXjgOQ/g=@vger.kernel.org, AJvYcCUleflgAkm2wlEi8u3cDSlEWFyJvPLnprCe30cNm7ja3DV1vML2sSTfdA5wPjlQJSprJNPsoZ4WPwT8k5EHF+/v0w==@vger.kernel.org, AJvYcCUzPGJ6glwWwfRbK64efm9mfaklEIYtHtx85POlRFh/+5pyjflJkIAkO1s+i1ZF9bq8X8anb3c+nkO2HD+QBip4@vger.kernel.org, AJvYcCVr53q+8kwgH0QHvMbmoRYez5GSV3NiggRn56wd/rkTwPQi66fimM+eVp0jTo1jJD27Se8=@vger.kernel.org, AJvYcCWTFZr7Re2wXKbDN1Ngv4W3ljhOtRz4bFOkoQrhUDHNtAihaoDVehUJsx++yss9nVuANqqtr+so0P0N6q2UNboAyKkq@vger.kernel.org, AJvYcCWYPS7307W+5apHWNkva1lBEDg+Y4N+KS+ELH8MEGgmSmvCluo+MrX/UFZDI5zySHOHmLDsJT/6G750DZVq@vger.kernel.org, AJvYcCWdJ0nCQ+vLfzaUZdFFN9QOw9aHLgIgyhcAHUMwY6B1xEcrOXitt24ZLrHHhs68PcTcXUqT9rz+qrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIdm1yxXR6mqeIEo5BTXUMUNc4h0/crs4clIEaVeaqtV9poJ6
	hzV9+p1urxvHzAJE1KdPdmpytdIC1JyJIk7Au/QfBrK25NhWyQbQ
X-Gm-Gg: ASbGnctDamob4ELB9Tw0rLfOFzv5YpfdcLtaUM1xVsyi+7h+EjhFClVZHezvlAm/6Jb
	qPK1l5U0BhkJChuoBxmuUOopA5EAloHEfII4VK0LGEdGcHBM66saiGYIysajx+Pb2Sb2EfrXOtF
	EW8NBMfry5mYUgD8u9G6uJJbvXellHVymJHfj4ZZFWvosQUdp0kyfOXPWwYSaiDxmwnEjCf/7WB
	C+WhHlwxX/QkV1jiChNKKGRCofTMJv/b7f70RqDljOu5sVfhjbbUllqIqBFZ5jKOVb91dxcGXrJ
	jQ==
X-Google-Smtp-Source: AGHT+IErrYuekv+/nrTb7IZvNJjKz2lGy53rvTWCwQL+ehrSB/L5vFNgAiZni7laN5QvT53Qm+BgvQ==
X-Received: by 2002:a17:907:6e88:b0:ab7:da56:af95 with SMTP id a640c23a62f3a-ab7da56b481mr345017266b.2.1739281088648;
        Tue, 11 Feb 2025 05:38:08 -0800 (PST)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d855b61fsm180430666b.124.2025.02.11.05.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:38:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Feb 2025 14:38:05 +0100
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z6tSvUt47FV60UJA@krava>
References: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
 <20250210-quiet_tools-v2-1-b2f18cbf72af@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-quiet_tools-v2-1-b2f18cbf72af@rivosinc.com>

On Mon, Feb 10, 2025 at 10:34:42AM -0800, Charlie Jenkins wrote:

SNIP

> +# Beautify output
> +# ---------------------------------------------------------------------------
> +#
> +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> +# that command is printed by default.
> +#
> +# e.g.)
> +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> +#
> +# A simple variant is to prefix commands with $(Q) - that's useful
> +# for commands that shall be hidden in non-verbose mode.
> +#
> +#    $(Q)$(MAKE) $(build)=scripts/basic
> +#
> +# To put more focus on warnings, be less verbose as default
> +# Use 'make V=1' to see the full commands
> +
> +ifeq ($(V),1)
> +  quiet =
> +  Q =
> +else
> +  quiet = quiet_
> +  Q = @
> +endif
> +
>  # If the user is running make -s (silent mode), suppress echoing of commands
>  # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
>  ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> @@ -145,9 +172,11 @@ short-opts := $(filter-out --%,$(MAKEFLAGS))
>  endif
>  
>  ifneq ($(findstring s,$(short-opts)),)
> -  silent=1

hi,
I think you need to keep this one, there's "ifneq ($(silent),1)" condition
later in the file for the silent (-s) builds

jirka


> +  quiet=silent_
>  endif
>  
> +export quiet Q
> +
>  #
>  # Define a callable command for descending to a new directory
>  #
> 
> -- 
> 2.43.0
> 

