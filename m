Return-Path: <linux-kselftest+bounces-36287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97849AF1129
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4243AD2BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD124A07A;
	Wed,  2 Jul 2025 10:06:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278992376E0;
	Wed,  2 Jul 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450807; cv=none; b=iQPVW17NFUXUgCnDH7gxLxmrSvsqw5ohRjHP1/7dDTDfoeRZnPUyBbasajj8jEO1qdj3qEQ1zDIXh0p0epbxCcZsSIh4MJ2hZ0JjvFPZ4PW4OpGE/x1UT0MReEsb3Rf9m+cSM7RpVJjqJ/fR467U/Cm7+wDLqXa9LzGPf1BS1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450807; c=relaxed/simple;
	bh=gBXapBjhsGncsCHz7HHng97WylcbP7vOg7ZSWGnLGTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AX4jdspQc1wxBwSlxtfR2tOY7C3uKxofmgf/HXZXs9+py41Mpa6TraFiKDctv12aGHcf9Rd11L2KHTzkSuDdzyx/DYypc5HdMayfpMzMTcJzJ4+WvOLTCBB06085p7o/8Z6N0y/MEhH/WGshROQtCZeG+nC9/RIM1FdWryMIFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1176489266b.3;
        Wed, 02 Jul 2025 03:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450804; x=1752055604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QCuCBmF8QaYqs1/drTKdD/gVfMwicF+7VehnV1Bdt4=;
        b=O73DkOCeI1QMKwn1qWc+Ss5DOHvnR6BlaXCY52tNNN9/3tDIySaa0ZqYu+Bs8Uqmaz
         LwtGuHaWanNTc/SCk3p2GB4HlbPY/iWXPHdE+QIwN9vVbMDwLGcrjn8o84Cy+g3Rgf0P
         WamnV0L2FLV76C1eu8f9D/60Fx5MYaUbq04lfxzpYvCoU57KzPXk3NGXF8Nblgf2VQJD
         HoSgt2Or06KcvKstIHteYrzd3eVHkwEyOq4+dvU29d/FsYzTJLCS/9d5PcodAwWJ4/uw
         rGd+VdBTYF21+yy2WMX0KsIeKHytnOueLyhH7x1H3OlRqGubVX9Nf/3sV2eM8BLnIogq
         u7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCULjBJyae6QLV/0d5IdPVqc6LRi9gBNkgnO4etbON1jNozAFYlESV12pnClankXkDqwQiDK7GuxFyqgGv+7gPQm@vger.kernel.org, AJvYcCVqTkn4hSlQN26D0O9OwWC6kPauDCwGgXNgREzhG4RstN93MpORHDLew4L0F/3MwcduY5OBhkIjcWWSHrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnhOIKOEH7JJZVLQ1mLY4vrJPL/ZNFKC6rNGy3WsTSIKZm0SX
	F0tGpTZrvlAKi4nUPUaiOLG7xU+e7IyHPUq79+XiIOE4NP8eWFupbaUb
X-Gm-Gg: ASbGnctNntSR9nASnelhpQdhdXaCHX1oYB9XGjc7uenkBbfekSZ1NxKLA7m8uR+W2fn
	R+rEruI7tHh9I9Uhcd1HnCnqBEudsZwNnS0Ocn7qX/RSTGtvAsM8iW3F3AQWIdGQl7yHh0fkcid
	rLLKtOKHbnqmZHmx0qjH/miFKJWq8hRTAh/+JboB6BYcsVOwwRF+1+oWcaR3XYOp10uuvDO0oQI
	KtyPdaUywliiBKy3tY53ffnqc0N1cPqQU9g1ZCc3uJYOe1UBXcXwCXTuMVGhkq9Xy7ZEK7A4iPL
	ir2WEGSFauij97AuCJkhi+y9M6hfa8TRhNNW/GHV1FHBSCdJhNGl
X-Google-Smtp-Source: AGHT+IExqwyCDaBJV4RZ1jK7MygEWEjWI6DB7TG9XSz13u+qvUKnpwC7oX2pie9l0LwSlJH5bngU1g==
X-Received: by 2002:a17:907:86a2:b0:ade:bf32:b05a with SMTP id a640c23a62f3a-ae3c28ad072mr232725466b.0.1751450804088;
        Wed, 02 Jul 2025 03:06:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a732sm1060424966b.65.2025.07.02.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] netpoll: Factor out functions from
 netpoll_send_udp() and add ipv6 selftest
Date: Wed, 02 Jul 2025 03:06:32 -0700
Message-Id: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgEZWgC/23NQQqDMBBA0auEWZuSpDU2rnqPIpLqqAMykSQVi
 3j3gnTZ9Yf3d0gYCRPUYoeIKyUKDLUwhYBu8jyipB5qAUaZUlmjJGNewjy3b85+nLGlReK16ir
 nvHWmhELAEnGg7USfwJgl45ahKQRMlHKIn/O26rP/4OofvGqppNXeaOvMcL/5R48v8nwJcYTmO
 I4v1xj3ZL8AAAA=
X-Change-ID: 20250620-netpoll_untagle_ip-e37c799a6925
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=leitao@debian.org;
 h=from:subject:message-id; bh=gBXapBjhsGncsCHz7HHng97WylcbP7vOg7ZSWGnLGTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyseK8z8mbKZFES5J7zFgJr7Xt3FnWXHCOV
 Xw9i4oJMICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 beEfD/9pdL8uKcywWdJ9wi5DSie5fd+KC6VvWG0jN/9Fo2vM2G+Bm/2vLvUEOwudkk5waUwP6HN
 +udzC8KY1+rySQ3QknYc4vr6vT+sDgb+Q7g+r0Hmau3GoOyb4Y7J0rJa3PV4DnzeXiDxLbSL1QR
 h63OfBQFVOoXtkYCGnhkWGjBDlQLoJm+29ALJtJVDFTvdPtb3CBWwi7Fhk/jQMVB36Rgf2ZC+Ge
 /Fu1eg1pe6m9dRzdnk4E+4/r011FbryvhbCDN89tBA7fDLQhb2ouLSW4J0I6wB4Rcw1Rc+T6EvR
 Vvvd075E5mNpVxnTKBj7Qco8mxwXfL/pBgnbRLqNFSK+kigtNDK+2jLjJA4R1TGv//St9HwC5L9
 p0fi0NMWh5IqSNCKCtszXCz3OBxVzkZP2kuZCPrk3HHpfuzlu9YhOqwQ4OquDXH6u/k6u+xclIc
 3h9896h3+o3rk4tqxSRP4ViwGCDiio2OD7Fxu1iH6h3BkpazKNsevAZ1FEykWXrnMvgXba3cw/f
 kmIvFskq3ae1pRcMzFpRU7NwA5Da4IS2on9dWTn+ORaNWH/budSpUXC0aVwbE8VsZbkXEpksUje
 CSYDQF9u+AvMuKfWpfLsJp2F68vOGOe3N0XyMEYO28nSocpuN8J4X57YMIdCB0ZnxPUCaFLLD8a
 3cVof6Ntc3uIQug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Refactors the netpoll UDP transmit path to improve code clarity,
maintainability, and protocol-layer encapsulation.

Function netpoll_send_udp() has more than 100 LoC, which is hard to
understand and review. After this patchset, it has only 32 LoC, which is
more manageable.

The series systematically moves the construction of protocol headers
(UDP, IPv4, IPv6, Ethernet) out of the core `netpoll_send_udp()`
function into dedicated static helpers:

  - `push_udp()` for UDP header setup
  - `push_ipv4()` and `push_ipv6()` for IP header setup
  - `push_eth()` for Ethernet header setup

This results in a clean, layered abstraction that mirrors the protocol
stack, reduces code duplication, and improves readability.

Also, to make sure this is not breaking anything, add IPv6 selftest to
netconsole tests, which will exercise this code. This test would also pick
problems similiar to the one fixed by f599020702698  ("net: netpoll:
Initialize UDP checksum field before checksumming"), which was
embarrassin we didn't have a selftest catch it.

Anyway, there are **no functional changes** intended in this patchset.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Move ethernet data from push_ipv{4,6} into push_eth() function, making
  the slice up even more clearer (Jakub).
- Fixed some long lines to get checkpatch happier.
- Link to v1: https://lore.kernel.org/r/20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org

---
Breno Leitao (7):
      netpoll: Improve code clarity with explicit struct size calculations
      netpoll: factor out UDP checksum calculation into helper
      netpoll: factor out IPv6 header setup into push_ipv6() helper
      netpoll: factor out IPv4 header setup into push_ipv4() helper
      netpoll: factor out UDP header setup into push_udp() helper
      netpoll: move Ethernet setup to push_eth() helper
      selftests: net: Add IPv6 support to netconsole basic tests

 net/core/netpoll.c                                 | 192 +++++++++++++--------
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  76 +++++++-
 .../testing/selftests/drivers/net/netcons_basic.sh |  53 +++---
 3 files changed, 215 insertions(+), 106 deletions(-)
---
base-commit: 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0
change-id: 20250620-netpoll_untagle_ip-e37c799a6925

Best regards,
--  
Breno Leitao <leitao@debian.org>


