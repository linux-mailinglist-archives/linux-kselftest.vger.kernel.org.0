Return-Path: <linux-kselftest+bounces-8361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31138AA27F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546FD1F218D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659F17AD87;
	Thu, 18 Apr 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiIEs4X0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55717AD83;
	Thu, 18 Apr 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467192; cv=none; b=ap3O+OH6l9EhYyaG1D0ITxUn6/7rpus5nkTXOhKZ94m84qBAKzPz4dqtn7LY0Le2u9C7k2iguOXA+MUAxBrIzwQnchMpW/KZ0ozU2GcNy5szkKXdsBjilYu67+rvXf7suKIVC6Oy43zXAPJWnnB+5pNrIpgEaym4OTRxuuqBQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467192; c=relaxed/simple;
	bh=5yE7gTbmJo1J/i8oxJyG/BtKhBBGRJSbKzrS01UohJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNbx/dQq86ou/k82aI5139pweZiVl4Vb7pFgOwCqdeQeLqRVfXjeJRDDVZPoIycMtP6iMRF9zIqouSuxNiGTKjG6AeGWfNF5IMZHHzC67YUH9BYD1MXdeME/JW7fm8KOjmfHmMr9xCcjfO+yagPr2f2py4FG/OmqkRD64yCPIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiIEs4X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8D7C113CC;
	Thu, 18 Apr 2024 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713467190;
	bh=5yE7gTbmJo1J/i8oxJyG/BtKhBBGRJSbKzrS01UohJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RiIEs4X0gVy9qI8JGUr8/tjiBT5jgThH2L5iJF8qGVsF5dh8mIpMnF0jnoYmCLvcP
	 UVElqdV71Xo4INIWy3gIuy+i34F2MHi53C3sfDhSm8nUo9wBNrR6A3jKpii6DrzDf8
	 j/2PfcUs7TwQk/KcgVkqXqjnGugJWwxbuY6jY0/dBTQxKrG30l8OZTBTldSIKVrzLL
	 0jmM6Gm5GtoONkMzj4U/vRNKB/2sh8zvUBCrN9I1jK2uFzOC8efC4PCnmAVYFf2bhM
	 salRsYB1+3KPbUJjDJpH65lzqCaWCRcWcBfDaH8N6676Xk5ChM0zW0Juxoio+TwHCv
	 PbI6Rw/QmuA6g==
Date: Thu, 18 Apr 2024 12:06:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/8] selftests: net: support matching cases
 by name prefix
Message-ID: <20240418120628.381fd081@kernel.org>
In-Reply-To: <66212d8b82945_ec9b9294aa@willemb.c.googlers.com.notmuch>
References: <20240417231146.2435572-1-kuba@kernel.org>
	<20240417231146.2435572-8-kuba@kernel.org>
	<66212d8b82945_ec9b9294aa@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 10:26:19 -0400 Willem de Bruijn wrote:
> > -def ksft_run(cases, args=()):
> > +def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
> > +    cases = cases or []
> > +
> > +    if globs and case_pfx:
> > +        for key, value in globs.items():
> > +            stats_with_pfx = bool([pfx for pfx in case_pfx if key.startswith(pfx)])  
> 
> stats -> starts
> 
> for the reader, just spell out prefix instead of pfx?
> 
> perhaps less pythonic, but just
> 
>     if key.startswith(prefix) and callable(value):
>       cases.append(value)

like this?

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index fe4025dc5a16..8018bf98a9d2 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -86,9 +86,12 @@ KSFT_RESULT_ALL = True
 
     if globs and case_pfx:
         for key, value in globs.items():
-            stats_with_pfx = bool([pfx for pfx in case_pfx if key.startswith(pfx)])
-            if callable(value) and stats_with_pfx:
-                cases.append(value)
+            if not callable(value):
+                continue
+            for prefix in case_pfx:
+                if key.startswith(prefix):
+                    cases.append(value)
+                    break
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 

