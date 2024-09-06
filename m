Return-Path: <linux-kselftest+bounces-17425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF196FCDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB1C288678
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECDB1D5CDB;
	Fri,  6 Sep 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAj0G6Um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478E1B85F3;
	Fri,  6 Sep 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655589; cv=none; b=GrY5lFonkCeaeGDFup3L8lt6NPwyvsaAOouau5kMMVuss0PNfiJju96JbPyxJqry2l6pIeG5klwGO7n+nPpiZlfS8rMvrOEa2qZmGzudXIzzlPq05RpjT8shw/ygL9at314v/Rk6cNgcHEJnQmF7aq68OsNPaJUho8f1L2GR4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655589; c=relaxed/simple;
	bh=ja20IrBAw3wYn8GHefIkv6XWxhhlzm76ReH7NEp9qq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqGaRdfVWp/NsZ2IpzTJgJiqBGhTo7MTzTjhUyJTUzGLPxRpbLif9aJ9DpJWMgHzXx0b38J/2VbnJPI1Z8QL2vm3MqYr+/um3twYCqrBOFkiW4Z39UjsgljQh9zCTzZtNPAgY/cCCyoe1+naDN5k9Oo7e36VsXTsAP9z2z/hBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAj0G6Um; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2057c6c57b5so13966985ad.1;
        Fri, 06 Sep 2024 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725655586; x=1726260386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DulQxFyxfC3V3sFFbk29/KbmlwOujuVzihqTTa8u0/o=;
        b=QAj0G6UmBcPbRvJrO3ucJDzL0XsI6qqlZngGyqoYI6dOLk96/hP0hZNRnahnwLjXhy
         t/xbPATarYX94UzLVNqSu3b30EzMyECsTkEUVZ3coBnFpRVgtZ3qUHkYbv2ORQvFrB8e
         4a9j1n2Ck7sFfehk5arXjapSCkm7VyjGg85XzTCSj7Oa0u7vYoHfE1dLvpTdaFy7yvDX
         YPZVq4SsCacWicR6xcYueRXmRpMEd7ynoBc27Y2R7SB1ZVeVX9EuA0KGmDGBtWTebroU
         25wUV81iqnpwcYbr8rq8QAM5M3356XHLEIhJ6DShlrPHG4KpjOHeVNpPkudQwPAlrLv4
         EGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725655586; x=1726260386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DulQxFyxfC3V3sFFbk29/KbmlwOujuVzihqTTa8u0/o=;
        b=iYlj4yjeCqKhxdhzIR/r2mDyMnKu1C9DbOabLnTfDQoQiuB7WFLu6rirrcycZSiTTr
         tnXfd5yKQqAVooc42ABo+6Zc9anKz0xfUx6MvxWsGwjO7QLR7I5fy2GFEGRqY0++/nXa
         bjIDB/UEfK9wwylnPLXlcrt+6e5FitOkIC/o0sdjpYksxZl+mpoqKfbcXYLH7ygMfS8c
         dqPHz/A3ahcwyNqPYXVHPoiT6W+F1jNmCC714aimoHuG10XJs7gC5L3I9sXSljk/BlU3
         MM3Ifmk/rAfRyo6g6FV5rZCjpQ7DPg3+UKjC6mQqbMYE2ReBRvZNqpz1PmOtrC9kgEEw
         yR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNCPq7qJoniEBFxKtlTfZMHB0kKaLIYeJUcLRMuySfZBioGlOaJofpnh3r/qrD7yDalymJOsRDT+XZDjQT0B+A@vger.kernel.org, AJvYcCWGdEuyN5nl5UbL+DhPbeNGuj4a80HGD5KXnSDTFEU3tki+Vm88DJwhhFpbGgkhN6bXiESqw3ne1iH6B6HP@vger.kernel.org, AJvYcCWdd/LD36Osv3Lu7duR6jLZLu85RIHHA1MtUCpk1i1oGSMj0qI32g6+uj2/69c/Ar3vo/A=@vger.kernel.org, AJvYcCX3hmwJbLgoZKmr4D5yms1N2DVqQSiJiUPWr8UKdph9sYeqwiBJifLs9fb9LjQjmRgKqpIuDJSh@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKj52s3L2ncYloIFLvG5ca+BZfopSDBKE4nc0Vik+gdS3U9rA
	A/XFlBtVQlaR4o9lj02dYpTrNsD6PGPtdd3M/iyHvMnG+Vzvp4A=
X-Google-Smtp-Source: AGHT+IFQpuM49e1iBf57WiEpqEBxgYLXbGA/ZzUPlBLIxHFa3kHJf1EunmqPzy8aNkh/KlbiWT/eoA==
X-Received: by 2002:a17:902:cec9:b0:206:8915:1c74 with SMTP id d9443c01a7336-206b840d063mr161651675ad.21.1725655585724;
        Fri, 06 Sep 2024 13:46:25 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea66598sm46873765ad.250.2024.09.06.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:46:25 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:46:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] bpf: selftests: send packet to devmap
 redirect XDP
Message-ID: <ZttqIOKR9Khhw0H7@mini-arch>
References: <20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de>
 <20240906-devel-koalo-fix-ingress-ifindex-v2-2-4caa12c644b4@linutronix.de>
 <Zttk_hTqQ-1wFTtI@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zttk_hTqQ-1wFTtI@mini-arch>

On 09/06, Stanislav Fomichev wrote:
> On 09/06, Florian Kauer wrote:
> > The current xdp_devmap_attach test attaches a program
> > that redirects to another program via devmap.
> > 
> > It is, however, never executed, so do that to catch
> > any bugs that might occur during execution.
> > 
> > Also, execute the same for a veth pair so that we
> > also cover the non-generic path.
> > 
> > Warning: Running this without the bugfix in this series
> > will likely crash your system.
> > 
> > Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> > ---
> >  .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
> >  1 file changed, 108 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> > index ce6812558287..c9034f8ae63b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> > @@ -1,6 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <arpa/inet.h>
> >  #include <uapi/linux/bpf.h>
> >  #include <linux/if_link.h>
> > +#include <network_helpers.h>
> > +#include <net/if.h>
> >  #include <test_progs.h>
> >  
> >  #include "test_xdp_devmap_helpers.skel.h"
> > @@ -17,7 +20,7 @@ static void test_xdp_with_devmap_helpers(void)
> >  		.ifindex = IFINDEX_LO,
> >  	};
> >  	__u32 len = sizeof(info);
> > -	int err, dm_fd, map_fd;
> > +	int err, dm_fd, dm_fd_redir, map_fd;
> >  	__u32 idx = 0;
> >  
> >  
> > @@ -25,14 +28,11 @@ static void test_xdp_with_devmap_helpers(void)
> >  	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
> >  		return;
> >  
> > -	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> > -	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
> > +	dm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
> > +	err = bpf_xdp_attach(IFINDEX_LO, dm_fd_redir, XDP_FLAGS_SKB_MODE, NULL);
> >  	if (!ASSERT_OK(err, "Generic attach of program with 8-byte devmap"))
> >  		goto out_close;
> >  
> > -	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> > -	ASSERT_OK(err, "XDP program detach");
> > -
> >  	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
> >  	map_fd = bpf_map__fd(skel->maps.dm_ports);
> >  	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
> > @@ -47,6 +47,23 @@ static void test_xdp_with_devmap_helpers(void)
> >  	ASSERT_OK(err, "Read devmap entry");
> >  	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
> >  
> > +	/* send a packet to trigger any potential bugs in there */
> > +	char data[10] = {};
> > +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > +			    .data_in = &data,
> > +			    .data_size_in = 10,
> > +			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
> > +			    .repeat = 1,
> > +		);
> > +	err = bpf_prog_test_run_opts(dm_fd_redir, &opts);
> > +	ASSERT_OK(err, "XDP test run");
> > +
> > +	/* wait for the packets to be flushed */
> > +	kern_sync_rcu();
> > +
> > +	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> > +	ASSERT_OK(err, "XDP program detach");
> > +
> >  	/* can not attach BPF_XDP_DEVMAP program to a device */
> >  	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
> >  	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_DEVMAP program"))
> > @@ -124,6 +141,88 @@ static void test_xdp_with_devmap_frags_helpers(void)
> >  	test_xdp_with_devmap_frags_helpers__destroy(skel);
> >  }
> >  
> > +static void test_xdp_with_devmap_helpers_veth(void)
> > +{
> > +	struct test_xdp_with_devmap_helpers *skel;
> 
> skel needs to be initialized to NULL ....
> 
> > +	struct bpf_prog_info info = {};
> > +	struct bpf_devmap_val val = {};
> > +	struct nstoken *nstoken = NULL;
> > +	__u32 len = sizeof(info);
> > +	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
> > +	__u32 idx = 0;
> > +
> > +	SYS(out_close, "ip netns add testns");
> > +	nstoken = open_netns("testns");
> > +	if (!ASSERT_OK_PTR(nstoken, "setns"))
> > +		goto out_close;
> 
> ... for this goto to not do test_xdp_with_devmap_helpers__destroy(garbage)
> 
> pw-bot: cr

Ignore everything below and sorry for the spam.
(NIPA doesn't like DKIM on my sdf@fomichev.me, let's see whether it
works from plain gmail.com)

pw-bot: cr

