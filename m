Return-Path: <linux-kselftest+bounces-14363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFC93F01F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BE71C21C4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D813D533;
	Mon, 29 Jul 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrtgL5qf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42112F375;
	Mon, 29 Jul 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242911; cv=none; b=IqfbCcQhTuqB6eO63f2OnX4B24IEsxVA9ZWPX2NlwgRPHb8hjMnMk1pdq9HuMHcsXmvirpd3Yvn8PFPeWqBTGAT9PcOOXI3VJoaQcQqP7HD7J38O3D2HhCmImvp38BrKxYQ/HqPeDc2o/U3vwX7Xt3qrkjX9EpTZ+kNP0AU5fOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242911; c=relaxed/simple;
	bh=HimJpWgYHlr50l9L5f8uYfgoa/FDDf9kVPtHcsbNQbA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs6oTna8bHJdnVbh3X79UC56AwAY6jeiECkUNFKNz9fgnKQ/DBpFVE267F6jEXKPSQDAxMAurCSs01UoXBKmWZ6OmSEm1xw4N9pl9TVA6OtFPZKJzodlo3wrTVebTEZDhUMfCq60Ciqz5QBYhUzmDPatWjUmOQdIZGJ2w0s1K/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrtgL5qf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc56fd4de1so16972335ad.0;
        Mon, 29 Jul 2024 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722242909; x=1722847709; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+V9bttpZfhfaFB3d1IzxKloWUu2oJW+Czq5f8hfGCcs=;
        b=GrtgL5qfLUtP5IeBRKcHjcPVByoY+ezqEuQpYmKLk++Eb09mIdoXcdkZh/DyE0ahgm
         BE480/M2IKDM8F3KWIHe+frtLsOlrY5fowbo2iacrV/QrKUKEqML+e9vE3n5YaeJMqMq
         fbHVU3c0QlxD2Nm1JKVvShzX85knULKOEtqfGvHFI5wEy/WCOaIHvWOmzL2Ksu4e9yvj
         SemakfDHhxBnch/Ie7HdzJ9qmSJ0eMvsnMBxuDUMu1YILbZEArSs/5P18Q6BPj4Y14wS
         OGE+xlZMGLdRuc9RE5hwMKyMlJd7W4OX1E8IuymHZj2BZQ+vUqvqdbKS9+289JrJ69mM
         XIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722242909; x=1722847709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+V9bttpZfhfaFB3d1IzxKloWUu2oJW+Czq5f8hfGCcs=;
        b=o8yqhjmILsPy8Vts3DC9zlj47+KEoD5qg/kvk41MK7+M8IO45K41SbZHqCvVFY5Zpp
         ktXqVb+cza8DPe92+U7LKk/FFywCHTknFveuHpVXYxzljSITe/pJkrMk3dw09ET+K5Bd
         eqVtb4u6VOVooi9IbugapCM79PNU/PFUJqJW26OyTaYNJbx9GJYzy2zq6kmMQp+sX0Kq
         jF+4ZVsTmkhxBB6vFF8vttbucRzypUvAe9rSAezvwf+IGkMzitYgaAyra/S0NiVhLaie
         NyU4jhNHaAAqyP1ZEheSJtTMI4sQNX27aHQXNeRHX3ixLutYAcL0SnkjBqbJinDpGp/u
         iFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC5vuZUiqPOkN2UHjX2RzIkMvJH/fhPqeEiHuuqydXUEczIR9Yv2Iz6WpQLQ6GpIOS4gzwolS58oUJdEbp+1cYLbkKwnCa42qeBgjxJ+2KL85ku1+kxHt5MA9c8OzaOyUhTLlZRLmV
X-Gm-Message-State: AOJu0YydAa3QBM/B5eOT1rsQkGj1DVL7e6uFjiA+I5/NIyKK5HBSpMie
	dk8beWgMtXX3QV5Zq2Z77gJdT1UTukza1/xItDlsUs9l9ar2K+Bv
X-Google-Smtp-Source: AGHT+IH2+XVsqFsmkc+t7Bnj96glbaxo8kfRP5fYWch6Yr1DlTjhbOGghhjfa28Z3j1/2sL6QGOgVw==
X-Received: by 2002:a17:903:41c3:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-1ff04a238bemr114033755ad.4.1722242908968;
        Mon, 29 Jul 2024 01:48:28 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fd6113sm77056665ad.283.2024.07.29.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:48:28 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 29 Jul 2024 01:48:26 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Fix using stdout, stderr
 as struct field names
Message-ID: <ZqdXWswv1oGYV/mN@kodidev-ubuntu>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
 <847a5b798f24e81b9dec4e8d9eb3eb1e602a909e.1721903630.git.tony.ambardar@gmail.com>
 <CAEf4BzauQQgWfc8eKsWF+Fr-j--oY6tJAM2+ZfAPHP7JJqZ6Zg@mail.gmail.com>
 <ZqR2DuHdBXPX/yx8@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqR2DuHdBXPX/yx8@kodidev-ubuntu>

On Fri, Jul 26, 2024 at 09:22:38PM -0700, Tony Ambardar wrote:
> On Thu, Jul 25, 2024 at 01:27:03PM -0700, Andrii Nakryiko wrote:
> > On Thu, Jul 25, 2024 at 3:39 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > >
> > > From: Tony Ambardar <tony.ambardar@gmail.com>
> > >
> > > Typically stdin, stdout, stderr are treated as reserved identifiers under
> > > ISO/ANSI C, and a libc implementation is free to define these as macros.
> > 
> > Ok, wow that. Do you have a pointer to where in the standard it is
> > said that stdin/stdout/stderr is some sort of reserved identifier that
> > can't be used as a field name?
> > 
> 
> I'll need to dig around to share some references. The short answer IIRC
> is there's enough potential variation in their definitions that their
> use requires care (or better avoidance).
> 

Hi Andrii,

Following up on your request for pointers, some excerpts from a quasi-draft
C17 ISO doc located here:
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf


7.1.2 Standard headers
	(2) The standard headers are ... <stdio.h> ...
	(5) Any definition of an object-like macro ... shall expand to
	code that is fully protected by parentheses ...

7.1.3 Reserved identifiers
	(1) ... Each macro name in any of the following subclauses ...
	is reserved for use as specified if any of its associated headers
	is included ...

7.21.1 Input/output <stdio.h>, Introduction
	(1) The header <stdio.h> defines several macros ...
	(3) The macros are ... stderr stdin stdout which are expressions
	of type "pointer to FILE" ...

7.21.5.4 The freopen function
	(2) (Footnote 278) The primary use of the freopen function is to
	change the file associated with a standard text stream (stderr,
	stdin, or stdout), as those identifiers need not be modifiable
	lvalues ...


So we have reserved idents (IANALL so not sure of field names), macros,
parentheses, and potentially unassignable stdout/stderr that might break
the output redirection hack in test_progs.c. More than enough to tread
carefully I think... 

Cheers,
Tony

