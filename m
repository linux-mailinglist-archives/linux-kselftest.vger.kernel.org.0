Return-Path: <linux-kselftest+bounces-35772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C772CAE8198
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057FA169983
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537525D1E3;
	Wed, 25 Jun 2025 11:40:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7425CC57;
	Wed, 25 Jun 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851600; cv=none; b=OVR0/yyo+uC1W8WuFPZxKCTc0NMEwTyjDujN9yLGGdm02SGILyTg+/UJLiLTJb7KoYhR5E6iTBLW5KwZk3YjtUM6319bMC7UNFXXgHzg2fhbyIPyIJVfknSq5qt7XBbTQLNX2uDQGzxUSdNPONfeZvnhJb5IyYI8Sy6nUu1uiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851600; c=relaxed/simple;
	bh=JueEE3DvsRlhzkgHYcrS6DntXEIcD7ppBnuSS6iweH8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EOzmW4e+GEALrjxywcNsSye/4LJ7Zkx7xPZqAuIm9F8C1Bg8yxUg9OL9xqE1zbR1tcpPZrS+f2LqX8Z3v9v5ODwB9AzqZm/zoLL0k1Lt0tYcBl8WmUGIPTI0sXU8yJ8sYISNs9xgRGG36zrwq5FBwm6S5NcPg0wssXiT1TvfGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so160076866b.3;
        Wed, 25 Jun 2025 04:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851597; x=1751456397;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tke9wHtMirrgZTrW46kxPtXcVfyckiAgBOslrizVckQ=;
        b=XjKg3gXt/noIdtKx+0j4xzDVglfnYfTjBwxHOhJ9YkjRdSnMOe4QhSbgi7BjyOsY6B
         QnE/IX4GV66uIeNbh6h73ir8j9qbUPn4Z6P6F/RT5oNAwSX+wf+ygyF7mjz7EkURrK3c
         Li3PY3yH8tqB2Aeq47n3wIy4dC5L340odR20dAscwu6wENdkzI9Ft7o6UfJGB69XShFA
         4NhpTtdm0olIn2U7prDSZc19J3+QdInpTExhS3/XqacsPCYWpFiOx/YDT9HiKMtzhEUp
         W5v/xRv2upP1/fGqh7iZ0NiDClTcvwqxDRzeCjQ3ctAH4ZdcRlCGEGQdIRtN8oNqPr5d
         BOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv7WWodm63dbuGJF+Jqf7KpxyrEDh/hw97B9lKM2tN70I5Rgb4I4JBGvJBlv6Zsbxua3M=@vger.kernel.org, AJvYcCVD7nToB6sstvvnuBJfu1ubVCVBybeQKkBinQfVNCFvOkk0ZpM9prJI4Rj/hxN6ZyeBmxs39ig5@vger.kernel.org, AJvYcCVqFqwlU8H1BKsujdaue8qmsWjHdWohYrJ70Bc3nQwPQuuoH+NjQm54RhnRsoW/UDbP52j6KpxQEeDQ6wnyStqg@vger.kernel.org
X-Gm-Message-State: AOJu0YxbT2Kms5qJNlXWfdtwCUNPF8WBpmvlmA0v3QEpLeLiMEQmwWJx
	ZLoGgTYXdbNm1oOg+7JYAPtK67po7ugPmcqoBsqIQDzU93rt22Aj5yiX
X-Gm-Gg: ASbGncsJQ/RNXyYnp7BAn1c8IkrzMEq/LxpkLqJo2/1WiuvfoqoPJh+ihaAnE+3U+p2
	Aj0VkeyMDov/1b6UZNHww6IySILA1Ra5M/WZi/jnPbehCo5GUj2ujwKDvg/cuQ4Xvvv212vb2g9
	lbynJEMn5FQk+KJcfZWwkTc9y0RSoJQOnNhs046ZS4wOjVhoJee1X617/TX2RLb+Rjr5f+i2BpG
	Rjl2gWkyg3JNidVtOnJFFvqqvO/jvOmIYw2GdLxxpEoW3LOr7Alm6PnhxOfjM5uNmi99myBtZ3q
	Ohtc5ju7r1UrBKCmQXHF6XNYmHyqwTqBe9jhiFa+GGOMmrXe4Lew
X-Google-Smtp-Source: AGHT+IGZ0XGE56v7BJE/3UHKyOECHehXbeb/ARdCR/GegdkD3+9DI8Bp+zDWzUBcx8AnigpH4wx5YQ==
X-Received: by 2002:a17:906:b218:b0:ad4:d00f:b4ca with SMTP id a640c23a62f3a-ae0bea5247dmr219952966b.50.1750851596458;
        Wed, 25 Jun 2025 04:39:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b742dsm1036234666b.132.2025.06.25.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:39:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/4] selftest: net: Add selftest for netpoll
Date: Wed, 25 Jun 2025 04:39:45 -0700
Message-Id: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHgW2gC/22NQQqDMBAAvxL2bEqyUaOe+o8ixZqNBiRKEsQi/
 r3UXnrwPMzMDpGCowgN2yHQ6qKbPTQMMwb92PmBuDPQMECBhSglck9pmafpmSgm3kmFuUFR6L6
 CjMESyLrtzD3AU+KetgRtxmB0Mc3hfX5WefLr5Cq55LnWuTV1UStl74ZervO3OQzfxc9CcWEVo
 qwqhVaj7f+t9jiODzkU2S/pAAAA
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 gustavold@gmail.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=leitao@debian.org;
 h=from:subject:message-id; bh=JueEE3DvsRlhzkgHYcrS6DntXEIcD7ppBnuSS6iweH8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoW+AK55EFUm8sEunfZvyXeiRnAjOaFs836CxmX
 Ls9DeQ9zkCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFvgCgAKCRA1o5Of/Hh3
 bfL1D/9YAwJcn5Dvs8NppODXm/5QfmP4drwRgJDqiWYS1AcVfprHPC1LXT5GEOPVa74miWa5QD4
 4IwfBFvUP63a/RF1PlQX814VMSGaCdJ67uivXFdBmWIyy+UyAzuqGLyc8aIQwDRIDNzuBjQFL0L
 7zvQsElRbLpzJie0wnFujxlKHpHA3iewXyzT52yB6konhNBQcmJj1o5Sgkc696PH1jv2sSccrhw
 kQ14zpfYQvumsgP6PgbL78WJqRa6jEliADfsdgOTrt8bJhak6ZLK/TkEbni0Zzof5w/hKjvzbmg
 iS0+WOL2qad75NvSvRhbblirp2+OcThahIq5wwrluP+6iwuVnf27tHxKJ+M8goVUOIavTEjJcTc
 iLro6WgiYnqicQjozp9s+JJAMZKkqLKsj/39yefVgM6unSRjrJZPyTf5mVCMAdZ9McZn5r3GGWj
 01vkUiUOg1X7YQ/7W0/G+bUurCiYrHcQEVFNiGzI7NF5QBiWmILwhNN6dbPXIeMF0XK9EqS9sN8
 QuvC95m55jh0RLDC2eTPndgY2lVofmwZw2sCAqrBokXHtXAk+BN96DcY3n9og4PKKa1YYaRTcBk
 VHDWjIEw5njYfImFZwtpjTPtllogLiJgnu9csc9ZGHkC9qwK9fij/PMzffaMMVSybIhkpTvcoQ/
 In3Ma/7HL1H9Bug==
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
Changes in v1 (from RFC):
- Toggle the netconsole interfaces up and down after 5 iterations.
- Moved the traffic check under DEBUG (Willem de Bruijn).
- Bumped the iterations to 20 given it runs faster now.
- Link to the RFC: https://lore.kernel.org/r/20250612-netpoll_test-v1-1-4774fd95933f@debian.org

---
Changes in v2:
- Stole Jakub's helper to run bpftrace
- Removed the DEBUG option and moved logs to logging
- Change the code to have a higher chance of calling netpoll_poll_dev().
  In my current configuration, it is hitting multiple times during the
  test.
- Save and restore TX/RX queue size (Jakub)
- Link to v1: https://lore.kernel.org/r/20250620-netpoll_test-v1-1-5068832f72fc@debian.org

---
Breno Leitao (3):
      selftests: drv-net: Improve bpftrace utility error handling
      selftests: drv-net: Strip '@' prefix from bpftrace map keys
      selftests: net: add netpoll basic functionality test

Jakub Kicinski (1):
      selftests: drv-net: add helper/wrapper for bpftrace

 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/netpoll_basic.py | 344 +++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  38 +++
 3 files changed, 383 insertions(+)
---
base-commit: eb4c27edb4d8dbfbdcc7bc03e0394a0fab8af7d5
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


