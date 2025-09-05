Return-Path: <linux-kselftest+bounces-40857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE6CB4600A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62ACA47251
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF430B534;
	Fri,  5 Sep 2025 17:25:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE43191C2;
	Fri,  5 Sep 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093128; cv=none; b=OQxRQYjHG37qZw8ELWhG3Mc2Yc9tCco5gdt500fyx9RD5IvZtw4OYHghCpuQVDObQFGlr/qB/Rru/backhFykYdDLccUHMxIxq05ryhp92BEXN5+cNkHCcoSOyUDAoAYf7Z1w99RxXlK223vifLj7kCphjH8YmI5LjbY2yNkRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093128; c=relaxed/simple;
	bh=Qy6YvJoeTji61t1mZRxRlusN42LF2rqUAfct8w5o8JI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wyn+sbEf4iEArscAjlxLDCAtHabUADoRcScQevApcXIiuLy4Pt0qP6o+m1WeHBSdHK3kRziKL9mAXx68pME6hsZE009Bb1L3Jd+dTxAWAyNZNtb1CauSnJifVoOHMTKPivzBojwlmySQ99fc9+x+rLyojH8V2SV+aM2Yg0zIU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b046fc9f359so445654066b.0;
        Fri, 05 Sep 2025 10:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093125; x=1757697925;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHDYLsHpohNsUyyCoi3m6vc8R+M4yrYz3cLb+AlY1+g=;
        b=WX8Yz6EY3UuXX0DfLTi1AQTcVLLR5aXHmPiM/oZ/AB2UOT7sVwpROEtA7vUJdo4XhI
         Gy5eU1mevXkjNSSmqShpt5yWzrJo2qyAaCNoLhDQihmAhbE5QxS75eUcau/PZXOvQRO/
         2lSe/nwFJGbxV6apmLy8SJqsc8tXJ+ojXLenAUmq11dwQ/7UDyqoAI6JbTosI/yXAu7w
         olFghr6CI/ZVt2tkVZP1HaeKolNThDeT9KJ9NQJ4N2rZK+LARrgVHb/SmmeiX5+rjVFT
         YZt1WwLun4EXCf7Pzh7dhhFrHQX6PziQpGFvbD86JOHU/7/3Vw5GF6ZpldPKwZ84vRkQ
         TWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+9IGjy2Ar65liBpyhQwsm4bGUz+jFo8vEb8B8Uwp0IHnXpPUbRkV8NJv2aaYo/YEo34tWTwTM@vger.kernel.org, AJvYcCVyG5Q4/3jdWaaDQh7tW9rtDEWPBHnnkoXUZ3juKedrFdzpOtPCS3QFyLGFoG375IDrZzwzk0z+EHnW9Q/uJYg=@vger.kernel.org, AJvYcCWTua/3HWaP4nrGMLgT9/9hYi2SrwAboljBl+sPiKJ8tQ7gy7hBsSh2h7qwp79tni8qWNzOm8as@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cPhOpTEgCfu1Dra/YtQFfmVtbScKd2AAOPeF+WYELAh6kNx9
	TmYQN7s/vbhZBq1t5wu9vjxQRkVy4RyLKzX7qdHvti6cDf3Z7/RanhDZ93VWyw==
X-Gm-Gg: ASbGncthh4AhjRhKKgaMQ+PRhQ9H4KRNptn7MHYLcWSmoYibkBVFLWQc52+r0A+rKP8
	Hh/K2Szvw6R9Sx3hiWz8naU0sWr9+6j3T3Q+aOQRRDh2b6tmKo56aI/HylBtWyb6X48OygYC7Ue
	5doEB4Nkv4fO7xBWerH9edYNkgRrGSH4QpY06FlGf/ZQPwYzInw5o7MOkzkV3RMrQeYSegoZX8R
	zZAh/HMSQzK1Lfc2tcu/tZdelWxO0p8nYOXOzP+E1Lngpek8jbVKAaR3e43njDpQL/5noBQHgUb
	ipsYWt5C7bgzUJ00NHdjK8O8ds/yPE8WPc1eamr8Lq8cQiGEm/VsF6QZdfK85OsK1PH6DZuNrut
	/wfKGTd3g5Lpx3m2KVTnosj4=
X-Google-Smtp-Source: AGHT+IGEGyqyx4VJabm4Vhed5iJmFLI6l0ORIangqVpHuf1vsooKlo5pRRFXuT9M8Vc863VgXbCU/g==
X-Received: by 2002:a17:907:9283:b0:afe:8761:e76a with SMTP id a640c23a62f3a-b01d971a17dmr2377128466b.39.1757093124506;
        Fri, 05 Sep 2025 10:25:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04110b94cbsm1495583166b.93.2025.09.05.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:25:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v3 0/3] net: netpoll: fix a memleak and create a
 selftest
Date: Fri, 05 Sep 2025 10:25:06 -0700
Message-Id: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMcu2gC/33N0QrCIBSA4VeRcz3DabrcVe8REaZnmxAaalKMv
 XvgVUF0/cP3r5AxecwwkhUSVp99DDAS0RGwiwkzUu9gJMAZl0wzTgMWG0OON7yUmMojIT1Mlou
 JGWu0ho7APeHknw09QcAC547A4nOJ6dVGtW/pn1l72lMmrGJKSX1AfXR49SbsYpqbV/mnsf9pc
 MqoHAaJTjorlPoytm17A/Tf6rz+AAAA
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org, jv@jvosburgh.net
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=leitao@debian.org;
 h=from:subject:message-id; bh=Qy6YvJoeTji61t1mZRxRlusN42LF2rqUAfct8w5o8JI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoux0Bu+8t4g1U+nbsovlVTHHByY+Ut0opVFiP5
 QsEmLp0D1CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsdAQAKCRA1o5Of/Hh3
 bZkrD/47iuzPAjxTw9rChVtNP5hRjUY14UjFbBYWXSLBBwZ7Yk07Jt9Tf43XUi4REVAtE2y667f
 /MlfZWXuVNVt4FHOzEebxmyEmgHbENV0/zxKXnb1rE8nEwFAd+dHj2UelXsk/QcZGqjqUYv6DYF
 TcdZWWJdtfbi60NVNn6WchLAqoCAIl8F3pHrnoMmKD8trzisEZAfXdNDTAYj5H+KLYkzE3NRIWv
 1xXTg4C/0mcpNXXnGi246xrQ6lCQ5ym5h9b4gddjzqa9SrgBntxWSCrJOvGKG3Jb473JQ+8FwuJ
 qD3L7gKsuQpKgLVODi0NggwIHbFF6fm6snqucmJ5BX+kSuY0XucVzZbEkcgKiTC0TlomV2DSxWL
 5FR22ydDT3As9JLUiEnLfRFfvnzz1GGZSAzJr+iUfl8OoTvRGF4CTeSKfzo9RgdB5xpSSuPao2+
 7kEvCLSLREIKHbOxsZyMbrTxgr5godm4KQnbza68z0uG2NdclIHn4k2iAaiX+x26I4vxQzW8HBI
 wMWy6GVdGFllJsaYj15RwlBMGH/4650NY0vt0TjipzTL7fRDonyoR4fLZvAX1Fph1xdfu3+A7dd
 imRLI+tkjfoLFbdia0gvgmEIFqRNWSZUxaa4elULHewTzuwsXv+ONbz4xF6x0eIlj0uk7iC6WlQ
 l/byiO0ix/yyWiA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak issue on netpoll and create a netconsole test that exposes
the problem, when run with kmemleak enabled.

This is a merge of two patches I've sent individually and are merged on
the same patchset[1][2].

Link: https://lore.kernel.org/all/20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org/ [1]
Link: https://lore.kernel.org/all/20250902165426.6d6cd172@kernel.org/ [2]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- this patchset is a merge of the fix and the selftest together as
recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (3):
      netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test

 net/core/netpoll.c                                 |   7 +-
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  30 +++--
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++++++++++
 4 files changed, 152 insertions(+), 13 deletions(-)
---
base-commit: d69eb204c255c35abd9e8cb621484e8074c75eaa
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


