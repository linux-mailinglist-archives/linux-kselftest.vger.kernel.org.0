Return-Path: <linux-kselftest+bounces-16519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7A962235
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 10:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5961C20D0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A10156C76;
	Wed, 28 Aug 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+BbEfFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158C15B111
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833240; cv=none; b=OOaLE2puYQ/j6XaFHny+Ba5sEaW0kPKAEGw4YhsrvNxa1leqS463l+pSth98O+qfl06SPvaD1mK1wte/wclbtSdNw2gsrPSWQ149LIpI3aiA+p17+8pSy2eZiggv0x5ujzAINh4XaFofE1g5JxOZx+KN3MeC9m7/0tFjB5s7hY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833240; c=relaxed/simple;
	bh=1lx02cr09o0GvC4pP+O93KnU2VBN6Uii6gCTgj3Z0xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t05ic/60R9PXHyOnVZU7wYq0PFaWODbDZR+SOcZ+cvmJVrVE6HJ11hhzVTwAWaVLK4mN1Z9GK2MDKN122SExPnxklQPcR7J4qOdR1pOgNGi4iw2QA0EZkCBSfvRDRRFGb4ICh+exeHg34bfa/DONI7dQcdE8h0kxfzRxxdxRSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+BbEfFl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724833237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RB+6lhxu3ehfP+zrXXgfWhDBZmy97wctUMf7QuJM/wI=;
	b=P+BbEfFl9brelruaHw2spa0xcf++wDTpwjgM7v/oN6+YtjGFcp4LQB27xevR6m3e3s+P4A
	mVFRoOD6uouAUZEKevMzmeQKS9aKjZM4Zw4CQ2OmCM7F4WBfNIr0YfkacWkMAHzdImpCHA
	NPlU+ysG6S11QOqTBhBoVZfKyoHvhqQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-IVD0PNLfMlmrbTA1kO249Q-1; Wed, 28 Aug 2024 04:20:36 -0400
X-MC-Unique: IVD0PNLfMlmrbTA1kO249Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428fb72245bso2141005e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833235; x=1725438035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RB+6lhxu3ehfP+zrXXgfWhDBZmy97wctUMf7QuJM/wI=;
        b=XG9e/EuqNvyflc8cFRRQU6md+QrrCFARggdSzVRltCeCLP48O227+cOdcFcGU6h2L+
         +f2Y/fNvnMKvANUEjczYa46Ohp4fsEKW7TGKkagrUoIlN8K7B/SlqELJNXPtjreQ3lbX
         6wWFg2CJ6gyNPaO7bpeNP8lOL4R3m/kL0ymVFdNiHpcjZlMDVyishKo/UbbatBhyxe27
         Jq6MRV6mUixFfOGkUhDmwBTzjxR1+R8TFdKPO9YHLZXAM4IlSaI29kn6dfJAy9Vyxvqv
         Q64Tn9hVeXFUSQnJRni9MXTMzXv0xNjNLETfQD+WXPJJCwzJ6ZmKY6BPlRCjecRffigx
         TiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9kdFRHteUHByzdJtUiGqCAtA7PUfffCCuqNfOOroQ6l5dQ/IeKXA21CpuuBSRcqsUTJbzdbwVmqA+/HhBTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJ9nzthd3+iay1dsSh4HMzZ85BuIfcC/YW4+3ciRqhbEV8fo4
	gWxKglJV8jKRza3BbnMrTV08jJjLuNT6hb4B3J/eyQjBR07WjEy/ck0ZaRr9jdJUs14x92/t2Oh
	5KqzYq938ooJwpXlCWNqDI2pP2nhA/NoyQSbkTFzs+Rl6rpFKSynRhxN+dtIPyDX2uQ==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42ba572f39fmr7389865e9.15.1724833234650;
        Wed, 28 Aug 2024 01:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHsbTzYkFGfKQB6RCD+HDMcq6rBfUzAZuckOuRNsoFpeBcypplDnwz5Dg+z2fP7injSiDcAw==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42ba572f39fmr7389605e9.15.1724833233996;
        Wed, 28 Aug 2024 01:20:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63d816bsm13471755e9.36.2024.08.28.01.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:20:33 -0700 (PDT)
Message-ID: <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
Date: Wed, 28 Aug 2024 10:20:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 ncardwell@google.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 fw@strlen.de, Willem de Bruijn <willemb@google.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, martineau@kernel.org
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Adding Mat(s) for awareness, it would be great (but difficult) to have 
mptcp too in the long run ;)

On 8/27/24 21:32, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
> 
> Florian recently added support for packetdrill tests in nf_conntrack,Addin
> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> conntrack tests").
> 
> This patch takes a slightly different implementation and reuses the
> ksft python library for its KTAP, ksft, NetNS and other such tooling.
> 
> It also anticipates the large number of testcases, by creating a
> separate kselftest for each feature (directory). It does this by
> copying the template script packetdrill_ksft.py for each directory,
> and putting those in TEST_CUSTOM_PROGS so that kselftests runs each.
> 
> To demonstrate the code with minimal patch size, initially import only
> two features/directories from github. One with a single script, and
> one with two. This was the only reason to pick tcp/inq and tcp/md5.
> 
> Any future imports of packetdrill tests should require no additional
> coding. Just add the tcp/$FEATURE directory with *.pkt files.
> 
> Implementation notes:
> - restore alphabetical order when adding the new directory to
>    tools/testing/selftests/Makefile
> - copied *.pkt files and support verbatim from the github project,
>    except for
>      - update common/defaults.sh path (there are two paths on github)
>      - add SPDX headers
>      - remove one author statement
>      - Acknowledgment: drop an e (checkpatch)
> 
> Tested:
> 	make -C tools/testing/selftests/ \
> 	  TARGETS=net/packetdrill \
> 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> 
> 	# in virtme-ng
> 	sudo ./run_kselftest.sh -c net/packetdrill
> 	sudo ./run_kselftest.sh -t net/packetdrill:tcp_inq.py
> 
> Result:
> 	kselftest: Running tests in net/packetdrill
> 	TAP version 13
> 	1..2
> 	# timeout set to 45
> 	# selftests: net/packetdrill: tcp_inq.py
> 	# KTAP version 1
> 	# 1..4
> 	# ok 1 tcp_inq.client-v4
> 	# ok 2 tcp_inq.client-v6
> 	# ok 3 tcp_inq.server-v4
> 	# ok 4 tcp_inq.server-v6
> 	# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	ok 1 selftests: net/packetdrill: tcp_inq.py
> 	# timeout set to 45
> 	# selftests: net/packetdrill: tcp_md5.py
> 	# KTAP version 1
> 	# 1..2
> 	# ok 1 tcp_md5.md5-only-on-client-ack-v4
> 	# ok 2 tcp_md5.md5-only-on-client-ack-v6
> 	# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	ok 2 selftests: net/packetdrill: tcp_md5.py
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> RFC points for discussion
> 
> ksft: the choice for this python framework introduces a dependency on
> the YNL scripts, and some non-obvious code:
> - to include the net/lib dep in tools/testing/selftests/Makefile
> - a boilerplate lib/py/__init__.py that each user of ksft will need
> It seems preferable to me to use ksft.py over reinventing the wheel,
> e.g., to print KTAP output. But perhaps we can make it more obvious
> for future ksft users, and make the dependency on YNL optional.
> 
> kselftest-per-directory: copying packetdrill_ksft.py to create a
> separate script per dir is a bit of a hack. 

Additionally, in some setups the test directory is RO, avoding file 
creation there would be better.

What about placing in each subdiretory a trivial wrapper invoking the 
'main' packetdrill_ksft.py script specifying as an argument the 
(sub-)directory to run/process?

> A single script is much
> simpler, optionally with nested KTAP (not supported yet by ksft). But,
> I'm afraid that running time without intermediate output will be very
> long when we integrate all packetdrill scripts.

If I read correctly, this runs the scripts in the given directory 
sequentially (as opposed to the default pktdrill run_all.py behavior 
that uses many concurrent threads).

I guess/fear that running all the pktdrill tests in a single batch would 
take quite a long time, which in turn could be not so good for CI 
integration. Currently there are a couple of CI test-cases with runtime 
 > 1h, but that is bad ;)

> nf_conntrack: we can dedup the common.sh.
> 
> *pkt files: which of the 150+ scripts on github are candidates for
> kselftests, all or a subset? To avoid change detector tests. And what
> is the best way to eventually send up to 150 files, 7K LoC.

I have no idea WRT the overall test stability, is some specific case/dir 
is subject to very frequent false positive/false negative we could 
postpone importing them, but ideally IMHO all the github scripts are 
good candidates.

Side note: I think it would be great to have some easy command line 
parameter to run only the specified script/test-case.

Thanks!

Paolo


