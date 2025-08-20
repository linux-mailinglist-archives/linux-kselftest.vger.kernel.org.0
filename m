Return-Path: <linux-kselftest+bounces-39369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAEDB2DBDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138D21C206DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3532E62B9;
	Wed, 20 Aug 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPDCSZYG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7E2356B9
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691023; cv=none; b=aQKSRf0J1pMlOeyZXm+HgK8Uu1QTfjmAJbPapVB8b2+YFxYAqDEtgD82iV/gLr5LOJhImgpAYvW5lqRmTL48wHZfoLI3Hoc9jrSSE/PUDCEmYS0EeTN3FArENrvpMtL8qXkCGzguubmgG9Ncw4TR7/RNq2dFzoAFrJQ4nQ4S3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691023; c=relaxed/simple;
	bh=cYaIwa7OKDucApKeRVWCFfec6pzGvS4Cc/Uc55pPyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtnllh0FcdNko4XyQnG+FYc94VZGw/tBy758UsKdL4u3+6dwT34sP6whQHOGB7r+cEWUEO02UbcuyxrH2jPwF0Fdv5pwkn+E356UoQudo8JVUc/NuMZqLA+kS8RBn0cKgP4R/K4QgljIWAm/YA5N9AH2nT3NyEG4VZ4DFxd6GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPDCSZYG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78d5e74so1099797266b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755691019; x=1756295819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moCsdLjCmUX6PvbdLzVPGIybOfeYotWGYwXLJgkQHp4=;
        b=MPDCSZYGKuKjPbnTkoV2UzJdGYHBV/gjr5NN+Hh2NJeWhxnSVRMER+ZnJILmq4cv5s
         YzZxzb5l4RNEZ+BBKjMIEzSlmkLcjMk3NHIbentsmMGy6Sh2NycfCwqD+CLIOgrJRVs6
         NZWYZg6AwgJWuEcZ3BPTbwrYN7cMdofXR1Qeono7tiu9qzHjpgez87aFb785knM3byLv
         XmWgFOes8k3Beoaag1erxCwtR6o1u3aTGtnNpSNSXAUtkhctZyfjENbdkg5mmC5uYENs
         uEQkFnuVI6rxSkgzPlFndpF3kQeaRdcDWodaahdBWd3CR/GZk2tFV6JDR7tlWcPP/VqS
         06Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755691019; x=1756295819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moCsdLjCmUX6PvbdLzVPGIybOfeYotWGYwXLJgkQHp4=;
        b=cW6jGU+xuEy2sxsarlsmzZoW2/bYmRmGeP5icJpBZMGq/r6I9cYgLxOIpfvI8t4zjl
         bFVnodxqD3shiZDa8MchGHQE8sfsngMMQWKbmtitkX4hH9Vavw19fHKevbfNC84wtvA3
         hplc84WX648hdL1rEvBWKynUfq48It5bIiFfQzeFVE+/P9lQxXZVsE6RE3sk8bE6YZyC
         c1LjgE7sa5hPiBIM5fwMeTBeKCY+QXBKY6ND3goQPekT5VHe/LWiBPL5PztKUDMP33sp
         7UYgscOJwjObo6+/6DLYMd19i5EpoBexoMXipv1uvQ7hIUpNuoVRUnfp51Itd5FJ8wef
         skRg==
X-Forwarded-Encrypted: i=1; AJvYcCWZYGRuJqwZHTpbNTH8YSJ1xg/YbARmKu5t3MaMwnUS7IsYBpOHhnOZlCN8FlxG5DeRTmORh1+LsyNRk/CUpcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwVOc7+0EKv9c3pjoI8nqooSht+Io5HcVLq4py6Ez1YVvWnqz
	Pb2gZGLmamZYORTWE0WQD+75VVkUCxYuLX9366PGgyV0z6iqRlUQFEVDojpYa/HjsBs=
X-Gm-Gg: ASbGncs0OFk/XfruCDVwloFjkZ3vHEmjBjEq3lcESQCsf79m1nI+mwsj6LSheWYd3V1
	oEMzgPnbRg1AmM66mvcvwmZg7I9zaVhz/lgVcJraeUdTlmgecVXP3ClmBmw6seY1hDMKGTPjmdf
	Pb/EwjkFaKDQ7nvk3vepaKkFgTzGOt5SwtVji67OEvLtr/WPyY4guA1uNM4jyQyNB8/jCPd4WEf
	rgr/FI0gEdCxIxn02uazlyXCACnkKBUg8GXyaO33SGcPXQtpvEA/esJ9R0MU+PNYFJnduhCUbig
	l+IXf42gLCFTsOpnkyH54WQNrAX0Nvy082d9YJnTt5tBlwyjn9GgqT0PeiZM8cufGqI8h8sZJpA
	DwIxl6+ugheqiBv83MvpsUJC2ysbs4fpjrBhk
X-Google-Smtp-Source: AGHT+IH8jGgP7Yi06FTb3TEFxWNfS8BaL6kBNZrhzOIwS6IMpjYfsgVAKJNdI/w7l343iLu7BzJvvw==
X-Received: by 2002:a17:906:7313:b0:af9:e1f0:cd15 with SMTP id a640c23a62f3a-afdf00a90e5mr214610866b.18.1755691019015;
        Wed, 20 Aug 2025 04:56:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2badcdsm167984366b.21.2025.08.20.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:56:58 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:56:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] selftests/livepatch: Ignore NO_SUPPORT line in dmesg
Message-ID: <aKW4CApORh7o73nz@pathway.suse.cz>
References: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>

On Tue 2025-08-19 14:37:01, Ricardo B. Marlière wrote:
> Some systems might disable unloading a livepatch and when running tests on
> them they fail like the following:
> 
> $ ./run_kselftest.sh -c livepatch
>   TAP version 13
>   1..8
>   # selftests: livepatch: test-livepatch.sh
>   # TEST: basic function patching ... not ok
>   #
>   # --- expected
>   # +++ result
>   # @@ -5,6 +5,7 @@ livepatch: 'test_klp_livepatch': starting
>   #  livepatch: 'test_klp_livepatch': completing patching transition
>   #  livepatch: 'test_klp_livepatch': patching complete
>   #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>   # +livepatch: attempt to disable live patch test_klp_livepatch, setting
>   NO_SUPPORT taint flag
>   #  livepatch: 'test_klp_livepatch': initializing unpatching transition
>   #  livepatch: 'test_klp_livepatch': starting unpatching transition
>   #  livepatch: 'test_klp_livepatch': completing unpatching transition
>   #
>   # ERROR: livepatch kselftest(s) failed

This seems to be a SUSE-specific feature. The upstream kernel does not
even know the NO_SUPPORT taint flag.

This patch is not for upstream. But we should add it into SUSE
kernel sources.

Best Regards,
Petr

