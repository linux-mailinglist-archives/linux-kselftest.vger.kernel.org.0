Return-Path: <linux-kselftest+bounces-16806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B896652E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154902845E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C01B5830;
	Fri, 30 Aug 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsBbSKm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AF1B5311;
	Fri, 30 Aug 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031209; cv=none; b=CkZxPAFPLg+CCoovX2FGxlpG+TKZtiHJtbTna+iajMzLmnr70mgXNae+Ks9q8xsXGlE9llB9j0IsfH+Oa/FRKlSbx8DBeVMKkgsj0NXgZq8ExKhw7l90R5yIOpeQ3nJesSojHzHYxMsXCkUBKfjuSxv1XuchAmyDLCq4Hns2xss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031209; c=relaxed/simple;
	bh=paUW6lrg/oGbNgiylxHYA3HVlrH/VYmkqMwYVUKaDtA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D6B5Eg+T/kDrfVyORuYgvX6so297vPRNeSN8iY/oCms8JmjVsBT0rrozZJ43bzzKjaEJF5nKnf5TcVYDtqqyFANucPEx3clAs+YFYZqxKhRCdL3L8KiDO2Mo3fQj+OVSOEvylMx/e/2wuaxeNZSRqKCxD/rLmRbym0Zo9I9txGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsBbSKm7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a7f8b0b7d0so83375285a.2;
        Fri, 30 Aug 2024 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031206; x=1725636006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa1HHxrncCHtu5ztN4T2T0FOnML+pcv6VrX3IGviXIY=;
        b=SsBbSKm7AkQiAt+Jx+6fx/+sMHS23DCh1Z5IaGBguf727C+3vgkK0mE+5Yy3vgkp2/
         R4tTxlZLmFKyXqCztEoq1UQJGhhIvQ7Go0DToCevGDbCPZPe06q3GI3gJz2OLtIxCXG8
         jydPH7FczIpXmx409vkbGIskGwEujfjlestgTgsPIJ+RdjdtogTjhozKGw5+UWhdtuLw
         8jY0DdMzs12DcBjdWSnIlUADmHaNEsJ3XNL8LH0I879mhHFOgpjsIj26KbNRB+uKT8+o
         XJmT1TFqIytpqMvAM+IQrQsbbR7wp8HxQL54A1Sk0R+FQrlTW8BtNdX1Vp7s7nFHdzeD
         hqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031206; x=1725636006;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wa1HHxrncCHtu5ztN4T2T0FOnML+pcv6VrX3IGviXIY=;
        b=bwR/+0IPDV5iVC7kfT408E7+hnl9nW3t0mT6+J0dJvFeb9J+NonW9z7ADgwlIpevEl
         r23KSxOVdfsIM5gFBhCNucNaU1kCe1furW3Km3g0UyHo+8de4ZgWw/eG9AvMtUoFRsYA
         sojebO9DMU6OzZOHniO2u5yitQN0avtn8N83woNN/vkcjJhX5EaGgBfzH5q77y3Qy0Yl
         5vTp61/8OOD9RlkUrUayc8BQJ2i9nwgT1lqPIMWQldiomqM7vxQZLLnBT/YQwiT+fEQS
         PPqDCDm8guMem+oEQHk8Iw0YJuoF9mGwz2ru7mgpmuMWLs7E/Vnq/8S4pXCvu+v7Hxqu
         ZuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2MK+bfxQ0srzFb+lonGdnN+QHDco8i/ddzseUFCTy5wUOh51z3L7lRnoWYcFNqswliSxH8naY@vger.kernel.org, AJvYcCXzqrezprjpNnzNeNrdLr1yrc6DN1N89I5oAzG0dn6VllvpoNXZOudeo0/puI/4cMsX7sNAwaFU1BAhtAcotqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPQfxYasmYNgkxCLIL0Oy3Gxwbi5xTySiUYuMb3uditGvyHPw
	JUrfWeGnGRYs1hS8i2j/5rk8i0p1GC4H2PwbdeNnUTveCj1EAPGr
X-Google-Smtp-Source: AGHT+IGKywkJXzU4f21NgfkbZ6Pihq+QM5fvS4l26vW1qX1/3HuxLygJPPHCGscgy3XfbmWaDCw2Jg==
X-Received: by 2002:a05:620a:3952:b0:79f:190a:8ad7 with SMTP id af79cd13be357-7a8041c8131mr725141985a.33.1725031206215;
        Fri, 30 Aug 2024 08:20:06 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c23dfbsm151605685a.41.2024.08.30.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:20:05 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:20:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 martineau@kernel.org
Message-ID: <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240828140035.4554142f@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
 <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
 <20240828140035.4554142f@kernel.org>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 15:33:33 -0400 Willem de Bruijn wrote:
> > That could work.
> > 
> > Is reporting one KTAP and exitcode per directory vs per packetdrill
> > invocation good/bad/neither?
> 
> To me "neither", hopefully and unhelpfully I won't tell you anything
> that's not common sense :) The balance is between:
> 
>  - having test cases which don't take too long (assuming debug kernel):
>      <15min is good, 
>      >1h I will start complaining,
>      >1h30m is bad because we can't retry and still make the 3h
>             deadline that NIPA has,
>      >3h the test can't run in NIPA at all.
> 
> vs
> 
>  - flip side is having so many cases it's hard to keep track and render
>    in the UI. JSON is relatively slow to process. If you have 150 cases,
>    that's 300 per branch (debug and non-debug kernels), times 8
>    branches a day => 2.4k results / day
>    I think that's still fine-ish, but on the larger side for sure. For
>    reference net and forwarding have ~100 tests each. FWIW we do have
>    the ability to collect and display nested KTAP so the information is
>    not lost (but it makes queries slower so we don't fetch it by default).
> 
> > Three other issues if this is calling packetdrill directly is
> > - passing the non-trivial IP specific flags
> > - running twice, for IPv4 and IPv6
> > - chdir into the directory of the pkt file
> > 
> > That can be addressed by instead calling a small wrapper shell script.
> > 
> > That would do the test_func_builder part of packetdrill_ksft.py.
> > But without the need to handle netns, popen/cmd, etc, and thus the
> > ksft dependencies.
> 
> Right!

Implemented this, but hit a snag

Kselftest install does not preserve directories.

So all .pkt files are copied into net/packetdrill root. This is messy.
More fundamentally it breaks the includes in the files (e..g, `source
../common/defaults.sh`).

The output of having each test separate is also quite unreadable.

An alternative is to add each subdirectory as a separate TARGET.
But that seems similarly impractical. And does nothing to group
KTAP output.

In practice, most directories have a handful of .pkt scripts, and
each script is fast, so serialization is not a huge issue.

I found tools/testing/selftests/net/kselftest/ktap_helpers.sh,
which has helpful KTAP boilerplate for shell tests, including
KSFT exit codes. Am using that instead of python, to reduce the
external dependencies.

