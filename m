Return-Path: <linux-kselftest+bounces-26587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491EA34F77
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DAE3ADD0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA0266B4D;
	Thu, 13 Feb 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="acmIhGlJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0C266B47
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478977; cv=none; b=T6qT79WDgb2oZUvtPkskKMb/hI9bbiPZbSP8L3f49TzLTov6v/BPNVh+c3nHibzV7Vuri4ovnfoho1z7JgkqT7BbFINuv830V2fwEY6VhPoyPTcIRuRLu6giypptazp9JcokNnmCgEVDh6/wWYNStetDKi+XGVFSsP3uxFTpVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478977; c=relaxed/simple;
	bh=3OmoPPtRJ3Eu45qzEZ5Fn9o4ggtZYUBS4BI+ZuxwU9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Y+kJLoKwPa11UlScLj7MIiotDaRI/OzduT6mSEZcJcO7xIwbp/+RMSgMcvySNA8pjrVkII0DZSLe0QXAobH88rxzEWGhKf/kUjVQKb2o9F9Pdoum3dJ0tZkRoAwLDf5IBRMXUo9QwlFyBm5ZJMH6DKr7TNl/EZ7JnCoGXTOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=acmIhGlJ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef60e500d7so12599397b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739478974; x=1740083774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBViFwG3GkhnREQpuSeahWWDP1mD68WVlRn8a2dnxcU=;
        b=acmIhGlJgUa5X6x/p6lGSR1OOTQm1fFvAnS8y5pnJIQNrmErCwufB/us5tLL+QCi3d
         5/c2g9J/IeOzJDhW6nAaE+9xa3w0MILNPonFLCcxhj1nzE6uaU2zgaQxwGSg5wFjJMZH
         wDe/5xMMaBdU8pupcqRhTla0MVHXbLiMtoU3+7wiYleKzhrGjYEoPoxQgRSvC70TiG9B
         lGAZDAFhqkqInpWF4EkfE+mLuzrar8bs84DmX5t/UAG/neQjPpE5Ip7b9g3jNaLAsFYh
         eXtEeYKTOeL1hqbOa+I/FU5/wNK0QtBeF6GIZV48r7NW3DupoIZKnYu5Z9y5DbuiFeHt
         lUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739478974; x=1740083774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBViFwG3GkhnREQpuSeahWWDP1mD68WVlRn8a2dnxcU=;
        b=kkDOVAgSRuS6zqUgR+A8verE3SGm8xAdyG2kCmTeK7F6+F8o5+c0ZBv3tLjIesX3TO
         eVB+QRRGBrAvlJYljiYec4YqQ7hzlnBAPeHZgD0UfOXIyd3sXdaWMLNtR3dQ/rNPQggy
         a9lvu0utg7QPYzFnLqjQ6h/eYfmoTEzE2CL4n6+c+DPwXYCpnuhNSpfJUOMPD/u+LdXJ
         DpRMAYJQM3D1GG+pnzxdksImiBjt6UHAe3bdMCqESsNgdfK2VWWmGJT4u+SbKT/nUxG6
         mV0Avhcu37b2zGqvYnkvUlogY9p+FhgmuqOzs69NAgKHXO6TX3ElxbeFJ2PgDQ3ArTpi
         1cVA==
X-Forwarded-Encrypted: i=1; AJvYcCWnnFqZUUA1XnP6HEGKMeAuXJRzcXyGVnGGiq87zPADthA1FPWclEgGqFkuOP7dF3gl/nQ/DTOvQDNCFLRDNi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycejKO+VsJjCX7bMZBLiEyKljNd/Qj8fGPdEXbv6Ht4yO9vRUL
	DSTMqDV9zHCg37nRB/R3ZNpU5vIsrbf8nkk+UydEM5GPEb0tq90ETP6sc8tbO4g=
X-Gm-Gg: ASbGncte5K+kY/4Xun/9pGe8lVGw9U4FfV/Z3wYnwLoGeRdxf1BRyFggRZPMsbr4g8C
	lL0ba3519ppw9ZasH6buoe87esLIjov7LT6T7YCR2C7ejFEbozsxVbWztm5Na0cBnkyG7xtyrMQ
	oOH2o4CC8lYk7CGCR/1087oCcxKz1FwFM2I1cW9RuR40w3QME9t6KR4uKVR6a/rALT3H0YE2eds
	1EeuzQ8zIdtnEoXFcRl8Xqk65NMeBd4V9nLlR7rCmOv4agcpkrSdXEdy2qBYrlGa4TcOgPQjt11
	7ZU=
X-Google-Smtp-Source: AGHT+IFli3J2pYxGrWlDhVf9piBN6Mt57GNwjDPRKZNkn4CDBVtemQHp9qzLUy0Yrgza7R0zwIrtIA==
X-Received: by 2002:a05:6902:11c7:b0:e57:4db7:6d51 with SMTP id 3f1490d57ef6-e5d9f170324mr8763028276.32.1739478974506;
        Thu, 13 Feb 2025 12:36:14 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dadeca97bsm580863276.32.2025.02.13.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:36:13 -0800 (PST)
Date: Thu, 13 Feb 2025 12:36:12 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <Z65XvCrcBlf61LYw@ghost>
References: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
 <20250210-quiet_tools-v2-1-b2f18cbf72af@rivosinc.com>
 <Z6tSvUt47FV60UJA@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tSvUt47FV60UJA@krava>

On Tue, Feb 11, 2025 at 02:38:05PM +0100, Jiri Olsa wrote:
> On Mon, Feb 10, 2025 at 10:34:42AM -0800, Charlie Jenkins wrote:
> 
> SNIP
> 
> > +# Beautify output
> > +# ---------------------------------------------------------------------------
> > +#
> > +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> > +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> > +# that command is printed by default.
> > +#
> > +# e.g.)
> > +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> > +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> > +#
> > +# A simple variant is to prefix commands with $(Q) - that's useful
> > +# for commands that shall be hidden in non-verbose mode.
> > +#
> > +#    $(Q)$(MAKE) $(build)=scripts/basic
> > +#
> > +# To put more focus on warnings, be less verbose as default
> > +# Use 'make V=1' to see the full commands
> > +
> > +ifeq ($(V),1)
> > +  quiet =
> > +  Q =
> > +else
> > +  quiet = quiet_
> > +  Q = @
> > +endif
> > +
> >  # If the user is running make -s (silent mode), suppress echoing of commands
> >  # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> >  ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > @@ -145,9 +172,11 @@ short-opts := $(filter-out --%,$(MAKEFLAGS))
> >  endif
> >  
> >  ifneq ($(findstring s,$(short-opts)),)
> > -  silent=1
> 
> hi,
> I think you need to keep this one, there's "ifneq ($(silent),1)" condition
> later in the file for the silent (-s) builds

Oh yes, thank you.

- Charlie

> 
> jirka
> 
> 
> > +  quiet=silent_
> >  endif
> >  
> > +export quiet Q
> > +
> >  #
> >  # Define a callable command for descending to a new directory
> >  #
> > 
> > -- 
> > 2.43.0
> > 

