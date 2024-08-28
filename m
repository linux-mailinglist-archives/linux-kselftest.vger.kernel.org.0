Return-Path: <linux-kselftest+bounces-16549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A796297F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F45A1F25271
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BC18756D;
	Wed, 28 Aug 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ+/GL1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DD1EB35;
	Wed, 28 Aug 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853500; cv=none; b=fWJ76TYVOPIQ8NUZSGDzlOoEKcwfsLaWWUz4315NCGBmBAspnnCMX7wPSCnZkWEPdtFAXyG1Spc0IXKNFENnVfe45TAKd0If8UDoXf8hDsCP4mSku7d6M9p6wuQKe3supTQRG54T3Hhuqomli2I0A7QSnnrgkTuSNSfY88WeSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853500; c=relaxed/simple;
	bh=qS/3ftrCe7+Q/pKCY1b7nFn0NBImMM+OvaA5nSEunNs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HkSmk8ZbC0D0XenzTfJ7Wb8rnY+ZHitl87cgB9BofcBoAVnUW3A2dN5B7EtUPyxBYJxHOzZmuwFrGSR7SgzfCQiTm+6DWQTVYNPP/xfpok2cn4gMSQVI9+tgRyvBdof/mTXjxejxJc2MQLFrRCJAjLU3s6oEe8qw7suxlDU/D0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ+/GL1Z; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-498d7c77e91so2327331137.0;
        Wed, 28 Aug 2024 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724853498; x=1725458298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OIvGrmUj4kPFC8I7b58x9G7CZTxM2XNn+yRsQ87PT8=;
        b=DZ+/GL1ZqjEqd3Iv7mg9N9aNU93fdVWPb+EocfkSxrxlpmGHFHMtCrWzIuLpHsawXw
         0Z2weFBY8nuo8oQ2XfsHxiAubkxEdAlXOMLRTTxxuuLq+yB9BP0TuBi6dkHp+RXDLXpT
         lHB4tx75vyScEa2hPCIxtbFTcrbjFarJLdOkTVRf70eBQ95tgWskvTFQaevTFJErOI88
         kQgg2yBSAi2M+uGGnrS/eoNXU+zVbZ37jpzR22TP+BZ4PvEeF/C4IaBk0Wkip0kLdz9N
         FTJ+P/sPIm/o+TMNRjXi8CXmihFowIVJprL5+u4EG03PV3d6hf2SJH3LJGkCaSxBSIut
         uQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853498; x=1725458298;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6OIvGrmUj4kPFC8I7b58x9G7CZTxM2XNn+yRsQ87PT8=;
        b=BZR6rQzOiGcRCFkEk7lQBBgppPLGUeMrufVwKCZFwVGhMvr6EqQG+fTiRrCCH9dDTO
         0ErRA0EjveE5R2Z89bx77CdJDzpuLgwfYHSJQ/1r6rduF/ALCtIT6AQdbuVAcgb3V7hF
         Y+PMXuQ3fuPCQV3w9HW9j9x6p0oTyv3X4B2FQQACDk6wztDNvy4BgHpZtA4HTeTHthb+
         tNe33DNB/uqs8hmi4smxuBLwyr4BW/mr3miz/UJ7F7CSKM0dLyPN79kFCUmSbLEelmDQ
         1isjBGaG1PXc4qfzrD1ouANm+srD6VQBSMjb75JfBvGmg0VhAytcm5Kvfl0la5VnKbhP
         b5ng==
X-Forwarded-Encrypted: i=1; AJvYcCWCUHpPa37Pc086PGSXUvDxN4c7PX0GRrQwUsRvynJCHIB1Rw3MqS+ft7gD5RqUrLyxeknLzuVN3lP1nMTK0Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6b/jVn0ee58o0hxYsiNcAbMXj9C8+s/HC2/F6oQaLBNRkoocy
	uhoeaZL5EMhnsIFodLd0/3brrgJDSwujso+JVKpocexb6R5OWooS
X-Google-Smtp-Source: AGHT+IFKVKYUaCGtjv01yeFmRNewTPTgVPZtqwnVU1LXom5CrWd9qKPTnVniGrWXi2X5X02qiqKoqQ==
X-Received: by 2002:a05:6102:d86:b0:492:a93d:7cab with SMTP id ada2fe7eead31-498f4b1476fmr16781178137.1.1724853497863;
        Wed, 28 Aug 2024 06:58:17 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3199dasm642700485a.15.2024.08.28.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:58:17 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:58:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66cf2cf8efd6f_33815c29411@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240827173905.65b8efcc@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <20240827173905.65b8efcc@kernel.org>
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
> Very exciting to see packetdrill tests making their way upstream!
> 
> On Tue, 27 Aug 2024 15:32:29 -0400 Willem de Bruijn wrote:
> > RFC points for discussion
> > 
> > ksft: the choice for this python framework introduces a dependency on
> > the YNL scripts, and some non-obvious code:
> > - to include the net/lib dep in tools/testing/selftests/Makefile
> > - a boilerplate lib/py/__init__.py that each user of ksft will need
> > It seems preferable to me to use ksft.py over reinventing the wheel,
> > e.g., to print KTAP output. But perhaps we can make it more obvious
> > for future ksft users, and make the dependency on YNL optional.
> 
> No preference here, the wrapper script uses little of the python
> code, and use of YNL seems unlikely, so it's a coin toss whether
> it's worth linking up to net/lib/py or just writing a bit of bash.
> 
> > kselftest-per-directory: copying packetdrill_ksft.py to create a
> > separate script per dir is a bit of a hack. A single script is much
> > simpler, optionally with nested KTAP (not supported yet by ksft). But,
> > I'm afraid that running time without intermediate output will be very
> > long when we integrate all packetdrill scripts.
> 
> Not sure what you mean by intermediate output (the perl wrapper prints
> immediately, do you have perl?). We do have some nested ktap parsing
> in nipa, but small tweaks would be necessary to "decapsulate" the first
> layer completely. My bigger concern would be runtime, if the time it
> takes to run all tests grows we spawn multiple VMs and load balance
> the test cases. 
>
> All in all, trying to support single script is probably not worth the
> extra effort.
> 
> > nf_conntrack: we can dedup the common.sh.
> > 
> > *pkt files: which of the 150+ scripts on github are candidates for
> > kselftests, all or a subset? To avoid change detector tests.
> 
> Other than avoiding known flakes - no concerns. Is the distinction
> between "change detector" vs hard tests (uAPI change / RFC compliance),
> well defined? Not sure if that's really possible but if so it would be
> nice to "sort" the tests into different dirs.

It's not as clear-cut as API/RFC.

The major change detector issues are with timing, as packetdrill
scripts have timestamped lines. I think usec TCP timestamps were an
issue at some point. On-going is that we increase allowed variance on
debug builds. Note to self that that is missing here.

I think that all tests we open sourced to github so far were chosen to
be robust. Will double check and err on the side of caution.
 
> > And what
> > is the best way to eventually send up to 150 files, 7K LoC.
> 
> Just send them, slice into a handful (<10) of patches if you can. 
> 7k LoC is same order of magnitude as initial drivers we merge.
> 
> To be clear let's start with a small patch like this one.
> Since this is a new target I'll have to reconfigure the runners.
> So we'll see how well this works once it's merged.
> Spinning up new runners is a bit tedious but here new target seems 
> quite justified.

Ack. Thanks for that guidance.
 
> >  tools/testing/selftests/Makefile              |  7 +-
> >  .../selftests/net/packetdrill/.gitignore      |  1 +
> >  .../selftests/net/packetdrill/Makefile        | 28 ++++++
> >  .../net/packetdrill/lib/py/__init__.py        | 15 ++++
> >  .../net/packetdrill/packetdrill_ksft.py       | 90 +++++++++++++++++++
> >  .../net/packetdrill/tcp/common/defaults.sh    | 63 +++++++++++++
> >  .../net/packetdrill/tcp/common/set_sysctls.py | 38 ++++++++
> >  .../net/packetdrill/tcp/inq/client.pkt        | 51 +++++++++++
> >  .../net/packetdrill/tcp/inq/server.pkt        | 51 +++++++++++
> >  .../tcp/md5/md5-only-on-client-ack.pkt        | 28 ++++++
> 
> prolly need a config file to enable kconfig for MD5 ?
> perils of adding new targets
> 
> > diff --git a/tools/testing/selftests/net/packetdrill/.gitignore b/tools/testing/selftests/net/packetdrill/.gitignore
> > new file mode 100644
> > index 0000000000000..a40f1a600eb94
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/.gitignore
> > @@ -0,0 +1 @@
> > +tcp*sh
> 
> Is this right or should it be tcp_*.py ?
> 
> > diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
> > new file mode 100644
> > index 0000000000000..d94c51098d1f0
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/Makefile
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Would be nice to add a few lines here with an overview of how the
> packetdrill tests get executed. People may jump in here to try to
> add new tests, since that's how ksft usually operates.
> 
> > +def scriptname_to_testdir(filepath):
> > +    """Extract the directory to run from this filename."""
> > +
> > +    suffix = ".sh"
> 
> .sh again ?
> 
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh b/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh
> 
> > +# Override the default qdisc on the tun device.
> > +# Many tests fail with timing errors if the default
> > +# is FQ and that paces their flows.
> > +tc qdisc add dev tun0 root pfifo
> > +
> 
> nit: double new line
> 
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py b/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
> > new file mode 100755
> > index 0000000000000..5ddf456ae973a
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
> 
> What calls this one? I can't grep it out.

Whoops. I changed test directories and apparently these ones don't
rely on this.

Thanks for the review. I'll take a quick stab at a standalone script
to see whether that is easier. Else will resubmit with these and
Paolo's feedback addressed.

In particular to Paolo's feedback: running multiple tests in parallel
like run_all.py can. Come to think of it, maybe I should import
run_all.py, modifying it to output KTAP and ksft return codes.

