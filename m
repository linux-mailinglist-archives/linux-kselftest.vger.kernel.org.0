Return-Path: <linux-kselftest+bounces-7300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD989A214
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5C91F23D01
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A0D171087;
	Fri,  5 Apr 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfgX9mWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A0171069;
	Fri,  5 Apr 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333248; cv=none; b=l+tzgcDuD+Cm8HJ2CiFzLpC1u93Ir39qK6E9Icqq6Ov6SQ+bBgJ69X/sx9Jz6qEd+HhQMIdJtyHw9Wh5hwB8zYlYeqh6ztXFYAsW21K9hQBIZhDIiThYpExe+nSRnUFaKQb75RTdvTjtlnTF30ycuDuVKPxgUtgO13naRZG/tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333248; c=relaxed/simple;
	bh=/n6EdmNiAaj7jJ9fb7jZrjiJ9kgHzGDjzSEonMO8iBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwiKPkhAM1Oa144eyNRf2oLWfZjjeIQnMGSDOBmrGVBUhmWD5D+4jH0MXJjjcr1X/ppY/F07sTW56Zq/QUIyU4cjcqTPkDfmsNTtjst6LFrz3qIqZJzk7Lj6rRVcJ8wHU4/ur+XQYfrmjSTTVyOMQShORS1ViLDZF11v7M8M7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfgX9mWr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4162b0e21b0so12292965e9.0;
        Fri, 05 Apr 2024 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333245; x=1712938045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n6EdmNiAaj7jJ9fb7jZrjiJ9kgHzGDjzSEonMO8iBs=;
        b=RfgX9mWr43Y+3XZRcFnHgI14j9KrKgoCF7tr7tCVdIB22tu95THyy6aJRO4/JKlWOW
         XQbnGdqQoG+O76jjqxmvtvuPy8fHFYcsGw6eHdUn+9b9Z+VfAUNF8DZT+Ws4xJeqCVKL
         xUR/DymovD9h2Ji9dxE5BHFW64Za87PfHppv0UJ5u89RE8EgvhlnIz/YNKKxe4Y1gqRR
         9fSWFh6ldWz2nkvjJWndojYUi+8tSX+nIUKXLuFYODIMDUT6uvkXZsn0NNAuv7DjqWNl
         seGewuzpUfjcIscpYNIw/bWDz9l0yxzPCmC4FowuTrkFS2D2iPlA6cH7dOOsyiHXewBB
         KvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333245; x=1712938045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/n6EdmNiAaj7jJ9fb7jZrjiJ9kgHzGDjzSEonMO8iBs=;
        b=Z85b82U+wwYSKx7HAQO/dQal3ma9IvxtcnhYjtJLLe0VGrTU0xbWIZGDKBm5LDEf+H
         y1w7yhf4VwGE8TwE4gQUMVVJwHMrHWt+Sof2mx9Idg8jWE6QbAnYlXm11rJ8pHTpRulB
         jCOEgr5+HhP7qOXchzc2ohAODvnXGSe+C3RrrhvBJaUkKp8w+ktsaT4/wo9brblZukTX
         JXDOFOH/u2NJACmkyJ+Ow1SXQV7uXyzT94VL5tMJSFlKeNyMA/nsEMnVNts8oGE4a1oo
         Vxt1jxtgUgY+KkO25fwBaRsm1EqjuEQ9eHce/LNA6zTXbhTPSP3gWFfKH8K5CoHUyQUp
         wFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeolWJhwdl1wXc9aJpc9cYVmiAXVKCJ0xqZfldgMfiucU8vGal3KMrOmGg73vSE2JoJjV6jXZ93sghwgtm5oH7vBAD048PCsGeqxjItiERTYxU52vyZj64K9tnAKQnOG9KXdUKTy9ayP6CRANXr8SDIdNQITqeEgb7CzJiZ8pFXvAX
X-Gm-Message-State: AOJu0YzrZ6i6bKbRCIkZAIq2CaAD5OXk+GY3d25ZbYkJNrrW7pG2GOR5
	bQ3P4UGtVEpuRIp/3h/R5dPr2s/p/idneS8BftBhE5LZ02eT/JMui02IKwajfvOS4qMvKJdWd2v
	eX9LP2IlLR043wS7j+g0+LakzfiE=
X-Google-Smtp-Source: AGHT+IHJa17c/UAjDpaaM4OZ/aa58GujEn4FPNnYug7DLSdv/Q08eVXaiGF1njm/Xbdk+2JyNPc9peKruPCsUnY/uQw=
X-Received: by 2002:a5d:6184:0:b0:343:e45c:c91d with SMTP id
 j4-20020a5d6184000000b00343e45cc91dmr1422867wru.41.1712333245021; Fri, 05 Apr
 2024 09:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
 <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
 <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
 <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com>
 <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com>
 <CAADnVQ+gikPakTuYpD4-oxS6yS5-Dd_HanfqyNnGW-nk7=eXNg@mail.gmail.com>
 <CAO-hwJLz4ET8Rba-_8icR+7t9T63BPnf97JrSFjviJWG+i8dVQ@mail.gmail.com>
 <CAADnVQ+MSqf1=FesorSxT63Qh83+4W79HX3HDyOWupajk_rTHg@mail.gmail.com> <CAO-hwJJmb3f7y39YqFrt9K0rUdab8ERvA9sU3kNz1qUj7_=BfA@mail.gmail.com>
In-Reply-To: <CAO-hwJJmb3f7y39YqFrt9K0rUdab8ERvA9sU3kNz1qUj7_=BfA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Apr 2024 09:07:13 -0700
Message-ID: <CAADnVQLxKuTDKhN4R_LVnXpO8oS6AWNhQpExtV9+P66giHq=UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:46=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Alright, as of today (and I'm about to be AFK for the weekend), I got
> your changes in and working (I think). I'll review the series on
> Monday and send it back so we have a baseline to compare it to with
> bpf_wq.

Nice! Looking forward to it.

