Return-Path: <linux-kselftest+bounces-16859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DB966B76
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E20B224E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF016FF5F;
	Fri, 30 Aug 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLiWYAPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D6165EE0;
	Fri, 30 Aug 2024 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054380; cv=none; b=pCRwZf4R9Db+D9tTZEEO64ppt8aUAxUDKAZZC69TpAvDlxNN28/1qIobXoOcUhKVJ37MQwcFsNCuPltMHSrR4aJ14NwgNafh1/5cjBW8WcPAnDW3zCJsz9qGjp9qPALepDa72nZsZb8GXdWiVTj6pG2KBM9SRoDhZIwMUmBK3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054380; c=relaxed/simple;
	bh=2Rvb8tMZHQHsmiijwlk7hSTrlM+BUj56sPl/97f/g74=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pdO6bYUQ4OY7Io1kcCkCEe/lfgf2cshwhg8/vllSzsFYdYSRogtyRJCMThM5TjaO95saDxBbOlVSlhQk3T+7AFF38aBmPSR6ovkKagMQ1C+TCgUatdWD2cyF3MxrFJgGdHQPnPGdvZy0H2bL2pqQcbktDK6aG1kA1OT6Z7FSzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLiWYAPI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a7f8b0b7d0so101749485a.2;
        Fri, 30 Aug 2024 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725054378; x=1725659178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEXUSEjOgE2zDXVPt774/bdHGXaaOnzgSC3FiU8zMnY=;
        b=OLiWYAPISE9EgLMdcJbL6NWkThfTcB62i6jBQajZPOcr+tHXSJiN6E+UDA8huNSH4l
         EK17lie3A3QMOOOABn5yn2xxpPyhi3ulUXsyf2Z8WzsnbFAGcL9HHfWMUpUxMSaU/eWT
         8yJKmltBWpotnstB/OG8S+Yl8U/dybe3leyKNyAtTEj7dkvdRpBXa1pDWNsFGd49nsDT
         hARIY0Kk46c6qbXZ+Lk2HTSiXI3Z55INkMF/Ic8x7mwezVc34UDI+lZaBl6xIlYf7DrU
         pty3SmIUjcEcKuqpw2aiW92fMwM9Y754Flo4HzR8A1dORqzp5ZaP5SzF55V9ewj5f+VL
         O1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054378; x=1725659178;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sEXUSEjOgE2zDXVPt774/bdHGXaaOnzgSC3FiU8zMnY=;
        b=WXfe7WxfnsjKTB4eauF3WHT/uNQ9y3ocYLyFkTsZd3y3CqSfBMo+7pU3cN8niIPxbe
         u5XmXaoLFpOuoMlRlbw0IoOz6/sC8X91EzozvoLCkUQRze9oOXQfHsv5df+LbrA/3miP
         1DHSzWTEX9Rx41s7YIijdZ4tmaB0rfn1nSJjHL7E0nfdkhrTb1D76rJeV665CR0LoPBd
         jXrw2Beug8iCsz3WlfwxLN/uTfXfpkVDuX7da7t/Ot440zr+wZ/aR1KrcfZhEW2TLooq
         s9nWF4W6gjkn65O5P8VUGzjNEUZ2DXdB2JxN/5io2Ue3u+aDUkdPqAEQ/pKa00vKuigS
         W7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU4wrxqLjAlzfdnvUjIkALK2DY+scYlfeg/J7X0/4Dapl5Ggectp0NB2ZgaX0kga9GI50cCZFLdK/H7GHX0J+k=@vger.kernel.org, AJvYcCXUxJk5AgxmlFbQ52RO2nwcxWxVhD7h/BewP44B7IN28sF6ycAKoExaRSvmpPhupnXrpjjgFOmF@vger.kernel.org
X-Gm-Message-State: AOJu0YyHl6UevtsFrAtLuf0njjZj+A2kKiVnUk1iWIaBtJn7TmHNSxOf
	dxGso3LCeUFbTb3kNmhj4Z18WX4Tn0eJtMrblSlmFh9kKQn+j3Sb
X-Google-Smtp-Source: AGHT+IHDPnnaSnOjSRgFBWB67AatbTFMjTn9iJqQ0ElcAwtTBuHDCG+8pbBKZvbxcbmycupRUYmTXA==
X-Received: by 2002:a05:620a:4048:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a8ac3bc192mr88851685a.55.1725054377712;
        Fri, 30 Aug 2024 14:46:17 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c2b689sm181534685a.53.2024.08.30.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:46:17 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:46:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
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
Message-ID: <66d23da8e7cb7_3d822329461@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
 <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
 <20240828140035.4554142f@kernel.org>
 <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
 <20240830103343.0dd20018@kernel.org>
 <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Fri, 30 Aug 2024 11:20:05 -0400 Willem de Bruijn wrote:
> > > Kselftest install does not preserve directories.
> > > 
> > > So all .pkt files are copied into net/packetdrill root. This is messy.
> > > More fundamentally it breaks the includes in the files (e..g, `source
> > > ../common/defaults.sh`).
> > 
> > Can you show an example of exact commands and what happens?
> 
> Running directly works fine:
> 
>     $ KSELFTEST_PKT_INTERP=packetdrill_ksft.sh
>     $ make -C tools/testing/selftests \
>             TARGETS=net/packetdrill O=/tmp run_tests
> 
>     TAP version 13
>     1..3
>     # timeout set to 45
>     # selftests: net/packetdrill: client.pkt
>     # TAP version 13
>     # 1..2
>     # ok 1 ipv4
>     # ok 2 ipv6
>     # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>     ok 1 selftests: net/packetdrill: client.pkt
>     [..etc..]
> 
> Installing does not:
> 
>     $ make -C tools/testing/selftests/ \
>           TARGETS=net/packetdrill \
>           install INSTALL_PATH=$INSTALL_DIR
>     $ cd $INSTALL_DIR
>     $ export KSELFTEST_PKT_INTERP=packetdrill_ksft.sh
>     $ ./run_kselftest.sh -c net/packetdrill
> 
>     TAP version 13
>     1..3
>     # timeout set to 45
>     # selftests: net/packetdrill: client.pkt
>     # TAP version 13
>     # 1..2
>     # sh: line 1: ../common/defaults.sh: No such file or directory
>     # ./client.pkt: error executing init command: non-zero status 127
>     # not ok 1 ipv4
>     # sh: line 1: ../common/defaults.sh: No such file or directory
>     # ./client.pkt: error executing init command: non-zero status 127
>     # not ok 2 ipv6
>     # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
>     not ok 1 selftests: net/packetdrill: client.pkt # exit=1
> 
> Due to that relative path to defaults.sh inside the scripts.
> 
> It is arguably a bit weird that the relative path of the TEST_PROGS
> differs before and after install.

I guess what's weird is more what I'm trying to do. There has been
no need so far for progs in subdirectories from the TARGET.

One option is to just create a bunch of targets with a wildcard.
Something like below (entirely untested).

TARGETS += net/packetdrill/tcp/$(wildcard *)

> > We have directories in net/lib, and it's a target, and it works, no?
> 
> net/lib is not a TARGET in tools/testing/selftests/Makefile. Its
> Makefile only generates dependencies for other targets: TEST_FILES,
> TEST_GEN_FILES and TEST_INCLUDES.
> 
> This issue with preserving paths until recently also existed for
> helper files (TEST_FILES). TEST_INCLUDES was added expressly to
> preserve those paths (commit 2a0683be5b4c).

Another option is to dive yet deeper into kselftest infra and do the
same for TEST_PROGS, either TEST_PROGS itself or as a new
TEST_PROGS_FULLPATH or so.

It needs a change to INSTALL_RULE (maybe just passing -R to rsync),
to emit_tests to skip basename when writing kselftest-list.txt, and
probably to run_one() to break up the path and chdir. I'll see if I
can make this work without too much churn.

