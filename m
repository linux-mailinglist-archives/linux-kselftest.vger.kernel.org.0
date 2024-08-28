Return-Path: <linux-kselftest+bounces-16550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3F9629A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0B1B24224
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F10189531;
	Wed, 28 Aug 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6zRKA1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32316D4C4;
	Wed, 28 Aug 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853840; cv=none; b=baxmpuNSAzEs46rTA9TPJvM+fNMgDU0sz7lBO3wQAyRY6KytW6H+R2PxX0bg6NQwzfhbWctQcHhaXOptkgUYgRsFRwk7ZIqoPG1WE1VuX5drkD8C+z76qZ/Ve03sIjGi/rpj+IfLx3FKbxwM6yKEsF0BMsc6L4a0YvKRq1vgC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853840; c=relaxed/simple;
	bh=eZSzCsJwj7rqAjlnXNvCMvbp6dG3WM00eloeQdjFn+g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hEv4j1DvDeYWFs1AOQn8qpiYa9hV+qD6MfpQipZ9pNswNgLo+nCHvR1LopBbu/JCu+DRhS37qnO7q3Ac/zfwE7UFAKxlHoJ3xV/wvUwky5E51v4FJRrqeDiZbu6nJPJ7qlxv/AisNL+kCoJv7/ZOJBpdnVhIpOy1gA7r9M7GMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6zRKA1C; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a337501630so433410985a.3;
        Wed, 28 Aug 2024 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724853837; x=1725458637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQmc8dBb0j9CbeOENdVCHjYG/YY34AOkbiJtBQYP0Fw=;
        b=e6zRKA1Cgm84Zu8kD2nfThZttaEWrGUYgegUA7OEPxQ4JQ0xv0N4laxf7IsdIkH5ti
         +Vl3ymr7AvxtQZdW8bVeswG897Xn0pjK0uGGvSA7T22B5nCxWAFWZnNEsoYC4Lr+WH4Z
         nuJzPevgblX+g2u8ckke1IWYp6mgZ9ve6spCUOQvsgDkEBkevcz6VSvXglLr5pm0A48g
         e24tbk2qIuTurYv5NS0u8le7+6JPYkXzedWKRBlHoyED+PhsMnxsWq5R7L8HEyrw+0Cb
         B7K+R2nTnqHMmqD6qlODRGs4XaJSDJj48gHszVU6GW/yavC1xQol2j1TeA9C9AjP4+H9
         rgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853837; x=1725458637;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQmc8dBb0j9CbeOENdVCHjYG/YY34AOkbiJtBQYP0Fw=;
        b=PUYjp9eBS1F3hHkbQ8UExVTOklyeX44jfJaK9QeGkm2T8fcjYqsU3uQmAMzkYlbGW9
         Bj1mFGIt/7cJCk2ySEl+CmzNasggUUu2lBjz7PVw/UIVl4vF3KrF7lc6YdgMdrdkHzbC
         yvVYkAU7VWOPef0n+XJpB/MzUlLrLeDxXK+XwPo2uzikrx3ySeuiPeAyzv7DFd0Nm30D
         CQr1K+jfgsDKHVwpIAcPpkMIJBdwzZMNhITUIArjtgFOMEMrqw9S33TVT7Y3/OAyX34f
         pe1xEN+sNjltm/WH0EFFCHPqBqxaVorSqeZ1XCDvgUD7D6ILQxS0tHthLOzUHRB6btsu
         R/mw==
X-Forwarded-Encrypted: i=1; AJvYcCW+nX6CslG+Ap5whhlzPE4g5E+jiZb0ghsHZxYkv1UkzGz46dyhqX5BomA7sglYgb+BiGh+gG4fWt2b5TfYJVw=@vger.kernel.org, AJvYcCXNulNq61pZJKZ2JXI8dv69GO2t5O7glXw29N/onhfTLvF2cvzhqtNuxBPjeYnFhoV6MEefY7w7@vger.kernel.org
X-Gm-Message-State: AOJu0YzAL2AXpvcJYWjBgwyZeTTL3nK8Vg7quBKk1uzL8JPGNHZCa5Zd
	KzvITx//FJbHuwfIpSD1X4boQEMdwWMLPX/zYGM9YzP25eXvr5J6
X-Google-Smtp-Source: AGHT+IGCiWFEPEYqnVdRpQ4RX8PknJ9btlY6va//y4op67qcNy8CIZRS2aXBgQDQuW/VkT9ABYmmGA==
X-Received: by 2002:a05:620a:40c:b0:7a7:fad0:d916 with SMTP id af79cd13be357-7a7fad0dbf5mr98008185a.26.1724853836696;
        Wed, 28 Aug 2024 07:03:56 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f31b2d5sm643630185a.12.2024.08.28.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:03:56 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:03:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 martineau@kernel.org
Message-ID: <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
In-Reply-To: <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
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

Paolo Abeni wrote:
> Adding Mat(s) for awareness, it would be great (but difficult) to have 
> mptcp too in the long run ;)
> 
> On 8/27/24 21:32, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Lay the groundwork to import into kselftests the over 150 packetdrill
> > TCP/IP conformance tests on github.com/google/packetdrill.
> > 
> > Florian recently added support for packetdrill tests in nf_conntrack,Addin
> > in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> > conntrack tests").
> > 
> > This patch takes a slightly different implementation and reuses the
> > ksft python library for its KTAP, ksft, NetNS and other such tooling.
> > 
> > It also anticipates the large number of testcases, by creating a
> > separate kselftest for each feature (directory). It does this by
> > copying the template script packetdrill_ksft.py for each directory,
> > and putting those in TEST_CUSTOM_PROGS so that kselftests runs each.
> > 
> > To demonstrate the code with minimal patch size, initially import only
> > two features/directories from github. One with a single script, and
> > one with two. This was the only reason to pick tcp/inq and tcp/md5.
> > 
> > Any future imports of packetdrill tests should require no additional
> > coding. Just add the tcp/$FEATURE directory with *.pkt files.
> > 
> > Implementation notes:
> > - restore alphabetical order when adding the new directory to
> >    tools/testing/selftests/Makefile
> > - copied *.pkt files and support verbatim from the github project,
> >    except for
> >      - update common/defaults.sh path (there are two paths on github)
> >      - add SPDX headers
> >      - remove one author statement
> >      - Acknowledgment: drop an e (checkpatch)
> > 
> > Tested:
> > 	make -C tools/testing/selftests/ \
> > 	  TARGETS=net/packetdrill \
> > 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> > 
> > 	# in virtme-ng
> > 	sudo ./run_kselftest.sh -c net/packetdrill
> > 	sudo ./run_kselftest.sh -t net/packetdrill:tcp_inq.py
> > 
> > Result:
> > 	kselftest: Running tests in net/packetdrill
> > 	TAP version 13
> > 	1..2
> > 	# timeout set to 45
> > 	# selftests: net/packetdrill: tcp_inq.py
> > 	# KTAP version 1
> > 	# 1..4
> > 	# ok 1 tcp_inq.client-v4
> > 	# ok 2 tcp_inq.client-v6
> > 	# ok 3 tcp_inq.server-v4
> > 	# ok 4 tcp_inq.server-v6
> > 	# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 	ok 1 selftests: net/packetdrill: tcp_inq.py
> > 	# timeout set to 45
> > 	# selftests: net/packetdrill: tcp_md5.py
> > 	# KTAP version 1
> > 	# 1..2
> > 	# ok 1 tcp_md5.md5-only-on-client-ack-v4
> > 	# ok 2 tcp_md5.md5-only-on-client-ack-v6
> > 	# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 	ok 2 selftests: net/packetdrill: tcp_md5.py
> > 
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> > ---
> > 
> > RFC points for discussion
> > 
> > ksft: the choice for this python framework introduces a dependency on
> > the YNL scripts, and some non-obvious code:
> > - to include the net/lib dep in tools/testing/selftests/Makefile
> > - a boilerplate lib/py/__init__.py that each user of ksft will need
> > It seems preferable to me to use ksft.py over reinventing the wheel,
> > e.g., to print KTAP output. But perhaps we can make it more obvious
> > for future ksft users, and make the dependency on YNL optional.
> > 
> > kselftest-per-directory: copying packetdrill_ksft.py to create a
> > separate script per dir is a bit of a hack. 
> 
> Additionally, in some setups the test directory is RO, avoding file 
> creation there would be better.
> 
> What about placing in each subdiretory a trivial wrapper invoking the 
> 'main' packetdrill_ksft.py script specifying as an argument the 
> (sub-)directory to run/process?

The files are created by kselftests, similar to any TEST_GEN_XXX or
TEST_CUSTOM_PROGS.

If instead we prepopulate in each directory that is duplicative
boilerplate committed to git, and we still need to add it to
kselftests. Not sure whether TEST_PROGS with paths extending into
subdirectories are supported. And we do not want a TARGET for each
subdirectory.

It probably can be done, but I don't think that it is needed or
simpler.
 
> > A single script is much
> > simpler, optionally with nested KTAP (not supported yet by ksft). But,
> > I'm afraid that running time without intermediate output will be very
> > long when we integrate all packetdrill scripts.
> 
> If I read correctly, this runs the scripts in the given directory 
> sequentially (as opposed to the default pktdrill run_all.py behavior 
> that uses many concurrent threads).
> 
> I guess/fear that running all the pktdrill tests in a single batch would 
> take quite a long time, which in turn could be not so good for CI 
> integration. Currently there are a couple of CI test-cases with runtime 
>  > 1h, but that is bad ;)

Very good point, thanks! This is the third packetdrill runner that I'm
writing. I should know this by now.. Let me see whether I can use
run_all.py rather than reinvent the wheel here.
 
> > nf_conntrack: we can dedup the common.sh.
> > 
> > *pkt files: which of the 150+ scripts on github are candidates for
> > kselftests, all or a subset? To avoid change detector tests. And what
> > is the best way to eventually send up to 150 files, 7K LoC.
> 
> I have no idea WRT the overall test stability, is some specific case/dir 
> is subject to very frequent false positive/false negative we could 
> postpone importing them, but ideally IMHO all the github scripts are 
> good candidates.
> 
> Side note: I think it would be great to have some easy command line 
> parameter to run only the specified script/test-case.

Makes sense. Will include.


