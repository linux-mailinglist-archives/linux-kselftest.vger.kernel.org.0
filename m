Return-Path: <linux-kselftest+bounces-18215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AC97EA74
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 13:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC24DB20C3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141319882B;
	Mon, 23 Sep 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv+rwdHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F45197A77;
	Mon, 23 Sep 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089633; cv=none; b=Rh0skgFbJwY1sxaqKz1Z8Wofm5YfGKFbJoXW5/osLP70QZC6NCF3Q5xIC6M/URjri/Ufwe0m+Gsr2WxkKsuJHE4UHKtrCDLXiK6syK+Wd8k3j0tnf45i657bz7EBc1jTwH89+DrmShBYcT/4BDT+QkydhfaX/Wql3GssWqFHuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089633; c=relaxed/simple;
	bh=uQqTX8MOzbotyLLLrtDqctrYuNvqiUuv18STkugV78c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Z3J5p1VFZePaLiHt4N5KeG0ODp9b7nijx6lhderuIJL67YvRcQtipmNECa3vz4AtXwanw7q6bMh7gYaziYvZE9PE7ECCxpVyvBSchKazPUlOjxSkphYivl3anj70Uf+rNCj+M4/ANj34kwt1h3H6jZ3MKcrnaq9/lQm6KVLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv+rwdHq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso42035175e9.0;
        Mon, 23 Sep 2024 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089630; x=1727694430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3geJL7ixz4Bia+Km87KjRXCdEiy3BgJRZYEhH0JnWs=;
        b=lv+rwdHquZOJdvGJlgrRGswp7yiLhIK7ciXBZkW/8n45NciYSxIXK5heNL/ibgFOy8
         ZbERRwCWlul61hG6fiGI9CutYxH8Mfq5Nl4ud0xqqO5t7fOpzP//3/zTYUD8jjYekAnV
         xXYd9zADeBg9ZkA21dKIBf5H3BZem5sQv8ZuaUBLnVPd5iwz6h4GsLakzCl3xbNY772B
         AIfwylhcVPXq77OLvOQf1Jllwgopk56awRPzORdXR2mtr4yVx63UECHdNwAWxx6S675C
         LthORiXJlI1ah4KEwCCOyoPneDPVsxCtT3tBjmDQazUjPBStLhbVbf5jpH/w4xYTsn9V
         ry5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089630; x=1727694430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3geJL7ixz4Bia+Km87KjRXCdEiy3BgJRZYEhH0JnWs=;
        b=VqXjTalPf/ZkV/AN16jBWmDMJ6gxU2+lslWZNq460Sy5JxwZUcaj+7IBdYs53K+F3W
         GBlBJ4ckY8rjINAbV4bKhGW7Cg0s5f49aITwfSce+k9Bq8R2rOneXvbXydRGbGVZ0GDG
         R2ZmyvmOIUuwoTlKvSLSh5Y8shbz4FTP84aFS9SWhow4iog8d5rEE+Lgc/BnhMJPtwif
         PeImvSeOktcZcTwba84MWt0OQcck77BqKwbR8bQ1GJPb79CVHZNRtdWGCmU0iy3MxXeu
         tzav2Q4IdF26oGTA2F+NyEFkzNdHZqwplGzavFD3UkzpD5zfLq5eoDJeDYbiMQJuZRtg
         +Lrg==
X-Forwarded-Encrypted: i=1; AJvYcCX97VAzouqidaBOw/WcNYSkpcgPwWyOMqXnGUkwHcGCMDRSIAOylbnhIcDl8wXDKK06+WgnW8qWfHmwNVk1NeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9UCv6rY1h6oZyBUf3BraUCOtEx9S19pzDSuRjMwcO1byJetR
	HVc4icnteTM6BYCt3VmaPJrGU3NihVghJV0joxru9GZgr1xEZeNj
X-Google-Smtp-Source: AGHT+IHg07MeygA6nqV6/Z+8rt5L7mI/nXsru41UUFH2Mg0UopscBeAQ7xb3ZPGp3/ch6UmIzEtJJw==
X-Received: by 2002:a05:600c:358b:b0:42c:b377:3f76 with SMTP id 5b1f17b1804b1-42e7c16ec9dmr88999175e9.17.1727089629839;
        Mon, 23 Sep 2024 04:07:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ac7d315sm98942635e9.0.2024.09.23.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:07:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Sep 2024 13:07:07 +0200
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v1 0/3] Improve .BTF_ids patching and alignment
Message-ID: <ZvFL2_qf3m6jcnqu@krava>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726806756.git.tony.ambardar@gmail.com>

On Fri, Sep 20, 2024 at 12:49:10AM -0700, Tony Ambardar wrote:
> Hello all,
> 
> This patch series offers improvements to the way .BTF_ids section data is
> created and later patched by resolve_btfids.
> 
> Patch #1 simplifies the byte-order translation in resolve_btfids while
> making it more resilient to future .BTF_ids encoding updates.
> 
> Patch #2 makes sure all BTF ID data is 4-byte aligned, and not only the
> .BTF_ids used for vmlinux.
> 
> Patch #3 syncs the above changes in btf_ids.h to tools/include, obviating
> a previous alignment fix in selftests/bpf.
> 
> Feedback and suggestions are welcome!
> 
> Best regards,
> Tony

nice, thanks for the fix

Jean-Philippe, Viktor,
any chance you could check/test this patchset? it changes your recent
cross building fixes

thanks,
jirka

> 
> 
> Tony Ambardar (3):
>   tools/resolve_btfids: Simplify handling cross-endian compilation
>   bpf: btf: Ensure natural alignment of .BTF_ids section
>   tools/bpf, selftests/bpf : Sync btf_ids.h to tools
> 
>  include/linux/btf_ids.h                       |  1 +
>  tools/bpf/resolve_btfids/main.c               | 60 +++++---------
>  tools/include/linux/btf_ids.h                 | 80 +++++++++++++++++--
>  .../selftests/bpf/prog_tests/resolve_btfids.c |  6 --
>  4 files changed, 97 insertions(+), 50 deletions(-)
> 
> -- 
> 2.34.1
> 

