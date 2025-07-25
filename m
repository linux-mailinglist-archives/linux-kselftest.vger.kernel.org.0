Return-Path: <linux-kselftest+bounces-38012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED099B1260C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 23:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D743E1888F43
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084B25D216;
	Fri, 25 Jul 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5JPWyFB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B4DDA9;
	Fri, 25 Jul 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477912; cv=none; b=tWqxgWPcf5/VyCDdRPi81Lr4iAXPVtpRnlnbhWAowdrPTtP5GKDhv1L8vMtjJUvLV8tX8rkWmgijctAXB2V5FINHXXkOXtwznwgsUCNfkQUzgqyVg5nYpK/fZ7d84PvXJwxXpgroFPwJSoYt823xFzWE6RWsFb79EL+gH92zlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477912; c=relaxed/simple;
	bh=iPntpkN5s9nm/kwmyNW7/VQUJGr7X2cHZpVGCRpZHvM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hSoWrwS+bUxJGw+GvhJ/XKJ4uOCUnvF12XYpeasFz1ZPXxuEJpPJoD2tbqoBDHrmiW1pQ1roKh9JQLfbG1tYjSPlr+pOU2usJvVMFQlUs57q0BQDzrz420VE3L0AypqupIjnamIUJmMEWmZ4wK05yrw54lgqM/F6oB4Je16WC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5JPWyFB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7115e32802bso21071737b3.1;
        Fri, 25 Jul 2025 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753477909; x=1754082709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdqOqIb0Bsc0iPEAfHlc33CmH07FCmyzWixSo0X/0wI=;
        b=H5JPWyFBLmjoA8efxvAA27LtfvPcrmyV3UQcAkVgGtn4Og8hvlHZKbVpNeJCYGIPfk
         tSZHaddUCZb/Lvab0GCK0/T4LI5yesgVkkLfWTYckCHBAhaMR2KvzB4iU340wuFWTUIF
         3K+Aqt4uPNRZqE4WLd/IOhwdfsjVQJFnv/9hOaWgHbJGnGiBpWS2SuJWYyAt0n+KONlO
         7kl3ms1yhuJbgiOkhb52c3Ob4Gogp0N+Cvz62FnYYZE7ZhAoCQvl8Ulq7xBUZ8QhMFAk
         l2uTZtD23fypT4hQJgJoSE7uj1OInvwpAA0sGHkuGgLYW/EwDJtqaO8aQ0mVRdMybC1E
         UmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753477909; x=1754082709;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdqOqIb0Bsc0iPEAfHlc33CmH07FCmyzWixSo0X/0wI=;
        b=j33hdGSdnQfzOMBArjkdejlpq4Kmr7CbZsHbbzx61q6JoTLJKqwYtl80QB/Uzae0RI
         8Q4ZBUi4x8CatF/hZlZZTbawmtgmcSCCWVXFUTiUpQZyG3i2JaqZB6Tsf4fK/EBxRPiE
         TWrqTVNq8rFEPEBN5Mf3eIK/ATM9yyHKaz/tpfILREK503vMwrqhUPJPE0U/Z2KmVGIz
         vgwi/PVWAhVjtXHbm4zFnh7Zrcvd0Sxrrk0w2FKEVNLRpN3oXScSBD6UFNr3+xK5bv/9
         /ntbkumHjKifcL72O0lOAvBARsnR4m6YPGbCWg9L9Epp2B6VPsT9r3wGr402f0snKM1C
         jziw==
X-Forwarded-Encrypted: i=1; AJvYcCUY5a96L7v7CyVwf4bdrCwQCCA5wJRXd5auMKXh5mT+C6ikCZAvJQVLiZqto7eb8bsMK/VO2SJRN9NHOoMlfwin@vger.kernel.org, AJvYcCVyPrYbnDxpX1rhrxrmKjhYuQJOZM76qXH1ov19RMTRvKf25arREGmZmner2LU3HKP6Pgjortub3eCLzwA=@vger.kernel.org, AJvYcCW+8Hut7UUDCKBuMnsr2Obqs0YtEERrfHUY3M+5QF/SnTHUH/F3n/RYqu9MnQfekAktBsQ6hwK+@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0HEJjXqcJzB3zySas5mVlVYO+EcHg8sku6TAZqrd7Qr/aT/f
	CgfLX4WXcPAyVVyES6w28GFLogueLD7psmmH4IQQxJJPw4SWZsC1McFV
X-Gm-Gg: ASbGncug2I96hFq0Sdi87rOR3n3EVDklxvmay9PsWVoSAJn9IJUxcIq/d8BnoYaP1gT
	2VSMJkR9C+qASTFV69WzPLn6zZvpcX7w2G3H+rq385bNXl2DCi6F/M828+Dw7WefDghp8WkT6O3
	zGGk2NfWu3dzRnyoqwL4o8+IsQByUmyAq8YHiVTNKT42XDC+qTYgHIARW+KNUC724X6vxfKhrCe
	YLJsI02Gm3VebipFVcEDr/9OOy6X7vQCNSfdWDMaGS8kL8gnL5VDHOLBOmIS81Ocvo2YgtPg7sE
	2LxxQF/MpdtsoiWN/zkr8OQ8CdaWnLFBwMyQTPPD7etJbXHreNLIgQ5wpnY8ctv39wERRxYTVdu
	j6s8KwHcLAsERovZlCGEaml9wCH52jFqgDNQqMHq0hmvLIfa73lDhIrvB1dOfOxN7oymD/w==
X-Google-Smtp-Source: AGHT+IHFX0QKQh1xLtmHqt4hOrEJp6y1p7TYcXr28uaLfMhJPkaiR9STb8aOvzmtBOjaVFmJZ8G3Ig==
X-Received: by 2002:a05:690c:fc1:b0:709:1b68:9f5c with SMTP id 00721157ae682-719e32c0f97mr48634007b3.16.1753477909554;
        Fri, 25 Jul 2025 14:11:49 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719f23b39fdsm1543597b3.60.2025.07.25.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 14:11:48 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:11:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
Message-ID: <6883f3146d073_d14929462@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250725135856.6854f2a5@kernel.org>
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
 <20250724182427.5ece92e8@kernel.org>
 <eutsqoc6f7xcaez2ttuce4uqtfvs3hyit6dradikvfcgxdev75@3senqada4nzn>
 <6883ed7aed06f_3f184b294c5@willemb.c.googlers.com.notmuch>
 <20250725135856.6854f2a5@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
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
> On Fri, 25 Jul 2025 16:47:54 -0400 Willem de Bruijn wrote:
> > Less opinionated: the tests implicitly depends on the config files
> > in the test directory. Do we have to start making the robust against
> > situations where CONFIGs in that file are missing?
> 
> I was considering adding something like this to the test guidance.
> 
>   ### Ensure necessary kernel config knobs are set
> 
>   Each test directory has a `config` file listing which kernel
>   configuration options the tests depend on. This file must be kept
>   up to date, our CIs build minimal kernels for each test group. 
> 
>   Adding checks inside the tests to validate that the necessary kernel
>   configs are enabled is discouraged. The test author may include such
>   checks, but standalone patches to make tests compatible e.g. with 
>   distro kernel configs are unlikely to be accepted.
> 
> WDYT?
> 
> Primarily trying to minimize the number of patches and adjustments 
> we'd see, as the matrix of systems and kernel configs can easily get
> out of hand..

This is great!

It's not really feasible to maintain tests with arbitrary missing
dependencies.

