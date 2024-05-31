Return-Path: <linux-kselftest+bounces-10997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481378D605D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758E81C20A44
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ECE156F4D;
	Fri, 31 May 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DFgamvD7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AEF156F40
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154025; cv=none; b=nyNAYPfW3eLNwEGjiCyMQ1srY52baj22uZi31afFyNwacYEolB2k7YZih1bYg611MvJvoMv7hcFpR042DL9Y6EKa5iBkYTgm8zgY1alVq/GlbBu9Cq6lVgrKd25r0Hz9pjyWew9AkYQZ1YyuHUqAXpj4+YgesaH5ZLPMj6VrsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154025; c=relaxed/simple;
	bh=b3A47GKp3DVbDjtboyMRPNUCGOfNcSUH5VJJp458EUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uT9uHyFYYFbbXotKyx8T1ItJRSgBGWlkWfRZucKtbSBqY0lefcsEZPNXr8CLXW+XOUMwR2oYU7P9uh7MDMpbe7DiFv0jZU71AolXqNahLFcfVbL92gDSPOyjLK8g+mLqUjwAJEfxlhTvbCuSGWFb40ZvkouiUqvP0IQEM8BMOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DFgamvD7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a635a74e0deso218376366b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717154022; x=1717758822; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Skowyj1GrS+nqOzj9o4sPhgAkjxMx0n01JEJn6nXjeY=;
        b=DFgamvD7fWNZ3ekk7r3dttyp6qGzYlWvuonpHDwWdV7Q+lQAkLxVv2aXBedB4/gs4Y
         NtqSEizsJlZdAob+p53/h71nk2oYFr58gT8PWVtY4mwcRP2IBcLeyI0Zcr5x2qBg92KA
         V+McSmAMFibkYBkCCaGfNYSgLBEBWBGMG359uXBmQLXI32WNUKewnfEL6hRmn+yLyVjC
         6oEWHaViIpu1ECCyPbpVLGXgrpWgulySgknkhO1yp1SqN3YmEoAzk7qEBswDjvx8zlw6
         YJtTXtiP0GLyB4a8bHrHJC4JeIEH7lCclbbltcWxwSDD0CUnaCuh9sRVeC/WAiTjoAdW
         Wi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154022; x=1717758822;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Skowyj1GrS+nqOzj9o4sPhgAkjxMx0n01JEJn6nXjeY=;
        b=nLMi9hcrwycSsn3IbS5ZTBpWrJLxk7CfcXz7OM13asKo5JpDQOiK1hziXTa6vQT11k
         ufEdL0HenaOo3B+IHG2xl3hatPM6x6DOrwFnTHllb8m4MNDoclGEO2tg39jyQKmOAM23
         Zzvx71NphuN+Irv2XvoGQCCKoAIZdi9zGxw6sBXuXFjBYHc0hBiE9iauw9bIwfvWq+d7
         jL0MgsGv8OJaaSD27G5qSNX0Ux46oIBTCjuQR0pHLBqmjN6XYGEwuEPodiTQ8gVicLSR
         0jHnRJai5cCWIdXdSJjqAoFYKn6rt2VSb4yFgv07Q8PYJ7TrDxxL2bbNQX0+GvKEaiZe
         RM4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQzdrfo8Nfro8273RuGDMSXEyFq2yG+gFdFtYLhOEy2S8U8jFRYphGr5sxCLh835pXcvp3jTzdudTAkQMCE5ivoJoDKgLsmHsnaM2IKFPt
X-Gm-Message-State: AOJu0Yw32kGrsmgPfvwHzZ+c3Vd9hRwawA/SuGiyg2GosUqmQ/iJDeJ2
	JIKI8ic9bPOh8c/XLS+/nZaE31Sc7RXgonD67o4VVkXALzv5c3MRXqsqeSjMgQg=
X-Google-Smtp-Source: AGHT+IGaxXHFTVRHEsvv6q9z+YGNFkpqNRVrzgFepTWblfIrwjh5IyPMmzwEBN+iYaMSGdvj8ETx6g==
X-Received: by 2002:a17:906:6046:b0:a64:3518:f904 with SMTP id a640c23a62f3a-a681fe4e25emr106111666b.7.1717154021966;
        Fri, 31 May 2024 04:13:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68519892c8sm49491166b.65.2024.05.31.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:13:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@google.com>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Geliang Tang
 <tanggeliang@kylinos.cn>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in
 test_sockmap
In-Reply-To: <66590f821d120_e5072085a@john.notmuch> (John Fastabend's message
	of "Thu, 30 May 2024 16:45:06 -0700")
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
	<32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
	<6654beff96840_23de2086e@john.notmuch> <87wmnfujwg.fsf@cloudflare.com>
	<577531139c4db3cb35f3f40e23587bcb9815b0ba.camel@kernel.org>
	<66590f821d120_e5072085a@john.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 31 May 2024 13:13:39 +0200
Message-ID: <87wmnaw7x8.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 30, 2024 at 04:45 PM -07, John Fastabend wrote:
> Geliang Tang wrote:
>> On Mon, 2024-05-27 at 21:36 +0200, Jakub Sitnicki wrote:
>> > On Mon, May 27, 2024 at 10:12 AM -07, John Fastabend wrote:
>> > > Geliang Tang wrote:

[...]

>> > > The one advantage of test_sockmap is we can have it run for longer
>> > > runs by pushing different options through so might be worth keeping
>> > > just for that.
>> > > 
>> > > If you really want links here I'm OK with that I guess just asking.
>> > 
>> > It was me who suggested the switch to bpf_link in reaction to a
>> > series
>> > of cleanups to prog_type and prog_attach_type submitted by Geliang.
>> 
>> Yes, patches 3-5 address Jakub's suggestion: switching attachments to
>> bpf_link.
>
> OK. Lets just take them the series lgtm. Jakub any other comments?

Gave it a run - all looks well. Thanks for the patches.

Geliang, is there some MPTCP+sockmap use-case you're working towards?

