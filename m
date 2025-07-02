Return-Path: <linux-kselftest+bounces-36310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BBAF13A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB83A8DB5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73F26658A;
	Wed,  2 Jul 2025 11:21:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935E265CB6;
	Wed,  2 Jul 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455271; cv=none; b=Qzkia5Cl+lKMYMtoDK5oM4rHmkgUjgmkcdUi2tjqLTofw/Jb5zXQve3jvc5OzWbAJMsxAwTeFthZ9XUz1Ve7sz/2zKhnzncOx7VNxayXOz1FL8BW9AApBg6pe3uXXrhOwxzX3ItdLGpN80KSFNGQPIM0PrOB+jfopZwYnfWKVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455271; c=relaxed/simple;
	bh=Oa6I4J+3EiaoitoMqlxxWZcodweGnrQkOFGVcWo9wc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fToS4eztKgFi34u3jI8X3WlYi95BhmkRZEcUXlovbl2zk0XAyGoBpQEvv4sYF58s/HXJmLzlptps0Hgs0U/uYeOeKI1VwZQzRU8x3pMLd0z5pS7BKZjuTaUCCrpV+qYMPgI2laRWSbLQf8MHxMa+b+2MOfkPQe170edKG9ODh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so8851259a12.0;
        Wed, 02 Jul 2025 04:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455268; x=1752060068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwOadImlG8DTWZnqLfHAUYeQtgglNV2hsUFUVDivTSA=;
        b=NIgs67d3N16U1C1rXBouemb4jVh5nGGKi9fEPif8Llcgh5N+tnfgvFiPFIFRwOWeeG
         p9Tw468AKzFvzWTFt3snKKXCXNTEAM2HdGQIRdpFo6FJSEBr4eZE6kWSJg793jJzl8cL
         L12rasS0OYg23IHQ57HSofIptOSH2X2DKMnZLjQHStCXIvTyH2tSu+XgZqmYy94QB7tx
         N12mhyp5mNL54IkCxPL1vZzaOhj8/DohM9KaA/A41OkzXcMC5y/7EDeDoJxA5Hdf+Ove
         IvbIGO2g/BBTiKy8v6uz/9fMa0JmTH/S14SfetsfTwa2Q31k9aGSSzqqqTA4um0kNEmC
         K8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFHevD70wEh+FnNoGcMm3jzTVJA2v3U07t5s2E7JaiItBWrvfmWwDO84wwtTtiKnKTsh0//lbGMix52gOGUhdL@vger.kernel.org, AJvYcCVTWYfBFD2XLWVYVAdHulIdSOjE79gOTOm7fQvaDhtoXWHRORUGbio7jNWPwRXUB/Tv0ew=@vger.kernel.org, AJvYcCWKdlPjYPdkpMqJwToogfJrVlo4+kDnw5K1qjrs67YbGf50uXn65CCtAMqeVwlULfc1/XLa84uo@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUF6trvOgZ6D/AZ53MDccW0aQ5t4BfqbGfTp5czD+MSZDdABL
	6MgO95KLK/G/eCPZzG/0ZIhjRMAl02aGLU0m7XIQOLZF2hi7Et8ElC4D
X-Gm-Gg: ASbGncuc+txEzgN8V5RzwmgqUKOn+2GG3dQYKsEdn1yXRWBMFziPG9o6ituHLppHQeL
	NHf/XVPxSVvLGH01kWL0xe6wiw1uYKC0VCDyhdmLTtmeJctKFur9B9VH7ckew1s6Hy2LSqcRJas
	oNbk7Wt+4vWF/bqQzhUO7h9wY1pkfVZZmTAPk4+DKL0LWCyQZOz1rcETWZGhMVZLjhKVZPsBGdP
	XQjJP+8Zqnn1Ov+El7jKjVYKt9MOFxgrD2XVsrDYrX5oxVF+767aqfRF3JA/orZbtLOIKPZ/z4g
	gNdb+kBGOtDrCWcbp0Nc5UyhgA29Rbe6Y+Bd46N9UxkvrFwOb0CL
X-Google-Smtp-Source: AGHT+IFvAijHC5To3z3TZw8XM7+z0rJfgERCs2qkqWCxTbZD6N1lkZgCDi9PpgZtH0wfmFxOoiXqxg==
X-Received: by 2002:a05:6402:3550:b0:609:aa85:8d78 with SMTP id 4fb4d7f45d1cf-60e52cc4800mr2040323a12.8.1751455267772;
        Wed, 02 Jul 2025 04:21:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831aa9d0sm9333912a12.46.2025.07.02.04.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:21:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/3] selftest: net: Add selftest for netpoll
Date: Wed, 02 Jul 2025 04:20:59 -0700
Message-Id: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABsWZWgC/23NQWrDMBCF4auIWXuKPJIytle9RynFsUaJIMhBE
 iYl+O4l7sZNs358779DkRylwKDukGWJJc4JBmUbBdN5TCfB6GFQQJqcPrSESep1vly+qpSKY2v
 IetKOpw4aBdcsId62uw9IUjHJrcJno+AcS53z99ZZ2m1/fbm02KJltsH3rjcmvHs5xjG9zfn0S
 Pwq0i+U04euMxSYwrRXj/5Cuya5J02o0bInZnZE9F+bveYnbVCjY3f0pPXUjf0fva7rD6DotUt
 lAQAA
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3228; i=leitao@debian.org;
 h=from:subject:message-id; bh=Oa6I4J+3EiaoitoMqlxxWZcodweGnrQkOFGVcWo9wc4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZRYiCCzdTww05PHSPGEQ3RsBQGB1aNhF4dwTQ
 O8dDRUldtaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUWIgAKCRA1o5Of/Hh3
 bVNKEACIjYWP/95e6ctiGaabivMqrcbUw4TRMCHeKwFUpED6VJRSaldn/4Ie6mkfq9UUuasCmk3
 kkX8ETD9PqYdHVWa5nb5bSPhc7yDc3VQolvRu5hu97HDadZWRqVxdOjIAB3xYavnmQ2GXG4XDms
 rX5+ABYkWJ8dXzXdoatuKngk3g38FAMk4In9erUNCAL9UMmpSmhQ0lpFISBmhJFB/tweXfVkhZG
 4a5nZ+KpGnS3s996/tJKdJlMiVARwXrRr7CYH2pdlfawa5zlAMFz4k8C0Sxj0M2c7kf+d5/iWKg
 qCYAvxMA4RsXf9vJFm/96ued6abvQMxoY2qhWvxz6pPoOv8JjWl3bxUJ71at69kvt2pGcYYo3zQ
 0KSyP68Sqz6fmGfqkXCElOTt7XZ5NUV/DHICNxUpQnoGVS15ON+C2u283YnEbXhQd+WGwQLGHkT
 a58sBHC9aL8TLmgngE14foDYbu9E13d/VA+AAwH5Sq+1DvK5apBFU+L+ohPozT65PB1uqsOX7pR
 olI6ucsXl4ERZyAMcfy0UMw0DAs6vgrT8msv8thKy3F39WcY8yfrx8C8Nzn4zzoWFcOplrz5Bjb
 GBLdbuHCU2W1B942cmH9DeNMMwnPOFy5acVPJ8Q6IooT1oQ5ZiVuXZzRCxS32DqXqOJVzhWyCBx
 jSMjIlowG+1Oo2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I am submitting a new selftest for the netpoll subsystem specifically
targeting the case where the RX is polling in the TX path, which is
a case that we don't have any test in the tree today. This is done when
netpoll_poll_dev() called, and this test creates a scenario when that is
probably.

The test does the following:

 1) Configuring a single RX/TX queue to increase contention on the
    interface.
 2) Generating background traffic to saturate the network, mimicking
    real-world congestion.
 3) Sending netconsole messages to trigger netpoll polling and monitor
    its behavior.
 4) Using dynamic netconsole targets via configfs, with the ability to
    delete and recreate targets during the test.
 5) Running bpftrace in parallel to verify that netpoll_poll_dev() is
    called when expected. If it is called, then the test passes,
    otherwise the test is marked as skipped.

In order to achieve it, I stole Jakub's bpftrace helper from [1], and
did some small changes that I found useful to use the helper.

So, this patchset basically contains:

 1) The code stolen from Jakub
 2) Improvements on bpftrace() helper 
 3) The selftest itself

Link: https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/ [1]

---
Changes in v4:
- Make the test XFail if it doesn't hit the function we are looking for
- Toggle the interface while the traffic is flowing.
- Bumped the number of messages from 10 to 40 per iterations.
   * This is hitting ~15 times per run on my vng test.
- Decreased the time from 15 seconds to 10 seconds, given that if
  it didn't hit the function in 10 seconds, 5 seconds extra will not
  help.
- Link to v3: https://lore.kernel.org/r/20250627-netpoll_test-v3-0-575bd200c8a9@debian.org

Changes in v3:
- Make pylint happy (Simon)
- Remove the unnecessary patch in bpftrace to raise an exception when it
  fails. (Jakub)
- Improved the bpftrace code (Willem)
- Stop sending messages if bpftrace is not alive anymore.
- Link to v2: https://lore.kernel.org/r/20250625-netpoll_test-v2-0-47d27775222c@debian.org

Changes in v2:
- Stole Jakub's helper to run bpftrace
- Removed the DEBUG option and moved logs to logging
- Change the code to have a higher chance of calling netpoll_poll_dev().
  In my current configuration, it is hitting multiple times during the
  test.
- Save and restore TX/RX queue size (Jakub)
- Link to v1: https://lore.kernel.org/r/20250620-netpoll_test-v1-1-5068832f72fc@debian.org

---
Breno Leitao (2):
      selftests: drv-net: Strip '@' prefix from bpftrace map keys
      selftests: net: add netpoll basic functionality test

Jakub Kicinski (1):
      selftests: drv-net: add helper/wrapper for bpftrace

 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/py/__init__.py       |   3 +-
 .../testing/selftests/drivers/net/netpoll_basic.py | 365 +++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  35 ++
 4 files changed, 403 insertions(+), 1 deletion(-)
---
base-commit: 22e1cfda0f612556f116560d2b7e9c3315636bfb
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


