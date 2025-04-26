Return-Path: <linux-kselftest+bounces-31710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084EBA9DBC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D271BA18F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2501DE3CE;
	Sat, 26 Apr 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3vlyA/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA4A31;
	Sat, 26 Apr 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680538; cv=none; b=ZDuWKBNFNMAuGttWeIvk11VopBgJF9t4vvn2CJcAfHNdg/U0ImYOCDvwod5gFQ5diLPizo7OQIVhXkn0J2D36v3HrbpgRzp6ijj7QDJyD68FZ1Kw6tOxgW4oG2oGtUiEIsHZCqlE5vbIpsxkA5/kM2MhYVsSazOrhtMfgvqyfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680538; c=relaxed/simple;
	bh=1X7hzm4K83uSdhmHjqtjE/ay1lY32gCYd5tZNihSHxs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q8geAyazMB1wfy8rIaGxQ5LlkyKhPhlJ43i45NvImKXbQH2nKAQuzZrPYMUWrkZxJZ44AdaKwnYhogQq4AaWiijzfALO1MO8B8DQ36WXmm3RTrEcuMSp9XymWIDW88ONNGuPn5UFMTccoMXgWu0Kf6DlG2iZwHbmocgE6rXTPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3vlyA/X; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso35921986d6.2;
        Sat, 26 Apr 2025 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745680535; x=1746285335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og1iE/90Bmt2hCkw8qaULnn0aSlkQYRPJno2tCvI7ZE=;
        b=b3vlyA/XINjmGxxPJ4bfwfNIWlZWULdT/6vdxzVqO+LiKjR+uTDoBiSYZ5x2e80P/j
         LSuKxOnlDSGCVFN+/8xc6E6ymUI42DUU4DlvhU5gVaBGrO/BmS+sq+Lz+iSyAIuqjeG4
         wLazJt6aNq50OYhEdGUzwmAi2ejOxyA2Zia7fjTYkuYNk6Q6+A7sXxVLV5C9+0KblXlV
         DavCnGRrUn0QhVIA9jOM5/h5J6DQfmLU1Pav9VkOuK6vr0Zc31koW4aFwFf9i5Pyulnv
         JnQbTfnNPZkkwrSNSWaDWIfh7q5IX5q/3hfMDJKP+RLUmVDzz6HqdnNzR6diGAU8Fnwy
         hyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745680535; x=1746285335;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Og1iE/90Bmt2hCkw8qaULnn0aSlkQYRPJno2tCvI7ZE=;
        b=oSpOy881+Knw03iNYNDhj6SxEFISBu6c2NSCext16R+YpRryEr7F0Z4wH2A4VOlqaN
         uPihSJUn7VOXUPdsEWW1QzMQ3gcr49H/SMG3O3V4HpRu7I0ftvRvDNy8ZjafeAS1VLS5
         g0BG2QooAw8Br0H3I6sOgPX42dC+BLt9sogZo3+AeB6dGZ136IybJtz7Ne0ZflQzpSK8
         pXEXD3ztxI1VzztScZEV2cysil1EyRVlUDq0KQ9DPSid1FFcGGzJ2vBKrMxnBpWWysNH
         m2zXRwAkyGmqRSqkX+EqmKu8PGp5rY2Vby+CZUrv5gEcZFQ133n6+a9p7V4vR9hWqER6
         twGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsTtrhUholeEu5J/v8TpPuwH3Jdxy1Z5u6YnGVLonnD/z4eBCEi6EyX//JGWgDXqeiyKtronwPQ8m1hCG97rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKO2FSWB4mLEFVOx1dm632xGZn38fMpzdu8ZaQeU0DPsWGdU2
	8DbLrIOyMuSaSnAj4p+Gjpc8vJZ4dGLc6Pjvx8jE7DGqMWH6pwRm
X-Gm-Gg: ASbGncsft4cYq3prF1Wh/UirHjK5DHfCdzV78KknpbehXlH30kM7TkZe+q53tc4pzcH
	f779HEamM6Kk6nFI04N+rtkwQYs1jNbsCMP9ocwjtFByex0pv1k8ANZcdeEhN/twMkHyTDN9baU
	PCkohewNGZ9EeEl7bN1HB8aagm9541yWqMxVdyZ9Bb0Emrm3LFLLGN7KIjVPGkIgHxjRV0qiCLn
	Xbyor0wxaNrnaQhprHmLVQTeuaeFvyTuWmQn7GSyX/Ih6Vw+PHp0ghvvpGIM82B8xd1tCSpJTAq
	sAHPJxOZPlrowre6ikpHCG9MfEA0tDUk9sHVftpAb+jpQlCWolBp6CdfmDMMAhvBXxB1jLtT28H
	bmGBrIGVb+pbmyvAlYN5R
X-Google-Smtp-Source: AGHT+IEHzBf1ELtLwhB+iurfe7MRCTefGSOl4RLwBrag1Ax3fG2pNQMv7FU/rK2NslyIWnGHlvsj3A==
X-Received: by 2002:a05:6214:483:b0:6e6:602f:ef68 with SMTP id 6a1803df08f44-6f4cb9cfc28mr111554176d6.10.1745680535059;
        Sat, 26 Apr 2025 08:15:35 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c09341edsm35525956d6.30.2025.04.26.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 08:15:34 -0700 (PDT)
Date: Sat, 26 Apr 2025 11:15:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 petrm@nvidia.com, 
 willemb@google.com, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250425151757.1652517-1-kuba@kernel.org>
References: <20250425151757.1652517-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: exit cleanly on SIGTERM /
 timeout
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
> ksft runner sends 2 SIGTERMs in a row if a test runs out of time.
> Handle this in a similar way we handle SIGINT - cleanup and stop
> running further tests.
> 
> Because we get 2 signals we need a bit of logic to ignore
> the subsequent one, they come immediately one after the other
> (due to commit 9616cb34b08e ("kselftest/runner.sh: Propagate SIGTERM
> to runner child")).
> 
> This change makes sure we run cleanup (scheduled defer()s)
> and also print a stack trace on SIGTERM, which doesn't happen
> by default. Tests occasionally hang in NIPA and it's impossible
> to tell what they are waiting from or doing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: petrm@nvidia.com
> CC: willemb@google.com
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 3cfad0fd4570..73710634d457 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -3,6 +3,7 @@
>  import builtins
>  import functools
>  import inspect
> +import signal
>  import sys
>  import time
>  import traceback
> @@ -26,6 +27,10 @@ KSFT_DISRUPTIVE = True
>      pass
>  
>  
> +class KsftTerminate(KeyboardInterrupt):
> +    pass
> +
> +
>  def ksft_pr(*objs, **kwargs):
>      print("#", *objs, **kwargs)
>  
> @@ -193,6 +198,19 @@ KSFT_DISRUPTIVE = True
>      return env
>  
>  
> +term_cnt = 0
> +

A bit ugly to initialize this here. Also, it already is initialized
below.

> +def _ksft_intr(signum, frame):
> +    # ksft runner.sh sends 2 SIGTERMs in a row on a timeout
> +    # if we don't ignore the second one it will stop us from handling cleanup
> +    global term_cnt
> +    term_cnt += 1
> +    if term_cnt == 1:
> +        raise KsftTerminate()
> +    else:
> +        ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
> +
> +
>  def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
>      cases = cases or []
>  
> @@ -205,6 +223,10 @@ KSFT_DISRUPTIVE = True
>                      cases.append(value)
>                      break
>  
> +    global term_cnt
> +    term_cnt = 0
> +    prev_sigterm = signal.signal(signal.SIGTERM, _ksft_intr)
> +
>      totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
>  
>      print("TAP version 13")
> @@ -229,11 +251,12 @@ KSFT_DISRUPTIVE = True
>              cnt_key = 'xfail'
>          except BaseException as e:
>              stop |= isinstance(e, KeyboardInterrupt)
> +            stop |= isinstance(e, KsftTerminate)
>              tb = traceback.format_exc()
>              for line in tb.strip().split('\n'):
>                  ksft_pr("Exception|", line)
>              if stop:
> -                ksft_pr("Stopping tests due to KeyboardInterrupt.")
> +                ksft_pr(f"Stopping tests due to {type(e).__name__}.")
>              KSFT_RESULT = False
>              cnt_key = 'fail'
>  
> @@ -248,6 +271,8 @@ KSFT_DISRUPTIVE = True
>          if stop:
>              break
>  
> +    signal.signal(signal.SIGTERM, prev_sigterm)
> +

Why is prev_sigterm saved and reassigned as handler here?

>      print(
>          f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
>      )
> -- 
> 2.49.0
> 



