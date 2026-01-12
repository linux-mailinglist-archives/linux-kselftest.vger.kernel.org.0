Return-Path: <linux-kselftest+bounces-48793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF4ED15504
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6585B301461B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD99A32AACB;
	Mon, 12 Jan 2026 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJEpuSUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038F280324
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250948; cv=none; b=u6b2ddCqtb25/+bu8PikF/t4bNIYmfwT17EHQUJfDmWI/Mz5RBBBq5c2lC3dIAxam+p1ZdLBHSBcWu7CfBmUjspxBcZaLvYkAhJIc9QnLzISFYBtXUNJNpUl24v0+iuyszctM6qZg/G0cFqmo3IINPcao3dFV96X0SxYpCpM1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250948; c=relaxed/simple;
	bh=DXbVa3jS0bJFES33jOZRjblJg0xNQ4KyxInln27F+dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgOOOTBnVeJoHQWWeZ9Akn4waCPu1l5tKeLKflDNVVs7SkgMGnDFjNhPSCh63FY4M51+G5OgkV2/S487rrOQ3M5V7BXmfXd3eArCCBJQp5UiFZvDZhOVlQsqS0Bp3jXtL5o9xo0UUNHf7AS1F15RGXxEG92plXoogjhrUxqbbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJEpuSUU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso54222075e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250945; x=1768855745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2RjJNZj9WiaDuu2/f+BActJj79sF/vP6f1iAg7+n+0=;
        b=nJEpuSUUZ/ZiUYVVDFs/teihrwDrgHHq4z26v4/Bl2gxYqg+aBw0Z0rrfj3e1CHu2t
         rR+Jq5ymGn15/u9fFzCt1jDed83lxsATGyRpCG1fhCkFeux4w3Hay6hyluU9nMYN7sgc
         AtBV4PLI2Ep3zzuzx986RfrgCBvjJ1VUQCK83J1Od+JVEC3VgV1wUSiX/SmFt3vgjaHA
         HErFidYvsXFF4TnOIFTtCgq4AbCY69MtBbLoAL4izB97vqbWfFH6jYWhJAYhP71GcrMB
         k1Jpp2oxybVpwGYMAlnTSBRFtmppghgM7tJmyMx+DWrQDYmpYOlDwkF/oZbnEbzfdKA9
         nQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250945; x=1768855745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2RjJNZj9WiaDuu2/f+BActJj79sF/vP6f1iAg7+n+0=;
        b=E7ttQP70tKHgLKQerlGlQu0eXmxt3S3E8F/afnvYgSycN2C5tTVHuQ1TWtH20Qdklt
         bmfjEoWpv9VVkQ0QaumI2Nln6CnUZ4s0HewFut1sJIc8i6hQplUQMPCNmyyYbrWjVlxb
         dBjBwpnS9MXs4CXeymJEL9cNkXgIk/7YO2q5jTVLZyhr8d/GGe9jRZiyxD73z4LDMRfn
         w+o6a5vVXG3qPrgfM45nzUeRyMx2b6MN33voNUASgI5DT4jKTXVaKp69gGHUtzMA+3IH
         Btfp0C5bLdWwxOrWStJcUL9PeNXrR5CKKDgL86rEAOwz1q6wUlUftHClC5fuBQI2V9Gk
         KZlg==
X-Forwarded-Encrypted: i=1; AJvYcCV9QJa5HVwck2zESUrWWLiDqu8hUR8NOdjuJemSBx6qRxrAhBcRPxAnoCR2k0rAl2YkHnL8N2nfufATBD3tjjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wiNQHg0J6adsli8Z0mtWCuA00K/sZ/oEg1KaNzuRPrz276zA
	rVdqFVmRiEi8g+0ZDFTQeDYv7BPd42ogNUfVdhyYBZv7B06UdaYp8NRI
X-Gm-Gg: AY/fxX42QlPbmK3CTDZkaHa/I8p7CcF2AgLU+h7AeiBvvwQEgyQJu+I5POwhIB3yEqL
	qM3DiKakdbeRcQYwmp/9wEHTL5/pUvYrQlSJPPy6gBm+Uu9lLyd+4Py2JAIxGcJulbjQWMCMWg6
	F2dvAMf6lQkU+q4qr+TZDrYPQtxPXqp/V2kkPB0zMUUGdpVQ/LzsFvGSBteAPES4naKskhV4NsU
	b8jubA+Ox6/MmVZdwQymwM1/O83r9J+db5eQmBhm2IVoDMb1oP8xe8c6Y7ZRa9rA5oJvclDzwSL
	CtI95EOlyDuuSZRc6SFTB9E2/zOrOz0d/409/eWE8XWEcf5cWlxnIuIVwmnUx3J7yZ13KSFU7it
	yu9Xv3W4OlANE6LP+X2rTHH1tvmCOWPYg/twuaFWOt6L2uPY9HVr3CM5gySKTuNsn8Lj6WSt4AL
	SBZfWcng==
X-Google-Smtp-Source: AGHT+IEUHyZiTNqqW+IdaQUrwbNAvr56XMJ93G/j42dlvw8ceohsgT5xlYL83tB9qWVnH/xCWwdzwQ==
X-Received: by 2002:a05:600c:8b43:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-47d84b33b7bmr228110095e9.21.1768250945215;
        Mon, 12 Jan 2026 12:49:05 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c61sm377709655e9.10.2026.01.12.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:49:04 -0800 (PST)
Date: Mon, 12 Jan 2026 20:49:02 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <aWVarVD7DQ4uG8YZ@archlinux>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
 <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
 <20260112061642.7092437c@kernel.org>
 <uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>

On Mon, Jan 12, 2026 at 07:16:54AM -0800, Breno Leitao wrote:
> > On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> > The new test seems to be failing in netdev CI:
> > 
> > TAP version 13
> > 1..1
> > # timeout set to 180
> > # selftests: drivers/net: netcons_resume.sh
> > # Running with bind mode: ifname
> > not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
> 
> I was discussing this with Andre on private.

I have not been able to reproduce the failure locally yet. I've checkout out the
CI branch from linux-netdev/testing and followed the instructions in [1] to try
running it as close as possible to the CI setup and no luck yet.

I'll continue digging but appreciate any suggestions.

> Also, do you know why we got:
> 
> 	/srv/vmksft/testing/wt-18/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
> 
> after the test failed?

I think this might be caused by a change[2] in run_kselftest.sh/runner.sh which
seems to cause runner.sh to fail when a test failed and runner.sh was not called
from run_kselftest.sh.

[1] https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
[2] https://lore.kernel.org/all/20251111-b4-ksft-error-on-fail-v3-1-0951a51135f6@google.com/
-- 
Andre Carvalho

