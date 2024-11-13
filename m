Return-Path: <linux-kselftest+bounces-21961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E159C7A44
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82AC1F23180
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA92022D9;
	Wed, 13 Nov 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UduD5eqB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4C1494DD;
	Wed, 13 Nov 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520244; cv=none; b=bw8BMOXP50JbkbKUmvOMuTHEq58MznlspaZwyETybnYzaBAkhVM8vCUviyHYWxbxyxbT9k08phlvqGNZPPsM6bTw5KQhaL3aH//QKBei31nmeffAzAam1VHeZY+JNDPhYXM4g93M7bpUH6VpuTWN7+k/supLSiPXpVBKv5QgbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520244; c=relaxed/simple;
	bh=uiKubqfzMx2s2ufqjwwokbGZLNA7OAammJ1+n+A7QOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4wEheLwopjldi5SVqvweDTOA9fRoG9l/m/i6kjyt7MiA9cGUy0MAgm1lJDi4o0PBd+lkJ6iC1WkWuUu6/ogqg0UywRVySWQKGujKH6F3IXZMv2brEYiFCuiCIziWLlC1J3jeNvrpQbupr1enwM/96xDgv+epsqlEyFf+Up2Kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UduD5eqB; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27b7a1480bdso3045797fac.2;
        Wed, 13 Nov 2024 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731520242; x=1732125042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YASkwPLR6DW5p2wms4wC0dIzAVnPt7gYAm9iZK3s/7I=;
        b=UduD5eqBeJ+6baCuhkC8BRTmJNiyyE+qomPUYNFGxR4zeKQXFVedoumV58k+Lijex5
         qJeRdlkO/MEbxZ3EfXcVjIX4c83jSVGZ0rwbc3cfzSEOTgZIeYFHBpby5UDNh4zbIee+
         rmH5Esn87gYOVmD9OYWNORakKCr7/1xk8KR9FTnAvAWayOCmbY0lSBp9gX9Jp3HVhnBn
         XNKgiE6zuzxHcMh0j5Wl6rUt4QXbY0s5JHUlKkTuB2ssmSo5OWNZo5fNLmca0n0KexR3
         i+Tk5JOOwkuHME0DzRv8y9xKqzdtXnYqP0g4e67hnETrGLxw7XGxiBKIv+D9BI5PL4Ty
         THVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520242; x=1732125042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YASkwPLR6DW5p2wms4wC0dIzAVnPt7gYAm9iZK3s/7I=;
        b=q3CSWkRvNxtRh88sZkWkh4Uf1wquFpPTTkPqT0Y+M/gXN9KXiKm1hk4hbY8PEcQkVe
         UtGXrmdCbKUgFfEx5Gg+A6574klHQF6/S8fdNLOYqLulQfypAowwflaAU9cuFbGGBpWt
         juZOoTySA+iieviFI53opu2b+uESVUqBcysl+xNMo1+juea2K8PDkte1tf6KBoA0SeM3
         tgr0gLH94dMsE+VBi0TiMH3oztF6js79jr7jGvv+HlWG3L15JYc5r7q2i0F6n84PwJ0i
         64JNtrH+2ZtICuF85+uk7U+MHDMY5uk6F7sw2Prh/FZBE93RfBWTd8bYzpL3yWf/Vwzu
         w8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNiYowKewwyL+vX2tZGE/xHRFpO+DxHOfhArtuZWj0LsQmU7lNQFsKQwP0loj9A261vm4=@vger.kernel.org, AJvYcCUhqj53Yc8m2dOoW7+j+r5XwGMN4Y/NHP2J5NsUDLbJWUmYgp4pjtCwBmQo3xaAyG5NRCD4D90ztVHszXxnPtZk@vger.kernel.org, AJvYcCWQ5JikswZMc/a8//Q/E/AjEszvkhEv5BXGsnlUT0qC81rUmged1znq+AyMoINxhZZocf3p86UYFGFlfcf6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsj/wBJpw0dX58ZLPUtHtmMYvU/dqNTzxHM0gq9OdtF7fqORnm
	iuepqe5OKFWiqfazx+3Fg375OVI/T4wMxNpZ0pyJlHQOKvkWE5g=
X-Google-Smtp-Source: AGHT+IEF01O6Epfp5F3V8NpoD+BiSaq7bs1bUg4f5F/1e1isXwK/aJccWC+w6jieFf72m8LLen0VTA==
X-Received: by 2002:a05:6870:3310:b0:287:32f7:ef42 with SMTP id 586e51a60fabf-295e8d51845mr3982170fac.16.1731520240475;
        Wed, 13 Nov 2024 09:50:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643e9asm12674863a12.59.2024.11.13.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:50:40 -0800 (PST)
Date: Wed, 13 Nov 2024 09:50:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 07/10] selftests/bpf: migrate flow_dissector
 namespace exclusivity test
Message-ID: <ZzTm7wKsOLuI5w20@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-7-27c4df0592dc@bootlin.com>
 <4f68d104-b96d-4726-a94d-1123765393c6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f68d104-b96d-4726-a94d-1123765393c6@bootlin.com>

On 11/13, Alexis Lothoré wrote:
> On 11/13/24 14:53, Alexis Lothoré (eBPF Foundation) wrote:
> 
> [...]
> 
> > +	ns = open_netns(TEST_NS);
> > +	bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
> > +	close_netns(ns);
> 
> I would like to mention that I initially planned to directly delete the
> namespace to perform the test cleanup, assuming it would be enough to consider
> any non-root namespace flow_dissector to be removed. However I observed that it
> made other tests dealing with flow_dissector starting to fail with -EEXIST,
> despite all those tests being marked as "serial". I started examining this,
> suspecting a real issue (a race between namespace deletion and flow dissector
> attachment check, or a ns refcount issue) but before going further: is my
> assumption right ? Should a mere namespace deletion be indeed enough to remove
> the corresponding bpf flow dissector ? Or am I missing something ? If so I'll
> keep examining this.

Don't think that's expected. Removing a namespace with an attached
dissector program should (in theory) clearly detach it.

