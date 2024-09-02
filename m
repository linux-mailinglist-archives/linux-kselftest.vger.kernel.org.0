Return-Path: <linux-kselftest+bounces-17015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A7968EF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9931E1C222A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720E177992;
	Mon,  2 Sep 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwTFslI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD71A4E9E;
	Mon,  2 Sep 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310226; cv=none; b=OjKsD/BeB07/JRIo0OG+USmX3nDFG+R5PCCs8zDS60+Ve4FlpPYvQx2d3SP17F+1K7kVVqsx0EfQZAQe4imOLXT2bncmMYMb2AnDIJ1eHKK3bkEFqnSQig7zGiFhkljFMEyynaLRCvE3fp6WVTFRcv6YVCMPksqQrGdNCHur/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310226; c=relaxed/simple;
	bh=/O/nz0eaygvRgiRxlGqfsSrXFN3Hmd5GUzPbjopTbIA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hHlmrZwgL5y8GjXQ5E0XU35Rsw+diBW1pYxOJywqSACJkPSKFAINLoyrxOyyuoKHFXlsoluVpmmW9XwWNwet6tu2YoJdL1Wc6oc4tLc31zK0JYy6qmdyZLvUTNZNW5Br8q+sFlB2wWZs8pHGpQSOQeVZ2anZ/i9shKl85lMzzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwTFslI2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c3603292abso8391976d6.1;
        Mon, 02 Sep 2024 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725310224; x=1725915024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r58d46ZBXsKsP+o6kE1FVctskSA/DGdushyT08NeT4o=;
        b=XwTFslI2HpLIXWQnDvV0ch5yMpiRaU8GiL3sddcHPscr2W8XOQ3QU6WxMI/X0g6WRP
         kwu6u6f5plc6PH+Vfd4ennfeSzCtzgCkpm4Ky4sXAqbpBusJvGffqf6gxFq9ztpWP6oY
         N9CB6W7QC43q8GralLZ29cU93Hhxtd3uiEyL/4btfxFNFQLw2TyhfgepKY4BdmoLJ3sq
         E2UsBPh+QejiWnz0dnPOkCHcG++ijZnDexXgurwkfDQwg7i9oOxdAT1DXmGMkCjC/eJJ
         yIAHJAE/PLgnl6+JxQj0Jl2cE4KdbxS/19CLHBU0DQl/Acm4JzKPjjzAQ+luDYwS3CVA
         HEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310224; x=1725915024;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r58d46ZBXsKsP+o6kE1FVctskSA/DGdushyT08NeT4o=;
        b=tPzoCEvYW2pYVaSRREuOgdelcLNbnxKzhBd/c6p3pVgL3TPeKYUiih3NmVO2RfYCBA
         15U5vLACLOUJMVPTabIxr/R36YX0cj3K+IeQXm7XiElnH9jiunp9TQZGUxSn535uza9t
         2/z7wNg/zEiJhjI4KPiLGa1s4qsW0iEGjhOnP98NUK6SkqmOP7TGCMcOIDUNQwc9vvfN
         9ruK9nxC2rA4HuFBtni74qfLqwSkvxIf6gxW+bz7g44L5gtq6gjHGrEX1TOZDyKnU+z0
         I5jh0mIkLdPe84mL8l+Z/3FGftqiUk2P0V+8RJNeVSpbiXMJdQJgjI2QvDsUbnYezCKf
         LCWw==
X-Forwarded-Encrypted: i=1; AJvYcCWIgbxsSp1tLzlEP/r7HbkPxK0m8Z6UG+ov2oJeTDSJ+IkNscv8wEMr+u7bgVSNxZcMLIx+3Aiv@vger.kernel.org, AJvYcCWtgEHdea0UgNC3sK32VgjJ6c/nF6wvXlFWBF7j0+A0x9ksh5pu/XaENH0faUsqIjC1GvlIWlPPqpS7ka3DxVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfm0JPU2eWggaFHUa1NhEKKBZ8mOOYXgZfCm4QBuXjEIQVPVMn
	jcyoDC+rCTs7dB+cEfC521MuJ6mLt4PJCD50b85nUteKKeK9SI6X
X-Google-Smtp-Source: AGHT+IEYVqOkdUVrtA+A/y/y5nFfmda6t6mI1R67+5bdQ2ljVZQNSgcIgZzOWNTVOw2kE+R5fPtm9Q==
X-Received: by 2002:a05:6214:3292:b0:6c3:66ab:d2cc with SMTP id 6a1803df08f44-6c3b966e71emr9401426d6.1.1725310223568;
        Mon, 02 Sep 2024 13:50:23 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c96856sm46042556d6.89.2024.09.02.13.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:50:23 -0700 (PDT)
Date: Mon, 02 Sep 2024 16:50:22 -0400
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
Message-ID: <66d6250e9dc93_71ed72940@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240902095611.3567ba1e@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
 <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
 <20240828140035.4554142f@kernel.org>
 <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
 <20240830103343.0dd20018@kernel.org>
 <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
 <20240830144420.5974dc5b@kernel.org>
 <66d23f2349f7_3d8dba29489@willemb.c.googlers.com.notmuch>
 <66d4d97a4cac_3df182941a@willemb.c.googlers.com.notmuch>
 <20240902094612.6d40a914@kernel.org>
 <20240902095611.3567ba1e@kernel.org>
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
> On Mon, 2 Sep 2024 09:46:12 -0700 Jakub Kicinski wrote:
> > PRESERVE_TEST_DIRS
> 
> This was meant to be:
> 
> PRESERVE_TEST_DIRS := 1

Oh I like this.

> Testing this more, looks like rsync -aR breaks networking tests, too.
> The net/lib target, specifically, is no longer able to copy out 
> the files outside of tools/testing/selftests (the YAML specs which
> live in Documentation/).
> 
> So unless we can pass some magic flag to rsync to skip leading ../
> we'll be stuck in supporting both behaviors forever. In which case
> maybe TEST_PROGS_RECURSE is indeed better. I was hoping the
> PRESERVE_TEST_DIRS flag can spread and once it reaches all targets
> we can make delete the old behavior. If it can't happen its no better
> than TEST_PROGS_RECURSE... sorry for the noise.

Oh right :/ 

A lot of TEST(_GEN|_CUSTOM)_PROGS(_EXTENDED) could probably be cleaned
up.

One part that I haven't looked at closely yet is x86's Makefile
prefixing everything with $(OUTPUT). That seems something that should
be consistent across target Makefiles if it exists at all, but
clearly isn't. Maybe it was when it was introduced in commit
a8ba798bc8ec.

So, we could opt out only TEST_FILES. But that still leaves a
branch there indefinitely and makes the option harder to understand.
Sounds like TEST_PROGS_RECURSE is simpler then, indeed.


Separate from the above, runner.sh also needs a few changes. This
part is mostly cosmetic, but there will be duplicate basenames,
for common terms such as client.pkt
 
-       TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
+       TEST_HDR_MSG="selftests: $DIR: $TEST"

run_in_netns and run_many need similar fixes to avoid name collisions.


Btw, for KSELFTEST_PKT_INTERP it probably makes sense to only try this
if the script is non-executable, similar to the existing opt-out that
looks at the shebang.

