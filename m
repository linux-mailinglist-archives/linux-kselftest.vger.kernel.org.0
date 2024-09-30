Return-Path: <linux-kselftest+bounces-18577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F72989B73
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B2C281C4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4213C9C4;
	Mon, 30 Sep 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMQTpuFv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974F21105;
	Mon, 30 Sep 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681454; cv=none; b=sOfLQQ4SxulkP+huVbmRwuxFwL3JdiBLgiawrK0e0WlSUWzBHseNEm4McOFoSypqywU9GAN/Ykk+z6x35zS8ZXpU7POCbNbOZDnTmZG4mUI5kv+kgFbFa9ux20kYLpc+a2ZDMjhFCkC/8u8LiOxC9WRxfqsxhHc8QAkRnJSVyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681454; c=relaxed/simple;
	bh=cCo/fLAbtIySYmGhjn2Dszar3sQ0qCxvq3HoyL6hBEU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8l1iBSuOGM0qJyBb9tCEOnomkpAYLQDuYrjHjXO5xYlh+sSRvkdMSXwCn6cAqn0ytYWjbGl6LvgwvGPUaOR3zfBr9kFk0E6KzwjQZKAtSfdsbRDxA19NmGkODT5mtiINmqy1hqEPdKLn8htum0S1Ieh7SyB9mhBYhxu7EQqCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMQTpuFv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so2094986a12.0;
        Mon, 30 Sep 2024 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727681452; x=1728286252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClHkn94f2eHvY8OtjIJbzSBBrFztTgapow7MgGqWqQ0=;
        b=NMQTpuFvRuFoRnUHCFh9f0ia2zEHPgtvbEV8twGpvI5QgJqG6M6xqjLJzlsdFfEhJX
         FdaCIjSwyTwo0JmzZhN8jmKCNziQp1T1bymt2nSscoJ693Zmoa9rmc+W+jv2T6BGhuZq
         pXs5yLgjOHDFksSAafkdCLL8d0QN5lzy86xYX9ddoeuoqxUbM44Z9adA2pUk7MJj+aQi
         Ce10rKBmMoMGzpN2QPUnesYfBOmWJtW0sFJBv1WiVhen8bcxOqzO1Jrpx1i7Hxv5H+2U
         KL+ZsX8QH+oHWBikGJP9SIrfgpq5fjg8moyt0wWqT3Qt2/WLAOvFYQnwzAGx8mLduXrE
         61OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727681452; x=1728286252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClHkn94f2eHvY8OtjIJbzSBBrFztTgapow7MgGqWqQ0=;
        b=NVQTkUPht0yIjsaX4nQMVs7b23hu6cKMlCfoEnzKEioZ5EaaR6edCVfmQKr00YsRU2
         Wn3TwJj9EDiRi0IVEH6V6ETlSdWMSkQZF8GtkLln3aJl7vziaAZvS1JZL4jOdmQy2mmF
         T1GLrfM6+iV0PAiTiRc4ImRxBT0qhIwAAi19jKTCbvBd9aFEg+6/PYgaNYsOL5MqjoSZ
         rI41Kmx1d96AedwdOt2ANAd9p11BnCitbECxGPeIM8NOAgNw2q4WuAMKsFS7TeLWUL7q
         hluBynZinT1U7XBkJZg8HlGqWje1rXaHUfT7Vimk0PLID1HIzYQ5FLXgWyyHYqSlLI9g
         jJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUOLp00zrNfRUC2thzMXkJWZzKzi7BNZTdK0wagKJqA+ZWNDTUUnkgio4PwkI0dK7Jd4oY=@vger.kernel.org, AJvYcCVRqYIw22w/dO5NigePvhrQbveJHCOiUnCQ4QtoWr5rMf+/PK4+KLATJpZ2fFL74SS2JLVUw5oGb73k7TRV@vger.kernel.org, AJvYcCWNw7B5gwXW9ls4mB2KeZ+4fZgULtB6QO35yvJw5lPT5ccETEi7GsfyeV/gv77EpW2D3g0JR+57hBGAsS7u+3ZB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2UxMTsOxm9hJDycQQFs9K/GqtzyR8Ydtw82jGN3bBvk6YZ3Y
	1URkUqja51PBoW6TWMOczoeL3Mfiu7xOHq3nTSDVKMn1e9lBXSvl
X-Google-Smtp-Source: AGHT+IG2GMh+01FhZGX/8NArehqsmFbxm0c8Tt5WgTBnanQ+Hw6SF+CyF2FSAL3EBXHm9LoXqPRHmw==
X-Received: by 2002:a05:6a20:6f9c:b0:1cf:4ed:ffc0 with SMTP id adf61e73a8af0-1d4fa1b8417mr17769352637.4.1727681452084;
        Mon, 30 Sep 2024 00:30:52 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c66e1sm5908521a12.47.2024.09.30.00.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:30:51 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 30 Sep 2024 00:30:49 -0700
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 -next] selftests/bpf: Use ARRAY_SIZE for array length
Message-ID: <ZvpTqammU0DqcKyz@kodidev-ubuntu>
References: <20240929092811.7103-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929092811.7103-1-jiapeng.chong@linux.alibaba.com>

On Sun, Sep 29, 2024 at 05:28:11PM +0800, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> 
> ./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:98:34-35: WARNING: Use ARRAY_SIZE.
> ./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:93:29-30: WARNING: Use ARRAY_SIZE.
> ./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:101:34-35: WARNING: Use ARRAY_SIZE.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11167
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Modify the header file "kselftest.h" to "linux/kernel.h".
> 
>  tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb16..7534014279ca 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -7,6 +7,7 @@
>  #include <sys/syscall.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> +#include <linux/kernel.h>

Hi Jiapeng,

I don't believe adding this header is needed, since ARRAY_SIZE is defined
in bpf_utils.h and already pulled in by test_progs.h below. Maybe try
without "#include <linux/kernel.h"> to check?

Take care,
Tony

>  
>  #include "test_progs.h"
>  #include "test_btf.h"
> @@ -90,15 +91,15 @@ static void test_bad_local_id(void)
>  	attr.prog_type = BPF_TRACE_RAW_TP;
>  	attr.license = (__u64)"GPL";
>  	attr.insns = (__u64)&insns;
> -	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
> +	attr.insn_cnt = ARRAY_SIZE(insns);
>  	attr.log_buf = (__u64)log;
>  	attr.log_size = sizeof(log);
>  	attr.log_level = log_level;
>  	attr.func_info = (__u64)funcs;
> -	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
> +	attr.func_info_cnt = ARRAY_SIZE(funcs);
>  	attr.func_info_rec_size = sizeof(*funcs);
>  	attr.core_relos = (__u64)relos;
> -	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
> +	attr.core_relo_cnt = ARRAY_SIZE(relos);
>  	attr.core_relo_rec_size = sizeof(*relos);
>  	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
>  	saved_errno = errno;
> -- 
> 2.32.0.3.g01195cf9f
> 

