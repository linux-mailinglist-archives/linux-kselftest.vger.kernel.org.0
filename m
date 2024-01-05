Return-Path: <linux-kselftest+bounces-2663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6E582566F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F5E284E2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674A2E630;
	Fri,  5 Jan 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3HCkHom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059C2E412;
	Fri,  5 Jan 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a277339dcf4so180602066b.2;
        Fri, 05 Jan 2024 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704467949; x=1705072749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXM8mUu2b7I5NINWgE1xN7lsAgN9ikjmrQenDxvMoYo=;
        b=O3HCkHomOHx8BjYuyfNNLHLohiIwPf6SmH3GXrIc9m2ps9ZmttX5NWBL/d9ZNmlg2q
         e9UvXEjOJlOItiWWVCevxZbK8YYfmECGTRgqdJUvtIqXPL/zv6AgjZIPKrfb6ZmU5E1g
         KFcGTPVhrBmS6kcsb2ks1nFmcvQoSpDnIVB+2MLinb8iMWB0TnZFXUn2+SxMnWMSTszZ
         KSXUd+aFZYw8GUwJiONOPmFUAHcjMoCnLxMUBn6t+aQBcXp7wwkMXxDwrHQNnQLHYYLq
         karFE6IClx/cFi32qKrn+fuOOKTR0le2FR8/al+S9AlCTdSOGZOEYiGrNA1kOOcjAK/T
         jzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704467949; x=1705072749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXM8mUu2b7I5NINWgE1xN7lsAgN9ikjmrQenDxvMoYo=;
        b=HVloNXSBjMObJEcZhV9REzOWPgUVXT8gQSUeTZaWS/zzfPkkSo+zmyxxzFKP0B5qX/
         v0OmkdKtJ/BijoLdEjrdqjTkL3HPAJxaqR+fU4CGHvvvLQe0/KlIFTgmbmZW0rnFdVE5
         7FNmZnk7arSk4SOQOzLcR4vROOtT9pkUO9U8klXVE9iWluwMwtK67Yqb4xuEJ8+secVX
         ScIh5PX3qAn5Uq16hkpli7u+0IkdPXCWVGSAQ4e21S6pKE72Wat70bBRRwdEIlwCbHoe
         LJg0v5NYPIzQQC4gwPeWq4abYCQIiu74V0uuOyWYpgu+krDLcsfhoB96kFMSjUpB4TDD
         FTuw==
X-Gm-Message-State: AOJu0YzNN3d/AeoGT0ESSkM6a5Sa++NtfrAmOzVJR1emDr24P427p6eq
	8hclxVV7LhBioDSLQO7P2ibE4XEDf11ZwA==
X-Google-Smtp-Source: AGHT+IHMylC1f/uOwiPnE54XyvPyUNJflvpVz3FB0ZLbHNPVoLKw4ML5AEQ2yE/zVzZzRQJG9qQEHw==
X-Received: by 2002:a17:906:6a82:b0:a23:4c5d:dab4 with SMTP id p2-20020a1709066a8200b00a234c5ddab4mr1164549ejr.62.1704467948901;
        Fri, 05 Jan 2024 07:19:08 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id mj20-20020a170906af9400b00a27a7fa8691sm979246ejb.137.2024.01.05.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:19:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jan 2024 16:19:06 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, cgroups@vger.kernel.org,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <ZZgd6vOhpLcZmYp5@krava>
References: <cover.1704422454.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704422454.git.dxu@dxuuu.xyz>

On Thu, Jan 04, 2024 at 07:45:46PM -0700, Daniel Xu wrote:
> === Description ===
> 
> This is a bpf-treewide change that annotates all kfuncs as such inside
> .BTF_ids. This annotation eventually allows us to automatically generate
> kfunc prototypes from bpftool.
> 
> We store this metadata inside a yet-unused flags field inside struct
> btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> 
> More details about the full chain of events are available in commit 3's
> description.
> 
> The accompanying pahole changes (still needs some cleanup) can be viewed
> here on this "frozen" branch [0].
> 
> [0]: https://github.com/danobi/pahole/tree/kfunc_btf-mailed

great, lgtm.. seems I've got the tags in right places (128 kfuncs)

please send it on the list once you're done with that, so we could
comment on that

thanks,
jirka

> 
> === Changelog ===
> 
> Changes from v1:
> * Move WARN_ON() up a call level
> * Also return error when kfunc set is not properly tagged
> * Use BTF_KFUNCS_START/END instead of flags
> * Rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS
> 
> Daniel Xu (3):
>   bpf: btf: Support flags for BTF_SET8 sets
>   bpf: btf: Add BTF_KFUNCS_START/END macro pair
>   bpf: treewide: Annotate BPF kfuncs in BTF
> 
>  drivers/hid/bpf/hid_bpf_dispatch.c            |  8 +++----
>  fs/verity/measure.c                           |  4 ++--
>  include/linux/btf_ids.h                       | 21 +++++++++++++++----
>  kernel/bpf/btf.c                              |  4 ++++
>  kernel/bpf/cpumask.c                          |  4 ++--
>  kernel/bpf/helpers.c                          |  8 +++----
>  kernel/bpf/map_iter.c                         |  4 ++--
>  kernel/cgroup/rstat.c                         |  4 ++--
>  kernel/trace/bpf_trace.c                      |  8 +++----
>  net/bpf/test_run.c                            |  8 +++----
>  net/core/filter.c                             | 16 +++++++-------
>  net/core/xdp.c                                |  4 ++--
>  net/ipv4/bpf_tcp_ca.c                         |  4 ++--
>  net/ipv4/fou_bpf.c                            |  4 ++--
>  net/ipv4/tcp_bbr.c                            |  4 ++--
>  net/ipv4/tcp_cubic.c                          |  4 ++--
>  net/ipv4/tcp_dctcp.c                          |  4 ++--
>  net/netfilter/nf_conntrack_bpf.c              |  4 ++--
>  net/netfilter/nf_nat_bpf.c                    |  4 ++--
>  net/xfrm/xfrm_interface_bpf.c                 |  4 ++--
>  net/xfrm/xfrm_state_bpf.c                     |  4 ++--
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 +++----
>  22 files changed, 77 insertions(+), 60 deletions(-)
> 
> -- 
> 2.42.1
> 

