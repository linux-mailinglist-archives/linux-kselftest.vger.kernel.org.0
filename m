Return-Path: <linux-kselftest+bounces-2944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95582CCE0
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 14:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3983F1C214A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A9E2134F;
	Sat, 13 Jan 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEZlhzbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07821113;
	Sat, 13 Jan 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so384528266b.0;
        Sat, 13 Jan 2024 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705154263; x=1705759063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGE1HEJ5ixxTvOXVNxbbYY7sOdvQr1NpAqO6gUYLh08=;
        b=aEZlhzbuh4VFbItmMYKxfYHzvAwezxQ72V8VbwSa3g2pnsRc0mi1xrF0c2AznuUXwc
         BJokau6Tlj72I3E3GC3GeRuNsGi2elNDjWnjAwhxUnub0gGGsmIV8RptUwm9DS4198b+
         9bcTkY0oNaQOiKshEmC8vbw1maBpVjdNlYIO7jdlpzn+1rX/qpSDtPm5VBUXihACvvCI
         igCjIlJMp6gtdIpmOqnwP03yP+op1I3/KfFOj6HiKZJouw0ejX1F/mpHaO7EVW0zoyFN
         Bt08xk92AtZrM3fpJ22N4PoVCTMewA352nCZUZzqlf7bBAw80c3vt0pccG0YogCLefAX
         8mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705154263; x=1705759063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGE1HEJ5ixxTvOXVNxbbYY7sOdvQr1NpAqO6gUYLh08=;
        b=AjXDxe0byr1rZ/QgUCURCH6+r/gh6ngdPXDwWBsTXr62OMj+epLO7uNCpk+tDLxkkL
         4EfM103SAJBUUZBr3Kszbu/zMYTZPvYNUL3bFZ/FVzlPoD0nzU1tGa1xRY1Yi6xIw/bD
         UXZtqw3EyiIm14h2jJZjdnZxIruGvPaybM+Yepqbkn1ma2EluHA3LMwEgUWbfEDEAJ2L
         t06RyN2MIafbSwIH8RH33Uaq6acT1zKJOdl/8X9qHqWOcvH7BHvbqK2uiretTDqfvb5k
         Tj3k/u1sQv277L0BUla4I2Kii1s4U30C3U1WOZMunvZAnwQaCifQ3mJ++DGxAmFLzGmN
         WBKA==
X-Gm-Message-State: AOJu0YzAXUKt422fjnYSnVLlWKTkkrdkxmTZh8fpUq4MUl1O7Cr7mFYG
	sar8Mo4oLEOvDWf8REg5gl4=
X-Google-Smtp-Source: AGHT+IFMOIYDYiCqRWjRhgVi6B2d5peHDNTF2jXuwvHB8FKts87L7ld0sC7DRk8qiddMgjxRgmPzDw==
X-Received: by 2002:a17:906:15c3:b0:a2b:1a80:7b72 with SMTP id l3-20020a17090615c300b00a2b1a807b72mr1514786ejd.30.1705154262796;
        Sat, 13 Jan 2024 05:57:42 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906150400b00a2a37f63216sm2950887ejd.171.2024.01.13.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 05:57:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 Jan 2024 14:57:40 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-input@vger.kernel.org,
	coreteam@netfilter.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	fsverity@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	cgroups@vger.kernel.org, alexei.starovoitov@gmail.com,
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <ZaKW1AghwUnVz_c4@krava>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
 <ZaFm13GyXUukcnkm@krava>
 <2dhmwvfnnqnlrui2qcr5fob54gdsuse5caievct42trvvia6qe@p24nymz3uttv>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dhmwvfnnqnlrui2qcr5fob54gdsuse5caievct42trvvia6qe@p24nymz3uttv>

On Fri, Jan 12, 2024 at 01:03:59PM -0700, Daniel Xu wrote:
> On Fri, Jan 12, 2024 at 05:20:39PM +0100, Jiri Olsa wrote:
> > On Sat, Jan 06, 2024 at 11:24:07AM -0700, Daniel Xu wrote:
> > > === Description ===
> > > 
> > > This is a bpf-treewide change that annotates all kfuncs as such inside
> > > .BTF_ids. This annotation eventually allows us to automatically generate
> > > kfunc prototypes from bpftool.
> > > 
> > > We store this metadata inside a yet-unused flags field inside struct
> > > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> > > 
> > > More details about the full chain of events are available in commit 3's
> > > description.
> > > 
> > > The accompanying pahole changes (still needs some cleanup) can be viewed
> > > here on this "frozen" branch [0].
> > 
> > so the plan is to have bpftool support to generate header file
> > with detected kfuncs?
> 
> Yep, that's the major use case. But I see other use cases as well like

ok, any chance you could already include it in the patchset?
would be a great way to test this.. maybe we could change
selftests to use that

thanks,
jirka


> precision probing of kfuncs. Rather than guess and check which progs can
> load (in the event of backwards incompatible kfunc changes), programs
> can look at kfunc type signature thru BTF.

