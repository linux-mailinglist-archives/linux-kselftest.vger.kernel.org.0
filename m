Return-Path: <linux-kselftest+bounces-34599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D737AD3CCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A4E1776F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D023F431;
	Tue, 10 Jun 2025 15:18:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D523E32D;
	Tue, 10 Jun 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568707; cv=none; b=QhdJYrsLN0FuCRYA3gWt9bqOdQrQBAwKP+IfdBzc7pyxmbhc0lSdSm8zClDaFB0iTwR5r3xhfNPlDR4NUN0G4YsVALxKNs9SMVS0fSRuaBIn0YrJZ19l6Et0nzipHLu/qnkPsDzAbdSLsU+SH8oqID5PU39GIt1+qTIG7XNGvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568707; c=relaxed/simple;
	bh=VzoLQyE4wl6OHnhW3cdOsqTAdS7RUvOcmDCMwL7brDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t4s/EDx14BFyhQsg+O6zUdnQduwdshD64CGwbeoFUyk8+zUiNRxG4a+PUiGanubNmpis9YgcPFbdRUOkb0dQOB464qcpx1Gv42znLtISDFARFCqh1QKbhpKeXbmB4783ZGumVryTKW66mamLP0k4N3wb6b2AswywzdZC4w9xPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so818218466b.0;
        Tue, 10 Jun 2025 08:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568704; x=1750173504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irqUA8MmTfr+t8bn/uEmRMXvR9i+NTIZlr/iv1nvdzA=;
        b=DvJs6p7Wi6v/og9hAo+yAo6T+wKefDs/iv1o9MOrq5FGOHsVt0EHmp/OZ0I2dFneVf
         3uFGPqNkezwJ7ng2ESuLfn7hL/8TCXsZHkFR0t3FJBc4FZCYGQdOQSYYABmZ7GN9XPjy
         T7RXRFjToN9nFAD/8XpMe+/8wohZ0U6V+b+SIU6FilMxr3rAHnyvH2Lr3bcCAj3UvB/J
         CDbkQfBTcq6Tx9CJIOczJ5oLqypTuyaBA6fojGFJy+zM4wanZRAO893He4S4mn+8DQog
         xzobGd7BvKH9BuAyJnjCPCvX5RGY0HDVcxCcy7Rx4Y53QMrFIY1UUwqHTfvCKsMW/dir
         56cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkguM5b5tbrM4b/LKk0klqj3/oqu27YbaOpTGyX/f2+oVxyllaNJN66p7whHFUd4zwMKqVoE2f2m5naJM=@vger.kernel.org, AJvYcCXEo09soMAQu/+DAVwOY1UrsD2FkIhFNpX2VOuUtfJ5JwmZPr4xopQWg8KnOPjNO9L3n5cnBccnMoSoHtSAQZCQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqe55bhGj2CMPyeWFbmiKP8IrGRnz+Arm6DFHC3VRkjep9jP2
	kxGjIHUvmFibr9K5wjq5hwQiUSOojGrUCTsyqa0uV3S5jYW8/+HPR2xV
X-Gm-Gg: ASbGnctoAol3S4lz73KMJ5T2rHNNLViaLVGXA8++G0dlmQ73VIKCRDwNtk8R4FO8wrK
	Vh2xWRswGQZ96xYoBbA+SIcFPaKr5jHXEU9N7x/gWvk1doKkmSAz6QxUvJlYI7vSqCXIh1nlvne
	UVrneODGdociJiQuwLQ9SrKcE7XkwWDUK9H/v8QYY4F4BJlsJ5UPhekV7/42ierdRV1+Ekt6nOL
	Zsw+Lf63d09xSQvvEkoGLH30Hew3GJuaWn5AZluCS14FuIduTcwaQzZa5Qoihsh4UVl1f3FYuuO
	IwBvSBBQPvs3PbxUpWyoeWWPkMwrwlZ/rLwNfF4KfGmHgTn+jA4d
X-Google-Smtp-Source: AGHT+IGA75b9YcASk2D5n/bwRadF4WvuuJsbkaEyipV19iAdWDM29jLzv700q9BkuPpQqahnED6w1g==
X-Received: by 2002:a17:906:f58e:b0:ad8:a9fc:8127 with SMTP id a640c23a62f3a-ade1a9c7b43mr1688656666b.41.1749568703757;
        Tue, 10 Jun 2025 08:18:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc39c4asm750849566b.142.2025.06.10.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/7] netpoll: Untangle netconsole and netpoll
Date: Tue, 10 Jun 2025 08:18:12 -0700
Message-Id: <20250610-rework-v1-0-7cfde283f246@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRMSGgC/x3MQQqDMBAF0KsMf20gRmwlVyldSPJtByGWiVRBv
 LvgO8A7UGnKiigHjH+tuhREaRtB+o7lQ6cZURB86P3Dd864LTa71D77NOYhh0A0gp9x0v2OXih
 cXeG+4n2eFzQPg9NiAAAA
X-Change-ID: 20250603-rework-c175cad8d22e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=leitao@debian.org;
 h=from:subject:message-id; bh=VzoLQyE4wl6OHnhW3cdOsqTAdS7RUvOcmDCMwL7brDs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy9Oux/XDfzkJfTEyRM1B+R0ahEONt9ysa3T
 uGnDbFk5Q6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvQAKCRA1o5Of/Hh3
 bbBmEACYtS0IcqbN240pTfocSzNrfxewiIgC8hV4fthdTzdovD9c3WRT+CCJP72XhXv3r4vs0nB
 X2ZC4Ogh8kxVhCIYNf/kdpPXinlo0XeUOTRVEqKr14XxtpKuDBbF06QXGcaDU+fbcuZLoZVVcHz
 Z1GJz7DGilv8aqGsTtEGFI+wOou1NlUfnlmuWEYz1IyS2hPPDpMkYEiV7XgH07jjQaz+ByR+MhM
 eox3dMiI4yaI9D5l+lUwmATVlXrRXW8l3fLkC07WSCQcF44AKdLG9X7/7gIFilU2Xo2nQhMDwGe
 /doO4edBn0ri15oOc+mQVPQeZaOj2Nwn2TRpStMY9IiDjZlGYlUQ6AN+e/YTNqY5LaPmdwsG4Eb
 8x0rYA689xym6BBJsu7XC8n4KBC2KbHfn7WGFL3JdgfoCdqrRzz7SjWoBh2sYydwasBnV9FP2ET
 J6FhTFZbtWm7xLVnayd9O5BpTqsoZ2+VUBXySuvnRcsjg50/jSzJ1918RmcwxCpLg5TWxxTnCrm
 7s8xPJ21rxWpi+mMj3L3lvXOIBekdHbX019ZVcOr5aXnvcMxTHZPCQfak4nkTSAG2+0NYCJ4p45
 2XX0lnwHFTC0PwvRCylItePQ12JNhnQQSQ0rd320i1DuWK85Rwm0ky0yql/L+iCoVPD6SrSGN2y
 groae+YtVDwgQWQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Initially netpoll and netconsole were created together, and some
functions are in the wrong file. Seperate netconsole-only functions
in netconsole, avoiding exports.

1. Expose netpoll logging macros in the public header to enable consistent
   log formatting across netpoll consumers.

2. Relocate netconsole-specific functions from netpoll to the netconsole
   module where they are actually used, reducing unnecessary coupling.

3. Remove unnecessary function exports

4. Rename netpoll parsing functions in netconsole to better reflect their
   specific usage.

5. Create a test to check that cmdline works fine. This was in my todo
   list since [1], this was a good time to add it here to make sure this
   patchset doesn't regress.

PS: The code was split in a way that it is easy to review. When copying
the functions from netpoll to netconsole, I do not change than other
than adding `static`. This will make checkpatch unhappy, but, further
patches will address the issues. It is done this way to make it easy for
reviewers.

Link: https://lore.kernel.org/netdev/Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (7):
      netpoll: remove __netpoll_cleanup from exported API
      netpoll: expose netpoll logging macros in public header
      netpoll: relocate netconsole-specific functions to netconsole module
      netpoll: move netpoll_print_options to netconsole
      netconsole: rename functions to better reflect their purpose
      netconsole: improve code style in parser function
      selftest: netconsole: add test for cmdline configuration

 drivers/net/netconsole.c                           | 137 ++++++++++++++++++++-
 include/linux/netpoll.h                            |  10 +-
 net/core/netpoll.c                                 | 136 +-------------------
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  39 +++++-
 .../selftests/drivers/net/netcons_cmdline.sh       |  52 ++++++++
 6 files changed, 228 insertions(+), 147 deletions(-)
---
base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
change-id: 20250603-rework-c175cad8d22e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


