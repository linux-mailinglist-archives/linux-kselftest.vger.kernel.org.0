Return-Path: <linux-kselftest+bounces-14479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E66941850
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9892B1F238C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6631898E4;
	Tue, 30 Jul 2024 16:20:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3819189503;
	Tue, 30 Jul 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356409; cv=none; b=FMBfq4Z7rQ1kUalERNAKAk2aKOxDGlQwy9NcYSRVHg/j2Bp9LAWsi7oG7ykkVZ014M/kdMQiVO5vukJFFDmuL+t5OjSOcyESlNFGXdiOw3inPKVytVsKpfNBbBiSLF/FCYJlx2feYgG5E8oRkMWxhkJlXYZXsCR55u6R54SYQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356409; c=relaxed/simple;
	bh=TY5iOr5tfwo4FDpYsZpKpOOmjcoiZSnJgzg7dklim0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzS/kBIrveRjreMv67I/TxUUpSUROf3xbTEls2URcAAe0Hz7Lt1YV852dtw1WJPxutrt10yd000zF4ygeB9qtxLYRxIjeMkdEPaDrIumOXIn9xnPeU1Be2rTi2hpdbDWY4HjJEcfG1hc4J6+4OFUyMwYbE5cZ488zkHoBrl+j9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so2985336a12.1;
        Tue, 30 Jul 2024 09:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356407; x=1722961207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEALnRPWK6uP6fkyvkVukOq/0JwVxe26FQ0nX7S8CUo=;
        b=Y+eu2FgrNGaT1IS9AHb1BHQymmSCI9C6Oro/HmYgMWK+xkaR5qTlPXBigEm8qEng/M
         JyS3l6RxG+KcfPwR94QHBwcrT5a0zrtRkXS/Pg3TDI6WdBAZfbHVub8oFcuucrBw2JJk
         J+IUcVvBYGVgsFJ3O67BoazuxZJF4xl72M2hInXGNanN+3ttLlBNxBRf+jXjCVaG6xf/
         kMuY/Sjw8LTXNo/xtWWwumYNTL1RYbJ1GZ4EqdMu0wVp5goOB6z/wvbJiC8Q0RmO4ysG
         2CJBNVDlxNMemSyfC0hhZLjEaD9IZrUXSPULIp71RdlGTXNJ/iN9XXzOuG2H8VtNjW7a
         DFjg==
X-Forwarded-Encrypted: i=1; AJvYcCWdRMUVqaTOwY5DqbKkzM7DPhULP0o8FD9fEWmYDV7FzX6tEYf/FVgQY4yRyPlDbbN5Hm+fz/fkEB9lDvo6NU2SBs4Arr+q72oiYrfs6dTD
X-Gm-Message-State: AOJu0Yx1cD8bQArGNo/vNG7K/UDPjfe2TY3Zr9aP1KQSsHnfpOm9BvAl
	Jru8jBjHPz0f/ibDF1psAVQcs/n9FMr2rH9Z8imAV/sccxpR+Uo=
X-Google-Smtp-Source: AGHT+IEq1aikRvq6hCXivmDQcj2a0BREWwj/jIUHVvE6+2Zu+63pQcpuKaAAm+jjW2OBDznoWxcsbw==
X-Received: by 2002:a05:6a20:9184:b0:1c2:9095:7382 with SMTP id adf61e73a8af0-1c4a14fe5d4mr9498821637.52.1722356406680;
        Tue, 30 Jul 2024 09:20:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm6241125b3a.180.2024.07.30.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:20:06 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:20:05 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Shuah Khan <shuah@kernel.org>,
	Joe Damato <jdamato@fastly.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: ksft: support marking tests
 as disruptive
Message-ID: <ZqkStZ9UHfcYBG9L@mini-arch>
References: <20240729221042.2700882-1-sdf@fomichev.me>
 <20240729221042.2700882-2-sdf@fomichev.me>
 <20240729190013.5b0743e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729190013.5b0743e7@kernel.org>

On 07/29, Jakub Kicinski wrote:
> On Mon, 29 Jul 2024 15:10:42 -0700 Stanislav Fomichev wrote:
> > +    parser = argparse.ArgumentParser()
> > +    parser.add_argument('--skip-disruptive', default=False, action='store_true', help='skip tests that might be disruptive (e.g. restart the interface)')
> > +    global KSFT_ARGS
> > +    KSFT_ARGS = parser.parse_args()
> 
> We pass all other args via env exports, I think we should stick to
> that, it's easier to integrate with external runners.
> 
> FWIW Mohsin is also adding VERBOSE=1 this way:
> https://lore.kernel.org/all/20240715030723.1768360-1-mohsin.bashr@gmail.com/

SG! The patch you reference is doing it in NetDrvEnv* but I'll probably
try to keep most of the code in 'core' ksft. So far I'm thinking about
adding some ksft_setup(env) to initialize that disruptive=yes/no state.
LMK if you prefer me to keep everything in NetDrvEnv instead (or wait
until I send out a v2 later today).

And thanks for the feedback on 1/2, will incorporate in the v2.

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a5e800b8f103..2b2a216bf108 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,6 +4,7 @@ import os
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
+from lib.py import ksft_setup
 from lib.py import cmd, ethtool, ip
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
@@ -30,6 +31,7 @@ from .remote import Remote
             if len(pair) != 2:
                 raise Exception("Can't parse configuration line:", full_file)
             env[pair[0]] = pair[1]
+    ksft_setup(env)
     return env



