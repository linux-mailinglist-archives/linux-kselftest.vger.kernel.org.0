Return-Path: <linux-kselftest+bounces-36804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EDEAFE393
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08DE4E3173
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D5283CBE;
	Wed,  9 Jul 2025 09:08:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9878F36;
	Wed,  9 Jul 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052113; cv=none; b=D73BcvKzn0SquRFSpjJ3be6eTyaYEi31ScfYth24hK/N2jQMXx1Hn4QvkktHRQScaUg1pPGUFVH6ijrcj3Vbd0b1bGMxrO1+CuBkp52Tc+scvb+Fj0TiFGJSm50cOdOKAHGf++5eJpEjIa83iqHdElEX1HDLMxsi+dC51jafDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052113; c=relaxed/simple;
	bh=4oP/BxQ13aamcUJCA30PvuCdZJb618zDuY0b6VNikI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R3BLYBNXSEqUt+s7OUCEt4WYrKC7ar2AszMfoL8s/98Cs8DVbNlXoqy7IGWIAs2FOB1OSo8/xIjfqgYQxWXH8N/R4C0VhoufthAysho9GfxCWBlGy9vcwprWMD4w6tp7Nv1XtuFWhJGIW9j8yBVd7htxUlAcpXkKOYo5GHGM2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8618190a12.1;
        Wed, 09 Jul 2025 02:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052110; x=1752656910;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSsTwFQE4LJ67DmF/fgc6P+/sHFKlTuTrdiV4mhoHyE=;
        b=MkJ27OeTUYH1/oEjNWotgHzKm2qaib7zA5jIsKNDX8wv/+dO8msBSSsLKDkIqmbfAP
         EcSYBzO/P29nV7E15460ySPlSVus7L2gKORhUXKhQdWxmNmNaM8fcgBR9Zwl7D+KtMFo
         /qaRTJm0JIN7MqRWPi+uz6bfpL80wg9AqjQeayqOoPxUYht3SpqxtMS2fh2gvOiYXmok
         6iCG1fdPB6t6EiLF8/qNQ6Csji176ojxpeechSSqnzH5P6PHQIEU7ttdxdbABtpmifEM
         +YRy3mLJS8LtW63RK+z/xzv7/V15zUc3PfjXFgmUQ9xSVAbKMK+j1K8sHa+y5Cge9snC
         gSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/pZx4ZgGkNSz6gL2VOcUCTYTm4II2wHK366YEtRS/+laNQmjrkw/fepKB28WaigvZ+shsn/o29GDyi205H96@vger.kernel.org, AJvYcCWXDs0hZE+m4iV4MpK0ukhRlwMgfmoTnoq4HdOvoHF/Lbz9qB7ART5FqA41PlA1nshdjS0=@vger.kernel.org, AJvYcCWoGsJ9oUg9cWfcw3NLx6I+Hv8zzI9xoeiHnx2sQ+YH0qFJxShUiycLOH4s7J6kvjvziAcc9LaV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8bLbu4Ou3CMJ/QZOxDhbjiWk4R6EcLqXRaYOlEOhDnbnOi++
	3xfzzqk0upqPtKezGNlTFuRXb/KbIaTYVFCj3PiwRxkkVsvtc+Ubu1jQ9tAnxg==
X-Gm-Gg: ASbGncsxjl5XTfFwRsR1OP0BJg7lACHAgdFumMfMYpSwPyJphc+4D8eknnLPRXeqOao
	V+b6x/7zQ9baRL3vxlME9wrF9AjLUAa4Sp/tMAJCkcTB14bC2tN+Fm4J6+jYuCv6kufKtTetWbr
	1nLwz8CsrvUvwp8QCqhn5LkjDuq4B7KHxQXygOuPHZlIOMaKmQDH3mNEV5KNLX2tZwx+edrLeXM
	C2qYYuqVb74SKwl1jlj89s2wl59TrHqTP0RrVY/KFYoXsCZlX9vRrn7lUpAbe9ALBvxcVAfxz6j
	VbMgR8wAtIJ6XliwvwIH7vfLFdOMTAnLFkZx7yK8mqENPn3p+kiCnQ==
X-Google-Smtp-Source: AGHT+IFVKDXRSM/7QlhW8X/iY/vWLuI93QWpeJcbvGgdIWUfRuFXIxogGi5q4e81CMsYHkVbjNqP/Q==
X-Received: by 2002:a05:6402:40c5:b0:606:df70:7aa2 with SMTP id 4fb4d7f45d1cf-611a6f3ef46mr1239856a12.31.1752052109427;
        Wed, 09 Jul 2025 02:08:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c790dsm8538029a12.37.2025.07.09.02.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:08:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v5 0/3] selftest: net: Add selftest for netpoll
Date: Wed, 09 Jul 2025 02:08:14 -0700
Message-Id: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4xbmgC/23PwYqDMBDG8VcJc3aWOEkc9bTvsSzFJmMbKLFok
 C7Fdy91D+vanoff92fuMMkYZYJW3WGUOU5xSNAqVyjw5y6dBGOAVgFpcroqCZPk63C5HLJMGbv
 SkA2kHfsaCgXXUfp4W+e+IEnGJLcM34WCc5zyMP6snblc7+8n5xJLtMy2D41rjOk/gxxjlz6G8
 fRM/CrSb5TTVV0b6pl6v1XP/kybJrmdJtRoORAzOyJ61WareacNanTsjoG09nXXvGj7p1nv/7W
 o0YsnYqldZf7rZVke7/8wVKMBAAA=
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3426; i=leitao@debian.org;
 h=from:subject:message-id; bh=4oP/BxQ13aamcUJCA30PvuCdZJb618zDuY0b6VNikI0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBobjGLCka0PhRapUGcKAOYG1LziuVAG+bSZzBNR
 vK/d940zuKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaG4xiwAKCRA1o5Of/Hh3
 bUuOD/46pfHqzsum11VFl4bHz3EmIf5Dwg8DsZPZsAuqvip1bLcVfgSH4wpZ07vLUdZRZLLdZ/K
 NIh1jMAGzcHv9n0GAFmYT3jwVcrRtg2xNtoNE2Mx3YGub0sgz5ZXhVkWRA3hE5AGfLKx2H4BYbw
 yhWeduw2rKPc3Yhe0Z7KooV1qD1phFlKSKREIRYGFmOsHScDNupY09uvSST1qRQIDIv1z4Eh+d8
 xo7o1dk2JU9zEA1VxWiYTisRL6NVlvtd5uqnCPShchCsp777rCZobe0CLVY2zL1IF0ytwsYqs85
 JZldcuzYgOBX1cUd2lBAEfHtd03S4YEli4WnnSJwGkNhPA/YRIaAlkkEoTkcPduzVQyllwCd4Iz
 Y+35U7+HMspMDI0KC89BlWnke+OcrtURmNdU4Ek1pe1T8VWbNVMZFuhRvruYj/uIm9d1GosGEK3
 okIZhv0yIHRGQZxk3crKWAM9Bydhtg/UiyzDKqDQt4b5n/MHf4s35wN8EYLG09ybn4yhESTXNXP
 RraYAXU2WJ1objji3zIsmGdKuWMQ/FIsQo8QnYeejv3p7jIt4KG+S2kAPsjmmYsTewHicwiROdm
 CuFhbjdbZcahKGDdRycem9Jt7VfzkLEfgXoDJIpmq6WV3pcqVfmMz7LaE0h6f6qUr2LYlaT24GH
 vAWWBTXY2+bpOWA==
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
Changes in v5:
- Rebased on top of net-next.
- Calling bpftrace_stop using the defer helper. (Willem)
- Link to v4: https://lore.kernel.org/r/20250702-netpoll_test-v4-0-cec227e85639@debian.org

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
 .../testing/selftests/drivers/net/netpoll_basic.py | 366 +++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  35 ++
 4 files changed, 404 insertions(+), 1 deletion(-)
---
base-commit: 0234362d0af4649bc2ff745e94d06d0c6f0a46ce
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


