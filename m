Return-Path: <linux-kselftest+bounces-7002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231E895AF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B591F21942
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C315AAA3;
	Tue,  2 Apr 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV4FgpfU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AB15A4B3;
	Tue,  2 Apr 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079882; cv=none; b=l01LLoJVNG3WHlnK3zhYosH1uHCEiZeQBWMVP9109xDsqC5K1o56jrSqXZFKo1kCjRFE2/2trmKYce3Ub5QbHjWAN3i36jO8ByhHjRYRChz6l9VtbvoiCDGdUzaaBMz28upOK3/qf7P+KTDZtyA41Lb6H1uJkINeacnSxttRZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079882; c=relaxed/simple;
	bh=5bsK6tVCmaqdFgzV3erqrs/nn+yUjtIXU/6RBdgvrsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gp63juvBl94kaOpZoFOI63RD9KQ7snfFHNflCOlj/rVbWdMqQPDB3/SxgAUsanqvKY/TlGPkAYMpKRiCmFTIu7IAZF0wJQnsfWiGYk7Q9ZzzlKTj/j8MCCltMdac6PdX5sMS0pG9W6kozBrG40xwKkeSZtfUTbwBASLyDg+8a0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV4FgpfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48089C433C7;
	Tue,  2 Apr 2024 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079881;
	bh=5bsK6tVCmaqdFgzV3erqrs/nn+yUjtIXU/6RBdgvrsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fV4FgpfUcWtS9hzrhJQuRDXrIrnLJsAt7rX4Rme/VCiXe1Ljfk6wInmEe0AB+XfiU
	 tzqjOvNZkdBJfz/wQ18ZQ+zEp1Eqr4LDegV9CQQePvIiW6px9zpUNGAme3vlPLhSn4
	 hmVvG2ESndPjxezCmgsyUMjGH8bqm0aKXBSlS8kOPWcxepo+amNCcu4N8K92xF9Xuq
	 oOmd7n5vTdGAF82xs2OmJl64C5ygDHCNwQHvrLkgU1A/Ms4ViXIiIE5Ult3dO+eADn
	 phob11V4cRF5j14qvuefXoCfIAV0e1zB8EM0O5ih59kWnVi7HWH/pxwF6z/KFkbrcb
	 2BJ0k0Q0XYpXg==
Date: Tue, 2 Apr 2024 10:44:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Message-ID: <20240402104439.4d833997@kernel.org>
In-Reply-To: <20240402103111.7d190fb1@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
	<20240402010520.1209517-8-kuba@kernel.org>
	<87bk6rit8f.fsf@nvidia.com>
	<20240402103111.7d190fb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 10:31:11 -0700 Jakub Kicinski wrote:
> Yes, I was wondering about that. It must be doable, IIRC 
> the multi-threading API "injects" args from a tuple.
> I was thinking something along the lines of:
> 
>     with NetDrvEnv(__file__) as cfg:
>         ksft_run([check_pause, check_fec, pkt_byte_sum],
>                  args=(cfg, ))

seems to work, is this good?

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 7c296fe5e438..c7210525981c 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -60,7 +60,7 @@ KSFT_RESULT = None
     print(res)
 
 
-def ksft_run(cases):
+def ksft_run(cases, args=()):
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("KTAP version 1")
@@ -72,7 +72,7 @@ KSFT_RESULT = None
         KSFT_RESULT = True
         cnt += 1
         try:
-            case()
+            case(*args)
         except KsftSkipEx as e:
             ktap_result(True, cnt, case, comment="SKIP " + str(e))
             totals['skip'] += 1

