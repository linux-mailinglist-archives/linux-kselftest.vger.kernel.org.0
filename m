Return-Path: <linux-kselftest+bounces-5247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D579585EB81
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 23:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A21F26325
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D741128392;
	Wed, 21 Feb 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpj48WmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435A83A1F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552874; cv=none; b=LoWe3CoBgzQb6jhdq8b7dZFVugpwxwGlhU3nSOFKULMnJqhqTF1r//YpvHEzyo15KAdJh7MZyA5H6H8EeMh0RiXSziyaGHpMKOkU+I2UWolqDCAoygaFyHF882L86PaTC9gVFGxj+MeOYQxaHKeWRhqoJV+g9m7J2yk1F8ynsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552874; c=relaxed/simple;
	bh=wqGWw9nOiid78rmVoNJpLAKogw9OxxtIINANjebVuns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9iK25DnO/OIZ8iSuvsef6QP4QrQe/jab1XeE4mFCgVTJIw3DmyWF1zckgAgTowHt2oMij9Ijgxy3aW+gr5QDcFPOQR9WVcOPPAdAmclQwQUOf35jQ6sZGsnfXicKd9w4htDpsNMQOp2mE0MKnfa1Skuu5RkX2k7/Y4gRnfFMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bpj48WmF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbd32cff0bso35464345ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708552871; x=1709157671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+6LHH2NPUzYokJHyaMeg6P0BHjKGeB4TbkarefmniY=;
        b=bpj48WmFS/Iv/Pl0hg7lOS8zJgnv0NSStFCNmbJ6KEpuG46kTUN/691glGTo/3Ussp
         p+NO4+VI9TFFxK1I1IpwAumuQPpNmQosA0O5VcsIoRgOfll/Zs90O7tq42+7asod3qYo
         QfauMBovnb/+K04a39tMMdP5sPWShkQq8NrPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552871; x=1709157671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+6LHH2NPUzYokJHyaMeg6P0BHjKGeB4TbkarefmniY=;
        b=h8wX/t6nNa+YtbLV9TUWktVfod0Kpr4PMTpa2LlT9QggRXp4mHr3LRJrqgmmA1J7xw
         TzB+SPXcQRD0P/189ABpeCBU7zoVDsldMVIlASR7rmjxma/Vpcp/kawPcWC1muifLZtX
         bf4RmsUje9DTbfjK028LdHH0v9OX6JuKpfxflccPCjfG+Evb6TrXtPBCI/cUFsguUjU/
         9PEQdHLitQYQlCJDDSdVn261Y/v7oyz0oxw50PoM6j+FzRFUqYhYpUiJCD6DT2q/6Yzv
         dQj5jZisKSnldLDaWNRPUfYUbbIPfHBZ2USCzOKjxvP9ms0iz37fW7LBtpmEBpswXl8N
         18BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMMMzxyMpIFiLYj11LasvHF3B/JaDjpSvDaeVC/Vrn6F1fablGL5KbDiR1uFkzBebzFeFqcAYRdowjLIFnZgrMuC1ohIo2cAq9Z31X5y+j
X-Gm-Message-State: AOJu0Yx35G2kxJHMLppbGKKCo9+rlV84SWiFqsVqkGYDPbRN8016pIbt
	Bh7D6weml02GU08dDU6Td9YOSkAs1dRsDd+7hoL+npfEtbr4iLUfgn8eQTUE1Q==
X-Google-Smtp-Source: AGHT+IEf5eKUQSWm+opFfaiF5eBQJmg0AXhYyA+h2y9jNbW7sOQuiyq0AM8mKQQVx25bJ6R/7Y4UCw==
X-Received: by 2002:a17:902:f70f:b0:1dc:4b04:13d4 with SMTP id h15-20020a170902f70f00b001dc4b0413d4mr60269plo.8.1708552870628;
        Wed, 21 Feb 2024 14:01:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902e90400b001dbba4c8289sm8533989pld.202.2024.02.21.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:01:10 -0800 (PST)
Date: Wed, 21 Feb 2024 14:01:09 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402211347.2AF2EC4621@keescook>
References: <20240220185421.it.949-kees@kernel.org>
 <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>

On Wed, Feb 21, 2024 at 05:39:55PM +0100, Daniel Borkmann wrote:
> The build in BPF CI is still broken, did you try to build selftests?

Okay, I give up. How is a mortal supposed to build these?

If I try to follow what I see in
https://github.com/libbpf/ci/blob/main/build-selftests/build_selftests.sh
I just get more and more kinds of errors:

In file included from progs/cb_refs.c:5:
progs/../bpf_testmod/bpf_testmod_kfunc.h:29:8: error: redefinition of 'prog_test_pass1'
   29 | struct prog_test_pass1 {
      |        ^
/srv/code/tools/testing/selftests/bpf/tools/include/vmlinux.h:106850:8: note: previous definition is
 here
 106850 | struct prog_test_pass1 {
        |        ^

Messing around with deleting vmlinux.h seems to get me further, but later:

/srv/code/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c: In function 'bpf_testmod_ops_is_valid_access':
/srv/code/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:535:16: error: implicit declaration of function 'bpf_tracing_btf_ctx_access' [-Werror=implicit-function-declaration]
  535 |         return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~

and then I'm stuck. It looks like the build isn't actually using
KBUILD_OUTPUT for finding includes. If I try to add -I flags to the
Makefile I just drown in new errors.

-- 
Kees Cook

